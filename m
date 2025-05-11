Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAEEC3ABC3
	for <webhook@archiver.kernel.org>; Sun, 11 May 2025 21:11:18 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.36442.1746997876491573154
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 May 2025 14:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=OtobqwtM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-2025051121111327c514fc625ea39b95-jtva4i@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025051121111327c514fc625ea39b95
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 11 May 2025 23:11:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=SsxxBfuR9k2TMMzXi2/pxRRXWXeSz33aGjYx14QIj5c=;
 b=OtobqwtMIUyMi/AjoLkPz4mGqIVXuh+84F72SGSB5eGng5qRA6fLnxiZhr2YPdyGma98ZK
 Yicpf81OkCiFMK9G01f6j1kyNauRgMUWb0RBpaOtdtaN0laWG5MqYBO2w4DUfvp9jNpdZfP6
 QV+uPBUYo4sZN92Z6iDEy1p6zKk/C9EXtlsX4yLOIksGmo/8blKJ8Nt2gqi3gEuQM8jy0/5t
 8dwjEtFF2CkizPowcM7NWijaxujUc8nguur8WhxXGOEHp/Xi70svkNDKZRBtXdY09R/5tfo4
 jwre+3UYQM7e1xBnzskHjdfQpW1XoamwYuM33tgGArpLXo05OAyMSnXw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics-meta-oe][PATCH] patch-status: add walnascar
Date: Sun, 11 May 2025 23:10:26 +0200
Message-Id: <20250511211026.3733893-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 11 May 2025 21:11:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1545

From: Peter Marko <peter.marko@siemens.com>

See https://lists.yoctoproject.org/g/yocto-announce/message/348

Also correct Styhead version.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html   | 12 +++++++++++-
 patch-status/releases.csv |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index fd4f0df..041c5d1 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -58,6 +58,10 @@ SPDX-License-Identifier: MIT
         <summary>master</summary>
         <div id="cve_status_master"></div>
       </details>
+      <details>
+        <summary>walnascar</summary>
+        <div id="cve_status_walnascar"></div>
+      </details>
       <details>
         <summary>styhead</summary>
         <div id="cve_status_styhead"></div>
@@ -117,6 +121,12 @@ SPDX-License-Identifier: MIT
       createCVEList('cve_status_master', data);
    })
 
+   fetch('cve-status-walnascar.txt')
+   .then(response => response.text())
+   .then(data => {
+       createCVEList('cve_status_walnascar', data);
+   })
+
    fetch('cve-status-styhead.txt')
    .then(response => response.text())
    .then(data => {
@@ -191,7 +201,7 @@ SPDX-License-Identifier: MIT
       sob: 'Malformed Signed-off-by',
       upstream_status: 'Malformed Upstream-Status'
     };
-    const branches = ['master', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
+    const branches = ['master', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
 
     const general_options = {
       tooltip: {
diff --git a/patch-status/releases.csv b/patch-status/releases.csv
index af8e192..91b94bd 100644
--- a/patch-status/releases.csv
+++ b/patch-status/releases.csv
@@ -1,5 +1,6 @@
 Name,Date
-4.1 (Styhead),2024-10-17
+5.2 (Walnascar),2025-05-08
+5.1 (Styhead),2024-10-17
 5.0 (Scarthgap),2024-04-30
 4.3 (Nanbield),2023-11-14
 4.2 (Mickledore),2023-05-03

