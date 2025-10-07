Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7794DCCD187
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:24 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.20394.1759847833772291481
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=tZ0QbNpi;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C663B1A11C9
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9DB65606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E7AA102F2156;
	Tue,  7 Oct 2025 16:37:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=EZaMLontGQnq8mQfuncAXAnjhWb0+hgtUSH4fxul7yY=;
	b=tZ0QbNpisbrF8Hdh9jlM+cgqME+I8wzzOShORlgMBtwBKqGR0X+hVaZB/r8V9I7c5eCNZ3
	kWkyWe/56XgIfHeIAGPllQIzxMQNy4slg5apE75pkiVmCZeISsvV0mEwqRJaLCBxV2iRkW
	HvZMcyqXaq76LaUbq4k4uDSC+mQje9w9BJB9kn6+WGXQY29HNwv0nXUKtaqsG97oedjh2x
	5i8/WmlKYQ5IGBbTq4qPfs/wJKzYUM0agD05e4Woq/IK9lKg459zCsd1I3P5JbxlwoB3CA
	nlgxBwxiuOPHr6Uan//TUmMeP97L6KaoMKB2lCCBKgTbSaD5nGpEe5KllUDFTg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder-helper master-next v3 0/3] run-config:
 Export some build properties
Date: Tue, 07 Oct 2025 16:37:01 +0200
Message-Id: <20251007-contrib-mathieu-build_props-v3-0-0263f52bd682@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI0l5WgC/43OwW6DMAzG8VdBOc9TSFMKO+09pqlKjDcsQYySg
 FpVvHujnLbLtON3+P/sh0oUmZJ6ax4q0s6JJZRxemkUTi58E/BYtjLanPWgLaCEHNnD4vLEtIH
 feB6va5Q1wdmiRsSh67tWFWGN9MW3qn+ou2AWcFuWmlCEieaVYrO4lMsKdMvqs1QTpyzxXl/a2
 9r+6/reggbTj2Rb4/Bkh3cvkmcOryhLlXfzUxv+1kzRfKcv3tuLJ93/1o7jeAL+SEcDPAEAAA=
 =
X-Change-ID: 20250904-contrib-mathieu-build_props-54c0ccc96861
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847830; l=1565;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=F0MPNjOsFMOHfBcPdY4vtIRWLPZFTRgvWhgRfc6+O+k=;
 b=8dDBj9ImXb57P3Fs4kksBX+K6vjXhTXHMJff73lueBvwWK08V+AJeqlEszKy7qdRJ0qGw6DqM
 GlzjD+PIDthBwyoPmjY5OxFg9iwOqvEbiwoDrd405gmRvdBH/XFcFOy
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2274

Allows to extract some build data from the config.json, such as MACHINE
or DISTRO. This will be used by the build configuration step in
yocto-autobuilder2.

Additionally, add a property explicitly saying this build use
bitake-setup. This is used to either show poky or bitbake/oe-core
revisions on the console view.

Also add b4 configuration file, to ease a bit the patch submission process.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v3:
- Use scripts/getproperties.py instead of scripts/run-config, easing the
  integration on the autobuilder.
- Add a build property to show we use bibake-setup.
- Link to v2: https://lore.kernel.org/r/20250909-contrib-mathieu-build_props-v2-0-b607bb47be08@bootlin.com

Changes in v2:
- Do not modify the list of arguments expected by run-config, allowing
  to merge this commit only on some branches.
- Link to v1: https://lore.kernel.org/r/20250904-contrib-mathieu-build_props-v1-0-28de412ac349@bootlin.com

---
Mathieu Dubois-Briand (3):
      b4-config: Add basic b4 configuration
      getproperties: Also extract build properties
      getproperties: Add property to indicate we use bitbake-setup

 .b4-config               |  4 ++++
 scripts/getproperties.py | 24 ++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)
---
base-commit: 88bf60ac133b683cf335751d94198cd140c4b6ec
change-id: 20250904-contrib-mathieu-build_props-54c0ccc96861

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


