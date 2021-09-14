	set nocompatible              " be iMproved, required
	filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdtree'
" Initialize plugin system
call vundle#end()            " required
filetype plugin indent on    " required
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
