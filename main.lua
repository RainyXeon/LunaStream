local weblit = require('weblit')
local app = weblit.app

app.bind({host = "127.0.0.1", port = 8888})

-- Configure weblit server
app.use(weblit.logger)
app.use(weblit.autoHeaders)

-- A custom route that sends back method and part of url.
app.route({ path = "/version"}, function (req, res)
  res.body = "0.0.1-rewritten"
  res.code = 200
  res.headers["Content-Type"] = "application/json"
end)

-- Start the server
app.start()