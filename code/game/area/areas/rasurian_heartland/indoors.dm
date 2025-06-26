
// INDOORS

/area/rasurian_heartland/indoors
	name = "The Keep Of Rasura"
	icon_state = "rasura"
	ambientrain = RAIN_IN
	ambientsounds = AMB_INGEN
	ambientnight = AMB_INGEN
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/towngen.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	soundenv = 2
	first_time_text = "THE KEEP OF RASURA"
	noteleport = TRUE
	blob_allowed = FALSE //Should go without saying, no blobs should take over centcom as a win condition.
	flags_1 = NONE
	brief_descriptor = "somewhere far, far away"
	general_location = /area::general_location
	converted_type = /area/rasurian_heartland/outdoors

/area/rasurian_heartland/indoors/prison
	name = "Heartland Prison"

/area/rasurian_heartland/indoors/artificacy_launchbay
	name = "Artificacy Launchbay"
	icon_state = "artificacy_launchbay"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/// Stores created supplypods briefly.
/area/rasurian_heartland/indoors/artificacy_launchbay/podStorage
	name = "Artificacy Launchbay Storage"

/area/rasurian_heartland/indoors/artificacy_launchbay/bay_one
	name = "Bay #1"

/area/rasurian_heartland/indoors/artificacy_launchbay/bay_two
	name = "Bay #2"

/area/rasurian_heartland/indoors/artificacy_launchbay/bay_three
	name = "Bay #3"

/area/rasurian_heartland/indoors/artificacy_launchbay/bay_four
	name = "Bay #4"

/area/rasurian_heartland/indoors/artificacy_launchbay/aetherial_road
	name = "Aetherial Road"
