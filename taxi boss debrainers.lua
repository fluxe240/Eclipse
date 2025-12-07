local vu1 = game:GetService("VirtualUser")
local v2 = workspace:FindFirstChild("World")
local v3 = v2 and v2:FindFirstChild("Fences")
if v3 then
	v3:Destroy()
end
local v4 = workspace:FindFirstChild("Offices")
if v4 then
	local vu5 = v4:FindFirstChild("Models")
	if vu5 then
		local function vu12()
			-- upvalues: (ref) vu5
			local v6 = vu5
			local v7, v8, v9 = pairs(v6:GetChildren())
			while true do
				local v10
				v9, v10 = v7(v8, v9)
				if v9 == nil then
					break
				end
				if v10.Name == "Model" then
					local v11 = v10:FindFirstChild("Fences")
					if v11 then
						v11:Destroy()
						print("Deleted Fences folder in model: " .. v10.Name)
					end
				end
			end
		end
		vu12()
		spawn(function()
			-- upvalues: (ref) vu12
			while true do
				wait(10)
				vu12()
			end
		end)
	else
		print("Models folder not found in Offices.")
	end
else
	print("Offices folder not found in Workspace.")
end
local v13 = workspace:FindFirstChild("World")
if v13 then
	local v14 = v13:FindFirstChild("Military")
	if v14 then
		local v15, v16, v17 = pairs(v14:GetChildren())
		while true do
			local v18
			v17, v18 = v15(v16, v17)
			if v17 == nil then
				break
			end
			if v18.Name == "Barrack" or (v18.Name == "Part" or v18.Name == "Crate") then
				v18:Destroy()
				print("Deleted: " .. v18.Name)
			end
		end
		local v19, v20, v21 = pairs(v14:GetChildren())
		while true do
			local v22
			v21, v22 = v19(v20, v21)
			if v21 == nil then
				break
			end
			if v22:IsA("Model") and v22.Name == "Model" then
				local v23, v24, v25 = pairs(v22:GetChildren())
				while true do
					local v26
					v25, v26 = v23(v24, v25)
					if v25 == nil then
						break
					end
					if v26.Name == "Container" then
						v26:Destroy()
						print("Deleted Container in Model: " .. v22.Name)
					end
				end
			end
		end
	else
		print("Military folder not found in World.")
	end
else
	print("World folder not found in Workspace.")
