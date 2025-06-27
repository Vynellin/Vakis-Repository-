/datum/reagent/blood
	data = list("donor"=null,"blood_DNA"=null,"blood_type"=null,"resistances"=null,"trace_chem"=null,"mind"=null,"ckey"=null,"gender"=null,"real_name"=null,"cloneable"=null,"factions"=null,"quirks"=null)
	name = "Blood"
	color = "#C80000" // rgb: 200, 0, 0
	metabolization_rate = 5 //fast rate so it disappears fast.
	taste_description = "iron"
	taste_mult = 1.3
	glass_icon_state = "glass_red"
	glass_name = "glass of tomato juice"
	glass_desc = ""
	shot_glass_icon_state = "shotglassred"

/datum/reagent/blood/reaction_mob(mob/living/L, method=TOUCH, reac_volume)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		if(C.get_blood_id() == /datum/reagent/blood && (method == INJECT || (method == INGEST && C.dna && C.dna.species && (DRINKSBLOOD in C.dna.species.species_traits))))
			if(!data || !(data["blood_type"] in get_safe_blood(C.dna.blood_type)))
				C.reagents.add_reagent(/datum/reagent/toxin, reac_volume * 0.5)
			else
				C.blood_volume = min(C.blood_volume + round(reac_volume, 0.1), BLOOD_VOLUME_MAXIMUM)


/datum/reagent/blood/on_merge(list/mix_data)
	if(data && mix_data)
		if(data["blood_DNA"] != mix_data["blood_DNA"])
			data["cloneable"] = 0 //On mix, consider the genetic sampling unviable for pod cloning if the DNA sample doesn't match.
	return 1

/datum/reagent/blood/reaction_turf(turf/T, reac_volume)//splash the blood all over the place
	if(!istype(T))
		return
	if(reac_volume < 3)
		return

	var/obj/effect/decal/cleanable/blood/B = locate() in T //find some blood here
	if(!B)
		B = new(T)
	if(data["blood_DNA"])
		B.add_blood_DNA(list(data["blood_DNA"] = data["blood_type"]))

/datum/reagent/blood/green
	color = "#05af01"

/datum/reagent/liquidgibs
	name = "Liquid gibs"
	color = "#CC4633"
	description = "You don't even want to think about what's in here."
	taste_description = "gross iron"
	shot_glass_icon_state = "shotglassred"

/datum/reagent/water
	name = "Water"
	description = "An ubiquitous chemical substance that is composed of hydrogen and oxygen."
	color = "#6a9295c6"
	taste_description = "water"
	var/cooling_temperature = 2
	glass_icon_state = "glass_clear"
	glass_name = "glass of water"
	glass_desc = ""
	shot_glass_icon_state = "shotglassclear"
	var/hydration = 12
	alpha = 100
	taste_mult = 0.1

/datum/chemical_reaction/grosswaterify
	name = "grosswater"
	id = /datum/reagent/water/gross
	results = list(/datum/reagent/water/gross = 2)
	required_reagents = list(/datum/reagent/water/gross = 1, /datum/reagent/water = 1)


/datum/reagent/water/on_mob_life(mob/living/carbon/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
			H.adjust_hydration(hydration)
		if(M.blood_volume < BLOOD_VOLUME_NORMAL)
			M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_NORMAL)
	..()

/datum/reagent/water/gross
	taste_description = "something vile"
	color = "#98934bc6"

/datum/reagent/water/gross/reaction_mob(mob/living/L, method=TOUCH, reac_volume)
	if(method == INGEST) // Make sure you DRANK the toxic water before giving damage
		..()

/datum/reagent/water/gross/on_mob_life(mob/living/carbon/M)
	..()
	if(HAS_TRAIT(M, TRAIT_NASTY_EATER )) // lets orcs and goblins drink bogwater
		return
	M.adjustToxLoss(1)
	M.add_nausea(12) //Over 8 units will cause puking

/datum/chemical_reaction/grosswaterboil //boiling water purifies it
	name = "gross water purification"
	id = /datum/reagent/water
	results = list(/datum/reagent/water = 1)
	required_reagents = list(/datum/reagent/water/gross = 1)
	required_temp = 375

/datum/reagent/water/bathwater
	taste_description = "bathwater"
	color = "#c9e5eec6"

/datum/reagent/water/salty
	taste_description = "salt"
	color = "#417ac5c6"

/datum/reagent/water/salty/reaction_mob(mob/living/L, method=TOUCH, reac_volume)
	if(method == INGEST) // Make sure you DRANK the salty water before losing hydration
		..()

/datum/reagent/water/salty/on_mob_life(mob/living/carbon/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER)&&!HAS_TRAIT(H, TRAIT_SEA_DRINKER))
			H.adjust_hydration(-6)  //saltwater dehydrates more than it hydrates
		else if(HAS_TRAIT(H, TRAIT_SEA_DRINKER))
			H.adjust_hydration(hydration)  //saltwater dehydrates more than it hydrates
	..()

