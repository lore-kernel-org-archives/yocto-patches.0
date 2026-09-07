Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD97C79F89
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 11:19:50 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32734.1788779988072933783
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 04:19:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=eaR5PdZs;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a82c103580so419215a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788779986; x=1789384786; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUI0zKjnqjI+sec4GtFQHNNYI3Dnad07oz3NpR89usg=;
        b=eaR5PdZs/w5oTbYyQ0abS8sIymhasvq2Sdk2JDhAhMl7cWuZ5l8DYpJuR8G9FBrSpX
         cRdZ/j1Of0oVWMGwjClLOUxdypoUScTCLTUeSWhND/ZTNZJBm/b6BF79fUq2migsEweT
         aodZqZ5eEAX/dvXsLzFGmEkADIqXE9MqVaBaQxGRa7eF4Z92g9wOSlLkP17V3xYyWTS3
         9tVd6y+J9pSutacirYTSzYyAnkLZ3NPGXQjG4LfagpPYPSMOf1fYrEA3Qk9FSRWPAPjB
         qfh8SRvwehcD4kMCHq7qkUzEVuUBhQrMJ4ZLgrXtO1z1V4VMzrl9QWI2hGu/nRPgSu3L
         dhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779986; x=1789384786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bUI0zKjnqjI+sec4GtFQHNNYI3Dnad07oz3NpR89usg=;
        b=Ow562+gAwsqP8v9YEklyV/8mQbUV27rNqAzp93IKYMK3QIVzgMEhqICLXTjFpZ06V+
         MxrFHRz4gcgXXMLYEQCIfczHZEnqgpK3nApdq7W44PbDWceoGzbml2pKiq+WlnrNRC3d
         KAyWApREFAMNMy1f1cvFKMomYVhwqbwKXbgoSCXKppbvLw3K8Fxl4L/duwupdG78Q+Pq
         HW3wwTe0CmNsiSZiKTqTB1YLc2ZwFjEZteYC1VjPsevT8pAeaE+B45thoj4jv2GtSfHD
         RZMS8AMibivIacHiMjz6tKs/HUT/cxkiKzP/BLKITjNp+e5EAJEc1mBM8e7FjtXbWEDR
         YoeQ==
X-Gm-Message-State: AFuF++mnz3v3s/wREFjX26rLZDze9enqia2kiEgJ/g4i+lGnxJ1TlpMv
	tWxnKTAgchduR/x4fkaX4k6j3H/D69KUV7vg+8GhGRFBpXTRPOzqPHmcP9RGBDPy
X-Gm-Gg: AYBFou3G8eEWmZxY/WcL/NHVBXeAhGRGDYVk4RpBoQFMfTva2VlXyIzPNBiFAmA8zRm
	DIIxn8imAszZZEDD7YtuO2t83Iiq670Rn9/CHjw0bPC/kqh/cGx8LsB22uajiw1bLDY0gfhOoIj
	kszCi+Jwfmh6bsp8J4ANzY5QAPGyWtqxGYclzjJufVETh9rhoiPli8y7/Th4mKvlYpt1LmebbWx
	z2yDVu1/Tanrazi2bFCVKSC2lqiblIMXva1dOT/dbCrCTCRVKjRIHUAIawiqdoFbNxF6w9/9xxO
	JXjvyur62rX20f3JZXtOnif8kD8cTECdIminpmJG4vjr3/jcwdofcR6/uJ5ci4uMOgIXXZpyss4
	rXXQRETECrfDBHDiUywkU1OePQ/SMLV4es4CxQs3ZY8o4H92bOMy2fzI2veyEcPbNfqhThSzTLY
	xsYHep9jiLV1J63q5xzvnsONVerrzg2DSC1TWSKPGZ8ApaQCn8lmfcm9fLTg==
X-Received: by 2002:a05:6402:42c6:b0:6a6:32fa:1e99 with SMTP id 4fb4d7f45d1cf-6a7e90b8f43mr8031778a12.17.1788779986006;
        Mon, 07 Sep 2026 04:19:46 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20a41sm4200117a12.31.2026.09.07.04.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:19:45 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v3 2/6] test: Add open_tree test
Date: Mon,  7 Sep 2026 14:18:39 +0300
Message-ID: <20260907111843.26746-3-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907111843.26746-1-frezidok1@gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 11:19:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4743

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

