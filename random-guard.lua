count = 0
guard = false

math.randomseed(os.time())

gui.register(function()
  p1 = joypad.getdown(1)
  if guard then
    count = count + 1
    if count > 15 then
      joypad.set(2, {})
      count = 0
      guard = false
    end
  elseif p1["square"] or p1["triangle"] or p1["r1"] or p1["x"] or p1["circle"] or p1["r2"] then
    if math.random(2) == 1 then
      joypad.set(2, {["down"] = 1, ["right"] = 1})
    end
    guard = true
  end
end)
