Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9041D2502D
	for <webhook@archiver.kernel.org>; Sun, 11 Jan 2026 19:05:27 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16414.1768158326597390255
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 Jan 2026 11:05:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=F3bKm7pk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-20260111190522c33659ad0f000207fa-cdzo1j@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260111190522c33659ad0f000207fa
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 11 Jan 2026 20:05:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=xmLDsdoyUUiuhRN87W2pigPeINeQzxq+VcpqTrgt+RE=;
 b=F3bKm7pkR5Pfc1Zf4sD/u4fjL6uTRik70KlQaDKgxpA+jqoATTeMm56Q5gUgGQx3Juyc2A
 JDUBhz+rMpav2eH+HV4zgSaoQuiD9ZAZlowNOwEk3cntoTgVxKQjhsgrVNvesKURTSx8UWFN
 6KyhUGL9k49+xRfOFk5lupnvr4WchZIrEArK2eX4yJRZUgyugQNhAsHUpw3jiQYgrdYgMGDu
 EInW6y0TQoiGEdfg07zpuim/PdSfMHT2QTcAu4bxnwguOVYzEPhB1G2BqXuVq9JN01BpkP98
 gYS7PrSbmswxbmPzYvilel3nVM8JWOtmtJ7wrDD/5U1ll81a9j7aAEZw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics][PATCH 1/2] patch-status: drop styhead
Date: Sun, 11 Jan 2026 20:05:14 +0100
Message-Id: <20260111190515.13188-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 11 Jan 2026 19:05:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2933

Metrics are no longer updated for this styhead, so drop current list of
its CVEs. Keep it in graphs as all other obsolete releases.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 9bdcd478..39c6f5a5 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -174,10 +174,6 @@ SPDX-License-Identifier: MIT
           <summary>walnascar</summary>
           <div id="cve_status_walnascar"></div>
         </details>
-        <details>
-          <summary>styhead</summary>
-          <div id="cve_status_styhead"></div>
-        </details>
         <details>
           <summary>scarthgap</summary>
           <div id="cve_status_scarthgap"></div>
@@ -375,13 +371,6 @@ SPDX-License-Identifier: MIT
         createCVEList('cve_status_walnascar', data);
       })
 
-    fetch('cve-status-styhead.txt')
-      .then(response => response.text())
-      .then(data => {
-        createCVEList('cve_status_styhead', data);
-      })
-
-
     fetch('cve-status-scarthgap.txt')
       .then(response => response.text())
       .then(data => {

