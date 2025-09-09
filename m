Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40636CAC583
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 14:31:14 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.15035.1757428273384003352
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 07:31:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=RenZX8GG;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 07D274E40C4D;
	Tue,  9 Sep 2025 14:31:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D563960630;
	Tue,  9 Sep 2025 14:31:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E167102F1C96;
	Tue,  9 Sep 2025 16:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757428270; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=CHJK6BLObVY2L6u5uy/4DEWBX055jcpKDSRBwe/K758=;
	b=RenZX8GGJdHjdtOhSDKuuU3kzCwn+ELaiq7/t+ruPKztKLhuVnCfXlKFZ7xQZK7EAnAuXf
	2ia6M0uq9JvznLf6wB14y1e9CVR8jqhfOZDDmnR1+rZ8c997yhi5lvyfi09734YIJu2UIz
	6W4ecrj3ZwZpr//3hGOeC0vVHn3l7u/Cc/iJoCzPrDWAPejRYAkJXM52v3UmK/VSDXGR8o
	w50oERmqsV3e1RKXrIYr00cpIsY/lNOLbXv1hI+rDrQ1eHnwMYNMCIg/Ilh+Dz5wMTh+y3
	pJO6uQQtc2w7NbUZIHhUcnxCxclPf8DHr+znsH8+WnveN+/+FWf8+d49f3v++g==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 v2 0/3] runconfig: Add build
 configuration as properties
Date: Tue, 09 Sep 2025 16:31:02 +0200
Message-Id: <20250909-contrib-mathieu-build_props-v2-0-14b809f99dfa@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACY6wGgC/42OXQrCMBCEr1L22UiaqqBP3kOK5GdjF9psSdJiK
 b27ISfwceCbb2aHhJEwwaPZIeJKiTiUoE4N2EGHDwpyJYOS6irv8iIshxzJiEnngXARZqHRvef
 IcxK6k94genlzHRTDHNHTt9pfsLHNLPSSuVYwKugLM1DKHLd6YG0r+dfW2goppPdae+tka83TM
 OeRwtnyBP1xHD9dqiIr3AAAAA==
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>, 
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757428270; l=2262;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=rsaStwvlWGFUgoaojzK/HrR2kkNWG3ZMDE7Kus0KKr0=;
 b=xHY50Od8eHN6atsNPtTD0+9x+g6bVUZUatx2f2t2Brs/+ssDE4NUqHR9Pa2QpR5S53voK8qiM
 98Bsp9fYvy2AHw4JtkcQReGOtaXIoihXcgGhLW1o6tT/kOAzk/ay0uA
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 14:31:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2153

It was recently brought to my attention that the "Build properties" tab
on buildbot could contain more data. One is the build configuration,
such as MACHINE or DISTRO, the other is about the poky-ci-archive tag
that is automatically created on a-full and a-quick builds.

This series aims to improve a bit the situation, by extracting DISTRO,
MACHINE, SDKMACHINE and PACKAGE_CLASSES from the config.json file
describing builds configuration, and adding them as build properties.
More properties can be added if any appears to be useful.

It also stores poky-ci-archive tag as well as a web git URL in
"poky-ci-archive_tag" and "poky-ci-archive_url" properties, on a-full
and a-quick builds, copied to all sub-builds. I'm not convinced by the
need to have both properties, so I'm open for any feedback.

This series has a dependency on run-config modifications, in
yocto-autobuilder-helper git [1].

Also add b4 configuration file, to ease a bit the patch submission
process.

[1] https://lists.yoctoproject.org/g/yocto-patches/message/2129

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Fix arguments list to account for v2 of the corresponding series in
  yocto-autobuilder-helper.
- Do not fail if the properties json file was not generated, allowing to
  keep compatibility with all yocto-autobuilder-helper branches.
- Link to v1: https://lore.kernel.org/r/20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com

---
Mathieu Dubois-Briand (3):
      runconfig: Add build configuration as properties
      builders: Add poky-ci-archive tag in build properties
      b4-config: Add basic b4 configuration

 .b4-config                                              |  4 ++++
 builders.py                                             | 10 +++++++++-
 ...0001-builders-Do-not-create-tags-during-builds.patch | 17 +++++++++++++----
 steps/runconfig.py                                      | 14 +++++++++++++-
 4 files changed, 39 insertions(+), 6 deletions(-)
---
base-commit: 45b64625b3d58449fc6e18bf2cbe473b63745656
change-id: 20250904-contrib-mathieu-build_props-a30fbeef06d3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


