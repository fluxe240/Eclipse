local vu1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))()
local vu2 = vu1.newNotify()
local v3 = vu1
local v4 = vu1.ConfigManager(v3, {
    Directory = "NEVA HUB-UI",
    Config = "NEVA HUB-Config"
})
local vu5 = game:GetService("Players")
local vu6 = game:GetService("RunService")
local vu7 = game:GetService("TweenService")
local v8 = game:GetService("UserInputService")
local vu9 = game:GetService("TeleportService")
game:GetService("StarterGui")
local vu10 = game:GetService("HttpService")
game:GetService("Workspace")
local vu11 = vu5.LocalPlayer
local vu12 = nil
local vu13 = nil
local vu14 = nil
local function vu15()
    vu12 = vu11.Character or vu11.CharacterAdded:Wait()
    vu13 = vu12:WaitForChild("HumanoidRootPart")
    vu14 = vu12:WaitForChild("Humanoid")
end
vu15()
vu11.CharacterAdded:Connect(function()
    task.wait(1)
    vu15()
end)
local vu16 = nil
local vu17 = nil
local vu18 = false
local vu19 = {}
local vu20 = false
local vu21 = false
local vu22 = false
local vu23 = false
local vu24 = {
    Vector3.new(- 466, - 1, 220),
    Vector3.new(- 466, - 2, 116),
    Vector3.new(- 466, - 2, 8),
    Vector3.new(- 464, - 2, - 102),
    Vector3.new(- 351, - 2, - 100),
    Vector3.new(- 354, - 2, 5),
    Vector3.new(- 354, - 2, 115),
    Vector3.new(- 358, - 2, 223)
}
local function vu32()
    if not vu13 then
        return nil
    end
    local v25 = math.huge
    local v26, v27, v28 = ipairs(vu24)
    local v29 = nil
    while true do
        local v30
        v28, v30 = v26(v27, v28)
        if v28 == nil then
            break
        end
        local v31 = (vu13.Position - v30).Magnitude
        if v31 < v25 then
            v29 = v30
            v25 = v31
        end
    end
    return v29
end
local function vu34()
    if not vu13 then
        vu15()
    end
    local v33 = vu32()
    if v33 and vu13 then
        vu7:Create(vu13, TweenInfo.new(1.2), {
            CFrame = CFrame.new(v33)
        }):Play()
        task.wait(1.3)
        vu13.CFrame = vu13.CFrame + Vector3.new(0, 200, 0)
    end
end
local function vu35()
    if not vu13 then
        vu15()
    end
    if vu13 then
        vu13.CFrame = vu13.CFrame - Vector3.new(0, 50, 0)
    end
end
function setGodMode(p36)
    if not vu14 then
        vu15()
    end
    if vu14 then
        vu23 = p36
        if p36 then
            vu14.MaxHealth = math.huge
            vu14.Health = math.huge
            if vu16 then
                vu16:Disconnect()
            end
            vu16 = vu14:GetPropertyChangedSignal("Health"):Connect(function()
                if vu14.Health < math.huge then
                    vu14.Health = math.huge
                end
            end)
        else
            if vu16 then
                vu16:Disconnect()
            end
            vu16 = nil
            pcall(function()
                vu14.MaxHealth = 100
                vu14.Health = 100
            end)
        end
    end
end
local vu37 = 100
local function vu47()
    if not vu13 then
        return nil
    end
    local v38 = vu37
    local v39 = vu5
    local v40, v41, v42 = ipairs(v39:GetPlayers())
    local v43 = nil
    while true do
        local v44
        v42, v44 = v40(v41, v42)
        if v42 == nil then
            break
        end
        if v44 ~= vu11 and v44.Character and (v44.Character:FindFirstChild("HumanoidRootPart") and (v44.Character:FindFirstChildOfClass("Humanoid") and v44.Character.Humanoid.Health > 0)) then
            local v45 = v44.Character.HumanoidRootPart
            local v46 = (vu13.Position - v45.Position).Magnitude
            if v46 < v38 then
                v43 = v44
                v38 = v46
            end
        end
    end
    return v43
end
local function vu51(p48)
    vu22 = p48
    if p48 then
        vu17 = vu6.Heartbeat:Connect(function()
            local v49 = vu47()
            local v50 = v49 and (v49.Character and (vu12 and (vu13 and vu14))) and v49.Character:FindFirstChild("HumanoidRootPart")
            if v50 then
                vu13.CFrame = CFrame.lookAt(vu13.Position, Vector3.new(v50.Position.X, vu13.Position.Y, v50.Position.Z))
            end
        end)
    elseif vu17 then
        vu17:Disconnect()
        vu17 = nil
    end
