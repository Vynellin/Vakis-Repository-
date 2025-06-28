/obj/effect/proc_holder/spell/invoked/warlock/summon_weapon
	name = "Summon Pact Weapon"
	desc = "Summon your bound weapon to your side, reforging it if it has been lost."
	overlay_state = "arcane_cast"
	invocation = "Duregos meklom."
	invocation_type = "whisper"
	glow_color = GLOW_COLOR_VAMPIRIC
	glow_intensity = GLOW_INTENSITY_LOW
	recharge_time = 10 SECONDS
	chargetime = 5 SECONDS
	xp_gain = TRUE

/obj/effect/proc_holder/spell/invoked/warlock/summon_weapon/cast(list/targets, mob/living/carbon/human/user = usr)
	if(!user.mind || !user.mind.warlock_weapon_type)
		to_chat(user, span_warning("You feel no weapon bound to your soul."))
		revert_cast()
		return FALSE

	// Weapon exists and is somewhere?
	if(user.mind.warlock_weapon)
		var/obj/item/existing_weapon = user.mind.warlock_weapon

		to_chat(user, span_notice("Your blade tears through the veil and returns to your hand!"))
		user.put_in_hands(existing_weapon)
		return TRUE

	// Weapon needs to be remade
	var/obj/item/new_weapon = new user.mind.warlock_weapon_type(user.loc)
	new_weapon.AddComponent(/datum/component/pact_weapon, user, user.patronchoice)
	new_weapon.AddComponent(/datum/component/singing_item, user, user.patronchoice, new_weapon)

	user.mind.warlock_weapon = new_weapon

	to_chat(user, span_notice("You reach into the void... and draw forth your bound weapon anew."))
	user.put_in_hands(new_weapon)

	return TRUE
