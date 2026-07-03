Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8DBC4450C
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83552.1783039589023657821
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ1J069650;
	Thu, 2 Jul 2026 19:46:24 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 20/23] exec*: Replace bash workaround to avoid memory corruption
Date: Thu,  2 Jul 2026 19:46:15 -0500
Message-Id: <1783039578-31531-21-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4388

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Bash intercepts getenv/setenv/unsetenv and does magic with it internally.

The data pointed to by environ may not be allocated by glibc but by bash
and the glibc env functions have their own memory handling outside of malloc.
Unfortuantely bash doesn't keep environ and the result of setenv/getenv/unsetenv
in sync either. This means the current workaround badly corrupts memory and it
is just luck we're not breaking more often than the occasional opkg-build segfaults
we've been seeing.

Fixing this is tricky, the best we can probably do is to read through environ and
create our own copy of the it, modifying it how we need to keep the pseudo variables
correct.

We do already have a function which can copy and modify the environment, we can
therefore swap some setupenv calls for setupenvp and switch out environ around
the exec calls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20260701131336.3578279-6-richard.purdie@linuxfoundation.org>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 ports/common/guts/execv.c  | 19 ++++++++++++++-----
 ports/common/guts/execvp.c | 15 ++++++++++++---
 ports/unix/guts/popen.c    | 16 +++++++++++++---
 ports/unix/guts/system.c   | 16 +++++++++++++---
 pseudo_client.h            |  3 ---
 pseudo_util.c              | 12 +++---------
 pseudo_wrappers.c          |  6 ------
 7 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/ports/common/guts/execv.c b/ports/common/guts/execv.c
index 7819911..eb328ed 100644
--- a/ports/common/guts/execv.c
+++ b/ports/common/guts/execv.c
@@ -8,6 +8,8 @@
  * wrap_execv(const char *file, char *const *argv) {
  *	int rc = -1;
  */
+	char **new_environ, **orig_environ;
+
 	/* note:  we don't canonicalize this, because we are intentionally
 	 * NOT redirecting execs into the chroot environment.  If you try
 	 * to execute /bin/sh, you get the actual /bin/sh, not
@@ -19,17 +21,24 @@
                 pseudo_client_op(OP_EXEC, PSA_EXEC, -1, -1, path_guess, 0);
 	}
 
-	pseudo_setupenv();
-	if (pseudo_has_unload(NULL)) {
-		/* and here we attach */
-		pseudo_dropenv();
-	}
+	/* Due to bash intercepting setenv/getenv/unsetenv and changing environ
+	   internally itself at will, we create our own environ copy at process
+	   creation based on it to ensure it is correct */
+	orig_environ = environ;
+	new_environ = pseudo_setupenvp(environ);
+	if (pseudo_has_unload(new_environ))
+		new_environ = pseudo_dropenvp(new_environ);
+	environ = new_environ;
+
 	/* if exec() fails, we may end up taking signals unexpectedly...
 	 * not much we can do about that.
 	 */
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execv(file, argv);
 
+	environ = orig_environ;
+	free(new_environ);
+
 /*	return rc;
  * }
  */
