#define ALCOHOL_THRESHOLD_MODIFIER 1 //Greater numbers mean that less alcohol has greater intoxication potential
#define ALCOHOL_RATE 0.005 //The rate at which alcohol affects you
#define ALCOHOL_EXPONENT 1.6 //The exponent applied to boozepwr to make higher volume alcohol at least a little bit damaging to the liver

/datum/reagent/consumable/ethanol /// base alcohol
	name = "Ethanol"
	description = "A well-known alcohol with a variety of applications."
	color = "#404030" // rgb: 64, 64, 48
	nutriment_factor = 0
	taste_description = "alcohol"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	var/boozepwr = 65 //Higher numbers equal higher hardness, higher hardness equals more intense alcohol poisoning

/*
Boozepwr Chart
Note that all higher effects of alcohol poisoning will inherit effects for smaller amounts (i.e. light poisoning inherts from slight poisoning)
In addition, severe effects won't always trigger unless the drink is poisonously strong
All effects don't start immediately, but rather get worse over time; the rate is affected by the imbiber's alcohol tolerance

0: Non-alcoholic
1-10: Barely classifiable as alcohol - occassional slurring
11-20: Slight alcohol content - slurring
21-30: Below average - imbiber begins to look slightly drunk
31-40: Just below average - no unique effects
41-50: Average - mild disorientation, imbiber begins to look drunk
51-60: Just above average - disorientation, vomiting, imbiber begins to look heavily drunk
61-70: Above average - small chance of blurry vision, imbiber begins to look smashed
71-80: High alcohol content - blurry vision, imbiber completely shitfaced
81-90: Extremely high alcohol content - heavy toxin damage, passing out
91-100: Dangerously toxic - swift death
*/

/datum/reagent/consumable/ethanol/on_mob_life(mob/living/carbon/C)
	if(C.drunkenness < volume * boozepwr * ALCOHOL_THRESHOLD_MODIFIER || boozepwr < 0)
		var/booze_power = boozepwr
		C.drunkenness = max((C.drunkenness + (sqrt(volume) * booze_power * ALCOHOL_RATE)), 0) //Volume, power, and server alcohol rate effect how quickly one gets drunk
//		if(boozepwr > 0)
//			var/obj/item/organ/liver/L = C.getorganslot(ORGAN_SLOT_LIVER)
//			if (istype(L))
//				L.applyOrganDamage(((max(sqrt(volume) * (boozepwr ** ALCOHOL_EXPONENT) * L.alcohol_tolerance, 0))/150))
	return ..()

/datum/reagent/consumable/ethanol/reaction_obj(obj/O, reac_volume)
	if(istype(O, /obj/item/paper))
		var/obj/item/paper/paperaffected = O
		paperaffected.clearpaper()
		to_chat(usr, "<span class='notice'>[paperaffected]'s ink washes away.</span>")
	if(istype(O, /obj/item/book))
		if(reac_volume >= 5)
			var/obj/item/book/affectedbook = O
			affectedbook.dat = null
			O.visible_message("<span class='notice'>[O]'s writing is washed away by [name]!</span>")
		else
			O.visible_message("<span class='warning'>[O]'s ink is smeared by [name], but doesn't wash away!</span>")
	return

/datum/reagent/consumable/ethanol/reaction_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with ethanol isn't quite as good as fuel.
	if(!isliving(M))
		return

	if(method in list(TOUCH, VAPOR, PATCH))
		M.adjust_fire_stacks(reac_volume / 15)

	return ..()

///////////////////
/// ROGUE BOOZE ///
///////////////////

// BEERS - Imported for now, later the styles will be 'mockable', if and when I get to brewing.

// Humen Production - Underwhelming, but cheap.

/datum/reagent/consumable/ethanol/beer/zagul
	name = "Zagul Brew"
	boozepwr = 15
	taste_description = "cheap pisswater"
	color = "#DBD77F"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/beer/hagwoodbitter
	name = "Hagwood Bitter"
	boozepwr = 25
	taste_description = "dull crispness"
	color = "#BBB525"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/beer/blackgoat
	name = "Black Goat Kriek"
	boozepwr = 25
	taste_description = "overwhelming sourness"
	color = "#401806"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/beer/onion
	name = "Ratkept Onin Cognac"
	boozepwr = 10
	taste_description = "spicy sweet malty overtones"
	color = "#f1b5ff"
	quality = DRINK_NICE

// Elf Production - LEAF-LOVERS MOTHERFUCKER

/datum/reagent/consumable/ethanol/beer/aurorian
	name = "Aurorian"
	boozepwr = 5
	taste_description = "subtle herbacious undertones"
	color = "#5D8A8A"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/beer/fireleaf // cabbbage
	name = "Fireleaf"
	boozepwr = 2
	taste_description = "bland liquor"
	color = "#475e45"

// Dwarven Production - Best in the Realms

