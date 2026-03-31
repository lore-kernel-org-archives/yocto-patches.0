Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1FDFF60E0
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 08:12:24 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15064.1774944732292390455
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 31 Mar 2026 01:12:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=rKRvd8hW;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 228644E4287F
	for <yocto-patches@lists.yoctoproject.org>; Tue, 31 Mar 2026 08:12:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EEF3E6029D
	for <yocto-patches@lists.yoctoproject.org>; Tue, 31 Mar 2026 08:12:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D8F210450EF5;
	Tue, 31 Mar 2026 10:12:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774944729; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=NZg11ExjQgTo/iAe2SQaTF/JZyLkIIGW9rENcSOtWDA=;
	b=rKRvd8hWWd+pAiwg/9HNtgoOQmqbYQBJ98G/A9JYc15Vp+efLcrrrd92SIFyWAoBjCeOiI
	cWE5StgztYKadD7Fw6htNhliaiP/LbX/RKBdHspZFW7agWS5j5s4X0gkTwCEN9RuZmlSZi
	pD2WUQ6BkmQWbm+L/fT9qXPj4qfqr/ofyyyinne8T3fLzJGx1HpwlVly+BBqPTQvw2hkp5
	mWdsH15emlhH2uKD1M/LBzJorBNO1ZDF/fz5edH8plhgvBhhXlQruq4CYBd/kfzcYWuerD
	atDgM8BDLex4IwmfFp8nvO0XvSJ9AIEa+FbMGcj3mB/PwcuhNYUi0CjZk8Sfsg==
From: thomas.perrot@bootlin.com
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com,
	Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [yocto-patches][meta-selinux][PATCH] libsemanage: disable LTO to fix buildpaths QA failure
Date: Tue, 31 Mar 2026 10:12:01 +0200
Message-ID: <20260331081201.72633-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 31 Mar 2026 08:12:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3590

From: Thomas Perrot <thomas.perrot@bootlin.com>

Fat LTO objects in the static library embed original source paths in
.gnu.lto_* IR sections. Unlike DWARF output, these sections are not
affected by -ffile-prefix-map, causing TMPDIR references to survive
into the installed libsepol-staticdev package.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 recipes-security/selinux/libsemanage_3.10.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-security/selinux/libsemanage_3.10.bb b/recipes-secur=
ity/selinux/libsemanage_3.10.bb
index 1279cce23e22..4a18faecfc8b 100644
--- a/recipes-security/selinux/libsemanage_3.10.bb
+++ b/recipes-security/selinux/libsemanage_3.10.bb
@@ -65,4 +65,8 @@ do_install:append() {
=20
 }
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


