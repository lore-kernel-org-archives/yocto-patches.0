Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180D5C0218B
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 16:33:32 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.14819.1737650001860438895
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Jan 2025 08:33:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=DtpPPep6;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41C6DFF805;
	Thu, 23 Jan 2025 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737649999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HT6qOND6FE5j4RvcAlZyg7U4SMk7gRahZAfc8hRzykc=;
	b=DtpPPep6cjbtlxFzlm9q7UQPlg+CRlB2MIHMS9rC+RoUkY6Oc0ECnEJIgqmAE0SeCe+zNA
	4SUvdViLh/ZQT50ija6vQ1dw9SFcr4dNA1rxTp6E4dSasvqiHZW25UkGpURhcYyKyxTWPh
	wy7odO9c2mfq1CWPzNBovO7z0+RCPICB6slg+2VWXSVpmgojFfuoscph60s5xoJfxYull/
	k24hnJHay2spHkiNKOMqyqW/inbcC36dRQXUc4LBl0m3AfiNOBp12SR8nXmK3Pgty9PmOW
	y+/dHrCFyEC6W5Nhk/5IakdzXWlJx1aqGTte29a2VYLdYWj0kBhwDQYNa9+p8A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 23 Jan 2025 17:33:16 +0100
Subject: [yocto-autobuilder-helper PATCH] scripts/release-parser.py: merge
 full list with previous list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-update-release-parser-v1-1-95a165ab36ed@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEtvkmcC/x3MQQqDMBBG4avIrB2IMYHSq0gXifltB4qGSRUhe
 HdDl9/ivUoFKij07CopDimyrQ1D39H8CesbLKmZrLHeDHbkPafwAyu+CAWcg7YDu7TEiNk79/D
 U2qxY5Px/p9d13W+6kXFnAAAA
X-Change-ID: 20250123-update-release-parser-4dfbbec54485
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=bV/Ohiu7p4ZmNJFvaO4rj3Kr8z1MjNI057+7f9iFrdk=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnkm9Pst3OGWDsezbm8iS3+94H+lQYeTtW5crhi
 5fNF5czJueJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ5JvTwAKCRDRgEFAKaOo
 NqrbD/9vf3GFQuBmZDRjOtNC6QYL8zHxHzbbXUazDeLPDigv4beljAV+7aD4ph6r4r8jkMCLfbB
 d3rYqbwNj9NGnXuX4a8ikwB20Q9Yn70FkL7Jlfw0mYms1iZO7SPRyCXlnTUDV4BGNo+bOnrzcRW
 LCt4GEYWArb64Bkccpg5GQE+y//CSTdKjGPQPxdzRn2FJ//tXiotONYoZlfmgtpYu8bbpUHZ428
 YCVDhGcLDw03JkCRwoSU1nI/rYp6jaul9Hej8gfvsj1bh850wOw+F9vn8xeOAB+N0tIQYI0IG3N
 qRgiM+wSx/zoWM3e4f4ILYRNdOzl7oi+xCcN0McQINWmnnL5LA2a+mNyLeXuMrVscNS7Ihk72q8
 L1rgLnSSMA3WBVQQ0A9QsqJP+aTol4o5NHdGPfro25Z5AW2mrXWniQVOn4/QUpbtsAFEhf3HO9D
 EVb+TopPl7yi2e65ravsNxiRsMv51xcpVx1JMFh7ODwmBpQyUv9nXmEbQOmWKZ0zxpsr5xJ/2bG
 a+meviRAuYCzxg3QGbTGQbQhrrcmrBLYS83IsocEcBBKqACH/9u4MM63eEOiyvcbKAuIbMErSuO
 05uL4bIVNdGQPevEaWy+BUFJj+UdzcK5RyrFypRCkk1L3Po9Ruo19FwpX1rUA/v8wm+3Dt73JqZ
 JvSGkM2MBSgHc1A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Jan 2025 16:33:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1004

On https://www.yoctoproject.org/development/releases, the "Full Release
List" can mislead users into thinking the list represents all of the
Yocto release, whereas these are only EOL releases. Remove this list and
merge everything in "Previous Release List".

[YOCTO #15339]

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Note: I'm not sure if this will remove the "Full Release List" section
title and how I can verify this.
---
 scripts/release-parser.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 96b9d5ef416c16d348459bc4ce74e16abdc6a33a..321bd582be4f927d5f23c396cf41a6d81d7f7d78 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -120,14 +120,9 @@ tags.append(
 
 tags.reverse()
 
-previous_release_series = 3
 for tag in tags:
     if tag["status"] == "EOL":
-        if previous_release_series > 0:
-            tag["series"] = "previous"
-            previous_release_series -= 1
-        else:
-            tag["series"] = "full"
+        tag["series"] = "previous"
     else:
         tag["series"] = "current"
 

---
base-commit: 384d37a957a7f90abe04fe320cf0919c5a8f22ef
change-id: 20250123-update-release-parser-4dfbbec54485

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


