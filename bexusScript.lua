local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

print("BEXUS ULTIMATE AKTIF! 😈")
print("KETIK: Help() UNTUK LIHAT SEMUA PERINTAH!")

-- ==================== BYPASS ====================
spawn(function()
    while true do
        wait(1)
        for i, v in pairs(player.PlayerScripts:GetChildren()) do
            if v.Name:lower():find("anticheat") or v.Name:lower():find("ac") or v.Name:lower():find("exploit") then
                v:Destroy()
            end
        end
        for i, v in pairs(game.Workspace:GetChildren()) do
            if v.Name:lower():find("detector") or v.Name:lower():find("anti") then
                v:Destroy()
            end
        end
        for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            if v:IsA("RemoteEvent") and (v.Name:lower():find("kick") or v.Name:lower():find("ban")) then
                v.OnClientEvent:Connect(function() end)
            end
        end
        game:GetService("LogService"):SetLogLevel(Enum.LogLevel.Error)
    end
end)

-- ==================== DAFTAR PULAU ====================
local islands = {
    -- SEA 1
    Bandit = CFrame.new(-1200, 20, 200),
    Jungle = CFrame.new(800, 30, -500),
    Pirate = CFrame.new(300, 15, 1500),
    Marine = CFrame.new(-500, 20, -800),
    Sky = CFrame.new(0, 1000, 0),
    Snow = CFrame.new(-2000, 50, 1000),
    Magma = CFrame.new(1500, 25, -1200),
    Dark = CFrame.new(-1800, 30, 1800),
    Forgotten = CFrame.new(2000, 20, -2000),
    Fishman = CFrame.new(-1500, 20, -1500),
    -- SEA 2
    Ice = CFrame.new(-2500, 30, 2500),
    Dragon = CFrame.new(2500, 40, -2500),
    Stone = CFrame.new(-3000, 35, 3000),
    Admiral = CFrame.new(3000, 50, -3000),
    -- SEA 3
    Sea3_1 = CFrame.new(4000, 50, 4000),
    Sea3_2 = CFrame.new(4500, 50, -4500),
    Sea3_3 = CFrame.new(-4000, 50, 4000),
    Sea3_4 = CFrame.new(-4500, 50, -4500),
    Sea3_5 = CFrame.new(5000, 60, 5000),
    Sea3_6 = CFrame.new(-5000, 60, -5000),
    Sea3_7 = CFrame.new(5500, 70, -5500),
    Sea3_8 = CFrame.new(-5500, 70, 5500),
    -- BOSS SPAWN
    Boss_Bandit = CFrame.new(-1200, 20, 300),
    Boss_Jungle = CFrame.new(850, 30, -450),
    Boss_Pirate = CFrame.new(350, 15, 1550),
    Boss_Marine = CFrame.new(-450, 20, -750),
    Boss_Sky = CFrame.new(0, 1050, 0),
    Boss_Snow = CFrame.new(-1950, 50, 1050),
    Boss_Magma = CFrame.new(1550, 25, -1150),
    Boss_Dark = CFrame.new(-1750, 30, 1850),
    Boss_Forgotten = CFrame.new(2050, 20, -1950),
    Boss_Ice = CFrame.new(-2450, 30, 2550),
    Boss_Dragon = CFrame.new(2550, 40, -2450),
    Boss_Stone = CFrame.new(-2950, 35, 3050),
    Boss_Admiral = CFrame.new(3050, 50, -2950),
}

-- ==================== FITUR TELEPORT ====================
function Teleport(islandName)
    if islands[islandName] then
        root.CFrame = islands[islandName]
        print("✅ Teleport ke " .. islandName)
    else
        print("❌ Pulau " .. islandName .. " gak ada! Ketik ListIslands() buat liat daftar.")
    end
end

function ListIslands()
    print("=== DAFTAR PULAU ===")
    print("SEA 1: Bandit, Jungle, Pirate, Marine, Sky, Snow, Magma, Dark, Forgotten, Fishman")
    print("SEA 2: Ice, Dragon, Stone, Admiral")
    print("SEA 3: Sea3_1, Sea3_2, Sea3_3, Sea3_4, Sea3_5, Sea3_6, Sea3_7, Sea3_8")
    print("BOSS: Boss_Bandit, Boss_Jungle, Boss_Pirate, Boss_Marine, Boss_Sky, Boss_Snow, Boss_Magma, Boss_Dark, Boss_Forgotten, Boss_Ice, Boss_Dragon, Boss_Stone, Boss_Admiral")
end

