Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34CDCD37AC
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 20:00:47 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6061.1778702440766709936
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 May 2026 13:00:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=SN+2oVGu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-20260513200038f7de7d9d57000207ee-qpe1qk@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260513200038f7de7d9d57000207ee
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 13 May 2026 22:00:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=bWEYix8ylcuMQXyWyg2q0CGAU2pKeJUqai8AvRNP34M=;
 b=SN+2oVGuwXnSlTni3dNFvxtNBezxdJNDJg8ULDHRTKInXIMXv1P9R1S/7/HTjV/qh4a3c+
 6Tdyxl9Iovex9HOkwK8FcLKcOxDT+bgm1kZtzlz9RdXpt36Csqyz1R4Ez2ulXaWd9cD5FUqX
 HqUsNPszM6RebOSvYO3iWn9OqSoiYCPEWsMNgKakvMdGfoheLOcC8uJ0CUfylsjryoz1fUgG
 edT5a2eO/17S2koSSWDzrmrGD+bCi5o022zucij+NgKLwLQMFyC69wejDtSHljtq0luFgUfq
 1ngMR0mnTh1IjvGNpRn0qjJ43ZB5p+5ByOva+f73Aqmp596HbINKxiJg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics-meta-oe][PATCH] patch-status: add wrynose
Date: Wed, 13 May 2026 22:00:09 +0200
Message-ID: <20260513200009.2474228-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 May 2026 20:00:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3991

From: Peter Marko <peter.marko@siemens.com>

See https://lists.yoctoproject.org/g/yocto-announce/message/386

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html   | 12 +++++++++++-
 patch-status/releases.csv |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index cdd89e6e..c784151a 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -58,6 +58,10 @@ SPDX-License-Identifier: MIT
         <summary>master</summary>
         <div id="cve_status_master"></div>
       </details>
+      <details>
+        <summary>wrynose</summary>
+        <div id="cve_status_wrynose"></div>
+      </details>
       <details>
         <summary>whinlatter</summary>
         <div id="cve_status_whinlatter"></div>
@@ -125,6 +129,12 @@ SPDX-License-Identifier: MIT
       createCVEList('cve_status_master', data);
    })
 
+   fetch('cve-status-wrynose.txt')
+   .then(response => response.text())
+   .then(data => {
+       createCVEList('cve_status_wrynose', data);
+   })
+
    fetch('cve-status-whinlatter.txt')
    .then(response => response.text())
    .then(data => {
@@ -212,7 +222,7 @@ SPDX-License-Identifier: MIT
       upstream_status: 'Malformed Upstream-Status',
       inactive_upstream: 'Inactive-Upstream'
     };
-    const branches = ['master', 'whinlatter', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
+    const branches = ['master', 'wrynose', 'whinlatter', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
 
     const general_options = {
       tooltip: {
diff --git a/patch-status/releases.csv b/patch-status/releases.csv
index 1e8d95f3..48368ed5 100644
--- a/patch-status/releases.csv
+++ b/patch-status/releases.csv
@@ -1,4 +1,5 @@
 Name,Date
+6.0 (Wrynose),2026-05-13
 5.3 (Whinlatter),2025-12-16
 5.2 (Walnascar),2025-05-08
 5.1 (Styhead),2024-10-17

