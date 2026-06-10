Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09692CD8CB2
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 11:46:56 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18627.1781092013605110236
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 04:46:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lhMzKqfC;
 spf=pass (domain: gmail.com, ip: 209.85.208.46, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6912f4acca4so8841251a12.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781092012; x=1781696812; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMpahlxNluK3mG2+AuhkNJfiJLy4QPz8QwmwW9Gixyc=;
        b=lhMzKqfCw69ObmKV+4V1kc0PBtLc2xKUxnpwBjEjRMfUecucBnlFKUcFxll9/3Ns3Q
         kJ8akIxXy9iKwRryHOs65QNA2ybH+eTKn3ImwKm9fpFdnKy9xjZ09LmZthPIEXLi6yGj
         Mkf6I6JQmcYiXGsVgIQkXeG2G4eI+1/ijLoP62erk2v/uQxtJy/ICXRIl3lHs4ECfWFY
         8jiM2ntqcUjWHkCR0WIlkqj4Ay1JjL2r5L57qNWHlpasDRdbijV33KlupgoljboZj3DV
         lDh1IPVWLF7SFfJ92aOnji7YtH3WHdqQKEN5vv//qyKtruU+374PPX2mUQ4r/gBa74j5
         F4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092012; x=1781696812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CMpahlxNluK3mG2+AuhkNJfiJLy4QPz8QwmwW9Gixyc=;
        b=L6zjpf4DDH/4yuqXLADM9dv2swWsYkrj0k6JA+wApwxrV869/6sq+WUgARuuVEKDHd
         qT0QVi6LODATkY41PkLRveLRsFzPbsnZ3MzaToN6psOhMyAgF9DvBiQUUlIxVZoC6onk
         ZEVaJJMzoZ83UP3wjYPCaK159A4D8C2tuPDSNK0ZRCSEaBbGCYnYrdbCvsW2o3XXgHKR
         UKtZ9MGYyHGqVm86QOAYNpDHl+yqbmH4Eav3LKlOxVFFd8nP/ibSazMj2h1LoAgBy0wb
         9/QtFk7nbz6uhS8hhq/4x3XD+/QkJxkl/3D0Jcyes/b4Xx+Pj318PiQHokxcBJBVHfis
         eTFQ==
X-Gm-Message-State: AOJu0YzdfbygbjMhoLfPhQ5dicne7WycUFktNq2Ouv1RVzflFOLOfoy7
	igZ1NjhiitSKmTt37HfI79Ie0SGZZj0zUMpUYe3lx1DlZGV8HipqFjJsYIXooGBl
X-Gm-Gg: Acq92OGm/vPu1/x8aChgXiPFMjpc1c+y6E6SWp8bXKXqV6mDp2zF6CXmuG1MPygqXIJ
	/k5/oBXmPlemTMfO0wG3FvQJjKnveTksp/GpmfyuYIAtvuw+56V3K7xLgoPIJvN/IDHnVUZDCN9
	Crh7i/U5MglJemgczWJlnTDzog6cg/NDEybK2JkB69a+EMPpN0yGbdwU+NNwvS/WHHvo9CHecxq
	IMkMNOnw52FAQbMC64plZtdBp62ASU8RdsyIlpJrhn9o+beHPk2v3s0dqVUTeH0oWlHzURnHiZD
	LgqvY3+b3dFH4HUm9g/tZD9TRv2NEIthEZFuK5UGeRt+FojONvM//Q4LrIP3/t/N3pZliQipuUE
	zNA+2/P/8yVVEN2w9Ei5eg5PPqjSQMlR4ANFH4oBjoOT9zEjCnPrJQgyVUkf7jaOegudl0S8CkF
	fGqvx8pQR3DZsk8qQMO0Gx4OLC/Tfm
X-Received: by 2002:a05:6402:35d1:b0:68d:642b:3d4c with SMTP id 4fb4d7f45d1cf-68fa4d24321mr12683296a12.11.1781092011447;
        Wed, 10 Jun 2026 04:46:51 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912faea64dsm5997164a12.19.2026.06.10.04.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:46:50 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH 3/8] pseudo_client: Change pseudo_diag() calls to appropriate macros
Date: Wed, 10 Jun 2026 14:46:05 +0300
Message-ID: <20260610114610.60776-3-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610114610.60776-1-frezidok1@gmail.com>
References: <20260610114610.60776-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:46:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4194

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
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