/datum/chemical_reaction/saltwaterify
	name = "saltwater"
	id = /datum/reagent/water/salty
	results = list(/datum/reagent/water/salty = 2)
	required_reagents = list(/datum/reagent/water/salty = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/saltwaterboil //boiling water purifies it
	name = "saltwater purification"
	id = /datum/reagent/water
	results = list(/datum/reagent/water = 1)
	required_reagents = list(/datum/reagent/water/salty = 1)
	required_temp = 375

/datum/chemical_reaction/saltwaterboil/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	new /obj/item/reagent_containers/powder/salt(location)
	new /obj/item/reagent_containers/powder/salt(location)
	new /obj/item/reagent_containers/powder/salt(location)

/*
 *	Water reaction to turf
 */

/turf/open
	var/water_level = 0
	var/last_water_update
	var/max_water = 500

/turf/open/proc/add_water(amt)
	if(!amt)
		return
	var/shouldupdate = FALSE
	if(water_level <= 0)
		if(amt > 0)
			shouldupdate = TRUE
	var/newwater = water_level + amt
	if(newwater >= max_water)
		water_level = max_water
	else
		water_level = newwater
	water_level = round(water_level)
	if(water_level > 0)
		START_PROCESSING(SSwaterlevel, src)
	if(shouldupdate)
		update_water()

	if(amt > 101)
		for(var/obj/effect/decal/cleanable/blood/target in src)
			qdel(target)

	return TRUE

/turf/open/proc/update_water()
	return TRUE

/datum/reagent/water/reaction_turf(turf/open/T, reac_volume)
	if(!istype(T))
		return
	if(reac_volume >= 5)
		T.add_water(reac_volume * 3) //nuprocet)

	var/obj/effect/hotspot/hotspot = (locate(/obj/effect/hotspot) in T)
	if(hotspot)
		new /obj/effect/temp_visual/small_smoke(T)
		qdel(hotspot)

/*
 *	Water reaction to an object
 */

/datum/reagent/water/reaction_obj(obj/O, reac_volume)
	O.extinguish()
	O.acid_level = 0


	if(istype(O, /obj/item/roguebin))
		var/obj/item/roguebin/RB = O
		if(!RB.kover)
			if(RB.reagents)
				RB.reagents.add_reagent(src.type, reac_volume)

	else if(istype(O, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/RB = O
		if(RB.reagents)
			RB.reagents.add_reagent(src.type, reac_volume)


/*
 *	Water reaction to a mob
 */

/datum/reagent/water/reaction_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with water can help put them out!
	if(!istype(M))
		return
	if(method == TOUCH)
		M.adjust_fire_stacks(-(reac_volume / 10))
		M.SoakMob(FULL_BODY)
//		for(var/obj/effect/decal/cleanable/blood/target in M)
//			qdel(target)
	..()

/datum/reagent/water/holywater
	name = "Holy Water"
	description = "Water blessed by some deity."
	color = "#E0E8EF" // rgb: 224, 232, 239
	glass_icon_state  = "glass_clear"
	glass_name = "glass of holy water"
	glass_desc = ""
	self_consuming = TRUE //divine intervention won't be limited by the lack of a liver

/datum/reagent/water/holywater/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_HOLY, type)

/datum/reagent/water/holywater/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_HOLY, type)
	..()


/datum/reagent/water/holywater/on_mob_life(mob/living/carbon/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
			H.adjust_hydration(hydration)
	var/old_count = LAZYACCESS(data, "misc")
	LAZYSET(data, "misc", old_count + 1)
	M.jitteriness = min(M.jitteriness+4,10)
	if(data >= 25)		// 10 units, 45 seconds @ metabolism 0.4 units & tick rate 1.8 sec
		if(!M.stuttering)
			M.stuttering = 1
		M.stuttering = min(M.stuttering+4, 10)
		M.Dizzy(5)
	if(data >= 60)	// 30 units, 135 seconds
		M.jitteriness = 0
		M.stuttering = 0
		holder.remove_reagent(type, volume)	// maybe this is a little too perfect and a max() cap on the statuses would be better??
		return
	holder.remove_reagent(type, 0.4)	//fixed consumption to prevent balancing going out of whack

/datum/reagent/water/holywater/reaction_turf(turf/T, reac_volume)
	..()
	if(!istype(T))
		return
	T.Bless()

/datum/reagent/hydrogen_peroxide
	name = "Hydrogen peroxide"
	description = "An ubiquitous chemical substance that is composed of hydrogen and oxygen and oxygen." //intended intended
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha)
	taste_description = "burning water"
	var/cooling_temperature = 2
	glass_icon_state = "glass_clear"
	glass_name = "glass of oxygenated water"
	glass_desc = ""
	shot_glass_icon_state = "shotglassclear"

/*
 *	Water reaction to turf
 */

/datum/reagent/hydrogen_peroxide/reaction_turf(turf/open/T, reac_volume)
	if(!istype(T))
		return
	if(reac_volume >= 5)
		T.MakeSlippery(TURF_WET_WATER, 10 SECONDS, min(reac_volume*1.5 SECONDS, 60 SECONDS))
/*
 *	Water reaction to a mob
 */

/datum/reagent/hydrogen_peroxide/reaction_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with h2o2 can burn them !
	if(!istype(M))
		return
	if(method == TOUCH)
		M.adjustFireLoss(2, 0) // burns
	..()

/datum/reagent/carbon
	name = "Carbon"
	description = "A crumbly black solid that, while unexciting on a physical level, forms the base of all known life. Kind of a big deal."
	reagent_state = SOLID
	color = "#1C1300" // rgb: 30, 20, 0
	taste_description = "sour chalk"

/datum/reagent/carbon/reaction_turf(turf/T, reac_volume)
	var/obj/effect/decal/cleanable/dirt/D = locate() in T.contents
	if(!D)
		new /obj/effect/decal/cleanable/dirt(T)

/datum/reagent/phosphorus
	name = "Phosphorus"
	description = "A ruddy red powder that burns readily. Though it comes in many colors, the general theme is always the same."
	reagent_state = SOLID
	color = "#832828" // rgb: 131, 40, 40
	taste_description = "vinegar"

/datum/reagent/iron
	name = "Iron"
	description = "Pure iron is a metal."
	reagent_state = SOLID
	taste_description = "iron"

	color = "#606060" //pure iron? let's make it violet of course

/datum/reagent/iron/on_mob_life(mob/living/carbon/C)
	if(C.blood_volume < BLOOD_VOLUME_NORMAL)
		C.blood_volume += 0.5
	..()

/datum/reagent/fuel
	name = "Welding fuel"
	description = "Required for welders. Flammable."
	color = "#660000" // rgb: 102, 0, 0
	taste_description = "gross metal"
	glass_icon_state = "dr_gibb_glass"
	glass_name = "glass of welder fuel"
	glass_desc = ""

/datum/reagent/fuel/reaction_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with welding fuel to make them easy to ignite!
	if(method == TOUCH || method == VAPOR)
		M.adjust_fire_stacks(reac_volume / 10)
		return
	..()

/datum/reagent/fuel/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(1, 0)
	..()
	return TRUE

/// goon stuff
/datum/reagent/lye
	name = "Lye"
	description = "Also known as sodium hydroxide. As a profession making this is somewhat underwhelming."
	reagent_state = LIQUID
	color = "#FFFFD6" // very very light yellow
	taste_description = "acid"

/datum/reagent/yuck
	name = "Organic Slurry"
	description = "A mixture of various colors of fluid. Induces vomiting."
	glass_name = "glass of ...yuck!"
	glass_desc = ""
	color = "#545000"
	taste_description = "insides"
	taste_mult = 4
	can_synth = FALSE
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	var/yuck_cycle = 0 //! The `current_cycle` when puking starts.

/datum/reagent/yuck/on_mob_add(mob/living/L)
	if(HAS_TRAIT(src, TRAIT_NOHUNGER)) //they can't puke
		holder.del_reagent(type)

#define YUCK_PUKE_CYCLES 3 		// every X cycle is a puke
#define YUCK_PUKES_TO_STUN 3 	// hit this amount of pukes in a row to start stunning
/datum/reagent/yuck/on_mob_life(mob/living/carbon/C)
	if(!yuck_cycle)
		if(prob(8))
			var/dread = pick("Something is moving in my stomach...", \
				"A wet growl echoes from my stomach...", \
				"For a moment you feel like my surroundings are moving, but it's my stomach...")
			to_chat(C, "<span class='danger'>[dread]</span>")
			yuck_cycle = current_cycle
	else
		var/yuck_cycles = current_cycle - yuck_cycle
		if(yuck_cycles % YUCK_PUKE_CYCLES == 0)
			if(yuck_cycles >= YUCK_PUKE_CYCLES * YUCK_PUKES_TO_STUN)
				holder.remove_reagent(type, 5)
			C.vomit(rand(14, 26), stun = yuck_cycles >= YUCK_PUKE_CYCLES * YUCK_PUKES_TO_STUN)
	if(holder)
		return ..()
#undef YUCK_PUKE_CYCLES
#undef YUCK_PUKES_TO_STUN

/datum/reagent/yuck/on_mob_end_metabolize(mob/living/L)
	yuck_cycle = 0 // reset vomiting
	return ..()

/datum/reagent/yuck/on_transfer(atom/A, method=TOUCH, trans_volume)
	if(method == INGEST || !iscarbon(A))
		return ..()

	A.reagents.remove_reagent(type, trans_volume)
	A.reagents.add_reagent(/datum/reagent/fuel, trans_volume * 0.75)
	A.reagents.add_reagent(/datum/reagent/water, trans_volume * 0.25)

	return ..()

/datum/reagent/cellulose
	name = "Cellulose Fibers"
	description = "A crystaline polydextrose polymer, plants swear by this stuff."
	reagent_state = SOLID
	color = "#E6E6DA"
	taste_mult = 0
