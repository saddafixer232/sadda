local KeyGuardLibrary = loadstring(game:HttpGet("https://cdn.keyguardian.org/library/v1.0.0.lua"))()
local trueData = "8bc9bffd0eb146898a0f45fc24f04d82"
local falseData = "dde561d7284c452381979bf549432252"

KeyGuardLibrary.Set({
	publicToken = "c7adfac41a5d4ff1a9ff94ef8f1b54f9",
	privateToken = "d36890846179461da3a2108a32a4e8d2",
	trueData = trueData,
	falseData = falseData,
})

local key = "test"

getkey = KeyGuardLibrary.getLink()

response = KeyGuardLibrary.validateDefaultKey(key)


if response == trueData then
	print("Key is valid")
    type_custom = typeof
if not LPH_OBFUSCATED then
	LPH_JIT = function(...)
		return ...;
	end;
	LPH_JIT_MAX = function(...)
		return ...;
	end;
	LPH_NO_VIRTUALIZE = function(...)
		return ...;
	end;
	LPH_NO_UPVALUES = function(f)
		return (function(...)
			return f(...);
		end);
	end;
	LPH_ENCSTR = function(...)
		return ...;
	end;
	LPH_ENCNUM = function(...)
		return ...;
	end;
	LPH_ENCFUNC = function(func, key1, key2)
		if key1 ~= key2 then return print("LPH_ENCFUNC mismatch") end
		return func
	end
	LPH_CRASH = function()
		return print(debug.traceback());
	end;
end
allowedGameIds = {
    [7333407059] = true,
    [4777055365] = true,
}

if not allowedGameIds[game.GameId] then
    warn("This game is not support")
    return
end


local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

local MainParts = {"Head", "HumanoidRootPart"}

Window = Library:CreateWindow({
    Title = 'VeryUp                                      t.me/+tb37OkrY27YwZmY6',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2,
    Theme = 'Mint',
})

local isMobile = UserInputService.TouchEnabled

if isMobile then
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MobileControlGui"
    screenGui.DisplayOrder = 999 
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local openButton = Instance.new("TextButton")
    openButton.Name = "OpenCloseUIButton"
    openButton.Size = UDim2.new(0, 120, 0, 50)
    openButton.Position = UDim2.new(1, -130, 0.5, -25) 
    openButton.AnchorPoint = Vector2.new(0, 0)
    openButton.BackgroundColor3 = Color3.fromRGB(40, 160, 220)
    openButton.BackgroundTransparency = 0.13
    openButton.Text = "Close UI"
    openButton.TextSize = 22
    openButton.TextColor3 = Color3.new(1,1,1)
    openButton.Parent = screenGui

    local uiVisible = true

    openButton.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        if Window and Window.SetVisible then
            Window:SetVisible(uiVisible)
        elseif Window and Window.Visible ~= nil then
            Window.Visible = uiVisible
        end
        if uiVisible then
            openButton.Text = "Close UI"
        else
            openButton.Text = "Open UI"
        end
    end)
end

Tabs = {
    Combat = Window:AddTab('Combat'),
    Visual = Window:AddTab('Visual'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local SilentAimSettings = {
    Enabled = false,
    TargetPart = "HumanoidRootPart",
    UseFOV = true,
    FOVRadius = 300,
    FOVColor = Color3.fromRGB(255, 255, 255),
    FOVColorNoTarget = Color3.fromRGB(255, 255, 255),
    FOVColorOnTarget = Color3.fromRGB(255, 255, 255),
    FOVFill = false,
    FOVFillColor = Color3.fromRGB(255,255,255),
    FOVFillTrans = 0.1,
    Snapline = true,
    SnaplineColor = Color3.fromRGB(255, 255, 255),
    SnaplineThickness = 2,
}

CombatBox = Tabs.Combat:AddLeftGroupbox('Silent Aim')

CombatBox:AddToggle('SA_Enabled', {Text='Silent Aim Enabled', Default=false})
    :AddKeyPicker('SA_Enabled_Key', {
        Default = 'P',
        SyncToggleState = true,
        Mode = 'Toggle',
        Text = 'Silent Aim Key',
        NoUI = false
    })
    :OnChanged(function(v)
        SilentAimSettings.Enabled = v
    end)

task.spawn(function()
    while true do
        task.wait(0.03)
        local shouldEnable = Options.SA_Enabled_Key:GetState()
        if shouldEnable ~= Toggles.SA_Enabled.Value then
            Toggles.SA_Enabled:SetValue(shouldEnable)
        end
        if Library.Unloaded then break end
    end
end)

CombatBox:AddToggle('MagicBullets', {
    Text = 'Magic Bullets BETA',
    Default = false,
    Tooltip = "doesn't work inside buildings",
})
:AddKeyPicker('MagicBulletsKey', {
    Default = 'M',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Magic Bullets Key',
    NoUI = false
})
:OnChanged(function(v)

end)

task.spawn(function()
    while true do
        task.wait(0.03)
        local shouldEnable = Options.MagicBulletsKey:GetState()
        if shouldEnable ~= Toggles.MagicBullets.Value then
            Toggles.MagicBullets:SetValue(shouldEnable)
        end
        if Library.Unloaded then break end
    end
end)

CombatBox:AddSlider('MagicBulletsHeight', {
    Text = 'Magic Bullets Arc Height',
    Min = 200,
    Max = 1000,
    Default = 1000,
    Rounding = 0,
})

CombatBox:AddDropdown('SA_TargetPart', {
    Text = 'Target Part',
    Values = MainParts,
    Default = 2,
    Multi = false
}):OnChanged(function(val) SilentAimSettings.TargetPart = val end)

CombatBox:AddToggle('SA_UseFOV', {Text = 'Use FOV', Default = true})
    :AddColorPicker('SA_FOVColor', {
        Default = SilentAimSettings.FOVColor,
        Title = 'FOV Color (current)',
        Callback = function(val) SilentAimSettings.FOVColor = val end
    })
    :OnChanged(function(v) SilentAimSettings.UseFOV = v end)

Options.SA_FOVColor:OnChanged(function(val)
    SilentAimSettings.FOVColor = val
end)

CombatBox:AddLabel('FOV Color (No Target)'):AddColorPicker('SA_FOVColorNoTarget', {
    Default = SilentAimSettings.FOVColorNoTarget,
    Title = 'FOV Color (No Target)',
    Callback = function(val) SilentAimSettings.FOVColorNoTarget = val end
})
Options.SA_FOVColorNoTarget:OnChanged(function(val)
    SilentAimSettings.FOVColorNoTarget = val
end)

CombatBox:AddLabel('FOV Color (On Target)'):AddColorPicker('SA_FOVColorOnTarget', {
    Default = SilentAimSettings.FOVColorOnTarget,
    Title = 'FOV Color (On Target)',
    Callback = function(val) SilentAimSettings.FOVColorOnTarget = val end
})
Options.SA_FOVColorOnTarget:OnChanged(function(val)
    SilentAimSettings.FOVColorOnTarget = val
end)

CombatBox:AddSlider('SA_FOV', {
    Text='FOV',
    Min=50,
    Max=1200,
    Default=300,
    Rounding=0
}):OnChanged(function(v) SilentAimSettings.FOVRadius=v end)

CombatBox:AddToggle('SA_FOVFill', {Text = 'FOV Fill', Default = false})
    :AddColorPicker('SA_FOVFillColor', {
        Default = SilentAimSettings.FOVFillColor,
        Title = 'FOV Fill Color',
        Callback = function(val) SilentAimSettings.FOVFillColor = val end
    })
    :OnChanged(function(v) SilentAimSettings.FOVFill = v end)
Options.SA_FOVFillColor:OnChanged(function(val)
    SilentAimSettings.FOVFillColor = val
end)
CombatBox:AddSlider('SA_FOVFillTrans', {
    Text = 'FOV Fill Transparency',
    Min = 0,
    Max = 100,
    Default = 10,
    Rounding = 0
}):OnChanged(function(v) SilentAimSettings.FOVFillTrans = v/100 end)

CombatBox:AddToggle('SA_Snapline', {Text='Snapline', Default=true})
    :AddColorPicker('SA_SnaplineColor', {
        Default = SilentAimSettings.SnaplineColor,
        Title = 'Snapline Color',
        Callback = function(val) SilentAimSettings.SnaplineColor = val end
    })
    :OnChanged(function(v) SilentAimSettings.Snapline=v end)
Options.SA_SnaplineColor:OnChanged(function(val)
    SilentAimSettings.SnaplineColor = val
end)
CombatBox:AddSlider('SA_SnaplineThickness', {
    Text='Snapline Thickness',
    Min=1,
    Max=5,
    Default=2,
    Rounding=1
}):OnChanged(function(v) SilentAimSettings.SnaplineThickness=v end)
CombatOtherBox = Tabs.Combat:AddRightGroupbox('Other')
noRecoilEnabled = false
recoilModule = nil

function setupNoRecoil(enable)
    if enable then
        if not recoilModule then
            pcall(function()
                recoilModule = require(ReplicatedStorage:WaitForChild("Gun"):WaitForChild("Scripts"):WaitForChild("RecoilHandler"))
            end)
        end
        if recoilModule then
            if not recoilModule._original_nextStep then
                recoilModule._original_nextStep = recoilModule.nextStep
            end
            if not recoilModule._original_setRecoilMultiplier then
                recoilModule._original_setRecoilMultiplier = recoilModule.setRecoilMultiplier
            end
            recoilModule.nextStep = function() end
            recoilModule.setRecoilMultiplier = function() end
            noRecoilEnabled = true
        else
            warn("recoilModule not found!")
        end
    else
        if recoilModule then
            if recoilModule._original_nextStep then
                recoilModule.nextStep = recoilModule._original_nextStep
                recoilModule._original_nextStep = nil
            end
            if recoilModule._original_setRecoilMultiplier then
                recoilModule.setRecoilMultiplier = recoilModule._original_setRecoilMultiplier
                recoilModule._original_setRecoilMultiplier = nil
            end
            noRecoilEnabled = false
        end
    end
end

CombatOtherBox:AddToggle('NoRecoil', {Text='No Recoil', Default=false}):OnChanged(function(v)
    setupNoRecoil(v)
end)
noSpreadEnabled = false
spreadPatched = false
spreadOldFuncs = {}

function setupNoSpread(enable)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local utils = ReplicatedStorage:FindFirstChild("Utils")
    if utils and utils:IsA("ModuleScript") then
        local s, mod = pcall(require, utils)
        if s and type(mod) == "table" and mod.applySpreadToDirection then
            if enable then
                if not spreadPatched then
                    spreadOldFuncs.applySpreadToDirection = mod.applySpreadToDirection
                    mod.applySpreadToDirection = function(direction, ...)
                        return direction
                    end
                    spreadPatched = true
                end
            else
                if spreadPatched and spreadOldFuncs.applySpreadToDirection then
                    mod.applySpreadToDirection = spreadOldFuncs.applySpreadToDirection
                    spreadPatched = false
                end
            end
        end
    end

    local gunClient = ReplicatedStorage:FindFirstChild("Gun") and ReplicatedStorage.Gun:FindFirstChild("Scripts") and ReplicatedStorage.Gun.Scripts:FindFirstChild("GunClient")
    if gunClient and gunClient:IsA("ModuleScript") then
        local s, mod = pcall(require, gunClient)
        if s and type(mod) == "table" and mod.updateSpreadMult then
            if enable then
                if not spreadOldFuncs.updateSpreadMult then
                    spreadOldFuncs.updateSpreadMult = mod.updateSpreadMult
                end
                mod.updateSpreadMult = function(...) return 0 end
            else
                if spreadOldFuncs.updateSpreadMult then
                    mod.updateSpreadMult = spreadOldFuncs.updateSpreadMult
                end
            end
        end
    end

    noSpreadEnabled = enable
end

CombatOtherBox:AddToggle('NoSpread', {Text = 'No Spread', Default = false}):OnChanged(function(v)
    setupNoSpread(v)
end)


jumpShootPatched = false
patchedModules = {}
originalCanFires = {}

local function getCurrentAmmo()
    local plr = game:GetService("Players").LocalPlayer
    local gui = plr:FindFirstChild("PlayerGui")
    if not gui then return nil end
    local gunGui = gui:FindFirstChild("GunGui")
    if not gunGui then return nil end
    local frame = gunGui:FindFirstChild("Frame")
    if not frame then return nil end
    local ammoLbl = frame:FindFirstChild("Ammo")
    if not ammoLbl or not ammoLbl:IsA("TextLabel") then return nil end
    local txt = ammoLbl.Text
    local current = tostring(txt):match("^%d+")
    return tonumber(current)
end

local function patchAllCanFire(enable)
    if enable then
        if not jumpShootPatched then
            patchedModules = {}
            originalCanFires = {}
            for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
                if obj:IsA("ModuleScript") and (obj.Name:find("Client") or obj.Name:find("Gun")) then
                    local ok, mod = pcall(require, obj)
                    if ok and type(mod) == "table" and type(mod.canFire) == "function" then
                        if not originalCanFires[obj] then
                            originalCanFires[obj] = mod.canFire
                        end
                        mod.canFire = function(self, ...)
                            local ammo = getCurrentAmmo()
                            return ammo ~= nil and ammo > 0
                        end
                        table.insert(patchedModules, obj:GetFullName())
                    end
                end
            end
            jumpShootPatched = true
        end
    else
        if jumpShootPatched then
            for obj, oldFunc in pairs(originalCanFires) do
                local ok, mod = pcall(require, obj)
                if ok and type(mod) == "table" and type(oldFunc) == "function" then
                    mod.canFire = oldFunc
                end
            end
            patchedModules = {}
            originalCanFires = {}
            jumpShootPatched = false
        end
    end
end

CombatOtherBox:AddToggle('JumpShoot', {
    Text = 'Jump Shoot & Water Shoot',
    Default = false,
})
:OnChanged(function(v)
    patchAllCanFire(v)
end)
Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer

rapidFireEnabled = false
rapidFireSliderValue = 0.5
currentTool = nil
currentGunTable = nil
currentGunOld = nil

function sliderToDelay(val)
    return math.max(0.005, 0.1 * math.pow(0.5, val))
end

function getGunTableForTool(tool)
    for _,v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "Tool") == tool and (rawget(v, "FireDelay") or rawget(v, "INIT_FIRE_DELAY")) then
            return v
        end
    end
    return nil
end

rapidFireEnabled = false
rapidFireSliderValue = 0.5
currentTool = nil
currentGunTable = nil
currentGunOld = nil

function sliderToDelay(val)
    return math.max(0.005, 0.1 * math.pow(0.5, val))
end

function getGunTableForTool(tool)
    if not tool then return nil end
    for _,v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "Tool") == tool then
            -- Только если есть FireDelay или INIT_FIRE_DELAY!
            if rawget(v, "FireDelay") or rawget(v, "INIT_FIRE_DELAY") then
                return v
            end
        end
    end
    return nil
end

function applyRapidFireToTool(tool, delay)
    local gun = getGunTableForTool(tool)
    if not gun then return false end

    -- Если меняем пушку — откатить старую!
    if currentGunTable and currentGunTable ~= gun then
        if currentGunOld then
            if rawget(currentGunTable, "FireDelay") and currentGunOld.FireDelay then
                currentGunTable.FireDelay = currentGunOld.FireDelay
            end
            if rawget(currentGunTable, "INIT_FIRE_DELAY") and currentGunOld.INIT_FIRE_DELAY then
                currentGunTable.INIT_FIRE_DELAY = currentGunOld.INIT_FIRE_DELAY
            end
        end
        currentGunOld = nil
    end
    -- Только если ещё не патчили
    if not currentGunOld then
        currentGunOld = {
            FireDelay = rawget(gun, "FireDelay") and gun.FireDelay or nil,
            INIT_FIRE_DELAY = rawget(gun, "INIT_FIRE_DELAY") and gun.INIT_FIRE_DELAY or nil
        }
    end
    if rawget(gun, "FireDelay") then
        gun.FireDelay = delay
    end
    if rawget(gun, "INIT_FIRE_DELAY") then
        gun.INIT_FIRE_DELAY = delay
    end
    currentGunTable = gun
    return true
end

function restoreRapidFireOnCurrent()
    if currentGunTable and currentGunOld then
        if rawget(currentGunTable, "FireDelay") and currentGunOld.FireDelay then
            currentGunTable.FireDelay = currentGunOld.FireDelay
        end
        if rawget(currentGunTable, "INIT_FIRE_DELAY") and currentGunOld.INIT_FIRE_DELAY then
            currentGunTable.INIT_FIRE_DELAY = currentGunOld.INIT_FIRE_DELAY
        end
    end
    currentGunTable = nil
    currentGunOld = nil
end

function tryPatchRapidFire(tool, delay)
    -- Патчим только если есть FireDelay/INIT_FIRE_DELAY, иначе не трогаем предмет!
    task.spawn(function()
        for i = 1, 10 do -- обычно хватает 1-3 итераций
            if not rapidFireEnabled or not tool or not tool.Parent then
                break
            end
            if applyRapidFireToTool(tool, delay) then
                break
            end
            task.wait(0.07)
        end
    end)
end

function hookCharacter(char)
    char.ChildAdded:Connect(function(obj)
        if obj:IsA("Tool") then
            -- Только если rapid включён
            if rapidFireEnabled then
                tryPatchRapidFire(obj, sliderToDelay(rapidFireSliderValue))
            end
            currentTool = obj
            obj.AncestryChanged:Connect(function(child, parent)
                if child == currentTool and not child:IsDescendantOf(LocalPlayer.Character) then
                    restoreRapidFireOnCurrent()
                    currentTool = nil
                end
            end)
        end
    end)
end

