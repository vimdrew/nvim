return {
  spec = "https://github.com/ibhagwan/fzf-lua",
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({})
    local map = function(k, f, d) vim.keymap.set("n", k, f, { desc = d }) end
    map("<leader>ff", fzf.files, "FZF Files")
    map("<leader>fg", fzf.live_grep, "FZF Live Grep")
    map("<leader>fb", fzf.buffers, "FZF Buffers")
    map("<leader>fh", fzf.help_tags, "FZF Help Tags")
    map("<leader>fx", fzf.diagnostics_document, "FZF Diagnostics Document")
    map("<leader>fX", fzf.diagnostics_workspace, "FZF Diagnostics Workspace")
  end,
}
