-- ----------------------------------------
-- command definition
-- ----------------------------------------

p1 = {
 "5:1"
 ,"6:60"
 ,"4:14"
 ,"4:1"
 ,"2:1"
 ,"1:1"
 ,"hp:1"
}

p2 = {
 "5:1"
 ,"4:60"
 ,"6:15"
 ,"2:1"
 ,"1:1"
 ,"4:1"
 ,"hp:1"
}

-- ----------------------------------------
-- parse command into input frames
-- ----------------------------------------

function parseCommand(input)
  result = {}

  i = 1
  for cnt, s in ipairs(input) do
    pos = s:find(':')
    command = s:sub(0, pos - 1)
    frame = s:sub(pos + 1, s:len())

    for j = i, i + frame - 1 do
      key = {}
      if command:find('7') ~= nil or command:find('8') ~= nil or command:find('9') ~= nil then
        key['up'] = 1
      end
      if command:find('1') ~= nil or command:find('2') ~= nil or command:find('3') ~= nil then
        key['down'] = 1
      end
      if command:find('3') ~= nil or command:find('6') ~= nil or command:find('9') ~= nil then
        key['right'] = 1
      end
      if command:find('1') ~= nil or command:find('4') ~= nil or command:find('7') ~= nil then
        key['left'] = 1
      end
      if command:find('lp') ~= nil then
        key['square'] = 1
      end
      if command:find('mp') ~= nil then
        key['triangle'] = 1
      end
      if command:find('hp') ~= nil then
        key['r1'] = 1
      end
      if command:find('lk') ~= nil then
        key['circle'] = 1
      end
      if command:find('mk') ~= nil then
        key['x'] = 1
      end
      if command:find('hk') ~= nil then
        key['r2'] = 1
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

c1 = parseCommand(p1)
c2 = parseCommand(p2)

frames = #c1
if #c1 < #c2 then
  frames = #c2
end

for i = 1, frames do
  if i <= #c1 then
    joypad.set(1, c1[i])
  end
  if i <= #c2 then
    joypad.set(2, c2[i])
  end
  emu.frameadvance()
end
