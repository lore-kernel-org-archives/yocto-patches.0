Return-Path: <joaomarcos.costa@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4131CE7AAA
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 10:53:08 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15250.1763117580003632167
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 02:53:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=GrZPInl9;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: joaomarcos.costa@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 380454E416AD;
	Fri, 14 Nov 2025 10:52:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F384A6060E;
	Fri, 14 Nov 2025 10:52:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93FE610371C42;
	Fri, 14 Nov 2025 11:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763117577; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=eeMHxvNHmzb2h77tAlG/UXLuI0b3NchrCNYg5pefRzM=;
	b=GrZPInl9KPHFeUjqtzn083LLaAKgDamJ6mxV+h5FWTAPOUghxwK2xptb1FpqnUGh0crNCU
	IKcLgF9O5MUCx6cv7awitxfemDHaYuqYZdPWiaxSXmzhoIz4UTSPnF8pZ6e6Z+pKeTXUeX
	8UaLmUEzXMGEtxG2zuhQE6jV5JdEAcFmEAjqXMnJIWQ343D2cu3ObQ7IkBhzP2hrKJ8csr
	Xep3aVbOkMbhkoQhSJ2tL7sGG9/3CJTz07dRd44dR9B2l2gVNk7m/aEjCHHbwPJW2QlvoR
	gYiOg9Jkn7dUna5ggE84caIDp+WJHpZqw9Hh0+BiXjKtNE7eT+TBR1FSjF4H4Q==
From: =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com,
	joe.macdonald@siemens.com,
	yi.zhao@windriver.com,
	=?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
Subject: [meta-selinux][scarthgap][PATCH v1 0/1] initscripts: fix incompatibility with read-only-rootfs
Date: Fri, 14 Nov 2025 11:52:41 +0100
Message-ID: <20251114105242.206611-1-joaomarcos.costa@bootlin.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 10:53:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2559

Hello,

This is a backport from master branch to scarthgap:

commit 91bf2937722476fe2b8f9d787300cfcd04670c5e
Author: Jo=C3=A3o Marcos Costa <joaomarcos.costa@bootlin.com>
Date:   Mon Sep 29 18:20:57 2025 +0200

    initscripts: fix incompatibility with read-only-rootfs

Best regards,
---

Jo=C3=A3o Marcos Costa (1):
  initscripts: fix incompatibility with read-only-rootfs

 recipes-core/initscripts/initscripts-1.0_selinux.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--=20
2.47.0


