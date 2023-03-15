-- Credit to dtlnor: https://www.nexusmods.com/monsterhunterrise/mods/265

local version = "1.2.1"
local name = "ForceForlornArena v" .. version

-- Target Maps
local INFERNAL_MAP_NO = 9
local ARENA_MAP_NO = 10
local FORLORN_MAP_NO = 14
local TAGET_MAPS = {
    INFERNAL_MAP_NO,
    ARENA_MAP_NO,
    FORLORN_MAP_NO
}

-- Ignore Maps
local PALACE_MAP_NO = 11
local ABYSS_MAP_NO = 15

-- Quest Types
local HUNT_QUEST_TYPE = 1
local KILL_QUEST_TYPE = 2
local CAPTURE_QUEST_TYPE = 4

-- Related to enemy init sets
local ENEMY_COUNT = 116
local IGNORE_ENEMIES = {
    [35] = true,  -- Wind Serpent Ibushi
    [38] = true,  -- Thunder Serpent Narwa
    [39] = true,  -- Narwa the Allmother
    [46] = true,  -- Giant Mechanized Toa
    [96] = true   -- Gaismagorm
}

-- Load Data Dumps
local questDump = json.load_file("ForceForlornArena/QuestDataDump.json")
if not questDump then questDump = {} end
local investigationDump = json.load_file("ForceForlornArena/InvestigationDataDump.json") 
if not investigationDump then investigationDump = {} end

-- Normal Quests
local function getNormalQuestDataList(questman, fieldname)
    local normalQuestData = questman:get_field(fieldname)
    if normalQuestData == nil then return end
    local normalQuestData_array = normalQuestData._Param
    if normalQuestData_array == nil then return end
    normalQuestData_array = normalQuestData_array:get_elements()
    return normalQuestData_array
end

local function getNormalQuestDataForEnemyList(questman, fieldname)
    local normalQuestDataForEnemy = questman:get_field(fieldname)
    if normalQuestDataForEnemy == nil then return end
    local normalQuestDataForEnemy_array = normalQuestDataForEnemy._Param
    if normalQuestDataForEnemy_array == nil then return end
    normalQuestDataForEnemy_array = normalQuestDataForEnemy_array:get_elements()
    return normalQuestDataForEnemy_array
end

local function dump_quest_data(normalQuestData_array, normalQuestDataForEnemy_array)
    if normalQuestData_array == nil then return end
    if normalQuestDataForEnemy_array == nil then return end
    for i, quest in ipairs(normalQuestDataForEnemy_array) do
        local QuestNo = quest._QuestNo
        if QuestNo == nil then return
        else
            questDump[tostring(QuestNo)] = {}

            local value = quest._EmsSetNo
            questDump[tostring(QuestNo)].EmsSetNo = value
            --log.debug("lua:log:"..tostring(value))

            local RouteNo = quest._RouteNo
            local value = RouteNo[0].mValue
            questDump[tostring(QuestNo)].RouteNo_0 = value
            --log.debug("lua:log:"..tostring(value))

            local InitSetName = quest._InitSetName
            local value = InitSetName[0]
            value = value:call("Substring(System.Int32)", 0)
            questDump[tostring(QuestNo)].InitSetName_0 = value
        end
    end

    for i, quest in ipairs(normalQuestData_array) do
        local QuestNo = quest._QuestNo
        if QuestNo == nil then return
        else
            local value = quest._MapNo
            questDump[tostring(QuestNo)].MapNo = value
            --log.debug("lua:log:"..tostring(value))

            local value = quest._InitExtraEmNum
            questDump[tostring(QuestNo)].InitExtraEmNum = value
            --log.debug("lua:log:"..tostring(value))

            local BossEmType = quest._BossEmType
            BossEmType = BossEmType:get_elements()
            questDump[tostring(QuestNo)].BossEmType = {}
            for i, value in ipairs(BossEmType) do
                questDump[tostring(QuestNo)].BossEmType[tostring(i)] = value.value__
                --log.debug("lua:log:"..tostring(value.value__))
            end

            local SwapEmRate = quest._SwapEmRate
            questDump[tostring(QuestNo)].SwapEmRate = {}
            SwapEmRate = SwapEmRate:get_elements()
            for i, value in ipairs(SwapEmRate) do
                questDump[tostring(QuestNo)].SwapEmRate[tostring(i)] = value.mValue
                --log.debug("lua:log:"..tostring(value.mValue))
            end

            local BossSetCondition = quest._BossSetCondition
            questDump[tostring(QuestNo)].BossSetCondition = {}
            BossSetCondition = BossSetCondition:get_elements()
            for i, value in ipairs(BossSetCondition) do
                questDump[tostring(QuestNo)].BossSetCondition[tostring(i)] = value.value__
                --log.debug("lua:log:"..tostring(value.value__))
            end

            local SwapSetCondition = quest._SwapSetCondition
            questDump[tostring(QuestNo)].SwapSetCondition = {}
            SwapSetCondition = SwapSetCondition:get_elements()
            for i, value in ipairs(SwapSetCondition) do
                questDump[tostring(QuestNo)].SwapSetCondition[tostring(i)] = value.value__
                --log.debug("lua:log:"..tostring(value.value__))
            end

            local SwapSetParam = quest._SwapSetParam
            questDump[tostring(QuestNo)].SwapSetParam = {}
            SwapSetParam = SwapSetParam:get_elements()
            for i, value in ipairs(SwapSetParam) do
                questDump[tostring(QuestNo)].SwapSetParam[tostring(i)] = value.mValue
                --log.debug("lua:log:"..tostring(value.mValue))
            end

            local SwapExitTime = quest._SwapExitTime
            questDump[tostring(QuestNo)].SwapExitTime = {}
            SwapExitTime = SwapExitTime:get_elements()
            for i, value in ipairs(SwapExitTime) do
                questDump[tostring(QuestNo)].SwapExitTime[tostring(i)] = value.mValue
                --log.debug("lua:log:"..tostring(value.mValue))
            end
        end
    end