if LocalPlayer.Character then hookCharacter(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(hookCharacter)

CombatOtherBox:AddToggle('RapidFire', {Text = 'Rapid Fire', Default = false})
:OnChanged(function(v)
    rapidFireEnabled = v
    if v and LocalPlayer.Character then
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            tryPatchRapidFire(tool, sliderToDelay(rapidFireSliderValue))
            currentTool = tool
        end
    else
        restoreRapidFireOnCurrent()
    end
end)

CombatOtherBox:AddSlider('RapidFireSpeed', {
    Text = 'Rapid Fire Speed',
    Min = 0,
    Max = 2,
    Default = 0.5,
    Rounding = 2,
    Tooltip = 'recomend use 1'
}):OnChanged(function(val)
    rapidFireSliderValue = val
    if rapidFireEnabled and LocalPlayer.Character then
        local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool then
            tryPatchRapidFire(tool, sliderToDelay(val))
        end
    end
end)

AntiAimSettings = {
    SpinEnabled = false,
    SpinSpeed = 350,
}

local spinConnection = nil

function setSpinBot(enabled, speed)
    AntiAimSettings.SpinEnabled = enabled
    AntiAimSettings.SpinSpeed = speed or AntiAimSettings.SpinSpeed

    if spinConnection then
        spinConnection:Disconnect()
        spinConnection = nil
    end

    if enabled then
        spinConnection = game:GetService("RunService").RenderStepped:Connect(function()
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local pos = hrp.Position
                local spinAngle = math.rad(tick() * AntiAimSettings.SpinSpeed % 360)
                hrp.CFrame = CFrame.new(pos) * CFrame.Angles(0, spinAngle, 0)
            end
        end)
    end
end

CombatAntiAim = Tabs.Combat:AddRightGroupbox("AntiAim")

CombatAntiAim:AddSlider('SpinBotSpeed', {
    Text = 'Spin Speed',
    Min = -1000,
    Max = 1000,
    Default = AntiAimSettings.SpinSpeed,
    Rounding = 0
})
:OnChanged(function(val)
    AntiAimSettings.SpinSpeed = val
    if Toggles.SpinBotEnabled and Toggles.SpinBotEnabled.Value then
        setSpinBot(true, val)
    end
end)

CombatAntiAim:AddToggle('SpinBotEnabled', {Text = 'Spin Bot', Default = false})
    :OnChanged(function(v)
        local speed = Options.SpinBotSpeed and Options.SpinBotSpeed.Value or AntiAimSettings.SpinSpeed
        setSpinBot(v, speed)
    end)
    local randomAngleEnabled = false
randomAngleSpeed = 0.1 
lastChange = 0
randomAngleConnection = nil

CombatAntiAim:AddToggle('RandomAngleEnabled', {
    Text = 'Random Angle',
    Default = false,
})
:OnChanged(function(v)
    randomAngleEnabled = v
    if randomAngleConnection then
        randomAngleConnection:Disconnect()
        randomAngleConnection = nil
    end
    lastChange = 0
    if v then
        randomAngleConnection = RunService.Heartbeat:Connect(function()
            local now = tick()
            if now - lastChange >= randomAngleSpeed then
                local player = Players.LocalPlayer
                local character = player.Character
                local primary = character and character.PrimaryPart
                if character and primary then
                    local pos = primary.Position
                    local angle = math.random(0, 360)
                    character:SetPrimaryPartCFrame(CFrame.new(pos) * CFrame.Angles(0, math.rad(angle), 0))
                end
                lastChange = now
            end
        end)
    end
end)

CombatAntiAim:AddSlider('RandomAngleSpeed', {
    Text = 'Random Angle Speed',
    Min = 0.02,
    Max = 1,
    Default = randomAngleSpeed,
    Rounding = 2,
}):OnChanged(function(val)
    randomAngleSpeed = val
end)

Players.LocalPlayer.CharacterAdded:Connect(function()
    if randomAngleEnabled then
        if randomAngleConnection then
            randomAngleConnection:Disconnect()
            randomAngleConnection = nil
        end
        lastChange = 0
        randomAngleConnection = RunService.Heartbeat:Connect(function()
            local now = tick()
            if now - lastChange >= randomAngleSpeed then
                local player = Players.LocalPlayer
                local character = player.Character
                local primary = character and character.PrimaryPart
                if character and primary then
                    local pos = primary.Position
                    local angle = math.random(0, 360)
                    character:SetPrimaryPartCFrame(CFrame.new(pos) * CFrame.Angles(0, math.rad(angle), 0))
                end
                lastChange = now
            end
        end)
    end
end)
VisualBox = Tabs.Visual:AddLeftGroupbox('ESP')
ESPOptions = {
    Enabled = false,
    Box = false,
    BoxStyle = "Default",
    BoxFill = false,
    BoxFillColor = Color3.fromRGB(255, 255, 255),
    BoxFillTrans = 0.5,
    Name = false,
    HealthBar = false,
    HealthText = false,
    Distance = false,
    Weapon = false,
    TeamCheck = false 
}
local ESPColors = {
    Box1 = Color3.fromRGB(255, 255, 255),
    Name = Color3.fromRGB(255, 255, 255),
    Distance = Color3.fromRGB(255, 255, 255),
    Weapon = Color3.fromRGB(255, 255, 255),
}
VisualBox:AddToggle('ESPEnabled', {Text = 'ESP Enabled', Default = false}):OnChanged(function(v) ESPOptions.Enabled = v end)
VisualBox:AddDivider()
VisualBox:AddToggle('ESPBox', {Text = 'Box', Default = false})
    :AddColorPicker('BoxColor1', {
        Default = ESPColors.Box1, Title = 'Box Color',
        Callback = function(val) ESPColors.Box1 = val end
    }):OnChanged(function(v) ESPOptions.Box = v end)
VisualBox:AddDropdown('BoxStyle', {Text = 'Box Style', Values = {'Default', 'Corned'}, Default = 1}):OnChanged(function(v) ESPOptions.BoxStyle = v end)
VisualBox:AddToggle('ESPBoxFill', {Text = 'Box Fill', Default = false})
    :AddColorPicker('ESPBoxFillColor', {
        Default = ESPOptions.BoxFillColor, Title = 'Box Fill Color',
        Callback = function(val) ESPOptions.BoxFillColor=val end
    }):OnChanged(function(v) ESPOptions.BoxFill = v end)
VisualBox:AddSlider('ESPBoxFillTrans', {Text='Box Fill Transparency', Min=1, Max=100, Default=50, Rounding=0}):OnChanged(function(v) ESPOptions.BoxFillTrans=v/100 end)
VisualBox:AddToggle('ESPName', {Text = 'Name', Default = false})
    :AddColorPicker('NameColor', {
        Default = ESPColors.Name, Title = 'Name Color',
        Callback = function(val) ESPColors.Name = val end
    }):OnChanged(function(v) ESPOptions.Name = v end)
VisualBox:AddToggle('ESPDistance', {Text = 'Distant', Default = false})
    :AddColorPicker('DistanceColor', {
        Default = ESPColors.Distance, Title = 'Distance Color',
        Callback = function(val) ESPColors.Distance = val end
    }):OnChanged(function(v) ESPOptions.Distance = v end)
VisualBox:AddToggle('ESPWeapon', {Text = 'Weapon', Default = false})
    :AddColorPicker('WeaponColor', {
        Default = ESPColors.Weapon, Title = 'Weapon Color',
        Callback = function(val) ESPColors.Weapon = val end
    }):OnChanged(function(v) ESPOptions.Weapon = v end)
VisualBox:AddToggle('ESPHealthBar', {Text = 'Health bar', Default = false}):OnChanged(function(v) ESPOptions.HealthBar = v end)
VisualBox:AddToggle('ESPHealthText', {Text = 'Health text', Default = false}):OnChanged(function(v) ESPOptions.HealthText = v end)
VisualBox:AddToggle('NpcVis', {Text = 'Npc Vis', Default = false}):OnChanged(function(v)
    ESPOptions.NpcVis = v
end)
VisualBox:AddToggle('TeamCheck', {Text = 'Team Check', Default = false, }):OnChanged(function(v)
    ESPOptions.TeamCheck = v
end)
VisualBox:AddSlider('MaxDistPlayerESP', {
    Text = 'Player Distance',
    Min = 1,
    Max = 10000,
    Default = 5000,
    Rounding = 0,
}):OnChanged(function(val)
    ESPOptions.MaxPlayerDist = val
end)
ESPOptions.MaxPlayerDist = 5000

VisualBox:AddSlider('MaxDistNpcESP', {
    Text = 'Npc Distance ESP',
    Min = 1,
    Max = 10000,
    Default = 5000,
    Rounding = 0,
}):OnChanged(function(val)
    ESPOptions.MaxNpcDist = val
end)
OtherBox = Tabs.Visual:AddRightGroupbox('Other')

local BulletTraceConfig = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    Mode = "Default", 
    LifeTime = 1,
    Transparency = 0.1,
}

OtherBox:AddToggle('BulletTrace', {Text = 'Bullet Trace', Default = false})
    :AddColorPicker('BulletTraceColor', {
        Default = BulletTraceConfig.Color,
        Title = 'Trace Color',
        Callback = function(val) BulletTraceConfig.Color = val end
    })
    :OnChanged(function(v) BulletTraceConfig.Enabled = v end)
Options.BulletTraceColor:OnChanged(function(val) BulletTraceConfig.Color = val end)

OtherBox:AddDropdown('BulletTraceMode', {
    Text = 'Trace Style',
    Values = {"Default", "Neon", "Laser", "Wave"}, 
    Default = 1
}):OnChanged(function(val)
    BulletTraceConfig.Mode = val
end)

OtherBox:AddSlider('BulletTraceLifeTime', {
    Text="Trace Life Time (sec)",
    Min=0, Max=20, Default=1, Rounding=2
}):OnChanged(function(val)
    BulletTraceConfig.LifeTime = val
end)

OtherBox:AddSlider('BulletTraceTrans', {
    Text="Trace Transparency",
    Min=0, Max=100, Default=10, Rounding=0
}):OnChanged(function(val)
    BulletTraceConfig.Transparency = val/100
end)

local XRayOptions = {Enabled = false, Bind = Enum.KeyCode.X, Transparency = 1}
OtherBox:AddToggle('XRay', {Text = 'XRay', Default = false})
    :AddKeyPicker('XRayKey', {
        Default = 'X',
        SyncToggleState = true,
        Mode = 'Toggle',
        Text = 'XRay Key',
        NoUI = false
    })
    :OnChanged(function(v)
        XRayOptions.Enabled = v
    end)

task.spawn(function()
    while true do
        task.wait(0.03)
        local shouldEnable = Options.XRayKey:GetState()
        if shouldEnable ~= Toggles.XRay.Value then
            Toggles.XRay:SetValue(shouldEnable)
        end
        if Library.Unloaded then break end
    end
end)
OtherBox:AddSlider('XRayTrans', {Text = 'XRay Transparency', Min = 0, Max = 100, Default = 100, Rounding = 0}):OnChanged(function(v)
    XRayOptions.Transparency = v / 100
end)
OtherBox:AddSlider('FovChanger', {
    Text = 'FOV Changer',
    Min = 60,
    Max = 170,
    Default = Camera.FieldOfView,
    Rounding = 0
}):OnChanged(function(v)
    Camera.FieldOfView = v
end)

ReplicatedStorage = game:GetService("ReplicatedStorage")
GunRemotes = ReplicatedStorage:FindFirstChild("Gun") and ReplicatedStorage.Gun:FindFirstChild("Remotes")
if GunRemotes then
    if GunRemotes:FindFirstChild("Aim") then
        GunRemotes.Aim.OnClientEvent:Connect(function(...)
            isAiming = true
        end)
    end
    if GunRemotes:FindFirstChild("StopAim") then
        GunRemotes.StopAim.OnClientEvent:Connect(function(...)
            isAiming = false
            local cam = workspace.CurrentCamera
            if cam then
                cam.FieldOfView = desiredFOV
            end
        end)
    end
end

terrain = workspace:FindFirstChildOfClass("Terrain")
defaultGrass = nil
if terrain and sethiddenproperty then
    defaultGrass = (gethiddenproperty and gethiddenproperty(terrain, "Decoration")) or false
end
OtherBox:AddToggle('NoGrass', {Text = 'No Grass', Default = false}):OnChanged(function(v)
    if terrain and sethiddenproperty then
        sethiddenproperty(terrain, "Decoration", not v and defaultGrass or false)
        if _G.ConsoleLogs then
            warn(v and "Decorations Disabled" or "Decorations Enabled")
        end
    else
        warn("Your exploit does not support sethiddenproperty, please use a different exploit.")
    end
end)

Lighting = game:GetService("Lighting")

originalAtmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
savedAtmosphereProps = nil
if originalAtmosphere then
    savedAtmosphereProps = {}
    for _, prop in ipairs({"Density", "Offset", "Color", "Decay", "Glare", "Haze"}) do
        savedAtmosphereProps[prop] = originalAtmosphere[prop]
    end
end

local shadowConnection

OtherBox:AddToggle('NoFog', {Text = 'No Fog', Default = false}):OnChanged(function(v)
    local atmos = Lighting:FindFirstChildOfClass("Atmosphere")
    if v then
        if atmos then
            atmos:Destroy()
        end
    else
        if not Lighting:FindFirstChildOfClass("Atmosphere") and savedAtmosphereProps then
            local newAtmos = Instance.new("Atmosphere")
            for prop, value in pairs(savedAtmosphereProps) do
                newAtmos[prop] = value
            end
            newAtmos.Parent = Lighting
        end
    end
end)

OtherBox:AddToggle('NoShadow', {Text = 'No Shadow', Default = false}):OnChanged(function(v)
    if v then
        if not shadowConnection then
            shadowConnection = RunService.RenderStepped:Connect(function()
                Lighting.GlobalShadows = false
            end)
        end
    else
        if shadowConnection then
            shadowConnection:Disconnect()
            shadowConnection = nil
        end
        Lighting.GlobalShadows = true 
    end
end)
ambientColor = Lighting.Ambient
OtherBox:AddToggle('AmbientEnabled', {Text = 'Ambient', Default = false})
    :AddColorPicker('AmbientColorPicker', {
        Default = ambientColor,
        Title = 'Ambient Color',
        Callback = function(val)
            ambientColor = val
            if Toggles.AmbientEnabled.Value then
                Lighting.Ambient = ambientColor
            end
        end
    })
    :OnChanged(function(v)
        if v then
            Lighting.Ambient = ambientColor
        else
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        end
    end)
local StaffListConfig = {
    Enabled = false,
    OnlyOnline = false,
    Roles = {
        ["Admin"] = true, ["Admin+"] = true, ["Cool coconut"] = true,
        ["Developer"] = true, ["Secret agent"] = true, ["Lead developer"] = true, ["Bob"] = true,
    },
    NotificationAlert = false,
    SoundAlert = false,
    SelectedSoundId = 3165700530,
}
local staffGroupId = 15631191
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local allStaffRoles = {"Admin", "Admin+", "Cool coconut", "Developer", "Secret agent", "Lead developer", "Bob"}
local staffWindowW, staffHeaderH = 292, 28
local staffRowH = 18
local staffFontSize = 14
local staffBgColor = Color3.fromRGB(24, 24, 24)
local staffHeaderColor = Color3.fromRGB(34, 36, 39)
local staffBorderColor = Color3.fromRGB(120, 120, 120)
local staffTextColor = Color3.fromRGB(255, 255, 255)
local staffGreen = Color3.fromRGB(45, 220, 70)
local staffRed = Color3.fromRGB(230, 60, 60)
local staffBgTransparency = 0.93
local staffColNameX, staffColRoleX, staffColStatX = 17, 120, 210
local viewportY = workspace.CurrentCamera.ViewportSize.Y
local staffWindowPos = Vector2.new(24, math.floor(viewportY * 0.2))

local staffDragging, staffOffset = false, Vector2.new(0, 0)
local staffExpanded = false
local staffEntries = {}
local staffLastStaff = {}
local staffDrawings = {}

local staffPrevOnline = {}

local function StaffList_ClearDrawings()
    for _, v in pairs(staffDrawings) do if v then v.Visible = false end end
    for _, row in ipairs(staffEntries) do
        for _, obj in pairs(row) do if obj then obj.Visible = false end end
    end
end
local function StaffList_DestroyDrawings()
    for _, v in pairs(staffDrawings) do if v then pcall(function() v:Remove() end) end end
    staffDrawings = {}
    for _, row in ipairs(staffEntries) do
        for _, obj in pairs(row) do if obj then pcall(function() obj:Remove() end) end end
    end
    staffEntries = {}
end
local function StaffList_CreateDrawings()
    StaffList_DestroyDrawings()
    local d = {}
    d.border = Drawing.new("Square")
    d.border.Filled = false
    d.border.Color = staffBorderColor
    d.border.Thickness = 2
    d.border.Transparency = 1
    d.border.Size = Vector2.new(staffWindowW, staffHeaderH)
    d.border.Position = staffWindowPos
    d.border.Visible = true

    d.bg = Drawing.new("Square")
    d.bg.Filled = true
    d.bg.Color = staffBgColor
    d.bg.Transparency = staffBgTransparency
    d.bg.Size = Vector2.new(staffWindowW, staffHeaderH)
    d.bg.Position = staffWindowPos
    d.bg.Visible = true

    d.header = Drawing.new("Square")
    d.header.Filled = true
    d.header.Color = staffHeaderColor
    d.header.Transparency = 1
    d.header.Size = Vector2.new(staffWindowW, staffHeaderH)
    d.header.Position = staffWindowPos
    d.header.Visible = true

    d.arrow = Drawing.new("Text")
    d.arrow.Text = ">"
    d.arrow.Size = 16
    d.arrow.Color = staffTextColor
    d.arrow.Outline = true
    d.arrow.Center = false
    d.arrow.Position = staffWindowPos + Vector2.new(staffWindowW - 24, 5)
    d.arrow.Visible = true

    d.title = Drawing.new("Text")
    d.title.Text = "Staff List"
    d.title.Size = 16
    d.title.Color = staffTextColor
    d.title.Outline = true
    d.title.Center = false
    d.title.Position = staffWindowPos + Vector2.new(12, 4)
    d.title.Visible = true

    d.colNameLbl = Drawing.new("Text")
    d.colNameLbl.Text = "Name"
    d.colNameLbl.Size = staffFontSize
    d.colNameLbl.Font = Drawing.Fonts.UI
    d.colNameLbl.Color = staffTextColor
    d.colNameLbl.Outline = true
    d.colNameLbl.Center = false
    d.colNameLbl.Position = staffWindowPos + Vector2.new(staffColNameX, staffHeaderH + 2)
    d.colNameLbl.Visible = false

    d.colRoleLbl = Drawing.new("Text")
    d.colRoleLbl.Text = "Role"
    d.colRoleLbl.Size = staffFontSize
    d.colRoleLbl.Font = Drawing.Fonts.UI
    d.colRoleLbl.Color = staffTextColor
    d.colRoleLbl.Outline = true
    d.colRoleLbl.Center = false
    d.colRoleLbl.Position = staffWindowPos + Vector2.new(staffColRoleX, staffHeaderH + 2)
    d.colRoleLbl.Visible = false

    d.colStatusLbl = Drawing.new("Text")
    d.colStatusLbl.Text = "Status"
    d.colStatusLbl.Size = staffFontSize
    d.colStatusLbl.Font = Drawing.Fonts.UI
    d.colStatusLbl.Color = staffTextColor
    d.colStatusLbl.Outline = true
    d.colStatusLbl.Center = false
    d.colStatusLbl.Position = staffWindowPos + Vector2.new(staffColStatX, staffHeaderH + 2)
    d.colStatusLbl.Visible = false

    staffDrawings = d
end
local function StaffList_SetRows(staff)
    for _, row in ipairs(staffEntries) do
        for _, obj in pairs(row) do if obj then pcall(function() obj:Remove() end) end end
    end
    staffEntries = {}
    for i, e in ipairs(staff) do
        local y = staffWindowPos.Y + staffHeaderH + 2 + staffFontSize + ((i - 1) * staffRowH)
        local n = Drawing.new("Text")
        n.Text = e.name
        n.Size = staffFontSize
        n.Font = Drawing.Fonts.UI
        n.Color = staffTextColor
        n.Outline = false
        n.Center = false
        n.Position = Vector2.new(staffWindowPos.X + staffColNameX, y)
        n.Visible = staffExpanded

        local r = Drawing.new("Text")
        r.Text = e.rank
        r.Size = staffFontSize
        r.Font = Drawing.Fonts.UI
        r.Color = staffTextColor
        r.Outline = false
        r.Center = false
        r.Position = Vector2.new(staffWindowPos.X + staffColRoleX, y)
        r.Visible = staffExpanded

        local s = Drawing.new("Text")
        s.Text = e.online and "Online" or "Offline"
        s.Size = staffFontSize
        s.Font = Drawing.Fonts.UI
        s.Color = e.online and staffGreen or staffRed
        s.Outline = false
        s.Center = false
        s.Position = Vector2.new(staffWindowPos.X + staffColStatX, y)
        s.Visible = staffExpanded

        table.insert(staffEntries, {name=n, role=r, status=s})
    end
