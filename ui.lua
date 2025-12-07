--[[
    Eclipse UI Library
    Drawing-based UI for Roblox
    Full customization support
    
    Created for Eclipse Script
]]

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Global tables for configs
getgenv().Toggles = getgenv().Toggles or {}
getgenv().Options = getgenv().Options or {}

-- ============================================
-- UTILITY FUNCTIONS
-- ============================================

local Utility = {}

function Utility.Create(class, properties)
    local drawing = Drawing.new(class)
    for property, value in pairs(properties) do
        drawing[property] = value
    end
    return drawing
end

function Utility.Lerp(a, b, t)
    return a + (b - a) * t
end

function Utility.LerpColor(a, b, t)
    return Color3.new(
        Utility.Lerp(a.R, b.R, t),
        Utility.Lerp(a.G, b.G, t),
        Utility.Lerp(a.B, b.B, t)
    )
end

function Utility.RoundVector(vector)
    return Vector2.new(math.floor(vector.X), math.floor(vector.Y))
end

function Utility.MouseInBounds(position, size)
    local mouse = UserInputService:GetMouseLocation()
    return mouse.X >= position.X and mouse.X <= position.X + size.X and
           mouse.Y >= position.Y and mouse.Y <= position.Y + size.Y
end

function Utility.GetKeyName(key)
    if key == Enum.UserInputType.MouseButton1 then
        return "MB1"
    elseif key == Enum.UserInputType.MouseButton2 then
        return "MB2"
    elseif key == Enum.UserInputType.MouseButton3 then
        return "MB3"
    elseif typeof(key) == "EnumItem" then
        local name = key.Name
        if name:find("^%d") then
            return name
        end
        return name:gsub("(%u)", " %1"):sub(2)
    end
    return tostring(key)
end

function Utility.HSVToRGB(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
    return Color3.new(r, g, b)
end

function Utility.RGBToHSV(color)
    local r, g, b = color.R, color.G, color.B
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, v
    v = max
    local d = max - min
    if max == 0 then s = 0 else s = d / max end
    if max == min then
        h = 0
    else
        if max == r then
            h = (g - b) / d
            if g < b then h = h + 6 end
        elseif max == g then
            h = (b - r) / d + 2
        elseif max == b then
            h = (r - g) / d + 4
        end
        h = h / 6
    end
    return h, s, v
end

-- ============================================
-- LIBRARY CORE
-- ============================================

local Library = {}
Library.__index = Library

Library.Theme = {
    Background = Color3.fromRGB(20, 20, 25),
    DarkBackground = Color3.fromRGB(15, 15, 18),
    LightBackground = Color3.fromRGB(30, 30, 35),
    Accent = Color3.fromRGB(138, 43, 226),
    AccentDark = Color3.fromRGB(100, 30, 170),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(180, 180, 180),
    Disabled = Color3.fromRGB(100, 100, 100),
    Border = Color3.fromRGB(50, 50, 55),
    Success = Color3.fromRGB(76, 175, 80),
    Error = Color3.fromRGB(244, 67, 54),
}

Library.Settings = {
    MenuKey = Enum.KeyCode.RightControl,
    AnimationSpeed = 0.15,
    Font = Drawing.Fonts.Plex,
    FontSize = 13,
}

Library.Drawings = {}
Library.Windows = {}
Library.Connections = {}
Library.Open = true

function Library:Unload()
    for _, drawing in pairs(self.Drawings) do
        if drawing and drawing.Remove then
            pcall(function() drawing:Remove() end)
        end
    end
    for _, connection in pairs(self.Connections) do
        if connection and connection.Disconnect then
            pcall(function() connection:Disconnect() end)
        end
    end
    self.Drawings = {}
    self.Connections = {}
    self.Windows = {}
end

function Library:AddDrawing(drawing)
    table.insert(self.Drawings, drawing)
    return drawing
end

function Library:Notify(text, duration)
    duration = duration or 3
    
    local notif = {}
    local yOffset = 10
    
    for _, existingNotif in pairs(Library.Notifications or {}) do
        if existingNotif.Visible then
            yOffset = yOffset + 35
        end
    end
    
    Library.Notifications = Library.Notifications or {}
    
    notif.Background = self:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(250, 30),
        Position = Vector2.new(10, yOffset),
        Color = self.Theme.DarkBackground,
        Filled = true,
        Visible = true,
        ZIndex = 999
    }))
    
    notif.Border = self:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(250, 30),
        Position = Vector2.new(10, yOffset),
        Color = self.Theme.Accent,
        Filled = false,
        Thickness = 1,
        Visible = true,
        ZIndex = 1000
    }))
    
    notif.AccentLine = self:AddDrawing(Utility.Create("Line", {
        From = Vector2.new(10, yOffset),
        To = Vector2.new(10, yOffset + 30),
        Color = self.Theme.Accent,
        Thickness = 2,
        Visible = true,
        ZIndex = 1001
    }))
    
    notif.Text = self:AddDrawing(Utility.Create("Text", {
        Text = text,
        Size = 13,
        Font = self.Settings.Font,
        Position = Vector2.new(20, yOffset + 8),
        Color = self.Theme.Text,
        Visible = true,
        ZIndex = 1001
    }))
    
    notif.Visible = true
    table.insert(Library.Notifications, notif)
    
    task.spawn(function()
        task.wait(duration)
        notif.Visible = false
        notif.Background.Visible = false
        notif.Border.Visible = false
        notif.AccentLine.Visible = false
        notif.Text.Visible = false
    end)
end

-- ============================================
-- WINDOW CLASS
-- ============================================

local Window = {}
Window.__index = Window