end
game:GetService("Players").LocalPlayer.Idled:connect(function()
	-- upvalues: (ref) vu1
	vu1:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait(1)
	vu1:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
spawn(function()
	game:GetService("Players")
end)
spawn(function()
	warn("Anti Staff is now running")
	while wait() do
		local v27, v28, v29 = pairs(game.Players:GetPlayers())
		while true do
			local v30
			v29, v30 = v27(v28, v29)
			if v29 == nil then
				break
			end
			if v30:GetRankInGroup(11987919) > 149 then
				game.Players.LocalPlayer:Kick("Auto Kicked Due to Staff Member " .. v30.Name .. " is in your game")
			end
		end
		wait(5)
	end
end)
local vu31 = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local v32 = loadstring(game:HttpGet("https://sirius.menu/sense"))()
v32.teamSettings.enemy.enabled = true
v32.teamSettings.enemy.box = true
v32.teamSettings.enemy.boxColor[1] = Color3.new(0, 0.25, 0.75)
local v33 = vu31
local v34 = vu31.CreateWindow(v33, {
	["Name"] = "Taxi boss script made by debrainers",
	["Icon"] = 0,
	["LoadingTitle"] = "Taxi boss",
	["LoadingSubtitle"] = "by debrainers",
	["Theme"] = "AmberGlow",
	["DisableRayfieldPrompts"] = false,
	["DisableBuildWarnings"] = false,
	["ConfigurationSaving"] = {
		["Enabled"] = false,
		["FolderName"] = nil,
		["FileName"] = "bigAhhTaxiHub"
	},
	["Discord"] = {
		["Enabled"] = true,
		["Invite"] = "NVhr7BRAap",
		["RememberJoins"] = false
	},
	["KeySystem"] = false,
	["KeySettings"] = {
		["Title"] = "Taxi boss script made by debrainers",
		["Subtitle"] = "Key System",
		["Note"] = "Join Discord   https://discord.gg/NVhr7BRAap",
		["FileName"] = "keyTaxiBoss683",
		["SaveKey"] = true,
		["GrabKeyFromSite"] = false,
		["Key"] = ""
	}
})
local v35 = v34:CreateTab("Autos", "refresh-ccw")
local v36 = v34:CreateTab("click stuff", "mouse-pointer-click")
local v37 = v34:CreateTab("Teleport 1", "battery-low")
local v38 = v34:CreateTab("Teleport 2", "battery-medium")
local v39 = v34:CreateTab("Teleport 3", "battery-full")
local v40 = v34:CreateTab("Guides", "badge-alert")
local v41 = v34:CreateTab("Credits", "badge-check")
v35:CreateDivider()
v36:CreateDivider()
v38:CreateDivider()
v39:CreateDivider()
v37:CreateDivider()
v38:CreateParagraph({
	["Title"] = "READ 4 NO BAN",
	["Content"] = "do not use the teleport while carrying a customer. teleporting while carrying a customer will 100% get you banned."
})
v39:CreateParagraph({
	["Title"] = "READ 4 NO BAN",
	["Content"] = "do not use the teleport while carrying a customer. teleporting while carrying a customer will 100% get you banned."
})
v37:CreateParagraph({
	["Title"] = "READ 4 NO BAN",
	["Content"] = "do not use the teleport while carrying a customer. teleporting while carrying a customer will 100% get you banned."
})
v38:CreateDivider()
v39:CreateDivider()
v37:CreateDivider()
v41:CreateDivider()
v40:CreateDivider()
v40:CreateParagraph({
	["Title"] = "AUTO MONEY GUIDE:",
	["Content"] = "the higher ur office level is the faster and more money you earn. the auto money script does NOT work with a level 1 office. level 2+ office is NEEDED. once you reached the amount you like simply leave the game and join again. cash will be kept. *not detected*"
})
v40:CreateDivider()
v40:CreateParagraph({
	["Title"] = "TIME TRIAL FARM GUIDE:",
	["Content"] = "you literally just turn it on."
})
v40:CreateDivider()
v40:CreateParagraph({
	["Title"] = "AUTO TROPHIES GUIDE:",
	["Content"] = "cmon bro turn it on already"
})
v40:CreateDivider()
v40:CreateParagraph({
	["Title"] = "AUTO CUSTOMERS:",
	["Content"] = "customizeable stuff later fr but rn i shall say. activate and pray that you dont get stuck:P"
})
v40:CreateDivider()
v41:CreateParagraph({
	["Title"] = "Coder and Developer:",
	["Content"] = "debrainers"
})
v41:CreateParagraph({
	["Title"] = "Inspiration:",
	["Content"] = "Marco8642"
})
v41:CreateParagraph({
	["Title"] = "Ui library:",
	["Content"] = "rayfield *ts actually sigma*"
})
v41:CreateDivider()
v35:CreateParagraph({
	["Title"] = "DISCLAIMER",
	["Content"] = "some functions can brick ur car. meaning youd have to rejoin for the car to be fixed again."
})
v35:CreateDivider()
v36:CreateParagraph({
	["Title"] = "DISCLAIMER",
	["Content"] = "if you remove the ai vehicles, the only way to get them back is rejoining or joining a new server. the max items are only vissual. you will not lose or gain anything from clicking/doing it. Taxi radar is not permanent!"
})
v36:CreateDivider()
v35:CreateButton({
	["Name"] = "Auto money *once ran not stopable*",
	["Callback"] = function()
		writefile("taxibossautomoney.txt", game:HttpGet("https://raw.githubusercontent.com/essyyyyy/TB/refs/heads/main/autofarm"))
		loadstring(game:HttpGet("https://raw.githubusercontent.com/essyyyyy/TB/refs/heads/main/autofarm"))()
	end
})
v35:CreateToggle({
	["Name"] = "Auto Part Farm",
	["CurrentValue"] = false,
	["Flag"] = "part",
	["Callback"] = function(p42)
		getfenv().partcollector = p42 and true or false
		while getfenv().partcollector do
			task.wait()
			local v43, v44, v45 = pairs(workspace.ItemSpawnLocations:GetChildren())
			while true do
				local v46
				v45, v46 = v43(v44, v45)
				if v45 == nil then
					break
				end
				if getfenv().partcollector then
					local v47 = tick()
					repeat
						task.wait()
						game.Players.LocalPlayer.Character:PivotTo(v46.CFrame + Vector3.new(0, 251, 0))
					until tick() - v47 >= 2
					local v48, v49, v50 = pairs(workspace.ItemSpawnLocations:GetDescendants())
					while true do
						local v51
						v50, v51 = v48(v49, v50)
						if v50 == nil then
							break
						end
						if v51.Name == "TouchInterest" then
							firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v51.Parent, 0)
							firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v51.Parent, 1)
						end
					end
				end
			end
		end
	end
})
v36:CreateButton({
	["Name"] = "All items maxed *ONLY VISUAL*",
	["CurrentValue"] = false,
	["Flag"] = "part",
	["Callback"] = function(_)
		-- upvalues: (ref) vu31
		vu31:Notify({
			["Title"] = "ur items have arrived!",
			["Content"] = "Check ur inventory:P! (this is only vissual and doesnt actually affect any ingame items)",
			["Duration"] = 10
		})
		local v52 = game.Players.LocalPlayer:WaitForChild("Inventory")
		local v53, v54, v55 = pairs(v52:GetChildren())
		while true do
			local v56
			v55, v56 = v53(v54, v55)
			if v55 == nil then
				break
			end
			if v56:IsA("IntValue") or v56:IsA("NumberValue") then
				v56.Value = 1000
			end
		end
	end
})
v36:CreateButton({
	["Name"] = "Reset character",
	["Callback"] = function()
		game.Players.LocalPlayer.Character:BreakJoints()
	end
})
v36:CreateButton({
	["Name"] = "Remove Ai Vehicles",
	["Callback"] = function()
		game:GetService("Workspace").Tracks:Destroy()
	end
})
v36:CreateButton({
	["Name"] = "Unlock locked Areas *idk if this works rn tbh*",
	["Callback"] = function()
		game:GetService("Workspace").AreaLocked:Destroy()
	end
})
v36:CreateButton({
	["Name"] = "Unlock Taxi radar",
	["Callback"] = function()
		game:GetService("Players").LocalPlayer.variables.vip.Value = true
	end
})
v35:CreateToggle({
	["Name"] = "Auto upgrade office *not really auto yet. toggle on and off*",
	["CurrentValue"] = false,
	["Flag"] = "freakyy",
	["Callback"] = function(_)
		wait()
		if not game:GetService("Players").LocalPlayer:FindFirstChild("Office") then
			game:GetService("ReplicatedStorage").Company.StartOffice:InvokeServer()
			wait(0.2)
		end
		if game:GetService("Players").LocalPlayer.Office:GetAttribute("level") < 16 then
			game:GetService("ReplicatedStorage").Company.SkipOfficeQuest:InvokeServer()
			game:GetService("ReplicatedStorage").Company.UpgradeOffice:InvokeServer()
		end
	end
})
v35:CreateToggle({
	["Name"] = "Auto Time Trial",
	["CurrentValue"] = false,
	["Flag"] = "gesrfs",
	["Callback"] = function(p57)
		getfenv().medals = p57
		if not getfenv().medals then
			return
		end

		game:GetService("ReplicatedStorage").Race.LeaveRace:InvokeServer()

		spawn(function()
			while getfenv().medals do
				pcall(function()
					for _, v in pairs(game:GetService("Workspace").Vehicles:GetDescendants()) do
						if v.Name == "Player" and v.Value == game.Players.LocalPlayer then
							local vehicle = v.Parent.Parent
							if vehicle and vehicle.PrimaryPart then
								local pos = vehicle.PrimaryPart.Position
								vehicle.PrimaryPart.CFrame = CFrame.new(pos + Vector3.new(1, 0, 0))
								task.wait(0.5)
								vehicle.PrimaryPart.CFrame = CFrame.new(pos + Vector3.new(-1, 0, 0))
							end
						end
					end
				end)
				task.wait(0.5)
			end
		end)

		while getfenv().medals do
			task.wait()
			if game.Players.LocalPlayer.Character.Humanoid.Sit == false then
				game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(game:GetService("Players").LocalPlayer.variables.carId.Value)
				task.wait(0.5)
				game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
				task.wait(1)
			else
				local playerVehicle
				for _, v in pairs(game:GetService("Workspace").Vehicles:GetDescendants()) do
					if v.Name == "Player" and v.Value == game.Players.LocalPlayer then
						playerVehicle = v.Parent.Parent
						break
					end
				end

				if not playerVehicle then
					continue
				end

				for _, raceFolder in pairs(game:GetService("Workspace").Races:GetChildren()) do
					if not getfenv().medals then return end
					if raceFolder:IsA("Folder") then
						for difficulty = 1, 3 do
							if not getfenv().medals then return end

							game:GetService("ReplicatedStorage").Race.TimeTrial:InvokeServer(raceFolder.Name, difficulty)
							task.wait(1)

							if game:GetService("Players").LocalPlayer.variables.race.Value ~= "none" then
								while game:GetService("Players").LocalPlayer.variables.race.Value ~= "none" and getfenv().medals do
									local timeTrialFolder = raceFolder:FindFirstChild("timeTrial")
									local detectsFolder = raceFolder:FindFirstChild("detects")
									
									if detectsFolder then
										for _, part in pairs(detectsFolder:GetChildren()) do
											if part:IsA("Part") and part:FindFirstChild("TouchInterest") then
												part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
												firetouchinterest(playerVehicle.PrimaryPart, part, 0)
												firetouchinterest(playerVehicle.PrimaryPart, part, 1)
											end
										end
									end

									if timeTrialFolder then
										local finishPart = timeTrialFolder:FindFirstChildOfClass("IntValue")
										if finishPart and finishPart:FindFirstChild("finish") then
											finishPart.finish.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
											firetouchinterest(playerVehicle.PrimaryPart, finishPart.finish, 0)
											firetouchinterest(playerVehicle.PrimaryPart, finishPart.finish, 1)
										end
									end
									task.wait()
								end
							end
						end
					end
				end
			end
		end
	end
})
v35:CreateToggle({
	["Name"] = "Auto Trophies",
	["CurrentValue"] = false,
	["Flag"] = "freakyysd",
	["Callback"] = function(p84)
		getfenv().Trophies = p84
		game:GetService("ReplicatedStorage").Race.LeaveRace:InvokeServer()
		getfenv().showui = getfenv().Trophies
		spawn(function()
			if getfenv().showui or not game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money:FindFirstChild("Rep") then
				while getfenv().showui do
					task.wait()
					if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money:FindFirstChild("Rep") then
						game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money.Rep.Text = "Rep:" .. tostring(game:GetService("Players").LocalPlayer.variables.rep.Value)
					else
						local v85 = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money.CashLabel:Clone()
						v85.Name = "Rep"
						v85.Parent = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money
						task.wait()
						game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money.Rep.Position = UDim2.new(3, 0, 0, 0)
					end
				end
			else
				pcall(function() game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money.Rep:Destroy() end)
			end
		end)
		while getfenv().Trophies do
			task.wait()
			pcall(function()
				if game.Players.LocalPlayer.Character.Humanoid.Sit then
					if game:GetService("Players").LocalPlayer.variables.race.Value ~= "none" then
						local v86, v87, v88 = pairs(game:GetService("Workspace").Vehicles:GetDescendants())
						while true do
							local v89
							v88, v89 = v86(v87, v88)
							if v88 == nil then
								break
							end
							if v89.Name == "Player" and v89.Value == game.Players.LocalPlayer then
								local v90 = v89.Parent.Parent.PrimaryPart
								local v91 = v90.Position.X
								v90.CFrame = CFrame.new(v91 + 1, v90.Position.Y, v90.Position.Z)
								task.wait(0.1)
								v90.CFrame = CFrame.new(v91 - 1, v90.Position.Y, v90.Position.Z)
								local v92, v93, v94 = pairs(game:GetService("Workspace").Races.circuit.detects:GetChildren())
								while true do
									local v95
									v94, v95 = v92(v93, v94)
									if v94 == nil then
										break
									end
									if v95.ClassName == "Part" and v95:FindFirstChild("TouchInterest") then
										firetouchinterest(v90, v95, 0)
										firetouchinterest(v90, v95, 1)
									end
								end
								local v96 = game:GetService("Workspace").Races.circuit.timeTrial:FindFirstChildOfClass("IntValue").finish
								firetouchinterest(v90, v96, 0)
								firetouchinterest(v90, v96, 1)
							end
						end
					else
						task.wait()
						game:GetService("ReplicatedStorage").Race.TimeTrial:InvokeServer("circuit", 5)
					end
				else
					game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(game:GetService("Players").LocalPlayer.variables.carId.Value)
					task.wait(0.5)
					game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
				end
			end)
		end
	end
})
v35:CreateToggle({
	["Name"] = "Auto customers *BETA*",
	["CurrentValue"] = false,
	["Flag"] = "part",
	["Callback"] = function(p97)
		getfenv().customersfarm = p97 and true or false
		pcall(function()
			game:GetService("Workspace").GaragePlate:Destroy()
		end)
		local v98, v99, v100 = pairs(game:GetService("Workspace").World.Industrial.Port:GetChildren())
		while true do
			local v101, v102 = v98(v99, v100)
			if v101 == nil then
				break
			end
			v100 = v101
			if string.find(v102.Name, "Container") then
				v102:Destroy()
			end
		end
		getfenv().numbers = 0
		getfenv().stuck = 0
		local vu103 = false
		local vu104 = 0
		local vu105 = 1
		while getfenv().customersfarm do
			wait()
			pcall(function()
				-- upvalues: (ref) vu103, (ref) vu104, (ref) vu105
				if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
					if game.Players.LocalPlayer.Character.Humanoid.SeatPart == nil then
						game:GetService("ReplicatedStorage").Vehicles.GetNearestSpot:InvokeServer(game:GetService("Players").LocalPlayer.variables.carId.Value)
						wait(0.5)
						game:GetService("ReplicatedStorage").Vehicles.EnterVehicleEvent:InvokeServer()
					end
				else
					local v106 = game.Players.LocalPlayer.Character
					local v107 = v106.Humanoid.SeatPart.Parent.Parent
					local v108 = RaycastParams.new()
					v108.FilterDescendantsInstances = { v106, v107, workspace.Camera }
					v108.FilterType = Enum.RaycastFilterType.Exclude
					v108.IgnoreWater = false
					vu103 = false
					if game:GetService("Players").LocalPlayer.variables.inMission.Value ~= true or game:GetService("Workspace").ParkingMarkers:FindFirstChild("destinationPart") then
						if vu104 > 10 then
							game.Players.LocalPlayer:Kick("Kicked due to ban prevention *much love* - debrainers")
						end
					else
						vu104 = vu104 + 1
						wait(1)
					end
					if game:GetService("Players").LocalPlayer.variables.inMission.Value == true and game:GetService("Workspace").ParkingMarkers:FindFirstChild("destinationPart") and game.Players.LocalPlayer:DistanceFromCharacter(game:GetService("Workspace").ParkingMarkers:WaitForChild("destinationPart").Position) < 50 then
						tastvalue = 1
						v107:SetPrimaryPartCFrame(game:GetService("Workspace").ParkingMarkers.destinationPart.CFrame + Vector3.new(0, 3, 0))
						v107.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
						game:GetService("VirtualInputManager"):SendKeyEvent(true, 304, false, game)
						wait(1)
						v107:SetPrimaryPartCFrame(game:GetService("Workspace").ParkingMarkers.destinationPart.CFrame + Vector3.new(0, 3, 0))
						v107.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
						game:GetService("VirtualInputManager"):SendKeyEvent(true, 304, false, game)
						wait()
						dcframe = game:GetService("Workspace").ParkingMarkers.destinationPart.CFrame
						while true do
							wait()
							if (v107.PrimaryPart.Position - Vector3.new(dcframe.X, dcframe.Y, dcframe.Z)).magnitude > 3 then
								v107.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
								v107:PivotTo(dcframe)
								wait(0.1)
								game:GetService("VirtualInputManager"):SendKeyEvent(true, 304, false, game)
								v107.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
							end
							if not game:GetService("Workspace").ParkingMarkers:FindFirstChild("destinationPart") or getfenv().customersfarm == false then
								vu104 = 0
								game:GetService("VirtualInputManager"):SendKeyEvent(false, 304, false, game)
								getfenv().numbers = getfenv().numbers + 1
								vu105 = 1
								task.wait()
								break
							end
						end
					elseif workspace:Raycast(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(0, -100, 0), v108).Instance.Name ~= "Terrain" or vu103 ~= false then
						if game:GetService("Players").LocalPlayer.variables.inMission.Value ~= true then
							if game:GetService("Players").LocalPlayer.variables.inMission.Value == false then
								getfenv().rat = nil
								local v109 = math.huge
								local v110, v111, v112 = pairs(game:GetService("Workspace").NewCustomers:GetDescendants())
								while true do
									local v113
									v112, v113 = v110(v111, v112)
									if v112 == nil then
										break
									end
									if v113.Name == "Part" and (v113:GetAttribute("GroupSize") ~= nil and (v113:FindFirstChildOfClass("CFrameValue") and game.Players.LocalPlayer.variables.seatAmount.Value > v113:GetAttribute("GroupSize"))) and (v113:GetAttribute("Rating") < game:GetService("Players").LocalPlayer.variables.vehicleRating.Value and game:GetService("Players").LocalPlayer.variables.inMission.Value == false) then
										print(v113)
										local v114 = (v113.Position - Vector3.new(v113:FindFirstChildOfClass("CFrameValue").Value.X, v113:FindFirstChildOfClass("CFrameValue").Value.Y, v113:FindFirstChildOfClass("CFrameValue").Value.Z)).magnitude
										if v114 < v109 then
											getfenv().rat = v113
											v109 = v114
										end
									end
								end
								local v115, v116, v117 = pairs(game:GetService("Workspace").Vehicles:GetDescendants())
								while true do
									local v118
									v117, v118 = v115(v116, v117)
									if v117 == nil then
										break
									end
									if v118.Name == "Player" and v118.Value == game.Players.LocalPlayer then
										v118.Parent.Parent:SetPrimaryPartCFrame(getfenv().rat.CFrame * CFrame.new(0, 3, 0))
										wait(1)
										fireproximityprompt(getfenv().rat.Client.PromptPart.CustomerPrompt)
										wait(3)
									end
								end
							end
						else
							warn("Tester")
							local vu119 = game.Players.LocalPlayer.Character.Humanoid.SeatPart.Parent.Parent
							print(vu105)
							vu105 = vu105 - 0.02
							if vu105 < 0 then
								getfenv().rat = nil
								local v120 = math.huge
								local v121, v122, v123 = pairs(game:GetService("Workspace").World:GetDescendants())
								while true do
									local v124
									v123, v124 = v121(v122, v123)
									if v123 == nil then
										break
									end
									if string.find(v124.Name, "road") and v124.ClassName == "Part" or string.find(v124.Name, "Road") and v124.ClassName == "Part" then
										local v125 = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v124.Position).magnitude
										if v125 < v120 then
											getfenv().rat = v124
											v120 = v125
										end
									end
								end
								vu119:PivotTo(getfenv().rat.CFrame)
								getfenv().stuck = getfenv().stuck + 1
								vu105 = 1
							end
							pcall(function()
								-- upvalues: (ref) vu105, (ref) vu119
								local v126 = game:GetService("PathfindingService")
								game:GetService("TweenService")
								local v127 = game.Players.LocalPlayer.Character.HumanoidRootPart
								local v128 = game:GetService("Workspace").ParkingMarkers.destinationPart
								local v129 = v127.CFrame:lerp(v128.CFrame, vu105)
								local v130 = Vector3.new(v129.X, v128.Position.Y, v129.Z)
								local v131 = vu119
								local v132 = v126:CreatePath({
									["AgentRadius"] = 10
								})
								v132:ComputeAsync(v131.PrimaryPart.Position, v130)
								print(v132:ComputeAsync(v131.PrimaryPart.Position, v130))
								local v133 = v132:GetWaypoints()
								local v134, v135, v136 = pairs(v133)
								while true do
									local v137
									v136, v137 = v134(v135, v136)
									if v136 == nil then
										break
									end
									print("test")
									local v138 = Instance.new("Part")
									v138.Shape = "Ball"
									v138.Size = Vector3.new(0.6, 0.6, 0.6)
									v138.Position = v137.Position
									v138.Anchored = true
									v138.CanCollide = false
									v138.Parent = game.Workspace
									local v139 = game.Players.LocalPlayer.Character
									local v140 = v139.Humanoid.SeatPart.Parent.Parent
									local v141 = RaycastParams.new()
									v141.FilterDescendantsInstances = { v139, v140, workspace.Camera }
									v141.FilterType = Enum.RaycastFilterType.Exclude
									v141.IgnoreWater = true
									if workspace:Raycast(v137.Position, Vector3.new(0, 1000, 0), v141) ~= nil then
										if workspace:Raycast(v137.Position, Vector3.new(0, 1000, 0), v141) ~= nil then
											print(workspace:Raycast(v137.Position, Vector3.new(0, 1000, 0), v141))
											v138:Destroy()
											vu105 = 1
										end
									else
										v140:PivotTo(v138.CFrame + Vector3.new(0, 5, 0))
										v138:Destroy()
										vu105 = 1
										task.wait(0.009)
									end
								end
							end)
						end
					else
						getfenv().rat = nil
						local v142 = math.huge
						local v143, v144, v145 = pairs(game:GetService("Workspace").World:GetDescendants())
						while true do
							local v146
							v145, v146 = v143(v144, v145)
							if v145 == nil then
								break
							end
							if string.find(v146.Name, "road") and v146.ClassName == "Part" or string.find(v146.Name, "Road") and v146.ClassName == "Part" then
								local v147 = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v146.Position).magnitude
								if v147 < v142 then
									getfenv().rat = v146
									v142 = v147
								end
							end
						end
						v107:PivotTo(getfenv().rat.CFrame)
						vu103 = true
					end
				end
			end)
		end
	end
})
v38:CreateButton({
	["Name"] = "Gas Station",
	["Callback"] = function()
		local v148 = game.Players.LocalPlayer.Character
		local v149 = v148.Humanoid
		if v149.SeatPart ~= nil then
			if v149.SeatPart ~= nil then
				v149.SeatPart.Parent.Parent:PivotTo(CFrame.new(103.700256, 0, -640.599792) + Vector3.new(0, 40, 0))
			end
		else
			v148:PivotTo(CFrame.new(103.700256, 0, -640.599792) + Vector3.new(0, 30, 0))
		end
	end
})
v38:CreateButton({
	["Name"] = "Gas Station 2",
	["Callback"] = function()
		local v150 = game.Players.LocalPlayer.Character
		local v151 = v150.Humanoid
		if v151.SeatPart ~= nil then
			if v151.SeatPart ~= nil then
				v151.SeatPart.Parent.Parent:PivotTo(CFrame.new(930.7002563476562, 0, 643.4002075195312) + Vector3.new(0, 40, 0))
			end
		else
			v150:PivotTo(CFrame.new(930.7002563476562, 0, 643.4002075195312) + Vector3.new(0, 30, 0))
		end
	end
})
v38:CreateButton({
	["Name"] = "Hospital",
	["Callback"] = function()
		local v152 = "Hospital"
		local v153 = game.Players.LocalPlayer.Character
		local v154 = v153.Humanoid
		if v154.SeatPart ~= nil then
			if v154.SeatPart ~= nil then
				v154.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v152].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v153:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v152].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v38:CreateButton({
	["Name"] = "Industrial District",
	["Callback"] = function()
		local v155 = "Industrial District"
		local v156 = game.Players.LocalPlayer.Character
		local v157 = v156.Humanoid
		if v157.SeatPart ~= nil then
			if v157.SeatPart ~= nil then
				v157.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v155].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v156:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v155].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v38:CreateButton({
	["Name"] = "Logistic District",
	["Callback"] = function()
		local v158 = game.Players.LocalPlayer.Character
		local v159 = v158.Humanoid
		if v159.SeatPart ~= nil then
			if v159.SeatPart ~= nil then
				v159.SeatPart.Parent.Parent:PivotTo(CFrame.new(588.2861938476562, 53.5777473449707, 2529.95361328125) + Vector3.new(0, 40, 0))
			end
		else
			v158:PivotTo(CFrame.new(588.2861938476562, 53.5777473449707, 2529.95361328125) + Vector3.new(0, 30, 0))
		end
	end
})
v38:CreateButton({
	["Name"] = "Master Hotel",
	["Callback"] = function()
		local v160 = game.Players.LocalPlayer.Character
		local v161 = v160.Humanoid
		if v161.SeatPart ~= nil then
			if v161.SeatPart ~= nil then
				v161.SeatPart.Parent.Parent:PivotTo(CFrame.new(2736.1591796875, 15.864909172058105, -202.09945678710938) + Vector3.new(0, 40, 0))
			end
		else
			v160:PivotTo(CFrame.new(2736.1591796875, 15.864909172058105, -202.09945678710938) + Vector3.new(0, 30, 0))
		end
	end
})
v38:CreateButton({
	["Name"] = "Military Base",
	["Callback"] = function()
		local v162 = "Military Base"
		local v163 = game.Players.LocalPlayer.Character
		local v164 = v163.Humanoid
		if v164.SeatPart ~= nil then
			if v164.SeatPart ~= nil then
				v164.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v162].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v163:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v162].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v38:CreateButton({
	["Name"] = "Noll Cliffs",
	["Callback"] = function()
		local v165 = "Noll Cliffs"
		local v166 = game.Players.LocalPlayer.Character
		local v167 = v166.Humanoid
		if v167.SeatPart ~= nil then
			if v167.SeatPart ~= nil then
				v167.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v165].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v166:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v165].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v38:CreateButton({
	["Name"] = "Nuclear Power Plant",
	["Callback"] = function()
		local v168 = "Nuclear Power Plant"
		local v169 = game.Players.LocalPlayer.Character
		local v170 = v169.Humanoid
		if v170.SeatPart ~= nil then
			if v170.SeatPart ~= nil then
				v170.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v168].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v169:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v168].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v38:CreateButton({
	["Name"] = "OFF ROAD Test Track",
	["Callback"] = function()
		local v171 = "OFF ROAD Test Track"
		local v172 = game.Players.LocalPlayer.Character
		local v173 = v172.Humanoid
		if v173.SeatPart ~= nil then
			if v173.SeatPart ~= nil then
				v173.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v171].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v172:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v171].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Beechwood",
	["Callback"] = function()
		local v174 = game.Players.LocalPlayer.Character
		local v175 = v174.Humanoid
		if v175.SeatPart ~= nil then
			if v175.SeatPart ~= nil then
				v175.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places.Beechwood.CFrame + Vector3.new(0, 40, 0))
			end
		else
			v174:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places.Beechwood.Position) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Beechwood Beach",
	["Callback"] = function()
		local v176 = "Beechwood Beach"
		local v177 = game.Players.LocalPlayer.Character
		local v178 = v177.Humanoid
		if v178.SeatPart ~= nil then
			if v178.SeatPart ~= nil then
				v178.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v176].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v177:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v176].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Boss Airport",
	["Callback"] = function()
		local v179 = game.Players.LocalPlayer.Character
		local v180 = v179.Humanoid
		if v180.SeatPart ~= nil then
			if v180.SeatPart ~= nil then
				v180.SeatPart.Parent.Parent:PivotTo(CFrame.new(-637.1304931640625, 38.99796676635742, 4325.2275390625) + Vector3.new(0, 40, 0))
			end
		else
			v179:PivotTo(CFrame.new(-637.1304931640625, 38.99796676635742, 4325.2275390625) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Bridgeview",
	["Callback"] = function()
		local v181 = game.Players.LocalPlayer.Character
		local v182 = v181.Humanoid
		if v182.SeatPart ~= nil then
			if v182.SeatPart ~= nil then
				v182.SeatPart.Parent.Parent:PivotTo(CFrame.new(1354.4610595703125, 10.30431079864502, 1278.8033447265625) + Vector3.new(0, 40, 0))
			end
		else
			v181:PivotTo(CFrame.new(1354.4610595703125, 10.30431079864502, 1278.8033447265625) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Cedar Side",
	["Callback"] = function()
		local v183 = "Cedar Side"
		local v184 = game.Players.LocalPlayer.Character
		local v185 = v184.Humanoid
		if v185.SeatPart ~= nil then
			if v185.SeatPart ~= nil then
				v185.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v183].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v184:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v183].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Central Bank",
	["Callback"] = function()
		local v186 = "Central Bank"
		local v187 = game.Players.LocalPlayer.Character
		local v188 = v187.Humanoid
		if v188.SeatPart ~= nil then
			if v188.SeatPart ~= nil then
				v188.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v186].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v187:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v186].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Central City",
	["Callback"] = function()
		local v189 = "Central City"
		local v190 = game.Players.LocalPlayer.Character
		local v191 = v190.Humanoid
		if v191.SeatPart ~= nil then
			if v191.SeatPart ~= nil then
				v191.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v189].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v190:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v189].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "City Park",
	["Callback"] = function()
		local v192 = "City Park"
		local v193 = game.Players.LocalPlayer.Character
		local v194 = v193.Humanoid
		if v194.SeatPart ~= nil then
			if v194.SeatPart ~= nil then
				v194.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v192].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v193:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v192].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Coconut Park",
	["Callback"] = function()
		local v195 = "Coconut Park"
		local v196 = game.Players.LocalPlayer.Character
		local v197 = v196.Humanoid
		if v197.SeatPart ~= nil then
			if v197.SeatPart ~= nil then
				v197.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v195].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v196:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v195].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Country Club",
	["Callback"] = function()
		local v198 = "Country Club"
		local v199 = game.Players.LocalPlayer.Character
		local v200 = v199.Humanoid
		if v200.SeatPart ~= nil then
			if v200.SeatPart ~= nil then
				v200.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v198].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v199:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v198].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Da Hills",
	["Callback"] = function()
		local v201 = game.Players.LocalPlayer.Character
		local v202 = v201.Humanoid
		if v202.SeatPart ~= nil then
			if v202.SeatPart ~= nil then
				v202.SeatPart.Parent.Parent:PivotTo(CFrame.new(2348.347412109375, 73.10881805419922, -1537.3157958984375) + Vector3.new(0, 40, 0))
			end
		else
			v201:PivotTo(CFrame.new(2348.347412109375, 73.10881805419922, -1537.3157958984375) + Vector3.new(0, 30, 0))
		end
	end
})
v39:CreateButton({
	["Name"] = "Doge Harbor",
	["Callback"] = function()
		local v203 = game.Players.LocalPlayer.Character
		local v204 = v203.Humanoid
		if v204.SeatPart ~= nil then
			if v204.SeatPart ~= nil then
				v204.SeatPart.Parent.Parent:PivotTo(CFrame.new(3335.737548828125, 24.955890655517578, 2773.038818359375) + Vector3.new(0, 40, 0))
			end
		else
			v203:PivotTo(CFrame.new(3335.737548828125, 24.955890655517578, 2773.038818359375) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "Ocean Viewpoint",
	["Callback"] = function()
		local v205 = "Ocean Viewpoint"
		local v206 = game.Players.LocalPlayer.Character
		local v207 = v206.Humanoid
		if v207.SeatPart ~= nil then
			if v207.SeatPart ~= nil then
				v207.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v205].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v206:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v205].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "Oil Refinery",
	["Callback"] = function()
		local v208 = "Oil Refinery"
		local v209 = game.Players.LocalPlayer.Character
		local v210 = v209.Humanoid
		if v210.SeatPart ~= nil then
			if v210.SeatPart ~= nil then
				v210.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v208].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v209:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v208].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "Old Town",
	["Callback"] = function()
		local v211 = "Old Town"
		local v212 = game.Players.LocalPlayer.Character
		local v213 = v212.Humanoid
		if v213.SeatPart ~= nil then
			if v213.SeatPart ~= nil then
				v213.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v211].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v212:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v211].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "Popular Street",
	["Callback"] = function()
		local v214 = "Popular Street"
		local v215 = game.Players.LocalPlayer.Character
		local v216 = v215.Humanoid
		if v216.SeatPart ~= nil then
			if v216.SeatPart ~= nil then
				v216.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v214].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v215:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v214].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "Small Town",
	["Callback"] = function()
		local v217 = "Small Town"
		local v218 = game.Players.LocalPlayer.Character
		local v219 = v218.Humanoid
		if v219.SeatPart ~= nil then
			if v219.SeatPart ~= nil then
				v219.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v217].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v218:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v217].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "St. Noll Viewpoint",
	["Callback"] = function()
		local v220 = "St. Noll Viewpoint"
		local v221 = game.Players.LocalPlayer.Character
		local v222 = v221.Humanoid
		if v222.SeatPart ~= nil then
			if v222.SeatPart ~= nil then
				v222.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v220].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v221:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v220].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "Sunny Elementary",
	["Callback"] = function()
		local v223 = "Sunny Elementary"
		local v224 = game.Players.LocalPlayer.Character
		local v225 = v224.Humanoid
		if v225.SeatPart ~= nil then
			if v225.SeatPart ~= nil then
				v225.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v223].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v224:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v223].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "Sunset Grove",
	["Callback"] = function()
		local v226 = "Sunset Grove"
		local v227 = game.Players.LocalPlayer.Character
		local v228 = v227.Humanoid
		if v228.SeatPart ~= nil then
			if v228.SeatPart ~= nil then
				v228.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v226].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v227:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v226].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "Taxi Central",
	["Callback"] = function()
		local v229 = "Taxi Central"
		local v230 = game.Players.LocalPlayer.Character
		local v231 = v230.Humanoid
		if v231.SeatPart ~= nil then
			if v231.SeatPart ~= nil then
				v231.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v229].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v230:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v229].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "High School",
	["Callback"] = function()
		local v232 = "high school"
		local v233 = game.Players.LocalPlayer.Character
		local v234 = v233.Humanoid
		if v234.SeatPart ~= nil then
			if v234.SeatPart ~= nil then
				v234.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v232].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v233:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v232].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "Mall",
	["Callback"] = function()
		local v235 = "mall"
		local v236 = game.Players.LocalPlayer.Character
		local v237 = v236.Humanoid
		if v237.SeatPart ~= nil then
			if v237.SeatPart ~= nil then
				v237.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v235].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v236:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v235].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "The Beach",
	["Callback"] = function()
		local v238 = "the beach"
		local v239 = game.Players.LocalPlayer.Character
		local v240 = v239.Humanoid
		if v240.SeatPart ~= nil then
			if v240.SeatPart ~= nil then
				v240.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v238].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v239:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v238].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v37:CreateButton({
	["Name"] = "\239\191\189\239\191\189\239\191\189 Race Club",
	["Callback"] = function()
		local v241 = "\239\191\189\239\191\189\239\191\189 Race Club"
		local v242 = game.Players.LocalPlayer.Character
		local v243 = v242.Humanoid
		if v243.SeatPart ~= nil then
			if v243.SeatPart ~= nil then
				v243.SeatPart.Parent.Parent:PivotTo(game:GetService("ReplicatedStorage").Places[v241].CFrame + Vector3.new(0, 40, 0))
			end
		else
			v242:PivotTo(CFrame.new(game:GetService("ReplicatedStorage").Places[v241].Position) + Vector3.new(0, 30, 0))
		end
	end
})
v32.Load()

