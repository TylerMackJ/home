local util = require('formatter.util')

local format_dir = vim.env.HOME..'/.config/nvim/lua/setup/formatting/'

require('formatter').setup({
    logging = true,
    filetype = {
        cpp = {
            require('formatter.filetypes.cpp').clangformat,
            function()
                return {
                    exe = 'clang-format',
                    args = {
                        '-style=file:'..format_dir..'.clang-format'
                    },
                    stdin = true,
                }
            end
        },
        python = {
            require('formatter.filetypes.python').autopep8,
            function()
                return {
                    exe = 'autopep8',
                    args = {
                        '--global-configs='..format_dir..'pycodestyle',
                        '--aggressive',
                    },
                    stdin = false,
                }
            end
        },
    }
})

vim.api.nvim_create_autocmd('BufWritePost', {
    desc = 'Format on write',
    pattern = '*',
    group = vim.api.nvim_create_augroup('FormatAutogroup', { clear = true }),
    callback = function() vim.cmd [[FormatWrite]] end,
})
