/obj/item/book/rogue/solastra_lunata
	name = "Solastra Lunata"
	icon_state = "bibble_0"
	base_icon_state = "bibble"
	bookfile = "religious/solastra_lunata.json"

/obj/item/book/rogue/solastra_lunata/attack(mob/living/M, mob/user)
	if(user.mind && user.mind.assigned_role == "Priest")
		if(!user.can_read(src))
			to_chat(user, span_warning("I don't understand these scribbly black lines."))
			return
		M.apply_status_effect(/datum/status_effect/buff/blessed)
		M.add_stress(/datum/stressevent/blessed)
		user.visible_message(span_notice("[user] blesses [M]."))
		playsound(user, 'sound/magic/bless.ogg', 100, FALSE)
		return

/datum/status_effect/buff/blessed
	id = "blessed"
	alert_type = /atom/movable/screen/alert/status_effect/buff/blessed
	effectedstats = list("fortune" = 1)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/blessed
	name = "Blessed"
	desc = ""
	icon_state = "buff"
