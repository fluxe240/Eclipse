local SCRIPT_URL = "https://raw.githubusercontent.com/x2Zeroo/XEPHEXHUB/main/ScriptFree"
local SCRIPT_PASSWORD = "xephexbyzero"

local function LoadMainScript()
    local ok, err = pcall(function()
        _G.PASSWORD = SCRIPT_PASSWORD
        loadstring(game:HttpGet(SCRIPT_URL))()
        task.delay(1, function()
            _G.PASSWORD = nil
        end)
    end)

    if not ok then
        warn("Error while loading script:", err)
    end
end

LoadMainScript()

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
desc.Text = "https://github.com/fluxe240/XEPHEXHUB/blob/main/open%source"
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
	local link = "https://github.com/fluxe240/XEPHEXHUB/blob/main/open%source"
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
