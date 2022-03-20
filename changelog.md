# Changelog

## Todo

- genetic thing or class thing

## 2.3.0 ( Hotfix 29/06 )

### Changed

- [Plant] Implemented model and

### Fixed

- [Plant]

## 2.2.1 ( Hotfix 29/06 )

### Fixed

- Fixing a bug with rc_printevents, and message displaying
Thanks to "Combine DvL ID:3"

## 2.2 ( Workshop upload 23/06/16 ) : Pushing the Revs update on the workshop

## 2.1 rev C ( 06/06/16 ) : The plant update

### Changed

- Small plants now grow ( and spawn melon relativly to their size )
- Plants spawn melon more often,
- Small plants and melons should grow quite more often.
- Plants now have a random +- 10% melon spawning rate
- Plants should spawn melon a bit faster on increased rc_speed
- Watermelon decay way faster ( so that there can't be an area with tons of melon )

### Fixed

- Plant should now properly react to rc_speed changes.
- Melon should now properly spawn plants on the ground.
- Small and Medium plant now have a correct growing timer
- Headcrab and Zombies behavior were incorrect when to hungry (not targeting some type of headcrab/zombie)

## 2.1 rev B (30/05/2016)

### Changed

- Npcs won't be able to lay egg as long as they are > 1/2 max hunger.
- Npcs will now start searching for food when they are a bit more hungry ( from 35% to 40% maxhunger )

### Balancing

- eggs restore more hunger
- meat restore more hunger
- minors melon hunger buffs

- Antlion lay less eggs ( in average )
- Headcrab are much less likely to be black headcrabs ( they can't kill their target )
- Headcrab are now a little bit likely to be fast headcrabs

- Plants Grow / die quite faster
- Smaller size plant are buffed ( spawn melon a bit more often and a little bit bigger )

- Baby now start with half of their max hitpoint
- Baby now start with 25% their hunger.

### Fixed

- Headcrab will now attack zombie when to hungry

### Known bug

- Human are not fighting back against headcrabs and zombies.

## 2.1 rev A (29/05/2016)

### Changed

- NPCs wont all target the same 'food', which improve the global efficiency of the colonies ( and as well using less time the costy searching for food function )

### Internal

- New function to init food items : rc_api.setFood ( ent , foodType[type : string] )
- New function to properly remove NPCs : rc_api.removeNPC ( ent )

## 2.1

### Changed

- Name in spawn tab changed
- Gamemode removed

### Fixed

- Npcs are not laying eggs when they are to hungry ( this really allowed colony to survive without having to eat )
- Fixed some mistakes in convar uses related to eggs
- Fixed some terrible mistakes in counting colonies member ( human was sometimes counting headcrab one instead ... )

## 2.0

- SPAWN ICONS ... yeah finally ... ( it took me a long time to make them =( )
Note : not all of them are included nor really good, but that's better than nothing

Plants :

- Changed some convar related things.
- Small plants spawn small melons, Big plants spawn big melon.
- Melon are spawn at higher places to prevent them geting stuck in the map ( you should not let tree grows in corner, they need a lot of space ! )

NPCS :

- Changed a lot of convar value to balance things
- Added a young state, npcs grow fast then stop ( young ) then grow again.
- NPCS are not eating their own meat, they won't target it, but they still become crazy if not enough food is present ( and very hungry , this does not affect human )
- NPCS can now eat eggs to stay alive
- Zombie drops 1 human and 1 headcrabs meat on death. (non natural death)
-Human now have crowbar !

Note :
Zombie are considered as headcrab, they can eat human meat but not headcrab one.
Zombie eggs are considered as human, they can be eat by other zombies and headcrab but not by human.

Things you will never notice :

- Changed a lot of internal code so the entities' script are much much smaller
- Improved the RC API.

## 2.0 pre release 5

(added) Torso zombies.

(Fix) Human death message are not showing as headcrab's ones.
(Fix) Headcrab are now attacking black headcrab when to hungry.

(Change) New addons format, so I can finally upload it to workshop ;).

## 2.0 pre release 4

- New trees stuff :
-- Randoming wich tree have to grow up
-- Increased melon spawning zone.
-- Tree limit increased
-- Tree are living older
-- Tree are spawning melon faster
-- Melon and tree are removing if the limit of the next tree is hit.
- Optimisation of food and trees,
- Bug fix related to rc_speed and rc_time (egg, meet, healing of npc)
- Melon now spawn on the ground.
- Npc can't lay egg when they are starving.
- some Balance

## 2.0 pre release 3

- The entities tab is now 'Realistic_Colonies' instead of 'Real_Colonies'.

- Adding human.
- Adding human egg.
- Adding human meat.
- Human can't eat human meat.

- Zombies egg look like human egg.
- Zombies are now droping human meat + headcrab meat instead of 3 headcrab meat.
- Zombies may now spawn from combat.
- Zombies now have there own hunger convar.

- Melon are now killable again (i'm trying a way so they explode when damaged.)

- Removed a gui thing.
- Optimized gui thing.
- Client side vars is now clientside xD

- Npcs may now eat human meat.
- Npcs may now eat others npc's egg.

Code side :

- Meat now have correct name.
- Plant now have correct name

## 2.0 pre release 2

- melon are not colony killer :).
- information writen over npc head are now related to their scale.
- fixed weapon to controll npc.
- fixed an other bug with weapon.
- reworked the weapon a bit.
- the resize bug is kinda fixed, since it is smoother.
- commented the old thing so it does not any error anymore.

## 2.0 pre release

- Adding growing effect of npc.
- Fixed headcrab having different Hp depanding of their model.
- Removed pink color of young npc.

- Fixed plant related timer wich was not according to delay between each execution.
- Fixed an Antlion death message showed as an Headcrab death message.
- Fixed Antlion and headcrab being able to eat more than 1 food at once.
- Fixed the colision bug with tree.
- Changed part of code that was quite useless.

- Changed death message.
- Changed how much leg are layed at once.
- Tree are growing faster.
- Increased max melon.
- Reduced health on spawn.
- Reduced max headcrab.

- Added random thing to egg time so the whole colonie does not lay egg at once.
- Added health regeneration overtime.
- They can now eat while they are not too hungry. (still imposible if <40)

- Removed Hp gained by eating.
