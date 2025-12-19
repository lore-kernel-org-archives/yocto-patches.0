Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB21D767CB
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:36:08 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14245.1766140566698784075
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Dec 2025 02:36:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=l5pHN/sn;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 284D04E41CB5
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F35736071D
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B513102F0CD5;
	Fri, 19 Dec 2025 11:36:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766140560; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=COfeaHbyieXyTX9o2uA/Y1fkKA4rJXUoII2FwjDnwnc=;
	b=l5pHN/snLRX2wxmC5zbyuIAzvUc7PUPI9oprlNv6Lo7HvqJ0Zdlc08YVObVcInOV1akEqY
	raXkoGN6tksZWkwThLreYiaId0RHg/Z++dEbTPR1dan31BCwbBELSSY81aR3M92fIWaehd
	Z3ZRLtFtMo5M2jmD7kRLZ8lj5TdHV++WxhHD0krSl2pRiaDslU6HmE6pSOY+t1806wYf3+
	KkYTneN6k1gDapBUrozXPAjFRtLUhXeEyy/YvJxcCP0pc6X6ETFYPVe1Ycz1i0yBkmnNdR
	OqXjMRIS3FrJvpEr5znzMsRkYEZ2DOfT+uIqU2bClhztYGNQlbGzD2wdi/d4Uw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 19 Dec 2025 11:35:37 +0100
Subject: [yocto-autobuilder-helper][PATCH 1/3] scripts/release-parser.py:
 use yocto-docs instead of poky
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-releases-parser-updates-v1-1-6830e6a67db0@bootlin.com>
References: <20251219-releases-parser-updates-v1-0-6830e6a67db0@bootlin.com>
In-Reply-To: <20251219-releases-parser-updates-v1-0-6830e6a67db0@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=R0QY+okYnj9ZhTNAQQDTGOEnFu/JAkmpIccrWje4VOk=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpRSqKGll7jmoIf5+mXjbkFnMnIbVOj3yzWajkn
 8w8m4/lO3eJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUUqigAKCRDRgEFAKaOo
 NoaCD/4hhE7YfI5SD2oXl1gkxLcwoIHN+SdKbWQDODcuQFEoGHtOCslx7+DMRvdvR/2a+JrdYf8
 0JGTlOwBdbQb7+XVqsee1N0jj14pH+40o5qg70p4vqcvzyOyUr4rVzpmsc7EI+csbazozo4/4Ig
 d+rRLMNr8mKSPmviYd8CuNyulbhlFNRYUwK02ZCb93QIozBYdDnircSukWR1wEal3Md/qolKadR
 li5ocvVF653v20xbYr/MbaS4p/jBQt/RmcXWqYZjGY2dIvBseIu9WNTCJYGiVaRaZrifkGCnjz7
 lnCGb3oUB0kfKF67R3sTxi9ZuZi+aSkhlYU8K9OjeNZVfkmeNLg2ITLaPmGMp+O+TUkx8JQwrEj
 EkAMs6PBRjosKoWWpRXvvtATyXaaGNeLmBV0ocNNh7o5GIBlaWHQfrsyKteLtqXAH/mxGtn9Xfc
 582lKwouR9UDMhDjiHUy+9/QjLF9nPwPzmOj5KnFM4cw7NbKZI30sVbEIARrBmLw7TZdkaPCNpP
 GxiTS8ANRRtFGo7PWwhxAw1hlFMZEu4Ccl8zOwUveP2lE+qPIusBAe/b8Upz1NGt4hFRy6zDgw1
 7buMqlbQ13uWzxg3EjgSHulJ8U7b4pXgy/17nUOydYbK+4R4LLFSAGmq83+1z835rgpxguMprz+
 BRoJZ1pMiZnRgPg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 10:36:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2829

For the release-parser.py to pick up new tags, we need to move away from
the poky repository. Right now, one of source of tags closest to poky we
have is yocto-docs. Add this repository as a dependency of the indexing
job.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.json               | 1 +
 scripts/release-parser.py | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 3229cde..be65d24 100644
--- a/config.json
+++ b/config.json
@@ -1402,6 +1402,7 @@
             }
         },
         "indexing" : {
+            "NEEDREPOS": ["yocto-docs"],
             "step1" : {
                 "shortname" : "Generate non-release index",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/generate-testresult-index.py ${BASE_SHAREDDIR}/pub/non-release/"]
diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 21a6d57..ef25289 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -10,7 +10,7 @@ from collections import defaultdict
 import datetime
 import semver
 
-GIT_REPO = "~/git/mirror/poky"
+GIT_REPO = "~/git/mirror/yocto-docs"
 
 repo = Repo(GIT_REPO)
 

-- 
2.51.0


