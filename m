Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D35CA5FFC
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 08:12:32 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15161.1791187942846478977
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Oct 2026 01:12:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WZOR2sYt;
 spf=pass (domain: gmail.com, ip: 74.125.225.141, mailfrom: frezidok1@gmail.com)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso8376395e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791187941; x=1791792741; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYks8fJRt6Vd8Ce4kvrMwHiAqbSw8S/YxhOTZ/v6aoI=;
        b=WZOR2sYtE+J9/90mBYnTHIcMdIQbfK2L5c7xTAp/ejcftqxpuNqlx9syajA5sxhJpy
         vl0gM1JJKy3zZajIyJVwk7/2g5VCls6b+4dNd1EUQgk5bb2otE26KNwSkZatxt4ZSEPA
         UIFGLrsbhJNXcxiWT6V0Y8Ofy0IJGdZE78injeHS7tUQtg0jp8/LJsq7otjhmHvK2elr
         kcckpnBjKYdgWHiOWxb0qOt1TzwEUeNvs4QMErN0cBqpJAOLeS9/xlOoa7UbISI+ySBB
         X82OYObq/DVzFL3Q/3BIh9tV9XHddQZJZCd4aytO9EjgIPuIeDddgDc4sGhqqMaJsP4X
         KYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187941; x=1791792741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SYks8fJRt6Vd8Ce4kvrMwHiAqbSw8S/YxhOTZ/v6aoI=;
        b=hlI+ZVG09twCAfiBvwmc9667+0F3vmTmJcmam9L0KxS0dmArxYSTlVIf/xwjJ2ll8X
         r6vqxc8JpugZ5E1blpW6SL+W5JnU66H9CKfb4ORyx6Lur048PVqsEgfYDBnavqyUeFXM
         CEPrnSyTLERD+kXkIsmqP1+c41YJmkeKPMyCLgqedM1isEpY6MpTS22kS8hp89ZihnNz
         NhSq68c+4gmTgKmCnS6FBboxiMxqdsjmYFIWJItFG9QeT+nm5Hws8xmyauW6NZSN/px5
         QX56cMujbYtPC3XOxkXrxXq4lSetDnTrInX/LVgC2+6YzR7PXNfbsjkYga3JiW7VpNmy
         DqMw==
X-Gm-Message-State: AFuF++kTgORKvR5/Q3gfLMzRtz5zUxCdwoREx18z5WXIXFtltNBmYAIg
	IzNK9Ff9iOEupYPxxUtAlcWLND9/a4T7duRmi1OWmCK0L2vE99au7HAf/DTZPzNB
X-Gm-Gg: AYBFou26Zz0ElCRuUc6quMqwStI4qH53DAI9U5A77E3z0BKo+zvoCtiKQ9G06nSP4lj
	gbKojMEBO+Fuf3cr7FHOamMEPkqC29j83c2Ms4r01oTFpLa+gBDtAYLL4jfhTm/110pVEHZDqpJ
	RFbDTObVvBQIZMmRsRc0mGYFPjuBghC7ns8u8H3FE09Z5GaYl4EliTQVSXKSCl3NXlpJp7bPi7n
	qrKzOd2REOlTG54Wa6sHgAgs+hZt/ZzYHpRdXfFUR04I5fQ/UkiLXMetEf3QoZ1DX6WLiHcIJru
	U6IlQF+ihunxM2JX+91FWqaUJ1HBcZR2ql/3dwZ+z+Y6/kW9vEtOwp8IqziXm5INlp33dm6PLHt
	wuvqmsO+bZVCkVNjwRPZqPvmFylQ2y2y9WX44pvbp54MoKgVPzmycfgGR2PeCdWpLNkHhwQ3W/X
	Kqdk5Ek0/TyZqHqALkTt66Z4NP6jK6DofiJcxsVFsf1MifAA1yMAwMknLclHhReIrB8lEYvs3G0
	3ieLtkhO67ay0MG8lk2f0oqp+EY
X-Received: by 2002:a05:600c:8b33:b0:49f:fd2d:23d1 with SMTP id 5b1f17b1804b1-4a027598c41mr164691295e9.27.1791187940866;
        Mon, 05 Oct 2026 01:12:20 -0700 (PDT)
Received: from ubuntu1.. (ppp91-79-47-228.pppoe.mtu-net.ru. [91.79.47.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280d1e38sm268675535e9.13.2026.10.05.01.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:12:20 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v4 4/6] test: Add open_tree syscall test
Date: Mon,  5 Oct 2026 11:11:25 +0300
Message-ID: <20261005081127.107126-5-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005081127.107126-1-frezidok1@gmail.com>
References: <20261005081127.107126-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Oct 2026 08:12:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4987

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

Covers basic wrapper functionality when using syscall(SYS_open_tree, ...), also tests AT_EMPTY_PATH flag and related paths using dirfd != AT_FDCWD.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 test/test-open_tree-syscall.c  | 154 +++++++++++++++++++++++++++++++++
 test/test-open_tree-syscall.sh |   9 ++
 2 files changed, 163 insertions(+)
 create mode 100644 test/test-open_tree-syscall.c
 create mode 100755 test/test-open_tree-syscall.sh

diff --git a/test/test-open_tree-syscall.c b/test/test-open_tree-syscall.c
new file mode 100644
index 0000000..42eeb37
--- /dev/null
+++ b/test/test-open_tree-syscall.c
@@ -0,0 +1,154 @@
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
+    int rc = test_no_flags();
+    rc |= test_at_empty_path();
+    rc |= test_relative_dirfd();
+
+    cleanup();
+
+    return rc;
+}
diff --git a/test/test-open_tree-syscall.sh b/test/test-open_tree-syscall.sh
new file mode 100755
index 0000000..b3cd550
--- /dev/null
+++ b/test/test-open_tree-syscall.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+./test/test-open_tree-syscall
+rc1=$?
+
+PSEUDO_IGNORE_PATHS=/ ./test/test-open_tree-syscall
+rc2=$?
+
+exit $((rc1 | rc2))

