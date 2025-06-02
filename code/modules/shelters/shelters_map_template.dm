/// Map templates used for summoning shelters.
/datum/map_template/shelter
	has_ceiling = TRUE
	ceiling_turf = /turf/open/floor/rogue/rooftop
	ceiling_baseturfs = list(/turf/open/transparent/openspace)
	/// The description of the shelter, shown when examining the shelter pod.
	var/description
	/// If turf in the affected turfs is in this list, the shelter cannot be deployed.
	/// This list gets automatically converted into a typecache when this datum is initialized.
	var/list/blacklisted_turfs = list(/turf/closed)
	/// Areas where the pod cannot be deployed.
	/// This list gets automatically converted into a typecache when this datum is initialized.
	var/list/banned_areas
	/// If any object in this list is found in the affected turfs, the shelter cannot deploy.
	/// This list gets automatically converted into a typecache when this datum is initialized.
	var/list/banned_objects


/datum/map_template/shelter/New()
	. = ..()
	LAZYINITLIST(blacklisted_turfs)
	blacklisted_turfs = typecacheof(blacklisted_turfs)
	LAZYINITLIST(banned_areas)
	banned_areas = typecacheof(banned_areas)
	LAZYINITLIST(banned_objects)
	banned_objects = typecacheof(banned_objects)

/datum/map_template/shelter/proc/check_deploy(turf/deploy_location, obj/item/shelter_pod/pod, ignore_flags = NONE)
	var/affected = get_affected_turfs(deploy_location, centered=TRUE)
	for(var/turf/turf in affected)
		var/area/area = get_area(turf)
		if(is_type_in_typecache(area, banned_areas))
			return SHELTER_DEPLOY_BAD_AREA

		if(is_type_in_typecache(turf, blacklisted_turfs))
			return SHELTER_DEPLOY_BAD_TURFS

		for(var/obj/object in turf)
			if(!(ignore_flags & CAPSULE_IGNORE_ANCHORED_OBJECTS) && object.density && object.anchored)
				return SHELTER_DEPLOY_ANCHORED_OBJECTS
			if(!(ignore_flags & CAPSULE_IGNORE_BANNED_OBJECTS) && is_type_in_typecache(object, banned_objects))
				return SHELTER_DEPLOY_BANNED_OBJECTS

	// Check if the shelter sticks out of map borders
	var/shelter_origin_x = deploy_location.x - round(width/2)
	if(shelter_origin_x <= 1 || shelter_origin_x+width > world.maxx)
		return SHELTER_DEPLOY_OUTSIDE_MAP
	var/shelter_origin_y = deploy_location.y - round(height/2)
	if(shelter_origin_y <= 1 || shelter_origin_y+height > world.maxy)
		return SHELTER_DEPLOY_OUTSIDE_MAP

	return SHELTER_DEPLOY_ALLOWED


/datum/map_template/shelter/tree
	name = "living tree-house"
	id = "shelter_tree"
	description = "A magical yet homely shelter, with a distinct natural feel."
	mappath = "_maps/templates/shelter_tree.dmm"

/datum/map_template/shelter/tree/small
	name = "small living tree-house"
	id = "shelter_tree_small"
	description = "A magical yet homely shelter, with a distinct natural feel. You got a feeling this one won't be so big."
	mappath = "_maps/templates/shelter_tree_small.dmm"
