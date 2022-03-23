"{{{Common maps i use
" Do clever indent things. Don't make a # force column zero.
inoremap # X<BS>#
nmap <silent> <F1> :set paste<CR>"+p:set nopaste<CR>
"Those are REALLY REALLY annoying
nmap :Q! :q!
nmap :q1 :q!
nmap :Q1 :q!
nmap <leader>be :CtrlPBuffer<CR>
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
nnoremap <expr> <silent> cp (&diff ? "[c" : ":cprev\<CR>")
nnoremap <expr> <silent> cp (&diff ? "[c" : ":cprev\<CR>")
vmap cl :cl<CR>
nmap cl :cl<CR>
nmap ccl :ccl<CR>
vmap ccl :ccl<CR>
"###Some really nice key strokes I stole or are put alone in work with the editor####"
" Insert a single char
noremap <Leader>i i<Space><Esc>r
" Delete all blank lines in a file
noremap <Leader>dbl :g/^$/d<CR>:nohls<CR>
"Edit the files in the current directory
noremap <Leader>ed :e <C-r>=expand("%:p:h")<CR>/<C-d>
vnoremap <F4> =
nmap <silent> <F7> :make<CR><CR>
vmap <silent> <F7> :make<CR><CR>
imap <silent> <F7> <esc>:make<CR><CR>
map <F2> :nohl<ESC>
map <F2><F2> :on<cr>

"More emacs like keystrokes - those move to the end/beginign of line"
inoremap <C-e> <esc>$a
inoremap <C-a> <esc>^i
imap lll <esc>
imap hhh <esc>
imap jj <esc>
imap kk <esc>
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


nnoremap <leader>ss :Rg<CR>
nnoremap <leader>fe :FZF<CR>
nnoremap <silent> <Leader>be :Buffers<CR>

nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <CR> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Move between splits much faster
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

