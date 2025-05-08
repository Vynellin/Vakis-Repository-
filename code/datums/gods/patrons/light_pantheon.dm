/datum/patron/light
	name = null
	associated_faith = /datum/faith/light
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/light/aeternus
	name = "Aeturnus"
	domain = "God of the Sun"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_APRICITY)
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/revive
	confess_lines = list(
		"AETERNUS' LIGHT!",
		"AETERNUS BLESS ALL!",
		"I SERVE THE GLORY OF THE SUN!",
	)
