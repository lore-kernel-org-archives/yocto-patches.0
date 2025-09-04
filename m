Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577CFCA1002
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 15:49:20 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.132.1757000958163455054
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 08:49:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=aPz8hRDF;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D16EB4E40C32;
	Thu,  4 Sep 2025 15:49:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A0B9B606C4;
	Thu,  4 Sep 2025 15:49:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D662B1C22D6B1;
	Thu,  4 Sep 2025 17:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757000956; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2fVUqOXcFWSjFkGBabedQcamXR8vg+7IrVmtGwCnOqs=;
	b=aPz8hRDFl9TTpfG0PCFyRuaVAsKg6Wz3pkFbQxVu3Bv+azvNeXVhuVVfFUzstu1E+48WTP
	G5I+GmNqPgXRSGfJ8aPyIehrr2h7Tx/Hbkb6yb6V8ZNyYxd7qFnoDQycSmJ+zHmm15Wdl0
	svBlcTENM2blbU3oCh0/i3Bs10p87bgxgB3QMMy1de9HABvvw9sFJQfoOa4SWIKf+0x8Xk
	/gR35QuLufslswyxZle/UOBd3akSVTD5F1MkzLaDrfLh/99yhWdd5Ncy852n3iLFQpVgg6
	1lITWamV83SsI7KKB/dFEviq/pbhkqnaNgMkC58xdKu0sNJV9e6PoLjl8lLl2g==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/3] runconfig: Add build configuration
 as properties
Date: Thu, 04 Sep 2025 17:48:48 +0200
Message-Id: <20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOC0uWgC/x3MTQrCMBBA4auUWTsQUxX0KiIlPxM7oJkySUQpv
 buhy2/x3gqFlKnAbVhB6cOFJXccDwOE2eUnIcdusMaezdWcMEiuyh7frs5MDX3jV5wWlaWgG03
 yRMlc4gj9sCgl/u73O/wkVEHXquwJqYXHtv0Bd5ssOIEAAAA=
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>, 
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757000954; l=1697;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=oB2gCgb6Xwiz+VzEQMYZr6h/+J1ZFA0Q9bOgfUSpTfQ=;
 b=WWq4eZHr/DCYCM1z5bPkeU2dimjMbCK17x3qPNVZjkGtG3PadMMufiFfZA4t3ARTGXp0WZGkq
 hL3RxAyOzmMDH7hM6YDOc0OLR0QVt6ZWC4Oj+/AoMDzhVauuppbDfw3
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 15:49:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2131

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
Mathieu Dubois-Briand (3):
      runconfig: Add build configuration as properties
      builders: Add poky-ci-archive tag in build properties
      b4-config: Add basic b4 configuration

 .b4-config         |  4 ++++
 builders.py        | 10 +++++++++-
 steps/runconfig.py | 12 +++++++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: 45b64625b3d58449fc6e18bf2cbe473b63745656
change-id: 20250904-contrib-mathieu-build_props-a30fbeef06d3

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