local v4625 = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local v1459 = v4625.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "CopyPrompt"
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = v1459:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(1, 20, 1, 20)
mainFrame.AnchorPoint = Vector2.new(1, 1)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 255, 0)
stroke.Thickness = 3
stroke.Transparency = 0.3
stroke.Parent = mainFrame

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Image = "rbxassetid://5554237731"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Size = UDim2.new(1, 24, 1, 24)
shadow.Position = UDim2.new(0, -12, 0, -12)
shadow.BackgroundTransparency = 1
shadow.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 15)
title.BackgroundTransparency = 1
title.Text = "copy open source link?"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

local desc = Instance.new("TextLabel")
desc.Name = "Description"
desc.Size = UDim2.new(1, -20, 0, 40)
desc.Position = UDim2.new(0, 10, 0, 50)
desc.BackgroundTransparency = 1
desc.Text = "https://github.com/fluxe240/Eclipse/blob/main/taxi%20boss%20debrainers.lua"
desc.TextColor3 = Color3.fromRGB(200, 200, 200)
desc.TextSize = 14
desc.Font = Enum.Font.Gotham
desc.TextXAlignment = Enum.TextXAlignment.Left
desc.TextWrapped = true
desc.Parent = mainFrame

local buttonContainer = Instance.new("Frame")
buttonContainer.Name = "ButtonContainer"
buttonContainer.Size = UDim2.new(1, -20, 0, 40)
buttonContainer.Position = UDim2.new(0, 10, 1, -55)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Parent = mainFrame

