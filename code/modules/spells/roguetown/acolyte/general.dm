// Lesser miracle
/obj/effect/proc_holder/spell/invoked/lesser_heal
	name = "Miracle"
	overlay_state = "lesserheal"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/magic/heal.ogg'
	invocation_type = "emote"
	invocation = span_warning("%user% casts Miracle!")
	invocation_emote_self = span_warning("I cast Miracle!")
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 10 SECONDS
	miracle = TRUE
	devotion_cost = 10

/obj/effect/proc_holder/spell/invoked/lesser_heal/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(user.patron?.undead_hater && (target.mob_biotypes & MOB_UNDEAD)) //positive energy harms the undead
			target.visible_message(span_danger("[target] is burned by holy light!"), span_userdanger("I'm burned by holy light!"))
			target.adjustFireLoss(10)
			target.fire_act(1,10)
			return TRUE
		var/conditional_buff = FALSE
		var/situational_bonus = 1
		var/message_out
		var/message_self
		//this if chain is stupid, replace with variables on /datum/patron when possible?
		switch(user.patron.type)
			if(/datum/patron/lording_three/aeternus)
				message_out = span_info("A wreath of gentle light passes over [target]!")
				message_self = ("I'm bathed in holy light!")
				// during the day, heal 1 more (basic as fuck)
				if (GLOB.tod == "day")
					conditional_buff = TRUE
					situational_bonus = 2
				// While day and night share timings, most antagonists and those 'uncouth' operate at night -- thusly religious healing should wane at the hour.
			if(/datum/patron/lording_three/zira)
				message_out = span_info("A shroud of soft moonlight falls upon [target]!")
				message_self = span_notice("I'm shrouded in gentle moonlight!")
				// during the night, heal 1 more (i wish this was more interesting but they're twins so whatever)
				if (GLOB.tod == "night")
					conditional_buff = TRUE
			if(/datum/patron/three_sisters/tamari)
				message_out = span_info("A rush of primal energy spirals about [target]!")
				message_self = span_notice("I'm infused with primal energies!")
				var/list/natural_stuff = list(/obj/structure/flora/roguegrass, /obj/structure/flora/roguetree, /obj/structure/flora/rogueshroom, /obj/structure/soil, /obj/structure/flora/newtree, /obj/structure/flora/tree, /obj/structure/glowshroom)
				situational_bonus = 0
				// the more natural stuff around US, the more we heal
				for (var/obj/O in oview(5, user))
					if (O in natural_stuff)
						situational_bonus = min(situational_bonus + 0.1, 2)
				for (var/obj/structure/flora/roguetree/wise/O in oview(5, user))
					situational_bonus += 1.5
				// Healing before the oaken avatar of Tamari in the Druid Grove (exceptionally rare otherwise) supercharges their healing
				if (situational_bonus > 0)
					conditional_buff = TRUE
			if(/datum/patron/peoples_pantheon/cinella)
				message_out = span_info("A mist of salt-scented vapour settles on [target]!")
				message_self = span_notice("I'm invigorated by healing vapours!")
				// if our target is standing in water, heal a flat amount extra
				if (istype(get_turf(target), /turf/open/water))
					conditional_buff = TRUE
					situational_bonus = 1.5
			if(/datum/patron/peoples_pantheon/carthus)
				message_out = span_info("An air of righteous defiance rises near [target]!")
				message_self = span_notice("I'm filled with an urge to fight on!")
				situational_bonus = 0
				// the bloodier the area around our target is, the more we heal
				for (var/obj/effect/decal/cleanable/blood/O in oview(5, target))
					situational_bonus = min(situational_bonus + 0.1, 2)
				conditional_buff = TRUE
			if(/datum/patron/lording_three/tsoridys)
				message_out = span_info("A sense of quiet respite radiates from [target]!")
				message_self = span_notice("I feel Tsoridys' gaze turn from me for now!")
				if (iscarbon(target))
					var/mob/living/carbon/C = target
					// if the target is "close to death" (at or below 25% health)
					if (C.health <= (C.maxHealth * 0.25))
						conditional_buff = TRUE
						situational_bonus = 2.5
			if(/datum/patron/three_sisters/kasmidian)
				message_out = span_info("A fugue seems to manifest briefly across [target]!")
				message_self = span_notice("My wounds vanish as if they had never been there! ")
				// half of the time, heal a little (or a lot) more - flip the coin
				if (prob(50))
					conditional_buff = TRUE
					situational_bonus = rand(1, 2.5)
			if(/datum/patron/three_sisters/nunos)
				message_out = span_info("A tempering heat is discharged out of [target]!")
				message_self = span_info("I feel the heat of a forge soothing my pains!")
				var/list/firey_stuff = list(/obj/machinery/light/rogue/torchholder, /obj/machinery/light/rogue/campfire, /obj/machinery/light/rogue/hearth, /obj/machinery/light/rogue/wallfire, /obj/machinery/light/rogue/wallfire/candle, /obj/machinery/light/rogue/forge)
				// extra healing for every source of fire/light near us
				situational_bonus = 0
				for (var/obj/O in oview(5, user))
					if (O.type in firey_stuff)
						situational_bonus = min(situational_bonus + 0.5, 2.5)
				if (situational_bonus > 0)
					conditional_buff = TRUE
			if(/datum/patron/peoples_pantheon/varielle)
				message_out = span_info("An emanance of love blossoms around [target]!")
				message_self = span_notice("I'm filled with the restorative warmth of love!")
				// if they're wearing an heroine bud (or are a pacifist), pretty much double the healing. if we're also wearing a bud at any point or a pacifist from any other source, apply another +15 bonus
				situational_bonus = 0
				if (HAS_TRAIT(target, TRAIT_PACIFISM))
					conditional_buff = TRUE
					situational_bonus = 2.5
				if (HAS_TRAIT(user, TRAIT_PACIFISM))
					conditional_buff = TRUE
					situational_bonus += 1.5
			if(/datum/patron/godless)
				message_out = span_info("Without any particular cause or reason, [target] is healed!")
				message_self = span_notice("My wounds close without cause.")
			else
				message_out = span_info("A choral sound comes from above and [target] is healed!")
				message_self = span_notice("I am bathed in healing choral hymns!")

		var/healing = 2.5
		if (conditional_buff)
			to_chat(user, "Channeling my patron's power is easier in these conditions!")
			healing += situational_bonus

		if(ishuman(target))
			var/mob/living/carbon/human/H = target
			var/no_embeds = TRUE
			var/list/embeds = H.get_embedded_objects()
			if(length(embeds))
				for(var/object in embeds)
					if(!istype(object, /obj/item/natural/worms/leech))	//Leeches and surgical cheeles are made an exception.
						no_embeds = FALSE
			else
				no_embeds = TRUE
			if(no_embeds)
				target.apply_status_effect(/datum/status_effect/buff/healing, healing)
			else
				message_out = span_warning("The wounds tear and rip around the embedded objects!")
				message_self = span_warning("Agonising pain shoots through your body as magycks try to sew around the embedded objects!")
				H.adjustBruteLoss(20)
				playsound(target, 'sound/combat/dismemberment/dismem (2).ogg', 100)
				H.emote("agony")
		target.visible_message(message_out, message_self)
		return TRUE
	revert_cast()
	return FALSE

// Miracle
/obj/effect/proc_holder/spell/invoked/heal
	name = "Fortify"
	overlay_state = "astrata"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/heal.ogg'
	invocation_type = "emote"
	invocation = span_warning("%user% casts Fortify!")
	invocation_emote_self = span_warning("I cast Fortify!")
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 20 SECONDS
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/heal/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(user.patron?.undead_hater && (target.mob_biotypes & MOB_UNDEAD)) //positive energy harms the undead
			target.visible_message(span_danger("[target] is burned by holy light!"), span_userdanger("I'm burned by holy light!"))
			target.adjustFireLoss(25)
			target.fire_act(1,10)
			return TRUE
		target.visible_message(span_info("A wreath of gentle light passes over [target]!"), span_notice("I'm bathed in holy light!"))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			C.apply_status_effect(/datum/status_effect/buff/fortify)
		else
			target.adjustBruteLoss(-50)
			target.adjustFireLoss(-50)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/regression
	name = "Regression"
	overlay_state = "regression"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = list('sound/magic/regression1.ogg','sound/magic/regression2.ogg','sound/magic/regression3.ogg','sound/magic/regression4.ogg')
	invocation_type = "emote"
	invocation = span_warning("%user% casts Regression!")
	invocation_emote_self = span_warning("I cast Regression!")
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 10 SECONDS
	miracle = TRUE
	devotion_cost = 10

/obj/effect/proc_holder/spell/invoked/regression/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		target.visible_message(span_info("Order filled magic rewind [target]'s wounds!"), span_notice("My wounds, undone!"))
		var/healing = 2.5
		if(target.has_status_effect(/datum/status_effect/buff/stasis))
			healing += 2.5
		target.apply_status_effect(/datum/status_effect/buff/healing, healing)
		return TRUE
	revert_cast()
	return FALSE

/obj/effect/proc_holder/spell/invoked/convergence
	name = "Convergence"
	overlay_state = "convergence"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 4
	warnie = "sydwarning"
	movement_interrupt = FALSE
