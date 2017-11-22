function reset()
  lastNeutral = 0
  lastRight = 0
  lastLeft = 0
end

function getAttack(joy)
  attack = ""
  if joy["square"] then
    attack = attack .. "lp"
  end
  if joy["triangle"] then
    attack = attack .. "mp"
  end
  if joy["r1"] then
    attack = attack .. "hp"
  end
  if joy["x"] then
    attack = attack .. "lk"
  end
  if joy["circle"] then
    attack = attack .. "mk"
  end
  if joy["r2"] then
    attack = attack .. "hk"
  end

  return attack
end

-- ----------------------------------------
-- main content
-- ----------------------------------------

lastNeutral = 0
lastRight = 0
lastLeft = 0
commands = {}

while true do
  p1 = joypad.get(1)

  a1 = {}
  for k,v in pairs(p1) do
    if v then
      a1[k] = 1
    end
  end
  joypad.set(1, {})

  currentFrame = emu.framecount()
  attack = p1["square"] or p1["triangle"] or p1["r1"] or p1["x"] or p1["circle"] or p1["r2"]

  if (not(p1["right"] or p1["left"] or p1["down"] or p1["up"])) then
    lastNeutral = currentFrame
  elseif (p1["right"] and not p1["down"] and not p1["up"]) then
    lastRight = currentFrame
  elseif (p1["left"] and not p1["down"] and not p1["up"]) then
    lastLeft = currentFrame
  end

  if (attack and p1["right"] and not p1["down"] and not p1["up"] and currentFrame - lastLeft < 10) then
    commands = {"2","3","6","2","3","6"}
  elseif (attack and p1["left"] and not p1["down"] and not p1["up"] and currentFrame - lastRight < 10) then
    commands = {"2","1","4","2","1","4"}
  elseif (attack and p1["right"] and p1["down"] and currentFrame - lastNeutral < 10) then
    buttons = getAttack(p1)
    commands = {"6","2","3"}
  elseif (attack and p1["left"] and p1["down"] and currentFrame - lastNeutral < 10) then
    commands = {"4","2","1"}
  elseif (attack and p1["right"] and not p1["up"] and currentFrame - lastNeutral < 10) then
    commands = {"2","3","6"}
  elseif (attack and p1["left"] and not p1["up"] and currentFrame - lastNeutral < 10) then
    commands = {"2","1","4"}
  end

  if #commands > 0 then
    reset()
    buttons = getAttack(p1)
    commands[#commands] = commands[#commands] .. buttons

    for i = 1, #commands do
      key = {}
      joypad.set(1, {})

      command = commands[i]
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
        key['x'] = 1
      end
      if command:find('mk') ~= nil then
        key['circle'] = 1
      end
      if command:find('hk') ~= nil then
        key['r2'] = 1
      end
      if command:find('start') ~= nil then
        key['start'] = 1
      end
      if command:find('select') ~= nil then
        key['select'] = 1
      end

      joypad.set(1, key)

      emu.frameadvance()
    end
  else
   joypad.set(1, a1)
  end
  commands = {}

  emu.frameadvance()
end

