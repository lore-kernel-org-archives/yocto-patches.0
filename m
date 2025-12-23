Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7534E6F096
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 14:42:44 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.102213.1766500959611751229
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Dec 2025 06:42:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=plDjNHJH;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2F18CC1AE23
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Dec 2025 14:42:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45BAA60716
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Dec 2025 14:42:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8435B10AB0B24;
	Tue, 23 Dec 2025 15:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766500956; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=9p0SBvEUFa5cWA5pjvmHTXJcindg4phX7DXLDa0S1yI=;
	b=plDjNHJHM4pspfSi1pArfyxp2YI3MiEbz91U5C7mrENC6nBb34yKNn/iJPFmz8Dmtro3Lv
	ZwM1UZHCJYzq3eKptuip3G4tRCbJ8Kx6I7dBp4Et4jG3TtxyXMaGUrXr5xyehhOcPDpG8R
	RXIO36LmX8/VkP7Wh51kr8LnmRZ87mDu5r8xVSL/Qt5QZm0Py1Au6Krjpqt6EGhz97BYtt
	R9mf4s9ab8bDEnjsAFW3mCLpZBx2VMSYFxbmnv/8TXRQqJsRvxaDf6R/Xfit/16k9Pk9ID
	AHTIQdF2/IHSYfi0Gxa1mkuSuu7HK061m6bpTOEdt8Bfy3A74CnXb5jyX1h3+Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 23 Dec 2025 15:42:21 +0100
Subject: [yocto-autobuilder2][PATCH] schedulers.py: add a branch selector
 for self
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-release-selector-v1-1-916323760b71@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEyqSmkC/yWM0QrCMAxFf2Xk2cKaOkF/Zeyh7TKNjFWSVZSxf
 zfq0+XAPWcDJWFSuDQbCD1ZuSwG/tBAvsXlSo5HY8AWO48YnNBMUcmpbV6LuFNIbZeDn+L5CKY
 9hCZ+/ZL98Get6W7nb6d/F7NcrGtJleeRBAfY9w+hEgSwiAAAAA==
X-Change-ID: 20251223-release-selector-63b05c31fa94
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=IK5mQTxkoQtVjSJ4zO6PoJzMFl9HsOnIhQDmLHsE1kE=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpSqpbzzCnbIJCdnXrteeX2mowoC13Igbs4LEtd
 5mvgEt+IUaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUqqWwAKCRDRgEFAKaOo
 Np7zEACA2jjLXrM6h1OJSeOEqIe4w62Y/sGBNqhKQXj32Mo+YgNLb9sT4aRYervaGiswW87JLIs
 PWZzN6w9l7uBifhLMiTvCDlaoDQ4mNFyGkJGZNvTTAR4Ef67TNQ3ELrEBKlrR1fELUPIh2T6uTj
 yPwVDSIWjZPwUILnPwTWjGiniVHfOPWPjIqnxA+9mTShvJWyjmlSNph+7DwJxazUcpdwEj54LRg
 DLg8QoILyKqtepON5v+WzkJW4HyYyfjKTN4UxqwZjM2pVIQJfXD5RULCzyVQw9Q86yl7ryQU9jP
 sTcRNj/MGUXgPdn5xMUHw1jZa4M9ycFOxOszjRSPXiJ32z7nhs/I6uhTiFYRFZNfDUZTmg2mdmo
 IK2JgNdHPynXNWqlv5Bzf6nsVCKgdrYhxxs+6PUQpk/iE8ilrf2WHTuu0gYtgqpX4ShHP9B4sRr
 /bNAGiUrt7IDqtGDbvV89jNB5FUG90q5yHTScblaEi2LVbuY36aA0r9MirbRUzd/f/ScTyBQKXE
 tHAVnJ5CNi5o8BkjMD31KrGk0n8qks0lbGtWVd/5I+e5KbkOzzlC1+vWyD2D1vpneeEo+/90Ioi
 LLuTNIWpRI8XYOyZxCFABdOuIFxeT5Yvq0wXoavjU6r6fUNYeHMMQj0A1RYXWAMRVgSIP3Q4BOy
 stKB/a5XfDw1cxw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Dec 2025 14:42:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2863

In preparation of the SWAT work I'll be doing in January 2026, add a
branch selector for myself as I'll be running builds frequently.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 schedulers.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index fe1dd9c..df82c93 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -47,6 +47,16 @@ branchdefaults = {
         'branch_bitbake': 'mathieu/master-next',
         'branch_meta-yocto': 'contrib/mathieu/master-next',
     },
+    'antonin-next': {
+        'reason': 'test agodard/master-next',
+        'repo_poky': 'ssh://git@push.yoctoproject.org/poky-contrib',
+        'branch_poky': 'agodard/master-next',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'agodard/master-next',
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'agodard/master-next',
+        'branch_meta-yocto': 'contrib/agodard/master-next',
+    },
     'mut': {
         'branch': 'master',
         'branch_poky': 'ross/mut',

---
base-commit: 315e7c2300adc03a3519f355c641404fad4f11c0
change-id: 20251223-release-selector-63b05c31fa94


