-- how to do local namespace
local function f()
	local _ENV = setmetatable({}, {__index=_G})						-- 5.2 support
	if setfenv then setfenv(1, _ENV) end	-- 5.1 support
	x = 1
	print('within function, x =', x)	-- make sure print works
end
f()
print('outside function, x =', x)
