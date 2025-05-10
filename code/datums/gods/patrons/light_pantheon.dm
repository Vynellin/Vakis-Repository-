/datum/patron/light
	name = null
	associated_faith = /datum/faith/light
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/light/aeternus
	name = "Aeturnus"
	domain = "Ascendant; Sun, Fire, Light, Permanence, Justice, Hope, and Order"
	desc = "The Dawnfather, the Lord of Day, Aeternus is one half of the two Prime Deities alongside his Sister, Zira. \
			His domain is light, his voice is fire, and his word has been law among the kingdoms of the Dawn that rose \
			in his name from the shadows of the Dusk War. All life comes from the Sun, and it is back unto Him that we \
			give praise."
	worshippers = "Children of the Sun, the Hopeful, Optimists, Paladins, Farmers, and the Noble"
	mob_traits = list(TRAIT_APRICITY)
	t1 = /obj/effect/proc_holder/spell/invoked/sacred_flame_rogue
	t2 = /obj/effect/proc_holder/spell/invoked/heal
	t3 = /obj/effect/proc_holder/spell/invoked/revive
