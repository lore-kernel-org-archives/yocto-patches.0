Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67FBC41513
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:53 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.15803.1715182310269049266
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=lariYWXu;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.167.46, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51fea3031c3so5902504e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182308; x=1715787108; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o6KMAa61WOoK5eCVpqoRI+U5oXRSo0QW98KELf5RarY=;
        b=lariYWXuZap1g80h6FbKuaR9TrQ+CmF2/jrgDW+IluaVPAgFT4JAaG0X+5au/Hf9zZ
         ab+1hNpR00TwE1m2NVzOoq79zpyaw1ghfSNYDgoYfY7bSWV1bX3QiFCf3ZH05mYwdvi6
         yuy9IeuO2pqA0OzhtNkwm6dgfi0eOby1W8V2RYC2zye7NBsNF9KGFkITH8HgURjF9HIT
         rlyofa0OY+eERUx4nwd0Mq8QtSwSS3p/7xLF6xit919XPQnKPrNtUUJKlyx00TmBGRsQ
         AJIZI+6cRmfgOWxDYcQA29hS638IiqMORtrAEzbAGIF+4zBVxT71v4wQ4rhy38xmZ7zg
         Dv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182308; x=1715787108;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6KMAa61WOoK5eCVpqoRI+U5oXRSo0QW98KELf5RarY=;
        b=fs2KiJYlkdjYPQCmg5WZLyoA9gx4hQG0Y3Up0u9GODiuTDfnR6K6qSm86VAyhOK6/s
         5Y5Jt3ndEGc0EptivZstP7g92tSwziOeeYDwhuUHfO4WPUKklEbWdrGD6bpCA2HGXb2s
         ZHE9Pw/9gBFCcBn2eTvTp14vSWplNn/Cdbx17Svs/pCbZK5H66jKYuqDSx24JfM7IqEG
         2yltRx+1O6+FhUuEnOhdguSgq9CtNefVosMiYy/uiSj3mVG7lU1cuqyRKZauB/i2V0W4
         r5XvajlPz7vBWmuFrWfKiFPATPofq6WE/BaGtyh/ZogdmFx7QBSoBBaHKvzKp8uzrM3N
         OeZw==
X-Gm-Message-State: AOJu0YwLidV+H5gmJCaOONzIHETHi1K8bBH6muUrooMb4MfkScP0hdYw
	mAyhanFIGWkNA26vzTVak9cPjhnYhPk9/1TPs7H53PSNco8eR6qVCWhGUI99SNy2j9BsFkvv7Nr
	h
X-Google-Smtp-Source: AGHT+IH2EeUXw8+Ug/HtYZNzpjOYNmKR+L4SwmSe6QQvUuaZSBHZexJCJ/FJLU2t0qf5zpmh7GsRJg==
X-Received: by 2002:ac2:4291:0:b0:51d:3675:6a06 with SMTP id 2adb3069b0e04-5217cf3cbdfmr2168888e87.66.1715182308524;
        Wed, 08 May 2024 08:31:48 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:48 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 11/12] index.html: Add dark mode to charts, improve chart layout
Date: Wed,  8 May 2024 17:31:26 +0200
Message-ID: <20240508153131.94270-12-ninette@thehoodiefirm.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/102

From: Alex Feyerke <hello@alexfeyerke.com>

Improve dark mode to include charts. Also make line and area charts full width and remove animations.

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
---
 patch-status/index.html        | 56 +++++++++++--------------
 patch-status/resources/dark.js | 76 ++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 31 deletions(-)
 create mode 100644 patch-status/resources/dark.js

diff --git a/patch-status/index.html b/patch-status/index.html
index a847a456..86e8c9db 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -8,6 +8,8 @@ SPDX-License-Identifier: MIT
   <meta charset="UTF-8">
   <meta title="Yocto Autobuilder Patch Metrics" <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <script src="resources/echarts.min.js"></script>
+  <!-- import dark theme -->
+  <script src="resources/dark.js"></script>
   <link rel="stylesheet" href="resources/pico.fluid.classless.min.css">
   <link rel="apple-touch-icon" sizes="144x144" href="/resources/apple-touch-icon.png">
   <link rel="icon" type="image/png" sizes="32x32" href="/resources/favicon-32x32.png">
@@ -426,6 +428,7 @@ SPDX-License-Identifier: MIT
 
   <!-- get the data -->
   <script type="text/javascript">
+    const theme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'default'
     const status_names = {
       pending: 'Pending',
       backport: 'Backport',
@@ -554,11 +557,16 @@ SPDX-License-Identifier: MIT
 
   <!-- cve_chart -->
   <script type="text/javascript">
-  if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
-    // dark mode
-    var cveChart = echarts.init(document.getElementById('cve_chart'), 'dark');
-  } else {
-    var cveChart = echarts.init(document.getElementById('cve_chart'));
+  const cveChart = echarts.init(document.getElementById('cve_chart'), theme);
+
+  const optionsforAllLineCharts = {
+    grid: {
+      left: 60,
+      right: 60,
+      top: 75,
+      bottom: 90
+    },
+    animation: false
   }
 
   const cveSeries = []
@@ -599,7 +607,8 @@ SPDX-License-Identifier: MIT
       series: [
         releases,
         ...cveSeries,
-      ]
+      ],
+      ...optionsforAllLineCharts
     };
 
     cveChart.setOption(cveOption);
