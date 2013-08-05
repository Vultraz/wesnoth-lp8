
-- By 8680.
-- Utilities that do not use type.lua.
-- As far as other add-ons should be concerned, this is part of utils.lua.
-- This is separate from utils.lua so that type.lua can depend on this even
--  if utils.lua depends on type.lua.

local type, next, load, loadstring, setfenv =
	type, next, load, loadstring, setfenv
local h = lp8.helper

lp8.AND = {}
lp8.OR = {}

function lp8.nyil(f)
	error("Not yet implemented: " .. f, 2)
end

function lp8.nyiw(f)
	h.wml_error("Not yet implemented: " .. f)
end

function lp8.tblorudt(x)
	return type(x) == 'table' or type(x) == 'userdata'
end

function lp8.keys(t, k)
	return function(s)
		local k = s.k
		s.k = next(t, k)
		return k
	end, {k = k or next(t)}
end

function lp8.values(t, k)
	return function(s)
		local v
		v, s.k = t[s.k], next(t, s.k)
		return v
	end, {k = k or next(t)}
end

function lp8.ivalues(t, i)
	return function(s)
		s.i = s.i+1
		return t[s.i-1]
	end, {i = i or 1}
end

function lp8.load(ld, env, name)
	if not loadstring then
		return load(ld, name, nil, env)
	else
		ld = (type(ld) == 'string' and loadstring or
			type(ld) == 'function' and load or
			error("expected string or function as first argument; received "
				.. ty))(ld, name)
		return ld and setfenv(ld, env)
	end
end

function lp8.flip(x, b)
	if b == false then
		return x
	end
	local ty = type(x)
	if ty == 'table' then
		local r = {}
		for i = #x, 1, -1 do
			r[#r+1] = x[i]
		end
		return r
	elseif ty == 'boolean' then
		return not x
	elseif ty == 'string' then
		return x: reverse()
	elseif ty == 'number' then
		return -x
	end
	error("don’t know how to flip a " .. ty)
end

lp8.wml_vars = h.set_wml_var_metatable {}