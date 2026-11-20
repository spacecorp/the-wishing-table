-- init
TheWishingTable.TheWishingAdditions = {}
local feature = "TheWishingAdditions"

-- Spell categories announced by this file (see the prefix block in speakconsumableSpell).
-- The remaining categories are handled in TheWishingTable.lua.
local HANDLED_CATEGORIES = {
  summoning = true,
  summoning_portal = true,
  demonic_gateway = true,
  mage_portal = true,
  repairbot = true,
  campfire = true,
  chair = true,
  anvil = true,
  mailbox = true,
}

function TheWishingTable.TheWishingAdditions.speakconsumableSpell(spellId)
  local pickedLine

  -- player info
  local Class = TheWishingTable.Constants.Class
  local Race = TheWishingTable.Constants.Race
  local playerName, playerGender, playerClass, playerRace, playerLevel =
    TheWishingTable.Helpers.GetPlayerInformation()

  -- dateFormat
  local rawTime = date("*t")
  local d = {
    day = rawTime.day,
    month = rawTime.month,
    year = rawTime.year,
  }

  -- get the current place of the player
  local zoneName = GetZoneText()

  local spellCategory = spellId and TheWishingTable.SpellIds.getSpellCategory(spellId) or nil

  local spellName = "This feast"
  if spellId then
    local ok, name = pcall(GetSpellInfo, spellId)
    spellName = (ok and name) or "The consumable"
  end

  -- In debug mode, randomly pick a category for unknown spells
  if not spellCategory and TheWishingTableVars and TheWishingTableVars.debugMode == true then
    local categories = { "summoning", "summoning_portal", "demonic_gateway", "mage_portal", "repairbot", "campfire", "chair", "anvil", "mailbox" }
    spellCategory = categories[fastrandom(1, #categories)]
  end

  -- prefix
  local prefixText = ""
  
  if (spellCategory == "summoning") then
    prefixText = "Summoning"
  elseif (spellCategory == "summoning_portal") then
    prefixText = "Summoning portal"
  elseif (spellCategory == "demonic_gateway") then
    prefixText = "Demonic gateway"
  elseif (spellCategory == "mage_portal") then
    prefixText = "Portal"
  elseif (spellCategory == "repairbot") then
    prefixText = "Repair bot"
  elseif (spellCategory == "campfire") then
    prefixText = "Campfire"
  elseif (spellCategory == "chair") then
    prefixText = "Chair"
  elseif (spellCategory == "anvil") then
    prefixText = "Anvil"
  elseif (spellCategory == "mailbox") then
    prefixText = "Mailbox"
  end

  local prefix = TheWishingTableVars.usePrefix == true and "[" .. prefixText .. " put down]: " or ""

  -- Time-of-day
  -- date("!%H") is the UTC hour; comparing with local gives us a rough timezone offset,
  -- which is good enough to guess whether someone is on UK time (UTC+0 GMT / UTC+1 BST).
  local localHour = tonumber(date("%H")) or 12
  local utcHour = tonumber(date("!%H")) or localHour
  local utcOffset = localHour - utcHour
  if utcOffset > 12 then
    utcOffset = utcOffset - 24
  elseif utcOffset < -12 then
    utcOffset = utcOffset + 24
  end
  local likelyUK = (utcOffset == 0 or utcOffset == 1)
  local consumableSpellLines = {}

  -- Genders
  local playerGuyGirl = TheWishingTable.Helpers.GetGuyGirl(playerGender)
  local playerManWoman = TheWishingTable.Helpers.GetManWoman(playerGender)
  local oppositeSex = "guys"

  if (playerGender == "male") then
    oppositeSex = "girls"
  end



  -- Table type
  if (spellCategory == "summoning_portal") then
     table.insert(consumableSpellLines, "Since some don't want to walk, it's up to us to open a summoning portal at the cost of kittens.")
  end

  if (spellCategory == "summoning") then
     table.insert(consumableSpellLines, "Since some don't want to walk, it's up to us to open a summoning portal at the cost of kittens.")
  end

  if (spellCategory == "demonic_gateway") then
     table.insert(consumableSpellLines, "Summoning presents for everyone, or an angry demon, who know!?")
  end

  if (spellCategory == "mage_portal") then
     table.insert(consumableSpellLines, "Opening a portal to happiness, or eternal limbo!")
  end

  if (spellCategory == "repairbot") then
     table.insert(consumableSpellLines, "Repair bot down! I repeat, repair bot do..ehh... UP!")
  end

  if (spellCategory == "campfire") then
     table.insert(consumableSpellLines, "Come tell us your stories at the campfire!")
  end

  if (spellCategory == "chair") then
     table.insert(consumableSpellLines, "This chair has magical powers!")
  end

  if (spellCategory == "anvil") then
     table.insert(consumableSpellLines, "Slam your hammers on this mighty anvil!")
  end

  if (spellCategory == "mailbox") then
     table.insert(consumableSpellLines, "Helping the postal service by delivering your this mailbox!")
  end


  -- Class/Race based
  if (playerRace == Race.Undead) then
      if (spellCategory == "demonic_gateway") then
        table.insert(consumableSpellLines, "Summining bags of bones!")
      end
      
      if (spellCategory == "mage_portal") then
        table.insert(consumableSpellLines, "Opening a portal to a peaceful graveyard!")
      end
  end

  if (playerClass == Class.Warlock) then
  end

  if (playerRace == Race.Undead or playerRace == Race.VoidElf) then
  end

  if (playerRace == Race.Dracthyr) then
  end

  if (playerRace == Race.HighmountainTauren or playerRace == Race.Tauren) then
  end

  if (playerRace == Race.Undead) then
  end

  if (playerRace == Race.HighmountainTauren or playerRace == Race.Tauren) then
  end

  if (playerRace == Race.HighmountainTauren) then
    local highmountainTaurenHomelands = { "Highmountain", "Thunder Totem" }
    local highmountainTaurenHomeland =
      highmountainTaurenHomelands[fastrandom(1, #highmountainTaurenHomelands)]
  end

  if (playerRace == Race.Tauren) then
    local taurenHomelands =
      { "Mulgore", "Thunder Bluff", "The Barrens", "Feralas", "Thousand Needles" }
    local taurenHomeland = taurenHomelands[fastrandom(1, #taurenHomelands)]
  end

  if (playerRace == Race.Dwarf or playerRace == Race.Earthen) then
  end

  if (playerClass == Class.DeathKnight) then
  end

  if (playerRace == Race.Dracthyr) then
  end

  if (playerRace == Race.LightforgedDraenei or playerClass == Class.Paladin or playerClass == Class.Priest) then
  end

  if (playerClass == Class.Priest) then
  end

  if (playerClass == Class.Druid and playerGender == "male") then
  end

  -- Zone specific
  -- Midnight
  if (zoneName == "The Voidspire" or zoneName == "The Dreamrift" or zoneName == "March on Quel'Danas") then
  end

  -- The war within
  if (zoneName == "Nerub-ar Palace" or zoneName == "Liberation of Undermine" or zoneName == "Mana Forge Omega" or zoneName == "Blackrock Depths") then
  end

  -- Shadowlands
  if (zoneName == "Revendreth" or zoneName == "Castle Nathria") then
  end

  -- Mushrooms
  if (zoneName == "Naxxramas" or zoneName == "Zangarmarsh" or zoneName == "Hallowfall" or zoneName == "Fungal Folly" or zoneName == "The Fungal Vale") then
  end

  -- Category-specific messages
  if spellCategory == "soul_well" then
  elseif spellCategory == "mage_table" then
  elseif spellCategory == "feast" then
  elseif spellCategory == "cauldron" then
    if (playerClass == Class.Shaman) then
    end
  end

  -- time of the day based messaged

  if localHour < 4 then
    -- Midnight snack (00:00 – 03:59)
  end

  if (localHour >= 2 and localHour < 3) then
  end

  if localHour >= 4 and localHour < 5 then
    -- 4am: the 'are you okay?' hour
  end

  if localHour >= 5 and localHour < 10 then
    -- Breakfast (05:00 – 09:59)

    if (playerClass == Class.Monk) then
    end
  end

  if localHour >= 10 and localHour < 12 then
    -- Brunch (10:00 – 11:59)
    if (localHour == 11 and (playerRace == Race.BloodElf or playerRace == Race.NightElf or playerRace == Race.Nightborne or playerRace == Race.Haranir)) then
    end
  end

  if localHour >= 12 and localHour < 14 then
    -- Lunch (12:00 – 13:59)
  end

  if localHour >= 14 and localHour < 18 then
    -- Afternoon tea (14:00 – 17:59)
    if likelyUK then
    end

    if localHour == 16 then
    end
  end

  if localHour >= 18 and localHour < 21 then
    -- Dinner (18:00 – 20:59)
  end

  if localHour >= 21 then
    -- Late-night supper (21:00 – 23:59)
  end

  -- Public festivities
  -- New Year's Day
  if (d.month == 1 and d.day == 1) then
  end

  -- Epiphany / Three Kings' Day
  if (d.month == 1 and d.day == 6) then
  end

  -- Valentine's Day
  if (d.month == 2 and d.day == 14) then  end

  -- Imbolc / Candlemas (Celtic spring festival)
  if (d.month == 2 and d.day == 1) then
  end

  -- International Women's Day
  if (d.month == 3 and d.day == 8) then
  end

  -- St. Patrick's Day
  if (d.month == 3 and d.day == 17) then
  end

  -- April Fools' Day
  if (d.month == 4 and d.day == 1) then
  end

  -- Earth Day
  if (d.month == 4 and d.day == 22) then
  end

  -- Cinco de Mayo
  if (d.month == 5 and d.day == 5) then
  end

  -- International Workers' Day / May Day / Beltane (Celtic festival)
  if (d.month == 5 and d.day == 1) then
  end

  -- Star Wars Day
  if (d.month == 5 and d.day == 4) then
  end

  -- Summer Solstice (Litha)
  if (d.month == 6 and d.day >= 20 and d.day <= 21) then
  end

  -- Pride Day
  if (d.month == 6 and d.day == 28) then
  end

  -- Independence Day (US)
  if (d.month == 7 and d.day == 4) then
  end

  -- Bastille Day (France)
  if (d.month == 7 and d.day == 14) then
  end

  -- Lammas (Lughnasadh, Celtic harvest festival)
  if (d.month == 8 and d.day == 1) then
  end

  -- International Cat Day
  if (d.month == 8 and d.day == 8) then
  end

  -- Autumn Equinox (Mabon, Celtic harvest festival)
  if (d.month == 9 and d.day >= 22 and d.day <= 23) then
  end

  -- Oktoberfest (mid-September to early October)
  if (d.month == 9 and d.day >= 16) or (d.month == 10 and d.day <= 3) then
  end

  -- Halloween / Samhain (Celtic new year)
  if (d.month == 10 and d.day == 31) then
  end

  -- Day of the Dead (Día de Muertos) – Oct 31 - Nov 2
  if (d.month == 10 and d.day == 31) or (d.month == 11 and d.day >= 1 and d.day <= 2) then
  end

  -- Guy Fawkes Night (UK)
  if (d.month == 11 and d.day == 5) then
  end

  -- Remembrance Day / Veterans Day
  if (d.month == 11 and d.day == 11) then
  end

  -- Thanksgiving (US, ~4th Thursday of November)
  if (d.month == 11 and d.day >= 22 and d.day <= 28) then
  end

  -- Winter Solstice (Yule)
  if (d.month == 12 and d.day >= 20 and d.day <= 21) then
  end

  -- New Year's Eve
  if (d.month == 12 and d.day == 31) then
  end

  -- ZODIAC SIGNS

  -- Chinese New Year (lunar calendar --�late January through mid-February)
  local chineseYearIndex = (d.year - 2020) % 12

  if chineseYearIndex == 0 then
  elseif chineseYearIndex == 1 then
  elseif chineseYearIndex == 2 then
  elseif chineseYearIndex == 3 then
  elseif chineseYearIndex == 4 then
  elseif chineseYearIndex == 5 then
  elseif chineseYearIndex == 6 then
  elseif chineseYearIndex == 7 then
  elseif chineseYearIndex == 8 then
  elseif chineseYearIndex == 9 then
  elseif chineseYearIndex == 10 then
  elseif chineseYearIndex == 11 then
  end

  if (d.month == 1 and d.day >= 21) or (d.month == 2 and d.day <= 20) then
  end

  -- Western Zodiac Signs
  -- Capricorn (Dec 22 - Jan 19)
  if (d.month == 12 and d.day >= 22) or (d.month == 1 and d.day <= 19) then
  end

  -- Aquarius (Jan 20 - Feb 18)
  if (d.month == 1 and d.day >= 20) or (d.month == 2 and d.day <= 18) then
  end

  -- Pisces (Feb 19 - Mar 20)
  if (d.month == 2 and d.day >= 19) or (d.month == 3 and d.day <= 20) then
  end

  -- Aries (Mar 21 - Apr 19)
  if (d.month == 3 and d.day >= 21) or (d.month == 4 and d.day <= 19) then
  end

  -- Taurus (Apr 20 - May 20)
  if (d.month == 4 and d.day >= 20) or (d.month == 5 and d.day <= 20) then
  end

  -- Gemini (May 21 - Jun 20)
  if (d.month == 5 and d.day >= 21) or (d.month == 6 and d.day <= 20) then
  end

  -- Cancer (Jun 21 - Jul 22)
  if (d.month == 6 and d.day >= 21) or (d.month == 7 and d.day <= 22) then
  end

  -- Leo (Jul 23 - Aug 22)
  if (d.month == 7 and d.day >= 23) or (d.month == 8 and d.day <= 22) then
  end

  -- Virgo (Aug 23 - Sep 22)
  if (d.month == 8 and d.day >= 23) or (d.month == 9 and d.day <= 22) then
  end

  -- Libra (Sep 23 - Oct 22)
  if (d.month == 9 and d.day >= 23) or (d.month == 10 and d.day <= 22) then
  end

  -- Scorpio (Oct 23 - Nov 21)
  if (d.month == 10 and d.day >= 23) or (d.month == 11 and d.day <= 21) then
  end

  -- Sagittarius (Nov 22 - Dec 21)
  if (d.month == 11 and d.day >= 22) or (d.month == 12 and d.day <= 21) then
  end

  pickedLine = consumableSpellLines[fastrandom(1, #consumableSpellLines)]

  return TheWishingTable.Helpers.parseText(prefix .. pickedLine, {
    playerName = playerName,
    playerGender = playerGender,
    playerClass = playerClass,
    playerRace = playerRace,
    playerLevel = playerLevel,
    playerManWoman = playerManWoman,
    playerGuyGirl = playerGuyGirl,
    oppositeSex = oppositeSex,
    zoneName = zoneName,
  })
end

local function str_to_bool(str)
  if str == nil then
    return false
  end
  return string.lower(str) == "true"
end

local function canBroadcastParty(value)
  if (value == 1 or value == 3) then
    return true
  end

  return false
end

local function canBroadcastRaid(value)
  if (value == 2 or value == 3) then
    return true
  end

  return false
end

-- Test mode wrappers for group detection (allows testing without real groups)
local function isInTestGroup()
  return TheWishingTableVars and TheWishingTableVars.testGroupMode and true or false
end

local function testIsInGroup(category)
  if isInTestGroup() then
    local mode = TheWishingTableVars.testGroupMode
    if mode == "party" or mode == "raid" then
      return true
    end
    return false
  end
  return IsInGroup(category)
end

local function testIsInRaid(category)
  if isInTestGroup() then
    local mode = TheWishingTableVars.testGroupMode
    if mode == "raid" then
      return true
    end
    return false
  end
  return IsInRaid(category)
end

local function getBroadcastChannel(broadCastChannels, canBroadcastToInstance)
  local canBroadcastToParty = canBroadcastParty(broadCastChannels)
  local canBroadcastToRaid = canBroadcastRaid(broadCastChannels)

  -- LFD/LFR/battleground groups talk through instance chat.
  if testIsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
    if not (canBroadcastToInstance == true) then
      return nil
    end

    if testIsInRaid(LE_PARTY_CATEGORY_INSTANCE) then
      return canBroadcastToRaid and "INSTANCE_CHAT" or nil
    end

    return canBroadcastToParty and "INSTANCE_CHAT" or nil
  end

  if testIsInRaid() then
    return canBroadcastToRaid and "RAID" or nil
  end

  if testIsInGroup() then
    return canBroadcastToParty and "PARTY" or nil
  end

  return nil
end

local function determineChannel()
  return getBroadcastChannel(
    TheWishingTableVars.consumableSpell_channel,
    TheWishingTableVars.consumableSpell_instance
  )
end

function TheWishingTable.TheWishingAdditions.Run()
  local frame = CreateFrame("Frame")
  TheWishingTable.TheWishingAdditions.Frame = frame

  -- Midnight (12.0): the player's own spellcasts are explicitly non-secret, even in combat,
  -- so we can keep reacting to them. RegisterUnitEvent restricts the events to the player.
  -- UNIT_SPELLCAST_START only fires for spells with a cast time; UNIT_SPELLCAST_SUCCEEDED
  -- catches the instant ones (Raise Ally, Reincarnation, soulstone self-ress).
  -- UNIT_SPELLCAST_SENT still exists but its target parameter may be a secret value now,
  -- so it is registered defensively and only used when the name is actually readable.
  -- "pet" is included for pet-cast resurrections (hunter Stone Hound's Eternal Guardian);
  -- units controlled by the player are non-secret in Midnight too.
  pcall(frame.RegisterUnitEvent, frame, "UNIT_SPELLCAST_SENT", "player")
  frame:RegisterUnitEvent("UNIT_SPELLCAST_START", "player", "pet")
  frame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player", "pet")

  local lastAnnouncedKey, lastAnnouncedTime = nil, 0

  local function announceConsumablesPutDown(castGUID, spellID)
    local isDebugMode = TheWishingTableVars and TheWishingTableVars.debugMode == true
    local isKnownSpell = TheWishingTable.SpellIds.isConsumableSpellCasting(spellID)

    -- In debug mode, allow any spell through
    if not isKnownSpell and not isDebugMode then return end

    -- Only handle the categories this file has lines for; other categories
    -- are handled in TheWishingTable.lua.
    local spellCategory = TheWishingTable.SpellIds.getSpellCategory(spellID)
    if not HANDLED_CATEGORIES[spellCategory] and not (isDebugMode and not isKnownSpell) then return end

    -- A spell with a cast time fires START and then SUCCEEDED for the same cast;
    -- announce it only once.
    local dedupeKey = castGUID or ("spell:" .. tostring(spellID))
    if (dedupeKey == lastAnnouncedKey and (GetTime() - lastAnnouncedTime) < 10) then return end

    local channel = determineChannel()
    if not channel then
      TheWishingTable.debugPrint(
        feature,
        "No broadcast channel (not in a group, or channel disabled in /twt)."
      )
      return
    end

    -- pcall keeps Midnight's secret-value restrictions from throwing Lua errors mid-fight;
    -- worst case the announcement is skipped.
    local ok, line = pcall(function()
      return TheWishingTable.TheWishingAdditions.speakconsumableSpell(spellID)
    end)

    if (not ok or type(line) ~= "string") then
      TheWishingTable.debugPrint(feature, "Could not build a line for spell " .. tostring(spellID))
      return
    end

    lastAnnouncedKey = dedupeKey
    lastAnnouncedTime = GetTime()

    -- Midnight blocks addon chat during boss encounters, keystone runs and PvP matches.
    if (C_ChatInfo and C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown()) then
      TheWishingTable.debugPrint(feature, "Chat messaging lockdown active; skipped: " .. line)
      return
    end

    local sent = pcall(SendChatMessage, line, channel)
    TheWishingTable.debugPrint(
      feature,
      "[" .. channel .. "] " .. line .. (sent and "" or " (send failed)")
    )
  end

  frame:SetScript("OnEvent", function(self, event, ...)
    if not TheWishingTableVars then return end

    if (not (TheWishingTableVars.TheWishingTableIsOn == true) and not (TheWishingTableVars.debugMode == true)) then return end

    if (event == "UNIT_SPELLCAST_SENT") then
      local unitTarget, arg2, arg3 = ...
      lastSentTargetName, lastSentCastGUID = nil, nil

      -- The SENT payload changed in Midnight: the target name parameter may be gone or
      -- secret. Only keep it when it is a readable name (cast GUIDs start with "Cast-").
      pcall(function()
        if (type(arg2) == "string" and arg2 ~= "" and not arg2:find("^Cast%-")) then
          lastSentTargetName = arg2
          lastSentCastGUID = arg3
        else
          lastSentCastGUID = arg2
        end
      end)
      return
    end

    if (event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_SUCCEEDED") then
      local unitTarget, castGUID, spellID = ...

      if not spellID then return end

      announceConsumablesPutDown(castGUID, spellID)
    end
  end)
end

TheWishingTable.TheWishingAdditions.Run()
