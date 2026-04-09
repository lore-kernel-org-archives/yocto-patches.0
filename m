Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6163F31E43
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 15:42:17 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.131407.1775739331523287013
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 05:55:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=rA/t3FJX;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 950261A31F7
	for <yocto-patches@lists.yoctoproject.org>; Thu,  9 Apr 2026 12:55:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 661AA5FDEB
	for <yocto-patches@lists.yoctoproject.org>; Thu,  9 Apr 2026 12:55:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36690104500B3;
	Thu,  9 Apr 2026 14:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775739328; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=CfpFvwxIsh8YIsPlQdgxlpqtQJjxx+oshPLAZT6H2ss=;
	b=rA/t3FJXWrTE2Nbi0TTwNRsb8C21oPuPjYabbjXJCmV3079CiuWupIyLQgIjTj5SJD0JA0
	PvjArVjxptS5dADOLsYYEiV0tZA0Vx0Cq/9UlUvV9TYkPHTYPC2o4DE9mwGaZD+BtU1qID
	Y+OTsvYkcaowboOQ/qJ6njqlH4VJqfi7XknzQtbQKM28ZnyU5hbyQxLpof/cMvoCGcaKyx
	1c9cCvVtStnLEZuUU213Jf6Stl0WjJXT84itlw4dypV/ztp7Q4ZOLploec0GfskKz3ayO7
	hfdK8JncN+pwT4nANjesr73LPFEsB0bM25OrCAjstODL3SZybeeiMQlA+aHQFA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 09 Apr 2026 14:55:18 +0200
Subject: [yocto-autobuilder-helper][PATCH] scripts/run-docs-build: skip
 milestone tags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-docs-skip-milestone-tags-v1-1-f78f1f9bdeed@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJbQhGr0JYlPYHRpGSTiEaw
 t1FXX6L9zZSJIHSrdgoYRWVOB04nwryg5t6sITDZI2tTGmuHKJX1ofM/JQRmuMEzq5XtvbiTFm
 hQhfoyOeETl6/dd38rUt7h8/fX/2OPkd2S47tImNA4gHjjNTQvn8Am7+255YAAAA=
X-Change-ID: 20260409-docs-skip-milestone-tags-227a046e6efd
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=999;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ir/yLZ+QRS7ElvGJYmhOAuU3sTR+EXquPU5IEZYvTFI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBp16G/A/8hRdhFOc0QQ4dQZEi5ect0/0QQa83fP
 RZz2PVrQ8GJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCadehvwAKCRDRgEFAKaOo
 NtsYD/9pGcYkVylcZl7U34Q20uNzt6zeFZ87tMvZDIOgHrHV+YMLFPpoC4KdPBxhHnBZxQfqNsY
 VYUYuMPjzFvbUljqBILTQ2i0KNQQN79pwkaSdUWypcMrjoszWbvnC15BcZ3SAFfgplOHjKlg4nC
 rE0B5xmspkS710w1c+mQuXaH9zoSXRHC0i6zd0x/PM0ZLbi0B4QxXSEZkUlaDMT8kj+z9JGU39S
 ctJ8v+atxtczg3Ats4J57r8AwCYZHMa+eLNKs9y5lnqi4qKC2cwXiThkbweJ5zDn4LztagmYO20
 pIN6lWnAgCsPTpwhOAjcs2k04veG913b/CeQETUm9F6b1Kuu9pbTh9T7o+YpsZJc7nEkN1Bym0z
 a9aSjxbsKhuJ6KYwgEkNx2tK147x8jPoUxyf4yNhc1owhS2qr4zLMswlyV6ayNv02VQJu+HA1iV
 bIHHllnmgUcaUSiZ0kh/hQKDLOhcpZYmY5wmQn2EhVpIFAgAeQDREWvz2hHs/8VlW5ngjg2Wbeh
 cr3WB/kbUUealxfJ0By2Q8ExLIEDRcs8R3m34wx2khOQH9TWLSjXD5G8SF0utcPcei3/98G0meT
 h/n6gkuE7/tpbfVxn3rosiSe45RwLCsv1s7Hak05J2CLx4HgvuI/nTr4qVLvAWUCV3+6w5ivKzf
 gNpyGTg6JI/aYjw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 15:42:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3678

Milestones tags in the form of "yocto-X.Y_MZ" were recently introduced
but we don't need to build them, and they're currently breaking the
build of the docs. Skip them when we match them.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
A fix to the docs is also planned to be sent for building on these tags.
---
 scripts/run-docs-build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index dfe3265..268ce73 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -196,6 +196,11 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
         continue
     fi
 
+    # skip milestone tags
+    if [[ $branch =~ yocto-.*_M[0-9] ]]; then
+      continue
+    fi
+
     echo Building $branch
     git checkout $branch
     git reset --hard

---
base-commit: 0742f9ec479b344a987e800dd0ca7e25850d7450
change-id: 20260409-docs-skip-milestone-tags-227a046e6efd


