local M={}
local zhouyi_text = require('book-of-change.zhouyi_text')
local ZHOUYI_LINE_COUNT = #zhouyi_text
local gua = require'book-of-change.gua'

local bagua = {'乾', '兑', '离', '震','巽','坎','艮', '坤'}

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

function M.suan_ming_by_date(year, month, day, hour)
    local upGua = (year + month + day)%8
    if upGua == 0 then
        upGua = 8
    end
    local downGua = (year + month + day + hour)%8
    if downGua == 0 then
        downGua = 8
    end
    local yao = (year + month + day + hour)%6
    if yao == 0 then
        yao = 6
    end
    local guaxiang = bagua[upGua] .. '上' .. bagua[downGua] .. '下'
    for _, v in ipairs(gua) do
        if type(v[1]) == "string" and string.match(v[1], guaxiang) then
            return {
                v[1],
                v[yao + 1][1],
            }
        end
    end
end

return M
