return {
    {
      "stevearc/conform.nvim",
      -- event = 'BufWritePre', -- uncomment for format on save
      config = function()
        require "configs.conform"
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      event = "VeryLazy",
      dependencies = "mfussenegger/nvim-dap",
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      event = "VeryLazy",
      dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
      },
      opts = {
        handlers = {}
      },
    },
    {
      "mfussenegger/nvim-dap",
      config = function(_, _)
        
      end
    },
    {
      "nvimtools/none-ls.nvim",
      event = "VeryLazy",
      opts = function()
        return require "configs.null-ls"
      end,
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        require "nvchad.configs.lspconfig"
        require "configs.lspconfig"
      end,
    },
    {
      "williamboman/mason.nvim",
    },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        auto_install = true,
      },
    },
  }

