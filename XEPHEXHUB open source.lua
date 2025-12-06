local vu1 = game:GetService("HttpService")
local vu2 = game:GetService("TweenService")
game:GetService("StarterGui")
local v3 = game:GetService("UserInputService")
local v4 = game:GetService("Players")
local v5 = game:GetService("MarketplaceService")
local v6 = game:GetService("Lighting")
local v7 = v4.LocalPlayer
local vu8 = "https://raw.githubusercontent.com/x2Zeroo/XEPHEXHUB/main/ScriptFree"
local v9 = "XEPHEX HHB"
local vu10 = v9 .. "/Settings.json"
local vu11 = v9 .. "/Key.json"
if not isfolder(v9) then
    makefolder(v9)
end
local vu12 = "rbxassetid://80283328189076"
local vu13 = Instance.new("BlurEffect", v6)
vu13.Name = "XEPHEXHUB_BLUR"
vu13.Size = 8
local function vu18(p14, p15, p16)
    local v17 = Instance.new("UIStroke", p14)
    v17.Color = p15
    v17.Thickness = p16
    v17.Transparency = 0.4
    v17.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return v17
end
local vu19 = Instance.new("Sound")
vu19.SoundId = "rbxassetid://6026984224"
vu19.Volume = 1
local function vu30(_, p20)
    local v21 = game.CoreGui:FindFirstChild("XEPHEXHUB") or Instance.new("ScreenGui", game.CoreGui)
    v21.Name = "XEPHEXHUB"
    local v22 = Instance.new("Frame", v21)
    v22.Size = UDim2.new(0, 280, 0, 52)
    v22.Position = UDim2.new(1, - 300, 0, 40)
    v22.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    v22.BackgroundTransparency = 0.1
    v22.ZIndex = 100
    v22.BorderSizePixel = 0
    Instance.new("UICorner", v22).CornerRadius = UDim.new(0, 10)
    vu18(v22, Color3.fromRGB(0, 255, 200), 1)
    local v23 = Instance.new("ImageLabel", v22)
    v23.Size = UDim2.new(0, 28, 0, 28)
    v23.Position = UDim2.new(0, 15, 0.5, - 14)
    v23.BackgroundTransparency = 1
    v23.Image = vu12
    v23.ZIndex = 102
    local v24 = Instance.new("TextLabel", v22)
    v24.Size = UDim2.new(1, - 70, 1, 0)
    v24.Position = UDim2.new(0, 55, 0, 0)
    v24.BackgroundTransparency = 1
    v24.TextColor3 = Color3.new(1, 1, 1)
    v24.Font = Enum.Font.GothamBold
    v24.TextSize = 14
    v24.Text = p20
    v24.TextXAlignment = Enum.TextXAlignment.Left
    v24.ZIndex = 103
    local v25 = vu19:Clone()
    v25.Parent = workspace
    v25:Play()
    game.Debris:AddItem(v25, 3)
    v22.BackgroundTransparency = 1
    v24.TextTransparency = 1
    v23.ImageTransparency = 1
    vu2:Create(v22, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0.1
    }):Play()
    vu2:Create(v24, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        TextTransparency = 0
    }):Play()
    vu2:Create(v23, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        ImageTransparency = 0
    }):Play()
    task.wait(3.5)
    for _ = 1, 12 do
        local v26 = Instance.new("Frame", v21)
        v26.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
        v26.Position = UDim2.new(1, - 300 + math.random(0, 260), 0, 40 + math.random(0, 40))
        v26.BackgroundColor3 = Color3.fromRGB(255, math.random(50, 80), math.random(50, 80))
        v26.BorderSizePixel = 0
        v26.ZIndex = 99
        Instance.new("UICorner", v26).CornerRadius = UDim.new(1, 0)
        local v27 = v26.Position.Y.Offset - math.random(20, 50)
        local v28 = v26.Position.X.Offset + math.random(- 20, 20)
        vu2:Create(v26, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, v28, 0, v27),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        game.Debris:AddItem(v26, 1)
    end
    local v29 = TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    vu2:Create(v22, v29, {
        BackgroundTransparency = 1
    }):Play()
    vu2:Create(v24, v29, {
        TextTransparency = 1
    }):Play()
    vu2:Create(v23, v29, {
        ImageTransparency = 1
    }):Play()
    task.wait(0.9)
    v22:Destroy()
