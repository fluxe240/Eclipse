local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

getgenv().Toggles = getgenv().Toggles or {}
getgenv().Options = getgenv().Options or {}

-- Utility
local Utility = {}

function Utility.Create(class, properties)
    local drawing = Drawing.new(class)
    for property, value in pairs(properties) do
        drawing[property] = value
    end
    return drawing
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
        return key.Name
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

-- Library
local Library = {}
Library.__index = Library

Library.Theme = {
    Background = Color3.fromRGB(20, 20, 25),
    DarkBackground = Color3.fromRGB(15, 15, 18),
    LightBackground = Color3.fromRGB(30, 30, 35),
    Accent = Color3.fromRGB(138, 43, 226),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(180, 180, 180),
    Disabled = Color3.fromRGB(100, 100, 100),
    Border = Color3.fromRGB(50, 50, 55),
}

Library.Settings = {
    MenuKey = Enum.KeyCode.RightControl,
    Font = Drawing.Fonts.Plex,
    FontSize = 13,
}

Library.Drawings = {}
Library.Windows = {}
Library.Connections = {}
Library.Open = true

function Library:Unload()
    for _, drawing in pairs(self.Drawings) do
        pcall(function() drawing:Remove() end)
    end
    for _, connection in pairs(self.Connections) do
        pcall(function() connection:Disconnect() end)
    end
    self.Drawings = {}
    self.Connections = {}
end

function Library:AddDrawing(drawing)
    table.insert(self.Drawings, drawing)
    return drawing
end

function Library:Notify(text, duration)
    duration = duration or 3
    
    local notif = {}
    
    notif.Background = self:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(250, 30),
        Position = Vector2.new(10, 10),
        Color = self.Theme.DarkBackground,
        Filled = true,
        Visible = true,
        ZIndex = 999
    }))
    
    notif.Border = self:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(250, 30),
        Position = Vector2.new(10, 10),
        Color = self.Theme.Accent,
        Filled = false,
        Thickness = 1,
        Visible = true,
        ZIndex = 1000
    }))
    
    notif.Text = self:AddDrawing(Utility.Create("Text", {
        Text = text,
        Size = 13,
        Font = self.Settings.Font,
        Position = Vector2.new(20, 18),
        Color = self.Theme.Text,
        Visible = true,
        ZIndex = 1001
    }))
    
    task.spawn(function()
        task.wait(duration)
        pcall(function()
            notif.Background:Remove()
            notif.Border:Remove()
            notif.Text:Remove()
        end)
    end)
end

