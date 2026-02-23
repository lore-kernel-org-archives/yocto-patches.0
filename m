Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F4EC1107
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 16:34:06 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39441.1771864435760961844
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Feb 2026 08:33:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=B5ixjJ60;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7BDA8C63A11
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 16:34:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4EC3E5FD59
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 16:33:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A3D710368F42;
	Mon, 23 Feb 2026 17:33:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771864432; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=t+5f9wasWj9x/W64t8CtVZ32mEfZ4OrsrS10TiHCOQM=;
	b=B5ixjJ60Ho6yVS6h7Hrf/uLXQMSWeo9mRtw7FyxYWVAXz/+HSrCnHMI8w3Nuy/nln2HLjd
	J+FnvJ+8Z1pBP7+kUUoUhH0EFmgraPRtG+WbcQ+D/t8AKgU9vYBcdV2EyUjiRhf+mQ0WSS
	3kPlY1nselVHVEyjmR6OYdneHWVRU+0WbOH43/qbaaRfFGFvtnB6r3TznpI+G2r/h3D11D
	t4WlQs6GBmZi4lLyUug0/pis9KwRaIFi0MD89VEhugahGPPUsHvlbaWAwvnkTYjx37YRIv
	ZkhSyVA87pQ+Nw3jc1MpU7CzNsjpWTgmzlrwRgdJ0EgIEaf1til7aWsSpCO/0Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 23 Feb 2026 17:33:33 +0100
Subject: [PATCH yocto-autobuilder2] builders: Fix using a custom helper
 repository
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-mathieu-fix-custom-helper-git-v1-1-e277ffb9da3f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAFyBnGkC/x3MTQqDMBBA4avIrDuQjqGVXqV0kSZTM6CO5Ke0i
 Hc3uPzg8TbInIQzPLoNEn8liy4N10sHPrplZJTQDGToZoh6nF2JwhU/8kNfc9EZI08rJxyloLW
 uH9gEdx8stMeauIXn/wl/9UXR1aLvKlPgRPDa9wP6hbBYgwAAAA==
X-Change-ID: 20260223-mathieu-fix-custom-helper-git-44a38e0da784
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771864431; l=1848;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=n0WUaHKFxoBCKejplwbLZ0CkDp3wJbzkHl2Xt8ygjg8=;
 b=y7H96LzpTtIEVVcghjpqjculRcErTmNgAnwjR7Rik1c/2Z0hqaXZ2J5UKUXNUkqoKD9VzJxFc
 3Ylnsdb9/A4CxzEsuTNggHJ7vXogVUEkJlMxmxf9z2UgFHC6cJMaJdc
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 16:34:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3271

The URL in config.repos is not updated when a build is launched.
Instead, use the "repository" property, if defined.

Fixes [YOCTO #13979]

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builders.py b/builders.py
index b7379ece71f2..b6d72bc4dd58 100644
--- a/builders.py
+++ b/builders.py
@@ -113,7 +113,9 @@ def create_builder_factory():
         haltOnFailure=True,
         name="Clobber build dir"))
     f.addStep(steps.Git(
-        repourl=config.repos["yocto-autobuilder-helper"][0],
+        repourl=util.Interpolate("%(prop:repository:~%(kw:repository)s)s",
+                                 repository=config.repos["yocto-autobuilder-helper"][0]
+                                 ),
         branch=config.repos["yocto-autobuilder-helper"][1],
         workdir=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper"),
         mode='incremental',
@@ -300,7 +302,9 @@ def create_parent_builder_factory(buildername, waitname):
                     name="Clobber build dir"))
     # check out the source
     factory.addStep(steps.Git(
-        repourl=config.repos["yocto-autobuilder-helper"][0],
+        repourl=util.Interpolate("%(prop:repository:~%(kw:repository)s)s",
+                                 repository=config.repos["yocto-autobuilder-helper"][0]
+                                 ),
         branch=config.repos["yocto-autobuilder-helper"][1],
         workdir=util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper"),
         mode='incremental',

---
base-commit: b0ffe10a67f842fb56855719ff7650919cda564b
change-id: 20260223-mathieu-fix-custom-helper-git-44a38e0da784

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


