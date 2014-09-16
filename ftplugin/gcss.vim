" Vim filetype plugin
" Language:	GCSS
" Maintainer:	Keiji Yoshida <yoshida.keiji.84@gmail.com>
" Last Change:	2014 September 16

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl com< cms< def< inc< inex< ofu< sua<"

setlocal comments=://
setlocal commentstring=//\ %s
setlocal define=^\\s*\\%(@mixin\\\|=\\)
setlocal includeexpr=substitute(v:fname,'\\%(.*/\\\|^\\)\\zs','_','')
setlocal omnifunc=csscomplete#CompleteCSS
setlocal suffixesadd=.gcss,.css

let &l:include = '^\s*@import\s\+\%(url(\)\=["'']\='

" vim:set sw=2:
