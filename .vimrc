" Vundle:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" vim +PluginInstall +qall
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'luochen1990/rainbow'
Plugin 'andreasvc/vim-256noir'
Plugin 'ghifarit53/tokyonight-vim'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'airblade/vim-gitgutter'
call vundle#end()          "required
filetype plugin indent on  "required

syntax on
set number
set tabstop=4
set shiftwidth=4
set autoindent
set shortmess+=I
set autochdir
set noswapfile
set nobackup
set noundofile
set showmatch
set expandtab
set laststatus=2
set noshowmode
"set cursorcolumn
set cursorline
set incsearch
set showmatch
set ignorecase
set smartcase
set encoding=utf-8
set relativenumber
set belloff=all
"set mouse=a

let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

"colorscheme 256_noir
"TokyoNight
set termguicolors

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight
"TokyoNight
let g:lightline = {
        "\ 'colorscheme': 'seoul256',
        "\ 'colorscheme': 'powerlineish',
        \ 'colorscheme': 'tokyonight',
        \ 'separator': {'left': "\ue0b0", 'right': "\ue0b2"},
        \ 'subseparator': { 'left': '\ue0b1', 'right': '\ue0b3'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
        \   'gitbranch': 'MyFugitiveHead'
        \ },
        \ }

let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

autocmd! bufreadpost * set noexpandtab | retab! 4
autocmd! bufwritepre * set expandtab | retab! 4
autocmd! bufwritepost * set noexpandtab | retab! 4

if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"vim-table-mode
let g:table_mode_corner_corner='|'

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" Git Gutter
highlight GitGutterAdd    ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
set signcolumn=yes

" Strict whitspace
set list
set listchars=tab:>-,trail:•,extends:>,precedes:<
" Optional: Highlight trailing whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

autocmd FileType c,cpp,java,php,python,javascript,markdown,vim autocmd BufWritePre <buffer> :%s/\s\+$//e

" Pressing <Leader>md will open a vertical split on the right and run leaf
nnoremap <Leader>md :vertical botright terminal leaf -w %<CR>

" Pressing <Leader>dt will show differences of the two files
function! ToggleDiff()
    if &diff
        windo diffoff
    else
        windo diffthis
    endif
endfunction

nnoremap <Leader>dt :call ToggleDiff()<CR>
