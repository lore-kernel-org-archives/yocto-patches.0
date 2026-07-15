Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F760C44507
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 09:06:36 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.481.1784094106041579388
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Jul 2026 22:41:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cleeu0Z6;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8487b7b4066so5010744b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 22:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784094105; x=1784698905; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1HmKLCW9+ZXJqHBltPu8fin/Ezulz9iFCmh7iTNMcqw=;
        b=cleeu0Z66lBOgnAQS+rzJAFyPyu38BkVB/GB1scHTqIQLJIdeC2wH+SKQBW8qLFQ/n
         dDo+dBb9IHVnMfky4T1ayGv8W6K4esLI8cA0SaW0XpT3rXENAThMi6Rz76BK94UWz0lo
         DDI/zLQAUOx3Ql9DpK24Rd3cQ6WMWvH/8V4r8fOEHRt/j8C9H1VeRCYiTqvQa7J1O6Fo
         euNId8Qp4kJP2Uti1YqFK6+cvJGtvFaeolEcmDxORxxQl9SOPq92F4cBOR3y9nyQUZwS
         NZJW3LljT2PaIoktMwIXhn4KhN/Q+MpW05wUNE8zgK/eHu7gIV6zd/toEmBqLKBxHCV2
         CgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094105; x=1784698905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1HmKLCW9+ZXJqHBltPu8fin/Ezulz9iFCmh7iTNMcqw=;
        b=qrL1wK4GHbpyfsBmDobu4dvwVvg7Q60JlVj2eZEJKNrulJtPEgw8yOZq3+WYSZDdd0
         5LQIC/WH4nMmauxCRPOb5UpVx0F2+sUYm0qxbFU7SDIQ960GAOH4IQ/2JmEPCViGETxg
         guuA7hKcv2eqruHkdXufwOad6LoupvImkFH3/n+Bh/p3wSb4MFxj2InPYmXyZ3W6j3It
         Q85PXSyqmPqbJgzUAo6f+wJoWDNBL1Dlit9cl0qg4dLFyjeemwZB29p18IGKQtMaT/Ca
         5ui/qKHkctJa7E2pwWG8wAgYqEMe7M2FTsrLoBsuh11FkaAbrZ6TRy7AUPrdzKPH245y
         gJUQ==
X-Gm-Message-State: AOJu0Yx5dTISUWNdD5tpDhSHYVHJ6F5un4uvt1YqtbwKgXqkOEYLTQua
	/8iKLrSZzk9RXgD48g27GH236fycsSETHV79A2BohWzK/dqT9cMwZIj99t2xsaKhMJ4=
X-Gm-Gg: AfdE7cnblUR7WEaJURZiVx1KqamtSQkkCFxsS7E16zIlPrltMXt16xN0+PPWmONr2CF
	G9FSRCIMu9FNf9Ot+CBJ/8M4xKiTPZUPj/YK3gJfe3oMQ9vdAO5W2M03waZRAdp/vnDQDKFw7+E
	0HIYNiq62wRwY//xI65Cz6SpRUruuBwDBrPGSBkSR9FyPEUJQmW6dKUx5v7kbEB1jVIFuiVT8WV
	SqFXsMrqqdO7NgK6LRRMPyH5PU1HvB4vwv8CzABJxZR09nlbwv5L5cjv91Xmy7b+oBnBGwFWswa
	qmDloJZre3BRRBndyIyX2s1NyD4S+WqQafjkXZnJymJCw08cqqIbR3xLYCqVgJEhyoqcwQTWdbf
	I9LJ588xLD/n5DjyIV59Flf4GSk27G1VvYN5Kd67pJKiXLzFdTfKTLBlGBLbLDpIMTKwWF4ew0C
	qRnGpnRDrbXAoh
X-Received: by 2002:aa7:8891:0:b0:847:b2e4:9f68 with SMTP id d2e1a72fcca58-84a671da3aamr1125803b3a.9.1784094105303;
        Tue, 14 Jul 2026 22:41:45 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f264989sm2550668b3a.13.2026.07.14.22.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:41:45 -0700 (PDT)
From: "Baban" <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH 2/2] tests: Add close_range() test
Date: Wed, 15 Jul 2026 05:41:42 +0000
Message-ID: <20260715054142.7-3-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715054142.7-1-bbnpreetsingh@gmail.com>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 09:06:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4477

Covers the ENOSYS regression itself, that the wrapper agrees with the
kernel about bad arguments, and the part that actually needs the care:
pseudo keeps its own descriptors in the range, including the connection
to its server, and has to come out of a close_range(3, ~0U, 0) still
tracking ownership.

close_range() needs a 5.9 kernel, so the shell wrapper probes for it
with PSEUDO_DISABLED=1 before running anything. Asking with pseudo out
of the way keeps a wrapper which has gone back to returning ENOSYS from
passing itself off as an old kernel and quietly skipping the test it is
supposed to fail.

[YOCTO #16339]

AI-Generated: Uses Claude (claude-opus-4-8)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 test/test-close-range.c  | 167 +++++++++++++++++++++++++++++++++++++++
 test/test-close-range.sh |  16 ++++
 2 files changed, 183 insertions(+)
 create mode 100644 test/test-close-range.c
 create mode 100755 test/test-close-range.sh

diff --git a/test/test-close-range.c b/test/test-close-range.c
new file mode 100644
index 0000000..61f729b
--- /dev/null
+++ b/test/test-close-range.c
@@ -0,0 +1,167 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * close_range() was stubbed out to return ENOSYS unconditionally, on the
+ * assumption that callers all cope with that. Current systemd does not: it
+ * dropped its /proc fallback once its kernel baseline reached 5.10, so every
+ * fork+exec under pseudo failed. Check the wrapper works, that it agrees
+ * with the kernel about bad arguments, and that pseudo still functions after
+ * a caller closes every descriptor from 3 up.
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+/* <linux/close_range.h> is missing on hosts with pre-5.9 kernel headers */
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
+int main(int argc, char **argv) {
+	struct stat st;
+	int a, b, c;
+
+	if (argc > 1 && !strcmp(argv[1], "--probe"))
+		return probe();
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
+	/* CLOSE_RANGE_CLOEXEC marks descriptors, it does not close them */
+	a = open_null();
+	if (a < 0)
+		return 1;
+	if (close_range(a, a, CLOSE_RANGE_CLOEXEC) == -1) {
+		perror("close_range(a, a, CLOSE_RANGE_CLOEXEC)");
+		return 1;
+	}
+	if (is_closed(a)) {
+		fprintf(stderr, "CLOSE_RANGE_CLOEXEC closed fd %d\n", a);
+		return 1;
+	}
+	if (!(fcntl(a, F_GETFD) & FD_CLOEXEC)) {
+		fprintf(stderr, "CLOSE_RANGE_CLOEXEC did not set FD_CLOEXEC on fd %d\n", a);
+		return 1;
+	}
+	close(a);
+
+	/* bad arguments are refused, and nothing is closed on the way out */
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
index 0000000..65be016
--- /dev/null
+++ b/test/test-close-range.sh
@@ -0,0 +1,16 @@
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
+./test/test-close-range
-- 
2.43.0


