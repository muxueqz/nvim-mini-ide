#!/usr/bin/env lua
local io = require("io")
local string = require("string")

local cmd = string.format("grep --color=never --exclude-dir='.git' -R -I -i -n -H %s '%s' .",
  arg[1], arg[2])
-- print(cmd)
for line in io.popen(cmd):lines() do
  local output = line:gsub("[^:]*:[^:]*", "%1:0", 1)
  print(output)
end
