package = "papis-translation-server"
version = "0.1.0-1"
source = {
  url = "https://github.com/michal-h21/papis-translation-server/archive/v0.1.0.tar.gz",
  dir = "papis-translation-server-0.1.0-1"
}
description = {
  summary = "papis-translation-server",
  detailed = [[
    Papis plugin for retrieving bibliographic information from web using Zotero translation server"
  ]],
  homepage = "https://github.com/michal-h21/papis-translation-server/",
  license = "MIT <http://opensource.org/licenses/MIT>"
}
dependencies = {
  "lua >= 5.1",
  "lua-http >= 0.2"
}
build = {
  type = "builtin",
   modules = {
    ["papis-translation-server"] = "src/papis-translation-server.lua"
  }
}
