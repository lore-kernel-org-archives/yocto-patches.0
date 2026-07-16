Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1600FC44511
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 05:56:44 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6531.1784181396597703964
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 22:56:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EP6ZbgPU;
 spf=pass (domain: gmail.com, ip: 209.85.214.176, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceb096e675so55796665ad.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 22:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784181396; x=1784786196; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIxfU2MysL8f6MpK9jdQK0hfsaPk0NjankeRFgRPEUs=;
        b=EP6ZbgPUjv7z9spKieeEz6uyEeLQnbXN980vunVyXfdSz39QqhO5e7if5Aebd48DNm
         1u8kUAoK31Nb407/OVSKzXDBrzJXnooWsTwfWcGcL+4ayH3Ot3xPcrAHOC77nKteGZqO
         +i0yPeHfaM5tnPSMBkcZCzgNgFUn765kOEzlEGyopfSziN6e0V/lBQ76AKGJO7rkgUul
         pWq8/AcXhbs53a+dnCKLY6+lBMfQXisqCZBne4I6JPKvhfUVRLTLRO9YsNEa907RmG3u
         1LYCN9+8j2cCw4smr6jp0N1Mf/btdiUO83zC+Lk2EszxIcP2mX5bQJvZ5wV1h6PC6tpm
         wUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784181396; x=1784786196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIxfU2MysL8f6MpK9jdQK0hfsaPk0NjankeRFgRPEUs=;
        b=mvtwFaNHmgmYkMZwhovViGYt3OxYXpNjpMHw1Fvb+o7EqXoC6YsPQ1XbweW10uypVy
         /IVOUDUexAyhV/A/Oxc10aUeEBtCzhpUrfdzm9G5uq9bipnnrjAMakagkAuGHa2cnszy
         jlz/+GzpPD+dzRvc5FTtcnpsY6WCwmHZE4lLl+dRgUq96DwbEAarROESIttUTgkwtRGg
         mLqOh/C9LIW1gc2qOdYEriGhfOom7IYIp1Ni5VBG3Mrl2pF7iAWGmoa3lysHL3BpY6pp
         D6Nt1X/Fq4D4/Z3FWrd0FkLTVTbebQeK8qNsqRzbII0HvsLIZSjeBjZbD0I9HjS1TGe3
         FHqQ==
X-Gm-Message-State: AOJu0YweYNddb3SDc6THFgD6l2GGJXkeH/NfpbfRo8J83v5DCQEIWSdj
	w/l2noMnFysC2KiINXyDCdMiBNJyLxni/ib5Ug8BdtTFgMzZ1zlvproxNsjKySPj5qQ=
X-Gm-Gg: AfdE7cmw0Cwcpgzzr96y4jWT04qIaVKMDW3tFFNA8hZR6MlEOfdC/pC++cXdlleXhVV
	zmgjZ6WP2aaZB0SE/brpn++47CYn98qoW09j3AHUhhHRz5pWVEYzfaBeJ7VslH4LXBNZjEsykHm
	czJaXXELjAmZmr9Fra7R/p0e6X6eTU3IGdPH7IHYBqf77xVoe9hrggHXf7cFmu3G7MbGyZh9hJZ
	csrA4sq38XPFPGyiDv5j4+kCR3+MAqaoCeZbrbnfDMDeEoEWViOEFc7xvwfIrAmaSGOfzIcgaeY
	lUMyqP/yufPrtV+PR7aOM44lgKXbQ9jZUQ0qg2YSVItIVx4a4//7nLIoaYpC8cNzRIYtdAb1CDp
	r+LsFa0/+qlA+aF7PDoF9awWr46ilhAkDtYCWeGUjQcQPZghHBT0hwoHZsJ7cjrWdhUq2UDMkfp
	x3cA==
X-Received: by 2002:a17:902:ec8e:b0:2ca:ce91:f027 with SMTP id d9443c01a7336-2cf03d37947mr50158105ad.36.1784181395916;
        Wed, 15 Jul 2026 22:56:35 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf100e44ecsm14124585ad.12.2026.07.15.22.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:56:35 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH v2 1/2] ports/linux/guts: Implement close_range() instead of returning ENOSYS
Date: Thu, 16 Jul 2026 05:56:32 +0000
Message-ID: <20260716055633.7-2-bbnpreetsingh@gmail.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4491

