--Basic Settings
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.wrap = false -- Don't wrap lines
vim.opt.scrolloff = 15 -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.mouse = "nv"

--Indentation
vim.opt.tabstop = 4 -- Tab width
vim.opt.shiftwidth = 4 -- Indent width
vim.opt.softtabstop = 4 -- Soft tab stop
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto indenting
vim.opt.autoindent = true -- copy indent from current line


--search settings
vim.opt.ignorecase = true -- case insenstive search
vim.opt.smartcase = true -- case sensitive if uppercase in search
vim.opt.hlsearch = false -- dont highlight search results
vim.opt.incsearch = true -- show matches as you type


--visual settings
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.colorcolumn = "100" -- Show column at 100 characters
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching brackets
vim.opt.cmdheight = 1 -- command line height
vim.opt.completeopt = "menuone,noinsert,noselect" --complete options
vim.opt.showmode = false -- dont show mode in command line
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- dont hide markup
vim.opt.concealcursor = "" -- dont height cursor line markup
vim.opt.lazyredraw = true -- dont redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlight limit

--File handling
vim.opt.backup = false -- Dont create backup files
vim.opt.writebackup = false -- dont create backup before writing
vim.opt.swapfile = false -- dont create swapfiles
vim.opt.undofile = true -- persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") --undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- key timeout duration
vim.opt.autoread = true -- auto reload fileschange outside vim
vim.opt.ttimeoutlen = 0 -- key code timeout
vim.opt.autowrite = false -- dont auto save

-- Behavior settings
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- No error bells
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.path:append("**") -- include subdirectories in search
vim.opt.selection = "exclusive" -- Selection behavior
--vim.opt.mouse = " " -- Enable mouse support
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.encoding = "UTF-8" -- Set encoding

-- Cursor settings
vim.opt.guicursor =
  "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Folding settings
vim.opt.foldmethod = "expr" -- Use expression for folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Start with all folds open

-- Split behavior
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right
