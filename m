Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465FBC624D3
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 13:07:37 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13455.1788527253864695927
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Sep 2026 06:07:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CANSv0DF;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a7f27637d6so434594a12.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788527252; x=1789132052; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUI0zKjnqjI+sec4GtFQHNNYI3Dnad07oz3NpR89usg=;
        b=CANSv0DF1AnYkzGWaFyycx0aii/b8H8kOW6q90CozxTkOFe0+GzH8WlRNEDxRdBjl+
         S+xr5QLFkiiSLUBGghiib/SCKBychVFt4C1MkGNrherjaySpLbKJXKjsLsB8Jjhy8Lzb
         P59cLTPZHaCxHv4hrPUFK4cpEtM2TCK+hq4XdNl7q/ViPuGxvzM1f9AXUATzMmrWpF/V
         G9z/gH88Wcck6SoJOqvqYm8xIzfal+tLlGQZUSG3vwquXMG7g2WdXfofbwWwzE6WlHqN
         coUWPDJDT6VBui1CI9WMR6NTZjf72gdDlgwHul0e2pNSPcUeljhL4x6GWLvElLkCjeuU
         v0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788527252; x=1789132052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bUI0zKjnqjI+sec4GtFQHNNYI3Dnad07oz3NpR89usg=;
        b=dLXKRL1jx1YCJ2onvqj0D0hHa14ECGMuLn1ICAGVxv0Kl/5rHkZJt+63mIrKDdnuYW
         SPJ4zrP/Wg3TbnCFo01M9KYWU0qe242AwKGgV15kKyRPvdmywZHYksxtfMWPaouN5DMq
         osw4S4XgJaIY0pU+EFuNskhO+/rMmEh0TfLo+yIcR6MWT12e8HMkRzV8rHVBwbtHmT3F
         WoIPEgVC1myZPI2WKrTVcNscEeiKTmvK4NVmtYF9+WuPb1fTFaj8NYGNZENtzH2WCxmr
         yyvmXfXVBsnzbLDs0L4RHXA6/NNDW5U1R+UO0hfpG4FCMUeYEX3VIMouPcV1SlMys2T5
         jxrg==
X-Gm-Message-State: AFuF++n6ECQ6nC5jRN2ojBFbHSlj8W8N0hzTQEfQQZhQBcLJON8GN/Bq
	ZOY9UtLTem4kr4kXTqKibZNqhYuvLqpWdaE0BSdHgEwEmn/LSHEwW8JOMQcdmW/B
X-Gm-Gg: AYBFou3POqV+Gg1txRXIOg0CjJ40dFwlQt3IhohhdAGsIDJbVuuKapIlSBGXg/qDI/2
	M16h7UfNwwGItLSF56HjOlU2jdNezikTlfcM3RKlH/aPtGDnVwqJnDJHyFQ7Um/SGEVnKOszH19
	bkTIOrSSJezQoByCSuyieyOu00kThARbkr10NPA1YO1UMdwPF5nUvaFo/+xjyfvLjQeFC3RWFeh
	u11C8Mxl2mg4f5BfVT5xkfDVxp/DyM4O2/9CixrGWakV13cNhqxbwGfECDhLmva4JqQY6XvZq47
	TaiG5FeDTDMLV2t/nHAMGU+fYPYp3V/CMgpcb1fvC54fHXAk1Mg4YwrboICUS3r9jsoQqs2bJQ4
	wbuisc6hr/f17kw9UnjiB/0hMVd+9Jv5J9tXFfDsO++i2qIKHf4YsKOdg2O6cgzG+pzlJ4/vR+B
	NOEXZoWKX3XV+9q8TKiU+BTMfzLOo9KD30clTDsknZcrX2RtGTmfY3LEw=
X-Received: by 2002:a05:6402:3553:b0:6a6:32f5:90b3 with SMTP id 4fb4d7f45d1cf-6a7e8f9d860mr2878223a12.21.1788527251873;
        Fri, 04 Sep 2026 06:07:31 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e68c3d88sm1173158a12.15.2026.09.04.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 06:07:30 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v2 2/4] test: Add open_tree test
Date: Fri,  4 Sep 2026 16:06:25 +0300
Message-ID: <20260904130627.453678-3-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904130627.453678-1-frezidok1@gmail.com>
References: <20260904130627.453678-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 13:07:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4730

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

Covers basic open_tree wrapper functionality and the AT_EMPTY_PATH case.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 test/test-open_tree.c  | 139 +++++++++++++++++++++++++++++++++++++++++
 test/test-open_tree.sh |   5 ++
 2 files changed, 144 insertions(+)
 create mode 100644 test/test-open_tree.c
 create mode 100755 test/test-open_tree.sh

diff --git a/test/test-open_tree.c b/test/test-open_tree.c
new file mode 100644
index 0000000..0fc02f4
--- /dev/null
+++ b/test/test-open_tree.c
@@ -0,0 +1,139 @@
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
+    int rc = test_no_flags() || test_at_empty_path() || test_relative_dirfd();
+
+    cleanup();
+
+    return rc;
+}
diff --git a/test/test-open_tree.sh b/test/test-open_tree.sh
new file mode 100755
index 0000000..1654a0b
--- /dev/null
+++ b/test/test-open_tree.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+
+./test/test-open_tree
+
+PSEUDO_IGNORE_PATHS=/ ./test/test-open_tree
\ No newline at end of file

