/datum/patron/light
	name = null
	associated_faith = /datum/faith/divine
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

/// all below will be chaos in a bit i gotta work on order rn

/datum/patron/light/dendor
	name = "Placeholder Name"
	domain = "God of Life and Nature"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_KNEESTINGER_IMMUNITY, TRAIT_LEECHIMMUNE)
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/self/dendor_shapeshift
	t3 = /obj/effect/proc_holder/spell/targeted/conjure_glowshroom
	t4 = /obj/effect/proc_holder/spell/self/howl/call_of_the_moon
	confess_lines = list(
		"DENDOR PROVIDES!",
		"THE TREEFATHER BRINGS BOUNTY!",
		"I ANSWER THE CALL OF THE WILD!",
	)

/datum/patron/light/cinella
	name = "Cinella"
	domain = "Goddess of the Seas"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_ABYSSOR_SWIM, TRAIT_SEA_DRINKER)
	t1 = /obj/effect/proc_holder/spell/invoked/abyssor_bends
	t2 = /obj/effect/proc_holder/spell/invoked/abyssheal
	t3 = /obj/effect/proc_holder/spell/invoked/call_mossback
	confess_lines = list(
		"CINELLA COMMANDS THE WAVES!",
		"THE OCEAN'S FURY IS CINELLA'S WILL!",
		"I AM DRAWN BY THE PULL OF THE TIDE!",
	)

/datum/patron/light/xylix
	name = "Placeholder"
	domain = "God of Primordial Magic"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_XYLIX)
	t1 = /obj/effect/proc_holder/spell/invoked/wheel
	t2 = /obj/effect/proc_holder/spell/invoked/mockery
	confess_lines = list(
		"ASTRATA IS MY LIGHT!",
		"NOC IS NIGHT!",
		"DENDOR PROVIDES!",
		"ABYSSOR COMMANDS THE WAVES!",
		"RAVOX IS JUSTICE!",
		"ALL SOULS FIND THEIR WAY TO NECRA!",
		"HAHAHAHA! AHAHAHA! HAHAHAHA!",
		"MALUM IS MY MUSE!",
		"EORA BRINGS US TOGETHER!",
	)
