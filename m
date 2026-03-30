Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488351061B0A
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 15:12:21 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53979.1774883537796407542
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Mar 2026 08:12:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=puUv47W2;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BA96A1A308C
	for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 15:12:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 911B75FFA8
	for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 15:12:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44FA5104506C8;
	Mon, 30 Mar 2026 17:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774883535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ytM1k1jMyA9AX19G++zLWheImuOp/+UlSeJbmtKdNWI=;
	b=puUv47W2safMgCk658otPd3h10/zFW4kjgo935qcFLesrS7znpjXqko9dqfoJ/z5w1E9eh
	fTBE6oRu+upj7jndq0UmXnKfFo+XmwY5C3BiDWKbNkw9oBoaMas7K/RDj3OZhVxOs2txOF
	h33UHzDLvPnLbg5LCaPB35EFc4CEwROBuXFwIEEKyd59mIYan51XcRoFgktUjTw8p9er3L
	crHLX5vgQdhm7Fwch6OHCmTKCtGTFBPqmVvW56KDHPRQRWALWevsXfkM4QU7cQyBwHonx9
	X8jZPEzX8d3ATjLfE6T8XBM6NyEw5UadK0Y2q+72SwA5TLWWmedyXOmnBDIzXg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 30 Mar 2026 17:12:03 +0200
Subject: [yocto-autobuilder-helper][PATCH] scripts/run-docs-build: fix
 check on request branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-fix-docs-build-v1-1-1c3e962a4c13@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywqDMBAAf0X23IUYbQv9FfGQx6ZuESPZpLSI/
 95ojwMzs4FQYhJ4NBskerNwXCq0lwbcZJYnIfvKoJW+qa5TGPiDPjpBW3j22Grb34PRIVwN1Gh
 NVI1zOIx/lmJf5PJxGb7R5Yim5HjmlHCieaU0wr7/ACpasliMAAAA
X-Change-ID: 20260330-fix-docs-build-12b47fa2ff5a
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=t9MTn5uAxqPKuLxiFwE0quXjp7VZMm2TfGBspLQbeFQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpypLNp3HHfWzllVnnWtxh85LVjOWfoRUFlOVF1
 aasu9HO8ZeJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCacqSzQAKCRDRgEFAKaOo
 NkLjD/4+yMiN10TDOGxAHwV3ApKr0t6uZ4GuRhTePM1gmUBOW7ojVYNoJ/np57tjlSZ4qG9lEKA
 ol2AZuq9sm/et93rkRrfV3hR/PgLqYoos7T4DoPLBpsEWdyYI4uQMkm52stRLJSTrHTurKY16yS
 IVCMxu/ROrXcZ7sau436cuqViLWZYNFb+0qS1CJyuLsx6YWnEz9NFv+6gQqOnkPKAJe4XKQV/gH
 /VJ2S/lyLRqxTBs7Nd0rge8Kww/rT51asvvLvL87v2BT5fG23DitKVFhl+33TQRr564Ha5U7KW9
 ksOJKvs4QkUQqNtW13QAYVKD8M785fMXvMN/eRV8KMSDPLnmfFvAunq+pFXCGv/Xyisx/xB4N9G
 fJ4dfTFpOi5AVfc0vqTNO/1CS0FnJB/edyX5ThQNuSc+pmguWAHWx+B2FWvQnhR+iRRGHoVR6bF
 g7tkjwL2w7q3UG45CUQNlFL40lqoWZmokmm8gh586tqtGFUzoo3z39tawxs81wOI4I+yrQIuMih
 gPlebQ6LZvkH35kwJysoRcsF3nXVvazD+e3iecAv2VLaY5+AYhpOZdZJN3AnkjH40IfPWuVEr+j
 kwGUsdwQjQMfJOFYYoH3ZPdXUA7kFinD8wqGqNuNoRyVnkrevCmG1nrlw4Xbnu3clfe1Wb9IYeF
 CJK1eJoBSwnsuFg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 15:12:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3586

Fix the check on the request branch to be more precise, as for example
ypdocsbranch equal to "master" could make branches such as
"contrib/name/master-next" be built.

This was causing some of the contrib/ branches to be matched with their
closest branch (as per our algorithm to determine a version number in
set_versions.py), laverne, which in turns does not have a
bitbake_mapping and made our build fail.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Also I'm guessing we are seeing this now as some tags have been removed
and some branches created and this changed the list of closest matches,
producing the failure. Only a guess though.
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 3271328..dfe3265 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -192,7 +192,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
     fi
     # Do not build contrib/ branches as they are development branches only
     # Do build request branch though!
-    if echo "$branch" | grep -v "$ypdocsbranch" | grep -q -E "^contrib/"; then
+    if echo "$branch" | grep -v "^$ypdocsbranch$" | grep -q -E "^contrib/"; then
         continue
     fi
 

---
base-commit: 7e475b822d164e02f03a60cf4e02f0db0c4d086e
change-id: 20260330-fix-docs-build-12b47fa2ff5a


