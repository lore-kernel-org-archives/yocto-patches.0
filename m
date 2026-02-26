Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B869FCE094
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 14:26:51 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70961.1772116000210648075
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 06:26:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=LdaaBeoE;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E85DC1A13C4;
	Thu, 26 Feb 2026 14:26:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A3BCE5FDEB;
	Thu, 26 Feb 2026 14:26:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4ADA910369392;
	Thu, 26 Feb 2026 15:26:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772115997; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=j3RmNpcsCnzf5Q3noioIanuM+1YnBrSyecTiK0T+Mvc=;
	b=LdaaBeoEIsvRxcdaprvkyO4w6PrYMdQcO16oLWq0pOZZUB9xYkCuZbqcz0KkW7nKjLATw8
	iXB3QCdCNem46D/1XBQCmqGbsSkz0Bsl45/q26jpzwYRBokHzDN5d+YBHdxOYnIHLkGPNU
	CAvfQW1jRcWfY6MqB4tYNNFjLIsca1mY586zVqAd6nyPoHsCfGGubd7h93PD7xuywWiWbA
	jNWlAlS/T558AWsVW+NPA6uqIhBTE5dlRiB/E2ySpjFnb8h42lKw3XSNX9yz1mH37e4xFe
	qCHpu+sEjVgzfTdt8lSgDlMPgZyg9P7WJFqVe2/dBIjT8P/tAQwcaJJPzuhHRQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/2] release-parser.py
 improvements
Date: Thu, 26 Feb 2026 15:26:28 +0100
Message-Id: <20260226-release-parser-improvements-v1-0-3cc1c9842a87@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrBvQUFR6FXER4586RU2YRLGId
 2/aLt/ifSdFCCPSozhJsHNkv+aobgXZyaxPKB5zky51XWpdK8EME6GCkbwqXoL4HQvWFNW9qeF
 c69qmspSFIHB8/PSu/3fchhds+pLd29vkldmSHzaex6xNmAOkp+v6AOZtCoWZAAAA
X-Change-ID: 20260226-release-parser-improvements-476eff8f871c
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=446;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=GRLeQ2hCMStWE+mgO4C5GeqgiEuLUkIAbJjnT1TRgqk=;
 b=owEBbAKT/ZANAwAKAdGAQUApo6g2AcsmYgBpoFgbsj2dEVNOOFgGSGYvMN/mVh6p01rkYnu6i
 3tyJ/S08fKJAjIEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaaBYGwAKCRDRgEFAKaOo
 Ns/bD/jvP++mKFQjtzRmqGP0izsRkmcNt5TCW0geyYzCqVDYGcdEfOcoljFATeATYiOFJwbscgo
 yR26F2a3aqVtIj5bZwa2cGWWhCC0wgpFXKI7q/0aY8m12qF3LBfCcstxX60lidCcsMSZgaMXNxK
 MPpbK9JvnlH/nMIulBJg/meRxpoVI7trwiz3vsTc//kq6YclHHGQfjB4yyLDeWszEyWX9JuqHxD
 AmUiNMXeaAy+G9sIH5Bmqb6lehg9r3YGEaezwcSG+g35xCMm1nH6VtcXBvnnksfWJeQ19VnZ/Rj
 LQBpNz8Lfsvk6Zh+QdFsM7T/APS29AWPemnRRLGTVs+vg4wNimx6WQcb8TnP1Xzl47ZIvyaqIF2
 giyVB/2EOAYpfHiMOvN2KWMNmiWJ3q1zFGQ55VRBs7grWOSqky9yQNMOlnjv2X852ouGPtM96iC
 3fLqcsrST0wjJiGshR66TGYFm/km8qSn4GrZHtbgpX6mwgcc4/F3In4aTdP6mAol+OxpUhFvliM
 rw20s+VmmDslHeqVg/e7ifZDWw+8+5LEiu3ZL5j0ogG6N6IKEhcIMxTMTb+Cl/jv0922KuoMhI/
 rhimc0wC7E3V/Tm8WehFpftdcRquaxgnoOutYOT0+d5O/mFeS5/hsbQz3iqxnyy/uAG2Ev4OvZx
 6ZOeSXWSILMpa
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 14:26:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3287

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      scripts/release-parser.py: sort tags based on semantic versioning
      scripts/release-parser.py: sort and remove unused imports

 scripts/release-parser.py | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)
---
base-commit: 4c389f7f8e9f3e7f9fd46313dc7f25027caf60ca
change-id: 20260226-release-parser-improvements-476eff8f871c