end
v8.JumpRequest:Connect(function()
    if vu20 and (vu14 and vu13) then
        vu13.AssemblyLinearVelocity = Vector3.new(0, 100, 0)
        local vu52 = nil
        vu52 = vu6.Stepped:Connect(function()
            if vu12 and (vu13 and (vu14 and vu20)) then
                if vu14:GetState() ~= Enum.HumanoidStateType.Freefall then
                    if vu14.FloorMaterial ~= Enum.Material.Air then
                        vu52:Disconnect()
                    end
                else
                    vu13.Velocity = Vector3.new(vu13.Velocity.X, math.clamp(vu13.Velocity.Y, - 20, 150), vu13.Velocity.Z)
                end
            else
                vu52:Disconnect()
            end
        end)
    end
end)
function setInvisible(p53)
    if not vu12 then
        vu15()
    end
    if vu12 then
        vu21 = p53
        local v54 = vu12
        local v55, v56, v57 = ipairs(v54:GetDescendants())
        while true do
            local v58
            v57, v58 = v55(v56, v57)
            if v57 == nil then
                break
            end
            if v58:IsA("BasePart") and v58.Name ~= "HumanoidRootPart" then
                v58.Transparency = p53 and 1 or (v58.Parent:IsA("Accessory") and (v58.Parent.Handle.Transparency or 0) or 0)
            elseif v58:IsA("Decal") then
                v58.Transparency = p53 and 1 or 0
            end
        end
    end
end
local function vu86(p59)
    vu18 = p59
    if p59 then
        local v60 = vu5
        local v61, v62, v63 = pairs(v60:GetPlayers())
        local function vu66(p64)
            if p64 and not p64:FindFirstChild("NEVA HUBESP") then
                local v65 = Instance.new("Highlight")
                v65.Name = "NEVA HUBESP"
                v65.FillColor = Color3.fromRGB(255, 50, 50)
                v65.OutlineColor = Color3.new(1, 1, 1)
                v65.FillTransparency = 0.5
                v65.OutlineTransparency = 0
                v65.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                v65.Parent = p64
            end
        end
        while true do
            local v67
            v63, v67 = v61(v62, v63)
            if v63 == nil then
                break
            end
            if v67 ~= vu11 and v67.Character then
                vu66(v67.Character)
            end
        end
        table.insert(vu19, vu5.PlayerAdded:Connect(function(p68)
            p68.CharacterAdded:Connect(function(p69)
                if vu18 then
                    vu66(p69)
                end
            end)
        end))
        local v70 = vu5
        local v71, v72, v73 = pairs(v70:GetPlayers())
        while true do
            local v74
            v73, v74 = v71(v72, v73)
            if v73 == nil then
                break
            end
            if v74 ~= vu11 then
                table.insert(vu19, v74.CharacterAdded:Connect(function(p75)
                    if vu18 then
                        vu66(p75)
                    end
                end))
            end
        end
    else
        local v76, v77, v78 = ipairs(vu19)
        while true do
            local v79
            v78, v79 = v76(v77, v78)
            if v78 == nil then
                break
            end
            v79:Disconnect()
        end
        vu19 = {}
        local v80 = vu5
        local v81, v82, v83 = pairs(v80:GetPlayers())
        while true do
            local v84
            v83, v84 = v81(v82, v83)
            if v83 == nil then
                break
            end
            if v84.Character then
                local v85 = v84.Character:FindFirstChild("NEVA HUBESP")
                if v85 then
                    v85:Destroy()
                end
            end
        end
    end
