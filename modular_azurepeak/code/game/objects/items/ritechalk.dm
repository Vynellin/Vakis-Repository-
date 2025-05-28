/obj/item/ritechalk
	name = "Ritual Chalk"
	icon_state = "chalk"
	desc = "Simple white chalk. A useful tool for rites."
	icon = 'icons/roguetown/misc/rituals.dmi'
	w_class = WEIGHT_CLASS_TINY
	experimental_inhand = FALSE

/obj/item/ritechalk/attack_self(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user, span_smallred("I don't know what I'm doing with this..."))
		return

	var/ritechoices = list()
	switch (user.patron?.type)
		if(/datum/patron/lording_three/aeternus)
			ritechoices+="Rune of Sun"
		if(/datum/patron/lording_three/zira)
			ritechoices+="Rune of Moon"
		if(/datum/patron/three_sisters/tamari)
			ritechoices+="Rune of Beasts"
		if(/datum/patron/three_sisters/nunos)
			ritechoices+="Rune of Forge"
		if(/datum/patron/three_sisters/kasmidian)
			ritechoices+="Rune of Rifts"
		if(/datum/patron/lording_three/tsoridys)
			ritechoices+="Rune of Death"
		if(/datum/patron/peoples_pantheon/varielle)
			ritechoices+="Rune of Love"
		if(/datum/patron/peoples_pantheon/carthus)
			ritechoices+="Rune of War"
		if(/datum/patron/peoples_pantheon/cinella)
			ritechoices+="Rune of Storm"

	var/runeselection = input(user, "Which rune shall I inscribe?", src) as null|anything in ritechoices
	var/turf/step_turf = get_step(get_turf(user), user.dir)
	switch(runeselection)
		if("Rune of Sun")
			to_chat(user,span_cultsmall("I begin inscribing the rune of His Radiance..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/aeternus(step_turf)
		if("Rune of Moon")
			to_chat(user, span_cultsmall("I begin inscribing the rune of Her Wisdom"))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/zira(step_turf)
		if("Rune of Beasts")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her Madness"))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/tamari(step_turf)
		if("Rune of Forge")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her Craft..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/nunos(step_turf)
		if("Rune of Rifts")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her Rifts..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/kasmidian(step_turf)
		if("Rune of Death")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her Embrace..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/tsoridys(step_turf)
		if("Rune of Love")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her Love..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/varielle(step_turf)
		if("Rune of War")
			to_chat(user,span_cultsmall("I begin inscribing the rune of His Prowess..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/carthus(step_turf)
		if("Rune of Storm")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her Storm..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/cinella(step_turf)