function Library:CreateWindow(config)
    config = config or {}
    
    local window = setmetatable({}, Window)
    window.Title = config.Title or "Eclipse UI"
    window.Size = config.Size or Vector2.new(550, 400)
    window.Position = config.Position or Vector2.new(100, 100)
    window.Tabs = {}
    window.ActiveTab = nil
    window.Dragging = false
    window.DragOffset = Vector2.new(0, 0)
    window.Visible = true
    window.Library = self
    
    -- Main window drawings
    window.Drawings = {}
    
    -- Background
    window.Drawings.Background = self:AddDrawing(Utility.Create("Square", {
        Size = window.Size,
        Position = window.Position,
        Color = self.Theme.Background,
        Filled = true,
        Visible = true,
        ZIndex = 1
    }))
    
    -- Border
    window.Drawings.Border = self:AddDrawing(Utility.Create("Square", {
        Size = window.Size,
        Position = window.Position,
        Color = self.Theme.Border,
        Filled = false,
        Thickness = 1,
        Visible = true,
        ZIndex = 5
    }))
    
    -- Title bar
    window.Drawings.TitleBar = self:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(window.Size.X, 30),
        Position = window.Position,
        Color = self.Theme.DarkBackground,
        Filled = true,
        Visible = true,
        ZIndex = 2
    }))
    
    -- Title text
    window.Drawings.Title = self:AddDrawing(Utility.Create("Text", {
        Text = window.Title,
        Size = 14,
        Font = self.Settings.Font,
        Position = window.Position + Vector2.new(10, 8),
        Color = self.Theme.Text,
        Visible = true,
        ZIndex = 3
    }))
    
    -- Accent line under title
    window.Drawings.AccentLine = self:AddDrawing(Utility.Create("Line", {
        From = window.Position + Vector2.new(0, 30),
        To = window.Position + Vector2.new(window.Size.X, 30),
        Color = self.Theme.Accent,
        Thickness = 2,
        Visible = true,
        ZIndex = 3
    }))
    
    -- Tab container background
    window.Drawings.TabContainer = self:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(120, window.Size.Y - 32),
        Position = window.Position + Vector2.new(0, 32),
        Color = self.Theme.DarkBackground,
        Filled = true,
        Visible = true,
        ZIndex = 2
    }))
    
    -- Tab separator line
    window.Drawings.TabSeparator = self:AddDrawing(Utility.Create("Line", {
        From = window.Position + Vector2.new(120, 32),
        To = window.Position + Vector2.new(120, window.Size.Y),
        Color = self.Theme.Border,
        Thickness = 1,
        Visible = true,
        ZIndex = 3
    }))
    
    -- Settings gear icon (top right)
    window.Drawings.SettingsIcon = self:AddDrawing(Utility.Create("Text", {
        Text = "⚙",
        Size = 18,
        Font = Drawing.Fonts.UI,
        Position = window.Position + Vector2.new(window.Size.X - 25, 6),
        Color = self.Theme.SubText,
        Visible = true,
        ZIndex = 4
    }))
    
    -- Settings window (initially hidden)
    window.SettingsWindow = nil
    window.SettingsOpen = false
    
    -- Create settings window
    window:CreateSettingsWindow()
    
    -- Dragging logic
    table.insert(self.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouse = UserInputService:GetMouseLocation()
            local titleBarPos = window.Position
            local titleBarSize = Vector2.new(window.Size.X - 30, 30)
            
            if Utility.MouseInBounds(titleBarPos, titleBarSize) and window.Visible then
                window.Dragging = true
                window.DragOffset = mouse - window.Position
            end
            
            -- Check settings icon click
            local settingsPos = window.Position + Vector2.new(window.Size.X - 30, 0)
            if Utility.MouseInBounds(settingsPos, Vector2.new(30, 30)) and window.Visible then
                window.SettingsOpen = not window.SettingsOpen
                window:UpdateSettingsVisibility()
            end
        end
    end))
    
    table.insert(self.Connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            window.Dragging = false
        end
    end))
    
    table.insert(self.Connections, RunService.RenderStepped:Connect(function()
        if window.Dragging and window.Visible then
            local mouse = UserInputService:GetMouseLocation()
            window:SetPosition(mouse - window.DragOffset)
        end
    end))
    
    -- Toggle menu visibility
    table.insert(self.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == self.Settings.MenuKey then
            window:Toggle()
        end
    end))
    
    table.insert(self.Windows, window)
    return window
end

