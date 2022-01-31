local gua = require'book-of-change.gua'

local M={}
local bagua = {'乾', '兑', '离', '震','巽','坎','艮', '坤'}

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
                v[2][1],
                v[yao + 2][1],
            }
        end
    end
end

return M
