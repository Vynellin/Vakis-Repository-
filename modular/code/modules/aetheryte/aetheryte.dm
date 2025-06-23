/obj/structure/roguemachine/teleport_beacon
	name = "\improper Kasmidian beacon"
	desc = "A horrid stench rises from the hole, perhaps the visible bile residue is the cause?"
	icon = 'modular/code/modules/aetheryte/aetheryte.dmi'
	icon_state = "aetheryte_town"
	anchored = TRUE
	density = TRUE
	pixel_x = -19
	var/list/granted_list = list()
	var/custom_name

/obj/structure/roguemachine/teleport_beacon/Initialize()
	. = ..()
	name = custom_name ? "[custom_name] Kasmidian beacon" : "[get_area(get_turf(src))] Kasmidian beacon"
	SSroguemachine.teleport_beacons += src

/obj/structure/roguemachine/teleport_beacon/attack_hand(mob/living/user)
	. = ..()
	var/list/permitted_beacons = list()

	if(!ishuman(user))
		return

	if(!(user.real_name in src.granted_list))
		to_chat(user, span_notice("You imprint your name in the crystal's surface or someshit idunno."))
		src.granted_list += user.real_name
		return

	for(var/obj/structure/roguemachine/teleport_beacon/beacon_choice in SSroguemachine.teleport_beacons)
		if(user.real_name in beacon_choice.granted_list)
			permitted_beacons += beacon_choice

	var/teleport_choice = input(user, "Which imprinted beacon would you travel to?", "Teleport Beacon Choice") as null|anything in permitted_beacons

	if(!teleport_choice || teleport_choice == src)
		return

	if(!do_after(user, 10 SECONDS, target = src))
		to_chat(user, span_notice("You decide against going through [src]."))
		return

	user.forceMove(get_teleport_turf(get_turf(teleport_choice),3))

/obj/structure/roguemachine/teleport_beacon/Destroy(force)
	SSroguemachine.teleport_beacons -= src
	return ..()
