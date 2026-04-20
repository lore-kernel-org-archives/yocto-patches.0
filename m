Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1115F5A8AC
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 18:30:40 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.208.1776709833150896232
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 11:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63KIUUPx3563308;
	Mon, 20 Apr 2026 13:30:31 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
Subject: [PATCH 4/5] test: Add renameat2 test cases
Date: Mon, 20 Apr 2026 13:30:28 -0500
Message-Id: <1776709829-2754-5-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1776709829-2754-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1776709829-2754-1-git-send-email-mark.hatle@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 63KIUUPx3563308
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 18:30:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3743

From: Mark Hatle <mark.hatle@amd.com>

Add two test cases for renameat2 semantics.  A primary test and a
chroot test case.

AI-Generated: Test cases written using GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 test/test-renameat2-chroot.sh |  11 ++
 test/test-renameat2.c         | 263 ++++++++++++++++++++++++++++++++++++=
++++++
 test/test-renameat2.sh        |  11 ++
 3 files changed, 285 insertions(+)
 create mode 100755 test/test-renameat2-chroot.sh
 create mode 100644 test/test-renameat2.c
 create mode 100755 test/test-renameat2.sh

diff --git a/test/test-renameat2-chroot.sh b/test/test-renameat2-chroot.s=
h
new file mode 100755
index 0000000..3e44033
--- /dev/null
+++ b/test/test-renameat2-chroot.sh
@@ -0,0 +1,11 @@
+#! /bin/sh
+
+# Run with and without ignored paths, matching test-openat coverage.
+
+chroot ./test ./test-renameat2
+rc=3D$?
+if [ "$rc" -ne 0 ]; then
+	exit "$rc"
+fi
+
+PSEUDO_IGNORE_PATHS=3D/ chroot ./test ./test-renameat2
diff --git a/test/test-renameat2.c b/test/test-renameat2.c
new file mode 100644
index 0000000..286045f
--- /dev/null
+++ b/test/test-renameat2.c
@@ -0,0 +1,263 @@
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
+#ifndef RENAME_NOREPLACE
+#define RENAME_NOREPLACE (1 << 0)
+#endif
+#ifndef RENAME_EXCHANGE
+#define RENAME_EXCHANGE (1 << 1)
+#endif
+
+static int do_renameat2(int olddirfd, const char *oldpath,
+			int newdirfd, const char *newpath,
+			unsigned int flags) {
+#ifdef SYS_renameat2
+	return syscall(SYS_renameat2, olddirfd, oldpath, newdirfd, newpath, fla=
gs);
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
+static int file_exists(int dirfd, const char *name) {
+	struct stat st;
+	return fstatat(dirfd, name, &st, AT_SYMLINK_NOFOLLOW) =3D=3D 0;
+}
+
+int main(void) {
+	char template[] =3D "test-renameat2.XXXXXX";
+	char *base;
+	int dirfd =3D -1;
+	int rc =3D 1;
+	int ret;
+	int renameat2_works =3D 1;
+
+	base =3D mkdtemp(template);
+	if (!base) {
+		perror("mkdtemp");
+		return 1;
+	}
+
+	if (chdir(base) =3D=3D -1) {
+		perror("chdir to base");
+		rmdir(base);
+		return 1;
+	}
+
+	dirfd =3D open(".", O_RDONLY | O_DIRECTORY);
+	if (dirfd =3D=3D -1) {
+		perror("open base dir");
+		goto out;
+	}
+
+	/* ---------------------------------------------------------- */
+	/* Part 1: renameat (classic) semantics via dirfd             */
+	/* ---------------------------------------------------------- */
+
+	if (touch_file("fileA") =3D=3D -1)
+		goto out_in_base;
+
+	/* Rename fileA -> fileB using renameat with dirfd */
+	if (renameat(AT_FDCWD, "fileA", AT_FDCWD, "fileB") =3D=3D -1) {
+		perror("renameat fileA -> fileB");
+		goto out_in_base;
+	}
+	if (file_exists(AT_FDCWD, "fileA")) {
+		fprintf(stderr, "renameat: source still exists after rename\n");
+		goto out_in_base;
+	}
+	if (!file_exists(AT_FDCWD, "fileB")) {
+		fprintf(stderr, "renameat: destination missing after rename\n");
+		goto out_in_base;
+	}
+	unlink("fileB");
+
+	/* Same test but with actual dirfd instead of AT_FDCWD */
+	if (touch_file("fileC") =3D=3D -1)
+		goto out_in_base;
+
+	if (renameat(dirfd, "fileC", dirfd, "fileD") =3D=3D -1) {
+		perror("renameat dirfd fileC -> fileD");
+		goto out_in_base;
+	}
+	if (file_exists(dirfd, "fileC")) {
+		fprintf(stderr, "renameat dirfd: source still exists\n");
+		goto out_in_base;
+	}
+	if (!file_exists(dirfd, "fileD")) {
+		fprintf(stderr, "renameat dirfd: destination missing\n");
+		goto out_in_base;
+	}
+	unlinkat(dirfd, "fileD", 0);
+
+	/* ---------------------------------------------------------- */
+	/* Part 2: renameat2 with flags=3D0 (should match renameat)     */
+	/* ---------------------------------------------------------- */
+
+	if (touch_file("fileE") =3D=3D -1)
+		goto out_in_base;
+
+	ret =3D do_renameat2(AT_FDCWD, "fileE", AT_FDCWD, "fileF", 0);
+	if (ret =3D=3D -1) {
+		if (errno =3D=3D ENOSYS) {
+			/* renameat2 not available (kernel too old or pseudo stub) */
+			renameat2_works =3D 0;
+			unlink("fileE");
+		} else {
+			perror("renameat2 flags=3D0 fileE -> fileF");
+			goto out_in_base;
+		}
+	} else {
+		if (file_exists(AT_FDCWD, "fileE")) {
+			fprintf(stderr, "renameat2 flags=3D0: source still exists\n");
+			goto out_in_base;
+		}
+		if (!file_exists(AT_FDCWD, "fileF")) {
+			fprintf(stderr, "renameat2 flags=3D0: destination missing\n");
+			goto out_in_base;
+		}
+		unlink("fileF");
+	}
+
+	if (!renameat2_works) {
+		/* renameat2 returned ENOSYS; skip the remaining renameat2-specific te=
sts */
+		rc =3D 0;
+		goto out;
+	}
+
+	/* ---------------------------------------------------------- */
+	/* Part 3: RENAME_NOREPLACE =E2=80=94 must fail when target exists    *=
/
+	/* ---------------------------------------------------------- */
+
+	if (touch_file("src_noreplace") =3D=3D -1)
+		goto out_in_base;
+	if (touch_file("dst_noreplace") =3D=3D -1)
+		goto out_in_base;
+
+	ret =3D do_renameat2(AT_FDCWD, "src_noreplace",
+			   AT_FDCWD, "dst_noreplace", RENAME_NOREPLACE);
+	if (ret !=3D -1) {
+		fprintf(stderr, "RENAME_NOREPLACE: should have failed when target exis=
ts\n");
+		goto out_in_base;
+	}
+	if (errno !=3D EEXIST) {
+		fprintf(stderr, "RENAME_NOREPLACE: expected EEXIST, got %s\n",
+			strerror(errno));
+		goto out_in_base;
+	}
+	/* Both files must still exist */
+	if (!file_exists(AT_FDCWD, "src_noreplace") ||
+	    !file_exists(AT_FDCWD, "dst_noreplace")) {
+		fprintf(stderr, "RENAME_NOREPLACE: files disappeared\n");
+		goto out_in_base;
+	}
+
+	/* Positive case: RENAME_NOREPLACE succeeds when target does not exist =
*/
+	unlink("dst_noreplace");
+	ret =3D do_renameat2(AT_FDCWD, "src_noreplace",
+			   AT_FDCWD, "dst_noreplace", RENAME_NOREPLACE);
+	if (ret =3D=3D -1) {
+		perror("RENAME_NOREPLACE (no target)");
+		goto out_in_base;
+	}
+	if (file_exists(AT_FDCWD, "src_noreplace")) {
+		fprintf(stderr, "RENAME_NOREPLACE: source still exists\n");
+		goto out_in_base;
+	}
+	if (!file_exists(AT_FDCWD, "dst_noreplace")) {
+		fprintf(stderr, "RENAME_NOREPLACE: destination missing\n");
+		goto out_in_base;
+	}
+	unlink("dst_noreplace");
+
+	/* ---------------------------------------------------------- */
+	/* Part 4: RENAME_EXCHANGE =E2=80=94 atomically swap two paths        *=
/
+	/* ---------------------------------------------------------- */
+
+	if (touch_file("swap_a") =3D=3D -1)
+		goto out_in_base;
+	if (touch_file("swap_b") =3D=3D -1)
+		goto out_in_base;
+
+	/* Write distinct content so we can verify the swap */
+	{
+		struct stat sa, sb;
+		ino_t ino_a, ino_b;
+
+		if (stat("swap_a", &sa) =3D=3D -1 || stat("swap_b", &sb) =3D=3D -1) {
+			perror("stat before exchange");
+			goto out_in_base;
+		}
+		ino_a =3D sa.st_ino;
+		ino_b =3D sb.st_ino;
+
+		ret =3D do_renameat2(AT_FDCWD, "swap_a",
+				   AT_FDCWD, "swap_b", RENAME_EXCHANGE);
+		if (ret =3D=3D -1) {
+			perror("RENAME_EXCHANGE");
+			goto out_in_base;
+		}
+
+		if (stat("swap_a", &sa) =3D=3D -1 || stat("swap_b", &sb) =3D=3D -1) {
+			perror("stat after exchange");
+			goto out_in_base;
+		}
+
+		/* After exchange, inodes should be swapped */
+		if (sa.st_ino !=3D ino_b || sb.st_ino !=3D ino_a) {
+			fprintf(stderr, "RENAME_EXCHANGE: inodes not swapped "
+				"(a: %lu->%lu, b: %lu->%lu)\n",
+				(unsigned long) ino_a, (unsigned long) sa.st_ino,
+				(unsigned long) ino_b, (unsigned long) sb.st_ino);
+			goto out_in_base;
+		}
+	}
+	unlink("swap_a");
+	unlink("swap_b");
+
+	rc =3D 0;
+	goto out;
+
+out_in_base:
+	/* Best-effort cleanup of any leftover files inside the temp dir */
+	unlink("fileA"); unlink("fileB"); unlink("fileC"); unlink("fileD");
+	unlink("fileE"); unlink("fileF");
+	unlink("src_noreplace"); unlink("dst_noreplace");
+	unlink("swap_a"); unlink("swap_b");
+
+out:
+	if (dirfd !=3D -1)
+		close(dirfd);
+	if (chdir("..") =3D=3D 0)
+		rmdir(base);
+
+	return rc;
+}
diff --git a/test/test-renameat2.sh b/test/test-renameat2.sh
new file mode 100755
index 0000000..6aa7fbc
--- /dev/null
+++ b/test/test-renameat2.sh
@@ -0,0 +1,11 @@
+#! /bin/sh
+
+# Run with and without ignored paths, matching test-openat coverage.
+
+./test/test-renameat2
+rc=3D$?
+if [ "$rc" -ne 0 ]; then
+	exit "$rc"
+fi
+
+PSEUDO_IGNORE_PATHS=3D/ ./test/test-renameat2
--=20
1.8.3.1


