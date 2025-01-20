Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B72C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 20:14:17 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.164.1737404056638354765
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jan 2025 12:14:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=WD2qO7sf;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-256628-202501202014133fac0a3cab34762f12-urgz0m@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202501202014133fac0a3cab34762f12
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 20 Jan 2025 21:14:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ydDV9oX2zxHReVeZEIZYrYQnfWGV6ho93ziwzyT13ZI=;
 b=WD2qO7sf8QCT5djuA3+3AtjIYqQCV/psqq2yZ/lTXhRujXRDFYdbqfI0jDasJdh+6InFu/
 boha/A0ijVJ5rFn5/bVk9+77EYBPbr8tiXwLrMkoUCL4BCIK6rK/7pf1bCL7aKysNX/HV/ZU
 RcOR8ZLEQTy+tJNZkA2Gu19iWy4MZ5mh4GefNQX4/HE/1dgGoJCMopAmYFB+5IhMGvhD/L3m
 1zsRk3l0WURATunR8IlEEYvkKbRCOpVIwBeJD34FJ9h84WATAm/Q+ix7g4Mk9JJSAlqqtBN7
 nQ89QXGLvdAzL+P492Rg9b+mDX8PpwPEGJd3p6EQbKhTfGg5TsOVEM+w==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics-meta-oe][PATCH 1/3] patch-status: Add styhead
Date: Mon, 20 Jan 2025 21:13:20 +0100
Message-Id: <20250120201322.13262-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 20:14:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/993

From: Peter Marko <peter.marko@siemens.com>

Sync with what core shows.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 89ee66ae..7669ac5f 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -58,6 +58,10 @@ SPDX-License-Identifier: MIT
         <summary>master</summary>
         <div id="cve_status_master"></div>
       </details>
+      <details>
+        <summary>styhead</summary>
+        <div id="cve_status_styhead"></div>
+      </details>
       <details>
         <summary>scarthgap</summary>
         <div id="cve_status_scarthgap"></div>
@@ -117,6 +121,13 @@ SPDX-License-Identifier: MIT
       createCVEList('cve_status_master', data);
    })
 
+   fetch('cve-status-styhead.txt')
+   .then(response => response.text())
+   .then(data => {
+       createCVEList('cve_status_styhead', data);
+   })
+
+
    fetch('cve-status-scarthgap.txt')
    .then(response => response.text())
    .then(data => {
@@ -190,7 +201,7 @@ SPDX-License-Identifier: MIT
       sob: 'Malformed Signed-off-by',
       upstream_status: 'Malformed Upstream-Status'
     };
-    const branches = ['master', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
+    const branches = ['master', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
 
     const general_options = {
       tooltip: {
-- 
2.30.2


