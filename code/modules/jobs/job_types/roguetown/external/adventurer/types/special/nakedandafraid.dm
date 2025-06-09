/// challenge class, spawns with no items at all
/datum/advclass/naked_and_afraid
	name = "Naked And Afraid"
	tutorial = "Whatever left you to the whims of the wild - Robbery or Choice, accost or salvation - you've been stranded on the edge of Sunmarch \
		with not even clothes to your name. A challenging survival experience awaits those who befall this fate..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/naked_and_afraid
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/naked_and_afraid/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind) // Adjust our skills to make building up less painful.
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
		H.change_stat("speed", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 2)
		H.change_stat("intelligence", -2) // You're in this for the long-haul, mechanically, at least.
