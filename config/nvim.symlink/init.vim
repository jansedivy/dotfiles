autocmd!

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/vim-easy-align'
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'tommcdo/vim-exchange'
Plug 'SirVer/ultisnips'
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'nelstrom/vim-visual-star-search'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'unblevable/quick-scope'
Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'neomake/neomake'

" syntax
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'
Plug 'groenewege/vim-less'
Plug 'othree/html5.vim'
Plug 'nono/vim-handlebars'
Plug 'elixir-lang/vim-elixir'
Plug 'wting/rust.vim'
Plug 'fatih/vim-go'
Plug 'tikhomirov/vim-glsl'
Plug 'beyondmarc/hlsl.vim'
Plug 'mxw/vim-jsx'
Plug 'jansedivy/jai.vim'
Plug 'keith/swift.vim'
Plug 'flowtype/vim-flow'
Plug 'ernstvanderlinden/vim-coldfusion'
Plug 'jparise/vim-graphql'
Plug 'justinj/vim-pico8-syntax'

" typescript
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['typescript'] }

Plug 'jansedivy/vim-hybrid', { 'branch': '471b235' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}}

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
set inccommand=nosplit
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
" set relativenumber
set shell=zsh
set nojoinspaces
set shortmess=atI
set lazyredraw
set showcmd
set title
set cursorline
set virtualedit=block
set wrap

set exrc
set secure

set modeline
set modelines=3

set cpoptions+=$
set vb

set noswapfile
set nobackup
set nowritebackup

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
set gdefault

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

set foldmethod=manual

let g:loaded_sql_completion = 0
let g:omni_sql_no_default_maps = 1

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
  autocmd FileType python,sql set sw=4 sts=4 et
  autocmd FileType qf set nowrap

  " autocmd BufWritePost,BufEnter *.js,*.coffee,*.go Neomake

  autocmd BufRead,BufNewFile *.sass setfiletype sass

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

  autocmd FileType eoz setlocal noexpandtab

  autocmd Bufread,BufNewFile *.cfm set filetype=eoz
  autocmd Bufread,BufNewFile *.cfc set filetype=eoz
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_co=256
let g:hybrid_use_iTerm_colors = 1
color hybrid

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

" nmap j gj
" nmap k gk

map Y y$

map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
imap <c-c> <esc>

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

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

map <leader><leader> :b#<cr>
map <leader>w :normal ma<cr>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>:normal 'a<cr>
map <leader>e :edit %%
map <leader>n :call RenameFile()<cr>
map <Leader>ra :%s/
map <Leader>s :set spell!<cr>
map <Leader>v :e ~/.config/nvim/init.vim<cr>

map <leader>o :silent !open .<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <expr> %% expand('%:h').'/'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NPM LOCAL PATH
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GetNpmBin(binname)
  let dir = getcwd()
  while ! isdirectory(dir . '/node_modules')
    let dir = fnamemodify(dir, ':h')
    if dir == '/'
      break
    end
  endwhile

  let binpath = ''
  if dir != '/'
    let binpath = dir . '/node_modules/.bin/' . a:binname
    if ! filereadable(binpath)
      let binpath = ''
    end
  endif

  return binpath
endfunction

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
  let current_file = expand("%:r")
  let current_extension = expand("%:e")

  if current_extension == "h"
    exec ':e ' . current_file . ".cpp"
    return
  elseif current_extension == "cpp"
    exec ':e ' . current_file . ".h"
    return
  elseif current_extension == "js"
    exec ':e ' . current_file . ".test.js"
    return
  elseif current_extension == "go"
    exec ':GoAlternate!'
    return
  endif

  exec ':e' . expand("%")
endfunction

nnoremap <leader>. :call OpenAlternativeFile()<cr>
map <leader>t :FZF<cr>
" map <leader>kr :call fzf#run({'sink': 'e', 'down': '40%', 'source': 'rg --files --hidden --follow --glob "!__test__" src/graphql/resolvers'})<cr>
" map <leader>km :call fzf#run({'sink': 'e', 'down': '40%', 'source': 'rg --files --hidden --follow --glob "!__test__" src/data/models'})<cr>
map <leader>b :Buffers<cr>

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
    function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

let g:deoplete#enable_at_startup = 1

let g:UltiSnipsExpandTrigger="<C-\\>"
let g:UltiSnipsJumpForwardTrigger="<C-n>"
let g:UltiSnipsJumpBackwardTrigger="<C-p>"

let g:netrw_liststyle=3

let g:typescript_compiler_binary = GetNpmBin('tsc')

call neomake#configure#automake('w')

let g:neomake_javascript_flow_exe = GetNpmBin('flow')
let g:neomake_javascript_eslint_exe = GetNpmBin('eslint')

let g:neomake_javascript_enabled_makers = ['flow', 'eslint']
" let g:neomake_jsx_enabled_makers = ['flow']
let g:neomake_go_enabled_makers = ['go', 'govet', 'golint']

let g:neomake_coffee_enabled_makers = ['coffeelint']

let g:neomake_error_sign = {'text': '●', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text': '◎', 'texthl': 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:user_emmet_mode='i'

let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

let g:flow#enable = 0
let g:flow#flowpath = GetNpmBin('flow')

let g:go_fmt_command = "goimports"
let g:go_def_mode = 'godef'

let g:ackprg = 'rg --vimgrep --no-heading --ignore-case'

set grepprg=rg\ --vimgrep
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

let g:fzf_layout = { 'down': '40%' }

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

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
abbr hightlight highlight
abbr enitty entity
abbr enityt entity
abbr enity entity
abbr rigth right
abbr assing assign
