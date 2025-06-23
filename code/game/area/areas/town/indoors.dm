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

/area/provincial/indoors/town/shop
	name = "Shop"
	icon_state = "shop"
	droning_sound = 'sound/music/area/shop.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	converted_type = /area/provincial/outdoors/shop

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

/area/provincial/indoors/town/dwarfin
	name = "dwarven quarter"
	icon_state = "dwarfin"
	droning_sound = 'sound/music/area/dwarf.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "The Dwarven Quarter"
	converted_type = /area/provincial/outdoors/dwarfin
	brief_descriptor = "where craftsmen toil and legends are prepared"

/area/provincial/indoors/town/warehouse
	name = "dock warehouse import"
	icon_state = "warehouse"
	brief_descriptor = "where the steward imports goods"
	general_location = "Below town!"

/area/provincial/indoors/town/warehouse/can_craft_here()
	return FALSE

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
