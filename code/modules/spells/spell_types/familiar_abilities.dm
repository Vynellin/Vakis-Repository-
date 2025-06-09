/obj/effect/proc_holder/spell/self/message/message_summoner
	name = "Message Summoner"
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/self/message/message_summoner/cast(list/targets, mob/user)
	. = ..()

	var/mob/living/simple_animal/pet/familiar/caster = src
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
	xp_gain = FALSE
	releasedrain = 30
	recharge_time = 1 SECONDS
	warnie = "spellwarning"
	spell_tier = 1
	associated_skill = /datum/skill/magic/arcane

/obj/effect/proc_holder/spell/self/stillness_of_stone/cast(list/targets, mob/living/simple_animal/pet/familiar/pondstone_toad/user)
	. = ..()
	if(user.stoneform) // Already stoned: revert to normal
		user.icon = user.original_icon
		user.icon_state = user.original_icon_state
		user.icon_living = user.original_icon_living
		user.name = user.original_name
		user.stoneform = FALSE
		to_chat(user, "<span class='notice'>You shift back into your natural form.</span>")
		update_icon()
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
		update_icon()

/mob/living/simple_animal/pet/familiar/pondstone_toad/Move()
	if(stoneform)
		return 0
	return ..()

/mob/living/simple_animal/pet/familiar/hollow_antlerling/Move()
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

	light_outer_range = 1 
	light_power = 0.3 
	light_color = rgb(255, 120, 255) 

/obj/effect/proc_holder/spell/self/scent_of_the_grave
	name = "Scent of the Grave"
	overlay_state = "null"
	recharge_time = 1 SECONDS
	warnie = "spellwarning"
	xp_gain = FALSE
	miracle = FALSE

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

	var/direction = get_dir(user.loc, choice.loc)

	to_chat(user, "The scent leads you [direction].")

/obj/effect/proc_holder/spell/invoked/blink/glimmer_hare
	invocation = "" //"Natural" abilty, no incantation.
	chargetime = 0

/obj/effect/proc_holder/spell/self/inscription_cache
	name = "Inscription Cache"

/obj/effect/proc_holder/spell/self/inscription_cache/cast(mob/living/simple_animal/pet/familiar/rune_rat/user)
	. = ..()
	var/obj/item/item = user.get_active_held_item()
	if(!item)
		to_chat(user, "<span class='notice'>You must be holding something to store.</span>")
		return
	if(!(istype(item, /obj/item/book) || istype(item, /obj/item/paper)))
		to_chat(user, "<span class='warning'>Only written materials can be stored.</span>")
		return
	if(length(user.stored_books) >= user.storage_limit)
		to_chat(user, "<span class='warning'>Your cache is full. Recall something first.</span>")
		return

	user.stored_books += item
	item.forceMove(null) // remove it from the world
	user.visible_message(span_notice("[user.name] vanishes [item.name] into a shimmer of runes."),span_notice("You vanish [item.name] into a shimmer of runes."))

/obj/effect/proc_holder/spell/self/recall_cache
	name = "Recall_cache"

/obj/effect/proc_holder/spell/self/recall_cache/cast(mob/living/simple_animal/pet/familiar/rune_rat/user)
	. = ..()
	if(!length(user.stored_books))
		to_chat(user, "<span class='notice'>Your cache is empty.</span>")
		return

	var/obj/item/input = input(user, "Select an item to retrieve:", "Recall Cache") as null|anything in user.stored_books
	if(input)
		input.forceMove(user.loc)
		user.stored_books -= input
		user.visible_message(span_notice("[input.name] shimmers into existence beside [user.name]"),span_notice("[input.name] shimmers into existence beside you."))

/obj/effect/proc_holder/spell/self/smolder_shroud
	name = "Smolder Shroud"
	recharge_time = 5 MINUTES
	chargetime = 0
	xp_gain = FALSE

/obj/effect/proc_holder/spell/self/smolder_shroud/cast(list/targets, mob/user)
	. = ..()
	var/datum/effect_system/smoke_spread/smoke = new /datum/effect_system/smoke_spread
	smoke.set_up(2, targets[1])
	smoke.start()
