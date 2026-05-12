Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BF1CD343F
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 22:20:51 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.611.1778624448031393954
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 May 2026 15:20:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 64CMKiEx1619785;
	Tue, 12 May 2026 17:20:46 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev,
        changqing.li@windriver.com
Cc: richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 2/5] tests: Add mv then hardlink testing
Date: Tue, 12 May 2026 17:20:40 -0500
Message-Id: <1778624443-20857-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1778624443-20857-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 May 2026 22:20:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3975

From: Mark Hatle <mark.hatle@amd.com>

Per the discussion:
   https://lists.openembedded.org/g/openembedded-core/topic/119214074#msg236712

Changqing Li found an issue with renameat (mv) from an ignored to an
included path was not updating the database properly.  This could lead
to an abort, but would definitely cause the new file/symlink to have
the wrong (in pseudo terms) uid/gid.

The test-mv-hardlink.sh is an attempt to implement the test case
suggested by Paul Barker.  It was noted that both rename and renameat
may suffer from the same issue, so additional test cases for each
implementation was added as well.

AI-Generated: Implemented with the assistance of github CoPilot (Claude Opus 4.6)

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 test/test-mv-hardlink.sh       |  52 +++++++++++++++++++++
 test/test-rename-hardlink.c    |  87 +++++++++++++++++++++++++++++++++++
 test/test-rename-hardlink.sh   |  14 ++++++
 test/test-renameat-hardlink.c  | 101 +++++++++++++++++++++++++++++++++++++++++
 test/test-renameat-hardlink.sh |  14 ++++++
 5 files changed, 268 insertions(+)
 create mode 100755 test/test-mv-hardlink.sh
 create mode 100644 test/test-rename-hardlink.c
 create mode 100755 test/test-rename-hardlink.sh
 create mode 100644 test/test-renameat-hardlink.c
 create mode 100755 test/test-renameat-hardlink.sh

