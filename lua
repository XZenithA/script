
if getgenv().UndetectedScriptLoaded then return end
getgenv().UndetectedScriptLoaded = true

repeat task.wait() until game:IsLoaded()
local P = game:GetService("Players")
local LP = P.LocalPlayer
repeat task.wait() until LP.Character or LP.CharacterAdded:Wait()

local RS = game:GetService("RunService")
local Rep = game:GetService("ReplicatedStorage")
local L = game:GetService("Lighting")
local TS = game:GetService("TweenService")
local SS = game:GetService("SoundService")
local CG = game:GetService("CoreGui")
local Cam = workspace.CurrentCamera

local isMM2 = game.PlaceId == 142823291 or game.PlaceId == 335132309

if isMM2 then
    task.spawn(function()
        local guiNames = {"Loading", "DeviceSelect", "Join", "JoinPhone"}
        local remotes = Rep:WaitForChild("Remotes")
        local loadedRemote = remotes:WaitForChild("Extras"):WaitForChild("LoadedCompletely")
        
        while true do
            local PlayerGui = LP:FindFirstChild("PlayerGui")
            if PlayerGui then
                for _, name in ipairs(guiNames) do
                    local screen = PlayerGui:FindFirstChild(name)
                    if screen then screen:Destroy() end
                end
                
                if PlayerGui:GetAttribute("Device") ~= "PC" then
                    PlayerGui:SetAttribute("Device", "PC")
                end
                
                if not PlayerGui:FindFirstChild("MainGUI") then
                    local guiFolder = Rep:FindFirstChild("GUI")
                    if guiFolder then
                        local mainGui = guiFolder:FindFirstChild("MainPC") or guiFolder:FindFirstChild("MainMobile")
                        if mainGui then
                            local clone = mainGui:Clone()
                            clone.Name = "MainGUI"
                            clone.Parent = PlayerGui
                        end
                    end
                end
                
                pcall(function()
                    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
                end)
                
                loadedRemote:FireServer()
            end
            task.wait(0.1)
        end
    end)
end

local FOLDER_NAME = "UndetectedScript_Music"
if not isfolder(FOLDER_NAME) then makefolder(FOLDER_NAME) end

