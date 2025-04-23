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
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- Task setup
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
  tasks.run_task({"./build.sh", "--asan"}, "^([^:]+%a):(%d+):(%d+): (%a+): (.+)$")
end, opts)

vim.keymap.set('n', '<leader>K', function()
  save_if_modified()
  tasks.run_task({"./build.sh", "--asan"}, "^([^:]+%a):(%d+):(%d+): (%a+): (.+)$", function()
    vim.cmd('!tmux new-window ./run.sh')
  end)
end, opts)

-- Diagnostics
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

-- Rename
vim.keymap.set('n', '<leader>n', function()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('New file name: ', old_name, 'file')
  if new_name ~= '' and new_name ~= old_name then
    vim.cmd('Move ' .. new_name)
  end
end, { noremap = true, silent = true })

-- Copilot
vim.keymap.set('n', '<leader>d', ':lua vim.diagnostic.setqflist()<CR>', {})

vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
vim.g.copilot_enabled = true

-- Abbreviations
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
