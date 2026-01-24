Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5282D715F3
	for <webhook@archiver.kernel.org>; Sat, 24 Jan 2026 19:56:37 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26011.1769284593898804068
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Jan 2026 11:56:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=TpUMzO8s;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-256628-202601241956315b3928f67f00020726-yvsbsp@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202601241956315b3928f67f00020726
        for <yocto-patches@lists.yoctoproject.org>;
        Sat, 24 Jan 2026 20:56:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XAmL3Ef5pnXuRMj06tLt0NmCU+ZkG4hb1mBT7C6BXDs=;
 b=TpUMzO8sMNJXwuDvGSvAJLTUX5C0DumA1p25It02ZKd3mzHtNoG9hWKGjo+BRquuT+18ye
 zObDAWl8N/NThUdC4Fq4+7A76a3IPdT41OtN8IxIO9cMWyznKwc3LOq88HA4cPpfR/qfbSvs
 dI50vd1eD9zxMuouA95aC6DEHuKWHV6CKtYGpo++hDUTDuWzqjm4zFWnhZXY4+RVddSNYMOf
 pMRO3ZVYj9bS6IMsePihI4+FS9zYUbrV62gRh+ldG2IXf/g7a9rtwtyU8hnstpkRNM7fWY6X
 Anl5Y7aAKG1XmxHyeYJolxlU73Hc0qk34OpycjQk7nk4pzSOV8fkbkjg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics-meta-oe][PATCH 2/2] patch-status: remove accepted, add inactive-upstream
Date: Sat, 24 Jan 2026 20:56:25 +0100
Message-Id: <20260124195625.1874765-2-peter.marko@siemens.com>
In-Reply-To: <20260124195625.1874765-1-peter.marko@siemens.com>
References: <20260124195625.1874765-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 24 Jan 2026 19:56:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3072

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
index de09770a..071bb1b7 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -209,7 +209,8 @@ SPDX-License-Identifier: MIT
       denied: 'Denied',
       total: 'Total',
       sob: 'Malformed Signed-off-by',
-      upstream_status: 'Malformed Upstream-Status'
+      upstream_status: 'Malformed Upstream-Status',
+      inactive_upstream: 'Inactive-Upstream'
     };
     const branches = ['master', 'whinlatter', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
 
@@ -296,9 +297,9 @@ SPDX-License-Identifier: MIT
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
 
@@ -396,9 +397,9 @@ SPDX-License-Identifier: MIT
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

