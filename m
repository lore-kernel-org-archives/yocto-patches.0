Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3BDC02182
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 20:11:08 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.101.1737403863973018322
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jan 2025 12:11:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=ENz7kvVW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-256628-20250120201102268503b8ed21619bb1-ld9mku@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20250120201102268503b8ed21619bb1
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 20 Jan 2025 21:11:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=zBw94/5Rf7aEO1qG4vqKrIyf665v9iLkOxekQrJ5Gac=;
 b=ENz7kvVWcuBnqwC3E+VBuRveswoaMrN66UVAbMnb4sLAGrX6CBYsU6YH/OT2L1b22bQ9A7
 ErjAjaWmrBkFgkOIQvoCMd33D3t2Vi5x/J4dXR6oa5CJDklhtu/LwiOsMagIw8XSTOiEnEUr
 RpOg+FEBDFfW7RB6ORxPnj1yp3NUhARsjy6xx7nzXU4WVjKtNtHLD61S1X8APUPOUfiJuxgf
 kHDUOFSgIvlnvaRKODPEHZ+W35Jniz4DyusqiY2qnU0b+NqMlPno4ucvqcgI9n9soGcP6FJV
 TOl6WTy5tO0Sb5XoXrGATWHdTCLJn3QkP6v+MYurSCt54CaFbY/llrtg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics][PATCH 2/2] releases: add styhead
Date: Mon, 20 Jan 2025 21:10:01 +0100
Message-Id: <20250120201001.13117-2-peter.marko@siemens.com>
In-Reply-To: <20250120201001.13117-1-peter.marko@siemens.com>
References: <20250120201001.13117-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 20:11:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/992

From: Peter Marko <peter.marko@siemens.com>

https://lists.yoctoproject.org/g/yocto-announce/message/327

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/releases.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/patch-status/releases.csv b/patch-status/releases.csv
index 13cb8d2f..af8e1925 100644
--- a/patch-status/releases.csv
+++ b/patch-status/releases.csv
@@ -1,4 +1,5 @@
 Name,Date
+4.1 (Styhead),2024-10-17
 5.0 (Scarthgap),2024-04-30
 4.3 (Nanbield),2023-11-14
 4.2 (Mickledore),2023-05-03
-- 
2.30.2


