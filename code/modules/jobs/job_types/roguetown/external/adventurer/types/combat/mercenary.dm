/// DEFINES FOR NAMES AND DESCRIPTIONS ///
#define CLASS_CAVE_DWELLER "Cave Dweller"
#define CLASS_CAVE_DWELLER_DESC "You hail from a husk of a once-great dusk elven city, from the undergrowth."
#define CLASS_WOODLAND_RANGER "Woodland Ranger"
#define CLASS_WOODLAND_RANGER_DESC "You hail from a line of woodland-faring rangers, in the times of the Dusk War."
#define CLASS_UNERRED_SWORDSMAN "Unerred Swordsman"
#define CLASS_UNERRED_SWORDSMAN_DESC "You've trained on years as an unaffiliated mercenary, having gotten all-the used to being the hunter." // yet as one hunts, so is he hunted in kind

/datum/advclass/mercenary
	name = "Mercenary"
	tutorial = "Mercenaries are highly specialized warriors with a central gimmick - and a passion for hunting sunmarks." // YOU'RE NOT A HERO, VARIK... YOU KILL PEOPLE FOR MONEY
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/mercenary
	category_tags = list(CTAG_ADVENTURER, CTAG_COURTAGENT)
	traits_applied = list(TRAIT_OUTLANDER)
	classes = list( \
					CLASS_CAVE_DWELLER = CLASS_CAVE_DWELLER_DESC, \
					CLASS_WOODLAND_RANGER = CLASS_WOODLAND_RANGER_DESC, \
					CLASS_UNERRED_SWORDSMAN = CLASS_UNERRED_SWORDSMAN_DESC, \
				)

/datum/outfit/job/roguetown/adventurer/mercenary/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_blindness(-3)
	var/classes = list(CLASS_CAVE_DWELLER, CLASS_WOODLAND_RANGER, CLASS_UNERRED_SWORDSMAN)
	var/classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes

	switch(classchoice)
		if(CLASS_CAVE_DWELLER) // Formerly locked to a few races, but I don't care to police it continually
			to_chat(H, span_warning(CLASS_CAVE_DWELLER_DESC))
			head = /obj/item/clothing/head/roguetown/helmet/leather/minershelm
			pants = /obj/item/clothing/under/roguetown/trou/leather
			armor = /obj/item/clothing/suit/roguetown/armor/plate/half
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			belt = /obj/item/storage/belt/rogue/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			beltl = /obj/item/rogueweapon/stoneaxe/woodcut/pick
			beltr = /obj/item/rogueweapon/huntingknife
			backl = /obj/item/storage/backpack/rogue/backpack
			backr = /obj/item/rogueweapon/shield/wood
			backpack_contents = list(/obj/item/roguekey/adventurers_guild, /obj/item/storage/belt/rogue/pouch/coins/poor)
			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/axes, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
			H.change_stat("fortune", 1)
			H.change_stat("strength", 1)
			H.change_stat("constitution", 2)
			H.change_stat("endurance", 2)
			H.change_stat("speed", 1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		if(CLASS_WOODLAND_RANGER) // Ditto
			to_chat(H, span_warning(CLASS_WOODLAND_RANGER_DESC))
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather/elven_boots
			cloak = /obj/item/clothing/cloak/forrestercloak
			gloves = /obj/item/clothing/gloves/roguetown/elven_gloves
			belt = /obj/item/storage/belt/rogue/leather/black
			backl = /obj/item/storage/backpack/rogue/satchel
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
			pants = /obj/item/clothing/under/roguetown/trou/leather
			var/weapons = list("Melee (Polearms)", "Ranged (Bows)")
			var/weaponchoice = input("Choose your archetype", "Available archetypes") as anything in weapons
			switch(weaponchoice)
				if("Melee (Polearms)")
					if(H.mind)
						H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
						H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
						H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
						H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
						H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
						H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
						H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
						H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
						H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
					H.change_stat("endurance", 2)
					H.change_stat("constitution", 1)
					H.change_stat("strength", 3)
					head = /obj/item/clothing/head/roguetown/helmet/heavy/elven_helm
					armor = /obj/item/clothing/suit/roguetown/armor/plate/elven_plate
					neck = /obj/item/clothing/neck/roguetown/chaincoif
					beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/special
					r_hand = /obj/item/rogueweapon/halberd/glaive
					backr = /obj/item/gwstrap
					backpack_contents = list(/obj/item/roguekey/adventurers_guild, /obj/item/storage/belt/rogue/pouch/coins/poor)
				if("Ranged (Bows)")
					if(H.mind)
						H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
						H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
						H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
						H.mind.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
						H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
						H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
						H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
						H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
						H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
					H.change_stat("perception", 3)
					H.change_stat("speed", 3)
					armor = /obj/item/clothing/suit/roguetown/armor/plate/half/elven
					head = /obj/item/clothing/head/roguetown/helmet/sallet/elven
					neck = /obj/item/clothing/neck/roguetown/chaincoif/full
					beltr = /obj/item/rogueweapon/huntingknife/idagger/silver/elvish
					beltl = /obj/item/quiver/arrows
					backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
					backpack_contents = list(/obj/item/roguekey/adventurers_guild, /obj/item/storage/belt/rogue/pouch/coins/poor, /obj/item/rogueweapon/huntingknife/idagger/navaja)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_OUTDOORSMAN, TRAIT_GENERIC)
		if(CLASS_UNERRED_SWORDSMAN)
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
			cloak = /obj/item/clothing/cloak/half/red
			gloves = /obj/item/clothing/gloves/roguetown/angle
			belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/iron
			head = /obj/item/clothing/head/roguetown/helmet
			armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
			backl = /obj/item/storage/backpack/rogue/satchel
			beltl = /obj/item/rogueweapon/sword/short
			beltr = /obj/item/quiver/bolts
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow // THIS TYPEPATH IS FUCKING AWFUL
			shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
			pants = /obj/item/clothing/under/roguetown/trou/leather
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			backpack_contents = list(/obj/item/roguekey/adventurers_guild, /obj/item/storage/belt/rogue/pouch/coins/poor, /obj/item/rogueweapon/huntingknife/idagger/navaja, /obj/item/lockpick = 1)
			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE) //Possibly too high, no idea.
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
				H.mind.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
			H.change_stat("endurance", 2)
			H.change_stat("perception", 2)
			H.change_stat("speed", 2)
			H.change_stat("intelligence", 1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

#undef CLASS_CAVE_DWELLER
#undef CLASS_CAVE_DWELLER_DESC
#undef CLASS_WOODLAND_RANGER
#undef CLASS_WOODLAND_RANGER_DESC
#undef CLASS_UNERRED_SWORDSMAN
#undef CLASS_UNERRED_SWORDSMAN_DESC
