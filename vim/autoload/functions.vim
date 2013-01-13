"{{{ ShowDoc(name) Show the documentation in python
function! functions#ShowDoc(name)
    enew
    execute "read !pydoc " . a:name
    setlocal nomodifiable
    setlocal nomodified
    set filetype=man
    normal 1G
endfunction"}}}
"{{{ FindInfo(cword) Find information for word/snippet under cursor in google
fun! functions#FindInfo(cword)
    let url = "\"http://google.com/search?q="
    let word = a:cword
    "remove trailing blank spaces, quotes if any and other characters (google don't like)
    let word = join(split(substitute(word, '["+]*',"", "g"))) 
    let url = url . word
    "cpp doesn't give reasonable results in google
    if expand(&filetype) == "cpp"
        let url = url . " " . "C\%2B\%2B" 
    else
        let url = url . " " . expand(&filetype)
    endif
    execute "silent !firefox  -new-tab " . url . "\""
endfun"}}}
"{{{BuffersRenameVar(cword) 
"Rename the word under cursor, ask for the new variable name and
"if we want to rename it through the buffers
fun! functions#BuffersRenameVar(cword, newvar)
    let word = a:cword
    let newvar = a:newvar
    let replace = ":bufdo %s/\\\<"
    let replace .= expand(word)
    let replace .= "\\>/"
    let replace .= expand(newvar)
    let replace .= "/gce"
    execute replace
endfun"}}}
"{{{ Function to automate Abbreviation 
function! functions#Abbreviate(input, output) 
python << EOF
def appendAbb():
    import os
    import vim
    home = os.getenv("USERPROFILE") or os.getenv("HOME")
    home += "/.vim/abbs.vim"
    Abbs = open(home, "a")
    inputstr = vim.eval("a:input")
    outputstr = vim.eval("a:output")
    abbreviation = "iabbrev " + str(inputstr) + " " + str(outputstr)+ "\n"
    Abbs.write(abbreviation)
EOF
:py appendAbb()
let abbrevation = "iabbrev ". expand(a:input). " ". expand(a:output)
execute abbrevation
endfunction
"}}}
"{{{ Find a tag file in the current or parent directories
function! functions#FindTags()
   let s:tagfile = findfile('tags', '.;')
   if s:tagfile != ''
     let &tags = s:tagfile . ",". &tags
   endif
endfunction
"}}}
" vim:fdm=marker:sw=4
