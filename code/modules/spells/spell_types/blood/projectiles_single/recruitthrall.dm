/obj/effect/proc_holder/spell/targeted/recruitthrall
	name = "Recruit Thrall"
	desc = "recruit a thrall to become a fledgling"
	antimagic_allowed = TRUE
	//charge_max = 150
	max_targets = 1
	cost = 4 //how many points it takes
	releasedrain = 0
	chargedrain = 1
	chargetime = 1 SECONDS
	warnie = "spellwarning"
	school = "blood"
	no_early_release = TRUE
	movement_interrupt = FALSE
	spell_tier = 4 // What vampire level are we?
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

/obj/effect/proc_holder/spell/targeted/recruitthrall/cast(list/targets,mob/user = usr)
	..()
	var/inputty = input("Make a dark offer", "VAMPIRE") as text|null
	if(inputty)
		user.say(inputty, forced = "spell")
		var/mob/living/carbon/human/BS = user.mind.has_antag_datum(/datum/antagonist/bloodsucker)
		for(var/mob/living/carbon/human/L in get_hearers_in_view(1, get_turf(user)))
			addtimer(CALLBACK(L,TYPE_PROC_REF(/mob/living/carbon/human, rev_ask), user,BS,inputty),1)

/mob/living/carbon/human/proc/vamp_ask(mob/living/carbon/human/guy,mob/living/carbon/human/caster,offer)
	if(!guy || !offer)
		return
	if(!mind)
		return
	if(!client)
		return
	if(HAS_TRAIT(src,TRAIT_VAMPIRISM))
		to_chat(src,span_danger("I am already a vampire"))
		to_chat(guy,span_danger("They are already a vampire"))
	if(HAS_TRAIT(src,TRAIT_BLOOD_THRALL))
		to_chat(src,span_danger("I am already a Thrall"))
		to_chat(guy,span_danger("They are already a Thrall"))
	if(mind)
		if(mind.special_role)
			return
	if(mob_timers["thralloffer"])
		return
	var/shittime = world.time
	playsound_local(src, 'sound/misc/rebel.ogg', 100, FALSE)
	var/garbaggio = alert(src, "[offer]","Become a Thrall?", "Yes", "No")
	if(world.time > shittime + 35 SECONDS)
		to_chat(src,span_danger("Too late."))
		return
	mob_timers["thralloffer"] = world.time
	if(garbaggio == "Yes")
		if(caster.bs_thrall >= 1)
			to_chat(src,span_danger("They have too many Thralls"))
			to_chat(guy,span_danger("I have too many Thralls"))
			//RT.offers2join += span_info("<B>[real_name]</B> <span class='red'>REJECTED</span> [guy.real_name]: \"[offer]\"")
		else
			//RT.offers2join += span_info("<B>[real_name]</B> <span class='blue'>ACCEPTED</span> [guy.real_name]: \"[offer]\"")
			to_chat(guy,span_blue("[src] makes a dark choice."))
			ADD_TRAIT(src, TRAIT_BLOOD_THRALL, GENERIC)
			//we need to add the thrall trait "TRAIT_BLOOD_THRALL" here
			caster.bs_thrall += 1
			//we remove the spell, we made a thrall, we might add an endless thrall perk for a lord later
			if (HAS_TRAIT(caster,TRAIT_VAMP_ANCIENT) && caster.bs_thrall < 6)
				//we don't do anything if they are an ancient vampire and under 5 thralls
			else
				caster.mind.RemoveSpell(/obj/effect/proc_holder/spell/targeted/recruitthrall)
	else
		to_chat(src,span_danger("I reject the offer."))
		to_chat(guy,span_danger("[src] rejects the offer."))
		//RT.offers2join += span_info("<B>[real_name]</B> <span class='red'>REJECTED</span> [guy.real_name]: \"[offer]\"")
