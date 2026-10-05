Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA5DCA5FF0
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 08:12:22 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15217.1791187932236043844
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Oct 2026 01:12:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QnhCWgPb;
 spf=pass (domain: gmail.com, ip: 74.125.225.141, mailfrom: frezidok1@gmail.com)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a0280d4f56so8603525e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187930; x=1791792730; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mBl7W4ZDCYNuvlFqDhc5gVZWtBj0/1h3GIJo4IXZB90=;
        b=QnhCWgPbuDQpRgSNvvcnCAFKgrBYnJ98NiNv0nxhWVY11pjrlTceWWfPohq7iQ2aZz
         fgTdlZ9yA4lyBhnSy48ryz0hCMFkj0ta3kMWCZXyJB9lisngY/dpTGR7gGd3KLoWEHZD
         yVTEmZ5Kul2CR+xYdPGqZF18lo3LORQWrcKsavs3hmuaesI34+486ggZKtRKiOJbwNOF
         KveV9IaAoq/TuYQzqAReRH1jSPwfNHCyVTTIQU5RaovW9omkYm7LiAIjPG88ruIfh8Wn
         lYGBnAZDXw4IY+OSkZVDeCMqf1fVguhjYTnJqDcxy3FfCEjvqgSi/Af7gIqD+b/ztFO1
         zkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187930; x=1791792730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mBl7W4ZDCYNuvlFqDhc5gVZWtBj0/1h3GIJo4IXZB90=;
        b=g4xqaAT93aPtwhoMqpTSQGe7E2+hjgRh38yeW4y5+3/Ptd2S1290hj7NIizH3cPuuW
         e8TCSj4Mmigv+BGn6p5701fTOH0GQ55HyMgNYeExfq3troBqZ0sff9tohEN1mRFECAkA
         Qyy/fWmA0cZRf0u78FKGJiQJ8p0sT203DJrE+Mau8Apv3ueXXs1CjCEi5f4LvE3cWhaa
         ZreyQ6UF7PMCWhSRmVgVvK2+ByOpIuVT8w+Pnqp+uBebqXniVzfNiAbSoArP4Pg17RDJ
         7P0bwuFc+PXgDsi/8pGEYWPTwZh9bPFaTC9/yxD65pGpZXQJoi4Gxg4jH7EMlUwsk5e7
         1oAQ==
X-Gm-Message-State: AFuF++kVbHYYh5VQzw2ZFkOijS5VF0yIp+ZSubJgLFWv7ajVyfXGmaLm
	IR04C1/sTMZKtMLZcQZck0tmQDcW84m6CLhfRkZlAIm/kZHJKHoD3N0giAshiJxr
X-Gm-Gg: AYBFou0fJ6BeXQ3QdSwM4+83tHDeWGhqMMc1joab43LWPa8kMZZatphCfkMY4F/JlVR
	GM6KtVOD5AA1ANRZVN1I/QQPfYWcK1oPFORhCCTjW1qkJD0hX9c6sSCoDNC7mM5gS9/UbX3GbDp
	w0vnyUaKAvMLPk8phGp079K0vUfRtXt4VKh6Ixfda8THidHCvQ+Sc+OobFijUCzZ1WJoKbYfBE0
	jGvNcO+l0ckUQCzKaFjoCB+p4jLmyDdKQhVKdopNsKsZfZ0PNND8DdFdpnjog659+PMjMhc2mlX
	304z9EvNCc1+4snT5kjPDE19hbYoYfkgKfLtcCEIZpcKKqreLCWihWSK6M7+2b51mrTksdsjFsE
	WgPJqqDmReZp/MW1kndJ/WEEnCRhmTtsKVxFCeOka0oH3qFLxRuE5Y82EPTkdMPjzKNwSyvug0o
	aG2XOs+TcYw+/WOguJb0ohsDEb9sJR4MmLieYDVgKvq/J9OjwAwvfkyiFEiQPv4RRDE6GyudJNW
	UgmbWEkNC8kQB+9mvHw2fRLagWA