end
local function StaffList_UpdatePositions()
    if not staffDrawings.border then return end
    local d = staffDrawings
    d.bg.Position = staffWindowPos
    d.border.Position = staffWindowPos
    d.header.Position = staffWindowPos
    d.arrow.Position = staffWindowPos + Vector2.new(staffWindowW - 24, 5)
    d.title.Position = staffWindowPos + Vector2.new(12, 4)
    d.colNameLbl.Position = staffWindowPos + Vector2.new(staffColNameX, staffHeaderH + 2)
    d.colRoleLbl.Position = staffWindowPos + Vector2.new(staffColRoleX, staffHeaderH + 2)
    d.colStatusLbl.Position = staffWindowPos + Vector2.new(staffColStatX, staffHeaderH + 2)
    for i, v in ipairs(staffEntries) do
        local y = staffWindowPos.Y + staffHeaderH + 2 + staffFontSize + ((i - 1) * staffRowH)
        v.name.Position = Vector2.new(staffWindowPos.X + staffColNameX, y)
        v.role.Position = Vector2.new(staffWindowPos.X + staffColRoleX, y)
        v.status.Position = Vector2.new(staffWindowPos.X + staffColStatX, y)
    end
end
local function StaffList_Redraw()
    if not staffDrawings.border then return end
    local staff = staffLastStaff
    local visibleCount = #staff
    local listH = staffHeaderH + 2 + staffFontSize + (visibleCount)*staffRowH + 10
    local d = staffDrawings
    d.bg.Size = Vector2.new(staffWindowW, staffExpanded and listH or staffHeaderH)
    d.border.Size = Vector2.new(staffWindowW, staffExpanded and listH or staffHeaderH)
    d.header.Size = Vector2.new(staffWindowW, staffHeaderH)
    d.colNameLbl.Visible = staffExpanded
    d.colRoleLbl.Visible = staffExpanded
    d.colStatusLbl.Visible = staffExpanded
    for _, v in ipairs(staffEntries) do
        v.name.Visible = staffExpanded
        v.role.Visible = staffExpanded
        v.status.Visible = staffExpanded
    end
    d.arrow.Text = staffExpanded and "v" or ">"
end
local function StaffList_GetStaff()
    local staff = {}
    local userIdToStaff = {}
    local rolesRaw
    pcall(function()
        rolesRaw = game:HttpGet("https://groups.roblox.com/v1/groups/" .. staffGroupId .. "/roles")
    end)
    if not rolesRaw then return {} end
    local rolesData = HttpService:JSONDecode(rolesRaw).roles
    for _, role in ipairs(rolesData) do
        if StaffListConfig.Roles[role.name] then
            local usersRaw
            pcall(function()
                usersRaw = game:HttpGet("https://groups.roblox.com/v1/groups/" .. staffGroupId .. "/roles/" .. role.id .. "/users?limit=100")
            end)
            if usersRaw then
                local usersData = HttpService:JSONDecode(usersRaw).data
                for _, user in ipairs(usersData) do
                    staff[#staff + 1] = {name = user.username, rank = role.name, userId = user.userId, online = false}
                    userIdToStaff[user.userId] = #staff
                end
            end
        end
    end
    for _, player in ipairs(Players:GetPlayers()) do
        if userIdToStaff[player.UserId] then
            staff[userIdToStaff[player.UserId]].online = true
        end
    end
    if StaffListConfig.OnlyOnline then
        local filtered = {}
        for _, s in ipairs(staff) do
            if s.online then table.insert(filtered, s) end
        end
        staff = filtered
    end
    table.sort(staff, function(a, b)
        if a.online == b.online then
            return string.lower(a.rank) < string.lower(b.rank)
        else
            return a.online and not b.online
        end
    end)
    return staff
end

local function playStaffSound()
    if not StaffListConfig.SoundAlert then return end
    local id = StaffListConfig.SelectedSoundId or 3165700530
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://"..id
    sound.Volume = 2
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 4)
end

function notifyStaffAlert(name)
    if not StaffListConfig.NotificationAlert then return end
    if Library and Library.Notify then
        Library:Notify(name.." is now online!", 5)
    end
end

local function StaffList_Refresh()
    if not StaffListConfig.Enabled then return end
    local staff = StaffList_GetStaff()
    staffLastStaff = staff
    -- Оповещения
    if staffPrevOnline and StaffListConfig.Enabled then
        for _, s in ipairs(staff) do
            if s.online and not staffPrevOnline[s.userId] then
                -- Новый стафф онлайн
                playStaffSound()
                notifyStaffAlert(s.name)
            end
        end
    end
    -- Обновить мапу для следующего раза
    staffPrevOnline = {}
    for _, s in ipairs(staff) do
        if s.online then
            staffPrevOnline[s.userId] = true
        end
    end

    StaffList_SetRows(staff)
    StaffList_Redraw()
    StaffList_UpdatePositions()
end

UserInputService.InputBegan:Connect(function(input)
    if not StaffListConfig.Enabled or not staffDrawings.border then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local m = UserInputService:GetMouseLocation()
        if m.X >= staffWindowPos.X + staffWindowW - 36 and m.X <= staffWindowPos.X + staffWindowW and
           m.Y >= staffWindowPos.Y and m.Y <= staffWindowPos.Y + staffHeaderH then
            staffExpanded = not staffExpanded
            StaffList_Redraw()
            return
        end
        if m.X >= staffWindowPos.X and m.X <= staffWindowPos.X + staffWindowW - 36 and
           m.Y >= staffWindowPos.Y and m.Y <= staffWindowPos.Y + staffHeaderH then
            staffDragging = true
            staffOffset = m - staffWindowPos
        end
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        staffDragging = false
    end
end)
RunService.RenderStepped:Connect(function()
    if StaffListConfig.Enabled and staffDragging then
        local m = UserInputService:GetMouseLocation()
        staffWindowPos = m - staffOffset
        StaffList_UpdatePositions()
    end
end)

staffListRunning = false
staffListThread = nil
function StaffList_Start()
    if staffListRunning then return end
    staffListRunning = true
    viewportY = workspace.CurrentCamera.ViewportSize.Y
    staffWindowPos = Vector2.new(24, math.floor(viewportY * 0.2))
    StaffList_CreateDrawings()
    staffExpanded = false
    staffDrawings.arrow.Text = ">"
    staffDrawings.colNameLbl.Visible = false
    staffDrawings.colRoleLbl.Visible = false
    staffDrawings.colStatusLbl.Visible = false
    for _, v in ipairs(staffEntries) do
        v.name.Visible = false
        v.role.Visible = false
        v.status.Visible = false
    end
    staffDrawings.bg.Size = Vector2.new(staffWindowW, staffHeaderH)
    staffDrawings.border.Size = Vector2.new(staffWindowW, staffHeaderH)
    staffPrevOnline = {}
    StaffList_Refresh()
    staffListThread = task.spawn(function()
        while StaffListConfig.Enabled do
            task.wait(10)
            StaffList_Refresh()
        end
    end)
end
function StaffList_Stop()
    staffListRunning = false
    StaffList_ClearDrawings()
    StaffList_DestroyDrawings() 
    if staffListThread then
        task.cancel(staffListThread)
        staffListThread = nil
    end
    staffPrevOnline = {}
end

StaffVisualBox = Tabs.Visual:AddLeftGroupbox('Staff List', {TabSide='Top'})

StaffVisualBox:AddToggle('StaffListEnabled', {Text = 'Staff List enabled', Default = false})
    :OnChanged(function(v)
        StaffListConfig.Enabled = v
        if v then
            StaffList_Start()
        else
            StaffList_Stop()
        end
    end)

StaffVisualBox:AddDropdown('StaffListRoles', {
    Text = 'Staff Roles',
    Values = allStaffRoles,
    Multi = true,
    Default = allStaffRoles,
}):OnChanged(function(val)
    local hasAny = false
    for _, role in ipairs(allStaffRoles) do
        if val[role] then hasAny = true end
    end
    if not hasAny then
        for _, role in ipairs(allStaffRoles) do
            val[role] = true
        end
    end
    for _, role in ipairs(allStaffRoles) do
        StaffListConfig.Roles[role] = val[role] and true or false
    end
    if StaffListConfig.Enabled then StaffList_Refresh() end
end)
Options.StaffListRoles:SetValue(table.clone(StaffListConfig.Roles))

StaffVisualBox:AddToggle('StaffListOnlyOnline', {Text = 'Only Online', Default = false})
    :OnChanged(function(v)
        StaffListConfig.OnlyOnline = v
        if StaffListConfig.Enabled then StaffList_Refresh() end
    end)

StaffVisualBox:AddToggle('StaffListNotify', {Text = 'Notification Alert', Default = false})
    :OnChanged(function(v)
        StaffListConfig.NotificationAlert = v
    end)
StaffVisualBox:AddToggle('StaffListSound', {Text = 'Sound Alert', Default = false})
    :OnChanged(function(v)
        StaffListConfig.SoundAlert = v
    end)
StaffVisualBox:AddDropdown('StaffListSoundSelect', {
    Text = 'Sound Alert Type',
    Values = {"Alert 1", "Alert 2"},
    Default = "Alert 1",
}):OnChanged(function(val)
    if val == "Alert 1" then
        StaffListConfig.SelectedSoundId = 3165700530
    elseif val == "Alert 2" then
        StaffListConfig.SelectedSoundId = 8727079949
    end
end)
Options.StaffListSoundSelect:SetValue("Alert 1")

Toggles.StaffListEnabled:SetValue(false)
Options.StaffListRoles:SetValue(table.clone(StaffListConfig.Roles))
Toggles.StaffListOnlyOnline:SetValue(false)
Toggles.StaffListNotify:SetValue(false)
Toggles.StaffListSound:SetValue(false)

local player = game:GetService("Players").LocalPlayer
local workspace = game:GetService("Workspace")
local camera = workspace.CurrentCamera
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Tabs = Tabs or getgenv().Tabs
local Toggles = Toggles or getgenv().Toggles
local Options = Options or getgenv().Options

local function safeIsA(obj, class)
    return obj and typeof(obj) == "Instance" and obj:IsA(class)
end
local function safeProp(obj, prop)
    local ok, val = pcall(function() return obj[prop] end)
    return ok and val or nil
end
local function safeGetChildren(obj)
    if obj and typeof(obj) == "Instance" and obj.GetChildren then
        local ok, children = pcall(function() return obj:GetChildren() end)
        if ok and children then return children end
    end
    return {}
end

local armorPriority = {
    {"facemask", "FaceMask", "Metal facemask", "MetalFacemask", "Facemask"},
    {"helmet", "Helmet", "HelmetModel"},
    {"hoodie", "Hoodie", "HoodieModel", "shirt", "Shirt", "ShirtModel", "TShirt", "TShirtModel", "jacket", "Jacket", "JacketModel"},
    {"chest", "Chest", "ChestModel", "ChestPlate", "ChestPlateModel", "Metal chest plate"},
    {"kilt", "Kilt", "KiltModel", "RoadSignKilt", "RoadSignKiltModel"},
    {"pants", "Pants", "PantsModel", "boots", "Boots", "BootsModel", "hazmat", "Hazmat", "HazmatSuit", "HazmatModel"}
}

local assetIdCache = setmetatable({}, {__mode = "k"})

local function findAssetIdDeep(obj)
    if not safeIsA(obj, "Instance") then return nil end
    if assetIdCache[obj] ~= nil then return assetIdCache[obj] end
    local props = {"TextureID", "TextureId", "Texture", "Image"}
    if safeIsA(obj, "StringValue") or safeIsA(obj, "IntValue") then
        local val = safeProp(obj, "Value")
        if val and tostring(val):find("rbxassetid") then
            assetIdCache[obj] = tostring(val)
            return assetIdCache[obj]
        end
    end
    for _, prop in ipairs(props) do
        local value = safeProp(obj, prop)
        if value and typeof(value) == "string" and value:find("rbxassetid") then
            assetIdCache[obj] = value
            return value
        end
    end
    for _, child in ipairs(safeGetChildren(obj)) do
        local assetId = findAssetIdDeep(child)
        if assetId and assetId ~= "" then
            assetIdCache[obj] = assetId
            return assetId
        end
    end
    assetIdCache[obj] = nil
    return nil
end

local function isArmor(obj)
    local name = (safeProp(obj, "Name") or ""):lower()
    for _, group in ipairs(armorPriority) do
        for _, armorName in ipairs(group) do
            if name == armorName:lower() or name:find(armorName:lower()) then
                return true
            end
        end
    end
    return false
end

local slotW, slotH = 82, 80
local slotRadius = 8
local slotGapX, slotGapY = 3, 3
local armorCount = 6
local hotbarCount = 6
local invBarCols = 6
local invBarRows = 4
local rightShift = 8
local rowDistance = 5

local function getScreenSize()
    return camera and camera.ViewportSize.X or 1920, camera and camera.ViewportSize.Y or 1080
end

local screenW, screenH = getScreenSize()
local totalWidthArmor = armorCount * slotW + (armorCount - 1) * slotGapX
local totalWidthHotbar = hotbarCount * slotW + (hotbarCount - 1) * slotGapX
local totalWidthInvBar = invBarCols * slotW + (invBarCols - 1) * slotGapX
local armorStartX = math.floor((screenW - totalWidthArmor) / 2) + rightShift
local hotbarStartX = math.floor((screenW - totalWidthHotbar) / 2) + rightShift
local invBarStartX = math.floor((screenW - totalWidthInvBar) / 2) + rightShift

local function getPersistentGui()
    local gui = nil
    pcall(function()
        gui = player.PlayerGui:FindFirstChild("TargetInventoryScreenGui")
    end)
    if not gui then
        gui = Instance.new("ScreenGui")
        gui.Name = "TargetInventoryScreenGui"
        gui.IgnoreGuiInset = true
        gui.ResetOnSpawn = false
        gui.Parent = player:WaitForChild("PlayerGui")
    end
    return gui
end

local function loadPersistentPositions()
    local data = {}
    pcall(function()
        data = HttpService:JSONDecode(getgenv().TargetInvGuiPositions or "{}")
    end)
    return data
end

local function savePersistentPositions(data)
    getgenv().TargetInvGuiPositions = HttpService:JSONEncode(data)
end

local positionStore = loadPersistentPositions()
local dragBarX = positionStore.dragBarX or hotbarStartX
local dragBarY = positionStore.dragBarY or (math.floor(screenH * 0.71) - 5 - 2)
local invDragBarX = positionStore.invDragBarX or invBarStartX
local invDragBarY = positionStore.invDragBarY or (dragBarY - (invBarRows * (slotH + slotGapY)) - 32)

local dragBarHeight = 5
local dragBarWidth = totalWidthHotbar
local dragBarRadius = 10
local dragBarTransparency = 0.8

local invDragBarHeight = 5
local invDragBarWidth = totalWidthInvBar
local invDragBarRadius = 10
local invDragBarTransparency = 0.8

local screenGui = getPersistentGui()
local slotFrames = {}

local TargetBox = Tabs.Visual:AddLeftGroupbox('Target')
TargetBox:AddToggle('TargetInfoEnabled', {Text = 'Target Info Enabled BETA', Default = false})
TargetBox:AddToggle('ArmorEnabled', {Text = 'Armor (1 row)', Default = true})
TargetBox:AddToggle('HotbarEnabled', {Text = 'HotBar (2 row)', Default = true})
TargetBox:AddToggle('DragModeEnabled', {Text = 'Drag Mode Armor&HotBar', Default = false})
TargetBox:AddToggle('InventoryBarEnabled', {Text = 'Inventory Bar', Default = false})
TargetBox:AddToggle('InventoryDragModeEnabled', {Text = 'Inventory Drag Mode', Default = false})
TargetBox:AddToggle('OnlyTarget', {Text = 'Only Target', Default = false})

TargetBox:AddSlider('HotBarTransparency', {
    Text = 'HotBar Transparency',
    Default = 0.8, Min = 0, Max = 1, Rounding = 2
})

TargetBox:AddSlider('ArmorTransparency', {
    Text = 'Armor Transparency',
    Default = 0.8, Min = 0, Max = 1, Rounding = 2
})

TargetBox:AddSlider('InventoryBarTransparency', {
    Text = 'Inventory Transparency',
    Default = 0.8, Min = 0, Max = 1, Rounding = 2
})

TargetBox:AddLabel('Default HotBar color')
    :AddColorPicker('DefaultHudColor', {Default = Color3.fromRGB(0,0,0), Title = 'Default HotBar Color'})

TargetBox:AddLabel('Active item color')
    :AddColorPicker('ActiveItemHudColor', {Default = Color3.fromRGB(35, 55, 100), Title = 'Active Item Color'})

TargetBox:AddLabel('Armor color')
    :AddColorPicker('ArmorHudColor', {Default = Color3.fromRGB(0,0,0), Title = 'Armor Color'})

TargetBox:AddLabel('Inventory color')
    :AddColorPicker('InventoryHudColor', {Default = Color3.fromRGB(18,18,18), Title = 'Inventory Color'})

TargetBox:AddToggle('InventoryOnlyFilled', {Text = 'Inventory Only Filled', Default = false})

local function getDragBar()
    local frame = screenGui:FindFirstChild("DragBarFrame")
    if not frame then
        frame = Instance.new("Frame")
        frame.Name = "DragBarFrame"
        frame.Size = UDim2.new(0, dragBarWidth, 0, dragBarHeight)
        frame.Position = UDim2.new(0, dragBarX, 0, dragBarY)
        frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
        frame.BackgroundTransparency = dragBarTransparency
        frame.BorderSizePixel = 0
        frame.Visible = false
        frame.Parent = screenGui

        local dragUICorner = Instance.new("UICorner")
        dragUICorner.CornerRadius = UDim.new(0, dragBarRadius)
        dragUICorner.Parent = frame
    end
    return frame
end

local function getInvDragBar()
    local frame = screenGui:FindFirstChild("InvDragBarFrame")
    if not frame then
        frame = Instance.new("Frame")
        frame.Name = "InvDragBarFrame"
        frame.Size = UDim2.new(0, invDragBarWidth, 0, invDragBarHeight)
        frame.Position = UDim2.new(0, invDragBarX, 0, invDragBarY)
        frame.BackgroundColor3 = Color3.fromRGB(255,255,255)
        frame.BackgroundTransparency = invDragBarTransparency
        frame.BorderSizePixel = 0
        frame.Visible = false
        frame.Parent = screenGui

        local dragUICorner = Instance.new("UICorner")
        dragUICorner.CornerRadius = UDim.new(0, invDragBarRadius)
        dragUICorner.Parent = frame
    end
    return frame
end

local dragBarFrame = getDragBar()
local invDragBarFrame = getInvDragBar()

local function shouldRender()
    local ok, v = pcall(function()
        return Toggles and Toggles.TargetInfoEnabled and Toggles.TargetInfoEnabled.Value
    end)
    return ok and v or false
end

local function clearGui()
    for i = #slotFrames, 1, -1 do
        if slotFrames[i] then pcall(function() slotFrames[i]:Destroy() end) end
        slotFrames[i] = nil
    end
end

local function getItemCount(obj)
    if obj and safeProp(obj, "ToolTip") then
        local ok, count = pcall(function()
            return tostring(obj.ToolTip):match("%d+")
        end)
        return ok and (count or "1") or "1"
    end
    return nil
end

