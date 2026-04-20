Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFE2F5A8AB
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 18:30:40 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.213.1776709833130889982
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 11:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63KIUUPw3563308;
	Mon, 20 Apr 2026 13:30:31 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Subject: [PATCH 3/5] test: Add openat2 test cases
Date: Mon, 20 Apr 2026 13:30:27 -0500
Message-Id: <1776709829-2754-4-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1776709829-2754-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1776709829-2754-1-git-send-email-mark.hatle@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 63KIUUPw3563308
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 18:30:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3745

From: Mark Hatle <mark.hatle@amd.com>

Add two primary test cases, openat2 via syscall and openat2 via
function call.  Add two secondary tests calling each of these
from a chroot environment.

Since the function may or may not exist in different versions of
glibc, this may return skipped if the glibc used for testing does
not contain the function.

Similarly if the running kernel does not define the openat2
syscall, the test may also be skipped.

Otherwise the two test cases are virtually identical in nature,
but were broken into two different .c files to make it easier
to capture the difference between the syscall and function in
the future.

Note, we're not checking for the openat2 escaping the chroot.
We expect it is able to escape the chroot via relative paths.

AI-Generated: Test cases written using GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 test/test-openat2-func-chroot.sh    |  18 +++
 test/test-openat2-func.c            | 274 ++++++++++++++++++++++++++++++=
+++
 test/test-openat2-func.sh           |  18 +++
 test/test-openat2-syscall-chroot.sh |  18 +++
 test/test-openat2-syscall.c         | 299 ++++++++++++++++++++++++++++++=
++++++
 test/test-openat2-syscall.sh        |  18 +++
 6 files changed, 645 insertions(+)
 create mode 100755 test/test-openat2-func-chroot.sh
 create mode 100644 test/test-openat2-func.c
 create mode 100755 test/test-openat2-func.sh
 create mode 100755 test/test-openat2-syscall-chroot.sh
 create mode 100644 test/test-openat2-syscall.c
 create mode 100755 test/test-openat2-syscall.sh

