local os = {}

function os:get()
	local osname = nil
	-- Unix, Linux variants
	local fh = assert(io.popen("uname -o 2>/dev/null", "r"))
	if fh then
		osname = fh:read()
	end

	return osname or "Windows"
end

return os
