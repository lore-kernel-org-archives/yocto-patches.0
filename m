Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4519FC3ABC3
	for <webhook@archiver.kernel.org>; Sun, 11 May 2025 21:05:28 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.36391.1746997525992078637
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 May 2025 14:05:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=Ke1xq7tX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-20250511210522070bcf33c8b1922e78-33arka@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250511210522070bcf33c8b1922e78
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 11 May 2025 23:05:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=C6ggp1HJuRxYOVKrd6TvBZsI+Q7aqfpNCzemRaIcfU4=;
 b=Ke1xq7tXUDXGy4DQR2q9U765xmI5HZW85MzC2d776+uWIF2ax9coyt83rFpe3X/9Z2nv1a
 x12s16ajr5F+F/dqvnk1pcUlnYFWUggEadvRyYaIF+9fPJnoCO0YsM6yrA0JOxcVuY0aGedT
 PS0UtMITyB4Wnn5X8A8LzrrzZssYmP8HX5pnXMUJ/hdSJ3G22KsTZxz2rLNFGzpxxVnVIANF
 1O7MBvARxbYc4fm9a/UIx50590vkj0yYrTE84IMuR11gDGMpx11u+MTgrpOiVP0TJUvRIt3L
 SIAN4QWsvHkpLZ1jw6UD+8NDQlC6dFoApSeZyNFhqgWdkRN3EBgvZIPA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics][PATCH] patch-status: add walnascar
Date: Sun, 11 May 2025 23:04:24 +0200
Message-Id: <20250511210424.3733369-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 11 May 2025 21:05:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1544

From: Peter Marko <peter.marko@siemens.com>

See https://lists.yoctoproject.org/g/yocto-announce/message/348

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html   | 12 +++++++++++-
 patch-status/releases.csv |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 28ca07df..9bdcd478 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -170,6 +170,10 @@ SPDX-License-Identifier: MIT
           <summary>master</summary>
           <div id="cve_status_master"></div>
         </details>
+        <details>
+          <summary>walnascar</summary>
+          <div id="cve_status_walnascar"></div>
+        </details>
         <details>
           <summary>styhead</summary>
           <div id="cve_status_styhead"></div>
@@ -365,6 +369,12 @@ SPDX-License-Identifier: MIT
         createCVEList('cve_status_master', data);
       })
 
+    fetch('cve-status-walnascar.txt')
+      .then(response => response.text())
+      .then(data => {
+        createCVEList('cve_status_walnascar', data);
+      })
+
     fetch('cve-status-styhead.txt')
       .then(response => response.text())
       .then(data => {
@@ -441,7 +451,7 @@ SPDX-License-Identifier: MIT
       upstream_status: 'Malformed Upstream-Status',
       inactive_upstream: 'Inactive-Upstream'
     };
-    const branches = ['master', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
+    const branches = ['master', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
 
     const general_options = {
       tooltip: {
diff --git a/patch-status/releases.csv b/patch-status/releases.csv
index 4bb33da6..91b94bd9 100644
--- a/patch-status/releases.csv
+++ b/patch-status/releases.csv
@@ -1,4 +1,5 @@
 Name,Date
+5.2 (Walnascar),2025-05-08
 5.1 (Styhead),2024-10-17
 5.0 (Scarthgap),2024-04-30
 4.3 (Nanbield),2023-11-14