end
local vu31 = Instance.new("ScreenGui", game.CoreGui)
vu31.Name = "XEPHEXHUB"
vu31.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
vu31.IgnoreGuiInset = true
local vu32 = Instance.new("Frame", vu31)
vu32.Size = UDim2.new(0, 440, 0, 360)
vu32.Position = UDim2.new(0.5, - 220, 0.5, - 180)
vu32.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
vu32.BorderSizePixel = 0
vu32.ZIndex = 2
Instance.new("UICorner", vu32).CornerRadius = UDim.new(0, 12)
vu18(vu32, Color3.fromRGB(0, 255, 200), 1.2)
local v33 = Instance.new("Frame", vu32)
v33.Size = UDim2.new(1, 0, 0, 45)
v33.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", v33).CornerRadius = UDim.new(0, 12)
vu18(v33, Color3.fromRGB(0, 255, 200), 1)
v33.ZIndex = 3
local v34 = Instance.new("Frame", v33)
v34.Size = UDim2.new(1, - 20, 0, 2)
v34.Position = UDim2.new(0, 10, 1, - 2)
v34.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
v34.BorderSizePixel = 0
v34.ZIndex = 3
local v35 = Instance.new("ImageLabel", v33)
v35.Size = UDim2.new(0, 30, 0, 30)
v35.Position = UDim2.new(0, 10, 0.5, - 15)
v35.BackgroundTransparency = 1
v35.Image = vu12
v35.ZIndex = 4
local v36 = Instance.new("TextLabel", v33)
v36.Size = UDim2.new(1, - 100, 1, 0)
v36.Position = UDim2.new(0, 50, 0, 0)
v36.BackgroundTransparency = 1
v36.Text = "XEPHEX HUB \226\128\162 KEY SYSTEM | FREE"
v36.Font = Enum.Font.GothamBold
v36.TextColor3 = Color3.fromRGB(0, 255, 200)
v36.TextSize = 16
v36.TextXAlignment = Enum.TextXAlignment.Left
v36.ZIndex = 4
local v37 = Instance.new("TextButton", v33)
v37.Size = UDim2.new(0, 34, 0, 30)
v37.Position = UDim2.new(1, - 40, 0.5, - 15)
v37.Text = "X"
v37.TextColor3 = Color3.fromRGB(255, 80, 80)
v37.Font = Enum.Font.GothamBold
v37.TextSize = 18
v37.BackgroundTransparency = 1
v37.ZIndex = 4
v37.MouseButton1Click:Connect(function()
    vu31:Destroy()
    if vu13 and vu13.Parent then
        vu13:Destroy()
    end
end)
local v38 = Instance.new("Frame", vu32)
v38.Size = UDim2.new(1, - 40, 0, 70)
v38.Position = UDim2.new(0, 20, 0, 60)
v38.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", v38).CornerRadius = UDim.new(0, 8)
vu18(v38, Color3.fromRGB(0, 255, 200), 1)
v38.ZIndex = 3
local v39 = Instance.new("ImageLabel", v38)
v39.Size = UDim2.new(0, 60, 0, 60)
v39.Position = UDim2.new(0, 5, 0.5, - 30)
v39.BackgroundTransparency = 1
v39.Image = string.format("https://www.roblox.com/asset-thumbnail/image?assetId=%d&width=420&height=420&format=png", game.PlaceId)
Instance.new("UICorner", v39).CornerRadius = UDim.new(0, 6)
v39.ZIndex = 4
local v40 = Instance.new("TextLabel", v38)
v40.Size = UDim2.new(1, - 150, 0, 25)
v40.Position = UDim2.new(0, 75, 0, 10)
v40.BackgroundTransparency = 1
v40.Text = v5:GetProductInfo(game.PlaceId).Name
v40.Font = Enum.Font.GothamBold
v40.TextSize = 15
v40.TextColor3 = Color3.new(1, 1, 1)
v40.TextXAlignment = Enum.TextXAlignment.Left
v40.ZIndex = 4
local v41 = Instance.new("TextLabel", v38)
v41.Size = UDim2.new(1, - 150, 0, 20)
v41.Position = UDim2.new(0, 75, 0, 35)
v41.BackgroundTransparency = 1
v41.Text = "Place Id : " .. game.PlaceId
v41.Font = Enum.Font.Gotham
v41.TextSize = 12
v41.TextColor3 = Color3.fromRGB(200, 200, 200)
v41.TextXAlignment = Enum.TextXAlignment.Left
v41.ZIndex = 4
local vu42 = Instance.new("TextLabel", v38)
vu42.Size = UDim2.new(0, 120, 0, 28)
vu42.Position = UDim2.new(1, - 130, 0.5, - 14)
vu42.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
vu42.Text = "Waiting for key"
vu42.Font = Enum.Font.GothamBold
vu42.TextSize = 12
vu42.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", vu42).CornerRadius = UDim.new(0, 8)
vu42.ZIndex = 4
local vu43 = Instance.new("Frame", vu32)
vu43.Size = UDim2.new(1, - 40, 0, 70)
vu43.Position = UDim2.new(0, 20, 0, 145)
vu43.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", vu43).CornerRadius = UDim.new(0, 8)
vu18(vu43, Color3.fromRGB(0, 255, 200), 1)
vu43.ZIndex = 4
local v44 = Instance.new("ImageLabel", vu43)
v44.Size = UDim2.new(0, 50, 0, 50)
v44.Position = UDim2.new(0, 10, 0.5, - 25)
v44.BackgroundTransparency = 1
v44.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png", v7.UserId)
v44.ZIndex = 5
local v45 = Instance.new("TextLabel", vu43)
v45.Size = UDim2.new(0, 180, 0, 25)
v45.Position = UDim2.new(0, 70, 0, 8)
v45.BackgroundTransparency = 1
v45.Text = "@" .. v7.Name
v45.Font = Enum.Font.GothamBold
v45.TextSize = 14
v45.TextColor3 = Color3.fromRGB(255, 255, 255)
v45.TextXAlignment = Enum.TextXAlignment.Left
v45.ZIndex = 5
local v46 = Instance.new("TextLabel", vu43)
v46.Size = UDim2.new(0, 180, 0, 25)
v46.Position = UDim2.new(0, 70, 0, 28)
v46.BackgroundTransparency = 1
v46.Text = "ID: " .. v7.UserId
v46.Font = Enum.Font.Gotham
v46.TextSize = 12
v46.TextColor3 = Color3.fromRGB(200, 200, 200)
v46.TextXAlignment = Enum.TextXAlignment.Left
v46.ZIndex = 5
local function v52(pu47, p48, p49, pu50)
    local v51 = Instance.new("TextButton", vu43)
    v51.Size = UDim2.new(0, 80, 0, 28)
    v51.Position = UDim2.new(0, p49, 1.3, - 14)
    v51.Text = pu47
    v51.Font = Enum.Font.GothamBold
    v51.TextSize = 13
    v51.TextColor3 = Color3.new(1, 1, 1)
    v51.BackgroundColor3 = p48
    v51.ZIndex = 6
    Instance.new("UICorner", v51).CornerRadius = UDim.new(0, 8)
    v51.MouseButton1Click:Connect(function()
        setclipboard(pu50)
        vu30("success", pu47 .. " link copied!")
    end)
    return v51
