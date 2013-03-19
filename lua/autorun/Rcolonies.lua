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
		"firefox",
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
		"Mozilla",
		"Thunderbird",
		"Steam",
		"Gordon",
		"chrome",
		"Bill",
		"Gates"
	}

--Global Convar
CreateConVar("rc_printevents",1, {FCVAR_NOTIFY}) --Wether or not to print info on deaths
CreateConVar("rc_hateplayers",0, {FCVAR_NOTIFY}) --Makes colonies guy hate persons
CreateConVar("rc_remove",0, {FCVAR_NOTIFY}) --clean up colonies stuff !
CreateClientConVar("rc_view", 768, true, false) --distance of view.
CreateConVar("rc_searchrad",1024, {FCVAR_NOTIFY}) -- Radius to search for food

CreateConVar("rc_time",1, {FCVAR_NOTIFY}) --Time for npc to run there script again (recommended from 0.5  to 2)
CreateConVar("rc_planttime",2, {FCVAR_NOTIFY}) --Time for plant to run there script again (recommended from 1 to 4)
CreateConVar("rc_speed",1, {FCVAR_NOTIFY}) --how fast stuff should happen ?(recommended  1)


--Meat stuff
CreateConVar("rc_meat_time",45, {FCVAR_NOTIFY}) --Time between meat remove

--Watermelon stuff
CreateConVar("rc_watermelon_time",75, {FCVAR_NOTIFY}) --Time between new plant
CreateConVar("rc_watermelon_max",75, {FCVAR_NOTIFY}) --Maximum number of watermelons before plant stops spawning

--Watermelon plant stuff
CreateConVar("rc_watermelonb_time",10, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelonbg_time",15, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelonbm_time",20, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelonbs_time",25, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelonp_life",500, {FCVAR_NOTIFY}) --Time between a tree death
CreateConVar("rc_watermelonbgg_time",300, {FCVAR_NOTIFY}) --Time between tree dead / grow
CreateConVar("rc_watermelonbmg_time",200, {FCVAR_NOTIFY}) --Time between tree dead / grow
CreateConVar("rc_watermelonbsg_time",100, {FCVAR_NOTIFY}) --Time between tree dead / grow
CreateConVar("rc_tree_max",3, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_tree_maxh",5, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_tree_maxm",7, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_tree_maxs",15, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_watermelonb_distance",125, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant
CreateConVar("rc_watermelons_distance",20, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant
CreateConVar("rc_watermelonm_distance",30, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant
CreateConVar("rc_watermelong_distance",40, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant



--Antlion Vars
CreateConVar("rc_antlion_lifespan",285, {FCVAR_NOTIFY}) 
CreateConVar("rc_antlion_hunger",1, {FCVAR_NOTIFY})
CreateConVar("rc_antlion_mhunger",95, {FCVAR_NOTIFY})
CreateConVar("rc_antlion_eggtime",20, {FCVAR_NOTIFY})
CreateConVar("rc_antlion_maturetime",55, {FCVAR_NOTIFY})
CreateConVar("rc_antlion_pregtime",95, {FCVAR_NOTIFY})
CreateConVar("rc_antlion_max",35, {FCVAR_NOTIFY}) --Maximum antlion population
CreateConVar("rc_antlion_healing",1, {FCVAR_NOTIFY})

--Headcrab Vars
CreateConVar("rc_zombie_lifespan",395, {FCVAR_NOTIFY}) --How long the zombie lives for
CreateConVar("rc_zombie_max",15, {FCVAR_NOTIFY}) --Maximum zombie population
CreateConVar("rc_zombie_mhunger",115, {FCVAR_NOTIFY})
CreateConVar("rc_zombie_maturetime",65, {FCVAR_NOTIFY}) --How long before the zombie matures
CreateConVar("rc_zombie_pregtime",65, {FCVAR_NOTIFY}) --How long between each egg
CreateConVar("rc_zombie_eggtime",10, {FCVAR_NOTIFY}) --How long before egg hatches

CreateConVar("rc_headcrab_lifespan",195, {FCVAR_NOTIFY}) --How long the headcrab lives for
CreateConVar("rc_headcrab_hunger",1, {FCVAR_NOTIFY}) -- How quickly the hunger increases
CreateConVar("rc_headcrab_mhunger",75, {FCVAR_NOTIFY})
CreateConVar("rc_headcrab_eggtime",10, {FCVAR_NOTIFY}) --How long before egg hatches
CreateConVar("rc_headcrab_maturetime",30, {FCVAR_NOTIFY}) --How long before the Headcrab matures
CreateConVar("rc_headcrab_pregtime",65, {FCVAR_NOTIFY}) --How long between each egg
CreateConVar("rc_headcrab_max",75, {FCVAR_NOTIFY}) --Maximum headcrab population
CreateConVar("rc_headcrab_healing",1, {FCVAR_NOTIFY})
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
