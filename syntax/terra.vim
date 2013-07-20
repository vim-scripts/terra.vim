" Vim syntax file
" Language:	Terra; based on lua.vim (2012 Feb 07), bundled with vim 7.3.
" Maintainer:	Amelia Cuss <amelia 'at' kivikakk ee>
" First Author:	Carlos Augusto Teixeira Mendes <cmendes 'at' inf puc-rio br>
" Last Change:	2013 Jul 20

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case match

" syncing method
syn sync minlines=100

" Comments
syn keyword terraTodo            contained TODO FIXME XXX
syn match   terraComment         "--.*$" contains=terraTodo,@Spell
" Comments in Lua 5.1: --[[ ... ]], [=[ ... ]=], [===[ ... ]===], etc.
syn region terraComment        matchgroup=terraComment start="--\[\z(=*\)\[" end="\]\z1\]" contains=terraTodo,@Spell

" First line may start with #!
syn match terraComment "\%^#!.*"

" catch errors caused by wrong parenthesis and wrong curly brackets or
" keywords placed outside their respective blocks

syn region terraParen transparent start='(' end=')' contains=TOP,terraParenError
syn match  terraParenError ")"
syn match  terraError "}"
syn match  terraError "\<\%(end\|else\|elseif\|then\|until\|in\)\>"

" Function declaration
syn region terraFunctionBlock transparent matchgroup=terraFunction start="\<function\>" end="\<end\>" contains=TOP
syn region terraTerraFunctionBlock transparent matchgroup=terraTerraFunction start="\<terra\>" end="\<end\>" contains=TOP

" quote
syn region terraQuoteBlock transparent matchgroup=terraQuote start="\<quote\>" end="\<end\>" contains=TOP

" else
syn keyword terraCondElse matchgroup=terraCond contained containedin=terraCondEnd else

" then ... end
syn region terraCondEnd contained transparent matchgroup=terraCond start="\<then\>" end="\<end\>" contains=TOP

" elseif ... then
syn region terraCondElseif contained containedin=terraCondEnd transparent matchgroup=terraCond start="\<elseif\>" end="\<then\>" contains=TOP

" if ... then
syn region terraCondStart transparent matchgroup=terraCond start="\<if\>" end="\<then\>"me=e-4 contains=TOP nextgroup=terraCondEnd skipwhite skipempty

" do ... end
syn region terraBlock transparent matchgroup=terraStatement start="\<do\>" end="\<end\>" contains=TOP
" repeat ... until
syn region terraRepeatBlock transparent matchgroup=terraRepeat start="\<repeat\>" end="\<until\>" contains=TOP

" while ... do
syn region terraWhile transparent matchgroup=terraRepeat start="\<while\>" end="\<do\>"me=e-2 contains=TOP nextgroup=terraBlock skipwhite skipempty

" for ... do and for ... in ... do
syn region terraFor transparent matchgroup=terraRepeat start="\<for\>" end="\<do\>"me=e-2 contains=TOP nextgroup=terraBlock skipwhite skipempty

syn keyword terraFor contained containedin=terraFor in

" other keywords
syn keyword terraStatement return local break
syn keyword terraStatement goto
syn match terraLabel "::\I\i*::"
syn keyword terraOperator and or not
syn keyword terraConstant nil
syn keyword terraConstant true false

" (more) Terra keywords
syn keyword terraStruct struct union
syn keyword terraVariable var
syn keyword terraType rawstring niltype double float bool int uint int64 uint64 int32 uint32 int16 uint16 int8 uint8

" Strings
syn match  terraSpecial contained #\\[\\abfnrtvz'"]\|\\x[[:xdigit:]]\{2}\|\\[[:digit:]]\{,3}#
syn region terraString2 matchgroup=terraString start="\[\z(=*\)\[" end="\]\z1\]" contains=@Spell
syn region terraString  start=+'+ end=+'+ skip=+\\\\\|\\'+ contains=terraSpecial,@Spell
syn region terraString  start=+"+ end=+"+ skip=+\\\\\|\\"+ contains=terraSpecial,@Spell

