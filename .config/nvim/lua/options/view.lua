-- Colorscheme
vim.cmd [[ set background=dark ]]
vim.cmd [[ colorscheme carbonfox ]]

-- Line numbering
vim.opt.number = true

-- 80 Char limit
local colorcolumn_augroup = vim.api.nvim_create_augroup('ColorColumnAutogroup',
                                                        { clear = true })
local colorcolumn_pairs = {
    { pattern = '*', colorcolumn = '80' },
    { pattern = 'startup', colorcolumn = '' },
    { pattern = 'lua', colorcolumn = '120' },
}
for _, item in ipairs(colorcolumn_pairs) do
    vim.api.nvim_create_autocmd('FileType', {
        desc = item.pattern..' colorcolumn = '..item.colorcolumn,
        pattern = item.pattern,
        group = colorcolumn_augroup,
        callback = function() vim.opt.colorcolumn = item.colorcolumn end,
    })
end

-- Top and bottom padding
vim.opt.scrolloff = 5
