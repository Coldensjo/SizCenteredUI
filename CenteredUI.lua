-- Centered UI: shrinks UIParent to a centered region so every Blizzard frame
-- (gossip, quest, merchant, bags, etc.) behaves as if the screen were 16:9.
-- The 3D world (WorldFrame) keeps rendering at full ultrawide width.

local defaults = { enabled = true, aspect = 16 / 9 }
local pending = false

local function Apply()
    if InCombatLockdown() then
        pending = true -- moving UIParent in combat is blocked; retry after combat
        return
    end
    pending = false

    -- Screen size expressed in UIParent's own (scaled) units
    local height = WorldFrame:GetHeight() * WorldFrame:GetEffectiveScale() / UIParent:GetEffectiveScale()
    local width = WorldFrame:GetWidth() * WorldFrame:GetEffectiveScale() / UIParent:GetEffectiveScale()
    local target = width
    if CenteredUIDB.enabled then
        target = math.min(width, height * CenteredUIDB.aspect)
    end

    UIParent:ClearAllPoints()

    -- Explicit size plus an explicit left offset from the screen's top-left,
    -- rather than center anchors, which the client doesn't honor for UIParent.
    UIParent:SetSize(target, height)
    UIParent:SetPoint("TOPLEFT", nil, "TOPLEFT", (width - target) / 2, 0)
end

-- Screen/scale values may not be updated yet when the event fires
local function ApplyNextFrame()
    C_Timer.After(0, Apply)
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("DISPLAY_SIZE_CHANGED")
f:RegisterEvent("UI_SCALE_CHANGED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" then
        if arg1 ~= "CenteredUI" then return end
        CenteredUIDB = CenteredUIDB or {}
        for k, v in pairs(defaults) do
            if CenteredUIDB[k] == nil then CenteredUIDB[k] = v end
        end
        Apply()
    elseif event == "PLAYER_REGEN_ENABLED" then
        if pending then Apply() end
    else
        ApplyNextFrame()
    end
end)

SLASH_CENTEREDUI1 = "/centeredui"
SLASH_CENTEREDUI2 = "/cui"
SlashCmdList.CENTEREDUI = function(msg)
    msg = strtrim(msg or ""):lower()
    local a, b = msg:match("^(%d+%.?%d*)[:x/](%d+%.?%d*)$")
    if msg == "on" or msg == "off" then
        CenteredUIDB.enabled = (msg == "on")
    elseif msg == "debug" then
        print(("|cff33ff99CenteredUI|r: World %.0fx%.0f (scale %.3f)  UIParent left=%.0f width=%.0f height=%.0f (scale %.3f)"):format(
            WorldFrame:GetWidth(), WorldFrame:GetHeight(), WorldFrame:GetEffectiveScale(),
            UIParent:GetLeft() or -1, UIParent:GetWidth(), UIParent:GetHeight(), UIParent:GetEffectiveScale()))
        return
    elseif msg == "" then
        CenteredUIDB.enabled = not CenteredUIDB.enabled
    elseif a and b and tonumber(b) > 0 and tonumber(a) / tonumber(b) >= 1 then
        CenteredUIDB.aspect = tonumber(a) / tonumber(b)
        CenteredUIDB.enabled = true
    else
        print("|cff33ff99CenteredUI|r: /cui [on|off|16:9|21:9|debug] (aspect must be at least 1:1)")
        return
    end
    Apply()
    print(("|cff33ff99CenteredUI|r: %s, aspect %.3f"):format(
        CenteredUIDB.enabled and "enabled" or "disabled", CenteredUIDB.aspect))
end
