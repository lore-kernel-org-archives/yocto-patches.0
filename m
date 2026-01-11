Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7947D2502E
	for <webhook@archiver.kernel.org>; Sun, 11 Jan 2026 19:07:17 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16444.1768158436006924040
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 Jan 2026 11:07:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=BEs3NtpO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-20260111190714d020a378b2000207ae-q_ktbj@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260111190714d020a378b2000207ae
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 11 Jan 2026 20:07:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=a+oWiCrwCdejyKRAHdm/vQil0g3fYztJ/7BGMWWTMbo=;
 b=BEs3NtpOqCJftYEx/0E6tZ4iFAzeV3nY7ANd5nNyFPHXuWurLp4qawdXRifIbd2AQOuGBy
 Tr0X8xLf9y1znkbKA9x9Jy0dg4TpKs50ip/hof9I461FMreG8O8DZgCVKgjUJ/6HzjfrQ7Jl
 hbWcpQR/A5ZCnlgkuqeWnYlM8BHqFct+Z8PO0QPTfu7kltW9KoCJmGNyFN3pWKD+p5DeIahs
 u6mRlaa128+BmSFq8NFXhoTAziZmKbDOtr7+Z814xPju97wVxHsb80hwBXE4LHcNUrKj0aJ6
 gauEmo/4rJkoSkRcp9myWRf2nndiQfofWkYsDYsnkNUcQqO8hgZ8/6LQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics-meta-oe][PATCH 2/3] patch-status: add whinlatter
Date: Sun, 11 Jan 2026 20:07:02 +0100
Message-Id: <20260111190703.13425-2-peter.marko@siemens.com>
In-Reply-To: <20260111190703.13425-1-peter.marko@siemens.com>
References: <20260111190703.13425-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 11 Jan 2026 19:07:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2938

From: Peter Marko <peter.marko@siemens.com>

See https://lists.yoctoproject.org/g/yocto-announce/message/366

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html   | 12 +++++++++++-
 patch-status/releases.csv |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index b6dc47e8..2119d9ec 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -58,6 +58,10 @@ SPDX-License-Identifier: MIT
         <summary>master</summary>
         <div id="cve_status_master"></div>
       </details>
+      <details>
+        <summary>whinlatter</summary>
+        <div id="cve_status_whinlatter"></div>
+      </details>
       <details>
         <summary>walnascar</summary>
         <div id="cve_status_walnascar"></div>
@@ -117,6 +121,12 @@ SPDX-License-Identifier: MIT
       createCVEList('cve_status_master', data);
    })
 
+   fetch('cve-status-whinlatter.txt')
+   .then(response => response.text())
+   .then(data => {
+       createCVEList('cve_status_whinlatter', data);
+   })
+
    fetch('cve-status-walnascar.txt')
    .then(response => response.text())
    .then(data => {
@@ -190,7 +200,7 @@ SPDX-License-Identifier: MIT
       sob: 'Malformed Signed-off-by',
       upstream_status: 'Malformed Upstream-Status'
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

