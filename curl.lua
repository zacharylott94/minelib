function curl (file, url)
  cwd = shell.dir()
  fs.delete(cwd .."/".. file)
  local f = io.open(cwd .. "/" .. file, "a")
  local src = http.get(url)
  f:write(src.readAll())
  f:close()
end

curl(arg[1], arg[2])