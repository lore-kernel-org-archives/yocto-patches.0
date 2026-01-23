Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F035CD72359
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:00:16 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63624.1769158811245519878
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:00:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=DKGaSpxS;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 99FDF4E42217
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67B346070A
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C9D8119A879A;
	Fri, 23 Jan 2026 10:00:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=56JZZmhAh9J0EWeg0fbG6jEZD1KZnxaYRfMQ2LkEpJ0=;
	b=DKGaSpxSLtHrohjInsJRfcmSA+s98eDtC1o+eiAF/zVmtRhGgsetdb5tUonHYNU7jsz2Qs
	/wlArmVLd0fqyzdMnHEFYxbkkOt6IOEsoRKfo1BBTAcG6oc8LLz+Y9/+ZEH1pNkwqLFvvW
	wpsDxWrJL8DNItKkS8KsKP2X2dfvYNchbo8c4a3KmkA/4ts+HV/XaGC9D+ocQN8gGTiPzs
	vXP9Z/Ef4blTpdc3BpVFmPHU39+/VavOja0/so4HKiH6cwNOfSapLE9SHz89BcdZpHDViW
	3gmYfMx5mGD3KntCBh14nbWeruSzrBjHbqE/vxPx0oy1WGS/q+IS6mgCrW7VkQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 09:59:44 +0100
Subject: [yocto-autobuilder-helper][PATCH v2 1/9]
 scripts/release-parser.py: use yocto-docs instead of poky
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-releases-parser-updates-v2-1-c24c30da807b@bootlin.com>
References: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
In-Reply-To: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=v9UJvdoj8Zfg0uctMijqQf0VJf2y1Yb+dZXSywXaC+o=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcziVRGh38efUaYFnVTVd8RIeQTuzqo37OoreL
 /5FDkE7DTKJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXM4lQAKCRDRgEFAKaOo
 NhOgD/9bY0YYBXjgB0AKD/WSOPMhFGAqZnujzcqtNg7rvx62gAP3P6WuUZ0gibeqqMMdraEyl9g
 KIV/dht3UiN5ZN5KkcXYSce9N0uj1A5xiHhYE5tuGUooe/e/RWPQTVcgm7G9G9C3p8K/u/FuLON
 lUca3ybWyVch6Ku1O9Od2E3NE+V+1//VnjhrLes13Tc6mYU+vvpEkbDjGo39VBr6meMrTZJa8Tw
 Dly7LqDoWId+6QW6XPNj96utUxonYXGnViVXE7/g1kesDIEFr7qozLXrruMOZKI+cTDnEK5kQOJ
 y2K3InOnhvBIzYxGJUfeNf7UqrYSaV5X7/y7/8PbA1x2jM+O0mOMhm2Do/lxYqRDdLj2Y8bTqnQ
 MDGULF4+S+hTTwCQn1Pz6DfaW8NcHFqlIXnYHv8BP7EutCyPBULhCL6QGbU0aQLmyDNu79M2o64
 zaUAFsNtBLirlufqPMJEnGkfR0FrDy+11ndFKlTsAUbGdqHOZlo3TX7NA2nlczST2LA+l3c8hwQ
 kIbcVNR4pMX8Q9L2hXskQb8MTRbLPRHMQ27WuAKkCDs4eEsWYzfgy7fLKQTFrfx+qciFtAx6T9E
 SpI7enS9Iu6NyGoO82fdxbY0DcZC+6nLZ3qsuwVPlwiiHtpHGC0S7lwiIouQbctAzWXbK2WhKbp
 xJ+eSwpvVe066Pw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3055

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
index 4f6d305..1dc7e94 100644
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
2.52.0


