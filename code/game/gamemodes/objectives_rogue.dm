/datum/objective/delf
	name = "delf"
	explanation_text = "Feed honeys to the mother."

/datum/objective/delf/check_completion()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C.delfcontrib >= C.delfgoal)
			return TRUE

/datum/objective/delf/update_explanation_text()
	..()
	if(SSticker.mode)
		var/datum/game_mode/chaosmode/C = SSticker.mode
		if(C)
			explanation_text = "Feed [C.delfgoal] honeys to the mother."
		else
			explanation_text = "The statuette no longer hungers. You are free, for the time being..."

/datum/objective/werewolf
	name = "conquer"
	explanation_text = "You are a werewolf, a monsterous beast that walks the night in search of prey. Work with your fellow werewolves and protect the pack from all threats by any means necessary. Survival means blood."
	team_explanation_text = "You are a werewolf, a monsterous beast that walks the night in search of prey. Work with your fellow werewolves and protect the pack from all threats by any means necessary. Survival means blood."
	triumph_count = 5

/datum/objective/werewolf/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "werewolf")
			return TRUE

/datum/objective/vampire
	name = "conquer"
	explanation_text = "Put an end to the werewolf menace in Sunmarch, or unite with them against the forces of the Nine."
	team_explanation_text = "The feud between werewolves and vampires reaches back to the dawn of time. Will the two factions destroy each other, or find a way to coexist and face the mortals of Sunmarch together?"
	triumph_count = 5

/datum/objective/vampire/check_completion()
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.vampire_werewolf() == "vampire")
			return TRUE
