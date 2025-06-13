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
	var/familiars = list(
		"Pondstone Toad (+1 Strength)" = /mob/living/simple_animal/pet/familiar/pondstone_toad,
		"Mist Lynx (+1 Perception)" = /mob/living/simple_animal/pet/familiar/mist_lynx,
		"Rune Rat (+1 Intelligence)" = /mob/living/simple_animal/pet/familiar/rune_rat,
		"Vaporroot Wisp (+1 Constitution)" = /mob/living/simple_animal/pet/familiar/vaporroot_wisp,
		"Ashcoiler (+1 Endurance)" = /mob/living/simple_animal/pet/familiar/ashcoiler,
		"Glimmer Hare (+1 Speed)" = /mob/living/simple_animal/pet/familiar/glimmer_hare,
		"Hollow Antlerling (+1 Luck)" = /mob/living/simple_animal/pet/familiar/hollow_antlerling,
	)

/obj/effect/proc_holder/spell/self/findfamiliar/empowered/
	name = "Empowered Find Familiar"
	invocation = "Tegos, nemetos trēwos." //I'm calling "older, forgotten incanation" as proto celtic sounding since we're using latin for normal ones.

/obj/effect/proc_holder/spell/self/findfamiliar/empowered/Initialize()
	. = ..()
	// Extended list offered in some conditions.
	familiars += list(
		"Gravemoss Serpent (+1 Strength, +1 Endurance)" = /mob/living/simple_animal/pet/familiar/gravemoss_serpent,
		"Starfield Crow (+1 Perception, +1 Luck)" = /mob/living/simple_animal/pet/familiar/starfield_crow,
		"Emberdrake (+1 Intelligence, +1 Constitution)" = /mob/living/simple_animal/pet/familiar/emberdrake,
		"Ripplefox (+1 Speed, +1 Luck)" = /mob/living/simple_animal/pet/familiar/ripplefox,
		"Whisper Stoat (+1 Perception, +1 Intelligence)" = /mob/living/simple_animal/pet/familiar/whisper_stoat,
		"Thornback Turtle (+1 Strength, +1 Constitution)" = /mob/living/simple_animal/pet/familiar/thornback_turtle,
	)

