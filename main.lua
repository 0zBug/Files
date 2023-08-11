
local function Build(Path, Folder)
	for File, Data in Folder do
		if type(Data) == "table" then
			makefolder(Path .. File)
			
			Build(Path .. File .. "/", Data)
		else
			writefile(Path .. File, Data)
		end
	end
end

local Files
function Files(Path, Value)
	local Path = Path and (Path .. "/") or ""

	return debug.setmetatable(Value or {}, {
		__index = function(self, Index)
			local Path = Path .. Index

      local Contents = isfile(Path) and readfile(Path) or isfolder(Index) and Index or false

			return Contents and Files(Path, Contents) or nil
		end,
		__newindex = function(self, Index, Value)
			local Path = Path .. Index

			if type(Value) == "table" then
				makefolder(Path)
				
				Build(Path .. "/", Value)
			else
				writefile(Path, Value)
			end
		end
	})
end

return Files()
