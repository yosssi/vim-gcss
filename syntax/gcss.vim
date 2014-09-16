" Vim syntax file
" Language:	GCSS
" Maintainer:	Keiji Yoshida <yoshida.keiji.84@gmail.com>
" Filenames:	*.gcss
" Last Change:	2014 September 16

if exists("b:current_syntax")
  finish
endif

runtime! syntax/css.vim

syn case ignore

syn cluster gcssCssProperties contains=cssFontProp,cssFontDescriptorProp,cssColorProp,cssTextProp,cssBoxProp,cssGeneratedContentProp,cssPagingProp,cssUIProp,cssRenderProp,cssAuralProp,cssTableProp
syn cluster gcssCssAttributes contains=css.*Attr,gcssEndOfLineComment,scssComment,cssValue.*,cssColor,cssURL,gcssDefault,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssRenderProp

syn region gcssDefinition matchgroup=cssBraces start="{" end="}" contains=TOP

syn match gcssProperty "\%([{};]\s*\|^\)\@<=\%([[:alnum:]-]\|#{[^{}]*}\)\+\s*:" contains=css.*Prop skipwhite nextgroup=gcssCssAttribute contained containedin=gcssDefinition
syn match gcssProperty "^\s*\zs\s\%(\%([[:alnum:]-]\|#{[^{}]*}\)\+\s*:\|:[[:alnum:]-]\+\)"hs=s+1 contains=css.*Prop skipwhite nextgroup=gcssCssAttribute
syn match gcssProperty "^\s*\zs\s\%(:\=[[:alnum:]-]\+\s*=\)"hs=s+1 contains=css.*Prop skipwhite nextgroup=gcssCssAttribute
syn match gcssCssAttribute +\%("\%([^"]\|\\"\)*"\|'\%([^']\|\\'\)*'\|#{[^{}]*}\|[^{};]\)*+ contained contains=@gcssCssAttributes,gcssVariable,gcssFunction,gcssInterpolation
syn match gcssDefault "!default\>" contained
syn match gcssVariable "!\%(important\>\|default\>\)\@![[:alnum:]_-]\+"
syn match gcssVariable "$[[:alnum:]_-]\+"
syn match gcssVariableAssignment "\%([!$][[:alnum:]_-]\+\s*\)\@<=\%(||\)\==" nextgroup=gcssCssAttribute skipwhite
syn match gcssVariableAssignment "\%([!$][[:alnum:]_-]\+\s*\)\@<=:" nextgroup=gcssCssAttribute skipwhite

syn match gcssFunction "\<\%(rgb\|rgba\|red\|green\|blue\|mix\)\>(\@=" contained
syn match gcssFunction "\<\%(hsl\|hsla\|hue\|saturation\|lightness\|adjust-hue\|lighten\|darken\|saturate\|desaturate\|grayscale\|complement\)\>(\@=" contained
syn match gcssFunction "\<\%(alpha\|opacity\|rgba\|opacify\|fade-in\|transparentize\|fade-out\)\>(\@=" contained
syn match gcssFunction "\<\%(unquote\|quote\)\>(\@=" contained
syn match gcssFunction "\<\%(percentage\|round\|ceil\|floor\|abs\)\>(\@=" contained
syn match gcssFunction "\<\%(type-of\|unit\|unitless\|comparable\)\>(\@=" contained

syn region gcssInterpolation matchgroup=gcssInterpolationDelimiter start="#{" end="}" contains=@gcssCssAttributes,gcssVariable,gcssFunction containedin=cssStringQ,cssStringQQ,cssPseudoClass,gcssProperty

syn match gcssMixinName "[[:alnum:]_-]\+" contained nextgroup=gcssCssAttribute
syn match gcssMixin  "^="               nextgroup=gcssMixinName skipwhite
syn match gcssMixin  "\%([{};]\s*\|^\s*\)\@<=@mixin"   nextgroup=gcssMixinName skipwhite
syn match gcssMixing "^\s\+\zs+"        nextgroup=gcssMixinName
syn match gcssMixing "\%([{};]\s*\|^\s*\)\@<=@include" nextgroup=gcssMixinName skipwhite
syn match gcssExtend "\%([{};]\s*\|^\s*\)\@<=@extend"
syn match gcssPlaceholder "\%([{};]\s*\|^\s*\)\@<=%"   nextgroup=gcssMixinName skipwhite

