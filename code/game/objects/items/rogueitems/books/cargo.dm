/obj/item/book/rogue/secret/ledger
	name = "catatoma"
	icon_state = "ledger_0"
	base_icon_state = "ledger"
	title = "Catatoma"
	dat = "To create a shipping order, use a papyrus on me."

/obj/item/book/rogue/secret/ledger/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/paper/scroll/cargo))
		if(!open)
			to_chat(user, span_info("Open me first."))
			return FALSE
		var/obj/item/paper/scroll/cargo/C = I
		if(C.orders.len > 4)
			to_chat(user, span_warning("Too much order."))
			return
		var/picked_cat = input(user, "Categories", "Shipping Ledger") as null|anything in sortList(SSmerchant.supply_cats)
		if(!picked_cat)
			testing("yeye")
			return
		var/list/pax = list()
		for(var/pack in SSmerchant.supply_packs)
			var/datum/supply_pack/PA = SSmerchant.supply_packs[pack]
			if(PA.group == picked_cat)
				pax += PA

		var/datum/supply_pack/picked_pack = input(user, "Shipments", "Shipping Ledger") as null|anything in sortList(pax)
		if(!picked_pack)
			return

		C.orders += picked_pack
		C.rebuild_info()
		return
	if(istype(I, /obj/item/paper/scroll))
		if(!open)
			to_chat(user, span_info("Open me first."))
			return FALSE
		var/obj/item/paper/scroll/P = I
		if(P.info)
			to_chat(user, span_warning("Something is written here already."))
			return
		var/picked_cat = input(user, "Categories", "Shipping Ledger") as null|anything in sortList(SSmerchant.supply_cats)
		if(!picked_cat)
			return
		var/list/pax = list()
		for(var/pack in SSmerchant.supply_packs)
			var/datum/supply_pack/PA = SSmerchant.supply_packs[pack]
			if(PA.group == picked_cat)
				pax += PA
		var/datum/supply_pack/picked_pack = input(user, "Shipments", "Shipping Ledger") as null|anything in sortList(pax)
		if(!picked_pack)
			return
		var/obj/item/paper/scroll/cargo/C = new(user.loc)

		C.orders += picked_pack
		C.rebuild_info()
		user.dropItemToGround(P)
		qdel(P)
		user.put_in_active_hand(C)
	..()
