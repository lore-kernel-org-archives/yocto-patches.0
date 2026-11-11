Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2484.1794370867469091959
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3m22428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:06 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 16/34] pseudo_server: Always use epoll
Date: Tue, 10 Nov 2026 22:20:44 -0600
Message-Id: <1794370862-30908-17-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5275
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

The server had two main loops: a select() based loop, used by default,
and an epoll loop, used with --enable-epoll.  Every change to client
handling had to be made in both, and select() can't handle descriptors
numbered 1024 or higher, which a server with many clients can reach.

Now that Linux is the only port, always use the epoll loop, as
pseudo_server_loop(), and remove the select() loop and the
PSEUDO_EPOLL conditionals.  pseudo_server.c fails with #error for a
port other than Linux.

configure accepts --enable-epoll for compatibility and ignores it, and
fails with an error if epoll is disabled.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 Makefile.in     |   3 +-
 configure       |  18 +----
 pseudo_server.c | 231 ++++----------------------------------------------------
 3 files changed, 17 insertions(+), 235 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index e875864..84e3ee8 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -14,7 +14,6 @@ SQLITE=@SQLITE@
 SQLITE_LIB=@SQLITE_LIB@
 SQLITE_MEMORY=@SQLITE_MEMORY@
 FORCE_ASYNC=@FORCE_ASYNC@
-EPOLL=@EPOLL@
 XATTR=@XATTR@
 XATTRDB=@XATTRDB@
 PROFILING=@PROFILING@
@@ -45,7 +44,7 @@ LOCALSTATEDIR=$(PREFIX)/$(LOCALSTATE)
 
 CFLAGS_BASE=-pipe -std=gnu99 -Wall -W -Wextra -Wno-deprecated-declarations
 CFLAGS_CODE=-fPIC -D_LARGEFILE64_SOURCE -D_ATFILE_SOURCE $(ARCH_FLAGS)
-CFLAGS_DEFS=-DPSEUDO_PREFIX='"$(PREFIX)"' -DPSEUDO_SUFFIX='"$(SUFFIX)"' -DPSEUDO_BINDIR='"$(BIN)"' -DPSEUDO_LIBDIR='"$(LIB)"' -DPSEUDO_LOCALSTATEDIR='"$(LOCALSTATE)"' -DPSEUDO_VERSION='"$(VERSION)"' $(SQLITE_MEMORY) $(FORCE_ASYNC) -DPSEUDO_PASSWD_FALLBACK='$(PASSWD_FALLBACK)' $(OPTDEFS) $(EPOLL)
+CFLAGS_DEFS=-DPSEUDO_PREFIX='"$(PREFIX)"' -DPSEUDO_SUFFIX='"$(SUFFIX)"' -DPSEUDO_BINDIR='"$(BIN)"' -DPSEUDO_LIBDIR='"$(LIB)"' -DPSEUDO_LOCALSTATEDIR='"$(LOCALSTATE)"' -DPSEUDO_VERSION='"$(VERSION)"' $(SQLITE_MEMORY) $(FORCE_ASYNC) -DPSEUDO_PASSWD_FALLBACK='$(PASSWD_FALLBACK)' $(OPTDEFS)
 CFLAGS_DEBUG=-O2 -g
 @DEFAULT_SQLITE@CFLAGS_SQL=-L$(SQLITE)/$(SQLITE_LIB) -I$(SQLITE)/include $(RPATH)
 CFLAGS_PSEUDO=$(CFLAGS_BASE) $(CFLAGS_CODE) $(CFLAGS_DEFS) \
diff --git a/configure b/configure
index b43809e..315bcd0 100755
--- a/configure
+++ b/configure
@@ -15,7 +15,6 @@ opt_arch=x86
 opt_bits=
 opt_sqlite=/usr
 opt_rpath=
-opt_epoll=
 opt_memory=
 opt_async=
 opt_xattr=
@@ -35,7 +34,6 @@ usage()
     echo >&2 "           [--suffix=...]"
     echo >&2 "           [--target=...]"
     echo >&2 "           [--enable-memory-db]"
-    echo >&2 "           [--enable-epoll]"
     echo >&2 "           [--enable-xattr]"
     echo >&2 "           [--enable-xattrdb]"
     echo >&2 "           [--enable-profiling]"
