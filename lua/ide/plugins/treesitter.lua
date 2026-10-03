-- runs at require time, before vim.pack.add, which PackChanged needs
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local d = ev.data
    if d.spec.name == "nvim-treesitter" and (d.kind == "install" or d.kind == "update") then
      if not d.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end,
})

return {
  spec = {
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({})

    local ensure = {
      "vim","markdown_inline", "vimdoc", "rust", "c", "cpp", "c_sharp", "go", "html", "css",
      "javascript", "json", "lua", "markdown", "python", "typescript", "bash",
    }
    local config = require("nvim-treesitter.config")
    local have = config.get_installed()
    local missing = vim.tbl_filter(function(p) return not vim.tbl_contains(have, p) end, ensure)
    if #missing > 0 then ts.install(missing) end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang and vim.list_contains(config.get_installed(), lang) then
          vim.treesitter.start(args.buf)
        end
      end,
    })

    require("ts_context_commentstring").setup({ enable_autocmd = false })
  end,
}
