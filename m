Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE14CCD19A
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:20:23 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.8311.1760620820446718488
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 06:20:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=n3LvAsAL;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 260601A134B
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F15466062C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6255C102F22FC;
	Thu, 16 Oct 2025 15:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760620818; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I9VMf5shjJ8HX6f7CQ+UBwKRe95Ki9ZZxhYG57HdXC0=;
	b=n3LvAsALMPCkwmpfQgwTlQ8BW6QVqJFstITNbqVsdJDKJDi/ej/Z24tl2aTRV900Biat0g
	2NSfMPKs7UZcfwGpzmuL4yf1ISa6+AdCGNcwZzJZUvajaXGNYwodivy3EzBMgEfflcmBCc
	yAP/EgCJtWYCQI8tIMVhIFJfvvQdBAHhE/HY2nccsQy29qnxL2zfitPqR6xR8MfnbKD043
	AkYxFZV0VrOLDVqmgq5FOmhtD10rQwExcI3nNEvnudjO61c6NlGs8IgM8LV1daSdO5K2/L
	ZD+L3wxXjIH7onDQP8IrqNVZ4I/4s1R3q50KvLxJZ/im0cdThS16FwShO7TpMw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 16 Oct 2025 15:20:12 +0200
Subject: [PATCH yocto-autobuilder2 v2 1/6] builders: Fix disk space error
 message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-contrib-mathieu-bb-setup-links-v2-1-095908455e0b@bootlin.com>
References: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
In-Reply-To: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760620815; l=1201;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=EvqKVYn0FMi0Ktotld9fjDR2yNQPcE8mkXDk5mRV0Bo=;
 b=DxTuUZYNNm0BujAcO86QRaiZQzE9tWzbMMTSh/VoE2MQ76AfrZEjkDZ10C0jD1rU1pEw4petv
 rac2QjgL7DyDYLTcRZSsAyPgW4EwhMkwM0S4Jr7DZrmPngx4XhVhwC/
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2314

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builders.py b/builders.py
index 0000122af015..15985f258bb9 100644
--- a/builders.py
+++ b/builders.py
@@ -77,12 +77,12 @@ def canStartBuild(builder, wfb, request):
     for mountpoint in checks:
         threshold, name = checks[mountpoint]
 
-        threshold = threshold * 1024 *1024 * 1024
+        bytes_in_gb = 1024 * 1024 * 1024
 
         cmd = yield shell("findmnt -T %s --df -n --bytes | awk '{print $5}'" % mountpoint, wfb.worker, builder)
         space = int(cmd.stdout.strip())
-        if space < threshold:
-            log.msg("Detected {0} GB of space available on {1}, less than threshold of {2} GB. Can't start build".format(space, name, threshold))
+        if space < threshold * bytes_in_gb:
+            log.msg("Detected {0} GB of space available on {1}, less than threshold of {2} GB. Can't start build".format(space / bytes_in_gb, name, threshold))
             wfb.worker.quarantine_timeout = 10 * 60
             wfb.worker.putInQuarantine()
             return False

-- 
2.47.3