diff --git a/test/test-mv-hardlink.sh b/test/test-mv-hardlink.sh
new file mode 100755
index 0000000..2963ef3
--- /dev/null
+++ b/test/test-mv-hardlink.sh
@@ -0,0 +1,52 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# Test that rename (mv) from outside PSEUDO_INCLUDE_PATHS followed by
+# hardlink properly tracks file ownership.
+#
+# Reproduces: https://lists.openembedded.org/g/openembedded-core/message/236712
+#
+# In Yocto, files are often moved from ${B} (build dir, outside
+# PSEUDO_INCLUDE_PATHS) to ${D} (image dir, tracked by pseudo) and
+# then hardlinked. If pseudo doesn't track the rename, the hardlink
+# gets recorded with the real UID, causing inconsistent ownership
+# and pseudo abort on subsequent stat.
+
+# Create two directories:
+#   srcdir  - simulates ${B}, outside PSEUDO_INCLUDE_PATHS
+#   destdir - simulates ${D}, inside PSEUDO_INCLUDE_PATHS
+# Use realpath to resolve symlinks, since pseudo canonicalizes paths
+# internally and the PSEUDO_INCLUDE_PATHS prefix must match.
+srcdir=$(mktemp -d "$(realpath "${PWD}")/mv_hl_src_XXXXXX")
+destdir=$(mktemp -d "$(realpath "${PWD}")/mv_hl_dest_XXXXXX")
+trap "rm -rf '$srcdir' '$destdir'" EXIT
+
+# Restrict pseudo tracking to only destdir
+export PSEUDO_INCLUDE_PATHS="$destdir"
+
+echo hello > ${srcdir}/hello.txt
+
+mv ${srcdir}/hello.txt ${destdir}/hello.txt
+ln ${destdir}/hello.txt ${destdir}/hello2.txt
+
+# Both files should report uid 0 under pseudo
+dest_uid=$(\ls -n1 ${destdir}/hello.txt | awk '{ print $3 }')
+link_uid=$(\ls -n1 ${destdir}/hello2.txt | awk '{ print $3 }')
+
+if [ "$dest_uid" != "0" ]; then
+    echo "FAIL: dest uid is $dest_uid, expected 0"
+    exit 1
+fi
+
+if [ "$link_uid" != "0" ]; then
+    echo "FAIL: link uid is $link_uid, expected 0"
+    exit 1
+fi
+
+if [ "$dest_uid" != "$link_uid" ]; then
+    echo "FAIL: UIDs don't match (dest=$dest_uid, link=$link_uid)"
+    exit 1
+fi
+
+exit 0
diff --git a/test/test-rename-hardlink.c b/test/test-rename-hardlink.c
new file mode 100644
index 0000000..d3f7384
--- /dev/null
+++ b/test/test-rename-hardlink.c
@@ -0,0 +1,87 @@
+/*
+ * Test that rename() from outside PSEUDO_INCLUDE_PATHS followed by
+ * hardlink properly tracks file ownership.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ */
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <limits.h>
+
+static int failures = 0;
+
+static void check(const char *desc, int condition) {
+	if (!condition) {
+		fprintf(stderr, "FAIL: %s\n", desc);
+		failures++;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct stat st1, st2;
+	char src_path[PATH_MAX];
+	char dest_path[PATH_MAX];
+	char link_path[PATH_MAX];
+	int fd;
+
+	if (argc != 3) {
+		fprintf(stderr, "Usage: %s <src_dir> <dest_dir>\n", argv[0]);
+		return 1;
+	}
+
+	/* Create a file in src_dir (outside PSEUDO_INCLUDE_PATHS) */
+	snprintf(src_path, sizeof(src_path), "%s/testfile.txt", argv[1]);
+	fd = open(src_path, O_CREAT | O_WRONLY, 0644);
+	if (fd < 0) {
+		perror("create source file");
+		return 1;
+	}
+	if (write(fd, "hello\n", 6) != 6) {
+		perror("write");
+		close(fd);
+		return 1;
+	}
+	close(fd);
+
+	/* rename() from untracked src_dir to tracked dest_dir */
+	snprintf(dest_path, sizeof(dest_path), "%s/testfile.txt", argv[2]);
+	if (rename(src_path, dest_path) != 0) {
+		perror("rename");
+		return 1;
+	}
+
+	/* Create a hardlink in the tracked directory */
+	snprintf(link_path, sizeof(link_path), "%s/testfile2.txt", argv[2]);
+	if (link(dest_path, link_path) != 0) {
+		perror("link");
+		return 1;
+	}
+
+	/* Stat both files and verify consistent uid 0 */
+	if (stat(dest_path, &st1) != 0) {
+		perror("stat dest");
+		return 1;
+	}
+	if (stat(link_path, &st2) != 0) {
+		perror("stat link");
+		return 1;
+	}
+
+	check("same inode", st1.st_ino == st2.st_ino);
+	check("UIDs match", st1.st_uid == st2.st_uid);
+	check("dest uid is 0", st1.st_uid == 0);
+	check("link uid is 0", st2.st_uid == 0);
+
+	unlink(link_path);
+	unlink(dest_path);
+
+	return failures;
+}
diff --git a/test/test-rename-hardlink.sh b/test/test-rename-hardlink.sh
new file mode 100755
index 0000000..8f2be60
--- /dev/null
+++ b/test/test-rename-hardlink.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# Test that rename() from outside PSEUDO_INCLUDE_PATHS followed by
+# hardlink properly tracks file ownership.
+
+srcdir=$(mktemp -d "$(realpath "${PWD}")/ren_hl_src_XXXXXX")
+destdir=$(mktemp -d "$(realpath "${PWD}")/ren_hl_dest_XXXXXX")
+trap "rm -rf '$srcdir' '$destdir'" EXIT
+
+export PSEUDO_INCLUDE_PATHS="$destdir"
+
+./test/test-rename-hardlink "$srcdir" "$destdir"
diff --git a/test/test-renameat-hardlink.c b/test/test-renameat-hardlink.c
new file mode 100644
index 0000000..9c4840c
--- /dev/null
+++ b/test/test-renameat-hardlink.c
@@ -0,0 +1,101 @@
+/*
+ * Test that renameat() from outside PSEUDO_INCLUDE_PATHS followed by
+ * hardlink properly tracks file ownership.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ */
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <limits.h>
+
+static int failures = 0;
+
+static void check(const char *desc, int condition) {
+	if (!condition) {
+		fprintf(stderr, "FAIL: %s\n", desc);
+		failures++;
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct stat st1, st2;
+	char dest_path[PATH_MAX];
+	char link_path[PATH_MAX];
+	int fd, olddirfd, newdirfd;
+
+	if (argc != 3) {
+		fprintf(stderr, "Usage: %s <src_dir> <dest_dir>\n", argv[0]);
+		return 1;
+	}
+
+	/* Open directory fds for renameat */
+	olddirfd = open(argv[1], O_RDONLY | O_DIRECTORY);
+	if (olddirfd < 0) {
+		perror("open src_dir");
+		return 1;
+	}
+	newdirfd = open(argv[2], O_RDONLY | O_DIRECTORY);
+	if (newdirfd < 0) {
+		perror("open dest_dir");
+		close(olddirfd);
+		return 1;
+	}
+
+	/* Create a file in src_dir (outside PSEUDO_INCLUDE_PATHS) */
+	fd = openat(olddirfd, "testfile.txt", O_CREAT | O_WRONLY, 0644);
+	if (fd < 0) {
+		perror("create source file");
+		return 1;
+	}
+	if (write(fd, "hello\n", 6) != 6) {
+		perror("write");
+		close(fd);
+		return 1;
+	}
+	close(fd);
+
+	/* renameat() from untracked src_dir to tracked dest_dir */
+	if (renameat(olddirfd, "testfile.txt", newdirfd, "testfile.txt") != 0) {
+		perror("renameat");
+		return 1;
+	}
+
+	/* Create a hardlink using linkat in the tracked directory */
+	if (linkat(newdirfd, "testfile.txt", newdirfd, "testfile2.txt", 0) != 0) {
+		perror("linkat");
+		return 1;
+	}
+
+	/* Stat both files and verify consistent uid 0 */
+	snprintf(dest_path, sizeof(dest_path), "%s/testfile.txt", argv[2]);
+	snprintf(link_path, sizeof(link_path), "%s/testfile2.txt", argv[2]);
+
+	if (stat(dest_path, &st1) != 0) {
+		perror("stat dest");
+		return 1;
+	}
+	if (stat(link_path, &st2) != 0) {
+		perror("stat link");
+		return 1;
+	}
+
+	check("same inode", st1.st_ino == st2.st_ino);
+	check("UIDs match", st1.st_uid == st2.st_uid);
+	check("dest uid is 0", st1.st_uid == 0);
+	check("link uid is 0", st2.st_uid == 0);
+
+	unlinkat(newdirfd, "testfile2.txt", 0);
+	unlinkat(newdirfd, "testfile.txt", 0);
+	close(olddirfd);
+	close(newdirfd);
+
+	return failures;
+}
diff --git a/test/test-renameat-hardlink.sh b/test/test-renameat-hardlink.sh
new file mode 100755
index 0000000..b7e3a9e
--- /dev/null
+++ b/test/test-renameat-hardlink.sh
@@ -0,0 +1,14 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# Test that renameat() from outside PSEUDO_INCLUDE_PATHS followed by
+# hardlink properly tracks file ownership.
+
+srcdir=$(mktemp -d "$(realpath "${PWD}")/renat_hl_src_XXXXXX")
+destdir=$(mktemp -d "$(realpath "${PWD}")/renat_hl_dest_XXXXXX")
+trap "rm -rf '$srcdir' '$destdir'" EXIT
+
+export PSEUDO_INCLUDE_PATHS="$destdir"
+
+./test/test-renameat-hardlink "$srcdir" "$destdir"
-- 
1.8.3.1


