Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267FAE83EF4
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 08:08:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15337.1770192528564848334
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 00:08:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=oIoqDSdB;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C891F4E423F2
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A04C360745
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B366119A8891;
	Wed,  4 Feb 2026 09:08:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770192526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3+L2mJ7AT/42IA1VmHXv3Cdql79TlR/BKkA7Sw1hkAA=;
	b=oIoqDSdBaJJNEiP8F/uT9Ujqc+3OGSvVOigyRwA2UqI/zy/l9P+K3PPszYOs37yUQ67HwL
	1Nv9n6yElW8w1HG5EvV0FH67UILk4thJtgxuVQVuZqg5cxcOUMzQnOT99lRKBqNNS6E5cO
	e+BzwzvSuvKTdO/b2WXemzlOwDHzsAzHWTmG5D/nj79yZwadP2cTDOncsgI0ffzNoDlqfB
	I2eaQeJFbW97sYhYRfeVhIYUOjKFVEsRO49FHKeHwGF3cD3nNE8sRh4x8QL12xlEeqre0p
	GNjL1HbL9IXHHfmidZSBlpeSxqOYMh3KhnZAl+fk7CZzeBrUsMGh0i3Gr3XZug==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Feb 2026 09:08:21 +0100
Subject: [yocto-autobuilder-helper][PATCH v3 1/7]
 scripts/release-parser.py: use yocto-docs instead of poky
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-releases-parser-updates-v3-1-be208a7748b1@bootlin.com>
References: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
In-Reply-To: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=93JbW9h7rG27B1XETvq+kQt/at35uqsuLDAK+kV4zxU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpgv6LgrbICr4SPnlgMmWnj0n4C2kOFUFgLvZ9p
 8pWD/eJqvCJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYL+iwAKCRDRgEFAKaOo
 Np9pD/0YPrdU0MTVe+dUyFAPFQs+ZPIIJRNp2c5DIZI1vhnwvLwReEmGc95aMIlpBAJbpb+VrhC
 lAVz80gxwPDAcV5wMr8Jh2hz85gCVc0aCSXlhsOC2D1xnML4orl/44bgkjkBQ1PX1lxKT3FnWW9
 V/ZBt/UrqD5gAsB+nBZ/uaklAxpOCJnAXD/r8wexD1TJo6s8nnwk8G24QyvIi0gk1fALcYzYzsV
 udlItBZOSgbqBJMzNcZxtvIiLEQxyMMVlQwL34xNR0n1iVXik8fULVhM5vQo2TJsEwiF3bNTpkx
 q1L6uiX3PEeXUNv4WZZKTyJU578d3ZQFghiep8CjtnBSVXxHi8GDnxyIsTcUumHmLiD1D2Howj5
 phay/zH7a+Jzgzfifoy4lZgw6NG55eKuq3TNOCHYChN/bXBj79rA2pzYODuzWYM0buXx5kpOMd9
 DMfPPxb4eIrzUzqSmLz20cgvRrUpmOPKzFFxfFtP6uII9f6redehHgNUc3lvTPXaWUWm/vbfsMD
 A219W5swtLCkVnoTFfA7gZ79ogrcn+xrCXQMnYRhulm/YuJKKvxuYUtdNIR8Bl0JLT5F9eSd0tG
 VG1PTmh0VhSRYEAqqmYOtoZ1WIbxxl18aXCJSgg9kWvV+kkbjPiYw8qYLpnynOsisIr1+Du5lt9
 WdDah+3blrG8yCw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 08:08:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3183

For the release-parser.py to pick up new tags, we need to move away from
the poky repository. Right now, one of source of tags closest to poky we
have is yocto-docs. Add this repository as a dependency of the indexing
job.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.json               | 2 ++
 scripts/release-parser.py | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 4f6d305..8fb34af 100644
--- a/config.json
+++ b/config.json
@@ -1402,6 +1402,8 @@
             }
         },
         "indexing" : {
+            "NEEDREPOS": ["bitbake", "yocto-docs"],
+            "NOLAYERADD": ["yocto-docs"],
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
2.52.0


