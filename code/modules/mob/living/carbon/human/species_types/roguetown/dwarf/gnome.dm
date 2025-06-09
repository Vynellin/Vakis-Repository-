/mob/living/carbon/human/species/dwarf/gnome
	race = /datum/species/dwarf/gnome

/datum/species/dwarf/gnome
	name = "Gnome"
	id = "gnome"
	desc = "<b>Gnome</b><br>\
	Gnomes are short delicate creatures known for their quick thinking and wit.<br>\

The naturally inquisitive mind of a Gnome inclines them towards arcane pursuits, artificing and teaching others.\
Gnomish folk have an earned reputation for being brilliant tradespeople and crafters, although their rapid thoughts often lead to them seeming scatterbrained to the other beings of Sunmarch.<br>\
Gnomes gladly congregate wherever other beings gather with a special friendship for Dwarves and followers of The Three Sisters. Despite their friendly and open demeanor the location of their secret strongholds is a closely guarded secret. <br>\

	(+1 Intelligence, +1 Perception, -1 Constitution)"

	skin_tone_wording = "Skintone"

	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,YOUNGBEARD,STUBBLE,OLDGREY)
	possible_ages = ALL_AGES_LIST
	default_features = MANDATORY_FEATURE_LIST
	use_skintones = 1
	disliked_food = NONE
	liked_food = NONE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mgn.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fd.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
	use_f = TRUE
	custom_clothes = TRUE
	clothes_id = "dwarf"
	offset_features = list(
		OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_WRISTS = list(0,0),\
		OFFSET_CLOAK = list(0,0), OFFSET_FACEMASK = list(0,-5), OFFSET_HEAD = list(0,-5), \
		OFFSET_FACE = list(0,-5), OFFSET_BELT = list(0,-5), OFFSET_BACK = list(0,-4), \
		OFFSET_NECK = list(0,-5), OFFSET_MOUTH = list(0,-6), OFFSET_PANTS = list(0,0), \
		OFFSET_SHIRT = list(0,0), OFFSET_ARMOR = list(0,0), OFFSET_HANDS = list(0,-3), \
		OFFSET_ID_F = list(0,-4), OFFSET_GLOVES_F = list(0,-4), OFFSET_WRISTS_F = list(0,-4), OFFSET_HANDS_F = list(0,-4), \
		OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-5), OFFSET_HEAD_F = list(0,-5), \
		OFFSET_FACE_F = list(0,-5), OFFSET_BELT_F = list(0,-5), OFFSET_BACK_F = list(0,-5), \
		OFFSET_NECK_F = list(0,-5), OFFSET_MOUTH_F = list(0,-5), OFFSET_PANTS_F = list(0,0), \
		OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES = list(0,-4), OFFSET_UNDIES_F = list(0,-4), \
		)
	race_bonus = list( STAT_INTELLIGENCE = 1, STAT_PERCEPTION = 1, STAT_CONSTITUTION = -1, )
	enflamed_icon = "widefire"
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/elfw,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
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
		/datum/customizer/organ/vagina/human,
		)
	body_markings = list(
	)

/datum/species/dwarf/gnome/check_roundstart_eligible()
	return TRUE

/datum/species/dwarf/gnome/get_span_language(datum/language/message_language)
	if(!message_language)
		return
	if(message_language.type == /datum/language/dwarvish)
		return list(SPAN_DWARF)
//	if(message_language.type == /datum/language/common)
//		return list(SPAN_DWARF)
	return message_language.spans

/datum/species/dwarf/gnome/get_skin_list()
	return list(
		"Platinum" = SKIN_COLOR_PLATINUM,
		"Aurum" = SKIN_COLOR_AURUM,
		"Quicksilver" = SKIN_COLOR_QUICKSILVER,
		"Brass" = SKIN_COLOR_BRASS,
		"Iron" = SKIN_COLOR_IRON,
		"Malachite" = SKIN_COLOR_MALACHITE,
		"Obsidian" = SKIN_COLOR_OBSIDIAN,
		"Brimstone" = SKIN_COLOR_BRIMSTONE,
		"Jade" = SKIN_COLOR_JADE,
		"Ashen" = SKIN_COLOR_ASHEN,
		"Underdusk" = SKIN_COLOR_UNDERDUSK,
		"Light" = SKIN_COLOR_LIGHT,
		"Warm Ivory" = SKIN_COLOR_WARMIVORY,
		"Heartland" = SKIN_COLOR_HEARTLAND,
		"Cool Sand" = SKIN_COLOR_COOLSAND,
		"South Sand" = SKIN_COLOR_SOUTHSAND,
		"Dull" = SKIN_COLOR_DULL,
		"Beach" = SKIN_COLOR_BEACH,
		"Coastal" = SKIN_COLOR_COASTAL,
		"Dark Gold" = SKIN_COLOR_DARKGOLD,
		"Palm" = SKIN_COLOR_PALM,
		"Walnut" = SKIN_COLOR_WALNUT,
		"Pyrite" = SKIN_COLOR_PYRITE,
	)
/datum/species/dwarf/gnome/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"blond - pale" = "9d8d6e",
	"blond - dirty" = "88754f",
	"blond - drywheat" = "d5ba7b",
	"blond - strawberry" = "c69b71",

	"brown - mud" = "362e25",
	"brown - oats" = "7a4e1e",
	"brown - grain" = "58433b",
	"brown - soil" = "48322a",

	"red - berry" = "b23434",
	"red - wine" = "b87f77",
	"red - sunset" = "bf6821",
	"red - blood" = "822b2b"
	))

/datum/species/dwarf/gnome/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/dwarf/dwarmm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/dwarf/dwarmf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/dwarf/dwarmm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/dwarf/dwarmf.txt") )
	return randname

/datum/species/dwarf/gnome/random_surname()
	return " [pick(world.file2list("strings/rt/names/elf/elfwlast.txt"))]"
