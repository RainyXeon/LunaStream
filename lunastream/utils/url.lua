Url = {}

function Url:encode(url)
	if url == nil then return end
	url = url:gsub("\n", "\r\n")
	url = url:gsub("([^%w ])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)
	url = url:gsub(" ", "+")
	return url
end

function Url:decode(url)
	if url == nil then return end
	url = url:gsub("+", " ")
	url = url:gsub("%%(%x%x)", function(x)
		return string.char(tonumber(x, 16))
	end)
	return url
end

return Url