local WebSongs = {
    {N = "Phonk - EEYUH x Fluxxwave", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/EEYUH!%20x%20Fluxxwave.mp3"},
    {N = "Phonk - Metamorphosis", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/Metamorphosis.mp3"},
    {N = "Phonk - Murder In My Mind", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/MurderInMyMind.mp3"},
    {N = "Phonk - PLUGGNB JEDAG JEDUG", U = "https://raw.githubusercontent.com/fiangg20/Fian_gg-Repo/main/PLUGGNB%20JEDAG%20JEDUG.mp3"},
    {N = "Phonk - Memory Reboot", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/somebody%20pleasure%20[edit%20audio]%20(full%20version).mp3"},
    {N = "Viral - Somebody's Pleasure", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/Aziz%20Hedra%20-%20Somebody's%20Pleasure%20(Extended%20Version).mp3"},
    {N = "Viral - Cupid (Twin Ver)", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/FIFTY%20FIFTY%20-%20Cupid%20(Twin%20Ver.).mp3"},
    {N = "Viral - Angels Like You", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/Miley%20Cyrus%20-%20Angels%20Like%20You.mp3"},
    {N = "Viral - Here With Me", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/d4vd%20-%20Here%20With%20Me.mp3"},
    {N = "Viral - Love on me x Prince of Egypt", U = "https://raw.githubusercontent.com/fiangg20/Fian_gg-Repo/main/Love%20on%20me%20x%20Prince%20of%20egypt.mp3"},
    {N = "Viral - wutiwant x love potions", U = "https://raw.githubusercontent.com/fiangg20/Fian_gg-Repo/main/wutiwant%20x%20love%20potions%20(Lyrics)%20tiktok%20version%20_%20saraunh0ly%20x%20BJ%20Lips%2C%206arelyhuman.mp3"},
    {N = "Viral - Masa Lalu (Speed Up)", U = "https://raw.githubusercontent.com/fiangg20/Fian_gg-Repo/main/Masa%20Lalu%20(Speed%20Up).mp3"},
    {N = "Viral - Masa Depanmu", U = "https://raw.githubusercontent.com/fiangg20/Fian_gg-Repo/main/Masa%20Depanmu.mp3"},
    {N = "Meme - Rick Roll", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/RickRoll.mp3"},
    {N = "Meme - Gas Gas Gas", U = "https://raw.githubusercontent.com/3kh0/soundboard/main/sounds/gas-gas-gas.mp3"},
    {N = "Meme - Spongebob dance", U = "https://raw.githubusercontent.com/fiangg20/Fian_gg-Repo/main/Spongebob%20dance.mp3"},
    {N = "Meme - Trap Royalty Tutorial", U = "https://raw.githubusercontent.com/fiangg20/Fian_gg-Repo/main/Trap%20Royalty%20-%20very%20cool%20tutorial%20%5BSlowed%20-%20More%20reverb%5D.mp3"},
    {N = "NCS - Faded (Alan Walker)", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/Faded.mp3"},
    {N = "NCS - Spectre", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/Spectre.mp3"},
    {N = "NCS - Invincible", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/Invincible.mp3"},
    {N = "NCS - My Heart", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/MyHeart.mp3"},
    {N = "NCS - Blank", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/Blank.mp3"},
    {N = "NCS - Sky High", U = "https://github.com/fiangg20/Fian_gg-Repo/raw/main/SkyHigh.mp3"},
    {N = "Slowed - chess", U = "https://raw.githubusercontent.com/fiangg20/Fian_gg-Repo/main/chess%20(slowed).mp3"},
    {N = "Custom - Slot 50", U = ""}
}

local Connections = {}
local function AddConnection(conn)
    table.insert(Connections, conn)
    return conn
end
local function CleanupConnections()
    for _, conn in pairs(Connections) do
        if conn then pcall(function() conn:Disconnect() end) end
    end
    Connections = {}
end

local SFX = {
    W = "rbxassetid://9125402735",
    C = "rbxassetid://6895079853",
    T = "rbxassetid://6895079946",
    S = "rbxassetid://6895079769"
}

local MP = {Snd = nil, Vol = 0.5, On = false, Downloading = false, UI = nil}

local function Notify(title, msg)
    if MP.UI and MP.UI.Notify then
        MP.UI:Notify({
            Title = title,
            Content = msg,
            Duration = 3
        })
    end
end

local function Sanitize(name)
    return name:gsub("[%p%c%s]", "") .. ".mp3"
end

local function DownloadFile(url, filename)
    if not url or url == "" then return false end
    if isfile(FOLDER_NAME .. "/" .. filename) then return true end
    
    local success, data = pcall(function() return game:HttpGet(url) end)
    if success and data then
        writefile(FOLDER_NAME .. "/" .. filename, data)
        return true
    end
    return false
end

local function PlayM(songData)
    if MP.Snd then 
        MP.Snd:Stop() 
        MP.Snd:Destroy()
        MP.Snd = nil
    end
    MP.On = false
    
    if not songData or not songData.U then return end
    
    local filename = Sanitize(songData.N)
    local path = FOLDER_NAME .. "/" .. filename
    
    if not isfile(path) then
        if MP.Downloading then return end
        MP.Downloading = true
        
        Notify("Music Player", "Downloading: " .. songData.N)
        
        local success = DownloadFile(songData.U, filename)
        MP.Downloading = false
        
        if not success then 
            Notify("Music Player", "Failed to download.")
            return 
        end
        Notify("Music Player", "Download Complete!")
    end
    
    local s = Instance.new("Sound")
    s.Name = "ZephMusic"
    s.Volume = MP.Vol
    s.Looped = true
    s.Parent = SS
    
    local success, asset = pcall(function() return getcustomasset(path) end)
    if success and asset then
        s.SoundId = asset
        s:Play()
        MP.Snd = s
        MP.On = true
        Notify("Now Playing", songData.N)
    end
end

local function StopM()
    if MP.Snd then 
        MP.Snd:Stop() 
        MP.Snd:Destroy()
        MP.Snd = nil
    end
    MP.On = false
end

local function SetVol(v)
    MP.Vol = v
    if MP.Snd then MP.Snd.Volume = v end
end

local function Sfx(id, v)
    pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = id
        s.Volume = v or 0.5
        s.Parent = SS
        s:Play()
        s.Ended:Connect(function() s:Destroy() end)
    end)
end

local Remotes, ShopRem, GameRem, DB_Item, DB_Prof

pcall(function()
    Remotes = Rep:WaitForChild("Remotes", 5)
    if Remotes then
        ShopRem = Remotes:WaitForChild("Shop", 3):WaitForChild("BoxController", 3)
        GameRem = Remotes:WaitForChild("Gameplay", 3)
    end
    DB_Item = require(Rep:WaitForChild("Database"):WaitForChild("Sync"):WaitForChild("Item"))
    DB_Prof = require(Rep:WaitForChild("Modules"):WaitForChild("ProfileData"))
end)

local function GetRewards()
    local success, result = pcall(function()
        return GameRem:WaitForChild("GetLastRoundRewards"):InvokeServer()
    end)
    return success and result
end

local function ClearTweens()
    pcall(function()
        Rep:WaitForChild("ClientTweenEvents"):WaitForChild("ClearTweens"):Fire()
    end)
end

local function Main()
    local W = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    MP.UI = W
    
    
    W:AddTheme({
        Name = "UndetectedScriptTheme",
        Accent = W:Gradient({
            ["0"] = {Color = Color3.fromHex("00FFFF"), Transparency = 0},
            ["100"] = {Color = Color3.fromHex("008CFF"), Transparency = 0}
        }, {Rotation = 90}),
        Background = Color3.fromHex("0A0C14"),
        Outline = Color3.fromHex("1E283C"),
        Text = Color3.fromHex("F0FAFF"),
        Placeholder = Color3.fromHex("647896"),
        Button = Color3.fromHex("141928"),
        Icon = Color3.fromHex("00FFFF"),
        Hover = Color3.fromHex("00C8FF"),
        WindowBackground = Color3.fromHex("0C0E18"),
        WindowShadow = Color3.fromHex("0096FF"),
        WindowTopbarTitle = Color3.fromHex("FFFFFF"),
        WindowTopbarAuthor = Color3.fromHex("64B4FF"),
        WindowTopbarIcon = Color3.fromHex("00FFFF"),
        TabBackground = Color3.fromHex("FFFFFF"),
        TabTitle = Color3.fromHex("FFFFFF"),
        TabIcon = Color3.fromHex("C8C8C8"),
        ElementBackground = Color3.fromHex("161A2D"),
        ElementTitle = Color3.fromHex("FFFFFF"),
        ElementDesc = Color3.fromHex("788CB4"),
        Toggle = Color3.fromHex("1E233C"),
        ToggleBar = Color3.fromHex("FFFFFF"),
        Slider = Color3.fromHex("1E233C"),
        SliderThumb = Color3.fromHex("FFFFFF")
    })
    
    local Config = {
        FarmSpeed = 30,
        MaxCandy = 50,
        EvadeDistance = 20
    }
    
    local Logic = {
        CoinFarm = false,
        KillAll = false,
        AutoReset = false,
        AvoidMurderer = true,
        ESP = {
            Enabled = true,
            ShowNames = false,
            ShowDistance = false,
            Colors = {
                Murderer = Color3.fromRGB(255, 50, 50),
                Sheriff = Color3.fromRGB(50, 50, 255),
                Innocent = Color3.fromRGB(50, 255, 50)
            }
        }
    }
    
    local FarmState = {
        CurrentTarget = nil,
        TargetStartTime = 0,
        CoinFolder = nil,
        CoinsCollected = 0,
        IgnoreList = {},
        LastRoundTime = 0
    }

    local RoleCache = {}
    local RoleCacheTime = 0
    local CACHE_DURATION = 0.5
    
    local FlingActive = false
    W:SetNotificationLower(true)
    
    getgenv().GWS = 16
    getgenv().GJP = 50

    local function Role(p)
        if not p or not p.Character then return "Innocent" end

        local now = tick()
        if now - RoleCacheTime < CACHE_DURATION and RoleCache[p] then
            return RoleCache[p]
        end
        
        local role = "Innocent"
        if p.Character:FindFirstChild("Knife") or (p.Backpack and p.Backpack:FindFirstChild("Knife")) then
            role = "Murderer"
        elseif p.Character:FindFirstChild("Gun") or (p.Backpack and p.Backpack:FindFirstChild("Gun")) then
            role = "Sheriff"
        end
        
        RoleCache[p] = role
        RoleCacheTime = now
        return role
    end

    task.spawn(function()
        while true do
            task.wait(CACHE_DURATION)
            RoleCache = {}
        end
    end)
    
    local function GetMurdererPosition()
        for _, player in ipairs(P:GetPlayers()) do
            if player ~= LP and player.Character then
                if Role(player) == "Murderer" then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then return hrp.Position, player end
                end
            end
        end
        return nil, nil
    end
    
    local function FindCoinFolder()
        if FarmState.CoinFolder and FarmState.CoinFolder.Parent then
            return FarmState.CoinFolder
        end
        
        FarmState.CoinFolder = workspace:FindFirstChild("CoinContainer", true)
            or workspace:FindFirstChild("CoinVisuals")
            or workspace:FindFirstChild("Coins")
            or workspace:FindFirstChild("CoinCollection")
        
        return FarmState.CoinFolder
    end

    local function GetNearestCoin(fromPos)
        local folder = FindCoinFolder()
        if not folder then return nil end
        
        local char = LP.Character
        if not char then return nil end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return nil end
        
        local referencePos = fromPos or hrp.Position
        
        local nearest, minDist = nil, math.huge
        local murdererPos = nil
        if Logic.AvoidMurderer then murdererPos = GetMurdererPosition() end
        
        for _, v in pairs(folder:GetChildren()) do
            if FarmState.IgnoreList[v] then continue end
            local p = v:IsA("BasePart") and v or (v:IsA("Model") and v.PrimaryPart)
            if p and (v.Name == "Coin" or v.Name == "SnowToken" or v:FindFirstChild("TouchInterest")) then
                if Logic.AvoidMurderer and murdererPos and (p.Position - murdererPos).Magnitude < Config.EvadeDistance then 
                    continue 
                end
                local dist = (referencePos - p.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = p
                end
            end
        end
        
        return nearest
    end

    local function ClearIgnoreList()
        FarmState.IgnoreList = {}
        FarmState.CoinsCollected = 0
    end
    
    AddConnection(Rep.ChildAdded:Connect(function(child)
        if child.Name == "NewRound" or child.Name:find("Round") then
            ClearIgnoreList()
        end
    end))
    
    task.spawn(function()
        pcall(function()
            local Remotes = Rep:WaitForChild("Remotes", 5)
            if Remotes then
                local coinRemote = Remotes:WaitForChild("Gameplay"):WaitForChild("CoinCollected")
                coinRemote.OnClientEvent:Connect(function(tokenName, currentAmount, bagLimit)
                    if type(currentAmount) == "number" then 
                        FarmState.CoinsCollected = currentAmount 
                    end
                    if type(bagLimit) == "number" then 
                        Config.MaxCandy = bagLimit 
                    end
                    if FarmState.CurrentTarget then 
                        FarmState.CurrentTarget = nil 
                    end
                    if FarmState.CoinsCollected >= Config.MaxCandy then
                        if Logic.AutoReset then
                            Logic.CoinFarm = false
                            if LP.Character and LP.Character:FindFirstChild("Humanoid") then 
                                LP.Character.Humanoid.Health = 0 
                            end
                            task.wait(4)
                            FarmState.CoinsCollected = 0
                            FarmState.IgnoreList = {}
                            Logic.CoinFarm = true
                        else
                            Logic.CoinFarm = false
                        end
                    end
                end)
            end
        end)
    end)
    
    local Attachment = Instance.new("Attachment")
    local AlignOrientation = Instance.new("AlignOrientation")
    local LinearVelocity = Instance.new("LinearVelocity")
    
    AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    AlignOrientation.RigidityEnabled = true
    LinearVelocity.MaxForce = math.huge
    LinearVelocity.VectorVelocity = Vector3.zero

    local function IsInLobby()
        local char = LP.Character
        if not char then return true end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return true end

        local lobby = workspace:FindFirstChild("Lobby") or workspace:FindFirstChild("RegularLobby")
        if lobby then
            local spawn = lobby:FindFirstChild("Spawn") or lobby:FindFirstChild("SpawnLocation") or lobby:FindFirstChild("Spawns")
            if spawn then
                if spawn:IsA("Folder") or spawn:IsA("Model") then
                    for _, s in pairs(spawn:GetChildren()) do
                        if s:IsA("BasePart") and (hrp.Position - s.Position).Magnitude < 40 then
                            return true
                        end
                    end
                elseif spawn:IsA("BasePart") then
                    if (hrp.Position - spawn.Position).Magnitude < 40 then
                        return true
                    end
                end
            end
        end
        return false
    end
    
    AddConnection(RS.Heartbeat:Connect(function()
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end
        
        local inLobby = IsInLobby()
        
        if Logic.CoinFarm and not inLobby and hum.Health > 0 then
            if not FindCoinFolder() then
                Attachment.Parent = nil
                AlignOrientation.Parent = nil
                LinearVelocity.Parent = nil
                if hum.PlatformStand then hum.PlatformStand = false end
                return
            end

            Attachment.Parent = hrp
            AlignOrientation.Attachment0 = Attachment
            AlignOrientation.Parent = hrp
            LinearVelocity.Attachment0 = Attachment
            LinearVelocity.Parent = hrp
            hum.PlatformStand = true
            
            for _, part in pairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end
            
            if Logic.AvoidMurderer then
                local murdererPos = GetMurdererPosition()
                if murdererPos and (hrp.Position - murdererPos).Magnitude < Config.EvadeDistance then
                    local escapeDir = (hrp.Position - murdererPos).Unit
                    LinearVelocity.VectorVelocity = escapeDir * (Config.FarmSpeed * 1.5)
                    AlignOrientation.CFrame = CFrame.new(hrp.Position, hrp.Position + escapeDir)
                    return
                end
            end
            
            if FarmState.CurrentTarget and not FarmState.CurrentTarget.Parent then 
                local lastPos = FarmState.CurrentTarget.Position
                FarmState.CurrentTarget = GetNearestCoin(lastPos)
            end
            if not FarmState.CurrentTarget then 
                FarmState.CurrentTarget = GetNearestCoin()
            end
            
            if FarmState.CurrentTarget then
                local targetPos = FarmState.CurrentTarget.Position + Vector3.new(0, -1.5, 0)
                local direction = (targetPos - hrp.Position).Unit
                LinearVelocity.VectorVelocity = direction * Config.FarmSpeed
                AlignOrientation.CFrame = CFrame.new(hrp.Position, hrp.Position + Vector3.new(direction.X, 0, direction.Z))
            else
                LinearVelocity.VectorVelocity = Vector3.zero
            end
        else
            Attachment.Parent = nil
            AlignOrientation.Parent = nil
            LinearVelocity.Parent = nil
            if hum and hum.PlatformStand and not FlingActive then
                hum.PlatformStand = false
            end
            
            if not Logic.CoinFarm or inLobby then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
        end
    end))
    
    AddConnection(RS.Heartbeat:Connect(function()
        if not Logic.KillAll then return end
        
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp or not hum then return end
        
        local knife = char:FindFirstChild("Knife") or (LP.Backpack and LP.Backpack:FindFirstChild("Knife"))
        if not knife then return end
        
        for _, player in ipairs(P:GetPlayers()) do
            if player ~= LP and player.Character then
                local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
                local targetHum = player.Character:FindFirstChild("Humanoid")
                if targetHRP and targetHum and targetHum.Health > 0 then
                    hrp.CFrame = targetHRP.CFrame
                    if knife:FindFirstChild("Remote") then
                        knife.Remote:FireServer()
                    end
                end
            end
        end
    end))
    
    local function Fling(t)
        if FlingActive then FlingActive = false return end
        if not t or not t.Character then return end
        FlingActive = true
        Sfx(SFX.T, 0.4)
        
        local TC = t.Character
        local TR = TC:FindFirstChild("HumanoidRootPart")
        local MC = LP.Character
        local MR = MC and MC:FindFirstChild("HumanoidRootPart")
        
        if not TR or not MR then FlingActive = false return end
        
        local OldFPDH = workspace.FallenPartsDestroyHeight
        local OldPos = MR.CFrame
        
        workspace.FallenPartsDestroyHeight = 0/0
        Cam.CameraSubject = TC
        MC.Humanoid.PlatformStand = true
        
        local BAV = Instance.new("BodyAngularVelocity", MR)
        BAV.MaxTorque = Vector3.one * math.huge
        BAV.AngularVelocity = Vector3.new(0, 100000, 0)
        
        local BT = Instance.new("BodyThrust", MR)
        BT.Force = Vector3.one * 20000
        
        task.spawn(function()
            local startTime = tick()
            while FlingActive and t.Parent and TC.Parent and MR.Parent do
                if TR.Position.Y < -50 or TC.Humanoid.Health <= 0 then break end
                if (tick() - startTime) > 15 then break end
                if TR.Velocity.Magnitude > 100 or TR.Velocity.Y > 50 then break end
                
                local Pred = TR.CFrame + (TR.Velocity * 0.15)
                local Jitter = Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))
                
                MR.CFrame = Pred + Jitter
                MR.Velocity = Vector3.one * 9e9
                MR.RotVelocity = Vector3.one * 9e9
                
                RS.Heartbeat:Wait()
            end
            
            if BAV then BAV:Destroy() end
            if BT then BT:Destroy() end
            if MR then
                MR.Velocity = Vector3.zero
                MR.RotVelocity = Vector3.zero
                MR.CFrame = OldPos
            end
            if MC and MC:FindFirstChild("Humanoid") then
                MC.Humanoid.PlatformStand = false
            end
            Cam.CameraSubject = LP.Character and LP.Character:FindFirstChild("Humanoid")
            workspace.FallenPartsDestroyHeight = OldFPDH
            FlingActive = false
        end)
    end
    
    local function FixUI()
        local pg = LP:FindFirstChild("PlayerGui")
        if pg then
            if pg:FindFirstChild("MysteryBoxOpen") then pg.MysteryBoxOpen:Destroy() end
            if pg:FindFirstChild("MainGUI") then
                if pg.MainGUI:FindFirstChild("CrateOpen") then pg.MainGUI.CrateOpen:Destroy() end
                pcall(function() pg.MainGUI.Lobby.Screens.Shop.Main.ViewCrate.Visible = false end)
            end
        end
        ClearTweens()
    end
    AddConnection(RS.RenderStepped:Connect(FixUI))
    
    local function Spawn(n)
        if not n or n == "" then return end
        if not DB_Item then return end
        
        local id = DB_Item[n] and n or nil
        if not id then
            for k, _ in pairs(DB_Item) do
                if k:lower() == n:lower() then id = k break end
            end
        end
        if not id then return end
        
        pcall(function()
            ShopRem:Fire("KnifeBox4", id)
            DB_Prof.Weapons.Owned[id] = (DB_Prof.Weapons.Owned[id] or 0) + 1
        end)
        
        task.spawn(function()
            FixUI()
            pcall(function()
                getsenv(LP.PlayerGui.MainGUI.Inventory.NewItem)._G.NewItem(id, nil, nil, "Weapons", 1)
            end)
        end)
        
        task.delay(1.5, function()
            if LP.Character then LP.Character:BreakJoints() end
        end)
    end
    
    local ESPHighlights = {}
    
    local function CleanupESP(player)
        if ESPHighlights[player] then
            pcall(function() ESPHighlights[player]:Destroy() end)
            ESPHighlights[player] = nil
        end
    end
    
    local function UpdateESP()
        for _, p in ipairs(P:GetPlayers()) do
            if p ~= LP and p.Character then
                local role = Role(p)
                local color = Logic.ESP.Colors.Innocent
                if role == "Murderer" then 
                    color = Logic.ESP.Colors.Murderer
                elseif role == "Sheriff" then 
                    color = Logic.ESP.Colors.Sheriff
                end
                
                if Logic.ESP.Enabled then
                    local existingHL = ESPHighlights[p]
                    if not existingHL or existingHL.Parent ~= p.Character then
                        CleanupESP(p)
                        local h = Instance.new("Highlight")
                        h.Name = "ZEPH"
                        h.FillTransparency = 0.5
                        h.OutlineTransparency = 1
                        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        h.Parent = p.Character
                        ESPHighlights[p] = h
                    end
                    
                    if ESPHighlights[p] then
                        ESPHighlights[p].FillColor = color
                    end
                else
                    CleanupESP(p)
                end
            else
                CleanupESP(p)
            end
        end
    end
    
    AddConnection(RS.Heartbeat:Connect(UpdateESP))
    
    AddConnection(P.PlayerRemoving:Connect(function(p)
        CleanupESP(p)
        RoleCache[p] = nil
    end))
    
    for _, player in ipairs(P:GetPlayers()) do
        if player ~= LP then
            AddConnection(player.CharacterAdded:Connect(function()
                CleanupESP(player)
                RoleCache[player] = nil
            end))
        end
    end
    
    AddConnection(P.PlayerAdded:Connect(function(player)
        AddConnection(player.CharacterAdded:Connect(function()
            CleanupESP(player)
            RoleCache[player] = nil
        end))
    end))
    
    local Win = W:CreateWindow({
        Title = "UndetectedScript",
        Icon = "zap",
        Author = "The Peak",
        Folder = "UndetectedScript",
        Size = UDim2.fromOffset(580, 460),
        Theme = "Dark",
        Resizable = true,
        Transparent = true
    })
    
    Win:SetToggleKey(Enum.KeyCode.RightControl)
    Win:EditOpenButton({
        Title = "Zeph",
        Icon = "zap",
        CornerRadius = UDim.new(0, 10),
        StrokeThickness = 2,
        Color = ColorSequence.new(Color3.fromRGB(0, 255, 255), Color3.fromRGB(0, 100, 255)),
        Enabled = true,
        Draggable = true
    })
    
    local T = {
        H = Win:Tab({Title = "Home", Icon = "home"}),
        F = Win:Tab({Title = "Farm", Icon = "bot"}),
        Fl = Win:Tab({Title = "Fling", Icon = "swords"}),
        C = Win:Tab({Title = "Combat", Icon = "crosshair"}),
        E = Win:Tab({Title = "ESP", Icon = "eye"}),
        M = Win:Tab({Title = "Music", Icon = "music"}),
        U = Win:Tab({Title = "Misc", Icon = "wrench"}),
        S = Win:Tab({Title = "Settings", Icon = "settings"})
    }
    
    T.H:Section({Title = "Welcome", Box = true, Opened = true}):Paragraph({
        Title = "UndetectedScript",
        Content = "Toggle: RightControl"
    })
    
    local InfoS = T.H:Section({Title = "Game Info", Box = true, Opened = true})
    local BagLabel = InfoS:Paragraph({
        Title = "Bag",
        Content = "0 / 50",
        Icon = "shopping-bag"
    })
    
    task.spawn(function()
        while task.wait(0.5) do
            BagLabel:SetDesc(FarmState.CoinsCollected .. " / " .. Config.MaxCandy)
        end
    end)
    
    local BotS = T.F:Section({Title = "Auto Farm", Box = true, Opened = true})
    
    local StatusLabel = BotS:Paragraph({
        Title = "Status",
        Content = "Waiting..."
    })
    
    task.spawn(function()
        while task.wait(1) do
            if Logic.CoinFarm then
                local inLobby = IsInLobby()
                if inLobby then
                    StatusLabel:SetDesc("Paused (Lobby)")
                else
                    StatusLabel:SetDesc("Farming: " .. FarmState.CoinsCollected .. " / " .. Config.MaxCandy)
                end
            else
                StatusLabel:SetDesc("Disabled")
            end
        end
    end)
    
    local FarmT = BotS:Toggle({
        Title = "Enable Coin Farm",
        Callback = function(v)
            Logic.CoinFarm = v
            Sfx(SFX.T, 0.3)
            if not v then ClearIgnoreList() end
        end
    })
    BotS:Keybind({Title = "Toggle Key", Value = "None", Callback = function() FarmT:Set(not Logic.CoinFarm) end})
    BotS:Toggle({Title = "Auto Reset", Value = false, Callback = function(v) Logic.AutoReset = v end})
    BotS:Toggle({Title = "Avoid Murderer", Value = true, Callback = function(v) Logic.AvoidMurderer = v end})
    BotS:Slider({Title = "Farm Speed", Step = 1, Value = {Min = 10, Max = 32, Default = 30}, Callback = function(v) Config.FarmSpeed = v end})
    BotS:Slider({Title = "Evade Distance", Step = 1, Value = {Min = 10, Max = 50, Default = 25}, Callback = function(v) Config.EvadeDistance = v end})
    BotS:Button({Title = "Clear Stuck Coins", Callback = function()
        ClearIgnoreList()
    end})
    
    local FlingS = T.Fl:Section({Title = "Fling", Box = true, Opened = true})
    local PlayerList = {}
    local FlingTarget = ""
    
    local function UpdatePlayers()
        PlayerList = {}
        for _, v in pairs(P:GetPlayers()) do
            if v ~= LP then table.insert(PlayerList, v.Name) end
        end
    end
    UpdatePlayers()
    
    local PlayerDrop = FlingS:Dropdown({
        Title = "Target",
        Values = PlayerList,
        Callback = function(v) FlingTarget = v Sfx(SFX.C, 0.3) end
    })
    FlingS:Button({Title = "Refresh", Callback = function()
        UpdatePlayers()
        PlayerDrop:Refresh(PlayerList)
        Sfx(SFX.C, 0.3)
    end})
    FlingS:Button({Title = "Fling", Callback = function()
        local target = P:FindFirstChild(FlingTarget)
        if target then
            Fling(target)
        end
    end})
    FlingS:Button({Title = "Stop", Callback = function() FlingActive = false Sfx(SFX.C, 0.3) end})
    
    local CombS = T.C:Section({Title = "Combat", Box = true, Opened = true})
    CombS:Toggle({Title = "Kill All (Murderer Only)", Callback = function(v) Logic.KillAll = v end})
    
    local EspS = T.E:Section({Title = "ESP", Box = true, Opened = true})
    EspS:Toggle({Title = "Enable", Value = true, Callback = function(v)
        Logic.ESP.Enabled = v
        if not v then
            for p, _ in pairs(ESPHighlights) do CleanupESP(p) end
        end
    end})
    EspS:Colorpicker({Title = "Murderer", Default = Color3.fromRGB(255, 50, 50), Callback = function(v) Logic.ESP.Colors.Murderer = v end})
    EspS:Colorpicker({Title = "Sheriff", Default = Color3.fromRGB(50, 50, 255), Callback = function(v) Logic.ESP.Colors.Sheriff = v end})
    EspS:Colorpicker({Title = "Innocent", Default = Color3.fromRGB(50, 255, 50), Callback = function(v) Logic.ESP.Colors.Innocent = v end})
    
    local WorldS = T.E:Section({Title = "World", Box = true})
    WorldS:Toggle({Title = "Fullbright", Callback = function(v)
        L.Brightness = v and 2 or 1
        L.GlobalShadows = not v
    end})
    
    local MS = T.M:Section({Title = "Music", Box = true, Opened = true})
    local SongNames = {}
    for _, s in ipairs(WebSongs) do table.insert(SongNames, s.N) end
    
    MS:Dropdown({Title = "Select Song", Values = SongNames, Callback = function(v)
        for _, s in ipairs(WebSongs) do
            if s.N == v then
                PlayM(s)
                break
            end
        end
    end})
    
    MS:Button({Title = "Download ALL Songs (Background)", Callback = function()
        task.spawn(function()
            for _, s in ipairs(WebSongs) do
                if s.U ~= "" then
                    local fn = Sanitize(s.N)
                    if not isfile(FOLDER_NAME .. "/" .. fn) then
                        DownloadFile(s.U, fn)
                        task.wait(0.1)
                    end
                end
            end
        end)
    end})
    
    MS:Input({Title = "Custom ID or MP3 URL", Placeholder = "ID or Link...", Callback = function(v)
        if v:find("http") then
            PlayM({N = "Custom", U = v})
        else
            local id = v:match("%d+")
            if id then
                local s = Instance.new("Sound")
                s.SoundId = "rbxassetid://" .. id
                s.Volume = MP.Vol
                s.Looped = true
                s.Parent = SS
                s:Play()
                MP.Snd = s
                MP.On = true
            end
        end
    end})
    
    MS:Slider({Title = "Volume", Step = 0.1, Value = {Min = 0, Max = 1, Default = 0.5}, Callback = function(v) SetVol(v) end})
    MS:Button({Title = "Stop", Callback = function() StopM() Sfx(SFX.C, 0.3) end})
    
    local TpS = T.U:Section({Title = "Teleport", Box = true})
    TpS:Button({Title = "To Murderer", Callback = function()
        for _, p in pairs(P:GetPlayers()) do
            if Role(p) == "Murderer" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                LP.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                Sfx(SFX.S, 0.4)
                return
            end
        end
    end})
    TpS:Button({Title = "To Sheriff", Callback = function()
        for _, p in pairs(P:GetPlayers()) do
            if Role(p) == "Sheriff" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                LP.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                Sfx(SFX.S, 0.4)
                return
            end
        end
    end})
    TpS:Button({Title = "To Gun", Callback = function()
        local g = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("DroppedGun")
        if g then
            LP.Character.HumanoidRootPart.CFrame = g.CFrame
            Sfx(SFX.S, 0.4)
        end
    end})
    
    local SpS = T.U:Section({Title = "Spawner", Box = true})
    SpS:Input({Title = "Item", Placeholder = "Icewing", Callback = function(v) _G.ITS = v end})
    SpS:Button({Title = "Spawn", Callback = function() Spawn(_G.ITS) Sfx(SFX.C, 0.3) end})
    
    local RwS = T.U:Section({Title = "Rewards", Box = true})
    RwS:Button({Title = "Get Rewards", Callback = function()
        GetRewards()
    end})
    RwS:Button({Title = "Clear Tweens", Callback = function()
        ClearTweens()
    end})
    
    local LoS = T.U:Section({Title = "Local", Box = true})
    LoS:Slider({Title = "Speed", Step = 1, Value = {Min = 16, Max = 200, Default = 16}, Callback = function(v) getgenv().GWS = v end})
    LoS:Slider({Title = "Jump", Step = 1, Value = {Min = 50, Max = 200, Default = 50}, Callback = function(v) getgenv().GJP = v end})
    LoS:Slider({Title = "FOV", Step = 1, Value = {Min = 70, Max = 120, Default = 70}, Callback = function(v) Cam.FieldOfView = v end})
    
    local SetS = T.S:Section({Title = "UI", Box = true})
    SetS:Dropdown({Title = "Theme", Values = {"Dark", "Rose", "Aqua"}, Value = "Dark", Callback = function(v) W:SetTheme(v) end})
    SetS:Button({Title = "Copy Discord", Callback = function()
        setclipboard("discord.gg/zephhub")
    end})
    SetS:Button({Title = "Destroy", Callback = function()
        StopM()
        CleanupConnections()
        for p, _ in pairs(ESPHighlights) do CleanupESP(p) end
        W:Destroy()
        getgenv().UndetectedScriptLoaded = nil
    end})
    
    AddConnection(RS.RenderStepped:Connect(function()
        if LP.Character and LP.Character:FindFirstChild("Humanoid") then
            local hum = LP.Character.Humanoid
            if getgenv().GWS > 16 then
                hum.WalkSpeed = getgenv().GWS
            end
            if getgenv().GJP > 50 then
                hum.UseJumpPower = true
                hum.JumpPower = getgenv().GJP
            end
        end
    end))
end

task.spawn(function()
    local success, err = pcall(function()
        Main()
    end)
    if not success then
        warn("UndetectedScript Error:", err)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "UndetectedScript Error",
            Text = "Failed to load. Check console (F9)",
            Duration = 10
        })
    end
end)