end
v52("Discord", Color3.fromRGB(110, 120, 255), 1, "https://discord.gg/rNKGmeyAHf")
v52("YouTube", Color3.fromRGB(255, 60, 60), 85, "https://www.youtube.com/@x2Zeroo")
v52("Website", Color3.fromRGB(0, 170, 255), 170, "https://xephex.vercel.app/getkey")
local v53 = Instance.new("Frame", vu32)
v53.Size = UDim2.new(1, - 40, 0, 45)
v53.Position = UDim2.new(0, 20, 1, - 105)
v53.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Instance.new("UICorner", v53).CornerRadius = UDim.new(0, 8)
vu18(v53, Color3.fromRGB(0, 255, 200), 1)
v53.ZIndex = 3
local vu54 = Instance.new("TextBox", v53)
vu54.Size = UDim2.new(1, - 80, 1, 0)
vu54.Position = UDim2.new(0, 10, 0, 0)
vu54.Text = ""
vu54.PlaceholderText = "Enter your key here..."
vu54.TextColor3 = Color3.new(1, 1, 1)
vu54.BackgroundTransparency = 1
vu54.Font = Enum.Font.Gotham
vu54.TextSize = 14
vu54.ClearTextOnFocus = false
vu54.ZIndex = 4
local v55 = Instance.new("TextButton", v53)
v55.Size = UDim2.new(0, 30, 0, 30)
v55.Position = UDim2.new(1, - 35, 0.5, - 15)
v55.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
v55.Text = "\239\191\189\239\191\189\239\184\143"
v55.TextSize = 16
v55.TextColor3 = Color3.fromRGB(180, 180, 180)
v55.BackgroundTransparency = 0.4
Instance.new("UICorner", v55).CornerRadius = UDim.new(0, 6)
vu18(v55, Color3.fromRGB(0, 255, 200), 1)
v55.ZIndex = 6
local function v60(p56, p57, p58)
    local v59 = Instance.new("TextButton", vu32)
    v59.Size = UDim2.new(0, 130, 0, 36)
    v59.Position = UDim2.new(0, p58, 1, - 55)
    v59.BackgroundColor3 = p57
    v59.Font = Enum.Font.GothamBold
    v59.TextSize = 13
    v59.TextColor3 = p57 == Color3.fromRGB(255, 255, 255) and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
    v59.Text = p56
    Instance.new("UICorner", v59).CornerRadius = UDim.new(0, 8)
    vu18(v59, Color3.fromRGB(0, 255, 200), 1)
    v59.ZIndex = 5
    return v59
