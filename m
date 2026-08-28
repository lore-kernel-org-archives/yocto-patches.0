Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A82C61DD7
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 11:39:02 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4383.1787917141511407176
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 28 Aug 2026 04:39:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Kc7QgUNz;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D6EFE4E413D5
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:38:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD3CF60537
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:38:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EC0D611C781DA;
	Fri, 28 Aug 2026 13:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787917135; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RFG6Kbwgx3I55XtuPoQNaqU7I+AcXjYFjNF09SeaPkc=;
	b=Kc7QgUNzJPdK1m+NMUghWxkfxKO/PXsPu52Gdhxla84sdskabPJ1sc11NL7oXpm7ka1j6h
	mFiRlXgy8kVAbv3fNpX+sx5snu4Ru9dbyxp3Pw7ZIpAWCB2yy6s2aA+L2SQa84eY9/itox
	GGuwHVrfK16DCelBk0D+V9WUvvzAdOvN4eERCjvv3lnzu+YweVlm0rDMTL2EHOtGUaWn4w
	KQMr+nedY7/RfC4NjsPwAfEBpxf/D/qx8G+FJScdxuqkGnD74KmxE7T6YaLUSKA67hMBlu
	kS7soXXRAtZl247aO6hJ0YKP0Jy6CJRFTz5F3qiudHvEt9a6XK9ubbJelkcb9g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 28 Aug 2026 13:38:35 +0200
Subject: [yocto-autobuilder-helper][PATCH 2/4] scripts/run-docs-build: fix
 indentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-run-docs-build-tweaks-v1-2-24a7c832e352@bootlin.com>
References: <20260828-run-docs-build-tweaks-v1-0-24a7c832e352@bootlin.com>
In-Reply-To: <20260828-run-docs-build-tweaks-v1-0-24a7c832e352@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2989;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=aO4tescTlDTHatCs9V/z+aL1bdd3firB/LvJcRT6vvg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqkXNE/YGoROZmUYeXCPV0H+44KjTkcfbgGe/8l
 LckiEO2RbOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCapFzRAAKCRDRgEFAKaOo
 NlZkD/wNipmFRjOsOG/NHwf8Lrwhiae23JnkXe4wdnc6vsd6ZPN33JRyYUcUnmvza31rutN/UDx
 ElOftEqv0y5jJMJnj1eOSxBhBcxtppdQE3fyUUuMQ3DXrbDMZ7r7wmMwllmisXep4/LS32kM05c
 XnxUaBVTF9K23qhFx1vKfoM/8CMQuBMpjSUXUC6d4iyhuUk6eSyjj7hUmPb9Xdzw7sFA/UqegX3
 rfqVAPXBDKitQ0DlMv0BsDhUnfK7vUqCzm2Nj6k1ZgZbbeFn75WgZEa6r90wuef9MK65jO08pR0
 2foJW3yhjm0GI9kp7mBLCHIdz555ef1/chy7OqiB6wqC7GnkNXihVNPmCMU8b5CKnt0hmDhALJH
 IHLBiyqkDd1e5NQCPx2ogMI0tn2bujbCCuXJuMAdFL/KSdhK/Z96eOMuKW5gpZH3vq978GODr+3
 GO/Reee+nLxGr8l5WSAT/MLYV3vEEKgOFoeFNhtusSUQAP2cPdyh3jhXfn6gxgElMp53b992/kU
 gYDs+LkLXv2O0fw/zxiTm0qgp125+iqs1de10FiuoUsbOoL/tAWUqPSTRuxQ4y4VsLswmE6bkPA
 xTs5ppSo9rlol5pdCQBE/kFsjIm4palYLvCW5KtHxa4RUAhdG0Y1/iTfhACVbnk4gPBdRUn0B3U
 Erjv9MtIfdXlzTw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:39:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4716

Fix the indentation of the script to have indents as 4 spaces
consistently.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 6b6e5de..344acbf 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -113,9 +113,9 @@ first_sphinx_commit=84ccba0f4aff91528f764523fe1205a354c889ed
 
 latest_branch=$(./setversions.py --get-latest-branch 2>/dev/null)
 if ! echo "$latest_branch" | grep -qE "^[0-9]+\.[0-9]+$"; then
-  echo "Got unexpected branch from ./set_versions.py: $latest_branch"
-  echo "Should be in X.Y format"
-  exit 1
+    echo "Got unexpected branch from ./set_versions.py: $latest_branch"
+    echo "Should be in X.Y format"
+    exit 1
 fi
 
 for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)'); do
@@ -144,7 +144,7 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
 
     if [ "$branch" = "master-next" ]; then
         branch="next"
-	mkdir $outputdir/bitbake/$branch
+        mkdir $outputdir/bitbake/$branch
     elif [ "$branch" = "master" ]; then
         branch="dev"
         mkdir $outputdir/bitbake/$branch
@@ -153,7 +153,7 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
         mkdir $outputdir/bitbake/$latest_branch
         cp -r ./_build/final/* $outputdir/bitbake/$latest_branch
     else
-	mkdir $outputdir/bitbake/$branch
+        mkdir $outputdir/bitbake/$branch
     fi
 
     cp -r ./_build/final/* $outputdir/bitbake/$branch
@@ -203,7 +203,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
 
     # skip milestone tags
     if [[ $branch =~ yocto-.*_M[0-9] ]]; then
-      continue
+        continue
     fi
 
     echo Building $branch
@@ -221,7 +221,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
         cp poky.yaml poky.yaml.in
     fi
     if [ -f ref-manual/svg/releases.svg ]; then
-      git checkout origin/master ref-manual/svg/releases.svg
+        git checkout origin/master ref-manual/svg/releases.svg
     fi
 
     (
@@ -244,7 +244,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
 
     if [ "$branch" = "master-next" ]; then
         branch="next"
-	mkdir -p $outputdir/$branch
+        mkdir -p $outputdir/$branch
     elif [ "$branch" = "master" ]; then
         branch="dev"
         mkdir -p $outputdir/$branch
@@ -257,7 +257,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
     elif [ "$branch" = "transition" ]; then
         branch=""
     else
-	mkdir -p $outputdir/$branch
+        mkdir -p $outputdir/$branch
     fi
 
     cp -r ./_build/final/* $outputdir/$branch

-- 
2.55.0


