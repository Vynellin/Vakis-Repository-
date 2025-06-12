#define MIRACLE_HEALING_FILTER "miracle_heal_glow"

/obj/effect/proc_holder/spell/self/message_summoner
	name = "Message Summoner"
	recharge_time = 1 SECONDS

/obj/effect/proc_holder/spell/self/message_summoner/cast(list/targets, mob/user)
	. = ..()

	var/mob/living/simple_animal/pet/familiar/caster = user
	var/mob/living/summoner = caster.familiar_summoner

	if(!isliving(summoner) || !summoner?.mind)
		revert_cast()
		to_chat(user, span_warning("You cannot sense your summoner's mind."))
		return FALSE

	var/message = input(user, "You make a connection. What are you trying to say?")
	if(!message)
		revert_cast()
		return FALSE
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
	if(user.stoneform)
		user.revert_from_stoneform()
	else
		// Save original state if not already saved
		if(!user.original_icon)
			user.original_icon = user.icon
			user.original_icon_state = user.icon_state
			user.original_icon_living = user.icon_living
			user.original_name = user.name

		user.icon = 'icons/roguetown/items/natural.dmi'
		user.icon_state = "stone1"
		user.icon_living = "stone1"
		user.name = "Stone"
		user.stoneform = TRUE

		user.visible_message(
			span_notice("[user] becomes utterly still, their body taking on the appearance of a stone."),
			span_notice("You become utterly still, blending into your surroundings like a stone.")
		)
		user.regenerate_icons()
	return TRUE

/mob/living/simple_animal/pet/familiar/pondstone_toad/proc/revert_from_stoneform()
	if(!stoneform)
		return

	icon = original_icon
	icon_state = original_icon_state
	icon_living = original_icon_living
	name = original_name
	stoneform = FALSE

	visible_message(
		span_notice("[src] shifts back into a more animated, toad-like form."),
		span_notice("You shift back into your natural form.")
	)
	regenerate_icons()

/mob/living/simple_animal/pet/familiar/pondstone_toad/Move()
	if(stoneform)
		return FALSE
	return ..()

/mob/living/simple_animal/pet/familiar/pondstone_toad/death()
	. = ..()
	if(stoneform)
		revert_from_stoneform()

/mob/living/simple_animal/pet/familiar/hollow_antlerling/Exited(atom/movable/AM, atom/newLoc)
	. = ..()
	if (prob(60) && isturf(src.loc))
		var/obj/item/glow_petal/petal = new /obj/item/glow_petal(src.loc)
		spawn(rand(50, 60))
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

/obj/effect/proc_holder/spell/self/scent_of_the_grave/cast(list/targets, mob/living/simple_animal/pet/familiar/gravemoss_serpent/user)
	. = ..()

	user.visible_message(
		span_notice("[user] lifts its head, tongue flickering as it tastes the air..."),
		span_notice("You raise your head, tasting the air for the scent of the dead.")
	)

	var/list/trackable = list()
	for (var/mob/living/corpse in GLOB.dead_mob_list)
		if(get_dist(corpse, user) < 30)
			trackable += corpse

	if(!trackable.len)
		to_chat(user,span_notice("You detect no nearby corpses."))
		return

	var/obj/item/choice = input(user, "Select a corpse to track", "Nearby corpses") as null|anything in trackable
	if(!choice)
		return

	var/direction_text = dir2text(get_dir(user.loc, choice.loc))

	user.visible_message(
		span_warning("[user]'s eyes narrows."),
		span_notice("The scent of the grave draws you to the [direction_text].")
	)

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

/obj/effect/proc_holder/spell/self/starseers_cry
	name = "Starseer's Cry"
	desc = "Let out a piercing celestial call that disrupts all veils of shadow within sight."
	recharge_time = 30 SECONDS

