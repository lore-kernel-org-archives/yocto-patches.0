Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86190C41513
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:40 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.62827.1715612379712547898
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=wFBSArsf;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.49, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a8f0d941so1086910266b.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612378; x=1716217178; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F2Q2K0jI7VuRGBNKD2VAYzULqqbkbAe/GFIerNEjkog=;
        b=wFBSArsf4G/Dp5clZiq9eSbw94r8zOo3ZwAujpScVybhZLoW584qJYG/tRdLWo+IM0
         QrKrwCp0cC/Sp59hKHq+gYi8P4ev0T0ukOsfQHM/6LHLzRplZhxrVKJnM4KGhikm8aUM
         /XD79NoXyaQ71IVnX64IpgL240MxA0DFuuBvJQtfjz5NCX2olvuME3no/6foMCaypM6t
         i6JJRlsxhUd7K7PtFTrfKiK9InlXPnbXMEyZfrOzr9N+pBQTqTPr4crAXfcULLCUIEBD
         qDlceT+yCo4BSWn8lBy+435fQWRg+Gea1/4P83lnCvBNsZFW2IIaT1uCqqBu7nxuQpd8
         9APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612378; x=1716217178;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2Q2K0jI7VuRGBNKD2VAYzULqqbkbAe/GFIerNEjkog=;
        b=FnRWZhc6dPGHXdU1oj5vNwkl3BsM64Ffbkjr9+Q3hJs/0xIbi/fl44tnzgw4vjErtE
         KQQ8uFLvvJXHcgj+YTWWv2C22ETwEzD/ad7lgZFn1UleP+G714x9v/8SntP30Jtrn2QS
         oss8VrEWcQnnoNgfZKsxDQvnDFaEJ5+PZXDVOnaO3ji+jGNHnF4nQImmBTTcdVpJYL3s
         G7aRIudjL1dw9XkF+Kl68tnaXQqOM3ENMlQi/v2l8Zbk4Pl2z7IaeFrAUXqt2W9NujJZ
         hTOhewU/aAFRGZV9ZKsdCnBIwgbuRCgjfXDziiTFrFMLweBEjYXqHmsiQon9Yme/brjt
         Djkw==
X-Gm-Message-State: AOJu0YxRiCn0/bWYSimnT/jrX1GBNP0AJdfVot8qbbXvG4NV7Pz6CIBf
	KytH0C+MFrww/CwyOmTnyCG+etaSmnLWtU8UJE/q+K5/GHUMt6UfYbvrBPLHBk9VpW/gRWPut+9
	2
X-Google-Smtp-Source: AGHT+IF8msafZ2/mpN28ioBT6xbd6ya/y1bk27YAbg2/f2Qne95B5RgFg82hNovBgA5K8vNswg253A==
X-Received: by 2002:a17:906:d207:b0:a59:bacc:b082 with SMTP id a640c23a62f3a-a5a2d65f32fmr616484366b.60.1715612378228;
        Mon, 13 May 2024 07:59:38 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:38 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 12/12] index.html: linting and formatting
Date: Mon, 13 May 2024 16:59:01 +0200
Message-ID: <20240513145905.4167-13-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240513145905.4167-1-ninette@thehoodiefirm.com>
References: <20240513145905.4167-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 14:59:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/132

From: Alex Feyerke <hello@alexfeyerke.com>

Also corrects a minor padding issue in details elements.

Signed-off-by: Ninette Adhikari <ninette@thehoodiefirm.com>
---
 patch-status/index.html | 259 ++++++++++++++++++++--------------------
 1 file changed, 128 insertions(+), 131 deletions(-)

diff --git a/patch-status/index.html b/patch-status/index.html
index 86e8c9db..99ddbbd2 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -64,11 +64,8 @@ SPDX-License-Identifier: MIT
     details {
       margin-bottom: 0;
     }
