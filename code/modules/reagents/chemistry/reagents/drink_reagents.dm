

/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// DRINKS BELOW, Beer is up there though, along with cola. Cap'n Pete's Cuban Spiced Rum////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/reagent/consumable/limejuice/on_mob_life(mob/living/carbon/M)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1*REM, 0)
		. = 1
	..()

/datum/reagent/consumable/carrotjuice
	name = "Carrot Juice"
	description = "It is just like a carrot but without crunching."
	color = "#973800" // rgb: 151, 56, 0
	taste_description = "carrots"
	glass_icon_state = "carrotjuice"
	glass_name = "glass of  carrot juice"
	glass_desc = ""

/datum/reagent/consumable/carrotjuice/on_mob_life(mob/living/carbon/M)
	M.adjust_blurriness(-1)
	M.adjust_blindness(-1)
	switch(current_cycle)
		if(1 to 20)
			//nothing
		if(21 to INFINITY)
			if(prob(current_cycle-10))
				M.cure_nearsighted(list(EYE_DAMAGE))
	..()
	return

/datum/reagent/consumable/berryjuice
	name = "Berry Juice"
	description = "A delicious blend of several different kinds of berries."
	color = "#4a4b8d" 
	taste_description = "berries"
	glass_icon_state = "berryjuice"
	glass_name = "glass of berry juice"
	glass_desc = ""
	hydration_factor = 10

/datum/reagent/consumable/applejuice
	name = "Apple Juice"
	description = "The sweet juice of an apple, fit for all ages."
	color = "#ECFF56" // rgb: 236, 255, 86
	taste_description = "apples"
	hydration_factor = 10

/datum/reagent/consumable/sugarcanejuice
	name = "Sugarcane Juice"
	description = "A sweet juice made from sugarcane, a staple of many tropical diets."
	color = "#D2B48C" // rgb: 210, 180, 140
	taste_description = "sweetness"
	glass_icon_state = "sugarcanejuice"
	glass_name = "glass of sugarcane juice"
	glass_desc = ""
	hydration_factor = 10

/datum/reagent/consumable/maltwheat
	name = "Malt Wheat Juice"
	description = "A sweet juice made from malted wheat, a staple of many diets."
	color = "#D2B48C" // rgb: 210, 180, 140
	taste_description = "sweetness"
	glass_icon_state = "maltwheatjuice"
	glass_name = "glass of malt wheat juice"
	glass_desc = ""
	hydration_factor = 10

/datum/reagent/consumable/malted_oats
	name = "Malted Oats Juice"
	description = "A sweet juice made from malted oats, a staple of many temperate diets."
	color = "#D2B48C" // rgb: 210, 180, 140
	taste_description = "sweetness"
	glass_icon_state = "malted_oatsjuice"
	glass_name = "glass of malted oats juice"
	glass_desc = ""
	hydration_factor = 10

/datum/reagent/consumable/rice_milk
	name = "Rice Milk"
	description = "A sweet juice made from rice, a staple of many tropical diets."
	color = "#D2B48C" // rgb: 210, 180, 140
	taste_description = "sweetness"
	glass_icon_state = "ricemilk"
	glass_name = "glass of rice milk"
	glass_desc = ""
	hydration_factor = 10

/datum/reagent/consumable/poisonberryjuice
	name = "Poison Berry Juice"
	description = "A tasty juice blended from various kinds of very deadly and toxic berries."
	color = "#863353" // rgb: 134, 51, 83
	taste_description = "berries"
	glass_icon_state = "poisonberryjuice"
	glass_name = "glass of berry juice"
	glass_desc = ""

/datum/reagent/consumable/poisonberryjuice/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(1, 0)
	. = 1
	..()

/datum/reagent/consumable/meadbase
    name = "Mead Base"
    description = "The freshly pressed base for a fine, and smooth mead."
    color = "#e0c133"
    taste_description = "freshly pressed honey"
    glass_name = "glass of mead base"

/datum/reagent/consumable/potato_juice
	name = "Potato Juice"
	description = "Juice of the potato. Bleh."
	nutriment_factor = 2 * REAGENTS_METABOLISM
	color = "#302000" // rgb: 48, 32, 0
	taste_description = "irish sadness"
	glass_icon_state = "glass_brown"
	glass_name = "glass of potato juice"
	glass_desc = ""

/datum/reagent/consumable/milk
	name = "Milk"
	description = "An opaque white liquid produced by the mammary glands of mammals."
	color = "#DFDFDF" // rgb: 223, 223, 223
	taste_description = "milk"
	glass_icon_state = "glass_white"
	glass_name = "glass of milk"
	glass_desc = ""

/datum/reagent/consumable/coffee/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.AdjustSleeping(-40, FALSE)
	//310.15 is the normal bodytemp.
	M.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	..()
	. = 1

/datum/reagent/consumable/pumpkinjuice
	name = "Pumpkin Juice"
	description = "Juiced from real pumpkin."
	color = "#FFA500"
	taste_description = "pumpkin"

//Rougetown Reagents - Ported from Dreamkeep
/datum/reagent/consumable/acorn_powder
	name = "Acorn Powder"
	description = "A bitter fine powder."
	color = "#dcb137"
	quality = DRINK_VERYGOOD
	taste_description = "bitter earthy-ness"

/datum/reagent/consumable/acorn_powder/on_mob_life(mob/living/carbon/M)
	M.rogstam_add(8)
	..()
