Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2494.1794370872149445854
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3mC2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:08 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 26/34] pseudo_util: Write the event log to PSEUDO_EVLOG_FILE
Date: Tue, 10 Nov 2026 22:20:54 -0600
Message-Id: <1794370862-30908-27-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5292
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

PSEUDO_EVLOG_FILE was in the environment table, but
pseudo_evlog_logfile() was never called, so the event log was always
dumped to standard error, which may be the output of whatever program
was running.  Call it when the client sets up its debug log file.

pseudo_logfile() also stored the descriptor it opened as the debug log
descriptor, which would have redirected debug output to the event log
file. When a program closes the descriptor used by either log, move
both logs that use it to a copy, as both are standard error by default.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 doc/program_flow  | 4 ++--
 pseudo.h          | 1 +
 pseudo_client.c   | 9 +++++++--
 pseudo_util.c     | 1 -
 pseudo_wrappers.c | 3 ++-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/doc/program_flow b/doc/program_flow
index e987e4a..f7eb26c 100644
--- a/doc/program_flow
+++ b/doc/program_flow
@@ -9,10 +9,10 @@ libpseudo execution flow:
 	pseudo_wrappers.c: (constructor) _libpseudo_init()
 		pseudo_util.c: pseudo_init_util()
 			copy environment
-			setup PSEUDO_DEBUG levels
+			setup PSEUDO_DEBUG, PSEUDO_EVLOG and PSEUDO_SEVERITY flags
 		pseudo_wrappers.c: pseudo_init_wrappers()
 			setup pseudo_functions
-			setup pseudo_logfile
+			setup log files (PSEUDO_DEBUG_FILE, PSEUDO_EVLOG_FILE)
 		pseudo_client.c: pseudo_init_client()
 			setup PSEUDO_DISABLED
 			setup pseudo_localstate_dir_fd
diff --git a/pseudo.h b/pseudo.h
index 13249bf..6a7339b 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -100,6 +100,7 @@ extern char *pseudo_get_bindir(void);
 extern char *pseudo_get_libdir(void);
 extern char *pseudo_get_localstatedir(void);
 extern int pseudo_debug_logfile(char *defname, int prefer_fd);
+extern int pseudo_evlog_logfile(char *defname, int prefer_fd);
 extern ssize_t pseudo_sys_path_max(void);
 extern ssize_t pseudo_path_max(void);
 #define PSEUDO_PWD_MAX 4096
diff --git a/pseudo_client.c b/pseudo_client.c
index bbe0829..58e8810 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -2152,8 +2152,13 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 				if (connect_fd == -1) {
 					pseudo_error("tried to close connection, couldn't dup: %s\n", strerror(errno));
 				}
-			} else if (fd == pseudo_util_debug_fd) {
-				pseudo_util_debug_fd = pseudo_fd(fd, COPY_FD);
+			} else if (fd == pseudo_util_debug_fd || fd == pseudo_util_evlog_fd) {
+				/* both are stderr by default */
+				int newfd = pseudo_fd(fd, COPY_FD);
+				if (fd == pseudo_util_debug_fd)
+					pseudo_util_debug_fd = newfd;
+				if (fd == pseudo_util_evlog_fd)
+					pseudo_util_evlog_fd = newfd;
 			} else if (fd == pseudo_localstate_dir_fd) {
 				pseudo_localstate_dir_fd = pseudo_fd(fd, COPY_FD);
 			} else if (fd == pseudo_pathlock_fd) {
diff --git a/pseudo_util.c b/pseudo_util.c
index e0d7306..1e29ba5 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1738,7 +1738,6 @@ pseudo_logfile(char *filename, char *defname, int prefer_fd) {
 				fd = newfd;
 			}
 		}
-		pseudo_util_debug_fd = fd;
 	}
 	free(pseudo_path);
 	return fd;
diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index d073b1e..a4e9015 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -183,9 +183,10 @@ pseudo_init_wrappers(void) {
 	pseudo_real_execv = dlsym(RTLD_NEXT, "execv");
 
 	/* Once the wrappers are setup, we can now use open... so
-	 * setup the logfile, if necessary...
+	 * setup the logfiles, if necessary...
 	 */
 	pseudo_debug_logfile(NULL, -1);
+	pseudo_evlog_logfile(NULL, -1);
 
 	pseudo_magic();
 	pseudo_droplock();
-- 
1.8.3.1

