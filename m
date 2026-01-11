Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA704D2502D
	for <webhook@archiver.kernel.org>; Sun, 11 Jan 2026 19:07:17 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16336.1768158430977574715
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 Jan 2026 11:07:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=RE7R9qrs;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-202601111907087565b9f8e5000207ca-0srhmo@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202601111907087565b9f8e5000207ca
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 11 Jan 2026 20:07:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=TajXVfKO/FGtPIFc7J1C8DPt92tCrOgLtyEoUDWgJv0=;
 b=RE7R9qrsYd5nx6vxMTNdb5PBRSYDPoQkTgkagy8QNhGJ4FFrCApavtKx9CI9ml5uUh0bTd
 MBAQ3OUaT8D9TiyruurPKV0SZLxl98zEohyQ76+C2K/2Abrck8TNLLH4FqA644H6owMG38OB
 M4P8ox5kvemzbsN0d0+4YEu4zhrrZlog1IGLAbcn4jsWI3J1w9rnjil0ReE5x75MnazgEySS
 7GFeS9X2dDHKcFfZDgzjcLJ68qdX1FP9y37qDsUlvFJR8W31zPmQq+6bAaeyLYLHv1l3qE8U
 DgEQbGcJqxIpprTSbj9JmS79UUhYL2rZOP7KXEsD5kAYBbR324R2Vo2Q==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics-meta-oe][PATCH 1/3] patch-status: drop styhead
Date: Sun, 11 Jan 2026 20:07:01 +0100
Message-Id: <20260111190703.13425-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 11 Jan 2026 19:07:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2937

From: Peter Marko <peter.marko@siemens.com>

Metrics are no longer updated for this styhead, so drop current list of
its CVEs. Keep it in graphs as all other obsolete releases.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 041c5d19..b6dc47e8 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -62,10 +62,6 @@ SPDX-License-Identifier: MIT
         <summary>walnascar</summary>
         <div id="cve_status_walnascar"></div>
       </details>
-      <details>
-        <summary>styhead</summary>
-        <div id="cve_status_styhead"></div>
-      </details>
       <details>
         <summary>scarthgap</summary>
         <div id="cve_status_scarthgap"></div>
@@ -127,13 +123,6 @@ SPDX-License-Identifier: MIT
        createCVEList('cve_status_walnascar', data);
    })
 
-   fetch('cve-status-styhead.txt')
-   .then(response => response.text())
-   .then(data => {
-       createCVEList('cve_status_styhead', data);
-   })
-
-
    fetch('cve-status-scarthgap.txt')
    .then(response => response.text())
    .then(data => {

