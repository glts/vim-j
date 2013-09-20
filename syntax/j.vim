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

syn region jString oneline start=/'/ skip=/''/ end=/'/

" Patterns for numbers in general, rational numbers, numbers with explicit
" base, infinities, and numbers with extended precision.
"
" Matching J numbers is difficult. The regular expression used for the general
" case roughly embodies this grammar sketch:
"
"         EXP     := /_?\d+(\.\d*)?([eE]_?\d+)?/
"         COMP    := EXP  |  EXP (j|a[dr]) EXP
"         PIEU    := COMP  |  COMP [px] COMP
"
" For the rest, a compromise between correctness and practicality was made.
" See http://www.jsoftware.com/help/dictionary/dcons.htm for reference.
syn match jNumber /\<_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\%(\%(j\|a[dr]\)_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\)\=\%([px]_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\%(\%(j\|a[dr]\)_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\)\=\)\=/
syn match jNumber /\<_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=r_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=/
syn match jNumber /\<_\=\d\+\%([eE]\d\+\)\=b_\=[0-9a-z]\+/
syn match jNumber /\<__\=\>/
syn match jNumber /\<_\=\d\+x\>/

syn match jComment /NB\..*$/

hi def link jControl Statement
hi def link jString String
hi def link jNumber Number
hi def link jComment Comment

let b:current_syntax = 'j'
