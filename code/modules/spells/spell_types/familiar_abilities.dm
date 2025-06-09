/obj/effect/proc_holder/spell/self/message/message_summoner
	name = "Message Summoner"
	desc = "Whisper a message in your summoner's head."
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
	to_chat_immediateo_chat(summoner, "Arcane whispers fill the back of my head, resolving into [user]'s voice: <font color=#7246ff>[message]</font>")
	user.visible_message("[user] mutters an incantation and their mouth briefly flashes white.")
	user.whisper(message)
	log_game("[key_name(user)] sent a message to [key_name(summoner)] with contents [message]")
	return TRUE

/obj/effect/proc_holder/spell/self/stillness_of_stone
	name = "Stillness of Stone"
	desc = "You become completly still, blending in with nature."
	xp_gain = FALSE
	releasedrain = 30
	recharge_time = 60 SECONDS
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
		user.canmove = TRUE
		user.stoneform = FALSE
		to_chat(M, "<span class='notice'>You shift back into your natural form.</span>")
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
		user.canmove = FALSE
		user.stoneform = TRUE
		to_chat(user, "<span class='notice'>You become utterly still, blending into your surroundings like a stone.</span>")
