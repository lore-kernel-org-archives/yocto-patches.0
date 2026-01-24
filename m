Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD552D715EE
	for <webhook@archiver.kernel.org>; Sat, 24 Jan 2026 19:56:27 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26005.1769284579757365708
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Jan 2026 11:56:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=eCVLXr9T;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-2026012419561628e4e99691000207ee-nftiwj@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026012419561628e4e99691000207ee
        for <yocto-patches@lists.yoctoproject.org>;
        Sat, 24 Jan 2026 20:56:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Xn3fEVfVd6McfBdeIWkMm0UA/kdcd+xLlL8utA/cq0g=;
 b=eCVLXr9Tp/4shMGnvchc9GSoIh1UL+IAt6NaQOVysvqnsz/lOOnobKzh9TQPdI2ZHByvks
 KPFlMMSZaP/dbLl6C9P9ILDCFqHl7CpfBCaheA/2m3XbZEJciMhgJeppU3jh2WyctFg0MiOd
 rQkZ9op+YjxzeMICNo/HT0vrSXlX53DTmZ0r4ukKOqMCsKoterl6MPOdultECpVx+WbSfPGh
 jsfXQ6jJJikZjspSLZ7EGZLe1xp0RTEcVEtBlkRvYhkXFI/XP2lFDfBf5dKxii7cIVLWHLW3
 TACC/6HDm1fvSThiBElh32FSMGn1AFuTsZHcvI8STPfQbWdYnjFPVYxA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics][PATCH] patch-status: add whinlatter
Date: Sat, 24 Jan 2026 20:56:14 +0100
Message-Id: <20260124195614.1874743-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 24 Jan 2026 19:56:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3070

From: Peter Marko <peter.marko@siemens.com>

See https://lists.yoctoproject.org/g/yocto-announce/message/366

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html   | 12 +++++++++++-
 patch-status/releases.csv |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 9bdcd478..dd407502 100644
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
@@ -369,6 +373,12 @@ SPDX-License-Identifier: MIT
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
@@ -451,7 +461,7 @@ SPDX-License-Identifier: MIT
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

