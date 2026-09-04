Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B3AC61DD6
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 13:07:57 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13468.1788527271255379954
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Sep 2026 06:07:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=U2dZgNPO;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so1432417a12.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788527269; x=1789132069; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U51Km27bUin8I6yWA7uWIhFWDB6EZm7iysxiw2UI+Mg=;
        b=U2dZgNPO84jF+BOme0Ftr7GwhfRRSqN+Xg/gxd2kUB6CnNvIrfkBqdMtMUghAJhH7n
         pS7QhcY5q59ZjNXopVGrOjcF3w56A+L1lDGrENPWtRzu+gyvtUiSX3x1NukKOSgBZBuJ
         kRtjpMvLZ6gw6muNIF/9N8mD7lX/QVRfryt8/t5AdYKFwkmYGPKi5ozRkUz+lnuWbske
         swjkROP9ztsXbzeRs3T/4jQn6WvN7EHMo6p7LNMEnybtxO9Jfk/5bG5w5nXutWfTACRl
         tO4WbiZG63+2MM3WKNJdZ3uuEHpSv/kkWyXW3hiqqhocwoTzquNPJo0PneE3LVKvZH8m
         F0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788527269; x=1789132069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U51Km27bUin8I6yWA7uWIhFWDB6EZm7iysxiw2UI+Mg=;
        b=OBNW6/vfD8Y298tU+f3hMzaIVQrzntj2KbZdFl8rCsllQmEJp72l6eeTUixqaKh+dn
         7tRrR+sMjDI2/oXrt+TTT4MT9H/JFKau5l+VyU49j+t6moWyITb1YVw5/s5bAO/zfieC
         na7MNDQcvzDRig61ciYX+Srb7ag7BvE2cLfdZg2v/gZPyVjOqLdX38dTIVE+FfwOLO3N
         sEoHWNFfHCVbrp5AkacUKLRUJgZG7mZ4ufSvj9qYYx44zAcN/J42Sa2b2sGx7HHLYxAq
         NiGDMbAK1pCJcl7aHOLP3W/hjctN8yG49RDIzL/Q5fXDOwsihnXUpDek3q5Jzqu1HMUF
         TvIA==
X-Gm-Message-State: AFuF++lKO0GOtrIa//iNg+nBarDwSjYw33IBneVMkfgDBBwjPMbrZInN
	NBHbsT1MCFk9bjKe8PUrCpWbmVJmpXxugDQSa/ZXjYh55zkfSqha9sfBQGb3C1LO
X-Gm-Gg: AYBFou0i5TBxBM6cFoZjHcVjpEeImMZkWTTtlspXIbF0/7nmN35riPsL9KeyBfkjedF
	eie5AYDyuTxZBwsP8OZHlzyOIbwIJ/ELb6ea/QuU9ntrpxZfFf0oCscKzQR+fpB7UVtrNH/bp74
	OoEHdcXiev4gZyNlHsiBL43XNAmiPYiASCXHev3ZokI38/88nqZ7zixvxm8cRz/BO1vLW/IIxI2
	zpNEhHy6jTVrq0thCjjQkHS68D10o+3eju8MKpGJfDu/7QzX69bkSZbzXWkRhFOiMcRJbqtYchs
	EKDBzI5NXT4WF9m5A8kiYnpLB9SLccCaWXSYOsT8bKPViRiGxeQPjn1u2BJchKKvQkT7Q96UAtH
	gP/KrvZl3e9qLJCTuV3OP7H1KEXXR/jZZ4TPYLqK1h2SF2G/Jm8mQHfIGHeHsoe11s8fuWhDuYT
	GmUKqKGTaHM/SJ1WnNcIUkXWmppyGSnTF50Lyt7TILhba2DV5CTxhgFjI=
X-Received: by 2002:a05:6402:a0ca:b0:6a7:f25b:d281 with SMTP id 4fb4d7f45d1cf-6a7f25bd43dmr505305a12.13.1788527269096;
        Fri, 04 Sep 2026 06:07:49 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68c3d88sm1173158a12.15.2026.09.04.06.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:07:48 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v2 4/4] test: Add open_tree syscall test
Date: Fri,  4 Sep 2026 16:06:27 +0300
Message-ID: <20260904130627.453678-5-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904130627.453678-1-frezidok1@gmail.com>
References: <20260904130627.453678-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 13:07:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4732

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

Covers basic wrapper functionality when using syscall(SYS_open_tree, ...), also tests AT_EMPTY_PATH flag and related paths using dirfd != AT_FDCWD.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 test/test-open_tree-syscall.c  | 152 +++++++++++++++++++++++++++++++++
 test/test-open_tree-syscall.sh |   5 ++
 2 files changed, 157 insertions(+)
 create mode 100644 test/test-open_tree-syscall.c
 create mode 100755 test/test-open_tree-syscall.sh

diff --git a/test/test-open_tree-syscall.c b/test/test-open_tree-syscall.c
new file mode 100644
index 0000000..03f5618
--- /dev/null
+++ b/test/test-open_tree-syscall.c
@@ -0,0 +1,152 @@
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/stat.h>
+
+#define TEST_DIR "test-open-tree-dir"
+#define TEST_FILE "test-open-tree-file"
+
+static int do_open_tree_syscall(int dirfd, const char *path,
+                unsigned int flags)
+{
+#ifdef SYS_open_tree
+    return syscall(SYS_open_tree, dirfd, path, flags);
+#elif defined(__NR_open_tree)
+    return syscall(__NR_open_tree, dirfd, path, flags);
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
+    treefd = do_open_tree_syscall(AT_FDCWD, TEST_DIR, 0);
+    if (treefd == -1) {
+        perror("open_tree");
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
+    treefd = do_open_tree_syscall(basefd, TEST_DIR, 0);
+    if (treefd < 0) {
+        perror("open_tree");
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
+    treefd = do_open_tree_syscall(dirfd, "", AT_EMPTY_PATH);
+    if (treefd == -1) {
+        perror("open_tree");
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
diff --git a/test/test-open_tree-syscall.sh b/test/test-open_tree-syscall.sh
new file mode 100755
index 0000000..3cb4d96
--- /dev/null
+++ b/test/test-open_tree-syscall.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+./test/test-open_tree-syscall
+
+PSEUDO_IGNORE_PATHS=/ ./test/test-open_tree-syscall
\ No newline at end of file

