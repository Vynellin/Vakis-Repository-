/obj/item/quicksilver
	name = "quicksilver poultice"
	icon_state = "quicksilver"
	possible_item_intents = list(/datum/intent/use)
	icon = 'modular_azurepeak/icons/obj/items/quicksilver.dmi'
	desc = "A daring blend of alchemy, aberrant blood, and divine silver, this poultice can lift some of the most fell of curses."
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 1
	drop_sound = 'sound/items/gem.ogg'
	resistance_flags = FIRE_PROOF
	var/miracle_use = 0
	var/success = 0

/obj/item/quicksilver/examine(mob/user)
	. = ..()
	if(miracle_use)
		. += span_notice("Through some miraculous happenstance, there is enough for one more use.")

/obj/item/quicksilver/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	anoint(M, user)

/obj/item/quicksilver/proc/anoint(mob/living/carbon/human/M, mob/living/carbon/human/user) //Time to deconvert some antagonists
	var/inquisitor = FALSE
	if(!user.mind)
		return
	if(user.mind.assigned_role == "Inquisitor")
		inquisitor = TRUE

	if(!M.mind) //Stopping null lookup runtimes
		to_chat(user, span_warning("[M] does not have the mind to benefit from the holy anointment."))
		return

	if(HAS_TRAIT(M, TRAIT_SILVER_BLESSED))
		to_chat(user, span_warning("Upon closer inspection, [M] is already anointed with quicksilver."))
		return

	if(!inquisitor && !user.mind.get_skill_level(/datum/skill/magic/holy) >= SKILL_EXP_EXPERT)
		to_chat(user, span_warning("I do not have the divine knowledge to properly apply [src]."))
		return

	if(user == M)
		to_chat(user, span_warning("I cannot anoint myself with this. I must find someone else to perform the rites."))
		return
	
	if(M.stat == DEAD)
		to_chat(user, span_warning("With their heart stilled, the ritual will have no purchase upon them. It would be a waste."))
		return

	var/found = null
	for(var/obj/structure/fluff/psycross/S in oview(5, user))
		found = S
	if(!found)
		to_chat(user, span_warning("I need a holy cross nearby to properly apply this.")) //Like Anastasis
		return

	var/datum/antagonist/werewolf/Were = M.mind.has_antag_datum(/datum/antagonist/werewolf/)
	var/datum/antagonist/werewolf/lesser/Wereless = M.mind.has_antag_datum(/datum/antagonist/werewolf/lesser/)
	var/datum/antagonist/vampirelord/Vamp = M.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/vampirelord/lesser/Vampless = M.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)

	user.visible_message(span_notice("[user] begins to anoint [M] with [src]."))
	if(do_after(user, 10 SECONDS, target = M))
		if(!Were && !Vamp)
			user.visible_message(span_notice("[user] anoints [M]'s brow with [src]."))
			ADD_TRAIT(M, TRAIT_SILVER_BLESSED, TRAIT_GENERIC)
			success = 1
		else
			to_chat(M, span_userdanger("This silver concoction burns! It threatens to undo me!"))
			M.emote("agony", forced = TRUE)
			M.adjustFireLoss(25)
			M.fire_act(3,3) //Not too bad, but not a single pat to put out.
			user.visible_message(span_danger("[src] bursts into flames on [M]'s brow, yet [user] vies to complete the anointment."))
			if(do_after(user, 10 SECONDS, target = M))
				user.visible_message(span_danger("[user] anoints [M]'s brow with [src]."))
				success = 1
	if(!success)
		return

	//Delete the item, or if you're the inquisitor, you squeeze another dose out of it.
	miracle_use += 1
	if((miracle_use && !inquisitor) || miracle_use > 1)
		to_chat(user, span_notice("That's all of the poultice. Only the binding cloth remains."))
		new /obj/item/natural/cloth(user.loc)
		qdel(src)
	else
		to_chat(user, span_notice("My inquisitorial training allows just enough of the poultice left for one more anointment."))

	//Werewolf deconversion
	if(Were && !Wereless) //The roundstart elder/alpha werewolf, it cannot be saved
		to_chat(M, span_userdanger("This wretched silver weighs heavy on my brow. This accurse shall not be quit of me so easily."))
		user.visible_message(span_danger("The silver poultice boils away from [M]'s brow, viscerally rejecting the divine anointment."))
		M.Stun(30)
		M.Knockdown(30)
		return

	else if(Wereless) //A lesser werewolf can be deconverted
		if(Were.transformed == TRUE)
			var/mob/living/carbon/human/I = M.stored_mob
			to_chat(M, span_userdanger("THE FOUL SILVER! MY BODY RENDS ITSELF ASUNDER!"))
			M.werewolf_untransform()
			Were.on_removal()
			ADD_TRAIT(I, TRAIT_SILVER_BLESSED, TRAIT_GENERIC)
			I.emote("agony", forced = TRUE)
			I.Stun(30)
			I.Knockdown(30)
			I.Jitter(30)
			return
		else
			M.flash_fullscreen("redflash3")
			M.emote("agony", forced = TRUE)
			to_chat(M, span_userdanger("THE FOUL SILVER! IT BURNS ME TO MY CORE!"))
			Were.on_removal()
			ADD_TRAIT(M, TRAIT_SILVER_BLESSED, TRAIT_GENERIC)
			M.Stun(30)
			M.Knockdown(30)
			M.Jitter(30)
			return

	else if(Vamp && !Vampless) //We're the vampire lord, we can't be saved.
		to_chat(M, span_userdanger("This wretched silver weighs heavy on my brow. An insult I shall never forget, for as long as I die."))
		user.visible_message(span_danger("The silver poultice boils away from [M]'s brow, viscerally rejecting the divine anointment."))
		M.Stun(30)
		M.Knockdown(30)
		return
	
	else if(Vampless) //Lesser vampires being saved
		M.mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
		var/obj/item/organ/eyes/eyes = M.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(M,1)
			QDEL_NULL(eyes)
			eyes = new /obj/item/organ/eyes/
			eyes.Insert(M)
		M.skin_tone = Vampless.cache_skin
		M.hair_color = Vampless.cache_hair
		M.facial_hair_color = Vampless.cache_hair 
		M.eye_color = Vampless.cache_eyes
		M.update_body()
		M.update_hair()
		M.update_body_parts(redraw = TRUE)
		Vampless.on_removal()
		M.mind.special_role = null
		M.emote("agony", forced = TRUE)
		to_chat(M, span_userdanger("THE FOUL SILVER! IT QUICKENS MY HEART!"))
		REMOVE_TRAIT(M, TRAIT_NOROGSTAM, "/datum/antagonist/vampirelord/lesser")
		REMOVE_TRAIT(M, TRAIT_NOSLEEP, "/datum/antagonist/vampirelord/lesser")
		REMOVE_TRAIT(M, TRAIT_NOBREATH, "/datum/antagonist/vampirelord/lesser")
		REMOVE_TRAIT(M, TRAIT_NOPAIN, "/datum/antagonist/vampirelord/lesser")
		REMOVE_TRAIT(M, TRAIT_NOHUNGER, "/datum/antagonist/vampirelord/lesser")
		REMOVE_TRAIT(M, TRAIT_TOXIMMUNE, "/datum/antagonist/vampirelord/lesser")
		REMOVE_TRAIT(M, TRAIT_VAMP_DREAMS, "/datum/antagonist/vampirelord/lesser")
		REMOVE_TRAIT(M, TRAIT_HEAVYARMOR, "/datum/antagonist/vampirelord/lesser")
		REMOVE_TRAIT(M, TRAIT_STEELHEARTED, "/datum/antagonist/vampirelord/lesser")
		M.verbs -= /mob/living/carbon/human/proc/disguise_button
		M.verbs -= /mob/living/carbon/human/proc/vampire_telepathy
		M.verbs -= /mob/living/carbon/human/proc/vamp_regenerate
		M.RemoveSpell(/obj/effect/proc_holder/spell/targeted/transfix)
		ADD_TRAIT(M, TRAIT_SILVER_BLESSED, TRAIT_GENERIC)
		M.Stun(30)
		M.Knockdown(30)
		M.Jitter(30)
		return


/obj/item/quicksilver/pickup(mob/user) //Akin to the psycross.
	. = ..()
	var/mob/living/carbon/human/H = user
	if(!H.mind)
		return
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	if(ishuman(H))
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(20)
			H.adjustFireLoss(60)
			H.Paralyze(20)
			H.fire_act(1,5)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
				H.Knockdown(10)
				H.adjustFireLoss(25)
		if(W && W.transformed == TRUE)
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