-- Window
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
    window.Drawings = {}
    window.SettingsOpen = false
    window.SettingsDrawings = {}
    
    -- Main Background
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
    
    -- Title Bar
    window.Drawings.TitleBar = self:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(window.Size.X, 30),
        Position = window.Position,
        Color = self.Theme.DarkBackground,
        Filled = true,
        Visible = true,
        ZIndex = 2
    }))
    
    -- Title
    window.Drawings.Title = self:AddDrawing(Utility.Create("Text", {
        Text = window.Title,
        Size = 14,
        Font = self.Settings.Font,
        Position = window.Position + Vector2.new(10, 8),
        Color = self.Theme.Text,
        Visible = true,
        ZIndex = 3
    }))
    
    -- Accent Line
    window.Drawings.AccentLine = self:AddDrawing(Utility.Create("Line", {
        From = window.Position + Vector2.new(0, 30),
        To = window.Position + Vector2.new(window.Size.X, 30),
        Color = self.Theme.Accent,
        Thickness = 2,
        Visible = true,
        ZIndex = 3
    }))
    
    -- Tab Container
    window.Drawings.TabContainer = self:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(120, window.Size.Y - 32),
        Position = window.Position + Vector2.new(0, 32),
        Color = self.Theme.DarkBackground,
        Filled = true,
        Visible = true,
        ZIndex = 2
    }))
    
    -- Tab Separator
    window.Drawings.TabSeparator = self:AddDrawing(Utility.Create("Line", {
        From = window.Position + Vector2.new(120, 32),
        To = window.Position + Vector2.new(120, window.Size.Y),
        Color = self.Theme.Border,
        Thickness = 1,
        Visible = true,
        ZIndex = 3
    }))
    
    -- Settings Icon
    window.Drawings.SettingsIcon = self:AddDrawing(Utility.Create("Text", {
        Text = "⚙",
        Size = 18,
        Font = Drawing.Fonts.UI,
        Position = window.Position + Vector2.new(window.Size.X - 25, 6),
        Color = self.Theme.SubText,
        Visible = true,
        ZIndex = 4
    }))
    
    -- Create Settings Window
    window:CreateSettingsWindow()
    
    -- Dragging
    table.insert(self.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouse = UserInputService:GetMouseLocation()
            local titleBarPos = window.Position
            local titleBarSize = Vector2.new(window.Size.X - 30, 30)
            
            if Utility.MouseInBounds(titleBarPos, titleBarSize) and window.Visible then
                window.Dragging = true
                window.DragOffset = mouse - window.Position
            end
            
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
    local settingsPos = self.Position + Vector2.new(self.Size.X + 10, 0)
    local settingsSize = Vector2.new(250, 200)
    
    self.SettingsDrawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = settingsSize,
        Position = settingsPos,
        Color = lib.Theme.Background,
        Filled = true,
        Visible = false,
        ZIndex = 100
    }))
    
    self.SettingsDrawings.Border = lib:AddDrawing(Utility.Create("Square", {
        Size = settingsSize,
        Position = settingsPos,
        Color = lib.Theme.Border,
        Filled = false,
        Thickness = 1,
        Visible = false,
        ZIndex = 101
    }))
    
    self.SettingsDrawings.Title = lib:AddDrawing(Utility.Create("Text", {
        Text = "Settings",
        Size = 13,
        Font = lib.Settings.Font,
        Position = settingsPos + Vector2.new(10, 10),
        Color = lib.Theme.Text,
        Visible = false,
        ZIndex = 102
    }))
    
    self.SettingsDrawings.KeybindLabel = lib:AddDrawing(Utility.Create("Text", {
        Text = "Menu Key: " .. Utility.GetKeyName(lib.Settings.MenuKey),
        Size = 12,
        Font = lib.Settings.Font,
        Position = settingsPos + Vector2.new(10, 35),
        Color = lib.Theme.SubText,
        Visible = false,
        ZIndex = 102
    }))
    
    self.SettingsDrawings.ColorLabel = lib:AddDrawing(Utility.Create("Text", {
        Text = "Accent Color",
        Size = 12,
        Font = lib.Settings.Font,
        Position = settingsPos + Vector2.new(10, 60),
        Color = lib.Theme.SubText,
        Visible = false,
        ZIndex = 102
    }))
    
    self.SettingsDrawings.ColorPreview = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(230, 25),
        Position = settingsPos + Vector2.new(10, 80),
        Color = lib.Theme.Accent,
        Filled = true,
        Visible = false,
        ZIndex = 102
    }))
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
    
    for _, drawing in pairs(self.SettingsDrawings) do
        if drawing.Position then
            drawing.Position = drawing.Position + delta
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

-- Tab
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
    
    local tabY = 40 + (tab.Index - 1) * 30
    
    tab.Drawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(115, 25),
        Position = self.Position + Vector2.new(2, tabY),
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = true,
        ZIndex = 10
    }))
    
    tab.Drawings.Text = lib:AddDrawing(Utility.Create("Text", {
        Text = name,
        Size = 12,
        Font = lib.Settings.Font,
        Position = self.Position + Vector2.new(12, tabY + 6),
        Color = lib.Theme.SubText,
        Visible = true,
        ZIndex = 11
    }))
    
    tab.ContentPosition = self.Position + Vector2.new(125, 40)
    tab.ContentSize = Vector2.new(self.Size.X - 130, self.Size.Y - 50)
    
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

-- Button
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
    
    table.insert(lib.Connections, UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Window.Visible and self.Visible then
            local btnPos = button.Drawings.Background.Position
            local btnSize = button.Drawings.Background.Size
            
            if Utility.MouseInBounds(btnPos, btnSize) then
                button.Drawings.Background.Color = lib.Theme.Accent
                task.spawn(function()
                    task.wait(0.1)
                    button.Drawings.Background.Color = lib.Theme.LightBackground
                end)
                button.Callback()
            end
        end
    end))
    
    self:AddOffset(35)
    table.insert(self.Elements, button)
    return button
end

-- Toggle
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

-- Slider
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