local yesButton = Instance.new("TextButton")
yesButton.Name = "YesButton"
yesButton.Size = UDim2.new(0.45, 0, 1, 0)
yesButton.Position = UDim2.new(0, 0, 0, 0)
yesButton.BackgroundColor3 = Color3.fromRGB(40, 180, 60)
yesButton.Text = "YES"
yesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
yesButton.TextSize = 16
yesButton.Font = Enum.Font.GothamBold
yesButton.AutoButtonColor = false
yesButton.Parent = buttonContainer

local yesCorner = Instance.new("UICorner")
yesCorner.CornerRadius = UDim.new(0, 8)
yesCorner.Parent = yesButton

local noButton = Instance.new("TextButton")
noButton.Name = "NoButton"
noButton.Size = UDim2.new(0.45, 0, 1, 0)
noButton.Position = UDim2.new(0.55, 0, 0, 0)
noButton.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
noButton.Text = "NO"
noButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noButton.TextSize = 16
noButton.Font = Enum.Font.GothamBold
noButton.AutoButtonColor = false
noButton.Parent = buttonContainer

local noCorner = Instance.new("UICorner")
noCorner.CornerRadius = UDim.new(0, 8)
noCorner.Parent = noButton

local function createHoverEffect(button, hoverColor)
	local originalColor = button.BackgroundColor3
	
	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
	end)
	
	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
	end)
