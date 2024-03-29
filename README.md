# Force Forlorn Arena for Single Targe Quests

Script to change the maps of single target quests and anomaly investigations in Monster Hunte Rise to Arena / Infernal Springs / Forlorn Arena.

## Important Note

- Disclaimer: the script will be editing game files. Backup your save before using and use at your own risks;
- The game has some checks for illegal investigation quests. Changing the map will most certainly fail the check. A message "Unable to accept as quest is unauthorized" will appear and preventing you from accepting the quest. Checking the `Settings - Disable Validity Check` box will disbale the check and allow you to accept the quest;
- Usally, after you complete an investigation the game will give you a quest with the same condition but at a higher level. If you complete an investigation at one of the arenas, the new quest will also be permanently at the arena. It cannot be restored to the original map. If you remove the script or uncheck `Change Investigations`, the quest will no longer be able to be accepted;
- Use of the script in multiplayer is not encouraged. For regular quests, it's currently impossible to use this mod in multiplayer. Even if all players are using this mod and set to the same map, everyone except for the one who accept the quest will spawn in the wrong map; For investigations, if all players are using this mod and disbale the validity check then it can be played as normal from my experience. Note that participants have a chance to get a copy of the quest after completing it, and they cannot accept that new quest if they don't also have the script. Use at your own risks.

## Ackowledgement

The original script is [ForceArenaQuest](https://www.nexusmods.com/monsterhunterrise/mods/265) and the bulk of the work is done by the original author [dtlnor](https://github.com/dtlnor). I only did some minor changes and added the support for anomaly investigations.

## Install

1. Install [REFramework](https://www.nexusmods.com/monsterhunterrise/mods/26); 
2. Put the folder `reframework/` into the game's root folder (in the same director as `MonsterHunterRise.exe`).

## Usage

1. Open the REFramework window in-game (default button is `Insert`);
2. Check the type of quests you would like to change (regular quests, anomaly investigations, or both);
3. Press either of the three buttons `Arena` / `Infernal Springs` / `Forlorn Arena` to change the corresponding quests to the selected map. Only single-target, hunt, kill or capture quest that is not on a special map (Coral Palace or Yawning Abyss) will be changed;
4. To restore the original map, press `reset quests` or `reset investigations`. Note that the quests with modified map given after you complete an investigation cannot be restored;
5. To change the level of all _single target_ investigations, input a quest level between 1-200 in the bottom slider and click the `Set Level` button. Do not set to a level that is higher than your player's investigation level, or else the quests may not be able to be accepted;
6. In `Settings`, check `Disable Validity Check` to disable the validity check for anomaly investigations. See [Important Note](#important-note) for more details;
7. In `Settings`, check `Auto Change Investigations` to automatically change the map for anomaly investigations to the selected map upon opening up the quest counter.

## Known Issues

1. Sometimes small monsters will spawn in the arena for regular quests;
2. If change the map of Risen Chameleos, when the fog rises, the map will become literally pitch black. This will probably never get fixed unless the Capcom add Risen Chameleos to the arena maps.

## Update Logs

- (v1.2, 2023.02.28) Fix the problem where spawning Scorned Magnamalo in Forlorn Arena will crash the game.
- (v1.1, 2022.11.27) Add an investigation level slider and fix normal quest reset bug.

# 怪物猎人崛起 单怪任务地图修改

可以将单怪任务和怪异调查的地图修改为斗技场/狱泉乡/塔之秘境的脚本。

## 重要提示

- 免责声明：此脚本会修改游戏文件，请备份好存档再使用。如有问题请后果自负；
- 对于怪异调查，游戏会检查任务是否合法。将地图修改为斗技场类地图会被游戏视为非法任务，接任务界面会出现”此为违法篡改的任务，因而无法承接“的提示且无法承接。勾选`Settings - Disable Validity Check`将会关闭合法性检查，允许修改任务的承接；
- 一般情况下，完成一个怪异调查后游戏会返还一个同等条件但更高等级的任务。如果承接并完成了一个修改过地图的怪异调查，收到的新任务的地图会永久变成修改的地图。如果移除此脚本或取消勾选`Change Investigations`，这些任务都会因为是非法任务而无法承接；
- 不建议在多人游戏里使用此脚本。根据经验，普通任务目前是无法多人的，即使所有玩家都打了本mod并设置成了相同的地图，除了接任务的人之外的玩家都会出生在错误的地图里；对于怪异调查，只要所有玩家都打了本mod并关闭了合法性检查，应该是可以正常游玩的。注意完成后参与者有几率也收到一个修改过地图的非法任务，如果参与者没有使用脚本的话是无法承接该任务的。在多人游戏中使用请后果自负。

## 致谢

这个脚本基于 [dtlnor](https://github.com/dtlnor) 写的 [ForceArenaQuest](https://www.nexusmods.com/monsterhunterrise/mods/265). 绝大部分功能都是 dtlnor 实现的，我只加入了怪异调查的部分。

## 安装

- 安装 [REFramework](https://www.nexusmods.com/monsterhunterrise/mods/26)；
- 将 `reframework/` 这个文件夹放入游戏根目录（与 `MonsterHunterRise.exe` 同一路径下）。

## 使用

1. 在游戏中打开 REFramework 菜单（默认按键为 `insert`）；
2. 选择希望修改的任务类别（普通任务、怪异调查或所有）；
3. 按 `Arena` / `Infernal Springs` / `Forlorn Arena` 来修改至对应的地图。只会修改单怪的、不在特殊地图（龙宫古城或渊劫地狱）的狩猎/讨伐/捕获任务；
4. 按 `reset quests` 和 `reset investigations` 来还原普通任务和怪异调查的原始地图。注意无法还原在完成怪异调查后获得的新的在修改的地图上的任务；
5. 如果想修改所有 _单怪_ 调查的等级，可以在下方的滑条里输入一个1-200间的等级并按 `Set Level`. 注意不要设置超过自己怪异研究等级的任务等级，否则可能会导致任务无法承接；
6. 勾选 `Settings - Disable Validity Check` 来关闭游戏对于怪异调查合法性的检查。详细信息请参阅[重要提示](#重要提示)；
7. 勾选 `Settings - Auto Change Investigations` 后，将在打开任务柜台后将所有怪异调查自动修改为当前所设置的地图。

## 已知问题

1. 对于普通任务，有时小怪会刷在古塔/斗技场里；
2. 如果修改傀异克服霞龙的地图，在霞龙开雾之后整个地图会变成伸手不见五指的漆黑。除非卡普空更新了在这几张斗技场地图里的傀异克服霞龙任务，只靠我们应该无法修复这个问题。

## 更新日志

- (v1.2, 2023.02.28) 修复了如果将嗟怨震天怨虎龙的地图修改为塔之秘境，游戏崩溃的问题。
- (v1.1, 2022.11.27) 更新了修改全部怪异调查等级的滑条，并修复了普通任务无法还原地图的问题。
