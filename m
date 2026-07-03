Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B37FC4450B
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83545.1783039586667335062
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ1I069650;
	Thu, 2 Jul 2026 19:46:24 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 19/23] pseudo_util: Clean up memory handling for setupenvp results
Date: Thu,  2 Jul 2026 19:46:14 -0500
Message-Id: <1783039578-31531-20-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4376

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Currently, the environment array allocated by pseudo_setupenvp is never
freed. Fix this (and the copy created by dropenvp).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20260701131336.3578279-5-richard.purdie@linuxfoundation.org>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/common/guts/execve.c       | 4 +++-
 ports/common/guts/posix_spawn.c  | 4 +++-
 ports/common/guts/posix_spawnp.c | 4 +++-
 pseudo.h                         | 2 +-
 pseudo_util.c                    | 3 ++-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/ports/common/guts/execve.c b/ports/common/guts/execve.c
index 1144f7c..c2be66e 100644
--- a/ports/common/guts/execve.c
+++ b/ports/common/guts/execve.c
@@ -8,7 +8,7 @@
  * wrap_execve(const char *file, char *const *argv, char *const *envp) {
  *	int rc = -1;
  */
-	char * const *new_environ;
+	char **new_environ;
 	/* note:  we don't canonicalize this, because we are intentionally
 	 * NOT redirecting execs into the chroot environment.  If you try
 	 * to execute /bin/sh, you get the actual /bin/sh, not
@@ -30,6 +30,8 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execve(file, argv, new_environ);
 
+	free(new_environ);
+
 /*	return rc;
  * }
  */
diff --git a/ports/common/guts/posix_spawn.c b/ports/common/guts/posix_spawn.c
index e15e68f..5896893 100644
--- a/ports/common/guts/posix_spawn.c
+++ b/ports/common/guts/posix_spawn.c
@@ -7,7 +7,7 @@
  * wrap_posix_spawn(pid_t *pid, const char *path, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp) {
  *	int rc = -1;
  */
-	char * const *new_environ;
+	char **new_environ;
 	/* note:  we don't canonicalize this, because we are intentionally
 	 * NOT redirecting execs into the chroot environment.  If you try
 	 * to execute /bin/sh, you get the actual /bin/sh, not
@@ -29,6 +29,8 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_posix_spawn(pid, path, file_actions, attrp, argv, new_environ);
 
+	free(new_environ);
+
 /*	return rc;
  * }
  */
diff --git a/ports/common/guts/posix_spawnp.c b/ports/common/guts/posix_spawnp.c
index b2e1fc8..f3dc16b 100644
--- a/ports/common/guts/posix_spawnp.c
+++ b/ports/common/guts/posix_spawnp.c
@@ -7,7 +7,7 @@
  * wrap_posix_spawnp(pid_t *pid, const char *file, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp) {
  *	int rc = -1;
  */
-	char * const *new_environ;
+	char **new_environ;
 	/* note:  we don't canonicalize this, because we are intentionally
 	 * NOT redirecting execs into the chroot environment.  If you try
 	 * to execute /bin/sh, you get the actual /bin/sh, not
@@ -29,6 +29,8 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_posix_spawnp(pid, file, file_actions, attrp, argv, new_environ);
 
+	free(new_environ);
+
 /*	return rc;
  * }
  */
diff --git a/pseudo.h b/pseudo.h
index ae1fe0d..e1129fa 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -86,7 +86,7 @@ void pseudo_new_pid(void);
 #define PSEUDO_MAX_LINK_RECURSION 16
 extern char *pseudo_fix_path(const char *, const char *, size_t, size_t, size_t *, int);
 extern void pseudo_dropenv(void);
-extern char **pseudo_dropenvp(char * const *);
+extern char **pseudo_dropenvp(char **);
 extern void pseudo_setupenv(void);
 extern char **pseudo_setupenvp(char * const *);
 extern char *pseudo_prefix_path(char *);
diff --git a/pseudo_util.c b/pseudo_util.c
index 10274b8..61d47e4 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1050,7 +1050,7 @@ void pseudo_dropenv() {
 }
 
 char **
-pseudo_dropenvp(char * const *envp) {
+pseudo_dropenvp(char **envp) {
 	char **new_envp;
 	int i, j;
 
@@ -1081,6 +1081,7 @@ pseudo_dropenvp(char * const *envp) {
 		}
 	}
 	new_envp[j++] = NULL;
+	free(envp);
 	return new_envp;
 }
 
-- 
2.53.0


