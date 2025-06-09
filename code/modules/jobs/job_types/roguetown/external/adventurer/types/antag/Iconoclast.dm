/datum/advclass/iconoclast //Support Cleric, Heavy armor, unarmed, miracles.
	name = "Iconoclast"
	tutorial = "Your methedology in worship has been... questioned; in past. Yet it's fine, now - exile though you may be, you are freer than a bird."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/bandit/iconoclast
	category_tags = list(CTAG_BANDIT)
	maximum_possible_slots = 1 // We only want one of these.
	cmode_music = 'sound/music/Iconoclast.ogg'

/datum/outfit/job/roguetown/bandit/iconoclast/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/holy, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE) // Poles or maces if we're a wimp and don't want to engage with unarmed. Not ideal.
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)  // Unarmed if we want to kick ass for the lord(you do, this is what you SHOULD DO!!)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE) // We can substitute for a sawbones, but aren't as good and dont have access to surgical tools
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 5, TRUE) //We are the True Mathlete
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	r_hand = /obj/item/rogueweapon/woodstaff
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(
					/obj/item/needle/thorn = 1,
					/obj/item/natural/cloth = 1,
					/obj/item/flashlight/flare/torch = 1,
					/obj/item/ritechalk = 1,
					)
	head = /obj/item/clothing/head/roguetown/roguehood
	armor = /obj/item/clothing/suit/roguetown/armor/plate
	beltr = /obj/item/rogueweapon/katar
	H.change_stat("strength", 3) // LETS WRASSLE
	H.change_stat("endurance", 3) // This is our Go Big stat, we want lots of stamina for miracles and WRASSLIN.
	H.change_stat("constitution", 1)
	H.change_stat("fortune", 2) //We have a total of +12 in stats. 
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC) // We are going to be the lord's first heavy armor unarmed class
	ADD_TRAIT(H, TRAIT_RITUALIST, TRAIT_GENERIC)
	var/datum/devotion/C = new /datum/devotion(H, H.patron)
	C.grant_spells_monk(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	switch(H.patron?.type)
		if(/datum/patron/lording_three/aeternus)
			neck = /obj/item/clothing/neck/roguetown/psicross/aeternus
		if(/datum/patron/lording_three/zira)
			neck = /obj/item/clothing/neck/roguetown/psicross/zira
		if(/datum/patron/peoples_pantheon/cinella)
			neck = /obj/item/clothing/neck/roguetown/psicross/cinella	
		if(/datum/patron/three_sisters/tamari)
			neck = /obj/item/clothing/neck/roguetown/psicross/tamari
		if(/datum/patron/lording_three/tsoridys)
			neck = /obj/item/clothing/neck/roguetown/psicross/tsoridys
		if(/datum/patron/peoples_pantheon/varielle)
			neck = /obj/item/clothing/neck/roguetown/psicross/varielle
		if(/datum/patron/three_sisters/nunos)
			neck = /obj/item/clothing/neck/roguetown/psicross/nunos
		if(/datum/patron/peoples_pantheon/carthus)
			neck = /obj/item/clothing/neck/roguetown/psicross/carthus
		if(/datum/patron/three_sisters/kasmidian)
			var/list/psicross_options = list(
				/obj/item/clothing/neck/roguetown/psicross, \
				/obj/item/clothing/neck/roguetown/psicross/aeternus, \
				/obj/item/clothing/neck/roguetown/psicross/zira, \
				/obj/item/clothing/neck/roguetown/psicross/cinella, \
				/obj/item/clothing/neck/roguetown/psicross/tamari, \
				/obj/item/clothing/neck/roguetown/psicross/tsoridys, \
				/obj/item/clothing/neck/roguetown/psicross/carthus, \
				/obj/item/clothing/neck/roguetown/psicross/nunos, \
				/obj/item/clothing/neck/roguetown/psicross/varielle, \
				/obj/item/clothing/neck/roguetown/psicross/wood, \
			)
			neck = pick(psicross_options) // Don't care to move this off xylix behavior yet
