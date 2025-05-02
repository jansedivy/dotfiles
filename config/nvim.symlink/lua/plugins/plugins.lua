return {
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-eunuch" }, -- used for :Rename, :Remove, ...
  { "tommcdo/vim-exchange" },
  { "mbbill/undotree" },
  { "romainl/vim-qf" },
  { "wsdjeg/vim-fetch" }, -- Open files at specific rows ./file.txt:123
  { "ryanoasis/vim-devicons" },
  { "MunifTanjim/nui.nvim" },
  { "sindrets/diffview.nvim" },

  { "lewis6991/gitsigns.nvim", opts = {} },

  { "folke/snacks.nvim", opts = {} },

  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enabled = true
    end
  },

  {
    "SirVer/ultisnips",
    config = function()
      vim.g.UltiSnipsExpandTrigger = "<C-\\>"
      vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
    end
  },

  {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_mode = 'i'
    end
  },

  {
    -- "jansedivy/jansedivy-theme"
    dir = "~/Documents/scratch/jansedivy-theme",

    config = function()
      vim.cmd.colorscheme 'jansedivy'
    end
  },

  { "windwp/nvim-autopairs", opts = {} },

  { "kylechui/nvim-surround", opts = {} },

  {
    "echasnovski/mini.nvim",
    config = function()
      require('mini.splitjoin').setup()

      require('mini.comment').setup()

      require('mini.align').setup({
        mappings = {
          start = "ga",
          start_with_preview = 'gA',
        },
      })

      require('mini.cursorword').setup({ delay = 0 })

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
    end
  },

  {
    "windwp/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local spectre = require('spectre')

      spectre.setup({
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

      vim.keymap.set("n", "<leader>R", function()
        require("spectre").open()
      end, { desc = "Spectre: Open search UI" })

      vim.keymap.set("n", "<leader>rw", function()
        spectre.open_visual({ select_word = true })
      end, { desc = "Spectre: Search current word" })

      vim.keymap.set("n", "<leader>rp", function()
        spectre.open_file_search()
      end, { desc = "Spectre: Search in current file" })

      vim.keymap.set("v", "<leader>rw", function()
        spectre.open_visual()
      end, { desc = "Spectre: Search visual selection" })
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {"c","comment"},
        sync_install = false,

        auto_install = true,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
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
    end
  },

  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      local fzf = require('fzf-lua')

      fzf.setup({
        winopts = {
          backdrop = 90,
          preview = {
            horizontal = "right:40%",
          },
        }
      })

      vim.keymap.set('n', '<leader>t', function() fzf.files() end, {})
      vim.keymap.set('n', '<leader>b', function() fzf.buffers() end, {})
    end
  },

  {
    "saghen/blink.cmp",
    build = "cargo build --release",

    opts = {
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
    }
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
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

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },
}
