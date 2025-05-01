/// GEN TURF ///
/// Used for marking areas that'll have generators override them for map editors.
/turf/open/gen_turf
	name = "UNGENERATED TURF"
	desc = "If you see this in-game, this was either incorrectly called as an area's baseturf or mistakenly\
	placed outside an area that's generated on the fly! Get a coder!"
	icon = 'icons/turf/floors.dmi'
	icon_state = "genturf"

/// This secondary gen turf is meant for distinguishing if two different area generators are being used next to each other.
/turf/open/gen_turf/alt
	icon_state = "genturf_alt"

/// Ditto for a third.
/turf/open/gen_turf/alt_two
	icon_state = "genturf_alt_two"
