Return-Path: <f_l_k@t-online.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D166ACA5FA5
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 13:52:52 +0000 (UTC)
Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57924.1790603564868148614
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Sep 2026 06:52:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=f_l_k@t-online.de header.s=20260216 header.b=T0R/t3QH;
 spf=pass (domain: t-online.de, ip: 194.25.134.81, mailfrom: f_l_k@t-online.de)
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
	by mailout03.t-online.de (Postfix) with SMTP id 7AF56E3AC;
	Mon, 28 Sep 2026 15:52:42 +0200 (CEST)
Received: from intel-corei7-64.fritz.box ([84.163.40.132]) by fwd85.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1xBBmb-1VaOzg0; Mon, 28 Sep 2026 15:52:41 +0200
From: Markus Volk <f_l_k@t-online.de>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
Subject: [wic][PATCH] bootimg_efi: allow a systemd-boot timeout of 0
Date: Mon, 28 Sep 2026 15:52:36 +0200
Message-ID: <20260928135236.89296-1-f_l_k@t-online.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-TOI-EXPURGATEID: 150726::1790603561-17FFC98E-CC6CB9FC/0/0 CLEAN NORMAL
X-TOI-MSGID: 057e5979-1a61-45c5-bc76-9fcc62401d94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-online.de;
	s=20260216; t=1790603562; i=f_l_k@t-online.de;
	bh=ymhNRqwLFpiUcJgIdevZF2Lna9TzAPXUQ8OYs3FWgDk=;
	h=From:To:Cc:Subject:Date;
	b=T0R/t3QHP2Ush1FwuuSUV8ohlv37qY+Oh7tn4haAD2daFFFuQbZ3bUE84DwSMFIVk
	 pyvcvr4Ezr6lGzqx7ZLf3IlNBRnYpd+UCTTiWraf/X0eh0IXZbK8q6cHHjDLZsRJCQ
	 ztRc7c8seNbvZdJTP3IEu8YfRpFI0BAiQzjxz1Raamxez2+NgSCDlnhraWHIhLn8rH
	 Z837JKMsmeF9AI2FBXahvzktzvwnsTx8D8wN7QmVixVkni8rIrr9HNT9X5vgHctVWc
	 WR2p+wPTVbzoP9a5EnKeYXJZP96z1zIY4QR5UjBaUldD8oAkFohD9dzFJ6z/ag7VJw
	 IK0qDhNIYd5Vg==
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Sep 2026 13:52:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4960

--timeout=3D0 was turned into the 5 second default because the value was
combined with "or", so systemd-boot could not be told to skip the menu.
Fall back to 5 only when no timeout is given. Tested with a Raspberry
Pi 4 image: loader.conf gets "timeout 0" and systemd-boot starts the
default entry without showing the menu.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Markus Volk <f_l_k@t-online.de>
---
 src/wic/plugins/source/bootimg_efi.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/wic/plugins/source/bootimg_efi.py b/src/wic/plugins/sour=
ce/bootimg_efi.py
index fe6c222..7274249 100644
--- a/src/wic/plugins/source/bootimg_efi.py
+++ b/src/wic/plugins/source/bootimg_efi.py
@@ -145,7 +145,8 @@ class BootimgEFIPlugin(SourcePlugin):
         loader_conf =3D ""
=20
         # 5 seconds is a sensible default timeout
-        loader_conf +=3D "timeout %d\n" % (bootloader.timeout or 5)
+        timeout =3D 5 if bootloader.timeout is None else bootloader.time=
out
+        loader_conf +=3D "timeout %d\n" % timeout
=20
         logger.debug("Writing systemd-boot config "
                      "%s/hdd/boot/loader/loader.conf", cr_workdir)
--=20
2.55.0


