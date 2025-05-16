/obj/structure/ritualcircle
	name = "ritual circle"
	desc = ""
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "ritual_base"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/ritualcircle/attack_right(mob/living/carbon/human/user)
	user.visible_message(span_warning("[user] begins wiping away the rune"))
	if(do_after(user, 15))
		playsound(loc, 'sound/foley/cloth_wipe (1).ogg', 100, TRUE)
		qdel(src)

/obj/structure/ritualcircle/aeternus
	name = "Rune of the Sun" 
	icon_state = "astrata_chalky" // Ensure your icon state has an active / inactive state, should it call them. 
	desc = "The holy rune of Aeternus; god of the sun."
	/// Valid options for rites to perform on this ritual circle.
	var/solarrites = list("Guiding Light")

/obj/structure/ritualcircle/aeternus/attack_hand(mob/living/user) 
	if((user.patron?.type) != /datum/patron/light/aeternus)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this...")) // You need ritualist to use them
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more.")) // If you have already done a ritual in the last 30 minutes, you cannot do another.
		return
	var/riteselection = input(user, "Rituals of the Sun", src) as null|anything in solarrites // When you use a open hand on a rune, It'll give you a selection of all the rites available from that rune
	switch(riteselection) // rite selection goes in this section, try to do something fluffy. Presentation is most important here, truthfully.
		if("Guiding Light") // User selects Guiding Light, begins the stuff for it
			if(do_after(user, 50)) // just flavor stuff before activation
				user.say("I beseech the light the formed us!")
				if(do_after(user, 50))
					user.say("To bring gaze down upon us mortals!!")
					if(do_after(user, 50))
						user.say("Place your gaze upon me, oh Radiant one!!")
						to_chat(user,span_danger("You feel the eye of Aeternus turned upon you, stoic; though warm...")) // A bunch of flavor stuff, slow incanting.
						icon_state = "astrata_active"
						if(!HAS_TRAIT(user, TRAIT_CHOSEN)) //Priests don't burst into flames.
							loc.visible_message(span_warning("[user] bursts into flames, embraced by his warmth wholly!"))
							playsound(loc, 'sound/combat/hits/burn (1).ogg', 100, FALSE, -1)
							user.adjust_fire_stacks(10)
							user.IgniteMob()
							user.flash_fullscreen("redflash3")
							user.emote("firescream")
						guidinglight(src) // Actually starts the proc for applying the buff
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
						spawn(120)
							icon_state = "astrata_chalky"

/obj/structure/ritualcircle/aeternus/proc/guidinglight(src)
	var/ritualtargets = view(7, loc) // Range of 7 from the source, which is the rune
	for(var/mob/living/carbon/human/target in ritualtargets) // defines the target as every human in this range
		target.apply_status_effect(/datum/status_effect/buff/guidinglight) // applies the status effect
		to_chat(target,span_cultsmall("Aeternus' light guides me forward, drawn to me in my time of need!"))
		playsound(target, 'sound/magic/holyshield.ogg', 80, FALSE, -1) // Cool sound!
// If you want to review a more complicated one, Undermaiden's Bargain is probs the most complicated of the starting set. - Have fun! - Onutsio 🏳️‍⚧️


/obj/structure/ritualcircle/zira
	name = "Rune of the Moon"
	icon_state = "noc_chalky"
	desc = "A Holy Rune of Zira"
	var/lunarrites = list("Moonlight Dance") // list for more to be added later

/obj/structure/ritualcircle/zira/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/balance/zira)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of the Moon", src) as null|anything in lunarrites
	switch(riteselection) // put ur rite selection here
		if("Moonlight Dance")
			if(do_after(user, 50))
				user.say("I beseech the goddess of twilight's end!!")
				if(do_after(user, 50))
					user.say("Bring now, upon me, your light and refraction!!")
					if(do_after(user, 50))
						user.say("Place your gaze upon me, oh hallowed one!!")
						to_chat(user,span_cultsmall("I feel the chill of the night creep against me... her gaze now affixed upon me."))
						playsound(loc, 'sound/magic/holyshield.ogg', 80, FALSE, -1)
						moonlightdance(src)
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)

/obj/structure/ritualcircle/zira/proc/moonlightdance(src)
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/moonlightdance)

/obj/structure/ritualcircle/kasmidian
	name = "Rune of Pryamore"
	desc = "A Holy Rune of Kasmidian"

/obj/structure/ritualcircle/carthus
	name = "Rune of the Warrior"
	desc = "A Holy Rune of Carthus"

/obj/structure/ritualcircle/tamari
	name = "Rune of Beasts"
	desc = "A Holy Rune of Tamari"
	icon_state = "dendor_chalky"
	var/bestialrites = list("Rite of the Lesser Wolf")

