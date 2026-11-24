Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17677.1795526089866000538
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 05:14:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=mRnUn3TB;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D422EC2C648
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:14:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6B18C601E1
	for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:14:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8BFD11E6885B;
	Tue, 24 Nov 2026 14:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795526083; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=e3zhGVxEpnIIWiaeeLOjDxWCOcLN56xoW2IWEk9/GuE=;
	b=mRnUn3TBJNl+lB0ynGFDYSB8YyowH3eNSqZYL5bbfWxmDGHfGo9+HSX0i8BS60ltOqGKTK
	yJbZLojAgb+Peb7UqcoKapSe3nAWdvVoUbG6qCGSo2rBlp6eDVZgPf6uyD3UpbZmGUnn0R
	6pW7MhQlRQGJ7HWKnB5WRfHInsKAjeSZ9TTO8hCMKLWNKLSPziU02US/AXR5LGxhH5y9g4
	+7rQ0oOJR+oZxf/j2OvFyP+w/IFuSh+vP/hh0jd/qPirZ99cl/6pEOiZ9UMflgPB+U7iji
	WBeQX6Ax7xyGmWhNxG7v/NQiChTNykjwPvKp9PIGIKbuPCB1LS0LM3QPhqCzmA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/4] Preparation patches for
 auto-documenting oecore's library
Date: Tue, 24 Nov 2026 14:14:34 +0100
Message-Id: <20261124-docs-build-oecore-functions-v1-0-ce9f3c4fbad4@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTsJbbREr0JYwHQqNaRD+kM0h
 LtbcfkW79shcfSc4NHsEHnzyUuooS4N0DyGJ6O3tUG32ijVarRCCafiF4vCJJHRlUC5bgmtoc5
 pvl9vnYEqrJGdf596P/w7lenFlH9k/xHKgmPJcnocceZl5TjAcXwB3hmUYpkAAAA=
X-Change-ID: 20261102-docs-build-oecore-functions-d6c7f2e94576
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=dbHDQfCmOqhR7B1c/B7nX1DYg84H50jc/hkp6h0GAPQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBrBY28fxi0U3W0vtkBvB0xfGHXLGYAUICiLcZ1g
 8upicp7fouJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCawWNvAAKCRDRgEFAKaOo
 NueTEACv49o7SmNvu2lQDm2ey/RUA28czJzlb5UwYfbi3vJ8N4y6zsbZ1hdIxpbYZUqGQQU6TFk
 pXM5nP20eV6QTkyATvOrZgFK+ie0BZi5w1+G/MII6N9an6OapS2aK+nU32j4eEpPsDap8lcTajf
 uOtkxC2Fuo1StkfdQEMcvxH9pGu/Z8jgAtZmdexw2hTb0D0thcFTlxdXXrS7n5aBIqTA8+CMgGQ
 ne9ogXPZ0NRpEW9TodiLDmNOy4VXI3XpqLGWQ+HkSXb5XCtrkOh+y01M9wN6Imw8TwUnsK5LgTV
 ZKpUQBOHSUhe60t2wpihRsD92SPiT73xfuHIR2Yucg5nzcd+NR8CO5ubAHedmK7MHwj4cfokn3V
 se5wedVv5tlt9p4FXNlg7VxAegmcsU5yjBQGkNXqUPTzesiyETzsvfk5MJM5n4qv24kS0P4UJ1W
 G6X93Ldih+L5Vt7nsYvP52PE3abzBBPBL+2TfRNEhR9LS6CwgYFm34r6rWReUcn0cJ9YZljAlPJ
 wIAQZv8XLN89EpkmVuSJ62MXfTVqzuI0gZbPlEKMuk7ReUewwkHN95FMACgQm9s0cfSEjGFLv1O
 LpkgID3Ogni6KBogFvRjTcq1iwjhqAKsGNQ+KJeCipFFHFesJ1m8CC9M9aTIDb1w6hzaleUcFPp
 FbVeTvec0qgzmtA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 13:14:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5507

This series prepares the autobuilder to auto-document functions from the
openembedded-core library. For that we need the openembedded-core repo
to be available before building, and to be on the correct version.

Depends on yocto-autobuilder2's patch sent here (and the config to be
applied on the autobuilder too):
https://lore.kernel.org/r/20261120-run-docs-build-with-oecore-v1-1-75124e549421@bootlin.com

Tested on a local Autobuilder instance.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (4):
      scripts/run-docs-build: add openembedded-core as new argument of the script
      scripts/run-docs-build: checkout closest known ref for oecore/bitbake
      scripts/run-docs-build: export AUTOBUILDER_BUILD when building the docs
      scripts/run-docs-build: export bitbake/oecore repository paths

 scripts/docsutils/get-bbmapping | 24 +++++++++++++++++++
 scripts/run-docs-build          | 52 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
---
base-commit: 7c55f8249e74281d843f3c20453d63774a38c63e
change-id: 20261102-docs-build-oecore-functions-d6c7f2e94576

