Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8442EC79F99
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 11:20:30 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32494.1788780024825040739
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 04:20:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ZLTSKRS2;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a5ebf75d62so4935214a12.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788780023; x=1789384823; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TpAn+ev0mjriQBZovNit/5c7iNwzyPq7sx+AX/5IpUs=;
        b=ZLTSKRS2faP6p9X0p7Tg3xj0FnRjLC2EDAoCjE5SJLyY1fAyXkCVLhCPvj9vueXpfG
         ACKVDlNwtJD7CSH5ijQ4Kq6BK8PcDNulH7KxTixc1H/tTLHAfn8pCKdSp7rhk/zWwKca
         bLeaPYDIbW8SMVrlCIT9D8AjoHJnGl/nAVgJ8kQTcWo6KAmVINTYfFpBwWeSlpk88jan
         THowNQm+Q/9bGfBdNPLlo+6we5YLKG65EUqP7RMrpBsGjGbBMQriLHXRNJbnh/X5g8lf
         uT7LqvJU2HiPM6jpkAnWnLsH7G3LRtHr9nxVlezq8Ar9MTLal1qxQBipGEVPtT+TCeEt
         4QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788780023; x=1789384823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TpAn+ev0mjriQBZovNit/5c7iNwzyPq7sx+AX/5IpUs=;
        b=CSetjcayNNYcHlfGHMzrcz7tC1vLTk0eQCLJjiTu5ebNmhJknwxFz6SBgeGTR8Usg6
         M1WBIvC8RvuTfmHiVanSsiPH1N4psWdOUVqsx8E3WdD66+aOhbNy1jpT094JaPwsIFPp
         jzXgnlrLSsBF/pRRyr8cgyfJZPZXzbALjDDcK3Z3z7GEmaT3Uorbm6d1SiC3p8PNPcCd
         RG6WrUd2cmzCHLCMdxWwL8f9dpJ7M2Cid2jyXD1fiT+F0T/db5H6vKBP9Pm4BDzazR6C
         N+pWV0G3KQkuIhJsnZxolJW4mvw4dX8q8BFi+M/5fXSY1QWl4A70Z3yoXAm03B4RA6M5
         MIGw==
X-Gm-Message-State: AFuF++n8rWh+brtX2L3mg+o0vircwtLhxuf5skbaHAKAk6+NGaG0LuO8
	w97iO/gW2qxBVzbxEGWHW3KoLigZSiD3VEWKXg2P4BEx7+upAyheKPXWAapuTp9Y
X-Gm-Gg: AYBFou3XSuuHEUFZSNVRzuu4sg95M/NqI+JgKYnTF0tV933qxMCNmoggbix4ffQBR57
	1n8p3GwGRrJHoepX4r/1umJfJSYUnHE/j4Y6z3NxOv+diOlyIWlCAbFbkM19cDzFB5PLSJHEsSm
	BeCX1J6xHyGmSAcJz2DtDeXLgpQ0QrlZ82QNF1K0dNc7aCjNaxwiecTpsDalR3eeFYG4YGwKIPu
	SnyXrxrwfmLIDOZZgsufN6XhwdvvqbF0kbkZ6Cs/jUYqXSb92wZXUQlUi8LlrHslIOe+VZLfZSq
	LBtQxIh0PRzpxEeWQXO2Du4rmraP0OTM+OXNwRJu0MomVn0csmO6ULPr10Rii6TimahCEt43N7I
	UKp/R3PU5QLEk9NBnxLz6ZRoeSE+h5JOycAKxd0Sa4wVfik46BPnATR52sZ/OYoY0dQN6k47SsU
	MZ3Q1OxPbUKz9oavQgB9QtVLrO2YLdei4as9kNeZ0/VL5oLDpeS95aV6DerzfoJSLbwy0=
X-Received: by 2002:aa7:c75a:0:b0:6a6:75b7:4ff6 with SMTP id 4fb4d7f45d1cf-6a696a84013mr7036587a12.8.1788780022749;
        Mon, 07 Sep 2026 04:20:22 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20a41sm4200117a12.31.2026.09.07.04.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:20:22 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v3 6/6] ports/linux/guts: Add open_tree_attr wrapper
Date: Mon,  7 Sep 2026 14:18:43 +0300
Message-ID: <20260907111843.26746-7-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907111843.26746-1-frezidok1@gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 11:20:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4747

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

