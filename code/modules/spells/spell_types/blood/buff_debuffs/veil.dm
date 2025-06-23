/obj/effect/proc_holder/spell/self/blood_veil
	name = "Veil"
	desc = "Lift your veil or put it on"
	cost = 1
	xp_gain = TRUE
	releasedrain = 0
	chargedrain = 1
	chargetime = 1 SECONDS
	warnie = "spellwarning"
	school = "blood"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 1 // What vampire level are we?
	invocation = ""
	invocation_type = "whisper"
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	/* reenable when on newer code
	recharge_time = 2 MINUTES
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	vitaedrain = 100*/
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = null //is there a bad trait we want to associate? the code name
	badtraitname = null //is there a bad trait we want to associate? the player name
	badtraitdesc = null //is there a bad trait we want to associate? the player description

/*
/mob/living/carbon/human/proc/blood_veil()
	set name = "Vampire Veil"
	set category = "VAMPIRE"

	var/mob/living/carbon/human/H = src
	//var/datum/antagonist/bloodsucker/BS = mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(!HAS_TRAIT(H,TRAIT_VAMPIRISM))
		return
	if(has_status_effect(/datum/status_effect/debuff/veil_up))
		H.bloodsucker_undisguise(H)
		return
	if(has_status_effect(/datum/status_effect/buff/veil_down))
		H.bloodsucker_disguise(H)
	if(!has_status_effect(/datum/status_effect/buff/veil_down) && !has_status_effect(/datum/status_effect/debuff/veil_up)) 
		H.bloodsucker_disguise(H)
	if(H.vitae < 100)
		to_chat(src, span_warning("Not enough vitae blood."))
		return
	src.playsound_local(get_turf(src), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)*/

/obj/effect/proc_holder/spell/self/blood_veil/cast(list/targets, mob/living/user = usr)
	var/mob/living/carbon/human/H = usr
	//var/datum/antagonist/bloodsucker/BS = mind.has_antag_datum(/datum/antagonist/bloodsucker)
	if(!HAS_TRAIT(H,TRAIT_VAMPIRISM))
		to_chat(src, span_warning("I'm not a vampire, what am I doing?"))
		return
	if(H.has_status_effect(/datum/status_effect/debuff/veil_up))
		to_chat(src, span_greentext("I raise my veil"))
		H.bloodsucker_undisguise(H)
		return
	if(H.has_status_effect(/datum/status_effect/buff/veil_down))
		to_chat(src, span_greentext("I lower my veil"))
		H.bloodsucker_disguise(H)
	if(!H.has_status_effect(/datum/status_effect/buff/veil_down) && !H.has_status_effect(/datum/status_effect/debuff/veil_up)) 
		to_chat(src, span_greentext("I raise my veil"))
		H.bloodsucker_disguise(H)
	if(H.vitae < 100)
		to_chat(src, span_warning("Not enough vitae to keep up my veil."))
		return
	H.playsound_local(get_turf(H), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
