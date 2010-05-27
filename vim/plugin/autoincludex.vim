" =============================================================================
" File:         autoincludex.vim
" Description:  vim plugin for autoinserting headers for classes
" Maintainer:   Vadim A. Khohlov  <xvadima at ukr dot net>
" Last Change:  31 August, 2008
" Version:      0.9
" License:      GPL
" -----------------------------------------------------------------------------
" Description:  This script allows you to automatically add the #include
" statements in C/C++-files.
"
" Install:      
"   Put autoincludex.vim file in your ~/.vim/plugin. Create directory 
"   ~/.vim/includesdb where databases of headers will be saved. You can use
"   any directory, but in this case you should set the variable
"   g:dict_inc_db_path in correct value.
"
" Usage:
"   Place the cursor on the type you need to include. If it is your class,
"   for example MyClass, enter in Normal mode:
"       :call AutoIncludeCC()
"   The string #include "myclass.h" will be inserted in file.
"   For type from library, for example STL, enter:
"       :call AutoIncludeLib("stl")
"   At first time you well be prompted to enter the correct header. You
"   should enter full text for include statement, i.e. with < >. In next time
"   this header will be inserted automatically even after reloading of
"   vim.
"   You can also place the special marks into file. For you types this is
"   the "project headers". In this case #include will be inserted after
"   line with this text:
"   //project headers
"   #include "myclass.h"
"   For type from the libraries this text is the "libname headers", where
"   libname is name of library:
"   //stl headers
"   #include <vector>
"
"   //wx headers
"   #include <wx/menu.h>
"
"   Of course, you can create map for calling of this function:
"   map ;; :call AutoIncludeCC()<cr>
"   map ;;w :call AutoIncludeLib("wx")<cr>
"
"   For other languages you may specify options g:ainc_header_prefix and
"   g:ainc_header_suffix for prefix and suffix of included header. For
"   example, for php this options may have the values "require_once('" and
"   "');"; for python - "import " and ""
"
" Changelog:
"   0.9 - Initial release
"   1.0 - bugfix of processing headers with \ and /
"       - Added options g:ainc_header_prefix and g:ainc_header_suffix
"
" P.S.: 
"   1. This script will be written under influence of script
"   autoinclude.vim.
"   2. Please don't hesitate to correct my English :) Send corrections to
"   my e-mail.

" Prevent multyloading
if exists("g:loaded_autoincludex")
    finish
endif
let g:loaded_autoincludex = 1

" Dictionary of dictionaries with headers info
let dict_inc = {}
" Path to files with headers' info
if !exists("g:dict_inc_db_path")
    let g:dict_inc_db_path = $HOME."/.vim/includesdb/"
endif
" Header's prefix and suffix
if !exists("g:ainc_header_prefix")
    let g:ainc_header_prefix = "#include "
endif
if !exists("g:ainc_header_suffix")
    let g:ainc_header_suffix = ""
endif

" Finds header string for a:obj_name into subdict dict_inc[a:subdict_key]
" If string not found - adds it
function! s:SearchInclude(subdict_key, obj_name)
    if !has_key(g:dict_inc, a:subdict_key)
        " creates subdict if it not exists
        let g:dict_inc[a:subdict_key] = {}
        " and loads it from file
        call s:LoadDictInc(a:subdict_key)
    endif
    if !has_key(g:dict_inc[a:subdict_key], a:obj_name)
        let g:dict_inc[a:subdict_key][a:obj_name] = input("Enter header for ".a:obj_name.": ")
    endif
    return g:dict_inc[a:subdict_key][a:obj_name]
endfun

" Inserts header for library a:libname
function! AutoIncludeLib(libname)
    let obj_name = expand("<cword>")
    let mark_inc = a:libname.' headers'
    let str_inc = s:SearchInclude(a:libname, obj_name)
    call s:InsertInclude(mark_inc, str_inc)
endfun

" Inserts header "classname.h" for class under cursor (ClassName)
function! AutoIncludeCC()
    let class = expand("<cword>")
    let mark_inc = 'project headers'
    let str_inc = '"'.tolower(class).'.h"'
    call s:InsertInclude(mark_inc, str_inc)
endfun

" Inserts string '#include a:str_inc' after line with 'a:mark_inc' text
function! s:InsertInclude(mark_inc, str_inc)
    let old_line_num = line(".")
    let x = g:ainc_header_prefix.escape(escape(a:str_inc, '\'), '/').g:ainc_header_suffix
    try
        execute '/'.x
        echo 'Header '.a:str_inc.' is already included'
    catch /^Vim\%((\a\+)\)\=:E486/  " insert header if it needed
        try " jump after marked line
            execute '/'.a:mark_inc
            let line = line(".") + 1
        catch /^Vim\%((\a\+)\)\=:E486/
            "if no a:mark_inc text insert header at first line of file
            let line = 1
        endtry
        execute '' . line
        normal O
        execute 's/$/\=x/'
        normal ==
    endtry
    execute '' . old_line_num + 1
endfun

" Saves include dictionaries into files
function! s:SaveDictInc()
    for key in keys(g:dict_inc)
        let lst_includes = []
        for obj_name in keys(g:dict_inc[key])
            call add(lst_includes, obj_name.' '.g:dict_inc[key][obj_name])
        endfor
        call writefile(lst_includes, g:dict_inc_db_path.key)
    endfor
endfun

" Loads includes' dictionary for library a:libname
function! s:LoadDictInc(libname)
    let filename = g:dict_inc_db_path.a:libname
    if (filereadable(filename))
        let inc_strs = readfile(filename)
        for str in inc_strs
            let [obj_name, str_inc] = split(str)
            let g:dict_inc[a:libname][obj_name] = str_inc
        endfor " str in inc_strs
    endif
endfun

" Autosaves dictionary on leaving vim
au VimLeave * call s:SaveDictInc()

