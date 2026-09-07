Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C78C79F99
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 11:20:20 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32750.1788780011662969205
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 04:20:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=rB2tFva9;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a5e329c0f2so3784735a12.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788780010; x=1789384810; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEnnJkz2WMy/oXHPCNRiSqRYRh/TZttmJDfojt2QGZ8=;
        b=rB2tFva9tjEFGeW0jUJ3Bs/nFd6nlWlNhOgehKYOug9yl4Su1JmQ3qbSGoYAb7i/zJ
         V9xiAAF6MOAHyzJ9JYEceP50RgIG+yG1Disdu7uiQj8j4+5aaKVGT72rQOYX619DClQP
         3LYyAOky1fNpwBuQ999LaE3Hmd2oc8u4BizfR0w8hQTVtnActBrcoDdQMnxY3xpbaKdq
         1UhocYA7jjY6xV6cwmf5zyoNXpASOs8x5vFXJLi2nQ6S50cQn6wLXLpWlmDsmYdJovRM
         CF+zPNrEH1/CdG80TF/5L/iyzP0tOpkHgN3cKvpZfYrlcenguygD0EDUCrWx5vPU+5qo
         a17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788780010; x=1789384810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JEnnJkz2WMy/oXHPCNRiSqRYRh/TZttmJDfojt2QGZ8=;
        b=FJdlCsV04E4VkxHsEbVNuFIVUvzGqaXoz/R/IUYnR2vGedKIbi8R/9TlxRaVSKFnpW
         fzoXbdcmpjIsZqr5uB9LerCKPZ2WATHwh5q7ZBfLg7q+HSijechEYBbUvtK5gb5YgOKc
         XUv+NneIjDPo0SW0Xwxjc/5h3o4YQHM8S+jN6Vt1Jdkqs3+U5GgK8JSFgKIZTXscvMxe
         4e3ruk5ZN/VEx/xExYM3DQMY2TYBYGr9clE3+YtuSfBHW5LtyA+4qHU+PT4h2MKaza4B
         AgVIS2/ecJPq73Ca1b9eqadv+ENqZvUED+pg2w1lJs4NdUnYx0oZBtET6UBKqG5vzCX3
         plMg==
X-Gm-Message-State: AFuF++m7xsUTr47LG6/8Egz/sNObhyYC53IZnp2yeTThVz0o94TE63Ic
	T+S7xoTKDi8AdNlnN8tYTEvUn//CkprdopSt7svhUGqTsaTSv2nM4ecHj6wsnWkt
X-Gm-Gg: AYBFou1H0OeJCmmlPIQyY1tjWbcAsECMrPjx0dH8HSc3i/f5P2I9O/avMhZ7fpIZ8hl
	kbvm3+eD9OfKAtvUzzAHByv8/2BYXVlr+eOaIUahGaWOVwx1Xf9xJ0XIzpKkiZAx7WMYR6TKuTM
	u9mpEC73xn2I4+KjuOaII2hirrhXT7o6RXsTaohUIy+BC2Ex972gt3V7n/+gvb8Hzo87c5e46UM
	bmduOi1iyfkE0gAX0j9UqCcZ2vqVQTqAbG2RqU7kWOvtMRvktMF3ZqRSkXxoYr1BwvZufb6b80q
	atF1vD6b8+XPxJHVaotgxPwMTNbMGR80uZJAqkzU1lAVhBxvvBjeZ/0dN8Clki6+lYU/sLUcE07
	CoyUwEiYJS+7r/K/xZBRFaLDYhWGL2RWGm304eXSXswIvSgrm6k4q64WlcJUyCfiRZY6NU/8aNO
	l9vepy3fqik+GYS0TD0xny8WT9qau4YJdNnW0dE8ykcz5QVBmCVdTzzErs
X-Received: by 2002:a05:6402:2110:b0:6a7:ea53:f61e with SMTP id 4fb4d7f45d1cf-6a812fbf245mr2702259a12.29.1788780009629;
        Mon, 07 Sep 2026 04:20:09 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20a41sm4200117a12.31.2026.09.07.04.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:20:09 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v3 5/6] test: Add open_tree_attr syscall test
Date: Mon,  7 Sep 2026 14:18:42 +0300
Message-ID: <20260907111843.26746-6-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907111843.26746-1-frezidok1@gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 11:20:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4746

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

Covers basic wrapper functionality when using syscall(SYS_open_tree_attr, ...), also tests AT_EMPTY_PATH flag and related paths using dirfd != AT_FDCWD.
The test uses attr == NULL, because using mount_attr in this call starts mount-specific privilege checks which end up with EPERM.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 test/test-open_tree_attr-syscall.c  | 165 ++++++++++++++++++++++++++++
 test/test-open_tree_attr-syscall.sh |   5 +
 2 files changed, 170 insertions(+)
 create mode 100644 test/test-open_tree_attr-syscall.c
 create mode 100755 test/test-open_tree_attr-syscall.sh

diff --git a/test/test-open_tree_attr-syscall.c b/test/test-open_tree_attr-syscall.c
new file mode 100644
index 0000000..4b656cb
--- /dev/null
+++ b/test/test-open_tree_attr-syscall.c
@@ -0,0 +1,165 @@
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
+    int rc = test_no_flags() || test_at_empty_path() || test_relative_dirfd();
+
+    cleanup();
+
+    return rc;
+}
diff --git a/test/test-open_tree_attr-syscall.sh b/test/test-open_tree_attr-syscall.sh
new file mode 100755
index 0000000..3e50ebe
--- /dev/null
+++ b/test/test-open_tree_attr-syscall.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+./test/test-open_tree_attr-syscall
+
+PSEUDO_IGNORE_PATHS=/ ./test/test-open_tree_attr-syscall

