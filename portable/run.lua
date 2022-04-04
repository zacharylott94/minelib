local file = io.open(args[1],"r")
for line in file:lines() do
  shell.run(line)
end