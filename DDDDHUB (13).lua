-- DDDD HUB VIP
local KEY = "DDDD-GIKD-56GF"
local KEY_FILE = "DDDDHUB_VIP_key.txt"

local function savedKeyOk()
    if not (isfile and readfile) then return false end
    local ok, data = pcall(function()
        if not isfile(KEY_FILE) then return "" end
        return readfile(KEY_FILE)
    end)
    return ok and data == KEY
end

local function saveKey()
    if writefile then
        pcall(function() writefile(KEY_FILE, KEY) end)
    end
end

if game:GetService("CoreGui"):FindFirstChild("DDDDHUB") then
    game:GetService("CoreGui"):FindFirstChild("DDDDHUB"):Destroy()
end
pcall(function() game:GetService("CoreGui"):FindFirstChild("NeonCustomCrosshairSuite"):Destroy() end)
pcall(function() game:GetService("RunService"):UnbindFromRenderStep("DDDD_RestoreDesync") end)
pcall(function() game:GetService("RunService"):UnbindFromRenderStep("DDDD_SniperAim") end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local accent = Color3.fromRGB(0, 170, 255)
local accentHot = Color3.fromRGB(80, 230, 255)
local bg = Color3.fromRGB(6, 10, 16)
local panel = Color3.fromRGB(10, 18, 28)
local white = Color3.fromRGB(235, 248, 255)
local muted = Color3.fromRGB(120, 150, 170)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DDDDHUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local function corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = parent
    return c
end
local function stroke(parent, color, t)
    local s = Instance.new("UIStroke")
    s.Color = color or accent
    s.Thickness = t or 1
    s.Parent = parent
    return s
end

local keyFrame = Instance.new("Frame", ScreenGui)
keyFrame.Size = UDim2.new(0, 340, 0, 168)
keyFrame.Position = UDim2.new(0.5, -170, 0.5, -40)
keyFrame.BackgroundColor3 = bg
keyFrame.BackgroundTransparency = 1
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
corner(keyFrame, 8)
local keyStroke = stroke(keyFrame, accent, 1)
keyStroke.Transparency = 1

local keyBar = Instance.new("TextButton", keyFrame)
keyBar.Size = UDim2.new(1, 0, 0, 32)
keyBar.BackgroundColor3 = panel
keyBar.BackgroundTransparency = 1
keyBar.BorderSizePixel = 0
keyBar.Text = ""
keyBar.AutoButtonColor = false
local keyTitle = Instance.new("TextLabel", keyBar)
keyTitle.Size = UDim2.new(1, -40, 1, 0)
keyTitle.Position = UDim2.new(0, 12, 0, 0)
keyTitle.BackgroundTransparency = 1
keyTitle.Font = Enum.Font.RobotoMono
keyTitle.TextSize = 13
keyTitle.TextXAlignment = Enum.TextXAlignment.Left
keyTitle.TextColor3 = white
keyTitle.TextTransparency = 1
keyTitle.Text = "DDDD HUB VIP"
local keyClose = Instance.new("TextButton", keyBar)
keyClose.Size = UDim2.new(0, 24, 0, 24)
keyClose.Position = UDim2.new(1, -28, 0, 4)
keyClose.BackgroundTransparency = 1
keyClose.Font = Enum.Font.SourceSansBold
keyClose.TextSize = 16
keyClose.TextColor3 = white
keyClose.TextTransparency = 1
keyClose.Text = "X"

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(1, -24, 0, 32)
keyBox.Position = UDim2.new(0, 12, 0, 46)
keyBox.BackgroundColor3 = panel
keyBox.BackgroundTransparency = 1
keyBox.BorderSizePixel = 0
keyBox.ClearTextOnFocus = false
keyBox.Font = Enum.Font.RobotoMono
keyBox.TextSize = 14
keyBox.TextColor3 = white
keyBox.TextTransparency = 1
keyBox.PlaceholderText = "Enter key"
keyBox.PlaceholderColor3 = muted
keyBox.Text = ""
corner(keyBox, 4)
local boxStroke = stroke(keyBox, accent, 1)
boxStroke.Transparency = 1

local keyStatus = Instance.new("TextLabel", keyFrame)
keyStatus.Size = UDim2.new(1, -24, 0, 16)
keyStatus.Position = UDim2.new(0, 12, 0, 84)
keyStatus.BackgroundTransparency = 1
keyStatus.Font = Enum.Font.SourceSans
keyStatus.TextSize = 13
keyStatus.TextXAlignment = Enum.TextXAlignment.Left
keyStatus.TextColor3 = muted
keyStatus.TextTransparency = 1
keyStatus.Text = "RightShift opens the hub"

local keyButton = Instance.new("TextButton", keyFrame)
keyButton.Size = UDim2.new(1, -24, 0, 28)
keyButton.Position = UDim2.new(0, 12, 1, -40)
keyButton.BackgroundColor3 = Color3.fromRGB(12, 28, 42)
keyButton.BackgroundTransparency = 1
keyButton.BorderSizePixel = 0
keyButton.Font = Enum.Font.SourceSansBold
keyButton.TextSize = 14
keyButton.TextColor3 = white
keyButton.TextTransparency = 1
keyButton.Text = "Unlock"
corner(keyButton, 4)
local btnStroke = stroke(keyButton, accent, 1)
btnStroke.Transparency = 1

local keyDragging, keyDragStart, keyStart = false, nil, nil
keyBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        keyDragging = true
        keyDragStart = input.Position
        keyStart = keyFrame.Position
    end
end)
keyBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then keyDragging = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if keyDragging and input.UserInputType == Enum.UserInputType.MouseMovement and keyStart and keyDragStart then
        local d = input.Position - keyDragStart
        keyFrame.Position = UDim2.new(keyStart.X.Scale, keyStart.X.Offset + d.X, keyStart.Y.Scale, keyStart.Y.Offset + d.Y)
    end
end)

local function fadeKey(show)
    local t = show and 0 or 1
    TweenService:Create(keyFrame, TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = t, Position = keyFrame.Position + UDim2.new(0, 0, 0, show and 0 or 12)}):Play()
    TweenService:Create(keyStroke, TweenInfo.new(0.28), {Transparency = t}):Play()
    TweenService:Create(keyBar, TweenInfo.new(0.28), {BackgroundTransparency = t}):Play()
    for _, obj in ipairs({keyTitle, keyClose, keyBox, keyStatus, keyButton}) do
        if obj:IsA("TextBox") or obj:IsA("TextButton") or obj:IsA("TextLabel") then
            TweenService:Create(obj, TweenInfo.new(0.28), {TextTransparency = t, BackgroundTransparency = obj == keyBox or obj == keyButton and t or 1}):Play()
        end
    end
    TweenService:Create(boxStroke, TweenInfo.new(0.28), {Transparency = t}):Play()
    TweenService:Create(btnStroke, TweenInfo.new(0.28), {Transparency = t}):Play()
end
keyFrame.Position = UDim2.new(0.5, -170, 0.5, -20)
task.defer(function()
    TweenService:Create(keyFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -170, 0.5, -84),
        BackgroundTransparency = 0
    }):Play()
    fadeKey(true)
end)

local keyClosed = false
keyClose.MouseButton1Click:Connect(function()
    if keyClosed then return end
    keyClosed = true
    fadeKey(false)
    task.delay(0.3, function()
        pcall(function() ScreenGui:Destroy() end)
    end)
end)

local unlocked = false
local connections = {}
local function track(c)
    table.insert(connections, c)
    return c
end

