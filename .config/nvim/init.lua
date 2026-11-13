require("config.lazy")

vim.keymap.set("n", "<leader>nh", function()
  vim.cmd("botright vsplit | vertical resize 60 | terminal ollama run qwen2.5-coder:1.5b")
  vim.cmd("startinsert")
end, { desc = "Open Neovim AI Helper" })

vim.opt.undofile = true

