Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8C6CA101C
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 15:46:30 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.34.1757000780050365033
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 08:46:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=gGbhPUl+;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2CDAD4E40C03
	for <yocto-patches@lists.yoctoproject.org>; Thu,  4 Sep 2025 15:46:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 06335606C4
	for <yocto-patches@lists.yoctoproject.org>; Thu,  4 Sep 2025 15:46:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A45FC1C22DE71;
	Thu,  4 Sep 2025 17:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757000777; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=qcGPBPNjjOOzj2+Nq30PznOb8JZE/6Q1WDoMLyQQi7A=;
	b=gGbhPUl+sgovZ5G/SzoOLp90azo4PZfUydL8expCLJbWGVn9qjZ1tHJRr6sOdkP4UYB0wZ
	7nlbxw9Rz9MwME0kurZ8DKIbX2ri6EE3d1bm7Cy9uv1h6mHxJE70njGAONwg4R1ZfpZMdD
	FlW1Nf5X5j5PBoxZy+3jXCZr1UXxibnBSJHkB0M4HQbo5gmbJzrAzaIT8ZAOsVV5dO9MWd
	OGhYDnMuqJMnT+Y1l8Oqs6WCyDSEQKBaagU6QXW/UfMRX0XP2lyVhOxIrKDbLoW4/jfEyM
	lfMk7GjWJ2ypY/jHNyum7wVj0WTrUBuZzhNpaiUnvM6u7tBnzAntrB3nBrixxQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder-helper 0/2] run-config: Generate a file
 with build properties
Date: Thu, 04 Sep 2025 17:45:30 +0200
Message-Id: <20250904-contrib-mathieu-build_props-v1-0-28de412ac349@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABq0uWgC/x3MQQqDMBBA0avIrDsQRaX2KqVIHKfNgE3CJCkt4
 t0bXL7F/zskVuEEt2YH5Y8kCb6ivTRAzvoXo6zV0JluMJPpkYLPKgu+bXbCBZci2zpHDTHh0JM
 homm8ji3UQ1R+yve83+EXKAe0JYczYUXHW2SFx3H8AUZjo5+HAAAA
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757000770; l=795;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=tfI1YSKFj4bC1S5y74GHMiSXe9Y2Ugq4CJHhxWcShYs=;
 b=s3C19BTbzgsFRL8a0MlmMxhnxehBs0N9gbKkmDNoM9HIghAb5JxBd9MabAvid9UoagrRqatpW
 f6Nm0Dy7rd7A8SXu+PKrz5gYFu2FK9tU3gv7XsPhHZGvTq77kfi9zO2
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 15:46:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2128

Allows to extract some build data from the config.json, such as MACHINE
or DISTRO. This will be used by the build configuration step in
yocto-autobuilder2.

Also add b4 configuration file, to ease a bit the patch submission process.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (2):
      run-config: Generate a file with build properties
      b4-config: Add basic b4 configuration

 .b4-config         |  4 ++++
 scripts/run-config | 31 ++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)
---
base-commit: fa3e15fba7fa96da520343c2ad312cefa6fc9c87
change-id: 20250904-contrib-mathieu-build_props-54c0ccc96861

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


