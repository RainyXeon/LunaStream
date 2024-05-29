---@diagnostic disable: need-check-nil

local linux_installer = {}

function linux_installer:check()
  local nonexists = ""
  local isLuarocksExist =
    linux_installer:exists_checker(
      "luarocks",
      "LuaRocks",
      "--version"
    )
  if not isLuarocksExist then
    nonexists = "luarocks " .. nonexists
  end

  local isMakeExist =
    linux_installer:exists_checker(
      "make",
      "Free Software Foundation",
      "--version"
    )
  if not isMakeExist then
    nonexists = "make " .. nonexists
  end

  if (nonexists:len() > 0) then linux_installer:install(nonexists) end
end

function linux_installer:exists_checker(program, expect, arg)
  local handle = io.popen(program .. " " .. arg)
  local result = handle:read("*a")
  handle:close()
  if not result:find(expect) then
    print("[ProgramChecker]: (" .. program ..") does not exist!")
    return false
  else
    print("[ProgramChecker]: (" .. program .. ") exist!")
    return true
  end
end

function linux_installer:install(list)
  print("[ProgramChecker]: Perform installing some missing program...")
  os.execute("sudo apt install " .. list)
end

return linux_installer