return function (req, res, go)
  go()
  print(string.format("%s %s %s", req.method, res.code, req.path))
end