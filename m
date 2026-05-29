Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53457CD6E4A
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 15:40:40 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13432.1780069234526005434
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 29 May 2026 08:40:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 64TFeW7W1175460;
	Fri, 29 May 2026 10:40:32 -0500
Received: from [192.168.2.62] ([192.168.2.62])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 64TFeUVh013578;
	Fri, 29 May 2026 10:40:31 -0500
Message-ID: <1c0a7f74-ccf1-4c68-abb4-3a224b68a4d4@kernel.crashing.org>
Date: Fri, 29 May 2026 10:40:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH] pseudo_util: Add log severity
 flags
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
References: <20260527120820.237469-1-frezidok1@gmail.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20260527120820.237469-1-frezidok1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 29 May 2026 15:40:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4086

Sorry for the late reply.

On 5/27/26 7:08 AM, Dmitry Sakhonchik via lists.yoctoproject.org wrote:
> From: Dmitry Sakhonchik <frezidok1@gmail.com>
> 
> Create an infrastructure to make use of severity flags from pseudo_tables.
> After that it is now possible to set severity flags from env (PSEUDO_SEVERITY) and from terminal via optargs.
> 
> [YOCTO #12141]
> 
> Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
> ---
>   pseudo.c      |  8 +++++++-
>   pseudo.h      |  3 +++
>   pseudo_util.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/pseudo.c b/pseudo.c
> index 25711b6..8a05d82 100644
> --- a/pseudo.c
> +++ b/pseudo.c
> @@ -134,7 +134,10 @@ main(int argc, char *argv[]) {
>   	 * wrong.  The + suppresses this annoying behavior, but may not
>   	 * be compatible with sane option libraries.
>   	 */
> -	while ((o = getopt(argc, argv, "+BCdfhi:lm:M:p:P:r:R:St:vVx:")) != -1) {
> +	while ((o = getopt(argc, argv, "+BCdfhi:lm:M:p:P:r:R:St:vVx:k:")) != -1) {

In the above string, the letters should be in alphabetic order.  So the new line 
should be:

+BCdfhi:klm:M:p:P:r:R:St:vVx:

> +		/*                                                               ^^^^^    */
> +		/* 						which letter to choose for severity is a topic for discussion */
> +		/*						I've chosen 'k' simply because it was not used yet 	*/

I've no objections to 'k'.  We're out of easily letters at this point.. :(

>   		switch (o) {
>   		case 'B': /* rebuild database */
>   			opt_B = 1;
> @@ -231,6 +234,9 @@ main(int argc, char *argv[]) {
>   			printf("Set PSEUDO_PREFIX to run with a different prefix.\n");
>   			exit(0);
>   			break;
> +		case 'k': /* debug severity */
> +			pseudo_severity_set(optarg);
> +			break;
>   		case 'x': /* debug flags */
>   			pseudo_debug_set(optarg);
>   			break;
> diff --git a/pseudo.h b/pseudo.h
> index b6c13f2..e48d38a 100644
> --- a/pseudo.h
> +++ b/pseudo.h
> @@ -26,8 +26,11 @@ extern void pseudo_debug_terse(void);
>   extern void pseudo_debug_set(char *);
>   extern void pseudo_debug_clear(char *);
>   extern void pseudo_debug_flags_finalize(void);
> +extern void pseudo_severity_set(char *);
> +extern void pseudo_severity_flags_finalize(void);
>   extern unsigned long pseudo_util_debug_flags;
>   extern unsigned long pseudo_util_evlog_flags;
> +extern unsigned long pseudo_util_severity_flags;
>   extern int pseudo_util_debug_fd;
>   extern int pseudo_disabled;
>   extern int pseudo_allow_fsync;
> diff --git a/pseudo_util.c b/pseudo_util.c
> index 2b0cc04..f8f2a2f 100644
> --- a/pseudo_util.c
> +++ b/pseudo_util.c
> @@ -63,6 +63,7 @@ static struct pseudo_variables pseudo_env[] = {
>   #endif
>   	{ "PSEUDO_EVLOG", 12, NULL },
>   	{ "PSEUDO_EVLOG_FILE", 17, NULL },
> +	{ "PSEUDO_SEVERITY", 15, NULL },
>   	{ NULL, 0, NULL } /* Magic terminator */
>   };
>   
> @@ -90,6 +91,7 @@ static int pseudo_evlog_next_entry = 0;
>   static void pseudo_evlog_set(char *);
>   static void pseudo_evlog_flags_finalize(void);
>   static unsigned long pseudo_debug_flags_in(char *);
> +static unsigned long pseudo_severity_flags_in(char *);
>   
>   /* -1 - init hasn't been run yet
>    * 0 - init has been run
> @@ -247,10 +249,17 @@ pseudo_init_util(void) {
>   		pseudo_evlog_flags_finalize();
>   	}
>   	free(env);
> +	env = pseudo_get_value("PSEUDO_SEVERITY");
> +	if (env) {
> +		pseudo_severity_set(env);
> +		pseudo_severity_flags_finalize();
> +	}
> +	free(env);
>   }
>   
>   unsigned long pseudo_util_debug_flags = 0;
>   unsigned long pseudo_util_evlog_flags = 0;
> +unsigned long pseudo_util_severity_flags = 0;
>   int pseudo_util_debug_fd = 2;
>   int pseudo_util_evlog_fd = 2;
>   static int debugged_newline = 1;
> @@ -433,6 +442,11 @@ pseudo_evlog_set(char *s) {
>   	pseudo_util_evlog_flags = pseudo_debug_flags_in(s);
>   }
>   
> +void
> +pseudo_severity_set(char *s) {
> +	pseudo_util_severity_flags = pseudo_severity_flags_in(s);
> +}
> +
>   /* This exists because we don't want to allocate a bunch of strings
>    * and free them immediately if you have several flags set.
>    */
> @@ -457,6 +471,11 @@ pseudo_evlog_flags_finalize(void) {
>   	pseudo_flags_finalize(pseudo_util_evlog_flags, "PSEUDO_EVLOG");
>   }
>   
> +void
> +pseudo_severity_flags_finalize(void) {
> +	pseudo_flags_finalize(pseudo_util_severity_flags, "PSEUDO_SEVERITY");
> +}
> +
>   static unsigned long
>   pseudo_debug_flags_in(char *s) {
>   	unsigned long flags = 0;
> @@ -471,6 +490,31 @@ pseudo_debug_flags_in(char *s) {
>   	return flags;
>   }
>   
> +static unsigned long
> +pseudo_severity_flags_in(char *s) {
> +	unsigned long flags = 0;
> +	char *token = NULL;
> +	char *saveptr = NULL;
> +	char *s_copy = NULL;
> +
> +	if (!s)
> +		return flags;
> +
> +	s_copy = strdup(s);
> +
> +	token = strtok_r(s_copy, " ,;", &saveptr);
> +	while (token != NULL) {
> +		pseudo_sev_t id = pseudo_sev_id(token);
> +		if (id > SEVERITY_NONE && id < SEVERITY_MAX) {
> +				flags |= (1UL << id);
> +			}
> +		token = strtok_r(NULL, " ,;", &saveptr);
> +	}
> +
> +	free(s_copy);
> +	return flags;	
> +}
> +
>   void
>   pseudo_debug_clear(char *s) {
>   	if (!s)
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4074): https://lists.yoctoproject.org/g/yocto-patches/message/4074
> Mute This Topic: https://lists.yoctoproject.org/mt/119511285/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

