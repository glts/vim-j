" Vim syntax file
" Language:	J
" Maintainer:	David Bürgin <676c7473@gmail.com>
" URL:		https://github.com/glts/vim-j
" Last Change:	2013-10-06

if exists('b:current_syntax')
  finish
endif

syntax case match
syntax sync minlines=50

syntax match jControl /\<\%(assert\|break\|case\|catch[dt]\=\|continue\|do\|else\%(if\)\=\|end\|fcase\|for\|if\|return\|select\|throw\|try\|whil\%(e\|st\)\)\./
syntax match jControl /\<\%(for\|goto\|label\)_\a\k*\./

syntax region jString oneline start=/'/ skip=/''/ end=/'/

" Number patterns. Matching J numbers is difficult. The regular expression
" used for the general case roughly embodies this grammar sketch:
"
"     BASE     := /_?\d+(\.\d*)?([eE]_?\d+)?/
"     RATIONAL := BASE  |  BASE r BASE
"     COMPLEX  := BASE  |  BASE (j|a[dr]) BASE
"     JNUMBER  := RATIONAL  |  RATIONAL [px] RATIONAL  |  COMPLEX  |  COMPLEX [px] COMPLEX
"
" The grammar is implemented as shown in this pseudo-regexp:
"
"        base         rational                       complex                       remainder
"     /\< B  (  [r]B ([px]B([r]B)?)?  |  (j|a[dr])B ([px]B((j|a[dr])B)?)?  |  [px]B ((j|a[dr]|r)B)?  )?/
"
" All in all, a compromise between correctness and practicality had to be
" made. See http://www.jsoftware.com/help/dictionary/dcons.htm for reference.
syntax match jNumber /\<_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\%(\%(r_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\%([px]_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\%(r_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\)\=\)\=\)\|\%(\%(j\|a[dr]\)_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\%([px]_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\%(\%(j\|a[dr]\)_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\)\=\)\=\)\|\%([px]_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\%(\%(j\|a[dr]\|r\)_\=\d\+\%(\.\d*\)\=\%([eE]_\=\d\+\)\=\)\=\)\)\=/
syntax match jNumber /\<_\=\d\+\%([eE]\d\+\)\=b_\=[0-9a-z]\+/
syntax match jNumber /\<__\=\>/
syntax match jNumber /\<_\=\d\+x\>/

syntax match jComment /NB\..*$/ contains=jTodo,@Spell
syntax keyword jTodo TODO FIXME XXX contained

highlight default link jControl Statement
highlight default link jString String
highlight default link jNumber Number
highlight default link jComment Comment
highlight default link jTodo Todo

let b:current_syntax = 'j'
