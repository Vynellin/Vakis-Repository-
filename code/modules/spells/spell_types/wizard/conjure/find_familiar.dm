/obj/effect/proc_holder/spell/self/findfamiliar
	name = "Find Familiar"
	desc = "Summon a loyal magical companion to aid you in your adventures."
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	recharge_time = 1 HOURS

	warnie = "spellwarning"

	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane //can be arcane, druidic, blood, holy

	xp_gain = FALSE
	miracle = FALSE
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

/obj/effect/proc_holder/spell/self/findfamiliar/warlock/
	name = "Find Familiar (Warlock)"
	invocation = "Tegos, nemetos trēwos."

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

/obj/effect/proc_holder/spell/self/findfamiliar/cast(mob/user = usr)
	..()
	for(var/mob/living/simple_animal/pet/familiar/familiar_check in GLOB.player_list)
		if(familiar_check.familiar_summoner == user)
			to_chat(user, span_notice("You alread have a familiar."))
			revert_cast()
			return
	var/familiarchoice = input("Choose your familiar", "Available familiars") as anything in familiars
	var/mob/living/simple_animal/pet/familiar/familiar_type = familiars[familiarchoice]
	fam = new familiar_type(user.loc)
	fam.familiar_summoner = user
	user.visible_message(span_notice("[fam.summoning_emote]"))
	fam.fully_replace_character_name(null, "[user]'s familiar")	

/mob/living/simple_animal/pet/familiar/AltClick(mob/user)
	. = ..()
	if(!familiar_summoner == user)
		to_chat(user, span_notice("You are not this familiar's master."))
		return
	var/list/candidate = pollGhostCandidates("Do you want to play as [span_notice("[src.name]")]?", ROLE_SENTIENCE, null, FALSE, 100, POLL_IGNORE_SENTIENCE_POTION)
	if(LAZYLEN(candidate))
		var/mob/chosen_one =  pick(candidate)
		var/fam = src
		fam.key = chosen_one.key
		chosen_one.mind.transfer_to(fam)
		fam.grant_all_languages(omnitongue=TRUE)
		var/new_name = input(fam.current, "What is your name?", "Name") as text|null
		fam.fully_replace_character_name(null, new_name)
		fam.give_spell(/obj/effect/proc_holder/spell/self/message/message_summoner)
		user.give_spell(/obj/effect/proc_holder/spell/self/message/message_familiar)
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
	to_chat(familiar, "Arcane whispers fill the back of my head, resolving into [user]'s voice: <font color=#7246ff>[message]</font>")
	user.visible_message("[user] mutters an incantation and their mouth briefly flashes white.")
	user.whisper(message)
	log_game("[key_name(user)] sent a message to [key_name(HL)] with contents [message]")
	return TRUE
