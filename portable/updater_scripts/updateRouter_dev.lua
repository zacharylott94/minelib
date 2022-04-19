local function curl (file, url)
  cwd = shell.dir()
  fs.delete(cwd .."/".. file)
  local f = io.open(cwd .. "/" .. file, "a")
  local src = http.get(url)
  f:write(src.readAll())
  f:close()
end

curl("router.lua", "https://raw.githubusercontent.com/zacharylott94/minelib/dev/portable/router.lua")