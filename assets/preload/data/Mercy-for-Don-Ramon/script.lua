local playerBop = true

local bopStength = 28

local downToNega = 1

local relocatePosition = 571

function onCreatePost()
  playerRelocatePos = getPropertyFromGroup('strumLineNotes', direction,'y')
end

function directionProcessing(bopStength)
  return bopStength*downToNega
end

function onBeatHit()
    for i = 1,4 do
          setPropertyFromGroup('strumLineNotes', i+3,'y',directionProcessing(bopStength)+playerRelocatePos)
          noteTweenY('playerBop'..i, i+3,playerRelocatePos, 0.15,"circInOut")
	end
end