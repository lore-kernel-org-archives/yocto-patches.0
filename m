Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D37C44510
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 05:56:44 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6455.1784181397384671808
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 22:56:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=SGbv8SK4;
 spf=pass (domain: gmail.com, ip: 209.85.214.169, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cace91f112so59268195ad.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 22:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784181397; x=1784786197; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rimp8WitE9zbsIDrFZlsS+wNK/4vZn0uQjicKbM1kPg=;
        b=SGbv8SK4DmJZT9xR1Qe5LRret6BESCZTaWIIQ94Jhnl/GqzmbEa9mke9qzf1CyBVin
         hUZvjtrpgdWtUTJOQzrHGzVdDb+WexkS2cS8QzNKOlxG1NfV+zAFfPrXcbU5RWKrZfi0
         BIqjcPTZzamaaB8gJo6jXd3n7dqdfv/48BCu1gonb36UMkt2cXH0kqKYsrwiSfMxUkzm
         JuFH9CIIrIoA8PHCo//qvfhm+msNkq2cxMyJCGMOKClor1IXIpJG5egGqiFNbVfmd8H8
         YqoHlLMzigdjb1LMWJn6E91bj/1BxxEdFWOcwis9AaAlN80wi1n/pd/OILjU0ePzWiKk
         xh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784181397; x=1784786197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rimp8WitE9zbsIDrFZlsS+wNK/4vZn0uQjicKbM1kPg=;
        b=J0ubMlsz5IFeywIJpBgd0dlPFmTO7qeOXkCQvJiVnCVazb8F5ibvvM+mN6EZ3kHF1a
         01UIKMxpBHUdTkOuwpaWjpS0vdnVJmdUuZKvz5w9062APlS4GUzRW7vbhNZ5QCMo8Chg
         l+4br1t634y3O9JxmxYSpLhHYlLC2Cz08RaZGwMJ5Zl2ksajsWgfNV/xWHSYCyZajqdD
         UBkVRZ0i4PWuOE4O0rDbgFEJ4dL6Wi1HWUAuKT/z0OJYRLlDzWzxQ7+asUC0xEdNj+71
         9trVSGrS2eDTuAfXx2o0ZvIUyfAzK14rXlMXCy5xVJPIc06z7nVKJg03Q6mJOfWfs//i
         84OA==
X-Gm-Message-State: AOJu0Yw7PpVecTIX0Ci+50pPdWxb3mWNl/84O36oRgANcdUI33kRO3Em
	MEvbHmoGNrEuD3JN1dx8cwPt4OA3FlDuAQWm82WCSpB5/8OjcIclNmxB8Q4xUXJZZTU=
X-Gm-Gg: AfdE7cnAqEGeawJHqmTnggO3SewQIBas8pXo43yKZknhFmyzeLl3cFBwi4UJvvt/PgZ
	cDEzrHWS3epQRNbbQMudGyWwwuSLAv+7+fH4eXAzFuqlCHN9vnw9AJJmmBjrl8fcPJp1b+qizGP
	aNGrH3X0scvHUQ4IEaN9akJ57OcwIPZITBdL6H9d6vGTMfPBfKeueD/FXmAstl+VB36zZgDBCgF
	YVNdy8J8iw2xXaWu3jNUdIp80XtOSaDCacxeqKD1jGsD6c/ROo/CEPSYOjsTS6ID241aaSNJtUk
	LAZlKpTAtK1AakfMC+qwjLyNRyb3V3dXo1t2Uo6+SAMMzEaZZpuxJi/iP3kEI7eb0Va81Y+ZNqw
	bO/LqVZSIX/qGhUi/TlJnKfxEF3ExKTER4IRrEISHLZoFI+4p+44+Bsu6PoSNjf9zZgylFYCKqr
	a6IQ==
X-Received: by 2002:a17:903:b8e:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2cf03c762e3mr50483315ad.2.1784181396627;
        Wed, 15 Jul 2026 22:56:36 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf100e44ecsm14124585ad.12.2026.07.15.22.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:56:36 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH v2 2/2] tests: Add close_range() test
Date: Thu, 16 Jul 2026 05:56:33 +0000
Message-ID: <20260716055633.7-3-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716055633.7-1-bbnpreetsingh@gmail.com>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
 <20260716055633.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 05:56:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4492

