#define TOPAZ_CAST_TIME_REDUCTION 0.1
#define EMERALD_CAST_TIME_REDUCTION 0.15
#define SAPPHIRE_CAST_TIME_REDUCTION 0.2
#define QUARTZ_CAST_TIME_REDUCTION 0.25
#define RUBY_CAST_TIME_REDUCTION 0.3
#define DIAMOND_CAST_TIME_REDUCTION 0.35
#define RIDDLE_OF_STEEL_CAST_TIME_REDUCTION 0.4

//we use discrete staff objs so that they can be easily thrown into loot tables and maps without complex varediting

/obj/item/rogueweapon/woodstaff
	var/cast_time_reduction = null

/obj/item/rogueweapon/woodstaff/prepared
	name = "prepared wooden staff"
	desc = "A stave of hardwood that has had its head cut and splayed in preparation \
	of receiving a keen arcyne focus."
	icon = 'icons/obj/staffs.dmi'
	icon_state = "gemless"

/obj/item/rogueweapon/woodstaff/prepared/toper
	name = "toper-focused staff"
	desc = "An amber focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "topazstaff"
	cast_time_reduction = TOPAZ_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF //imagine the salt

/obj/item/rogueweapon/woodstaff/prepared/amethyst
	name = "amethyst-focused staff"
	desc = "A purple focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "amethyststaff"
	cast_time_reduction = TOPAZ_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF

/obj/item/rogueweapon/woodstaff/prepared/emerald
	name = "gemerald-focused staff"
	desc = "A glistening green focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "emeraldstaff"
	cast_time_reduction = EMERALD_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF

/obj/item/rogueweapon/woodstaff/prepared/sapphire
	name = "saffira-focused staff"
	desc = "A beautiful blue focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "sapphirestaff"
	cast_time_reduction = SAPPHIRE_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF

/obj/item/rogueweapon/woodstaff/prepared/quartz
	name = "blortz-focused staff"
	desc = "A crystal-clear focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "quartzstaff"
	cast_time_reduction = QUARTZ_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF

/obj/item/rogueweapon/woodstaff/prepared/ruby
	name = "ronts-focused staff"
	desc = "A sanguine focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "rubystaff"
	cast_time_reduction = RUBY_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF

/obj/item/rogueweapon/woodstaff/prepared/diamond
	name = "dorpel-focused staff"
	desc = "A beautifully faceted focus-gem hewn by pressure immense sits nestled in crown of this staff."
	icon_state = "diamondstaff"
	cast_time_reduction = DIAMOND_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF

/obj/item/rogueweapon/woodstaff/prepared/riddle_of_steel
	name = "\improper Staff of the Riddle-Steel"
	desc = "Flame dances within the focus-gem of this mighty staff at a rhythm and intensity to match the \
	mage that wields it."
	icon_state = "riddlestaff"
	cast_time_reduction = RIDDLE_OF_STEEL_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF

/obj/item/rogueweapon/woodstaff/prepared/riddle_of_steel/magos
	name = "\improper Staff of the Court Magos"
	icon_state = "courtstaff"

/obj/item/rogueweapon/woodstaff/naledi
	cast_time_reduction = DIAMOND_CAST_TIME_REDUCTION
	resistance_flags = FIRE_PROOF

//slapcrafting stuff

