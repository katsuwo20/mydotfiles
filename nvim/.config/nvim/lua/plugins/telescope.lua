-- Telescope本体の読み込み
local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local telescope_config = require('telescope.config').values

local all_files_vimgrep_arguments = vim.deepcopy(telescope_config.vimgrep_arguments)
table.insert(all_files_vimgrep_arguments, '--hidden')
table.insert(all_files_vimgrep_arguments, '--no-ignore')
table.insert(all_files_vimgrep_arguments, '--no-ignore-parent')

local function live_grep_with_extension(ext, default_text)
  local opts = {
    default_text = default_text,
    file_ignore_patterns = {},
    additional_args = function()
      local args = { '--hidden', '--no-ignore', '--no-ignore-parent' }

      if ext ~= nil and ext ~= '' then
        table.insert(args, '--glob')
        table.insert(args, '*.' .. ext)
      end

      return args
    end,
  }

  if ext ~= nil and ext ~= '' then
    opts.prompt_title = 'Live Grep (*.' .. ext .. ')'
  end

  opts.attach_mappings = function(prompt_bufnr, map)
    local function set_extension_filter()
      local current_query = action_state.get_current_line()
      local input = vim.fn.input('Extension (e.g. lua, ts): ')

      if input == nil or input == '' then
        return
      end

      local normalized = input:gsub('^%*?%.?', '')
      if normalized == '' then
        return
      end

      actions.close(prompt_bufnr)
      live_grep_with_extension(normalized, current_query)
    end

    map({ 'i', 'n' }, '<C-g>', set_extension_filter)
    return true
  end

  builtin.live_grep(opts)
end

-- 基本設定
telescope.setup{
  defaults = {
    vimgrep_arguments = all_files_vimgrep_arguments,
    mappings = {
      i = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-h>'] = actions.preview_scrolling_left,
        ['<C-l>'] = actions.preview_scrolling_right,
      },
      n = {
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-h>'] = actions.preview_scrolling_left,
        ['<C-l>'] = actions.preview_scrolling_right,
      },
    },
    layout_config = {
        width = 0.8,   -- 画面幅の80%を使用
        height = 0.9,  -- 画面高さの90%を使用
    },
    file_ignore_patterns = {},
  },
  pickers = {
    find_files = {
      hidden = true,  -- dotfileも検索
      no_ignore = true,
      no_ignore_parent = true,
      follow = true,
    },
  },
-- fzf-telescopeを追加
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }

}

telescope.load_extension('fzf')

-- キーマップ
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', function()
  live_grep_with_extension(nil, nil)
end, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