-- ==================== FITUR AUTO TP FRUIT ====================
local fruitMode = "nearest"
function AutoTPFruit(mode)
    fruitMode = mode or "nearest"
    spawn(function()
        while true do
            wait(0.5)
            local target = nil
            local best = (fruitMode == "nearest") and math.huge or -math.huge
            for i, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Model") and (v.Name:lower():find("fruit") or v.Name:lower():find("buah")) then
                    local handle = v:FindFirstChild("Handle")
                    if handle then
                        local mag = (root.Position - handle.Position).Magnitude
                        if (fruitMode == "nearest" and mag < best) or (fruitMode == "farthest" and mag > best) then
                            best = mag
                            target = v
                        end
                    end
                end
            end
            if target then
                local handle = target:FindFirstChild("Handle")
                if handle then
                    root.CFrame = handle.CFrame * CFrame.new(0, 2, 0)
                    print("🍎 TP ke " .. target.Name .. " - Jarak: " .. math.floor(best))
                end
            else
                wait(2)
            end
        end
    end)
    print("🍎 Auto TP Fruit: " .. fruitMode)
end

-- ==================== FITUR AUTO FARM ====================
_G.farm = false
function AutoFarm()
    _G.farm = not _G.farm
    if _G.farm then
        spawn(function()
            while _G.farm do
                wait(0.1)
                local target = nil
                local dist = math.huge
                for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        local mag = (root.Position - v.HumanoidRootPart.Position).Magnitude
                        if mag < dist and mag < 100 then
                            dist = mag
                            target = v
                        end
                    end
                end
                if target then
                    root.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Q", false, nil)
                    wait(0.05)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, "Q", false, nil)
                end
            end
        end)
        print("🌊 Auto Farm: ON")
    else
        print("🌊 Auto Farm: OFF")
    end
end

-- ==================== FITUR GOD MODE ====================
_G.god = false
function GodMode()
    _G.god = not _G.god
    if _G.god then
        spawn(function()
            while _G.god do
                wait(0.01)
                if character:FindFirstChild("Humanoid") then
                    humanoid.Health = humanoid.MaxHealth
                    humanoid.BreakJointsOnDeath = false
                end
            end
        end)
        print("🛡️ God Mode: ON")
    else
        print("🛡️ God Mode: OFF")
    end
end

-- ==================== FITUR FAST ATTACK ====================
_G.fast = false
function FastAttack()
    _G.fast = not _G.fast
    if _G.fast then
        spawn(function()
            while _G.fast do
                wait(0.0001)
                for i, v in pairs(character:GetChildren()) do
                    if v:IsA("Tool") then
                        v:Activate()
                    end
                end
            end
        end)
        print("⚡ Fast Attack: ON")
    else
        print("⚡ Fast Attack: OFF")
    end
end

-- ==================== FITUR INFINITE ENERGY ====================
_G.energy = false
function InfiniteEnergy()
    _G.energy = not _G.energy
    if _G.energy then
        spawn(function()
            while _G.energy do
                wait(0.01)
                if player:FindFirstChild("Energy") then
                    player.Energy.Value = player.Energy.MaxValue
                end
            end
        end)
        print("♾️ Infinite Energy: ON")
    else
        print("♾️ Infinite Energy: OFF")
    end
end

-- ==================== FITUR AUTO COLLECT FRUIT ====================
_G.collect = false
function AutoCollect()
    _G.collect = not _G.collect
    if _G.collect then
        spawn(function()
            while _G.collect do
                wait(0.5)
                for i, v in pairs(game.Workspace:GetChildren()) do
                    if v:IsA("Model") and (v.Name:lower():find("fruit") or v.Name:lower():find("buah")) then
                        local handle = v:FindFirstChild("Handle")
                        if handle then
                            root.CFrame = handle.CFrame * CFrame.new(0, 2, 0)
                            wait(0.2)
                            v:Destroy()
                            print("🍎 Buah " .. v.Name .. " dikolek!")
                        end
                    end
                end
            end
        end)
        print("🍏 Auto Collect Fruit: ON")
    else
        print("🍏 Auto Collect Fruit: OFF")
    end
end

-- ==================== FITUR AUTO RAID ====================
_G.raid = false
function AutoRaid()
    _G.raid = not _G.raid
    if _G.raid then
        spawn(function()
            while _G.raid do
                wait(0.1)
                for i, v in pairs(game.Workspace.Raid:GetChildren()) do
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        root.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "Q", false, nil)
                    end
                end
            end
        end)
        print("🏚️ Auto Raid: ON")
    else
        print("🏚️ Auto Raid: OFF")
    end
end

-- ==================== FITUR AUTO BOSS ====================
_G.boss = false
function AutoBoss()
    _G.boss = not _G.boss
    if _G.boss then
        spawn(function()
            while _G.boss do
                wait(0.5)
                for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v.Name:lower():find("boss") then
                        root.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "Q", false, nil)
                    end
                end
            end
        end)
        print("👹 Auto Boss: ON")
    else
        print("👹 Auto Boss: OFF")
    end
end