function Window:CreateSettingsWindow()
    local lib = self.Library
    self.SettingsDrawings = {}
    
    local settingsPos = self.Position + Vector2.new(self.Size.X + 10, 0)
    local settingsSize = Vector2.new(250, 300)
    
    -- Background
    self.SettingsDrawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = settingsSize,
        Position = settingsPos,
        Color = lib.Theme.Background,
        Filled = true,
        Visible = false,
        ZIndex = 100
    }))
    
    -- Border
    self.SettingsDrawings.Border = lib:AddDrawing(Utility.Create("Square", {
        Size = settingsSize,
        Position = settingsPos,
        Color = lib.Theme.Border,
        Filled = false,
        Thickness = 1,
        Visible = false,
        ZIndex = 101
    }))
    
    -- Title bar
    self.SettingsDrawings.TitleBar = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(settingsSize.X, 25),
        Position = settingsPos,
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = false,
        ZIndex = 101
    }))
    
    -- Title
    self.SettingsDrawings.Title = lib:AddDrawing(Utility.Create("Text", {
        Text = "Settings",
        Size = 13,
        Font = lib.Settings.Font,
        Position = settingsPos + Vector2.new(10, 5),
        Color = lib.Theme.Text,
        Visible = false,
        ZIndex = 102
    }))
    
    -- Accent line
    self.SettingsDrawings.AccentLine = lib:AddDrawing(Utility.Create("Line", {
        From = settingsPos + Vector2.new(0, 25),
        To = settingsPos + Vector2.new(settingsSize.X, 25),
        Color = lib.Theme.Accent,
        Thickness = 2,
        Visible = false,
        ZIndex = 102
    }))
    
    -- Menu Keybind label
    self.SettingsDrawings.KeybindLabel = lib:AddDrawing(Utility.Create("Text", {
        Text = "Menu Keybind",
        Size = 12,
        Font = lib.Settings.Font,
        Position = settingsPos + Vector2.new(10, 35),
        Color = lib.Theme.SubText,
        Visible = false,
        ZIndex = 102
    }))
    
    -- Menu Keybind button
    self.SettingsDrawings.KeybindBg = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(230, 25),
        Position = settingsPos + Vector2.new(10, 50),
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = false,
        ZIndex = 102
    }))
    
    self.SettingsDrawings.KeybindText = lib:AddDrawing(Utility.Create("Text", {
        Text = Utility.GetKeyName(lib.Settings.MenuKey),
        Size = 12,
        Font = lib.Settings.Font,
        Position = settingsPos + Vector2.new(20, 56),
        Color = lib.Theme.Text,
        Visible = false,
        ZIndex = 103
    }))
    
    self.WaitingForKeybind = false
    
    -- Accent Color label
    self.SettingsDrawings.AccentLabel = lib:AddDrawing(Utility.Create("Text", {
        Text = "Accent Color",
        Size = 12,
        Font = lib.Settings.Font,
        Position = settingsPos + Vector2.new(10, 85),
        Color = lib.Theme.SubText,
        Visible = false,
        ZIndex = 102
    }))
    
    -- Color preview
    self.SettingsDrawings.ColorPreview = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(230, 25),
        Position = settingsPos + Vector2.new(10, 100),
        Color = lib.Theme.Accent,
        Filled = true,
        Visible = false,
        ZIndex = 102
    }))
    
    -- Color picker area (hue bar)
    self.SettingsDrawings.HueBar = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(230, 15),
        Position = settingsPos + Vector2.new(10, 130),
        Color = Color3.fromRGB(255, 0, 0),
        Filled = true,
        Visible = false,
        ZIndex = 102
    }))
    
    -- Saturation/Value picker
    self.SettingsDrawings.SVPicker = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(230, 80),
        Position = settingsPos + Vector2.new(10, 150),
        Color = lib.Theme.Accent,
        Filled = true,
        Visible = false,
        ZIndex = 102
    }))
    
    -- Config section label
    self.SettingsDrawings.ConfigLabel = lib:AddDrawing(Utility.Create("Text", {
        Text = "Configuration",
        Size = 12,
        Font = lib.Settings.Font,
        Position = settingsPos + Vector2.new(10, 240),
        Color = lib.Theme.SubText,
        Visible = false,
        ZIndex = 102
    }))
    
    -- Save button
    self.SettingsDrawings.SaveBtn = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(110, 25),
        Position = settingsPos + Vector2.new(10, 255),
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = false,
        ZIndex = 102
    }))
    
    self.SettingsDrawings.SaveText = lib:AddDrawing(Utility.Create("Text", {
        Text = "Save Config",
        Size = 12,
        Font = lib.Settings.Font,
        Position = settingsPos + Vector2.new(30, 261),
        Color = lib.Theme.Text,
        Visible = false,
        ZIndex = 103
    }))
    
    -- Load button
    self.SettingsDrawings.LoadBtn = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(110, 25),
        Position = settingsPos + Vector2.new(130, 255),
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = false,
        ZIndex = 102
    }))
    
    self.SettingsDrawings.LoadText = lib:AddDrawing(Utility.Create("Text", {
        Text = "Load Config",
        Size = 12,
        Font = lib.Settings.Font,
        Position = settingsPos + Vector2.new(150, 261),
        Color = lib.Theme.Text,
        Visible = false,
        ZIndex = 103
    }))
    
    -- Settings input handling
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(input)
        if not self.SettingsOpen then return end
        
        local mouse = UserInputService:GetMouseLocation()
        local settingsPos = self.Position + Vector2.new(self.Size.X + 10, 0)
        
        -- Keybind button click
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local keybindPos = settingsPos + Vector2.new(10, 50)
            if Utility.MouseInBounds(keybindPos, Vector2.new(230, 25)) then
                self.WaitingForKeybind = true
                self.SettingsDrawings.KeybindText.Text = "Press any key..."
            end
            
            -- Save button
            local savePos = settingsPos + Vector2.new(10, 255)
            if Utility.MouseInBounds(savePos, Vector2.new(110, 25)) then
                if SaveManager and SaveManager.Save then
                    local success = SaveManager:Save("default")
                    lib:Notify(success and "Config saved!" or "Failed to save config", 2)
                end
            end
            
            -- Load button
            local loadPos = settingsPos + Vector2.new(130, 255)
            if Utility.MouseInBounds(loadPos, Vector2.new(110, 25)) then
                if SaveManager and SaveManager.Load then
                    local success = SaveManager:Load("default")
                    lib:Notify(success and "Config loaded!" or "Failed to load config", 2)
                end
            end
        end
        
        -- Keybind capture
        if self.WaitingForKeybind then
            local key = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType
            if key ~= Enum.UserInputType.MouseButton1 then
                lib.Settings.MenuKey = key
                self.SettingsDrawings.KeybindText.Text = Utility.GetKeyName(key)
                self.WaitingForKeybind = false
            end
        end
    end))
    
    -- Color picker input
    self.ColorPickerActive = false
    self.HueActive = false
    self.CurrentHue = 0.75
    self.CurrentSat = 1
    self.CurrentVal = 1
    
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(input)
        if not self.SettingsOpen then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        
        local mouse = UserInputService:GetMouseLocation()
        local settingsPos = self.Position + Vector2.new(self.Size.X + 10, 0)
        
        local huePos = settingsPos + Vector2.new(10, 130)
        local svPos = settingsPos + Vector2.new(10, 150)
        
        if Utility.MouseInBounds(huePos, Vector2.new(230, 15)) then
            self.HueActive = true
        end
        
        if Utility.MouseInBounds(svPos, Vector2.new(230, 80)) then
            self.ColorPickerActive = true
        end
    end))
    
    table.insert(lib.Connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.ColorPickerActive = false
            self.HueActive = false
        end
    end))
    
    table.insert(lib.Connections, RunService.RenderStepped:Connect(function()
        if not self.SettingsOpen then return end
        
        local mouse = UserInputService:GetMouseLocation()
        local settingsPos = self.Position + Vector2.new(self.Size.X + 10, 0)
        
        if self.HueActive then
            local huePos = settingsPos + Vector2.new(10, 130)
            local relX = math.clamp((mouse.X - huePos.X) / 230, 0, 1)
            self.CurrentHue = relX
            self:UpdateAccentColor()
        end
        
        if self.ColorPickerActive then
            local svPos = settingsPos + Vector2.new(10, 150)
            local relX = math.clamp((mouse.X - svPos.X) / 230, 0, 1)
            local relY = math.clamp((mouse.Y - svPos.Y) / 80, 0, 1)
            self.CurrentSat = relX
            self.CurrentVal = 1 - relY
            self:UpdateAccentColor()
        end
    end))
end

function Window:UpdateAccentColor()
    local newColor = Utility.HSVToRGB(self.CurrentHue, self.CurrentSat, self.CurrentVal)
    self.Library.Theme.Accent = newColor
    
    -- Update color preview
    if self.SettingsDrawings.ColorPreview then
        self.SettingsDrawings.ColorPreview.Color = newColor
    end
    
    -- Update all accent-colored elements
    self:RefreshTheme()
end

function Window:RefreshTheme()
    local theme = self.Library.Theme
    
    self.Drawings.AccentLine.Color = theme.Accent
    
    if self.SettingsDrawings then
        self.SettingsDrawings.AccentLine.Color = theme.Accent
    end
    
    -- Refresh tabs
    for _, tab in pairs(self.Tabs) do
        if tab == self.ActiveTab then
            tab.Drawings.Background.Color = theme.Accent
        end
    end
end

function Window:UpdateSettingsVisibility()
    for _, drawing in pairs(self.SettingsDrawings) do
        drawing.Visible = self.SettingsOpen and self.Visible
    end
end

function Window:SetPosition(pos)
    local delta = pos - self.Position
    self.Position = pos
    
    for _, drawing in pairs(self.Drawings) do
        if drawing.Position then
            drawing.Position = drawing.Position + delta
        elseif drawing.From then
            drawing.From = drawing.From + delta
            drawing.To = drawing.To + delta
        end
    end
    
    for _, drawing in pairs(self.SettingsDrawings or {}) do
        if drawing.Position then
            drawing.Position = drawing.Position + delta
        elseif drawing.From then
            drawing.From = drawing.From + delta
            drawing.To = drawing.To + delta
        end
    end
    
    for _, tab in pairs(self.Tabs) do
        tab:UpdatePosition(delta)
    end
