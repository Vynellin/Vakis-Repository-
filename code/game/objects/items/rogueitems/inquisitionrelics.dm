// Reliquary Box and key - The Box Which contains these
/obj/structure/reliquarybox
	name = "Otavan Reliquary"
	desc = "A foreboding red chest with a intricate lock design. It seems to only fit a very specific key. Choose wisely."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "chestweird1"
	anchored = TRUE
	density = TRUE
	var/opened = FALSE

/obj/item/roguekey/psydonkey
	icon_state = "birdkey"
	name = "Reliquary Key"
	desc = "The single use key with which to unleash woe. Choose wisely."

/obj/structure/reliquarybox/attackby(obj/item/W, mob/user, params)
	if(ishuman(user))
		if(istype(W, /obj/item/roguekey/psydonkey))
			if(opened)
				to_chat(user, span_info("The reliquary box has already been opened..."))
				return
			qdel(W)
			to_chat(user, span_info("The reliquary lock takes my key as it opens, I take a moment to ponder what power was delivered to us..."))
			playsound(loc, 'sound/foley/doors/lock.ogg', 60)
			to_chat(user,)
			var/relics = list("Melancholic Crankbox - Antimagic", "Daybreak - Silver Whip","Inquistorial Armory - Weapons",)
			var/relicchoice = input(user, "Choose your tool", "RELICS") as anything in relics
			switch(relicchoice)
				if("Melancholic Crankbox - Antimagic")
					user.put_in_hands(new /obj/item/psydonmusicbox(user))
				if("Daybreak - Silver Whip")
					user.put_in_hands(new /obj/item/rogueweapon/whip/antique/psywhip(user))
				if("Inquistorial Armory - Weapons")
					user.put_in_hands(new /obj/structure/closet/crate/chest/inqarmory)
			to_chat(user, span_info("I retrieve the relic, may HE guide my hand."))
			opened = TRUE
			icon_state = "chestweird1open"
			

// Soul Churner - Music box which applies magic resistance to Inquisition members, greatly mood debuffs everyone not a Psydon worshipper.
/obj/item/psydonmusicbox
	name = "melancholic crankbox"
	desc = ""
	icon_state = "psydonmusicbox"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_HUGE
	var/cranking = FALSE
	force = 15
	max_integrity = 100
	attacked_sound = 'sound/combat/hits/onwood/education2.ogg'
	gripped_intents = list(/datum/intent/hit)
	possible_item_intents = list(/datum/intent/hit)
	obj_flags = CAN_BE_HIT
	twohands_required = TRUE
	var/datum/looping_sound/psydonmusicboxsound/soundloop

/obj/item/psydonmusicbox/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(usr, TRAIT_INQUISITION))
		desc = "A relic from the bowels of the Otavan cathedral's thaumaturgical workshops. Fourteen souls of heretics, all bound together, they will scream and protect us from magicks. It would be wise to not teach the heretics of its true nature, to only bring it to bear in dire circumstances."
	else
		desc = "A cranked music box, it has the seal of the Otavan Inquisition on the side. It carries a somber feeling to it..."

/obj/item/psydonmusicbox/attack_self(mob/living/user)
	. = ..()
	if(!HAS_TRAIT(usr, TRAIT_INQUISITION))
		user.add_stress(/datum/stressevent/soulchurnerhorror)
		to_chat(user, (span_cultsmall("I FEEL SUFFERING WITH EVERY CRANK, WHAT AM I DOING?!")))
	cranking = !cranking
	update_icon()
	if(cranking)
		user.apply_status_effect(/datum/status_effect/buff/cranking_soulchurner)
		soundloop.start()
		var/songhearers = view(7, user)
		for(var/mob/living/carbon/human/target in songhearers)
			to_chat(target,span_cultsmall("[user] begins cranking the soul churner..."))
	if(!cranking)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/cranking_soulchurner)

/obj/item/psydonmusicbox/Initialize()
	soundloop = new(src, FALSE)
	. = ..()

/obj/item/psydonmusicbox/Destroy()
	if(soundloop)
		QDEL_NULL(soundloop)
	src.visible_message(span_cult("A great deluge of souls escapes the shattered box!"))
	return ..()

/obj/item/psydonmusicbox/update_icon()
	if(cranking)
		icon_state = "psydonmusicbox_active"
	else
		icon_state = "psydonmusicbox"

/obj/item/psydonmusicbox/dropped(mob/living/user, silent)
	..()
	cranking = FALSE
	update_icon()
	if(soundloop)
		soundloop.stop()
		user.remove_status_effect(/datum/status_effect/buff/cranking_soulchurner)

