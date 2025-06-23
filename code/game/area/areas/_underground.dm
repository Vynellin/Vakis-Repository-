/area/provincial/underground
	name = "cave"
	warden_area = TRUE
	icon_state = "cave"
	ambientsounds = AMB_GENCAVE
	ambientnight = AMB_GENCAVE
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/floor/rogue/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/bigrat = 30,
				/mob/living/carbon/human/species/goblin/npc/ambush/cave = 20,
				/mob/living/carbon/human/species/skeleton/npc/ambush = 10,
				/mob/living/simple_animal/hostile/retaliate/rogue/minotaur = 5)
	brief_descriptor = "where rock and murk intermingle"

// these don't get a rain sound because they're underground
/area/provincial/underground/basement
	name = "basement"
	icon_state = "under"
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	soundenv = 8
	brief_descriptor = "walls and ceiling abound, yet no windows to be found"
	general_location = "From somewhere below!"
	ambush_times = null
	ambush_types = null
	ambush_mobs = null
