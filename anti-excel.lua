count = 0
excel = false

gui.register(function()
  if joypad.getdown(1)["down"] and joypad.getdown(1)["circle"] then
    joypad.set(2, {["down"] = 1, ["triangle"] = 1, ["x"] = 1})
    excel = true
  elseif excel then
    count = count + 1
    if count > 60 then
      joypad.set(2, {})
      count = 0
      excel = false
    end
  end
end)
