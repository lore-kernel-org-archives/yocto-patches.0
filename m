Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57282D12679
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 10:14:48 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.14361.1730801679325813250
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 Nov 2024 02:14:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=hOy6p2H6;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83822C0006;
	Tue,  5 Nov 2024 10:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730801677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q8wscAguuOrgii7azOdh9vsP/JZbq/J9o4Jc+Wx6poM=;
	b=hOy6p2H6NnfvF58vRqxMjec0+nFIspvAmAU9hi6G4gv8++7x4zKrppg510ANrpOoLLcr/C
	DBrzTP5wG0haXUjgQvcWnIxDL07fsuMTJ9buo6Stfq/CwVZzOenGztThJEs+emF2kn0pJ8
	dmrHNq7337DAbXpZmxCWeRDoVAEBHPHv3VEVgVdnsGUu6nE6dlTDvzaGt0PMESdDgnM+Zh
	Wc/Y7NXwr8obbdwFP2WX8+d6FXqTR7N9rmMoSPV4Z6Uc1Dk9aB6ePsNdOw/dBle6iGI3fD
	WKFWgIwiVhvlmyiDf20oe8qmwfLgu/e5WDdbQTy2k+ZZCGW1KIHKGqMIfucLwQ==
From: mathieu.dubois-briand@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: Hieu Van Nguyen <hieu2.nguyen@lge.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [yocto-autobuilder2][PATCH] config.py: Update meta-qt6 from 6.6.0 to 6.7.2
Date: Tue,  5 Nov 2024 11:13:41 +0100
Message-Id: <20241105101341.2251465-1-mathieu.dubois-briand@bootlin.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 Nov 2024 10:14:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/788

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

meta-qt6 is only used for the webosose builder and webosose now needs
Qt6.7.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.py     | 2 +-
 schedulers.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.py b/config.py
index 158cc5f2e2ab..13c4d09b0cc4 100644
--- a/config.py
+++ b/config.py
@@ -60,7 +60,7 @@ repos = {
                           "master"],
     "bitbake": ["ssh://git@push.openembedded.org/bitbake", "master"],
     "auto-upgrade-helper": ["ssh://git@push.yoctoproject.org/auto-upgrade-helper", "master"],
-    "meta-qt6": ["http://code.qt.io/yocto/meta-qt6.git", "6.6.0"],
+    "meta-qt6": ["http://code.qt.io/yocto/meta-qt6.git", "6.7.2"],
     "meta-qt4": ["ssh://git@push.yoctoproject.org/meta-qt4", "master"],
     "meta-qt3": ["ssh://git@push.yoctoproject.org/meta-qt3", "master"],
     "meta-mingw": ["ssh://git@push.yoctoproject.org/meta-mingw", "master"],
diff --git a/schedulers.py b/schedulers.py
index b9847c067be9..b53a96f1ac38 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -163,7 +163,7 @@ branchdefaults = {
         'branch_meta-virtualization': 'kirkstone',
         'branch_oecore': 'kirkstone',
         'branch_meta-webosose': 'kirkstone-webos',
-        'branch_meta-qt6': '6.6.0',
+        'branch_meta-qt6': '6.7.2',
     },
     'honister': {
         'branch': 'honister',
-- 
2.39.5


