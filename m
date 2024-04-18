Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.8931.1713433771819686500
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 02:49:32 -0700
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343f62d8124so472660f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1713433770; x=1714038570; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pGDTds6PXEEd0YB5m+EX0EnSg5/z2qV1Kb+QEMLtDng=;
        b=jed0HKTiYren93T7i7NrUmJzXzYUXauZnydWyV/hHntTxm5n0NfkogXHdXOAUNEq1y
         FSRt9UBQiT+GX/MLrgKSJXZSvlnJM4tAxOWoxo2ebtGN0LLmkwuKOVpbLfI8QyiOv8l7
         pg/8ez/Oloiq/sHhbZ9m8r1+RTQj8cZAh9QV55CHR/y7sgx+Br5KkWiaRFQIkcqlTrAT
         3O3kgy1lhI7mbXKVzV0QwpOCiSEpBJd5jjZXngevB4KKIDdJSZF6qfvUk8hqOYIkK1gO
         4rD99z0xiyJ/iYOA2Sc3sDhvpoJ6/x4S4Gn5I7wMkYW8DanodOJRb9peq30Hfp3ImU7k
         CB7w==
Return-Path: <ninette@thehoodiefirm.com>
From: "Ninette Adhikari" <ninette@thehoodiefirm.com>
Subject: [PATCH 1/4] patch-status: merge index- and index-full.html
Date: Thu, 18 Apr 2024 11:49:14 +0200
Message-ID: <20240418094921.86489-5-ninette@thehoodiefirm.com>
In-Reply-To: <20240418094921.86489-1-ninette@thehoodiefirm.com>
References: <20240418094921.86489-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie, hulkoba <jacoba@neighbourhood.ie>
List-ID: <yocto-patches.lists.yoctoproject.org>

From: hulkoba <jacoba@neighbourhood.ie>

Yocto currently maintains two views to display metrics: a multi-year and a single-year view.
Unifying them facilitates a more seamless user experience, and improves the maintenance of the website.

This commit removes the index-full.html
---
 patch-status/index-full.html | 266 -----------------------------------
 patch-status/index.html      | 217 ++++++++++++++++++++++++++--
 2 files changed, 206 insertions(+), 277 deletions(-)
 delete mode 100644 patch-status/index-full.html

