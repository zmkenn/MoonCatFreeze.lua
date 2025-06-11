-- 🌐 Remote Loadstring-Compatible Version
-- Upload this script to GitHub, then load it via Delta using:
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/YourName/YourRepo/main/mooncat_freeze.lua"))()

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
                        part.CFrame = cf:ToWorldSpace(part.CFrame:ToObjectSpace(part.CFrame))
                        part.Velocity = Vector3.zero
                        part.RotVelocity = Vector3.zero
                    end
                end
            end
        end
    end
end)

print("✅ Moon Cat HARD freeze (Remote Version) running")
