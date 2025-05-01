GLOBAL_LIST_EMPTY_TYPED(mentorhelps, /datum/mentorhelp)

/mob
	COOLDOWN_DECLARE(mentorhelp_cooldown)

/mob/proc/mentorhelp(msg as text)
	if(!msg)
		return
	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	to_chat(src, span_info("<i>You throw your thoughts to the gods...</i>\n[msg]"))
	var/datum/mentorhelp/ticket = new(src)
	var/message = span_info("<i>[src] meditates...</i>\n[msg]")
	var/message_admins = span_info("<i>[src] ([key || "NO KEY"]) [ADMIN_FLW(src)] [ADMIN_SM(src)] meditates...</i>\n[msg]")
	for(var/client/voice in (GLOB.clients - client))
		if(!(voice.prefs.toggles & BE_MENTOR) || check_rights_for(voice, R_ADMIN))
			continue
		var/answer_button = span_info("(<a href='?src=[voice];mentorhelp=[REF(ticket)];'>ANSWER</a>)")
		to_chat(voice, "[message] [answer_button]")

	for(var/client/admin in GLOB.admins)
		if(!(admin.prefs.chat_toggles & CHAT_PRAYER))
			continue
		var/answer_button = span_info("(<a href='?src=[admin];mentorhelp=[REF(ticket)];'>ANSWER</a>)")
		to_chat(admin, "[message_admins] [answer_button]")
	COOLDOWN_START(src, mentorhelp_cooldown, 1 MINUTES)

/client/proc/answer_mentorhelp(datum/mentorhelp/mentee)
	if(QDELETED(mentee))
		to_chat(src, span_warning("This meditation can no longer be answered..."))
		return
	if(mentee.owner == src.mob)
		to_chat(src, span_warning("I can't answer my own meditation!"))
		return
	var/answer = input("Answer their meditations...", "VOICE")
	if(!answer || QDELETED(mentee))
		return
	mentee.answer_mentorhelp(answer, src.mob)

/datum/mentorhelp
	/// Guy who made this mentorhelp ticket
	var/mob/owner
	/// Answers we got so far, indexed by client key
	var/list/answers = list()
	/// How many answers we can get at maximum
	var/max_answers = 5
	/// How much time we have to be answered
	var/timeout = 5 MINUTES

/datum/mentorhelp/New(mob/owner)
	. = ..()
	if(owner)
		src.owner = owner
		RegisterSignal(owner, COMSIG_PARENT_QDELETING, PROC_REF(owner_qdeleted))
	GLOB.mentorhelps += src
	if(timeout)
		QDEL_IN(src, timeout)
	
/datum/mentorhelp/Destroy(force)
	. = ..()
	owner = null
	answers = null
	GLOB.mentorhelps -= src

/datum/mentorhelp/proc/answer_mentorhelp(answer, mob/voice)
	if(QDELETED(src) || !voice.client)
		return
	answer = copytext(sanitize(answer), 1, MAX_MESSAGE_LEN)
	to_chat(owner, "<i>I hear a voice in my head...\n<b>[answer]</i></b>")

	for(var/client/listener in (GLOB.clients - owner.client))
		if(listener in GLOB.admins)
			if(!(listener.prefs.chat_toggles & CHAT_PRAYER))
				continue
			to_chat(listener, span_info("<i>[voice] ([voice.key || "NO KEY"]) [ADMIN_FLW(owner)] [ADMIN_SM(owner)] answered [owner] ([owner.key || "NO KEY"])'s [ADMIN_FLW(owner)] [ADMIN_SM(owner)] meditation:</i>\n[answer]"))
		else
			if(!(listener.prefs.toggles & BE_MENTOR))
				continue
			to_chat(listener, span_info("Someone answers:<i>[answer]</i>"))

	answers[voice.key] = answer
	if(length(answers) >= max_answers)
		qdel(src)

/datum/mentorhelp/proc/owner_qdeleted(mob/source)
	if(QDELETED(src))
		return
	UnregisterSignal(owner, COMSIG_PARENT_QDELETING)
	qdel(src)