end

function Window:Toggle()
    self.Visible = not self.Visible
    
    for _, drawing in pairs(self.Drawings) do
        drawing.Visible = self.Visible
    end
    
    if not self.Visible then
        self.SettingsOpen = false
    end
    
    self:UpdateSettingsVisibility()
    
    for _, tab in pairs(self.Tabs) do
        tab:SetVisible(self.Visible and tab == self.ActiveTab)
    end
end

-- ============================================
-- TAB CLASS
-- ============================================

local Tab = {}
Tab.__index = Tab

function Window:AddTab(name)
    local lib = self.Library
    local tab = setmetatable({}, Tab)
    
    tab.Name = name
    tab.Window = self
    tab.Library = lib
    tab.Elements = {}
    tab.Drawings = {}
    tab.Visible = false
    tab.Index = #self.Tabs + 1
    tab.ContentOffset = 0
    tab.ScrollOffset = 0
    
    local tabY = 40 + (tab.Index - 1) * 30
    
    -- Tab button background
    tab.Drawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(115, 25),
        Position = self.Position + Vector2.new(2, tabY),
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = true,
        ZIndex = 10
    }))
    
    -- Tab text
    tab.Drawings.Text = lib:AddDrawing(Utility.Create("Text", {
        Text = name,
        Size = 12,
        Font = lib.Settings.Font,
        Position = self.Position + Vector2.new(12, tabY + 6),
        Color = lib.Theme.SubText,
        Visible = true,
        ZIndex = 11
    }))
    
    -- Content area
    tab.ContentPosition = self.Position + Vector2.new(125, 40)
    tab.ContentSize = Vector2.new(self.Size.X - 130, self.Size.Y - 50)
    
    -- Tab click handling
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Visible then
            local tabPos = self.Position + Vector2.new(2, tabY)
            if Utility.MouseInBounds(tabPos, Vector2.new(115, 25)) then
                self:SelectTab(tab)
            end
        end
    end))
    
    table.insert(self.Tabs, tab)
    
    if #self.Tabs == 1 then
        self:SelectTab(tab)
    end
    
    return tab
end

function Window:SelectTab(tab)
    local lib = self.Library
    
    for _, t in pairs(self.Tabs) do
        t.Visible = false
        t.Drawings.Background.Color = lib.Theme.DarkBackground
        t.Drawings.Text.Color = lib.Theme.SubText
        t:SetVisible(false)
    end
    
    tab.Visible = true
    tab.Drawings.Background.Color = lib.Theme.Accent
    tab.Drawings.Text.Color = lib.Theme.Text
    tab:SetVisible(true)
    
    self.ActiveTab = tab
end

function Tab:UpdatePosition(delta)
    for _, drawing in pairs(self.Drawings) do
        if drawing.Position then
            drawing.Position = drawing.Position + delta
        elseif drawing.From then
            drawing.From = drawing.From + delta
            drawing.To = drawing.To + delta
        end
    end
    
    self.ContentPosition = self.ContentPosition + delta
    
    for _, element in pairs(self.Elements) do
        if element.UpdatePosition then
            element:UpdatePosition(delta)
        end
    end
end

function Tab:SetVisible(visible)
    for _, element in pairs(self.Elements) do
        if element.SetVisible then
            element:SetVisible(visible)
        end
    end
end

function Tab:GetNextY()
    return self.ContentOffset
end

function Tab:AddOffset(amount)
    self.ContentOffset = self.ContentOffset + amount
end

-- ============================================
-- BUTTON COMPONENT
-- ============================================

function Tab:AddButton(config)
    local lib = self.Library
    config = config or {}
    
    local button = {
        Type = "Button",
        Text = config.Text or "Button",
        Callback = config.Callback or function() end,
        Drawings = {},
        Tab = self
    }
    
    local y = self:GetNextY()
    local pos = self.ContentPosition + Vector2.new(5, y)
    
    button.Drawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(self.ContentSize.X - 15, 28),
        Position = pos,
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 20
    }))
    
    button.Drawings.Border = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(self.ContentSize.X - 15, 28),
        Position = pos,
        Color = lib.Theme.Border,
        Filled = false,
        Thickness = 1,
        Visible = self.Visible,
        ZIndex = 21
    }))
    
    button.Drawings.Text = lib:AddDrawing(Utility.Create("Text", {
        Text = button.Text,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(10, 7),
        Color = lib.Theme.Text,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    function button:SetVisible(visible)
        for _, drawing in pairs(self.Drawings) do
            drawing.Visible = visible
        end
    end
    
    function button:UpdatePosition(delta)
        for _, drawing in pairs(self.Drawings) do
            if drawing.Position then
                drawing.Position = drawing.Position + delta
            end
        end
    end
    
    -- Click handling
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Window.Visible and self.Visible then
            local btnPos = button.Drawings.Background.Position
            local btnSize = button.Drawings.Background.Size
            
            if Utility.MouseInBounds(btnPos, btnSize) then
                button.Drawings.Background.Color = lib.Theme.Accent
                task.wait(0.1)
                button.Drawings.Background.Color = lib.Theme.LightBackground
                button.Callback()
            end
        end
    end))
    
    self:AddOffset(35)
    table.insert(self.Elements, button)
    return button
end

-- ============================================
-- TOGGLE COMPONENT
-- ============================================

function Tab:AddToggle(idx, config)
    local lib = self.Library
    config = config or {}
    
    local toggle = {
        Type = "Toggle",
        Text = config.Text or "Toggle",
        Value = config.Default or false,
        Callback = config.Callback or function() end,
        Drawings = {},
        Tab = self,
        Idx = idx
    }
    
    local y = self:GetNextY()
    local pos = self.ContentPosition + Vector2.new(5, y)
    
    toggle.Drawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(self.ContentSize.X - 15, 28),
        Position = pos,
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 20
    }))
    
    toggle.Drawings.Text = lib:AddDrawing(Utility.Create("Text", {
        Text = toggle.Text,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(10, 7),
        Color = lib.Theme.Text,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    toggle.Drawings.CheckboxBg = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(18, 18),
        Position = pos + Vector2.new(self.ContentSize.X - 40, 5),
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 21
    }))
    
    toggle.Drawings.CheckboxBorder = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(18, 18),
        Position = pos + Vector2.new(self.ContentSize.X - 40, 5),
        Color = lib.Theme.Border,
        Filled = false,
        Thickness = 1,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    toggle.Drawings.Checkmark = lib:AddDrawing(Utility.Create("Text", {
        Text = "✓",
        Size = 14,
        Font = Drawing.Fonts.UI,
        Position = pos + Vector2.new(self.ContentSize.X - 38, 4),
        Color = lib.Theme.Accent,
        Visible = self.Visible and toggle.Value,
        ZIndex = 23
    }))
    
    function toggle:SetValue(value)
        self.Value = value
        self.Drawings.Checkmark.Visible = value and self.Tab.Visible
        self.Drawings.CheckboxBorder.Color = value and lib.Theme.Accent or lib.Theme.Border
        self.Callback(value)
    end
    
    function toggle:SetVisible(visible)
        for name, drawing in pairs(self.Drawings) do
            if name == "Checkmark" then
                drawing.Visible = visible and self.Value
            else
                drawing.Visible = visible
            end
        end
    end
    
    function toggle:UpdatePosition(delta)
        for _, drawing in pairs(self.Drawings) do
            if drawing.Position then
                drawing.Position = drawing.Position + delta
            end
        end
    end
    
    -- Click handling
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Window.Visible and self.Visible then
            local btnPos = toggle.Drawings.Background.Position
            local btnSize = toggle.Drawings.Background.Size
            
            if Utility.MouseInBounds(btnPos, btnSize) then
                toggle:SetValue(not toggle.Value)
            end
        end
    end))
    
    if toggle.Value then
        toggle:SetValue(true)
    end
    
    Toggles[idx] = toggle
    self:AddOffset(35)
    table.insert(self.Elements, toggle)
    return toggle
