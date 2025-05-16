/mob/living/carbon/human/species/halforc
	race = /datum/species/halforc

/datum/species/halforc
	name = "True Orc"
	id = "halforc"
	desc = "<b>Orcs</b><br>\
Orcs are a heavy-set warrior people from the far reaches of the world.\

Known for their size, strength and large canine tusks, it’s no wonder the Orcish visage inspires fear. Orcs have no shame in inspiring fear in their enemies, living in ever evolving wars for territory far from Sunmarch and it’s relative stability. <br>\
Orcs survived the Dusk War through tooth blood and claw. They were never afraid to turn against fellow forces of the light one day if it meant securing a victory the next, unfortunately sowing distrust for their people that has never fully left.<br>\

Those of Orcish blood still exist in Sunmarch, far away from their homelands that struggle in the most wartorn of the dusk damaged lands. They make a living as warriors, adventurers and the most hard working of laborers. <br>\

	(+1 Strength and +1 Endurance)"

	skin_tone_wording = "Skintone"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = 1
	disliked_food = NONE
	liked_food = NONE
	possible_ages = ALL_AGES_LIST
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mt_muscular.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/ft_muscular.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	use_m = TRUE
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
	offset_features = list(OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
	OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
	OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
	OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1), \
	OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
	OFFSET_ID_F = list(0,1), OFFSET_GLOVES_F = list(0,1), OFFSET_WRISTS_F = list(0,1), OFFSET_HANDS_F = list(0,1), \
	OFFSET_CLOAK_F = list(0,1), OFFSET_FACEMASK_F = list(0,1), OFFSET_HEAD_F = list(0,1), \
	OFFSET_FACE_F = list(0,1), OFFSET_BELT_F = list(0,1), OFFSET_BACK_F = list(0,1), \
	OFFSET_NECK_F = list(0,1), OFFSET_MOUTH_F = list(0,1), OFFSET_PANTS_F = list(0,1), \
	OFFSET_SHIRT_F = list(0,1), OFFSET_ARMOR_F = list(0,1), OFFSET_UNDIES_F = list(0,1))
	race_bonus = list(STAT_STRENGTH = 1, STAT_ENDURANCE = 1)
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/halforc,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		//ORGAN_SLOT_TESTICLES = /obj/item/organ/testicles,
		//ORGAN_SLOT_PENIS = /obj/item/organ/penis,
		//ORGAN_SLOT_BREASTS = /obj/item/organ/breasts,
		//ORGAN_SLOT_VAGINA = /obj/item/organ/vagina,
		)
	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/belly,
		/datum/body_marking_set/bellysocks,
		/datum/body_marking_set/tiger,
		/datum/body_marking_set/tiger_dark,
	)
	body_markings = list(
		/datum/body_marking/flushed_cheeks,
		/datum/body_marking/eyeliner,
		/datum/body_marking/tonage,
	)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/bodypart_feature/underwear,
		/datum/customizer/organ/testicles/anthro,
		/datum/customizer/organ/penis/anthro,
		/datum/customizer/organ/breasts/human,
		/datum/customizer/organ/vagina/human_anthro,
		/datum/customizer/organ/horns/tusks,
		)
	languages = list(
		/datum/language/common,
		/datum/language/orcish
	)

/datum/species/halforc/after_creation(mob/living/carbon/C)
	..()
	to_chat(C, "<span class='info'>I can speak Orcish with ,o before my speech.</span>")

/datum/species/halforc/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/halforc/get_skin_list()
	return list(
		"Slate" = SKIN_COLOR_SLATE,
		"Teak" = SKIN_COLOR_TEAK,
		"Undergrowth" = SKIN_COLOR_UNDERGROWTH,
		"Raw Blood" = SKIN_COLOR_RAWBLOOD,
		"Water Moss" = SKIN_COLOR_WATERMOSS,
		"Deep One" = SKIN_COLOR_DEEPONE,
		"Cave Moss" = SKIN_COLOR_CAVEMOSS,
		"Hobbe" = SKIN_COLOR_HOBBE,
		"Murkwalker" = SKIN_COLOR_MURKWALKER,
		"Ice Blood" = SKIN_COLOR_ICEBLOOD,
		"Rawhide" = SKIN_COLOR_RAWHIDE,
		"Marine" = SKIN_COLOR_MARINE,
		"Pyrite" = SKIN_COLOR_PYRITE,

	)

/datum/species/halforc/get_hairc_list()
	return sortList(list(
	"Minotaur" = "58433b",
	"Volf" = "48322a",
	"Maneater" = "458745",
	"Mud" = "201616",
	))

/datum/species/halforc/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/halforcm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/halforcf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/halforcm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/halforcf.txt") )
	return randname

/datum/species/halforc/random_surname()
	return
