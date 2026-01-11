Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F5D2502E
	for <webhook@archiver.kernel.org>; Sun, 11 Jan 2026 19:07:27 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16339.1768158441857340908
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 Jan 2026 11:07:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=PP1NNN4H;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-2026011119072059d7cdd612000207ac-9uxsze@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026011119072059d7cdd612000207ac
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 11 Jan 2026 20:07:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kJ0VyPCWfXTi8TeuuaZZiTc14YoCD1QPANeUD4PaSg8=;
 b=PP1NNN4H1YxbmMHu0RnmKOI9Bs3dR2NpmxY7/EJPlmkm+wAWlkt+k6hPmC5cmsVgDEwnBD
 sSriWe/b0G7UOpljHR9LXNh3n/LMhNQfkzLoxhx+B4kE5sl0OQ21uEPNHCAOu6jqAw1WPEfN
 WJwv30g7rTKHX7cweLB43khRTqyy5CTdlBfQ1qsxmJzWjP4uIwIaRtB0FdN65XNVXgnmTmjz
 alghi6TSJBje5H0Dly5IJlWDszGOaknx0kvk+1Q5s2F1GwTVTRDO8gKtQ3YYxVu33g95Ucql
 ZKE3pd9oCW3H7q7pmnEjUzZX8RdkAC1NU55PzSvvGOjcKJE7AFnwsJNg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics-meta-oe][PATCH 3/3] patch-status: remove accepted, add inactive-upstream
Date: Sun, 11 Jan 2026 20:07:03 +0100
Message-Id: <20260111190703.13425-3-peter.marko@siemens.com>
In-Reply-To: <20260111190703.13425-1-peter.marko@siemens.com>
References: <20260111190703.13425-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 11 Jan 2026 19:07:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2939

From: Peter Marko <peter.marko@siemens.com>

This corresponds to oe-core changes:
* https://git.yoctoproject.org/yocto-metrics/commit/?id=416a3a4af0129b53a62bd550d170c53d1b187bb1
* https://git.yoctoproject.org/yocto-metrics/commit/?id=312e8f1203b9882dc463c385a337c1b2f40c83de

Value of 'accepted' is 0.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 2119d9ec..ddcaf655 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -198,7 +198,8 @@ SPDX-License-Identifier: MIT
       denied: 'Denied',
       total: 'Total',
       sob: 'Malformed Signed-off-by',
-      upstream_status: 'Malformed Upstream-Status'
+      upstream_status: 'Malformed Upstream-Status',
+      inactive_upstream: 'Inactive-Upstream'
     };
     const branches = ['master', 'whinlatter', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
 
@@ -285,9 +286,9 @@ SPDX-License-Identifier: MIT
                 pending: status.pending || 0,
                 backport: status.backport || 0,
                 inappropriate: status.inappropriate || 0,
-                accepted: status.accepted || 0,
                 submitted: status.submitted || 0,
-                denied: status.denied || 0
+                denied: status.denied || 0,
+                inactive_upstream: status['inactive-upstream'] || 0
               }
             })
 
@@ -385,9 +386,9 @@ SPDX-License-Identifier: MIT
           { "value": data.pending || 0, "name": "Pending" },
           { "value": data.backport || 0, "name": "Backport" },
           { "value": data.inappropriate || 0, "name": "Inappropriate" },
-          { "value": data.accepted || 0, "name": "Accepted" },
           { "value": data.submitted || 0, "name": "Submitted" },
-          { "value": data.denied || 0, "name": "Denied" }
+          { "value": data.denied || 0, "name": "Denied" },
+          { "value": data['inactive-upstream'] || 0, "name": "Inactive-Upstream" }
         ]
         generatePieChart(formatted)
       });

