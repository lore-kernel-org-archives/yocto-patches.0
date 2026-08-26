Return-Path: <marcel@solidxs.se>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0B9C61DBD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 13:38:29 +0000 (UTC)
Received: from mail.solidxs.nl (mail.solidxs.nl [135.181.160.165])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12706.1787751504415287209
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 06:38:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@solidxs.se header.s=2026a header.b=MjFxDAT+;
 spf=pass (domain: solidxs.se, ip: 135.181.160.165, mailfrom: marcel@solidxs.se)
Received: from localhost.localdomain (unknown [137.133.17.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.solidxs.nl (Postfix) with ESMTPSA id 864EC2DA0054;
	Wed, 26 Aug 2026 15:38:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidxs.se; s=2026a;
	t=1787751502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ewVYwyjxOYBqL3fTOIQhQLYnmxxGuoEY7vuApgfH3LM=;
	b=MjFxDAT+aA8TwJL/bdDJ+OnblLvecl7CRxKOiGEB3LcrvAIbVBxwd6Iy8U5dJDR48rZTWy
	Vk4qvm+cwsPPhNaWG2+slLSuKwPE7oJ+O2QwBc9b1pLVMTQMVQHcr9TndV31QDuJvREJuA
	VuxktChVILnYoB/UQxskK3edYgF8ZI3usklFqlM05sRzslBSJrMuUnS895kJ8CYIQM61C6
	eS7VUfLpYAod7JSzF0jfyRIk3Ji0K3MedZue8eOUeru42PaCREfPNVToHZRsXjeAMbtzfV
	YWT9xek8lgijKPBR/0Bg7/xww2Ht/fHtba808SjzxVBjMemOCPSdFPetrx8vDA==
From: Marcel Hamer <marcel@solidxs.se>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Marcel Hamer <marcel@solidxs.se>
Subject: [wic][PATCH] wic/plugins: allow timeout of 0 for systemd-boot
Date: Wed, 26 Aug 2026 15:38:17 +0200
Message-ID: <20260826133817.2852505-1-marcel@solidxs.se>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:38:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4688

Setting a timeout value of 0 for systemd-boot evaluated to False and
caused for a default timeout value of 5 to be set instead of 0.

A timeout of 0 is a valid loader.conf value for systemd-boot.

Signed-off-by: Marcel Hamer <marcel@solidxs.se>
---
 src/wic/plugins/source/bootimg_efi.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/wic/plugins/source/bootimg_efi.py b/src/wic/plugins/sour=
ce/bootimg_efi.py
index fe6c222..1f73f85 100644
--- a/src/wic/plugins/source/bootimg_efi.py
+++ b/src/wic/plugins/source/bootimg_efi.py
@@ -145,7 +145,8 @@ class BootimgEFIPlugin(SourcePlugin):
         loader_conf =3D ""
=20
         # 5 seconds is a sensible default timeout
-        loader_conf +=3D "timeout %d\n" % (bootloader.timeout or 5)
+        timeout_val =3D bootloader.timeout if bootloader.timeout is not =
None else 5
+        loader_conf +=3D f"timeout {timeout_val}\n"
=20
         logger.debug("Writing systemd-boot config "
                      "%s/hdd/boot/loader/loader.conf", cr_workdir)
--=20
2.47.3


