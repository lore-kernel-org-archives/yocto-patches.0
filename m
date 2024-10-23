Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A021CDDE52
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:03:10 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.5199.1729677784207351091
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Oct 2024 03:03:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=XSgg/Gdh;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4307240007;
	Wed, 23 Oct 2024 10:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729677781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+3jaLnmA/lMfLO7HJKR7hso4jlFiTPPdV4PNRBd3mpo=;
	b=XSgg/GdhvrkhFU2FvBQuPGMr8WMg36fyM+F0agDLhzV01Ldhb+nDkLi5WuyV5BTP0iO45D
	ExSaLZxyBe6KHPn7CUPB0AC2QJbLPV9fm6baTXJF0YLXxgVbI8aG399+88n59b2w7ZbdDF
	oVaSSq1Fm+PexP4QHOaWJQQX7VsXoub8E1Q4YH4gi+2SzI0+y+TldDP8Vgd+U+ayLigT/6
	XBar7cQds9+1Mlf+YazakOfWvFbRfOdXyLKOhbjlOnc/sSnkVk6NZE6Kx3rjTuUgseKbtP
	Gea+ekhMU8PxoCRjGM35Daiq5Fjj5aQc4aURnO12oSRDDlgy6S5iCWpLKrBb8A==
From: mathieu.dubois-briand@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [yocto-autobuilder2][PATCH] Add branch selector for Mathieu
Date: Wed, 23 Oct 2024 12:02:42 +0200
Message-Id: <20241023100242.3953188-1-mathieu.dubois-briand@bootlin.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 10:03:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/730

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

As Alexandre is no longer using the autobuilder daily, remove his branch
selector and add mine.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 schedulers.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index ec3a085ace8a..7bf27f8537dc 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -44,13 +44,13 @@ branchdefaults = {
         'branch_meta-openembedded': 'master',
         'branch_oecore': 'master-next',
     },
-    'abelloni-next': {
+    'mathieu-next': {
         'repo_poky': 'ssh://git@push.yoctoproject.org/poky-contrib',
-        'branch_poky': 'abelloni/master-next',
+        'branch_poky': 'mathieu/master-next',
         'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
-        'branch_oecore': 'abelloni/master-next',
+        'branch_oecore': 'mathieu/master-next',
         'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
-        'branch_bitbake': 'abelloni/master-next',
+        'branch_bitbake': 'mathieu/master-next',
     },
     'mut': {
         'branch': 'master',
@@ -454,7 +454,7 @@ def parent_scheduler(target):
             name="branchselector",
             default="master",
             label="Release Shortcut Selector",
-            choices=["master", "master-next", "abelloni-next", "mut", "styhead", "scarthgap", "nanbield", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
+            choices=["master", "master-next", "mathieu-next", "mut", "styhead", "scarthgap", "nanbield", "mickledore", "langdale", "kirkstone", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
             selectors=branchdefaults),
         util.BooleanParameter(
             name="swat_monitor",
-- 
2.39.5


