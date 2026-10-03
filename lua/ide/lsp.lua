local augroup = vim.api.nvim_create_augroup("LspConfig", { clear = true })

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "\u{f057}",
			[vim.diagnostic.severity.WARN] = "\u{f071}",
			[vim.diagnostic.severity.INFO] = "\u{f05a}",
			[vim.diagnostic.severity.HINT] = "\u{ea61}",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup,
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end
		local fzf = require("fzf-lua")
		local function map(lhs, fn, desc)
			vim.keymap.set("n", lhs, fn, { buffer = ev.buf, silent = true, desc = desc })
		end

		map("gd", function()
			fzf.lsp_definitions({ jump1 = true })
		end, "Definition")
		map("gD", vim.lsp.buf.declaration, "Declaration")
		map("gS", function()
			vim.cmd("vsplit")
			vim.lsp.buf.definition()
		end, "Definition in split")
		map("K", vim.lsp.buf.hover, "Hover")
		map("<leader>rn", vim.lsp.buf.rename, "Rename")
		map("<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("<leader>fr", fzf.lsp_references, "References")
		map("<leader>fi", fzf.lsp_implementations, "Implementations")
		map("<leader>ft", fzf.lsp_typedefs, "Type definitions")
		map("<leader>fs", fzf.lsp_document_symbols, "Document symbols")
		map("<leader>fw", fzf.lsp_live_workspace_symbols, "Workspace symbols")
		map("<leader>d", function()
			vim.diagnostic.open_float({ scope = "cursor" })
		end, "Cursor diagnostics")
		map("<leader>D", function()
			vim.diagnostic.open_float({ scope = "line" })
		end, "Line diagnostics")
		map("]d", function()
			vim.diagnostic.jump({ count = 1 })
		end, "Next diagnostic")
		map("[d", function()
			vim.diagnostic.jump({ count = -1 })
		end, "Prev diagnostic")
		map("<leader>q", function()
			vim.diagnostic.setloclist({ open = true })
		end, "Diagnostics list")

		if client:supports_method("textDocument/formatting", ev.buf) then
			map("<leader>F", function()
				vim.lsp.buf.format({ bufnr = ev.buf })
			end, "Format")
		end
		if client:supports_method("textDocument/inlayHint", ev.buf) then
			map("<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
			end, "Toggle inlay hints")
		end
	end,
})

-- blink capabilities for every server
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

-- efm: linters/formatters (binaries must be installed)
local ef = function(m)
	return require("efmls-configs." .. m)
end
vim.lsp.config("efm", {
	filetypes = {
		"lua",
		"python",
		"sh",
		"go",
		"c",
		"cpp",
		"javascript",
		"typescript",
		"json",
		"css",
		"html",
		"markdown",
	},
	init_options = { documentFormatting = true },
	settings = {
		languages = {
			lua = { ef("linters.luacheck"), ef("formatters.stylua") },
			python = { ef("linters.ruff"), ef("formatters.ruff") },
			sh = { ef("linters.shellcheck"), ef("formatters.shfmt") },
			go = { ef("linters.go_revive"), ef("formatters.gofumpt") },
			c = { ef("linters.cpplint"), ef("formatters.clang_format") },
			cpp = { ef("linters.cpplint"), ef("formatters.clang_format") },
			javascript = { ef("linters.eslint_d"), ef("formatters.prettier_d") },
			typescript = { ef("linters.eslint_d"), ef("formatters.prettier_d") },
			json = { ef("formatters.fixjson") },
			css = { ef("formatters.prettier_d") },
			html = { ef("formatters.prettier_d") },
			markdown = { ef("formatters.prettier_d") },
		},
	},
})

vim.lsp.enable({
	"cssls",
	"lua_ls",
	"emmet_language_server",
	"pyright",
	"bashls",
	"ts_ls",
	"gopls",
	"clangd",
	"omnisharp",
	"efm",
})
