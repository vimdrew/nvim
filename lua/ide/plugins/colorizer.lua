return {
  spec = "https://github.com/catgoose/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      filetypes = {
        "html", "css", "javascript", "typescript",
        "javascriptreact", "typescriptreact", "vue", "svelte",
      },
      options = {
        parsers = {
          tailwind = { enable = true },
        },
      },
    })
  end,
}
