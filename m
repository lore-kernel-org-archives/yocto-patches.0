Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85949FD7F9C
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 11:51:21 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.94129.1772193073811983393
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Feb 2026 03:51:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=TCVtgciG;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 82326C406A7
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 11:51:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A86915FE46
	for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 11:51:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D492A1036941A;
	Fri, 27 Feb 2026 12:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772193071; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2vDtHQ3b3a8XcpGGvVIENL+A63h5dC3wudK5CWMwy4A=;
	b=TCVtgciG0/W0jrv3aPIBLyYX2Nib73HUgsNPhb1M7SmmODSbT1CH9p6GNzCJvtGr1erFwI
	H6BTo3pf5+WypCJTBi///kf3BQ67zUV4Su2uWTD7ocdcAgy9kWW99biCgF2/ZOKG+VF34t
	mxLuetXFljmn4e07qyjb5otjuAxkp+Pz02koAsbKVjTw5ZyksXh9kjhKEs+xea8NxrduPV
	Lti52+9YFCmFH5VntMHyMO2OqrfdCK6OswH7vInN2zW6Wj5dYe0e3jgoNY5z+pyrAIe1eI
	V/2oPEnrKQ+x8PQYwlbw5KG6Wz+3Bnw7U5zg5gUbPVL7QgTp10Phc4EWQmByfA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 27 Feb 2026 12:51:03 +0100
Subject: [PATCH yocto-autobuilder-helper whinlatter] getproperties: Ignore
 meta-qcom for nightly-check-layer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-contrib-mathieu-fix-check-layer-nightly-qcom-v1-1-de7022338274@bootlin.com>
X-B4-Tracking: v=1; b=H4sIACaFoWkC/x2NQQ6CMBBFr0Jm7STYKIpXMS6GdqQTSwtlUAnh7
 jYuX/LffxvMnIVnuFUbZH7LLCkWOB4qsJ5izyiuMJjaNLUxF7QpapYOB1IvvOBTvmg92xcGWjl
 jlN5rWHGyacD2Smd3Ite0XQvlcsxc9v/cHdZkNSEtmrpFgiuu5zByrj5eYiBVzvDY9x8M/eBso
 wAAAA==
X-Change-ID: 20260227-contrib-mathieu-fix-check-layer-nightly-qcom-98a5d4ad69b9
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772193070; l=1340;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=n/f6d2gpSEk+eJD9fmFqgfvzOEr+QyhmP+5+Ytto5cU=;
 b=yMpP5JFbzLvcHeHXmYMVkFUHeBxWjcvFSTaXPcvfjirAniVlQ+f6p6y41EEbY4R5W9R+jKeqD
 Az+HlHu+U9tAfMkvQQ1U61tKOskhJYcfROqjBCwp+Mlil1wtgZDYicQ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Feb 2026 11:51:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3300

The repository was removed from NEEDREPOS on check-layer-nightly: it
will be missing in such builds and so should be ignored by
getproperties.py.

Fixes [YOCTO #16186]

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 scripts/getproperties.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 90ca1ef45d1d..0f2b59602462 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -56,7 +56,8 @@ for repo in sorted(repos.keys()):
     if not os.path.exists(layerpath):
         # layer may not be used by the build and hence not moved into final position
         layerpath = builddir + '/repos/' + repo
-    if not os.path.exists(layerpath) and repo in ['meta-security', 'meta-riscv']:
+    if not os.path.exists(layerpath) and repo in ['meta-security', 'meta-riscv',
+                                                  'meta-qcom']:
         # Repos is specified on the controller but not used in the helper config
         continue
     getrevs(jsonprops, layerpath, repo)

---
base-commit: dd90ba998f860ffe1941619f1cee98223ef7554d
change-id: 20260227-contrib-mathieu-fix-check-layer-nightly-qcom-98a5d4ad69b9

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


