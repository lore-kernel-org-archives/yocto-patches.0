Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD96CA5FF0
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 08:12:32 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15162.1791187952218518612
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Oct 2026 01:12:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=k1bMTR5d;
 spf=pass (domain: gmail.com, ip: 74.125.225.141, mailfrom: frezidok1@gmail.com)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a022e9cbebso12118545e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187950; x=1791792750; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ahr65LlqRZF7ziGb54e59+uE7PKTZRVpLFM3ck0sKhM=;
        b=k1bMTR5dN2k8f2wMGuBJ4jILJUuCsXby0amHdSoyCu8av6NSmO81Hj46yKYBph0XLH
         i2pyo9PaDBMkwNUgWD+pvV2ISlicbyb3lKVRTfV0O4Lc9tYOgwyXZLy28QiJSfTO3Shw
         8yHC5wo51Fb0eqSxIr6D5j35Zxnc22U43exhlMz/reiDynvw3q565Oh4++gTvXa5pWu3
         zlB3fTsq1vNeHroChqOVTgebRShizr2sgguNFYx1DiY8Ne26PyECdeWgUMP4fNd7AREN
         eHNDHQXT46fh2eavpl6JBIntqj1aJsLBJwllgwlok00J8HH0E79xVSL4Lk0JYfts//0/
         g7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187950; x=1791792750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ahr65LlqRZF7ziGb54e59+uE7PKTZRVpLFM3ck0sKhM=;
        b=okixvyPTYeKwizhm6GihvoiJMRTwDTQWCbTFwnd/ck+VB+teU6xbP/gv6aZ3NmKfa0
         Nj8PNS0E+lUFsUN8FflLoKWvn3bqS7hZD0rylkRiNJwEI/cNM388xzmyJj+lSsS0nGmt
         jVgIy9hVKASnnFuZpMblxeGmXBWhOLq8hyugodqXfk/X2W/l/UNJ5INwUuoU4BXLZRhk
         RUU46/fKCJkvLtAYKm4sVFyzCl2HaPf4+xDzOrUnZnMk78TcuUQ8EUeldn55TWul0dAk
         wdnmHNlr/EafV1/fwYZn9eTqSYA/icD/CHLkGp8TtBdZb1S9KDF494WoX7UpqiG9Jc6I
         j40w==
X-Gm-Message-State: AFuF++nxkzq2RkxaAmX92tAqZh4PirlPTsV7f0686S90D++c9lMMo0pe
	P60H+M0wU6CQ9X3ceWYw16oUgxrZ/tiR1Njxds5Igt28AgcdU5xwRIRQRtf69Ix2
X-Gm-Gg: AYBFou0wPtnfsj+Q757TY7WqglXoIpeVy+r4yf8gqDtmxyK9in8VOrKfNAh5jzAcViB
	6X9B/QyQenmR0wWVwe99DjJiEOywtzIBVQfjtaQbnA2NaDjZHDdQ8mKeVEANP/qsxXKt+PMY/p+
	pRPHK7BS4IhF426wX169AMoMtG5x9SKe+/SNK2ar/L6aCssCeRDN7oJYGxoceZM+BeCfDIj0hC0
	wBJNJ11yq69HdbsYnZaVlHb5b3mkM6I8SE7A/XRBcZNtYBbzrC+3o3emR7oelAcvtuASkDTXE7v
	EDFnPtsqrpd1Y53GEQB7Q/+PBfBTHFgGJS2/ieKWcP9Sf+wfI8BwVLOtIAhjJX0rHXgAOfYjdn3
	X91ouaoknkDmsbRYiNUmilsqd+wcREiKQaHhSIhkugHB5VzXfrhNiKHuoIiPDRunA2p0lkwtlVp
	5glDffVv0iftvDG6qkqTMWxOD2s0RmPxzoNh7VTdb402qcF4iCQu1oXtmuyQQBOmiEkUezgU3hD
	fON9UbWfUqDPeQYh8wPtxgk8yjG
X-Received: by 2002:a05:600c:a306:b0:49e:719e:e215 with SMTP id 5b1f17b1804b1-4a027577b68mr121333965e9.26.1791187950278;
        Mon, 05 Oct 2026 01:12:30 -0700 (PDT)