-- Dropdown
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
    
    local displayText = dropdown.Value or "Select..."
    
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
    
    function dropdown:SetValue(value)
        self.Value = value
        self.Drawings.SelectedText.Text = value or "Select..."
        self.Callback(value)
    end
    
    function dropdown:SetValues(values)
        self.Values = values
    end
    
    function dropdown:ToggleOpen()
        self.Open = not self.Open
        self.Drawings.Arrow.Text = self.Open and "▲" or "▼"
        
        for _, drawing in pairs(self.OptionDrawings) do
            pcall(function() drawing:Remove() end)
        end
        self.OptionDrawings = {}
        
        if self.Open then
            local optPos = self.Drawings.Selected.Position + Vector2.new(0, 25)
            local optWidth = self.Drawings.Selected.Size.X
            
            for i, value in ipairs(self.Values) do
                local optY = optPos + Vector2.new(0, (i - 1) * 22)
                
                local optBg = lib:AddDrawing(Utility.Create("Square", {
                    Size = Vector2.new(optWidth, 22),
                    Position = optY,
                    Color = lib.Theme.DarkBackground,
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
                        dropdown:SetValue(value)
                        dropdown:ToggleOpen()
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

-- Keybind
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
        Active = false,
        Holding = false
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

-- ColorPicker
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
        Val = 1,
        SVDragging = false,
        HueDragging = false
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
    
    colorpicker.Drawings.PickerBg = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(180, 100),
        Position = pos + Vector2.new(width - 180, 30),
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = false,
        ZIndex = 60
    }))
    
    colorpicker.Drawings.SVArea = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(160, 60),
        Position = pos + Vector2.new(width - 170, 35),
        Color = colorpicker.Value,
        Filled = true,
        Visible = false,
        ZIndex = 61
    }))
    
    colorpicker.Drawings.HueBar = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(160, 15),
        Position = pos + Vector2.new(width - 170, 100),
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
        self.Drawings.SVArea.Visible = self.Open
        self.Drawings.HueBar.Visible = self.Open
    end
    
    function colorpicker:SetVisible(visible)
        for name, drawing in pairs(self.Drawings) do
            if name == "PickerBg" or name == "SVArea" or name == "HueBar" then
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

-- Label
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

-- Divider
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

-- Input
function Tab:AddInput(idx, config)
    local lib = self.Library
    config = config or {}
    
    local inputBox = {
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
    
    inputBox.Drawings.Background = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(width, 45),
        Position = pos,
        Color = lib.Theme.LightBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 20
    }))
    
    inputBox.Drawings.Label = lib:AddDrawing(Utility.Create("Text", {
        Text = inputBox.Text,
        Size = 12,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(10, 5),
        Color = lib.Theme.SubText,
        Visible = self.Visible,
        ZIndex = 22
    }))
    
    inputBox.Drawings.InputBg = lib:AddDrawing(Utility.Create("Square", {
        Size = Vector2.new(width - 20, 20),
        Position = pos + Vector2.new(10, 22),
        Color = lib.Theme.DarkBackground,
        Filled = true,
        Visible = self.Visible,
        ZIndex = 21
    }))
    
    inputBox.Drawings.InputText = lib:AddDrawing(Utility.Create("Text", {
        Text = inputBox.Value ~= "" and inputBox.Value or inputBox.Placeholder,
        Size = 11,
        Font = lib.Settings.Font,
        Position = pos + Vector2.new(15, 25),
        Color = inputBox.Value ~= "" and lib.Theme.Text or lib.Theme.Disabled,
        Visible = self.Visible,
        ZIndex = 23
    }))
    
    function inputBox:SetValue(value)
        self.Value = value
        self.Drawings.InputText.Text = value ~= "" and value or self.Placeholder
        self.Drawings.InputText.Color = value ~= "" and lib.Theme.Text or lib.Theme.Disabled
        self.Callback(value)
    end
    
    function inputBox:SetVisible(visible)
        for _, drawing in pairs(self.Drawings) do
            drawing.Visible = visible
        end
    end
    
    function inputBox:UpdatePosition(delta)
        for _, drawing in pairs(self.Drawings) do
            if drawing.Position then
                drawing.Position = drawing.Position + delta
            end
        end
    end
    
    Options[idx] = inputBox
    self:AddOffset(52)
    table.insert(self.Elements, inputBox)
    return inputBox
end

return Library
