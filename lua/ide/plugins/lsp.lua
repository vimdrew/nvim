-- lua/ide/plugins/lsp.lua
return {
  order = 60,
  spec = {
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/creativenull/efmls-configs-nvim",
  },
  config = function()
    require("mason").setup({})
    require("ide.lsp")
  end,
}
