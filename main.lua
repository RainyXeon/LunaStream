local weblit = require('weblit')
local app = weblit.app
local prefix = "/v" .. require('./src/constants/metadata.lua').version.major
app.bind({host = "127.0.0.1", port = 3000})

-- Configure weblit server
app.use(weblit.logger)
app.use(weblit.autoHeaders)

-- A custom route that sends back method and part of url.
app.route({ path = "/version"}, require("./src/router/version.lua"))
app.route({ path = prefix .. "/info"}, require("./src/router/info.lua"))

-- Start the server
app.start()