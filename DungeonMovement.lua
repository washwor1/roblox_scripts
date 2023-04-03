local UserInputService = game:GetService("UserInputService")
local PlayerModule = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"))
local Players = game:GetService("Players")

local Controls = PlayerModule:GetControls()
local moveLock = 0
local Player = Players.LocalPlayer
local Character = Player.Character
if not Character or not Character.Parent then
	Character = Player.CharacterAdded:wait()
end
local Humanoid = Player.Character:WaitForChild("Humanoid")

Controls:Disable()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.W and Humanoid then
		if Humanoid.MoveDirection.magnitude ~= 0  then
			return
		end
		local location = Player.Character.HumanoidRootPart.CFrame
		local look = location.LookVector
		local LR = math.ceil(look.X-0.2) 
		local UD = math.ceil(look.Z-0.2) 
		local newLocation = Vector3.new(location.X+(LR*9),location.Y,location.Z+(UD*9))
		-- Calculate the new position to move to based on the player's orientation
		Humanoid:MoveTo(newLocation)
	end
	if input.KeyCode == Enum.KeyCode.S and Humanoid then
		if Humanoid.MoveDirection.magnitude ~= 0  then
			return
		end
		local location = Player.Character.HumanoidRootPart.CFrame
		local look = location.LookVector
		local LR = math.ceil(look.X-0.2) 
		local UD = math.ceil(look.Z-0.2) 
		local newLocation = Vector3.new(location.X-(LR*9),location.Y,location.Z-(UD*9))
		-- Calculate the new position to move to based on the player's orientation
		Humanoid:MoveTo(newLocation)
	end
	if input.KeyCode == Enum.KeyCode.A and Humanoid then
		print(moveLock)
		if Humanoid.MoveDirection.magnitude ~= 0 then
			return
		end
		turnPlayer90Degrees(Player,1,0.2)
	end
	if input.KeyCode == Enum.KeyCode.D and Humanoid then
		if Humanoid.MoveDirection.magnitude ~= 0 then
			return
		end
		turnPlayer90Degrees(Player,-1,0.2)
	end
	if input.KeyCode == Enum.KeyCode.Q and Humanoid then
		if Humanoid.MoveDirection.magnitude ~= 0 then
			return
		end
		turnPlayer90Degrees(Player,1,0.3)
		turnPlayer90Degrees(Player,1,0.3)
	end
	if input.KeyCode == Enum.KeyCode.E and Humanoid then
		if Humanoid.MoveDirection.magnitude ~= 0 then
			return
		end
		turnPlayer90Degrees(Player,-1,0.3)
		turnPlayer90Degrees(Player,-1,0.3)
	end
end)

function turnPlayer90Degrees(player,dir,speed)
	local humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return -- humanoid not found
	end
	local currentCFrame = humanoid.RootPart.CFrame
	local newCFrame = currentCFrame * CFrame.Angles(0, dir*(math.pi / 2), 0) -- rotate 90 degrees around Y-axis
	local duration = speed -- duration of the turn animation
	local turn = 0
	while true do
		local t = math.min(1,turn )
		humanoid.RootPart.CFrame = currentCFrame:Lerp(newCFrame, t)
		if t >= 1 then
			break
		end
		wait()
		turn+= duration
	end
end