/datum/reagent/consumable/ethanol/beer/butterhairs
	name = "Butterhairs"
	boozepwr = 30
	taste_description = "buttery richness"
	color = "#5D8A8A"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/beer/stonebeards
	name = "Stonebeard Reserve"
	boozepwr = 40
	taste_description = "potent oatlike liquor"
	color = "#5D8A8A"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/beer/voddena // Not vodka. Trust me.
	name = "Voddena"
	boozepwr = 55  // holy shit
	taste_description = "burning starchy wet dirt"
	color = "#4b443c"

// WINE - Fancy.. And yes: all drinks are beer, technically. Cope. Seethe. I didnt code it like this.

// Humen Production - Grape Based

/datum/reagent/consumable/ethanol/beer/sourwine // Peasant grade shit.
	name = "Sour Wine"
	boozepwr = 20
	taste_description = "sour wine"
	color = "#583650"

/datum/reagent/consumable/ethanol/beer/whitewine
	name = "White Wine"
	boozepwr = 30
	taste_description = "sweet white wine"
	color = "#F3ED91"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/beer/redwine
	name = "Red Wine"
	boozepwr = 30
	taste_description = "tannin-stricken wine"
	color = "#4A1111"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/beer/jackberrywine
	name = "Jackberry Wine"
	boozepwr = 15
	taste_description = "sickly sweet young wine"
	color = "#3F2D45"
	quality = DRINK_NICE


// Elf Production - Berries & Herbal

/datum/reagent/consumable/ethanol/beer/elfred
	name = "Elven Red"
	boozepwr = 15
	taste_description = "delectable fruity notes"
	color = "#6C0000"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/beer/elfblue
	name = "Valmora Blue"
	boozepwr = 50
	taste_description = "saintly sweetness"
	color = "#2C9DAF"
	quality = DRINK_FANTASTIC

//AZURE DRINKS
/datum/reagent/consumable/ethanol/beer/jagdtrunk // JÄGERMEISTER!!!!
	name = "Jagdtrunk"
	boozepwr = 55  // gotta be stronk
	taste_description = "spicy herbal remedy"
	color = "#331f18"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/beer/apfelweinheim
	name = "Appelheimer"
	boozepwr = 45
	taste_description = "tart crispness and mellow sweetness"
	color = "#e0cb55"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/beer/rtopaz
	name = "Rockhill Topaz"
	boozepwr = 40
	taste_description = "overwhelming tartness"
	color = "#e0a400"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/beer/nred
	name = "Norwardine Red"
	boozepwr = 30
	taste_description = "heavy caramel note and slight bitterness"
	color = "#543633"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/beer/gronnmead
	name = "Ragnar's Brew"
	boozepwr = 35
	taste_description = "notes of honey and red berries" //I love red mead ok...
	color = "#772C48"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/beer/honeyedmead
	name = "Zögiin bal"
	boozepwr = 30
	taste_description = "spicy honey"
	color = "#e0a400"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/beer/makkolir
	name = "Makkolir"
	boozepwr = 30
	taste_description = "tangy sweetness"
	color = "#ddcbc9"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/beer/saigamilk
	name = "Bökhiin Arkhi"
	boozepwr = 15
	taste_description = "bubbly, sour salt"
	color = "#dddddd"

/datum/reagent/consumable/ethanol/beer/kgunlager
	name = "Yamaguchi Pale"
	boozepwr = 10 //A PALE imitation actual beer...
	taste_description = "mellow bitterness and a hint of green tea"
	color = "#d7dbbc"

/datum/reagent/consumable/ethanol/beer/kgunsake
	name = "Junmai-ginjo"
	boozepwr = 50
	taste_description = "dry sweetness"
	color = "#ccd7e0"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/beer/kgunplum
	name = "Umeshu"
	boozepwr = 30
	taste_description = "a mix of sweet and sour"
	color = "#ddb99b"
	quality = DRINK_VERYGOOD


/datum/reagent/consumable/ethanol/beer/murkwine // not Toilet wine
	name = "mürkwine"
	boozepwr = 50  // bubba's best
	taste_description = "hints of questionable choices--a bouqet of murkwater and pure ethanol"
	color = "#4b1e00"

/datum/reagent/consumable/ethanol/beer/murkwine/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/murkwine)
	M.rogfat_add(0.1)
	..()
	. = 1

/datum/reagent/consumable/ethanol/beer/murkwine/on_mob_end_metabolize(mob/living/M)
	M.remove_status_effect(/datum/status_effect/buff/murkwine)
	


/datum/reagent/consumable/ethanol/beer/moonshine // i'm not calling it zirashine
	name = "moonshine"
	boozepwr = 70  // YEEEEEHAAAWWWWWW
	taste_description = "what might be my throat melting and nose hair burning"
	color = "#d8fbfd63"
	quality = DRINK_NICE


/datum/reagent/consumable/ethanol/beer/moonshine/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/moonshine)
	M.adjustToxLoss(0.75, 0)
	..()
	. = 1

/datum/reagent/consumable/ethanol/beer/moonshine/on_mob_end_metabolize(mob/living/M)
	M.remove_status_effect(/datum/status_effect/buff/moonshine)
