// simple is_type and similar inline helpers


#define in_range(source, user) (get_dist(source, user) <= 1 && (get_step(source, 0)?:z) == (get_step(user, 0)?:z))

#define ismovableatom(A) ismovable(A)


#define isatom(A) (isloc(A))

#define isweakref(D) (istype(D, /datum/weakref))
#define isdatum(D) (istype(D, /datum))
//Turfs
//#define isturf(A) (istype(A, /turf)) This is actually a byond built-in. Added here for completeness sake.

GLOBAL_LIST_INIT(turfs_without_ground, typecacheof(list(
	/turf/open/lava,
	/turf/open/water,
	/turf/open/transparent/openspace
	)))

GLOBAL_LIST_INIT(our_forest_sex, typecacheof(list(
	/area/provincial/outdoors/forest,
	/area/provincial/outdoors/river,
	/area/provincial/outdoors/bog,
	/area/provincial/outdoors/field
	)))

//stick town areas here, if any
GLOBAL_LIST_INIT(townboundries, typecacheof(list(

	//basic town areas
	/area/provincial/indoors/town,
	/area/provincial/indoors/town/adventurers_guild,
	/area/provincial/indoors/town/adventurers_guild/handlers_office,
	/area/provincial/indoors/town/basement,
	/area/provincial/indoors/town/blacksmith,
	/area/provincial/indoors/town/dusk_quarter,
	/area/provincial/indoors/town/house,
	/area/provincial/indoors/town/house/janitor,
	/area/provincial/indoors/town/house/veteran,
	/area/provincial/indoors/town/house/village_elder,
	/area/provincial/indoors/town/ramparts,
	/area/provincial/indoors/town/sewer,
	/area/provincial/indoors/town/sewer/rogues_den,
	/area/provincial/indoors/town/stall,
	/area/provincial/indoors/town/stall/stall_three,
	/area/provincial/indoors/town/stall/stall_two,
	/area/provincial/indoors/town/steward,
	/area/provincial/indoors/town/steward/import_platform,
	/area/provincial/indoors/town/tailor,
	/area/provincial/outdoors/town,
	/area/provincial/outdoors/town/garrison,
	/area/provincial/outdoors/town/garrison/ramparts,
	/area/provincial/outdoors/town/keep,
	/area/provincial/outdoors/town/ramparts,
	/area/provincial/outdoors/town/roofs,
	/area/provincial/outdoors/town/roofs/keep,
	/area/provincial/outdoors/shop,
	/area/provincial/outdoors/tavern,

	//church areas
	/area/provincial/indoors/town/church,
	/area/provincial/indoors/town/church/basement,
	/area/provincial/indoors/town/church/basement/crypt,
	/area/provincial/indoors/town/church/bell_tower,
	/area/provincial/indoors/town/church/canteen,
	/area/provincial/indoors/town/church/fire_chamber,
	/area/provincial/indoors/town/church/quarters,
	/area/provincial/indoors/town/church/quarters/priest,
	/area/provincial/indoors/town/church/storage,
	/area/provincial/indoors/town/church/treatment_center,
	/area/provincial/indoors/town/church/vault,
	/area/provincial/outdoors/church,

	//Farm area
	/area/provincial/indoors/town/farm,
	/area/provincial/indoors/town/farm/barn,
	/area/provincial/indoors/town/farm/basement,
	/area/provincial/indoors/town/farm/chicken_coop,
	/area/provincial/indoors/town/farm/secondary,
	/area/provincial/indoors/town/farm/secondary/basement,
	/area/provincial/indoors/town/farm/secondary/stall,

	//Mages university
	/area/provincial/indoors/town/mages_university,
	/area/provincial/indoors/town/mages_university/alchemy_lab,
	/area/provincial/indoors/town/mages_university/archivist/quarters,
	/area/provincial/indoors/town/mages_university/artificer,
	/area/provincial/indoors/town/mages_university/established_mage_hall,
	/area/provincial/indoors/town/mages_university/head_mage,
	/area/provincial/indoors/town/mages_university/kitchen,
	/area/provincial/indoors/town/mages_university/library,
	/area/provincial/indoors/town/mages_university/shared_storage,

	//Keep areas
	/area/provincial/indoors/town/province_keep,
	/area/provincial/indoors/town/province_keep/basement,
	/area/provincial/indoors/town/province_keep/baths,
	/area/provincial/indoors/town/province_keep/baths/marquis,
	/area/provincial/indoors/town/province_keep/baths/toilets,
	/area/provincial/indoors/town/province_keep/councillor,
	/area/provincial/indoors/town/province_keep/deacon,
	/area/provincial/indoors/town/province_keep/deacon/alchemylab,
	/area/provincial/indoors/town/province_keep/deacon/quarters,
	/area/provincial/indoors/town/province_keep/dressing_room,
	/area/provincial/indoors/town/province_keep/kitchen,
	/area/provincial/indoors/town/province_keep/kitchen/marquis,
	/area/provincial/indoors/town/province_keep/library,
	/area/provincial/indoors/town/province_keep/magician,
	/area/provincial/indoors/town/province_keep/magician/alchemylab,
	/area/provincial/indoors/town/province_keep/magician/quarters,
	/area/provincial/indoors/town/province_keep/meeting_room,
	/area/provincial/indoors/town/province_keep/quarters,
	/area/provincial/indoors/town/province_keep/quarters/councillor,
	/area/provincial/indoors/town/province_keep/quarters/guest,
	/area/provincial/indoors/town/province_keep/quarters/hand,
	/area/provincial/indoors/town/province_keep/quarters/jester,
	/area/provincial/indoors/town/province_keep/quarters/knight,
	/area/provincial/indoors/town/province_keep/quarters/marquis,
	/area/provincial/indoors/town/province_keep/quarters/nobleman,
	/area/provincial/indoors/town/province_keep/quarters/seneschal,
	/area/provincial/indoors/town/province_keep/quarters/servant,
	/area/provincial/indoors/town/province_keep/quarters/squire,
	/area/provincial/indoors/town/province_keep/throneroom,
	/area/provincial/indoors/town/province_keep/throneroom/overlook,
	/area/provincial/indoors/town/province_keep/vault,
	/area/provincial/indoors/town/province_keep/wine_cellar,

	//Garrison
	/area/provincial/indoors/town/province_keep/garrison,
	/area/provincial/indoors/town/province_keep/garrison/armory,
	/area/provincial/indoors/town/province_keep/garrison/armory/secure,
	/area/provincial/indoors/town/province_keep/garrison/armory/toilets,
	/area/provincial/indoors/town/province_keep/garrison/canteen,
	/area/provincial/indoors/town/province_keep/garrison/dungeon/cell,
	/area/provincial/indoors/town/province_keep/garrison/gate,
	/area/provincial/indoors/town/province_keep/garrison/gate/east,
	/area/provincial/indoors/town/province_keep/garrison/gate/keep,
	/area/provincial/indoors/town/province_keep/garrison/gate/north,
	/area/provincial/indoors/town/province_keep/garrison/gate/south,
	/area/provincial/indoors/town/province_keep/garrison/gate/west,
	/area/provincial/indoors/town/province_keep/garrison/quarters,
	/area/provincial/indoors/town/province_keep/garrison/quarters/knight_captain,
	/area/provincial/indoors/town/province_keep/garrison/quarters/marshal,
	/area/provincial/indoors/town/province_keep/garrison/quarters/sergeant,
	/area/provincial/indoors/town/province_keep/garrison/ramparts,
	/area/provincial/indoors/town/province_keep/garrison/stables,
	/area/provincial/indoors/town/province_keep/garrison/warden_watchtower,

	//Tavern
	/area/provincial/indoors/town/tavern,
	/area/provincial/indoors/town/tavern/arena,
	/area/provincial/indoors/town/tavern/arena/spectator,
	/area/provincial/indoors/town/tavern/bath,
	/area/provincial/indoors/town/tavern/innkeeper,
	/area/provincial/indoors/town/tavern/kitchen,
	/area/provincial/indoors/town/tavern/kitchen/pantry,
	/area/provincial/indoors/town/tavern/public_meeting_room,
	/area/provincial/indoors/town/tavern/room,
	/area/provincial/indoors/town/tavern/room/two,
	/area/provincial/indoors/town/tavern/room/three,
	/area/provincial/indoors/town/tavern/room/four,
	/area/provincial/indoors/town/tavern/room/five,
	/area/provincial/indoors/town/tavern/room/six,
	/area/provincial/indoors/town/tavern/room/seven,
	/area/provincial/indoors/town/tavern/room/eight,
	/area/provincial/indoors/town/tavern/room/luxury,
	/area/provincial/indoors/town/tavern/room/luxury/two,
	/area/provincial/indoors/town/tavern/room/luxury/three,
	/area/provincial/indoors/town/tavern/room/luxury/four,
	/area/provincial/indoors/town/tavern/room/luxury/five,
	/area/provincial/indoors/town/tavern/tapster_quarters,
	)))

