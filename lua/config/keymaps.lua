--KEYMAPS--



vim.keymap.set("n", "n", "nzzzv")

vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n","Y","y$",{desc ="Yank to the end of the line"})

vim.keymap.set("n", "<leader>so", "<Cmd>source %<CR>", {desc = "Shortcut for sourcing"})

vim.keymap.set("n", "-","<Cmd>Ex<CR>",{desc ="Shortcut to open explorer"})

vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>w", "<Cmd>update<CR>")

vim.keymap.set("n", "<leader>q", "<Cmd>quit<CR>")


vim.keymap.set("n", "<leader>Q", "<cmd>wqa<cr>")

vim.keymap.set("n", "L", "$",{desc = "Jump to end of line"})

vim.keymap.set("n","<leader>bn",":bnext<CR>",{desc ="Next Buffer"})
vim.keymap.set("n","<leader>bp",":bprevious<CR>",{desc ="Previous Buffer"})



vim.keymap.set("n","<leader>sv",":vsplit<CR>",{desc ="Apply a vertical split"})
vim.keymap.set("n","<leader>sh",":split<CR>",{desc ="Apply a horizontal split"})
vim.keymap.set("n","<C-Up>",":resize +2<CR>",{desc ="Increase vertical size"})
vim.keymap.set("n","<C-Down>",":resize -2<CR>",{desc ="Decrease vertical size"})

vim.keymap.set("n","<C-left>",":vertical resize +2<CR>",{desc ="Increase horizontal size"})
vim.keymap.set("n","<C-right>",":vertical resize -2<CR>",{desc ="Decrease horizontal size"})


vim.keymap.set("n","<C-h>","<C-w>h",{desc ="Move a window left"})
vim.keymap.set("n","<C-j>","<C-w>j",{desc ="Move a window down"})
vim.keymap.set("n","<C-k>","<C-w>k",{desc ="Move a window up"})
vim.keymap.set("n","<C-l>","<C-w>l",{desc ="Move a window right"})



vim.keymap.set("n","<A-j>",":m .+1<CR>==",{desc ="move line down"})
vim.keymap.set("n","<A-k>",":m .-2<CR>==",{desc ="move line up"})
vim.keymap.set("v","<A-k>",":m '<-2<CR>gv=gv",{desc ="move selection up"})
vim.keymap.set("v","<A-j>",":m '>+1<CR>gv=gv",{desc ="move selection down"})


vim.keymap.set("v","<","<gv",{desc ="indent left"})
vim.keymap.set("v",">",">gv",{desc ="indent right"})


--
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], {desc= "delete without putting in clipboard"})

vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>", { desc = "Clear search hl", silent = true })

vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word cursor is on globally" })

vim.keymap.set("n","<leader>ff",":find ",{desc = "Find file"})


-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
  local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
  vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
  print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
end, { desc = "Copy file path to clipboard" })

vim.keymap.set("n", "<leader>rc",":e ~/.config/nvim/init.lua<CR>", {desc= "Edit config"})