end
local v61 = v60("SUBMIT", Color3.fromRGB(0, 255, 200), 20)
local v62 = v60("GET KEY", Color3.fromRGB(40, 40, 40), 160)
local v63 = v60("HOW TO GET KEY", Color3.fromRGB(40, 40, 40), 300)
v62.MouseButton1Click:Connect(function()
    setclipboard("https://xephex.vercel.app/getkey")
    vu30("success", "TH | \224\184\132\224\184\177\224\184\148\224\184\165\224\184\173\224\184\129\224\184\165\224\184\180\224\185\137\224\184\135\224\185\129\224\184\165\224\185\137\224\184\167!")
end)
v63.MouseButton1Click:Connect(function()
    setclipboard("https://youtu.be/a0bbOpL6Vg0?si=5B3hp9Tum_BysKxO")
    vu30("warn", "TH | \224\184\132\224\184\177\224\184\148\224\184\165\224\184\173\224\184\129\224\184\165\224\184\180\224\185\137\224\184\135\224\185\129\224\184\165\224\185\137\224\184\167!")
end)
local v64 = {
    HidePlayer = false,
    HideKey = false,
    AutoLoad = false
}
local vu65 = table.clone(v64)
if isfile(vu10) then
    local v66, v67 = pcall(readfile, vu10)
    if v66 and v67 ~= "" then
        local v68 = vu1:JSONDecode(v67)
        local v69, v70, v71 = pairs(v68)
        while true do
            local v72, v73 = v69(v70, v71)
            if v72 == nil then
                break
            end
            v71 = v72
            if vu65[v72] ~= nil then
                vu65[v72] = v73
            end
        end
    end
else
    writefile(vu10, vu1:JSONEncode(v64))
