return {
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-eunuch' }, -- used for :Rename, :Remove, ...
  { 'tommcdo/vim-exchange' },
  { 'mbbill/undotree' },
  { 'romainl/vim-qf' },
  { 'wsdjeg/vim-fetch' }, -- Open files at specific rows ./file.txt:123
  { 'ryanoasis/vim-devicons' },
  { 'MunifTanjim/nui.nvim' },
  { 'sindrets/diffview.nvim' },

  { 'lewis6991/gitsigns.nvim', opts = {} },

  { 'folke/snacks.nvim', opts = {} },

  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enabled = false
    end,
  },

  {
    'mattn/emmet-vim',
    config = function()
      vim.g.user_emmet_mode = 'i'
    end,
  },

  {
    -- "jansedivy/jansedivy-theme"
    dir = '~/Documents/scratch/jansedivy-theme',

    config = function()
      vim.cmd.colorscheme 'jansedivy'
    end,
  },

  { 'windwp/nvim-autopairs', opts = {} },

  { 'kylechui/nvim-surround', opts = {} },

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.splitjoin').setup()

      require('mini.comment').setup()

      require('mini.align').setup {
        mappings = {
          start = 'ga',
          start_with_preview = 'gA',
        },
      }

      require('mini.cursorword').setup { delay = 0 }

      local hipatterns = require 'mini.hipatterns'

      local function rgb(c)
        c = string.lower(c)
        return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
      end

      local function blend(foreground, alpha, background)
        local bg = rgb(background)
        local fg = rgb(foreground)

        local r = math.floor(math.min(math.max(0, (alpha * fg[1] + ((1 - alpha) * bg[1]))), 255) + 0.5)
        local g = math.floor(math.min(math.max(0, (alpha * fg[2] + ((1 - alpha) * bg[2]))), 255) + 0.5)
        local b = math.floor(math.min(math.max(0, (alpha * fg[3] + ((1 - alpha) * bg[3]))), 255) + 0.5)

        return string.format('#%02x%02x%02x', r, g, b)
      end

      local function u32_hex_color(_, match)
        local background = '#222426'
        local alpha = tonumber(match:sub(9), 16) / 255
        local hex = '#' .. match:sub(3, 8)

        hex = blend(hex, alpha, background)

        return hipatterns.compute_hex_color_group(hex, 'bg')
      end

      local function u32_hex_color_no_alpha(_, match)
        local hex = '#' .. match:sub(3, 8)
        return hipatterns.compute_hex_color_group(hex, 'bg')
      end

      hipatterns.setup {
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
          u32_hex_color = { pattern = '0x%x%x%x%x%x%x%x%x', group = u32_hex_color },
          u32_hex_color_no_alpha = { pattern = '0x%x%x%x%x%x%x', group = u32_hex_color_no_alpha },
        },
      }

      local gen_loader = require('mini.snippets').gen_loader
      require('mini.snippets').setup {
        snippets = {
          gen_loader.from_file '~/.config/nvim/snippets/global.json',
          gen_loader.from_lang(),
        },

        mappings = {
          expand = '<C-\\>',
          jump_next = '<C-j>',
          jump_prev = '<C-k>',
        },
      }
    end,
  },

  {
    'windwp/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local spectre = require 'spectre'

      spectre.setup {
        replace_engine = {
          ['sed'] = {
            cmd = 'sed',
            args = {
              '-i',
              '',
              '-E',
            },
          },
        },
      }

      vim.keymap.set('n', '<leader>R', function()
        require('spectre').open()
      end, { desc = 'Spectre: Open search UI' })

      vim.keymap.set('n', '<leader>rw', function()
        spectre.open_visual { select_word = true }
      end, { desc = 'Spectre: Search current word' })

      vim.keymap.set('n', '<leader>rp', function()
        spectre.open_file_search()
      end, { desc = 'Spectre: Search in current file' })

      vim.keymap.set('v', '<leader>rw', function()
        spectre.open_visual()
      end, { desc = 'Spectre: Search visual selection' })
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'comment' },
        sync_install = false,

        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {
        settings = {
          sync_on_ui_close = true,
          save_on_toggle = true,
        },
      }

      harpoon:extend {
        UI_CREATE = function(cx)
          vim.keymap.set('n', '<C-c>', function()
            harpoon.ui:close_menu()
          end, { buffer = cx.bufnr })
        end,
      }

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<leader>g', function()
        harpoon.ui:toggle_quick_menu(harpoon:list(), {
          title = '',
          border = 'rounded',
        })
      end)

      vim.keymap.set('n', '<leader>1', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<leader>2', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<leader>3', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<leader>4', function()
        harpoon:list():select(4)
      end)
      vim.keymap.set('n', '<leader>5', function()
        harpoon:list():select(5)
      end)
    end,
  },

  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
      local fzf = require 'fzf-lua'

      fzf.setup {
        winopts = {
          backdrop = 90,
          preview = {
            horizontal = 'right:40%',
          },
        },
      }

      vim.keymap.set('n', '<leader>t', function()
        fzf.files()
      end, {})
      vim.keymap.set('n', '<leader>b', function()
        fzf.buffers()
      end, {})
    end,
  },

  {
    'saghen/blink.cmp',
    build = 'cargo build --release',

    opts = {
      completion = {
        list = { selection = { preselect = false, auto_insert = true } },
      },

      cmdline = {
        enabled = false,
      },

      sources = {
        default = { 'lsp', 'path', 'buffer' },

        providers = {
          buffer = {
            name = 'Buffer',
            module = 'blink.cmp.sources.buffer',
            opts = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
        },
      },
    },
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
      require('oil').setup {
        keymaps = {
          ['<C-c>'] = false,
        },
        buf_options = {
          buflisted = true,
          bufhidden = 'hide',
        },
      }

      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
