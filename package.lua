return {
  name = "LunaStream",
  version = "0.0.1",
  description = "A simple description of my little package.",
  tags = { "lavalink audio" },
  license = "MIT",
  author = { name = "RainyXeon", email = "minh15052008@gmail.com" },
  homepage = "https://github.com/RainyXeon/LunaStream",
  dependencies = {
    "creationix/weblit@3.1.2",
    "luvit/require@2.2.3",
    "luvit/process@2.1.3",
    "luvit/dns@2.0.4",
    "creationix/coro-http@v3.2.3",
    "luvit/secure-socket@v1.2.3"
  },
  files = {
    "**.lua",
    "!test*"
  }
}