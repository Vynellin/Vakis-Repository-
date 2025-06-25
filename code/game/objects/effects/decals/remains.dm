/obj/effect/decal/remains
	name = "remains"
	gender = PLURAL
	icon = 'icons/effects/blood.dmi'

/obj/effect/decal/remains/human
	desc = ""
	icon_state = "remains"
	var/harvestable_bones = list(/obj/item/natural/bone = 3, /obj/item/skull = 1)
/obj/effect/decal/remains/human/attack_hand(mob/living/user)
	. = ..()
	user.visible_message(span_warning("[user] begins sorting through [src]."), span_warning("You begin sorting through [src]."))
	if(do_after(user, 5 SECONDS, needhand = TRUE, target = src))
		playsound(src, 'sound/foley/equip/rummaging-02.ogg', 100, FALSE)
		var/atom/L = drop_location()
		for(var/item in harvestable_bones)
			for(var/num in 1 to harvestable_bones[item])
				new item(L)
		user.visible_message(span_warning("[user] sorts through [src]."), span_warning("You sort through [src]."))
		qdel(src)
/obj/effect/decal/remains/plasma
	icon_state = "remainsplasma"

/obj/effect/decal/remains/xeno
	desc = ""
	icon_state = "remainsxeno"

/obj/effect/decal/remains/xeno/larva
	icon_state = "remainslarva"

/obj/effect/decal/cleanable/robot_debris/old
	name = "dusty robot debris"
	desc = ""
