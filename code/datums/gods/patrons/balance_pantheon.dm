/datum/patron/balance
	name = null
	associated_faith = /datum/faith/balance
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/balance/zira
	name = "Zira"
	domain = "Balance; The Moon, Masks, Secrets, Alteration, Nighttime, and Yearning"
	desc = "The Moonmaiden, the Lady of Night, Zira is one half of the two Prime Deities alongside her Brother, Aeternus. \
			Her domain is night, her voice moonlight, and her influence is that compassion and firmness, decorum and \
			self-actualization, has guided the hands of wizard, priest, ruler, and commoner alike, teaching that gentility \
			is just as necessary as might."
	worshippers = "Children of the Night, the Gentle, Caretakers, Secretkeepers, and Lovers"
	mob_traits = list(TRAIT_NIGHT_OWL, TRAIT_ZIRASIGHT)
	t1 = /obj/effect/proc_holder/spell/invoked/blindness/miracle
	t2 = /obj/effect/proc_holder/spell/invoked/invisibility/miracle

/datum/patron/balance/tsoridys
	name = "Tsoridys"
	domain = "Death; Time, and Entropy"
	desc = "Placeholder Description. Tsoridys shepherds the end of Tamari's reign on life, ensuring safe passage for mortals."
	worshippers = "Mourners, The World-Weary, Gravediggers & Burialmen"
	mob_traits = list(TRAIT_SOUL_EXAMINE, TRAIT_NOSTINK)	//No stink is generic but they deal with dead bodies so.. makes sense, I suppose?
	t1 = /obj/effect/proc_holder/spell/invoked/avert
	t2 = /obj/effect/proc_holder/spell/targeted/abrogation
	t3 = /obj/effect/proc_holder/spell/targeted/churn
	extra_spell = /obj/effect/proc_holder/spell/targeted/soulspeak

/datum/patron/balance/nunos
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

/datum/patron/balance/carthus
	name = "Carthus"
	domain = "God of War, Ambition, and Rule"
	desc = "Placeholder Description - Carthus guides the power mortals hold over each other, hand-in-hand with ambitions they hold to keep it."
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_SHARPER_BLADES, TRAIT_JUSTICARSIGHT)
	t1 = /obj/effect/proc_holder/spell/self/divine_strike
	t2 = /obj/effect/proc_holder/spell/self/call_to_arms
	t3 = /obj/effect/proc_holder/spell/invoked/persistence

/datum/patron/balance/varielle
	name = "Varielle"
	domain = "Goddess of Love, Music and Harmony"
	desc = "Placeholder Description - Varielle guides mortals and thought in lock-step, be it in wed or in echoes of music."
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_VARIELLE, TRAIT_EMPATH, TRAIT_EXTEROCEPTION)
	t1 = /obj/effect/proc_holder/spell/invoked/bud
	t2 = /obj/effect/proc_holder/spell/invoked/variellecurse
	t3 = null