local function makeSlot(x, y, assetId, zIndex, count, isActive, isArmor, isInventory)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, slotW, 0, slotH)
    frame.Position = UDim2.new(0, x, 0, y)
    frame.BorderSizePixel = 0
    frame.ZIndex = zIndex
    frame.Parent = screenGui
    frame.Name = "SlotFrame"

    local hudTransparency = isArmor and (Options and Options.ArmorTransparency and Options.ArmorTransparency.Value or 0.8)
        or (isInventory and (Options and Options.InventoryBarTransparency and Options.InventoryBarTransparency.Value or 0.8))
        or (Options and Options.HotBarTransparency and Options.HotBarTransparency.Value or 0.8)
    local hotbarDefaultColor = Options and Options.DefaultHudColor and Options.DefaultHudColor.Value or Color3.fromRGB(0,0,0)
    local hotbarActiveColor = Options and Options.ActiveItemHudColor and Options.ActiveItemHudColor.Value or Color3.fromRGB(35,55,100)
    local armorColor = Options and Options.ArmorHudColor and Options.ArmorHudColor.Value or Color3.fromRGB(0,0,0)
    local inventoryColor = Options and Options.InventoryHudColor and Options.InventoryHudColor.Value or Color3.fromRGB(18,18,18)

    if isArmor then
        frame.BackgroundColor3 = armorColor
    elseif isInventory then
        frame.BackgroundColor3 = inventoryColor
    else
        frame.BackgroundColor3 = isActive and hotbarActiveColor or hotbarDefaultColor
    end
    frame.BackgroundTransparency = hudTransparency

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, slotRadius)
    corner.Parent = frame

    local img = Instance.new("ImageLabel")
    img.Size = UDim2.new(0, slotW-12, 0, slotH-12)
    img.Position = UDim2.new(0, 6, 0, 6)
    img.BackgroundTransparency = 1
    img.ZIndex = zIndex + 1
    img.Parent = frame
    img.Image = assetId or ""

    if count then
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 32, 0, 24)
        lbl.Position = UDim2.new(0, 6, 1, -24)
        lbl.BackgroundTransparency = 1
        lbl.Text = "x" .. tostring(count)
        lbl.Font = Enum.Font.SourceSansBold
        lbl.TextSize = 20
        lbl.TextColor3 = Color3.new(1, 1, 1)
        lbl.TextStrokeTransparency = 0.5
        lbl.ZIndex = zIndex + 2
        lbl.Parent = frame
    end

    table.insert(slotFrames, frame)
end

local function getArmorY()
    return dragBarY + dragBarHeight + rowDistance
end
local function getHotbarY()
    return getArmorY() + slotH + slotGapY + rowDistance
end
local function getInventoryY()
    return invDragBarY + invDragBarHeight + rowDistance
end

