-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Save with <C-s>
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Switch to alternate file
map("n", "<leader><leader>", "<C-^>", { desc = "Alternate File" })

-- Duplicate current row
map("n", "<C-d>", "Vyp", { desc = "Duplicate Line" })

-- Map jk to escape
map("i", "jk", "<Esc>", { desc = "Escape" })

-- Move current row one down (in all modes)
map("n", "<C-j>", ":m+<CR>==", { desc = "Move Down" })
map("i", "<C-j>", "<Esc>:m+<CR>==gi", { desc = "Move Down" })
map("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move Down" })

-- Move current row one up (in all modes)
map("n", "<C-k>", ":m-2<CR>==", { desc = "Move Up" })
map("i", "<C-k>", "<Esc>:m-2<CR>==gi", { desc = "Move Up" })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move Up" })

-- Rename current file
function RenameCurrentFile()
  local old_name = vim.fn.expand('%')
  local new_name = vim.fn.input('New name: ' .. old_name)
  if new_name ~= '' and new_name ~= old_name then
    local result = os.rename(old_name, new_name)
    if result == nil then
      vim.api.nvim_err_writeln('Error renaming file')
    else
      vim.api.nvim_command('e ' .. new_name)
      vim.api.nvim_command('delete ' .. old_name)
      vim.api.nvim_out_write('Renamed file from ' .. old_name .. ' to ' .. new_name .. '\n')
    end
  end
end
map("n", "<leader>n", ":lua RenameCurrentFile()<CR>", { desc = "Rename Current File" })

-- Other keybindings will be added in plugin configs (e.g. Telescope)
