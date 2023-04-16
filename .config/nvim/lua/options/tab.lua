-- Move windows between tabs
vim.keymap.set('n', '<C-w><', function()
    local tab_nr = vim.fn.tabpagenr('$')

    -- If there is only 1 tab and 1 window
    if tab_nr == 1 and vim.fn.winnr('$') == 1 then
        return
    end

    -- Prepare new window
    local cur_buf = vim.fn.bufnr('%')
    -- If not currently in the first tab
    if vim.fn.tabpagenr() ~= 1 then
        vim.cmd [[ close! ]]
        -- Check if that was the last window in the tab
        if tab_nr == vim.fn.tabpagenr('$') then
            -- It not we go to prev tab
            vim.cmd [[ tabpev ]]
        end
        vim.cmd [[ vert topleft split ]]
    else
        vim.cmd [[ close! ]]
        vim.fn.execute("0tabnew")
    end
    
    -- Reopen the buffer
    vim.fn.execute("b"..cur_buf)
end, { silent = true })
vim.keymap.set('n', '<C-w>>', function()
    local tab_nr = vim.fn.tabpagenr('$')

    -- If there is only 1 tab and 1 window
    if tab_nr == 1 and vim.fn.winnr('$') == 1 then
        return
    end

    -- Prepare new window
    local cur_buf = vim.fn.bufnr('%')
    -- ?
    if vim.fn.tabpagenr() < tab_nr then
        vim.cmd [[ close! ]]
        -- Check if that was the last window in the tab
        if tab_nr == vim.fn.tabpagenr('$') then
            -- If not we go to next tab
            vim.cmd [[ tabnext ]]
        end
        vim.cmd [[ vert topleft split ]]
    else
        vim.cmd [[ close! ]]
        vim.cmd [[ tabnew ]]
    end

    -- Reopen the buffer
    vim.fn.execute("b"..cur_buf)
end, { silent = true })