local function getClosestToFOV()
    if not workspace or not workspace.CurrentCamera then return nil end
    local camera = workspace.CurrentCamera
    local screenCenter = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    local closest, closestDist = nil, math.huge
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= player and plr.Character and safeProp(plr.Character, "HumanoidRootPart") and safeProp(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
            local pos, onScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                if dist < (getgenv().FOV_RADIUS or 250) and dist < closestDist then
                    closestDist = dist
                    closest = plr
                end
            end
        end
    end
    return closest
end

local function getClosestToCenter()
    if not workspace or not workspace.CurrentCamera then return nil end
    local camera = workspace.CurrentCamera
    local screenCenter = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    local closest, closestDist = nil, math.huge
    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= player and plr.Character and safeProp(plr.Character, "HumanoidRootPart") and safeProp(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
            local pos, onScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = plr
                end
            end
        end
    end
    return closest
end

local function getCurrentTarget()
    if not shouldRender() then return nil end
    local SilentAim = getgenv().SilentAim or {Enabled = false, GetTarget = function() return nil end}
    if SilentAim.Enabled and SilentAim.GetTarget then
        local ok, target = pcall(function() return SilentAim:GetTarget() end)
        if ok and target and target ~= player and safeProp(target, "Character") and safeProp(target.Character, "HumanoidRootPart") and safeProp(target.Character, "Humanoid") and target.Character.Humanoid.Health > 0 then
            return target
        end
    end
    local fovTarget = getClosestToFOV()
    if fovTarget then return fovTarget end
    local centerTarget = getClosestToCenter()
    if centerTarget ~= player then
        return centerTarget
    end
    return nil
end

local lastTarget = nil
local lastInventoryHash = nil
local lastHotbarHash = nil
local lastArmorHash = nil
local cachedInventoryGrid = nil
local cachedHotbar = nil
local cachedArmor = nil
local hotbarToolsSet = nil
local backpackConns = {}
local charConns = {}

local function disconnectConns(tbl)
    for _, v in ipairs(tbl) do
        pcall(function() v:Disconnect() end)
    end
    while #tbl > 0 do table.remove(tbl) end
end

local function hashToolList(list)
    if not list then return "" end
    local str = ""
    for i, v in ipairs(list) do str = str .. (safeProp(v, "Name") or "") .. "#" end
    return str
end

local function hashArmorList(list)
    if not list then return "" end
    local str = ""
    for i, v in ipairs(list) do
        str = str .. (v and v.displayObj and safeProp(v.displayObj, "Name") or "") .. "#" end
    return str
end

local function inventoryListFromTarget(targetPlr, hotbarSet)
    local backpack = safeProp(targetPlr, "Backpack")
    local char = safeProp(targetPlr, "Character")
    local inventoryList = {}
    local added = {}

    local function isInHotbar(obj)
        return hotbarSet and hotbarSet[obj]
    end

    if backpack then
        for _, obj in ipairs(safeGetChildren(backpack)) do
            if not isArmor(obj) and not isInHotbar(obj) then
                table.insert(inventoryList, obj)
                added[obj] = true
            end
        end
    end
    if char then
        for _, obj in ipairs(safeGetChildren(char)) do
            if not isArmor(obj) and not isInHotbar(obj) and not added[obj] and not safeIsA(obj, "Tool") then
                table.insert(inventoryList, obj)
                added[obj] = true
            end
        end
    end
    return inventoryList
end

local function playerInventoryList()
    local backpack = safeProp(player, "Backpack")
    local char = safeProp(player, "Character")
    local inventoryList = {}
    local added = {}

    if backpack then
        for _, obj in ipairs(safeGetChildren(backpack)) do
            if not isArmor(obj) then
                table.insert(inventoryList, obj)
                added[obj] = true
            end
        end
    end
    if char then
        for _, obj in ipairs(safeGetChildren(char)) do
            if not isArmor(obj) and not safeIsA(obj, "Tool") and not added[obj] then
                table.insert(inventoryList, obj)
                added[obj] = true
            end
        end
    end
    return inventoryList
end

local function renderSlots(force)
    if not (Toggles and Toggles.TargetInfoEnabled and Toggles.TargetInfoEnabled.Value) then
        dragBarFrame.Visible = false
        invDragBarFrame.Visible = false
        clearGui()
        return
    end

    local onlyTarget = Toggles and Toggles.OnlyTarget and Toggles.OnlyTarget.Value
    local targetPlr = getCurrentTarget()
    local hasTarget = targetPlr and targetPlr ~= player
    local inventoryBarEnabled = Toggles and Toggles.InventoryBarEnabled and Toggles.InventoryBarEnabled.Value
    local inventoryOnlyFilled = Toggles and Toggles.InventoryOnlyFilled and Toggles.InventoryOnlyFilled.Value

    if onlyTarget and not hasTarget then
        dragBarFrame.Visible = false
        invDragBarFrame.Visible = false
        clearGui()
        lastTarget = nil
        return
    end

    if not hasTarget and not onlyTarget then
        clearGui()
        if Toggles and Toggles.ArmorEnabled and Toggles.ArmorEnabled.Value then
            local armorY = getArmorY()
            for i = 1, armorCount do
                local x = armorStartX + (i-1)*(slotW + slotGapX) + (dragBarX - hotbarStartX)
                makeSlot(x, armorY, nil, 20, nil, false, true, false)
            end
        end
        if Toggles and Toggles.HotbarEnabled and Toggles.HotbarEnabled.Value then
            local hotbarY = getHotbarY()
            for i = 1, hotbarCount do
                local x = hotbarStartX + (i-1)*(slotW + slotGapX) + (dragBarX - hotbarStartX)
                makeSlot(x, hotbarY, nil, 20, nil, false, false, false)
            end
        end
        if inventoryBarEnabled then
            local invStartY = getInventoryY()
            local invList = playerInventoryList()
            local idx = 1
            for row = 1, invBarRows do
                for col = 1, invBarCols do
                    local x = invBarStartX + (col-1)*(slotW + slotGapX) + (invDragBarX - invBarStartX)
                    local y = invStartY + (row-1)*(slotH + slotGapY)
                    local obj = invList[idx]
                    local assetId = obj and findAssetIdDeep(obj) or nil
                    local count = getItemCount(obj)
                    if obj then
                        makeSlot(x, y, assetId, 20, count or "1", false, false, true)
                    else
                        makeSlot(x, y, nil, 20, nil, false, false, true)
                    end
                    idx = idx + 1
                end
            end
        end
        dragBarFrame.Visible = Toggles and Toggles.DragModeEnabled and Toggles.DragModeEnabled.Value
        dragBarFrame.Position = UDim2.new(0, dragBarX, 0, dragBarY)
        dragBarFrame.Size = UDim2.new(0, dragBarWidth, 0, dragBarHeight)
        invDragBarFrame.Visible = Toggles and Toggles.InventoryDragModeEnabled and Toggles.InventoryDragModeEnabled.Value and inventoryBarEnabled
        invDragBarFrame.Position = UDim2.new(0, invDragBarX, 0, invDragBarY)
        invDragBarFrame.Size = UDim2.new(0, invDragBarWidth, 0, invDragBarHeight)
        lastTarget = nil
        return
    end

    if not force and lastTarget == targetPlr then
        local hotbarHash = hashToolList(cachedHotbar)
        local armorHash = hashArmorList(cachedArmor)
        local hashArr = {}
        for i, v in ipairs((cachedInventoryGrid and cachedInventoryGrid.flat) or {}) do
            if typeof(v) == "Instance" then
                hashArr[#hashArr+1] = (safeProp(v, "Name") or "") .. ":" .. (safeProp(v, "ClassName") or "")
            else
                hashArr[#hashArr+1] = tostring(v or "")
            end
        end
        local invHash = table.concat(hashArr, "#")
        if hotbarHash == lastHotbarHash and armorHash == lastArmorHash and invHash == lastInventoryHash then
            return
        end
    end

    clearGui()
    lastTarget = targetPlr

    if Toggles and Toggles.ArmorEnabled and Toggles.ArmorEnabled.Value then
        local armorY = getArmorY()
        cachedArmor = (function()
            local armorItems = {}
            local char = safeProp(targetPlr, "Character")
            local backpack = safeProp(targetPlr, "Backpack")
            local usedObjects = {}
            local index = 1

            if char then
                for groupIdx, group in ipairs(armorPriority) do
                    local foundOnChar = nil
                    local foundName = nil
                    for _, armorName in ipairs(group) do
                        for _, obj in ipairs(safeGetChildren(char)) do
                            local nameLower = (safeProp(obj, "Name") or ""):lower()
                            local matchLower = armorName:lower()
                            if (nameLower == matchLower or nameLower:find(matchLower))
                                and (safeProp(obj, "ClassName") ~= "Shirt")
                                and (safeProp(obj, "ClassName") ~= "Pants")
                                and (safeProp(obj, "ClassName") ~= "ShirtGraphic")
                                and not usedObjects[obj]
                            then
                                foundOnChar = obj
                                foundName = armorName
                                usedObjects[obj] = true
                                break
                            end
                        end
                        if foundOnChar then break end
                    end
                    if foundOnChar and index <= armorCount then
                        local assetObj = nil
                        if backpack then
                            for _, obj in ipairs(safeGetChildren(backpack)) do
                                local nameLower = (safeProp(obj, "Name") or ""):lower()
                                local matchLower = foundName:lower()
                                if nameLower == matchLower or nameLower:find(matchLower) then
                                    assetObj = obj
                                    break
                                end
                            end
                        end
                        armorItems[index] = {
                            displayObj = foundOnChar,
                            assetObj = assetObj
                        }
                        index = index + 1
                    end
                end
            end
            for i = 1, armorCount do
                armorItems[i] = armorItems[i] or nil
            end
            return armorItems
        end)()
        lastArmorHash = hashArmorList(cachedArmor)
        local activeTool = (function()
            local char = safeProp(targetPlr, "Character")
            if char then
                for _, obj in ipairs(safeGetChildren(char)) do
                    if safeIsA(obj, "Tool") then
                        return obj
                    end
                end
            end
            return nil
        end)()
        for i = 1, armorCount do
            local x = armorStartX + (i-1)*(slotW + slotGapX) + (dragBarX - hotbarStartX)
            local armorItem = cachedArmor[i]
            local isActive = armorItem and armorItem.displayObj and activeTool and armorItem.displayObj == activeTool
            local assetId = nil
            local count = nil
            if armorItem then
                if armorItem.assetObj then
                    assetId = findAssetIdDeep(armorItem.assetObj)
                    count = getItemCount(armorItem.assetObj)
                end
            end
            makeSlot(x, armorY, assetId, 20, count, isActive, true, false)
        end
    end

    hotbarToolsSet = {}
    if Toggles and Toggles.HotbarEnabled and Toggles.HotbarEnabled.Value then
        local hotbarY = getHotbarY()
        cachedHotbar = (function()
            local toolItems = {}
            local backpack = safeProp(targetPlr, "Backpack")
            local char = safeProp(targetPlr, "Character")
            local allTools = {}
            local activeTool = nil

            if char then
                for _, tool in ipairs(safeGetChildren(char)) do
                    if safeIsA(tool, "Tool") and not isArmor(tool) then
                        activeTool = tool
                    end
                end
            end

            if backpack then
                for _, tool in ipairs(safeGetChildren(backpack)) do
                    if safeIsA(tool, "Tool") and not isArmor(tool) and tool ~= activeTool then
                        table.insert(allTools, tool)
                    end
                end
            end
            if char then
                for _, tool in ipairs(safeGetChildren(char)) do
                    if safeIsA(tool, "Tool") and not isArmor(tool) and tool ~= activeTool then
                        table.insert(allTools, tool)
                    end
                end
            end

            local slotIndex = 1
            if activeTool then
                toolItems[slotIndex] = activeTool
                slotIndex = slotIndex + 1
            end

            for _, tool in ipairs(allTools) do
                if slotIndex <= hotbarCount then
                    toolItems[slotIndex] = tool
                    slotIndex = slotIndex + 1
                end
            end

            for i = 1, hotbarCount do
                toolItems[i] = toolItems[i] or nil
            end

            return toolItems
        end)()
        lastHotbarHash = hashToolList(cachedHotbar)
        local activeTool = (function()
            local char = safeProp(targetPlr, "Character")
            if char then
                for _, obj in ipairs(safeGetChildren(char)) do
                    if safeIsA(obj, "Tool") then
                        return obj
                    end
                end
            end
            return nil
        end)()
        for i = 1, hotbarCount do
            local x = hotbarStartX + (i-1)*(slotW + slotGapX) + (dragBarX - hotbarStartX)
            local toolObj = cachedHotbar[i]
            if toolObj then hotbarToolsSet[toolObj] = true end
            local isActive = toolObj and activeTool and toolObj == activeTool
            local assetId = toolObj and findAssetIdDeep(toolObj) or nil
            local count = getItemCount(toolObj)
            makeSlot(x, hotbarY, assetId, 20, count, isActive, false, false)
        end
    end

    if inventoryBarEnabled then
        local invStartY = getInventoryY()
        local invList = inventoryListFromTarget(targetPlr, hotbarToolsSet)
        local idx = 1
        if inventoryOnlyFilled then
            for _, obj in ipairs(invList) do
                local assetId = obj and findAssetIdDeep(obj) or nil
                local count = getItemCount(obj)
                makeSlot(
                    invBarStartX + ((idx-1)%invBarCols)*(slotW + slotGapX) + (invDragBarX - invBarStartX),
                    invStartY + (math.floor((idx-1)/invBarCols))*(slotH + slotGapY),
                    assetId,
                    20, count or "1", false, false, true
                )
                idx = idx + 1
            end
        else
            for row = 1, invBarRows do
                for col = 1, invBarCols do
                    local x = invBarStartX + (col-1)*(slotW + slotGapX) + (invDragBarX - invBarStartX)
                    local y = invStartY + (row-1)*(slotH + slotGapY)
                    local obj = invList[idx]
                    local assetId = obj and findAssetIdDeep(obj) or nil
                    local count = getItemCount(obj)
                    if obj then
                        makeSlot(x, y, assetId, 20, count or "1", false, false, true)
                    else
                        makeSlot(x, y, nil, 20, nil, false, false, true)
                    end
                    idx = idx + 1
                end
            end
        end
    end

    dragBarFrame.Visible = Toggles and Toggles.DragModeEnabled and Toggles.DragModeEnabled.Value
    dragBarFrame.Position = UDim2.new(0, dragBarX, 0, dragBarY)
    dragBarFrame.Size = UDim2.new(0, dragBarWidth, 0, dragBarHeight)

    invDragBarFrame.Visible = Toggles and Toggles.InventoryDragModeEnabled and Toggles.InventoryDragModeEnabled.Value and inventoryBarEnabled
    invDragBarFrame.Position = UDim2.new(0, invDragBarX, 0, invDragBarY)
    invDragBarFrame.Size = UDim2.new(0, invDragBarWidth, 0, invDragBarHeight)
end

local function setupTargetConnections(targetPlr)
    disconnectConns(backpackConns)
    disconnectConns(charConns)
    if not targetPlr then return end

    local function onChange()
        renderSlots(true)
    end

    local function listenFolder(folder, conns)
        if not folder then return end
        local okc, children = pcall(function() return folder:GetChildren() end)
        if okc and children then
            for _, child in ipairs(children) do
                if safeIsA(child, "Folder") or safeIsA(child, "Model") then
                    listenFolder(child, conns)
                end
            end
        end
        table.insert(conns, folder.ChildAdded:Connect(onChange))
        table.insert(conns, folder.ChildRemoved:Connect(onChange))
    end

    local backpack = safeProp(targetPlr, "Backpack")
    if backpack then
        listenFolder(backpack, backpackConns)
    end
    local char = safeProp(targetPlr, "Character")
    if char then
        listenFolder(char, charConns)
    end
end

local dragging = false
local dragOffset = Vector2.new(0,0)
local invDragging = false
local invDragOffset = Vector2.new(0,0)

dragBarFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and dragBarFrame.Visible then
        dragging = true
        local mouse = UserInputService:GetMouseLocation()
        local guiPos = dragBarFrame.AbsolutePosition
        dragOffset = Vector2.new(mouse.X - guiPos.X, mouse.Y - guiPos.Y)
    end
end)
dragBarFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
invDragBarFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and invDragBarFrame.Visible then
        invDragging = true
        local mouse = UserInputService:GetMouseLocation()
        local guiPos = invDragBarFrame.AbsolutePosition
        invDragOffset = Vector2.new(mouse.X - guiPos.X, mouse.Y - guiPos.Y)
    end
end)
invDragBarFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        invDragging = false
    end
end)

local lastTargetPlr = nil
RunService.RenderStepped:Connect(function()
    if not shouldRender() then
        dragBarFrame.Visible = false
        invDragBarFrame.Visible = false
        clearGui()
        disconnectConns(backpackConns)
        disconnectConns(charConns)
        lastTargetPlr = nil
        lastTarget = nil
        return
    end

    local changed = false
    if Toggles and Toggles.DragModeEnabled and Toggles.DragModeEnabled.Value then
        if dragging then
            local mouse = UserInputService:GetMouseLocation()
            dragBarX = math.clamp(mouse.X - dragOffset.X, 0, screenW - dragBarWidth)
            dragBarY = math.clamp(mouse.Y - dragOffset.Y, 0, screenH - dragBarHeight - slotH*2 - slotGapY - 4)
            changed = true
        end
    end
    if Toggles and Toggles.InventoryDragModeEnabled and Toggles.InventoryDragModeEnabled.Value then
        if invDragging then
            local mouse = UserInputService:GetMouseLocation()
            invDragBarX = math.clamp(mouse.X - invDragOffset.X, 0, screenW - invDragBarWidth)
            invDragBarY = math.clamp(mouse.Y - invDragBarOffset.Y, 0, dragBarY - invDragBarHeight - invBarRows*slotH - 8)
            changed = true
        end
    end
    if changed then
        savePersistentPositions({
            dragBarX = dragBarX;
            dragBarY = dragBarY;
            invDragBarX = invDragBarX;
            invDragBarY = invDragBarY;
        })
        renderSlots(true)
    end

    local target = getCurrentTarget()
    if target and target ~= lastTargetPlr then
        setupTargetConnections(target)
        lastTargetPlr = target
        renderSlots(true)
    end
end)

player.CharacterAdded:Connect(function(char)
    task.spawn(function()
        local ok = pcall(function()
            screenGui = getPersistentGui()
            dragBarFrame = getDragBar()
            invDragBarFrame = getInvDragBar()
            clearGui()
            renderSlots(true)
        end)
    end)
end)

renderSlots(true)

local ChamsSettings = {
    Enabled = false,
    Type = "ForceField",
    UseColor = false,
    Color = Color3.fromRGB(0,255,255),
    Transparency = 0.2,
    IgnoreSights = false,
    IgnoreAttachments = false,
}

local SightKeywords = {'HolosightModel','Scope8xModel','Scope16xModel','HandmadeSightModel'}
local AttachmentKeywords = {'SilencerModel','MuzzleBrakeModel','GunFlashlightModel'}

local ToolOriginals = {}

local function IsIgnored(obj)
    if (ChamsSettings.IgnoreSights or ChamsSettings.IgnoreAttachments) and obj:IsA("Model") then
        if ChamsSettings.IgnoreSights then
            for _, kw in ipairs(SightKeywords) do
                if obj.Name:find(kw) then return true end
            end
        end
        if ChamsSettings.IgnoreAttachments then
            for _, kw in ipairs(AttachmentKeywords) do
                if obj.Name:find(kw) then return true end
            end
        end
    end
    if obj.Parent and obj.Parent:IsA("Model") then
        if ChamsSettings.IgnoreSights then
            for _, kw in ipairs(SightKeywords) do
                if obj.Parent.Name:find(kw) then return true end
            end
        end
        if ChamsSettings.IgnoreAttachments then
            for _, kw in ipairs(AttachmentKeywords) do
                if obj.Parent.Name:find(kw) then return true end
            end
        end
    end
    if ChamsSettings.IgnoreSights then
        for _, kw in ipairs(SightKeywords) do
            if obj.Name:find(kw) then return true end
        end
    end
    if ChamsSettings.IgnoreAttachments then
        for _, kw in ipairs(AttachmentKeywords) do
            if obj.Name:find(kw) then return true end
        end
    end
    return false
end

local function SaveOriginals(tool)
    ToolOriginals[tool] = ToolOriginals[tool] or {}
    for _, obj in ipairs(tool:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
            if not ToolOriginals[tool][obj] then
                ToolOriginals[tool][obj] = {
                    Material = obj.Material,
                    Color = obj.Color,
                    Transparency = obj.Transparency,
                    SurfaceAppearance = obj:FindFirstChildOfClass("SurfaceAppearance"),
                    Decals = {},
                    Textures = {},
                }
                for _, child in ipairs(obj:GetChildren()) do
                    if child:IsA("Decal") then
                        table.insert(ToolOriginals[tool][obj].Decals, child:Clone())
                    elseif child:IsA("Texture") then
                        table.insert(ToolOriginals[tool][obj].Textures, child:Clone())
                    end
                end
            end
        end
    end
end

local function RemoveChams(tool)
    if not tool or not ToolOriginals[tool] then return end
    for obj, orig in pairs(ToolOriginals[tool]) do
        if obj and obj.Parent then
            obj.Material = orig.Material
            obj.Color = orig.Color
            obj.Transparency = orig.Transparency
            if orig.SurfaceAppearance and not obj:FindFirstChildOfClass("SurfaceAppearance") then
                orig.SurfaceAppearance:Clone().Parent = obj
            end
            for _, child in ipairs(obj:GetChildren()) do
                if child:IsA("Decal") or child:IsA("Texture") then
                    child:Destroy()
                end
            end
            for _, decal in ipairs(orig.Decals) do
                if not obj:FindFirstChild(decal.Name) then
                    decal:Clone().Parent = obj
                end
            end
            for _, texture in ipairs(orig.Textures) do
                if not obj:FindFirstChild(texture.Name) then
                    texture:Clone().Parent = obj
                end
            end
        end
    end
    ToolOriginals[tool] = nil
end

local function RemoveChamsPart(obj, tool)
    if not ToolOriginals[tool] or not ToolOriginals[tool][obj] then return end
    local orig = ToolOriginals[tool][obj]
    obj.Material = orig.Material
    obj.Color = orig.Color
    obj.Transparency = orig.Transparency
    if orig.SurfaceAppearance and not obj:FindFirstChildOfClass("SurfaceAppearance") then
        orig.SurfaceAppearance:Clone().Parent = obj
    end
    for _, child in ipairs(obj:GetChildren()) do
        if child:IsA("Decal") or child:IsA("Texture") then
            child:Destroy()
        end
    end
    for _, decal in ipairs(orig.Decals) do
        if not obj:FindFirstChild(decal.Name) then
            decal:Clone().Parent = obj
        end
    end
    for _, texture in ipairs(orig.Textures) do
        if not obj:FindFirstChild(texture.Name) then
            texture:Clone().Parent = obj
        end
    end
end

local function ApplyChams(tool)
    if not tool or not tool:IsA("Tool") then return end
    if tool.Parent ~= LocalPlayer.Character then return end
    SaveOriginals(tool)
    for _, obj in ipairs(tool:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
            if obj.Transparency < 0.98 and not IsIgnored(obj) then
                obj.Material = Enum.Material.ForceField
                obj.Transparency = ChamsSettings.Transparency
                if ChamsSettings.UseColor then
                    obj.Color = ChamsSettings.Color
                end
                for _, child in ipairs(obj:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") or child:IsA("SurfaceAppearance") then
                        child:Destroy()
                    end
                end
                if obj:FindFirstChildOfClass("SurfaceAppearance") then
                    obj:FindFirstChildOfClass("SurfaceAppearance"):Destroy()
                end
            elseif IsIgnored(obj) then
                RemoveChamsPart(obj, tool)
            end
        end
    end
end

local function UpdateAllToolsChams()
    if not ChamsSettings.Enabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and tool.Parent == char then
            ApplyChams(tool)
        end
    end
end

local function RemoveAllToolsChams()
    local char = LocalPlayer.Character
    if not char then return end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            RemoveChams(tool)
        end
    end
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                RemoveChams(tool)
            end
        end
    end
end

local function ToolListener(char)
    char.ChildAdded:Connect(function(obj)
        if not ChamsSettings.Enabled then return end
        if obj:IsA("Tool") then
            ApplyChams(obj)
        end
    end)
    char.ChildRemoved:Connect(function(obj)
        if obj:IsA("Tool") then
            RemoveChams(obj)
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    ToolListener(char)
    if ChamsSettings.Enabled then
        UpdateAllToolsChams()
    end
end)

if LocalPlayer.Character then
    ToolListener(LocalPlayer.Character)
    if ChamsSettings.Enabled then
        UpdateAllToolsChams()
    end
end

local function BackpackListener(backpack)
    backpack.ChildAdded:Connect(function(obj)
        if not ChamsSettings.Enabled then RemoveChams(obj) end
    end)
end

local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
if backpack then BackpackListener(backpack) end
LocalPlayer.ChildAdded:Connect(function(obj)
    if obj:IsA("Backpack") then
        BackpackListener(obj)
    end
end)

local ChamsBox = Tabs.Visual:AddRightGroupbox('Chams')

ChamsBox:AddToggle('ChamsEnabled', {Text = 'Chams Enabled', Default = ChamsSettings.Enabled, Tooltip = 'remove and equip item to apply chams'})
    :OnChanged(function(v)
        ChamsSettings.Enabled = v
        if v then
            UpdateAllToolsChams()
        else
            RemoveAllToolsChams()
        end
    end)
ChamsBox:AddDropdown('ChamsType', {Text = 'Type', Values = {'ForceField'}, Default = 1})
    :OnChanged(function(val)
        ChamsSettings.Type = val
        UpdateAllToolsChams()
    end)
ChamsBox:AddToggle('ChamsUseColor', {Text = 'Use Color', Default = ChamsSettings.UseColor})
    :AddColorPicker('ChamsColor', {
        Default = ChamsSettings.Color,
        Title = 'Chams Color',
        Callback = function(val)
            ChamsSettings.Color = val
            UpdateAllToolsChams()
        end
    })
    :OnChanged(function(v)
        ChamsSettings.UseColor = v
        UpdateAllToolsChams()
    end)
ChamsBox:AddSlider('ChamsTransparency', {
    Text = 'Transparency',
    Min = 0,
    Max = 1,
    Default = ChamsSettings.Transparency,
    Rounding = 2
})
    :OnChanged(function(val)
        ChamsSettings.Transparency = val
        UpdateAllToolsChams()
    end)
ChamsBox:AddToggle('ChamsIgnoreSights', {Text = 'Ignore holosights & scopes', Default = ChamsSettings.IgnoreSights})
    :OnChanged(function(v)
        ChamsSettings.IgnoreSights = v
        UpdateAllToolsChams()
    end)
ChamsBox:AddToggle('ChamsIgnoreAttachments', {Text = 'Ignore attachments', Default = ChamsSettings.IgnoreAttachments})
    :OnChanged(function(v)
        ChamsSettings.IgnoreAttachments = v
        UpdateAllToolsChams()
    end)
local RightGroupBox = Tabs.Misc:AddRightGroupbox('Fly hack')

local minicopterFlyEnabled = false
local minicopterFlySpeed = 50

RightGroupBox:AddToggle('MinicopterFlyEnabled', {
    Text = 'Minicopter Fly BETA',
    Default = false,
})
:AddKeyPicker('MinicopterFlyKey', {
    Default = 'H',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Fly Mini',
    NoUI = false
})
:OnChanged(function(v)
    minicopterFlyEnabled = v
end)

task.spawn(function()
    while true do
        task.wait(0.03)
        local shouldEnable = Options.MinicopterFlyKey:GetState()
        if shouldEnable ~= Toggles.MinicopterFlyEnabled.Value then
            Toggles.MinicopterFlyEnabled:SetValue(shouldEnable)
        end
        if Library.Unloaded then break end
    end
end)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local HitSoundsBox = Tabs.Visual:AddRightGroupbox('Hit Sounds')

local HitSoundAssetIds = {
    ["None"] = "",
    ["Skeet"] = "rbxassetid://83717596220569",
    ["Sonic checkpoint"] = "rbxassetid://6817150445",
    ["Sonic.exe laugh"] = "rbxassetid://18379039436",
    ["Windows XP Error"] = "rbxassetid://9066167010",
    ["Minecraft Hit"] = "rbxassetid://8766809464",
    ["One sit nn dog"] = "rbxassetid://7380502345",
    ["Door Bell"] = "rbxassetid://131845870598154",
    ["Duck"] = "rbxassetid://1139819274",
    ["Mgs"] = "rbxassetid://81845122657643",
    ["Money"] = "rbxassetid://3020841054",
    ["Fart"] = "rbxassetid://4809574295",
    ["Meow"] = "rbxassetid://7148585764",
    ["byebye"] = "rbxassetid://70888261086432",
    ['Neverlose'] = "rbxassetid://8726881116",
    ['TF2'] = "rbxassetid://2868331684",
    ['Pop'] = "rbxassetid://198598793"
}

local HitSoundNames = {}
for k, _ in pairs(HitSoundAssetIds) do
    table.insert(HitSoundNames, k)
end

local HitSoundConfig = {
    Enabled = false,
    Choice = "None",
    AssetId = "",
    Volume = 1,
    OriginalSounds = {} 
}

local function isBodyAttachHitSound(sound)
    local parent = sound.Parent
    if not parent or parent.Name ~= "BodyAttach" then return false end
    if (sound.Name == "HitClient" or sound.Name == "HeadShotClient" or sound.Name == "HitCharacterClient") then
        local tool = parent.Parent
        if not tool or not tool:IsA("Tool") then return false end
        local char = tool.Parent
        if not char or not char:IsA("Model") then return false end
        return char == LocalPlayer.Character
    end
    return false
end

local function applyHitSound(assetId, volume)
    HitSoundConfig.AssetId = assetId
    HitSoundConfig.Volume = volume
    local char = LocalPlayer.Character
    if char and char:IsA("Model") then
        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA("Tool") then
                local bodyAttach = tool:FindFirstChild("BodyAttach")
                if bodyAttach then
                    local soundNames = {"HitClient", "HeadShotClient", "HitCharacterClient"}
                    for _, sName in ipairs(soundNames) do
                        local snd = bodyAttach:FindFirstChild(sName)
                        if snd and snd:IsA("Sound") then
                            if not HitSoundConfig.OriginalSounds[snd] then
                                HitSoundConfig.OriginalSounds[snd] = {SoundId = snd.SoundId, Volume = snd.Volume}
                            end
                            snd.SoundId = assetId ~= "" and assetId or HitSoundConfig.OriginalSounds[snd].SoundId
                            snd.Volume = volume
                        end
                    end
                end
            end
        end
    end
end

local function restoreOriginalHitSounds()
    for sound, data in pairs(HitSoundConfig.OriginalSounds) do
        if sound and sound:IsA("Sound") then
            sound.SoundId = data.SoundId
            sound.Volume = data.Volume
        end
    end
    HitSoundConfig.AssetId = ""
    HitSoundConfig.Volume = 1
end

HitSoundsBox:AddToggle('HitSoundEnabled', {
    Text = 'Hit Sound Enabled',
    Default = false
}):OnChanged(function(v)
    HitSoundConfig.Enabled = v
    if v then
        local chosen = HitSoundConfig.Choice or "None"
        local assetId = HitSoundAssetIds[chosen] or ""
        applyHitSound(assetId, HitSoundConfig.Volume)
    else
        restoreOriginalHitSounds()
    end
end)

HitSoundsBox:AddDropdown('HitSoundChoice', {
    Text = 'Hit Sound',
    Values = HitSoundNames,
    Default = 1,
    Multi = false
}):OnChanged(function(val)
    HitSoundConfig.Choice = val
    if HitSoundConfig.Enabled then
        local assetId = HitSoundAssetIds[val] or ""
        applyHitSound(assetId, HitSoundConfig.Volume)
    end
end)

HitSoundsBox:AddSlider('HitSoundVolume', {
    Text = 'Volume',
    Min = 0,
    Max = 100,
    Default = 100,
    Rounding = 0,
}):OnChanged(function(val)
    local volume = val / 100
    HitSoundConfig.Volume = volume
    if HitSoundConfig.Enabled then
        local assetId = HitSoundAssetIds[HitSoundConfig.Choice] or ""
        applyHitSound(assetId, volume)
    end
end)

local function handleTool(tool)
    local char = LocalPlayer.Character
    if not char or tool.Parent ~= char then return end
    local bodyAttach = tool:FindFirstChild("BodyAttach")
    if bodyAttach then
        local soundNames = {"HitClient", "HeadShotClient", "HitCharacterClient"}
        for _, sName in ipairs(soundNames) do
            local snd = bodyAttach:FindFirstChild(sName)
            if snd and snd:IsA("Sound") and HitSoundConfig.Enabled then
                if not HitSoundConfig.OriginalSounds[snd] then
                    HitSoundConfig.OriginalSounds[snd] = {SoundId = snd.SoundId, Volume = snd.Volume}
                end
                local assetId = HitSoundAssetIds[HitSoundConfig.Choice] or ""
                if assetId ~= "" then
                    snd.SoundId = assetId
                end
                snd.Volume = HitSoundConfig.Volume
            end
        end
    end
end

local function handleSound(sound)
    if isBodyAttachHitSound(sound) and HitSoundConfig.Enabled then
        if not HitSoundConfig.OriginalSounds[sound] then
            HitSoundConfig.OriginalSounds[sound] = {SoundId = sound.SoundId, Volume = sound.Volume}
        end
        local assetId = HitSoundAssetIds[HitSoundConfig.Choice] or ""
        if assetId ~= "" then
            sound.SoundId = assetId
        end
        sound.Volume = HitSoundConfig.Volume
    end
end

workspace.DescendantAdded:Connect(function(obj)
    if not HitSoundConfig.Enabled then return end
    if obj:IsA("Tool") then
        handleTool(obj)
    elseif obj:IsA("Sound") then
        handleSound(obj)
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    if HitSoundConfig.Enabled then
        local assetId = HitSoundAssetIds[HitSoundConfig.Choice] or ""
        applyHitSound(assetId, HitSoundConfig.Volume)
    end
end)

RightGroupBox:AddSlider('MinicopterFlySpeed', {
    Text = 'Minicopter Fly Speed',
    Min = 1,
    Max = 500,
    Default = minicopterFlySpeed,
    Rounding = 0,
}):OnChanged(function(val)
    minicopterFlySpeed = val
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")

local function getMinicopterSeat()
    if not LocalPlayer.Character then return end
    for _, part in ipairs(LocalPlayer.Character:GetChildren()) do
        if part:IsA("Humanoid") and part.SeatPart and (part.SeatPart:IsA("Seat") or part.SeatPart:IsA("VehicleSeat")) then
            return part.SeatPart
        end
    end
end

local function applyFlyPhysics(seat, camCF, moveDirection)
    if not seat:FindFirstChild("MinicopterFlyBodyGyro") then
        local g = Instance.new("BodyGyro")
        g.Name = "MinicopterFlyBodyGyro"
        g.P = 90000
        g.maxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
        g.Parent = seat
    end
    if not seat:FindFirstChild("MinicopterFlyBodyVelocity") then
        local v = Instance.new("BodyVelocity")
        v.Name = "MinicopterFlyBodyVelocity"
        v.maxForce = Vector3.new(9000000000, 9000000000, 9000000000)
        v.Parent = seat
    end

    local gyro = seat:FindFirstChild("MinicopterFlyBodyGyro")
    local velocity = seat:FindFirstChild("MinicopterFlyBodyVelocity")

    gyro.CFrame = CFrame.new(seat.Position, seat.Position + camCF.LookVector)
    velocity.Velocity = moveDirection * minicopterFlySpeed
end

function removeFlyPhysics(seat)
    local gyro = seat:FindFirstChild("MinicopterFlyBodyGyro")
    local velocity = seat:FindFirstChild("MinicopterFlyBodyVelocity")
    if gyro then gyro:Destroy() end
    if velocity then velocity:Destroy() end
end

Toggles.MinicopterFlyEnabled:OnChanged(function(v)
    minicopterFlyEnabled = v
    if not v then
        local seat = getMinicopterSeat()
        if seat then
            removeFlyPhysics(seat)
        end
    end
end)

RunService.RenderStepped:Connect(function(dt)
    if not Toggles.MinicopterFlyEnabled.Value then
        local seat = getMinicopterSeat()
        if seat then
            removeFlyPhysics(seat)
        end
        return
    end

    local seat = getMinicopterSeat()
    if not seat then return end

    local camera = workspace.CurrentCamera
    local camCF = camera.CFrame

    local moveDirection = Vector3.new(0,0,0)
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + camCF.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - camCF.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - camCF.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + camCF.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + camCF.UpVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection = moveDirection - camCF.UpVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDirection = moveDirection + camCF.UpVector end

    applyFlyPhysics(seat, camCF, moveDirection)
end)
flyEnabled = false
forceConnection = nil
targetY = nil

function setFly(state)
    flyEnabled = state

    local LocalPlayer = Players.LocalPlayer
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    if state then
        local pos = humanoidRootPart.Position
        targetY = pos.Y + FlyHeight 

        humanoidRootPart.CFrame = CFrame.lookAt(
            Vector3.new(pos.X, targetY, pos.Z),
            Vector3.new(pos.X, targetY, pos.Z) + humanoidRootPart.CFrame.LookVector
        )

        forceConnection = RunService.RenderStepped:Connect(function()
            if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then return end
            local currentPos = humanoidRootPart.Position
            local currentCF = humanoidRootPart.CFrame
            humanoidRootPart.Velocity = Vector3.new(humanoidRootPart.Velocity.X, 0, humanoidRootPart.Velocity.Z)
            humanoidRootPart.CFrame = CFrame.lookAt(
                Vector3.new(currentPos.X, targetY, currentPos.Z),
                Vector3.new(currentPos.X, targetY, currentPos.Z) + currentCF.LookVector
            )
        end)
    else
        if forceConnection then
            forceConnection:Disconnect()
            forceConnection = nil
        end
        local pos = humanoidRootPart.Position
        local rayOrigin = Vector3.new(pos.X, pos.Y + 2, pos.Z)
        local rayDirection = Vector3.new(0, -1000, 0)
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {character}
        params.FilterType = Enum.RaycastFilterType.Blacklist
        local result = workspace:Raycast(rayOrigin, rayDirection, params)
        local groundY = result and result.Position.Y or 0
        humanoidRootPart.CFrame = CFrame.lookAt(
            Vector3.new(pos.X, groundY + 4, pos.Z),
            Vector3.new(pos.X, groundY + 4, pos.Z) + humanoidRootPart.CFrame.LookVector
        )
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.PlatformStanding)
            task.wait(0.2)
            humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end

RightGroupBox:AddToggle('FlyEnabled', {
    Text = 'Fly simple',
    Default = false,
})
:AddKeyPicker('FlyKey', {
    Default = 'F',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Fly Simple',
    NoUI = false
})
:OnChanged(function(v)
    setFly(v)
end)

task.spawn(function()
    while true do
        task.wait(0.03)
        local shouldEnable = Options.FlyKey:GetState()
        if shouldEnable ~= Toggles.FlyEnabled.Value then
            Toggles.FlyEnabled:SetValue(shouldEnable)
        end
        if Library.Unloaded then break end
    end
end)

RightGroupBox:AddSlider('FlyHeight', {
    Text = 'Fly Height',
    Min = 5,
    Max = 500,
    Default = 40,
    Rounding = 0,
}):OnChanged(function(val)
    FlyHeight = val
    if flyEnabled then
        setFly(true)
    end
end)

Toggles.FlyEnabled:OnChanged(function(v)
    setFly(v)
end)

Options.FlyKey:OnClick(function()
    Toggles.FlyEnabled:SetValue(not Toggles.FlyEnabled.Value)
end)
MovementBox = Tabs.Misc:AddLeftGroupbox('Movement')

frogJumpSpeedActive = false
frogJumpSpeedValue = 40 
frogJumpSpeedMin = 20
frogJumpSpeedMax = 100

MovementBox:AddToggle('FrogJumpSpeed', {Text = 'Speedhack BETA', Default = false})
    :AddKeyPicker('FrogJumpSpeedKey', {
        Default = 'Zero',
        SyncToggleState = true,
        Mode = 'Toggle',
        Text = 'Speedhack Jump',
        NoUI = false
    })
    :OnChanged(function(v)
        frogJumpSpeedActive = v
    end)

task.spawn(function()
    while true do
        task.wait(0.03)
        local shouldEnable = Options.FrogJumpSpeedKey:GetState()
        if shouldEnable ~= Toggles.FrogJumpSpeed.Value then
            Toggles.FrogJumpSpeed:SetValue(shouldEnable)
        end
        if Library.Unloaded then break end
    end
end)

MovementBox:AddSlider('FrogJumpSpeedValue', {
    Text = 'Speedhack Value',
    Min = frogJumpSpeedMin,
    Max = frogJumpSpeedMax,
    Default = frogJumpSpeedValue,
    Rounding = 0
}):OnChanged(function(val)
    frogJumpSpeedValue = val
end)

function unstuckIfStuck(humanoid, root)
    if humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        local rayOrigin = root.Position
        local rayDir = Vector3.new(0, -5, 0)
        local params = RaycastParams.new()
        params.FilterDescendantsInstances = {root.Parent}
        params.FilterType = Enum.RaycastFilterType.Blacklist
        local rayResult = workspace:Raycast(rayOrigin, rayDir, params)
        if not rayResult then
            root.CFrame = root.CFrame + Vector3.new(0, -0.5, 0)
        end
    end
end

Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
RunService = game:GetService("RunService")

function isJumping(humanoid)
    return humanoid:GetState() == Enum.HumanoidStateType.Freefall
end

frogJumpConnection = nil

Toggles.FrogJumpSpeed:OnChanged(function(v)
    frogJumpSpeedActive = v
    if frogJumpConnection then
        frogJumpConnection:Disconnect()
        frogJumpConnection = nil
    end
    if v then
        frogJumpConnection = RunService.RenderStepped:Connect(function(dt)
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local root = character:FindFirstChild("HumanoidRootPart")
                if humanoid and root then
                    if isJumping(humanoid) then
                        local moveDir = humanoid.MoveDirection
                        if moveDir.Magnitude > 0 then
                            root.CFrame = root.CFrame + moveDir * frogJumpSpeedValue * dt
                        end
                        unstuckIfStuck(humanoid, root)
                    end
                end
            end
        end)
    end
end)
normalSpeedActive = false
normalSpeedValue = 40 
normalSpeedConnection = nil

CrosshairBox = Tabs.Misc:AddRightGroupbox('Crosshair')

crosshairTypes = {"Cross", "Dot", "Swastika"}
positionTypes = {"Mouse", "Camera"}
CrosshairSettings = {
    Enabled = false,
    Type = "Cross",
    Color = Color3.fromRGB(255,255,255),
    Size = 12,
    SpreadEnabled = true,
    Spread = 4,
    Animate = false,
    AnimateSpeed = 2,
    Rainbow = false,
    Thickness = 2,
    TextEnabled = false,
    Text = "VeryUp Private",
    TextSize = 15,
    TextColor = Color3.fromRGB(255,255,255),
    RainbowText = false,
    TextOutline = false,
    Position = "Mouse",
    YOffset = 0 
}

CrosshairBox:AddToggle('CrosshairEnabled', {Text = 'Enabled', Default = false})
    :AddColorPicker('CrosshairColor', {
        Default = CrosshairSettings.Color,
        Title = 'Crosshair Color',
        Callback = function(val) CrosshairSettings.Color = val end
    })
    :OnChanged(function(v) CrosshairSettings.Enabled = v end)

CrosshairBox:AddDropdown('CrosshairType', {
    Text = 'Type',
    Values = crosshairTypes,
    Default = 1,
    Multi = false
}):OnChanged(function(val)
    CrosshairSettings.Type = val
end)

CrosshairBox:AddSlider('CrosshairSize', {
    Text = 'Size',
    Min = 1,
    Max = 32,
    Default = CrosshairSettings.Size,
    Rounding = 0
}):OnChanged(function(val)
    CrosshairSettings.Size = val
end)

CrosshairBox:AddSlider('CrosshairThickness', {
    Text = 'Thickness',
    Min = 1,
    Max = 8,
    Default = CrosshairSettings.Thickness,
    Rounding = 0
}):OnChanged(function(val)
    CrosshairSettings.Thickness = val
end)

CrosshairBox:AddToggle('CrosshairRainbow', {Text = 'Rainbow', Default = false})
    :OnChanged(function(v)
        CrosshairSettings.Rainbow = v
    end)

CrosshairBox:AddToggle('CrosshairSpreadEnabled', {Text = 'Spread', Default = true})
    :OnChanged(function(v)
        CrosshairSettings.SpreadEnabled = v
    end)
CrosshairBox:AddSlider('CrosshairSpread', {
    Text = 'Spread',
    Min = 1,
    Max = 12,
    Default = CrosshairSettings.Spread,
    Rounding = 0
}):OnChanged(function(val)
    CrosshairSettings.Spread = val
end)

CrosshairBox:AddToggle('CrosshairAnimate', {Text = 'Spin', Default = false})
    :OnChanged(function(v)
        CrosshairSettings.Animate = v
    end)
CrosshairBox:AddSlider('CrosshairAnimateSpeed', {
    Text = 'Spin Speed',
    Min = 1,
    Max = 10,
    Default = CrosshairSettings.AnimateSpeed,
    Rounding = 1
}):OnChanged(function(val)
    CrosshairSettings.AnimateSpeed = val
end)

CrosshairBox:AddDropdown('CrosshairPosition', {
    Text = 'Position',
    Values = positionTypes,
    Default = 1,
    Multi = false
}):OnChanged(function(val)
    CrosshairSettings.Position = val
end)

CrosshairBox:AddSlider('CrosshairYOffset', {
    Text = 'Vertical Offset',
    Min = -200,
    Max = 200,
    Default = 0,
    Rounding = 0,
}):OnChanged(function(val)
    CrosshairSettings.YOffset = val
end)

CrosshairBox:AddToggle('CrosshairTextEnabled', {Text = 'Text', Default = false})
    :AddColorPicker('CrosshairTextColor', {
        Default = CrosshairSettings.TextColor,
        Title = 'Text Color',
        Callback = function(val) CrosshairSettings.TextColor = val end
    })
    :OnChanged(function(v)
        CrosshairSettings.TextEnabled = v
    end)
CrosshairBox:AddSlider('CrosshairTextSize', {
    Text = 'Text Size',
    Min = 8,
    Max = 32,
    Default = CrosshairSettings.TextSize,
    Rounding = 0
}):OnChanged(function(val)
    CrosshairSettings.TextSize = val
end)
CrosshairBox:AddToggle('CrosshairRainbowText', {Text = 'Text Rainbow', Default = false})
    :OnChanged(function(v)
        CrosshairSettings.RainbowText = v
    end)
CrosshairBox:AddToggle('CrosshairTextOutline', {Text = 'Text Outline', Default = false})
    :OnChanged(function(v)
        CrosshairSettings.TextOutline = v
    end)

RunService = game:GetService("RunService")
UserInputService = game:GetService("UserInputService")
workspace = game:GetService("Workspace")

lines = {}
dot = nil
textObj = nil

function getCenter()
    if CrosshairSettings.Position == "Camera" then
        local cam = workspace.CurrentCamera
        local v = cam.ViewportSize / 2
        return v.X, v.Y
    else
        local mouse = UserInputService:GetMouseLocation()
        return mouse.X, mouse.Y
    end
end

function getGlobalRainbowColor()
    local t = tick() * 0.7
    return Color3.fromHSV(t % 1, 1, 1)
end

math_sin, math_cos, math_atan, math_rad, math_deg = math.sin, math.cos, math.atan, math.rad, math.deg

function drawCross(x, y, size, spread, angle, color, thickness)
    for i = 1, 4 do
        if not lines[i] then lines[i] = Drawing.new("Line") end
    end
    local dirs = {
        Vector2.new(0, -1),
        Vector2.new(1, 0),
        Vector2.new(0, 1),
        Vector2.new(-1, 0)
    }
    for i = 1, 4 do
        local dir = dirs[i]
        local a = math.rad(angle)
        local cs, sn = math.cos(a), math.sin(a)
        local dx, dy = dir.X, dir.Y
        dx, dy = dx * cs - dy * sn, dx * sn + dy * cs
        local from = Vector2.new(x + dx * (spread + size), y + dy * (spread + size))
        local to   = Vector2.new(x + dx * spread, y + dy * spread)
        lines[i].From = from
        lines[i].To = to
        lines[i].Color = color
        lines[i].Visible = true
        lines[i].Transparency = 1
        lines[i].Thickness = thickness
        lines[i].ZIndex = 2
    end
    for i = 5, #lines do if lines[i] then lines[i].Visible = false end end
end

function drawSwastika(x, y, size, spread, angle, color, thickness)
    for i = 1, 8 do
        if not lines[i] then lines[i] = Drawing.new("Line") end
    end
    local a = size
    local gamma = math_atan(a / a)
    local rotationdegree = angle % 90
    local DEG2RAD = math_rad
    local RAD2DEG = math_deg

    for i = 1, 4 do
        local p_0 = (a * math_sin(DEG2RAD(rotationdegree + (i * 90))))
        local p_1 = (a * math_cos(DEG2RAD(rotationdegree + (i * 90))))
        local p_2 = ((a / math_cos(gamma)) * math_sin(DEG2RAD(rotationdegree + (i * 90) + RAD2DEG(gamma))))
        local p_3 = ((a / math_cos(gamma)) * math_cos(DEG2RAD(rotationdegree + (i * 90) + RAD2DEG(gamma))))

        lines[i].From = Vector2.new(x, y)
        lines[i].To   = Vector2.new(x + p_0, y - p_1)
        lines[i].Color = color
        lines[i].Visible = true
        lines[i].Transparency = 1
        lines[i].Thickness = thickness
        lines[i].ZIndex = 2

        lines[i+4].From = Vector2.new(x + p_0, y - p_1)
        lines[i+4].To   = Vector2.new(x + p_2, y - p_3)
        lines[i+4].Color = color
        lines[i+4].Visible = true
        lines[i+4].Transparency = 1
        lines[i+4].Thickness = thickness
        lines[i+4].ZIndex = 2
    end
    for i = 9, #lines do if lines[i] then lines[i].Visible = false end end
end

RunService.RenderStepped:Connect(function()
    for _, l in ipairs(lines) do l.Visible = false end
    if dot then dot.Visible = false end
    if textObj then textObj.Visible = false end
    if not CrosshairSettings.Enabled then return end

    local x, y = getCenter()
    y = y + CrosshairSettings.YOffset

    local size = CrosshairSettings.Size
    local spread = CrosshairSettings.SpreadEnabled and CrosshairSettings.Spread or 0
    local animate = CrosshairSettings.Animate
    local animateSpeed = CrosshairSettings.AnimateSpeed
    local type = CrosshairSettings.Type
    local angle = (animate and (type == "Cross" or type == "Swastika")) and ((tick() * animateSpeed * 65) % 90) or 0
    local baseColor = CrosshairSettings.Rainbow and getGlobalRainbowColor() or CrosshairSettings.Color
    local thickness = CrosshairSettings.Thickness

    if type == "Dot" then
        if not dot then
            dot = Drawing.new("Circle")
            dot.Filled = true
        end
        dot.Position = Vector2.new(x, y)
        dot.Radius = size / 2
        dot.Color = baseColor
        dot.Visible = true
        dot.Transparency = 1
        dot.Thickness = thickness
    elseif type == "Cross" then
        drawCross(x, y, size, spread, angle, baseColor, thickness)
    elseif type == "Swastika" then
        drawSwastika(x, y, size, spread, angle, baseColor, thickness)
    end

    if CrosshairSettings.TextEnabled then
        if not textObj then
            textObj = Drawing.new("Text")
        end
        textObj.Center = true
        textObj.Text = CrosshairSettings.Text
        textObj.Size = CrosshairSettings.TextSize
        textObj.Position = Vector2.new(x, y + size + 18)
        textObj.Visible = true
        textObj.Color = CrosshairSettings.RainbowText and getGlobalRainbowColor() or CrosshairSettings.TextColor
        textObj.Transparency = 1
        textObj.Outline = CrosshairSettings.TextOutline
    end
end)
MovementBox:AddToggle('WaterSpeedEnabled', {
    Text = 'Speed Water (Swim)',
    Default = false,
})
:AddKeyPicker('WaterSpeedKey', {
    Default = 'C',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Water Speed',
    NoUI = false
})
:OnChanged(function(v)
end)

task.spawn(function()
    while true do
        task.wait(0.03)
        local shouldEnable = Options.WaterSpeedKey:GetState()
        if shouldEnable ~= Toggles.WaterSpeedEnabled.Value then
            Toggles.WaterSpeedEnabled:SetValue(shouldEnable)
        end
        if Library.Unloaded then break end
    end
end)

MovementBox:AddSlider('WaterSpeedValue', {
    Text = 'Swim Speed',
    Min = 20,
    Max = 250,
    Default = 70,
    Rounding = 0,
}):OnChanged(function(val)
    _G.WaterSpeedValue = val
end)

_G.WaterSpeedValue = Options.WaterSpeedValue and Options.WaterSpeedValue.Value or 70

Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
RunService = game:GetService("RunService")
applyForceName = "WaterSwimVelocity"

waterSpeedConnection = nil

Toggles.WaterSpeedEnabled:OnChanged(function(v)
    if waterSpeedConnection then
        waterSpeedConnection:Disconnect()
        waterSpeedConnection = nil
    end

    if v then
        waterSpeedConnection = RunService.RenderStepped:Connect(function(dt)
            local character = LocalPlayer.Character
            if not character then return end

            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local root = character:FindFirstChild("HumanoidRootPart")
            if not humanoid or not root then return end

            if humanoid:GetState() == Enum.HumanoidStateType.Swimming then
                local velocity = root:FindFirstChild(applyForceName)
                if not velocity then
                    velocity = Instance.new("BodyVelocity")
                    velocity.Name = applyForceName
                    velocity.MaxForce = Vector3.new(100000, 100000, 100000)
                    velocity.Parent = root
                end
                velocity.Velocity = humanoid.MoveDirection * (_G.WaterSpeedValue or 70)
            else
                local velocity = root:FindFirstChild(applyForceName)
                if velocity then velocity:Destroy() end
            end
        end)
    else
        local character = LocalPlayer.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local velocity = root:FindFirstChild(applyForceName)
                if velocity then velocity:Destroy() end
            end
        end
    end
end)

getgenv().DesyncEnabled = getgenv().DesyncEnabled or false
if getgenv().DesyncConnection then
    getgenv().DesyncConnection:Disconnect()
    getgenv().DesyncConnection = nil
end
local forceWalkConnection
local forceWalkSavedSpeed
FORCE_WALK_SPEED = 26

function getHumanoid()
    local char = Players.LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

function applyForceWalk()
    if forceWalkConnection then
        forceWalkConnection:Disconnect()
        forceWalkConnection = nil
    end
    local humanoid = getHumanoid()
    if humanoid then
        forceWalkSavedSpeed = humanoid.WalkSpeed
        forceWalkConnection = RunService.RenderStepped:Connect(function()
            local h = getHumanoid()
            if h and h.WalkSpeed ~= FORCE_WALK_SPEED then
                h.WalkSpeed = FORCE_WALK_SPEED
            end
        end)
    end
end

function removeForceWalk()
    if forceWalkConnection then
        forceWalkConnection:Disconnect()
        forceWalkConnection = nil
    end
    local humanoid = getHumanoid()
    if humanoid and forceWalkSavedSpeed then
        humanoid.WalkSpeed = forceWalkSavedSpeed
    end
    forceWalkSavedSpeed = nil
end

MovementBox:AddToggle('ForceWalkEnabled', {Text = 'Force Walk', Default = false})
    :AddKeyPicker('ForceWalkKey', {
        Default = 'None',
        SyncToggleState = true, 
        Mode = 'Toggle',
        Text = 'Force Walk',
        NoUI = false
    })
    :OnChanged(function(state)
        if state then
            applyForceWalk()
        else
            removeForceWalk()
        end
    end)

MovementBox:AddSlider('ForceWalkSpeed', {
    Text = 'Force Walk Speed',
    Min = 16,
    Max = 26,
    Default = 26,
    Rounding = 0,
}):OnChanged(function(val)
    FORCE_WALK_SPEED = val
end)

Players.LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid", 5)
    if Toggles.ForceWalkEnabled and Toggles.ForceWalkEnabled.Value then
        applyForceWalk()
    else
        removeForceWalk()
    end
end)
function clearUnwantedScripts(character)
    for _, v in pairs(character:GetChildren()) do
        if v:IsA("Script") and v.Name ~= "Health" and v.Name ~= "Sound" and v:FindFirstChild("LocalScript") then
            v:Destroy()
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    repeat task.wait() until char
    clearUnwantedScripts(char)
    char.ChildAdded:Connect(function(child)
        if child:IsA("Script") and child:FindFirstChild("LocalScript") then
            task.wait(0.25)
            child.LocalScript:FireServer()
        end
    end)
end)

function setDesync(state)
    getgenv().DesyncEnabled = state
    if getgenv().DesyncConnection then
        getgenv().DesyncConnection:Disconnect()
        getgenv().DesyncConnection = nil
    end
    if state then
        getgenv().DesyncConnection = RunService.Heartbeat:Connect(function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                pcall(function()
                    local currentVelocity = hrp.Velocity
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(0.0001), 0)
                    hrp.AssemblyLinearVelocity = Vector3.new(math.random(2000, 4000), math.random(2000, 4000), math.random(2000, 4000))
                    RunService.RenderStepped:Wait()
                    hrp.Velocity = currentVelocity
                end)
            end
        end)
    end
end

MovementBox:AddToggle('DesyncEnabled', {
    Text = 'Desync',
    Default = getgenv().DesyncEnabled,
})
:AddKeyPicker('DesyncKey', {
    Default = 'Delete',
    SyncToggleState = true,
    Mode = 'Toggle',
    Text = 'Desync Hotkey',
    NoUI = false
})
:OnChanged(function(v)
    setDesync(v)
end)

task.spawn(function()
    while true do
        task.wait(0.03)
        local shouldEnable = Options.DesyncKey:GetState()
        if shouldEnable ~= Toggles.DesyncEnabled.Value then
            Toggles.DesyncEnabled:SetValue(shouldEnable)
        end
        if Library and Library.Unloaded then break end
    end
end)

UIBox = Tabs['UI Settings']:AddRightGroupbox('UI')
WaterMarkBox = Tabs['UI Settings']:AddRightGroupbox('Water Mark')

WaterMarkBox:AddToggle('WaterMarkEnabled', {Text = 'Water mark enabled', Default = true})

WaterMarkConnection = nil

function UpdateWaterMark()
    local FrameTimer = tick()
    local FrameCounter = 0
    local FPS = 60

    if WaterMarkConnection then
        WaterMarkConnection:Disconnect()
        WaterMarkConnection = nil
    end

    WaterMarkConnection = RunService.RenderStepped:Connect(function()
        if not (Toggles.WaterMarkEnabled and Toggles.WaterMarkEnabled.Value) then
            Library:SetWatermarkVisibility(false)
            return
        end

        FrameCounter += 1
        if (tick() - FrameTimer) >= 1 then
            FPS = FrameCounter
            FrameTimer = tick()
            FrameCounter = 0
        end

        local now = os.date("*t")
        local dateStr = string.format("%02d.%02d.%02d", now.day, now.month, now.year % 100)
        local timeStr = string.format("%02d:%02d:%02d", now.hour, now.min, now.sec)
        local ping = math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())

        Library:SetWatermark(string.format(
            "VeryUp Private | %s | %s | %s fps | %s ms",
            dateStr,
            timeStr,
            math.floor(FPS),
            ping
        ))
        Library:SetWatermarkVisibility(true)
    end)
