Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A40ED72362
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 09:00:17 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.63626.1769158813436641161
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Jan 2026 01:00:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=FqH6Tctb;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F01AAC21ABE
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C66536070A
	for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EEBD5119A879D;
	Fri, 23 Jan 2026 10:00:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769158811; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KLoOaWTG84KH08GLnRoD6NTIqxspZnDdbpCUds4Ys8E=;
	b=FqH6TctbStA6cjIgSvHWf8DfBhMESbOtUdktarNXwwb9kqk+ohJg1lDIQcN8Iur5WbinzG
	+qBUrNDnJ7Jisn2dPmgEiGyB3mLA/m4NKSAmywqBvBdBDswrnO092A7o4iEcHHQq6zRZHl
	k6r/4ONDclF0DJfYWPJI2KikQRCnMQy1KzSJlkAt9kDyOtAUET1G+nye6N7PvfCigY2acP
	n9UmxsJ1hcf2sdZxy9eWjHyGsU5kyav2v9/sn0gZybAmhEv2fP26DGd/Ew5HrNYwqgGCAS
	F1FUWbXjuf71ZqNmYIK1cZUb2DbqmIWJR3DaZhSEiywhAYSgISnI9xofmDJEwA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 09:59:47 +0100
Subject: [yocto-autobuilder-helper][PATCH v2 4/9] config.json: indexing:
 add bitbake repository back
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-releases-parser-updates-v2-4-c24c30da807b@bootlin.com>
References: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
In-Reply-To: <20260123-releases-parser-updates-v2-0-c24c30da807b@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=865;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=hRzh/vMvBiLOIuCGzPo62JnbKWuLBAe0OTwGQGp/bRY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcziVIViYxQoihvKaNquewzcb8w49p/qFGqwr9
 O45vKN6to2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXM4lQAKCRDRgEFAKaOo
 NokoD/9kzRQtouTYe0LYV2UElK14OX4DuRnehhJ/afxiQDlPCzZX/cIX1n0YYU9yODDrzSQz99B
 n0yHwMZ7e7/qm6Xst9Ewxby/UAzZA3nv79wVEYiI2FlcmlatrpWJiHZkkZAhfOdSTCUQ4JEqVNY
 Kq0uFUryWRYr+3Jvtib2VGfnsx7HJ4dyAkNqRY9RBoavVHAjaY9lycQmMfFxIbWJoDMVk/zmDAF
 QDDErUsLXrcsOaWxkFnDzHUTc2hY6GMiLKgjjUlk3ykgXNQCpCz+m24gyDOLxdoNdNVOJuu9sB0
 +siZFaUlIxjueNpjLmJv41sQoY3Pww9cMQBdrYgcrDArpCS58K5SB2ZwM9o0QEhonV++6O+qyTi
 KXGbg6/AKDn4UwTBXWg9fJBjhkgumnVeDeGUkKyoiUAm+DddL4XeD+IxTtu/ZGmrK4S1ynBvnMP
 Cya26WVQtOkWqJsRtYnP8+Rtg9DXeL0ejqQc8xd+BOkH4kEsrkL768w3yioaI8UwVzi88QUNgbf
 4vqTthjg7rEeY/v57G1x7Gsk9AELk4KFYvkvnkXADNsDGMozAcFBByQBYwDHsz6MGzSTdTZtG5l
 BfLxgp7kLlA11nduvHy6AJh5H0VijGDeyuCptlMecYEDDBeycPRPFqngD0YDUgfzszUTHu/5/Fs
 IhLgOQd7nEfjweA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Jan 2026 09:00:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3059

The change in 2395b8974745 ("scripts/release-parser.py: use yocto-docs
instead of poky") replaces the previous definition of NEEDREPOS, and
does not append. Add bitbake back to the repositories to fix the
indexing builder.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 1dc7e94..4bfce70 100644
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

-- 
2.52.0


