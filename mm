-- ✅ Moon Cat Freeze Script (final version)
-- Upload to GitHub with filename: MoonCatFreeze.lua
-- Use this exact loadstring to run in Delta:
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/zmkenn/MoonCatFreeze.lua/main/MoonCatFreeze.lua"))()

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local RunService = game:GetService("RunService")
local frozenPositions = {}

local function getPrimaryPart(model)
    return model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
end

local function hardFreeze(model)
    if not frozenPositions[model] then
        local primary = getPrimaryPart(model)
        if primary then
            frozenPositions[model] = primary.CFrame
        end
    end
end

RunService.Heartbeat:Connect(function()
    for _, model in ipairs(workspace:GetDescendants()) do
        if model:IsA("Model") and string.find(model.Name, "Moon Cat") then
            hardFreeze(model)
            local cf = frozenPositions[model]
            if cf then
                for _, part in ipairs(model:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Anchored = true
                        part.CFrame = cf
                        part.Velocity = Vector3.zero
                        part.RotVelocity = Vector3.zero
                    end
                end
            end
        end
    end
end)

print("✅ Moon Cat freeze script running")