local function boot()
    keyFrame:Destroy()

    getgenv().Aimbot = false
    getgenv().SniperMode = false
    getgenv().TriggerBot = false
    getgenv().TriggerSize = 14
    getgenv().SilentAim = false
    getgenv().DrawSilentPOV = false
    getgenv().SilentHead = 50
    getgenv().SilentBody = 50
    getgenv().Smoothness = 1
    getgenv().FOV = 120
    getgenv().DrawFOV = false
    getgenv().BoxESP = false
    getgenv().VisibleCheck = false
    getgenv().ESPColor = Color3.fromRGB(0, 200, 255)
    getgenv().Speed = 16
    getgenv().Fly = false
    getgenv().FlySpeed = 50
    getgenv().InfiniteJump = false
    getgenv().AimbotKey = Enum.UserInputType.MouseButton1
    getgenv().MenuKey = Enum.KeyCode.RightShift
    getgenv().SpinCrosshair = false
    getgenv().Ragebot = false
    getgenv().RageDistance = 3
    getgenv().TeamCheck = true
    getgenv().DeviceSpoof = false
    getgenv().SpoofDevice = "MouseKeyboard"
    getgenv().RapidFire = false
    getgenv().NameESP = false
    getgenv().HealthESP = false
    getgenv().DistanceESP = false
    getgenv().Noclip = false
    getgenv().CameraFOVOn = false
    getgenv().CameraFOV = 90
    getgenv().SkeletonESP = false
    getgenv().FullAuto = false
    getgenv().NoSpread = false
    getgenv().Chams = false
    getgenv().WeaponESP = false
    getgenv().HitChance = 100
    getgenv().MaxDistance = 500
    getgenv().LimitDistance = false
    getgenv().ClockTimeOn = false
    getgenv().ClockTime = 14
    getgenv().RemoveVignette = false
    getgenv().ViewmodelColor = false

    local Main = Instance.new("Frame", ScreenGui)
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 520, 0, 400)
    Main.Position = UDim2.new(0.5, -260, 0.5, -200)
    Main.BackgroundColor3 = bg
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Visible = false
    corner(Main, 6)
    stroke(Main, accent, 1)

    local dragBar = Instance.new("TextButton", Main)
    dragBar.Size = UDim2.new(1, 0, 0, 32)
    dragBar.BackgroundColor3 = panel
    dragBar.BorderSizePixel = 0
    dragBar.Text = ""
    dragBar.AutoButtonColor = false
    local title = Instance.new("TextLabel", dragBar)
    title.Size = UDim2.new(1, -12, 1, 0)
    title.Position = UDim2.new(0, 12, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.RobotoMono
    title.TextSize = 12
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextColor3 = white
    title.Text = "DDDD HUB VIP"

    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    track(dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end))
    track(dragBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end))
    track(UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
        if dragging and input == dragInput and startPos and dragStart then
            local d = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end))

    local tabBar = Instance.new("Frame", Main)
    tabBar.Size = UDim2.new(0, 118, 1, -32)
    tabBar.Position = UDim2.new(0, 0, 0, 32)
    tabBar.BackgroundColor3 = panel
    tabBar.BorderSizePixel = 0
    local content = Instance.new("Frame", Main)
    content.Size = UDim2.new(1, -118, 1, -32)
    content.Position = UDim2.new(0, 118, 0, 32)
    content.BackgroundTransparency = 1

    local pages = {}
    for i, name in ipairs({"Aim", "Rage", "Visuals", "Move", "Exploits", "Cosmetics", "Misc"}) do
        local btn = Instance.new("TextButton", tabBar)
        btn.Size = UDim2.new(1, 0, 0, 36)
        btn.Position = UDim2.new(0, 0, 0, (i - 1) * 36)
        btn.BackgroundTransparency = 1
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 14
        btn.Text = name
        btn.TextColor3 = i == 1 and accentHot or muted
        local mark = Instance.new("Frame", btn)
        mark.Name = "Mark"
        mark.Size = UDim2.new(0, 2, 1, 0)
        mark.BackgroundColor3 = accentHot
        mark.BorderSizePixel = 0
        mark.Visible = i == 1
        local page = Instance.new("ScrollingFrame", content)
        page.Size = UDim2.new(1, -16, 1, -16)
        page.Position = UDim2.new(0, 8, 0, 8)
        page.BackgroundTransparency = 1
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.ScrollBarThickness = 2
        page.Visible = i == 1
        local layout = Instance.new("UIListLayout", page)
        layout.Padding = UDim.new(0, 6)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        pages[name] = page
        btn.MouseButton1Click:Connect(function()
            for _, p in pairs(pages) do p.Visible = false end
            for _, child in ipairs(tabBar:GetChildren()) do
                if child:IsA("TextButton") then
                    child.TextColor3 = muted
                    local m = child:FindFirstChild("Mark")
                    if m then m.Visible = false end
                end
            end
            btn.TextColor3 = accentHot
            mark.Visible = true
            page.Visible = true
        end)
    end

    local function makeToggle(parent, text, default, callback)
        local row = Instance.new("Frame", parent)
        row.Size = UDim2.new(1, 0, 0, 28)
        row.BackgroundTransparency = 1
        local label = Instance.new("TextLabel", row)
        label.Size = UDim2.new(0.72, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.SourceSans
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextColor3 = Color3.fromRGB(190, 220, 235)
        label.Text = text
        local button = Instance.new("TextButton", row)
        button.Size = UDim2.new(0, 30, 0, 14)
        button.Position = UDim2.new(1, -34, 0.5, -7)
        button.Text = ""
        button.BackgroundColor3 = default and accentHot or Color3.fromRGB(16, 22, 30)
        corner(button, 2)
        local st = stroke(button, default and accentHot or Color3.fromRGB(50, 70, 85), 1)
        local state = default and true or false
        button.MouseButton1Click:Connect(function()
            if unloaded then return end
            state = not state
            TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = state and accentHot or Color3.fromRGB(16, 22, 30)}):Play()
            TweenService:Create(st, TweenInfo.new(0.15), {Color = state and accentHot or Color3.fromRGB(50, 70, 85)}):Play()
            callback(state)
        end)
    end

    local function makeSlider(parent, text, min, max, default, callback)
        local row = Instance.new("Frame", parent)
        row.Size = UDim2.new(1, 0, 0, 36)
        row.BackgroundTransparency = 1
        local label = Instance.new("TextLabel", row)
        label.Size = UDim2.new(1, 0, 0, 16)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.SourceSans
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextColor3 = Color3.fromRGB(170, 200, 220)
        label.Text = text .. " (" .. tostring(default) .. ")"
        local trackBtn = Instance.new("TextButton", row)
        trackBtn.Size = UDim2.new(1, -8, 0, 5)
        trackBtn.Position = UDim2.new(0, 0, 0, 22)
        trackBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
        trackBtn.Text = ""
        trackBtn.AutoButtonColor = false
        corner(trackBtn, 2)
        local fill = Instance.new("Frame", trackBtn)
        fill.Size = UDim2.new(math.clamp((default - min) / math.max(max - min, 1), 0, 1), 0, 1, 0)
        fill.BackgroundColor3 = accent
        fill.BorderSizePixel = 0
        corner(fill, 2)
        local sliding = false
        local function apply(x)
            local rel = math.clamp((x - trackBtn.AbsolutePosition.X) / math.max(trackBtn.AbsoluteSize.X, 1), 0, 1)
            local value = min + rel * (max - min)
            value = (max - min) >= 5 and math.floor(value + 0.5) or math.floor(value * 100 + 0.5) / 100
            fill.Size = UDim2.new(rel, 0, 1, 0)
            label.Text = text .. " (" .. tostring(value) .. ")"
            callback(value)
        end
        trackBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true apply(input.Position.X) end
        end)
        track(UserInputService.InputChanged:Connect(function(input)
            if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then apply(input.Position.X) end
        end))
        track(UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
        end))
    end

    local function makeButton(parent, text, callback)
        local button = Instance.new("TextButton", parent)
        button.Size = UDim2.new(1, -8, 0, 28)
        button.BackgroundColor3 = Color3.fromRGB(12, 28, 42)
        button.BorderSizePixel = 0
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 14
        button.TextColor3 = white
        button.Text = text
        corner(button, 4)
        stroke(button, accent, 1)
        button.MouseButton1Click:Connect(function()
            if not unloaded then callback(button) end
        end)
        return button
    end

    local function makeDropdown(parent, text, options, default, callback)
        local row = Instance.new("Frame", parent)
        row.Size = UDim2.new(1, 0, 0, 46)
        row.BackgroundTransparency = 1
        row.ClipsDescendants = false
        local label = Instance.new("TextLabel", row)
        label.Size = UDim2.new(1, 0, 0, 16)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.SourceSans
        label.TextSize = 13
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextColor3 = Color3.fromRGB(170, 200, 220)
        label.Text = text
        local button = Instance.new("TextButton", row)
        button.Size = UDim2.new(1, -8, 0, 24)
        button.Position = UDim2.new(0, 0, 0, 18)
        button.BackgroundColor3 = Color3.fromRGB(12, 24, 36)
        button.BorderSizePixel = 0
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 13
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.TextColor3 = white
        button.Text = "  " .. default
        button.AutoButtonColor = false
        corner(button, 4)
        stroke(button, accent, 1)
        local list = Instance.new("Frame", row)
        list.BackgroundColor3 = Color3.fromRGB(8, 16, 26)
        list.BorderSizePixel = 0
        list.Position = UDim2.new(0, 0, 0, 44)
        list.Size = UDim2.new(1, -8, 0, 0)
        list.Visible = false
        list.ZIndex = 30
        list.ClipsDescendants = true
        corner(list, 4)
        stroke(list, accent, 1)
        local ll = Instance.new("UIListLayout", list)
        ll.SortOrder = Enum.SortOrder.LayoutOrder
        local open = false
        for _, opt in ipairs(options) do
            local item = Instance.new("TextButton", list)
            item.Size = UDim2.new(1, 0, 0, 22)
            item.BackgroundTransparency = 1
            item.Font = Enum.Font.SourceSans
            item.TextSize = 13
            item.TextXAlignment = Enum.TextXAlignment.Left
            item.TextColor3 = white
            item.Text = "  " .. opt
            item.ZIndex = 31
            item.MouseButton1Click:Connect(function()
                button.Text = "  " .. opt
                open = false
                list.Visible = false
                list.Size = UDim2.new(1, -8, 0, 0)
                row.Size = UDim2.new(1, 0, 0, 46)
                callback(opt)
            end)
        end
        button.MouseButton1Click:Connect(function()
            open = not open
            local h = open and (#options * 22) or 0
            list.Visible = open
            list.Size = UDim2.new(1, -8, 0, h)
            row.Size = UDim2.new(1, 0, 0, 46 + (open and h + 4 or 0))
        end)
    end

    makeToggle(pages.Aim, "Aimbot", false, function(v) getgenv().Aimbot = v end)
    makeToggle(pages.Aim, "Sniper Mode", false, function(v) getgenv().SniperMode = v end)
    makeToggle(pages.Aim, "TriggerBot", false, function(v) getgenv().TriggerBot = v end)
    makeSlider(pages.Aim, "Trigger Size", 4, 40, 14, function(v) getgenv().TriggerSize = v end)
    makeToggle(pages.Aim, "Silent Aim", false, function(v)
        getgenv().SilentAim = v
        if v and _G.DDDD_InstallSilent then _G.DDDD_InstallSilent() end
    end)
    makeToggle(pages.Aim, "Draw Silent POV", false, function(v) getgenv().DrawSilentPOV = v end)

    local silentRow = Instance.new("Frame", pages.Aim)
    silentRow.Size = UDim2.new(1, 0, 0, 78)
    silentRow.BackgroundTransparency = 1
    local headLabel = Instance.new("TextLabel", silentRow)
    headLabel.Size = UDim2.new(1, 0, 0, 16)
    headLabel.BackgroundTransparency = 1
    headLabel.Font = Enum.Font.SourceSans
    headLabel.TextSize = 13
    headLabel.TextXAlignment = Enum.TextXAlignment.Left
    headLabel.TextColor3 = Color3.fromRGB(170, 200, 220)
    headLabel.Text = "Silent Head (50%)"
    local bodyLabel = Instance.new("TextLabel", silentRow)
    bodyLabel.Size = UDim2.new(1, 0, 0, 16)
    bodyLabel.Position = UDim2.new(0, 0, 0, 40)
    bodyLabel.BackgroundTransparency = 1
    bodyLabel.Font = Enum.Font.SourceSans
    bodyLabel.TextSize = 13
    bodyLabel.TextXAlignment = Enum.TextXAlignment.Left
    bodyLabel.TextColor3 = Color3.fromRGB(170, 200, 220)
    bodyLabel.Text = "Silent Body (50%)"
    local headFill, bodyFill
    local function linked(y, isHead)
        local trackBtn = Instance.new("TextButton", silentRow)
        trackBtn.Size = UDim2.new(1, -8, 0, 5)
        trackBtn.Position = UDim2.new(0, 0, 0, y)
        trackBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
        trackBtn.Text = ""
        trackBtn.AutoButtonColor = false
        corner(trackBtn, 2)
        local fill = Instance.new("Frame", trackBtn)
        fill.Size = UDim2.new(0.5, 0, 1, 0)
        fill.BackgroundColor3 = accent
        fill.BorderSizePixel = 0
        corner(fill, 2)
        local sliding = false
        local function apply(x)
            local rel = math.clamp((x - trackBtn.AbsolutePosition.X) / math.max(trackBtn.AbsoluteSize.X, 1), 0, 1)
            local headPct = isHead and math.floor(rel * 100 + 0.5) or (100 - math.floor(rel * 100 + 0.5))
            getgenv().SilentHead = headPct
            getgenv().SilentBody = 100 - headPct
            headLabel.Text = "Silent Head (" .. headPct .. "%)"
            bodyLabel.Text = "Silent Body (" .. (100 - headPct) .. "%)"
            if headFill then headFill.Size = UDim2.new(headPct / 100, 0, 1, 0) end
            if bodyFill then bodyFill.Size = UDim2.new((100 - headPct) / 100, 0, 1, 0) end
        end
        trackBtn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true apply(input.Position.X) end
        end)
        track(UserInputService.InputChanged:Connect(function(input)
            if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then apply(input.Position.X) end
        end))
        track(UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
        end))
        return fill
    end
    headFill = linked(20, true)
    bodyFill = linked(60, false)

    makeToggle(pages.Aim, "Draw FOV", false, function(v) getgenv().DrawFOV = v end)
    makeSlider(pages.Aim, "FOV Size", 30, 800, 120, function(v) getgenv().FOV = v end)
    makeSlider(pages.Aim, "Smooth", 1, 10, 1, function(v) getgenv().Smoothness = v end)

    makeSlider(pages.Aim, "Hit Chance", 1, 100, 100, function(v) getgenv().HitChance = v end)
    makeToggle(pages.Aim, "Limit Distance", false, function(v) getgenv().LimitDistance = v end)
    makeSlider(pages.Aim, "Max Distance", 50, 2000, 500, function(v) getgenv().MaxDistance = v end)

    makeToggle(pages.Rage, "Ragebot", false, function(v)
        getgenv().Ragebot = v
        if _G.DDDD_StartRagebot then _G.DDDD_StartRagebot(v) end
    end)
    makeSlider(pages.Rage, "Rage Distance", 0, 15, 3, function(v) getgenv().RageDistance = v end)
    makeToggle(pages.Rage, "Team Check", true, function(v) getgenv().TeamCheck = v end)

    makeToggle(pages.Visuals, "Box ESP", false, function(v) getgenv().BoxESP = v end)
    makeToggle(pages.Visuals, "Name ESP", false, function(v) getgenv().NameESP = v end)
    makeToggle(pages.Visuals, "Health ESP", false, function(v) getgenv().HealthESP = v end)
    makeToggle(pages.Visuals, "Distance ESP", false, function(v) getgenv().DistanceESP = v end)
    makeToggle(pages.Visuals, "Chams", false, function(v) getgenv().Chams = v end)
    makeToggle(pages.Visuals, "Weapon ESP", false, function(v) getgenv().WeaponESP = v end)
    makeToggle(pages.Visuals, "Skeleton ESP", false, function(v) getgenv().SkeletonESP = v end)
    makeToggle(pages.Visuals, "Visibility Check", false, function(v) getgenv().VisibleCheck = v end)
    makeToggle(pages.Visuals, "Spin Crosshair", false, function(v) getgenv().SpinCrosshair = v end)

    makeToggle(pages.Move, "Fly", false, function(v) getgenv().Fly = v end)
    makeToggle(pages.Move, "Noclip", false, function(v) getgenv().Noclip = v end)
    makeSlider(pages.Move, "Speed", 16, 200, 16, function(v) getgenv().Speed = v end)
    makeSlider(pages.Move, "Fly Speed", 20, 300, 50, function(v) getgenv().FlySpeed = v end)
    makeToggle(pages.Move, "Infinite Jump", false, function(v) getgenv().InfiniteJump = v end)

    makeToggle(pages.Exploits, "Rapid Fire", false, function(v)
        getgenv().RapidFire = v
        if _G.DDDD_SetRapidFire then _G.DDDD_SetRapidFire(v) end
    end)
    makeToggle(pages.Exploits, "Full Auto", false, function(v)
        getgenv().FullAuto = v
        if _G.DDDD_SetRapidFire then _G.DDDD_SetRapidFire(v or getgenv().RapidFire) end
    end)
    makeToggle(pages.Exploits, "No Spread", false, function(v)
        getgenv().NoSpread = v
        if _G.DDDD_SetRapidFire then _G.DDDD_SetRapidFire(v or getgenv().RapidFire) end
    end)
    makeToggle(pages.Exploits, "Device Spoofer", false, function(v)
        getgenv().DeviceSpoof = v
        if v then applyDevice() end
    end)
    makeDropdown(pages.Exploits, "Spoof", {"Touch", "Gamepad", "MouseKeyboard", "VR"}, "MouseKeyboard", function(v)
        getgenv().SpoofDevice = v
        if getgenv().DeviceSpoof then applyDevice() end
    end)
    makeToggle(pages.Exploits, "FOV Changer", false, function(v) getgenv().CameraFOVOn = v end)
    makeSlider(pages.Exploits, "Camera FOV", 40, 120, 90, function(v) getgenv().CameraFOV = v end)
    makeToggle(pages.Exploits, "Auto Queue", false, function(v) getgenv().AutoQueue = v end)
    makeToggle(pages.Exploits, "Remove Vignette", false, function(v) getgenv().RemoveVignette = v end)
    makeToggle(pages.Exploits, "Clock Time", false, function(v) getgenv().ClockTimeOn = v end)
    makeSlider(pages.Exploits, "Time", 0, 24, 14, function(v) getgenv().ClockTime = v end)
    makeToggle(pages.Exploits, "Viewmodel Color", false, function(v) getgenv().ViewmodelColor = v end)

    makeButton(pages.Cosmetics, "UNLOCK ALL", function(button)
        button.Text = "UNLOCK ALL..."
        local ok = pcall(function() if _G.DDDD_UnlockAll then _G.DDDD_UnlockAll() end end)
        button.Text = ok and "UNLOCK ALL (saved)" or "UNLOCK ALL failed"
    end)

    makeButton(pages.Misc, "Menu Key: RightShift", function(button)
        button.Text = "Press a key"
        local conn
        conn = UserInputService.InputBegan:Connect(function(input, processed)
            if processed then return end
            if input.KeyCode ~= Enum.KeyCode.Unknown then
                getgenv().MenuKey = input.KeyCode
                button.Text = "Menu Key: " .. input.KeyCode.Name
                conn:Disconnect()
            end
        end)
    end)
    makeButton(pages.Misc, "Unload", function()
        if _G.DDDD_Unload then _G.DDDD_Unload() end
    end)

    function applyDevice()
        pcall(function()
            ReplicatedStorage.Remotes.Replication.Fighter.SetControls:FireServer(getgenv().SpoofDevice)
        end)
    end

    local menuOpen = true
    local function toggleMenu()
        if unloaded then return end
        menuOpen = not menuOpen
        Main.Visible = menuOpen
    end
    track(UserInputService.InputBegan:Connect(function(input)
        if unloaded then return end
        if input.KeyCode == getgenv().MenuKey then
            toggleMenu()
        end
    end))

    local fovCircle = Drawing.new("Circle")
    fovCircle.Visible = false
    fovCircle.Color = accentHot
    fovCircle.Thickness = 1
    fovCircle.NumSides = 64
    local silentCircle = Drawing.new("Circle")
    silentCircle.Visible = false
    silentCircle.Thickness = 1
    silentCircle.NumSides = 48
    silentCircle.Filled = false

    local function sameTeam(player)
        if not getgenv().TeamCheck then return false end
        local a, b = LocalPlayer:GetAttribute("TeamID"), player:GetAttribute("TeamID")
        if a ~= nil and b ~= nil then return a == b end
        return LocalPlayer.Team ~= nil and player.Team == LocalPlayer.Team
    end
    local function visible(char, part)
        part = part or char:FindFirstChild("HumanoidRootPart")
        if not part then return false end
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {LocalPlayer.Character, char, Camera}
        local hit = Workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, params)
        return not hit or hit.Instance:IsDescendantOf(char)
    end
    local function aimPart(char)
        return char:FindFirstChild("HeadHB") or char:FindFirstChild("HitboxHead") or char:FindFirstChild("Head") or char:FindFirstChild("UpperTorso")
    end

    local espBoxes = {}
    local function addEsp(player)
        if player == LocalPlayer or espBoxes[player] then return end
        local sq = Drawing.new("Square")
        sq.Visible = false
        sq.Thickness = 1
        sq.Filled = false
        local name = Drawing.new("Text")
        name.Visible = false
        name.Size = 14
        name.Center = true
        name.Outline = true
        local hp = Drawing.new("Text")
        hp.Visible = false
        hp.Size = 13
        hp.Center = true
        hp.Outline = true
        local dist = Drawing.new("Text")
        dist.Visible = false
        dist.Size = 13
        dist.Center = true
        dist.Outline = true
        local bones = {}
        for i = 1, 8 do
            local line = Drawing.new("Line")
            line.Visible = false
            line.Thickness = 1
            bones[i] = line
        end
        espBoxes[player] = {box = sq, name = name, hp = hp, dist = dist, bones = bones}
    end
    track(Players.PlayerAdded:Connect(addEsp))
    for _, p in ipairs(Players:GetPlayers()) do addEsp(p) end
    track(Players.PlayerRemoving:Connect(function(p)
        if espBoxes[p] then
            for _, d in pairs(espBoxes[p]) do pcall(function() d:Destroy() end) end
            espBoxes[p] = nil
        end
    end))

    local aiming = false
    track(UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.UserInputType == getgenv().AimbotKey or input.KeyCode == getgenv().AimbotKey then aiming = true end
    end))
    track(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == getgenv().AimbotKey or input.KeyCode == getgenv().AimbotKey then aiming = false end
    end))

    local currentTarget, realCF, realVel, rageConn, lastToast = nil, nil, nil, nil, 0
    local function rageHead(char)
        return char and (char:FindFirstChild("HitboxHead") or char:FindFirstChild("HitboxHeadSmall") or char:FindFirstChild("Head"))
    end
    _G.DDDD_StartRagebot = function(on)
        if rageConn then rageConn:Disconnect() rageConn = nil end
        if not on then return end
        local FighterCtrl, EnumLib, useItem, startShoot, cachedId
        local function resolve()
            if not FighterCtrl then
                local ok, mod = pcall(require, LocalPlayer.PlayerScripts.Controllers.FighterController)
                if ok then FighterCtrl = mod end
            end
            if not EnumLib then
                local ok, mod = pcall(require, ReplicatedStorage.Modules.EnumLibrary)
                if ok then EnumLib = mod pcall(function() EnumLib:WaitForEnumBuilder() end) end
            end
            if not useItem then
                pcall(function()
                    useItem = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter"):WaitForChild("UseItem")
                end)
            end
            if not startShoot and EnumLib then
                pcall(function() startShoot = EnumLib:ToEnum("StartShooting") end)
                if not startShoot then startShoot = "\26" end
            end
        end
        local function objId()
            resolve()
            if not FighterCtrl then return cachedId end
            local item
            pcall(function()
                item = FighterCtrl.LocalFighter and FighterCtrl.LocalFighter.EquippedItem
                if not item and FighterCtrl.GetFighter then
                    local f = FighterCtrl:GetFighter(LocalPlayer)
                    item = f and f.EquippedItem
                end
            end)
            if not item then return cachedId end
            local ok, id = pcall(function() return item:Get("ObjectID") end)
            if ok and id then cachedId = id return id end
            ok, id = pcall(function() return item.Data and item.Data.ObjectID end)
            if ok and id then cachedId = id end
            return cachedId
        end
        local function shot(origin, part)
            local look = CFrame.lookAt(origin, part.Position)
            local lx, ly, lz = look:ToOrientation()
            local o = {[utf8.char(0)] = origin.X, [utf8.char(1)] = origin.Y, [utf8.char(2)] = origin.Z, [utf8.char(3)] = lx, [utf8.char(4)] = ly, [utf8.char(5)] = lz}
            local rel = part.CFrame:ToObjectSpace(CFrame.new(part.Position))
            local rx, ry, rz = rel:ToOrientation()
            return {[utf8.char(1)] = {[utf8.char(0)] = o, [utf8.char(1)] = o, [utf8.char(2)] = part, [utf8.char(3)] = {[utf8.char(0)] = rel.X, [utf8.char(1)] = rel.Y, [utf8.char(2)] = rel.Z, [utf8.char(3)] = rx, [utf8.char(4)] = ry, [utf8.char(5)] = rz}}}
        end
        rageConn = track(RunService.Heartbeat:Connect(function()
            if unloaded or not getgenv().Ragebot or not currentTarget or not currentTarget.Parent then return end
            resolve()
            local id = objId()
            if not useItem or not startShoot or not id then return end
            pcall(function()
                useItem:FireServer(id, startShoot, shot(currentTarget.Position + Vector3.new(0, 0.1, 0), currentTarget), nil)
            end)
        end))
    end

    track(RunService.Heartbeat:Connect(function()
        if unloaded or not getgenv().Ragebot or not currentTarget then return end
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        realCF = hrp.CFrame
        realVel = hrp.AssemblyLinearVelocity
        hrp.CFrame = CFrame.new(currentTarget.Position + Vector3.new(0, getgenv().RageDistance, 0), currentTarget.Position)
        hrp.AssemblyLinearVelocity = Vector3.zero
    end))
    RunService:BindToRenderStep("DDDD_RestoreDesync", 150, function()
        if unloaded then return end
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and realCF then
            hrp.CFrame = realCF
            if realVel then hrp.AssemblyLinearVelocity = realVel end
            realCF, realVel = nil, nil
        end
    end)
    task.spawn(function()
        while not unloaded do
            task.wait(0.03)
            if not getgenv().Ragebot then currentTarget = nil continue end
            local my = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local best, dist = nil, math.huge
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and not sameTeam(p) then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health > 0 then
                        local d = (hrp.Position - (my and my.Position or Vector3.zero)).Magnitude
                        if d < dist then dist = d best = rageHead(p.Character) end
                    end
                end
            end
            currentTarget = best
        end
    end)

    local flyVel
    local lastTrigger = 0
    track(RunService.RenderStepped:Connect(function()
        if unloaded then return end
        local needAim = getgenv().Aimbot or getgenv().TriggerBot or getgenv().DrawFOV or getgenv().BoxESP or getgenv().Fly or getgenv().Speed ~= 16
        if not needAim then
            fovCircle.Visible = false
            return
        end
        Camera = Workspace.CurrentCamera
        local center = Camera.ViewportSize / 2
        local aimPoint = getgenv().SniperMode and center or UserInputService:GetMouseLocation()
        fovCircle.Visible = getgenv().DrawFOV
        fovCircle.Position = aimPoint
        fovCircle.Radius = getgenv().FOV

        if getgenv().Aimbot and aiming and not getgenv().SniperMode then
            local best, bestD = nil, getgenv().FOV
            local mouse = UserInputService:GetMouseLocation()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and not sameTeam(p) then
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    local part = hum and hum.Health > 0 and aimPart(p.Character)
                    if part and ((not getgenv().VisibleCheck) or visible(p.Character, part)) then
                        local s, on = Camera:WorldToViewportPoint(part.Position)
                        if on then
                            local d = (Vector2.new(s.X, s.Y) - mouse).Magnitude
                            if d < bestD then bestD = d best = part end
                        end
                    end
                end
            end
            if best then
                local s = Camera:WorldToViewportPoint(best.Position)
                local smooth = math.max(1, getgenv().Smoothness)
                local dx = math.clamp(s.X - mouse.X, -300, 300) / smooth
                local dy = math.clamp(s.Y - mouse.Y, -300, 300) / smooth
                if mousemoverel then mousemoverel(dx, dy) end
            end
        end

        if getgenv().TriggerBot and mouse1click and tick() - lastTrigger > 0.05 then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and not sameTeam(p) then
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    local part = hum and hum.Health > 0 and aimPart(p.Character)
                    if part then
                        local s, on = Camera:WorldToViewportPoint(part.Position)
                        if on and (Vector2.new(s.X, s.Y) - center).Magnitude <= getgenv().TriggerSize then
                            lastTrigger = tick()
                            pcall(mouse1click)
                            break
                        end
                    end
                end
            end
        end

        for player, pack in pairs(espBoxes) do
            local square, name, hp, distT = pack.box, pack.name, pack.hp, pack.dist
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local show = getgenv().BoxESP or getgenv().NameESP or getgenv().HealthESP or getgenv().DistanceESP
            if show and hum and hum.Health > 0 then
                local head = char:FindFirstChild("Head") or char:FindFirstChild("HitboxHead")
                local foot = char:FindFirstChild("LeftFoot") or char:FindFirstChild("RightFoot") or char:FindFirstChild("Left Leg")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local top = head and (head.Position + Vector3.new(0, head.Size.Y * 0.6, 0)) or hrp.Position + Vector3.new(0, 2.8, 0)
                    local bot = foot and (foot.Position - Vector3.new(0, foot.Size.Y * 0.5, 0)) or hrp.Position - Vector3.new(0, 3, 0)
                    local a, onA = Camera:WorldToViewportPoint(top)
                    local b = Camera:WorldToViewportPoint(bot)
                    if onA and a.Z > 0 then
                        local col = getgenv().VisibleCheck and (visible(char, head or hrp) and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(255, 60, 60)) or getgenv().ESPColor
                        local h = math.max(math.abs(b.Y - a.Y), 8)
                        local w = math.max(h * 0.45, 6)
                        local x = (a.X + b.X) / 2 - w / 2
                        local y = math.min(a.Y, b.Y)
                        square.Color = col
                        square.Size = Vector2.new(w, h)
                        square.Position = Vector2.new(x, y)
                        square.Visible = getgenv().BoxESP
                        name.Text = player.Name
                        name.Color = col
                        name.Position = Vector2.new(x + w / 2, y - 16)
                        name.Visible = getgenv().NameESP
                        hp.Text = math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
                        hp.Color = Color3.fromRGB(80, 255, 120)
                        hp.Position = Vector2.new(x + w / 2, y + h + 2)
                        hp.Visible = getgenv().HealthESP
                        local my = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        distT.Text = my and (math.floor((hrp.Position - my.Position).Magnitude) .. "m") or ""
                        distT.Color = col
                        distT.Position = Vector2.new(x + w / 2, y + h + 16)
                        distT.Visible = getgenv().DistanceESP
                        local pairsBones = {
                            {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
                            {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"},
                            {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"},
                            {"LowerTorso", "LeftUpperLeg"}, {"LowerTorso", "RightUpperLeg"}
                        }
                        for i, bone in ipairs(pack.bones or {}) do
                            local aName, bName = pairsBones[i][1], pairsBones[i][2]
                            local pa, pb = char:FindFirstChild(aName), char:FindFirstChild(bName)
                            if getgenv().SkeletonESP and pa and pb then
                                local sa, onA2 = Camera:WorldToViewportPoint(pa.Position)
                                local sb = Camera:WorldToViewportPoint(pb.Position)
                                bone.From = Vector2.new(sa.X, sa.Y)
                                bone.To = Vector2.new(sb.X, sb.Y)
                                bone.Color = col
                                bone.Visible = onA2 and sa.Z > 0
                            else
                                bone.Visible = false
                            end
                        end
                        if getgenv().Chams then
                            local hl = char:FindFirstChild("DDDDCham")
                            if not hl then
                                hl = Instance.new("Highlight", char)
                                hl.Name = "DDDDCham"
                                hl.FillTransparency = 0.5
                                hl.OutlineTransparency = 0
                            end
                            hl.FillColor = col
                            hl.OutlineColor = col
                        else
                            local hl = char:FindFirstChild("DDDDCham")
                            if hl then hl:Destroy() end
                        end
                    else
                        square.Visible = false name.Visible = false hp.Visible = false distT.Visible = false
                for _, bone in ipairs(pack.bones or {}) do bone.Visible = false end
                    end
                end
            else
                square.Visible = false name.Visible = false hp.Visible = false distT.Visible = false
                for _, bone in ipairs(pack.bones or {}) do bone.Visible = false end
            end
        end

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hrp and hum then
            if getgenv().Noclip then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
            if getgenv().ClockTimeOn then
                pcall(function() game:GetService("Lighting").ClockTime = getgenv().ClockTime end)
            end
            if getgenv().RemoveVignette then
                pcall(function()
                    for _, g in ipairs(LocalPlayer.PlayerGui:GetDescendants()) do
                        if g:IsA("ImageLabel") and string.find(string.lower(g.Name), "vignette") then g.Visible = false end
                    end
                end)
            end
            if getgenv().AntiFlash then
                pcall(function()
                    game:GetService("Lighting").ExposureCompensation = 0
                    for _, v in ipairs(game:GetService("Lighting"):GetChildren()) do
                        if v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") then v.Enabled = false end
                    end
                end)
            end
            if getgenv().Fly then
                hum.PlatformStand = true
                if not flyVel or not flyVel.Parent then
                    flyVel = Instance.new("BodyVelocity")
                    flyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                    flyVel.Parent = hrp
                end
                local vel = hum.MoveDirection.Magnitude > 0 and hum.MoveDirection * getgenv().FlySpeed or Vector3.zero
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0, getgenv().FlySpeed, 0)
                elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vel -= Vector3.new(0, getgenv().FlySpeed, 0) end
                flyVel.Velocity = vel
            else
                hum.PlatformStand = false
                if flyVel then flyVel:Destroy() flyVel = nil end
            end
        end
    end))

    RunService:BindToRenderStep("DDDD_SniperAim", Enum.RenderPriority.Camera.Value + 1, function()
        if unloaded or not getgenv().SniperMode then return end
        Camera = Workspace.CurrentCamera
        if not Camera then return end
        local center = Camera.ViewportSize / 2
        local best, bestD = nil, getgenv().FOV
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and not sameTeam(p) then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local part = hum and hum.Health > 0 and aimPart(p.Character)
                if part and ((not getgenv().VisibleCheck) or visible(p.Character, part)) then
                    local s, on = Camera:WorldToViewportPoint(part.Position)
                    if on and s.Z > 0 then
                        local d = (Vector2.new(s.X, s.Y) - center).Magnitude
                        if d < bestD then bestD = d best = part end
                    end
                end
            end
        end
        if best then
            local mouse = UserInputService:GetMouseLocation()
            local screen = Camera:WorldToViewportPoint(best.Position)
            local smooth = math.max(1, getgenv().Smoothness)
            if mousemoverel then
                mousemoverel((screen.X - mouse.X) / smooth, (screen.Y - mouse.Y) / smooth)
            end
            local goal = CFrame.new(Camera.CFrame.Position, best.Position)
            Camera.CFrame = smooth <= 1 and goal or Camera.CFrame:Lerp(goal, math.clamp(1 / smooth, 0.08, 1))
        end
    end)

    track(task.spawn(function()
        while not unloaded do
            task.wait(8)
            if getgenv().AutoQueue then
                pcall(function()
                    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
                    local match = remotes and (remotes:FindFirstChild("Matchmaking") or remotes:FindFirstChild("Duels") or remotes)
                    local join = match and (match:FindFirstChild("JoinQueue") or match:FindFirstChild("Join"))
                    if join then join:FireServer() end
                end)
            end
        end
    end))
    track(UserInputService.JumpRequest:Connect(function()
        if unloaded or not getgenv().InfiniteJump then return end
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState("Jumping") end
    end))

    local C0, C1, C2, C3, C4, C5 = utf8.char(0), utf8.char(1), utf8.char(2), utf8.char(3), utf8.char(4), utf8.char(5)
    local silentCache, silentAt, scanAt = {}, 0, 0
    local silentPos, silentPart = nil, nil
    local sParams = RaycastParams.new()
    sParams.FilterType = Enum.RaycastFilterType.Exclude
    sParams.IgnoreWater = true
    local function bodyPart(char)
        local best, bestSize = nil, 0
        for _, d in ipairs(char:GetDescendants()) do
            if d:IsA("BasePart") and (d.Name == "HitboxBody" or d.Name == "HitboxBodySmall" or (string.find(d.Name, "Hitbox") and not string.find(d.Name, "Head"))) then
                local size = d.Size.Magnitude
                if size > bestSize then
                    best, bestSize = d, size
                end
            end
        end
        if best then return best end
        return char:FindFirstChild("UpperTorso")
            or char:FindFirstChild("Torso")
            or char:FindFirstChild("LowerTorso")
            or char:FindFirstChild("HumanoidRootPart")
    end
    local function headPart(char)
        return char:FindFirstChild("HitboxHead")
            or char:FindFirstChild("HitboxHeadSmall")
            or char:FindFirstChild("Head")
    end
    local function rolledAim(char)
        local head = headPart(char)
        local body = bodyPart(char)
        local headPct = math.clamp(tonumber(getgenv().SilentHead) or 50, 0, 100)
        if math.random(1, 100) > (getgenv().HitChance or 100) then
            return nil, nil
        end
        local useHead = headPct >= 100 or (headPct > 0 and math.random(1, 100) <= headPct)
        if useHead and head then
            return head, head.Position
        end
        if body then
            return body, body.Position
        end
        return head, head and head.Position
    end
    local function scanSilent()
        if not getgenv().SilentAim then
            silentPos, silentPart, silentChar = nil, nil, nil
            silentCircle.Visible = false
            return
        end
        if tick() - scanAt < 0.05 then return end
        scanAt = tick()
        if tick() - silentAt > 1 then
            silentAt = tick()
            table.clear(silentCache)
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and not sameTeam(p) then table.insert(silentCache, p.Character) end
            end
        end
        Camera = Workspace.CurrentCamera
        local mouse = UserInputService:GetMouseLocation()
        local camPos, camLook = Camera.CFrame.Position, Camera.CFrame.LookVector
        local bestPos, bestPart, bestChar, bestD = nil, nil, nil, getgenv().FOV
        for _, model in ipairs(silentCache) do
            local hum = model:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local part = headPart(model) or bodyPart(model)
                if part then
                    local aim = part.Position
                    local s, on = Camera:WorldToViewportPoint(aim)
                    if on then
                        local d = (Vector2.new(s.X, s.Y) - mouse).Magnitude
                        if d < bestD then
                            bestD, bestPos, bestPart, bestChar = d, aim, part, model
                        end
                    end
                end
            end
        end
        silentChar = bestChar
        silentPart = bestPart
        silentPos = bestPos
        silentCircle.Position = mouse
        silentCircle.Radius = getgenv().FOV
        silentCircle.Visible = getgenv().DrawSilentPOV == true
        silentCircle.Color = bestPos and Color3.fromRGB(255, 70, 70) or Color3.fromRGB(125, 170, 200)
    end
    track(RunService.RenderStepped:Connect(function()
        if not unloaded then scanSilent() end
    end))

    local silentHooked = false
    local function installSilent()
        if silentHooked then return end
        silentHooked = true
        local folder = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter")
        local updateState = folder:WaitForChild("UpdateState")
        local updateCam = folder:WaitForChild("UpdateCameraRotation")
        local Utility
        pcall(function() Utility = require(ReplicatedStorage.Modules.Utility) end)
        local function enc(cf)
            local rx, ry, rz = cf:ToOrientation()
            return {[C0] = cf.X, [C1] = cf.Y, [C2] = cf.Z, [C3] = rx, [C4] = ry, [C5] = rz}
        end
        local function encRot(target)
            local rx, ry = CFrame.new(Camera.CFrame.Position, target):ToOrientation()
            local ok, out = pcall(function() return Utility:EncodeCameraRotation(Vector2.new(rx, ry)) end)
            if ok and out then return out end
            local function b(v) return utf8.char(math.clamp(math.floor((v % 6.2831853) / 6.2831853 * 256 + 0.5), 0, 255)) end
            return b(rx) .. b(ry)
        end
        local function hookRemote(remote, fn)
            if not hookfunction then return end
            local old
            old = hookfunction(remote.FireServer, function(self, ...)
                if not getgenv().SilentAim then
                    return old(self, ...)
                end
                local packed = table.pack(pcall(fn, old, self, ...))
                if not packed[1] then
                    return old(self, ...)
                end
                return table.unpack(packed, 2, packed.n)
            end)
        end
        hookRemote(updateState, function(call, self, enumId, a1, a2, ...)
            local part, aim
            if silentChar then
                part, aim = rolledAim(silentChar)
            else
                part, aim = silentPart, silentPos
            end
            if type(a2) == "table" and part and aim then
                local ok, pcf = pcall(function() return part.CFrame end)
                if ok then
                    local cloned = table.clone(a2)
                    local noff = enc(pcf:Inverse() * CFrame.new(aim))
                    local wrote = false
                    for k, e in pairs(cloned) do
                        if type(e) == "table" and e[C2] ~= nil then
                            local n = table.clone(e)
                            n[C2] = part
                            n[C3] = noff
                            cloned[k] = n
                            wrote = true
                        end
                    end
                    if wrote then
                        getgenv().__SA_Shot = {Pos = aim, T = tick()}
                        pcall(function()
                            local remote = ReplicatedStorage.Remotes.Replication.Fighter.UpdateCameraRotation
                            local Utility = require(ReplicatedStorage.Modules.Utility)
                            local rx, ry = CFrame.new(Camera.CFrame.Position, aim):ToOrientation()
                            remote:FireServer(Utility:EncodeCameraRotation(Vector2.new(rx, ry)))
                        end)
                        return call(self, enumId, a1, cloned, ...)
                    end
                end
            end
            return call(self, enumId, a1, a2, ...)
        end)
        hookRemote(updateCam, function(call, self, rot, ...)
            local shot = getgenv().__SA_Shot
            if rot ~= nil and shot and silentPos and tick() - shot.T < 0.2 then
                rot = encRot(silentPos)
            end
            return call(self, rot, ...)
        end)
    end
    _G.DDDD_InstallSilent = installSilent

    local rapidBackup
    _G.DDDD_SetRapidFire = function(on)
        if game.GameId ~= 6035872082 then return end
        local ok, Items = pcall(function() return require(ReplicatedStorage.Modules.ItemLibrary).Items end)
        if not ok or type(Items) ~= "table" then return end
        local skip = {Sniper = true, Crossbow = true, Bow = true, RPG = true}
        if on then
            rapidBackup = rapidBackup or {}
            for name, data in pairs(Items) do
                if type(data) == "table" then
                    rapidBackup[name] = rapidBackup[name] or {
                        ShootSpread = data.ShootSpread, ShootAccuracy = data.ShootAccuracy, ShootRecoil = data.ShootRecoil,
                        ShootCooldown = data.ShootCooldown, ShootBurstCooldown = data.ShootBurstCooldown,
                        AttackCooldown = data.AttackCooldown, SwingCooldown = data.SwingCooldown, MeleeCooldown = data.MeleeCooldown,
                        Cooldown = data.Cooldown, RecoveryTime = data.RecoveryTime, ResetTime = data.ResetTime
                    }
                    if not skip[name] then
                        if getgenv().NoSpread or getgenv().RapidFire or getgenv().FullAuto then
                            if data.ShootSpread then data.ShootSpread = 0 end
                            if data.ShootAccuracy then data.ShootAccuracy = 0 end
                            if data.ShootRecoil then data.ShootRecoil = 0 end
                        end
                        if getgenv().RapidFire or getgenv().FullAuto then
                            if data.ShootCooldown then data.ShootCooldown = 0.001 end
                            if data.ShootBurstCooldown then data.ShootBurstCooldown = 0.001 end
                        end
                    end
                    if data.AttackCooldown then data.AttackCooldown = 0.001 end
                    if data.SwingCooldown then data.SwingCooldown = 0.001 end
                    if data.MeleeCooldown then data.MeleeCooldown = 0.001 end
                end
            end
        elseif rapidBackup then
            for name, saved in pairs(rapidBackup) do
                local data = Items[name]
                if type(data) == "table" then
                    for k, v in pairs(saved) do data[k] = v end
                end
            end
        end
    end

    local crossGui = Instance.new("ScreenGui")
    crossGui.Name = "NeonCustomCrosshairSuite"
    crossGui.ResetOnSpawn = false
    crossGui.IgnoreGuiInset = true
    crossGui.DisplayOrder = 1000
    crossGui.Enabled = false
    crossGui.Parent = CoreGui
    local cross = Instance.new("Frame", crossGui)
    cross.Size = UDim2.new(0, 100, 0, 100)
    cross.Position = UDim2.new(0.5, 0, 0.5, 0)
    cross.AnchorPoint = Vector2.new(0.5, 0.5)
    cross.BackgroundTransparency = 1
    local arms = {}
    for _, def in ipairs({
        {n = "Top", s = UDim2.new(0, 4, 0, 14), a = Vector2.new(0.5, 1)},
        {n = "Bottom", s = UDim2.new(0, 4, 0, 14), a = Vector2.new(0.5, 0)},
        {n = "Left", s = UDim2.new(0, 14, 0, 4), a = Vector2.new(1, 0.5)},
        {n = "Right", s = UDim2.new(0, 14, 0, 4), a = Vector2.new(0, 0.5)},
    }) do
        local arm = Instance.new("Frame", cross)
        arm.Size = def.s
        arm.AnchorPoint = def.a
        arm.BorderSizePixel = 0
        arm.BackgroundColor3 = accentHot
        stroke(arm, accentHot, 2)
        arms[#arms + 1] = {i = arm, n = def.n}
    end
    local spinT = 0
    track(RunService.RenderStepped:Connect(function(dt)
        if unloaded then return end
        crossGui.Enabled = getgenv().SpinCrosshair == true
        if not getgenv().SpinCrosshair then return end
        spinT += dt
        local gap = math.sin(spinT * 3.5) * 6 + 10
        cross.Rotation = spinT * 45 % 360
        local col = Color3.fromHSV(spinT * 0.15 % 1, 0.8, 1)
        for _, arm in ipairs(arms) do
            arm.i.BackgroundColor3 = col
            if arm.n == "Top" then arm.i.Position = UDim2.new(0.5, 0, 0.5, -gap)
            elseif arm.n == "Bottom" then arm.i.Position = UDim2.new(0.5, 0, 0.5, gap)
            elseif arm.n == "Left" then arm.i.Position = UDim2.new(0.5, -gap, 0.5, 0)
            else arm.i.Position = UDim2.new(0.5, gap, 0.5, 0) end
        end
    end))

    _G.DDDD_UnlockAll = function()
        if _G.DDDD_UnlockReady then
            if _G.DDDD_LoadUnlockConfig then _G.DDDD_LoadUnlockConfig() end
            return
        end
        _G.DDDD_UnlockReady = true
        local HttpService = game:GetService("HttpService")
        local EnumLibrary = require(ReplicatedStorage.Modules:WaitForChild("EnumLibrary", 10))
        if EnumLibrary then pcall(function() EnumLibrary:WaitForEnumBuilder() end) end
        local CosmeticLibrary = require(ReplicatedStorage.Modules:WaitForChild("CosmeticLibrary", 10))
        local ItemLibrary = require(ReplicatedStorage.Modules:WaitForChild("ItemLibrary", 10))
        local DataController = require(LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlayerDataController", 10))
        local equipped, favorites = {}, {}
        local allowed = {Skin = true, Charm = true, Dance = true, Emote = true, Wrap = true, Wrapping = true}
        local function allowedName(name, kind)
            if type(name) ~= "string" or name:find("MISSING_") then return false end
            local c = CosmeticLibrary.Cosmetics[name]
            if c and c.Type == "Finisher" then return false end
            if kind and allowed[kind] then return true end
            return c and allowed[c.Type] or false
        end
        local function cloneCosmetic(name, kind, options)
            local base = CosmeticLibrary.Cosmetics[name]
            if not base then return nil end
            local data = {}
            for k, v in pairs(base) do data[k] = v end
            data.Name = name
            data.Type = data.Type or kind
            data.Seed = math.random(1, 1000000)
            if EnumLibrary then
                local ok, id = pcall(function() return EnumLibrary:ToEnum(name) end)
                if ok and id then data.Enum = id data.ObjectID = data.ObjectID or id end
            end
            if options and options.inverted ~= nil then data.Inverted = options.inverted end
            return data
        end
        local saveFile = "unlockall/config.json"
        local function saveConfig()
            if not writefile then return end
            pcall(function()
                local config = {equipped = {}, favorites = favorites}
                for weapon, list in pairs(equipped) do
                    config.equipped[weapon] = {}
                    for kind, data in pairs(list) do
                        if data and data.Name then
                            config.equipped[weapon][kind] = {name = data.Name, seed = data.Seed, inverted = data.Inverted}
                        end
                    end
                end
                if makefolder then makefolder("unlockall") end
                writefile(saveFile, HttpService:JSONEncode(config))
            end)
        end
        local function loadConfig()
            if not (readfile and isfile and isfile(saveFile)) then return end
            pcall(function()
                local config = HttpService:JSONDecode(readfile(saveFile))
                for weapon, list in pairs(config.equipped or {}) do
                    equipped[weapon] = equipped[weapon] or {}
                    for kind, data in pairs(list) do
                        local cloned = cloneCosmetic(data.name, kind, {inverted = data.inverted})
                        if cloned then cloned.Seed = data.seed equipped[weapon][kind] = cloned end
                    end
                end
                favorites = config.favorites or favorites
            end)
        end
        _G.DDDD_LoadUnlockConfig = loadConfig
        loadConfig()
        local originalOwns = CosmeticLibrary.OwnsCosmetic
        local function own(...)
            local args = {...}
            for i = 1, #args do
                if allowedName(args[i]) then return true end
            end
            if originalOwns then
                local ok, result = pcall(originalOwns, ...)
                if ok then return result end
            end
            return false
        end
        CosmeticLibrary.OwnsCosmetic = own
        CosmeticLibrary.OwnsCosmeticNormally = own
        CosmeticLibrary.OwnsCosmeticUniversally = own
        CosmeticLibrary.OwnsCosmeticForWeapon = own
        local originalGet = DataController.Get
        DataController.Get = function(self, key)
            local data = originalGet(self, key)
            if key ~= "CosmeticInventory" then return data end
            local proxy = {}
            if type(data) == "table" then
                for k, v in pairs(data) do proxy[k] = v end
            end
            for name in pairs(CosmeticLibrary.Cosmetics) do
                if allowedName(name) then proxy[name] = proxy[name] or true end
            end
            return setmetatable(proxy, {__index = function(_, k)
                if allowedName(k) then return true end
                return nil
            end})
        end
        local originalWeapon = DataController.GetWeaponData
        DataController.GetWeaponData = function(self, weaponName)
            local data = originalWeapon(self, weaponName)
            if not data then return nil end
            local merged = {}
            for k, v in pairs(data) do merged[k] = v end
            merged.Name = weaponName
            if equipped[weaponName] then
                for kind, cosmetic in pairs(equipped[weaponName]) do merged[kind] = cosmetic end
            end
            return merged
        end
        if hookmetamethod and not _G.DDDD_UnlockHooked then
            _G.DDDD_UnlockHooked = true
            local equipRemote = ReplicatedStorage.Remotes.Data:FindFirstChild("EquipCosmetic")
            local favoriteRemote = ReplicatedStorage.Remotes.Data:FindFirstChild("FavoriteCosmetic")
            local old
            old = hookmetamethod(game, "__namecall", function(self, ...)
                if getnamecallmethod() ~= "FireServer" then return old(self, ...) end
                local a = {...}
                if self == equipRemote and (allowed[a[2]] or allowedName(a[3], a[2])) then
                    equipped[a[1]] = equipped[a[1]] or {}
                    if not a[3] or a[3] == "None" then
                        equipped[a[1]][a[2]] = nil
                    else
                        equipped[a[1]][a[2]] = cloneCosmetic(a[3], a[2], {inverted = a[4] and a[4].IsInverted})
                    end
                    task.defer(function()
                        pcall(function() DataController.CurrentData:Replicate("WeaponInventory") end)
                        saveConfig()
                    end)
                    return
                end
                return old(self, ...)
            end)
        end
        pcall(function()
            local ClientItem = require(LocalPlayer.PlayerScripts.Modules.ClientReplicatedClasses.ClientFighter.ClientItem)
            if ClientItem and ClientItem._CreateViewModel and not _G.DDDD_ViewHooked then
                _G.DDDD_ViewHooked = true
                local oldCreate = ClientItem._CreateViewModel
                ClientItem._CreateViewModel = function(self, ref)
                    local list = equipped[self.Name]
                    if self.ClientFighter and self.ClientFighter.Player == LocalPlayer and list and ref then
                        local dataKey = self:ToEnum("Data")
                        for _, kind in ipairs({"Skin", "Charm", "Wrap"}) do
                            if list[kind] then
                                if ref[dataKey] then ref[dataKey][self:ToEnum(kind)] = list[kind]
                                elseif ref.Data then ref.Data[kind] = list[kind] end
                            end
                        end
                    end
                    return oldCreate(self, ref)
                end
            end
        end)
        pcall(function() DataController.CurrentData:Replicate("CosmeticInventory") end)
        pcall(function() DataController.CurrentData:Replicate("WeaponInventory") end)
        saveConfig()
    end

    _G.DDDD_Unload = function()
        if unloaded then return end
        unloaded = true
        getgenv().Aimbot = false
        getgenv().SniperMode = false
        getgenv().SilentAim = false
        getgenv().Ragebot = false
        getgenv().Fly = false
        getgenv().SpinCrosshair = false
        getgenv().RapidFire = false
        pcall(function() if _G.DDDD_SetRapidFire then _G.DDDD_SetRapidFire(false) end end)
        if rageConn then pcall(function() rageConn:Disconnect() end) end
        for _, c in ipairs(connections) do pcall(function() c:Disconnect() end) end
        pcall(function() RunService:UnbindFromRenderStep("DDDD_RestoreDesync") end)
        pcall(function() RunService:UnbindFromRenderStep("DDDD_SniperAim") end)
        pcall(function() fovCircle:Destroy() end)
        pcall(function() silentCircle:Destroy() end)
        for _, pack in pairs(espBoxes) do
            for _, d in pairs(pack) do pcall(function() d:Destroy() end) end
        end
        pcall(function() if flyVel then flyVel:Destroy() end end)
        pcall(function()
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = false hum.WalkSpeed = 16 end
        end)
        pcall(function() ScreenGui:Destroy() end)
        pcall(function() crossGui:Destroy() end)
        _G.DDDD_Unload = nil
        _G.DDDD_StartRagebot = nil
    end

    Main.Visible = true
    print("[DDDD HUB VIP] loaded")
end

local function tryKey()
    if keyClosed then return end
    if keyBox.Text == KEY then
        saveKey()
        keyStatus.TextColor3 = accentHot
        keyStatus.Text = "Accepted"
        TweenService:Create(keyFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 300, 0, 150)}):Play()
        task.delay(0.18, boot)
    else
        keyStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
        keyStatus.Text = "Invalid key"
        local base = keyFrame.Position
        TweenService:Create(keyFrame, TweenInfo.new(0.06), {Position = base + UDim2.new(0, 8, 0, 0)}):Play()
        task.delay(0.06, function()
            TweenService:Create(keyFrame, TweenInfo.new(0.06), {Position = base}):Play()
        end)
    end
end
keyButton.MouseButton1Click:Connect(tryKey)
keyBox.FocusLost:Connect(function(enter)
    if enter then tryKey() end
end)

if savedKeyOk() then
    keyFrame.Visible = false
    task.defer(boot)
end
