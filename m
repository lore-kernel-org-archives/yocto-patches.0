Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D616BCCD1BF
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 08:51:56 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.6933.1761641515399055386
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Oct 2025 01:51:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=CT6bE82k;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 739414E41391;
	Tue, 28 Oct 2025 08:51:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43D8A606AB;
	Tue, 28 Oct 2025 08:51:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FE0C102F2427;
	Tue, 28 Oct 2025 09:51:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761641512; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=eeqOUrjBc+lFybaWyadHBS61eFh8DCcFOIu7yMTI2NM=;
	b=CT6bE82kikB7RYmwo3XNEWzaxEMOldBj3YSRXoCJkLa72lj/0zntmrm4hw7ObN9qhY3DxC
	LgQPj0qCOE9t+c88nB/vxTM/hLEMJyzMVdRFeX3x+JZbhcK7izlmuJcYEMyYHMku7Kcfz8
	IIGDuuOFBTpsIZV4Ux6chwAkfg8EwdM/FDT4Q67sFziMXoaa9dvOgvkUdL10TSH/l6ZqlZ
	q2mcscgN2g6YHjUCWpAWFYzH8TwfqX4nnFy4GfbFeFom6TcOmGeKwaof8I2i3WnGeJdMx1
	goPvrLL3omoHpKXO5jBQqxbfQyua9kKL/wpAqIqEPA8ateIH5iFa2SJX/1rYhA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 28 Oct 2025 09:51:34 +0100
Subject: [PATCH yocto-autobuilder-helper] config: meta-agl-core: update
 distro name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-mathieu-agl-distro-v1-1-2efb9b98a810@bootlin.com>
X-B4-Tracking: v=1; b=H4sIABWEAGkC/x3MTQrCMBBA4auUWTvQJCjiVcRFfibNQGzKJClK6
 d0NLr/FewdUEqYKj+kAoZ0rl3VAXSbwya4LIYdh0LO+qlnf8W1bYupol4yBa5OC3ikTnQkUzQ1
 GuAlF/vynT/gW3wra3orrnAMJJsobCbzO8wdNTN/EfgAAAA==
X-Change-ID: 20251028-mathieu-agl-distro-cb13fb3def36
To: yocto-patches@lists.yoctoproject.org
Cc: Jan-Simon Moeller <jsmoeller@linuxfoundation.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761641511; l=904;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=BntHVRn2kzup+bzvLWUiHdgkHc6LVL/kXRppFbKGA74=;
 b=o1phCnuETEmQI/3bRuSBaSn4T6EKq4bQCzZFDVzsLR15BbkMCOanO4voE7wHV3lFUlBAhdcL5
 pHpJn/tOoN8BQwdeYbaE4w1CxLCLKUBW5kTd65iw6ujMsJ5LNx05Ge5
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Oct 2025 08:51:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2397

Distro provided by meta-agl-core was renamed from poky-agl to agl:
reflect this change in the autobuilder configuration.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index c4d29aebc9cc..a725d4093350 100644
--- a/config.json
+++ b/config.json
@@ -658,7 +658,7 @@
             "ADDLAYER" : [
                 "${BUILDDIR}/../meta-agl/meta-agl-core"
             ],
-            "DISTRO" : "poky-agl",
+            "DISTRO" : "agl",
             "BUILDINFO" : true,
             "BUILDHISTORY" : true,
             "PACKAGE_CLASSES" : "package_rpm",

---
base-commit: 63f4e3954ff26cfd753c3c21f094b751978dda3e
change-id: 20251028-mathieu-agl-distro-cb13fb3def36

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


