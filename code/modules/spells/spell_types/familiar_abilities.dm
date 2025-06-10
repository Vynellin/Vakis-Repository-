#define MIRACLE_HEALING_FILTER "miracle_heal_glow"

/obj/effect/proc_holder/spell/self/message_summoner
	name = "Message Summoner"
	recharge_time = 1 SECONDS

/obj/effect/proc_holder/spell/self/message_summoner/cast(list/targets, mob/user)
	. = ..()

	var/mob/living/simple_animal/pet/familiar/caster = user
	var/mob/living/summoner = caster.familiar_summoner

	if(!isliving(summoner))
		revert_cast()
		to_chat(summoner, "You cannot sense your summoner's mind.")
		return
	if(!summoner.mind)
		revert_cast()
		to_chat(summoner, "You cannot sense your summoner's mind.")
		return
	var/message = input(user, "You make a connection. What are you trying to say?")
	if(!message)
		revert_cast()
		return
	to_chat_immediate(summoner, "Arcane whispers fill the back of my head, resolving into [user]'s voice: <font color=#7246ff>[message]</font>")
	user.visible_message("[user] mutters an incantation and their mouth briefly flashes white.")
	user.whisper(message)
	log_game("[key_name(user)] sent a message to [key_name(summoner)] with contents [message]")
	return TRUE

/obj/effect/proc_holder/spell/self/stillness_of_stone
	name = "Stillness of Stone"
	recharge_time = 1 SECONDS

/obj/effect/proc_holder/spell/self/stillness_of_stone/cast(list/targets, mob/living/simple_animal/pet/familiar/pondstone_toad/user)
	. = ..()
	if(user.stoneform) // Already stoned: revert to normal
		user.icon = user.original_icon
		user.icon_state = user.original_icon_state
		user.icon_living = user.original_icon_living
		user.name = user.original_name
		user.stoneform = FALSE
		to_chat(user, "<span class='notice'>You shift back into your natural form.</span>")
		user.regenerate_icons()
	else
		// Save original state
		user.original_icon = user.icon
		user.original_icon_state = user.icon_state
		user.original_icon_living = user.icon_living
		user.original_name = user.name
		// Transform to stone
		user.icon = 'icons/roguetown/items/natural.dmi'
		user.icon_state = "stone1"
		user.icon_living = "stone1"
		user.name = "Stone"
		user.stoneform = TRUE
		to_chat(user, "<span class='notice'>You become utterly still, blending into your surroundings like a stone.</span>")
		user.regenerate_icons()
	return TRUE

/mob/living/simple_animal/pet/familiar/pondstone_toad/Move()
	if(stoneform)
		return 0
	return ..()

//Dying in stone form would cause weird issues.
/mob/living/simple_animal/pet/familiar/pondstone_toad/death()
	. = ..()
	if(src.stoneform) // Already stoned: revert to normal
		src.icon = src.original_icon
		src.icon_state = src.original_icon_state
		src.icon_living = src.original_icon_living
		src.name = src.original_name
		src.stoneform = FALSE
		to_chat(src, "<span class='notice'>You shift back into your natural form.</span>")
		src.regenerate_icons()

/mob/living/simple_animal/pet/familiar/hollow_antlerling/Moved()
	. = ..()
	// 60% chance to leave a glowing petal trail
	if(prob(60) && isturf(loc))
		var/turf/turf = loc
		// Create the petal overlay
		var/obj/effect/overlay/petal = new /obj/item/glow_petal(turf)
		// Delete it after 5 to 6 seconds
		spawn(rand(50, 60)) // 5 to 6 seconds
			qdel(petal)

/obj/item/glow_petal
	name = "Faint Petals"
	icon = 'icons/roguetown/mob/familiars.dmi'
	icon_state = "leaf_trail"
	anchored = TRUE
	mouse_opacity = 0

	light_outer_range = 2 
	light_power = 1 
	light_color = rgb(255, 120, 255) 
	light_on = TRUE

/obj/effect/proc_holder/spell/self/scent_of_the_grave
	name = "Scent of the Grave"
	recharge_time = 1 SECONDS

/obj/effect/proc_holder/spell/self/scent_of_the_grave/cast(list/targets, mob/living/simple_animal/pet/familiar/pondstone_toad/user)
	. = ..()
	var/list/trackable = list()
	for (var/corpse in GLOB.dead_mob_list)
		if(get_dist(corpse, user) < 30)
			trackable += corpse

	if(!trackable || !trackable.len)
		to_chat(user, "No trackable corpses nearby.")
		return

	var/obj/item/choice = input(user, "Select a corpse to track", "Nearby corpses") as null|anything in trackable
	if(choice == null)
		return

	var/direction_text = dir2text(get_dir(user.loc, choice.loc))
	to_chat(user, "The scent leads you [direction_text].")