/obj/structure/ritualcircle/tamari/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/change/tamari)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Beasts", src) as null|anything in bestialrites
	switch(riteselection) // put ur rite selection here
		if("Rite of the Lesser Wolf")
			if(do_after(user, 50))
				user.say("RRRGH GRRRHHHG GRRRRRHH!!")
				playsound(loc, 'sound/vo/mobs/vw/idle (1).ogg', 100, FALSE, -1)
				if(do_after(user, 50))
					user.say("GRRRR GRRRRHHHH!!")
					playsound(loc, 'sound/vo/mobs/vw/idle (4).ogg', 100, FALSE, -1)
					if(do_after(user, 50))
						loc.visible_message(span_warning("[user] snaps and snarls at the rune. Drool runs down their lip..."))
						playsound(loc, 'sound/vo/mobs/vw/bark (1).ogg', 100, FALSE, -1)
						if(do_after(user, 30))
							icon_state = "dendor_active"
							loc.visible_message(span_warning("[user] snaps their head upward, they let out a howl!"))
							playsound(loc, 'sound/vo/mobs/wwolf/howl (2).ogg', 100, FALSE, -1)
							lesserwolf(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							spawn(120)
								icon_state = "dendor_chalky"

/obj/structure/ritualcircle/tamari/proc/lesserwolf(src)
	var/ritualtargets = view(1, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/lesserwolf)


/obj/structure/ritualcircle/nunos
	name = "Rune of Forge"
	desc = "A Holy Rune of Nunos"

/obj/structure/ritualcircle/cinella
	name = "Rune of Storm"
	desc = "A Holy Rune of Cinella"

/obj/structure/ritualcircle/tsoridys
	name = "Rune of Death"
	desc = "A Holy Rune of Tsoridys"
	icon_state = "necra_chalky"
	var/deathrites = list("Undermaiden's Bargain")

/obj/structure/ritualcircle/tsoridys/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/balance/tsoridys)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Death", src) as null|anything in deathrites
	switch(riteselection) // put ur rite selection here
		if("Undermaiden's Bargain")
			loc.visible_message(span_warning("[user] sways before the rune, they open their mouth, though no words come out..."))
			playsound(user, 'sound/vo/mobs/ghost/whisper (3).ogg', 100, FALSE, -1)
			if(do_after(user, 60))
				loc.visible_message(span_warning("[user] silently weeps, yet their tears do not flow..."))
				playsound(user, 'sound/vo/mobs/ghost/whisper (1).ogg', 100, FALSE, -1)
				if(do_after(user, 60))
					loc.visible_message(span_warning("[user] locks up, as though someone had just grabbed them..."))
					to_chat(user,span_danger("You feel cold breath on the back of your neck..."))
					playsound(user, 'sound/vo/mobs/ghost/death.ogg', 100, FALSE, -1)
					if(do_after(user, 20))
						icon_state = "necra_active"
						user.say("Forgive me, the bargain is intoned!!")
						to_chat(user,span_cultsmall("My devotion to the Undermaiden has allowed me to strike a bargain for these souls...."))
						playsound(loc, 'sound/vo/mobs/ghost/moan (1).ogg', 100, FALSE, -1)
						undermaidenbargain(src)
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
						spawn(120)
							icon_state = "necra_chalky"

/obj/structure/ritualcircle/tsoridys/proc/undermaidenbargain(src)
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/undermaidenbargain)
	

/obj/structure/ritualcircle/varielle
	name = "Rune of Love"
	desc = "A Holy Rune of Varielle"
	icon_state = "eora_chalky"

	var/peacerites = list("Rite of Pacification")

/obj/structure/ritualcircle/varielle/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/balance/varielle)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Love", src) as null|anything in peacerites
	switch(riteselection)
		if("Rite of Pacification")
			if(do_after(user, 50))
				user.say("#Blessed be your weary head...")
				if(do_after(user, 50))
					user.say("#Full of strife and pain...")
					if(do_after(user, 50))
						user.say("#Let Her ease your fear...")
						if(do_after(user, 50))
							icon_state = "eora_active"
							pacify(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							spawn(120)
								icon_state = "eora_chalky"

/obj/structure/ritualcircle/varielle/proc/pacify(src)
	var/ritualtargets = view(0, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		loc.visible_message(span_warning("[target] sways like windchimes in the wind..."))
		target.visible_message(span_green("I feel the burdens of my heart lifting. Something feels very wrong... I don't mind at all..."))
		target.apply_status_effect(/datum/status_effect/buff/pacify)