//stick holy areas here, if any
GLOBAL_LIST_INIT(churchboundries, typecacheof(list(
	//church areas
	/area/provincial/indoors/town/church,
	/area/provincial/indoors/town/church/basement,
	/area/provincial/indoors/town/church/basement/crypt,
	/area/provincial/indoors/town/church/bell_tower,
	/area/provincial/indoors/town/church/canteen,
	/area/provincial/indoors/town/church/fire_chamber,
	/area/provincial/indoors/town/church/quarters,
	/area/provincial/indoors/town/church/quarters/priest,
	/area/provincial/indoors/town/church/storage,
	/area/provincial/indoors/town/church/treatment_center,
	/area/provincial/indoors/town/church/vault,
	/area/provincial/outdoors/church,
	)))

#define isclient(A) istype(A, /client)

#define isforestsex(A) (is_type_in_typecache(A, GLOB.our_forest_sex))

#define isintown(A) (is_type_in_typecache(A, GLOB.townboundries))

#define isholyarea(A) (is_type_in_typecache(A, GLOB.churchboundries))

#define isgroundlessturf(A) (is_type_in_typecache(A, GLOB.turfs_without_ground))

#define isopenturf(A) (istype(A, /turf/open))

#define isindestructiblefloor(A) (istype(A, /turf/open/indestructible))

