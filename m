Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93030C3ABB0
	for <webhook@archiver.kernel.org>; Sat,  3 May 2025 20:02:03 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web11.17579.1746302522581255012
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 03 May 2025 13:02:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 543JxuJw008895;
	Sat, 3 May 2025 14:59:57 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: skandigraun@gmail.com, landervanloock@gmail.com,
        richard.purdie@linuxfoundation.org, fntoth@gmail.com
Subject: [pseudo][PATCH v3 2/3] nftw, nftw64: add wrapper
Date: Sat,  3 May 2025 14:59:54 -0500
Message-Id: <1746302395-8723-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746302395-8723-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1746302395-8723-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 03 May 2025 20:02:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1484

From: "Gyorgy Sarvari via lists.yoctoproject.org" <skandigraun=gmail.com@lists.yoctoproject.org>

Add a wrapper for nftw and ftw[1] calls (along with nftw64 and ftw64).

The call in brief: it accepts a path, which it walks. For every
entries it finds, it calls a user-specified callback function, and
passes some information about the entry to this callback.

The implementation saves the callback from the nftw call, and subtitutes
it with its own "fake_callback". When the real nftw calls the fake_callback,
it corrects the stat struct it received with information queried from pseudo.
Afterwards it calls the original callback and passes the now corrected
information to it.

Since nftw and nftw64 are so similar, the same codebase is used to
implement both (which is also fairly similar to their implementation in
glibc).

[1]: https://linux.die.net/man/3/nftw

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>

Rework nftw_wrapper_base to provide a 'pseudo_<name>' function for the
generated wrapper functions to call.  This is cleaner for debugging and
profiling in the future as the standard wrapper is now being used.

Reworded the commit message above to remove references to a chunk that
is no longer applicable.

Added error checking around chdir and fchdir function calls.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 guts/README                         |   4 +-
 ports/linux/guts/nftw64.c           |   2 +-
 ports/linux/pseudo_wrappers.c       |  10 ++
 ports/unix/guts/nftw.c              |   2 +-
 ports/unix/guts/nftw_wrapper_base.c | 195 ++++++++++++++++++++++++++++
 ports/unix/pseudo_wrappers.c        |  10 ++
 6 files changed, 219 insertions(+), 4 deletions(-)
 create mode 100644 ports/unix/guts/nftw_wrapper_base.c

diff --git a/guts/README b/guts/README
index bb2e573..a1f30f5 100644
--- a/guts/README
+++ b/guts/README
@@ -96,6 +96,8 @@ wrappers:
 	freopen64
 	mkstemp
 	mkstemp64
+	nftw64
+	nftw
 	fcntl
 	fork
 	link
@@ -136,8 +138,6 @@ calling the underlying routine.
 	lutimes
 	mkdtemp
 	mktemp
-	nftw64
-	nftw
 	opendir
 	pathconf
 	readlinkat
diff --git a/ports/linux/guts/nftw64.c b/ports/linux/guts/nftw64.c
index 816faba..8946109 100644
--- a/ports/linux/guts/nftw64.c
+++ b/ports/linux/guts/nftw64.c
@@ -9,7 +9,7 @@
  *	int rc = -1;
  */
 
-	rc = real_nftw64(path, fn, nopenfd, flag);
+	rc = pseudo_nftw64(path, fn, nopenfd, flag);
 
 /*	return rc;
  * }
diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index 7659897..c39cf20 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -148,3 +148,13 @@ static int wrap_prctl(int option, va_list ap) {
 	(void) ap;
 	return -1;
 }
+
+#undef NFTW_NAME
+#undef NFTW_STAT_NAME
+#undef NFTW_STAT_STRUCT
+#undef NFTW_LSTAT_NAME
+#define NFTW_NAME nftw64
+#define NFTW_STAT_NAME stat64
+#define NFTW_STAT_STRUCT stat64
+#define NFTW_LSTAT_NAME lstat64
+#include "../unix/guts/nftw_wrapper_base.c"
diff --git a/ports/unix/guts/nftw.c b/ports/unix/guts/nftw.c
index dac3106..7a81acf 100644
--- a/ports/unix/guts/nftw.c
+++ b/ports/unix/guts/nftw.c
@@ -9,7 +9,7 @@
  *	int rc = -1;
  */
 
