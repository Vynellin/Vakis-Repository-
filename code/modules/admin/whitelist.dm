#ifdef TESTSERVER
	#define WHITELISTFILE	"[global.config.directory]/roguetown/wl_test.txt"
#else
	#define WHITELISTFILE	"[global.config.directory]/roguetown/wl_mat.txt"
#endif

GLOBAL_LIST_EMPTY(whitelist)
GLOBAL_PROTECT(whitelist)


/proc/load_whitelist()
	GLOB.whitelist = list()

	if(!SSdbcore.Connect())
		log_config("Could not connect to the database to load the whitelist, reverting to legacy whitelist.txt file!")
		load_whitelist_legacy()
		return

	var/datum/DBQuery/query_load_whitelist = SSdbcore.NewQuery(
		"SELECT ckey, revoked FROM [format_table_name("whitelist")]"
	)

	if(!query_load_whitelist.Execute())
		qdel(query_load_whitelist)
		return
	
	while(query_load_whitelist.NextRow())
		var/revoked = query_load_whitelist.item[2]
		if(revoked) // Don't add revoked whitelist entries to the whitelist
			continue

		GLOB.whitelist[query_load_whitelist.item[1]] = TRUE

	qdel(query_load_whitelist)


/proc/load_whitelist_legacy()
	for(var/line in world.file2list(WHITELISTFILE))
		if(!line)
			continue

		if(findtextEx(line,"#",1,2))
			continue

		GLOB.whitelist[ckey(line)] = TRUE


/proc/check_whitelist(ckey)
	if(!GLOB.whitelist || !GLOB.whitelist.len)
		load_whitelist()

	return GLOB.whitelist[ckey]


/client/proc/add_whitelist()
	set name = "Add Whitelist"
	set category = "-Admin-"

	if(!check_rights(R_ADMIN))
		return

	if(!CONFIG_GET(flag/sql_enabled) || !SSdbcore.Connect())
		to_chat(usr, span_adminnotice("This feature requires a SQL database!"))
		return

	var/ckey_to_whitelist = input(usr, "Enter a ckey to add to the whitelist.", "Ckey Input") as text|null
	ckey_to_whitelist = ckey(ckey_to_whitelist)
	if(!ckey_to_whitelist)
		return

	var/datum/DBQuery/query_add_whitelist = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name("whitelist")] (ckey) VALUES(:ckey) ON DUPLICATE KEY UPDATE revoked = 0",
		list("ckey" = ckey_to_whitelist)
	)
	
	if(!query_add_whitelist.warn_execute())
		qdel(query_add_whitelist)
		return

	qdel(query_add_whitelist)
	GLOB.whitelist[ckey_to_whitelist] = TRUE
	log_admin("[key_name(usr)] has added [ckey_to_whitelist] to the whitelist.")
	message_admins("[key_name_admin(usr)] has added [ckey_to_whitelist] to the whitelist.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Add Whitelist") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/* TODO: Discuss this and which permissions should be tied to it, since this is equivalent to banning someone.
/client/proc/revoke_whitelist()
	set name = "Revoke Whitelist"
	set category = "-Admin-"
	if(!check_rights(R_BAN))
		return

	if(!CONFIG_GET(flag/sql_enabled) || !SSdbcore.Connect())
		to_chat(usr, span_adminnotice("This feature requires a SQL database!"))
		return

	var/ckey_to_revoke = input(usr, "Enter a ckey to revoke whitelist access from.", "Ckey Input") as text|null
	ckey_to_revoke = ckey(ckey_to_revoke)
	if(!ckey_to_revoke)
		return

	var/datum/DBQuery/query_revoke_whitelist = SSdbcore.NewQuery(
		"UPDATE [format_table_name("whitelist")] SET `revoked` = 0 WHERE ckey = :ckey",
		list("ckey" = ckey_to_revoke)
	)
	
	if(!query_revoke_whitelist.Execute())
		qdel(query_revoke_whitelist)
		to_chat(usr, span_danger("[ckey_to_revoke] wasn't in the whitelist."))
		return

	qdel(query_revoke_whitelist)
	GLOB.whitelist[ckey_to_revoke] = FALSE
	log_admin("[key_name(usr)] has revoked [ckey_to_revoke]'s whitelist status.")
	message_admins("[key_name_admin(usr)] has revoked  [ckey_to_revoke]'s whitelist status.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Revoke Whitelist") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
*/


/datum/tgs_chat_command/add_whitelist
	name = "whitelist"
	help_text = "whitelist <ckey>"
	admin_only = TRUE


/datum/tgs_chat_command/add_whitelist/Run(datum/tgs_chat_user/sender, params)
	if(!CONFIG_GET(flag/usewhitelist))
		return new /datum/tgs_message_content("This feature only works if the whitelist is enabled!")

	if(!CONFIG_GET(flag/sql_enabled))
		return new /datum/tgs_message_content("This feature requires a SQL database!")

	var/ckey_to_whitelist = ckey(params)

	var/datum/DBQuery/query_add_whitelist = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name("whitelist")] (ckey) VALUES(:ckey) ON DUPLICATE KEY UPDATE revoked = 0",
		list("ckey" = ckey_to_whitelist)
	)

	if(!query_add_whitelist.Execute())
		qdel(query_add_whitelist)
		return new /datum/tgs_message_content("A SQL error occurred during this operation, report this ASAP.")

	qdel(query_add_whitelist)

	GLOB.whitelist[ckey_to_whitelist] = TRUE

	log_admin("[sender.friendly_name] has added [ckey_to_whitelist] to the whitelist.")
	message_admins("[sender.friendly_name] has added [ckey_to_whitelist] to the whitelist.")
	return new /datum/tgs_message_content("[ckey_to_whitelist] has been added to the whitelist.")


#undef WHITELISTFILE
