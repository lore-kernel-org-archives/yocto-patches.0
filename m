Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460C6D44C54
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 14:19:04 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36645.1768486735742269497
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 06:18:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=gmoUd4sV;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 82668C1F1EF
	for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:18:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 409AC606B6
	for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:18:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A69C910B685C7;
	Thu, 15 Jan 2026 15:18:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768486733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cR5VB9a0Sd0dbeTf5wraVTiTSomf+l0nZ+kyJGEvsaQ=;
	b=gmoUd4sVXmCnxcnweKj4AVTRIicmF2zD6HttoyI9AaKYu4x2C6/i3tPAWaYvE8AymDiV9S
	zMMF+6HXC06gY7alepGbxCaqQ9FXpHw00kyzJreDva5lnTD+Tfad2gBOLqJdp/M2r/55Un
	QkGep0qetTTt1y6m41ghMYIdbUiZhOqPD1NJysG/2219LSB3WYRkWyPu9uKRSkGgJCBbkC
	biL+gF+ZAva3qyFLO6I95+k4K05Xo3QCUy6wXv5hnVjLqQADfxQmjfDXXgQwtyYb4vNnRU
	ticbDHEE+QVZ25PBBcsXeUSFzvFopd0G1dGeYGeuoHVmUgWxl+3cDHkm8d6sFQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 15 Jan 2026 15:18:48 +0100
Subject: [swat-tools][PATCH 2/2] swattool/review.py: status_bar: show
 number of triaged builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-status-bar-info-v1-2-1386e29bc87a@bootlin.com>
References: <20260115-status-bar-info-v1-0-1386e29bc87a@bootlin.com>
In-Reply-To: <20260115-status-bar-info-v1-0-1386e29bc87a@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=HiuYqBbG3RAohxbXyyW7XJJHRXohWP5ObSCdimtL/Ic=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpaPdLqaLuNHW7kubt0LmIpAWmYAfrPjsb0ed1y
 X9jG3DD0XeJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaWj3SwAKCRDRgEFAKaOo
 NjUpD/9Z4Zv/aorjvqTK58m1h8dSDO2PE2VoiGcb1fqQtJoOCrgk6XUk6yBkGjWpoLtnL1aFvlC
 sUAKawGhXiMGDTqP4xld0pYptGEO2fZDg0ILl6h7NsKJ0xU11zo72Ynv5dwrtLbgh3mlBrTzSHP
 Nr5HtE0tjzkIHmSizDYx4T0Z2t0sGejM0mvuoCClpIfmn/tfDMRQpX2jBGlVh+UqKn2TXxDqSkt
 OKkETUagyQSG4ahAXStdob7+WWo5eAFSxGlLZVr2X2URwZq1otF/B7ZdUrsGuO/pkuFHaYzNlC+
 ugJ4am0gQdgpqgSp1NZUeZh8lgAeYSfPmRN3aPjza2n1+gNiIpIsQQhbyeQsxcnKtJKF8SKQIUM
 JREZ1eLyY6jQXD360guA1RrEPUtg/Ndd30/9oEPP7DU+2ikM+V8q9LHLAPRuRso1tEBjFGAtN0q
 SELviRvFGC7CvViqClrpdIajAFMCQL+Z6XdkRBcmou1EqRr0+6FgRHwYetOoMmuhgyVmJP3WaOm
 JtAs5x35jVnT8yKeJzeE1DQDR3OTVNj614i6H5xwxYDooy0EJaNJ98s/sTfEyv4yWBBNPuGoXGs
 3FCLx9z/CxefROeoKgyvQgi6rr3bjyqCVn+uEf5NzeH+wbaKPDbV4M3+Pb36+ICUNcbE0bAz1dV
 HUwWDCTFMuCpynQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:19:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2963

As triage is done, show the user the number of triaged builds.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 swattool/review.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/swattool/review.py b/swattool/review.py
index 16a9b0f..73e1f5d 100644
--- a/swattool/review.py
+++ b/swattool/review.py
@@ -194,6 +194,13 @@ class ReviewMenu:  # pylint: disable=too-many-instance-attributes
     def _get_status_bar(self) -> str:
         status_bar = f"Progress: {self.entry + 1}/{len(self.builds)}"
 
+        triaged = 0
+        for build in self.builds:
+            if build.id in self.userinfos:
+                if self.userinfos[build.id].triages:
+                    triaged += 1
+        status_bar += f" | Triaged: {triaged}/{len(self.builds)}"
+
         owners = set([b.owner for b in self.builds])
         if len(owners) > 1:
             status_bar += " |"

-- 
2.52.0


