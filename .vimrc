call pathogen#infect()

filetype on
filetype plugin on
filetype indent on

set history=10000
set autoread
set nocompatible
set ruler
set number
set hidden
set shortmess=atI
set cursorline
set cursorcolumn
set notitle
set paste
set lazyredraw
set scrolloff=4
set background=dark
set cmdheight=2
set laststatus=2

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set wildmenu
set wildmode=list:longest,full

set ignorecase
set smartcase
set hlsearch
set incsearch
set magic
set showmatch
set matchtime=2

set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

set nobackup
set nowritebackup
set noswapfile

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab

set autoindent
set smartindent

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

syntax enable

" Select appropriate color scheme for graphics
if &t_Co >= 256 || has("gui_running")
    colorscheme jarvis
else
    colorscheme noctu
endif

" Status Setup
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
set statusline+=%-40f\                    " path
set statusline+=%=%1*%y%*%*\              " file type
set statusline+=%10((%l,%c)%)\            " line and column
set statusline+=%P                        " percentage of file

function! RestoreCursor()
  if line ("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>

let mapleader=","

map <leader>d :call <SID>DiffWithDisk()<CR>
map <leader>m :silent! :make \| :redraw! \| :botright :cw<CR>
map <leader>t :TagbarToggle<CR>

nmap <leader>w :%s/\s\+$//<CR>:let @/=''<CR>
nmap <leader>v V`]
nmap <leader><space> :let @/=''<CR>
nmap <leader>vb :ls<CR>:vert sb<space>
nmap <leader>hb :ls<CR>:sb<space>

cabbrev w!! w !sudo tee % > /dev/null

let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkyellow',  'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['brown',       'firebrick3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['yellow',      'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['red',         'firebrick3'],
        \ ]

" autocmd BufWinEnter * call RestoreCursor()
autocmd BufReadPost *.java DetectIndent
autocmd BufNewFile,BufRead *.json set ft=javascript

