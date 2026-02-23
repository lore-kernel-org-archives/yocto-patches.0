Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6196EA4FA9
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 11:03:34 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32896.1771844612508128705
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Feb 2026 03:03:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=U9siGw+F;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0879CC143C7
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9ADE5FD43
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 485D610368F7E;
	Mon, 23 Feb 2026 12:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771844610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CuuNpanEYjJYuoAz29oS8474lJyfTYYvlAB9PXJiQdI=;
	b=U9siGw+F2kbSfFldXTrZ/6+TvhNQSjK7Vgur53j1B5jPjoA5OYIDczDzHHQmE2K+3TL5b8
	z4ahhXsgxfceiKDX5yk5NcdXibAJ69Z8HS6n6hSEAnqXxq5opzsAFOb37utduzTNawmmvr
	OiO+Vj0TieLYlxDBWqnW7qtYfSJXJebJmDr4Scq63U8tEMRPTMRz0I84XDtgJlvZhg4JLJ
	WZ+OaPiUw2bjsBF2YH+dLpNduy3/93sm6sM8O/ICVjLHg/oes99e7VPNK98MoRIkIz2D4K
	pM1xvb83inQuZY79l1ktqPc8A7b8An11BSE4Q2HsY55sGQ0J3E5vK+o7kyE/6A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 23 Feb 2026 12:03:22 +0100
Subject: [yocto-autobuilder-helper][PATCH 3/4] scripts/run-docs-build: use
 git apply to apply patches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-fix-switchers-js-ydocs-v1-3-6f58a78ee8c3@bootlin.com>
References: <20260223-fix-switchers-js-ydocs-v1-0-6f58a78ee8c3@bootlin.com>
In-Reply-To: <20260223-fix-switchers-js-ydocs-v1-0-6f58a78ee8c3@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=953;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=HUB/CrgX0BZ0rYQ2nj4iiGkerpk8A+STYZzwmFCFcAU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpnDP/i9cLnbb2DGoLmYvN3lsC2XB1LC0WGG9we
 eFAUSWUPbOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZwz/wAKCRDRgEFAKaOo
 NiEGD/4x0U22crWnmJrLyzK8b0a9W8Fw1nQz6qcCbSIu1vn4GAi3oGzUk47dtGHjS2yuqhvKuM4
 iqEBGWNSyj0l7QtC24wDbWuZ2xEW52o+p++rb6FsYQ5iWBPszsChbjmc13G2gqxUUM9zzYk4CZL
 R70dTAN/Djp0NsxyiOVzyo6PPqmZQYqybzfqVOxYIp1O68DIarb1rIbvocs/GBCtcqBzP3DdHEE
 xbMv5FkFhJB1mVaK6d3+1OeP6rncgD+siESIQZGAzCD43oUCLzn26W5hGGMJ1ReISgTlD5WGIZo
 YtDUYjbDfkXXU7x2OkvPRe+NoRjrXNzwxNQlmOP4OiylOMiyyfwWT5FJxFK80h3WTMqDzaDTrgS
 2u7B7fYiY/UTYdUueyGxkbd59gbytXwDFeDOsVkCvUqj6XeQgdCNWXcAuGWdDTHIXwvMNvW/Bt3
 G1taUxKheuJE/e8ys4sYE7Oh6r5ij9eUjrUGBTZgnUBwJw0clsAfzcwSF7Wo6HqxfqTJTRJU1tc
 P8eRgXW2KE64zBqTvsOUSUsmakw/xSoDy3UPz1IwWiRL7j4dr0B/o/jJiMl8hT1p+WaxNPq4naV
 aULXFq7emIolTehkliIManyEiM0YDAtqm80XMRRicBFNM/JdsUVbuajfzbFk7WrW0HSsar6dg2D
 8Qh53OHjBOQV5dw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 11:03:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3266

Since we're now using set_versions.py from every tag, if we use git
am it creates a new commit and so we do not point on the tag anymore.
Use git apply instead so that our HEAD does not move.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 924b446..fed5e61 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -196,7 +196,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
 
     if [ -e "${scriptdir}/docs-build-patches/${branch}/" ]; then
         echo Adding patch for $branch
-        git am "${scriptdir}/docs-build-patches/${branch}/"000*
+        git apply -3 "${scriptdir}/docs-build-patches/${branch}/"000*
     fi
 
     git checkout origin/master sphinx-static/switchers.js.in set_versions.py

-- 
2.52.0