/obj/effect/proc_holder/spell/invoked/blink/glimmer_hare
	invocation = "" //"Natural" abilty, no incantation.
	chargetime = 0

/obj/effect/proc_holder/spell/self/inscription_cache
	name = "Inscription Cache"
	recharge_time = 5 SECONDS

/obj/effect/proc_holder/spell/self/inscription_cache/cast(mob/living/simple_animal/pet/familiar/rune_rat/user)
	. = ..()
	var/obj/item/item = user.get_active_held_item()
	if(!item)
		to_chat(user, "<span class='notice'>You must be holding something to store.</span>")
		return TRUE
	if(!(istype(item, /obj/item/book) || istype(item, /obj/item/paper)))
		to_chat(user, "<span class='warning'>Only written materials can be stored.</span>")
		revert_cast()
		return FALSE
	if(length(user.stored_books) >= user.storage_limit)
		to_chat(user, "<span class='warning'>Your cache is full. Recall something first.</span>")
		revert_cast()
		return FALSE

	user.stored_books += item
	item.forceMove(user) // remove it from the world
	user.visible_message(span_notice("[user.name] vanishes [item.name] into a shimmer of runes."),span_notice("You vanish [item.name] into a shimmer of runes."))

/obj/effect/proc_holder/spell/self/recall_cache
	name = "Recall cache"
	recharge_time = 5 SECONDS

/obj/effect/proc_holder/spell/self/recall_cache/cast(mob/living/simple_animal/pet/familiar/rune_rat/user)
	. = ..()
	if(!length(user.stored_books))
		to_chat(user, "<span class='notice'>Your cache is empty.</span>")
		revert_cast()
		return FALSE

	var/obj/item/input = input(user, "Select an item to retrieve:", "Recall Cache") as null|anything in user.stored_books
	if(input)
		input.forceMove(user.loc)
		user.stored_books -= input
		user.visible_message(span_notice("[input.name] shimmers into existence beside [user.name]"),span_notice("[input.name] shimmers into existence beside you."))
		return TRUE

/mob/living/simple_animal/pet/familiar/rune_rat/death()
	. = ..()
	for (var/obj/item in src.stored_books)
		item.forceMove(src.loc)

/obj/effect/proc_holder/spell/self/smolder_shroud
	name = "Smolder Shroud"
	recharge_time = 5 MINUTES
	chargetime = 0

/obj/effect/proc_holder/spell/self/smolder_shroud/cast(list/targets, mob/user)
	. = ..()
	var/datum/effect_system/smoke_spread/smoke = new /datum/effect_system/smoke_spread
	smoke.set_up(2, user)
	smoke.start()

/obj/effect/proc_holder/spell/self/soothing_bloom
	name = "Soothing Bloom"
	recharge_time = 16 SECONDS

/obj/effect/proc_holder/spell/self/soothing_bloom/cast(list/targets, mob/living/simple_animal/pet/familiar/vaporroot_wisp/user)
	. = ..()

	user.visible_message(span_notice("[user.name] releases a soothing vapor"),span_notice("You releases a soothing vapor"))
	for (var/mob/living/vaper in view(5, user))
		if(vaper == user || isdead(vaper))
			continue
		vaper.apply_status_effect(/datum/status_effect/regen/soothing_bloom)
		to_chat(vaper, "<span class='notice'>A cool mist settles on your skin, and you feel your wounds slowly close.</span>")
	return TRUE

/datum/status_effect/regen/soothing_bloom
	id = "soothing_bloom"
	tick_interval = 40 //This should give it two ticks of 1 healing per person in the radius.
	duration = 8 SECONDS
	var/healing_on_tick = 1
	var/outline_colour = "#129160"

/atom/movable/screen/alert/status_effect/regen/soothing_bloom
	name = "Soothing Bloom"
	desc = "You are gently regenerating health over time."

/datum/status_effect/regen/soothing_bloom/on_apply()
	var/filter = owner.get_filter(MIRACLE_HEALING_FILTER)
	if (!filter)
		owner.add_filter(MIRACLE_HEALING_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 60, "size" = 1))
	return TRUE

/datum/status_effect/regen/soothing_bloom/tick()
	var/obj/effect/temp_visual/heal/heal = new /obj/effect/temp_visual/heal_rogue(get_turf(owner))
	heal.color = "#129160"
	var/list/wCount = owner.get_wounds()
	if(!owner.construct)
		if(owner.blood_volume < BLOOD_VOLUME_NORMAL)
			owner.blood_volume = min(owner.blood_volume+2, BLOOD_VOLUME_NORMAL) //Reduced blood replenishment compared to cleric miracle.
		if(wCount.len > 0)
			owner.heal_wounds(healing_on_tick)
			owner.update_damage_overlays()
		owner.adjustBruteLoss(-healing_on_tick, 0)
		owner.adjustFireLoss(-healing_on_tick, 0)
		owner.adjustOxyLoss(-healing_on_tick, 0)
		owner.adjustToxLoss(-healing_on_tick, 0)
		owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, -healing_on_tick)
		owner.adjustCloneLoss(-healing_on_tick, 0)

