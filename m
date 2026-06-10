Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C55CD8CB9
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 11:46:36 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18355.1781091987092163099
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 04:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=iZa9gLBN;
 spf=pass (domain: gmail.com, ip: 209.85.208.47, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68b90fc6a1dso2775330a12.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781091985; x=1781696785; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOlgvYhHTzVRNQlneINMF2oinsKnP+jOhYRFb+5Y7Y0=;
        b=iZa9gLBNqRosf43b95XZsiS0dIaQAf+Cr+WTYRXpNT6KSzVU5RtiPM6A7g3zb6TAWO
         IbxAnupXZvn3H9h0rd76ZUVD4dIL0uA9A678yUrIvJ0Gddcd7EXTqyjl+hPLbtQI9XTQ
         F0izc7NXzkSQwVqBrmdAtF7las7bSd8VvW9L/NacQ8gG48n9ZQ+FKjSB9mC+k5QPD5eB
         DJ+IweFl0Y08Zfee5J2m4QsxfUPxhVbqu1i0GNxrck3o2DBjIOFYtHgbHbL1pnrmwrgP
         7ba8RYY3OMPEeu6O3KIIqJSWnUmmdiJ68dfIeYBOuoWrmFw1LrHuAegkRgXYXSbvvNM+
         qLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091985; x=1781696785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOlgvYhHTzVRNQlneINMF2oinsKnP+jOhYRFb+5Y7Y0=;
        b=UDbywdtkIX3MNgssW4AfRkdcquq8aMkNhr8rF3e0HeXBxFW7R9vGH1ttnAIkw0wimn
         lAj3sqqrSas90k9PZjyMvL/71KCs2QPDUAbzmIn4aFmP002evzqWCmuekUNiZ0/CoXwN
         RMvJxWPHBYNmPGRLzISTI6CyYouRn5G53PcnMZ7wrvDX8aAtIe0QCvEJL+IapCRhZLH5
         u9Dg6eN/S0XAN6rqWTQxI2hMjs3R7uOAc+h7pL8hVfJ6b7pTJtKwNOzcQ1iyCvTfpbZH
         VHgCs0egTe4uAvTHqML0py1g4KcA23T/G6EfXSAcJeiXDQAEySyWmkKu5fX+31Fskpt0
         sxDA==
X-Gm-Message-State: AOJu0YzFGDeJ7dhhQzhR379nnoVgz+niZNjmIjAKffBmEPWgI86zzjUt
	Ox0y76v9Yqfx9DlOEah2JkbwAa5N+yrPhKW5kquwInuTd+Q579WTX7Q2U4xabgCF
X-Gm-Gg: Acq92OFoTgyi0Kg68keitK32wI/FB58qb+QZmnIGEpCKgDx4PPZkknYGrR5N+xgh9hu
	JgwK9iGjR58X5C6HCoRH+/k+dbxLzQzB9Vb7iBFeAdaB+tOoBXjDHFhCy65w7H4hyR+WHverfYP
	gH/JTQgSKXCJagZ0h3jrs9bcVfo+2Pz1DeEA5PqmlCu5PojQvX/fPb2qYUShcEmFB1Zx3Om7Q0h
	3PXA8K1DlUarvOuOgvN+b2oaPG7m44rCHjEWtEwoVwH/EXOXRHwbXPnYSrPP64k4Aua4HuhoAAi
	Na/aT0brIqQMdHG2r+VRbUbfqMWJnw2J5mgp7yS1QYDCZocLs/lfkePCo7Tg8vxIJj46FkNB0Cv
	JWDkJbNssy0OzjywF3ULXU4Ho7vzxLveWBIS3oG9ufqLIcjYTwJOO6EBJxjDCS5pU19YtQOnqSK
	sor6YCiwUpK0Yf89Cy1+FeAdZcln/jvdZFVaAtd8k=
X-Received: by 2002:a05:6402:4487:b0:68f:9fd9:435a with SMTP id 4fb4d7f45d1cf-68ff2495467mr9397243a12.17.1781091985246;
        Wed, 10 Jun 2026 04:46:25 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912faea64dsm5997164a12.19.2026.06.10.04.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:46:24 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH 1/8] pseudo_util: Change pseudo_diag() calls to appropriate logging macros