end

Toggles.WaterMarkEnabled:OnChanged(function(v)
    if v then
        Library:SetWatermarkVisibility(true)
        UpdateWaterMark()
    else
        Library:SetWatermarkVisibility(false)
        if WaterMarkConnection then WaterMarkConnection:Disconnect() end
        WaterMarkConnection = nil
    end
end)

if Toggles.WaterMarkEnabled.Value then
    Library:SetWatermarkVisibility(true)
    UpdateWaterMark()
end
UIBox:AddToggle('ShowKeybinds', {Text = 'Keybinds', Default = true}):OnChanged(function(v)
    Library.KeybindFrame.Visible = v
end)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder('VeryUp')
SaveManager:SetFolder('VeryUp/rost')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()

DrawingFont = Drawing.Fonts.Plex
ESPObjects = {}

function GetHealth(model)
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid then
        return humanoid.Health, humanoid.MaxHealth
    end
    local healthObj = model:FindFirstChild("Health")
    local maxObj = model:FindFirstChild("MaxHealth")
    if healthObj and (healthObj:IsA("IntValue") or healthObj:IsA("NumberValue")) then
        local maxhp = maxObj and maxObj.Value or 100
        return healthObj.Value, maxhp
    end
    return nil
end
function GetEquippedWeapon(model)
    for _, child in ipairs(model:GetChildren()) do
        if child:IsA("Tool") then
            local name = child.Name
            local count = 1
            if child.ToolTip then
                local found = tostring(child.ToolTip):match("%d+")
                if found then count = tonumber(found) end
            end
            if count == 1 then
                return name
            elseif count > 1 then
                return name .. " x" .. tostring(count)
            else
                return name
            end
        end
    end
    for _, child in ipairs(model:GetChildren()) do
        if child:IsA("Model") and child.Name ~= "Appearance" then
            local name = child.Name
            local count = 1
            if child.ToolTip then
                local found = tostring(child.ToolTip):match("%d+")
                if found then count = tonumber(found) end
            end
            if count == 1 then
                return name
            elseif count > 1 then
                return name .. " x" .. tostring(count)
            else
                return name
            end
        end
    end
    return "None"
