/datum/job/roguetown/jester
	title = "Jester"
	flag = JESTER
	department_flag = COURTIERS
	selection_color = JCOLOR_COURTIER
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_ALL_KINDS

	tutorial = "Jesters are renowned confidants, comedians, and former bards seeking position in the court. \
				While their antics are generally considered meaningless and silly - those employed in Rasura \
				have kept steady hand in times of crisis past, a legacy held on, albeit quietly, in the courts \
				today."

	allowed_ages = ALL_AGES_LIST
	spells = list(/obj/effect/proc_holder/spell/self/telljoke,/obj/effect/proc_holder/spell/self/telltragedy)
	outfit = /datum/outfit/job/roguetown/jester
	display_order = JDO_JESTER
	give_bank_account = TRUE
	min_pq = -4 //silly jesters are funny so low PQ requirement
	max_pq = null
	round_contrib_points = 2

/datum/outfit/job/roguetown/jester/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/jester
	pants = /obj/item/clothing/under/roguetown/tights
	armor = /obj/item/clothing/suit/roguetown/shirt/jester
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/servant
	beltl = /obj/item/storage/belt/rogue/pouch
	head = /obj/item/clothing/head/roguetown/jester
	neck = /obj/item/clothing/neck/roguetown/coif

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/music, rand(1,6), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, rand(1,3), TRUE)
		H.STASTR = rand(1, 20)
		H.STAINT = rand(1, 20)
		H.STALUC = rand(1, 20)
		H.cmode_music = 'sound/music/combat_jester.ogg'
	H.verbs |= /mob/living/carbon/human/proc/ventriloquate
	H.verbs |= /mob/living/carbon/human/proc/ear_trick
	if(!istype(H.getorganslot(ORGAN_SLOT_TONGUE), /obj/item/organ/tongue/wild_tongue))
		H.internal_organs_slot[ORGAN_SLOT_TONGUE] = new /obj/item/organ/tongue/wild_tongue
	ADD_TRAIT(H, TRAIT_ZJUMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LEAPER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)
	if(prob(50))
		ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC) // Jester :3
	else
		ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC) // Joker >:(

