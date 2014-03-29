" Vim filetype plugin
" Language:	J
" Maintainer:	David Bürgin <676c7473@gmail.com>
" URL:		https://github.com/glts/vim-j
" Last Change:	2014-03-17

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal iskeyword=48-57,65-90,_,97-122
setlocal comments=:NB.
setlocal commentstring=NB.\ %s
setlocal formatoptions-=t
setlocal shiftwidth=2 softtabstop=2 expandtab
setlocal matchpairs=(:)

" Section movement with ]] ][ [[ []. The start/end patterns below are amended
" inside the function in order to avoid matching on the current cursor line.
let s:sectionstart = '.\{-}\<\%([0-4]\|13\|noun\|adverb\|conjunction\|verb\|monad\|dyad\)\s\+\%(:\s*0\|def\s\+0\|define\)\>.*'
let s:sectionend = '\s*)\s*'

function! s:SearchSection(end, backwards, visualmode) abort
  if a:visualmode !=# ''
    normal! gv
  endif
  let flags = a:backwards ? 'bsW' : 'sW'
  if a:end
    call search('^' . s:sectionend . (a:backwards ? '\n\_.\{-}\%#' : '$'), flags)
  else
    call search('^' . s:sectionstart . (a:backwards ? '\n\_.\{-}\%#' : '$'), flags)
  endif
endfunction

noremap <script> <buffer> <silent> ]] :<C-U>call <SID>SearchSection(0, 0, '')<CR>
xnoremap <script> <buffer> <silent> ]] :<C-U>call <SID>SearchSection(0, 0, visualmode())<CR>
sunmap <buffer> ]]
noremap <script> <buffer> <silent> ][ :<C-U>call <SID>SearchSection(1, 0, '')<CR>
xnoremap <script> <buffer> <silent> ][ :<C-U>call <SID>SearchSection(1, 0, visualmode())<CR>
sunmap <buffer> ][
noremap <script> <buffer> <silent> [[ :<C-U>call <SID>SearchSection(0, 1, '')<CR>
xnoremap <script> <buffer> <silent> [[ :<C-U>call <SID>SearchSection(0, 1, visualmode())<CR>
sunmap <buffer> [[
noremap <script> <buffer> <silent> [] :<C-U>call <SID>SearchSection(1, 1, '')<CR>
xnoremap <script> <buffer> <silent> [] :<C-U>call <SID>SearchSection(1, 1, visualmode())<CR>
sunmap <buffer> []

let b:undo_ftplugin = 'setlocal matchpairs< expandtab< softtabstop< shiftwidth< formatoptions< commentstring< comments< iskeyword<'
let b:undo_ftplugin .= '| silent! execute "unmap <buffer> ]]"'
let b:undo_ftplugin .= '| silent! execute "unmap <buffer> ]["'
let b:undo_ftplugin .= '| silent! execute "unmap <buffer> [["'
let b:undo_ftplugin .= '| silent! execute "unmap <buffer> []"'
