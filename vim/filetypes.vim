"{{{Autocmd's for files"
if has("autocmd")
    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
    " Filetypes (au = autocmd)
    au FileType helpfile set nonumber      " no line numbers when viewing help
    au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back
    " When using mutt, text width=72
    au FileType mail,tex set textwidth=72
    au FileType cpp,c,java,sh,pl,php,asp  set autoindent
    au FileType cpp,c,java,sh,pl,php,asp  set smartindent
    au FileType cpp,c,java,sh,pl,php,asp  set cindent
    au Filetype cpp,c,java,php,python call functions#FindTags()
    " File formats
    au BufNewFile,BufRead  *.pls    set syntax=dosini
    au BufNewFile,BufRead  *.tex  set ft=tex
    au BufNewFile,BufRead  *.jape  set ft=jape
    au BufNewFile,BufRead  *.forum  set ft=forum
    au BufNewFile,BufRead  modprobe.conf    set syntax=modconf

    " Set confluence syntax highlighting
    au BufNewFile,BufRead */itsalltext/*confluence* set ft=confluencewiki
    " Set notes filetype for tasknote and taskwarrior
    au BufNewFile,BufRead */*task*/notes* set ft=notes
    au BufNewFile,BufRead */*diary* set ft=notes

    " Completion modes for the languages we are using
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd	FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete
    " Taken from ciaranm, really useful - always open cwindow after :make
    autocmd QuickFixCmdPost * botright cwindow 5
    " Always do a full syntax refresh(that can be a litte slow if you
    " don't have a fast machine)
    " autocmd CursorHold * make
    "
    autocmd FileType python setlocal omnifunc=python3complete#Complete
endif

