-- how to do local namespace, and access variables afterwards:
local locals = setmetatable({}, {__index=_G})
local function f()
	local _ENV = locals						-- 5.2 support
	if setfenv then setfenv(1, _ENV) end	-- 5.1 support
	x = 1
end
f()
assert(x == nil)
assert(locals.x == 1)