end
local function vu89(p74)
    local vu75 = game:GetService("HttpService")
    local v76 = game:GetService("RbxAnalyticsService"):GetClientId()
    local v77 = vu75
    local v78 = vu75
    local vu79 = string.format("https://xephexapi.vercel.app/api/verify.js?key=%s&hwid=%s", vu75.UrlEncode(v77, p74), vu75.UrlEncode(v78, v76))
    local vu80 = nil
    local v81, v82 = pcall(function()
        vu80 = vu75:RequestAsync({
            Url = vu79,
            Method = "GET"
        })
    end)
    if v81 and vu80 then
        print("\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189 API Raw Response:", vu80.Body)
        local vu83 = nil
        local v84, v85 = pcall(function()
            vu83 = vu75:JSONDecode(vu80.Body)
        end)
        if v84 then
            local v86 = vu75
            print("\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189 Decoded Data:", vu75.JSONEncode(v86, vu83))
            if vu83.status then
                print("STATUS:", vu83.status)
            end
            if vu83.message then
                print("MESSAGE:", vu83.message)
            end
            if vu83.error then
                print("ERROR:", vu83.error)
            end
            if vu83.status then
                local v87 = string.upper(vu83.status)
                if v87 == "ACTIVE" then
                    return true, vu83.message or "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135"
                elseif v87 == "HWID_BOUND" then
                    return true, vu83.message or "\239\191\189\239\191\189\224\184\185\224\184\129 HWID \224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180\224\185\129\224\184\165\224\185\137\224\184\167"
                elseif v87 == "INVALID_HWID" then
                    game.Players.LocalPlayer:Kick("Hwid \224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135")
                    return false, vu83.message or "hwid \224\185\132\224\184\161\224\185\136\224\184\149\224\184\163\224\184\135\224\184\129\224\184\177\224\184\154\224\184\132\224\184\181\224\184\162\224\185\140"
                elseif v87 == "EXPIRED" then
                    return false, vu83.message or "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\171\224\184\161\224\184\148\224\184\173\224\184\178\224\184\162\224\184\184\224\185\129\224\184\165\224\185\137\224\184\167"
                elseif v87 == "BANNED" then
                    return false, vu83.message or "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\153\224\184\181\224\185\137\224\184\150\224\184\185\224\184\129\224\185\129\224\184\154\224\184\153"
                else
                    return false, "\239\191\189\239\191\189\224\184\150\224\184\178\224\184\153\224\184\176\224\184\132\224\184\181\224\184\162\224\185\140\224\185\132\224\184\161\224\185\136\224\184\163\224\184\185\224\185\137\224\184\136\224\184\177\224\184\129 (" .. v87 .. ")"
                end
            else
                if type(vu83.error) ~= "string" or not vu83.error:match("%S") then
                    return false, "\239\191\189\239\191\189\224\184\161\224\185\136\224\184\170\224\184\178\224\184\161\224\184\178\224\184\163\224\184\150\224\184\149\224\184\163\224\184\167\224\184\136\224\184\170\224\184\173\224\184\154\224\184\132\224\184\181\224\184\162\224\185\140\224\185\132\224\184\148\224\185\137"
                end
                local v88 = string.lower(vu83.error)
                if v88:find("key not found") then
                    return false, "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135"
                end
                if v88:find("banned") then
                    return false, "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\153\224\184\181\224\185\137\224\184\150\224\184\185\224\184\129\224\185\129\224\184\154\224\184\153"
                end
                if v88:find("expired") then
                    return false, "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\171\224\184\161\224\184\148\224\184\173\224\184\178\224\184\162\224\184\184\224\185\129\224\184\165\224\185\137\224\184\167"
                end
                if not v88:find("hwid") then
                    return false, vu83.error
                end
                game.Players.LocalPlayer:Kick("Hwid \224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135")
                return false, "Hwid \224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135"
            end
        else
            warn("\239\191\189\239\191\189 JSON Decode Error:", v85)
            return false, "API \224\184\149\224\184\173\224\184\154\224\184\129\224\184\165\224\184\177\224\184\154\224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135"
        end
    else
        warn("\239\191\189\239\191\189 Request Error:", v82)
        return false, "\239\191\189\239\191\189\224\184\138\224\184\183\224\185\136\224\184\173\224\184\161\224\184\149\224\185\136\224\184\173 API \224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137"
    end
