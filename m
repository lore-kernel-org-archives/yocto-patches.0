Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA8C25B10
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:40 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.62817.1715612370431019505
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=KhlLQf2g;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.44, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a599c55055dso1149147566b.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612369; x=1716217169; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/dCmKfWK9IMdPYisuUeh6RQ+/OIU0tE6bKjVhdWb0T8=;
        b=KhlLQf2gpex/uh+vCcPwFa/8DEWhjACqwJFreFlNsbnjXraRDkniairOSRm6gRpJvD
         vvBBEtiiKiI3dTrLif5GpMwbMMqbOJ3sLpX19ifUMew+pDuKiyP16jjEF7ht3ivacJgl
         ebuo5+8nWVpIPrlb3KDGvWlxwwaRjCbL6XMyHIcGToEv0PcR43ShMKa1jefvFcuSwxWt
         iCwKjs5zKv5hctm6JWa4hldv+1s6zV4RGc9AQzCo3JvLJrDbM0fF6K57JYXT/JW3/dhl
         gyC/KpNqjFId8bkyZDpQVKdcc7tCPVog8ES5ogHQaUzQfeqSoTfqcbroGCg7bguBXmDa
         WTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612369; x=1716217169;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dCmKfWK9IMdPYisuUeh6RQ+/OIU0tE6bKjVhdWb0T8=;
        b=tb7cpyDY6sn3qgH41YMC1Ks1SOFHModnFO+ngxT+wuD6qRU6uAItLCsZjqzEFUAobz
         ngOO3ceQN5dB9Ss/kN64W7vCx9/3KXn7YW1W/wd7y5I4ufJFwvVao4WqX7jtm4PyvFvg
         2cfmEqiTfzy1plA64fEC/HLqyldUh1/oFeLBxVbXmxmPssIm8aK2Fmr2wlVe+lekY403
         WHMthHMEB9comrvj8Srj95fDJzXS/H027sf8Ojk7Os4GgDUaongtajeAvHPBnloC3FTN
         dcQFcg6ElAbdmi7pGktCvxWfGGH0vVZZXIw6ZYbFzUTZBnonDh85gCVazVKT6LaB0FJ+
         QqTA==
X-Gm-Message-State: AOJu0YxLeR6N0cD8gzG7LWP/rfxoV59qiUaNjYaUzsU98pO8VpmI4tI3
	/b/uQRq+MJtv1fnxN6fllHAYNBF9S+0zfuTmlLx2LjZMtm33cnhg+qtThkr6qFEjEGnaSXXguAe
	b
X-Google-Smtp-Source: AGHT+IHK+ZsJ+gBbp3U/M8DKAF97Uk+HoaNzuf6XYckQo1kfLN5Z4D4FlhBhTo6v+LNTDhoA0ZND2A==
X-Received: by 2002:a17:906:f856:b0:a59:ab55:a58 with SMTP id a640c23a62f3a-a5a2d572b27mr657479166b.22.1715612368978;
        Mon, 13 May 2024 07:59:28 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:28 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 04/12] index.html: Add general description to first section
Date: Mon, 13 May 2024 16:58:53 +0200
Message-ID: <20240513145905.4167-5-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240513145905.4167-1-ninette@thehoodiefirm.com>
References: <20240513145905.4167-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 14:59:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/124

From: Alex Feyerke <hello@alexfeyerke.com>

Explains purpose of entire page, how to read the charts, and how to use the CVE lists for the individual branches.

Signed-off-by: Ninette Adhikari <ninette@thehoodiefirm.com>
---
 patch-status/index.html | 161 +++++++++++++++++++++++++++++-----------
 1 file changed, 119 insertions(+), 42 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 86a6cf06..f95fb692 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -13,14 +13,22 @@ SPDX-License-Identifier: MIT
   <link rel="icon" type="image/png" sizes="32x32" href="/resources/favicon-32x32.png">
   <link rel="icon" type="image/png" sizes="16x16" href="/resources/favicon-16x16.png">
   <style>
-    h3 {
-      margin-left: 60px;
-      padding-top: 20px;
-    }
-    ul {
-      margin-left: 60px;
+    main {
       font-size: 0.9em;
     }
+
+    section {
+      max-width: 55rem;
+      margin-inline: 3rem;
+    }
+
+    h1 {
+      padding-inline: 3rem;
+    }
+
+    h2 {
+      padding-top: 1em;
+    }
     details {
       margin-bottom: 0;
     }
@@ -32,23 +40,66 @@ SPDX-License-Identifier: MIT
       list-style-type: none;
       font-size: 0.8em;
     }
