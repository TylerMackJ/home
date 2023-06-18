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
                        '--global-configs='..format_dur..'pycodestyle',
                        '--aggressive',
                    },
                    stdin = false,
                }
            end
        },
    }
})

vim.cmd [[
augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
augroup END
]]
