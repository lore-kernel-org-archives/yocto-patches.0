Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A949D47CA5
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 23:43:50 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.764.1768520625058314019
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 15:43:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 60FNhbjl2408772;
	Thu, 15 Jan 2026 17:43:42 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, richard.purdie@linuxfoundation.org
Subject: [pseudo][PATCH 16/20] Update COPYRIGHT files
Date: Thu, 15 Jan 2026 17:43:32 -0600
Message-Id: <1768520616-7289-17-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1768520616-7289-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 23:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2991

From: Mark Hatle <mark.hatle@amd.com>

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 guts/COPYRIGHT                    | 2 ++
 ports/darwin/guts/COPYRIGHT       | 1 +
 ports/linux/guts/COPYRIGHT        | 2 ++
 ports/uids_generic/guts/COPYRIGHT | 1 +
 ports/unix/guts/COPYRIGHT         | 2 ++
 5 files changed, 8 insertions(+)

diff --git a/guts/COPYRIGHT b/guts/COPYRIGHT
index 1b478d1..db589b4 100644
--- a/guts/COPYRIGHT
+++ b/guts/COPYRIGHT
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2008-2014 Wind River Systems, Inc.
+ * Copyright (c) 2018 Peter Seebach/Seebs <seebs@seebs.net>
+ * Copyright (c) 2020-2026 Yocto Project Contributors
  *
  * SPDX-License-Identifier: LGPL-2.1-only
  *
diff --git a/ports/darwin/guts/COPYRIGHT b/ports/darwin/guts/COPYRIGHT
index b860a36..6cbbc41 100644
--- a/ports/darwin/guts/COPYRIGHT
+++ b/ports/darwin/guts/COPYRIGHT
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2008-2010 Wind River Systems, Inc.
+ * Copyright (c) 2018 Peter Seebach/Seebs <seebs@seebs.net>
  *
  * SPDX-License-Identifier: LGPL-2.1-only
  *
diff --git a/ports/linux/guts/COPYRIGHT b/ports/linux/guts/COPYRIGHT
index b860a36..1c33800 100644
--- a/ports/linux/guts/COPYRIGHT
+++ b/ports/linux/guts/COPYRIGHT
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2008-2010 Wind River Systems, Inc.
+ * Copyright (c) 2018-2019 Peter Seebach/Seebs <seebs@seebs.net>
+ * Copyright (c) 2019-2026 Yocto Project Contributors
  *
  * SPDX-License-Identifier: LGPL-2.1-only
  *
diff --git a/ports/uids_generic/guts/COPYRIGHT b/ports/uids_generic/guts/COPYRIGHT
index b860a36..6cbbc41 100644
--- a/ports/uids_generic/guts/COPYRIGHT
+++ b/ports/uids_generic/guts/COPYRIGHT
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2008-2010 Wind River Systems, Inc.
+ * Copyright (c) 2018 Peter Seebach/Seebs <seebs@seebs.net>
  *
  * SPDX-License-Identifier: LGPL-2.1-only
  *
diff --git a/ports/unix/guts/COPYRIGHT b/ports/unix/guts/COPYRIGHT
index b860a36..79da56d 100644
--- a/ports/unix/guts/COPYRIGHT
+++ b/ports/unix/guts/COPYRIGHT
@@ -1,5 +1,7 @@
 /*
  * Copyright (c) 2008-2010 Wind River Systems, Inc.
+ * Copyright (c) 2018 Peter Seebach/Seebs <seebs@seebs.net>
+ * Copyright (C) 2020-2026 Yocto Project Contributors
  *
  * SPDX-License-Identifier: LGPL-2.1-only
  *
-- 
2.43.0


