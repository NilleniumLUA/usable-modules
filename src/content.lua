local req = {}


function req.chat(message: string)
	local remote = game.ReplicatedStorage.Chat3
	
	remote:FireAllClients(message)
end

function req.encode(table: any)
	local h = game:GetService("HttpService")
	
	local JSONEncoded = h:JSONEncode(table)
    return JSONEncoded
end



function req.setHealthStarterPlayer(maxhealth: number, health: number)
	game.Players.PlayerAdded:Connect(function(plr)
		plr.CharacterAdded:Connect(function(char)
			local hum = char.Humanoid
			hum.MaxHealth = maxhealth
			hum.Health = health
		end)
		
	end)
end
function req.saveData(UserID: number, table: datatobesaved)
	local DSS = game:GetService("DataStoreService")
	local data = DSS:GetDataStore("Overhaul")
	local success, result = pcall(function()
		data:SetAsync(UserID, table)
	end)
	
	if success then 
		print("saved")
		return result 
		
	else 
		warn(result)
	end
end

function req.CheckData(UserID: number)
	local DSS = game:GetService("DataStoreService")
	local data = DSS:GetDataStore("Overhaul")
	local sucess, result = pcall(function()
		return data:GetAsync(UserID)
	end)
	
	if sucess then 
		return result
	else 
		warn(result)
	end
end

function req.setStarterSpawnLocation(SpawnCFrame: CFrame, custom: bool)
	if game.Workspace:FindFirstChildWhichIsA("SpawnLocation") then 
		game.Workspace:FindFirstChildWhichIsA("SpawnLocation"):Destroy()
		task.wait(2)
		if custom == true then
			local new = Instance.new("SpawnLocation")
			new.Parent = game.Workspace
			new.CFrame = SpawnCFrame
			new.Transparency = 1
			new.Size = Vector3.new(12, 1, 12)
			new.Anchored = true
			new.CanCollide = false
			if new:FindFirstChild("Decal") then 
				new:FindFirstChild("Decal"):Destroy()
			else 
				return
			end
		else 
			local new = Instance.new("SpawnLocation")
			new.Parent = game.Workspace
			new.CFrame = SpawnCFrame
		end
	end
end
return req
