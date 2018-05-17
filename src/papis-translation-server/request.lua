local http_request = require "http.request"

local Request = {}
Request.__index = Request

function Request.new(host, port)
  local host = host or "127.0.0.1"
  local port = port or "1969"
  local uri = string.format("http://%s:%s/web", host, port)
  local self = setmetatable({}, Request)
  local request = http_request.new_from_uri(uri)
  request.host=host
  request.port=port
  local post = [[{"url":"https://www.csfd.cz/film/581606-patrick-melrose/", "sessionid":"agbsf"}]]
  request.headers:upsert(":method", "POST")
  request.headers:upsert("Content-Type",  "application/json")
  request:set_body(post)
  local headers, stream = request:go()
  if headers == nil then
    io.stderr:write(tostring(stream), "\n")
    os.exit(1)
  end
  print("## HEADERS")
  for k, v in headers:each() do
    print(k, v)
  end
  local body, err = stream:get_body_as_string()
  if not body and err then
    io.stderr:write(tostring(err), "\n")
    os.exit(1)
  end
  print(body)
  local newrequest = http_request.new_from_uri(string.format("http://%s:%s/export?format=biblatex", host, port))
  newrequest.headers:upsert(":method", "POST")
  newrequest.headers:upsert("Content-Type",  "application/json")
  newrequest:set_body(body)
  local headers, stream = newrequest:go()
  if headers == nil then
    io.stderr:write(tostring(stream), "\n")
    os.exit(1)
  end
  print("## HEADERS")
  for k, v in headers:each() do
    print(k, v)
  end
  local body, err = stream:get_body_as_string()
  if not body and err then
    io.stderr:write(tostring(err), "\n")
    os.exit(1)
  end
  print(body)
  self.request = request


  return self
end

local request = Request.new()

return Request
