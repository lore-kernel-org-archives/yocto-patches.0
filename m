Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96399C79F9E
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 11:19:50 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32733.1788779981592517144
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 04:19:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=jckNaXpg;
 spf=pass (domain: gmail.com, ip: 209.85.208.47, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a5e329c0f2so3784107a12.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788779980; x=1789384780; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Va4C0dTnKTWVpknauT3dH3SDglebvYppVpjNA76wBww=;
        b=jckNaXpg/H7IHW8XCAaulfYUXKY+qduZ9K+jKeZZ09RgQDD6NyMd3r9QlmolkCQ3nl
         5aPbuRKzSTT0BiPdMc5PSzbdP4YfoQCpdS0xDyrRu8IRmjL8Zdv35/NYZk6MJ9R1LNkI
         ybPnsF6xDOzO1pzYqkze8HhX4zMyHII8yia0SGWsQ4ioectmg+GeY7dvYVAG/Jbje7Gy
         1snL113S86QGmeCJ/TYk+gOfwPe+jyv52SwrLhctFIsQJUjHiuEJFT3EcjIlc127quXg
         qoUnq3kS0SwcSGNvDYtUiaZ2LrLNs0oBqzNwQvA/oHiVLIFIYn6+QAy9xcipdZ2sdfA0
         hicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779980; x=1789384780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Va4C0dTnKTWVpknauT3dH3SDglebvYppVpjNA76wBww=;
        b=AmH+jUdSiVVTB0KgL7CAe5NnpAtCONa/lz+teWH9tzMrZKO1CTZ8oKpIsp+lmp3yNq
         UEpsnwb/dal+DRkOHhCYywHN8LdIUKhXdhf0kEL3M7XGRSjBY33ckSSbg3tjPwZifYUS
         hwXMO678aQTqThD+Mrrmd2Z4JJvhqyfs7N5qK+5PTYFjMSiPSZb7N7HJG7d36R7Hg4ei
         J/5bA4btq0NMsI/8hr3vOmQ82k2wb52b2bH5WUX/uOsaxTWjsUPfbW7gwQSCCyQnAbhe
         T1HGyoBwd6DPmm95npyN/kVgmKd4IsW0Fayc+Y4zuL6cpGXhxFpAzJmuToMYaD4hONkX
         ZpGg==
X-Gm-Message-State: AFuF++mbduRTp5PeJFkAEyiFd/bitoluTnQ8emFl1KZkHH5uhuVma3MC
	KSArhsQUij5MfHZ0szyXdFrbXdQZ8sRbL2fVKwXvzKP8UnolrCduGuF+FJXvTTeS
X-Gm-Gg: AYBFou2FZJNj9MDFHUQnLJyG8MZrLrKG4NZr0kRby/zSD+F1squm++ysO3DfU57SOIS
	Su93r04S3lvdqrqFyBlIhX2e6ATFOUFDfFQrM5zTIDhRvk2IX4BTwEFrDBET9JkV3KsmmT7plWV
	i5U7obQmGqYd8ijzSf8D2MTcIeWLdpSLUrLjswFjcq4UJuHXqSYcBUCI7JsNsJYFgmsxhDoD8Ql
	Oe6hw7SJ+vyIE6KAVmgt6iGwYhxnRWNeqlz5i/QRD+ceRD4x5YwqTzeTnlBgs680CB+UV5uat1Q
	RdzXqGgekSi34ZWiLMueju4tvYaxnZg1MwUVriYPlMINLXOO36vWG6qDOfEUqC0IjF8607M6yCG
	gqfqiiScRfuMr9IMRIM6QEHJfNSS12b9/daXQrrYIGulBWX/7JsfjzOsivQThDqn5uKKfOCDLxk
	+K8PyhQWVpZGAMxtbDpi52Mo8myG+p+TZZ0erINu+5qkAcD0xdmoaQvMHv
X-Received: by 2002:a05:6402:43c8:b0:6a3:8652:a373 with SMTP id 4fb4d7f45d1cf-6a7e8d4b44bmr7280680a12.3.1788779979375;
        Mon, 07 Sep 2026 04:19:39 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20a41sm4200117a12.31.2026.09.07.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:19:38 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v3 1/6] ports/linux/guts: Add open_tree wrapper
Date: Mon,  7 Sep 2026 14:18:38 +0300
Message-ID: <20260907111843.26746-2-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907111843.26746-1-frezidok1@gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 11:19:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4742

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

