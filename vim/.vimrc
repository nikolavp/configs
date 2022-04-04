
" vim: fdm=marker sw=4
" Basic options
"####################################################################
""{{{1 Basic options in vim
let mapleader = "\<Space>"
" Source this abbs that I am creating with Abb
source ~/.vim/abbs.vim

scriptencoding utf-8
if has('vim_starting')
    set nocompatible               " Be iMproved
endif
let mapleader = "\<Space>"

" Required:
call plug#begin('~/.vim/bundle')


Plug 'ciaranm/inkpot'

Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'nikolavp/sparql.vim', { 'for': 'sparql' }
Plug 'nikolavp/vim-jape', { 'for': 'jape' }
Plug 'tpope/vim-cucumber', { 'for': 'cucumber' }
Plug 'rosstimson/scala-vim-support', { 'for': 'scala' }
Plug 'plasticboy/vim-markdown', { 'for': 'mkd' }
Plug 'vim-scripts/n3.vim', { 'for': 'n3' }

Plug 'godlygeek/tabular', {'for': 'puppet'}
Plug 'rodjek/vim-puppet', { 'for': 'puppet'}

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/personal/content', 'syntax': 'markdown', 'ext': '.md'}]


Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'neovim/nvim-lspconfig'

" Add closing pairs automatically. Also add them by default
" for functions and methods in different languages during autocomplete
Plug 'windwp/nvim-autopairs'

" Snippet support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Autocomplete with different sources
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/cmp-nvim-lsp'

Plug 'ray-x/lsp_signature.nvim'

Plug 'gfanto/fzf-lsp.nvim'

call plug#end()

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = '/Users/nikolavp/gocode/bin/gocode'
let g:go_auto_type_info = 1
set updatetime=100


" Max line length to be readable
set colorcolumn=120

set numberwidth=1   "Make it low so it doesn't get too much space.
"{{{2 Filetype options
filetype on
filetype plugin on
filetype indent on
"}}}
syntax on
set showfulltag     " Show the full tag when we are doing search completion
set showcmd         " Show the command we are typing
set nowrap          " Make this default and switch it on if we need
set linebreak       " This don't just cut our words but wraps nice
set lazyredraw      " speed up macros
set tabstop=4       " numbers of spaces of tab character
set softtabstop=4   " Really, really useful!
set shiftwidth=4    " numbers of spaces to (auto)indent
"{{{Searching options
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ignorecase      " No case sensitivity 
"}}}
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
set autowriteall
"Don't select text in visual mode when dragging the mouse(i hate that.);
set mouse=nic
"{{{2 No bad visual annoying and beeps
set novisualbell
set visualbell t_vb=   
if has("autocmd")
    autocmd GUIEnter * set visualbell t_vb=
endif

if has("nvim")
    set inccommand=nosplit
endif

"}}}
"Try to wrap on these
set whichwrap+=<,>,[,]
"Use the cool tab complete menu
set wildmenu
set wildignore+=*.o,*~,.lo
set suffixes+=.in,.a
set suffixes+=.lo,.o,.moc,.la,.closure,.loT
"Make backspace delete lots of things
set backspace=indent,eol,start
set backup " keep a backup file
set backupdir=~/tmp/
set number          " show line numbers
"Enable a nice big viminfo file
set viminfo='1000,f1,:1000,/1000
set history=500
"Highlight matching parens
set showmatch
"Do spell checking for English
set spell
silent set spelllang+=en
colorscheme inkpot
set autoindent
set smartindent
"{{{Enable folds
if has("folding")
    set foldenable
    set foldlevel=4
    set foldmethod=indent
endif
"}}}
"}}}
if $TERM=='screen-256color-bce'
   exe "set title titlestring=vim:%f"
   exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
endif
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
    set guifont=Consolas\ 10.5  " use this font
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
endif
""}}}
"}}}
source ~/.vim/filetypes.vim
source ~/.vim/maps.vim
source ~/.vim/contents.vim
" Added and stolen from Radev lately
source ~/.vim/cyrillic.vim
"{{{ Options for the plugins
let python_highlight_all=1
" Settings for tagbar
let g:tagbar_compact = 1
let g:tagbar_width = 28
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

"Close NERDTree if open after we open a new file
let g:NERDTreeQuitOnOpen=1
"Doxygen
let g:load_doxygen_syntax=1
let g:doxygen_enhanced_color=1
"Latex options
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf="kpdf"

"}}}
"-----------------------------------------------------------------------
" final commands
"-----------------------------------------------------------------------
" turn off any existing search
if has("autocmd")
    au VimEnter * nohls
endif
command! -nargs=+ Abb :call functions#Abbreviate(<f-args>)
"Spot any double word, which are really hard to find. Especially useful for latex and plain text
au Syntax * syn match Error "\c\<\(\a\+\)\_s\+\1\>"
"Highlight extra whitespace
au Syntax * syn match Error /\s\+$\| \+\ze\t/  " highlight extra whitespace
let java_highlight_java_lang_ids=1
let java_highlight_java_io=1
"This deletes the space after the iabrev i don't like sometimes.
"{{{Getchar function + Eathchar - a neat way for iabbrev that eat a space
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
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"Store the session on exit
if has("autocmd")
    au VimLeave * mksession! ~/.vimsession
endif

"More on this option here http://www.johnhawthorn.com/2012/09/vi-escape-delays/
set ttimeoutlen=0

"turtle filetypes
augroup filetypedetect
    au BufNewFile,BufRead *.n3  setfiletype n3
    au BufNewFile,BufRead *.ttl  setfiletype n3
    au BufNewFile,BufRead *.confluence  setfiletype confluencewiki
augroup END

" Save folds as described here
" http://vimrc-dissection.blogspot.com/2014/10/save-state-of-folds-mkview.html
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent! loadview 

" Debugging of language server support
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')

" Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright

" Avoid showing message extra message when using completion
set shortmess+=c

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Set completeopt to have a better completion experience
set completeopt=menu,menuone,noselect

" Autocomplete configuration
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  -- cmp.setup.filetype('gitcommit', {
  --   sources = cmp.config.sources({
  --     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  --   }, {
  --     { name = 'buffer' },
  --   })
  -- })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline('/', {
  --   sources = {
  --     { name = 'buffer' }
  --   }
  -- })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline(':', {
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     { name = 'cmdline' }
  --   })
  -- })

  -- Setup lspconfig and cmp-nvim-lsp
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local lsp_config = require('lspconfig')

  lsp_config.pylsp.setup{
    capabilities = capabilities
  }
  lsp_config.gopls.setup{
    root_dir = lsp_config.util.root_pattern("itea.setup.yaml", "main.go", "go.mod", ".git"),
    capabilities = capabilities,
  }

  -- Setup nvim-autopairs
  require('nvim-autopairs').setup{}

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
  -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
  cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
  require'lsp_signature'.setup({})
EOF


