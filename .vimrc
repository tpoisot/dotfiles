set nocompatible
set hidden
filetype off
set cursorline
set title
set nomodeline

set ffs=unix,dos,mac

let mapleader = ","

" j and k deal with wrapped lines sanely
nnoremap j gj
nnoremap k gk

" Move across windows

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>l

nnoremap <leader>h <C-w>h
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j

set splitbelow
set splitright

" Faster path completion
inoremap <C-f> <C-x><C-f>

set wildmenu
set wildmode=list:longest
set ignorecase
set smartcase
set ruler
set backspace=indent,eol,start

call plug#begin("~/.vim/plugged")

" Use tpoisot/xr.vim for github version
Plug '~/code/packages/vim/xr.vim'

Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeClose', 'NERDTreeOpen']}
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'scrooloose/nerdcommenter'

Plug 'ervandew/supertab'

Plug 'junegunn/goyo.vim', {'on': ['Goyo']}
Plug 'junegunn/limelight.vim'

Plug 'Townk/vim-autoclose'

Plug 'JuliaLang/julia-vim'

Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-criticmarkup'

Plug 'vim-scripts/Align'
Plug 'dhruvasagar/vim-table-mode'

Plug 'antoyo/vim-licenses'

Plug 'hail2u/vim-css3-syntax', {'for': ['css', 'less']}
Plug 'skammer/vim-css-color', {'for': ['css', 'less']}
Plug 'groenewege/vim-less', {'for': ['less']}

Plug 'wakatime/vim-wakatime'

Plug 'chrisbra/csv.vim', {'for': ['csv']}

Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'

Plug 'yuratomo/w3m.vim'

Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar', {'on': ['TagbarToggle', 'TagbarOpen', 'TagbarClose']}

Plug 'rhysd/vim-clang-format', {'for': ['c']}
Plug 'justmao945/vim-clang', {'for': ['c']}
"Plug 'bbchung/clighter', {'for': ['c']}
Plug 'mrtazz/DoxygenToolkit.vim', {'for': ['c']}

Plug 'gi1242/vim-tex-syntax'

call plug#end()

" NERDTree
nnoremap <leader>f :NERDTreeToggle<CR>
nnoremap <leader>m :NERDTreeClose<cr>:NERDTreeFind<CR>
let g:NERDTreeIgnore=['\.pyc$', '\.DS_Store']
"let g:NERDTreeDirArrowExpandable = '»'
"let g:NERDTreeDirArrowCollapsible = '«'
" NERDTree git markers
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "x",
    \ "Staged"    : "+",
    \ "Untracked" : "~",
    \ "Renamed"   : ">",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "-",
    \ "Dirty"     : "X",
    \ "Clean"     : "O",
    \ "Unknown"   : "?"
    \ }

" Tagbar
nnoremap <leader>t :TagbarToggle<CR>

map <leader>q {!}fmt -w80<CR>}<CR>
set formatoptions+=1 " No one-letter word on line end

nnoremap <leader>i :set list!<cr> " Invisibles

" User normal regexp
nnoremap / /\v
vnoremap / /\v

set scrolloff=3
set display+=lastline
set autoread

" Scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

set noswapfile
set noerrorbells
set visualbell
set nobackup
set nowritebackup
set encoding=utf-8
set termencoding=utf-8
set foldmethod=marker
set number
set updatetime=750
syntax enable
filetype plugin indent on

" Fold by level
nnoremap z1 :set foldlevel=0<cr>
nnoremap z2 :set foldlevel=1<cr>
nnoremap z3 :set foldlevel=2<cr>
nnoremap z4 :set foldlevel=3<cr>
nnoremap z5 :set foldlevel=4<cr>
nnoremap z6 :set foldlevel=5<cr>

set autoindent
set copyindent
set cindent
set softtabstop=4
set tabstop=4
set shiftwidth=4
set shiftround " Indent by multiple of tab length
set expandtab
set smarttab

" Matching brackets
set showmatch
set mat=5 " show for .5 sec

" Development notes
if has("autocmd")
   if v:version > 701
      autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|BUG\)')
      autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|CHANGED\|IDEA\|XXX\|HACK\)')
   endif
endif

" Highlight search
set incsearch
set hlsearch
set ignorecase
set smartcase
" But remove highlights with space
nnoremap <Leader><Space> :noh<CR>

" Select paragraphs when indented
vnoremap < <gv
vnoremap > >gv

" Move lines around
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
vnoremap <C-j> :m+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" Scroll with space bar
nnoremap <Space> <C-F>


" s skips whitespace and puts cursor on next non-whitespace char
map s :call search('\S','ceW')<cr>
" S skips preceding whitespace and puts cursor on last non-whitespace char
map S :call search('\S','bceW')<cr>

" toggle spelling
map <Leader>S :set invspell<cr>

" System clipboard
set clipboard=unnamed
noremap <Leader>p :set paste<CR>
noremap <Leader>P :set paste<CR>

set t_Co=256
set background=light
colorscheme xr


let g:julia_auto_latex_to_unicode = 1
let g:julia_highlight_operators = 1

let g:pandoc#folding#fdc = 0
let g:pandoc#biblio#sources = "bcltg"
let g:pandoc#syntax#codeblocks#embeds#langs = ['python', 'r', 'julia', 'json', 'make', 'sh', 'c']
let g:pandoc#syntax#conceal#cchar_overrides = {
    \"atx": "§",
    \"codelang": "»",
    \"image": "◆",
    \"newline": "¶"}

" Table mode
let g:table_mode_separator="|"
let g:table_mode_corner="|"
let g:table_mode_corner_corner="|"
let g:table_mode_align_char=":"

let g:licenses_authors_name = 'Poisot, Timothée <tim@poisotlab.io>'
let g:licenses_copyright_holders_name = 'Poisot, Timothée <tim@poisotlab.io>'

let g:goyo_width = 82
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_ctermfg = 240
let g:limelight_priority = -1
nnoremap <Leader>g :Goyo<CR>

" Tags
let g:tagbar_type_r = {
   \'ctagstype' : 'r',
   \'kinds' : [
      \ 'f:Functions',
      \ 'g:GlobalVariables',
      \ 'v:FunctionVariables'
   \]
\}

let g:tagbar_type_julia = {
   \'ctagstype' : 'julia',
   \'kinds' : [
      \ 'f:Functions',
      \ 'u:UserFunctions'
   \]
\}

let g:tagbar_type_markdown = {
   \ 'ctagstype' : 'markdown',
   \ 'kinds' : [
      \ 'h:Heading_L1',
      \ 'i:Heading_L2',
      \ 'k:Heading_L3'
   \ ]
\ }


" Doxygen
let g:DoxygenToolkit_authorName="Timothée Poisot"

" Latex things
nmap <Leader>C :w<CR>:silent !latexmk -quiet -pv "%"; latexmk -c "%"<CR><CR>:redraw!<CR>
nmap <Leader>c :w<CR>:silent !latexmk -quiet "%"; latexmk -c "%"<CR><CR>:redraw!<CR>
let g:tex_fold_envs="frame"

" Build
nmap <Leader>b :w<CR>:silent !make<CR><CR>:redraw!<CR>

" Get syntax group
nmap <leader>z :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
