Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB70F5A8B1
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 18:30:41 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.212.1776709833130689080
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 11:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63KIUUPv3563308;
	Mon, 20 Apr 2026 13:30:31 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Subject: [PATCH 2/5] makewrappers/openat2: Add preserve_path option
Date: Mon, 20 Apr 2026 13:30:26 -0500
Message-Id: <1776709829-2754-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1776709829-2754-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1776709829-2754-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 18:30:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3744

From: Richard Purdie <richard.purdie@linuxfoundation.org>

openat2 needs the relative path preserved as a call argument, we can't pass
in the absolute path pseudo converts to. The difference in behaviour is
clear in this example:

openat2(AT_FDCWD, "/tmp/testdir/dir1/dir2/", {flags=O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH|O_DIRECTORY, resolve=RESOLVE_BENEATH}, 24) = -1 EXDEV (Invalid cross-device link)

vs.

openat2(AT_FDCWD, "dir1/dir2/", {flags=O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH|O_DIRECTORY, resolve=RESOLVE_BENEATH}, 24) = 4

Add a makewrappers option to preserve paths to the underlying function
call and use it for openat2.

This code attempts to handle a chroot for absolute paths but if the path
is relative, chroot behaviour would be tricky.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 makewrappers                       | 18 ++++++++++++++-
 ports/linux/openat2/guts/openat2.c | 46 +++++++++++++++++++++++++-------------
 ports/linux/openat2/wrapfuncs.in   |  2 +-
 templates/wrapfuncs.c              |  1 +
 4 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/makewrappers b/makewrappers
index 326f70e..df405fc 100755
--- a/makewrappers
+++ b/makewrappers
@@ -248,6 +248,11 @@ class Function:
         self.date = datetime.date.today().year
         # Used to define pointers that should EFAULT if null
         self.efault = None
+
+        # Used for functions which need to called with the original unconverted paths, e.g. openat2
+        # In those cases, use a suffix ('_int') for the path variable names instead of
+        # overwriting them. This means the wrapper needs to handle paths itself.
+        self.preserve_paths = False
     
         function, comments = line.split(';')
         comment = re.search(r'/\* *(.*) *\*/', comments)
@@ -383,6 +388,11 @@ class Function:
         """present argument list for a function call"""
         return self.args.call()
 
+    def paths_decl(self):
+        if self.preserve_paths:
+            return "\n\t".join("char *" + path + "_int;" for path in self.paths_to_munge)
+        return ""
+
     def fix_paths(self):
         """create/allocate canonical paths"""
         fix_paths = []
@@ -390,6 +400,9 @@ class Function:
             prefix = path[:-4]
             if prefix not in self.specific_dirfds:
                 prefix = ''
+            pathvar = path
+            if self.preserve_paths:
+                pathvar = path + "_int"
             if self.dirfd != "AT_FDCWD" and "flags" in self.flags \
                     and "AT_SYMLINK_NOFOLLOW" in self.flags:
                 fix_paths.append(
@@ -409,7 +422,7 @@ class Function:
                     "\t\t}\n" % (path, self.rc_assign()))
             fix_paths.append(
                 "%s = pseudo_root_path(__func__, __LINE__, %s%s, %s, %s);" %
-                (path, prefix, self.dirfd, path, self.flags))
+                (pathvar, prefix, self.dirfd, path, self.flags))
         return "\n\t\t".join(fix_paths)
 
     def ignore_paths(self):
@@ -424,6 +437,9 @@ class Function:
         elif "path" in self.paths_to_munge:
             mainpath = "path"
 
+        if mainpath and self.preserve_paths:
+            mainpath += "_int"
+
         if mainpath:
             return "pseudo_client_ignore_path(%s)" % mainpath
         if self.fd_arg:
diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/guts/openat2.c
index 946a4e4..a0acbe7 100644
--- a/ports/linux/openat2/guts/openat2.c
+++ b/ports/linux/openat2/guts/openat2.c
@@ -14,6 +14,7 @@
 	int save_errno;
 	sigset_t local_saved_sigmask;
 	struct open_how my_how;
+	char *pseudo_path;
 
 	/* Validate parameters */
 	if (!how || size < sizeof(struct open_how)) {
@@ -25,6 +26,19 @@
 		return -1;
 	}
 
+	/* This wrapper is not called with modified paths, therefore we have to handle this ourselves.
+	   We can't use the standard mappings since the function needs relative paths to be preserved,
+	   they can't be our usual absolute paths. An example difference:
+	   openat2(AT_FDCWD, "/tmp/testdir/dir1/dir2/", {flags=O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH|O_DIRECTORY, resolve=RESOLVE_BENEATH}, 24) = -1 EXDEV (Invalid cross-device link)
+	   vs.
+           openat2(AT_FDCWD, "dir1/dir2/", {flags=O_RDONLY|O_NOFOLLOW|O_CLOEXEC|O_PATH|O_DIRECTORY, resolve=RESOLVE_BENEATH}, 24) = 4
+           FIXME - we don't handle chroot for relative paths
+	*/
+        pseudo_path = pseudo_root_path(__func__, __LINE__, dirfd, path, 0);
+	if (path && path[0] == '/')
+		/* If the path is absolute, we should account for a potential chroot */
+	        path = pseudo_path;
+
 	memcpy(&my_how, how, size);
 
 	/* mask out mode bits appropriately */
