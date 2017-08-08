-- ----------------------------------------
-- main content
-- ----------------------------------------

local newTable = {}
local record = true
local finish = false

local lastCommand = nil;
local commandCount = 0;
local recording = false;

gui.register(function()
  local joy = joypad.get(1)

  if recording == false and joy['l1'] then
    recording = true
  elseif recording then
    local keys = {}

    if joy['up'] then
      if joy['left'] then
        table.insert(keys, '7')
      elseif joy['right'] then
        table.insert(keys, '9')
      else
        table.insert(keys, '8')
      end
    elseif joy['down'] then
      if joy['left'] then
        table.insert(keys, '1')
      elseif joy['right'] then
        table.insert(keys, '3')
      else
        table.insert(keys, '2')
      end
    else
      if joy['left'] then
        table.insert(keys, '4')
      elseif joy['right'] then
        table.insert(keys, '6')
      end
    end

    if joy['square'] then
      table.insert(keys, 'lp')
    end
    if joy['triangle'] then
      table.insert(keys, 'mp')
    end
    if joy['r1'] then
      table.insert(keys, 'hp')
    end
    if joy['x'] then
      table.insert(keys, 'lk')
    end
    if joy['circle'] then
      table.insert(keys, 'mk')
    end
    if joy['r2'] then
      table.insert(keys, 'hk')
    end
    if joy['start'] then
      table.insert(keys, 'start')
    end
    if joy['select'] then
      table.insert(keys, 'select')
    end

    local command = table.concat(keys, ' ')

    if command == lastCommand then
      commandCount = commandCount + 1
    elseif lastCommand == nil then
      lastCommand = command
      commandCount = 1;
    else
      local newLine = lastCommand .. ':' .. commandCount
      print (newLine)
      table.insert(newTable, newLine)
      lastCommand = command
      commandCount = 1;
    end

    if joy['l2'] then
      print ('"' .. table.concat(newTable, '"\n,"') .. '"')
      recording = false
    end
  end
end)
