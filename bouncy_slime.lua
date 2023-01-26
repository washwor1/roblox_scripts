local players = game:GetService("Players")
local player = players.LocalPlayer
local cube = script.Parent

function checkPlayerDeath(player)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid and humanoid.Health <= 0 then
			return true
		end
	end
	return false
end


-- Function to get the nearest player
local function getNearestPlayer()
	local nearestPlayer = nil
	local nearestPlayerDistance = math.huge
	for i, p in pairs(players:GetPlayers()) do
		if p ~= player then
			if p.Character and not checkPlayerDeath(p) and p.Character:FindFirstChild("HumanoidRootPart") then
				local distance = (p.Character.HumanoidRootPart.Position - cube.Position).magnitude
				if distance < nearestPlayerDistance then
					nearestPlayer = p
					nearestPlayerDistance = distance
				end
			end
		end
	end
	return nearestPlayer
end


-- Function to make the cube look at the nearest player
function lookAtNearestPlayer()
	local nearestPlayer = getNearestPlayer()
	if nearestPlayer then
		local goal = nearestPlayer.Character.Head.Position
		cube.CFrame = CFrame.new(cube.Position, goal)
	end
	return nearestPlayer
end

-- Function to make the cube bounce towards the nearest player
function bounceTowardsNearestPlayer()
	local nearestPlayer = getNearestPlayer()
	if nearestPlayer then
		local goal = nearestPlayer.Character.Head.Position
		local velocity = (goal - cube.Position).unit * math.random(15,45)
		cube.Velocity = Vector3.new(velocity.x, velocity.y + math.random(20,65), velocity.z)
		return velocity
	end
end

-- Run the lookAtNearestPlayer and bounceTowardsNearestPlayer functions every 0.1 seconds
while true do
	playercount = players:GetPlayers()
	if playercount then
		okSoHead = lookAtNearestPlayer()
		if okSoHead then
			bruh = bounceTowardsNearestPlayer()
			if bruh then
				print(bruh.x, bruh.y, bruh.z)
			end
		end
	else 
		print("This broke :(")
	end
	wait(3)
end