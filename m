Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD41AC43602
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 18:41:10 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.98548.1783104064192344592
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 11:41:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 663IeuaK237103;
	Fri, 3 Jul 2026 13:41:01 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH v2 21/23] pseudo_util: Correctly free memory allocated by pseudo_setupenvp
Date: Fri,  3 Jul 2026 13:40:53 -0500
Message-Id: <1783104055-19005-22-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 18:41:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4416

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Add a function to properly clean up the environment array memory after use.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20260701131336.3578279-7-richard.purdie@linuxfoundation.org>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/common/guts/execv.c        |  2 +-
 ports/common/guts/execve.c       |  2 +-
 ports/common/guts/execvp.c       |  2 +-
 ports/common/guts/posix_spawn.c  |  2 +-
 ports/common/guts/posix_spawnp.c |  2 +-
 ports/unix/guts/popen.c          |  2 +-
 ports/unix/guts/system.c         |  2 +-
 pseudo.h                         |  1 +
 pseudo_util.c                    | 11 +++++++++++
 9 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/ports/common/guts/execv.c b/ports/common/guts/execv.c
index eb328ed..d4031b3 100644
--- a/ports/common/guts/execv.c
+++ b/ports/common/guts/execv.c
@@ -37,7 +37,7 @@
 	rc = real_execv(file, argv);
 
 	environ = orig_environ;
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/common/guts/execve.c b/ports/common/guts/execve.c
index c2be66e..de2f1d4 100644
--- a/ports/common/guts/execve.c
+++ b/ports/common/guts/execve.c
@@ -30,7 +30,7 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execve(file, argv, new_environ);
 
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/common/guts/execvp.c b/ports/common/guts/execvp.c
index 177e4ee..ffc94be 100644
--- a/ports/common/guts/execvp.c
+++ b/ports/common/guts/execvp.c
@@ -37,7 +37,7 @@
 	rc = real_execvp(file, argv);
 
 	environ = orig_environ;
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/common/guts/posix_spawn.c b/ports/common/guts/posix_spawn.c
index 5896893..46ebb0e 100644
--- a/ports/common/guts/posix_spawn.c
+++ b/ports/common/guts/posix_spawn.c
@@ -29,7 +29,7 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_posix_spawn(pid, path, file_actions, attrp, argv, new_environ);
 
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/common/guts/posix_spawnp.c b/ports/common/guts/posix_spawnp.c
index f3dc16b..194bcb3 100644
--- a/ports/common/guts/posix_spawnp.c
+++ b/ports/common/guts/posix_spawnp.c
@@ -29,7 +29,7 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_posix_spawnp(pid, file, file_actions, attrp, argv, new_environ);
 
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/unix/guts/popen.c b/ports/unix/guts/popen.c
index 1d48d04..1ce083d 100644
--- a/ports/unix/guts/popen.c
+++ b/ports/unix/guts/popen.c
@@ -24,7 +24,7 @@
 	rc = real_popen(command, mode);
 
 	environ = orig_environ;
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/ports/unix/guts/system.c b/ports/unix/guts/system.c
index 4b374ec..12a3aff 100644
--- a/ports/unix/guts/system.c
+++ b/ports/unix/guts/system.c
@@ -24,7 +24,7 @@
 	rc = real_system(command);
 
 	environ = orig_environ;
-	free(new_environ);
+	pseudo_free_envp(new_environ);
 
 /*	return rc;
  * }
diff --git a/pseudo.h b/pseudo.h
index e1129fa..ecb1615 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -89,6 +89,7 @@ extern void pseudo_dropenv(void);
 extern char **pseudo_dropenvp(char **);
 extern void pseudo_setupenv(void);
 extern char **pseudo_setupenvp(char * const *);
+extern void pseudo_free_envp(char **envp);
 extern char *pseudo_prefix_path(char *);
 extern char *pseudo_bindir_path(char *);
 extern char *pseudo_libdir_path(char *);
diff --git a/pseudo_util.c b/pseudo_util.c
index 13c974f..3a6c05c 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1295,6 +1295,17 @@ pseudo_setupenvp(char * const *envp) {
 	return new_envp;
 }
 
+/* Free data allocated by pseudo_setupenvp() */
+void
+pseudo_free_envp(char **envp) {
+	int i;
+
+	for (i = 0; envp && envp[i]; ++i) {
+		free(envp[i]);
+	}
+	free(envp);
+}
+
 /* Append the file value to the prefix value. */
 char *
 pseudo_append_path(const char * prefix, size_t prefix_len, char *file) {
-- 
1.8.3.1


