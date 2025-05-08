/datum/patron/chaos
	name = null
	associated_faith = /datum/faith/chaos
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/chaos/tamari
	name = "Tamari"
	domain = "God of Life and Nature"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_KNEESTINGER_IMMUNITY, TRAIT_LEECHIMMUNE)
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/self/tamari_shapeshift
	t3 = /obj/effect/proc_holder/spell/targeted/conjure_glowshroom
	t4 = /obj/effect/proc_holder/spell/self/howl/call_of_the_moon
	confess_lines = list(
		"TAMARI GIFTS US!",
		"NATURE'S WILDS CALL TO ME!",
		"I ANSWER THE CALL OF THE WILD!",
	)

/datum/patron/chaos/cinella
	name = "Cinella"
	domain = "Goddess of the Seas"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_CINELLA_SWIM, TRAIT_SEA_DRINKER)
	t1 = /obj/effect/proc_holder/spell/invoked/cinella_bends
	t2 = /obj/effect/proc_holder/spell/invoked/abyssheal
	t3 = /obj/effect/proc_holder/spell/invoked/call_mossback
	confess_lines = list(
		"CINELLA COMMANDS THE WAVES!",
		"THE OCEAN'S FURY IS CINELLA'S WILL!",
		"I AM DRAWN BY THE PULL OF THE TIDE!",
	)

/datum/patron/chaos/kasmidian
	name = "Kasmidian"
	domain = "God of Primordial Magic"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_KASMIDIAN)
	t1 = /obj/effect/proc_holder/spell/invoked/wheel
	t2 = /obj/effect/proc_holder/spell/invoked/mockery
	confess_lines = list(
		"I SEEK KNOWLEDGE OF THE ARCANE!",
		"IN KASMIDIAN'S WAKE!",
		"I SEEK MASTERY OF THE ELEMENTS!!",
	)
