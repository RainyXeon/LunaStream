local weblit = require('weblit')
local config = require('./utils/config.lua')
local app = weblit.app
local prefix = "/v" .. require('./constants/metadata.lua').version.major

app.bind({
  host = config.server.host,
  port = config.server.port
})

-- Configure weblit server
app.use(require("./utils/req_logger.lua"))
app.use(weblit.autoHeaders)

app.use(require("./utils/auth.lua"))
app.route({ path = "/version" }, require("./router/version.lua"))
app.route({ path = prefix .. "/info" }, require("./router/info.lua"))
app.route({ path = prefix .. "/loadtracks" }, require("./router/loadtracks.lua"))
app.route({ path = prefix .. "/encodetrack", method = "POST" }, require("./router/encodetrack.lua"))
app.route({ path = prefix .. "/decodetrack" }, require("./router/decodetrack.lua"))
-- A custom route that sends back method and part of url.
app.websocket({
  path = prefix .. "/websocket",
}, function (req, read, write)
  -- Log the request headers
  p(req)
  -- Log and echo all messages
  for message in read do
    write(message)
  end
  -- End the stream
  write()
end)
-- Start the server
app.start()