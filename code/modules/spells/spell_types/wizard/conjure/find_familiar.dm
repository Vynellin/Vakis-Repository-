/obj/effect/proc_holder/spell/self/findfamiliar
	name = "Find Familiar"
	desc = "Summon a loyal magical companion to aid you in your adventures. Reusing the spell with an active familiar can awaken its sentience."
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	recharge_time = 5 SECONDS
	chargetime = 2 SECONDS

	warnie = "spellwarning"

	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane

	xp_gain = TRUE
	spell_tier = 1
	cost = 1

	invocation = "Appare, spiritus fidus."
	invocation_type = "whisper"

	var/mob/living/simple_animal/pet/familiar/fam
	var/familiars

/obj/effect/proc_holder/spell/self/findfamiliar/Initialize()
	. = ..()
	familiars = GLOB.familiar_types

/obj/effect/proc_holder/spell/self/findfamiliar/empowered/
	name = "Empowered Find Familiar"
	invocation = "Tegos, nemetos trēwos." //I'm calling "older, forgotten incanation" as proto celtic sounding since we're using latin for normal ones.

/obj/effect/proc_holder/spell/self/findfamiliar/empowered/Initialize()
	. = ..()
	// Extended list if we're eligible
	familiars += GLOB.familiar_types_extended