It mostly mirrors open_tree, with the additional
mount attribute arguments passed to the underlying syscall.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 ports/linux/guts/open_tree_attr.c | 48 +++++++++++++++++++++++++++++++
 ports/linux/portdefs.h            |  9 ++++++
 ports/linux/pseudo_wrappers.c     | 16 +++++++++++
 ports/linux/wrapfuncs.in          |  1 +
 pseudo_wrappers.c                 |  1 +
 5 files changed, 75 insertions(+)
 create mode 100644 ports/linux/guts/open_tree_attr.c

diff --git a/ports/linux/guts/open_tree_attr.c b/ports/linux/guts/open_tree_attr.c
new file mode 100644
index 0000000..da0315c
--- /dev/null
+++ b/ports/linux/guts/open_tree_attr.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (c) 2026 Yocto Project
+ * guts/COPYRIGHT for information.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * int open_tree_attr(int dirfd, const char *path, unsigned int flags, struct mount_attr *attr, size_t size)
+ *	int rc = -1;
+ */
+
+	/* Mostly based on open_tree wrapper */
+
+	struct stat64 buf;
+	int save_errno;
+	char *pseudo_path;
+
+	if (real_open_tree_attr) {
+		pseudo_debug(PDBGF_SYSCALL, "open_tree_attr, calling open_tree_attr.\n");
+		rc = real_open_tree_attr(dirfd, path, flags, attr, size);
+	} else {
+		pseudo_debug(PDBGF_SYSCALL, "open_tree_attr, calling syscall.\n");
+		rc = real_syscall(SYS_open_tree_attr, dirfd, path, flags, attr, size);
+	}
+
+	pseudo_path = pseudo_root_path(__func__, __LINE__, dirfd, path, 0);
+
+	if (rc != -1) {
+		save_errno = errno;
+		int stat_rc;
+
+		stat_rc = real___fxstatat64(_STAT_VER, dirfd, pseudo_path, &buf, (flags & AT_SYMLINK_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+
+		pseudo_debug(PDBGF_FILE, "open_tree_attr(path %s), flags %o, stat rc %d, stat mode %o\n",
+			pseudo_path, flags, stat_rc, buf.st_mode);
+
+		if (stat_rc != -1) {
+			pseudo_client_op(OP_OPEN, 0, rc, dirfd, pseudo_path, &buf);
+		} else {
+			pseudo_debug(PDBGF_FILE, "open_tree_attr(fd %d, path %d/%s, flags %d) succeeded, but stat failed (%s).\n",
+				rc, dirfd, pseudo_path, flags, strerror(errno));
+			pseudo_client_op(OP_OPEN, 0, rc, dirfd, pseudo_path, 0);
+		}
+		errno = save_errno;
+	}
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
index 565fed9..af8b8e8 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -91,3 +91,12 @@ extern int unshare(int flags);
 
 #define SYS_open_tree __NR_open_tree
 #endif
+
+#ifndef SYS_open_tree_attr
+
+#ifndef __NR_open_tree_attr
+#define __NR_open_tree_attr 467
+#endif
+
+#define SYS_open_tree_attr __NR_open_tree_attr
+#endif
diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index 33cba2d..4141556 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -116,6 +116,22 @@ syscall(long number, ...) {
 #error SYS_open_tree not defined
 #endif
 
+#ifdef SYS_open_tree_attr
+	if (number == SYS_open_tree_attr) {
+		pseudo_debug(PDBGF_SYSCALL, "syscall, faking open_tree_attr.\n");
+		va_start(ap, number);
+		int dirfd = va_arg(ap, int);
+		const char *path = va_arg(ap, const char*);
+		unsigned int flags = va_arg(ap, unsigned int);
+		struct mount_attr *attr = va_arg(ap, struct mount_attr*);
+		size_t size = va_arg(ap, size_t);
+
+		return wrap_open_tree_attr(dirfd, path, flags, attr, size);
+	}
+#else
+#error SYS_open_tree_attr not defined
+#endif
+
 #ifdef SYS_renameat2
         /* Call out wrapper, expanding the variable arguments first */
 	if (number == SYS_renameat2) {
diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index a51e9a0..639d9a5 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -11,6 +11,7 @@ int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf, int flags
 int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int __openat_2(int dirfd, const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int open_tree(int dirfd, const char *path, unsigned int flags); /* noignore_path=1 */
+int open_tree_attr(int dirfd, const char *path, unsigned int flags, struct mount_attr *attr, size_t size); /* noignore_path=1 */
 int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknod */
 int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknodat */
 int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW */
diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index 112239b..78cdecf 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -37,6 +37,7 @@
 #include <grp.h>
 #include <pwd.h>
 #include <utime.h>
+#include <sys/mount.h>
 #ifdef PSEUDO_PORT_LINUX_STATVFS
 #include <sys/statvfs.h>
 #endif

