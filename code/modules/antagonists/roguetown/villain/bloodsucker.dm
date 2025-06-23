/mob/living/carbon/human/verb/become_bloodsucker()
	//set category = "DEBUGTEST"
	set name = "BLOODSUCKER"
	if(mind)
		var/datum/antagonist/bloodsucker/new_antag = new /datum/antagonist/bloodsucker()
		mind.add_antag_datum(new_antag)

//basic bloodsucker references
/datum/antagonist/bloodsucker
	name = "Bloodsucker"
	roundend_category = "Bloodsuckers"
	antagpanel_category = "Bloodsucker"
	job_rank = ROLE_BLOODSUCKER
	antag_hud_type = ANTAG_HUD_TRAITOR
	antag_hud_name = "vampire"
//starting traits 
	var/list/inherent_traits = list(TRAIT_STRONGBITE, 
									TRAIT_NOHUNGER, 
									TRAIT_NOBREATH, 
									TRAIT_TOXIMMUNE, 
									TRAIT_STEELHEARTED, 
									TRAIT_GRAVEROBBER,
									TRAIT_NOSLEEP, 
									TRAIT_VAMPMANSION, 
									TRAIT_VAMP_DREAMS,
									TRAIT_VAMPIRISM,)
	//confession lines if caught
	/*confess_lines = list(
		"I WANT TO YOUR DRINK BLOOD!",
		"BLOOD I MUST HAVE BLOOD!",
		"LET ME DRINK OF YOUR BLOOD!",
	)*/
	rogue_enabled = TRUE
	//starting disguised
	var/disguised = TRUE
	//starting vitae, moved this to 
	//var/vitae = 1000 
	var/last_transform
	var/is_lesser = FALSE
	//caching a players looks, this has not worked before
	var/new_bloodsucker = FALSE
	var/ancient_bloodsucker = FALSE
	var/sired = FALSE
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform //attached to the datum itself to avoid cloning memes, and other duplicates
	var/obj/effect/proc_holder/spell/targeted/shapeshift/gaseousform/gas

//inspection references
/datum/antagonist/vampire/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(istype(examined_datum, /datum/antagonist/bloodsucker))
		return span_boldnotice("A bloodsucker, like me")
	if(istype(examined_datum, /datum/antagonist/bloodsucker/lesser))
		return span_boldnotice("A fledgling bloodsucker")
	if(istype(examined_datum, /datum/antagonist/vampire/lesser))
		return span_boldnotice("A child of Kain.")
	if(istype(examined_datum, /datum/antagonist/vampire))
		return span_boldnotice("An elder Kin.")
	if(examiner.Adjacent(examined))
		if(istype(examined_datum, /datum/antagonist/werewolf/lesser))
			if(!disguised)
				return span_boldwarning("I sense a lesser Werewolf.")
		if(istype(examined_datum, /datum/antagonist/werewolf))
			if(!disguised)
				return span_boldwarning("THIS IS AN ELDER WEREWOLF! MY ENEMY!")
	if(istype(examined_datum, /datum/antagonist/zombie))
		return span_boldnotice("Another deadite.")
	if(istype(examined_datum, /datum/antagonist/skeleton))
		return span_boldnotice("Another deadite.")

/datum/antagonist/vampire/lesser/roundend_report()
	return


