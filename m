Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3628AFD875F
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 12:35:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.74875.1773750903165041017
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 05:35:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=W4cmCATd;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 12D3E1A2DED
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DD6CB5FC9A
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2340104504AE;
	Tue, 17 Mar 2026 13:34:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773750900; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pJVai99z0ntJ6LNP4mzFN/cAYuiPJ+DrHJoPl/egP14=;
	b=W4cmCATdUAgBblB7p7bhKOdeR8Tz84f8FqPnfJW/tHj1DxMVFoGp/qwYYRlkqq6kivy8u9
	M1xRF6xVfvvdbwY9hLaPQVhID6Xup7pFhLMmfYdDOHhWk3BBV5J/qPn9XNu4jOxW0C7wMv
	wW0wq4vve/CmQsQ103znDZSTE9NlRw6RFbH9+2nupfmM/We5rs0djwQL0HkSjoBMEt61Kz
	1FkmX2b5j3fVOYfqjMJFU2+qvRVA6YoaWwFxoHdFJtFrsAaCgSfcQd4Jv5Somi3WUjmkMW
	iaoYSLKUutkHNxW+M3GK40oAZYdkMpaWCGchxG97oHS82H4jsuEbRRV2XEQurA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/3] run-docs-build: fixes after
 bitbake docs generation updates
Date: Tue, 17 Mar 2026 13:34:52 +0100
Message-Id: <20260317-fix-releases-json-generation-v1-0-f57f3267c88a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqDQBCE4atIr9OgJhjIVcTFPEodkRnpHkOCe
 PdMkuUPVd9BCglQelQHCZ5BQ4olmktFbjZxAgdfmtq67eprc+cxvFiwwiiUF02RJ0SIyeXI1gG
 t96MduxsVYhOU/Y/vh3/rbhe4/DX7d3I5sdlzsntYPYRnrBtkoPP8AFtIQvGaAAAA
X-Change-ID: 20260317-fix-releases-json-generation-bcee2ddfbf64
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=530;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=FHZrD475jyzB6fyOfGBYdverScpxfaizy5FeuzWcC3M=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuUpyp8ygpXcXX4fh3TwiVJw8IuZ/hf9AdLhv7
 irzGoN5FmiJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCablKcgAKCRDRgEFAKaOo
 Nr8ND/wLDOY7QKQzbQer/zW+d8wGhzivwSwSl6lUiL/CXOeMHv9htC5n1Hs0+pn2AHclykNLoY1
 k9IhpMwz3+gk0PIlqV49EoEtpB55Xhsa2Dn7sMZnnK1HNYdahDeiTf2nb0kzUuofT6TMiuIPzce
 ndJ3b3G2thizqqm4268pHqMGrxHhoLrc3q1FlRigRiRwpDfJpWsnn3/FL6LmE7bbvWtGCrHewtf
 tJ4oGE3J0P0VGCNipjR5lKH5EsOT8dWE5+NGz6B+KJmc7kbUeGlBQb/NliBXeG6UlxU4JyM0xQW
 AZJ/co4MEqtc3ETAhz5C8Svl0DTjue6xlYiadlxxBX6G24+CyEdFlp5f4VCLYFpbePaBxr47p11
 g7yz5/RoRwH2vX6q7xQb9QAHNzMFvBRn03G2mmO2hJbX1vjpTHj43NwCi8RgZ1a/AhNcWggDZ0R
 ZkQlH2sFabyyLpsfmv/Z50o3OwQmNWRaGK4ch/MAPogLSvA6uu30cOeG6y5U33R154CAUoRYv7N
 OSeaRIoRYvox16H4kdE53A3+azBEDFAfvk1g/qTFNu/dJokVtfrH+MlvztoUybVbken+X7WSRI6
 wTBZQEo4xvWx//lH6Z98ShCnh5wr///KAHRcbx5BRtBnU2rr3rzmZ5NQSO4xB9UnhdAXyD3l4Ti
 h+8/AqCLGk3gaSA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3484

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (3):
      scripts/run-docs-build: fix the releases.json file generation
      scripts/run-docs-build: do not checkout releases.rst from master for bitbake
      scripts/run-docs-build: copy the releases.json file for the bitbake build

 scripts/run-docs-build | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
base-commit: 62d06a23f8168863777b85fa106cf5a1ebb1eade
change-id: 20260317-fix-releases-json-generation-bcee2ddfbf64


