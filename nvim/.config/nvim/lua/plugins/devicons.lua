-- ===============================
-- nvim-web-devicons 設定
-- ===============================

require("nvim-web-devicons").setup({
	-- デフォルトアイコンを有効化して、拡張子未対応でも何かしら表示する
	default = true,
	-- 既存の highlight 設定があればそれを維持
	color_icons = true,
	strict = true,
})
