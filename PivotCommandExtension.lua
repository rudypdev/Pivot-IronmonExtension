-- Pivot Command Extension for Ironmon Tracker
-- This extension provides a "!pivot" command that helps monitor pivot mons in Super Kaiso ironmon.

local function PivotCommandExtension()
	local self = {}
	self.version = "1.0"
	self.name = "Pivot Command Extension"
	self.author = "rudyp"
	self.description = "Provides a !pivot command that shows Pokemon catch locations"
	self.github = "" -- Add your GitHub repo if you have one

	-- Location lookup table (hex value -> location name)
	-- Only supports LGFR locations, copied from http://bulbapedia.bulbagarden.net/wiki/List_of_locations_by_index_number_in_Generation_III 
	local locationIdToName = {
		[0x58] = "Pallet Town",
		[0x59] = "Viridian City",
		[0x5A] = "Pewter City",
		[0x5B] = "Cerulean City",
		[0x5C] = "Lavender Town",
		[0x5D] = "Vermilion City",
		[0x5E] = "Celadon City",
		[0x5F] = "Fuchsia City",
		[0x60] = "Cinnabar Island",
		[0x61] = "Indigo Plateau",
		[0x62] = "Saffron City",
		[0x63] = "Route 4 (Pokémon Center)",
		[0x64] = "Route 10 (Pokémon Center)",
		[0x65] = "Route 1",
		[0x66] = "Route 2",
		[0x67] = "Route 3",
		[0x68] = "Route 4",
		[0x69] = "Route 5",
		[0x6A] = "Route 6",
		[0x6B] = "Route 7",
		[0x6C] = "Route 8",
		[0x6D] = "Route 9",
		[0x6E] = "Route 10",
		[0x6F] = "Route 11",
		[0x70] = "Route 12",
		[0x71] = "Route 13",
		[0x72] = "Route 14",
		[0x73] = "Route 15",
		[0x74] = "Route 16",
		[0x75] = "Route 17",
		[0x76] = "Route 18",
		[0x77] = "Route 19",
		[0x78] = "Route 20",
		[0x79] = "Route 21",
		[0x7A] = "Route 22",
		[0x7B] = "Route 23",
		[0x7C] = "Route 24",
		[0x7D] = "Route 25",
		[0x7E] = "Viridian Forest",
		[0x7F] = "Mt. Moon",
		[0x80] = "S.S. Anne",
		[0x81] = "Underground Path (Routes 5-6)",
		[0x82] = "Underground Path (Routes 7-8)",
		[0x83] = "Diglett's Cave",
		[0x84] = "Victory Road",
		[0x85] = "Rocket Hideout",
		[0x86] = "Silph Co.",
		[0x87] = "Pokémon Mansion",
		[0x88] = "Safari Zone",
		[0x89] = "Pokémon League",
		[0x8A] = "Rock Tunnel",
		[0x8B] = "Seafoam Islands",
		[0x8C] = "Pokémon Tower",
		[0x8D] = "Cerulean Cave",
		[0x8E] = "Power Plant",
		[0x8F] = "One Island",
		[0x90] = "Two Island",
		[0x91] = "Three Island",
		[0x92] = "Four Island",
		[0x93] = "Five Island",
		[0x94] = "Seven Island",
		[0x95] = "Six Island",
		[0x96] = "Kindle Road",
		[0x97] = "Treasure Beach",
		[0x98] = "Cape Brink",
		[0x99] = "Bond Bridge",
		[0x9A] = "Three Isle Port",
		[0x9B] = "Sevii Isle 6",
		[0x9C] = "Sevii Isle 7",
		[0x9D] = "Sevii Isle 8",
		[0x9E] = "Sevii Isle 9",
		[0x9F] = "Resort Gorgeous",
		[0xA0] = "Water Labyrinth",
		[0xA1] = "Five Isle Meadow",
		[0xA2] = "Memorial Pillar",
		[0xA3] = "Outcast Island",
		[0xA4] = "Green Path",
		[0xA5] = "Water Path",
		[0xA6] = "Ruin Valley",
		[0xA7] = "Trainer Tower (exterior)",
		[0xA8] = "Canyon Entrance",
		[0xA9] = "Sevault Canyon",
		[0xAA] = "Tanoby Ruins",
		[0xAB] = "Sevii Isle 22",
		[0xAC] = "Sevii Isle 23",
		[0xAD] = "Sevii Isle 24",
		[0xAE] = "Navel Rock",
		[0xAF] = "Mt. Ember",
		[0xB0] = "Berry Forest",
		[0xB1] = "Icefall Cave",
		[0xB2] = "Rocket Warehouse",
		[0xB3] = "Trainer Tower",
		[0xB4] = "Dotted Hole",
		[0xB5] = "Lost Cave",
		[0xB6] = "Pattern Bush",
		[0xB7] = "Altering Cave",
		[0xB8] = "Tanoby Chambers",
		[0xB9] = "Three Isle Path",
		[0xBA] = "Tanoby Key",
		[0xBB] = "Birth Island",
		[0xBC] = "Monean Chamber",
		[0xBD] = "Liptoo Chamber",
		[0xBE] = "Weepth Chamber",
		[0xBF] = "Dilford Chamber",
		[0xC0] = "Scufib Chamber",
		[0xC1] = "Rixy Chamber",
		[0xC2] = "Viapois Chamber",
		[0xC3] = "Ember Spa",
		[0xC4] = "Celadon Dept"
	}

	-- Helper function to find items in bag by name substring (case insensitive)
	local function findItemsByName(searchString)
		local foundItems = {}
		
		-- Check all bag pockets for items containing the search string
		for bagKey, itemGroup in pairs(Program.GameData.Items) do
			if type(itemGroup) == "table" then
				for id, quantity in pairs(itemGroup) do
					if quantity > 0 and MiscData.Items[id] then
						local itemName = MiscData.Items[id]
						if string.find(string.lower(itemName), string.lower(searchString)) then
							table.insert(foundItems, { id = id, text = itemName, quantity = quantity })
						end
					end
				end
			end
		end
		
		return foundItems
	end


	local function handleMushroomsSubcommand(params)
		local mushroomItems = findItemsByName("mushroom")
		
		if #mushroomItems == 0 then
			return "Mushrooms > No mushroom items."
		end
		
		table.sort(mushroomItems, function(a, b) return a.id < b.id end)
		
		local itemList = {}
		for _, item in ipairs(mushroomItems) do
			table.insert(itemList, string.format("%s (%s)", item.text, item.quantity))
		end
		
		return "Mushrooms > " .. table.concat(itemList, ", ")
	end

	local function handleCandySubcommand(params)
		local candyItems = findItemsByName("rare candy")
		
		if #candyItems == 0 then
			return "Candy > No rare candies."
		end
		
		table.sort(candyItems, function(a, b) return a.id < b.id end)
		
		local itemList = {}
		for _, item in ipairs(candyItems) do
			table.insert(itemList, string.format("%s (%s)", item.text, item.quantity))
		end
		
		return "Candy > " .. table.concat(itemList, ", ")
	end

	local function handleEvolutionSubcommand(params)
		local evolutionItems = {}
		
		-- Get all evolution items from bag
		for id, quantity in pairs(Program.GameData.Items.EvoStones or {}) do
			if quantity > 0 and MiscData.Items[id] then
				table.insert(evolutionItems, { id = id, text = MiscData.Items[id], quantity = quantity })
			end
		end
		
		if #evolutionItems == 0 then
			return "Evo Stones > No evolution stones."
		end

		table.sort(evolutionItems, function(a, b) return a.id < b.id end)
		
		local itemList = {}
		for _, item in ipairs(evolutionItems) do
			table.insert(itemList, string.format("%s (%s)", item.text, item.quantity))
		end
		
		return "Evo Stones > " .. table.concat(itemList, ", ")
	end

	local function handlePivotCommand(params)
		if not Program.GameData then
			return "Pivot > Data not available."
		end

		-- Check if this is a subcommand
		if params and not Utils.isNilOrEmpty(params) then
			local subcommand = Utils.toLowerUTF8(params:match("^%s*(%w+)"))
			
			if subcommand == "mushrooms" then
				return handleMushroomsSubcommand(params:match("^%s*%w+%s*(.*)"))
			elseif subcommand == "candy" or subcommand == "candies" then
				return handleCandySubcommand(params:match("^%s*%w+%s*(.*)"))
			elseif subcommand == "evo" or subcommand == "stones" then
				return handleEvolutionSubcommand(params:match("^%s*%w+%s*(.*)"))
			end
		end

		-- Default pivot command behavior 
		-- In ironmon, we generally only care about the first pokemon in the party.
		local pokemon = Tracker.getPokemon(1, true)
		if not pokemon then
			return "Pivot > No Pokemon in slot 1."
		end

		-- Read the Pokemon's memory data to get misc1
		local pokemonAddress = GameSettings.pstats
		local personality = Memory.readdword(pokemonAddress)
		local otid = Memory.readdword(pokemonAddress + 4)
		local magicword = Utils.bit_xor(personality, otid)

		-- Calculate misc substructure offset (same as Program.lua)
		local aux = personality % 24 + 1
		local miscoffset = (MiscData.TableData.misc[aux] - 1) * 12
		local misc1 = Utils.bit_xor(Memory.readdword(pokemonAddress + Program.Addresses.offsetPokemonSubstruct + miscoffset), magicword)
		-- Found where location is stored from https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9mon_data_substructures_%28Generation_III%29
		local metLocationId = Utils.getbits(misc1, 8, 8)

		local locationName = locationIdToName[metLocationId] or string.format("Unknown Location (0x%02X)", metLocationId)
		local pokemonName = pokemon.nickname or PokemonData.Pokemon[pokemon.pokemonID].name

		-- Check if this Pokemon is a pivot (caught in Safari Zone)
		local isPivot = (metLocationId == 0x88) -- Safari Zone location ID

		if isPivot then
			return string.format("Pivot > %s IS the pivot!", pokemonName)
		else
			-- Special message for Pokemon caught in Pallet Town
			if metLocationId == 0x58 then -- Pallet Town location ID
				return string.format("Pivot > %s IS NOT the Pivot, it came out of the lab!", pokemonName)
			else
				return string.format("Pivot > %s IS NOT the Pivot. It was caught in %s.", pokemonName, locationName)
			end
		end
	end

	-- Create the command event
	self.CommandEvent = EventHandler.IEvent:new({
		Key = "CMD_Pivot",
		Type = EventHandler.EventTypes.Command,
		Name = "[EXT] Pivot Command",
		Command = "!pivot",
		Help = "> Shows if first Pokemon is a pivot or item info. Usage: !pivot, !pivot mushrooms, !pivot candy, !pivot evo/stones",
		Fulfill = function(this, request)
			return handlePivotCommand(request.SanitizedInput)
		end
	})
	self.CommandEvent.IsEnabled = false

	function self.startup()
		-- Register our command event
		EventHandler.addNewEvent(self.CommandEvent)
	end

	function self.unload()
		-- Remove our command event
		EventHandler.removeEvent(self.CommandEvent.Key)
	end

	return self
end

return PivotCommandExtension
