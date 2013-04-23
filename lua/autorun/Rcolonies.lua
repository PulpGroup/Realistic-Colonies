--======================--
--=	Realistic      =--
--=	Colonies       =--
--======================--
AddCSLuaFile("Rcoloniesclient.lua")

	 
	coloniesnames = {
		"Bob",
		"Frank",
		"John",
		"David",
		"Mark",
		"Carl",
		"Russell",
		"Neil",
		"Amy",
		"Chris",
		"Aimiee",
		"Sarah",
		"Kent",
		"Barry",
		"Scott",
		"Christine",
		"Jenny",
		"Josh",
		"Alien",
		"Scotty",
		"Fred",
		"Garry",
		"Erik",
		"Harry",
		"Jean",
		"Harry",
		"Abby",
		"Alfred",
		"Amy",
		"Andy",
		"Abe",
		"Bart",
		"Bryan",
		"Bryce",
		"Alice",
		"Ashley",
		"Gordon",
		"Mafiatoss",
		"Cake",
		"Jean",
		"Pipé",
		"Cupcake",
		"Mr Troll",
		"Kerrigan",
		"Jim",
		"Raynor",
		"Douglas",
		"Adams",
		"Link",
		"Zelda",
		"Arthas",
		"Sharlock",
		"Homes",
		"Simpson",
		"Homer",
		"Edisier",
		"Christophe",
		"Eric",
		"Hugo",
		"Victor",
		"Renner",
		"Denoel",
		"Poivre",
		"Sel",
		"Saarlouis",
		"RitzenHoff",
		"Terraria",
		"Seb",
		"Pipi",
		"Caca",
		"Hint",
		"Bill"
	}

--Global Convar
CreateConVar("rc_printevents",1, {FCVAR_NOTIFY}) --Wether or not to print info on deaths
CreateConVar("rc_hateplayers",0, {FCVAR_NOTIFY}) --Makes colonies guy hate player
CreateConVar("rc_remove",0, {FCVAR_NOTIFY}) --clean up colonies stuff ! / not recomanded to use
CreateClientConVar("rc_view", 768, true, false) --distance of view.
CreateConVar("rc_searchrad",1024, {FCVAR_NOTIFY}) -- Radius to search for food

CreateConVar("rc_time",1, {FCVAR_NOTIFY}) -- Delay between each execution of npcs stuff.
CreateConVar("rc_planttime",2, {FCVAR_NOTIFY}) --Delay between each execution of plant stuff.
CreateConVar("rc_speed",1, {FCVAR_NOTIFY}) -- Changes the speed of the addons.


--Meat stuff
CreateConVar("rc_meat_time",60, {FCVAR_NOTIFY}) -- Time needed for the meat to delete itself.

--Watermelon stuff
CreateConVar("rc_watermelon_time",60, {FCVAR_NOTIFY}) -- Time needed for a watermelon to become a plant.
CreateConVar("rc_watermelon_max",150, {FCVAR_NOTIFY}) -- Limit of watermelon.