end

createHoverEffect(yesButton, Color3.fromRGB(60, 220, 80))
createHoverEffect(noButton, Color3.fromRGB(220, 80, 80))

local rgbTime = 0
local rgbConnection

local function startRGBAnimation()
	rgbConnection = RunService.RenderStepped:Connect(function(delta)
		rgbTime = rgbTime + delta * 2
		local r = math.sin(rgbTime) * 0.5 + 0.5
		local g = math.sin(rgbTime + 2) * 0.5 + 0.5
		local b = math.sin(rgbTime + 4) * 0.5 + 0.5
		stroke.Color = Color3.new(r, g, b)
	end)
end

local function showPrompt()
	mainFrame.Position = UDim2.new(1, 20, 1, 20)
	mainFrame.Visible = true
	
	local slideIn = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -20, 1, -20)
	})
	
	mainFrame.BackgroundTransparency = 1
	stroke.Transparency = 1
	
	local fadeIn = TweenService:Create(mainFrame, TweenInfo.new(0.3), {
		BackgroundTransparency = 0.1
	})
	
	local strokeFade = TweenService:Create(stroke, TweenInfo.new(0.3), {
		Transparency = 0.3
	})
	
	slideIn:Play()
	wait(0.1)
	fadeIn:Play()
	strokeFade:Play()
	
	startRGBAnimation()
