Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D1410F3DEB
	for <webhook@archiver.kernel.org>; Sat, 28 Mar 2026 16:00:42 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13442.1774713635720891674
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Mar 2026 09:00:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=nchtgYb8;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 966681A3057
	for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Mar 2026 16:00:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 543CF6029A
	for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Mar 2026 16:00:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E6B6104509EF;
	Sat, 28 Mar 2026 17:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774713632; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=VzWx2ravf8lWLZEjlmExfI2blxGHMgW3jyN/WXWxJJs=;
	b=nchtgYb8c0mSWLLTku3hvn/Ae/ut6b538msE0TWYk1D8leKW14wFjwaiCGskpy2Mn7Lvj9
	veDVO2Sdhjxk+MRceglzPyyB26fo7TPvwJIHPLowHHBUvvLJbV9jeF0AwcikX/zmhkfXGH
	fnYBmC6EkZBrr9IqpWZVasvZm+z7Gqs1DRSW5Cq8GZ1JS0qcX+tcKCzp8jULrkqxBD4ZZ9
	dTcRFPFr4o6YZ6Av0hVYbpePks4JFkFn1coz9isR34/o1p9M9DyENzzV6eydySmBmyio9L
	LTo26XR90yOU4o8357WuZkO28WuGxBysNzAlo6SC36clpyCbaAlVjbvkrWTvUQ==
From: thomas.perrot@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com,
	Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [yocto-patches] [meta-selinux][PATCH]] libsepol: disable LTO to fix buildpaths QA failure
Date: Sat, 28 Mar 2026 16:58:21 +0100
Message-ID: <20260328155821.407004-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 28 Mar 2026 16:00:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3573

From: Thomas Perrot <thomas.perrot@bootlin.com>

Fat LTO objects in the static library embed original source paths in
.gnu.lto_* IR sections. Unlike DWARF output, these sections are not
affected by -ffile-prefix-map, causing TMPDIR references to survive
into the installed libsepol-staticdev package.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 recipes-security/selinux/libsepol_3.10.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-security/selinux/libsepol_3.10.bb b/recipes-security=
/selinux/libsepol_3.10.bb
index 0423a2a6ea31..0a51aba28ee8 100644
--- a/recipes-security/selinux/libsepol_3.10.bb
+++ b/recipes-security/selinux/libsepol_3.10.bb
@@ -13,4 +13,8 @@ inherit lib_package
=20
 DEPENDS =3D "flex-native"
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