#define isspaceturf(A) (istype(A, /turf/open/space))

#define isfloorturf(A) (istype(A, /turf/open/floor))

#define isclosedturf(A) (istype(A, /turf/closed))

#define isindestructiblewall(A) (istype(A, /turf/closed/indestructible))

#define iswallturf(A) (istype(A, /turf/closed/wall))

#define ismineralturf(A) (istype(A, /turf/closed/mineral))

#define islava(A) (istype(A, /turf/open/lava))

#define ischasm(A) (istype(A, /turf/open/chasm))

#define isplatingturf(A) (istype(A, /turf/open/floor/plating))

#define istransparentturf(A) (istype(A, /turf/open/transparent) || istype(A, /turf/closed/transparent))

//Mobs
#define isliving(A) (istype(A, /mob/living))

#define issimple(A) (istype(A, /mob/living/simple_animal))

#define isbrain(A) (istype(A, /mob/living/brain))

//Carbon mobs
#define iscarbon(A) (istype(A, /mob/living/carbon))

#define ishuman(A) (istype(A, /mob/living/carbon/human))

//Human sub-species
#define ishumanbasic(A) (is_species(A, /datum/species/human))
#define isvampire(A) (is_species(A,/datum/species/vampire))
#define ismoth(A) (is_species(A, /datum/species/moth))

