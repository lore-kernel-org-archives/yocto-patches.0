Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFECC624D7
	for <webhook@archiver.kernel.org>; Thu,  3 Sep 2026 10:17:45 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4531.1788430661205561692
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Sep 2026 03:17:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gPrpNZZE;
 spf=pass (domain: gmail.com, ip: 209.85.208.47, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a68ca482e2so2151693a12.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 03 Sep 2026 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788430659; x=1789035459; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMGQ002/v2mGn7BwWDUuz7PwpBywE2C2/RE1Uu4eiRM=;
        b=gPrpNZZEbGgpnDMvgs60eJC7byi/kO0C4RRYQ3zHIaGEmtbQVu8Oq1QcnrEGR84+dk
         JnhUFTZAyTcENgBuXluqt8NWtrsdqYwUhjYhtmnejctVit/B49/GclJFilbWGb4qiFb9
         aaY7wKvXJmmazer/F8MqZgh4inUGIowhYlBs2ed6dtkzEShupEVo/CRavRXF11crcoW/
         GrVSRB0aY6OJsmMqmvVNxip6ItUMMBQRj0IZFR/9zulwUERha5OnrUc0weHlwPiCb3Ac
         7dkvEdoceIZoBHTXevo9zSEtw5FA/sG/lqZl1TRWDq3zhGF4rtqYwppQG3btfzq4+TJr
         PObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430659; x=1789035459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HMGQ002/v2mGn7BwWDUuz7PwpBywE2C2/RE1Uu4eiRM=;
        b=NTeST6UeYNbW4XAa1TeVpJ9vwhAcD4Hb4+HQTzUM7+FKXJIUPUSelyRfak7xm2otVe
         N62YNvje6zfzAs/nl6Z+6VDcLptT9iFWE6PVemgL4ZUMtFPcALjab1kP39B0Fu2cIo1U
         DuiX4gbs0Qdtnzqz4t/PEfA3oia6/PpCvtByq0nMU4Yr4tHi79BbRR8VkjP1Qc9UWfEo
         U2FBko3TgT96l+KGchr2r6fcHQugpSFBD+dsFSymlLrKHrWRkcTaNCDwsI6V0LOrtqSr
         IXcwouap9aQYY5JiFCrPKInlEXTCVtVAwh8/S1RN9U9NZMnwjh/ltaybXK/j4p2qPUt2
         PUkQ==
X-Gm-Message-State: AFuF++ljQIpigQOFHzRcc4ukYpl4ZJ1NUV8ZYBm+9FOiEGCIEoagDsKS
	HaaPre6DfporTPtd1gPikeUHx73//j3iz+83FgCFy4g+vT0x/czb0GQqGozQXOMA
X-Gm-Gg: AYBFou2Cl08yGd0qgalLkQxFYKmbS4UvFObuzkEZJ/RRTIIqnvtPacg8h4/Dovai+z8
	46TP5gAvqUZ6D1PZrLevBfiHA9LnATli0uj7m2la5eh8YeWf++ZM2V4ADofrz6xtX5Fo7QUvS4Q
	fFdoZc+A0/X3E/GoaDEcNoYvyphOMpbWuzK/x/aGy5mVObSGElnohXWecREjG8hZTr2ucM0Z80C
	6/TBvXUnAFGjLXxje6Nozx5Pqj0KabxoydEPNSlbhG4X++Gv6V0T5s+W6Tuv0/EJjU67yTOoXqx
	jT03tQbB1/udqH7j+Z8yd4tdWq9gPD/u1V7uzqhaSFcBvlbkQv1XUW3S9RRjhM61UbsFqtr8oXK
	P+Z/P+IwqabKNHDwa6eWP7CFHChEP2x/12HZG+i64VHRGlJLXC58MgwIPSWoy6C07B5l4KKmoA9
	kFt9i9NNT3MYro2e7GPEDrlIu40N8PGnFWpCY9WiWOe290FvXBRJh4VX7tqE9rhx6URjc6+t09Q
	eRU7PI=
X-Received: by 2002:a05:6402:5515:b0:6a1:23f3:26b7 with SMTP id 4fb4d7f45d1cf-6a6829b02f6mr7692158a12.14.1788430659113;
        Thu, 03 Sep 2026 03:17:39 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f95f557sm2181728a12.31.2026.09.03.03.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:17:38 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH 2/2] test: Add open_tree test
Date: Thu,  3 Sep 2026 13:16:38 +0300
Message-ID: <20260903101638.371901-2-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903101638.371901-1-frezidok1@gmail.com>
References: <20260903101638.371901-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Sep 2026 10:17:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4727

From: Dmitry Sakhonchik <frezidok1@gmail.com>

[YOCTO #16379]

Covers basic open_tree wrapper functionality and the AT_EMPTY_PATH case.

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 test/test-open_tree.c  | 101 +++++++++++++++++++++++++++++++++++++++++
 test/test-open_tree.sh |   5 ++
 2 files changed, 106 insertions(+)
 create mode 100644 test/test-open_tree.c
 create mode 100755 test/test-open_tree.sh

diff --git a/test/test-open_tree.c b/test/test-open_tree.c
new file mode 100644
index 0000000..b1d9c81
--- /dev/null
+++ b/test/test-open_tree.c
@@ -0,0 +1,101 @@
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
+    int rc = test_no_flags() || test_at_empty_path();
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