end
function GetDist(localPos, targetPos)
    return (localPos - targetPos).Magnitude
end
function GetHealthColor(Health, MaxHealth)
    local p = Health / MaxHealth
    if p > 0.65 then
        return Color3.fromRGB(40, 255, 40)
    elseif p > 0.35 then
        return Color3.fromRGB(255, 200, 0)
    else
        return Color3.fromRGB(255, 40, 40)
    end
end

function StaticBoxParts(character)
    local Camera = workspace.CurrentCamera
    local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
    local any = false
    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            local v2, onScreen = Camera:WorldToViewportPoint(part.Position)
            if onScreen then
                minX = math.min(minX, v2.X)
                maxX = math.max(maxX, v2.X)
                minY = math.min(minY, v2.Y)
                maxY = math.max(maxY, v2.Y)
                any = true
            end
        end
    end
    if not any then return end
    local boxPos = Vector2.new(minX, minY)
    local boxSize = Vector2.new(maxX - minX, maxY - minY)
    return boxPos, boxSize
end

whitelistKeywords = {"TwigWall","SoloTwigFrame","TrigTwigRoof","TwigFrame","TwigWindow","TwigRoof"}
function isWhitelisted(name)
    for _, keyword in ipairs(whitelistKeywords) do
        if string.find(name, keyword) then return true end
    end
    return false
end

xrayTargets = {}

function registerForXray(obj)
    if xrayTargets[obj] then return end
    if (obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation")) then
        if isWhitelisted(obj.Name) then
            xrayTargets[obj] = {OriginalTransparency = obj.Transparency}
        end
    end
    for _, desc in pairs(obj:GetDescendants()) do
        if (desc:IsA("BasePart") or desc:IsA("MeshPart") or desc:IsA("UnionOperation")) then
            if isWhitelisted(desc.Name) then
                xrayTargets[desc] = {OriginalTransparency = desc.Transparency}
            end
        end
    end
end

function initializeXray()
    for _, obj in pairs(workspace:GetDescendants()) do
        if isWhitelisted(obj.Name) then
            registerForXray(obj)
        end
    end
end

function setXrayState(enabled, transparency)
    for part, data in pairs(xrayTargets) do
        if part and part:IsDescendantOf(workspace) then
            if enabled then
                part.Transparency = transparency
            else
                part.Transparency = data.OriginalTransparency
            end
        end
    end
end

if not getgenv()._XRayListenerConnected then
    getgenv()._XRayListenerConnected = true
    workspace.DescendantAdded:Connect(function(obj)
        if isWhitelisted(obj.Name) then
            task.delay(1, function() registerForXray(obj) end)
        end
    end)
end

initializeXray()


Options.XRayKey:OnClick(function()
    Toggles.XRay:SetValue(not Toggles.XRay.Value)
end)

Toggles.XRay:OnChanged(function(v)
    setXrayState(v, XRayOptions.Transparency)
    if v then
        if not getgenv()._XRayRender then
            getgenv()._XRayRender = RunService.RenderStepped:Connect(function()
                setXrayState(true, XRayOptions.Transparency)
            end)
        end
    else
        if getgenv()._XRayRender then
            getgenv()._XRayRender:Disconnect()
            getgenv()._XRayRender = nil
        end
    end
end)

Options.XRayTrans:OnChanged(function(v)
    XRayOptions.Transparency = v / 100
    if Toggles.XRay.Value then
        setXrayState(true, XRayOptions.Transparency)
    end
end)

if Toggles.XRay.Value then
    setXrayState(true, XRayOptions.Transparency)
end

GetPlayers = Players.GetPlayers
WorldToViewportPoint = Camera.WorldToViewportPoint
FindFirstChild = game.FindFirstChild
GetMouseLocation = UserInputService.GetMouseLocation

function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToViewportPoint(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

function getMousePosition()
    return GetMouseLocation(UserInputService)
end

function getClosestPlayer()
    local Closest, DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        local Character = Player.Character
        if not Character then continue end
        local TargetPart = FindFirstChild(Character, SilentAimSettings.TargetPart)
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not TargetPart or not Humanoid or Humanoid.Health <= 0 then continue end
        local ScreenPosition, OnScreen = getPositionOnScreen(TargetPart.Position)
        if not OnScreen then continue end
        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if SilentAimSettings.UseFOV then
            if Distance <= (DistanceToMouse or SilentAimSettings.FOVRadius) then
                Closest = TargetPart
                DistanceToMouse = Distance
            end
        else
            if DistanceToMouse == nil or Distance < DistanceToMouse then
                Closest = TargetPart
                DistanceToMouse = Distance
            end
        end
    end
    return Closest
end

function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

fov_circle = Drawing.new("Circle")
fov_circle.Thickness = 1
fov_circle.NumSides = 100
fov_circle.Radius = SilentAimSettings.FOVRadius
fov_circle.Filled = false
fov_circle.Visible = true
fov_circle.ZIndex = 999
fov_circle.Transparency = 1
fov_circle.Color = SilentAimSettings.FOVColor

fov_fill = Drawing.new("Circle")
fov_fill.Thickness = 0
fov_fill.NumSides = 100
fov_fill.Radius = SilentAimSettings.FOVRadius
fov_fill.Filled = true
fov_fill.Visible = false
fov_fill.ZIndex = 998
fov_fill.Color = SilentAimSettings.FOVFillColor
fov_fill.Transparency = SilentAimSettings.FOVFillTrans

snapline = Drawing.new("Line")
snapline.Visible = false
snapline.Thickness = SilentAimSettings.SnaplineThickness
snapline.Color = SilentAimSettings.SnaplineColor
snapline.ZIndex = 999
snapline.Transparency = 1

RunService.RenderStepped:Connect(function()
    if not SilentAimSettings.Enabled then
        fov_circle.Visible = false
        snapline.Visible = false
        fov_fill.Visible = false
        return
    end

    fov_circle.Position = getMousePosition()
    fov_circle.Radius = SilentAimSettings.FOVRadius

    local target = SilentAimSettings.UseFOV and getClosestPlayer() or nil
    if SilentAimSettings.UseFOV then
        if target then
            fov_circle.Color = SilentAimSettings.FOVColorOnTarget
        else
            fov_circle.Color = SilentAimSettings.FOVColorNoTarget
        end
    else
        fov_circle.Color = SilentAimSettings.FOVColor
    end
    fov_circle.Visible = SilentAimSettings.UseFOV

    fov_fill.Position = getMousePosition()
    fov_fill.Radius = SilentAimSettings.FOVRadius
    fov_fill.Color = SilentAimSettings.FOVFillColor
    fov_fill.Transparency = SilentAimSettings.FOVFillTrans
    fov_fill.Visible = SilentAimSettings.UseFOV and SilentAimSettings.FOVFill

    if SilentAimSettings.Snapline then
        local targetLine = getClosestPlayer()
        if targetLine then
            local pos, onScreen = Camera:WorldToViewportPoint(targetLine.Position)
            if onScreen then
                snapline.Visible = true
                snapline.From = getMousePosition()
                snapline.To = Vector2.new(pos.X, pos.Y)
                snapline.Color = SilentAimSettings.SnaplineColor
                snapline.Thickness = SilentAimSettings.SnaplineThickness
            else
                snapline.Visible = false
            end
        else
            snapline.Visible = false
        end
    else
        snapline.Visible = false
    end
end)


function createBulletTrace(origin, hitPos)
    if not BulletTraceConfig.Enabled then return end

    local part = Instance.new("Part")
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Size = Vector3.new(0.1, 0.1, 0.1)
    part.Parent = workspace

    local att0 = Instance.new("Attachment", part)
    att0.WorldPosition = origin
    local att1 = Instance.new("Attachment", part)
    att1.WorldPosition = hitPos

    local mode = BulletTraceConfig.Mode
    local color = BulletTraceConfig.Color
    local transparency = BulletTraceConfig.Transparency or 0

    if mode == "Default" then
        local beam = Instance.new("Beam")
        beam.Attachment0 = att0
        beam.Attachment1 = att1
        beam.FaceCamera = true
        beam.LightInfluence = 0
        beam.Color = ColorSequence.new(color)
        beam.Width0 = 0.15
        beam.Width1 = 0.15
        beam.Transparency = NumberSequence.new(transparency)
        beam.CurveSize0 = 0
        beam.CurveSize1 = 0
        beam.LightEmission = 0
        beam.Parent = part

    elseif mode == "Neon" then
        local beam = Instance.new("Beam")
        beam.Attachment0 = att0
        beam.Attachment1 = att1
        beam.FaceCamera = true
        beam.LightInfluence = 0
        beam.Color = ColorSequence.new(color)
        beam.Width0 = 0.13
        beam.Width1 = 0.13
        beam.Transparency = NumberSequence.new(transparency)
        beam.CurveSize0 = 0
        beam.CurveSize1 = 0
        beam.LightEmission = 1
        beam.Parent = part

    elseif mode == "Laser" then
        local beamGlow = Instance.new("Beam")
        beamGlow.Attachment0 = att0
        beamGlow.Attachment1 = att1
        beamGlow.FaceCamera = true
        beamGlow.LightInfluence = 0
        beamGlow.Color = ColorSequence.new(color)
        beamGlow.Width0 = 0.18
        beamGlow.Width1 = 0.18
        beamGlow.Transparency = NumberSequence.new(transparency)
        beamGlow.CurveSize0 = 0
        beamGlow.CurveSize1 = 0
        beamGlow.LightEmission = 0.7
        beamGlow.Parent = part

        local beamCore = Instance.new("Beam")
        beamCore.Attachment0 = att0
        beamCore.Attachment1 = att1
        beamCore.FaceCamera = true
        beamCore.LightInfluence = 0
        beamCore.Color = ColorSequence.new(Color3.new(1,1,1))
        beamCore.Width0 = 0.09
        beamCore.Width1 = 0.09
        beamCore.Transparency = NumberSequence.new(math.clamp(transparency * 0.5 + 0.025, 0, 1))
        beamCore.CurveSize0 = 0
        beamCore.CurveSize1 = 0
        beamCore.LightEmission = 0.6
        beamCore.Parent = part

    elseif mode == "Wave" then
    local beam1 = Instance.new("Beam")
    beam1.Attachment0 = att0
    beam1.Attachment1 = att1
    beam1.FaceCamera = true
    beam1.LightInfluence = 0
    beam1.Color = ColorSequence.new(color)
    beam1.Width0 = 1.1
    beam1.Width1 = 1.1
    beam1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.09),NumberSequenceKeypoint.new(1,0.25)})
    beam1.Texture = "rbxassetid://446111271" 
    beam1.TextureLength = 5
    beam1.TextureSpeed = 3
    beam1.Segments = 16
    beam1.LightEmission = 1
    beam1.Parent = part

    local beam2 = Instance.new("Beam")
    beam2.Attachment0 = att0
    beam2.Attachment1 = att1
    beam2.FaceCamera = true
    beam2.LightInfluence = 0
    beam2.Color = ColorSequence.new(Color3.fromRGB(250,250,255))
    beam2.Width0 = 1.7
    beam2.Width1 = 1.7
    beam2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.35),NumberSequenceKeypoint.new(1,0.7)})
    beam2.Texture = "rbxassetid://446111271"
    beam2.TextureLength = 8
    beam2.TextureSpeed = 2
    beam2.Segments = 20
    beam2.LightEmission = 1
    beam2.Parent = part
end

    local totalLife = BulletTraceConfig.LifeTime
    task.spawn(function()
        task.wait(totalLife)
        if part and part.Parent then part:Destroy() end
    end)
end
function getMagicBulletDirection(origin, targetPos)
    local arcHeight = Options.MagicBulletsHeight and Options.MagicBulletsHeight.Value or 400
    local above = targetPos + Vector3.new(0, arcHeight, 0)
    return {
        toAbove = (above - origin),
        toTarget = (targetPos - above)
    }
end

function safeCopyArguments(args)
    local ok, copy = pcall(function()
        local newArgs = {}
        for i, v in ipairs(args) do
            newArgs[i] = v
        end
        return newArgs
    end)
    return (ok and copy) or args
end

function getSilentAimDirection(origin, targetPos, velocity)
    local dir = (targetPos - origin)
    if velocity and velocity > 0 then
        dir = dir.Unit * velocity
    end
    return dir
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]

    if Method == "Raycast" and self == workspace and not checkcaller() then
        local origin = Arguments[2]
        local direction = Arguments[3]
        local result = oldNamecall(...)
        local magnitude = direction and direction.Magnitude or 0
        local intMag = math.floor(magnitude + 0.5)
        local magicBulletsActive = Toggles.MagicBullets and Toggles.MagicBullets.Value and SilentAimSettings.Enabled

if BulletTraceConfig.Enabled 
    and intMag ~= 0 and intMag ~= 1 
    and intMag ~= 7 and intMag ~= 9 
    and intMag ~= 10 and intMag ~= 14 
    and intMag ~= 30 and intMag ~= 50 
    and intMag <= 99 then

    local HitPart = getClosestPlayer()
    if magicBulletsActive and HitPart and typeof(HitPart) == "Instance" and typeof(HitPart.Position) == "Vector3" then
        createBulletTrace(origin, HitPart.Position)
    elseif SilentAimSettings.Enabled and HitPart and typeof(HitPart) == "Instance" and typeof(HitPart.Position) == "Vector3" then
        if result and typeof(result) == "table" and result.Position and typeof(result.Position) == "Vector3" then
            createBulletTrace(origin, result.Position)
        else
            createBulletTrace(origin, HitPart.Position)
        end
    elseif result and typeof(result) == "table" and result.Position and typeof(result.Position) == "Vector3" then
        createBulletTrace(origin, result.Position)
    elseif direction and typeof(direction) == "Vector3" then
        createBulletTrace(origin, origin + direction)
    end
