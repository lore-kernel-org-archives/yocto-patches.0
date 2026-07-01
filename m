Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40EBC43327
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 13:13:52 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44828.1782911625653500858
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 06:13:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=C6dn8QbB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so4345575e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 06:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782911624; x=1783516424; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXE42ppu7GRuoze4l58IbKdiNoH1rvI2YwbnwK/knp8=;
        b=C6dn8QbBs+cjD+p9GL+uq2jodWPhvoC9fOI/BecnH/iXt7UDxqauEFWum9XhUzYviY
         kEI3LbDhZT+UBjvrS/aD0ez7sBmBgboNeZYymrrnb3/0/Bods/dN9ij5dNVf54fAWYn/
         Sg60RI68wX871yWDvxTtw3ZPvtQC4XrkQWzWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911624; x=1783516424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uXE42ppu7GRuoze4l58IbKdiNoH1rvI2YwbnwK/knp8=;
        b=Y6OJ4j7Q/wy7EyXc/txrctCgNTPXmGspgaYEIrYU6yyDKxLL9gEDLXD6xe0ehNGhH6
         WFCg01sJl9Pq0DugEpY/Azv8h89nuiWu5MbuGtzsksHRVLu6YFBQLEQ1/legTJ20HbtM
         yi24HTkWGKWZqnkKRkUFqrhTif3mvGumdngvwAtPhXsHEVDuRWDCvpo35I6SelK7SZKE
         HZcdEkhy4507qMoEMIlSIxtM/hsg3EcN3B2LKyWNAIOkYbmUPNbs5VppbrdHWPL4BM2+
         NK0WdTvDuuz+4Dlqh9f103Q95f2b0lA3F5zXEXbK+ko048AHVb3dt9p8L1dj5PolxImG
         Pcvw==
X-Gm-Message-State: AOJu0YwabG+wEV8fOgvDnkPmOsfVej5tMsbL/f0fTOfC0qvu/Cpe7DEZ
	U7l+lwBbiEV15fj80WKKMUMMopT0cjA+Os3wsOilEf6CorSIs75oXRTvAidGg6tjM6eIdNUqrzT
	TeuIG
X-Gm-Gg: AfdE7cndrMco49GZHXwujfuA2jZGcy2m/NfkzY7UGRJyD0IiMgS36BdJ24d6ASqno1I
	dReqQxVsgf8VFmQPNa0W+O40ESW30FuQlnG38LPwNw72l3KQ8BJUQzaiceGclKuX94VeIwcFHoH
	aIeN+Sda4ELFMkyH6OyNaYjKOa+OQQ3dORdU5koKJTYcJIDtqSpRLySh1keMQ6jeA15lSEMCBfk
	12Ns5Imfi5oHao9N5ywT1IjwhvssuxKZPh2iOxiBfR5DzWpWk925FinKh51Pfchq2IyX0TmWhSU
	7TXWL2MaYGzszgjoQcymMOTAR5dnsiClj3aeKS1Kgs8j+wCC45q05/VlVMdypDDZnmexVdWojRw
	8XCEMeorDZXUtsLLpDJbRTQYyCy1pyiLF5d7RfMrJJqTmbWuqxa5g/e26K2keQrIOjMn/KL2O5E
	aFsC7cAfxfttpjOTf30LvyFGx4Nb4l5NRTsSirkN4q4w==
X-Received: by 2002:a05:600c:35d0:b0:493:c3cb:409e with SMTP id 5b1f17b1804b1-493c3cb42d9mr11219835e9.15.1782911623800;
        Wed, 01 Jul 2026 06:13:43 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6b3f:20f2:ee05:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567884770sm17568280f8f.33.2026.07.01.06.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:13:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 6/7] exec*: Replace bash workaround to avoid memory corruption
Date: Wed,  1 Jul 2026 14:13:35 +0100
Message-ID: <20260701131336.3578279-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 13:13:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4348

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

We do already have a function which can copyn and modify the environment, we can
therefore swap some setupenv calls for setupenvp and switch out environ around
the exec calls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
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
index 599cf31..83f92b3 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -72,15 +72,9 @@ typedef struct {
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
index 9ae1200..112239b 100644
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