diff --git a/ports/common/guts/execvp.c b/ports/common/guts/execvp.c
index acc9fdc..177e4ee 100644
--- a/ports/common/guts/execvp.c
+++ b/ports/common/guts/execvp.c
@@ -8,6 +8,7 @@
  * wrap_execvp(const char *file, char *const *argv) {
  *	int rc = -1;
  */
+	char **new_environ, **orig_environ;
 
 	/* note:  we don't canonicalize this, because we are intentionally
 	 * NOT redirecting execs into the chroot environment.  If you try
@@ -20,9 +21,14 @@
                 pseudo_client_op(OP_EXEC, PSA_EXEC, -1, -1, path_guess, 0);
         }
 
-	pseudo_setupenv();
-	if (pseudo_has_unload(NULL))
-		pseudo_dropenv();
+	/* Due to bash intercepting setenv/getenv/unsetenv and changing environ 
+	   internally itself at will, we create our own environ copy at process
+	   creation based on it to ensure it is correct */
+	orig_environ = environ;
+	new_environ = pseudo_setupenvp(environ);
+	if (pseudo_has_unload(new_environ))
+		new_environ = pseudo_dropenvp(new_environ);
+	environ = new_environ;
 
 	/* if exec() fails, we may end up taking signals unexpectedly...
 	 * not much we can do about that.
@@ -30,6 +36,9 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execvp(file, argv);
 
+	environ = orig_environ;
+	free(new_environ);
+
 /*	return rc;
  * }
  */
diff --git a/ports/unix/guts/popen.c b/ports/unix/guts/popen.c
index d19ec7e..1d48d04 100644
--- a/ports/unix/guts/popen.c
+++ b/ports/unix/guts/popen.c
@@ -7,15 +7,25 @@
  * FILE *popen(const char *command, const char *mode)
  *	FILE *rc = NULL;
  */
+	char **new_environ, **orig_environ;
+
 	/* on at least some systems, popen() calls fork and exec
 	 * in ways that avoid our usual enforcement of the environment.
 	 */
-	pseudo_setupenv();
-	if (pseudo_has_unload(NULL))
-		pseudo_dropenv();
+	/* Due to bash intercepting setenv/getenv/unsetenv and changing environ
+	   internally itself at will, we create our own environ copy at process
+	   creation based on it to ensure it is correct */
+	orig_environ = environ;
+	new_environ = pseudo_setupenvp(environ);
+	if (pseudo_has_unload(new_environ))
+		new_environ = pseudo_dropenvp(new_environ);
+        environ = new_environ;
 
 	rc = real_popen(command, mode);
 
+	environ = orig_environ;
+	free(new_environ);
+
 /*	return rc;
  * }
  */
diff --git a/ports/unix/guts/system.c b/ports/unix/guts/system.c
index 1214314..4b374ec 100644
--- a/ports/unix/guts/system.c
+++ b/ports/unix/guts/system.c
@@ -7,15 +7,25 @@
  * int system(const char *command)
  *	int rc = -1;
  */
+	char **new_environ, **orig_environ;
+
 	if (!command)
 		return 1;
 
-	pseudo_setupenv();
-	if (pseudo_has_unload(NULL))
-		pseudo_dropenv();
+	/* Due to bash intercepting setenv/getenv/unsetenv and changing environ
+	   internally itself at will, we create our own environ copy at process
+	   creation based on it to ensure it is correct */
+	orig_environ = environ;
+	new_environ = pseudo_setupenvp(environ);
+	if (pseudo_has_unload(new_environ))
+		new_environ = pseudo_dropenvp(new_environ);
+	environ = new_environ;
 
 	rc = real_system(command);
 
+	environ = orig_environ;
+	free(new_environ);
+
 /*	return rc;
  * }
  */
diff --git a/pseudo_client.h b/pseudo_client.h
index a013f88..43bbc0a 100644
--- a/pseudo_client.h
+++ b/pseudo_client.h
@@ -52,9 +52,6 @@ extern FILE *pseudo_grp;
 
 /* pseudo_wrappers will try to initialize these */
 extern int (*pseudo_real_lstat)(const char *path, PSEUDO_STATBUF *buf);
-extern int (*pseudo_real_unsetenv)(const char *);
-extern char * (*pseudo_real_getenv)(const char *);
-extern int (*pseudo_real_setenv)(const char *, const char *, int);
 extern int (*pseudo_real_fork)(void);
 extern int (*pseudo_real_execv)(const char *, char * const *);
 
diff --git a/pseudo_util.c b/pseudo_util.c
index 61d47e4..13c974f 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -73,15 +73,9 @@ typedef struct {
 	char *data;
 } pseudo_evlog_entry;
 
-/* so bash overrides getenv/unsetenv/etcetera, preventing them from
- * actually modifying environ, so we have pseudo_wrappers try to dlsym
- * the right values. This could fail, in which case we'd get null
- * pointers, and we'll just call whatever the linker gives us and
- * hope for the best.
- */
-#define SETENV(x, y, z) (pseudo_real_setenv ? pseudo_real_setenv : setenv)(x, y, z)
-#define GETENV(x) (pseudo_real_getenv ? pseudo_real_getenv : getenv)(x)
-#define UNSETENV(x) (pseudo_real_unsetenv ? pseudo_real_unsetenv : unsetenv)(x)
+#define SETENV(x, y, z) setenv(x, y, z)
+#define GETENV(x) getenv(x)
+#define UNSETENV(x) unsetenv(x)
 
 #define PSEUDO_EVLOG_ENTRIES 250
 #define PSEUDO_EVLOG_LENGTH 256
diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index 662c276..6cd8e5d 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -173,12 +173,6 @@ pseudo_init_wrappers(void) {
 	pseudo_real_fsetxattr = real_fsetxattr;
 #endif
 	pseudo_real_lstat = base_lstat;
-	/* bash has its own local copies of these which it uses
-	 * instead of ours...
-	 */
-	pseudo_real_unsetenv = dlsym(RTLD_NEXT, "unsetenv");
-	pseudo_real_getenv = dlsym(RTLD_NEXT, "getenv");
-	pseudo_real_setenv = dlsym(RTLD_NEXT, "setenv");
 	/* and these are used so the client's server spawn can bypass
 	 * wrappers.
 	 */
-- 
2.53.0


