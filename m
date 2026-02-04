Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCBEE83EF5
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 08:08:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15336.1770192528499520132
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 00:08:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=LhljwTeF;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5A99C4E423E2
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3268360745
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC49E119A865B;
	Wed,  4 Feb 2026 09:08:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770192525; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ojbVLBhJEb3xVSBN63FeDg+sqdEaveHWU1sg5RKUhr8=;
	b=LhljwTeFSkSTD663pazcy+4y+PpPM5QL5k9U01PQnifg8BwxLogkuui5oC4ibCr4EYqTbt
	9ImcaR7IZXFBpheX7pdLnd9IEOZDeNmwx4xtFWCdqw5Hagqel0kIeqXq+TLVptsSctZrFW
	JjNVLKwr/OImQnHyg9p6EnOMLIjLhgSVMfNkw52kSm0vJz66y2GRF7XE3LNpgYTxC9gNnb
	2/IxrUHbgZPDcPlvMtw/gtP60PNQx4k+jyxm9Afc8Hh2K/Z3PrM/tQ0lowXO6npO16VaI9
	htSBdSvp76IO42POAdsRoJk/0dISYGtGpjO8esTcNxND3pWIcf/9EM4RPp8kcA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH v3 0/7]
 scripts/release-parser.py: update and move from poky
Date: Wed, 04 Feb 2026 09:08:20 +0100
Message-Id: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOvQ6CMBSG4Vsxna3pDxRw8j4IQ3+OUoOUtIVIC
 PduwTg4GMd3+J5zFhTAWwjofFiQh8kG6/oU/HhAupX9DbA1qREjLKeMVthDBzJAwIP0aYvHwci
 YstAkzzKouKg4SuvBw9U+d7lu3h1GdQcdN66enY4OyzE6NdrOJKiFbgDfbNvWhuj8vD810U34f
 3+imGBRcgJCisIoclHOxc72J+0eaPtgYh9JEMr4b4klSbNMc2JkSQr1La3r+gIcPfLBNgEAAA=
 =
X-Change-ID: 20251219-releases-parser-updates-7c0544e93693
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=CtgRP7tDZJ8yVQiTph37P/FaqDdD8CaotNWoshe81/s=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpgv6Lez/c4G+Dljk3qFF9b0wm3vWWh3GwwqAuL
 e0bJLmSBdmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYL+iwAKCRDRgEFAKaOo
 Np4MEADDoMSOVPinevFmHDUFurtfH3ADRSkFr+mn+eFMQm0Q5AJxS96kIrFTiem4a+XfHgP0Yhq
 GK4GZ9am2LLfUpQbnZBLfSheiPUBmgSiluD1jBTC/11k1o4qykgwoQsURqf2gaHSaegeT8ErZx+
 vs8UVz58T8URhIKcZh0ST88DIz/vCuP+8nUkqGNGo3rq6rG+02aQCEUTWFwFSk0M96sOgfSCCDy
 wzvzfVSn2Oyy2x1iLQEY29kkZwB0XuyNftIQNfQ6t4IwGhawLA4MNRt+xBweIR/6eVqPVgrB/Uv
 sZ2sXdfxxI5tGCAOosRkYwZUmajMADxw2YXS5k5DSEMOh5EXp1ui1HfJHAYo8r7Rqnzk0OQfSkR
 SJZPJ/hYoFovVTAlDTs5PQHQeDVljtNM2YvA4OwpgWMKd3yphzjy1i1PfKnmsT3Zja1R8wtVAb3
 IynvVM1dKpU3/b5Ms3WTwJec22uTNqi9hVbEPSEjkE6W0oLPOzp2DB1g566KOLreJO9HEYqwVgg
 cXGJVIujejFDdR3xqjtqR+DQisd373y1NUxN36Hq7ms7usIP/CJzPXpqLv6m/SRs5P/Wae7uBN/
 HegNp8Vvky7Tdaos0qsbA08aCM+uNpFnoH7TM8XL+hMeD21gdAJy2YyNREJuXvBSUkr2NRnm80D
 crU+xroA+8mghyQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 08:08:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3184

Make the necessary changes to move away from poky and use yocto-docs to
get the tag information we need. yocto-docs is currently one of the
closest source of tags compared to poky.

Also do some refactoring on release-parser.py to make it slightly easier
to maintain (by only maintaining variables at the top of the file).

This is what the output looks like if you want to verify:
https://0x0.st/PPgi.json

This should fix https://bugzilla.yoctoproject.org/show_bug.cgi?id=16138.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v3:
- Merge patch 4 and 5 in the first one.
- Link to v2: https://patch.msgid.link/20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com

Changes in v2:
- Declare an array for supported releases as suggested by quentin.
- Rebase on master.
- Link to v1: https://patch.msgid.link/20251219-releases-parser-updates-v1-0-6830e6a67db0@bootlin.com

---
Antonin Godard (7):
      scripts/release-parser.py: use yocto-docs instead of poky
      scripts/release-parser.py: update for Wrynose/Whinlatter
      scripts/release-parser.py: define globals for stable/active versions
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


