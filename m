Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307D3D44C48
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 14:19:04 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36725.1768486735414593473
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 06:18:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=JMW1tjuH;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0BA6AC1F1ED
	for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:18:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BDB3F606B6
	for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:18:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A6C810B685B5;
	Thu, 15 Jan 2026 15:18:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768486733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Y+hh/DaJnLePQ4a3b6OJQkRyhPma6yT+IBMZOjjPopo=;
	b=JMW1tjuHyGnLUypYXzLoIQO5o5+k9f1F2GJNwwdIwOs5wejXLlB3Fg8oXzVjQX6iesTtc2
	fRHYej3x5K4qcOAWAIjqx0UqE5akK8rHkej2GVtNFiUyJo6oEhFE+gid74bkstSYFa+zjP
	2NQgWg4JFCTwBtISpcTfzng9ZLVaTDDBxTQRKJkGgZ3Xl8jNEl04+jU4UO1Eq/Ckwf+y/u
	YGIt7vULuLPngwjD2XPzTv0dUW7H6uO+OKhDTU/+73TXBMTUkWXgNwxGW9TvJjVJzRxJoM
	9PbfVkCbzrnTiC7z8AMEieB79YpGaBtwLzUHq+U/nI22Ou2gyGRp+IxYAuGg9A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 15 Jan 2026 15:18:47 +0100
Subject: [swat-tools][PATCH 1/2] swattool/review.py: show owner repartition
 in status bar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-status-bar-info-v1-1-1386e29bc87a@bootlin.com>
References: <20260115-status-bar-info-v1-0-1386e29bc87a@bootlin.com>
In-Reply-To: <20260115-status-bar-info-v1-0-1386e29bc87a@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Jv/hjUgOJudeAGpW6J1SdkrmQHKaeJhe6NxBL81l2nQ=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpaPdL5BHU1DbR6zdnk2YUb01qirrylLmES6HtK
 Z+W471I2i6JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaWj3SwAKCRDRgEFAKaOo
 NuGTD/9JFQbKx07i1MnI95sumDLYv6a4l5KPygveEJGtx//okRASqoXsSGPmBZWnX04F5YxauUD
 AsWhB4cdev3OXeus3FY7boZDVIKzbWdoBM5JbCxw9XGrIaOFJHMZTvWG3UhdyGq18PUrEnkMNHR
 0hjqqV5VC7JPi3ryPUSo1tDgOKZAT70nyaZsQzEk8epPAHy+CSuaxxdBrZbP6UU81yJ2bzAPKOj
 lw+L3gYl3iJdkD5r3NFsSiR/Ndrp7/C9kJJjM0d8LjHwkI7KZwdf5GF3BxEYb4h1oYhCvi5wDDF
 7xz1Y4vfZnqe0L++qy+iTztphevXvZGGuxzKjuNGsCt3JfZkGCI/naOkyJ2y5zwDNW8Fcj6lWfh
 Rmyc+XrQ+xrqCWWa6Vo8+WAYf6G5454KhjgqGxJEdmniJt8ibuenkFnZaI9PlWLgTN+MkzC78o3
 PfoumJUIwlER1os6Ytx+U0FJdxkNeqvsxcKPHhXidJuh7gKxxW/l2Jr0/XTEfwPUEKE5da+cbeJ
 d7Tvaq59mju24k3qPnlqHu4En+2EBTF0Nqe2VyZMYPEWhRYR/fJuEXceH+KssOeMtCC/5sBPNP6
 XoVMA+Pr1+RyX2YS1FePE+KVDiGbeaynouWF5n+KtPhpmMiu9dXmQGtUnLpKyv7f2kMzVArhUI4
 uQSYWuTiU65/0Yw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:19:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2964

Show the number of bugs per build owner when there's more than one
owner in the list of builds in the status bar, separated with a "|".

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 swattool/review.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/swattool/review.py b/swattool/review.py
index a9af008..16a9b0f 100644
--- a/swattool/review.py
+++ b/swattool/review.py
@@ -191,6 +191,22 @@ class ReviewMenu:  # pylint: disable=too-many-instance-attributes
 
         return [c for c in commands if c != ""]
 
+    def _get_status_bar(self) -> str:
+        status_bar = f"Progress: {self.entry + 1}/{len(self.builds)}"
+
+        owners = set([b.owner for b in self.builds])
+        if len(owners) > 1:
+            status_bar += " |"
+            for owner in owners:
+                count = len([b for b in self.builds if b.owner == owner])
+                if owner is None:
+                    owner = "nobody"
+                status_bar += f" {owner}: {count},"
+            # remove trailing comma
+            status_bar = status_bar[:-1]
+
+        return status_bar
+
     def _show_menu(
         self,
         commands: list[str],
@@ -198,7 +214,7 @@ class ReviewMenu:  # pylint: disable=too-many-instance-attributes
         status_bar: str = "",
     ) -> Optional[str]:
         if not status_bar:
-            status_bar = f"Progress: {self.entry + 1}/{len(self.builds)}"
+            status_bar = self._get_status_bar()
         action_menu = TerminalMenu(
             commands,
             title="Action",

-- 
2.52.0


