-- Undo File
if not vim.fn.isdirectory(vim.env.HOME.."/.vim") then
    vim.fn.mkdir(vim.env.HOME.."/.vim", "", 0700)
end
vim.opt.undodir = vim.env.HOME.."/.vim/undo-dir"
vim.opt.undofile = true