end

local function dump_quest()
    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

    dump_quest_data(getNormalQuestDataList(questman, "_normalQuestData"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemy"))
    dump_quest_data(getNormalQuestDataList(questman, "_DlQuestData"), getNormalQuestDataForEnemyList(questman, "_DlQuestDataForEnemy"))
    dump_quest_data(getNormalQuestDataList(questman, "_nomalQuestDataKohaku"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemyKohaku"))

    json.dump_file("ForceForlornArena/QuestDataDump.json", questDump)
end

local function checkQuest(quest)
    -- map cannot be Coral Palace or Yawning Abyss
    local mapNo = quest._MapNo
    if mapNo == PALACE_MAP_NO or mapNo == ABYSS_MAP_NO then
        return false
    end 

    -- quest type needs to be hunt, kill or capture
    local questType = quest._QuestType
    if questType ~= HUNT_QUEST_TYPE and questType ~= KILL_QUEST_TYPE and questType ~= CAPTURE_QUEST_TYPE then
        return false
    end

    -- target number is only one
    local tgtNum = quest._TgtNum
    local tgtNum0 = tgtNum[0].mValue
    local tgtNum1 = tgtNum[1].mValue
    return tgtNum0 == 1 and tgtNum1 == 0
end

local function set_quest_data(mapNo, normalQuestData_array, normalQuestDataForEnemy_array)
    if normalQuestData_array == nil then return end
    if normalQuestDataForEnemy_array == nil then return end
    for i, quest in ipairs(normalQuestDataForEnemy_array) do
        local QuestNo = quest._QuestNo
        if QuestNo == nil then return
        else
            if checkQuest(quest) then
                quest._EmsSetNo = 0

                local RouteNo = quest._RouteNo
                local value = sdk.create_instance("System.Byte")
                value.mValue = 10
                RouteNo[0] = value

                local InitSetName = quest._InitSetName
                local initSet = "メイン"
                if mapNo == ARENA_NO then initSet = "A" end
                InitSetName[0] = initSet
                quest._InitSetName = InitSetName
            end
        end
    end

    for i, quest in ipairs(normalQuestData_array) do
        local QuestNo = quest._QuestNo
        if QuestNo == nil then return
        else
            if checkQuest(quest) then
                quest._MapNo = mapNo
                quest._InitExtraEmNum = 0

                local BossEmType = quest._BossEmType
                local value = sdk.create_instance("snow.enemy.EnemyDef.EmTypes")
                value.value__ = 0
                for j=1,6 do
                    BossEmType[j] = value
                end

                local SwapEmRate = quest._SwapEmRate
                local value = sdk.create_instance("System.Byte")
                value.mValue = 0
                for j=0,1 do
                    SwapEmRate[j] = value
                end

                local BossSetCondition = quest._BossSetCondition
                local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
                value.value__ = 1
                BossSetCondition[0] = value

                local SwapSetCondition = quest._SwapSetCondition
                value = sdk.create_instance("snow.QuestManager.SwapSetCondition")
                value.value__ = 0
                for j=0,1 do
                    SwapSetCondition[j] = value
                end

                local SwapSetParam = quest._SwapSetParam
                local value = sdk.create_instance("System.Byte")
                value.mValue = 0
                for j=0,1 do
                    SwapSetParam[j] = value
                end

                local SwapExitTime = quest._SwapExitTime
                local value = sdk.create_instance("System.Byte")
                value.mValue = 0
                for j=0,1 do
                    SwapExitTime[j] = value
                end
            end
        end
    end
end

local function set_quest(mapNo)
    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

    set_quest_data(mapNo, getNormalQuestDataList(questman, "_normalQuestData"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemy"))
    set_quest_data(mapNo, getNormalQuestDataList(questman, "_DlQuestData"), getNormalQuestDataForEnemyList(questman, "_DlQuestDataForEnemy"))
    set_quest_data(mapNo, getNormalQuestDataList(questman, "_nomalQuestDataKohaku"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemyKohaku"))
end

local function load_quest_data(normalQuestData_array, normalQuestDataForEnemy_array)
    if normalQuestData_array == nil then return end
    if normalQuestDataForEnemy_array == nil then return end
    for i, quest in ipairs(normalQuestDataForEnemy_array) do
        local QuestNo = quest._QuestNo
        if QuestNo == nil then return
        else
            if QuestNo ~= 0 and questDump[tostring(QuestNo)] ~= nil then
                quest._EmsSetNo = questDump[tostring(QuestNo)].EmsSetNo

                local RouteNo = quest._RouteNo
                local value = sdk.create_instance("System.Byte")
                value.mValue = questDump[tostring(QuestNo)].RouteNo_0
                RouteNo[0] = value

                local InitSetName = quest._InitSetName
                local value = sdk.create_managed_string(questDump[tostring(QuestNo)].InitSetName_0)
                InitSetName[0] = value
                quest._InitSetName = InitSetName
            end
        end
    end

    for i, quest in ipairs(normalQuestData_array) do
        local QuestNo = quest._QuestNo
        if QuestNo == nil then return
        else
            if not (QuestNo == 0) then
                local Map = questDump[tostring(QuestNo)].MapNo
                quest._MapNo = Map
                quest._InitExtraEmNum = questDump[tostring(QuestNo)].InitExtraEmNum

                local BossEmType = quest._BossEmType
                local value = sdk.create_instance("snow.enemy.EnemyDef.EmTypes")
                for j=1,6 do
                    value.value__ = questDump[tostring(QuestNo)].BossEmType[tostring(j + 1)]
                    BossEmType[j] = value
                end

                local SwapEmRate = quest._SwapEmRate
                local value = sdk.create_instance("System.Byte")
                for j=0,1 do
                    value.mValue = questDump[tostring(QuestNo)].SwapEmRate[tostring(j + 1)]
                    SwapEmRate[j] = value
                end

                local BossSetCondition = quest._BossSetCondition
                local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
                value.value__ = questDump[tostring(QuestNo)].BossSetCondition["1"]
                BossSetCondition[0] = value

                local SwapSetCondition = quest._SwapSetCondition
                value = sdk.create_instance("snow.QuestManager.SwapSetCondition")
                for j=0,1 do
                    value.value__ = questDump[tostring(QuestNo)].SwapSetCondition[tostring(j + 1)]
                    SwapSetCondition[j] = value
                end

                local SwapSetParam = quest._SwapSetParam
                local value = sdk.create_instance("System.Byte")
                for j=0,1 do
                    value.mValue = questDump[tostring(QuestNo)].SwapSetParam[tostring(j + 1)]
                    SwapSetParam[j] = value
                end

                local SwapExitTime = quest._SwapExitTime
                local value = sdk.create_instance("System.Byte")
                for j=0,1 do
                    value.mValue = questDump[tostring(QuestNo)].SwapExitTime[tostring(j + 1)]
                    SwapExitTime[j] = value
                end
            end
        end
    end
end

local function load_quest()
    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

    load_quest_data(getNormalQuestDataList(questman, "_normalQuestData"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemy"))
    load_quest_data(getNormalQuestDataList(questman, "_DlQuestData"), getNormalQuestDataForEnemyList(questman, "_DlQuestDataForEnemy"))
    load_quest_data(getNormalQuestDataList(questman, "_nomalQuestDataKohaku"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemyKohaku"))
end

-- Anomaly Investigations
local function set_investigations(mapNo)
    local questman = sdk.get_managed_singleton("snow.QuestManager")
    local questData = questman._RandomMysteryQuestData
    questData = questData:get_elements()

    for i, quest in ipairs(questData) do
        local questIdx = quest._Idx
        local huntTargetNum = quest._HuntTargetNum

        if questIdx ~= -1 and huntTargetNum == 1 then 
            quest._MapNo = mapNo

            local bossEmType = quest._BossEmType
            local value = sdk.create_instance("snow.enemy.EnemyDef.EmTypes")
            value.value__ = 0
            for j=1,6 do
                bossEmType[j] = value
            end

            local bossSetCondition = quest._BossSetCondition
            local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
            value.value__ = 1
            bossSetCondition[0] = value
            value.value__ = 0
            for j=1,6 do
                bossSetCondition[j] = value
            end

            local swapSetCondition = quest._SwapSetCondition
            value = sdk.create_instance("snow.QuestManager.SwapSetCondition")
            value.value__ = 0
            swapSetCondition[0] = value
            swapSetCondition[1] = value

            local swapSetParam = quest._SwapSetParam
            local value = sdk.create_instance("System.Byte")
            value.mValue = 0
            swapSetParam[0] = value
            swapSetParam[1] = value

            local swapExitTime = quest._SwapExitTime
            local value = sdk.create_instance("System.Byte")
            value.mValue = 0
            swapExitTime[0] = value
            swapExitTime[1] = value
        end
    end
end

local function set_investigations_lv(questLv)
    local questman = sdk.get_managed_singleton("snow.QuestManager")
    local questData = questman._RandomMysteryQuestData
    questData = questData:get_elements()

    for i, quest in ipairs(questData) do
        local questIdx = quest._Idx
        local huntTargetNum = quest._HuntTargetNum

        if questIdx ~= -1 and huntTargetNum == 1 then 
            quest._QuestLv = questLv
        end
    end
end

local function update_investigation_dump()
    local questman = sdk.get_managed_singleton("snow.QuestManager")
    local questData = questman._RandomMysteryQuestData
    questData = questData:get_elements()

    -- add new quests to data dump
    for i, quest in ipairs(questData) do
        local questNo = tostring(quest._QuestNo)
        local questIdx = quest._Idx

        if questNo ~= "-1" then
            -- only update if the questNo location is empty
            -- or a new quest (new idx) appears
            if investigationDump[questNo] == nil or investigationDump[questNo]._QuestIdx ~= questIdx then
                investigationDump[questNo] = {}
                investigationDump[questNo]._QuestIdx = questIdx
                investigationDump[questNo]._ArrIdx = string.format("0x%X", i - 1)
                investigationDump[questNo]._QuestLv = quest._QuestLv
                investigationDump[questNo]._MapNo = quest._MapNo

                for _, fieldname in ipairs({"_BossEmType", "_BossSetCondition", "_SwapSetCondition"}) do
                    investigationDump[questNo][fieldname] = {}
                    for j, value in ipairs(quest:get_field(fieldname):get_elements()) do
                        investigationDump[questNo][fieldname][j] = value.value__
                    end
                end

                for _, fieldname in ipairs({"_SwapSetParam", "_SwapExitTime"}) do
                    investigationDump[questNo][fieldname] = {}
                    for j, value in ipairs(quest:get_field(fieldname):get_elements()) do
                        investigationDump[questNo][fieldname][j] = value.mValue
                    end
                end
            end
        end
    end

    json.dump_file("ForceForlornArena/InvestigationDataDump.json", investigationDump)
end

local function load_investigations()
    local questman = sdk.get_managed_singleton("snow.QuestManager")
    local questData = questman._RandomMysteryQuestData
    questData = questData:get_elements()

    for i, quest in ipairs(questData) do
        local questNo = quest._QuestNo
        questNo = tostring(questNo)

        local questIdx = quest._Idx

        -- only load if entry exists with the same idx
        if questNo ~= "-1" and investigationDump[questNo] ~= nil and investigationDump[questNo]._QuestIdx == questIdx then
            quest._MapNo = investigationDump[questNo]._MapNo

            local bossEmType = quest._BossEmType
            local value = sdk.create_instance("snow.enemy.EnemyDef.EmTypes")
            for j, item in ipairs(investigationDump[questNo]._BossEmType) do
                value.value__ = item
                bossEmType[j - 1] = value
            end

            local bossSetCondition = quest._BossSetCondition
            local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
            for j, item in ipairs(investigationDump[questNo]._BossSetCondition) do
                value.value__ = item
                bossSetCondition[j - 1] = value
            end

            local swapSetCondition = quest._SwapSetCondition
            local value = sdk.create_instance("snow.QuestManager.SwapSetCondition")
            for j, item in ipairs(investigationDump[questNo]._SwapSetCondition) do
                value.value__ = item
                swapSetCondition[j - 1] = value
            end

            local value = sdk.create_instance("System.Byte")
            for _, fieldname in ipairs({"_SwapSetParam", "_SwapExitTime"}) do
                field = quest:get_field(fieldname)
                for j, item in ipairs(investigationDump[questNo][fieldname]) do
                    value.mValue = item
                    field[j - 1]  = value
                end
            end
        end 
    end
end

-- Fix Enemy Init Set
local function fetch_map_init_set_data(initSetData, targetMapNo)
    -- Fetch the first seen init set data for a given map
    for i=0,(ENEMY_COUNT - 1) do 
        local enemy = initSetData[i]
        if enemy ~= nil then
            local stageInfoList = enemy._StageInfoList
            for j=0, stageInfoList:call("get_Count()") - 1 do 
                local stageInfo = stageInfoList[j]
                local mapNo = stageInfo._MapType
                if mapNo == targetMapNo then
                    return stageInfo
                end
            end
        end
    end
end

local function fix_init_set_data()
    local enemyman = sdk.get_managed_singleton("snow.enemy.EnemyManager")
    local initSetData = enemyman._EnemyBossInitLotData

    for i=0,(ENEMY_COUNT - 1) do 
        local enemy = initSetData[i]
        if enemy ~= nil and IGNORE_ENEMIES[enemy._EnemyType] ~= true then
            -- fetch stageInfoList for a certain enemy
            local managedStageInfoList = enemy._StageInfoList
            local stageInfoList = {}
            for j=0, managedStageInfoList:call("get_Count()") - 1 do 
                local stageInfo = managedStageInfoList[j]
                local mapNo = stageInfo._MapType
                stageInfoList[mapNo] = stageInfo
            end

            -- check if this enemy has init data for all target maps
            for _, mapNo in ipairs(TAGET_MAPS) do
                if stageInfoList[mapNo] == nil then
                    -- log.debug("[ForceForlornArena] map = " .. tostring(mapNo))
                    stageInfo = fetch_map_init_set_data(initSetData, mapNo)
                    managedStageInfoList:call("Add(snow.enemy.EnemyBossInitSetData.StageInfo)", stageInfo)
                end
            end
        end
    end
end

-- Properties
local questStatus = "default"
local investigationStatus = "default"

local changeQuests = false
local changeInvestigations = false
local questLv = 220

local isInitSetDataFixed = false

local settings = {
    disableValidityCheck = true,
    autoChangeInvestigations = true
}

local function save_settings()
    json.dump_file("ForceForlornArena/settings.json", settings)
end

local function load_settings()
    local loadedSettings = json.load_file("ForceForlornArena/settings.json")
    if loadedSettings then
        settings = loadedSettings
    end
end

load_settings()

-- Remove validity checks for anomaly investigations
sdk.hook(
    sdk.find_type_definition('snow.quest.nRandomMysteryQuest'):get_method('checkRandomMysteryQuestOrderBan'),
    nil,
    function(retval)
        if settings.disableValidityCheck then
            return sdk.to_ptr(0)
        else
            return retval
        end
    end
)

-- Auto change investigations upon opening up the quest counter
sdk.hook(
    sdk.find_type_definition('snow.SnowSingletonBehaviorRoot`1<snow.gui.fsm.questcounter.GuiQuestCounterFsmManager>'):get_method('awake'),
    function(args)
        if settings.autoChangeInvestigations then
            if investigationStatus == "Arena" then
                -- log.debug('[ForceForlornAreana] setting to arena')
                set_investigations(ARENA_MAP_NO)
            elseif investigationStatus == "Infernal Springs" then
                -- log.debug('[ForceForlornAreana] setting to infernal')
                set_investigations(INFERNAL_MAP_NO)
            elseif investigationStatus == "Forlorn Arena" then
                -- log.debug('[ForceForlornAreana] setting to forlorn')
                set_investigations(FORLORN_MAP_NO)
            end
        end
    end
)

-- Fix init set data upon entering the village for the first time
sdk.hook(
    sdk.find_type_definition("snow.gui.GuiManager"):get_method("notifyReturnInVillage"), 
    function(args)
        if not isInitSetDataFixed then
            fix_init_set_data()
            isInitSetDataFixed = true
        end
    end
)

-- GUI
re.on_draw_ui(
    function()
        if imgui.tree_node(name) then

            if imgui.tree_node("Settings") then
                _, settings.disableValidityCheck = imgui.checkbox("Disable Validity Check", settings.disableValidityCheck)
                _, settings.autoChangeInvestigations = imgui.checkbox("Auto Change Investigations", settings.autoChangeInvestigations)
                imgui.tree_pop()
            end

            if string.len(questStatus) > 0 then
                imgui.text("Regular Quests: " .. questStatus)
            end
            imgui.same_line()
            if imgui.button("reset quests") then
                load_quest()
                questStatus = "default"
            end

            if string.len(investigationStatus) > 0 then
                imgui.text("Investigations: " .. investigationStatus)
            end
            imgui.same_line()
            if imgui.button("reset investigations") then
                load_investigations()
                investigationStatus = "default"
            end

            _, changeQuests = imgui.checkbox("Change Regular Quests", changeQuests)
            imgui.same_line()
            _, changeInvestigations = imgui.checkbox("Change Investigations", changeInvestigations)

            if imgui.button("Arena") then
                if changeQuests then
                    if questStatus == "default" then
                        dump_quest()
                    end
                    set_quest(ARENA_MAP_NO)
                    questStatus = "Arena"
                end
                if changeInvestigations then
                    update_investigation_dump()
                    set_investigations(ARENA_MAP_NO)
                    investigationStatus = "Arena"
                end
            end
            imgui.same_line()
            if imgui.button("Infernal Springs") then
                if changeQuests then
                    if questStatus == "default" then
                        dump_quest()
                    end
                    set_quest(INFERNAL_MAP_NO)
                    questStatus = "Infernal Springs"
                end
                if changeInvestigations then
                    update_investigation_dump()
                    set_investigations(INFERNAL_MAP_NO)
                    investigationStatus = "Infernal Springs"
                end
            end
            imgui.same_line()
            if imgui.button("Forlorn Arena") then
                if changeQuests then
                    if questStatus == "default" then
                        dump_quest()
                    end
                    set_quest(FORLORN_MAP_NO)
                    questStatus = "Forlorn Arena"
                end
                if changeInvestigations then
                    update_investigation_dump()
                    set_investigations(FORLORN_MAP_NO)
                    investigationStatus = "Forlorn Arena"
                end
            end

            _, questLv = imgui.drag_int('Quest Level', questLv, 1, 200)
            imgui.same_line()
            if imgui.button("Set Level") then
                set_investigations_lv(questLv)
            end
            imgui.tree_pop()
        end 
    end
)

re.on_config_save(
    function()
        save_settings()
    end
)
