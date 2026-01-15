Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21118D44C47
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.847.1768520625144321119
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjn2408772;
	Thu, 15 Jan 2026 17:43:42 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 18/20] pseudo: code quality scan - resolved various potential issues
Date: Thu, 15 Jan 2026 17:43:34 -0600
Message-Id: <1768520616-7289-19-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2994

From: Mark Hatle <mark.hatle@amd.com>

Memory Management Issues:
* Unchecked malloc/realloc calls in multiple files that could lead to
  NULL pointer dereferences or memory leaks
* Missing error handling for strdup() calls returning NULL

AI-Generated: Issues identified by GitHub Copilot (Claude Sonnet 4.5)

The actual code changes however are my own, AI only identified potential
issues.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/unix/guts/fts_open.c          |  5 ++-
 ports/unix/guts/nftw_wrapper_base.c | 11 ++---
 pseudo.c                            | 61 ++++++++++++++++-----------
 pseudo_client.c                     |  4 ++
 pseudo_db.c                         | 10 +++++
 pseudo_server.c                     | 14 +++++++
 pseudo_util.c                       | 64 +++++++++++++++++++----------
 7 files changed, 117 insertions(+), 52 deletions(-)

diff --git a/ports/unix/guts/fts_open.c b/ports/unix/guts/fts_open.c
index e5b27ba..ccc9322 100644
--- a/ports/unix/guts/fts_open.c
+++ b/ports/unix/guts/fts_open.c
@@ -31,8 +31,11 @@
 		rpath_argv[i] = PSEUDO_ROOT_PATH(AT_FDCWD, path_argv[i], AT_SYMLINK_NOFOLLOW);
 		if (!rpath_argv[i])
 			errored = 1;
