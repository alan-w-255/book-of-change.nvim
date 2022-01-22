local M={}
local ZHOUYI_LINE_COUNT = 957
local zhouyi_text = require('book-of-change.zhouyi_text')

local function random_seed()
    local dev_rand = io.open("/dev/urandom", 'r')
    if dev_rand ~= nil then
        local d=dev_rand:read(4)
        math.randomseed(os.time()+d:byte(1)+(d:byte(2)*256)+(d:byte(3)*65536)+(d:byte(4)*4294967296))
    else
        math.randomseed(tostring(os.time()):reverse():sub(1, 7))
    end
end


function M.suan_ming()
    random_seed()
    local random_line = math.random(ZHOUYI_LINE_COUNT)
    local result = zhouyi_text[random_line]
    return result
end

return M
