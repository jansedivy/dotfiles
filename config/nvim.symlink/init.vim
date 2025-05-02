autocmd!

lua << EOF
---------------------------------------
-- Basic settings
---------------------------------------

vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.opt.mouse = 'a'
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

---------------------------------------
-- Task setup
---------------------------------------
tasks = require('tasks')

local function save_if_modified()
  local buf = vim.api.nvim_get_current_buf()
  local is_modified = vim.api.nvim_buf_get_option(buf, 'modified')

  if is_modified then
    vim.api.nvim_command('write')
  end
end

vim.keymap.set('n', '<leader>k', function()
  save_if_modified()
  tasks.run_task({"./build.sh", "--test"}, "^([^:]+%a):(%d+) ()(.+)$")
end, opts)

vim.keymap.set('n', '<leader>c', function()
  save_if_modified()
  tasks.run_task({"./build.sh", "--asan", "--build", "MacOS"}, "^([^:]+%a):(%d+):(%d+): (%a+): (.+)$")
end, opts)

vim.keymap.set('n', '<leader>K', function()
  save_if_modified()
  tasks.run_task({"./build.sh", "--asan"}, "^([^:]+%a):(%d+):(%d+): (%a+): (.+)$", function()
    vim.cmd('!tmux new-window ./run.sh')
  end)
end, opts)

---------------------------------------
-- Diagnostics
---------------------------------------
vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next() end, opts)

vim.diagnostic.config({
  virtual_lines = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  },
})

---------------------------------------
-- Rename
---------------------------------------
vim.keymap.set('n', '<leader>n', function()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('New file name: ', old_name, 'file')
  if new_name ~= '' and new_name ~= old_name then
    vim.cmd('Move ' .. new_name)
  end
end, { noremap = true, silent = true })

---------------------------------------
-- Abbreviations
---------------------------------------
vim.cmd([[
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
]])

---------------------------------------
-- Lazy.nvim setup
---------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = false },
  change_detection = { enabled = false },
})
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
set switchbuf=useopen
set numberwidth=3
set showtabline=1
set shell=zsh
set nojoinspaces
set shortmess=atI
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

set synmaxcol=256

set backspace=indent,eol,start
syntax on
filetype plugin indent on

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

set autoread
set list listchars=tab:▸⋅,trail:⋅,nbsp:⋅
let &showbreak = '↳ '

set notimeout
set ttimeout
set ttimeoutlen=10

" When at 3 spaces and I hit >>, go to 4, not 5.
set shiftround
set gdefault

set foldmethod=manual

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

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

  autocmd BufWritePost *.c,*.cpp,*.h,*.m silent! !/opt/homebrew/bin/ctags src/**/*.{h,c,m} . &
augroup END

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
map Q <nop>
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

nnoremap <silent> # :let stay_star_view = winsaveview()<cr>#:call winrestview(stay_star_view)<cr>
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

map <leader><leader> :b#<cr>
map <leader>w :normal ma<cr>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>:normal 'a<cr>
map <leader>e :edit %%
map <leader>d '.<cr>
map <leader>ra :%s/
map <leader>s :set spell!<cr>
map <leader>v :e ~/.config/nvim/init.vim<cr>
map <leader>f :normal gF<cr>
map <leader>` vipga\

" open the current file and line number in xcode
map <leader>x :w\|:execute '!xed -l ' . line(".") . ' ' expand("%")<cr><cr>

map <leader>o :silent !open .<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <expr> %% expand('%:h').'/'

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
