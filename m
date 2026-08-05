Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377FC55822
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 06:23:02 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34401.1785910982088619792
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 23:23:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LM1SU4SO;
 spf=pass (domain: gmail.com, ip: 209.85.214.175, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d02b4c3601so7604635ad.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 23:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785910981; x=1786515781; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rimp8WitE9zbsIDrFZlsS+wNK/4vZn0uQjicKbM1kPg=;
        b=LM1SU4SO4YgdT+4RhAklR48wwhqcUQSBviHCioWgQlsl37kPB5dWWK7E2VcYuSgXjc
         Ya9pArWWyuIssQGo+NciEG34ef0l+cm99w8o/vNijHHLhwZYD8lzrhxRGhWM0oGt7WcI
         cLfnChXSIotop0kXkr2Y/T5E8pEeYF/SSarBYiwk/if2D5gpshHvuiGfP01qN+CNCqJE
         zgWQKuHogNUiToFqZB2MP9bFVku7OxbrrXTbMZQrvGXtFVeQUFUdO5qgNqGHAFRcRgLu
         i7kUG7YMxmr6gzhB2lRwlQ7/LIjHuTKxNFVaAFddKAbXSkUKZ+W1R06ezVegajO1rcu/
         VPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785910981; x=1786515781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rimp8WitE9zbsIDrFZlsS+wNK/4vZn0uQjicKbM1kPg=;
        b=TqE1FHteYK1DTYea/sUdExn8cbEv+tjelJwd3puzaRkmJg64XIVvdOTQMYwIz29IxD
         q63GyHfSbxrV+kvGUhpFfb1Sl3/JHGpxFrqEJXu2qHVgRRRkYD9cRPrH6VLdN8EMKoqb
         nr22ARhGHa9iI+XQpTt6RCMlO68NGXoWaouRowR2yFhp5cg+sRHlU2tth20ks5Vbl4mT
         /+AAIgQw8rnz6hZKBjTviLZ5ogUJcp28Msl7yQvvmkNC/VSwWlVMbJ5A5w+Lx/n5Xuua
         2YSvNciQO9lEXJITc7KSnwSNtCSxW4YV/ZupqNE73GIUce0W7pQY3ZbY3ArO5uAW7Hym
         ZKFg==
X-Gm-Message-State: AOJu0Yx96K9aQDaKyDirnsgftmci4ppkna8EKRjF2DVPZ0COE/z8Kg2N
	vvsGRTBubGHcDJ66hyXFtap6ZE6hgbGr+VbFRK8UA4cl+qRzM3Gx++nE1WAmyOhV6CQ=
X-Gm-Gg: AR+sD10/jdSDM74a5+pJOLUqKeycfc0U+w3Qx8JtjmfSJ87bFNfvPC/vBE1jKAmDiiO
	Nn/6XUSnWiyajvwxMD/m/bqIcmN50/e3OXtdTpAgrQzNsg1W2KsT+FTbJSzcbrEp/eDd90E9tXz
	j32nXbsWdRB9m/cZBZ+rgEPz2mDNLnWTFOnlW/fruiMjfiCzjjwr+yUaKSskwqTJsdt6MeGRZRg
	W+lQdF2ucORt24/B3wrhFrPqINfqXHkagU+6eYu+a9zJSgkv8gczx8kCCdyLH3qc0/1gD+IQp6E
	rCroFtamgHZZxXyZJCqOB1fw3H3B/Dka+tksUUs42JiEhaPkfBUzeyqLJe3HoNMGQ+syAteMZXw
	cKilY7m6ewypz7DNfk8aiQAFFpDfeErVCeFVb5QjoqZHnrFLVqyY7gsBsRUFhKpK3qRUqL01wWw
	M3qJpJd5u4XJGNHFGvvjV73Mftftz8DUGi7fWmpaNfXVETWCqB45Tfq5nXyYEX
X-Received: by 2002:a17:902:f54a:b0:2d0:cc92:f7ac with SMTP id d9443c01a7336-2d0cc9302b2mr39544995ad.14.1785910981329;
        Tue, 04 Aug 2026 23:23:01 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa492c7fsm14230065ad.43.2026.08.04.23.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 23:23:00 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>,
	Paul Barker <paul@pbarker.dev>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH v3 2/2] tests: Add close_range() test
Date: Wed,  5 Aug 2026 06:22:58 +0000
Message-ID: <20260805062258.7-3-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805062258.7-1-bbnpreetsingh@gmail.com>
References: <92c180949cc82cbd9025c7673c2ffb8a43896fda.camel@linuxfoundation.org>
 <20260805062258.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 06:23:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4629

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


