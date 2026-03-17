Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B656FD8763
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 12:35:09 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.74878.1773750904375113697
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 05:35:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ewnFr20z;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D939E1A2E0A
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ADF895FC9A
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2412B104504BD;
	Tue, 17 Mar 2026 13:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773750902; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IlkeDJAxot3SDdiwxW6khtKOOcvi0so1bs6u4bzQLGU=;
	b=ewnFr20zy6kFkd7mt/OknLIkjTUDFUNm0Ao5AXAgPiQDpGO/G24UsQPoDYFSnNMFVGBhkK
	J0cnQuAeUwbXVWleuInQGP6B5glaxPIs7SwRw3Gpmu+zEEyvGhHqapCvk+jNjsMCFbTWJ1
	OjeumEJQWHbqf+1x+a1sQk0a8rwBOJu4fo+4SP88qf6GwRh3wTIMDcMR8R6lERNMCuN39M
	m7Zk5NCqwP7dvoKUVaNsKPlHEIc5UFuMmW4SkeyTjrZ5y2UzmWUcyd5Jf/V3qf9M/28KPR
	E1Bl+/H9QlSlXq3eE5568PAJ8OHignKVNujt2HNhVNN+svccsX7erIBJXOA7jA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Mar 2026 13:34:54 +0100
Subject: [yocto-autobuilder-helper][PATCH 2/3] scripts/run-docs-build: do
 not checkout releases.rst from master for bitbake
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-fix-releases-json-generation-v1-2-f57f3267c88a@bootlin.com>
References: <20260317-fix-releases-json-generation-v1-0-f57f3267c88a@bootlin.com>
In-Reply-To: <20260317-fix-releases-json-generation-v1-0-f57f3267c88a@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=901;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=8Jr96pHS/4WckbG6fTzhMVNeoC8zMxtkyFSfjOwljMM=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuUpznsdKmBWw9uQ6mL6/s1TNHwkqFwqOyCEBD
 nIve0g2o4+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCablKcwAKCRDRgEFAKaOo
 NhY7EACkPI+c3cntbyRzlXURLlx2NQ2lQQPeI4MBI/E80Dhn7Hwh2ZqEEgedt5jD/XMbzGDw0xe
 DnwviSZhvWNkFIZbW1vYkUQZe52//I5twX9DyMkmEZ7JXa64td779QMgGSXqMqzq/lYDgUd2HyY
 GCgTJ5DUqAK526RKZC3gP59QJkVzwg4v86JpiYDurGEmlMz7+wTbcqvsrkWyXUMUmSgfo86ufAL
 arNOG985C0UzD98xtRZosHkfof5/t1vbiX4B00kyJr4ZoT2vaXN1W38FvG4vuMceZchwihqFJ8R
 3zGnemgSYwvXUNVc9QeGAcZa9iOBKQ5F5JnlxFWLVevVuf2uor0dr+x/MuytgUFacTagySh8pFx
 0BAhH9SAciHWJ9gyPFxpWBhLyoVOQyMthsF3MwsP6hvqQzMUK6V8m4RgXpdXgraGRmL6KpK/0oH
 ngRvEn21lA1uABaD+OWikxojvjCNwCc5SvbR1xSdrblJVRWQXhmLV7X1kJic0R8Y5Q6DIlP2Ztl
 ay+IZ2hDqgI0K+w8tocQaXvhTds3UtbgZKHtHKuQ8saIekc7nMPQku1eAmd0ZBxwUD2rDkh/CI6
 KtEE62RO5kPYPemNkD1q5V/YT5rwRMRWD86qWFy7cDmkFsquXMYL0ol+bONxdbPCYQz15B9ZkgO
 /AJlSl662PtZP+w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3486

This file is now auto-generated with setversions.py after [1].

[1]: https://git.openembedded.org/bitbake/commit/?id=02cebba47b3d2b415c4aa8098a6af53da448f71e

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index ed32412..a58abe1 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -128,7 +128,7 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
         git am -3 "${scriptdir}/docs-build-patches/bitbake/${branch}/"000*
     fi
 
-    git checkout origin/master releases.rst sphinx-static/switchers.js.in setversions.py
+    git checkout origin/master sphinx-static/switchers.js.in setversions.py
 
     (
         . $builddir/buildtools/environment-setup*

-- 
2.53.0


