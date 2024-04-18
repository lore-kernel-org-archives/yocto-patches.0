Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.8838.1713433777259961396
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 02:49:37 -0700
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343e46ec237so429030f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1713433776; x=1714038576; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zvXIdT7R7ZYahJx5F0MV8HR01E5UMOsEqdvv5EM0pjc=;
        b=V2VQ7bdS1gb2q3JaP8HrFGFK+1SxDSk7+XfRV7xsjFvdHALMjzczxBs3fH3eE+uwap
         Yp292CHyMXBANemLnT5qXJFaQ0/wa95QTm6A+1z28K574OQp+xaz8O9Q8l0JbDNYNMlr
         TVPmAIijfK7iJzDjKeys3UFBukRfSlxNfF9mGsUib/Fvk+gcnIn0pTsR+lQdDyffxSoY
         zxD/hVcZWPTxWoYATqpqNvihhh/CfHsOz6OIDH9sExDRFR4MULL3YNkyzHafe45mjDr9
         1ekeAciHZOtkKR8dLJ6y0DkrX6qbVxsWTMBM7KJlDg1IQzFTADqNr4C+ZrNs+6LyVK2X
         ze7g==
Return-Path: <ninette@thehoodiefirm.com>
From: "Ninette Adhikari" <ninette@thehoodiefirm.com>
Subject: [PATCH 4/4] index.html: show summary in a collapsible list
Date: Thu, 18 Apr 2024 11:49:17 +0200
Message-ID: <20240418094921.86489-8-ninette@thehoodiefirm.com>
In-Reply-To: <20240418094921.86489-1-ninette@thehoodiefirm.com>
References: <20240418094921.86489-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie, hulkoba <jacoba@neighbourhood.ie>
List-ID: <yocto-patches.lists.yoctoproject.org>

From: hulkoba <jacoba@neighbourhood.ie>

Yocto gathers the amount of CVEs per branch at the top of their metrics view.
However, the presentation of this information is not descriptive enough and it’s spread across several files.
This change adds collapsible, nested lists to show all cve information.

This commit shows current CVE count per release,
parse txt files with CVE lists to group them by project and display their total CVE count.

Inline this data on the page in details elements so there’s no need to navigate away.

Also, there will be another patch for the autobuilder-helper project where we update the data that is used.
It changes the format of the txt file so the metrics can handle it easily.
---
 patch-status/index.html | 120 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 6 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index a38e6644..3ebff90e 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -13,6 +13,39 @@ SPDX-License-Identifier: MIT
     }
     ul {
       margin-left: 60px;
+      font-size: 0.9em;
+    }
+    details {
+      margin-bottom: 0;
+    }
+    details > ul {
+      margin-left: 0;
+      padding-left: 14px;
+    }
+    details > ul > li {
+      list-style-type: none;
+      font-size: 0.8em;
+    }
+    .cve-status {
+      display: flex;
+      margin: 0 60px;
+      align-items: stretch;
+    }
+    .cve-status > details {
+      flex: 1;
+    }
+    details > summary {
+      padding: 13px 14px;
+    }
+    details > summary:hover {
+      filter: invert(50%);
+    }
+    details[open] > summary {
+      margin-bottom: 6px;
+    }
+    summary.sub {
+      font-size: 0.8em;
+      padding: 6px 18px;
     }
   </style>
 </head>
@@ -20,12 +53,25 @@ SPDX-License-Identifier: MIT
 <body>
   <main>
     <h3>Current CVE status for OE-Core/Poky</h3>
-    <ul>
-      <li><a href="cve-status-master.txt">master</a></li>
-      <li><a href="cve-status-nanbield.txt">nanbield</a></li>
-      <li><a href="cve-status-kirkstone.txt">kirkstone</a></li>
-      <li><a href="cve-status-dunfell.txt">dunfell</a></li>
-    </ul>
+    <div class="cve-status">
+      <details>
+        <summary>master</summary>
+        <div id="cve_status_master"></div>
+      </details>
+
+      <details>
+        <summary>nanbield</summary>
+        <div id="cve_status_nanbield"></div>
+      </details>
+      <details>
+        <summary>kirkstone</summary>
+        <div id="cve_status_kirkstone"></div>
+      </details>
+      <details>
+        <summary>dunfell</summary>
+        <div id="cve_status_dunfell"></div>
+      </details>
+    </div>
 
     <!-- Prepare a DOM with a defined width and height for ECharts -->
     <section>
@@ -60,6 +106,68 @@ SPDX-License-Identifier: MIT
       <li><a href="releases.csv">releases.csv</a></li>
     </ul>
   </main>
+
+  <script type="text/javascript">
+    fetch('cve-status-master.txt')
+   .then(response => response.text())
+   .then(data => {
+      createCVEList('cve_status_master', data);
+   })
+
+   fetch('cve-status-nanbield.txt')
+   .then(response => response.text())
+   .then(data => {
+       createCVEList('cve_status_nanbield', data);
+   })
+
+   fetch('cve-status-kirkstone.txt')
+   .then(response => response.text())
+   .then(data => {
+       createCVEList('cve_status_kirkstone', data);
+   })
+
+   fetch('cve-status-dunfell.txt')
+   .then(response => response.text())
+   .then(data => {
+       createCVEList('cve_status_dunfell', data);
+   })
+
+    function parseTxtFile(data) {
+      const cveData = {}
+      const txtCVEs = data.split(/\n\s*\n/)
+      // skip the header
+      for (let i = 1; i < txtCVEs.length; i++) {
+        const urls = txtCVEs[i].split("\n");
+        packageName = urls[0]
+
+        cveData[packageName] = []
+        for (let i = 1; i < urls.length; i++) {
+          cveData[packageName].push(urls[i].toString().trim());
+        }
+      }
+      return cveData
+    }
+
+    function createCVEList(listid, data) {
+      const nestedDetails = document.getElementById(listid);
+      const cveData = parseTxtFile(data)
+      let html = "";
+      for (let [name, cves] of Object.entries(cveData)) {
+        html += '<details>';
+        html += `<summary class="sub">${name} CVEs</summary>`;
+        html += "<ul>";
+        for (const cve of cves) {
+          html += '<li>'
+          html += `<a href="${cve}" target="_blank">${cve}</a>`
+          html += '</li>';
+        }
+        html += "</ul>";
+        html += "</details>";
+        nestedDetails.innerHTML = html;
+    };
+   }
+  </script>
+
   <!-- get the data -->
   <script type="text/javascript">
     const status_names = {
-- 
2.34.1

