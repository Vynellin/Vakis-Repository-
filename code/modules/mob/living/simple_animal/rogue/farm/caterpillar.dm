
/mob/living/simple_animal/hostile/retaliate/rogue/mothcat
	icon = 'icons/roguetown/mob/monster/caterpillar.dmi'
	name = "\improper cat'erpillar"
	desc = ""
	icon_state = "chicken"
	icon_living = "chicken"
	icon_dead = "chicken_dead"

	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	emote_hear = list("meows.")
	emote_see = list("pecks at the ground.","flaps its wings viciously.")
	density = FALSE
	base_intents = list(/datum/intent/simple/claw)
	speak_chance = 2
	turns_per_move = 5
	faction = list("chickens")
	butcher_results = list(
		/obj/item/reagent_containers/food/snacks/fat = 1, 
		/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1, 
		/obj/item/natural/bone = 2, 
		/obj/item/alch/sinew = 1, 
		/obj/item/alch/bone = 1, 
		/obj/item/alch/viscera = 1,
		)
	var/egg_type = /obj/item/reagent_containers/food/snacks/egg/mothcat
	food_type = list(
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue,
		/obj/item/natural/worms,
		/obj/item/natural/fibers,
		/obj/item/natural/bundle/fibers,
	)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	melee_damage_lower = 1
	melee_damage_upper = 8
	pooptype = /obj/item/natural/poo/horse
	health = 15
	maxHealth = 15
	ventcrawler = VENTCRAWLER_ALWAYS
	var/eggsFertile = TRUE
	var/body_color
	var/icon_prefix = "chicken"
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	var/list/layMessage = EGG_LAYING_MESSAGES
	var/list/validColors = list("brown","black","white")
	var/static/mothcat_count = 0
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	STACON = 6
	STASTR = 6
	STASPD = 1
	tame = TRUE

/mob/living/simple_animal/hostile/retaliate/rogue/mothcat/get_sound(input)
	switch(input)
		if("pain")
			return 'sound/vo/mobs/cat/trill.ogg'
		if("death")
			return 'sound/vo/mobs/chikn/death.ogg'
		if("idle")
			return pick('sound/vo/mobs/cat/cat_meow1.ogg','sound/vo/mobs/cat/cat_meow2.ogg','sound/vo/mobs/cat/cat_meow3.ogg','sound/vo/mobs/cat/cat_purr1.ogg','sound/vo/mobs/cat/cat_purr2.ogg','sound/vo/mobs/cat/cat_purr3.ogg','sound/vo/mobs/cat/cat_purr4.ogg')


/mob/living/simple_animal/hostile/retaliate/rogue/mothcat/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "head"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "head"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "wing"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "wing"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "wing"
		if(BODY_ZONE_L_ARM)
			return "wing"
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/mothcat/Initialize()
	. = ..()
	++mothcat_count

/mob/living/simple_animal/hostile/retaliate/rogue/mothcat/Destroy()
	--mothcat_count
	return ..()

/mob/living/simple_animal/hostile/retaliate/rogue/mothcat/Life()
	..()
	if(!stat && (production > 29) && egg_type && isturf(loc) && !enemies.len)
		testing("laying egg with [production] production")
		if(locate(/obj/structure/fluff/nest) in loc)
			visible_message(span_alertalien("[src] [pick(layMessage)]"))
			production = max(production - 30, 0)
			var/obj/item/reagent_containers/food/snacks/egg/E = new egg_type(get_turf(src))
			E.pixel_x = rand(-6,6)
			E.pixel_y = rand(-6,6)
			if(eggsFertile)
				if(mothcat_count < MAX_CHICKENS && prob(50))
					E.fertile = TRUE
		else if(!stop_automated_movement)
			//look for nests
			var/list/foundnests = list()
			for(var/obj/structure/fluff/nest/N in oview(src))
				foundnests += N
			//if no nests, look for chaff and build one
			if(!foundnests.len)
				//look for chaff in our loc first, build nest
				var/obj/item/CH = locate(/obj/item/natural/fibers) in loc
				if(CH)
					qdel(CH)
					new /obj/structure/fluff/nest(loc)
					visible_message(span_notice("[src] builds a nest."))
				else
					CH = locate(/obj/item/grown/log/tree/stick) in loc
					if(CH)
						qdel(CH)
						new /obj/structure/fluff/nest(loc)
						visible_message(span_notice("[src] builds a nest."))
				//if cant find, look for chaff in view and move to it
				var/list/foundchaff = list()
				for(var/obj/item/natural/fibers/C in oview(src))
					foundchaff += C
				if(!foundchaff.len)
					for(var/obj/item/grown/log/tree/stick/S in oview(src))
						foundchaff += S
				if(foundchaff.len)
					stop_automated_movement = TRUE
					Goto(pick(foundchaff),move_to_delay)
					addtimer(CALLBACK(src, PROC_REF(return_action)), 15 SECONDS)
			else
				stop_automated_movement = TRUE
				Goto(pick(foundnests),move_to_delay)
				addtimer(CALLBACK(src, PROC_REF(return_action)), 15 SECONDS)

/obj/item/reagent_containers/food/snacks/egg/mothcat
	mob_type = /mob/living/simple_animal/hostile/retaliate/rogue/caterpillar

/obj/structure/fluff/nest
	name = "nest"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "nest"
	density = FALSE
	anchored = TRUE
	can_buckle = 1
	layer = 2.8
	max_integrity = 40
	static_debris = list(/obj/item/natural/fibers = 1)
