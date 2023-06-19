local format_dir = vim.env.HOME..'/.config/nvim/lua/setup/formatting/'

local custom_pylint_severities = {
  error = vim.diagnostic.severity.ERROR,
  fatal = vim.diagnostic.severity.ERROR,
  warning = vim.diagnostic.severity.WARN,
  refactor = vim.diagnostic.severity.INFO,
  info = vim.diagnostic.severity.INFO,
  convention = vim.diagnostic.severity.HINT,
}

require('lint').linters.custom_pylint = {
  cmd = 'pylint',
  stdin = false,
  args = { '-f', 'json', },
  ignore_exitcode = true,
  parser = function(output, bufnr)
    local diagnostics = {}
    local buffer_path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":~:.")

    for _, item in ipairs(vim.json.decode(output) or {}) do
      if not item.path or vim.fn.fnamemodify(item.path, ":~:.") == buffer_path then
        local column = item.column > 0 and item.column or 0
        local end_column = item.endColumn ~= vim.NIL and item.endColumn or column
        table.insert(diagnostics, {
          source = 'pylint',
          lnum = item.line - 1,
          col = column,
          end_lnum = item.line - 1,
          end_col = end_column,
          severity = assert(custom_pylint_severities[item.type], 'missing mapping for severity ' .. item.type),
          message = item.message,
          code = item['message-id'],
          user_data = {
            lsp = {
              code = item['message-id'],
            },
          },
        })
      end
    end
    return diagnostics
  end,
}


local custom_luacheck_pattern = '[^:]+:(%d+):(%d+)-(%d+): %((%a)(%d+)%) (.*)'
local custom_luacheck_groups = { 'lnum', 'col', 'end_col', 'severity', 'code', 'message' }
local custom_luacheck_severities = {
  W = vim.diagnostic.severity.WARN,
  E = vim.diagnostic.severity.ERROR,
}

require('lint').linters.custom_luacheck = {
  cmd = 'luacheck',
  stdin = true,
  args = { '--formatter', 'plain', '--codes', '--ranges', '-', '--config', format_dir..'.luacheckrc' },
  ignore_exitcode = true,
  parser = require('lint.parser').from_pattern(
    custom_luacheck_pattern,
    custom_luacheck_groups,
    custom_luacheck_severities,
    { ['source'] = 'luacheck' },
    { end_col_offset = 0 }
  ),
}

require('lint').linters_by_ft = {
    python = { 'custom_pylint', },
    lua = { 'custom_luacheck', },
--    cpp = { 'clangtidy', },
}


vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    callback = function()
        require('lint').try_lint()
    end,
})