/obj/effect/proc_holder/spell/self/celestial_illumination
	name= "Celestial Illumination"
	recharge_time = 1 SECONDS

/obj/effect/proc_holder/spell/self/celestial_illumination/cast(list/targets, mob/living/simple_animal/pet/familiar/starfield_crow/user)
	. = ..()
	if(user.light_on)
		user.light_on = FALSE
		user.update_light
	else
		user.light_on = TRUE
		user.update_light

/obj/effect/proc_holder/spell/invoked/pyroclastic_puff
	name = "Pyroclastic_puff"
	recharge_time = 1 SECONDS
	sound = list('sound/magic/whiteflame.ogg')

/obj/effect/proc_holder/spell/invoked/pyroclastic_puff/cast(list/targets, mob/user)
	. = ..()
	if (isturf(targets[1]))
		var/turf/front = get_step(user, user.dir)
		var/datum/effect_system/spark_spread/spread = new()
		user.flash_fullscreen("whiteflash")
		flick("flintstrike", src)
		spread.set_up(1, 1, front)
		spread.start()
		user.visible_message(span_notice("[user.name] exhales a flurry of glowing sparks!"), span_notice("You breathe out a tiny burst of emberlight."))
		return TRUE
	else
		var/atom/target = targets[1]
		if (user.Adjacent(target))
			user.flash_fullscreen("whiteflash")
			flick("flintstrike", src)
			target.spark_act()
			user.visible_message(span_notice("[user.name] exhales a directed spark toward [target]!"), span_notice("You release a pinpoint ember toward [target]."))
			return TRUE
		else
			to_chat(user, span_warning("You're too far to spark that."))
			revert_cast()
			return FALSE

/obj/effect/proc_holder/spell/self/verdant_sprout
	name = "Verdant Sprout"
	recharge_time = 1 MINUTES

/obj/effect/proc_holder/spell/self/verdant_sprout/cast(list/targets, mob/user)
	. = ..()
	var/turf/target = get_step(user, user.dir)

	if(!isturf(target))
		to_chat(user, span_warning("You cannot grow plants on this."))
		revert_cast()
		return FALSE

	// Turn dirt to grass
	if(istype(target, /turf/open/floor/rogue/dirt))
		target.ChangeTurf(/turf/open/floor/rogue/grass)
		user.visible_message(span_notice("Vines creep forward in front of [user.name], coaxing new grass from the soil."), span_notice("Vines creep forward in front of you, coaxing new grass from the soil."))
		return TRUE

	// Add bush to existing grass tile if empty
	if(istype(target, /turf/open/floor/rogue/grass))
		var/has_structures = FALSE
		for(var/obj/structure/S in target)
			has_structures = TRUE
			break

		if(!has_structures)
			new /obj/structure/flora/roguegrass/bush(target)
			to_chat(user, span_notice("A small thicket of roguegrass rises gently from the turf."))
			return TRUE
		else
			to_chat(user, span_warning("That spot is already occupied."))
			return FALSE

	to_chat(user, span_warning("Nothing happens."))
	return FALSE

/obj/effect/proc_holder/spell/self/phantasm_fade
	name= "Phantasm Fade"
	recharge_time = 2 MINUTES

/obj/effect/proc_holder/spell/self/phantasm_fade/cast(list/targets, mob/user)
	. = ..()
	user.visible_message(span_warning("[user] starts to fade into thin air!"), span_notice("You start to become invisible!"))
	animate(user, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
	user.mob_timers[MT_INVISIBILITY] = world.time + 15 SECONDS
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 15 SECONDS)
	addtimer(CALLBACK(user, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[user] fades back into view."), span_notice("You become visible again.")), 15 SECONDS)

/obj/effect/proc_holder/spell/self/phantom_flicker/cast(list/targets, mob/living/simple_animal/pet/familiar/ripplefox/user)
	. = ..()
	var/mob/living/simple_animal/pet/familiar/ripplefox/fam = new user.type(user.loc)
	fam.familiar_summoner = user
	fam.fully_replace_character_name(null, user.name)
	spawn(10 SECONDS)
		if(!QDELETED(fam))
			qdel(fam)
	return TRUE

#undef MIRACLE_HEALING_FILTER
