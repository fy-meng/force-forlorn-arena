-- Credit to dtlnor: https://www.nexusmods.com/monsterhunterrise/mods/265

-- Target Maps
local INFERNAL_MAP_NO = 9
local ARENA_MAP_NO = 10
local FORLORN_MAP_NO = 14

-- Ignore Maps
local PALACE_MAP_NO = 11
local ABYSS_MAP_NO = 15

-- Quest Types
local HUNT_QUEST_TYPE = 1
local KILL_QUEST_TYPE = 2
local CAPTURE_QUEST_TYPE = 4

-- Normal Quests

local function getNormalQuestDataList(questman, fieldname)
    local normalQuestData = questman:get_field(fieldname)
    if normalQuestData == nil then return end
    local normalQuestData_array = normalQuestData:get_field("_Param")
    if normalQuestData_array == nil then return end
    normalQuestData_array = normalQuestData_array:get_elements()
    return normalQuestData_array
end

local function getNormalQuestDataForEnemyList(questman, fieldname)
    local normalQuestDataForEnemy = questman:get_field(fieldname)
    if normalQuestDataForEnemy == nil then return end
    local normalQuestDataForEnemy_array = normalQuestDataForEnemy:get_field("_Param")
    if normalQuestDataForEnemy_array == nil then return end
    normalQuestDataForEnemy_array = normalQuestDataForEnemy_array:get_elements()
    return normalQuestDataForEnemy_array
end

local function dump_quest_data(normalQuestData_array, normalQuestDataForEnemy_array)
    if normalQuestData_array == nil then return end
    if normalQuestDataForEnemy_array == nil then return end
    for i, quest in ipairs(normalQuestDataForEnemy_array) do
        local QuestNo = quest:get_field("_QuestNo")
        if QuestNo == nil then return
        else
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)] = {}

            local value = quest:get_field("_EmsSetNo")
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].EmsSetNo = value
            --log.debug("lua:log:"..tostring(value))

            local RouteNo = quest:get_field("_RouteNo")
            local value = RouteNo[0]:get_field("mValue")
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].RouteNo_0 = value
            --log.debug("lua:log:"..tostring(value))

            local InitSetName = quest:get_field("_InitSetName")
            local value = InitSetName:call("GetValue(System.Int32)", 0)
            value = value:call("Substring(System.Int32)", 0)
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].InitSetName_0 = value
        end
    end

    for i, quest in ipairs(normalQuestData_array) do
        local QuestNo = quest:get_field("_QuestNo")
        if QuestNo == nil then return
        else
            local value = quest:get_field("_MapNo")
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].MapNo = value
            --log.debug("lua:log:"..tostring(value))

            local value = quest:get_field("_InitExtraEmNum")
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].InitExtraEmNum = value
            --log.debug("lua:log:"..tostring(value))

            local BossEmType = quest:get_field("_BossEmType")
            BossEmType = BossEmType:get_elements()
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType = {}
            for i, value in ipairs(BossEmType) do
                cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType[tostring(i)] = value:get_field("value__")
                --log.debug("lua:log:"..tostring(value:get_field("value__")))
            end

            local SwapEmRate = quest:get_field("_SwapEmRate")
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapEmRate = {}
            SwapEmRate = SwapEmRate:get_elements()
            for i, value in ipairs(SwapEmRate) do
                cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapEmRate[tostring(i)] = value:get_field("mValue")
                --log.debug("lua:log:"..tostring(value:get_field("mValue")))
            end

            local BossSetCondition = quest:get_field("_BossSetCondition")
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossSetCondition = {}
            BossSetCondition = BossSetCondition:get_elements()
            for i, value in ipairs(BossSetCondition) do
                cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossSetCondition[tostring(i)] = value:get_field("value__")
                --log.debug("lua:log:"..tostring(value:get_field("value__")))
            end

            local SwapSetCondition = quest:get_field("_SwapSetCondition")
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetCondition = {}
            SwapSetCondition = SwapSetCondition:get_elements()
            for i, value in ipairs(SwapSetCondition) do
                cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetCondition[tostring(i)] = value:get_field("value__")
                --log.debug("lua:log:"..tostring(value:get_field("value__")))
            end

            local SwapSetParam = quest:get_field("_SwapSetParam")
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetParam = {}
            SwapSetParam = SwapSetParam:get_elements()
            for i, value in ipairs(SwapSetParam) do
                cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetParam[tostring(i)] = value:get_field("mValue")
                --log.debug("lua:log:"..tostring(value:get_field("mValue")))
            end

            local SwapExitTime = quest:get_field("_SwapExitTime")
            cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapExitTime = {}
            SwapExitTime = SwapExitTime:get_elements()
            for i, value in ipairs(SwapExitTime) do
                cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapExitTime[tostring(i)] = value:get_field("mValue")
                --log.debug("lua:log:"..tostring(value:get_field("mValue")))
            end
        end
    end
