local instree = require 'parser'.parse[[
local _ENV = setmetatable({}, {__index=_G})	-- 5.2 support
if setfenv then setfenv(1, _ENV) end		-- 5.1 support
]]

local function modifyTree(tree)
	-- insert local-scope call into each function
	local function addcbs(x)
		for k,v in pairs(x) do
			if type(v) == 'table'
			and k ~= 'parent'	-- TODO need a list of child keys
			then
				if v.type == 'function' then
					for i=#instree,1,-1 do
						table.insert(v, 1, instree[i])	-- clone?  .parent?
					end
				end
				addcbs(v)
			end
		end
	end

	-- insert it at file scope too
	for i=#instree,1,-1 do
		table.insert(tree, 1, instree[i])	-- clone?  .parent?
	end

	addcbs(tree)
end

local Parser = require 'parser'

table.insert(require 'ext.load'.xforms, function(d, source)
	local parser
	local result, code = xpcall(function()
		parser = Parser()
		parser:setData(d, source)
		modifyTree(parser.tree)
		return tostring(parser.tree)
	end, function(err)
		return tostring(source)
			..' at '..parser.t:getpos()..'\n'
			..err..'\n'
			..debug.traceback()
	end)
	if not result then error(code) end
	return code
end)
