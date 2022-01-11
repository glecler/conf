set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'voldikss/vim-floaterm'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'pechorin/any-jump.vim'
" Initialize plugin system

call plug#end()
" autocmd vimenter * NERDTree

colorscheme gruvbox

autocmd vimenter * AirlineTheme gruvbox
highlight Normal ctermbg=Black
highlight NonText ctermbg=Black

set background=dark
set number
set mouse=a
set ts=4
set shiftwidth=4
syntax on
let g:floaterm_keymap_toggle = '<F12>'
nnoremap <C-m> :NERDTreeFocus<CR>
nnoremap <C-l> :NERDTreeToggle<CR>
let mapleader = ","
