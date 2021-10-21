if exists('g:loaded_listify') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" command to run our plugin
command! Listify lua require'listify'.listify(true)

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

let g:loaded_listify = 1
