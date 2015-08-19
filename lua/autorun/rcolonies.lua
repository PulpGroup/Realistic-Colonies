--======================--
--=	Realistic      =--
--=	Colonies       =--
--======================--
AddCSLuaFile("rcoloniesclient.lua")

	 
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
		"Pipe",
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
CreateConVar("rc_printevents",1, {FCVAR_NOTIFY}) -- Shall we print death events ?
CreateConVar("rc_hateplayers",0, {FCVAR_NOTIFY}) --Makes colonies npcs hate player
CreateConVar("rc_remove",0, {FCVAR_NOTIFY}) --clean up colonies stuff ! / not recomanded to use
CreateConVar("rc_searchrad",2048, {FCVAR_NOTIFY}) -- Radius to search for food

CreateConVar("rc_time",1, {FCVAR_NOTIFY}) -- Delay between each execution of npcs stuff.
CreateConVar("rc_planttime",1, {FCVAR_NOTIFY}) --Delay between each execution of plant stuff.
CreateConVar("rc_speed",1, {FCVAR_NOTIFY}) -- Changes the speed of the addons.


--Meat stuff
CreateConVar("rc_meat_time",60, {FCVAR_NOTIFY}) -- Time needed for the meat to delete itself.

--Watermelon stuff
CreateConVar("rc_watermelon_time",50, {FCVAR_NOTIFY}) -- Time needed for a watermelon to become a plant.
CreateConVar("rc_watermelon_max",100, {FCVAR_NOTIFY}) -- Limit of watermelon.

-- Food value
CreateConVar("rc_hungry",35, {FCVAR_NOTIFY}) -- the % of maxhunger after which npcs will start searching for food
CreateConVar("rc_veryhungry",80, {FCVAR_NOTIFY}) -- the % of maxhunger after which npcs of same class can eat each others
-- It doesn't affect human.
CreateConVar("rc_food_melon" 			,40, {FCVAR_NOTIFY}) -- Food value of melon
CreateConVar("rc_food_antlion_meat" 	,35, {FCVAR_NOTIFY}) -- Food value of antlion's meat
CreateConVar("rc_food_headcrab_meat" 	,25, {FCVAR_NOTIFY}) -- Food value of headcrab's meat
CreateConVar("rc_food_human_meat" 		,50, {FCVAR_NOTIFY}) -- Food value of human's meat

CreateConVar("rc_food_antlion_egg"	 	,25, {FCVAR_NOTIFY}) -- Food value of antlion's egg
CreateConVar("rc_food_headcrab_egg" 	,20, {FCVAR_NOTIFY}) -- Food value of headcrab's egg
CreateConVar("rc_food_human_egg" 		,20, {FCVAR_NOTIFY}) -- Food value of human's egg
CreateConVar("rc_food_zombie_egg" 		,20, {FCVAR_NOTIFY}) -- Food value of zombie's egg

--Watermelon plant stuff
CreateConVar("rc_watermelonh_time",8, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelonb_time",12, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelonm_time",16, {FCVAR_NOTIFY}) --Time between each new watermelon
CreateConVar("rc_watermelons_time",20, {FCVAR_NOTIFY}) --Time between each new watermelon

CreateConVar("rc_watermelonh_size",150, {FCVAR_NOTIFY})-- Size of melon in %
CreateConVar("rc_watermelonb_size",100, {FCVAR_NOTIFY})-- Size of melon in %
CreateConVar("rc_watermelonm_size",75, {FCVAR_NOTIFY}) -- Size of melon in %
CreateConVar("rc_watermelons_size",50, {FCVAR_NOTIFY}) -- Size of melon in %

