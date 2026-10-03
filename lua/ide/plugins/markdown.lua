return {
  spec = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  config = function()
    require("render-markdown").setup({
      heading = {
        sign = false,
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      bullet = { enabled = true },
      checkbox = {
        enabled = true,
        position = "inline",
        unchecked = { icon = "   󰄱 ", highlight = "RenderMarkdownUnchecked" },
        checked = { icon = "   󰱒 ", highlight = "RenderMarkdownChecked" },
      },
    })
  end,
}
