// Places for most buffs spells. Single-target buffs get duration doubled on other people to encourage support mage (And not buff Zizoite Heretic to high heavens)

/obj/effect/proc_holder/spell/invoked/fortitude
	name = "Fortitude"
	desc = "Harden one's humors to the fatigues of the body. (-50% Stamina Usage)"
	cost = 1
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 4 SECONDS
	charge_max = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 7

/obj/effect/proc_holder/spell/invoked/fortitude/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		user.visible_message("[user] mutters an incantation and [spelltarget] briefly shines green.")
		to_chat(user, span_notice("With another person as a conduit, my spell's duration is doubled."))
		spelltarget.apply_status_effect(/datum/status_effect/buff/fortitude/other)
	else
		user.visible_message("[user] mutters an incantation and they briefly shine green.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/fortitude)

	return TRUE

/atom/movable/screen/alert/status_effect/buff/fortitude
	name = "Fortitude"
	desc = "My humors has been hardened to the fatigues of the body. (-50% Stamina Usage)"
	icon_state = "buff"

#define FORTITUDE_FILTER "fortitude_glow"
/datum/status_effect/buff/fortitude
	var/outline_colour ="#008000" // Forest green to avoid le sparkle mage
	id = "fortitude"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fortitude
	duration = 1 MINUTES

/datum/status_effect/buff/fortitude/other
	duration = 2 MINUTES

/datum/status_effect/buff/fortitude/on_apply()
	. = ..()
	var/filter = owner.get_filter(FORTITUDE_FILTER)
	if (!filter)
		owner.add_filter(FORTITUDE_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
	to_chat(owner, span_warning("My body feels lighter..."))
	ADD_TRAIT(owner, TRAIT_FORTITUDE, MAGIC_TRAIT)

/datum/status_effect/buff/fortitude/on_remove()
	. = ..()
	owner.remove_filter(FORTITUDE_FILTER)
	to_chat(owner, span_warning("The weight of the world rests upon my shoulders once more."))
	REMOVE_TRAIT(owner, TRAIT_FORTITUDE, MAGIC_TRAIT)

/obj/effect/proc_holder/spell/invoked/guidance
	name = "Guidance"
	overlay_state = "guidance"
	desc = "Makes one's hand travel true, blessing them with arcane luck in combat. (+15% chance to bypass parry / dodge, +15% chance to parry / dodge)"
	cost = 1
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 4 SECONDS
	charge_max = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 7

/obj/effect/proc_holder/spell/invoked/guidance/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		user.visible_message("[user] mutters an incantation and [spelltarget] briefly shines orange.")
		to_chat(user, span_notice("With another person as a conduit, my spell's duration is doubled."))
		spelltarget.apply_status_effect(/datum/status_effect/buff/guidance/other)
	else
		user.visible_message("[user] mutters an incantation and they briefly shine orange.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/guidance)

	return TRUE

#define GUIDANCE_FILTER "guidance_glow"
/atom/movable/screen/alert/status_effect/buff/guidance
	name = "Guidance"
	desc = "Arcane assistance guides my hands. (+15% chance to bypass parry / dodge, +15% chance to parry / dodge)"
	icon_state = "buff"

/datum/status_effect/buff/guidance
	var/outline_colour ="#f58e2d"
	id = "guidance"
	alert_type = /atom/movable/screen/alert/status_effect/buff/guidance
	duration = 1 MINUTES

/datum/status_effect/buff/guidance/other
	duration = 2 MINUTES

/datum/status_effect/buff/guidance/on_apply()
	. = ..()
	var/filter = owner.get_filter(GUIDANCE_FILTER)
	if (!filter)
		owner.add_filter(GUIDANCE_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
	to_chat(owner, span_warning("The arcane aides me in battle."))
	ADD_TRAIT(owner, TRAIT_GUIDANCE, MAGIC_TRAIT)

/datum/status_effect/buff/guidance/on_remove()
	. = ..()
	to_chat(owner, span_warning("My feeble mind muddies my warcraft once more."))
	owner.remove_filter(GUIDANCE_FILTER)
	REMOVE_TRAIT(owner, TRAIT_GUIDANCE, MAGIC_TRAIT)

#undef GUIDANCE_FILTER

/obj/effect/proc_holder/spell/invoked/haste
	name = "Haste"
	desc = "Cause a target to be magically hastened. (+5 Speed, 0.85 x Action Cooldown)"
	cost = 2
	xp_gain = TRUE
	releasedrain = 60
	chargedrain = 1
	chargetime = 1 SECONDS
	charge_max = 2 MINUTES
	warnie = "spellwarning"
	school = "transmutation"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 7

/obj/effect/proc_holder/spell/invoked/haste/cast(list/targets, mob/user)
	var/atom/A = targets[1]
	if(!isliving(A))
		revert_cast()
		return

	var/mob/living/spelltarget = A
	playsound(get_turf(spelltarget), 'sound/magic/haste.ogg', 80, TRUE, soundping = TRUE)

	if(spelltarget != user)
		user.visible_message("[user] mutters an incantation and [spelltarget] briefly shines yellow.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/haste/other)
		to_chat(user, span_notice("With another person as a conduit, my spell's duration is doubled."))
	else
		user.visible_message("[user] mutters an incantation and they briefly shine yellow.")
		spelltarget.apply_status_effect(/datum/status_effect/buff/haste)

	return TRUE
	
/atom/movable/screen/alert/status_effect/buff/haste
	name = "Haste"
	desc = "I am magically hastened."
	icon_state = "buff"

#define HASTE_FILTER "haste_glow"

/datum/status_effect/buff/haste
	var/outline_colour ="#F0E68C" // Hopefully not TOO yellow
	id = "haste"
	alert_type = /atom/movable/screen/alert/status_effect/buff/haste
	effectedstats = list("speed" = 5)
	duration = 1 MINUTES

/datum/status_effect/buff/haste/other
	duration = 2 MINUTES

/datum/status_effect/buff/haste/on_apply()
	. = ..()
	var/filter = owner.get_filter(HASTE_FILTER)
	if (!filter)
		owner.add_filter(HASTE_FILTER, 2, list("type" = "outline", "color" = outline_colour, "alpha" = 200, "size" = 1))
	to_chat(owner, span_warning("My limbs move with uncanny swiftness."))

/datum/status_effect/buff/haste/on_remove()
	. = ..()
	owner.remove_filter(HASTE_FILTER)
	to_chat(owner, span_warning("My body move slowly again..."))

#undef HASTE_FILTER

/datum/status_effect/buff/haste/nextmove_modifier()
	return 0.85

/obj/effect/proc_holder/spell/invoked/featherfall
	name = "Featherfall"
	desc = "Grant yourself and any creatures adjacent to you some defense against falls."
	cost = 1
	xp_gain = TRUE
	school = "transmutation"
	releasedrain = 50
	chargedrain = 0
	chargetime = 10 SECONDS
	charge_max = 2 MINUTES
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "jump"

/obj/effect/proc_holder/spell/invoked/featherfall/cast(list/targets, mob/user = usr)

	user.visible_message("[user] mutters an incantation and a dim pulse of light radiates out from them.")

	for(var/mob/living/L in range(1, usr))
		L.apply_status_effect(/datum/status_effect/buff/featherfall)

	return TRUE

/obj/effect/proc_holder/spell/invoked/longstrider
	name = "Longstrider"
	desc = "Grant yourself and any creatures adjacent to you free movement through rough terrain."
	cost = 1
	xp_gain = TRUE
	school = "transmutation"
	releasedrain = 50
	chargedrain = 0
	chargetime = 4 SECONDS
	charge_max = 1.5 MINUTES
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 7

/obj/effect/proc_holder/spell/invoked/longstrider/cast(list/targets, mob/user = usr)

	user.visible_message("[user] mutters an incantation and a dim pulse of light radiates out from them.")

	for(var/mob/living/L in range(1, usr))
		L.apply_status_effect(/datum/status_effect/buff/longstrider)

	return TRUE
