Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DA810F3DEC
	for <webhook@archiver.kernel.org>; Sat, 28 Mar 2026 16:05:32 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13560.1774713923826179069
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Mar 2026 09:05:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=U4xpt9HD;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D409BC5875B
	for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Mar 2026 16:05:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8720D6029A
	for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Mar 2026 16:05:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE0CB104509EF;
	Sat, 28 Mar 2026 17:05:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774713921; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=AyiRlG0FRCkpojqoD8RupvrKrDksmEs5XMyNzmbvt+U=;
	b=U4xpt9HD7HPB04YGUaOpvi2dxMOkKflVDwO5P+NHGLuMMQQZ1mGyCnic0n3l/QYuNSx0iE
	3KWBOXMv/TMa3hRp4v6jPMf+e1/MOLX1EiZEent3WL+fMZiVSokgVp6VCyaYrB7w0MMnf2
	NoMS3y9/e5aA1UWiOypQGQY6xX08rd84nuAOV2O8EZlObStdOwS+u24azN8mUTjP7QHxsi
	+u6fDsc0cZp8jUJQhgT1oHtNrxY4MIL0pqh1rwsToBgxu3EZWIgxi676f7DJE2MXOZvo9A
	h4GPGlIk2+ynJvXqGZg6T52rh4/mpv5c6/HmoLkce1DRoQzzjB+LyxFOFnWfFA==
From: thomas.perrot@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com,
	Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [yocto-patches][meta-selinux][PATCH] libselinux: disable LTO to fix buildpaths QA failure
Date: Sat, 28 Mar 2026 17:02:51 +0100
Message-ID: <20260328160251.417665-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 28 Mar 2026 16:05:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3574

From: Thomas Perrot <thomas.perrot@bootlin.com>

Fat LTO objects in the static library embed original source paths in
.gnu.lto_* IR sections. Unlike DWARF output, these sections are not
affected by -ffile-prefix-map, causing TMPDIR references to survive
into the installed libselinux-staticdev package.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 recipes-security/selinux/libselinux_3.10.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-security/selinux/libselinux_3.10.bb b/recipes-securi=
ty/selinux/libselinux_3.10.bb
index 9cfcf65b5020..86c9168a002d 100644
--- a/recipes-security/selinux/libselinux_3.10.bb
+++ b/recipes-security/selinux/libselinux_3.10.bb
@@ -28,4 +28,8 @@ def get_policyconfigarch(d):
 EXTRA_OEMAKE =3D "${@get_policyconfigarch(d)}"
 EXTRA_OEMAKE:append:libc-musl =3D " FTS_LDLIBS=3D-lfts"
=20
+# LTO fat objects in static library embed original source paths in .gnu.=
lto_* IR
+# sections which are not affected by -ffile-prefix-map, causing buildpat=
hs QA failure
+LTO =3D ""
+
 BBCLASSEXTEND =3D "native"
--=20
2.53.0


