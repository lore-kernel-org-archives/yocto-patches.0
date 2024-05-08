Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28F5C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:53 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.15804.1715182311257638751
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=BvTjpPfZ;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.48, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a5f81af4so1186923666b.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182310; x=1715787110; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81C6tWmMwPFoOnDt63Wryg63jY5wi6grruP1M1setYo=;
        b=BvTjpPfZ0V7kJgNcZeWuhcqzjBq1lHAPVb7BQ3YlnHp/8SYeQJVMvNX2IkC/79YTF5
         zqJV0kf+ljq3sCa+JqvDfDe3qB5qxhWXyRUJ9o4F8hsyyKr19jfGe4KozdcYvlBEQl8S
         A6wX2VpLbBB9j4FM5S6NVMZWgcWaOwvpLMRuFAAcHDzi0OtrBBwoMBQznjfEhlLHEc24
         TF1/qATZBGSRttPsy8noJtKmSz/VMe3RTaAeUDxKjS9zSkdemWKrGjUcAgzljI68xzgW
         qB3EfNX+cjeG0bMADKOZQXiP108ReXqlV7RegtaXekyZv6eyXB3aW6VLx3fMebTB5AAm
         /qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182310; x=1715787110;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81C6tWmMwPFoOnDt63Wryg63jY5wi6grruP1M1setYo=;
        b=iopcc+6zY8hWPdbETpMeb0fj6UfQ68CMkhs0//rfgkoYfG7RlfiA1Jy96mEipclyWc
         UZa2mdYDYQms60yU1+ED1w6s4pKRhXIZmVBP26MJzCoBe9Zb+8K72pY24za8LQT6u/1c
         KII+EYBc+EB+nYVGWTVB584MHOEPk+UQInC/cbwHVjVWE1hJGc6lF2BJCNFPFuUO4oYx
         s04mEUPVIgsfaQq7OKm8x9WHKW3JJ4ZfH3luocZvSoyOo8R9uXYJ38LjPFXEudfhyiQG
         smEfjkuTM3WVSvZH2/vAP+vWTUU3sH0ziCZ5aY+Y869HeDcEnJnfRttScX43+tUPjtDQ
         DtqA==
X-Gm-Message-State: AOJu0Yw8A+FW7Jh3W3/ZzIewAoryIUubH+8RdonpqEUFoGhgVd+SjMO9
	1zE0Jkem+WNEzSZ7MIE6IQukkRDVmnb+Mbpv8pl695yklMsYg9fk4D2RaJntdihaaCwAjkP4dfZ
	m
X-Google-Smtp-Source: AGHT+IE6pGlBDaYiI7m2BH8iMFnSjGKopaEyYqpIR7f/dbyZFjI0gqjJlbYtuhm7dz0fOGeWLLmlYQ==
X-Received: by 2002:a17:906:54c7:b0:a59:9edf:14b6 with SMTP id a640c23a62f3a-a59fb9699ccmr195990766b.45.1715182309724;
        Wed, 08 May 2024 08:31:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:49 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 12/12] index.html: linting and formatting
Date: Wed,  8 May 2024 17:31:27 +0200
Message-ID: <20240508153131.94270-13-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508153131.94270-1-ninette@thehoodiefirm.com>
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/103

From: Alex Feyerke <hello@alexfeyerke.com>

Also corrects a minor padding issue in details elements.

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
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
2.39.3 (Apple Git-145)


