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
    "luvit/luvit@2.18.1",
    "creationix/coro-http@v3.2.3",
    "luvit/secure-socket@v1.2.3"
  },
  files = {
    "**.lua",
    "!test*"
  }
}