syn match gcssFunctionName "[[:alnum:]_-]\+" contained nextgroup=gcssCssAttribute
syn match gcssFunctionDecl "\%([{};]\s*\|^\s*\)\@<=@function"   nextgroup=gcssFunctionName skipwhite
syn match gcssReturn "\%([{};]\s*\|^\s*\)\@<=@return"

syn match gcssEscape     "^\s*\zs\\"
syn match gcssIdChar     "#[[:alnum:]_-]\@=" nextgroup=gcssId
syn match gcssId         "[[:alnum:]_-]\+" contained
syn match gcssClassChar  "\.[[:alnum:]_-]\@=" nextgroup=gcssClass
syn match gcssClass      "[[:alnum:]_-]\+" contained
syn match gcssAmpersand  "&"

" TODO: Attribute namespaces
" TODO: Arithmetic (including strings and concatenation)

syn region gcssMediaQuery matchgroup=gcssMedia start="@media" end="[{};]\@=\|$" contains=gcssMediaOperators
syn keyword gcssMediaOperators and not only contained
syn region gcssCharset start="@charset" end=";\|$" contains=scssComment,cssStringQ,cssStringQQ,cssURL,cssUnicodeEscape,cssMediaType
syn region gcssInclude start="@import" end=";\|$" contains=scssComment,cssStringQ,cssStringQQ,cssURL,cssUnicodeEscape,cssMediaType
syn region gcssDebugLine end=";\|$" matchgroup=gcssDebug start="@debug\>" contains=@gcssCssAttributes,gcssVariable,gcssFunction
syn region gcssWarnLine end=";\|$" matchgroup=gcssWarn start="@warn\>" contains=@gcssCssAttributes,gcssVariable,gcssFunction
syn region gcssControlLine matchgroup=gcssControl start="@\%(if\|else\%(\s\+if\)\=\|while\|for\|each\)\>" end="[{};]\@=\|$" contains=gcssFor,@gcssCssAttributes,gcssVariable,gcssFunction
syn keyword gcssFor from to through in contained

syn keyword gcssTodo        FIXME NOTE TODO OPTIMIZE XXX contained
syn region  gcssComment     start="^\z(\s*\)//"  end="^\%(\z1 \)\@!" contains=gcssTodo,@Spell
syn region  gcssCssComment  start="^\z(\s*\)/\*" end="^\%(\z1 \)\@!" contains=gcssTodo,@Spell
syn match   gcssEndOfLineComment "//.*" contains=gcssComment,gcssTodo,@Spell

hi def link gcssEndOfLineComment        gcssComment
hi def link gcssCssComment              gcssComment
hi def link gcssComment                 Comment
hi def link gcssDefault                 cssImportant
hi def link gcssVariable                Identifier
hi def link gcssFunction                Function
hi def link gcssMixing                  PreProc
hi def link gcssMixin                   PreProc
hi def link gcssPlaceholder             PreProc
hi def link gcssExtend                  PreProc
hi def link gcssFunctionDecl            PreProc
hi def link gcssReturn                  PreProc
hi def link gcssTodo                    Todo
hi def link gcssCharset                 PreProc
hi def link gcssMedia                   PreProc
hi def link gcssMediaOperators          PreProc
hi def link gcssInclude                 Include
hi def link gcssDebug                   gcssControl
hi def link gcssWarn                    gcssControl
hi def link gcssControl                 PreProc
hi def link gcssFor                     PreProc
hi def link gcssEscape                  Special
hi def link gcssIdChar                  Special
hi def link gcssClassChar               Special
hi def link gcssInterpolationDelimiter  Delimiter
hi def link gcssAmpersand               Character
hi def link gcssId                      Identifier
hi def link gcssClass                   Type

let b:current_syntax = "gcss"

" vim:set sw=2:
