local vu1 = game:GetService("Lighting")
local vu2 = game:GetService("RunService")
game:GetService("StarterGui")
local v3 = game:GetService("HttpService")
local vu4 = game:GetService("TeleportService")
local vu5 = game:GetService("UserInputService")
game:GetService("ReplicatedStorage")
local vu6 = Instance.new("Folder", workspace)
vu6.Name = v3:GenerateGUID()
local vu7 = game.Players
local vu8 = vu7.LocalPlayer
local vu9 = vu8:GetMouse()
local vu10 = workspace.CurrentCamera
local vu11 = {
    drawings = {}
}
local vu12 = {}
local vu13 = {
    head = {
        "Head"
    },
    chest = {
        "UpperTorso",
        "LowerTorso"
    },
    arms = {
        "LeftUpperArm",
        "LeftLowerArm",
        "LeftHand",
        "RightUpperArm",
        "RightLowerArm",
        "RightHand"
    },
    legs = {
        "LeftUpperLeg",
        "LeftLowerLeg",
        "LeftFoot",
        "RightUpperLeg",
        "RightLowerLeg",
        "RightFoot"
    }
}
local vu14 = {
    FindPartOnRayWithIgnoreList = {
        ArgCountRequired = 3,
        Args = {
            "Instance",
            "Ray",
            "table",
            "boolean",
            "boolean"
        }
    },
    FindPartOnRayWithWhitelist = {
        ArgCountRequired = 3,
        Args = {
            "Instance",
            "Ray",
            "table",
            "boolean"
        }
    },
    FindPartOnRay = {
        ArgCountRequired = 2,
        Args = {
            "Instance",
            "Ray",
            "Instance",
            "boolean",
            "boolean"
        }
    },
    Raycast = {
        ArgCountRequired = 3,
        Args = {
            "Instance",
            "Vector3",
            "Vector3",
            "RaycastParams"
        }
    }
}
if not vu1:FindFirstChild("Atmosphere") then
    Instance.new("Atmosphere", vu1)
end
local vu15 = {
    target = nil
}
local vu16 = mousemove or mousemoverel or (mouse_move or false)
if vu16 == false then
    return vu8:Kick("Exploit not supported! Missing: mousemove.")
end
local function vu19(p17, p18)
    return # vu10:GetPartsObscuringTarget({
        vu8.Character.Head.Position,
        p17
    }, p18) == 0 and true or false
end
local function vu26(p20, p21)
    local v22 = 0
    if # p20 < p21.ArgCountRequired then
        return false
    end
    local v23 = next
    local v24 = nil
    while true do
        local v25
        v24, v25 = v23(p20, v24)
        if v24 == nil then
            break
        end
        if typeof(v25) == p21.Args[v24] then
            v22 = v22 + 1
        end
    end
    return p21.ArgCountRequired <= v22
end
local function vu29(p27, p28)
    return (p28 - p27).Unit * 1000
end
local function vu31(p30)
    if p30 == nil then
        p30 = vu8
    end
    return p30 and (p30.Character and (p30.Character.FindFirstChild(p30.Character, "Humanoid") and p30.Character.Humanoid.Health > 0)) and true or false
end
local function vu37(p32)
    local v33, v34, v35 = pairs(p32:GetChildren())
    while true do
        local v36
        v35, v36 = v33(v34, v35)
        if v35 == nil then
            break
        end
        if v36.ClassName == "Tool" then
            return tostring(v36.Name)
        end
    end
    return "NONE"
end
local v38 = "https://raw.githubusercontent.com/fliskScript/jaran/refs/heads/main/other/"
local vu39 = loadstring(game:HttpGet(v38 .. "Library"))()
loadstring(game:HttpGet(v38 .. "Themes"))()
local v40 = loadstring(game:HttpGet(v38 .. "SaveManager"))()
local v41 = vu39
local v42 = vu39.CreateWindow(v41, {
    Title = "<font color=\"#C090E2\">BEArvpfjHD</font> | open source | role: Eclipse",
    Center = true,
    AutoShow = true,
    Size = UDim2.fromOffset(550, 500),
    TabPadding = 8,
    MenuFadeTime = 0.2
})
local v43 = {
    legit = v42:AddTab("legitbot"),
    esp = v42:AddTab("visuals"),
    misc = v42:AddTab("misc"),
    ["UI Settings"] = v42:AddTab("menu")
}
local v44 = v43.legit:AddLeftGroupbox("aimbot")
v44:AddToggle("legit_enabled", {
    Text = "enabled"
})
v44:AddToggle("legit_team", {
    Text = "teammates"
})
v44:AddLabel("activation type"):AddKeyPicker("legit_bind", {
    Default = "MB1",
    Mode = "Hold",
    NoUI = true,
    Text = "legitbot"
})
v44:AddDropdown("legit_hitbox", {
    Text = "target hitbox",
    Default = 1,
    Multi = true,
    Values = {
        "head",
        "chest",
        "arms",
        "legs"
    }
})
v44:AddDropdown("legit_target_priority", {
    Text = "target priority",
    Default = 1,
    Values = {
        "closest to crosshair",
        "distance"
    }
})
v44:AddSlider("legit_speed", {
    Text = "smoothness",
    Default = 8,
    Min = 1,
    Max = 30,
    Rounding = 0
})
v44:AddSlider("legit_aim_fov", {
    Text = "maximum fov",
    Default = 90,
    Min = 0,
    Max = 180,
    Suffix = "\239\191\189",
    Rounding = 0
})
v44:AddSlider("legit_deadzone_fov", {
    Text = "deadzone fov",
    Default = 50,
    Min = 0,
    Max = 140,
    Rounding = 0
})
v44:AddToggle("legit_walls", {
    Text = "aim through walls"
})
v44:AddToggle("legit_forcefield", {
    Text = "aim on forcefield"
})
v44:AddDivider()
v44:AddLabel("silent aim")
v44:AddToggle("legit_silent", {
    Text = "enabled"
})
v44:AddSlider("legit_hitchance", {
    Text = "hitchance",
    Default = 100,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 0
})
v44:AddDropdown("legit_silent_mode", {
    Text = "method",
    Default = 1,
    Values = {
        "raycast",
        "findpartonray",
        "findpartonraywithwhitelist",
        "findpartonraywithignorelist",
        "mouse.hit/target"
    }
})
v44:AddToggle("legit_prediction", {
    Text = "prediction (mouse.hit/target)"
})
v44:AddSlider("legit_prediction_amount", {
    Text = "prediction amount",
    Default = 100,
    Min = 0,
    Max = 100,
    Suffix = "%",
    Rounding = 0
})
local v45 = v43.legit:AddRightGroupbox("triggerbot")
v45:AddToggle("trigger_enabled", {
    Text = "enabled"
})
v45:AddToggle("trigger_team", {
    Text = "teammates"
})
v45:AddToggle("trigger_onkey", {
    Text = "on keybind"
})
v45:AddLabel("activation type"):AddKeyPicker("trigger_bind", {
    Default = "E",
    Mode = "Hold",
    NoUI = true,
    Text = "triggerbot"
})
v45:AddSlider("trigger_delay", {
    Text = "delay",
    Default = 0,
    Min = 0,
    Max = 1000,
    Suffix = "ms",
    Rounding = 0
})
local v46 = v43.legit:AddRightGroupbox("renders")
v46:AddDropdown("legit_fov_position", {
    Text = "circle position",
    Default = 1,
    Values = {
        "center",
        "mouse"
    }
})
v46:AddToggle("legit_fov_render", {
    Text = "aimbot fov render"
}):AddColorPicker("fov_color", {
    Default = Color3.new(1, 1, 1),
    Transparency = 0
})
v46:AddToggle("legit_deadzone_render", {
    Text = "deadzone fov render"
}):AddColorPicker("deadzone_color", {
    Default = Color3.new(1, 0, 0),
    Transparency = 0
})
v46:AddToggle("legit_fov_filled", {
    Text = "aimbot fov filled"
})
v46:AddToggle("legit_target_text", {
    Text = "target name render"
})
local v47 = v43.esp:AddLeftGroupbox("players")
v47:AddToggle("esp_team", {
    Text = "teammates"
})
v47:AddToggle("esp_box", {
    Text = "bounding box"
}):AddColorPicker("box_color", {
    Default = Color3.new(1, 1, 1)
})
v47:AddToggle("esp_healthbar", {
    Text = "healthbar"
}):AddColorPicker("health_color", {
    Default = Color3.fromRGB(172, 223, 126)
})
local v48 = v47:AddDependencyBox()
v48:SetupDependencies({
    {
        Toggles.esp_healthbar,
        true
    }
})
v48:AddToggle("esp_health", {
    Text = "health text"
}):AddColorPicker("htext_color", {
    Default = Color3.fromRGB(172, 223, 126)
})
v47:AddToggle("esp_name", {
    Text = "name"
}):AddColorPicker("name_color", {
    Default = Color3.new(1, 1, 1)
})
v47:AddToggle("esp_weapon", {
    Text = "weapon"
}):AddColorPicker("weapon_color", {
    Default = Color3.new(1, 1, 1)
})
v47:AddToggle("esp_distance", {
    Text = "distance"
}):AddColorPicker("distance_color", {
    Default = Color3.new(1, 1, 1)
})
v47:AddToggle("esp_outoffov", {
    Text = "out of fov"
}):AddColorPicker("arrows_color", {
    Default = Color3.new(1, 1, 1),
    Transparency = 0
})
local v49 = v47:AddDependencyBox()
v49:SetupDependencies({
    {
        Toggles.esp_outoffov,
        true
    }
})
v49:AddToggle("esp_arrowfilled", {
    Text = "arrows filled",
    Default = true
})
v49:AddDropdown("esp_arrows_transparency", {
    Text = "transparency mode",
    Default = 1,
    Values = {
        "static",
        "pulse"
    }
})
v49:AddSlider("esp_arrowsize", {
    Text = "arrows size",
    Default = 64,
    Min = 40,
    Max = 200,
    Rounding = 0
})
v49:AddSlider("esp_arrowoffset", {
    Text = "arrows offset",
    Default = 10,
    Min = 1,
    Max = 30,
    Rounding = 0
})
v47:AddToggle("esp_chams", {
    Text = "chams"
}):AddColorPicker("chams_color", {
    Default = Color3.fromRGB(166, 255, 0),
    Transparency = 0.3
})
local v50 = v47:AddDependencyBox()
v50:SetupDependencies({
    {
        Toggles.esp_chams,
        true
    }
})
v50:AddToggle("esp_chamsoutline", {
    Text = "chams outline"
}):AddColorPicker("ochams_color", {
    Default = Color3.fromRGB(245, 129, 204),
    Transparency = 0.6
})
v47:AddDropdown("esp_font", {
    Text = "font",
    Default = 1,
    Values = {
        "1",
        "2",
        "3"
    }
})
v47:AddSlider("esp_fontsize", {
    Text = "font size",
    Default = 11,
    Min = 7,
    Max = 20,
    Rounding = 0
})
v47:AddSlider("esp_fontflagsize", {
    Text = "font flags size",
    Default = 10,
    Min = 7,
    Max = 20,
    Rounding = 0
})
local v51 = v43.esp:AddRightGroupbox("world")
v51:AddToggle("effects_worldcolor", {
    Text = "world gradient"
}):AddColorPicker("ambient_color", {
    Default = vu1.Ambient,
    Title = "ambient"
}):AddColorPicker("outdoorambient_color", {
    Default = vu1.OutdoorAmbient,
    Title = "outdoor ambient"
})
v51:AddDropdown("effects_brightness", {
    Text = "brightness adjustment",
    Default = 1,
    Values = {
        "-",
        "fullbright",
        "night mode"
    }
})
v51:AddSlider("effects_haze", {
    Text = "haze",
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 0,
    Callback = function(p52)
        vu1.Atmosphere.Haze = p52
    end
})
v51:AddLabel("haze color"):AddColorPicker("haze_color", {
    Default = vu1.Atmosphere.Color,
    Title = "haze",
    Callback = function(p53)
        vu1.Atmosphere.Color = p53
    end
})
v51:AddSlider("effects_glare", {
    Text = "glare",
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 0,
    Callback = function(p54)
        vu1.Atmosphere.Glare = p54
    end
})
v51:AddLabel("decay color"):AddColorPicker("haze_color", {
    Default = vu1.Atmosphere.Color,
    Title = "haze",
    Callback = function(p55)
        vu1.Atmosphere.Decay = p55
    end
})
v51:AddSlider("effects_fog", {
    Text = "fog",
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(p56)
        vu1.Atmosphere.Density = p56
    end
})
v51:AddSlider("effects_fog_visible", {
    Text = "fog visible",
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(p57)
        vu1.Atmosphere.Offset = p57
    end
})
v51:AddSlider("effects_exposure", {
    Text = "exposure",
    Default = vu1.ExposureCompensation,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Callback = function(p58)
        vu1.ExposureCompensation = p58
    end
})
local v59 = v43.misc:AddLeftGroupbox("server")
v59:AddButton({
    Text = "copy place id",
    Func = function()
        setclipboard(game.PlaceId)
    end
})
v59:AddButton({
    Text = "copy job id",
    Func = function()
        setclipboard(game.JobId)
    end
})
v59:AddButton({
    Text = "rejoin to the server",
    Func = function()
        vu4:TeleportToPlaceInstance(game.PlaceId, game.JobId, vu8)
    end
})
local v60 = v43.misc:AddLeftGroupbox("game")
v60:AddSlider("fps_cap", {
    Text = "fps cap",
    Default = 144,
    Min = 20,
    Max = 600,
    Rounding = 0,
    Callback = function(p61)
        setfpscap(p61)
    end
})
v60:AddToggle("misc_fovtoggle", {
    Text = "fov changer"
})
v60:AddSlider("misc_fov", {
    Text = "",
    Default = 70,
    Min = 70,
    Max = 120,
    Rounding = 0,
    Callback = function(p62)
        if vu8.Character ~= nil then
            if Toggles.misc_fovtoggle.Value then
                vu10.FieldOfView = p62
            end
        end
    end
})
vu10:GetPropertyChangedSignal("FieldOfView"):Connect(function(p63)
    if vu8.Character ~= nil then
        if p63 ~= Options.misc_fov.Value then
            if Toggles.misc_fovtoggle.Value then
                vu10.FieldOfView = Options.misc_fov.Value
            end
        end
    else
        return
    end
end)
local v64 = v43.misc:AddRightGroupbox("movement")
v64:AddToggle("move_speedhack", {
    Text = "speedhack"
}):AddKeyPicker("speed_bind", {
    Default = "O",
    Mode = "Toggle",
    Text = "speedhack"
})
v64:AddSlider("move_speed", {
    Text = "speed",
    Default = 60,
    Min = 15,
    Max = 300,
    Suffix = " studs/s",
    Rounding = 0
})
v64:AddToggle("move_noclip", {
    Text = "noclip"
}):AddKeyPicker("noclip_bind", {
    Default = "L",
    Mode = "Toggle",
    Text = "noclip"
})
v64:AddSlider("move_noclipspeed", {
    Text = "speed",
    Default = 80,
    Min = 0,
    Max = 300,
    Rounding = 0
})
v64:AddToggle("move_autojump", {
    Text = "auto jump"
})
v64:AddToggle("move_edge", {
    Text = "jump at edge"
}):AddKeyPicker("edge_bind", {
    Default = "Z",
    Mode = "Hold",
    Text = "jump at edje"
})
local v65 = vu39
vu39.OnUnload(v65, function()
    vu39.Unloaded = true
end)
local v66 = v43["UI Settings"]:AddRightGroupbox("menu")
v66:AddToggle("show_keybinds", {
    Text = "show keybinds",
    Callback = function(p67)
        vu39.KeybindFrame.Visible = p67
    end
})
v66:AddButton("unload", function()
    vu39:Unload()
end)
v66:AddLabel("menu bind"):AddKeyPicker("MenuKeybind", {
    Default = "Insert",
    NoUI = true,
    Text = "menu keybind"
})
vu39.ToggleKeybind = Options.MenuKeybind
v40:SetLibrary(vu39)
v40:IgnoreThemeSettings()
v40:SetIgnoreIndexes({
    "MenuKeybind"
})
v40:SetFolder("jaran/cfgs")
v40:BuildConfigSection(v43["UI Settings"])
v40:LoadAutoloadConfig()
local function vu80()
    local v68 = math.huge
    local v69 = vu7
    local v70, v71, v72 = pairs(v69:GetPlayers())
    local v73 = nil
    while true do
        local v74
        v72, v74 = v70(v71, v72)
        if v72 == nil then
            break
        end
        if vu31(v74) and v74 ~= vu8 and (Toggles.legit_forcefield.Value or not v74.Character:FindFirstChild("ForceField")) and ((Toggles.legit_team.Value or v74.Team ~= vu8.Team) and (Toggles.legit_walls.Value or vu19(v74.Character.Head.Position, {
            v74.Character,
            vu8.Character,
            vu6,
            vu10
        }) == true)) then
            local v75, _ = vu10:WorldToScreenPoint(v74.Character.HumanoidRootPart.Position)
            local v76 = (Vector2.new(vu9.X, vu9.Y) - Vector2.new(v75.X, v75.Y)).magnitude
            if v76 <= Options.legit_aim_fov.Value and Options.legit_deadzone_fov.Value <= v76 or Options.legit_aim_fov.Value == 0 then
                if Options.legit_target_priority.Value ~= "closest to crosshair" then
                    if Options.legit_target_priority.Value == "distance" then
                        local v77 = math.floor((v74.Character.HumanoidRootPart.Position - vu8.Character.HumanoidRootPart.Position).magnitude)
                        if v77 < v68 then
                            v73 = v74
                            v68 = v77
                        end
                    end
                else
                    local v78, _ = vu10:WorldToScreenPoint(v74.Character.HumanoidRootPart.Position)
                    local v79 = (Vector2.new(vu9.X, vu9.Y) - Vector2.new(v78.X, v78.Y)).magnitude
                    if v79 < v68 then
                        v73 = v74
                        v68 = v79
                    end
                end
            end
        end
    end
    if v73 ~= nil then
        return v73
    end
end
function vu11.drawObject(_, p81, p82)
    local v83 = Drawing.new(p81)
    if p82 then
        local v84 = next
        local v85 = nil
        while true do
            local v86
            v85, v86 = v84(p82, v85)
            if v85 == nil then
                break
            end
            v83[v85] = v86
        end
    end
    return v83
end
vu11.default = {
    Line = {
        Thickness = 1.5,
        Color = Color3.fromRGB(255, 255, 255),
        Visible = false
    },
    Text = {
        Size = 13,
        Center = true,
        Outline = true,
        Font = Drawing.Fonts.Plex,
        Color = Color3.fromRGB(255, 255, 255),
        Visible = false
    },
    Square = {
        Thickness = 1,
        Filled = false,
        Color = Color3.fromRGB(255, 255, 255),
        Visible = false
    },
    Triangle = {
        Thickness = 2,
        Filled = false,
        Visible = false,
        Color = Color3.fromRGB(255, 255, 255)
    }
}
function vu11.create(p87, p88, p89)
    local v90 = Drawing.new(p87)
    local v91, v92, v93 = pairs(vu11.default[p87])
    while true do
        local v94
        v93, v94 = v91(v92, v93)
        if v93 == nil then
            break
        end
        v90[v93] = v94
        v90.ZIndex = 2
    end
    if p88 then
        v90.ZIndex = 1
        v90.Color = Color3.new(0, 0, 0)
        v90.Thickness = 2
    end
    if p89 then
        v90.Data = game:HttpGet("https://raw.githubusercontent.com/portallol/luna/main/Gradient180.png")
    end
    return v90
end
function vu11.add(p95)
    if not vu12[p95] then
        vu12[p95] = {
            Name = vu11.create("Text"),
            Weapon = vu11.create("Text"),
            BoxOutline = vu11.create("Square", true),
            Box = vu11.create("Square"),
            Distance = vu11.create("Text"),
            HealthOutline = vu11.create("Line", true),
            Health = vu11.create("Line"),
            HealthText = vu11.create("Text"),
            Arrow = vu11.create("Triangle")
        }
    end
end
local v96, v97, v98 = pairs(vu7:GetPlayers())
local vu99 = vu31
local function vu113(p100)
    local v101 = math.huge
    local v102, v103, v104 = pairs(Options.legit_hitbox.Value)
    local v105 = nil
    while true do
        local v106
        v104, v106 = v102(v103, v104)
        if v104 == nil then
            break
        end
        local v107, v108, v109 = pairs(vu13[v104])
        while true do
            local v110
            v109, v110 = v107(v108, v109)
            if v109 == nil then
                break
            end
            targetpart = p100.Character:FindFirstChild(v110)
            if targetpart ~= nil then
                local v111, _ = vu10:WorldToScreenPoint(targetpart.Position)
                local v112 = (Vector2.new(vu9.X, vu9.Y) - Vector2.new(v111.X, v111.Y)).magnitude
                if v112 < v101 then
                    v105 = targetpart
                    v101 = v112
                end
            end
        end
    end
    if v105 ~= nil then
        return v105
    end
end
while true do
    local v114
    v98, v114 = v96(v97, v98)
    if v98 == nil then
        break
    end
    if Player ~= vu8 then
        vu11.add(v114)
    end
end
vu7.PlayerAdded:Connect(vu11.add)
vu7.PlayerRemoving:Connect(function(p115)
    wait()
    if vu12[p115] then
        local v116, v117, v118 = pairs(vu12[p115])
        while true do
            local v119
            v118, v119 = v116(v117, v118)
            if v118 == nil then
                break
            end
            if v119 then
                v119:Remove()
            end
        end
        vu12[p115] = nil
    end
end)
vu11.drawings.aimbot_fov = vu11:drawObject("Circle", {
    Visible = false,
    Radius = 90,
    Color = Color3.new(1, 1, 1),
    Filled = false
})
vu11.drawings.deadzone_fov = vu11:drawObject("Circle", {
    Visible = false,
    Radius = 50,
    Color = Color3.new(1, 0, 0),
    Filled = false
})
vu11.drawings.target_text = vu11:drawObject("Text", {
    Visible = false,
    Text = "",
    Size = 20,
    Font = 3,
    Center = true
})
function getRotate(p120, p121)
    local v122 = p120.unit
    local v123 = math.sin(p121)
    local v124 = math.cos(p121)
    local v125 = v124 * v122.X - v123 * v122.Y
    local v126 = v123 * v122.X + v124 * v122.Y
    return Vector2.new(v125, v126).unit * p120.Magnitude
end
vu2.RenderStepped:Connect(function(_)
    vu11.drawings.aimbot_fov.Position = Options.legit_fov_position.Value == "center" and vu10.ViewportSize / 2 or vu5:GetMouseLocation()
    vu11.drawings.deadzone_fov.Position = vu11.drawings.aimbot_fov.Position
    local v127 = vu11.drawings.aimbot_fov
    local v128 = Toggles.legit_enabled.Value
    if v128 then
        v128 = Toggles.legit_fov_render.Value
    end
    v127.Visible = v128
    local v129 = vu11.drawings.deadzone_fov
    local v130 = Toggles.legit_enabled.Value
    if v130 then
        v130 = Toggles.legit_deadzone_render.Value
    end
    v129.Visible = v130
    vu11.drawings.aimbot_fov.Color = Options.fov_color.Value
    vu11.drawings.deadzone_fov.Color = Options.deadzone_color.Value
    vu11.drawings.aimbot_fov.Transparency = math.abs(1 - Options.fov_color.Transparency)
    vu11.drawings.deadzone_fov.Transparency = math.abs(1 - Options.deadzone_color.Transparency)
    vu11.drawings.aimbot_fov.Filled = Toggles.legit_fov_filled.Value
    vu11.drawings.aimbot_fov.Radius = Options.legit_aim_fov.Value
    vu11.drawings.deadzone_fov.Radius = Options.legit_deadzone_fov.Value
    if vu99() then
        if Toggles.legit_enabled.Value then
            Player = vu80()
            if Player == nil then
                vu11.drawings.target_text.Text = ""
                if vu15.target ~= nil then
                    vu15.target = nil
                end
            else
                vu11.drawings.target_text.Visible = Toggles.legit_target_text.Value
                vu11.drawings.target_text.Position = vu10.ViewportSize / 2 + Vector2.new(0, Options.legit_aim_fov.Value + 15)
                vu11.drawings.target_text.Text = Player.Name
                hitboxpart = vu113(Player)
                if hitboxpart == nil then
                    if vu15.target ~= nil then
                        vu15.target = nil
                    end
                else
                    local v131, _ = vu10:WorldToScreenPoint(hitboxpart.Position)
                    local v132 = (vu9.X - v131.X) / Options.legit_speed.Value + 1
                    local v133 = (vu9.Y - v131.Y) / Options.legit_speed.Value + 1
                    if Toggles.legit_silent.Value then
                        vu15.target = hitboxpart
                    else
                        if Options.legit_bind:GetState() then
                            vu16(- v132, - v133)
                        end
                        if vu15.target ~= nil then
                            vu15.target = nil
                        end
                    end
                end
            end
        end
        if Toggles.trigger_enabled.Value and (not Toggles.trigger_onkey.Value or Options.trigger_bind:GetState()) and (vu9.Target and vu9.Target.Parent and vu9.Target.Parent:FindFirstChildOfClass("Humanoid")) then
            local vu134 = vu7:GetPlayerFromCharacter(vu9.Target.Parent)
            if Toggles.trigger_team.Value or vu134.Team ~= vu8.Team then
                coroutine.wrap(function()
                    wait(Options.trigger_delay.Value / 1000)
                    mouse1press()
                    repeat
                        vu2.RenderStepped:Wait()
                    until vu9.Target == nil or vu134 ~= vu7:GetPlayerFromCharacter(vu9.Target.Parent)
                    mouse1release()
                end)()
            end
        end
        if Toggles.move_speedhack.Value and Options.speed_bind:GetState() then
            local v135 = Vector3.zero
            if vu5:IsKeyDown("W") then
                v135 = v135 + vu10.CFrame.LookVector
            end
            if vu5:IsKeyDown("S") then
                v135 = v135 - vu10.CFrame.LookVector
            end
            if vu5:IsKeyDown("A") then
                v135 = v135 - vu10.CFrame.RightVector
            end
            if vu5:IsKeyDown("D") then
                v135 = v135 + vu10.CFrame.RightVector
            end
            if v135.Magnitude > 0 then
                local v136 = Vector3.new(v135.X, 0, v135.Z)
                vu8.Character.HumanoidRootPart.Velocity = v136.Unit * (Options.move_speed.Value * 1.3) + Vector3.new(0, vu8.Character.HumanoidRootPart.Velocity.Y, 0)
            end
        end
        if Toggles.move_noclip.Value and Options.noclip_bind:GetState() then
            local v137 = Options.move_noclipspeed.Value
            local v138 = Vector3.new(0, 1, 0)
            if vu5:IsKeyDown(Enum.KeyCode.W) then
                v138 = v138 + vu10.CoordinateFrame.lookVector * v137
            end
            if vu5:IsKeyDown(Enum.KeyCode.A) then
                v138 = v138 + vu10.CoordinateFrame.rightVector * - v137
            end
            if vu5:IsKeyDown(Enum.KeyCode.S) then
                v138 = v138 + vu10.CoordinateFrame.lookVector * - v137
            end
            if vu5:IsKeyDown(Enum.KeyCode.D) then
                v138 = v138 + vu10.CoordinateFrame.rightVector * v137
            end
            vu8.Character.HumanoidRootPart.Velocity = v138
            vu8.Character.Humanoid.PlatformStand = true
            local v139, v140, v141 = pairs(vu8.Character:GetChildren())
            while true do
                local v142
                v141, v142 = v139(v140, v141)
                if v141 == nil then
                    break
                end
                if v142:IsA("BasePart") and v142.CanCollide == true then
                    v142.CanCollide = false
                end
            end
        end
        if Toggles.move_edge.Value and (Options.edge_bind:GetState() and (vu8.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall and vu8.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping)) then
            coroutine.wrap(function()
                vu2.RenderStepped:Wait()
                if vu8.Character ~= nil and (vu8.Character:FindFirstChild("Humanoid") and (vu8.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and vu8.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping)) then
                    vu8.Character.Humanoid:ChangeState("Jumping")
                end
            end)()
        end
    end
    if Toggles.effects_worldcolor.Value then
        vu1.Ambient = Options.effects_brightness.Value == "fullbright" and Color3.new(1, 1, 1) or Options.ambient_color.Value
        vu1.OutdoorAmbient = Options.effects_brightness.Value == "fullbright" and Color3.new(1, 1, 1) or Options.outdoorambient_color.Value
    end
    if Options.effects_brightness.Value ~= "fullbright" then
        if Options.effects_brightness.Value == "night mode" then
            vu1.Brightness = 0
        end
    else
        vu1.Brightness = 2
    end
    local v143 = vu7
    local v144, v145, v146 = pairs(v143:GetPlayers())
    while true do
        local v147
        v146, v147 = v144(v145, v146)
        if v146 == nil then
            break
        end
        local v148 = vu12[v147]
        if v148 == nil then
            return
        end
        if v147.Character and (v147.Character:FindFirstChild("HumanoidRootPart") and (Toggles.esp_team.Value or vu8.Team ~= v147.Team) and vu8 ~= v147 and v147.Character:FindFirstChild("Humanoid")) then
            local v149 = v147.Character.HumanoidRootPart.Position
            local v150, v151 = vu10:WorldToViewportPoint(v149)
            local v152 = vu10
            local v153 = (vu10:WorldToViewportPoint(v149 - Vector3.new(0, 3, 0)).Y - v152:WorldToViewportPoint(v149 + Vector3.new(0, 2.6, 0)).Y) / 2
            local v154 = math.round((vu10.CFrame.Position - v149).Magnitude * 0.28)
            local v155 = tonumber(Options.esp_font.Value)
            local v156 = Options.esp_fontsize.Value
            local v157 = Options.esp_fontflagsize.Value
            v148.Box.Color = Options.box_color.Value
            v148.Box.Size = Vector2.new(v153 * 1.5, v153 * 1.9)
            v148.Box.Position = Vector2.new(v150.X - v153 * 1.5 / 2, v150.Y - v153 * 1.6 / 2)
            if Toggles.esp_box.Value then
                v148.Box.Visible = v151
                v148.BoxOutline.Size = v148.Box.Size
                v148.BoxOutline.Position = v148.Box.Position
                v148.BoxOutline.Visible = v151
            else
                v148.Box.Visible = false
                v148.BoxOutline.Visible = false
            end
            if Toggles.esp_healthbar.Value then
                v148.Health.Color = Options.health_color.Value
                v148.Health.From = Vector2.new(v148.Box.Position.X - 5, v148.Box.Position.Y + v148.Box.Size.Y)
                v148.Health.To = Vector2.new(v148.Health.From.X, v148.Health.From.Y - v147.Character.Humanoid.Health / v147.Character.Humanoid.MaxHealth * v148.Box.Size.Y)
                v148.Health.Visible = v151
                v148.HealthOutline.From = Vector2.new(v148.Health.From.X, v148.Box.Position.Y + v148.Box.Size.Y + 1)
                v148.HealthOutline.To = Vector2.new(v148.Health.From.X, v148.Health.From.Y - 1 * v148.Box.Size.Y - 1)
                v148.HealthOutline.Visible = v151
            else
                v148.Health.Visible = false
                v148.HealthOutline.Visible = false
            end
            if Toggles.esp_health.Value and (Toggles.esp_healthbar.Value and (v147.Character.Humanoid.Health ~= 0 and v147.Character.Humanoid.Health < 100)) then
                v148.HealthText.Color = Options.htext_color.Value
                v148.HealthText.Text = math.round(v147.Character.Humanoid.Health)
                v148.HealthText.Position = Vector2.new(v148.Health.To.X - 10, v148.Health.To.Y)
                v148.HealthText.Font = v155
                v148.HealthText.Outline = true
                v148.HealthText.Size = v157
                v148.HealthText.Visible = v151
            else
                v148.HealthText.Visible = false
            end
            if Toggles.esp_weapon.Value then
                v148.Weapon.Color = Options.weapon_color.Value
                v148.Weapon.Text = tostring(vu37(v147.Character))
                v148.Weapon.Position = Vector2.new(v148.Box.Size.X / 2 + v148.Box.Position.X, v148.Box.Size.Y + v148.Box.Position.Y + 2)
                v148.Weapon.Font = 5
                v148.Weapon.Outline = true
                v148.Weapon.Size = v156
                v148.Weapon.Visible = v151
            else
                v148.Weapon.Visible = false
            end
            if Toggles.esp_name.Value then
                v148.Name.Color = Options.name_color.Value
                v148.Name.Text = v147.Name
                v148.Name.Position = Vector2.new(v148.Box.Size.X / 2 + v148.Box.Position.X, v148.Box.Position.Y - 16)
                v148.Name.Font = v155
                v148.Name.Outline = true
                v148.Name.Size = v156
                v148.Name.Visible = v151
            else
                v148.Name.Visible = false
            end
            if Toggles.esp_distance.Value then
                v148.Distance.Color = Options.distance_color.Value
                v148.Distance.Text = "[" .. v154 .. "M]"
                v148.Distance.Position = Vector2.new(v148.Box.Size.X / 2 + v148.Box.Position.X, v148.Box.Size.Y + v148.Box.Position.Y + 2) + Vector2.new(0, Toggles.esp_weapon.Value and Options.esp_fontsize.Value or 0)
                v148.Distance.Font = v155
                v148.Distance.Outline = true
                v148.Distance.Size = v156
                v148.Distance.Visible = v151
            else
                v148.Distance.Visible = false
            end
            if Toggles.esp_outoffov.Value then
                v148.Arrow.Visible = not v151
                local v158 = vu10.CFrame:PointToObjectSpace(v147.Character.HumanoidRootPart.Position)
                local v159 = math.atan2(- v158.Y, v158.X)
                local v160 = Vector2.new(math.cos(v159), math.sin(v159))
                local v161 = v160 * vu10.ViewportSize * (Options.esp_arrowoffset.Value / 100) + vu10.ViewportSize / 2
                local v162 = math.floor(vu10.ViewportSize.X / math.abs(256 - Options.esp_arrowsize.Value))
                v148.Arrow.PointA = v161
                v148.Arrow.PointB = v161 - getRotate(v160, 0.5) * v162
                v148.Arrow.PointC = v161 - getRotate(v160, - 0.5) * v162
                v148.Arrow.Color = Options.arrows_color.Value
                v148.Arrow.Transparency = Options.esp_arrows_transparency.Value == "pulse" and math.abs(math.sin(tick() * 0.8)) or math.abs(1 - Options.arrows_color.Transparency)
                v148.Arrow.Filled = Toggles.esp_arrowfilled.Value
            else
                v148.Arrow.Visible = false
            end
            if Toggles.esp_chams.Value then
                if not v147.Character:FindFirstChildOfClass("Highlight") then
                    local v163 = Instance.new("Highlight", v147.Character)
                    v163.FillTransparency = Options.chams_color.Transparency
                    v163.OutlineTransparency = 1
                end
                v147.Character.Highlight.FillColor = Options.chams_color.Value
                if Toggles.esp_chamsoutline.Value and Toggles.esp_chams.Value then
                    v147.Character.Highlight.OutlineTransparency = Options.ochams_color.Transparency
                    v147.Character.Highlight.OutlineColor = Options.ochams_color.Value
                else
                    v147.Character.Highlight.OutlineTransparency = 1
                end
            elseif v147.Character:FindFirstChildOfClass("Highlight") then
                v147.Character:FindFirstChildOfClass("Highlight"):Destroy()
            end
        elseif v147.Name ~= vu8.Name then
            local v164, v165, v166 = pairs(v148)
            while true do
                local v167
                v166, v167 = v164(v165, v166)
                if v166 == nil then
                    break
                end
                v167.Visible = false
            end
        end
    end
end)
local vu168 = nil
vu168 = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local v169 = getnamecallmethod()
    local v170 = {
        ...
    }
    local v171 = v170[1]
    if Toggles.legit_enabled.Value and (v171 == workspace and (not checkcaller() and math.random(0, 100) <= Options.legit_hitchance.Value)) then
        if v169 == "FindPartOnRayWithIgnoreList" and Options.legit_silent_mode.Value == v169:lower() then
            if vu26(v170, vu14.FindPartOnRayWithIgnoreList) then
                local v172 = v170[2]
                if vu15.target ~= nil then
                    local v173 = v172.Origin
                    local v174 = vu29(v173, vu15.target.Position)
                    v170[2] = Ray.new(v173, v174)
                    return vu168(unpack(v170))
                end
            end
        elseif v169 == "FindPartOnRayWithWhitelist" and Options.legit_silent_mode.Value == v169:lower() then
            if vu26(v170, vu14.FindPartOnRayWithWhitelist) then
                local v175 = v170[2]
                if vu15.target ~= nil then
                    local v176 = v175.Origin
                    local v177 = vu29(v176, vu15.target.Position)
                    v170[2] = Ray.new(v176, v177)
                    return vu168(unpack(v170))
                end
            end
        elseif (v169 == "FindPartOnRay" or v169 == "findPartOnRay") and Options.legit_silent_mode.Value:lower() == v169:lower() then
            if vu26(v170, vu14.FindPartOnRay) then
                local v178 = v170[2]
                if vu15.target ~= nil then
                    local v179 = v178.Origin
                    local v180 = vu29(v179, vu15.target.Position)
                    v170[2] = Ray.new(v179, v180)
                    return vu168(unpack(v170))
                end
            end
        elseif v169 == "Raycast" and (Options.legit_silent_mode.Value == v169:lower() and vu26(v170, vu14.Raycast)) then
            local v181 = v170[2]
            if vu15.target then
                v170[3] = vu29(v181, vu15.target.Position)
                return vu168(unpack(v170))
            end
        end
    end
    return vu168(...)
