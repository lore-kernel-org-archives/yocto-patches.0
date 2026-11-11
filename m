Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2567.1794370864964304612
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3ln2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:04 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 03/34] ports: check created files under the path lock before recording them
Date: Tue, 10 Nov 2026 22:20:31 -0600
Message-Id: <1794370862-30908-4-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5263
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

open() and friends with O_CREAT create a file and then send OP_CREAT
for the path, so another client can rename onto or remove the name in
between, like the other wrappers that create names.  They can't hold
the path lock across the real call, as opening a FIFO can block
indefinitely, which could deadlock against a client waiting for the
lock.

Instead, take the lock after the file has been opened, and only send
OP_CREAT if the path still names the file that was opened, using a new
pseudo_client_path_matches_fd().  With the lock held no other client is
part way through changing the path, so if it now names a different
file, that client has already recorded the change and recording ours
would be wrong.

This covers openat (and so open, creat and their variants), openat2,
fopen, freopen, fopen64 and freopen64.  openat and openat2 now also take
the recorded stat data from the descriptor rather than from an earlier
lookup of the path.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/linux/guts/fopen64.c         |  5 ++++-
 ports/linux/guts/freopen64.c       |  5 ++++-
 ports/linux/guts/openat.c          |  8 +++++++-
 ports/linux/openat2/guts/openat2.c |  8 +++++++-
 ports/unix/guts/fopen.c            |  5 ++++-
 ports/unix/guts/freopen.c          |  5 ++++-
 pseudo_client.c                    | 25 +++++++++++++++++++++++++
 pseudo_client.h                    |  1 +
 8 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/ports/linux/guts/fopen64.c b/ports/linux/guts/fopen64.c
