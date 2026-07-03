Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D5C43458
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:31 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83540.1783039583547576645
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ13069650;
	Thu, 2 Jul 2026 19:46:20 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 04/23] pseudo_util: Change pseudo_diag() calls to appropriate logging macros
Date: Thu,  2 Jul 2026 19:45:59 -0500
Message-Id: <1783039578-31531-5-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4365

From: Dmitry Sakhonchik <frezidok1@gmail.com>

The patch is based on: [pseudo] pseudo: Add new logging macros
and implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
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
-- 
2.53.0


