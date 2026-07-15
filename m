Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582ECC44508
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 09:06:46 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.480.1784094105435895567
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Jul 2026 22:41:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Li5difgn;
 spf=pass (domain: gmail.com, ip: 209.85.210.177, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845c92bc464so1684581b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Jul 2026 22:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784094105; x=1784698905; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MfFuRyPRnk8cGj7U0aOW5yv28tMt3ff4BwJD3L/xOg=;
        b=Li5difgn3vChBNBbtPNtK9Fmmen0upfPzsYKks30HrFcxmd4Mk9kjuAWEUehvl8voc
         tfYBV7dr6112Vn90pVf8s3UII/fvM1/y/QJ1Jl8W0pQf2x0+ZyM4pZng9echjs4YY0jc
         cDwlW9F3Qy0AaX+yTgVTnwGGnK+esMhSLoWv/QqBNpb4jneC9hnry9EhGVJi+od0JxBe
         hAw6rvOR3ZcpkiQnoU63pLG/n0/exMRWN8TB1Y2ryvyDOMkQhfmDhPq5VMB3pRKrIsPK
         r2wJde2X9H+sIMS/jDrUkomdmhJHRGgUvis/dpEXQmbbEbz8P8XtlYXSbUXr6gmhuX8X
         mgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094105; x=1784698905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6MfFuRyPRnk8cGj7U0aOW5yv28tMt3ff4BwJD3L/xOg=;
        b=F/4IusP8VErYwD2CztTsXQaq8kl6rd5IDuDi4XYS6sWnNOGkyqOhSzHlzAzW2xIDN0
         E8WM7CzOt5I1rOwhQTgUUp7Lzg9rfk1vC6Aqgm0EX/QApwKhkB5LiaFNhYFrb+Q+dGtJ
         7xX/jCkKene+DkaV8kyriWlFdQiDMdPSeGflQvLgs8BbOe0dhLfxR3XDMYS61px3Z2pA
         JZn3n9FhJ3dtO35zqtyyANfKTeo6Fd8j8bNZXN7kfIYqLCPGJDBAfEkCOjGtxLV1R/uZ
         VWfa9JDnAUsoBW2m5YhC0Xp0ed/A60u2iBGsEPm6wCTZufWO931U9YQsZeHucTFvoEMA
         6cAA==
X-Gm-Message-State: AOJu0YwCI6GH3sKaipEYxXIufW8FUbM5rzhxKsosqvB6eiVQwoWoeAEl
	Rs190tVnce/wQskJ4kmjJWjVn7mFWN1DyROOywd8GNcaiZDfdFkdg/jhnkYntpHd6mM=
X-Gm-Gg: AfdE7cn/ZmK+dDVo4AL4WQCV5bTyYgwi9nKjW/dpWCI5M1nTGhL6wPzLqcUcCVT5Df/
	Sj7o9xl0PI3Q8eS8t/ed+TjIIBCxeW7PB2i5vdSnCTu6oB3uE9djvOHRm67YusxL72Im4QiMIwR
	8DdmPwSyjfmxByM0eCjcQbhb7DxL8YIAks3nXUbsMDLZiKbHql4hfLsCix55hNiwsv0xJheIG9u
	ZcQmdazUo+XC49FjBGvrVNDADmnwQIlI7l1rvdDkRRho7twBqClyC87DHkHpkR+epQPlU5/IYmr
	q1cmz4oAVBi9kTIkwLctf8hGzEIVE1Aq9NiWf2MbAUoJotNl3RjlPuGZFidU5sMx31gx6KOZWPl
	K6rfzILh7xv25wRoJEBuVa3lB5bnbodtina9+QrNTUY10KXLD4BlxyuX9MomeNIqE3WEhtDMq1q
	lWi2CmVfnE99jX
X-Received: by 2002:a05:6a00:1741:b0:845:e1a3:107e with SMTP id d2e1a72fcca58-848896eb340mr15376983b3a.52.1784094104673;
        Tue, 14 Jul 2026 22:41:44 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f264989sm2550668b3a.13.2026.07.14.22.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:41:44 -0700 (PDT)
From: "Baban" <bbnpreetsingh@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Mark Hatle <mark.hatle@amd.com>,
	Randy MacLeod <randy.macleod@windriver.com>,
	Vincent Haupert <mail@vincent-haupert.de>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [pseudo] [PATCH 1/2] ports/linux/guts: Implement close_range() instead of returning ENOSYS
Date: Wed, 15 Jul 2026 05:41:41 +0000
Message-ID: <20260715054142.7-2-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715054142.7-1-bbnpreetsingh@gmail.com>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 09:06:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4479

close_range() has been wrapped since 35433e6 ("ports/linux/guts: Add
close_range wrapper for glibc 2.34"), but the wrapper only sets ENOSYS,
on the grounds that callers have to handle that anyway. That was true
when it was written. It no longer is: systemd's close_all_fds() has used
close_range() since v247, and v260 raised its kernel baseline to 5.10,
dropped the /proc fallback and began treating a failure as fatal.
safe_fork_full() aborts the child when it fails, so under pseudo every
fork+exec dies, eg for "pseudo systemd-repart" spawning mkfs:

    Failed to close all file descriptors: Function not implemented
    '(mkfs)' failed with exit status 1.

Implement it the way closefrom() already is, per 21ff2fb ("ports/linux/
guts: Add closefrom support for glibc 2.34"): a client side op works out
the first fd above every descriptor pseudo keeps for itself, closes the
ones below it by hand while stepping around its own, and hands that fd
back so the caller can turn the kernel loose on the rest. close_range()
has a top end where closefrom() does not, so both the manual loop and
the path table cleanup are bounded by maxfd.

The flags are dealt with before any of that. CLOSE_RANGE_UNSHARE has to
take effect first, or descriptors would be closed for everyone still
sharing the table rather than just for us. CLOSE_RANGE_CLOEXEC closes
nothing, and pseudo's own fds are close-on-exec already, so there is
nothing to protect and it can go straight to the kernel. An unknown flag
or an inverted range is refused before anything is touched, matching the
kernel: otherwise a call which should have failed cleanly takes
descriptors with it on the way out.

A range starting above INT_MAX cannot hold any of pseudo's own fds and
is passed through, since the client op takes the low end as an int.

[YOCTO #16339]

AI-Generated: Uses Claude (claude-opus-4-8)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 enums/op.in                    |  1 +
 ports/linux/guts/close_range.c | 55 +++++++++++++++++++++++++++----
 ports/linux/portdefs.h         | 16 +++++++++
 pseudo_client.c                | 60 ++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 7 deletions(-)

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
index 4bd2fe1..15258be 100644
--- a/ports/linux/guts/close_range.c
+++ b/ports/linux/guts/close_range.c
@@ -6,14 +6,55 @@
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
+	/* The kernel rejects both of these outright, so check before doing
+	 * anything: otherwise a call which should have failed cleanly takes
+	 * descriptors with it on the way out.
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


