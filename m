Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17912E83EEF
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 08:08:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15339.1770192529199464230
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 00:08:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=FuKVSOpk;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9FC9E4E423F4
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 755F860745
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 052BA119A88F7;
	Wed,  4 Feb 2026 09:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770192527; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=taROIC6bFNyPnJGCZbSgxjrTGmp0vR3br4mTvGTlKmc=;
	b=FuKVSOpkOdIk43H0uaWuX6nb+q3SfOl5z8yLRNOX/7VQaEhXdmlZfEoqUBPylc8BRyfrcG
	NNxF6YBMWXOOTIiWKcn1zCcN9w2XJmjBep5toq0cCAVQmhbwDhaphCC7aNU9uMu51q1Dmr
	Y8Ybw9//bRZIs7MBMFq7fAYywShqZQYrLAWa1pYcIVw67Q0atnQX8fiOFMRf1UUtdtDHFk
	aJpnF64j3yIBcqxy82cCgsNRDCH6X5AqW0izdHHQsc4c6Bz8Bc6HgXKW0mdx613CxQIFTD
	vHECxOVR6MWc0pkNObd2zNY1hZhdCIQ6WmvgZFx5wYmN8FjisnAFQp4w5LiJ1Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Feb 2026 09:08:23 +0100
Subject: [yocto-autobuilder-helper][PATCH v3 3/7]
 scripts/release-parser.py: define globals for stable/active versions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-releases-parser-updates-v3-3-be208a7748b1@bootlin.com>
References: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
In-Reply-To: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=dp5dWhAQbAQ2jzTEjrCwlVF+zb+h88SOi78/jTWg2Yw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpgv6Lh2yVY7Vptj97lGFL7c1zX/zhqwo7ZN2de
 6u1IOH0VJyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYL+iwAKCRDRgEFAKaOo
 NgyKEACk66oY2XbcNm5nUlSWCuOumvwvEYQNuAFUW86SLYmbuoB90sCsiScjPqQnOdGw4tVA4cT
 6REXGFs91CFy/nhQDd6M3uOOmd8ofPcq8KoTTWcbHt7+LsU8kKl0mSMQjn2c+bNuXiLVvh0XLT4
 SZT6Y6KEVYOCCl+e7lGcZC5Z0M2DZcH30pr2vNCSH8LpKFLnR5VZpQrnqtkX/2TEkIt4IcltBdB
 gsY5jO6dZUCnY72ImrQtGV1UDc/T9mCIMD79wxnXeAuJ1aQ4JGr0j6tWu5daXbCZk0XK4PCzr/S
 IVmOAjQBpLzRvgN6k53d4otC9Whqlj2x/q8cuFg74rW74vUfOZnNUuXgMBicUXh7bm+8QoIi6Lv
 knCDVpSp4SLHoxQybMMPhnU3RIkw2JHrtwU3sc4j3QlfkdKum6nFgZvMsgeqSrp/BVOah6MZEzG
 1rcRm2C50FmLSLE/lNqVacMyi/+KxCL8lZ/6pTC/4cXTcP2+ldSK89pm6wdIuzjY1dSi66W+v9w
 dKwlwVvMNZGAB/bXthiKWY6q33EWPCuTGNrmrzZPwbst+y+b1MCKwelHWNYhEmAm88sxeBKM+YL
 paOhy36B5Jd/cgeuxYHh78goh+b8XKRlHotPzaw1gOohUVRH1lWkP3YNLiVSlmQeUol8uvBuFCC
 fSeHQDMjvuelyKQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 08:08:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3182

To avoid forgetting a spot where the we need to update this information,
define it at the top of the file and use it in the code below.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index e882569..33c5fe7 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -17,6 +17,9 @@ SUPPORTED_RELEASES = {
      "yocto-5.0": "LTS until Apr. 2028",
      "yocto-5.3": "Stable Release until Apr. 2026",
 }
+CURRENT_ACTIVE_DEV_CODENAME = "Wrynose"
+CURRENT_ACTIVE_DEV_VERSION = "6.0"
+CURRENT_STABLE_BRANCH = "5.3"
 
 repo = Repo(GIT_REPO)
 
@@ -109,12 +112,12 @@ tags = sorted(get_git_tags(), key=lambda x: x["original_release_date"], reverse=
 
 tags.append(
     {
-        "series_version": "6.0",
+        "series_version": CURRENT_ACTIVE_DEV_VERSION,
         "original_release_date": "",
         "latest_release_date": "",
-        "release_codename": "Wrynose",
+        "release_codename": CURRENT_ACTIVE_DEV_CODENAME,
         "latest_tag": "",
-        "releases" : list(e.name for e in filter(lambda e: e.name.startswith("6.0"), repo.tags)),
+        "releases" : list(e.name for e in filter(lambda e: e.name.startswith(CURRENT_ACTIVE_DEV_VERSION), repo.tags)),
         "status": "Active Development",
         "download": "",
     }

-- 
2.52.0


