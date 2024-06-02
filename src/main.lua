local weblit = require('weblit')
local config = require('./utils/config.lua')
local app = weblit.app
local prefix = "/v" .. require('./constants/metadata.lua').version.major
app.bind({host = "127.0.0.1", port = config.server.port})

-- Configure weblit server
app.use(weblit.logger)
app.use(weblit.autoHeaders)

-- A custom route that sends back method and part of url.
app.use(require("./utils/auth.lua"))
app.route({ path = "/version"}, require("./router/version.lua"))
app.route({ path = prefix .. "/info"}, require("./router/info.lua"))
app.route({ path = prefix .. "/loadtracks"}, require("./router/loadtracks.lua"))

-- Start the server
app.start()