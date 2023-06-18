require('trouble').setup({
    icons = false,
    mode = "document_diagnostics",
    indent_lines = true,
    auto_open = true,
    auto_close = true,
    signs = {
        error = "E",
        warning = "W",
        hint = "H",
        information = "I",
    },
    use_diagnostic_signs = false,
})
