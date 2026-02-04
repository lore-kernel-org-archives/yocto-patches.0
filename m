Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357C2E83EF7
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 08:08:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15340.1770192529584847918
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Feb 2026 00:08:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=YYD9NiVv;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0D3D84E423F6
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D248860745
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Feb 2026 08:08:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FBA6119A88F8;
	Wed,  4 Feb 2026 09:08:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770192527; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eHyOJZXTB2jRg0VlsJARbpaosvPTYgwdA+CXoTYJ91I=;
	b=YYD9NiVvvXJMyX4nVE5UxD6hjHvU/UKAbPie0tRAFrExjcTRxDGxYMZG3myVoIkRjKJls0
	8KDaJJK2yzb0r2GTzAyqxVexmWi97zVIPYYot+yotzLWipZW+UUhQj0q1BgyDFXFn3RvFP
	ErpmciD6eiq1EVyXbacC4PCL4BSyz789qj2LMgrez/r+F/uAomgqG14rpEwbzbzQroJHfu
	neXZFv37KtbB9DG544GBjouqrs0aPr5CrV/l6QC6dSD7hFZzE3Ti/URSHT45FOSLXZqHrC
	xEyGEV8tVKo+ziILKASPmFUlVGBZ6fsdm5BshLOLou2ZBHH+axS7GBspfsedmg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Feb 2026 09:08:24 +0100
Subject: [yocto-autobuilder-helper][PATCH v3 4/7]
 scripts/release-parser.py: use cloned yocto-docs from build directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-releases-parser-updates-v3-4-be208a7748b1@bootlin.com>
References: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
In-Reply-To: <20260204-releases-parser-updates-v3-0-be208a7748b1@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=1ta+NaNaC4Ok1gphZ0R2yh4cjYzi9gJPZl9VrxquqvY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpgv6Mx43KUjXwBpSO0tzJ3Bx1XT4FaRWRtSXUY
 98pZmkIUVqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYL+jAAKCRDRgEFAKaOo
 NmP9D/0YnU6EZWXop3xWBAaQ/TRVDya0q+IuG3rrKdSnTGgQP4He3xKACasnjzXfImHm2ARHiBt
 ohWDvSUM+jLfVYAa6pY5KS3zLyLjQkXLlWohktGculjssMLLLMxi1htmlIaPo1+Gd7hLdKF/Dlk
 En4vHHGSxknKA1TEjm/0DeU+IQ69hOMRSgFfJOO+7LU3J9tPK/J645wkNSDWAEECfOAaJkD6OCI
 +FQkKjVwiX7qPEg4sdw0v9r4GYzEX5RJlG6hU6pESWwsRywkodoS6gHwAeX4ZotNsoZ24AnjvU4
 PpWkUYgPE98I8ishTAQxal+nUJnGkyuJ2CatmKs+iCN8Tw/Zqtap8Q0cNEUjuGRj/cLhFtCv7Ja
 mFeQR/k180TYAqjNTVDtXiAI4j78gbhsr5Ek9JVTiLllvKwnhbk7QTFxdpjhid1OrHq5elHk0K5
 //BV2xCb9WM/BpuUdnRc9z51MSQR4oww/aI8JMFVy5M/si+aalmEprp8/NcPitd8eKhQjBSDKgd
 jBTqr9GoxggwEokesqgy2iYNmbKIizseIBG0Ucf6E2F7KsjQwdQ4YkL4bqulqJt8U7Y7O5kPbDI
 N7fSNqLFmGBtRAMHNL4z8XhOgPvLiI3ztvPjMpJLeduWDjBnTLrbbE3EYPyHPdkeWK9WW+2szp+
 poZ+nsY7ttJ7vJg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Feb 2026 08:08:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3185

Add an argument to release-parser.py to pass the yocto-docs repository,
and pass it from run-dashboard-index.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/release-parser.py   | 4 +++-
 scripts/run-dashboard-index | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 33c5fe7..cb56257 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -10,7 +10,9 @@ from collections import defaultdict
 import datetime
 import semver
 
-GIT_REPO = "~/git/mirror/yocto-docs"
+GIT_REPO = sys.argv[1]
+
+print(f"Reading tag information in {GIT_REPO}")
 
 SUPPORTED_RELEASES = {
      "yocto-4.0": "LTS until Apr. 2026",
diff --git a/scripts/run-dashboard-index b/scripts/run-dashboard-index
index 8c5222e..c3fb8fa 100755
--- a/scripts/run-dashboard-index
+++ b/scripts/run-dashboard-index
@@ -16,7 +16,7 @@ scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 dest=${DEST:-docs@docs.yoctoproject.org:dashboard/}
 
 cd $builddir
-$scriptdir/release-parser.py 
+$scriptdir/release-parser.py $builddir/yocto-docs
 $scriptdir/layer-parser.py
 curl --silent --output $scriptdir/dashboard/testresults.json https://git.yoctoproject.org/yocto-testresults/plain/oeselftest/reproducible/qemux86-64/testresults.json
 

-- 
2.52.0


