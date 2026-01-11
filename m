Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF123D2502E
	for <webhook@archiver.kernel.org>; Sun, 11 Jan 2026 19:05:37 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16414.1768158326597390255
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 Jan 2026 11:05:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=dxcS7TBS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-202601111905277f2f74875800020700-qzo490@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202601111905277f2f74875800020700
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 11 Jan 2026 20:05:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NEE5rcnUTWfVFbn/yvf4fCBhpfiFOJQ/IM1CJkUjjlE=;
 b=dxcS7TBSzdZONe+eE7Rs+y2d2MftuKjNnLtY9Z/l3VLoNj9QKQqn9sa6Hth4hbNTN/5Pm7
 sAxoc8PlWdmOTys5W30OWj3dCOQTVSUi/2+ohrSMOUvh05x7/vY7dwYhne3axGABJ6gNtQdF
 uW48Qg82nO4euzGnzv7HXBnk5P6sV/3gZgsIpPmwnVdQi3SU08FEFXomh8mJ++UTRmLA40uQ
 fPFONNnv8iMNNohIwXtX9CRU153+QX5hI0F1RjgU9LOAQp0sbp4thJXm6s2Mq+9FSOmNsajD
 BypxrunZoJICUF0dc8za3r1CeVNgF+Th8HD/291FOkODxkl57iHxf3Og==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics][PATCH 2/2] patch-status: add whinlatter
Date: Sun, 11 Jan 2026 20:05:15 +0100
Message-Id: <20260111190515.13188-2-peter.marko@siemens.com>
In-Reply-To: <20260111190515.13188-1-peter.marko@siemens.com>
References: <20260111190515.13188-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 11 Jan 2026 19:05:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2934

See https://lists.yoctoproject.org/g/yocto-announce/message/366

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html   | 12 +++++++++++-
 patch-status/releases.csv |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 39c6f5a5..f0841c73 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -170,6 +170,10 @@ SPDX-License-Identifier: MIT
           <summary>master</summary>
           <div id="cve_status_master"></div>
         </details>
+        <details>
+          <summary>whinlatter</summary>
+          <div id="cve_status_whinlatter"></div>
+        </details>
         <details>
           <summary>walnascar</summary>
           <div id="cve_status_walnascar"></div>
@@ -365,6 +369,12 @@ SPDX-License-Identifier: MIT
         createCVEList('cve_status_master', data);
       })
 
+    fetch('cve-status-whinlatter.txt')
+      .then(response => response.text())
+      .then(data => {
+        createCVEList('cve_status_whinlatter', data);
+      })
+
     fetch('cve-status-walnascar.txt')
       .then(response => response.text())
       .then(data => {
@@ -440,7 +450,7 @@ SPDX-License-Identifier: MIT
       upstream_status: 'Malformed Upstream-Status',
       inactive_upstream: 'Inactive-Upstream'
     };
-    const branches = ['master', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
+    const branches = ['master', 'whinlatter', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
 
     const general_options = {
       tooltip: {
diff --git a/patch-status/releases.csv b/patch-status/releases.csv
index 91b94bd9..1e8d95f3 100644
--- a/patch-status/releases.csv
+++ b/patch-status/releases.csv
@@ -1,4 +1,5 @@
 Name,Date
+5.3 (Whinlatter),2025-12-16
 5.2 (Walnascar),2025-05-08
 5.1 (Styhead),2024-10-17
 5.0 (Scarthgap),2024-04-30

