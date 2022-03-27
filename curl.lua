function curl (file, url)
  fs.delete("./" .. file)
  local f = io.open("./" .. file, "a")
  local src = http.get(url)
  f:write(src.readAll())
  f:close()
end

curl(arg[1], arg[2])