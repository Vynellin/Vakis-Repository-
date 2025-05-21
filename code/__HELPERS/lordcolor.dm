GLOBAL_LIST_EMPTY(lordcolor)

GLOBAL_VAR(lordprimary)
GLOBAL_VAR(lordsecondary)

/obj/proc/lordcolor(primary,secondary)
	color = primary

/obj/item/clothing/cloak/lordcolor(primary,secondary)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_cloak()


/turf/proc/lordcolor(primary,secondary)
	color = primary

/mob/proc/lord_color_choice()
	if(!client)
		addtimer(CALLBACK(src, PROC_REF(lord_color_choice)), 50)
		return
	var/list/lordcolors = list(
"PURPLE"="#8747b1",
"DEEP PURPLE"="#8747B1",
"MAGENTA"="#962e5c",
"ROYAL RED"="#FF1021",
"BLOOD RED"="#8A040E",
"SILVER"="#A9C4CA",
"SLATE"="#707279",
"BLACK"="#2b292e",
"MUD"="#61462c",
"ORANGE"="#df8405",
"CLAY"="#CE7A45",
"MAHOGANEY"="#522000",
"LIME"="#7BFF4E",
"FOREST GREEN"="#00AA00",
"DARK GREEN"="#003900",
"AZURE"="#007fff",
"ULTRAMARINE BLUE"="#0035FF",
"NAVY BLUE"="#173266",
"YELLOW"="#FFD500",
"GOLD"="#FFA400",
"TEAL"="#249589",
"CYAN"="#4BE0A6",
"WHITE"="#ffffff",)
	var/prim
	var/sec
	var/choice = input(src, "Choose a Primary Color", "ROGUETOWN") as anything in lordcolors
	if(choice)
		prim = lordcolors[choice]
		lordcolors -= choice
	choice = input(src, "Choose a Secondary Color", "ROGUETOWN") as anything in lordcolors
	if(choice)
		sec = lordcolors[choice]
	if(!prim || !sec)
		GLOB.lordcolor = list()
		return
	GLOB.lordprimary = prim
	GLOB.lordsecondary = sec
	for(var/obj/O in GLOB.lordcolor)
		O.lordcolor(prim,sec)
		GLOB.lordcolor -= O
	for(var/turf/T in GLOB.lordcolor)
		T.lordcolor(prim,sec)
		GLOB.lordcolor -= T

/proc/lord_color_default()
	GLOB.lordprimary = "#FFA400" //GOLD
	GLOB.lordsecondary = "#ffffff" //WHITE
	for(var/obj/O in GLOB.lordcolor)
		O.lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	for(var/turf/T in GLOB.lordcolor)
		T.lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
