/datum/patron/peoples_pantheon
	name = null
	associated_faith = /datum/faith/peoples_pantheon
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/peoples_pantheon/cinella
	name = "Cinella"
	domain = "Seas, Storms, Fortune, Adventure, and Longing"
	desc = "Impartial to the point of being called cruel, Cinella is the Goddess of seas and tides - of gamblers and wanderers, \
			who choose to take risks and who choose to wander into realms forgotten or never before seen. It it unto her that \
			sailors pray, both for good tides and good hauls, for clear skies and clear waters, in gambling dens and bars the \
			world over. She has been known as well as a goddess of melancholy: eternally bound by her love of Zira, the Moon, \
			yet fated never to meet - a mourning that permeates the rains of autumn and the sighing winds of winter. Cinella is \
			the Goddess of those who yearn for the light just out of reach, eternally, knowing they may never reach it."
	worshippers = "Sea-farers, Fishermen, Lovers, and the Refracted"
	mob_traits = list(TRAIT_CINELLA_SWIM, TRAIT_SEA_DRINKER)
	t1 = /obj/effect/proc_holder/spell/invoked/cinella_bends
	t2 = /obj/effect/proc_holder/spell/invoked/abyssheal
	t3 = /obj/effect/proc_holder/spell/invoked/call_mossback

/datum/patron/peoples_pantheon/carthus
	name = "Carthus"
	domain = "War, Instinct, Justice, Dance"
	desc = "Among other war-gods, Carthus' cult drove him steadily to the forefront of his 'peers', and it was in the fires of the \
	Dusk War that he rose as the only of his title. Carthus, though war-god, does not seek it; Carthus' domain is the instinctual, \
	the training that drives action to repetition to experience, the intermingling of conscious thought and subconscious drive into \
	the apotheosis of oneself in the pursuit of what one believes in. Instinct is to be tempered by discipline, sharpened by will, and \
	turned against the darkness that would see one's life crushed underfoot - be that a physical enemy, a vice turned unto oneself, or a \
	challenge one sees as insurmountable. Conquest takes many forms, and it is in the thundering of one's heart in one's ears, wherein their \
	pulse aligns with the thundering drum of their God's own heartbeat, that acolytes of Carthus find themselves at their strongest."
	worshippers = "Knights, Soldiers, Dancers, Those of Ambition, Those Who Train."
	mob_traits = list(TRAIT_SHARPER_BLADES, TRAIT_JUSTICARSIGHT)
	t1 = /obj/effect/proc_holder/spell/self/divine_strike
	t2 = /obj/effect/proc_holder/spell/self/call_to_arms
	t3 = /obj/effect/proc_holder/spell/invoked/persistence

/datum/patron/peoples_pantheon/varielle
	name = "Varielle"
	domain = "Harmony, Music, Hearth, Healing, and Love"
	desc = "Amongst the many mighty gods of the Light, none are more humble than the songstress Varielle, goddess of home, healing, and love. \
			Known as the most compassionate of the Nine, her gentility and affection for mortalkind almost motherly, she has seen fit to bear \
			herself as a caretaker of the lands her tender gaze watches over. She is the song of passion in one's heart; she is the impulse of \
			compassion and generosity that turns one's hand; she is the mercy and sensitivity towards the sick and the dying. Hers' is the \
			smouldering flame of love for others; love of the world, love of mortalkind, love of life, love of song, love of family, and the \
			love between romantics - a declaration that life is to be lived to its fullest in service of others, and that the truest self is \
			one that is kind."
	worshippers = "Caretakers, Bards, Minstrels, Healers, Homebodies, and Lovers."
	mob_traits = list(TRAIT_VARIELLE, TRAIT_EMPATH, TRAIT_EXTEROCEPTION)
	t1 = /obj/effect/proc_holder/spell/invoked/bud
	t2 = /obj/effect/proc_holder/spell/invoked/variellecurse
	t3 = null
