Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D10C44510
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 18:41:12 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.99267.1783104061354698919
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jul 2026 11:41:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 663Ieua6237103;
	Fri, 3 Jul 2026 13:40:58 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH v2 07/23] pseudo_server: Change pseudo_diag() calls to appropriate macros
Date: Fri,  3 Jul 2026 13:40:39 -0500
Message-Id: <1783104055-19005-8-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783104055-19005-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 18:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4404

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_server.c | 92 ++++++++++++++++++++++++++++-----------------------------
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
-- 
1.8.3.1


