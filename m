Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAABD7235A
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:00:17 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63628.1769158815061587584
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:00:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=xTGR6PqQ;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8FDC5C21ABD
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 66C416070A
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63015119A879A;
	Fri, 23 Jan 2026 10:00:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158812; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eHyOJZXTB2jRg0VlsJARbpaosvPTYgwdA+CXoTYJ91I=;
	b=xTGR6PqQI+OCVHLoDA+PbLO16pzNrNfNuQMP+Tv8ipUCusGm9dkEqtlOLSRZRQGxcxirpB
	846TFE5FnF+8lyN3XlhDbI7bhqxpEPiODqIqQtgyPDl1dIx/t40olIPEk1dHLEAqmLpxy/
	JjqK6eHoFDzFjd4bplDQ5FyXGVWP5cJ6u0lQyi3KbBZTQwG4+LmDWSdcjOMnZGJPo58j6s
	/l6fydUsvhni5F1BpgEt3c8cRhoMby3mDC56tPWzOyq6kVa7wizzCLYehfdazsIlyYkJEF
	GXmfSV2PeuqnQ+FPtH93L+HXJ6uodD/VYkYU+ZGB6AGm9E17G5Oa3PfB/PokeQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 09:59:49 +0100
Subject: [yocto-autobuilder-helper][PATCH v2 6/9]
 scripts/release-parser.py: use cloned yocto-docs from build directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-releases-parser-updates-v2-6-c24c30da807b@bootlin.com>
References: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
In-Reply-To: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=1ta+NaNaC4Ok1gphZ0R2yh4cjYzi9gJPZl9VrxquqvY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcziViYaEdpZDVuVKoxVwkjf3B+7sQTXs00bDJ
 P/vyZ5lhrCJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXM4lQAKCRDRgEFAKaOo
 Np+eD/9ot2VDHH1T5/ZWWXo2P2Tx98zvAKImSd2NXhdURQYDrzbKtxvi+4V7zFv61in9t5W05cO
 YJsEs6V/oWXrcaPyEDGI5mT5gDM5fAzuQkWcErRSQOXIMKNb6v/WTQVEieRpC6IAnOP1Idu2gey
 M/h2uUDFl6MoCizfdgPGlx2OcUQtMY3EUXgbgTOgihHAnOsQkx6ZqDt4VhQWbdWmSE3907CvYoj
 qhX6F1L4u6xIdpU7TDxnNwRwChi1e0m56qgFOO9dDNQwI/kPCIkeae3WW8FafFItMtanFAvvBbG
 xZ4F6WOx0Cu0aR9x1YmUl+AJ04KjpjvnM280BcrCQONNoeiJzu/72CHs/0jAjAM3B8oXBjGMMN7
 6Le0mxE366z7V3SLrXTn11sdKK4sZI6ajkjTom+cgNlbgiwWaFdRydfIJsyvOJujAnylydJBB0+
 IbWFy35mI7VGsQWra0Nl+dz/GJK5XC87IScH+O3b/T/+WS5sNTwRSGPsCljNhXId3IyveFq7nC6
 1h+rvOa0+99mFkJZVOCBQnUoEWs76Oey7fmRILDsdsmhmH1GJP9Da0sXNyAaFZR9L4O9pMG4YCQ
 kGU4gFVqfWDzVP/VPcRzRlY6/1zfFBY7b+sslZPGqqcSwP8V1QGSkiNoOC+OGNReoTNqqggpgao
 dHZQ+qrj5a4zeyw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3061

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


