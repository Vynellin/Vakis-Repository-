/datum/advclass/drunkard
	name = "Gambler"
	tutorial = "You were a gambler, once - now held with only a bottle in-hand, you've staggered your way into Sunmarch for respite... yet the land \
				may offer you none."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/drunkard
	category_tags = list(CTAG_TOWNER)

/datum/outfit/job/roguetown/adventurer/drunkard/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		armor = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		backl = /obj/item/storage/backpack/rogue/satchel
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/clothing/mask/cigarette/rollie/cannabis
		beltl = /obj/item/flint
		backpack_contents = list(
							/obj/item/storage/pill_bottle/dice = 1,
							/obj/item/toy/cards/deck = 1,
							/obj/item/reagent_containers/glass/bottle/rogue/wine = 1,
							/obj/item/flashlight/flare/torch = 1,
							)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE) //Climbing into windows to steal drugs or booze.
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("intelligence", -2)
		H.change_stat("constitution", 1)
		H.change_stat("strength", 1)
		H.change_stat("fortune", 2)
