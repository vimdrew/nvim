return {
  spec = {
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/folke/todo-comments.nvim",
  },
  config = function()
    local todo = require("todo-comments")

    todo.setup({
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        FORGETNOT = { icon = " ", color = "hint" },
      },
      highlight = {
        multiline = true,
        multiline_pattern = "^.",
        multiline_context = 10,
        before = "",
        keyword = "wide",
        after = "fg",
        pattern = {
          [[.*<(KEYWORDS)\s*:]],
          [[<!--\s*(KEYWORDS)\s*:.*-->]],
          [[<!--\s*(KEYWORDS)\s*.*-->]],
        },
        comments_only = false,
      },
    })

    vim.keymap.set("n", "]t", todo.jump_next, { desc = "Next todo comment" })
    vim.keymap.set("n", "[t", todo.jump_prev, { desc = "Previous todo comment" })
    vim.keymap.set("n", "<leader>fT", "<cmd>TodoFzfLua<cr>", { desc = "Find todos" })
  end,
}
