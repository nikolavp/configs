
" vim: fdm=marker sw=4
" Basic options
"####################################################################
""{{{1 Basic options in vim
let mapleader = "\<Space>"
" Source this abbs that I am creating with Abb
source ~/.vim/abbs.vim
" Put customer ftdetect and
set runtimepath+=~/.vim/
" Use ripgrep instad of the builtin grep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat+=%f:%l:%c:%m
" Define a command to skip the "Press any key to continue"" when executing the
" normal :grep
command! -nargs=+ Grep silent! grep! <args>

scriptencoding utf-8
if has('vim_starting')
    set nocompatible               " Be iMproved
endif
let mapleader = "\<Space>"

" Required:
call plug#begin('~/.vim/bundle')


Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'nikolavp/sparql.vim', { 'for': 'sparql' }
Plug 'nikolavp/vim-jape', { 'for': 'jape' }
Plug 'tpope/vim-cucumber', { 'for': 'cucumber' }
Plug 'rosstimson/scala-vim-support', { 'for': 'scala' }
Plug 'plasticboy/vim-markdown', { 'for': 'mkd' }

Plug 'godlygeek/tabular', {'for': 'puppet'}
Plug 'rodjek/vim-puppet', { 'for': 'puppet'}

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/personal/content', 'syntax': 'markdown', 'ext': '.md'}]


Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'

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

" Better matchit
Plug 'andymass/vim-matchup'
" Copy paste from remote machines
Plug 'ojroques/vim-oscyank'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/mason.nvim'
Plug 'folke/tokyonight.nvim'

call plug#end()

set updatetime=100

" Max line length to be readable
set colorcolumn=120
" Note that this doesn't result in the buffer being wrapped at this column, it
" will just look visually like so
set columns=120

set numberwidth=1   "Make it low so it doesn't get too much space.
"{{{2 Filetype options
filetype on
filetype plugin on
filetype indent on
"}}}
syntax on
set showfulltag     " Show the full tag when we are doing search completion
set showcmd         " Show the command we are typing
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
colorscheme tokyonight
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
"}}}
""{{{1
source ~/.vim/filetypes.vim
source ~/.vim/maps.vim
source ~/.vim/contents.vim
" Added and stolen from Radev
source ~/.vim/cyrillic.vim
"{{{ Options for the plugins

"Close NERDTree if open after we open a new file
let g:NERDTreeQuitOnOpen=1
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
au Syntax * syn match Error /\s\+$\| \+\ze\t/
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
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },

    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<Down>"] = cmp.mapping.select_next_item(),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
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
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local lsp_config = require('lspconfig')

  lsp_config.pylsp.setup{
    capabilities = capabilities
  }

  lsp_config.gopls.setup{
    root_dir = lsp_config.util.root_pattern("itea.setup.yaml", "main.go", "go.mod", ".git"),
    capabilities = capabilities,
  }

  lsp_config.pylsp.setup {
    capabilities = capabilities,
  }


  lsp_config.helm_ls.setup {
    settings = {
      ['helm-ls'] = {
        yamlls = {
          path = "yaml-language-server",
        }
      }
    }
  }

  lsp_config.ts_ls.setup{
    capabilities = capabilities
  }

  lsp_config.jsonls.setup{
    capabilities = capabilities
  }
  lsp_config.svelte.setup{
    capabilities = capabilities
  }
  lsp_config.tailwindcss.setup{
    capabilities = capabilities
  }

-- a little bit based on https://github.com/neovim/nvim-lspconfig/blob/ead2fbc4893fdd062e1dd0842679a48bfb7bac5c/lua/lspconfig/configs/sourcery.lua#L17
-- https://neovim.discourse.group/t/how-to-add-a-custom-server-to-nvim-lspconfig/3925/4
-- Setup a custom lsp server
--   local configs = require 'lspconfig.configs'
--   if not configs.noir_lsp then
--     configs.noir_lsp = {
--       default_config = {
--         cmd = { '/Users/nikolavp/test.sh' },
--         root_dir = lsp_config.util.root_pattern('.git'),
--         filetypes = { 'go' },
--       },
--     }
--   end
--   lsp_config.noir_lsp.setup {
--       init_options = {
--           token = "",
--           apiUrl = ""
--       }
--   }

  -- Setup nvim-autopairs
  require('nvim-autopairs').setup{}

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
  require'lsp_signature'.setup({})


  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "svelte", "typescript", "tsx", "json", "css", "javascript" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { },

    highlight = {
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = { },
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      -- disable = function(lang, buf)
      --     local max_filesize = 100 * 1024 -- 100 KB
      --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      --     if ok and stats and stats.size > max_filesize then
      --         return true
      --     end
      -- end,

      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true
    }
  }
  require("mason").setup()
EOF

" Use terminal background for performance.
highlight Normal ctermbg=NONE guibg=NONE

" vim-matchup non-distracting-config
hi MatchWord ctermfg=red guifg=blue cterm=underline gui=underline

" Line numbers in terminal
highlight LineNr ctermfg=245
