/obj/effect/proc_holder/spell/invoked/findfamiliar
	name = "Find Familiar"
	desc = "Summon a loyal magical companion to aid you in your adventures. Reusing the spell on a familiar might awaken them to sentience."
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	recharge_time = 5 SECONDS
	chargetime = 1 SECONDS

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

/obj/effect/proc_holder/spell/invoked/findfamiliar/empowered/
	name = "Empowered Find Familiar"
	invocation = "Tegos, nemetos trēwos."

/obj/effect/proc_holder/spell/invoked/findfamiliar/empowered/Initialize()
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

/obj/effect/proc_holder/spell/invoked/findfamiliar/cast(list/targets, mob/user)
	..()
	var/atom/target = targets[1]
	if(!(istype(target, /turf/open)) || !(istype(target, /mob/living/simple_animal/pet/familiar)))
		return
	if(istype(target, /turf/open/))
		for(var/mob/living/simple_animal/pet/familiar/familiar_check in GLOB.player_list)
			if(familiar_check.familiar_summoner == user)
				to_chat(user, span_notice("You alread have a familiar."))
				revert_cast()
				return
		var/familiarchoice = input("Choose your familiar", "Available familiars") as anything in familiars
		var/mob/living/simple_animal/pet/familiar/familiar_type = familiars[familiarchoice]
		fam = new familiar_type(get_turf(target))
		fam.familiar_summoner = user
		user.visible_message(span_notice("[fam.summoning_emote]"))
		fam.fully_replace_character_name(null, "[user]'s familiar")	
	else 
		var/mob/living/simple_animal/pet/familiar/targeted_familiar
		if(!targeted_familiar.familiar_summoner == user)
			to_chat(user, span_notice("You are not this familiar's master."))
			return
		var/list/mob/candidate = pollGhostCandidates("Do you want to play as [span_notice("[targeted_familiar.name]")]?", ROLE_SENTIENCE, null, FALSE, 100, POLL_IGNORE_SENTIENCE_POTION)
		if(LAZYLEN(candidate))
			var/mob/chosen_one =  pick(candidate)
			var/mob/living/simple_animal/pet/familiar/awakener = target
			awakener.key = chosen_one.key
			chosen_one.mind.transfer_to(awakener)
			awakener.grant_all_languages(omnitongue=TRUE)
			var/new_name = input(awakener, "What is your name?", "Name") as text|null
			awakener.fully_replace_character_name(null, new_name)
			awakener.mind.AddSpell(/obj/effect/proc_holder/spell/self/message/message_summoner)
			awakener.mind.AddSpell(/obj/effect/proc_holder/spell/self/message/message_familiar)
			if(awakener.inherent_spell)
				for(var/spell_path in awakener.inherent_spell)
					awakener.mind.AddSpell(spell_path)
			//Disabling the AI
			awakener.can_have_ai = FALSE
			awakener.AIStatus = AI_OFF
			awakener.stop_automated_movement = TRUE  // Stop automated movement
			awakener.stop_automated_movement_when_pulled = TRUE  // Stop movement when pulled
			awakener.wander = FALSE  // Disable wandering
		else
			to_chat(user, span_notice("The familiar didn't awaken."))

/obj/effect/proc_holder/spell/self/message/message_familiar
	name = "Message Familiar"
	desc = "Whisper a message in your Familar's head."

/obj/effect/proc_holder/spell/self/message/message_familiar/cast(list/targets, mob/user)
	. = ..()
	var/mob/living/simple_animal/pet/familiar/familiar = null
	for(var/mob/living/simple_animal/pet/familiar/familiar_check in GLOB.player_list)
		if(familiar_check.familiar_summoner == user)
			familiar = familiar_check
			return
	if(!familiar)
		revert_cast()
		to_chat(user, "You cannot sense your familiar's mind.")
		return
	if(!familiar.mind)
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
