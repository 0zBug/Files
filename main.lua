
local function Build(Path, Folder)
  local Path = Path .. "/"

	for File, Data in Folder do
		if type(Data) == "table" then
			makefolder(Path .. File)
			
			Build(Path .. File, Data)
		else
			writefile(Path .. File, Data)
		end
	end
end

local Files
function Files(Path, Value, Meta)
	local Path = Path and (Path .. "/") or ""

	return Meta and Value or setmetatable({}, {
		__index = function(self, Index)
			local Path = Path .. Index

      local Value = isfile(Path) and readfile(Path) or isfolder(Path) and Path
      local File = Files(Path, Value, isfile(Path))

			return Value and File or nil
		end,
		__newindex = function(self, Index, Value)
			local Path = Path .. Index

			if type(Value) == "table" then
				makefolder(Path)
				
				Build(Path, Value)
			else
				writefile(Path, tostring(Value))
			end
		end
	})
end

return Files()
