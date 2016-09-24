set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'Keithbsmiley/swift.vim'
Plug 'airblade/vim-gitgutter'
Plug 'dag/vim-fish'
Plug 'kchmck/vim-coffee-script'
Plug 'kylef/apiblueprint.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle','NERDTreeFind'] }
Plug 'scrooloose/syntastic'
Plug 'sjl/vitality.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

call plug#end()

nnoremap <Leader>p :Files<cr>
nnoremap <Leader>t :NERDTreeToggle<cr>
nnoremap <Leader>j :NERDTreeFind<cr>

set hidden " Handle multiple buffers better

" Interface
color jellybeans
set number " Show line numbers
set showmode " Show the mode in use
set cursorline " Highlight current line
set wrap " Turn on line wrapping
"set textwidth=79 " Force wrap at 79 characters
set colorcolumn=80 " Show a column at 80
set title " Set the terminal title
set visualbell " Disable beeping
set mouse=a
set shortmess=Ia " Disable start up message and abbreviate items

" Show indication of newlines and trailing spaces
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,trail:▝
set list

" Status Bar
set laststatus=2 " Always show status bar
" Highlight the status bar when in insert mode
au InsertEnter * hi StatusLine ctermfg=235 ctermbg=10
au InsertLeave * hi StatusLine ctermfg=15 ctermbg=240

" Search
set hlsearch " Highlight all search matches
set incsearch " Highlight matches as you type
set ignorecase
set smartcase " Be case-sensitive if expression contains a capital letter

" Backup
set nobackup
set nowritebackup
set directory=$HOME/.vim/tmp//,. " Keep swap files in one place

" Formatting
set tabstop=4 " Use 4 spaces to a tab
set shiftwidth=4 " As above
set expandtab " Expand tabs into spaces
set showbreak=↪

" Completion
set complete=.,w,b,u,t,i
set completeopt=menu
set wildmenu                                           " Better completion in the CLI
set wildmode=longest:full,full                         " Completion settings
set wildignore+=*/venv/*

" Files
autocmd FileType cpp set noexpandtab
autocmd FileType gitcommit setlocal spell textwidth=72
autocmd FileType markdown setlocal spell textwidth=79
autocmd FileType apiblueprint setlocal spell textwidth=79

" Copy copy register to OS X general pasteboard
function! PBCopy()
  call system("pbcopy", getreg(""))
endfunction

" Paste from OS X general pasteboard to copy register
function! PBPaste()
  call setreg("", system("pbpaste"))
endfunction

" By the power of https://github.com/sjl/vitality.vim, copies and pastes
" to the OS X pasteboard when switching between vim and other windows
" (even in tmux)
autocmd FocusLost * :call PBCopy()
autocmd FocusGained * :call PBPaste()

" Yeah... these get typoed
command W w
command Q q
command Wq wq
command WQ wq

" Wordcount
command! Wc :w !wc

" autocmd BufWritePre * :%s/\s\+$//e

" Syntastic
let g:syntastic_python_flake8_args="--max-complexity 10"

if &shell =~# 'fish$'
  set shell=bash
endif

" Podspecs ------ {{{
augroup ft_podspec
  autocmd!
  autocmd BufNewFile,BufRead,BufWrite *.podspec setlocal filetype=podspec
  autocmd BufNewFile,BufRead Podfile setlocal filetype=podfile
  autocmd FileType podspec,podfile set syntax=ruby
  autocmd FileType podspec set makeprg=pod\ spec\ lint\ %
  autocmd FileType podfile set makeprg=pod\ install
augroup END
" }}}
