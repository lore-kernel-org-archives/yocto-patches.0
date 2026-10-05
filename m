Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5057CA5FCE
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 08:12:22 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15218.1791187936286870334
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Oct 2026 01:12:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nHjzJnrI;
 spf=pass (domain: gmail.com, ip: 74.125.225.141, mailfrom: frezidok1@gmail.com)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso12440475e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 01:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187934; x=1791792734; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PQ9OtYQz/ILSUSpuY3QKpve236/B7A1PMMq1AdJSML8=;
        b=nHjzJnrIlMUefP40Dp+5F+HGAL0ahu7cykhANkc8cDl4GfkrfGXPErlFej6u/2Y7S1
         aTfwNYYMvIz79Yh9d/zRBxsI3fxVTSQAaI8X/kjvqIp97nEOtpR9sjL11t2p9Yo1hkTX
         RVvypDBfFIUNPngk6j9mrtl1CiGA29ibd1Nkkc1UaITBVDCkYffPWROC7DOyvkRDMrW7
         miti8b32b4rL5U7HrGUI4ycj7+qW41Z3BKkzQG9KmPgxdmlbl2p23vszHRU+Aiauw4yD
         D7fJR/LKDQpcHpkqVNBjsQsvF7EU+vF77LPHw7NZZnffCoYnOeXFB5DRa1EO5uGiu9wZ
         mCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187934; x=1791792734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PQ9OtYQz/ILSUSpuY3QKpve236/B7A1PMMq1AdJSML8=;
        b=NBU20ikmQHqLXyFoi4//pOq3jz6VK4RnZCu4WhMBADur8MSlf7hyG7Ku9KqGNTBpWD
         TCn7dGrLyYzIjqqYNZyRyIeRKcR8fylWsCircZBLlu0MVj426fihYhYqgTgYLtkg4ORo
         VoTSIA9FI6t/0R50jkltPnNhwG3aKbiw6cL59Sjab8AfrHp4TacwisxZ/5DPhFDuegI9
         Fsp8UJqPrvtp4HSf1XSGJo9VpwER/21J/Y5UcPV7dke89Lq2UI+QiYyDFd9UXd15eyVm
         vWPGtXYRQGGsmtIm2PVl613MIDopzPJD5CppfP/9oLi80Hun000mJOQHe3nPG3nzdHPe
         jk5g==
X-Gm-Message-State: AFuF++kMHa7eb+f6S6Up+gtEswDpvl6Z1qTZ3Dnby5oNpN+Nnw2AwxjE
	UBjZG0IHlJ7tg14uX9DRoU7s3HJBh93p6Mo5pztX+PZZrYXfv7XpnEGP3Jy8qQ0D
X-Gm-Gg: AYBFou1orZUGwh2+xYFVuW7Dz1XnRabkf04+AEnU4ps0I5teWVkPh/7vlmTY+9dV/Ni
	dVO8P9GAILMql1L2+uZqP5UM8H/eYbT8X5QiPSVAk0Bgxmd4ukAtPPBYgEQwUUQXSwDCxzUNaiF
	gfi7Pa6/HyHNpRH5M/2YYUNyDuqRisyI5+PVlY8ovmfvUEL6Ho4EwWe+maxFjAA+k2GycgfIvlD
	J296xJvwi1HjOcLS7Jl0b2sRyQRSrdGtbdrxEhyeitsJgwbRwOcQd7mCCBfyTH+MBqI2UNn1XBo
	ivCVOPO5OgaFqHBJ/hfAph9dbjN0Nv7qeKnm7vyPRD/8S502RlFc7Dm44cT1FGUQ/nm7ncReWW0
	E3huOcaDnC/vt2iIAMmjndaqnoaUq8qrbUxEyb2g6+BihDdD4uV/34i+afJ+63J/k7p+t9lWK1a
	uY/Bbo8xrWkCpV6FcMxgdW6WsLiPvSuqbxTZg4c/t2wQ4x+LL/TSKP5bF7yLcmuvSW4hNzDV5LS
	zoeEMazBLKY4Np8ILIJRyF/+xlj
X-Received: by 2002:a05:600c:a011:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-4a0275107e2mr164615535e9.1.1791187934197;
        Mon, 05 Oct 2026 01:12:14 -0700 (PDT)
Received: from ubuntu1.. (ppp91-79-47-228.pppoe.mtu-net.ru. [91.79.47.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm268675535e9.13.2026.10.05.01.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:12:13 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v4 2/6] test: Add open_tree test
Date: Mon,  5 Oct 2026 11:11:23 +0300
Message-ID: <20261005081127.107126-3-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005081127.107126-1-frezidok1@gmail.com>
References: <20261005081127.107126-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 08:12:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4985

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

Covers basic open_tree wrapper functionality and the AT_EMPTY_PATH case.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 test/test-open_tree.c  | 141 +++++++++++++++++++++++++++++++++++++++++
 test/test-open_tree.sh |   9 +++
 2 files changed, 150 insertions(+)
 create mode 100644 test/test-open_tree.c
 create mode 100755 test/test-open_tree.sh

diff --git a/test/test-open_tree.c b/test/test-open_tree.c
new file mode 100644
index 0000000..9570f11
--- /dev/null
+++ b/test/test-open_tree.c
@@ -0,0 +1,141 @@
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+
+#define TEST_DIR "test-open-tree-dir"
+#define TEST_FILE "test-open-tree-file"
+
+static int test_no_flags(void) {
+    int treefd = -1;
+    int fd = -1;
+    int rc = 1;
+
+    treefd = open_tree(AT_FDCWD, TEST_DIR, 0);
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
+    treefd = open_tree(basefd, TEST_DIR, 0);
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
+out:
+    if (basefd != -1) {
+        close(basefd);
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
+    treefd = open_tree(dirfd, "", AT_EMPTY_PATH);
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
+    int rc = test_no_flags();
+    rc |= test_at_empty_path();
+    rc |= test_relative_dirfd();
+
+    cleanup();
+
+    return rc;
+}
diff --git a/test/test-open_tree.sh b/test/test-open_tree.sh
new file mode 100755
index 0000000..427d550
--- /dev/null
+++ b/test/test-open_tree.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+./test/test-open_tree
+rc1=$?
+
+PSEUDO_IGNORE_PATHS=/ ./test/test-open_tree
+rc2=$?
+
+exit $((rc1 | rc2))

