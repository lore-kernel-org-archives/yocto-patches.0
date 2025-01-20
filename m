Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1717C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 20:14:27 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.173.1737404062186174032
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jan 2025 12:14:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=WThREapM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-202501202014195f04111dd7b8e721a6-cwawwn@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202501202014195f04111dd7b8e721a6
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 20 Jan 2025 21:14:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PIzLADnyDOwmfX+cXwsiwG/QrjR+ccTlpHUYfL1GpuY=;
 b=WThREapMqjKdczvgck5cv6vL7ybGPu0cpXjjEr4t8b9Rd2OuUhWFhovS7bIzmDch/lavRu
 NLn2XZUck7VmFSaJfKZUwou0q0MLcv6G5mkvYeEpWKQHezQJuQOA81NZ6iVGWyN9r4ts899b
 7+AgMMrPtZRNE34TcjynBO+NpGFNDC/3NHdlHwYZowxj+GwTVVITuwpVz0JvwVJMJdYmFIqu
 Uhs9FQ80PfJrEGOPpQV0tYk3u5nuiFk3k4BgH9xPBNT13w6em5D+3u9YhkXmhB1pD4D+eAp+
 5KWqODA4PAFy9zsX8PZktVdzS/VuMABDZwRbyaWiWtA7JL1OkmERHjzQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics-meta-oe][PATCH 2/3] patch-status: remove nanbield
Date: Mon, 20 Jan 2025 21:13:21 +0100
Message-Id: <20250120201322.13262-2-peter.marko@siemens.com>
In-Reply-To: <20250120201322.13262-1-peter.marko@siemens.com>
References: <20250120201322.13262-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 20:14:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/994

From: Peter Marko <peter.marko@siemens.com>

Sync with what core shows.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 7669ac5f..fd4f0df5 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -66,10 +66,6 @@ SPDX-License-Identifier: MIT
         <summary>scarthgap</summary>
         <div id="cve_status_scarthgap"></div>
       </details>
-      <details>
-        <summary>nanbield</summary>
-        <div id="cve_status_nanbield"></div>
-      </details>
       <details>
         <summary>kirkstone</summary>
         <div id="cve_status_kirkstone"></div>
@@ -134,12 +130,6 @@ SPDX-License-Identifier: MIT
        createCVEList('cve_status_scarthgap', data);
    })
 
-   fetch('cve-status-nanbield.txt')
-   .then(response => response.text())
-   .then(data => {
-       createCVEList('cve_status_nanbield', data);
-   })
-
    fetch('cve-status-kirkstone.txt')
    .then(response => response.text())
    .then(data => {
-- 
2.30.2


