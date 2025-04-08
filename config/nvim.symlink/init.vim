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
" Plug 'haya14busa/incsearch.vim'
" Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'dense-analysis/ale'
Plug 'romainl/vim-qf'
Plug 'wsdjeg/vim-fetch'
" Plug 'github/copilot.vim'
Plug 'echasnovski/mini.nvim'
Plug 'cocopon/inspecthi.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'brenoprata10/nvim-highlight-colors'

Plug 'stevearc/dressing.nvim'

" Plug 'nvim-neo-tree/neo-tree.nvim' " needs nvim-lua/plenary.nvim, nvim-tree/nvim-web-devicons, MunifTanjim/nui.nvim
Plug 'stevearc/oil.nvim'

Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'sindrets/diffview.nvim' " needs nvim-lua/plenary.nvim
Plug 'windwp/nvim-spectre' " needs nvim-lua/plenary.nvim
Plug 'ibhagwan/fzf-lua' " needs nvim-tree/nvim-web-devicons

Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' } " needs nvim-lua/plenary.nvim

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

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'jansedivy/jansedivy-theme'
Plug '~/Documents/scratch/jansedivy-theme'

" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'saghen/blink.cmp', { 'do': 'cargo build --release' }

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
  autocmd BufNewFile,BufRead *.mm setlocal filetype=objc

  autocmd BufNewFile,BufRead *.odin setlocal filetype=odin
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c

  autocmd BufNewFile,BufRead *.usf setfiletype glsl
  autocmd BufNewFile,BufRead *.slang setfiletype hlsl

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

  autocmd BufEnter *.c,*.h,*.m syntax keyword Type u8 u16 u32 u64 s8 s16 s32 s64 f32 f64 v2 v2i str8 string f32x4 u32x4 u16x8 u8x8 u8x16
  autocmd BufEnter *.c,*.h,*.m syntax keyword Operator global internal local_persist Defer

  autocmd BufWritePost *.c,*.cpp,*.h,*.m silent! !/opt/homebrew/bin/ctags src/**/*.{h,c,m} . &

  autocmd Syntax c syn match Number "\<0b[01]\('\=[01]\+\)*\([Uu]\=\([Ll]\|LL\|ll\)\|\([Ll]\|LL\|ll\)\=[Uu]\|i[fl]\=\|h\|min\|s\|ms\|us\|ns\|_\i*\)\=\>"
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
" map <leader>cc :!flow-coverage-report -i % -f "./node_modules/.bin/flow" -t html && open flow-coverage/index.html<cr>
map <leader>f :normal gF<cr>

" open the current file and line number in xcode
map <leader>x :w\|:execute '!xed -l ' . line(".") . ' ' expand("%")<cr><cr>

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
  elseif current_extension == "frag"
    exec ':e ' . current_file . ".vert"
    return
  elseif current_extension == "vert"
    exec ':e ' . current_file . ".frag"
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

require("spectre").setup({
  replace_engine = {
    ["sed"] = {
      cmd = "sed",
      args = {
        "-i",
        "",
        "-E",
      },
    },
  },
})

require('nvim-treesitter.configs').setup({
  ensure_installed = {"c","comment"},
  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})

-- require('treesitter-context').setup({
--   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
--   multiwindow = false, -- Enable multiwindow support.
--   max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
--   min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
--   line_numbers = true,
--   multiline_threshold = 20, -- Maximum number of lines to show for a single context
--   trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
--   mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
--   -- Separator between context and content. Should be a single character string, like '-'.
--   -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
--   separator = nil,
--   zindex = 20, -- The Z-index of the context window
--   on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
-- })

local harpoon = require('harpoon')
harpoon:setup({
  settings = {
    sync_on_ui_close = true,
    save_on_toggle = true,
  }
})

harpoon:extend({
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-c>", function()
      harpoon.ui:close_menu()
    end, { buffer = cx.bufnr })
  end,
})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>g", function() harpoon.ui:toggle_quick_menu(harpoon:list(), {
  title = "",
  border = "rounded",
}) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)

require("oil").setup({
  keymaps = {
    ["<C-c>"] = false,
  },
  cleanup_delay_ms = false,
  buf_options = {
    buflisted = true,
    bufhidden = "hide",
  },
})

vim.keymap.set('n', '<leader>k', function()
  save_if_modified()
  tasks.run_task("./test.sh", "^([^:]+%a):(%d+) ()(.+)$")
end, opts)


vim.keymap.set('n', '<leader>c', function()
  save_if_modified()
  tasks.run_task("./build.sh", "^([^:]+%a):(%d+):%d+: (%a+): (.+)$")
end, opts)

vim.keymap.set('n', '<leader>K', function()
  save_if_modified()
  tasks.run_task("./build.sh", "^([^:]+%a):(%d+):%d+: (%a+): (.+)$", function()
    vim.cmd('!tmux new-window ./run.sh')
  end)
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

local fzf = require('fzf-lua')

require("fzf-lua").setup({
  winopts = {
    backdrop = 90,
    preview = {
      horizontal = "right:40%",
    },
  }
})

vim.keymap.set('n', '<leader>t', function() fzf.files() end, {})

require('mini.cursorword').setup({
  delay = 0,
})

require("nvim-autopairs").setup {}

require('blink.cmp').setup({
  completion = {
    list = { selection = { preselect = false, auto_insert = true } },
  },

  cmdline = {
    enabled = false
  },

  sources = {
    default = { 'path', 'buffer' },

    providers = {
      buffer = {
        name = 'Buffer',
        module = 'blink.cmp.sources.buffer',
        opts = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        }
      },
    },
  },
})

-- local cmp = require('cmp')
-- cmp.setup({
--   mapping = {
--     ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
--     ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
--     ['<C-j>'] = cmp.mapping.confirm({ select = true }),
--   },
--   sources = {
--     {
--       name = 'buffer',
--       option = {
--         keyword_pattern = [[\k\+]],
--         get_bufnrs = function()
--           return vim.api.nvim_list_bufs()
--         end
--       }
--     },
--     { name = 'path' },
--   },
-- })

--vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
  --expr = true,
  --replace_keycodes = false
--})
--vim.g.copilot_no_tab_map = true
--vim.g.copilot_enabled = false

EOF

let g:qf_mapping_ack_style = 1

" let g:python3_host_prog = '/opt/homebrew/bin/python3'
" let g:python_host_prog = '/usr/bin/python2'

let g:go_def_mapping_enabled = 0

""" Ale
set signcolumn=yes
let g:ale_use_neovim_diagnostics_api = 1
let g:ale_sign_column_always = 1
let g:ale_linters = {
      \  'javascript': ['flow_ls', 'eslint'],
      \  'go': ['gopls'],
      \  'c': [],
      \  'objc': [],
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
      \  'objc': [],
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