/obj/effect/proc_holder/spell/self/starseers_cry/cast(list/targets, mob/living/simple_animal/pet/familiar/starfield_crow/user)
	. = ..()
	user.visible_message(span_danger("[user] lets out a soul-piercing cry, the stars shimmering in their eyes!"))

	for (var/mob/living/M in range(7, user))
		if (M == user)
			continue

		var/invis_active = M.mob_timers[MT_INVISIBILITY] > world.time
		var/sneaking = M.m_intent == MOVE_INTENT_SNEAK

		if (invis_active || sneaking)
			if (invis_active)
				M.mob_timers[MT_INVISIBILITY] = world.time
				M.invis_broken_early = TRUE // Prevent future fade-back message
				M.update_sneak_invis()
			if (sneaking)
				M.mob_timers[MT_FOUNDSNEAK] = world.time

			M.visible_message(span_danger("[M] is revealed by a cosmic pulse!"), span_notice("You feel your concealment burn away."))
			found_ping(get_turf(M), user.client, "hidden")

	return TRUE


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

/obj/effect/proc_holder/spell/self/phantasm_fade/cast(list/targets, mob/living/simple_animal/pet/familiar/whisper_stoat/user)
	. = ..()
	user.visible_message(span_warning("[user.name] starts to fade into thin air!"), span_notice("You start to become invisible!"))
	animate(user, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
	user.mob_timers[MT_INVISIBILITY] = world.time + 15 SECONDS
	addtimer(CALLBACK(user, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 15 SECONDS)
	addtimer(CALLBACK(user, TYPE_PROC_REF(/atom/movable, visible_message), span_warning("[user.name] fades back into view."), span_notice("You become visible again.")), 15 SECONDS)
	return TRUE

/obj/effect/proc_holder/spell/self/phantom_flicker
	name= "Phantom Flicker"
	recharge_time = 2 MINUTES

/obj/effect/proc_holder/spell/self/phantom_flicker/cast(list/targets, mob/living/simple_animal/pet/familiar/ripplefox/user)
	. = ..()

	var/mob/living/simple_animal/pet/familiar/ripplefox/fam = new user.type(user.loc)
	user.visible_message(span_notice("[user.name] blurs and darts away in two directions at once!"))

	fam.familiar_summoner = user
	fam.fully_replace_character_name(null, user.name)

	// Find a random open turf in view range
	var/list/valid_turfs = list()
	for (var/turf/potential_turf in range(7, user))
		if (potential_turf && fam.CanPass(potential_turf))
			valid_turfs += potential_turf

	if (valid_turfs.len)
		var/turf/target_turf = pick(valid_turfs)
		walk_to(fam, target_turf, 0)

	// Schedule deletion safely with global context
	addtimer(CALLBACK(GLOBAL_PROC, /proc/delete_illusory_fam, fam, user), 200)

	return TRUE

/proc/delete_illusory_fam(var/mob/living/simple_animal/pet/familiar/ripplefox/fam, var/mob/user)
	if(fam && !QDELETED(fam))
		user.visible_message(span_notice("[fam.name] flickers and vanishes into nothingness."))
		qdel(fam)

/obj/effect/proc_holder/spell/self/lurking_step
	name = "Lurking Step"
	desc = "Mark this location with a name, binding it to your hidden trail."
	recharge_time = 10 SECONDS

/obj/effect/proc_holder/spell/self/lurking_step/cast(list/targets, mob/living/simple_animal/pet/familiar/mist_lynx/user)
	. = ..()
	if (!user.saved_trails)
		user.saved_trails = list()

	var/spot_name = input(user, "Name this location for future return:", "Mark Trail") as text|null
	if (!spot_name)
		return FALSE

	// Limit to 3 entries
	if (user.saved_trails.len >= 3)
		user.saved_trails.Cut(1, 2)

	user.saved_trails += list(list("name" = spot_name, "loc" = user.loc))

	to_chat(user, span_notice("You still yourself. The place is etched into your hidden path."))
	return TRUE

/obj/effect/proc_holder/spell/invoked/veilbound_shift
	name = "Veilbound Shift"
	desc = "Vanish and reappear at a hidden trail you've marked before."
	chargetime = 20 // longer cast time to balance teleporting
	recharge_time = 1 MINUTES

/obj/effect/proc_holder/spell/invoked/veilbound_shift/cast(list/targets, mob/living/simple_animal/pet/familiar/mist_lynx/user)
	. = ..()
	if (!user.saved_trails || !user.saved_trails.len)
		to_chat(user, span_warning("You have no marked paths to return to."))
		return FALSE

	var/list/names = list()
	for (var/entry in user.saved_trails)
		names += entry["name"]

	var/choice = input(user, "Choose a hidden trail to return to:", "Veilbound Shift") as null|anything in names
	if (!choice)
		return FALSE

	var/target_loc
	for (var/entry in user.saved_trails)
		if (entry["name"] == choice)
			target_loc = entry["loc"]
			break

	if (!(isturf(target_loc) || isopenturf(target_loc)))
		to_chat(user, span_warning("The path has faded..."))
		return

	user.visible_message(span_emote("[user] blurs at the edges, dissolving like mist."))

	spawn(20) // short delay before teleport
		do_teleport(user, target_loc, forceMove = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
		user.visible_message(span_emote("A ripple in the air resolves into fur and paw. [user.name] pads silently into view."))

	return TRUE

/obj/effect/proc_holder/spell/self/verdant_veil
	name = "Verdant Veil"
	desc = "Shrouds nearby allies in illusionary invisibility, broken if they move or act."
	recharge_time = 30 SECONDS

/obj/effect/proc_holder/spell/self/verdant_veil/cast(list/targets, mob/living/simple_animal/pet/familiar/hollow_antlerling/user)
	. = ..()
	to_chat(user, span_notice("You exhale a shimmering cloud of forest illusion..."))
	user.visible_message(span_warning("[user] releases a swirl of glowing leaves!"), span_notice("You feel the forest's stillness wrap around you."))

	for (var/mob/living/M in range(1, user))
		if (M == user || isobserver(M))
			continue

		if (M.anti_magic_check(TRUE, TRUE))
			continue

		M.visible_message(span_warning("[M] starts to fade into thin air!"), span_notice("You start to become invisible!"))
		animate(M, alpha = 0, time = 1 SECONDS, easing = EASE_IN)

		M.mob_timers[MT_INVISIBILITY] = world.time + 2 MINUTES
		M.invis_broken_early = FALSE

		// Apply invis and visual feedback
		M.update_sneak_invis()

		// Register movement signal to break stealth
		RegisterSignal(M, COMSIG_MOVABLE_MOVED, /mob/living/proc/on_veil_movement)

		// Schedule end of duration
		addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living, fade_back_message)), 2 MINUTES)
		addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living, update_sneak_invis), TRUE), 2 MINUTES)

	return TRUE

/mob/living/proc/on_veil_movement(atom/source, dir)
	if (!src || QDELETED(src))
		return

	// Already broken or expired?
	if (src.invis_broken_early || world.time > src.mob_timers[MT_INVISIBILITY])
		return

	src.invis_broken_early = TRUE
	src.visible_message(span_warning("[src] shimmers and becomes visible!"), span_notice("You break the illusion and become visible."))
	animate(src, alpha = 255, time = 0.5 SECONDS, easing = EASE_OUT)
	src.alpha = 255
	src.mob_timers[MT_INVISIBILITY] = world.time

	src.update_sneak_invis()

	// Cleanup signal
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED, /mob/living/proc/on_veil_movement)

/mob/living/proc/fade_back_message()
	if (!src || QDELETED(src))
		return

	// Stop tracking movement
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED, /mob/living/proc/on_veil_movement)

	if (src.invis_broken_early)
		return // Already became visible via movement

	src.visible_message(span_warning("[src] fades back into view."), span_notice("You become visible again."))
