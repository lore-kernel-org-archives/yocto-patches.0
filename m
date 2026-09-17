Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C337C982D0
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 10:28:36 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35959.1789640911183192471
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 17 Sep 2026 03:28:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=rmZ/zhdM;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 56A75C5CD6F
	for <yocto-patches@lists.yoctoproject.org>; Thu, 17 Sep 2026 10:29:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 047475FAA3
	for <yocto-patches@lists.yoctoproject.org>; Thu, 17 Sep 2026 10:28:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6D3211C7B074;
	Thu, 17 Sep 2026 12:28:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789640904; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=SkpUR16GM2TDynk1lJe6rufOoWPOGDm4Ble+7YevfmI=;
	b=rmZ/zhdMq3jOBit6ffE0Q4XLJAZUdgWSK44uHDnqKHtcZcizvXWWoDuhqtKNGkbSoDQofC
	kgrFS7pE8jMqYSF7CxwaJnnhcwrkM36/L4cvURYbaDGWUjGRTeSytnx+cIyppywAZpPqIV
	tNBKkAoQtj7DXrX2n3n44i3qgKs1w4AshBT+vJ7a4HoA9oMebDSrZtJCUsMoS6qHs2NDVX
	LjtUTa67+0lXXh0K1ZQYG7NXG3J1/dMSNgf3BB3l8MHVV6I2etWjZh3zfm89u+9wsmnR3O
	xD1X6xWQaxIXpSTnVHwwtzV+yt+mdHRvLgqZyIIvJ9P91OMz8KNGAYQIz7kNvw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 17 Sep 2026 12:28:03 +0200
Subject: [yocto-autobuilder-helper][PATCH] scripts/release-parser.py: fix
 bitbake dev branch 2.19 -> 2.20
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-fix-bitbake-dev-version-v1-1-f3b9f6c737bc@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSQqDQBAAvyJ9ToM6YjBfEQ+zdGIn4kjPQoL49
 4zJsaCqdggkTAFu1Q5CmQP7tUBzqcDOen0QsisMbd329dBc8c5vNByNfhE6yphJzgZVrwfXKds
 a1UGpN6Gi/s7j9OeQzJNsPHfjx9voUafoTeLFkeBMy0YywXF8AUcOVPCVAAAA
X-Change-ID: 20260917-fix-bitbake-dev-version-36a9d43c2b34
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=VRE3947wIrNs6vTYFTbMhzrY3f+MOx0kZ4ax5cQjEBU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqq8DGT/TrowilGL/ppih1qRhKX0yiO69WLUI2y
 G+6WYkGL9OJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaqvAxgAKCRDRgEFAKaOo
 NqXhD/sHYQRIpXWRQwhQTE6WA1rbX3VgFLgzXJNUD3H1DHw0k+xEPv7K27NwimXpYcnG1Z/fthc
 dxOC3G0gFcq883Q4PCv5EuQz+4uFxPEMsEjmhafcHR+qHnSF98J/i9RczGV5IOY5phEaEH/SoLd
 TPR6x5Fw254qe+6f8fSTJpIteU3/zBi9U+f2atQs+r31miEgy3vY+O+XufDyxuTxm3okTx6lvhe
 JR9Jr8PVVPGPWaUOa4/7Dc0CABn4z2P6E/mf3/40x0Z2Y1xYqHmpRYiz3kJhyEsCPdX3RzJ/TVD
 kls5xsF72YAwP+stDN4PlXF7aiRUCyXV56NfIhnjFL+Lb5woakOkEEIBw27REEqgOT2Bv1PzQFR
 wta8fkv45vY/EaO4rwuYf6rq666JnTlspuXHS+QYLrAgmJkX2G1b15xWgYF58HqWD7Rk1DOaU4N
 enPhOQ2blQbzayTP8DqYpljnj3Xe6wvyxKTbOQ3Td3fmq4sl60XvgoI0pZm3z6efzmGp85vYBHf
 10xDB17BudxrJTPrTKLbaDdj8l7qByZsp294FAEOQHPuOh1Fsnyo5rrZKth/bHMM+zC4lJ56YXb
 3j3dOrs2ylEec0B2smTdXtaThLVGxkFLjlpXmesr3G5M0+SM2SAf3lOxlJOP0meTvHyYqD0xMG2
 l+kh2+57+8CH8lg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 17 Sep 2026 10:28:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4903

The next version of BitBake will be 2.20, not 2.19, we always hop two
by two. Fix the version, which also fixes the following yocto-docs build
error:

  intersphinx inventory
  'https://docs.yoctoproject.org/bitbake/2.19/objects.inv' not fetchable
  due to <class 'requests.exceptions.HTTPError'>: 404 Client Error: Not
  Found for url: https://docs.yoctoproject.org/bitbake/2.19/objects.inv

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 4f928b3..c147d1d 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -29,7 +29,7 @@ CURRENT_ACTIVE_DEV_CODENAME = "Blacksail"
 CURRENT_ACTIVE_DEV_VERSION = "6.1"
 CURRENT_ACTIVE_DEV_MAINTAINER_NAME = "Richard Purdie"
 CURRENT_ACTIVE_DEV_MAINTAINER_EMAIL = "richard.purdie@linuxfoundation.org"
-CURRENT_ACTIVE_DEV_BITBAKE_MAPPING = "2.19"
+CURRENT_ACTIVE_DEV_BITBAKE_MAPPING = "2.20"
 CURRENT_STABLE_BRANCH = "6.0"
 CURRENT_STABLE_MAINTAINER_NAME = "Yoann Congal"
 CURRENT_STABLE_MAINTAINER_EMAIL = "yoann.congal@smile.fr"

---
base-commit: e5226a56cab986ce0a6940a35aa30ddf1dadd07a
change-id: 20260917-fix-bitbake-dev-version-36a9d43c2b34


