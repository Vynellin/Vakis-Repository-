/obj/effect/proc_holder/spell/self/vampire_celerity
	name = "Celerity"
	desc = "Speed up my movements with the power of blood"
	cost = 2 //how many points it takes
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

/obj/effect/proc_holder/spell/self/vampire_celerity/cast(list/targets, mob/living/user = usr)
	var/mob/living/carbon/human/H = usr
	//var/temp_vitae = H.vitae //use this to store vitae if we need a dynamic cost

	/*Left here if we want to nerf a skill with a silver curse
	silver_curse_status = H.has_status_effect(/datum/status_effect/debuff/silver_curse)
	if(silver_curse_status)
		to_chat(H, span_warning("My BANE is not letting me use this ability!."))
		return */

	if(!HAS_TRAIT(H,TRAIT_VAMPIRISM))
		to_chat(H, span_warning("I'm not a vampire, what am I doing?"))
		return
	if(H.has_status_effect(/datum/status_effect/debuff/veil_up))
		to_chat(H, span_warning("My curse is hidden."))
		return
	if(H.vitae < 100)
		to_chat(H, span_warning("Not enough vitae."))
		return
	if(H.has_status_effect(/datum/status_effect/buff/vampire_celerity))
		to_chat(H, span_warning("Already active."))
		return
	H.vitae -= 100
	H.rogstam_add(2000)
	H.apply_status_effect(/datum/status_effect/buff/vampire_celerity)
	to_chat(H, span_greentext("! SPEED OF DARKNESS !"))
	H.playsound_local(get_turf(H), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
