return {
	spec = "https://github.com/olrtg/nvim-emmet",
	config = function()
		vim.keymap.set({ "n", "v" }, "<leader>xe", function()
			require("nvim-emmet").wrap_with_abbreviation()
		end, { desc = "Emmet wrap with abbreviation" })
	end,
}
