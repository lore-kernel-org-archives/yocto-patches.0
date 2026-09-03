Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C229C624D7
	for <webhook@archiver.kernel.org>; Thu,  3 Sep 2026 10:17:15 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4528.1788430629645039664
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Sep 2026 03:17:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ZqNxuXYb;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso3111963a12.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 03 Sep 2026 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788430628; x=1789035428; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m5BzS7ULqVW7P4fCOUIuDPpOOWcUB1Z/C0emQAg4ykM=;
        b=ZqNxuXYbPkQx1Oid5KPe+fW/9yl2XppF97fu56cUxrGwKxxLa/G2Me+nbwxl2+nI/T
         A5b3EAgZbbD38TYzUPv6nRb10WJOsq49Tinx9aX0kKGgfGgqbi23fDFzw4+9JCgnc5ND
         th9F1hVr/uR2reWu/es8ayY3s6Hu2werncP1FoayWqewdoulATUcfPl7mvAK11PPQy9K
         1fekVRGz62/azr1/xnZ6RiHkfQNNLsVo0Py4QHbz22TNbNvdANQXhLcFV9HNXC3mZG7f
         noWkmGFEgSyhEobPlTpAScn9nfT8jeCPQOehlL69h5wZQ2ckr1bTn8iDf9NyoJj6gNNN
         kdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430628; x=1789035428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m5BzS7ULqVW7P4fCOUIuDPpOOWcUB1Z/C0emQAg4ykM=;
        b=opc4ExtNNslWu9o7wtSRe868Ge72ue+ZewGkrjEnJ2tQv8ERPis96ldpIs2JGrK6mP
         q4PZrDner17NZnaZPSlDBYXQq8QghysMSmxzWD/maGUjlLYNYAfPu5BHkR2hs+vVoZpR
         HMbQ0V9gOpeHEoxZBCGqMa996HdDOG7eB7XmT82YPLYJRvAcNeEaE3OaxgT8HQtllO2K
         gjVl5hmzG90jlzK3zbNpQhMHXAduAFKsIBsZPL1TDUKVjH8cvG3ZV1daI3/IbznKMFn2
         RcZE6yiE8ocTQJlIel3SBUhYouf69vCFgL0eT5AXOebSpxH7ACLynq6rK4XMAzD58fy6
         s6gw==
X-Gm-Message-State: AFuF++ndnSyhKH0C5SsrW+w5g1eb4OD5aSzN6xvhBg3IIHXYaLWMgZ38
	nq72ZX0+adJ0yAO2tCF1jnOfAfkGlV1fhgbfPxls1+lWEUcNROhMN6KzI0tGfOB5
X-Gm-Gg: AYBFou2bdLIpKBXsoNXiEaMR+dIuup0a+HIgcNqUaZa1NOfPBYptWdtivzumk+EX5ox
	5zJDTXym50FSRKB8DR503yNfiNYJueqe/f5BVasLZI/kKxa1QtNdQ2vPR5EBgqEHpWlr/ZUSrsC
	XAE3DzPpe0fPjuWlGoiXtWhACSSeCqTr73dh5voWevGlFUwse+w9l5GG+gV2gRZM8nS5ylgUo9T
	9EsigSreTLbwb6dZ5REDfJO2uYwhHalLoIp8q+k+IIR5+xL2r+2NQOkK2y4/nWvMmQVg3CCUqSF
	MDWHpSybqTGaia1pIA7xkcKisWAxEDADse8im6V0qjFbLv5y/b9oEYOI5wyhvKSNXrpk/3NTGx+
	np4rNlOTLuNGYlD2xvmf/fwM0ilm8JbNHws8cohgnXgfPELnfTsYRpksehSSWUAL/FXlYcTmMFJ
	ES4HOx3tWSa/YhLQAyJk0UUZlSePUJQNVZQxzhLmLtzzl9CyzoxvbhnUs=
X-Received: by 2002:a05:6402:a0cf:b0:6a6:32f9:d7d0 with SMTP id 4fb4d7f45d1cf-6a682af6405mr7250115a12.21.1788430627440;
        Thu, 03 Sep 2026 03:17:07 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f95f557sm2181728a12.31.2026.09.03.03.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:17:05 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH 1/2] ports/linux/guts: Add open_tree wrapper
Date: Thu,  3 Sep 2026 13:16:37 +0300
Message-ID: <20260903101638.371901-1-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Sep 2026 10:17:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4726

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

OPEN_TREE_CLONE is not handled since it requires CAP_SYS_ADMIN and is outside the common pseudo use case.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 ports/linux/guts/open_tree.c | 37 ++++++++++++++++++++++++++++++++++++
 ports/linux/wrapfuncs.in     |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 ports/linux/guts/open_tree.c

diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree.c
new file mode 100644
index 0000000..4b50a19
--- /dev/null
+++ b/ports/linux/guts/open_tree.c
@@ -0,0 +1,37 @@
+/*
+ * Copyright (c) 2026 Yocto Project
+ * guts/COPYRIGHT for information.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * int open_tree(int dirfd, const char *path, unsigned int flags)
+ *	int rc = -1;
+ */
+
+	struct stat64 buf;
+	int save_errno;
+
+	rc = real_open_tree(dirfd, path, flags);
+
+	if (rc != -1) {
+		save_errno = errno;
+		int stat_rc;
+
+		stat_rc = real___fxstatat64(_STAT_VER, dirfd, path, &buf, (flags & AT_SYMLINK_NOFOLLOW) ? AT_SYMLINK_NOFOLLOW : 0);
+
+		pseudo_debug(PDBGF_FILE, "open_tree(path %s), flags %o, stat rc %d, stat mode %o\n",
+			path, flags, stat_rc, buf.st_mode);
+
+		if (stat_rc != -1) {
+			pseudo_client_op(OP_OPEN, 0, rc, dirfd, path, &buf);
+		} else {
+			pseudo_debug(PDBGF_FILE, "open_tree(fd %d, path %d/%s, flags %d) succeeded, but stat failed (%s).\n",
+				rc, dirfd, path, flags, strerror(errno));
+			pseudo_client_op(OP_OPEN, 0, rc, dirfd, path, 0);
+		}
+		errno = save_errno;
+	}
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index 3cea20a..a51e9a0 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -10,6 +10,7 @@ int lchown(const char *path, uid_t owner, gid_t group); /* flags=AT_SYMLINK_NOFO
 int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf, int flags);
 int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int __openat_2(int dirfd, const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
+int open_tree(int dirfd, const char *path, unsigned int flags); /* noignore_path=1 */
 int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknod */
 int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknodat */
 int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW */

