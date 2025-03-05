Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB8C19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:03:41 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.10112.1741169016464170441
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:03:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=OeKQDsNH;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E74B44280;
	Wed,  5 Mar 2025 10:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741169014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XXGHfcx1bHHs+GQN6/+1iXv8rOuv/pUG1h/Bdi7xG9Y=;
	b=OeKQDsNHJsgxRVfC+6i1t4tW7zCYEwWg4VYSJ/YEjMB4i6bS0lm2IcIc8j1DwpRNZksfY7
	0hHyH0Ch1rpJZOO7YeNv1s8WK2b4TpXXXN/qhRTMSfOR+61KqnFmbyDm2Gfkj76JcGOLUG
	voE1IzIzDM7DO1MTa2qd7EyrbYnTbFT3UsJ7QHroEzNhfZcKWepvUnzKhGXQhMNNjPkwg7
	QImitIit46j7IG/8M4deZVIG2/9C1FEI8V/OYLzDKcK4521SIDrG7UH4vkZQ9JjwNsunzj
	6trkSiSrdT49lOlUp7QLUWrTCJhzaUWW8fdrISWd1q+5IDpZjL1gWXcSR4i+6A==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper PATCH 0/2] Fixes for
 yocto-supported-distros
Date: Wed, 05 Mar 2025 11:03:04 +0100
Message-Id: <20250305-yocto-supported-distros-fixes-v1-0-308df26dd6d9@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFghyGcC/x3MwQqDMAyA4VeRnBeorT1sryIeXBu3XExJ6lDEd
 1/x+PHDf4KRMhm8uhOUfmwsa0P/6CB95/VDyLkZvPPRBRfxkFQFbStFtFLGzFZVDBfeyTAkn+L
 8JP8eFmiPonSHthin6/oDJhMe9W8AAAA=
X-Change-ID: 20250305-yocto-supported-distros-fixes-3c2c5a9e2b4f
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=542;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=aGbyov+2dqQnpPIYtHyaakOrnhn3VS4qaWZDDwCg8G4=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnyCF156kLPVL9QoUjGFeJP2NmwUUTyMH7R8008
 SsoHF4wNjuJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ8ghdQAKCRDRgEFAKaOo
 Nr9xEADFz+D5z8oVVfsmqYb+nyNvo2CeB4UMd1ma/i6t+koxr9ENyqRhlyE3RVqF3Qt8yX3mEoF
 r+EIqt49pw5nDT+NAmU7u/XOafdJMJp0FfSRj+D8leSLdKLHeD+my70uQLWTBZqhMqmiEHQaQ4b
 0tWhFx96NKodZhqCQqYGuvIxe8avH+AcNDfrPaEXAaG6IlDfV0XEslBmhz0iGmtqhIs6cvKXC7A
 +ricuUxw3a/mfDUfg/dCI0Uy+0x8BbyXPaHpC4kUe6PNN9M/aEsQuMDmG0a6qGEfWpgEjKgTF2E
 stqkJrC1SXu2QBJowUeCBbcrDVIo+DN4iyNl/oyT6DlYdWzvKgKk68smWV6I2x60sNqUQVVGFAp
 kxw4TMJWzxzILzOGswiDdT3pzRVVTjPsaErWJqlSuTQHrwYS8eUC9aKBtQSYJM3fzyocCLgXiL5
 u+QxFaa+CUSpG4cuXZhEM6JdFd2yY52WCYZ8eqQT87/B6GNVUanfViTbAYq/Rw1G84pp9X4rDeD
 QWWYTgpJI6EjjB2pnhqRvWlYJp/LFSn1/BDDXFmXpkYsub0YOzagIimw/YNigSMNz0d9Sgq9CSv
 DmxOtpxUyOJFPcKJ99exBXvHuXxPKMkbUnLO+gAv1+75ItpvFEpTpFtgN5Vs0mMX9vOIbnSfrkH
 ueYS7U/MEihJBRQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduvdefkeffteeluedvgffhjeegffduveegfffghfejteejkedvgfeuvedtudejkeenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsr
 dihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:03:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1144

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      scripts/yocto-supported-distros: run bitbake-getvar with --quiet
      scripts/yocto-supported-distros: ignore missing on AB for stable branches

 scripts/yocto-supported-distros | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)
---
base-commit: eb162faf3c7d1b721a1511aae5621a2feb282e3f
change-id: 20250305-yocto-supported-distros-fixes-3c2c5a9e2b4f

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


