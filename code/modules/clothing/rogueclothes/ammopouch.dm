/obj/item/ammopouch
	name = "bullet pouch"
	desc = ""
	icon_state = "pouch0"
	item_state = "pouch"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_HIP
	resistance_flags = NONE
	max_integrity = 0
	equip_sound = 'sound/blank.ogg'
	bloody_icon_state = "bodyblood"
	alternate_worn_layer = UNDER_CLOAK_LAYER
	strip_delay = 10
	var/max_storage = 20
	var/list/bullets = list()
	sewrepair = TRUE

/obj/item/ammopouch/attackby(obj/A, loc, params)
	if(istype(A, /obj/item/ammo_casing/caseless/rogue))
		if(bullets.len < max_storage)
			A.forceMove(src)
			bullets += A
			update_icon()
		else
			to_chat(loc, span_warning("Full!"))
		return
/*
	if(istype(A, /obj/item/gun/ballistic/revolver/grenadelauncher/matchlock))
		var/obj/item/gun/ballistic/revolver/grenadelauncher/matchlock/B = A
		if(bullets.len && !B.chambered)
			for(var/AR in bullets)
				if(istype(AR, /obj/item/ammo_casing/caseless/rogue/bullet))
					bullets -= AR
					B.attackby(AR, loc, params)
					break
		return
*/
	..()

/obj/item/ammopouch/attack_right(mob/user)
	if(bullets.len)
		var/obj/O = bullets[bullets.len]
		bullets -= O
		O.forceMove(user.loc)
		user.put_in_hands(O)
		update_icon()
		return TRUE

/obj/item/ammopouch/examine(mob/user)
	. = ..()
	if(bullets.len)
		. += span_notice("[bullets.len] inside.")

/obj/item/ammopouch/update_icon()
	if(bullets.len)
		icon_state = "pouch1"
	else
		icon_state = "pouch0"

// Experimental code from quivers to try to get scooping to work

/obj/item/ammopouch/bullets/Initialize()
	..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/rogue/bullet/A = new()
		bullets += A
	update_icon()

/obj/item/ammopouch/attack_turf(turf/T, mob/living/user)
	if(bullets.len >= max_storage)
		to_chat(user, span_warning("My [src.name] is full!"))
		return
	to_chat(user, span_notice("I begin to gather the ammunition..."))
	for(var/obj/item/ammo_casing/caseless/rogue/bullets in T.contents)
		if(do_after(user, 5))
			if(!eatarrow(bullets))
				break


/obj/item/ammopouch/proc/eatarrow(obj/A)
	if(A.type in subtypesof(/obj/item/ammo_casing/caseless/rogue))
		if(bullets.len < max_storage)
			A.forceMove(src)
			bullets += A
			update_icon()
			return TRUE
		else
			return FALSE

/obj/item/ammopouch/attack_self(mob/living/user)
	..()

	if (!bullets.len)
		return
	to_chat(user, span_warning("I begin to take out the shot from [src], one by one..."))
	for(var/obj/item/ammo_casing/caseless/rogue/bullets in bullets)
		if(!do_after(user, 0.5 SECONDS))
			return
		bullets.forceMove(user.loc)
		bullets -= bullets

	update_icon()
