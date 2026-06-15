Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E71CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 09:38:53 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.125930.1781516325402550025
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jun 2026 02:38:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=hvtx0C3y;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 226F91A3936
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 09:38:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EC05460015
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 09:38:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD196106C93EE;
	Mon, 15 Jun 2026 11:38:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781516322; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=C6AnlIiG86nT4ECF8OrjwzrFqXEA86NrcZCZf6wgRHA=;
	b=hvtx0C3ys9YaIdIaY1KWUN7EfB3gEXgiN0WePG3q1JI39yJO8pi+eT9jb7oGgffGuSZ/nQ
	Agp8B+KL+JoISQ1FjJGD4DuWJ4k5nShLlMbVsC0RbFr4UnfQwOU0IVsNdiu3Ff5+ghcp2V
	VGiRxLGVcKp2Z/UpvS2C/iaxcyIvj4cnhyPaYSlabdXSM6Gf87TC4Nd5E6FHLFZ2YgIbmS
	65AvtULzz7yuICbJ+CkTye6VODKqDhFh64AB1ra7UdtfOzf9TEkE3c2CY1ci8c6Pzd0df6
	XQ1rP4R+Y0+4I5eR0ePg6L3ctvs9aDmE7zbVGK6veXF1CSehsBoTQuQCHFMzKg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 15 Jun 2026 11:38:39 +0200
Subject: [PATCH yocto-autobuilder2] schedulers: Switch meta-agl to unagi
 branch for scarthgap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-mathieu-agl-unagi-v1-1-5c2b5b28bd44@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAB7IL2oC/x3MywqDMBBA0V+RWXcgiQ+wv1K6GM00Dtik5CGK+
 O+GLs/i3hMSR+EEz+aEyJskCb5CPxqYF/KOUWw1GGUGNegev5QX4YLkViyenKBWuh07os5OBmr
 3i/yR/f98wRHmHJBKDlOR1XI08L6uG26CEwl3AAAA
X-Change-ID: 20260615-mathieu-agl-unagi-101394aa4db2
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781516321; l=808;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=Y4nviaYXd1K6bv6l1lVUjn+hnu60p05A3iOf7qzjM7c=;
 b=cjdiF6CQpk+ALYoPw/3qrCIc9S2iGPiZQIu5YIL8tJ9RWYNArClmoK6KNmr5Ylw2FfrP353h0
 HNPq3ea0aGHC/PqiQwJblYakw32LoZW3w4B6LwbUh0SMRSIpHFvReFV
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 09:38:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4223

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 schedulers.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index 0f41bd0c7ca6..e5f0684fcb34 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -161,7 +161,7 @@ branchdefaults = {
     'scarthgap': {
         'branch': 'scarthgap',
         'branch_bitbake': '2.8',
-        'branch_meta-agl': 'master',
+        'branch_meta-agl': 'unagi',
         'branch_meta-arm': 'scarthgap',
         'branch_meta-aws': 'scarthgap',
         'branch_meta-clang': 'scarthgap',

---
base-commit: 5a6ea7528b04dab22417da66bd9cde87fdd05121
change-id: 20260615-mathieu-agl-unagi-101394aa4db2

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


