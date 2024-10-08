autocmd!

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'junegunn/vim-easy-align'
Plug 'mileszs/ack.vim'
Plug 'windwp/nvim-autopairs'
Plug 'mattn/emmet-vim'
Plug 'tommcdo/vim-exchange'
Plug 'SirVer/ultisnips'
Plug 'nelstrom/vim-visual-star-search'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'dense-analysis/ale'
Plug 'romainl/vim-qf'
Plug 'wsdjeg/vim-fetch'
Plug 'github/copilot.vim'
Plug 'echasnovski/mini.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'cocopon/inspecthi.vim'
Plug 'lewis6991/gitsigns.nvim'

Plug 'nvim-neo-tree/neo-tree.nvim' " needs nvim-lua/plenary.nvim, nvim-tree/nvim-web-devicons, MunifTanjim/nui.nvim

Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'sindrets/diffview.nvim' " needs nvim-lua/plenary.nvim
Plug 'windwp/nvim-spectre' " needs nvim-lua/plenary.nvim
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' } " needs nvim-lua/plenary.nvim
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" syntax
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'
Plug 'othree/html5.vim'
Plug 'nono/vim-handlebars'
Plug 'fatih/vim-go'
Plug 'tikhomirov/vim-glsl'
Plug 'beyondmarc/hlsl.vim'
Plug 'mxw/vim-jsx'
Plug 'jansedivy/jai.vim'
Plug 'Tetralux/odin.vim'
Plug 'jparise/vim-graphql'
Plug 'justinj/vim-pico8-syntax'
Plug 'bfrg/vim-cpp-modern'
Plug 'rhysd/vim-llvm'

" typescript
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'

Plug 'folke/tokyonight.nvim'

" Plug 'jansedivy/jansedivy-theme'
Plug '~/Documents/scratch/jansedivy-theme'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

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

set inccommand=split

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

  autocmd BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufNewFile,BufRead *.widget setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  autocmd BufNewFile,BufRead *.as setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.cocoascript setlocal filetype=javascript

  autocmd BufNewFile,BufRead *.odin setlocal filetype=odin

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

  autocmd BufEnter *.c,*.h syntax keyword Type u8 u16 u32 u64 s8 s16 s32 s64 f32 f64 v2 v2i str8 f32x4 u32x4 u16x8 u8x8 u8x16
  autocmd BufEnter *.c,*.h syntax keyword Operator global internal local_persist Defer

  autocmd BufWritePost *.c,*.cpp,*.h silent! !/opt/homebrew/bin/ctags src/**/*.{h,c} . &
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
color jansedivy

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cinoptions=l1,(2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUSLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set stl=\ %{WebDevIconsGetFileTypeSymbol()}\ %f\ %m\ %r\ Line:%l/%L[%p%%]
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
" map <leader>cn :e ~/notes.md<cr>
map <leader>d '.<cr>
map <leader>n :call RenameFile()<cr>
map <Leader>ra :%s/
map <Leader>s :set spell!<cr>
map <Leader>v :e ~/.config/nvim/init.vim<cr>
map <leader>i :ALEImport<cr>
map <leader>h :ALEHover<cr>
" map <leader>cc :!flow-coverage-report -i % -f "./node_modules/.bin/flow" -t html && open flow-coverage/index.html<cr>
map <leader>f :normal gF<cr>


map <leader>o :silent !open .<cr>

nnoremap <leader>R <cmd>lua require('spectre').open()<CR>

"search current word
nnoremap <leader>rw <cmd>lua require('spectre').open_visual({select_word=true})<CR>
vnoremap <leader>rw <esc>:lua require('spectre').open_visual()<CR>
"  search in current file
nnoremap <leader>rp viw:lua require('spectre').open_file_search()<cr>

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
" Switch to header/implementation file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenAlternativeFile()
  let current_file = expand("%:r")
  let current_extension = expand("%:e")

  if current_extension == "h"
    exec ':e ' . current_file . ".c"
    return
  elseif current_extension == "c"
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:cpp_function_highlight = 1
let g:cpp_member_highlight = 0

lua << EOF
tasks = require('tasks')

local function save_if_modified()
  local buf = vim.api.nvim_get_current_buf()
  local is_modified = vim.api.nvim_buf_get_option(buf, 'modified')

  if is_modified then
    vim.api.nvim_command('write')
  end
end

require("neo-tree").setup({
  filesystem = {
    bind_to_cwd = false,
    hijack_netrw_behavior = "open_current",
  },
})

vim.keymap.set('n', '<leader>K', ':!tmux new-window ./run.sh<CR>', {})

vim.keymap.set('n', '<leader>k', function()
  save_if_modified()
  tasks.run_task("./test.sh", "^([^:]+%.c):(%d+) (.+)$")
end, opts)

vim.keymap.set('n', '<leader>c', function()
  save_if_modified()
  tasks.run_task("./build.sh", "^([^:]+%.c):(%d+):%d+: (.+)$")
end, opts)

vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  },
})

