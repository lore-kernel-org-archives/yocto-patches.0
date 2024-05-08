Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B14C41513
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:43 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.15797.1715182300173976879
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=thRt00GZ;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.49, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59b58fe083so793688966b.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182298; x=1715787098; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VsLvGgg5nrIQAYcUssChicz1c6iXBm+Xav/FO4F5N+M=;
        b=thRt00GZ2/BmDwKqne2OtIfXLNbzLfP/AsnD9jaPYpH0mP4eakX4BhLhcANahp6mA+
         gnxqcnsgNJwZ7rwGku82cLNEiCL9bJd2Y1BPglYiUvWnf+YIL1caQTC3eEd+2WB53keO
         zLqVO0Qd8TeKncAJpw+gGQoUH2AV6X4LXmNc00ecagaPvzp6zdtJb09T6abIzCyAnsFp
         B2LykFkZi3xUaD2LHt2J7t8CPuoTAaFgf6RY2xKblvIW0KJlKO/xaEYunRbRcxjwYCGk
         z1sP/PVTId8VwHPfm6ugNSxv5KhXCK79xB4KNVmPfhw2oR9CRh5pAe4NC0DIi/dOC4uX
         441A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182298; x=1715787098;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VsLvGgg5nrIQAYcUssChicz1c6iXBm+Xav/FO4F5N+M=;
        b=d2X+pFf6v0tLyAgL5vRJvTPDSvpQFRu9aX3YAx04S4Wei5fhcy+P5ifJmbBSE9qvPj
         L+fzjcFK4SXoydBQDzQsycmm2Tw4dQCDp1HmYMGPVNadHZsb4CcNI/Uv+Q+IO3BDY5xt
         QxOvhq26WKnSh9QXsr/QHVdl2sl2sWNcR2PNuY5EU5uqQwa4PZQTPmRaCpxU82hM+TO2
         Cr58heFPYZ4wrRujGAJOGeUcsVS0p3htCKeuKSjzB1wHET5aBbDa9QGunwuIv/ZZM4Xa
         KxnwsSmWuBWzUSRwSL22ejudmV2KUcBRMkgAFau0Hbao/f58+CDHggnUCihKbEhYgA+z
         cJFg==
X-Gm-Message-State: AOJu0YwaUOtlQAUvlq/g4f/avba3ihC7sMAWwJFevP0m772+JplOZpL8
	agYJh9nnMwn2rKoubAt/w3u975EYnKkrivMTNn8BlrucaqIyKXHTLF5G+E8CnyOthiOD+L2LqAF
	K
X-Google-Smtp-Source: AGHT+IHeIS1+F/nu80A/90Ts0yEbNYlBSUWfJLFj78fPrrtnqP3Xw4VCvUwPF1BOE9D5tuzs+Ulqtw==
X-Received: by 2002:a17:906:b311:b0:a59:ef75:5382 with SMTP id a640c23a62f3a-a59fb96beb1mr191517866b.43.1715182298688;
        Wed, 08 May 2024 08:31:38 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:38 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 04/12] index.html: Add general description to first section
Date: Wed,  8 May 2024 17:31:19 +0200
Message-ID: <20240508153131.94270-5-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508153131.94270-1-ninette@thehoodiefirm.com>
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/95

From: Alex Feyerke <hello@alexfeyerke.com>

Explains purpose of entire page, how to read the charts, and how to use the CVE lists for the individual branches.

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
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
2.39.3 (Apple Git-145)