diff --git a/patch-status/index-full.html b/patch-status/index-full.html
deleted file mode 100644
index 8c410be5..00000000
--- a/patch-status/index-full.html
+++ /dev/null
@@ -1,266 +0,0 @@
-<html>
-<!--
-SPDX-License-Identifier: MIT
--->
-    <head>
-        <script src="https://d3js.org/d3.v5.min.js"></script>
-        <script src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.6.0/c3.min.js"></script>
-        <link href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.6.0/c3.min.css" rel="stylesheet">
-        <style>
-            .c3-line {
-                stroke-width: 2px;
-            }
-        </style>
-    </head>
-    <body>
-        <h1>Current CVE status for OE-Core/Poky</h1>
-        <ul>
-        <li><a href="cve-status-master.txt">master</a></li>
-        <li><a href="cve-status-nanbield.txt">nanbield</a></li>
-        <li><a href="cve-status-kirkstone.txt">kirkstone</a></li>
-        <li><a href="cve-status-dunfell.txt">dunfell</a></li>
-        </ul>
-
-        <h1>CVE Trends for OE-Core/Poky</h1>
-        <div id="cve_chart"></div>
-
-        <h1>Current Patch Status Pie</h1>
-        <div id="status_pie_chart"></div>
-
-        <h1>Patch Upstream-Status Counts (OE-Core meta directory)</h1>
-        <div id="upstream_status_chart"></div>
-
-        <h1>Patch Tag Error Counts (OE-Core meta directory)</h1>
-        <div id="malformed_chart"></div>
-
-        <h1>Recipe Count (OE-Core meta directory)</h1>
-        <div id="recipe_count_chart"></div>
-
-        <h2>Raw Data</h2>
-        <ul>
-        <li><a href="patch-status.json">patch-status.json</a></li>
-        <li><a href="patch-status-pie.json">patch-status-pie.json</a></li>
-        <li><a href="patch-status-byday.json">patch-status-byday.json</a></li>
-        <li><a href="cve-count-byday.json">cve-count-byday.json</a></li>
-        <li><a href="releases.csv">releases.csv</a></li>
-        </ul>
-
-        <script type="text/javascript">
-            var valid_status = ['pending', 'backport', 'inappropriate', 'accepted', 'submitted', 'denied'];
-            var label_names = {
-                pending: "Pending",
-                backport: "Backport",
-                inappropriate: "Inappropriate",
-                accepted: "Accepted",
-                submitted: "Submitted",
-                denied: "Denied",
-                total: "Total",
-                'malformed-sob': "Malformed Signed-off-by",
-                'malformed-upstream-status': "Malformed Upstream-Status"
-            };
-
-            d3.json("patch-status-pie.json").then(function(data) {
-                var chart = c3.generate({
-                    bindto: '#status_pie_chart',
-                    data: {
-                        json: [data],
-                        keys: {
-                            value: valid_status
-                        },
-                        type: "pie",
-                        names: label_names
-                    },
-                    pie: {
-                        label: {
-                            format: function (value, ratio, id) {
-                                return d3.format('.0%')(ratio);
-                            }
-                        }
-                    }
-                });
-            });
-
-            d3.dsv(",", "releases.csv", function(d) {
-                return {
-                    value: new Date(d.Date),
-                    text: d.Name
-                };
-            }).then(function(release_lines) {
-                d3.json("cve-count-byday.json").then(function(cve_data) {
-                    cve_data2 = []
-                    for (var key in cve_data) {
-                        cve_data[key].date = key
-                        cve_data2.push(cve_data[key])
-                    }
-
-                    var chart = c3.generate({
-                        bindto: '#cve_chart',
-                        data: {
-                            json: cve_data2,
-                            xFormat: "%s",
-                            keys: {
-                                x: "date",
-                                value: ['master', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
-                            },
-                            type: "line",
-                            names: label_names
-                        },
-                        axis: {
-                            x: {
-                                type: 'timeseries',
-                                tick: {
-                                    format: '%Y-%m-%d'
-                                },
-                                localtime: false
-                            },
-                            y: {
-                                min: 0,
-                                padding: {bottom:0}
-                            }
-                        },
-                        grid: {
-                            x: {
-                                lines: release_lines
-                            },
-                            y: {
-                                show: true
-                            }
-                        },
-                        zoom: {
-                            enabled: true
-                        },
-                        line: {
-                            connectNull: true
-                        },
-                        point: {
-                            show: false
-                        }
-                    });
-
-                });
-
-            });
-
-            d3.dsv(",", "releases.csv", function(d) {
-                return {
-                    value: new Date(d.Date),
-                    text: d.Name
-                };
-            }).then(function(release_lines) {
-                d3.json("patch-status-byday.json").then(function(status_data) {
-                    var chart = c3.generate({
-                        bindto: '#upstream_status_chart',
-                        data: {
-                            json: status_data,
-                            xFormat: "%s",
-                            keys: {
-                                x: "date",
-                                value: valid_status.concat(['total'])
-                            },
-                            type: "area",
-                            groups: [valid_status, ['total']],
-                            names: label_names
-                        },
-                        axis: {
-                            x: {
-                                type: 'timeseries',
-                                tick: {
-                                    format: '%Y-%m-%d'
-                                },
-                                localtime: false
-                            }
-                        },
-                        grid: {
-                            x: {
-                                lines: release_lines
-                            },
-                            y: {
-                                show: true
-                            }
-                        },
-                        zoom: {
-                            enabled: true
-                        },
-                        point: {
-                            show: false
-                        }
-                    });
-
-                    var chart = c3.generate({
-                        bindto: '#malformed_chart',
-                        data: {
-                            json: status_data,
-                            xFormat: "%s",
-                            keys: {
-                                x: "date",
-                                value: ['total', 'malformed-upstream-status', 'malformed-sob']
-                            },
-                            type: "area",
-                            names: label_names
-                        },
-                        axis: {
-                            x: {
-                                type: 'timeseries',
-                                tick: {
-                                    format: '%Y-%m-%d'
-                                },
-                                localtime: false
-                            }
-                        },
-                        grid: {
-                            x: {
-                                lines: release_lines
-                            },
-                            y: {
-                                show: true
-                            }
-                        },
-                        zoom: {
-                            enabled: true
-                        },
-                        point: {
-                            show: false
-                        }
-                    });
-                    var chart = c3.generate({
-                        bindto: '#recipe_count_chart',
-                        data: {
-                            json: status_data,
-                            xFormat: "%s",
-                            keys: {
-                                x: "date",
-                                value: ['recipe_count']
-                            },
-                            type: "area",
-                            names: label_names
-                        },
-                        axis: {
-                            x: {
-                                type: 'timeseries',
-                                tick: {
-                                    format: '%Y-%m-%d'
-                                },
-                                localtime: false
-                            }
-                        },
-                        grid: {
-                            x: {
-                                lines: release_lines
-                            },
-                            y: {
-                                show: true
-                            }
-                        },
-                        zoom: {
-                            enabled: true
-                        },
-                        point: {
-                            show: false
-                        }
-                    });
-
-                });
-            });
-        </script>
-    </body>
-</html>
diff --git a/patch-status/index.html b/patch-status/index.html
index f88e5cb5..b54beccd 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -23,28 +23,39 @@ SPDX-License-Identifier: MIT
 
         <p><a href="index-full.html">Multi year data</a></p>
 
-        <h1>CVE Trends for OE-Core/Poky</h1>
+        <h2>CVE Trends for OE-Core/Poky</h2>
         <div id="cve_chart"></div>
+        <h3>CVE Trends for OE-Core/Poky of the last year</h3>
+        <div id="cve_chart_lastyear"></div>
 
-        <h1>Current Patch Status Pie</h1>
+        <h2>Current Patch Status Pie</h2>
         <div id="status_pie_chart"></div>
 
-        <h1>Patch Upstream-Status Counts (OE-Core meta directory)</h1>
+        <h2>Patch Upstream-Status Counts (OE-Core meta directory)</h2>
         <div id="upstream_status_chart"></div>
+        <h3>Patch Upstream-Status Counts (OE-Core meta directory) from the last year</h3>
+        <div id="upstream_status_chart_lastyear"></div>
 
-        <h1>Patch Tag Error Counts (OE-Core meta directory)</h1>
+        <h2>Patch Tag Error Counts (OE-Core meta directory)</h2>
         <div id="malformed_chart"></div>
+        <h3>Patch Tag Error Counts (OE-Core meta directory) from the last year</h3>
+        <div id="malformed_chart_lastyear"></div>
 
-        <h1>Recipe Count (OE-Core meta directory)</h1>
+        <h2>Recipe Count (OE-Core meta directory)</h2>
         <div id="recipe_count_chart"></div>
+        <h3>Recipe Count (OE-Core meta directory) from the last year</h3>
+        <div id="recipe_count_chart_lastyear"></div>
 
-        <h2>Raw Data</h2>
+        <h3>Raw Data</h3>
         <ul>
-        <li><a href="patch-status.json">patch-status.json</a></li>
-        <li><a href="patch-status-pie.json">patch-status-pie.json</a></li>
-        <li><a href="patch-status-byday-lastyear.json">patch-status-byday.json</a></li>
-        <li><a href="cve-count-byday-lastyear.json">cve-count-byday.json</a></li>
-        <li><a href="releases.csv">releases.csv</a></li>
+            <li><a href="../patch-status.json">patch-status.json</a></li>
+            <li><a href="patch-status-pie.json">patch-status-pie.json</a></li>
+
+            <li><a href="patch-status-byday.json">patch-status-byday.json</a></li>
+            <li><a href="patch-status-byday-lastyear.json">patch-status-byday-lastyear.json</a></li>
+            <li><a href="../cve-count-byday.json">cve-count-byday.json</a></li>
+            <li><a href="../cve-count-byday-lastyear.json">cve-count-byday-lastyear.json</a></li>
+            <li><a href="releases.csv">releases.csv</a></li>
         </ul>
 
         <script type="text/javascript">
@@ -82,6 +93,7 @@ SPDX-License-Identifier: MIT
                 });
             });
 
