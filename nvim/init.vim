filetype plugin indent on
set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set encoding=UTF-8
set autoindent
set laststatus=2
set mouse+=a
set paste

call plug#begin('~/.vim/plugged')

" The visual plugin
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
Plug 'glepnir/dashboard-nvim'
Plug 'vim-airline/vim-airline'
Plug 'folke/trouble.nvim'
Plug 'norcalli/nvim-colorizer.lua'
let g:dashboard_default_executive = 'telescope'

" Archive Manage
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim'

" Autocomplete experience in Nvim
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'Pocco81/AutoSave.nvim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'j+son', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
Plug 'github/copilot.vim'

" Autocomplete and Tips Code
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'sirver/ultisnips'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" Nvim TreeSitter

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'

" Show error hints and highlights
Plug 'vim-syntastic/syntastic'

" Rust Plugin
Plug 'simrat39/rust-tools.nvim'
Plug 'rust-lang/rust.vim'

" The power of Git
Plug 'tpope/vim-fugitive'

call plug#end()

" Theme Config
set termguicolors
colorscheme dracula

" Shortcuts
let mapleader = " "
let g:user_emmet_leader_key= ","

nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<cr>
nnoremap <leader>pc :NERDTreeClose<CR>
nnoremap <leader>pn :NERDTree<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>p :Prettier<CR>

" Code in Lua

" Colorizer Plugin
lua require'colorizer'.setup()

let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }

" Autosave

lua << EOF
local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)
EOF

" Trouble Plugin

lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

" Nvim TreeSitter

lua << EOF
    require('nvim-treesitter.configs').setup {

        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        }

    }
EOF