/obj/effect/proc_holder/spell/self/findfamiliar/cast(list/targets, mob/living/carbon/user)
	. = ..()

	for (var/mob/living/simple_animal/pet/familiar/familiar_check in GLOB.alive_mob_list)
		if (familiar_check.familiar_summoner == user)
			var/choice = input(user, "You already have a familiar. Do you want to free them?") as null|anything in list(
				"Yes",
				"No"
			)
			if (choice == "No" || choice == null)
				revert_cast()
				return FALSE
			else if (choice == "Yes")
				if(familiar_check.mind)
					to_chat(familiar_check, span_warning("You feel your link with [familiar_check.familiar_summoner.real_name] break, you are free."))
					to_chat(user, span_warning("You feel your link with [familiar_check.name] break."))
					familiar_check.summoner = null
					familiar_check.familiar_summoner.remove_status_effect(familiar_check.buff_given)
					familiar_check.familiar_summoner.mind.RemoveSpell(/obj/effect/proc_holder/spell/self/message_familiar)
					familiar_check.mind.RemoveSpell(/obj/effect/proc_holder/spell/self/message_summoner)
				else
					familiar_check.visible_message(span_warning("[familiar_check.name] looks in the direction of [familiar_check.familiar_summoner.real_name] one last time, before opening a portal and vanishing into it, the portal closing behind them."))
					qdel(familiar_check)
				revert_cast()
				return FALSE
	//familiar exists but is dead
	for (var/mob/living/simple_animal/pet/familiar/familiar_check in GLOB.dead_mob_list)
		if (familiar_check.familiar_summoner == user)
			var/choice = input(user, "You already have a familiar. Do you want to free them?") as null|anything in list(
				"Yes",
				"No"
			)
			if (choice == "No" || choice == null)
				revert_cast()
				return FALSE
			else if (choice == "Yes")
				if(familiar_check.mind)
					to_chat(familiar_check, span_warning("You feel your link with [familiar_check.familiar_summoner.real_name] break, you are free."))
					to_chat(user, span_warning("You feel your link with [familiar_check.name] break."))
					familiar_check.summoner = null
					familiar_check.familiar_summoner.remove_status_effect(familiar_check.buff_given)
					familiar_check.familiar_summoner.mind.RemoveSpell(/obj/effect/proc_holder/spell/self/message_familiar)
					familiar_check.mind.RemoveSpell(/obj/effect/proc_holder/spell/self/message_summoner)
				else
					familiar_check.visible_message(span_warning("[familiar_check.name]'s corpse vanishes in a puff of smoke."))
					qdel(familiar_check)
	// No existing familiar
	var/path_choice = input(user, "How do you want to summon your familiar?") as null|anything in list(
		"Summon from registered familiars",
		"Summon a non-sentient familiar"
	)
	if (path_choice == "Summon from registered familiars")
		var/list/candidates = list()

		for (var/client/looped_client in GLOB.familiar_queue)
			var/datum/familiar_prefs/pref = looped_client.prefs?.familiar_prefs
			if (pref)
				candidates += looped_client

		if (!candidates.len)
			to_chat(user, span_notice("No familiar candidates are currently registered."))
			revert_cast()
			return FALSE

		while (TRUE)
			var/list/name_map = list()
			for (var/client/looped_candidates in candidates)
				var/datum/familiar_prefs/pref = looped_candidates.prefs?.familiar_prefs
				if (pref?.familiar_name)
					name_map[pref.familiar_name] = looped_candidates

			var/choice = input(user, "Choose a registered familiar to inspect:") as null|anything in name_map
			if (!choice)
				revert_cast()
				return FALSE

			var/client/target = name_map[choice]
			var/datum/familiar_prefs/pref = target.prefs?.familiar_prefs
			if (!pref)
				to_chat(user, span_warning("That familiar is no longer available."))
				continue

			// Mimic clicking "Examine closer"
			var/list/dat = list()
			dat += "<div align='center'><font size = 5; font color = '#dddddd'><b>[pref.familiar_name]</b></font></div>"
			if(valid_headshot_link(null, pref.familiar_headshot_link, TRUE))
				dat += ("<div align='center'><img src='[pref.familiar_headshot_link]' width='325px' height='325px'></div>")
			if(pref.familiar_flavortext)
				dat += "<div align='left'>[pref.familiar_flavortext_display]</div>"
			if(pref.familiar_ooc_notes_display)
				dat += "<br>"
				dat += "<div align='center'><b>OOC notes</b></div>"
				dat += "<div align='left'>[pref.familiar_ooc_notes_display]</div>"
			if(pref.familiar_ooc_extra)
				dat += "[pref.familiar_ooc_extra]"
			var/datum/browser/popup = new(user, "[src]", nwidth = 600, nheight = 800)
			popup.set_content(dat.Join())
			popup.open(FALSE)

			var/confirm = input(user, "Summon this familiar?") as null|anything in list("Yes", "No")
			if (confirm != "Yes")
				winset(user.client, "[src]", "is-visible=false")
				continue
			
			if (!target || (!isobserver(target.mob) && !isnewplayer(target.mob)))
				to_chat(user, span_warning("That familiar is no longer available."))
				revert_cast()
				return FALSE

			var/response = ask_familiar_prompt(target, user, 200)

			if (response == "Yes")
				popup.close()
				spawn_familiar_for_player(target, user)
				return TRUE


			else
				to_chat(user, span_notice("[target] declined or didn't respond in time."))
				continue
	else
		var/familiarchoice = input("Choose your familiar", "Available familiars") as anything in familiars
		var/mob/living/simple_animal/pet/familiar/familiar_type = familiars[familiarchoice]
		var/mob/living/simple_animal/pet/familiar/fam = new familiar_type(get_step(user, user.dir))
		fam.familiar_summoner = user
		user.visible_message(span_notice("[fam.summoning_emote]"))
		fam.fully_replace_character_name(null, "[user]'s familiar")
		user.apply_status_effect(fam.buff_given)
		return TRUE


/datum/familiar_poll
	var/mob/target
	var/mob/caster
	var/timeout
	var/response = null

/datum/familiar_poll/New(mob/M, mob/c, time)
	target = M
	caster = c
	timeout = time
	spawn(0)
		show_prompt()
	..()

/proc/ask_familiar_prompt(mob/user, mob/caster, poll_time = 200)
	var/datum/familiar_poll/polled = new(user, caster, poll_time)
	return polled.wait_for_response()

