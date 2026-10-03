
vim.g.mapleader = " "
vim.g.maplocalleader = " "


--KEYMAPS--
require("config.keymaps")

--OPTIONS--
require("config.options")

--COMMANDS--
require("config.autocmd")


--terminal--
require("custom.terminal")

--statusline--
require("custom.statusline")

--lsp--
--require("custom.lsp")


--plugins--
require("ide")




