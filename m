Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2023.1792708059711001375
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 15:27:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=gWBRzBTS;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-2026102222273741d418f2b2000207fc-_6pkwd@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2026102222273741d418f2b2000207fc
        for <yocto-patches@lists.yoctoproject.org>;
        Fri, 23 Oct 2026 00:27:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=QznjNVo9DVaE6v+bYAY0gcLrT93mtih84LA3qGgmzyA=;
 b=gWBRzBTSrlZeUecF6LiV03+P24PTlq5b31ivPm4VLYatqVxCaOHmuemkc8npJRzcMtoUwC
 Oq8+imu0E1XlVYiRM/V5qE9IF1+PrIOrpxp/8kqI/I3KpalJeElOrb3ZtxjtXdVyM6u4uXgl
 M1MFGRQXe3c0uRZSqQQJ9Cq605B9gJpZr6DeMlvcjcnEjDYUH/wBmGyYcVSXQnyUxgE6r8/S
 ACr8cSDgdqfkr5XM8ER06x4tLpLKWRba5RfFxF0fovGnTVxUtJaNWVFtUrPA05JN4BsNRQYy
 Q61bHL4gREAzsGSqU9oYBwnjMIRWyRhRz/0gmBb8iHLTkne2/KsDlWjg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics-meta-oe][PATCH] patch-status: add blacksail
Date: Fri, 23 Oct 2026 00:27:19 +0200
Message-ID: <20261022222719.3775554-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 22:27:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5141
Content-Type: text/plain; charset="utf-8"

From: Peter Marko <peter.marko@siemens.com>

See https://lists.yoctoproject.org/g/yocto-announce/message/397

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html   | 12 +++++++++++-
 patch-status/releases.csv |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index c784151a..dcab4abf 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -58,6 +58,10 @@ SPDX-License-Identifier: MIT
         <summary>master</summary>
         <div id="cve_status_master"></div>
       </details>
+      <details>
+        <summary>blacksail</summary>
+        <div id="cve_status_blacksail"></div>
+      </details>
       <details>
         <summary>wrynose</summary>
         <div id="cve_status_wrynose"></div>
@@ -129,6 +133,12 @@ SPDX-License-Identifier: MIT
       createCVEList('cve_status_master', data);
    })
 
+   fetch('cve-status-blacksail.txt')
+   .then(response => response.text())
+   .then(data => {
+       createCVEList('cve_status_blacksail', data);
+   })
+
    fetch('cve-status-wrynose.txt')
    .then(response => response.text())
    .then(data => {
@@ -222,7 +232,7 @@ SPDX-License-Identifier: MIT
       upstream_status: 'Malformed Upstream-Status',
       inactive_upstream: 'Inactive-Upstream'
     };
-    const branches = ['master', 'wrynose', 'whinlatter', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
+    const branches = ['master', 'blacksail', 'wrynose', 'whinlatter', 'walnascar', 'styhead', 'scarthgap', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
 
     const general_options = {
       tooltip: {
diff --git a/patch-status/releases.csv b/patch-status/releases.csv
index 48368ed5..324d4a0d 100644
--- a/patch-status/releases.csv
+++ b/patch-status/releases.csv
@@ -1,4 +1,5 @@
 Name,Date
+6.1 (Blacksail),2026-10-21
 6.0 (Wrynose),2026-05-13
 5.3 (Whinlatter),2025-12-16
 5.2 (Walnascar),2025-05-08
