return require('./bootstrap.lua')(function (...)
  require("./src/main.lua")
end, ...)