end

local function dump_quest()
    log.debug("lua:log: dump_quest")

    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

    dump_quest_data(getNormalQuestDataList(questman, "_normalQuestData"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemy"))
    dump_quest_data(getNormalQuestDataList(questman, "_DlQuestData"), getNormalQuestDataForEnemyList(questman, "_DlQuestDataForEnemy"))
    dump_quest_data(getNormalQuestDataList(questman, "_nomalQuestDataKohaku"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemyKohaku"))

    log.debug("lua:log: dump_quest end")
end

local function checkQuest(quest)
    -- map cannot be Coral Palace or Yawning Abyss
    local mapNo = quest:get_field("_MapNo")
    if mapNo == PALACE_MAP_NO or mapNo == ABYSS_MAP_NO then
        return false
    end 

    -- quest type needs to be hunt, kill or capture
    local questType = quest:get_field("_QuestType")
    if questType ~= HUNT_QUEST_TYPE and questType ~= KILL_QUEST_TYPE and questType ~= CAPTURE_QUEST_TYPE then
        return false
    end

    -- target number is only one
    local tgtNum = quest:get_field("_TgtNum")
    local tgtNum0 = tgtNum:call("GetValue(System.Int32)", 0):get_field("mValue")
    local tgtNum1 = tgtNum:call("GetValue(System.Int32)", 1):get_field("mValue")
    log.debug("lua:log:")
    log.debug(tostring(tgtNum0))
    log.debug(tostring(tgtNum1))
    return tgtNum0 == 1 and tgtNum1 == 0
end

local function set_quest_data(mapNo, normalQuestData_array, normalQuestDataForEnemy_array)
    if normalQuestData_array == nil then return end
    if normalQuestDataForEnemy_array == nil then return end
    for i, quest in ipairs(normalQuestDataForEnemy_array) do
        local QuestNo = quest:get_field("_QuestNo")
        if QuestNo == nil then return
        else
            if checkQuest(quest) then
                quest:set_field("_EmsSetNo", 0)

                local RouteNo = quest:get_field("_RouteNo")
                local value = sdk.create_instance("System.Byte")
                value:set_field("mValue", 10)
                RouteNo:call("SetValue(System.Object, System.Int32)", value, 0)

                local InitSetName = quest:get_field("_InitSetName")
                local initSet = "メイン"
                if mapNo == ARENA_NO then initSet = "A" end
                InitSetName:call("SetValue(System.Object, System.Int32)", initSet, 0)
                quest:set_field("_InitSetName", InitSetName)
            end
        end
    end

    for i, quest in ipairs(normalQuestData_array) do
        local QuestNo = quest:get_field("_QuestNo")
        if QuestNo == nil then return
        else
            if checkQuest(quest) then
                quest:set_field("_MapNo", mapNo)
                quest:set_field("_InitExtraEmNum", 0)

                local BossEmType = quest:get_field("_BossEmType")
                local value = sdk.create_instance("snow.enemy.EnemyDef.EmTypes")
                value:set_field("value__", 0)
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 1)
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 2)
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 3)
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 4)
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 5)
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 6)

                local SwapEmRate = quest:get_field("_SwapEmRate")
                local value = sdk.create_instance("System.Byte")
                value:set_field("mValue", 0)
                SwapEmRate:call("SetValue(System.Object, System.Int32)", value, 0)
                SwapEmRate:call("SetValue(System.Object, System.Int32)", value, 1)

                local BossSetCondition = quest:get_field("_BossSetCondition")
                local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
                value:set_field("value__", 1)
                BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)

                local SwapSetCondition = quest:get_field("_SwapSetCondition")
                value = sdk.create_instance("snow.QuestManager.SwapSetCondition")
                value:set_field("value__", 0)
                SwapSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)
                SwapSetCondition:call("SetValue(System.Object, System.Int32)", value, 1)

                local SwapSetParam = quest:get_field("_SwapSetParam")
                local value = sdk.create_instance("System.Byte")
                value:set_field("mValue", 0)
                SwapSetParam:call("SetValue(System.Byte, System.Int32)", value, 0)
                SwapSetParam:call("SetValue(System.Byte, System.Int32)", value, 1)

                local SwapExitTime = quest:get_field("_SwapExitTime")
                local value = sdk.create_instance("System.Byte")
                value:set_field("mValue", 0)
                SwapExitTime:call("SetValue(System.Byte, System.Int32)", value, 0)
                SwapExitTime:call("SetValue(System.Byte, System.Int32)", value, 1)
            end
        end
    end
