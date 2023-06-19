local wk = require('which-key')

vim.o.timeout = true
vim.o.timeoutlen = 300
wk.setup({
--    icons = {
--        breadcrumb = ">>",
--        separator = "->",
--        group = "+",
--    },
    window = {
        border = 'none',
        position = 'bottom',
    },
    layout = {
        align = 'center',
    },
})

local keybinds = {
    w = { "<cmd>update!<cr>", "Save" },
    q = { "<cmd>q!<cr>", "Quit" },
    S = {
        "<cmd>source "..vim.env.HOME.."/.config/nvim/init.lua<cr>",
        "Source",
        silent = false,
    },
    b = {
        name = "Buffer",
        c = { "<cmd>bd!<cr>", "Close current buffer" },
        D = { "<cmd>%bd|e#|bd#<cr>", "Delete all buffers" },
    },
    f = {
        name = "Format",
        w = {
            "<cmd>let _s=@/<Bar>:%s/\\s\\+$//e<Bar><cr><cmd>let @/=_s<Bar><cr>",
            "Remove Trailing Whitespace",
        },
        m = {
            "<cmd>%s/\\r//g<cr>",
            "Remove Carriage-Return (<C-m>)",
        },
    },
    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    d = {
        name = "Diagnostic",
        k = { function() vim.diagnostic.goto_prev() end, "Previous" },
        j = { function() vim.diagnostic.goto_next() end, "Next" },
        f = { function() vim.lsp.buf.code_action() end, "Fix" },
    },
    g = {
        name = "Goto",
        d = { function() vim.lsp.buf.definition() end, "Definition" },
        D = { function() vim.lsp.buf.declaration() end, "Declaration" },
    },
}

-- Module dependent binds
local function isModuleAvailable(name)
    if package.loaded[name] then
        return true
    else
        for _, searcher in ipairs(package.searchers or package.loaders) do
            local loader = searcher(name)
            if type(loader) == 'function' then
                package.preload[name] = loader
                return true
            end
        end
        return false
    end
end

if isModuleAvailable('nvim-tree.api') then
    local ntapi = require('nvim-tree.api')
    keybinds['e'] = {
        name = "Tree",
        e = {
            function()
                ntapi.tree.toggle({ find_file = true, focus = true, })
            end,
            "Explorer",
        },
        r = {
            function()
                ntapi.tree.change_root_to_node(
                    ntapi.tree.get_node_under_cursor() )
            end,
            "Set Root"
        },
        R = { function() ntapi.tree.reload() end, "Reload" },
    }
end

if isModuleAvailable('lspconfig') then
    keybinds['l'] = {
        name = "LSP",
        r = { "<cmd>LspRestart<cr>", "Restart" },
        s = { "<cmd>LspStop<cr>", "Stop" },
        S = { "<cmd>LspStart<cr>", "Start" },
        i = { "<cmd>LspInfo<cr>", "Info" },
    }
end

if isModuleAvailable('trouble') then
    keybinds['d']['t'] = { "<cmd>TroubleToggle<cr>", "Toggle Pane" }
end

if isModuleAvailable('telescope.builtin') then
    local telescope = require('telescope.builtin')
    keybinds['t'] = {
        name = "Telescope",
        f = { function() telescope.find_files() end, "Find Files" },
        g = {
            name = "Grep",
            a = { function() telescope.live_grep() end, "All Files" },
            o = {
                function()
                    telescope.live_grep({
                        grep_open_files = true,
                    })
                end,
                "Open Files"
            },
            c = {
                function() telescope.current_buffer_fuzzy_find() end,
                "Current File"
            },
        },
        s = { function() telescope.spell_suggest() end, "Spell Suggest" },
        r = { function() telescope.resume() end, "Resume" },
        b = { function() telescope.buffers() end, "Buffers" },
        h = { function() telescope.help_tags() end, "Help Tags" },
        c = { function() telescope.colorscheme() end, "Colorschemes" },
        t = { function() telescope.treesitter() end, "Treesitter" },
    }

    -- Should check if module exists
    keybinds['t']['e'] = {
        function()
            require('telescope').extensions.file_browser.file_browser()
        end,
        "Explore"
    }
end

wk.register(keybinds , {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
})
