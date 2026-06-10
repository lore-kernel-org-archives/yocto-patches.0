Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B38CCD8CB9
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 11:47:06 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18366.1781092022232140710
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 04:47:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gmooO63j;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so12286826a12.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781092021; x=1781696821; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD8NZH+RLViO9p+BfgFN7spI7HIO6762HqFFIpPx1iI=;
        b=gmooO63jW/OqRg12TRr9Bq+EoKLu3MTBjrTKzUmOh8c+QJESyB7JSANQLEiO4cm6St
         39pO9hBJiH8kgSZZGt23J5jL7cddpw0YCAn+yMr2ixt5OPiu1EYajAsOlchWmSd86xRK
         k8A7SjY4EG7Su7QJN44iEtZ3hhgjPB0+QrYQZz1WOLbmlgysa41MFp+KtNYa+5ZFg6bL
         iEr3p0JMaInhz/B7PpmHC8j38FPHH3b2mAJcQgJbGZUKuw5Zz8JyT6Bl+73qdW8epD8T
         PJXwKv5px6nOt/Rtsn0SCbjSqrjvkTl8WVHTq4tnYhauTvgdKwWmE8DbXs7O+YJZIfmW
         itDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092021; x=1781696821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uD8NZH+RLViO9p+BfgFN7spI7HIO6762HqFFIpPx1iI=;
        b=K22ficaXiDcI+8/0ZlKj8J0lg3sBL4lZXmNKxoCUIFMaU76kEKViwC/JrCW960qcxn
         fOPe9MxZk8bCajybuB8pLp/Y0MXGJ+/zFtx8fZdxK+jF9XOD/ZR34tB0EorlOZ5batIx
         ZJIU6UnXlY84eMyGaU5jejg9NxW7z8D4/dtnit5IT9Do4mTgqo2ksYvl+eazWlv+7BPm
         KSHLhCNaqJVb8RcLhhzm4jicYbjSM8mZxtHzrq3HMnW33cjdKGPOdTMZ6qg8EZ2mdfNz
         MGyB0jP3p9EJRU0eBIZpm0d6sJuAQJZV2a0RU4P+iGWTC1bpk9QmbGF7b7ihcxxnCEZk
         hJVw==
X-Gm-Message-State: AOJu0YxyXMgBUFlSDuJhSJgRTADR0IGtSlQvR5Qupsp2qVwTvhsuZaVX
	27XLJ8n89yEhrl/Mg0DEHzIHw3eNps4mMh6TIVCK8fqLyv+8Ga4/ArIrL+Eb0sja
X-Gm-Gg: Acq92OGspKF2DrtytVZjtcjOLPjC0EKHR9Xl0CIqtz9YG+2bpge5IIz4w5CAb2xX+Xy
	0xEqvXQ6yPQyyDAb4FjLgiDlecpJV5ClTctDUntziiSjkN9AKjXEWHMEEyH8GrMLOngaomMFCkD
	TCIs/Qcd2FSnZOahZqm2NBG+HJZXsQXLwJ0gR3ep0OqqPM78JCGnc+HdN+WcCVN6Nk6Y5OG3wC5
	xINCkTNRm2VmwHxVQExlNZ47N9J6DkuLzp4dk62cBgm+cFCXrBUVOEUUoA4U62c+EJdwSmxH+i4
	4vGkXx8mug78PT00Wr88M64rvI2ma/Byop6T8Y2otOiQPD+lHJu9R7Y6/ReKZe5zPXHGooJ8Vdx
	qE+Zwrbe1+ltE85TkBGAKqRGIQPdeQZ0ejXyLw++tNUiOzG3P68+0j9gdPnaNNPVZyy+GehSrRb
	injxVXQesfQrNezVhp9IJvexpoUI3n
X-Received: by 2002:a05:6402:4494:b0:692:4759:ac57 with SMTP id 4fb4d7f45d1cf-6924759aff8mr3646412a12.2.1781092020318;
        Wed, 10 Jun 2026 04:47:00 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912faea64dsm5997164a12.19.2026.06.10.04.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:46:59 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH 4/8] pseudo_server: Change pseudo_diag() calls to appropriate macros