--Watermelon plant stuff
CreateConVar("rc_watermelonb_time",10, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelonbg_time",15, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelonbm_time",20, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelonbs_time",25, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelonp_life",500, {FCVAR_NOTIFY}) --Time between a tree death
CreateConVar("rc_watermelonbgg_time",250, {FCVAR_NOTIFY}) --Time between tree grow
CreateConVar("rc_watermelonbmg_time",160, {FCVAR_NOTIFY}) --Time between tree grow
CreateConVar("rc_watermelonbsg_time",80, {FCVAR_NOTIFY}) --Time between tree grow
CreateConVar("rc_tree_max",3, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_tree_maxh",5, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_tree_maxm",7, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_tree_maxs",15, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_watermelonb_distance",125, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant
CreateConVar("rc_watermelons_distance",20, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant
CreateConVar("rc_watermelonm_distance",30, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant
CreateConVar("rc_watermelong_distance",40, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant



--Antlion Vars
CreateConVar("rc_antlion_lifespan",285, {FCVAR_NOTIFY}) -- Lifespan of antlion.
CreateConVar("rc_antlion_hunger",1, {FCVAR_NOTIFY}) -- How fast should the hunger rise.
CreateConVar("rc_antlion_mhunger",95, {FCVAR_NOTIFY}) -- The max hunger before npc die of starvation
CreateConVar("rc_antlion_eggtime",20, {FCVAR_NOTIFY}) -- Time needed for the egg to break.
CreateConVar("rc_antlion_maturetime",55, {FCVAR_NOTIFY}) -- Time needed for an antlino to become adult
CreateConVar("rc_antlion_pregtime",95, {FCVAR_NOTIFY}) -- Time between each egg lay.
CreateConVar("rc_antlion_max",35, {FCVAR_NOTIFY}) --Maximum antlion population

--Headcrab Vars
CreateConVar("rc_zombie_lifespan",395, {FCVAR_NOTIFY}) -- Lifespan of zombies
CreateConVar("rc_zombie_hunger",1, {FCVAR_NOTIFY}) -- How quickly the hunger increases
CreateConVar("rc_zombie_max",25, {FCVAR_NOTIFY}) --Maximum zombie population
CreateConVar("rc_zombie_mhunger",115, {FCVAR_NOTIFY}) -- Maximum hunger of zombies.
CreateConVar("rc_zombie_maturetime",65, {FCVAR_NOTIFY}) --How long before the zombie matures
CreateConVar("rc_zombie_pregtime",65, {FCVAR_NOTIFY}) --How long between each egg
CreateConVar("rc_zombie_eggtime",10, {FCVAR_NOTIFY}) --How long before egg hatches

CreateConVar("rc_headcrab_lifespan",195, {FCVAR_NOTIFY}) --How long the headcrab lives for
CreateConVar("rc_headcrab_hunger",1, {FCVAR_NOTIFY}) -- How quickly the hunger increases
CreateConVar("rc_headcrab_mhunger",75, {FCVAR_NOTIFY}) -- Maximum hunger of headcrab.
CreateConVar("rc_headcrab_eggtime",10, {FCVAR_NOTIFY}) --How long before egg hatches
CreateConVar("rc_headcrab_maturetime",30, {FCVAR_NOTIFY}) --How long before the Headcrab matures
CreateConVar("rc_headcrab_pregtime",65, {FCVAR_NOTIFY}) --How long between each egg
CreateConVar("rc_headcrab_max",65, {FCVAR_NOTIFY}) --Maximum headcrab population
CreateConVar("rc_headcrab_tozombie",1, {FCVAR_NOTIFY}) --Should Headcrabs spawn zombies when they kill citizens


hook.Add("Initialize","ColonyTags",function() local tags = GetConVarString("sv_tags") or " "
	if string.find(tags,"colonies") == nil then
		RunConsoleCommand("sv_tags", tags..",Realistic Colonies Beta") 
	end
end)

hook.Add("OnNPCKilled","ColonyKilledNPC",function(v, k, w) 
	local Ok=0
	
	if v:GetClass() == "npc_citizen" or v:GetClass() == "npc_rebel" then
		Ok=1
	end
	
	if k:GetClass():sub(1,12) == "npc_headcrab" and k:GetNWBool("HC") and Ok==1 and GetConVarNumber("rc_headcrab_tozombie") == 1 then
		--Remove both the headcrab and the killed NPC and replace with zombie
		local zomb = ents.Create( "colonies_zombie" )
		zomb:SetPos(v:GetPos())
		zomb:Spawn()
		v:Remove()
		k:Remove()
	end
	
end)

hook.Add("PlayerInitialSpawn","ColoniesDefaultPlayerFaction",function(ply, sid) ply:SetPData("HCfaction","Default Faction") end)
--Function to set player faction
function ColoniesPlayerFaction(ply, cmnd, args)
	if args[1] then
		ply:SetPData("HCfaction",args[1])
	end
end
concommand.Add("rc_myfaction",ColoniesPlayerFaction)
