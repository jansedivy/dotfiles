autocmd!

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
" Plug 'scrooloose/syntastic'
Plug 'junegunn/vim-easy-align'
Plug 'rking/ag.vim'
Plug 'Raimondi/delimitMate'
Plug 'mattn/emmet-vim'
Plug 'tommcdo/vim-exchange'
Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'nelstrom/vim-visual-star-search'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'OmniSharp/omnisharp-vim', { 'for': 'cs' }
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'unblevable/quick-scope'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'craigemery/vim-autotag'
Plug 'neomake/neomake'

" syntax
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'
Plug 'kchmck/vim-coffee-script'
Plug '~/Documents/scratch/vim-coffee-script'
Plug 'groenewege/vim-less'
Plug 'othree/html5.vim'
Plug 'digitaltoad/vim-jade'
Plug 'nono/vim-handlebars'
Plug 'leafgarland/typescript-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'wting/rust.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'dag/vim2hs'
Plug 'fatih/vim-go'
Plug 'tikhomirov/vim-glsl'
Plug 'mxw/vim-jsx'
Plug 'davidhalter/jedi-vim'
Plug 'gotcha/vimpdb'
Plug 'jansedivy/jai.vim'
Plug 'petRUShka/vim-opencl'
Plug 'keith/swift.vim'
Plug 'flowtype/vim-flow'

Plug 'mhartington/oceanic-next'
Plug 'jansedivy/vim-hybrid', { 'branch': '471b235' }
Plug 'atelierbram/vim-colors_atelier-schemes'
Plug 'jdkanani/vim-material-theme'
Plug 'chriskempson/base16-vim'
Plug 'whatyouhide/vim-gotham'
Plug 'jacoborus/tender.vim'
Plug 'joshdick/onedark.vim'

call plug#end()

runtime macros/matchit.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set history=10000

set autoindent
set smartindent
set smarttab

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set laststatus=2
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set mouse=
set encoding=utf-8 nobomb
scriptencoding utf-8
set cmdheight=1
set switchbuf=useopen
set numberwidth=3
set showtabline=1
set winwidth=81
set relativenumber
set shell=zsh
set nojoinspaces
set shortmess=atI
set lazyredraw
set showcmd
set title
set cursorline
set virtualedit=block
set nowrap

set exrc
set secure

set modeline
set modelines=3

set cpoptions+=$
set vb

set noswapfile
set nobackup
set nowb

set undofile
set undodir=~/.config/nvim/undos
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

set synmaxcol=256

set backspace=indent,eol,start
syntax on
filetype plugin indent on
let g:mapleader=","

set wildmenu
set wildignore=*.o,*.obj,*~
set wildignore+=*.gem
set wildignore+=*vim/backups*
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.pyc

" System clipboard
set clipboard=unnamed
set autoread
set list listchars=tab:▸⋅,trail:⋅,nbsp:⋅
let &showbreak = '↳ '

set notimeout
set ttimeout
set ttimeoutlen=10

" When at 3 spaces and I hit >>, go to 4, not 5.
set shiftround
" Get rid of the delay when hitting esc!
set noesckeys
set gdefault

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

set foldmethod=manual
" set nofoldenable

" highlight colorcolumn ctermbg=magenta
" call matchadd('colorcolumn', '\%81v', 100)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et
  autocmd FileType qf set nowrap

  autocmd BufWritePost,BufEnter *.js,*.coffee,*.go Neomake

  autocmd BufRead,BufNewFile *.sass setfiletype sass

  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  autocmd BufNewFile,BufRead *.as setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.cocoascript setlocal filetype=javascript

  autocmd BufNewFile,BufRead *.usf setfiletype glsl

  autocmd Filetype gitcommit setlocal spell textwidth=72

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  autocmd WinEnter * set cursorline
  autocmd WinLeave * set nocursorline

  autocmd FocusGained * set cursorline
  autocmd FocusLost * set nocursorline
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_co=256
" set t_ut=
 " let $NVIM_TUI_ENABLE_TRUE_COLOR=1
 " colorscheme OceanicNext
 " set background=dark
let g:hybrid_use_iTerm_colors = 1
color hybrid

" colorscheme onedark

" Fix contrast for search highlight color
hi Search cterm=NONE ctermfg=8 ctermbg=3

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUSLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]

hi StatusLine ctermfg=235 ctermbg=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap ; :

nnoremap gV `[V`]

command! W :w
command! Q :q
command! Qall :qall

" Disable Q and K keys
map Q <Nop>
map K <nop>

vmap D y'>p

nmap j gj
nmap k gk

map Y y$

map <leader>q :!spot-selecta<cr><cr>
map <leader>l :!gl3<cr><cr>

" Sudo to write
cnoremap w!! w !sudo tee "%" >/dev/null

map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
imap <c-c> <esc>

imap <c-e> <c-o>$
imap <c-a> <c-o>^

function! MapCR()
  map <cr> :nohlsearch<cr>
endfunction
call MapCR()

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap <silent> # :let stay_star_view = winsaveview()<cr>#:call winrestview(stay_star_view)<cr>
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

map <c-k> :w\|:let stay_star_view = winsaveview()<cr>:%!clang-format %<cr>:call winrestview(stay_star_view)<cr>


" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

map <leader><leader> <c-^>
map <leader>w :normal ma<cr>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>:normal 'a<cr>
map <leader>e :edit %%
map <leader>n :call RenameFile()<cr>
map <Leader>ra :%s/
map <Leader>s :set spell!<cr>
map <Leader>v :e ~/.config/nvim/init.vim<cr>
" map <leader>k :!vmd %&<cr><cr>

map <leader>o :silent !open .<cr>

map <leader>cn :e ~/Dropbox\ \(Personal\)/coding-notes.markdown<cr>

map <leader>i :GoImports<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction

inoremap <expr> <tab> InsertTabWrapper()
inoremap <expr> <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <expr> %% expand('%:h').'/'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        let old_alt = expand('#')
        exec ':saveas ' . new_name
        let @# = old_alt
        exec ':bd ' . bufnr(old_name)
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch to header/implementatino file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenAlternativeFile()
  let new_file = AlternativeForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternativeForCurrentFile()
  let current_file = expand("%:r")
  let current_extension = expand("%:e")

  if current_extension == "h"
    return current_file . ".cpp"
  elseif current_extension == "cpp"
    return current_file . ".h"
  endif

  return expand("%")
endfunction

nnoremap <leader>. :call OpenAlternativeFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Selecta config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | hs " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  " Saves current location in jumplist
  execute "normal " . line(".") . "G" . col(".") . "|"
  exec a:vim_command . " " . selection
endfunction

let filter = ' | grep -v "node_modules/"
      \ | grep -v "libs/"
      \ | grep -v "build/"
      \ | grep -v "CMakeScripts/"
      \ | grep -v "^dist/"
      \ | grep -v "^vim/vim.symlink/backups/"
      \ | grep -v "^vim/vim.symlink/bundle/"
      \ | grep -v "bower_components/"
      \ | grep -v "cache/"
      \ | grep -v ".git/"
      \ | grep -v ".gitignore"
      \ | grep -v "tmp/"
      \ | grep -v "deps/"
      \ | grep -v "^CMakeFiles/"
      \ | grep -v "CMakeCache.txt"
      \ | grep -v "cmake_install.cmake"
      \ | grep -v "^_build/"
      \ | grep -v "^ENV/"
      \ | grep -v "^env/"
      \ | grep -v "^venv/"
      \ | grep -v "bundle.min.js"
      \ | grep -v ".xcodeproj/"
      \ | grep -v ".dSYM/"
      \ | grep -i -v -w ".*\.\(otf\|ogg\|gz\|pyc\|rdb\|pdf\|eot\|ttf\|svg\|woff\|gif\|dds\|png\|wav\|jpg\|sqlite3\|psd\|ai\|ico\|DS_Store\|.gitkeep\|o\)$"'

let command = 'find * -type f ' . g:filter

function! SelectaFile(path)
  call SelectaCommand(g:command . " | grep " . a:path, "", ":e")
endfunction

function! SelectaApps()
  try
    let selection = system("find $(find apps -depth 1 -type d | hs) -type f " . g:filter . " | hs")
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec ":e " . selection
endfunction

map <leader>t :FZF<cr>
map <leader>b :Buffers<cr>


" imap <c-x><c-k> <plug>(fzf-complete-word)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<C-\\>"
let g:UltiSnipsJumpForwardTrigger="<C-n>"
let g:UltiSnipsJumpBackwardTrigger="<C-p>"

let g:netrw_liststyle=3

" let g:syntastic_mode_map = {
"   \ 'mode': 'active',
"   \ 'active_filetypes': [],
"   \ 'passive_filetypes': ['html', 'xml']
"   \ }

" let g:syntastic_aggregate_errors = 1
" let g:syntastic_always_populate_loc_list = 1

" let g:syntastic_cpp_compiler = 'clang++'
" let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wno-int-to-void-pointer-cast'
" let g:syntastic_cpp_include_dirs = ['./libs/assimp/include', './libs/glew/include', './libs/jemalloc/include', './libs/glm', './libs/stb', './libs/perlin', './libs/vcache', './libs/base']

" let g:syntastic_python_checkers=['flake8']
" let g:syntastic_python_flake8_args='--ignore=E501'
" " let g:syntastic_css_checkers=['stylelint']
" let g:syntastic_go_checkers = ['go', 'govet', 'golint']

" " let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" let g:syntastic_python_python_exec = '/usr/local/bin/python3'

let g:neomake_javascript_enabled_makers = ['eslint', 'flow']
let g:neomake_jsx_enabled_makers = ['eslint', 'flow']
let g:neomake_go_enabled_makers = ['go', 'govet', 'golint']

let g:neomake_coffee_enabled_makers = ['coffeelint']

let g:neomake_error_sign = {'text': '●', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '◎', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:user_emmet_mode='i'

let g:jsx_ext_required = 0

let g:javascript_plugin_flow = 1
let g:flow#enable = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
abbr tihs this
abbr htis this
abbr thsi this
abbr vra var
abbr funciton function
abbr functino function
abbr reutrn return
abbr heigth height
abbr ligth light

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "0"
let g:jedi#goto_command = "<c-]>"


nmap <leader>z :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
