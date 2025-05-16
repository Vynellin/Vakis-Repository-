/datum/patron/lording_three
	name = null
	associated_faith = /datum/faith/lording_three
	t0 = /obj/effect/proc_holder/spell/invoked/lesser_heal

/datum/patron/lording_three/aeternus
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

/datum/patron/lording_three/zira
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

/datum/patron/lording_three/tsoridys
	name = "Tsoridys"
	domain = "Death; Time, and Entropy"
	desc = "Placeholder Description. Tsoridys shepherds the end of Tamari's reign on life, ensuring safe passage for mortals."
	worshippers = "Mourners, The World-Weary, Gravediggers & Burialmen"
	mob_traits = list(TRAIT_SOUL_EXAMINE, TRAIT_NOSTINK)	//No stink is generic but they deal with dead bodies so.. makes sense, I suppose?
	t1 = /obj/effect/proc_holder/spell/invoked/avert
	t2 = /obj/effect/proc_holder/spell/targeted/abrogation
	t3 = /obj/effect/proc_holder/spell/targeted/churn
	extra_spell = /obj/effect/proc_holder/spell/targeted/soulspeak