@@ -110,10 +108,11 @@ do
         opt_profiling=true
 	;;
     --enable-epoll=no)
-        opt_epoll=false
+        echo >&2 "Error: disabling epoll is no longer supported: the pseudo server always uses epoll."
+        exit 1
         ;;
     --enable-epoll=yes | --enable-epoll)
-        opt_epoll=true
+        # epoll is always used; accepted for compatibility
 	;;
     --enable-xattr=no)
         opt_xattr=false
@@ -261,10 +260,6 @@ if [ -z "$opt_async" ]; then
     opt_async=false
 fi
 
-if [ -z "$opt_epoll" ]; then
-    opt_epoll=false
-fi
-
 if $opt_async; then
     FORCE_ASYNC="-DPSEUDO_FORCE_ASYNC"
 else
@@ -293,12 +288,6 @@ if [ -z "$opt_xattr" ]; then
     fi
 fi
 
-if $opt_epoll; then
-    EPOLL="-DPSEUDO_EPOLL"
-else
-    EPOLL=""
-fi
-
 if $opt_xattr || $opt_xattrdb; then
     if ! $xattr_runs; then
         echo >&2 "WARNING: getfattr doesn't work, but xattr-related features requested."
@@ -339,7 +328,6 @@ touch func_deps.mk
 rm -f Makefile
 sed -e '
   s,@PREFIX@,'"$opt_prefix"',g
-  s,@EPOLL@,'"$EPOLL"',g
   s,@XATTR@,'"$opt_xattr"',g
   s,@XATTRDB@,'"$opt_xattrdb"',g
   s,@PROFILING@,'"$opt_profiling"',g
diff --git a/pseudo_server.c b/pseudo_server.c
index 77d1c39..c54c0d2 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -15,16 +15,12 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
-#include <sys/select.h>
 #include <sys/time.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
-#ifdef PSEUDO_EPOLL
-#include <sys/epoll.h>
-#endif
 #include <signal.h>
 
 #include "pseudo.h"
@@ -33,6 +29,11 @@
 #include "pseudo_client.h"
 #include "pseudo_db.h"
 