end

local function set_quest(mapNo)
    log.debug("lua:log: set_localQuestData")

    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

    set_quest_data(mapNo, getNormalQuestDataList(questman, "_normalQuestData"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemy"))
    set_quest_data(mapNo, getNormalQuestDataList(questman, "_DlQuestData"), getNormalQuestDataForEnemyList(questman, "_DlQuestDataForEnemy"))
    set_quest_data(mapNo, getNormalQuestDataList(questman, "_nomalQuestDataKohaku"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemyKohaku"))

    log.debug("lua:log: set_localQuestData end")
end

local function load_quest_data(normalQuestData_array, normalQuestDataForEnemy_array)
    if normalQuestData_array == nil then return end
    if normalQuestDataForEnemy_array == nil then return end
    for i, quest in ipairs(normalQuestDataForEnemy_array) do
        local QuestNo = quest:get_field("_QuestNo")
        if QuestNo == nil then return
        else
            if not (QuestNo == 0) then
                quest:set_field("_EmsSetNo", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].EmsSetNo)

                local RouteNo = quest:get_field("_RouteNo")
                local value = sdk.create_instance("System.Byte")
                value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].RouteNo_0)
                RouteNo:call("SetValue(System.Object, System.Int32)", value, 0)

                local InitSetName = quest:get_field("_InitSetName")
                local value = sdk.create_managed_string(cfg_QuestData.read_only_quest_data[tostring(QuestNo)].InitSetName_0)
                InitSetName:call("SetValue(System.Object, System.Int32)", value, 0)
                quest:set_field("_InitSetName", InitSetName)
            end
        end
    end

    for i, quest in ipairs(normalQuestData_array) do
        local QuestNo = quest:get_field("_QuestNo")
        if QuestNo == nil then return
        else
            if not (QuestNo == 0) then
                local Map = cfg_QuestData.read_only_quest_data[tostring(QuestNo)].MapNo
                quest:set_field("_MapNo", Map)
                quest:set_field("_InitExtraEmNum", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].InitExtraEmNum)

                local BossEmType = quest:get_field("_BossEmType")
                local value = sdk.create_instance("snow.enemy.EnemyDef.EmTypes")
                value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["2"])
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 1)
                value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["3"])
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 2)
                value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["4"])
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 3)
                value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["5"])
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 4)
                value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["6"])
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 5)
                value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossEmType["7"])
                BossEmType:call("SetValue(System.Object, System.Int32)", value, 6)

                local SwapEmRate = quest:get_field("_SwapEmRate")
                local value = sdk.create_instance("System.Byte")
                value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapEmRate["1"])
                SwapEmRate:call("SetValue(System.Object, System.Int32)", value, 0)
                value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapEmRate["2"])
                SwapEmRate:call("SetValue(System.Object, System.Int32)", value, 1)

                local BossSetCondition = quest:get_field("_BossSetCondition")
                local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
                value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].BossSetCondition["1"])
                BossSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)

                local SwapSetCondition = quest:get_field("_SwapSetCondition")
                value = sdk.create_instance("snow.QuestManager.SwapSetCondition")
                value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetCondition["1"])
                SwapSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)
                value:set_field("value__", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetCondition["2"])
                SwapSetCondition:call("SetValue(System.Object, System.Int32)", value, 1)

                local SwapSetParam = quest:get_field("_SwapSetParam")
                local value = sdk.create_instance("System.Byte")
                value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetParam["1"])
                SwapSetParam:call("SetValue(System.Byte, System.Int32)", value, 0)
                value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapSetParam["2"])
                SwapSetParam:call("SetValue(System.Byte, System.Int32)", value, 1)

                local SwapExitTime = quest:get_field("_SwapExitTime")
                local value = sdk.create_instance("System.Byte")
                value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapExitTime["1"])
                SwapExitTime:call("SetValue(System.Byte, System.Int32)", value, 0)
                value:set_field("mValue", cfg_QuestData.read_only_quest_data[tostring(QuestNo)].SwapExitTime["2"])
                SwapExitTime:call("SetValue(System.Byte, System.Int32)", value, 1)
            end
        end
    end