vim.keymap.set('n', '<leader>n', function()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('New file name: ', old_name, 'file')
  if new_name ~= '' and new_name ~= old_name then
    vim.cmd('Move ' .. new_name)
  end
end, { noremap = true, silent = true })

require('gitsigns').setup()

local hipatterns = require('mini.hipatterns')

local function rgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

function blend(foreground, alpha, background)
  local bg = rgb(background)
  local fg = rgb(foreground)

  local r = math.floor(math.min(math.max(0, (alpha * fg[1] + ((1 - alpha) * bg[1]))), 255) + 0.5)
  local g = math.floor(math.min(math.max(0, (alpha * fg[2] + ((1 - alpha) * bg[2]))), 255) + 0.5)
  local b = math.floor(math.min(math.max(0, (alpha * fg[3] + ((1 - alpha) * bg[3]))), 255) + 0.5)

  return string.format("#%02x%02x%02x", r, g, b)
end

function u32_hex_color(_, match)
  background = "#222426"
  alpha = tonumber(match:sub(9), 16) / 255
  hex = "#" .. match:sub(3, 8)

  hex = blend(hex, alpha, background);

  return hipatterns.compute_hex_color_group(hex, 'bg')
end

hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
    u32_hex_color = { pattern = "0x%x%x%x%x%x%x%x%x", group = u32_hex_color },
  },
})

vim.keymap.set('n', '<leader>d', ':lua vim.diagnostic.setqflist()<CR>', {})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>t', builtin.find_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}
require('telescope').load_extension('fzf')

require('mini.cursorword').setup({
  delay = 0,
})

require("nvim-autopairs").setup {}

local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
  },
  sources = {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'ultisnips' },
  },
})

vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

EOF

let g:qf_mapping_ack_style = 1

let g:python3_host_prog = '/opt/homebrew/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

let g:go_def_mapping_enabled = 0

""" Ale
set signcolumn=yes
let g:ale_use_neovim_diagnostics_api = 1
let g:ale_sign_column_always = 1
let g:ale_linters = {
      \  'javascript': ['flow_ls', 'eslint'],
      \  'go': ['gopls'],
      \  'c': [],
      \  'cpp': [],
      \  'h': [],
      \ }

let g:ale_c_cc_executable = '/opt/homebrew/opt/llvm/bin/clang'
let g:ale_c_clangcheck_executable = '/opt/homebrew/opt/llvm/bin/clang-check'
" let g:ale_c_build_dir = 'build'
" let g:ale_c_always_make = 0

let g:ale_go_golangci_lint_package = 1

let g:ale_fixers = {
      \  'javascript': ['prettier', 'eslint'],
      \  'c': [],
      \  'cpp': [],
      \  'h': []
      \ }

let g:ale_fix_on_save = 1
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
" nmap <silent> <C-]> <Plug>(ale_go_to_definition)
"""


let g:UltiSnipsExpandTrigger="<C-\\>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

let g:netrw_liststyle=3

let g:typescript_compiler_binary = GetNpmBin('tsc')

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:user_emmet_mode='i'

let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" let g:go_fmt_command = "goimports"
" let g:go_gopls_enabled = 0
" let g:go_def_mode = 'godef'

" let g:ackprg = 'rg --vimgrep --no-heading --ignore-case'
" set grepprg=rg\ --vimgrep

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
