"{{{Common maps i use
" Do clever indent things. Don't make a # force column zero.
inoremap # X<BS>#
nmap <silent> <F1> :set paste<CR>"+p:set nopaste<CR>
"Those are REALLY REALLY annoying
nmap :Q! :q!
nmap :q1 :q!
nmap :Q1 :q!
nmap :W :w

nmap qq :bdelete<CR>
nmap ,e :e ~/.vimrc<cr>      " edit my .vimrc file
nmap ,u :source ~/.vimrc<cr> " update the system settings from my vimrc file
" Insert a single char
noremap <Leader>i i<Space><Esc>r
" Insert a new line before or after current line
noremap <leader>o o<Esc>
noremap <leader>O O<Esc>
" Delete all blank lines in a file
noremap <Leader>dbl :g/^$/d<CR>:nohls<CR>
"Edit the files in the current directory
noremap <Leader>ed :e <C-r>=expand("%:p:h")<CR>/<C-d>

nmap <silent> <F7> :make<CR><CR>
vmap <silent> <F7> :make<CR><CR>
imap <silent> <F7> <esc>:make<CR><CR>
map <F2> :nohl<ESC>
map <F2><F2> :on<cr>

"More emacs like keystrokes - those move to the end/beginign of line"
inoremap <C-e> <esc>$a
inoremap <C-a> <esc>^i

"Go into normal with movement keys in insert mode
imap lll <esc>
imap hhh <esc>
imap jj <esc>
imap kk <esc>

" Don't go to the end of the file to start scrolling
map <up> g<up>
map <down> g<down>

" Mark the last selection with < and >
vnoremap > >gv
vnoremap < <gv

map // /\V
nnoremap % %zz
nnoremap * *zn
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
" Make * find the occurrence of the visually marked text
vnoremap * y/<C-R>"<CR>
"map it to the K key which i don't use for man pages(it is even annoying)
nnoremap <leader>k :call functions#FindInfo("<C-R><C-W>")<CR>
"select some text and then ask google for it directly with M"
vnoremap <leader>m y:call functions#FindInfo('<c-r>"')<cr><cr>
vnoremap <leader>papaste y:callste y:call Paste('<C-R>"')<cr><cr>
"Rename the variable under cursor in all buffers. You should confirm to do
"it. This also puts a mark with name R under the cursor we can go back
" to the buffer we were after that. Replace nvname with the new variable name
map <leader>brn mR:call functions#BuffersRenameVar("<C-R><C-W>", "nvname")
"If we don't have permissions use that to filter
"the save with sudoers
cmap w!! %!sudo tee > /dev/null %

imap <c-space> <C-x><C-o>
map <F12> :TagbarToggle<CR>
map <F6> :NERDTreeToggle<CR>

" portable ctrl + space
" taken from http://stackoverflow.com/questions/2269005/how-can-i-change-the-keybinding-used-to-autocomplete-in-vim
if has("gui_running")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-x><C-o>
else " no gui
  if has("unix")
    inoremap <Nul> <C-x><C-o>
  else
  " I have no idea of the name of Ctrl-Space elsewhere
  endif
endif
"}}}


nnoremap <leader>ss :execute "Rg " . expand('<cword>')<CR>
nnoremap <leader>fe :FZF<CR>
nnoremap <silent> <Leader>be :Buffers<CR>

nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    :References<CR>
nnoremap <silent> <leader>r  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Move between splits much faster
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h
map <Up> <C-W>k
map <Down> <C-W>j
map <Left> <C-W>h
map <Right> <C-W>l

" Disable ex mode from Q
nnoremap Q <Nop>

noremap ; :
vnoremap ; :

nmap ,p "0p
nmap ,P "0P

" Make uppercase behave in a sane way like D and C. You can use yy for whole
" line
noremap Y y$

" Make the overwriting paste in visual mode keep the last yank
xnoremap p "_dP

" fix the last spelling mistake and continue at the same insert mode position
" with ctrl-l
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
