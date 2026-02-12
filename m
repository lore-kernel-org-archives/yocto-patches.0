Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C74EDF05D
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 08:37:43 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41525.1770885455008370663
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 00:37:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=PY5JGbjX;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 891BBC23D9B
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:37:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6805D606CA;
	Thu, 12 Feb 2026 08:37:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CAD6119714CA;
	Thu, 12 Feb 2026 09:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770885451; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=gceEl0PJDOxe2AUigMiUROe5rmxfgZxufLf+xaa7dvk=;
	b=PY5JGbjXhyjJ2exvRlDPXWyDFLgCwpGaIuaHqxcHaLUV01uYkLYb/cxkSrdDcvhOQx/QuF
	Fa30iSbo4Nar9e+ZlwdkMTN13GsMG3AS5Tz4kdJiKLGndWnL0gkMlcCbu0eldn5c9al7gC
	U+fAHp2IKgWCUxTDEAgX05/lpn4RDAdJmzvx+lOCs2xYYrwbotIAHkA0MG7guPGEoShofN
	zKGzkAUlg6l3u/+v86vlYunXp50MLw4PHYhJz85Do2P/nqGv/6aVMVVQ4oG6qNnXX9KZXp
	36zObxhwddymIKqS1JVNQdAwrpZ0YFP/LBzUAl36e8ePZeUdI5xfjz26/Tbk+w==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 12 Feb 2026 09:37:14 +0100
Subject: [PATCH yocto-autobuilder-helper] config: Add meta-yocto to
 repo-defaults section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-mathieu-repos-meta-yocto-v1-1-f8c72de9c075@bootlin.com>
X-B4-Tracking: v=1; b=H4sIADmRjWkC/yWMwQrCMBAFf6Xs2YU21gr+inhI06dZaJuwSYpS+
 u8GPQ7MzE4JKkh0a3ZSbJIkrBW6U0PO2/UFlqkymdYMrekMLzZ7QWFFDIkXZMuf4HLg83UY0fc
 W7mKp5lHxlPdvfae/YksOY5F5grLHHKH0OI4vULFpAYQAAAA=
X-Change-ID: 20260212-mathieu-repos-meta-yocto-376be44aec5a
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michael Halstead <mhalstead@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770885450; l=1076;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=GYqirrVrvwhbO+LrsB0A5nbp+0iP3H9OGm6r/71ia7I=;
 b=c7BbAgYXXwnKsg+RcoXa66hFegc8Xveevy83BQUtOmtPUj34MY3YTdt77MM0AGYkVsp1HukMS
 aadJvMXEUqVDyGtx9Gftavss2F6j7YRn0KKCfAUCRf5SDoXXIEO9rVe
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 08:37:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3221

Recent changes are relying on the presence of meta-yocto git in the
mirror folder, but this git is not mirrored so far. Add it to the list
of gits to mirror.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.json | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.json b/config.json
index 407d2451c514..631b7c82f20b 100644
--- a/config.json
+++ b/config.json
@@ -1898,6 +1898,12 @@
             "revision" : "HEAD",
             "no-layer-add" : true
         },
+        "meta-yocto" : {
+            "url" : "ssh://git@push.yoctoproject.org/meta-yocto",
+            "branch" : "master",
+            "revision" : "HEAD",
+            "no-layer-add" : true
+        },
         "meta-mingw" : {
             "url" : "ssh://git@push.yoctoproject.org/meta-mingw",
             "branch" : "master",

---
base-commit: dfa040ecf286a20afac1bd3360aca8e1158766d4
change-id: 20260212-mathieu-repos-meta-yocto-376be44aec5a

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


