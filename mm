-- ✅ FINAL Moon Cat Freeze Script for Delta
-- Upload this as MoonCatFreeze.lua in your GitHub repo
-- Use: loadstring(game:HttpGet("https://raw.githubusercontent.com/zmkenn/MoonCatFreeze.lua/main/MoonCatFreeze.lua"))()

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local function getMoonCats()
    local found = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:find("Moon Cat") then
            local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if primary then
                table.insert(found, {Model = obj, Part = primary, FreezeCFrame = primary.CFrame})
            end
        end
    end
    return found
end

local moonCats = getMoonCats()

RunService.Heartbeat:Connect(function()
    for _, data in ipairs(moonCats) do
        local model = data.Model
        local part = data.Part
        if model and part and part:IsDescendantOf(Workspace) then
            for _, p in ipairs(model:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.Anchored = true
                    p.CFrame = data.FreezeCFrame
                    p.Velocity = Vector3.zero
                    p.RotVelocity = Vector3.zero
                end
            end
        end
    end
end)

print("✅ Moon Cat FREEZE ACTIVE")
