Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BE7C25B7E
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 14:59:40 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web11.62826.1715612378493337889
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 07:59:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=uzIJVeCy;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.52, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a599eedc8eeso1097855466b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715612377; x=1716217177; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ZoCH81FCO1WxKZTq5NgRjokzb8CtBGX4/z6k5F1CjQ=;
        b=uzIJVeCy4YieXNCGVWbkhGCcmYjuZwu70TtnbB6/asQNzDzXsyw5hn9E8XEm+qVBe4
         dB7uUje35X3VKOPPdzij1mxH3HSIjhs8WeNkRMaRbzLNTHCxrOKG3XMxaRh2wSvQr46w
         kp+0ojGpDle/YQ4e2KGo91ySIqqx6Bv3psB6L8AX4/yiGiZ6tgYeAbQXcL9Nb8ssC2B+
         mrVmiAnkIEC+b4A2FxBMVbhaf+3wXI5mKzxTIUf0VVG3+x1zGU1DPFnlm3EykZfE35+f
         KBwuQmSD+FsvKy+h8/cQW37DdWj3SvrSeXCc3vlOLB9OI1epufjTNQDtvwhI8UHDcSxP
         NXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612377; x=1716217177;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZoCH81FCO1WxKZTq5NgRjokzb8CtBGX4/z6k5F1CjQ=;
        b=dGKa69VTF7KuOKk8noyxBmN96PBey9AOmSFTeFQDGKn2O7uCmYxv+L/i3LoN1z0Bvh
         86rb7tgJFuCyHpg2Af3U+UpWW0bUsJVPcwXDC1rK+amdN0UeKvLdmvH7d+Qmouz3bJdW
         63id2wXR4Ofc8xqxZ0UpjJkCw2tkvkAbao3V1lDKtVy8t6q/as0Ycrn1lQlom9mio1Nj
         JDmLVxn3s1D7vb2/KrMNptBBkgLFByBjZFQcC+B8zwsrR6MK5K5dFCD84nyg5urE8QwJ
         CKFBNahpXTUC3V/yNIQbsdTySAGu7EgEdSeKkK6W44rrtjQ76B1EHsKsD0gHry2jG576
         ZQbQ==
X-Gm-Message-State: AOJu0YyXEmqYQWF+CFp1UKKmDHSH2q85Mjp71MVFJ6OxHfLia6JF9w4b
	niORkOYg9Dq7H6nGKUClw7Efs5/ATipyzZZcfS4Gg0HCYDfpIoJPMW1GpMBeMNAi9h73smcOsKZ
	8
X-Google-Smtp-Source: AGHT+IGl03kx7xUjRcexNK03T31O1wATZQ+x/IFARFE2T36FFCUJ3KqC13KIwjxluxihn/oaE85c1Q==
X-Received: by 2002:a17:907:6d21:b0:a59:c62c:2127 with SMTP id a640c23a62f3a-a5a2d5815e5mr867460466b.17.1715612377004;
        Mon, 13 May 2024 07:59:37 -0700 (PDT)
Received: from localhost.localdomain ([95.90.235.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c81bfsm607518066b.129.2024.05.13.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 07:59:36 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>,
	Ninette Adhikari <ninette@thehoodiefirm.com>
Subject: [PATCH 11/12] index.html: Add dark mode to charts, improve chart layout
Date: Mon, 13 May 2024 16:59:00 +0200
Message-ID: <20240513145905.4167-12-ninette@thehoodiefirm.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/131

From: Alex Feyerke <hello@alexfeyerke.com>

Improve dark mode to include charts. Also make line and area charts full width and remove animations.

Signed-off-by: Ninette Adhikari <ninette@thehoodiefirm.com>
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
2.44.0


