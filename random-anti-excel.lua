count = 0
guard = false
excel = false
nothing = false

math.randomseed(os.time())

gui.register(function()
  p1 = joypad.getdown(1)

  if guard or excel or nothing then
    count = count + 1

    if guard then
      if count < 20 then
        joypad.set(2, {})
      elseif count < 80 then
        joypad.set(2, {["down"] = 1, ["right"] = 1})
      else
        joypad.set(2, {})
        guard = false
        count = 0
      end
    elseif excel then
      if count < 20 then
        joypad.set(2, {})
      elseif count < 60 then
        joypad.set(2, {["triangle"] = 1, ["x"] = 1})
      elseif count < 80 then
        joypad.set(2, {["down"] = 1, ["x"] = 1})
      else
        joypad.set(2, {})
        excel = false
        count = 0
      end
    elseif nothing and count > 50 then
      nothing = false
    end
  elseif (p1["triangle"] and p1["x"]) or (p1["r1"] and p1["circle"]) or (p1["square"] and p1["circle"]) or (p1["triangle"] and p1["r2"]) then
    choice = math.random(3)
    if choice == 1 then
      guard = true
      print ("guard")
    elseif choice == 2 then
      excel = true
      print ("excel")
    else
      nothing = true
      print ("nothing")
    end
  end
end)
