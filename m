Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE08CCD186
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.20533.1759847846578797570
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=NFLWbPNh;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 46C461A1169
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1F7F5606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 788D8102F2169;
	Tue,  7 Oct 2025 16:37:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847844; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ChijKfl4a/KlZzXtzCf9MLEiMPZdMHNqLsRPV9pPQ84=;
	b=NFLWbPNh1Xt64WVNMrTwpjRmubRIavIjI/uaWQbu9Onctqrwv3GUsZMqKIsXUmrcam6Jfp
	RzbRWsoR+SxRvM8jbwRqAgrkUEvVmuRANuZ0C3DyjGfvF3sPZQwg6QPSeB8YF38iXn8e2/
	0KkrqaTL++5BDcPW8/Bhogu5v1qumFFQoQYdaqNmIXZeULi3dkd2PNHcj99Ui2KtLRYqNj
	lbwOy66Joh7ijWutvR52CP9EOHbCK/bRjQnqpi6Sv1MWdB6vQiZcK/XQc72FxHdRbS1wCb
	+Us69lkNwIerv3N58M5gnhuZwSCH04TBO+qhGIDTPs42kR1RTrRETLRyHp1flA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 07 Oct 2025 16:37:20 +0200
Subject: [PATCH yocto-autobuilder2 04/10] builders: Fix disk space error
 message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-4-bb1d79289c3f@bootlin.com>
References: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
In-Reply-To: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=1257;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=tvfiFRdxtQU/aBxcgIBY+HsfXbh3yQhb4wr6oevBKFo=;
 b=p5wRPPgYADBk/fEA/o9jC/BXqn+0GU7sg8IOVHOUsQ+XR/KrGHdl4jYqnLBod1ayvTvZKoJPh
 aCtz/ACWXIeAewEqMJOgbihMSA+M3aQD0d479D/AIBq+68vLz7tx1n+
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2280

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builders.py b/builders.py
index 0000122af015158e0cbb3a689e2419ab9c03e103..15985f258bb9fa7d38e70f4ca35f87ede4c24a23 100644
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


