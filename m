Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4D0CD8C9F
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 12:45:37 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53673.1780922727028935556
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Jun 2026 05:45:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Y0xxwLFE;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: frezidok1@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so609784766b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 08 Jun 2026 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780922725; x=1781527525; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uA4NHnIO6WQQbrIsvYYuPsePhrQyWsrJkAbCKuLDlpA=;
        b=Y0xxwLFE8ZbPvyW5zakVEE6LL7wdViIJNSt4x9MwG8f0sukbWn1Jovxf2KYkBnaYpm
         hUZmtyahI26YirunxJ4muV7zBHnfAu4l+ovCgmzEyV43VHJnJu3X2Y4R1d5VlrH+U17G
         lkK5jKPxfF4Ez/c5x3VxbxJQFQKb7SN87n9MrQKXgAQ1hH/qeb47dciWMUBglMvBPmYN
         aXdhpuX475jJClw8HZOEHV6ZqbRCLC3JtHzbbiKCECT0Q336f7qYDjzujr3PS6mU05X8
         Vw3LALF01za7eidM4VygTwK08bXsQmpke1LnMtmkUP1L4cfAaPUA+fe37BSigCOm7WAi
         Hh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922725; x=1781527525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA4NHnIO6WQQbrIsvYYuPsePhrQyWsrJkAbCKuLDlpA=;
        b=bn0ek+1HyjvqwfURCbK0qZZBzsKwDjjfjbaKKcpbfYgt8iGy49NUmYHCIulcklN3vM
         zCf3vik2gnJ44rJWV0Ugijc6saAzGCK21mQcwxlxf8D5qoah4h7PlOkASPKU1Pue3tJc
         vnarFDrXFNhJ7lKdSbTBnFoROdyYvVzZyZ8RlxOzL2UwDL/j8dtDHNQaBOaQGlnUgQsk
         FGQZk5XO8ap6WnvhhtJTo7xd+9m8FjG+cHkRvRXY0mQIG5gPFfFSddpRkXbh6zFC4cYH
         VjUgL5xxZHvkbD4UgQzK2oW1FouVIqrvpcmqTvCdm1v3SVFhaVbiyykkp36J4yU25y5O
         jl8A==
X-Gm-Message-State: AOJu0YwcHQHKqJDBS1VRC8N+R1mXF6RaC8BYtYLI7SRNy1Mn3lZEp6Yq
	oJLXW6omQElJHddUYhiA/enC7jqlzPe9f3Ff2YzqTV+F7eXEXYaV2r+IU4vI5rGv
X-Gm-Gg: Acq92OGu1tRnPW6g4Vz+tUgBBrTLnDtNQd30uHRBstD+GasFn+sg4vog1Pa6BJ/+zHm
	y+4Kv7kLARr6L2oVTd2A1GesctzEUpNByjyunGbLmm8z1PZVretDaD9VlacQRGiRI4kaQuc4Qxx
	Dg+Xz6r8To2c9rVwKIMUuaM11St0pgFx0Ka2I7HT66gjYS8l5SLJO10/3a81VGqrlcHIV2EWzP1
	6/9F9JYrIwaorqgCJyeifDDtZf9X6QoQAaogXqz8eOidLM5dVdne7sM7o3BsXZPzEDcbcPYNV5Y
	Gz1cf2bbRlk/ln+Mc+azcS2TGAeNDg+hjJkspy0ZEVPk/qD7ZCX+DuDovTL5vEDiJ9UvhyjzbSZ
	1/MpL2Y5wUO8/jFVvfvtC4rL7pGdZuFVFcakJAY4fFjXNXrpC8W4HdqtS4Fv1rp5M8/dVa77E/3
	o1NdKkI9czCkKkb27ilX5ZZYxlR0LN
X-Received: by 2002:a17:907:60cd:b0:bed:f8a3:23a0 with SMTP id a640c23a62f3a-bf3a8a0ce48mr580370166b.25.1780922724851;
        Mon, 08 Jun 2026 05:45:24 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051c8de00sm882877766b.20.2026.06.08.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:45:23 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH] [RFC] pseudo_util: Change pseudo_diag() calls to appropriate logging macros
Date: Mon,  8 Jun 2026 15:44:50 +0300
Message-ID: <20260608124450.4020884-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Jun 2026 12:45:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4178

From: Dmitry Sakhonchik <frezidok1@gmail.com>

I've tried my best, but I am not completely sure what to consider "warning"
or "info" or "error". Some are very clear, some are don't.
I would appreciate if someone more familiar with the code point me out to
the right direction.

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

