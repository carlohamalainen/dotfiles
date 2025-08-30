-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Diagnostic keybindings (global)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", function() vim.diagnostic.open_float() end)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Basic settings
vim.opt.number = true
-- vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.whichwrap:append("<,>,[,],h,l")  -- h and l wrap to next/previous lines
vim.opt.ignorecase = true  -- Case insensitive search
vim.opt.smartcase = true   -- Unless you type a capital letter

-- Remove trailing whitespace command
vim.keymap.set("n", "<leader>w", [[:%s/\s\+$//e<CR>]], { desc = "Remove trailing whitespace", silent = true })

-- Setup plugins  
require("lazy").setup({
  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "haskell", "lua", "python" },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Setup Mason first
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "hls", "pyright", "ruff" }, -- Haskell Language Server, Python LSP, and Ruff
      })

      -- Setup HLS
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      
      lspconfig.hls.setup({
        filetypes = { "haskell", "lhaskell", "cabal" },
        root_dir = function(filepath)
          return util.root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml")(filepath)
            or util.find_git_ancestor(filepath)
            or vim.fn.getcwd()
        end,
        on_attach = function(client, bufnr)
          vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
          })
          print("HLS attached to buffer " .. bufnr)
        end,
      })

      -- Setup Pyright (Python LSP)
      lspconfig.pyright.setup({
        on_attach = function(client, bufnr)
          print("Pyright attached to buffer " .. bufnr)
        end,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      -- Setup Ruff (Python linter/formatter)
      lspconfig.ruff.setup({
        on_attach = function(client, bufnr)
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
          print("Ruff attached to buffer " .. bufnr)
        end,
      })

      -- LSP keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        end,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
        },
      })
    end,
  },

  -- Light theme similar to GitHub/VS Code
  {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          styles = {
            comments = "NONE",
            keywords = "NONE",
            functions = "NONE",
            variables = "NONE",
          },
        },
      })
      -- vim.cmd.colorscheme("github_light")
      vim.cmd.colorscheme("github_light_colorblind")
    end,
  },

  -- Comment toggling
  -- 
  -- ⏺ Run :Lazy sync to install, then you can use:
  --   - gcc - Toggle comment on current line
  --   - gc in visual mode - Toggle comment on selected lines
  --   - gcap - Comment a paragraph
  --   - gc5j - Comment current line and 5 lines below

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Auto save
  {
    "pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        debounce_delay = 2000, -- saves after 2 seconds of no typing
      })
    end,
  },

  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      -- File searching
      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      
      -- Global text search (like VS Code's Ctrl+Shift+F)
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep (global search)" })
      vim.keymap.set("n", "<C-S-f>", builtin.live_grep, { desc = "Live grep (global search)" })
      
      -- Search current word under cursor
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Search current word" })
      
      -- Other useful searches
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help" })
      vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Search in current buffer" })
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })
      
      -- Configure Telescope
      require("telescope").setup({
        defaults = {
          layout_strategy = "flex",
          layout_config = {
            flex = {
              flip_columns = 120,
            },
          },
        },
      })
    end,
  },

  -- Text alignment plugin
  {
    "junegunn/vim-easy-align",
    config = function()
      -- Define custom delimiters
      vim.g.easy_align_delimiters = {
        ['>'] = { pattern = '->' },
        ['<'] = { pattern = '<-' },
      }
      
      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { desc = "Easy align" })
      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { desc = "Easy align" })
    end,
  },

  -- Trouble for better diagnostics UI
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      -- Keybindings for Trouble v3
      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle diagnostics (Trouble)" })
      -- vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics (Trouble)" })
      -- vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list (Trouble)" })
      -- vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list (Trouble)" })
      -- vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
      -- vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
    end,
  },

  -- Statusline with LSP info
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Custom jujutsu component
      local function jujutsu_status()
        local handle = io.popen('jj log -r @ -T "change_id.short()" --no-graph 2>/dev/null')
        if handle then
          local result = handle:read("*a")
          handle:close()
          if result and result ~= "" then
            return "jj: " .. result:gsub("\n", "")
          end
        end
        return ""
      end

      require("lualine").setup({
        options = {
          theme = "auto",
        },
        sections = {
          lualine_b = { jujutsu_status },
          lualine_c = { "filename" },
          lualine_x = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic", "nvim_lsp" },
              sections = { "error", "warn", "info", "hint" },
              diagnostics_color = {
                error = "DiagnosticError",
                warn = "DiagnosticWarn",
                info = "DiagnosticInfo",
                hint = "DiagnosticHint",
              },
              symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
              colored = true,
              update_in_insert = false,
              always_visible = false,
            },
            "encoding",
            "fileformat",
            "filetype",
          },
        },
      })
    end,
  },
}, {
  install = { 
    missing = true,
    colorscheme = { "catppuccin" },
  },
  checker = { 
    enabled = false,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
})
