/obj/effect/proc_holder/spell/self/overclock_arm
	name = "Valiant Arm"
	desc = "Release the limiters on your bronze arm for an increase in strength."
	overlay_state = "null"
	releasedrain = 50
	chargetime = 1
	recharge_time = 5 SECONDS
	warnie = "spellwarning"
	movement_interrupt = FALSE
	no_early_release = FALSE
	chargedloop = null
	sound = 'sound/magic/trickarm_eject.ogg'
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/craft/engineering //can be arcane, druidic, blood, holy
	cost = 1
	miracle = FALSE
	xp_gain = FALSE

	invocation = "Mutuatus Virtute!" //"Borrowed Valor" in latin. Thanks for the +1 nunos!
	invocation_type = "none" //can be none, whisper, emote and shout

var/ison = FALSE
	
/obj/effect/proc_holder/spell/self/overclock_arm/cast(list/targets, mob/user = usr)
	var/mob/living/target = usr
	if(ison == FALSE)
		target.apply_status_effect(/datum/status_effect/buff/overclock_arm1)
		target.visible_message(span_info("[user] racks their arm, it begins to rev and whirr with mechanical strength!"), span_info("You grip the safety lever on your arm and cock it! The cogs inside begin to hurtle around with centrifugal force!"))
		ison = TRUE
	else
		ison = FALSE
		target.remove_status_effect(/datum/status_effect/buff/overclock_arm1)
		target.visible_message(span_info("[user] slaps their arm, the metallic racket slows and dies down..."), span_info("You throw the safety lever back into place, the cogs rattle in relief..."))

//One prosthetic arm, one organic arm

/datum/status_effect/buff/overclock_arm1
	id = "Valiant Arm"
	alert_type = /atom/movable/screen/alert/status_effect/buff/overclock_arm1
	effectedstats = list("strength" = 1)

/datum/status_effect/buff/overclock_arm1/tick()
	. = ..()
	var/mob/living/target = owner
	var/obj/item/bodypart/right_arm = target.get_bodypart(BODY_ZONE_R_ARM)
	var/obj/item/bodypart/left_arm = target.get_bodypart(BODY_ZONE_L_ARM)
	if(right_arm.status == BODYPART_ROBOTIC && right_arm.get_damage() <= 80 && right_arm)
		target.apply_damage(5, BRUTE, BODY_ZONE_R_ARM)
		return
	if(left_arm.status == BODYPART_ROBOTIC && left_arm.get_damage() <= 80 && left_arm)
		target.apply_damage(5, BRUTE, BODY_ZONE_L_ARM)
		return
	target.remove_status_effect(/datum/status_effect/buff/overclock_arm1)
	target.visible_message(span_info("[owner]'s arm makes a horrible noise as it sparks and goes silent!"), span_info("Your arm stills and goes limp, unable to withstand any more punishment!"))
	ison = FALSE

/atom/movable/screen/alert/status_effect/buff/overclock_arm1
	name = "Valiant Arm"
	desc = "My bronze limb's limiters have been turned off! It's slowly falling apart in exchange for increased strength!"
	icon_state = "buff"

//Two Prosthetic arms