+            // #cve_chart
             d3.dsv(",", "releases.csv", function(d) {
                 return {
                     value: new Date(d.Date),
@@ -141,6 +153,68 @@ SPDX-License-Identifier: MIT
 
                 });
 
+            });
+            // #cve_chart lastyear
+            d3.dsv(",", "releases.csv", function(d) {
+                return {
+                    value: new Date(d.Date),
+                    text: d.Name
+                };
+            }).then(function(release_lines) {
+                d3.json("../cve-count-byday_lastyear.json")
+                .then(function(cve_data) {
+                    cve_data2 = []
+                    for (var key in cve_data) {
+                        cve_data[key].date = key
+                        cve_data2.push(cve_data[key])
+                    }
+
+                    var chart = bb.generate({
+                        bindto: '#cve_chart_lastyear',
+                        data: {
+                            json: cve_data2,
+                            xFormat: "%s",
+                            keys: {
+                                x: "date",
+                                value: ['master', 'nanbield', 'mickledore', 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
+                            },
+                            type: "line",
+                            names: label_names
+                        },
+                        axis: {
+                            x: {
+                                type: 'timeseries',
+                                tick: {
+                                    format: '%Y-%m-%d'
+                                },
+                                localtime: false
+                            },
+                            y: {
+                                min: 0,
+                                padding: {bottom:0}
+                            }
+                        },
+                        grid: {
+                            x: {
+                                lines: release_lines
+                            },
+                            y: {
+                                show: true
+                            }
+                        },
+                        zoom: {
+                            enabled: true
+                        },
+                        line: {
+                            connectNull: true
+                        },
+                        point: {
+                            show: false
+                        }
+                    });
+
+                });
+
             });
 
             d3.dsv(",", "releases.csv", function(d) {
@@ -263,6 +337,127 @@ SPDX-License-Identifier: MIT
 
                 });
             });