end

-- ============================================
-- SLIDER COMPONENT
-- ============================================

function Tab:AddSlider(idx, config)
    local lib = self.Library
    config = config or {}
    
    local slider = {
        Type = "Slider",
        Text = config.Text or "Slider",
        Value = config.Default or config.Min or 0,
        Min = config.Min or 0,
        Max = config.Max or 100,
        Increment = config.Increment or 1,
        Suffix = config.Suffix or "",
        Callback = config.Callback or function() end,
        Drawings = {},
        Tab = self,
        Idx = idx,
        Dragging = false
    }
    
    local y = self:GetNextY()
    local pos = self.ContentPosition + Vector2.new(5, y)
    local sliderWidth = self.ContentSize.X - 15
    
    slider.Drawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(sliderWidth, 40),
        Position = pos,
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 20
    }))
    
    slider.Drawings.Text = lib:AddDrawing(Utility.Create("Text", {
        Text = slider.Text,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(10, 5),
        Color = lib.Theme.Text,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    slider.Drawings.ValueText = lib:AddDrawing(Utility.Create("Text", {
        Text = tostring(slider.Value) .. slider.Suffix,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(sliderWidth - 50, 5),
        Color = lib.Theme.SubText,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    slider.Drawings.SliderBg = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(sliderWidth - 20, 8),
        Position = pos + Vector2.new(10, 25),
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 21
    }))
    
    local fillWidth = ((slider.Value - slider.Min) / (slider.Max - slider.Min)) * (sliderWidth - 20)
    
    slider.Drawings.SliderFill = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(math.max(fillWidth, 1), 8),
        Position = pos + Vector2.new(10, 25),
        Color = lib.Theme.Accent,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    function slider:SetValue(value)
        value = math.clamp(value, self.Min, self.Max)
        value = math.floor(value / self.Increment + 0.5) * self.Increment
        self.Value = value
        
        local sliderWidth = self.Tab.ContentSize.X - 15
        local fillWidth = ((value - self.Min) / (self.Max - self.Min)) * (sliderWidth - 20)
        
        self.Drawings.SliderFill.Size = Vector2.new(math.max(fillWidth, 1), 8)
        self.Drawings.ValueText.Text = tostring(value) .. self.Suffix
        
        self.Callback(value)
    end
    
    function slider:SetVisible(visible)
        for _, drawing in pairs(self.Drawings) do
            drawing.Visible = visible
        end
    end
    
    function slider:UpdatePosition(delta)
        for _, drawing in pairs(self.Drawings) do
            if drawing.Position then
                drawing.Position = drawing.Position + delta
            end
        end
    end
    
    -- Slider dragging
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Window.Visible and self.Visible then
            local sliderPos = slider.Drawings.SliderBg.Position
            local sliderSize = slider.Drawings.SliderBg.Size
            
            if Utility.MouseInBounds(sliderPos, sliderSize) then
                slider.Dragging = true
            end
        end
    end))
    
    table.insert(lib.Connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            slider.Dragging = false
        end
    end))
    
    table.insert(lib.Connections, RunService.RenderStepped:Connect(function()
        if slider.Dragging and self.Window.Visible and self.Visible then
            local mouse = UserInputService:GetMouseLocation()
            local sliderPos = slider.Drawings.SliderBg.Position
            local sliderWidth = slider.Drawings.SliderBg.Size.X
            
            local relX = math.clamp((mouse.X - sliderPos.X) / sliderWidth, 0, 1)
            local value = slider.Min + relX * (slider.Max - slider.Min)
            
            slider:SetValue(value)
        end
    end))
    
    slider:SetValue(slider.Value)
    
    Options[idx] = slider
    self:AddOffset(47)
    table.insert(self.Elements, slider)
    return slider
end

-- ============================================
-- DROPDOWN COMPONENT
-- ============================================

