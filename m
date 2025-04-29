Return-Path: <hieu2.nguyen@lge.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE3C369D5
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 02:16:33 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.52])
 by mx.groups.io with SMTP id smtpd.web11.4577.1745892988419238098
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Apr 2025 19:16:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: lge.com, ip: 156.147.23.52, mailfrom: hieu2.nguyen@lge.com)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
	by 156.147.23.52 with ESMTP; 29 Apr 2025 11:16:25 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: hieu2.nguyen@lge.com
Received: from unknown (HELO vsl.LGE.NET) (10.218.140.120)
	by 156.147.1.127 with ESMTP; 29 Apr 2025 11:16:25 +0900
X-Original-SENDERIP: 10.218.140.120
X-Original-MAILFROM: hieu2.nguyen@lge.com
From: hieu2.nguyen@lge.com
To: yocto-patches@lists.yoctoproject.org
Cc: martin.jansa@gmail.com,
	Hieu Van Nguyen <hieu2.nguyen@lge.com>
Subject: [yocto-autobuilder2][PATCH] schedulers: add meta-webosose scheduled build for scarthgap
Date: Tue, 29 Apr 2025 11:16:22 +0900
Message-ID: <20250429021622.309740-1-hieu2.nguyen@lge.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 02:16:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1411

From: Hieu Van Nguyen <hieu2.nguyen@lge.com>

Support to build meta-webosose for both of kirkstone and scarthgap
branches.

Signed-off-by: Hieu Van Nguyen <hieu2.nguyen@lge.com>
---
 schedulers.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index fd2cad6..1fead60 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -642,7 +642,10 @@ schedulers.append(sched.AnyBranchScheduler(name="bitbake-docs-changed",
             properties=repos_dict_for_scheduler("docs"),
             builderNames=["docs"]))
 
-# Run meta-webosose for kirkstone once a week on weekends (2am on Friday)
+# Run meta-webosose for kirkstone and scarthgap once a week on weekends (2am on Friday)
 schedulers.append(sched.Nightly(name='nightly-meta-webosose', branch='kirkstone', properties=parent_default_props('meta-webosose', 'kirkstone'),
                                 codebases = {'' : {'branch' : 'kirkstone'}},
                                 builderNames=['meta-webosose'], hour=2, minute=0, dayOfWeek=4))
+schedulers.append(sched.Nightly(name='nightly-meta-webosose', branch='scarthgap', properties=parent_default_props('meta-webosose', 'scarthgap'),
+                                codebases = {'' : {'branch' : 'scarthgap'}},
+                                builderNames=['meta-webosose'], hour=2, minute=0, dayOfWeek=4))
-- 
2.48.1


