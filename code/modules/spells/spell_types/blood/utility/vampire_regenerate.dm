/obj/effect/proc_holder/spell/self/vampire_regenerate
	name = "Vampiric Regeneration"
	desc = "Regenerate using half of my blood (300 used minimum)"
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
	charging_slowdown = 300
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/blood
	goodtrait = null //is there a good trait we want to associate? the code name
	badtrait = TRAIT_VAMP_HEAL_LIMIT //is there a bad trait we want to associate? the code name
	badtraitname = "Healing Abilities Limit" //is there a bad trait we want to associate? the player name
	badtraitdesc = "You can only have one ability that gives a heal. Affects regeneration, passive regeneration, batform, and mistform" //is there a bad trait we want to associate? the player description
	/* reenable when on newer code
	recharge_time = 2 MINUTES
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_MEDIUM
	vitaedrain = 300*/



/obj/effect/proc_holder/spell/self/vampire_regenerate/cast(list/targets, mob/living/user = usr)
	var/silver_curse_status = FALSE
	var/mob/living/carbon/human/H = usr
	var/temp_vitae = H.vitae

	silver_curse_status = H.has_status_effect(/datum/status_effect/debuff/silver_curse)
	if(silver_curse_status)
		to_chat(H, span_warning("My BANE is not letting me heal!."))
		return

	if(!HAS_TRAIT(H,TRAIT_VAMPIRISM))
		to_chat(H, span_warning("I'm not a vampire, what am I doing?"))
		return
	if(H.has_status_effect(/datum/status_effect/debuff/veil_up))
		to_chat(H, span_warning("My curse is hidden."))
		return
	if(H.vitae < 600)
		to_chat(H, span_warning("Not enough vitae."))
		return
	to_chat(H, span_greentext("! REGENERATE !"))
	H.playsound_local(get_turf(H), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	
	if(H.vitae > 600)
		H.vitae -= temp_vitae/2
	else
		H.vitae -= 300
	H.fully_heal()
	H.regenerate_limbs()
