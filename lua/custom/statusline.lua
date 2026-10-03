-- lua/custom/statusline.lua
local M = {}

vim.o.showmode = false

local modes = {
  n = { "NORMAL", "SlNormal" },
  i = { "INSERT", "SlInsert" },
  v = { "VISUAL", "SlVisual" },
  V = { "V-LINE", "SlVisual" },
  ["\22"] = { "V-BLOCK", "SlVisual" },
  c = { "COMMAND", "SlCommand" },
  R = { "REPLACE", "SlCommand" },
  s = { "SELECT", "SlInsert" },
  t = { "TERMINAL", "SlCommand" },
}

local glyphs = {
  lua = 0xF08B1, python = 0xe606, javascript = 0xe74e, typescript = 0xe628,
  rust = 0xe7a8, go = 0xe627, c = 0xe61e, cpp = 0xe61d,
  sh = 0xe795, bash = 0xe795, zsh = 0xe795,
  json = 0xe60b, yaml = 0xe6a8, toml = 0xe6b2,
  markdown = 0xe73e, html = 0xe736, css = 0xe749,
  vim = 0xe62b, gitcommit = 0xe702, terminal = 0xf120,
}

local default_glyph = 0xf15b

local function set_hls()
  local function fg_of(name)
    return vim.api.nvim_get_hl(0, { name = name, link = false }).fg
  end
  local dark = "#111111"
  vim.api.nvim_set_hl(0, "SlNormal", { bg = fg_of("Function"), fg = dark, bold = true })
  vim.api.nvim_set_hl(0, "SlInsert", { bg = fg_of("String"), fg = dark, bold = true })
  vim.api.nvim_set_hl(0, "SlVisual", { bg = fg_of("Statement"), fg = dark, bold = true })
  vim.api.nvim_set_hl(0, "SlCommand", { bg = fg_of("Constant"), fg = dark, bold = true })
  vim.api.nvim_set_hl(0, "SlDim", { link = "Comment" })
end
set_hls()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hls })

local branch = ""
local function update_branch()
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then branch = "" return end
  vim.system({ "git", "-C", dir, "branch", "--show-current" }, { text = true }, function(r)
    branch = r.code == 0 and vim.trim(r.stdout) or ""
    vim.schedule(function() vim.cmd.redrawstatus() end)
  end)
end
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "DirChanged" }, { callback = update_branch })

local function diagnostics()
  local c = vim.diagnostic.count(0)
  local S = vim.diagnostic.severity
  local out = {}
  for _, d in ipairs({
    { S.ERROR, "E", "DiagnosticError" },
    { S.WARN, "W", "DiagnosticWarn" },
    { S.INFO, "I", "DiagnosticInfo" },
    { S.HINT, "H", "DiagnosticHint" },
  }) do
    if c[d[1]] then
      table.insert(out, string.format("%%#%s#%s%d", d[3], d[2], c[d[1]]))
    end
  end
  return table.concat(out, " ")
end

local function filetype()
  local ft = vim.bo.filetype
  if ft == "" then return "no ft" end
  return vim.fn.nr2char(glyphs[ft] or default_glyph) .. " " .. ft
end

function M.render()
  local m = modes[vim.api.nvim_get_mode().mode:sub(1, 1)] or { "UNKNOWN", "SlNormal" }

  return table.concat({
    string.format("%%#%s# %s ", m[2], m[1]),
    "%#StatusLine#  ",
    branch ~= "" and ("%#SlDim#" .. branch .. "  ") or "",
    "%#StatusLine#%f %m%r",
    "%=",
    diagnostics(),
    "  %#SlDim#" .. filetype(),
    "  %#StatusLine#%l:%c %p%% ",
  })
end

vim.o.statusline = "%!v:lua.require'custom.statusline'.render()"

return M
