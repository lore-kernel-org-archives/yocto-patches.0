Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEDCC61DCB
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 11:39:12 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4387.1787917151027986628
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 28 Aug 2026 04:39:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=GcsI2KR2;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 57ED64E413D5
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:39:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E44560537
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:39:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46B5B11C781DA;
	Fri, 28 Aug 2026 13:39:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787917144; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CA86DWrpvHgNPekYdjwitOGtfz3lfSNX697Gp+9HW/4=;
	b=GcsI2KR2TNlx+3EkBXwZxuBsGtPV58rFfVqh5KL5NDSLbhddJCFDtr2W9L8kji1M/OvMAg
	IWlhI8fUknMz3FYOyWs5oCseFZwgnaf73BCuFRSHXK54T1c9XFTjDEmcIv6x52ACcrWwSN
	LR3E3/95UhvYfwIwD/kiWqpXnEsJOW7Q4oTx6K7bQQlpe1GWQb0obscowmnjpAdZC3BTT2
	wE34Kf4zPBmt3oEhHSVlC2T6c5CPukFwt/hADmbIPMBonPrEGkQFltSLhyO5fjBPnnguzR
	0brMCCWnbWPodXjenW/iRqUfGsx/aaCZgHh+n1H6fc+UmZuvTF8Xvegg/lXwJQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 28 Aug 2026 13:38:37 +0200
Subject: [yocto-autobuilder-helper][PATCH 4/4] scripts/run-docs-build: use
 a bashism
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-run-docs-build-tweaks-v1-4-24a7c832e352@bootlin.com>
References: <20260828-run-docs-build-tweaks-v1-0-24a7c832e352@bootlin.com>
In-Reply-To: <20260828-run-docs-build-tweaks-v1-0-24a7c832e352@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=618;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=QJMtJNWqWPzNlDyXj6YpjD0J/slTY49xa+6lcuTnAl8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqkXNEYWY9fqBI7/+jIVDD8we/zAMxo2dYIrxaz
 8ZRzBShEnaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCapFzRAAKCRDRgEFAKaOo
 NqtOEADEjnom48pcmuBjEh9ar0Wi61kFGtwZg3nl7yJ7twqYfKWyiZHDoj+0tuMxWPkUWGSsmNX
 EYLF60OQwcjWMfc2+ejKFnd5SwhOwj7+WzgDzS3V0wGxuIprf+UOeiOxaPBfBs3X1vlnVkHkGVl
 gj7qaSSfM7ijksTa3wqNRFB+IiKLZkVvfVPOzUJGufvg1UA/RENlGlyD8Olz+YCHmrgP7xO/i3+
 Tf3YVlWBJgjhmMGTACClDysYzclyDSS/y/KTjh4wHnzJBl/yjzbrQJ5A3/OZYL7GX3VcTnt0zzF
 fR4XTxG06IOTKKjzAzw7jNl8vgEvGAqpYHJN2moZ4QDl961MWM/XyiI2WArNcBKmslE5RKlopO1
 ka9723tmF8RQ0a3oK5xleo7GsRyNQdwMLiZ60fu3fK2QQLhXrY3Ot9d9xN7TzLVict/m+O+CY0P
 pJHRrKA7BI+pDqRd+xuMRvP7Es5XoAE80jlMjzQpaSQqKx9hiubONJenzLCayKA5D1HUJkIAR9V
 HLxNr653r+C4FlCdW86ZWlPBWJXU9auu3+9F15J5pMOUkEHpuuUq3CcX75xicjAf6u0TpCCbbyR
 ulR866Fc4Mc2axXnNi7r3AjPoeLAiiOIFOLSLK403cKTRgKMT5oWdwFKQmFkpscLk3ZHYgmFxm7
 RnCFMrGTFS45OBw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:39:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4718

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 274ad20..5f5fa05 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -243,7 +243,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
     )
 
     # Strip yocto- from tag names
-    branch=$(echo "$branch" | sed 's/yocto-//')
+    branch=${branch//yocto-/}
 
     if [ "$branch" = "master-next" ]; then
         branch="next"

-- 
2.55.0