@@ -69,16 +83,16 @@
 		save_errno = errno;
 #ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
 		if (my_how.flags & O_NOFOLLOW) {
-			rc = real___lxstat64(_STAT_VER, path, &buf);
+			rc = real___lxstat64(_STAT_VER, pseudo_path, &buf);
 		} else {
-			rc = real___xstat64(_STAT_VER, path, &buf);
+			rc = real___xstat64(_STAT_VER, pseudo_path, &buf);
 		}
 #else
-		rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 #endif
 		existed = (rc != -1);
 		if (!existed)
-			pseudo_debug(PDBGF_FILE, "openat2_creat: %s -> 0%lld\n", path, my_how.mode);
+			pseudo_debug(PDBGF_FILE, "openat2_creat: %s -> 0%lld\n", pseudo_path, my_how.mode);
 		errno = save_errno;
 	}
 
@@ -90,12 +104,12 @@
 		save_errno = errno;
 #ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
 		if (my_how.flags & O_NOFOLLOW) {
-			rc = real___lxstat64(_STAT_VER, path, &buf);
+			rc = real___lxstat64(_STAT_VER, pseudo_path, &buf);
 		} else {
-			rc = real___xstat64(_STAT_VER, path, &buf);
+			rc = real___xstat64(_STAT_VER, pseudo_path, &buf);
 		}
 #else
-		rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 #endif
 		if (rc != -1 && S_ISFIFO(buf.st_mode)) {
 			overly_magic_nonblocking = 1;
@@ -134,7 +148,7 @@
 		 */
 		if (pseudo_getlock()) {
 			pseudo_diag("PANIC: after opening a readonly/writeonly FIFO (path '%s', fd %d, errno %d, saved errno %d), could not regain lock. unrecoverable. sorry. bye.\n",
-				path, rc, errno, save_errno);
+				pseudo_path, rc, errno, save_errno);
 			abort();
 		}
 		errno = save_errno;
@@ -156,28 +170,28 @@
 #endif
 #ifdef PSEUDO_NO_REAL_AT_FUNCTIONS
 		if (my_how.flags & O_NOFOLLOW) {
-			stat_rc = real___lxstat64(_STAT_VER, path, &buf);
+			stat_rc = real___lxstat64(_STAT_VER, pseudo_path, &buf);
 		} else {
-			stat_rc = real___xstat64(_STAT_VER, path, &buf);
+			stat_rc = real___xstat64(_STAT_VER, pseudo_path, &buf);
 		}
 #else
-		stat_rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+		stat_rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (my_how.flags & O_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
 #endif
 
 		pseudo_debug(PDBGF_FILE, "openat2(path %s), flags %lld, stat rc %d, stat mode %o\n",
-			path, my_how.flags, stat_rc, buf.st_mode);
+			pseudo_path, my_how.flags, stat_rc, buf.st_mode);
 		if (stat_rc != -1) {
 			buf.st_mode = PSEUDO_DB_MODE(buf.st_mode, my_how.mode);
 			if (!existed) {
 				real_fchmod(rc, PSEUDO_FS_MODE(my_how.mode, 0));
 				// file has no path, but has been created
-				pseudo_client_op(OP_CREAT, 0, -1, dirfd, path, &buf);
+				pseudo_client_op(OP_CREAT, 0, -1, dirfd, pseudo_path, &buf);
 			}
-				pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, path, &buf);
+				pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, pseudo_path, &buf);
 		} else {
 			pseudo_debug(PDBGF_FILE, "openat2 (fd %d, path %d/%s, flags %lld) succeeded, but stat failed (%s).\n",
-				rc, dirfd, path, my_how.flags, strerror(errno));
-			pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, path, 0);
+				rc, dirfd, pseudo_path, my_how.flags, strerror(errno));
+			pseudo_client_op(OP_OPEN, PSEUDO_ACCESS(my_how.flags), rc, dirfd, pseudo_path, 0);
 		}
 		errno = save_errno;
 	}
diff --git a/ports/linux/openat2/wrapfuncs.in b/ports/linux/openat2/wrapfuncs.in
index 2f1e716..2995646 100644
--- a/ports/linux/openat2/wrapfuncs.in
+++ b/ports/linux/openat2/wrapfuncs.in
@@ -1 +1 @@
-int openat2(int dirfd, const char *path, const struct open_how *how, size_t size);
+int openat2(int dirfd, const char *path, const struct open_how *how, size_t size); /* preserve_paths=1 */
diff --git a/templates/wrapfuncs.c b/templates/wrapfuncs.c
index e925b6e..9385a40 100644
--- a/templates/wrapfuncs.c
+++ b/templates/wrapfuncs.c
@@ -22,6 +22,7 @@ ${name}(${decl_args}) {
 	sigset_t saved;
 	${variadic_decl}
 	${rc_decl}
+	${paths_decl}
 	PROFILE_START;
 
 ${maybe_async_skip}
-- 
1.8.3.1


