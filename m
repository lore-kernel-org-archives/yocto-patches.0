Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B71CA5FF0
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 08:12:42 +0000 (UTC)
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15163.1791187956031679395
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Oct 2026 01:12:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=W7aIwNzI;
 spf=pass (domain: gmail.com, ip: 74.125.225.98, mailfrom: frezidok1@gmail.com)
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01c41135so894926f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187954; x=1791792754; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LQYIDNnXUCepz+96C4gqw8T6ZXsPjeS5T1dcjHPVZqc=;
        b=W7aIwNzI7ogQrUuNR07pK7NVWrwI3nOpdRL2qH5QIaCgA2IrQCp9oPLGshlYV/xVgz
         C1bOl5rSo6ZMHhLxDxqSqe9MNBYZnpnj6jRWOAXpCQXr1OSuC5TEkKMPfqn8SeTQeVij
         r+Gc6JoKhasrYEm7ZRguoqySKX234qR6LuP2cjQMNb+xUsW/0wXmLl333NRicq8hEzIp
         0JK1jnRKGJQ3Gx5cRmlTAaG1U5ZQ4wmtk3798BrCZZnAsYgwaxr/iH1aXMtErGAzfeTK
         wLL+LJAMSTizVQKnA9Un6C8rAuLNPpgbhq5XW8cFh6TEarP++vz2Gp2/so5nDRqGBvgm
         3Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187954; x=1791792754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LQYIDNnXUCepz+96C4gqw8T6ZXsPjeS5T1dcjHPVZqc=;
        b=dUcZl7HOF8+InsLo7EmfGG/8HRogjZ3QPtSbDB1g8dpejv3H/gQrk5V5dBGu5pDvEQ
         HhxKPlv/87VCDJkhW4crHoX89QI0XoGyewpqxuoesCRb5GK/eKZzsYx5OBbxY3EsuReH
         rEoF7TvpGw/DyG7Mnm9L4X++UGatBGPlQ6y+sehPsAGedEqhZLsuGSLEBiObfsJWBXN0
         8+PEZ9hgURW9Bu3RtnQSVdBErY5LIVgBlVwWvLSoM+wfLro+s5wg6Mn9p6L1iyyhjpby
         TnsFi3yuWqVJ8H41I4YrqfitIaimPhbJn7iikq/XAGzpUVI7/MgVWF/EGeHw7TvgbhiP
         O+Iw==
X-Gm-Message-State: AFuF++lUGoxayRvhswWIxKhZkVHkpD05qwaKrh9f6LsjCSOic8C0hSD5
	COwoLmWKIjLr024cTC1Li8SR3QoVCLhIO9EbulgBASqdIsXYx7MWDUNAkBUnRg9I
X-Gm-Gg: AYBFou1kJg7pIgvOvGtGzgvxUxeqFIiUPo3Snq7cH2I+YfSlk25UlVWr+IwWRKQns7T
	yF0UR9UhlHWy+bOyAQNOggJ1poR3FpJwX7iOpmU02YQbqnz5cuxB/1tSC2aQih/3zFTpbEGyrWP
	ZDc2pZ634pnJRtuUggdn7Q6M8n3WQ51Z4woUqqmVwIB/m56uB8CXtL875OALowfSQwtmk3QVG9q
	oO5YXgJcfTHZ+e8tYMppOqmgXNwUm04imQK7jaZEChJRR+Vf7O6gHfclP6W/bQSkledC4wucxUa
	KWY295plnk/7uNsHVT/I7okmH+hUbPfe/vcWcXU5MrO+YARfPMhn/HgN5qUpRI5CGyAQo5LfF6N
	h+weYuTQJdctBJfhRxh7D9845GhJcR5MJ88uTmuFTdikjRIvzREEIdcgHcXpf76oNbbrq1MkYS+
	qOz2R0lDKXKuj/cZI0Gx/LvlRuKldDxoGb/WidzlpDJ0tTPm1ngPYzjXMPIgPqDuT/8ooPiuvvx
	a3b9Up2LMz7xuOyV849Lwxp7ZEYrk2N8wd4p24=
X-Received: by 2002:a05:600c:3152:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4a027584bc4mr166737025e9.22.1791187954053;
        Mon, 05 Oct 2026 01:12:34 -0700 (PDT)
Received: from ubuntu1.. (ppp91-79-47-228.pppoe.mtu-net.ru. [91.79.47.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm268675535e9.13.2026.10.05.01.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:12:33 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v4 6/6] ports/linux/guts: Add open_tree_attr wrapper
Date: Mon,  5 Oct 2026 11:11:27 +0300
Message-ID: <20261005081127.107126-7-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005081127.107126-1-frezidok1@gmail.com>
References: <20261005081127.107126-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 08:12:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4989

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

It mostly mirrors open_tree, with the additional
mount attribute arguments passed to the underlying syscall.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 ports/linux/guts/open_tree_attr.c | 57 +++++++++++++++++++++++++++++++
 ports/linux/portdefs.h            |  8 +++++
 ports/linux/pseudo_wrappers.c     | 16 +++++++++
 ports/linux/wrapfuncs.in          |  1 +
 pseudo_wrappers.c                 |  1 +
 5 files changed, 83 insertions(+)
 create mode 100644 ports/linux/guts/open_tree_attr.c

diff --git a/ports/linux/guts/open_tree_attr.c b/ports/linux/guts/open_tree_attr.c
new file mode 100644
index 0000000..3cf8fc7
--- /dev/null
+++ b/ports/linux/guts/open_tree_attr.c
@@ -0,0 +1,57 @@
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
+	if (flags & OPEN_TREE_CLONE) {
+		pseudo_diag("ERROR: OPEN_TREE_CLONE is not supported\n");
+	}
+
+	if (path && path[0] == '/') {
+		/* If the path is absolute, we should account for a potential chroot */
+		path = pseudo_path;
+	}
+
+	if (real_open_tree_attr) {
+		pseudo_debug(PDBGF_SYSCALL, "open_tree_attr, calling open_tree_attr.\n");
+		rc = real_open_tree_attr(dirfd, path, flags, attr, size);
+	} else {
+		pseudo_debug(PDBGF_SYSCALL, "open_tree_attr, calling syscall.\n");
+		rc = real_syscall(SYS_open_tree_attr, dirfd, path, flags, attr, size);
+	}
+
+	if (rc != -1) {
+		save_errno = errno;
+		int stat_rc;
+
+		pseudo_path = pseudo_root_path(__func__, __LINE__, dirfd, path, 0);
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
index 579dde7..6cece4e 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -98,3 +98,11 @@ extern int unshare(int flags);
 #define OPEN_TREE_CLONE (1U << 0)
 #endif
 
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
index bc6ca23..d417ed3 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -11,6 +11,7 @@ int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf, int flags
 int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int __openat_2(int dirfd, const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int open_tree(int dirfd, const char *path, unsigned int flags); /* preserve_paths=1, noignore_path=1 */
+int open_tree_attr(int dirfd, const char *path, unsigned int flags, struct mount_attr *attr, size_t size); /* preserve_paths=1, noignore_path=1*/
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

