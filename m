Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2642CCF2C6
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 08:44:09 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31718.1768812244750750544
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 00:44:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=iXUzww8u;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9C0811A294C
	for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 08:44:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 70E8260731
	for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 08:44:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2832E10B6978E;
	Mon, 19 Jan 2026 09:44:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768812242; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=hDmtkOl8m17bhaDESbjZr7cbg7eZi7ouyC5YM0nu6R0=;
	b=iXUzww8u/qOQP4ZMwZhSX4LQy6rno0/6ZxpZlcU7oKRbbQ87mcvVZGMcrUTIAc6VQFGcgl
	s1vRmajtw20eanGAyQwSqKuEbnqNiTsFPjZ1Q6e2R7SkkK7HDvIbZH+FAgMstSDK4pBOYZ
	XRTp9ZwxDCgzw19Q3lgvBmop8Ps++xYox4lGmjyz5wcgOnIahsshDqm2XCT4fKI4wqezi3
	bPcVQePyzIAWB9o0pB3IqZlJ7z+b0Xeug43/VkzmHAJa9iDD/4tSmZpcu4NAx9yjgBhA2L
	1CjBRI6Ab6gxsCR2bay4Lyahul6lxSfIyby7qiE+LG/gSOfqpBp2A7t4Zk8iMA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 19 Jan 2026 09:43:47 +0100
Subject: [yocto-autobuilder-helper][PATCH] config.json: rename qemux86-64
 builders to contain "-64"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-qemux86-64-builds-rename-v1-1-1509a9431c02@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAMLubWkC/yXMSw6CMBRG4a2QO/YmLZGHboUwKO2v1ACFPgyGs
 HcRh9/gnI0CvEWge7aRx9sG66YD8pKR7tX0BFtzmHKRl0LKGy8Y01qXXF65S3YwgT0mNYKFqYW
 poERVFHTks8fDrue6af8OqXtBx9+v+TgdHasU3bmB5x7DDN/Svn8Bf3QwCJYAAAA=
X-Change-ID: 20260119-qemux86-64-builds-rename-0d80d7ea0755
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=kY7hm++MwrxtIRlQY/7ZIwMySsPxJ4oX/Ww8puoeA3g=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpbe7QGzEpH9BruNadgJxxkw036/ws9sn22T1Vy
 TNAsXBq0wSJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaW3u0AAKCRDRgEFAKaOo
 NljnD/9CcYEZTbH197/5/23TamUazB0J78auNHl6IQcRhid/cY4sISaAX7Na3c+2FYJYLr+g286
 drs53ISiif5AH/lC1/5OYsoRtsK37+AGS5BNkk2AFxS58Cm+M/8ClPJ8fr/F7jotmk/+W3YgmEG
 gX8WHRVc+WehdffSG94tBDfDq2qMEtrhtgEGNH2z7SPYd7T71uxB3f7Oqm032B3anVjn22dLWbN
 wAFv+geDXIP9z/yq3FyYnDNeViUEYx4UhtpyMaLPyPDsrsCYZAf3S+R1/KgQI+AAdUFh91J9a5g
 b50g0g0a9qYYS5H+4yzbZFUNUKa+l53P1oUsFGFLx3XFwUnKjjn4EP6bSsLDltFXpgoJKuXnfuT
 cXrmyhKaVB5WoP5hVhw8iz5c1JW/xYO9Lz4S6meEmKojKaE/My/FdsEU4EwfdMsCrbQ1cQGqgtu
 ofqkrZfXdalld9sIMJjNDplFamdyk7J+TiEVZp6TuSuiYp3gjOPjdhTXu8Xnd/TH0NU2/m2H8dz
 HRECTzxUJzlJJvD/YVlDbAKo6RwGZo1/vfcFubIM9LlcwdYTuOpAGfr7yKpY2NbtIWvA4cIkC8d
 H1HUqCtjZVGsx14Dj9Ew5/tzx0ahDl9cCUB3MWQcpJCoSnU0WSpaLB1v7HPYlvopgbbSPK4FR30
 TRTFDyF0o6RxDgg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 08:44:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3007

It can be confusing as some builds are also named qemux86-<something> for
the "qemux86" machine. Rename these two qemux86-64 to begin with
"qemux86-64-".

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.json b/config.json
index 3229cde..1a81133 100644
--- a/config.json
+++ b/config.json
@@ -831,14 +831,14 @@
             "MACHINE" : "genericx86-64",
             "TEMPLATE" : "altcfg-hw"
         },
-        "qemux86-world" : {
+        "qemux86-64-world" : {
             "MACHINE" : "qemux86-64",
             "BBTARGETS" : "world",
             "extravars" : [
                 "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib32'"
             ]
         },
-        "qemux86-world-alt" : {
+        "qemux86-64-world-alt" : {
             "MACHINE" : "qemux86-64",
             "DISTRO" : "poky-altcfg",
             "BBTARGETS" : "world",

---
base-commit: 6f793956c9b43f7a74f5a22c86a93b744b21ada9
change-id: 20260119-qemux86-64-builds-rename-0d80d7ea0755


