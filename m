Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18F1D72357
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:00:16 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63623.1769158811220571520
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:00:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=LAVATbeJ;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DFD1D4E42214
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE89B6070A;
	Fri, 23 Jan 2026 09:00:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D290E119A8790;
	Fri, 23 Jan 2026 10:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158808; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=K6DyoTsFhd1jkD5PHiulTDaxPHixSlDCjZNeooPpn0A=;
	b=LAVATbeJFhGmmmm90/K6hzhobZvFRM9eHt9x38THdwd3JxyNQmlqz0xUlJcclnmqNAeyRf
	4LkEQ0U/HzmWsyi2NSaXmudpLeFA45QlHNXtUwcztHVy1sMDv4pmzEg+H5C9FpTqBUfIY/
	vzX1ArXa4iAEw6Yjr7X1qtSm0RYtTeSQw0zlOnawScytSpAYbZOAUnsIZLSgGM6T5zVzSp
	Pvv0j8n/sO9zss2lQwhO28uHd0otB+aq8u/NHBrYKn7+0ewqdIJWrEYumNNGvRIIRZO3ap
	/JSspV2h1kFXr0S33MXoImeftqiDoMPNRfaR9hkkl5l4cLzlXLQEoPHz9RYTEA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH v2 0/9]
 scripts/release-parser.py: update and move from poky
Date: Fri, 23 Jan 2026 09:59:43 +0100
Message-Id: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH84c2kC/4WOSw6CMBRFt2I6tqYtUMSR+yAM+nlKTaVNP0RC2
 LsFF+DwDM65d0URgoGIbqcVBZhNNG4qwM4npEYxPQEbXRgxwhrKaIcDWBARIvYiFBdnr0Uq2Cr
 S1DV0Fe8qVGwf4GE+R7kffhyzfIFKe65fnEoOi5yczMbqEhrBegjD7o4mJheW49RM98L//Zlig
 vm1IsAFb7Ukd+lcsma6KPdGw7ZtX/seXs3sAAAA
X-Change-ID: 20251219-releases-parser-updates-7c0544e93693
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=+cmslbvjarc3E9P/O1rx83yNvleaxVozj5cN9FVQsjA=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcziU0oABBL1GqvaVyxuwheWFwKH9sk8t1r73i
 zuY0thhZZaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXM4lAAKCRDRgEFAKaOo
 NlIBD/9pSEY/hhvKV/JKMXKgALHtoUnv+bD69DIEkPYjyT9EFy6tdzm2PfaC7AEkmROLebpoIn6
 /sdrs0NeVpVzINmojbHgEOGu7/Ab0yXlLwi0g89tAs3l3InCT+aHd1bmfb+s6elQ5NDwptSHyVG
 7B297vrfgw1uY1o3x1MbO1prNDqluF9MoyqcIZ9sjbCCJI5B4ZGkQhb2z+lecQUWgjFmdwbhqps
 VV0cCfYpc5vR+lydC9q5uyj/g4OelY5Z7/RQkV0rbiwDMnKBkrjmi8pRcKJ6aymK6Tf9RXEi0xM
 oBbp/SdMKA8yHcSaZU7KrcWotYgJFWKyKdRB4Wosc0N4A+rYfTXO1uUr561oSp6v64A1oeJomgp
 aOVNpC8eKdoRHVgMgAlBYuu2dvSlbphxhHW6VBxqiPr40f0idjIGnDcMPbIfnNFqpqu7aAibdec
 0CT7S0pkCqT5PsS7q9xU2sLSTA0Ixhy4n+0F7iXHuP6IaLCu/Fkk/wnK3OIFnPdNFfuYRjRGLYM
 o8WxR+G/TTfGl2x/7uWHJnCQpZ6+shuDUxFuacq5bsmisuFfAAPsf0cHNSH7L69Y0VlMiZZAZor
 T1aquP2G7yjciF28f3Uy99R8cxeuT6AmbBuPoE2DOJ0b5UmRhz8DfxD7AYfcctdxfUlrc77de1X
 Fnnmzqo25TLbdQg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3056

Make the necessary changes to move away from poky and use yocto-docs to
get the tag information we need. yocto-docs is currently one of the
closest source of tags compared to poky.

Also do some refactoring on release-parser.py to make it slightly easier
to maintain (by only maintaining variables at the top of the file).

This is what the output looks like if you want to verify:
https://0x0.st/PPgi.json

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Declare an array for supported releases as suggested by quentin.
- Rebase on master.
- Link to v1: https://patch.msgid.link/20251219-releases-parser-updates-v1-0-6830e6a67db0@bootlin.com

---
Antonin Godard (9):
      scripts/release-parser.py: use yocto-docs instead of poky
      scripts/release-parser.py: update for Wrynose/Whinlatter
      scripts/release-parser.py: define globals for stable/active versions
      config.json: indexing: add bitbake repository back
      config.json: indexing: don't add yocto-docs as a layer
      scripts/release-parser.py: use cloned yocto-docs from build directory
      scripts/release-parser.py: don't remove non-existing branch
      scripts/release-parser.py: update commit for yocto-docs
      scripts/release-parser.py: use latest_tag to get branch name

 config.json                 |  2 ++
 scripts/release-parser.py   | 34 +++++++++++++++++++---------------
 scripts/run-dashboard-index |  2 +-
 3 files changed, 22 insertions(+), 16 deletions(-)
---
base-commit: ec17abb0b2d759b800cefec4fcac61cee74dbefc
change-id: 20251219-releases-parser-updates-7c0544e93693


