return require('./wrapper.lua')(function (...)
  require("./src/main.lua")
end, ...)