end))
local vu182 = nil
vu182 = hookmetamethod(game, "__index", newcclosure(function(p183, p184)
    if p183 == vu9 and (not checkcaller() and (Toggles.legit_enabled.Value and (Options.legit_silent_mode.Value == "mouse.hit/target" and vu15.target ~= nil))) then
        if p184 == "Target" or p184 == "target" then
            return vu15.target
        end
        if p184 == "Hit" or p184 == "hit" then
            local v185 = Toggles.legit_prediction.Value and vu15.target.CFrame + vu15.target.Velocity * Options.legit_prediction_amount.Value
            if not v185 then
                if Toggles.legit_prediction.Value then
                    v185 = false
                else
                    v185 = vu15.target.CFrame
                end
            end
            return v185
        end
        if p184 == "X" or p184 == "x" then
            return p183.X
        end
        if p184 == "Y" or p184 == "y" then
            return p183.Y
        end
        if p184 == "UnitRay" then
            return Ray.new(p183.Origin, (p183.Hit - p183.Origin).Unit)
        end
    end
    return vu182(p183, p184)
end))

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
desc.Text = "https://github.com/fluxe240/Eclipse/blob/main/universal.lua"
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
	local link = "https://github.com/fluxe240/Eclipse/blob/main/universal.lua"
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
