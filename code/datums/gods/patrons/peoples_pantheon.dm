/datum/patron/peoples_pantheon
	name = null
	associated_faith = /datum/faith/peoples_pantheon
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/peoples_pantheon/cinella
	name = "Cinella"
	domain = "Goddess of the Seas"
	desc = "Placeholder Description - Cinella heads the change pantheon as the world's mirror to the stars above."
	worshippers = "Sea-farers, Fishermen, Lovers, and the Refracted"
	mob_traits = list(TRAIT_CINELLA_SWIM, TRAIT_SEA_DRINKER)
	t1 = /obj/effect/proc_holder/spell/invoked/cinella_bends
	t2 = /obj/effect/proc_holder/spell/invoked/abyssheal
	t3 = /obj/effect/proc_holder/spell/invoked/call_mossback

/datum/patron/peoples_pantheon/carthus
	name = "Carthus"
	domain = "God of War, Ambition, and Rule"
	desc = "Placeholder Description - Carthus guides the power mortals hold over each other, hand-in-hand with ambitions they hold to keep it."
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_SHARPER_BLADES, TRAIT_JUSTICARSIGHT)
	t1 = /obj/effect/proc_holder/spell/self/divine_strike
	t2 = /obj/effect/proc_holder/spell/self/call_to_arms
	t3 = /obj/effect/proc_holder/spell/invoked/persistence

/datum/patron/peoples_pantheon/varielle
	name = "Varielle"
	domain = "Goddess of Love, Music and Harmony"
	desc = "Placeholder Description - Varielle guides mortals and thought in lock-step, be it in wed or in echoes of music."
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_VARIELLE, TRAIT_EMPATH, TRAIT_EXTEROCEPTION)
	t1 = /obj/effect/proc_holder/spell/invoked/bud
	t2 = /obj/effect/proc_holder/spell/invoked/variellecurse
	t3 = null