end

local function load_quest()
    log.debug("lua:log: load_quest")

    local questman = sdk.get_managed_singleton("snow.QuestManager")
    if not questman then return end

    load_quest_data(getNormalQuestDataList(questman, "_normalQuestData"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemy"))
    load_quest_data(getNormalQuestDataList(questman, "_DlQuestData"), getNormalQuestDataForEnemyList(questman, "_DlQuestDataForEnemy"))
    load_quest_data(getNormalQuestDataList(questman, "_nomalQuestDataKohaku"), getNormalQuestDataForEnemyList(questman, "_normalQuestDataForEnemyKohaku"))

    log.debug("lua:log: load_quest end")
end

-- Anomaly Investigations

local function set_investigations(mapNo)
    local questman = sdk.get_managed_singleton("snow.QuestManager")
    local questData = questman:get_field("_RandomMysteryQuestData")
    questData = questData:get_elements()

    for i, quest in ipairs(questData) do
        local questIdx = quest:get_field("_Idx")
        local huntTargetNum = quest:get_field("_HuntTargetNum")

        if questIdx ~= -1 and huntTargetNum == 1 then 
            quest:set_field("_MapNo", mapNo)

            local bossEmType = quest:get_field("_BossEmType")
            local value = sdk.create_instance("snow.enemy.EnemyDef.EmTypes")
            value:set_field("value__", 0)
            for j = 1, 6 do
                bossEmType:call("SetValue(System.Object, System.Int32)", value, j)
            end

            local bossSetCondition = quest:get_field("_BossSetCondition")
            local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
            value:set_field("value__", 1)
            bossSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)

            local swapSetCondition = quest:get_field("_SwapSetCondition")
            value = sdk.create_instance("snow.QuestManager.SwapSetCondition")
            value:set_field("value__", 0)
            swapSetCondition:call("SetValue(System.Object, System.Int32)", value, 0)
            swapSetCondition:call("SetValue(System.Object, System.Int32)", value, 1)

            local swapSetParam = quest:get_field("_SwapSetParam")
            local value = sdk.create_instance("System.Byte")
            value:set_field("mValue", 0)
            swapSetParam:call("SetValue(System.Byte, System.Int32)", value, 0)
            swapSetParam:call("SetValue(System.Byte, System.Int32)", value, 1)

            local swapExitTime = quest:get_field("_SwapExitTime")
            local value = sdk.create_instance("System.Byte")
            value:set_field("mValue", 0)
            swapExitTime:call("SetValue(System.Byte, System.Int32)", value, 0)
            swapExitTime:call("SetValue(System.Byte, System.Int32)", value, 1)
        end
    end
end

local function update_investigation_dump()
    local data = json.load_file("InvestigationDataDump.json")
    if not data then data = {} end

    local questman = sdk.get_managed_singleton("snow.QuestManager")
    local questData = questman:get_field("_RandomMysteryQuestData")
    questData = questData:get_elements()

    -- add new quests to data dump
    for i, quest in ipairs(questData) do
        local questNo = quest:get_field("_QuestNo") 
        questNo = tostring(questNo)

        local questIdx = quest:get_field("_Idx")

        if questNo ~= "-1" then
            -- only update if the questNo location is empty
            -- or a new quest (new idx) appears
            if data[questNo] == nil or data[questNo].questIdx ~= questIdx then
                data[questNo] = {}
                data[questNo].questIdx = questIdx
                data[questNo].mapNo = quest:get_field("_MapNo")
                data[questNo].bossEmType = {}
                for j, em_type in ipairs(quest:get_field("_BossEmType"):get_elements()) do
                    data[questNo].bossEmType[j] = em_type:get_field("value__")
                end
                data[questNo].bossSetCondition = {}
                for j, em_type in ipairs(quest:get_field("_BossSetCondition"):get_elements()) do
                    data[questNo].bossSetCondition[j] = em_type:get_field("value__")
                end
                data[questNo].swapSetCondition = {}
                for j, em_type in ipairs(quest:get_field("_SwapSetCondition"):get_elements()) do
                    data[questNo].swapSetCondition[j] = em_type:get_field("value__")
                end
                data[questNo].swapSetParam = {}
                for j, em_type in ipairs(quest:get_field("_SwapSetParam"):get_elements()) do
                    data[questNo].swapSetParam[j] = em_type:get_field("mValue")
                end
                data[questNo].swapExitTime = {}
                for j, em_type in ipairs(quest:get_field("_SwapExitTime"):get_elements()) do
                    data[questNo].swapExitTime[j] = em_type:get_field("mValue")
                end
            end
        end
    end

    json.dump_file("InvestigationDataDump.json", data)
end

local function load_investigations()
    local questman = sdk.get_managed_singleton("snow.QuestManager")
    local questData = questman:get_field("_RandomMysteryQuestData")
    questData = questData:get_elements()

    local data = json.load_file("InvestigationDataDump.json")
    if not data then return end

    for i, quest in ipairs(questData) do
        local questNo = quest:get_field("_QuestNo")
        questNo = tostring(questNo)

        local questIdx = quest:get_field("_Idx")

        -- only load if entry exists with the same idx
        if questNo ~= "-1" and data[questNo] ~= nil and data[questNo].questIdx == questIdx then
            quest:set_field("_MapNo", data[questNo].mapNo)

            local bossEmType = quest:get_field("_BossEmType")
            local value = sdk.create_instance("snow.enemy.EnemyDef.EmTypes")
            for j, item in ipairs(data[questNo].bossEmType) do
                value:set_field("value__", item)
                bossEmType:call("SetValue(System.Object, System.Int32)", value, j - 1)
            end

            local bossSetCondition = quest:get_field("_BossSetCondition")
            local value = sdk.create_instance("snow.QuestManager.BossSetCondition")
            for j, item in ipairs(data[questNo].bossSetCondition) do
                value:set_field("value__", item)
                bossSetCondition:call("SetValue(System.Object, System.Int32)", value, j - 1)
            end

            local swapSetCondition = quest:get_field("_SwapSetCondition")
            value = sdk.create_instance("snow.QuestManager.SwapSetCondition")
            for j, item in ipairs(data[questNo].swapSetCondition) do
                value:set_field("value__", item)
                swapSetCondition:call("SetValue(System.Object, System.Int32)", value, j - 1)
            end

            local swapSetParam = quest:get_field("_SwapSetParam")
            local value = sdk.create_instance("System.Byte")
            for j, item in ipairs(data[questNo].swapSetParam) do
                value:set_field("mValue", item)
                swapSetParam:call("SetValue(System.Object, System.Int32)", value, j - 1)
            end

            local swapExitTime = quest:get_field("_SwapExitTime")
            local value = sdk.create_instance("System.Byte")
            for j, item in ipairs(data[questNo].swapExitTime) do
                value:set_field("mValue", item)
                swapExitTime:call("SetValue(System.Object, System.Int32)", value, j - 1)
            end
        end 
    end
end

-- Properties

local name = "ForceForlornArena v3.0"

local questStatus = "default"
local investigationStatus = "default"

local changeQuests = false
local changeInvestigations = true

-- Remove validity checks for anomaly investigations
sdk.hook(sdk.find_type_definition('snow.quest.nRandomMysteryQuest'):get_method('checkRandomMysteryQuestOrderBan'),
    function(args)
    end,
    function(retval)
        if changeInvestigations then
            return sdk.to_ptr(0)
        else
            return retval
        end
    end
)

-- GUI

re.on_draw_ui(
    function()
        if imgui.tree_node(name) then
            if string.len(questStatus) > 0 then
                imgui.text("Regular Quests: " .. questStatus)
            end
            imgui.same_line()
            if imgui.button("reset quests") then
                cfg_QuestData = json.load_file("QuestDataDump.json")
                if not cfg_QuestData then
                    cfg_QuestData = {}
                    cfg_QuestData.read_only_quest_data = {}
                    dump_quest()
                    json.dump_file("QuestDataDump.json", cfg_QuestData)
                end
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
                    set_quest(FORLORN_MAP_NO)
                    questStatus = "Forlorn Arena"
                end
                if changeInvestigations then
                    update_investigation_dump()
                    set_investigations(FORLORN_MAP_NO)
                    investigationStatus = "Forlorn Arena"
                end
            end
            imgui.tree_pop()
        end 
    end
)
