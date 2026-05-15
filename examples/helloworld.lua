local lutui = require("lutui")
local term = require("term")

local M = {}

function M.init()
    termw, termh = lutui.getSize()
end

function M.draw()
    term.cursor.jump(1, 0)
    io.write("Hello World!")
end

function M.update()
    local k = io.read(1)
    if k == "q" then
        return false -- exit
    end
end

return M
