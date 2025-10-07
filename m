Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E98CCA476
	for <webhook@archiver.kernel.org>; Tue,  7 Oct 2025 14:37:34 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web11.20530.1759847844177313886
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Oct 2025 07:37:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=vwAxuQR3;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DE4DA1A1167
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B4D19606C8
	for <yocto-patches@lists.yoctoproject.org>; Tue,  7 Oct 2025 14:37:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4359102F215F;
	Tue,  7 Oct 2025 16:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759847842; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=YC0/CV7ciHhw9CKn46ofh48p7WxNVKVuwmLas1hOb4w=;
	b=vwAxuQR3wAouzr1mT3uPqYoXA28PeCDDUCncz4bG3zbG7AU53qNcM6vnXsb3eKr70RZweB
	ac4tSkkmSNisyFQLM8InOBiGUI5hbgiV+dryLcugoKZ2jxY+gZ4l7xP1/F2Kl8zjE1gaiX
	XtZgzKfhGaEnru+srz16s2gcSL0xmv73tIoSG3gzMcnFuPPcq+xwmHbOpZz+8UggrPzWtj
	itTGJOMV7bx4hvgWNFkUKQRGIFKpE0OifL220fwZBmXv70TLW5tMWgzsepmYGYseb8AToh
	0Q26wmc/ac2/gHgoN7Q/hjNBpZfmjwn2Xuy+Ae3SXk+fQV2sX6Tyg5wYEFOyMw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 00/10] Fix links with bitbake setup and
 general improvements
Date: Tue, 07 Oct 2025 16:37:16 +0200
Message-Id: <20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJwl5WgC/x3NwQrCMAyA4VcZORtoAzLwVcRD20QXnO1oU1HG3
 t3i8bv8/w5NqkqDy7RDlbc2LXnAnyZIS8gPQeVhIEdn79yMqWSrGvEVbFHpGCM2sb7hqvnZkAL
 PQuSSZ4YR2arc9fMfXOFbkhUM3UrsurJUgttx/ABrdSjJhAAAAA==
X-Change-ID: 20251007-contrib-mathieu-bb-setup-links-2ad7e220c1dd
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759847841; l=2148;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=4VamVqqxrp2YC9fX1JMKQacZlPhMCIFpPzc6XgASz2s=;
 b=m57us4RpcvFmDqjeFdo9n/oE5nu/NkFdKQUxZGFnTk8O8FC1PLm4U8njV5o6MXyXx2/0Gpnz4
 a6q8jGuIDSCBkgpDjG7VBU3J4rcObr7+oNT/4yydiKitCATs866TJez
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Oct 2025 14:37:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2276

This is kind of a Frankenstein's monster series with a lot of various
things. Patches in there have a few interdependencies that makes it hard
to create separate series.

Richard, feel free to cherry-pick only some of these commits if you feel
more work is needed for the others.

It contains:
- Fixing console view links on the autobuilder. The "Error" link will
  need more changes in error-report-web to work as expected.
- Fixing docker file to account for the recent changes.
- Adding build properties for poky-ci-archive tag and part of the
  bitbake configuration. Imported from my previous series and modified
  to account for recent changes.
- Add of the b4 configuration file.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (10):
      docker: Update buildbot version
      docker: compose: Fix docker role detection
      docker: Fix missing directory
      builders: Fix disk space error message
      docker: refresh patches
      yocto_console_view: fix commit links
      yocto_console_view: fix error link
      builders: Add poky-ci-archive tag in build properties
      b4-config: Add basic b4 configuration
      builders: provide builder name to getproperties.py

 .b4-config                                         |  4 ++
 builders.py                                        | 20 +++++++---
 docker/Dockerfile                                  | 16 ++++----
 docker/compose.yaml                                |  4 ++
 docker/entry.sh                                    |  4 +-
 ...builders-Do-not-create-tags-during-builds.patch | 30 ++++++++++++---
 ...Modify-free-space-check-to-work-in-docker.patch | 18 ++++-----
 .../src/views/ConsoleView/ConsoleView.tsx          | 40 +++++++++++++++++---
 .../src/views/ConsoleView/YoctoChangeDetails.tsx   | 44 +++++++++++++++++-----
 9 files changed, 133 insertions(+), 47 deletions(-)
---
base-commit: 0dc19a8f0b247f7ca78da6419b16fa743d9ae307
change-id: 20251007-contrib-mathieu-bb-setup-links-2ad7e220c1dd

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


