Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54F1D2502D
	for <webhook@archiver.kernel.org>; Sun, 11 Jan 2026 19:06:57 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16324.1768158410405422040
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 Jan 2026 11:06:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=Nr/diw3B;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-20260111190648fcf3e0a0f0000207e5-_0s0jy@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260111190648fcf3e0a0f0000207e5
        for <yocto-patches@lists.yoctoproject.org>;
        Sun, 11 Jan 2026 20:06:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3wJguOzDcbe5836cuf1i9Wz6jvofIp2puQ99KJ4bQW4=;
 b=Nr/diw3BKgMNlJ1TDmEaA6A5a+voG8csVESJTD7XUeqDHNC8BzrIqXvPAwJUNRYr5zVtXl
 S8iYxFzghh2RaK3ig+HW8g0DawjW2lDyFIWgHcqDjF7g62NiujTSePb1E8BMr+WSuZyreghQ
 6qoe61A4v6VN73SDulVI93/rpBUcEzmv38EhYZGyg1tM7rVk8c5HNfpUQnhc5ZqVo6BOhnq5
 8WZJVGmJBLn8izFuc/O1QpobkOshWhlrwG8P+1VDClDXAtTGGrzXnHij8ISP1Eq4qOUw53BY
 efOMmC/1GUf3uGnLSTxkaI9uzJmY4nztzZgoCuSeqM4I7/tIBBq/y8Vg==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics][PATCH v2 1/2] patch-status: drop styhead
Date: Sun, 11 Jan 2026 20:06:42 +0100
Message-Id: <20260111190643.13404-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 11 Jan 2026 19:06:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2935

From: Peter Marko <peter.marko@siemens.com>

Metrics are no longer updated for this styhead, so drop current list of
its CVEs. Keep it in graphs as all other obsolete releases.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
v2: correct sender
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