/obj/item/rogueweapon/woodstaff/prepared/attackby(obj/item/arcyne_focus, mob/living/carbon/human/user, params)
	if(istype(arcyne_focus, /obj/item/roguegem/yellow))
		var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
		if(do_after(user, crafttime, target = src))
			if(isarcyne(user))
				playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
				user.visible_message(span_warning("[user] slots [user.p_their()] [arcyne_focus] into the staff!"), \
					span_notice("I empower the staff with an arcyne-focus!"))
				new /obj/item/rogueweapon/woodstaff/prepared/toper(loc)
				qdel(arcyne_focus)
				qdel(src)
			else
				return
	else if(istype(arcyne_focus, /obj/item/roguegem/amethyst))
		var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
		if(do_after(user, crafttime, target = src))
			if(isarcyne(user))
				playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
				user.visible_message(span_warning("[user] slots [user.p_their()] [arcyne_focus] into the staff!"), \
					span_notice("I empower the staff with an arcyne-focus!"))
				new /obj/item/rogueweapon/woodstaff/prepared/amethyst(loc)
				qdel(arcyne_focus)
				qdel(src)
			else
				return
	else if(istype(arcyne_focus, /obj/item/roguegem/green))
		var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
		if(do_after(user, crafttime, target = src))
			if(isarcyne(user))
				playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
				user.visible_message(span_warning("[user] slots [user.p_their()] [arcyne_focus] into the staff!"), \
					span_notice("I empower the staff with an arcyne-focus!"))
				new /obj/item/rogueweapon/woodstaff/prepared/emerald(loc)
				qdel(arcyne_focus)
				qdel(src)
			else
				return
	else if(istype(arcyne_focus, /obj/item/roguegem/violet))
		var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
		if(do_after(user, crafttime, target = src))
			if(isarcyne(user))
				playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
				user.visible_message(span_warning("[user] slots [user.p_their()] [arcyne_focus] into the staff!"), \
					span_notice("I empower the staff with an arcyne-focus!"))
				new /obj/item/rogueweapon/woodstaff/prepared/sapphire(loc)
				qdel(arcyne_focus)
				qdel(src)
			else
				return
	else if(istype(arcyne_focus, /obj/item/roguegem/blue))
		var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
		if(do_after(user, crafttime, target = src))
			if(isarcyne(user))
				playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
				user.visible_message(span_warning("[user] slots [user.p_their()] [arcyne_focus] into the staff!"), \
					span_notice("I empower the staff with an arcyne-focus!"))
				new /obj/item/rogueweapon/woodstaff/prepared/quartz(loc)
				qdel(arcyne_focus)
				qdel(src)
			else
				return
	else if(istype(arcyne_focus, /obj/item/roguegem/blue))
		var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
		if(do_after(user, crafttime, target = src))
			if(isarcyne(user))
				playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
				user.visible_message(span_warning("[user] slots [user.p_their()] [arcyne_focus] into the staff!"), \
					span_notice("I empower the staff with an arcyne-focus!"))
				new /obj/item/rogueweapon/woodstaff/prepared/quartz(loc)
				qdel(arcyne_focus)
				qdel(src)
			else
				return
	else if(istype(arcyne_focus, /obj/item/roguegem/diamond))
		var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
		if(do_after(user, crafttime, target = src))
			if(isarcyne(user))
				playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
				user.visible_message(span_warning("[user] slots [user.p_their()] [arcyne_focus] into the staff!"), \
					span_notice("I empower the staff with an arcyne-focus!"))
				new /obj/item/rogueweapon/woodstaff/prepared/diamond(loc)
				qdel(arcyne_focus)
				qdel(src)
			else
				return
	else if(istype(arcyne_focus, /obj/item/roguegem)) //has to be checked last because someone made the ruby also the base gem object
		var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
		if(do_after(user, crafttime, target = src))
			if(isarcyne(user))
				playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
				user.visible_message(span_warning("[user] slots [user.p_their()] [arcyne_focus] into the staff!"), \
					span_notice("I empower the staff with an arcyne-focus!"))
				new /obj/item/rogueweapon/woodstaff/prepared/ruby(loc)
				qdel(arcyne_focus)
				qdel(src)
			else
				return
	else if(istype(arcyne_focus, /obj/item/riddleofsteel)) 
		var/crafttime = (100 - ((user.mind?.get_skill_level(/datum/skill/magic/arcane))*5))
		if(do_after(user, crafttime, target = src))
			if(isarcyne(user))
				playsound(loc, 'modular_azurepeak/sound/spellbooks/crystal.ogg', 100, TRUE)
				user.visible_message(span_warning("[user] slots [user.p_their()] [arcyne_focus] into the staff!"), \
					span_notice("I empower the staff with an arcyne-focus!"))
				new /obj/item/rogueweapon/woodstaff/prepared/riddle_of_steel(loc)
				qdel(arcyne_focus)
				qdel(src)
			else
				return
