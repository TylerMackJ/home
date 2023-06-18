-- Add additional capabilities supported by nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities
-- offered by nvim-cmp
local servers = { 'pylsp', 'denols', }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
    }
end

require('clangd_extensions').setup({
    extensions = {
        inlay_hints = {
            only_current_line = true,
            only_current_line_autocmd = "CursorMoved",
        },
    },
})
