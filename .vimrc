" Let's setup Vundle and load the plugins we have installed
" (.vimrc/bundle/pluginName)
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'preservim/nerdtree'
call vundle#end()            " required
filetype plugin indent on    " required

" Some config to NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 35

" enable syntax highlighting
syntax enable
" show line numbers
set number
" set tabs to have 4 spaces
set ts=4
" indent when moving to the next line while writing code
set autoindent
" expand tabs into spaces
set expandtab
" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4
" show a visual line under the cursor's current line
set cursorline
" show the matching part of the pair for [] {} and ()
set showmatch
" Highligt all searh results
set hlsearch
" Case insensitive search
set ignorecase
" enable all Python syntax highlighting features
let python_highlight_all = 1
set mouse=v

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Using persistent sudo. We'll be able to use undo and redo 
" even if we exit the file we were modifying :)
if has('persistent_undo')
    silent !mkdir ~/.vim_undo_files > /dev/null 2>&1
    " Save all undo files in a single location (less messy, more risky)...
    set undodir=$HOME/.vim_undo_files
    " Save a lot of back-history...
    set undolevels=5000
    " Actually switch on persistent undo
    set undofile
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Execute the actual file opened with vim.
" It checks if we are using one of the following:
"   - python | python3
"   - bash | sh
" And it will execute the file with the respective executable
" It will run using Alt+F9
filetype detect
let file_type = &ft

if file_type == 'python'
    if executable('python3')
        let executable_program = 'python3'
    elseif executable('python')
        let executable_program = 'python'
    endif
elseif file_type == 'sh'
    let executable_program = 'bash'
endif

if exists("g:executable_program")
    execute "nnoremap <F9> <Esc>:w<CR>:! " . executable_program . " %<CR>"
else
    nnoremap <F9> <Esc>:echoerr 'Executable not found to run this file!'<CR>
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