-    details > ul {
-      margin-left: 0;
-      padding-left: 14px;
-    }
-    details > ul > li {
+
+    details>ul>li {
       list-style-type: none;
       font-size: 0.8em;
     }
@@ -361,34 +358,34 @@ SPDX-License-Identifier: MIT
 
   <script type="text/javascript">
     fetch('cve-status-master.txt')
-   .then(response => response.text())
-   .then(data => {
-      createCVEList('cve_status_master', data);
-   })
-
-   fetch('cve-status-scarthgap.txt')
-   .then(response => response.text())
-   .then(data => {
-       createCVEList('cve_status_scarthgap', data);
-   })
-
-   fetch('cve-status-nanbield.txt')
-   .then(response => response.text())
-   .then(data => {
-       createCVEList('cve_status_nanbield', data);
-   })
-
-   fetch('cve-status-kirkstone.txt')
-   .then(response => response.text())
-   .then(data => {
-       createCVEList('cve_status_kirkstone', data);
-   })
-
-   fetch('cve-status-dunfell.txt')
-   .then(response => response.text())
-   .then(data => {
-       createCVEList('cve_status_dunfell', data);
-   })
+      .then(response => response.text())
+      .then(data => {
+        createCVEList('cve_status_master', data);
+      })
+
+    fetch('cve-status-scarthgap.txt')
+      .then(response => response.text())
+      .then(data => {
+        createCVEList('cve_status_scarthgap', data);
+      })
+
+    fetch('cve-status-nanbield.txt')
+      .then(response => response.text())
+      .then(data => {
+        createCVEList('cve_status_nanbield', data);
+      })
+
+    fetch('cve-status-kirkstone.txt')
+      .then(response => response.text())
+      .then(data => {
+        createCVEList('cve_status_kirkstone', data);
+      })
+
+    fetch('cve-status-dunfell.txt')
+      .then(response => response.text())
+      .then(data => {
+        createCVEList('cve_status_dunfell', data);
+      })
 
     function parseTxtFile(data) {
       const cveData = {}
@@ -422,8 +419,8 @@ SPDX-License-Identifier: MIT
         html += "</ul>";
         html += "</details>";
         nestedDetails.innerHTML = html;
-    };
-   }
+      };
+    }
   </script>
 
   <!-- get the data -->
@@ -448,7 +445,7 @@ SPDX-License-Identifier: MIT
         trigger: 'axis'
       },
       legend: {},
