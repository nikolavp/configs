" vim: fdm=marker sw=4
" -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*- 
" Some of the stuff is coppied from the Vimrcs all over the net
"####################################################################
" Basic options
"####################################################################
""{{{1 Basic options in vim
"source ~/kdesdk.vim
"source ~/bookmarks.vim
runtime ftplugin/man.vim
source ~/.vim/abbs.vim
set runtimepath+=~/myvimfiles
scriptencoding utf-8
set nocompatible    " use vim defaults
set numberwidth=1   "Make it low so it doesn't get too much space.
"{{{2 Filetype options
filetype on
filetype plugin on
filetype indent on
"}}}
syntax on
set showfulltag     " Show the full tag when we are doing search completion
set showcmd			" Show the command we are typing
set nowrap          " Make this default and switch it on if we need
set linebreak       " This don't just cut our words but wraps nice
set lazyredraw 		" speed up macros
set tabstop=4       " numbers of spaces of tab character
set softtabstop=4   " Really, really useful!
set shiftwidth=4    " numbers of spaces to (auto)indent
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ignorecase 		" No case sensitivity 
set ruler           " show the cursor position all the time
set scrolloff=3     " Keep 3 lines when we are scrolling
set expandtab
set fileformat=unix "Set it default to Unix. So many problems with that :("
set clipboard=unnamed "Just copy to the clipboard as default!!
set listchars=tab:·\ ,trail:·,nbsp:·
"Uncomment that if you want to see hmm most everything :)(thanks to mauke
"from IRC for that.)
"let &lcs = "tab:\273\255,trail:\267,eol:\266,nbsp:\u23b5,precedes:\u2190,extends:\u2192"
set list
set autowrite
"Don't select text in visual mode when dragging the mouse(i hate that.);
set mouse=nic
"set pastetoggle=<F1> "Set F1 to toggle the paste :)
"Much better :)
nmap <silent> <F1> :set paste<CR>"+p:set nopaste<CR> 
"{{{2 No bad visual annoying and beeps
set novisualbell
set visualbell t_vb=   
if has("autocmd")
    autocmd GUIEnter * set visualbell t_vb=
endif
"}}}
"Try to wrap on these
set whichwrap+=<,>,[,]
"Use the cool tab complete menu(ciaranm's vimrc)
set wildmenu
set wildignore+=*.o,*~,.lo
set suffixes+=.in,.a
set suffixes+=.lo,.o,.moc,.la,.closure,.loT
"Make backspace delete lots of things(vim book)
set backspace=indent,eol,start
set backup        	" keep a backup file
set backupdir=~/tmp/
set number          " show line numbers
set ignorecase      " ignore case when searching
"Enable a nice big viminfo file
set viminfo='1000,f1,:1000,/1000
set history=500
"Highlight matching parens
set showmatch
"Do spell checking for English
set spell
set spelllang=
silent set spelllang+=en
silent set spelllang+=bg
""{{{Try to load a nice colourscheme (ciaranm)
"if has("eval")
"    fun! LoadColourScheme(schemes)
"        while a:schemes != ""
"            let a:scheme = strpart(a:schemes, 0, stridx(a:schemes, ":"))
"            try
"                exec "colorscheme" a:scheme
"                break
"            catch
"            endtry
"        endwhile
"    endfun
"    if has('gui')
"        let g:inkpot_black_background = 1
"        call LoadColourScheme("inkpot:zenburn:night:rainbow_night:darkblue:elflord")
"    endif
"endif
colorscheme inkpot
"let g:inkpot_black_background = 1
"}}}
" Do clever indent things. Don't make a # force column zero.
set autoindent
set smartindent
inoremap # X<BS>#
"Enable folds
if has("folding")
    set foldenable
    set foldmethod=indent
endif
"}}}
"{{{1
"{{{2 Status bar options(ciaranm's vimrc)
set laststatus=2
set statusline=
set statusline+=%2*%-3.3n%0*\                " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%2*0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset"
"}}}
"{{{2 Window title options(ciaranm''s vimrc)
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                                              " file name
    set titlestring+=%h%m%r%w                                         " flags
    set titlestring+=\ -\ %{v:progname}                               " program name
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}  " working directory
endif
"}}}
"{{{2 Completion
"set dictionary+=/usr/share/dict/words
"set complete+=k
""}}}
""{{{2 Extra terminal things
if (&term =~ "xterm") && (&termencoding == "")
    set termencoding=utf-8
endif
if &term =~ "xterm"
    " use xterm titles
    if has('title')
        set title
    endif
    " change cursor colour depending upon mode
    if exists('&t_SI')
        let &t_SI = "\<Esc>]12;lightgoldenrod\x7"
        let &t_EI = "\<Esc>]12;grey80\x7"
    endif
endif
"}}}
"}}}
""{{{1
"Gui options 
""{{{2
"Gui options which I like(Clean and simple)
if has('gui')
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
end
"}}}
""{{{2
if has("gui_running")
    " See ~/.gvimrc
    " I like the traditional Courier New fonts
    set guifont=Monospace\ 10.5  " use this font
    "Turn off that stupid blinking in all modes :(
    set guicursor=
    set guicursor+=n-v-c:block-Cursor/lCursor-blinkon0,
                \ve:ver35-Cursor-blinkon0,
                \o:hor50-Cursor-blinkon0,
                \i-ci:ver25-Cursor/lCursor-blinkon0,
                \r-cr:hor20-Cursor/lCursor-blinkon0,
                \sm:block-Cursor-blinkon0
    set lines=30      " height = 50 lines
    set columns=100        " width = 100 columns
    set keymodel=
"else
"    colorscheme elflord    " use this color scheme
"    set background=dark        " adapt colors for background
endif
""}}}
"}}}
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
    " Nice imap for curly braces.
    autocmd FileType c,cpp,java,perl,php imap <buffer> {{ {<esc>o}<esc>O
    " File formats
    au BufNewFile,BufRead  *.pls    set syntax=dosini
    au BufNewFile,BufRead  *.tex  set ft=tex
    au BufNewFile,BufRead  *.forum  set ft=forum
    au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
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
    "autocmd CursorHold * make
endif
"content creation - some of this is taken from ciaranm(thanks :D)
if has("autocmd")
    augroup content
        autocmd!
        autocmd BufNewFile *.rb 0put ='# vim: set sw=4 sts=4 et tw=80 :' |
                    \ 0put ='#!/usr/bin/ruby' | set sw=4 sts=4 et tw=80 |
                    \ norm G
        autocmd BufNewFile *.hh 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
                    \ 1put ='/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */' |
                    \ 2put ='' | call IncludeGuard() |
                    \ set sw=4 sts=4 et tw=80 | norm G
        autocmd BufNewFile *cpp 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
                    \ 1put ='/* -*- Mode: C++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */' |
                    \ 2put ='' | 3put ='' | call setline(3, '#include "' .
                    \ substitute(expand("%:t"), ".cc$", ".hh", "") . '"') |
                    \ set sw=4 sts=4 et tw=80 | norm G
        autocmd BufNewFile *.sh 0put ='#!/bin/bash' |
                    \ 1put ='# vim: set sw=4 sts=4 et foldmethod=indent :' |
                    \ set sw=4 sts=4 et tw=80 |
                    \ norm G
        autocmd BufNewFile *.py 0put ='# vim: set sw=4 sts=4 et foldmethod=indent :'|
                    \ 0put ='#!/usr/bin/env python' |
                    \ set sw=4 sts=4 et tw=80
                    \ norm G
    augroup END
endif
"}}}
"{{{Common maps i use 
"Those are REALLY REALLY annoying
nmap :Q! :q!
nmap :q1 :q!
nmap :Q1 :q!
"I don't use the q macro name :)
nmap qq :bdelete<CR>
nmap :W :w
nmap ,e :e ~/.vimrc<cr>      " edit my .vimrc file
nmap ,u :source ~/.vimrc<cr> " update the system settings from my vimrc file
"Some mappings for quickfix
"we don't need cc use C instead for changing a whole line
vmap cc :cc<CR> 
nmap cc :cc<CR>
nnoremap <expr> <silent> cn (&diff ? "]c" : ":cnext\<CR>")
nnoremap <expr> <silent> cn (&diff ? "]c" : ":cnext\<CR>")
vnoremap <expr> <silent> cp (&diff ? "[c" : ":cprev\<CR>")
vnoremap <expr> <silent> cp (&diff ? "[c" : ":cprev\<CR>")
vmap cl :cl<CR> 
nmap cl :cl<CR>
nmap ccl :ccl<CR>
vmap ccl :ccl<CR>
"Those mappings are for the tabs(all modes)
map <C-S-Right> :bnext<CR>
map <C-S-l> :bnext<CR>
map <C-S-h> :bprevious<CR>
map <C-S-Left> :bprevious<CR>
"###Some really nice key strokes I stole or are put alone in work with the editor####"
" Insert a single char (ciaranm :)) 
noremap <Leader>i i<Space><Esc>r
" Delete all blank lines in a file
noremap <Leader>dbl :g/^$/d<CR>:nohls<CR>
"Edit the files in the current directory 
noremap <Leader>ed :e <C-r>=expand("%:p:h")<CR>/<C-d>
"Format the whole file with my rules :)
map <F4> mpggVG=`p
nmap <silent> <F7> :make<CR><CR>
vmap <silent> <F7> :make<CR><CR>
imap <silent> <F7> <esc>:make<CR><CR>
map <F2> :nohl<ESC>
map <F2><F2> :on<cr>
if !has('win32')
    "This moves the text on the current line one line up and one down(taken
    "from eclipse :)). Those characters are just <ALT+j>;<ALT+k>. It seems that
    "this doesnt work nice on Windows :(
    nnoremap ê ddp
    nnoremap ë ddkP
    inoremap ë <ESC>ddkP
    inoremap ê <ESC>ddp
    "Those move one word left/right in insert mode emacs like"
    inoremap æ <esc>lea
    inoremap â <esc>bi
endif

"More emacs like keystrokes - those move to the end/beginign of line"
inoremap <C-e> <esc>$a
inoremap <C-a> <esc>^i
"This puts a semicolon at the end of the line and removes it with _;
nnoremap ; mpA;<ESC>`p
nnoremap _; mp$x`p
imap lll <esc>
imap hhh <esc>
imap jj <esc>
imap kk <esc>
map <up> g<up>
map <down> g<down>
noremap <F3> <C-w>w
nnoremap % %zz
nnoremap * *zn
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
vnoremap * y/<C-R>"<CR>
"map it to the K key which i don't use for man pages(it is even annoying)
nnoremap <leader>k :call functions#FindInfo("<C-R><C-W>")<CR>
"select some text and then ask google for it directly with M"
vnoremap <leader>m y:call functions#FindInfo('<c-r>"')<cr><cr>
vnoremap <leader>paste y:call Paste('<C-R>"')<cr><cr>
"Rename the variable under cursor in all buffers. You should confirm to do
"it. This also puts a mark with name R under the cursor we can go back
" to the buffer we were after that. Replace nvname with the new variable name
map <leader>brn mR:call functions#BuffersRenameVar("<C-R><C-W>", "nvname")
"If we don't have permissions use that to filter
"the save with sudoers
cmap w!! %!sudo tee > /dev/null %
"Those are for Bulgarian language, because I want to have some of the
"keystrokes in that language too 
nmap А A
nmap И I
nmap и i
nmap а a
nmap :я :q
nmap :я! :q!
nmap :в :w
nmap о o
nmap О O
nmap ь x
nmap д d
nmap Ж V
nmap ж v
nmap у u
imap <c-space> <C-x><C-o>
map <F12> :TlistToggle<cr>
map <F6> :NERDTreeToggle<CR>
"}}}
"{{{ Options for the plugins
let python_highlight_all=1
" Settings for taglist.vim
let Tlist_Process_File_Always=1
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
let Tlist_Enable_Fold_Column=0
let Tlist_Compact_Format=1
let Tlist_WinWidth=28
let Tlist_Exit_OnlyWindow=1
if exists('loaded_taglist')
    let Tlist_File_Fold_Auto_Close = 1
    set statusline=%<%f:[\ %{Tlist_Get_Tag_Prototype_By_Line()}\ ]\ %h%m%r%=%-14.(%l,%c%V%)\ %P
endif
" Settings for nopaste"
let g:nickname = "nikolavp"
" Settings for Autoclose.vim(really cool)
let g:AutoCloseProtectedRegions = ["Comment", "String", "Character"] 
"}}}
"Close NERDTree if open after we open a new file
let g:NERDTreeQuitOnOpen=1
"
let g:load_doxygen_syntax=1
let g:doxygen_enhanced_color=1
"Latex options
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf="kpdf"
"-----------------------------------------------------------------------
" final commands
"-----------------------------------------------------------------------
" turn off any existing search
if has("autocmd")
au VimEnter * nohls
endif
command! -nargs=+ Abb :call functions#Abbreviate(<f-args>)
"Spot any double word, which are really hard to find. Especially useful for latex :)
syn match texDoubleWord "\c\<\(\a\+\)\_s\+\1\>"
hi def link texDoubleWord Error
"This will indent and close the brace when we are at the end of the line for a
"function"
"inoremap <expr> <CR> (col("$")==col(".") ? "\<ESC>=a{\<C-O>o" : "\<CR>")
"Highlight extra whitespace
au Syntax * syn match Error /\s\+$\| \+\ze\t/  " highlight extra whitespace
let java_highlight_java_lang_ids=1
let java_highlight_java_io=1
"autocmd Syntax * call AddQtSyntax();
"autocmd CursorHold * call UpdateMocFiles()
"autocmd BufNewFile,BufRead * call SetCodingStyle()
"{{{Getchar function + Eathchar - a neat way for iabbrev that eat a space
" Append modeline after last line in buffer.
function! AppendModeline()
  let save_cursor = getpos('.')
  $put =printf(&commentstring, ' vim: set ts='.&tabstop.' sw='.&shiftwidth.' tw='.&textwidth.': ')
  call setpos('.', save_cursor)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
"This deletes the space after the iabrev i don't like sometimes.
fun! Eatchar(pat)
   let c = Getchar()
   return (c =~ a:pat) ? '' : c
endfun
fun! Getchar()
  let c = getchar()
  if c != 0
    let c = nr2char(c)
  endif
  return c
endfun
command! -nargs=+ Iabbr execute "iabbr" <q-args> . "<C-R>=Eatchar('\\s')<CR>"
"}}}
command! -nargs=0 FindTags :call functions#FindTags()
" Bring us to the directory of the file we are editing
command! CD :cd %:h
"Deletes some warning from gcc"
"let &errorformat = "%-G%f\:%l\:\ warning\:\ deprecated\ conversion\ from\ string%.%#\,".&errorformat
"Use that if we are getting strange warning from gcc"
"let &errorformat = "%-G%.%#warning:%.%#\,".&errorformat 
"This deletes the line numbers from pasted text(super useful sometimes
" '[,'] is used for a region of the last paste
" :'[,']s/\s*\d\+\..//
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"Store the session from last time :)
if has("autocmd")
au VimLeave * mksession! ~/.vimsession
endif