end

local function hidePrompt()
	if rgbConnection then
		rgbConnection:Disconnect()
		rgbConnection = nil
	end
	
	local slideOut = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Position = UDim2.new(1, 20, 1, 20)
	})
	
	local fadeOut = TweenService:Create(mainFrame, TweenInfo.new(0.3), {
		BackgroundTransparency = 1
	})
	
	local strokeFade = TweenService:Create(stroke, TweenInfo.new(0.3), {
		Transparency = 1
	})
	
	fadeOut:Play()
	strokeFade:Play()
	slideOut:Play()
	
	wait(0.5)
	mainFrame.Visible = false
end

local function copyToClipboard(text)
	local clipboard = setclipboard or toclipboard or writeclipboard or function(data)
		if typeof(data) == "string" then
			pcall(function()
				UserInputService:SetClipboard(data)
			end)
		end
	end
	
	if clipboard then
		pcall(clipboard, text)
		
		local originalText = yesButton.Text
		yesButton.Text = "COPIED!"
		TweenService:Create(yesButton, TweenInfo.new(0.3), {
			BackgroundColor3 = Color3.fromRGB(0, 150, 255)
		}):Play()
		
		wait(1)
		
		TweenService:Create(yesButton, TweenInfo.new(0.3), {
			BackgroundColor3 = Color3.fromRGB(40, 180, 60)
		}):Play()
		yesButton.Text = originalText
	end
end

yesButton.MouseButton1Click:Connect(function()
	local link = "https://github.com/fluxe240/Eclipse/blob/main/taxi%20boss%20debrainers.lua"
	copyToClipboard(link)
	hidePrompt()
end)

noButton.MouseButton1Click:Connect(function()
	hidePrompt()
end)

wait(1)
showPrompt()

task.spawn(function()
	wait(30)
	if mainFrame.Visible then
		hidePrompt()
	end
end)
