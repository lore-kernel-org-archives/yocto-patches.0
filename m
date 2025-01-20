Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14723C02185
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 20:10:58 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.95.1737403856451399723
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jan 2025 12:10:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=O44yn2z9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-20250120201053fef669ccea82dc72dc-t6znkx@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250120201053fef669ccea82dc72dc
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 20 Jan 2025 21:10:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=/tltfM+y6lxL3SmK11eqvXqDliotWSwUfFhG++MvEaE=;
 b=O44yn2z9UMQsSEdPQYz4PS6wCDeHQJiucqhL7mB4WhYkAq8BqvnqoptofCC0nUfAjjOwEG
 uHlobvhP3bQVDoPOUuArjKhwh9ZI/JdPDrIbRrs2pa50bKM9X856n3HGEkNZ3tFzGHi5G6fm
 phx31hSONjtvGOfCeERcFXeInE2rdNB7boYEswqyjQ97Tk2lHguwiI6hsIInGMCJLHmnJX/y
 or6X7+oPEDeL8TdWfH/+ed+JnjqH3VUnWvGTnE2hSCgemaG0A+17izmTqK3ozJSB1Ol6zUlm
 O0QPwW+Tyd/cjoHUhmnxBKAry2FuPh+27GE/+809DTinsiUWPHkDiRQw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics][PATCH 1/2] patch-status: remove nanbield
Date: Mon, 20 Jan 2025 21:10:00 +0100
Message-Id: <20250120201001.13117-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 20:10:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/991

From: Peter Marko <peter.marko@siemens.com>

The reports are no longer generated, they are shown empty.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/index.html | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index e8f3dfb8..28ca07df 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -178,10 +178,6 @@ SPDX-License-Identifier: MIT
           <summary>scarthgap</summary>
           <div id="cve_status_scarthgap"></div>
         </details>
-        <details>
-          <summary>nanbield</summary>
-          <div id="cve_status_nanbield"></div>
-        </details>
         <details>
           <summary>kirkstone</summary>
           <div id="cve_status_kirkstone"></div>
@@ -382,12 +378,6 @@ SPDX-License-Identifier: MIT
         createCVEList('cve_status_scarthgap', data);
       })
 
-    fetch('cve-status-nanbield.txt')
-      .then(response => response.text())
-      .then(data => {
-        createCVEList('cve_status_nanbield', data);
-      })
-
     fetch('cve-status-kirkstone.txt')
       .then(response => response.text())
       .then(data => {
-- 
2.30.2