index e76da69..a6efd18 100644
--- a/ports/linux/guts/fopen64.c
+++ b/ports/linux/guts/fopen64.c
@@ -22,8 +22,11 @@
 		pseudo_debug(PDBGF_FILE, "fopen64 '%s': fd %d <FILE %p>\n", path, fd, (void *) rc);
 		if (real___fxstat64(_STAT_VER, fd, &buf) != -1) {
 			if (!existed) {
+				int path_lock_fd = pseudo_client_path_lock(0);
 				real_fchmod(fd, PSEUDO_FS_MODE(0666 & ~pseudo_umask, 0));
-				pseudo_client_op(OP_CREAT, 0, -1, -1, path, &buf);
+				if (pseudo_client_path_matches_fd(path, fd, 0))
+					pseudo_client_op(OP_CREAT, 0, -1, -1, path, &buf);
+				pseudo_client_path_unlock(path_lock_fd);
 			}
 			pseudo_client_op(OP_OPEN, pseudo_access_fopen(mode), fd, -1, path, &buf);
 		} else {
diff --git a/ports/linux/guts/freopen64.c b/ports/linux/guts/freopen64.c
index 5fc9073..6057eda 100644
--- a/ports/linux/guts/freopen64.c
+++ b/ports/linux/guts/freopen64.c
@@ -21,8 +21,11 @@
 		pseudo_debug(PDBGF_FILE, "freopen64 '%s': fd %d\n", path, fd);
 		if (real___fxstat64(_STAT_VER, fd, &buf) != -1) {
 			if (!existed) {
+				int path_lock_fd = pseudo_client_path_lock(0);
 				real_fchmod(fd, PSEUDO_FS_MODE(0666 & ~pseudo_umask, 0));
-				pseudo_client_op(OP_CREAT, 0, -1, -1, path, &buf);
+				if (pseudo_client_path_matches_fd(path, fd, 0))
+					pseudo_client_op(OP_CREAT, 0, -1, -1, path, &buf);
+				pseudo_client_path_unlock(path_lock_fd);
 			}
 			pseudo_client_op(OP_OPEN, pseudo_access_fopen(mode), fd, -1, path, &buf);
 		} else {
diff --git a/ports/linux/guts/openat.c b/ports/linux/guts/openat.c
index 0a44063..4fd83dd 100644
--- a/ports/linux/guts/openat.c
+++ b/ports/linux/guts/openat.c
@@ -147,9 +147,15 @@
 		if (stat_rc != -1) {
 			buf.st_mode = PSEUDO_DB_MODE(buf.st_mode, mode);
 			if (!existed) {
+				int path_lock_fd = pseudo_client_path_lock(0);
 				real_fchmod(rc, PSEUDO_FS_MODE(mode, 0));
 				// file has no path, but has been created
-				pseudo_client_op(OP_CREAT, 0, -1, dirfd, path, &buf);
+				if (pseudo_client_path_matches_fd(path, rc, flags & O_NOFOLLOW) &&
+				    real___fxstat64(_STAT_VER, rc, &buf) != -1) {
+					buf.st_mode = PSEUDO_DB_MODE(buf.st_mode, mode);
+					pseudo_client_op(OP_CREAT, 0, -1, dirfd, path, &buf);
+				}
+				pseudo_client_path_unlock(path_lock_fd);
 			}
 				pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(flags), rc, dirfd, path, &buf);
 		} else {
diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/guts/openat2.c
index f1c523e..06fcec8 100644
--- a/ports/linux/openat2/guts/openat2.c
+++ b/ports/linux/openat2/guts/openat2.c
@@ -182,9 +182,15 @@
 		if (stat_rc != -1) {
 			buf.st_mode = PSEUDO_DB_MODE(buf.st_mode, my_how.mode);
 			if (!existed) {
+				int path_lock_fd = pseudo_client_path_lock(0);
 				real_fchmod(rc, PSEUDO_FS_MODE(my_how.mode, 0));
 				// file has no path, but has been created
-				pseudo_client_op(OP_CREAT, 0, -1, dirfd, pseudo_path, &buf);
+				if (pseudo_client_path_matches_fd(pseudo_path, rc, my_how.flags & O_NOFOLLOW) &&
+				    real___fxstat64(_STAT_VER, rc, &buf) != -1) {
+					buf.st_mode = PSEUDO_DB_MODE(buf.st_mode, my_how.mode);
+					pseudo_client_op(OP_CREAT, 0, -1, dirfd, pseudo_path, &buf);
+				}
+				pseudo_client_path_unlock(path_lock_fd);
 			}
 				pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, pseudo_path, &buf);
 		} else {
diff --git a/ports/unix/guts/fopen.c b/ports/unix/guts/fopen.c
index 26a6abc..78388f7 100644
--- a/ports/unix/guts/fopen.c
+++ b/ports/unix/guts/fopen.c
@@ -21,8 +21,11 @@
 		pseudo_debug(PDBGF_OP, "fopen '%s': fd %d <FILE %p>\n", path, fd, (void *) rc);
 		if (base_fstat(fd, &buf) != -1) {
 			if (!existed) {
+				int path_lock_fd = pseudo_client_path_lock(0);
 				real_fchmod(fd, PSEUDO_FS_MODE(0666 & ~pseudo_umask, 0));
-				pseudo_client_op(OP_CREAT, 0, -1, -1, path, &buf);
+				if (pseudo_client_path_matches_fd(path, fd, 0))
+					pseudo_client_op(OP_CREAT, 0, -1, -1, path, &buf);
+				pseudo_client_path_unlock(path_lock_fd);
 			}
 			pseudo_client_op(OP_OPEN, pseudo_access_fopen(mode), fd, -1, path, &buf);
 		} else {
diff --git a/ports/unix/guts/freopen.c b/ports/unix/guts/freopen.c
index 703b6aa..5d63c9f 100644
--- a/ports/unix/guts/freopen.c
+++ b/ports/unix/guts/freopen.c
@@ -21,8 +21,11 @@
 		pseudo_debug(PDBGF_OP, "freopen '%s': fd %d\n", path, fd);
 		if (base_fstat(fd, &buf) != -1) {
 			if (!existed) {
+				int path_lock_fd = pseudo_client_path_lock(0);
 				real_fchmod(fd, PSEUDO_FS_MODE(0666 & ~pseudo_umask, 0));
-				pseudo_client_op(OP_CREAT, 0, -1, -1, path, &buf);
+				if (pseudo_client_path_matches_fd(path, fd, 0))
+					pseudo_client_op(OP_CREAT, 0, -1, -1, path, &buf);
+				pseudo_client_path_unlock(path_lock_fd);
 			}
 			pseudo_client_op(OP_OPEN, pseudo_access_fopen(mode), fd, -1, path, &buf);
 		} else {
diff --git a/pseudo_client.c b/pseudo_client.c
index ffd3450..a3d461e 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1225,6 +1225,31 @@ pseudo_client_path_unlock(int fd) {
 	errno = save_errno;
 }
 
+/* Operations that can block, such as open() on a FIFO, can't hold the path
+ * lock across the real call.  Instead they take the lock afterwards and
+ * check that the path still names the file they opened before recording
+ * it.  With the lock held, no other client is part way through changing the
+ * path, so if it now names a different file, that client has already
+ * recorded the change, and recording ours would be wrong.
+ */
+int
+pseudo_client_path_matches_fd(const char *path, int fd, int nofollow) {
+	PSEUDO_STATBUF pbuf, fbuf;
+	int save_errno = errno;
+	int rc;
+
+	if (!path || fd < 0 || !pseudo_real_fstat || !pseudo_real_lstat || !pseudo_real_stat)
+		return 1;
+	rc = pseudo_real_fstat(fd, &fbuf) == 0 &&
+	     (nofollow ? pseudo_real_lstat(path, &pbuf) : pseudo_real_stat(path, &pbuf)) == 0 &&
+	     pbuf.st_dev == fbuf.st_dev && pbuf.st_ino == fbuf.st_ino;
+	if (!rc)
+		pseudo_debug(PDBGF_FILE, "'%s' no longer names fd %d, not recording it.\n",
+			path, fd);
+	errno = save_errno;
+	return rc;
+}
+
 static int
 client_connect(void) {
 	/* we have a server pid, is it responsive? */
diff --git a/pseudo_client.h b/pseudo_client.h
index 3958f6d..716c441 100644
--- a/pseudo_client.h
+++ b/pseudo_client.h
@@ -29,6 +29,7 @@ extern int pseudo_client_shutdown(int);
 extern int pseudo_fd(int fd, int how);
 extern int pseudo_client_path_lock(int shared);
 extern void pseudo_client_path_unlock(int fd);
+extern int pseudo_client_path_matches_fd(const char *path, int fd, int nofollow);
 #define MOVE_FD	0
 #define COPY_FD	1
 #define PSEUDO_MIN_FD	20
-- 
1.8.3.1

