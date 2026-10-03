return {
  spec = "https://github.com/stevearc/oil.nvim",
  config = function()
    require("oil").setup({
      default_file_explorer = true, -- oil instead of netrw
      columns = {},
      keymaps = {
        ["<C-h>"] = false,
        ["<C-c>"] = false, -- <C-c> is your esc key
        ["<M-h>"] = "actions.select_split",
        ["q"] = "actions.close",
      },
      delete_to_trash = true,
      view_options = { show_hidden = true },
      skip_confirm_for_simple_edits = true,
    })

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Oil float" })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "oil",
      callback = function()
        vim.opt_local.cursorline = true
      end,
    })
  end,
}
