-------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
function TMIsCritter(Name)                                                                                                        -- Function To Check If Critter
	if (GetUnitLevel("reticleover") ~= 1) then return false end                                                                 -- Critters Are Always Level 1
	local Critters = {                                                                                                          -- The List Of Critters
		"Lizard", "Rat", "Snake", "Pony Guar", "Frog", "Squirrel", "Rabbit", "Deer", "Cat", "Pig", "Sheep", "Antelope", "Monkey", "Centipede", "Chicken", "Spider", "Scorpion", "Goat", "Scrib", "Scuttler",
	}
	for I = 1, #Critters do                                                                                                     -- Is The Target A Critter?
		if (Name == Critters[I]) then return true end
	end
	return false                                                                                                                -- Otherwise False
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMIsCollectableCritter(Name)                                                                                             -- Function To Check If Critter
	if (GetUnitLevel("reticleover") ~= 1) then return false end               
	local CCritters = {                                                        
		"Butterfly", "Wasp", "Fleshflies", "Torchbug",
	}
	for I = 1, #CCritters do                                                    
		if (Name == CCritters[I]) then return true end
	end
	return false                                                               
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TMIsPlayerPet(Name)                                                                                                      -- Function To Check If Pet
    local PReaction = GetUnitReaction("reticleover")                                                       
	local Pets = {                                                         
		"Familiar", "Volatile Familiar", "Clannfear", "Unstable Clannfear", "Summon Winged Twilight", "Restoring Twilight", "Twilight Matriarch",
	}
    if PReaction == UNIT_REACTION_HOSTILE then return end
	for I = 1, #Pets do                                                    
		if (Name == Pets[I]) then return true end
	end
	return false                                                               
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------