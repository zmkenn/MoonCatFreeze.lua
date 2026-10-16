-- RollbackSecurityTest.server.lua
-- USE IN A TEST COPY OF YOUR OWN EXPERIENCE

local Players = game:GetService("Players")

local TESTING = true

-- Replace these two functions with your game's real profile functions.
local function getState(player)
	-- Example state
	return {
		Coins = player:GetAttribute("Coins") or 0,
	}
end

local function applyState(player, state)
	player:SetAttribute("Coins", state.Coins)
end

local snapshots = {}

local function copyTable(t)
	local result = {}

	for k, v in pairs(t) do
		if type(v) == "table" then
			result[k] = copyTable(v)
		else
			result[k] = v
		end
	end

	return result
end

Players.PlayerAdded:Connect(function(player)
	if not TESTING then
		return
	end

	task.wait(2)

	-- STATE A
	local original = getState(player)
	snapshots[player.UserId] = copyTable(original)

	print("[ROLLBACK TEST] Original state:", original.Coins)

	-- Simulate a transaction.
	local changed = copyTable(original)
	changed.Coins += 1000

	applyState(player, changed)

	print("[ROLLBACK TEST] Transaction applied:", changed.Coins)

	-- Simulate the situation where the transaction happened
	-- but persistence failed.
	print("[ROLLBACK TEST] SIMULATING SAVE FAILURE")

	task.wait(2)

	-- Simulate loading the previously persisted state.
	local oldState = snapshots[player.UserId]
	applyState(player, oldState)

	local final = getState(player)

	if final.Coins == original.Coins then
		warn(
			"[ROLLBACK DETECTED]",
			"Transaction state disappeared:",
			changed.Coins,
			"->",
			final.Coins
		)
	else
		print("[PASS] Transaction survived persistence test.")
	end
end)

Players.PlayerRemoving:Connect(function(player)
	snapshots[player.UserId] = nil
end)