Date: Wed, 10 Jun 2026 14:46:03 +0300
Message-ID: <20260610114610.60776-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:46:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4192

From: Dmitry Sakhonchik <frezidok1@gmail.com>

The patch is based on: [pseudo] pseudo: Add new logging macros
and implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 pseudo_util.c | 88 +++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index f8f2a2f..dbd979e 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -177,7 +177,7 @@ pseudo_get_value(const char *key) {
 		value = NULL;
 
 	if (!pseudo_env[i].key) 
-		pseudo_diag("Unknown variable %s.\n", key);
+		pseudo_warning("Unknown variable %s.\n", key);
 
 	return value;
 }
@@ -202,12 +202,12 @@ pseudo_set_value(const char *key, const char *value) {
 			if (new)
 				pseudo_env[i].value = new;
 			else
-				pseudo_diag("warning: failed to save new value (%s) for key %s\n",
+				pseudo_warning("failed to save new value (%s) for key %s\n",
 					value, key);
 		} else
 			pseudo_env[i].value = NULL;
 	} else {
-		if (!pseudo_util_initted) pseudo_diag("Unknown variable %s.\n", key);
+		if (!pseudo_util_initted) pseudo_warning("Unknown variable %s.\n", key);
 		rc = -EINVAL;
 	}
 
@@ -350,7 +350,7 @@ without_libpseudo(char *list) {
 	}
 	list = strdup(list);
 	if (!list) {
-		pseudo_diag("Couldn't allocate memory to remove libpseudo from environment.\n");
+		pseudo_error("Couldn't allocate memory to remove libpseudo from environment.\n");
 	}
 	while (list && !(*real_regexec)(&libpseudo_regex, list, 1, pmatch, 0)) {
 		char *start = list + pmatch[0].rm_so;
@@ -360,7 +360,7 @@ without_libpseudo(char *list) {
 		memmove(start, end, strlen(end) + 1);
 		++counter;
 		if (counter > 5) {
-			pseudo_diag("Found way too many libpseudo.so in environment, giving up.\n");
+			pseudo_error("Found way too many libpseudo.so in environment, giving up.\n");
 			return list;
 		}
 	}
@@ -621,7 +621,7 @@ pseudo_evlog_internal(char *fmt, ...) {
 				event_log[i].data = pseudo_evlog_buffer + (PSEUDO_EVLOG_LENGTH * i);
 			}
 		} else {
-			pseudo_diag("fatal: can't allocate event log storage.\n");
+			pseudo_error("can't allocate event log storage.\n");
 		}
 	}
 