-    .cve-status {
-      display: flex;
-      margin: 0 60px;
-      align-items: stretch;
+
+    details summary::before {
+      display: block;
+      width: 1rem;
+      height: 1rem;
+      margin-inline-end: calc(var(--pico-spacing, 1rem)* .5);
+      float: left;
+      transform: rotate(-90deg);
+      background-image: var(--pico-icon-chevron);
+      background-position: right center;
+      background-size: 1rem auto;
+      background-repeat: no-repeat;
+      content: "";
+      transition: transform var(--pico-transition);
     }
-    .cve-status > details {
-      flex: 1;
+
+    details summary::after {
+      display: inline;
+      vertical-align: text-bottom;
+      width: auto;
+      background: none;
+      float: none;
+      font-weight: 600;
+      text-transform: uppercase;
+      font-size: 0.6em;
+      border: 2px solid;
+      border-radius: 1em;
+      padding-inline: 0.35em;
+      content: "Click to show";
     }
-    details > summary {
-      padding: 13px 14px;
+
+    .cve-status>details {
+      margin-block-end: 1em;
     }
-    details > summary:hover {
-      filter: invert(50%);
+
+    .cve-status details summary {
+      font-family: var(--pico-font-family-monospace);
     }
-    details[open] > summary {
+
+    .cve-status details summary:after {
+      display: none;
+    }
+
+    details[open]>summary {
       margin-bottom: 6px;
     }
+
+    details[open]>summary::before {
+      transform: rotate(0);
+    }
+
+    details[open]>summary::after {
+      transform: none;
+      content: "Click to hide";
+    }
+
+    details>summary:hover {
+      filter: invert(50%);
+    }
+
     summary.sub {
       font-size: 0.8em;
       padding: 6px 18px;
@@ -58,31 +109,57 @@ SPDX-License-Identifier: MIT
 
 <body>
   <main>
-    <h3>Current CVE status for OE-Core/Poky</h3>
-    <div class="cve-status">
-      <details>
-        <summary>master</summary>
-        <div id="cve_status_master"></div>
-      </details>
-      <details>
-        <summary>scarthgap</summary>
-        <div id="cve_status_scarthgap"></div>
-      </details>
-      <details>
-        <summary>nanbield</summary>
-        <div id="cve_status_nanbield"></div>
-      </details>
-      <details>
-        <summary>kirkstone</summary>
-        <div id="cve_status_kirkstone"></div>
-      </details>
-      <details>
-        <summary>dunfell</summary>
-        <div id="cve_status_dunfell"></div>
-      </details>
-    </div>
-
-    <!-- Prepare a DOM with a defined width and height for ECharts -->
+    <h1>yocto-metrics</h1>
+    <section>
+      <p>This page shows Common Vulnerabilities and Exposures (CVEs) metrics gathered from the Yocto Project autobuilder in graphs. It is updated daily to show the current status of the project.</p>
+      <p>
+        Each graph (except the pie chart) has an <strong>x-axis</strong> and a <strong>y-axis:</strong>
+      </p>
+      <ul>
+        <li>The <strong>x-axis</strong> represents time. You can filter by time-range using the zoom bar at the bottom.</li>
+        <li>The <strong>y-axis</strong> represents the amount of something (CVEs, patches, errors etc.) at a particular point in time. You can zoom here as well, using the bar on the right.</li>
+      </ul>
+      <p>
+        Click on the items in the <strong>legend</strong> to toggle the visibility of the corresponding line on the graph.</p>
+      <p>
+        Note the grey, vertical lines representing <strong>releases</strong>.
+        These lines are not part of the graph’s data but are added to highlight release points in time. They denote the release of new versions or updates of the software. This helps you correlate vulnerability trends with software releases, which can indicate whether vulnerabilities were addressed in a particular release.
+      </p>
+    </section>
+
+    <section>
+      <h2>Current CVE status for OE-Core/Poky</h2>
+      <p>
+        This section provides a detailed overview of the current status of CVEs for each branch in the <code>OE-Core/Poky</code> repository.</p>
+      <p>
+        When you click on a branch name, a summary count of CVEs related to that branch is displayed.
+        This count includes the total number of CVEs reported for that branch and so gives a quick overview of the security status of the branch.</p>
+      <p>
+        Below the summary count, you'll find links to more detailed information about CVEs for that branch. You can easily access more detailed information at the National Vulnerability Database (NVD), about CVEs for each branch by clicking on the provided links.</p>
+      <div class="cve-status">
+        <details>
+          <summary>master</summary>
+          <div id="cve_status_master"></div>
+        </details>
+        <details>
+          <summary>scarthgap</summary>
+          <div id="cve_status_scarthgap"></div>
+        </details>
+        <details>
+          <summary>nanbield</summary>
+          <div id="cve_status_nanbield"></div>
+        </details>
+        <details>
+          <summary>kirkstone</summary>
+          <div id="cve_status_kirkstone"></div>
+        </details>
+        <details>
+          <summary>dunfell</summary>
+          <div id="cve_status_dunfell"></div>
+        </details>
+      </div>
+    </section>
+
     <section>
       <h3>CVE Trends for OE-Core/Poky</h3>
       <div id='cve_chart' style='height:400px;'></div>
-- 
2.44.0