/datum/familiar_poll/proc/show_prompt()
	if (!target || !target.client)
		response = "Timeout"
		return

	window_flash(target.client)

	var/result = askuser(
		target,
		"[caster] wants to summon you as a familiar.",
		"Respond within [DisplayTimeText(timeout)]",
		"Yes", "No",
		Timeout = timeout,
		StealFocus = 0
	)

	switch(result)
		if(1)
			response = "Yes"
		if(2)
			response = "No"
		else
			response = "Timeout"

/datum/familiar_poll/proc/wait_for_response()
	var/timer = 0
	while (isnull(response) && timer++ < timeout)
		sleep(1)
	return response

/proc/spawn_familiar_for_player(mob/chosen_one, mob/living/carbon/user)
	var/mob/living/simple_animal/pet/familiar/awakener = new chosen_one.client.prefs.familiar_prefs.familiar_specie(get_step(user, user.dir))
	awakener.familiar_summoner = user
	user.visible_message(span_notice("[awakener.summoning_emote]"))
	awakener.fully_replace_character_name(null, "[chosen_one.client.prefs.familiar_prefs.familiar_name]")
	user.apply_status_effect(awakener.buff_given)
	awakener.fully_replace_character_name(null, chosen_one.client.prefs.familiar_prefs.familiar_name)
	chosen_one.mind.transfer_to(awakener)
	var/datum/mind/mind_datum = awakener.mind
	if (!mind_datum)
		return // failsafe in case something went wrong with transfer
	mind_datum.RemoveAllSpells()
	mind_datum.AddSpell(new /obj/effect/proc_holder/spell/self/message_summoner)
	user.mind.AddSpell(new /obj/effect/proc_holder/spell/self/message_familiar)

	if (awakener.inherent_spell)
		for (var/spell_path in awakener.inherent_spell)
			mind_datum.AddSpell(new spell_path)


	// Disabling AI features
	awakener.can_have_ai = FALSE
	awakener.AIStatus = AI_OFF
	awakener.stop_automated_movement = TRUE
	awakener.stop_automated_movement_when_pulled = TRUE
	awakener.wander = FALSE

/obj/effect/proc_holder/spell/self/message_familiar
	name = "Message Familiar"
	desc = "Whisper a message in your Familar's head."

/obj/effect/proc_holder/spell/self/message_familiar/cast(list/targets, mob/user)
	. = ..()
	var/mob/living/simple_animal/pet/familiar/familiar
	for(var/mob/living/simple_animal/pet/familiar/familiar_check in GLOB.player_list)
		if(familiar_check.familiar_summoner == user)
			familiar = familiar_check
	if(!familiar || !familiar.mind)
		revert_cast()
		to_chat(user, "You cannot sense your familiar's mind.")
		return
	var/message = input(user, "You make a connection. What are you trying to say?")
	if(!message)
		revert_cast()
		return
	to_chat_immediate(familiar, "Arcane whispers fill the back of my head, resolving into [user]'s voice: <font color=#7246ff>[message]</font>")
	user.visible_message("[user] mutters an incantation and their mouth briefly flashes white.")
	user.whisper(message)
	log_game("[key_name(user)] sent a message to [key_name(familiar)] with contents [message]")
	return TRUE

/datum/virtue/utility/forgotten_bond
	name = "Forgotten Bond"
	desc = "Long before the Ridge was settled, old pacts were made... and I remember them. My bond reaches deeper than most, calling on familiars that stir uneasily in memory and myth. They are stranger, older... and they chose me."
	custom_text = "Teaches the empowered version of the Find Familiar spell."
	
	
/datum/virtue/utility/forgotten_bond/apply_to_human(mob/living/carbon/human/recipient)
	if (!recipient.mind?.has_spell(/obj/effect/proc_holder/spell/self/findfamiliar/empowered))
		recipient.mind?.AddSpell(new /obj/effect/proc_holder/spell/self/findfamiliar/empowered)