Received: from ubuntu1.. (ppp91-79-47-228.pppoe.mtu-net.ru. [91.79.47.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm268675535e9.13.2026.10.05.01.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:12:28 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v4 5/6] test: Add open_tree_attr syscall test
Date: Mon,  5 Oct 2026 11:11:26 +0300
Message-ID: <20261005081127.107126-6-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005081127.107126-1-frezidok1@gmail.com>
References: <20261005081127.107126-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 08:12:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4988

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

Covers basic wrapper functionality when using syscall(SYS_open_tree_attr, ...), also tests AT_EMPTY_PATH flag and related paths using dirfd != AT_FDCWD.
The test uses attr == NULL, because using mount_attr in this call starts mount-specific privilege checks which end up with EPERM.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 test/test-open_tree_attr-syscall.c  | 167 ++++++++++++++++++++++++++++
 test/test-open_tree_attr-syscall.sh |   9 ++
 2 files changed, 176 insertions(+)
 create mode 100644 test/test-open_tree_attr-syscall.c
 create mode 100755 test/test-open_tree_attr-syscall.sh

diff --git a/test/test-open_tree_attr-syscall.c b/test/test-open_tree_attr-syscall.c
new file mode 100644
index 0000000..cc38c5f
--- /dev/null
+++ b/test/test-open_tree_attr-syscall.c
@@ -0,0 +1,167 @@
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <linux/mount.h>
+#include <sys/stat.h>
+
+#ifndef SYS_open_tree_attr
+
+#ifndef __NR_open_tree_attr
+#define __NR_open_tree_attr 467
+#endif
+
+#define SYS_open_tree_attr __NR_open_tree_attr
+#endif
+
+#define TEST_DIR "test-open-tree-dir"
+#define TEST_FILE "test-open-tree-file"
+
+static int do_open_tree_attr_syscall(int dirfd, const char *path,
+                unsigned int flags)
+{
+    /* Using mount_attr in this call starts mount-specific privilege checks
+     * which end up with EPERM.
+     * The functionality when using attr == NULL is equivalent to open_tree() */
+#ifdef SYS_open_tree_attr
+    return syscall(SYS_open_tree_attr, dirfd, path, flags, NULL, 0);
+#elif defined(__NR_open_tree_attr)
+    return syscall(__NR_open_tree_attr, dirfd, path, flags, NULL, 0);
+#else
+    errno = ENOSYS;
+    return -1;
+#endif
+}
+
+static int test_no_flags(void) {
+    int treefd = -1;
+    int fd = -1;
+    int rc = 1;
+
+    treefd = do_open_tree_attr_syscall(AT_FDCWD, TEST_DIR, 0);
+    if (treefd == -1) {
+        perror("open_tree_attr");
+        goto out;
+    }
+
+    fd = openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
+    if (fd < 0) {
+        perror("openat");
+        goto out;
+    }
+
+    rc = 0;
+out:
+    if (treefd != -1) {
+        close(treefd);
+    }
+    if (fd != -1) {
+        close(fd);
+    }
+    return rc;
+}
+
+static int test_relative_dirfd(void) {
+    int basefd = -1;
+    int treefd = -1;
+    int fd = -1;
+    int rc = 1;
+
+    basefd = open(".", O_PATH | O_DIRECTORY);
+    if (basefd < 0) {
+        perror("open");
+        goto out;
+    }
+
+    treefd = do_open_tree_attr_syscall(basefd, TEST_DIR, 0);
+    if (treefd < 0) {
+        perror("open_tree_attr");
+        goto out;
+    }
+
+    fd = openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
+    if (fd < 0) {
+        perror("openat");
+        goto out;
+    }
+
+    rc = 0;
+    out:
+        if (basefd != -1) {
+            close(basefd);
+        }
+    if (treefd != -1) {
+        close(treefd);
+    }
+    if (fd != -1) {
+        close(fd);
+    }
+    return rc;
+}
+
+static int test_at_empty_path(void) {
+    int treefd = -1;
+    int dirfd = -1;
+    int fd = -1;
+    int rc = 1;
+
+    dirfd = open(TEST_DIR, O_PATH | O_DIRECTORY);
+    if (dirfd < 0) {
+        perror("open");
+        goto out;
+    }
+
+    treefd = do_open_tree_attr_syscall(dirfd, "", AT_EMPTY_PATH);
+    if (treefd == -1) {
+        perror("open_tree_attr");
+        goto out;
+    }
+
+    fd = openat(treefd, TEST_FILE, O_CREAT | O_RDWR, 0666);
+    if (fd < 0) {
+        perror("openat");
+        goto out;
+    }
+
+    rc = 0;
+out:
+    if (dirfd != -1) {
+        close(dirfd);
+    }
+    if (treefd != -1) {
+        close(treefd);
+    }
+    if (fd != -1) {
+        close(fd);
+    }
+    return rc;
+}
+
+static void cleanup(void) {
+    if (unlink(TEST_DIR "/" TEST_FILE) == -1 && errno != ENOENT) {
+        perror("unlink");
+    }
+    if (rmdir(TEST_DIR) == -1 && errno != ENOENT) {
+        perror("rmdir");
+    }
+}
+
+int main(void) {
+    cleanup();
+
+    if (mkdir(TEST_DIR, 0777) == -1) {
+        perror("mkdir");
+        return 1;
+    }
+
+    int rc = test_no_flags();
+    rc |= test_at_empty_path();
+    rc |= test_relative_dirfd();
+
+    cleanup();
+
+    return rc;
+}
diff --git a/test/test-open_tree_attr-syscall.sh b/test/test-open_tree_attr-syscall.sh
new file mode 100755
index 0000000..f6e51f4
--- /dev/null
+++ b/test/test-open_tree_attr-syscall.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+./test/test-open_tree_attr-syscall
+rc1=$?
+
+PSEUDO_IGNORE_PATHS=/ ./test/test-open_tree_attr-syscall
+rc2=$?
+
+exit $((rc1 | rc2))

