Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EA2D7879F
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 16:13:30 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20261.1766160809222487627
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Dec 2025 08:13:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=M9Dvy7GO;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1041C1A22EF
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 16:13:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D4C3E6071D
	for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 16:13:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 70D7110AA9535;
	Fri, 19 Dec 2025 17:13:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766160806; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=dO4gN13EqYlx/GjXvqgDzw0189X2n/NtWc420+u3U0E=;
	b=M9Dvy7GONb1JSP4jEivVHsF7U3zP1tWZLe4NLm1S87L4+d1l8AWZw//Arkfh1xP0uJF1kD
	09Ye7LHmox9cgukjoQb77DbL5Xgr6oAMhK59v7f3G9ZkE+xsHPHgiRzkJYAS5XshcVEyVG
	hm2gFFH9DpsN7hP2qA5fJBYHINE8VSTKlnhfVXBGcXWuLBHr+sC/92AnADRfRWhOhjIqTB
	1FHqrBO61bd1HC1BgYAuHnDaBeIe4fVqDLShNNH7QbPErUCR3HG/NPSU/+WtH/wb4WlguA
	GV/355Sw6y/9XezM9+R9C88MgMLq48j8ZDhinLVKT6wP2qqpHt9KG66Y1KxBow==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 19 Dec 2025 17:13:21 +0100
Subject: [yocto-autobuilder-helper][PATCH] config.json: indexing: add
 bitbake repository back
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-fix-indexing-job-v1-1-78c3c87201c4@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKF5RWkC/yXMywqDMBSE4VeRs+6BJCDUvoq4MHGqRySRXIpFf
 Pem7fKDmf+khChI9GhOinhJkuAr9K0ht4x+BstUTUaZVhvd8VMOFj/hED/zGiyjdVYp3OE6S/W
 2R9TNL9kPf6diV7j87fTv4HLgseRgi2wTIi/YdsSBrusDHAUpJo4AAAA=
X-Change-ID: 20251219-fix-indexing-job-e5cb00e8ec9b
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=963;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=EL5kVsux8pJWfgu9ctFO/ErAGEpVPtuIVvSDh4LYrA4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpRXmkcvxUjChKgpk1FiMYXALu5ITJrEcDcwid5
 PmHvZr7PwaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUV5pAAKCRDRgEFAKaOo
 NqfmD/4upQZmacDQWr3fbvlyRadBtXXemL56ue4/PEfLx79JGKBpApVSyeEp/AF2bQYL09E4dvP
 gM2/CycBZ4yGz1Ta2i9PBixSAHTgVTw8qY8XZcrOc5ZEqfhGzUxZ3JSG5OVv6CvAoJIuBtoBq/p
 lMSs0iV39bTVmgXXnRCoUQyc2nvV6w9CAt8iRRoHouemCaeK8Aj285K0VcbLo/vygFf0KKN/yMB
 AJAW1EKHDVSOSte9LQjFlhtYu45dhdTuA9qw8QJy52caujwpI3wtCnxrBGGgRK2ehmXjulB9hKO
 tFMXDRntHYPhHo9wxa4oDDgzhCrOVlQJxycTXuvZXu4KU2OryJA+yDJeICiCICkdIqm0LuJPInx
 y+P5XbxdikipzkNmbhW1oqf7pOfGgVkO+TWW2Q2oy38moisy0PcZJtwzoe2qWKGygFyN44cdvv9
 CmR7FKxg7QJTd40ZASZM555bTJdaxvLN+dowxYnu8WioA6Qd+Xk0k1hHtOyYGF1aOnSkyxthF8V
 K+5mZfIAIy6V8aubRUhEv5AuWc0nmp1/AGWx8V/8pUygHl7HExRLRfGEqRfZ7wYGN4OMwDSNDGM
 T3otm3xMN3lUZYHq8VZzFv7Yy5Img0nmZTGQdDhvDB2bvDaAbL1WG1Fh8LPZ6fYestDheAxNsby
 eHRf54//4rsKdXg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 16:13:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2836

The change in 2395b8974745 ("scripts/release-parser.py: use yocto-docs
instead of poky") replaces the previous definition of NEEDREPOS, and
does not append. Add bitbake back to the repositories to fix the
indexing builder.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index be65d24..3415b1a 100644
--- a/config.json
+++ b/config.json
@@ -1402,7 +1402,7 @@
             }
         },
         "indexing" : {
-            "NEEDREPOS": ["yocto-docs"],
+            "NEEDREPOS": ["bitbake", "yocto-docs"],
             "step1" : {
                 "shortname" : "Generate non-release index",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/generate-testresult-index.py ${BASE_SHAREDDIR}/pub/non-release/"]

---
base-commit: 4e37ec5c3097bc73a4b26c2a8f6002e1e923d3e6
change-id: 20251219-fix-indexing-job-e5cb00e8ec9b