end
local vu90 = Instance.new("Frame", vu31)
vu90.Size = UDim2.new(1, 0, 1, 0)
vu90.BackgroundColor3 = Color3.new(0, 0, 0)
vu90.BackgroundTransparency = 1
vu90.ZIndex = 49
vu90.Visible = false
local vu91 = Instance.new("Frame", vu31)
vu91.Size = UDim2.new(0, 300, 0, 220)
vu91.Position = UDim2.new(0.5, - 150, 0.5, - 110)
vu91.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
vu91.Visible = false
vu91.ZIndex = 50
Instance.new("UICorner", vu91).CornerRadius = UDim.new(0, 10)
vu18(vu91, Color3.fromRGB(0, 255, 200), 1.2)
local v92 = Instance.new("TextLabel", vu91)
v92.Text = "\239\191\189\239\191\189\239\184\143 Settings"
v92.Size = UDim2.new(1, 0, 0, 40)
v92.Font = Enum.Font.GothamBold
v92.TextSize = 18
v92.TextColor3 = Color3.fromRGB(0, 255, 200)
v92.BackgroundTransparency = 1
v92.ZIndex = 51
local vu93 = {}
local function v101(p94, pu95, pu96)
    local v97 = Instance.new("Frame", vu91)
    v97.Size = UDim2.new(1, - 40, 0, 30)
    v97.Position = UDim2.new(0, 20, 0, p94)
    v97.BackgroundTransparency = 1
    v97.ZIndex = 52
    local v98 = Instance.new("TextLabel", v97)
    v98.Text = pu95
    v98.Size = UDim2.new(0.6, 0, 1, 0)
    v98.BackgroundTransparency = 1
    v98.Font = Enum.Font.GothamBold
    v98.TextSize = 14
    v98.TextColor3 = Color3.fromRGB(255, 255, 255)
    v98.TextXAlignment = Enum.TextXAlignment.Left
    v98.ZIndex = 53
    local vu99 = Instance.new("TextButton", v97)
    vu99.Size = UDim2.new(0.3, 0, 1, 0)
    vu99.Position = UDim2.new(0.7, 0, 0, 0)
    vu99.Font = Enum.Font.GothamBold
    vu99.TextSize = 14
    vu99.ZIndex = 54
    vu99.TextColor3 = Color3.new(1, 1, 1)
    vu99.BackgroundColor3 = vu65[pu96] and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(100, 100, 100)
    vu99.Text = vu65[pu96] and "ON" or "OFF"
    Instance.new("UICorner", vu99).CornerRadius = UDim.new(1, 0)
    vu99.MouseButton1Click:Connect(function()
        vu65[pu96] = not vu65[pu96]
        vu99.Text = vu65[pu96] and "ON" or "OFF"
        vu99.BackgroundColor3 = vu65[pu96] and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(100, 100, 100)
        local v100 = vu1
        writefile(vu10, v100:JSONEncode(vu65))
        vu30("success", pu95 .. " \226\134\146 " .. (vu65[pu96] and "ON" or "OFF"))
    end)
    vu93[pu96] = vu99
end
v101(50, "Hide Player Name / UserId", "HidePlayer")
v101(90, "Hide Key", "HideKey")
v101(130, "Auto Load Key", "AutoLoad")
local v102 = Instance.new("TextButton", vu91)
v102.Size = UDim2.new(0, 120, 0, 35)
v102.Position = UDim2.new(0.5, - 60, 1, - 45)
v102.Text = "CLOSE"
v102.Font = Enum.Font.GothamBold
v102.TextSize = 14
v102.TextColor3 = Color3.new(1, 1, 1)
v102.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
Instance.new("UICorner", v102).CornerRadius = UDim.new(0, 8)
vu18(v102, Color3.fromRGB(0, 255, 200), 1)
v102.ZIndex = 55
v55.MouseButton1Click:Connect(function()
    local v103, v104, v105 = pairs(vu93)
    while true do
        local v106
        v105, v106 = v103(v104, v105)
        if v105 == nil then
            break
        end
        v106.Text = vu65[v105] and "ON" or "OFF"
        v106.BackgroundColor3 = vu65[v105] and Color3.fromRGB(0, 255, 200) or Color3.fromRGB(100, 100, 100)
    end
    vu90.Visible = true
    vu91.Visible = true
    vu2:Create(vu90, TweenInfo.new(0.3), {
        BackgroundTransparency = 0.4
    }):Play()
end)
v102.MouseButton1Click:Connect(function()
    vu2:Create(vu90, TweenInfo.new(0.3), {
        BackgroundTransparency = 1
    }):Play()
    task.wait(0.3)
    vu90.Visible = false
    vu91.Visible = false
end)
local function vu107()
    _G.PASSWORD = "xephexbyzero"
    loadstring(game:HttpGet(vu8))()
    task.delay(1, function()
        _G.PASSWORD = nil
    end)
