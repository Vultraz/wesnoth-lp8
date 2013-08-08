
-- By 8680.

lp8.require 'butils'

lp8.reopenLib 'utils'

local type, tostring = type, tostring

local function dbgstr(x)
	local ty = type(x)
	if ty == 'table' or ty == 'function' or ty == 'userdata'
			or x == nil then
		return tostring(x)
	else
		return tostring(ty) .. ': ' .. tostring(x)
	end
end
lp8.export(dbgstr, 'dbgstr')

return lp8.export()