-- ==================== FITUR AUTO BOUNTY ====================
_G.bounty = false
function AutoBounty()
    _G.bounty = not _G.bounty
    if _G.bounty then
        spawn(function()
            while _G.bounty do
                wait(1)
                for i, v in pairs(game.Players:GetChildren()) do
                    if v ~= player then
                        local char = v.Character
                        if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
                            root.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Q", false, nil)
                        end
                    end
                end
            end
        end)
        print("💰 Auto Bounty: ON")
    else
        print("💰 Auto Bounty: OFF")
    end
end

-- ==================== FITUR KILL ALL ====================
function KillAll()
    for i, v in pairs(game.Players:GetChildren()) do
        if v ~= player then
            local char = v.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.Health = 0
            end
        end
    end
    print("💀 Kill All: Semua player mati!")
end

-- ==================== FITUR SPEED HACK ====================
_G.speed = false
function SpeedHack()
    _G.speed = not _G.speed
    if _G.speed then
        spawn(function()
            while _G.speed do
                wait(0.01)
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.WalkSpeed = 350
                end
            end
        end)
        print("💨 Speed Hack: ON")
    else
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.WalkSpeed = 16
        end
        print("💨 Speed Hack: OFF")
    end
end

-- ==================== FITUR AUTO DANCE ====================
_G.dance = false
function AutoDance()
    _G.dance = not _G.dance
    if _G.dance then
        spawn(function()
            while _G.dance do
                wait(0.5)
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid.Sit = false
                    character.Humanoid.Jump = true
                    wait(0.1)
                    character.Humanoid.Jump = false
                end
            end
        end)
        print("💃 Auto Dance: ON")
    else
        print("💃 Auto Dance: OFF")
    end
end

-- ==================== FITUR REKOMENDASI BUAH TERBAIK ====================
function BestFruits()
    print("=== REKOMENDASI BUAH BLOX FRUIT ===")
    print("1. Kitsune - Terbaik untuk PvP dan Grinding (Logia)")
    print("2. Venom - Damage tinggi, cocok untuk Boss")
    print("3. Dragon - AOE luas, bagus untuk Raid")
    print("4. Leopard - Cepat dan damage besar")
    print("5. Dough - Kombonya gila, susah di-counter")
    print("6. Dark - Pilihan murah tapi efektif")
    print("7. Light - Terbaik buat mobile dan farm")
    print("8. Flame - Buah pemula yang solid")
    print("9. Ice - CC yang bagus untuk PvP")
    print("10. Magma - Damage besar, bagus untuk Sea Beast")
    print("")
    print("💡 Tips: Kalo mau farming, pake Kitsune atau Light.")
    print("💡 Kalo mau PvP, pake Leopard atau Dough.")
    print("😈🤪👎")
end

-- ==================== FITUR SET WALKSPEED/JUMP ====================
function SetSpeed(speed)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = speed
        print("🏃 WalkSpeed: " .. speed)
    end
end

function SetJump(jump)
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.JumpPower = jump
        print("🦘 JumpPower: " .. jump)
    end
end

-- ==================== HELP MENU ====================
function Help()
    print("")
    print("====================")
    print("  BEXUS ULTIMATE")
    print("====================")
    print("")
    print("=== TELEPORT ===")
    print("Teleport('Nama') - TP ke pulau")
    print("ListIslands() - Lihat daftar pulau")
    print("")
    print("=== AUTO FARM ===")
    print("AutoFarm() - Toggle auto farm")
    print("AutoTPFruit('nearest') - TP ke buah terdekat")
    print("AutoTPFruit('farthest') - TP ke buah terjauh")
    print("AutoCollect() - Toggle auto collect buah")
    print("")
    print("=== FIGHT ===")
    print("GodMode() - Toggle god mode")
    print("FastAttack() - Toggle fast attack")
    print("InfiniteEnergy() - Toggle infinite energy")
    print("AutoRaid() - Toggle auto raid")
    print("AutoBoss() - Toggle auto boss")
    print("AutoBounty() - Toggle auto bounty")
    print("KillAll() - Bunuh semua player")
    print("")
    print("=== EXTRA ===")
    print("SpeedHack() - Toggle speed hack")
    print("AutoDance() - Toggle auto dance")
    print("SetSpeed(angka) - Set walk speed")
    print("SetJump(angka) - Set jump power")
    print("BestFruits() - Rekomendasi buah terbaik")
    print("")
    print("=== CONTOH ===")
    print("Teleport('Bandit')")
    print("AutoFarm()")
    print("SetSpeed(200)")
    print("====================")
    print("😈🤪👎")
end

-- ==================== SET DEFAULT ====================
SetSpeed(100)
SetJump(200)

-- ==================== PANDUAN AWAL ====================
print("")
print("====================")
print("  BEXUS ULTIMATE")
print("====================")
print("✅ SEMUA FITUR LENGKAP!")
print("✅ KETIK Help() UNTUK LIHAT SEMUA PERINTAH!")
print("✅ CONTOH: Teleport('Bandit')")
print("====================")
print("😈🤪👎")