Covers the ENOSYS regression itself, that the wrapper agrees with the
kernel about bad arguments, and the part that actually needs the care:
pseudo keeps its own descriptors in the range, including the connection
to its server, and has to come out of a close_range(3, ~0U, 0) still
tracking ownership.

CLOSE_RANGE_UNSHARE is exercised against a child cloned with
CLONE_FILES: the child closes a shared descriptor with the flag set,
and the parent must still hold that descriptor afterwards, which is
what the wrapper's unshare-before-closing order exists to preserve. A
second child then closes the same descriptor without the flag and the
parent must see it gone.

close_range() needs a 5.9 kernel and CLOSE_RANGE_CLOEXEC a 5.11 one, so
the shell wrapper probes for each with PSEUDO_DISABLED=1 before running.
On 5.9 and 5.10 the syscall probe succeeds, the flag probe fails, and
only the CLOSE_RANGE_CLOEXEC part of the test is left out.

[YOCTO #16339]

AI-Generated: Uses Claude (claude-opus-4-8)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 test/test-close-range.c  | 283 +++++++++++++++++++++++++++++++++++++++
 test/test-close-range.sh |  24 ++++
 2 files changed, 307 insertions(+)
 create mode 100644 test/test-close-range.c
 create mode 100755 test/test-close-range.sh

diff --git a/test/test-close-range.c b/test/test-close-range.c
new file mode 100644
index 0000000..482c85e
--- /dev/null
+++ b/test/test-close-range.c
@@ -0,0 +1,283 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * close_range() was stubbed out to return ENOSYS unconditionally, on the
+ * assumption that callers all cope with that. Current systemd does not: it
+ * dropped its /proc fallback once its kernel baseline reached 5.10, so every
+ * fork+exec under pseudo failed. Check the wrapper works, that it agrees
+ * with the kernel about bad arguments, that CLOSE_RANGE_UNSHARE keeps a
+ * process sharing the descriptor table unaffected, and that pseudo still
+ * functions after a caller closes every descriptor from 3 up.
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+/* <linux/close_range.h> is missing on hosts with pre-5.9 kernel headers */
+#ifndef CLOSE_RANGE_UNSHARE
+#define CLOSE_RANGE_UNSHARE (1U << 1)
+#endif
+#ifndef CLOSE_RANGE_CLOEXEC
+#define CLOSE_RANGE_CLOEXEC (1U << 2)
+#endif
+
+/* matches test-openat2-syscall: the shell wrapper turns 77 into "skipped" */
+#define SKIP 77
+
+#define TESTFILE "test-close-range-file"
+
+static int open_null(void) {
+	int fd = open("/dev/null", O_RDONLY);
+	if (fd < 0)
+		perror("open /dev/null");
+	return fd;
+}
+
+static int is_closed(int fd) {
+	return fcntl(fd, F_GETFD) == -1 && errno == EBADF;
+}
+
+/* Is close_range() there at all? The wrapper runs this with PSEUDO_DISABLED
+ * set, so the answer is the kernel's and a stubbed wrapper cannot pass
+ * itself off as an old kernel.
+ */
+static int probe(void) {
+	int fd = open_null();
+
+	if (fd < 0)
+		return 1;
+	if (close_range(fd, fd, 0) == -1) {
+		int err = errno;
+		close(fd);
+		return (err == ENOSYS) ? SKIP : 1;
+	}
+	return 0;
+}
+
+/* CLOSE_RANGE_CLOEXEC is newer than the syscall: 5.11 rather than 5.9. Probe
+ * for it separately, the same way, so that on a 5.9 or 5.10 kernel only the
+ * CLOSE_RANGE_CLOEXEC part of the test is left out, not the whole thing.
+ */
+static int probe_cloexec(void) {
+	int fd = open_null();
+	int rc;
+
+	if (fd < 0)
+		return 1;
+	rc = close_range(fd, fd, CLOSE_RANGE_CLOEXEC);
+	if (rc == -1) {
+		int err = errno;
+		close(fd);
+		return (err == EINVAL || err == ENOSYS) ? SKIP : 1;
+	}
+	close(fd);
+	return 0;
+}
+
+/* for the CLONE_FILES children: close one descriptor, with or without
+ * CLOSE_RANGE_UNSHARE, and report whether it is gone for the child itself.
+ */
+struct child_close {
+	int fd;
+	int flags;
+};
+
+static char child_stack[65536];
+
+static int child_close_one(void *arg) {
+	struct child_close *cc = arg;
+
+	if (close_range(cc->fd, cc->fd, cc->flags) == -1)
+		return 2;
+	return is_closed(cc->fd) ? 0 : 3;
+}
+
+int main(int argc, char **argv) {
+	struct child_close cc;
+	struct stat st;
+	int a, b, c;
+	int status;
+	int test_cloexec = 1;
+	pid_t pid;
+
+	if (argc > 1 && !strcmp(argv[1], "--probe"))
+		return probe();
+	if (argc > 1 && !strcmp(argv[1], "--probe-cloexec"))
+		return probe_cloexec();
+	if (argc > 1 && !strcmp(argv[1], "--no-cloexec"))
+		test_cloexec = 0;
+
+	/* the reported bug: this used to fail with ENOSYS every time */
+	a = open_null();
+	if (a < 0)
+		return 1;
+	if (close_range(a, a, 0) == -1) {
+		fprintf(stderr, "close_range(%d, %d, 0): %s\n", a, a, strerror(errno));
+		return 1;
+	}
+	if (!is_closed(a)) {
+		fprintf(stderr, "close_range() left fd %d open\n", a);
+		return 1;
+	}
+
+	/* a bounded range closes all of itself */
+	a = open_null();
+	b = open_null();
+	c = open_null();
+	if (a < 0 || b < 0 || c < 0)
+		return 1;
+	if (close_range(a, c, 0) == -1) {
+		perror("close_range(a, c, 0)");
+		return 1;
+	}
+	if (!is_closed(a) || !is_closed(b) || !is_closed(c)) {
+		fprintf(stderr, "close_range(%d, %d, 0) left descriptors open\n", a, c);
+		return 1;
+	}
+
+	/* CLOSE_RANGE_CLOEXEC marks descriptors, it does not close them. The
+	 * flag needs a 5.11 kernel; the shell wrapper passes --no-cloexec
+	 * when the probe says this kernel has the syscall but not the flag.
+	 */
+	if (test_cloexec) {
+		a = open_null();
+		if (a < 0)
+			return 1;
+		if (close_range(a, a, CLOSE_RANGE_CLOEXEC) == -1) {
+			perror("close_range(a, a, CLOSE_RANGE_CLOEXEC)");
+			return 1;
+		}
+		if (is_closed(a)) {
+			fprintf(stderr, "CLOSE_RANGE_CLOEXEC closed fd %d\n", a);
+			return 1;
+		}
+		if (!(fcntl(a, F_GETFD) & FD_CLOEXEC)) {
+			fprintf(stderr, "CLOSE_RANGE_CLOEXEC did not set FD_CLOEXEC on fd %d\n", a);
+			return 1;
+		}
+		close(a);
+	}
+
+	/* bad arguments are refused, and a refused call closes nothing */
+	a = open_null();
+	if (a < 0)
+		return 1;
+	if (close_range(a, a, 0x80) != -1 || errno != EINVAL) {
+		fprintf(stderr, "close_range() with an unknown flag should fail EINVAL\n");
+		return 1;
+	}
+	if (is_closed(a)) {
+		fprintf(stderr, "a rejected close_range() closed fd %d anyway\n", a);
+		return 1;
+	}
+	if (close_range(a + 1, a, 0) != -1 || errno != EINVAL) {
+		fprintf(stderr, "close_range() with lowfd > maxfd should fail EINVAL\n");
+		return 1;
+	}
+	close(a);
+
+	/* a range entirely above INT_MAX holds no descriptors at all, but it
+	 * still has to be accepted rather than mangled on the way through
+	 */
+	if (close_range((unsigned int) INT_MAX + 1, ~0U, 0) == -1) {
+		fprintf(stderr, "close_range(INT_MAX+1, ~0U, 0): %s\n", strerror(errno));
+		return 1;
+	}
+
+	/* CLOSE_RANGE_UNSHARE unshares the descriptor table before closing:
+	 * when a child cloned with CLONE_FILES closes our shared descriptor
+	 * with the flag set, we must still hold that descriptor afterwards.
+	 * This is what the wrapper's unshare-first order preserves; closing
+	 * by hand before unsharing would go through the still-shared table.
+	 */
+	a = open_null();
+	if (a < 0)
+		return 1;
+	cc.fd = a;
+	cc.flags = CLOSE_RANGE_UNSHARE;
+	pid = clone(child_close_one, child_stack + sizeof(child_stack),
+		    CLONE_FILES | SIGCHLD, &cc);
+	if (pid == -1) {
+		perror("clone(CLONE_FILES)");
+		return 1;
+	}
+	if (waitpid(pid, &status, 0) == -1) {
+		perror("waitpid");
+		return 1;
+	}
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+		fprintf(stderr, "CLOSE_RANGE_UNSHARE failed in the child (status %d)\n",
+			status);
+		return 1;
+	}
+	if (is_closed(a)) {
+		fprintf(stderr, "child's CLOSE_RANGE_UNSHARE closed the parent's fd %d\n", a);
+		return 1;
+	}
+
+	/* the control for the test above: the same close without the flag
+	 * happens in the shared table, so this time fd a must be gone for
+	 * us as well. A clone that quietly stopped sharing the table would
+	 * pass the test above no matter what the wrapper did; it fails here
+	 * instead.
+	 */
+	cc.flags = 0;
+	pid = clone(child_close_one, child_stack + sizeof(child_stack),
+		    CLONE_FILES | SIGCHLD, &cc);
+	if (pid == -1) {
+		perror("clone(CLONE_FILES)");
+		return 1;
+	}
+	if (waitpid(pid, &status, 0) == -1) {
+		perror("waitpid");
+		return 1;
+	}
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+		fprintf(stderr, "close_range() failed in the CLONE_FILES child (status %d)\n",
+			status);
+		return 1;
+	}
+	if (!is_closed(a)) {
+		fprintf(stderr, "close in a CLONE_FILES child did not reach the parent's fd %d\n", a);
+		return 1;
+	}
+
+	/* And the point of the care in the wrapper: pseudo keeps descriptors
+	 * of its own in this range and has to come out of it still working.
+	 */
+	a = open(TESTFILE, O_CREAT | O_WRONLY, 0644);
+	if (a < 0) {
+		perror("open " TESTFILE);
+		return 1;
+	}
+	close(a);
+	if (chown(TESTFILE, 0, 0) == -1) {
+		perror("chown " TESTFILE);
+		return 1;
+	}
+	if (close_range(3, ~0U, 0) == -1) {
+		fprintf(stderr, "close_range(3, ~0U, 0): %s\n", strerror(errno));
+		return 1;
+	}
+	if (stat(TESTFILE, &st) == -1) {
+		perror("stat after close_range");
+		return 1;
+	}
+	if (st.st_uid != 0 || st.st_gid != 0) {
+		fprintf(stderr, "pseudo lost track after close_range: uid %d, gid %d\n",
+			(int) st.st_uid, (int) st.st_gid);
+		return 1;
+	}
+	unlink(TESTFILE);
+
+	return 0;
+}
diff --git a/test/test-close-range.sh b/test/test-close-range.sh
new file mode 100755
index 0000000..578102c
--- /dev/null
+++ b/test/test-close-range.sh
@@ -0,0 +1,24 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+
+# close_range() needs a 5.9 kernel. Ask with pseudo out of the way, so that a
+# wrapper which has gone back to returning ENOSYS cannot pass itself off as an
+# old kernel and quietly skip the test it is supposed to fail.
+PSEUDO_DISABLED=1 ./test/test-close-range --probe
+case $? in
+0)  ;;
+77) exit 255 ;;
+*)  exit 1 ;;
+esac
+
+# CLOSE_RANGE_CLOEXEC needs 5.11. On a 5.9 or 5.10 kernel the syscall probe
+# above succeeds but the flag does not exist yet, so probe for it the same
+# way and leave only the CLOSE_RANGE_CLOEXEC part of the test out.
+PSEUDO_DISABLED=1 ./test/test-close-range --probe-cloexec
+case $? in
+0)  ./test/test-close-range ;;
+77) ./test/test-close-range --no-cloexec ;;
+*)  exit 1 ;;
+esac
-- 
2.43.0


