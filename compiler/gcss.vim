" Vim compiler file
" Compiler:	GCSS
" Maintainer:	Keiji Yoshida <yoshida.keiji.84@gmail.com>
" Last Change:	2014 September 16

if exists("current_compiler")
  finish
endif
let current_compiler = "gcss"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=gcss

CompilerSet errorformat=
      \%f:%l:%m\ (GCSS::Syntax%trror),
      \%ESyntax\ %trror:%m,
      \%C%\\s%\\+on\ line\ %l\ of\ %f,
      \%Z%.%#,
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2:
