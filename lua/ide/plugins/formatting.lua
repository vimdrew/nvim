return {
  spec = "https://github.com/stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "biome-check" },
        typescript = { "biome-check" },
        javascriptreact = { "biome-check" },
        typescriptreact = { "biome-check" },
        css = { "prettier" },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettier" },
        yaml = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        python = { "ruff_format" },
        markdown = { "prettier", "markdown-toc" },
      },
      formatters = {
        prettier = {
          prepend_args = { "--tab-width", "4", "--use-tabs", "false" },
        },
        shfmt = { prepend_args = { "-i", "4" } },
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then return true end
            end
            return false
          end,
        },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({ lsp_format = "fallback", async = false, timeout_ms = 1000 })
    end, { desc = "Format file or range" })
  end,
}