" integer number
syn match terraNumber "\<\d\+\>"
" floating point number, with dot, optional exponent
syn match terraNumber  "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
" floating point number, starting with a dot, optional exponent
syn match terraNumber  "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
syn match terraNumber  "\<\d\+[eE][-+]\=\d\+\>"

" hex numbers
syn match terraNumber "\<0[xX][[:xdigit:].]\+\%([pP][-+]\=\d\+\)\=\>"

" tables
syn region terraTableBlock transparent matchgroup=terraTable start="{" end="}" contains=TOP,terraStatement

syn keyword terraFunc assert collectgarbage dofile error next
syn keyword terraFunc print rawget rawset tonumber tostring type _VERSION

syn keyword terraFunc getmetatable setmetatable
syn keyword terraFunc ipairs pairs
syn keyword terraFunc pcall xpcall
syn keyword terraFunc _G loadfile rawequal require import
syn keyword terraFunc load select
syn match terraFunc /\<package\.cpath\>/
syn match terraFunc /\<package\.loaded\>/
syn match terraFunc /\<package\.loadlib\>/
syn match terraFunc /\<package\.path\>/
syn keyword terraFunc _ENV rawlen
syn match terraFunc /\<package\.config\>/
syn match terraFunc /\<package\.preload\>/
syn match terraFunc /\<package\.searchers\>/
syn match terraFunc /\<package\.searchpath\>/
syn match terraFunc /\<bit32\.arshift\>/
syn match terraFunc /\<bit32\.band\>/
syn match terraFunc /\<bit32\.bnot\>/
syn match terraFunc /\<bit32\.bor\>/
syn match terraFunc /\<bit32\.btest\>/
syn match terraFunc /\<bit32\.bxor\>/
syn match terraFunc /\<bit32\.extract\>/
syn match terraFunc /\<bit32\.lrotate\>/
syn match terraFunc /\<bit32\.lshift\>/
syn match terraFunc /\<bit32\.replace\>/
syn match terraFunc /\<bit32\.rrotate\>/
syn match terraFunc /\<bit32\.rshift\>/
syn match terraFunc /\<coroutine\.running\>/
syn match terraFunc /\<coroutine\.create\>/
syn match terraFunc /\<coroutine\.resume\>/
syn match terraFunc /\<coroutine\.status\>/
syn match terraFunc /\<coroutine\.wrap\>/
syn match terraFunc /\<coroutine\.yield\>/
syn match terraFunc /\<string\.byte\>/
syn match terraFunc /\<string\.char\>/
syn match terraFunc /\<string\.dump\>/
syn match terraFunc /\<string\.find\>/
syn match terraFunc /\<string\.format\>/
syn match terraFunc /\<string\.gsub\>/
syn match terraFunc /\<string\.len\>/
syn match terraFunc /\<string\.lower\>/
syn match terraFunc /\<string\.rep\>/
syn match terraFunc /\<string\.sub\>/
syn match terraFunc /\<string\.upper\>/
syn match terraFunc /\<string\.gmatch\>/
syn match terraFunc /\<string\.match\>/
syn match terraFunc /\<string\.reverse\>/
syn match terraFunc /\<table\.pack\>/
syn match terraFunc /\<table\.unpack\>/
syn match terraFunc /\<table\.concat\>/
syn match terraFunc /\<table\.sort\>/
syn match terraFunc /\<table\.insert\>/
syn match terraFunc /\<table\.remove\>/
syn match terraFunc /\<math\.abs\>/
syn match terraFunc /\<math\.acos\>/
syn match terraFunc /\<math\.asin\>/
syn match terraFunc /\<math\.atan\>/
syn match terraFunc /\<math\.atan2\>/
syn match terraFunc /\<math\.ceil\>/
syn match terraFunc /\<math\.sin\>/
syn match terraFunc /\<math\.cos\>/
syn match terraFunc /\<math\.tan\>/
syn match terraFunc /\<math\.deg\>/
syn match terraFunc /\<math\.exp\>/
syn match terraFunc /\<math\.floor\>/
syn match terraFunc /\<math\.log\>/
syn match terraFunc /\<math\.max\>/
syn match terraFunc /\<math\.min\>/
syn match terraFunc /\<math\.huge\>/
syn match terraFunc /\<math\.fmod\>/
syn match terraFunc /\<math\.modf\>/
syn match terraFunc /\<math\.cosh\>/
syn match terraFunc /\<math\.sinh\>/
syn match terraFunc /\<math\.tanh\>/
syn match terraFunc /\<math\.pow\>/
syn match terraFunc /\<math\.rad\>/
syn match terraFunc /\<math\.sqrt\>/
syn match terraFunc /\<math\.frexp\>/
syn match terraFunc /\<math\.ldexp\>/
syn match terraFunc /\<math\.random\>/
syn match terraFunc /\<math\.randomseed\>/
syn match terraFunc /\<math\.pi\>/
syn match terraFunc /\<io\.close\>/
syn match terraFunc /\<io\.flush\>/
syn match terraFunc /\<io\.input\>/
syn match terraFunc /\<io\.lines\>/
syn match terraFunc /\<io\.open\>/
syn match terraFunc /\<io\.output\>/
syn match terraFunc /\<io\.popen\>/
syn match terraFunc /\<io\.read\>/
syn match terraFunc /\<io\.stderr\>/
syn match terraFunc /\<io\.stdin\>/
syn match terraFunc /\<io\.stdout\>/
syn match terraFunc /\<io\.tmpfile\>/
syn match terraFunc /\<io\.type\>/
syn match terraFunc /\<io\.write\>/
syn match terraFunc /\<os\.clock\>/
syn match terraFunc /\<os\.date\>/
syn match terraFunc /\<os\.difftime\>/
syn match terraFunc /\<os\.execute\>/
syn match terraFunc /\<os\.exit\>/
syn match terraFunc /\<os\.getenv\>/
syn match terraFunc /\<os\.remove\>/
syn match terraFunc /\<os\.rename\>/
syn match terraFunc /\<os\.setlocale\>/
syn match terraFunc /\<os\.time\>/
syn match terraFunc /\<os\.tmpname\>/
syn match terraFunc /\<debug\.debug\>/
syn match terraFunc /\<debug\.gethook\>/
syn match terraFunc /\<debug\.getinfo\>/
syn match terraFunc /\<debug\.getlocal\>/
syn match terraFunc /\<debug\.getupvalue\>/
syn match terraFunc /\<debug\.setlocal\>/
syn match terraFunc /\<debug\.setupvalue\>/
syn match terraFunc /\<debug\.sethook\>/
syn match terraFunc /\<debug\.traceback\>/
syn match terraFunc /\<debug\.getmetatable\>/
syn match terraFunc /\<debug\.setmetatable\>/
syn match terraFunc /\<debug\.getregistry\>/
syn match terraFunc /\<debug\.getuservalue\>/
syn match terraFunc /\<debug\.setuservalue\>/
syn match terraFunc /\<debug\.upvalueid\>/
syn match terraFunc /\<debug\.upvaluejoin\>/

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_terra_syntax_inits")
  if version < 508
    let did_terra_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink terraStatement		Statement
  HiLink terraRepeat		Repeat
  HiLink terraFor		Repeat
  HiLink terraString		String
  HiLink terraString2		String
  HiLink terraNumber		Number
  HiLink terraOperator		Operator
  HiLink terraConstant		Constant
  HiLink terraCond		Conditional
  HiLink terraCondElse		Conditional
  HiLink terraFunction		Function
  HiLink terraTerraFunction	Function
  HiLink terraQuote		Function
  HiLink terraComment		Comment
  HiLink terraTodo		Todo
  HiLink terraTable		Structure
  HiLink terraStruct		Structure
  HiLink terraError		Error
  HiLink terraParenError	Error
  HiLink terraSpecial		SpecialChar
  HiLink terraFunc		Identifier
  HiLink terraVariable		Identifier
  HiLink terraType		Type
  HiLink terraLabel		Label

  delcommand HiLink
endif

let b:current_syntax = "terra"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: et ts=8 sw=2
