Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1940.1792708057627374415
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 15:27:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=dvfdhNG7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-202610222227352cfd1fc58800020765-wrv3wg@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202610222227352cfd1fc58800020765
        for <yocto-patches@lists.yoctoproject.org>;
        Fri, 23 Oct 2026 00:27:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/eRMJ26Fj5gQg26Il2tmvclfCV52ydgjJejBGCE8uWY=;
 b=dvfdhNG7lSAp+HSbQtqe/iF7rqa8faHJQmipRlRlCRtxcZopPaHXAm5DjrigKlksztstv5
 xCKnpkjgmwCo5dqXFVUmWyKQe+PK1dCs5D4prgImgq/e1/1SGPkIE+nfIUctuqDbzEBbxdrR
 Assvzar7UCtD0Y/IKfABxm3bcJ70ECXQ90crVcFdgypBf3vnYGixaHEDJcR4Q8H7/qKNooLr
 YbJZUG6QgABzO96b5K51K+5tNCpzWXOPxv2dxQMxNynEVl40AjFlGsnHTK2S9rxaNKMzvj2I
 MZdI39NprJwQA3TrYUWPir1Vghz6oGE9idSYKvQ1zlYktSyLevrQ4rcA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics][PATCH] patch-status: add blacksail
Date: Fri, 23 Oct 2026 00:27:15 +0200
Message-ID: <20261022222715.3775519-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 22:27:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5140
Content-Type: text/plain; charset="utf-8"

From: Peter Marko <peter.marko@siemens.com>

See https://lists.yoctoproject.org/g/yocto-announce/message/397

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html   | 12 +++++++++++-
 patch-status/releases.csv |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 9d0ebac6..ef5c009d 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -170,6 +170,10 @@ SPDX-License-Identifier: MIT
           <summary>master</summary>
           <div id="cve_status_master"></div>
         </details>
+        <details>
+          <summary>blacksail</summary>
+          <div id="cve_status_blacksail"></div>
+        </details>
         <details>
           <summary>wrynose</summary>
           <div id="cve_status_wrynose"></div>
@@ -377,6 +381,12 @@ SPDX-License-Identifier: MIT
         createCVEList('cve_status_master', data);
       })
 
+    fetch('cve-status-blacksail.txt')
+      .then(response => response.text())
+      .then(data => {
+        createCVEList('cve_status_blacksail', data);
+      })
+
     fetch('cve-status-wrynose.txt')
       .then(response => response.text())
       .then(data => {
@@ -471,7 +481,7 @@ SPDX-License-Identifier: MIT
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
