/datum/patron/order
	name = null
	associated_faith = /datum/faith/order
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/order/zira
	name = "Zira"
	domain = "Goddess of the Moon"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_NIGHT_OWL, TRAIT_ZIRASIGHT)
	t1 = /obj/effect/proc_holder/spell/invoked/blindness/miracle
	t2 = /obj/effect/proc_holder/spell/invoked/invisibility/miracle
	confess_lines = list(
		"IN ZIRA'S GAZE!",
		"ZIRA HOLDS ALL!",
		"I SEEK THE MYSTERIES OF THE MOON!",
	)

/datum/patron/order/tsoridys
	name = "Tsoridys"
	domain = "God of Death, Time, and Entropy"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_SOUL_EXAMINE, TRAIT_NOSTINK)	//No stink is generic but they deal with dead bodies so.. makes sense, I suppose?
	t1 = /obj/effect/proc_holder/spell/invoked/avert
	t2 = /obj/effect/proc_holder/spell/targeted/abrogation
	t3 = /obj/effect/proc_holder/spell/targeted/churn
	extra_spell = /obj/effect/proc_holder/spell/targeted/soulspeak
	confess_lines = list(
		"ALL SOULS FIND THEIR WAY TO TSORIDYS' GRACE!",
		"I FEAR NOT THE GRASP OF DEATH!",
		"TSORIDYS WATCH ME ON THIS DAY!",
	)

/datum/patron/order/nunos
	name = "Nunos"
	domain = "Contested God of Toil"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_FORGEBLESSED, TRAIT_BETTER_SLEEP)
	t1 = /obj/effect/proc_holder/spell/invoked/vigorousexchange
	t2 = /obj/effect/proc_holder/spell/invoked/heatmetal
	t3 = /obj/effect/proc_holder/spell/invoked/hammerfall
	t4 = /obj/effect/proc_holder/spell/invoked/craftercovenant
	extra_spell = /obj/effect/proc_holder/spell/invoked/nunos_flame_rogue
	confess_lines = list(
		"MY WORK IS MY LIFE!",
		"TRUE VALUE IS IN THE TOIL!",
		"I AM AN INSTRUMENT OF CREATION!",
	)

/datum/patron/order/carthus
	name = "Carthus"
	domain = "God of War, Ambition, and Rule"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_SHARPER_BLADES, TRAIT_JUSTICARSIGHT)
	t1 = /obj/effect/proc_holder/spell/self/divine_strike
	t2 = /obj/effect/proc_holder/spell/self/call_to_arms
	t3 = /obj/effect/proc_holder/spell/invoked/persistence
	confess_lines = list(
		"CARTHUS IS JUSTICE!",
		"THROUGH STRIFE, GRACE!",
		"THROUGH PERSISTENCE, GLORY!",
	)

/datum/patron/order/varielle
	name = "Varielle"
	domain = "Goddess of Love, Music and Harmony"
	desc = "Placeholder"
	worshippers = "Placeholder"
	mob_traits = list(TRAIT_EMPATH, TRAIT_EXTEROCEPTION)
	t1 = /obj/effect/proc_holder/spell/invoked/bud
	t2 = /obj/effect/proc_holder/spell/invoked/variellecurse
	t3 = null
	confess_lines = list(
		"VARIELLE BRINGS US TOGETHER!",
		"HER BEAUTY IS EVEN IN THIS TORMENT!",
		"I LOVE YOU, EVEN AS YOU TRESPASS AGAINST ME!",
	)