end
local function vu96()
    local vu87 = game.PlaceId
    local v88 = {}
    local v89, v90 = pcall(function()
        return vu10:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. vu87 .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    local v91
    if v89 and (v90 and v90.data) then
        local v92, v93, v94 = ipairs(v90.data)
        v91 = vu87
        while true do
            local v95
            v94, v95 = v92(v93, v94)
            if v94 == nil then
                break
            end
            if v95.playing and (v95.maxPlayers and (v95.playing < v95.maxPlayers and v95.id ~= game.JobId)) then
                table.insert(v88, v95.id)
            end
        end
    else
        v91 = vu87
    end
    if # v88 <= 0 then
        vu2.new({
            Title = "Server Hop",
            Content = "No other servers found!",
            Duration = 3,
            Icon = "rbxassetid://72028320244858"
        })
    else
        vu9:TeleportToPlaceInstance(v91, v88[math.random(1, # v88)])
    end
end
local v97 = vu1
vu1.Loader(v97, "rbxassetid://72028320244858", 2.5).yield()
local vu98 = vu1.new({
    Name = "NEVA HUB",
    Keybind = "LeftAlt",
    Logo = "rbxassetid://72028320244858",
    Scale = vu1.Scale.Window,
    TextSize = 15
})
vu2.new({
    Title = "NEVA HUB",
    Content = "Welcome! Script loaded successfully!",
    Duration = 5,
    Icon = "rbxassetid://72028320244858"
})
local v99 = vu98
local v100 = vu98.Watermark(v99)
v100:AddText({
    Icon = "user",
    Text = "NEVA HUB"
})
local v101 = v100.AddText
local v102 = {
    Icon = "clock"
}
local v103 = vu1
v102.Text = vu1.GetDate(v103)
v101(v100, v102)
local vu104 = v100:AddText({
    Icon = "timer",
    Text = "TIME"
})
task.spawn(function()
    while true do
        task.wait()
        vu104:SetText(vu1:GetTimeNow())
    end
end)
v100:AddText({
    Icon = "server",
    Text = vu1.Version
})
local v105 = vu98
vu98.DrawCategory(v105, {
    Name = "Player Features"
})
local v106 = vu98
local v107 = vu98.DrawTab(v106, {
    Name = "Player Settings",
    Icon = "user",
    EnableScrolling = true
})
local v108 = v107:DrawSection({
    Name = "Player Settings",
    Position = "left"
})
v108:AddToggle({
    Name = "God Mode",
    Flag = "GodMode",
    Default = false,
    Callback = function(p109)
        setGodMode(p109)
    end
})
v108:AddToggle({
    Name = "Aimbot",
    Flag = "Aimbot",
    Default = false,
    Callback = function(p110)
        vu51(p110)
    end
})
v108:AddToggle({
    Name = "Jump Boost",
    Flag = "JumpBoost",
    Default = false,
    Callback = function(p111)
        vu20 = p111
    end
})
v108:AddSlider({
    Name = "Aimbot Range",
    Min = 50,
    Max = 500,
    Default = 100,
    Round = 0,
    Flag = "AimbotRange",
    Callback = function(p112)
        vu37 = p112
    end
})
local vu113 = game:GetService("Players")
local v114 = game:GetService("RunService")
local vu115 = false
local vu116 = {}
local vu117 = {}
local function vu122(p118)
    if p118.Character and not p118.Character:FindFirstChild("ESP") then
        local v119 = Instance.new("Highlight")
        v119.Name = "ESP"
        v119.FillColor = Color3.fromRGB(255, 50, 50)
        v119.OutlineColor = Color3.new(1, 1, 1)
        v119.FillTransparency = 0.5
        v119.OutlineTransparency = 0
        v119.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        v119.Parent = p118.Character
        local v120 = Instance.new("BillboardGui")
        v120.Size = UDim2.new(0, 100, 0, 50)
        v120.Adornee = p118.Character:WaitForChild("Head")
        v120.AlwaysOnTop = true
        local v121 = Instance.new("TextLabel", v120)
        v121.Size = UDim2.new(1, 0, 1, 0)
        v121.BackgroundTransparency = 1
        v121.Text = p118.Name
        v121.TextColor3 = Color3.new(1, 1, 1)
        v121.TextStrokeTransparency = 0
        v121.TextScaled = true
        v120.Parent = p118.Character
        vu117[p118.UserId] = {
            v119,
            v120
        }
    end
end
local function vu128(p123)
    if vu117[p123.UserId] then
        local v124, v125, v126 = ipairs(vu117[p123.UserId])
        while true do
            local v127
            v126, v127 = v124(v125, v126)
            if v126 == nil then
                break
            end
            v127:Destroy()
        end
        vu117[p123.UserId] = nil
    end
end
local function vu150(p129)
    vu115 = p129
    if p129 then
        local v130 = vu113
        local v131, v132, v133 = pairs(v130:GetPlayers())
        while true do
            local v134
            v133, v134 = v131(v132, v133)
            if v133 == nil then
                break
            end
            vu122(v134)
        end
        vu116[# vu116 + 1] = vu113.PlayerAdded:Connect(function(pu135)
            pu135.CharacterAdded:Connect(function()
                if vu115 then
                    vu122(pu135)
                end
            end)
        end)
        local v136 = vu113
        local v137, v138, v139 = pairs(v136:GetPlayers())
        while true do
            local vu140
            v139, vu140 = v137(v138, v139)
            if v139 == nil then
                break
            end
            vu140.CharacterAdded:Connect(function()
                if vu115 then
                    vu122(vu140)
                end
            end)
        end
    else
        local v141, v142, v143 = ipairs(vu116)
        while true do
            local v144
            v143, v144 = v141(v142, v143)
            if v143 == nil then
                break
            end
            v144:Disconnect()
        end
        vu116 = {}
        local v145 = vu113
        local v146, v147, v148 = pairs(v145:GetPlayers())
        while true do
            local v149
            v148, v149 = v146(v147, v148)
            if v148 == nil then
                break
            end
            vu128(v149)
        end
    end
end
v108:AddToggle({
    Name = "OP ESP",
    Flag = "OPESP",
    Default = false,
    Callback = function(p151)
        vu150(p151)
    end
})
local v152 = v107:DrawSection({
    Name = "Visual Settings",
    Position = "right"
})
v108:AddParagraph({
    Title = "Join Our Discord!",
    Content = "Join the NEVA HUB community for updates and support! Click the button below to copy the invite link."
})
v108:AddButton({
    Name = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/8s8PEXz6XC")
        vu2.new({
            Title = "Link Copied",
            Content = "Discord invite link has been copied to your clipboard!",
            Duration = 3,
            Icon = "rbxassetid://72028320244858"
        })
    end
})
v152:AddToggle({
    Name = "ESP",
    Flag = "ESP",
    Default = false,
    Callback = function(p153)
        vu86(p153)
    end
})
v152:AddToggle({
    Name = "Invisible",
    Flag = "Invisible",
    Default = false,
    Callback = function(p154)
        setInvisible(p154)
    end
})
local vu155 = false
local vu156 = 6
local vu157 = 0
v114.RenderStepped:Connect(function()
    if vu155 and (tick() - vu157 > 0.2 and (vu13 and vu14)) then
        local v158 = vu14.MoveDirection
        if v158.Magnitude > 0 then
            vu157 = tick()
            local v159 = math.clamp(vu156, 4, 10)
            local v160 = vu13.Position + v158.Unit * v159
            vu7:Create(vu13, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                CFrame = CFrame.new(v160)
            }):Play()
        end
    end
end)
v152:AddToggle({
    Name = "Bypass Speed",
    Flag = "BypassSpeedToggle",
    Default = false,
    Callback = function(p161)
        vu155 = p161
    end
})
v152:AddSlider({
    Name = "Bypass Speed Value",
    Min = 4,
    Max = 10,
    Default = 6,
    Round = 0,
    Flag = "BypassSpeedSlider",
    Callback = function(p162)
        vu156 = p162
    end
})
local v163 = vu98
vu98.DrawCategory(v163, {
    Name = "Teleport & Steal"
})
local v164 = vu98
local v165 = vu98.DrawTab(v164, {
    Name = "Teleport",
    Icon = "move",
    EnableScrolling = true
})
local v166 = v165:DrawSection({
    Name = "Teleport Controls",
    Position = "left"
})
v166:AddButton({
    Name = "Teleport to Sky",
    Callback = function()
        vu34()
        vu2.new({
            Title = "Teleport",
            Content = "Teleported to sky!",
            Duration = 2,
            Icon = "rbxassetid://72028320244858"
        })
    end
})
v166:AddButton({
    Name = "Teleport to Ground",
    Callback = function()
        vu35()
        vu2.new({
            Title = "Teleport",
            Content = "Teleported to ground!",
            Duration = 2,
            Icon = "rbxassetid://72028320244858"
        })
    end
})
local v167 = v165:DrawSection({
    Name = "Steal Features",
    Position = "right"
})
local vu168 = false
v167:AddToggle({
    Name = "Auto Steal",
    Flag = "AutoSteal",
    Default = false,
    Callback = function(p169)
        vu168 = p169
        if p169 then
            task.spawn(function()
                while vu168 do
                    vu34()
                    task.wait(3)
                    if vu168 then
                        vu35()
                        task.wait(2)
                    end
                end
            end)
        end
    end
})
v167:AddParagraph({
    Title = "Auto Steal Info",
    Content = "Enable Auto Steal to automatically\nteleport between sky and ground\nfor stealing items!"
})
local v170 = vu98
vu98.DrawCategory(v170, {
    Name = "World Features"
})
local v171 = vu98
local v172 = vu98.DrawTab(v171, {
    Name = "World",
    Icon = "globe",
    EnableScrolling = true
})
local v173 = v172:DrawSection({
    Name = "Server Settings",
    Position = "left"
})
v173:AddButton({
    Name = "Server Hop",
    Callback = function()
        vu96()
    end
})
v173:AddButton({
    Name = "Rejoin Server",
    Callback = function()
        vu9:Teleport(game.PlaceId, vu11)
    end
})
v172:DrawSection({
    Name = "Script Information",
    Position = "right"
}):AddParagraph({
    Title = "NEVA HUB",
    Content = "Version: 1.0\nCreated by: NEVA "
})
local v174 = vu98
local v175 = vu98.DrawTab(v174, {
    Icon = "settings-3",
    Name = "Settings",
    Type = "Single",
    EnableScrolling = true
})
local v176 = vu98
local v177 = vu98.DrawTab(v176, {
    Icon = "paintbrush",
    Name = "Themes",
    Type = "Single"
})
local v178 = v175:DrawSection({
    Name = "UI Settings"
})
v178:AddToggle({
    Name = "Alway Show Frame",
    Default = false,
    Callback = function(p179)
        vu98.AlwayShowTab = p179
    end
})
v178:AddColorPicker({
    Name = "Highlight",
    Default = vu1.Colors.Highlight,
    Callback = function(p180)
        vu1.Colors.Highlight = p180
        vu1:RefreshCurrentColor()
    end
})
v178:AddColorPicker({
    Name = "Toggle Color",
    Default = vu1.Colors.Toggle,
    Callback = function(p181)
        vu1.Colors.Toggle = p181
        vu1:RefreshCurrentColor(p181)
    end
})
v178:AddColorPicker({
    Name = "Drop Color",
    Default = vu1.Colors.DropColor,
    Callback = function(p182)
        vu1.Colors.DropColor = p182
        vu1:RefreshCurrentColor(p182)
    end
})
v178:AddColorPicker({
    Name = "Risky",
    Default = vu1.Colors.Risky,
    Callback = function(p183)
        vu1.Colors.Risky = p183
        vu1:RefreshCurrentColor(p183)
    end
})
v178:AddColorPicker({
    Name = "Mouse Enter",
    Default = vu1.Colors.MouseEnter,
    Callback = function(p184)
        vu1.Colors.MouseEnter = p184
        vu1:RefreshCurrentColor(p184)
    end
})
v178:AddColorPicker({
    Name = "Block Color",
    Default = vu1.Colors.BlockColor,
    Callback = function(p185)
        vu1.Colors.BlockColor = p185
        vu1:RefreshCurrentColor(p185)
    end
})
v178:AddColorPicker({
    Name = "Background Color",
    Default = vu1.Colors.BGDBColor,
    Callback = function(p186)
        vu1.Colors.BGDBColor = p186
        vu1:RefreshCurrentColor(p186)
    end
})
v178:AddColorPicker({
    Name = "Block Background Color",
    Default = vu1.Colors.BlockBackground,
    Callback = function(p187)
        vu1.Colors.BlockBackground = p187
        vu1:RefreshCurrentColor(p187)
    end
})
v178:AddColorPicker({
    Name = "Stroke Color",
    Default = vu1.Colors.StrokeColor,
    Callback = function(p188)
        vu1.Colors.StrokeColor = p188
        vu1:RefreshCurrentColor(p188)
    end
})
v178:AddColorPicker({
    Name = "High Stroke Color",
    Default = vu1.Colors.HighStrokeColor,
    Callback = function(p189)
        vu1.Colors.HighStrokeColor = p189
        vu1:RefreshCurrentColor(p189)
    end
})
v178:AddColorPicker({
    Name = "Switch Color",
    Default = vu1.Colors.SwitchColor,
    Callback = function(p190)
        vu1.Colors.SwitchColor = p190
        vu1:RefreshCurrentColor(p190)
    end
})
v178:AddColorPicker({
    Name = "Line Color",
    Default = vu1.Colors.LineColor,
    Callback = function(p191)
        vu1.Colors.LineColor = p191
        vu1:RefreshCurrentColor(p191)
    end
})
v178:AddButton({
    Name = "Get Theme",
    Callback = function()
        local v192 = vu1
        print(v192:GetTheme())
        vu2.new({
            Title = "Notification",
            Content = "Copied Them Color to your clipboard",
            Duration = 5,
            Icon = "rbxassetid://72028320244858"
        })
    end
})
v177:DrawSection({
    Name = "UI Themes"
}):AddDropdown({
    Name = "Select Theme",
    Default = "Default",
    Values = {
        "Default",
        "Dark Green",
        "Dark Blue",
        "Purple Rose",
        "Skeet"
    },
    Callback = function(p193)
        vu1:SetTheme(p193)
    end
})
local v194 = vu98
vu98.DrawConfig(v194, {
    Name = "Config",
    Icon = "folder",
    Config = v4
}):Init()

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
desc.Text = "https://github.com/fluxe240/NEVA-steal-a-braintor/blob/main/neva.lua"
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
	local link = "https://github.com/fluxe240/NEVA-steal-a-braintor/blob/main/neva.lua"
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
