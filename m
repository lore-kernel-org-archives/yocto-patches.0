Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.242.1794500400611661548
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 08:20:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ACGJxKu2743931
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 10:20:00 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 2/6] pseudo_client: Connect to the server without changing directory
Date: Thu, 12 Nov 2026 10:19:54 -0600
Message-Id: <1794500398-31706-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 16:20:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5325
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

The socket paths can be too long for sun_path, so client_connect()
saved the working directory with open("."), changed to the state
directory, and changed back.  A Landlock sandbox that revokes
filesystem access, as xz sets up when working on a pipe, denies that
open(), so a process that sandboxes itself before its first pseudo
operation can never reach the server.  Name the directory as
/proc/self/fd/<fd>/ instead, which also stops connecting from moving
other threads' working directory.  Fall back to changing directory if
/proc is not mounted or the path doesn't fit in sun_path.

This makes test-landlock pass.  Both fallbacks were checked by hiding
/proc in a mount namespace and by forcing the length check to fail.

[YOCTO #16493]

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 pseudo_client.c | 77 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/pseudo_client.c b/pseudo_client.c
index 58e8810..fe111cf 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1253,8 +1253,31 @@ pseudo_client_path_matches_fd(const char *path, int fd, int nofollow) {
 static int
 client_connect(void) {
 	/* we have a server pid, is it responsive? */
-	struct sockaddr_un sun = { .sun_family = AF_UNIX, .sun_path = PSEUDO_SOCKET };
-	int cwd_fd;
+	struct sockaddr_un sun = { .sun_family = AF_UNIX };
+	struct stat st;
+	int cwd_fd = -1;
+	int use_chdir;
+	int len;
+
+	/* The full socket path can be too long for sun_path, so name the
+	 * state directory by its descriptor under /proc/self/fd.  Unlike
+	 * changing directory, that needs no open("."), which a Landlock
+	 * sandbox can deny, and doesn't move other threads' working
+	 * directory.  Without /proc, or if that path doesn't fit, change
+	 * directory as before.
+	 */
+	len = snprintf(sun.sun_path, sizeof(sun.sun_path), "/proc/self/fd/%d",
+		pseudo_localstate_dir_fd);
+	if (len > 0 && (size_t) len + 1 + strlen(PSEUDO_SOCKET) < sizeof(sun.sun_path) &&
+	    stat(sun.sun_path, &st) == 0 && S_ISDIR(st.st_mode)) {
+		snprintf(sun.sun_path + len, sizeof(sun.sun_path) - len, "/%s",
+			PSEUDO_SOCKET);
+		use_chdir = 0;
+	} else {
+		pseudo_debug(PDBGF_CLIENT, "/proc/self/fd unusable or path too long, changing directory to connect.\n");
+		snprintf(sun.sun_path, sizeof(sun.sun_path), "%s", PSEUDO_SOCKET);
+		use_chdir = 1;
+	}
 
 	connect_fd = socket(PF_UNIX, SOCK_STREAM, 0);
 	connect_fd = pseudo_fd(connect_fd, MOVE_FD);
@@ -1267,40 +1290,46 @@ client_connect(void) {
 	}
 
 	pseudo_debug(PDBGF_CLIENT, "connecting socket...\n");
-	cwd_fd = open(".", O_RDONLY);
-	if (cwd_fd == -1) {
-		pseudo_error("Couldn't stash directory before opening socket: %s",
-			strerror(errno));
-		close(connect_fd);
-		connect_fd = -1;
-		return 1;
-	}
-	if (fchdir(pseudo_localstate_dir_fd) == -1) {
-		pseudo_error("Couldn't chdir to server directory [%d]: %s\n",
-			pseudo_localstate_dir_fd, strerror(errno));
-		close(connect_fd);
-		close(cwd_fd);
-		connect_fd = -1;
-		return 1;
+	if (use_chdir) {
+		cwd_fd = open(".", O_RDONLY);
+		if (cwd_fd == -1) {
+			pseudo_error("Couldn't stash directory before opening socket: %s\n",
+				strerror(errno));
+			close(connect_fd);
+			connect_fd = -1;
+			return 1;
+		}
+		if (fchdir(pseudo_localstate_dir_fd) == -1) {
+			pseudo_error("Couldn't chdir to server directory [%d]: %s\n",
+				pseudo_localstate_dir_fd, strerror(errno));
+			close(connect_fd);
+			close(cwd_fd);
+			connect_fd = -1;
+			return 1;
+		}
 	}
 	if (connect(connect_fd, (struct sockaddr *) &sun, sizeof(sun)) == -1) {
 		char *e = strerror(errno);
 		pseudo_debug(PDBGF_CLIENT, "Can't connect socket to pseudo.socket: (%s)\n", e);
 		pseudo_evlog(PDBGF_CLIENT, "connect failed: %s\n", e);
 		close(connect_fd);
+		if (use_chdir) {
+			if (fchdir(cwd_fd) == -1) {
+				pseudo_error("return to previous directory failed: %s\n",
+					strerror(errno));
+			}
+			close(cwd_fd);
+		}
+		connect_fd = -1;
+		return 1;
+	}
+	if (use_chdir) {
 		if (fchdir(cwd_fd) == -1) {
 			pseudo_error("return to previous directory failed: %s\n",
 				strerror(errno));
 		}
 		close(cwd_fd);
-		connect_fd = -1;
-		return 1;
-	}
-	if (fchdir(cwd_fd) == -1) {
-		pseudo_error("return to previous directory failed: %s\n",
-			strerror(errno));
 	}
-	close(cwd_fd);
 	pseudo_evlog(PDBGF_CLIENT, "socket connect OK.\n");
 	pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "connected socket.\n");
 	return 0;
-- 
1.8.3.1