end

        if magicBulletsActive then
            local HitPart = getClosestPlayer()
            if HitPart and typeof(HitPart) == "Instance" and typeof(HitPart.Position) == "Vector3" and typeof(origin) == "Vector3" then
                local magic = getMagicBulletDirection(origin, HitPart.Position)
                local Args = safeCopyArguments(Arguments)
                Args[3] = magic.toAbove
                local ok1, res1 = pcall(oldNamecall, unpack(Args))
                Args[2] = origin + magic.toAbove
                Args[3] = magic.toTarget
                if typeof(Args[1]) == "Instance" and typeof(Args[2]) == "Vector3" and typeof(Args[3]) == "Vector3" then
                    local ok2, res2 = pcall(oldNamecall, unpack(Args))
                    if ok2 then
                        return res2
                    end
                end
                return result
            else
                return result
            end
        end

        if SilentAimSettings.Enabled and self == workspace and not checkcaller() and Method == "Raycast" then
            local HitPart = getClosestPlayer()
            if HitPart and typeof(HitPart) == "Instance" and typeof(HitPart.Position) == "Vector3" and typeof(origin) == "Vector3" then
                local Args = safeCopyArguments(Arguments)
                local velocity = direction and direction.Magnitude or nil
                Args[3] = getSilentAimDirection(origin, HitPart.Position, velocity)
                if typeof(Args[1]) == "Instance" and typeof(Args[2]) == "Vector3" and typeof(Args[3]) == "Vector3" then
                    local ok, res = pcall(oldNamecall, unpack(Args))
                    if ok then
                        return res
                    end
                end
                return result
            else
                return result
            end
        end

        return result
    end

    if SilentAimSettings.Enabled and self == workspace and not checkcaller() and Method == "Raycast" then
        local origin = Arguments[2]
        local direction = Arguments[3]
        local HitPart = getClosestPlayer()
        if HitPart and typeof(HitPart) == "Instance" and typeof(HitPart.Position) == "Vector3" and typeof(origin) == "Vector3" then
            local Args = safeCopyArguments(Arguments)
            local velocity = direction and direction.Magnitude or nil
            Args[3] = getSilentAimDirection(origin, HitPart.Position, velocity)
            if typeof(Args[1]) == "Instance" and typeof(Args[2]) == "Vector3" and typeof(Args[3]) == "Vector3" then
                local ok, res = pcall(oldNamecall, unpack(Args))
                if ok then
                    return res
                end
            end
        end
        return oldNamecall(...)
    end

    return oldNamecall(...)
end))

local function isTeammate(player)
    local character = player.Character
    if character then
        local head = character:FindFirstChild("Head")
        if head then
            local teammateGui = head:FindFirstChild("TeammateGui")
            if teammateGui and teammateGui:IsA("BillboardGui") then
                return true
            end
        end
    end
    return false
end

ESPCache = setmetatable({}, {__mode = "k"})
ESPVisible = {}
DrawingCache = {Square = {}, Text = {}, Line = {}}

function GetDrawing(class)
    local cache = DrawingCache[class]
    if cache and #cache > 0 then
        local obj = table.remove(cache)
        obj.Visible = false
        return obj
    end
    local d = Drawing.new(class)
    d.Visible = false
    return d
end

function ReleaseDrawing(obj, class)
    obj.Visible = false
    if DrawingCache[class] then
        table.insert(DrawingCache[class], obj)
    else
        pcall(function() obj:Remove() end)
    end
end

function EnsureESPObject(objs, key, class, extra)
    if not objs[key] then
        if class == "corners" then
            objs.corners = {}
            for i = 1, 8 do
                local l = GetDrawing("Line")
                l.Visible = false
                table.insert(objs.corners, l)
            end
        else
            local d = GetDrawing(class)
            d.Visible = false
            if extra and type(extra) == "function" then extra(d) end
            objs[key] = d
        end
    end
    return objs[key]
end

function HideESP(objs)
    if objs then
        for k, obj in pairs(objs) do
            if typeof(obj) == "table" then
                for _, o in pairs(obj) do o.Visible = false end
            elseif obj then
                obj.Visible = false
            end
        end
    end
end

function RemoveESP(player)
    local objs = ESPCache[player]
    if objs then
        HideESP(objs)
        ESPVisible[player] = nil
    end
end
function getBoundingBox(model)
    local cframe, size = model:GetBoundingBox()
    size = Vector3.new(math.min(size.X, 5), math.min(size.Y, 6.7), math.min(size.Z, 5))
    return cframe, size
end

function worldToViewPoint(pos)
    local vec, onScreen = Camera:WorldToViewportPoint(pos)
    return Vector2.new(vec.X, vec.Y), onScreen
end

function calculateBox2D(model)
    local cframe, size = getBoundingBox(model)
    local rootPos = cframe.Position
    local center2D, onScreen = worldToViewPoint(rootPos)
    if not onScreen then return end
    local lookAt = CFrame.new(rootPos, Camera.CFrame.Position)
    local x, y = -size.X/2, size.Y/2
    local topright2D = worldToViewPoint((lookAt * CFrame.new(x, y, 0)).Position)
    local bottomright2D = worldToViewPoint((lookAt * CFrame.new(x, -y, 0)).Position)
    local offset = Vector2.new(
        math.max(topright2D.X - center2D.X, bottomright2D.X - center2D.X),
        math.max((center2D.Y - topright2D.Y), (bottomright2D.Y - center2D.Y))
    )
    return center2D, offset
end

function isESPActive()
    return ESPOptions.Enabled and (
        ESPOptions.Box or ESPOptions.Name or ESPOptions.Distance or
        ESPOptions.Weapon or ESPOptions.HealthBar or ESPOptions.HealthText or ESPOptions.BoxFill
    )
end

RunService.RenderStepped:Connect(function()
    if not isESPActive() then
        for player, _ in pairs(ESPVisible) do RemoveESP(player) end
        if ESPCache.Npc then
            for npc, _ in pairs(ESPCache.Npc) do HideESP(ESPCache.Npc[npc]) end
        end
        return
    end

    local localHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local players = Players:GetPlayers()
    local visibleNow = {}
    local maxPlayerDist = ESPOptions.MaxPlayerDist or 5000
    local maxNpcDist = ESPOptions.MaxNpcDist or 5000

    for i = 1, #players do
        local player = players[i]
        if player ~= LocalPlayer then
            if ESPOptions.TeamCheck and isTeammate(player) then
                RemoveESP(player)
            else
                local char = player.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                local targetHRP = char and char:FindFirstChild("HumanoidRootPart")
                if char and hum and hum.Health > 0 and localHRP and targetHRP then
                    local dist = GetDist(localHRP.Position, targetHRP.Position)
                    if dist <= maxPlayerDist then
                        local center2D, offset = calculateBox2D(char)
                        if center2D and offset then
                            local objs = ESPCache[player] or {}; ESPCache[player] = objs
                            visibleNow[player] = true; ESPVisible[player] = true
                            local boxPos = center2D - offset
                            local boxSize = offset * 2
                            local x, y, w, h = boxPos.X, boxPos.Y, boxSize.X, boxSize.Y

                            if ESPOptions.BoxFill then
                                local rect = EnsureESPObject(objs, "boxfill", "Square")
                                rect.Position = boxPos
                                rect.Size = boxSize
                                rect.Color = ESPOptions.BoxFillColor
                                rect.Transparency = ESPOptions.BoxFillTrans
                                rect.Filled = true
                                rect.Visible = true
                            elseif objs.boxfill then objs.boxfill.Visible = false end

                            if ESPOptions.Box then
                                if ESPOptions.BoxStyle == "Default" then
                                    local box = EnsureESPObject(objs, "box", "Square")
                                    box.Position = boxPos
                                    box.Size = boxSize
                                    box.Color = ESPColors.Box1
                                    box.Thickness = 1.5
                                    box.Visible = true
                                    if objs.corners then for _, l in pairs(objs.corners) do l.Visible = false end end
                                elseif ESPOptions.BoxStyle == "Corned" then
                                    EnsureESPObject(objs, "corners", "corners")
                                    local len = math.min(w, h) * 0.21
                                    local ci = 1
                                    local function setline(x1, y1, x2, y2)
                                        local l = objs.corners[ci]
                                        l.From = Vector2.new(x1, y1)
                                        l.To = Vector2.new(x2, y2)
                                        l.Color = ESPColors.Box1
                                        l.Thickness = 1.5
                                        l.Visible = true
                                        ci = ci + 1
                                    end
                                    setline(x, y, x + len, y)
                                    setline(x, y, x, y + len)
                                    setline(x + w, y, x + w - len, y)
                                    setline(x + w, y, x + w, y + len)
                                    setline(x, y + h, x + len, y + h)
                                    setline(x, y + h, x, y + h - len)
                                    setline(x + w, y + h, x + w - len, y + h)
                                    setline(x + w, y + h, x + w, y + h - len)
                                    if objs.box then objs.box.Visible = false end
                                end
                            else
                                if objs.box then objs.box.Visible = false end
                                if objs.corners then for _, l in pairs(objs.corners) do l.Visible = false end end
                            end

                            if ESPOptions.Name then
                                local nameText = EnsureESPObject(objs, "name", "Text")
                                nameText.Text = player.Name
                                nameText.Font = DrawingFont
                                nameText.Size = 14
                                nameText.Color = ESPColors.Name
                                nameText.Outline = true
                                nameText.Center = true
                                nameText.Position = Vector2.new(x + w / 2, y - 15)
                                nameText.Visible = true
                            elseif objs.name then objs.name.Visible = false end

                            if ESPOptions.Distance then
                                local distText = EnsureESPObject(objs, "dist", "Text")
                                local distVal = localHRP and char.HumanoidRootPart and GetDist(localHRP.Position, char.HumanoidRootPart.Position)
                                if distVal then
                                    distText.Text = tostring(math.floor(distVal)) .. "m"
                                    distText.Font = DrawingFont
                                    distText.Size = 12
                                    distText.Color = ESPColors.Distance
                                    distText.Outline = true
                                    distText.Center = true
                                    distText.Position = Vector2.new(x + w / 2, y + h + 2)
                                    distText.Visible = true
                                else
                                    distText.Visible = false
                                end
                            elseif objs.dist then objs.dist.Visible = false end

                            if ESPOptions.Weapon then
                                local weaponText = EnsureESPObject(objs, "weapon", "Text")
                                local weaponName = GetEquippedWeapon(char)
                                weaponText.Text = tostring(weaponName)
                                weaponText.Font = DrawingFont
                                weaponText.Size = 12
                                weaponText.Color = ESPColors.Weapon
                                weaponText.Outline = true
                                weaponText.Center = false
                                weaponText.Position = Vector2.new(x + w + 8, y + h / 2 - 2)
                                weaponText.Visible = true
                            elseif objs.weapon then objs.weapon.Visible = false end

                            local hp, maxhp = GetHealth(char)
                            if hp and maxhp then
                                if ESPOptions.HealthBar then
                                    local barOut = EnsureESPObject(objs, "healthbaroutline", "Line")
                                    local bar = EnsureESPObject(objs, "healthbar", "Line")
                                    local barH = h
                                    local perc = math.clamp(hp / maxhp, 0, 1)
                                    barOut.From = Vector2.new(x - 4, y + barH + 1)
                                    barOut.To = Vector2.new(x - 4, y - 1)
                                    barOut.Color = Color3.fromRGB(0, 0, 0)
                                    barOut.Thickness = 2.1
                                    barOut.Visible = true
                                    bar.From = Vector2.new(x - 4, y + barH)
                                    bar.To = Vector2.new(x - 4, y + barH - barH * perc)
                                    bar.Color = GetHealthColor(hp, maxhp)
                                    bar.Thickness = 1.2
                                    bar.Visible = true
                                else
                                    if objs.healthbar then objs.healthbar.Visible = false end
                                    if objs.healthbaroutline then objs.healthbaroutline.Visible = false end
                                end
                                if ESPOptions.HealthText then
                                    local hpText = EnsureESPObject(objs, "healthtext", "Text")
                                    hpText.Text = ("%d/%d"):format(hp, maxhp)
                                    hpText.Font = DrawingFont
                                    hpText.Size = 12
                                    hpText.Color = GetHealthColor(hp, maxhp)
                                    hpText.Outline = true
                                    hpText.Center = false
                                    hpText.Position = Vector2.new(x + w + 8, y + h / 2 + 10)
                                    hpText.Visible = true
                                elseif objs.healthtext then objs.healthtext.Visible = false end
                            else
                                if objs.healthbar then objs.healthbar.Visible = false end
                                if objs.healthbaroutline then objs.healthbaroutline.Visible = false end
                                if objs.healthtext then objs.healthtext.Visible = false end
                            end
                        else
                            RemoveESP(player)
                        end
                    else
                        RemoveESP(player)
                    end
                else
                    RemoveESP(player)
                end
            end
        end
    end

    local npcVisibleNow = {}
    if ESPOptions.NpcVis then
        if not ESPCache.Npc then ESPCache.Npc = {} end
        local npcFolder = workspace:FindFirstChild("Npc")
        if npcFolder then
            for _, npc in ipairs(npcFolder:GetChildren()) do
                local hum = npc:FindFirstChildOfClass("Humanoid")
                local targetHRP = npc:FindFirstChild("HumanoidRootPart")
                if npc:IsA("Model") and hum and hum.Health > 0 and localHRP and targetHRP then
                    local dist = GetDist(localHRP.Position, targetHRP.Position)
                    if dist <= maxNpcDist then
                        local center2D, offset = calculateBox2D(npc)
                        if center2D and offset then
                            local objs = ESPCache.Npc[npc] or {}; ESPCache.Npc[npc] = objs
                            npcVisibleNow[npc] = true
                            local boxPos = center2D - offset
                            local boxSize = offset * 2
                            local x, y, w, h = boxPos.X, boxPos.Y, boxSize.X, boxSize.Y

                            if ESPOptions.BoxFill then
                                local rect = EnsureESPObject(objs, "boxfill", "Square")
                                rect.Position = boxPos
                                rect.Size = boxSize
                                rect.Color = ESPOptions.BoxFillColor
                                rect.Transparency = ESPOptions.BoxFillTrans
                                rect.Filled = true
                                rect.Visible = true
                            elseif objs.boxfill then objs.boxfill.Visible = false end

                            if ESPOptions.Box then
                                if ESPOptions.BoxStyle == "Default" then
                                    local box = EnsureESPObject(objs, "box", "Square")
                                    box.Position = boxPos
                                    box.Size = boxSize
                                    box.Color = ESPColors.Box1
                                    box.Thickness = 1.5
                                    box.Visible = true
                                    if objs.corners then for _, l in pairs(objs.corners) do l.Visible = false end end
                                elseif ESPOptions.BoxStyle == "Corned" then
                                    EnsureESPObject(objs, "corners", "corners")
                                    local len = math.min(w, h) * 0.21
                                    local ci = 1
                                    local function setline(x1, y1, x2, y2)
                                        local l = objs.corners[ci]
                                        l.From = Vector2.new(x1, y1)
                                        l.To = Vector2.new(x2, y2)
                                        l.Color = ESPColors.Box1
                                        l.Thickness = 1.5
                                        l.Visible = true
                                        ci = ci + 1
                                    end
                                    setline(x, y, x + len, y)
                                    setline(x, y, x, y + len)
                                    setline(x + w, y, x + w - len, y)
                                    setline(x + w, y, x + w, y + len)
                                    setline(x, y + h, x + len, y + h)
                                    setline(x, y + h, x, y + h - len)
                                    setline(x + w, y + h, x + w - len, y + h)
                                    setline(x + w, y + h, x + w, y + h - len)
                                    if objs.box then objs.box.Visible = false end
                                end
                            else
                                if objs.box then objs.box.Visible = false end
                                if objs.corners then for _, l in pairs(objs.corners) do l.Visible = false end end
                            end

                            if ESPOptions.Name then
                                local nameText = EnsureESPObject(objs, "name", "Text")
                                nameText.Text = npc.Name
                                nameText.Font = DrawingFont
                                nameText.Size = 14
                                nameText.Color = ESPColors.Name
                                nameText.Outline = true
                                nameText.Center = true
                                nameText.Position = Vector2.new(x + w / 2, y - 15)
                                nameText.Visible = true
                            elseif objs.name then objs.name.Visible = false end

                            if ESPOptions.Distance and localHRP and npc:FindFirstChild("HumanoidRootPart") then
                                local distText = EnsureESPObject(objs, "dist", "Text")
                                local distVal = GetDist(localHRP.Position, npc.HumanoidRootPart.Position)
                                distText.Text = tostring(math.floor(distVal)) .. "m"
                                distText.Font = DrawingFont
                                distText.Size = 12
                                distText.Color = ESPColors.Distance
                                distText.Outline = true
                                distText.Center = true
                                distText.Position = Vector2.new(x + w / 2, y + h + 2)
                                distText.Visible = true
                            elseif objs.dist then objs.dist.Visible = false end

                            if ESPOptions.Weapon then
                                local weaponText = EnsureESPObject(objs, "weapon", "Text")
                                local weaponName = "None"
                                for _, child in ipairs(npc:GetChildren()) do
                                    if child:IsA("Tool") then
                                        weaponName = child.Name
                                        break
                                    end
                                end
                                weaponText.Text = tostring(weaponName)
                                weaponText.Font = DrawingFont
                                weaponText.Size = 12
                                weaponText.Color = ESPColors.Weapon
                                weaponText.Outline = true
                                weaponText.Center = false
                                weaponText.Position = Vector2.new(x + w + 8, y + h / 2 - 2)
                                weaponText.Visible = true
                            elseif objs.weapon then objs.weapon.Visible = false end

                            local hp, maxhp = hum.Health, hum.MaxHealth
                            if hp and maxhp then
                                if ESPOptions.HealthBar then
                                    local barOut = EnsureESPObject(objs, "healthbaroutline", "Line")
                                    local bar = EnsureESPObject(objs, "healthbar", "Line")
                                    local barH = h
                                    local perc = math.clamp(hp / maxhp, 0, 1)
                                    barOut.From = Vector2.new(x - 4, y + barH + 1)
                                    barOut.To = Vector2.new(x - 4, y - 1)
                                    barOut.Color = Color3.fromRGB(0, 0, 0)
                                    barOut.Thickness = 2.1
                                    barOut.Visible = true
                                    bar.From = Vector2.new(x - 4, y + barH)
                                    bar.To = Vector2.new(x - 4, y + barH - barH * perc)
                                    bar.Color = GetHealthColor(hp, maxhp)
                                    bar.Thickness = 1.2
                                    bar.Visible = true
                                else
                                    if objs.healthbar then objs.healthbar.Visible = false end
                                    if objs.healthbaroutline then objs.healthbaroutline.Visible = false end
                                end
                                if ESPOptions.HealthText then
                                    local hpText = EnsureESPObject(objs, "healthtext", "Text")
                                    hpText.Text = ("%d/%d"):format(hp, maxhp)
                                    hpText.Font = DrawingFont
                                    hpText.Size = 12
                                    hpText.Color = GetHealthColor(hp, maxhp)
                                    hpText.Outline = true
                                    hpText.Center = false
                                    hpText.Position = Vector2.new(x + w + 8, y + h / 2 + 10)
                                    hpText.Visible = true
                                elseif objs.healthtext then objs.healthtext.Visible = false end
                            else
                                if objs.healthbar then objs.healthbar.Visible = false end
                                if objs.healthbaroutline then objs.healthbaroutline.Visible = false end
                                if objs.healthtext then objs.healthtext.Visible = false end
                            end
                        else
                            HideESP(objs)
                        end
                    else
                        HideESP(ESPCache.Npc[npc])
                    end
                else
                    if ESPCache.Npc and ESPCache.Npc[npc] then HideESP(ESPCache.Npc[npc]) end
                end
            end
        end
    else
        if ESPCache.Npc then
            for npc, _ in pairs(ESPCache.Npc) do HideESP(ESPCache.Npc[npc]) end
        end
    end

    for player in pairs(ESPVisible) do
        if not visibleNow[player] then RemoveESP(player) end
    end
    if ESPCache.Npc then
        for npc, _ in pairs(ESPCache.Npc) do
            if not npcVisibleNow[npc] then HideESP(ESPCache.Npc[npc]) end
        end
    end
end)
else
	print("Key is invalid")

end
