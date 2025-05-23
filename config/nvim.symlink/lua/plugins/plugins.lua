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

  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
  --       expr = true,
  --       replace_keycodes = false
  --     })
  --     vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_enabled = false
  --   end
  -- },

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

{
    'neovim/nvim-lspconfig',

    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },

    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            return client:supports_method(method, bufnr)
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        rust_analyzer = {},

        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
