/datum/patron/three_sisters
	name = null
	associated_faith = /datum/faith/three_sisters
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/three_sisters/tamari
	name = "Tamari"
	domain = "Whimsical Goddess of the Wild"
	desc = "Placeholder"
	worshippers = "Placeholder Description - Tamari serves as faithful watchman over the circles and cycles that comprise all life."
	mob_traits = list(TRAIT_KNEESTINGER_IMMUNITY, TRAIT_LEECHIMMUNE)
	t1 = /obj/effect/proc_holder/spell/targeted/blesscrop
	t2 = /obj/effect/proc_holder/spell/self/tamari_shapeshift
	t3 = /obj/effect/proc_holder/spell/targeted/conjure_glowshroom
	t4 = /obj/effect/proc_holder/spell/self/howl/call_of_the_moon

/datum/patron/three_sisters/nunos
	name = "Nunos"
	domain = "Contested God of Toil"
	desc = "Placeholder Description - Nunos is split apart into three divergent interpretations. The human-borne interpretation considers Nunos \
	to be the god of Technology, Alchemy, Industry, Forces, Toil, and Metal - the elven-borne interpretation, Nuvelle, is the god of Fire, Renewal, \
	Transformation, Rebirth, and Toil - and the dwarven-borne interpretation, Nardám, is the god of Fire, Metallurgy, Craftsdwarfship, Industry, Hammers, \
	and Toil. Nunos' exact place in the balance pantheon is heavily debated, as is their details - being the only one incapable of verbal communion with mortals."
	worshippers = "Artisans, Mages, The Reformed, Thugs and Smithys"
	mob_traits = list(TRAIT_FORGEBLESSED, TRAIT_BETTER_SLEEP)
	t1 = /obj/effect/proc_holder/spell/invoked/vigorousexchange
	t2 = /obj/effect/proc_holder/spell/invoked/heatmetal
	t3 = /obj/effect/proc_holder/spell/invoked/hammerfall
	t4 = /obj/effect/proc_holder/spell/invoked/craftercovenant
	extra_spell = /obj/effect/proc_holder/spell/invoked/nunos_flame_rogue

/datum/patron/three_sisters/kasmidian
	name = "Kasmidian"
	domain = "Enchanting Goddess of the Arcane"
	desc = "Placeholder Description - Kasmidian serves as the keeper of all knowledge arcane."
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_KASMIDIAN)
	t1 = /obj/effect/proc_holder/spell/invoked/wheel
	t2 = /obj/effect/proc_holder/spell/invoked/mockery
