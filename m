Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821FBC4450D
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83543.1783039585493589540
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ15069650;
	Thu, 2 Jul 2026 19:46:21 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 06/23] pseudo_client: Change pseudo_diag() calls to appropriate macros
Date: Thu,  2 Jul 2026 19:46:01 -0500
Message-Id: <1783039578-31531-7-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4372

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_client.c | 96 ++++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 49 deletions(-)

diff --git a/pseudo_client.c b/pseudo_client.c
index 7041366..69e5cbc 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -166,7 +166,7 @@ build_passwd_paths(void)
 		/* allocation and/or return */
 		if (passwd_paths) {
 			if (np != npasswd_paths) {
-				pseudo_diag("internal error: path allocation was inconsistent.\n");
+				pseudo_error("internal error: path allocation was inconsistent.\n");
 			} else {
 				/* yes, we allocated one extra for a trailing
 				 * null pointer.
@@ -178,14 +178,14 @@ build_passwd_paths(void)
 			passwd_paths = malloc((np + 1) * sizeof(*passwd_paths));
 			npasswd_paths = np;
 			if (!passwd_paths) {
-				pseudo_diag("couldn't allocate storage for password paths.\n");
+				pseudo_error("couldn't allocate storage for password paths.\n");
 				exit(1);
 			}
 			np = 0;
 		}
 	} while (++pass < 2);
 	/* in theory the second pass already returned, but. */
-	pseudo_diag("should totally not have gotten here.\n");
+	pseudo_error("should totally not have gotten here.\n");
 
 	return;
 }
@@ -567,11 +567,11 @@ pseudo_init_client(void) {
 				}
 				pseudo_prefix_dir_fd = pseudo_fd(pseudo_prefix_dir_fd, MOVE_FD);
 			} else {
-				pseudo_diag("No prefix available to to find server.\n");
+				pseudo_error("No prefix available to to find server.\n");
 				exit(1);
 			}
 			if (pseudo_prefix_dir_fd == -1) {
-				pseudo_diag("Can't open prefix path '%s' for server: %s\n",
+				pseudo_error("Can't open prefix path '%s' for server: %s\n",
 					pseudo_path,
 					strerror(errno));
 				exit(1);
@@ -590,11 +590,11 @@ pseudo_init_client(void) {
 				}
 				pseudo_localstate_dir_fd = pseudo_fd(pseudo_localstate_dir_fd, MOVE_FD);
 			} else {
-				pseudo_diag("No local state directory available for server/file interactions.\n");
+				pseudo_error("No local state directory available for server/file interactions.\n");
 				exit(1);
 			}
 			if (pseudo_localstate_dir_fd == -1) {
-				pseudo_diag("Can't open local state path '%s': %s\n",
+				pseudo_error("Can't open local state path '%s': %s\n",
 					pseudo_path,
 					strerror(errno));
 				exit(1);
@@ -633,7 +633,7 @@ pseudo_init_client(void) {
 			if (pseudo_chroot) {
 				pseudo_chroot_len = strlen(pseudo_chroot);
 			} else {
-				pseudo_diag("Can't store chroot path '%s'\n", env);
+				pseudo_error("Can't store chroot path '%s'\n", env);
 			}
 		}
 		free(env);
@@ -662,7 +662,7 @@ pseudo_init_client(void) {
 static void
 pseudo_file_close(int *fd, FILE **fp) {
 	if (!fp || !fd) {
-		pseudo_diag("pseudo_file_close: needs valid pointers.\n");
+		pseudo_error("pseudo_file_close: needs valid pointers.\n");
 		return;
 	}
 	pseudo_antimagic();
@@ -698,7 +698,7 @@ pseudo_file_close(int *fd, FILE **fp) {
 static FILE *
 pseudo_file_open(char *name, int *fd, FILE **fp) {
 	if (!fp || !fd || !name) {
-		pseudo_diag("pseudo_file_open: needs valid pointers.\n");
+		pseudo_error("pseudo_file_open: needs valid pointers.\n");
 		return NULL;
 	}
 	pseudo_file_close(fd, fp);
@@ -734,7 +734,7 @@ pseudo_pwd_lck_open(void) {
 	if (!pseudo_pwd_lck_name) {
 		pseudo_pwd_lck_name = malloc(pseudo_path_max());
 		if (!pseudo_pwd_lck_name) {
-			pseudo_diag("couldn't allocate space for passwd lockfile path.\n");
+			pseudo_error("couldn't allocate space for passwd lockfile path.\n");
 			return -1;
 		}
 	}
@@ -815,7 +815,7 @@ pseudo_client_chroot(const char *path) {
 	pseudo_chroot_len = strlen(path);
 	pseudo_chroot = malloc(pseudo_chroot_len + 1);
 	if (!pseudo_chroot) {
-		pseudo_diag("Couldn't allocate chroot directory buffer.\n");
+		pseudo_error("Couldn't allocate chroot directory buffer.\n");
 		pseudo_chroot_len = 0;
 		errno = ENOMEM;
 		return -1;
@@ -834,7 +834,7 @@ pseudo_root_path(const char *func, int line, int dirfd, const char *path, int le
 	rc = base_path(dirfd, path, leave_last);
 	pseudo_magic();
 	if (!rc) {
-		pseudo_diag("couldn't allocate absolute path for '%s'.\n",
+		pseudo_error("couldn't allocate absolute path for '%s'.\n",
 			path ? path : "null");
 	}
 	pseudo_debug(PDBGF_CHROOT, "root_path [%s, %d]: '%s' from '%s'\n",
@@ -849,7 +849,7 @@ pseudo_client_getcwd(void) {
 	char *cwd;
 	cwd = malloc(pseudo_path_max());
 	if (!cwd) {
-		pseudo_diag("Can't allocate CWD buffer!\n");
+		pseudo_error("Can't allocate CWD buffer!\n");
 		return -1;
 	}
 	pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "getcwd: trying to find cwd.\n");
@@ -874,7 +874,7 @@ pseudo_client_getcwd(void) {
 		}
 		return 0;
 	} else {
-		pseudo_diag("Can't get CWD: %s\n", strerror(errno));
+		pseudo_error("Can't get CWD: %s\n", strerror(errno));
 		return -1;
 	}
 }
@@ -901,7 +901,7 @@ pseudo_client_path_set(int fd, const char *path, char ***patharray, int *len) {
 			*len, fd + 1);
 		(*patharray) = realloc((*patharray), (fd + 1) * sizeof(char *));
 		if (!*patharray) {
-			pseudo_diag("couldn't realloc fd path array to %ld entries\n", (fd + 1) * sizeof(char *));
+			pseudo_error("couldn't realloc fd path array to %ld entries\n", (fd + 1) * sizeof(char *));
 			exit(1);
 		}
 		for (i = *len; i < fd + 1; ++i)
@@ -1002,7 +1002,7 @@ client_spawn_server(void) {
 
 	if ((server_pid = pseudo_real_fork()) != 0) {
 		if (server_pid == -1) {
-			pseudo_diag("couldn't fork server: %s\n", strerror(errno));
+			pseudo_error("couldn't fork server: %s\n", strerror(errno));
 			return 1;
 		}
 		pseudo_evlog(PDBGF_CLIENT, "spawned new server, pid %d\n", server_pid);
@@ -1109,7 +1109,7 @@ client_spawn_server(void) {
 		pseudo_setupenv();
 		pseudo_dropenv();
 		pseudo_real_execv(argv[0], argv);
-		pseudo_diag("critical failure: exec of pseudo daemon failed: %s\n", strerror(errno));
+		pseudo_error("critical failure: exec of pseudo daemon failed: %s\n", strerror(errno));
 		exit(1);
 	}
 }
@@ -1187,7 +1187,7 @@ pseudo_fd(int fd, int how) {
 
 	/* Set close on exec, even if we didn't move it. */
 	if ((newfd >= 0) && (fcntl(newfd, F_SETFD, FD_CLOEXEC) < 0))
-		pseudo_diag("Can't set close on exec flag: %s\n",
+		pseudo_error("Can't set close on exec flag: %s\n",
 			strerror(errno));
 
 	return(newfd);
@@ -1208,7 +1208,7 @@ client_connect(void) {
 	pseudo_evlog(PDBGF_CLIENT, "creating socket %s.\n", sun.sun_path);
 	if (connect_fd == -1) {
 		char *e = strerror(errno);
-		pseudo_diag("Can't create socket: %s (%s)\n", sun.sun_path, e);
+		pseudo_error("Can't create socket: %s (%s)\n", sun.sun_path, e);
 		pseudo_evlog(PDBGF_CLIENT, "failed to create socket: %s\n", e);
 		return 1;
 	}
@@ -1216,14 +1216,14 @@ client_connect(void) {
 	pseudo_debug(PDBGF_CLIENT, "connecting socket...\n");
 	cwd_fd = open(".", O_RDONLY);
 	if (cwd_fd == -1) {
-		pseudo_diag("Couldn't stash directory before opening socket: %s",
+		pseudo_error("Couldn't stash directory before opening socket: %s",
 			strerror(errno));
 		close(connect_fd);
 		connect_fd = -1;
 		return 1;
 	}
 	if (fchdir(pseudo_localstate_dir_fd) == -1) {
-		pseudo_diag("Couldn't chdir to server directory [%d]: %s\n",
+		pseudo_error("Couldn't chdir to server directory [%d]: %s\n",
 			pseudo_localstate_dir_fd, strerror(errno));
 		close(connect_fd);
 		close(cwd_fd);
@@ -1236,7 +1236,7 @@ client_connect(void) {
 		pseudo_evlog(PDBGF_CLIENT, "connect failed: %s\n", e);
 		close(connect_fd);
 		if (fchdir(cwd_fd) == -1) {
-			pseudo_diag("return to previous directory failed: %s\n",
+			pseudo_error("return to previous directory failed: %s\n",
 				strerror(errno));
 		}
 		close(cwd_fd);
@@ -1244,7 +1244,7 @@ client_connect(void) {
 		return 1;
 	}
 	if (fchdir(cwd_fd) == -1) {
-		pseudo_diag("return to previous directory failed: %s\n",
+		pseudo_error("return to previous directory failed: %s\n",
 			strerror(errno));
 	}
 	close(cwd_fd);
@@ -1402,11 +1402,9 @@ pseudo_client_request(pseudo_msg_t *msg, size_t len, const char *path) {
 			}
 		}
 	}
-	pseudo_diag("pseudo: server connection persistently failed, aborting.\n");
+	pseudo_error("pseudo: server connection persistently failed, aborting.\n");
 	pseudo_evlog_dump();
-	pseudo_diag("event log dumped, aborting.\n");
-	abort();
-	pseudo_diag("aborted.\n");
+	pseudo_critical("event log dumped, aborting.\n");
 	return 0;
 }
 
@@ -1430,11 +1428,11 @@ pseudo_client_shutdown(int wait_on_socket) {
 			pseudo_prefix_dir_fd = pseudo_fd(pseudo_prefix_dir_fd, COPY_FD);
 			free(pseudo_path);
 		} else {
-			pseudo_diag("No prefix available to to find server.\n");
+			pseudo_error("No prefix available to to find server.\n");
 			exit(1);
 		}
 		if (pseudo_prefix_dir_fd == -1) {
-			pseudo_diag("Can't open prefix path (%s) for server. (%s)\n",
+			pseudo_error("Can't open prefix path (%s) for server. (%s)\n",
 				pseudo_prefix_path(NULL),
 				strerror(errno));
 			exit(1);
@@ -1454,11 +1452,11 @@ pseudo_client_shutdown(int wait_on_socket) {
 			pseudo_localstate_dir_fd = pseudo_fd(pseudo_localstate_dir_fd, COPY_FD);
 			free(pseudo_path);
 		} else {
-			pseudo_diag("No prefix available to to find server.\n");
+			pseudo_error("No prefix available to to find server.\n");
 			exit(1);
 		}
 		if (pseudo_localstate_dir_fd == -1) {
-			pseudo_diag("Can't open local state path (%s) for server. (%s)\n",
+			pseudo_error("Can't open local state path (%s) for server. (%s)\n",
 				pseudo_localstatedir_path(NULL),
 				strerror(errno));
 			exit(1);
@@ -1479,13 +1477,13 @@ pseudo_client_shutdown(int wait_on_socket) {
 	}
 	ack = pseudo_msg_receive(connect_fd);
 	if (!ack) {
-		pseudo_diag("server did not respond to shutdown query.\n");
+		pseudo_error("server did not respond to shutdown query.\n");
 		return 1;
 	}
 	if (ack->type != PSEUDO_MSG_ACK) {
-		pseudo_diag("Server refused shutdown.  Remaining client fds: %d\n", ack->fd);
-		pseudo_diag("Client pids: %s\n", ack->path);
-		pseudo_diag("Server will shut down after all clients exit.\n");
+		pseudo_info("Server refused shutdown.  Remaining client fds: %d\n", ack->fd);
+		pseudo_info("Client pids: %s\n", ack->path);
+		pseudo_info("Server will shut down after all clients exit.\n");
 	}
 	if (wait_on_socket) {
 		/* try to receive a message the server won't send;
@@ -1520,14 +1518,14 @@ base_path(int dirfd, const char *path, int leave_last) {
 			if (basepath) {
 				baselen = strlen(basepath);
 			} else {
-				pseudo_diag("got *at() syscall for unknown directory, fd %d\n", dirfd);
+				pseudo_error("got *at() syscall for unknown directory, fd %d\n", dirfd);
 			}
 		} else {
 			basepath = pseudo_cwd;
 			baselen = pseudo_cwd_len;
 		}
 		if (!basepath) {
-			pseudo_diag("unknown base path for fd %d, path %s\n", dirfd, path);
+			pseudo_error("unknown base path for fd %d, path %s\n", dirfd, path);
 			return 0;
 		}
 		/* if there's a chroot path, and it's the start of basepath,
@@ -1756,7 +1754,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 	if (op == OP_RENAME) {
 		va_list ap;
 		if (!path) {
-			pseudo_diag("rename (%s) without new path.\n",
+			pseudo_warning("rename (%s) without new path.\n",
 				path ? path : "<nil>");
 			pseudo_magic();
 			return 0;
@@ -1766,7 +1764,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 		va_end(ap);
 		/* last argument is the previous path of the file */
 		if (!path_extra_1) {
-			pseudo_diag("rename (%s) without old path.\n",
+			pseudo_warning("rename (%s) without old path.\n",
 				path ? path : "<nil>");
 			pseudo_magic();
 			return 0;
@@ -1835,7 +1833,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 			alloced_path = malloc(full_len);
 			alloced_len = full_len;
 			if (!alloced_path) {
-				pseudo_diag("Can't allocate space for paths for a rename operation.  Sorry.\n");
+				pseudo_error("Can't allocate space for paths for a rename operation.  Sorry.\n");
 				alloced_len = 0;
 				pseudo_magic();
 				return 0;
@@ -1859,7 +1857,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 				alloced_path = malloc(pathlen);
 				alloced_len = pathlen;
 				if (!alloced_path) {
-					pseudo_diag("Can't allocate space for paths for a rename operation.  Sorry.\n");
+					pseudo_error("Can't allocate space for paths for a rename operation.  Sorry.\n");
 					alloced_len = 0;
 					pseudo_magic();
 					return 0;
@@ -1965,7 +1963,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 			if (fd == connect_fd) {
 				connect_fd = pseudo_fd(connect_fd, COPY_FD);
 				if (connect_fd == -1) {
-					pseudo_diag("tried to close connection, couldn't dup: %s\n", strerror(errno));
+					pseudo_error("tried to close connection, couldn't dup: %s\n", strerror(errno));
 				}
 			} else if (fd == pseudo_util_debug_fd) {
 				pseudo_util_debug_fd = pseudo_fd(fd, COPY_FD);
@@ -2037,7 +2035,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 		do_request = 1;
 		break;
 	default:
-		pseudo_diag("error: unknown or unimplemented operator %d (%s)", op, pseudo_op_name(op));
+		pseudo_error("unknown or unimplemented operator %d (%s)", op, pseudo_op_name(op));
 		break;
 	}
 	/* result can only be set when PSEUDO_XATTRDB resulted in a
@@ -2069,7 +2067,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 			pseudo_debug(PDBGF_OP, "(%d) %s", getpid(), pseudo_res_name(result->result));
 			if (result->result == RESULT_ABORT) {
 				char *local_state_dir = pseudo_get_value("PSEUDO_LOCALSTATEDIR");
-				pseudo_diag("abort()ing pseudo client by server request. See https://wiki.yoctoproject.org/wiki/Pseudo_Abort for more details on this.\n"
+				pseudo_info("abort()ing pseudo client by server request. See https://wiki.yoctoproject.org/wiki/Pseudo_Abort for more details on this.\n"
 					"Check logfile: %s/%s\n", local_state_dir, PSEUDO_LOGFILE);
 				abort();
 			}
@@ -2149,13 +2147,13 @@ populate_path_segs(void) {
 	}
 	path_segs = malloc((c+2) * sizeof(*path_segs));
 	if (!path_segs) {
-		pseudo_diag("warning: failed to allocate space for %d path segments.\n",
+		pseudo_warning("failed to allocate space for %d path segments.\n",
 			c);
 		return;
 	}
 	path_lens = malloc((c + 2) * sizeof(*path_lens));
 	if (!path_lens) {
-		pseudo_diag("warning: failed to allocate space for %d path lengths.\n",
+		pseudo_warning("failed to allocate space for %d path lengths.\n",
 			c);
 		free(path_segs);
 		path_segs = 0;
@@ -2163,7 +2161,7 @@ populate_path_segs(void) {
 	}
 	previous_path_segs = strdup(previous_path);
 	if (!previous_path_segs) {
-		pseudo_diag("warning: failed to allocate space for path copy.\n");
+		pseudo_warning("failed to allocate space for path copy.\n");
 		free(path_segs);
 		path_segs = NULL;
 		free(path_lens);
@@ -2242,7 +2240,7 @@ pseudo_exec_path(const char *filename, int search_path) {
 				candidate = pseudo_fix_path(dir, filename, 0, len, NULL, 0);
 				pseudo_debug(PDBGF_CLIENT, "exec_path: got %s for non-absolute path\n", candidate);
 			} else {
-				pseudo_diag("couldn't allocate intermediate path.\n");
+				pseudo_error("couldn't allocate intermediate path.\n");
 				candidate = NULL;
 			}
 		}
-- 
2.53.0