+#if !PSEUDO_PORT_LINUX
+#error "pseudo: the server uses epoll(7), which is only implemented for Linux"
+#endif
+#include <sys/epoll.h>
+
 static int listen_fd = -1;
 
 typedef struct {
@@ -80,11 +81,7 @@ set_do_list_clients(int sig) {
 static int messages = 0, responses = 0;
 static struct timeval message_time = { .tv_sec = 0 };
 
-#ifdef PSEUDO_EPOLL
-static void pseudo_server_loop_epoll(void);
-#else
 static void pseudo_server_loop(void);
-#endif
 
 /* helper function to make a directory, just like mkdir -p.
  * Can't use system() because the child shell would end up trying
@@ -369,11 +366,7 @@ pseudo_server_start(int daemonize) {
 			kill(ppid, SIGUSR1);
 		}
 	}
-#ifdef PSEUDO_EPOLL
-	pseudo_server_loop_epoll();
-#else
 	pseudo_server_loop();
-#endif
 	return 0;
 }
 
@@ -589,8 +582,8 @@ serve_client(int i) {
 		}
 		free(response_path);
 	} else {
-		/* this should not be happening, but the exceptions aren't
-		 * being detected in select() for some reason.
+		/* this should not be happening, as the server loop
+		 * closes clients with nothing to read.
 		 */
 		pseudo_debug(PDBGF_SERVER, "client %d: no message\n", (int) clients[i].pid);
 		close_client(i);
@@ -612,9 +605,12 @@ serve_client(int i) {
 	return rc;
 }
 
-#ifdef PSEUDO_EPOLL
-static void pseudo_server_loop_epoll(void)
-{
+/* get clients, handle messages, shut down.
+ * This doesn't actually do any work, it just calls a ton of things which
+ * do work.
+ */
+static void
+pseudo_server_loop(void) {
 	struct sockaddr_un client;
 	socklen_t len;
 	int i;
@@ -803,204 +799,3 @@ static void pseudo_server_loop_epoll(void)
 	}
 
 }
-#else
-
-/* get clients, handle messages, shut down.
- * This doesn't actually do any work, it just calls a ton of things which
- * do work.
- */
-static void
-pseudo_server_loop(void) {
-	struct sockaddr_un client;
-	socklen_t len;
-	fd_set reads, writes, events;
-	int max_fd, current_clients;
-	struct timeval timeout;
-	int i;
-	int rc;
-	int fd;
-	int loop_timeout = pseudo_server_timeout;
-	struct sigaction eat_usr2 = {
-		.sa_handler = set_do_list_clients
-	};
-	int hitmaxfiles;
-
-	clients = malloc(16 * sizeof(*clients));
-	if (!clients) {
-		pseudo_error("out of memory allocating client table.\n");
-		exit(PSEUDO_EXIT_LISTEN_FD);
-	}
-
-	sigaction(SIGUSR2, &eat_usr2, NULL);
-
-	clients[0].fd = listen_fd;
-	clients[0].pid = getpid();
-
-	for (i = 1; i < 16; ++i) {
-		clients[i].fd = -1;
-		clients[i].pid = 0;
-		clients[i].tag = NULL;
-		clients[i].program = NULL;
-	}
-
-	active_clients = 1;
-	max_clients = 16;
-	highest_client = 0;
-	hitmaxfiles = 0;
-
-	pseudo_debug(PDBGF_SERVER, "server loop started.\n");
-	if (listen_fd < 0) {
-		pseudo_error("got into loop with no valid listen fd.\n");
-		exit(PSEUDO_EXIT_LISTEN_FD);
-	}
-	pdb_log_msg(SEVERITY_INFO, NULL, NULL, NULL, "server started (pid %d)", getpid());
-
-	FD_ZERO(&reads);
-	FD_ZERO(&events);
-	FD_ZERO(&writes);
-	FD_SET(clients[0].fd, &reads);
-	FD_SET(clients[0].fd, &events);
-	max_fd = clients[0].fd;
-	timeout = (struct timeval) { .tv_sec = LOOP_DELAY, .tv_usec = 0 };
-	
-	/* EINTR tends to come from profiling, so it is not a good reason to
-	 * exit; other signals are caught and set the flag causing a graceful
-	 * exit. */
-	sigset_t maskusr2;
-	sigemptyset(&maskusr2);
-	sigaddset(&maskusr2, SIGUSR2);
-	sigprocmask(SIG_BLOCK, &maskusr2, NULL);
-	while ((rc = select(max_fd + 1, &reads, &writes, &events, &timeout)) >= 0 || (errno == EINTR)) {
-		sigprocmask(SIG_UNBLOCK, &maskusr2, NULL);
-		if (rc == 0 || (rc == -1 && errno == EINTR)) {
-			/* If there's no clients, start timing out.  If there
-			 * are active clients, never time out.
-			 */
-			if (active_clients == 1) {
-				loop_timeout -= LOOP_DELAY;
-				/* maybe flush database to disk */
-				pdb_maybe_backup();
-				if (loop_timeout <= 0) {
-					pseudo_debug(PDBGF_SERVER, "no more clients, got bored.\n");
-					die_peacefully = 1;
-				} else {
-					/* display this if not exiting */
-					pseudo_debug(PDBGF_SERVER | PDBGF_BENCHMARK, "%d messages handled in %.4f seconds, %d responses\n",
-						messages,
-						(double) message_time.tv_sec +
-						(double) message_time.tv_usec / 1000000.0,
-						responses);
-				}
-			}
-		} else if (rc > 0) {
-			loop_timeout = pseudo_server_timeout;
-			for (i = 1; i <= highest_client; ++i) {
-				if (clients[i].fd == -1) {
-					continue;
-				} else if (FD_ISSET(clients[i].fd, &reads)) {
-					int n = 0;
-					ioctl(clients[i].fd, FIONREAD, &n);
-					if (n == 0) {
-						close_client(i);
-					} else {
-						serve_client(i);
-					}
-				} else if (hitmaxfiles) {
-					/* Only close one per loop iteration in the interests of caution */
-					close_client(i);
-					hitmaxfiles = 0;
-				}
-				if (die_forcefully)
-					break;
-			}
-			hitmaxfiles = 0;
-			if (!die_forcefully && 
-			    (FD_ISSET(clients[0].fd, &events) ||
-			     FD_ISSET(clients[0].fd, &reads))) {
-				len = sizeof(client);
-				if ((fd = accept(listen_fd, (struct sockaddr *) &client, &len)) != -1) {
-					/* Don't allow clients to end up on fd 2, because glibc's
-					 * malloc debug uses that fd unconditionally.
-					 */
-					if (fd == 2) {
-						int newfd = fcntl(fd, F_DUPFD, 3);
-						close(fd);
-						fd = newfd;
-					}
-					pseudo_debug(PDBGF_SERVER, "new client fd %d\n", fd);
-					open_client(fd);
-					/* A new client implicitly cancels any
-					 * previous shutdown request, or a
-					 * shutdown for lack of clients.
-					 */
-					pseudo_server_timeout = DEFAULT_PSEUDO_SERVER_TIMEOUT;
-					die_peacefully = 0;
-				} else if (errno == EMFILE) {
-					hitmaxfiles = 1;
-					pseudo_debug(PDBGF_SERVER, "Hit max open files, dropping a client.\n");
-				}
-			}
-			pseudo_debug(PDBGF_SERVER, "server loop complete [%d clients left]\n", active_clients);
-		}
-		if (do_list_clients) {
-			do_list_clients = 0;
-			pseudo_info("listing clients [1 through %d]:\n", highest_client);
-			for (i = 1; i <= highest_client; ++i) {
-				if (clients[i].fd == -1) {
-					pseudo_info("client %4d: inactive.\n", i);
-					continue;
-				}
-				pseudo_info("client %4d: fd %4d, pid %5d, state %s, program %s\n",
-					i, clients[i].fd, clients[i].pid,
-					FD_ISSET(clients[i].fd, &reads) ? "R" : "-",
-					clients[i].program ? clients[i].program : "<unspecified>");
-			}
-			pseudo_info("done.\n");
-		}
-		if (die_peacefully || die_forcefully) {
-			pseudo_debug(PDBGF_SERVER, "quitting.\n");
-			pseudo_debug(PDBGF_SERVER | PDBGF_BENCHMARK, "server %d exiting: handled %d messages in %.4f seconds\n",
-				getpid(), messages,
-				(double) message_time.tv_sec +
-				(double) message_time.tv_usec / 1000000.0);
-			pdb_log_msg(SEVERITY_INFO, NULL, NULL, NULL, "server %d exiting: handled %d messages in %.4f seconds",
-				getpid(), messages,
-				(double) message_time.tv_sec +
-				(double) message_time.tv_usec / 1000000.0);
-			/* and at this point, we'll start refusing connections */
-			close(clients[0].fd);
-			/* This is a good place to insert a delay for
-			 * debugging race conditions during startup. */
-			/* usleep(300000); */
-			exit(0);
-		}
-		FD_ZERO(&reads);
-		FD_ZERO(&writes);
-		FD_ZERO(&events);
-		FD_SET(clients[0].fd, &reads);
-		FD_SET(clients[0].fd, &events);
-		max_fd = clients[0].fd;
-		/* current_clients is a sanity check; note that for
-		 * purposes of select(), the server is one of the fds,
-		 * and thus, "a client".
-		 */
-		current_clients = 1;
-		for (i = 1; i <= highest_client; ++i) {
-			if (clients[i].fd != -1) {
-				++current_clients;
-				FD_SET(clients[i].fd, &reads);
-				if (clients[i].fd > max_fd)
-					max_fd = clients[i].fd;
-			}
-		}
-		if (current_clients != active_clients) {
-			pseudo_debug(PDBGF_SERVER, "miscount of current clients (%d) against active_clients (%d)?\n",
-				current_clients, active_clients);
-		}
-		/* reinitialize timeout because Linux select alters it */
-		timeout = (struct timeval) { .tv_sec = LOOP_DELAY, .tv_usec = 0 };
-		sigprocmask(SIG_BLOCK, &maskusr2, NULL);
-	}
-	pseudo_error("select failed: %s\n", strerror(errno));
-}
-#endif /* this is the else of #ifdef PSEUDO_EPOLL */
-- 
1.8.3.1