+
+            d3.dsv(",", "releases.csv", function(d) {
+                return {
+                    value: new Date(d.Date),
+                    text: d.Name
+                };
+            }).then(function(release_lines) {
+                d3.json("patch-status-byday_lastyear.json").then(function(status_data) {
+                    var chart = bb.generate({
+                        bindto: '#upstream_status_chart_lastyear',
+                        data: {
+                            json: status_data,
+                            xFormat: "%s",
+                            keys: {
+                                x: "date",
+                                value: valid_status.concat(['total'])
+                            },
+                            type: "area",
+                            groups: [valid_status, ['total']],
+                            names: label_names
+                        },
+                        axis: {
+                            x: {
+                                type: 'timeseries',
+                                tick: {
+                                    format: '%Y-%m-%d'
+                                },
+                                localtime: false
+                            }
+                        },
+                        grid: {
+                            x: {
+                                lines: release_lines
+                            },
+                            y: {
+                                show: true
+                            }
+                        },
+                        zoom: {
+                            enabled: true
+                        },
+                        point: {
+                            show: false
+                        }
+                    });
+
+                    var chart = bb.generate({
+                        bindto: '#malformed_chart_last',
+                        data: {
+                            json: status_data,
+                            xFormat: "%s",
+                            keys: {
+                                x: "date",
+                                value: ['total', 'malformed-upstream-status', 'malformed-sob']
+                            },
+                            type: "area",
+                            names: label_names
+                        },
+                        axis: {
+                            x: {
+                                type: 'timeseries',
+                                tick: {
+                                    format: '%Y-%m-%d'
+                                },
+                                localtime: false
+                            }
+                        },
+                        grid: {
+                            x: {
+                                lines: release_lines
+                            },
+                            y: {
+                                show: true
+                            }
+                        },
+                        zoom: {
+                            enabled: true
+                        },
+                        point: {
+                            show: false
+                        }
+                    });
+                    var chart = bb.generate({
+                        bindto: '#recipe_count_chart_lastyear',
+                        data: {
+                            json: status_data,
+                            xFormat: "%s",
+                            keys: {
+                                x: "date",
+                                value: ['recipe_count']
+                            },
+                            type: "area",
+                            names: label_names
+                        },
+                        axis: {
+                            x: {
+                                type: 'timeseries',
+                                tick: {
+                                    format: '%Y-%m-%d'
+                                },
+                                localtime: false
+                            }
+                        },
+                        grid: {
+                            x: {
+                                lines: release_lines
+                            },
+                            y: {
+                                show: true
+                            }
+                        },
+                        zoom: {
+                            enabled: true
+                        },
+                        point: {
+                            show: false
+                        }
+                    });
+
+                });
+            });
         </script>
     </body>
 </html>
-- 
2.34.1

