package = "lunastream"
version = "dev-1"
source = {
   url = "git+https://github.com/RainyXeon/Hatsuharu.git"
}
description = {
   homepage = "https://github.com/RainyXeon/Hatsuharu",
   license = "*** please specify a license ***"
}
dependencies = {
  "lua >= 5.1",
  "pegasus",
  "lua-cjson",
  "luastatic"
}
build = {
   type = "builtin",
   modules = {
      ["constants.metadata"] = "src/constants/metadata.lua",
      lunastream = "src/lunastream.lua",
      ["router.init"] = "src/router/init.lua",
      ["router.v1.info"] = "src/router/v1/info.lua",
      ["router.v1.init"] = "src/router/v1/init.lua",
      ["router.v1.loadtracks"] = "src/router/v1/loadtracks.lua",
      ["sources.soundcloud"] = "src/sources/soundcloud.lua",
      ["utils.http"] = "src/utils/http.lua",
      ["utils.readconfig"] = "src/utils/readconfig.lua",
      ["utils.url"] = "src/utils/url.lua"
   }
}
