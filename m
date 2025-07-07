Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5053AC8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 14:05:51 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web10.220.1751897146602904533
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Jul 2025 07:05:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=DSaD5Nxf;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 944D144275;
	Mon,  7 Jul 2025 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751897143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T3r3OjP7MxZoCe9jflW04jr8bp5tQGlOfjDz55rgEkc=;
	b=DSaD5Nxf6tNxlKH+1Bc7F+lbd01vm8j7nvC6CIK7z080O2AesDUmuNIzL3zVYBSL0YAq5W
	IkajcuHqXHGj6yRkgPpaaR3RhLcBhmyprR+PfTCrzIwKZd3PnxaMYgVO3uyFet3P3zcQTK
	UQwf9rgA+ySQdyew75vitSuBJlOmGL+2ZcP3hu3I/HD0D5hidqCWLkqNgK0CPjgdaHNZIm
	7uJSA6xmE804LGfg6Z1VU/hT0Srr7sXqtxRLwmF9loxgrbk0DO9HSEjIe8e30PKtIih3Au
	/QGqSe/7XqOjn2vAPzVIl0/UBskHKy8KGwrD9/y2p07kRuLBM/A2M/L/vlyneg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/5] yocto_console_view: Fix build
 bullets title
Date: Mon, 07 Jul 2025 16:05:22 +0200
Message-Id: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLUa2gC/x3M0QrCMAxA0V8ZeTbQFbTgr4hIl2UuMJvSpqKM/
 btF7tN5uTtULsIVrsMOhd9SRVPHeBqA1piejDJ3g3f+7IILSJqsyISvaKtww6y55YeJbYw8BuL
 lQj2GfsiFF/n87zf4KplibKZTk23m4uF+HD+rf3+BgQAAAA==
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751897143; l=1128;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=rQ3Y1751F0azA29qtCy0zzCwzLkYpr7nfixKCnXxOYE=;
 b=iOwi68sb6Xdcq32GPM9eTKXL1REQekLNohMiK4RrpFoUWCAefIpfg4ppZIvS5X9TV7pqlEu2A
 T5wbhpqlC2iCL4340pL5l0j5sFBgQfn1EN+Ji1gcT3rakfsPhaq+O41
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuedufeevjeeukedulefggeetkeduuefhkefhvdfftdetheeujefhueevkeehheetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdro
 hhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhm
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 14:05:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1776

Fix an issue where the browser pop-up label was the same for all build
of a builders group.

This series also contains a few small improvements and fixes for the
docker files allowing to run a local buildbot instance.

To: yocto-patches@lists.yoctoproject.org
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (5):
      docker: Add note about using a custom buildbot branch
      docker: Fix scheduled builds disabling
      docker: Allow to use any worker for builders of previous releases
      yocto_console_view: Fix build bullets title
      yocto_console_view: Sort build bullets by build id

 docker/Dockerfile                                  | 29 +++++++++++++++++-----
 .../src/views/ConsoleView/ConsoleView.tsx          | 16 +++++++-----
 2 files changed, 33 insertions(+), 12 deletions(-)
---
base-commit: b9db368e79c5d761c3e6c1fea8697914fc5fe930
change-id: 20250707-contrib-mathieu-popup_title-e17cef6c6c6e

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