@@ -608,12 +617,7 @@ SPDX-License-Identifier: MIT
 
   <!-- pie chart -->
   <script>
-    // dark mode
-    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
-      var pieChart = echarts.init(document.getElementById('pie_chart'), 'dark');
-    } else {
-      var pieChart = echarts.init(document.getElementById('pie_chart'));
-    }
+    const pieChart = echarts.init(document.getElementById('pie_chart'), theme);
 
     fetch('patch-status-pie.json')
       .then(response => response.json())
@@ -652,12 +656,7 @@ SPDX-License-Identifier: MIT
 
   <!-- patch status -->
   <script type="text/javascript">
-    // dark mode
-    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
-      var upstreamStatusChart = echarts.init(document.getElementById('upstream_status_chart'), 'dark');
-    } else {
-      var upstreamStatusChart = echarts.init(document.getElementById('upstream_status_chart'));
-    }
+    const upstreamStatusChart = echarts.init(document.getElementById('upstream_status_chart'), theme);
 
     function generateUpstreamChart({ patch_data, releases }) {
       releases.markLine.label.position = 'insideEndTop';
@@ -678,7 +677,8 @@ SPDX-License-Identifier: MIT
         series: [
           releases,
           ...upstreamSeries
-        ]
+        ],
+        ...optionsforAllLineCharts
       };
 
       upstreamStatusChart.setOption(upstreamOption);
@@ -687,11 +687,7 @@ SPDX-License-Identifier: MIT
 
   <!-- malformed upstream -->
   <script type="text/javascript">
-    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
-      var malformedChart = echarts.init(document.getElementById('malformed_chart'), 'dark');
-    } else {
-      var malformedChart = echarts.init(document.getElementById('malformed_chart'));
-    }
+    const malformedChart = echarts.init(document.getElementById('malformed_chart'), theme);
 
     function generateMalformedChart({ malformed_data, releases }) {
       releases.markLine.label.position = 'insideEndTop';
@@ -713,7 +709,8 @@ SPDX-License-Identifier: MIT
         series: [
           releases,
           ...malformedSeries
-        ]
+        ],
+        ...optionsforAllLineCharts
       };
 
       malformedChart.setOption(malformedOption);
@@ -722,11 +719,7 @@ SPDX-License-Identifier: MIT
 
   <!-- recipe count -->
   <script type="text/javascript">
-    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
-      var recipeChart = echarts.init(document.getElementById('recipe_chart'), 'dark');
-    } else {
-      var recipeChart = echarts.init(document.getElementById('recipe_chart'));
-    }
+    const recipeChart = echarts.init(document.getElementById('recipe_chart'), theme);
 
     function generateRecipeChart({ recipe_data, releases }) {
       releases.markLine.label.position = 'insideEndTop';
@@ -742,7 +735,8 @@ SPDX-License-Identifier: MIT
             name: 'Recipe Count',
             areaStyle: {},
           }
-        ]
+        ],
+        ...optionsforAllLineCharts
       };
 
       recipeChart.setOption(recipeOption);
diff --git a/patch-status/resources/dark.js b/patch-status/resources/dark.js
new file mode 100644
index 00000000..7f0fc92c
--- /dev/null
+++ b/patch-status/resources/dark.js
@@ -0,0 +1,76 @@
+/*
+ * Licensed to the Apache Software Foundation (ASF) under one
+ * or more contributor license agreements.  See the NOTICE file
+ * distributed with this work for additional information
+ * regarding copyright ownership.  The ASF licenses this file
+ * to you under the Apache License, Version 2.0 (the
+ * "License"); you may not use this file except in compliance
+ * with the License.  You may obtain a copy of the License at
+ *
+ *   http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing,
+ * software distributed under the License is distributed on an
+ * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
+ * KIND, either express or implied.  See the License for the
+ * specific language governing permissions and limitations
+ * under the License.
+ */
+
+(function(root, factory) {
+    if (typeof define === 'function' && define.amd) {
+        // AMD. Register as an anonymous module.
+        define(['exports', 'echarts'], factory);
+    } else if (
+        typeof exports === 'object' &&
+        typeof exports.nodeName !== 'string'
+    ) {
+        // CommonJS
+        factory(exports, require('echarts/lib/echarts'));
+    } else {
+        // Browser globals
+        factory({}, root.echarts);
+    }
+})(this, function(exports, echarts) {
+    var log = function(msg) {
+        if (typeof console !== 'undefined') {
+            console && console.error && console.error(msg);
+        }
+    };
+    if (!echarts) {
+        log('ECharts is not Loaded');
+        return;
+    }
+    var axisCommon = function () {
+        return {
+            splitLine: {
+                lineStyle: {
+                    color: '#484753'
+                }
+            },
+        };
+    };
+
+    var theme = {
+        darkMode: true,
+        backgroundColor: '#13171f',
+        legend: {
+            textStyle: {
+                color: '#B9B8CE'
+            }
+        },
+        line: {
+            symbol: 'circle'
+        },
+        dataZoom: {
+            borderColor: '#71708A',
+            handleStyle: {
+                color: '#353450',
+                borderColor: '#C5CBE3'
+            },
+        },
+        valueAxis: axisCommon(),
+    };
+
+    echarts.registerTheme('dark', theme);
+});
-- 
2.39.3 (Apple Git-145)