function Tab:AddDropdown(idx, config)
    local lib = self.Library
    config = config or {}
    
    local dropdown = {
        Type = "Dropdown",
        Text = config.Text or "Dropdown",
        Value = config.Default or (config.Values and config.Values[1]) or nil,
        Values = config.Values or {},
        Multi = config.Multi or false,
        Callback = config.Callback or function() end,
        Drawings = {},
        OptionDrawings = {},
        Tab = self,
        Idx = idx,
        Open = false
    }
    
    if dropdown.Multi then
        dropdown.Value = config.Default or {}
    end
    
    local y = self:GetNextY()
    local pos = self.ContentPosition + Vector2.new(5, y)
    local dropWidth = self.ContentSize.X - 15
    
    dropdown.Drawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(dropWidth, 45),
        Position = pos,
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 20
    }))
    
    dropdown.Drawings.Text = lib:AddDrawing(Utility.Create("Text", {
        Text = dropdown.Text,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(10, 5),
        Color = lib.Theme.SubText,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    dropdown.Drawings.Selected = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(dropWidth - 20, 22),
        Position = pos + Vector2.new(10, 20),
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 21
    }))
    
    dropdown.Drawings.SelectedBorder = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(dropWidth - 20, 22),
        Position = pos + Vector2.new(10, 20),
        Color = lib.Theme.Border,
        Filled = false,
        Thickness = 1,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    local displayText = dropdown.Multi and "None" or (dropdown.Value or "Select...")
    if dropdown.Multi and type(dropdown.Value) == "table" then
        local selected = {}
        for _, v in pairs(dropdown.Value) do
            table.insert(selected, v)
        end
        displayText = #selected > 0 and table.concat(selected, ", ") or "None"
    end
    
    dropdown.Drawings.SelectedText = lib:AddDrawing(Utility.Create("Text", {
        Text = displayText,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(15, 24),
        Color = lib.Theme.Text,
        Visible = self.Visible,
        ZIndex = 23
    }))
    
    dropdown.Drawings.Arrow = lib:AddDrawing(Utility.Create("Text", {
        Text = "▼",
        Size = 10,
        Font = Drawing.Fonts.UI,
        Position = pos + Vector2.new(dropWidth - 30, 25),
        Color = lib.Theme.SubText,
        Visible = self.Visible,
        ZIndex = 23
    }))
    
    function dropdown:UpdateDisplay()
        local displayText
        if self.Multi then
            local selected = {}
            for k, v in pairs(self.Value) do
                if v then table.insert(selected, k) end
            end
            displayText = #selected > 0 and table.concat(selected, ", ") or "None"
        else
            displayText = self.Value or "Select..."
        end
        self.Drawings.SelectedText.Text = displayText
    end
    
    function dropdown:SetValue(value)
        self.Value = value
        self:UpdateDisplay()
        self.Callback(value)
    end
    
    function dropdown:SetValues(values)
        self.Values = values
        self:BuildOptions()
    end
    
    function dropdown:BuildOptions()
        for _, drawing in pairs(self.OptionDrawings) do
            drawing:Remove()
        end
        self.OptionDrawings = {}
        
        if not self.Open then return end
        
        local optPos = self.Drawings.Selected.Position + Vector2.new(0, 25)
        local optWidth = self.Drawings.Selected.Size.X
        
        for i, value in ipairs(self.Values) do
            local optY = optPos + Vector2.new(0, (i - 1) * 22)
            
            local isSelected = false
            if self.Multi then
                isSelected = self.Value[value] == true
            else
                isSelected = self.Value == value
            end
            
            local optBg = lib:AddDrawing(Utility.Create("Square", {
                Size = Vector2.new(optWidth, 22),
                Position = optY,
                Color = isSelected and lib.Theme.Accent or lib.Theme.DarkBackground,
                Filled = true,
                Visible = true,
                ZIndex = 50
            }))
            
            local optText = lib:AddDrawing(Utility.Create("Text", {
                Text = value,
                Size = 12,
                Font = lib.Settings.Font,
                Position = optY + Vector2.new(5, 4),
                Color = lib.Theme.Text,
                Visible = true,
                ZIndex = 51
            }))
            
            table.insert(self.OptionDrawings, optBg)
            table.insert(self.OptionDrawings, optText)
        end
    end
    
    function dropdown:ToggleOpen()
        self.Open = not self.Open
        self.Drawings.Arrow.Text = self.Open and "▲" or "▼"
        self:BuildOptions()
    end
    
    function dropdown:SetVisible(visible)
        for _, drawing in pairs(self.Drawings) do
            drawing.Visible = visible
        end
        if not visible then
            self.Open = false
            for _, drawing in pairs(self.OptionDrawings) do
                drawing.Visible = false
            end
        end
    end
    
    function dropdown:UpdatePosition(delta)
        for _, drawing in pairs(self.Drawings) do
            if drawing.Position then
                drawing.Position = drawing.Position + delta
            end
        end
    end
    
    -- Click handling
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Window.Visible and self.Visible then
            local selectPos = dropdown.Drawings.Selected.Position
            local selectSize = dropdown.Drawings.Selected.Size
            
            if Utility.MouseInBounds(selectPos, selectSize) then
                dropdown:ToggleOpen()
                return
            end
            
            if dropdown.Open then
                local optPos = dropdown.Drawings.Selected.Position + Vector2.new(0, 25)
                local optWidth = dropdown.Drawings.Selected.Size.X
                
                for i, value in ipairs(dropdown.Values) do
                    local optY = optPos + Vector2.new(0, (i - 1) * 22)
                    
                    if Utility.MouseInBounds(optY, Vector2.new(optWidth, 22)) then
                        if dropdown.Multi then
                            dropdown.Value[value] = not dropdown.Value[value]
                            dropdown:UpdateDisplay()
                            dropdown.Callback(dropdown.Value)
                        else
                            dropdown:SetValue(value)
                            dropdown:ToggleOpen()
                        end
                        dropdown:BuildOptions()
                        return
                    end
                end
                
                dropdown:ToggleOpen()
            end
        end
    end))
    
    Options[idx] = dropdown
    self:AddOffset(52)
    table.insert(self.Elements, dropdown)
    return dropdown
end

-- ============================================
-- KEYBIND COMPONENT
-- ============================================