Date: Wed, 10 Jun 2026 14:46:06 +0300
Message-ID: <20260610114610.60776-4-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610114610.60776-1-frezidok1@gmail.com>
References: <20260610114610.60776-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:47:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4195

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 pseudo_server.c | 92 ++++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/pseudo_server.c b/pseudo_server.c
index edfbce1..c1a97c8 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -68,7 +68,7 @@ void pseudo_antimagic(void) { }
 
 void
 quit_now(int signal) {
-	pseudo_diag("Received signal %d, quitting.\n", signal);
+	pseudo_info("Received signal %d, quitting.\n", signal);
 	die_forcefully = 1;
 }
 
@@ -116,12 +116,12 @@ pseudo_server_write_pid(pid_t pid) {
 
 	pseudo_path = pseudo_localstatedir_path(PSEUDO_PIDFILE);
 	if (!pseudo_path) {
-		pseudo_diag("Couldn't get path for prefix/%s\n", PSEUDO_PIDFILE);
+		pseudo_error("Couldn't get path for prefix/%s\n", PSEUDO_PIDFILE);
 		return 1;
 	}
 	fp = fopen(pseudo_path, "w");
 	if (!fp) {
-		pseudo_diag("Couldn't open %s: %s\n",
+		pseudo_error("Couldn't open %s: %s\n",
 			pseudo_path, strerror(errno));
 		return 1;
 	}
@@ -171,7 +171,7 @@ pseudo_server_start(int daemonize) {
 		pseudo_debug_logfile(PSEUDO_LOGFILE, 2);
 		child = fork();
 		if (child == -1) {
-			pseudo_diag("Couldn't fork child process: %s\n",
+			pseudo_error("Couldn't fork child process: %s\n",
 				strerror(errno));
 			exit(PSEUDO_EXIT_FORK_FAILED);
 		}
@@ -204,18 +204,18 @@ pseudo_server_start(int daemonize) {
 				exit(0);
 			}
 			if (got_sigalrm) {
-				pseudo_diag("Child process timeout after %d seconds.\n",
+				pseudo_error("Child process timeout after %d seconds.\n",
 					PSEUDO_CHILD_PROCESS_TIMEOUT);
 				exit(PSEUDO_EXIT_TIMEOUT);
 			}
 			if (rc == -1) {
-				pseudo_diag("Failure in waitpid(): %s\n",
+				pseudo_error("Failure in waitpid(): %s\n",
 					strerror(save_errno));
 				exit(PSEUDO_EXIT_WAITPID);
 			}
 			if (WIFSIGNALED(status)) {
 				status = WTERMSIG(status);
-				pseudo_diag("Child process exited from signal %d.\n",
+				pseudo_error("Child process exited from signal %d.\n",
 					status);
 				kill(getpid(), status);
 				/* can't use +128 because that's not valid */
@@ -223,15 +223,15 @@ pseudo_server_start(int daemonize) {
 			}
 			if (WIFEXITED(status)) {
 				status = WEXITSTATUS(status);
-				pseudo_diag("Child process exit status %d: %s\n",
+				pseudo_error("Child process exit status %d: %s\n",
 					status,
 					pseudo_exit_status_name(status));
 				if (status == 0) {
-					pseudo_diag("Hang on, server should not have exited 0 without sending us sigusr1?\n");
+					pseudo_error("Hang on, server should not have exited 0 without sending us sigusr1?\n");
 				}
 				exit(status);
 			}
-			pseudo_diag("Unknown exit status %d.\n", status);
+			pseudo_error("Unknown exit status %d.\n", status);
 			exit(PSEUDO_EXIT_GENERAL);
 		} else {
 			/* detach from parent session */
@@ -245,24 +245,24 @@ pseudo_server_start(int daemonize) {
 		}
 	}
 
-	pseudo_diag("pid %d [parent %d], doing new pid setup and server start\n", getpid(), getppid());
+	pseudo_info("pid %d [parent %d], doing new pid setup and server start\n", getpid(), getppid());
 	pseudo_new_pid();
 
 	pseudo_debug(PDBGF_SERVER, "opening lock.\n");
 	lockpath = pseudo_localstatedir_path(NULL);
 	if (!lockpath) {
-		pseudo_diag("Couldn't allocate a file path.\n");
+		pseudo_error("Couldn't allocate a file path.\n");
 		exit(PSEUDO_EXIT_LOCK_PATH);
 	}
 	mkdir_p(lockpath);
 	lockname = pseudo_localstatedir_path(PSEUDO_LOCKFILE);
 	if (!lockname) {
-		pseudo_diag("Couldn't allocate a file path.\n");
+		pseudo_error("Couldn't allocate a file path.\n");
 		exit(PSEUDO_EXIT_LOCK_PATH);
 	}
 	lockfd = open(lockname, O_RDWR | O_CREAT, 0644);
 	if (lockfd < 0) {
-		pseudo_diag("Can't open or create lockfile %s: %s\n",
+		pseudo_error("Can't open or create lockfile %s: %s\n",
 			lockname, strerror(errno));
 		exit(PSEUDO_EXIT_LOCK_FAILED);
 	}
@@ -275,7 +275,7 @@ pseudo_server_start(int daemonize) {
 	if (lockfd <= 2) {
 		newfd = fcntl(lockfd, F_DUPFD, 3);
 		if (newfd < 0) {
-			pseudo_diag("Can't move lockfile to safe descriptor, leaving it on %d: %s\n",
+			pseudo_warning("Can't move lockfile to safe descriptor, leaving it on %d: %s\n",
 				lockfd, strerror(errno));
 		} else {
 			close(lockfd);
@@ -297,11 +297,11 @@ pseudo_server_start(int daemonize) {
 		if (save_errno == EACCES || save_errno == EAGAIN) {
 			rc = fcntl(lockfd, F_GETLK, &lock_data);
 			if (rc == 0 && lock_data.l_type != F_UNLCK) {
-				pseudo_diag("lock already held by existing pid %d.\n",
+				pseudo_warning("lock already held by existing pid %d.\n",
 					lock_data.l_pid);
 			}
 		}
-		pseudo_diag("Couldn't obtain lock: %s.\n", strerror(save_errno));
+		pseudo_error("Couldn't obtain lock: %s.\n", strerror(save_errno));
 		exit(PSEUDO_EXIT_LOCK_HELD);
 
 	} else {
@@ -314,14 +314,14 @@ pseudo_server_start(int daemonize) {
 
 	listen_fd = socket(PF_UNIX, SOCK_STREAM, 0);
 	if (listen_fd < 0) {
-		pseudo_diag("couldn't create listening socket: %s\n", strerror(errno));
+		pseudo_error("couldn't create listening socket: %s\n", strerror(errno));
 		exit(PSEUDO_EXIT_SOCKET_CREATE);
 	}
 
 	if (listen_fd <= 2) {
 		newfd = fcntl(listen_fd, F_DUPFD, 3);
 		if (newfd < 0) {
-			pseudo_diag("couldn't dup listening socket: %s\n", strerror(errno));
+			pseudo_error("couldn't dup listening socket: %s\n", strerror(errno));
 			close(listen_fd);
 			exit(PSEUDO_EXIT_SOCKET_FD);
 		} else {
@@ -333,7 +333,7 @@ pseudo_server_start(int daemonize) {
 	/* cd to the data directory */
 	pseudo_path = pseudo_localstatedir_path(NULL);
 	if (!pseudo_path || chdir(pseudo_path) == -1) {
-		pseudo_diag("can't get to '%s': %s\n",
+		pseudo_error("can't get to '%s': %s\n",
 			pseudo_path, strerror(errno));
 		exit(PSEUDO_EXIT_SOCKET_PATH);
 	}
@@ -341,21 +341,21 @@ pseudo_server_start(int daemonize) {
 	/* remove existing socket -- if it exists */
 	rc = unlink(sun.sun_path);
 	if (rc == -1 && errno != ENOENT) {
-		pseudo_diag("Can't unlink existing socket: %s.\n",
+		pseudo_error("Can't unlink existing socket: %s.\n",
 			strerror(errno));
 		exit(PSEUDO_EXIT_SOCKET_UNLINK);
 	}
 	if (bind(listen_fd, (struct sockaddr *) &sun, sizeof(sun)) == -1) {
-		pseudo_diag("couldn't bind listening socket: %s\n", strerror(errno));
+		pseudo_error("couldn't bind listening socket: %s\n", strerror(errno));
 		exit(PSEUDO_EXIT_SOCKET_BIND);
 	}
 	if (listen(listen_fd, 5) == -1) {
-		pseudo_diag("couldn't listen on socket: %s\n", strerror(errno));
+		pseudo_error("couldn't listen on socket: %s\n", strerror(errno));
 		exit(PSEUDO_EXIT_SOCKET_LISTEN);
 	}
 	rc = pseudo_server_write_pid(getpid());
 	if (rc != 0) {
-		pseudo_diag("warning: couldn't write pid file.\n");
+		pseudo_warning("couldn't write pid file.\n");
 	}
 	signal(SIGHUP, quit_now);
 	signal(SIGINT, quit_now);
@@ -366,9 +366,9 @@ pseudo_server_start(int daemonize) {
 	if (daemonize) {
 		pid_t ppid = getppid();
 		if (ppid == 1) {
-			pseudo_diag("Setup complete, but parent is init, not sending SIGUSR1.\n");
+			pseudo_info("Setup complete, but parent is init, not sending SIGUSR1.\n");
 		} else {
-			pseudo_diag("Setup complete, sending SIGUSR1 to pid %d.\n",
+			pseudo_info("Setup complete, sending SIGUSR1 to pid %d.\n",
 				ppid);
 			kill(ppid, SIGUSR1);
 		}
@@ -424,7 +424,7 @@ open_client(int fd) {
 		++active_clients;
 		return max_clients - 16;
 	} else {
-		pseudo_diag("error allocating new client, fd %d\n", fd);
+		pseudo_error("error allocating new client, fd %d\n", fd);
 		close(fd);
 		return 0;
 	}
@@ -439,7 +439,7 @@ close_client(int client) {
 		clients[client].pid, clients[client].fd);
 	/* client went away... */
 	if (client > highest_client || client <= 0) {
-		pseudo_diag("tried to close client %d (highest is %d)\n",
+		pseudo_info("tried to close client %d (highest is %d)\n",
 			client, highest_client);
 		return;
 	}
@@ -559,7 +559,7 @@ serve_client(int i) {
 
 				response_path = malloc(8 * active_clients);
 				if (!response_path) {
-					pseudo_diag("out of memory allocating shutdown response\n");
+					pseudo_error("out of memory allocating shutdown response\n");
 					exit(PSEUDO_EXIT_GENERAL);
 				} else {
 					memset(response_path, 0, 8 * active_clients);
@@ -633,7 +633,7 @@ static void pseudo_server_loop_epoll(void)
 
 	clients = malloc(16 * sizeof(*clients));
 	if (!clients) {
-		pseudo_diag("out of memory allocating client table.\n");
+		pseudo_error("out of memory allocating client table.\n");
 		exit(PSEUDO_EXIT_LISTEN_FD);
 	}
 
@@ -655,7 +655,7 @@ static void pseudo_server_loop_epoll(void)
 
 	pseudo_debug(PDBGF_SERVER, "server loop started.\n");
 	if (listen_fd < 0) {
-		pseudo_diag("got into loop with no valid listen fd.\n");
+		pseudo_error("got into loop with no valid listen fd.\n");
 		exit(PSEUDO_EXIT_LISTEN_FD);
 	}
 
@@ -663,13 +663,13 @@ static void pseudo_server_loop_epoll(void)
 
 	int epollfd = epoll_create1(0);
 	if (epollfd == -1) {
-		pseudo_diag("epoll_create1() failed.\n");
+		pseudo_error("epoll_create1() failed.\n");
 		exit(PSEUDO_EXIT_EPOLL_CREATE);
 	}
 	ev.events = EPOLLIN;
 	ev.data.u64 = 0;
 	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, clients[0].fd, &ev) == -1) {
-		pseudo_diag("epoll_ctl() failed with listening socket.\n");
+		pseudo_error("epoll_ctl() failed with listening socket.\n");
 		exit(PSEUDO_EXIT_EPOLL_CTL);
 	}
 
@@ -724,7 +724,7 @@ static void pseudo_server_loop_epoll(void)
 							ev.events = EPOLLIN;
 							ev.data.u64 = open_client(fd);
 							if (ev.data.u64 != 0 && epoll_ctl(epollfd, EPOLL_CTL_ADD, clients[ev.data.u64].fd, &ev) == -1) {
-								pseudo_diag("epoll_ctl() failed with accepted socket.\n");
+								pseudo_error("epoll_ctl() failed with accepted socket.\n");
 								exit(PSEUDO_EXIT_EPOLL_CTL);
 							}
 						} else if (errno == EMFILE) {
@@ -746,22 +746,22 @@ static void pseudo_server_loop_epoll(void)
 			}
 			pseudo_debug(PDBGF_SERVER, "server loop complete [%d clients left]\n", active_clients);
 		} else {
-			pseudo_diag("epoll_wait failed: %s\n", strerror(errno));
+			pseudo_error("epoll_wait failed: %s\n", strerror(errno));
 			break;
 		}
 		if (do_list_clients) {
 			do_list_clients = 0;
-			pseudo_diag("listing clients [1 through %d]:\n", highest_client);
+			pseudo_info("listing clients [1 through %d]:\n", highest_client);
 			for (i = 1; i <= highest_client; ++i) {
 				if (clients[i].fd == -1) {
-					pseudo_diag("client %4d: inactive.\n", i);
+					pseudo_info("client %4d: inactive.\n", i);
 					continue;
 				}
-				pseudo_diag("client %4d: fd %4d, pid %5d, program %s\n",
+				pseudo_info("client %4d: fd %4d, pid %5d, program %s\n",
 					i, clients[i].fd, clients[i].pid,
 					clients[i].program ? clients[i].program : "<unspecified>");
 			}
-			pseudo_diag("done.\n");
+			pseudo_info("done.\n");
 		}
 		if (die_peacefully || die_forcefully) {
 			pseudo_debug(PDBGF_SERVER, "quitting.\n");
@@ -807,7 +807,7 @@ pseudo_server_loop(void) {
 
 	clients = malloc(16 * sizeof(*clients));
 	if (!clients) {
-		pseudo_diag("out of memory allocating client table.\n");
+		pseudo_error("out of memory allocating client table.\n");
 		exit(PSEUDO_EXIT_LISTEN_FD);
 	}
 
@@ -830,7 +830,7 @@ pseudo_server_loop(void) {
 
 	pseudo_debug(PDBGF_SERVER, "server loop started.\n");
 	if (listen_fd < 0) {
-		pseudo_diag("got into loop with no valid listen fd.\n");
+		pseudo_error("got into loop with no valid listen fd.\n");
 		exit(PSEUDO_EXIT_LISTEN_FD);
 	}
 	pdb_log_msg(SEVERITY_INFO, NULL, NULL, NULL, "server started (pid %d)", getpid());
@@ -924,18 +924,18 @@ pseudo_server_loop(void) {
 		}
 		if (do_list_clients) {
 			do_list_clients = 0;
-			pseudo_diag("listing clients [1 through %d]:\n", highest_client);
+			pseudo_info("listing clients [1 through %d]:\n", highest_client);
 			for (i = 1; i <= highest_client; ++i) {
 				if (clients[i].fd == -1) {
-					pseudo_diag("client %4d: inactive.\n", i);
+					pseudo_info("client %4d: inactive.\n", i);
 					continue;
 				}
-				pseudo_diag("client %4d: fd %4d, pid %5d, state %s, program %s\n",
+				pseudo_info("client %4d: fd %4d, pid %5d, state %s, program %s\n",
 					i, clients[i].fd, clients[i].pid,
 					FD_ISSET(clients[i].fd, &reads) ? "R" : "-",
 					clients[i].program ? clients[i].program : "<unspecified>");
 			}
-			pseudo_diag("done.\n");
+			pseudo_info("done.\n");
 		}
 		if (die_peacefully || die_forcefully) {
 			pseudo_debug(PDBGF_SERVER, "quitting.\n");
@@ -981,6 +981,6 @@ pseudo_server_loop(void) {
 		timeout = (struct timeval) { .tv_sec = LOOP_DELAY, .tv_usec = 0 };
 		sigprocmask(SIG_BLOCK, &maskusr2, NULL);
 	}
-	pseudo_diag("select failed: %s\n", strerror(errno));
+	pseudo_error("select failed: %s\n", strerror(errno));
 }
 #endif /* this is the else of #ifdef PSEUDO_EPOLL */