X-Received: by 2002:a05:600c:a306:b0:49f:f099:6f8c with SMTP id 5b1f17b1804b1-4a0275758cemr126977045e9.9.1791187929982;
        Mon, 05 Oct 2026 01:12:09 -0700 (PDT)
Received: from ubuntu1.. (ppp91-79-47-228.pppoe.mtu-net.ru. [91.79.47.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm268675535e9.13.2026.10.05.01.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:12:05 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v4 1/6] ports/linux/guts: Add open_tree wrapper
Date: Mon,  5 Oct 2026 11:11:22 +0300
Message-ID: <20261005081127.107126-2-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005081127.107126-1-frezidok1@gmail.com>
References: <20261005081127.107126-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 08:12:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4984

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

OPEN_TREE_CLONE is not handled since it requires CAP_SYS_ADMIN and is outside the common pseudo use case.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 ports/linux/guts/open_tree.c | 59 ++++++++++++++++++++++++++++++++++++
 ports/linux/portdefs.h       | 16 ++++++++++
 ports/linux/wrapfuncs.in     |  1 +
 3 files changed, 76 insertions(+)
 create mode 100644 ports/linux/guts/open_tree.c

diff --git a/ports/linux/guts/open_tree.c b/ports/linux/guts/open_tree.c
new file mode 100644
index 0000000..ca299a1
--- /dev/null
+++ b/ports/linux/guts/open_tree.c
@@ -0,0 +1,59 @@
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
+	if (flags & OPEN_TREE_CLONE) {
+		pseudo_diag("ERROR: OPEN_TREE_CLONE is not supported\n");
+	}
+
+	if (path && path[0] == '/') {
+		/* If the path is absolute, we should account for a potential chroot */
+		path = pseudo_path;
+	}
+
+	/*
+	* Older libc versions do not provide open_tree(), so call the syscall
+	* directly when the libc wrapper is not available.
+	*/
+	if (real_open_tree) {
+		pseudo_debug(PDBGF_SYSCALL, "open_tree, calling open_tree.\n");
+		rc = real_open_tree(dirfd, path, flags);
+	} else {
+		pseudo_debug(PDBGF_SYSCALL, "open_tree, calling syscall.\n");
+		rc = real_syscall(SYS_open_tree, dirfd, path, flags);
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
index 1f1a41a..579dde7 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -82,3 +82,19 @@ extern int unshare(int flags);
 
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
+
+/* OPEN_TREE_CLONE may be missing from older host headers.
+ */
+#ifndef OPEN_TREE_CLONE
+#define OPEN_TREE_CLONE (1U << 0)
+#endif
+
diff --git a/ports/linux/wrapfuncs.in b/ports/linux/wrapfuncs.in
index 3cea20a..bc6ca23 100644
--- a/ports/linux/wrapfuncs.in
+++ b/ports/linux/wrapfuncs.in
@@ -10,6 +10,7 @@ int lchown(const char *path, uid_t owner, gid_t group); /* flags=AT_SYMLINK_NOFO
 int __fxstatat(int ver, int dirfd, const char *path, struct stat *buf, int flags);
 int openat(int dirfd, const char *path, int flags, ...{mode_t mode}); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
 int __openat_2(int dirfd, const char *path, int flags); /* flags=((flags&O_NOFOLLOW)||((flags&(O_CREAT|O_EXCL))==(O_CREAT|O_EXCL))), noignore_path=1 */
+int open_tree(int dirfd, const char *path, unsigned int flags); /* preserve_paths=1, noignore_path=1 */
 int mknod(const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknod */
 int mknodat(int dirfd, const char *path, mode_t mode, dev_t dev); /* real_func=pseudo_mknodat */
 int __xmknod(int ver, const char *path, mode_t mode, dev_t *dev); /* flags=AT_SYMLINK_NOFOLLOW */

