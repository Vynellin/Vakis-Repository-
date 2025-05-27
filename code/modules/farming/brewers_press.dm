/obj/structure/brewers_press
	name = "brewer's press"
	desc = "A press used to extract juice from fruit, or to press hops into a cake."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "brewerspress"
	density = TRUE
	opacity = FALSE
	anchored = TRUE
	max_integrity = 300

/obj/structure/brewers_press/Initialize()
	// Bluespace beakers, but without the portability or efficiency in circuits.
	create_reagents(900, DRAINABLE | AMOUNT_VISIBLE | REFILLABLE)
	AddComponent(/datum/component/storage/concrete/roguetown/bin)
	. = ..()

/obj/structure/brewers_press/examine(mob/user)
	. = ..()

/obj/structure/brewers_press/Destroy()
	chem_splash(loc, 2, list(reagents))
	qdel(reagents)
	..()

/obj/structure/brewers_press/attackby(obj/item/I, mob/user, params)
	if(istype(I,/obj/item/storage/roguebag) && I.contents.len)
		var/datum/component/storage/STR = GetComponent(/datum/component/storage)
		for(var/obj/item/reagent_containers/food/snacks/grown/bagged_fruit in I.contents)
			//If you can press it, transfer the fruit from the bag to the press' storage
			if(bagged_fruit.can_press)
				STR.remove_from_storage(bagged_fruit, get_turf(user))
				if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, bagged_fruit, null, TRUE, TRUE))
					bagged_fruit.inventory_flip(null, TRUE)
					if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, bagged_fruit, null, TRUE, TRUE))
						qdel(bagged_fruit)
			else
				to_chat(user, span_warning("I can't press [bagged_fruit] in [src]."))
				return FALSE
		to_chat(user, span_info("I dump the contents of [I] into [src]."))
		I.update_icon()	
		return TRUE
	if(user.used_intent)
		if(user.used_intent.type in list(/datum/intent/fill,/datum/intent/pour,/datum/intent/splash))
			return I.attack_obj(src, user) // Allow pouring reagents into the press.

	if(!istype(I,/obj/item/reagent_containers/food/snacks/grown))
		return FALSE
	..()

/obj/structure/brewers_press/attack_right(mob/user)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		//to_chat(user, span_notice("Currently has: [things.len] items."))
		var/turf/original_loc = get_turf(user)
		for(var/obj/item/I in things)
			if(get_turf(user) != original_loc)
				return TRUE // If the player moved, stop showing contents.
			try_press(I, user)

/obj/structure/brewers_press/attack_hand(mob/user)
	var/datum/component/storage/CP = GetComponent(/datum/component/storage)
	if(CP)
		CP.rmb_show(user)
		return TRUE

/obj/structure/brewers_press/proc/makeJuice(obj/item/reagent_containers/food/snacks/grown/fruit)
	if(fruit.reagents)
		fruit.reagents.remove_reagent(/datum/reagent/consumable/nutriment, fruit.reagents.total_volume)
		fruit.reagents.remove_reagent(/datum/reagent/water, fruit.reagents.total_volume)
		fruit.reagents.remove_reagent(/datum/reagent/floure, fruit.reagents.total_volume)
		fruit.reagents.trans_to(src, fruit.reagents.total_volume)
	if(fruit.press_reagent)
		reagents.add_reagent(fruit.press_reagent, fruit.press_amt)
	qdel(fruit)
	playsound(src, "bubbles", 100, TRUE)
	return TRUE

/obj/structure/brewers_press/proc/try_press(obj/item/reagent_containers/food/snacks/grown/fruit, mob/living/user)
	to_chat(user, span_notice("I press [fruit] in [src]."))
	if(do_after(user, 3 SECONDS, target = src))
		add_sleep_experience(user, /datum/skill/craft/cooking, user.STAINT)
		makeJuice(fruit)
		//to_chat(user, span_notice("I extract juice from [fruit]."))
	return TRUE
