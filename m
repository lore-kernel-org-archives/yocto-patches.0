Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B458C87FD3
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 15:44:33 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.28546.1754495066289047114
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 Aug 2025 08:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=J1b5yJpQ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB95B44303;
	Wed,  6 Aug 2025 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754495064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PXjR5f74PqcNybIfNhgCMec0kZ5bCPRYQaRRBQxfBPw=;
	b=J1b5yJpQ9OVc/StjIdjNy9lHOYytuRAA01A9d30OUCTieLmPJKi1VhMbPRMTrmasm98RPe
	TsTY+BK+AOa8tOfefU6s1TEP9M/IovJeiBiJIUo9McLSYT0zY+b2rBcYplghLlKargPUWz
	p0wzLACFxEXnt13HLlWRnxUjohafrgCo+TxqRoTRFIdNY4vReRaHDFLkK4crSGqpiF6xwH
	GMfVlRrjpgTQs3u5mzYbp+/zDiYPjtSFMNyEE+Of+oezHnPrCqVSP3tchs/ORKjusNbzBd
	dMG0+Pf7tSGFEuY7WOLzZZYUBdNti0Fhuu5YHA/Vncget5E+E9qtT5ekfjMGTg==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH v2 0/7]
 scripts/yocto-supported-distros improvements
Date: Wed, 06 Aug 2025 17:43:30 +0200
Message-Id: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACJ4k2gC/4WOQQ6CMBBFr2K6tqagSHHlPQgLOgxSQYZ0CkoId
 7fgAcxfvcV//y+C0VlkcTsswuFk2VIfID4eBDRl/0Bpq8AiVnGitEokNAitfJNr0Un2pR8ZWZp
 rpCFWqa6zSoTu4LC2n92bFz/m0TwR/CbLZwJPshw9mdF2VTA12A3oiq3bWPbk5v3SFG2Gf+tTJ
 EPUObvoMgWA5G6IfGf7E9BLFOu6fgEa3iMc6AAAAA==
X-Change-ID: 20250805-check-worker-statuses-b618c2078f9d
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=j2GNeh/5JwixIthu3+NCAmG5xHXtUQI93bjCdXu4+s8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBok3hWk9ZsqAIosncCKq7K6SRAfHUYxFN8RacdC
 Ek7KCabF8+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaJN4VgAKCRDRgEFAKaOo
 NrRsD/46r1owzxMF6QdzyvVH9w8g3h+RNyMEVQXkkiOfDXHlqA67lsks9JgP6r6LGcgGVNuGMwL
 vj5BxzSJXOui5ZHJagDm52/Ah+VsxLP4khKH4rVoGvPW3I73mZnAXCJMVmkaAXGBU9FomjCc++y
 evt0kF893eEhsAvHm9wahJG0B6As/0+uPnSXp/QkY3KpZWYNqWJ/J5n6wXWB420Ik9l8ftt1TUp
 mODVpmTbPlCXZgsAxoWaz1LTgZS+7X73WgRQjZqR3YG745q3F1v31w8EsSGM/IuHLoZu/YXX7ps
 g5opfutU1o3qP5jGEhBopmJB4mpbO6NBp8ADtDR7w2nNL4C/F4p2h2v+Qop6qOLjvNMKxgjUxgs
 H82M2gXL/ccxWNSzZDjsRZyHs/idavx32wpHEOpLUXUEnjukz4kcdUdpH6sQYhZDx5eQdYOpdGK
 JL1Dm3i7aT62EDzl17mDbcSxBIoWcgtMA6d33RXBnyZjUzjYIGXzfn35u5uL9IdZDWZF5r5nQuF
 7tSYMFckC1i7xET5EsoPwln9gn9Qk2gqT2DPMlZBWzhbyy4da2dazrbdpXt8TY4aNf46C7pgc6x
 bMwP9X2j+1UO2KcIwSnnLq0uZ77dFC/qZJsqVur9kYJRVdWpB22y1P3fC8UtRqic/sM2o5nk9uM
 //9ydfCnvbUwB9A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtudeuhfelveehueevudefgedvtdfffeevleefuedtjeeuteelgeelvefftdejteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgp
 dhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 Aug 2025 15:44:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1893

Several improvement to this script including:

- Checking the workers statuses from the Autobuilder API, to check if
  workers are disconnected.
- Some refactoring and simplifications (non-breaking).
- Option to print previously supported distros (--old-distros).
- Option to just print distros listed in SANITY_TESTED_DISTROS
  (--poky-distros).
- Options to modify the output format (lsb_release string or docs bullet
  list).

This will make my life much easier maintaining the supported distros
section in the docs. In the long run, this could be called when building
the docs to automatically generate the list.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Add patches 2 to 7.
- Link to v1: https://lore.kernel.org/r/20250805-check-worker-statuses-v1-1-103948a7ccc5@bootlin.com

---
Antonin Godard (7):
      scripts/yocto-supported-distros: check worker status on AB API
      config.json: yocto-supported-distros: use --check-worker-statuses
      scripts/yocto-supported-distros: configure mutually exclusive argparse groups
      scripts/yocto-supported-distros: pass one release only
      scripts/yocto-supported-distros: add option to print old distros
      scripts/yocto-supported-distros: add --output-format option
      scripts/yocto-supported-distros: add --poky-distros option

 config.json                     |   2 +-
 scripts/yocto-supported-distros | 308 ++++++++++++++++++++++++++++------------
 2 files changed, 216 insertions(+), 94 deletions(-)
---
base-commit: baa4a9a06acf544e91f4816fd0cca484a6f7dab7
change-id: 20250805-check-worker-statuses-b618c2078f9d

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