//setup a process if someone is turned into a vampire midround
/datum/antagonist/bloodsucker/on_gain()
	var/datum/game_mode/C = SSticker.mode
	C.bloodsuckers |= owner
	. = ..()
	owner.special_role = name

	for(var/inherited_trait in inherent_traits)
		//ADD_TRAIT(owner.current, inherited_trait, "[type]") commenting out, need to find out where to set a "type"
		ADD_TRAIT(owner.current, inherited_trait, TRAIT_GENERIC)

	owner.current.cmode_music = 'sound/music/combat_vamp2.ogg'
	owner.adjust_skillrank(/datum/skill/magic/vampirism, 1, TRUE)
	owner.adjust_skillrank(/datum/skill/magic/blood, 1, TRUE)
	if(!sired)
		owner.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE)
		owner.adjust_skillrank(/datum/skill/combat/unarmed, 6, TRUE)
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfix)
	owner.current.AddSpell(new /obj/effect/proc_holder/spell/self/blood_veil)
	if (ancient_bloodsucker)
		owner.adjust_skillrank(/datum/skill/magic/vampirism, 5, TRUE)
		owner.adjust_skillrank(/datum/skill/magic/blood, 5, TRUE)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/self/vampire_blood_vision)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/vampire_subjugate)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/vampire_blood_lightning)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/vampire_blood_steal)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/recruitthrall)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/shapeshift/vampire_bat)
		owner.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/shapeshift/vampire_mistform)
		owner.adjust_vamppoints(6)

	if(increase_votepwr)
		forge_bloodsucker_objectives()
	if (new_bloodsucker)
		//we give fewer points to new spawn
		owner.adjust_vamppoints(-4)
		finalize_bloodsucker_lesser()
		greet()
	
	else
		forge_bloodsucker_objectives()
		finalize_bloodsucker()
		//starting vampire points, raise or lower
		owner.adjust_vamppoints(0)
	//owner.current.verbs |= /mob/living/carbon/human/proc/disguise_button
	//owner.current.verbs |= /mob/living/carbon/human/proc/vamp_regenerate
	//if(!is_lesser)
	//	owner.current.verbs |= /mob/living/carbon/human/proc/blood_strength
	//	owner.current.verbs |= /mob/living/carbon/human/proc/blood_celerity
	//	owner.current.verbs |= /mob/living/carbon/human/proc/blood_fortitude
	var/mob/living/carbon/human/H = owner.current
	//storing the player's sink tone
	H.cache_skin = H.skin_tone
	H.cache_eyes = H.hair_color
	H.cache_hair = H.eye_color
	H.bloodsucker_disguise(H)
	return ..()

//setup a process if someone cured of vampirism
/datum/antagonist/bloodsucker/on_removal()
	if(!silent && owner.current)
		to_chat(owner.current,span_danger("I am no longer a [job_rank]!"))
	owner.special_role = null
	if(!isnull(batform))
		owner.current.RemoveSpell(batform)
		QDEL_NULL(batform)
	return ..()

//populate their objectives
/datum/antagonist/bloodsucker/proc/add_objective(datum/objective/O)
	objectives += O

/datum/antagonist/bloodsucker/proc/remove_objective(datum/objective/O)
	objectives -= O

/datum/antagonist/bloodsucker/proc/forge_bloodsucker_objectives()
	if(!(locate(/datum/objective/escape) in objectives))
		var/datum/objective/bloodsucker/escape_objective = new
		escape_objective.owner = owner
		add_objective(escape_objective)
		return

//announcement to the player they are a vampire
/datum/antagonist/bloodsucker/greet()
	to_chat(owner.current, span_userdanger("Ever since that bite, I have been a VAMPIRE."))
	owner.announce_objectives()
	..()
/datum/antagonist/bloodsucker/lesser/greet()
	to_chat(owner.current, span_userdanger("I must learn from other vampires and become more powerful"))
	owner.announce_objectives()

/datum/antagonist/bloodsucker/lesser/greet()
	to_chat(owner.current, span_userdanger("I awaken from years of slumber, what has changed in this land?"))
	owner.announce_objectives()

//finalize becoming a vampire
/datum/antagonist/bloodsucker/proc/finalize_bloodsucker()
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)

/datum/antagonist/bloodsucker/proc/finalize_bloodsucker_lesser()
	if(!sired)
		owner.current.forceMove(pick(GLOB.vspawn_starts))
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)

/datum/antagonist/bloodsucker/proc/finalize_bloodsucker_ancient()
	if(!sired)
		owner.current.forceMove(pick(GLOB.vlord_starts))
	owner.current.playsound_local(get_turf(owner.current), 'sound/music/vampintro.ogg', 80, FALSE, pressure_affected = FALSE)

// SPAWN
/datum/antagonist/bloodsucker/lesser
	name = "Vampire Spawn"
	antag_hud_name = "Vspawn"
	inherent_traits = list(TRAIT_STRONGBITE, 
						   TRAIT_NOHUNGER, 
						   TRAIT_NOBREATH, 
						   TRAIT_TOXIMMUNE, 
						   TRAIT_STEELHEARTED, 
						   TRAIT_GRAVEROBBER,
						   TRAIT_NOSLEEP, 
						   TRAIT_ZOMBIE_IMMUNE,
						   TRAIT_VAMPMANSION, 
						   TRAIT_VAMP_DREAMS,
						   TRAIT_VAMPIRISM,)
	/*confess_lines = list(
		"THE CRIMSON CALLS!",
		"MY MASTER COMMANDS",
		"THE SUN IS ENEMY!",
	)*/
	new_bloodsucker = TRUE

