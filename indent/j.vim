if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetJIndent()
setlocal indentkeys-=0{,0},\:,0#
" TODO more indentkeys
setlocal indentkeys+=0),=end.,=else.

let b:undo_indent = "setl indentkeys< indentexpr<"

if exists("*GetJIndent")
  finish
endif

function! GetJIndent()
  let prevlnum = prevnonblank(v:lnum-1)
  if prevlnum == 0
    return 0
  endif

  let indent = indent(prevlnum)
  if getline(prevlnum) =~# '^\s*\%(if\)\.'
    if getline(prevlnum) !~# '\<end\.'
      let indent += &shiftwidth
    endif
  endif
  if getline(prevlnum) =~# '^\s*\%(else\)\.'
    let indent += &shiftwidth
  endif
  if getline(v:lnum) =~# '^\s*\%(else\|end\)\.'
    let indent -= &shiftwidth
  endif
  return indent
endfunction
