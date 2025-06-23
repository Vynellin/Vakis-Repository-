
// CENTCOM

/area/centcom
	name = "CentCom"
	icon_state = "centcom"
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	noteleport = TRUE
	blob_allowed = FALSE //Should go without saying, no blobs should take over centcom as a win condition.
	flags_1 = NONE

/area/centcom/prison
	name = "Admin Prison"

/area/centcom/holding
	name = "Holding Facility"

/area/centcom/supplypod/flyMeToTheMoon
	name = "Supplypod Shipping lane"
	icon_state = "supplypod_flight"

/area/centcom/supplypod
	name = "Supplypod Facility"
	icon_state = "supplypod"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/area/centcom/supplypod/podStorage
	name = "Supplypod Storage"
	icon_state = "supplypod_holding"

/area/centcom/supplypod/loading
	name = "Supplypod Loading Facility"
	icon_state = "supplypod_loading"

/area/centcom/supplypod/loading/one
	name = "Bay #1"

/area/centcom/supplypod/loading/two
	name = "Bay #2"

/area/centcom/supplypod/loading/three
	name = "Bay #3"

/area/centcom/supplypod/loading/four
	name = "Bay #4"

/area/centcom/supplypod/loading/ert
	name = "ERT Bay"
