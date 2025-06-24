/area/provincial/indoors/town
	name = "Solaris Ridge - Interior"
	icon_state = "town"
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/provincial/outdoors/town
	town_area = TRUE
	brief_descriptor = "nestled within walls of walls inside Solaris Ridge."
	general_location = "Inside the town of Solaris Ridge!"

/// ADVENTURER'S GUILD ///

/area/provincial/indoors/town/adventurers_guild
	name = "Solaris Ridge - Adventurer's Guild"

/area/provincial/indoors/town/adventurers_guild/handlers_office
	name = "Solaris Ridge - Guild Handler's Office"

/area/provincial/indoors/town/adventurers_guild/handlers_office/bedroom
	name = "Solaris Ridge - Guild Handler's Bedroom"

/// BASEMENT ///

/area/provincial/indoors/town/basement
	name = "Solaris Ridge - Basement"
	icon_state = "basement"
	ambientsounds = AMB_BASEMENT
	ambientnight = AMB_BASEMENT
	spookysounds = SPOOKY_DUNGEON
	spookynight = SPOOKY_DUNGEON
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	soundenv = 5
	brief_descriptor = "beneath the bustle of the city"
	general_location = "From below Solaris Ridge!"

/// BLACKSMITH ///

/area/provincial/indoors/town/blacksmith
	name = "Solaris Ridge - Blacksmith"
	icon_state = "dwarfin"
	droning_sound = 'sound/music/area/dwarf.ogg'
	brief_descriptor = "where craftsmen toil and legends are prepared"

/// DUSK QUARTER ///

/area/provincial/indoors/town/dusk_quarter
	name = "Solaris Ridge - Dusk Quarter"
	icon_state = "dwarfin"
	first_time_text = "The Dusk Quarter"

/// JANITOR'S ABODE ///

/area/provincial/indoors/town/janitors_abode
	name = "Solaris Ridge - Janitor's Abode"

/// MAGE'S UNIVERSITY ///

/area/provincial/indoors/town/mages_university
	name = "Solaris Ridge - Mage's University"

/area/provincial/indoors/town/mages_university/alchemy_lab
	name = "Solaris Ridge - University Alchemy Lab"

/area/provincial/indoors/town/mages_university/archivist
	name = "Solaris Ridge - Archivist's Office"

/area/provincial/indoors/town/mages_university/archivist/quarters
	name = "Solaris Ridge - Archivist's Quarters"

/area/provincial/indoors/town/mages_university/artificer
	name = "Solaris Ridge - Artificer's Office"

/area/provincial/indoors/town/mages_university/established_mage_hall
	name = "Solaris Ridge - Established Mage Hall"

/area/provincial/indoors/town/mages_university/head_mage
	name = "Solaris Ridge - Head Mage's Quarters"

/area/provincial/indoors/town/mages_university/kitchen
	name = "Solaris Ridge - University Kitchen"

/area/provincial/indoors/town/mages_university/library
	name = "Solaris Ridge - Library"

/area/provincial/indoors/town/mages_university/shared_storage
	name = "Solaris Ridge - University Shared Storage"

/// STALLS ///
/area/provincial/indoors/town/stall
	name = "Solaris Ridge - Stall I"

/area/provincial/indoors/town/stall/stall_two
	name = "Solaris Ridge - Stall II"

/area/provincial/indoors/town/stall/stall_three
	name = "Solaris Ridge - Stall III"

/// STEWARD ///
/area/provincial/indoors/town/steward
	name = "Solaris Ridge - Stewardry"
	icon_state = "warehouse"

/area/provincial/indoors/town/steward/import_platform
	name = "dock warehouse import"
	brief_descriptor = "where the steward imports goods"
	general_location = "Below town!"

/area/provincial/indoors/town/steward/import_platform/can_craft_here()
	return FALSE

/// RAMPARTS ///

/area/provincial/indoors/town/ramparts
	name = "Solaris Ridge - Ramparts"
	icon_state = "garrison"

/// SEWERS ///

/area/provincial/indoors/town/sewer
	name = "Solaris Ridge - Sewers"
	icon_state = "sewer"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_RATS
	spookynight = SPOOKY_RATS
	droning_sound = 'sound/music/area/sewers.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambientrain = RAIN_SEWER
	soundenv = 21
	brief_descriptor = "where rat and murk mingle twice-over"
	general_location = /area/provincial/indoors/town/basement::general_location

/// SHOP ///

/area/provincial/indoors/town/shop
	name = "Shop"
	icon_state = "shop"
	droning_sound = 'sound/music/area/shop.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/provincial/outdoors/shop

/// TAVERN ///

/area/provincial/indoors/town/tavern
	name = "The Rasurian Pint"
	icon_state = "tavern"
	ambientsounds = AMB_INGEN
	ambientnight = AMB_INGEN
	droning_sound = 'sound/silence.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/provincial/outdoors/tavern
	brief_descriptor = "where merriment sparks and bards play"

/// TAILOR ///

/area/provincial/indoors/town/tailor
	name = "Solaris Ridge - Tailor"

/// VETERAN'S HOUSE ///

/area/provincial/indoors/town/veterans_house
	name = "Solaris Ridge - Veteran's House"
	icon_state = "garrison"
