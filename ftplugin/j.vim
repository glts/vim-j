" Vim filetype plugin for J

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal iskeyword=48-57,65-90,_,97-122
setlocal comments=:NB.
setlocal commentstring=NB.\ %s
setlocal shiftwidth=2 softtabstop=2 expandtab

" maybe undo backwards? "setl et< sts< sw< cms< ..."
let b:undo_ftplugin = "setl isk< com< cms< sw< sts< et<"
