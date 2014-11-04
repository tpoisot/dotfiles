set nocompatible
set hidden
filetype off
set cursorline

" Replace <Leader> with ,
let mapleader = ","

" SPLITS "{{{
nnoremap <leader>sh :sp<CR>
nnoremap <leader>sv :vsp<CR>
nnoremap <leader><down> <C-w>j
nnoremap <leader><up> <C-w>k
nnoremap <leader><left> <C-w>h
nnoremap <leader><right> <C-w>l
nnoremap <leader>sH <C-w>|
nnoremap <leader>sW <C-w>_
nnoremap <leader>sr <C-w>=
set splitbelow
set splitright
"}}}

source $HOME/.vimtokens

" Limelight integration to Goyo
function! GoyoBefore()
   Limelight
endfunction

function! GoyoAfter()
   Limelight!
endfunction

let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]
let g:limelight_conceal_ctermfg = 15

nnoremap <leader>V :Goyo<CR>
nnoremap <leader>L :Limelight!!<CR>

" View whitespace
nnoremap <leader>l :set list!<CR>
set listchars=tab:»\ ,eol:¬

" Better auto-completion of options
set wildmenu
set wildmode=list:longest

" Ignorecase when searching with /, keep case when searching with *
set ignorecase
set smartcase

" Stop highlighting search matches
nmap <silent> <leader>h :silent :nohlsearch<CR>

" Scroll faster
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
set ruler

" Intuitive backspacing in insert mode
set backspace=indent,eol,start


" PLUGINS "{{{
call plug#begin('~/.vim/plugged')

" follow VCS changes in the left gutter
Plug 'mhinz/vim-signify'
" Fugitive
Plug 'tpope/vim-fugitive'
" GitHub issues
Plug 'jaxbot/github-issues.vim'
" JSON syntax
Plug 'elzr/vim-json'
" distraction-free with <leader>V
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-pandoc/vim-pandoc'
" less syntax
Plug 'groenewege/vim-less'
" scss syntax
Plug 'tpope/vim-haml'
" CSS colors
Plug 'ap/vim-css-color'
" better javascript syntax
Plug 'pangloss/vim-javascript'
" (un)comment with <leader>c(u/c)
Plug 'scrooloose/nerdcommenter'
" use tab for auto-completion
Plug 'ervandew/supertab'
" Neocomplete
Plug 'Shougo/neocomplete.vim'
" Add END after begin
Plug 'tpope/vim-endwise'
" Surround
Plug 'tpope/vim-surround'
" Liquid markup
Plug 'tpope/vim-liquid'
" ipython
Plug 'ivanov/vim-ipython'
" julia
Plug 'JuliaLang/julia-vim'
" Autoclose brackets
Plug 'Townk/vim-autoclose'
" Theme
Plug '~/code/xr.vim'
" Ctags
Plug 'majutsushi/tagbar'
" NERD Tree with git support
Plug 'Xuyuanp/git-nerdtree'
" LaTeX
Plug 'lervag/vim-latex'
" Create gists
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
" Passive voice
Plug 'jamestomasino/vim-writingsyntax'
" Wordy
Plug 'reedes/vim-wordy'
" Marks with m.
Plug 'kshenoy/vim-signature'
" Graphviz
Plug 'wannesm/wmgraphviz.vim'
call plug#end()
"}}}

" python
let python_highlight_all = 1
let python_highlight_indent_errors = 1
let python_highlight_space_errors = 1

" NERDTree
nnoremap <leader>f :NERDTreeToggle<CR>

" tagbar
nnoremap <leader>t :TagbarToggle<CR>

"Liquid
let g:liquid_highlight_types = ['ruby', 'vim', 'python', 'r', 'json', 'c', 'julia']


"SuperTab!
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
"let g:SuperTabDefaultCompletionType = "context"

" NeoComplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
nnoremap <leader>ne :NeoCompleteEnable<CR>
nnoremap <leader>nd :NeoCompleteDisable<CR>
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" <leader>k Knits to MD
nnoremap <leader>k :! Rscript -e "library(knitr);knit(input='%', output='%:r.md');"<CR>

"The cursor is never on the last line
set scrolloff=3

"Search is not highlighted
"set nohlsearch

"Files are read as soon as they are changed
set autoread

"Various general options
set noswapfile
set noerrorbells
set visualbell
set nobackup
set nowritebackup
set encoding=utf-8
set foldmethod=marker

"Line numbers and syntax
set number "Line numbers
syntax enable "Syntax coloration
filetype plugin indent on

set t_Co=256

set background=light
colorscheme xr

" Rainbow delimiters
"let g:rainbow_active = 0



" WRITING bindings "{{{

" Passive voice and such
nnoremap <leader>P :setf writing<CR>

" Rmd and Rpres are pandoc
au BufRead,BufNewFile *.Rmd,*.Rpres setfiletype pandoc

" Format paragraphs with <leader>q
map <leader>q {!}fmt -w 80<CR>}<CR>

" Place markers with {type} for markdown files
augroup markers
   autocmd! BufEnter *.md,*.mkd,*.txt,*.Rmd,*.Rpres match Error '{{\w\+}}'
augroup END
nnoremap <leader>{{ :vimgrep /{\w\+}}/ %<CR>:copen<CR>
"}}}



" PANDOC options "{{{

let g:pandoc#folding#fdc = 0
let g:pandoc#biblio#sources = "bcltg"
let g:pandoc#synatx#codeblock#embeds#langs = ['ruby', 'vim', 'python', 'r', 'json', 'c', 'julia', 'make', 'sh', 'latex']

"}}}



" INDENTATION "{{{
set autoindent
set cindent
set softtabstop=3
set tabstop=3
set shiftwidth=3
set expandtab
set smarttab
" Select blocks after indenting
vnoremap < <gv
vnoremap > >gv
"}}}

map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

" GitHub access token
let g:github_upstream_issues = 1

" tagbar markdown
let g:tagbar_type_pandoc = {
    \ 'ctagstype': 'pandoc',
    \ 'ctagsbin' : '~/.scripts/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

" tagbar r
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }

" Gist options
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_api_url = 'https://api.github.com/'

let g:signify_sign_add               = '+'
let g:signify_sign_change            = '~'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '^'


" Julia
let g:julia_auto_latex_to_unicode = 1
let g:julia_highlight_operators = 1
