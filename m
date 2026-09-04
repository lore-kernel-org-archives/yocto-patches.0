Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42846C624D3
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 13:07:27 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13452.1788527245801799087
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Sep 2026 06:07:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BTjE+rd+;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so1517119a12.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788527244; x=1789132044; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Va4C0dTnKTWVpknauT3dH3SDglebvYppVpjNA76wBww=;
        b=BTjE+rd+lbW0+IDDUylO5vJgtWHPCziBcG5QN5vxaInWbCTOJeKIS4R86xObOLsIBb
         r7hPk+w10IlgqpFoAhcQ1g/4vhxIWZU4BZYZYW2bFczhdRCX9bw3hReIiubX+ONmQFCc
         JxWMenMQwR1CsVVsAWaM7/YrfROnvst0YPHIC5ADYtKQbCdXdE5TWT6HF2S6a97HOsKQ
         pxor2y2qo2TO08sSQ9FeHaB6YNOO8bdem9DkIvwRan/8GuEfvJTYqFP6EsHu2Hhjv6Pk
         c8+mTCOC5mItnXadTXMeWGEBdRHfdaEEHodjy7b050bwVjCISWUoOLjZJCF/KWPOBiFe
         bGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788527244; x=1789132044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Va4C0dTnKTWVpknauT3dH3SDglebvYppVpjNA76wBww=;
        b=F076wirhWbAPKaXYyPt+HmOj/REefU6eNF+yu0xHHdULTxugFIrcXzNFZUYAMgYL2G
         yu3J91jiBEFdRcWTDmfKRtnVCtx5pMg0ObBb4nL+GuZwUA0sPApvGezU0OxZ8bahMTO2
         a4KESO9kEZfs+HQTyq71+fBaw+LblXAFq8stVxX61AwNfhtEKBJsiJcvI5opAxH3pK0+
         hj9s46ovOGBT++qyacBkNUj82QaA56r5OumnRCUqn7ndHra7m9ncoAcalAvUTNoCCyqw
         SUWF8JKXHFuO1bj456FS5Vk1yPdrGV90EDSmj8fnCG19GSgO3kwfkRvt9qPyPMcY3hW7
         /PMg==
X-Gm-Message-State: AFuF++lULSj732xFTwnu5YXVqqoIqi1jneWw9FIcs3kxQpkpFhmYdPic
	rDm4HeyUFUgJNWTeorA3GnDot3WGN+0Ih0IgI4BuHMtXOMJitaiwS9paeu5x692G
X-Gm-Gg: AYBFou1LIAf9N0jkkqV4tbGbELooYdPZYMLE3TPgW+x1wr+Ubo5Q/mEX2rVbr5sTpl0
	lwSJm8bOKxUkBHFQ3UPbHWrynqb3T9cNXHI3SZIJmJtBmn16e7enUvA/tgqNfzO27HVJPlIdzfA
	38Kl+9o3dVeU6hLp2hsSWG3EKb50UK+dfdRB1uSGsAJVxxhpzYLVizGkSDJ2M4bKCsRF6hD8FUu
	/DhqtN2lS7m5HG4PZxNPBHTt+eFghiUXosWyFPQ5n7TQQDNAMCilIOxGpiNQB16UYH8xiR6BQss
	qxvwRdaBRV93l+3fci3i1Deu4KCm8mRuNiELjjwjMPUcQrqKioB6Ul9jE9j6/tSrKy0m2rtAkVO
	aBRNLsLut79syOVcIO3u2lmaeKtk6Tmkb5/M90H8+BhrTslY0gqfQW/is9LGzpTPKTYri4YmIQF
	8oSA8TlJPzeFSidBgZZ0pVW+D6ScAD+t6uaCg4aMjAKKr2z10NA53uU9Q=
X-Received: by 2002:a05:6402:46cc:b0:6a6:1026:b0d6 with SMTP id 4fb4d7f45d1cf-6a7e8d54234mr1856593a12.4.1788527243696;
        Fri, 04 Sep 2026 06:07:23 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68c3d88sm1173158a12.15.2026.09.04.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:07:22 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v2 1/4] ports/linux/guts: Add open_tree wrapper
Date: Fri,  4 Sep 2026 16:06:24 +0300
Message-ID: <20260904130627.453678-2-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904130627.453678-1-frezidok1@gmail.com>
References: <20260904130627.453678-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 13:07:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4729

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

OPEN_TREE_CLONE is not handled since it requires CAP_SYS_ADMIN and is outside the common pseudo use case.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 ports/linux/guts/open_tree.c | 46 ++++++++++++++++++++++++++++++++++++
 ports/linux/portdefs.h       |  9 +++++++
 ports/linux/wrapfuncs.in     |  1 +
 3 files changed, 56 insertions(+)
 create mode 100644 ports/linux/guts/open_tree.c

diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree.c
new file mode 100644
index 0000000..6c2aad9
--- /dev/null
+++ b/ports/linux/guts/open_tree.c
@@ -0,0 +1,46 @@
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
+	char *pseudo_path;
+
+	if (real_open_tree) {
+		pseudo_debug(PDBGF_SYSCALL, "open_tree, calling open_tree.\n");
+		rc = real_open_tree(dirfd, path, flags);
+	} else {
+		pseudo_debug(PDBGF_SYSCALL, "open_tree, calling syscall.\n");
+		rc = real_syscall(SYS_open_tree, dirfd, path, flags);
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
+		pseudo_debug(PDBGF_FILE, "open_tree(path %s), flags %o, stat rc %d, stat mode %o\n",
+			pseudo_path, flags, stat_rc, buf.st_mode);
+
+		if (stat_rc != -1) {
+			pseudo_client_op(OP_OPEN, 0, rc, dirfd, pseudo_path, &buf);
+		} else {
+			pseudo_debug(PDBGF_FILE, "open_tree(fd %d, path %d/%s, flags %d) succeeded, but stat failed (%s).\n",
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
index 1f1a41a..565fed9 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -82,3 +82,12 @@ extern int unshare(int flags);
 
 #define SYS_openat2 __NR_openat2
 #endif
+
+#ifndef SYS_open_tree
+
+#ifndef __NR_open_tree
+#define __NR_open_tree 428
+#endif
+
+#define SYS_open_tree __NR_open_tree
+#endif
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