//RT species
#define ishumannorthern(A) (is_species(A, /datum/species/human/northern))
#define isdwarf(A) (is_species(A, /datum/species/dwarf))
#define isdwarfmountain(A) (is_species(A, /datum/species/dwarf/mountain))
#define iself(A) (is_species(A, /datum/species/elf))
#define isdarkelf(A) (is_species(A, /datum/species/elf/dark))
#define iswoodelf(A) (is_species(A, /datum/species/elf/wood))
#define ishalfelf(A) (is_species(A, /datum/species/human/halfelf))
#define istiefling(A) (is_species(A, /datum/species/tieberian))
#define ishalforc(A) (is_species(A, /datum/species/halforc))
#define isargonian(A) (is_species(A, /datum/species/lizard/brazil))
#define isgoblinp(A) (is_species(A, /datum/species/goblinp))

//more carbon mobs
#define ismonkey(A) (istype(A, /mob/living/carbon/monkey))

#define istruedevil(A) (istype(A, /mob/living/carbon/true_devil))

//Simple animals
#define isanimal(A) (istype(A, /mob/living/simple_animal))

#define isrevenant(A) (istype(A, /mob/living/simple_animal/revenant))

#define isshade(A) (istype(A, /mob/living/simple_animal/shade))

#define ismouse(A) (istype(A, /mob/living/simple_animal/mouse))

#define iscow(A) (istype(A, /mob/living/simple_animal/cow))

#define isslime(A) (istype(A, /mob/living/simple_animal/slime))

#define isdrone(A) (istype(A, /mob/living/simple_animal/drone))

#define iscat(A) (istype(A, /mob/living/simple_animal/pet/cat))

#define isdog(A) (istype(A, /mob/living/simple_animal/pet/dog))

#define iscorgi(A) (istype(A, /mob/living/simple_animal/pet/dog/corgi))

#define ishostile(A) (istype(A, /mob/living/simple_animal/hostile))

#define isswarmer(A) (istype(A, /mob/living/simple_animal/hostile/swarmer))

#define isguardian(A) (istype(A, /mob/living/simple_animal/hostile/guardian))

#define isconstruct(A) (istype(A, /mob/living/simple_animal/hostile/construct))

#define ismegafauna(A) (istype(A, /mob/living/simple_animal/hostile/megafauna))

#define isclown(A) (istype(A, /mob/living/simple_animal/hostile/retaliate/clown))


//Misc mobs
#define isobserver(A) (istype(A, /mob/dead/observer))

#define isdead(A) (istype(A, /mob/dead))

#define isnewplayer(A) (istype(A, /mob/dead/new_player))

#define isovermind(A) (istype(A, /mob/camera/blob))

#define iscameramob(A) (istype(A, /mob/camera))

#define isaicamera(A) (istype(A, /mob/camera/aiEye))

//Objects
#define isobj(A) istype(A, /obj) //override the byond proc because it returns true on children of /atom/movable that aren't objs

#define isitem(A) (istype(A, /obj/item))

#define isidcard(I) (istype(I, /obj/item/card/id))

#define isstructure(A) (istype(A, /obj/structure))

#define ismachinery(A) (istype(A, /obj/machinery))

#define ismecha(A) (istype(A, /obj/mecha))

#define is_cleanable(A) (istype(A, /obj/effect/decal/cleanable)) //if something is cleanable

#define isorgan(A) (istype(A, /obj/item/organ))

#define isclothing(A) (istype(A, /obj/item/clothing))

#define iscash(A) (istype(A, /obj/item/coin) || istype(A, /obj/item/stack/spacecash) || istype(A, /obj/item/holochip))

GLOBAL_LIST_INIT(pointed_types, typecacheof(list(
	/obj/item/kitchen/fork)))

#define is_pointed(W) (is_type_in_typecache(W, GLOB.pointed_types))

#define isbodypart(A) (istype(A, /obj/item/bodypart))

#define isprojectile(A) (istype(A, /obj/projectile))

#define isgun(A) (istype(A, /obj/item/gun))


#define iseffect(O) (istype(O, /obj/effect))

#define isblobmonster(O) (istype(O, /mob/living/simple_animal/hostile/blob))

#define isshuttleturf(T) (length(T.baseturfs) && (/turf/baseturf_skipover/shuttle in T.baseturfs))
