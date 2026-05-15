local lutui = require("lutui")
local term = require("term")

local M = {}

function M.init()
    termw, termh = lutui.getSize()
    current_string = {}
end

function M.draw()
    term.cursor.jump(1, 0)
    io.write(table.concat(current_string))
end

function M.update()
    local k = io.read(1)
    if k == "q" then
        return false                             -- exit
    elseif k:byte() == 127 or k:byte() == 8 then -- backspace
        current_string[#current_string] = nil
    else
        current_string[#current_string + 1] = k
    end
end

return M
