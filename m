Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287C5CCD18E
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 15:08:10 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.46259.1760368086486141765
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Oct 2025 08:08:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1UToE1NH;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9691EC093A2
	for <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 15:07:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78C6A6067B;
	Mon, 13 Oct 2025 15:08:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 073ED102F226F;
	Mon, 13 Oct 2025 17:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760368083; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=HK51+xkB0QS6iRz54WH7DMP99iE83fOj2Q6s246FUoQ=;
	b=1UToE1NHYxdiWhPrkAbyBAZlbF9CXkDHEW4ldLRM6o1Z0bQaEhscPsbAh3K1HzWUmF8lsr
	E8sF8Pcan1vdmA1tCBNgrPZZOAaZJ8qrAc2iLABHnbtMJ34S0TS+ioDYu26bP7EzUkB28Y
	nynk5wj5xP+1XA3t6w41gY+GUETdorVeDJ1IfsbTQo8p+6TZSDjJ6+ddVbs+LndpA87VAZ
	VW4VOUBSDe90G4nt29TPDctM8xYr3pFqRpBEBTOLYROEjXwNirfOcIZ+WMEwJfj3LoS5h+
	yuc0Hs/fohevSBdM5AZInCjC/W57eF8/KZRQaTe/1RfKJai5BLXCIu6Qtgpaww==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/2] steps: observer: Extract yocto.io
 links form logs
Date: Mon, 13 Oct 2025 17:07:53 +0200
Message-Id: <20251013-contrib-mathieu-bb-log-links-v1-0-79db0af7bdce@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMkV7WgC/x3MSwrCMBAA0KuUWTuQxFbFq4iLfMZ2MGYkH7GU3
 t3g8m3eBoUyU4HrsEGmDxeW1KEPA/jFppmQQzcYZSat9BG9pJrZ4cvWhamhcxhlxsjpWdCfLi6
 E0YfzpKAX70wP/v77G6ziq6BtVVzjGCgbuO/7D5aJ/cqCAAAA
X-Change-ID: 20251013-contrib-mathieu-bb-log-links-c68bdd4cd750
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Ross Burton <ross.burton@arm.com>, Yoann Congal <yoann.congal@smile.fr>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760368082; l=661;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=AUkGHjbGtiXMBQ9rrLbekk3ve+/GMINjY1zeGHV6aYo=;
 b=2SMAcoA58KeKZbHhjFuUrf3FGkgUj/OtKLB8KtnodMgAZMHz4cMuNhoP3cbZesrYgxzY/mMng
 oP5bq8Y/XgTDVo+ZvpBOhtI/iUtw0O8JRGnV+QuHDI+f4XPg73tLIyc
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 15:08:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2293

Following a discussion we had on IRC on Friday, extract the yocto.io
URLs from build logs. Also add some trick to directly show ptest log
folders

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (2):
      steps: observer: Extract yocto.io links form logs
      steps: observer: Add links to ptest logs

 steps/observer.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
---
base-commit: 0dc19a8f0b247f7ca78da6419b16fa743d9ae307
change-id: 20251013-contrib-mathieu-bb-log-links-c68bdd4cd750

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