/obj/item/psydonmusicbox/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6,"sx" = -1,"sy" = 0,"nx" = 11,"ny" = 1,"wx" = 0,"wy" = 1,"ex" = 4,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 15,"sturn" = 0,"wturn" = 0,"eturn" = 39,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 8)

/atom/movable/screen/alert/status_effect/buff/cranking_soulchurner
	name = "Cranking Soulchurner"
	desc = "I am bringing the twisted device to life..."
	icon_state = "buff"

/datum/status_effect/buff/cranking_soulchurner
	id = "crankchurner"
	alert_type = /atom/movable/screen/alert/status_effect/buff/cranking_soulchurner
	var/effect_color
	var/pulse = 0
	var/ticks_to_apply = 10
	var/aeternianlines =list("'HIS LIGHT HAS LEFT ME! WHERE AM I?!'", "'SHATTER THIS CONTRAPTION, SO I MAY FEEL HIS WARMTH ONE LAST TIME!'", "'I am royal.. Why did they do this to me...?'")
	var/ziralines =list("'Colder than moonlight...'", "'No wisdom can reach me here...'", "'Please help me, I miss the stars...'")
	var/tsoridyslines =list("'They snatched me from her grasp, for eternal torment...'", "'Tsoridys! Please! I am so tired! Release me!'", "'I am lost, lost in a sea of stolen ends.'")
	var/cinellalines =list("'I cannot feel the coast's breeze...'", "'We churn tighter here than schooling fish...'", "'Free me, please, so I may return to the sea...'")
	var/carthuslines =list("'Free me from this damnable witchery!'", "'There is no justice nor glory to be found here, just endless fatigue...'", "'I begged for a death by the sword...'")
	var/variellelines =list("'Every caress feels like a thousand splintering bones...'", "'She was a monster, but how could I hurt her?!'", "'I'm sorry! I only wanted peace! Please release me!'")
	var/tamarilines =list("'HIS BOUNTY CALLS FOR ME! RRGHNN...'", "'SHATTER THIS BOX, SO WE MAY CHOKE THIS OTAVAN ON DIRT AND ROOTS!'", "'I miss His voice in the leaves... Free me, please...'")
	var/kasmidianlines =list("'THEY TOOK MY SIGHT, MY KNOWLEDGE AND STRIFE.'", "'NOTHING TO BE LEARNED SITS HERE.'", "'I WOULD HAVE PREFERED TO BE RENDED ASUNDER.'", "'A NIGHTMARE.'")
	var/nunoslines =list("'The structure of this cursed machine is malleable.. Shatter it, please...'", "'My craft could've changed the world...'", "'Free me, so I may return to my apprentice, please...'")


/datum/status_effect/buff/cranking_soulchurner/on_creation(mob/living/new_owner, stress, colour)
	effect_color = "#800000"
	return ..()

/datum/status_effect/buff/cranking_soulchurner/tick()
	var/obj/effect/temp_visual/music_rogue/M = new /obj/effect/temp_visual/music_rogue(get_turf(owner))
	M.color = "#800000"
	pulse += 1
	if (pulse >= ticks_to_apply)
		pulse = 0
		if(!HAS_TRAIT(owner, TRAIT_INQUISITION))
			owner.add_stress(/datum/stressevent/soulchurnerhorror)
		for (var/mob/living/carbon/human/H in hearers(7, owner))
			if (!H.client)
				continue
			if (!H.has_stress_event(/datum/stressevent/soulchurner))
				switch(H.patron?.type)
					if(/datum/patron/light/aeternus)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(aeternianlines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/order/zira)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(ziralines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/order/tsoridys)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(tsoridyslines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/order/nunos)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(nunoslines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/chaos/tamari)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(tamarilines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/chaos/kasmidian)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(kasmidianlines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/order/varielle)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(variellelines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/chaos/cinella)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(cinellalines))))
						H.add_stress(/datum/stressevent/soulchurner)
					if(/datum/patron/order/carthus)
						to_chat(H, (span_hypnophrase("A voice calls out from the song for you...")))
						to_chat(H, (span_cultsmall(pick(carthuslines))))		
						H.add_stress(/datum/stressevent/soulchurner)

//Inquisitorial armory down here

/obj/structure/closet/crate/chest/inqarmory

/obj/structure/closet/crate/chest/inqarmory/PopulateContents()
	.=..()
	new /obj/item/rogueweapon/huntingknife/idagger/silver/psydagger(src)
	new /obj/item/rogueweapon/greatsword/psygsword(src)
	new /obj/item/rogueweapon/halberd/psyhalberd(src)
	new /obj/item/rogueweapon/spear/psyspear(src)
	new /obj/item/rogueweapon/sword/long/psysword(src)
	new /obj/item/rogueweapon/mace/goden/psymace(src)
	new /obj/item/rogueweapon/stoneaxe/silver/psyaxe(src)