//	chargedloop = /datum/looping_sound/invokeholy
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = list('sound/magic/convergence1.ogg','sound/magic/convergence2.ogg','sound/magic/convergence3.ogg','sound/magic/convergence4.ogg')
	invocation_type = "none"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 20 SECONDS
	miracle = TRUE
	devotion_cost = 20

/obj/effect/proc_holder/spell/invoked/convergence/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		target.visible_message(span_info("A convergence of fates surrounds [target]!"), span_notice("My past and present converge as one!"))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			C.apply_status_effect(/datum/status_effect/buff/convergence)
			C.apply_status_effect(/datum/status_effect/buff/fortify)
		else
			target.adjustBruteLoss(-50)
			target.adjustFireLoss(-50)
		return TRUE
	revert_cast()
	return FALSE


/obj/effect/proc_holder/spell/invoked/stasis
	name = "Stasis"
	desc = "You capture your target's current state in time, reverting them to such a state several seconds later."
	releasedrain = 35
	chargedrain = 1
	chargetime = 30
	recharge_time = 60 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 3
	sound = 'sound/magic/timeforward.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/holy
	overlay_state = "sands_of_time"
	var/brute = 0
	var/burn = 0
	var/oxy = 0
	var/toxin = 0
	var/turf/origin
	var/firestacks = 0
	var/blood = 0
	miracle = TRUE
	devotion_cost = 30

/obj/effect/proc_holder/spell/invoked/stasis/cast(list/targets, mob/user = usr)
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		var/mob/living/carbon/C = target
		C.apply_status_effect(/datum/status_effect/buff/stasis)
		brute = target.getBruteLoss()
		burn = target.getFireLoss()
		oxy = target.getOxyLoss()
		toxin = target.getToxLoss()
		origin = get_turf(target)
		firestacks = target.fire_stacks
		blood = target.blood_volume
		to_chat(target, span_warning("I feel a part of me was left behind..."))
		play_indicator(target,'icons/mob/overhead_effects.dmi', "timestop", 100, OBJ_LAYER)
		addtimer(CALLBACK(src, PROC_REF(remove_buff), target), wait = 10 SECONDS)
		return TRUE
	

/obj/effect/proc_holder/spell/invoked/stasis/proc/remove_buff(mob/living/carbon/target)
	do_teleport(target, origin, no_effects=TRUE)
	target.adjust_fire_stacks(target.fire_stacks*-1 + firestacks)
	var/brutenew = target.getBruteLoss()
	var/burnnew = target.getFireLoss()
	var/oxynew = target.getOxyLoss()
	var/toxinnew = target.getToxLoss()
	if(target.has_status_effect(/datum/status_effect/buff/convergence))
		if(brutenew>brute)
			target.adjustBruteLoss(brutenew*-1 + brute)
		if(burnnew>burn)
			target.adjustFireLoss(burnnew*-1 + burn)
		if(oxynew>oxy)
			target.adjustOxyLoss(oxynew*-1 + oxy)
		if(toxinnew>toxin)
			target.adjustToxLoss(target.getToxLoss()*-1 + toxin)
		if(target.blood_volume<blood)
			target.blood_volume = blood
	else
		target.adjustBruteLoss(brutenew*-1 + brute)
		target.adjustFireLoss(burnnew*-1 + burn)
		target.adjustOxyLoss(oxynew*-1 + oxy)
		target.adjustToxLoss(target.getToxLoss()*-1 + toxin)
		target.blood_volume = blood
	playsound(target.loc, 'sound/magic/timereverse.ogg', 100, FALSE)

/obj/effect/proc_holder/spell/invoked/stasis/proc/play_indicator(mob/living/carbon/target, icon_path, overlay_name, clear_time, overlay_layer)
	if(!ishuman(target))
		return
	if(target.stat != DEAD)
		var/mob/living/carbon/humie = target
		var/datum/species/species =	humie.dna.species
		var/list/offset_list
		if(humie.gender == FEMALE)
			offset_list = species.offset_features[OFFSET_HEAD_F]
		else
			offset_list = species.offset_features[OFFSET_HEAD]
			var/mutable_appearance/appearance = mutable_appearance(icon_path, overlay_name, overlay_layer)
			if(offset_list)
				appearance.pixel_x += (offset_list[1])
				appearance.pixel_y += (offset_list[2]+12)
			appearance.appearance_flags = RESET_COLOR
			target.overlays_standing[OBJ_LAYER] = appearance
			target.apply_overlay(OBJ_LAYER)
			update_icon()
			addtimer(CALLBACK(humie, PROC_REF(clear_overhead_indicator), appearance, target), clear_time)

/obj/effect/proc_holder/spell/invoked/stasis/proc/clear_overhead_indicator(appearance,mob/living/carbon/target)
	target.remove_overlay(OBJ_LAYER)
	cut_overlay(appearance, TRUE)
	qdel(appearance)
	update_icon()
	return