diff --git a/test/test-openat2-func-chroot.sh b/test/test-openat2-func-ch=
root.sh
new file mode 100755
index 0000000..b20b4ff
--- /dev/null
+++ b/test/test-openat2-func-chroot.sh
@@ -0,0 +1,18 @@
+#! /bin/sh
+
+# rc 77 indicates an ENOSYS, so return back we're skipped
+# This usually indicates that glibc does not have the openat2 function
+run_test() {
+	$@
+	rc=3D$?
+	if [ "$rc" -eq 77 ]; then
+		exit 255
+	fi
+	return "$rc"
+}
+
+# Run with and without ignored paths, matching test-openat coverage.
+run_test chroot ./test ./test-openat2-func || exit $?
+run_test env PSEUDO_IGNORE_PATHS=3D/ chroot ./test ./test-openat2-func |=
| exit $?
+
+exit 0
diff --git a/test/test-openat2-func.c b/test/test-openat2-func.c
new file mode 100644
index 0000000..00c3e12
--- /dev/null
+++ b/test/test-openat2-func.c
@@ -0,0 +1,274 @@
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#if __has_include (<linux/openat2.h>)
+# include <linux/openat2.h>
+#else
+/* Kernel too old for SYS_openat2 =E2=80=94 define the necessary bits ou=
rselves. */
+  struct open_how {
+	unsigned long long flags;
+	unsigned long long mode;
+	unsigned long long resolve;
+  };
+  #ifndef RESOLVE_NO_XDEV
+  #define RESOLVE_NO_XDEV	0x01
+  #endif
+  #ifndef RESOLVE_NO_MAGICLINKS
+  #define RESOLVE_NO_MAGICLINKS	0x02
+  #endif
+  #ifndef RESOLVE_NO_SYMLINKS
+  #define RESOLVE_NO_SYMLINKS	0x04
+  #endif
+  #ifndef RESOLVE_BENEATH
+  #define RESOLVE_BENEATH	0x08
+  #endif
+  #ifndef RESOLVE_IN_ROOT
+  #define RESOLVE_IN_ROOT	0x10
+  #endif
+  #ifndef RESOLVE_CACHED
+  #define RESOLVE_CACHED	0x20
+  #endif
+#endif /* has linux/openat2.h */
+
+#ifndef O_PATH
+#define O_PATH 0
+#endif
+
+/*
+ * Pseudo intercepts openat2 via two separate code paths:
+ *
+ * 1) syscall(SYS_openat2, ...) =E2=80=94 intercepted by wrap_syscall() =
in
+ *    pseudo_wrappers.c, which extracts the varargs and calls
+ *    wrap_openat2() directly.  The path is NOT converted.
+ *
+ * 2) openat2(...) as a direct function call =E2=80=94 intercepted by ps=
eudo's
+ *    openat2() symbol in libpseudo.so.  This wrapper runs
+ *    pseudo_root_path() to convert the path to an absolute form,
+ *    then calls wrap_openat2().
+ *
+ * The fix in f18abb3 (preserve_paths) only affects path #2: without it,
+ * the pseudo_root_path conversion turns a relative path into an absolut=
e
+ * one, which then fails with EXDEV when RESOLVE_BENEATH is set.
+ *
+ * We test both paths to ensure neither regresses.
+ */
+
+/*
+ * Declare openat2 as an extern =E2=80=94 glibc doesn't provide it, but =
pseudo's
+ * libpseudo.so exports it.  Calling this exercises the glibc-level
+ * interceptor path where pseudo_root_path() is applied to the path arg.
+ * When running without pseudo, this resolves to a weak alias for the
+ * syscall wrapper below.
+ */
+extern int openat2(int dirfd, const char *path,
+		   const struct open_how *how, size_t size) __attribute__((weak));
+
+/* Call openat2 as a function if available, fall back to syscall. */
+static int do_openat2_func(int dirfd, const char *path,
+			   struct open_how *how, size_t size) {
+	if (openat2)
+		return openat2(dirfd, path, how, size);
+        errno =3D ENOSYS;
+        return -1;
+}
+
+static int touch_file(const char *path) {
+	int fd =3D open(path, O_CREAT | O_WRONLY | O_TRUNC, 0644);
+	if (fd =3D=3D -1) {
+		perror("open");
+		return -1;
+	}
+	if (write(fd, "x", 1) !=3D 1) {
+		perror("write");
+		close(fd);
+		return -1;
+	}
+	if (close(fd) =3D=3D -1) {
+		perror("close");
+		return -1;
+	}
+	return 0;
+}
+
+int main(void) {
+	char template[] =3D "test-openat2.XXXXXX";
+	char subdir[PATH_MAX];
+	char leafdir[PATH_MAX];
+	char marker[PATH_MAX];
+	char marker_relative[] =3D "../marker";
+	char *base;
+	int dirfd =3D -1;
+	int fd =3D -1;
+	int rc =3D 1;
+	int saved_errno;
+	struct open_how how;
+	char cwd_save[PATH_MAX];
+	int cwd_saved =3D 0;
+
+	base =3D mkdtemp(template);
+	if (!base) {
+		perror("mkdtemp");
+		return 1;
+	}
+
+	if (snprintf(subdir, sizeof(subdir), "%s/sub", base) >=3D (int) sizeof(=
subdir)) {
+		fprintf(stderr, "path too long\n");
+		goto out;
+	}
+	if (snprintf(leafdir, sizeof(leafdir), "%s/sub/leaf", base) >=3D (int) =
sizeof(leafdir)) {
+		fprintf(stderr, "path too long\n");
+		goto out;
+	}
+	if (snprintf(marker, sizeof(marker), "%s/marker", base) >=3D (int) size=
of(marker)) {
+		fprintf(stderr, "path too long\n");
+		goto out;
+	}
+
+	if (mkdir(subdir, 0755) =3D=3D -1) {
+		perror("mkdir sub");
+		goto out;
+	}
+	if (mkdir(leafdir, 0755) =3D=3D -1) {
+		perror("mkdir leaf");
+		goto out;
+	}
+	if (touch_file(marker) =3D=3D -1) {
+		goto out;
+	}
+
+	dirfd =3D open(subdir, O_RDONLY | O_DIRECTORY);
+	if (dirfd =3D=3D -1) {
+		perror("open subdir");
+		goto out;
+	}
+
+	/* openat semantics: resolving ".." from a dirfd should escape to paren=
t. */
+	fd =3D openat(dirfd, marker_relative, O_RDONLY);
+	if (fd =3D=3D -1) {
+		perror("openat ../marker");
+		goto out;
+	}
+	close(fd);
+	fd =3D -1;
+
+	memset(&how, 0, sizeof(how));
+	how.flags =3D O_RDONLY;
+
+	/*
+	 * Verify fix from f18abb3: openat2 must preserve relative paths.
+	 *
+	 * Before the fix, pseudo's openat2() interceptor converted relative
+	 * paths to absolute via pseudo_root_path(), so a call like:
+	 *   openat2(AT_FDCWD, "dir1/dir2/",
+	 *           {O_DIRECTORY, resolve=3DRESOLVE_BENEATH})
+	 * was turned into:
+	 *   openat2(AT_FDCWD, "/full/path/to/dir1/dir2/",
+	 *           {O_DIRECTORY, resolve=3DRESOLVE_BENEATH})
+	 * which failed with EXDEV because the absolute path escapes the
+	 * directory tree rooted at AT_FDCWD.
+	 *
+	 * This bug only affects the direct openat2() function call path
+	 * (pseudo's glibc-level interceptor), NOT the syscall(SYS_openat2)
+	 * path (which goes through wrap_syscall and never converts paths).
+	 *
+	 * We test both paths to ensure neither regresses.
+	 *
+	 * Test: chdir into base, then open a relative sub-path with
+	 * RESOLVE_BENEATH via AT_FDCWD.  This must succeed via both paths.
+	 */
+	{
+		int beneath_fd;
+		char abspath[PATH_MAX];
+
+		if (!getcwd(cwd_save, sizeof(cwd_save))) {
+			perror("getcwd");
+			goto out;
+		}
+		cwd_saved =3D 1;
+
+		/* chdir into base so "sub/leaf" is a valid relative path */
+		if (chdir(base) =3D=3D -1) {
+			perror("chdir base");
+			goto out;
+		}
+
+		memset(&how, 0, sizeof(how));
+		how.flags =3D O_RDONLY | O_DIRECTORY;
+		how.resolve =3D RESOLVE_BENEATH;
+
+
+		/* --- Test via openat2() direct function call (f18abb3 path) --- */
+
+		/* Positive: relative path + RESOLVE_BENEATH via direct call.
+		 * This is the case that failed before f18abb3 because pseudo
+		 * converted the relative path to absolute.
+		 */
+		beneath_fd =3D do_openat2_func(AT_FDCWD, "sub/leaf", &how,
+					     sizeof(how));
+		if (beneath_fd =3D=3D -1) {
+			if (errno =3D=3D ENOSYS) {
+				rc =3D 77;
+				goto out_restore_cwd;
+			}
+			fprintf(stderr, "openat2(): RESOLVE_BENEATH + relative "
+				"\"sub/leaf\" failed: %s (bug f18abb3)\n",
+				strerror(errno));
+			goto out_restore_cwd;
+		}
+		close(beneath_fd);
+
+		/* Negative: absolute path + RESOLVE_BENEATH via direct call */
+		if (snprintf(abspath, sizeof(abspath), "%s/%s/sub/leaf",
+			     cwd_save, base) < (int) sizeof(abspath)) {
+			beneath_fd =3D do_openat2_func(AT_FDCWD, abspath,
+						     &how, sizeof(how));
+			if (beneath_fd !=3D -1) {
+				fprintf(stderr, "openat2(): RESOLVE_BENEATH + "
+					"absolute path should have failed\n");
+				close(beneath_fd);
+				goto out_restore_cwd;
+			}
+			if (errno !=3D EXDEV) {
+				fprintf(stderr, "openat2(): RESOLVE_BENEATH + "
+					"absolute: expected EXDEV, got %s\n",
+					strerror(errno));
+				goto out_restore_cwd;
+			}
+		}
+
+		if (chdir(cwd_save) =3D=3D -1) {
+			perror("chdir restore");
+			cwd_saved =3D 0;
+			goto out;
+		}
+	}
+
+	rc =3D 0;
+	goto out;
+
+out_restore_cwd:
+	if (cwd_saved)
+		if (chdir(cwd_save) =3D=3D -1)
+			perror("chdir restore (cleanup)");
+
+out:
+	if (fd !=3D -1)
+		close(fd);
+	if (dirfd !=3D -1)
+		close(dirfd);
+	unlink(marker);
+	rmdir(leafdir);
+	rmdir(subdir);
+	rmdir(base);
+
+	return rc;
+}
diff --git a/test/test-openat2-func.sh b/test/test-openat2-func.sh
new file mode 100755
index 0000000..727b377
--- /dev/null
+++ b/test/test-openat2-func.sh
@@ -0,0 +1,18 @@
+#! /bin/sh
+
+# rc 77 indicates an ENOSYS, so return back we're skipped
+# This usually indicates that glibc does not have the openat2 function
+run_test() {
+	$@
+	rc=3D$?
+	if [ "$rc" -eq 77 ]; then
+		exit 255
+	fi
+	return "$rc"
+}
+
+# Run with and without ignored paths, matching test-openat coverage.
+run_test ./test/test-openat2-func || exit $?
+run_test env PSEUDO_IGNORE_PATHS=3D/ ./test/test-openat2-func || exit $?
+
+exit 0
diff --git a/test/test-openat2-syscall-chroot.sh b/test/test-openat2-sysc=
all-chroot.sh
new file mode 100755
index 0000000..c3aef7a
--- /dev/null
+++ b/test/test-openat2-syscall-chroot.sh
@@ -0,0 +1,18 @@
+#! /bin/sh
+
+# rc 77 indicates an ENOSYS, so return back we're skipped
+# This shouldn't happen, but the user could disable openat2 syscall emul=
ation
+run_test() {
+	$@
+	rc=3D$?
+	if [ "$rc" -eq 77 ]; then
+		exit 255
+	fi
+	return "$rc"
+}
+
+# Run with and without ignored paths, matching test-openat coverage.
+run_test chroot ./test ./test-openat2-syscall || exit $?
+run_test env PSEUDO_IGNORE_PATHS=3D/ chroot ./test ./test-openat2-syscal=
l || exit $?
+
+exit 0
diff --git a/test/test-openat2-syscall.c b/test/test-openat2-syscall.c
new file mode 100644
index 0000000..4dbb279
--- /dev/null
+++ b/test/test-openat2-syscall.c
@@ -0,0 +1,299 @@
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#if __has_include (<linux/openat2.h>)
+# include <linux/openat2.h>
+#else
+/* Kernel too old for SYS_openat2 =E2=80=94 define the necessary bits ou=
rselves. */
+  struct open_how {
+	unsigned long long flags;
+	unsigned long long mode;
+	unsigned long long resolve;
+  };
+  #ifndef RESOLVE_NO_XDEV
+  #define RESOLVE_NO_XDEV	0x01
+  #endif
+  #ifndef RESOLVE_NO_MAGICLINKS
+  #define RESOLVE_NO_MAGICLINKS	0x02
+  #endif
+  #ifndef RESOLVE_NO_SYMLINKS
+  #define RESOLVE_NO_SYMLINKS	0x04
+  #endif
+  #ifndef RESOLVE_BENEATH
+  #define RESOLVE_BENEATH	0x08
+  #endif
+  #ifndef RESOLVE_IN_ROOT
+  #define RESOLVE_IN_ROOT	0x10
+  #endif
+  #ifndef RESOLVE_CACHED
+  #define RESOLVE_CACHED	0x20
+  #endif
+#endif /* has linux/openat2.h */
+
+#ifndef O_PATH
+#define O_PATH 0
+#endif
+
+/*
+ * Pseudo intercepts openat2 via two separate code paths:
+ *
+ * 1) syscall(SYS_openat2, ...) =E2=80=94 intercepted by wrap_syscall() =
in
+ *    pseudo_wrappers.c, which extracts the varargs and calls
+ *    wrap_openat2() directly.  The path is NOT converted.
+ *
+ * 2) openat2(...) as a direct function call =E2=80=94 intercepted by ps=
eudo's
+ *    openat2() symbol in libpseudo.so.  This wrapper runs
+ *    pseudo_root_path() to convert the path to an absolute form,
+ *    then calls wrap_openat2().
+ *
+ * The fix in f18abb3 (preserve_paths) only affects path #2: without it,
+ * the pseudo_root_path conversion turns a relative path into an absolut=
e
+ * one, which then fails with EXDEV when RESOLVE_BENEATH is set.
+ *
+ * We test both paths to ensure neither regresses.
+ */
+
+/* Call openat2 via syscall() =E2=80=94 exercises the wrap_syscall dispa=
tch path. */
+static int do_openat2_syscall(int dirfd, const char *path,
+			      struct open_how *how, size_t size) {
+#ifdef SYS_openat2
+	return syscall(SYS_openat2, dirfd, path, how, size);
+#elif defined(__NR_openat2)
+	return syscall(__NR_openat2, dirfd, path, how, size);
+#else
+	errno =3D ENOSYS;
+	return -1;
+#endif
+}
+
+static int touch_file(const char *path) {
+	int fd =3D open(path, O_CREAT | O_WRONLY | O_TRUNC, 0644);
+	if (fd =3D=3D -1) {
+		perror("open");
+		return -1;
+	}
+	if (write(fd, "x", 1) !=3D 1) {
+		perror("write");
+		close(fd);
+		return -1;
+	}
+	if (close(fd) =3D=3D -1) {
+		perror("close");
+		return -1;
+	}
+	return 0;
+}
+
+int main(void) {
+	char template[] =3D "test-openat2.XXXXXX";
+	char subdir[PATH_MAX];
+	char leafdir[PATH_MAX];
+	char marker[PATH_MAX];
+	char marker_relative[] =3D "../marker";
+	char *base;
+	int dirfd =3D -1;
+	int fd =3D -1;
+	int rc =3D 1;
+	int saved_errno;
+	struct open_how how;
+	char cwd_save[PATH_MAX];
+	int cwd_saved =3D 0;
+
+	base =3D mkdtemp(template);
+	if (!base) {
+		perror("mkdtemp");
+		return 1;
+	}
+
+	if (snprintf(subdir, sizeof(subdir), "%s/sub", base) >=3D (int) sizeof(=
subdir)) {
+		fprintf(stderr, "path too long\n");
+		goto out;
+	}
+	if (snprintf(leafdir, sizeof(leafdir), "%s/sub/leaf", base) >=3D (int) =
sizeof(leafdir)) {
+		fprintf(stderr, "path too long\n");
+		goto out;
+	}
+	if (snprintf(marker, sizeof(marker), "%s/marker", base) >=3D (int) size=
of(marker)) {
+		fprintf(stderr, "path too long\n");
+		goto out;
+	}
+
+	if (mkdir(subdir, 0755) =3D=3D -1) {
+		perror("mkdir sub");
+		goto out;
+	}
+	if (mkdir(leafdir, 0755) =3D=3D -1) {
+		perror("mkdir leaf");
+		goto out;
+	}
+	if (touch_file(marker) =3D=3D -1) {
+		goto out;
+	}
+
+	dirfd =3D open(subdir, O_RDONLY | O_DIRECTORY);
+	if (dirfd =3D=3D -1) {
+		perror("open subdir");
+		goto out;
+	}
+
+	/* openat semantics: resolving ".." from a dirfd should escape to paren=
t. */
+	fd =3D openat(dirfd, marker_relative, O_RDONLY);
+	if (fd =3D=3D -1) {
+		perror("openat ../marker");
+		goto out;
+	}
+	close(fd);
+	fd =3D -1;
+
+	memset(&how, 0, sizeof(how));
+	how.flags =3D O_RDONLY;
+
+	/* openat2 via syscall() with no resolve flags should match openat-styl=
e lookup. */
+	fd =3D do_openat2_syscall(dirfd, marker_relative, &how, sizeof(how));
+	if (fd =3D=3D -1) {
+		if (errno =3D=3D ENOSYS) {
+			rc =3D 77;
+			goto out;
+		}
+		perror("openat2 ../marker without resolve");
+		goto out;
+	}
+	close(fd);
+	fd =3D -1;
+
+	/* openat2-specific semantics: RESOLVE_BENEATH must block parent escape=
. */
+	how.resolve =3D RESOLVE_BENEATH;
+	fd =3D do_openat2_syscall(dirfd, marker_relative, &how, sizeof(how));
+	if (fd !=3D -1) {
+		fprintf(stderr, "openat2 RESOLVE_BENEATH unexpectedly allowed ../ esca=
pe\n");
+		close(fd);
+		fd =3D -1;
+		goto out;
+	}
+	saved_errno =3D errno;
+	if (saved_errno !=3D EXDEV) {
+		fprintf(stderr, "openat2 RESOLVE_BENEATH returned errno %d, expected %=
d\n",
+			saved_errno, EXDEV);
+		goto out;
+	}
+
+	/* Positive RESOLVE_BENEATH case should still allow a path under dirfd.=
 */
+	how.flags =3D O_RDONLY | O_DIRECTORY;
+	fd =3D do_openat2_syscall(dirfd, "leaf", &how, sizeof(how));
+	if (fd =3D=3D -1) {
+		perror("openat2 RESOLVE_BENEATH leaf");
+		goto out;
+	}
+	close(fd);
+	fd =3D -1;
+
+	/*
+	 * Verify fix from f18abb3: openat2 must preserve relative paths.
+	 *
+	 * Before the fix, pseudo's openat2() interceptor converted relative
+	 * paths to absolute via pseudo_root_path(), so a call like:
+	 *   openat2(AT_FDCWD, "dir1/dir2/",
+	 *           {O_DIRECTORY, resolve=3DRESOLVE_BENEATH})
+	 * was turned into:
+	 *   openat2(AT_FDCWD, "/full/path/to/dir1/dir2/",
+	 *           {O_DIRECTORY, resolve=3DRESOLVE_BENEATH})
+	 * which failed with EXDEV because the absolute path escapes the
+	 * directory tree rooted at AT_FDCWD.
+	 *
+	 * This bug only affects the direct openat2() function call path
+	 * (pseudo's glibc-level interceptor), NOT the syscall(SYS_openat2)
+	 * path (which goes through wrap_syscall and never converts paths).
+	 *
+	 * We test both paths to ensure neither regresses.
+	 *
+	 * Test: chdir into base, then open a relative sub-path with
+	 * RESOLVE_BENEATH via AT_FDCWD.  This must succeed via both paths.
+	 */
+	{
+		int beneath_fd;
+		char abspath[PATH_MAX];
+
+		if (!getcwd(cwd_save, sizeof(cwd_save))) {
+			perror("getcwd");
+			goto out;
+		}
+		cwd_saved =3D 1;
+
+		/* chdir into base so "sub/leaf" is a valid relative path */
+		if (chdir(base) =3D=3D -1) {
+			perror("chdir base");
+			goto out;
+		}
+
+		memset(&how, 0, sizeof(how));
+		how.flags =3D O_RDONLY | O_DIRECTORY;
+		how.resolve =3D RESOLVE_BENEATH;
+
+		/* --- Test via syscall(SYS_openat2) path --- */
+
+		/* Positive: relative path + RESOLVE_BENEATH via syscall */
+		beneath_fd =3D do_openat2_syscall(AT_FDCWD, "sub/leaf", &how,
+						sizeof(how));
+		if (beneath_fd =3D=3D -1) {
+			fprintf(stderr, "syscall: RESOLVE_BENEATH + relative "
+				"\"sub/leaf\" failed: %s\n", strerror(errno));
+			goto out_restore_cwd;
+		}
+		close(beneath_fd);
+
+		/* Negative: absolute path + RESOLVE_BENEATH via syscall must fail */
+		if (snprintf(abspath, sizeof(abspath), "%s/%s/sub/leaf",
+			     cwd_save, base) < (int) sizeof(abspath)) {
+			beneath_fd =3D do_openat2_syscall(AT_FDCWD, abspath,
+							&how, sizeof(how));
+			if (beneath_fd !=3D -1) {
+				fprintf(stderr, "syscall: RESOLVE_BENEATH + "
+					"absolute path should have failed\n");
+				close(beneath_fd);
+				goto out_restore_cwd;
+			}
+			if (errno !=3D EXDEV) {
+				fprintf(stderr, "syscall: RESOLVE_BENEATH + "
+					"absolute: expected EXDEV, got %s\n",
+					strerror(errno));
+				goto out_restore_cwd;
+			}
+		}
+
+		if (chdir(cwd_save) =3D=3D -1) {
+			perror("chdir restore");
+			cwd_saved =3D 0;
+			goto out;
+		}
+	}
+
+	rc =3D 0;
+	goto out;
+
+out_restore_cwd:
+	if (cwd_saved)
+		if (chdir(cwd_save) =3D=3D -1)
+			perror("chdir restore (cleanup)");
+
+out:
+	if (fd !=3D -1)
+		close(fd);
+	if (dirfd !=3D -1)
+		close(dirfd);
+	unlink(marker);
+	rmdir(leafdir);
+	rmdir(subdir);
+	rmdir(base);
+
+	return rc;
+}
diff --git a/test/test-openat2-syscall.sh b/test/test-openat2-syscall.sh
new file mode 100755
index 0000000..0a26c0c
--- /dev/null
+++ b/test/test-openat2-syscall.sh
@@ -0,0 +1,18 @@
+#! /bin/sh
+
+# rc 77 indicates an ENOSYS, so return back we're skipped
+# This shouldn't happen, but the user could disable openat2 syscall emul=
ation
+run_test() {
+	$@
+	rc=3D$?
+	if [ "$rc" -eq 77 ]; then
+		exit 255
+	fi
+	return "$rc"
+}
+
+# Run with and without ignored paths, matching test-openat coverage.
+run_test ./test/test-openat2-syscall || exit $?
+run_test env PSEUDO_IGNORE_PATHS=3D/ ./test/test-openat2-syscall || exit=
 $?
+
+exit 0
--=20
1.8.3.1


