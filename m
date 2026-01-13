Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1751FD2D114
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 23:17:36 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.72920.1768346253465982773
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 13 Jan 2026 15:17:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S6friGYJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47774d3536dso2728995e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 13 Jan 2026 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768346251; x=1768951051; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0dk1D1dSI4+Em/wzNmfWzw1Ftb5BQWw5aSX4WE76bA=;
        b=S6friGYJ4vTbtt/YKxJbI6jK7ztfe/3Ewhz3CWjqglI0N2PZQirY9e22ig+JHw6GOl
         A99w27/O/NgdMaj9HP/stjomJ75S6qyiBS/kWbsEiRmZ2imt6cDybvCMTb9tzyq0Etpr
         dV8QMLdSwq5llfWP5kQBPt/cEXRXZtKICm1zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768346251; x=1768951051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0dk1D1dSI4+Em/wzNmfWzw1Ftb5BQWw5aSX4WE76bA=;
        b=bctdnisNTp90l7KmTIOM+TVgQ3T3hH4u6PvfUPK4T6BBRX8b48cG5fgB7ZuQCMS1YW
         x0LyhgW+0/O9AFon2rt0xKpSBH5zIEZgorNrHt32URkP+1j4RMH7uTNffLbR2z7Lb1fK
         OSEgpafYEZcMVi5kbeuAwT6V3ML4CJzTfuVpULCAJWz0PCVSJfST/kIa8hwYu+iRSsZB
         H5Wv93AkZoSCegA9kqD2EKKOeLHr3SI+cZrXrWLlPQs5NUCe0CWjnF25PD70hFcTU9qF
         3NGQTVBmIeDCUWe0GoKTOyqIaR5V2SGYdLQthFmBeUdXt7VOxOLAeCGjatT0lGu9GeG1
         mQzQ==
X-Gm-Message-State: AOJu0Yzr0/UFCKgmb/SFDLxP2vlPU9xYA3Vk9OFMjo/3F06n0LTxbB04
	CZXTplCD2i9OL82dRPRE2DoIKQ8LbFLDPyIqaKUORt7rHCwWDiM1QqHSkUpcpPglSBAUIm3oLmr
	0HWluoLM=
X-Gm-Gg: AY/fxX4tCGX/ao0uXP4r9FWCaTO4qtWzOmFoJ2rKJNLPCf1JYFwPaBkk6nVDukvQ+uk
	tIfLI6GBqQPONFMhasXCY0lcZwN7820T31twqXUzXiRbYrhssTQ1c2AlNL2W4Ve8kNSpQfzMKA1
	dxt0GUqQlSS1m4pJC6oeAeJGAnUjzPanv1hir9Zi8t47MjQ+9UfU0EQ6RlA436U+qhMhOngFxyz
	ro0imaMt+o9whXHi1Fto7un3MUmcEmB25oqZbmH7ZSnn5ewFV4lgBydOBA3VlHc+P4aIV76C4e5
	/LgazIB3YcpIkkGAUuDy7bcLDrvPJKFbK++Ga4NwTEfhUoORKEJUPHfXXgnxHFR7MxQS3mp+wun
	iFr34xv/bE79tARPn4NEDAEX/XfVjmMT4iJh2YVRx/jYITK/1fkqp664Bc/uM5mNDHvkp8lIRrM
	V4MMQN1cG7be5mUpjObiMruydkKnxMmg2LIRwJlQ==
X-Received: by 2002:a05:600c:6992:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-47ee3775159mr7182635e9.4.1768346251306;
        Tue, 13 Jan 2026 15:17:31 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:143:ebd4:ccef:c4b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695956sm436956115e9.6.2026.01.13.15.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 15:17:30 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 1/3] test-syscall: Add a syscall test
Date: Tue, 13 Jan 2026 23:17:27 +0000
Message-ID: <20260113231729.2698563-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 13 Jan 2026 23:17:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2951

From: "mark.hatle" <mark.hatle@kernel.crashing.org>

Verify the syscalls we intercept are being handled properly.  This usually
means ENOSYS.

In the future we may catch and forward them to wrappers, if that happens
the test can be improved.

Signed-off-by: mark.hatle <mark.hatle@kernel.crashing.org>
---
 test/test-syscall.c  | 87 ++++++++++++++++++++++++++++++++++++++++++++
 test/test-syscall.sh |  5 +++
 2 files changed, 92 insertions(+)
 create mode 100644 test/test-syscall.c
 create mode 100755 test/test-syscall.sh

diff --git a/test/test-syscall.c b/test/test-syscall.c
new file mode 100644
index 0000000..1e21525
--- /dev/null
+++ b/test/test-syscall.c
@@ -0,0 +1,87 @@
+/* This test case must match the implementation in:
+ *   ports/linux/pseudo_wrappers.c
+ */
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <errno.h>
+
+int main(int argc, char *argv[]) {
+    long rc = 0;
+
+#ifdef SYS_renameat2
+    int retval;
+
+    #ifndef RENAME_NOREPLACE
+      # define RENAME_NOREPLACE (1 << 0)
+    #endif
+
+    /* The two paths don't exist, but we're just checking on error what the errno is. */
+    retval = syscall(SYS_renameat2, AT_FDCWD, "empty_path_1", AT_FDCWD, "empty_path_2", RENAME_NOREPLACE);
+    if (retval != -1) {
+        errno = 0;
+        printf("renameat2: fail: function implemented\n");
+        rc++;
+    } else {
+        if (errno != ENOSYS) {
+            printf("renameat2: fail: function implemented: %s\n", strerror(errno));
+            rc++;
+        }
+        else
+            printf("renameat2: pass\n");
+    }
+
+#endif
+
+#ifdef SYS_seccomp
+    /* We should verify this was intercepted, but at present we're not able to. */
+    errno = 0;
+    printf("seccomp: skip\n");
+#endif
+
+#ifdef SYS_openat2
+    struct open_how
+    {
+    #  ifdef __UINT64_TYPE__
+      __UINT64_TYPE__ flags, mode, resolve;
+    #  else
+      unsigned long long int flags, mode, resolve;
+    #  endif
+    };
+    #  define RESOLVE_NO_XDEV	0x01
+    #  define RESOLVE_NO_MAGICLINKS	0x02
+    #  define RESOLVE_NO_SYMLINKS	0x04
+    #  define RESOLVE_BENEATH	0x08
+    #  define RESOLVE_IN_ROOT	0x10
+    #  define RESOLVE_CACHED	0x20
+
+    struct open_how how;
+    memset(&how, 0, sizeof(how));
+    how.flags = O_DIRECTORY;
+    how.resolve = RESOLVE_IN_ROOT;
+
+    int fd;
+    fd = syscall(SYS_openat2, AT_FDCWD, ".", &how, sizeof(how));
+    if (fd == -1) {
+        if (errno != ENOSYS) {
+            printf("openat2: fail: function implemented: %s\n", strerror(errno));
+            rc++;
+        }
+        else
+            printf("openat2: pass\n");
+    }
+    else {
+        printf("openat2: fail: function implemented\n");
+        rc++;
+    }
+
+    close(fd);
+#endif
+
+    return rc;
+}
diff --git a/test/test-syscall.sh b/test/test-syscall.sh
new file mode 100755
index 0000000..69774db
--- /dev/null
+++ b/test/test-syscall.sh
@@ -0,0 +1,5 @@
+#! /bin/sh
+
+mypath=$(dirname $0)
+
+exec ${mypath}/test-syscall

