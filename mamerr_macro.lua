-- ----------------------------------------
-- command definition
-- ----------------------------------------

p1 = {
"6:1",
"2:1",
"3hp:1",
}

p2 = {
"4:1",
"2:1",
"1hp:1",
}

-- ----------------------------------------
-- parse command into input frames
-- ----------------------------------------

function parseCommand(prefix, input)
  result = {}

  i = 1
  for cnt, s in ipairs(input) do
    pos = s:find(':')
    command = s:sub(0, pos - 1)
    frame = s:sub(pos + 1, s:len())

    for j = i, i + frame - 1 do
      key = {}
      if command:find('7') ~= nil or command:find('8') ~= nil or command:find('9') ~= nil then
        key[prefix..'Up'] = true
      end
      if command:find('1') ~= nil or command:find('2') ~= nil or command:find('3') ~= nil then
        key[prefix..'Down'] = true
      end
      if command:find('3') ~= nil or command:find('6') ~= nil or command:find('9') ~= nil then
        key[prefix..'Right'] = true
      end
      if command:find('1') ~= nil or command:find('4') ~= nil or command:find('7') ~= nil then
        key[prefix..'Left'] = true
      end
      if command:find('lp') ~= nil then
        key[prefix..'Button 1'] = true
      end
      if command:find('mp') ~= nil then
        key[prefix..'Button 2'] = true
      end
      if command:find('hp') ~= nil then
        key[prefix..'Button 3'] = true
      end
      if command:find('lk') ~= nil then
        key[prefix..'Button 4'] = true
      end
      if command:find('mk') ~= nil then
        key[prefix..'Button 5'] = true
      end
      if command:find('hk') ~= nil then
        key[prefix..'Button 6'] = true
      end
      result[j] = key
    end
    i = i + frame
  end

  return result
end

-- ----------------------------------------
-- main function
-- ----------------------------------------

c1 = parseCommand("P1 ", p1)
c2 = parseCommand("P2 ", p2)

frames = #c1
if #c1 < #c2 then
  frames = #c2
end

for i = 1, frames do
  command = {}
  if i <= #c1 then
    for k,v in pairs(c1[i]) do
      command[k] = v
    end
  end
  if i <= #c2 then
    for k,v in pairs(c2[i]) do
      command[k] = v
    end
  end
  joypad.set(command)
  emu.frameadvance()
end