@@ -668,7 +668,7 @@ pseudo_append_element(char *newpath, char *root, size_t allocated, char **pcurre
 	if (!newpath ||
 	    !pcurrent || !*pcurrent ||
 	    !root || !element) {
-		pseudo_diag("pseudo_append_element: invalid args.\n");
+		pseudo_warning("pseudo_append_element: invalid args.\n");
 		return -1;
 	}
 
@@ -689,7 +689,7 @@ pseudo_append_element(char *newpath, char *root, size_t allocated, char **pcurre
 		 * fall through and do standard processing
 		 */
 		if (!proc_path)
-			pseudo_diag("allocation failed seeking memory for path (%s).\n", newpath);
+			pseudo_warning("allocation failed seeking memory for path (%s).\n", newpath);
 		else
 			is_proc = 1;
 	}
@@ -729,7 +729,7 @@ pseudo_append_element(char *newpath, char *root, size_t allocated, char **pcurre
 	/* current length, plus / <element> / \0 */
 	/* => curlen + elen + 3 */
 	if (curlen + elen + 3 > allocated) {
-		pseudo_diag("pseudo_append_element: path too long (wanted %lu bytes).\n", (unsigned long) curlen + elen + 3);
+		pseudo_error("pseudo_append_element: path too long (wanted %lu bytes).\n", (unsigned long) curlen + elen + 3);
 		return -1;
 	}
 	/* append a slash */
@@ -798,7 +798,7 @@ pseudo_append_element(char *newpath, char *root, size_t allocated, char **pcurre
 					char *target_link_path = malloc(pseudo_path_max());
 
 					if (!target_link_path)
-						pseudo_diag("allocation failed seeking memory for path (%s/%s).\n", proc_path, linkbuf);
+						pseudo_error("allocation failed seeking memory for path (%s/%s).\n", proc_path, linkbuf);
 						/* Fall through, nothing we can do here */
 					else {
 						snprintf(target_link_path, target_link_max, "%s/%s", proc_path, linkbuf);
@@ -865,7 +865,7 @@ pseudo_append_elements(char *newpath, char *root, size_t allocated, char **curre
 	if (!newpath || !root ||
 	    !current || !*current ||
 	    !path) {
-		pseudo_diag("pseudo_append_elements: invalid arguments.");
+		pseudo_error("pseudo_append_elements: invalid arguments.");
 		return -1;
 	}
 	if (!sbuf) {
@@ -935,7 +935,7 @@ pseudo_fix_path(const char *base, const char *path, size_t rootlen, size_t basel
 	int trailing_slash = 0;
 	
 	if (!path) {
-		pseudo_diag("can't fix empty path.\n");
+		pseudo_warning("can't fix empty path.\n");
 		return 0;
 	}
 	if (baselen == 1) {
@@ -957,7 +957,7 @@ pseudo_fix_path(const char *base, const char *path, size_t rootlen, size_t basel
 	if (!pathbufs[pathbuf]) {
 		pathbufs[pathbuf] = malloc(newpathlen);
 		if (!pathbufs[pathbuf]) {
-			pseudo_diag("allocation failed seeking memory for path (%s).\n", path);
+			pseudo_error("allocation failed seeking memory for path (%s).\n", path);
 			return 0;
 		}
 	}
@@ -976,7 +976,7 @@ pseudo_fix_path(const char *base, const char *path, size_t rootlen, size_t basel
 	 * easier for the library.
 	 */
 	if (!newpath) {
-		pseudo_diag("allocation failed seeking memory for path (%s).\n", path);
+		pseudo_error("allocation failed seeking memory for path (%s).\n", path);
 		return 0;
 	}
 	newpath[0] = '\0';
@@ -1037,7 +1037,7 @@ void pseudo_dropenv() {
 	if (ld_preload) {
 		ld_preload = without_libpseudo(ld_preload);
 		if (!ld_preload) {
-			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+			pseudo_error("can't allocate new %s variable.\n", PRELINK_LIBRARIES);
 		}
 		if (ld_preload && strlen(ld_preload)) {
 			SETENV(PRELINK_LIBRARIES, ld_preload, 1);
@@ -1056,7 +1056,7 @@ pseudo_dropenvp(char * const *envp) {
 
 	new_envp = malloc((i + 1) * sizeof(*new_envp));
 	if (!new_envp) {
-		pseudo_diag("fatal: can't allocate new environment.\n");
+		pseudo_error("can't allocate new environment.\n");
 		return NULL;
 	}
 
@@ -1065,7 +1065,7 @@ pseudo_dropenvp(char * const *envp) {
 		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=")) {
 			char *new_val = without_libpseudo(envp[i]);
 			if (!new_val) {
-				pseudo_diag("fatal: can't allocate new environment variable.\n");
+				pseudo_error("can't allocate new environment variable.\n");
 				return 0;
 			} else {
 				/* don't keep an empty value; if the whole string is
@@ -1111,7 +1111,7 @@ pseudo_setupenv() {
 		size_t len = strlen(libdir_path) + 1 + (strlen(libdir_path) + 2) + 1;
 		char *newenv = malloc(len);
 		if (!newenv) {
-			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_PATH);
+			pseudo_error("can't allocate new %s variable.\n", PRELINK_PATH);
 		} else {
 		    snprintf(newenv, len, "%s:%s64", libdir_path, libdir_path);
 		    SETENV(PRELINK_PATH, newenv, 1);
@@ -1121,7 +1121,7 @@ pseudo_setupenv() {
 		size_t len = strlen(ld_library_path) + 1 + strlen(libdir_path) + 1 + (strlen(libdir_path) + 2) + 1;
 		char *newenv = malloc(len);
 		if (!newenv) {
-			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_PATH);
+			pseudo_error("can't allocate new %s variable.\n", PRELINK_PATH);
 		} else {
 		    snprintf(newenv, len, "%s:%s:%s64", ld_library_path, libdir_path, libdir_path);
 		    SETENV(PRELINK_PATH, newenv, 1);
@@ -1136,7 +1136,7 @@ pseudo_setupenv() {
 	if (ld_preload) {
 		ld_preload = with_libpseudo(ld_preload, libdir_path);
 		if (!ld_preload) {
-			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+			pseudo_error("can't allocate new %s variable.\n", PRELINK_LIBRARIES);
 		} else {
 		    SETENV(PRELINK_LIBRARIES, ld_preload, 1);
 		    free(ld_preload);
@@ -1144,7 +1144,7 @@ pseudo_setupenv() {
 	} else {
 		ld_preload = with_libpseudo("", libdir_path);
 		if (!ld_preload) {
-			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+			pseudo_error("can't allocate new %s variable.\n", PRELINK_LIBRARIES);
 		} else {
 		    SETENV(PRELINK_LIBRARIES, ld_preload, 1);
 		    free(ld_preload);
@@ -1216,7 +1216,7 @@ pseudo_setupenvp(char * const *envp) {
 	j = 0;
 	new_envp = malloc((env_count + 1) * sizeof(*new_envp));
 	if (!new_envp) {
-		pseudo_diag("fatal: can't allocate new environment.\n");
+		pseudo_error("can't allocate new environment.\n");
 		return NULL;
 	}	
 
@@ -1225,7 +1225,7 @@ pseudo_setupenvp(char * const *envp) {
 		size_t len = strlen(PRELINK_PATH "=") + strlen(libdir_path) + 1 + (strlen(libdir_path) + 2) + 1;
 		char *newenv = malloc(len);
 		if (!newenv) {
-			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_PATH);
+			pseudo_error("can't allocate new %s variable.\n", PRELINK_PATH);
 		} else {
 		    snprintf(newenv, len, PRELINK_PATH "=%s:%s64", libdir_path, libdir_path);
 		    new_envp[j++] = newenv;
@@ -1234,7 +1234,7 @@ pseudo_setupenvp(char * const *envp) {
 		size_t len = strlen(ld_library_path) + 1 + strlen(libdir_path) + 1 + (strlen(libdir_path) + 2) + 1;
 		char *newenv = malloc(len);
 		if (!newenv) {
-			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_PATH);
+			pseudo_error("can't allocate new %s variable.\n", PRELINK_PATH);
 		} else {
 		    snprintf(newenv, len, "%s:%s:%s64", ld_library_path, libdir_path, libdir_path);
 		    new_envp[j++] = newenv;
@@ -1247,18 +1247,18 @@ pseudo_setupenvp(char * const *envp) {
 	if (ld_preload) {
 		ld_preload = with_libpseudo(ld_preload, libdir_path);
 		if (!ld_preload) {
-			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+			pseudo_error("can't allocate new %s variable.\n", PRELINK_LIBRARIES);
 		} else
 			new_envp[j++] = ld_preload;
 	} else {
 		ld_preload = with_libpseudo("", libdir_path);
 		if (!ld_preload) {
-			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+			pseudo_error("can't allocate new %s variable.\n", PRELINK_LIBRARIES);
 		} else {
 			size_t len = strlen(PRELINK_LIBRARIES "=") + strlen(ld_preload) + 1;
 			char *newenv = malloc(len);
 			if (!newenv) {
-				pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+				pseudo_error("can't allocate new %s variable.\n", PRELINK_LIBRARIES);
 			} else {
 				snprintf(newenv, len, PRELINK_LIBRARIES "=%s", ld_preload);
 				new_envp[j++] = newenv;
@@ -1287,7 +1287,7 @@ pseudo_setupenvp(char * const *envp) {
 			size_t len = strlen(pseudo_env[i].key) + 1 + strlen(pseudo_env[i].value) + 1;
 			char *newenv = malloc(len);
 			if (!newenv) {
-				pseudo_diag("fatal: can't allocate new variable.\n");
+				pseudo_error("can't allocate new variable.\n");
 			} else {
 				snprintf(newenv, len, "%s=%s", pseudo_env[i].key, pseudo_env[i].value);
 				new_envp[j++] = newenv;
@@ -1339,7 +1339,7 @@ pseudo_prefix_path(char *file) {
 	char * prefix = pseudo_get_prefix(NULL);
 
 	if (!prefix) {
-		pseudo_diag("You must set the PSEUDO_PREFIX environment variable to run pseudo.\n");
+		pseudo_error("You must set the PSEUDO_PREFIX environment variable to run pseudo.\n");
 		exit(1);
 	}
 
@@ -1356,7 +1356,7 @@ pseudo_bindir_path(char *file) {
 	char * bindir = pseudo_get_bindir();
 
 	if (!bindir) {
-		pseudo_diag("You must set the PSEUDO_BINDIR environment variable to run pseudo.\n");
+		pseudo_error("You must set the PSEUDO_BINDIR environment variable to run pseudo.\n");
 		exit(1);
 	}
 
@@ -1373,7 +1373,7 @@ pseudo_libdir_path(char *file) {
 	char * libdir = pseudo_get_libdir();
 
 	if (!libdir) {
-		pseudo_diag("You must set the PSEUDO_LIBDIR environment variable to run pseudo.\n");
+		pseudo_error("You must set the PSEUDO_LIBDIR environment variable to run pseudo.\n");
 		exit(1);
 	}
 
@@ -1390,7 +1390,7 @@ pseudo_localstatedir_path(char *file) {
 	char * localstatedir = pseudo_get_localstatedir();
 
 	if (!localstatedir) {
-		pseudo_diag("You must set the PSEUDO_LOCALSTATEDIR environment variable to run pseudo.\n");
+		pseudo_error("You must set the PSEUDO_LOCALSTATEDIR environment variable to run pseudo.\n");
 		exit(1);
 	}
 
@@ -1424,7 +1424,7 @@ pseudo_get_prefix(char *pathname) {
 		tmp_path = pseudo_fix_path(NULL, mypath, 0, 0, 0, AT_SYMLINK_NOFOLLOW);
 		/* point s to the end of the fixed path */
 		if ((int) strlen(tmp_path) >= pseudo_path_max()) {
-			pseudo_diag("Can't expand path '%s' -- expansion exceeds %d.\n",
+			pseudo_error("Can't expand path '%s' -- expansion exceeds %d.\n",
 				mypath, (int) pseudo_path_max());
 		} else {
 			s = mypath + snprintf(mypath, pseudo_path_max(), "%s", tmp_path);
@@ -1446,7 +1446,7 @@ pseudo_get_prefix(char *pathname) {
 			strcpy(mypath, "/");
 		}
 
-		pseudo_diag("Warning: PSEUDO_PREFIX unset, defaulting to %s.\n",
+		pseudo_warning("PSEUDO_PREFIX unset, defaulting to %s.\n",
 			mypath);
 		pseudo_set_value("PSEUDO_PREFIX", mypath);
 		s = pseudo_get_value("PSEUDO_PREFIX");
@@ -1702,7 +1702,7 @@ pseudo_logfile(char *filename, char *defname, int prefer_fd) {
 		}
 		pseudo_path = pseudo_localstatedir_path(defname);
 		if (!pseudo_path) {
-			pseudo_diag("can't get path for prefix/%s\n", PSEUDO_LOGFILE);
+			pseudo_error("can't get path for prefix/%s\n", PSEUDO_LOGFILE);
 			return -1;
 		}
 	} else {
@@ -1716,7 +1716,7 @@ pseudo_logfile(char *filename, char *defname, int prefer_fd) {
 					break;
 				case 'd':
 					if (pid) {
-						pseudo_diag("found second %%d in PSEUDO_DEBUG_FILE, ignoring.\n");
+						pseudo_info("found second %%d in PSEUDO_DEBUG_FILE, ignoring.\n");
 						return -1;
 					} else {
 						pid = s;
@@ -1724,7 +1724,7 @@ pseudo_logfile(char *filename, char *defname, int prefer_fd) {
 					break;
 				case 's':
 					if (prog) {
-						pseudo_diag("found second %%s in PSEUDO_DEBUG_FILE, ignoring.\n");
+						pseudo_info("found second %%s in PSEUDO_DEBUG_FILE, ignoring.\n");
 						return -1;
 					} else {
 						prog = s;
@@ -1732,10 +1732,10 @@ pseudo_logfile(char *filename, char *defname, int prefer_fd) {
 					break;
 				default:
 					if (isprint(s[1])) {
-						pseudo_diag("found unknown format character '%c' in PSEUDO_DEBUG_FILE, ignoring.\n",
+						pseudo_info("found unknown format character '%c' in PSEUDO_DEBUG_FILE, ignoring.\n",
 							s[1]);
 					} else {
-						pseudo_diag("found unknown format character '\\x%02x' in PSEUDO_DEBUG_FILE, ignoring.\n",
+						pseudo_info("found unknown format character '\\x%02x' in PSEUDO_DEBUG_FILE, ignoring.\n",
 							(unsigned char) s[1]);
 					}
 					return -1;
@@ -1750,7 +1750,7 @@ pseudo_logfile(char *filename, char *defname, int prefer_fd) {
 			len += strlen(program_invocation_short_name);
 		pseudo_path = malloc(len);
 		if (!pseudo_path) {
-			pseudo_diag("can't allocate space for debug file name.\n");
+			pseudo_error("can't allocate space for debug file name.\n");
 			return -1;
 		}
 		if (pid && prog) {
@@ -1770,7 +1770,7 @@ pseudo_logfile(char *filename, char *defname, int prefer_fd) {
 	}	
 	fd = open(pseudo_path, O_WRONLY | O_APPEND | O_CREAT | O_CLOEXEC, 0644);
 	if (fd == -1) {
-		pseudo_diag("help: can't open log file %s: %s\n", pseudo_path, strerror(errno));
+		pseudo_error("help: can't open log file %s: %s\n", pseudo_path, strerror(errno));
 	} else {
 		/* try to force fd to prefer_fd.  We do this because glibc's malloc
 		 * debug unconditionally writes to fd 2, and we don't want
@@ -1799,7 +1799,7 @@ pseudo_debug_logfile(char *defname, int prefer_fd) {
 
 	fd = pseudo_logfile(filename, defname, prefer_fd);
 	if (fd > -1) {
-		pseudo_diag("debug_logfile: fd %d\n", fd);
+		pseudo_info("debug_logfile: fd %d\n", fd);
 		pseudo_util_debug_fd = fd;
 		return 0;
 	}
@@ -1864,7 +1864,7 @@ pseudo_dump_data(char *name, const void *v, size_t len) {
 	const unsigned char *base = v;
 	const unsigned char *data = base;
 	int remaining = len;
-	pseudo_diag("%s at %p [%d byte%s]:\n",
+	pseudo_info("%s at %p [%d byte%s]:\n",
 		name ? name : "data", v, (int) len, len == 1 ? "" : "s");
 	while (remaining > 0) {
 		char *hexptr = hexbuf;
@@ -1882,7 +1882,7 @@ pseudo_dump_data(char *name, const void *v, size_t len) {
 		}
 		*hexptr = '\0';
 		*asciiptr = '\0';
-		pseudo_diag("0x%06x %-50.50s '%.16s'\n",
+		pseudo_info("0x%06x %-50.50s '%.16s'\n",
 			(int) (data - base),
 			hexbuf, asciibuf);
 		remaining = remaining - 16;

base-commit: f554e5d2b207eb96754d2c62784419a46cb364ba