The close_range() wrapper added in 35433e6 ("ports/linux/guts: Add
close_range wrapper for glibc 2.34") returns ENOSYS on the assumption
that callers handle that. systemd v260 no longer does: it removed its
/proc/self/fd fallback and treats a close_range() failure as fatal, so
every fork+exec under pseudo aborts:

    Failed to close all file descriptors: Function not implemented
    '(mkfs)' failed with exit status 1.

A client side op closes the low descriptors one at a time, skipping the
ones pseudo needs for itself, and returns the first fd above pseudo's
own so the caller can pass the rest of the range to the kernel directly.

CLOSE_RANGE_UNSHARE is handled by calling unshare(CLONE_FILES) before
closing anything, so the closes only affect the caller and not other
processes sharing the descriptor table. Unknown flags and an inverted
range are rejected with EINVAL before anything is closed.

A range starting entirely above INT_MAX cannot contain any of pseudo's
fds and is also passed straight through.

[YOCTO #16339]

AI-Generated: Uses Claude (claude-opus-4-8)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 enums/op.in                    |  1 +
 ports/linux/guts/close_range.c | 54 ++++++++++++++++++++++++++----
 ports/linux/portdefs.h         | 16 +++++++++
 pseudo_client.c                | 60 ++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 7 deletions(-)

diff --git a/enums/op.in b/enums/op.in
index 5b5e21b..5013892 100644
--- a/enums/op.in
+++ b/enums/op.in
@@ -28,3 +28,4 @@ set-xattr, 0
 create-xattr, 1
 replace-xattr, 1
 closefrom, 0
+close-range, 0
diff --git a/ports/linux/guts/close_range.c b/ports/linux/guts/close_range.c
index 4bd2fe1..c3ca71d 100644
--- a/ports/linux/guts/close_range.c
+++ b/ports/linux/guts/close_range.c
@@ -6,14 +6,54 @@
  * int close_range(unsigned int lowfd, unsigned int maxfd, int flags)
  *      int rc = -1;
  */
+	pseudo_msg_t *msg;
 
-        (void) lowfd;
-        (void) maxfd;
-        (void) flags;
-        /* for now pretend the kernel doesn't support it regardless 
-           which users are supposed to be able to handle */
-        errno = ENOSYS;
-        rc = -1;
+	/* The kernel rejects both of these outright and closes nothing when
+	 * it does, so validate before touching anything.
+	 */
+	if (flags & ~(CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC)) {
+		errno = EINVAL;
+		return -1;
+	}
+	if (lowfd > maxfd) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/* CLOSE_RANGE_UNSHARE has to take effect before anything is closed:
+	 * while the descriptor table is still shared, closing a descriptor
+	 * would close it for everyone sharing the table, not just for us.
+	 */
+	if (flags & CLOSE_RANGE_UNSHARE) {
+		if (unshare(CLONE_FILES) == -1)
+			return -1;
+		flags &= ~CLOSE_RANGE_UNSHARE;
+	}
+
+	/* CLOSE_RANGE_CLOEXEC closes nothing, it only marks descriptors, and
+	 * pseudo's own are close-on-exec already (pseudo_fd() sets that on
+	 * every one of them), so there is nothing here to protect.
+	 */
+	if (flags & CLOSE_RANGE_CLOEXEC)
+		return real_close_range(lowfd, maxfd, flags);
+
+	/* Descriptors are ints, so a range starting above INT_MAX cannot hold
+	 * any of pseudo's own and there is nothing to step around. Worth its
+	 * own case because pseudo_client_op() takes the low end as an int.
+	 */
+	if (lowfd > INT_MAX)
+		return real_close_range(lowfd, maxfd, flags);
+
+	/* Same shape as closefrom(): the client op closes the descriptors its
+	 * own are mixed in with by hand, stepping around the ones pseudo needs
+	 * to keep, and hands back the first fd the kernel can safely be turned
+	 * loose on.
+	 */
+	msg = pseudo_client_op(OP_CLOSE_RANGE, 0, lowfd, -1, 0, 0, maxfd);
+	if (maxfd >= (unsigned int) msg->fd)
+		rc = real_close_range(msg->fd, maxfd, flags);
+	else
+		rc = 0;
 
 /*      return rc;
  * }
diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
index 19bb232..1f1a41a 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -35,6 +35,22 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
 #include <sys/prctl.h>
 #include <linux/seccomp.h>
 
+/* close_range()'s flags, and unshare(), are only declared by glibc under
+ * _GNU_SOURCE, which pseudo does not build with. <linux/close_range.h> is
+ * not an option either: it is absent on hosts with pre-5.9 kernel headers,
+ * the same problem SYS_openat2 has below. Both values are kernel ABI.
+ */
+#ifndef CLOSE_RANGE_UNSHARE
+#define CLOSE_RANGE_UNSHARE (1U << 1)
+#endif
+#ifndef CLOSE_RANGE_CLOEXEC
+#define CLOSE_RANGE_CLOEXEC (1U << 2)
+#endif
+#ifndef CLONE_FILES
+#define CLONE_FILES 0x00000400
+#endif
+extern int unshare(int flags);
+
 #ifndef _STAT_VER
 #if defined (__aarch64__) || defined (__riscv)
 #define _STAT_VER 0
diff --git a/pseudo_client.c b/pseudo_client.c
index 7041366..1acd948 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -993,6 +993,28 @@ pseudo_client_closefrom(int fd) {
 	}
 }
 
+/* Like pseudo_client_closefrom(), but bounded: close_range() has a top end,
+ * so entries above it have to be left alone.
+ */
+static void
+pseudo_client_close_range(int lowfd, unsigned int maxfd) {
+	int i, top;
+
+	if (lowfd < 0 || lowfd >= nfds)
+		return;
+
+	top = (maxfd >= (unsigned int) nfds) ? nfds - 1 : (int) maxfd;
+	for (i = lowfd; i <= top; ++i) {
+		free(fd_paths[i]);
+		fd_paths[i] = 0;
+
+		if (i < linked_nfds) {
+			free(linked_fd_paths[i]);
+			linked_fd_paths[i] = 0;
+		}
+	}
+}
+
 /* spawn server */
 static int
 client_spawn_server(void) {
@@ -1633,6 +1655,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 	static size_t alloced_len = 0;
 	int strip_slash;
 	int startfd, i;
+	unsigned int close_range_maxfd = 0;
 
 #ifdef PSEUDO_PROFILING
 	struct timeval tv1_op, tv2_op;
@@ -1753,6 +1776,13 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 	}
 #endif
 
+	if (op == OP_CLOSE_RANGE) {
+		va_list ap;
+		va_start(ap, buf);
+		close_range_maxfd = va_arg(ap, unsigned int);
+		va_end(ap);
+	}
+
 	if (op == OP_RENAME) {
 		va_list ap;
 		if (!path) {
@@ -1959,6 +1989,36 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 		msg.fd = startfd;
 		do_request = 0;
 		break;
+	case OP_CLOSE_RANGE:
+		/* no request needed */
+		startfd = fd;
+		if (pseudo_util_debug_fd > startfd)
+			startfd = pseudo_util_debug_fd + 1;
+		if (pseudo_localstate_dir_fd > startfd)
+			startfd = pseudo_localstate_dir_fd + 1;
+		if (pseudo_pwd_fd > startfd)
+			startfd = pseudo_pwd_fd + 1;
+		if (pseudo_grp_fd > startfd)
+			startfd = pseudo_grp_fd + 1;
+		if (connect_fd > startfd)
+			startfd = connect_fd + 1;
+		/* the fds below startfd are the ones our own are mixed in
+		 * with, so close those by hand and skip the ones we need
+		 */
+		for (i = fd; i < startfd && (unsigned int) i <= close_range_maxfd; ++i) {
+			if (i == pseudo_util_debug_fd || i == pseudo_localstate_dir_fd || i == pseudo_pwd_fd ||
+					i == pseudo_grp_fd || i == connect_fd)
+				continue;
+			pseudo_client_close(i);
+			close(i);
+		}
+		if (close_range_maxfd >= (unsigned int) startfd)
+			pseudo_client_close_range(startfd, close_range_maxfd);
+		/* tell the caller to start at startfd instead of fd */
+		result = &msg;
+		msg.fd = startfd;
+		do_request = 0;
+		break;
 	case OP_CLOSE:
 		/* no request needed */
 		if (fd >= 0) {
-- 
2.43.0


