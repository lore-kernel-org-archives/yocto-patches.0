Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F379C55174
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 06:23:02 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34439.1785910981339098785
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 23:23:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WCE/4IJ/;
 spf=pass (domain: gmail.com, ip: 209.85.214.178, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc61541f8cso21583865ad.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 23:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785910981; x=1786515781; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vra5moo9/2Fsl9bnt8G0H2qZNz8OefuPkZ2/FI2SGkk=;
        b=WCE/4IJ/X8G3p+hNK04j587yYvlHnyAEJTJqh55N3R1gNMcA35Fs2qpzJEDAXggi9Y
         WZs2UjTmqyvAw7nphZfpi4AUInnoCrk9ZK4c1/NdAZHvY2bdIAMAaHiyFEYVbwepVbD+
         6HievGcJUXx3yHgGDPkoyLQ5ap7NfELZvUpp9qu2qSwXFfI/bfQHAQe8JYz259jc2mzP
         Syb5A7dbwSpaYKH8ucd5J1JTPvupuXbQHqLWlmjpv2UV4H1OP2Bd4JzlzQHILIOHi71C
         MmhzYlcMe6u6JD45OKxtO6l5y2cjuHkUhqRCtw/anubJyUtb9bumS1EhD8srbUUz8f4Z
         bkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785910981; x=1786515781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vra5moo9/2Fsl9bnt8G0H2qZNz8OefuPkZ2/FI2SGkk=;
        b=UkpPLyTfDISSaIqKDk5VvRmQMMKDzP47Q42YDdy0Q4i/fW9hrfqdRyMAvVr1VVLBSE
         mwZFg7U64cFbaob4/JJarq7xEYD+pqcfCiIG5HEwaavVffzyyQ5tLfr66M1BNHv7kKud
         EwbUVDGMqQnh5LpD6bIIjvplLmc9hsqSTPB39OfiGzRa5HcVkDlNtd2jzIRxIiCVNbnE
         AclCaZz1B3Y+tEVEIlRD10mppj9jzXxNOPcBpGHd4FZhr1I8tKMk6vaU8udWtvQcZ/t2
         gtJSWir2h0dqdmV2OdoZA2cqKzVQLkQ82rDKuXjZKpmwgqaVAz57VAT/dhwDBB4kuipC
         Ddhg==
X-Gm-Message-State: AOJu0Ywn8cyncmC83AR7OMF6eOh1+DVOLURsjmefsekawEW9S5kJxRDc
	tsvyvRDbOLn6qzi1UlUrh9b7F9vu5+jG0DRDCMZtJdkn1zg2c8v1dVuYo8o7HWTgSpM=
X-Gm-Gg: AR+sD13BHQ1iu5QpWfWy/9LtDYgAqRJLrqYJqgZyY9eBCOYeClMQlT7X3NjlMkaD+Bv
	ykwrqbdf/kJp7o7nKcHwNmxLktCwZlQl2LZ2RwbsJdf/K7w0+kK2zaQEXLD+eYXFQ3CajD/T6vF
	9MbTaw52kkh6aakCpigq6mm77WSdZ2OKRvpdliTlt2LRZCIhgG1Ej9ZPSHCrn+gKKTt715v3JDn
	6DzNB1Rwd9NWLyTjMNTcdB0FPwcmb7rBOZmbDPZXNAqA71TDxruDsRJlSMYtLau1n0z1zhXDqw5
	yYNAeL+2JxTb05H9vRrheFjmuGkU7jIrbV56HRRcg894tmVaBYmKHJSF/ZJrBnAcgOdwG3uqPws
	EHL7b/Z/2oo8Q63t3bS1HrH/bpCd7Foku048fGD7ZLZMv7mbGUeXMH3gZXr/bTy3JrqVKGDFnwv
	muL7/A67UGjHGJjpEXyWn2sDgIZHWUPodZvdYV9vitlWbp7E/+I0YzjjOs5rii
X-Received: by 2002:a17:902:c952:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2d088e888d6mr97083135ad.0.1785910980500;
        Tue, 04 Aug 2026 23:23:00 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa492c7fsm14230065ad.43.2026.08.04.23.22.59
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
Subject: [pseudo] [PATCH v3 1/2] ports/linux/guts: Implement close_range() instead of returning ENOSYS
Date: Wed,  5 Aug 2026 06:22:57 +0000
Message-ID: <20260805062258.7-2-bbnpreetsingh@gmail.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4628

close_range() runs through a client side op, OP_CLOSE_RANGE. The op closes
the descriptors below pseudo's own one at a time, skipping the ones pseudo
keeps, clears the tracked paths across the range, and returns the first
descriptor above pseudo's own so the caller can hand the rest of the range
to the kernel.

closefrom() uses the same op, with INT_MAX as the maximum.

Unknown flags and a lowfd above maxfd return EINVAL before anything is
closed. CLOSE_RANGE_UNSHARE unshares the descriptor table first, so the
closes do not reach other processes sharing it. CLOSE_RANGE_CLOEXEC and a
range starting above INT_MAX go straight to the kernel. A maxfd above
INT_MAX is clamped for the op; the kernel still gets the caller's maxfd.

[YOCTO #16339]

[RP: Various tweaks for type conversion and path handling]
AI-Generated: Uses Claude (claude-opus-4-8)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 enums/op.in                    |  2 +-
 ports/linux/guts/close_range.c | 59 ++++++++++++++++++++++++++++++----
 ports/linux/guts/closefrom.c   |  3 +-
 ports/linux/portdefs.h         | 16 +++++++++
 pseudo_client.c                | 38 ++++++++++++++++------
 5 files changed, 99 insertions(+), 19 deletions(-)

diff --git a/enums/op.in b/enums/op.in
index 5b5e21b..5854b74 100644
--- a/enums/op.in
+++ b/enums/op.in
@@ -27,4 +27,4 @@ remove-xattr, 1
 set-xattr, 0
 create-xattr, 1
 replace-xattr, 1
-closefrom, 0
+close-range, 0
diff --git a/ports/linux/guts/close_range.c b/ports/linux/guts/close_range.c
index 4bd2fe1..1964c70 100644
--- a/ports/linux/guts/close_range.c
+++ b/ports/linux/guts/close_range.c
@@ -6,14 +6,59 @@
  * int close_range(unsigned int lowfd, unsigned int maxfd, int flags)
  *      int rc = -1;
  */
+	pseudo_msg_t *msg;
+	int maxintfd;
 
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
+	if (maxfd > INT_MAX)
+		maxintfd = INT_MAX;
+	else
+		maxintfd = (int) maxfd;
+
+	/* The op closefrom() also goes through: it closes the descriptors
+	 * pseudo's own are mixed in with by hand, stepping around the ones
+	 * pseudo needs to keep, and hands back the first fd the kernel can
+	 * safely be turned loose on.
+	 */
+	msg = pseudo_client_op(OP_CLOSE_RANGE, 0, lowfd, -1, 0, 0, maxintfd);
+	if (maxfd >= (unsigned int) msg->fd)
+		rc = real_close_range(msg->fd, maxfd, flags);
+	else
+		rc = 0;
 
 /*      return rc;
  * }
diff --git a/ports/linux/guts/closefrom.c b/ports/linux/guts/closefrom.c
index 1350506..7d5df31 100644
--- a/ports/linux/guts/closefrom.c
+++ b/ports/linux/guts/closefrom.c
@@ -7,7 +7,8 @@
  */
  	pseudo_msg_t *msg;
 	/* this cleans up internal tables, and shouldn't make it to the server. Avoids pseudo's internal fds */
-	msg = pseudo_client_op(OP_CLOSEFROM, 0, fd, -1, 0, 0);
+	/* closefrom() has no top end, so the range op gets the highest fd there can be */
+	msg = pseudo_client_op(OP_CLOSE_RANGE, 0, fd, -1, 0, 0, INT_MAX);
 	/* fds between fd and msg->fd are closed within the above function avoiding pseudo's own fds */
 	real_closefrom(msg->fd);
 
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
index 6a7fef7..d83175e 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -950,13 +950,19 @@ pseudo_client_close(int fd) {
 	}
 }
 
+/* Drop the tracked paths for a range of descriptors. The range has a top
+ * end, so entries above it have to be left alone; closefrom() asks for
+ * everything by passing INT_MAX.
+ */
 static void
-pseudo_client_closefrom(int fd) {
-	int i;
-	if (fd < 0 || fd >= nfds)
+pseudo_client_close_range(int lowfd, unsigned int maxfd) {
+	int i, top;
+
+	if (lowfd < 0 || lowfd >= nfds)
 		return;
 
-	for (i = fd; i < nfds; ++i) {
+	top = (maxfd >= (unsigned int) nfds) ? nfds - 1 : (int) maxfd;
+	for (i = lowfd; i <= top; ++i) {
 		free(fd_paths[i]);
 		fd_paths[i] = 0;
 
@@ -1584,6 +1590,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 	static size_t alloced_len = 0;
 	int strip_slash;
 	int startfd, i;
+	int close_range_maxfd = 0;
 
 #ifdef PSEUDO_PROFILING
 	struct timeval tv1_op, tv2_op;
@@ -1611,7 +1618,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 		}
 	}
 
-	if (op != OP_CHROOT && op != OP_CHDIR && op != OP_CLOSE && op != OP_CLOSEFROM && op != OP_DUP
+	if (op != OP_CHROOT && op != OP_CHDIR && op != OP_CLOSE && op != OP_CLOSE_RANGE && op != OP_DUP
 			&& pseudo_client_ignore_path_chroot(path, 0)) {
 		if (op == OP_OPEN) {
 			/* Sanitise the path to have no trailing slash as this is convention in the database */
@@ -1704,6 +1711,13 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 	}
 #endif
 
+	if (op == OP_CLOSE_RANGE) {
+		va_list ap;
+		va_start(ap, buf);
+		close_range_maxfd = va_arg(ap, int);
+		va_end(ap);
+	}
+
 	if (op == OP_RENAME) {
 		va_list ap;
 		if (!path) {
@@ -1884,7 +1898,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 	case OP_EXEC:
 		do_request = pseudo_client_logging;
 		break;
-	case OP_CLOSEFROM:
+	case OP_CLOSE_RANGE:
 		/* no request needed */
 		startfd = fd;
 		if (pseudo_util_debug_fd >= startfd)
@@ -1901,7 +1915,10 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 			startfd = pseudo_grp_fd + 1;
 		if (connect_fd >= startfd)
 			startfd = connect_fd + 1;
-		for (i = fd; i < startfd; ++i) {
+		/* the fds below startfd are the ones our own are mixed in
+		 * with, so close those by hand and skip the ones we need
+		 */
+		for (i = fd; i < startfd && i <= close_range_maxfd; ++i) {
 			if (i == pseudo_util_debug_fd || i == pseudo_util_evlog_fd ||
 					i == pseudo_localstate_dir_fd || i == pseudo_pwd_fd ||
 					i == pseudo_pwd_lck_fd || i == pseudo_grp_fd ||
@@ -1910,8 +1927,9 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 			pseudo_client_close(i);
 			close(i);
 		}
-		pseudo_client_closefrom(startfd);
-		/* tell the caller to close from startfd instead of fd */
+		if (close_range_maxfd >= startfd)
+			pseudo_client_close_range(startfd, close_range_maxfd);
+		/* tell the caller to start at startfd instead of fd */
 		result = &msg;
 		msg.fd = startfd;
 		do_request = 0;
@@ -1996,7 +2014,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 		break;
 	}
 	/* result can only be set when PSEUDO_XATTRDB resulted in a
-	 * successful store to or read from the local database or for OP_CLOSEFROM.
+	 * successful store to or read from the local database or for OP_CLOSE_RANGE.
 	 */
 	if (do_request && !result) {
 #ifdef PSEUDO_PROFILING
-- 
2.43.0