function Tab:AddKeybind(idx, config)
    local lib = self.Library
    config = config or {}
    
    local keybind = {
        Type = "KeyPicker",
        Text = config.Text or "Keybind",
        Value = config.Default or Enum.KeyCode.None,
        Mode = config.Mode or "Toggle",
        Callback = config.Callback or function() end,
        ChangedCallback = config.ChangedCallback or function() end,
        Drawings = {},
        Tab = self,
        Idx = idx,
        Waiting = false,
        Active = false
    }
    
    local y = self:GetNextY()
    local pos = self.ContentPosition + Vector2.new(5, y)
    local width = self.ContentSize.X - 15
    
    keybind.Drawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(width, 28),
        Position = pos,
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 20
    }))
    
    keybind.Drawings.Text = lib:AddDrawing(Utility.Create("Text", {
        Text = keybind.Text,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(10, 7),
        Color = lib.Theme.Text,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    keybind.Drawings.KeyBg = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(60, 18),
        Position = pos + Vector2.new(width - 70, 5),
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 21
    }))
    
    keybind.Drawings.KeyText = lib:AddDrawing(Utility.Create("Text", {
        Text = Utility.GetKeyName(keybind.Value),
        Size = 11,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(width - 65, 8),
        Color = lib.Theme.SubText,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    function keybind:SetValue(data)
        if type(data) == "table" then
            self.Value = data[1] or Enum.KeyCode.None
            self.Mode = data[2] or "Toggle"
        else
            self.Value = data
        end
        self.Drawings.KeyText.Text = Utility.GetKeyName(self.Value)
        self.ChangedCallback(self.Value)
    end
    
    function keybind:SetVisible(visible)
        for _, drawing in pairs(self.Drawings) do
            drawing.Visible = visible
        end
    end
    
    function keybind:UpdatePosition(delta)
        for _, drawing in pairs(self.Drawings) do
            if drawing.Position then
                drawing.Position = drawing.Position + delta
            end
        end
    end
    
    function keybind:GetState()
        if self.Mode == "Toggle" then
            return self.Active
        elseif self.Mode == "Hold" then
            return self.Holding
        end
        return false
    end
    
    -- Click to change keybind
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Window.Visible and self.Visible then
            local keyPos = keybind.Drawings.KeyBg.Position
            local keySize = keybind.Drawings.KeyBg.Size
            
            if Utility.MouseInBounds(keyPos, keySize) then
                keybind.Waiting = true
                keybind.Drawings.KeyText.Text = "..."
                return
            end
        end
        
        if keybind.Waiting then
            local key
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                key = Enum.UserInputType.MouseButton1
            elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                key = Enum.UserInputType.MouseButton2
            elseif input.KeyCode ~= Enum.KeyCode.Unknown then
                key = input.KeyCode
            end
            
            if key then
                keybind:SetValue(key)
                keybind.Waiting = false
            end
            return
        end
        
        -- Keybind activation
        local key = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType
        
        if key == keybind.Value then
            if keybind.Mode == "Toggle" then
                keybind.Active = not keybind.Active
                keybind.Callback(keybind.Active)
            elseif keybind.Mode == "Hold" then
                keybind.Holding = true
                keybind.Callback(true)
            end
        end
    end))
    
    table.insert(lib.Connections, UserInputService.InputEnded:Connect(function(input)
        local key = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType
        
        if key == keybind.Value and keybind.Mode == "Hold" then
            keybind.Holding = false
            keybind.Callback(false)
        end
    end))
    
    Options[idx] = keybind
    self:AddOffset(35)
    table.insert(self.Elements, keybind)
    return keybind
end

-- ============================================
-- COLOR PICKER COMPONENT
-- ============================================

function Tab:AddColorPicker(idx, config)
    local lib = self.Library
    config = config or {}
    
    local colorpicker = {
        Type = "ColorPicker",
        Text = config.Text or "Color",
        Value = config.Default or Color3.fromRGB(255, 255, 255),
        Transparency = config.Transparency or 0,
        Callback = config.Callback or function() end,
        Drawings = {},
        Tab = self,
        Idx = idx,
        Open = false,
        Hue = 0,
        Sat = 1,
        Val = 1
    }
    
    local h, s, v = Utility.RGBToHSV(colorpicker.Value)
    colorpicker.Hue = h
    colorpicker.Sat = s
    colorpicker.Val = v
    
    local y = self:GetNextY()
    local pos = self.ContentPosition + Vector2.new(5, y)
    local width = self.ContentSize.X - 15
    
    colorpicker.Drawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(width, 28),
        Position = pos,
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 20
    }))
    
    colorpicker.Drawings.Text = lib:AddDrawing(Utility.Create("Text", {
        Text = colorpicker.Text,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(10, 7),
        Color = lib.Theme.Text,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    colorpicker.Drawings.Preview = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(40, 18),
        Position = pos + Vector2.new(width - 50, 5),
        Color = colorpicker.Value,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 21
    }))
    
    colorpicker.Drawings.PreviewBorder = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(40, 18),
        Position = pos + Vector2.new(width - 50, 5),
        Color = lib.Theme.Border,
        Filled = false,
        Thickness = 1,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    -- Picker window (initially hidden)
    colorpicker.Drawings.PickerBg = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(180, 120),
        Position = pos + Vector2.new(width - 180, 30),
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = false,
        ZIndex = 60
    }))
    
    colorpicker.Drawings.PickerBorder = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(180, 120),
        Position = pos + Vector2.new(width - 180, 30),
        Color = lib.Theme.Border,
        Filled = false,
        Thickness = 1,
        Visible = false,
        ZIndex = 61
    }))
    
    colorpicker.Drawings.SVArea = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(160, 80),
        Position = pos + Vector2.new(width - 170, 35),
        Color = colorpicker.Value,
        Filled = true,
        Visible = false,
        ZIndex = 61
    }))
    
    colorpicker.Drawings.HueBar = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(160, 15),
        Position = pos + Vector2.new(width - 170, 120),
        Color = Color3.fromRGB(255, 0, 0),
        Filled = true,
        Visible = false,
        ZIndex = 61
    }))
    
    function colorpicker:SetValueRGB(color, transparency)
        self.Value = color
        self.Transparency = transparency or 0
        
        local h, s, v = Utility.RGBToHSV(color)
        self.Hue = h
        self.Sat = s
        self.Val = v
        
        self.Drawings.Preview.Color = color
        self.Drawings.SVArea.Color = Utility.HSVToRGB(h, 1, 1)
        
        self.Callback(color)
    end
    
    function colorpicker:UpdateColor()
        local color = Utility.HSVToRGB(self.Hue, self.Sat, self.Val)
        self.Value = color
        self.Drawings.Preview.Color = color
        self.Drawings.SVArea.Color = Utility.HSVToRGB(self.Hue, 1, 1)
        self.Callback(color)
    end
    
    function colorpicker:ToggleOpen()
        self.Open = not self.Open
        self.Drawings.PickerBg.Visible = self.Open
        self.Drawings.PickerBorder.Visible = self.Open
        self.Drawings.SVArea.Visible = self.Open
        self.Drawings.HueBar.Visible = self.Open
    end
    
    function colorpicker:SetVisible(visible)
        for name, drawing in pairs(self.Drawings) do
            if name:find("Picker") or name == "SVArea" or name == "HueBar" then
                drawing.Visible = visible and self.Open
            else
                drawing.Visible = visible
            end
        end
    end
    
    function colorpicker:UpdatePosition(delta)
        for _, drawing in pairs(self.Drawings) do
            if drawing.Position then
                drawing.Position = drawing.Position + delta
            end
        end
    end
    
    colorpicker.SVDragging = false
    colorpicker.HueDragging = false
    
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Window.Visible and self.Visible then
            local previewPos = colorpicker.Drawings.Preview.Position
            local previewSize = colorpicker.Drawings.Preview.Size
            
            if Utility.MouseInBounds(previewPos, previewSize) then
                colorpicker:ToggleOpen()
                return
            end
            
            if colorpicker.Open then
                local svPos = colorpicker.Drawings.SVArea.Position
                local svSize = colorpicker.Drawings.SVArea.Size
                
                if Utility.MouseInBounds(svPos, svSize) then
                    colorpicker.SVDragging = true
                    return
                end
                
                local huePos = colorpicker.Drawings.HueBar.Position
                local hueSize = colorpicker.Drawings.HueBar.Size
                
                if Utility.MouseInBounds(huePos, hueSize) then
                    colorpicker.HueDragging = true
                    return
                end
            end
        end
    end))
    
    table.insert(lib.Connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            colorpicker.SVDragging = false
            colorpicker.HueDragging = false
        end
    end))
    
    table.insert(lib.Connections, RunService.RenderStepped:Connect(function()
        if not self.Window.Visible or not self.Visible or not colorpicker.Open then return end
        
        local mouse = UserInputService:GetMouseLocation()
        
        if colorpicker.SVDragging then
            local svPos = colorpicker.Drawings.SVArea.Position
            local svSize = colorpicker.Drawings.SVArea.Size
            
            local relX = math.clamp((mouse.X - svPos.X) / svSize.X, 0, 1)
            local relY = math.clamp((mouse.Y - svPos.Y) / svSize.Y, 0, 1)
            
            colorpicker.Sat = relX
            colorpicker.Val = 1 - relY
            colorpicker:UpdateColor()
        end
        
        if colorpicker.HueDragging then
            local huePos = colorpicker.Drawings.HueBar.Position
            local hueSize = colorpicker.Drawings.HueBar.Size
            
            local relX = math.clamp((mouse.X - huePos.X) / hueSize.X, 0, 1)
            
            colorpicker.Hue = relX
            colorpicker:UpdateColor()
        end
    end))
    
    Options[idx] = colorpicker
    self:AddOffset(35)
    table.insert(self.Elements, colorpicker)
    return colorpicker
