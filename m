Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C89C79F89
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 11:20:10 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32744.1788780007427823607
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 04:20:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=aANSS6wx;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso4608395a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 04:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788780006; x=1789384806; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U51Km27bUin8I6yWA7uWIhFWDB6EZm7iysxiw2UI+Mg=;
        b=aANSS6wxRVfWLT3KUD9ja02EQuC6YVe9zvOVKLTgUG2J7pwBSjZuCuvSHtNOXex9OW
         FYvs6yloTabffG9TcgmNp5V9iKb0DDcZbRzu5YWQO4BxvJAH5f+jz56dA2fThpKu2iEH
         1BFzuBta+Y7bXCpyktAK4Bh5Ax/RUNiwxfIgtOLFrl93wlNU1tmZWa6chg0IFrSc5Jv4
         hOEveMVnO/AEEtdn8DhPI075uV3Fbp581q3PCSkLCVHOxzSmyD7s1EV4cAaGXBErIF6x
         inwIdzQBenhuu/UqXcdTXSPiIUKey/02Qhv2D2sf5Vz/7LMyZwZyoeTacdIcmy8XUzWd
         mqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788780006; x=1789384806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U51Km27bUin8I6yWA7uWIhFWDB6EZm7iysxiw2UI+Mg=;
        b=Ogu0voX+5kNbaSK6jGP5w4DDMNcRtuCJUt0Ri2JA2w3iKoidZRZve9kwbZYsRhtcTX
         fyP81wE9CK+esserWzqNpFIKetDbB2rhK+KLCnueVXnF6Kre2sX+3ho9LVIR+ZJQ15a1
         5XEhZ5Mk3gpSESRkIWVQSZDca4fbb+X3kk/BrD15r7swTduWbexs/qwIXVEnm2Ifyehh
         ZwtCyYNf+TdWEnnDfM2aBRYweq+y0o6qoNomQvEGa0PrCVQoWUTIEcq8yVNMTQXN9GTS
         z0FGQUiuQO1ObYCa4jeTAGnmfklOOGcZW6qNVDWKG+YrJsSq3q9gz5VHbbPW1W4kijC+
         WHmA==
X-Gm-Message-State: AFuF++mBhFwS57iAKKq00TSm/vEootRr5YVYcNrXJDrTRpeUIGd7dNd5
	FLs/NcJjhh6bSHYV8b+K7FOlp+kOutWPF2lax98OoDzBww4tiMhT/6yOARq2A9Qd
X-Gm-Gg: AYBFou3uxgAMiNQ6WURuT/Lbeh+rwslXNeSTPuK7YzHg81/k5pMac35yHzSkXH2760a
	Rc5fY37zqIyWzKdyqwY8u/77n8kAvQHQT6xCslEclHGBwkRKXsqarSi6ZEolHZH9vUXjGUAukbj
	xzZshkAYqrNwPYbpIap42hGeGTQ6E4j2LbiTa3uPFRfF84GJedFSbSeNhga2qlVCaMJt+3ycNft
	/cBUPfS4ylfw5m540IXIgAsM4X6DUyd7PGjcC5kwGkIwq4s0a6KMXKXsOzXi0ivOOibdhkQBRNS
	60GEGf8qgpdw49UoLnjdZ/qicjl9UkesqvEMUx8qzv20WutsE53UTe/UfuZbSlF2T8KbuReV/jK
	hgZRcU1e9LHrmtnySgZw7vQ05igM2xktix2L2N6WhYspBJ6DeQtSnqKjwfDHmMdHk5nzJICBEol
	l4NGcpcIMICpi9IZJQsuWhUAk8b5fAK5TeULgQAmEjBX/DwmHe9A9OTFJZ
X-Received: by 2002:a05:6402:4348:b0:6a7:e5e3:35a7 with SMTP id 4fb4d7f45d1cf-6a7e8e92bffmr7061317a12.18.1788780005404;
        Mon, 07 Sep 2026 04:20:05 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6c20a41sm4200117a12.31.2026.09.07.04.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:20:04 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH v3 4/6] test: Add open_tree syscall test
Date: Mon,  7 Sep 2026 14:18:41 +0300
Message-ID: <20260907111843.26746-5-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907111843.26746-1-frezidok1@gmail.com>
References: <20260907111843.26746-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 11:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4745

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