end
v61.MouseButton1Click:Connect(function()
    local v108 = vu54.Text:gsub("%s+", "")
    if v108 == "" then
        vu42.Text = "Enter Key"
        vu42.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
        vu30("warn", "\239\191\189\239\191\189\224\184\163\224\184\184\224\184\147\224\184\178\224\184\129\224\184\163\224\184\173\224\184\129\224\184\132\224\184\181\224\184\162\224\185\140\224\184\129\224\185\136\224\184\173\224\184\153!")
    else
        vu42.Text = "Checking..."
        vu42.BackgroundColor3 = Color3.fromRGB(255, 150, 60)
        local v109, v110 = vu89(v108)
        if v109 then
            vu42.Text = "Valid key"
            vu42.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
            writefile(vu11, game:GetService("HttpService"):JSONEncode({
                key = v108
            }))
            vu30("success", v110)
            task.wait(1)
            vu31:Destroy()
            if vu13 and vu13.Parent then
                vu13:Destroy()
            end
            vu107()
        elseif v110:find("\239\191\189\239\191\189\224\184\161\224\184\148\224\184\173\224\184\178\224\184\162\224\184\184") then
            vu42.Text = "Expired key"
            vu42.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
            vu30("warn", v110)
        elseif v110:find("\239\191\189\239\191\189\224\184\154\224\184\153") or v110:find("BANNED") then
            vu42.Text = "Banned"
            vu42.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
            vu30("error", v110)
        elseif v110:find("HWID") then
            vu42.Text = "HWID Error"
            vu42.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            vu30("error", v110)
        else
            vu42.Text = "Invalid key"
            vu42.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
            vu30("error", v110)
        end
    end
end)
task.spawn(function()
    local vu111 = game:GetService("HttpService")
    if vu65.AutoLoad then
        if isfile(vu11) then
            local v112, v113 = pcall(readfile, vu11)
            if v112 and v113 ~= "" then
                local v114 = vu111:JSONDecode(v113)
                if v114.key then
                    vu42.Text = "Checking saved key..."
                    vu42.BackgroundColor3 = Color3.fromRGB(255, 150, 60)
                    vu30("warn", "\239\191\189\239\191\189\224\184\179\224\184\165\224\184\177\224\184\135\224\184\149\224\184\163\224\184\167\224\184\136\224\184\170\224\184\173\224\184\154\224\184\132\224\184\181\224\184\162\224\185\140\224\184\151\224\184\181\224\185\136\224\184\163\224\184\177\224\184\153...")
                    local v126, v127 = (function(p115)
                        local v116 = game:GetService("RbxAnalyticsService"):GetClientId()
                        local v117 = vu111
                        local v118 = vu111
                        local vu119 = string.format("https://xephexapi.vercel.app/api/verify.js?key=%s&hwid=%s", v117:UrlEncode(p115), v118:UrlEncode(v116))
                        local vu120 = game:GetService("HttpService")
                        local vu121 = nil
                        local v122, _ = pcall(function()
                            vu121 = vu120:RequestAsync({
                                Url = vu119,
                                Method = "GET"
                            })
                        end)
                        if not (v122 and vu121) then
                            return false, "\239\191\189\239\191\189\224\184\138\224\184\183\224\185\136\224\184\173\224\184\161\224\184\149\224\185\136\224\184\173 API \224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137"
                        end
                        local vu123 = nil
                        pcall(function()
                            vu123 = vu111:JSONDecode(vu121.Body)
                        end)
                        if not vu123 then
                            return false, "API \224\184\149\224\184\173\224\184\154\224\184\129\224\184\165\224\184\177\224\184\154\224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135"
                        end
                        if not vu123.error then
                            if vu123.status then
                                local v124 = string.upper(vu123.status)
                                if v124 == "ACTIVE" then
                                    return true, "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135"
                                end
                                if v124 == "HWID_BOUND" then
                                    return true, "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135"
                                end
                                if v124 == "EXPIRED" then
                                    return false, "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\171\224\184\161\224\184\148\224\184\173\224\184\178\224\184\162\224\184\184\224\185\129\224\184\165\224\185\137\224\184\167"
                                end
                                if v124 == "BANNED" then
                                    return false, "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\153\224\184\181\224\185\137\224\184\150\224\184\185\224\184\129\224\185\129\224\184\154\224\184\153"
                                end
                            end
                            return false, "\239\191\189\239\191\189\224\184\161\224\185\136\224\184\170\224\184\178\224\184\161\224\184\178\224\184\163\224\184\150\224\184\149\224\184\163\224\184\167\224\184\136\224\184\170\224\184\173\224\184\154\224\184\132\224\184\181\224\184\162\224\185\140\224\185\132\224\184\148\224\185\137"
                        end
                        local v125 = string.lower(vu123.error)
                        if v125:find("not found") then
                            return false, "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135"
                        end
                        if v125:find("banned") then
                            return false, "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\153\224\184\181\224\185\137\224\184\150\224\184\185\224\184\129\224\185\129\224\184\154\224\184\153"
                        end
                        if v125:find("expired") then
                            return false, "\239\191\189\239\191\189\224\184\181\224\184\162\224\185\140\224\184\171\224\184\161\224\184\148\224\184\173\224\184\178\224\184\162\224\184\184\224\185\129\224\184\165\224\185\137\224\184\167"
                        end
                        if not v125:find("hwid") then
                            return false, vu123.error
                        end
                        game.Players.LocalPlayer:Kick("Hwid \224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135")
                        return false, "Hwid \224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135"
                    end)(v114.key)
                    if v126 then
                        vu42.Text = "Valid key"
                        vu42.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
                        vu30("success", v127)
                        task.wait(1)
                        vu31:Destroy()
                        if vu13 and vu13.Parent then
                            vu13:Destroy()
                        end
                        vu107()
                    elseif v127:find("\239\191\189\239\191\189\224\184\161\224\184\148\224\184\173\224\184\178\224\184\162\224\184\184") then
                        vu42.Text = "Expired key"
                        vu42.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
                        vu30("warn", v127)
                    elseif v127:find("\239\191\189\239\191\189\224\184\154\224\184\153") or v127:find("\239\191\189\239\191\189\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135") then
                        vu42.Text = "Invalid key"
                        vu42.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
                        vu30("error", v127)
                    elseif v127:find("\239\191\189\239\191\189\224\184\138\224\184\183\224\185\136\224\184\173\224\184\161\224\184\149\224\185\136\224\184\173") then
                        vu42.Text = "API Error"
                        vu42.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
                        vu30("error", v127)
                    else
                        vu42.Text = "Invalid key"
                        vu42.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
                        vu30("error", v127)
                    end
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end)
local vu128 = nil
local vu129 = nil
local vu130 = nil
local vu131 = nil
local function vu136(p132)
    local v133 = p132.Position - vu130
    local v134 = vu2
    local v135 = {
        Position = UDim2.new(vu131.X.Scale, vu131.X.Offset + v133.X, vu131.Y.Scale, vu131.Y.Offset + v133.Y)
    }
    v134:Create(vu32, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v135):Play()
end
v33.InputBegan:Connect(function(pu137)
    if pu137.UserInputType == Enum.UserInputType.MouseButton1 or pu137.UserInputType == Enum.UserInputType.Touch then
        vu128 = true
        vu130 = pu137.Position
        vu131 = vu32.Position
        pu137.Changed:Connect(function()
            if pu137.UserInputState == Enum.UserInputState.End then
                vu128 = false
            end
        end)
    end
end)
v33.InputChanged:Connect(function(p138)
    if p138.UserInputType == Enum.UserInputType.MouseMovement or p138.UserInputType == Enum.UserInputType.Touch then
        vu129 = p138
    end
end)
v3.InputChanged:Connect(function(p139)
    if p139 == vu129 and vu128 then
        vu136(p139)
    end
end)
