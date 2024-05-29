local linux_installer = require 'lunastream.preinstaller.linux'
local isWin = package.config:sub(1,1) == "\\"
if not isWin then linux_installer:check() end