/obj/effect/proc_holder/spell/self/findfamiliar/cast(list/targets, mob/living/carbon/user)
	. = ..()

	for (var/mob/living/simple_animal/pet/familiar/familiar_check in GLOB.alive_mob_list)
		if (familiar_check.familiar_summoner == user)
			// Ask the caster how they want to proceed
			var/choice = input(user, "You already have a familiar. What do you want to do?") as null|anything in list(
				"Make it sentient",
				"Do nothing",
				"I have a specific familiar in mind"
			)
			if (choice == "Do nothing" || choice == null)
				revert_cast()
				return FALSE
			else if (choice == "Make it sentient")
				var/list/mob/candidate = pollGhostCandidates("Do you want to play as [familiar_check.name], the [familiar_check.animal_species]?", ROLE_SENTIENCE, null, FALSE, 100, POLL_IGNORE_SENTIENCE_POTION)
				if (LAZYLEN(candidate))
					var/mob/chosen_one = pick(candidate)
					if (istype(chosen_one, /mob/dead/new_player))
						var/mob/dead/new_player/menu_gamer = chosen_one
						menu_gamer.close_spawn_windows()
					var/mob/living/simple_animal/pet/familiar/awakener = familiar_check
					prepare_familiar_for_player(awakener, chosen_one, user)
					return FALSE
				else
					to_chat(user, span_notice("The familiar didn't awaken."))
					return FALSE
			else if (choice == "I have a specific familiar in mind")
				// Filter matching familiars
				var/list/options = list()
				for (var/entry in GLOB.registered_familiars)
					if (entry["type"] == familiar_check.type && !entry["suppress"])
						options += entry

				if (!options.len)
					to_chat(user, span_notice("No matching familiar candidates are currently available."))
					revert_cast()
					return FALSE

				while (TRUE)
					var/list/name_map = list()
					for (var/entry in options)
						name_map[entry["name"]] = entry
					var/name_choice = input(user, "Choose from registered familiars") as null|anything in name_map
					if (!name_choice)
						revert_cast()
						return FALSE

					var/entry = name_map[name_choice]
					var/desc_confirm = input(user, "[entry["description"]]\n\nSummon this familiar?") as null|anything in list("Yes", "No")
					if (desc_confirm == "Yes")
						var/mob/ghost_candidate = get_mob_by_ckey(entry["ckey"])
						if (!ghost_candidate || !istype(ghost_candidate, /mob/dead/observer))
							to_chat(user, span_warning("That familiar is no longer available."))
							revert_cast()
							return FALSE

						var/resp = input(ghost_candidate, "[user] wants to make you their familiar. Accept?") as null|anything in list("Yes", "No", "Never this round")
						if (resp == "Yes")
							var/fam_type = entry["type"]
							var/mob/living/simple_animal/pet/familiar/fam = new fam_type(get_step(user, user.dir))
							fam.familiar_summoner = user
							prepare_familiar_for_player(fam, ghost_candidate, user)
							return FALSE
						else if (resp == "Never this round")
							entry["suppress"] = TRUE
							return FALSE
						else
							continue
					else
						continue

	//familiar exists but is dead
	for (var/mob/living/simple_animal/pet/familiar/familiar_check in GLOB.dead_mob_list)
		if (familiar_check.familiar_summoner == user)
			var/death_deleting = input(user, "You have a familiar but they are dead, do you want to summon another ? This will make the previous one impossible to ressurect.") as null|anything in list("Yes", "No")
			if (death_deleting == "No")
				return FALSE
	// No existing familiar
	var/path_choice = input(user, "How do you want to summon your familiar?") as null|anything in list(
		"Summon from registered familiars",
		"Summon a non-sentient familiar"
	)
	if (path_choice == "Summon from registered familiars")
		var/list/options = list()
		for (var/entry in GLOB.registered_familiars)
			if (!entry["suppress"])
				options += entry
		if (!options.len)
			to_chat(user, span_notice("No familiar candidates are currently registered."))
			return FALSE

		while (TRUE)
			var/list/name_map = list()
			for (var/entry in options)
				name_map[entry["name"]] = entry
			var/name_choice = input(user, "Choose from registered familiars") as null|anything in name_map
			if (!name_choice)
				return FALSE

			var/entry = name_map[name_choice]
			var/desc_confirm = input(user, "[entry["description"]]\n\nSummon this familiar?") as null|anything in list("Yes", "No")
			if (desc_confirm == "Yes")
				var/mob/ghost_candidate = get_mob_by_ckey(entry["ckey"])
				if (!ghost_candidate || !istype(ghost_candidate, /mob/dead/observer))
					to_chat(user, span_warning("That ghost is no longer available."))
					return FALSE

				var/resp = input(ghost_candidate, "[user] wants to make you their familiar. Accept?") as null|anything in list("Yes", "No", "Never this round")
				if (resp == "Yes")
					var/fam_type = entry["type"]
					var/mob/living/simple_animal/pet/familiar/fam = new fam_type(get_step(user, user.dir))
					fam.familiar_summoner = user
					prepare_familiar_for_player(fam, ghost_candidate, user)
					return TRUE
				else if (resp == "Never this round")
					entry["suppress"] = TRUE
					return FALSE
				else
					continue
	else if (path_choice != "Summon a non-sentient familiar")
		return FALSE

	var/familiarchoice = input("Choose your familiar", "Available familiars") as anything in familiars
	var/mob/living/simple_animal/pet/familiar/familiar_type = familiars[familiarchoice]
	var/mob/living/simple_animal/pet/familiar/fam = new familiar_type(get_step(user, user.dir))
	fam.familiar_summoner = user
	user.visible_message(span_notice("[fam.summoning_emote]"))
	fam.fully_replace_character_name(null, "[user]'s familiar")
	user.apply_status_effect(fam.buff_given)
	return TRUE

/proc/prepare_familiar_for_player(mob/living/simple_animal/pet/familiar/awakener, mob/chosen_one, mob/living/carbon/user)
	awakener.ckey = chosen_one.ckey
	chosen_one.client.prefs.fam_copy_to(awakener) //This should save the familiar name, fam ooc notes, fam extra ooc and fam headshot to the mob for inspection later.
	chosen_one.mind.transfer_to(awakener)
	awakener.grant_all_languages(omnitongue=TRUE)
	awakener.mind.RemoveAllSpells()
	awakener.mind.AddSpell(new /obj/effect/proc_holder/spell/self/message_summoner)
	user.mind.AddSpell(new /obj/effect/proc_holder/spell/self/message_familiar)
	if (awakener.inherent_spell)
		for (var/spell_path in awakener.inherent_spell)
			awakener.mind.AddSpell(new spell_path)

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
