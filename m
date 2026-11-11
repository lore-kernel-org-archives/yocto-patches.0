Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2572.1794370865918820642
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3lt2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:05 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 09/34] Remove unused #if 0 debug code
Date: Tue, 10 Nov 2026 22:20:37 -0600
Message-Id: <1794370862-30908-10-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5269
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

Remove an abort() check for clients named "pseudo" in
pseudo_client_request(), and dump_env() in pseudo_util.c, which have
been disabled with #if 0 and are not referred to.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_client.c |  5 -----
 pseudo_util.c   | 16 ----------------
 2 files changed, 21 deletions(-)

diff --git a/pseudo_client.c b/pseudo_client.c
index 4c9c2e8..bbe0829 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1399,11 +1399,6 @@ pseudo_client_request(pseudo_msg_t *msg, size_t len, const char *path) {
 	pseudo_msg_t *response = 0;
 	int tries = 0;
 	int rc;
-	#if 0
-	extern char *program_invocation_short_name;
-	if (!strcmp(program_invocation_short_name, "pseudo"))
-		abort();
-	#endif
 
 	if (!msg)
 		return 0;
diff --git a/pseudo_util.c b/pseudo_util.c
index 25f8bc0..78c2e1b 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -106,22 +106,6 @@ int (*pseudo_real_unsetenv)(const char *) = unsetenv;
 char * (*pseudo_real_getenv)(const char *) = getenv;
 int (*pseudo_real_setenv)(const char *, const char *, int) = setenv;
 
-#if 0
-static void
-dump_env(char **envp) {
-	size_t i = 0;
-	for (i = 0; envp[i]; i++) {
-		pseudo_debug(PDBGF_ENV, "dump_envp: [%d]%s\n", (int) i, envp[i]);
-	}
-
-	for (i = 0; pseudo_env[i].key; i++) {
-		pseudo_debug(PDBGF_ENV, "dump_envp: {%d}%s=%s\n", (int) i, pseudo_env[i].key, pseudo_env[i].value);
-	}
-
-	pseudo_debug(PDBGF_ENV, "dump_envp: _in_init %d\n", pseudo_util_initted);
-}
-#endif
-
 int
 pseudo_has_unload(char * const *envp) {
 	static const char unload[] = "PSEUDO_UNLOAD";
-- 
1.8.3.1

