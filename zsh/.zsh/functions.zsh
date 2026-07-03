############################################################
# 関数
############################################################
bsub() {
  command bsub -Is -q re8bat_full "$@"
}
bsubn() {}
  command bsub "$@"
}
bsub_int() {
  command bsub -Is -q re8int_full "$@"
}
verisium() {
  bsub_int verisium -debug -memlimit 16G -db "$1"
}
vscode() {
  bsub_int code --no-sandbox .
}
