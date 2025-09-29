Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A68CAC5B0
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 16:47:23 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web11.2373.1759162884243157206
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 09:21:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=Go8qQET2;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: joaomarcos.costa@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8215FC0244C
	for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 16:21:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 172D0606AE;
	Mon, 29 Sep 2025 16:21:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 265A8102F184B;
	Mon, 29 Sep 2025 18:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759162881; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=sPdLadYU0L0npMp0z6ZJXKoxWh7MTEf1H5TBDWsaWxQ=;
	b=Go8qQET2OjGSqsCA+sEClBUkY/Ajxdf7mxDmdcWd0NLfOjwlOZ6snGYaJctaKNWbe0y7uL
	t4GjVysI5eQ9b+iRVTQgvNZ8yxJILqrnsKJ5k+CmlRA9s/btiCi7btm3z/6PZkC8QPHAHG
	GcUGeNsnW8x7uQri8bckGg3qpY7H3ql2gWzIkAXGHs5MP2Shx+gBn5cLd1Nvt7SfiWkl0y
	ed5SU1betScsW3iW0RSQ5ttptdkMEsX9U5OpopVkFUNcUMGgofkyjm3T3M0X2KPHvxUMMB
	Ao40y0Wv4iEzCRVrtQa3cbTFV18e9uj0Ar4ZbG5iw1UxsHRiY33LqWNHx/K5cQ==
From: "Joao Marcos Costa" <joaomarcos.costa@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com,
	peter.kjellerstedt@axis.com,
	=?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
Subject: [meta-selinux][PATCH v2 0/1] initscripts: fix incompatibility with read-only-rootfs
Date: Mon, 29 Sep 2025 18:20:56 +0200
Message-ID: <20250929162057.48553-1-joaomarcos.costa@bootlin.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 16:47:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2251

Hello,

This patch presents a possible fix for a build-time issue whenever the
'read-only-rootfs' IMAGE_FEATURE is used. I decided to keep the details o=
n the
commit message itself, and to add this cover letter mostly for keeping a
changelog.

Best regards,
---

Changes in v2:
- removed the do_ prefix in do_restore_context as it is used mostly for t=
asks
- replaced the python anonymous function by 'postfuncs' variable flag

Jo=C3=A3o Marcos Costa (1):
  initscripts: fix incompatibility with read-only-rootfs

 recipes-core/initscripts/initscripts-1.0_selinux.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--=20
2.47.0


