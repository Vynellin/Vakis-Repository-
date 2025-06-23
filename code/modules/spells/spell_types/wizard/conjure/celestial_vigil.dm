/obj/effect/proc_holder/spell/invoked/celestial_vigil
    name = "Celestial Vigil"
    desc = "Summons guiding stars that protect the caster against those who draw near."

/obj/effect/proc_holder/spell/invoked/celestial_vigil/cast(mob/living/target, mob/living/user)
    if(!user || !target || user != target) return

    if(user.HasStatus("celestial_vigil"))
        to_chat(user, span_warning("The celestial vigil is already watching over you."))
        return

    user.AddStatus("celestial_vigil", duration = 60 SECONDS)
    create_orb_overlay(user)

    spawn()
        monitor_celestial_vigil(user)

/proc/create_orb_overlay(mob/living/user)
    if (!user) return

    var/orb_count = get_celestial_orb_count(user)

    for (var/i in 1 to orb_count)
        var/obj/effect/overlay/orb = new /obj/effect/overlay(user.loc)
        orb.layer = FLOAT_LAYER
        orb.pixel_x = rand(-16, 16)
        orb.pixel_y = rand(-16, 16)
        orb.name = "Celestial Light"
        orb.color = "#ddeeff"
        orb.alpha = 200
        orb.orbiting = user
        orb.anchored = TRUE
        user.vis_contents += orb

/proc/monitor_celestial_vigil(mob/living/user)
    while(user && user.HasStatus("celestial_vigil"))
        sleep(10) // every second

        var/list/enemies = list()
        for(var/mob/living/M in view(4, user))
            if(M == user) continue
            if(ishuman(M) || iscarbon(M)) // customize filter
                enemies += M

        if(enemies.len)
            user.RemoveStatus("celestial_vigil")
            remove_orb_overlay(user)
            fire_orbs(user, enemies[1])
            return

/proc/remove_orb_overlay(mob/living/user)
    for(var/obj/effect/overlay/orb in user.vis_contents)
        if(orb.name == "Celestial Light")
            qdel(orb)

/proc/fire_orbs(mob/living/user, mob/living/target)
    var/turf/start = get_turf(user)
    var/turf/end = get_turf(target)
    var/total_orbs = get_celestial_orb_count(user)
    var/fan_angle = 45 // total spread angle
    var/step = total_orbs > 1 ? fan_angle / (total_orbs - 1) : 0
    var/base_angle = Get_Angle(start, end)
    var/offset = -(fan_angle / 2)

    for (var/i in 0 to total_orbs - 1)
        var/obj/projectile/orb_proj = new /obj/projectile/magic/celestial_orb(start)
        orb_proj.firer = user
        orb_proj.target = target

        var/final_angle = base_angle + offset + (step * i)
        orb_proj.setAngle(final_angle)
        orb_proj.fire()

/obj/projectile/magic/celestial_orb
    name = "Celestial Orb"
    icon = 'celestial_orb.dmi'
    pixel_x = -8
    pixel_y = -8
    speed = 8
    var/fade = TRUE
    var/max_turn_rate = 15
    var/homing_strength = 1

    var/turn_penalty = 1.1
    var/min_speed = 2

/obj/projectile/magic/celestial_orb/Life()
    ..()
    spawn(1)
        add_trail(src)

    if(ismob(target))
        var/angle_to_target = Get_Angle(get_turf(src), get_turf(target))
        var/delta = abs(angle_to_target - direction)
        if(delta > 15) // adjust turn penalty threshold
            speed /= turn_penalty
            if(speed < min_speed)
                qdel(src)
                return

        setAngle(angle_to_target)

/proc/add_trail(obj/projectile/P)
    var/obj/effect/trail = new /obj/effect(get_turf(P))
    trail.icon = 'orb_trail.dmi'
    trail.layer = UNDER_OBJ_LAYER
    trail.color = "#ddeeff"
    trail.alpha = 150
    spawn(20)
        qdel(trail)

/proc/get_celestial_orb_count(mob/living/user)
    if (!user || !user.mind) return 1

    var/intellect = clamp(user.get_stat("STAINT"), 1, 20)
    var/skill_level = user.mind.get_skill_level(/datum/skill/magic/arcane)

    // Base: 3 + 1 per 5 INT, +1 per Arcane skill tier past Apprentice
    var/count = 3
    count += round(intellect / 5)
    count += max(0, skill_level - SKILL_LEVEL_APPRENTICE)

    return min(count, 9) // Cap to avoid spam
