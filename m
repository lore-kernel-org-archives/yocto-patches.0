Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FCCD2D11F
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 23:17:36 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.72584.1768346254848757129
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 13 Jan 2026 15:17:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WqrRHs/P;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so9126925e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 13 Jan 2026 15:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768346253; x=1768951053; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwRWRSEF/DaVz1qv5Ly5Re2l18JpcfF8KGR1OMCLMJk=;
        b=WqrRHs/Py6wuAdZ1zbzgdF7Ptr1qzpbdDmbmy0A5AGwj5rgSR9Ky750z1Ti9L2vI4d
         DFFdp+Gx1NnQeDzCZdIk633YqyKjnAJA2m93FRvsuAbhmds48eioJyfTMxz34gbKjAez
         ThI3V6CUi86DY347opcrvLzTWFvbFTx20Y/n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768346253; x=1768951053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OwRWRSEF/DaVz1qv5Ly5Re2l18JpcfF8KGR1OMCLMJk=;
        b=hOnWbsvb7ECMn6/XtpCAYf6YtLGAIjsjlqv/OFZOTf4l7ci3+OoreAwIy0I/LOBhGS
         xGcDHryoA8uB9vh7OgAUhmckyDFWp3RqeREp8au9dZtg5ictmpfQcZYA7rsVI6F2pl6C
         NLqLp9R2kgrHHaXYYqCJ17xI/oID3Evq6+6QH9xUKa3exOdQMcff7tMoO/OuwigsiODU
         iG/yuy/PiItjVIi5E02X/Py6O2l71meOTLDTrZQ+qMNQHWwHu24qwyALBYvJ/tYzSM+p
         1+cflTEjdMtPvOrc+qOdDlB1n9w+ilM2iNqlFUrLuIjBBlQEfJi0oQCgVFwBtSSEe9FV
         QLFw==
X-Gm-Message-State: AOJu0YyMAKrfWFvBB978OT4Omub+Ekw3WjL1EPweKgZsRwNc/sao/DfU
	0d1i8k6kRELB5gvYKt25tOCZQVRGVy9P241VCC7HTCikaFe7k45+ADgBl6UnMQc+ZQKx7mNpN3d
	0Ki2o1nA=
X-Gm-Gg: AY/fxX4XbTJHeA7o2U8HijNQW/Jii0iSObWQoetelvtXmAlXgrSpx3WC2eeo0b23hfz
	HHnK72JVRd+ylkMfO2VDZ75PegcvyyCarqUS+1tw+pMHHPo7WpLbp7fF1r1O6br4XzQc6FghHwB
	Kuf4ET2JCyf69qm0UYtlR+aMxTH1t0eIRvVruHsUL4Vzef2vyrqqst3aP9CFjY+A9La+lLs7QnT
	1kSwmFWWb2cTvCypNmjWn+uLGYcUqtKHCf4W+Y/o1S2ZmUNivmyxz+yET3RoXz9Bu/UrqYOh7Xs
	ucBal1eaR7y+6vfekiha9TdVuyHW9ZuRNVSGe9x1OH37leEzOsVZOpbpsjs3cDgYs4QWLnvY25P
	4LnjqkiCnHPedvkmh8+jJaNKbLDCf9TmhWe1Dfamj9b8nBGKd6gI6UeFaDIqkaqhsHQIfGoCWlj
	XNa3VxVA4pmCNUK1WizL3RzQtycc6/UxezRRsEuw==
X-Received: by 2002:a05:600c:8183:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-47ee47bb085mr1993775e9.1.1768346252672;
        Tue, 13 Jan 2026 15:17:32 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:143:ebd4:ccef:c4b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695956sm436956115e9.6.2026.01.13.15.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 15:17:31 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 2/3] ports/linux/openat2: Add dummy wrapper
Date: Tue, 13 Jan 2026 23:17:28 +0000
Message-ID: <20260113231729.2698563-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260113231729.2698563-1-richard.purdie@linuxfoundation.org>
References: <20260113231729.2698563-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 13 Jan 2026 23:17:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2952

From: "mark.hatle" <mark.hatle@kernel.crashing.org>

For now fail politely, most callers have fallback behavior.

Signed-off-by: mark.hatle <mark.hatle@kernel.crashing.org>
---
 makewrappers                       |  1 +
 ports/linux/openat2/guts/openat2.c | 23 +++++++++++++++++++++++
 ports/linux/openat2/portdefs.h     | 13 +++++++++++++
 ports/linux/openat2/wrapfuncs.in   |  1 +
 ports/linux/subports               |  2 ++
 5 files changed, 40 insertions(+)
 create mode 100644 ports/linux/openat2/guts/openat2.c
 create mode 100644 ports/linux/openat2/portdefs.h
 create mode 100644 ports/linux/openat2/wrapfuncs.in

diff --git a/makewrappers b/makewrappers
index 67c73e2..0d73cc1 100755
--- a/makewrappers
+++ b/makewrappers
@@ -209,6 +209,7 @@ typedata = {
   'ssize_t': { 'format': '%ld', 'value': '(long) rc' },
   'struct group *': { 'format': '%p', 'value': '(void *) rc' },
   'struct passwd *': { 'format': '%p', 'value': '(void *) rc' },
+  'struct open_how *': { 'format': '%p', 'value': '(void *) rc' },
   'uid_t': { 'format': '%ld', 'value': ' (long) rc' },
   'void *': { 'format': '%p', 'value': 'rc' },
   'void': { 'format': 'void%s', 'value': '""' },
diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/guts/openat2.c
new file mode 100644
index 0000000..da01b31
--- /dev/null
+++ b/ports/linux/openat2/guts/openat2.c
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2026 Mark Hatle <mark.hatle@amd.com>; see
+ * guts/COPYRIGHT for information.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * int openat2(int dirfd, const char *path, struct open_how *how, size_t size)
+ *	int rc = -1;
+ */
+
+	(void) dirfd;
+	(void) path;
+	(void) how;
+	(void) size;
+	/* for now, let's try just failing out hard, and hope things retry with a
+	 * different syscall.
+	 */
+	errno = ENOSYS;
+	rc = -1;
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/linux/openat2/portdefs.h b/ports/linux/openat2/portdefs.h
new file mode 100644
index 0000000..8e4e33e
--- /dev/null
+++ b/ports/linux/openat2/portdefs.h
@@ -0,0 +1,13 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ */
+#if __has_include (<linux/openat2.h>)
+# include <linux/openat2.h>
+#else
+  struct open_how {
+        __u64 flags;
+        __u64 mode;
+        __u64 resolve;
+  };
+#endif
diff --git a/ports/linux/openat2/wrapfuncs.in b/ports/linux/openat2/wrapfuncs.in
new file mode 100644
index 0000000..96ae8a7
--- /dev/null
+++ b/ports/linux/openat2/wrapfuncs.in
@@ -0,0 +1 @@
+int openat2(int dirfd, const char *path, struct open_how *how, size_t size);
diff --git a/ports/linux/subports b/ports/linux/subports
index 099ea59..b202c27 100755
--- a/ports/linux/subports
+++ b/ports/linux/subports
@@ -70,3 +70,5 @@ else
 fi
 rm -f dummy.c dummy.o
 
+# For openat2, similar to statx, we need to be able to build on systems without that support.
+echo "linux/openat2"

