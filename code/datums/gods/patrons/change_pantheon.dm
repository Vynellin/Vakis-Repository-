/datum/patron/change
	name = null
	associated_faith = /datum/faith/change
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/change/tamari
	name = "Tamari"
	domain = "God of Life and Nature"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_KNEESTINGER_IMMUNITY, TRAIT_LEECHIMMUNE)
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/self/tamari_shapeshift
	t3 = /obj/effect/proc_holder/spell/targeted/conjure_glowshroom
	t4 = /obj/effect/proc_holder/spell/self/howl/call_of_the_moon

/datum/patron/change/cinella
	name = "Cinella"
	domain = "Goddess of the Seas"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_CINELLA_SWIM, TRAIT_SEA_DRINKER)
	t1 = /obj/effect/proc_holder/spell/invoked/cinella_bends
	t2 = /obj/effect/proc_holder/spell/invoked/abyssheal
	t3 = /obj/effect/proc_holder/spell/invoked/call_mossback

/datum/patron/change/kasmidian
	name = "Kasmidian"
	domain = "God of Primordial Magic"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_KASMIDIAN)
	t1 = /obj/effect/proc_holder/spell/invoked/wheel
	t2 = /obj/effect/proc_holder/spell/invoked/mockery