// Ancient
/datum/antagonist/bloodsucker/ancient
	name = "Ancient Vampire"
	antag_hud_name = "Vancient"
	inherent_traits = list(TRAIT_STRONGBITE, 
						   TRAIT_NOHUNGER, 
						   TRAIT_NOBREATH, 
						   TRAIT_TOXIMMUNE, 
						   TRAIT_STEELHEARTED, 
						   TRAIT_GRAVEROBBER,
						   TRAIT_NOSLEEP, 
						   TRAIT_ZOMBIE_IMMUNE,
						   TRAIT_VAMPMANSION, 
						   TRAIT_VAMP_DREAMS,
						   TRAIT_VAMPIRISM,
						   TRAIT_NOBLE,
						   TRAIT_NOPAIN,
						   TRAIT_NOROGSTAM, 
						   TRAIT_HEAVYARMOR, 
						   TRAIT_COUNTERCOUNTERSPELL,
						   TRAIT_LOW_METABOLISM,
						   TRAIT_EFFICIENT_DRINKER,
						   TRAIT_NOVEGAN,
						   TRAIT_PERMADUST,)
	/*confess_lines = list(
		"THE CRIMSON CALLS!",
		"MY MASTER COMMANDS",
		"THE SUN IS ENEMY!",
	)*/
	new_bloodsucker = TRUE


/* moved this to "/code/modules/mob/living/carbon/human/species.dm" under the digestion section
//this is where fires start... vampires catching on fire in the sun
/datum/antagonist/bloodsucker/on_life(mob/user)
	if(!user)
		return
	var/mob/living/carbon/human/H = user
	if(H.stat == DEAD)
		return
	if(H.advsetup)
		return

	if(world.time % 5)
		if(GLOB.tod != "night")
			if(isturf(H.loc))
				var/turf/T = H.loc
				if(T.can_see_sky())
					if(T.get_lumcount() > 0.15)
						if(!HAS_TRAIT(H,TRAIT_SUN_RESIST))
							if(has_status_effect(/datum/status_effect/buff/veil_down) && HAS_TRAIT(H,TRAIT_SUN_WEAKNESS))
								H.fire_act(1,10)
							else
								H.fire_act(1,5)

	if(H.on_fire)
		if(has_status_effect(/datum/status_effect/buff/veil_up))
			last_transform = world.time
			H.bloodsucker_undisguise(src)
		H.freak_out()

	if(H.stat)
		if(istype(H.loc, /obj/structure/closet/crate/coffin))
			H.fully_heal()
	var/vampskill = H.mind.get_skill_level(/datum/skill/magic/vampirism)
	//we'll set higher blood levels per level
	if(vampskill < 2)
		vitae = CLAMP(vitae, 0, 1666)
	if(vampskill == 3)
		vitae = CLAMP(vitae, 0, 2000)
	if(vampskill == 4)
		vitae = CLAMP(vitae, 0, 2500)
	if(vampskill == 5)
		vitae = CLAMP(vitae, 0, 3000)
	if(vampskill == 6)
		vitae = CLAMP(vitae, 0, 3500)

//this drops the disguise if you run out of blood or dusts someone
	if(vitae > 0)
		H.blood_volume = BLOOD_VOLUME_MAXIMUM
		if(vitae < 100)
			if(has_status_effect(/datum/status_effect/buff/veil_up))
				to_chat(H, "<span class='warning'>My veil fails!</span>")
				H.bloodsucker_undisguise(src)
		//this controls the vitae tick rate!
		if(istype(H.loc, /obj/structure/closet/crate/coffin))
			vitae -= 0 //no vitae drain while in a coffin
		if(has_status_effect(/datum/status_effect/buff/veil_up))
			vitae -= .5 //low vitae drain rate
		if(has_status_effect(/datum/status_effect/buff/veil_down) && HAS_TRAIT(H,TRAIT_LOW_METABOLISM))
			vitae -= .5 //low vitae drain rate
		if(has_status_effect(/datum/status_effect/buff/veil_up) && HAS_TRAIT(H,TRAIT_LOW_METABOLISM))
			vitae -= .25 //low vitae drain rate
		if(has_status_effect(/datum/status_effect/buff/veil_down) && HAS_TRAIT(H,TRAIT_HIGH_METABOLISM))
			vitae -= 2 //high vitae drain rate
		else
			vitae -= 1 //normal Vitae drain rate
	else
		to_chat(H, "<span class='userdanger'>I RAN OUT OF VITAE!</span>")
		//comment out the dusting code, maybe we can make them pass out? how do we ghost em instead?
		//var/obj/shapeshift_holder/SS = locate() in H
		//if(SS)
		//	SS.shape.dust()
		//H.dust()
		return
*/
/* moved this to "/code/modules/mob/living/carbon/human/species.dm"
/mob/living/carbon/human/proc/bloodsucker_disguise(datum/antagonist/bloodsucker/BS)
	if(!BS)
		return
	BS.disguised = TRUE
	apply_status_effect(/datum/status_effect/buff/veil_up)
	remove_status_effect(/datum/status_effect/buff/veil_down)
	skin_tone = BS.cache_skin
	hair_color = BS.cache_hair
	eye_color = BS.cache_eyes
	facial_hair_color = BS.cache_hair
	update_body()
	update_hair()
	update_body_parts(redraw = TRUE)

/mob/living/carbon/human/proc/vampire_undisguise(datum/antagonist/bloodsucker/BS)
	if(!BS)
		return
	BS.disguised = FALSE
	apply_status_effect(/datum/status_effect/buff/veil_down)
	remove_status_effect(/datum/status_effect/buff/veil_up)
	BS.cache_skin = skin_tone
	BS.cache_eyes = eye_color
	BS.cache_hair = hair_color
	skin_tone = "c9d3de"
	hair_color = "181a1d"
	facial_hair_color = "181a1d"
	eye_color = "ff0000"
	update_body()
	update_hair()
	update_body_parts(redraw = TRUE)

*/

