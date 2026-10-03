
local augroup = vim.api.nvim_create_augroup("UserConfig",{})

--highlight when yanking--
vim.api.nvim_create_autocmd("TextYankPost",{
    group = augroup,
    callback = function()
    vim.highlight.on_yank()
end,
})



--auto-close term when exiting process--
vim.api.nvim_create_autocmd("TermClose",{
    group = augroup,
    callback = function()
        if vim.v.event.status == 0 then
            vim.api.nvim_buf_delete(0,{})
        end
    end,
})

--resize on window resize--
vim.api.nvim_create_autocmd("VimResized",{
    group = augroup,
    callback = function()
            vim.cmd("tabdo wincmd =")
    end,
})


vim.opt.wildmenu =true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({"*.o","*.obj","*.pyc","*.class","*.jar"})
vim.opt.diffopt:append("linematch:60")


vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000


--create undo dir -- 
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir,"p")
end


-- create/ delete oil --
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    local function refresh()
      vim.api.nvim_feedkeys(vim.keycode("<C-l>"), "m", false)
    end

    vim.keymap.set("n", "o", function()
      local name = vim.fn.input("Create: ")
      if name == "" then return end

      local is_dir = name:sub(-1) == "/"
      local clean = name:gsub("/+$", "")
      if clean == "" then return end

      local path = vim.b.netrw_curdir .. "/" .. clean
      local stat = vim.uv.fs_stat(path)
      if stat then
        vim.notify(clean .. " already exists as a " .. stat.type, vim.log.levels.WARN)
        return
      end

      local ok, err = pcall(function()
        if is_dir then
          vim.fn.mkdir(path, "p")
        else
          vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
          if vim.fn.writefile({}, path) == -1 then
            error("could not write " .. clean)
          end
        end
      end)
      if not ok then
        vim.notify(tostring(err), vim.log.levels.ERROR)
        return
      end

      refresh()
    end, { buffer = true, silent = true })

    vim.keymap.set("n", "d", function()
      local name = vim.fn.getline("."):gsub("/$", "")
      if name == "" or name == "." or name == ".." then return end

      local path = vim.b.netrw_curdir .. "/" .. name
      local stat = vim.uv.fs_lstat(path)
      if not stat then
        vim.notify(name .. " not found", vim.log.levels.WARN)
        return
      end

      local label = stat.type == "directory" and (name .. "/ and everything in it") or name
      if vim.fn.confirm("Delete " .. label .. "?", "&Yes\n&No", 2) ~= 1 then return end

      local flags = stat.type == "directory" and "rf" or ""
      if vim.fn.delete(path, flags) ~= 0 then
        vim.notify("could not delete " .. name, vim.log.levels.ERROR)
        return
      end

      refresh()
    end, { buffer = true, silent = true })
  end,
})

