-		else
+		else {
 			rpath_argv[i] = strdup(rpath_argv[i]);
+			if (!rpath_argv[i])
+				errored = 1;
+		}
 	}
 
 	if (errored) {
diff --git a/ports/unix/guts/nftw_wrapper_base.c b/ports/unix/guts/nftw_wrapper_base.c
index 76a2ba6..000fa18 100644
--- a/ports/unix/guts/nftw_wrapper_base.c
+++ b/ports/unix/guts/nftw_wrapper_base.c
@@ -38,7 +38,8 @@ static pthread_mutex_t NFTW_MUTEX_NAME = PTHREAD_MUTEX_INITIALIZER;
 
 static void NFTW_APPEND_FN_NAME(struct NFTW_STORAGE_STRUCT_NAME *data_to_append){
     NFTW_STORAGE_ARRAY_NAME = realloc(NFTW_STORAGE_ARRAY_NAME, ++NFTW_STORAGE_ARRAY_SIZE * sizeof(*data_to_append));
-    memcpy(&NFTW_STORAGE_ARRAY_NAME[NFTW_STORAGE_ARRAY_SIZE - 1], data_to_append, sizeof(*data_to_append));
+    if (NFTW_STORAGE_ARRAY_NAME)
+        memcpy(&NFTW_STORAGE_ARRAY_NAME[NFTW_STORAGE_ARRAY_SIZE - 1], data_to_append, sizeof(*data_to_append));
 }
 
 int NFTW_FIND_FN_NAME(struct NFTW_STORAGE_STRUCT_NAME* target) {
@@ -46,7 +47,7 @@ int NFTW_FIND_FN_NAME(struct NFTW_STORAGE_STRUCT_NAME* target) {
 
     // return the last one, not the first
     for (ssize_t i = NFTW_STORAGE_ARRAY_SIZE - 1; i >= 0; --i){
-        if (NFTW_STORAGE_ARRAY_NAME[i].tid == tid){
+        if ((NFTW_STORAGE_ARRAY_NAME) && (NFTW_STORAGE_ARRAY_NAME[i].tid == tid)){
             // need to dereference it, as next time this array
             // may be realloc'd, making the original pointer
             // invalid
@@ -62,7 +63,7 @@ static void NFTW_DELETE_FN_NAME() {
     pthread_t tid = pthread_self();
 
     if (NFTW_STORAGE_ARRAY_SIZE == 1) {
-        if (NFTW_STORAGE_ARRAY_NAME[0].tid == tid) {
+        if ((NFTW_STORAGE_ARRAY_NAME) && (NFTW_STORAGE_ARRAY_NAME[0].tid == tid)) {
             free(NFTW_STORAGE_ARRAY_NAME);
             NFTW_STORAGE_ARRAY_NAME = NULL;
             --NFTW_STORAGE_ARRAY_SIZE;
@@ -73,7 +74,7 @@ static void NFTW_DELETE_FN_NAME() {
     }
 
     int found_idx = -1;
-    for (ssize_t i = NFTW_STORAGE_ARRAY_SIZE - 1; i >= 0; --i) {
+    for (ssize_t i = NFTW_STORAGE_ARRAY_SIZE - 1; (NFTW_STORAGE_ARRAY_NAME) && i >= 0; --i) {
         if (NFTW_STORAGE_ARRAY_NAME[i].tid == tid) {
             found_idx = i;
             break;
@@ -86,7 +87,7 @@ static void NFTW_DELETE_FN_NAME() {
     }
 
     // delete the item we just found
-    for (size_t i = found_idx + 1; i < NFTW_STORAGE_ARRAY_SIZE; ++i)
+    for (size_t i = found_idx + 1; (NFTW_STORAGE_ARRAY_NAME) && i < NFTW_STORAGE_ARRAY_SIZE; ++i)
         NFTW_STORAGE_ARRAY_NAME[i - 1] = NFTW_STORAGE_ARRAY_NAME[i];
 
     NFTW_STORAGE_ARRAY_NAME = realloc(NFTW_STORAGE_ARRAY_NAME, --NFTW_STORAGE_ARRAY_SIZE * sizeof(struct NFTW_STORAGE_STRUCT_NAME));
diff --git a/pseudo.c b/pseudo.c
index 132d24a..25711b6 100644
--- a/pseudo.c
+++ b/pseudo.c
@@ -373,8 +373,11 @@ main(int argc, char *argv[]) {
 			while (*path) {
 				struct stat buf;
 				int len = strcspn(path, ":");
-				snprintf(fullpath, pseudo_path_max(), "%.*s/%s",
-					len, path, argv[0]);
+				if ( snprintf(fullpath, pseudo_path_max(), "%.*s/%s",
+					len, path, argv[0]) > (int) pseudo_path_max()) {
+					pseudo_diag("pseudo: path too long.\n");
+					exit(EXIT_FAILURE);
+				}
 				path += len;
 				if (*path == ':')
 					++path;
@@ -394,27 +397,33 @@ main(int argc, char *argv[]) {
 		pseudo_setupenv();
 
 		rc = fork();
-		if (rc) {
-			waitpid(rc, &rc, 0);
-			/* try to hint that we don't think we still need
-			 * the server.
-			 */
-                        if (opt_S) {
-				pseudo_client_shutdown(1);
-                        }
-			if (WIFEXITED(rc)) {
-				return WEXITSTATUS(rc);
-			} else if (WIFSIGNALED(rc)) {
-				kill(getpid(), WTERMSIG(rc));
-				exit(1);
-			} else {
-				exit(1);
-			}
+		if (rc == -1) {
+			pseudo_diag("pseudo: fork failed: %s\n",
+				strerror(errno));
+			exit(EXIT_FAILURE);
 		} else {
-			rc = execv(fullpath, argv);
-			if (rc == -1) {
-				pseudo_diag("pseudo: can't run %s: %s\n",
-					argv[0], strerror(errno));
+			if (rc) {
+				waitpid(rc, &rc, 0);
+				/* try to hint that we don't think we still need
+				 * the server.
+				 */
+				if (opt_S) {
+					pseudo_client_shutdown(1);
+				}
+				if (WIFEXITED(rc)) {
+					return WEXITSTATUS(rc);
+				} else if (WIFSIGNALED(rc)) {
+					kill(getpid(), WTERMSIG(rc));
+					exit(1);
+				} else {
+					exit(1);
+				}
+			} else {
+				rc = execv(fullpath, argv);
+				if (rc == -1) {
+					pseudo_diag("pseudo: can't run %s: %s\n",
+						argv[0], strerror(errno));
+				}
 			}
 			exit(EXIT_FAILURE);
 		}
@@ -482,15 +491,19 @@ pseudo_op(pseudo_msg_t *msg, const char *program, const char *tag, char **respon
 			/* for rename, the path name would be null-terminated,
 			 * but for *xattr, we don't want the null. */
 			oldpathlen = msg->pathlen - (oldpath - msg->path) - 1;
-			pseudo_debug(PDBGF_OP | PDBGF_FILE | PDBGF_XATTR, "%s: path '%s', oldpath '%s' [%d/%d]\n",
-				pseudo_op_name(msg->op), msg->path, oldpath, (int) oldpathlen, (int) msg->pathlen);
+
 			/* For a rename op, we want to strip any trailing
 			 * slashes. For xattr, "oldpath" is the raw data
 			 * to be stored. */
 			if (oldpathlen > 0 && msg->op == OP_RENAME) {
+				pseudo_debug(PDBGF_OP | PDBGF_FILE | PDBGF_XATTR, "%s: path '%s', oldpath '%s' [%d/%d]\n",
+					pseudo_op_name(msg->op), msg->path, oldpath, (int) oldpathlen, (int) msg->pathlen);
 				if (oldpath[oldpathlen - 1] == '/') {
 					oldpath[--oldpathlen] = '\0';
 				}
+			} else {
+				pseudo_debug(PDBGF_OP | PDBGF_FILE | PDBGF_XATTR, "%s: path '%s', xattr data len %d [%d]\n",
+					pseudo_op_name(msg->op), msg->path, (int) oldpathlen, (int) msg->pathlen);
 			}
 			/* if we got an oldpath, but a 0-length initial
 			 * path, we don't want to act as though we had
diff --git a/pseudo_client.c b/pseudo_client.c
index 8a07341..7041366 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -900,6 +900,10 @@ pseudo_client_path_set(int fd, const char *path, char ***patharray, int *len) {
 		pseudo_debug(PDBGF_CLIENT, "expanding fds from %d to %d\n",
 			*len, fd + 1);
 		(*patharray) = realloc((*patharray), (fd + 1) * sizeof(char *));
+		if (!*patharray) {
+			pseudo_diag("couldn't realloc fd path array to %ld entries\n", (fd + 1) * sizeof(char *));
+			exit(1);
+		}
 		for (i = *len; i < fd + 1; ++i)
 			(*patharray)[i] = 0;
 		*len = fd + 1;
diff --git a/pseudo_db.c b/pseudo_db.c
index 8b23938..009ea2f 100644
--- a/pseudo_db.c
+++ b/pseudo_db.c
@@ -2165,6 +2165,10 @@ pdb_update_inode(pseudo_msg_t *msg) {
 
 	if (!oldmsg) {
 		oldmsg = malloc(sizeof(*msg) + pseudo_path_max());
+		if (!oldmsg) {
+			pseudo_diag("%s: out of memory\n", __func__);
+			return 1;
+		}
 	}
 
 	char *sql = "UPDATE files "
@@ -2516,6 +2520,12 @@ pdb_get_xattr(pseudo_msg_t *msg, char **value, size_t *len) {
 			 * arbitrary bytes.
 			 */
 			*value = malloc(length);
+			if (!*value) {
+				pseudo_diag("%s: out of memory\n", __func__);
+				sqlite3_reset(select);
+				sqlite3_clear_bindings(select);
+				return 1;
+			}
 			memcpy(*value, response, length);
 			*len = length;
 			rc = 0;
diff --git a/pseudo_server.c b/pseudo_server.c
index 815c76b..edfbce1 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -558,6 +558,12 @@ serve_client(int i) {
 				char *s;
 
 				response_path = malloc(8 * active_clients);
+				if (!response_path) {
+					pseudo_diag("out of memory allocating shutdown response\n");
+					exit(PSEUDO_EXIT_GENERAL);
+				} else {
+					memset(response_path, 0, 8 * active_clients);
+				}
 				in->type = PSEUDO_MSG_NAK;
 				in->fd = active_clients - 2;
 				s = response_path;
@@ -626,6 +632,10 @@ static void pseudo_server_loop_epoll(void)
 	};
 
 	clients = malloc(16 * sizeof(*clients));
+	if (!clients) {
+		pseudo_diag("out of memory allocating client table.\n");
+		exit(PSEUDO_EXIT_LISTEN_FD);
+	}
 
 	sigaction(SIGUSR2, &eat_usr2, NULL);
 
@@ -796,6 +806,10 @@ pseudo_server_loop(void) {
 	int hitmaxfiles;
 
 	clients = malloc(16 * sizeof(*clients));
+	if (!clients) {
+		pseudo_diag("out of memory allocating client table.\n");
+		exit(PSEUDO_EXIT_LISTEN_FD);
+	}
 
 	sigaction(SIGUSR2, &eat_usr2, NULL);
 
diff --git a/pseudo_util.c b/pseudo_util.c
index d16b14c..671ab7f 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -340,7 +340,10 @@ without_libpseudo(char *list) {
 		return list;
 	}
 	list = strdup(list);
-	while (!(*real_regexec)(&libpseudo_regex, list, 1, pmatch, 0)) {
+	if (!list) {
+		pseudo_diag("Couldn't allocate memory to remove libpseudo from environment.\n");
+	}
+	while (list && !(*real_regexec)(&libpseudo_regex, list, 1, pmatch, 0)) {
 		char *start = list + pmatch[0].rm_so;
 		char *end = list + pmatch[0].rm_eo;
 		/* don't copy over the space or = */
@@ -895,6 +898,10 @@ pseudo_fix_path(const char *base, const char *path, size_t rootlen, size_t basel
 	}
 	if (!pathbufs[pathbuf]) {
 		pathbufs[pathbuf] = malloc(newpathlen);
+		if (!pathbufs[pathbuf]) {
+			pseudo_diag("allocation failed seeking memory for path (%s).\n", path);
+			return 0;
+		}
 	}
 	newpath = pathbufs[pathbuf];
 	pathbuf = (pathbuf + 1) % PATHBUFS;
@@ -1047,19 +1054,21 @@ pseudo_setupenv() {
 		char *newenv = malloc(len);
 		if (!newenv) {
 			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_PATH);
+		} else {
+		    snprintf(newenv, len, "%s:%s64", libdir_path, libdir_path);
+		    SETENV(PRELINK_PATH, newenv, 1);
+		    free(newenv);
 		}
-		snprintf(newenv, len, "%s:%s64", libdir_path, libdir_path);
-		SETENV(PRELINK_PATH, newenv, 1);
-		free(newenv);
 	} else if (!strstr(ld_library_path, libdir_path)) {
 		size_t len = strlen(ld_library_path) + 1 + strlen(libdir_path) + 1 + (strlen(libdir_path) + 2) + 1;
 		char *newenv = malloc(len);
 		if (!newenv) {
 			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_PATH);
+		} else {
+		    snprintf(newenv, len, "%s:%s:%s64", ld_library_path, libdir_path, libdir_path);
+		    SETENV(PRELINK_PATH, newenv, 1);
+		    free(newenv);
 		}
-		snprintf(newenv, len, "%s:%s:%s64", ld_library_path, libdir_path, libdir_path);
-		SETENV(PRELINK_PATH, newenv, 1);
-		free(newenv);
 	} else {
 		/* nothing to do, ld_library_path exists and contains
 		 * our preferred path */
@@ -1070,16 +1079,18 @@ pseudo_setupenv() {
 		ld_preload = with_libpseudo(ld_preload, libdir_path);
 		if (!ld_preload) {
 			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+		} else {
+		    SETENV(PRELINK_LIBRARIES, ld_preload, 1);
+		    free(ld_preload);
 		}
-		SETENV(PRELINK_LIBRARIES, ld_preload, 1);
-		free(ld_preload);
 	} else {
 		ld_preload = with_libpseudo("", libdir_path);
 		if (!ld_preload) {
 			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+		} else {
+		    SETENV(PRELINK_LIBRARIES, ld_preload, 1);
+		    free(ld_preload);
 		}
-		SETENV(PRELINK_LIBRARIES, ld_preload, 1);
-		free(ld_preload);
 	}
 
 	/* we kept libdir path until now because with_libpseudo might
@@ -1149,17 +1160,19 @@ pseudo_setupenvp(char * const *envp) {
 		char *newenv = malloc(len);
 		if (!newenv) {
 			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_PATH);
+		} else {
+		    snprintf(newenv, len, PRELINK_PATH "=%s:%s64", libdir_path, libdir_path);
+		    new_envp[j++] = newenv;
 		}
-		snprintf(newenv, len, PRELINK_PATH "=%s:%s64", libdir_path, libdir_path);
-		new_envp[j++] = newenv;
 	} else if (!strstr(ld_library_path, libdir_path)) {
 		size_t len = strlen(ld_library_path) + 1 + strlen(libdir_path) + 1 + (strlen(libdir_path) + 2) + 1;
 		char *newenv = malloc(len);
 		if (!newenv) {
 			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_PATH);
+		} else {
+		    snprintf(newenv, len, "%s:%s:%s64", ld_library_path, libdir_path, libdir_path);
+		    new_envp[j++] = newenv;
 		}
-		snprintf(newenv, len, "%s:%s:%s64", ld_library_path, libdir_path, libdir_path);
-		new_envp[j++] = newenv;
 	} else {
 		/* keep old value */
 		new_envp[j++] = ld_library_path;
@@ -1169,15 +1182,22 @@ pseudo_setupenvp(char * const *envp) {
 		ld_preload = with_libpseudo(ld_preload, libdir_path);
 		if (!ld_preload) {
 			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
-		}
-		new_envp[j++] = ld_preload;
+		} else
+			new_envp[j++] = ld_preload;
 	} else {
 		ld_preload = with_libpseudo("", libdir_path);
-		size_t len = strlen(PRELINK_LIBRARIES "=") + strlen(ld_preload) + 1;
-		char *newenv = malloc(len);
-		snprintf(newenv, len, PRELINK_LIBRARIES "=%s", ld_preload);
-		new_envp[j++] = newenv;
-		free(ld_preload);
+		if (!ld_preload) {
+			pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+		} else {
+			size_t len = strlen(PRELINK_LIBRARIES "=") + strlen(ld_preload) + 1;
+			char *newenv = malloc(len);
+			if (!newenv) {
+				pseudo_diag("fatal: can't allocate new %s variable.\n", PRELINK_LIBRARIES);
+			}
+			snprintf(newenv, len, PRELINK_LIBRARIES "=%s", ld_preload);
+			new_envp[j++] = newenv;
+			free(ld_preload);
+		}
 	}
 
 	free(libdir_path);
-- 
2.43.0


