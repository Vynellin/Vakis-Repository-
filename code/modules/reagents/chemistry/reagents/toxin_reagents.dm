
//////////////////////////Poison stuff (Toxins & Acids)///////////////////////

/datum/reagent/toxin
	name = "Toxin"
	description = "A toxic chemical."
	color = "#CF3600" // rgb: 207, 54, 0
	taste_description = "bitterness"
	taste_mult = 1.2
	harmful = TRUE
	var/toxpwr = 1.5
	var/silent_toxin = FALSE //won't produce a pain message when processed by liver/life() if there isn't another non-silent toxin present.

/datum/reagent/toxin/on_mob_life(mob/living/carbon/M)
	if(toxpwr)
		M.adjustToxLoss(toxpwr*REM, 0)
	return ..()

#define	LIQUID_PLASMA_BP (50+T0C)

/datum/reagent/toxin/plasma
	name = "Plasma"
	description = "Plasma in its liquid form."
	taste_description = "bitterness"
	specific_heat = SPECIFIC_HEAT_PLASMA
	taste_mult = 1.5
	color = "#8228A0"
	toxpwr = 3

/datum/reagent/toxin/plasma/reaction_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with plasma is stronger than fuel!
	if(method == TOUCH || method == VAPOR)
		M.adjust_fire_stacks(reac_volume / 5)
		return
	..()

/datum/reagent/toxin/histamine
	name = "Histamine"
	description = "Histamine's effects become more dangerous depending on the dosage amount. They range from mildly annoying to incredibly lethal."
	silent_toxin = TRUE
	reagent_state = LIQUID
	color = "#FA6464"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30
	toxpwr = 0

/datum/reagent/toxin/histamine/on_mob_life(mob/living/carbon/M)
	if(prob(50))
		switch(pick(1, 2, 3, 4))
			if(1)
				to_chat(M, span_danger("I can barely see!"))
				M.blur_eyes(3)
			if(2)
				M.emote("cough")
			if(3)
				M.emote("sneeze")
			if(4)
				if(prob(75))
					to_chat(M, span_danger("I scratch at an itch."))
					M.adjustBruteLoss(2*REM, 0)
					. = 1
	..()

/datum/reagent/toxin/histamine/overdose_process(mob/living/M)
	M.adjustOxyLoss(2*REM, 0)
	M.adjustBruteLoss(2*REM, FALSE, FALSE, BODYPART_ORGANIC)
	M.adjustToxLoss(2*REM, 0)
	..()
	. = 1

/datum/reagent/toxin/venom
	name = "Venom"
	description = "An exotic poison extracted from highly toxic fauna. Causes scaling amounts of toxin damage and bruising depending and dosage. Often decays into Histamine."
	reagent_state = LIQUID
	color = "#F0FFF0"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	toxpwr = 0

/datum/reagent/toxin/venom/on_mob_life(mob/living/carbon/M)
	toxpwr = 0.2*volume
//	M.adjustBruteLoss((0.3*volume)*REM, 0)
	. = 1
//	if(prob(15))
//		M.reagents.add_reagent(/datum/reagent/toxin/histamine, pick(5,10))
//		M.reagents.remove_reagent(/datum/reagent/toxin/venom, 1.1)
//	else
//		..()
	..()

/datum/reagent/toxin/killersice
	name = "killersice"
	description = "killersice"
	reagent_state = LIQUID
	color = "#FFFFFF"
	metabolization_rate = 0.01
	toxpwr = 0

/datum/reagent/toxin/killersice/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(10, 0)
	return ..()

/datum/reagent/toxin/bad_food
	name = "Bad Food"
	description = "The result of some abomination of cookery, food so bad it's toxic."
	reagent_state = LIQUID
	color = "#d6d6d8"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	toxpwr = 0.5
	taste_description = "bad cooking"

/datum/reagent/toxin/spewium
	name = "Spewium"
	description = "A powerful emetic, causes uncontrollable vomiting.  May result in vomiting organs at high doses."
	reagent_state = LIQUID
	color = "#2f6617" //A sickly green color
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 29
	toxpwr = 0
	taste_description = "vomit"

/datum/reagent/toxin/spewium/on_mob_life(mob/living/carbon/C)
	.=..()
	if(current_cycle >=11 && prob(min(50,current_cycle)))
		C.vomit(10, prob(10), prob(50), rand(0,4), TRUE, prob(30))
		for(var/datum/reagent/toxin/R in C.reagents.reagent_list)
			if(R != src)
				C.reagents.remove_reagent(R.type,1)

/datum/reagent/toxin/spewium/overdose_process(mob/living/carbon/C)
	. = ..()
	if(current_cycle >=33 && prob(15))
		C.spew_organ()
		C.vomit(0, TRUE, TRUE, 4)
		to_chat(C, span_danger("I feel something lumpy come up..."))

/datum/reagent/toxin/drow
	name = "Drow Toxin"
	description = "How are you even reading this?"
	reagent_state = LIQUID
	color = "#410233"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM

/datum/reagent/miasmagas
	name = "miasmagas"
	description = "."
	color = "#801E28" // rgb: 128, 30, 40
	taste_description = "ugly"
	metabolization_rate = 1

/datum/reagent/miasmagas/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NOSTINK) && !physician_mask_check(M))
		M.add_nausea(15)
		M.add_stress(/datum/stressevent/miasmagas)
	return ..()

/proc/physician_mask_check(mob/living/carbon/M)
	if(!M)
		return FALSE
	if(!istype(M, /mob/living/carbon/human))
		return FALSE
	var/mob/living/carbon/human/H = M
	if(!H.wear_mask)
		return FALSE
	return istype(H.wear_mask, /obj/item/clothing/mask/rogue/deacon)

/datum/reagent/rogueacid
	name = "rogueacid"
	description = "."
	reagent_state = LIQUID
	color = "#5eff00"
	taste_description = "burning"
	self_consuming = TRUE

/datum/reagent/rogueacid/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	M.adjustFireLoss(35, 0)
	..()