-	rc = real_nftw(path, fn, nopenfd, flag);
+	rc = pseudo_nftw(path, fn, nopenfd, flag);
 
 /*	return rc;
  * }
diff --git a/ports/unix/guts/nftw_wrapper_base.c b/ports/unix/guts/nftw_wrapper_base.c
new file mode 100644
index 0000000..d13712b
--- /dev/null
+++ b/ports/unix/guts/nftw_wrapper_base.c
@@ -0,0 +1,195 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ */
+
+/*
+ * Whatever includes this is expected to defind the four items
+ *
+ * #define NFTW_NAME nftw64
+ * #define NFTW_STAT_STRUCT stat64
+ * #define NFTW_STAT_NAME stat64
+ * #define NFTW_LSTAT_NAME lstat64
+ */
+
+#define NFTW_CONCAT_EXPANDED(prefix, value) prefix ## value
+#define NFTW_CONCAT(prefix, value) NFTW_CONCAT_EXPANDED(prefix, value)
+
+#define NFTW_PSEUDO_NAME NFTW_CONCAT(pseudo_, NFTW_NAME)
+#define NFTW_REAL_NAME NFTW_CONCAT(real_, NFTW_NAME)
+
+#define NFTW_CALLBACK_NAME NFTW_CONCAT(wrap_callback_, NFTW_NAME)
+#define NFTW_STORAGE_STRUCT_NAME NFTW_CONCAT(storage_struct_, NFTW_NAME)
+#define NFTW_STORAGE_ARRAY_SIZE NFTW_CONCAT(storage_size_, NFTW_NAME)
+#define NFTW_MUTEX_NAME NFTW_CONCAT(mutex_, NFTW_NAME)
+#define NFTW_STORAGE_ARRAY_NAME NFTW_CONCAT(storage_array_, NFTW_NAME)
+#define NFTW_APPEND_FN_NAME NFTW_CONCAT(append_to_array_, NFTW_NAME)
+#define NFTW_DELETE_FN_NAME NFTW_CONCAT(delete_from_array_, NFTW_NAME)
+#define NFTW_FIND_FN_NAME NFTW_CONCAT(find_in_array_, NFTW_NAME)
+
+struct NFTW_STORAGE_STRUCT_NAME {
+    int (*callback)(const char *, const struct NFTW_STAT_STRUCT *, int, struct FTW *);
+    int flags;
+    pthread_t tid;
+};
+
+static struct NFTW_STORAGE_STRUCT_NAME *NFTW_STORAGE_ARRAY_NAME;
+size_t NFTW_STORAGE_ARRAY_SIZE = 0;
+static pthread_mutex_t NFTW_MUTEX_NAME = PTHREAD_MUTEX_INITIALIZER;
+
+static void NFTW_APPEND_FN_NAME(struct NFTW_STORAGE_STRUCT_NAME *data_to_append){
+    NFTW_STORAGE_ARRAY_NAME = realloc(NFTW_STORAGE_ARRAY_NAME, ++NFTW_STORAGE_ARRAY_SIZE * sizeof(*data_to_append));
+    memcpy(&NFTW_STORAGE_ARRAY_NAME[NFTW_STORAGE_ARRAY_SIZE - 1], data_to_append, sizeof(*data_to_append));
+}
+
+int NFTW_FIND_FN_NAME(struct NFTW_STORAGE_STRUCT_NAME* target) {
+    pthread_t tid = pthread_self();
+
+    // return the last one, not the first
+    for (ssize_t i = NFTW_STORAGE_ARRAY_SIZE - 1; i >= 0; --i){
+        if (NFTW_STORAGE_ARRAY_NAME[i].tid == tid){
+            // need to dereference it, as next time this array
+            // may be realloc'd, making the original pointer
+            // invalid
+            *target = NFTW_STORAGE_ARRAY_NAME[i];
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
+static void NFTW_DELETE_FN_NAME() {
+    pthread_t tid = pthread_self();
+
+    if (NFTW_STORAGE_ARRAY_SIZE == 1) {
+        if (NFTW_STORAGE_ARRAY_NAME[0].tid == tid) {
+            free(NFTW_STORAGE_ARRAY_NAME);
+            NFTW_STORAGE_ARRAY_NAME = NULL;
+            --NFTW_STORAGE_ARRAY_SIZE;
+        } else {
+            pseudo_diag("%s: Invalid callback storage content, can't find corresponding data", __func__);
+        }
+        return;
+    }
+
+    int found_idx = -1;
+    for (ssize_t i = NFTW_STORAGE_ARRAY_SIZE - 1; i >= 0; --i) {
+        if (NFTW_STORAGE_ARRAY_NAME[i].tid == tid) {
+            found_idx = i;
+            break;
+        }
+    }
+
+    if (found_idx == -1) {
+        pseudo_diag("%s: Invalid callback storage content, can't find corresponding data", __func__);
+        return;
+    }
+
+    // delete the item we just found
+    for (size_t i = found_idx + 1; i < NFTW_STORAGE_ARRAY_SIZE; ++i)
+        NFTW_STORAGE_ARRAY_NAME[i - 1] = NFTW_STORAGE_ARRAY_NAME[i];
+
+    NFTW_STORAGE_ARRAY_NAME = realloc(NFTW_STORAGE_ARRAY_NAME, --NFTW_STORAGE_ARRAY_SIZE * sizeof(struct NFTW_STORAGE_STRUCT_NAME));
+
+}
+
+static int NFTW_CALLBACK_NAME(const char* fpath, const struct NFTW_STAT_STRUCT __attribute__((unused)) *sb, int typeflag, struct FTW *ftwbuf) {
+    int orig_cwd_fd = -1;
+    char *orig_cwd = NULL;
+    char *target_dir = NULL;
+    struct NFTW_STORAGE_STRUCT_NAME saved_details;
+    struct NFTW_STAT_STRUCT pseudo_sb;
+
+    if (!NFTW_FIND_FN_NAME(&saved_details)) {
+        pseudo_diag("%s: Could not find corresponding callback!", __func__);
+        return -1;
+    }
+
+    // This flag is handled by nftw, however the actual directory change happens
+    // outside of pseudo, so it doesn't have any effect. To mitigate this, handle
+    // it here also explicitly.
+    //
+    // This is very similar to what glibc is doing: keep an open FD for the
+    // current working directory, process the entry (determine the flags, etc),
+    // call the callback, and then switch back to the original folder - in the same
+    // process. Glibc doesn't seem to take any further thread-safety measures nor
+    // other special steps.
+    //
+    // See io/ftw.c in glibc source
+    if (saved_details.flags & FTW_CHDIR) {
+        orig_cwd_fd = open(".", O_RDONLY | O_DIRECTORY);
+        if (orig_cwd_fd == -1) {
+            orig_cwd = getcwd(NULL, 0);
+        }
+
+        // If it is a folder that's content has been already walked with the
+        // FTW_DEPTH flag, then switch into this folder, instead of the parent of
+        // it. This matches the behavior of the real nftw in this special case.
+        // This seems to be undocumented - it was derived by observing this behavior.
+        if (typeflag == FTW_DP) {
+            if (chdir(fpath) == -1)
+                return -1;
+        } else {
+            target_dir = malloc(ftwbuf->base + 1);
+            memset(target_dir, 0, ftwbuf->base + 1);
+            strncpy(target_dir, fpath, ftwbuf->base);
+            if (chdir(target_dir) == -1)
+                return -1;
+        }
+    }
+
+    // This is the main point of this call. Instead of the stat that
+    // came from real_nftw, use the stat returned by pseudo.
+    //
+    // We use our own stat memory as the stat from nftw is labeled const
+    // and while it would probably be safe to re-use, there is a
+    // chance it won't be.
+    //
+    // If the target can't be stat'd (DNR), then just we clear the
+    // stat memory as no information can be retrieved of it anyway.
+    if (typeflag != FTW_DNR) {
+        (saved_details.flags & FTW_PHYS) ? NFTW_LSTAT_NAME(fpath, &pseudo_sb) : NFTW_STAT_NAME(fpath, &pseudo_sb);
+    } else {
+        /* Clear memory so we're not passing something we shouldn't */
+        memset(&pseudo_sb, 0, sizeof(pseudo_sb));
+    }
+
+    int ret = saved_details.callback(fpath, &pseudo_sb, typeflag, ftwbuf);
+
+    if (saved_details.flags & FTW_CHDIR) {
+        if (orig_cwd_fd != -1) {
+            if (fchdir(orig_cwd_fd) == -1)
+                return -1;
+            close(orig_cwd_fd);
+        } else if (orig_cwd != NULL) {
+            if (chdir(orig_cwd) == -1)
+                return -1;
+        }
+        free(target_dir);
+    }
+
+    return ret;
+}
+
+static int
+NFTW_PSEUDO_NAME(const char *path, int (*fn)(const char *, const struct NFTW_STAT_STRUCT *, int, struct FTW *), int nopenfd, int flag) {
+    int rc = -1;
+
+    struct NFTW_STORAGE_STRUCT_NAME saved_details;
+
+    saved_details.tid = pthread_self();
+    saved_details.flags = flag;
+    saved_details.callback = fn;
+
+    pthread_mutex_lock(&NFTW_MUTEX_NAME);
+    NFTW_APPEND_FN_NAME(&saved_details);
+    pthread_mutex_unlock(&NFTW_MUTEX_NAME);
+
+    // Call the real function, but use our callback to intercept the answer
+    rc = NFTW_REAL_NAME(path, NFTW_CALLBACK_NAME, nopenfd, flag);
+
+    pthread_mutex_lock(&NFTW_MUTEX_NAME);
+    NFTW_DELETE_FN_NAME();
+    pthread_mutex_unlock(&NFTW_MUTEX_NAME);
+    return rc;
+}
diff --git a/ports/unix/pseudo_wrappers.c b/ports/unix/pseudo_wrappers.c
index bf69aa9..41398e4 100644
--- a/ports/unix/pseudo_wrappers.c
+++ b/ports/unix/pseudo_wrappers.c
@@ -52,3 +52,13 @@ wrap_popen(const char *command, const char *mode) {
 	return rc;
 }
 
+
+#undef NFTW_NAME
+#undef NFTW_STAT_NAME
+#undef NFTW_STAT_STRUCT
+#undef NFTW_LSTAT_NAME
+#define NFTW_NAME nftw
+#define NFTW_STAT_NAME stat
+#define NFTW_STAT_STRUCT stat
+#define NFTW_LSTAT_NAME lstat
+#include "guts/nftw_wrapper_base.c"
-- 
2.34.1