end

-- ============================================
-- LABEL COMPONENT
-- ============================================

function Tab:AddLabel(text)
    local lib = self.Library
    
    local label = {
        Type = "Label",
        Text = text,
        Drawings = {},
        Tab = self
    }
    
    local y = self:GetNextY()
    local pos = self.ContentPosition + Vector2.new(5, y)
    
    label.Drawings.Text = lib:AddDrawing(Utility.Create("Text", {
        Text = text,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(5, 5),
        Color = lib.Theme.SubText,
        Visible = self.Visible,
        ZIndex = 20
    }))
    
    function label:SetText(newText)
        self.Text = newText
        self.Drawings.Text.Text = newText
    end
    
    function label:SetVisible(visible)
        self.Drawings.Text.Visible = visible
    end
    
    function label:UpdatePosition(delta)
        self.Drawings.Text.Position = self.Drawings.Text.Position + delta
    end
    
    self:AddOffset(25)
    table.insert(self.Elements, label)
    return label
end

-- ============================================
-- DIVIDER COMPONENT
-- ============================================

function Tab:AddDivider()
    local lib = self.Library
    
    local divider = {
        Type = "Divider",
        Drawings = {},
        Tab = self
    }
    
    local y = self:GetNextY()
    local pos = self.ContentPosition + Vector2.new(10, y + 5)
    
    divider.Drawings.Line = lib:AddDrawing(Utility.Create("Line", {
        From = pos,
        To = pos + Vector2.new(self.ContentSize.X - 25, 0),
        Color = lib.Theme.Border,
        Thickness = 1,
        Visible = self.Visible,
        ZIndex = 20
    }))
    
    function divider:SetVisible(visible)
        self.Drawings.Line.Visible = visible
    end
    
    function divider:UpdatePosition(delta)
        self.Drawings.Line.From = self.Drawings.Line.From + delta
        self.Drawings.Line.To = self.Drawings.Line.To + delta
    end
    
    self:AddOffset(15)
    table.insert(self.Elements, divider)
    return divider
end

-- ============================================
-- INPUT COMPONENT
-- ============================================

function Tab:AddInput(idx, config)
    local lib = self.Library
    config = config or {}
    
    local input = {
        Type = "Input",
        Text = config.Text or "Input",
        Value = config.Default or "",
        Placeholder = config.Placeholder or "Enter text...",
        Callback = config.Callback or function() end,
        Drawings = {},
        Tab = self,
        Idx = idx,
        Focused = false
    }
    
    local y = self:GetNextY()
    local pos = self.ContentPosition + Vector2.new(5, y)
    local width = self.ContentSize.X - 15
    
    input.Drawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(width, 45),
        Position = pos,
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 20
    }))
    
    input.Drawings.Label = lib:AddDrawing(Utility.Create("Text", {
        Text = input.Text,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(10, 5),
        Color = lib.Theme.SubText,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    input.Drawings.InputBg = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(width - 20, 20),
        Position = pos + Vector2.new(10, 22),
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 21
    }))
    
    input.Drawings.InputBorder = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(width - 20, 20),
        Position = pos + Vector2.new(10, 22),
        Color = lib.Theme.Border,
        Filled = false,
        Thickness = 1,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    input.Drawings.InputText = lib:AddDrawing(Utility.Create("Text", {
        Text = input.Value ~= "" and input.Value or input.Placeholder,
        Size = 11,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(15, 25),
        Color = input.Value ~= "" and lib.Theme.Text or lib.Theme.Disabled,
        Visible = self.Visible,
        ZIndex = 23
    }))
    
    function input:SetValue(value)
        self.Value = value
        self.Drawings.InputText.Text = value ~= "" and value or self.Placeholder
        self.Drawings.InputText.Color = value ~= "" and lib.Theme.Text or lib.Theme.Disabled
        self.Callback(value)
    end
    
    function input:SetVisible(visible)
        for _, drawing in pairs(self.Drawings) do
            drawing.Visible = visible
        end
    end
    
    function input:UpdatePosition(delta)
        for _, drawing in pairs(self.Drawings) do
            if drawing.Position then
                drawing.Position = drawing.Position + delta
            end
        end
    end
    
    -- Input handling
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 and self.Window.Visible and self.Visible then
            local inputPos = input.Drawings.InputBg.Position
            local inputSize = input.Drawings.InputBg.Size
            
            if Utility.MouseInBounds(inputPos, inputSize) then
                input.Focused = true
                input.Drawings.InputBorder.Color = lib.Theme.Accent
                input.Drawings.InputText.Text = input.Value .. "|"
            else
                if input.Focused then
                    input.Focused = false
                    input.Drawings.InputBorder.Color = lib.Theme.Border
                    input.Drawings.InputText.Text = input.Value ~= "" and input.Value or input.Placeholder
                    input.Drawings.InputText.Color = input.Value ~= "" and lib.Theme.Text or lib.Theme.Disabled
                end
            end
        end
        
        if input.Focused and inp.UserInputType == Enum.UserInputType.Keyboard then
            local key = inp.KeyCode.Name
            
            if inp.KeyCode == Enum.KeyCode.Backspace then
                input.Value = input.Value:sub(1, -2)
            elseif inp.KeyCode == Enum.KeyCode.Return then
                input.Focused = false
                input.Drawings.InputBorder.Color = lib.Theme.Border
                input.Drawings.InputText.Text = input.Value ~= "" and input.Value or input.Placeholder
                input.Callback(input.Value)
                return
            elseif inp.KeyCode == Enum.KeyCode.Space then
                input.Value = input.Value .. " "
            elseif #key == 1 then
                local char = key
                if not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and not UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                    char = char:lower()
                end
                input.Value = input.Value .. char
            end
            
            input.Drawings.InputText.Text = input.Value .. "|"
            input.Drawings.InputText.Color = lib.Theme.Text
        end
    end))
    
    Options[idx] = input
    self:AddOffset(52)
    table.insert(self.Elements, input)
    return input
end

return Library
