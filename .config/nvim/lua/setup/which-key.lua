local wk = require('which-key')

vim.o.timeout = true
vim.o.timeoutlen = 300
wk.setup({
    window = {
        border = 'single',
        position = 'bottom',
    },
})

wk.register({
    w = { "<cmd>update!<cr>", "Save" },
    q = { "<cmd>q!<cr>", "Quit" },
    b = {
        name = "Buffer",
        c = { "<cmd>bd!<cr>", "Close current buffer" },
        D = { "<cmd>%bd|e#|bd#<cr>", "Delete all buffers" },
    },
    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
}, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})
