local M = {}

M.map = function(module, mode, keys, func, desc, buffer)
    if module == nil or type(module) ~= "string" then
        vim.notify(debug.traceback("ERROR: 'module' must be a string holding the name of the calling module"),
            vim.log.levels.ERROR)
    end
    if mode == nil or type(mode) ~= "string" and type(mode) ~= "table" then
        vim.notify(
        debug.traceback("ERROR: 'mode' must be a string or table holding the mode(s) in which the keymap is valid"),
            vim.log.levels.ERROR)
    end
    if keys == nil or type(keys) ~= "string" then
        vim.notify(debug.traceback("ERROR: 'keys' must be a string holding the keys to use for the keymap"),
            vim.log.levels.ERROR)
    end
    if func == nil or type(func) ~= "string" and type(func) ~= "function" then
        vim.notify(
        debug.traceback(
        "ERROR: 'func' must be a function or command string that's executed when the keymap is used (NOTE: pass a function reference)"),
            vim.log.levels.ERROR)
    end
    if desc == nil or type(desc) ~= "string" then
        vim.notify(debug.traceback("ERROR: 'desc' must be a string holding a description of the keymap"),
            vim.log.levels.ERROR)
    end

    desc = module .. ": " .. desc
    if buffer ~= nil then
        vim.keymap.set(mode, keys, func, { desc = desc, buffer = buffer })
    else
        vim.keymap.set(mode, keys, func, { desc = desc })
    end
end

return M
