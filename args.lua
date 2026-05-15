-- singleton for storing args
-- because when you require() smth thats already require()'d it uses the cached one
local args = {}

local M = {}

function M.add(new_args)
    for i, v in ipairs(new_args) do
        table.insert(args, v)
    end
end

function M.get()
    return args
end

return M
