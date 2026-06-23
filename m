Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F3CD98F2
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 12:19:04 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19345.1782217143054669650
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 05:19:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=n5A49A3H;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 63CDDC6B385
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 12:19:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB5F5601C2
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 12:19:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FC58106C81A8;
	Tue, 23 Jun 2026 14:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782217140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=XcSJmlj4kELM+Z7osTsF52w0JiV0VoIbh/Al6ap5UmY=;
	b=n5A49A3HJ42rDeY9OnCbU4HsF6ZKA/Z50cPWOlwvUdi5pasGEJCdZjsztsH5xgD/W0EITp
	doZb9AhgWsTxE+oMnIz/5vGsnLbNlh4RNVl75MMdMSzSjktRAmCKIzoCLC7Rpr2b+Puibh
	BxsQ/afxPl/p8zUUIvs4z2wgabBlgiSUtDE5uXSU17NiEmivM2pr+MyvfkA/T3BctK+unx
	wyWKq9lfLNH9k6yuliyCcsTTt5xezTcG6PGaTpMYsa9/Mcwx/pVA+gq8o+g13kPSLyeY2V
	PKXb0C5fPM7j4/mC+6lDgu5oDRQwIG5sjagWWCvEStj+sp908z1NkjGh6SCSDA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 23 Jun 2026 14:18:40 +0200
Subject: [PATCH yocto-autobuilder2] schedulers: add missing wrynose branch
 selector for meta-openembedded
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-mathieu-meta-oe-wrynose-v1-1-cdfca42191d3@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAJ95OmoC/x3MTQrCQAxA4auUrA1MY6noVcRFnIk2YCcyP9VSe
 ncHl9/ivQ2yJJUMl26DJItmtdjQHzrwE8enoIZmIEejG+mIM5dJpeIshdEEP2mNlgXPzKfBO+q
 DH6DV7yQP/f7PV1jNF0Ouxe5VX0ESwW3ff9uTX4N9AAAA
X-Change-ID: 20260623-mathieu-meta-oe-wrynose-9aa74c021dc4
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782217138; l=796;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=2P9AKaG9Qai8OvfKQkSiU3LrcbfDatF3MmByT3Xa6jA=;
 b=FiC12Ak1YgR8gVj6b6UCOXWQdEIouGtFQoy2L45S3eeQ4McY/lX1bzGv/w1Xi5qleoNgwkF18
 MB4b4uEnMj+BsNSJ7Pw6Ban3WklpWYjGTId44VfO4dpwWhn7J67GwoW
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 12:19:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4280

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 schedulers.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/schedulers.py b/schedulers.py
index e5f0684fcb34..5ca57f3961a5 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -78,6 +78,7 @@ branchdefaults = {
         'branch_meta-aws': 'wrynose',
         'branch_meta-clang': 'wrynose',
         'branch_meta-exein': 'wrynose',
+        'branch_meta-openembedded': 'wrynose',
         'branch_meta-qcom': 'wrynose',
         'branch_meta-risc': 'wrynose',
         'branch_meta-ti': 'wrynose',

---
base-commit: 007f5ad32b586f52a4fe53e3069b7ff7f0461372
change-id: 20260623-mathieu-meta-oe-wrynose-9aa74c021dc4

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


