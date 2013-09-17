if exists('b:current_syntax')
  finish
endif

" For the time being ...
silent! set re=1

syntax case match
syntax sync fromstart

syn match jControl /\<\%(assert\|break\|case\|catch\|catchd\|catcht\|continue\|do\|else\|elseif\|end\|fcase\|for\|if\|return\|select\|throw\|try\|while\|whilst\)\./
" TODO work in progress
syn match jControl /\<for_\k\+\./
syn match jControl /\<\%(goto\|label\)_\k\+\./

syn region jString  oneline start=/'/ skip=/''/ end=/'/
syn match  jNumber  /\<_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=/
" numbers are much more complicated, see http://www.jsoftware.com/help/dictionary/dcons.htm
" also think of 4!:77, these are not numbers
syn match  jNumber  /\<__\=\>/
syn match  jNumber  /\<_\=\d\+x\>/
" syn match  jOperator /[-=<>_+*%{][.:]\=/
syn match  jComment /NB\..*$/

syn region jFunction start=/.*\d\s\+:\s*\d\s*/ matchgroup=jEnd end=/^\s*)\s*$/

hi def link jString String
hi def link jNumber Number
hi def link jControl Statement
hi def link jOperator Identifier
hi def link jComment Comment
hi def link jFunction Function
hi def link jEnd Function

let b:current_syntax = 'j'