-      xAxis : { type: 'time' },
+      xAxis: { type: 'time' },
       yAxis: { type: 'value' },
       dataZoom: [
         {
@@ -472,7 +469,7 @@ SPDX-License-Identifier: MIT
         // skip the header
         for (let i = 1; i < lines.length; i++) {
           const line = lines[i].split(",");
-          if(line.length) {
+          if (line.length) {
             const cve = {
               name: line[0],
               xAxis: new Date(line[1])
@@ -510,109 +507,109 @@ SPDX-License-Identifier: MIT
             generateCVEChart({ cve_data, releases });
             return releases;
           }).then((releases) => {
-        fetch('patch-status-byday.json')
-          .then(response => response.json())
-          .then(data => {
-            // We have to sort the data by date
-            data.sort(function(x, y){
-              return x.date - y.date;
-            })
-
-            const patch_data = data.map(status => {
-              return {
-                date: new Date(status.date * 1000),
-                total: status.total,
-                pending: status.pending || 0,
-                backport: status.backport || 0,
-                inappropriate: status.inappropriate || 0,
-                accepted: status.accepted || 0,
-                submitted: status.submitted || 0,
-                denied: status.denied || 0
-              }
-            })
-
-            const malformed_data = data.map(status => {
-              return {
-                date: new Date(status.date * 1000),
-                total: status.total,
-                upstream_status: status['malformed-upstream-status'] || 0,
-                sob: status['malformed-sob'] || 0
-              }
-            })
-
-            const recipe_data = data.map(status => {
-              return {
-                date: new Date(status.date * 1000),
-                recipe_count: status.recipe_count
-              }
-            })
-
-            generateMalformedChart({ malformed_data, releases });
-            generateUpstreamChart({ patch_data, releases });
-            generateRecipeChart({ recipe_data, releases });
+            fetch('patch-status-byday.json')
+              .then(response => response.json())
+              .then(data => {
+                // We have to sort the data by date
+                data.sort(function (x, y) {
+                  return x.date - y.date;
+                })
+
+                const patch_data = data.map(status => {
+                  return {
+                    date: new Date(status.date * 1000),
+                    total: status.total,
+                    pending: status.pending || 0,
+                    backport: status.backport || 0,
+                    inappropriate: status.inappropriate || 0,
+                    accepted: status.accepted || 0,
+                    submitted: status.submitted || 0,
+                    denied: status.denied || 0
+                  }
+                })
+
+                const malformed_data = data.map(status => {
+                  return {
+                    date: new Date(status.date * 1000),
+                    total: status.total,
+                    upstream_status: status['malformed-upstream-status'] || 0,
+                    sob: status['malformed-sob'] || 0
+                  }
+                })
+
+                const recipe_data = data.map(status => {
+                  return {
+                    date: new Date(status.date * 1000),
+                    recipe_count: status.recipe_count
+                  }
+                })
+
+                generateMalformedChart({ malformed_data, releases });
+                generateUpstreamChart({ patch_data, releases });
+                generateRecipeChart({ recipe_data, releases });
+              });
           });
-        });
       });
   </script>
 
   <!-- cve_chart -->
   <script type="text/javascript">
-  const cveChart = echarts.init(document.getElementById('cve_chart'), theme);
-
-  const optionsforAllLineCharts = {
-    grid: {
-      left: 60,
-      right: 60,
-      top: 75,
-      bottom: 90
-    },
-    animation: false
-  }
-
-  const cveSeries = []
-  const datasetWithFilters = []
-  function generateCVEChart({ cve_data, releases }) {
-    branches.forEach(branch => {
-      datasetWithFilters.push({
-        id: branch,
-        fromDatasetId: 'dataset_raw',
-        transform: {
-          type: 'filter',
-          config: {
-            dimension: 'Branch', '=': branch,
+    const cveChart = echarts.init(document.getElementById('cve_chart'), theme);
+
+    const optionsforAllLineCharts = {
+      grid: {
+        left: 60,
+        right: 60,
+        top: 75,
+        bottom: 90
+      },
+      animation: false
+    }
+
+    const cveSeries = []
+    const datasetWithFilters = []
+    function generateCVEChart({ cve_data, releases }) {
+      branches.forEach(branch => {
+        datasetWithFilters.push({
+          id: branch,
+          fromDatasetId: 'dataset_raw',
+          transform: {
+            type: 'filter',
+            config: {
+              dimension: 'Branch', '=': branch,
+            }
           }
-        }
-      });
-      cveSeries.push({
-        type: 'line',
-        showSymbol: false,
-        datasetId: branch,
-        name: branch,
-        encode: {
-          x: 'Date',
-          y: 'Branchvalue'
-        }
+        });
+        cveSeries.push({
+          type: 'line',
+          showSymbol: false,
+          datasetId: branch,
+          name: branch,
+          encode: {
+            x: 'Date',
+            y: 'Branchvalue'
+          }
+        });
       });
-    });
-    const cveOption = {
-      legend: { right: 'auto' },
-      ...general_options,
-      dataset: [
-        {
-          id: 'dataset_raw',
-          source: cve_data
-        },
-        ...datasetWithFilters
-      ],
-      series: [
-        releases,
-        ...cveSeries,
-      ],
-      ...optionsforAllLineCharts
-    };
+      const cveOption = {
+        legend: { right: 'auto' },
+        ...general_options,
+        dataset: [
+          {
+            id: 'dataset_raw',
+            source: cve_data
+          },
+          ...datasetWithFilters
+        ],
+        series: [
+          releases,
+          ...cveSeries,
+        ],
+        ...optionsforAllLineCharts
+      };
 
-    cveChart.setOption(cveOption);
-  }
+      cveChart.setOption(cveOption);
+    }
   </script>
 
   <!-- pie chart -->
-- 
2.44.0