// OBJECTIVES STORED HERE TEMPORARILY FOR EASE OF REFERENCE
/datum/objective/bloodsucker/announce
	name = "announce"
	explanation_text = "Sit on the thrown and let others know of Vampire's existance"
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/bloodsucker/announce/check_completion()
	return TRUE

/*Maybe we'll bring this back with rituals, rather than just drinking a buncha blood
/datum/objective/bloodsucker/sun
	name = "sun"
	explanation_text = "I must conquer the Sun and block it from the sky."
	team_explanation_text = ""
	triumph_count = 5

/datum/objective/bloodsucker/sun/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(C.ascended)
		return TRUE
*/

/datum/objective/bloodsucker/infiltrate/one
	name = "infiltrate1"
	explanation_text = "Make a new fledgingling to carry on this era"
	triumph_count = 5

/datum/objective/bloodsucker/infiltrate/one/check_completion()
	//var/datum/game_mode/chaosmode/C = SSticker.mode
	//for(var/datum/mind/V in C.bloodsucker)
	//need a way to see if the player turned someone 
	return TRUE

/datum/objective/sun/drink
	name = "Drink"
	explanation_text = "I must Drink 3000 litres of Vitae"
	triumph_count = 1

/datum/objective/bloodsuckersurvive/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(!C.vlord.stat)
		return TRUE

/datum/objective/bloodsuckersurvive
	name = "survive"
	explanation_text = "I must survive to see the next Era"
	triumph_count = 3

/datum/objective/bloodsuckersurvive/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(!C.vlord.stat)
		return TRUE


/datum/antagonist/bloodsucker/roundend_report()
	var/traitorwin = TRUE

	printplayer(owner)

	var/count = 0
	if(new_bloodsucker) // don't need to spam up the chat with all spawn
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				else
					to_chat(owner, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
					traitorwin = FALSE
				count += objective.triumph_count
	else
		if(objectives.len)//If the traitor had no objectives, don't need to process this.
			for(var/datum/objective/objective in objectives)
				objective.update_explanation_text()
				if(objective.check_completion())
					to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				else
					to_chat(world, "<B>Goal #[count]</B>: [objective.explanation_text] <span class='redtext'>Failure.</span>")
					traitorwin = FALSE
				count += objective.triumph_count

	var/special_role_text = lowertext(name)
	if(traitorwin)
		if(count)
			if(owner)
				owner.adjust_triumphs(count)
		to_chat(world, span_greentext("The [special_role_text] has TRIUMPHED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/triumph.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, span_redtext("The [special_role_text] has FAILED!"))
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/fail.ogg', 100, FALSE, pressure_affected = FALSE)

// LANDMARKS

/obj/effect/landmark/start/bloodsucker
	name = "Bloodsucker Respawn"
	icon_state = "arrow"
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/bloodsucker/Initialize()
	. = ..()
	GLOB.vlord_starts += loc