CreateConVar("rc_watermelonh_life",1200, {FCVAR_NOTIFY}) --Time between a tree death
CreateConVar("rc_watermelonb_life",600, {FCVAR_NOTIFY}) --Time between tree grow
CreateConVar("rc_watermelonm_life",240, {FCVAR_NOTIFY}) --Time between tree grow
CreateConVar("rc_watermelons_life",120, {FCVAR_NOTIFY}) --Time between tree grow
CreateConVar("rc_tree_maxh",2, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_tree_maxb",9, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_tree_maxm",14, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_tree_maxs",29, {FCVAR_NOTIFY}) --Maximum number of plant 
CreateConVar("rc_watermelonh_distance",1250, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant
CreateConVar("rc_watermelonb_distance",500, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant
CreateConVar("rc_watermelonm_distance",300, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant
CreateConVar("rc_watermelons_distance",150, {FCVAR_NOTIFY}) --Maximum/Minimum distance watermelons can spawn from the plant

--Antlion Vars
CreateConVar("rc_antlion_lifespan",300, {FCVAR_NOTIFY}) -- Lifespan of antlion.
CreateConVar("rc_antlion_hunger",1, {FCVAR_NOTIFY}) -- How fast should the hunger rise.
CreateConVar("rc_antlion_mhunger",150, {FCVAR_NOTIFY}) -- The max hunger before npc die of starvation
CreateConVar("rc_antlion_eggtime",10, {FCVAR_NOTIFY}) -- Time needed for the egg to break.
CreateConVar("rc_antlion_maturetime",50, {FCVAR_NOTIFY}) -- Time needed for an antlion to become adult
CreateConVar("rc_antlion_pregtime",80, {FCVAR_NOTIFY}) -- Time between each egg lay.
CreateConVar("rc_antlion_max",50, {FCVAR_NOTIFY}) --Maximum antlion population

--Human Vars
CreateConVar("rc_human_lifespan",450, {FCVAR_NOTIFY}) -- Lifespan of human.
CreateConVar("rc_human_hunger",1, {FCVAR_NOTIFY}) -- How fast should the hunger rise.
CreateConVar("rc_human_mhunger",200, {FCVAR_NOTIFY}) -- The max hunger before npc die of starvation
CreateConVar("rc_human_eggtime",20, {FCVAR_NOTIFY}) -- Time needed for the egg to break.
CreateConVar("rc_human_maturetime",80, {FCVAR_NOTIFY}) -- Time needed for an human to become adult
CreateConVar("rc_human_pregtime",120, {FCVAR_NOTIFY}) -- Time between each egg lay.
CreateConVar("rc_human_max",40, {FCVAR_NOTIFY}) --Maximum human population

--Headcrab Vars
CreateConVar("rc_zombie_lifespan",400, {FCVAR_NOTIFY}) -- Lifespan of zombies
CreateConVar("rc_zombie_hunger",1, {FCVAR_NOTIFY}) -- How quickly the hunger increases
CreateConVar("rc_zombie_max",35, {FCVAR_NOTIFY}) --Maximum zombie population
CreateConVar("rc_zombie_mhunger",225, {FCVAR_NOTIFY}) -- Maximum hunger of zombies.
CreateConVar("rc_zombie_maturetime",50, {FCVAR_NOTIFY}) --How long before the zombie matures
CreateConVar("rc_zombie_pregtime",75, {FCVAR_NOTIFY}) --How long between each egg
CreateConVar("rc_zombie_eggtime",15, {FCVAR_NOTIFY}) --How long before egg hatches

CreateConVar("rc_headcrab_lifespan",200, {FCVAR_NOTIFY}) --How long the headcrab lives for
CreateConVar("rc_headcrab_hunger",1, {FCVAR_NOTIFY}) -- How quickly the hunger increases
CreateConVar("rc_headcrab_mhunger",115, {FCVAR_NOTIFY}) -- Maximum hunger of headcrab.
CreateConVar("rc_headcrab_eggtime",5, {FCVAR_NOTIFY}) --How long before egg hatches
CreateConVar("rc_headcrab_maturetime",20, {FCVAR_NOTIFY}) --How long before the Headcrab matures
CreateConVar("rc_headcrab_pregtime",50, {FCVAR_NOTIFY}) --How long between each egg
CreateConVar("rc_headcrab_max",95, {FCVAR_NOTIFY}) --Maximum headcrab population
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
