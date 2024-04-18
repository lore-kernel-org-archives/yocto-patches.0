Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.8837.1713433776095952469
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 02:49:37 -0700
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-345b857d7adso446879f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1713433774; x=1714038574; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r3afeEYOGb8Yd/y2N5AygbshuisReV79l4mWJnJ4hjM=;
        b=o3gLKUhveJ30s9j6EAbvHpWrTp5/agT3SXQAWKCzeXy+nYwfHXXKq5jmdWU8vSvyEF
         8ydWAnhBd9ZzDvXZQD303dqnpe6X5Mfk4IpggfpiMHpslHST6U5rZwdPAZpA25+Hi45y
         d01CgvaceKXpqxwhTjUcFcrhGK7B81b6xNGgMn43bHVLMKr/bgmfN8TAdvVHfO9gxUq7
         X15XvWOkDA2mSPzk6DdXCnPK/L5ltupe7yNn9IiiYAF8znJHikHNw3tqjaBojTyo37vt
         aQ3zBooj4HzvYLbszly+JHr2eB/OihI5vwg83fd5GlEkmHnSf1qZCHk/5SI9ARInIe4k
         +DvQ==
Return-Path: <ninette@thehoodiefirm.com>
From: "Ninette Adhikari" <ninette@thehoodiefirm.com>
Subject: [PATCH 3/4] patch-status/index.html: use echarts to display all charts
Date: Thu, 18 Apr 2024 11:49:16 +0200
Message-ID: <20240418094921.86489-7-ninette@thehoodiefirm.com>
In-Reply-To: <20240418094921.86489-1-ninette@thehoodiefirm.com>
References: <20240418094921.86489-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie, hulkoba <jacoba@neighbourhood.ie>
List-ID: <yocto-patches.lists.yoctoproject.org>

From: hulkoba <jacoba@neighbourhood.ie>

Now we use echarts and add a separate controls section (zoom)
for this purpose and remove interactivity from the old charts themselves
With this change we only need to load one, the complete, set of data. The z=
oom option makes it easy to filter tha charts by date-ranges.

We also load releases.csv only once

Note that there will be another patch for the autobuilder-helper project wh=
ere we update the data that is used.
Means that the jsonfiles with data for only the last year don't get created=
 anymore.
---
 patch-status/index.html               | 798 ++++++++++++--------------
 patch-status/resources/echarts.min.js |   1 +
 2 files changed, 361 insertions(+), 438 deletions(-)
 create mode 100644 patch-status/resources/echarts.min.js

diff --git a/patch-status/index.html b/patch-status/index.html
index 514e916f..a38e6644 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -1,464 +1,386 @@
-<html>
+<!DOCTYPE html>
 <!--
 SPDX-License-Identifier: MIT
 -->
-    <head>
-        <script src=3D"https://d3js.org/d3.v5.min.js"></script>
-        <script src=3D"https://cdnjs.cloudflare.com/ajax/libs/c3/0.6.0/c3.=
min.js"></script>
-        <link href=3D"https://cdnjs.cloudflare.com/ajax/libs/c3/0.6.0/c3.m=
in.css" rel=3D"stylesheet">
-        <link rel=3D"stylesheet" href=3D"pico.fluid.classless.min.css">
-        <style>
-            .c3-line {
-                stroke-width: 2px;
+
+<head>
+  <script src=3D"resources/echarts.min.js"></script>
+  <link rel=3D"stylesheet" href=3D"resources/pico.fluid.classless.min.css">
+  <style>
+    h3 {
+      margin-left: 60px;
+      padding-top: 20px;
+    }
+    ul {
+      margin-left: 60px;
+    }
+  </style>
+</head>
+
+<body>
+  <main>
+    <h3>Current CVE status for OE-Core/Poky</h3>
+    <ul>
+      <li><a href=3D"cve-status-master.txt">master</a></li>
+      <li><a href=3D"cve-status-nanbield.txt">nanbield</a></li>
+      <li><a href=3D"cve-status-kirkstone.txt">kirkstone</a></li>
+      <li><a href=3D"cve-status-dunfell.txt">dunfell</a></li>
+    </ul>
+
+    <!-- Prepare a DOM with a defined width and height for ECharts -->
+    <section>
+      <h3>CVE Trends for OE-Core/Poky</h3>
+      <div id=3D'cve_chart' style=3D'height:400px;'></div>
+    </section>
+    <section>
+      <h3>Current Patch Status Pie</h3>
+      <div id=3D'pie_chart' style=3D'height:300px; width: 600px;'></div>
+    </section>
+
+    <section>
+      <h3>Patch Upstream-Status Counts (OE-Core meta directory)</h3>
+      <div id=3D"upstream_status_chart" style=3D"height:400px;"></div>
+    </section>
+
+    <section>
+      <h3>Patch Tag Error Counts (OE-Core meta directory)</h3>
+      <div id=3D"malformed_chart" style=3D"height:400px;"></div>
+    </section>
+
+    <section>
+      <h3>Recipe Count (OE-Core meta directory)</h3>
+      <div id=3D"recipe_chart" style=3D"height:400px;"></div>
+    </section>
+
+    <h3>Raw Data</h3>
+    <ul>
+      <li><a href=3D"patch-status-pie.json">patch-status-pie.json</a></li>
+      <li><a href=3D"patch-status-byday.json">patch-status-byday.json</a><=
/li>
+      <li><a href=3D"../cve-count-byday.json">cve-count-byday.json</a></li>
+      <li><a href=3D"releases.csv">releases.csv</a></li>
+    </ul>
+  </main>
+  <!-- get the data -->
+  <script type=3D"text/javascript">
+    const status_names =3D {
+      pending: 'Pending',
+      backport: 'Backport',
+      inappropriate: 'Inappropriate',
+      accepted: 'Accepted',
+      submitted: 'Submitted',
+      denied: 'Denied',
+      total: 'Total',
+      sob: 'Malformed Signed-off-by',
+      upstream_status: 'Malformed Upstream-Status'
+    };
+    const branches =3D ['master', 'nanbield', 'mickledore', 'langdale', 'k=
irkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
+
+    const general_options =3D {
+      tooltip: {
+        order: 'valueDesc',
+        trigger: 'axis'
+      },
+      legend: {},
+      xAxis : { type: 'time' },
+      yAxis: { type: 'value' },
+      dataZoom: [
+        {
+          type: 'slider',
+          xAxisIndex: 0,
+          filterMode: 'none'
+        },
+        {
+          type: 'slider',
+          yAxisIndex: 0,
+          filterMode: 'none'
+        }
+      ]
+    }
+
+    fetch('releases.csv')
+      .then(response =3D> response.text())
+      .then(data =3D> {
+        const release_lines =3D []
+        const lines =3D data.split("\n")
+        // skip the header
+        for (let i =3D 1; i < lines.length; i++) {
+          const line =3D lines[i].split(",");
+          if(line.length) {
+            const cve =3D {
+              name: line[0],
+              xAxis: new Date(line[1])
+            }
+            release_lines.push(cve)
+          }
+        }
+        const releases =3D {
+          type: 'line',
+          datasetId: 'releases',
+          markLine: {
+            lineStyle: { color: '#aaa' },
+            symbol: ['none', 'none'],
+            label: {
+              formatter: '{b}',
+              color: '#777'
+            },
+            data: release_lines
+          },
+        }
+        return releases
+      }).then((releases) =3D> {
+        fetch('../cve-count-byday.json')
+          .then(response =3D> response.json())
+          .then(data =3D> {
+            const cve_data =3D []
+            cve_data.push(['Date', 'Branch', 'Branchvalue']);
+            for (var key in data) {
+              const dateObj =3D new Date(key * 1000);
+              for (let branchVal in data[key]) {
+                let entry =3D [dateObj, branchVal, parseInt(data[key][bran=
chVal])]
+                cve_data.push(entry)
+              }
             }
-        </style>
-    </head>
-    <body>
-      <main>
-        <h1>Current CVE status for OE-Core/Poky</h1>
-        <ul>
-        <li><a href=3D"cve-status-master.txt">master</a></li>
-        <li><a href=3D"cve-status-nanbield.txt">nanbield</a></li>
-        <li><a href=3D"cve-status-kirkstone.txt">kirkstone</a></li>
-        <li><a href=3D"cve-status-dunfell.txt">dunfell</a></li>
-        </ul>
+            generateCVEChart({ cve_data, releases });
+            return releases;
+          }).then((releases) =3D> {
+        fetch('patch-status-byday.json')
+          .then(response =3D> response.json())
+          .then(data =3D> {
+            // We have to sort the data by date
+            data.sort(function(x, y){
+              return x.date - y.date;
+            })
=20
+            const patch_data =3D data.map(status =3D> {
+              return {
+                date: new Date(status.date * 1000),
+                total: status.total,
+                pending: status.pending || 0,
+                backport: status.backport || 0,
+                inappropriate: status.inappropriate || 0,
+                accepted: status.accepted || 0,
+                submitted: status.submitted || 0,
+                denied: status.denied || 0
+              }
+            })
=20
-        <h2>CVE Trends for OE-Core/Poky</h2>
-        <div id=3D"cve_chart"></div>
-        <h3>CVE Trends for OE-Core/Poky of the last year</h3>
-        <div id=3D"cve_chart_lastyear"></div>
+            const malformed_data =3D data.map(status =3D> {
+              return {
+                date: new Date(status.date * 1000),
+                total: status.total,
+                upstream_status: status['malformed-upstream-status'] || 0,
+                sob: status['malformed-sob'] || 0
+              }
+            })
=20
-        <h2>Current Patch Status Pie</h2>
-        <div id=3D"status_pie_chart"></div>
+            const recipe_data =3D data.map(status =3D> {
+              return {
+                date: new Date(status.date * 1000),
+                recipe_count: status.recipe_count
+              }
+            })
=20
-        <h2>Patch Upstream-Status Counts (OE-Core meta directory)</h2>
-        <div id=3D"upstream_status_chart"></div>
-        <h3>Patch Upstream-Status Counts (OE-Core meta directory) from the=
 last year</h3>
-        <div id=3D"upstream_status_chart_lastyear"></div>
+            generateMalformedChart({ malformed_data, releases });
+            generateUpstreamChart({ patch_data, releases });
+            generateRecipeChart({ recipe_data, releases });
+          });
+        });
+      });
+  </script>
=20
-        <h2>Patch Tag Error Counts (OE-Core meta directory)</h2>
-        <div id=3D"malformed_chart"></div>
-        <h3>Patch Tag Error Counts (OE-Core meta directory) from the last =
year</h3>
-        <div id=3D"malformed_chart_lastyear"></div>
+  <!-- cve_chart -->
+  <script type=3D"text/javascript">
+  if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
+    // dark mode
+    var cveChart =3D echarts.init(document.getElementById('cve_chart'), 'd=
ark');
+  } else {
+    var cveChart =3D echarts.init(document.getElementById('cve_chart'));
+  }
=20
-        <h2>Recipe Count (OE-Core meta directory)</h2>
-        <div id=3D"recipe_count_chart"></div>
-        <h3>Recipe Count (OE-Core meta directory) from the last year</h3>
-        <div id=3D"recipe_count_chart_lastyear"></div>
+  const cveSeries =3D []
+  const datasetWithFilters =3D []
+  function generateCVEChart({ cve_data, releases }) {
+    branches.forEach(branch =3D> {
+      datasetWithFilters.push({
+        id: branch,
+        fromDatasetId: 'dataset_raw',
+        transform: {
+          type: 'filter',
+          config: {
+            dimension: 'Branch', '=3D': branch,
+          }
+        }
+      });
+      cveSeries.push({
+        type: 'line',
+        showSymbol: false,
+        datasetId: branch,
+        name: branch,
+        encode: {
+          x: 'Date',
+          y: 'Branchvalue'
+        }
+      });
+    });
+    const cveOption =3D {
+      legend: { right: 'auto' },
+      ...general_options,
+      dataset: [
+        {
+          id: 'dataset_raw',
+          source: cve_data
+        },
+        ...datasetWithFilters
+      ],
+      series: [
+        releases,
+        ...cveSeries,
+      ]
+    };
=20
-        <h3>Raw Data</h3>
-        <ul>
-            <li><a href=3D"../patch-status.json">patch-status.json</a></li>
-            <li><a href=3D"patch-status-pie.json">patch-status-pie.json</a=
></li>
+    cveChart.setOption(cveOption);
+  }
+  </script>
=20
-            <li><a href=3D"patch-status-byday.json">patch-status-byday.jso=
n</a></li>
-            <li><a href=3D"patch-status-byday-lastyear.json">patch-status-=
byday-lastyear.json</a></li>
-            <li><a href=3D"../cve-count-byday.json">cve-count-byday.json</=
a></li>
-            <li><a href=3D"../cve-count-byday-lastyear.json">cve-count-byd=
ay-lastyear.json</a></li>
-            <li><a href=3D"releases.csv">releases.csv</a></li>
-        </ul>
-      </main>
-        <script type=3D"text/javascript">
-            var valid_status =3D ['pending', 'backport', 'inappropriate', =
'accepted', 'submitted', 'denied'];
-            var label_names =3D {
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
+  <!-- pie chart -->
+  <script>
+    // dark mode
+    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
+      var pieChart =3D echarts.init(document.getElementById('pie_chart'), =
'dark');
+    } else {
+      var pieChart =3D echarts.init(document.getElementById('pie_chart'));
+    }
=20
-            d3.json("patch-status-pie.json").then(function(data) {
-                var chart =3D c3.generate({
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
+    fetch('patch-status-pie.json')
+      .then(response =3D> response.json())
+      .then(data =3D> {
+        const formatted =3D [
+          { "value": data.pending || 0, "name": "Pending" },
+          { "value": data.backport || 0, "name": "Backport" },
+          { "value": data.inappropriate || 0, "name": "Inappropriate" },
+          { "value": data.accepted || 0, "name": "Accepted" },
+          { "value": data.submitted || 0, "name": "Submitted" },
+          { "value": data.denied || 0, "name": "Denied" }
+        ]
+        generatePieChart(formatted)
+      });
=20
-            // #cve_chart
-            d3.dsv(",", "releases.csv", function(d) {
-                return {
-                    value: new Date(d.Date),
-                    text: d.Name
-                };
-            }).then(function(release_lines) {
-                d3.json("cve-count-byday-lastyear.json").then(function(cve=
_data) {
-                    cve_data2 =3D []
-                    for (var key in cve_data) {
-                        cve_data[key].date =3D key
-                        cve_data2.push(cve_data[key])
-                    }
+    function generatePieChart(data) {
+      const pieOption =3D {
+        tooltip: { trigger: 'item' },
+        series: [{
+          type: 'pie',
+          radius: '50%',
+          data: data,
+          label: { formatter: '{b} {d}%' },
+        }],
+        emphasis: {
+          itemStyle: {
+            shadowBlur: 10,
+            shadowOffsetX: 0,
+            shadowColor: 'rgba(0, 0, 0, 0.5)'
+          }
+        }
+      };
+      pieChart.setOption(pieOption);
+    }
+  </script>
=20
-                    var chart =3D c3.generate({
-                        bindto: '#cve_chart',
-                        data: {
-                            json: cve_data2,
-                            xFormat: "%s",
-                            keys: {
-                                x: "date",
-                                value: ['master', 'nanbield', 'mickledore'=
, 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
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
+  <!-- patch status -->
+  <script type=3D"text/javascript">
+    // dark mode
+    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
+      var upstreamStatusChart =3D echarts.init(document.getElementById('up=
stream_status_chart'), 'dark');
+    } else {
+      var upstreamStatusChart =3D echarts.init(document.getElementById('up=
stream_status_chart'));
+    }
=20
-                });
+    function generateUpstreamChart({ patch_data, releases }) {
+      releases.markLine.label.position =3D 'insideEndTop';
+      const keys =3D Object.keys(patch_data[0]);
+      const upstreamSeries =3D keys
+        .filter(status =3D> status !=3D=3D 'date')
+        .map(status =3D> ({
+          type: 'line',
+          showSymbol: false,
+          areaStyle: {},
+          name: status_names[status],
+          encode: { x: 'Date', y: status }
+        }));
=20
-            });
-            // #cve_chart lastyear
-            d3.dsv(",", "releases.csv", function(d) {
-                return {
-                    value: new Date(d.Date),
-                    text: d.Name
-                };
-            }).then(function(release_lines) {
-                d3.json("../cve-count-byday_lastyear.json")
-                .then(function(cve_data) {
-                    cve_data2 =3D []
-                    for (var key in cve_data) {
-                        cve_data[key].date =3D key
-                        cve_data2.push(cve_data[key])
-                    }
+      const upstreamOption =3D {
+        ...general_options,
+        dataset: { source: patch_data },
+        series: [
+          releases,
+          ...upstreamSeries
+        ]
+      };
=20
-                    var chart =3D bb.generate({
-                        bindto: '#cve_chart_lastyear',
-                        data: {
-                            json: cve_data2,
-                            xFormat: "%s",
-                            keys: {
-                                x: "date",
-                                value: ['master', 'nanbield', 'mickledore'=
, 'langdale', 'kirkstone', 'honister', 'hardknott', 'gatesgarth', 'dunfell']
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
+      upstreamStatusChart.setOption(upstreamOption);
+    }
+  </script>
=20
-                });
+  <!-- malformed upstream -->
+  <script type=3D"text/javascript">
+    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
+      var malformedChart =3D echarts.init(document.getElementById('malform=
ed_chart'), 'dark');
+    } else {
+      var malformedChart =3D echarts.init(document.getElementById('malform=
ed_chart'));
+    }
=20
-            });
+    function generateMalformedChart({ malformed_data, releases }) {
+      releases.markLine.label.position =3D 'insideEndTop';
+      const keys =3D Object.keys(malformed_data[0]);
+      const malformedSeries =3D keys
+        .filter(status =3D> status !=3D=3D 'date')
+        .map(status =3D> ({
+          type: 'line',
+          showSymbol: false,
+          areaStyle: {},
+          name: status_names[status],
+          encode: { x: 'Date', y: status }
+        }));
=20
-            d3.dsv(",", "releases.csv", function(d) {
-                return {
-                    value: new Date(d.Date),
-                    text: d.Name
-                };
-            }).then(function(release_lines) {
-                d3.json("patch-status-byday-lastyear.json").then(function(=
status_data) {
-                    var chart =3D c3.generate({
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
+      const malformedOption =3D {
+        ...general_options,
+        legend: {},
+        dataset: { source: malformed_data },
+        series: [
+          releases,
+          ...malformedSeries
+        ]
+      };
=20
-                    var chart =3D c3.generate({
-                        bindto: '#malformed_chart',
-                        data: {
-                            json: status_data,
-                            xFormat: "%s",
-                            keys: {
-                                x: "date",
-                                value: ['total', 'malformed-upstream-statu=
s', 'malformed-sob']
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
-                    var chart =3D c3.generate({
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
+      malformedChart.setOption(malformedOption);
+    }
+  </script>
=20
-                });
-            });
+  <!-- recipe count -->
+  <script type=3D"text/javascript">
+    if (window.matchMedia('(prefers-color-scheme: dark)').matches) {
+      var recipeChart =3D echarts.init(document.getElementById('recipe_cha=
rt'), 'dark');
+    } else {
+      var recipeChart =3D echarts.init(document.getElementById('recipe_cha=
rt'));
+    }
=20
-            d3.dsv(",", "releases.csv", function(d) {
-                return {
-                    value: new Date(d.Date),
-                    text: d.Name
-                };
-            }).then(function(release_lines) {
-                d3.json("patch-status-byday_lastyear.json").then(function(=
status_data) {
-                    var chart =3D bb.generate({
-                        bindto: '#upstream_status_chart_lastyear',
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
+    function generateRecipeChart({ recipe_data, releases }) {
+      releases.markLine.label.position =3D 'insideEndTop';
=20
-                    var chart =3D bb.generate({
-                        bindto: '#malformed_chart_last',
-                        data: {
-                            json: status_data,
-                            xFormat: "%s",
-                            keys: {
-                                x: "date",
-                                value: ['total', 'malformed-upstream-statu=
s', 'malformed-sob']
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
-                    var chart =3D bb.generate({
-                        bindto: '#recipe_count_chart_lastyear',
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
+      const recipeOption =3D {
+        ...general_options,
+        dataset: { source: recipe_data },
+        series: [
+          releases,
+          {
+            type: 'line',
+            showSymbol: false,
+            name: 'Recipe Count',
+            areaStyle: {},
+          }
+        ]
+      };
=20
-                });
-            });
-        </script>
-    </body>
-</html>
+      recipeChart.setOption(recipeOption);
+    }
+  </script>
diff --git a/patch-status/resources/echarts.min.js b/patch-status/resources=
/echarts.min.js
new file mode 100644
index 00000000..89a9a813
--- /dev/null
+++ b/patch-status/resources/echarts.min.js
@@ -0,0 +1 @@
+!function(t,e){"object"=3D=3Dtypeof exports&&"undefined"!=3Dtypeof module?=
e(exports):"function"=3D=3Dtypeof define&&define.amd?define(["exports"],e):=
e((t=3D"undefined"!=3Dtypeof globalThis?globalThis:t||self).echarts=3D{})}(=
this,function(t){"use strict";var v=3Dfunction(t,e){return(v=3DObject.setPr=
ototypeOf||({__proto__:[]}instanceof Array?function(t,e){t.__proto__=3De}:f=
unction(t,e){for(var n in e)Object.prototype.hasOwnProperty.call(e,n)&&(t[n=
]=3De[n])}))(t,e)};function u(t,e){if("function"!=3Dtypeof e&&null!=3D=3De)=
throw new TypeError("Class extends value "+String(e)+" is not a constructor=
 or null");function n(){this.constructor=3Dt}v(t,e),t.prototype=3Dnull=3D=
=3D=3De?Object.create(e):(n.prototype=3De.prototype,new n)}function _(){thi=
s.firefox=3D!1,this.ie=3D!1,this.edge=3D!1,this.newEdge=3D!1,this.weChat=3D=
!1}var b=3Dnew function(){this.browser=3Dnew _,this.node=3D!1,this.wxa=3D!1=
,this.worker=3D!1,this.svgSupported=3D!1,this.touchEventsSupported=3D!1,thi=
s.pointerEventsSupported=3D!1,this.domSupported=3D!1,this.transformSupporte=
d=3D!1,this.transform3dSupported=3D!1,this.hasGlobalWindow=3D"undefined"!=
=3Dtypeof window};"object"=3D=3Dtypeof wx&&"function"=3D=3Dtypeof wx.getSys=
temInfoSync?(b.wxa=3D!0,b.touchEventsSupported=3D!0):"undefined"=3D=3Dtypeo=
f document&&"undefined"!=3Dtypeof self?b.worker=3D!0:"undefined"=3D=3Dtypeo=
f navigator||0=3D=3D=3Dnavigator.userAgent.indexOf("Node.js")?(b.node=3D!0,=
b.svgSupported=3D!0):(J=3Dnavigator.userAgent,ie=3D(Ft=3Db).browser,ot=3DJ.=
match(/Firefox\/([\d.]+)/),Y=3DJ.match(/MSIE\s([\d.]+)/)||J.match(/Trident\=
/.+?rv:(([\d.]+))/),Q=3DJ.match(/Edge?\/([\d.]+)/),J=3D/micromessenger/i.te=
st(J),ot&&(ie.firefox=3D!0,ie.version=3Dot[1]),Y&&(ie.ie=3D!0,ie.version=3D=
Y[1]),Q&&(ie.edge=3D!0,ie.version=3DQ[1],ie.newEdge=3D18<+Q[1].split(".")[0=
]),J&&(ie.weChat=3D!0),Ft.svgSupported=3D"undefined"!=3Dtypeof SVGRect,Ft.t=
ouchEventsSupported=3D"ontouchstart"in window&&!ie.ie&&!ie.edge,Ft.pointerE=
ventsSupported=3D"onpointerdown"in window&&(ie.edge||ie.ie&&11<=3D+ie.versi=
on),Ft.domSupported=3D"undefined"!=3Dtypeof document,ot=3Ddocument.document=
Element.style,Ft.transform3dSupported=3D(ie.ie&&"transition"in ot||ie.edge|=
|"WebKitCSSMatrix"in window&&"m11"in new WebKitCSSMatrix||"MozPerspective"i=
n ot)&&!("OTransition"in ot),Ft.transformSupported=3DFt.transform3dSupporte=
d||ie.ie&&9<=3D+ie.version);var j=3D"12px sans-serif";var x,w,T=3Dfunction(=
t){var e=3D{};if("undefined"!=3Dtypeof JSON)for(var n=3D0;n<t.length;n++){v=
ar i=3DString.fromCharCode(n+32),o=3D(t.charCodeAt(n)-20)/100;e[i]=3Do}retu=
rn e}("007LLmW'55;N0500LLLLLLLLLL00NNNLzWW\\\\WQb\\0FWLg\\bWb\\WQ\\WrWWQ000=
CL5LLFLL0LL**F*gLLLL5F0LF\\FFF5.5N"),X=3D{createCanvas:function(){return"un=
defined"!=3Dtypeof document&&document.createElement("canvas")},measureText:=
function(t,e){if(x||(n=3DX.createCanvas(),x=3Dn&&n.getContext("2d")),x)retu=
rn w!=3D=3De&&(w=3Dx.font=3De||j),x.measureText(t);t=3Dt||"";var n=3D/(\d+)=
px/.exec(e=3De||j),i=3Dn&&+n[1]||12,o=3D0;if(0<=3De.indexOf("mono"))o=3Di*t=
.length;else for(var r=3D0;r<t.length;r++){var a=3DT[t[r]];o+=3Dnull=3D=3Da=
?i:a*i}return{width:o}},loadImage:function(t,e,n){var i=3Dnew Image;return =
i.onload=3De,i.onerror=3Dn,i.src=3Dt,i}};function I(t){for(var e in X)t[e]&=
&(X[e]=3Dt[e])}var A=3Dlt(["Function","RegExp","Date","Error","CanvasGradie=
nt","CanvasPattern","Image","Canvas"],function(t,e){return t["[object "+e+"=
]"]=3D!0,t},{}),L=3Dlt(["Int8","Uint8","Uint8Clamped","Int16","Uint16","Int=
32","Uint32","Float32","Float64"],function(t,e){return t["[object "+e+"Arra=
y]"]=3D!0,t},{}),U=3DObject.prototype.toString,Y=3DArray.prototype,Z=3DY.fo=
rEach,q=3DY.filter,K=3DY.slice,$=3DY.map,Q=3Dfunction(){}.constructor,J=3DQ=
?Q.prototype:null,tt=3D"__proto__",et=3D2311;function nt(){return et++}func=
tion it(){for(var t=3D[],e=3D0;e<arguments.length;e++)t[e]=3Darguments[e];"=
undefined"!=3Dtypeof console&&console.error.apply(console,t)}function y(t){=
if(null=3D=3Dt||"object"!=3Dtypeof t)return t;var e=3Dt,n=3DU.call(t);if("[=
object Array]"=3D=3D=3Dn){if(!Ct(t))for(var e=3D[],i=3D0,o=3Dt.length;i<o;i=
++)e[i]=3Dy(t[i])}else if(L[n]){if(!Ct(t)){var r=3Dt.constructor;if(r.from)=
e=3Dr.from(t);else for(e=3Dnew r(t.length),i=3D0,o=3Dt.length;i<o;i++)e[i]=
=3Dt[i]}}else if(!A[n]&&!Ct(t)&&!ft(t))for(var a in e=3D{},t)t.hasOwnProper=
ty(a)&&a!=3D=3Dtt&&(e[a]=3Dy(t[a]));return e}function d(t,e,n){if(!O(e)||!O=
(t))return n?y(e):t;for(var i in e){var o,r;e.hasOwnProperty(i)&&i!=3D=3Dtt=
&&(o=3Dt[i],!O(r=3De[i])||!O(o)||V(r)||V(o)||ft(r)||ft(o)||pt(r)||pt(o)||Ct=
(r)||Ct(o)?!n&&i in t||(t[i]=3Dy(e[i])):d(o,r,n))}return t}function P(t,e){=
if(Object.assign)Object.assign(t,e);else for(var n in e)e.hasOwnProperty(n)=
&&n!=3D=3Dtt&&(t[n]=3De[n]);return t}function B(t,e,n){for(var i=3Dht(e),o=
=3D0;o<i.length;o++){var r=3Di[o];(n?null!=3De[r]:null=3D=3Dt[r])&&(t[r]=3D=
e[r])}return t}var ot=3DX.createCanvas;function C(t,e){if(t){if(t.indexOf)r=
eturn t.indexOf(e);for(var n=3D0,i=3Dt.length;n<i;n++)if(t[n]=3D=3D=3De)ret=
urn n}return-1}function rt(t,e){var n,i=3Dt.prototype;function o(){}for(n i=
n o.prototype=3De.prototype,t.prototype=3Dnew o,i)i.hasOwnProperty(n)&&(t.p=
rototype[n]=3Di[n]);(t.prototype.constructor=3Dt).superClass=3De}function a=
t(t,e,n){if(t=3D"prototype"in t?t.prototype:t,e=3D"prototype"in e?e.prototy=
pe:e,Object.getOwnPropertyNames)for(var i=3DObject.getOwnPropertyNames(e),o=
=3D0;o<i.length;o++){var r=3Di[o];"constructor"!=3D=3Dr&&(n?null!=3De[r]:nu=
ll=3D=3Dt[r])&&(t[r]=3De[r])}else B(t,e,n)}function st(t){return!!t&&"strin=
g"!=3Dtypeof t&&"number"=3D=3Dtypeof t.length}function E(t,e,n){if(t&&e)if(=
t.forEach&&t.forEach=3D=3D=3DZ)t.forEach(e,n);else if(t.length=3D=3D=3D+t.l=
ength)for(var i=3D0,o=3Dt.length;i<o;i++)e.call(n,t[i],i,t);else for(var r =
in t)t.hasOwnProperty(r)&&e.call(n,t[r],r,t)}function F(t,e,n){if(!t)return=
[];if(!e)return wt(t);if(t.map&&t.map=3D=3D=3D$)return t.map(e,n);for(var i=
=3D[],o=3D0,r=3Dt.length;o<r;o++)i.push(e.call(n,t[o],o,t));return i}functi=
on lt(t,e,n,i){if(t&&e){for(var o=3D0,r=3Dt.length;o<r;o++)n=3De.call(i,n,t=
[o],o,t);return n}}function ut(t,e,n){if(!t)return[];if(!e)return wt(t);if(=
t.filter&&t.filter=3D=3D=3Dq)return t.filter(e,n);for(var i=3D[],o=3D0,r=3D=
t.length;o<r;o++)e.call(n,t[o],o,t)&&i.push(t[o]);return i}function ht(t){i=
f(!t)return[];if(Object.keys)return Object.keys(t);var e,n=3D[];for(e in t)=
t.hasOwnProperty(e)&&n.push(e);return n}var S=3DJ&&D(J.bind)?J.call.bind(J.=
bind):function(t,e){for(var n=3D[],i=3D2;i<arguments.length;i++)n[i-2]=3Dar=
guments[i];return function(){return t.apply(e,n.concat(K.call(arguments)))}=
};function M(t){for(var e=3D[],n=3D1;n<arguments.length;n++)e[n-1]=3Dargume=
nts[n];return function(){return t.apply(this,e.concat(K.call(arguments)))}}=
function V(t){return Array.isArray?Array.isArray(t):"[object Array]"=3D=3D=
=3DU.call(t)}function D(t){return"function"=3D=3Dtypeof t}function H(t){ret=
urn"string"=3D=3Dtypeof t}function ct(t){return"[object String]"=3D=3D=3DU.=
call(t)}function W(t){return"number"=3D=3Dtypeof t}function O(t){var e=3Dty=
peof t;return"function"=3D=3De||!!t&&"object"=3D=3De}function pt(t){return!=
!A[U.call(t)]}function dt(t){return!!L[U.call(t)]}function ft(t){return"obj=
ect"=3D=3Dtypeof t&&"number"=3D=3Dtypeof t.nodeType&&"object"=3D=3Dtypeof t=
.ownerDocument}function gt(t){return null!=3Dt.colorStops}function yt(t){re=
turn null!=3Dt.image}function mt(t){return"[object RegExp]"=3D=3D=3DU.call(=
t)}function vt(t){return t!=3Dt}function _t(){for(var t=3D[],e=3D0;e<argume=
nts.length;e++)t[e]=3Darguments[e];for(var n=3D0,i=3Dt.length;n<i;n++)if(nu=
ll!=3Dt[n])return t[n]}function R(t,e){return null!=3Dt?t:e}function xt(t,e=
,n){return null!=3Dt?t:null!=3De?e:n}function wt(t){for(var e=3D[],n=3D1;n<=
arguments.length;n++)e[n-1]=3Darguments[n];return K.apply(t,e)}function bt(=
t){var e;return"number"=3D=3Dtypeof t?[t,t,t,t]:2=3D=3D=3D(e=3Dt.length)?[t=
[0],t[1],t[0],t[1]]:3=3D=3D=3De?[t[0],t[1],t[2],t[1]]:t}function St(t,e){if=
(!t)throw new Error(e)}function Mt(t){return null=3D=3Dt?null:"function"=3D=
=3Dtypeof t.trim?t.trim():t.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g,""=
)}var Tt=3D"__ec_primitive__";function It(t){t[Tt]=3D!0}function Ct(t){retu=
rn t[Tt]}At.prototype.delete=3Dfunction(t){var e=3Dthis.has(t);return e&&de=
lete this.data[t],e},At.prototype.has=3Dfunction(t){return this.data.hasOwn=
Property(t)},At.prototype.get=3Dfunction(t){return this.data[t]},At.prototy=
pe.set=3Dfunction(t,e){return this.data[t]=3De,this},At.prototype.keys=3Dfu=
nction(){return ht(this.data)},At.prototype.forEach=3Dfunction(t){var e,n=
=3Dthis.data;for(e in n)n.hasOwnProperty(e)&&t(n[e],e)};var Dt=3DAt,kt=3D"f=
unction"=3D=3Dtypeof Map;function At(){this.data=3D{}}Pt.prototype.hasKey=
=3Dfunction(t){return this.data.has(t)},Pt.prototype.get=3Dfunction(t){retu=
rn this.data.get(t)},Pt.prototype.set=3Dfunction(t,e){return this.data.set(=
t,e),e},Pt.prototype.each=3Dfunction(n,i){this.data.forEach(function(t,e){n=
.call(i,t,e)})},Pt.prototype.keys=3Dfunction(){var t=3Dthis.data.keys();ret=
urn kt?Array.from(t):t},Pt.prototype.removeKey=3Dfunction(t){this.data.dele=
te(t)};var Lt=3DPt;function Pt(t){var n=3DV(t),i=3D(this.data=3Dnew(kt?Map:=
Dt),this);function e(t,e){n?i.set(t,e):i.set(e,t)}t instanceof Pt?t.each(e)=
:t&&E(t,e)}function N(t){return new Lt(t)}function Ot(t,e){for(var n=3Dnew =
t.constructor(t.length+e.length),i=3D0;i<t.length;i++)n[i]=3Dt[i];for(var o=
=3Dt.length,i=3D0;i<e.length;i++)n[i+o]=3De[i];return n}function Rt(t,e){va=
r n,t=3DObject.create?Object.create(t):((n=3Dfunction(){}).prototype=3Dt,ne=
w n);return e&&P(t,e),t}function Nt(t){t=3Dt.style;t.webkitUserSelect=3D"no=
ne",t.userSelect=3D"none",t.webkitTapHighlightColor=3D"rgba(0,0,0,0)",t["-w=
ebkit-touch-callout"]=3D"none"}function Et(t,e){return t.hasOwnProperty(e)}=
function zt(){}var Bt=3D180/Math.PI,Ft=3DObject.freeze({__proto__:null,Hash=
Map:Lt,RADIAN_TO_DEGREE:Bt,assert:St,bind:S,clone:y,concatArray:Ot,createCa=
nvas:ot,createHashMap:N,createObject:Rt,curry:M,defaults:B,disableUserSelec=
t:Nt,each:E,eqNaN:vt,extend:P,filter:ut,find:function(t,e,n){if(t&&e)for(va=
r i=3D0,o=3Dt.length;i<o;i++)if(e.call(n,t[i],i,t))return t[i]},guid:nt,has=
Own:Et,indexOf:C,inherits:rt,isArray:V,isArrayLike:st,isBuiltInObject:pt,is=
Dom:ft,isFunction:D,isGradientObject:gt,isImagePatternObject:yt,isNumber:W,=
isObject:O,isPrimitive:Ct,isRegExp:mt,isString:H,isStringSafe:ct,isTypedArr=
ay:dt,keys:ht,logError:it,map:F,merge:d,mergeAll:function(t,e){for(var n=3D=
t[0],i=3D1,o=3Dt.length;i<o;i++)n=3Dd(n,t[i],e);return n},mixin:at,noop:zt,=
normalizeCssArray:bt,reduce:lt,retrieve:_t,retrieve2:R,retrieve3:xt,setAsPr=
imitive:It,slice:wt,trim:Mt});function Vt(t,e){return[t=3Dnull=3D=3Dt?0:t,e=
=3Dnull=3D=3De?0:e]}function Ht(t){return[t[0],t[1]]}function Wt(t,e,n){ret=
urn t[0]=3De[0]+n[0],t[1]=3De[1]+n[1],t}function Gt(t,e,n){return t[0]=3De[=
0]-n[0],t[1]=3De[1]-n[1],t}function Xt(t){return Math.sqrt(Ut(t))}function =
Ut(t){return t[0]*t[0]+t[1]*t[1]}function Yt(t,e,n){return t[0]=3De[0]*n,t[=
1]=3De[1]*n,t}function Zt(t,e){var n=3DXt(e);return 0=3D=3D=3Dn?(t[0]=3D0,t=
[1]=3D0):(t[0]=3De[0]/n,t[1]=3De[1]/n),t}function qt(t,e){return Math.sqrt(=
(t[0]-e[0])*(t[0]-e[0])+(t[1]-e[1])*(t[1]-e[1]))}var jt=3Dqt;function Kt(t,=
e){return(t[0]-e[0])*(t[0]-e[0])+(t[1]-e[1])*(t[1]-e[1])}var $t=3DKt;functi=
on Qt(t,e,n,i){return t[0]=3De[0]+i*(n[0]-e[0]),t[1]=3De[1]+i*(n[1]-e[1]),t=
}function Jt(t,e,n){var i=3De[0],e=3De[1];return t[0]=3Dn[0]*i+n[2]*e+n[4],=
t[1]=3Dn[1]*i+n[3]*e+n[5],t}function te(t,e,n){return t[0]=3DMath.min(e[0],=
n[0]),t[1]=3DMath.min(e[1],n[1]),t}function ee(t,e,n){return t[0]=3DMath.ma=
x(e[0],n[0]),t[1]=3DMath.max(e[1],n[1]),t}function ne(t,e){this.target=3Dt,=
this.topTarget=3De&&e.topTarget}var ie=3DObject.freeze({__proto__:null,add:=
Wt,applyTransform:Jt,clone:Ht,copy:function(t,e){return t[0]=3De[0],t[1]=3D=
e[1],t},create:Vt,dist:jt,distSquare:$t,distance:qt,distanceSquare:Kt,div:f=
unction(t,e,n){return t[0]=3De[0]/n[0],t[1]=3De[1]/n[1],t},dot:function(t,e=
){return t[0]*e[0]+t[1]*e[1]},len:Xt,lenSquare:Ut,length:Xt,lengthSquare:Ut=
,lerp:Qt,max:ee,min:te,mul:function(t,e,n){return t[0]=3De[0]*n[0],t[1]=3De=
[1]*n[1],t},negate:function(t,e){return t[0]=3D-e[0],t[1]=3D-e[1],t},normal=
ize:Zt,scale:Yt,scaleAndAdd:function(t,e,n,i){return t[0]=3De[0]+n[0]*i,t[1=
]=3De[1]+n[1]*i,t},set:function(t,e,n){return t[0]=3De,t[1]=3Dn,t},sub:Gt})=
,oe=3D(re.prototype._dragStart=3Dfunction(t){for(var e=3Dt.target;e&&!e.dra=
ggable;)e=3De.parent||e.__hostTarget;e&&((this._draggingTarget=3De).draggin=
g=3D!0,this._x=3Dt.offsetX,this._y=3Dt.offsetY,this.handler.dispatchToEleme=
nt(new ne(e,t),"dragstart",t.event))},re.prototype._drag=3Dfunction(t){var =
e,n,i,o,r=3Dthis._draggingTarget;r&&(e=3Dt.offsetX,n=3Dt.offsetY,i=3De-this=
._x,o=3Dn-this._y,this._x=3De,this._y=3Dn,r.drift(i,o,t),this.handler.dispa=
tchToElement(new ne(r,t),"drag",t.event),i=3Dthis.handler.findHover(e,n,r).=
target,o=3Dthis._dropTarget,r!=3D=3D(this._dropTarget=3Di))&&(o&&i!=3D=3Do&=
&this.handler.dispatchToElement(new ne(o,t),"dragleave",t.event),i)&&i!=3D=
=3Do&&this.handler.dispatchToElement(new ne(i,t),"dragenter",t.event)},re.p=
rototype._dragEnd=3Dfunction(t){var e=3Dthis._draggingTarget;e&&(e.dragging=
=3D!1),this.handler.dispatchToElement(new ne(e,t),"dragend",t.event),this._=
dropTarget&&this.handler.dispatchToElement(new ne(this._dropTarget,t),"drop=
",t.event),this._draggingTarget=3Dnull,this._dropTarget=3Dnull},re);functio=
n re(t){(this.handler=3Dt).on("mousedown",this._dragStart,this),t.on("mouse=
move",this._drag,this),t.on("mouseup",this._dragEnd,this)}se.prototype.on=
=3Dfunction(t,e,n,i){this._$handlers||(this._$handlers=3D{});var o=3Dthis._=
$handlers;if("function"=3D=3Dtypeof e&&(i=3Dn,n=3De,e=3Dnull),n&&t){var r=
=3Dthis._$eventProcessor;null!=3De&&r&&r.normalizeQuery&&(e=3Dr.normalizeQu=
ery(e)),o[t]||(o[t]=3D[]);for(var a=3D0;a<o[t].length;a++)if(o[t][a].h=3D=
=3D=3Dn)return this;r=3D{h:n,query:e,ctx:i||this,callAtLast:n.zrEventfulCal=
lAtLast},e=3Do[t].length-1,i=3Do[t][e];i&&i.callAtLast?o[t].splice(e,0,r):o=
[t].push(r)}return this},se.prototype.isSilent=3Dfunction(t){var e=3Dthis._=
$handlers;return!e||!e[t]||!e[t].length},se.prototype.off=3Dfunction(t,e){v=
ar n=3Dthis._$handlers;if(n)if(t)if(e){if(n[t]){for(var i=3D[],o=3D0,r=3Dn[=
t].length;o<r;o++)n[t][o].h!=3D=3De&&i.push(n[t][o]);n[t]=3Di}n[t]&&0=3D=3D=
=3Dn[t].length&&delete n[t]}else delete n[t];else this._$handlers=3D{};retu=
rn this},se.prototype.trigger=3Dfunction(t){for(var e=3D[],n=3D1;n<argument=
s.length;n++)e[n-1]=3Darguments[n];if(this._$handlers){var i=3Dthis._$handl=
ers[t],o=3Dthis._$eventProcessor;if(i)for(var r=3De.length,a=3Di.length,s=
=3D0;s<a;s++){var l=3Di[s];if(!o||!o.filter||null=3D=3Dl.query||o.filter(t,=
l.query))switch(r){case 0:l.h.call(l.ctx);break;case 1:l.h.call(l.ctx,e[0])=
;break;case 2:l.h.call(l.ctx,e[0],e[1]);break;default:l.h.apply(l.ctx,e)}}o=
&&o.afterTrigger&&o.afterTrigger(t)}return this},se.prototype.triggerWithCo=
ntext=3Dfunction(t){for(var e=3D[],n=3D1;n<arguments.length;n++)e[n-1]=3Dar=
guments[n];if(this._$handlers){var i=3Dthis._$handlers[t],o=3Dthis._$eventP=
rocessor;if(i)for(var r=3De.length,a=3De[r-1],s=3Di.length,l=3D0;l<s;l++){v=
ar u=3Di[l];if(!o||!o.filter||null=3D=3Du.query||o.filter(t,u.query))switch=
(r){case 0:u.h.call(a);break;case 1:u.h.call(a,e[0]);break;case 2:u.h.call(=
a,e[0],e[1]);break;default:u.h.apply(a,e.slice(1,r-1))}}o&&o.afterTrigger&&=
o.afterTrigger(t)}return this};var ae=3Dse;function se(t){t&&(this._$eventP=
rocessor=3Dt)}var le=3DMath.log(2);function ue(t,e,n,i,o,r){var a,s=3Di+"-"=
+o,l=3Dt.length;if(r.hasOwnProperty(s))return r[s];if(1=3D=3D=3De)return a=
=3DMath.round(Math.log((1<<l)-1&~o)/le),t[n][a];for(var u=3Di|1<<n,h=3Dn+1;=
i&1<<h;)h++;for(var c=3D0,p=3D0,d=3D0;p<l;p++){var f=3D1<<p;f&o||(c+=3D(d%2=
?-1:1)*t[n][p]*ue(t,e-1,h,u,o|f,r),d++)}return r[s]=3Dc}function he(t,e){va=
r n=3D[[t[0],t[1],1,0,0,0,-e[0]*t[0],-e[0]*t[1]],[0,0,0,t[0],t[1],1,-e[1]*t=
[0],-e[1]*t[1]],[t[2],t[3],1,0,0,0,-e[2]*t[2],-e[2]*t[3]],[0,0,0,t[2],t[3],=
1,-e[3]*t[2],-e[3]*t[3]],[t[4],t[5],1,0,0,0,-e[4]*t[4],-e[4]*t[5]],[0,0,0,t=
[4],t[5],1,-e[5]*t[4],-e[5]*t[5]],[t[6],t[7],1,0,0,0,-e[6]*t[6],-e[6]*t[7]]=
,[0,0,0,t[6],t[7],1,-e[7]*t[6],-e[7]*t[7]]],i=3D{},o=3Due(n,8,0,0,0,i);if(0=
!=3D=3Do){for(var r=3D[],a=3D0;a<8;a++)for(var s=3D0;s<8;s++)null=3D=3Dr[s]=
&&(r[s]=3D0),r[s]+=3D((a+s)%2?-1:1)*ue(n,7,0=3D=3D=3Da?1:0,1<<a,1<<s,i)/o*e=
[a];return function(t,e,n){var i=3De*r[6]+n*r[7]+1;t[0]=3D(e*r[0]+n*r[1]+r[=
2])/i,t[1]=3D(e*r[3]+n*r[4]+r[5])/i}}}var ce=3D"___zrEVENTSAVED",pe=3D[];fu=
nction de(t,e,n,i,o){if(e.getBoundingClientRect&&b.domSupported&&!fe(e)){va=
r r=3De[ce]||(e[ce]=3D{}),e=3Dfunction(t,e,n){for(var i=3Dn?"invTrans":"tra=
ns",o=3De[i],r=3De.srcCoords,a=3D[],s=3D[],l=3D!0,u=3D0;u<4;u++){var h=3Dt[=
u].getBoundingClientRect(),c=3D2*u,p=3Dh.left,h=3Dh.top;a.push(p,h),l=3Dl&&=
r&&p=3D=3D=3Dr[c]&&h=3D=3D=3Dr[1+c],s.push(t[u].offsetLeft,t[u].offsetTop)}=
return l&&o?o:(e.srcCoords=3Da,e[i]=3Dn?he(s,a):he(a,s))}(function(t,e){var=
 n=3De.markers;if(!n){n=3De.markers=3D[];for(var i=3D["left","right"],o=3D[=
"top","bottom"],r=3D0;r<4;r++){var a=3Ddocument.createElement("div"),s=3Dr%=
2,l=3D(r>>1)%2;a.style.cssText=3D["position: absolute","visibility: hidden"=
,"padding: 0","margin: 0","border-width: 0","user-select: none","width:0","=
height:0",i[s]+":0",o[l]+":0",i[1-s]+":auto",o[1-l]+":auto",""].join("!impo=
rtant;"),t.appendChild(a),n.push(a)}}return n}(e,r),r,o);if(e)return e(t,n,=
i),!0}return!1}function fe(t){return"CANVAS"=3D=3D=3Dt.nodeName.toUpperCase=
()}var ge=3D/([&<>"'])/g,ye=3D{"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot=
;","'":"&#39;"};function me(t){return null=3D=3Dt?"":(t+"").replace(ge,func=
tion(t,e){return ye[e]})}var ve=3D/^(?:mouse|pointer|contextmenu|drag|drop)=
|click/,_e=3D[],xe=3Db.browser.firefox&&+b.browser.version.split(".")[0]<39=
;function we(t,e,n,i){return n=3Dn||{},i?be(t,e,n):xe&&null!=3De.layerX&&e.=
layerX!=3D=3De.offsetX?(n.zrX=3De.layerX,n.zrY=3De.layerY):null!=3De.offset=
X?(n.zrX=3De.offsetX,n.zrY=3De.offsetY):be(t,e,n),n}function be(t,e,n){if(b=
.domSupported&&t.getBoundingClientRect){var i,o=3De.clientX,e=3De.clientY;i=
f(fe(t))return i=3Dt.getBoundingClientRect(),n.zrX=3Do-i.left,n.zrY=3De-i.t=
op;if(de(_e,t,o,e))return n.zrX=3D_e[0],n.zrY=3D_e[1]}n.zrX=3Dn.zrY=3D0}fun=
ction Se(t){return t||window.event}function Me(t,e,n){var i;return null=3D=
=3D(e=3DSe(e)).zrX&&((i=3De.type)&&0<=3Di.indexOf("touch")?(i=3D("touchend"=
!=3D=3Di?e.targetTouches:e.changedTouches)[0])&&we(t,i,e,n):(we(t,e,e,n),t=
=3D(t=3D(i=3De).wheelDelta)||(n=3Di.deltaX,i=3Di.deltaY,null=3D=3Dn||null=
=3D=3Di?t:3*(0!=3D=3Di?Math.abs(i):Math.abs(n))*(0<i||!(i<0)&&0<n?-1:1)),e.=
zrDelta=3Dt?t/120:-(e.detail||0)/3),i=3De.button,null=3D=3De.which&&void 0!=
=3D=3Di&&ve.test(e.type))&&(e.which=3D1&i?1:2&i?3:4&i?2:0),e}var Te=3Dfunct=
ion(t){t.preventDefault(),t.stopPropagation(),t.cancelBubble=3D!0};function=
 Ie(t){return 2=3D=3D=3Dt.which||3=3D=3D=3Dt.which}De.prototype.recognize=
=3Dfunction(t,e,n){return this._doTrack(t,e,n),this._recognize(t)},De.proto=
type.clear=3Dfunction(){return this._track.length=3D0,this},De.prototype._d=
oTrack=3Dfunction(t,e,n){var i=3Dt.touches;if(i){for(var o=3D{points:[],tou=
ches:[],target:e,event:t},r=3D0,a=3Di.length;r<a;r++){var s=3Di[r],l=3Dwe(n=
,s,{});o.points.push([l.zrX,l.zrY]),o.touches.push(s)}this._track.push(o)}}=
,De.prototype._recognize=3Dfunction(t){for(var e in Ae)if(Ae.hasOwnProperty=
(e)){e=3DAe[e](this._track,t);if(e)return e}};var Ce=3DDe;function De(){thi=
s._track=3D[]}function ke(t){var e=3Dt[1][0]-t[0][0],t=3Dt[1][1]-t[0][1];re=
turn Math.sqrt(e*e+t*t)}var Ae=3D{pinch:function(t,e){var n=3Dt.length;if(n=
){var i=3D(t[n-1]||{}).points,n=3D(t[n-2]||{}).points||i;if(n&&1<n.length&&=
i&&1<i.length)return n=3Dke(i)/ke(n),isFinite(n)||(n=3D1),e.pinchScale=3Dn,=
n=3D[(i[0][0]+i[1][0])/2,(i[0][1]+i[1][1])/2],e.pinchX=3Dn[0],e.pinchY=3Dn[=
1],{type:"pinch",target:t[0].target,event:e}}}};function Le(){return[1,0,0,=
1,0,0]}function Pe(t){return t[0]=3D1,t[1]=3D0,t[2]=3D0,t[3]=3D1,t[4]=3D0,t=
[5]=3D0,t}function Oe(t,e){return t[0]=3De[0],t[1]=3De[1],t[2]=3De[2],t[3]=
=3De[3],t[4]=3De[4],t[5]=3De[5],t}function Re(t,e,n){var i=3De[0]*n[0]+e[2]=
*n[1],o=3De[1]*n[0]+e[3]*n[1],r=3De[0]*n[2]+e[2]*n[3],a=3De[1]*n[2]+e[3]*n[=
3],s=3De[0]*n[4]+e[2]*n[5]+e[4],n=3De[1]*n[4]+e[3]*n[5]+e[5];return t[0]=3D=
i,t[1]=3Do,t[2]=3Dr,t[3]=3Da,t[4]=3Ds,t[5]=3Dn,t}function Ne(t,e,n){return =
t[0]=3De[0],t[1]=3De[1],t[2]=3De[2],t[3]=3De[3],t[4]=3De[4]+n[0],t[5]=3De[5=
]+n[1],t}function Ee(t,e,n,i){void 0=3D=3D=3Di&&(i=3D[0,0]);var o=3De[0],r=
=3De[2],a=3De[4],s=3De[1],l=3De[3],e=3De[5],u=3DMath.sin(n),n=3DMath.cos(n)=
;return t[0]=3Do*n+s*u,t[1]=3D-o*u+s*n,t[2]=3Dr*n+l*u,t[3]=3D-r*u+n*l,t[4]=
=3Dn*(a-i[0])+u*(e-i[1])+i[0],t[5]=3Dn*(e-i[1])-u*(a-i[0])+i[1],t}function =
ze(t,e,n){var i=3Dn[0],n=3Dn[1];return t[0]=3De[0]*i,t[1]=3De[1]*n,t[2]=3De=
[2]*i,t[3]=3De[3]*n,t[4]=3De[4]*i,t[5]=3De[5]*n,t}function Be(t,e){var n=3D=
e[0],i=3De[2],o=3De[4],r=3De[1],a=3De[3],e=3De[5],s=3Dn*a-r*i;return s?(t[0=
]=3Da*(s=3D1/s),t[1]=3D-r*s,t[2]=3D-i*s,t[3]=3Dn*s,t[4]=3D(i*e-a*o)*s,t[5]=
=3D(r*o-n*e)*s,t):null}var Fe=3DObject.freeze({__proto__:null,clone:functio=
n(t){var e=3DLe();return Oe(e,t),e},copy:Oe,create:Le,identity:Pe,invert:Be=
,mul:Re,rotate:Ee,scale:ze,translate:Ne}),z=3D(Ve.prototype.copy=3Dfunction=
(t){return this.x=3Dt.x,this.y=3Dt.y,this},Ve.prototype.clone=3Dfunction(){=
return new Ve(this.x,this.y)},Ve.prototype.set=3Dfunction(t,e){return this.=
x=3Dt,this.y=3De,this},Ve.prototype.equal=3Dfunction(t){return t.x=3D=3D=3D=
this.x&&t.y=3D=3D=3Dthis.y},Ve.prototype.add=3Dfunction(t){return this.x+=
=3Dt.x,this.y+=3Dt.y,this},Ve.prototype.scale=3Dfunction(t){this.x*=3Dt,thi=
s.y*=3Dt},Ve.prototype.scaleAndAdd=3Dfunction(t,e){this.x+=3Dt.x*e,this.y+=
=3Dt.y*e},Ve.prototype.sub=3Dfunction(t){return this.x-=3Dt.x,this.y-=3Dt.y=
,this},Ve.prototype.dot=3Dfunction(t){return this.x*t.x+this.y*t.y},Ve.prot=
otype.len=3Dfunction(){return Math.sqrt(this.x*this.x+this.y*this.y)},Ve.pr=
ototype.lenSquare=3Dfunction(){return this.x*this.x+this.y*this.y},Ve.proto=
type.normalize=3Dfunction(){var t=3Dthis.len();return this.x/=3Dt,this.y/=
=3Dt,this},Ve.prototype.distance=3Dfunction(t){var e=3Dthis.x-t.x,t=3Dthis.=
y-t.y;return Math.sqrt(e*e+t*t)},Ve.prototype.distanceSquare=3Dfunction(t){=
var e=3Dthis.x-t.x,t=3Dthis.y-t.y;return e*e+t*t},Ve.prototype.negate=3Dfun=
ction(){return this.x=3D-this.x,this.y=3D-this.y,this},Ve.prototype.transfo=
rm=3Dfunction(t){var e,n;if(t)return e=3Dthis.x,n=3Dthis.y,this.x=3Dt[0]*e+=
t[2]*n+t[4],this.y=3Dt[1]*e+t[3]*n+t[5],this},Ve.prototype.toArray=3Dfuncti=
on(t){return t[0]=3Dthis.x,t[1]=3Dthis.y,t},Ve.prototype.fromArray=3Dfuncti=
on(t){this.x=3Dt[0],this.y=3Dt[1]},Ve.set=3Dfunction(t,e,n){t.x=3De,t.y=3Dn=
},Ve.copy=3Dfunction(t,e){t.x=3De.x,t.y=3De.y},Ve.len=3Dfunction(t){return =
Math.sqrt(t.x*t.x+t.y*t.y)},Ve.lenSquare=3Dfunction(t){return t.x*t.x+t.y*t=
.y},Ve.dot=3Dfunction(t,e){return t.x*e.x+t.y*e.y},Ve.add=3Dfunction(t,e,n)=
{t.x=3De.x+n.x,t.y=3De.y+n.y},Ve.sub=3Dfunction(t,e,n){t.x=3De.x-n.x,t.y=3D=
e.y-n.y},Ve.scale=3Dfunction(t,e,n){t.x=3De.x*n,t.y=3De.y*n},Ve.scaleAndAdd=
=3Dfunction(t,e,n,i){t.x=3De.x+n.x*i,t.y=3De.y+n.y*i},Ve.lerp=3Dfunction(t,=
e,n,i){var o=3D1-i;t.x=3Do*e.x+i*n.x,t.y=3Do*e.y+i*n.y},Ve);function Ve(t,e=
){this.x=3Dt||0,this.y=3De||0}var He=3DMath.min,We=3DMath.max,Ge=3Dnew z,Xe=
=3Dnew z,Ue=3Dnew z,Ye=3Dnew z,Ze=3Dnew z,qe=3Dnew z,G=3D(je.prototype.unio=
n=3Dfunction(t){var e=3DHe(t.x,this.x),n=3DHe(t.y,this.y);isFinite(this.x)&=
&isFinite(this.width)?this.width=3DWe(t.x+t.width,this.x+this.width)-e:this=
.width=3Dt.width,isFinite(this.y)&&isFinite(this.height)?this.height=3DWe(t=
.y+t.height,this.y+this.height)-n:this.height=3Dt.height,this.x=3De,this.y=
=3Dn},je.prototype.applyTransform=3Dfunction(t){je.applyTransform(this,this=
,t)},je.prototype.calculateTransform=3Dfunction(t){var e=3Dt.width/this.wid=
th,n=3Dt.height/this.height,i=3DLe();return Ne(i,i,[-this.x,-this.y]),ze(i,=
i,[e,n]),Ne(i,i,[t.x,t.y]),i},je.prototype.intersect=3Dfunction(t,e){if(!t)=
return!1;t instanceof je||(t=3Dje.create(t));var n,i,o,r,a,s,l,u,h=3Dthis,c=
=3Dh.x,p=3Dh.x+h.width,d=3Dh.y,h=3Dh.y+h.height,f=3Dt.x,g=3Dt.x+t.width,y=
=3Dt.y,t=3Dt.y+t.height,m=3D!(p<f||g<c||h<y||t<d);return e&&(n=3D1/0,i=3D0,=
o=3DMath.abs(p-f),r=3DMath.abs(g-c),a=3DMath.abs(h-y),s=3DMath.abs(t-d),l=
=3DMath.min(o,r),u=3DMath.min(a,s),p<f||g<c?i<l&&(i=3Dl,o<r?z.set(qe,-o,0):=
z.set(qe,r,0)):l<n&&(n=3Dl,o<r?z.set(Ze,o,0):z.set(Ze,-r,0)),h<y||t<d?i<u&&=
(i=3Du,a<s?z.set(qe,0,-a):z.set(qe,0,s)):l<n&&(n=3Dl,a<s?z.set(Ze,0,a):z.se=
t(Ze,0,-s))),e&&z.copy(e,m?Ze:qe),m},je.prototype.contain=3Dfunction(t,e){v=
ar n=3Dthis;return t>=3Dn.x&&t<=3Dn.x+n.width&&e>=3Dn.y&&e<=3Dn.y+n.height}=
,je.prototype.clone=3Dfunction(){return new je(this.x,this.y,this.width,thi=
s.height)},je.prototype.copy=3Dfunction(t){je.copy(this,t)},je.prototype.pl=
ain=3Dfunction(){return{x:this.x,y:this.y,width:this.width,height:this.heig=
ht}},je.prototype.isFinite=3Dfunction(){return isFinite(this.x)&&isFinite(t=
his.y)&&isFinite(this.width)&&isFinite(this.height)},je.prototype.isZero=3D=
function(){return 0=3D=3D=3Dthis.width||0=3D=3D=3Dthis.height},je.create=3D=
function(t){return new je(t.x,t.y,t.width,t.height)},je.copy=3Dfunction(t,e=
){t.x=3De.x,t.y=3De.y,t.width=3De.width,t.height=3De.height},je.applyTransf=
orm=3Dfunction(t,e,n){var i,o,r,a;n?n[1]<1e-5&&-1e-5<n[1]&&n[2]<1e-5&&-1e-5=
<n[2]?(i=3Dn[0],o=3Dn[3],r=3Dn[4],a=3Dn[5],t.x=3De.x*i+r,t.y=3De.y*o+a,t.wi=
dth=3De.width*i,t.height=3De.height*o,t.width<0&&(t.x+=3Dt.width,t.width=3D=
-t.width),t.height<0&&(t.y+=3Dt.height,t.height=3D-t.height)):(Ge.x=3DUe.x=
=3De.x,Ge.y=3DYe.y=3De.y,Xe.x=3DYe.x=3De.x+e.width,Xe.y=3DUe.y=3De.y+e.heig=
ht,Ge.transform(n),Ye.transform(n),Xe.transform(n),Ue.transform(n),t.x=3DHe=
(Ge.x,Xe.x,Ue.x,Ye.x),t.y=3DHe(Ge.y,Xe.y,Ue.y,Ye.y),r=3DWe(Ge.x,Xe.x,Ue.x,Y=
e.x),a=3DWe(Ge.y,Xe.y,Ue.y,Ye.y),t.width=3Dr-t.x,t.height=3Da-t.y):t!=3D=3D=
e&&je.copy(t,e)},je);function je(t,e,n,i){n<0&&(t+=3Dn,n=3D-n),i<0&&(e+=3Di=
,i=3D-i),this.x=3Dt,this.y=3De,this.width=3Dn,this.height=3Di}var Ke=3D"sil=
ent";function $e(){Te(this.event)}function Qe(t,e){this.x=3Dt,this.y=3De}u(=
sn,tn=3Dae),sn.prototype.dispose=3Dfunction(){},sn.prototype.setCursor=3Dfu=
nction(){};var Je,tn,en=3Dsn,nn=3D["click","dblclick","mousewheel","mouseou=
t","mouseup","mousedown","mousemove","contextmenu"],on=3Dnew G(0,0,0,0),rn=
=3D(u(an,Je=3Dae),an.prototype.setHandlerProxy=3Dfunction(e){this.proxy&&th=
is.proxy.dispose(),e&&(E(nn,function(t){e.on&&e.on(t,this[t],this)},this),e=
.handler=3Dthis),this.proxy=3De},an.prototype.mousemove=3Dfunction(t){var e=
=3Dt.zrX,n=3Dt.zrY,i=3Dun(this,e,n),o=3Dthis._hovered,r=3Do.target,i=3D(r&&=
!r.__zr&&(r=3D(o=3Dthis.findHover(o.x,o.y)).target),this._hovered=3Di?new Q=
e(e,n):this.findHover(e,n)),e=3Di.target,n=3Dthis.proxy;n.setCursor&&n.setC=
ursor(e?e.cursor:"default"),r&&e!=3D=3Dr&&this.dispatchToElement(o,"mouseou=
t",t),this.dispatchToElement(i,"mousemove",t),e&&e!=3D=3Dr&&this.dispatchTo=
Element(i,"mouseover",t)},an.prototype.mouseout=3Dfunction(t){var e=3Dt.zrE=
ventControl;"only_globalout"!=3D=3De&&this.dispatchToElement(this._hovered,=
"mouseout",t),"no_globalout"!=3D=3De&&this.trigger("globalout",{type:"globa=
lout",event:t})},an.prototype.resize=3Dfunction(){this._hovered=3Dnew Qe(0,=
0)},an.prototype.dispatch=3Dfunction(t,e){t=3Dthis[t];t&&t.call(this,e)},an=
.prototype.dispose=3Dfunction(){this.proxy.dispose(),this.storage=3Dnull,th=
is.proxy=3Dnull,this.painter=3Dnull},an.prototype.setCursorStyle=3Dfunction=
(t){var e=3Dthis.proxy;e.setCursor&&e.setCursor(t)},an.prototype.dispatchTo=
Element=3Dfunction(t,e,n){var i=3D(t=3Dt||{}).target;if(!i||!i.silent){for(=
var o=3D"on"+e,r=3D{type:e,event:n,target:(t=3Dt).target,topTarget:t.topTar=
get,cancelBubble:!1,offsetX:n.zrX,offsetY:n.zrY,gestureEvent:n.gestureEvent=
,pinchX:n.pinchX,pinchY:n.pinchY,pinchScale:n.pinchScale,wheelDelta:n.zrDel=
ta,zrByTouch:n.zrByTouch,which:n.which,stop:$e};i&&(i[o]&&(r.cancelBubble=
=3D!!i[o].call(i,r)),i.trigger(e,r),i=3Di.__hostTarget||i.parent,!r.cancelB=
ubble););r.cancelBubble||(this.trigger(e,r),this.painter&&this.painter.each=
OtherLayer&&this.painter.eachOtherLayer(function(t){"function"=3D=3Dtypeof =
t[o]&&t[o].call(t,r),t.trigger&&t.trigger(e,r)}))}},an.prototype.findHover=
=3Dfunction(t,e,n){var i=3Dthis.storage.getDisplayList(),o=3Dnew Qe(t,e);if=
(ln(i,o,t,e,n),this._pointerSize&&!o.target){for(var r=3D[],a=3Dthis._point=
erSize,s=3Da/2,l=3Dnew G(t-s,e-s,a,a),u=3Di.length-1;0<=3Du;u--){var h=3Di[=
u];h=3D=3D=3Dn||h.ignore||h.ignoreCoarsePointer||h.parent&&h.parent.ignoreC=
oarsePointer||(on.copy(h.getBoundingRect()),h.transform&&on.applyTransform(=
h.transform),on.intersect(l)&&r.push(h))}if(r.length)for(var c=3DMath.PI/12=
,p=3D2*Math.PI,d=3D0;d<s;d+=3D4)for(var f=3D0;f<p;f+=3Dc)if(ln(r,o,t+d*Math=
.cos(f),e+d*Math.sin(f),n),o.target)return o}return o},an.prototype.process=
Gesture=3Dfunction(t,e){this._gestureMgr||(this._gestureMgr=3Dnew Ce);var n=
=3Dthis._gestureMgr,i=3D("start"=3D=3D=3De&&n.clear(),n.recognize(t,this.fi=
ndHover(t.zrX,t.zrY,null).target,this.proxy.dom));"end"=3D=3D=3De&&n.clear(=
),i&&(e=3Di.type,t.gestureEvent=3De,(n=3Dnew Qe).target=3Di.target,this.dis=
patchToElement(n,e,i.event))},an);function an(t,e,n,i,o){var r=3DJe.call(th=
is)||this;return r._hovered=3Dnew Qe(0,0),r.storage=3Dt,r.painter=3De,r.pai=
nterRoot=3Di,r._pointerSize=3Do,n=3Dn||new en,r.proxy=3Dnull,r.setHandlerPr=
oxy(n),r._draggingMgr=3Dnew oe(r),r}function sn(){var t=3Dnull!=3D=3Dtn&&tn=
.apply(this,arguments)||this;return t.handler=3Dnull,t}function ln(t,e,n,i,=
o){for(var r=3Dt.length-1;0<=3Dr;r--){var a=3Dt[r],s=3Dvoid 0;if(a!=3D=3Do&=
&!a.ignore&&(s=3Dfunction(t,e,n){if(t[t.rectHover?"rectContain":"contain"](=
e,n)){for(var i=3Dt,o=3Dvoid 0,r=3D!1;i;){if(!(r=3Di.ignoreClip?!0:r)){var =
a=3Di.getClipPath();if(a&&!a.contain(e,n))return!1}i.silent&&(o=3D!0);i=3Di=
.__hostTarget||i.parent}return!o||Ke}return!1}(a,n,i))&&(e.topTarget||(e.to=
pTarget=3Da),s!=3D=3DKe)){e.target=3Da;break}}}function un(t,e,n){t=3Dt.pai=
nter;return e<0||e>t.getWidth()||n<0||n>t.getHeight()}E(["click","mousedown=
","mouseup","mousewheel","dblclick","contextmenu"],function(a){rn.prototype=
[a]=3Dfunction(t){var e,n,i=3Dt.zrX,o=3Dt.zrY,r=3Dun(this,i,o);if("mouseup"=
=3D=3D=3Da&&r||(n=3D(e=3Dthis.findHover(i,o)).target),"mousedown"=3D=3D=3Da=
)this._downEl=3Dn,this._downPoint=3D[t.zrX,t.zrY],this._upEl=3Dn;else if("m=
ouseup"=3D=3D=3Da)this._upEl=3Dn;else if("click"=3D=3D=3Da){if(this._downEl=
!=3D=3Dthis._upEl||!this._downPoint||4<jt(this._downPoint,[t.zrX,t.zrY]))re=
turn;this._downPoint=3Dnull}this.dispatchToElement(e,a,t)}});var hn=3D32,cn=
=3D7;function pn(t,e,n,i){var o=3De+1;if(o=3D=3D=3Dn)return 1;if(i(t[o++],t=
[e])<0){for(;o<n&&i(t[o],t[o-1])<0;)o++;var r=3Dt,a=3De,s=3Do;for(s--;a<s;)=
{var l=3Dr[a];r[a++]=3Dr[s],r[s--]=3Dl}}else for(;o<n&&0<=3Di(t[o],t[o-1]);=
)o++;return o-e}function dn(t,e,n,i,o){for(i=3D=3D=3De&&i++;i<n;i++){for(va=
r r,a=3Dt[i],s=3De,l=3Di;s<l;)o(a,t[r=3Ds+l>>>1])<0?l=3Dr:s=3D1+r;var u=3Di=
-s;switch(u){case 3:t[s+3]=3Dt[s+2];case 2:t[s+2]=3Dt[s+1];case 1:t[s+1]=3D=
t[s];break;default:for(;0<u;)t[s+u]=3Dt[s+u-1],u--}t[s]=3Da}}function fn(t,=
e,n,i,o,r){var a=3D0,s=3D0,l=3D1;if(0<r(t,e[n+o])){for(s=3Di-o;l<s&&0<r(t,e=
[n+o+l]);)(l=3D1+((a=3Dl)<<1))<=3D0&&(l=3Ds);s<l&&(l=3Ds),a+=3Do,l+=3Do}els=
e{for(s=3Do+1;l<s&&r(t,e[n+o-l])<=3D0;)(l=3D1+((a=3Dl)<<1))<=3D0&&(l=3Ds);i=
=3Da,a=3Do-(l=3Ds<l?s:l),l=3Do-i}for(a++;a<l;){var u=3Da+(l-a>>>1);0<r(t,e[=
n+u])?a=3Du+1:l=3Du}return l}function gn(t,e,n,i,o,r){var a=3D0,s=3D0,l=3D1=
;if(r(t,e[n+o])<0){for(s=3Do+1;l<s&&r(t,e[n+o-l])<0;)(l=3D1+((a=3Dl)<<1))<=
=3D0&&(l=3Ds);var u=3Da,a=3Do-(l=3Ds<l?s:l),l=3Do-u}else{for(s=3Di-o;l<s&&0=
<=3Dr(t,e[n+o+l]);)(l=3D1+((a=3Dl)<<1))<=3D0&&(l=3Ds);s<l&&(l=3Ds),a+=3Do,l=
+=3Do}for(a++;a<l;){var h=3Da+(l-a>>>1);r(t,e[n+h])<0?l=3Dh:a=3Dh+1}return =
l}function yn(t,e,n,i){var f,g,r,a,y,s,m,o=3D(i=3Di||t.length)-(n=3Dn||0);i=
f(!(o<2)){var l=3D0;if(o<hn)dn(t,n,i,n+(l=3Dpn(t,n,i,e)),e);else{f=3Dt,g=3D=
e,y=3Dcn,s=3D0,m=3D[],r=3D[],a=3D[];var u,h=3D{mergeRuns:function(){for(;1<=
s;){var t=3Ds-2;if(1<=3Dt&&a[t-1]<=3Da[t]+a[t+1]||2<=3Dt&&a[t-2]<=3Da[t]+a[=
t-1])a[t-1]<a[t+1]&&t--;else if(a[t]>a[t+1])break;p(t)}},forceMergeRuns:fun=
ction(){for(;1<s;){var t=3Ds-2;0<t&&a[t-1]<a[t+1]&&t--,p(t)}},pushRun:funct=
ion(t,e){r[s]=3Dt,a[s]=3De,s+=3D1}},c=3Dfunction(t){for(var e=3D0;hn<=3Dt;)=
e|=3D1&t,t>>=3D1;return t+e}(o);do{}while((l=3Dpn(t,n,i,e))<c&&(dn(t,n,n+(u=
=3Dc<(u=3Do)?c:o),n+l,e),l=3Du),h.pushRun(n,l),h.mergeRuns(),n+=3Dl,0!=3D=
=3D(o-=3Dl));h.forceMergeRuns()}}function p(t){var e=3Dr[t],n=3Da[t],i=3Dr[=
t+1],o=3Da[t+1],t=3D(a[t]=3Dn+o,t=3D=3D=3Ds-3&&(r[t+1]=3Dr[t+2],a[t+1]=3Da[=
t+2]),s--,gn(f[i],f,e,n,0,g));e+=3Dt,0!=3D(n-=3Dt)&&0!=3D=3D(o=3Dfn(f[e+n-1=
],f,i,o,o-1,g))&&(n<=3Do?function(t,e,n,i){for(var o=3D0,o=3D0;o<e;o++)m[o]=
=3Df[t+o];var r=3D0,a=3Dn,s=3Dt;if(f[s++]=3Df[a++],0=3D=3D--i)for(o=3D0;o<e=
;o++)f[s+o]=3Dm[r+o];else{if(1=3D=3D=3De){for(o=3D0;o<i;o++)f[s+o]=3Df[a+o]=
;return f[s+i]=3Dm[r]}for(var l,u,h,c=3Dy;;){u=3Dl=3D0,h=3D!1;do{if(g(f[a],=
m[r])<0){if(f[s++]=3Df[a++],u++,(l=3D0)=3D=3D--i){h=3D!0;break}}else if(f[s=
++]=3Dm[r++],l++,u=3D0,1=3D=3D--e){h=3D!0;break}}while((l|u)<c);if(h)break;=
do{if(0!=3D=3D(l=3Dgn(f[a],m,r,e,0,g))){for(o=3D0;o<l;o++)f[s+o]=3Dm[r+o];i=
f(s+=3Dl,r+=3Dl,(e-=3Dl)<=3D1){h=3D!0;break}}if(f[s++]=3Df[a++],0=3D=3D--i)=
{h=3D!0;break}if(0!=3D=3D(u=3Dfn(m[r],f,a,i,0,g))){for(o=3D0;o<u;o++)f[s+o]=
=3Df[a+o];if(s+=3Du,a+=3Du,0=3D=3D(i-=3Du)){h=3D!0;break}}if(f[s++]=3Dm[r++=
],1=3D=3D--e){h=3D!0;break}}while(c--,cn<=3Dl||cn<=3Du);if(h)break;c<0&&(c=
=3D0),c+=3D2}if((y=3Dc)<1&&(y=3D1),1=3D=3D=3De){for(o=3D0;o<i;o++)f[s+o]=3D=
f[a+o];f[s+i]=3Dm[r]}else{if(0=3D=3D=3De)throw new Error;for(o=3D0;o<e;o++)=
f[s+o]=3Dm[r+o]}}}:function(t,e,n,i){for(var o=3D0,o=3D0;o<i;o++)m[o]=3Df[n=
+o];var r=3Dt+e-1,a=3Di-1,s=3Dn+i-1,l=3D0,u=3D0;if(f[s--]=3Df[r--],0=3D=3D-=
-e)for(l=3Ds-(i-1),o=3D0;o<i;o++)f[l+o]=3Dm[o];else{if(1=3D=3D=3Di){for(u=
=3D1+(s-=3De),l=3D1+(r-=3De),o=3De-1;0<=3Do;o--)f[u+o]=3Df[l+o];return f[s]=
=3Dm[a]}for(var h=3Dy;;){var c=3D0,p=3D0,d=3D!1;do{if(g(m[a],f[r])<0){if(f[=
s--]=3Df[r--],c++,(p=3D0)=3D=3D--e){d=3D!0;break}}else if(f[s--]=3Dm[a--],p=
++,c=3D0,1=3D=3D--i){d=3D!0;break}}while((c|p)<h);if(d)break;do{if(0!=3D(c=
=3De-gn(m[a],f,t,e,e-1,g))){for(e-=3Dc,u=3D1+(s-=3Dc),l=3D1+(r-=3Dc),o=3Dc-=
1;0<=3Do;o--)f[u+o]=3Df[l+o];if(0=3D=3D=3De){d=3D!0;break}}if(f[s--]=3Dm[a-=
-],1=3D=3D--i){d=3D!0;break}if(0!=3D(p=3Di-fn(f[r],m,0,i,i-1,g))){for(i-=3D=
p,u=3D1+(s-=3Dp),l=3D1+(a-=3Dp),o=3D0;o<p;o++)f[u+o]=3Dm[l+o];if(i<=3D1){d=
=3D!0;break}}if(f[s--]=3Df[r--],0=3D=3D--e){d=3D!0;break}}while(h--,cn<=3Dc=
||cn<=3Dp);if(d)break;h<0&&(h=3D0),h+=3D2}if((y=3Dh)<1&&(y=3D1),1=3D=3D=3Di=
){for(u=3D1+(s-=3De),l=3D1+(r-=3De),o=3De-1;0<=3Do;o--)f[u+o]=3Df[l+o];f[s]=
=3Dm[a]}else{if(0=3D=3D=3Di)throw new Error;for(l=3Ds-(i-1),o=3D0;o<i;o++)f=
[l+o]=3Dm[o]}}})(e,n,i,o)}}var mn=3D1,vn=3D4,_n=3D!1;function xn(){_n||(_n=
=3D!0,console.warn("z / z2 / zlevel of displayable is invalid, which may ca=
use unexpected errors"))}function wn(t,e){return t.zlevel=3D=3D=3De.zlevel?=
t.z=3D=3D=3De.z?t.z2-e.z2:t.z-e.z:t.zlevel-e.zlevel}Sn.prototype.traverse=
=3Dfunction(t,e){for(var n=3D0;n<this._roots.length;n++)this._roots[n].trav=
erse(t,e)},Sn.prototype.getDisplayList=3Dfunction(t,e){e=3De||!1;var n=3Dth=
is._displayList;return!t&&n.length||this.updateDisplayList(e),n},Sn.prototy=
pe.updateDisplayList=3Dfunction(t){this._displayListLen=3D0;for(var e=3Dthi=
s._roots,n=3Dthis._displayList,i=3D0,o=3De.length;i<o;i++)this._updateAndAd=
dDisplayable(e[i],null,t);n.length=3Dthis._displayListLen,yn(n,wn)},Sn.prot=
otype._updateAndAddDisplayable=3Dfunction(t,e,n){if(!t.ignore||n){t.beforeU=
pdate(),t.update(),t.afterUpdate();var i=3Dt.getClipPath();if(t.ignoreClip)=
e=3Dnull;else if(i){e=3De?e.slice():[];for(var o=3Di,r=3Dt;o;)o.parent=3Dr,=
o.updateTransform(),e.push(o),o=3D(r=3Do).getClipPath()}if(t.childrenRef){f=
or(var a=3Dt.childrenRef(),s=3D0;s<a.length;s++){var l=3Da[s];t.__dirty&&(l=
.__dirty|=3Dmn),this._updateAndAddDisplayable(l,e,n)}t.__dirty=3D0}else{i=
=3Dt;e&&e.length?i.__clipPaths=3De:i.__clipPaths&&0<i.__clipPaths.length&&(=
i.__clipPaths=3D[]),isNaN(i.z)&&(xn(),i.z=3D0),isNaN(i.z2)&&(xn(),i.z2=3D0)=
,isNaN(i.zlevel)&&(xn(),i.zlevel=3D0),this._displayList[this._displayListLe=
n++]=3Di}i=3Dt.getDecalElement&&t.getDecalElement(),i=3D(i&&this._updateAnd=
AddDisplayable(i,e,n),t.getTextGuideLine()),i=3D(i&&this._updateAndAddDispl=
ayable(i,e,n),t.getTextContent());i&&this._updateAndAddDisplayable(i,e,n)}}=
,Sn.prototype.addRoot=3Dfunction(t){t.__zr&&t.__zr.storage=3D=3D=3Dthis||th=
is._roots.push(t)},Sn.prototype.delRoot=3Dfunction(t){if(t instanceof Array=
)for(var e=3D0,n=3Dt.length;e<n;e++)this.delRoot(t[e]);else{var i=3DC(this.=
_roots,t);0<=3Di&&this._roots.splice(i,1)}},Sn.prototype.delAllRoots=3Dfunc=
tion(){this._roots=3D[],this._displayList=3D[],this._displayListLen=3D0},Sn=
.prototype.getRoots=3Dfunction(){return this._roots},Sn.prototype.dispose=
=3Dfunction(){this._displayList=3Dnull,this._roots=3Dnull};var bn=3DSn;func=
tion Sn(){this._roots=3D[],this._displayList=3D[],this._displayListLen=3D0,=
this.displayableSortFunc=3Dwn}var Mn=3Db.hasGlobalWindow&&(window.requestAn=
imationFrame&&window.requestAnimationFrame.bind(window)||window.msRequestAn=
imationFrame&&window.msRequestAnimationFrame.bind(window)||window.mozReques=
tAnimationFrame||window.webkitRequestAnimationFrame)||function(t){return se=
tTimeout(t,16)},Tn=3D{linear:function(t){return t},quadraticIn:function(t){=
return t*t},quadraticOut:function(t){return t*(2-t)},quadraticInOut:functio=
n(t){return(t*=3D2)<1?.5*t*t:-.5*(--t*(t-2)-1)},cubicIn:function(t){return =
t*t*t},cubicOut:function(t){return--t*t*t+1},cubicInOut:function(t){return(=
t*=3D2)<1?.5*t*t*t:.5*((t-=3D2)*t*t+2)},quarticIn:function(t){return t*t*t*=
t},quarticOut:function(t){return 1- --t*t*t*t},quarticInOut:function(t){ret=
urn(t*=3D2)<1?.5*t*t*t*t:-.5*((t-=3D2)*t*t*t-2)},quinticIn:function(t){retu=
rn t*t*t*t*t},quinticOut:function(t){return--t*t*t*t*t+1},quinticInOut:func=
tion(t){return(t*=3D2)<1?.5*t*t*t*t*t:.5*((t-=3D2)*t*t*t*t+2)},sinusoidalIn=
:function(t){return 1-Math.cos(t*Math.PI/2)},sinusoidalOut:function(t){retu=
rn Math.sin(t*Math.PI/2)},sinusoidalInOut:function(t){return.5*(1-Math.cos(=
Math.PI*t))},exponentialIn:function(t){return 0=3D=3D=3Dt?0:Math.pow(1024,t=
-1)},exponentialOut:function(t){return 1=3D=3D=3Dt?1:1-Math.pow(2,-10*t)},e=
xponentialInOut:function(t){return 0=3D=3D=3Dt?0:1=3D=3D=3Dt?1:(t*=3D2)<1?.=
5*Math.pow(1024,t-1):.5*(2-Math.pow(2,-10*(t-1)))},circularIn:function(t){r=
eturn 1-Math.sqrt(1-t*t)},circularOut:function(t){return Math.sqrt(1- --t*t=
)},circularInOut:function(t){return(t*=3D2)<1?-.5*(Math.sqrt(1-t*t)-1):.5*(=
Math.sqrt(1-(t-=3D2)*t)+1)},elasticIn:function(t){var e,n=3D.1;return 0=3D=
=3D=3Dt?0:1=3D=3D=3Dt?1:(e=3D!n||n<1?(n=3D1,.1):.4*Math.asin(1/n)/(2*Math.P=
I),-n*Math.pow(2,10*--t)*Math.sin((t-e)*(2*Math.PI)/.4))},elasticOut:functi=
on(t){var e,n=3D.1;return 0=3D=3D=3Dt?0:1=3D=3D=3Dt?1:(e=3D!n||n<1?(n=3D1,.=
1):.4*Math.asin(1/n)/(2*Math.PI),n*Math.pow(2,-10*t)*Math.sin((t-e)*(2*Math=
.PI)/.4)+1)},elasticInOut:function(t){var e,n=3D.1;return 0=3D=3D=3Dt?0:1=
=3D=3D=3Dt?1:(e=3D!n||n<1?(n=3D1,.1):.4*Math.asin(1/n)/(2*Math.PI),(t*=3D2)=
<1?n*Math.pow(2,10*--t)*Math.sin((t-e)*(2*Math.PI)/.4)*-.5:n*Math.pow(2,-10=
*--t)*Math.sin((t-e)*(2*Math.PI)/.4)*.5+1)},backIn:function(t){return t*t*(=
2.70158*t-1.70158)},backOut:function(t){return--t*t*(2.70158*t+1.70158)+1},=
backInOut:function(t){var e=3D2.5949095;return(t*=3D2)<1?t*t*((1+e)*t-e)*.5=
:.5*((t-=3D2)*t*((1+e)*t+e)+2)},bounceIn:function(t){return 1-Tn.bounceOut(=
1-t)},bounceOut:function(t){return t<1/2.75?7.5625*t*t:t<2/2.75?7.5625*(t-=
=3D1.5/2.75)*t+.75:t<2.5/2.75?7.5625*(t-=3D2.25/2.75)*t+.9375:7.5625*(t-=3D=
2.625/2.75)*t+.984375},bounceInOut:function(t){return t<.5?.5*Tn.bounceIn(2=
*t):.5*Tn.bounceOut(2*t-1)+.5}},In=3DMath.pow,Cn=3DMath.sqrt,Dn=3D1e-8,kn=
=3DCn(3),An=3D1/3,Ln=3DVt(),Pn=3DVt(),On=3DVt();function Rn(t){return-Dn<t&=
&t<Dn}function Nn(t){return Dn<t||t<-Dn}function En(t,e,n,i,o){var r=3D1-o;=
return r*r*(r*t+3*o*e)+o*o*(o*i+3*r*n)}function zn(t,e,n,i,o){var r=3D1-o;r=
eturn 3*(((e-t)*r+2*(n-e)*o)*r+(i-n)*o*o)}function Bn(t,e,n,i,o,r){var a,s,=
i=3Di+3*(e-n)-t,n=3D3*(n-2*e+t),e=3D3*(e-t),t=3Dt-o,o=3Dn*n-3*i*e,l=3Dn*e-9=
*i*t,t=3De*e-3*n*t,u=3D0;return Rn(o)&&Rn(l)?Rn(n)?r[0]=3D0:0<=3D(s=3D-e/n)=
&&s<=3D1&&(r[u++]=3Ds):Rn(e=3Dl*l-4*o*t)?(a=3D-(t=3Dl/o)/2,0<=3D(s=3D-n/i+t=
)&&s<=3D1&&(r[u++]=3Ds),0<=3Da&&a<=3D1&&(r[u++]=3Da)):0<e?(e=3Do*n+1.5*i*(-=
l-(t=3DCn(e))),0<=3D(s=3D(-n-((t=3D(t=3Do*n+1.5*i*(-l+t))<0?-In(-t,An):In(t=
,An))+(e=3De<0?-In(-e,An):In(e,An))))/(3*i))&&s<=3D1&&(r[u++]=3Ds)):(t=3D(2=
*o*n-3*i*l)/(2*Cn(o*o*o)),e=3DMath.acos(t)/3,s=3D(-n-2*(l=3DCn(o))*(t=3DMat=
h.cos(e)))/(3*i),a=3D(-n+l*(t+kn*Math.sin(e)))/(3*i),o=3D(-n+l*(t-kn*Math.s=
in(e)))/(3*i),0<=3Ds&&s<=3D1&&(r[u++]=3Ds),0<=3Da&&a<=3D1&&(r[u++]=3Da),0<=
=3Do&&o<=3D1&&(r[u++]=3Do)),u}function Fn(t,e,n,i,o){var r,a=3D6*n-12*e+6*t=
,i=3D9*e+3*i-3*t-9*n,n=3D3*e-3*t,e=3D0;return Rn(i)?Nn(a)&&0<=3D(r=3D-n/a)&=
&r<=3D1&&(o[e++]=3Dr):Rn(t=3Da*a-4*i*n)?o[0]=3D-a/(2*i):0<t&&(t=3D(-a-(n=3D=
Cn(t)))/(2*i),0<=3D(r=3D(-a+n)/(2*i))&&r<=3D1&&(o[e++]=3Dr),0<=3Dt)&&t<=3D1=
&&(o[e++]=3Dt),e}function Vn(t,e,n,i,o,r){var a=3D(e-t)*o+t,e=3D(n-e)*o+e,n=
=3D(i-n)*o+n,s=3D(e-a)*o+a,e=3D(n-e)*o+e,o=3D(e-s)*o+s;r[0]=3Dt,r[1]=3Da,r[=
2]=3Ds,r[3]=3Do,r[4]=3Do,r[5]=3De,r[6]=3Dn,r[7]=3Di}function Hn(t,e,n,i,o,r=
,a,s,l,u,h){var c,p,d,f,g=3D.005,y=3D1/0;Ln[0]=3Dl,Ln[1]=3Du;for(var m=3D0;=
m<1;m+=3D.05)Pn[0]=3DEn(t,n,o,a,m),Pn[1]=3DEn(e,i,r,s,m),(d=3D$t(Ln,Pn))<y&=
&(c=3Dm,y=3Dd);for(var y=3D1/0,v=3D0;v<32&&!(g<1e-4);v++)p=3Dc+g,Pn[0]=3DEn=
(t,n,o,a,f=3Dc-g),Pn[1]=3DEn(e,i,r,s,f),d=3D$t(Pn,Ln),0<=3Df&&d<y?(c=3Df,y=
=3Dd):(On[0]=3DEn(t,n,o,a,p),On[1]=3DEn(e,i,r,s,p),f=3D$t(On,Ln),p<=3D1&&f<=
y?(c=3Dp,y=3Df):g*=3D.5);return h&&(h[0]=3DEn(t,n,o,a,c),h[1]=3DEn(e,i,r,s,=
c)),Cn(y)}function Wn(t,e,n,i){var o=3D1-i;return o*(o*t+2*i*e)+i*i*n}funct=
ion Gn(t,e,n,i){return 2*((1-i)*(e-t)+i*(n-e))}function Xn(t,e,n){n=3Dt+n-2=
*e;return 0=3D=3Dn?.5:(t-e)/n}function Un(t,e,n,i,o){var r=3D(e-t)*i+t,e=3D=
(n-e)*i+e,i=3D(e-r)*i+r;o[0]=3Dt,o[1]=3Dr,o[2]=3Di,o[3]=3Di,o[4]=3De,o[5]=
=3Dn}function Yn(t,e,n,i,o,r,a,s,l){var u,h=3D.005,c=3D1/0;Ln[0]=3Da,Ln[1]=
=3Ds;for(var p=3D0;p<1;p+=3D.05)Pn[0]=3DWn(t,n,o,p),Pn[1]=3DWn(e,i,r,p),(y=
=3D$t(Ln,Pn))<c&&(u=3Dp,c=3Dy);for(var c=3D1/0,d=3D0;d<32&&!(h<1e-4);d++){v=
ar f=3Du-h,g=3Du+h,y=3D(Pn[0]=3DWn(t,n,o,f),Pn[1]=3DWn(e,i,r,f),$t(Pn,Ln));=
0<=3Df&&y<c?(u=3Df,c=3Dy):(On[0]=3DWn(t,n,o,g),On[1]=3DWn(e,i,r,g),f=3D$t(O=
n,Ln),g<=3D1&&f<c?(u=3Dg,c=3Df):h*=3D.5)}return l&&(l[0]=3DWn(t,n,o,u),l[1]=
=3DWn(e,i,r,u)),Cn(c)}var Zn=3D/cubic-bezier\(([0-9,\.e ]+)\)/;function qn(=
t){t=3Dt&&Zn.exec(t);if(t){var e,t=3Dt[1].split(","),n=3D+Mt(t[0]),i=3D+Mt(=
t[1]),o=3D+Mt(t[2]),r=3D+Mt(t[3]);if(!isNaN(n+i+o+r))return e=3D[],function=
(t){return t<=3D0?0:1<=3Dt?1:Bn(0,n,o,1,t,e)&&En(0,i,r,1,e[0])}}}Kn.prototy=
pe.step=3Dfunction(t,e){if(this._inited||(this._startTime=3Dt+this._delay,t=
his._inited=3D!0),!this._paused){var n=3Dthis._life,i=3Dt-this._startTime-t=
his._pausedTime,o=3Di/n,r=3D(o<0&&(o=3D0),o=3DMath.min(o,1),this.easingFunc=
),r=3Dr?r(o):o;if(this.onframe(r),1=3D=3D=3Do){if(!this.loop)return!0;this.=
_startTime=3Dt-i%n,this._pausedTime=3D0,this.onrestart()}return!1}this._pau=
sedTime+=3De},Kn.prototype.pause=3Dfunction(){this._paused=3D!0},Kn.prototy=
pe.resume=3Dfunction(){this._paused=3D!1},Kn.prototype.setEasing=3Dfunction=
(t){this.easing=3Dt,this.easingFunc=3DD(t)?t:Tn[t]||qn(t)};var jn=3DKn;func=
tion Kn(t){this._inited=3D!1,this._startTime=3D0,this._pausedTime=3D0,this.=
_paused=3D!1,this._life=3Dt.life||1e3,this._delay=3Dt.delay||0,this.loop=3D=
t.loop||!1,this.onframe=3Dt.onframe||zt,this.ondestroy=3Dt.ondestroy||zt,th=
is.onrestart=3Dt.onrestart||zt,t.easing&&this.setEasing(t.easing)}function =
$n(t){this.value=3Dt}Jn.prototype.insert=3Dfunction(t){t=3Dnew $n(t);return=
 this.insertEntry(t),t},Jn.prototype.insertEntry=3Dfunction(t){this.head?((=
this.tail.next=3Dt).prev=3Dthis.tail,t.next=3Dnull,this.tail=3Dt):this.head=
=3Dthis.tail=3Dt,this._len++},Jn.prototype.remove=3Dfunction(t){var e=3Dt.p=
rev,n=3Dt.next;e?e.next=3Dn:this.head=3Dn,n?n.prev=3De:this.tail=3De,t.next=
=3Dt.prev=3Dnull,this._len--},Jn.prototype.len=3Dfunction(){return this._le=
n},Jn.prototype.clear=3Dfunction(){this.head=3Dthis.tail=3Dnull,this._len=
=3D0};var Qn=3DJn;function Jn(){this._len=3D0}ei.prototype.put=3Dfunction(t=
,e){var n,i,o=3Dthis._list,r=3Dthis._map,a=3Dnull;return null=3D=3Dr[t]&&(i=
=3Do.len(),n=3Dthis._lastRemovedEntry,i>=3Dthis._maxSize&&0<i&&(i=3Do.head,=
o.remove(i),delete r[i.key],a=3Di.value,this._lastRemovedEntry=3Di),n?n.val=
ue=3De:n=3Dnew $n(e),n.key=3Dt,o.insertEntry(n),r[t]=3Dn),a},ei.prototype.g=
et=3Dfunction(t){var t=3Dthis._map[t],e=3Dthis._list;if(null!=3Dt)return t!=
=3D=3De.tail&&(e.remove(t),e.insertEntry(t)),t.value},ei.prototype.clear=3D=
function(){this._list.clear(),this._map=3D{}},ei.prototype.len=3Dfunction()=
{return this._list.len()};var ti=3Dei;function ei(t){this._list=3Dnew Qn,th=
is._maxSize=3D10,this._map=3D{},this._maxSize=3Dt}var ni=3D{transparent:[0,=
0,0,0],aliceblue:[240,248,255,1],antiquewhite:[250,235,215,1],aqua:[0,255,2=
55,1],aquamarine:[127,255,212,1],azure:[240,255,255,1],beige:[245,245,220,1=
],bisque:[255,228,196,1],black:[0,0,0,1],blanchedalmond:[255,235,205,1],blu=
e:[0,0,255,1],blueviolet:[138,43,226,1],brown:[165,42,42,1],burlywood:[222,=
184,135,1],cadetblue:[95,158,160,1],chartreuse:[127,255,0,1],chocolate:[210=
,105,30,1],coral:[255,127,80,1],cornflowerblue:[100,149,237,1],cornsilk:[25=
5,248,220,1],crimson:[220,20,60,1],cyan:[0,255,255,1],darkblue:[0,0,139,1],=
darkcyan:[0,139,139,1],darkgoldenrod:[184,134,11,1],darkgray:[169,169,169,1=
],darkgreen:[0,100,0,1],darkgrey:[169,169,169,1],darkkhaki:[189,183,107,1],=
darkmagenta:[139,0,139,1],darkolivegreen:[85,107,47,1],darkorange:[255,140,=
0,1],darkorchid:[153,50,204,1],darkred:[139,0,0,1],darksalmon:[233,150,122,=
1],darkseagreen:[143,188,143,1],darkslateblue:[72,61,139,1],darkslategray:[=
47,79,79,1],darkslategrey:[47,79,79,1],darkturquoise:[0,206,209,1],darkviol=
et:[148,0,211,1],deeppink:[255,20,147,1],deepskyblue:[0,191,255,1],dimgray:=
[105,105,105,1],dimgrey:[105,105,105,1],dodgerblue:[30,144,255,1],firebrick=
:[178,34,34,1],floralwhite:[255,250,240,1],forestgreen:[34,139,34,1],fuchsi=
a:[255,0,255,1],gainsboro:[220,220,220,1],ghostwhite:[248,248,255,1],gold:[=
255,215,0,1],goldenrod:[218,165,32,1],gray:[128,128,128,1],green:[0,128,0,1=
],greenyellow:[173,255,47,1],grey:[128,128,128,1],honeydew:[240,255,240,1],=
hotpink:[255,105,180,1],indianred:[205,92,92,1],indigo:[75,0,130,1],ivory:[=
255,255,240,1],khaki:[240,230,140,1],lavender:[230,230,250,1],lavenderblush=
:[255,240,245,1],lawngreen:[124,252,0,1],lemonchiffon:[255,250,205,1],light=
blue:[173,216,230,1],lightcoral:[240,128,128,1],lightcyan:[224,255,255,1],l=
ightgoldenrodyellow:[250,250,210,1],lightgray:[211,211,211,1],lightgreen:[1=
44,238,144,1],lightgrey:[211,211,211,1],lightpink:[255,182,193,1],lightsalm=
on:[255,160,122,1],lightseagreen:[32,178,170,1],lightskyblue:[135,206,250,1=
],lightslategray:[119,136,153,1],lightslategrey:[119,136,153,1],lightsteelb=
lue:[176,196,222,1],lightyellow:[255,255,224,1],lime:[0,255,0,1],limegreen:=
[50,205,50,1],linen:[250,240,230,1],magenta:[255,0,255,1],maroon:[128,0,0,1=
],mediumaquamarine:[102,205,170,1],mediumblue:[0,0,205,1],mediumorchid:[186=
,85,211,1],mediumpurple:[147,112,219,1],mediumseagreen:[60,179,113,1],mediu=
mslateblue:[123,104,238,1],mediumspringgreen:[0,250,154,1],mediumturquoise:=
[72,209,204,1],mediumvioletred:[199,21,133,1],midnightblue:[25,25,112,1],mi=
ntcream:[245,255,250,1],mistyrose:[255,228,225,1],moccasin:[255,228,181,1],=
navajowhite:[255,222,173,1],navy:[0,0,128,1],oldlace:[253,245,230,1],olive:=
[128,128,0,1],olivedrab:[107,142,35,1],orange:[255,165,0,1],orangered:[255,=
69,0,1],orchid:[218,112,214,1],palegoldenrod:[238,232,170,1],palegreen:[152=
,251,152,1],paleturquoise:[175,238,238,1],palevioletred:[219,112,147,1],pap=
ayawhip:[255,239,213,1],peachpuff:[255,218,185,1],peru:[205,133,63,1],pink:=
[255,192,203,1],plum:[221,160,221,1],powderblue:[176,224,230,1],purple:[128=
,0,128,1],red:[255,0,0,1],rosybrown:[188,143,143,1],royalblue:[65,105,225,1=
],saddlebrown:[139,69,19,1],salmon:[250,128,114,1],sandybrown:[244,164,96,1=
],seagreen:[46,139,87,1],seashell:[255,245,238,1],sienna:[160,82,45,1],silv=
er:[192,192,192,1],skyblue:[135,206,235,1],slateblue:[106,90,205,1],slategr=
ay:[112,128,144,1],slategrey:[112,128,144,1],snow:[255,250,250,1],springgre=
en:[0,255,127,1],steelblue:[70,130,180,1],tan:[210,180,140,1],teal:[0,128,1=
28,1],thistle:[216,191,216,1],tomato:[255,99,71,1],turquoise:[64,224,208,1]=
,violet:[238,130,238,1],wheat:[245,222,179,1],white:[255,255,255,1],whitesm=
oke:[245,245,245,1],yellow:[255,255,0,1],yellowgreen:[154,205,50,1]};functi=
on ii(t){return(t=3DMath.round(t))<0?0:255<t?255:t}function oi(t){return t<=
0?0:1<t?1:t}function ri(t){return t.length&&"%"=3D=3D=3Dt.charAt(t.length-1=
)?ii(parseFloat(t)/100*255):ii(parseInt(t,10))}function ai(t){return t.leng=
th&&"%"=3D=3D=3Dt.charAt(t.length-1)?oi(parseFloat(t)/100):oi(parseFloat(t)=
)}function si(t,e,n){return n<0?n+=3D1:1<n&&--n,6*n<1?t+(e-t)*n*6:2*n<1?e:3=
*n<2?t+(e-t)*(2/3-n)*6:t}function li(t,e,n){return t+(e-t)*n}function ui(t,=
e,n,i,o){return t[0]=3De,t[1]=3Dn,t[2]=3Di,t[3]=3Do,t}function hi(t,e){retu=
rn t[0]=3De[0],t[1]=3De[1],t[2]=3De[2],t[3]=3De[3],t}var ci=3Dnew ti(20),pi=
=3Dnull;function di(t,e){pi&&hi(pi,e),pi=3Dci.put(t,pi||e.slice())}function=
 fi(t,e){if(t){e=3De||[];var n=3Dci.get(t);if(n)return hi(e,n);n=3D(t+=3D""=
).replace(/ /g,"").toLowerCase();if(n in ni)return hi(e,ni[n]),di(t,e),e;va=
r i=3Dn.length;if("#"=3D=3D=3Dn.charAt(0))return 4=3D=3D=3Di||5=3D=3D=3Di?0=
<=3D(o=3DparseInt(n.slice(1,4),16))&&o<=3D4095?(ui(e,(3840&o)>>4|(3840&o)>>=
8,240&o|(240&o)>>4,15&o|(15&o)<<4,5=3D=3D=3Di?parseInt(n.slice(4),16)/15:1)=
,di(t,e),e):void ui(e,0,0,0,1):7=3D=3D=3Di||9=3D=3D=3Di?0<=3D(o=3DparseInt(=
n.slice(1,7),16))&&o<=3D16777215?(ui(e,(16711680&o)>>16,(65280&o)>>8,255&o,=
9=3D=3D=3Di?parseInt(n.slice(7),16)/255:1),di(t,e),e):void ui(e,0,0,0,1):vo=
id 0;var o=3Dn.indexOf("("),r=3Dn.indexOf(")");if(-1!=3D=3Do&&r+1=3D=3D=3Di=
){var i=3Dn.substr(0,o),a=3Dn.substr(o+1,r-(o+1)).split(","),s=3D1;switch(i=
){case"rgba":if(4!=3D=3Da.length)return 3=3D=3D=3Da.length?ui(e,+a[0],+a[1]=
,+a[2],1):ui(e,0,0,0,1);s=3Dai(a.pop());case"rgb":return 3<=3Da.length?(ui(=
e,ri(a[0]),ri(a[1]),ri(a[2]),3=3D=3D=3Da.length?s:ai(a[3])),di(t,e),e):void=
 ui(e,0,0,0,1);case"hsla":return 4!=3D=3Da.length?void ui(e,0,0,0,1):(a[3]=
=3Dai(a[3]),gi(a,e),di(t,e),e);case"hsl":return 3!=3D=3Da.length?void ui(e,=
0,0,0,1):(gi(a,e),di(t,e),e);default:return}}ui(e,0,0,0,1)}}function gi(t,e=
){var n=3D(parseFloat(t[0])%360+360)%360/360,i=3Dai(t[1]),o=3Dai(t[2]),i=3D=
o<=3D.5?o*(i+1):o+i-o*i,o=3D2*o-i;return ui(e=3De||[],ii(255*si(o,i,n+1/3))=
,ii(255*si(o,i,n)),ii(255*si(o,i,n-1/3)),1),4=3D=3D=3Dt.length&&(e[3]=3Dt[3=
]),e}function yi(t,e){var n=3Dfi(t);if(n){for(var i=3D0;i<3;i++)n[i]=3De<0?=
n[i]*(1-e)|0:(255-n[i])*e+n[i]|0,255<n[i]?n[i]=3D255:n[i]<0&&(n[i]=3D0);ret=
urn xi(n,4=3D=3D=3Dn.length?"rgba":"rgb")}}function mi(t,e,n){var i,o,r;if(=
e&&e.length&&0<=3Dt&&t<=3D1)return n=3Dn||[],t=3Dt*(e.length-1),i=3DMath.fl=
oor(t),r=3DMath.ceil(t),o=3De[i],e=3De[r],n[0]=3Dii(li(o[0],e[0],r=3Dt-i)),=
n[1]=3Dii(li(o[1],e[1],r)),n[2]=3Dii(li(o[2],e[2],r)),n[3]=3Doi(li(o[3],e[3=
],r)),n}var vi=3Dmi;function _i(t,e,n){var i,o,r,a;if(e&&e.length&&0<=3Dt&&=
t<=3D1)return t=3Dt*(e.length-1),i=3DMath.floor(t),o=3DMath.ceil(t),a=3Dfi(=
e[i]),e=3Dfi(e[o]),a=3Dxi([ii(li(a[0],e[0],r=3Dt-i)),ii(li(a[1],e[1],r)),ii=
(li(a[2],e[2],r)),oi(li(a[3],e[3],r))],"rgba"),n?{color:a,leftIndex:i,right=
Index:o,value:t}:a}var e=3D_i;function xi(t,e){var n;if(t&&t.length)return =
n=3Dt[0]+","+t[1]+","+t[2],"rgba"!=3D=3De&&"hsva"!=3D=3De&&"hsla"!=3D=3De||=
(n+=3D","+t[3]),e+"("+n+")"}function wi(t,e){t=3Dfi(t);return t?(.299*t[0]+=
.587*t[1]+.114*t[2])*t[3]/255+(1-t[3])*e:0}var bi=3Dnew ti(100);function Si=
(t){var e;return H(t)?((e=3Dbi.get(t))||(e=3Dyi(t,-.1),bi.put(t,e)),e):gt(t=
)?((e=3DP({},t)).colorStops=3DF(t.colorStops,function(t){return{offset:t.of=
fset,color:yi(t.color,-.1)}}),e):t}vi=3DObject.freeze({__proto__:null,fastL=
erp:mi,fastMapToColor:vi,lerp:_i,lift:yi,liftColor:Si,lum:wi,mapToColor:e,m=
odifyAlpha:function(t,e){if((t=3Dfi(t))&&null!=3De)return t[3]=3Doi(e),xi(t=
,"rgba")},modifyHSL:function(t,e,n,i){var o=3Dfi(t);if(t)return o=3Dfunctio=
n(t){var e,n,i,o,r,a,s,l,u,h;if(t)return h=3Dt[0]/255,n=3Dt[1]/255,i=3Dt[2]=
/255,s=3DMath.min(h,n,i),r=3D((o=3DMath.max(h,n,i))+s)/2,0=3D=3D(u=3Do-s)?a=
=3De=3D0:(a=3Dr<.5?u/(o+s):u/(2-o-s),s=3D((o-h)/6+u/2)/u,l=3D((o-n)/6+u/2)/=
u,u=3D((o-i)/6+u/2)/u,h=3D=3D=3Do?e=3Du-l:n=3D=3D=3Do?e=3D1/3+s-u:i=3D=3D=
=3Do&&(e=3D2/3+l-s),e<0&&(e+=3D1),1<e&&--e),h=3D[360*e,a,r],null!=3Dt[3]&&h=
.push(t[3]),h}(o),null!=3De&&(o[0]=3D(t=3De,(t=3DMath.round(t))<0?0:360<t?3=
60:t)),null!=3Dn&&(o[1]=3Dai(n)),null!=3Di&&(o[2]=3Dai(i)),xi(gi(o),"rgba")=
},parse:fi,random:function(){return xi([Math.round(255*Math.random()),Math.=
round(255*Math.random()),Math.round(255*Math.random())],"rgb")},stringify:x=
i,toHex:function(t){if(t=3Dfi(t))return((1<<24)+(t[0]<<16)+(t[1]<<8)+ +t[2]=
).toString(16).slice(1)}});b.hasGlobalWindow&&D(window.btoa);var Mi=3DArray=
.prototype.slice;function Ti(t,e,n){return(e-t)*n+t}function Ii(t,e,n,i){fo=
r(var o=3De.length,r=3D0;r<o;r++)t[r]=3DTi(e[r],n[r],i);return t}function C=
i(t,e,n,i){for(var o=3De.length,r=3D0;r<o;r++)t[r]=3De[r]+n[r]*i;return t}f=
unction Di(t,e,n,i){for(var o=3De.length,r=3Do&&e[0].length,a=3D0;a<o;a++){=
t[a]||(t[a]=3D[]);for(var s=3D0;s<r;s++)t[a][s]=3De[a][s]+n[a][s]*i}return =
t}function ki(t){if(st(t)){var e=3Dt.length;if(st(t[0])){for(var n=3D[],i=
=3D0;i<e;i++)n.push(Mi.call(t[i]));return n}return Mi.call(t)}return t}func=
tion Ai(t){return t[0]=3DMath.floor(t[0])||0,t[1]=3DMath.floor(t[1])||0,t[2=
]=3DMath.floor(t[2])||0,t[3]=3Dnull=3D=3Dt[3]?1:t[3],"rgba("+t.join(",")+")=
"}function Li(t){return 4=3D=3D=3Dt||5=3D=3D=3Dt}function Pi(t){return 1=3D=
=3D=3Dt||2=3D=3D=3Dt}var Oi=3D[0,0,0,0],Ri=3D(zi.prototype.isFinished=3Dfun=
ction(){return this._finished},zi.prototype.setFinished=3Dfunction(){this._=
finished=3D!0,this._additiveTrack&&this._additiveTrack.setFinished()},zi.pr=
ototype.needsAnimate=3Dfunction(){return 1<=3Dthis.keyframes.length},zi.pro=
totype.getAdditiveTrack=3Dfunction(){return this._additiveTrack},zi.prototy=
pe.addKeyframe=3Dfunction(t,e,n){this._needsSort=3D!0;var i,o=3Dthis.keyfra=
mes,r=3Do.length,a=3D!1,s=3D6,l=3De,u=3D(st(e)?(1=3D=3D(s=3Di=3Dst((i=3De)&=
&i[0])?2:1)&&!W(e[0])||2=3D=3Di&&!W(e[0][0]))&&(a=3D!0):W(e)&&!vt(e)?s=3D0:=
H(e)?isNaN(+e)?(i=3Dfi(e))&&(l=3Di,s=3D3):s=3D0:gt(e)&&((u=3DP({},l)).color=
Stops=3DF(e.colorStops,function(t){return{offset:t.offset,color:fi(t.color)=
}}),"linear"=3D=3D=3De.type?s=3D4:"radial"=3D=3D=3De.type&&(s=3D5),l=3Du),0=
=3D=3D=3Dr?this.valType=3Ds:s=3D=3D=3Dthis.valType&&6!=3D=3Ds||(a=3D!0),thi=
s.discrete=3Dthis.discrete||a,{time:t,value:l,rawValue:e,percent:0});return=
 n&&(u.easing=3Dn,u.easingFunc=3DD(n)?n:Tn[n]||qn(n)),o.push(u),u},zi.proto=
type.prepare=3Dfunction(t,e){var n=3Dthis.keyframes;this._needsSort&&n.sort=
(function(t,e){return t.time-e.time});for(var i=3Dthis.valType,o=3Dn.length=
,r=3Dn[o-1],a=3Dthis.discrete,s=3DPi(i),l=3DLi(i),u=3D0;u<o;u++){var h=3Dn[=
u],c=3Dh.value,p=3Dr.value;if(h.percent=3Dh.time/t,!a)if(s&&u!=3D=3Do-1){h=
=3Dvoid 0;d=3Dvoid 0;f=3Dvoid 0;g=3Dvoid 0;y=3Dvoid 0;m=3Dvoid 0;v=3Dvoid 0=
;_=3Dvoid 0;x=3Dvoid 0;h=3Dc;var d=3Dp;var f=3Di;var g=3Dh,y=3Dd;if(g.push&=
&y.push){var h=3Dg.length,m=3Dy.length;if(h!=3D=3Dm)if(m<h)g.length=3Dm;els=
e for(var v=3Dh;v<m;v++)g.push(1=3D=3D=3Df?y[v]:Mi.call(y[v]));for(var _=3D=
g[0]&&g[0].length,v=3D0;v<g.length;v++)if(1=3D=3D=3Df)isNaN(g[v])&&(g[v]=3D=
y[v]);else for(var x=3D0;x<_;x++)isNaN(g[v][x])&&(g[v][x]=3Dy[v][x])}}else =
if(l){d=3Dvoid 0;h=3Dvoid 0;w=3Dvoid 0;b=3Dvoid 0;S=3Dvoid 0;M=3Dvoid 0;T=
=3Dvoid 0;d=3Dc.colorStops;h=3Dp.colorStops;for(var w=3Dd.length,b=3Dh.leng=
th,S=3Db<w?h:d,h=3DMath.min(w,b),M=3DS[h-1]||{color:[0,0,0,0],offset:0},T=
=3Dh;T<Math.max(w,b);T++)S.push({offset:M.offset,color:M.color.slice()})}}i=
f(!a&&5!=3D=3Di&&e&&this.needsAnimate()&&e.needsAnimate()&&i=3D=3D=3De.valT=
ype&&!e._finished){this._additiveTrack=3De;for(var I=3Dn[0].value,u=3D0;u<o=
;u++)0=3D=3D=3Di?n[u].additiveValue=3Dn[u].value-I:3=3D=3D=3Di?n[u].additiv=
eValue=3DCi([],n[u].value,I,-1):Pi(i)&&(n[u].additiveValue=3D(1=3D=3D=3Di?C=
i:Di)([],n[u].value,I,-1))}},zi.prototype.step=3Dfunction(t,e){if(!this._fi=
nished){this._additiveTrack&&this._additiveTrack._finished&&(this._additive=
Track=3Dnull);var n,i,o,r,a,s=3Dnull!=3Dthis._additiveTrack,l=3Ds?"additive=
Value":"value",u=3Dthis.valType,h=3Dthis.keyframes,c=3Dh.length,p=3Dthis.pr=
opName,d=3D3=3D=3D=3Du,f=3Dthis._lastFr,g=3DMath.min;if(1=3D=3D=3Dc)i=3Do=
=3Dh[0];else{if(e<0)n=3D0;else if(e<this._lastFrP){for(n=3Dg(f+1,c-1);0<=3D=
n&&!(h[n].percent<=3De);n--);n=3Dg(n,c-2)}else{for(n=3Df;n<c&&!(h[n].percen=
t>e);n++);n=3Dg(n-1,c-2)}o=3Dh[n+1],i=3Dh[n]}i&&o&&(this._lastFr=3Dn,this._=
lastFrP=3De,f=3Do.percent-i.percent,r=3D0=3D=3Df?1:g((e-i.percent)/f,1),o.e=
asingFunc&&(r=3Do.easingFunc(r)),g=3Ds?this._additiveValue:d?Oi:t[p],(Pi(u)=
||d)&&(g=3Dg||(this._additiveValue=3D[])),this.discrete?t[p]=3D(r<1?i:o).ra=
wValue:Pi(u)?(1=3D=3D=3Du?Ii:function(t,e,n,i){for(var o=3De.length,r=3Do&&=
e[0].length,a=3D0;a<o;a++){t[a]||(t[a]=3D[]);for(var s=3D0;s<r;s++)t[a][s]=
=3DTi(e[a][s],n[a][s],i)}})(g,i[l],o[l],r):Li(u)?(f=3Di[l],a=3Do[l],t[p]=3D=
{type:(u=3D4=3D=3D=3Du)?"linear":"radial",x:Ti(f.x,a.x,r),y:Ti(f.y,a.y,r),c=
olorStops:F(f.colorStops,function(t,e){e=3Da.colorStops[e];return{offset:Ti=
(t.offset,e.offset,r),color:Ai(Ii([],t.color,e.color,r))}}),global:a.global=
},u?(t[p].x2=3DTi(f.x2,a.x2,r),t[p].y2=3DTi(f.y2,a.y2,r)):t[p].r=3DTi(f.r,a=
.r,r)):d?(Ii(g,i[l],o[l],r),s||(t[p]=3DAi(g))):(u=3DTi(i[l],o[l],r),s?this.=
_additiveValue=3Du:t[p]=3Du),s)&&this._addToTarget(t)}},zi.prototype._addTo=
Target=3Dfunction(t){var e=3Dthis.valType,n=3Dthis.propName,i=3Dthis._addit=
iveValue;0=3D=3D=3De?t[n]=3Dt[n]+i:3=3D=3D=3De?(fi(t[n],Oi),Ci(Oi,Oi,i,1),t=
[n]=3DAi(Oi)):1=3D=3D=3De?Ci(t[n],t[n],i,1):2=3D=3D=3De&&Di(t[n],t[n],i,1)}=
,zi),Ni=3D(Ei.prototype.getMaxTime=3Dfunction(){return this._maxTime},Ei.pr=
ototype.getDelay=3Dfunction(){return this._delay},Ei.prototype.getLoop=3Dfu=
nction(){return this._loop},Ei.prototype.getTarget=3Dfunction(){return this=
._target},Ei.prototype.changeTarget=3Dfunction(t){this._target=3Dt},Ei.prot=
otype.when=3Dfunction(t,e,n){return this.whenWithKeys(t,e,ht(e),n)},Ei.prot=
otype.whenWithKeys=3Dfunction(t,e,n,i){for(var o=3Dthis._tracks,r=3D0;r<n.l=
ength;r++){var a=3Dn[r];if(!(l=3Do[a])){var s,l=3Do[a]=3Dnew Ri(a),u=3Dvoid=
 0,h=3Dthis._getAdditiveTrack(a);if(h?(u=3D(s=3D(s=3Dh.keyframes)[s.length-=
1])&&s.value,3=3D=3D=3Dh.valType&&(u=3Du&&Ai(u))):u=3Dthis._target[a],null=
=3D=3Du)continue;0<t&&l.addKeyframe(0,ki(u),i),this._trackKeys.push(a)}l.ad=
dKeyframe(t,ki(e[a]),i)}return this._maxTime=3DMath.max(this._maxTime,t),th=
is},Ei.prototype.pause=3Dfunction(){this._clip.pause(),this._paused=3D!0},E=
i.prototype.resume=3Dfunction(){this._clip.resume(),this._paused=3D!1},Ei.p=
rototype.isPaused=3Dfunction(){return!!this._paused},Ei.prototype.duration=
=3Dfunction(t){return this._maxTime=3Dt,this._force=3D!0,this},Ei.prototype=
._doneCallback=3Dfunction(){this._setTracksFinished(),this._clip=3Dnull;var=
 t=3Dthis._doneCbs;if(t)for(var e=3Dt.length,n=3D0;n<e;n++)t[n].call(this)}=
,Ei.prototype._abortedCallback=3Dfunction(){this._setTracksFinished();var t=
=3Dthis.animation,e=3Dthis._abortedCbs;if(t&&t.removeClip(this._clip),this.=
_clip=3Dnull,e)for(var n=3D0;n<e.length;n++)e[n].call(this)},Ei.prototype._=
setTracksFinished=3Dfunction(){for(var t=3Dthis._tracks,e=3Dthis._trackKeys=
,n=3D0;n<e.length;n++)t[e[n]].setFinished()},Ei.prototype._getAdditiveTrack=
=3Dfunction(t){var e,n=3Dthis._additiveAnimators;if(n)for(var i=3D0;i<n.len=
gth;i++){var o=3Dn[i].getTrack(t);o&&(e=3Do)}return e},Ei.prototype.start=
=3Dfunction(t){if(!(0<this._started)){this._started=3D1;for(var e,r=3Dthis,=
a=3D[],n=3Dthis._maxTime||0,i=3D0;i<this._trackKeys.length;i++){var o=3Dthi=
s._trackKeys[i],s=3Dthis._tracks[o],o=3Dthis._getAdditiveTrack(o),l=3Ds.key=
frames,u=3Dl.length;s.prepare(n,o),s.needsAnimate()&&(!this._allowDiscrete&=
&s.discrete?((o=3Dl[u-1])&&(r._target[s.propName]=3Do.rawValue),s.setFinish=
ed()):a.push(s))}return a.length||this._force?(e=3Dnew jn({life:n,loop:this=
._loop,delay:this._delay||0,onframe:function(t){r._started=3D2;var e=3Dr._a=
dditiveAnimators;if(e){for(var n=3D!1,i=3D0;i<e.length;i++)if(e[i]._clip){n=
=3D!0;break}n||(r._additiveAnimators=3Dnull)}for(i=3D0;i<a.length;i++)a[i].=
step(r._target,t);var o=3Dr._onframeCbs;if(o)for(i=3D0;i<o.length;i++)o[i](=
r._target,t)},ondestroy:function(){r._doneCallback()}}),this._clip=3De,this=
.animation&&this.animation.addClip(e),t&&e.setEasing(t)):this._doneCallback=
(),this}},Ei.prototype.stop=3Dfunction(t){var e;this._clip&&(e=3Dthis._clip=
,t&&e.onframe(1),this._abortedCallback())},Ei.prototype.delay=3Dfunction(t)=
{return this._delay=3Dt,this},Ei.prototype.during=3Dfunction(t){return t&&(=
this._onframeCbs||(this._onframeCbs=3D[]),this._onframeCbs.push(t)),this},E=
i.prototype.done=3Dfunction(t){return t&&(this._doneCbs||(this._doneCbs=3D[=
]),this._doneCbs.push(t)),this},Ei.prototype.aborted=3Dfunction(t){return t=
&&(this._abortedCbs||(this._abortedCbs=3D[]),this._abortedCbs.push(t)),this=
},Ei.prototype.getClip=3Dfunction(){return this._clip},Ei.prototype.getTrac=
k=3Dfunction(t){return this._tracks[t]},Ei.prototype.getTracks=3Dfunction()=
{var e=3Dthis;return F(this._trackKeys,function(t){return e._tracks[t]})},E=
i.prototype.stopTracks=3Dfunction(t,e){if(!t.length||!this._clip)return!0;f=
or(var n=3Dthis._tracks,i=3Dthis._trackKeys,o=3D0;o<t.length;o++){var r=3Dn=
[t[o]];r&&!r.isFinished()&&(e?r.step(this._target,1):1=3D=3D=3Dthis._starte=
d&&r.step(this._target,0),r.setFinished())}for(var a=3D!0,o=3D0;o<i.length;=
o++)if(!n[i[o]].isFinished()){a=3D!1;break}return a&&this._abortedCallback(=
),a},Ei.prototype.saveTo=3Dfunction(t,e,n){if(t){e=3De||this._trackKeys;for=
(var i=3D0;i<e.length;i++){var o=3De[i],r=3Dthis._tracks[o];r&&!r.isFinishe=
d()&&(r=3D(r=3Dr.keyframes)[n?0:r.length-1])&&(t[o]=3Dki(r.rawValue))}}},Ei=
.prototype.__changeFinalValue=3Dfunction(t,e){e=3De||ht(t);for(var n=3D0;n<=
e.length;n++){var i,o=3De[n],r=3Dthis._tracks[o];r&&1<(i=3Dr.keyframes).len=
gth&&(i=3Di.pop(),r.addKeyframe(i.time,t[o]),r.prepare(this._maxTime,r.getA=
dditiveTrack()))}},Ei);function Ei(t,e,n,i){this._tracks=3D{},this._trackKe=
ys=3D[],this._maxTime=3D0,this._started=3D0,this._clip=3Dnull,this._target=
=3Dt,(this._loop=3De)&&i?it("Can' use additive animation on looped animatio=
n."):(this._additiveAnimators=3Di,this._allowDiscrete=3Dn)}function zi(t){t=
his.keyframes=3D[],this.discrete=3D!1,this._invalid=3D!1,this._needsSort=3D=
!1,this._lastFr=3D0,this._lastFrP=3D0,this.propName=3Dt}function Bi(){retur=
n(new Date).getTime()}u(Hi,Fi=3Dae),Hi.prototype.addClip=3Dfunction(t){t.an=
imation&&this.removeClip(t),this._head?((this._tail.next=3Dt).prev=3Dthis._=
tail,t.next=3Dnull,this._tail=3Dt):this._head=3Dthis._tail=3Dt,t.animation=
=3Dthis},Hi.prototype.addAnimator=3Dfunction(t){t.animation=3Dthis;t=3Dt.ge=
tClip();t&&this.addClip(t)},Hi.prototype.removeClip=3Dfunction(t){var e,n;t=
.animation&&(e=3Dt.prev,n=3Dt.next,e?e.next=3Dn:this._head=3Dn,n?n.prev=3De=
:this._tail=3De,t.next=3Dt.prev=3Dt.animation=3Dnull)},Hi.prototype.removeA=
nimator=3Dfunction(t){var e=3Dt.getClip();e&&this.removeClip(e),t.animation=
=3Dnull},Hi.prototype.update=3Dfunction(t){for(var e=3DBi()-this._pausedTim=
e,n=3De-this._time,i=3Dthis._head;i;)var o=3Di.next,i=3D(i.step(e,n)&&(i.on=
destroy(),this.removeClip(i)),o);this._time=3De,t||(this.trigger("frame",n)=
,this.stage.update&&this.stage.update())},Hi.prototype._startLoop=3Dfunctio=
n(){var e=3Dthis;this._running=3D!0,Mn(function t(){e._running&&(Mn(t),!e._=
paused)&&e.update()})},Hi.prototype.start=3Dfunction(){this._running||(this=
._time=3DBi(),this._pausedTime=3D0,this._startLoop())},Hi.prototype.stop=3D=
function(){this._running=3D!1},Hi.prototype.pause=3Dfunction(){this._paused=
||(this._pauseStart=3DBi(),this._paused=3D!0)},Hi.prototype.resume=3Dfuncti=
on(){this._paused&&(this._pausedTime+=3DBi()-this._pauseStart,this._paused=
=3D!1)},Hi.prototype.clear=3Dfunction(){for(var t=3Dthis._head;t;){var e=3D=
t.next;t.prev=3Dt.next=3Dt.animation=3Dnull,t=3De}this._head=3Dthis._tail=
=3Dnull},Hi.prototype.isFinished=3Dfunction(){return null=3D=3Dthis._head},=
Hi.prototype.animate=3Dfunction(t,e){e=3De||{},this.start();t=3Dnew Ni(t,e.=
loop);return this.addAnimator(t),t};var Fi,Vi=3DHi;function Hi(t){var e=3DF=
i.call(this)||this;return e._running=3D!1,e._time=3D0,e._pausedTime=3D0,e._=
pauseStart=3D0,e._paused=3D!1,e.stage=3D(t=3Dt||{}).stage||{},e}var Wi,Gi=
=3Db.domSupported,Xi=3D(Wi=3D{pointerdown:1,pointerup:1,pointermove:1,point=
erout:1},{mouse:e=3D["click","dblclick","mousewheel","wheel","mouseout","mo=
useup","mousedown","mousemove","contextmenu"],touch:["touchstart","touchend=
","touchmove"],pointer:F(e,function(t){var e=3Dt.replace("mouse","pointer")=
;return Wi.hasOwnProperty(e)?e:t})}),Ui=3D["mousemove","mouseup"],Yi=3D["po=
intermove","pointerup"],Zi=3D!1;function qi(t){t=3Dt.pointerType;return"pen=
"=3D=3D=3Dt||"touch"=3D=3D=3Dt}function ji(t){t&&(t.zrByTouch=3D!0)}functio=
n Ki(t,e){for(var n=3De,i=3D!1;n&&9!=3D=3Dn.nodeType&&!(i=3Dn.domBelongToZr=
||n!=3D=3De&&n=3D=3D=3Dt.painterRoot);)n=3Dn.parentNode;return i}var $i=3Df=
unction(t,e){this.stopPropagation=3Dzt,this.stopImmediatePropagation=3Dzt,t=
his.preventDefault=3Dzt,this.type=3De.type,this.target=3Dthis.currentTarget=
=3Dt.dom,this.pointerType=3De.pointerType,this.clientX=3De.clientX,this.cli=
entY=3De.clientY},Qi=3D{mousedown:function(t){t=3DMe(this.dom,t),this.__may=
PointerCapture=3D[t.zrX,t.zrY],this.trigger("mousedown",t)},mousemove:funct=
ion(t){t=3DMe(this.dom,t);var e=3Dthis.__mayPointerCapture;!e||t.zrX=3D=3D=
=3De[0]&&t.zrY=3D=3D=3De[1]||this.__togglePointerCapture(!0),this.trigger("=
mousemove",t)},mouseup:function(t){t=3DMe(this.dom,t),this.__togglePointerC=
apture(!1),this.trigger("mouseup",t)},mouseout:function(t){Ki(this,(t=3DMe(=
this.dom,t)).toElement||t.relatedTarget)||(this.__pointerCapturing&&(t.zrEv=
entControl=3D"no_globalout"),this.trigger("mouseout",t))},wheel:function(t)=
{Zi=3D!0,t=3DMe(this.dom,t),this.trigger("mousewheel",t)},mousewheel:functi=
on(t){Zi||(t=3DMe(this.dom,t),this.trigger("mousewheel",t))},touchstart:fun=
ction(t){ji(t=3DMe(this.dom,t)),this.__lastTouchMoment=3Dnew Date,this.hand=
ler.processGesture(t,"start"),Qi.mousemove.call(this,t),Qi.mousedown.call(t=
his,t)},touchmove:function(t){ji(t=3DMe(this.dom,t)),this.handler.processGe=
sture(t,"change"),Qi.mousemove.call(this,t)},touchend:function(t){ji(t=3DMe=
(this.dom,t)),this.handler.processGesture(t,"end"),Qi.mouseup.call(this,t),=
+new Date-+this.__lastTouchMoment<300&&Qi.click.call(this,t)},pointerdown:f=
unction(t){Qi.mousedown.call(this,t)},pointermove:function(t){qi(t)||Qi.mou=
semove.call(this,t)},pointerup:function(t){Qi.mouseup.call(this,t)},pointer=
out:function(t){qi(t)||Qi.mouseout.call(this,t)}},Ji=3D(E(["click","dblclic=
k","contextmenu"],function(e){Qi[e]=3Dfunction(t){t=3DMe(this.dom,t),this.t=
rigger(e,t)}}),{pointermove:function(t){qi(t)||Ji.mousemove.call(this,t)},p=
ointerup:function(t){Ji.mouseup.call(this,t)},mousemove:function(t){this.tr=
igger("mousemove",t)},mouseup:function(t){var e=3Dthis.__pointerCapturing;t=
his.__togglePointerCapture(!1),this.trigger("mouseup",t),e&&(t.zrEventContr=
ol=3D"only_globalout",this.trigger("mouseout",t))}});function to(i,o){var r=
=3Do.domHandlers;b.pointerEventsSupported?E(Xi.pointer,function(e){no(o,e,f=
unction(t){r[e].call(i,t)})}):(b.touchEventsSupported&&E(Xi.touch,function(=
n){no(o,n,function(t){var e;r[n].call(i,t),(e=3Do).touching=3D!0,null!=3De.=
touchTimer&&(clearTimeout(e.touchTimer),e.touchTimer=3Dnull),e.touchTimer=
=3DsetTimeout(function(){e.touching=3D!1,e.touchTimer=3Dnull},700)})}),E(Xi=
.mouse,function(e){no(o,e,function(t){t=3DSe(t),o.touching||r[e].call(i,t)}=
)}))}function eo(i,o){function t(n){no(o,n,function(t){var e;t=3DSe(t),Ki(i=
,t.target)||(e=3Dt,t=3DMe(i.dom,new $i(i,e),!0),o.domHandlers[n].call(i,t))=
},{capture:!0})}b.pointerEventsSupported?E(Yi,t):b.touchEventsSupported||E(=
Ui,t)}function no(t,e,n,i){t.mounted[e]=3Dn,t.listenerOpts[e]=3Di,t.domTarg=
et.addEventListener(e,n,i)}function io(t){var e,n,i,o,r,a=3Dt.mounted;for(e=
 in a)a.hasOwnProperty(e)&&(n=3Dt.domTarget,i=3De,o=3Da[e],r=3Dt.listenerOp=
ts[e],n.removeEventListener(i,o,r));t.mounted=3D{}}function oo(t,e){this.mo=
unted=3D{},this.listenerOpts=3D{},this.touching=3D!1,this.domTarget=3Dt,thi=
s.domHandlers=3De}u(so,ro=3Dae),so.prototype.dispose=3Dfunction(){io(this._=
localHandlerScope),Gi&&io(this._globalHandlerScope)},so.prototype.setCursor=
=3Dfunction(t){this.dom.style&&(this.dom.style.cursor=3Dt||"default")},so.p=
rototype.__togglePointerCapture=3Dfunction(t){var e;this.__mayPointerCaptur=
e=3Dnull,Gi&&+this.__pointerCapturing^+t&&(this.__pointerCapturing=3Dt,e=3D=
this._globalHandlerScope,t?eo(this,e):io(e))};var ro,ao=3Dso;function so(t,=
e){var n=3Dro.call(this)||this;return n.__pointerCapturing=3D!1,n.dom=3Dt,n=
.painterRoot=3De,n._localHandlerScope=3Dnew oo(t,Qi),Gi&&(n._globalHandlerS=
cope=3Dnew oo(document,Ji)),to(n,n._localHandlerScope),n}var e=3D1,lo=3De=
=3Db.hasGlobalWindow?Math.max(window.devicePixelRatio||window.screen&&windo=
w.screen.deviceXDPI/window.screen.logicalXDPI||1,1):e,uo=3D"#333",ho=3D"#cc=
c",co=3DPe;function po(t){return 5e-5<t||t<-5e-5}var fo=3D[],go=3D[],yo=3DL=
e(),mo=3DMath.abs,vo=3D(_o.prototype.getLocalTransform=3Dfunction(t){return=
 _o.getLocalTransform(this,t)},_o.prototype.setPosition=3Dfunction(t){this.=
x=3Dt[0],this.y=3Dt[1]},_o.prototype.setScale=3Dfunction(t){this.scaleX=3Dt=
[0],this.scaleY=3Dt[1]},_o.prototype.setSkew=3Dfunction(t){this.skewX=3Dt[0=
],this.skewY=3Dt[1]},_o.prototype.setOrigin=3Dfunction(t){this.originX=3Dt[=
0],this.originY=3Dt[1]},_o.prototype.needLocalTransform=3Dfunction(){return=
 po(this.rotation)||po(this.x)||po(this.y)||po(this.scaleX-1)||po(this.scal=
eY-1)||po(this.skewX)||po(this.skewY)},_o.prototype.updateTransform=3Dfunct=
ion(){var t=3Dthis.parent&&this.parent.transform,e=3Dthis.needLocalTransfor=
m(),n=3Dthis.transform;e||t?(n=3Dn||Le(),e?this.getLocalTransform(n):co(n),=
t&&(e?Re(n,t,n):Oe(n,t)),this.transform=3Dn,this._resolveGlobalScaleRatio(n=
)):n&&(co(n),this.invTransform=3Dnull)},_o.prototype._resolveGlobalScaleRat=
io=3Dfunction(t){var e,n,i=3Dthis.globalScaleRatio;null!=3Di&&1!=3D=3Di&&(t=
his.getGlobalScale(fo),n=3D((fo[1]-(n=3Dfo[1]<0?-1:1))*i+n)/fo[1]||0,t[0]*=
=3Di=3D((fo[0]-(e=3Dfo[0]<0?-1:1))*i+e)/fo[0]||0,t[1]*=3Di,t[2]*=3Dn,t[3]*=
=3Dn),this.invTransform=3Dthis.invTransform||Le(),Be(this.invTransform,t)},=
_o.prototype.getComputedTransform=3Dfunction(){for(var t=3Dthis,e=3D[];t;)e=
.push(t),t=3Dt.parent;for(;t=3De.pop();)t.updateTransform();return this.tra=
nsform},_o.prototype.setLocalTransform=3Dfunction(t){var e,n,i,o;t&&(o=3Dt[=
0]*t[0]+t[1]*t[1],i=3Dt[2]*t[2]+t[3]*t[3],e=3DMath.atan2(t[1],t[0]),n=3DMat=
h.PI/2+e-Math.atan2(t[3],t[2]),i=3DMath.sqrt(i)*Math.cos(n),o=3DMath.sqrt(o=
),this.skewX=3Dn,this.skewY=3D0,this.rotation=3D-e,this.x=3D+t[4],this.y=3D=
+t[5],this.scaleX=3Do,this.scaleY=3Di,this.originX=3D0,this.originY=3D0)},_=
o.prototype.decomposeTransform=3Dfunction(){var t,e,n;this.transform&&(e=3D=
this.parent,t=3Dthis.transform,e&&e.transform&&(e.invTransform=3De.invTrans=
form||Le(),Re(go,e.invTransform,t),t=3Dgo),e=3Dthis.originX,n=3Dthis.origin=
Y,(e||n)&&(yo[4]=3De,yo[5]=3Dn,Re(go,t,yo),go[4]-=3De,go[5]-=3Dn,t=3Dgo),th=
is.setLocalTransform(t))},_o.prototype.getGlobalScale=3Dfunction(t){var e=
=3Dthis.transform;return t=3Dt||[],e?(t[0]=3DMath.sqrt(e[0]*e[0]+e[1]*e[1])=
,t[1]=3DMath.sqrt(e[2]*e[2]+e[3]*e[3]),e[0]<0&&(t[0]=3D-t[0]),e[3]<0&&(t[1]=
=3D-t[1])):(t[0]=3D1,t[1]=3D1),t},_o.prototype.transformCoordToLocal=3Dfunc=
tion(t,e){t=3D[t,e],e=3Dthis.invTransform;return e&&Jt(t,t,e),t},_o.prototy=
pe.transformCoordToGlobal=3Dfunction(t,e){t=3D[t,e],e=3Dthis.transform;retu=
rn e&&Jt(t,t,e),t},_o.prototype.getLineScale=3Dfunction(){var t=3Dthis.tran=
sform;return t&&1e-10<mo(t[0]-1)&&1e-10<mo(t[3]-1)?Math.sqrt(mo(t[0]*t[3]-t=
[2]*t[1])):1},_o.prototype.copyTransform=3Dfunction(t){for(var e=3Dthis,n=
=3Dt,i=3D0;i<xo.length;i++){var o=3Dxo[i];e[o]=3Dn[o]}},_o.getLocalTransfor=
m=3Dfunction(t,e){e=3De||[];var n=3Dt.originX||0,i=3Dt.originY||0,o=3Dt.sca=
leX,r=3Dt.scaleY,a=3Dt.anchorX,s=3Dt.anchorY,l=3Dt.rotation||0,u=3Dt.x,h=3D=
t.y,c=3Dt.skewX?Math.tan(t.skewX):0,t=3Dt.skewY?Math.tan(-t.skewY):0;return=
 n||i||a||s?(e[4]=3D-(a=3Dn+a)*o-c*(s=3Di+s)*r,e[5]=3D-s*r-t*a*o):e[4]=3De[=
5]=3D0,e[0]=3Do,e[3]=3Dr,e[1]=3Dt*o,e[2]=3Dc*r,l&&Ee(e,e,l),e[4]+=3Dn+u,e[5=
]+=3Di+h,e},_o.initDefaultProps=3D((e=3D_o.prototype).scaleX=3De.scaleY=3De=
.globalScaleRatio=3D1,void(e.x=3De.y=3De.originX=3De.originY=3De.skewX=3De.=
skewY=3De.rotation=3De.anchorX=3De.anchorY=3D0)),_o);function _o(){}var xo=
=3D["x","y","originX","originY","anchorX","anchorY","rotation","scaleX","sc=
aleY","skewX","skewY"];var wo=3D{};function bo(t,e){var n=3Dwo[e=3De||j],i=
=3D(n=3Dn||(wo[e]=3Dnew ti(500))).get(t);return null=3D=3Di&&(i=3DX.measure=
Text(t,e).width,n.put(t,i)),i}function So(t,e,n,i){t=3Dbo(t,e),e=3DCo(e),n=
=3DTo(0,t,n),i=3DIo(0,e,i);return new G(n,i,t,e)}function Mo(t,e,n,i){var o=
=3D((t||"")+"").split("\n");if(1=3D=3D=3Do.length)return So(o[0],e,n,i);for=
(var r=3Dnew G(0,0,0,0),a=3D0;a<o.length;a++){var s=3DSo(o[a],e,n,i);0=3D=
=3D=3Da?r.copy(s):r.union(s)}return r}function To(t,e,n){return"right"=3D=
=3D=3Dn?t-=3De:"center"=3D=3D=3Dn&&(t-=3De/2),t}function Io(t,e,n){return"m=
iddle"=3D=3D=3Dn?t-=3De/2:"bottom"=3D=3D=3Dn&&(t-=3De),t}function Co(t){ret=
urn bo("=E5=9B=BD",t)}function Do(t,e){return"string"=3D=3Dtypeof t?0<=3Dt.=
lastIndexOf("%")?parseFloat(t)/100*e:parseFloat(t):t}function ko(t,e,n){var=
 i=3De.position||"inside",o=3Dnull!=3De.distance?e.distance:5,r=3Dn.height,=
a=3Dn.width,s=3Dr/2,l=3Dn.x,u=3Dn.y,h=3D"left",c=3D"top";if(i instanceof Ar=
ray)l+=3DDo(i[0],n.width),u+=3DDo(i[1],n.height),c=3Dh=3Dnull;else switch(i=
){case"left":l-=3Do,u+=3Ds,h=3D"right",c=3D"middle";break;case"right":l+=3D=
o+a,u+=3Ds,c=3D"middle";break;case"top":l+=3Da/2,u-=3Do,h=3D"center",c=3D"b=
ottom";break;case"bottom":l+=3Da/2,u+=3Dr+o,h=3D"center";break;case"inside"=
:l+=3Da/2,u+=3Ds,h=3D"center",c=3D"middle";break;case"insideLeft":l+=3Do,u+=
=3Ds,c=3D"middle";break;case"insideRight":l+=3Da-o,u+=3Ds,h=3D"right",c=3D"=
middle";break;case"insideTop":l+=3Da/2,u+=3Do,h=3D"center";break;case"insid=
eBottom":l+=3Da/2,u+=3Dr-o,h=3D"center",c=3D"bottom";break;case"insideTopLe=
ft":l+=3Do,u+=3Do;break;case"insideTopRight":l+=3Da-o,u+=3Do,h=3D"right";br=
eak;case"insideBottomLeft":l+=3Do,u+=3Dr-o,c=3D"bottom";break;case"insideBo=
ttomRight":l+=3Da-o,u+=3Dr-o,h=3D"right",c=3D"bottom"}return(t=3Dt||{}).x=
=3Dl,t.y=3Du,t.align=3Dh,t.verticalAlign=3Dc,t}var Ao,Lo=3D"__zr_normal__",=
Po=3Dxo.concat(["ignore"]),Oo=3Dlt(xo,function(t,e){return t[e]=3D!0,t},{ig=
nore:!1}),Ro=3D{},No=3Dnew G(0,0,0,0),e=3D(n.prototype._init=3Dfunction(t){=
this.attr(t)},n.prototype.drift=3Dfunction(t,e,n){switch(this.draggable){ca=
se"horizontal":e=3D0;break;case"vertical":t=3D0}var i=3Dthis.transform;(i=
=3Di||(this.transform=3D[1,0,0,1,0,0]))[4]+=3Dt,i[5]+=3De,this.decomposeTra=
nsform(),this.markRedraw()},n.prototype.beforeUpdate=3Dfunction(){},n.proto=
type.afterUpdate=3Dfunction(){},n.prototype.update=3Dfunction(){this.update=
Transform(),this.__dirty&&this.updateInnerText()},n.prototype.updateInnerTe=
xt=3Dfunction(t){var e,n,i,o,r,a,s,l,u,h,c=3Dthis._textContent;!c||c.ignore=
&&!t||(this.textConfig||(this.textConfig=3D{}),l=3D(t=3Dthis.textConfig).lo=
cal,i=3Dn=3Dvoid 0,o=3D!1,(e=3Dc.innerTransformable).parent=3Dl?this:null,h=
=3D!1,e.copyTransform(c),null!=3Dt.position&&(u=3DNo,t.layoutRect?u.copy(t.=
layoutRect):u.copy(this.getBoundingRect()),l||u.applyTransform(this.transfo=
rm),this.calculateTextPosition?this.calculateTextPosition(Ro,t,u):ko(Ro,t,u=
),e.x=3DRo.x,e.y=3DRo.y,n=3DRo.align,i=3DRo.verticalAlign,r=3Dt.origin)&&nu=
ll!=3Dt.rotation&&(s=3Da=3Dvoid 0,s=3D"center"=3D=3D=3Dr?(a=3D.5*u.width,.5=
*u.height):(a=3DDo(r[0],u.width),Do(r[1],u.height)),h=3D!0,e.originX=3D-e.x=
+a+(l?0:u.x),e.originY=3D-e.y+s+(l?0:u.y)),null!=3Dt.rotation&&(e.rotation=
=3Dt.rotation),(r=3Dt.offset)&&(e.x+=3Dr[0],e.y+=3Dr[1],h||(e.originX=3D-r[=
0],e.originY=3D-r[1])),a=3Dnull=3D=3Dt.inside?"string"=3D=3Dtypeof t.positi=
on&&0<=3Dt.position.indexOf("inside"):t.inside,s=3Dthis._innerTextDefaultSt=
yle||(this._innerTextDefaultStyle=3D{}),h=3Du=3Dl=3Dvoid 0,a&&this.canBeIns=
ideText()?(l=3Dt.insideFill,u=3Dt.insideStroke,null!=3Dl&&"auto"!=3D=3Dl||(=
l=3Dthis.getInsideTextFill()),null!=3Du&&"auto"!=3D=3Du||(u=3Dthis.getInsid=
eTextStroke(l),h=3D!0)):(l=3Dt.outsideFill,u=3Dt.outsideStroke,null!=3Dl&&"=
auto"!=3D=3Dl||(l=3Dthis.getOutsideFill()),null!=3Du&&"auto"!=3D=3Du||(u=3D=
this.getOutsideStroke(l),h=3D!0)),(l=3Dl||"#000")=3D=3D=3Ds.fill&&u=3D=3D=
=3Ds.stroke&&h=3D=3D=3Ds.autoStroke&&n=3D=3D=3Ds.align&&i=3D=3D=3Ds.vertica=
lAlign||(o=3D!0,s.fill=3Dl,s.stroke=3Du,s.autoStroke=3Dh,s.align=3Dn,s.vert=
icalAlign=3Di,c.setDefaultTextStyle(s)),c.__dirty|=3Dmn,o&&c.dirtyStyle(!0)=
)},n.prototype.canBeInsideText=3Dfunction(){return!0},n.prototype.getInside=
TextFill=3Dfunction(){return"#fff"},n.prototype.getInsideTextStroke=3Dfunct=
ion(t){return"#000"},n.prototype.getOutsideFill=3Dfunction(){return this.__=
zr&&this.__zr.isDarkMode()?ho:uo},n.prototype.getOutsideStroke=3Dfunction(t=
){for(var e=3Dthis.__zr&&this.__zr.getBackgroundColor(),n=3D"string"=3D=3Dt=
ypeof e&&fi(e),i=3D(n=3Dn||[255,255,255,1])[3],o=3Dthis.__zr.isDarkMode(),r=
=3D0;r<3;r++)n[r]=3Dn[r]*i+(o?0:255)*(1-i);return n[3]=3D1,xi(n,"rgba")},n.=
prototype.traverse=3Dfunction(t,e){},n.prototype.attrKV=3Dfunction(t,e){"te=
xtConfig"=3D=3D=3Dt?this.setTextConfig(e):"textContent"=3D=3D=3Dt?this.setT=
extContent(e):"clipPath"=3D=3D=3Dt?this.setClipPath(e):"extra"=3D=3D=3Dt?(t=
his.extra=3Dthis.extra||{},P(this.extra,e)):this[t]=3De},n.prototype.hide=
=3Dfunction(){this.ignore=3D!0,this.markRedraw()},n.prototype.show=3Dfuncti=
on(){this.ignore=3D!1,this.markRedraw()},n.prototype.attr=3Dfunction(t,e){i=
f("string"=3D=3Dtypeof t)this.attrKV(t,e);else if(O(t))for(var n=3Dht(t),i=
=3D0;i<n.length;i++){var o=3Dn[i];this.attrKV(o,t[o])}return this.markRedra=
w(),this},n.prototype.saveCurrentToNormalState=3Dfunction(t){this._innerSav=
eToNormal(t);for(var e=3Dthis._normalState,n=3D0;n<this.animators.length;n+=
+){var i=3Dthis.animators[n],o=3Di.__fromStateTransition;i.getLoop()||o&&o!=
=3D=3DLo||(o=3D(o=3Di.targetName)?e[o]:e,i.saveTo(o))}},n.prototype._innerS=
aveToNormal=3Dfunction(t){var e=3D(e=3Dthis._normalState)||(this._normalSta=
te=3D{});t.textConfig&&!e.textConfig&&(e.textConfig=3Dthis.textConfig),this=
._savePrimaryToNormal(t,e,Po)},n.prototype._savePrimaryToNormal=3Dfunction(=
t,e,n){for(var i=3D0;i<n.length;i++){var o=3Dn[i];null=3D=3Dt[o]||o in e||(=
e[o]=3Dthis[o])}},n.prototype.hasState=3Dfunction(){return 0<this.currentSt=
ates.length},n.prototype.getState=3Dfunction(t){return this.states[t]},n.pr=
ototype.ensureState=3Dfunction(t){var e=3Dthis.states;return e[t]||(e[t]=3D=
{}),e[t]},n.prototype.clearStates=3Dfunction(t){this.useState(Lo,!1,t)},n.p=
rototype.useState=3Dfunction(t,e,n,i){var o=3Dt=3D=3D=3DLo;if(this.hasState=
()||!o){var r,a=3Dthis.currentStates,s=3Dthis.stateTransition;if(!(0<=3DC(a=
,t))||!e&&1!=3D=3Da.length){if((r=3D(r=3Dthis.stateProxy&&!o?this.stateProx=
y(t):r)||this.states&&this.states[t])||o)return o||this.saveCurrentToNormal=
State(r),(a=3D!!(r&&r.hoverLayer||i))&&this._toggleHoverLayerFlag(!0),this.=
_applyStateObj(t,r,this._normalState,e,!n&&!this.__inHover&&s&&0<s.duration=
,s),i=3Dthis._textContent,s=3Dthis._textGuide,i&&i.useState(t,e,n,a),s&&s.u=
seState(t,e,n,a),o?(this.currentStates=3D[],this._normalState=3D{}):e?this.=
currentStates.push(t):this.currentStates=3D[t],this._updateAnimationTargets=
(),this.markRedraw(),!a&&this.__inHover&&(this._toggleHoverLayerFlag(!1),th=
is.__dirty&=3D~mn),r;it("State "+t+" not exists.")}}},n.prototype.useStates=
=3Dfunction(t,e,n){if(t.length){var i=3D[],o=3Dthis.currentStates,r=3Dt.len=
gth,a=3Dr=3D=3D=3Do.length;if(a)for(var s=3D0;s<r;s++)if(t[s]!=3D=3Do[s]){a=
=3D!1;break}if(!a){for(s=3D0;s<r;s++){var l=3Dt[s],u=3Dvoid 0;(u=3D(u=3Dthi=
s.stateProxy?this.stateProxy(l,t):u)||this.states[l])&&i.push(u)}var h=3Di[=
r-1],h=3D!!(h&&h.hoverLayer||n),n=3D(h&&this._toggleHoverLayerFlag(!0),this=
._mergeStates(i)),c=3Dthis.stateTransition,n=3D(this.saveCurrentToNormalSta=
te(n),this._applyStateObj(t.join(","),n,this._normalState,!1,!e&&!this.__in=
Hover&&c&&0<c.duration,c),this._textContent),c=3Dthis._textGuide;n&&n.useSt=
ates(t,e,h),c&&c.useStates(t,e,h),this._updateAnimationTargets(),this.curre=
ntStates=3Dt.slice(),this.markRedraw(),!h&&this.__inHover&&(this._toggleHov=
erLayerFlag(!1),this.__dirty&=3D~mn)}}else this.clearStates()},n.prototype.=
isSilent=3Dfunction(){for(var t=3Dthis.silent,e=3Dthis.parent;!t&&e;){if(e.=
silent){t=3D!0;break}e=3De.parent}return t},n.prototype._updateAnimationTar=
gets=3Dfunction(){for(var t=3D0;t<this.animators.length;t++){var e=3Dthis.a=
nimators[t];e.targetName&&e.changeTarget(this[e.targetName])}},n.prototype.=
removeState=3Dfunction(t){var e,t=3DC(this.currentStates,t);0<=3Dt&&((e=3Dt=
his.currentStates.slice()).splice(t,1),this.useStates(e))},n.prototype.repl=
aceState=3Dfunction(t,e,n){var i=3Dthis.currentStates.slice(),t=3DC(i,t),o=
=3D0<=3DC(i,e);0<=3Dt?o?i.splice(t,1):i[t]=3De:n&&!o&&i.push(e),this.useSta=
tes(i)},n.prototype.toggleState=3Dfunction(t,e){e?this.useState(t,!0):this.=
removeState(t)},n.prototype._mergeStates=3Dfunction(t){for(var e,n=3D{},i=
=3D0;i<t.length;i++){var o=3Dt[i];P(n,o),o.textConfig&&P(e=3De||{},o.textCo=
nfig)}return e&&(n.textConfig=3De),n},n.prototype._applyStateObj=3Dfunction=
(t,e,n,i,o,r){var a=3D!(e&&i);e&&e.textConfig?(this.textConfig=3DP({},(i?th=
is:n).textConfig),P(this.textConfig,e.textConfig)):a&&n.textConfig&&(this.t=
extConfig=3Dn.textConfig);for(var s=3D{},l=3D!1,u=3D0;u<Po.length;u++){var =
h=3DPo[u],c=3Do&&Oo[h];e&&null!=3De[h]?c?(l=3D!0,s[h]=3De[h]):this[h]=3De[h=
]:a&&null!=3Dn[h]&&(c?(l=3D!0,s[h]=3Dn[h]):this[h]=3Dn[h])}if(!o)for(u=3D0;=
u<this.animators.length;u++){var p=3Dthis.animators[u],d=3Dp.targetName;p.g=
etLoop()||p.__changeFinalValue(d?(e||n)[d]:e||n)}l&&this._transitionState(t=
,s,r)},n.prototype._attachComponent=3Dfunction(t){var e;t.__zr&&!t.__hostTa=
rget||t!=3D=3Dthis&&((e=3Dthis.__zr)&&t.addSelfToZr(e),t.__zr=3De,t.__hostT=
arget=3Dthis)},n.prototype._detachComponent=3Dfunction(t){t.__zr&&t.removeS=
elfFromZr(t.__zr),t.__zr=3Dnull,t.__hostTarget=3Dnull},n.prototype.getClipP=
ath=3Dfunction(){return this._clipPath},n.prototype.setClipPath=3Dfunction(=
t){this._clipPath&&this._clipPath!=3D=3Dt&&this.removeClipPath(),this._atta=
chComponent(t),this._clipPath=3Dt,this.markRedraw()},n.prototype.removeClip=
Path=3Dfunction(){var t=3Dthis._clipPath;t&&(this._detachComponent(t),this.=
_clipPath=3Dnull,this.markRedraw())},n.prototype.getTextContent=3Dfunction(=
){return this._textContent},n.prototype.setTextContent=3Dfunction(t){var e=
=3Dthis._textContent;e!=3D=3Dt&&(e&&e!=3D=3Dt&&this.removeTextContent(),t.i=
nnerTransformable=3Dnew vo,this._attachComponent(t),this._textContent=3Dt,t=
his.markRedraw())},n.prototype.setTextConfig=3Dfunction(t){this.textConfig|=
|(this.textConfig=3D{}),P(this.textConfig,t),this.markRedraw()},n.prototype=
.removeTextConfig=3Dfunction(){this.textConfig=3Dnull,this.markRedraw()},n.=
prototype.removeTextContent=3Dfunction(){var t=3Dthis._textContent;t&&(t.in=
nerTransformable=3Dnull,this._detachComponent(t),this._textContent=3Dnull,t=
his._innerTextDefaultStyle=3Dnull,this.markRedraw())},n.prototype.getTextGu=
ideLine=3Dfunction(){return this._textGuide},n.prototype.setTextGuideLine=
=3Dfunction(t){this._textGuide&&this._textGuide!=3D=3Dt&&this.removeTextGui=
deLine(),this._attachComponent(t),this._textGuide=3Dt,this.markRedraw()},n.=
prototype.removeTextGuideLine=3Dfunction(){var t=3Dthis._textGuide;t&&(this=
._detachComponent(t),this._textGuide=3Dnull,this.markRedraw())},n.prototype=
.markRedraw=3Dfunction(){this.__dirty|=3Dmn;var t=3Dthis.__zr;t&&(this.__in=
Hover?t.refreshHover():t.refresh()),this.__hostTarget&&this.__hostTarget.ma=
rkRedraw()},n.prototype.dirty=3Dfunction(){this.markRedraw()},n.prototype._=
toggleHoverLayerFlag=3Dfunction(t){this.__inHover=3Dt;var e=3Dthis._textCon=
tent,n=3Dthis._textGuide;e&&(e.__inHover=3Dt),n&&(n.__inHover=3Dt)},n.proto=
type.addSelfToZr=3Dfunction(t){if(this.__zr!=3D=3Dt){this.__zr=3Dt;var e=3D=
this.animators;if(e)for(var n=3D0;n<e.length;n++)t.animation.addAnimator(e[=
n]);this._clipPath&&this._clipPath.addSelfToZr(t),this._textContent&&this._=
textContent.addSelfToZr(t),this._textGuide&&this._textGuide.addSelfToZr(t)}=
},n.prototype.removeSelfFromZr=3Dfunction(t){if(this.__zr){this.__zr=3Dnull=
;var e=3Dthis.animators;if(e)for(var n=3D0;n<e.length;n++)t.animation.remov=
eAnimator(e[n]);this._clipPath&&this._clipPath.removeSelfFromZr(t),this._te=
xtContent&&this._textContent.removeSelfFromZr(t),this._textGuide&&this._tex=
tGuide.removeSelfFromZr(t)}},n.prototype.animate=3Dfunction(t,e,n){var i=3D=
t?this[t]:this,i=3Dnew Ni(i,e,n);return t&&(i.targetName=3Dt),this.addAnima=
tor(i,t),i},n.prototype.addAnimator=3Dfunction(n,t){var e=3Dthis.__zr,i=3Dt=
his;n.during(function(){i.updateDuringAnimation(t)}).done(function(){var t=
=3Di.animators,e=3DC(t,n);0<=3De&&t.splice(e,1)}),this.animators.push(n),e&=
&e.animation.addAnimator(n),e&&e.wakeUp()},n.prototype.updateDuringAnimatio=
n=3Dfunction(t){this.markRedraw()},n.prototype.stopAnimation=3Dfunction(t,e=
){for(var n=3Dthis.animators,i=3Dn.length,o=3D[],r=3D0;r<i;r++){var a=3Dn[r=
];t&&t!=3D=3Da.scope?o.push(a):a.stop(e)}return this.animators=3Do,this},n.=
prototype.animateTo=3Dfunction(t,e,n){zo(this,t,e,n)},n.prototype.animateFr=
om=3Dfunction(t,e,n){zo(this,t,e,n,!0)},n.prototype._transitionState=3Dfunc=
tion(t,e,n,i){for(var o=3Dzo(this,e,n,i),r=3D0;r<o.length;r++)o[r].__fromSt=
ateTransition=3Dt},n.prototype.getBoundingRect=3Dfunction(){return null},n.=
prototype.getPaintRect=3Dfunction(){return null},n.initDefaultProps=3D((Ao=
=3Dn.prototype).type=3D"element",Ao.name=3D"",Ao.ignore=3DAo.silent=3DAo.is=
Group=3DAo.draggable=3DAo.dragging=3DAo.ignoreClip=3DAo.__inHover=3D!1,Ao._=
_dirty=3Dmn,void(Object.defineProperty&&(Eo("position","_legacyPos","x","y"=
),Eo("scale","_legacyScale","scaleX","scaleY"),Eo("origin","_legacyOrigin",=
"originX","originY")))),n);function n(t){this.id=3Det++,this.animators=3D[]=
,this.currentStates=3D[],this.states=3D{},this._init(t)}function Eo(t,e,n,i=
){function o(e,t){Object.defineProperty(t,0,{get:function(){return e[n]},se=
t:function(t){e[n]=3Dt}}),Object.defineProperty(t,1,{get:function(){return =
e[i]},set:function(t){e[i]=3Dt}})}Object.defineProperty(Ao,t,{get:function(=
){return this[e]||o(this,this[e]=3D[]),this[e]},set:function(t){this[n]=3Dt=
[0],this[i]=3Dt[1],this[e]=3Dt,o(this,t)}})}function zo(t,e,n,i,o){function=
 r(){u=3D!0,--l<=3D0&&(u?h&&h():c&&c())}function a(){--l<=3D0&&(u?h&&h():c&=
&c())}var s=3D[],l=3D(!function t(e,n,i,o,r,a,s,l){for(var u=3Dht(o),h=3Dr.=
duration,c=3Dr.delay,p=3Dr.additive,d=3Dr.setToFinal,f=3D!O(a),g=3De.animat=
ors,y=3D[],m=3D0;m<u.length;m++){var v=3Du[m],_=3Do[v];null!=3D_&&null!=3Di=
[v]&&(f||a[v])?!O(_)||st(_)||gt(_)?y.push(v):n?l||(i[v]=3D_,e.updateDuringA=
nimation(n)):t(e,v,i[v],_,r,a&&a[v],s,l):l||(i[v]=3D_,e.updateDuringAnimati=
on(n),y.push(v))}var x=3Dy.length;if(!p&&x)for(var w=3D0;w<g.length;w++){va=
r b;(S=3Dg[w]).targetName=3D=3D=3Dn&&S.stopTracks(y)&&(b=3DC(g,S),g.splice(=
b,1))}if(r.force||(x=3D(y=3Dut(y,function(t){return!Vo(o[t],i[t])})).length=
),0<x||r.force&&!s.length){var S,M=3Dvoid 0,T=3Dvoid 0,I=3Dvoid 0;if(l)for(=
T=3D{},d&&(M=3D{}),w=3D0;w<x;w++)T[v=3Dy[w]]=3Di[v],d?M[v]=3Do[v]:i[v]=3Do[=
v];else if(d)for(I=3D{},w=3D0;w<x;w++)I[v=3Dy[w]]=3Dki(i[v]),Fo(i,o,v);(S=
=3Dnew Ni(i,!1,!1,p?ut(g,function(t){return t.targetName=3D=3D=3Dn}):null))=
.targetName=3Dn,r.scope&&(S.scope=3Dr.scope),d&&M&&S.whenWithKeys(0,M,y),I&=
&S.whenWithKeys(0,I,y),S.whenWithKeys(null=3D=3Dh?500:h,l?T:o,y).delay(c||0=
),e.addAnimator(S,n),s.push(S)}}(t,"",t,e,n=3Dn||{},i,s,o),s.length),u=3D!1=
,h=3Dn.done,c=3Dn.aborted;l||h&&h(),0<s.length&&n.during&&s[0].during(funct=
ion(t,e){n.during(e)});for(var p=3D0;p<s.length;p++){var d=3Ds[p];d.done(r)=
,d.aborted(a),n.force&&d.duration(n.duration),d.start(n.easing)}return s}fu=
nction Bo(t,e,n){for(var i=3D0;i<n;i++)t[i]=3De[i]}function Fo(t,e,n){if(st=
(e[n]))if(st(t[n])||(t[n]=3D[]),dt(e[n])){var i=3De[n].length;t[n].length!=
=3D=3Di&&(t[n]=3Dnew e[n].constructor(i),Bo(t[n],e[n],i))}else{var o=3De[n]=
,r=3Dt[n],a=3Do.length;if(st(o[0]))for(var s=3Do[0].length,l=3D0;l<a;l++)r[=
l]?Bo(r[l],o[l],s):r[l]=3DArray.prototype.slice.call(o[l]);else Bo(r,o,a);r=
.length=3Do.length}else t[n]=3De[n]}function Vo(t,e){return t=3D=3D=3De||st=
(t)&&st(e)&&function(t,e){var n=3Dt.length;if(n!=3D=3De.length)return!1;for=
(var i=3D0;i<n;i++)if(t[i]!=3D=3De[i])return!1;return!0}(t,e)}at(e,ae),at(e=
,vo);u(Go,Ho=3De),Go.prototype.childrenRef=3Dfunction(){return this._childr=
en},Go.prototype.children=3Dfunction(){return this._children.slice()},Go.pr=
ototype.childAt=3Dfunction(t){return this._children[t]},Go.prototype.childO=
fName=3Dfunction(t){for(var e=3Dthis._children,n=3D0;n<e.length;n++)if(e[n]=
.name=3D=3D=3Dt)return e[n]},Go.prototype.childCount=3Dfunction(){return th=
is._children.length},Go.prototype.add=3Dfunction(t){return t&&t!=3D=3Dthis&=
&t.parent!=3D=3Dthis&&(this._children.push(t),this._doAdd(t)),this},Go.prot=
otype.addBefore=3Dfunction(t,e){var n;return t&&t!=3D=3Dthis&&t.parent!=3D=
=3Dthis&&e&&e.parent=3D=3D=3Dthis&&0<=3D(e=3D(n=3Dthis._children).indexOf(e=
))&&(n.splice(e,0,t),this._doAdd(t)),this},Go.prototype.replace=3Dfunction(=
t,e){t=3DC(this._children,t);return 0<=3Dt&&this.replaceAt(e,t),this},Go.pr=
ototype.replaceAt=3Dfunction(t,e){var n=3Dthis._children,i=3Dn[e];return t&=
&t!=3D=3Dthis&&t.parent!=3D=3Dthis&&t!=3D=3Di&&(n[e]=3Dt,i.parent=3Dnull,(n=
=3Dthis.__zr)&&i.removeSelfFromZr(n),this._doAdd(t)),this},Go.prototype._do=
Add=3Dfunction(t){t.parent&&t.parent.remove(t);var e=3D(t.parent=3Dthis).__=
zr;e&&e!=3D=3Dt.__zr&&t.addSelfToZr(e),e&&e.refresh()},Go.prototype.remove=
=3Dfunction(t){var e=3Dthis.__zr,n=3Dthis._children,i=3DC(n,t);return i<0||=
(n.splice(i,1),t.parent=3Dnull,e&&t.removeSelfFromZr(e),e&&e.refresh()),thi=
s},Go.prototype.removeAll=3Dfunction(){for(var t=3Dthis._children,e=3Dthis.=
__zr,n=3D0;n<t.length;n++){var i=3Dt[n];e&&i.removeSelfFromZr(e),i.parent=
=3Dnull}return t.length=3D0,this},Go.prototype.eachChild=3Dfunction(t,e){fo=
r(var n=3Dthis._children,i=3D0;i<n.length;i++){var o=3Dn[i];t.call(e,o,i)}r=
eturn this},Go.prototype.traverse=3Dfunction(t,e){for(var n=3D0;n<this._chi=
ldren.length;n++){var i=3Dthis._children[n],o=3Dt.call(e,i);i.isGroup&&!o&&=
i.traverse(t,e)}return this},Go.prototype.addSelfToZr=3Dfunction(t){Ho.prot=
otype.addSelfToZr.call(this,t);for(var e=3D0;e<this._children.length;e++)th=
is._children[e].addSelfToZr(t)},Go.prototype.removeSelfFromZr=3Dfunction(t)=
{Ho.prototype.removeSelfFromZr.call(this,t);for(var e=3D0;e<this._children.=
length;e++)this._children[e].removeSelfFromZr(t)},Go.prototype.getBoundingR=
ect=3Dfunction(t){for(var e=3Dnew G(0,0,0,0),n=3Dt||this._children,i=3D[],o=
=3Dnull,r=3D0;r<n.length;r++){var a,s=3Dn[r];s.ignore||s.invisible||(a=3Ds.=
getBoundingRect(),(s=3Ds.getLocalTransform(i))?(G.applyTransform(e,a,s),(o=
=3Do||e.clone()).union(e)):(o=3Do||a.clone()).union(a))}return o||e};var Ho=
,Wo=3DGo;function Go(t){var e=3DHo.call(this)||this;return e.isGroup=3D!0,e=
._children=3D[],e.attr(t),e}Wo.prototype.type=3D"group";var Xo=3D{},Uo=3D{}=
;qo.prototype.add=3Dfunction(t){!this._disposed&&t&&(this.storage.addRoot(t=
),t.addSelfToZr(this),this.refresh())},qo.prototype.remove=3Dfunction(t){!t=
his._disposed&&t&&(this.storage.delRoot(t),t.removeSelfFromZr(this),this.re=
fresh())},qo.prototype.configLayer=3Dfunction(t,e){this._disposed||(this.pa=
inter.configLayer&&this.painter.configLayer(t,e),this.refresh())},qo.protot=
ype.setBackgroundColor=3Dfunction(t){this._disposed||(this.painter.setBackg=
roundColor&&this.painter.setBackgroundColor(t),this.refresh(),this._backgro=
undColor=3Dt,this._darkMode=3Dfunction(t){if(t){if("string"=3D=3Dtypeof t)r=
eturn wi(t,1)<.4;if(t.colorStops){for(var e=3Dt.colorStops,n=3D0,i=3De.leng=
th,o=3D0;o<i;o++)n+=3Dwi(e[o].color,1);return(n/=3Di)<.4}}return!1}(t))},qo=
.prototype.getBackgroundColor=3Dfunction(){return this._backgroundColor},qo=
.prototype.setDarkMode=3Dfunction(t){this._darkMode=3Dt},qo.prototype.isDar=
kMode=3Dfunction(){return this._darkMode},qo.prototype.refreshImmediately=
=3Dfunction(t){this._disposed||(t||this.animation.update(!0),this._needsRef=
resh=3D!1,this.painter.refresh(),this._needsRefresh=3D!1)},qo.prototype.ref=
resh=3Dfunction(){this._disposed||(this._needsRefresh=3D!0,this.animation.s=
tart())},qo.prototype.flush=3Dfunction(){this._disposed||this._flush(!1)},q=
o.prototype._flush=3Dfunction(t){var e,n=3DBi(),t=3D(this._needsRefresh&&(e=
=3D!0,this.refreshImmediately(t)),this._needsRefreshHover&&(e=3D!0,this.ref=
reshHoverImmediately()),Bi());e?(this._stillFrameAccum=3D0,this.trigger("re=
ndered",{elapsedTime:t-n})):0<this._sleepAfterStill&&(this._stillFrameAccum=
++,this._stillFrameAccum>this._sleepAfterStill)&&this.animation.stop()},qo.=
prototype.setSleepAfterStill=3Dfunction(t){this._sleepAfterStill=3Dt},qo.pr=
ototype.wakeUp=3Dfunction(){this._disposed||(this.animation.start(),this._s=
tillFrameAccum=3D0)},qo.prototype.refreshHover=3Dfunction(){this._needsRefr=
eshHover=3D!0},qo.prototype.refreshHoverImmediately=3Dfunction(){this._disp=
osed||(this._needsRefreshHover=3D!1,this.painter.refreshHover&&"canvas"=3D=
=3D=3Dthis.painter.getType()&&this.painter.refreshHover())},qo.prototype.re=
size=3Dfunction(t){this._disposed||(this.painter.resize((t=3Dt||{}).width,t=
.height),this.handler.resize())},qo.prototype.clearAnimation=3Dfunction(){t=
his._disposed||this.animation.clear()},qo.prototype.getWidth=3Dfunction(){i=
f(!this._disposed)return this.painter.getWidth()},qo.prototype.getHeight=3D=
function(){if(!this._disposed)return this.painter.getHeight()},qo.prototype=
.setCursorStyle=3Dfunction(t){this._disposed||this.handler.setCursorStyle(t=
)},qo.prototype.findHover=3Dfunction(t,e){if(!this._disposed)return this.ha=
ndler.findHover(t,e)},qo.prototype.on=3Dfunction(t,e,n){return this._dispos=
ed||this.handler.on(t,e,n),this},qo.prototype.off=3Dfunction(t,e){this._dis=
posed||this.handler.off(t,e)},qo.prototype.trigger=3Dfunction(t,e){this._di=
sposed||this.handler.trigger(t,e)},qo.prototype.clear=3Dfunction(){if(!this=
._disposed){for(var t=3Dthis.storage.getRoots(),e=3D0;e<t.length;e++)t[e]in=
stanceof Wo&&t[e].removeSelfFromZr(this);this.storage.delAllRoots(),this.pa=
inter.clear()}},qo.prototype.dispose=3Dfunction(){var t;this._disposed||(th=
is.animation.stop(),this.clear(),this.storage.dispose(),this.painter.dispos=
e(),this.handler.dispose(),this.animation=3Dthis.storage=3Dthis.painter=3Dt=
his.handler=3Dnull,this._disposed=3D!0,t=3Dthis.id,delete Uo[t])};var Yo,Zo=
=3Dqo;function qo(t,e,n){var i=3Dthis,o=3D(this._sleepAfterStill=3D10,this.=
_stillFrameAccum=3D0,this._needsRefresh=3D!0,this._needsRefreshHover=3D!0,t=
his._darkMode=3D!1,n=3Dn||{},this.dom=3De,this.id=3Dt,new bn),r=3Dn.rendere=
r||"canvas",r=3D(Xo[r]||(r=3Dht(Xo)[0]),n.useDirtyRect=3Dnull!=3Dn.useDirty=
Rect&&n.useDirtyRect,new Xo[r](e,o,n,t)),e=3Dn.ssr||r.ssrOnly;this.storage=
=3Do,this.painter=3Dr;var a,t=3Db.node||b.worker||e?null:new ao(r.getViewpo=
rtRoot(),r.root),s=3Dn.useCoarsePointer;(null=3D=3Ds||"auto"=3D=3D=3Ds?b.to=
uchEventsSupported:s)&&(a=3DR(n.pointerSize,44)),this.handler=3Dnew rn(o,r,=
t,r.root,a),this.animation=3Dnew Vi({stage:{update:e?null:function(){return=
 i._flush(!0)}}}),e||this.animation.start()}function jo(t,e){t=3Dnew Zo(et+=
+,t,e);return Uo[t.id]=3Dt}function Ko(t,e){Xo[t]=3De}function $o(t){Yo=3Dt=
}var Qo=3DObject.freeze({__proto__:null,dispose:function(t){t.dispose()},di=
sposeAll:function(){for(var t in Uo)Uo.hasOwnProperty(t)&&Uo[t].dispose();U=
o=3D{}},getElementSSRData:function(t){if("function"=3D=3Dtypeof Yo)return Y=
o(t)},getInstance:function(t){return Uo[t]},init:jo,registerPainter:Ko,regi=
sterSSRDataGetter:$o,version:"5.5.0"}),Jo=3D20;function tr(t,e,n,i){var o=
=3De[0],e=3De[1],r=3Dn[0],n=3Dn[1],a=3De-o,s=3Dn-r;if(0=3D=3Da)return 0=3D=
=3Ds?r:(r+n)/2;if(i)if(0<a){if(t<=3Do)return r;if(e<=3Dt)return n}else{if(o=
<=3Dt)return r;if(t<=3De)return n}else{if(t=3D=3D=3Do)return r;if(t=3D=3D=
=3De)return n}return(t-o)/a*s+r}function er(t,e){switch(t){case"center":cas=
e"middle":t=3D"50%";break;case"left":case"top":t=3D"0%";break;case"right":c=
ase"bottom":t=3D"100%"}return H(t)?t.replace(/^\s+|\s+$/g,"").match(/%$/)?p=
arseFloat(t)/100*e:parseFloat(t):null=3D=3Dt?NaN:+t}function nr(t,e,n){retu=
rn null=3D=3De&&(e=3D10),e=3DMath.min(Math.max(0,e),Jo),t=3D(+t).toFixed(e)=
,n?t:+t}function ir(t){return t.sort(function(t,e){return t-e}),t}function =
or(t){if(t=3D+t,isNaN(t))return 0;if(1e-14<t)for(var e=3D1,n=3D0;n<15;n++,e=
*=3D10)if(Math.round(t*e)/e=3D=3D=3Dt)return n;return rr(t)}function rr(t){=
var t=3Dt.toString().toLowerCase(),e=3Dt.indexOf("e"),n=3D0<e?+t.slice(e+1)=
:0,e=3D0<e?e:t.length,t=3Dt.indexOf(".");return Math.max(0,(t<0?0:e-1-t)-n)=
}function ar(t,e){var n=3DMath.log,i=3DMath.LN10,t=3DMath.floor(n(t[1]-t[0]=
)/i),n=3DMath.round(n(Math.abs(e[1]-e[0]))/i),e=3DMath.min(Math.max(-t+n,0)=
,20);return isFinite(e)?e:20}function sr(t,e){var n=3Dlt(t,function(t,e){re=
turn t+(isNaN(e)?0:e)},0);if(0=3D=3D=3Dn)return[];for(var i=3DMath.pow(10,e=
),e=3DF(t,function(t){return(isNaN(t)?0:t)/n*i*100}),o=3D100*i,r=3DF(e,func=
tion(t){return Math.floor(t)}),a=3Dlt(r,function(t,e){return t+e},0),s=3DF(=
e,function(t,e){return t-r[e]});a<o;){for(var l=3DNumber.NEGATIVE_INFINITY,=
u=3Dnull,h=3D0,c=3Ds.length;h<c;++h)s[h]>l&&(l=3Ds[h],u=3Dh);++r[u],s[u]=3D=
0,++a}return F(r,function(t){return t/i})}function lr(t){var e=3D2*Math.PI;=
return(t%e+e)%e}function ur(t){return-1e-4<t&&t<1e-4}var hr=3D/^(?:(\d{4})(=
?:[-\/](\d{1,2})(?:[-\/](\d{1,2})(?:[T ](\d{1,2})(?::(\d{1,2})(?::(\d{1,2})=
(?:[.,](\d+))?)?)?(Z|[\+\-]\d\d:?\d\d)?)?)?)?)?$/;function cr(t){var e,n;re=
turn t instanceof Date?t:H(t)?(e=3Dhr.exec(t))?e[8]?(n=3D+e[4]||0,"Z"!=3D=
=3De[8].toUpperCase()&&(n-=3D+e[8].slice(0,3)),new Date(Date.UTC(+e[1],+(e[=
2]||1)-1,+e[3]||1,n,+(e[5]||0),+e[6]||0,e[7]?+e[7].substring(0,3):0))):new =
Date(+e[1],+(e[2]||1)-1,+e[3]||1,+e[4]||0,+(e[5]||0),+e[6]||0,e[7]?+e[7].su=
bstring(0,3):0):new Date(NaN):null=3D=3Dt?new Date(NaN):new Date(Math.round=
(t))}function pr(t){return Math.pow(10,dr(t))}function dr(t){var e;return 0=
=3D=3D=3Dt?0:(e=3DMath.floor(Math.log(t)/Math.LN10),10<=3Dt/Math.pow(10,e)&=
&e++,e)}function fr(t,e){var n=3Ddr(t),i=3DMath.pow(10,n),o=3Dt/i;return t=
=3D(e?o<1.5?1:o<2.5?2:o<4?3:o<7?5:10:o<1?1:o<2?2:o<3?3:o<5?5:10)*i,-20<=3Dn=
?+t.toFixed(n<0?-n:0):t}function gr(t){var e=3DparseFloat(t);return e=3D=3D=
t&&(0!=3D=3De||!H(t)||t.indexOf("x")<=3D0)?e:NaN}function yr(t){return!isNa=
N(gr(t))}function mr(){return Math.round(9*Math.random())}function vr(t,e){=
return null=3D=3Dt?e:null=3D=3De?t:t*e/function t(e,n){return 0=3D=3D=3Dn?e=
:t(n,e%n)}(t,e)}function f(t){throw new Error(t)}function _r(t,e,n){return(=
e-t)*n+t}var xr=3D"series\0",wr=3D"\0_ec_\0";function br(t){return t instan=
ceof Array?t:null=3D=3Dt?[]:[t]}function Sr(t,e,n){if(t){t[e]=3Dt[e]||{},t.=
emphasis=3Dt.emphasis||{},t.emphasis[e]=3Dt.emphasis[e]||{};for(var i=3D0,o=
=3Dn.length;i<o;i++){var r=3Dn[i];!t.emphasis[e].hasOwnProperty(r)&&t[e].ha=
sOwnProperty(r)&&(t.emphasis[e][r]=3Dt[e][r])}}}var Mr=3D["fontStyle","font=
Weight","fontSize","fontFamily","rich","tag","color","textBorderColor","tex=
tBorderWidth","width","height","lineHeight","align","verticalAlign","baseli=
ne","shadowColor","shadowBlur","shadowOffsetX","shadowOffsetY","textShadowC=
olor","textShadowBlur","textShadowOffsetX","textShadowOffsetY","backgroundC=
olor","borderColor","borderWidth","borderRadius","padding"];function Tr(t){=
return!O(t)||V(t)||t instanceof Date?t:t.value}function Ir(t,n,e){var a,i,o=
,r,s,l,u,h,c,p,d=3D"normalMerge"=3D=3D=3De,f=3D"replaceMerge"=3D=3D=3De,g=
=3D"replaceAll"=3D=3D=3De,y=3D(t=3Dt||[],n=3D(n||[]).slice(),N()),e=3D(E(n,=
function(t,e){O(t)||(n[e]=3Dnull)}),function(t,e,n){var i=3D[];if("replaceA=
ll"!=3D=3Dn)for(var o=3D0;o<t.length;o++){var r=3Dt[o];r&&null!=3Dr.id&&e.s=
et(r.id,o),i.push({existing:"replaceMerge"=3D=3D=3Dn||Lr(r)?null:r,newOptio=
n:null,keyInfo:null,brandNew:null})}return i}(t,y,e));return(d||f)&&(u=3De,=
h=3Dt,c=3Dy,E(p=3Dn,function(t,e){var n,i,o;t&&null!=3Dt.id&&(n=3DDr(t.id),=
null!=3D(i=3Dc.get(n)))&&(St(!(o=3Du[i]).newOption,'Duplicated option on id=
 "'+n+'".'),o.newOption=3Dt,o.existing=3Dh[i],p[e]=3Dnull)})),d&&(s=3De,E(l=
=3Dn,function(t,e){if(t&&null!=3Dt.name)for(var n=3D0;n<s.length;n++){var i=
=3Ds[n].existing;if(!s[n].newOption&&i&&(null=3D=3Di.id||null=3D=3Dt.id)&&!=
Lr(t)&&!Lr(i)&&Cr("name",i,t))return s[n].newOption=3Dt,void(l[e]=3Dnull)}}=
)),d||f?(o=3De,r=3Df,E(n,function(t){if(t){for(var e,n=3D0;(e=3Do[n])&&(e.n=
ewOption||Lr(e.existing)||e.existing&&null!=3Dt.id&&!Cr("id",t,e.existing))=
;)n++;e?(e.newOption=3Dt,e.brandNew=3Dr):o.push({newOption:t,brandNew:r,exi=
sting:null,keyInfo:null}),n++}})):g&&(i=3De,E(n,function(t){i.push({newOpti=
on:t,brandNew:!0,existing:null,keyInfo:null})})),t=3De,a=3DN(),E(t,function=
(t){var e=3Dt.existing;e&&a.set(e.id,t)}),E(t,function(t){var e=3Dt.newOpti=
on;St(!e||null=3D=3De.id||!a.get(e.id)||a.get(e.id)=3D=3D=3Dt,"id duplicate=
s: "+(e&&e.id)),e&&null!=3De.id&&a.set(e.id,t),t.keyInfo||(t.keyInfo=3D{})}=
),E(t,function(t,e){var n=3Dt.existing,i=3Dt.newOption,o=3Dt.keyInfo;if(O(i=
)){if(o.name=3Dnull!=3Di.name?Dr(i.name):n?n.name:xr+e,n)o.id=3DDr(n.id);el=
se if(null!=3Di.id)o.id=3DDr(i.id);else for(var r=3D0;o.id=3D"\0"+o.name+"\=
0"+r++,a.get(o.id););a.set(o.id,t)}}),e}function Cr(t,e,n){e=3Dkr(e[t],null=
),n=3Dkr(n[t],null);return null!=3De&&null!=3Dn&&e=3D=3D=3Dn}function Dr(t)=
{return kr(t,"")}function kr(t,e){return null=3D=3Dt?e:H(t)?t:W(t)||ct(t)?t=
+"":e}function Ar(t){t=3Dt.name;return!(!t||!t.indexOf(xr))}function Lr(t){=
return t&&null!=3Dt.id&&0=3D=3D=3DDr(t.id).indexOf(wr)}function Pr(t,o,r){E=
(t,function(t){var e,n,i=3Dt.newOption;O(i)&&(t.keyInfo.mainType=3Do,t.keyI=
nfo.subType=3D(e=3Do,i=3Di,t=3Dt.existing,n=3Dr,i.type||(t?t.subType:n.dete=
rmineSubType(e,i))))})}function Or(e,t){return null!=3Dt.dataIndexInside?t.=
dataIndexInside:null!=3Dt.dataIndex?V(t.dataIndex)?F(t.dataIndex,function(t=
){return e.indexOfRawIndex(t)}):e.indexOfRawIndex(t.dataIndex):null!=3Dt.na=
me?V(t.name)?F(t.name,function(t){return e.indexOfName(t)}):e.indexOfName(t=
.name):void 0}function Rr(){var e=3D"__ec_inner_"+Nr++;return function(t){r=
eturn t[e]||(t[e]=3D{})}}var Nr=3Dmr();function Er(n,t,i){var t=3Dzr(t,i),e=
=3Dt.mainTypeSpecified,o=3Dt.queryOptionMap,r=3Dt.others,a=3Di?i.defaultMai=
nType:null;return!e&&a&&o.set(a,{}),o.each(function(t,e){t=3DVr(n,e,t,{useD=
efault:a=3D=3D=3De,enableAll:!i||null=3D=3Di.enableAll||i.enableAll,enableN=
one:!i||null=3D=3Di.enableNone||i.enableNone});r[e+"Models"]=3Dt.models,r[e=
+"Model"]=3Dt.models[0]}),r}function zr(t,o){var e=3DH(t)?((e=3D{})[t+"Inde=
x"]=3D0,e):t,r=3DN(),a=3D{},s=3D!1;return E(e,function(t,e){var n,i;"dataIn=
dex"!=3D=3De&&"dataIndexInside"!=3D=3De?(n=3D(i=3De.match(/^(\w+)(Index|Id|=
Name)$/)||[])[1],i=3D(i[2]||"").toLowerCase(),!n||!i||o&&o.includeMainTypes=
&&C(o.includeMainTypes,n)<0||(s=3Ds||!!n,(r.get(n)||r.set(n,{}))[i]=3Dt)):a=
[e]=3Dt}),{mainTypeSpecified:s,queryOptionMap:r,others:a}}var Br=3D{useDefa=
ult:!0,enableAll:!1,enableNone:!1},Fr=3D{useDefault:!1,enableAll:!0,enableN=
one:!0};function Vr(t,e,n,i){i=3Di||Br;var o=3Dn.index,r=3Dn.id,n=3Dn.name,=
a=3D{models:null,specified:null!=3Do||null!=3Dr||null!=3Dn};return a.specif=
ied?"none"=3D=3D=3Do||!1=3D=3D=3Do?(St(i.enableNone,'`"none"` or `false` is=
 not a valid value on index option.'),a.models=3D[]):("all"=3D=3D=3Do&&(St(=
i.enableAll,'`"all"` is not a valid value on index option.'),o=3Dr=3Dn=3Dnu=
ll),a.models=3Dt.queryComponents({mainType:e,index:o,id:r,name:n})):(o=3Dvo=
id 0,a.models=3Di.useDefault&&(o=3Dt.getComponent(e))?[o]:[]),a}function Hr=
(t,e,n){t.setAttribute?t.setAttribute(e,n):t[e]=3Dn}function Wr(t,e,n,i,o){=
var r=3Dnull=3D=3De||"auto"=3D=3D=3De;if(null=3D=3Di)return i;if(W(i))retur=
n nr(p=3D_r(n||0,i,o),r?Math.max(or(n||0),or(i)):e);if(H(i))return o<1?n:i;=
for(var a=3D[],s=3Dn,l=3Di,u=3DMath.max(s?s.length:0,l.length),h=3D0;h<u;++=
h){var c,p,d=3Dt.getDimensionInfo(h);d&&"ordinal"=3D=3D=3Dd.type?a[h]=3D(o<=
1&&s?s:l)[h]:(p=3D_r(d=3Ds&&s[h]?s[h]:0,c=3Dl[h],o),a[h]=3Dnr(p,r?Math.max(=
or(d),or(c)):e))}return a}var Gr=3D".",Xr=3D"___EC__COMPONENT__CONTAINER___=
",Ur=3D"___EC__EXTENDED_CLASS___";function Yr(t){var e=3D{main:"",sub:""};r=
eturn t&&(t=3Dt.split(Gr),e.main=3Dt[0]||"",e.sub=3Dt[1]||""),e}function Zr=
(t){(t.$constructor=3Dt).extend=3Dfunction(t){var e,n,i,o=3Dthis;return D(i=
=3Do)&&/^class\s/.test(Function.prototype.toString.call(i))?(u(r,n=3Do),e=
=3Dr):rt(e=3Dfunction(){(t.$constructor||o).apply(this,arguments)},this),P(=
e.prototype,t),e[Ur]=3D!0,e.extend=3Dthis.extend,e.superCall=3DKr,e.superAp=
ply=3D$r,e.superClass=3Do,e;function r(){return n.apply(this,arguments)||th=
is}}}function qr(t,e){t.extend=3De.extend}var jr=3DMath.round(10*Math.rando=
m());function Kr(t,e){for(var n=3D[],i=3D2;i<arguments.length;i++)n[i-2]=3D=
arguments[i];return this.superClass.prototype[e].apply(t,n)}function $r(t,e=
,n){return this.superClass.prototype[e].apply(t,n)}function Qr(t){var o=3D{=
};t.registerClass=3Dfunction(t){var e,n=3Dt.type||t.prototype.type;return n=
&&(St(/^[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)?$/.test(e=3Dn),'componentType "'+e+=
'" illegal'),(e=3DYr(t.prototype.type=3Dn)).sub?e.sub!=3D=3DXr&&((n=3Do[e.m=
ain])&&n[Xr]||((n=3Do[e.main]=3D{})[Xr]=3D!0),n[e.sub]=3Dt):o[e.main]=3Dt),=
t},t.getClass=3Dfunction(t,e,n){var i=3Do[t];if(i&&i[Xr]&&(i=3De?i[e]:null)=
,n&&!i)throw new Error(e?"Component "+t+"."+(e||"")+" is used but not impor=
ted.":t+".type should be specified.");return i},t.getClassesByMainType=3Dfu=
nction(t){var t=3DYr(t),n=3D[],t=3Do[t.main];return t&&t[Xr]?E(t,function(t=
,e){e!=3D=3DXr&&n.push(t)}):n.push(t),n},t.hasClass=3Dfunction(t){t=3DYr(t)=
;return!!o[t.main]},t.getAllClassMainTypes=3Dfunction(){var n=3D[];return E=
(o,function(t,e){n.push(e)}),n},t.hasSubTypes=3Dfunction(t){t=3DYr(t),t=3Do=
[t.main];return t&&t[Xr]}}function Jr(a,s){for(var t=3D0;t<a.length;t++)a[t=
][1]||(a[t][1]=3Da[t][0]);return s=3Ds||!1,function(t,e,n){for(var i=3D{},o=
=3D0;o<a.length;o++){var r=3Da[o][1];e&&0<=3DC(e,r)||n&&C(n,r)<0||null!=3D(=
r=3Dt.getShallow(r,s))&&(i[a[o][0]]=3Dr)}return i}}var ta=3DJr([["fill","co=
lor"],["shadowBlur"],["shadowOffsetX"],["shadowOffsetY"],["opacity"],["shad=
owColor"]]),ea=3D(na.prototype.getAreaStyle=3Dfunction(t,e){return ta(this,=
t,e)},na);function na(){}var ia=3Dnew ti(50);function oa(t,e,n,i,o){return =
t?"string"=3D=3Dtypeof t?(e&&e.__zrImageSrc=3D=3D=3Dt||!n||(n=3D{hostEl:n,c=
b:i,cbPayload:o},(i=3Dia.get(t))?aa(e=3Di.image)||i.pending.push(n):((e=3DX=
.loadImage(t,ra,ra)).__zrImageSrc=3Dt,ia.put(t,e.__cachedImgObj=3D{image:e,=
pending:[n]}))),e):t:e}function ra(){var t=3Dthis.__cachedImgObj;this.onloa=
d=3Dthis.onerror=3Dthis.__cachedImgObj=3Dnull;for(var e=3D0;e<t.pending.len=
gth;e++){var n=3Dt.pending[e],i=3Dn.cb;i&&i(this,n.cbPayload),n.hostEl.dirt=
y()}t.pending.length=3D0}function aa(t){return t&&t.width&&t.height}var sa=
=3D/\{([a-zA-Z0-9_]+)\|([^}]*)\}/g;function la(t,e,n,i,o){if(!e)return"";va=
r r=3D(t+"").split("\n");o=3Dua(e,n,i,o);for(var a=3D0,s=3Dr.length;a<s;a++=
)r[a]=3Dha(r[a],o);return r.join("\n")}function ua(t,e,n,i){var o=3DP({},i=
=3Di||{}),r=3D(o.font=3De,n=3DR(n,"..."),o.maxIterations=3DR(i.maxIteration=
s,2),o.minChar=3DR(i.minChar,0)),a=3D(o.cnCharWidth=3Dbo("=E5=9B=BD",e),o.a=
scCharWidth=3Dbo("a",e));o.placeholder=3DR(i.placeholder,"");for(var s=3Dt=
=3DMath.max(0,t-1),l=3D0;l<r&&a<=3Ds;l++)s-=3Da;i=3Dbo(n,e);return s<i&&(n=
=3D"",i=3D0),s=3Dt-i,o.ellipsis=3Dn,o.ellipsisWidth=3Di,o.contentWidth=3Ds,=
o.containerWidth=3Dt,o}function ha(t,e){var n=3De.containerWidth,i=3De.font=
,o=3De.contentWidth;if(!n)return"";var r=3Dbo(t,i);if(!(r<=3Dn)){for(var a=
=3D0;;a++){if(r<=3Do||a>=3De.maxIterations){t+=3De.ellipsis;break}var s=3D0=
=3D=3D=3Da?function(t,e,n,i){for(var o=3D0,r=3D0,a=3Dt.length;r<a&&o<e;r++)=
{var s=3Dt.charCodeAt(r);o+=3D0<=3Ds&&s<=3D127?n:i}return r}(t,o,e.ascCharW=
idth,e.cnCharWidth):0<r?Math.floor(t.length*o/r):0,r=3Dbo(t=3Dt.substr(0,s)=
,i)}""=3D=3D=3Dt&&(t=3De.placeholder)}return t}function ca(){this.width=3D0=
,this.height=3D0,this.contentWidth=3D0,this.contentHeight=3D0,this.outerWid=
th=3D0,this.outerHeight=3D0,this.lines=3D[]}var pa=3Dfunction(){},da=3Dfunc=
tion(t){this.tokens=3D[],t&&(this.tokens=3Dt)};function fa(t,e){var n=3Dnew=
 ca;if(null!=3Dt&&(t+=3D""),t){for(var i,o=3De.width,r=3De.height,a=3De.ove=
rflow,s=3D"break"!=3D=3Da&&"breakAll"!=3D=3Da||null=3D=3Do?null:{width:o,ac=
cumWidth:0,breakAll:"breakAll"=3D=3D=3Da},l=3Dsa.lastIndex=3D0;null!=3D(i=
=3Dsa.exec(t));){var u=3Di.index;l<u&&ga(n,t.substring(l,u),e,s),ga(n,i[2],=
e,s,i[1]),l=3Dsa.lastIndex}l<t.length&&ga(n,t.substring(l,t.length),e,s);va=
r h,c=3D[],p=3D0,d=3D0,f=3De.padding,g=3D"truncate"=3D=3D=3Da,y=3D"truncate=
"=3D=3D=3De.lineOverflow;t:for(var m=3D0;m<n.lines.length;m++){for(var v=3D=
n.lines[m],_=3D0,x=3D0,w=3D0;w<v.tokens.length;w++){var b=3D(k=3Dv.tokens[w=
]).styleName&&e.rich[k.styleName]||{},S=3Dk.textPadding=3Db.padding,M=3DS?S=
[1]+S[3]:0,T=3Dk.font=3Db.font||e.font,I=3D(k.contentHeight=3DCo(T),R(b.hei=
ght,k.contentHeight));if(k.innerHeight=3DI,S&&(I+=3DS[0]+S[2]),k.height=3DI=
,k.lineHeight=3Dxt(b.lineHeight,e.lineHeight,I),k.align=3Db&&b.align||e.ali=
gn,k.verticalAlign=3Db&&b.verticalAlign||"middle",y&&null!=3Dr&&p+k.lineHei=
ght>r){0<w?(v.tokens=3Dv.tokens.slice(0,w),L(v,x,_),n.lines=3Dn.lines.slice=
(0,m+1)):n.lines=3Dn.lines.slice(0,m);break t}var C,S=3Db.width,D=3Dnull=3D=
=3DS||"auto"=3D=3D=3DS;"string"=3D=3Dtypeof S&&"%"=3D=3D=3DS.charAt(S.lengt=
h-1)?(k.percentWidth=3DS,c.push(k),k.contentWidth=3Dbo(k.text,T)):(D&&(S=3D=
(S=3Db.backgroundColor)&&S.image)&&(C=3Dvoid 0,aa(S=3D"string"=3D=3Dtypeof(=
h=3DS)?(C=3Dia.get(h))&&C.image:h))&&(k.width=3DMath.max(k.width,S.width*I/=
S.height)),null!=3D(C=3Dg&&null!=3Do?o-x:null)&&C<k.width?!D||C<M?(k.text=
=3D"",k.width=3Dk.contentWidth=3D0):(k.text=3Dla(k.text,C-M,T,e.ellipsis,{m=
inChar:e.truncateMinChar}),k.width=3Dk.contentWidth=3Dbo(k.text,T)):k.conte=
ntWidth=3Dbo(k.text,T)),k.width+=3DM,x+=3Dk.width,b&&(_=3DMath.max(_,k.line=
Height))}L(v,x,_)}for(n.outerWidth=3Dn.width=3DR(o,d),n.outerHeight=3Dn.hei=
ght=3DR(r,p),n.contentHeight=3Dp,n.contentWidth=3Dd,f&&(n.outerWidth+=3Df[1=
]+f[3],n.outerHeight+=3Df[0]+f[2]),m=3D0;m<c.length;m++){var k,A=3D(k=3Dc[m=
]).percentWidth;k.width=3DparseInt(A,10)/100*n.width}}return n;function L(t=
,e,n){t.width=3De,t.lineHeight=3Dn,p+=3Dn,d=3DMath.max(d,e)}}function ga(t,=
e,n,i,o){var r,a,s=3D""=3D=3D=3De,l=3Do&&n.rich[o]||{},u=3Dt.lines,h=3Dl.fo=
nt||n.font,c=3D!1;i?(n=3D(t=3Dl.padding)?t[1]+t[3]:0,null!=3Dl.width&&"auto=
"!=3D=3Dl.width?(t=3DDo(l.width,i.width)+n,0<u.length&&t+i.accumWidth>i.wid=
th&&(r=3De.split("\n"),c=3D!0),i.accumWidth=3Dt):(t=3Dma(e,h,i.width,i.brea=
kAll,i.accumWidth),i.accumWidth=3Dt.accumWidth+n,a=3Dt.linesWidths,r=3Dt.li=
nes)):r=3De.split("\n");for(var p=3D0;p<r.length;p++){var d,f,g=3Dr[p],y=3D=
new pa;y.styleName=3Do,y.text=3Dg,y.isLineHolder=3D!g&&!s,"number"=3D=3Dtyp=
eof l.width?y.width=3Dl.width:y.width=3Da?a[p]:bo(g,h),p||c?u.push(new da([=
y])):1=3D=3D=3D(f=3D(d=3D(u[u.length-1]||(u[0]=3Dnew da)).tokens).length)&&=
d[0].isLineHolder?d[0]=3Dy:!g&&f&&!s||d.push(y)}}var ya=3Dlt(",&?/;] ".spli=
t(""),function(t,e){return t[e]=3D!0,t},{});function ma(t,e,n,i,o){for(var =
r,a=3D[],s=3D[],l=3D"",u=3D"",h=3D0,c=3D0,p=3D0;p<t.length;p++){var d,f,g=
=3Dt.charAt(p);"\n"!=3D=3Dg?(d=3Dbo(g,e),f=3D!(i||(f=3Dvoid 0,!(32<=3D(f=3D=
(f=3Dr=3Dg).charCodeAt(0))&&f<=3D591||880<=3Df&&f<=3D4351||4608<=3Df&&f<=3D=
5119||7680<=3Df&&f<=3D8303))||ya[r]),(a.length?n<c+d:n<o+c+d)?c?(l||u)&&(c=
=3Df?(l||(l=3Du,u=3D"",c=3Dh=3D0),a.push(l),s.push(c-h),u+=3Dg,l=3D"",h+=3D=
d):(u&&(l+=3Du,u=3D"",h=3D0),a.push(l),s.push(c),l=3Dg,d)):f?(a.push(u),s.p=
ush(h),u=3Dg,h=3Dd):(a.push(g),s.push(d)):(c+=3Dd,f?(u+=3Dg,h+=3Dd):(u&&(l+=
=3Du,u=3D"",h=3D0),l+=3Dg))):(u&&(l+=3Du,c+=3Dh),a.push(l),s.push(c),u=3Dl=
=3D"",c=3Dh=3D0)}return a.length||l||(l=3Dt,u=3D"",h=3D0),u&&(l+=3Du),l&&(a=
.push(l),s.push(c)),1=3D=3D=3Da.length&&(c+=3Do),{accumWidth:c,lines:a,line=
sWidths:s}}var va,_a=3D"__zr_style_"+Math.round(10*Math.random()),xa=3D{sha=
dowBlur:0,shadowOffsetX:0,shadowOffsetY:0,shadowColor:"#000",opacity:1,blen=
d:"source-over"},wa=3D{style:{shadowBlur:!0,shadowOffsetX:!0,shadowOffsetY:=
!0,shadowColor:!0,opacity:!0}},ba=3D(xa[_a]=3D!0,["z","z2","invisible"]),Sa=
=3D["invisible"],e=3D(u(i,va=3De),i.prototype._init=3Dfunction(t){for(var e=
=3Dht(t),n=3D0;n<e.length;n++){var i=3De[n];"style"=3D=3D=3Di?this.useStyle=
(t[i]):va.prototype.attrKV.call(this,i,t[i])}this.style||this.useStyle({})}=
,i.prototype.beforeBrush=3Dfunction(){},i.prototype.afterBrush=3Dfunction()=
{},i.prototype.innerBeforeBrush=3Dfunction(){},i.prototype.innerAfterBrush=
=3Dfunction(){},i.prototype.shouldBePainted=3Dfunction(t,e,n,i){var o,r=3Dt=
his.transform;if(this.ignore||this.invisible||0=3D=3D=3Dthis.style.opacity|=
|this.culling&&(o=3Dthis,t=3Dt,e=3De,Ma.copy(o.getBoundingRect()),o.transfo=
rm&&Ma.applyTransform(o.transform),Ta.width=3Dt,Ta.height=3De,!Ma.intersect=
(Ta))||r&&!r[0]&&!r[3])return!1;if(n&&this.__clipPaths)for(var a=3D0;a<this=
.__clipPaths.length;++a)if(this.__clipPaths[a].isZeroArea())return!1;if(i&&=
this.parent)for(var s=3Dthis.parent;s;){if(s.ignore)return!1;s=3Ds.parent}r=
eturn!0},i.prototype.contain=3Dfunction(t,e){return this.rectContain(t,e)},=
i.prototype.traverse=3Dfunction(t,e){t.call(e,this)},i.prototype.rectContai=
n=3Dfunction(t,e){t=3Dthis.transformCoordToLocal(t,e);return this.getBoundi=
ngRect().contain(t[0],t[1])},i.prototype.getPaintRect=3Dfunction(){var t,e,=
n,i,o,r=3Dthis._paintRect;return this._paintRect&&!this.__dirty||(o=3Dthis.=
transform,t=3Dthis.getBoundingRect(),e=3D(i=3Dthis.style).shadowBlur||0,n=
=3Di.shadowOffsetX||0,i=3Di.shadowOffsetY||0,r=3Dthis._paintRect||(this._pa=
intRect=3Dnew G(0,0,0,0)),o?G.applyTransform(r,t,o):r.copy(t),(e||n||i)&&(r=
.width+=3D2*e+Math.abs(n),r.height+=3D2*e+Math.abs(i),r.x=3DMath.min(r.x,r.=
x+n-e),r.y=3DMath.min(r.y,r.y+i-e)),o=3Dthis.dirtyRectTolerance,r.isZero())=
||(r.x=3DMath.floor(r.x-o),r.y=3DMath.floor(r.y-o),r.width=3DMath.ceil(r.wi=
dth+1+2*o),r.height=3DMath.ceil(r.height+1+2*o)),r},i.prototype.setPrevPain=
tRect=3Dfunction(t){t?(this._prevPaintRect=3Dthis._prevPaintRect||new G(0,0=
,0,0),this._prevPaintRect.copy(t)):this._prevPaintRect=3Dnull},i.prototype.=
getPrevPaintRect=3Dfunction(){return this._prevPaintRect},i.prototype.anima=
teStyle=3Dfunction(t){return this.animate("style",t)},i.prototype.updateDur=
ingAnimation=3Dfunction(t){"style"=3D=3D=3Dt?this.dirtyStyle():this.markRed=
raw()},i.prototype.attrKV=3Dfunction(t,e){"style"!=3D=3Dt?va.prototype.attr=
KV.call(this,t,e):this.style?this.setStyle(e):this.useStyle(e)},i.prototype=
.setStyle=3Dfunction(t,e){return"string"=3D=3Dtypeof t?this.style[t]=3De:P(=
this.style,t),this.dirtyStyle(),this},i.prototype.dirtyStyle=3Dfunction(t){=
t||this.markRedraw(),this.__dirty|=3D2,this._rect&&(this._rect=3Dnull)},i.p=
rototype.dirty=3Dfunction(){this.dirtyStyle()},i.prototype.styleChanged=3Df=
unction(){return!!(2&this.__dirty)},i.prototype.styleUpdated=3Dfunction(){t=
his.__dirty&=3D-3},i.prototype.createStyle=3Dfunction(t){return Rt(xa,t)},i=
.prototype.useStyle=3Dfunction(t){t[_a]||(t=3Dthis.createStyle(t)),this.__i=
nHover?this.__hoverStyle=3Dt:this.style=3Dt,this.dirtyStyle()},i.prototype.=
isStyleObject=3Dfunction(t){return t[_a]},i.prototype._innerSaveToNormal=3D=
function(t){va.prototype._innerSaveToNormal.call(this,t);var e=3Dthis._norm=
alState;t.style&&!e.style&&(e.style=3Dthis._mergeStyle(this.createStyle(),t=
his.style)),this._savePrimaryToNormal(t,e,ba)},i.prototype._applyStateObj=
=3Dfunction(t,e,n,i,o,r){va.prototype._applyStateObj.call(this,t,e,n,i,o,r)=
;var a,s=3D!(e&&i);if(e&&e.style?o?i?a=3De.style:(a=3Dthis._mergeStyle(this=
.createStyle(),n.style),this._mergeStyle(a,e.style)):(a=3Dthis._mergeStyle(=
this.createStyle(),(i?this:n).style),this._mergeStyle(a,e.style)):s&&(a=3Dn=
.style),a)if(o){var l=3Dthis.style;if(this.style=3Dthis.createStyle(s?{}:l)=
,s)for(var u=3Dht(l),h=3D0;h<u.length;h++)(p=3Du[h])in a&&(a[p]=3Da[p],this=
.style[p]=3Dl[p]);for(var c=3Dht(a),h=3D0;h<c.length;h++){var p=3Dc[h];this=
.style[p]=3Dthis.style[p]}this._transitionState(t,{style:a},r,this.getAnima=
tionStyleProps())}else this.useStyle(a);var d=3Dthis.__inHover?Sa:ba;for(h=
=3D0;h<d.length;h++)p=3Dd[h],e&&null!=3De[p]?this[p]=3De[p]:s&&null!=3Dn[p]=
&&(this[p]=3Dn[p])},i.prototype._mergeStates=3Dfunction(t){for(var e,n=3Dva=
.prototype._mergeStates.call(this,t),i=3D0;i<t.length;i++){var o=3Dt[i];o.s=
tyle&&this._mergeStyle(e=3De||{},o.style)}return e&&(n.style=3De),n},i.prot=
otype._mergeStyle=3Dfunction(t,e){return P(t,e),t},i.prototype.getAnimation=
StyleProps=3Dfunction(){return wa},i.initDefaultProps=3D((e=3Di.prototype).=
type=3D"displayable",e.invisible=3D!1,e.z=3D0,e.z2=3D0,e.zlevel=3D0,e.culli=
ng=3D!1,e.cursor=3D"pointer",e.rectHover=3D!1,e.incremental=3D!1,e._rect=3D=
null,e.dirtyRectTolerance=3D0,void(e.__dirty=3D2|mn)),i),Ma=3Dnew G(0,0,0,0=
),Ta=3Dnew G(0,0,0,0);function i(t){return va.call(this,t)||this}var Ia=3DM=
ath.min,Ca=3DMath.max,Da=3DMath.sin,ka=3DMath.cos,Aa=3D2*Math.PI,La=3DVt(),=
Pa=3DVt(),Oa=3DVt();function Ra(t,e,n,i,o,r){o[0]=3DIa(t,n),o[1]=3DIa(e,i),=
r[0]=3DCa(t,n),r[1]=3DCa(e,i)}var Na=3D[],Ea=3D[];var za=3D{M:1,L:2,C:3,Q:4=
,A:5,Z:6,R:7},Ba=3D[],Fa=3D[],Va=3D[],Ha=3D[],Wa=3D[],Ga=3D[],Xa=3DMath.min=
,Ua=3DMath.max,Ya=3DMath.cos,Za=3DMath.sin,qa=3DMath.abs,ja=3DMath.PI,Ka=3D=
2*ja,$a=3D"undefined"!=3Dtypeof Float32Array,Qa=3D[];function Ja(t){return =
Math.round(t/ja*1e8)/1e8%2*ja}function ts(t,e){var n=3DJa(t[0]),i=3D(n<0&&(=
n+=3DKa),n-t[0]),o=3Dt[1];o+=3Di,!e&&Ka<=3Do-n?o=3Dn+Ka:e&&Ka<=3Dn-o?o=3Dn-=
Ka:!e&&o<n?o=3Dn+(Ka-Ja(n-o)):e&&n<o&&(o=3Dn-(Ka-Ja(o-n))),t[0]=3Dn,t[1]=3D=
o}o.prototype.increaseVersion=3Dfunction(){this._version++},o.prototype.get=
Version=3Dfunction(){return this._version},o.prototype.setScale=3Dfunction(=
t,e,n){0<(n=3Dn||0)&&(this._ux=3Dqa(n/lo/t)||0,this._uy=3Dqa(n/lo/e)||0)},o=
.prototype.setDPR=3Dfunction(t){this.dpr=3Dt},o.prototype.setContext=3Dfunc=
tion(t){this._ctx=3Dt},o.prototype.getContext=3Dfunction(){return this._ctx=
},o.prototype.beginPath=3Dfunction(){return this._ctx&&this._ctx.beginPath(=
),this.reset(),this},o.prototype.reset=3Dfunction(){this._saveData&&(this._=
len=3D0),this._pathSegLen&&(this._pathSegLen=3Dnull,this._pathLen=3D0),this=
._version++},o.prototype.moveTo=3Dfunction(t,e){return this._drawPendingPt(=
),this.addData(za.M,t,e),this._ctx&&this._ctx.moveTo(t,e),this._x0=3Dt,this=
._y0=3De,this._xi=3Dt,this._yi=3De,this},o.prototype.lineTo=3Dfunction(t,e)=
{var n=3Dqa(t-this._xi),i=3Dqa(e-this._yi),o=3Dn>this._ux||i>this._uy;retur=
n this.addData(za.L,t,e),this._ctx&&o&&this._ctx.lineTo(t,e),o?(this._xi=3D=
t,this._yi=3De,this._pendingPtDist=3D0):(o=3Dn*n+i*i)>this._pendingPtDist&&=
(this._pendingPtX=3Dt,this._pendingPtY=3De,this._pendingPtDist=3Do),this},o=
.prototype.bezierCurveTo=3Dfunction(t,e,n,i,o,r){return this._drawPendingPt=
(),this.addData(za.C,t,e,n,i,o,r),this._ctx&&this._ctx.bezierCurveTo(t,e,n,=
i,o,r),this._xi=3Do,this._yi=3Dr,this},o.prototype.quadraticCurveTo=3Dfunct=
ion(t,e,n,i){return this._drawPendingPt(),this.addData(za.Q,t,e,n,i),this._=
ctx&&this._ctx.quadraticCurveTo(t,e,n,i),this._xi=3Dn,this._yi=3Di,this},o.=
prototype.arc=3Dfunction(t,e,n,i,o,r){this._drawPendingPt(),Qa[0]=3Di,Qa[1]=
=3Do,ts(Qa,r);var a=3D(o=3DQa[1])-(i=3DQa[0]);return this.addData(za.A,t,e,=
n,n,i,a,0,r?0:1),this._ctx&&this._ctx.arc(t,e,n,i,o,r),this._xi=3DYa(o)*n+t=
,this._yi=3DZa(o)*n+e,this},o.prototype.arcTo=3Dfunction(t,e,n,i,o){return =
this._drawPendingPt(),this._ctx&&this._ctx.arcTo(t,e,n,i,o),this},o.prototy=
pe.rect=3Dfunction(t,e,n,i){return this._drawPendingPt(),this._ctx&&this._c=
tx.rect(t,e,n,i),this.addData(za.R,t,e,n,i),this},o.prototype.closePath=3Df=
unction(){this._drawPendingPt(),this.addData(za.Z);var t=3Dthis._ctx,e=3Dth=
is._x0,n=3Dthis._y0;return t&&t.closePath(),this._xi=3De,this._yi=3Dn,this}=
,o.prototype.fill=3Dfunction(t){t&&t.fill(),this.toStatic()},o.prototype.st=
roke=3Dfunction(t){t&&t.stroke(),this.toStatic()},o.prototype.len=3Dfunctio=
n(){return this._len},o.prototype.setData=3Dfunction(t){var e=3Dt.length;th=
is.data&&this.data.length=3D=3D=3De||!$a||(this.data=3Dnew Float32Array(e))=
;for(var n=3D0;n<e;n++)this.data[n]=3Dt[n];this._len=3De},o.prototype.appen=
dPath=3Dfunction(t){for(var e=3D(t=3Dt instanceof Array?t:[t]).length,n=3D0=
,i=3Dthis._len,o=3D0;o<e;o++)n+=3Dt[o].len();for($a&&this.data instanceof F=
loat32Array&&(this.data=3Dnew Float32Array(i+n)),o=3D0;o<e;o++)for(var r=3D=
t[o].data,a=3D0;a<r.length;a++)this.data[i++]=3Dr[a];this._len=3Di},o.proto=
type.addData=3Dfunction(t,e,n,i,o,r,a,s,l){if(this._saveData){var u=3Dthis.=
data;this._len+arguments.length>u.length&&(this._expandData(),u=3Dthis.data=
);for(var h=3D0;h<arguments.length;h++)u[this._len++]=3Darguments[h]}},o.pr=
ototype._drawPendingPt=3Dfunction(){0<this._pendingPtDist&&(this._ctx&&this=
._ctx.lineTo(this._pendingPtX,this._pendingPtY),this._pendingPtDist=3D0)},o=
.prototype._expandData=3Dfunction(){if(!(this.data instanceof Array)){for(v=
ar t=3D[],e=3D0;e<this._len;e++)t[e]=3Dthis.data[e];this.data=3Dt}},o.proto=
type.toStatic=3Dfunction(){var t;this._saveData&&(this._drawPendingPt(),(t=
=3Dthis.data)instanceof Array)&&(t.length=3Dthis._len,$a)&&11<this._len&&(t=
his.data=3Dnew Float32Array(t))},o.prototype.getBoundingRect=3Dfunction(){V=
a[0]=3DVa[1]=3DWa[0]=3DWa[1]=3DNumber.MAX_VALUE,Ha[0]=3DHa[1]=3DGa[0]=3DGa[=
1]=3D-Number.MAX_VALUE;for(var t,e,n,i=3Dthis.data,o=3D0,r=3D0,a=3D0,s=3D0,=
l=3D0;l<this._len;){var u=3Di[l++],h=3D1=3D=3D=3Dl;switch(h&&(a=3Do=3Di[l],=
s=3Dr=3Di[l+1]),u){case za.M:o=3Da=3Di[l++],r=3Ds=3Di[l++],Wa[0]=3Da,Wa[1]=
=3Ds,Ga[0]=3Da,Ga[1]=3Ds;break;case za.L:Ra(o,r,i[l],i[l+1],Wa,Ga),o=3Di[l+=
+],r=3Di[l++];break;case za.C:I=3DT=3DM=3DS=3Db=3Dw=3Dx=3D_=3Dv=3Dm=3Dy=3Dg=
=3Df=3Dd=3Dp=3Dc=3Dvoid 0;var c=3Do,p=3Dr,d=3Di[l++],f=3Di[l++],g=3Di[l++],=
y=3Di[l++],m=3Di[l],v=3Di[l+1],_=3DWa,x=3DGa,w=3DFn,b=3DEn,S=3Dw(c,d,g,m,Na=
);_[0]=3D1/0,_[1]=3D1/0,x[0]=3D-1/0,x[1]=3D-1/0;for(var M=3D0;M<S;M++){var =
T=3Db(c,d,g,m,Na[M]);_[0]=3DIa(T,_[0]),x[0]=3DCa(T,x[0])}for(S=3Dw(p,f,y,v,=
Ea),M=3D0;M<S;M++){var I=3Db(p,f,y,v,Ea[M]);_[1]=3DIa(I,_[1]),x[1]=3DCa(I,x=
[1])}_[0]=3DIa(c,_[0]),x[0]=3DCa(c,x[0]),_[0]=3DIa(m,_[0]),x[0]=3DCa(m,x[0]=
),_[1]=3DIa(p,_[1]),x[1]=3DCa(p,x[1]),_[1]=3DIa(v,_[1]),x[1]=3DCa(v,x[1]),o=
=3Di[l++],r=3Di[l++];break;case za.Q:w=3Do,t=3Dr,P=3Di[l++],D=3Di[l++],L=3D=
i[l],e=3Di[l+1],A=3DWa,O=3DGa,n=3Dk=3Dn=3DC=3Dvoid 0,C=3DWn,n=3DCa(Ia((k=3D=
Xn)(w,P,L),1),0),k=3DCa(Ia(k(t,D,e),1),0),P=3DC(w,P,L,n),n=3DC(t,D,e,k),A[0=
]=3DIa(w,L,P),A[1]=3DIa(t,e,n),O[0]=3DCa(w,L,P),O[1]=3DCa(t,e,n),o=3Di[l++]=
,r=3Di[l++];break;case za.A:var C=3Di[l++],D=3Di[l++],k=3Di[l++],A=3Di[l++]=
,L=3Di[l++],P=3Di[l++]+L,O=3D(l+=3D1,!i[l++]);h&&(a=3DYa(L)*k+C,s=3DZa(L)*A=
+D),function(t,e,n,i,o,r,a,s,l){var u=3Dte,h=3Dee,c=3DMath.abs(o-r);if(c%Aa=
<1e-4&&1e-4<c)return s[0]=3Dt-n,s[1]=3De-i,l[0]=3Dt+n,l[1]=3De+i;La[0]=3Dka=
(o)*n+t,La[1]=3DDa(o)*i+e,Pa[0]=3Dka(r)*n+t,Pa[1]=3DDa(r)*i+e,u(s,La,Pa),h(=
l,La,Pa),(o%=3DAa)<0&&(o+=3DAa),(r%=3DAa)<0&&(r+=3DAa),r<o&&!a?r+=3DAa:o<r&=
&a&&(o+=3DAa),a&&(c=3Dr,r=3Do,o=3Dc);for(var p=3D0;p<r;p+=3DMath.PI/2)o<p&&=
(Oa[0]=3Dka(p)*n+t,Oa[1]=3DDa(p)*i+e,u(s,Oa,s),h(l,Oa,l))}(C,D,k,A,L,P,O,Wa=
,Ga),o=3DYa(P)*k+C,r=3DZa(P)*A+D;break;case za.R:Ra(a=3Do=3Di[l++],s=3Dr=3D=
i[l++],a+i[l++],s+i[l++],Wa,Ga);break;case za.Z:o=3Da,r=3Ds}te(Va,Va,Wa),ee=
(Ha,Ha,Ga)}return 0=3D=3D=3Dl&&(Va[0]=3DVa[1]=3DHa[0]=3DHa[1]=3D0),new G(Va=
[0],Va[1],Ha[0]-Va[0],Ha[1]-Va[1])},o.prototype._calculateLength=3Dfunction=
(){var t=3Dthis.data,e=3Dthis._len,n=3Dthis._ux,i=3Dthis._uy,o=3D0,r=3D0,a=
=3D0,s=3D0;this._pathSegLen||(this._pathSegLen=3D[]);for(var l=3Dthis._path=
SegLen,u=3D0,h=3D0,c=3D0;c<e;){var p=3Dt[c++],d=3D1=3D=3D=3Dc,f=3D(d&&(a=3D=
o=3Dt[c],s=3Dr=3Dt[c+1]),-1);switch(p){case za.M:o=3Da=3Dt[c++],r=3Ds=3Dt[c=
++];break;case za.L:var g=3Dt[c++],y=3D(_=3Dt[c++])-r;(qa(C=3Dg-o)>n||qa(y)=
>i||c=3D=3D=3De-1)&&(f=3DMath.sqrt(C*C+y*y),o=3Dg,r=3D_);break;case za.C:va=
r m=3Dt[c++],v=3Dt[c++],_=3D(g=3Dt[c++],t[c++]),x=3Dt[c++],w=3Dt[c++],f=3Df=
unction(t,e,n,i,o,r,a,s,l){for(var u=3Dt,h=3De,c=3D0,p=3D1/l,d=3D1;d<=3Dl;d=
++){var f=3Dd*p,g=3DEn(t,n,o,a,f),f=3DEn(e,i,r,s,f),y=3Dg-u,m=3Df-h;c+=3DMa=
th.sqrt(y*y+m*m),u=3Dg,h=3Df}return c}(o,r,m,v,g,_,x,w,10),o=3Dx,r=3Dw;brea=
k;case za.Q:f=3Dfunction(t,e,n,i,o,r,a){for(var s=3Dt,l=3De,u=3D0,h=3D1/a,c=
=3D1;c<=3Da;c++){var p=3Dc*h,d=3DWn(t,n,o,p),p=3DWn(e,i,r,p),f=3Dd-s,g=3Dp-=
l;u+=3DMath.sqrt(f*f+g*g),s=3Dd,l=3Dp}return u}(o,r,m=3Dt[c++],v=3Dt[c++],g=
=3Dt[c++],_=3Dt[c++],10),o=3Dg,r=3D_;break;case za.A:var x=3Dt[c++],w=3Dt[c=
++],b=3Dt[c++],S=3Dt[c++],M=3Dt[c++],T=3Dt[c++],I=3DT+M;c+=3D1,d&&(a=3DYa(M=
)*b+x,s=3DZa(M)*S+w),f=3DUa(b,S)*Xa(Ka,Math.abs(T)),o=3DYa(I)*b+x,r=3DZa(I)=
*S+w;break;case za.R:a=3Do=3Dt[c++],s=3Dr=3Dt[c++],f=3D2*t[c++]+2*t[c++];br=
eak;case za.Z:var C=3Da-o,y=3Ds-r;f=3DMath.sqrt(C*C+y*y),o=3Da,r=3Ds}0<=3Df=
&&(u+=3Dl[h++]=3Df)}return this._pathLen=3Du},o.prototype.rebuildPath=3Dfun=
ction(t,e){var n,i,o,r,a,s,l,u,h=3Dthis.data,E=3Dthis._ux,z=3Dthis._uy,B=3D=
this._len,c=3De<1,p=3D0,d=3D0,f=3D0;if(!c||(this._pathSegLen||this._calcula=
teLength(),a=3Dthis._pathSegLen,s=3De*this._pathLen))t:for(var g=3D0;g<B;){=
var y,m=3Dh[g++],F=3D1=3D=3D=3Dg;switch(F&&(n=3Do=3Dh[g],i=3Dr=3Dh[g+1]),m!=
=3D=3Dza.L&&0<f&&(t.lineTo(l,u),f=3D0),m){case za.M:n=3Do=3Dh[g++],i=3Dr=3D=
h[g++],t.moveTo(o,r);break;case za.L:var v=3Dh[g++],_=3Dh[g++],x=3Dqa(v-o),=
w=3Dqa(_-r);if(E<x||z<w){if(c){if(p+(y=3Da[d++])>s){var b=3D(s-p)/y;t.lineT=
o(o*(1-b)+v*b,r*(1-b)+_*b);break t}p+=3Dy}t.lineTo(v,_),o=3Dv,r=3D_,f=3D0}e=
lse{x=3Dx*x+w*w;f<x&&(l=3Dv,u=3D_,f=3Dx)}break;case za.C:var S=3Dh[g++],M=
=3Dh[g++],T=3Dh[g++],I=3Dh[g++],w=3Dh[g++],x=3Dh[g++];if(c){if(p+(y=3Da[d++=
])>s){Vn(o,S,T,w,b=3D(s-p)/y,Ba),Vn(r,M,I,x,b,Fa),t.bezierCurveTo(Ba[1],Fa[=
1],Ba[2],Fa[2],Ba[3],Fa[3]);break t}p+=3Dy}t.bezierCurveTo(S,M,T,I,w,x),o=
=3Dw,r=3Dx;break;case za.Q:if(S=3Dh[g++],M=3Dh[g++],T=3Dh[g++],I=3Dh[g++],c=
){if(p+(y=3Da[d++])>s){Un(o,S,T,b=3D(s-p)/y,Ba),Un(r,M,I,b,Fa),t.quadraticC=
urveTo(Ba[1],Fa[1],Ba[2],Fa[2]);break t}p+=3Dy}t.quadraticCurveTo(S,M,T,I),=
o=3DT,r=3DI;break;case za.A:var C=3Dh[g++],D=3Dh[g++],k=3Dh[g++],A=3Dh[g++]=
,L=3Dh[g++],P=3Dh[g++],O=3Dh[g++],V=3D!h[g++],H=3DA<k?k:A,R=3D.001<qa(k-A),=
N=3DL+P,W=3D!1;if(c&&(p+(y=3Da[d++])>s&&(N=3DL+P*(s-p)/y,W=3D!0),p+=3Dy),R&=
&t.ellipse?t.ellipse(C,D,k,A,O,L,N,V):t.arc(C,D,H,L,N,V),W)break t;F&&(n=3D=
Ya(L)*k+C,i=3DZa(L)*A+D),o=3DYa(N)*k+C,r=3DZa(N)*A+D;break;case za.R:n=3Do=
=3Dh[g],i=3Dr=3Dh[g+1],v=3Dh[g++],_=3Dh[g++];P=3Dh[g++],R=3Dh[g++];if(c){if=
(p+(y=3Da[d++])>s){O=3Ds-p;t.moveTo(v,_),t.lineTo(v+Xa(O,P),_),0<(O-=3DP)&&=
t.lineTo(v+P,_+Xa(O,R)),0<(O-=3DR)&&t.lineTo(v+Ua(P-O,0),_+R),0<(O-=3DP)&&t=
.lineTo(v,_+Ua(R-O,0));break t}p+=3Dy}t.rect(v,_,P,R);break;case za.Z:if(c)=
{if(p+(y=3Da[d++])>s){t.lineTo(o*(1-(b=3D(s-p)/y))+n*b,r*(1-b)+i*b);break t=
}p+=3Dy}t.closePath(),o=3Dn,r=3Di}}},o.prototype.clone=3Dfunction(){var t=
=3Dnew o,e=3Dthis.data;return t.data=3De.slice?e.slice():Array.prototype.sl=
ice.call(e),t._len=3Dthis._len,t},o.CMD=3Dza,o.initDefaultProps=3D((mu=3Do.=
prototype)._saveData=3D!0,mu._ux=3D0,mu._uy=3D0,mu._pendingPtDist=3D0,void(=
mu._version=3D0));var es=3Do;function o(t){this.dpr=3D1,this._xi=3D0,this._=
yi=3D0,this._x0=3D0,this._y0=3D0,this._len=3D0,t&&(this._saveData=3D!1),thi=
s._saveData&&(this.data=3D[])}function ns(t,e,n,i,o,r,a){var s;if(0!=3D=3Do=
)return s=3D0,!(e+(o=3Do)<a&&i+o<a||a<e-o&&a<i-o||t+o<r&&n+o<r||r<t-o&&r<n-=
o)&&(t=3D=3D=3Dn?Math.abs(r-t)<=3Do/2:(r=3D(s=3D(e-i)/(t-n))*r-a+(t*i-n*e)/=
(t-n))*r/(s*s+1)<=3Do/2*o/2)}var is=3D2*Math.PI;function os(t){return(t%=3D=
is)<0&&(t+=3Dis),t}var rs=3D2*Math.PI;function as(t,e,n,i,o,r){return e<r&&=
i<r||r<e&&r<i||i=3D=3D=3De?0:(n=3D(r=3D(r-e)/(i-e))*(n-t)+t)=3D=3D=3Do?1/0:=
o<n?1!=3Dr&&0!=3Dr?i<e?1:-1:i<e?.5:-.5:0}var ss=3Des.CMD,ls=3D2*Math.PI,us=
=3D1e-4;var hs=3D[-1,-1,-1],cs=3D[-1,-1];function ps(t,e,n,i,o,r,a,s,l,u){i=
f(e<u&&i<u&&r<u&&s<u||u<e&&u<i&&u<r&&u<s)return 0;var h=3DBn(e,i,r,s,u,hs);=
if(0=3D=3D=3Dh)return 0;for(var c,p=3D0,d=3D-1,f=3Dvoid 0,g=3Dvoid 0,y=3D0;=
y<h;y++){var m=3Dhs[y],v=3D0=3D=3D=3Dm||1=3D=3D=3Dm?.5:1;En(t,n,o,a,m)<l||(=
d<0&&(d=3DFn(e,i,r,s,cs),cs[1]<cs[0]&&1<d&&(c=3Dvoid 0,c=3Dcs[0],cs[0]=3Dcs=
[1],cs[1]=3Dc),f=3DEn(e,i,r,s,cs[0]),1<d)&&(g=3DEn(e,i,r,s,cs[1])),2=3D=3D=
=3Dd?m<cs[0]?p+=3Df<e?v:-v:m<cs[1]?p+=3Dg<f?v:-v:p+=3Ds<g?v:-v:m<cs[0]?p+=
=3Df<e?v:-v:p+=3Ds<f?v:-v)}return p}function ds(t,e,n,i,o,r,a,s){if(e<s&&i<=
s&&r<s||s<e&&s<i&&s<r)return 0;c=3Dhs,h=3D(l=3De)-2*(u=3Di)+(h=3Dr),u=3D2*(=
u-l),l-=3Ds=3Ds,s=3D0,Rn(h)?Nn(u)&&0<=3D(p=3D-l/u)&&p<=3D1&&(c[s++]=3Dp):Rn=
(l=3Du*u-4*h*l)?0<=3D(p=3D-u/(2*h))&&p<=3D1&&(c[s++]=3Dp):0<l&&(d=3D(-u-(l=
=3DCn(l)))/(2*h),0<=3D(p=3D(-u+l)/(2*h))&&p<=3D1&&(c[s++]=3Dp),0<=3Dd)&&d<=
=3D1&&(c[s++]=3Dd);var l,u,h,c,p,d,f=3Ds;if(0=3D=3D=3Df)return 0;var g=3DXn=
(e,i,r);if(0<=3Dg&&g<=3D1){for(var y=3D0,m=3DWn(e,i,r,g),v=3D0;v<f;v++){var=
 _=3D0=3D=3D=3Dhs[v]||1=3D=3D=3Dhs[v]?.5:1;Wn(t,n,o,hs[v])<a||(hs[v]<g?y+=
=3Dm<e?_:-_:y+=3Dr<m?_:-_)}return y}return _=3D0=3D=3D=3Dhs[0]||1=3D=3D=3Dh=
s[0]?.5:1,Wn(t,n,o,hs[0])<a?0:r<e?_:-_}function fs(t,e,n,i,o){for(var r,a=
=3Dt.data,s=3Dt.len(),l=3D0,u=3D0,h=3D0,c=3D0,p=3D0,d=3D0;d<s;){var f=3Da[d=
++],g=3D1=3D=3D=3Dd;switch(f=3D=3D=3Dss.M&&1<d&&(n||(l+=3Das(u,h,c,p,i,o)))=
,g&&(c=3Du=3Da[d],p=3Dh=3Da[d+1]),f){case ss.M:u=3Dc=3Da[d++],h=3Dp=3Da[d++=
];break;case ss.L:if(n){if(ns(u,h,a[d],a[d+1],e,i,o))return!0}else l+=3Das(=
u,h,a[d],a[d+1],i,o)||0;u=3Da[d++],h=3Da[d++];break;case ss.C:if(n){if(func=
tion(t,e,n,i,o,r,a,s,l,u,h){if(0!=3D=3Dl)return!(e+(l=3Dl)<h&&i+l<h&&r+l<h&=
&s+l<h||h<e-l&&h<i-l&&h<r-l&&h<s-l||t+l<u&&n+l<u&&o+l<u&&a+l<u||u<t-l&&u<n-=
l&&u<o-l&&u<a-l)&&Hn(t,e,n,i,o,r,a,s,u,h,null)<=3Dl/2}(u,h,a[d++],a[d++],a[=
d++],a[d++],a[d],a[d+1],e,i,o))return!0}else l+=3Dps(u,h,a[d++],a[d++],a[d+=
+],a[d++],a[d],a[d+1],i,o)||0;u=3Da[d++],h=3Da[d++];break;case ss.Q:if(n){i=
f(function(t,e,n,i,o,r,a,s,l){if(0!=3D=3Da)return!(e+(a=3Da)<l&&i+a<l&&r+a<=
l||l<e-a&&l<i-a&&l<r-a||t+a<s&&n+a<s&&o+a<s||s<t-a&&s<n-a&&s<o-a)&&Yn(t,e,n=
,i,o,r,s,l,null)<=3Da/2}(u,h,a[d++],a[d++],a[d],a[d+1],e,i,o))return!0}else=
 l+=3Dds(u,h,a[d++],a[d++],a[d],a[d+1],i,o)||0;u=3Da[d++],h=3Da[d++];break;=
case ss.A:var y=3Da[d++],m=3Da[d++],v=3Da[d++],_=3Da[d++],x=3Da[d++],w=3Da[=
d++],b=3D(d+=3D1,!!(1-a[d++])),S=3DMath.cos(x)*v+y,M=3DMath.sin(x)*_+m,T=3D=
(g?(c=3DS,p=3DM):l+=3Das(u,h,S,M,i,o),(i-y)*_/v+y);if(n){if(function(t,e,n,=
i,o,r,a,s,l){if(0!=3D=3Da)return a=3Da,s-=3Dt,l-=3De,!(n<(t=3DMath.sqrt(s*s=
+l*l))-a||t+a<n)&&(Math.abs(i-o)%rs<1e-4||((o=3Dr?(e=3Di,i=3Dos(o),os(e)):(=
i=3Dos(i),os(o)))<i&&(o+=3Drs),(t=3DMath.atan2(l,s))<0&&(t+=3Drs),i<=3Dt&&t=
<=3Do)||i<=3Dt+rs&&t+rs<=3Do)}(y,m,_,x,x+w,b,e,T,o))return!0}else l+=3Dfunc=
tion(t,e,n,i,o,r,a,s){if((s-=3De)>n||s<-n)return 0;var e=3DMath.sqrt(n*n-s*=
s);if(hs[0]=3D-e,hs[1]=3De,(n=3DMath.abs(i-o))<1e-4)return 0;if(ls-1e-4<=3D=
n)return o=3Dls,h=3Dr?1:-1,a>=3Dhs[i=3D0]+t&&a<=3Dhs[1]+t?h:0;o<i&&(e=3Di,i=
=3Do,o=3De),i<0&&(i+=3Dls,o+=3Dls);for(var l=3D0,u=3D0;u<2;u++){var h,c=3Dh=
s[u];a<c+t&&(h=3Dr?1:-1,i<=3D(c=3D(c=3DMath.atan2(s,c))<0?ls+c:c)&&c<=3Do||=
i<=3Dc+ls&&c+ls<=3Do)&&(l+=3Dh=3Dc>Math.PI/2&&c<1.5*Math.PI?-h:h)}return l}=
(y,m,_,x,x+w,b,T,o);u=3DMath.cos(x+w)*v+y,h=3DMath.sin(x+w)*_+m;break;case =
ss.R:if(c=3Du=3Da[d++],p=3Dh=3Da[d++],S=3Dc+a[d++],M=3Dp+a[d++],n){if(ns(c,=
p,S,p,e,i,o)||ns(S,p,S,M,e,i,o)||ns(S,M,c,M,e,i,o)||ns(c,M,c,p,e,i,o))retur=
n!0}else l=3D(l+=3Das(S,p,S,M,i,o))+as(c,M,c,p,i,o);break;case ss.Z:if(n){i=
f(ns(u,h,c,p,e,i,o))return!0}else l+=3Das(u,h,c,p,i,o);u=3Dc,h=3Dp}}return =
n||(t=3Dh,r=3Dp,Math.abs(t-r)<us)||(l+=3Das(u,h,c,p,i,o)||0),0!=3D=3Dl}var =
gs,ys=3DB({fill:"#000",stroke:null,strokePercent:1,fillOpacity:1,strokeOpac=
ity:1,lineDashOffset:0,lineWidth:1,lineCap:"butt",miterLimit:10,strokeNoSca=
le:!1,strokeFirst:!1},xa),ms=3D{style:B({fill:!0,stroke:!0,strokePercent:!0=
,fillOpacity:!0,strokeOpacity:!0,lineDashOffset:!0,lineWidth:!0,miterLimit:=
!0},wa.style)},vs=3Dxo.concat(["invisible","culling","z","z2","zlevel","par=
ent"]),_s=3D(u(a,gs=3De),a.prototype.update=3Dfunction(){var e=3Dthis,t=3D(=
gs.prototype.update.call(this),this.style);if(t.decal){var n,i=3Dthis._deca=
lEl=3Dthis._decalEl||new a,o=3D(i.buildPath=3D=3D=3Da.prototype.buildPath&&=
(i.buildPath=3Dfunction(t){e.buildPath(t,e.shape)}),i.silent=3D!0,i.style);=
for(n in t)o[n]!=3D=3Dt[n]&&(o[n]=3Dt[n]);o.fill=3Dt.fill?t.decal:null,o.de=
cal=3Dnull,o.shadowColor=3Dnull,t.strokeFirst&&(o.stroke=3Dnull);for(var r=
=3D0;r<vs.length;++r)i[vs[r]]=3Dthis[vs[r]];i.__dirty|=3Dmn}else this._deca=
lEl&&(this._decalEl=3Dnull)},a.prototype.getDecalElement=3Dfunction(){retur=
n this._decalEl},a.prototype._init=3Dfunction(t){var e=3Dht(t),n=3D(this.sh=
ape=3Dthis.getDefaultShape(),this.getDefaultStyle());n&&this.useStyle(n);fo=
r(var i=3D0;i<e.length;i++){var o=3De[i],r=3Dt[o];"style"=3D=3D=3Do?this.st=
yle?P(this.style,r):this.useStyle(r):"shape"=3D=3D=3Do?P(this.shape,r):gs.p=
rototype.attrKV.call(this,o,r)}this.style||this.useStyle({})},a.prototype.g=
etDefaultStyle=3Dfunction(){return null},a.prototype.getDefaultShape=3Dfunc=
tion(){return{}},a.prototype.canBeInsideText=3Dfunction(){return this.hasFi=
ll()},a.prototype.getInsideTextFill=3Dfunction(){var t,e=3Dthis.style.fill;=
if("none"!=3D=3De){if(H(e))return.5<(t=3Dwi(e,0))?uo:.2<t?"#eee":ho;if(e)re=
turn ho}return uo},a.prototype.getInsideTextStroke=3Dfunction(t){var e=3Dth=
is.style.fill;if(H(e)){var n=3Dthis.__zr;if(!(!n||!n.isDarkMode())=3D=3Dwi(=
t,0)<.4)return e}},a.prototype.buildPath=3Dfunction(t,e,n){},a.prototype.pa=
thUpdated=3Dfunction(){this.__dirty&=3D~vn},a.prototype.getUpdatedPathProxy=
=3Dfunction(t){return this.path||this.createPathProxy(),this.path.beginPath=
(),this.buildPath(this.path,this.shape,t),this.path},a.prototype.createPath=
Proxy=3Dfunction(){this.path=3Dnew es(!1)},a.prototype.hasStroke=3Dfunction=
(){var t=3Dthis.style,e=3Dt.stroke;return!(null=3D=3De||"none"=3D=3D=3De||!=
(0<t.lineWidth))},a.prototype.hasFill=3Dfunction(){var t=3Dthis.style.fill;=
return null!=3Dt&&"none"!=3D=3Dt},a.prototype.getBoundingRect=3Dfunction(){=
var t,e,n=3Dthis._rect,i=3Dthis.style,o=3D!n;return o&&(t=3D!1,this.path||(=
t=3D!0,this.createPathProxy()),e=3Dthis.path,(t||this.__dirty&vn)&&(e.begin=
Path(),this.buildPath(e,this.shape,!1),this.pathUpdated()),n=3De.getBoundin=
gRect()),this._rect=3Dn,this.hasStroke()&&this.path&&0<this.path.len()?(t=
=3Dthis._rectStroke||(this._rectStroke=3Dn.clone()),(this.__dirty||o)&&(t.c=
opy(n),e=3Di.strokeNoScale?this.getLineScale():1,o=3Di.lineWidth,this.hasFi=
ll()||(i=3Dthis.strokeContainThreshold,o=3DMath.max(o,null=3D=3Di?4:i)),1e-=
10<e)&&(t.width+=3Do/e,t.height+=3Do/e,t.x-=3Do/e/2,t.y-=3Do/e/2),t):n},a.p=
rototype.contain=3Dfunction(t,e){var n=3Dthis.transformCoordToLocal(t,e),i=
=3Dthis.getBoundingRect(),o=3Dthis.style;if(t=3Dn[0],e=3Dn[1],i.contain(t,e=
)){n=3Dthis.path;if(this.hasStroke()){i=3Do.lineWidth,o=3Do.strokeNoScale?t=
his.getLineScale():1;if(1e-10<o&&(this.hasFill()||(i=3DMath.max(i,this.stro=
keContainThreshold)),fs(n,i/o,!0,t,e)))return!0}if(this.hasFill())return fs=
(n,0,!1,t,e)}return!1},a.prototype.dirtyShape=3Dfunction(){this.__dirty|=3D=
vn,this._rect&&(this._rect=3Dnull),this._decalEl&&this._decalEl.dirtyShape(=
),this.markRedraw()},a.prototype.dirty=3Dfunction(){this.dirtyStyle(),this.=
dirtyShape()},a.prototype.animateShape=3Dfunction(t){return this.animate("s=
hape",t)},a.prototype.updateDuringAnimation=3Dfunction(t){"style"=3D=3D=3Dt=
?this.dirtyStyle():"shape"=3D=3D=3Dt?this.dirtyShape():this.markRedraw()},a=
.prototype.attrKV=3Dfunction(t,e){"shape"=3D=3D=3Dt?this.setShape(e):gs.pro=
totype.attrKV.call(this,t,e)},a.prototype.setShape=3Dfunction(t,e){var n=3D=
(n=3Dthis.shape)||(this.shape=3D{});return"string"=3D=3Dtypeof t?n[t]=3De:P=
(n,t),this.dirtyShape(),this},a.prototype.shapeChanged=3Dfunction(){return!=
!(this.__dirty&vn)},a.prototype.createStyle=3Dfunction(t){return Rt(ys,t)},=
a.prototype._innerSaveToNormal=3Dfunction(t){gs.prototype._innerSaveToNorma=
l.call(this,t);var e=3Dthis._normalState;t.shape&&!e.shape&&(e.shape=3DP({}=
,this.shape))},a.prototype._applyStateObj=3Dfunction(t,e,n,i,o,r){gs.protot=
ype._applyStateObj.call(this,t,e,n,i,o,r);var a,s=3D!(e&&i);if(e&&e.shape?o=
?i?a=3De.shape:(a=3DP({},n.shape),P(a,e.shape)):(a=3DP({},(i?this:n).shape)=
,P(a,e.shape)):s&&(a=3Dn.shape),a)if(o){this.shape=3DP({},this.shape);for(v=
ar l=3D{},u=3Dht(a),h=3D0;h<u.length;h++){var c=3Du[h];"object"=3D=3Dtypeof=
 a[c]?this.shape[c]=3Da[c]:l[c]=3Da[c]}this._transitionState(t,{shape:l},r)=
}else this.shape=3Da,this.dirtyShape()},a.prototype._mergeStates=3Dfunction=
(t){for(var e,n=3Dgs.prototype._mergeStates.call(this,t),i=3D0;i<t.length;i=
++){var o=3Dt[i];o.shape&&this._mergeStyle(e=3De||{},o.shape)}return e&&(n.=
shape=3De),n},a.prototype.getAnimationStyleProps=3Dfunction(){return ms},a.=
prototype.isZeroArea=3Dfunction(){return!1},a.extend=3Dfunction(n){u(o,i=3D=
a),o.prototype.getDefaultStyle=3Dfunction(){return y(n.style)},o.prototype.=
getDefaultShape=3Dfunction(){return y(n.shape)};var i,t,e=3Do;function o(t)=
{var e=3Di.call(this,t)||this;return n.init&&n.init.call(e,t),e}for(t in n)=
"function"=3D=3Dtypeof n[t]&&(e.prototype[t]=3Dn[t]);return e},a.initDefaul=
tProps=3D((mu=3Da.prototype).type=3D"path",mu.strokeContainThreshold=3D5,mu=
.segmentIgnoreThreshold=3D0,mu.subPixelOptimize=3D!1,mu.autoBatch=3D!1,void=
(mu.__dirty=3D2|mn|vn)),a);function a(t){return gs.call(this,t)||this}var x=
s,ws=3DB({strokeFirst:!0,font:j,x:0,y:0,textAlign:"left",textBaseline:"top"=
,miterLimit:2},ys),bs=3D(u(Ss,xs=3De),Ss.prototype.hasStroke=3Dfunction(){v=
ar t=3Dthis.style,e=3Dt.stroke;return null!=3De&&"none"!=3D=3De&&0<t.lineWi=
dth},Ss.prototype.hasFill=3Dfunction(){var t=3Dthis.style.fill;return null!=
=3Dt&&"none"!=3D=3Dt},Ss.prototype.createStyle=3Dfunction(t){return Rt(ws,t=
)},Ss.prototype.setBoundingRect=3Dfunction(t){this._rect=3Dt},Ss.prototype.=
getBoundingRect=3Dfunction(){var t,e=3Dthis.style;return this._rect||(null!=
=3D(t=3De.text)?t+=3D"":t=3D"",(t=3DMo(t,e.font,e.textAlign,e.textBaseline)=
).x+=3De.x||0,t.y+=3De.y||0,this.hasStroke()&&(e=3De.lineWidth,t.x-=3De/2,t=
.y-=3De/2,t.width+=3De,t.height+=3De),this._rect=3Dt),this._rect},Ss.initDe=
faultProps=3Dvoid(Ss.prototype.dirtyRectTolerance=3D10),Ss);function Ss(){r=
eturn null!=3D=3Dxs&&xs.apply(this,arguments)||this}bs.prototype.type=3D"ts=
pan";var Ms=3DB({x:0,y:0},xa),Ts=3D{style:B({x:!0,y:!0,width:!0,height:!0,s=
x:!0,sy:!0,sWidth:!0,sHeight:!0},wa.style)};u(Ds,Is=3De),Ds.prototype.creat=
eStyle=3Dfunction(t){return Rt(Ms,t)},Ds.prototype._getSize=3Dfunction(t){v=
ar e,n=3Dthis.style,i=3Dn[t];return null!=3Di?i:(i=3D(i=3Dn.image)&&"string=
"!=3Dtypeof i&&i.width&&i.height?n.image:this.__image)?null=3D=3D(e=3Dn[n=
=3D"width"=3D=3D=3Dt?"height":"width"])?i[t]:i[t]/i[n]*e:0},Ds.prototype.ge=
tWidth=3Dfunction(){return this._getSize("width")},Ds.prototype.getHeight=
=3Dfunction(){return this._getSize("height")},Ds.prototype.getAnimationStyl=
eProps=3Dfunction(){return Ts},Ds.prototype.getBoundingRect=3Dfunction(){va=
r t=3Dthis.style;return this._rect||(this._rect=3Dnew G(t.x||0,t.y||0,this.=
getWidth(),this.getHeight())),this._rect};var Is,Cs=3DDs;function Ds(){retu=
rn null!=3D=3DIs&&Is.apply(this,arguments)||this}Cs.prototype.type=3D"image=
";var ks=3DMath.round;function As(t,e,n){var i,o,r;if(e)return i=3De.x1,o=
=3De.x2,r=3De.y1,e=3De.y2,t.x1=3Di,t.x2=3Do,t.y1=3Dr,t.y2=3De,(n=3Dn&&n.lin=
eWidth)&&(ks(2*i)=3D=3D=3Dks(2*o)&&(t.x1=3Dt.x2=3DPs(i,n,!0)),ks(2*r)=3D=3D=
=3Dks(2*e))&&(t.y1=3Dt.y2=3DPs(r,n,!0)),t}function Ls(t,e,n){var i,o,r;if(e=
)return i=3De.x,o=3De.y,r=3De.width,e=3De.height,t.x=3Di,t.y=3Do,t.width=3D=
r,t.height=3De,(n=3Dn&&n.lineWidth)&&(t.x=3DPs(i,n,!0),t.y=3DPs(o,n,!0),t.w=
idth=3DMath.max(Ps(i+r,n,!1)-t.x,0=3D=3D=3Dr?0:1),t.height=3DMath.max(Ps(o+=
e,n,!1)-t.y,0=3D=3D=3De?0:1)),t}function Ps(t,e,n){var i;return e?((i=3Dks(=
2*t))+ks(e))%2=3D=3D0?i/2:(i+(n?1:-1))/2:t}function Os(){this.x=3D0,this.y=
=3D0,this.width=3D0,this.height=3D0}var Rs,Ns=3D{},Es=3D(u(zs,Rs=3D_s),zs.p=
rototype.getDefaultShape=3Dfunction(){return new Os},zs.prototype.buildPath=
=3Dfunction(t,e){var n,i,o,r,a,s,l,u,h,c,p,d,f,g;this.subPixelOptimize?(n=
=3D(a=3DLs(Ns,e,this.style)).x,i=3Da.y,o=3Da.width,r=3Da.height,a.r=3De.r,e=
=3Da):(n=3De.x,i=3De.y,o=3De.width,r=3De.height),e.r?(a=3Dt,p=3D(e=3De).x,d=
=3De.y,f=3De.width,g=3De.height,e=3De.r,f<0&&(p+=3Df,f=3D-f),g<0&&(d+=3Dg,g=
=3D-g),"number"=3D=3Dtypeof e?s=3Dl=3Du=3Dh=3De:e instanceof Array?1=3D=3D=
=3De.length?s=3Dl=3Du=3Dh=3De[0]:2=3D=3D=3De.length?(s=3Du=3De[0],l=3Dh=3De=
[1]):3=3D=3D=3De.length?(s=3De[0],l=3Dh=3De[1],u=3De[2]):(s=3De[0],l=3De[1]=
,u=3De[2],h=3De[3]):s=3Dl=3Du=3Dh=3D0,f<s+l&&(s*=3Df/(c=3Ds+l),l*=3Df/c),f<=
u+h&&(u*=3Df/(c=3Du+h),h*=3Df/c),g<l+u&&(l*=3Dg/(c=3Dl+u),u*=3Dg/c),g<s+h&&=
(s*=3Dg/(c=3Ds+h),h*=3Dg/c),a.moveTo(p+s,d),a.lineTo(p+f-l,d),0!=3D=3Dl&&a.=
arc(p+f-l,d+l,l,-Math.PI/2,0),a.lineTo(p+f,d+g-u),0!=3D=3Du&&a.arc(p+f-u,d+=
g-u,u,0,Math.PI/2),a.lineTo(p+h,d+g),0!=3D=3Dh&&a.arc(p+h,d+g-h,h,Math.PI/2=
,Math.PI),a.lineTo(p,d+s),0!=3D=3Ds&&a.arc(p+s,d+s,s,Math.PI,1.5*Math.PI)):=
t.rect(n,i,o,r)},zs.prototype.isZeroArea=3Dfunction(){return!this.shape.wid=
th||!this.shape.height},zs);function zs(t){return Rs.call(this,t)||this}Es.=
prototype.type=3D"rect";var Bs,Fs=3D{fill:"#000"},Vs=3D{style:B({fill:!0,st=
roke:!0,fillOpacity:!0,strokeOpacity:!0,lineWidth:!0,fontSize:!0,lineHeight=
:!0,width:!0,height:!0,textShadowColor:!0,textShadowBlur:!0,textShadowOffse=
tX:!0,textShadowOffsetY:!0,backgroundColor:!0,padding:!0,borderColor:!0,bor=
derWidth:!0,borderRadius:!0},wa.style)},Hs=3D(u(Us,Bs=3De),Us.prototype.chi=
ldrenRef=3Dfunction(){return this._children},Us.prototype.update=3Dfunction=
(){Bs.prototype.update.call(this),this.styleChanged()&&this._updateSubTexts=
();for(var t=3D0;t<this._children.length;t++){var e=3Dthis._children[t];e.z=
level=3Dthis.zlevel,e.z=3Dthis.z,e.z2=3Dthis.z2,e.culling=3Dthis.culling,e.=
cursor=3Dthis.cursor,e.invisible=3Dthis.invisible}},Us.prototype.updateTran=
sform=3Dfunction(){var t=3Dthis.innerTransformable;t?(t.updateTransform(),t=
.transform&&(this.transform=3Dt.transform)):Bs.prototype.updateTransform.ca=
ll(this)},Us.prototype.getLocalTransform=3Dfunction(t){var e=3Dthis.innerTr=
ansformable;return e?e.getLocalTransform(t):Bs.prototype.getLocalTransform.=
call(this,t)},Us.prototype.getComputedTransform=3Dfunction(){return this.__=
hostTarget&&(this.__hostTarget.getComputedTransform(),this.__hostTarget.upd=
ateInnerText(!0)),Bs.prototype.getComputedTransform.call(this)},Us.prototyp=
e._updateSubTexts=3Dfunction(){var t;this._childCursor=3D0,Zs(t=3Dthis.styl=
e),E(t.rich,Zs),this.style.rich?this._updateRichTexts():this._updatePlainTe=
xts(),this._children.length=3Dthis._childCursor,this.styleUpdated()},Us.pro=
totype.addSelfToZr=3Dfunction(t){Bs.prototype.addSelfToZr.call(this,t);for(=
var e=3D0;e<this._children.length;e++)this._children[e].__zr=3Dt},Us.protot=
ype.removeSelfFromZr=3Dfunction(t){Bs.prototype.removeSelfFromZr.call(this,=
t);for(var e=3D0;e<this._children.length;e++)this._children[e].__zr=3Dnull}=
,Us.prototype.getBoundingRect=3Dfunction(){if(this.styleChanged()&&this._up=
dateSubTexts(),!this._rect){for(var t=3Dnew G(0,0,0,0),e=3Dthis._children,n=
=3D[],i=3Dnull,o=3D0;o<e.length;o++){var r=3De[o],a=3Dr.getBoundingRect(),r=
=3Dr.getLocalTransform(n);r?(t.copy(a),t.applyTransform(r),(i=3Di||t.clone(=
)).union(t)):(i=3Di||a.clone()).union(a)}this._rect=3Di||t}return this._rec=
t},Us.prototype.setDefaultTextStyle=3Dfunction(t){this._defaultStyle=3Dt||F=
s},Us.prototype.setTextContent=3Dfunction(t){},Us.prototype._mergeStyle=3Df=
unction(t,e){var n,i;return e&&(n=3De.rich,i=3Dt.rich||n&&{},P(t,e),n&&i?(t=
his._mergeRich(i,n),t.rich=3Di):i&&(t.rich=3Di)),t},Us.prototype._mergeRich=
=3Dfunction(t,e){for(var n=3Dht(e),i=3D0;i<n.length;i++){var o=3Dn[i];t[o]=
=3Dt[o]||{},P(t[o],e[o])}},Us.prototype.getAnimationStyleProps=3Dfunction()=
{return Vs},Us.prototype._getOrCreateChild=3Dfunction(t){var e=3Dthis._chil=
dren[this._childCursor];return e&&e instanceof t||(e=3Dnew t),(this._childr=
en[this._childCursor++]=3De).__zr=3Dthis.__zr,e.parent=3Dthis,e},Us.prototy=
pe._updatePlainTexts=3Dfunction(){var t,e=3Dthis.style,n=3De.font||j,i=3De.=
padding,o=3Dfunction(t,e){null!=3Dt&&(t+=3D"");var n,i=3De.overflow,o=3De.p=
adding,r=3De.font,a=3D"truncate"=3D=3D=3Di,s=3DCo(r),l=3DR(e.lineHeight,s),=
u=3D!!e.backgroundColor,h=3D"truncate"=3D=3D=3De.lineOverflow,c=3De.width,i=
=3D(n=3Dnull=3D=3Dc||"break"!=3D=3Di&&"breakAll"!=3D=3Di?t?t.split("\n"):[]=
:t?ma(t,e.font,c,"breakAll"=3D=3D=3Di,0).lines:[]).length*l,p=3DR(e.height,=
i);if(p<i&&h&&(h=3DMath.floor(p/l),n=3Dn.slice(0,h)),t&&a&&null!=3Dc)for(va=
r d=3Dua(c,r,e.ellipsis,{minChar:e.truncateMinChar,placeholder:e.placeholde=
r}),f=3D0;f<n.length;f++)n[f]=3Dha(n[f],d);for(var h=3Dp,g=3D0,f=3D0;f<n.le=
ngth;f++)g=3DMath.max(bo(n[f],r),g);return null=3D=3Dc&&(c=3Dg),t=3Dg,o&&(h=
+=3Do[0]+o[2],t+=3Do[1]+o[3],c+=3Do[1]+o[3]),{lines:n,height:p,outerWidth:t=
=3Du?c:t,outerHeight:h,lineHeight:l,calculatedLineHeight:s,contentWidth:g,c=
ontentHeight:i,width:c}}($s(e),e),r=3DQs(e),a=3D!!e.backgroundColor,s=3Do.o=
uterHeight,l=3Do.outerWidth,u=3Do.contentWidth,h=3Do.lines,c=3Do.lineHeight=
,p=3Dthis._defaultStyle,d=3De.x||0,f=3De.y||0,g=3De.align||p.align||"left",=
y=3De.verticalAlign||p.verticalAlign||"top",m=3Dd,v=3DIo(f,o.contentHeight,=
y);(r||i)&&(t=3DTo(d,l,g),f=3DIo(f,s,y),r)&&this._renderBackground(e,e,t,f,=
l,s),v+=3Dc/2,i&&(m=3DKs(d,g,i),"top"=3D=3D=3Dy?v+=3Di[0]:"bottom"=3D=3D=3D=
y&&(v-=3Di[2]));for(var _=3D0,r=3D!1,x=3D(js(("fill"in e?e:(r=3D!0,p)).fill=
)),w=3D(qs("stroke"in e?e.stroke:a||p.autoStroke&&!r?null:(_=3D2,p.stroke))=
),b=3D0<e.textShadowBlur,S=3Dnull!=3De.width&&("truncate"=3D=3D=3De.overflo=
w||"break"=3D=3D=3De.overflow||"breakAll"=3D=3D=3De.overflow),M=3Do.calcula=
tedLineHeight,T=3D0;T<h.length;T++){var I=3Dthis._getOrCreateChild(bs),C=3D=
I.createStyle();I.useStyle(C),C.text=3Dh[T],C.x=3Dm,C.y=3Dv,g&&(C.textAlign=
=3Dg),C.textBaseline=3D"middle",C.opacity=3De.opacity,C.strokeFirst=3D!0,b&=
&(C.shadowBlur=3De.textShadowBlur||0,C.shadowColor=3De.textShadowColor||"tr=
ansparent",C.shadowOffsetX=3De.textShadowOffsetX||0,C.shadowOffsetY=3De.tex=
tShadowOffsetY||0),C.stroke=3Dw,C.fill=3Dx,w&&(C.lineWidth=3De.lineWidth||_=
,C.lineDash=3De.lineDash,C.lineDashOffset=3De.lineDashOffset||0),C.font=3Dn=
,Ys(C,e),v+=3Dc,S&&I.setBoundingRect(new G(To(C.x,e.width,C.textAlign),Io(C=
.y,M,C.textBaseline),u,M))}},Us.prototype._updateRichTexts=3Dfunction(){var=
 t=3Dthis.style,e=3Dfa($s(t),t),n=3De.width,i=3De.outerWidth,o=3De.outerHei=
ght,r=3Dt.padding,a=3Dt.x||0,s=3Dt.y||0,l=3Dthis._defaultStyle,u=3Dt.align|=
|l.align,l=3Dt.verticalAlign||l.verticalAlign,a=3DTo(a,i,u),u=3DIo(s,o,l),h=
=3Da,c=3Du,p=3D(r&&(h+=3Dr[3],c+=3Dr[0]),h+n);Qs(t)&&this._renderBackground=
(t,t,a,u,i,o);for(var d=3D!!t.backgroundColor,f=3D0;f<e.lines.length;f++){f=
or(var g=3De.lines[f],y=3Dg.tokens,m=3Dy.length,v=3Dg.lineHeight,_=3Dg.widt=
h,x=3D0,w=3Dh,b=3Dp,S=3Dm-1,M=3Dvoid 0;x<m&&(!(M=3Dy[x]).align||"left"=3D=
=3D=3DM.align);)this._placeToken(M,t,v,c,w,"left",d),_-=3DM.width,w+=3DM.wi=
dth,x++;for(;0<=3DS&&"right"=3D=3D=3D(M=3Dy[S]).align;)this._placeToken(M,t=
,v,c,b,"right",d),_-=3DM.width,b-=3DM.width,S--;for(w+=3D(n-(w-h)-(p-b)-_)/=
2;x<=3DS;)M=3Dy[x],this._placeToken(M,t,v,c,w+M.width/2,"center",d),w+=3DM.=
width,x++;c+=3Dv}},Us.prototype._placeToken=3Dfunction(t,e,n,i,o,r,a){var s=
=3De.rich[t.styleName]||{},l=3D(s.text=3Dt.text,t.verticalAlign),u=3Di+n/2,=
l=3D("top"=3D=3D=3Dl?u=3Di+t.height/2:"bottom"=3D=3D=3Dl&&(u=3Di+n-t.height=
/2),!t.isLineHolder&&Qs(s)&&this._renderBackground(s,e,"right"=3D=3D=3Dr?o-=
t.width:"center"=3D=3D=3Dr?o-t.width/2:o,u-t.height/2,t.width,t.height),!!s=
.backgroundColor),i=3Dt.textPadding,n=3D(i&&(o=3DKs(o,r,i),u-=3Dt.height/2-=
i[0]-t.innerHeight/2),this._getOrCreateChild(bs)),i=3Dn.createStyle(),h=3D(=
n.useStyle(i),this._defaultStyle),c=3D!1,p=3D0,d=3Djs(("fill"in s?s:"fill"i=
n e?e:(c=3D!0,h)).fill),l=3Dqs("stroke"in s?s.stroke:"stroke"in e?e.stroke:=
l||a||h.autoStroke&&!c?null:(p=3D2,h.stroke)),a=3D0<s.textShadowBlur||0<e.t=
extShadowBlur,c=3D(i.text=3Dt.text,i.x=3Do,i.y=3Du,a&&(i.shadowBlur=3Ds.tex=
tShadowBlur||e.textShadowBlur||0,i.shadowColor=3Ds.textShadowColor||e.textS=
hadowColor||"transparent",i.shadowOffsetX=3Ds.textShadowOffsetX||e.textShad=
owOffsetX||0,i.shadowOffsetY=3Ds.textShadowOffsetY||e.textShadowOffsetY||0)=
,i.textAlign=3Dr,i.textBaseline=3D"middle",i.font=3Dt.font||j,i.opacity=3Dx=
t(s.opacity,e.opacity,1),Ys(i,s),l&&(i.lineWidth=3Dxt(s.lineWidth,e.lineWid=
th,p),i.lineDash=3DR(s.lineDash,e.lineDash),i.lineDashOffset=3De.lineDashOf=
fset||0,i.stroke=3Dl),d&&(i.fill=3Dd),t.contentWidth),h=3Dt.contentHeight;n=
.setBoundingRect(new G(To(i.x,c,i.textAlign),Io(i.y,h,i.textBaseline),c,h))=
},Us.prototype._renderBackground=3Dfunction(t,e,n,i,o,r){var a,s,l,u,h=3Dt.=
backgroundColor,c=3Dt.borderWidth,p=3Dt.borderColor,d=3Dh&&h.image,f=3Dh&&!=
d,g=3Dt.borderRadius,y=3Dthis,g=3D((f||t.lineHeight||c&&p)&&((a=3Dthis._get=
OrCreateChild(Es)).useStyle(a.createStyle()),a.style.fill=3Dnull,(u=3Da.sha=
pe).x=3Dn,u.y=3Di,u.width=3Do,u.height=3Dr,u.r=3Dg,a.dirtyShape()),f?((l=3D=
a.style).fill=3Dh||null,l.fillOpacity=3DR(t.fillOpacity,1)):d&&((s=3Dthis._=
getOrCreateChild(Cs)).onload=3Dfunction(){y.dirtyStyle()},(u=3Ds.style).ima=
ge=3Dh.image,u.x=3Dn,u.y=3Di,u.width=3Do,u.height=3Dr),c&&p&&((l=3Da.style)=
.lineWidth=3Dc,l.stroke=3Dp,l.strokeOpacity=3DR(t.strokeOpacity,1),l.lineDa=
sh=3Dt.borderDash,l.lineDashOffset=3Dt.borderDashOffset||0,a.strokeContainT=
hreshold=3D0,a.hasFill())&&a.hasStroke()&&(l.strokeFirst=3D!0,l.lineWidth*=
=3D2),(a||s).style);g.shadowBlur=3Dt.shadowBlur||0,g.shadowColor=3Dt.shadow=
Color||"transparent",g.shadowOffsetX=3Dt.shadowOffsetX||0,g.shadowOffsetY=
=3Dt.shadowOffsetY||0,g.opacity=3Dxt(t.opacity,e.opacity,1)},Us.makeFont=3D=
function(t){var e,n=3D"";return(n=3Dnull!=3D(e=3Dt).fontSize||e.fontFamily|=
|e.fontWeight?[t.fontStyle,t.fontWeight,"string"!=3Dtypeof(e=3Dt.fontSize)|=
|-1=3D=3D=3De.indexOf("px")&&-1=3D=3D=3De.indexOf("rem")&&-1=3D=3D=3De.inde=
xOf("em")?isNaN(+e)?"12px":e+"px":e,t.fontFamily||"sans-serif"].join(" "):n=
)&&Mt(n)||t.textFont||t.font},Us),Ws=3D{left:!0,right:1,center:1},Gs=3D{top=
:1,bottom:1,middle:1},Xs=3D["fontStyle","fontWeight","fontSize","fontFamily=
"];function Us(t){var e=3DBs.call(this)||this;return e.type=3D"text",e._chi=
ldren=3D[],e._defaultStyle=3DFs,e.attr(t),e}function Ys(t,e){for(var n=3D0;=
n<Xs.length;n++){var i=3DXs[n],o=3De[i];null!=3Do&&(t[i]=3Do)}}function Zs(=
t){var e;t&&(t.font=3DHs.makeFont(t),e=3Dt.align,t.align=3Dnull=3D=3D(e=3D"=
middle"=3D=3D=3De?"center":e)||Ws[e]?e:"left",e=3Dt.verticalAlign,t.vertica=
lAlign=3Dnull=3D=3D(e=3D"center"=3D=3D=3De?"middle":e)||Gs[e]?e:"top",t.pad=
ding)&&(t.padding=3Dbt(t.padding))}function qs(t,e){return null=3D=3Dt||e<=
=3D0||"transparent"=3D=3D=3Dt||"none"=3D=3D=3Dt?null:t.image||t.colorStops?=
"#000":t}function js(t){return null=3D=3Dt||"none"=3D=3D=3Dt?null:t.image||=
t.colorStops?"#000":t}function Ks(t,e,n){return"right"=3D=3D=3De?t-n[1]:"ce=
nter"=3D=3D=3De?t+n[3]/2-n[1]/2:t+n[3]}function $s(t){t=3Dt.text;return nul=
l!=3Dt&&(t+=3D""),t}function Qs(t){return!!(t.backgroundColor||t.lineHeight=
||t.borderWidth&&t.borderColor)}var k=3DRr(),Js=3D1,tl=3D{},el=3DRr(),nl=3D=
Rr(),il=3D0,ol=3D1,rl=3D2,al=3D["emphasis","blur","select"],sl=3D["normal",=
"emphasis","blur","select"],ll=3D"highlight",ul=3D"downplay",hl=3D"select",=
cl=3D"unselect",pl=3D"toggleSelect";function dl(t){return null!=3Dt&&"none"=
!=3D=3Dt}function fl(t,e,n){t.onHoverStateChange&&(t.hoverState||0)!=3D=3Dn=
&&t.onHoverStateChange(e),t.hoverState=3Dn}function gl(t){fl(t,"emphasis",r=
l)}function yl(t){t.hoverState=3D=3D=3Drl&&fl(t,"normal",il)}function ml(t)=
{fl(t,"blur",ol)}function vl(t){t.hoverState=3D=3D=3Dol&&fl(t,"normal",il)}=
function _l(t){t.selected=3D!0}function xl(t){t.selected=3D!1}function wl(t=
,e,n){e(t,n)}function bl(t,e,n){wl(t,e,n),t.isGroup&&t.traverse(function(t)=
{wl(t,e,n)})}function Sl(t,e){switch(e){case"emphasis":t.hoverState=3Drl;br=
eak;case"normal":t.hoverState=3Dil;break;case"blur":t.hoverState=3Dol;break=
;case"select":t.selected=3D!0}}function Ml(t,e,n){var i=3D0<=3DC(t.currentS=
tates,e),o=3Dt.style.opacity,t=3Di?null:function(t,e,n,i){for(var o=3Dt.sty=
le,r=3D{},a=3D0;a<e.length;a++){var s=3De[a],l=3Do[s];r[s]=3Dnull=3D=3Dl?i&=
&i[s]:l}for(a=3D0;a<t.animators.length;a++){var u=3Dt.animators[a];u.__from=
StateTransition&&u.__fromStateTransition.indexOf(n)<0&&"style"=3D=3D=3Du.ta=
rgetName&&u.saveTo(r,e)}return r}(t,["opacity"],e,{opacity:1}),e=3D(n=3Dn||=
{}).style||{};return null=3D=3De.opacity&&(n=3DP({},n),e=3DP({opacity:i?o:.=
1*t.opacity},e),n.style=3De),n}function Tl(t,e){var n,i,o,r,a,s=3Dthis.stat=
es[t];if(this.style){if("emphasis"=3D=3D=3Dt)return n=3Dthis,i=3Ds,e=3D(e=
=3De)&&0<=3DC(e,"select"),a=3D!1,n instanceof _s&&(o=3Del(n),r=3De&&o.selec=
tFill||o.normalFill,e=3De&&o.selectStroke||o.normalStroke,dl(r)||dl(e))&&("=
inherit"=3D=3D=3D(o=3D(i=3Di||{}).style||{}).fill?(a=3D!0,i=3DP({},i),(o=3D=
P({},o)).fill=3Dr):!dl(o.fill)&&dl(r)?(a=3D!0,i=3DP({},i),(o=3DP({},o)).fil=
l=3DSi(r)):!dl(o.stroke)&&dl(e)&&(a||(i=3DP({},i),o=3DP({},o)),o.stroke=3DS=
i(e)),i.style=3Do),i&&null=3D=3Di.z2&&(a||(i=3DP({},i)),r=3Dn.z2EmphasisLif=
t,i.z2=3Dn.z2+(null!=3Dr?r:10)),i;if("blur"=3D=3D=3Dt)return Ml(this,t,s);i=
f("select"=3D=3D=3Dt)return e=3Dthis,(o=3Ds)&&null=3D=3Do.z2&&(o=3DP({},o),=
a=3De.z2SelectLift,o.z2=3De.z2+(null!=3Da?a:9)),o}return s}function Il(t){t=
.stateProxy=3DTl;var e=3Dt.getTextContent(),t=3Dt.getTextGuideLine();e&&(e.=
stateProxy=3DTl),t&&(t.stateProxy=3DTl)}function Cl(t,e){Nl(t,e)||t.__highB=
yOuter||bl(t,gl)}function Dl(t,e){Nl(t,e)||t.__highByOuter||bl(t,yl)}functi=
on kl(t,e){t.__highByOuter|=3D1<<(e||0),bl(t,gl)}function Al(t,e){(t.__high=
ByOuter&=3D~(1<<(e||0)))||bl(t,yl)}function Ll(t){bl(t,ml)}function Pl(t){b=
l(t,vl)}function Ol(t){bl(t,_l)}function Rl(t){bl(t,xl)}function Nl(t,e){re=
turn t.__highDownSilentOnTouch&&e.zrByTouch}function El(o){var e=3Do.getMod=
el(),r=3D[],a=3D[];e.eachComponent(function(t,e){var n=3Dnl(e),t=3D"series"=
=3D=3D=3Dt,i=3Dt?o.getViewOfSeriesModel(e):o.getViewOfComponentModel(e);t||=
a.push(i),n.isBlured&&(i.group.traverse(function(t){vl(t)}),t)&&r.push(e),n=
.isBlured=3D!1}),E(a,function(t){t&&t.toggleBlurSeries&&t.toggleBlurSeries(=
r,!1,e)})}function zl(t,r,a,s){var l,u,h,n=3Ds.getModel();function c(t,e){f=
or(var n=3D0;n<e.length;n++){var i=3Dt.getItemGraphicEl(e[n]);i&&Pl(i)}}a=
=3Da||"coordinateSystem",null!=3Dt&&r&&"none"!=3D=3Dr&&(l=3Dn.getSeriesByIn=
dex(t),(u=3Dl.coordinateSystem)&&u.master&&(u=3Du.master),h=3D[],n.eachSeri=
es(function(t){var e=3Dl=3D=3D=3Dt,n=3Dt.coordinateSystem;if(n&&n.master&&(=
n=3Dn.master),!("series"=3D=3D=3Da&&!e||"coordinateSystem"=3D=3D=3Da&&!(n&&=
u?n=3D=3D=3Du:e)||"series"=3D=3D=3Dr&&e)){if(s.getViewOfSeriesModel(t).grou=
p.traverse(function(t){t.__highByOuter&&e&&"self"=3D=3D=3Dr||ml(t)}),st(r))=
c(t.getData(),r);else if(O(r))for(var i=3Dht(r),o=3D0;o<i.length;o++)c(t.ge=
tData(i[o]),r[i[o]]);h.push(t),nl(t).isBlured=3D!0}}),n.eachComponent(funct=
ion(t,e){"series"!=3D=3Dt&&(t=3Ds.getViewOfComponentModel(e))&&t.toggleBlur=
Series&&t.toggleBlurSeries(h,!0,n)}))}function Bl(t,e,n){null!=3Dt&&null!=
=3De&&(t=3Dn.getModel().getComponent(t,e))&&(nl(t).isBlured=3D!0,e=3Dn.getV=
iewOfComponentModel(t))&&e.focusBlurEnabled&&e.group.traverse(function(t){m=
l(t)})}function Fl(t,e,n,i){var o=3D{focusSelf:!1,dispatchers:null};if(null=
=3D=3Dt||"series"=3D=3D=3Dt||null=3D=3De||null=3D=3Dn)return o;t=3Di.getMod=
el().getComponent(t,e);if(!t)return o;e=3Di.getViewOfComponentModel(t);if(!=
e||!e.findHighDownDispatchers)return o;for(var r,a=3De.findHighDownDispatch=
ers(n),s=3D0;s<a.length;s++)if("self"=3D=3D=3Dk(a[s]).focus){r=3D!0;break}r=
eturn{focusSelf:r,dispatchers:a}}function Vl(i){E(i.getAllData(),function(t=
){var e=3Dt.data,n=3Dt.type;e.eachItemGraphicEl(function(t,e){(i.isSelected=
(e,n)?Ol:Rl)(t)})})}function Hl(t,e,n){Yl(t,!0),bl(t,Il);t=3Dk(t),null!=3De=
?(t.focus=3De,t.blurScope=3Dn):t.focus&&(t.focus=3Dnull)}function Wl(t,e,n,=
i){i?Yl(t,!1):Hl(t,e,n)}var Gl=3D["emphasis","blur","select"],Xl=3D{itemSty=
le:"getItemStyle",lineStyle:"getLineStyle",areaStyle:"getAreaStyle"};functi=
on Ul(t,e,n,i){n=3Dn||"itemStyle";for(var o=3D0;o<Gl.length;o++){var r=3DGl=
[o],a=3De.getModel([r,n]);t.ensureState(r).style=3Di?i(a):a[Xl[n]]()}}funct=
ion Yl(t,e){var e=3D!1=3D=3D=3De,n=3Dt;t.highDownSilentOnTouch&&(n.__highDo=
wnSilentOnTouch=3Dt.highDownSilentOnTouch),e&&!n.__highDownDispatcher||(n._=
_highByOuter=3Dn.__highByOuter||0,n.__highDownDispatcher=3D!e)}function Zl(=
t){return!(!t||!t.__highDownDispatcher)}function ql(t){t=3Dt.type;return t=
=3D=3D=3Dhl||t=3D=3D=3Dcl||t=3D=3D=3Dpl}function jl(t){t=3Dt.type;return t=
=3D=3D=3Dll||t=3D=3D=3Dul}var Kl=3Des.CMD,$l=3D[[],[],[]],Ql=3DMath.sqrt,Jl=
=3DMath.atan2;var tu=3DMath.sqrt,eu=3DMath.sin,nu=3DMath.cos,iu=3DMath.PI;f=
unction ou(t){return Math.sqrt(t[0]*t[0]+t[1]*t[1])}function ru(t,e){return=
(t[0]*e[0]+t[1]*e[1])/(ou(t)*ou(e))}function au(t,e){return(t[0]*e[1]<t[1]*=
e[0]?-1:1)*Math.acos(ru(t,e))}function su(t,e,n,i,o,r,a,s,l,u,h){var l=3Dl*=
(iu/180),c=3Dnu(l)*(t-n)/2+eu(l)*(e-i)/2,p=3D-1*eu(l)*(t-n)/2+nu(l)*(e-i)/2=
,d=3Dc*c/(a*a)+p*p/(s*s),d=3D(1<d&&(a*=3Dtu(d),s*=3Dtu(d)),(o=3D=3D=3Dr?-1:=
1)*tu((a*a*(s*s)-a*a*(p*p)-s*s*(c*c))/(a*a*(p*p)+s*s*(c*c)))||0),o=3Dd*a*p/=
s,d=3Dd*-s*c/a,t=3D(t+n)/2+nu(l)*o-eu(l)*d,n=3D(e+i)/2+eu(l)*o+nu(l)*d,e=3D=
au([1,0],[(c-o)/a,(p-d)/s]),i=3D[(c-o)/a,(p-d)/s],c=3D[(-1*c-o)/a,(-1*p-d)/=
s],o=3Dau(i,c);ru(i,c)<=3D-1&&(o=3Diu),(o=3D1<=3Dru(i,c)?0:o)<0&&(p=3DMath.=
round(o/iu*1e6)/1e6,o=3D2*iu+p%2*iu),h.addData(u,t,n,a,s,e,o,l,r)}var lu=3D=
/([mlvhzcqtsa])([^mlvhzcqtsa]*)/gi,uu=3D/-?([0-9]*\.)?[0-9]+([eE]-?[0-9]+)?=
/g;u(pu,hu=3D_s),pu.prototype.applyTransform=3Dfunction(t){};var hu,cu=3Dpu=
;function pu(){return null!=3D=3Dhu&&hu.apply(this,arguments)||this}functio=
n du(t){return null!=3Dt.setData}function fu(t,e){var S=3Dfunction(t){var e=
=3Dnew es;if(t){var n,i=3D0,o=3D0,r=3Di,a=3Do,s=3Des.CMD,l=3Dt.match(lu);if=
(l){for(var u=3D0;u<l.length;u++){for(var h=3Dl[u],c=3Dh.charAt(0),p=3Dvoid=
 0,d=3Dh.match(uu)||[],f=3Dd.length,g=3D0;g<f;g++)d[g]=3DparseFloat(d[g]);f=
or(var y=3D0;y<f;){var m=3Dvoid 0,v=3Dvoid 0,_=3Dvoid 0,x=3Dvoid 0,w=3Dvoid=
 0,b=3Dvoid 0,S=3Dvoid 0,M=3Di,T=3Do,I=3Dvoid 0,C=3Dvoid 0;switch(c){case"l=
":i+=3Dd[y++],o+=3Dd[y++],p=3Ds.L,e.addData(p,i,o);break;case"L":i=3Dd[y++]=
,o=3Dd[y++],p=3Ds.L,e.addData(p,i,o);break;case"m":i+=3Dd[y++],o+=3Dd[y++],=
p=3Ds.M,e.addData(p,i,o),r=3Di,a=3Do,c=3D"l";break;case"M":i=3Dd[y++],o=3Dd=
[y++],p=3Ds.M,e.addData(p,i,o),r=3Di,a=3Do,c=3D"L";break;case"h":i+=3Dd[y++=
],p=3Ds.L,e.addData(p,i,o);break;case"H":i=3Dd[y++],p=3Ds.L,e.addData(p,i,o=
);break;case"v":o+=3Dd[y++],p=3Ds.L,e.addData(p,i,o);break;case"V":o=3Dd[y+=
+],p=3Ds.L,e.addData(p,i,o);break;case"C":p=3Ds.C,e.addData(p,d[y++],d[y++]=
,d[y++],d[y++],d[y++],d[y++]),i=3Dd[y-2],o=3Dd[y-1];break;case"c":p=3Ds.C,e=
.addData(p,d[y++]+i,d[y++]+o,d[y++]+i,d[y++]+o,d[y++]+i,d[y++]+o),i+=3Dd[y-=
2],o+=3Dd[y-1];break;case"S":m=3Di,v=3Do,I=3De.len(),C=3De.data,n=3D=3D=3Ds=
.C&&(m+=3Di-C[I-4],v+=3Do-C[I-3]),p=3Ds.C,M=3Dd[y++],T=3Dd[y++],i=3Dd[y++],=
o=3Dd[y++],e.addData(p,m,v,M,T,i,o);break;case"s":m=3Di,v=3Do,I=3De.len(),C=
=3De.data,n=3D=3D=3Ds.C&&(m+=3Di-C[I-4],v+=3Do-C[I-3]),p=3Ds.C,M=3Di+d[y++]=
,T=3Do+d[y++],i+=3Dd[y++],o+=3Dd[y++],e.addData(p,m,v,M,T,i,o);break;case"Q=
":M=3Dd[y++],T=3Dd[y++],i=3Dd[y++],o=3Dd[y++],p=3Ds.Q,e.addData(p,M,T,i,o);=
break;case"q":M=3Dd[y++]+i,T=3Dd[y++]+o,i+=3Dd[y++],o+=3Dd[y++],p=3Ds.Q,e.a=
ddData(p,M,T,i,o);break;case"T":m=3Di,v=3Do,I=3De.len(),C=3De.data,n=3D=3D=
=3Ds.Q&&(m+=3Di-C[I-4],v+=3Do-C[I-3]),i=3Dd[y++],o=3Dd[y++],p=3Ds.Q,e.addDa=
ta(p,m,v,i,o);break;case"t":m=3Di,v=3Do,I=3De.len(),C=3De.data,n=3D=3D=3Ds.=
Q&&(m+=3Di-C[I-4],v+=3Do-C[I-3]),i+=3Dd[y++],o+=3Dd[y++],p=3Ds.Q,e.addData(=
p,m,v,i,o);break;case"A":_=3Dd[y++],x=3Dd[y++],w=3Dd[y++],b=3Dd[y++],S=3Dd[=
y++],su(M=3Di,T=3Do,i=3Dd[y++],o=3Dd[y++],b,S,_,x,w,p=3Ds.A,e);break;case"a=
":_=3Dd[y++],x=3Dd[y++],w=3Dd[y++],b=3Dd[y++],S=3Dd[y++],su(M=3Di,T=3Do,i+=
=3Dd[y++],o+=3Dd[y++],b,S,_,x,w,p=3Ds.A,e)}}"z"!=3D=3Dc&&"Z"!=3D=3Dc||(p=3D=
s.Z,e.addData(p),i=3Dr,o=3Da),n=3Dp}e.toStatic()}}return e}(t),t=3DP({},e);=
return t.buildPath=3Dfunction(t){var e;du(t)?(t.setData(S.data),(e=3Dt.getC=
ontext())&&t.rebuildPath(e,1)):S.rebuildPath(e=3Dt,1)},t.applyTransform=3Df=
unction(t){var e=3DS,n=3Dt;if(n){for(var i,o,r,a,s=3De.data,l=3De.len(),u=
=3DKl.M,h=3DKl.C,c=3DKl.L,p=3DKl.R,d=3DKl.A,f=3DKl.Q,g=3D0,y=3D0;g<l;){swit=
ch(i=3Ds[g++],y=3Dg,o=3D0,i){case u:case c:o=3D1;break;case h:o=3D3;break;c=
ase f:o=3D2;break;case d:var m=3Dn[4],v=3Dn[5],_=3DQl(n[0]*n[0]+n[1]*n[1]),=
x=3DQl(n[2]*n[2]+n[3]*n[3]),w=3DJl(-n[1]/x,n[0]/_);s[g]*=3D_,s[g++]+=3Dm,s[=
g]*=3Dx,s[g++]+=3Dv,s[g++]*=3D_,s[g++]*=3Dx,s[g++]+=3Dw,s[g++]+=3Dw,y=3Dg+=
=3D2;break;case p:a[0]=3Ds[g++],a[1]=3Ds[g++],Jt(a,a,n),s[y++]=3Da[0],s[y++=
]=3Da[1],a[0]+=3Ds[g++],a[1]+=3Ds[g++],Jt(a,a,n),s[y++]=3Da[0],s[y++]=3Da[1=
]}for(r=3D0;r<o;r++){var b=3D$l[r];b[0]=3Ds[g++],b[1]=3Ds[g++],Jt(b,b,n),s[=
y++]=3Db[0],s[y++]=3Db[1]}}e.increaseVersion()}this.dirtyShape()},t}functio=
n gu(){this.cx=3D0,this.cy=3D0,this.r=3D0}u(vu,yu=3D_s),vu.prototype.getDef=
aultShape=3Dfunction(){return new gu},vu.prototype.buildPath=3Dfunction(t,e=
){t.moveTo(e.cx+e.r,e.cy),t.arc(e.cx,e.cy,e.r,0,2*Math.PI)};var yu,mu=3Dvu;=
function vu(t){return yu.call(this,t)||this}mu.prototype.type=3D"circle";fu=
nction _u(){this.cx=3D0,this.cy=3D0,this.rx=3D0,this.ry=3D0}u(bu,xu=3D_s),b=
u.prototype.getDefaultShape=3Dfunction(){return new _u},bu.prototype.buildP=
ath=3Dfunction(t,e){var n=3De.cx,i=3De.cy,o=3De.rx,e=3De.ry,r=3D.5522848*o,=
a=3D.5522848*e;t.moveTo(n-o,i),t.bezierCurveTo(n-o,i-a,n-r,i-e,n,i-e),t.bez=
ierCurveTo(n+r,i-e,n+o,i-a,n+o,i),t.bezierCurveTo(n+o,i+a,n+r,i+e,n,i+e),t.=
bezierCurveTo(n-r,i+e,n-o,i+a,n-o,i),t.closePath()};var xu,wu=3Dbu;function=
 bu(t){return xu.call(this,t)||this}wu.prototype.type=3D"ellipse";var Su=3D=
Math.PI,Mu=3D2*Su,Tu=3DMath.sin,Iu=3DMath.cos,Cu=3DMath.acos,Du=3DMath.atan=
2,ku=3DMath.abs,Au=3DMath.sqrt,Lu=3DMath.max,Pu=3DMath.min,Ou=3D1e-4;functi=
on Ru(t,e,n,i,o,r,a){var s=3Dt-n,l=3De-i,a=3D(a?r:-r)/Au(s*s+l*l),l=3Da*l,a=
=3D-a*s,s=3Dt+l,t=3De+a,e=3Dn+l,n=3Di+a,i=3D(s+e)/2,u=3D(t+n)/2,h=3De-s,c=
=3Dn-t,p=3Dh*h+c*c,r=3Do-r,s=3Ds*n-e*t,n=3D(c<0?-1:1)*Au(Lu(0,r*r*p-s*s)),e=
=3D(s*c-h*n)/p,t=3D(-s*h-c*n)/p,d=3D(s*c+h*n)/p,s=3D(-s*h+c*n)/p,h=3De-i,c=
=3Dt-u,n=3Dd-i,p=3Ds-u;return n*n+p*p<h*h+c*c&&(e=3Dd,t=3Ds),{cx:e,cy:t,x0:=
-l,y0:-a,x1:e*(o/r-1),y1:t*(o/r-1)}}function Nu(t,e){var n,i,o,r,a,s,l,u,h,=
c,p,d,f,g,y,m,v,_,x,w,b,S,M,T,I,C,D,k,A,L,P=3DLu(e.r,0),O=3DLu(e.r0||0,0),R=
=3D0<P;(R||0<O)&&(R||(P=3DO,O=3D0),P<O&&(R=3DP,P=3DO,O=3DR),R=3De.startAngl=
e,n=3De.endAngle,isNaN(R)||isNaN(n)||(i=3De.cx,o=3De.cy,r=3D!!e.clockwise,w=
=3Dku(n-R),Ou<(a=3DMu<w&&w%Mu)&&(w=3Da),Ou<P?Mu-Ou<w?(t.moveTo(i+P*Iu(R),o+=
P*Tu(R)),t.arc(i,o,P,R,n,!r),Ou<O&&(t.moveTo(i+O*Iu(n),o+O*Tu(n)),t.arc(i,o=
,O,n,R,r))):(g=3Df=3Dd=3Dp=3DS=3Db=3Dc=3Dh=3DC=3DI=3DT=3DM=3Du=3Dl=3Ds=3Da=
=3Dvoid 0,y=3DP*Iu(R),m=3DP*Tu(R),v=3DO*Iu(n),_=3DO*Tu(n),(x=3DOu<w)&&((e=
=3De.cornerRadius)&&(a=3D(e=3Dfunction(t){if(V(t)){var e=3Dt.length;if(!e)r=
eturn t;e=3D1=3D=3D=3De?[t[0],t[0],0,0]:2=3D=3D=3De?[t[0],t[0],t[1],t[1]]:3=
=3D=3D=3De?t.concat(t[2]):t}else e=3D[t,t,t,t];return e}(e))[0],s=3De[1],l=
=3De[2],u=3De[3]),e=3Dku(P-O)/2,M=3DPu(e,l),T=3DPu(e,u),I=3DPu(e,a),C=3DPu(=
e,s),b=3Dh=3DLu(M,T),S=3Dc=3DLu(I,C),Ou<h||Ou<c)&&(p=3DP*Iu(n),d=3DP*Tu(n),=
f=3DO*Iu(R),g=3DO*Tu(R),w<Su)&&((e=3Dfunction(t,e,n,i,o,r,a,s){var l=3D(s=
=3Ds-r)*(n=3Dn-t)-(a=3Da-o)*(i=3Di-e);if(!(l*l<Ou))return[t+(l=3D(a*(e-r)-s=
*(t-o))/l)*n,e+l*i]}(y,m,f,g,p,d,v,_))&&(M=3Dy-e[0],T=3Dm-e[1],I=3Dp-e[0],C=
=3Dd-e[1],w=3D1/Tu(Cu((M*I+T*C)/(Au(M*M+T*T)*Au(I*I+C*C)))/2),M=3DAu(e[0]*e=
[0]+e[1]*e[1]),b=3DPu(h,(P-M)/(1+w)),S=3DPu(c,(O-M)/(w-1)))),x?Ou<b?(D=3DPu=
(l,b),k=3DPu(u,b),A=3DRu(f,g,y,m,P,D,r),L=3DRu(p,d,v,_,P,k,r),t.moveTo(i+A.=
cx+A.x0,o+A.cy+A.y0),b<h&&D=3D=3D=3Dk?t.arc(i+A.cx,o+A.cy,b,Du(A.y0,A.x0),D=
u(L.y0,L.x0),!r):(0<D&&t.arc(i+A.cx,o+A.cy,D,Du(A.y0,A.x0),Du(A.y1,A.x1),!r=
),t.arc(i,o,P,Du(A.cy+A.y1,A.cx+A.x1),Du(L.cy+L.y1,L.cx+L.x1),!r),0<k&&t.ar=
c(i+L.cx,o+L.cy,k,Du(L.y1,L.x1),Du(L.y0,L.x0),!r))):(t.moveTo(i+y,o+m),t.ar=
c(i,o,P,R,n,!r)):t.moveTo(i+y,o+m),Ou<O&&x?Ou<S?(D=3DPu(a,S),A=3DRu(v,_,p,d=
,O,-(k=3DPu(s,S)),r),L=3DRu(y,m,f,g,O,-D,r),t.lineTo(i+A.cx+A.x0,o+A.cy+A.y=
0),S<c&&D=3D=3D=3Dk?t.arc(i+A.cx,o+A.cy,S,Du(A.y0,A.x0),Du(L.y0,L.x0),!r):(=
0<k&&t.arc(i+A.cx,o+A.cy,k,Du(A.y0,A.x0),Du(A.y1,A.x1),!r),t.arc(i,o,O,Du(A=
.cy+A.y1,A.cx+A.x1),Du(L.cy+L.y1,L.cx+L.x1),r),0<D&&t.arc(i+L.cx,o+L.cy,D,D=
u(L.y1,L.x1),Du(L.y0,L.x0),!r))):(t.lineTo(i+v,o+_),t.arc(i,o,O,n,R,r)):t.l=
ineTo(i+v,o+_)):t.moveTo(i,o),t.closePath()))}function Eu(){this.cx=3D0,thi=
s.cy=3D0,this.r0=3D0,this.r=3D0,this.startAngle=3D0,this.endAngle=3D2*Math.=
PI,this.clockwise=3D!0,this.cornerRadius=3D0}u(Fu,zu=3D_s),Fu.prototype.get=
DefaultShape=3Dfunction(){return new Eu},Fu.prototype.buildPath=3Dfunction(=
t,e){Nu(t,e)},Fu.prototype.isZeroArea=3Dfunction(){return this.shape.startA=
ngle=3D=3D=3Dthis.shape.endAngle||this.shape.r=3D=3D=3Dthis.shape.r0};var z=
u,Bu=3DFu;function Fu(t){return zu.call(this,t)||this}Bu.prototype.type=3D"=
sector";function Vu(){this.cx=3D0,this.cy=3D0,this.r=3D0,this.r0=3D0}u(Gu,H=
u=3D_s),Gu.prototype.getDefaultShape=3Dfunction(){return new Vu},Gu.prototy=
pe.buildPath=3Dfunction(t,e){var n=3De.cx,i=3De.cy,o=3D2*Math.PI;t.moveTo(n=
+e.r,i),t.arc(n,i,e.r,0,o,!1),t.moveTo(n+e.r0,i),t.arc(n,i,e.r0,0,o,!0)};va=
r Hu,Wu=3DGu;function Gu(t){return Hu.call(this,t)||this}function Xu(t,e,n)=
{var i=3De.smooth,o=3De.points;if(o&&2<=3Do.length){if(i){var r=3Dfunction(=
t,e,n,i){var o,r,a=3D[],s=3D[],l=3D[],u=3D[];if(i){for(var h=3D[1/0,1/0],c=
=3D[-1/0,-1/0],p=3D0,d=3Dt.length;p<d;p++)te(h,h,t[p]),ee(c,c,t[p]);te(h,h,=
i[0]),ee(c,c,i[1])}for(p=3D0,d=3Dt.length;p<d;p++){var f=3Dt[p];if(n)o=3Dt[=
p?p-1:d-1],r=3Dt[(p+1)%d];else{if(0=3D=3D=3Dp||p=3D=3D=3Dd-1){a.push(Ht(t[p=
]));continue}o=3Dt[p-1],r=3Dt[p+1]}Gt(s,r,o),Yt(s,s,e);var g=3Dqt(f,o),y=3D=
qt(f,r),m=3Dg+y,m=3D(0!=3D=3Dm&&(g/=3Dm,y/=3Dm),Yt(l,s,-g),Yt(u,s,y),Wt([],=
f,l)),g=3DWt([],f,u);i&&(ee(m,m,h),te(m,m,c),ee(g,g,h),te(g,g,c)),a.push(m)=
,a.push(g)}return n&&a.push(a.shift()),a}(o,i,n,e.smoothConstraint);t.moveT=
o(o[0][0],o[0][1]);for(var a=3Do.length,s=3D0;s<(n?a:a-1);s++){var l=3Dr[2*=
s],u=3Dr[2*s+1],h=3Do[(s+1)%a];t.bezierCurveTo(l[0],l[1],u[0],u[1],h[0],h[1=
])}}else{t.moveTo(o[0][0],o[0][1]);for(var s=3D1,c=3Do.length;s<c;s++)t.lin=
eTo(o[s][0],o[s][1])}n&&t.closePath()}}Wu.prototype.type=3D"ring";function =
Uu(){this.points=3Dnull,this.smooth=3D0,this.smoothConstraint=3Dnull}u(qu,Y=
u=3D_s),qu.prototype.getDefaultShape=3Dfunction(){return new Uu},qu.prototy=
pe.buildPath=3Dfunction(t,e){Xu(t,e,!0)};var Yu,Zu=3Dqu;function qu(t){retu=
rn Yu.call(this,t)||this}Zu.prototype.type=3D"polygon";function ju(){this.p=
oints=3Dnull,this.percent=3D1,this.smooth=3D0,this.smoothConstraint=3Dnull}=
u(Qu,Ku=3D_s),Qu.prototype.getDefaultStyle=3Dfunction(){return{stroke:"#000=
",fill:null}},Qu.prototype.getDefaultShape=3Dfunction(){return new ju},Qu.p=
rototype.buildPath=3Dfunction(t,e){Xu(t,e,!1)};var Ku,$u=3DQu;function Qu(t=
){return Ku.call(this,t)||this}$u.prototype.type=3D"polyline";function Ju()=
{this.x1=3D0,this.y1=3D0,this.x2=3D0,this.y2=3D0,this.percent=3D1}var th,eh=
=3D{},nh=3D(u(ih,th=3D_s),ih.prototype.getDefaultStyle=3Dfunction(){return{=
stroke:"#000",fill:null}},ih.prototype.getDefaultShape=3Dfunction(){return =
new Ju},ih.prototype.buildPath=3Dfunction(t,e){r=3D(this.subPixelOptimize?(=
n=3D(r=3DAs(eh,e,this.style)).x1,i=3Dr.y1,o=3Dr.x2,r):(n=3De.x1,i=3De.y1,o=
=3De.x2,e)).y2;var n,i,o,r,e=3De.percent;0!=3D=3De&&(t.moveTo(n,i),e<1&&(o=
=3Dn*(1-e)+o*e,r=3Di*(1-e)+r*e),t.lineTo(o,r))},ih.prototype.pointAt=3Dfunc=
tion(t){var e=3Dthis.shape;return[e.x1*(1-t)+e.x2*t,e.y1*(1-t)+e.y2*t]},ih)=
;function ih(t){return th.call(this,t)||this}nh.prototype.type=3D"line";fun=
ction oh(){this.x1=3D0,this.y1=3D0,this.x2=3D0,this.y2=3D0,this.cpx1=3D0,th=
is.cpy1=3D0,this.percent=3D1}var rh=3D[];function ah(t,e,n){var i=3Dt.cpx2,=
o=3Dt.cpy2;return null!=3Di||null!=3Do?[(n?zn:En)(t.x1,t.cpx1,t.cpx2,t.x2,e=
),(n?zn:En)(t.y1,t.cpy1,t.cpy2,t.y2,e)]:[(n?Gn:Wn)(t.x1,t.cpx1,t.x2,e),(n?G=
n:Wn)(t.y1,t.cpy1,t.y2,e)]}u(uh,sh=3D_s),uh.prototype.getDefaultStyle=3Dfun=
ction(){return{stroke:"#000",fill:null}},uh.prototype.getDefaultShape=3Dfun=
ction(){return new oh},uh.prototype.buildPath=3Dfunction(t,e){var n=3De.x1,=
i=3De.y1,o=3De.x2,r=3De.y2,a=3De.cpx1,s=3De.cpy1,l=3De.cpx2,u=3De.cpy2,e=3D=
e.percent;0!=3D=3De&&(t.moveTo(n,i),null=3D=3Dl||null=3D=3Du?(e<1&&(Un(n,a,=
o,e,rh),a=3Drh[1],o=3Drh[2],Un(i,s,r,e,rh),s=3Drh[1],r=3Drh[2]),t.quadratic=
CurveTo(a,s,o,r)):(e<1&&(Vn(n,a,l,o,e,rh),a=3Drh[1],l=3Drh[2],o=3Drh[3],Vn(=
i,s,u,r,e,rh),s=3Drh[1],u=3Drh[2],r=3Drh[3]),t.bezierCurveTo(a,s,l,u,o,r)))=
},uh.prototype.pointAt=3Dfunction(t){return ah(this.shape,t,!1)},uh.prototy=
pe.tangentAt=3Dfunction(t){t=3Dah(this.shape,t,!0);return Zt(t,t)};var sh,l=
h=3Duh;function uh(t){return sh.call(this,t)||this}lh.prototype.type=3D"bez=
ier-curve";function hh(){this.cx=3D0,this.cy=3D0,this.r=3D0,this.startAngle=
=3D0,this.endAngle=3D2*Math.PI,this.clockwise=3D!0}u(dh,ch=3D_s),dh.prototy=
pe.getDefaultStyle=3Dfunction(){return{stroke:"#000",fill:null}},dh.prototy=
pe.getDefaultShape=3Dfunction(){return new hh},dh.prototype.buildPath=3Dfun=
ction(t,e){var n=3De.cx,i=3De.cy,o=3DMath.max(e.r,0),r=3De.startAngle,a=3De=
.endAngle,e=3De.clockwise,s=3DMath.cos(r),l=3DMath.sin(r);t.moveTo(s*o+n,l*=
o+i),t.arc(n,i,o,r,a,!e)};var ch,ph=3Ddh;function dh(t){return ch.call(this=
,t)||this}ph.prototype.type=3D"arc";u(yh,fh=3D_s),yh.prototype._updatePathD=
irty=3Dfunction(){for(var t=3Dthis.shape.paths,e=3Dthis.shapeChanged(),n=3D=
0;n<t.length;n++)e=3De||t[n].shapeChanged();e&&this.dirtyShape()},yh.protot=
ype.beforeBrush=3Dfunction(){this._updatePathDirty();for(var t=3Dthis.shape=
.paths||[],e=3Dthis.getGlobalScale(),n=3D0;n<t.length;n++)t[n].path||t[n].c=
reatePathProxy(),t[n].path.setScale(e[0],e[1],t[n].segmentIgnoreThreshold)}=
,yh.prototype.buildPath=3Dfunction(t,e){for(var n=3De.paths||[],i=3D0;i<n.l=
ength;i++)n[i].buildPath(t,n[i].shape,!0)},yh.prototype.afterBrush=3Dfuncti=
on(){for(var t=3Dthis.shape.paths||[],e=3D0;e<t.length;e++)t[e].pathUpdated=
()},yh.prototype.getBoundingRect=3Dfunction(){return this._updatePathDirty.=
call(this),_s.prototype.getBoundingRect.call(this)};var fh,gh=3Dyh;function=
 yh(){var t=3Dnull!=3D=3Dfh&&fh.apply(this,arguments)||this;return t.type=
=3D"compound",t}vh.prototype.addColorStop=3Dfunction(t,e){this.colorStops.p=
ush({offset:t,color:e})};var mh=3Dvh;function vh(t){this.colorStops=3Dt||[]=
}u(wh,_h=3Dmh);var _h,xh=3Dwh;function wh(t,e,n,i,o,r){o=3D_h.call(this,o)|=
|this;return o.x=3Dnull=3D=3Dt?0:t,o.y=3Dnull=3D=3De?0:e,o.x2=3Dnull=3D=3Dn=
?1:n,o.y2=3Dnull=3D=3Di?0:i,o.type=3D"linear",o.global=3Dr||!1,o}u(Sh,bh=3D=
mh);var bh,mh=3DSh;function Sh(t,e,n,i,o){i=3Dbh.call(this,i)||this;return =
i.x=3Dnull=3D=3Dt?.5:t,i.y=3Dnull=3D=3De?.5:e,i.r=3Dnull=3D=3Dn?.5:n,i.type=
=3D"radial",i.global=3Do||!1,i}var Mh=3D[0,0],Th=3D[0,0],Ih=3Dnew z,Ch=3Dne=
w z,Dh=3D(kh.prototype.fromBoundingRect=3Dfunction(t,e){var n=3Dthis._corne=
rs,i=3Dthis._axes,o=3Dt.x,r=3Dt.y,a=3Do+t.width,t=3Dr+t.height;if(n[0].set(=
o,r),n[1].set(a,r),n[2].set(a,t),n[3].set(o,t),e)for(var s=3D0;s<4;s++)n[s]=
.transform(e);for(z.sub(i[0],n[1],n[0]),z.sub(i[1],n[3],n[0]),i[0].normaliz=
e(),i[1].normalize(),s=3D0;s<2;s++)this._origin[s]=3Di[s].dot(n[0])},kh.pro=
totype.intersect=3Dfunction(t,e){var n=3D!0,i=3D!e;return Ih.set(1/0,1/0),C=
h.set(0,0),!this._intersectCheckOneSide(this,t,Ih,Ch,i,1)&&(n=3D!1,i)||!thi=
s._intersectCheckOneSide(t,this,Ih,Ch,i,-1)&&(n=3D!1,i)||i||z.copy(e,n?Ih:C=
h),n},kh.prototype._intersectCheckOneSide=3Dfunction(t,e,n,i,o,r){for(var a=
=3D!0,s=3D0;s<2;s++){var l=3Dthis._axes[s];if(this._getProjMinMaxOnAxis(s,t=
._corners,Mh),this._getProjMinMaxOnAxis(s,e._corners,Th),Mh[1]<Th[0]||Th[1]=
<Mh[0]){if(a=3D!1,o)return a;var u=3DMath.abs(Th[0]-Mh[1]),h=3DMath.abs(Mh[=
0]-Th[1]);Math.min(u,h)>i.len()&&(u<h?z.scale(i,l,-u*r):z.scale(i,l,h*r))}e=
lse n&&(u=3DMath.abs(Th[0]-Mh[1]),h=3DMath.abs(Mh[0]-Th[1]),Math.min(u,h)<n=
.len())&&(u<h?z.scale(n,l,u*r):z.scale(n,l,-h*r))}return a},kh.prototype._g=
etProjMinMaxOnAxis=3Dfunction(t,e,n){for(var i=3Dthis._axes[t],o=3Dthis._or=
igin,r=3De[0].dot(i)+o[t],a=3Dr,s=3Dr,l=3D1;l<e.length;l++)var u=3De[l].dot=
(i)+o[t],a=3DMath.min(u,a),s=3DMath.max(u,s);n[0]=3Da,n[1]=3Ds},kh);functio=
n kh(t,e){this._corners=3D[],this._axes=3D[],this._origin=3D[0,0];for(var n=
=3D0;n<4;n++)this._corners[n]=3Dnew z;for(n=3D0;n<2;n++)this._axes[n]=3Dnew=
 z;t&&this.fromBoundingRect(t,e)}var Ah,Lh=3D[],e=3D(u(Ph,Ah=3De),Ph.protot=
ype.traverse=3Dfunction(t,e){t.call(e,this)},Ph.prototype.useStyle=3Dfuncti=
on(){this.style=3D{}},Ph.prototype.getCursor=3Dfunction(){return this._curs=
or},Ph.prototype.innerAfterBrush=3Dfunction(){this._cursor=3Dthis._displaya=
bles.length},Ph.prototype.clearDisplaybles=3Dfunction(){this._displayables=
=3D[],this._temporaryDisplayables=3D[],this._cursor=3D0,this.markRedraw(),t=
his.notClear=3D!1},Ph.prototype.clearTemporalDisplayables=3Dfunction(){this=
._temporaryDisplayables=3D[]},Ph.prototype.addDisplayable=3Dfunction(t,e){(=
e?this._temporaryDisplayables:this._displayables).push(t),this.markRedraw()=
},Ph.prototype.addDisplayables=3Dfunction(t,e){e=3De||!1;for(var n=3D0;n<t.=
length;n++)this.addDisplayable(t[n],e)},Ph.prototype.getDisplayables=3Dfunc=
tion(){return this._displayables},Ph.prototype.getTemporalDisplayables=3Dfu=
nction(){return this._temporaryDisplayables},Ph.prototype.eachPendingDispla=
yable=3Dfunction(t){for(var e=3Dthis._cursor;e<this._displayables.length;e+=
+)t&&t(this._displayables[e]);for(e=3D0;e<this._temporaryDisplayables.lengt=
h;e++)t&&t(this._temporaryDisplayables[e])},Ph.prototype.update=3Dfunction(=
){this.updateTransform();for(var t,e=3Dthis._cursor;e<this._displayables.le=
ngth;e++)(t=3Dthis._displayables[e]).parent=3Dthis,t.update(),t.parent=3Dnu=
ll;for(e=3D0;e<this._temporaryDisplayables.length;e++)(t=3Dthis._temporaryD=
isplayables[e]).parent=3Dthis,t.update(),t.parent=3Dnull},Ph.prototype.getB=
oundingRect=3Dfunction(){if(!this._rect){for(var t=3Dnew G(1/0,1/0,-1/0,-1/=
0),e=3D0;e<this._displayables.length;e++){var n=3Dthis._displayables[e],i=
=3Dn.getBoundingRect().clone();n.needLocalTransform()&&i.applyTransform(n.g=
etLocalTransform(Lh)),t.union(i)}this._rect=3Dt}return this._rect},Ph.proto=
type.contain=3Dfunction(t,e){var n=3Dthis.transformCoordToLocal(t,e);if(thi=
s.getBoundingRect().contain(n[0],n[1]))for(var i=3D0;i<this._displayables.l=
ength;i++)if(this._displayables[i].contain(t,e))return!0;return!1},Ph);func=
tion Ph(){var t=3Dnull!=3D=3DAh&&Ah.apply(this,arguments)||this;return t.no=
tClear=3D!0,t.incremental=3D!0,t._displayables=3D[],t._temporaryDisplayable=
s=3D[],t._cursor=3D0,t}var Oh=3DRr();function Rh(t,e,n,i,o,r,a){var s,l,u,h=
,c,p,d=3D!1,f=3D(D(o)?(a=3Dr,r=3Do,o=3Dnull):O(o)&&(r=3Do.cb,a=3Do.during,d=
=3Do.isFrom,l=3Do.removeOpt,o=3Do.dataIndex),"leave"=3D=3D=3Dt),g=3D(f||e.s=
topAnimation("leave"),p=3Dt,s=3Do,l=3Df?l||{}:null,i=3D(g=3Di)&&i.getAnimat=
ionDelayParams?i.getAnimationDelayParams(e,o):null,g&&g.ecModel&&(u=3D(u=3D=
g.ecModel.getUpdatePayload())&&u.animation),p=3D"update"=3D=3D=3Dp,g&&g.isA=
nimationEnabled()?(c=3Dh=3Do=3Dvoid 0,c=3Dl?(o=3DR(l.duration,200),h=3DR(l.=
easing,"cubicOut"),0):(o=3Dg.getShallow(p?"animationDurationUpdate":"animat=
ionDuration"),h=3Dg.getShallow(p?"animationEasingUpdate":"animationEasing")=
,g.getShallow(p?"animationDelayUpdate":"animationDelay")),D(c=3Du&&(null!=
=3Du.duration&&(o=3Du.duration),null!=3Du.easing&&(h=3Du.easing),null!=3Du.=
delay)?u.delay:c)&&(c=3Dc(s,i)),{duration:(o=3DD(o)?o(s):o)||0,delay:c,easi=
ng:h}):null);g&&0<g.duration?(p=3D{duration:g.duration,delay:g.delay||0,eas=
ing:g.easing,done:r,force:!!r||!!a,setToFinal:!f,scope:t,during:a},d?e.anim=
ateFrom(n,p):e.animateTo(n,p)):(e.stopAnimation(),d||e.attr(n),a&&a(1),r&&r=
())}function Nh(t,e,n,i,o,r){Rh("update",t,e,n,i,o,r)}function Eh(t,e,n,i,o=
,r){Rh("enter",t,e,n,i,o,r)}function zh(t){if(!t.__zr)return!0;for(var e=3D=
0;e<t.animators.length;e++)if("leave"=3D=3D=3Dt.animators[e].scope)return!0=
;return!1}function Bh(t,e,n,i,o,r){zh(t)||Rh("leave",t,e,n,i,o,r)}function =
Fh(t,e,n,i){t.removeTextContent(),t.removeTextGuideLine(),Bh(t,{style:{opac=
ity:0}},e,n,i)}function Vh(t,e,n){function i(){t.parent&&t.parent.remove(t)=
}t.isGroup?t.traverse(function(t){t.isGroup||Fh(t,e,n,i)}):Fh(t,e,n,i)}func=
tion Hh(t){Oh(t).oldStyle=3Dt.style}var Wh=3DMath.max,Gh=3DMath.min,Xh=3D{}=
;function Uh(t){return _s.extend(t)}var Yh=3Dfunction(t,e){var n,i=3Dfu(t,e=
);return u(o,n=3Dcu),o;function o(t){t=3Dn.call(this,t)||this;return t.appl=
yTransform=3Di.applyTransform,t.buildPath=3Di.buildPath,t}};function Zh(t,e=
){return Yh(t,e)}function qh(t,e){Xh[t]=3De}function jh(t){if(Xh.hasOwnProp=
erty(t))return Xh[t]}function Kh(t,e,n,i){t=3Dnew cu(fu(t,e));return n&&("c=
enter"=3D=3D=3Di&&(n=3DQh(n,t.getBoundingRect())),tc(t,n)),t}function $h(t,=
e,n){var i=3Dnew Cs({style:{image:t,x:e.x,y:e.y,width:e.width,height:e.heig=
ht},onload:function(t){"center"=3D=3D=3Dn&&(t=3D{width:t.width,height:t.hei=
ght},i.setStyle(Qh(e,t)))}});return i}function Qh(t,e){var e=3De.width/e.he=
ight,n=3Dt.height*e,e=3Dn<=3Dt.width?t.height:(n=3Dt.width)/e;return{x:t.x+=
t.width/2-n/2,y:t.y+t.height/2-e/2,width:n,height:e}}function Jh(t,e){for(v=
ar n=3D[],i=3Dt.length,o=3D0;o<i;o++){var r=3Dt[o];n.push(r.getUpdatedPathP=
roxy(!0))}return(e=3Dnew _s(e)).createPathProxy(),e.buildPath=3Dfunction(t)=
{var e;du(t)&&(t.appendPath(n),e=3Dt.getContext())&&t.rebuildPath(e,1)},e}f=
unction tc(t,e){t.applyTransform&&(e=3Dt.getBoundingRect().calculateTransfo=
rm(e),t.applyTransform(e))}function ec(t,e){return As(t,t,{lineWidth:e}),t}=
var nc=3DPs;function ic(t,e){for(var n=3DPe([]);t&&t!=3D=3De;)Re(n,t.getLoc=
alTransform(),n),t=3Dt.parent;return n}function oc(t,e,n){return e&&!st(e)&=
&(e=3Dvo.getLocalTransform(e)),Jt([],t,e=3Dn?Be([],e):e)}function rc(t,e,n)=
{var i=3D0=3D=3D=3De[4]||0=3D=3D=3De[5]||0=3D=3D=3De[0]?1:Math.abs(2*e[4]/e=
[0]),o=3D0=3D=3D=3De[4]||0=3D=3D=3De[5]||0=3D=3D=3De[2]?1:Math.abs(2*e[4]/e=
[2]),i=3Doc(["left"=3D=3D=3Dt?-i:"right"=3D=3D=3Dt?i:0,"top"=3D=3D=3Dt?-o:"=
bottom"=3D=3D=3Dt?o:0],e,n);return Math.abs(i[0])>Math.abs(i[1])?0<i[0]?"ri=
ght":"left":0<i[1]?"bottom":"top"}function ac(t){return!t.isGroup}function =
sc(t,e,i){var n,o;function r(t){var e=3D{x:t.x,y:t.y,rotation:t.rotation};r=
eturn null!=3Dt.shape&&(e.shape=3DP({},t.shape)),e}t&&e&&(n=3D{},t.traverse=
(function(t){ac(t)&&t.anid&&(n[t.anid]=3Dt)}),o=3Dn,e.traverse(function(t){=
var e,n;ac(t)&&t.anid&&(e=3Do[t.anid])&&(n=3Dr(t),t.attr(r(e)),Nh(t,n,i,k(t=
).dataIndex))}))}function lc(t,n){return F(t,function(t){var e=3Dt[0],e=3DW=
h(e,n.x),t=3D(e=3DGh(e,n.x+n.width),t[1]),t=3DWh(t,n.y);return[e,Gh(t,n.y+n=
.height)]})}function uc(t,e){var n=3DWh(t.x,e.x),i=3DGh(t.x+t.width,e.x+e.w=
idth),o=3DWh(t.y,e.y),t=3DGh(t.y+t.height,e.y+e.height);if(n<=3Di&&o<=3Dt)r=
eturn{x:n,y:o,width:i-n,height:t-o}}function hc(t,e,n){var e=3DP({rectHover=
:!0},e),i=3De.style=3D{strokeNoScale:!0};if(n=3Dn||{x:-1,y:-1,width:2,heigh=
t:2},t)return 0=3D=3D=3Dt.indexOf("image://")?(i.image=3Dt.slice(8),B(i,n),=
new Cs(e)):Kh(t.replace("path://",""),e,n,"center")}function cc(t,e,n,i,o,r=
,a,s){var l,n=3Dn-t,i=3Di-e,a=3Da-o,s=3Ds-r,u=3Da*i-n*s;return!((l=3Du)<=3D=
1e-6&&-1e-6<=3Dl||(o=3D((l=3Dt-o)*i-n*(t=3De-r))/u)<0||1<o||(i=3D(l*s-a*t)/=
u)<0||1<i)}function pc(t){var e=3Dt.itemTooltipOption,n=3Dt.componentModel,=
i=3Dt.itemName,e=3DH(e)?{formatter:e}:e,o=3Dn.mainType,n=3Dn.componentIndex=
,r=3D{componentType:o,name:i,$vars:["name"]},a=3D(r[o+"Index"]=3Dn,t.format=
terParamsExtra),t=3D(a&&E(ht(a),function(t){Et(r,t)||(r[t]=3Da[t],r.$vars.p=
ush(t))}),k(t.el));t.componentMainType=3Do,t.componentIndex=3Dn,t.tooltipCo=
nfig=3D{name:i,option:B({content:i,formatterParams:r},e)}}function dc(t,e){=
var n;(n=3Dt.isGroup?e(t):n)||t.traverse(e)}function fc(t,e){if(t)if(V(t))f=
or(var n=3D0;n<t.length;n++)dc(t[n],e);else dc(t,e)}qh("circle",mu),qh("ell=
ipse",wu),qh("sector",Bu),qh("ring",Wu),qh("polygon",Zu),qh("polyline",$u),=
qh("rect",Es),qh("line",nh),qh("bezierCurve",lh),qh("arc",ph);var gc=3DObje=
ct.freeze({__proto__:null,Arc:ph,BezierCurve:lh,BoundingRect:G,Circle:mu,Co=
mpoundPath:gh,Ellipse:wu,Group:Wo,Image:Cs,IncrementalDisplayable:e,Line:nh=
,LinearGradient:xh,OrientedBoundingRect:Dh,Path:_s,Point:z,Polygon:Zu,Polyl=
ine:$u,RadialGradient:mh,Rect:Es,Ring:Wu,Sector:Bu,Text:Hs,applyTransform:o=
c,clipPointsByRect:lc,clipRectByRect:uc,createIcon:hc,extendPath:Zh,extendS=
hape:Uh,getShapeClass:jh,getTransform:ic,groupTransition:sc,initProps:Eh,is=
ElementRemoved:zh,lineLineIntersect:cc,linePolygonIntersect:function(t,e,n,=
i,o){for(var r=3D0,a=3Do[o.length-1];r<o.length;r++){var s=3Do[r];if(cc(t,e=
,n,i,s[0],s[1],a[0],a[1]))return!0;a=3Ds}},makeImage:$h,makePath:Kh,mergePa=
th:Jh,registerShape:qh,removeElement:Bh,removeElementWithFadeOut:Vh,resizeP=
ath:tc,setTooltipConfig:pc,subPixelOptimize:nc,subPixelOptimizeLine:ec,subP=
ixelOptimizeRect:function(t){return Ls(t.shape,t.shape,t.style),t},transfor=
mDirection:rc,traverseElements:fc,updateProps:Nh}),yc=3D{};function mc(t,e)=
{for(var n=3D0;n<al.length;n++){var i=3Dal[n],o=3De[i],i=3Dt.ensureState(i)=
;i.style=3Di.style||{},i.style.text=3Do}var r=3Dt.currentStates.slice();t.c=
learStates(!0),t.setStyle({text:e.normal}),t.useStates(r,!0)}function vc(t,=
e,n){for(var i,o=3Dt.labelFetcher,r=3Dt.labelDataIndex,a=3Dt.labelDimIndex,=
s=3De.normal,l=3D{normal:i=3Dnull=3D=3D(i=3Do?o.getFormattedLabel(r,"normal=
",null,a,s&&s.get("formatter"),null!=3Dn?{interpolatedValue:n}:null):i)?D(t=
.defaultText)?t.defaultText(r,t,n):t.defaultText:i},u=3D0;u<al.length;u++){=
var h=3Dal[u],c=3De[h];l[h]=3DR(o?o.getFormattedLabel(r,h,null,a,c&&c.get("=
formatter")):null,i)}return l}function _c(t,e,n,i){n=3Dn||yc;for(var o=3Dt =
instanceof Hs,r=3D!1,a=3D0;a<sl.length;a++)if((p=3De[sl[a]])&&p.getShallow(=
"show")){r=3D!0;break}var s=3Do?t:t.getTextContent();if(r){o||(s||(s=3Dnew =
Hs,t.setTextContent(s)),t.stateProxy&&(s.stateProxy=3Dt.stateProxy));var l=
=3Dvc(n,e),u=3De.normal,h=3D!!u.getShallow("show"),c=3Dwc(u,i&&i.normal,n,!=
1,!o);for(c.text=3Dl.normal,o||t.setTextConfig(bc(u,n,!1)),a=3D0;a<al.lengt=
h;a++){var p,d,f,g=3Dal[a];(p=3De[g])&&(d=3Ds.ensureState(g),(f=3D!!R(p.get=
Shallow("show"),h))!=3Dh&&(d.ignore=3D!f),d.style=3Dwc(p,i&&i[g],n,!0,!o),d=
.style.text=3Dl[g],o||(t.ensureState(g).textConfig=3Dbc(p,n,!0)))}s.silent=
=3D!!u.getShallow("silent"),null!=3Ds.style.x&&(c.x=3Ds.style.x),null!=3Ds.=
style.y&&(c.y=3Ds.style.y),s.ignore=3D!h,s.useStyle(c),s.dirty(),n.enableTe=
xtSetter&&(Cc(s).setLabelText=3Dfunction(t){t=3Dvc(n,e,t);mc(s,t)})}else s&=
&(s.ignore=3D!0);t.dirty()}function xc(t,e){for(var n=3D{normal:t.getModel(=
e=3De||"label")},i=3D0;i<al.length;i++){var o=3Dal[i];n[o]=3Dt.getModel([o,=
e])}return n}function wc(t,e,n,i,o){var r,a=3D{},s=3Da,l=3Dt,u=3Dn,h=3Di,c=
=3Do;u=3Du||yc;var p,t=3Dl.ecModel,d=3Dt&&t.option.textStyle,f=3Dfunction(t=
){for(var e;t&&t!=3D=3Dt.ecModel;){var n=3D(t.option||yc).rich;if(n){e=3De|=
|{};for(var i=3Dht(n),o=3D0;o<i.length;o++)e[i[o]]=3D1}t=3Dt.parentModel}re=
turn e}(l);if(f)for(var g in p=3D{},f)f.hasOwnProperty(g)&&(r=3Dl.getModel(=
["rich",g]),Ic(p[g]=3D{},r,d,u,h,c,!1,!0));return p&&(s.rich=3Dp),(t=3Dl.ge=
t("overflow"))&&(s.overflow=3Dt),null!=3D(t=3Dl.get("minMargin"))&&(s.margi=
n=3Dt),Ic(s,l,d,u,h,c,!0,!1),e&&P(a,e),a}function bc(t,e,n){e=3De||{};var i=
=3D{},o=3Dt.getShallow("rotate"),r=3DR(t.getShallow("distance"),n?null:5),a=
=3Dt.getShallow("offset");return null!=3D(n=3D"outside"=3D=3D=3D(n=3Dt.getS=
hallow("position")||(n?null:"inside"))?e.defaultOutsidePosition||"top":n)&&=
(i.position=3Dn),null!=3Da&&(i.offset=3Da),null!=3Do&&(o*=3DMath.PI/180,i.r=
otation=3Do),null!=3Dr&&(i.distance=3Dr),i.outsideFill=3D"inherit"=3D=3D=3D=
t.get("color")?e.inheritColor||null:"auto",i}var Sc=3D["fontStyle","fontWei=
ght","fontSize","fontFamily","textShadowColor","textShadowBlur","textShadow=
OffsetX","textShadowOffsetY"],Mc=3D["align","lineHeight","width","height","=
tag","verticalAlign","ellipsis"],Tc=3D["padding","borderWidth","borderRadiu=
s","borderDashOffset","backgroundColor","borderColor","shadowColor","shadow=
Blur","shadowOffsetX","shadowOffsetY"];function Ic(t,e,n,i,o,r,a,s){n=3D!o&=
&n||yc;var l=3Di&&i.inheritColor,u=3De.getShallow("color"),h=3De.getShallow=
("textBorderColor"),c=3DR(e.getShallow("opacity"),n.opacity),u=3D("inherit"=
!=3D=3Du&&"auto"!=3D=3Du||(u=3Dl||null),"inherit"!=3D=3Dh&&"auto"!=3D=3Dh||=
(h=3Dl||null),r||(u=3Du||n.color,h=3Dh||n.textBorderColor),null!=3Du&&(t.fi=
ll=3Du),null!=3Dh&&(t.stroke=3Dh),R(e.getShallow("textBorderWidth"),n.textB=
orderWidth)),h=3D(null!=3Du&&(t.lineWidth=3Du),R(e.getShallow("textBorderTy=
pe"),n.textBorderType)),u=3D(null!=3Dh&&(t.lineDash=3Dh),R(e.getShallow("te=
xtBorderDashOffset"),n.textBorderDashOffset));null!=3Du&&(t.lineDashOffset=
=3Du),null!=3D(c=3Do||null!=3Dc||s?c:i&&i.defaultOpacity)&&(t.opacity=3Dc),=
o||r||null=3D=3Dt.fill&&i.inheritColor&&(t.fill=3Di.inheritColor);for(var p=
=3D0;p<Sc.length;p++){var d=3DSc[p];null!=3D(f=3DR(e.getShallow(d),n[d]))&&=
(t[d]=3Df)}for(p=3D0;p<Mc.length;p++)d=3DMc[p],null!=3D(f=3De.getShallow(d)=
)&&(t[d]=3Df);if(null=3D=3Dt.verticalAlign&&null!=3D(h=3De.getShallow("base=
line"))&&(t.verticalAlign=3Dh),!a||!i.disableBox){for(p=3D0;p<Tc.length;p++=
){var f,d=3DTc[p];null!=3D(f=3De.getShallow(d))&&(t[d]=3Df)}u=3De.getShallo=
w("borderType");null!=3Du&&(t.borderDash=3Du),"auto"!=3D=3Dt.backgroundColo=
r&&"inherit"!=3D=3Dt.backgroundColor||!l||(t.backgroundColor=3Dl),"auto"!=
=3D=3Dt.borderColor&&"inherit"!=3D=3Dt.borderColor||!l||(t.borderColor=3Dl)=
}}var Cc=3DRr();var Dc=3D["textStyle","color"],kc=3D["fontStyle","fontWeigh=
t","fontSize","fontFamily","padding","lineHeight","rich","width","height","=
overflow"],Ac=3Dnew Hs,nc=3D(Lc.prototype.getTextColor=3Dfunction(t){var e=
=3Dthis.ecModel;return this.getShallow("color")||(!t&&e?e.get(Dc):null)},Lc=
.prototype.getFont=3Dfunction(){return t=3D{fontStyle:this.getShallow("font=
Style"),fontWeight:this.getShallow("fontWeight"),fontSize:this.getShallow("=
fontSize"),fontFamily:this.getShallow("fontFamily")},e=3D(e=3Dthis.ecModel)=
&&e.getModel("textStyle"),Mt([t.fontStyle||e&&e.getShallow("fontStyle")||""=
,t.fontWeight||e&&e.getShallow("fontWeight")||"",(t.fontSize||e&&e.getShall=
ow("fontSize")||12)+"px",t.fontFamily||e&&e.getShallow("fontFamily")||"sans=
-serif"].join(" "));var t,e},Lc.prototype.getTextRect=3Dfunction(t){for(var=
 e=3D{text:t,verticalAlign:this.getShallow("verticalAlign")||this.getShallo=
w("baseline")},n=3D0;n<kc.length;n++)e[kc[n]]=3Dthis.getShallow(kc[n]);retu=
rn Ac.useStyle(e),Ac.update(),Ac.getBoundingRect()},Lc);function Lc(){}var =
Pc=3D[["lineWidth","width"],["stroke","color"],["opacity"],["shadowBlur"],[=
"shadowOffsetX"],["shadowOffsetY"],["shadowColor"],["lineDash","type"],["li=
neDashOffset","dashOffset"],["lineCap","cap"],["lineJoin","join"],["miterLi=
mit"]],Oc=3DJr(Pc),Rc=3D(Nc.prototype.getLineStyle=3Dfunction(t){return Oc(=
this,t)},Nc);function Nc(){}var Ec=3D[["fill","color"],["stroke","borderCol=
or"],["lineWidth","borderWidth"],["opacity"],["shadowBlur"],["shadowOffsetX=
"],["shadowOffsetY"],["shadowColor"],["lineDash","borderType"],["lineDashOf=
fset","borderDashOffset"],["lineCap","borderCap"],["lineJoin","borderJoin"]=
,["miterLimit","borderMiterLimit"]],zc=3DJr(Ec),Bc=3D(Fc.prototype.getItemS=
tyle=3Dfunction(t,e){return zc(this,t,e)},Fc);function Fc(){}Wc.prototype.i=
nit=3Dfunction(t,e,n){for(var i=3D3;i<arguments.length;i++)i-3,0},Wc.protot=
ype.mergeOption=3Dfunction(t,e){d(this.option,t,!0)},Wc.prototype.get=3Dfun=
ction(t,e){return null=3D=3Dt?this.option:this._doGet(this.parsePath(t),!e&=
&this.parentModel)},Wc.prototype.getShallow=3Dfunction(t,e){var n=3Dthis.op=
tion,n=3Dnull=3D=3Dn?n:n[t];return null!=3Dn||e||(e=3Dthis.parentModel)&&(n=
=3De.getShallow(t)),n},Wc.prototype.getModel=3Dfunction(t,e){var n=3Dnull!=
=3Dt,t=3Dn?this.parsePath(t):null;return new Wc(n?this._doGet(t):this.optio=
n,e=3De||this.parentModel&&this.parentModel.getModel(this.resolveParentPath=
(t)),this.ecModel)},Wc.prototype.isEmpty=3Dfunction(){return null=3D=3Dthis=
.option},Wc.prototype.restoreData=3Dfunction(){},Wc.prototype.clone=3Dfunct=
ion(){return new this.constructor(y(this.option))},Wc.prototype.parsePath=
=3Dfunction(t){return"string"=3D=3Dtypeof t?t.split("."):t},Wc.prototype.re=
solveParentPath=3Dfunction(t){return t},Wc.prototype.isAnimationEnabled=3Df=
unction(){if(!b.node&&this.option)return null!=3Dthis.option.animation?!!th=
is.option.animation:this.parentModel?this.parentModel.isAnimationEnabled():=
void 0},Wc.prototype._doGet=3Dfunction(t,e){var n=3Dthis.option;if(t){for(v=
ar i=3D0;i<t.length&&(!t[i]||null!=3D(n=3Dn&&"object"=3D=3Dtypeof n?n[t[i]]=
:null));i++);null=3D=3Dn&&e&&(n=3De._doGet(this.resolveParentPath(t),e.pare=
ntModel))}return n};var Vc,Hc=3DWc;function Wc(t,e,n){this.parentModel=3De,=
this.ecModel=3Dn,this.option=3Dt}Zr(Hc),op=3DHc,Vc=3D["__\0is_clz",jr++].jo=
in("_"),op.prototype[Vc]=3D!0,op.isInstance=3Dfunction(t){return!(!t||!t[Vc=
])},at(Hc,Rc),at(Hc,Bc),at(Hc,ea),at(Hc,nc);var Gc=3DMath.round(10*Math.ran=
dom());function Xc(t){return[t||"",Gc++].join("_")}function Uc(t,e){return =
d(d({},t,!0),e,!0)}var Yc=3D"ZH",Zc=3D"EN",qc=3DZc,jc=3D{},Kc=3D{},$c=3Db.d=
omSupported&&-1<(document.documentElement.lang||navigator.language||navigat=
or.browserLanguage||qc).toUpperCase().indexOf(Yc)?Yc:qc;function Qc(t,e){t=
=3Dt.toUpperCase(),Kc[t]=3Dnew Hc(e),jc[t]=3De}Qc(Zc,{time:{month:["January=
","February","March","April","May","June","July","August","September","Octo=
ber","November","December"],monthAbbr:["Jan","Feb","Mar","Apr","May","Jun",=
"Jul","Aug","Sep","Oct","Nov","Dec"],dayOfWeek:["Sunday","Monday","Tuesday"=
,"Wednesday","Thursday","Friday","Saturday"],dayOfWeekAbbr:["Sun","Mon","Tu=
e","Wed","Thu","Fri","Sat"]},legend:{selector:{all:"All",inverse:"Inv"}},to=
olbox:{brush:{title:{rect:"Box Select",polygon:"Lasso Select",lineX:"Horizo=
ntally Select",lineY:"Vertically Select",keep:"Keep Selections",clear:"Clea=
r Selections"}},dataView:{title:"Data View",lang:["Data View","Close","Refr=
esh"]},dataZoom:{title:{zoom:"Zoom",back:"Zoom Reset"}},magicType:{title:{l=
ine:"Switch to Line Chart",bar:"Switch to Bar Chart",stack:"Stack",tiled:"T=
ile"}},restore:{title:"Restore"},saveAsImage:{title:"Save as Image",lang:["=
Right Click to Save Image"]}},series:{typeNames:{pie:"Pie chart",bar:"Bar c=
hart",line:"Line chart",scatter:"Scatter plot",effectScatter:"Ripple scatte=
r plot",radar:"Radar chart",tree:"Tree",treemap:"Treemap",boxplot:"Boxplot"=
,candlestick:"Candlestick",k:"K line chart",heatmap:"Heat map",map:"Map",pa=
rallel:"Parallel coordinate map",lines:"Line graph",graph:"Relationship gra=
ph",sankey:"Sankey diagram",funnel:"Funnel chart",gauge:"Gauge",pictorialBa=
r:"Pictorial bar",themeRiver:"Theme River Map",sunburst:"Sunburst",custom:"=
Custom chart",chart:"Chart"}},aria:{general:{withTitle:'This is a chart abo=
ut "{title}"',withoutTitle:"This is a chart"},series:{single:{prefix:"",wit=
hName:" with type {seriesType} named {seriesName}.",withoutName:" with type=
 {seriesType}."},multiple:{prefix:". It consists of {seriesCount} series co=
unt.",withName:" The {seriesId} series is a {seriesType} representing {seri=
esName}.",withoutName:" The {seriesId} series is a {seriesType}.",separator=
:{middle:"",end:""}}},data:{allData:"The data is as follows: ",partialData:=
"The first {displayCnt} items are: ",withName:"the data for {name} is {valu=
e}",withoutName:"{value}",separator:{middle:", ",end:". "}}}}),Qc(Yc,{time:=
{month:["=E4=B8=80=E6=9C=88","=E4=BA=8C=E6=9C=88","=E4=B8=89=E6=9C=88","=E5=
=9B=9B=E6=9C=88","=E4=BA=94=E6=9C=88","=E5=85=AD=E6=9C=88","=E4=B8=83=E6=9C=
=88","=E5=85=AB=E6=9C=88","=E4=B9=9D=E6=9C=88","=E5=8D=81=E6=9C=88","=E5=8D=
=81=E4=B8=80=E6=9C=88","=E5=8D=81=E4=BA=8C=E6=9C=88"],monthAbbr:["1=E6=9C=
=88","2=E6=9C=88","3=E6=9C=88","4=E6=9C=88","5=E6=9C=88","6=E6=9C=88","7=E6=
=9C=88","8=E6=9C=88","9=E6=9C=88","10=E6=9C=88","11=E6=9C=88","12=E6=9C=88"=
],dayOfWeek:["=E6=98=9F=E6=9C=9F=E6=97=A5","=E6=98=9F=E6=9C=9F=E4=B8=80","=
=E6=98=9F=E6=9C=9F=E4=BA=8C","=E6=98=9F=E6=9C=9F=E4=B8=89","=E6=98=9F=E6=9C=
=9F=E5=9B=9B","=E6=98=9F=E6=9C=9F=E4=BA=94","=E6=98=9F=E6=9C=9F=E5=85=AD"],=
dayOfWeekAbbr:["=E6=97=A5","=E4=B8=80","=E4=BA=8C","=E4=B8=89","=E5=9B=9B",=
"=E4=BA=94","=E5=85=AD"]},legend:{selector:{all:"=E5=85=A8=E9=80=89",invers=
e:"=E5=8F=8D=E9=80=89"}},toolbox:{brush:{title:{rect:"=E7=9F=A9=E5=BD=A2=E9=
=80=89=E6=8B=A9",polygon:"=E5=9C=88=E9=80=89",lineX:"=E6=A8=AA=E5=90=91=E9=
=80=89=E6=8B=A9",lineY:"=E7=BA=B5=E5=90=91=E9=80=89=E6=8B=A9",keep:"=E4=BF=
=9D=E6=8C=81=E9=80=89=E6=8B=A9",clear:"=E6=B8=85=E9=99=A4=E9=80=89=E6=8B=A9=
"}},dataView:{title:"=E6=95=B0=E6=8D=AE=E8=A7=86=E5=9B=BE",lang:["=E6=95=B0=
=E6=8D=AE=E8=A7=86=E5=9B=BE","=E5=85=B3=E9=97=AD","=E5=88=B7=E6=96=B0"]},da=
taZoom:{title:{zoom:"=E5=8C=BA=E5=9F=9F=E7=BC=A9=E6=94=BE",back:"=E5=8C=BA=
=E5=9F=9F=E7=BC=A9=E6=94=BE=E8=BF=98=E5=8E=9F"}},magicType:{title:{line:"=
=E5=88=87=E6=8D=A2=E4=B8=BA=E6=8A=98=E7=BA=BF=E5=9B=BE",bar:"=E5=88=87=E6=
=8D=A2=E4=B8=BA=E6=9F=B1=E7=8A=B6=E5=9B=BE",stack:"=E5=88=87=E6=8D=A2=E4=B8=
=BA=E5=A0=86=E5=8F=A0",tiled:"=E5=88=87=E6=8D=A2=E4=B8=BA=E5=B9=B3=E9=93=BA=
"}},restore:{title:"=E8=BF=98=E5=8E=9F"},saveAsImage:{title:"=E4=BF=9D=E5=
=AD=98=E4=B8=BA=E5=9B=BE=E7=89=87",lang:["=E5=8F=B3=E9=94=AE=E5=8F=A6=E5=AD=
=98=E4=B8=BA=E5=9B=BE=E7=89=87"]}},series:{typeNames:{pie:"=E9=A5=BC=E5=9B=
=BE",bar:"=E6=9F=B1=E7=8A=B6=E5=9B=BE",line:"=E6=8A=98=E7=BA=BF=E5=9B=BE",s=
catter:"=E6=95=A3=E7=82=B9=E5=9B=BE",effectScatter:"=E6=B6=9F=E6=BC=AA=E6=
=95=A3=E7=82=B9=E5=9B=BE",radar:"=E9=9B=B7=E8=BE=BE=E5=9B=BE",tree:"=E6=A0=
=91=E5=9B=BE",treemap:"=E7=9F=A9=E5=BD=A2=E6=A0=91=E5=9B=BE",boxplot:"=E7=
=AE=B1=E5=9E=8B=E5=9B=BE",candlestick:"K=E7=BA=BF=E5=9B=BE",k:"K=E7=BA=BF=
=E5=9B=BE",heatmap:"=E7=83=AD=E5=8A=9B=E5=9B=BE",map:"=E5=9C=B0=E5=9B=BE",p=
arallel:"=E5=B9=B3=E8=A1=8C=E5=9D=90=E6=A0=87=E5=9B=BE",lines:"=E7=BA=BF=E5=
=9B=BE",graph:"=E5=85=B3=E7=B3=BB=E5=9B=BE",sankey:"=E6=A1=91=E5=9F=BA=E5=
=9B=BE",funnel:"=E6=BC=8F=E6=96=97=E5=9B=BE",gauge:"=E4=BB=AA=E8=A1=A8=E7=
=9B=98=E5=9B=BE",pictorialBar:"=E8=B1=A1=E5=BD=A2=E6=9F=B1=E5=9B=BE",themeR=
iver:"=E4=B8=BB=E9=A2=98=E6=B2=B3=E6=B5=81=E5=9B=BE",sunburst:"=E6=97=AD=E6=
=97=A5=E5=9B=BE",custom:"=E8=87=AA=E5=AE=9A=E4=B9=89=E5=9B=BE=E8=A1=A8",cha=
rt:"=E5=9B=BE=E8=A1=A8"}},aria:{general:{withTitle:"=E8=BF=99=E6=98=AF=E4=
=B8=80=E4=B8=AA=E5=85=B3=E4=BA=8E=E2=80=9C{title}=E2=80=9D=E7=9A=84=E5=9B=
=BE=E8=A1=A8=E3=80=82",withoutTitle:"=E8=BF=99=E6=98=AF=E4=B8=80=E4=B8=AA=
=E5=9B=BE=E8=A1=A8=EF=BC=8C"},series:{single:{prefix:"",withName:"=E5=9B=BE=
=E8=A1=A8=E7=B1=BB=E5=9E=8B=E6=98=AF{seriesType}=EF=BC=8C=E8=A1=A8=E7=A4=BA=
{seriesName}=E3=80=82",withoutName:"=E5=9B=BE=E8=A1=A8=E7=B1=BB=E5=9E=8B=E6=
=98=AF{seriesType}=E3=80=82"},multiple:{prefix:"=E5=AE=83=E7=94=B1{seriesCo=
unt}=E4=B8=AA=E5=9B=BE=E8=A1=A8=E7=B3=BB=E5=88=97=E7=BB=84=E6=88=90=E3=80=
=82",withName:"=E7=AC=AC{seriesId}=E4=B8=AA=E7=B3=BB=E5=88=97=E6=98=AF=E4=
=B8=80=E4=B8=AA=E8=A1=A8=E7=A4=BA{seriesName}=E7=9A=84{seriesType}=EF=BC=8C=
",withoutName:"=E7=AC=AC{seriesId}=E4=B8=AA=E7=B3=BB=E5=88=97=E6=98=AF=E4=
=B8=80=E4=B8=AA{seriesType}=EF=BC=8C",separator:{middle:"=EF=BC=9B",end:"=
=E3=80=82"}}},data:{allData:"=E5=85=B6=E6=95=B0=E6=8D=AE=E6=98=AF=E2=80=94=
=E2=80=94",partialData:"=E5=85=B6=E4=B8=AD=EF=BC=8C=E5=89=8D{displayCnt}=E9=
=A1=B9=E6=98=AF=E2=80=94=E2=80=94",withName:"{name}=E7=9A=84=E6=95=B0=E6=8D=
=AE=E6=98=AF{value}",withoutName:"{value}",separator:{middle:"=EF=BC=8C",en=
d:""}}}});var Jc=3D1e3,tp=3D60*Jc,ep=3D60*tp,np=3D24*ep,jr=3D365*np,ip=3D{y=
ear:"{yyyy}",month:"{MMM}",day:"{d}",hour:"{HH}:{mm}",minute:"{HH}:{mm}",se=
cond:"{HH}:{mm}:{ss}",millisecond:"{HH}:{mm}:{ss} {SSS}",none:"{yyyy}-{MM}-=
{dd} {HH}:{mm}:{ss} {SSS}"},op=3D"{yyyy}-{MM}-{dd}",rp=3D{year:"{yyyy}",mon=
th:"{yyyy}-{MM}",day:op,hour:op+" "+ip.hour,minute:op+" "+ip.minute,second:=
op+" "+ip.second,millisecond:ip.none},ap=3D["year","month","day","hour","mi=
nute","second","millisecond"],sp=3D["year","half-year","quarter","month","w=
eek","half-week","day","half-day","quarter-day","hour","minute","second","m=
illisecond"];function lp(t,e){return"0000".substr(0,e-(t+=3D"").length)+t}f=
unction up(t){switch(t){case"half-year":case"quarter":return"month";case"we=
ek":case"half-week":return"day";case"half-day":case"quarter-day":return"hou=
r";default:return t}}function hp(t,e,n,i){var t=3Dcr(t),o=3Dt[dp(n)](),r=3D=
t[fp(n)]()+1,a=3DMath.floor((r-1)/3)+1,s=3Dt[gp(n)](),l=3Dt["get"+(n?"UTC":=
"")+"Day"](),u=3Dt[yp(n)](),h=3D(u-1)%12+1,c=3Dt[mp(n)](),p=3Dt[vp(n)](),t=
=3Dt[_p(n)](),n=3D(i instanceof Hc?i:Kc[i||$c]||Kc[qc]).getModel("time"),i=
=3Dn.get("month"),d=3Dn.get("monthAbbr"),f=3Dn.get("dayOfWeek"),n=3Dn.get("=
dayOfWeekAbbr");return(e||"").replace(/{yyyy}/g,o+"").replace(/{yy}/g,lp(o%=
100+"",2)).replace(/{Q}/g,a+"").replace(/{MMMM}/g,i[r-1]).replace(/{MMM}/g,=
d[r-1]).replace(/{MM}/g,lp(r,2)).replace(/{M}/g,r+"").replace(/{dd}/g,lp(s,=
2)).replace(/{d}/g,s+"").replace(/{eeee}/g,f[l]).replace(/{ee}/g,n[l]).repl=
ace(/{e}/g,l+"").replace(/{HH}/g,lp(u,2)).replace(/{H}/g,u+"").replace(/{hh=
}/g,lp(h+"",2)).replace(/{h}/g,h+"").replace(/{mm}/g,lp(c,2)).replace(/{m}/=
g,c+"").replace(/{ss}/g,lp(p,2)).replace(/{s}/g,p+"").replace(/{SSS}/g,lp(t=
,3)).replace(/{S}/g,t+"")}function cp(t,e){var t=3Dcr(t),n=3Dt[fp(e)]()+1,i=
=3Dt[gp(e)](),o=3Dt[yp(e)](),r=3Dt[mp(e)](),a=3Dt[vp(e)](),t=3D0=3D=3D=3Dt[=
_p(e)](),e=3Dt&&0=3D=3D=3Da,a=3De&&0=3D=3D=3Dr,r=3Da&&0=3D=3D=3Do,o=3Dr&&1=
=3D=3D=3Di;return o&&1=3D=3D=3Dn?"year":o?"month":r?"day":a?"hour":e?"minut=
e":t?"second":"millisecond"}function pp(t,e,n){var i=3DW(t)?cr(t):t;switch(=
e=3De||cp(t,n)){case"year":return i[dp(n)]();case"half-year":return 6<=3Di[=
fp(n)]()?1:0;case"quarter":return Math.floor((i[fp(n)]()+1)/4);case"month":=
return i[fp(n)]();case"day":return i[gp(n)]();case"half-day":return i[yp(n)=
]()/24;case"hour":return i[yp(n)]();case"minute":return i[mp(n)]();case"sec=
ond":return i[vp(n)]();case"millisecond":return i[_p(n)]()}}function dp(t){=
return t?"getUTCFullYear":"getFullYear"}function fp(t){return t?"getUTCMont=
h":"getMonth"}function gp(t){return t?"getUTCDate":"getDate"}function yp(t)=
{return t?"getUTCHours":"getHours"}function mp(t){return t?"getUTCMinutes":=
"getMinutes"}function vp(t){return t?"getUTCSeconds":"getSeconds"}function =
_p(t){return t?"getUTCMilliseconds":"getMilliseconds"}function xp(t){return=
 t?"setUTCMonth":"setMonth"}function wp(t){return t?"setUTCDate":"setDate"}=
function bp(t){return t?"setUTCHours":"setHours"}function Sp(t){return t?"s=
etUTCMinutes":"setMinutes"}function Mp(t){return t?"setUTCSeconds":"setSeco=
nds"}function Tp(t){return t?"setUTCMilliseconds":"setMilliseconds"}functio=
n Ip(t){var e;return yr(t)?(e=3D(t+"").split("."))[0].replace(/(\d{1,3})(?=
=3D(?:\d{3})+(?!\d))/g,"$1,")+(1<e.length?"."+e[1]:""):H(t)?t:"-"}function =
Cp(t,e){return t=3D(t||"").toLowerCase().replace(/-(.)/g,function(t,e){retu=
rn e.toUpperCase()}),t=3De?t&&t.charAt(0).toUpperCase()+t.slice(1):t}var Dp=
=3Dbt;function kp(t,e,n){function i(t){return t&&Mt(t)?t:"-"}function o(t){=
return null!=3Dt&&!isNaN(t)&&isFinite(t)}var r=3D"time"=3D=3D=3De,a=3Dt ins=
tanceof Date;if(r||a){var r=3Dr?cr(t):t;if(!isNaN(+r))return hp(r,"{yyyy}-{=
MM}-{dd} {HH}:{mm}:{ss}",n);if(a)return"-"}return"ordinal"=3D=3D=3De?ct(t)?=
i(t):W(t)&&o(t)?t+"":"-":o(r=3Dgr(t))?Ip(r):ct(t)?i(t):"boolean"=3D=3Dtypeo=
f t?t+"":"-"}function Ap(t,e){return"{"+t+(null=3D=3De?"":e)+"}"}var Lp=3D[=
"a","b","c","d","e","f","g"];function Pp(t,e,n){var i=3D(e=3DV(e)?e:[e]).le=
ngth;if(!i)return"";for(var o=3De[0].$vars||[],r=3D0;r<o.length;r++){var a=
=3DLp[r];t=3Dt.replace(Ap(a),Ap(a,0))}for(var s=3D0;s<i;s++)for(var l=3D0;l=
<o.length;l++){var u=3De[s][o[l]];t=3Dt.replace(Ap(Lp[l],s),n?me(u):u)}retu=
rn t}function Op(t,e){var t=3DH(t)?{color:t,extraCssText:e}:t||{},n=3Dt.col=
or,i=3Dt.type,o=3D(e=3Dt.extraCssText,t.renderMode||"html");return n?"html"=
=3D=3D=3Do?"subItem"=3D=3D=3Di?'<span style=3D"display:inline-block;vertica=
l-align:middle;margin-right:8px;margin-left:3px;border-radius:4px;width:4px=
;height:4px;background-color:'+me(n)+";"+(e||"")+'"></span>':'<span style=
=3D"display:inline-block;margin-right:4px;border-radius:10px;width:10px;hei=
ght:10px;background-color:'+me(n)+";"+(e||"")+'"></span>':{renderMode:o,con=
tent:"{"+(t.markerId||"markerX")+"|}  ",style:"subItem"=3D=3D=3Di?{width:4,=
height:4,borderRadius:2,backgroundColor:n}:{width:10,height:10,borderRadius=
:5,backgroundColor:n}}:""}function Rp(t,e){return e=3De||"transparent",H(t)=
?t:O(t)&&t.colorStops&&(t.colorStops[0]||{}).color||e}var Np=3DE,Ep=3D["lef=
t","right","top","bottom","width","height"],zp=3D[["width","left","right"],=
["height","top","bottom"]];function Bp(a,s,l,u,h){var c=3D0,p=3D0,d=3D(null=
=3D=3Du&&(u=3D1/0),null=3D=3Dh&&(h=3D1/0),0);s.eachChild(function(t,e){var =
n,i,o,r=3Dt.getBoundingRect(),e=3Ds.childAt(e+1),e=3De&&e.getBoundingRect()=
;d=3D"horizontal"=3D=3D=3Da?(o=3Dr.width+(e?-e.x+r.x:0),(n=3Dc+o)>u||t.newl=
ine?(c=3D0,n=3Do,p+=3Dd+l,r.height):Math.max(d,r.height)):(o=3Dr.height+(e?=
-e.y+r.y:0),(i=3Dp+o)>h||t.newline?(c+=3Dd+l,p=3D0,i=3Do,r.width):Math.max(=
d,r.width)),t.newline||(t.x=3Dc,t.y=3Dp,t.markRedraw(),"horizontal"=3D=3D=
=3Da?c=3Dn+l:p=3Di+l)})}var Fp=3DBp;function Vp(t,e,n){n=3DDp(n||0);var i=
=3De.width,o=3De.height,r=3Der(t.left,i),a=3Der(t.top,o),e=3Der(t.right,i),=
s=3Der(t.bottom,o),l=3Der(t.width,i),u=3Der(t.height,o),h=3Dn[2]+n[0],c=3Dn=
[1]+n[3],p=3Dt.aspect;switch(isNaN(l)&&(l=3Di-e-c-r),isNaN(u)&&(u=3Do-s-h-a=
),null!=3Dp&&(isNaN(l)&&isNaN(u)&&(i/o<p?l=3D.8*i:u=3D.8*o),isNaN(l)&&(l=3D=
p*u),isNaN(u))&&(u=3Dl/p),isNaN(r)&&(r=3Di-e-l-c),isNaN(a)&&(a=3Do-s-u-h),t=
.left||t.right){case"center":r=3Di/2-l/2-n[3];break;case"right":r=3Di-l-c}s=
witch(t.top||t.bottom){case"middle":case"center":a=3Do/2-u/2-n[0];break;cas=
e"bottom":a=3Do-u-h}r=3Dr||0,a=3Da||0,isNaN(l)&&(l=3Di-c-r-(e||0)),isNaN(u)=
&&(u=3Do-h-a-(s||0));p=3Dnew G(r+n[3],a+n[0],l,u);return p.margin=3Dn,p}fun=
ction Hp(t){t=3Dt.layoutMode||t.constructor.layoutMode;return O(t)?t:t?{typ=
e:t}:null}function Wp(l,u,t){var h=3Dt&&t.ignoreSize,t=3D(V(h)||(h=3D[h,h])=
,n(zp[0],0)),e=3Dn(zp[1],1);function n(t,e){var n=3D{},i=3D0,o=3D{},r=3D0;i=
f(Np(t,function(t){o[t]=3Dl[t]}),Np(t,function(t){c(u,t)&&(n[t]=3Do[t]=3Du[=
t]),p(n,t)&&i++,p(o,t)&&r++}),h[e])p(u,t[1])?o[t[2]]=3Dnull:p(u,t[2])&&(o[t=
[1]]=3Dnull);else if(2!=3D=3Dr&&i){if(!(2<=3Di))for(var a=3D0;a<t.length;a+=
+){var s=3Dt[a];if(!c(n,s)&&c(l,s)){n[s]=3Dl[s];break}}return n}return o}fu=
nction c(t,e){return t.hasOwnProperty(e)}function p(t,e){return null!=3Dt[e=
]&&"auto"!=3D=3Dt[e]}function i(t,e,n){Np(t,function(t){e[t]=3Dn[t]})}i(zp[=
0],l,t),i(zp[1],l,e)}function Gp(t){return e=3D{},(n=3Dt)&&e&&Np(Ep,functio=
n(t){n.hasOwnProperty(t)&&(e[t]=3Dn[t])}),e;var e,n}M(Bp,"vertical"),M(Bp,"=
horizontal");var Xp,Up,Yp,Zp,qp=3DRr(),g=3D(u(jp,Xp=3DHc),jp.prototype.init=
=3Dfunction(t,e,n){this.mergeDefaultAndTheme(t,n)},jp.prototype.mergeDefaul=
tAndTheme=3Dfunction(t,e){var n=3DHp(this),i=3Dn?Gp(t):{};d(t,e.getTheme().=
get(this.mainType)),d(t,this.getDefaultOption()),n&&Wp(t,i,n)},jp.prototype=
.mergeOption=3Dfunction(t,e){d(this.option,t,!0);var n=3DHp(this);n&&Wp(thi=
s.option,t,n)},jp.prototype.optionUpdated=3Dfunction(t,e){},jp.prototype.ge=
tDefaultOption=3Dfunction(){var t=3Dthis.constructor;if(!(e=3Dt)||!e[Ur])re=
turn t.defaultOption;var e=3Dqp(this);if(!e.defaultOption){for(var n=3D[],i=
=3Dt;i;){var o=3Di.prototype.defaultOption;o&&n.push(o),i=3Di.superClass}fo=
r(var r=3D{},a=3Dn.length-1;0<=3Da;a--)r=3Dd(r,n[a],!0);e.defaultOption=3Dr=
}return e.defaultOption},jp.prototype.getReferringComponents=3Dfunction(t,e=
){var n=3Dt+"Id";return Vr(this.ecModel,t,{index:this.get(t+"Index",!0),id:=
this.get(n,!0)},e)},jp.prototype.getBoxLayoutParams=3Dfunction(){return{lef=
t:this.get("left"),top:this.get("top"),right:this.get("right"),bottom:this.=
get("bottom"),width:this.get("width"),height:this.get("height")}},jp.protot=
ype.getZLevelKey=3Dfunction(){return""},jp.prototype.setZLevel=3Dfunction(t=
){this.option.zlevel=3Dt},jp.protoInitialize=3D((Rc=3Djp.prototype).type=3D=
"component",Rc.id=3D"",Rc.name=3D"",Rc.mainType=3D"",Rc.subType=3D"",void(R=
c.componentIndex=3D0)),jp);function jp(t,e,n){t=3DXp.call(this,t,e,n)||this=
;return t.uid=3DXc("ec_cpt_model"),t}function Kp(t,e){return t[e]||(t[e]=3D=
{predecessor:[],successor:[]}),t[e]}qr(g,Hc),Qr(g),Zp=3D{},(Yp=3Dg).registe=
rSubTypeDefaulter=3Dfunction(t,e){t=3DYr(t);Zp[t.main]=3De},Yp.determineSub=
Type=3Dfunction(t,e){var n,i=3De.type;return i||(n=3DYr(t).main,Yp.hasSubTy=
pes(t)&&Zp[n]&&(i=3DZp[n](e))),i},Up=3Dfunction(t){var e=3D[];return E(g.ge=
tClassesByMainType(t),function(t){e=3De.concat(t.dependencies||t.prototype.=
dependencies||[])}),e=3DF(e,function(t){return Yr(t).main}),"dataset"!=3D=
=3Dt&&C(e,"dataset")<=3D0&&e.unshift("dataset"),e},g.topologicalTravel=3Dfu=
nction(t,e,n,i){if(t.length){c=3D{},p=3D[],E(h=3De,function(n){var e,i,o=3D=
Kp(c,n),t=3D(t=3Do.originalDeps=3DUp(n),e=3Dh,i=3D[],E(t,function(t){0<=3DC=
(e,t)&&i.push(t)}),i);o.entryCount=3Dt.length,0=3D=3D=3Do.entryCount&&p.pus=
h(n),E(t,function(t){C(o.predecessor,t)<0&&o.predecessor.push(t);var e=3DKp=
(c,t);C(e.successor,t)<0&&e.successor.push(n)})});var e=3D{graph:c,noEntryL=
ist:p},o=3De.graph,r=3De.noEntryList,a=3D{};for(E(t,function(t){a[t]=3D!0})=
;r.length;){var s=3Dr.pop(),l=3Do[s],u=3D!!a[s];u&&(n.call(i,s,l.originalDe=
ps.slice()),delete a[s]),E(l.successor,u?f:d)}E(a,function(){throw new Erro=
r("")})}var h,c,p;function d(t){o[t].entryCount--,0=3D=3D=3Do[t].entryCount=
&&r.push(t)}function f(t){a[t]=3D!0,d(t)}};var Bc=3D"",ea=3D("undefined"!=
=3Dtypeof navigator&&(Bc=3Dnavigator.platform||""),"rgba(0, 0, 0, 0.2)"),$p=
=3D{darkMode:"auto",colorBy:"series",color:["#5470c6","#91cc75","#fac858","=
#ee6666","#73c0de","#3ba272","#fc8452","#9a60b4","#ea7ccc"],gradientColor:[=
"#f6efa6","#d88273","#bf444c"],aria:{decal:{decals:[{color:ea,dashArrayX:[1=
,0],dashArrayY:[2,5],symbolSize:1,rotation:Math.PI/6},{color:ea,symbol:"cir=
cle",dashArrayX:[[8,8],[0,8,8,0]],dashArrayY:[6,0],symbolSize:.8},{color:ea=
,dashArrayX:[1,0],dashArrayY:[4,3],rotation:-Math.PI/4},{color:ea,dashArray=
X:[[6,6],[0,6,6,0]],dashArrayY:[6,0]},{color:ea,dashArrayX:[[1,0],[1,6]],da=
shArrayY:[1,0,6,0],rotation:Math.PI/4},{color:ea,symbol:"triangle",dashArra=
yX:[[9,9],[0,9,9,0]],dashArrayY:[7,2],symbolSize:.75}]}},textStyle:{fontFam=
ily:Bc.match(/^Win/)?"Microsoft YaHei":"sans-serif",fontSize:12,fontStyle:"=
normal",fontWeight:"normal"},blendMode:null,stateAnimation:{duration:300,ea=
sing:"cubicOut"},animation:"auto",animationDuration:1e3,animationDurationUp=
date:500,animationEasing:"cubicInOut",animationEasingUpdate:"cubicInOut",an=
imationThreshold:2e3,progressiveThreshold:3e3,progressive:400,hoverLayerThr=
eshold:3e3,useUTC:!1},Qp=3DN(["tooltip","label","itemName","itemId","itemGr=
oupId","itemChildGroupId","seriesName"]),Jp=3D"original",td=3D"arrayRows",e=
d=3D"objectRows",nd=3D"keyedColumns",id=3D"typedArray",od=3D"unknown",rd=3D=
"column",ad=3D"row",sd=3D{Must:1,Might:2,Not:3},ld=3DRr();function ud(n,t,e=
){var o,i,r,a,s,l=3D{},u=3Dcd(t);return u&&n&&(r=3D[],a=3D[],t=3Dt.ecModel,=
t=3Dld(t).datasetMap,u=3Du.uid+"_"+e.seriesLayoutBy,E(n=3Dn.slice(),functio=
n(t,e){t=3DO(t)?t:n[e]=3D{name:t};"ordinal"=3D=3D=3Dt.type&&null=3D=3Do&&(o=
=3De,i=3Dc(t)),l[t.name]=3D[]}),s=3Dt.get(u)||t.set(u,{categoryWayDim:i,val=
ueWayDim:0}),E(n,function(t,e){var n,i=3Dt.name,t=3Dc(t);null=3D=3Do?(n=3Ds=
.valueWayDim,h(l[i],n,t),h(a,n,t),s.valueWayDim+=3Dt):o=3D=3D=3De?(h(l[i],0=
,t),h(r,0,t)):(n=3Ds.categoryWayDim,h(l[i],n,t),h(a,n,t),s.categoryWayDim+=
=3Dt)}),r.length&&(l.itemName=3Dr),a.length)&&(l.seriesName=3Da),l;function=
 h(t,e,n){for(var i=3D0;i<n;i++)t.push(e+i)}function c(t){t=3Dt.dimsDef;ret=
urn t?t.length:1}}function hd(t,l,u){var h,c,p,e=3D{};return cd(t)&&(c=3Dl.=
sourceFormat,p=3Dl.dimensionsDefine,c!=3D=3Ded&&c!=3D=3Dnd||E(p,function(t,=
e){"name"=3D=3D=3D(O(t)?t.name:t)&&(h=3De)}),t=3Dfunction(){for(var t=3D{},=
e=3D{},n=3D[],i=3D0,o=3DMath.min(5,u);i<o;i++){var r=3Ddd(l.data,c,l.series=
LayoutBy,p,l.startIndex,i),a=3D(n.push(r),r=3D=3D=3Dsd.Not);if(a&&null=3D=
=3Dt.v&&i!=3D=3Dh&&(t.v=3Di),null!=3Dt.n&&t.n!=3D=3Dt.v&&(a||n[t.n]!=3D=3Ds=
d.Not)||(t.n=3Di),s(t)&&n[t.n]!=3D=3Dsd.Not)return t;a||(r=3D=3D=3Dsd.Might=
&&null=3D=3De.v&&i!=3D=3Dh&&(e.v=3Di),null!=3De.n&&e.n!=3D=3De.v)||(e.n=3Di=
)}function s(t){return null!=3Dt.v&&null!=3Dt.n}return s(t)?t:s(e)?e:null}(=
))&&(e.value=3D[t.v],t=3Dnull!=3Dh?h:t.n,e.itemName=3D[t],e.seriesName=3D[t=
]),e}function cd(t){if(!t.get("data",!0))return Vr(t.ecModel,"dataset",{ind=
ex:t.get("datasetIndex",!0),id:t.get("datasetId",!0)},Br).models[0]}functio=
n pd(t,e){return dd(t.data,t.sourceFormat,t.seriesLayoutBy,t.dimensionsDefi=
ne,t.startIndex,e)}function dd(t,e,n,i,o,r){var a,s,l;if(!dt(t)){if(i&&(O(i=
=3Di[r])?(s=3Di.name,l=3Di.type):H(i)&&(s=3Di)),null!=3Dl)return"ordinal"=
=3D=3D=3Dl?sd.Must:sd.Not;if(e=3D=3D=3Dtd){var u=3Dt;if(n=3D=3D=3Dad){for(v=
ar h=3Du[r],c=3D0;c<(h||[]).length&&c<5;c++)if(null!=3D(a=3Dm(h[o+c])))retu=
rn a}else for(c=3D0;c<u.length&&c<5;c++){var p=3Du[o+c];if(p&&null!=3D(a=3D=
m(p[r])))return a}}else if(e=3D=3D=3Ded){var d=3Dt;if(!s)return sd.Not;for(=
c=3D0;c<d.length&&c<5;c++)if((g=3Dd[c])&&null!=3D(a=3Dm(g[s])))return a}els=
e if(e=3D=3D=3Dnd){if(!s)return sd.Not;if(!(h=3Dt[s])||dt(h))return sd.Not;=
for(c=3D0;c<h.length&&c<5;c++)if(null!=3D(a=3Dm(h[c])))return a}else if(e=
=3D=3D=3DJp)for(var f=3Dt,c=3D0;c<f.length&&c<5;c++){var g=3Df[c],y=3DTr(g)=
;if(!V(y))return sd.Not;if(null!=3D(a=3Dm(y[r])))return a}}return sd.Not;fu=
nction m(t){var e=3DH(t);return null!=3Dt&&isFinite(t)&&""!=3D=3Dt?e?sd.Mig=
ht:sd.Not:e&&"-"!=3D=3Dt?sd.Must:void 0}}var fd=3DN();var gd=3DRr(),yd=3D(R=
r(),md.prototype.getColorFromPalette=3Dfunction(t,e,n){var i=3Dbr(this.get(=
"color",!0)),o=3Dthis.get("colorLayer",!0),r=3Dthis,a=3Dgd;return a=3Da(e=
=3De||r),r=3Da.paletteIdx||0,(e=3Da.paletteNameMap=3Da.paletteNameMap||{}).=
hasOwnProperty(t)?e[t]:(o=3D(o=3Dnull!=3Dn&&o?function(t,e){for(var n=3Dt.l=
ength,i=3D0;i<n;i++)if(t[i].length>e)return t[i];return t[n-1]}(o,n):i)||i)=
&&o.length?(n=3Do[r],t&&(e[t]=3Dn),a.paletteIdx=3D(r+1)%o.length,n):void 0}=
,md.prototype.clearColorPalette=3Dfunction(){var t,e;(e=3Dgd)(t=3Dthis).pal=
etteIdx=3D0,e(t).paletteNameMap=3D{}},md);function md(){}var vd,_d,xd,wd,bd=
=3D"\0_ec_inner",Sd=3D(u(r,wd=3DHc),r.prototype.init=3Dfunction(t,e,n,i,o,r=
){i=3Di||{},this.option=3Dnull,this._theme=3Dnew Hc(i),this._locale=3Dnew H=
c(o),this._optionManager=3Dr},r.prototype.setOption=3Dfunction(t,e,n){e=3DI=
d(e);this._optionManager.setOption(t,n,e),this._resetOption(null,e)},r.prot=
otype.resetOption=3Dfunction(t,e){return this._resetOption(t,Id(e))},r.prot=
otype._resetOption=3Dfunction(t,e){var n,i=3D!1,o=3Dthis._optionManager;ret=
urn t&&"recreate"!=3D=3Dt||(n=3Do.mountOption("recreate"=3D=3D=3Dt),this.op=
tion&&"recreate"!=3D=3Dt?(this.restoreData(),this._mergeOption(n,e)):xd(thi=
s,n),i=3D!0),"timeline"!=3D=3Dt&&"media"!=3D=3Dt||this.restoreData(),t&&"re=
create"!=3D=3Dt&&"timeline"!=3D=3Dt||(n=3Do.getTimelineOption(this))&&(i=3D=
!0,this._mergeOption(n,e)),t&&"recreate"!=3D=3Dt&&"media"!=3D=3Dt||(n=3Do.g=
etMediaOption(this)).length&&E(n,function(t){i=3D!0,this._mergeOption(t,e)}=
,this),i},r.prototype.mergeOption=3Dfunction(t){this._mergeOption(t,null)},=
r.prototype._mergeOption=3Dfunction(i,t){var o=3Dthis.option,h=3Dthis._comp=
onentsMap,c=3Dthis._componentsCount,n=3D[],r=3DN(),p=3Dt&&t.replaceMergeMai=
nTypeMap;ld(this).datasetMap=3DN(),E(i,function(t,e){null!=3Dt&&(g.hasClass=
(e)?e&&(n.push(e),r.set(e,!0)):o[e]=3Dnull=3D=3Do[e]?y(t):d(o[e],t,!0))}),p=
&&p.each(function(t,e){g.hasClass(e)&&!r.get(e)&&(n.push(e),r.set(e,!0))}),=
g.topologicalTravel(n,g.getAllClassMainTypes(),function(r){t=3Dthis,n=3Dbr(=
i[e=3Dr]);var t=3D(e=3D(e=3Dfd.get(e))&&e(t))?n.concat(e):n,e=3Dh.get(r),n=
=3DIr(e,t,e?p&&p.get(r)?"replaceMerge":"normalMerge":"replaceAll");Pr(n,r,g=
),o[r]=3Dnull,h.set(r,null),c.set(r,0);var a,s=3D[],l=3D[],u=3D0;E(n,functi=
on(t,e){var n=3Dt.existing,i=3Dt.newOption;if(i){var o=3Dg.getClass(r,t.key=
Info.subType,!("series"=3D=3D=3Dr));if(!o)return;if("tooltip"=3D=3D=3Dr){if=
(a)return;a=3D!0}n&&n.constructor=3D=3D=3Do?(n.name=3Dt.keyInfo.name,n.merg=
eOption(i,this),n.optionUpdated(i,!1)):(e=3DP({componentIndex:e},t.keyInfo)=
,P(n=3Dnew o(i,this,this,e),e),t.brandNew&&(n.__requireNewView=3D!0),n.init=
(i,this,this),n.optionUpdated(null,!0))}else n&&(n.mergeOption({},this),n.o=
ptionUpdated({},!1));n?(s.push(n.option),l.push(n),u++):(s.push(void 0),l.p=
ush(void 0))},this),o[r]=3Ds,h.set(r,l),c.set(r,u),"series"=3D=3D=3Dr&&vd(t=
his)},this),this._seriesIndices||vd(this)},r.prototype.getOption=3Dfunction=
(){var a=3Dy(this.option);return E(a,function(t,e){if(g.hasClass(e)){for(va=
r n=3Dbr(t),i=3Dn.length,o=3D!1,r=3Di-1;0<=3Dr;r--)n[r]&&!Lr(n[r])?o=3D!0:(=
n[r]=3Dnull,o||i--);n.length=3Di,a[e]=3Dn}}),delete a[bd],a},r.prototype.ge=
tTheme=3Dfunction(){return this._theme},r.prototype.getLocaleModel=3Dfuncti=
on(){return this._locale},r.prototype.setUpdatePayload=3Dfunction(t){this._=
payload=3Dt},r.prototype.getUpdatePayload=3Dfunction(){return this._payload=
},r.prototype.getComponent=3Dfunction(t,e){var n=3Dthis._componentsMap.get(=
t);if(n){t=3Dn[e||0];if(t)return t;if(null=3D=3De)for(var i=3D0;i<n.length;=
i++)if(n[i])return n[i]}},r.prototype.queryComponents=3Dfunction(t){var e,n=
,i,o,r,a=3Dt.mainType;return a&&(n=3Dt.index,i=3Dt.id,o=3Dt.name,r=3Dthis._=
componentsMap.get(a))&&r.length?(null!=3Dn?(e=3D[],E(br(n),function(t){r[t]=
&&e.push(r[t])})):e=3Dnull!=3Di?Md("id",i,r):null!=3Do?Md("name",o,r):ut(r,=
function(t){return!!t}),Td(e,t)):[]},r.prototype.findComponents=3Dfunction(=
t){var e,n=3Dt.query,i=3Dt.mainType,o=3D(o=3Di+"Index",r=3Di+"Id",e=3Di+"Na=
me",!n||null=3D=3Dn[o]&&null=3D=3Dn[r]&&null=3D=3Dn[e]?null:{mainType:i,ind=
ex:n[o],id:n[r],name:n[e]}),r=3DTd(o?this.queryComponents(o):ut(this._compo=
nentsMap.get(i),function(t){return!!t}),t);return t.filter?ut(r,t.filter):r=
},r.prototype.eachComponent=3Dfunction(t,e,n){var i=3Dthis._componentsMap;i=
f(D(t)){var o=3De,r=3Dt;i.each(function(t,e){for(var n=3D0;t&&n<t.length;n+=
+){var i=3Dt[n];i&&r.call(o,e,i,i.componentIndex)}})}else for(var a=3DH(t)?=
i.get(t):O(t)?this.findComponents(t):null,s=3D0;a&&s<a.length;s++){var l=3D=
a[s];l&&e.call(n,l,l.componentIndex)}},r.prototype.getSeriesByName=3Dfuncti=
on(t){var e=3Dkr(t,null);return ut(this._componentsMap.get("series"),functi=
on(t){return!!t&&null!=3De&&t.name=3D=3D=3De})},r.prototype.getSeriesByInde=
x=3Dfunction(t){return this._componentsMap.get("series")[t]},r.prototype.ge=
tSeriesByType=3Dfunction(e){return ut(this._componentsMap.get("series"),fun=
ction(t){return!!t&&t.subType=3D=3D=3De})},r.prototype.getSeries=3Dfunction=
(){return ut(this._componentsMap.get("series"),function(t){return!!t})},r.p=
rototype.getSeriesCount=3Dfunction(){return this._componentsCount.get("seri=
es")},r.prototype.eachSeries=3Dfunction(n,i){_d(this),E(this._seriesIndices=
,function(t){var e=3Dthis._componentsMap.get("series")[t];n.call(i,e,t)},th=
is)},r.prototype.eachRawSeries=3Dfunction(e,n){E(this._componentsMap.get("s=
eries"),function(t){t&&e.call(n,t,t.componentIndex)})},r.prototype.eachSeri=
esByType=3Dfunction(n,i,o){_d(this),E(this._seriesIndices,function(t){var e=
=3Dthis._componentsMap.get("series")[t];e.subType=3D=3D=3Dn&&i.call(o,e,t)}=
,this)},r.prototype.eachRawSeriesByType=3Dfunction(t,e,n){return E(this.get=
SeriesByType(t),e,n)},r.prototype.isSeriesFiltered=3Dfunction(t){return _d(=
this),null=3D=3Dthis._seriesIndicesMap.get(t.componentIndex)},r.prototype.g=
etCurrentSeriesIndices=3Dfunction(){return(this._seriesIndices||[]).slice()=
},r.prototype.filterSeries=3Dfunction(n,i){_d(this);var o=3D[];E(this._seri=
esIndices,function(t){var e=3Dthis._componentsMap.get("series")[t];n.call(i=
,e,t)&&o.push(t)},this),this._seriesIndices=3Do,this._seriesIndicesMap=3DN(=
o)},r.prototype.restoreData=3Dfunction(n){vd(this);var t=3Dthis._components=
Map,i=3D[];t.each(function(t,e){g.hasClass(e)&&i.push(e)}),g.topologicalTra=
vel(i,g.getAllClassMainTypes(),function(e){E(t.get(e),function(t){!t||"seri=
es"=3D=3D=3De&&function(t,e){{var n,i;if(e)return n=3De.seriesIndex,i=3De.s=
eriesId,e=3De.seriesName,null!=3Dn&&t.componentIndex!=3D=3Dn||null!=3Di&&t.=
id!=3D=3Di||null!=3De&&t.name!=3D=3De}}(t,n)||t.restoreData()})})},r.intern=
alField=3D(vd=3Dfunction(t){var e=3Dt._seriesIndices=3D[];E(t._componentsMa=
p.get("series"),function(t){t&&e.push(t.componentIndex)}),t._seriesIndicesM=
ap=3DN(e)},_d=3Dfunction(t){},void(xd=3Dfunction(t,e){t.option=3D{},t.optio=
n[bd]=3D1,t._componentsMap=3DN({series:[]}),t._componentsCount=3DN();var n,=
i,o=3De.aria;O(o)&&null=3D=3Do.enabled&&(o.enabled=3D!0),n=3De,o=3Dt._theme=
.option,i=3Dn.color&&!n.colorLayer,E(o,function(t,e){"colorLayer"=3D=3D=3De=
&&i||g.hasClass(e)||("object"=3D=3Dtypeof t?n[e]=3Dn[e]?d(n[e],t,!1):y(t):n=
ull=3D=3Dn[e]&&(n[e]=3Dt))}),d(e,$p,!1),t._mergeOption(e,null)})),r);functi=
on r(){return null!=3D=3Dwd&&wd.apply(this,arguments)||this}function Md(e,t=
,n){var i,o;return V(t)?(i=3DN(),E(t,function(t){null!=3Dt&&null!=3Dkr(t,nu=
ll)&&i.set(t,!0)}),ut(n,function(t){return t&&i.get(t[e])})):(o=3Dkr(t,null=
),ut(n,function(t){return t&&null!=3Do&&t[e]=3D=3D=3Do}))}function Td(t,e){=
return e.hasOwnProperty("subType")?ut(t,function(t){return t&&t.subType=3D=
=3D=3De.subType}):t}function Id(t){var e=3DN();return t&&E(br(t.replaceMerg=
e),function(t){e.set(t,!0)}),{replaceMergeMainTypeMap:e}}at(Sd,yd);function=
 Cd(e){E(Dd,function(t){this[t]=3DS(e[t],e)},this)}var Dd=3D["getDom","getZ=
r","getWidth","getHeight","getDevicePixelRatio","dispatchAction","isSSR","i=
sDisposed","on","off","getDataURL","getConnectedDataURL","getOption","getId=
","updateLabelLayout"],kd=3D{},Ad=3D(Ld.prototype.create=3Dfunction(n,i){va=
r o=3D[];E(kd,function(t,e){t=3Dt.create(n,i);o=3Do.concat(t||[])}),this._c=
oordinateSystems=3Do},Ld.prototype.update=3Dfunction(e,n){E(this._coordinat=
eSystems,function(t){t.update&&t.update(e,n)})},Ld.prototype.getCoordinateS=
ystems=3Dfunction(){return this._coordinateSystems.slice()},Ld.register=3Df=
unction(t,e){kd[t]=3De},Ld.get=3Dfunction(t){return kd[t]},Ld);function Ld(=
){this._coordinateSystems=3D[]}var Pd=3D/^(min|max)?(.+)$/,Od=3D(Rd.prototy=
pe.setOption=3Dfunction(t,e,n){t&&(E(br(t.series),function(t){t&&t.data&&dt=
(t.data)&&It(t.data)}),E(br(t.dataset),function(t){t&&t.source&&dt(t.source=
)&&It(t.source)})),t=3Dy(t);var i,o,r,a,s,l,u,h,c,p,d=3Dthis._optionBackup,=
t=3D(i=3De,o=3D!d,s=3D[],t=3D(e=3Dt).baseOption,l=3De.timeline,u=3De.option=
s,h=3De.media,c=3D!!e.media,p=3D!!(u||l||t&&t.timeline),t?(a=3Dt).timeline|=
|(a.timeline=3Dl):((p||c)&&(e.options=3De.media=3Dnull),a=3De),c&&V(h)&&E(h=
,function(t){t&&t.option&&(t.query?s.push(t):r=3Dr||t)}),f(a),E(u,f),E(s,fu=
nction(t){return f(t.option)}),{baseOption:a,timelineOptions:u||[],mediaDef=
ault:r,mediaList:s});function f(e){E(i,function(t){t(e,o)})}this._newBaseOp=
tion=3Dt.baseOption,d?(t.timelineOptions.length&&(d.timelineOptions=3Dt.tim=
elineOptions),t.mediaList.length&&(d.mediaList=3Dt.mediaList),t.mediaDefaul=
t&&(d.mediaDefault=3Dt.mediaDefault)):this._optionBackup=3Dt},Rd.prototype.=
mountOption=3Dfunction(t){var e=3Dthis._optionBackup;return this._timelineO=
ptions=3De.timelineOptions,this._mediaList=3De.mediaList,this._mediaDefault=
=3De.mediaDefault,this._currentMediaIndices=3D[],y(t?e.baseOption:this._new=
BaseOption)},Rd.prototype.getTimelineOption=3Dfunction(t){var e,n=3Dthis._t=
imelineOptions;return e=3Dn.length&&(t=3Dt.getComponent("timeline"))?y(n[t.=
getCurrentIndex()]):e},Rd.prototype.getMediaOption=3Dfunction(t){var e,n,i=
=3Dthis._api.getWidth(),o=3Dthis._api.getHeight(),r=3Dthis._mediaList,a=3Dt=
his._mediaDefault,s=3D[],l=3D[];if(r.length||a){for(var u=3D0,h=3Dr.length;=
u<h;u++)!function(t,e,n){var i=3D{width:e,height:n,aspectratio:e/n},o=3D!0;=
return E(t,function(t,e){var n,e=3De.match(Pd);e&&e[1]&&e[2]&&(n=3De[1],e=
=3De[2].toLowerCase(),e=3Di[e],t=3Dt,("min"=3D=3D=3D(n=3Dn)?t<=3De:"max"=3D=
=3D=3Dn?e<=3Dt:e=3D=3D=3Dt)||(o=3D!1))}),o}(r[u].query,i,o)||s.push(u);(s=
=3D!s.length&&a?[-1]:s).length&&(e=3Ds,n=3Dthis._currentMediaIndices,e.join=
(",")!=3D=3Dn.join(","))&&(l=3DF(s,function(t){return y((-1=3D=3D=3Dt?a:r[t=
]).option)})),this._currentMediaIndices=3Ds}return l},Rd);function Rd(t){th=
is._timelineOptions=3D[],this._mediaList=3D[],this._currentMediaIndices=3D[=
],this._api=3Dt}var Nd=3DE,Ed=3DO,zd=3D["areaStyle","lineStyle","nodeStyle"=
,"linkStyle","chordStyle","label","labelLine"];function Bd(t){var e=3Dt&&t.=
itemStyle;if(e)for(var n=3D0,i=3Dzd.length;n<i;n++){var o=3Dzd[n],r=3De.nor=
mal,a=3De.emphasis;r&&r[o]&&(t[o]=3Dt[o]||{},t[o].normal?d(t[o].normal,r[o]=
):t[o].normal=3Dr[o],r[o]=3Dnull),a&&a[o]&&(t[o]=3Dt[o]||{},t[o].emphasis?d=
(t[o].emphasis,a[o]):t[o].emphasis=3Da[o],a[o]=3Dnull)}}function Fd(t,e,n){=
var i,o;t&&t[e]&&(t[e].normal||t[e].emphasis)&&(i=3Dt[e].normal,o=3Dt[e].em=
phasis,i&&(n?(t[e].normal=3Dt[e].emphasis=3Dnull,B(t[e],i)):t[e]=3Di),o)&&(=
t.emphasis=3Dt.emphasis||{},(t.emphasis[e]=3Do).focus&&(t.emphasis.focus=3D=
o.focus),o.blurScope)&&(t.emphasis.blurScope=3Do.blurScope)}function Vd(t){=
Fd(t,"itemStyle"),Fd(t,"lineStyle"),Fd(t,"areaStyle"),Fd(t,"label"),Fd(t,"l=
abelLine"),Fd(t,"upperLabel"),Fd(t,"edgeLabel")}function Hd(t,e){var n=3DEd=
(t)&&t[e],i=3DEd(n)&&n.textStyle;if(i)for(var o=3D0,r=3DMr.length;o<r;o++){=
var a=3DMr[o];i.hasOwnProperty(a)&&(n[a]=3Di[a])}}function Wd(t){t&&(Vd(t),=
Hd(t,"label"),t.emphasis)&&Hd(t.emphasis,"label")}function Gd(t){return V(t=
)?t:t?[t]:[]}function Xd(t){return(V(t)?t[0]:t)||{}}function Ud(e,t){Nd(Gd(=
e.series),function(t){if(Ed(t))if(Ed(t)){Bd(t),Vd(t),Hd(t,"label"),Hd(t,"up=
perLabel"),Hd(t,"edgeLabel"),t.emphasis&&(Hd(t.emphasis,"label"),Hd(t.empha=
sis,"upperLabel"),Hd(t.emphasis,"edgeLabel"));var e=3Dt.markPoint,n=3D(e&&(=
Bd(e),Wd(e)),t.markLine),i=3D(n&&(Bd(n),Wd(n)),t.markArea),o=3D(i&&Wd(i),t.=
data);if("graph"=3D=3D=3Dt.type){var o=3Do||t.nodes,r=3Dt.links||t.edges;if=
(r&&!dt(r))for(var a=3D0;a<r.length;a++)Wd(r[a]);E(t.categories,function(t)=
{Vd(t)})}if(o&&!dt(o))for(a=3D0;a<o.length;a++)Wd(o[a]);if((e=3Dt.markPoint=
)&&e.data)for(var s=3De.data,a=3D0;a<s.length;a++)Wd(s[a]);if((n=3Dt.markLi=
ne)&&n.data){var l=3Dn.data;for(a=3D0;a<l.length;a++)V(l[a])?(Wd(l[a][0]),W=
d(l[a][1])):Wd(l[a])}"gauge"=3D=3D=3Dt.type?(Hd(t,"axisLabel"),Hd(t,"title"=
),Hd(t,"detail")):"treemap"=3D=3D=3Dt.type?(Fd(t.breadcrumb,"itemStyle"),E(=
t.levels,function(t){Vd(t)})):"tree"=3D=3D=3Dt.type&&Vd(t.leaves)}});var n=
=3D["xAxis","yAxis","radiusAxis","angleAxis","singleAxis","parallelAxis","r=
adar"];t&&n.push("valueAxis","categoryAxis","logAxis","timeAxis"),Nd(n,func=
tion(t){Nd(Gd(e[t]),function(t){t&&(Hd(t,"axisLabel"),Hd(t.axisPointer,"lab=
el"))})}),Nd(Gd(e.parallel),function(t){t=3Dt&&t.parallelAxisDefault;Hd(t,"=
axisLabel"),Hd(t&&t.axisPointer,"label")}),Nd(Gd(e.calendar),function(t){Fd=
(t,"itemStyle"),Hd(t,"dayLabel"),Hd(t,"monthLabel"),Hd(t,"yearLabel")}),Nd(=
Gd(e.radar),function(t){Hd(t,"name"),t.name&&null=3D=3Dt.axisName&&(t.axisN=
ame=3Dt.name,delete t.name),null!=3Dt.nameGap&&null=3D=3Dt.axisNameGap&&(t.=
axisNameGap=3Dt.nameGap,delete t.nameGap)}),Nd(Gd(e.geo),function(t){Ed(t)&=
&(Wd(t),Nd(Gd(t.regions),function(t){Wd(t)}))}),Nd(Gd(e.timeline),function(=
t){Wd(t),Fd(t,"label"),Fd(t,"itemStyle"),Fd(t,"controlStyle",!0);t=3Dt.data=
;V(t)&&E(t,function(t){O(t)&&(Fd(t,"label"),Fd(t,"itemStyle"))})}),Nd(Gd(e.=
toolbox),function(t){Fd(t,"iconStyle"),Nd(t.feature,function(t){Fd(t,"iconS=
tyle")})}),Hd(Xd(e.axisPointer),"label"),Hd(Xd(e.tooltip).axisPointer,"labe=
l")}function Yd(e){e&&E(Zd,function(t){t[0]in e&&!(t[1]in e)&&(e[t[1]]=3De[=
t[0]])})}var Zd=3D[["x","left"],["y","top"],["x2","right"],["y2","bottom"]]=
,qd=3D["grid","geo","parallel","legend","toolbox","title","visualMap","data=
Zoom","timeline"],jd=3D[["borderRadius","barBorderRadius"],["borderColor","=
barBorderColor"],["borderWidth","barBorderWidth"]];function Kd(t){var e=3Dt=
&&t.itemStyle;if(e)for(var n=3D0;n<jd.length;n++){var i=3Djd[n][1],o=3Djd[n=
][0];null!=3De[i]&&(e[o]=3De[i])}}function $d(t){t&&"edge"=3D=3D=3Dt.alignT=
o&&null!=3Dt.margin&&null=3D=3Dt.edgeDistance&&(t.edgeDistance=3Dt.margin)}=
function Qd(t){t&&t.downplay&&!t.blur&&(t.blur=3Dt.downplay)}function Jd(e,=
t){Ud(e,t),e.series=3Dbr(e.series),E(e.series,function(t){if(O(t)){var e,n=
=3Dt.type;if("line"=3D=3D=3Dn)null!=3Dt.clipOverflow&&(t.clip=3Dt.clipOverf=
low);else if("pie"=3D=3D=3Dn||"gauge"=3D=3D=3Dn){if(null!=3Dt.clockWise&&(t=
.clockwise=3Dt.clockWise),$d(t.label),(e=3Dt.data)&&!dt(e))for(var i=3D0;i<=
e.length;i++)$d(e[i]);null!=3Dt.hoverOffset&&(t.emphasis=3Dt.emphasis||{},t=
.emphasis.scaleSize=3Dnull)&&(t.emphasis.scaleSize=3Dt.hoverOffset)}else if=
("gauge"=3D=3D=3Dn){var o=3Dfunction(t,e){for(var n=3De.split(","),i=3Dt,o=
=3D0;o<n.length&&null!=3D(i=3Di&&i[n[o]]);o++);return i}(t,"pointer.color")=
;if(null!=3Do){var r=3Dt;var a=3D"itemStyle.color";var s=3Dvoid 0;for(var l=
,u=3Da.split(","),h=3Dr,c=3D0;c<u.length-1;c++)null=3D=3Dh[l=3Du[c]]&&(h[l]=
=3D{}),h=3Dh[l];!s&&null!=3Dh[u[c]]||(h[u[c]]=3Do)}}else if("bar"=3D=3D=3Dn=
){if(Kd(t),Kd(t.backgroundStyle),Kd(t.emphasis),(e=3Dt.data)&&!dt(e))for(i=
=3D0;i<e.length;i++)"object"=3D=3Dtypeof e[i]&&(Kd(e[i]),Kd(e[i]&&e[i].emph=
asis))}else"sunburst"=3D=3D=3Dn?((a=3Dt.highlightPolicy)&&(t.emphasis=3Dt.e=
mphasis||{},t.emphasis.focus||(t.emphasis.focus=3Da)),Qd(t),function t(e,n)=
{if(e)for(var i=3D0;i<e.length;i++)n(e[i]),e[i]&&t(e[i].children,n)}(t.data=
,Qd)):"graph"=3D=3D=3Dn||"sankey"=3D=3D=3Dn?(r=3Dt)&&null!=3Dr.focusNodeAdj=
acency&&(r.emphasis=3Dr.emphasis||{},null=3D=3Dr.emphasis.focus)&&(r.emphas=
is.focus=3D"adjacency"):"map"=3D=3D=3Dn&&(t.mapType&&!t.map&&(t.map=3Dt.map=
Type),t.mapLocation)&&B(t,t.mapLocation);null!=3Dt.hoverAnimation&&(t.empha=
sis=3Dt.emphasis||{},t.emphasis)&&null=3D=3Dt.emphasis.scale&&(t.emphasis.s=
cale=3Dt.hoverAnimation),Yd(t)}}),e.dataRange&&(e.visualMap=3De.dataRange),=
E(qd,function(t){t=3De[t];t&&E(t=3DV(t)?t:[t],function(t){Yd(t)})})}functio=
n tf(_){E(_,function(p,d){var f=3D[],g=3D[NaN,NaN],t=3D[p.stackResultDimens=
ion,p.stackedOverDimension],y=3Dp.data,m=3Dp.isStackedByIndex,v=3Dp.seriesM=
odel.get("stackStrategy")||"samesign";y.modify(t,function(t,e,n){var i,o,r=
=3Dy.get(p.stackedDimension,n);if(isNaN(r))return g;m?o=3Dy.getRawIndex(n):=
i=3Dy.get(p.stackedByDimension,n);for(var a,s,l,u=3DNaN,h=3Dd-1;0<=3Dh;h--)=
{var c=3D_[h];if(0<=3D(o=3Dm?o:c.data.rawIndexOf(c.stackedByDimension,i))){=
c=3Dc.data.getByRawIndex(c.stackResultDimension,o);if("all"=3D=3D=3Dv||"pos=
itive"=3D=3D=3Dv&&0<c||"negative"=3D=3D=3Dv&&c<0||"samesign"=3D=3D=3Dv&&0<=
=3Dr&&0<c||"samesign"=3D=3D=3Dv&&r<=3D0&&c<0){a=3Dr,s=3Dc,l=3Dvoid 0,l=3DMa=
th.max(or(a),or(s)),a+=3Ds,r=3DJo<l?a:nr(a,l),u=3Dc;break}}}return f[0]=3Dr=
,f[1]=3Du,f})})}var ef,nf,of=3Dfunction(t){this.data=3Dt.data||(t.sourceFor=
mat=3D=3D=3Dnd?{}:[]),this.sourceFormat=3Dt.sourceFormat||od,this.seriesLay=
outBy=3Dt.seriesLayoutBy||rd,this.startIndex=3Dt.startIndex||0,this.dimensi=
onsDetectedCount=3Dt.dimensionsDetectedCount,this.metaRawOption=3Dt.metaRaw=
Option;var e=3Dthis.dimensionsDefine=3Dt.dimensionsDefine;if(e)for(var n=3D=
0;n<e.length;n++){var i=3De[n];null=3D=3Di.type&&pd(this,n)=3D=3D=3Dsd.Must=
&&(i.type=3D"ordinal")}};function rf(t){return t instanceof of}function af(=
t,e,n){n=3Dn||lf(t);var i=3De.seriesLayoutBy,o=3Dfunction(t,e,n,i,o){var r,=
a;if(!t)return{dimensionsDefine:uf(o),startIndex:a,dimensionsDetectedCount:=
r};{var s;e=3D=3D=3Dtd?(s=3Dt,"auto"=3D=3D=3Di||null=3D=3Di?hf(function(t){=
null!=3Dt&&"-"!=3D=3Dt&&(H(t)?null=3D=3Da&&(a=3D1):a=3D0)},n,s,10):a=3DW(i)=
?i:i?1:0,o||1!=3D=3Da||(o=3D[],hf(function(t,e){o[e]=3Dnull!=3Dt?t+"":""},n=
,s,1/0)),r=3Do?o.length:n=3D=3D=3Dad?s.length:s[0]?s[0].length:null):e=3D=
=3D=3Ded?o=3Do||function(t){for(var e,n=3D0;n<t.length&&!(e=3Dt[n++]););if(=
e)return ht(e)}(t):e=3D=3D=3Dnd?o||(o=3D[],E(t,function(t,e){o.push(e)})):e=
=3D=3D=3DJp&&(i=3DTr(t[0]),r=3DV(i)&&i.length||1)}return{startIndex:a,dimen=
sionsDefine:uf(o),dimensionsDetectedCount:r}}(t,n,i,e.sourceHeader,e.dimens=
ions);return new of({data:t,sourceFormat:n,seriesLayoutBy:i,dimensionsDefin=
e:o.dimensionsDefine,startIndex:o.startIndex,dimensionsDetectedCount:o.dime=
nsionsDetectedCount,metaRawOption:y(e)})}function sf(t){return new of({data=
:t,sourceFormat:dt(t)?id:Jp})}function lf(t){var e=3Dod;if(dt(t))e=3Did;els=
e if(V(t)){0=3D=3D=3Dt.length&&(e=3Dtd);for(var n=3D0,i=3Dt.length;n<i;n++)=
{var o=3Dt[n];if(null!=3Do){if(V(o)||dt(o)){e=3Dtd;break}if(O(o)){e=3Ded;br=
eak}}}}else if(O(t))for(var r in t)if(Et(t,r)&&st(t[r])){e=3Dnd;break}retur=
n e}function uf(t){var i;if(t)return i=3DN(),F(t,function(t,e){var n,t=3D{n=
ame:(t=3DO(t)?t:{name:t}).name,displayName:t.displayName,type:t.type};retur=
n null!=3Dt.name&&(t.name+=3D"",null=3D=3Dt.displayName&&(t.displayName=3Dt=
.name),(n=3Di.get(t.name))?t.name+=3D"-"+n.count++:i.set(t.name,{count:1}))=
,t})}function hf(t,e,n,i){if(e=3D=3D=3Dad)for(var o=3D0;o<n.length&&o<i;o++=
)t(n[o]?n[o][0]:null,o);else for(var r=3Dn[0]||[],o=3D0;o<r.length&&o<i;o++=
)t(r[o],o)}function cf(t){t=3Dt.sourceFormat;return t=3D=3D=3Ded||t=3D=3D=
=3Dnd}yf.prototype.getSource=3Dfunction(){return this._source},yf.prototype=
.count=3Dfunction(){return 0},yf.prototype.getItem=3Dfunction(t,e){},yf.pro=
totype.appendData=3Dfunction(t){},yf.prototype.clean=3Dfunction(){},yf.prot=
oInitialize=3D((nc=3Dyf.prototype).pure=3D!1,void(nc.persistent=3D!0)),yf.i=
nternalField=3D(nf=3Dfunction(t,e,n){var i,o=3Dn.sourceFormat,r=3Dn.seriesL=
ayoutBy,a=3Dn.startIndex,n=3Dn.dimensionsDefine;P(t,ef[Cf(o,r)]),o=3D=3D=3D=
id?(t.getItem=3Dpf,t.count=3Dff,t.fillStorage=3Ddf):(i=3Dxf(o,r),t.getItem=
=3DS(i,null,e,a,n),i=3DSf(o,r),t.count=3DS(i,null,e,a,n))},pf=3Dfunction(t,=
e){t-=3Dthis._offset,e=3De||[];for(var n=3Dthis._data,i=3Dthis._dimSize,o=
=3Di*t,r=3D0;r<i;r++)e[r]=3Dn[o+r];return e},df=3Dfunction(t,e,n,i){for(var=
 o=3Dthis._data,r=3Dthis._dimSize,a=3D0;a<r;a++){for(var s=3Di[a],l=3Dnull=
=3D=3Ds[0]?1/0:s[0],u=3Dnull=3D=3Ds[1]?-1/0:s[1],h=3De-t,c=3Dn[a],p=3D0;p<h=
;p++){var d=3Do[p*r+a];(c[t+p]=3Dd)<l&&(l=3Dd),u<d&&(u=3Dd)}s[0]=3Dl,s[1]=
=3Du}},ff=3Dfunction(){return this._data?this._data.length/this._dimSize:0}=
,(nc=3D{})[td+"_"+rd]=3D{pure:!0,appendData:mf},nc[td+"_"+ad]=3D{pure:!0,ap=
pendData:function(){throw new Error('Do not support appendData when set ser=
iesLayoutBy: "row".')}},nc[ed]=3D{pure:!0,appendData:mf},nc[nd]=3D{pure:!0,=
appendData:function(t){var o=3Dthis._data;E(t,function(t,e){for(var n=3Do[e=
]||(o[e]=3D[]),i=3D0;i<(t||[]).length;i++)n.push(t[i])})}},nc[Jp]=3D{append=
Data:mf},nc[id]=3D{persistent:!1,pure:!0,appendData:function(t){this._data=
=3Dt},clean:function(){this._offset+=3Dthis.count(),this._data=3Dnull}},voi=
d(ef=3Dnc));var pf,df,ff,gf=3Dyf;function yf(t,e){var t=3Drf(t)?t:sf(t),n=
=3D(this._source=3Dt,this._data=3Dt.data);t.sourceFormat=3D=3D=3Did&&(this.=
_offset=3D0,this._dimSize=3De,this._data=3Dn),nf(this,n,t)}function mf(t){f=
or(var e=3D0;e<t.length;e++)this._data.push(t[e])}function vf(t,e,n,i){retu=
rn t[i]}(op=3D{})[td+"_"+rd]=3Dfunction(t,e,n,i){return t[i+e]},op[td+"_"+a=
d]=3Dfunction(t,e,n,i,o){i+=3De;for(var r=3Do||[],a=3Dt,s=3D0;s<a.length;s+=
+){var l=3Da[s];r[s]=3Dl?l[i]:null}return r},op[ed]=3Dvf,op[nd]=3Dfunction(=
t,e,n,i,o){for(var r=3Do||[],a=3D0;a<n.length;a++){var s=3Dt[n[a].name];r[a=
]=3Ds?s[i]:null}return r},op[Jp]=3Dvf;var _f=3Dop;function xf(t,e){return _=
f[Cf(t,e)]}function wf(t,e,n){return t.length}(Rc=3D{})[td+"_"+rd]=3Dfuncti=
on(t,e,n){return Math.max(0,t.length-e)},Rc[td+"_"+ad]=3Dfunction(t,e,n){t=
=3Dt[0];return t?Math.max(0,t.length-e):0},Rc[ed]=3Dwf,Rc[nd]=3Dfunction(t,=
e,n){t=3Dt[n[0].name];return t?t.length:0},Rc[Jp]=3Dwf;var bf=3DRc;function=
 Sf(t,e){return bf[Cf(t,e)]}function Mf(t,e,n){return t[e]}(ea=3D{})[td]=3D=
Mf,ea[ed]=3Dfunction(t,e,n){return t[n]},ea[nd]=3DMf,ea[Jp]=3Dfunction(t,e,=
n){t=3DTr(t);return t instanceof Array?t[e]:t},ea[id]=3DMf;var Tf=3Dea;func=
tion If(t){return Tf[t]}function Cf(t,e){return t=3D=3D=3Dtd?t+"_"+e:t}func=
tion Df(t,e,n){if(t){var i,o,e=3Dt.getRawDataItem(e);if(null!=3De)return i=
=3D(o=3Dt.getStore()).getSource().sourceFormat,null!=3Dn?(t=3Dt.getDimensio=
nIndex(n),n=3Do.getDimensionProperty(t),If(i)(e,t,n)):(o=3De,i=3D=3D=3DJp?T=
r(e):o)}}var kf=3D/\{@(.+?)\}/g,Bc=3D(Af.prototype.getDataParams=3Dfunction=
(t,e){var n=3Dthis.getData(e),i=3Dthis.getRawValue(t,e),o=3Dn.getRawIndex(t=
),r=3Dn.getName(t),a=3Dn.getRawDataItem(t),s=3Dn.getItemVisual(t,"style"),t=
=3Ds&&s[n.getItemVisual(t,"drawType")||"fill"],s=3Ds&&s.stroke,l=3Dthis.mai=
nType,u=3D"series"=3D=3D=3Dl,n=3Dn.userOutput&&n.userOutput.get();return{co=
mponentType:l,componentSubType:this.subType,componentIndex:this.componentIn=
dex,seriesType:u?this.subType:null,seriesIndex:this.seriesIndex,seriesId:u?=
this.id:null,seriesName:u?this.name:null,name:r,dataIndex:o,data:a,dataType=
:e,value:i,color:t,borderColor:s,dimensionNames:n?n.fullDimensions:null,enc=
ode:n?n.encode:null,$vars:["seriesName","name","value"]}},Af.prototype.getF=
ormattedLabel=3Dfunction(i,t,e,n,o,r){t=3Dt||"normal";var a=3Dthis.getData(=
e),e=3Dthis.getDataParams(i,e);return r&&(e.value=3Dr.interpolatedValue),nu=
ll!=3Dn&&V(e.value)&&(e.value=3De.value[n]),D(o=3Do||a.getItemModel(i).get(=
"normal"=3D=3D=3Dt?["label","formatter"]:[t,"label","formatter"]))?(e.statu=
s=3Dt,e.dimensionIndex=3Dn,o(e)):H(o)?Pp(o,e).replace(kf,function(t,e){var =
n=3De.length,n=3D("["=3D=3D=3De.charAt(0)&&"]"=3D=3D=3De.charAt(n-1)&&(e=3D=
+e.slice(1,n-1)),Df(a,i,e));return null!=3D(n=3Dr&&V(r.interpolatedValue)&&=
0<=3D(e=3Da.getDimensionIndex(e))?r.interpolatedValue[e]:n)?n+"":""}):void =
0},Af.prototype.getRawValue=3Dfunction(t,e){return Df(this.getData(e),t)},A=
f.prototype.formatTooltip=3Dfunction(t,e,n){},Af);function Af(){}function L=
f(t){var e,n;return O(t)?t.type&&(n=3Dt):e=3Dt,{text:e,frag:n}}function Pf(=
t){return new Of(t)}Rf.prototype.perform=3Dfunction(t){var e,n=3Dthis._upst=
ream,i=3Dt&&t.skip;this._dirty&&n&&((r=3Dthis.context).data=3Dr.outputData=
=3Dn.context.outputData),this.__pipeline&&(this.__pipeline.currentTask=3Dth=
is),this._plan&&!i&&(e=3Dthis._plan(this.context));var o,r=3Du(this._modBy)=
,a=3Dthis._modDataCount||0,s=3Du(t&&t.modBy),l=3Dt&&t.modDataCount||0;funct=
ion u(t){return t=3D1<=3Dt?t:1}r=3D=3D=3Ds&&a=3D=3D=3Dl||(e=3D"reset"),!thi=
s._dirty&&"reset"!=3D=3De||(this._dirty=3D!1,o=3Dthis._doReset(i)),this._mo=
dBy=3Ds,this._modDataCount=3Dl;r=3Dt&&t.step;if(this._dueEnd=3Dn?n._outputD=
ueEnd:this._count?this._count(this.context):1/0,this._progress){var h=3Dthi=
s._dueIndex,c=3DMath.min(null!=3Dr?this._dueIndex+r:1/0,this._dueEnd);if(!i=
&&(o||h<c)){var p=3Dthis._progress;if(V(p))for(var d=3D0;d<p.length;d++)thi=
s._doProgress(p[d],h,c,s,l);else this._doProgress(p,h,c,s,l)}this._dueIndex=
=3Dc;a=3Dnull!=3Dthis._settedOutputEnd?this._settedOutputEnd:c;this._output=
DueEnd=3Da}else this._dueIndex=3Dthis._outputDueEnd=3Dnull!=3Dthis._settedO=
utputEnd?this._settedOutputEnd:this._dueEnd;return this.unfinished()},Rf.pr=
ototype.dirty=3Dfunction(){this._dirty=3D!0,this._onDirty&&this._onDirty(th=
is.context)},Rf.prototype._doProgress=3Dfunction(t,e,n,i,o){Hf.reset(e,n,i,=
o),this._callingProgress=3Dt,this._callingProgress({start:e,end:n,count:n-e=
,next:Hf.next},this.context)},Rf.prototype._doReset=3Dfunction(t){this._due=
Index=3Dthis._outputDueEnd=3Dthis._dueEnd=3D0,this._settedOutputEnd=3Dnull,=
!t&&this._reset&&((e=3Dthis._reset(this.context))&&e.progress&&(n=3De.force=
FirstProgress,e=3De.progress),V(e))&&!e.length&&(e=3Dnull),this._progress=
=3De,this._modBy=3Dthis._modDataCount=3Dnull;var e,n,t=3Dthis._downstream;r=
eturn t&&t.dirty(),n},Rf.prototype.unfinished=3Dfunction(){return this._pro=
gress&&this._dueIndex<this._dueEnd},Rf.prototype.pipe=3Dfunction(t){this._d=
ownstream=3D=3D=3Dt&&!this._dirty||((this._downstream=3Dt)._upstream=3Dthis=
,t.dirty())},Rf.prototype.dispose=3Dfunction(){this._disposed||(this._upstr=
eam&&(this._upstream._downstream=3Dnull),this._downstream&&(this._downstrea=
m._upstream=3Dnull),this._dirty=3D!1,this._disposed=3D!0)},Rf.prototype.get=
Upstream=3Dfunction(){return this._upstream},Rf.prototype.getDownstream=3Df=
unction(){return this._downstream},Rf.prototype.setOutputEnd=3Dfunction(t){=
this._outputDueEnd=3Dthis._settedOutputEnd=3Dt};var Of=3DRf;function Rf(t){=
this._reset=3D(t=3Dt||{}).reset,this._plan=3Dt.plan,this._count=3Dt.count,t=
his._onDirty=3Dt.onDirty,this._dirty=3D!0}var Nf,Ef,zf,Bf,Ff,Vf,Hf=3DVf=3D{=
reset:function(t,e,n,i){Ef=3Dt,Nf=3De,zf=3Dn,Bf=3Di,Ff=3DMath.ceil(Bf/zf),V=
f.next=3D1<zf&&0<Bf?Gf:Wf}};function Wf(){return Ef<Nf?Ef++:null}function G=
f(){var t=3DEf%Ff*zf+Math.ceil(Ef/Ff),t=3DNf<=3DEf?null:t<Bf?t:Ef;return Ef=
++,t}function Xf(t,e){e=3De&&e.type;return"ordinal"=3D=3D=3De?t:null=3D=3D(=
t=3D"time"!=3D=3De||W(t)||null=3D=3Dt||"-"=3D=3D=3Dt?t:+cr(t))||""=3D=3D=3D=
t?NaN:+t}var Uf=3DN({number:function(t){return parseFloat(t)},time:function=
(t){return+cr(t)},trim:function(t){return H(t)?Mt(t):t}});function Yf(t){re=
turn Uf.get(t)}var Zf=3D{lt:function(t,e){return t<e},lte:function(t,e){ret=
urn t<=3De},gt:function(t,e){return e<t},gte:function(t,e){return e<=3Dt}},=
qf=3D($f.prototype.evaluate=3Dfunction(t){return W(t)?this._opFn(t,this._rv=
alFloat):this._opFn(gr(t),this._rvalFloat)},$f),jf=3D(Kf.prototype.evaluate=
=3Dfunction(t,e){var n=3DW(t)?t:gr(t),i=3DW(e)?e:gr(e),o=3DisNaN(n),r=3DisN=
aN(i);return o&&(n=3Dthis._incomparable),r&&(i=3Dthis._incomparable),o&&r&&=
(o=3DH(t),r=3DH(e),o&&(n=3Dr?t:0),r)&&(i=3Do?e:0),n<i?this._resultLT:i<n?-t=
his._resultLT:0},Kf);function Kf(t,e){t=3D"desc"=3D=3D=3Dt;this._resultLT=
=3Dt?1:-1,this._incomparable=3D"min"=3D=3D=3D(e=3Dnull=3D=3De?t?"min":"max"=
:e)?-1/0:1/0}function $f(t,e){W(e)||f(""),this._opFn=3DZf[t],this._rvalFloa=
t=3Dgr(e)}Jf.prototype.evaluate=3Dfunction(t){var e,n=3Dt=3D=3D=3Dthis._rva=
l;return n||(e=3Dtypeof t)=3D=3D=3Dthis._rvalTypeof||"number"!=3De&&"number=
"!=3D=3Dthis._rvalTypeof||(n=3Dgr(t)=3D=3D=3Dthis._rvalFloat),this._isEQ?n:=
!n};var Qf=3DJf;function Jf(t,e){this._rval=3De,this._isEQ=3Dt,this._rvalTy=
peof=3Dtypeof e,this._rvalFloat=3Dgr(e)}eg.prototype.getRawData=3Dfunction(=
){throw new Error("not supported")},eg.prototype.getRawDataItem=3Dfunction(=
t){throw new Error("not supported")},eg.prototype.cloneRawData=3Dfunction()=
{},eg.prototype.getDimensionInfo=3Dfunction(t){},eg.prototype.cloneAllDimen=
sionInfo=3Dfunction(){},eg.prototype.count=3Dfunction(){},eg.prototype.retr=
ieveValue=3Dfunction(t,e){},eg.prototype.retrieveValueFromItem=3Dfunction(t=
,e){},eg.prototype.convertValue=3DXf;var tg=3Deg;function eg(){}function ng=
(t){return lg(t.sourceFormat)||f(""),t.data}function ig(t){var e=3Dt.source=
Format,n=3Dt.data;if(lg(e)||f(""),e=3D=3D=3Dtd){for(var i=3D[],o=3D0,r=3Dn.=
length;o<r;o++)i.push(n[o].slice());return i}if(e=3D=3D=3Ded){for(i=3D[],o=
=3D0,r=3Dn.length;o<r;o++)i.push(P({},n[o]));return i}}function og(t,e,n){i=
f(null!=3Dn)return W(n)||!isNaN(n)&&!Et(e,n)?t[n]:Et(e,n)?e[n]:void 0}funct=
ion rg(t){return y(t)}var ag=3DN();function sg(t,e){var n=3Dbr(t),t=3Dn.len=
gth;t||f("");for(var i=3D0,o=3Dt;i<o;i++)e=3Dfunction(t,i){i.length||f(""),=
O(t)||f("");var e=3Dt.type,d=3Dag.get(e),e=3D(d||f(""),F(i,function(t){var =
e=3Dt,t=3Dd,n=3Dnew tg,i=3De.data,o=3Dn.sourceFormat=3De.sourceFormat,r=3De=
.startIndex,a=3D(e.seriesLayoutBy!=3D=3Drd&&f(""),[]),s=3D{};if(h=3De.dimen=
sionsDefine)E(h,function(t,e){var n=3Dt.name,e=3D{index:e,name:n,displayNam=
e:t.displayName};a.push(e),null!=3Dn&&(Et(s,n)&&f(""),s[n]=3De)});else for(=
var l=3D0;l<e.dimensionsDetectedCount;l++)a.push({index:l});var u=3Dxf(o,rd=
),h=3D(t.__isBuiltIn&&(n.getRawDataItem=3Dfunction(t){return u(i,r,a,t)},n.=
getRawData=3DS(ng,null,e)),n.cloneRawData=3DS(ig,null,e),Sf(o,rd)),c=3D(n.c=
ount=3DS(h,null,i,r,a),If(o)),p=3D(n.retrieveValue=3Dfunction(t,e){t=3Du(i,=
r,a,t);return p(t,e)},n.retrieveValueFromItem=3Dfunction(t,e){var n;return =
null!=3Dt&&(n=3Da[e])?c(t,e,n.name):void 0});return n.getDimensionInfo=3DS(=
og,null,a,s),n.cloneAllDimensionInfo=3DS(rg,null,a),n}));return F(br(d.tran=
sform({upstream:e[0],upstreamList:e,config:y(t.config)})),function(t,e){O(t=
)||f(""),t.data||f(""),lg(lf(t.data))||f("");var n=3Di[0],e=3Dn&&0=3D=3D=3D=
e&&!t.dimensions?((e=3Dn.startIndex)&&(t.data=3Dn.data.slice(0,e).concat(t.=
data)),{seriesLayoutBy:rd,sourceHeader:e,dimensions:n.metaRawOption.dimensi=
ons}):{seriesLayoutBy:rd,sourceHeader:0,dimensions:t.dimensions};return af(=
t.data,e,null)})}(n[i],e),i!=3D=3Do-1&&(e.length=3DMath.max(e.length,1));re=
turn e}function lg(t){return t=3D=3D=3Dtd||t=3D=3D=3Ded}var ug,nc=3D"undefi=
ned",hg=3Dtypeof Uint32Array=3D=3Dnc?Array:Uint32Array,cg=3Dtypeof Uint16Ar=
ray=3D=3Dnc?Array:Uint16Array,pg=3Dtypeof Int32Array=3D=3Dnc?Array:Int32Arr=
ay,op=3Dtypeof Float64Array=3D=3Dnc?Array:Float64Array,dg=3D{float:op,int:p=
g,ordinal:Array,number:Array,time:op};function fg(t){return 65535<t?hg:cg}f=
unction gg(){return[1/0,-1/0]}function yg(t,e,n,i,o){n=3Ddg[n||"float"];if(=
o){var r=3Dt[e],a=3Dr&&r.length;if(a!=3D=3Di){for(var s=3Dnew n(i),l=3D0;l<=
a;l++)s[l]=3Dr[l];t[e]=3Ds}}else t[e]=3Dnew n(i)}l.prototype.initData=3Dfun=
ction(t,e,n){this._provider=3Dt,this._chunks=3D[],this._indices=3Dnull,this=
.getRawIndex=3Dthis._getRawIdxIdentity;var i=3Dt.getSource(),o=3Dthis.defau=
ltDimValueGetter=3Dug[i.sourceFormat];this._dimValueGetter=3Dn||o,this._raw=
Extent=3D[],cf(i),this._dimensions=3DF(e,function(t){return{type:t.type,pro=
perty:t.property}}),this._initDataFromProvider(0,t.count())},l.prototype.ge=
tProvider=3Dfunction(){return this._provider},l.prototype.getSource=3Dfunct=
ion(){return this._provider.getSource()},l.prototype.ensureCalculationDimen=
sion=3Dfunction(t,e){var n=3Dthis._calcDimNameToIdx,i=3Dthis._dimensions,o=
=3Dn.get(t);if(null!=3Do){if(i[o].type=3D=3D=3De)return o}else o=3Di.length=
;return i[o]=3D{type:e},n.set(t,o),this._chunks[o]=3Dnew dg[e||"float"](thi=
s._rawCount),this._rawExtent[o]=3Dgg(),o},l.prototype.collectOrdinalMeta=3D=
function(t,e){var n=3Dthis._chunks[t],i=3Dthis._dimensions[t],o=3Dthis._raw=
Extent,r=3Di.ordinalOffset||0,a=3Dn.length;0=3D=3D=3Dr&&(o[t]=3Dgg());for(v=
ar s=3Do[t],l=3Dr;l<a;l++){var u=3Dn[l]=3De.parseAndCollect(n[l]);isNaN(u)|=
|(s[0]=3DMath.min(u,s[0]),s[1]=3DMath.max(u,s[1]))}i.ordinalMeta=3De,i.ordi=
nalOffset=3Da,i.type=3D"ordinal"},l.prototype.getOrdinalMeta=3Dfunction(t){=
return this._dimensions[t].ordinalMeta},l.prototype.getDimensionProperty=3D=
function(t){t=3Dthis._dimensions[t];return t&&t.property},l.prototype.appen=
dData=3Dfunction(t){var e=3Dthis._provider,n=3Dthis.count(),t=3D(e.appendDa=
ta(t),e.count());return e.persistent||(t+=3Dn),n<t&&this._initDataFromProvi=
der(n,t,!0),[n,t]},l.prototype.appendValues=3Dfunction(t,e){for(var n=3Dthi=
s._chunks,i=3Dthis._dimensions,o=3Di.length,r=3Dthis._rawExtent,a=3Dthis.co=
unt(),s=3Da+Math.max(t.length,e||0),l=3D0;l<o;l++)yg(n,l,(d=3Di[l]).type,s,=
!0);for(var u=3D[],h=3Da;h<s;h++)for(var c=3Dh-a,p=3D0;p<o;p++){var d=3Di[p=
],f=3Dug.arrayRows.call(this,t[c]||u,d.property,c,p),g=3D(n[p][h]=3Df,r[p])=
;f<g[0]&&(g[0]=3Df),f>g[1]&&(g[1]=3Df)}return{start:a,end:this._rawCount=3D=
this._count=3Ds}},l.prototype._initDataFromProvider=3Dfunction(t,e,n){for(v=
ar i=3Dthis._provider,o=3Dthis._chunks,r=3Dthis._dimensions,a=3Dr.length,s=
=3Dthis._rawExtent,l=3DF(r,function(t){return t.property}),u=3D0;u<a;u++){v=
ar h=3Dr[u];s[u]||(s[u]=3Dgg()),yg(o,u,h.type,e,n)}if(i.fillStorage)i.fillS=
torage(t,e,o,s);else for(var c=3D[],p=3Dt;p<e;p++)for(var c=3Di.getItem(p,c=
),d=3D0;d<a;d++){var f=3Do[d],g=3Dthis._dimValueGetter(c,l[d],p,d),f=3D(f[p=
]=3Dg,s[d]);g<f[0]&&(f[0]=3Dg),g>f[1]&&(f[1]=3Dg)}!i.persistent&&i.clean&&i=
.clean(),this._rawCount=3Dthis._count=3De,this._extent=3D[]},l.prototype.co=
unt=3Dfunction(){return this._count},l.prototype.get=3Dfunction(t,e){return=
 0<=3De&&e<this._count&&(t=3Dthis._chunks[t])?t[this.getRawIndex(e)]:NaN},l=
.prototype.getValues=3Dfunction(t,e){var n=3D[],i=3D[];if(null=3D=3De){e=3D=
t,t=3D[];for(var o=3D0;o<this._dimensions.length;o++)i.push(o)}else i=3Dt;f=
or(var o=3D0,r=3Di.length;o<r;o++)n.push(this.get(i[o],e));return n},l.prot=
otype.getByRawIndex=3Dfunction(t,e){return 0<=3De&&e<this._rawCount&&(t=3Dt=
his._chunks[t])?t[e]:NaN},l.prototype.getSum=3Dfunction(t){var e=3D0;if(thi=
s._chunks[t])for(var n=3D0,i=3Dthis.count();n<i;n++){var o=3Dthis.get(t,n);=
isNaN(o)||(e+=3Do)}return e},l.prototype.getMedian=3Dfunction(t){var e=3D[]=
,t=3D(this.each([t],function(t){isNaN(t)||e.push(t)}),e.sort(function(t,e){=
return t-e})),n=3Dthis.count();return 0=3D=3D=3Dn?0:n%2=3D=3D1?t[(n-1)/2]:(=
t[n/2]+t[n/2-1])/2},l.prototype.indexOfRawIndex=3Dfunction(t){if(!(t>=3Dthi=
s._rawCount||t<0)){if(!this._indices)return t;var e=3Dthis._indices,n=3De[t=
];if(null!=3Dn&&n<this._count&&n=3D=3D=3Dt)return t;for(var i=3D0,o=3Dthis.=
_count-1;i<=3Do;){var r=3D(i+o)/2|0;if(e[r]<t)i=3D1+r;else{if(!(e[r]>t))ret=
urn r;o=3Dr-1}}}return-1},l.prototype.indicesOfNearest=3Dfunction(t,e,n){va=
r i=3Dthis._chunks[t],o=3D[];if(i){null=3D=3Dn&&(n=3D1/0);for(var r=3D1/0,a=
=3D-1,s=3D0,l=3D0,u=3Dthis.count();l<u;l++){var h=3De-i[this.getRawIndex(l)=
],c=3DMath.abs(h);c<=3Dn&&((c<r||c=3D=3D=3Dr&&0<=3Dh&&a<0)&&(r=3Dc,a=3Dh,s=
=3D0),h=3D=3D=3Da)&&(o[s++]=3Dl)}o.length=3Ds}return o},l.prototype.getIndi=
ces=3Dfunction(){var t=3Dthis._indices;if(t){var e=3Dt.constructor,n=3Dthis=
._count;if(e=3D=3D=3DArray)for(var i=3Dnew e(n),o=3D0;o<n;o++)i[o]=3Dt[o];e=
lse i=3Dnew e(t.buffer,0,n)}else for(i=3Dnew(e=3Dfg(this._rawCount))(this.c=
ount()),o=3D0;o<i.length;o++)i[o]=3Do;return i},l.prototype.filter=3Dfuncti=
on(t,e){if(!this._count)return this;for(var n=3Dthis.clone(),i=3Dn.count(),=
o=3Dnew(fg(n._rawCount))(i),r=3D[],a=3Dt.length,s=3D0,l=3Dt[0],u=3Dn._chunk=
s,h=3D0;h<i;h++){var c=3Dvoid 0,p=3Dn.getRawIndex(h);if(0=3D=3D=3Da)c=3De(h=
);else if(1=3D=3D=3Da)c=3De(u[l][p],h);else{for(var d=3D0;d<a;d++)r[d]=3Du[=
t[d]][p];r[d]=3Dh,c=3De.apply(null,r)}c&&(o[s++]=3Dp)}return s<i&&(n._indic=
es=3Do),n._count=3Ds,n._extent=3D[],n._updateGetRawIdx(),n},l.prototype.sel=
ectRange=3Dfunction(t){var e=3Dthis.clone(),n=3De._count;if(!n)return this;=
var i=3Dht(t),o=3Di.length;if(!o)return this;var r=3De.count(),a=3Dnew(fg(e=
._rawCount))(r),s=3D0,l=3Di[0],u=3Dt[l][0],h=3Dt[l][1],c=3De._chunks,l=3D!1=
;if(!e._indices){var p=3D0;if(1=3D=3D=3Do){for(var d=3Dc[i[0]],f=3D0;f<n;f+=
+)((v=3Dd[f])>=3Du&&v<=3Dh||isNaN(v))&&(a[s++]=3Dp),p++;l=3D!0}else if(2=3D=
=3D=3Do){for(var d=3Dc[i[0]],g=3Dc[i[1]],y=3Dt[i[1]][0],m=3Dt[i[1]][1],f=3D=
0;f<n;f++){var v=3Dd[f],_=3Dg[f];(u<=3Dv&&v<=3Dh||isNaN(v))&&(y<=3D_&&_<=3D=
m||isNaN(_))&&(a[s++]=3Dp),p++}l=3D!0}}if(!l)if(1=3D=3D=3Do)for(f=3D0;f<r;f=
++){var x=3De.getRawIndex(f);((v=3Dc[i[0]][x])>=3Du&&v<=3Dh||isNaN(v))&&(a[=
s++]=3Dx)}else for(f=3D0;f<r;f++){for(var w=3D!0,b=3D(x=3De.getRawIndex(f),=
0);b<o;b++){var S=3Di[b];((v=3Dc[S][x])<t[S][0]||v>t[S][1])&&(w=3D!1)}w&&(a=
[s++]=3De.getRawIndex(f))}return s<r&&(e._indices=3Da),e._count=3Ds,e._exte=
nt=3D[],e._updateGetRawIdx(),e},l.prototype.map=3Dfunction(t,e){var n=3Dthi=
s.clone(t);return this._updateDims(n,t,e),n},l.prototype.modify=3Dfunction(=
t,e){this._updateDims(this,t,e)},l.prototype._updateDims=3Dfunction(t,e,n){=
for(var i=3Dt._chunks,o=3D[],r=3De.length,a=3Dt.count(),s=3D[],l=3Dt._rawEx=
tent,u=3D0;u<e.length;u++)l[e[u]]=3Dgg();for(var h=3D0;h<a;h++){for(var c=
=3Dt.getRawIndex(h),p=3D0;p<r;p++)s[p]=3Di[e[p]][c];s[r]=3Dh;var d=3Dn&&n.a=
pply(null,s);if(null!=3Dd)for("object"!=3Dtypeof d&&(o[0]=3Dd,d=3Do),u=3D0;=
u<d.length;u++){var f=3De[u],g=3Dd[u],y=3Dl[f],f=3Di[f];f&&(f[c]=3Dg),g<y[0=
]&&(y[0]=3Dg),g>y[1]&&(y[1]=3Dg)}}},l.prototype.lttbDownSample=3Dfunction(t=
,e){var n,i=3Dthis.clone([t],!0),o=3Di._chunks[t],r=3Dthis.count(),a=3D0,s=
=3DMath.floor(1/e),l=3Dthis.getRawIndex(0),u=3Dnew(fg(this._rawCount))(Math=
.min(2*(Math.ceil(r/s)+2),r));u[a++]=3Dl;for(var h=3D1;h<r-1;h+=3Ds){for(va=
r c=3DMath.min(h+s,r-1),p=3DMath.min(h+2*s,r),d=3D(p+c)/2,f=3D0,g=3Dc;g<p;g=
++){var y=3Do[M=3Dthis.getRawIndex(g)];isNaN(y)||(f+=3Dy)}f/=3Dp-c;for(var =
c=3Dh,m=3DMath.min(h+s,r),v=3Dh-1,_=3Do[l],x=3D-1,w=3Dc,b=3D-1,S=3D0,g=3Dc;=
g<m;g++){var M,y=3Do[M=3Dthis.getRawIndex(g)];isNaN(y)?(S++,b<0&&(b=3DM)):(=
n=3DMath.abs((v-d)*(y-_)-(v-g)*(f-_)))>x&&(x=3Dn,w=3DM)}0<S&&S<m-c&&(u[a++]=
=3DMath.min(b,w),w=3DMath.max(b,w)),l=3Du[a++]=3Dw}return u[a++]=3Dthis.get=
RawIndex(r-1),i._count=3Da,i._indices=3Du,i.getRawIndex=3Dthis._getRawIdx,i=
},l.prototype.downSample=3Dfunction(t,e,n,i){for(var o=3Dthis.clone([t],!0)=
,r=3Do._chunks,a=3D[],s=3DMath.floor(1/e),l=3Dr[t],u=3Dthis.count(),h=3Do._=
rawExtent[t]=3Dgg(),c=3Dnew(fg(this._rawCount))(Math.ceil(u/s)),p=3D0,d=3D0=
;d<u;d+=3Ds){u-d<s&&(a.length=3Ds=3Du-d);for(var f=3D0;f<s;f++){var g=3Dthi=
s.getRawIndex(d+f);a[f]=3Dl[g]}var y=3Dn(a),m=3Dthis.getRawIndex(Math.min(d=
+i(a,y)||0,u-1));(l[m]=3Dy)<h[0]&&(h[0]=3Dy),y>h[1]&&(h[1]=3Dy),c[p++]=3Dm}=
return o._count=3Dp,o._indices=3Dc,o._updateGetRawIdx(),o},l.prototype.each=
=3Dfunction(t,e){if(this._count)for(var n=3Dt.length,i=3Dthis._chunks,o=3D0=
,r=3Dthis.count();o<r;o++){var a=3Dthis.getRawIndex(o);switch(n){case 0:e(o=
);break;case 1:e(i[t[0]][a],o);break;case 2:e(i[t[0]][a],i[t[1]][a],o);brea=
k;default:for(var s=3D0,l=3D[];s<n;s++)l[s]=3Di[t[s]][a];l[s]=3Do,e.apply(n=
ull,l)}}},l.prototype.getDataExtent=3Dfunction(t){var e=3Dthis._chunks[t],n=
=3Dgg();if(!e)return n;var i,o=3Dthis.count();if(!this._indices)return this=
._rawExtent[t].slice();if(i=3Dthis._extent[t])return i.slice();for(var r=3D=
(i=3Dn)[0],a=3Di[1],s=3D0;s<o;s++){var l=3De[this.getRawIndex(s)];l<r&&(r=
=3Dl),a<l&&(a=3Dl)}return this._extent[t]=3Di=3D[r,a]},l.prototype.getRawDa=
taItem=3Dfunction(t){var e=3Dthis.getRawIndex(t);if(this._provider.persiste=
nt)return this._provider.getItem(e);for(var n=3D[],i=3Dthis._chunks,o=3D0;o=
<i.length;o++)n.push(i[o][e]);return n},l.prototype.clone=3Dfunction(t,e){v=
ar n,i,o=3Dnew l,r=3Dthis._chunks,a=3Dt&&lt(t,function(t,e){return t[e]=3D!=
0,t},{});if(a)for(var s=3D0;s<r.length;s++)o._chunks[s]=3Da[s]?(n=3Dr[s],i=
=3Dvoid 0,(i=3Dn.constructor)=3D=3D=3DArray?n.slice():new i(n)):r[s];else o=
._chunks=3Dr;return this._copyCommonProps(o),e||(o._indices=3Dthis._cloneIn=
dices()),o._updateGetRawIdx(),o},l.prototype._copyCommonProps=3Dfunction(t)=
{t._count=3Dthis._count,t._rawCount=3Dthis._rawCount,t._provider=3Dthis._pr=
ovider,t._dimensions=3Dthis._dimensions,t._extent=3Dy(this._extent),t._rawE=
xtent=3Dy(this._rawExtent)},l.prototype._cloneIndices=3Dfunction(){if(this.=
_indices){var t=3Dthis._indices.constructor,e=3Dvoid 0;if(t=3D=3D=3DArray)f=
or(var n=3Dthis._indices.length,e=3Dnew t(n),i=3D0;i<n;i++)e[i]=3Dthis._ind=
ices[i];else e=3Dnew t(this._indices);return e}return null},l.prototype._ge=
tRawIdxIdentity=3Dfunction(t){return t},l.prototype._getRawIdx=3Dfunction(t=
){return t<this._count&&0<=3Dt?this._indices[t]:-1},l.prototype._updateGetR=
awIdx=3Dfunction(){this.getRawIndex=3Dthis._indices?this._getRawIdx:this._g=
etRawIdxIdentity},l.internalField=3Dvoid(ug=3D{arrayRows:vg,objectRows:func=
tion(t,e,n,i){return Xf(t[e],this._dimensions[i])},keyedColumns:vg,original=
:function(t,e,n,i){t=3Dt&&(null=3D=3Dt.value?t:t.value);return Xf(t instanc=
eof Array?t[i]:t,this._dimensions[i])},typedArray:function(t,e,n,i){return =
t[i]}});var mg=3Dl;function l(){this._chunks=3D[],this._rawExtent=3D[],this=
._extent=3D[],this._count=3D0,this._rawCount=3D0,this._calcDimNameToIdx=3DN=
()}function vg(t,e,n,i){return Xf(t[i],this._dimensions[i])}xg.prototype.di=
rty=3Dfunction(){this._setLocalSource([],[]),this._storeList=3D[],this._dir=
ty=3D!0},xg.prototype._setLocalSource=3Dfunction(t,e){this._sourceList=3Dt,=
this._upstreamSignList=3De,this._versionSignBase++,9e10<this._versionSignBa=
se&&(this._versionSignBase=3D0)},xg.prototype._getVersionSign=3Dfunction(){=
return this._sourceHost.uid+"_"+this._versionSignBase},xg.prototype.prepare=
Source=3Dfunction(){this._isDirty()&&(this._createSource(),this._dirty=3D!1=
)},xg.prototype._createSource=3Dfunction(){this._setLocalSource([],[]);var =
t,e,n,i,o,r,a,s=3Dthis._sourceHost,l=3Dthis._getUpstreamSourceManagers(),u=
=3D!!l.length;bg(s)?(i=3Ds,o=3Dt=3Dr=3Dvoid 0,e=3Du?((e=3Dl[0]).prepareSour=
ce(),r=3D(o=3De.getSource()).data,t=3Do.sourceFormat,[e._getVersionSign()])=
:(t=3Ddt(r=3Di.get("data",!0))?id:Jp,[]),i=3Dthis._getSourceMetaRawOption()=
||{},o=3Do&&o.metaRawOption||{},a=3DR(i.seriesLayoutBy,o.seriesLayoutBy)||n=
ull,n=3DR(i.sourceHeader,o.sourceHeader),i=3DR(i.dimensions,o.dimensions),o=
=3Da!=3D=3Do.seriesLayoutBy||!!n!=3D!!o.sourceHeader||i?[af(r,{seriesLayout=
By:a,sourceHeader:n,dimensions:i},t)]:[]):(r=3Ds,e=3Du?(o=3D(a=3Dthis._appl=
yTransform(l)).sourceList,a.upstreamSignList):(o=3D[af(r.get("source",!0),t=
his._getSourceMetaRawOption(),null)],[])),this._setLocalSource(o,e)},xg.pro=
totype._applyTransform=3Dfunction(t){var e,n=3Dthis._sourceHost,i=3Dn.get("=
transform",!0),o=3Dn.get("fromTransformResult",!0),r=3D(null!=3Do&&1!=3D=3D=
t.length&&Sg(""),[]),a=3D[];return E(t,function(t){t.prepareSource();var e=
=3Dt.getSource(o||0);null=3D=3Do||e||Sg(""),r.push(e),a.push(t._getVersionS=
ign())}),i?e=3Dsg(i,r,n.componentIndex):null!=3Do&&(e=3D[new of({data:(t=3D=
r[0]).data,sourceFormat:t.sourceFormat,seriesLayoutBy:t.seriesLayoutBy,dime=
nsionsDefine:y(t.dimensionsDefine),startIndex:t.startIndex,dimensionsDetect=
edCount:t.dimensionsDetectedCount})]),{sourceList:e,upstreamSignList:a}},xg=
.prototype._isDirty=3Dfunction(){if(this._dirty)return!0;for(var t=3Dthis._=
getUpstreamSourceManagers(),e=3D0;e<t.length;e++){var n=3Dt[e];if(n._isDirt=
y()||this._upstreamSignList[e]!=3D=3Dn._getVersionSign())return!0}},xg.prot=
otype.getSource=3Dfunction(t){var e=3Dthis._sourceList[t=3Dt||0];return e||=
(e=3Dthis._getUpstreamSourceManagers())[0]&&e[0].getSource(t)},xg.prototype=
.getSharedDataStore=3Dfunction(t){var e=3Dt.makeStoreSchema();return this._=
innerGetDataStore(e.dimensions,t.source,e.hash)},xg.prototype._innerGetData=
Store=3Dfunction(t,e,n){var i,o=3Dthis._storeList,r=3Do[0],o=3D(r=3Dr||(o[0=
]=3D{}))[n];return o||(i=3Dthis._getUpstreamSourceManagers()[0],bg(this._so=
urceHost)&&i?o=3Di._innerGetDataStore(t,e,n):(o=3Dnew mg).initData(new gf(e=
,t.length),t),r[n]=3Do),o},xg.prototype._getUpstreamSourceManagers=3Dfuncti=
on(){var t,e=3Dthis._sourceHost;return bg(e)?(t=3Dcd(e))?[t.getSourceManage=
r()]:[]:F((t=3De).get("transform",!0)||t.get("fromTransformResult",!0)?Vr(t=
.ecModel,"dataset",{index:t.get("fromDatasetIndex",!0),id:t.get("fromDatase=
tId",!0)},Br).models:[],function(t){return t.getSourceManager()})},xg.proto=
type._getSourceMetaRawOption=3Dfunction(){var t,e,n,i=3Dthis._sourceHost;re=
turn bg(i)?(t=3Di.get("seriesLayoutBy",!0),e=3Di.get("sourceHeader",!0),n=
=3Di.get("dimensions",!0)):this._getUpstreamSourceManagers().length||(t=3D(=
i=3Di).get("seriesLayoutBy",!0),e=3Di.get("sourceHeader",!0),n=3Di.get("dim=
ensions",!0)),{seriesLayoutBy:t,sourceHeader:e,dimensions:n}};var _g=3Dxg;f=
unction xg(t){this._sourceList=3D[],this._storeList=3D[],this._upstreamSign=
List=3D[],this._versionSignBase=3D0,this._dirty=3D!0,this._sourceHost=3Dt}f=
unction wg(t){t.option.transform&&It(t.option.transform)}function bg(t){ret=
urn"series"=3D=3D=3Dt.mainType}function Sg(t){throw new Error(t)}var Mg=3D"=
line-height:1";function Tg(t,e){var n=3Dt.color||"#6e7079",i=3Dt.fontSize||=
12,o=3Dt.fontWeight||"400",r=3Dt.color||"#464646",a=3Dt.fontSize||14,t=3Dt.=
fontWeight||"900";return"html"=3D=3D=3De?{nameStyle:"font-size:"+me(i+"")+"=
px;color:"+me(n)+";font-weight:"+me(o+""),valueStyle:"font-size:"+me(a+"")+=
"px;color:"+me(r)+";font-weight:"+me(t+"")}:{nameStyle:{fontSize:i,fill:n,f=
ontWeight:o},valueStyle:{fontSize:a,fill:r,fontWeight:t}}}var Ig=3D[0,10,20=
,30],Cg=3D["","\n","\n\n","\n\n\n"];function Dg(t,e){return e.type=3Dt,e}fu=
nction kg(t){return"section"=3D=3D=3Dt.type}function Ag(t){return kg(t)?Lg:=
Pg}function Lg(i,o,t,r){var n,e=3Do.noHeader,a=3D(l=3Dfunction n(t){var i,e=
,o;return kg(t)?(i=3D0,e=3Dt.blocks.length,o=3D1<e||0<e&&!t.noHeader,E(t.bl=
ocks,function(t){var e=3Dn(t);i<=3De&&(i=3De+ +(o&&(!e||kg(t)&&!t.noHeader)=
))}),i):0}(o),{html:Ig[l],richText:Cg[l]}),s=3D[],l=3Do.blocks||[],u=3D(St(=
!l||V(l)),l=3Dl||[],i.orderMode),h=3D(o.sortBlocks&&u&&(l=3Dl.slice(),Et(h=
=3D{valueAsc:"asc",valueDesc:"desc"},u)?(n=3Dnew jf(h[u],null),l.sort(funct=
ion(t,e){return n.evaluate(t.sortParam,e.sortParam)})):"seriesDesc"=3D=3D=
=3Du&&l.reverse()),E(l,function(t,e){var n=3Do.valueFormatter,n=3DAg(t)(n?P=
(P({},i),{valueFormatter:n}):i,t,0<e?a.html:0,r);null!=3Dn&&s.push(n)}),"ri=
chText"=3D=3D=3Di.renderMode?s.join(a.richText):Rg(s.join(""),e?t:a.html));=
return e?h:(u=3Dkp(o.header,"ordinal",i.useUTC),l=3DTg(r,i.renderMode).name=
Style,"richText"=3D=3D=3Di.renderMode?Ng(i,u,l)+a.richText+h:Rg('<div style=
=3D"'+l+";"+Mg+';">'+me(u)+"</div>"+h,t))}function Pg(t,e,n,i){var o,r,a,s,=
l=3Dt.renderMode,u=3De.noName,h=3De.noValue,c=3D!e.markerType,p=3De.name,d=
=3Dt.useUTC,f=3De.valueFormatter||t.valueFormatter||function(t){return F(t=
=3DV(t)?t:[t],function(t,e){return kp(t,V(r)?r[e]:r,d)})};if(!u||!h)return =
o=3Dc?"":t.markupStyleCreator.makeTooltipMarker(e.markerType,e.markerColor|=
|"#333",l),p=3Du?"":kp(p,"ordinal",d),r=3De.valueType,f=3Dh?[]:f(e.value,e.=
dataIndex),e=3D!c||!u,a=3D!c&&u,i=3DTg(i,l),s=3Di.nameStyle,i=3Di.valueStyl=
e,"richText"=3D=3D=3Dl?(c?"":o)+(u?"":Ng(t,p,s))+(h?"":function(t,e,n,i,o){=
o=3D[o],i=3Di?10:20;return n&&o.push({padding:[0,0,0,i],align:"right"}),t.m=
arkupStyleCreator.wrapRichTextStyle(V(e)?e.join("  "):e,o)}(t,f,e,a,i)):Rg(=
(c?"":o)+(u?"":'<span style=3D"'+s+";"+(!c?"margin-left:2px":"")+'">'+me(p)=
+"</span>")+(h?"":function(t,e,n,i){e=3De?"float:right;margin-left:"+(n?"10=
px":"20px"):"";return t=3DV(t)?t:[t],'<span style=3D"'+e+";"+i+'">'+F(t,me)=
.join("&nbsp;&nbsp;")+"</span>"}(f,e,a,i)),n)}function Og(t,e,n,i,o,r){if(t=
)return Ag(t)({useUTC:o,renderMode:n,orderMode:i,markupStyleCreator:e,value=
Formatter:t.valueFormatter},t,0,r)}function Rg(t,e){return'<div style=3D"ma=
rgin: '+e+"px 0 0;"+Mg+';">'+t+'<div style=3D"clear:both"></div></div>'}fun=
ction Ng(t,e,n){return t.markupStyleCreator.wrapRichTextStyle(e,n)}function=
 Eg(t,e){t=3Dt.get("padding");return null!=3Dt?t:"richText"=3D=3D=3De?[8,10=
]:10}Bg.prototype._generateStyleName=3Dfunction(){return"__EC_aUTo_"+this._=
nextStyleNameId++},Bg.prototype.makeTooltipMarker=3Dfunction(t,e,n){var i=
=3D"richText"=3D=3D=3Dn?this._generateStyleName():null,e=3DOp({color:e,type=
:t,renderMode:n,markerId:i});return H(e)?e:(this.richTextStyles[i]=3De.styl=
e,e.content)},Bg.prototype.wrapRichTextStyle=3Dfunction(t,e){var n=3D{},e=
=3D(V(e)?E(e,function(t){return P(n,t)}):P(n,e),this._generateStyleName());=
return this.richTextStyles[e]=3Dn,"{"+e+"|"+t+"}"};var zg=3DBg;function Bg(=
){this.richTextStyles=3D{},this._nextStyleNameId=3Dmr()}function Fg(t){var =
e,n,i,o,r,a,s,l,u,h,c,p=3Dt.series,d=3Dt.dataIndex,t=3Dt.multipleSeries,f=
=3Dp.getData(),g=3Df.mapDimensionsAll("defaultedTooltip"),y=3Dg.length,m=3D=
p.getRawValue(d),v=3DV(m),_=3D(_=3Dd,Rp((w=3Dp).getData().getItemVisual(_,"=
style")[w.visualDrawType]));function x(t,e){e=3Ds.getDimensionInfo(e);e&&!1=
!=3D=3De.otherDims.tooltip&&(l?c.push(Dg("nameValue",{markerType:"subItem",=
markerColor:a,name:e.displayName,value:t,valueType:e.type})):(u.push(t),h.p=
ush(e.type)))}1<y||v&&!y?(w=3Dm,o=3Dd,r=3Dg,a=3D_,s=3Dp.getData(),l=3Dlt(w,=
function(t,e,n){n=3Ds.getDimensionInfo(n);return t||n&&!1!=3D=3Dn.tooltip&&=
null!=3Dn.displayName},!1),u=3D[],h=3D[],c=3D[],r.length?E(r,function(t){x(=
Df(s,o,t),t)}):E(w,x),e=3D(r=3D{inlineValues:u,inlineValueTypes:h,blocks:c}=
).inlineValueTypes,n=3Dr.blocks,i=3D(r=3Dr.inlineValues)[0]):y?(w=3Df.getDi=
mensionInfo(g[0]),i=3Dr=3DDf(f,d,g[0]),e=3Dw.type):i=3Dr=3Dv?m[0]:m;var y=
=3DAr(p),g=3Dy&&p.name||"",w=3Df.getName(d),v=3Dt?g:w;return Dg("section",{=
header:g,noHeader:t||!y,sortParam:i,blocks:[Dg("nameValue",{markerType:"ite=
m",markerColor:_,name:v,noName:!Mt(v),value:r,valueType:e,dataIndex:d})].co=
ncat(n||[])})}var Vg=3DRr();function Hg(t,e){return t.getName(e)||t.getId(e=
)}u(s,Wg=3Dg),s.prototype.init=3Dfunction(t,e,n){this.seriesIndex=3Dthis.co=
mponentIndex,this.dataTask=3DPf({count:Ug,reset:Yg}),this.dataTask.context=
=3D{model:this},this.mergeDefaultAndTheme(t,n),(Vg(this).sourceManager=3Dne=
w _g(this)).prepareSource();t=3Dthis.getInitialData(t,n);qg(t,this),this.da=
taTask.context.data=3Dt,Vg(this).dataBeforeProcessed=3Dt,Xg(this),this._ini=
tSelectedMapFromData(t)},s.prototype.mergeDefaultAndTheme=3Dfunction(t,e){v=
ar n=3DHp(this),i=3Dn?Gp(t):{},o=3Dthis.subType;g.hasClass(o),d(t,e.getThem=
e().get(this.subType)),d(t,this.getDefaultOption()),Sr(t,"label",["show"]),=
this.fillDataTextStyle(t.data),n&&Wp(t,i,n)},s.prototype.mergeOption=3Dfunc=
tion(t,e){t=3Dd(this.option,t,!0),this.fillDataTextStyle(t.data);var n=3DHp=
(this),n=3D(n&&Wp(this.option,t,n),Vg(this).sourceManager),n=3D(n.dirty(),n=
.prepareSource(),this.getInitialData(t,e));qg(n,this),this.dataTask.dirty()=
,this.dataTask.context.data=3Dn,Vg(this).dataBeforeProcessed=3Dn,Xg(this),t=
his._initSelectedMapFromData(n)},s.prototype.fillDataTextStyle=3Dfunction(t=
){if(t&&!dt(t))for(var e=3D["show"],n=3D0;n<t.length;n++)t[n]&&t[n].label&&=
Sr(t[n],"label",e)},s.prototype.getInitialData=3Dfunction(t,e){},s.prototyp=
e.appendData=3Dfunction(t){this.getRawData().appendData(t.data)},s.prototyp=
e.getData=3Dfunction(t){var e=3DKg(this);return e?(e=3De.context.data,null=
=3D=3Dt?e:e.getLinkedData(t)):Vg(this).data},s.prototype.getAllData=3Dfunct=
ion(){var t=3Dthis.getData();return t&&t.getLinkedDataAll?t.getLinkedDataAl=
l():[{data:t}]},s.prototype.setData=3Dfunction(t){var e,n=3DKg(this);n&&((e=
=3Dn.context).outputData=3Dt,n!=3D=3Dthis.dataTask)&&(e.data=3Dt),Vg(this).=
data=3Dt},s.prototype.getEncode=3Dfunction(){var t=3Dthis.get("encode",!0);=
if(t)return N(t)},s.prototype.getSourceManager=3Dfunction(){return Vg(this)=
.sourceManager},s.prototype.getSource=3Dfunction(){return this.getSourceMan=
ager().getSource()},s.prototype.getRawData=3Dfunction(){return Vg(this).dat=
aBeforeProcessed},s.prototype.getColorBy=3Dfunction(){return this.get("colo=
rBy")||"series"},s.prototype.isColorBySeries=3Dfunction(){return"series"=3D=
=3D=3Dthis.getColorBy()},s.prototype.getBaseAxis=3Dfunction(){var t=3Dthis.=
coordinateSystem;return t&&t.getBaseAxis&&t.getBaseAxis()},s.prototype.form=
atTooltip=3Dfunction(t,e,n){return Fg({series:this,dataIndex:t,multipleSeri=
es:e})},s.prototype.isAnimationEnabled=3Dfunction(){var t=3Dthis.ecModel;re=
turn!!(!b.node||t&&t.ssr)&&!!(t=3D(t=3Dthis.getShallow("animation"))&&this.=
getData().count()>this.getShallow("animationThreshold")?!1:t)},s.prototype.=
restoreData=3Dfunction(){this.dataTask.dirty()},s.prototype.getColorFromPal=
ette=3Dfunction(t,e,n){var i=3Dthis.ecModel;return yd.prototype.getColorFro=
mPalette.call(this,t,e,n)||i.getColorFromPalette(t,e,n)},s.prototype.coordD=
imToDataDim=3Dfunction(t){return this.getRawData().mapDimensionsAll(t)},s.p=
rototype.getProgressive=3Dfunction(){return this.get("progressive")},s.prot=
otype.getProgressiveThreshold=3Dfunction(){return this.get("progressiveThre=
shold")},s.prototype.select=3Dfunction(t,e){this._innerSelect(this.getData(=
e),t)},s.prototype.unselect=3Dfunction(t,e){var n=3Dthis.option.selectedMap=
;if(n){var i=3Dthis.option.selectedMode,o=3Dthis.getData(e);if("series"=3D=
=3D=3Di||"all"=3D=3D=3Dn)this.option.selectedMap=3D{},this._selectedDataInd=
icesMap=3D{};else for(var r=3D0;r<t.length;r++){var a=3DHg(o,t[r]);n[a]=3D!=
1,this._selectedDataIndicesMap[a]=3D-1}}},s.prototype.toggleSelect=3Dfuncti=
on(t,e){for(var n=3D[],i=3D0;i<t.length;i++)n[0]=3Dt[i],this.isSelected(t[i=
],e)?this.unselect(n,e):this.select(n,e)},s.prototype.getSelectedDataIndice=
s=3Dfunction(){if("all"=3D=3D=3Dthis.option.selectedMap)return[].slice.call=
(this.getData().getIndices());for(var t=3Dthis._selectedDataIndicesMap,e=3D=
ht(t),n=3D[],i=3D0;i<e.length;i++){var o=3Dt[e[i]];0<=3Do&&n.push(o)}return=
 n},s.prototype.isSelected=3Dfunction(t,e){var n=3Dthis.option.selectedMap;=
return!!n&&(e=3Dthis.getData(e),"all"=3D=3D=3Dn||n[Hg(e,t)])&&!e.getItemMod=
el(t).get(["select","disabled"])},s.prototype.isUniversalTransitionEnabled=
=3Dfunction(){var t;return!!this.__universalTransitionEnabled||!!(t=3Dthis.=
option.universalTransition)&&(!0=3D=3D=3Dt||t&&t.enabled)},s.prototype._inn=
erSelect=3Dfunction(t,e){var n,i=3Dthis.option,o=3Di.selectedMode,r=3De.len=
gth;if(o&&r)if("series"=3D=3D=3Do)i.selectedMap=3D"all";else if("multiple"=
=3D=3D=3Do){O(i.selectedMap)||(i.selectedMap=3D{});for(var a=3Di.selectedMa=
p,s=3D0;s<r;s++){var l=3De[s];a[n=3DHg(t,l)]=3D!0,this._selectedDataIndices=
Map[n]=3Dt.getRawIndex(l)}}else"single"!=3D=3Do&&!0!=3D=3Do||(n=3DHg(t,o=3D=
e[r-1]),i.selectedMap=3D((i=3D{})[n]=3D!0,i),this._selectedDataIndicesMap=
=3D((i=3D{})[n]=3Dt.getRawIndex(o),i))},s.prototype._initSelectedMapFromDat=
a=3Dfunction(n){var i;this.option.selectedMap||(i=3D[],n.hasItemOption&&n.e=
ach(function(t){var e=3Dn.getRawDataItem(t);e&&e.selected&&i.push(t)}),0<i.=
length&&this._innerSelect(n,i))},s.registerClass=3Dfunction(t){return g.reg=
isterClass(t)},s.protoInitialize=3D((Rc=3Ds.prototype).type=3D"series.__bas=
e__",Rc.seriesIndex=3D0,Rc.ignoreStyleOnData=3D!1,Rc.hasSymbolVisual=3D!1,R=
c.defaultSymbol=3D"circle",Rc.visualStyleAccessPath=3D"itemStyle",void(Rc.v=
isualDrawType=3D"fill"));var Wg,Gg=3Ds;function s(){var t=3Dnull!=3D=3DWg&&=
Wg.apply(this,arguments)||this;return t._selectedDataIndicesMap=3D{},t}func=
tion Xg(t){var e,n,i=3Dt.name;Ar(t)||(t.name=3D(t=3D(e=3D(t=3Dt).getRawData=
()).mapDimensionsAll("seriesName"),n=3D[],E(t,function(t){t=3De.getDimensio=
nInfo(t);t.displayName&&n.push(t.displayName)}),n.join(" ")||i))}function U=
g(t){return t.model.getRawData().count()}function Yg(t){t=3Dt.model;return =
t.setData(t.getRawData().cloneShallow()),Zg}function Zg(t,e){e.outputData&&=
t.end>e.outputData.count()&&e.model.getRawData().cloneShallow(e.outputData)=
}function qg(e,n){E(Ot(e.CHANGABLE_METHODS,e.DOWNSAMPLE_METHODS),function(t=
){e.wrapMethod(t,M(jg,n))})}function jg(t,e){t=3DKg(t);return t&&t.setOutpu=
tEnd((e||this).count()),e}function Kg(t){var e,n=3D(t.ecModel||{}).schedule=
r,n=3Dn&&n.getPipeline(t.uid);if(n)return(n=3Dn.currentTask)&&(e=3Dn.agentS=
tubMap)?e.get(t.uid):n}at(Gg,Bc),at(Gg,yd),qr(Gg,g);Qg.prototype.init=3Dfun=
ction(t,e){},Qg.prototype.render=3Dfunction(t,e,n,i){},Qg.prototype.dispose=
=3Dfunction(t,e){},Qg.prototype.updateView=3Dfunction(t,e,n,i){},Qg.prototy=
pe.updateLayout=3Dfunction(t,e,n,i){},Qg.prototype.updateVisual=3Dfunction(=
t,e,n,i){},Qg.prototype.toggleBlurSeries=3Dfunction(t,e,n){},Qg.prototype.e=
achRendered=3Dfunction(t){var e=3Dthis.group;e&&e.traverse(t)};var $g=3DQg;=
function Qg(){this.group=3Dnew Wo,this.uid=3DXc("viewComponent")}function J=
g(){var r=3DRr();return function(t){var e=3Dr(t),t=3Dt.pipelineContext,n=3D=
!!e.large,i=3D!!e.progressiveRender,o=3De.large=3D!(!t||!t.large),e=3De.pro=
gressiveRender=3D!(!t||!t.progressiveRender);return!(n=3D=3Do&&i=3D=3De)&&"=
reset"}}Zr($g),Qr($g);var ty=3DRr(),ey=3DJg(),ny=3D(iy.prototype.init=3Dfun=
ction(t,e){},iy.prototype.render=3Dfunction(t,e,n,i){},iy.prototype.highlig=
ht=3Dfunction(t,e,n,i){t=3Dt.getData(i&&i.dataType);t&&ry(t,i,"emphasis")},=
iy.prototype.downplay=3Dfunction(t,e,n,i){t=3Dt.getData(i&&i.dataType);t&&r=
y(t,i,"normal")},iy.prototype.remove=3Dfunction(t,e){this.group.removeAll()=
},iy.prototype.dispose=3Dfunction(t,e){},iy.prototype.updateView=3Dfunction=
(t,e,n,i){this.render(t,e,n,i)},iy.prototype.updateLayout=3Dfunction(t,e,n,=
i){this.render(t,e,n,i)},iy.prototype.updateVisual=3Dfunction(t,e,n,i){this=
.render(t,e,n,i)},iy.prototype.eachRendered=3Dfunction(t){fc(this.group,t)}=
,iy.markUpdateMethod=3Dfunction(t,e){ty(t).updateMethod=3De},iy.protoInitia=
lize=3Dvoid(iy.prototype.type=3D"chart"),iy);function iy(){this.group=3Dnew=
 Wo,this.uid=3DXc("viewChart"),this.renderTask=3DPf({plan:ay,reset:sy}),thi=
s.renderTask.context=3D{view:this}}function oy(t,e,n){t&&Zl(t)&&("emphasis"=
=3D=3D=3De?kl:Al)(t,n)}function ry(e,t,n){var i,o=3DOr(e,t),r=3Dt&&null!=3D=
t.highlightKey?(t=3Dt.highlightKey,i=3Dnull=3D=3D(i=3Dtl[t])&&Js<=3D32?tl[t=
]=3DJs++:i):null;null!=3Do?E(br(o),function(t){oy(e.getItemGraphicEl(t),n,r=
)}):e.eachItemGraphicEl(function(t){oy(t,n,r)})}function ay(t){return ey(t.=
model)}function sy(t){var e=3Dt.model,n=3Dt.ecModel,i=3Dt.api,o=3Dt.payload=
,r=3De.pipelineContext.progressiveRender,t=3Dt.view,a=3Do&&ty(o).updateMeth=
od,r=3Dr?"incrementalPrepareRender":a&&t[a]?a:"render";return"render"!=3D=
=3Dr&&t[r](e,n,i,o),ly[r]}Zr(ny),Qr(ny);var ly=3D{incrementalPrepareRender:=
{progress:function(t,e){e.view.incrementalRender(t,e.model,e.ecModel,e.api,=
e.payload)}},render:{forceFirstProgress:!0,progress:function(t,e){e.view.re=
nder(e.model,e.ecModel,e.api,e.payload)}}},uy=3D"\0__throttleOriginMethod",=
hy=3D"\0__throttleRate",cy=3D"\0__throttleType";function py(t,o,r){var a,s,=
l,u,h,c=3D0,p=3D0,d=3Dnull;function f(){p=3D(new Date).getTime(),d=3Dnull,t=
.apply(l,u||[])}o=3Do||0;function e(){for(var t=3D[],e=3D0;e<arguments.leng=
th;e++)t[e]=3Darguments[e];a=3D(new Date).getTime(),l=3Dthis,u=3Dt;var n=3D=
h||o,i=3Dh||r;h=3Dnull,s=3Da-(i?c:p)-n,clearTimeout(d),i?d=3DsetTimeout(f,n=
):0<=3Ds?f():d=3DsetTimeout(f,-s),c=3Da}return e.clear=3Dfunction(){d&&(cle=
arTimeout(d),d=3Dnull)},e.debounceNextCall=3Dfunction(t){h=3Dt},e}function =
dy(t,e,n,i){var o=3Dt[e];if(o){var r=3Do[uy]||o,a=3Do[cy];if(o[hy]!=3D=3Dn|=
|a!=3D=3Di){if(null=3D=3Dn||!i)return t[e]=3Dr;(o=3Dt[e]=3Dpy(r,n,"debounce=
"=3D=3D=3Di))[uy]=3Dr,o[cy]=3Di,o[hy]=3Dn}}}function fy(t,e){var n=3Dt[e];n=
&&n[uy]&&(n.clear&&n.clear(),t[e]=3Dn[uy])}var gy=3DRr(),yy=3D{itemStyle:Jr=
(Ec,!0),lineStyle:Jr(Pc,!0)},my=3D{lineStyle:"stroke",itemStyle:"fill"};fun=
ction vy(t,e){return t.visualStyleMapper||yy[e]||(console.warn("Unknown sty=
le type '"+e+"'."),yy.itemStyle)}function _y(t,e){return t.visualDrawType||=
my[e]||(console.warn("Unknown style type '"+e+"'."),"fill")}var ea=3D{creat=
eOnAllSeries:!0,performRawSeries:!0,reset:function(o,t){var e=3Do.getData()=
,n=3Do.visualStyleAccessPath||"itemStyle",i=3Do.getModel(n),r=3Dvy(o,n)(i),=
i=3Di.getShallow("decal"),a=3D(i&&(e.setVisual("decal",i),i.dirty=3D!0),_y(=
o,n)),i=3Dr[a],s=3DD(i)?i:null,n=3D"auto"=3D=3D=3Dr.fill||"auto"=3D=3D=3Dr.=
stroke;if(r[a]&&!s&&!n||(i=3Do.getColorFromPalette(o.name,null,t.getSeriesC=
ount()),r[a]||(r[a]=3Di,e.setVisual("colorFromPalette",!0)),r.fill=3D"auto"=
=3D=3D=3Dr.fill||D(r.fill)?i:r.fill,r.stroke=3D"auto"=3D=3D=3Dr.stroke||D(r=
.stroke)?i:r.stroke),e.setVisual("style",r),e.setVisual("drawType",a),!t.is=
SeriesFiltered(o)&&s)return e.setVisual("colorFromPalette",!1),{dataEach:fu=
nction(t,e){var n=3Do.getDataParams(e),i=3DP({},r);i[a]=3Ds(n),t.setItemVis=
ual(e,"style",i)}}}},xy=3Dnew Hc,nc=3D{createOnAllSeries:!0,performRawSerie=
s:!0,reset:function(t,e){var i,o,r;if(!t.ignoreStyleOnData&&!e.isSeriesFilt=
ered(t))return e=3Dt.getData(),i=3Dt.visualStyleAccessPath||"itemStyle",o=
=3Dvy(t,i),r=3De.getVisual("drawType"),{dataEach:e.hasItemOption?function(t=
,e){var n=3Dt.getRawDataItem(e);n&&n[i]&&(xy.option=3Dn[i],n=3Do(xy),P(t.en=
sureUniqueItemVisual(e,"style"),n),xy.option.decal&&(t.setItemVisual(e,"dec=
al",xy.option.decal),xy.option.decal.dirty=3D!0),r in n)&&t.setItemVisual(e=
,"colorFromPalette",!1)}:null}}},op=3D{performRawSeries:!0,overallReset:fun=
ction(e){var i=3DN();e.eachSeries(function(t){var e,n=3Dt.getColorBy();t.is=
ColorBySeries()||(n=3Dt.type+"-"+n,(e=3Di.get(n))||i.set(n,e=3D{}),gy(t).sc=
ope=3De)}),e.eachSeries(function(i){var o,r,a,s,t,l;i.isColorBySeries()||e.=
isSeriesFiltered(i)||(o=3Di.getRawData(),r=3D{},a=3Di.getData(),s=3Dgy(i).s=
cope,t=3Di.visualStyleAccessPath||"itemStyle",l=3D_y(i,t),a.each(function(t=
){var e=3Da.getRawIndex(t);r[e]=3Dt}),o.each(function(t){var e,n=3Dr[t];a.g=
etItemVisual(n,"colorFromPalette")&&(n=3Da.ensureUniqueItemVisual(n,"style"=
),t=3Do.getName(t)||t+"",e=3Do.count(),n[l]=3Di.getColorFromPalette(t,s,e))=
}))})}},wy=3DMath.PI;Sy.prototype.restoreData=3Dfunction(t,e){t.restoreData=
(e),this._stageTaskMap.each(function(t){t=3Dt.overallTask;t&&t.dirty()})},S=
y.prototype.getPerformArgs=3Dfunction(t,e){var n,i;if(t.__pipeline)return i=
=3D(n=3Dthis._pipelineMap.get(t.__pipeline.id)).context,{step:e=3D!e&&n.pro=
gressiveEnabled&&(!i||i.progressiveRender)&&t.__idxInPipeline>n.blockIndex?=
n.step:null,modBy:null!=3D(t=3Di&&i.modDataCount)?Math.ceil(t/e):null,modDa=
taCount:t}},Sy.prototype.getPipeline=3Dfunction(t){return this._pipelineMap=
.get(t)},Sy.prototype.updateStreamModes=3Dfunction(t,e){var n=3Dthis._pipel=
ineMap.get(t.uid),i=3Dt.getData().count(),e=3Dn.progressiveEnabled&&e.incre=
mentalPrepareRender&&i>=3Dn.threshold,o=3Dt.get("large")&&i>=3Dt.get("large=
Threshold"),i=3D"mod"=3D=3D=3Dt.get("progressiveChunkMode")?i:null;t.pipeli=
neContext=3Dn.context=3D{progressiveRender:e,modDataCount:i,large:o}},Sy.pr=
ototype.restorePipelines=3Dfunction(t){var i=3Dthis,o=3Di._pipelineMap=3DN(=
);t.eachSeries(function(t){var e=3Dt.getProgressive(),n=3Dt.uid;o.set(n,{id=
:n,head:null,tail:null,threshold:t.getProgressiveThreshold(),progressiveEna=
bled:e&&!(t.preventIncremental&&t.preventIncremental()),blockIndex:-1,step:=
Math.round(e||700),count:0}),i._pipe(t,t.dataTask)})},Sy.prototype.prepareS=
tageTasks=3Dfunction(){var n=3Dthis._stageTaskMap,i=3Dthis.api.getModel(),o=
=3Dthis.api;E(this._allHandlers,function(t){var e=3Dn.get(t.uid)||n.set(t.u=
id,{});St(!(t.reset&&t.overallReset),""),t.reset&&this._createSeriesStageTa=
sk(t,e,i,o),t.overallReset&&this._createOverallStageTask(t,e,i,o)},this)},S=
y.prototype.prepareView=3Dfunction(t,e,n,i){var o=3Dt.renderTask,r=3Do.cont=
ext;r.model=3De,r.ecModel=3Dn,r.api=3Di,o.__block=3D!t.incrementalPrepareRe=
nder,this._pipe(e,o)},Sy.prototype.performDataProcessorTasks=3Dfunction(t,e=
){this._performStageTasks(this._dataProcessorHandlers,t,e,{block:!0})},Sy.p=
rototype.performVisualTasks=3Dfunction(t,e,n){this._performStageTasks(this.=
_visualHandlers,t,e,n)},Sy.prototype._performStageTasks=3Dfunction(t,s,l,u)=
{u=3Du||{};var h=3D!1,c=3Dthis;function p(t,e){return t.setDirty&&(!t.dirty=
Map||t.dirtyMap.get(e.__pipeline.id))}E(t,function(i,t){var e,n,o,r,a;u.vis=
ualType&&u.visualType!=3D=3Di.visualType||(e=3D(n=3Dc._stageTaskMap.get(i.u=
id)).seriesTaskMap,(n=3Dn.overallTask)?((r=3Dn.agentStubMap).each(function(=
t){p(u,t)&&(t.dirty(),o=3D!0)}),o&&n.dirty(),c.updatePayload(n,l),a=3Dc.get=
PerformArgs(n,u.block),r.each(function(t){t.perform(a)}),n.perform(a)&&(h=
=3D!0)):e&&e.each(function(t,e){p(u,t)&&t.dirty();var n=3Dc.getPerformArgs(=
t,u.block);n.skip=3D!i.performRawSeries&&s.isSeriesFiltered(t.context.model=
),c.updatePayload(t,l),t.perform(n)&&(h=3D!0)}))}),this.unfinished=3Dh||thi=
s.unfinished},Sy.prototype.performSeriesTasks=3Dfunction(t){var e;t.eachSer=
ies(function(t){e=3Dt.dataTask.perform()||e}),this.unfinished=3De||this.unf=
inished},Sy.prototype.plan=3Dfunction(){this._pipelineMap.each(function(t){=
var e=3Dt.tail;do{if(e.__block){t.blockIndex=3De.__idxInPipeline;break}}whi=
le(e=3De.getUpstream())})},Sy.prototype.updatePayload=3Dfunction(t,e){"rema=
in"!=3D=3De&&(t.context.payload=3De)},Sy.prototype._createSeriesStageTask=
=3Dfunction(n,t,i,o){var r=3Dthis,a=3Dt.seriesTaskMap,s=3Dt.seriesTaskMap=
=3DN(),t=3Dn.seriesType,e=3Dn.getTargetSeries;function l(t){var e=3Dt.uid,e=
=3Ds.set(e,a&&a.get(e)||Pf({plan:Dy,reset:ky,count:Py}));e.context=3D{model=
:t,ecModel:i,api:o,useClearVisual:n.isVisual&&!n.isLayout,plan:n.plan,reset=
:n.reset,scheduler:r},r._pipe(t,e)}n.createOnAllSeries?i.eachRawSeries(l):t=
?i.eachRawSeriesByType(t,l):e&&e(i,o).each(l)},Sy.prototype._createOverallS=
tageTask=3Dfunction(t,e,n,i){var o=3Dthis,r=3De.overallTask=3De.overallTask=
||Pf({reset:My}),a=3D(r.context=3D{ecModel:n,api:i,overallReset:t.overallRe=
set,scheduler:o},r.agentStubMap),s=3Dr.agentStubMap=3DN(),e=3Dt.seriesType,=
l=3Dt.getTargetSeries,u=3D!0,h=3D!1;function c(t){var e=3Dt.uid,e=3Ds.set(e=
,a&&a.get(e)||(h=3D!0,Pf({reset:Ty,onDirty:Cy})));e.context=3D{model:t,over=
allProgress:u},e.agent=3Dr,e.__block=3Du,o._pipe(t,e)}St(!t.createOnAllSeri=
es,""),e?n.eachRawSeriesByType(e,c):l?l(n,i).each(c):(u=3D!1,E(n.getSeries(=
),c)),h&&r.dirty()},Sy.prototype._pipe=3Dfunction(t,e){t=3Dt.uid,t=3Dthis._=
pipelineMap.get(t);t.head||(t.head=3De),t.tail&&t.tail.pipe(e),(t.tail=3De)=
.__idxInPipeline=3Dt.count++,e.__pipeline=3Dt},Sy.wrapStageHandler=3Dfuncti=
on(t,e){return(t=3DD(t)?{overallReset:t,seriesType:function(t){Oy=3Dnull;tr=
y{t(Ry,Ny)}catch(t){}return Oy}(t)}:t).uid=3DXc("stageHandler"),e&&(t.visua=
lType=3De),t};var by=3DSy;function Sy(t,e,n,i){this._stageTaskMap=3DN(),thi=
s.ecInstance=3Dt,this.api=3De,n=3Dthis._dataProcessorHandlers=3Dn.slice(),i=
=3Dthis._visualHandlers=3Di.slice(),this._allHandlers=3Dn.concat(i)}functio=
n My(t){t.overallReset(t.ecModel,t.api,t.payload)}function Ty(t){return t.o=
verallProgress&&Iy}function Iy(){this.agent.dirty(),this.getDownstream().di=
rty()}function Cy(){this.agent&&this.agent.dirty()}function Dy(t){return t.=
plan?t.plan(t.model,t.ecModel,t.api,t.payload):null}function ky(t){t.useCle=
arVisual&&t.data.clearAllVisual();t=3Dt.resetDefines=3Dbr(t.reset(t.model,t=
.ecModel,t.api,t.payload));return 1<t.length?F(t,function(t,e){return Ly(e)=
}):Ay}var Ay=3DLy(0);function Ly(r){return function(t,e){var n=3De.data,i=
=3De.resetDefines[r];if(i&&i.dataEach)for(var o=3Dt.start;o<t.end;o++)i.dat=
aEach(n,o);else i&&i.progress&&i.progress(t,n)}}function Py(t){return t.dat=
a.count()}var Oy,Ry=3D{},Ny=3D{};function Ey(t,e){for(var n in e.prototype)=
t[n]=3Dzt}Ey(Ry,Sd),Ey(Ny,Cd),Ry.eachSeriesByType=3DRy.eachRawSeriesByType=
=3Dfunction(t){Oy=3Dt},Ry.eachComponent=3Dfunction(t){"series"=3D=3D=3Dt.ma=
inType&&t.subType&&(Oy=3Dt.subType)};function zy(){return{axisLine:{lineSty=
le:{color:By}},splitLine:{lineStyle:{color:"#484753"}},splitArea:{areaStyle=
:{color:["rgba(255,255,255,0.02)","rgba(255,255,255,0.05)"]}},minorSplitLin=
e:{lineStyle:{color:"#20203B"}}}}var Rc=3D["#37A2DA","#32C5E9","#67E0E3","#=
9FE6B8","#FFDB5C","#ff9f7f","#fb7293","#E062AE","#E690D1","#e7bcf3","#9d96f=
5","#8378EA","#96BFFF"],Ec=3D{color:Rc,colorLayer:[["#37A2DA","#ffd85c","#f=
d7b5f"],["#37A2DA","#67E0E3","#FFDB5C","#ff9f7f","#E062AE","#9d96f5"],["#37=
A2DA","#32C5E9","#9FE6B8","#FFDB5C","#ff9f7f","#fb7293","#e7bcf3","#8378EA"=
,"#96BFFF"],Rc]},By=3D"#B9B8CE",Pc=3D"#100C2A",Rc=3D["#4992ff","#7cffb2","#=
fddd60","#ff6e76","#58d9f9","#05c091","#ff8a45","#8d48e3","#dd79ff"],Pc=3D{=
darkMode:!0,color:Rc,backgroundColor:Pc,axisPointer:{lineStyle:{color:"#817=
f91"},crossStyle:{color:"#817f91"},label:{color:"#fff"}},legend:{textStyle:=
{color:By}},textStyle:{color:By},title:{textStyle:{color:"#EEF1FA"},subtext=
Style:{color:"#B9B8CE"}},toolbox:{iconStyle:{borderColor:By}},dataZoom:{bor=
derColor:"#71708A",textStyle:{color:By},brushStyle:{color:"rgba(135,163,206=
,0.3)"},handleStyle:{color:"#353450",borderColor:"#C5CBE3"},moveHandleStyle=
:{color:"#B0B6C3",opacity:.3},fillerColor:"rgba(135,163,206,0.2)",emphasis:=
{handleStyle:{borderColor:"#91B7F2",color:"#4D587D"},moveHandleStyle:{color=
:"#636D9A",opacity:.7}},dataBackground:{lineStyle:{color:"#71708A",width:1}=
,areaStyle:{color:"#71708A"}},selectedDataBackground:{lineStyle:{color:"#87=
A3CE"},areaStyle:{color:"#87A3CE"}}},visualMap:{textStyle:{color:By}},timel=
ine:{lineStyle:{color:By},label:{color:By},controlStyle:{color:By,borderCol=
or:By}},calendar:{itemStyle:{color:Pc},dayLabel:{color:By},monthLabel:{colo=
r:By},yearLabel:{color:By}},timeAxis:zy(),logAxis:zy(),valueAxis:zy(),categ=
oryAxis:zy(),line:{symbol:"circle"},graph:{color:Rc},gauge:{title:{color:By=
},axisLine:{lineStyle:{color:[[1,"rgba(207,212,219,0.2)"]]}},axisLabel:{col=
or:By},detail:{color:"#EEF1FA"}},candlestick:{itemStyle:{color:"#f64e56",co=
lor0:"#54ea92",borderColor:"#f64e56",borderColor0:"#54ea92"}}},Fy=3D(Pc.cat=
egoryAxis.splitLine.show=3D!1,Vy.prototype.normalizeQuery=3Dfunction(t){var=
 e,a,s,l=3D{},u=3D{},h=3D{};return H(t)?(e=3DYr(t),l.mainType=3De.main||nul=
l,l.subType=3De.sub||null):(a=3D["Index","Name","Id"],s=3D{name:1,dataIndex=
:1,dataType:1},E(t,function(t,e){for(var n=3D!1,i=3D0;i<a.length;i++){var o=
=3Da[i],r=3De.lastIndexOf(o);0<r&&r=3D=3D=3De.length-o.length&&"data"!=3D=
=3D(r=3De.slice(0,r))&&(l.mainType=3Dr,l[o.toLowerCase()]=3Dt,n=3D!0)}s.has=
OwnProperty(e)&&(u[e]=3Dt,n=3D!0),n||(h[e]=3Dt)})),{cptQuery:l,dataQuery:u,=
otherQuery:h}},Vy.prototype.filter=3Dfunction(t,e){var n,i,o,r,a,s=3Dthis.e=
ventInfo;return!s||(n=3Ds.targetEl,i=3Ds.packedEvent,o=3Ds.model,s=3Ds.view=
,!o)||!s||(r=3De.cptQuery,a=3De.dataQuery,l(r,o,"mainType")&&l(r,o,"subType=
")&&l(r,o,"index","componentIndex")&&l(r,o,"name")&&l(r,o,"id")&&l(a,i,"nam=
e")&&l(a,i,"dataIndex")&&l(a,i,"dataType")&&(!s.filterForExposedEvent||s.fi=
lterForExposedEvent(t,e.otherQuery,n,i)));function l(t,e,n,i){return null=
=3D=3Dt[n]||e[i||n]=3D=3D=3Dt[n]}},Vy.prototype.afterTrigger=3Dfunction(){t=
his.eventInfo=3Dnull},Vy);function Vy(){}var Hy=3D["symbol","symbolSize","s=
ymbolRotate","symbolOffset"],Wy=3DHy.concat(["symbolKeepAspect"]),Rc=3D{cre=
ateOnAllSeries:!0,performRawSeries:!0,reset:function(a,t){var e=3Da.getData=
();if(a.legendIcon&&e.setVisual("legendIcon",a.legendIcon),a.hasSymbolVisua=
l){for(var s,n=3D{},l=3D{},i=3D!1,o=3D0;o<Hy.length;o++){var r=3DHy[o],u=3D=
a.get(r);D(u)?(i=3D!0,l[r]=3Du):n[r]=3Du}if(n.symbol=3Dn.symbol||a.defaultS=
ymbol,e.setVisual(P({legendIcon:a.legendIcon||n.symbol,symbolKeepAspect:a.g=
et("symbolKeepAspect")},n)),!t.isSeriesFiltered(a))return s=3Dht(l),{dataEa=
ch:i?function(t,e){for(var n=3Da.getRawValue(e),i=3Da.getDataParams(e),o=3D=
0;o<s.length;o++){var r=3Ds[o];t.setItemVisual(e,r,l[r](n,i))}}:null}}}},Gy=
=3D{createOnAllSeries:!0,performRawSeries:!0,reset:function(t,e){if(t.hasSy=
mbolVisual&&!e.isSeriesFiltered(t))return{dataEach:t.getData().hasItemOptio=
n?function(t,e){for(var n=3Dt.getItemModel(e),i=3D0;i<Wy.length;i++){var o=
=3DWy[i],r=3Dn.getShallow(o,!0);null!=3Dr&&t.setItemVisual(e,o,r)}}:null}}}=
;function Xy(t,e){switch(e){case"color":return t.getVisual("style")[t.getVi=
sual("drawType")];case"opacity":return t.getVisual("style").opacity;case"sy=
mbol":case"symbolSize":case"liftZ":return t.getVisual(e)}}function Uy(r,t){=
E([[r+"ToggleSelect","toggleSelect"],[r+"Select","select"],[r+"UnSelect","u=
nselect"]],function(o){t(o[0],function(t,e,n){var i;t=3DP({},t),n.dispatchA=
ction(P(t,{type:o[1],seriesIndex:(n=3Dt,i=3D[],e.eachComponent({mainType:"s=
eries",subType:r,query:n},function(t){i.push(t.seriesIndex)}),i)}))})})}fun=
ction Yy(t,e,s,n,l){var u=3Dt+e;s.isSilent(u)||n.eachComponent({mainType:"s=
eries",subType:"pie"},function(t){for(var e,n,i=3Dt.seriesIndex,o=3Dt.optio=
n.selectedMap,r=3Dl.selected,a=3D0;a<r.length;a++)r[a].seriesIndex=3D=3D=3D=
i&&(n=3DOr(e=3Dt.getData(),l.fromActionPayload),s.trigger(u,{type:u,seriesI=
d:t.id,name:V(n)?e.getName(n[0]):e.getName(n),selected:H(o)?o:P({},o)}))})}=
function Zy(t,e,n){for(var i;t&&(!e(t)||(i=3Dt,!n));)t=3Dt.__hostTarget||t.=
parent;return i}var qy=3DMath.round(9*Math.random()),jy=3D"function"=3D=3Dt=
ypeof Object.defineProperty,Ky=3D($y.prototype.get=3Dfunction(t){return thi=
s._guard(t)[this._id]},$y.prototype.set=3Dfunction(t,e){t=3Dthis._guard(t);=
return jy?Object.defineProperty(t,this._id,{value:e,enumerable:!1,configura=
ble:!0}):t[this._id]=3De,this},$y.prototype.delete=3Dfunction(t){return!!th=
is.has(t)&&(delete this._guard(t)[this._id],!0)},$y.prototype.has=3Dfunctio=
n(t){return!!this._guard(t)[this._id]},$y.prototype._guard=3Dfunction(t){if=
(t!=3D=3DObject(t))throw TypeError("Value of WeakMap is not a non-null obje=
ct.");return t},$y);function $y(){this._id=3D"__ec_inner_"+qy++}var Qy=3D_s=
.extend({type:"triangle",shape:{cx:0,cy:0,width:0,height:0},buildPath:funct=
ion(t,e){var n=3De.cx,i=3De.cy,o=3De.width/2,e=3De.height/2;t.moveTo(n,i-e)=
,t.lineTo(n+o,i+e),t.lineTo(n-o,i+e),t.closePath()}}),Jy=3D_s.extend({type:=
"diamond",shape:{cx:0,cy:0,width:0,height:0},buildPath:function(t,e){var n=
=3De.cx,i=3De.cy,o=3De.width/2,e=3De.height/2;t.moveTo(n,i-e),t.lineTo(n+o,=
i),t.lineTo(n,i+e),t.lineTo(n-o,i),t.closePath()}}),tm=3D_s.extend({type:"p=
in",shape:{x:0,y:0,width:0,height:0},buildPath:function(t,e){var n=3De.x,i=
=3De.y,o=3De.width/5*3,e=3DMath.max(o,e.height),o=3Do/2,r=3Do*o/(e-o),e=3Di=
-e+o+r,a=3DMath.asin(r/o),s=3DMath.cos(a)*o,l=3DMath.sin(a),u=3DMath.cos(a)=
,h=3D.6*o,c=3D.7*o;t.moveTo(n-s,e+r),t.arc(n,e,o,Math.PI-a,2*Math.PI+a),t.b=
ezierCurveTo(n+s-l*h,e+r+u*h,n,i-c,n,i),t.bezierCurveTo(n,i-c,n-s+l*h,e+r+u=
*h,n-s,e+r),t.closePath()}}),em=3D_s.extend({type:"arrow",shape:{x:0,y:0,wi=
dth:0,height:0},buildPath:function(t,e){var n=3De.height,i=3De.width,o=3De.=
x,e=3De.y,i=3Di/3*2;t.moveTo(o,e),t.lineTo(o+i,e+n),t.lineTo(o,e+n/4*3),t.l=
ineTo(o-i,e+n),t.lineTo(o,e),t.closePath()}}),nm=3D{line:function(t,e,n,i,o=
){o.x1=3Dt,o.y1=3De+i/2,o.x2=3Dt+n,o.y2=3De+i/2},rect:function(t,e,n,i,o){o=
.x=3Dt,o.y=3De,o.width=3Dn,o.height=3Di},roundRect:function(t,e,n,i,o){o.x=
=3Dt,o.y=3De,o.width=3Dn,o.height=3Di,o.r=3DMath.min(n,i)/4},square:functio=
n(t,e,n,i,o){n=3DMath.min(n,i);o.x=3Dt,o.y=3De,o.width=3Dn,o.height=3Dn},ci=
rcle:function(t,e,n,i,o){o.cx=3Dt+n/2,o.cy=3De+i/2,o.r=3DMath.min(n,i)/2},d=
iamond:function(t,e,n,i,o){o.cx=3Dt+n/2,o.cy=3De+i/2,o.width=3Dn,o.height=
=3Di},pin:function(t,e,n,i,o){o.x=3Dt+n/2,o.y=3De+i/2,o.width=3Dn,o.height=
=3Di},arrow:function(t,e,n,i,o){o.x=3Dt+n/2,o.y=3De+i/2,o.width=3Dn,o.heigh=
t=3Di},triangle:function(t,e,n,i,o){o.cx=3Dt+n/2,o.cy=3De+i/2,o.width=3Dn,o=
.height=3Di}},im=3D{},om=3D(E({line:nh,rect:Es,roundRect:Es,square:Es,circl=
e:mu,diamond:Jy,pin:tm,arrow:em,triangle:Qy},function(t,e){im[e]=3Dnew t}),=
_s.extend({type:"symbol",shape:{symbolType:"",x:0,y:0,width:0,height:0},cal=
culateTextPosition:function(t,e,n){var t=3Dko(t,e,n),i=3Dthis.shape;return =
i&&"pin"=3D=3D=3Di.symbolType&&"inside"=3D=3D=3De.position&&(t.y=3Dn.y+.4*n=
.height),t},buildPath:function(t,e,n){var i,o=3De.symbolType;"none"!=3D=3Do=
&&(i=3D(i=3Dim[o])||im[o=3D"rect"],nm[o](e.x,e.y,e.width,e.height,i.shape),=
i.buildPath(t,i.shape,n))}}));function rm(t,e){var n;"image"!=3D=3Dthis.typ=
e&&(n=3Dthis.style,this.__isEmptyBrush?(n.stroke=3Dt,n.fill=3De||"#fff",n.l=
ineWidth=3D2):"line"=3D=3D=3Dthis.shape.symbolType?n.stroke=3Dt:n.fill=3Dt,=
this.markRedraw())}function am(t,e,n,i,o,r,a){var s=3D0=3D=3D=3Dt.indexOf("=
empty");return(a=3D0=3D=3D=3D(t=3Ds?t.substr(5,1).toLowerCase()+t.substr(6)=
:t).indexOf("image://")?$h(t.slice(8),new G(e,n,i,o),a?"center":"cover"):0=
=3D=3D=3Dt.indexOf("path://")?Kh(t.slice(7),{},new G(e,n,i,o),a?"center":"c=
over"):new om({shape:{symbolType:t,x:e,y:n,width:i,height:o}})).__isEmptyBr=
ush=3Ds,a.setColor=3Drm,r&&a.setColor(r),a}function sm(t){return[(t=3DV(t)?=
t:[+t,+t])[0]||0,t[1]||0]}function lm(t,e){if(null!=3Dt)return[er((t=3DV(t)=
?t:[t,t])[0],e[0])||0,er(R(t[1],t[0]),e[1])||0]}function um(t){return isFin=
ite(t)}function hm(t,e,n){for(var i,o,r,a,s,l,u,h,c,p=3D"radial"=3D=3D=3De.=
type?(i=3Dt,o=3De,a=3D(r=3Dn).width,s=3Dr.height,l=3DMath.min(a,s),u=3Dnull=
=3D=3Do.x?.5:o.x,h=3Dnull=3D=3Do.y?.5:o.y,c=3Dnull=3D=3Do.r?.5:o.r,o.global=
||(u=3Du*a+r.x,h=3Dh*s+r.y,c*=3Dl),u=3Dum(u)?u:.5,h=3Dum(h)?h:.5,c=3D0<=3Dc=
&&um(c)?c:.5,i.createRadialGradient(u,h,0,u,h,c)):(o=3Dt,a=3Dn,r=3Dnull=3D=
=3D(s=3De).x?0:s.x,l=3Dnull=3D=3Ds.x2?1:s.x2,i=3Dnull=3D=3Ds.y?0:s.y,u=3Dnu=
ll=3D=3Ds.y2?0:s.y2,s.global||(r=3Dr*a.width+a.x,l=3Dl*a.width+a.x,i=3Di*a.=
height+a.y,u=3Du*a.height+a.y),r=3Dum(r)?r:0,l=3Dum(l)?l:1,i=3Dum(i)?i:0,u=
=3Dum(u)?u:0,o.createLinearGradient(r,i,l,u)),d=3De.colorStops,f=3D0;f<d.le=
ngth;f++)p.addColorStop(d[f].offset,d[f].color);return p}function cm(t){ret=
urn parseInt(t,10)}function pm(t,e,n){var i=3D["width","height"][e],o=3D["c=
lientWidth","clientHeight"][e],r=3D["paddingLeft","paddingTop"][e],e=3D["pa=
ddingRight","paddingBottom"][e];return null!=3Dn[i]&&"auto"!=3D=3Dn[i]?pars=
eFloat(n[i]):(n=3Ddocument.defaultView.getComputedStyle(t),(t[o]||cm(n[i])|=
|cm(t.style[i]))-(cm(n[r])||0)-(cm(n[e])||0)|0)}function dm(t){var e,n=3Dt.=
style,i=3Dn.lineDash&&0<n.lineWidth&&(o=3Dn.lineDash,i=3Dn.lineWidth,o&&"so=
lid"!=3D=3Do&&0<i?"dashed"=3D=3D=3Do?[4*i,2*i]:"dotted"=3D=3D=3Do?[i]:W(o)?=
[o]:V(o)?o:null:null),o=3Dn.lineDashOffset;return i&&(e=3Dn.strokeNoScale&&=
t.getLineScale?t.getLineScale():1)&&1!=3D=3De&&(i=3DF(i,function(t){return =
t/e}),o/=3De),[i,o]}var fm=3Dnew es(!0);function gm(t){var e=3Dt.stroke;ret=
urn!(null=3D=3De||"none"=3D=3D=3De||!(0<t.lineWidth))}function ym(t){return=
"string"=3D=3Dtypeof t&&"none"!=3D=3Dt}function mm(t){t=3Dt.fill;return nul=
l!=3Dt&&"none"!=3D=3Dt}function vm(t,e){var n;null!=3De.fillOpacity&&1!=3D=
=3De.fillOpacity?(n=3Dt.globalAlpha,t.globalAlpha=3De.fillOpacity*e.opacity=
,t.fill(),t.globalAlpha=3Dn):t.fill()}function _m(t,e){var n;null!=3De.stro=
keOpacity&&1!=3D=3De.strokeOpacity?(n=3Dt.globalAlpha,t.globalAlpha=3De.str=
okeOpacity*e.opacity,t.stroke(),t.globalAlpha=3Dn):t.stroke()}function xm(t=
,e,n){var n=3Doa(e.image,e.__image,n);if(aa(n))return t=3Dt.createPattern(n=
,e.repeat||"repeat"),"function"=3D=3Dtypeof DOMMatrix&&t&&t.setTransform&&(=
(n=3Dnew DOMMatrix).translateSelf(e.x||0,e.y||0),n.rotateSelf(0,0,(e.rotati=
on||0)*Bt),n.scaleSelf(e.scaleX||1,e.scaleY||1),t.setTransform(n)),t}var wm=
=3D["shadowBlur","shadowOffsetX","shadowOffsetY"],bm=3D[["lineCap","butt"],=
["lineJoin","miter"],["miterLimit",10]];function Sm(t,e,n,i,o){var r,a=3D!1=
;if(!i&&e=3D=3D=3D(n=3Dn||{}))return!1;!i&&e.opacity=3D=3D=3Dn.opacity||(Am=
(t,o),a=3D!0,r=3DMath.max(Math.min(e.opacity,1),0),t.globalAlpha=3DisNaN(r)=
?xa.opacity:r),!i&&e.blend=3D=3D=3Dn.blend||(a||(Am(t,o),a=3D!0),t.globalCo=
mpositeOperation=3De.blend||xa.blend);for(var s=3D0;s<wm.length;s++){var l=
=3Dwm[s];!i&&e[l]=3D=3D=3Dn[l]||(a||(Am(t,o),a=3D!0),t[l]=3Dt.dpr*(e[l]||0)=
)}return!i&&e.shadowColor=3D=3D=3Dn.shadowColor||(a||(Am(t,o),a=3D!0),t.sha=
dowColor=3De.shadowColor||xa.shadowColor),a}function Mm(t,e,n,i,o){var r=3D=
Lm(e,o.inHover),a=3Di?null:n&&Lm(n,o.inHover)||{};if(r!=3D=3Da){var s=3DSm(=
t,r,a,i,o);(i||r.fill!=3D=3Da.fill)&&(s||(Am(t,o),s=3D!0),ym(r.fill))&&(t.f=
illStyle=3Dr.fill),(i||r.stroke!=3D=3Da.stroke)&&(s||(Am(t,o),s=3D!0),ym(r.=
stroke))&&(t.strokeStyle=3Dr.stroke),!i&&r.opacity=3D=3D=3Da.opacity||(s||(=
Am(t,o),s=3D!0),t.globalAlpha=3Dnull=3D=3Dr.opacity?1:r.opacity),e.hasStrok=
e()&&(n=3Dr.lineWidth/(r.strokeNoScale&&e.getLineScale?e.getLineScale():1),=
t.lineWidth!=3D=3Dn)&&(s||(Am(t,o),s=3D!0),t.lineWidth=3Dn);for(var l=3D0;l=
<bm.length;l++){var u=3Dbm[l],h=3Du[0];!i&&r[h]=3D=3D=3Da[h]||(s||(Am(t,o),=
s=3D!0),t[h]=3Dr[h]||u[1])}}}function Tm(t,e){var e=3De.transform,n=3Dt.dpr=
||1;e?t.setTransform(n*e[0],n*e[1],n*e[2],n*e[3],n*e[4],n*e[5]):t.setTransf=
orm(n,0,0,n,0,0)}var Im=3D1,Cm=3D2,Dm=3D3,km=3D4;function Am(t,e){e.batchFi=
ll&&t.fill(),e.batchStroke&&t.stroke(),e.batchFill=3D"",e.batchStroke=3D""}=
function Lm(t,e){return e&&t.__hoverStyle||t.style}function Pm(t,e){Om(t,e,=
{inHover:!1,viewWidth:0,viewHeight:0},!0)}function Om(t,e,n,E){var i=3De.tr=
ansform;if(!e.shouldBePainted(n.viewWidth,n.viewHeight,!1,!1))return e.__di=
rty&=3D~mn,e.__isRendered=3D!1;var o,r,a,s,l,u,h,c,p,d,f,g,y,m,v,_,x,w,b,S,=
M,T,I,C=3De.__clipPaths,D=3Dn.prevElClipPaths,k=3D!1,A=3D!1;if(!D||function=
(t,e){if(t!=3D=3De&&(t||e)){if(!t||!e||t.length!=3D=3De.length)return 1;for=
(var n=3D0;n<t.length;n++)if(t[n]!=3D=3De[n])return 1}}(C,D)){if(D&&D.lengt=
h&&(Am(t,n),t.restore(),A=3Dk=3D!0,n.prevElClipPaths=3Dnull,n.allClipped=3D=
!1,n.prevEl=3Dnull),C&&C.length){Am(t,n),t.save();var z=3DC,B=3Dt;D=3Dn;for=
(var F=3D!1,V=3D0;V<z.length;V++){var H=3Dz[V],F=3DF||H.isZeroArea();Tm(B,H=
),B.beginPath(),H.buildPath(B,H.shape),B.clip()}D.allClipped=3DF,k=3D!0}n.p=
revElClipPaths=3DC}if(n.allClipped)e.__isRendered=3D!1;else{e.beforeBrush&&=
e.beforeBrush(),e.innerBeforeBrush();var D=3Dn.prevEl,L=3D(D||(A=3Dk=3D!0),=
e instanceof _s&&e.autoBatch&&(C=3De.style,L=3Dmm(C),I=3Dgm(C),!(C.lineDash=
||!(+L^+I)||L&&"string"!=3Dtypeof C.fill||I&&"string"!=3Dtypeof C.stroke||C=
.strokePercent<1||C.strokeOpacity<1||C.fillOpacity<1))),k=3D(k||(I=3Di,C=3D=
D.transform,I&&C?I[0]!=3D=3DC[0]||I[1]!=3D=3DC[1]||I[2]!=3D=3DC[2]||I[3]!=
=3D=3DC[3]||I[4]!=3D=3DC[4]||I[5]!=3D=3DC[5]:I||C)?(Am(t,n),Tm(t,e)):L||Am(=
t,n),Lm(e,n.inHover));if(e instanceof _s)n.lastDrawType!=3D=3DIm&&(A=3D!0,n=
.lastDrawType=3DIm),Mm(t,e,D,A,n),L&&(n.batchFill||n.batchStroke)||t.beginP=
ath(),i=3Dt,C=3De,O=3DL,y=3Dgm(a=3Dk),m=3Dmm(a),v=3Da.strokePercent,_=3Dv<1=
,x=3D!C.path,C.silent&&!_||!x||C.createPathProxy(),w=3DC.path||fm,b=3DC.__d=
irty,O||(s=3Da.fill,T=3Da.stroke,l=3Dm&&!!s.colorStops,u=3Dy&&!!T.colorStop=
s,h=3Dm&&!!s.image,c=3Dy&&!!T.image,M=3Dg=3Df=3Dd=3Dp=3Dvoid 0,(l||u)&&(M=
=3DC.getBoundingRect()),l&&(p=3Db?hm(i,s,M):C.__canvasFillGradient,C.__canv=
asFillGradient=3Dp),u&&(d=3Db?hm(i,T,M):C.__canvasStrokeGradient,C.__canvas=
StrokeGradient=3Dd),h&&(f=3Db||!C.__canvasFillPattern?xm(i,s,C):C.__canvasF=
illPattern,C.__canvasFillPattern=3Df),c&&(g=3Db||!C.__canvasStrokePattern?x=
m(i,T,C):C.__canvasStrokePattern,C.__canvasStrokePattern=3Df),l?i.fillStyle=
=3Dp:h&&(f?i.fillStyle=3Df:m=3D!1),u?i.strokeStyle=3Dd:c&&(g?i.strokeStyle=
=3Dg:y=3D!1)),M=3DC.getGlobalScale(),w.setScale(M[0],M[1],C.segmentIgnoreTh=
reshold),i.setLineDash&&a.lineDash&&(S=3D(s=3Ddm(C))[0],P=3Ds[1]),T=3D!0,(x=
||b&vn)&&(w.setDPR(i.dpr),_?w.setContext(null):(w.setContext(i),T=3D!1),w.r=
eset(),C.buildPath(w,C.shape,O),w.toStatic(),C.pathUpdated()),T&&w.rebuildP=
ath(i,_?v:1),S&&(i.setLineDash(S),i.lineDashOffset=3DP),O||(a.strokeFirst?(=
y&&_m(i,a),m&&vm(i,a)):(m&&vm(i,a),y&&_m(i,a))),S&&i.setLineDash([]),L&&(n.=
batchFill=3Dk.fill||"",n.batchStroke=3Dk.stroke||"");else if(e instanceof b=
s)n.lastDrawType!=3D=3DDm&&(A=3D!0,n.lastDrawType=3DDm),Mm(t,e,D,A,n),l=3Dt=
,p=3De,null!=3D(f=3D(h=3Dk).text)&&(f+=3D""),f&&(l.font=3Dh.font||j,l.textA=
lign=3Dh.textAlign,l.textBaseline=3Dh.textBaseline,d=3Du=3Dvoid 0,l.setLine=
Dash&&h.lineDash&&(u=3D(p=3Ddm(p))[0],d=3Dp[1]),u&&(l.setLineDash(u),l.line=
DashOffset=3Dd),h.strokeFirst?(gm(h)&&l.strokeText(f,h.x,h.y),mm(h)&&l.fill=
Text(f,h.x,h.y)):(mm(h)&&l.fillText(f,h.x,h.y),gm(h)&&l.strokeText(f,h.x,h.=
y)),u)&&l.setLineDash([]);else if(e instanceof Cs)n.lastDrawType!=3D=3DCm&&=
(A=3D!0,n.lastDrawType=3DCm),c=3DD,g=3DA,Sm(t,Lm(e,(M=3Dn).inHover),c&&Lm(c=
,M.inHover),g,M),s=3Dt,x=3Dk,(C=3D(b=3De).__image=3Doa(x.image,b.__image,b,=
b.onload))&&aa(C)&&(T=3Dx.x||0,w=3Dx.y||0,_=3Db.getWidth(),b=3Db.getHeight(=
),v=3DC.width/C.height,null=3D=3D_&&null!=3Db?_=3Db*v:null=3D=3Db&&null!=3D=
_?b=3D_/v:null=3D=3D_&&null=3D=3Db&&(_=3DC.width,b=3DC.height),x.sWidth&&x.=
sHeight?(o=3Dx.sx||0,r=3Dx.sy||0,s.drawImage(C,o,r,x.sWidth,x.sHeight,T,w,_=
,b)):x.sx&&x.sy?(v=3D_-(o=3Dx.sx),x=3Db-(r=3Dx.sy),s.drawImage(C,o,r,v,x,T,=
w,_,b)):s.drawImage(C,T,w,_,b));else if(e.getTemporalDisplayables){n.lastDr=
awType!=3D=3Dkm&&(A=3D!0,n.lastDrawType=3Dkm);{var W=3Dt;var P=3De;var O=3D=
n;var G=3DP.getDisplayables(),X=3DP.getTemporalDisplayables();W.save();var =
R,U,Y=3D{prevElClipPaths:null,prevEl:null,allClipped:!1,viewWidth:O.viewWid=
th,viewHeight:O.viewHeight,inHover:O.inHover};for(R=3DP.getCursor(),U=3DG.l=
ength;R<U;R++)(N=3DG[R]).beforeBrush&&N.beforeBrush(),N.innerBeforeBrush(),=
Om(W,N,Y,R=3D=3D=3DU-1),N.innerAfterBrush(),N.afterBrush&&N.afterBrush(),Y.=
prevEl=3DN;for(var N,Z=3D0,q=3DX.length;Z<q;Z++)(N=3DX[Z]).beforeBrush&&N.b=
eforeBrush(),N.innerBeforeBrush(),Om(W,N,Y,Z=3D=3D=3Dq-1),N.innerAfterBrush=
(),N.afterBrush&&N.afterBrush(),Y.prevEl=3DN;P.clearTemporalDisplayables(),=
P.notClear=3D!0,W.restore()}}L&&E&&Am(t,n),e.innerAfterBrush(),e.afterBrush=
&&e.afterBrush(),(n.prevEl=3De).__dirty=3D0,e.__isRendered=3D!0}}var Rm=3Dn=
ew Ky,Nm=3Dnew ti(100),Em=3D["symbol","symbolSize","symbolKeepAspect","colo=
r","backgroundColor","dashArrayX","dashArrayY","maxTileWidth","maxTileHeigh=
t"];function zm(t,e){if("none"=3D=3D=3Dt)return null;var n=3De.getDevicePix=
elRatio(),i=3De.getZr(),o=3D"svg"=3D=3D=3Di.painter.type,e=3D(t.dirty&&Rm.d=
elete(t),Rm.get(t));if(e)return e;for(var r,a=3DB(t,{symbol:"rect",symbolSi=
ze:1,symbolKeepAspect:!0,color:"rgba(0, 0, 0, 0.2)",backgroundColor:null,da=
shArrayX:5,dashArrayY:5,rotation:0,maxTileWidth:512,maxTileHeight:512}),e=
=3D("none"=3D=3D=3Da.backgroundColor&&(a.backgroundColor=3Dnull),{repeat:"r=
epeat"}),s=3De,l=3D[n],u=3D!0,h=3D0;h<Em.length;++h){var c=3Da[Em[h]];if(nu=
ll!=3Dc&&!V(c)&&!H(c)&&!W(c)&&"boolean"!=3Dtypeof c){u=3D!1;break}l.push(c)=
}u&&(r=3Dl.join(",")+(o?"-svg":""),v=3DNm.get(r))&&(o?s.svgElement=3Dv:s.im=
age=3Dv);var p,d=3Dfunction t(e){if(!e||0=3D=3D=3De.length)return[[0,0]];if=
(W(e))return[[r=3DMath.ceil(e),r]];for(var n=3D!0,i=3D0;i<e.length;++i)if(!=
W(e[i])){n=3D!1;break}if(n)return t([e]);var o=3D[];for(i=3D0;i<e.length;++=
i){var r;W(e[i])?(r=3DMath.ceil(e[i]),o.push([r,r])):(r=3DF(e[i],function(t=
){return Math.ceil(t)})).length%2=3D=3D1?o.push(r.concat(r)):o.push(r)}retu=
rn o}(a.dashArrayX),f=3Dfunction(t){if(!t||"object"=3D=3Dtypeof t&&0=3D=3D=
=3Dt.length)return[0,0];if(W(t))return[e=3DMath.ceil(t),e];var e=3DF(t,func=
tion(t){return Math.ceil(t)});return t.length%2?e.concat(e):e}(a.dashArrayY=
),g=3Dfunction t(e){if(!e||0=3D=3D=3De.length)return[["rect"]];if(H(e))retu=
rn[[e]];for(var n=3D!0,i=3D0;i<e.length;++i)if(!H(e[i])){n=3D!1;break}if(n)=
return t([e]);var o=3D[];for(i=3D0;i<e.length;++i)H(e[i])?o.push([e[i]]):o.=
push(e[i]);return o}(a.symbol),y=3DF(d,Bm),m=3DBm(f),v=3D!o&&X.createCanvas=
(),_=3Do&&{tag:"g",attrs:{},key:"dcl",children:[]},x=3Dfunction(){for(var t=
=3D1,e=3D0,n=3Dy.length;e<n;++e)t=3Dvr(t,y[e]);for(var i=3D1,e=3D0,n=3Dg.le=
ngth;e<n;++e)i=3Dvr(i,g[e].length);t*=3Di;var o=3Dm*y.length*g.length;retur=
n{width:Math.max(1,Math.min(t,a.maxTileWidth)),height:Math.max(1,Math.min(o=
,a.maxTileHeight))}}();v&&(v.width=3Dx.width*n,v.height=3Dx.height*n,p=3Dv.=
getContext("2d")),p&&(p.clearRect(0,0,v.width,v.height),a.backgroundColor)&=
&(p.fillStyle=3Da.backgroundColor,p.fillRect(0,0,v.width,v.height));for(var=
 w=3D0,b=3D0;b<f.length;++b)w+=3Df[b];if(!(w<=3D0))for(var S,M=3D-m,T=3D0,I=
=3D0,C=3D0;M<x.height;){if(T%2=3D=3D0){for(var D=3DI/2%g.length,k=3D0,A=3D0=
,L=3D0;k<2*x.width;){for(var P,O,R,E,N,z=3D0,b=3D0;b<d[C].length;++b)z+=3Dd=
[C][b];if(z<=3D0)break;A%2=3D=3D0&&(O=3D.5*(1-a.symbolSize),P=3Dk+d[C][A]*O=
,O=3DM+f[T]*O,R=3Dd[C][A]*a.symbolSize,E=3Df[T]*a.symbolSize,N=3DL/2%g[D].l=
ength,P=3DP,N=3Dg[D][N],S=3Dvoid 0,N=3Dam(N,P*(S=3Do?1:n),O*S,R*S,E*S,a.col=
or,a.symbolKeepAspect),o?(P=3Di.painter.renderOneToVNode(N))&&_.children.pu=
sh(P):Pm(p,N)),k+=3Dd[C][A],++L,++A=3D=3D=3Dd[C].length&&(A=3D0)}++C=3D=3D=
=3Dd.length&&(C=3D0)}M+=3Df[T],++I,++T=3D=3D=3Df.length&&(T=3D0)}return u&&=
Nm.put(r,v||_),s.image=3Dv,s.svgElement=3D_,s.svgWidth=3Dx.width,s.svgHeigh=
t=3Dx.height,e.rotation=3Da.rotation,e.scaleX=3De.scaleY=3Do?1:1/n,Rm.set(t=
,e),t.dirty=3D!1,e}function Bm(t){for(var e=3D0,n=3D0;n<t.length;++n)e+=3Dt=
[n];return t.length%2=3D=3D1?2*e:e}var Fm=3Dnew ae,Vm=3D{};var Jy=3D{PROCES=
SOR:{FILTER:1e3,SERIES_FILTER:800,STATISTIC:5e3},VISUAL:{LAYOUT:1e3,PROGRES=
SIVE_LAYOUT:1100,GLOBAL:2e3,CHART:3e3,POST_CHART_LAYOUT:4600,COMPONENT:4e3,=
BRUSH:5e3,CHART_ITEM:4500,ARIA:6e3,DECAL:7e3}},Hm=3D"__flagInMainProcess",W=
m=3D"__pendingUpdate",Gm=3D"__needsUpdateStatus",Xm=3D/^[a-zA-Z0-9_]+$/,Um=
=3D"__connectUpdateStatus";function Ym(n){return function(){for(var t=3D[],=
e=3D0;e<arguments.length;e++)t[e]=3Darguments[e];if(!this.isDisposed())retu=
rn qm(this,n,t);this.id}}function Zm(n){return function(){for(var t=3D[],e=
=3D0;e<arguments.length;e++)t[e]=3Darguments[e];return qm(this,n,t)}}functi=
on qm(t,e,n){return n[0]=3Dn[0]&&n[0].toLowerCase(),ae.prototype[e].apply(t=
,n)}u(g0,d0=3Dae);var jm,Km,$m,Qm,Jm,t0,e0,n0,i0,o0,r0,a0,s0,l0,u0,h0,c0,p0=
,d0,f0=3Dg0,tm=3Df0.prototype;function g0(){return null!=3D=3Dd0&&d0.apply(=
this,arguments)||this}tm.on=3DZm("on"),tm.off=3DZm("off");u(h,y0=3Dae),h.pr=
ototype._onframe=3Dfunction(){if(!this._disposed){p0(this);var t=3Dthis._sc=
heduler;if(this[Wm]){var e=3Dthis[Wm].silent;this[Hm]=3D!0;try{jm(this),Qm.=
update.call(this,null,this[Wm].updateParams)}catch(t){throw this[Hm]=3D!1,t=
his[Wm]=3Dnull,t}this._zr.flush(),this[Hm]=3D!1,this[Wm]=3Dnull,n0.call(thi=
s,e),i0.call(this,e)}else if(t.unfinished){var n=3D1,i=3Dthis._model,o=3Dth=
is._api;t.unfinished=3D!1;do{var r=3D+new Date}while(t.performSeriesTasks(i=
),t.performDataProcessorTasks(i),t0(this,i),t.performVisualTasks(i),l0(this=
,this._model,o,"remain",{}),0<(n-=3D+new Date-r)&&t.unfinished);t.unfinishe=
d||this._zr.flush()}}},h.prototype.getDom=3Dfunction(){return this._dom},h.=
prototype.getId=3Dfunction(){return this.id},h.prototype.getZr=3Dfunction()=
{return this._zr},h.prototype.isSSR=3Dfunction(){return this._ssr},h.protot=
ype.setOption=3Dfunction(t,e,n){if(!this[Hm])if(this._disposed)this.id;else=
{O(e)&&(n=3De.lazyUpdate,i=3De.silent,o=3De.replaceMerge,r=3De.transition,e=
=3De.notMerge),this[Hm]=3D!0,this._model&&!e||(e=3Dnew Od(this._api),a=3Dth=
is._theme,(s=3Dthis._model=3Dnew Sd).scheduler=3Dthis._scheduler,s.ssr=3Dth=
is._ssr,s.init(null,null,null,a,this._locale,e)),this._model.setOption(t,{r=
eplaceMerge:o},C0);var i,o,r,a,s=3D{seriesTransition:r,optionChanged:!0};if=
(n)this[Wm]=3D{silent:i,updateParams:s},this[Hm]=3D!1,this.getZr().wakeUp()=
;else{try{jm(this),Qm.update.call(this,null,s)}catch(t){throw this[Wm]=3Dnu=
ll,this[Hm]=3D!1,t}this._ssr||this._zr.flush(),this[Wm]=3Dnull,this[Hm]=3D!=
1,n0.call(this,i),i0.call(this,i)}}},h.prototype.setTheme=3Dfunction(){},h.=
prototype.getModel=3Dfunction(){return this._model},h.prototype.getOption=
=3Dfunction(){return this._model&&this._model.getOption()},h.prototype.getW=
idth=3Dfunction(){return this._zr.getWidth()},h.prototype.getHeight=3Dfunct=
ion(){return this._zr.getHeight()},h.prototype.getDevicePixelRatio=3Dfuncti=
on(){return this._zr.painter.dpr||b.hasGlobalWindow&&window.devicePixelRati=
o||1},h.prototype.getRenderedCanvas=3Dfunction(t){return this.renderToCanva=
s(t)},h.prototype.renderToCanvas=3Dfunction(t){return this._zr.painter.getR=
enderedCanvas({backgroundColor:(t=3Dt||{}).backgroundColor||this._model.get=
("backgroundColor"),pixelRatio:t.pixelRatio||this.getDevicePixelRatio()})},=
h.prototype.renderToSVGString=3Dfunction(t){return this._zr.painter.renderT=
oString({useViewBox:(t=3Dt||{}).useViewBox})},h.prototype.getSvgDataURL=3Df=
unction(){var t;if(b.svgSupported)return E((t=3Dthis._zr).storage.getDispla=
yList(),function(t){t.stopAnimation(null,!0)}),t.painter.toDataURL()},h.pro=
totype.getDataURL=3Dfunction(t){var e,n,i,o;if(!this._disposed)return o=3D(=
t=3Dt||{}).excludeComponents,e=3Dthis._model,n=3D[],i=3Dthis,E(o,function(t=
){e.eachComponent({mainType:t},function(t){t=3Di._componentsMap[t.__viewId]=
;t.group.ignore||(n.push(t),t.group.ignore=3D!0)})}),o=3D"svg"=3D=3D=3Dthis=
._zr.painter.getType()?this.getSvgDataURL():this.renderToCanvas(t).toDataUR=
L("image/"+(t&&t.type||"png")),E(n,function(t){t.group.ignore=3D!1}),o;this=
.id},h.prototype.getConnectedDataURL=3Dfunction(i){var o,r,a,s,l,u,h,c,p,e,=
t,n,d,f,g;if(!this._disposed)return o=3D"svg"=3D=3D=3Di.type,r=3Dthis.group=
,a=3DMath.min,s=3DMath.max,P0[r]?(u=3Dl=3D1/0,c=3Dh=3D-1/0,p=3D[],e=3Di&&i.=
pixelRatio||this.getDevicePixelRatio(),E(L0,function(t,e){var n;t.group=3D=
=3D=3Dr&&(n=3Do?t.getZr().painter.getSvgDom().innerHTML:t.renderToCanvas(y(=
i)),t=3Dt.getDom().getBoundingClientRect(),l=3Da(t.left,l),u=3Da(t.top,u),h=
=3Ds(t.right,h),c=3Ds(t.bottom,c),p.push({dom:n,left:t.left,top:t.top}))}),=
t=3D(h*=3De)-(l*=3De),n=3D(c*=3De)-(u*=3De),d=3DX.createCanvas(),(f=3Djo(d,=
{renderer:o?"svg":"canvas"})).resize({width:t,height:n}),o?(g=3D"",E(p,func=
tion(t){var e=3Dt.left-l,n=3Dt.top-u;g+=3D'<g transform=3D"translate('+e+",=
"+n+')">'+t.dom+"</g>"}),f.painter.getSvgRoot().innerHTML=3Dg,i.connectedBa=
ckgroundColor&&f.painter.setBackgroundColor(i.connectedBackgroundColor),f.r=
efreshImmediately(),f.painter.toDataURL()):(i.connectedBackgroundColor&&f.a=
dd(new Es({shape:{x:0,y:0,width:t,height:n},style:{fill:i.connectedBackgrou=
ndColor}})),E(p,function(t){t=3Dnew Cs({style:{x:t.left*e-l,y:t.top*e-u,ima=
ge:t.dom}});f.add(t)}),f.refreshImmediately(),d.toDataURL("image/"+(i&&i.ty=
pe||"png")))):this.getDataURL(i);this.id},h.prototype.convertToPixel=3Dfunc=
tion(t,e){return Jm(this,"convertToPixel",t,e)},h.prototype.convertFromPixe=
l=3Dfunction(t,e){return Jm(this,"convertFromPixel",t,e)},h.prototype.conta=
inPixel=3Dfunction(t,i){var o;if(!this._disposed)return E(Er(this._model,t)=
,function(t,n){0<=3Dn.indexOf("Models")&&E(t,function(t){var e=3Dt.coordina=
teSystem;e&&e.containPoint?o=3Do||!!e.containPoint(i):"seriesModels"=3D=3D=
=3Dn&&(e=3Dthis._chartsMap[t.__viewId])&&e.containPoint&&(o=3Do||e.containP=
oint(i,t))},this)},this),!!o;this.id},h.prototype.getVisual=3Dfunction(t,e)=
{var t=3DEr(this._model,t,{defaultMainType:"series"}),n=3Dt.seriesModel.get=
Data(),t=3Dt.hasOwnProperty("dataIndexInside")?t.dataIndexInside:t.hasOwnPr=
operty("dataIndex")?n.indexOfRawIndex(t.dataIndex):null;if(null=3D=3Dt)retu=
rn Xy(n,e);var i=3Dn,o=3Dt,r=3De;switch(r){case"color":return i.getItemVisu=
al(o,"style")[i.getVisual("drawType")];case"opacity":return i.getItemVisual=
(o,"style").opacity;case"symbol":case"symbolSize":case"liftZ":return i.getI=
temVisual(o,r)}},h.prototype.getViewOfComponentModel=3Dfunction(t){return t=
his._componentsMap[t.__viewId]},h.prototype.getViewOfSeriesModel=3Dfunction=
(t){return this._chartsMap[t.__viewId]},h.prototype._initEvents=3Dfunction(=
){var t,n,i,s=3Dthis;E(S0,function(a){function t(t){var n,e,i,o=3Ds.getMode=
l(),r=3Dt.target;"globalout"=3D=3D=3Da?n=3D{}:r&&Zy(r,function(t){var e,t=
=3Dk(t);return t&&null!=3Dt.dataIndex?(e=3Dt.dataModel||o.getSeriesByIndex(=
t.seriesIndex),n=3De&&e.getDataParams(t.dataIndex,t.dataType,r)||{},1):t.ev=
entData&&(n=3DP({},t.eventData),1)},!0),n&&(e=3Dn.componentType,i=3Dn.compo=
nentIndex,"markLine"!=3D=3De&&"markPoint"!=3D=3De&&"markArea"!=3D=3De||(e=
=3D"series",i=3Dn.seriesIndex),i=3D(e=3De&&null!=3Di&&o.getComponent(e,i))&=
&s["series"=3D=3D=3De.mainType?"_chartsMap":"_componentsMap"][e.__viewId],n=
.event=3Dt,n.type=3Da,s._$eventProcessor.eventInfo=3D{targetEl:r,packedEven=
t:n,model:e,view:i},s.trigger(a,n))}t.zrEventfulCallAtLast=3D!0,s._zr.on(a,=
t,s)}),E(T0,function(t,e){s._messageCenter.on(e,function(t){this.trigger(e,=
t)},s)}),E(["selectchanged"],function(e){s._messageCenter.on(e,function(t){=
this.trigger(e,t)},s)}),t=3Dthis._messageCenter,i=3D(n=3Dthis)._api,t.on("s=
electchanged",function(t){var e=3Di.getModel();t.isFromClick?(Yy("map","sel=
ectchanged",n,e,t),Yy("pie","selectchanged",n,e,t)):"select"=3D=3D=3Dt.from=
Action?(Yy("map","selected",n,e,t),Yy("pie","selected",n,e,t)):"unselect"=
=3D=3D=3Dt.fromAction&&(Yy("map","unselected",n,e,t),Yy("pie","unselected",=
n,e,t))})},h.prototype.isDisposed=3Dfunction(){return this._disposed},h.pro=
totype.clear=3Dfunction(){this._disposed?this.id:this.setOption({series:[]}=
,!0)},h.prototype.dispose=3Dfunction(){var t,e,n;this._disposed?this.id:(th=
is._disposed=3D!0,this.getDom()&&Hr(this.getDom(),N0,""),e=3D(t=3Dthis)._ap=
i,n=3Dt._model,E(t._componentsViews,function(t){t.dispose(n,e)}),E(t._chart=
sViews,function(t){t.dispose(n,e)}),t._zr.dispose(),t._dom=3Dt._model=3Dt._=
chartsMap=3Dt._componentsMap=3Dt._chartsViews=3Dt._componentsViews=3Dt._sch=
eduler=3Dt._api=3Dt._zr=3Dt._throttledZrFlush=3Dt._theme=3Dt._coordSysMgr=
=3Dt._messageCenter=3Dnull,delete L0[t.id])},h.prototype.resize=3Dfunction(=
t){if(!this[Hm])if(this._disposed)this.id;else{this._zr.resize(t);var e=3Dt=
his._model;if(this._loadingFX&&this._loadingFX.resize(),e){var e=3De.resetO=
ption("media"),n=3Dt&&t.silent;this[Wm]&&(null=3D=3Dn&&(n=3Dthis[Wm].silent=
),e=3D!0,this[Wm]=3Dnull),this[Hm]=3D!0;try{e&&jm(this),Qm.update.call(this=
,{type:"resize",animation:P({duration:0},t&&t.animation)})}catch(t){throw t=
his[Hm]=3D!1,t}this[Hm]=3D!1,n0.call(this,n),i0.call(this,n)}}},h.prototype=
.showLoading=3Dfunction(t,e){this._disposed?this.id:(O(t)&&(e=3Dt,t=3D""),t=
=3Dt||"default",this.hideLoading(),A0[t]&&(t=3DA0[t](this._api,e),e=3Dthis.=
_zr,this._loadingFX=3Dt,e.add(t)))},h.prototype.hideLoading=3Dfunction(){th=
is._disposed?this.id:(this._loadingFX&&this._zr.remove(this._loadingFX),thi=
s._loadingFX=3Dnull)},h.prototype.makeActionFromEvent=3Dfunction(t){var e=
=3DP({},t);return e.type=3DT0[t.type],e},h.prototype.dispatchAction=3Dfunct=
ion(t,e){var n;this._disposed?this.id:(O(e)||(e=3D{silent:!!e}),M0[t.type]&=
&this._model&&(this[Hm]?this._pendingActions.push(t):(n=3De.silent,e0.call(=
this,t,n),(t=3De.flush)?this._zr.flush():!1!=3D=3Dt&&b.browser.weChat&&this=
._throttledZrFlush(),n0.call(this,n),i0.call(this,n))))},h.prototype.update=
LabelLayout=3Dfunction(){Fm.trigger("series:layoutlabels",this._model,this.=
_api,{updatedSeries:[]})},h.prototype.appendData=3Dfunction(t){var e;this._=
disposed?this.id:(e=3Dt.seriesIndex,this.getModel().getSeriesByIndex(e).app=
endData(t),this._scheduler.unfinished=3D!0,this.getZr().wakeUp())},h.intern=
alField=3D(jm=3Dfunction(t){var e=3Dt._scheduler;e.restorePipelines(t._mode=
l),e.prepareStageTasks(),Km(t,!0),Km(t,!1),e.plan()},Km=3Dfunction(t,o){for=
(var r=3Dt._model,a=3Dt._scheduler,s=3Do?t._componentsViews:t._chartsViews,=
l=3Do?t._componentsMap:t._chartsMap,u=3Dt._zr,h=3Dt._api,e=3D0;e<s.length;e=
++)s[e].__alive=3D!1;function n(t){var e,n=3Dt.__requireNewView,i=3D(t.__re=
quireNewView=3D!1,"_ec_"+t.id+"_"+t.type),n=3D!n&&l[i];n||(e=3DYr(t.type),(=
n=3Dnew(o?$g.getClass(e.main,e.sub):ny.getClass(e.sub))).init(r,h),l[i]=3Dn=
,s.push(n),u.add(n.group)),t.__viewId=3Dn.__id=3Di,n.__alive=3D!0,n.__model=
=3Dt,n.group.__ecComponentInfo=3D{mainType:t.mainType,index:t.componentInde=
x},o||a.prepareView(n,t,r,h)}for(o?r.eachComponent(function(t,e){"series"!=
=3D=3Dt&&n(e)}):r.eachSeries(n),e=3D0;e<s.length;){var i=3Ds[e];i.__alive?e=
++:(o||i.renderTask.dispose(),u.remove(i.group),i.dispose(r,h),s.splice(e,1=
),l[i.__id]=3D=3D=3Di&&delete l[i.__id],i.__id=3Di.group.__ecComponentInfo=
=3Dnull)}},$m=3Dfunction(p,e,d,n,t){var i,f,o=3Dp._model;function r(t){t&&t=
.__alive&&t[e]&&t[e](t.__model,o,p._api,d)}o.setUpdatePayload(d),n?((i=3D{}=
)[n+"Id"]=3Dd[n+"Id"],i[n+"Index"]=3Dd[n+"Index"],i[n+"Name"]=3Dd[n+"Name"]=
,i=3D{mainType:n,query:i},t&&(i.subType=3Dt),null!=3D(t=3Dd.excludeSeriesId=
)&&(f=3DN(),E(br(t),function(t){t=3Dkr(t,null);null!=3Dt&&f.set(t,!0)})),o&=
&o.eachComponent(i,function(t){if(!f||null=3D=3Df.get(t.id))if(jl(d))if(t i=
nstanceof Gg){if(d.type=3D=3D=3Dll&&!d.notBlur&&!t.get(["emphasis","disable=
d"])){var e=3Dt,n=3Dd,i=3Dp._api,o=3De.seriesIndex,r=3De.getData(n.dataType=
);if(r){var n=3D(V(n=3DOr(r,n))?n[0]:n)||0,a=3Dr.getItemGraphicEl(n);if(!a)=
for(var s=3Dr.count(),l=3D0;!a&&l<s;)a=3Dr.getItemGraphicEl(l++);a?zl(o,(n=
=3Dk(a)).focus,n.blurScope,i):(n=3De.get(["emphasis","focus"]),e=3De.get(["=
emphasis","blurScope"]),null!=3Dn&&zl(o,n,e,i))}}}else n=3D(o=3DFl(t.mainTy=
pe,t.componentIndex,d.name,p._api)).focusSelf,e=3Do.dispatchers,d.type=3D=
=3D=3Dll&&n&&!d.notBlur&&Bl(t.mainType,t.componentIndex,p._api),e&&E(e,func=
tion(t){(d.type=3D=3D=3Dll?kl:Al)(t)});else ql(d)&&t instanceof Gg&&(i=3Dt,=
u=3Dd,p._api,ql(u)&&(h=3Du.dataType,V(c=3DOr(i.getData(h),u))||(c=3D[c]),i[=
u.type=3D=3D=3Dpl?"toggleSelect":u.type=3D=3D=3Dhl?"select":"unselect"](c,h=
)),Vl(t),c0(p));var u,h,c},p),o&&o.eachComponent(i,function(t){f&&null!=3Df=
.get(t.id)||r(p["series"=3D=3D=3Dn?"_chartsMap":"_componentsMap"][t.__viewI=
d])},p)):E([].concat(p._componentsViews).concat(p._chartsViews),r)},Qm=3D{p=
repareAndUpdate:function(t){jm(this),Qm.update.call(this,t,{optionChanged:n=
ull!=3Dt.newOption})},update:function(t,e){var n=3Dthis._model,i=3Dthis._ap=
i,o=3Dthis._zr,r=3Dthis._coordSysMgr,a=3Dthis._scheduler;n&&(n.setUpdatePay=
load(t),a.restoreData(n,t),a.performSeriesTasks(n),r.create(n,i),a.performD=
ataProcessorTasks(n,t),t0(this,n),r.update(n,i),v0(n),a.performVisualTasks(=
n,t),a0(this,n,i,t,e),r=3Dn.get("backgroundColor")||"transparent",a=3Dn.get=
("darkMode"),o.setBackgroundColor(r),null!=3Da&&"auto"!=3D=3Da&&o.setDarkMo=
de(a),Fm.trigger("afterupdate",n,i))},updateTransform:function(n){var i,o,r=
=3Dthis,a=3Dthis._model,s=3Dthis._api;a&&(a.setUpdatePayload(n),i=3D[],a.ea=
chComponent(function(t,e){"series"!=3D=3Dt&&(t=3Dr.getViewOfComponentModel(=
e))&&t.__alive&&(!t.updateTransform||(e=3Dt.updateTransform(e,a,s,n))&&e.up=
date)&&i.push(t)}),o=3DN(),a.eachSeries(function(t){var e=3Dr._chartsMap[t.=
__viewId];(!e.updateTransform||(e=3De.updateTransform(t,a,s,n))&&e.update)&=
&o.set(t.uid,1)}),v0(a),this._scheduler.performVisualTasks(a,n,{setDirty:!0=
,dirtyMap:o}),l0(this,a,s,n,{},o),Fm.trigger("afterupdate",a,s))},updateVie=
w:function(t){var e=3Dthis._model;e&&(e.setUpdatePayload(t),ny.markUpdateMe=
thod(t,"updateView"),v0(e),this._scheduler.performVisualTasks(e,t,{setDirty=
:!0}),a0(this,e,this._api,t,{}),Fm.trigger("afterupdate",e,this._api))},upd=
ateVisual:function(n){var i=3Dthis,o=3Dthis._model;o&&(o.setUpdatePayload(n=
),o.eachSeries(function(t){t.getData().clearAllVisual()}),ny.markUpdateMeth=
od(n,"updateVisual"),v0(o),this._scheduler.performVisualTasks(o,n,{visualTy=
pe:"visual",setDirty:!0}),o.eachComponent(function(t,e){"series"!=3D=3Dt&&(=
t=3Di.getViewOfComponentModel(e))&&t.__alive&&t.updateVisual(e,o,i._api,n)}=
),o.eachSeries(function(t){i._chartsMap[t.__viewId].updateVisual(t,o,i._api=
,n)}),Fm.trigger("afterupdate",o,this._api))},updateLayout:function(t){Qm.u=
pdate.call(this,t)}},Jm=3Dfunction(t,e,n,i){if(t._disposed)t.id;else for(va=
r o=3Dt._model,r=3Dt._coordSysMgr.getCoordinateSystems(),a=3DEr(o,n),s=3D0;=
s<r.length;s++){var l=3Dr[s];if(l[e]&&null!=3D(l=3Dl[e](o,a,i)))return l}},=
t0=3Dfunction(t,e){var n=3Dt._chartsMap,i=3Dt._scheduler;e.eachSeries(funct=
ion(t){i.updateStreamModes(t,n[t.__viewId])})},e0=3Dfunction(i,t){var o=3Dt=
his,e=3Dthis.getModel(),n=3Di.type,r=3Di.escapeConnect,a=3DM0[n],s=3Da.acti=
onInfo,l=3D(s.update||"update").split(":"),u=3Dl.pop(),h=3Dnull!=3Dl[0]&&Yr=
(l[0]),l=3D(this[Hm]=3D!0,[i]),c=3D!1;i.batch&&(c=3D!0,l=3DF(i.batch,functi=
on(t){return(t=3DB(P({},t),i)).batch=3Dnull,t}));var p=3D[],d=3Dql(i),f=3Dj=
l(i);if(f&&El(this._api),E(l,function(t){var e,n;(y=3D(y=3Da.action(t,o._mo=
del,o._api))||P({},t)).type=3Ds.event||y.type,p.push(y),f?(e=3D(n=3Dzr(i)).=
queryOptionMap,n=3Dn.mainTypeSpecified?e.keys()[0]:"series",$m(o,u,t,n),c0(=
o)):d?($m(o,u,t,"series"),c0(o)):h&&$m(o,u,t,h.main,h.sub)}),"none"!=3D=3Du=
&&!f&&!d&&!h)try{this[Wm]?(jm(this),Qm.update.call(this,i),this[Wm]=3Dnull)=
:Qm[u].call(this,i)}catch(i){throw this[Hm]=3D!1,i}var g,y=3Dc?{type:s.even=
t||n,escapeConnect:r,batch:p}:p[0];this[Hm]=3D!1,t||((l=3Dthis._messageCent=
er).trigger(y.type,y),d&&(c=3D{type:"selectchanged",escapeConnect:r,selecte=
d:(g=3D[],e.eachSeries(function(n){E(n.getAllData(),function(t){t.data;var =
t=3Dt.type,e=3Dn.getSelectedDataIndices();0<e.length&&(e=3D{dataIndex:e,ser=
iesIndex:n.seriesIndex},null!=3Dt&&(e.dataType=3Dt),g.push(e))})}),g),isFro=
mClick:i.isFromClick||!1,fromAction:i.type,fromActionPayload:i},l.trigger(c=
.type,c)))},n0=3Dfunction(t){for(var e=3Dthis._pendingActions;e.length;){va=
r n=3De.shift();e0.call(this,n,t)}},i0=3Dfunction(t){t||this.trigger("updat=
ed")},o0=3Dfunction(e,n){e.on("rendered",function(t){n.trigger("rendered",t=
),!e.animation.isFinished()||n[Wm]||n._scheduler.unfinished||n._pendingActi=
ons.length||n.trigger("finished")})},r0=3Dfunction(t,a){t.on("mouseover",fu=
nction(t){var e,n,i,o,r=3DZy(t.target,Zl);r&&(r=3Dr,e=3Dt,t=3Da._api,n=3Dk(=
r),i=3D(o=3DFl(n.componentMainType,n.componentIndex,n.componentHighDownName=
,t)).dispatchers,o=3Do.focusSelf,i?(o&&Bl(n.componentMainType,n.componentIn=
dex,t),E(i,function(t){return Cl(t,e)})):(zl(n.seriesIndex,n.focus,n.blurSc=
ope,t),"self"=3D=3D=3Dn.focus&&Bl(n.componentMainType,n.componentIndex,t),C=
l(r,e)),c0(a))}).on("mouseout",function(t){var e,n,i=3DZy(t.target,Zl);i&&(=
i=3Di,e=3Dt,El(t=3Da._api),(n=3DFl((n=3Dk(i)).componentMainType,n.component=
Index,n.componentHighDownName,t).dispatchers)?E(n,function(t){return Dl(t,e=
)}):Dl(i,e),c0(a))}).on("click",function(t){var e,t=3DZy(t.target,function(=
t){return null!=3Dk(t).dataIndex},!0);t&&(e=3Dt.selected?"unselect":"select=
",t=3Dk(t),a._api.dispatchAction({type:e,dataType:t.dataType,dataIndexInsid=
e:t.dataIndex,seriesIndex:t.seriesIndex,isFromClick:!0}))})},a0=3Dfunction(=
t,e,n,i,o){var r,a,s,l,u,h,c;u=3D[],c=3D!(h=3D[]),(r=3De).eachComponent(fun=
ction(t,e){var n=3De.get("zlevel")||0,i=3De.get("z")||0,o=3De.getZLevelKey(=
);c=3Dc||!!o,("series"=3D=3D=3Dt?h:u).push({zlevel:n,z:i,idx:e.componentInd=
ex,type:t,key:o})}),c&&(yn(l=3Du.concat(h),function(t,e){return t.zlevel=3D=
=3D=3De.zlevel?t.z-e.z:t.zlevel-e.zlevel}),E(l,function(t){var e=3Dr.getCom=
ponent(t.type,t.idx),n=3Dt.zlevel,t=3Dt.key;null!=3Da&&(n=3DMath.max(a,n)),=
t?(n=3D=3D=3Da&&t!=3D=3Ds&&n++,s=3Dt):s&&(n=3D=3D=3Da&&n++,s=3D""),a=3Dn,e.=
setZLevel(n)})),s0(t,e,n,i,o),E(t._chartsViews,function(t){t.__alive=3D!1})=
,l0(t,e,n,i,o),E(t._chartsViews,function(t){t.__alive||t.remove(e,n)})},s0=
=3Dfunction(t,n,i,o,e,r){E(r||t._componentsViews,function(t){var e=3Dt.__mo=
del;w0(0,t),t.render(e,n,i,o),x0(e,t),b0(e,t)})},l0=3Dfunction(o,t,e,r,n,a)=
{var i,s,l,u,h=3Do._scheduler,c=3D(n=3DP(n||{},{updatedSeries:t.getSeries()=
}),Fm.trigger("series:beforeupdate",t,e,n),!1);t.eachSeries(function(t){var=
 e,n=3Do._chartsMap[t.__viewId],i=3D(n.__alive=3D!0,n.renderTask);h.updateP=
ayload(i,r),w0(0,n),a&&a.get(t.uid)&&i.dirty(),i.perform(h.getPerformArgs(i=
))&&(c=3D!0),n.group.silent=3D!!t.get("silent"),i=3Dn,e=3Dt.get("blendMode"=
)||null,i.eachRendered(function(t){t.isGroup||(t.style.blend=3De)}),Vl(t)})=
,h.unfinished=3Dc||h.unfinished,Fm.trigger("series:layoutlabels",t,e,n),Fm.=
trigger("series:transition",t,e,n),t.eachSeries(function(t){var e=3Do._char=
tsMap[t.__viewId];x0(t,e),b0(t,e)}),s=3Dt,l=3D(i=3Do)._zr.storage,u=3D0,l.t=
raverse(function(t){t.isGroup||u++}),u>s.get("hoverLayerThreshold")&&!b.nod=
e&&!b.worker&&s.eachSeries(function(t){t.preventUsingHoverLayer||(t=3Di._ch=
artsMap[t.__viewId]).__alive&&t.eachRendered(function(t){t.states.emphasis&=
&(t.states.emphasis.hoverLayer=3D!0)})}),Fm.trigger("series:afterupdate",t,=
e,n)},c0=3Dfunction(t){t[Gm]=3D!0,t.getZr().wakeUp()},p0=3Dfunction(t){t[Gm=
]&&(t.getZr().storage.traverse(function(t){zh(t)||_0(t)}),t[Gm]=3D!1)},u0=
=3Dfunction(n){return u(t,e=3DCd),t.prototype.getCoordinateSystems=3Dfuncti=
on(){return n._coordSysMgr.getCoordinateSystems()},t.prototype.getComponent=
ByElement=3Dfunction(t){for(;t;){var e=3Dt.__ecComponentInfo;if(null!=3De)r=
eturn n._model.getComponent(e.mainType,e.index);t=3Dt.parent}},t.prototype.=
enterEmphasis=3Dfunction(t,e){kl(t,e),c0(n)},t.prototype.leaveEmphasis=3Dfu=
nction(t,e){Al(t,e),c0(n)},t.prototype.enterBlur=3Dfunction(t){Ll(t),c0(n)}=
,t.prototype.leaveBlur=3Dfunction(t){Pl(t),c0(n)},t.prototype.enterSelect=
=3Dfunction(t){Ol(t),c0(n)},t.prototype.leaveSelect=3Dfunction(t){Rl(t),c0(=
n)},t.prototype.getModel=3Dfunction(){return n.getModel()},t.prototype.getV=
iewOfComponentModel=3Dfunction(t){return n.getViewOfComponentModel(t)},t.pr=
ototype.getViewOfSeriesModel=3Dfunction(t){return n.getViewOfSeriesModel(t)=
},new t(n);function t(){return null!=3D=3De&&e.apply(this,arguments)||this}=
var e},void(h0=3Dfunction(i){function o(t,e){for(var n=3D0;n<t.length;n++)t=
[n][Um]=3De}E(T0,function(t,e){i._messageCenter.on(e,function(t){var e,n;!P=
0[i.group]||0=3D=3D=3Di[Um]||t&&t.escapeConnect||(e=3Di.makeActionFromEvent=
(t),n=3D[],E(L0,function(t){t!=3D=3Di&&t.group=3D=3D=3Di.group&&n.push(t)})=
,o(n,0),E(n,function(t){1!=3D=3Dt[Um]&&t.dispatchAction(e)}),o(n,2))})})}))=
;var y0,m0=3Dh,em=3Dm0.prototype;function h(t,e,n){var i=3Dy0.call(this,new=
 Fy)||this,t=3D(i._chartsViews=3D[],i._chartsMap=3D{},i._componentsViews=3D=
[],i._componentsMap=3D{},i._pendingActions=3D[],n=3Dn||{},H(e)&&(e=3Dk0[e])=
,i._dom=3Dt,n.ssr&&$o(function(t){var e,t=3Dk(t),n=3Dt.dataIndex;if(null!=
=3Dn)return(e=3DN()).set("series_index",t.seriesIndex),e.set("data_index",n=
),t.ssrType&&e.set("ssr_type",t.ssrType),e}),i._zr=3Djo(t,{renderer:n.rende=
rer||"canvas",devicePixelRatio:n.devicePixelRatio,width:n.width,height:n.he=
ight,ssr:n.ssr,useDirtyRect:R(n.useDirtyRect,!1),useCoarsePointer:R(n.useCo=
arsePointer,"auto"),pointerSize:n.pointerSize})),n=3D(i._ssr=3Dn.ssr,i._thr=
ottledZrFlush=3Dpy(S(t.flush,t),17),(e=3Dy(e))&&Jd(e,!0),i._theme=3De,i._lo=
cale=3DH(e=3Dn.locale||$c)?(n=3Djc[e.toUpperCase()]||{},e=3D=3D=3DYc||e=3D=
=3D=3DZc?y(n):d(y(n),y(jc[qc]),!1)):d(y(e),y(jc[qc]),!1),i._coordSysMgr=3Dn=
ew Ad,i._api=3Du0(i));function o(t,e){return t.__prio-e.__prio}return yn(D0=
,o),yn(I0,o),i._scheduler=3Dnew by(i,n,I0,D0),i._messageCenter=3Dnew f0,i._=
initEvents(),i.resize=3DS(i.resize,i),t.animation.on("frame",i._onframe,i),=
o0(t,i),r0(t,i),It(i),i}function v0(t){t.clearColorPalette(),t.eachSeries(f=
unction(t){t.clearColorPalette()})}function _0(t){for(var e=3D[],n=3Dt.curr=
entStates,i=3D0;i<n.length;i++){var o=3Dn[i];"emphasis"!=3D=3Do&&"blur"!=3D=
=3Do&&"select"!=3D=3Do&&e.push(o)}t.selected&&t.states.select&&e.push("sele=
ct"),t.hoverState=3D=3D=3Drl&&t.states.emphasis?e.push("emphasis"):t.hoverS=
tate=3D=3D=3Dol&&t.states.blur&&e.push("blur"),t.useStates(e)}function x0(t=
,e){var n,i;t.preventAutoZ||(n=3Dt.get("z")||0,i=3Dt.get("zlevel")||0,e.eac=
hRendered(function(t){return function t(e,n,i,o){var r=3De.getTextContent()=
,a=3De.getTextGuideLine();if(e.isGroup)for(var s=3De.childrenRef(),l=3D0;l<=
s.length;l++)o=3DMath.max(t(s[l],n,i,o),o);else e.z=3Dn,e.zlevel=3Di,o=3DMa=
th.max(e.z2,o);r&&(r.z=3Dn,r.zlevel=3Di,isFinite(o))&&(r.z2=3Do+2),a&&(r=3D=
e.textGuideLineConfig,a.z=3Dn,a.zlevel=3Di,isFinite(o))&&(a.z2=3Do+(r&&r.sh=
owAbove?1:-1));return o}(t,n,i,-1/0),!0}))}function w0(t,e){e.eachRendered(=
function(t){var e,n;zh(t)||(e=3Dt.getTextContent(),n=3Dt.getTextGuideLine()=
,t.stateTransition&&(t.stateTransition=3Dnull),e&&e.stateTransition&&(e.sta=
teTransition=3Dnull),n&&n.stateTransition&&(n.stateTransition=3Dnull),t.has=
State()?(t.prevStates=3Dt.currentStates,t.clearStates()):t.prevStates&&(t.p=
revStates=3Dnull))})}function b0(t,e){var n=3Dt.getModel("stateAnimation"),=
o=3Dt.isAnimationEnabled(),t=3Dn.get("duration"),r=3D0<t?{duration:t,delay:=
n.get("delay"),easing:n.get("easing")}:null;e.eachRendered(function(t){var =
e,n,i;t.states&&t.states.emphasis&&(zh(t)||(t instanceof _s&&((i=3Del(n=3Dt=
)).normalFill=3Dn.style.fill,i.normalStroke=3Dn.style.stroke,n=3Dn.states.s=
elect||{},i.selectFill=3Dn.style&&n.style.fill||null,i.selectStroke=3Dn.sty=
le&&n.style.stroke||null),t.__dirty&&(i=3Dt.prevStates)&&t.useStates(i),o&&=
(t.stateTransition=3Dr,n=3Dt.getTextContent(),e=3Dt.getTextGuideLine(),n&&(=
n.stateTransition=3Dr),e)&&(e.stateTransition=3Dr),t.__dirty&&_0(t)))})}em.=
on=3DYm("on"),em.off=3DYm("off"),em.one=3Dfunction(i,o,t){var r=3Dthis;this=
.on.call(this,i,function t(){for(var e=3D[],n=3D0;n<arguments.length;n++)e[=
n]=3Darguments[n];o&&o.apply&&o.apply(this,e),r.off(i,t)},t)};var S0=3D["cl=
ick","dblclick","mouseover","mouseout","mousemove","mousedown","mouseup","g=
lobalout","contextmenu"];var M0=3D{},T0=3D{},I0=3D[],C0=3D[],D0=3D[],k0=3D{=
},A0=3D{},L0=3D{},P0=3D{},O0=3D+new Date,R0=3D+new Date,N0=3D"_echarts_inst=
ance_";function E0(t){P0[t]=3D!1}Qy=3DE0;function z0(t){return L0[e=3DN0,(t=
=3Dt).getAttribute?t.getAttribute(e):t[e]];var e}function B0(t,e){k0[t]=3De=
}function F0(t){C(C0,t)<0&&C0.push(t)}function V0(t,e){j0(I0,t,e,2e3)}funct=
ion H0(t){G0("afterinit",t)}function W0(t){G0("afterupdate",t)}function G0(=
t,e){Fm.on(t,e)}function X0(t,e,n){D(e)&&(n=3De,e=3D"");var i=3DO(t)?t.type=
:[t,t=3D{event:e}][0];t.event=3D(t.event||i).toLowerCase(),e=3Dt.event,T0[e=
]||(St(Xm.test(i)&&Xm.test(e)),M0[i]||(M0[i]=3D{action:n,actionInfo:t}),T0[=
e]=3Di)}function U0(t,e){Ad.register(t,e)}function Y0(t,e){j0(D0,t,e,1e3,"l=
ayout")}function Z0(t,e){j0(D0,t,e,3e3,"visual")}var q0=3D[];function j0(t,=
e,n,i,o){(D(e)||O(e))&&(n=3De,e=3Di),0<=3DC(q0,n)||(q0.push(n),(i=3Dby.wrap=
StageHandler(n,o)).__prio=3De,i.__raw=3Dn,t.push(i))}function K0(t,e){A0[t]=
=3De}function $0(t,e,n){var i=3DVm.registerMap;i&&i(t,e,n)}function Q0(t){v=
ar e=3D(t=3Dy(t)).type,n=3D(e||f(""),e.split(":")),i=3D(2!=3D=3Dn.length&&f=
(""),!1);"echarts"=3D=3D=3Dn[0]&&(e=3Dn[1],i=3D!0),t.__isBuiltIn=3Di,ag.set=
(e,t)}Z0(2e3,ea),Z0(4500,nc),Z0(4500,op),Z0(2e3,Rc),Z0(4500,Gy),Z0(7e3,func=
tion(e,i){e.eachRawSeries(function(t){var n;!e.isSeriesFiltered(t)&&((n=3Dt=
.getData()).hasItemVisual()&&n.each(function(t){var e=3Dn.getItemVisual(t,"=
decal");e&&(n.ensureUniqueItemVisual(t,"style").decal=3Dzm(e,i))}),t=3Dn.ge=
tVisual("decal"))&&(n.getVisual("style").decal=3Dzm(t,i))})}),F0(Jd),V0(900=
,function(t){var i=3DN();t.eachSeries(function(t){var e,n=3Dt.get("stack");=
n&&(n=3Di.get(n)||i.set(n,[]),(t=3D{stackResultDimension:(e=3Dt.getData()).=
getCalculationInfo("stackResultDimension"),stackedOverDimension:e.getCalcul=
ationInfo("stackedOverDimension"),stackedDimension:e.getCalculationInfo("st=
ackedDimension"),stackedByDimension:e.getCalculationInfo("stackedByDimensio=
n"),isStackedByIndex:e.getCalculationInfo("isStackedByIndex"),data:e,series=
Model:t}).stackedDimension)&&(t.isStackedByIndex||t.stackedByDimension)&&(n=
.length&&e.setCalculationInfo("stackedOnSeries",n[n.length-1].seriesModel),=
n.push(t))}),i.each(tf)}),K0("default",function(i,o){B(o=3Do||{},{text:"loa=
ding",textColor:"#000",fontSize:12,fontWeight:"normal",fontStyle:"normal",f=
ontFamily:"sans-serif",maskColor:"rgba(255, 255, 255, 0.8)",showSpinner:!0,=
color:"#5470c6",spinnerRadius:10,lineWidth:5,zlevel:0});var t=3Dnew Wo,r=3D=
new Es({style:{fill:o.maskColor},zlevel:o.zlevel,z:1e4});t.add(r);var a,s=
=3Dnew Hs({style:{text:o.text,fill:o.textColor,fontSize:o.fontSize,fontWeig=
ht:o.fontWeight,fontStyle:o.fontStyle,fontFamily:o.fontFamily},zlevel:o.zle=
vel,z:10001}),l=3Dnew Es({style:{fill:"none"},textContent:s,textConfig:{pos=
ition:"right",distance:10},zlevel:o.zlevel,z:10001});return t.add(l),o.show=
Spinner&&((a=3Dnew ph({shape:{startAngle:-wy/2,endAngle:-wy/2+.1,r:o.spinne=
rRadius},style:{stroke:o.color,lineCap:"round",lineWidth:o.lineWidth},zleve=
l:o.zlevel,z:10001})).animateShape(!0).when(1e3,{endAngle:3*wy/2}).start("c=
ircularInOut"),a.animateShape(!0).when(1e3,{startAngle:3*wy/2}).delay(300).=
start("circularInOut"),t.add(a)),t.resize=3Dfunction(){var t=3Ds.getBoundin=
gRect().width,e=3Do.showSpinner?o.spinnerRadius:0,t=3D(i.getWidth()-2*e-(o.=
showSpinner&&t?10:0)-t)/2-(o.showSpinner&&t?0:5+t/2)+(o.showSpinner?0:t/2)+=
(t?0:e),n=3Di.getHeight()/2;o.showSpinner&&a.setShape({cx:t,cy:n}),l.setSha=
pe({x:t-e,y:n-e,width:2*e,height:2*e}),r.setShape({x:0,y:0,width:i.getWidth=
(),height:i.getHeight()})},t.resize(),t}),X0({type:ll,event:ll,update:ll},z=
t),X0({type:ul,event:ul,update:ul},zt),X0({type:hl,event:hl,update:hl},zt),=
X0({type:cl,event:cl,update:cl},zt),X0({type:pl,event:pl,update:pl},zt),B0(=
"light",Ec),B0("dark",Pc);function J0(t){return null=3D=3Dt?0:t.length||1}f=
unction tv(t){return t}nv.prototype.add=3Dfunction(t){return this._add=3Dt,=
this},nv.prototype.update=3Dfunction(t){return this._update=3Dt,this},nv.pr=
ototype.updateManyToOne=3Dfunction(t){return this._updateManyToOne=3Dt,this=
},nv.prototype.updateOneToMany=3Dfunction(t){return this._updateOneToMany=
=3Dt,this},nv.prototype.updateManyToMany=3Dfunction(t){return this._updateM=
anyToMany=3Dt,this},nv.prototype.remove=3Dfunction(t){return this._remove=
=3Dt,this},nv.prototype.execute=3Dfunction(){this[this._diffModeMultiple?"_=
executeMultiple":"_executeOneToOne"]()},nv.prototype._executeOneToOne=3Dfun=
ction(){var t=3Dthis._old,e=3Dthis._new,n=3D{},i=3Dnew Array(t.length),o=3D=
new Array(e.length);this._initIndexMap(t,null,i,"_oldKeyGetter"),this._init=
IndexMap(e,n,o,"_newKeyGetter");for(var r=3D0;r<t.length;r++){var a,s=3Di[r=
],l=3Dn[s],u=3DJ0(l);1<u?(a=3Dl.shift(),1=3D=3D=3Dl.length&&(n[s]=3Dl[0]),t=
his._update&&this._update(a,r)):1=3D=3D=3Du?(n[s]=3Dnull,this._update&&this=
._update(l,r)):this._remove&&this._remove(r)}this._performRestAdd(o,n)},nv.=
prototype._executeMultiple=3Dfunction(){var t=3Dthis._old,e=3Dthis._new,n=
=3D{},i=3D{},o=3D[],r=3D[];this._initIndexMap(t,n,o,"_oldKeyGetter"),this._=
initIndexMap(e,i,r,"_newKeyGetter");for(var a=3D0;a<o.length;a++){var s=3Do=
[a],l=3Dn[s],u=3Di[s],h=3DJ0(l),c=3DJ0(u);if(1<h&&1=3D=3D=3Dc)this._updateM=
anyToOne&&this._updateManyToOne(u,l),i[s]=3Dnull;else if(1=3D=3D=3Dh&&1<c)t=
his._updateOneToMany&&this._updateOneToMany(u,l),i[s]=3Dnull;else if(1=3D=
=3D=3Dh&&1=3D=3D=3Dc)this._update&&this._update(u,l),i[s]=3Dnull;else if(1<=
h&&1<c)this._updateManyToMany&&this._updateManyToMany(u,l),i[s]=3Dnull;else=
 if(1<h)for(var p=3D0;p<h;p++)this._remove&&this._remove(l[p]);else this._r=
emove&&this._remove(l)}this._performRestAdd(r,i)},nv.prototype._performRest=
Add=3Dfunction(t,e){for(var n=3D0;n<t.length;n++){var i=3Dt[n],o=3De[i],r=
=3DJ0(o);if(1<r)for(var a=3D0;a<r;a++)this._add&&this._add(o[a]);else 1=3D=
=3D=3Dr&&this._add&&this._add(o);e[i]=3Dnull}},nv.prototype._initIndexMap=
=3Dfunction(t,e,n,i){for(var o=3Dthis._diffModeMultiple,r=3D0;r<t.length;r+=
+){var a,s,l=3D"_ec_"+this[i](t[r],r);o||(n[r]=3Dl),e&&(0=3D=3D=3D(s=3DJ0(a=
=3De[l]))?(e[l]=3Dr,o&&n.push(l)):1=3D=3D=3Ds?e[l]=3D[a,r]:a.push(r))}};var=
 ev=3Dnv;function nv(t,e,n,i,o,r){this._old=3Dt,this._new=3De,this._oldKeyG=
etter=3Dn||tv,this._newKeyGetter=3Di||tv,this.context=3Do,this._diffModeMul=
tiple=3D"multiple"=3D=3D=3Dr}ov.prototype.get=3Dfunction(){return{fullDimen=
sions:this._getFullDimensionNames(),encode:this._encode}},ov.prototype._get=
FullDimensionNames=3Dfunction(){return this._cachedDimNames||(this._cachedD=
imNames=3Dthis._schema?this._schema.makeOutputDimensionNames():[]),this._ca=
chedDimNames};var iv=3Dov;function ov(t,e){this._encode=3Dt,this._schema=3D=
e}function rv(r,t){var e=3D{},a=3De.encode=3D{},s=3DN(),l=3D[],u=3D[],h=3D{=
},i=3D(E(r.dimensions,function(t){var e,n,i=3Dr.getDimensionInfo(t),o=3Di.c=
oordDim;o&&(e=3Di.coordDimIndex,av(a,o)[e]=3Dt,i.isExtraCoord||(s.set(o,1),=
"ordinal"!=3D=3D(n=3Di.type)&&"time"!=3D=3Dn&&(l[0]=3Dt),av(h,o)[e]=3Dr.get=
DimensionIndex(i.name)),i.defaultTooltip)&&u.push(t),Qp.each(function(t,e){=
var n=3Dav(a,e),e=3Di.otherDims[e];null!=3De&&!1!=3D=3De&&(n[e]=3Di.name)})=
}),[]),o=3D{},n=3D(s.each(function(t,e){var n=3Da[e];o[e]=3Dn[0],i=3Di.conc=
at(n)}),e.dataDimsOnCoord=3Di,e.dataDimIndicesOnCoord=3DF(i,function(t){ret=
urn r.getDimensionInfo(t).storeDimIndex}),e.encodeFirstDimNotExtra=3Do,a.la=
bel),n=3D(n&&n.length&&(l=3Dn.slice()),a.tooltip);return n&&n.length?u=3Dn.=
slice():u.length||(u=3Dl.slice()),a.defaultedLabel=3Dl,a.defaultedTooltip=
=3Du,e.userOutput=3Dnew iv(h,t),e}function av(t,e){return t.hasOwnProperty(=
e)||(t[e]=3D[]),t[e]}var sv=3Dfunction(t){this.otherDims=3D{},null!=3Dt&&P(=
this,t)},lv=3DRr(),uv=3D{float:"f",int:"i",ordinal:"o",number:"n",time:"t"}=
,hv=3D(cv.prototype.isDimensionOmitted=3Dfunction(){return this._dimOmitted=
},cv.prototype._updateDimOmitted=3Dfunction(t){!(this._dimOmitted=3Dt)||thi=
s._dimNameMap||(this._dimNameMap=3Dfv(this.source))},cv.prototype.getSource=
DimensionIndex=3Dfunction(t){return R(this._dimNameMap.get(t),-1)},cv.proto=
type.getSourceDimension=3Dfunction(t){var e=3Dthis.source.dimensionsDefine;=
if(e)return e[t]},cv.prototype.makeStoreSchema=3Dfunction(){for(var t=3Dthi=
s._fullDimCount,e=3Dcf(this.source),n=3D!(30<t),i=3D"",o=3D[],r=3D0,a=3D0;r=
<t;r++){var s,l=3Dvoid 0,u=3Dvoid 0,h=3Dvoid 0,c=3Dthis.dimensions[a];c&&c.=
storeDimIndex=3D=3D=3Dr?(l=3De?c.name:null,u=3Dc.type,h=3Dc.ordinalMeta,a++=
):(s=3Dthis.getSourceDimension(r))&&(l=3De?s.name:null,u=3Ds.type),o.push({=
property:l,type:u,ordinalMeta:h}),!e||null=3D=3Dl||c&&c.isCalculationCoord|=
|(i+=3Dn?l.replace(/\`/g,"`1").replace(/\$/g,"`2"):l),i=3Di+"$"+(uv[u]||"f"=
),h&&(i+=3Dh.uid),i+=3D"$"}var p=3Dthis.source;return{dimensions:o,hash:[p.=
seriesLayoutBy,p.startIndex,i].join("$$")}},cv.prototype.makeOutputDimensio=
nNames=3Dfunction(){for(var t=3D[],e=3D0,n=3D0;e<this._fullDimCount;e++){va=
r i=3Dvoid 0,o=3Dthis.dimensions[n];o&&o.storeDimIndex=3D=3D=3De?(o.isCalcu=
lationCoord||(i=3Do.name),n++):(o=3Dthis.getSourceDimension(e))&&(i=3Do.nam=
e),t.push(i)}return t},cv.prototype.appendCalculationDimension=3Dfunction(t=
){this.dimensions.push(t),t.isCalculationCoord=3D!0,this._fullDimCount++,th=
is._updateDimOmitted(!0)},cv);function cv(t){this.dimensions=3Dt.dimensions=
,this._dimOmitted=3Dt.dimensionOmitted,this.source=3Dt.source,this._fullDim=
Count=3Dt.fullDimensionCount,this._updateDimOmitted(t.dimensionOmitted)}fun=
ction pv(t){return t instanceof hv}function dv(t){for(var e=3DN(),n=3D0;n<(=
t||[]).length;n++){var i=3Dt[n],i=3DO(i)?i.name:i;null!=3Di&&null=3D=3De.ge=
t(i)&&e.set(i,n)}return e}function fv(t){var e=3Dlv(t);return e.dimNameMap|=
|(e.dimNameMap=3Ddv(t.dimensionsDefine))}var gv,yv,mv,vv,_v,xv,wv,bv=3DO,Sv=
=3DF,Mv=3D"undefined"=3D=3Dtypeof Int32Array?Array:Int32Array,Tv=3D["hasIte=
mOption","_nameList","_idList","_invertedIndicesMap","_dimSummary","userOut=
put","_rawData","_dimValueGetter","_nameDimIdx","_idDimIdx","_nameRepeatCou=
nt"],Iv=3D["_approximateExtent"],Cv=3D(c.prototype.getDimension=3Dfunction(=
t){var e;return null=3D=3D(e=3Dthis._recognizeDimIndex(t))?t:(e=3Dt,this._d=
imOmitted?null!=3D(t=3Dthis._dimIdxToName.get(e))?t:(t=3Dthis._schema.getSo=
urceDimension(e))?t.name:void 0:this.dimensions[e])},c.prototype.getDimensi=
onIndex=3Dfunction(t){var e=3Dthis._recognizeDimIndex(t);return null!=3De?e=
:null=3D=3Dt?-1:(e=3Dthis._getDimInfo(t))?e.storeDimIndex:this._dimOmitted?=
this._schema.getSourceDimensionIndex(t):-1},c.prototype._recognizeDimIndex=
=3Dfunction(t){if(W(t)||null!=3Dt&&!isNaN(t)&&!this._getDimInfo(t)&&(!this.=
_dimOmitted||this._schema.getSourceDimensionIndex(t)<0))return+t},c.prototy=
pe._getStoreDimIndex=3Dfunction(t){return this.getDimensionIndex(t)},c.prot=
otype.getDimensionInfo=3Dfunction(t){return this._getDimInfo(this.getDimens=
ion(t))},c.prototype._initGetDimensionInfo=3Dfunction(t){var e=3Dthis._dimI=
nfos;this._getDimInfo=3Dt?function(t){return e.hasOwnProperty(t)?e[t]:void =
0}:function(t){return e[t]}},c.prototype.getDimensionsOnCoord=3Dfunction(){=
return this._dimSummary.dataDimsOnCoord.slice()},c.prototype.mapDimension=
=3Dfunction(t,e){var n=3Dthis._dimSummary;return null=3D=3De?n.encodeFirstD=
imNotExtra[t]:(n=3Dn.encode[t])?n[e]:null},c.prototype.mapDimensionsAll=3Df=
unction(t){return(this._dimSummary.encode[t]||[]).slice()},c.prototype.getS=
tore=3Dfunction(){return this._store},c.prototype.initData=3Dfunction(t,e,n=
){var i,o,r=3Dthis;(i=3Dt instanceof mg?t:i)||(o=3Dthis.dimensions,t=3Drf(t=
)||st(t)?new gf(t,o.length):t,i=3Dnew mg,o=3DSv(o,function(t){return{type:r=
._dimInfos[t].type,property:t}}),i.initData(t,o,n)),this._store=3Di,this._n=
ameList=3D(e||[]).slice(),this._idList=3D[],this._nameRepeatCount=3D{},this=
._doInit(0,i.count()),this._dimSummary=3Drv(this,this._schema),this.userOut=
put=3Dthis._dimSummary.userOutput},c.prototype.appendData=3Dfunction(t){t=
=3Dthis._store.appendData(t);this._doInit(t[0],t[1])},c.prototype.appendVal=
ues=3Dfunction(t,e){var t=3Dthis._store.appendValues(t,e.length),n=3Dt.star=
t,i=3Dt.end,o=3Dthis._shouldMakeIdFromName();if(this._updateOrdinalMeta(),e=
)for(var r=3Dn;r<i;r++)this._nameList[r]=3De[r-n],o&&wv(this,r)},c.prototyp=
e._updateOrdinalMeta=3Dfunction(){for(var t=3Dthis._store,e=3Dthis.dimensio=
ns,n=3D0;n<e.length;n++){var i=3Dthis._dimInfos[e[n]];i.ordinalMeta&&t.coll=
ectOrdinalMeta(i.storeDimIndex,i.ordinalMeta)}},c.prototype._shouldMakeIdFr=
omName=3Dfunction(){var t=3Dthis._store.getProvider();return null=3D=3Dthis=
._idDimIdx&&t.getSource().sourceFormat!=3D=3Did&&!t.fillStorage},c.prototyp=
e._doInit=3Dfunction(t,e){if(!(e<=3Dt)){var n=3Dthis._store.getProvider(),i=
=3D(this._updateOrdinalMeta(),this._nameList),o=3Dthis._idList;if(n.getSour=
ce().sourceFormat=3D=3D=3DJp&&!n.pure)for(var r=3D[],a=3Dt;a<e;a++){var s=
=3Dn.getItem(a,r);this.hasItemOption||!O(l=3Ds)||l instanceof Array||(this.=
hasItemOption=3D!0),s&&(l=3Ds.name,null=3D=3Di[a]&&null!=3Dl&&(i[a]=3Dkr(l,=
null)),s=3Ds.id,null=3D=3Do[a])&&null!=3Ds&&(o[a]=3Dkr(s,null))}if(this._sh=
ouldMakeIdFromName())for(a=3Dt;a<e;a++)wv(this,a);gv(this)}var l},c.prototy=
pe.getApproximateExtent=3Dfunction(t){return this._approximateExtent[t]||th=
is._store.getDataExtent(this._getStoreDimIndex(t))},c.prototype.setApproxim=
ateExtent=3Dfunction(t,e){e=3Dthis.getDimension(e),this._approximateExtent[=
e]=3Dt.slice()},c.prototype.getCalculationInfo=3Dfunction(t){return this._c=
alculationInfo[t]},c.prototype.setCalculationInfo=3Dfunction(t,e){bv(t)?P(t=
his._calculationInfo,t):this._calculationInfo[t]=3De},c.prototype.getName=
=3Dfunction(t){var t=3Dthis.getRawIndex(t),e=3Dthis._nameList[t];return e=
=3Dnull=3D=3D(e=3Dnull=3D=3De&&null!=3Dthis._nameDimIdx?mv(this,this._nameD=
imIdx,t):e)?"":e},c.prototype._getCategory=3Dfunction(t,e){e=3Dthis._store.=
get(t,e),t=3Dthis._store.getOrdinalMeta(t);return t?t.categories[e]:e},c.pr=
ototype.getId=3Dfunction(t){return yv(this,this.getRawIndex(t))},c.prototyp=
e.count=3Dfunction(){return this._store.count()},c.prototype.get=3Dfunction=
(t,e){var n=3Dthis._store,t=3Dthis._dimInfos[t];if(t)return n.get(t.storeDi=
mIndex,e)},c.prototype.getByRawIndex=3Dfunction(t,e){var n=3Dthis._store,t=
=3Dthis._dimInfos[t];if(t)return n.getByRawIndex(t.storeDimIndex,e)},c.prot=
otype.getIndices=3Dfunction(){return this._store.getIndices()},c.prototype.=
getDataExtent=3Dfunction(t){return this._store.getDataExtent(this._getStore=
DimIndex(t))},c.prototype.getSum=3Dfunction(t){return this._store.getSum(th=
is._getStoreDimIndex(t))},c.prototype.getMedian=3Dfunction(t){return this._=
store.getMedian(this._getStoreDimIndex(t))},c.prototype.getValues=3Dfunctio=
n(t,e){var n=3Dthis,i=3Dthis._store;return V(t)?i.getValues(Sv(t,function(t=
){return n._getStoreDimIndex(t)}),e):i.getValues(t)},c.prototype.hasValue=
=3Dfunction(t){for(var e=3Dthis._dimSummary.dataDimIndicesOnCoord,n=3D0,i=
=3De.length;n<i;n++)if(isNaN(this._store.get(e[n],t)))return!1;return!0},c.=
prototype.indexOfName=3Dfunction(t){for(var e=3D0,n=3Dthis._store.count();e=
<n;e++)if(this.getName(e)=3D=3D=3Dt)return e;return-1},c.prototype.getRawIn=
dex=3Dfunction(t){return this._store.getRawIndex(t)},c.prototype.indexOfRaw=
Index=3Dfunction(t){return this._store.indexOfRawIndex(t)},c.prototype.rawI=
ndexOf=3Dfunction(t,e){t=3D(t&&this._invertedIndicesMap[t])[e];return null=
=3D=3Dt||isNaN(t)?-1:t},c.prototype.indicesOfNearest=3Dfunction(t,e,n){retu=
rn this._store.indicesOfNearest(this._getStoreDimIndex(t),e,n)},c.prototype=
.each=3Dfunction(t,e,n){D(t)&&(n=3De,e=3Dt,t=3D[]);n=3Dn||this,t=3DSv(vv(t)=
,this._getStoreDimIndex,this);this._store.each(t,n?S(e,n):e)},c.prototype.f=
ilterSelf=3Dfunction(t,e,n){D(t)&&(n=3De,e=3Dt,t=3D[]);n=3Dn||this,t=3DSv(v=
v(t),this._getStoreDimIndex,this);return this._store=3Dthis._store.filter(t=
,n?S(e,n):e),this},c.prototype.selectRange=3Dfunction(n){var i=3Dthis,o=3D{=
};return E(ht(n),function(t){var e=3Di._getStoreDimIndex(t);o[e]=3Dn[t]}),t=
his._store=3Dthis._store.selectRange(o),this},c.prototype.mapArray=3Dfuncti=
on(t,e,n){D(t)&&(n=3De,e=3Dt,t=3D[]);var i=3D[];return this.each(t,function=
(){i.push(e&&e.apply(this,arguments))},n=3Dn||this),i},c.prototype.map=3Dfu=
nction(t,e,n,i){n=3Dn||i||this,i=3DSv(vv(t),this._getStoreDimIndex,this),t=
=3Dxv(this);return t._store=3Dthis._store.map(i,n?S(e,n):e),t},c.prototype.=
modify=3Dfunction(t,e,n,i){n=3Dn||i||this,i=3DSv(vv(t),this._getStoreDimInd=
ex,this);this._store.modify(i,n?S(e,n):e)},c.prototype.downSample=3Dfunctio=
n(t,e,n,i){var o=3Dxv(this);return o._store=3Dthis._store.downSample(this._=
getStoreDimIndex(t),e,n,i),o},c.prototype.lttbDownSample=3Dfunction(t,e){va=
r n=3Dxv(this);return n._store=3Dthis._store.lttbDownSample(this._getStoreD=
imIndex(t),e),n},c.prototype.getRawDataItem=3Dfunction(t){return this._stor=
e.getRawDataItem(t)},c.prototype.getItemModel=3Dfunction(t){var e=3Dthis.ho=
stModel,t=3Dthis.getRawDataItem(t);return new Hc(t,e,e&&e.ecModel)},c.proto=
type.diff=3Dfunction(e){var n=3Dthis;return new ev(e?e.getStore().getIndice=
s():[],this.getStore().getIndices(),function(t){return yv(e,t)},function(t)=
{return yv(n,t)})},c.prototype.getVisual=3Dfunction(t){var e=3Dthis._visual=
;return e&&e[t]},c.prototype.setVisual=3Dfunction(t,e){this._visual=3Dthis.=
_visual||{},bv(t)?P(this._visual,t):this._visual[t]=3De},c.prototype.getIte=
mVisual=3Dfunction(t,e){t=3Dthis._itemVisuals[t],t=3Dt&&t[e];return null=3D=
=3Dt?this.getVisual(e):t},c.prototype.hasItemVisual=3Dfunction(){return 0<t=
his._itemVisuals.length},c.prototype.ensureUniqueItemVisual=3Dfunction(t,e)=
{var n=3Dthis._itemVisuals,i=3Dn[t],n=3D(i=3Di||(n[t]=3D{}))[e];return null=
=3D=3Dn&&(V(n=3Dthis.getVisual(e))?n=3Dn.slice():bv(n)&&(n=3DP({},n)),i[e]=
=3Dn),n},c.prototype.setItemVisual=3Dfunction(t,e,n){var i=3Dthis._itemVisu=
als[t]||{};this._itemVisuals[t]=3Di,bv(e)?P(i,e):i[e]=3Dn},c.prototype.clea=
rAllVisual=3Dfunction(){this._visual=3D{},this._itemVisuals=3D[]},c.prototy=
pe.setLayout=3Dfunction(t,e){bv(t)?P(this._layout,t):this._layout[t]=3De},c=
.prototype.getLayout=3Dfunction(t){return this._layout[t]},c.prototype.getI=
temLayout=3Dfunction(t){return this._itemLayouts[t]},c.prototype.setItemLay=
out=3Dfunction(t,e,n){this._itemLayouts[t]=3Dn?P(this._itemLayouts[t]||{},e=
):e},c.prototype.clearItemLayouts=3Dfunction(){this._itemLayouts.length=3D0=
},c.prototype.setItemGraphicEl=3Dfunction(t,e){var n,i,o,r,a=3Dthis.hostMod=
el&&this.hostModel.seriesIndex;n=3Da,i=3Dthis.dataType,o=3Dt,(a=3De)&&((r=
=3Dk(a)).dataIndex=3Do,r.dataType=3Di,r.seriesIndex=3Dn,r.ssrType=3D"chart"=
,"group"=3D=3D=3Da.type)&&a.traverse(function(t){t=3Dk(t);t.seriesIndex=3Dn=
,t.dataIndex=3Do,t.dataType=3Di,t.ssrType=3D"chart"}),this._graphicEls[t]=
=3De},c.prototype.getItemGraphicEl=3Dfunction(t){return this._graphicEls[t]=
},c.prototype.eachItemGraphicEl=3Dfunction(n,i){E(this._graphicEls,function=
(t,e){t&&n&&n.call(i,t,e)})},c.prototype.cloneShallow=3Dfunction(t){return =
t=3Dt||new c(this._schema||Sv(this.dimensions,this._getDimInfo,this),this.h=
ostModel),_v(t,this),t._store=3Dthis._store,t},c.prototype.wrapMethod=3Dfun=
ction(t,e){var n=3Dthis[t];D(n)&&(this.__wrappedMethods=3Dthis.__wrappedMet=
hods||[],this.__wrappedMethods.push(t),this[t]=3Dfunction(){var t=3Dn.apply=
(this,arguments);return e.apply(this,[t].concat(wt(arguments)))})},c.intern=
alField=3D(gv=3Dfunction(a){var s=3Da._invertedIndicesMap;E(s,function(t,e)=
{var n=3Da._dimInfos[e],i=3Dn.ordinalMeta,o=3Da._store;if(i){t=3Ds[e]=3Dnew=
 Mv(i.categories.length);for(var r=3D0;r<t.length;r++)t[r]=3D-1;for(r=3D0;r=
<o.count();r++)t[o.get(n.storeDimIndex,r)]=3Dr}})},mv=3Dfunction(t,e,n){ret=
urn kr(t._getCategory(e,n),null)},yv=3Dfunction(t,e){var n=3Dt._idList[e];r=
eturn n=3Dnull=3D=3D(n=3Dnull=3D=3Dn&&null!=3Dt._idDimIdx?mv(t,t._idDimIdx,=
e):n)?"e\0\0"+e:n},vv=3Dfunction(t){return t=3DV(t)?t:null!=3Dt?[t]:[]},xv=
=3Dfunction(t){var e=3Dnew c(t._schema||Sv(t.dimensions,t._getDimInfo,t),t.=
hostModel);return _v(e,t),e},_v=3Dfunction(e,n){E(Tv.concat(n.__wrappedMeth=
ods||[]),function(t){n.hasOwnProperty(t)&&(e[t]=3Dn[t])}),e.__wrappedMethod=
s=3Dn.__wrappedMethods,E(Iv,function(t){e[t]=3Dy(n[t])}),e._calculationInfo=
=3DP({},n._calculationInfo)},void(wv=3Dfunction(t,e){var n=3Dt._nameList,i=
=3Dt._idList,o=3Dt._nameDimIdx,r=3Dt._idDimIdx,a=3Dn[e],s=3Di[e];null=3D=3D=
a&&null!=3Do&&(n[e]=3Da=3Dmv(t,o,e)),null=3D=3Ds&&null!=3Dr&&(i[e]=3Ds=3Dmv=
(t,r,e)),null=3D=3Ds&&null!=3Da&&(s=3Da,1<(o=3D(n=3Dt._nameRepeatCount)[a]=
=3D(n[a]||0)+1)&&(s+=3D"__ec__"+o),i[e]=3Ds)})),c);function c(t,e){this.typ=
e=3D"list",this._dimOmitted=3D!1,this._nameList=3D[],this._idList=3D[],this=
._visual=3D{},this._layout=3D{},this._itemVisuals=3D[],this._itemLayouts=3D=
[],this._graphicEls=3D[],this._approximateExtent=3D{},this._calculationInfo=
=3D{},this.hasItemOption=3D!1,this.TRANSFERABLE_METHODS=3D["cloneShallow","=
downSample","lttbDownSample","map"],this.CHANGABLE_METHODS=3D["filterSelf",=
"selectRange"];var n=3D!(this.DOWNSAMPLE_METHODS=3D["downSample","lttbDownS=
ample"]);pv(t)?(o=3Dt.dimensions,this._dimOmitted=3Dt.isDimensionOmitted(),=
this._schema=3Dt):(n=3D!0,o=3Dt);for(var i,o=3Do||["x","y"],r=3D{},a=3D[],s=
=3D{},l=3D!1,u=3D{},h=3D0;h<o.length;h++){var c=3Do[h],c=3DH(c)?new sv({nam=
e:c}):c instanceof sv?c:new sv(c),p=3Dc.name,d=3D(c.type=3Dc.type||"float",=
c.coordDim||(c.coordDim=3Dp,c.coordDimIndex=3D0),c.otherDims=3Dc.otherDims|=
|{});a.push(p),null!=3Du[p]&&(l=3D!0),(r[p]=3Dc).createInvertedIndices&&(s[=
p]=3D[]),0=3D=3D=3Dd.itemName&&(this._nameDimIdx=3Dh),0=3D=3D=3Dd.itemId&&(=
this._idDimIdx=3Dh),n&&(c.storeDimIndex=3Dh)}this.dimensions=3Da,this._dimI=
nfos=3Dr,this._initGetDimensionInfo(l),this.hostModel=3De,this._invertedInd=
icesMap=3Ds,this._dimOmitted&&(i=3Dthis._dimIdxToName=3DN(),E(a,function(t)=
{i.set(r[t].storeDimIndex,t)}))}function Dv(t,e){rf(t)||(t=3Dsf(t));for(var=
 n,i,o=3D(e=3De||{}).coordDimensions||[],r=3De.dimensionsDefine||t.dimensio=
nsDefine||[],a=3DN(),s=3D[],l=3D(u=3Dt,n=3Do,p=3De.dimensionsCount,i=3DMath=
.max(u.dimensionsDetectedCount||1,n.length,r.length,p||0),E(n,function(t){O=
(t)&&(t=3Dt.dimsDef)&&(i=3DMath.max(i,t.length))}),i),u=3De.canOmitUnusedDi=
mensions&&30<l,h=3Dr=3D=3D=3Dt.dimensionsDefine,c=3Dh?fv(t):dv(r),p=3De.enc=
odeDefine,d=3DN(p=3D!p&&e.encodeDefaulter?e.encodeDefaulter(t,l):p),f=3Dnew=
 pg(l),g=3D0;g<f.length;g++)f[g]=3D-1;function y(t){var e,n,i,o=3Df[t];retu=
rn o<0?(e=3DO(e=3Dr[t])?e:{name:e},n=3Dnew sv,null!=3D(i=3De.name)&&null!=
=3Dc.get(i)&&(n.name=3Dn.displayName=3Di),null!=3De.type&&(n.type=3De.type)=
,null!=3De.displayName&&(n.displayName=3De.displayName),f[t]=3Ds.length,n.s=
toreDimIndex=3Dt,s.push(n),n):s[o]}if(!u)for(g=3D0;g<l;g++)y(g);d.each(func=
tion(t,n){var i,t=3Dbr(t).slice();1=3D=3D=3Dt.length&&!H(t[0])&&t[0]<0?d.se=
t(n,!1):(i=3Dd.set(n,[]),E(t,function(t,e){t=3DH(t)?c.get(t):t;null!=3Dt&&t=
<l&&v(y(i[e]=3Dt),n,e)}))});var m=3D0;function v(t,e,n){null!=3DQp.get(e)?t=
.otherDims[e]=3Dn:(t.coordDim=3De,t.coordDimIndex=3Dn,a.set(e,!0))}E(o,func=
tion(t){H(t)?(r=3Dt,o=3D{}):(r=3D(o=3Dt).name,t=3Do.ordinalMeta,o.ordinalMe=
ta=3Dnull,(o=3DP({},o)).ordinalMeta=3Dt,n=3Do.dimsDef,i=3Do.otherDims,o.nam=
e=3Do.coordDim=3Do.coordDimIndex=3Do.dimsDef=3Do.otherDims=3Dnull);var n,i,=
o,r,e=3Dd.get(r);if(!1!=3D=3De){if(!(e=3Dbr(e)).length)for(var a=3D0;a<(n&&=
n.length||1);a++){for(;m<l&&null!=3Dy(m).coordDim;)m++;m<l&&e.push(m++)}E(e=
,function(t,e){t=3Dy(t);h&&null!=3Do.type&&(t.type=3Do.type),v(B(t,o),r,e),=
null=3D=3Dt.name&&n&&(O(e=3Dn[e])||(e=3D{name:e}),t.name=3Dt.displayName=3D=
e.name,t.defaultTooltip=3De.defaultTooltip),i&&B(t.otherDims,i)})}});var _=
=3De.generateCoord,x=3Dnull!=3D(w=3De.generateCoordCount),w=3D_?w||1:0,b=3D=
_||"value";function S(t){null=3D=3Dt.name&&(t.name=3Dt.coordDim)}if(u)E(s,f=
unction(t){S(t)}),s.sort(function(t,e){return t.storeDimIndex-e.storeDimInd=
ex});else for(var M=3D0;M<l;M++){var T=3Dy(M);null=3D=3DT.coordDim&&(T.coor=
dDim=3Dfunction(t,e,n){if(n||e.hasKey(t)){for(var i=3D0;e.hasKey(t+i);)i++;=
t+=3Di}return e.set(t,!0),t}(b,a,x),T.coordDimIndex=3D0,(!_||w<=3D0)&&(T.is=
ExtraCoord=3D!0),w--),S(T),null!=3DT.type||pd(t,M)!=3D=3Dsd.Must&&(!T.isExt=
raCoord||null=3D=3DT.otherDims.itemName&&null=3D=3DT.otherDims.seriesName)|=
|(T.type=3D"ordinal")}for(var I=3Ds,C=3DN(),D=3D0;D<I.length;D++){var k=3DI=
[D],A=3Dk.name,L=3DC.get(A)||0;0<L&&(k.name=3DA+(L-1)),L++,C.set(A,L)}retur=
n new hv({source:t,dimensions:s,fullDimensionCount:l,dimensionOmitted:u})}f=
unction kv(t){this.coordSysDims=3D[],this.axisMap=3DN(),this.categoryAxisMa=
p=3DN(),this.coordSysName=3Dt}var Av=3D{cartesian2d:function(t,e,n,i){var o=
=3Dt.getReferringComponents("xAxis",Br).models[0],t=3Dt.getReferringCompone=
nts("yAxis",Br).models[0];e.coordSysDims=3D["x","y"],n.set("x",o),n.set("y"=
,t),Lv(o)&&(i.set("x",o),e.firstCategoryDimIndex=3D0),Lv(t)&&(i.set("y",t),=
null=3D=3De.firstCategoryDimIndex)&&(e.firstCategoryDimIndex=3D1)},singleAx=
is:function(t,e,n,i){t=3Dt.getReferringComponents("singleAxis",Br).models[0=
];e.coordSysDims=3D["single"],n.set("single",t),Lv(t)&&(i.set("single",t),e=
.firstCategoryDimIndex=3D0)},polar:function(t,e,n,i){var t=3Dt.getReferring=
Components("polar",Br).models[0],o=3Dt.findAxisModel("radiusAxis"),t=3Dt.fi=
ndAxisModel("angleAxis");e.coordSysDims=3D["radius","angle"],n.set("radius"=
,o),n.set("angle",t),Lv(o)&&(i.set("radius",o),e.firstCategoryDimIndex=3D0)=
,Lv(t)&&(i.set("angle",t),null=3D=3De.firstCategoryDimIndex)&&(e.firstCateg=
oryDimIndex=3D1)},geo:function(t,e,n,i){e.coordSysDims=3D["lng","lat"]},par=
allel:function(t,i,o,r){var a=3Dt.ecModel,t=3Da.getComponent("parallel",t.g=
et("parallelIndex")),s=3Di.coordSysDims=3Dt.dimensions.slice();E(t.parallel=
AxisIndex,function(t,e){var t=3Da.getComponent("parallelAxis",t),n=3Ds[e];o=
.set(n,t),Lv(t)&&(r.set(n,t),null=3D=3Di.firstCategoryDimIndex)&&(i.firstCa=
tegoryDimIndex=3De)})}};function Lv(t){return"category"=3D=3D=3Dt.get("type=
")}function Pv(t,e,n){var i,o,r,a=3D(n=3Dn||{}).byIndex,s=3Dn.stackedCoordD=
imension;pv(e.schema)?(o=3De.schema,i=3Do.dimensions,r=3De.store):i=3De;var=
 l,u,h,c,p,d,f=3D!(!t||!t.get("stack"));return E(i,function(t,e){H(t)&&(i[e=
]=3Dt=3D{name:t}),f&&!t.isExtraCoord&&(a||l||!t.ordinalMeta||(l=3Dt),u||"or=
dinal"=3D=3D=3Dt.type||"time"=3D=3D=3Dt.type||s&&s!=3D=3Dt.coordDim||(u=3Dt=
))}),!u||a||l||(a=3D!0),u&&(h=3D"__\0ecstackresult_"+t.id,c=3D"__\0ecstacke=
dover_"+t.id,l&&(l.createInvertedIndices=3D!0),p=3Du.coordDim,n=3Du.type,d=
=3D0,E(i,function(t){t.coordDim=3D=3D=3Dp&&d++}),e=3D{name:h,coordDim:p,coo=
rdDimIndex:d,type:n,isExtraCoord:!0,isCalculationCoord:!0,storeDimIndex:i.l=
ength},t=3D{name:c,coordDim:c,coordDimIndex:d+1,type:n,isExtraCoord:!0,isCa=
lculationCoord:!0,storeDimIndex:i.length+1},o?(r&&(e.storeDimIndex=3Dr.ensu=
reCalculationDimension(c,n),t.storeDimIndex=3Dr.ensureCalculationDimension(=
h,n)),o.appendCalculationDimension(e),o.appendCalculationDimension(t)):(i.p=
ush(e),i.push(t))),{stackedDimension:u&&u.name,stackedByDimension:l&&l.name=
,isStackedByIndex:a,stackedOverDimension:c,stackResultDimension:h}}function=
 Ov(t,e){return!!e&&e=3D=3D=3Dt.getCalculationInfo("stackedDimension")}func=
tion Rv(t,e){return Ov(t,e)?t.getCalculationInfo("stackResultDimension"):e}=
function Nv(t,e,n){n=3Dn||{};var i,o,r,a,s,l,u=3De.getSourceManager(),h=3D!=
1,t=3D(t?(h=3D!0,i=3Dsf(t)):h=3D(i=3Du.getSource()).sourceFormat=3D=3D=3DJp=
,function(t){var e=3Dt.get("coordinateSystem"),n=3Dnew kv(e);if(e=3DAv[e])r=
eturn e(t,n,n.axisMap,n.categoryAxisMap),n}(e)),c=3D(l=3Dt,c=3D(c=3De).get(=
"coordinateSystem"),c=3DAd.get(c),p=3D(p=3Dl&&l.coordSysDims?F(l.coordSysDi=
ms,function(t){var e=3D{name:t},t=3Dl.axisMap.get(t);return t&&(t=3Dt.get("=
type"),e.type=3D"category"=3D=3D=3D(t=3Dt)?"ordinal":"time"=3D=3D=3Dt?"time=
":"float"),e}):p)||c&&(c.getDimensionsInfo?c.getDimensionsInfo():c.dimensio=
ns.slice())||["x","y"]),p=3Dn.useEncodeDefaulter,p=3DD(p)?p:p?M(ud,c,e):nul=
l,c=3D{coordDimensions:c,generateCoord:n.generateCoord,encodeDefine:e.getEn=
code(),encodeDefaulter:p,canOmitUnusedDimensions:!h},p=3DDv(i,c),d=3D(c=3Dp=
.dimensions,o=3Dn.createInvertedIndices,(r=3Dt)&&E(c,function(t,e){var n=3D=
t.coordDim,n=3Dr.categoryAxisMap.get(n);n&&(null=3D=3Da&&(a=3De),t.ordinalM=
eta=3Dn.getOrdinalMeta(),o)&&(t.createInvertedIndices=3D!0),null!=3Dt.other=
Dims.itemName&&(s=3D!0)}),s||null=3D=3Da||(c[a].otherDims.itemName=3D0),a),=
n=3Dh?null:u.getSharedDataStore(p),t=3DPv(e,{schema:p,store:n}),c=3Dnew Cv(=
p,e),p=3D(c.setCalculationInfo(t),null=3D=3Dd||(u=3Di).sourceFormat!=3D=3DJ=
p||V(Tr(function(t){for(var e=3D0;e<t.length&&null=3D=3Dt[e];)e++;return t[=
e]}(u.data||[])))?null:function(t,e,n,i){return i=3D=3D=3Dd?n:this.defaultD=
imValueGetter(t,e,n,i)});return c.hasItemOption=3D!1,c.initData(h?i:n,null,=
p),c}zv.prototype.getSetting=3Dfunction(t){return this._setting[t]},zv.prot=
otype.unionExtent=3Dfunction(t){var e=3Dthis._extent;t[0]<e[0]&&(e[0]=3Dt[0=
]),t[1]>e[1]&&(e[1]=3Dt[1])},zv.prototype.unionExtentFromData=3Dfunction(t,=
e){this.unionExtent(t.getApproximateExtent(e))},zv.prototype.getExtent=3Dfu=
nction(){return this._extent.slice()},zv.prototype.setExtent=3Dfunction(t,e=
){var n=3Dthis._extent;isNaN(t)||(n[0]=3Dt),isNaN(e)||(n[1]=3De)},zv.protot=
ype.isInExtentRange=3Dfunction(t){return this._extent[0]<=3Dt&&this._extent=
[1]>=3Dt},zv.prototype.isBlank=3Dfunction(){return this._isBlank},zv.protot=
ype.setBlank=3Dfunction(t){this._isBlank=3Dt};var Ev=3Dzv;function zv(t){th=
is._setting=3Dt||{},this._extent=3D[1/0,-1/0]}Qr(Ev);var Bv=3D0,Fv=3D(Vv.cr=
eateByAxisModel=3Dfunction(t){var t=3Dt.option,e=3Dt.data,e=3De&&F(e,Hv);re=
turn new Vv({categories:e,needCollect:!e,deduplication:!1!=3D=3Dt.dedplicat=
ion})},Vv.prototype.getOrdinal=3Dfunction(t){return this._getOrCreateMap().=
get(t)},Vv.prototype.parseAndCollect=3Dfunction(t){var e,n,i=3Dthis._needCo=
llect;return H(t)||i?(i&&!this._deduplication?(e=3Dthis.categories.length,t=
his.categories[e]=3Dt):null=3D=3D(e=3D(n=3Dthis._getOrCreateMap()).get(t))&=
&(i?(e=3Dthis.categories.length,this.categories[e]=3Dt,n.set(t,e)):e=3DNaN)=
,e):t},Vv.prototype._getOrCreateMap=3Dfunction(){return this._map||(this._m=
ap=3DN(this.categories))},Vv);function Vv(t){this.categories=3Dt.categories=
||[],this._needCollect=3Dt.needCollect,this._deduplication=3Dt.deduplicatio=
n,this.uid=3D++Bv}function Hv(t){return O(t)&&null!=3Dt.value?t.value:t+""}=
function Wv(t){return"interval"=3D=3D=3Dt.type||"log"=3D=3D=3Dt.type}functi=
on Gv(t,e,n,i){var o=3D{},r=3Dt[1]-t[0],r=3Do.interval=3Dfr(r/e,!0),e=3D(nu=
ll!=3Dn&&r<n&&(r=3Do.interval=3Dn),null!=3Di&&i<r&&(r=3Do.interval=3Di),o.i=
ntervalPrecision=3DUv(r));return n=3Do.niceTickExtent=3D[nr(Math.ceil(t[0]/=
r)*r,e),nr(Math.floor(t[1]/r)*r,e)],i=3Dt,isFinite(n[0])||(n[0]=3Di[0]),isF=
inite(n[1])||(n[1]=3Di[1]),Yv(n,0,i),Yv(n,1,i),n[0]>n[1]&&(n[0]=3Dn[1]),o}f=
unction Xv(t){var e=3DMath.pow(10,dr(t)),t=3Dt/e;return t?2=3D=3D=3Dt?t=3D3=
:3=3D=3D=3Dt?t=3D5:t*=3D2:t=3D1,nr(t*e)}function Uv(t){return or(t)+2}funct=
ion Yv(t,e,n){t[e]=3DMath.max(Math.min(t[e],n[1]),n[0])}function Zv(t,e){re=
turn t>=3De[0]&&t<=3De[1]}function qv(t,e){return e[1]=3D=3D=3De[0]?.5:(t-e=
[0])/(e[1]-e[0])}function jv(t,e){return t*(e[1]-e[0])+e[0]}u(Qv,Kv=3DEv),Q=
v.prototype.parse=3Dfunction(t){return null=3D=3Dt?NaN:H(t)?this._ordinalMe=
ta.getOrdinal(t):Math.round(t)},Qv.prototype.contain=3Dfunction(t){return Z=
v(t=3Dthis.parse(t),this._extent)&&null!=3Dthis._ordinalMeta.categories[t]}=
,Qv.prototype.normalize=3Dfunction(t){return qv(t=3Dthis._getTickNumber(thi=
s.parse(t)),this._extent)},Qv.prototype.scale=3Dfunction(t){return t=3DMath=
.round(jv(t,this._extent)),this.getRawOrdinalNumber(t)},Qv.prototype.getTic=
ks=3Dfunction(){for(var t=3D[],e=3Dthis._extent,n=3De[0];n<=3De[1];)t.push(=
{value:n}),n++;return t},Qv.prototype.getMinorTicks=3Dfunction(t){},Qv.prot=
otype.setSortInfo=3Dfunction(t){if(null!=3Dt){for(var e=3Dt.ordinalNumbers,=
n=3Dthis._ordinalNumbersByTick=3D[],i=3Dthis._ticksByOrdinalNumber=3D[],o=
=3D0,r=3Dthis._ordinalMeta.categories.length,a=3DMath.min(r,e.length);o<a;+=
+o){var s=3De[o];i[n[o]=3Ds]=3Do}for(var l=3D0;o<r;++o){for(;null!=3Di[l];)=
l++;n.push(l),i[l]=3Do}}else this._ordinalNumbersByTick=3Dthis._ticksByOrdi=
nalNumber=3Dnull},Qv.prototype._getTickNumber=3Dfunction(t){var e=3Dthis._t=
icksByOrdinalNumber;return e&&0<=3Dt&&t<e.length?e[t]:t},Qv.prototype.getRa=
wOrdinalNumber=3Dfunction(t){var e=3Dthis._ordinalNumbersByTick;return e&&0=
<=3Dt&&t<e.length?e[t]:t},Qv.prototype.getLabel=3Dfunction(t){if(!this.isBl=
ank())return t=3Dthis.getRawOrdinalNumber(t.value),null=3D=3D(t=3Dthis._ord=
inalMeta.categories[t])?"":t+""},Qv.prototype.count=3Dfunction(){return thi=
s._extent[1]-this._extent[0]+1},Qv.prototype.unionExtentFromData=3Dfunction=
(t,e){this.unionExtent(t.getApproximateExtent(e))},Qv.prototype.isInExtentR=
ange=3Dfunction(t){return t=3Dthis._getTickNumber(t),this._extent[0]<=3Dt&&=
this._extent[1]>=3Dt},Qv.prototype.getOrdinalMeta=3Dfunction(){return this.=
_ordinalMeta},Qv.prototype.calcNiceTicks=3Dfunction(){},Qv.prototype.calcNi=
ceExtent=3Dfunction(){},Qv.type=3D"ordinal";var Kv,$v=3DQv;function Qv(t){v=
ar t=3DKv.call(this,t)||this,e=3D(t.type=3D"ordinal",t.getSetting("ordinalM=
eta"));return V(e=3De||new Fv({}))&&(e=3Dnew Fv({categories:F(e,function(t)=
{return O(t)?t.value:t})})),t._ordinalMeta=3De,t._extent=3Dt.getSetting("ex=
tent")||[0,e.categories.length-1],t}Ev.registerClass($v);var Jv,t_=3Dnr,e_=
=3D(u(n_,Jv=3DEv),n_.prototype.parse=3Dfunction(t){return t},n_.prototype.c=
ontain=3Dfunction(t){return Zv(t,this._extent)},n_.prototype.normalize=3Dfu=
nction(t){return qv(t,this._extent)},n_.prototype.scale=3Dfunction(t){retur=
n jv(t,this._extent)},n_.prototype.setExtent=3Dfunction(t,e){var n=3Dthis._=
extent;isNaN(t)||(n[0]=3DparseFloat(t)),isNaN(e)||(n[1]=3DparseFloat(e))},n=
_.prototype.unionExtent=3Dfunction(t){var e=3Dthis._extent;t[0]<e[0]&&(e[0]=
=3Dt[0]),t[1]>e[1]&&(e[1]=3Dt[1]),this.setExtent(e[0],e[1])},n_.prototype.g=
etInterval=3Dfunction(){return this._interval},n_.prototype.setInterval=3Df=
unction(t){this._interval=3Dt,this._niceExtent=3Dthis._extent.slice(),this.=
_intervalPrecision=3DUv(t)},n_.prototype.getTicks=3Dfunction(t){var e=3Dthi=
s._interval,n=3Dthis._extent,i=3Dthis._niceExtent,o=3Dthis._intervalPrecisi=
on,r=3D[];if(e){n[0]<i[0]&&r.push(t?{value:t_(i[0]-e,o)}:{value:n[0]});for(=
var a=3Di[0];a<=3Di[1]&&(r.push({value:a}),(a=3Dt_(a+e,o))!=3D=3Dr[r.length=
-1].value);)if(1e4<r.length)return[];var s=3Dr.length?r[r.length-1].value:i=
[1];n[1]>s&&r.push(t?{value:t_(s+e,o)}:{value:n[1]})}return r},n_.prototype=
.getMinorTicks=3Dfunction(t){for(var e=3Dthis.getTicks(!0),n=3D[],i=3Dthis.=
getExtent(),o=3D1;o<e.length;o++){for(var r=3De[o],a=3De[o-1],s=3D0,l=3D[],=
u=3D(r.value-a.value)/t;s<t-1;){var h=3Dt_(a.value+(s+1)*u);h>i[0]&&h<i[1]&=
&l.push(h),s++}n.push(l)}return n},n_.prototype.getLabel=3Dfunction(t,e){re=
turn null=3D=3Dt?"":(null=3D=3D(e=3De&&e.precision)?e=3Dor(t.value)||0:"aut=
o"=3D=3D=3De&&(e=3Dthis._intervalPrecision),Ip(t_(t.value,e,!0)))},n_.proto=
type.calcNiceTicks=3Dfunction(t,e,n){t=3Dt||5;var i=3Dthis._extent,o=3Di[1]=
-i[0];isFinite(o)&&(o<0&&i.reverse(),o=3DGv(i,t,e,n),this._intervalPrecisio=
n=3Do.intervalPrecision,this._interval=3Do.interval,this._niceExtent=3Do.ni=
ceTickExtent)},n_.prototype.calcNiceExtent=3Dfunction(t){var e=3Dthis._exte=
nt,n=3D(e[0]=3D=3D=3De[1]&&(0!=3D=3De[0]?(n=3DMath.abs(e[0]),t.fixMax||(e[1=
]+=3Dn/2),e[0]-=3Dn/2):e[1]=3D1),e[1]-e[0]),n=3D(isFinite(n)||(e[0]=3D0,e[1=
]=3D1),this.calcNiceTicks(t.splitNumber,t.minInterval,t.maxInterval),this._=
interval);t.fixMin||(e[0]=3Dt_(Math.floor(e[0]/n)*n)),t.fixMax||(e[1]=3Dt_(=
Math.ceil(e[1]/n)*n))},n_.prototype.setNiceExtent=3Dfunction(t,e){this._nic=
eExtent=3D[t,e]},n_.type=3D"interval",n_);function n_(){var t=3Dnull!=3D=3D=
Jv&&Jv.apply(this,arguments)||this;return t.type=3D"interval",t._interval=
=3D0,t._intervalPrecision=3D2,t}Ev.registerClass(e_);var i_=3D"undefined"!=
=3Dtypeof Float32Array,o_=3Di_?Float32Array:Array;function r_(t){return V(t=
)?i_?new Float32Array(t):t:new o_(t)}function a_(t){return t.get("stack")||=
"__ec_stack_"+t.seriesIndex}function s_(t){return t.dim+t.index}function l_=
(t,e){var n=3D[];return e.eachSeriesByType(t,function(t){var e;(e=3Dt).coor=
dinateSystem&&"cartesian2d"=3D=3D=3De.coordinateSystem.type&&n.push(t)}),n}=
function u_(t){var a,d,u=3Dfunction(t){var e,l=3D{},n=3D(E(t,function(t){va=
r e=3Dt.coordinateSystem.getBaseAxis();if("time"=3D=3D=3De.type||"value"=3D=
=3D=3De.type)for(var t=3Dt.getData(),n=3De.dim+"_"+e.index,i=3Dt.getDimensi=
onIndex(t.mapDimension(e.dim)),o=3Dt.getStore(),r=3D0,a=3Do.count();r<a;++r=
){var s=3Do.get(i,r);l[n]?l[n].push(s):l[n]=3D[s]}}),{});for(e in l)if(l.ha=
sOwnProperty(e)){var i=3Dl[e];if(i){i.sort(function(t,e){return t-e});for(v=
ar o=3Dnull,r=3D1;r<i.length;++r){var a=3Di[r]-i[r-1];0<a&&(o=3Dnull=3D=3D=
=3Do?a:Math.min(o,a))}n[e]=3Do}}return n}(t),h=3D[];return E(t,function(t){=
var e,n,i=3Dt.coordinateSystem.getBaseAxis(),o=3Di.getExtent(),r=3D(e=3D"ca=
tegory"=3D=3D=3Di.type?i.getBandWidth():"value"=3D=3D=3Di.type||"time"=3D=
=3D=3Di.type?(e=3Di.dim+"_"+i.index,e=3Du[e],r=3DMath.abs(o[1]-o[0]),n=3Di.=
scale.getExtent(),n=3DMath.abs(n[1]-n[0]),e?r/n*e:r):(n=3Dt.getData(),Math.=
abs(o[1]-o[0])/n.count()),er(t.get("barWidth"),e)),o=3Der(t.get("barMaxWidt=
h"),e),a=3Der(t.get("barMinWidth")||((n=3Dt).pipelineContext&&n.pipelineCon=
text.large?.5:1),e),s=3Dt.get("barGap"),l=3Dt.get("barCategoryGap");h.push(=
{bandWidth:e,barWidth:r,barMaxWidth:o,barMinWidth:a,barGap:s,barCategoryGap=
:l,axisKey:s_(i),stackId:a_(t)})}),a=3D{},E(h,function(t,e){var n=3Dt.axisK=
ey,i=3Dt.bandWidth,i=3Da[n]||{bandWidth:i,remainedWidth:i,autoWidthCount:0,=
categoryGap:null,gap:"20%",stacks:{}},o=3Di.stacks,n=3D(a[n]=3Di,t.stackId)=
,r=3D(o[n]||i.autoWidthCount++,o[n]=3Do[n]||{width:0,maxWidth:0},t.barWidth=
),r=3D(r&&!o[n].width&&(o[n].width=3Dr,r=3DMath.min(i.remainedWidth,r),i.re=
mainedWidth-=3Dr),t.barMaxWidth),r=3D(r&&(o[n].maxWidth=3Dr),t.barMinWidth)=
,o=3D(r&&(o[n].minWidth=3Dr),t.barGap),n=3D(null!=3Do&&(i.gap=3Do),t.barCat=
egoryGap);null!=3Dn&&(i.categoryGap=3Dn)}),d=3D{},E(a,function(t,n){d[n]=3D=
{};var e=3Dt.stacks,i=3Dt.bandWidth,o=3Dt.categoryGap,r=3D(null=3D=3Do&&(r=
=3Dht(e).length,o=3DMath.max(35-4*r,15)+"%"),er(o,i)),a=3Der(t.gap,1),s=3Dt=
.remainedWidth,l=3Dt.autoWidthCount,u=3D(s-r)/(l+(l-1)*a),u=3DMath.max(u,0)=
;E(e,function(t){var e,n=3Dt.maxWidth,i=3Dt.minWidth;t.width?(e=3Dt.width,n=
&&(e=3DMath.min(e,n)),i&&(e=3DMath.max(e,i)),t.width=3De,s-=3De+a*e,l--):(e=
=3Du,n&&n<e&&(e=3DMath.min(n,s)),(e=3Di&&e<i?i:e)!=3D=3Du&&(t.width=3De,s-=
=3De+a*e,l--))}),u=3D(s-r)/(l+(l-1)*a),u=3DMath.max(u,0);var h,c=3D0,p=3D(E=
(e,function(t,e){t.width||(t.width=3Du),c+=3D(h=3Dt).width*(1+a)}),h&&(c-=
=3Dh.width*a),-c/2);E(e,function(t,e){d[n][e]=3Dd[n][e]||{bandWidth:i,offse=
t:p,width:t.width},p+=3Dt.width*(1+a)})}),d}u(d_,h_=3De_),d_.prototype.getL=
abel=3Dfunction(t){var e=3Dthis.getSetting("useUTC");return hp(t.value,rp[f=
unction(t){switch(t){case"year":case"month":return"day";case"millisecond":r=
eturn"millisecond";default:return"second"}}(up(this._minLevelUnit))]||rp.se=
cond,e,this.getSetting("locale"))},d_.prototype.getFormattedLabel=3Dfunctio=
n(t,e,n){var i=3Dthis.getSetting("useUTC"),o=3Dthis.getSetting("locale"),r=
=3Dnull;if(H(n))r=3Dn;else if(D(n))r=3Dn(t.value,e,{level:t.level});else{va=
r a=3DP({},ip);if(0<t.level)for(var s=3D0;s<ap.length;++s)a[ap[s]]=3D"{prim=
ary|"+a[ap[s]]+"}";var l=3Dn?!1=3D=3D=3Dn.inherit?n:B(n,a):a,u=3Dcp(t.value=
,i);if(l[u])r=3Dl[u];else if(l.inherit){for(s=3Dsp.indexOf(u)-1;0<=3Ds;--s)=
if(l[u]){r=3Dl[u];break}r=3Dr||a.none}V(r)&&(e=3Dnull=3D=3Dt.level?0:0<=3Dt=
.level?t.level:r.length+t.level,r=3Dr[e=3DMath.min(e,r.length-1)])}return h=
p(new Date(t.value),r,i,o)},d_.prototype.getTicks=3Dfunction(){var t=3Dthis=
._interval,e=3Dthis._extent,n=3D[];return t&&(n.push({value:e[0],level:0}),=
t=3Dthis.getSetting("useUTC"),t=3Dfunction(t,b,S,M){var e=3Dsp,n=3D0;functi=
on i(t,e,n){var i,o,r=3D[],a=3D!e.length;if(!function(t,e,n,i){function o(t=
){return pp(c,t,i)=3D=3D=3Dpp(p,t,i)}function r(){return o("year")}function=
 a(){return r()&&o("month")}function s(){return a()&&o("day")}function l(){=
return s()&&o("hour")}function u(){return l()&&o("minute")}function h(){ret=
urn u()&&o("second")}var c=3Dcr(e),p=3Dcr(n);switch(t){case"year":return r(=
);case"month":return a();case"day":return s();case"hour":return l();case"mi=
nute":return u();case"second":return h();case"millisecond":return h()&&o("m=
illisecond")}}(up(t),M[0],M[1],S)){a&&(e=3D[{value:function(t,e,n){var i=3D=
new Date(t);switch(up(e)){case"year":case"month":i[xp(n)](0);case"day":i[wp=
(n)](1);case"hour":i[bp(n)](0);case"minute":i[Sp(n)](0);case"second":i[Mp(n=
)](0),i[Tp(n)](0)}return i.getTime()}(new Date(M[0]),t,S)},{value:M[1]}]);f=
or(var s=3D0;s<e.length-1;s++){var l=3De[s].value,u=3De[s+1].value;if(l!=3D=
=3Du){var h=3Dvoid 0,c=3Dvoid 0,p=3Dvoid 0;switch(t){case"year":h=3DMath.ma=
x(1,Math.round(b/np/365)),c=3Ddp(S),p=3DS?"setUTCFullYear":"setFullYear";br=
eak;case"half-year":case"quarter":case"month":o=3Db,h=3D6<(o/=3D30*np)?6:3<=
o?3:2<o?2:1,c=3Dfp(S),p=3Dxp(S);break;case"week":case"half-week":case"day":=
o=3Db,h=3D16<(o/=3Dnp)?16:7.5<o?7:3.5<o?4:1.5<o?2:1,c=3Dgp(S),p=3Dwp(S);bre=
ak;case"half-day":case"quarter-day":case"hour":i=3Db,h=3D12<(i/=3Dep)?12:6<=
i?6:3.5<i?4:2<i?2:1,c=3Dyp(S),p=3Dbp(S);break;case"minute":h=3Df_(b,!0),c=
=3Dmp(S),p=3DSp(S);break;case"second":h=3Df_(b,!1),c=3Dvp(S),p=3DMp(S);brea=
k;case"millisecond":h=3Dfr(b,!0),c=3D_p(S),p=3DTp(S)}w=3Dx=3D_=3Dv=3Dm=3Dy=
=3Dg=3Df=3Dd=3Dvoid 0;for(var d=3Dh,f=3Dl,g=3Du,y=3Dc,m=3Dp,v=3Dr,_=3Dnew D=
ate(f),x=3Df,w=3D_[y]();x<g&&x<=3DM[1];)v.push({value:x}),_[m](w+=3Dd),x=3D=
_.getTime();v.push({value:x,notAdd:!0}),"year"=3D=3D=3Dt&&1<n.length&&0=3D=
=3D=3Ds&&n.unshift({value:n[0].value-h})}}for(s=3D0;s<r.length;s++)n.push(r=
[s])}}for(var o=3D[],r=3D[],a=3D0,s=3D0,l=3D0;l<e.length&&n++<1e4;++l){var =
u=3Dup(e[l]);if(function(t){return t=3D=3D=3Dup(t)}(e[l])&&(i(e[l],o[o.leng=
th-1]||[],r),u!=3D=3D(e[l+1]?up(e[l+1]):null))){if(r.length){s=3Da,r.sort(f=
unction(t,e){return t.value-e.value});for(var h=3D[],c=3D0;c<r.length;++c){=
var p=3Dr[c].value;0!=3D=3Dc&&r[c-1].value=3D=3D=3Dp||(h.push(r[c]),p>=3DM[=
0]&&p<=3DM[1]&&a++)}u=3D(M[1]-M[0])/b;if(1.5*u<a&&u/1.5<s)break;if(o.push(h=
),u<a||t=3D=3D=3De[l])break}r=3D[]}}var d=3Dut(F(o,function(t){return ut(t,=
function(t){return t.value>=3DM[0]&&t.value<=3DM[1]&&!t.notAdd})}),function=
(t){return 0<t.length}),f=3D[],g=3Dd.length-1;for(l=3D0;l<d.length;++l)for(=
var y=3Dd[l],m=3D0;m<y.length;++m)f.push({value:y[m].value,level:g-l});f.so=
rt(function(t,e){return t.value-e.value});var v=3D[];for(l=3D0;l<f.length;+=
+l)0!=3D=3Dl&&f[l].value=3D=3D=3Df[l-1].value||v.push(f[l]);return v}(this.=
_minLevelUnit,this._approxInterval,t,e),(n=3Dn.concat(t)).push({value:e[1],=
level:0})),n},d_.prototype.calcNiceExtent=3Dfunction(t){var e,n=3Dthis._ext=
ent;n[0]=3D=3D=3Dn[1]&&(n[0]-=3Dnp,n[1]+=3Dnp),n[1]=3D=3D=3D-1/0&&n[0]=3D=
=3D=3D1/0&&(e=3Dnew Date,n[1]=3D+new Date(e.getFullYear(),e.getMonth(),e.ge=
tDate()),n[0]=3Dn[1]-np),this.calcNiceTicks(t.splitNumber,t.minInterval,t.m=
axInterval)},d_.prototype.calcNiceTicks=3Dfunction(t,e,n){var i=3Dthis._ext=
ent,i=3Di[1]-i[0],i=3D(this._approxInterval=3Di/(t=3Dt||10),null!=3De&&this=
._approxInterval<e&&(this._approxInterval=3De),null!=3Dn&&this._approxInter=
val>n&&(this._approxInterval=3Dn),p_.length),t=3DMath.min(function(t,e,n,i)=
{for(;n<i;){var o=3Dn+i>>>1;t[o][1]<e?n=3D1+o:i=3Do}return n}(p_,this._appr=
oxInterval,0,i),i-1);this._interval=3Dp_[t][1],this._minLevelUnit=3Dp_[Math=
.max(t-1,0)][0]},d_.prototype.parse=3Dfunction(t){return W(t)?t:+cr(t)},d_.=
prototype.contain=3Dfunction(t){return Zv(this.parse(t),this._extent)},d_.p=
rototype.normalize=3Dfunction(t){return qv(this.parse(t),this._extent)},d_.=
prototype.scale=3Dfunction(t){return jv(t,this._extent)},d_.type=3D"time";v=
ar h_,c_=3Dd_,p_=3D[["second",Jc],["minute",tp],["hour",ep],["quarter-day",=
6*ep],["half-day",12*ep],["day",1.2*np],["half-week",3.5*np],["week",7*np],=
["month",31*np],["quarter",95*np],["half-year",jr/2],["year",jr]];function =
d_(t){t=3Dh_.call(this,t)||this;return t.type=3D"time",t}function f_(t,e){r=
eturn 30<(t/=3De?tp:Jc)?30:20<t?20:15<t?15:10<t?10:5<t?5:2<t?2:1}Ev.registe=
rClass(c_);var g_,y_=3DEv.prototype,m_=3De_.prototype,v_=3Dnr,__=3DMath.flo=
or,x_=3DMath.ceil,w_=3DMath.pow,b_=3DMath.log,S_=3D(u(M_,g_=3DEv),M_.protot=
ype.getTicks=3Dfunction(t){var e=3Dthis._originalScale,n=3Dthis._extent,i=
=3De.getExtent();return F(m_.getTicks.call(this,t),function(t){var t=3Dt.va=
lue,e=3Dnr(w_(this.base,t)),e=3Dt=3D=3D=3Dn[0]&&this._fixMin?T_(e,i[0]):e;r=
eturn{value:t=3D=3D=3Dn[1]&&this._fixMax?T_(e,i[1]):e}},this)},M_.prototype=
.setExtent=3Dfunction(t,e){var n=3Db_(this.base);t=3Db_(Math.max(0,t))/n,e=
=3Db_(Math.max(0,e))/n,m_.setExtent.call(this,t,e)},M_.prototype.getExtent=
=3Dfunction(){var t=3Dthis.base,e=3Dy_.getExtent.call(this),t=3D(e[0]=3Dw_(=
t,e[0]),e[1]=3Dw_(t,e[1]),this._originalScale.getExtent());return this._fix=
Min&&(e[0]=3DT_(e[0],t[0])),this._fixMax&&(e[1]=3DT_(e[1],t[1])),e},M_.prot=
otype.unionExtent=3Dfunction(t){this._originalScale.unionExtent(t);var e=3D=
this.base;t[0]=3Db_(t[0])/b_(e),t[1]=3Db_(t[1])/b_(e),y_.unionExtent.call(t=
his,t)},M_.prototype.unionExtentFromData=3Dfunction(t,e){this.unionExtent(t=
.getApproximateExtent(e))},M_.prototype.calcNiceTicks=3Dfunction(t){t=3Dt||=
10;var e=3Dthis._extent,n=3De[1]-e[0];if(!(n=3D=3D1/0||n<=3D0)){var i=3Dpr(=
n);for(t/n*i<=3D.5&&(i*=3D10);!isNaN(i)&&Math.abs(i)<1&&0<Math.abs(i);)i*=
=3D10;t=3D[nr(x_(e[0]/i)*i),nr(__(e[1]/i)*i)];this._interval=3Di,this._nice=
Extent=3Dt}},M_.prototype.calcNiceExtent=3Dfunction(t){m_.calcNiceExtent.ca=
ll(this,t),this._fixMin=3Dt.fixMin,this._fixMax=3Dt.fixMax},M_.prototype.pa=
rse=3Dfunction(t){return t},M_.prototype.contain=3Dfunction(t){return Zv(t=
=3Db_(t)/b_(this.base),this._extent)},M_.prototype.normalize=3Dfunction(t){=
return qv(t=3Db_(t)/b_(this.base),this._extent)},M_.prototype.scale=3Dfunct=
ion(t){return t=3Djv(t,this._extent),w_(this.base,t)},M_.type=3D"log",M_),K=
y=3DS_.prototype;function M_(){var t=3Dnull!=3D=3Dg_&&g_.apply(this,argumen=
ts)||this;return t.type=3D"log",t.base=3D10,t._originalScale=3Dnew e_,t._in=
terval=3D0,t}function T_(t,e){return v_(t,or(e))}Ky.getMinorTicks=3Dm_.getM=
inorTicks,Ky.getLabel=3Dm_.getLabel,Ev.registerClass(S_);C_.prototype._prep=
areParams=3Dfunction(t,e,n){n[1]<n[0]&&(n=3D[NaN,NaN]),this._dataMin=3Dn[0]=
,this._dataMax=3Dn[1];var i=3Dthis._isOrdinal=3D"ordinal"=3D=3D=3Dt.type,o=
=3D(this._needCrossZero=3D"interval"=3D=3D=3Dt.type&&e.getNeedCrossZero&&e.=
getNeedCrossZero(),this._modelMinRaw=3De.get("min",!0)),o=3D(D(o)?this._mod=
elMinNum=3DL_(t,o({min:n[0],max:n[1]})):"dataMin"!=3D=3Do&&(this._modelMinN=
um=3DL_(t,o)),this._modelMaxRaw=3De.get("max",!0));D(o)?this._modelMaxNum=
=3DL_(t,o({min:n[0],max:n[1]})):"dataMax"!=3D=3Do&&(this._modelMaxNum=3DL_(=
t,o)),i?this._axisDataLen=3De.getCategories().length:"boolean"=3D=3Dtypeof(=
t=3DV(n=3De.get("boundaryGap"))?n:[n||0,n||0])[0]||"boolean"=3D=3Dtypeof t[=
1]?this._boundaryGapInner=3D[0,0]:this._boundaryGapInner=3D[Do(t[0],1),Do(t=
[1],1)]},C_.prototype.calculate=3Dfunction(){var t=3Dthis._isOrdinal,e=3Dth=
is._dataMin,n=3Dthis._dataMax,i=3Dthis._axisDataLen,o=3Dthis._boundaryGapIn=
ner,r=3Dt?null:n-e||Math.abs(e),a=3D"dataMin"=3D=3D=3Dthis._modelMinRaw?e:t=
his._modelMinNum,s=3D"dataMax"=3D=3D=3Dthis._modelMaxRaw?n:this._modelMaxNu=
m,l=3Dnull!=3Da,u=3Dnull!=3Ds,e=3D(null=3D=3Da&&(a=3Dt?i?0:NaN:e-o[0]*r),nu=
ll=3D=3Ds&&(s=3Dt?i?i-1:NaN:n+o[1]*r),null!=3Da&&isFinite(a)||(a=3DNaN),nul=
l!=3Ds&&isFinite(s)||(s=3DNaN),vt(a)||vt(s)||t&&!i),n=3D(this._needCrossZer=
o&&(a=3D0<a&&0<s&&!l?0:a)<0&&s<0&&!u&&(s=3D0),this._determinedMin),o=3Dthis=
._determinedMax;return null!=3Dn&&(a=3Dn,l=3D!0),null!=3Do&&(s=3Do,u=3D!0),=
{min:a,max:s,minFixed:l,maxFixed:u,isBlank:e}},C_.prototype.modifyDataMinMa=
x=3Dfunction(t,e){this[k_[t]]=3De},C_.prototype.setDeterminedMinMax=3Dfunct=
ion(t,e){this[D_[t]]=3De},C_.prototype.freeze=3Dfunction(){this.frozen=3D!0=
};var I_=3DC_;function C_(t,e,n){this._prepareParams(t,e,n)}var D_=3D{min:"=
_determinedMin",max:"_determinedMax"},k_=3D{min:"_dataMin",max:"_dataMax"};=
function A_(t,e,n){return t.rawExtentInfo||(e=3Dnew I_(t,e,n),t.rawExtentIn=
fo=3De)}function L_(t,e){return null=3D=3De?null:vt(e)?NaN:t.parse(e)}funct=
ion P_(t,e){var n,i,o,r,a,s,l=3Dt.type,u=3DA_(t,e,t.getExtent()).calculate(=
),t=3D(t.setBlank(u.isBlank),u.min),h=3Du.max,c=3De.ecModel;return c&&"time=
"=3D=3D=3Dl&&(l=3Dl_("bar",c),n=3D!1,E(l,function(t){n=3Dn||t.getBaseAxis()=
=3D=3D=3De.axis}),n)&&(c=3Du_(l),l=3Dt,i=3Dh,c=3Dc,s=3D(s=3D(o=3De).axis.ge=
tExtent())[1]-s[0],t=3D(c=3Dvoid 0=3D=3D=3D(c=3Dfunction(t,e,n){if(t&&e)ret=
urn null!=3D(t=3Dt[s_(e)])&&null!=3Dn?t[a_(n)]:t}(c,o.axis))?{min:l,max:i}:=
(r=3D1/0,E(c,function(t){r=3DMath.min(t.offset,r)}),a=3D-1/0,E(c,function(t=
){a=3DMath.max(t.offset+t.width,a)}),r=3DMath.abs(r),a=3DMath.abs(a),{min:l=
-=3Dr/(o=3Dr+a)*(s=3D(c=3Di-l)/(1-(r+a)/s)-c),max:i+=3Da/o*s})).min,h=3Dc.m=
ax),{extent:[t,h],fixMin:u.minFixed,fixMax:u.maxFixed}}function O_(t,e){var=
 n=3DP_(t,e),i=3Dn.extent,o=3De.get("splitNumber"),r=3D(t instanceof S_&&(t=
.base=3De.get("logBase")),t.type),a=3De.get("interval"),r=3D"interval"=3D=
=3D=3Dr||"time"=3D=3D=3Dr;t.setExtent(i[0],i[1]),t.calcNiceExtent({splitNum=
ber:o,fixMin:n.fixMin,fixMax:n.fixMax,minInterval:r?e.get("minInterval"):nu=
ll,maxInterval:r?e.get("maxInterval"):null}),null!=3Da&&t.setInterval&&t.se=
tInterval(a)}function R_(t,e){if(e=3De||t.get("type"))switch(e){case"catego=
ry":return new $v({ordinalMeta:t.getOrdinalMeta?t.getOrdinalMeta():t.getCat=
egories(),extent:[1/0,-1/0]});case"time":return new c_({locale:t.ecModel.ge=
tLocaleModel(),useUTC:t.ecModel.get("useUTC")});default:return new(Ev.getCl=
ass(e)||e_)}}function N_(n){var i,o,e,t=3Dn.getLabelModel().get("formatter"=
),r=3D"category"=3D=3D=3Dn.type?n.scale.getExtent()[0]:null;return"time"=3D=
=3D=3Dn.scale.type?(o=3Dt,function(t,e){return n.scale.getFormattedLabel(t,=
e,o)}):H(t)?(e=3Dt,function(t){t=3Dn.scale.getLabel(t);return e.replace("{v=
alue}",null!=3Dt?t:"")}):D(t)?(i=3Dt,function(t,e){return null!=3Dr&&(e=3Dt=
.value-r),i(E_(n,t),e,null!=3Dt.level?{level:t.level}:null)}):function(t){r=
eturn n.scale.getLabel(t)}}function E_(t,e){return"category"=3D=3D=3Dt.type=
?t.scale.getLabel(e):e.value}function z_(t){var e,n,i,o=3Dt.model,r=3Dt.sca=
le;if(o.get(["axisLabel","show"])&&!r.isBlank()){var a,s,l=3Dr.getExtent(),=
u=3Dr instanceof $v?r.count():(a=3Dr.getTicks()).length,h=3Dt.getLabelModel=
(),c=3DN_(t),p=3D1;40<u&&(p=3DMath.ceil(u/40));for(var d=3D0;d<u;d+=3Dp){va=
r f=3Dc(a?a[d]:{value:l[0]+d},d),g=3D(f=3Dh.getTextRect(f),e=3Dh.get("rotat=
e")||0,n=3Di=3Dg=3Dn=3Dvoid 0,e=3De*Math.PI/180,n=3Df.width,g=3Df.height,i=
=3Dn*Math.abs(Math.cos(e))+Math.abs(g*Math.sin(e)),n=3Dn*Math.abs(Math.sin(=
e))+Math.abs(g*Math.cos(e)),new G(f.x,f.y,i,n));s?s.union(g):s=3Dg}return s=
}}function B_(t){t=3Dt.get("interval");return null=3D=3Dt?"auto":t}function=
 F_(t){return"category"=3D=3D=3Dt.type&&0=3D=3D=3DB_(t.getLabelModel())}fun=
ction V_(e,t){var n=3D{};return E(e.mapDimensionsAll(t),function(t){n[Rv(e,=
t)]=3D!0}),ht(n)}W_.prototype.getNeedCrossZero=3Dfunction(){return!this.opt=
ion.scale},W_.prototype.getCoordSysModel=3Dfunction(){};var H_=3DW_;functio=
n W_(){}var tm=3DObject.freeze({__proto__:null,createDimensions:function(t,=
e){return Dv(t,e).dimensions},createList:function(t){return Nv(null,t)},cre=
ateScale:function(t,e){var n=3De;return(e=3DR_(n=3De instanceof Hc?n:new Hc=
(e))).setExtent(t[0],t[1]),O_(e,n),e},createSymbol:am,createTextStyle:funct=
ion(t,e){return wc(t,null,null,"normal"!=3D=3D(e=3De||{}).state)},dataStack=
:{isDimensionStacked:Ov,enableDataStack:Pv,getStackedDimension:Rv},enableHo=
verEmphasis:Hl,getECData:k,getLayoutRect:Vp,mixinAxisModelCommonMethods:fun=
ction(t){at(t,H_)}}),G_=3D[],X_=3D{registerPreprocessor:F0,registerProcesso=
r:V0,registerPostInit:H0,registerPostUpdate:W0,registerUpdateLifecycle:G0,r=
egisterAction:X0,registerCoordinateSystem:U0,registerLayout:Y0,registerVisu=
al:Z0,registerTransform:Q0,registerLoading:K0,registerMap:$0,registerImpl:f=
unction(t,e){Vm[t]=3De},PRIORITY:Jy,ComponentModel:g,ComponentView:$g,Serie=
sModel:Gg,ChartView:ny,registerComponentModel:function(t){g.registerClass(t=
)},registerComponentView:function(t){$g.registerClass(t)},registerSeriesMod=
el:function(t){Gg.registerClass(t)},registerChartView:function(t){ny.regist=
erClass(t)},registerSubTypeDefaulter:function(t,e){g.registerSubTypeDefault=
er(t,e)},registerPainter:function(t,e){Ko(t,e)}};function U_(t){V(t)?E(t,fu=
nction(t){U_(t)}):0<=3DC(G_,t)||(G_.push(t),(t=3DD(t)?{install:t}:t).instal=
l(X_))}var Y_=3D1e-8;function Z_(t,e){return Math.abs(t-e)<Y_}function q_(t=
,e,n){var i=3D0,o=3Dt[0];if(o){for(var r=3D1;r<t.length;r++){var a=3Dt[r];i=
+=3Das(o[0],o[1],a[0],a[1],e,n),o=3Da}var s=3Dt[0];return Z_(o[0],s[0])&&Z_=
(o[1],s[1])||(i+=3Das(o[0],o[1],s[0],s[1],e,n)),0!=3D=3Di}}var j_=3D[];func=
tion K_(t,e){for(var n=3D0;n<t.length;n++)Jt(t[n],t[n],e)}function $_(t,e,n=
,i){for(var o=3D0;o<t.length;o++){var r=3Dt[o];(r=3Di?i.project(r):r)&&isFi=
nite(r[0])&&isFinite(r[1])&&(te(e,e,r),ee(n,n,r))}}Q_.prototype.setCenter=
=3Dfunction(t){this._center=3Dt},Q_.prototype.getCenter=3Dfunction(){return=
 this._center||(this._center=3Dthis.calcCenter())};em=3DQ_;function Q_(t){t=
his.name=3Dt}function J_(t,e){this.type=3D"polygon",this.exterior=3Dt,this.=
interiors=3De}function t1(t){this.type=3D"linestring",this.points=3Dt}u(o1,=
e1=3Dem),o1.prototype.calcCenter=3Dfunction(){for(var t,e,n=3Dthis.geometri=
es,i=3D0,o=3D0;o<n.length;o++){var r=3Dn[o],a=3Dr.exterior,a=3Da&&a.length;=
i<a&&(t=3Dr,i=3Da)}if(t){for(var s=3Dt.exterior,l=3D0,u=3D0,h=3D0,c=3Ds.len=
gth,p=3Ds[c-1][0],d=3Ds[c-1][1],f=3D0;f<c;f++){var g=3Ds[f][0],y=3Ds[f][1],=
m=3Dp*y-g*d;l+=3Dm,u+=3D(p+g)*m,h+=3D(d+y)*m,p=3Dg,d=3Dy}return l?[u/l/3,h/=
l/3,l]:[s[0][0]||0,s[0][1]||0]}return[(e=3Dthis.getBoundingRect()).x+e.widt=
h/2,e.y+e.height/2]},o1.prototype.getBoundingRect=3Dfunction(e){var n,i,t=
=3Dthis._rect;return t&&!e||(n=3D[1/0,1/0],i=3D[-1/0,-1/0],E(this.geometrie=
s,function(t){"polygon"=3D=3D=3Dt.type?$_(t.exterior,n,i,e):E(t.points,func=
tion(t){$_(t,n,i,e)})}),isFinite(n[0])&&isFinite(n[1])&&isFinite(i[0])&&isF=
inite(i[1])||(n[0]=3Dn[1]=3Di[0]=3Di[1]=3D0),t=3Dnew G(n[0],n[1],i[0]-n[0],=
i[1]-n[1]),e)||(this._rect=3Dt),t},o1.prototype.contain=3Dfunction(t){var e=
=3Dthis.getBoundingRect(),n=3Dthis.geometries;if(e.contain(t[0],t[1]))t:for=
(var i=3D0,o=3Dn.length;i<o;i++){var r=3Dn[i];if("polygon"=3D=3D=3Dr.type){=
var a=3Dr.exterior,s=3Dr.interiors;if(q_(a,t[0],t[1])){for(var l=3D0;l<(s?s=
.length:0);l++)if(q_(s[l],t[0],t[1]))continue t;return!0}}}return!1},o1.pro=
totype.transformTo=3Dfunction(t,e,n,i){var o=3Dthis.getBoundingRect(),r=3Do=
.width/o.height;n?i=3Di||n/r:n=3Dr*i;for(var r=3Dnew G(t,e,n,i),a=3Do.calcu=
lateTransform(r),s=3Dthis.geometries,l=3D0;l<s.length;l++){var u=3Ds[l];"po=
lygon"=3D=3D=3Du.type?(K_(u.exterior,a),E(u.interiors,function(t){K_(t,a)})=
):E(u.points,function(t){K_(t,a)})}(o=3Dthis._rect).copy(r),this._center=3D=
[o.x+o.width/2,o.y+o.height/2]},o1.prototype.cloneShallow=3Dfunction(t){t=
=3Dnew o1(t=3Dnull=3D=3Dt?this.name:t,this.geometries,this._center);return =
t._rect=3Dthis._rect,t.transformTo=3Dnull,t};var e1,n1,i1=3Do1;function o1(=
t,e,n){t=3De1.call(this,t)||this;return t.type=3D"geoJSON",t.geometries=3De=
,t._center=3Dn&&[n[0],n[1]],t}function r1(t,e){t=3Dn1.call(this,t)||this;re=
turn t.type=3D"geoSVG",t._elOnlyForCalculate=3De,t}function a1(t,e,n){for(v=
ar i=3D0;i<t.length;i++)t[i]=3Ds1(t[i],e[i],n)}function s1(t,e,n){for(var i=
=3D[],o=3De[0],r=3De[1],a=3D0;a<t.length;a+=3D2){var s=3D(s=3Dt.charCodeAt(=
a)-64)>>1^-(1&s),l=3D(l=3Dt.charCodeAt(a+1)-64)>>1^-(1&l),o=3Ds+=3Do,r=3Dl+=
=3Dr;i.push([s/n,l/n])}return i}function l1(t,r){return F(ut((t=3D(e=3Dt).U=
TF8Encoding?(null=3D=3D(o=3D(n=3De).UTF8Scale)&&(o=3D1024),E(n.features,fun=
ction(t){var e=3Dt.geometry,n=3De.encodeOffsets,i=3De.coordinates;if(n)swit=
ch(e.type){case"LineString":e.coordinates=3Ds1(i,n,o);break;case"Polygon":c=
ase"MultiLineString":a1(i,n,o);break;case"MultiPolygon":E(i,function(t,e){r=
eturn a1(t,n[e],o)})}}),n.UTF8Encoding=3D!1,n):e).features,function(t){retu=
rn t.geometry&&t.properties&&0<t.geometry.coordinates.length}),function(t){=
var e=3Dt.properties,n=3Dt.geometry,i=3D[];switch(n.type){case"Polygon":var=
 o=3Dn.coordinates;i.push(new J_(o[0],o.slice(1)));break;case"MultiPolygon"=
:E(n.coordinates,function(t){t[0]&&i.push(new J_(t[0],t.slice(1)))});break;=
case"LineString":i.push(new t1([n.coordinates]));break;case"MultiLineString=
":i.push(new t1(n.coordinates))}t=3Dnew i1(e[r||"name"],i,e.cp);return t.pr=
operties=3De,t});var e,n,o}u(r1,n1=3Dem),r1.prototype.calcCenter=3Dfunction=
(){for(var t=3Dthis._elOnlyForCalculate,e=3Dt.getBoundingRect(),e=3D[e.x+e.=
width/2,e.y+e.height/2],n=3DPe(j_),i=3Dt;i&&!i.isGeoSVGGraphicRoot;)Re(n,i.=
getLocalTransform(),n),i=3Di.parent;return Be(n,n),Jt(e,e,n),e};var ea=3DOb=
ject.freeze({__proto__:null,MAX_SAFE_INTEGER:9007199254740991,asc:ir,getPer=
centWithPrecision:function(t,e,n){return t[e]&&sr(t,n)[e]||0},getPixelPreci=
sion:ar,getPrecision:or,getPrecisionSafe:rr,isNumeric:yr,isRadianAroundZero=
:ur,linearMap:tr,nice:fr,numericToNumber:gr,parseDate:cr,quantile:function(=
t,e){var e=3D(t.length-1)*e+1,n=3DMath.floor(e),i=3D+t[n-1];return(e=3De-n)=
?i+e*(t[n]-i):i},quantity:pr,quantityExponent:dr,reformIntervals:function(t=
){t.sort(function(t,e){return function t(e,n,i){return e.interval[i]<n.inte=
rval[i]||e.interval[i]=3D=3D=3Dn.interval[i]&&(e.close[i]-n.close[i]=3D=3D(=
i?-1:1)||!i&&t(e,n,1))}(t,e,0)?-1:1});for(var e=3D-1/0,n=3D1,i=3D0;i<t.leng=
th;){for(var o=3Dt[i].interval,r=3Dt[i].close,a=3D0;a<2;a++)o[a]<=3De&&(o[a=
]=3De,r[a]=3Da?1:1-n),e=3Do[a],n=3Dr[a];o[0]=3D=3D=3Do[1]&&r[0]*r[1]!=3D1?t=
.splice(i,1):i++}return t},remRadian:lr,round:nr}),nc=3DObject.freeze({__pr=
oto__:null,format:hp,parse:cr}),op=3DObject.freeze({__proto__:null,Arc:ph,B=
ezierCurve:lh,BoundingRect:G,Circle:mu,CompoundPath:gh,Ellipse:wu,Group:Wo,=
Image:Cs,IncrementalDisplayable:e,Line:nh,LinearGradient:xh,Polygon:Zu,Poly=
line:$u,RadialGradient:mh,Rect:Es,Ring:Wu,Sector:Bu,Text:Hs,clipPointsByRec=
t:lc,clipRectByRect:uc,createIcon:hc,extendPath:Zh,extendShape:Uh,getShapeC=
lass:jh,getTransform:ic,initProps:Eh,makeImage:$h,makePath:Kh,mergePath:Jh,=
registerShape:qh,resizePath:tc,updateProps:Nh}),Rc=3DObject.freeze({__proto=
__:null,addCommas:Ip,capitalFirst:function(t){return t&&t.charAt(0).toUpper=
Case()+t.substr(1)},encodeHTML:me,formatTime:function(t,e,n){"week"!=3D=3Dt=
&&"month"!=3D=3Dt&&"quarter"!=3D=3Dt&&"half-year"!=3D=3Dt&&"year"!=3D=3Dt||=
(t=3D"MM-dd\nyyyy");var i=3D(e=3Dcr(e))[(n=3Dn?"getUTC":"get")+"FullYear"](=
),o=3De[n+"Month"]()+1,r=3De[n+"Date"](),a=3De[n+"Hours"](),s=3De[n+"Minute=
s"](),l=3De[n+"Seconds"](),e=3De[n+"Milliseconds"]();return t.replace("MM",=
lp(o,2)).replace("M",o).replace("yyyy",i).replace("yy",lp(i%100+"",2)).repl=
ace("dd",lp(r,2)).replace("d",r).replace("hh",lp(a,2)).replace("h",a).repla=
ce("mm",lp(s,2)).replace("m",s).replace("ss",lp(l,2)).replace("s",l).replac=
e("SSS",lp(e,3))},formatTpl:Pp,getTextRect:function(t,e,n,i,o,r,a,s){return=
 new Hs({style:{text:t,font:e,align:n,verticalAlign:i,padding:o,rich:r,over=
flow:a?"truncate":null,lineHeight:s}}).getBoundingRect()},getTooltipMarker:=
Op,normalizeCssArray:Dp,toCamelCase:Cp,truncateText:la}),Gy=3DObject.freeze=
({__proto__:null,bind:S,clone:y,curry:M,defaults:B,each:E,extend:P,filter:u=
t,indexOf:C,inherits:rt,isArray:V,isFunction:D,isObject:O,isString:H,map:F,=
merge:d,reduce:lt}),u1=3DRr();function h1(t){return"category"=3D=3D=3Dt.typ=
e?(o=3D(e=3Dt).getLabelModel(),r=3Dp1(e,o),!o.get("show")||e.scale.isBlank(=
)?{labels:[],labelCategoryInterval:r.labelCategoryInterval}:r):(o=3D(n=3Dt)=
.scale.getTicks(),i=3DN_(n),{labels:F(o,function(t,e){return{level:t.level,=
formattedLabel:i(t,e),rawLabel:n.scale.getLabel(t),tickValue:t.value}})});v=
ar n,i,e,o,r}function c1(t,e){var n,i,o,r,a,s;return"category"=3D=3D=3Dt.ty=
pe?(e=3De,r=3Dd1(n=3Dt,"ticks"),a=3DB_(e),(s=3Df1(r,a))||(e.get("show")&&!n=
.scale.isBlank()||(i=3D[]),i=3DD(a)?m1(n,a,!0):"auto"=3D=3D=3Da?(s=3Dp1(n,n=
.getLabelModel()),o=3Ds.labelCategoryInterval,F(s.labels,function(t){return=
 t.tickValue})):y1(n,o=3Da,!0),g1(r,a,{ticks:i,tickCategoryInterval:o}))):{=
ticks:F(t.scale.getTicks(),function(t){return t.value})}}function p1(t,e){v=
ar n,i=3Dd1(t,"labels"),e=3DB_(e);return f1(i,e)||g1(i,e,{labels:D(e)?m1(t,=
e):y1(t,n=3D"auto"=3D=3D=3De?null!=3D(t=3Du1(i=3Dt).autoInterval)?t:u1(i).a=
utoInterval=3Di.calculateCategoryInterval():e),labelCategoryInterval:n})}fu=
nction d1(t,e){return u1(t)[e]||(u1(t)[e]=3D[])}function f1(t,e){for(var n=
=3D0;n<t.length;n++)if(t[n].key=3D=3D=3De)return t[n].value}function g1(t,e=
,n){return t.push({key:e,value:n}),n}function y1(t,e,n){var i=3DN_(t),o=3Dt=
.scale,r=3Do.getExtent(),a=3Dt.getLabelModel(),s=3D[],l=3DMath.max((e||0)+1=
,1),e=3Dr[0],u=3Do.count(),u=3D(0!=3D=3De&&1<l&&2<u/l&&(e=3DMath.round(Math=
.ceil(e/l)*l)),F_(t)),t=3Da.get("showMinLabel")||u,a=3Da.get("showMaxLabel"=
)||u;t&&e!=3D=3Dr[0]&&c(r[0]);for(var h=3De;h<=3Dr[1];h+=3Dl)c(h);function =
c(t){var e=3D{value:t};s.push(n?t:{formattedLabel:i(e),rawLabel:o.getLabel(=
e),tickValue:t})}return a&&h-l!=3D=3Dr[1]&&c(r[1]),s}function m1(t,i,o){var=
 r=3Dt.scale,a=3DN_(t),s=3D[];return E(r.getTicks(),function(t){var e=3Dr.g=
etLabel(t),n=3Dt.value;i(t.value,e)&&s.push(o?n:{formattedLabel:a(t),rawLab=
el:e,tickValue:n})}),s}var v1=3D[0,1],Ec=3D(_1.prototype.contain=3Dfunction=
(t){var e=3Dthis._extent,n=3DMath.min(e[0],e[1]),e=3DMath.max(e[0],e[1]);re=
turn n<=3Dt&&t<=3De},_1.prototype.containData=3Dfunction(t){return this.sca=
le.contain(t)},_1.prototype.getExtent=3Dfunction(){return this._extent.slic=
e()},_1.prototype.getPixelPrecision=3Dfunction(t){return ar(t||this.scale.g=
etExtent(),this._extent)},_1.prototype.setExtent=3Dfunction(t,e){var n=3Dth=
is._extent;n[0]=3Dt,n[1]=3De},_1.prototype.dataToCoord=3Dfunction(t,e){var =
n=3Dthis._extent,i=3Dthis.scale;return t=3Di.normalize(t),this.onBand&&"ord=
inal"=3D=3D=3Di.type&&x1(n=3Dn.slice(),i.count()),tr(t,v1,n,e)},_1.prototyp=
e.coordToData=3Dfunction(t,e){var n=3Dthis._extent,i=3Dthis.scale,i=3D(this=
.onBand&&"ordinal"=3D=3D=3Di.type&&x1(n=3Dn.slice(),i.count()),tr(t,n,v1,e)=
);return this.scale.scale(i)},_1.prototype.pointToData=3Dfunction(t,e){},_1=
.prototype.getTicksCoords=3Dfunction(t){var e,n,i,o,r=3D(t=3Dt||{}).tickMod=
el||this.getTickModel(),a=3DF(c1(this,r).ticks,function(t){return{coord:thi=
s.dataToCoord("ordinal"=3D=3D=3Dthis.scale.type?this.scale.getRawOrdinalNum=
ber(t):t),tickValue:t}},this),s=3Dthis,l=3Da,r=3Dr.get("alignWithLabel"),t=
=3Dt.clamp,u=3Dl.length;function h(t,e){return t=3Dnr(t),e=3Dnr(e),o?e<t:t<=
e}return s.onBand&&!r&&u&&(r=3Ds.getExtent(),1=3D=3D=3Du?(l[0].coord=3Dr[0]=
,e=3Dl[1]=3D{coord:r[1]}):(n=3Dl[u-1].tickValue-l[0].tickValue,i=3D(l[u-1].=
coord-l[0].coord)/n,E(l,function(t){t.coord-=3Di/2}),n=3D1+s.scale.getExten=
t()[1]-l[u-1].tickValue,e=3D{coord:l[u-1].coord+i*n},l.push(e)),o=3Dr[0]>r[=
1],h(l[0].coord,r[0])&&(t?l[0].coord=3Dr[0]:l.shift()),t&&h(r[0],l[0].coord=
)&&l.unshift({coord:r[0]}),h(r[1],e.coord)&&(t?e.coord=3Dr[1]:l.pop()),t)&&=
h(e.coord,r[1])&&l.push({coord:r[1]}),a},_1.prototype.getMinorTicksCoords=
=3Dfunction(){var t;return"ordinal"=3D=3D=3Dthis.scale.type?[]:(t=3Dthis.mo=
del.getModel("minorTick").get("splitNumber"),F(this.scale.getMinorTicks(t=
=3D0<t&&t<100?t:5),function(t){return F(t,function(t){return{coord:this.dat=
aToCoord(t),tickValue:t}},this)},this))},_1.prototype.getViewLabels=3Dfunct=
ion(){return h1(this).labels},_1.prototype.getLabelModel=3Dfunction(){retur=
n this.model.getModel("axisLabel")},_1.prototype.getTickModel=3Dfunction(){=
return this.model.getModel("axisTick")},_1.prototype.getBandWidth=3Dfunctio=
n(){var t=3Dthis._extent,e=3Dthis.scale.getExtent(),e=3De[1]-e[0]+(this.onB=
and?1:0),t=3D(0=3D=3D=3De&&(e=3D1),Math.abs(t[1]-t[0]));return Math.abs(t)/=
e},_1.prototype.calculateCategoryInterval=3Dfunction(){o=3D(n=3Dd=3Dthis).g=
etLabelModel();var t=3D{axisRotate:n.getRotate?n.getRotate():n.isHorizontal=
&&!n.isHorizontal()?90:0,labelRotate:o.get("rotate")||0,font:o.getFont()},e=
=3DN_(d),n=3D(t.axisRotate-t.labelRotate)/180*Math.PI,i=3D(o=3Dd.scale).get=
Extent(),o=3Do.count();if(i[1]-i[0]<1)return 0;var r=3D1;40<o&&(r=3DMath.ma=
x(1,Math.floor(o/40)));for(var a=3Di[0],s=3Dd.dataToCoord(a+1)-d.dataToCoor=
d(a),l=3DMath.abs(s*Math.cos(n)),s=3DMath.abs(s*Math.sin(n)),u=3D0,h=3D0;a<=
=3Di[1];a+=3Dr)var c=3D1.3*(p=3DMo(e({value:a}),t.font,"center","top")).wid=
th,p=3D1.3*p.height,u=3DMath.max(u,c,7),h=3DMath.max(h,p,7);var n=3Du/l,l=
=3Dh/s,s=3D(isNaN(n)&&(n=3D1/0),isNaN(l)&&(l=3D1/0),Math.max(0,Math.floor(M=
ath.min(n,l)))),n=3Du1(d.model),l=3Dd.getExtent(),d=3Dn.lastAutoInterval,f=
=3Dn.lastTickCount;return null!=3Dd&&null!=3Df&&Math.abs(d-s)<=3D1&&Math.ab=
s(f-o)<=3D1&&s<d&&n.axisExtent0=3D=3D=3Dl[0]&&n.axisExtent1=3D=3D=3Dl[1]?s=
=3Dd:(n.lastTickCount=3Do,n.lastAutoInterval=3Ds,n.axisExtent0=3Dl[0],n.axi=
sExtent1=3Dl[1]),s},_1);function _1(t,e,n){this.onBand=3D!1,this.inverse=3D=
!1,this.dim=3Dt,this.scale=3De,this._extent=3Dn||[0,0]}function x1(t,e){e=
=3D(t[1]-t[0])/e/2;t[0]+=3De,t[1]-=3De}var w1=3D2*Math.PI,b1=3Des.CMD,S1=3D=
["top","right","bottom","left"];function M1(t,e,n,i,o,r,a,s){var l=3Do-t,u=
=3Dr-e,n=3Dn-t,i=3Di-e,h=3DMath.sqrt(n*n+i*i),l=3D(l*(n/=3Dh)+u*(i/=3Dh))/h=
,u=3D(s&&(l=3DMath.min(Math.max(l,0),1)),a[0]=3Dt+(l*=3Dh)*n),s=3Da[1]=3De+=
l*i;return Math.sqrt((u-o)*(u-o)+(s-r)*(s-r))}function T1(t,e,n,i,o,r,a){n<=
0&&(t+=3Dn,n=3D-n),i<0&&(e+=3Di,i=3D-i);n=3Dt+n,i=3De+i,t=3Da[0]=3DMath.min=
(Math.max(o,t),n),n=3Da[1]=3DMath.min(Math.max(r,e),i);return Math.sqrt((t-=
o)*(t-o)+(n-r)*(n-r))}var I1=3D[];function C1(t,e,n){for(var i,o,r,a,s,l,u,=
h,c,p=3D0,d=3D0,f=3D0,g=3D0,y=3D1/0,m=3De.data,v=3Dt.x,_=3Dt.y,x=3D0;x<m.le=
ngth;){var w=3Dm[x++],b=3D(1=3D=3D=3Dx&&(f=3Dp=3Dm[x],g=3Dd=3Dm[x+1]),y);sw=
itch(w){case b1.M:p=3Df=3Dm[x++],d=3Dg=3Dm[x++];break;case b1.L:b=3DM1(p,d,=
m[x],m[x+1],v,_,I1,!0),p=3Dm[x++],d=3Dm[x++];break;case b1.C:b=3DHn(p,d,m[x=
++],m[x++],m[x++],m[x++],m[x],m[x+1],v,_,I1),p=3Dm[x++],d=3Dm[x++];break;ca=
se b1.Q:b=3DYn(p,d,m[x++],m[x++],m[x],m[x+1],v,_,I1),p=3Dm[x++],d=3Dm[x++];=
break;case b1.A:var S=3Dm[x++],M=3Dm[x++],T=3Dm[x++],I=3Dm[x++],C=3Dm[x++],=
D=3Dm[x++],k=3D(x+=3D1,!!(1-m[x++])),A=3DMath.cos(C)*T+S,L=3DMath.sin(C)*I+=
M;x<=3D1&&(f=3DA,g=3DL),L=3D(A=3DC)+D,k=3Dk,a=3D(v-(i=3DS))*(r=3DI)/T+S,s=
=3D_,l=3DI1,c=3Dh=3Du=3Dvoid 0,a-=3Di,s-=3Do=3DM,u=3DMath.sqrt(a*a+s*s),h=
=3D(a/=3Du)*r+i,c=3D(s/=3Du)*r+o,b=3DMath.abs(A-L)%w1<1e-4||((L=3Dk?(k=3DA,=
A=3Dos(L),os(k)):(A=3Dos(A),os(L)))<A&&(L+=3Dw1),(k=3DMath.atan2(s,a))<0&&(=
k+=3Dw1),A<=3Dk&&k<=3DL)||A<=3Dk+w1&&k+w1<=3DL?(l[0]=3Dh,l[1]=3Dc,u-r):(c=
=3D((k=3Dr*Math.cos(A)+i)-a)*(k-a)+((h=3Dr*Math.sin(A)+o)-s)*(h-s))<(i=3D((=
u=3Dr*Math.cos(L)+i)-a)*(u-a)+((A=3Dr*Math.sin(L)+o)-s)*(A-s))?(l[0]=3Dk,l[=
1]=3Dh,Math.sqrt(c)):(l[0]=3Du,l[1]=3DA,Math.sqrt(i)),p=3DMath.cos(C+D)*T+S=
,d=3DMath.sin(C+D)*I+M;break;case b1.R:b=3DT1(f=3Dp=3Dm[x++],g=3Dd=3Dm[x++]=
,m[x++],m[x++],v,_,I1);break;case b1.Z:b=3DM1(p,d,f,g,v,_,I1,!0),p=3Df,d=3D=
g}b<y&&(y=3Db,n.set(I1[0],I1[1]))}return y}var D1=3Dnew z,k1=3Dnew z,A1=3Dn=
ew z,L1=3Dnew z,P1=3Dnew z;function O1(t,e){if(t){var n=3Dt.getTextGuideLin=
e(),i=3Dt.getTextContent();if(i&&n){var o=3Dt.textGuideLineConfig||{},r=3D[=
[0,0],[0,0],[0,0]],a=3Do.candidates||S1,s=3Di.getBoundingRect().clone(),l=
=3D(s.applyTransform(i.getComputedTransform()),1/0),u=3Do.anchor,h=3Dt.getC=
omputedTransform(),c=3Dh&&Be([],h),p=3De.get("length2")||0;u&&A1.copy(u);fo=
r(var d=3D0;d<a.length;d++){x=3D_=3Dv=3Dm=3Dy=3Dg=3Df=3Dvoid 0;var f=3Da[d]=
,g=3D0,y=3Ds,m=3DD1,v=3DL1,_=3Dy.width,x=3Dy.height;switch(f){case"top":m.s=
et(y.x+_/2,y.y-g),v.set(0,-1);break;case"bottom":m.set(y.x+_/2,y.y+x+g),v.s=
et(0,1);break;case"left":m.set(y.x-g,y.y+x/2),v.set(-1,0);break;case"right"=
:m.set(y.x+_+g,y.y+x/2),v.set(1,0)}z.scaleAndAdd(k1,D1,L1,p),k1.transform(c=
);f=3Dt.getBoundingRect(),f=3Du?u.distance(k1):t instanceof _s?C1(k1,t.path=
,A1):(b=3DA1,w=3DT1((w=3Df).x,f.y,f.width,f.height,k1.x,k1.y,I1),b.set(I1[0=
],I1[1]),w);f<l&&(l=3Df,k1.transform(h),A1.transform(h),A1.toArray(r[0]),k1=
.toArray(r[1]),D1.toArray(r[2]))}E1(r,e.get("minTurnAngle")),n.setShape({po=
ints:r})}}var w,b}var R1=3D[],N1=3Dnew z;function E1(t,e){var n,i;e<=3D180&=
&0<e&&(e=3De/180*Math.PI,D1.fromArray(t[0]),k1.fromArray(t[1]),A1.fromArray=
(t[2]),z.sub(L1,D1,k1),z.sub(P1,A1,k1),i=3DL1.len(),n=3DP1.len(),i<.001||n<=
.001||(L1.scale(1/i),P1.scale(1/n),i=3DL1.dot(P1),Math.cos(e)<i&&(n=3DM1(k1=
.x,k1.y,A1.x,A1.y,D1.x,D1.y,R1,!1),N1.fromArray(R1),N1.scaleAndAdd(P1,n/Mat=
h.tan(Math.PI-e)),i=3DA1.x!=3D=3Dk1.x?(N1.x-k1.x)/(A1.x-k1.x):(N1.y-k1.y)/(=
A1.y-k1.y),isNaN(i)||(i<0?z.copy(N1,k1):1<i&&z.copy(N1,A1),N1.toArray(t[1])=
))))}function z1(t,e,n,i){var o=3D"normal"=3D=3D=3Dn,n=3Do?t:t.ensureState(=
n),e=3D(n.ignore=3De,i.get("smooth")),e=3D(e&&!0=3D=3D=3De&&(e=3D.3),n.shap=
e=3Dn.shape||{},0<e&&(n.shape.smooth=3De),i.getModel("lineStyle").getLineSt=
yle());o?t.useStyle(e):n.style=3De}function B1(t,e){var n=3De.smooth,i=3De.=
points;if(i)if(t.moveTo(i[0][0],i[0][1]),0<n&&3<=3Di.length){var e=3Djt(i[0=
],i[1]),o=3Djt(i[1],i[2]);e&&o?(n=3DMath.min(e,o)*n,e=3DQt([],i[1],i[0],n/e=
),n=3DQt([],i[1],i[2],n/o),o=3DQt([],e,n,.5),t.bezierCurveTo(e[0],e[1],e[0]=
,e[1],o[0],o[1]),t.bezierCurveTo(n[0],n[1],n[0],n[1],i[2][0],i[2][1])):(t.l=
ineTo(i[1][0],i[1][1]),t.lineTo(i[2][0],i[2][1]))}else for(var r=3D1;r<i.le=
ngth;r++)t.lineTo(i[r][0],i[r][1])}function F1(t,e,n){var i=3Dt.getTextGuid=
eLine(),o=3Dt.getTextContent();if(o){for(var r=3De.normal,a=3Dr.get("show")=
,s=3Do.ignore,l=3D0;l<sl.length;l++){var u,h=3Dsl[l],c=3De[h],p=3D"normal"=
=3D=3D=3Dh;c&&(u=3Dc.get("show"),(p?s:R(o.states[h]&&o.states[h].ignore,s))=
||!R(u,a)?((u=3Dp?i:i&&i.states[h])&&(u.ignore=3D!0),i&&z1(i,!0,h,c)):(i||(=
i=3Dnew $u,t.setTextGuideLine(i),p||!s&&a||z1(i,!0,"normal",e.normal),t.sta=
teProxy&&(i.stateProxy=3Dt.stateProxy)),z1(i,!1,h,c)))}i&&(B(i.style,n),i.s=
tyle.fill=3Dnull,n=3Dr.get("showAbove"),(t.textGuideLineConfig=3Dt.textGuid=
eLineConfig||{}).showAbove=3Dn||!1,i.buildPath=3DB1)}else i&&t.removeTextGu=
ideLine()}function V1(t,e){for(var n=3D{normal:t.getModel(e=3De||"labelLine=
")},i=3D0;i<al.length;i++){var o=3Dal[i];n[o]=3Dt.getModel([o,e])}return n}=
function H1(t){for(var e=3D[],n=3D0;n<t.length;n++){var i,o,r,a,s,l,u=3Dt[n=
];u.defaultAttr.ignore||(o=3D(i=3Du.label).getComputedTransform(),r=3Di.get=
BoundingRect(),a=3D!o||o[1]<1e-5&&o[2]<1e-5,l=3Di.style.margin||0,(s=3Dr.cl=
one()).applyTransform(o),s.x-=3Dl/2,s.y-=3Dl/2,s.width+=3Dl,s.height+=3Dl,l=
=3Da?new Dh(r,o):null,e.push({label:i,labelLine:u.labelLine,rect:s,localRec=
t:r,obb:l,priority:u.priority,defaultAttr:u.defaultAttr,layoutOption:u.comp=
utedLayoutOption,axisAligned:a,transform:o}))}return e}function W1(s,l,u,t,=
e,n){var h=3Ds.length;if(!(h<2)){s.sort(function(t,e){return t.rect[l]-e.re=
ct[l]});for(var i,o=3D0,r=3D!1,a=3D[],c=3D0,p=3D0;p<h;p++){var d=3Ds[p],f=
=3Dd.rect,d=3D((i=3Df[l]-o)<0&&(f[l]-=3Di,d.label[l]-=3Di,r=3D!0),Math.max(=
-i,0));a.push(d),c+=3Dd,o=3Df[l]+f[u]}0<c&&n&&w(-c/h,0,h);var g,y,m=3Ds[0],=
v=3Ds[h-1];return _(),g<0&&b(-g,.8),y<0&&b(y,.8),_(),x(g,y,1),x(y,g,-1),_()=
,g<0&&S(-g),y<0&&S(y),r}function _(){g=3Dm.rect[l]-t,y=3De-v.rect[l]-v.rect=
[u]}function x(t,e,n){t<0&&(0<(e=3DMath.min(e,-t))?(w(e*n,0,h),(e=3De+t)<0&=
&b(-e*n,1)):b(-t*n,1))}function w(t,e,n){0!=3D=3Dt&&(r=3D!0);for(var i=3De;=
i<n;i++){var o=3Ds[i];o.rect[l]+=3Dt,o.label[l]+=3Dt}}function b(t,e){for(v=
ar n=3D[],i=3D0,o=3D1;o<h;o++){var r=3Ds[o-1].rect,r=3DMath.max(s[o].rect[l=
]-r[l]-r[u],0);n.push(r),i+=3Dr}if(i){var a=3DMath.min(Math.abs(t)/i,e);if(=
0<t)for(o=3D0;o<h-1;o++)w(n[o]*a,0,o+1);else for(o=3Dh-1;0<o;o--)w(-n[o-1]*=
a,o,h)}}function S(t){var e=3Dt<0?-1:1;t=3DMath.abs(t);for(var n=3DMath.cei=
l(t/(h-1)),i=3D0;i<h-1;i++)if(0<e?w(n,0,i+1):w(-n,h-i-1,h),(t-=3Dn)<=3D0)re=
turn}}function G1(t,e,n,i){return W1(t,"y","height",e,n,i)}function X1(t){v=
ar e=3D[],n=3D(t.sort(function(t,e){return e.priority-t.priority}),new G(0,=
0,0,0));function i(t){var e;t.ignore||null=3D=3D(e=3Dt.ensureState("emphasi=
s")).ignore&&(e.ignore=3D!1),t.ignore=3D!0}for(var o=3D0;o<t.length;o++){va=
r r=3Dt[o],a=3Dr.axisAligned,s=3Dr.localRect,l=3Dr.transform,u=3Dr.label,h=
=3Dr.labelLine;n.copy(r.rect),n.width-=3D.1,n.height-=3D.1,n.x+=3D.05,n.y+=
=3D.05;for(var c=3Dr.obb,p=3D!1,d=3D0;d<e.length;d++){var f=3De[d];if(n.int=
ersect(f.rect)){if(a&&f.axisAligned){p=3D!0;break}if(f.obb||(f.obb=3Dnew Dh=
(f.localRect,f.transform)),(c=3Dc||new Dh(s,l)).intersect(f.obb)){p=3D!0;br=
eak}}}p?(i(u),h&&i(h)):(u.attr("ignore",r.defaultAttr.ignore),h&&h.attr("ig=
nore",r.defaultAttr.labelGuideIgnore),e.push(r))}}function U1(t,e){var n=3D=
t.label,e=3De&&e.getTextGuideLine();return{dataIndex:t.dataIndex,dataType:t=
.dataType,seriesIndex:t.seriesModel.seriesIndex,text:t.label.style.text,rec=
t:t.hostRect,labelRect:t.rect,align:n.style.align,verticalAlign:n.style.ver=
ticalAlign,labelLinePoints:function(t){if(t){for(var e=3D[],n=3D0;n<t.lengt=
h;n++)e.push(t[n].slice());return e}}(e&&e.shape.points)}}var Y1=3D["align"=
,"verticalAlign","width","height","fontSize"],Z1=3Dnew vo,q1=3DRr(),j1=3DRr=
();function K1(t,e,n){for(var i=3D0;i<n.length;i++){var o=3Dn[i];null!=3De[=
o]&&(t[o]=3De[o])}}var $1=3D["x","y","rotation"],Q1=3D(J1.prototype.clearLa=
bels=3Dfunction(){this._labelList=3D[],this._chartViewList=3D[]},J1.prototy=
pe._addLabel=3Dfunction(t,e,n,i,o){var r=3Di.style,a=3Di.__hostTarget.textC=
onfig||{},s=3Di.getComputedTransform(),l=3Di.getBoundingRect().plain();G.ap=
plyTransform(l,l,s),s?Z1.setLocalTransform(s):(Z1.x=3DZ1.y=3DZ1.rotation=3D=
Z1.originX=3DZ1.originY=3D0,Z1.scaleX=3DZ1.scaleY=3D1),Z1.rotation=3Dos(Z1.=
rotation);var u,s=3Di.__hostTarget,h=3D(s&&(u=3Ds.getBoundingRect().plain()=
,h=3Ds.getComputedTransform(),G.applyTransform(u,u,h)),u&&s.getTextGuideLin=
e());this._labelList.push({label:i,labelLine:h,seriesModel:n,dataIndex:t,da=
taType:e,layoutOption:o,computedLayoutOption:null,rect:l,hostRect:u,priorit=
y:u?u.width*u.height:0,defaultAttr:{ignore:i.ignore,labelGuideIgnore:h&&h.i=
gnore,x:Z1.x,y:Z1.y,scaleX:Z1.scaleX,scaleY:Z1.scaleY,rotation:Z1.rotation,=
style:{x:r.x,y:r.y,align:r.align,verticalAlign:r.verticalAlign,width:r.widt=
h,height:r.height,fontSize:r.fontSize},cursor:i.cursor,attachedPos:a.positi=
on,attachedRot:a.rotation}})},J1.prototype.addLabelsOfSeries=3Dfunction(t){=
var n=3Dthis,i=3D(this._chartViewList.push(t),t.__model),o=3Di.get("labelLa=
yout");(D(o)||ht(o).length)&&t.group.traverse(function(t){if(t.ignore)retur=
n!0;var e=3Dt.getTextContent(),t=3Dk(t);e&&!e.disableLabelLayout&&n._addLab=
el(t.dataIndex,t.dataType,i,e,o)})},J1.prototype.updateLayoutConfig=3Dfunct=
ion(t){var e=3Dt.getWidth(),n=3Dt.getHeight();for(var i=3D0;i<this._labelLi=
st.length;i++){var o=3Dthis._labelList[i],r=3Do.label,a=3Dr.__hostTarget,s=
=3Do.defaultAttr,l=3Dvoid 0,l=3D(D(o.layoutOption)?o.layoutOption(U1(o,a)):=
o.layoutOption)||{},u=3D(o.computedLayoutOption=3Dl,Math.PI/180),h=3D(a&&a.=
setTextConfig({local:!1,position:null!=3Dl.x||null!=3Dl.y?null:s.attachedPo=
s,rotation:null!=3Dl.rotate?l.rotate*u:s.attachedRot,offset:[l.dx||0,l.dy||=
0]}),!1);null!=3Dl.x?(r.x=3Der(l.x,e),r.setStyle("x",0),h=3D!0):(r.x=3Ds.x,=
r.setStyle("x",s.style.x)),null!=3Dl.y?(r.y=3Der(l.y,n),r.setStyle("y",0),h=
=3D!0):(r.y=3Ds.y,r.setStyle("y",s.style.y)),l.labelLinePoints&&(c=3Da.getT=
extGuideLine())&&(c.setShape({points:l.labelLinePoints}),h=3D!1),q1(r).need=
sUpdateLabelLine=3Dh,r.rotation=3Dnull!=3Dl.rotate?l.rotate*u:s.rotation,r.=
scaleX=3Ds.scaleX,r.scaleY=3Ds.scaleY;for(var c,p=3D0;p<Y1.length;p++){var =
d=3DY1[p];r.setStyle(d,(null!=3Dl[d]?l:s.style)[d])}l.draggable?(r.draggabl=
e=3D!0,r.cursor=3D"move",a&&(c=3Do.seriesModel,null!=3Do.dataIndex&&(c=3Do.=
seriesModel.getData(o.dataType).getItemModel(o.dataIndex)),r.on("drag",func=
tion(t,e){return function(){O1(t,e)}}(a,c.getModel("labelLine"))))):(r.off(=
"drag"),r.cursor=3Ds.cursor)}},J1.prototype.layout=3Dfunction(t){var e,n=3D=
t.getWidth(),t=3Dt.getHeight(),i=3DH1(this._labelList),o=3Dut(i,function(t)=
{return"shiftX"=3D=3D=3Dt.layoutOption.moveOverlap}),r=3Dut(i,function(t){r=
eturn"shiftY"=3D=3D=3Dt.layoutOption.moveOverlap});W1(o,"x","width",0,n,e),=
G1(r,0,t),X1(ut(i,function(t){return t.layoutOption.hideOverlap}))},J1.prot=
otype.processLabelsOverall=3Dfunction(){var a=3Dthis;E(this._chartViewList,=
function(t){var i=3Dt.__model,o=3Dt.ignoreLabelLineUpdate,r=3Di.isAnimation=
Enabled();t.group.traverse(function(t){if(t.ignore&&!t.forceLabelAnimation)=
return!0;var e=3D!o,n=3Dt.getTextContent();(e=3D!e&&n?q1(n).needsUpdateLabe=
lLine:e)&&a._updateLabelLine(t,i),r&&a._animateLabels(t,i)})})},J1.prototyp=
e._updateLabelLine=3Dfunction(t,e){var n=3Dt.getTextContent(),i=3Dk(t),o=3D=
i.dataIndex;n&&null!=3Do&&(e=3D(n=3De.getData(i.dataType)).getItemModel(o),=
i=3D{},(o=3Dn.getItemVisual(o,"style"))&&(n=3Dn.getVisual("drawType"),i.str=
oke=3Do[n]),o=3De.getModel("labelLine"),F1(t,V1(e),i),O1(t,o))},J1.prototyp=
e._animateLabels=3Dfunction(t,e){var n,i,o,r,a,s,l,u,h,c,p,d,f,g=3Dt.getTex=
tContent(),y=3Dt.getTextGuideLine();!g||!t.forceLabelAnimation&&(g.ignore||=
g.invisible||t.disableLabelAnimation||zh(t))||(d=3D(f=3Dq1(g)).oldLayout,n=
=3D(i=3Dk(t)).dataIndex,s=3D{x:g.x,y:g.y,rotation:g.rotation},i=3De.getData=
(i.dataType),d?(g.attr(d),(t=3Dt.prevStates)&&(0<=3DC(t,"select")&&g.attr(f=
.oldLayoutSelect),0<=3DC(t,"emphasis"))&&g.attr(f.oldLayoutEmphasis),Nh(g,s=
,e,n)):(g.attr(s),Cc(g).valueAnimation||(t=3DR(g.style.opacity,1),g.style.o=
pacity=3D0,Eh(g,{style:{opacity:t}},e,n))),f.oldLayout=3Ds,g.states.select&=
&(K1(t=3Df.oldLayoutSelect=3D{},s,$1),K1(t,g.states.select,$1)),g.states.em=
phasis&&(K1(t=3Df.oldLayoutEmphasis=3D{},s,$1),K1(t,g.states.emphasis,$1)),=
r=3Dn,a=3Di,l=3Ds=3De,(p=3DCc(o=3Dg)).valueAnimation&&p.prevValue!=3D=3Dp.v=
alue&&(u=3Dp.defaultInterpolatedText,h=3DR(p.interpolatedValue,p.prevValue)=
,c=3Dp.value,o.percent=3D0,(null=3D=3Dp.prevValue?Eh:Nh)(o,{percent:1},s,r,=
null,function(t){var e=3DWr(a,p.precision,h,c,t),t=3D(p.interpolatedValue=
=3D1=3D=3D=3Dt?null:e,vc({labelDataIndex:r,labelFetcher:l,defaultText:u?u(e=
):e+""},p.statesModels,e));mc(o,t)}))),!y||y.ignore||y.invisible||(d=3D(f=
=3Dj1(y)).oldLayout,t=3D{points:y.shape.points},d?(y.attr({shape:d}),Nh(y,{=
shape:t},e)):(y.setShape(t),y.style.strokePercent=3D0,Eh(y,{style:{strokePe=
rcent:1}},e)),f.oldLayout=3Dt)},J1);function J1(){this._labelList=3D[],this=
._chartViewList=3D[]}var tx=3DRr();function ex(t){t.registerUpdateLifecycle=
("series:beforeupdate",function(t,e,n){(tx(e).labelManager||(tx(e).labelMan=
ager=3Dnew Q1)).clearLabels()}),t.registerUpdateLifecycle("series:layoutlab=
els",function(t,e,n){var i=3Dtx(e).labelManager;n.updatedSeries.forEach(fun=
ction(t){i.addLabelsOfSeries(e.getViewOfSeriesModel(t))}),i.updateLayoutCon=
fig(e),i.layout(e),i.processLabelsOverall()})}function nx(t,e,n){var i=3DX.=
createCanvas(),o=3De.getWidth(),e=3De.getHeight(),r=3Di.style;return r&&(r.=
position=3D"absolute",r.left=3D"0",r.top=3D"0",r.width=3Do+"px",r.height=3D=
e+"px",i.setAttribute("data-zr-dom-id",t)),i.width=3Do*n,i.height=3De*n,i}U=
_(ex);u(rx,ix=3Dae),rx.prototype.getElementCount=3Dfunction(){return this._=
_endIndex-this.__startIndex},rx.prototype.afterBrush=3Dfunction(){this.__pr=
evStartIndex=3Dthis.__startIndex,this.__prevEndIndex=3Dthis.__endIndex},rx.=
prototype.initContext=3Dfunction(){this.ctx=3Dthis.dom.getContext("2d"),thi=
s.ctx.dpr=3Dthis.dpr},rx.prototype.setUnpainted=3Dfunction(){this.__firstTi=
mePaint=3D!0},rx.prototype.createBackBuffer=3Dfunction(){var t=3Dthis.dpr;t=
his.domBack=3Dnx("back-"+this.id,this.painter,t),this.ctxBack=3Dthis.domBac=
k.getContext("2d"),1!=3D=3Dt&&this.ctxBack.scale(t,t)},rx.prototype.createR=
epaintRects=3Dfunction(t,e,n,i){if(this.__firstTimePaint)return this.__firs=
tTimePaint=3D!1,null;var o,l=3D[],u=3Dthis.maxRepaintRectCount,h=3D!1,c=3Dn=
ew G(0,0,0,0);function r(t){if(t.isFinite()&&!t.isZero())if(0=3D=3D=3Dl.len=
gth)(e=3Dnew G(0,0,0,0)).copy(t),l.push(e);else{for(var e,n=3D!1,i=3D1/0,o=
=3D0,r=3D0;r<l.length;++r){var a=3Dl[r];if(a.intersect(t)){var s=3Dnew G(0,=
0,0,0);s.copy(a),s.union(t),l[r]=3Ds,n=3D!0;break}h&&(c.copy(t),c.union(a),=
s=3Dt.width*t.height,a=3Da.width*a.height,(a=3Dc.width*c.height-s-a)<i)&&(i=
=3Da,o=3Dr)}h&&(l[o].union(t),n=3D!0),n||((e=3Dnew G(0,0,0,0)).copy(t),l.pu=
sh(e)),h=3Dh||l.length>=3Du}}for(var a,s=3Dthis.__startIndex;s<this.__endIn=
dex;++s)(p=3Dt[s])&&(f=3Dp.shouldBePainted(n,i,!0,!0),(d=3Dp.__isRendered&&=
(p.__dirty&mn||!f)?p.getPrevPaintRect():null)&&r(d),a=3Df&&(p.__dirty&mn||!=
p.__isRendered)?p.getPaintRect():null)&&r(a);for(s=3Dthis.__prevStartIndex;=
s<this.__prevEndIndex;++s){var p,d,f=3D(p=3De[s])&&p.shouldBePainted(n,i,!0=
,!0);!p||f&&p.__zr||!p.__isRendered||(d=3Dp.getPrevPaintRect())&&r(d)}do{fo=
r(o=3D!1,s=3D0;s<l.length;)if(l[s].isZero())l.splice(s,1);else{for(var g=3D=
s+1;g<l.length;)l[s].intersect(l[g])?(o=3D!0,l[s].union(l[g]),l.splice(g,1)=
):g++;s++}}while(o);return this._paintRects=3Dl},rx.prototype.debugGetPaint=
Rects=3Dfunction(){return(this._paintRects||[]).slice()},rx.prototype.resiz=
e=3Dfunction(t,e){var n=3Dthis.dpr,i=3Dthis.dom,o=3Di.style,r=3Dthis.domBac=
k;o&&(o.width=3Dt+"px",o.height=3De+"px"),i.width=3Dt*n,i.height=3De*n,r&&(=
r.width=3Dt*n,r.height=3De*n,1!=3D=3Dn)&&this.ctxBack.scale(n,n)},rx.protot=
ype.clear=3Dfunction(t,r,e){var n=3Dthis.dom,a=3Dthis.ctx,i=3Dn.width,o=3Dn=
.height,s=3D(r=3Dr||this.clearColor,this.motionBlur&&!t),l=3Dthis.lastFrame=
Alpha,u=3Dthis.dpr,h=3Dthis,c=3D(s&&(this.domBack||this.createBackBuffer(),=
this.ctxBack.globalCompositeOperation=3D"copy",this.ctxBack.drawImage(n,0,0=
,i/u,o/u)),this.domBack);function p(t,e,n,i){var o;a.clearRect(t,e,n,i),r&&=
"transparent"!=3D=3Dr&&(o=3Dvoid 0,gt(r)?(o=3D(r.global||r.__width=3D=3D=3D=
n&&r.__height=3D=3D=3Di)&&r.__canvasGradient||hm(a,r,{x:0,y:0,width:n,heigh=
t:i}),r.__canvasGradient=3Do,r.__width=3Dn,r.__height=3Di):yt(r)&&(r.scaleX=
=3Dr.scaleX||u,r.scaleY=3Dr.scaleY||u,o=3Dxm(a,r,{dirty:function(){h.setUnp=
ainted(),h.painter.refresh()}})),a.save(),a.fillStyle=3Do||r,a.fillRect(t,e=
,n,i),a.restore()),s&&(a.save(),a.globalAlpha=3Dl,a.drawImage(c,t,e,n,i),a.=
restore())}!e||s?p(0,0,i,o):e.length&&E(e,function(t){p(t.x*u,t.y*u,t.width=
*u,t.height*u)})};var ix,ox=3Drx;function rx(t,e,n){var i,o=3Dix.call(this)=
||this,t=3D(o.motionBlur=3D!1,o.lastFrameAlpha=3D.7,o.dpr=3D1,o.virtual=3D!=
1,o.config=3D{},o.incremental=3D!1,o.zlevel=3D0,o.maxRepaintRectCount=3D5,o=
.__dirty=3D!0,o.__firstTimePaint=3D!0,o.__used=3D!1,o.__drawIndex=3D0,o.__s=
tartIndex=3D0,o.__endIndex=3D0,o.__prevStartIndex=3Dnull,o.__prevEndIndex=
=3Dnull,n=3Dn||lo,"string"=3D=3Dtypeof t?i=3Dnx(t,e,n):O(t)&&(t=3D(i=3Dt).i=
d),o.id=3Dt,(o.dom=3Di).style);return t&&(Nt(i),i.onselectstart=3Dfunction(=
){return!1},t.padding=3D"0",t.margin=3D"0",t.borderWidth=3D"0"),o.painter=
=3De,o.dpr=3Dn,o}var ax=3D314159;p.prototype.getType=3Dfunction(){return"ca=
nvas"},p.prototype.isSingleCanvas=3Dfunction(){return this._singleCanvas},p=
.prototype.getViewportRoot=3Dfunction(){return this._domRoot},p.prototype.g=
etViewportRootOffset=3Dfunction(){var t=3Dthis.getViewportRoot();if(t)retur=
n{offsetLeft:t.offsetLeft||0,offsetTop:t.offsetTop||0}},p.prototype.refresh=
=3Dfunction(t){var e=3Dthis.storage.getDisplayList(!0),n=3Dthis._prevDispla=
yList,i=3Dthis._zlevelList;this._redrawId=3DMath.random(),this._paintList(e=
,n,t,this._redrawId);for(var o=3D0;o<i.length;o++){var r,a=3Di[o],a=3Dthis.=
_layers[a];!a.__builtin__&&a.refresh&&(r=3D0=3D=3D=3Do?this._backgroundColo=
r:null,a.refresh(r))}return this._opts.useDirtyRect&&(this._prevDisplayList=
=3De.slice()),this},p.prototype.refreshHover=3Dfunction(){this._paintHoverL=
ist(this.storage.getDisplayList(!1))},p.prototype._paintHoverList=3Dfunctio=
n(t){var e=3Dt.length,n=3Dthis._hoverlayer;if(n&&n.clear(),e){for(var i,o=
=3D{inHover:!0,viewWidth:this._width,viewHeight:this._height},r=3D0;r<e;r++=
){var a=3Dt[r];a.__inHover&&(n=3Dn||(this._hoverlayer=3Dthis.getLayer(1e5))=
,i||(i=3Dn.ctx).save(),Om(i,a,o,r=3D=3D=3De-1))}i&&i.restore()}},p.prototyp=
e.getHoverLayer=3Dfunction(){return this.getLayer(1e5)},p.prototype.paintOn=
e=3Dfunction(t,e){Pm(t,e)},p.prototype._paintList=3Dfunction(t,e,n,i){var o=
,r,a;this._redrawId=3D=3D=3Di&&(n=3Dn||!1,this._updateLayerStatus(t),o=3D(r=
=3Dthis._doPaintList(t,e,n)).finished,r=3Dr.needsRefreshHover,this._needsMa=
nuallyCompositing&&this._compositeManually(),r&&this._paintHoverList(t),o?t=
his.eachLayer(function(t){t.afterBrush&&t.afterBrush()}):(a=3Dthis,Mn(funct=
ion(){a._paintList(t,e,n,i)})))},p.prototype._compositeManually=3Dfunction(=
){var e=3Dthis.getLayer(ax).ctx,n=3Dthis._domRoot.width,i=3Dthis._domRoot.h=
eight;e.clearRect(0,0,n,i),this.eachBuiltinLayer(function(t){t.virtual&&e.d=
rawImage(t.dom,0,0,n,i)})},p.prototype._doPaintList=3Dfunction(d,f,g){for(v=
ar y=3Dthis,m=3D[],v=3Dthis._opts.useDirtyRect,t=3D0;t<this._zlevelList.len=
gth;t++){var e=3Dthis._zlevelList[t],e=3Dthis._layers[e];e.__builtin__&&e!=
=3D=3Dthis._hoverlayer&&(e.__dirty||g)&&m.push(e)}for(var _=3D!0,x=3D!1,w=
=3Dthis,n=3D0;n<m.length;n++)!function(t){function e(t){var e=3D{inHover:!1=
,allClipped:!1,prevEl:null,viewWidth:y._width,viewHeight:y._height};for(i=
=3Ds;i<o.__endIndex;i++){var n=3Dd[i];if(n.__inHover&&(x=3D!0),y._doPaintEl=
(n,o,v,t,e,i=3D=3D=3Do.__endIndex-1),l&&15<Date.now()-u)break}e.prevElClipP=
aths&&r.restore()}var i,n,o=3Dm[t],r=3Do.ctx,a=3Dv&&o.createRepaintRects(d,=
f,w._width,w._height),s=3Dg?o.__startIndex:o.__drawIndex,l=3D!g&&o.incremen=
tal&&Date.now,u=3Dl&&Date.now(),t=3Do.zlevel=3D=3D=3Dw._zlevelList[0]?w._ba=
ckgroundColor:null;o.__startIndex!=3D=3Do.__endIndex&&(s!=3D=3Do.__startInd=
ex||(n=3Dd[s]).incremental&&n.notClear&&!g)||o.clear(!1,t,a),-1=3D=3D=3Ds&&=
(console.error("For some unknown reason. drawIndex is -1"),s=3Do.__startInd=
ex);if(a)if(0=3D=3D=3Da.length)i=3Do.__endIndex;else for(var h=3Dw.dpr,c=3D=
0;c<a.length;++c){var p=3Da[c];r.save(),r.beginPath(),r.rect(p.x*h,p.y*h,p.=
width*h,p.height*h),r.clip(),e(p),r.restore()}else r.save(),e(),r.restore()=
;o.__drawIndex=3Di,o.__drawIndex<o.__endIndex&&(_=3D!1)}(n);return b.wxa&&E=
(this._layers,function(t){t&&t.ctx&&t.ctx.draw&&t.ctx.draw()}),{finished:_,=
needsRefreshHover:x}},p.prototype._doPaintEl=3Dfunction(t,e,n,i,o,r){e=3De.=
ctx;n?(n=3Dt.getPaintRect(),(!i||n&&n.intersect(i))&&(Om(e,t,o,r),t.setPrev=
PaintRect(n))):Om(e,t,o,r)},p.prototype.getLayer=3Dfunction(t,e){this._sing=
leCanvas&&!this._needsManuallyCompositing&&(t=3Dax);var n=3Dthis._layers[t]=
;return n||((n=3Dnew ox("zr_"+t,this,this.dpr)).zlevel=3Dt,n.__builtin__=3D=
!0,this._layerConfig[t]?d(n,this._layerConfig[t],!0):this._layerConfig[t-.0=
1]&&d(n,this._layerConfig[t-.01],!0),e&&(n.virtual=3De),this.insertLayer(t,=
n),n.initContext()),n},p.prototype.insertLayer=3Dfunction(t,e){var n,i=3Dth=
is._layers,o=3Dthis._zlevelList,r=3Do.length,a=3Dthis._domRoot,s=3Dnull,l=
=3D-1;if(!i[t]&&(n=3De)&&(n.__builtin__||"function"=3D=3Dtypeof n.resize&&"=
function"=3D=3Dtypeof n.refresh)){if(0<r&&t>o[0]){for(l=3D0;l<r-1&&!(o[l]<t=
&&o[l+1]>t);l++);s=3Di[o[l]]}o.splice(l+1,0,t),(i[t]=3De).virtual||(s?(n=3D=
s.dom).nextSibling?a.insertBefore(e.dom,n.nextSibling):a.appendChild(e.dom)=
:a.firstChild?a.insertBefore(e.dom,a.firstChild):a.appendChild(e.dom)),e.pa=
inter||(e.painter=3Dthis)}},p.prototype.eachLayer=3Dfunction(t,e){for(var n=
=3Dthis._zlevelList,i=3D0;i<n.length;i++){var o=3Dn[i];t.call(e,this._layer=
s[o],o)}},p.prototype.eachBuiltinLayer=3Dfunction(t,e){for(var n=3Dthis._zl=
evelList,i=3D0;i<n.length;i++){var o=3Dn[i],r=3Dthis._layers[o];r.__builtin=
__&&t.call(e,r,o)}},p.prototype.eachOtherLayer=3Dfunction(t,e){for(var n=3D=
this._zlevelList,i=3D0;i<n.length;i++){var o=3Dn[i],r=3Dthis._layers[o];r._=
_builtin__||t.call(e,r,o)}},p.prototype.getLayers=3Dfunction(){return this.=
_layers},p.prototype._updateLayerStatus=3Dfunction(t){function e(t){o&&(o._=
_endIndex!=3D=3Dt&&(o.__dirty=3D!0),o.__endIndex=3Dt)}if(this.eachBuiltinLa=
yer(function(t,e){t.__dirty=3Dt.__used=3D!1}),this._singleCanvas)for(var n=
=3D1;n<t.length;n++)if((s=3Dt[n]).zlevel!=3D=3Dt[n-1].zlevel||s.incremental=
){this._needsManuallyCompositing=3D!0;break}for(var i,o=3Dnull,r=3D0,a=3D0;=
a<t.length;a++){var s,l=3D(s=3Dt[a]).zlevel,u=3Dvoid 0;i!=3D=3Dl&&(i=3Dl,r=
=3D0),s.incremental?((u=3Dthis.getLayer(l+.001,this._needsManuallyCompositi=
ng)).incremental=3D!0,r=3D1):u=3Dthis.getLayer(l+(0<r?.01:0),this._needsMan=
uallyCompositing),u.__builtin__||it("ZLevel "+l+" has been used by unkown l=
ayer "+u.id),u!=3D=3Do&&(u.__used=3D!0,u.__startIndex!=3D=3Da&&(u.__dirty=
=3D!0),u.__startIndex=3Da,u.incremental?u.__drawIndex=3D-1:u.__drawIndex=3D=
a,e(a),o=3Du),s.__dirty&mn&&!s.__inHover&&(u.__dirty=3D!0,u.incremental)&&u=
.__drawIndex<0&&(u.__drawIndex=3Da)}e(a),this.eachBuiltinLayer(function(t,e=
){!t.__used&&0<t.getElementCount()&&(t.__dirty=3D!0,t.__startIndex=3Dt.__en=
dIndex=3Dt.__drawIndex=3D0),t.__dirty&&t.__drawIndex<0&&(t.__drawIndex=3Dt.=
__startIndex)})},p.prototype.clear=3Dfunction(){return this.eachBuiltinLaye=
r(this._clearLayer),this},p.prototype._clearLayer=3Dfunction(t){t.clear()},=
p.prototype.setBackgroundColor=3Dfunction(t){this._backgroundColor=3Dt,E(th=
is._layers,function(t){t.setUnpainted()})},p.prototype.configLayer=3Dfuncti=
on(t,e){if(e){var n=3Dthis._layerConfig;n[t]?d(n[t],e,!0):n[t]=3De;for(var =
i=3D0;i<this._zlevelList.length;i++){var o=3Dthis._zlevelList[i];o!=3D=3Dt&=
&o!=3D=3Dt+.01||d(this._layers[o],n[t],!0)}}},p.prototype.delLayer=3Dfuncti=
on(t){var e=3Dthis._layers,n=3Dthis._zlevelList,i=3De[t];i&&(i.dom.parentNo=
de.removeChild(i.dom),delete e[t],n.splice(C(n,t),1))},p.prototype.resize=
=3Dfunction(t,e){if(this._domRoot.style){var n=3Dthis._domRoot,i=3D(n.style=
.display=3D"none",this._opts),o=3Dthis.root;if(null!=3Dt&&(i.width=3Dt),nul=
l!=3De&&(i.height=3De),t=3Dpm(o,0,i),e=3Dpm(o,1,i),n.style.display=3D"",thi=
s._width!=3D=3Dt||e!=3D=3Dthis._height){for(var r in n.style.width=3Dt+"px"=
,n.style.height=3De+"px",this._layers)this._layers.hasOwnProperty(r)&&this.=
_layers[r].resize(t,e);this.refresh(!0)}this._width=3Dt,this._height=3De}el=
se{if(null=3D=3Dt||null=3D=3De)return;this._width=3Dt,this._height=3De,this=
.getLayer(ax).resize(t,e)}return this},p.prototype.clearLayer=3Dfunction(t)=
{t=3Dthis._layers[t];t&&t.clear()},p.prototype.dispose=3Dfunction(){this.ro=
ot.innerHTML=3D"",this.root=3Dthis.storage=3Dthis._domRoot=3Dthis._layers=
=3Dnull},p.prototype.getRenderedCanvas=3Dfunction(t){if(this._singleCanvas&=
&!this._compositeManually)return this._layers[ax].dom;var e=3Dnew ox("image=
",this,(t=3Dt||{}).pixelRatio||this.dpr),n=3D(e.initContext(),e.clear(!1,t.=
backgroundColor||this._backgroundColor),e.ctx);if(t.pixelRatio<=3Dthis.dpr)=
{this.refresh();var i=3De.dom.width,o=3De.dom.height;this.eachLayer(functio=
n(t){t.__builtin__?n.drawImage(t.dom,0,0,i,o):t.renderToCanvas&&(n.save(),t=
.renderToCanvas(n),n.restore())})}else for(var r=3D{inHover:!1,viewWidth:th=
is._width,viewHeight:this._height},a=3Dthis.storage.getDisplayList(!0),s=3D=
0,l=3Da.length;s<l;s++){var u=3Da[s];Om(n,u,r,s=3D=3D=3Dl-1)}return e.dom},=
p.prototype.getWidth=3Dfunction(){return this._width},p.prototype.getHeight=
=3Dfunction(){return this._height};var sx=3Dp;function p(t,e,n,i){this.type=
=3D"canvas",this._zlevelList=3D[],this._prevDisplayList=3D[],this._layers=
=3D{},this._layerConfig=3D{},this._needsManuallyCompositing=3D!1,this.type=
=3D"canvas";var o,r,a=3D!t.nodeName||"CANVAS"=3D=3D=3Dt.nodeName.toUpperCas=
e(),e=3D(this._opts=3Dn=3DP({},n||{}),this.dpr=3Dn.devicePixelRatio||lo,thi=
s._singleCanvas=3Da,(this.root=3Dt).style&&(Nt(t),t.innerHTML=3D""),this.st=
orage=3De,this._zlevelList),s=3D(this._prevDisplayList=3D[],this._layers);a=
?(o=3D(a=3Dt).width,r=3Da.height,null!=3Dn.width&&(o=3Dn.width),null!=3Dn.h=
eight&&(r=3Dn.height),this.dpr=3Dn.devicePixelRatio||1,a.width=3Do*this.dpr=
,a.height=3Dr*this.dpr,this._width=3Do,this._height=3Dr,(o=3Dnew ox(a,this,=
this.dpr)).__builtin__=3D!0,o.initContext(),(s[ax]=3Do).zlevel=3Dax,e.push(=
ax),this._domRoot=3Dt):(this._width=3Dpm(t,0,n),this._height=3Dpm(t,1,n),o=
=3Dthis._domRoot=3D(r=3Dthis._width,a=3Dthis._height,(s=3Ddocument.createEl=
ement("div")).style.cssText=3D["position:relative","width:"+r+"px","height:=
"+a+"px","padding:0","margin:0","border-width:0"].join(";")+";",s),t.append=
Child(o))}u(hx,lx=3Dg),hx.prototype.init=3Dfunction(t,e,n){lx.prototype.ini=
t.call(this,t,e,n),this._sourceManager=3Dnew _g(this),wg(this)},hx.prototyp=
e.mergeOption=3Dfunction(t,e){lx.prototype.mergeOption.call(this,t,e),wg(th=
is)},hx.prototype.optionUpdated=3Dfunction(){this._sourceManager.dirty()},h=
x.prototype.getSourceManager=3Dfunction(){return this._sourceManager},hx.ty=
pe=3D"dataset",hx.defaultOption=3D{seriesLayoutBy:rd};var lx,ux=3Dhx;functi=
on hx(){var t=3Dnull!=3D=3Dlx&&lx.apply(this,arguments)||this;return t.type=
=3D"dataset",t}u(dx,cx=3D$g),dx.type=3D"dataset";var cx,px=3Ddx;function dx=
(){var t=3Dnull!=3D=3Dcx&&cx.apply(this,arguments)||this;return t.type=3D"d=
ataset",t}function fx(t){t.registerComponentModel(ux),t.registerComponentVi=
ew(px)}U_([function(t){t.registerPainter("canvas",sx)},fx]),U_(ex);u(mx,gx=
=3DGg),mx.prototype.getInitialData=3Dfunction(t){return Nv(null,this,{useEn=
codeDefaulter:!0})},mx.prototype.getLegendIcon=3Dfunction(t){var e=3Dnew Wo=
,n=3Dam("line",0,t.itemHeight/2,t.itemWidth,0,t.lineStyle.stroke,!1),n=3D(e=
.add(n),n.setStyle(t.lineStyle),this.getData().getVisual("symbol")),i=3Dthi=
s.getData().getVisual("symbolRotate"),n=3D"none"=3D=3D=3Dn?"circle":n,o=3D.=
8*t.itemHeight,o=3Dam(n,(t.itemWidth-o)/2,(t.itemHeight-o)/2,o,o,t.itemStyl=
e.fill),i=3D(e.add(o),o.setStyle(t.itemStyle),"inherit"=3D=3D=3Dt.iconRotat=
e?i:t.iconRotate||0);return o.rotation=3Di*Math.PI/180,o.setOrigin([t.itemW=
idth/2,t.itemHeight/2]),-1<n.indexOf("empty")&&(o.style.stroke=3Do.style.fi=
ll,o.style.fill=3D"#fff",o.style.lineWidth=3D2),e},mx.type=3D"series.line",=
mx.dependencies=3D["grid","polar"],mx.defaultOption=3D{z:3,coordinateSystem=
:"cartesian2d",legendHoverLink:!0,clip:!0,label:{position:"top"},endLabel:{=
show:!1,valueAnimation:!0,distance:8},lineStyle:{width:2,type:"solid"},emph=
asis:{scale:!0},step:!1,smooth:!1,smoothMonotone:null,symbol:"emptyCircle",=
symbolSize:4,symbolRotate:null,showSymbol:!0,showAllSymbol:"auto",connectNu=
lls:!1,sampling:"none",animationEasing:"linear",progressive:0,hoverLayerThr=
eshold:1/0,universalTransition:{divideShape:"clone"},triggerLineEvent:!1};v=
ar gx,yx=3Dmx;function mx(){var t=3Dnull!=3D=3Dgx&&gx.apply(this,arguments)=
||this;return t.type=3Dmx.type,t.hasSymbolVisual=3D!0,t}function vx(t,e){va=
r n,i=3Dt.mapDimensionsAll("defaultedLabel"),o=3Di.length;if(1=3D=3D=3Do)re=
turn null!=3D(n=3DDf(t,e,i[0]))?n+"":null;if(o){for(var r=3D[],a=3D0;a<i.le=
ngth;a++)r.push(Df(t,e,i[a]));return r.join(" ")}}u(bx,_x=3DWo),bx.prototyp=
e._createSymbol=3Dfunction(t,e,n,i,o){this.removeAll();o=3Dam(t,-1,-1,2,2,n=
ull,o);o.attr({z2:100,culling:!0,scaleX:i[0]/2,scaleY:i[1]/2}),o.drift=3DSx=
,this._symbolType=3Dt,this.add(o)},bx.prototype.stopSymbolAnimation=3Dfunct=
ion(t){this.childAt(0).stopAnimation(null,t)},bx.prototype.getSymbolType=3D=
function(){return this._symbolType},bx.prototype.getSymbolPath=3Dfunction()=
{return this.childAt(0)},bx.prototype.highlight=3Dfunction(){kl(this.childA=
t(0))},bx.prototype.downplay=3Dfunction(){Al(this.childAt(0))},bx.prototype=
.setZ=3Dfunction(t,e){var n=3Dthis.childAt(0);n.zlevel=3Dt,n.z=3De},bx.prot=
otype.setDraggable=3Dfunction(t,e){var n=3Dthis.childAt(0);n.draggable=3Dt,=
n.cursor=3D!e&&t?"move":n.cursor},bx.prototype.updateData=3Dfunction(t,e,n,=
i){this.silent=3D!1;var o,r,a,s=3Dt.getItemVisual(e,"symbol")||"circle",l=
=3Dt.hostModel,u=3Dbx.getSymbolSize(t,e),h=3Ds!=3D=3Dthis._symbolType,c=3Di=
&&i.disableAnimation;h?(o=3Dt.getItemVisual(e,"symbolKeepAspect"),this._cre=
ateSymbol(s,t,e,u,o)):((a=3Dthis.childAt(0)).silent=3D!1,r=3D{scaleX:u[0]/2=
,scaleY:u[1]/2},c?a.attr(r):Nh(a,r,l,e),Hh(a)),this._updateCommon(t,e,u,n,i=
),h&&(a=3Dthis.childAt(0),c||(r=3D{scaleX:this._sizeX,scaleY:this._sizeY,st=
yle:{opacity:a.style.opacity}},a.scaleX=3Da.scaleY=3D0,a.style.opacity=3D0,=
Eh(a,r,l,e))),c&&this.childAt(0).stopAnimation("leave")},bx.prototype._upda=
teCommon=3Dfunction(e,t,n,i,o){var r,a,s,l,u,h,c,p,d=3Dthis.childAt(0),f=3D=
e.hostModel,g=3D(i&&(r=3Di.emphasisItemStyle,s=3Di.blurItemStyle,a=3Di.sele=
ctItemStyle,l=3Di.focus,u=3Di.blurScope,c=3Di.labelStatesModels,p=3Di.hover=
Scale,y=3Di.cursorStyle,h=3Di.emphasisDisabled),i&&!e.hasItemOption||(r=3D(=
g=3D(i=3Di&&i.itemModel?i.itemModel:e.getItemModel(t)).getModel("emphasis")=
).getModel("itemStyle").getItemStyle(),a=3Di.getModel(["select","itemStyle"=
]).getItemStyle(),s=3Di.getModel(["blur","itemStyle"]).getItemStyle(),l=3Dg=
.get("focus"),u=3Dg.get("blurScope"),h=3Dg.get("disabled"),c=3Dxc(i),p=3Dg.=
getShallow("scale"),y=3Di.getShallow("cursor")),e.getItemVisual(t,"symbolRo=
tate")),i=3D(d.attr("rotation",(g||0)*Math.PI/180||0),lm(e.getItemVisual(t,=
"symbolOffset"),n)),g=3D(i&&(d.x=3Di[0],d.y=3Di[1]),y&&d.attr("cursor",y),e=
.getItemVisual(t,"style")),i=3Dg.fill,y=3D(d instanceof Cs?(y=3Dd.style,d.u=
seStyle(P({image:y.image,x:y.x,y:y.y,width:y.width,height:y.height},g))):(d=
.__isEmptyBrush?d.useStyle(P({},g)):d.useStyle(g),d.style.decal=3Dnull,d.se=
tColor(i,o&&o.symbolInnerColor),d.style.strokeNoScale=3D!0),e.getItemVisual=
(t,"liftZ")),m=3Dthis._z2,v=3D(null!=3Dy?null=3D=3Dm&&(this._z2=3Dd.z2,d.z2=
+=3Dy):null!=3Dm&&(d.z2=3Dm,this._z2=3Dnull),o&&o.useNameLabel),y=3D(_c(d,c=
,{labelFetcher:f,labelDataIndex:t,defaultText:function(t){return v?e.getNam=
e(t):vx(e,t)},inheritColor:i,defaultOpacity:g.opacity}),this._sizeX=3Dn[0]/=
2,this._sizeY=3Dn[1]/2,d.ensureState("emphasis")),m=3D(y.style=3Dr,d.ensure=
State("select").style=3Da,d.ensureState("blur").style=3Ds,null=3D=3Dp||!0=
=3D=3D=3Dp?Math.max(1.1,3/this._sizeY):isFinite(p)&&0<p?+p:1);y.scaleX=3Dth=
is._sizeX*m,y.scaleY=3Dthis._sizeY*m,this.setSymbolScale(1),Wl(this,l,u,h)}=
,bx.prototype.setSymbolScale=3Dfunction(t){this.scaleX=3Dthis.scaleY=3Dt},b=
x.prototype.fadeOut=3Dfunction(t,e,n){var i=3Dthis.childAt(0),o=3Dk(this).d=
ataIndex,r=3Dn&&n.animation;this.silent=3Di.silent=3D!0,n&&n.fadeLabel?(n=
=3Di.getTextContent())&&Bh(n,{style:{opacity:0}},e,{dataIndex:o,removeOpt:r=
,cb:function(){i.removeTextContent()}}):i.removeTextContent(),Bh(i,{style:{=
opacity:0},scaleX:0,scaleY:0},e,{dataIndex:o,cb:t,removeOpt:r})},bx.getSymb=
olSize=3Dfunction(t,e){return sm(t.getItemVisual(e,"symbolSize"))};var _x,x=
x=3Dbx;function bx(t,e,n,i){var o=3D_x.call(this)||this;return o.updateData=
(t,e,n,i),o}function Sx(t,e){this.parent.drift(t,e)}function Mx(t,e,n,i){re=
turn e&&!isNaN(e[0])&&!isNaN(e[1])&&(!i.isIgnore||!i.isIgnore(n))&&(!i.clip=
Shape||i.clipShape.contain(e[0],e[1]))&&"none"!=3D=3Dt.getItemVisual(n,"sym=
bol")}function Tx(t){return(t=3Dnull=3D=3Dt||O(t)?t:{isIgnore:t})||{}}funct=
ion Ix(t){var t=3Dt.hostModel,e=3Dt.getModel("emphasis");return{emphasisIte=
mStyle:e.getModel("itemStyle").getItemStyle(),blurItemStyle:t.getModel(["bl=
ur","itemStyle"]).getItemStyle(),selectItemStyle:t.getModel(["select","item=
Style"]).getItemStyle(),focus:e.get("focus"),blurScope:e.get("blurScope"),e=
mphasisDisabled:e.get("disabled"),hoverScale:e.get("scale"),labelStatesMode=
ls:xc(t),cursorStyle:t.get("cursor")}}Dx.prototype.updateData=3Dfunction(r,=
a){this._progressiveEls=3Dnull,a=3DTx(a);var s=3Dthis.group,l=3Dr.hostModel=
,u=3Dthis._data,h=3Dthis._SymbolCtor,c=3Da.disableAnimation,p=3DIx(r),d=3D{=
disableAnimation:c},f=3Da.getSymbolPoint||function(t){return r.getItemLayou=
t(t)};u||s.removeAll(),r.diff(u).add(function(t){var e,n=3Df(t);Mx(r,n,t,a)=
&&((e=3Dnew h(r,t,p,d)).setPosition(n),r.setItemGraphicEl(t,e),s.add(e))}).=
update(function(t,e){var n,i,e=3Du.getItemGraphicEl(e),o=3Df(t);Mx(r,o,t,a)=
?(n=3Dr.getItemVisual(t,"symbol")||"circle",i=3De&&e.getSymbolType&&e.getSy=
mbolType(),!e||i&&i!=3D=3Dn?(s.remove(e),(e=3Dnew h(r,t,p,d)).setPosition(o=
)):(e.updateData(r,t,p,d),i=3D{x:o[0],y:o[1]},c?e.attr(i):Nh(e,i,l)),s.add(=
e),r.setItemGraphicEl(t,e)):s.remove(e)}).remove(function(t){var e=3Du.getI=
temGraphicEl(t);e&&e.fadeOut(function(){s.remove(e)},l)}).execute(),this._g=
etSymbolPoint=3Df,this._data=3Dr},Dx.prototype.updateLayout=3Dfunction(){va=
r n=3Dthis,t=3Dthis._data;t&&t.eachItemGraphicEl(function(t,e){e=3Dn._getSy=
mbolPoint(e);t.setPosition(e),t.markRedraw()})},Dx.prototype.incrementalPre=
pareUpdate=3Dfunction(t){this._seriesScope=3DIx(t),this._data=3Dnull,this.g=
roup.removeAll()},Dx.prototype.incrementalUpdate=3Dfunction(t,e,n){function=
 i(t){t.isGroup||(t.incremental=3D!0,t.ensureState("emphasis").hoverLayer=
=3D!0)}this._progressiveEls=3D[],n=3DTx(n);for(var o=3Dt.start;o<t.end;o++)=
{var r,a=3De.getItemLayout(o);Mx(e,a,o,n)&&((r=3Dnew this._SymbolCtor(e,o,t=
his._seriesScope)).traverse(i),r.setPosition(a),this.group.add(r),e.setItem=
GraphicEl(o,r),this._progressiveEls.push(r))}},Dx.prototype.eachRendered=3D=
function(t){fc(this._progressiveEls||this.group,t)},Dx.prototype.remove=3Df=
unction(t){var e=3Dthis.group,n=3Dthis._data;n&&t?n.eachItemGraphicEl(funct=
ion(t){t.fadeOut(function(){e.remove(t)},n.hostModel)}):e.removeAll()};var =
Cx=3DDx;function Dx(t){this.group=3Dnew Wo,this._SymbolCtor=3Dt||xx}functio=
n kx(t,e,n){var i=3Dt.getBaseAxis(),o=3Dt.getOtherAxis(i),n=3D(n=3Dn,a=3D0,=
r=3D(r=3Do).scale.getExtent(),"start"=3D=3D=3Dn?a=3Dr[0]:"end"=3D=3D=3Dn?a=
=3Dr[1]:W(n)&&!isNaN(n)?a=3Dn:0<r[0]?a=3Dr[0]:r[1]<0&&(a=3Dr[1]),a),r=3Di.d=
im,a=3Do.dim,i=3De.mapDimension(a),o=3De.mapDimension(r),s=3D"x"=3D=3D=3Da|=
|"radius"=3D=3D=3Da?1:0,t=3DF(t.dimensions,function(t){return e.mapDimensio=
n(t)}),l=3D!1,u=3De.getCalculationInfo("stackResultDimension");return Ov(e,=
t[0])&&(l=3D!0,t[0]=3Du),Ov(e,t[1])&&(l=3D!0,t[1]=3Du),{dataDimsForPoint:t,=
valueStart:n,valueAxisDim:a,baseAxisDim:r,stacked:!!l,valueDim:i,baseDim:o,=
baseDataOffset:s,stackedOverDimension:e.getCalculationInfo("stackedOverDime=
nsion")}}function Ax(t,e,n,i){var o=3DNaN,r=3D(t.stacked&&(o=3Dn.get(n.getC=
alculationInfo("stackedOverDimension"),i)),isNaN(o)&&(o=3Dt.valueStart),t.b=
aseDataOffset),a=3D[];return a[r]=3Dn.get(t.baseDim,i),a[1-r]=3Do,e.dataToP=
oint(a)}var Lx=3DMath.min,Px=3DMath.max;function Ox(t,e){return isNaN(t)||i=
sNaN(e)}function Rx(t,e,n,i,o,r,a,s,l){for(var u,h,c,p,d=3Dn,f=3D0;f<i;f++)=
{var g=3De[2*d],y=3De[2*d+1];if(o<=3Dd||d<0)break;if(Ox(g,y)){if(l){d+=3Dr;=
continue}break}if(d=3D=3D=3Dn)t[0<r?"moveTo":"lineTo"](g,y),c=3Dg,p=3Dy;els=
e{var m=3Dg-u,v=3Dy-h;if(m*m+v*v<.5){d+=3Dr;continue}if(0<a){for(var _=3Dd+=
r,x=3De[2*_],w=3De[2*_+1];x=3D=3D=3Dg&&w=3D=3D=3Dy&&f<i;)f++,d+=3Dr,x=3De[2=
*(_+=3Dr)],w=3De[2*_+1],g=3De[2*d],y=3De[2*d+1];var b=3Df+1;if(l)for(;Ox(x,=
w)&&b<i;)b++,x=3De[2*(_+=3Dr)],w=3De[2*_+1];var S,M,T,I,C,D,k,A,L,m=3D0,v=
=3D0,P=3Dvoid 0,O=3Dvoid 0;i<=3Db||Ox(x,w)?(k=3Dg,A=3Dy):(m=3Dx-u,v=3Dw-h,S=
=3Dg-u,M=3Dx-g,T=3Dy-h,I=3Dw-y,D=3DC=3Dvoid 0,O=3D"x"=3D=3D=3Ds?(k=3Dg-(L=
=3D0<m?1:-1)*(C=3DMath.abs(S))*a,A=3Dy,P=3Dg+L*(D=3DMath.abs(M))*a,y):"y"=
=3D=3D=3Ds?(k=3Dg,A=3Dy-(L=3D0<v?1:-1)*(C=3DMath.abs(T))*a,P=3Dg,y+L*(D=3DM=
ath.abs(I))*a):(C=3DMath.sqrt(S*S+T*T),k=3Dg-m*a*(1-(S=3D(D=3DMath.sqrt(M*M=
+I*I))/(D+C))),A=3Dy-v*a*(1-S),O=3Dy+v*a*S,P=3DLx(P=3Dg+m*a*S,Px(x,g)),O=3D=
Lx(O,Px(w,y)),P=3DPx(P,Lx(x,g)),A=3Dy-(v=3D(O=3DPx(O,Lx(w,y)))-y)*C/D,k=3DL=
x(k=3Dg-(m=3DP-g)*C/D,Px(u,g)),A=3DLx(A,Px(h,y)),P=3Dg+(m=3Dg-(k=3DPx(k,Lx(=
u,g))))*D/C,y+(v=3Dy-(A=3DPx(A,Lx(h,y))))*D/C)),t.bezierCurveTo(c,p,k,A,g,y=
),c=3DP,p=3DO}else t.lineTo(g,y)}u=3Dg,h=3Dy,d+=3Dr}return f}function Nx(){=
this.smooth=3D0,this.smoothConstraint=3D!0}u(Bx,Ex=3D_s),Bx.prototype.getDe=
faultStyle=3Dfunction(){return{stroke:"#000",fill:null}},Bx.prototype.getDe=
faultShape=3Dfunction(){return new Nx},Bx.prototype.buildPath=3Dfunction(t,=
e){var n=3De.points,i=3D0,o=3Dn.length/2;if(e.connectNulls){for(;0<o&&Ox(n[=
2*o-2],n[2*o-1]);o--);for(;i<o&&Ox(n[2*i],n[2*i+1]);i++);}for(;i<o;)i+=3DRx=
(t,n,i,o,o,1,e.smooth,e.smoothMonotone,e.connectNulls)+1},Bx.prototype.getP=
ointOn=3Dfunction(t,e){this.path||(this.createPathProxy(),this.buildPath(th=
is.path,this.shape));for(var n,i,o=3Dthis.path.data,r=3Des.CMD,a=3D"x"=3D=
=3D=3De,s=3D[],l=3D0;l<o.length;){var u,h=3Dvoid 0,c=3Dvoid 0;switch(o[l++]=
){case r.M:n=3Do[l++],i=3Do[l++];break;case r.L:var p,h=3Do[l++],c=3Do[l++]=
;if((u=3Da?(t-n)/(h-n):(t-i)/(c-i))<=3D1&&0<=3Du)return p=3Da?(c-i)*u+i:(h-=
n)*u+n,a?[t,p]:[p,t];n=3Dh,i=3Dc;break;case r.C:h=3Do[l++],c=3Do[l++];var d=
=3Do[l++],f=3Do[l++],g=3Do[l++],y=3Do[l++],m=3Da?Bn(n,h,d,g,t,s):Bn(i,c,f,y=
,t,s);if(0<m)for(var v=3D0;v<m;v++){var _=3Ds[v];if(_<=3D1&&0<=3D_)return p=
=3Da?En(i,c,f,y,_):En(n,h,d,g,_),a?[t,p]:[p,t]}n=3Dg,i=3Dy}}};var Ex,zx=3DB=
x;function Bx(t){t=3DEx.call(this,t)||this;return t.type=3D"ec-polyline",t}=
u(Xx,Vx=3DNx);var Fx,Vx,Hx=3DXx,Wx=3D(u(Gx,Fx=3D_s),Gx.prototype.getDefault=
Shape=3Dfunction(){return new Hx},Gx.prototype.buildPath=3Dfunction(t,e){va=
r n=3De.points,i=3De.stackedOnPoints,o=3D0,r=3Dn.length/2,a=3De.smoothMonot=
one;if(e.connectNulls){for(;0<r&&Ox(n[2*r-2],n[2*r-1]);r--);for(;o<r&&Ox(n[=
2*o],n[2*o+1]);o++);}for(;o<r;){var s=3DRx(t,n,o,r,r,1,e.smooth,a,e.connect=
Nulls);Rx(t,i,o+s-1,s,r,-1,e.stackedOnSmooth,a,e.connectNulls),o+=3Ds+1,t.c=
losePath()}},Gx);function Gx(t){t=3DFx.call(this,t)||this;return t.type=3D"=
ec-polygon",t}function Xx(){return null!=3D=3DVx&&Vx.apply(this,arguments)|=
|this}function Ux(t,e){return t.type=3D=3D=3De}function Yx(t,e){if(t.length=
=3D=3D=3De.length){for(var n=3D0;n<t.length;n++)if(t[n]!=3D=3De[n])return;r=
eturn 1}}function Zx(t){for(var e=3D1/0,n=3D1/0,i=3D-1/0,o=3D-1/0,r=3D0;r<t=
.length;){var a=3Dt[r++],s=3Dt[r++];isNaN(a)||(e=3DMath.min(a,e),i=3DMath.m=
ax(a,i)),isNaN(s)||(n=3DMath.min(s,n),o=3DMath.max(s,o))}return[[e,n],[i,o]=
]}function qx(t,e){var t=3DZx(t),n=3Dt[0],t=3Dt[1],e=3DZx(e),i=3De[0],e=3De=
[1];return Math.max(Math.abs(n[0]-i[0]),Math.abs(n[1]-i[1]),Math.abs(t[0]-e=
[0]),Math.abs(t[1]-e[1]))}function jx(t){return W(t)?t:t?.5:0}function Kx(t=
,e,n,i){var e=3De.getBaseAxis(),o=3D"x"=3D=3D=3De.dim||"radius"=3D=3D=3De.d=
im?0:1,r=3D[],a=3D0,s=3D[],l=3D[],u=3D[],h=3D[];if(i){for(a=3D0;a<t.length;=
a+=3D2)isNaN(t[a])||isNaN(t[a+1])||h.push(t[a],t[a+1]);t=3Dh}for(a=3D0;a<t.=
length-2;a+=3D2)switch(u[0]=3Dt[a+2],u[1]=3Dt[a+3],l[0]=3Dt[a],l[1]=3Dt[a+1=
],r.push(l[0],l[1]),n){case"end":s[o]=3Du[o],s[1-o]=3Dl[1-o],r.push(s[0],s[=
1]);break;case"middle":var c=3D[];s[o]=3Dc[o]=3D(l[o]+u[o])/2,s[1-o]=3Dl[1-=
o],c[1-o]=3Du[1-o],r.push(s[0],s[1]),r.push(c[0],c[1]);break;default:s[o]=
=3Dl[o],s[1-o]=3Du[1-o],r.push(s[0],s[1])}return r.push(t[a++],t[a++]),r}fu=
nction $x(t,e,n){var i=3Dt.getVisual("visualMeta");if(i&&i.length&&t.count(=
)&&"cartesian2d"=3D=3D=3De.type){for(var o,r,a=3Di.length-1;0<=3Da;a--){var=
 s=3Dt.getDimensionInfo(i[a].dimension);if("x"=3D=3D=3D(o=3Ds&&s.coordDim)|=
|"y"=3D=3D=3Do){r=3Di[a];break}}if(r){var l=3De.getAxis(o),e=3DF(r.stops,fu=
nction(t){return{coord:l.toGlobalCoord(l.dataToCoord(t.value)),color:t.colo=
r}}),u=3De.length,h=3Dr.outerColors.slice(),n=3D(u&&e[0].coord>e[u-1].coord=
&&(e.reverse(),h.reverse()),function(t,e){var n,i,o=3D[],r=3Dt.length;funct=
ion a(t,e,n){var i=3Dt.coord;return{coord:n,color:_i((n-i)/(e.coord-i),[t.c=
olor,e.color])}}for(var s=3D0;s<r;s++){var l=3Dt[s],u=3Dl.coord;if(u<0)n=3D=
l;else{if(e<u){i?o.push(a(i,l,e)):n&&o.push(a(n,l,0),a(n,l,e));break}n&&(o.=
push(a(n,l,0)),n=3Dnull),o.push(l),i=3Dl}}return o}(e,"x"=3D=3D=3Do?n.getWi=
dth():n.getHeight())),c=3Dn.length;if(!c&&u)return e[0].coord<0?h[1]||e[u-1=
].color:h[0]||e[0].color;var p=3Dn[0].coord-10,u=3Dn[c-1].coord+10,d=3Du-p;=
if(d<.001)return"transparent";E(n,function(t){t.offset=3D(t.coord-p)/d}),n.=
push({offset:c?n[c-1].offset:.5,color:h[1]||"transparent"}),n.unshift({offs=
et:c?n[0].offset:.5,color:h[0]||"transparent"});e=3Dnew xh(0,0,0,0,n,!0);re=
turn e[o]=3Dp,e[o+"2"]=3Du,e}}}function Qx(t,e,n){var t=3Dt.get("showAllSym=
bol"),i=3D"auto"=3D=3D=3Dt;if(!t||i){var o,r,a=3Dn.getAxesByScale("ordinal"=
)[0];if(a&&(!i||!function(t,e){var n=3Dt.getExtent(),i=3DMath.abs(n[1]-n[0]=
)/t.scale.count();isNaN(i)&&(i=3D0);for(var o=3De.count(),r=3DMath.max(1,Ma=
th.round(o/5)),a=3D0;a<o;a+=3Dr)if(1.5*xx.getSymbolSize(e,a)[t.isHorizontal=
()?1:0]>i)return;return 1}(a,e)))return o=3De.mapDimension(a.dim),r=3D{},E(=
a.getViewLabels(),function(t){t=3Da.scale.getRawOrdinalNumber(t.tickValue);=
r[t]=3D1}),function(t){return!r.hasOwnProperty(e.get(o,t))}}}function Jx(t)=
{for(var e,n,i=3Dt.length/2;0<i&&(e=3Dt[2*i-2],n=3Dt[2*i-1],isNaN(e)||isNaN=
(n));i--);return i-1}function tw(t,e){return[t[2*e],t[2*e+1]]}function ew(t=
){if(t.get(["endLabel","show"]))return 1;for(var e=3D0;e<al.length;e++)if(t=
.get([al[e],"endLabel","show"]))return 1}function nw(n,i,e,t){var o,r,a,s,l=
,u,h,c,p,d,f,g,y,m,v,_,x;return Ux(i,"cartesian2d")?(o=3Dt.getModel("endLab=
el"),r=3Do.get("valueAnimation"),a=3Dt.getData(),s=3D{lastFrameIndex:0},l=
=3Dew(t)?function(t,e){n._endLabelOnDuring(t,e,a,s,r,o,i)}:null,x=3Di.getBa=
seAxis().isHorizontal(),h=3De,m=3Dt,v=3Dfunction(){var t=3Dn._endLabel;t&&e=
&&null!=3Ds.originalX&&t.attr({x:s.originalX,y:s.originalY})},c=3Dl,y=3D(g=
=3D(u=3Di).getArea()).x,f=3Dg.y,p=3Dg.width,g=3Dg.height,_=3Dm.get(["lineSt=
yle","width"])||2,y-=3D_/2,f-=3D_/2,p+=3D_,g+=3D_,p=3DMath.ceil(p),y!=3D=3D=
Math.floor(y)&&(y=3DMath.floor(y),p++),d=3Dnew Es({shape:{x:y,y:f,width:p,h=
eight:g}}),h&&(h=3D(_=3Du.getBaseAxis()).isHorizontal(),u=3D_.inverse,h?(u&=
&(d.shape.x+=3Dp),d.shape.width=3D0):(u||(d.shape.y+=3Dg),d.shape.height=3D=
0),_=3DD(c)?function(t){c(t,d)}:null,Eh(d,{shape:{width:p,height:g,x:y,y:f}=
},m,null,v,_)),h=3Dd,t.get("clip",!0)||(u=3Dh.shape,p=3DMath.max(u.width,u.=
height),x?(u.y-=3Dp,u.height+=3D2*p):(u.x-=3Dp,u.width+=3D2*p)),l&&l(1,h),h=
):(g=3De,y=3Dt,m=3D(f=3Di).getArea(),v=3Dnr(m.r0,1),_=3Dnr(m.r,1),x=3Dnew B=
u({shape:{cx:nr(f.cx,1),cy:nr(f.cy,1),r0:v,r:_,startAngle:m.startAngle,endA=
ngle:m.endAngle,clockwise:m.clockwise}}),g&&("angle"=3D=3D=3Df.getBaseAxis(=
).dim?x.shape.endAngle=3Dm.startAngle:x.shape.r=3Dv,Eh(x,{shape:{endAngle:m=
.endAngle,r:_}},y)),x)}u(rw,iw=3Dny),rw.prototype.init=3Dfunction(){var t=
=3Dnew Wo,e=3Dnew Cx;this.group.add(e.group),this._symbolDraw=3De,this._lin=
eGroup=3Dt},rw.prototype.render=3Dfunction(t,e,n){var i=3Dthis,o=3Dt.coordi=
nateSystem,r=3Dthis.group,a=3Dt.getData(),s=3Dt.getModel("lineStyle"),l=3Dt=
.getModel("areaStyle"),u=3Da.getLayout("points")||[],h=3D"polar"=3D=3D=3Do.=
type,c=3Dthis._coordSys,p=3Dthis._symbolDraw,d=3Dthis._polyline,f=3Dthis._p=
olygon,g=3Dthis._lineGroup,e=3D!e.ssr&&t.get("animation"),y=3D!l.isEmpty(),=
m=3Dl.get("origin"),v=3Dkx(o,a,m),v=3Dy&&function(t,e,n){if(!n.valueDim)ret=
urn[];for(var i=3De.count(),o=3Dr_(2*i),r=3D0;r<i;r++){var a=3DAx(n,t,e,r);=
o[2*r]=3Da[0],o[2*r+1]=3Da[1]}return o}(o,a,v),_=3Dt.get("showSymbol"),x=3D=
t.get("connectNulls"),w=3D_&&!h&&Qx(t,a,o),b=3Dthis._data;b&&b.eachItemGrap=
hicEl(function(t,e){t.__temp&&(r.remove(t),b.setItemGraphicEl(e,null))}),_|=
|p.remove(),r.add(g);function S(t){i._changePolyState(t)}var M,T=3D!h&&t.ge=
t("step"),I=3D(o&&o.getArea&&t.get("clip",!0)&&(null!=3D(M=3Do.getArea()).w=
idth?(M.x-=3D.1,M.y-=3D.1,M.width+=3D.2,M.height+=3D.2):M.r0&&(M.r0-=3D.5,M=
.r+=3D.5)),this._clipShapeForSymbol=3DM,$x(a,o,n)||a.getVisual("style")[a.g=
etVisual("drawType")]),c=3D(d&&c.type=3D=3D=3Do.type&&T=3D=3D=3Dthis._step?=
(y&&!f?f=3Dthis._newPolygon(u,v):f&&!y&&(g.remove(f),f=3Dthis._polygon=3Dnu=
ll),h||this._initOrUpdateEndLabel(t,o,Rp(I)),(c=3Dg.getClipPath())?Eh(c,{sh=
ape:nw(this,o,!1,t).shape},t):g.setClipPath(nw(this,o,!0,t)),_&&p.updateDat=
a(a,{isIgnore:w,clipShape:M,disableAnimation:!0,getSymbolPoint:function(t){=
return[u[2*t],u[2*t+1]]}}),Yx(this._stackedOnPoints,v)&&Yx(this._points,u)|=
|(e?this._doUpdateAnimation(a,v,o,n,T,m,x):(T&&(u=3DKx(u,o,T,x),v=3Dv&&Kx(v=
,o,T,x)),d.setShape({points:u}),f&&f.setShape({points:u,stackedOnPoints:v})=
))):(_&&p.updateData(a,{isIgnore:w,clipShape:M,disableAnimation:!0,getSymbo=
lPoint:function(t){return[u[2*t],u[2*t+1]]}}),e&&this._initSymbolLabelAnima=
tion(a,o,M),T&&(u=3DKx(u,o,T,x),v=3Dv&&Kx(v,o,T,x)),d=3Dthis._newPolyline(u=
),y?f=3Dthis._newPolygon(u,v):f&&(g.remove(f),f=3Dthis._polygon=3Dnull),h||=
this._initOrUpdateEndLabel(t,o,Rp(I)),g.setClipPath(nw(this,o,!0,t))),t.get=
Model("emphasis")),n=3Dc.get("focus"),_=3Dc.get("blurScope"),p=3Dc.get("dis=
abled"),w=3D(d.useStyle(B(s.getLineStyle(),{fill:"none",stroke:I,lineJoin:"=
bevel"})),Ul(d,t,"lineStyle"),0<d.style.lineWidth&&"bolder"=3D=3D=3Dt.get([=
"emphasis","lineStyle","width"])&&(d.getState("emphasis").style.lineWidth=
=3D+d.style.lineWidth+1),k(d).seriesIndex=3Dt.seriesIndex,Wl(d,n,_,p),jx(t.=
get("smooth"))),e=3Dt.get("smoothMonotone");d.setShape({smooth:w,smoothMono=
tone:e,connectNulls:x}),f&&(M=3Da.getCalculationInfo("stackedOnSeries"),y=
=3D0,f.useStyle(B(l.getAreaStyle(),{fill:I,opacity:.7,lineJoin:"bevel",deca=
l:a.getVisual("style").decal})),M&&(y=3Djx(M.get("smooth"))),f.setShape({sm=
ooth:w,stackedOnSmooth:y,smoothMonotone:e,connectNulls:x}),Ul(f,t,"areaStyl=
e"),k(f).seriesIndex=3Dt.seriesIndex,Wl(f,n,_,p));a.eachItemGraphicEl(funct=
ion(t){t&&(t.onHoverStateChange=3DS)}),this._polyline.onHoverStateChange=3D=
S,this._data=3Da,this._coordSys=3Do,this._stackedOnPoints=3Dv,this._points=
=3Du,this._step=3DT,this._valueOrigin=3Dm,t.get("triggerLineEvent")&&(this.=
packEventData(t,d),f)&&this.packEventData(t,f)},rw.prototype.packEventData=
=3Dfunction(t,e){k(e).eventData=3D{componentType:"series",componentSubType:=
"line",componentIndex:t.componentIndex,seriesIndex:t.seriesIndex,seriesName=
:t.name,seriesType:"line"}},rw.prototype.highlight=3Dfunction(t,e,n,i){var =
o=3Dt.getData(),r=3DOr(o,i);if(this._changePolyState("emphasis"),!(r instan=
ceof Array)&&null!=3Dr&&0<=3Dr){var a=3Do.getLayout("points"),s=3Do.getItem=
GraphicEl(r);if(!s){var l=3Da[2*r],a=3Da[2*r+1];if(isNaN(l)||isNaN(a))retur=
n;if(this._clipShapeForSymbol&&!this._clipShapeForSymbol.contain(l,a))retur=
n;var u=3Dt.get("zlevel")||0,h=3Dt.get("z")||0,l=3D((s=3Dnew xx(o,r)).x=3Dl=
,s.y=3Da,s.setZ(u,h),s.getSymbolPath().getTextContent());l&&(l.zlevel=3Du,l=
.z=3Dh,l.z2=3Dthis._polyline.z2+1),s.__temp=3D!0,o.setItemGraphicEl(r,s),s.=
stopSymbolAnimation(!0),this.group.add(s)}s.highlight()}else ny.prototype.h=
ighlight.call(this,t,e,n,i)},rw.prototype.downplay=3Dfunction(t,e,n,i){var =
o,r=3Dt.getData(),a=3DOr(r,i);this._changePolyState("normal"),null!=3Da&&0<=
=3Da?(o=3Dr.getItemGraphicEl(a))&&(o.__temp?(r.setItemGraphicEl(a,null),thi=
s.group.remove(o)):o.downplay()):ny.prototype.downplay.call(this,t,e,n,i)},=
rw.prototype._changePolyState=3Dfunction(t){var e=3Dthis._polygon;Sl(this._=
polyline,t),e&&Sl(e,t)},rw.prototype._newPolyline=3Dfunction(t){var e=3Dthi=
s._polyline;return e&&this._lineGroup.remove(e),e=3Dnew zx({shape:{points:t=
},segmentIgnoreThreshold:2,z2:10}),this._lineGroup.add(e),this._polyline=3D=
e},rw.prototype._newPolygon=3Dfunction(t,e){var n=3Dthis._polygon;return n&=
&this._lineGroup.remove(n),n=3Dnew Wx({shape:{points:t,stackedOnPoints:e},s=
egmentIgnoreThreshold:2}),this._lineGroup.add(n),this._polygon=3Dn},rw.prot=
otype._initSymbolLabelAnimation=3Dfunction(t,l,u){var h,c,e=3Dl.getBaseAxis=
(),p=3De.inverse,e=3D("cartesian2d"=3D=3D=3Dl.type?(h=3De.isHorizontal(),c=
=3D!1):"polar"=3D=3D=3Dl.type&&(h=3D"angle"=3D=3D=3De.dim,c=3D!0),t.hostMod=
el),d=3De.get("animationDuration"),f=3D(D(d)&&(d=3Dd(null)),e.get("animatio=
nDelay")||0),g=3DD(f)?f(null):f;t.eachItemGraphicEl(function(t,e){var n,i,o=
,r,a,s=3Dt;s&&(r=3D[t.x,t.y],a=3Di=3Dn=3Dvoid 0,u&&(a=3Dc?(o=3Du,r=3Dl.poin=
tToCoord(r),h?(n=3Do.startAngle,i=3Do.endAngle,-r[1]/180*Math.PI):(n=3Do.r0=
,i=3Do.r,r[0])):h?(n=3Du.x,i=3Du.x+u.width,t.x):(n=3Du.y+u.height,i=3Du.y,t=
.y)),o=3Di=3D=3D=3Dn?0:(a-n)/(i-n),p&&(o=3D1-o),r=3DD(f)?f(e):d*o+g,a=3D(t=
=3Ds.getSymbolPath()).getTextContent(),s.attr({scaleX:0,scaleY:0}),s.animat=
eTo({scaleX:1,scaleY:1},{duration:200,setToFinal:!0,delay:r}),a&&a.animateF=
rom({style:{opacity:0}},{duration:300,delay:r}),t.disableLabelAnimation=3D!=
0)})},rw.prototype._initOrUpdateEndLabel=3Dfunction(t,e,n){var u,i,o,r=3Dt.=
getModel("endLabel");ew(t)?(u=3Dt.getData(),i=3Dthis._polyline,(o=3Du.getLa=
yout("points"))?(this._endLabel||((this._endLabel=3Dnew Hs({z2:200})).ignor=
eClip=3D!0,i.setTextContent(this._endLabel),i.disableLabelAnimation=3D!0),0=
<=3D(o=3DJx(o))&&(_c(i,xc(t,"endLabel"),{inheritColor:n,labelFetcher:t,labe=
lDataIndex:o,defaultText:function(t,e,n){if(null=3D=3Dn)return vx(u,t);var =
i=3Du,o=3Dn,r=3Di.mapDimensionsAll("defaultedLabel");if(!V(o))return o+"";f=
or(var a=3D[],s=3D0;s<r.length;s++){var l=3Di.getDimensionIndex(r[s]);0<=3D=
l&&a.push(o[l])}return a.join(" ")},enableTextSetter:!0},(n=3Dr,o=3D(t=3D(t=
=3De).getBaseAxis()).isHorizontal(),t=3Dt.inverse,r=3Do?t?"right":"left":"c=
enter",o=3Do?"middle":t?"top":"bottom",{normal:{align:n.get("align")||r,ver=
ticalAlign:n.get("verticalAlign")||o}})),i.textConfig.position=3Dnull)):(i.=
removeTextContent(),this._endLabel=3Dnull)):this._endLabel&&(this._polyline=
.removeTextContent(),this._endLabel=3Dnull)},rw.prototype._endLabelOnDuring=
=3Dfunction(t,e,n,i,o,r,a){var s,l,u,h,c,p,d,f,g,y,m=3Dthis._endLabel,v=3Dt=
his._polyline;m&&(t<1&&null=3D=3Di.originalX&&(i.originalX=3Dm.x,i.original=
Y=3Dm.y),s=3Dn.getLayout("points"),g=3D(l=3Dn.hostModel).get("connectNulls"=
),u=3Dr.get("precision"),r=3Dr.get("distance")||0,c=3D(a=3Da.getBaseAxis())=
.isHorizontal(),a=3Da.inverse,e=3De.shape,h=3D(c?r:0)*(a?-1:1),r=3D(c?0:-r)=
*(a?-1:1),d=3Dvoid 0,1<=3D(f=3D(p=3D(c=3Dfunction(t,e,n){for(var i,o,r=3Dt.=
length/2,a=3D"x"=3D=3D=3Dn?0:1,s=3D0,l=3D-1,u=3D0;u<r;u++)if(o=3Dt[2*u+a],!=
isNaN(o)&&!isNaN(t[2*u+1-a])){if(0!=3D=3Du){if(i<=3De&&e<=3Do||e<=3Di&&o<=
=3De){l=3Du;break}s=3Du}i=3Do}return{range:[s,l],t:(e-i)/(o-i)}}(s,a=3Da?c?=
e.x:e.y+e.height:c?e.x+e.width:e.y,e=3Dc?"x":"y")).range)[1]-p[0])?(1<f&&!g=
?(y=3Dtw(s,p[0]),m.attr({x:y[0]+h,y:y[1]+r}),o&&(d=3Dl.getRawValue(p[0]))):=
((y=3Dv.getPointOn(a,e))&&m.attr({x:y[0]+h,y:y[1]+r}),f=3Dl.getRawValue(p[0=
]),g=3Dl.getRawValue(p[1]),o&&(d=3DWr(n,u,f,g,c.t))),i.lastFrameIndex=3Dp[0=
]):(y=3Dtw(s,v=3D1=3D=3D=3Dt||0<i.lastFrameIndex?p[0]:0),o&&(d=3Dl.getRawVa=
lue(v)),m.attr({x:y[0]+h,y:y[1]+r})),o)&&"function"=3D=3Dtypeof(a=3DCc(m)).=
setLabelText&&a.setLabelText(d)},rw.prototype._doUpdateAnimation=3Dfunction=
(t,e,n,i,o,r,a){var s=3Dthis._polyline,l=3Dthis._polygon,u=3Dt.hostModel,e=
=3Dfunction(t,e,n,i,o,r){a=3D[],e.diff(t).add(function(t){a.push({cmd:"+",i=
dx:t})}).update(function(t,e){a.push({cmd:"=3D",idx:e,idx1:t})}).remove(fun=
ction(t){a.push({cmd:"-",idx:t})}).execute();for(var a,s=3Da,l=3D[],u=3D[],=
h=3D[],c=3D[],p=3D[],d=3D[],f=3D[],g=3Dkx(o,e,r),y=3Dt.getLayout("points")|=
|[],m=3De.getLayout("points")||[],v=3D0;v<s.length;v++){var _=3Ds[v],x=3D!0=
,w=3Dvoid 0;switch(_.cmd){case"=3D":var b=3D2*_.idx,w=3D2*_.idx1,S=3Dy[b],M=
=3Dy[1+b],T=3Dm[w],I=3Dm[w+1];(isNaN(S)||isNaN(M))&&(S=3DT,M=3DI),l.push(S,=
M),u.push(T,I),h.push(n[b],n[1+b]),c.push(i[w],i[w+1]),f.push(e.getRawIndex=
(_.idx1));break;case"+":S=3D_.idx,M=3Dg.dataDimsForPoint,T=3Do.dataToPoint(=
[e.get(M[0],S),e.get(M[1],S)]),I=3D(w=3D2*S,l.push(T[0],T[1]),u.push(m[w],m=
[w+1]),Ax(g,o,e,S));h.push(I[0],I[1]),c.push(i[w],i[w+1]),f.push(e.getRawIn=
dex(S));break;case"-":x=3D!1}x&&(p.push(_),d.push(d.length))}d.sort(functio=
n(t,e){return f[t]-f[e]});for(var C=3Dr_(r=3Dl.length),D=3Dr_(r),k=3Dr_(r),=
A=3Dr_(r),L=3D[],v=3D0;v<d.length;v++){var P=3Dd[v],O=3D2*v,R=3D2*P;C[O]=3D=
l[R],C[1+O]=3Dl[1+R],D[O]=3Du[R],D[1+O]=3Du[1+R],k[O]=3Dh[R],k[1+O]=3Dh[1+R=
],A[O]=3Dc[R],A[1+O]=3Dc[1+R],L[v]=3Dp[P]}return{current:C,next:D,stackedOn=
Current:k,stackedOnNext:A,status:L}}(this._data,t,this._stackedOnPoints,e,t=
his._coordSys,this._valueOrigin),h=3De.current,c=3De.stackedOnCurrent,p=3De=
.next,d=3De.stackedOnNext;if(o&&(h=3DKx(e.current,n,o,a),c=3DKx(e.stackedOn=
Current,n,o,a),p=3DKx(e.next,n,o,a),d=3DKx(e.stackedOnNext,n,o,a)),3e3<qx(h=
,p)||l&&3e3<qx(c,d))s.stopAnimation(),s.setShape({points:p}),l&&(l.stopAnim=
ation(),l.setShape({points:p,stackedOnPoints:d}));else{s.shape.__points=3De=
.current,s.shape.points=3Dh;n=3D{shape:{points:p}};e.current!=3D=3Dh&&(n.sh=
ape.__points=3De.next),s.stopAnimation(),Nh(s,n,u),l&&(l.setShape({points:h=
,stackedOnPoints:c}),l.stopAnimation(),Nh(l,{shape:{stackedOnPoints:d}},u),=
s.shape.points!=3D=3Dl.shape.points)&&(l.shape.points=3Ds.shape.points);for=
(var f,g=3D[],y=3De.status,m=3D0;m<y.length;m++)"=3D"=3D=3D=3Dy[m].cmd&&(f=
=3Dt.getItemGraphicEl(y[m].idx1))&&g.push({el:f,ptIdx:m});s.animators&&s.an=
imators.length&&s.animators[0].during(function(){l&&l.dirtyShape();for(var =
t=3Ds.shape.__points,e=3D0;e<g.length;e++){var n=3Dg[e].el,i=3D2*g[e].ptIdx=
;n.x=3Dt[i],n.y=3Dt[1+i],n.markRedraw()}})}},rw.prototype.remove=3Dfunction=
(t){var n=3Dthis.group,i=3Dthis._data;this._lineGroup.removeAll(),this._sym=
bolDraw.remove(!0),i&&i.eachItemGraphicEl(function(t,e){t.__temp&&(n.remove=
(t),i.setItemGraphicEl(e,null))}),this._polyline=3Dthis._polygon=3Dthis._co=
ordSys=3Dthis._points=3Dthis._stackedOnPoints=3Dthis._endLabel=3Dthis._data=
=3Dnull},rw.type=3D"line";var iw,ow=3Drw;function rw(){return null!=3D=3Diw=
&&iw.apply(this,arguments)||this}var aw=3D{average:function(t){for(var e=3D=
0,n=3D0,i=3D0;i<t.length;i++)isNaN(t[i])||(e+=3Dt[i],n++);return 0=3D=3D=3D=
n?NaN:e/n},sum:function(t){for(var e=3D0,n=3D0;n<t.length;n++)e+=3Dt[n]||0;=
return e},max:function(t){for(var e=3D-1/0,n=3D0;n<t.length;n++)t[n]>e&&(e=
=3Dt[n]);return isFinite(e)?e:NaN},min:function(t){for(var e=3D1/0,n=3D0;n<=
t.length;n++)t[n]<e&&(e=3Dt[n]);return isFinite(e)?e:NaN},minmax:function(t=
){for(var e=3D-1/0,n=3D-1/0,i=3D0;i<t.length;i++){var o=3Dt[i],r=3DMath.abs=
(o);e<r&&(e=3Dr,n=3Do)}return isFinite(n)?n:NaN},nearest:function(t){return=
 t[0]}},sw=3Dfunction(t){return Math.round(t.length/2)};U_(function(t){var =
i;t.registerChartView(ow),t.registerSeriesModel(yx),t.registerLayout((i=3D!=
0,{seriesType:"line",plan:Jg(),reset:function(t){var h,e,c,p,d,n=3Dt.getDat=
a(),f=3Dt.coordinateSystem,t=3Dt.pipelineContext,g=3Di||t.large;if(f)return=
 t=3DF(f.dimensions,function(t){return n.mapDimension(t)}).slice(0,2),h=3Dt=
.length,e=3Dn.getCalculationInfo("stackResultDimension"),Ov(n,t[0])&&(t[0]=
=3De),Ov(n,t[1])&&(t[1]=3De),c=3Dn.getStore(),p=3Dn.getDimensionIndex(t[0])=
,d=3Dn.getDimensionIndex(t[1]),h&&{progress:function(t,e){for(var n=3Dt.end=
-t.start,i=3Dg&&r_(n*h),o=3D[],r=3D[],a=3Dt.start,s=3D0;a<t.end;a++){var l,=
u=3Dvoid 0;u=3D1=3D=3D=3Dh?(l=3Dc.get(p,a),f.dataToPoint(l,null,r)):(o[0]=
=3Dc.get(p,a),o[1]=3Dc.get(d,a),f.dataToPoint(o,null,r)),g?(i[s++]=3Du[0],i=
[s++]=3Du[1]):e.setItemLayout(a,u.slice())}g&&e.setLayout("points",i)}}}}))=
,t.registerVisual({seriesType:"line",reset:function(t){var e=3Dt.getData(),=
t=3Dt.getModel("lineStyle").getLineStyle();t&&!t.stroke&&(t.stroke=3De.getV=
isual("style").fill),e.setVisual("legendLineStyle",t)}}),t.registerProcesso=
r(t.PRIORITY.PROCESSOR.STATISTIC,{seriesType:"line",reset:function(t,e,n){v=
ar i,o=3Dt.getData(),r=3Dt.get("sampling"),a=3Dt.coordinateSystem,s=3Do.cou=
nt();10<s&&"cartesian2d"=3D=3D=3Da.type&&r&&(i=3Da.getBaseAxis(),a=3Da.getO=
therAxis(i),i=3Di.getExtent(),n=3Dn.getDevicePixelRatio(),i=3DMath.abs(i[1]=
-i[0])*(n||1),n=3DMath.round(s/i),isFinite(n))&&1<n&&("lttb"=3D=3D=3Dr&&t.s=
etData(o.lttbDownSample(o.mapDimension(a.dim),1/n)),s=3Dvoid 0,H(r)?s=3Daw[=
r]:D(r)&&(s=3Dr),s)&&t.setData(o.downSample(o.mapDimension(a.dim),1/n,s,sw)=
)}})});var lw=3D2*Math.PI,uw=3DMath.PI/180;function hw(t,e){return Vp(t.get=
BoxLayoutParams(),{width:e.getWidth(),height:e.getHeight()})}function cw(t,=
e){var n=3Dhw(t,e),i=3Dt.get("center"),o=3Dt.get("radius");V(o)||(o=3D[0,o]=
);var r,a=3Der(n.width,e.getWidth()),e=3Der(n.height,e.getHeight()),s=3DMat=
h.min(a,e),l=3Der(o[0],s/2),o=3Der(o[1],s/2),s=3Dt.coordinateSystem;return =
s=3Ds?(r=3D(t=3Ds.dataToPoint(i))[0]||0,t[1]||0):(r=3Der((i=3DV(i)?i:[i,i])=
[0],a)+n.x,er(i[1],e)+n.y),{cx:r,cy:s,r0:l,r:o}}function pw(t,e,I){e.eachSe=
riesByType(t,function(t){var o,a=3Dt.getData(),e=3Da.mapDimension("value"),=
n=3Dhw(t,I),i=3Dcw(t,I),s=3Di.cx,l=3Di.cy,u=3Di.r,h=3Di.r0,r=3D-t.get("star=
tAngle")*uw,i=3Dt.get("endAngle"),c=3Dt.get("padAngle")*uw,i=3D"auto"=3D=3D=
=3Di?r-lw:-i*uw,p=3Dt.get("minAngle")*uw+c,d=3D0,f=3D(a.each(e,function(t){=
isNaN(t)||d++}),a.getSum(e)),g=3DMath.PI/(f||d)*2,y=3Dt.get("clockwise"),m=
=3Dt.get("roseType"),v=3Dt.get("stillShowZeroSum"),_=3Da.getDataExtent(e),x=
=3D(_[0]=3D0,y?1:-1),t=3D[r,i],w=3Dx*c/2,b=3D(ts(t,!y),r=3Dt[0],Math.abs(t[=
1]-r)),S=3Db,M=3D0,T=3Dr;a.setLayout({viewRect:n,r:u}),a.each(e,function(t,=
e){var n,i,o,r;isNaN(t)?a.setItemLayout(e,{angle:NaN,startAngle:NaN,endAngl=
e:NaN,clockwise:y,cx:s,cy:l,r0:h,r:m?NaN:u}):((n=3D"area"!=3D=3Dm?0=3D=3D=
=3Df&&v?g:t*g:b/d)<p?S-=3Dn=3Dp:M+=3Dt,i=3DT+x*n,r=3Do=3D0,r=3Dn<c?o=3DT+x*=
n/2:(o=3DT+w,i-w),a.setItemLayout(e,{angle:n,startAngle:o,endAngle:r,clockw=
ise:y,cx:s,cy:l,r0:h,r:m?tr(t,_,[h,u]):u}),T=3Di)}),S<lw&&d&&(S<=3D.001?(o=
=3Db/d,a.each(e,function(t,e){var n,i;isNaN(t)||(i=3Dt=3D0,i=3D((n=3Da.getI=
temLayout(e)).angle=3Do)<c?t=3Dr+x*(e+.5)*o:(t=3Dr+x*e*o+w,r+x*(e+1)*o-w),n=
.startAngle=3Dt,n.endAngle=3Di)})):(g=3DS/M,T=3Dr,a.each(e,function(t,e){va=
r n,i;isNaN(t)||(i=3Dn=3D0,i=3D(t=3D(e=3Da.getItemLayout(e)).angle=3D=3D=3D=
p?p:t*g)<c?n=3DT+x*t/2:(n=3DT+w,T+x*t-w),e.startAngle=3Dn,e.endAngle=3Di,T+=
=3Dx*t)})))})}var dw=3DMath.PI/180;function fw(t,s,l,u,h,e,n,i,o,r){if(!(t.=
length<2)){for(var a,c=3Dt.length,p=3D0;p<c;p++)"outer"=3D=3D=3Dt[p].positi=
on&&"labelLine"=3D=3D=3Dt[p].labelAlignTo&&(a=3Dt[p].label.x-r,t[p].linePoi=
nts[1][0]+=3Da,t[p].label.x=3Dr);if(G1(t,o,o+n)){for(var d,f,g,y,m,v=3Dt,_=
=3D{list:[],maxY:0},x=3D{list:[],maxY:0},w=3D0;w<v.length;w++)"none"=3D=3D=
=3Dv[w].labelAlignTo&&(f=3D(d=3Dv[w]).label.y>l?x:_,(g=3DMath.abs(d.label.y=
-l))>=3Df.maxY&&(m=3Dd.label.x-s-d.len2*h,y=3Du+d.len,m=3DMath.abs(m)<y?Mat=
h.sqrt(g*g/(1-m*m/y/y)):y,f.rB=3Dm,f.maxY=3Dg),f.list.push(d));b(_),b(x)}}f=
unction b(t){for(var e=3Dt.rB,n=3De*e,i=3D0;i<t.list.length;i++){var o=3Dt.=
list[i],r=3DMath.abs(o.label.y-l),a=3Du+o.len,a=3Da*a,r=3DMath.sqrt((1-Math=
.abs(r*r/n))*a),a=3Ds+(r+o.len2)*h,r=3Da-o.label.x;gw(o,o.targetTextWidth-r=
*h,!0),o.label.x=3Da}}}function gw(t,e,n){var i,o,r,a,s,l,u;void 0=3D=3D=3D=
n&&(n=3D!1),null=3D=3Dt.labelStyleWidth&&(s=3D(i=3Dt.label).style,o=3Dt.rec=
t,l=3Ds.backgroundColor,u=3D(u=3Ds.padding)?u[1]+u[3]:0,s=3Ds.overflow,e<(r=
=3Do.width+(l?0:u))||n)&&(a=3Do.height,s&&s.match("break")?(i.setStyle("bac=
kgroundColor",null),i.setStyle("width",e-u),s=3Di.getBoundingRect(),i.setSt=
yle("width",Math.ceil(s.width)),i.setStyle("backgroundColor",l)):(s=3De-u,l=
=3D!(e<r)&&(!n||s>t.unconstrainedWidth)?null:s,i.setStyle("width",l)),u=3Di=
.getBoundingRect(),o.width=3Du.width,e=3D(i.style.margin||0)+2.1,o.height=
=3Du.height+e,o.y-=3D(o.height-a)/2)}function yw(t){return"center"=3D=3D=3D=
t.position}function mw(t){var S,M,T=3Dt.getData(),I=3D[],C=3D!1,D=3D(t.get(=
"minShowLabelAngle")||0)*dw,e=3DT.getLayout("viewRect"),k=3DT.getLayout("r"=
),A=3De.width,L=3De.x,n=3De.y,e=3De.height;function P(t){t.ignore=3D!0}if(T=
.each(function(t){var e,n,i,o,r,a,s,l,u,h,c,p=3DT.getItemGraphicEl(t),d=3Dp=
.shape,f=3Dp.getTextContent(),g=3Dp.getTextGuideLine(),t=3DT.getItemModel(t=
),y=3Dt.getModel("label"),m=3Dy.get("position")||t.get(["emphasis","label",=
"position"]),v=3Dy.get("distanceToLabelLine"),_=3Dy.get("alignTo"),x=3Der(y=
.get("edgeDistance"),A),w=3Dy.get("bleedMargin"),t=3Dt.getModel("labelLine"=
),b=3Der(t.get("length"),A);e=3Der(t.get("length2"),A),Math.abs(d.endAngle-=
d.startAngle)<D?(E(f.states,P),f.ignore=3D!0,g&&(E(g.states,P),g.ignore=3D!=
0)):function(t){if(!t.ignore)return 1;for(var e in t.states)if(!1=3D=3D=3Dt=
.states[e].ignore)return 1}(f)&&(c=3D(d.startAngle+d.endAngle)/2,n=3DMath.c=
os(c),i=3DMath.sin(c),S=3Dd.cx,M=3Dd.cy,o=3D"inside"=3D=3D=3Dm||"inner"=3D=
=3D=3Dm,l=3D"center"=3D=3D=3Dm?(r=3Dd.cx,a=3Dd.cy,"center"):(r=3D(l=3D(o?(d=
.r+d.r0)/2*n:d.r*n)+S)+3*n,a=3D(u=3D(o?(d.r+d.r0)/2*i:d.r*i)+M)+3*i,o||(s=
=3Dl+n*(b+k-d.r),d=3Du+i*(b+k-d.r),h=3Ds+(n<0?-1:1)*e,r=3D"edge"=3D=3D=3D_?=
n<0?L+x:L+A-x:h+(n<0?-v:v),s=3D[[l,u],[s,a=3Dd],[h,d]]),o?"center":"edge"=
=3D=3D=3D_?0<n?"right":"left":0<n?"left":"right"),u=3DMath.PI,h=3D0,W(d=3Dy=
.get("rotate"))?h=3Dd*(u/180):"center"=3D=3D=3Dm?h=3D0:"radial"=3D=3D=3Dd||=
!0=3D=3D=3Dd?h=3Dn<0?-c+u:-c:"tangential"=3D=3D=3Dd&&"outside"!=3D=3Dm&&"ou=
ter"!=3D=3Dm&&((y=3DMath.atan2(n,i))<0&&(y=3D2*u+y),h=3D(y=3D0<i?u+y:y)-u),=
C=3D!!h,f.x=3Dr,f.y=3Da,f.rotation=3Dh,f.setStyle({verticalAlign:"middle"})=
,o?(f.setStyle({align:l}),(c=3Df.states.select)&&(c.x+=3Df.x,c.y+=3Df.y)):(=
(d=3Df.getBoundingRect().clone()).applyTransform(f.getComputedTransform()),=
y=3D(f.style.margin||0)+2.1,d.y-=3Dy/2,d.height+=3Dy,I.push({label:f,labelL=
ine:g,position:m,len:b,len2:e,minTurnAngle:t.get("minTurnAngle"),maxSurface=
Angle:t.get("maxSurfaceAngle"),surfaceNormal:new z(n,i),linePoints:s,textAl=
ign:l,labelDistance:v,labelAlignTo:_,edgeDistance:x,bleedMargin:w,rect:d,un=
constrainedWidth:d.width,labelStyleWidth:f.style.width})),p.setTextConfig({=
inside:o}))}),!C&&t.get("avoidLabelOverlap")){for(var i=3DI,o=3DS,r=3D(t=3D=
M,k),a=3DA,s=3DL,l,u,h,c,p,d,f=3D[],g=3D[],y=3DNumber.MAX_VALUE,m=3D-Number=
.MAX_VALUE,v=3D0;v<i.length;v++){var _=3Di[v].label;yw(i[v])||(_.x<o?(y=3DM=
ath.min(y,_.x),f):(m=3DMath.max(m,_.x),g)).push(i[v])}for(v=3D0;v<i.length;=
v++)!yw(u=3Di[v])&&u.linePoints&&null=3D=3Du.labelStyleWidth&&(_=3Du.label,=
h=3Du.linePoints,l=3Dvoid 0,l=3D"edge"=3D=3D=3Du.labelAlignTo?_.x<o?h[2][0]=
-u.labelDistance-s-u.edgeDistance:s+a-u.edgeDistance-h[2][0]-u.labelDistanc=
e:"labelLine"=3D=3D=3Du.labelAlignTo?_.x<o?y-s-u.bleedMargin:s+a-m-u.bleedM=
argin:_.x<o?_.x-s-u.bleedMargin:s+a-_.x-u.bleedMargin,u.targetTextWidth=3Dl=
,gw(u,l));for(fw(g,o,t,r,1,0,e,0,n,m),fw(f,o,t,r,-1,0,e,0,n,y),v=3D0;v<i.le=
ngth;v++)!yw(u=3Di[v])&&u.linePoints&&(_=3Du.label,h=3Du.linePoints,c=3D"ed=
ge"=3D=3D=3Du.labelAlignTo,p=3D(p=3D_.style.padding)?p[1]+p[3]:0,p=3D_.styl=
e.backgroundColor?0:p,p=3Du.rect.width+p,d=3Dh[1][0]-h[2][0],c?_.x<o?h[2][0=
]=3Ds+u.edgeDistance+p+u.labelDistance:h[2][0]=3Ds+a-u.edgeDistance-p-u.lab=
elDistance:(_.x<o?h[2][0]=3D_.x+u.labelDistance:h[2][0]=3D_.x-u.labelDistan=
ce,h[1][0]=3Dh[2][0]+d),h[1][1]=3Dh[2][1]=3D_.y)}for(var x=3D0;x<I.length;x=
++){var w,b=3DI[x],O=3Db.label,R=3Db.labelLine,N=3DisNaN(O.x)||isNaN(O.y);O=
&&(O.setStyle({align:b.textAlign}),N&&(E(O.states,P),O.ignore=3D!0),w=3DO.s=
tates.select)&&(w.x+=3DO.x,w.y+=3DO.y),R&&(w=3Db.linePoints,N||!w?(E(R.stat=
es,P),R.ignore=3D!0):(E1(w,b.minTurnAngle),function(t,e,n){if(n<=3D180&&0<n=
){n=3Dn/180*Math.PI,D1.fromArray(t[0]),k1.fromArray(t[1]),A1.fromArray(t[2]=
),z.sub(L1,k1,D1),z.sub(P1,A1,k1);var i=3DL1.len(),o=3DP1.len();if(!(i<.001=
||o<.001)&&(L1.scale(1/i),P1.scale(1/o),L1.dot(e)<Math.cos(n))){i=3DM1(k1.x=
,k1.y,A1.x,A1.y,D1.x,D1.y,R1,!1),o=3D(N1.fromArray(R1),Math.PI/2),e=3Do+Mat=
h.acos(P1.dot(e))-n;if(o<=3De)z.copy(N1,A1);else{N1.scaleAndAdd(P1,i/Math.t=
an(Math.PI/2-e));n=3DA1.x!=3D=3Dk1.x?(N1.x-k1.x)/(A1.x-k1.x):(N1.y-k1.y)/(A=
1.y-k1.y);if(isNaN(n))return;n<0?z.copy(N1,k1):1<n&&z.copy(N1,A1)}N1.toArra=
y(t[1])}}}(w,b.surfaceNormal,b.maxSurfaceAngle),R.setShape({points:w}),O.__=
hostTarget.textGuideLineConfig=3D{anchor:new z(w[0][0],w[0][1])}))}}functio=
n vw(t,e,n){t=3Dt.get("borderRadius");if(null=3D=3Dt)return n?{cornerRadius=
:0}:null;V(t)||(t=3D[t,t,t,t]);var i=3DMath.abs(e.r||0-e.r0||0);return{corn=
erRadius:F(t,function(t){return Do(t,i)})}}u(Mw,xw=3DBu),Mw.prototype.updat=
eData=3Dfunction(t,e,n,i){var o=3Dthis,r=3Dt.hostModel,a=3Dt.getItemModel(e=
),s=3Da.getModel("emphasis"),l=3Dt.getItemLayout(e),u=3DP(vw(a.getModel("it=
emStyle"),l,!0),l);isNaN(u.startAngle)?o.setShape(u):(i?(o.setShape(u),i=3D=
r.getShallow("animationType"),r.ecModel.ssr?(Eh(o,{scaleX:0,scaleY:0},r,{da=
taIndex:e,isFrom:!0}),o.originX=3Du.cx,o.originY=3Du.cy):"scale"=3D=3D=3Di?=
(o.shape.r=3Dl.r0,Eh(o,{shape:{r:l.r}},r,e)):null!=3Dn?(o.setShape({startAn=
gle:n,endAngle:n}),Eh(o,{shape:{startAngle:l.startAngle,endAngle:l.endAngle=
}},r,e)):(o.shape.endAngle=3Dl.startAngle,Nh(o,{shape:{endAngle:l.endAngle}=
},r,e))):(Hh(o),Nh(o,{shape:u},r,e)),o.useStyle(t.getItemVisual(e,"style"))=
,Ul(o,a),i=3D(l.startAngle+l.endAngle)/2,n=3Dr.get("selectedOffset"),u=3DMa=
th.cos(i)*n,i=3DMath.sin(i)*n,(n=3Da.getShallow("cursor"))&&o.attr("cursor"=
,n),this._updateLabel(r,t,e),o.ensureState("emphasis").shape=3DP({r:l.r+(s.=
get("scale")&&s.get("scaleSize")||0)},vw(s.getModel("itemStyle"),l)),P(o.en=
sureState("select"),{x:u,y:i,shape:vw(a.getModel(["select","itemStyle"]),l)=
}),P(o.ensureState("blur"),{shape:vw(a.getModel(["blur","itemStyle"]),l)}),=
n=3Do.getTextGuideLine(),r=3Do.getTextContent(),n&&P(n.ensureState("select"=
),{x:u,y:i}),P(r.ensureState("select"),{x:u,y:i}),Wl(this,s.get("focus"),s.=
get("blurScope"),s.get("disabled")))},Mw.prototype._updateLabel=3Dfunction(=
t,e,n){var i=3De.getItemModel(n),o=3Di.getModel("labelLine"),r=3De.getItemV=
isual(n,"style"),a=3Dr&&r.fill,r=3Dr&&r.opacity,e=3D(_c(this,xc(i),{labelFe=
tcher:e.hostModel,labelDataIndex:n,inheritColor:a,defaultOpacity:r,defaultT=
ext:t.getFormattedLabel(n,"normal")||e.getName(n)}),this.getTextContent()),=
n=3D(this.setTextConfig({position:null,rotation:null}),e.attr({z2:10}),t.ge=
t(["label","position"]));"outside"!=3D=3Dn&&"outer"!=3D=3Dn?this.removeText=
GuideLine():(this.getTextGuideLine()||(e=3Dnew $u,this.setTextGuideLine(e))=
,F1(this,V1(i),{stroke:a,opacity:xt(o.get(["lineStyle","opacity"]),r,1)}))}=
;var _w,xw,ww=3DMw,bw=3D(u(Sw,_w=3Dny),Sw.prototype.render=3Dfunction(e,t,n=
,i){var o,r=3De.getData(),a=3Dthis._data,s=3Dthis.group;if(!a&&0<r.count())=
{for(var l=3Dr.getItemLayout(0),u=3D1;isNaN(l&&l.startAngle)&&u<r.count();+=
+u)l=3Dr.getItemLayout(u);l&&(o=3Dl.startAngle)}this._emptyCircleSector&&s.=
remove(this._emptyCircleSector),0=3D=3D=3Dr.count()&&e.get("showEmptyCircle=
")&&((n=3Dnew Bu({shape:cw(e,n)})).useStyle(e.getModel("emptyCircleStyle").=
getItemStyle()),this._emptyCircleSector=3Dn,s.add(n)),r.diff(a).add(functio=
n(t){var e=3Dnew ww(r,t,o);r.setItemGraphicEl(t,e),s.add(e)}).update(functi=
on(t,e){e=3Da.getItemGraphicEl(e);e.updateData(r,t,o),e.off("click"),s.add(=
e),r.setItemGraphicEl(t,e)}).remove(function(t){Vh(a.getItemGraphicEl(t),e,=
t)}).execute(),mw(e),"expansion"!=3D=3De.get("animationTypeUpdate")&&(this.=
_data=3Dr)},Sw.prototype.dispose=3Dfunction(){},Sw.prototype.containPoint=
=3Dfunction(t,e){var n,e=3De.getData().getItemLayout(0);if(e)return n=3Dt[0=
]-e.cx,t=3Dt[1]-e.cy,(n=3DMath.sqrt(n*n+t*t))<=3De.r&&n>=3De.r0},Sw.type=3D=
"pie",Sw);function Sw(){var t=3Dnull!=3D=3D_w&&_w.apply(this,arguments)||th=
is;return t.ignoreLabelLineUpdate=3D!0,t}function Mw(t,e,n){var i=3Dxw.call=
(this)||this,o=3D(i.z2=3D2,new Hs);return i.setTextContent(o),i.updateData(=
t,e,n,!0),i}Iw.prototype.getAllNames=3Dfunction(){var t=3Dthis._getRawData(=
);return t.mapArray(t.getName)},Iw.prototype.containName=3Dfunction(t){retu=
rn 0<=3Dthis._getRawData().indexOfName(t)},Iw.prototype.indexOfName=3Dfunct=
ion(t){return this._getDataWithEncodedVisual().indexOfName(t)},Iw.prototype=
.getItemVisual=3Dfunction(t,e){return this._getDataWithEncodedVisual().getI=
temVisual(t,e)};var Tw=3DIw;function Iw(t,e){this._getDataWithEncodedVisual=
=3Dt,this._getRawData=3De}var Cw,Dw=3DRr(),kw=3D(u(Aw,Cw=3DGg),Aw.prototype=
.init=3Dfunction(t){Cw.prototype.init.apply(this,arguments),this.legendVisu=
alProvider=3Dnew Tw(S(this.getData,this),S(this.getRawData,this)),this._def=
aultLabelLine(t)},Aw.prototype.mergeOption=3Dfunction(){Cw.prototype.mergeO=
ption.apply(this,arguments)},Aw.prototype.getInitialData=3Dfunction(){retur=
n e=3DV(e=3D{coordDimensions:["value"],encodeDefaulter:M(hd,t=3Dthis)})?{co=
ordDimensions:e}:P({encodeDefine:t.getEncode()},e),i=3Dt.getSource(),e=3DDv=
(i,e).dimensions,(e=3Dnew Cv(e,t)).initData(i,n),e;var t,e,n,i},Aw.prototyp=
e.getDataParams=3Dfunction(t){var e,n=3Dthis.getData(),i=3DDw(n),o=3Di.seat=
s,i=3D(o||(e=3D[],n.each(n.mapDimension("value"),function(t){e.push(t)}),o=
=3Di.seats=3Dsr(e,n.hostModel.get("percentPrecision"))),Cw.prototype.getDat=
aParams.call(this,t));return i.percent=3Do[t]||0,i.$vars.push("percent"),i}=
,Aw.prototype._defaultLabelLine=3Dfunction(t){Sr(t,"labelLine",["show"]);va=
r e=3Dt.labelLine,n=3Dt.emphasis.labelLine;e.show=3De.show&&t.label.show,n.=
show=3Dn.show&&t.emphasis.label.show},Aw.type=3D"series.pie",Aw.defaultOpti=
on=3D{z:2,legendHoverLink:!0,colorBy:"data",center:["50%","50%"],radius:[0,=
"75%"],clockwise:!0,startAngle:90,endAngle:"auto",padAngle:0,minAngle:0,min=
ShowLabelAngle:0,selectedOffset:10,percentPrecision:2,stillShowZeroSum:!0,l=
eft:0,top:0,right:0,bottom:0,width:null,height:null,label:{rotate:0,show:!0=
,overflow:"truncate",position:"outer",alignTo:"none",edgeDistance:"25%",ble=
edMargin:10,distanceToLabelLine:5},labelLine:{show:!0,length:15,length2:15,=
smooth:!1,minTurnAngle:90,maxSurfaceAngle:90,lineStyle:{width:1,type:"solid=
"}},itemStyle:{borderWidth:1,borderJoin:"round"},showEmptyCircle:!0,emptyCi=
rcleStyle:{color:"lightgray",opacity:1},labelLayout:{hideOverlap:!0},emphas=
is:{scale:!0,scaleSize:5},avoidLabelOverlap:!0,animationType:"expansion",an=
imationDuration:1e3,animationTypeUpdate:"transition",animationEasingUpdate:=
"cubicInOut",animationDurationUpdate:500,animationEasing:"cubicInOut"},Aw);=
function Aw(){return null!=3D=3DCw&&Cw.apply(this,arguments)||this}U_(funct=
ion(t){t.registerChartView(bw),t.registerSeriesModel(kw),Uy("pie",t.registe=
rAction),t.registerLayout(M(pw,"pie")),t.registerProcessor({seriesType:"pie=
",reset:function(t,e){var i,o=3De.findComponents({mainType:"legend"});o&&o.=
length&&(i=3Dt.getData()).filterSelf(function(t){for(var e=3Di.getName(t),n=
=3D0;n<o.length;n++)if(!o[n].isSelected(e))return!1;return!0})}}),t.registe=
rProcessor({seriesType:"pie",reset:function(t,e){var n=3Dt.getData();n.filt=
erSelf(function(t){var e=3Dn.mapDimension("value"),e=3Dn.get(e,t);return!(W=
(e)&&!isNaN(e)&&e<0)})}})});u(Ow,Lw=3Dg),Ow.type=3D"grid",Ow.dependencies=
=3D["xAxis","yAxis"],Ow.layoutMode=3D"box",Ow.defaultOption=3D{show:!1,z:0,=
left:"10%",top:60,right:"10%",bottom:70,containLabel:!1,backgroundColor:"rg=
ba(0,0,0,0)",borderWidth:1,borderColor:"#ccc"};var Lw,Pw=3DOw;function Ow()=
{return null!=3D=3DLw&&Lw.apply(this,arguments)||this}u(Ew,Rw=3Dg),Ew.proto=
type.getCoordSysModel=3Dfunction(){return this.getReferringComponents("grid=
",Br).models[0]},Ew.type=3D"cartesian2dAxis";var Rw,Nw=3DEw;function Ew(){r=
eturn null!=3D=3DRw&&Rw.apply(this,arguments)||this}at(Nw,H_);var Pc=3D{sho=
w:!0,z:0,inverse:!1,name:"",nameLocation:"end",nameRotate:null,nameTruncate=
:{maxWidth:null,ellipsis:"...",placeholder:"."},nameTextStyle:{},nameGap:15=
,silent:!1,triggerEvent:!1,tooltip:{show:!1},axisPointer:{},axisLine:{show:=
!0,onZero:!0,onZeroAxisIndex:null,lineStyle:{color:"#6E7079",width:1,type:"=
solid"},symbol:["none","none"],symbolSize:[10,15]},axisTick:{show:!0,inside=
:!1,length:5,lineStyle:{width:1}},axisLabel:{show:!0,inside:!1,rotate:0,sho=
wMinLabel:null,showMaxLabel:null,margin:8,fontSize:12},splitLine:{show:!0,l=
ineStyle:{color:["#E0E6F1"],width:1,type:"solid"}},splitArea:{show:!1,areaS=
tyle:{color:["rgba(250,250,250,0.2)","rgba(210,219,238,0.2)"]}}},jr=3Dd({bo=
undaryGap:!0,deduplication:null,splitLine:{show:!1},axisTick:{alignWithLabe=
l:!1,interval:"auto"},axisLabel:{interval:"auto"}},Pc),Ky=3Dd({boundaryGap:=
[0,0],axisLine:{show:"auto"},axisTick:{show:"auto"},splitNumber:5,minorTick=
:{show:!1,splitNumber:5,length:3,lineStyle:{}},minorSplitLine:{show:!1,line=
Style:{color:"#F4F7FD",width:1}}},Pc),zw=3D{category:jr,value:Ky,time:d({sp=
litNumber:6,axisLabel:{showMinLabel:!1,showMaxLabel:!1,rich:{primary:{fontW=
eight:"bold"}}},splitLine:{show:!1}},Ky),log:B({logBase:10},Ky)},Bw=3D{valu=
e:1,category:1,time:1,log:1};function Fw(r,a,s,l){E(Bw,function(t,o){var e,=
n=3Dd(d({},zw[o],!0),l,!0),n=3D(u(i,e=3Ds),i.prototype.mergeDefaultAndTheme=
=3Dfunction(t,e){var n=3DHp(this),i=3Dn?Gp(t):{};d(t,e.getTheme().get(o+"Ax=
is")),d(t,this.getDefaultOption()),t.type=3DVw(t),n&&Wp(t,i,n)},i.prototype=
.optionUpdated=3Dfunction(){"category"=3D=3D=3Dthis.option.type&&(this.__or=
dinalMeta=3DFv.createByAxisModel(this))},i.prototype.getCategories=3Dfuncti=
on(t){var e=3Dthis.option;if("category"=3D=3D=3De.type)return t?e.data:this=
.__ordinalMeta.categories},i.prototype.getOrdinalMeta=3Dfunction(){return t=
his.__ordinalMeta},i.type=3Da+"Axis."+o,i.defaultOption=3Dn,i);function i()=
{var t=3Dnull!=3D=3De&&e.apply(this,arguments)||this;return t.type=3Da+"Axi=
s."+o,t}r.registerComponentModel(n)}),r.registerSubTypeDefaulter(a+"Axis",V=
w)}function Vw(t){return t.type||(t.data?"category":"value")}function Hw(t)=
{this.type=3D"cartesian",this._dimList=3D[],this._axes=3D{},this.name=3Dt||=
""}Hw.prototype.getAxis=3Dfunction(t){return this._axes[t]},Hw.prototype.ge=
tAxes=3Dfunction(){return F(this._dimList,function(t){return this._axes[t]}=
,this)},Hw.prototype.getAxesByScale=3Dfunction(e){return e=3De.toLowerCase(=
),ut(this.getAxes(),function(t){return t.scale.type=3D=3D=3De})},Hw.prototy=
pe.addAxis=3Dfunction(t){var e=3Dt.dim;this._axes[e]=3Dt,this._dimList.push=
(e)};var Ww=3D["x","y"];function Gw(t){return"interval"=3D=3D=3Dt.type||"ti=
me"=3D=3D=3Dt.type}u(Yw,Xw=3DHw),Yw.prototype.calcAffineTransform=3Dfunctio=
n(){this._transform=3Dthis._invTransform=3Dnull;var t,e,n,i,o=3Dthis.getAxi=
s("x").scale,r=3Dthis.getAxis("y").scale;Gw(o)&&Gw(r)&&(o=3Do.getExtent(),r=
=3Dr.getExtent(),i=3Dthis.dataToPoint([o[0],r[0]]),e=3Dthis.dataToPoint([o[=
1],r[1]]),t=3Do[1]-o[0],n=3Dr[1]-r[0],t)&&n&&(t=3D(e[0]-i[0])/t,e=3D(e[1]-i=
[1])/n,n=3Di[0]-o[0]*t,o=3Di[1]-r[0]*e,i=3Dthis._transform=3D[t,0,0,e,n,o],=
this._invTransform=3DBe([],i))},Yw.prototype.getBaseAxis=3Dfunction(){retur=
n this.getAxesByScale("ordinal")[0]||this.getAxesByScale("time")[0]||this.g=
etAxis("x")},Yw.prototype.containPoint=3Dfunction(t){var e=3Dthis.getAxis("=
x"),n=3Dthis.getAxis("y");return e.contain(e.toLocalCoord(t[0]))&&n.contain=
(n.toLocalCoord(t[1]))},Yw.prototype.containData=3Dfunction(t){return this.=
getAxis("x").containData(t[0])&&this.getAxis("y").containData(t[1])},Yw.pro=
totype.containZone=3Dfunction(t,e){var t=3Dthis.dataToPoint(t),e=3Dthis.dat=
aToPoint(e),n=3Dthis.getArea(),e=3Dnew G(t[0],t[1],e[0]-t[0],e[1]-t[1]);ret=
urn n.intersect(e)},Yw.prototype.dataToPoint=3Dfunction(t,e,n){n=3Dn||[];va=
r i,o=3Dt[0],r=3Dt[1];return this._transform&&null!=3Do&&isFinite(o)&&null!=
=3Dr&&isFinite(r)?Jt(n,t,this._transform):(t=3Dthis.getAxis("x"),i=3Dthis.g=
etAxis("y"),n[0]=3Dt.toGlobalCoord(t.dataToCoord(o,e)),n[1]=3Di.toGlobalCoo=
rd(i.dataToCoord(r,e)),n)},Yw.prototype.clampData=3Dfunction(t,e){var n=3Dt=
his.getAxis("x").scale,i=3Dthis.getAxis("y").scale,o=3Dn.getExtent(),r=3Di.=
getExtent(),n=3Dn.parse(t[0]),i=3Di.parse(t[1]);return(e=3De||[])[0]=3DMath=
.min(Math.max(Math.min(o[0],o[1]),n),Math.max(o[0],o[1])),e[1]=3DMath.min(M=
ath.max(Math.min(r[0],r[1]),i),Math.max(r[0],r[1])),e},Yw.prototype.pointTo=
Data=3Dfunction(t,e){var n,i,o=3D[];return this._invTransform?Jt(o,t,this._=
invTransform):(n=3Dthis.getAxis("x"),i=3Dthis.getAxis("y"),o[0]=3Dn.coordTo=
Data(n.toLocalCoord(t[0]),e),o[1]=3Di.coordToData(i.toLocalCoord(t[1]),e),o=
)},Yw.prototype.getOtherAxis=3Dfunction(t){return this.getAxis("x"=3D=3D=3D=
t.dim?"y":"x")},Yw.prototype.getArea=3Dfunction(t){t=3Dt||0;var e=3Dthis.ge=
tAxis("x").getGlobalExtent(),n=3Dthis.getAxis("y").getGlobalExtent(),i=3DMa=
th.min(e[0],e[1])-t,o=3DMath.min(n[0],n[1])-t,e=3DMath.max(e[0],e[1])-i+t,n=
=3DMath.max(n[0],n[1])-o+t;return new G(i,o,e,n)};var Xw,Uw=3DYw;function Y=
w(){var t=3Dnull!=3D=3DXw&&Xw.apply(this,arguments)||this;return t.type=3D"=
cartesian2d",t.dimensions=3DWw,t}u(jw,Zw=3DEc),jw.prototype.isHorizontal=3D=
function(){var t=3Dthis.position;return"top"=3D=3D=3Dt||"bottom"=3D=3D=3Dt}=
,jw.prototype.getGlobalExtent=3Dfunction(t){var e=3Dthis.getExtent();return=
 e[0]=3Dthis.toGlobalCoord(e[0]),e[1]=3Dthis.toGlobalCoord(e[1]),t&&e[0]>e[=
1]&&e.reverse(),e},jw.prototype.pointToData=3Dfunction(t,e){return this.coo=
rdToData(this.toLocalCoord(t["x"=3D=3D=3Dthis.dim?0:1]),e)},jw.prototype.se=
tCategorySortInfo=3Dfunction(t){if("category"!=3D=3Dthis.type)return!1;this=
.model.option.categorySortInfo=3Dt,this.scale.setSortInfo(t)};var Zw,qw=3Dj=
w;function jw(t,e,n,i,o){t=3DZw.call(this,t,e,n)||this;return t.index=3D0,t=
.type=3Di||"value",t.position=3Do||"bottom",t}function Kw(t,e,n){n=3Dn||{};=
var t=3Dt.coordinateSystem,i=3De.axis,o=3D{},r=3Di.getAxesOnZeroOf()[0],a=
=3Di.position,s=3Dr?"onZero":a,i=3Di.dim,t=3Dt.getRect(),t=3D[t.x,t.x+t.wid=
th,t.y,t.y+t.height],l=3D{left:0,right:1,top:0,bottom:1,onZero:2},u=3De.get=
("offset")||0,u=3D"x"=3D=3D=3Di?[t[2]-u,t[3]+u]:[t[0]-u,t[1]+u],h=3D(r&&(h=
=3Dr.toGlobalCoord(r.dataToCoord(0)),u[l.onZero]=3DMath.max(Math.min(h,u[1]=
),u[0])),o.position=3D["y"=3D=3D=3Di?u[l[s]]:t[0],"x"=3D=3D=3Di?u[l[s]]:t[3=
]],o.rotation=3DMath.PI/2*("x"=3D=3D=3Di?0:1),o.labelDirection=3Do.tickDire=
ction=3Do.nameDirection=3D{top:-1,bottom:1,left:-1,right:1}[a],o.labelOffse=
t=3Dr?u[l[a]]-u[l.onZero]:0,e.get(["axisTick","inside"])&&(o.tickDirection=
=3D-o.tickDirection),_t(n.labelInside,e.get(["axisLabel","inside"]))&&(o.la=
belDirection=3D-o.labelDirection),e.get(["axisLabel","rotate"]));return o.l=
abelRotate=3D"top"=3D=3D=3Ds?-h:h,o.z2=3D1,o}function $w(t){return"cartesia=
n2d"=3D=3D=3Dt.get("coordinateSystem")}function Qw(i){var o=3D{xAxisModel:n=
ull,yAxisModel:null};return E(o,function(t,e){var n=3De.replace(/Model$/,""=
),n=3Di.getReferringComponents(n,Br).models[0];o[e]=3Dn}),o}var Jw=3DMath.l=
og;eb.prototype.getRect=3Dfunction(){return this._rect},eb.prototype.update=
=3Dfunction(t,e){var n=3Dthis._axesMap;function i(t){var d,e=3Dht(t),n=3De.=
length;if(n){for(var i=3D[],o=3Dn-1;0<=3Do;o--){var r=3Dt[+e[o]],a=3Dr.mode=
l,s=3Dr.scale;Wv(s)&&a.get("alignTicks")&&null=3D=3Da.get("interval")?i.pus=
h(r):(O_(s,a),Wv(s)&&(d=3Dr))}i.length&&(d||O_((d=3Di.pop()).scale,d.model)=
,E(i,function(t){var e=3Dt.scale,t=3Dt.model,n=3Dd.scale,i=3De_.prototype,o=
=3Di.getTicks.call(n),r=3Di.getTicks.call(n,!0),a=3Do.length-1,n=3Di.getInt=
erval.call(n),s=3D(t=3DP_(e,t)).extent,l=3Dt.fixMin,t=3Dt.fixMax,u=3D("log"=
=3D=3D=3De.type&&(u=3DJw(e.base),s=3D[Jw(s[0])/u,Jw(s[1])/u]),e.setExtent(s=
[0],s[1]),e.calcNiceExtent({splitNumber:a,fixMin:l,fixMax:t}),i.getExtent.c=
all(e)),h=3D(l&&(s[0]=3Du[0]),t&&(s[1]=3Du[1]),i.getInterval.call(e)),c=3Ds=
[0],p=3Ds[1];if(l&&t)h=3D(p-c)/a;else if(l)for(p=3Ds[0]+h*a;p<s[1]&&isFinit=
e(p)&&isFinite(s[1]);)h=3DXv(h),p=3Ds[0]+h*a;else if(t)for(c=3Ds[1]-h*a;c>s=
[0]&&isFinite(c)&&isFinite(s[0]);)h=3DXv(h),c=3Ds[1]-h*a;else{u=3D(h=3De.ge=
tTicks().length-1>a?Xv(h):h)*a;(c=3Dnr((p=3DMath.ceil(s[1]/h)*h)-u))<0&&0<=
=3Ds[0]?(c=3D0,p=3Dnr(u)):0<p&&s[1]<=3D0&&(p=3D0,c=3D-nr(u))}l=3D(o[0].valu=
e-r[0].value)/n,t=3D(o[a].value-r[a].value)/n,i.setExtent.call(e,c+h*l,p+h*=
t),i.setInterval.call(e,h),(l||t)&&i.setNiceExtent.call(e,c+h,p-h)}))}}this=
._updateScale(t,this.model),i(n.x),i(n.y);var o=3D{};E(n.x,function(t){ib(n=
,"y",t,o)}),E(n.y,function(t){ib(n,"x",t,o)}),this.resize(this.model,e)},eb=
.prototype.resize=3Dfunction(t,e,n){var i=3Dt.getBoxLayoutParams(),n=3D!n&&=
t.get("containLabel"),a=3DVp(i,{width:e.getWidth(),height:e.getHeight()}),o=
=3D(this._rect=3Da,this._axesList);function r(){E(o,function(t){var e,n,i=
=3Dt.isHorizontal(),o=3Di?[0,a.width]:[0,a.height],r=3Dt.inverse?1:0;t.setE=
xtent(o[r],o[1-r]),o=3Dt,e=3Di?a.x:a.y,r=3Do.getExtent(),n=3Dr[0]+r[1],o.to=
GlobalCoord=3D"x"=3D=3D=3Do.dim?function(t){return t+e}:function(t){return =
n-t+e},o.toLocalCoord=3D"x"=3D=3D=3Do.dim?function(t){return t-e}:function(=
t){return n-t+e}})}r(),n&&(E(o,function(t){var e,n,i;t.model.get(["axisLabe=
l","inside"])||(e=3Dz_(t))&&(n=3Dt.isHorizontal()?"height":"width",i=3Dt.mo=
del.get(["axisLabel","margin"]),a[n]-=3De[n]+i,"top"=3D=3D=3Dt.position?a.y=
+=3De.height+i:"left"=3D=3D=3Dt.position&&(a.x+=3De.width+i))}),r()),E(this=
._coordsList,function(t){t.calcAffineTransform()})},eb.prototype.getAxis=3D=
function(t,e){t=3Dthis._axesMap[t];if(null!=3Dt)return t[e||0]},eb.prototyp=
e.getAxes=3Dfunction(){return this._axesList.slice()},eb.prototype.getCarte=
sian=3Dfunction(t,e){if(null!=3Dt&&null!=3De)return this._coordsMap["x"+t+"=
y"+e];O(t)&&(e=3Dt.yAxisIndex,t=3Dt.xAxisIndex);for(var n=3D0,i=3Dthis._coo=
rdsList;n<i.length;n++)if(i[n].getAxis("x").index=3D=3D=3Dt||i[n].getAxis("=
y").index=3D=3D=3De)return i[n]},eb.prototype.getCartesians=3Dfunction(){re=
turn this._coordsList.slice()},eb.prototype.convertToPixel=3Dfunction(t,e,n=
){e=3Dthis._findConvertTarget(e);return e.cartesian?e.cartesian.dataToPoint=
(n):e.axis?e.axis.toGlobalCoord(e.axis.dataToCoord(n)):null},eb.prototype.c=
onvertFromPixel=3Dfunction(t,e,n){e=3Dthis._findConvertTarget(e);return e.c=
artesian?e.cartesian.pointToData(n):e.axis?e.axis.coordToData(e.axis.toLoca=
lCoord(n)):null},eb.prototype._findConvertTarget=3Dfunction(t){var e,n,i=3D=
t.seriesModel,o=3Dt.xAxisModel||i&&i.getReferringComponents("xAxis",Br).mod=
els[0],r=3Dt.yAxisModel||i&&i.getReferringComponents("yAxis",Br).models[0],=
t=3Dt.gridModel,a=3Dthis._coordsList;return i?C(a,e=3Di.coordinateSystem)<0=
&&(e=3Dnull):o&&r?e=3Dthis.getCartesian(o.componentIndex,r.componentIndex):=
o?n=3Dthis.getAxis("x",o.componentIndex):r?n=3Dthis.getAxis("y",r.component=
Index):t&&t.coordinateSystem=3D=3D=3Dthis&&(e=3Dthis._coordsList[0]),{carte=
sian:e,axis:n}},eb.prototype.containPoint=3Dfunction(t){var e=3Dthis._coord=
sList[0];if(e)return e.containPoint(t)},eb.prototype._initCartesian=3Dfunct=
ion(r,t,e){var a=3Dthis,s=3Dthis,l=3D{left:!1,right:!1,top:!1,bottom:!1},u=
=3D{x:{},y:{}},h=3D{x:0,y:0};function n(o){return function(t,e){var n,i;nb(=
t,r)&&(n=3Dt.get("position"),"x"=3D=3D=3Do?"top"!=3D=3Dn&&"bottom"!=3D=3Dn&=
&(n=3Dl.bottom?"top":"bottom"):"left"!=3D=3Dn&&"right"!=3D=3Dn&&(n=3Dl.left=
?"right":"left"),l[n]=3D!0,i=3D"category"=3D=3D=3D(n=3Dnew qw(o,R_(t),[0,0]=
,t.get("type"),n)).type,n.onBand=3Di&&t.get("boundaryGap"),n.inverse=3Dt.ge=
t("inverse"),(t.axis=3Dn).model=3Dt,n.grid=3Ds,n.index=3De,s._axesList.push=
(n),u[o][e]=3Dn,h[o]++)}}t.eachComponent("xAxis",n("x"),this),t.eachCompone=
nt("yAxis",n("y"),this),h.x&&h.y?E((this._axesMap=3Du).x,function(i,o){E(u.=
y,function(t,e){var e=3D"x"+o+"y"+e,n=3Dnew Uw(e);n.master=3Da,n.model=3Dr,=
a._coordsMap[e]=3Dn,a._coordsList.push(n),n.addAxis(i),n.addAxis(t)})}):(th=
is._axesMap=3D{},this._axesList=3D[])},eb.prototype._updateScale=3Dfunction=
(t,i){function o(e,n){E(V_(e,n.dim),function(t){n.scale.unionExtentFromData=
(e,t)})}E(this._axesList,function(t){var e;t.scale.setExtent(1/0,-1/0),"cat=
egory"=3D=3D=3Dt.type&&(e=3Dt.model.get("categorySortInfo"),t.scale.setSort=
Info(e))}),t.eachSeries(function(t){var e,n;$w(t)&&(n=3D(e=3DQw(t)).xAxisMo=
del,e=3De.yAxisModel,nb(n,i))&&nb(e,i)&&(n=3Dthis.getCartesian(n.componentI=
ndex,e.componentIndex),e=3Dt.getData(),t=3Dn.getAxis("x"),n=3Dn.getAxis("y"=
),o(e,t),o(e,n))},this)},eb.prototype.getTooltipAxes=3Dfunction(n){var i=3D=
[],o=3D[];return E(this.getCartesians(),function(t){var e=3Dnull!=3Dn&&"aut=
o"!=3D=3Dn?t.getAxis(n):t.getBaseAxis(),t=3Dt.getOtherAxis(e);C(i,e)<0&&i.p=
ush(e),C(o,t)<0&&o.push(t)}),{baseAxes:i,otherAxes:o}},eb.create=3Dfunction=
(i,o){var r=3D[];return i.eachComponent("grid",function(t,e){var n=3Dnew eb=
(t,i,o);n.name=3D"grid_"+e,n.resize(t,o,!0),t.coordinateSystem=3Dn,r.push(n=
)}),i.eachSeries(function(t){var e,n,i;$w(t)&&(e=3D(n=3DQw(t)).xAxisModel,n=
=3Dn.yAxisModel,i=3De.getCoordSysModel().coordinateSystem,t.coordinateSyste=
m=3Di.getCartesian(e.componentIndex,n.componentIndex))}),r},eb.dimensions=
=3DWw;var tb=3Deb;function eb(t,e,n){this.type=3D"grid",this._coordsMap=3D{=
},this._coordsList=3D[],this._axesMap=3D{},this._axesList=3D[],this.axisPoi=
nterEnabled=3D!0,this.dimensions=3DWw,this._initCartesian(t,e,n),this.model=
=3Dt}function nb(t,e){return t.getCoordSysModel()=3D=3D=3De}function ib(t,e=
,n,i){n.getAxesOnZeroOf=3Dfunction(){return o?[o]:[]};var o,r=3Dt[e],t=3Dn.=
model,e=3Dt.get(["axisLine","onZero"]),n=3Dt.get(["axisLine","onZeroAxisInd=
ex"]);if(e){if(null!=3Dn)ob(r[n])&&(o=3Dr[n]);else for(var a in r)if(r.hasO=
wnProperty(a)&&ob(r[a])&&!i[s(r[a])]){o=3Dr[a];break}o&&(i[s(o)]=3D!0)}func=
tion s(t){return t.dim+"_"+t.index}}function ob(t){return t&&"category"!=3D=
=3Dt.type&&"time"!=3D=3Dt.type&&(e=3D(t=3D(t=3Dt).scale.getExtent())[0],t=
=3Dt[1],!(0<e&&0<t||e<0&&t<0));var e}var rb=3DMath.PI,ab=3D(lb.prototype.ha=
sBuilder=3Dfunction(t){return!!sb[t]},lb.prototype.add=3Dfunction(t){sb[t](=
this.opt,this.axisModel,this.group,this._transformGroup)},lb.prototype.getG=
roup=3Dfunction(){return this.group},lb.innerTextLayout=3Dfunction(t,e,n){v=
ar i,e=3Dlr(e-t),t=3Dur(e)?(i=3D0<n?"top":"bottom","center"):ur(e-rb)?(i=3D=
0<n?"bottom":"top","center"):(i=3D"middle",0<e&&e<rb?0<n?"right":"left":0<n=
?"left":"right");return{rotation:e,textAlign:t,textVerticalAlign:i}},lb.mak=
eAxisEventDataBase=3Dfunction(t){var e=3D{componentType:t.mainType,componen=
tIndex:t.componentIndex};return e[t.mainType+"Index"]=3Dt.componentIndex,e}=
,lb.isLabelSilent=3Dfunction(t){var e=3Dt.get("tooltip");return t.get("sile=
nt")||!(t.get("triggerEvent")||e&&e.show)},lb),sb=3D{axisLine:function(i,t,=
o,e){var r,a,s,l,u,h,c,n=3Dt.get(["axisLine","show"]);(n=3D"auto"=3D=3D=3Dn=
&&i.handleAutoShown?i.handleAutoShown("axisLine"):n)&&(n=3Dt.axis.getExtent=
(),e=3De.transform,r=3D[n[0],0],a=3D[n[1],0],s=3Da[0]<r[0],e&&(Jt(r,r,e),Jt=
(a,a,e)),l=3DP({lineCap:"round"},t.getModel(["axisLine","lineStyle"]).getLi=
neStyle()),ec((n=3Dnew nh({shape:{x1:r[0],y1:r[1],x2:a[0],y2:a[1]},style:l,=
strokeContainThreshold:i.strokeContainThreshold||5,silent:!0,z2:1})).shape,=
n.style.lineWidth),n.anid=3D"line",o.add(n),null!=3D(u=3Dt.get(["axisLine",=
"symbol"])))&&(e=3Dt.get(["axisLine","symbolSize"]),H(u)&&(u=3D[u,u]),(H(e)=
||W(e))&&(e=3D[e,e]),n=3Dlm(t.get(["axisLine","symbolOffset"])||0,e),h=3De[=
0],c=3De[1],E([{rotate:i.rotation+Math.PI/2,offset:n[0],r:0},{rotate:i.rota=
tion-Math.PI/2,offset:n[1],r:Math.sqrt((r[0]-a[0])*(r[0]-a[0])+(r[1]-a[1])*=
(r[1]-a[1]))}],function(t,e){var n;"none"!=3D=3Du[e]&&null!=3Du[e]&&(e=3Dam=
(u[e],-h/2,-c/2,h,c,l.stroke,!0),n=3Dt.r+t.offset,e.attr({rotation:t.rotate=
,x:(t=3Ds?a:r)[0]+n*Math.cos(i.rotation),y:t[1]-n*Math.sin(i.rotation),sile=
nt:!0,z2:11}),o.add(e))}))},axisTickLabel:function(t,e,n,i){var o,r,a,s=3Df=
unction(t,e,n,i){var o=3Dn.axis,r=3Dn.getModel("axisTick"),a=3Dr.get("show"=
);if((a=3D"auto"=3D=3D=3Da&&i.handleAutoShown?i.handleAutoShown("axisTick")=
:a)&&!o.scale.isBlank()){for(var a=3Dr.getModel("lineStyle"),i=3Di.tickDire=
ction*r.get("length"),s=3Dpb(o.getTicksCoords(),e.transform,i,B(a.getLineSt=
yle(),{stroke:n.get(["axisLine","lineStyle","color"])}),"ticks"),l=3D0;l<s.=
length;l++)t.add(s[l]);return s}}(n,i,e,t),l=3Dfunction(f,g,y,m){var v=3Dy.=
axis;{var _,x,w,t,b,S,M,T,I;if(_t(m.axisLabelShow,y.get(["axisLabel","show"=
]))&&!v.scale.isBlank())return _=3Dy.getModel("axisLabel"),x=3D_.get("margi=
n"),w=3Dv.getViewLabels(),t=3D(_t(m.labelRotate,_.get("rotate"))||0)*rb/180=
,b=3Dab.innerTextLayout(m.rotation,t,m.labelDirection),S=3Dy.getCategories&=
&y.getCategories(!0),M=3D[],T=3Dab.isLabelSilent(y),I=3Dy.get("triggerEvent=
"),E(w,function(t,e){var n=3D"ordinal"=3D=3D=3Dv.scale.type?v.scale.getRawO=
rdinalNumber(t.tickValue):t.tickValue,i=3Dt.formattedLabel,o=3Dt.rawLabel,r=
=3D_,a=3D(r=3DS&&S[n]&&O(a=3DS[n])&&a.textStyle?new Hc(a.textStyle,_,y.ecMo=
del):r).getTextColor()||y.get(["axisLine","lineStyle","color"]),s=3Dv.dataT=
oCoord(n),l=3Dr.getShallow("align",!0)||b.textAlign,u=3DR(r.getShallow("ali=
gnMinLabel",!0),l),h=3DR(r.getShallow("alignMaxLabel",!0),l),c=3Dr.getShall=
ow("verticalAlign",!0)||r.getShallow("baseline",!0)||b.textVerticalAlign,p=
=3DR(r.getShallow("verticalAlignMinLabel",!0),c),d=3DR(r.getShallow("vertic=
alAlignMaxLabel",!0),c),s=3Dnew Hs({x:s,y:m.labelOffset+m.labelDirection*x,=
rotation:b.rotation,silent:T,z2:10+(t.level||0),style:wc(r,{text:i,align:0=
=3D=3D=3De?u:e=3D=3D=3Dw.length-1?h:l,verticalAlign:0=3D=3D=3De?p:e=3D=3D=
=3Dw.length-1?d:c,fill:D(a)?a("category"=3D=3D=3Dv.type?o:"value"=3D=3D=3Dv=
.type?n+"":n,e):a})});s.anid=3D"label_"+n,I&&((t=3Dab.makeAxisEventDataBase=
(y)).targetType=3D"axisLabel",t.value=3Do,t.tickIndex=3De,"category"=3D=3D=
=3Dv.type&&(t.dataIndex=3Dn),k(s).eventData=3Dt),g.add(s),s.updateTransform=
(),M.push(s),f.add(s),s.decomposeTransform()}),M}}(n,i,e,t),u=3De,h=3Dl,c=
=3D(F_(u.axis)||(d=3Du.get(["axisLabel","showMinLabel"]),u=3Du.get(["axisLa=
bel","showMaxLabel"]),s=3Ds||[],y=3D(h=3Dh||[])[0],f=3Dh[1],o=3Dh[h.length-=
1],h=3Dh[h.length-2],r=3Ds[0],g=3Ds[1],a=3Ds[s.length-1],s=3Ds[s.length-2],=
!1=3D=3D=3Dd?(ub(y),ub(r)):hb(y,f)&&(d?(ub(f),ub(g)):(ub(y),ub(r))),!1=3D=
=3D=3Du?(ub(o),ub(a)):hb(h,o)&&(u?(ub(h),ub(s)):(ub(o),ub(a)))),n),p=3Di,d=
=3De,f=3Dt.tickDirection,g=3Dd.axis,y=3Dd.getModel("minorTick");if(y.get("s=
how")&&!g.scale.isBlank()){var m=3Dg.getMinorTicksCoords();if(m.length)for(=
var g=3Dy.getModel("lineStyle"),v=3Df*y.get("length"),_=3DB(g.getLineStyle(=
),B(d.getModel("axisTick").getLineStyle(),{stroke:d.get(["axisLine","lineSt=
yle","color"])})),x=3D0;x<m.length;x++)for(var w=3Dpb(m[x],p.transform,v,_,=
"minorticks_"+x),b=3D0;b<w.length;b++)c.add(w[b])}e.get(["axisLabel","hideO=
verlap"])&&X1(H1(F(l,function(t){return{label:t,priority:t.z2,defaultAttr:{=
ignore:t.ignore}}})))},axisName:function(t,e,n,i){var o,r,a,s,l,u,h,c,p=3D_=
t(t.axisName,e.get("name"));p&&(l=3De.get("nameLocation"),s=3Dt.nameDirecti=
on,r=3De.getModel("nameTextStyle"),u=3De.get("nameGap")||0,a=3D(h=3De.axis.=
getExtent())[0]>h[1]?-1:1,a=3D["start"=3D=3D=3Dl?h[0]-a*u:"end"=3D=3D=3Dl?h=
[1]+a*u:(h[0]+h[1])/2,cb(l)?t.labelOffset+s*u:0],null!=3D(u=3De.get("nameRo=
tate"))&&(u=3Du*rb/180),cb(l)?o=3Dab.innerTextLayout(t.rotation,null!=3Du?u=
:t.rotation,s):(s=3Dt.rotation,l=3Dl,h=3Dh,u=3Dlr((u=3Du||0)-s),s=3Dh[0]>h[=
1],h=3D"start"=3D=3D=3Dl&&!s||"start"!=3D=3Dl&&s,l=3Dur(u-rb/2)?(c=3Dh?"bot=
tom":"top","center"):ur(u-1.5*rb)?(c=3Dh?"top":"bottom","center"):(c=3D"mid=
dle",u<1.5*rb&&rb/2<u?h?"left":"right":h?"right":"left"),o=3D{rotation:u,te=
xtAlign:l,textVerticalAlign:c},null=3D=3D(c=3Dt.axisNameAvailableWidth)||(c=
=3DMath.abs(c/Math.sin(o.rotation)),isFinite(c))||(c=3Dnull)),s=3Dr.getFont=
(),u=3D(h=3De.get("nameTruncate",!0)||{}).ellipsis,l=3D_t(t.nameTruncateMax=
Width,h.maxWidth,c),pc({el:t=3Dnew Hs({x:a[0],y:a[1],rotation:o.rotation,si=
lent:ab.isLabelSilent(e),style:wc(r,{text:p,font:s,overflow:"truncate",widt=
h:l,ellipsis:u,fill:r.getTextColor()||e.get(["axisLine","lineStyle","color"=
]),align:r.get("align")||o.textAlign,verticalAlign:r.get("verticalAlign")||=
o.textVerticalAlign}),z2:1}),componentModel:e,itemName:p}),t.__fullText=3Dp=
,t.anid=3D"name",e.get("triggerEvent")&&((h=3Dab.makeAxisEventDataBase(e)).=
targetType=3D"axisName",h.name=3Dp,k(t).eventData=3Dh),i.add(t),t.updateTra=
nsform(),n.add(t),t.decomposeTransform())}};function lb(t,e){this.group=3Dn=
ew Wo,this.opt=3De,this.axisModel=3Dt,B(e,{labelOffset:0,nameDirection:1,ti=
ckDirection:1,labelDirection:1,silent:!0,handleAutoShown:function(){return!=
0}});t=3Dnew Wo({x:e.position[0],y:e.position[1],rotation:e.rotation});t.up=
dateTransform(),this._transformGroup=3Dt}function ub(t){t&&(t.ignore=3D!0)}=
function hb(t,e){var n,i=3Dt&&t.getBoundingRect().clone(),o=3De&&e.getBound=
ingRect().clone();if(i&&o)return Ee(n=3DPe([]),n,-t.rotation),i.applyTransf=
orm(Re([],n,t.getLocalTransform())),o.applyTransform(Re([],n,e.getLocalTran=
sform())),i.intersect(o)}function cb(t){return"middle"=3D=3D=3Dt||"center"=
=3D=3D=3Dt}function pb(t,e,n,i,o){for(var r=3D[],a=3D[],s=3D[],l=3D0;l<t.le=
ngth;l++){var u=3Dt[l].coord,u=3D(a[0]=3Du,s[a[1]=3D0]=3Du,s[1]=3Dn,e&&(Jt(=
a,a,e),Jt(s,s,e)),new nh({shape:{x1:a[0],y1:a[1],x2:s[0],y2:s[1]},style:i,z=
2:2,autoBatch:!0,silent:!0}));ec(u.shape,u.style.lineWidth),u.anid=3Do+"_"+=
t[l].tickValue,r.push(u)}return r}function db(t,e){var o,h,c,r,p,d,f,n=3D{a=
xesInfo:{},seriesInvolved:!1,coordSysAxesInfo:{},coordSysMap:{}};return h=
=3Dn,e=3De,r=3D(c=3Dt).getComponent("tooltip"),p=3Dc.getComponent("axisPoin=
ter"),d=3Dp.get("link",!0)||[],f=3D[],E(e.getCoordinateSystems(),function(s=
){var l,u,t,e,n;function i(t,e,n){var i,o,r=3Dn.model.getModel("axisPointer=
",p),a=3Dr.get("show");a&&("auto"!=3D=3Da||t||yb(r))&&(null=3D=3De&&(e=3Dr.=
get("triggerTooltip")),a=3D(r=3Dt?function(t,e,n,i,o,r){var a=3De.getModel(=
"axisPointer"),s=3D{},e=3D(E(["type","snap","lineStyle","shadowStyle","labe=
l","animation","animationDurationUpdate","animationEasingUpdate","z"],funct=
ion(t){s[t]=3Dy(a.get(t))}),s.snap=3D"category"!=3D=3Dt.type&&!!r,"cross"=
=3D=3D=3Da.get("type")&&(s.type=3D"line"),s.label||(s.label=3D{}));null=3D=
=3De.show&&(e.show=3D!1),"cross"=3D=3D=3Do&&(o=3Da.get(["label","show"]),e.=
show=3Dnull=3D=3Do||o,r||(o=3Ds.lineStyle=3Da.get("crossStyle"))&&B(e,o.tex=
tStyle));return t.model.getModel("axisPointer",new Hc(s,n,i))}(n,u,p,c,t,e)=
:r).get("snap"),t=3Dr.get("triggerEmphasis"),i=3Dmb(n.model),o=3De||a||"cat=
egory"=3D=3D=3Dn.type,e=3Dh.axesInfo[i]=3D{key:i,axis:n,coordSys:s,axisPoin=
terModel:r,triggerTooltip:e,triggerEmphasis:t,involveSeries:o,snap:a,useHan=
dle:yb(r),seriesModels:[],linkGroup:null},l[i]=3De,h.seriesInvolved=3Dh.ser=
iesInvolved||o,null!=3D(t=3Dfunction(t,e){for(var n=3De.model,i=3De.dim,o=
=3D0;o<t.length;o++){var r=3Dt[o]||{};if(fb(r[i+"AxisId"],n.id)||fb(r[i+"Ax=
isIndex"],n.componentIndex)||fb(r[i+"AxisName"],n.name))return o}}(d,n)))&&=
((a=3Df[t]||(f[t]=3D{axesInfo:{}})).axesInfo[i]=3De,a.mapper=3Dd[t].mapper,=
e.linkGroup=3Da)}s.axisPointerEnabled&&(t=3Dmb(s.model),l=3Dh.coordSysAxesI=
nfo[t]=3D{},u=3D(h.coordSysMap[t]=3Ds).model.getModel("tooltip",r),E(s.getA=
xes(),M(i,!1,null)),s.getTooltipAxes)&&r&&u.get("show")&&(t=3D"axis"=3D=3D=
=3Du.get("trigger"),e=3D"cross"=3D=3D=3Du.get(["axisPointer","type"]),n=3Ds=
.getTooltipAxes(u.get(["axisPointer","axis"])),(t||e)&&E(n.baseAxes,M(i,!e|=
|"cross",t)),e)&&E(n.otherAxes,M(i,"cross",!1))}),n.seriesInvolved&&(o=3Dn,=
t.eachSeries(function(n){var i=3Dn.coordinateSystem,t=3Dn.get(["tooltip","t=
rigger"],!0),e=3Dn.get(["tooltip","show"],!0);i&&"none"!=3D=3Dt&&!1!=3D=3Dt=
&&"item"!=3D=3Dt&&!1!=3D=3De&&!1!=3D=3Dn.get(["axisPointer","show"],!0)&&E(=
o.coordSysAxesInfo[mb(i.model)],function(t){var e=3Dt.axis;i.getAxis(e.dim)=
=3D=3D=3De&&(t.seriesModels.push(n),null=3D=3Dt.seriesDataCount&&(t.seriesD=
ataCount=3D0),t.seriesDataCount+=3Dn.getData().count())})})),n}function fb(=
t,e){return"all"=3D=3D=3Dt||V(t)&&0<=3DC(t,e)||t=3D=3D=3De}function gb(t){v=
ar e=3D(t.ecModel.getComponent("axisPointer")||{}).coordSysAxesInfo;return =
e&&e.axesInfo[mb(t)]}function yb(t){return!!t.get(["handle","show"])}functi=
on mb(t){return t.type+"||"+t.id}var vb,_b=3D{},xb=3D(u(wb,vb=3D$g),wb.prot=
otype.render=3Dfunction(t,e,n,i){var o,r,a,s,l,u;this.axisPointerClass&&(o=
=3Dgb(o=3Dt))&&(l=3Do.axisPointerModel,r=3Do.axis.scale,a=3Dl.option,u=3Dl.=
get("status"),null!=3D(s=3Dl.get("value"))&&(s=3Dr.parse(s)),l=3Dyb(l),null=
=3D=3Du&&(a.status=3Dl?"show":"hide"),(u=3Dr.getExtent().slice())[0]>u[1]&&=
u.reverse(),(s=3Dnull=3D=3Ds||s>u[1]?u[1]:s)<u[0]&&(s=3Du[0]),a.value=3Ds,l=
)&&(a.status=3Do.axis.scale.isBlank()?"hide":"show"),vb.prototype.render.ap=
ply(this,arguments),this._doUpdateAxisPointerClass(t,n,!0)},wb.prototype.up=
dateAxisPointer=3Dfunction(t,e,n,i){this._doUpdateAxisPointerClass(t,n,!1)}=
,wb.prototype.remove=3Dfunction(t,e){var n=3Dthis._axisPointer;n&&n.remove(=
e)},wb.prototype.dispose=3Dfunction(t,e){this._disposeAxisPointer(e),vb.pro=
totype.dispose.apply(this,arguments)},wb.prototype._doUpdateAxisPointerClas=
s=3Dfunction(t,e,n){var i,o=3Dwb.getAxisPointerClass(this.axisPointerClass)=
;o&&((i=3D(i=3Dgb(i=3Dt))&&i.axisPointerModel)?(this._axisPointer||(this._a=
xisPointer=3Dnew o)).render(t,i,e,n):this._disposeAxisPointer(e))},wb.proto=
type._disposeAxisPointer=3Dfunction(t){this._axisPointer&&this._axisPointer=
.dispose(t),this._axisPointer=3Dnull},wb.registerAxisPointerClass=3Dfunctio=
n(t,e){_b[t]=3De},wb.getAxisPointerClass=3Dfunction(t){return t&&_b[t]},wb.=
type=3D"axis",wb);function wb(){var t=3Dnull!=3D=3Dvb&&vb.apply(this,argume=
nts)||this;return t.type=3Dwb.type,t}var bb=3DRr();var Sb,Mb,Tb=3D["axisLin=
e","axisTickLabel","axisName"],Ib=3D["splitArea","splitLine","minorSplitLin=
e"],em=3D(u(Ab,Mb=3Dxb),Ab.prototype.render=3Dfunction(i,t,e,n){this.group.=
removeAll();var o,r,a=3Dthis._axisGroup;this._axisGroup=3Dnew Wo,this.group=
.add(this._axisGroup),i.get("show")&&(r=3DKw(o=3Di.getCoordSysModel(),i),r=
=3Dnew ab(i,P({handleAutoShown:function(t){for(var e=3Do.coordinateSystem.g=
etCartesians(),n=3D0;n<e.length;n++)if(Wv(e[n].getOtherAxis(i.axis).scale))=
return!0;return!1}},r)),E(Tb,r.add,r),this._axisGroup.add(r.getGroup()),E(I=
b,function(t){i.get([t,"show"])&&Cb[t](this,this._axisGroup,i,o)},this),n&&=
"changeAxisOrder"=3D=3D=3Dn.type&&n.isInitSort||sc(a,this._axisGroup,i),Mb.=
prototype.render.call(this,i,t,e,n))},Ab.prototype.remove=3Dfunction(){bb(t=
his).splitAreaColors=3Dnull},Ab.type=3D"cartesianAxis",Ab),Cb=3D{splitLine:=
function(t,e,n,i){var o=3Dn.axis;if(!o.scale.isBlank())for(var n=3Dn.getMod=
el("splitLine"),r=3Dn.getModel("lineStyle"),a=3DV(a=3Dr.get("color"))?a:[a]=
,s=3Di.coordinateSystem.getRect(),l=3Do.isHorizontal(),u=3D0,h=3Do.getTicks=
Coords({tickModel:n}),c=3D[],p=3D[],d=3Dr.getLineStyle(),f=3D0;f<h.length;f=
++){var g=3Do.toGlobalCoord(h[f].coord),g=3D(l?(c[0]=3Dg,c[1]=3Ds.y,p[0]=3D=
g,p[1]=3Ds.y+s.height):(c[0]=3Ds.x,c[1]=3Dg,p[0]=3Ds.x+s.width,p[1]=3Dg),u+=
+%a.length),y=3Dh[f].tickValue,y=3Dnew nh({anid:null!=3Dy?"line_"+h[f].tick=
Value:null,autoBatch:!0,shape:{x1:c[0],y1:c[1],x2:p[0],y2:p[1]},style:B({st=
roke:a[g]},d),silent:!0});ec(y.shape,d.lineWidth),e.add(y)}},minorSplitLine=
:function(t,e,n,i){var o=3Dn.axis,n=3Dn.getModel("minorSplitLine").getModel=
("lineStyle"),r=3Di.coordinateSystem.getRect(),a=3Do.isHorizontal(),s=3Do.g=
etMinorTicksCoords();if(s.length)for(var l=3D[],u=3D[],h=3Dn.getLineStyle()=
,c=3D0;c<s.length;c++)for(var p=3D0;p<s[c].length;p++){var d=3Do.toGlobalCo=
ord(s[c][p].coord),d=3D(a?(l[0]=3Dd,l[1]=3Dr.y,u[0]=3Dd,u[1]=3Dr.y+r.height=
):(l[0]=3Dr.x,l[1]=3Dd,u[0]=3Dr.x+r.width,u[1]=3Dd),new nh({anid:"minor_lin=
e_"+s[c][p].tickValue,autoBatch:!0,shape:{x1:l[0],y1:l[1],x2:u[0],y2:u[1]},=
style:h,silent:!0}));ec(d.shape,h.lineWidth),e.add(d)}},splitArea:function(=
t,e,n,i){var o=3De,e=3Di,r=3D(i=3Dn).axis;if(!r.scale.isBlank()){var i=3Di.=
getModel("splitArea"),n=3Di.getModel("areaStyle"),a=3Dn.get("color"),s=3De.=
coordinateSystem.getRect(),l=3Dr.getTicksCoords({tickModel:i,clamp:!0});if(=
l.length){var u=3Da.length,h=3Dbb(t).splitAreaColors,c=3DN(),p=3D0;if(h)for=
(var d=3D0;d<l.length;d++){var f=3Dh.get(l[d].tickValue);if(null!=3Df){p=3D=
(f+(u-1)*d)%u;break}}for(var g=3Dr.toGlobalCoord(l[0].coord),y=3Dn.getAreaS=
tyle(),a=3DV(a)?a:[a],d=3D1;d<l.length;d++){var m=3Dr.toGlobalCoord(l[d].co=
ord),v=3Dvoid 0,_=3Dvoid 0,x=3Dvoid 0,w=3Dvoid 0,g=3Dr.isHorizontal()?(v=3D=
g,_=3Ds.y,w=3Ds.height,v+(x=3Dm-v)):(v=3Ds.x,_=3Dg,x=3Ds.width,_+(w=3Dm-_))=
,m=3Dl[d-1].tickValue;null!=3Dm&&c.set(m,p),o.add(new Es({anid:null!=3Dm?"a=
rea_"+m:null,shape:{x:v,y:_,width:x,height:w},style:B({fill:a[p]},y),autoBa=
tch:!0,silent:!0})),p=3D(p+1)%u}bb(t).splitAreaColors=3Dc}}}},Db=3D(u(kb,Sb=
=3Dem),kb.type=3D"xAxis",kb);function kb(){var t=3Dnull!=3D=3DSb&&Sb.apply(=
this,arguments)||this;return t.type=3Dkb.type,t}function Ab(){var t=3Dnull!=
=3D=3DMb&&Mb.apply(this,arguments)||this;return t.type=3DAb.type,t.axisPoin=
terClass=3D"CartesianAxisPointer",t}u(Ob,Lb=3Dem),Ob.type=3D"yAxis";var Lb,=
Pb=3DOb;function Ob(){var t=3Dnull!=3D=3DLb&&Lb.apply(this,arguments)||this=
;return t.type=3DDb.type,t}u(zb,Rb=3D$g),zb.prototype.render=3Dfunction(t,e=
){this.group.removeAll(),t.get("show")&&this.group.add(new Es({shape:t.coor=
dinateSystem.getRect(),style:B({fill:t.get("backgroundColor")},t.getItemSty=
le()),silent:!0,z2:-1}))},zb.type=3D"grid";var Rb,Nb=3Dzb,Eb=3D{offset:0};f=
unction zb(){var t=3Dnull!=3D=3DRb&&Rb.apply(this,arguments)||this;return t=
.type=3D"grid",t}U_(function(t){t.registerComponentView(Nb),t.registerCompo=
nentModel(Pw),t.registerCoordinateSystem("cartesian2d",tb),Fw(t,"x",Nw,Eb),=
Fw(t,"y",Nw,Eb),t.registerComponentView(Db),t.registerComponentView(Pb),t.r=
egisterPreprocessor(function(t){t.xAxis&&t.yAxis&&!t.grid&&(t.grid=3D{})})}=
);u(Vb,Bb=3Dg),Vb.prototype.init=3Dfunction(t,e,n){this.mergeDefaultAndThem=
e(t,n),t.selected=3Dt.selected||{},this._updateSelector(t)},Vb.prototype.me=
rgeOption=3Dfunction(t,e){Bb.prototype.mergeOption.call(this,t,e),this._upd=
ateSelector(t)},Vb.prototype._updateSelector=3Dfunction(t){var n=3Dt.select=
or,i=3Dthis.ecModel;V(n=3D!0=3D=3D=3Dn?t.selector=3D["all","inverse"]:n)&&E=
(n,function(t,e){H(t)&&(t=3D{type:t}),n[e]=3Dd(t,(e=3Di,"all"=3D=3D=3D(t=3D=
t.type)?{type:"all",title:e.getLocaleModel().get(["legend","selector","all"=
])}:"inverse"=3D=3D=3Dt?{type:"inverse",title:e.getLocaleModel().get(["lege=
nd","selector","inverse"])}:void 0))})},Vb.prototype.optionUpdated=3Dfuncti=
on(){this._updateData(this.ecModel);var t=3Dthis._data;if(t[0]&&"single"=3D=
=3D=3Dthis.get("selectedMode")){for(var e=3D!1,n=3D0;n<t.length;n++){var i=
=3Dt[n].get("name");if(this.isSelected(i)){this.select(i),e=3D!0;break}}e||=
this.select(t[0].get("name"))}},Vb.prototype._updateData=3Dfunction(i){var =
o=3D[],r=3D[],t=3D(i.eachRawSeries(function(t){var e,n=3Dt.name;r.push(n),t=
.legendVisualProvider&&(n=3Dt.legendVisualProvider.getAllNames(),i.isSeries=
Filtered(t)||(r=3Dr.concat(n)),n.length)?o=3Do.concat(n):e=3D!0,e&&Ar(t)&&o=
.push(t.name)}),this._availableNames=3Dr,this.get("data")||o),e=3DN(),t=3DF=
(t,function(t){return(H(t)||W(t))&&(t=3D{name:t}),e.get(t.name)?null:(e.set=
(t.name,!0),new Hc(t,this,this.ecModel))},this);this._data=3Dut(t,function(=
t){return!!t})},Vb.prototype.getData=3Dfunction(){return this._data},Vb.pro=
totype.select=3Dfunction(t){var e=3Dthis.option.selected;"single"=3D=3D=3Dt=
his.get("selectedMode")&&E(this._data,function(t){e[t.get("name")]=3D!1}),e=
[t]=3D!0},Vb.prototype.unSelect=3Dfunction(t){"single"!=3D=3Dthis.get("sele=
ctedMode")&&(this.option.selected[t]=3D!1)},Vb.prototype.toggleSelected=3Df=
unction(t){var e=3Dthis.option.selected;e.hasOwnProperty(t)||(e[t]=3D!0),th=
is[e[t]?"unSelect":"select"](t)},Vb.prototype.allSelect=3Dfunction(){var t=
=3Dthis._data,e=3Dthis.option.selected;E(t,function(t){e[t.get("name",!0)]=
=3D!0})},Vb.prototype.inverseSelect=3Dfunction(){var t=3Dthis._data,e=3Dthi=
s.option.selected;E(t,function(t){t=3Dt.get("name",!0);e.hasOwnProperty(t)|=
|(e[t]=3D!0),e[t]=3D!e[t]})},Vb.prototype.isSelected=3Dfunction(t){var e=3D=
this.option.selected;return!(e.hasOwnProperty(t)&&!e[t])&&0<=3DC(this._avai=
lableNames,t)},Vb.prototype.getOrient=3Dfunction(){return"vertical"=3D=3D=
=3Dthis.get("orient")?{index:1,name:"vertical"}:{index:0,name:"horizontal"}=
},Vb.type=3D"legend.plain",Vb.dependencies=3D["series"],Vb.defaultOption=3D=
{z:4,show:!0,orient:"horizontal",left:"center",top:0,align:"auto",backgroun=
dColor:"rgba(0,0,0,0)",borderColor:"#ccc",borderRadius:0,borderWidth:0,padd=
ing:5,itemGap:10,itemWidth:25,itemHeight:14,symbolRotate:"inherit",symbolKe=
epAspect:!0,inactiveColor:"#ccc",inactiveBorderColor:"#ccc",inactiveBorderW=
idth:"auto",itemStyle:{color:"inherit",opacity:"inherit",borderColor:"inher=
it",borderWidth:"auto",borderCap:"inherit",borderJoin:"inherit",borderDashO=
ffset:"inherit",borderMiterLimit:"inherit"},lineStyle:{width:"auto",color:"=
inherit",inactiveColor:"#ccc",inactiveWidth:2,opacity:"inherit",type:"inher=
it",cap:"inherit",join:"inherit",dashOffset:"inherit",miterLimit:"inherit"}=
,textStyle:{color:"#333"},selectedMode:!0,selector:!1,selectorLabel:{show:!=
0,borderRadius:10,padding:[3,5,3,5],fontSize:12,fontFamily:"sans-serif",col=
or:"#666",borderWidth:1,borderColor:"#666"},emphasis:{selectorLabel:{show:!=
0,color:"#eee",backgroundColor:"#666"}},selectorPosition:"auto",selectorIte=
mGap:7,selectorButtonGap:10,tooltip:{show:!1}};var Bb,Fb=3DVb;function Vb()=
{var t=3Dnull!=3D=3DBb&&Bb.apply(this,arguments)||this;return t.type=3DVb.t=
ype,t.layoutMode=3D{type:"box",ignoreSize:!0},t}var Hb,Wb=3DM,Gb=3DE,Xb=3DW=
o,Ub=3D(u(Yb,Hb=3D$g),Yb.prototype.init=3Dfunction(){this.group.add(this._c=
ontentGroup=3Dnew Xb),this.group.add(this._selectorGroup=3Dnew Xb),this._is=
FirstRender=3D!0},Yb.prototype.getContentGroup=3Dfunction(){return this._co=
ntentGroup},Yb.prototype.getSelectorGroup=3Dfunction(){return this._selecto=
rGroup},Yb.prototype.render=3Dfunction(t,e,n){var i,o,r,a,s,l=3Dthis._isFir=
stRender;this._isFirstRender=3D!1,this.resetInner(),t.get("show",!0)&&(o=3D=
t.get("align"),i=3Dt.get("orient"),o&&"auto"!=3D=3Do||(o=3D"right"=3D=3D=3D=
t.get("left")&&"vertical"=3D=3D=3Di?"right":"left"),a=3Dt.get("selector",!0=
),s=3Dt.get("selectorPosition",!0),this.renderInner(o,t,e,n,a,i,s=3D!a||s&&=
"auto"!=3D=3Ds?s:"horizontal"=3D=3D=3Di?"end":"start"),r=3DVp(e=3Dt.getBoxL=
ayoutParams(),i=3D{width:n.getWidth(),height:n.getHeight()},n=3Dt.get("padd=
ing")),r=3DVp(B({width:(o=3Dthis.layoutInner(t,o,r,l,a,s)).width,height:o.h=
eight},e),i,n),this.group.x=3Dr.x-o.x,this.group.y=3Dr.y-o.y,this.group.mar=
kRedraw(),this.group.add(this._backgroundEl=3D(l=3Do,s=3DDp((a=3Dt).get("pa=
dding")),(e=3Da.getItemStyle(["color","opacity"])).fill=3Da.get("background=
Color"),new Es({shape:{x:l.x-s[3],y:l.y-s[0],width:l.width+s[1]+s[3],height=
:l.height+s[0]+s[2],r:a.get("borderRadius")},style:e,silent:!0,z2:-1}))))},=
Yb.prototype.resetInner=3Dfunction(){this.getContentGroup().removeAll(),thi=
s._backgroundEl&&this.group.remove(this._backgroundEl),this.getSelectorGrou=
p().removeAll()},Yb.prototype.renderInner=3Dfunction(s,l,u,h,t,e,n){var c=
=3Dthis.getContentGroup(),p=3DN(),d=3Dl.get("selectedMode"),f=3D[];u.eachRa=
wSeries(function(t){t.get("legendHoverLink")||f.push(t.id)}),Gb(l.getData()=
,function(o,r){var e,t,n,i,a=3Do.get("name");this.newlineDisabled||""!=3D=
=3Da&&"\n"!=3D=3Da?(e=3Du.getSeriesByName(a)[0],p.get(a)||(e?(i=3D(n=3De.ge=
tData()).getVisual("legendLineStyle")||{},t=3Dn.getVisual("legendIcon"),n=
=3Dn.getVisual("style"),(i=3Dthis._createItem(e,a,r,o,l,s,i,n,t,d,h)).on("c=
lick",Wb(Zb,a,null,h,f)).on("mouseover",Wb(jb,e.name,null,h,f)).on("mouseou=
t",Wb(Kb,e.name,null,h,f)),u.ssr&&i.eachChild(function(t){t=3Dk(t);t.series=
Index=3De.seriesIndex,t.dataIndex=3Dr,t.ssrType=3D"legend"}),p.set(a,!0)):u=
.eachRawSeries(function(e){var t,n,i;!p.get(a)&&e.legendVisualProvider&&(n=
=3De.legendVisualProvider).containName(a)&&(i=3Dn.indexOfName(a),t=3Dn.getI=
temVisual(i,"style"),n=3Dn.getItemVisual(i,"legendIcon"),(i=3Dfi(t.fill))&&=
0=3D=3D=3Di[3]&&(i[3]=3D.2,t=3DP(P({},t),{fill:xi(i,"rgba")})),(i=3Dthis._c=
reateItem(e,a,r,o,l,s,{},t,n,d,h)).on("click",Wb(Zb,null,a,h,f)).on("mouseo=
ver",Wb(jb,null,a,h,f)).on("mouseout",Wb(Kb,null,a,h,f)),u.ssr&&i.eachChild=
(function(t){t=3Dk(t);t.seriesIndex=3De.seriesIndex,t.dataIndex=3Dr,t.ssrTy=
pe=3D"legend"}),p.set(a,!0))},this))):((n=3Dnew Xb).newline=3D!0,c.add(n))}=
,this),t&&this._createSelector(t,l,h,e,n)},Yb.prototype._createSelector=3Df=
unction(t,i,o,e,n){var r=3Dthis.getSelectorGroup();Gb(t,function(t){var e=
=3Dt.type,n=3Dnew Hs({style:{x:0,y:0,align:"center",verticalAlign:"middle"}=
,onclick:function(){o.dispatchAction({type:"all"=3D=3D=3De?"legendAllSelect=
":"legendInverseSelect"})}});r.add(n),_c(n,{normal:i.getModel("selectorLabe=
l"),emphasis:i.getModel(["emphasis","selectorLabel"])},{defaultText:t.title=
}),Hl(n)})},Yb.prototype._createItem=3Dfunction(t,e,n,i,o,r,a,s,l,u,h){var =
c=3Dt.visualDrawType,p=3Do.get("itemWidth"),d=3Do.get("itemHeight"),f=3Do.i=
sSelected(e),g=3Di.get("symbolRotate"),y=3Di.get("symbolKeepAspect"),m=3Di.=
get("icon"),a=3Dfunction(t,e,n,i,o,r,a){function s(n,i){"auto"=3D=3D=3Dn.li=
neWidth&&(n.lineWidth=3D0<i.lineWidth?2:0),Gb(n,function(t,e){"inherit"=3D=
=3D=3Dn[e]&&(n[e]=3Di[e])})}var l=3De.getModel("itemStyle"),u=3Dl.getItemSt=
yle(),t=3D0=3D=3D=3Dt.lastIndexOf("empty",0)?"fill":"stroke",l=3Dl.getShall=
ow("decal"),l=3D(u.decal=3Dl&&"inherit"!=3D=3Dl?zm(l,a):i.decal,"inherit"=
=3D=3D=3Du.fill&&(u.fill=3Di[o]),"inherit"=3D=3D=3Du.stroke&&(u.stroke=3Di[=
t]),"inherit"=3D=3D=3Du.opacity&&(u.opacity=3D("fill"=3D=3D=3Do?i:n).opacit=
y),s(u,i),e.getModel("lineStyle")),a=3Dl.getLineStyle();s(a,n),"auto"=3D=3D=
=3Du.fill&&(u.fill=3Di.fill),"auto"=3D=3D=3Du.stroke&&(u.stroke=3Di.fill),"=
auto"=3D=3D=3Da.stroke&&(a.stroke=3Di.fill),r||(o=3De.get("inactiveBorderWi=
dth"),n=3Du[t],u.lineWidth=3D"auto"=3D=3D=3Do?0<i.lineWidth&&n?2:0:u.lineWi=
dth,u.fill=3De.get("inactiveColor"),u.stroke=3De.get("inactiveBorderColor")=
,a.stroke=3Dl.get("inactiveColor"),a.lineWidth=3Dl.get("inactiveWidth"));re=
turn{itemStyle:u,lineStyle:a}}(l=3Dm||l||"roundRect",i,a,s,c,f,h),s=3Dnew X=
b,c=3Di.getModel("textStyle"),m=3D(!D(t.getLegendIcon)||m&&"inherit"!=3D=3D=
m?(h=3D"inherit"=3D=3D=3Dm&&t.getData().getVisual("symbol")?"inherit"=3D=3D=
=3Dg?t.getData().getVisual("symbolRotate"):g:0,s.add((m=3D{itemWidth:p,item=
Height:d,icon:l,iconRotate:h,itemStyle:a.itemStyle,lineStyle:a.lineStyle,sy=
mbolKeepAspect:y},h=3Dm.icon||"roundRect",(v=3Dam(h,0,0,m.itemWidth,m.itemH=
eight,m.itemStyle.fill,m.symbolKeepAspect)).setStyle(m.itemStyle),v.rotatio=
n=3D(m.iconRotate||0)*Math.PI/180,v.setOrigin([m.itemWidth/2,m.itemHeight/2=
]),-1<h.indexOf("empty")&&(v.style.stroke=3Dv.style.fill,v.style.fill=3D"#f=
ff",v.style.lineWidth=3D2),v))):s.add(t.getLegendIcon({itemWidth:p,itemHeig=
ht:d,icon:l,iconRotate:g,itemStyle:a.itemStyle,lineStyle:a.lineStyle,symbol=
KeepAspect:y})),"left"=3D=3D=3Dr?p+5:-5),h=3Dr,v=3Do.get("formatter"),t=3De=
,l=3D(H(v)&&v?t=3Dv.replace("{name}",null!=3De?e:""):D(v)&&(t=3Dv(e)),f?c.g=
etTextColor():i.get("inactiveColor")),g=3D(s.add(new Hs({style:wc(c,{text:t=
,x:m,y:d/2,fill:l,align:h,verticalAlign:"middle"},{inheritColor:l})})),new =
Es({shape:s.getBoundingRect(),style:{fill:"transparent"}})),a=3Di.getModel(=
"tooltip");return a.get("show")&&pc({el:g,componentModel:o,itemName:e,itemT=
ooltipOption:a.option}),s.add(g),s.eachChild(function(t){t.silent=3D!0}),g.=
silent=3D!u,this.getContentGroup().add(s),Hl(s),s.__legendDataIndex=3Dn,s},=
Yb.prototype.layoutInner=3Dfunction(t,e,n,i,o,r){var a,s,l,u,h,c=3Dthis.get=
ContentGroup(),p=3Dthis.getSelectorGroup(),n=3D(Fp(t.get("orient"),c,t.get(=
"itemGap"),n.width,n.height),c.getBoundingRect()),d=3D[-n.x,-n.y];return p.=
markRedraw(),c.markRedraw(),o?(Fp("horizontal",p,t.get("selectorItemGap",!0=
)),a=3D[-(o=3Dp.getBoundingRect()).x,-o.y],s=3Dt.get("selectorButtonGap",!0=
),l=3D0=3D=3D=3D(t=3Dt.getOrient().index)?"width":"height",u=3D0=3D=3D=3Dt?=
"height":"width",h=3D0=3D=3D=3Dt?"y":"x","end"=3D=3D=3Dr?a[t]+=3Dn[l]+s:d[t=
]+=3Do[l]+s,a[1-t]+=3Dn[u]/2-o[u]/2,p.x=3Da[0],p.y=3Da[1],c.x=3Dd[0],c.y=3D=
d[1],(r=3D{x:0,y:0})[l]=3Dn[l]+s+o[l],r[u]=3DMath.max(n[u],o[u]),r[h]=3DMat=
h.min(0,o[h]+a[1-t]),r):(c.x=3Dd[0],c.y=3Dd[1],this.group.getBoundingRect()=
)},Yb.prototype.remove=3Dfunction(){this.getContentGroup().removeAll(),this=
._isFirstRender=3D!0},Yb.type=3D"legend.plain",Yb);function Yb(){var t=3Dnu=
ll!=3D=3DHb&&Hb.apply(this,arguments)||this;return t.type=3DYb.type,t.newli=
neDisabled=3D!1,t}function Zb(t,e,n,i){Kb(t,e,n,i),n.dispatchAction({type:"=
legendToggleSelect",name:null!=3Dt?t:e}),jb(t,e,n,i)}function qb(t){for(var=
 e,n=3Dt.getZr().storage.getDisplayList(),i=3D0,o=3Dn.length;i<o&&!(e=3Dn[i=
].states.emphasis);)i++;return e&&e.hoverLayer}function jb(t,e,n,i){qb(n)||=
n.dispatchAction({type:"highlight",seriesName:t,name:e,excludeSeriesId:i})}=
function Kb(t,e,n,i){qb(n)||n.dispatchAction({type:"downplay",seriesName:t,=
name:e,excludeSeriesId:i})}function $b(t){var n=3Dt.findComponents({mainTyp=
e:"legend"});n&&n.length&&t.filterSeries(function(t){for(var e=3D0;e<n.leng=
th;e++)if(!n[e].isSelected(t.name))return!1;return!0})}function Qb(t,e,n){v=
ar i,o=3D{},r=3D"toggleSelected"=3D=3D=3Dt;return n.eachComponent("legend",=
function(n){r&&null!=3Di?n[i?"select":"unSelect"](e.name):"allSelect"=3D=3D=
=3Dt||"inverseSelect"=3D=3D=3Dt?n[t]():(n[t](e.name),i=3Dn.isSelected(e.nam=
e)),E(n.getData(),function(t){var e,t=3Dt.get("name");"\n"!=3D=3Dt&&""!=3D=
=3Dt&&(e=3Dn.isSelected(t),o.hasOwnProperty(t)?o[t]=3Do[t]&&e:o[t]=3De)})})=
,"allSelect"=3D=3D=3Dt||"inverseSelect"=3D=3D=3Dt?{selected:o}:{name:e.name=
,selected:o}}function Jb(t){t.registerComponentModel(Fb),t.registerComponen=
tView(Ub),t.registerProcessor(t.PRIORITY.PROCESSOR.SERIES_FILTER,$b),t.regi=
sterSubTypeDefaulter("legend",function(){return"plain"}),(t=3Dt).registerAc=
tion("legendToggleSelect","legendselectchanged",M(Qb,"toggleSelected")),t.r=
egisterAction("legendAllSelect","legendselectall",M(Qb,"allSelect")),t.regi=
sterAction("legendInverseSelect","legendinverseselect",M(Qb,"inverseSelect"=
)),t.registerAction("legendSelect","legendselected",M(Qb,"select")),t.regis=
terAction("legendUnSelect","legendunselected",M(Qb,"unSelect"))}u(nS,tS=3DF=
b),nS.prototype.setScrollDataIndex=3Dfunction(t){this.option.scrollDataInde=
x=3Dt},nS.prototype.init=3Dfunction(t,e,n){var i=3DGp(t);tS.prototype.init.=
call(this,t,e,n),iS(this,t,i)},nS.prototype.mergeOption=3Dfunction(t,e){tS.=
prototype.mergeOption.call(this,t,e),iS(this,this.option,t)},nS.type=3D"leg=
end.scroll",nS.defaultOption=3DUc(Fb.defaultOption,{scrollDataIndex:0,pageB=
uttonItemGap:5,pageButtonGap:null,pageButtonPosition:"end",pageFormatter:"{=
current}/{total}",pageIcons:{horizontal:["M0,0L12,-10L12,10z","M0,0L-12,-10=
L-12,10z"],vertical:["M0,0L20,0L10,-20z","M0,0L20,0L10,20z"]},pageIconColor=
:"#2f4554",pageIconInactiveColor:"#aaa",pageIconSize:15,pageTextStyle:{colo=
r:"#333"},animationDurationUpdate:800});var tS,eS=3DnS;function nS(){var t=
=3Dnull!=3D=3DtS&&tS.apply(this,arguments)||this;return t.type=3DnS.type,t}=
function iS(t,e,n){var i=3D[1,1];i[t.getOrient().index]=3D0,Wp(e,n,{type:"b=
ox",ignoreSize:!!i})}var oS,rS=3DWo,aS=3D["width","height"],sS=3D["x","y"],=
lS=3D(u(uS,oS=3DUb),uS.prototype.init=3Dfunction(){oS.prototype.init.call(t=
his),this.group.add(this._containerGroup=3Dnew rS),this._containerGroup.add=
(this.getContentGroup()),this.group.add(this._controllerGroup=3Dnew rS)},uS=
.prototype.resetInner=3Dfunction(){oS.prototype.resetInner.call(this),this.=
_controllerGroup.removeAll(),this._containerGroup.removeClipPath(),this._co=
ntainerGroup.__rectSize=3Dnull},uS.prototype.renderInner=3Dfunction(t,i,e,o=
,n,r,a){var s=3Dthis,l=3D(oS.prototype.renderInner.call(this,t,i,e,o,n,r,a)=
,this._controllerGroup),t=3Di.get("pageIconSize",!0),u=3DV(t)?t:[t,t],e=3D(=
h("pagePrev",0),i.getModel("pageTextStyle"));function h(t,e){var n=3Dt+"Dat=
aIndex",e=3Dhc(i.get("pageIcons",!0)[i.getOrient().name][e],{onclick:S(s._p=
ageGo,s,n,i,o)},{x:-u[0]/2,y:-u[1]/2,width:u[0],height:u[1]});e.name=3Dt,l.=
add(e)}l.add(new Hs({name:"pageText",style:{text:"xx/xx",fill:e.getTextColo=
r(),font:e.getFont(),verticalAlign:"middle",align:"center"},silent:!0})),h(=
"pageNext",1)},uS.prototype.layoutInner=3Dfunction(t,e,n,i,o,r){var a=3Dthi=
s.getSelectorGroup(),s=3Dt.getOrient().index,l=3DaS[s],u=3DsS[s],h=3DaS[1-s=
],c=3DsS[1-s],p=3D(o&&Fp("horizontal",a,t.get("selectorItemGap",!0)),t.get(=
"selectorButtonGap",!0)),d=3Da.getBoundingRect(),f=3D[-d.x,-d.y],g=3Dy(n),n=
=3D(o&&(g[l]=3Dn[l]-d[l]-p),this._layoutContentAndController(t,i,g,s,l,h,c,=
u));return o&&("end"=3D=3D=3Dr?f[s]+=3Dn[l]+p:(t=3Dd[l]+p,f[s]-=3Dt,n[u]-=
=3Dt),n[l]+=3Dd[l]+p,f[1-s]+=3Dn[c]+n[h]/2-d[h]/2,n[h]=3DMath.max(n[h],d[h]=
),n[c]=3DMath.min(n[c],d[c]+f[1-s]),a.x=3Df[0],a.y=3Df[1],a.markRedraw()),n=
},uS.prototype._layoutContentAndController=3Dfunction(t,e,n,i,o,r,a,s){var =
l=3Dthis.getContentGroup(),u=3Dthis._containerGroup,h=3Dthis._controllerGro=
up,c=3D(Fp(t.get("orient"),l,t.get("itemGap"),i?n.width:null,i?null:n.heigh=
t),Fp("horizontal",h,t.get("pageButtonItemGap",!0)),l.getBoundingRect()),p=
=3Dh.getBoundingRect(),d=3Dthis._showController=3Dc[o]>n[o],f=3D[-c.x,-c.y]=
,e=3D(e||(f[i]=3Dl[s]),[0,0]),s=3D[-p.x,-p.y],g=3DR(t.get("pageButtonGap",!=
0),t.get("itemGap",!0)),f=3D(d&&("end"=3D=3D=3Dt.get("pageButtonPosition",!=
0)?s[i]+=3Dn[o]-p[o]:e[i]+=3Dp[o]+g),s[1-i]+=3Dc[r]/2-p[r]/2,l.setPosition(=
f),u.setPosition(e),h.setPosition(s),{x:0,y:0}),c=3D(f[o]=3D(d?n:c)[o],f[r]=
=3DMath.max(c[r],p[r]),f[a]=3DMath.min(0,p[a]+s[1-i]),u.__rectSize=3Dn[o],d=
?((e=3D{x:0,y:0})[o]=3DMath.max(n[o]-p[o]-g,0),e[r]=3Df[r],u.setClipPath(ne=
w Es({shape:e})),u.__rectSize=3De[o]):h.eachChild(function(t){t.attr({invis=
ible:!0,silent:!0})}),this._getPageInfo(t));return null!=3Dc.pageIndex&&Nh(=
l,{x:c.contentPosition[0],y:c.contentPosition[1]},d?t:null),this._updatePag=
eInfoView(t,c),f},uS.prototype._pageGo=3Dfunction(t,e,n){t=3Dthis._getPageI=
nfo(e)[t];null!=3Dt&&n.dispatchAction({type:"legendScroll",scrollDataIndex:=
t,legendId:e.id})},uS.prototype._updatePageInfoView=3Dfunction(n,i){var o=
=3Dthis._controllerGroup,t=3D(E(["pagePrev","pageNext"],function(t){var e=
=3Dnull!=3Di[t+"DataIndex"],t=3Do.childOfName(t);t&&(t.setStyle("fill",e?n.=
get("pageIconColor",!0):n.get("pageIconInactiveColor",!0)),t.cursor=3De?"po=
inter":"default")}),o.childOfName("pageText")),e=3Dn.get("pageFormatter"),r=
=3Di.pageIndex,r=3Dnull!=3Dr?r+1:0,a=3Di.pageCount;t&&e&&t.setStyle("text",=
H(e)?e.replace("{current}",null=3D=3Dr?"":r+"").replace("{total}",null=3D=
=3Da?"":a+""):e({current:r,total:a}))},uS.prototype._getPageInfo=3Dfunction=
(t){var e=3Dt.get("scrollDataIndex",!0),n=3Dthis.getContentGroup(),i=3Dthis=
._containerGroup.__rectSize,t=3Dt.getOrient().index,o=3DaS[t],r=3DsS[t],e=
=3Dthis._findTargetItemIndex(e),a=3Dn.children(),s=3Da[e],l=3Da.length,u=3D=
l?1:0,h=3D{contentPosition:[n.x,n.y],pageCount:u,pageIndex:u-1,pagePrevData=
Index:null,pageNextDataIndex:null};if(s){n=3Dg(s);h.contentPosition[t]=3D-n=
.s;for(var c=3De+1,p=3Dn,d=3Dn,f=3Dnull;c<=3Dl;++c)(!(f=3Dg(a[c]))&&d.e>p.s=
+i||f&&!y(f,p.s))&&(p=3Dd.i>p.i?d:f)&&(null=3D=3Dh.pageNextDataIndex&&(h.pa=
geNextDataIndex=3Dp.i),++h.pageCount),d=3Df;for(c=3De-1,d=3Dp=3Dn,f=3Dnull;=
-1<=3Dc;--c)(f=3Dg(a[c]))&&y(d,f.s)||!(p.i<d.i)||(d=3Dp,null=3D=3Dh.pagePre=
vDataIndex&&(h.pagePrevDataIndex=3Dp.i),++h.pageCount,++h.pageIndex),p=3Df}=
return h;function g(t){var e,n;if(t)return{s:n=3D(e=3Dt.getBoundingRect())[=
r]+t[r],e:n+e[o],i:t.__legendDataIndex}}function y(t,e){return t.e>=3De&&t.=
s<=3De+i}},uS.prototype._findTargetItemIndex=3Dfunction(n){return this._sho=
wController?(this.getContentGroup().eachChild(function(t,e){t=3Dt.__legendD=
ataIndex;null=3D=3Do&&null!=3Dt&&(o=3De),t=3D=3D=3Dn&&(i=3De)}),null!=3Di?i=
:o):0;var i,o},uS.type=3D"legend.scroll",uS);function uS(){var t=3Dnull!=3D=
=3DoS&&oS.apply(this,arguments)||this;return t.type=3DuS.type,t.newlineDisa=
bled=3D!0,t._currentIndex=3D0,t}U_(function(t){U_(Jb),t.registerComponentMo=
del(eS),t.registerComponentView(lS),t.registerAction("legendScroll","legend=
scroll",function(t,e){var n=3Dt.scrollDataIndex;null!=3Dn&&e.eachComponent(=
{mainType:"legend",subType:"scroll",query:t},function(t){t.setScrollDataInd=
ex(n)})})});var hS=3DRr(),cS=3Dy,pS=3DS;function dS(){this._dragging=3D!1,t=
his.animationThreshold=3D15}function fS(t,e,n,i){!function n(i,t){{var o;if=
(O(i)&&O(t))return o=3D!0,E(t,function(t,e){o=3Do&&n(i[e],t)}),!!o}return i=
=3D=3D=3Dt}(hS(n).lastProp,i)&&(hS(n).lastProp=3Di,e?Nh(n,i,t):(n.stopAnima=
tion(),n.attr(i)))}function gS(t,e){t[e.get(["label","show"])?"show":"hide"=
]()}function yS(t){return{x:t.x||0,y:t.y||0,rotation:t.rotation||0}}functio=
n mS(t,e,n){var i=3De.get("z"),o=3De.get("zlevel");t&&t.traverse(function(t=
){"group"!=3D=3Dt.type&&(null!=3Di&&(t.z=3Di),null!=3Do&&(t.zlevel=3Do),t.s=
ilent=3Dn)})}function vS(t,e,n,i,o){var r=3D_S(n.get("value"),e.axis,e.ecMo=
del,n.get("seriesDataIndices"),{precision:n.get(["label","precision"]),form=
atter:n.get(["label","formatter"])}),n=3Dn.getModel("label"),a=3DDp(n.get("=
padding")||0),s=3Dn.getFont(),l=3DMo(r,s),u=3Do.position,h=3Dl.width+a[1]+a=
[3],l=3Dl.height+a[0]+a[2],c=3Do.align,c=3D("right"=3D=3D=3Dc&&(u[0]-=3Dh),=
"center"=3D=3D=3Dc&&(u[0]-=3Dh/2),o.verticalAlign),i=3D("bottom"=3D=3D=3Dc&=
&(u[1]-=3Dl),"middle"=3D=3D=3Dc&&(u[1]-=3Dl/2),o=3Du,c=3Dh,h=3Dl,i=3D(l=3Di=
).getWidth(),l=3Dl.getHeight(),o[0]=3DMath.min(o[0]+c,i)-c,o[1]=3DMath.min(=
o[1]+h,l)-h,o[0]=3DMath.max(o[0],0),o[1]=3DMath.max(o[1],0),n.get("backgrou=
ndColor"));i&&"auto"!=3D=3Di||(i=3De.get(["axisLine","lineStyle","color"]))=
,t.label=3D{x:u[0],y:u[1],style:wc(n,{text:r,font:s,fill:n.getTextColor(),p=
adding:a,backgroundColor:i}),z2:10}}function _S(t,e,n,i,o){t=3De.scale.pars=
e(t);var r,a=3De.scale.getLabel({value:t},{precision:o.precision}),o=3Do.fo=
rmatter;return o&&(r=3D{value:E_(e,{value:t}),axisDimension:e.dim,axisIndex=
:e.index,seriesData:[]},E(i,function(t){var e=3Dn.getSeriesByIndex(t.series=
Index),t=3Dt.dataIndexInside,e=3De&&e.getDataParams(t);e&&r.seriesData.push=
(e)}),H(o)?a=3Do.replace("{value}",a):D(o)&&(a=3Do(r))),a}function xS(t,e,n=
){var i=3DLe();return Ee(i,i,n.rotation),Ne(i,i,n.position),oc([t.dataToCoo=
rd(e),(n.labelOffset||0)+(n.labelDirection||1)*(n.labelMargin||0)],i)}dS.pr=
ototype.render=3Dfunction(t,e,n,i){var o,r,a=3De.get("value"),s=3De.get("st=
atus");this._axisModel=3Dt,this._axisPointerModel=3De,this._api=3Dn,!i&&thi=
s._lastValue=3D=3D=3Da&&this._lastStatus=3D=3D=3Ds||(this._lastValue=3Da,th=
is._lastStatus=3Ds,i=3Dthis._group,o=3Dthis._handle,s&&"hide"!=3D=3Ds?(i&&i=
.show(),o&&o.show(),this.makeElOption(s=3D{},a,t,e,n),(r=3Ds.graphicKey)!=
=3D=3Dthis._lastGraphicKey&&this.clear(n),this._lastGraphicKey=3Dr,r=3Dthis=
._moveAnimation=3Dthis.determineAnimation(t,e),i?(r=3DM(fS,e,r),this.update=
PointerEl(i,s,r),this.updateLabelEl(i,s,r,e)):(i=3Dthis._group=3Dnew Wo,thi=
s.createPointerEl(i,s,t,e),this.createLabelEl(i,s,t,e),n.getZr().add(i)),mS=
(i,e,!0),this._renderHandle(a)):(i&&i.hide(),o&&o.hide()))},dS.prototype.re=
move=3Dfunction(t){this.clear(t)},dS.prototype.dispose=3Dfunction(t){this.c=
lear(t)},dS.prototype.determineAnimation=3Dfunction(t,e){var n,i=3De.get("a=
nimation"),o=3Dt.axis,r=3D"category"=3D=3D=3Do.type,e=3De.get("snap");retur=
n!(!e&&!r)&&("auto"=3D=3D=3Di||null=3D=3Di?(n=3Dthis.animationThreshold,r&&=
o.getBandWidth()>n||!!e&&(r=3Dgb(t).seriesDataCount,e=3Do.getExtent(),Math.=
abs(e[0]-e[1])/r>n)):!0=3D=3D=3Di)},dS.prototype.makeElOption=3Dfunction(t,=
e,n,i,o){},dS.prototype.createPointerEl=3Dfunction(t,e,n,i){var o=3De.point=
er;o&&(o=3DhS(t).pointerEl=3Dnew gc[o.type](cS(e.pointer)),t.add(o))},dS.pr=
ototype.createLabelEl=3Dfunction(t,e,n,i){e.label&&(e=3DhS(t).labelEl=3Dnew=
 Hs(cS(e.label)),t.add(e),gS(e,i))},dS.prototype.updatePointerEl=3Dfunction=
(t,e,n){t=3DhS(t).pointerEl;t&&e.pointer&&(t.setStyle(e.pointer.style),n(t,=
{shape:e.pointer.shape}))},dS.prototype.updateLabelEl=3Dfunction(t,e,n,i){t=
=3DhS(t).labelEl;t&&(t.setStyle(e.label.style),n(t,{x:e.label.x,y:e.label.y=
}),gS(t,i))},dS.prototype._renderHandle=3Dfunction(t){var e,n,i,o,r,a;!this=
._dragging&&this.updateHandleTransform&&(n=3Dthis._axisPointerModel,i=3Dthi=
s._api.getZr(),o=3Dthis._handle,r=3Dn.getModel("handle"),a=3Dn.get("status"=
),r.get("show")&&a&&"hide"!=3D=3Da?(this._handle||(e=3D!0,o=3Dthis._handle=
=3Dhc(r.get("icon"),{cursor:"move",draggable:!0,onmousemove:function(t){Te(=
t.event)},onmousedown:pS(this._onHandleDragMove,this,0,0),drift:pS(this._on=
HandleDragMove,this),ondragend:pS(this._onHandleDragEnd,this)}),i.add(o)),m=
S(o,n,!1),o.setStyle(r.getItemStyle(null,["color","borderColor","borderWidt=
h","opacity","shadowColor","shadowBlur","shadowOffsetX","shadowOffsetY"])),=
V(a=3Dr.get("size"))||(a=3D[a,a]),o.scaleX=3Da[0]/2,o.scaleY=3Da[1]/2,dy(th=
is,"_doDispatchAxisPointer",r.get("throttle")||0,"fixRate"),this._moveHandl=
eToValue(t,e)):(o&&i.remove(o),this._handle=3Dnull))},dS.prototype._moveHan=
dleToValue=3Dfunction(t,e){fS(this._axisPointerModel,!e&&this._moveAnimatio=
n,this._handle,yS(this.getHandleTransform(t,this._axisModel,this._axisPoint=
erModel)))},dS.prototype._onHandleDragMove=3Dfunction(t,e){var n=3Dthis._ha=
ndle;n&&(this._dragging=3D!0,t=3Dthis.updateHandleTransform(yS(n),[t,e],thi=
s._axisModel,this._axisPointerModel),this._payloadInfo=3Dt,n.stopAnimation(=
),n.attr(yS(t)),hS(n).lastProp=3Dnull,this._doDispatchAxisPointer())},dS.pr=
ototype._doDispatchAxisPointer=3Dfunction(){var t,e;this._handle&&(t=3Dthis=
._payloadInfo,e=3Dthis._axisModel,this._api.dispatchAction({type:"updateAxi=
sPointer",x:t.cursorPoint[0],y:t.cursorPoint[1],tooltipOption:t.tooltipOpti=
on,axesInfo:[{axisDim:e.axis.dim,axisIndex:e.componentIndex}]}))},dS.protot=
ype._onHandleDragEnd=3Dfunction(){var t;this._dragging=3D!1,this._handle&&(=
t=3Dthis._axisPointerModel.get("value"),this._moveHandleToValue(t),this._ap=
i.dispatchAction({type:"hideTip"}))},dS.prototype.clear=3Dfunction(t){this.=
_lastValue=3Dnull,this._lastStatus=3Dnull;var t=3Dt.getZr(),e=3Dthis._group=
,n=3Dthis._handle;t&&e&&(this._lastGraphicKey=3Dnull,e&&t.remove(e),n&&t.re=
move(n),this._group=3Dnull,this._handle=3Dnull,this._payloadInfo=3Dnull),fy=
(this,"_doDispatchAxisPointer")},dS.prototype.doClear=3Dfunction(){},dS.pro=
totype.buildLabel=3Dfunction(t,e,n){return{x:t[n=3Dn||0],y:t[1-n],width:e[n=
],height:e[1-n]}};u(SS,wS=3DdS),SS.prototype.makeElOption=3Dfunction(t,e,n,=
i,o){var r,a,s=3Dn.axis,l=3Ds.grid,u=3Di.get("type"),h=3DMS(l,s).getOtherAx=
is(s).getGlobalExtent(),c=3Ds.toGlobalCoord(s.dataToCoord(e,!0)),p=3D(u&&"n=
one"!=3D=3Du&&(r=3D(a=3Di).get("type"),a=3Da.getModel(r+"Style"),"line"=3D=
=3D=3Dr?(p=3Da.getLineStyle()).fill=3Dnull:"shadow"=3D=3D=3Dr&&((p=3Da.getA=
reaStyle()).stroke=3Dnull),r=3Dp,(a=3DTS[u](s,c,h)).style=3Dr,t.graphicKey=
=3Da.type,t.pointer=3Da),Kw(l.model,n));u=3De,s=3Dt,c=3Dp,h=3Dn,r=3Di,a=3Do=
,l=3Dab.innerTextLayout(c.rotation,0,c.labelDirection),c.labelMargin=3Dr.ge=
t(["label","margin"]),vS(s,h,r,a,{position:xS(h.axis,u,c),align:l.textAlign=
,verticalAlign:l.textVerticalAlign})},SS.prototype.getHandleTransform=3Dfun=
ction(t,e,n){var i=3DKw(e.axis.grid.model,e,{labelInside:!1}),n=3D(i.labelM=
argin=3Dn.get(["handle","margin"]),xS(e.axis,t,i));return{x:n[0],y:n[1],rot=
ation:i.rotation+(i.labelDirection<0?Math.PI:0)}},SS.prototype.updateHandle=
Transform=3Dfunction(t,e,n,i){var n=3Dn.axis,o=3Dn.grid,r=3Dn.getGlobalExte=
nt(!0),o=3DMS(o,n).getOtherAxis(n).getGlobalExtent(),n=3D"x"=3D=3D=3Dn.dim?=
0:1,a=3D[t.x,t.y],e=3D(a[n]+=3De[n],a[n]=3DMath.min(r[1],a[n]),a[n]=3DMath.=
max(r[0],a[n]),(o[1]+o[0])/2),r=3D[e,e];return r[n]=3Da[n],{x:a[0],y:a[1],r=
otation:t.rotation,cursorPoint:r,tooltipOption:[{verticalAlign:"middle"},{a=
lign:"center"}][n]}};var wS,bS=3DSS;function SS(){return null!=3D=3DwS&&wS.=
apply(this,arguments)||this}function MS(t,e){var n=3D{};return n[e.dim+"Axi=
sIndex"]=3De.index,t.getCartesian(n)}var TS=3D{line:function(t,e,n){return{=
type:"Line",subPixelOptimize:!0,shape:(i=3D[e,n[0]],e=3D[e,n[1]],n=3DIS(t),=
{x1:i[n=3Dn||0],y1:i[1-n],x2:e[n],y2:e[1-n]})};var i},shadow:function(t,e,n=
){var i=3DMath.max(1,t.getBandWidth()),o=3Dn[1]-n[0];return{type:"Rect",sha=
pe:(e=3D[e-i/2,n[0]],n=3D[i,o],i=3DIS(t),{x:e[i=3Di||0],y:e[1-i],width:n[i]=
,height:n[1-i]})}}};function IS(t){return"x"=3D=3D=3Dt.dim?0:1}u(kS,CS=3Dg)=
,kS.type=3D"axisPointer",kS.defaultOption=3D{show:"auto",z:50,type:"line",s=
nap:!1,triggerTooltip:!0,triggerEmphasis:!0,value:null,status:null,link:[],=
animation:null,animationDurationUpdate:200,lineStyle:{color:"#B9BEC9",width=
:1,type:"dashed"},shadowStyle:{color:"rgba(210,219,238,0.2)"},label:{show:!=
0,formatter:null,precision:"auto",margin:3,color:"#fff",padding:[5,7,5,7],b=
ackgroundColor:"auto",borderColor:null,borderWidth:0,borderRadius:3},handle=
:{show:!1,icon:"M10.7,11.9v-1.3H9.3v1.3c-4.9,0.3-8.8,4.4-8.8,9.4c0,5,3.9,9.=
1,8.8,9.4h1.3c4.9-0.3,8.8-4.4,8.8-9.4C19.5,16.3,15.6,12.2,10.7,11.9z M13.3,=
24.4H6.7v-1.2h6.6z M13.3,22H6.7v-1.2h6.6z M13.3,19.6H6.7v-1.2h6.6z",size:45=
,margin:50,color:"#333",shadowBlur:3,shadowColor:"#aaa",shadowOffsetX:0,sha=
dowOffsetY:2,throttle:40}};var CS,DS=3DkS;function kS(){var t=3Dnull!=3D=3D=
CS&&CS.apply(this,arguments)||this;return t.type=3DkS.type,t}var AS=3DRr(),=
LS=3DE;function PS(t,e,n){var i,c,p;function o(t,h){c.on(t,function(e){n=3D=
p;var n,i,t,o,r,a,s,l=3D{dispatchAction:u,pendings:i=3D{showTip:[],hideTip:=
[]}};function u(t){var e=3Di[t.type];e?e.push(t):(t.dispatchAction=3Du,n.di=
spatchAction(t))}LS(AS(c).records,function(t){t&&h(t,e,l.dispatchAction)}),=
o=3Dp,a=3D(t=3Dl.pendings).showTip.length,s=3Dt.hideTip.length,a?r=3Dt.show=
Tip[a-1]:s&&(r=3Dt.hideTip[s-1]),r&&(r.dispatchAction=3Dnull,o.dispatchActi=
on(r))})}b.node||(i=3De.getZr(),AS(i).records||(AS(i).records=3D{}),p=3De,A=
S(c=3Di).initialized||(AS(c).initialized=3D!0,o("click",M(RS,"click")),o("m=
ousemove",M(RS,"mousemove")),o("globalout",OS)),(AS(i).records[t]||(AS(i).r=
ecords[t]=3D{})).handler=3Dn)}function OS(t,e,n){t.handler("leave",null,n)}=
function RS(t,e,n,i){e.handler(t,n,i)}function NS(t,e){b.node||(e=3De.getZr=
(),(AS(e).records||{})[t]&&(AS(e).records[t]=3Dnull))}u(BS,ES=3D$g),BS.prot=
otype.render=3Dfunction(t,e,n){var e=3De.getComponent("tooltip"),i=3Dt.get(=
"triggerOn")||e&&e.get("triggerOn")||"mousemove|click";PS("axisPointer",n,f=
unction(t,e,n){"none"!=3D=3Di&&("leave"=3D=3D=3Dt||0<=3Di.indexOf(t))&&n({t=
ype:"updateAxisPointer",currTrigger:t,x:e&&e.offsetX,y:e&&e.offsetY})})},BS=
.prototype.remove=3Dfunction(t,e){NS("axisPointer",e)},BS.prototype.dispose=
=3Dfunction(t,e){NS("axisPointer",e)},BS.type=3D"axisPointer";var ES,zS=3DB=
S;function BS(){var t=3Dnull!=3D=3DES&&ES.apply(this,arguments)||this;retur=
n t.type=3DBS.type,t}function FS(t,e){var n,i,o,r,a=3D[],s=3Dt.seriesIndex;=
return null=3D=3Ds||!(e=3De.getSeriesByIndex(s))||null=3D=3D(s=3DOr(n=3De.g=
etData(),t))||s<0||V(s)?{point:[]}:(i=3Dn.getItemGraphicEl(s),o=3De.coordin=
ateSystem,e.getTooltipPosition?a=3De.getTooltipPosition(s)||[]:o&&o.dataToP=
oint?a=3Dt.isStacked?(e=3Do.getBaseAxis(),t=3Do.getOtherAxis(e).dim,e=3De.d=
im,t=3D"x"=3D=3D=3Dt||"radius"=3D=3D=3Dt?1:0,e=3Dn.mapDimension(e),(r=3D[])=
[t]=3Dn.get(e,s),r[1-t]=3Dn.get(n.getCalculationInfo("stackResultDimension"=
),s),o.dataToPoint(r)||[]):o.dataToPoint(n.getValues(F(o.dimensions,functio=
n(t){return n.mapDimension(t)}),s))||[]:i&&((e=3Di.getBoundingRect().clone(=
)).applyTransform(i.transform),a=3D[e.x+e.width/2,e.y+e.height/2]),{point:a=
,el:i})}var VS=3DRr();function HS(t,e,n){var r,a,i,s,l,o,u,h,c,p,d,f,g,y,m=
=3Dt.currTrigger,v=3D[t.x,t.y],_=3Dt,x=3Dt.dispatchAction||S(n.dispatchActi=
on,n),w=3De.getComponent("axisPointer").coordSysAxesInfo;if(w)return YS(v)&=
&(v=3DFS({seriesIndex:_.seriesIndex,dataIndex:_.dataIndex},e).point),r=3DYS=
(v),a=3D_.axesInfo,i=3Dw.axesInfo,s=3D"leave"=3D=3D=3Dm||YS(v),l=3D{},e=3D{=
list:[],map:{}},u=3D{showPointer:M(GS,o=3D{}),showTooltip:M(XS,e)},E(w.coor=
dSysMap,function(t,e){var o=3Dr||t.containPoint(v);E(w.coordSysAxesInfo[e],=
function(t,e){var n=3Dt.axis,i=3Dfunction(t,e){for(var n=3D0;n<(t||[]).leng=
th;n++){var i=3Dt[n];if(e.axis.dim=3D=3D=3Di.axisDim&&e.axis.model.componen=
tIndex=3D=3D=3Di.axisIndex)return i}}(a,t);s||!o||a&&!i||null!=3D(i=3Dnull!=
=3D(i=3Di&&i.value)||r?i:n.pointToData(v))&&WS(t,i,u,!1,l)})}),h=3D{},E(i,f=
unction(n,t){var i=3Dn.linkGroup;i&&!o[t]&&E(i.axesInfo,function(t,e){var e=
=3Do[e];t!=3D=3Dn&&e&&(e=3De.value,i.mapper&&(e=3Dn.axis.scale.parse(i.mapp=
er(e,US(t),US(n)))),h[n.key]=3De)})}),E(h,function(t,e){WS(i[e],t,u,!0,l)})=
,g=3Do,_=3Di,y=3Dl.axesInfo=3D[],E(_,function(t,e){var n=3Dt.axisPointerMod=
el.option,e=3Dg[e];e?(t.useHandle||(n.status=3D"show"),n.value=3De.value,n.=
seriesDataIndices=3D(e.payloadBatch||[]).slice()):t.useHandle||(n.status=3D=
"hide"),"show"=3D=3D=3Dn.status&&y.push({axisDim:t.axis.dim,axisIndex:t.axi=
s.model.componentIndex,value:n.value})}),m=3De,_=3Dt,e=3Dx,!YS(t=3Dv)&&m.li=
st.length?(x=3D((m.list[0].dataByAxis[0]||{}).seriesDataIndices||[])[0]||{}=
,e({type:"showTip",escapeConnect:!0,x:t[0],y:t[1],tooltipOption:_.tooltipOp=
tion,position:_.position,dataIndexInside:x.dataIndexInside,dataIndex:x.data=
Index,seriesIndex:x.seriesIndex,dataByCoordSys:m.list})):e({type:"hideTip"}=
),t=3Di,x=3D(_=3Dn).getZr(),m=3D"axisPointerLastHighlights",c=3DVS(x)[m]||{=
},p=3DVS(x)[m]=3D{},E(t,function(t,e){var n=3Dt.axisPointerModel.option;"sh=
ow"=3D=3D=3Dn.status&&t.triggerEmphasis&&E(n.seriesDataIndices,function(t){=
var e=3Dt.seriesIndex+" | "+t.dataIndex;p[e]=3Dt})}),d=3D[],f=3D[],E(c,func=
tion(t,e){p[e]||f.push(t)}),E(p,function(t,e){c[e]||d.push(t)}),f.length&&_=
.dispatchAction({type:"downplay",escapeConnect:!0,notBlur:!0,batch:f}),d.le=
ngth&&_.dispatchAction({type:"highlight",escapeConnect:!0,notBlur:!0,batch:=
d}),l}function WS(t,e,n,i,o){var r,a,s,l,u,h,c,p,d,f,g=3Dt.axis;!g.scale.is=
Blank()&&g.containData(e)&&(t.involveSeries?(l=3De,u=3Dt.axis,h=3Du.dim,c=
=3Dl,p=3D[],d=3DNumber.MAX_VALUE,f=3D-1,E(t.seriesModels,function(e,t){var =
n,i=3De.getData().mapDimensionsAll(h);if(e.getAxisTooltipData)var o=3De.get=
AxisTooltipData(i,l,u),r=3Do.dataIndices,o=3Do.nestestValue;else{if(!(r=3De=
.getData().indicesOfNearest(i[0],l,"category"=3D=3D=3Du.type?.5:null)).leng=
th)return;o=3De.getData().get(i[0],r[0])}null!=3Do&&isFinite(o)&&(i=3Dl-o,(=
n=3DMath.abs(i))<=3Dd)&&((n<d||0<=3Di&&f<0)&&(d=3Dn,f=3Di,c=3Do,p.length=3D=
0),E(r,function(t){p.push({seriesIndex:e.seriesIndex,dataIndexInside:t,data=
Index:e.getData().getRawIndex(t)})}))}),s=3D(r=3D{payloadBatch:p,snapToValu=
e:c}).snapToValue,(a=3Dr.payloadBatch)[0]&&null=3D=3Do.seriesIndex&&P(o,a[0=
]),!i&&t.snap&&g.containData(s)&&null!=3Ds&&(e=3Ds),n.showPointer(t,e,a),n.=
showTooltip(t,r,s)):n.showPointer(t,e))}function GS(t,e,n,i){t[e.key]=3D{va=
lue:n,payloadBatch:i}}function XS(t,e,n,i){var o,r,n=3Dn.payloadBatch,a=3De=
.axis,s=3Da.model,l=3De.axisPointerModel;e.triggerTooltip&&n.length&&(o=3Dm=
b(e=3De.coordSys.model),(r=3Dt.map[o])||(r=3Dt.map[o]=3D{coordSysId:e.id,co=
ordSysIndex:e.componentIndex,coordSysType:e.type,coordSysMainType:e.mainTyp=
e,dataByAxis:[]},t.list.push(r)),r.dataByAxis.push({axisDim:a.dim,axisIndex=
:s.componentIndex,axisType:s.type,axisId:s.id,value:i,valueLabelOpt:{precis=
ion:l.get(["label","precision"]),formatter:l.get(["label","formatter"])},se=
riesDataIndices:n.slice()}))}function US(t){var e=3Dt.axis.model,n=3D{},t=
=3Dn.axisDim=3Dt.axis.dim;return n.axisIndex=3Dn[t+"AxisIndex"]=3De.compone=
ntIndex,n.axisName=3Dn[t+"AxisName"]=3De.name,n.axisId=3Dn[t+"AxisId"]=3De.=
id,n}function YS(t){return!t||null=3D=3Dt[0]||isNaN(t[0])||null=3D=3Dt[1]||=
isNaN(t[1])}function ZS(t){xb.registerAxisPointerClass("CartesianAxisPointe=
r",bS),t.registerComponentModel(DS),t.registerComponentView(zS),t.registerP=
reprocessor(function(t){var e;t&&(t.axisPointer&&0!=3D=3Dt.axisPointer.leng=
th||(t.axisPointer=3D{}),e=3Dt.axisPointer.link)&&!V(e)&&(t.axisPointer.lin=
k=3D[e])}),t.registerProcessor(t.PRIORITY.PROCESSOR.STATISTIC,function(t,e)=
{t.getComponent("axisPointer").coordSysAxesInfo=3Ddb(t,e)}),t.registerActio=
n({type:"updateAxisPointer",event:"updateAxisPointer",update:":updateAxisPo=
inter"},HS)}u(KS,qS=3Dg),KS.type=3D"tooltip",KS.dependencies=3D["axisPointe=
r"],KS.defaultOption=3D{z:60,show:!0,showContent:!0,trigger:"item",triggerO=
n:"mousemove|click",alwaysShowContent:!1,displayMode:"single",renderMode:"a=
uto",confine:null,showDelay:0,hideDelay:100,transitionDuration:.4,enterable=
:!1,backgroundColor:"#fff",shadowBlur:10,shadowColor:"rgba(0, 0, 0, .2)",sh=
adowOffsetX:1,shadowOffsetY:2,borderRadius:4,borderWidth:1,padding:null,ext=
raCssText:"",axisPointer:{type:"line",axis:"auto",animation:"auto",animatio=
nDurationUpdate:200,animationEasingUpdate:"exponentialOut",crossStyle:{colo=
r:"#999",width:1,type:"dashed",textStyle:{}}},textStyle:{color:"#666",fontS=
ize:14}};var qS,jS=3DKS;function KS(){var t=3Dnull!=3D=3DqS&&qS.apply(this,=
arguments)||this;return t.type=3DKS.type,t}function $S(t){var e=3Dt.get("co=
nfine");return null!=3De?e:"richText"=3D=3D=3Dt.get("renderMode")}function =
QS(t){if(b.domSupported)for(var e=3Ddocument.documentElement.style,n=3D0,i=
=3Dt.length;n<i;n++)if(t[n]in e)return t[n]}var JS=3DQS(["transform","webki=
tTransform","OTransform","MozTransform","msTransform"]);function tM(t,e){if=
(!t)return e;e=3DCp(e,!0);var n=3Dt.indexOf(e);return(t=3D-1=3D=3D=3Dn?e:"-=
"+t.slice(0,n)+"-"+e).toLowerCase()}var eM=3DtM(QS(["webkitTransition","tra=
nsition","OTransition","MozTransition","msTransition"]),"transition"),nM=3D=
tM(JS,"transform"),iM=3D"position:absolute;display:block;border-style:solid=
;white-space:nowrap;z-index:9999999;"+(b.transform3dSupported?"will-change:=
transform;":"");function oM(t,e,n){var i,t=3Dt.toFixed(0)+"px",e=3De.toFixe=
d(0)+"px";return b.transformSupported?(i=3D"translate"+((i=3Db.transform3dS=
upported)?"3d":"")+"("+t+","+e+(i?",0":"")+")",n?"top:0;left:0;"+nM+":"+i+"=
;":[["top",0],["left",0],[JS,i]]):n?"top:"+e+";left:"+t+";":[["top",e],["le=
ft",t]]}function rM(i,t,e){var n,o,r=3D[],a=3Di.get("transitionDuration"),s=
=3Di.get("backgroundColor"),l=3Di.get("shadowBlur"),u=3Di.get("shadowColor"=
),h=3Di.get("shadowOffsetX"),c=3Di.get("shadowOffsetY"),p=3Di.getModel("tex=
tStyle"),d=3DEg(i,"html");return r.push("box-shadow:"+(h+"px "+c+"px "+l+"p=
x "+u)),t&&a&&r.push((u=3D"opacity"+(l=3D" "+(h=3Da)/2+"s "+(c=3D"cubic-bez=
ier(0.23,1,0.32,1)"))+",visibility"+l,e||(l=3D" "+h+"s "+c,u+=3Db.transform=
Supported?","+nM+l:",left"+l+",top"+l),eM+":"+u)),s&&r.push("background-col=
or:"+s),E(["width","color","radius"],function(t){var e=3D"border-"+t,n=3DCp=
(e),n=3Di.get(n);null!=3Dn&&r.push(e+":"+n+("color"=3D=3D=3Dt?"":"px"))}),r=
.push((o=3D[],t=3D(n=3Dp).get("fontSize"),(a=3Dn.getTextColor())&&o.push("c=
olor:"+a),o.push("font:"+n.getFont()),t&&o.push("line-height:"+Math.round(3=
*t/2)+"px"),a=3Dn.get("textShadowColor"),t=3Dn.get("textShadowBlur")||0,e=
=3Dn.get("textShadowOffsetX")||0,h=3Dn.get("textShadowOffsetY")||0,a&&t&&o.=
push("text-shadow:"+e+"px "+h+"px "+t+"px "+a),E(["decoration","align"],fun=
ction(t){var e=3Dn.get(t);e&&o.push("text-"+t+":"+e)}),o.join(";"))),null!=
=3Dd&&r.push("padding:"+Dp(d).join("px ")+"px"),r.join(";")+";"}function aM=
(t,e,n,i,o){var r,a,s=3De&&e.painter;n?(r=3Ds&&s.getViewportRoot())&&(a=3Dt=
,n=3Dn,de(pe,r,i,o,!0))&&de(a,n,pe[0],pe[1]):(t[0]=3Di,t[1]=3Do,(r=3Ds&&s.g=
etViewportRootOffset())&&(t[0]+=3Dr.offsetLeft,t[1]+=3Dr.offsetTop)),t[2]=
=3Dt[0]/e.getWidth(),t[3]=3Dt[1]/e.getHeight()}lM.prototype.update=3Dfuncti=
on(t){this._container||(i=3Dthis._api.getDom(),n=3D"position",n=3D(e=3D(e=
=3Di).currentStyle||document.defaultView&&document.defaultView.getComputedS=
tyle(e))?n?e[n]:e:null,"absolute"!=3D=3D(e=3Di.style).position&&"absolute"!=
=3D=3Dn&&(e.position=3D"relative"));var e,n,i=3Dt.get("alwaysShowContent");=
i&&this._moveIfResized(),this._alwaysShowContent=3Di,this.el.className=3Dt.=
get("className")||""},lM.prototype.show=3Dfunction(t,e){clearTimeout(this._=
hideTimeout),clearTimeout(this._longHideTimeout);var n=3Dthis.el,i=3Dn.styl=
e,o=3Dthis._styleCoord;n.innerHTML?i.cssText=3DiM+rM(t,!this._firstShow,thi=
s._longHide)+oM(o[0],o[1],!0)+"border-color:"+Rp(e)+";"+(t.get("extraCssTex=
t")||"")+";pointer-events:"+(this._enterable?"auto":"none"):i.display=3D"no=
ne",this._show=3D!0,this._firstShow=3D!1,this._longHide=3D!1},lM.prototype.=
setContent=3Dfunction(t,e,n,i,o){var r,a,s,l,u,h=3Dthis.el;if(null!=3Dt){va=
r c=3D"";if(H(o)&&"item"=3D=3D=3Dn.get("trigger")&&!$S(n)&&(n=3Dn,i=3Di,c=
=3DH(o=3Do)&&"inside"!=3D=3Do?(r=3Dn.get("backgroundColor"),n=3Dn.get("bord=
erWidth"),i=3DRp(i),o=3D"left"=3D=3D=3D(o=3Do)?"right":"right"=3D=3D=3Do?"l=
eft":"top"=3D=3D=3Do?"bottom":"top",p=3DMath.max(1.5*Math.round(n),6),a=3D"=
",s=3DnM+":",-1<C(["left","right"],o)?(a+=3D"top:50%",s+=3D"translateY(-50%=
) rotate("+(u=3D"left"=3D=3Do?-225:-45)+"deg)"):(a+=3D"left:50%",s+=3D"tran=
slateX(-50%) rotate("+(u=3D"top"=3D=3Do?225:45)+"deg)"),u=3Du*Math.PI/180,u=
=3D(l=3Dp+n)*Math.abs(Math.cos(u))+l*Math.abs(Math.sin(u)),i=3Di+" solid "+=
n+"px;",'<div style=3D"'+["position:absolute;width:"+p+"px;height:"+p+"px;z=
-index:-1;",(a+=3D";"+o+":-"+Math.round(100*((u-Math.SQRT2*n)/2+Math.SQRT2*=
n-(u-l)/2))/100+"px")+";"+s+";","border-bottom:"+i,"border-right:"+i,"backg=
round-color:"+r+";"].join("")+'"></div>'):""),H(t))h.innerHTML=3Dt+c;else i=
f(t){h.innerHTML=3D"",V(t)||(t=3D[t]);for(var p,d=3D0;d<t.length;d++)ft(t[d=
])&&t[d].parentNode!=3D=3Dh&&h.appendChild(t[d]);c&&h.childNodes.length&&((=
p=3Ddocument.createElement("div")).innerHTML=3Dc,h.appendChild(p))}}else h.=
innerHTML=3D""},lM.prototype.setEnterable=3Dfunction(t){this._enterable=3Dt=
},lM.prototype.getSize=3Dfunction(){var t=3Dthis.el;return[t.offsetWidth,t.=
offsetHeight]},lM.prototype.moveTo=3Dfunction(t,e){var n,i=3Dthis._styleCoo=
rd;aM(i,this._zr,this._container,t,e),null!=3Di[0]&&null!=3Di[1]&&(n=3Dthis=
.el.style,E(oM(i[0],i[1]),function(t){n[t[0]]=3Dt[1]}))},lM.prototype._move=
IfResized=3Dfunction(){var t=3Dthis._styleCoord[2],e=3Dthis._styleCoord[3];=
this.moveTo(t*this._zr.getWidth(),e*this._zr.getHeight())},lM.prototype.hid=
e=3Dfunction(){var t=3Dthis,e=3Dthis.el.style;e.visibility=3D"hidden",e.opa=
city=3D"0",b.transform3dSupported&&(e.willChange=3D""),this._show=3D!1,this=
._longHideTimeout=3DsetTimeout(function(){return t._longHide=3D!0},500)},lM=
.prototype.hideLater=3Dfunction(t){!this._show||this._inContent&&this._ente=
rable||this._alwaysShowContent||(t?(this._hideDelay=3Dt,this._show=3D!1,thi=
s._hideTimeout=3DsetTimeout(S(this.hide,this),t)):this.hide())},lM.prototyp=
e.isShow=3Dfunction(){return this._show},lM.prototype.dispose=3Dfunction(){=
clearTimeout(this._hideTimeout),clearTimeout(this._longHideTimeout);var t=
=3Dthis.el.parentNode;t&&t.removeChild(this.el),this.el=3Dthis._container=
=3Dnull};var sM=3DlM;function lM(t,e){if(this._show=3D!1,this._styleCoord=
=3D[0,0,0,0],this._enterable=3D!0,this._alwaysShowContent=3D!1,this._firstS=
how=3D!0,this._longHide=3D!0,b.wxa)return null;var n=3Ddocument.createEleme=
nt("div"),i=3D(n.domBelongToZr=3D!0,this.el=3Dn,this._zr=3Dt.getZr()),e=3De=
.appendTo,e=3De&&(H(e)?document.querySelector(e):ft(e)?e:D(e)&&e(t.getDom()=
)),o=3D(aM(this._styleCoord,i,e,t.getWidth()/2,t.getHeight()/2),(e||t.getDo=
m()).appendChild(n),this._api=3Dt,this._container=3De,this);n.onmouseenter=
=3Dfunction(){o._enterable&&(clearTimeout(o._hideTimeout),o._show=3D!0),o._=
inContent=3D!0},n.onmousemove=3Dfunction(t){var e;t=3Dt||window.event,o._en=
terable||(e=3Di.handler,Me(i.painter.getViewportRoot(),t,!0),e.dispatch("mo=
usemove",t))},n.onmouseleave=3Dfunction(){o._inContent=3D!1,o._enterable&&o=
._show&&o.hideLater(o._hideDelay)}}hM.prototype.update=3Dfunction(t){t=3Dt.=
get("alwaysShowContent");t&&this._moveIfResized(),this._alwaysShowContent=
=3Dt},hM.prototype.show=3Dfunction(){this._hideTimeout&&clearTimeout(this._=
hideTimeout),this.el.show(),this._show=3D!0},hM.prototype.setContent=3Dfunc=
tion(t,e,n,i,o){var r=3Dthis,a=3D(O(t)&&f(""),this.el&&this._zr.remove(this=
.el),n.getModel("textStyle")),s=3D(this.el=3Dnew Hs({style:{rich:e.richText=
Styles,text:t,lineHeight:22,borderWidth:1,borderColor:i,textShadowColor:a.g=
et("textShadowColor"),fill:n.get(["textStyle","color"]),padding:Eg(n,"richT=
ext"),verticalAlign:"top",align:"left"},z:n.get("z")}),E(["backgroundColor"=
,"borderRadius","shadowColor","shadowBlur","shadowOffsetX","shadowOffsetY"]=
,function(t){r.el.style[t]=3Dn.get(t)}),E(["textShadowBlur","textShadowOffs=
etX","textShadowOffsetY"],function(t){r.el.style[t]=3Da.get(t)||0}),this._z=
r.add(this.el),this);this.el.on("mouseover",function(){s._enterable&&(clear=
Timeout(s._hideTimeout),s._show=3D!0),s._inContent=3D!0}),this.el.on("mouse=
out",function(){s._enterable&&s._show&&s.hideLater(s._hideDelay),s._inConte=
nt=3D!1})},hM.prototype.setEnterable=3Dfunction(t){this._enterable=3Dt},hM.=
prototype.getSize=3Dfunction(){var t=3Dthis.el,e=3Dthis.el.getBoundingRect(=
),t=3DpM(t.style);return[e.width+t.left+t.right,e.height+t.top+t.bottom]},h=
M.prototype.moveTo=3Dfunction(t,e){var n,i,o=3Dthis.el;o&&(dM(i=3Dthis._sty=
leCoord,this._zr,t,e),t=3Di[0],e=3Di[1],n=3DcM((i=3Do.style).borderWidth||0=
),i=3DpM(i),o.x=3Dt+n+i.left,o.y=3De+n+i.top,o.markRedraw())},hM.prototype.=
_moveIfResized=3Dfunction(){var t=3Dthis._styleCoord[2],e=3Dthis._styleCoor=
d[3];this.moveTo(t*this._zr.getWidth(),e*this._zr.getHeight())},hM.prototyp=
e.hide=3Dfunction(){this.el&&this.el.hide(),this._show=3D!1},hM.prototype.h=
ideLater=3Dfunction(t){!this._show||this._inContent&&this._enterable||this.=
_alwaysShowContent||(t?(this._hideDelay=3Dt,this._show=3D!1,this._hideTimeo=
ut=3DsetTimeout(S(this.hide,this),t)):this.hide())},hM.prototype.isShow=3Df=
unction(){return this._show},hM.prototype.dispose=3Dfunction(){this._zr.rem=
ove(this.el)};var uM=3DhM;function hM(t){this._show=3D!1,this._styleCoord=
=3D[0,0,0,0],this._alwaysShowContent=3D!1,this._enterable=3D!0,this._zr=3Dt=
.getZr(),dM(this._styleCoord,this._zr,t.getWidth()/2,t.getHeight()/2)}funct=
ion cM(t){return Math.max(0,t)}function pM(t){var e=3DcM(t.shadowBlur||0),n=
=3DcM(t.shadowOffsetX||0),t=3DcM(t.shadowOffsetY||0);return{left:cM(e-n),ri=
ght:cM(e+n),top:cM(e-t),bottom:cM(e+t)}}function dM(t,e,n,i){t[0]=3Dn,t[1]=
=3Di,t[2]=3Dt[0]/e.getWidth(),t[3]=3Dt[1]/e.getHeight()}var fM,gM=3Dnew Es(=
{shape:{x:-1,y:-1,width:2,height:2}}),yM=3D(u(mM,fM=3D$g),mM.prototype.init=
=3Dfunction(t,e){var n;!b.node&&e.getDom()&&(t=3Dt.getComponent("tooltip"),=
n=3Dthis._renderMode=3D"auto"=3D=3D=3D(n=3Dt.get("renderMode"))?b.domSuppor=
ted?"html":"richText":n||"html",this._tooltipContent=3D"richText"=3D=3D=3Dn=
?new uM(e):new sM(e,{appendTo:t.get("appendToBody",!0)?"body":t.get("append=
To",!0)}))},mM.prototype.render=3Dfunction(t,e,n){!b.node&&n.getDom()&&(thi=
s.group.removeAll(),this._tooltipModel=3Dt,this._ecModel=3De,this._api=3Dn,=
(e=3Dthis._tooltipContent).update(t),e.setEnterable(t.get("enterable")),thi=
s._initGlobalListener(),this._keepShow(),"richText"!=3D=3Dthis._renderMode&=
&t.get("transitionDuration")?dy(this,"_updatePosition",50,"fixRate"):fy(thi=
s,"_updatePosition"))},mM.prototype._initGlobalListener=3Dfunction(){var i=
=3Dthis._tooltipModel.get("triggerOn");PS("itemTooltip",this._api,S(functio=
n(t,e,n){"none"!=3D=3Di&&(0<=3Di.indexOf(t)?this._tryShow(e,n):"leave"=3D=
=3D=3Dt&&this._hide(n))},this))},mM.prototype._keepShow=3Dfunction(){var t,=
e=3Dthis._tooltipModel,n=3Dthis._ecModel,i=3Dthis._api,o=3De.get("triggerOn=
");null!=3Dthis._lastX&&null!=3Dthis._lastY&&"none"!=3D=3Do&&"click"!=3D=3D=
o&&(t=3Dthis,clearTimeout(this._refreshUpdateTimeout),this._refreshUpdateTi=
meout=3DsetTimeout(function(){i.isDisposed()||t.manuallyShowTip(e,n,i,{x:t.=
_lastX,y:t._lastY,dataByCoordSys:t._lastDataByCoordSys})}))},mM.prototype.m=
anuallyShowTip=3Dfunction(t,e,n,i){var o,r,a,s;i.from!=3D=3Dthis.uid&&!b.no=
de&&n.getDom()&&(o=3D_M(i,n),this._ticket=3D"",s=3Di.dataByCoordSys,(r=3Dfu=
nction(n,t,e){var i=3Dzr(n).queryOptionMap,o=3Di.keys()[0];if(o&&"series"!=
=3D=3Do){var r,t=3DVr(t,o,i.get(o),{useDefault:!1,enableAll:!1,enableNone:!=
1}).models[0];if(t)return e.getViewOfComponentModel(t).group.traverse(funct=
ion(t){var e=3Dk(t).tooltipConfig;if(e&&e.name=3D=3D=3Dn.name)return r=3Dt,=
!0}),r?{componentMainType:o,componentIndex:t.componentIndex,el:r}:void 0}}(=
i,e,n))?((a=3Dr.el.getBoundingRect().clone()).applyTransform(r.el.transform=
),this._tryShow({offsetX:a.x+a.width/2,offsetY:a.y+a.height/2,target:r.el,p=
osition:i.position,positionDefault:"bottom"},o)):i.tooltip&&null!=3Di.x&&nu=
ll!=3Di.y?((a=3DgM).x=3Di.x,a.y=3Di.y,a.update(),k(a).tooltipConfig=3D{name=
:null,option:i.tooltip},this._tryShow({offsetX:i.x,offsetY:i.y,target:a},o)=
):s?this._tryShow({offsetX:i.x,offsetY:i.y,position:i.position,dataByCoordS=
ys:s,tooltipOption:i.tooltipOption},o):null!=3Di.seriesIndex?this._manually=
AxisShowTip(t,e,n,i)||(a=3D(r=3DFS(i,e)).point[0],s=3Dr.point[1],null!=3Da&=
&null!=3Ds&&this._tryShow({offsetX:a,offsetY:s,target:r.el,position:i.posit=
ion,positionDefault:"bottom"},o)):null!=3Di.x&&null!=3Di.y&&(n.dispatchActi=
on({type:"updateAxisPointer",x:i.x,y:i.y}),this._tryShow({offsetX:i.x,offse=
tY:i.y,position:i.position,target:n.getZr().findHover(i.x,i.y).target},o)))=
},mM.prototype.manuallyHideTip=3Dfunction(t,e,n,i){var o=3Dthis._tooltipCon=
tent;this._tooltipModel&&o.hideLater(this._tooltipModel.get("hideDelay")),t=
his._lastX=3Dthis._lastY=3Dthis._lastDataByCoordSys=3Dnull,i.from!=3D=3Dthi=
s.uid&&this._hide(_M(i,n))},mM.prototype._manuallyAxisShowTip=3Dfunction(t,=
e,n,i){var o=3Di.seriesIndex,r=3Di.dataIndex,a=3De.getComponent("axisPointe=
r").coordSysAxesInfo;if(null!=3Do&&null!=3Dr&&null!=3Da){a=3De.getSeriesByI=
ndex(o);if(a&&"axis"=3D=3D=3DvM([a.getData().getItemModel(r),a,(a.coordinat=
eSystem||{}).model],this._tooltipModel).get("trigger"))return n.dispatchAct=
ion({type:"updateAxisPointer",seriesIndex:o,dataIndex:r,position:i.position=
}),!0}},mM.prototype._tryShow=3Dfunction(t,e){var n,i,o,r=3Dt.target;this._=
tooltipModel&&(this._lastX=3Dt.offsetX,this._lastY=3Dt.offsetY,(n=3Dt.dataB=
yCoordSys)&&n.length?this._showAxisTooltip(n,t):r?"legend"!=3D=3Dk(r).ssrTy=
pe&&(Zy(r,function(t){return null!=3Dk(t).dataIndex?(i=3Dt,1):null!=3Dk(t).=
tooltipConfig&&(o=3Dt,1)},!(this._lastDataByCoordSys=3Dnull)),i?this._showS=
eriesItemTooltip(t,i,e):o?this._showComponentItemTooltip(t,o,e):this._hide(=
e)):(this._lastDataByCoordSys=3Dnull,this._hide(e)))},mM.prototype._showOrM=
ove=3Dfunction(t,e){t=3Dt.get("showDelay");e=3DS(e,this),clearTimeout(this.=
_showTimout),0<t?this._showTimout=3DsetTimeout(e,t):e()},mM.prototype._show=
AxisTooltip=3Dfunction(t,e){var u=3Dthis._ecModel,h=3Dthis._tooltipModel,n=
=3D[e.offsetX,e.offsetY],i=3DvM([e.tooltipOption],h),c=3Dthis._renderMode,p=
=3D[],d=3DDg("section",{blocks:[],noHeader:!0}),f=3D[],g=3Dnew zg,o=3D(E(t,=
function(t){E(t.dataByAxis,function(o){var r,a,s=3Du.getComponent(o.axisDim=
+"Axis",o.axisIndex),l=3Do.value;s&&null!=3Dl&&(r=3D_S(l,s.axis,u,o.seriesD=
ataIndices,o.valueLabelOpt),a=3DDg("section",{header:r,noHeader:!Mt(r),sort=
Blocks:!0,blocks:[]}),d.blocks.push(a),E(o.seriesDataIndices,function(t){va=
r e,n=3Du.getSeriesByIndex(t.seriesIndex),t=3Dt.dataIndexInside,i=3Dn.getDa=
taParams(t);i.dataIndex<0||(i.axisDim=3Do.axisDim,i.axisIndex=3Do.axisIndex=
,i.axisType=3Do.axisType,i.axisId=3Do.axisId,i.axisValue=3DE_(s.axis,{value=
:l}),i.axisValueLabel=3Dr,i.marker=3Dg.makeTooltipMarker("item",Rp(i.color)=
,c),(e=3D(t=3DLf(n.formatTooltip(t,!0,null))).frag)&&(n=3DvM([n],h).get("va=
lueFormatter"),a.blocks.push(n?P({valueFormatter:n},e):e)),t.text&&f.push(t=
.text),p.push(i))}))})}),d.blocks.reverse(),f.reverse(),e.position),e=3Di.g=
et("order"),e=3DOg(d,g,c,e,u.get("useUTC"),i.get("textStyle")),e=3D(e&&f.un=
shift(e),"richText"=3D=3D=3Dc?"\n\n":"<br/>"),r=3Df.join(e);this._showOrMov=
e(i,function(){this._updateContentNotChangedOnAxis(t,p)?this._updatePositio=
n(i,o,n[0],n[1],this._tooltipContent,p):this._showTooltipContent(i,r,p,Math=
.random()+"",n[0],n[1],o,null,g)})},mM.prototype._showSeriesItemTooltip=3Df=
unction(t,e,n){var i,o,r,a,s,l=3Dthis._ecModel,e=3Dk(e),u=3De.seriesIndex,h=
=3Dl.getSeriesByIndex(u),c=3De.dataModel||h,p=3De.dataIndex,e=3De.dataType,=
d=3Dc.getData(e),f=3Dthis._renderMode,g=3Dt.positionDefault,y=3DvM([d.getIt=
emModel(p),c,h&&(h.coordinateSystem||{}).model],this._tooltipModel,g?{posit=
ion:g}:null),h=3Dy.get("trigger");null!=3Dh&&"item"!=3D=3Dh||(i=3Dc.getData=
Params(p,e),o=3Dnew zg,i.marker=3Do.makeTooltipMarker("item",Rp(i.color),f)=
,g=3DLf(c.formatTooltip(p,!1,e)),h=3Dy.get("order"),e=3Dy.get("valueFormatt=
er"),r=3Dg.frag,a=3Dr?Og(e?P({valueFormatter:e},r):r,o,f,h,l.get("useUTC"),=
y.get("textStyle")):g.text,s=3D"item_"+c.name+"_"+p,this._showOrMove(y,func=
tion(){this._showTooltipContent(y,a,i,s,t.offsetX,t.offsetY,t.position,t.ta=
rget,o)}),n({type:"showTip",dataIndexInside:p,dataIndex:d.getRawIndex(p),se=
riesIndex:u,from:this.uid}))},mM.prototype._showComponentItemTooltip=3Dfunc=
tion(e,n,t){var i=3Dk(n),o=3Di.tooltipConfig.option||{},r=3D[o=3DH(o)?{cont=
ent:o,formatter:o}:o],i=3Dthis._ecModel.getComponent(i.componentMainType,i.=
componentIndex),i=3D(i&&r.push(i),r.push({formatter:o.content}),e.positionD=
efault),a=3DvM(r,this._tooltipModel,i?{position:i}:null),s=3Da.get("content=
"),l=3DMath.random()+"",u=3Dnew zg;this._showOrMove(a,function(){var t=3Dy(=
a.get("formatterParams")||{});this._showTooltipContent(a,s,t,l,e.offsetX,e.=
offsetY,e.position,n,u)}),t({type:"showTip",from:this.uid})},mM.prototype._=
showTooltipContent=3Dfunction(n,t,i,e,o,r,a,s,l){var u,h,c,p,d;this._ticket=
=3D"",n.get("showContent")&&n.get("show")&&((u=3Dthis._tooltipContent).setE=
nterable(n.get("enterable")),h=3Dn.get("formatter"),a=3Da||n.get("position"=
),t=3Dt,c=3Dthis._getNearestPoint([o,r],i,n.get("trigger"),n.get("borderCol=
or")).color,h&&(t=3DH(h)?(p=3Dn.ecModel.get("useUTC"),t=3Dh,Pp(t=3D(d=3DV(i=
)?i[0]:i)&&d.axisType&&0<=3Dd.axisType.indexOf("time")?hp(d.axisValue,t,p):=
t,i,!0)):D(h)?(d=3DS(function(t,e){t=3D=3D=3Dthis._ticket&&(u.setContent(e,=
l,n,c,a),this._updatePosition(n,a,o,r,u,i,s))},this),this._ticket=3De,h(i,e=
,d)):h),u.setContent(t,l,n,c,a),u.show(n,c),this._updatePosition(n,a,o,r,u,=
i,s))},mM.prototype._getNearestPoint=3Dfunction(t,e,n,i){return"axis"=3D=3D=
=3Dn||V(e)?{color:i||("html"=3D=3D=3Dthis._renderMode?"#fff":"none")}:V(e)?=
void 0:{color:i||e.color||e.borderColor}},mM.prototype._updatePosition=3Dfu=
nction(t,e,n,i,o,r,a){var s,l,u,h,c=3Dthis._api.getWidth(),p=3Dthis._api.ge=
tHeight(),d=3D(e=3De||t.get("position"),o.getSize()),f=3Dt.get("align"),g=
=3Dt.get("verticalAlign"),y=3Da&&a.getBoundingRect().clone();a&&y.applyTran=
sform(a.transform),V(e=3DD(e)?e([n,i],r,o.el,y,{viewSize:[c,p],contentSize:=
d.slice()}):e)?(n=3Der(e[0],c),i=3Der(e[1],p)):O(e)?((r=3De).width=3Dd[0],r=
.height=3Dd[1],n=3D(r=3DVp(r,{width:c,height:p})).x,i=3Dr.y,g=3Df=3Dnull):i=
=3D(n=3D(s=3DH(e)&&a?function(t,e,n,i){var o=3Dn[0],r=3Dn[1],a=3DMath.ceil(=
Math.SQRT2*i)+8,s=3D0,l=3D0,u=3De.width,h=3De.height;switch(t){case"inside"=
:s=3De.x+u/2-o/2,l=3De.y+h/2-r/2;break;case"top":s=3De.x+u/2-o/2,l=3De.y-r-=
a;break;case"bottom":s=3De.x+u/2-o/2,l=3De.y+h+a;break;case"left":s=3De.x-o=
-a,l=3De.y+h/2-r/2;break;case"right":s=3De.x+u+a,l=3De.y+h/2-r/2}return[s,l=
]}(e,y,d,t.get("borderWidth")):(r=3Dn,a=3Di,e=3Dc,y=3Dp,l=3Df?null:20,u=3Dg=
?null:20,h=3D(h=3Do).getSize(),s=3Dh[0],h=3Dh[1],null!=3Dl&&(e<r+s+l+2?r-=
=3Ds+l:r+=3Dl),null!=3Du&&(y<a+h+u?a-=3Dh+u:a+=3Du),[r,a]))[0],s[1]),f&&(n-=
=3DxM(f)?d[0]/2:"right"=3D=3D=3Df?d[0]:0),g&&(i-=3DxM(g)?d[1]/2:"bottom"=3D=
=3D=3Dg?d[1]:0),$S(t)&&(e=3Dn,l=3Di,y=3Dc,h=3Dp,u=3D(u=3Do).getSize(),r=3Du=
[0],u=3Du[1],e=3DMath.min(e+r,y)-r,l=3DMath.min(l+u,h)-u,n=3D(s=3D[e=3DMath=
.max(e,0),l=3DMath.max(l,0)])[0],i=3Ds[1]),o.moveTo(n,i)},mM.prototype._upd=
ateContentNotChangedOnAxis=3Dfunction(n,r){var t=3Dthis._lastDataByCoordSys=
,a=3Dthis._cbParamsList,s=3D!!t&&t.length=3D=3D=3Dn.length;return s&&E(t,fu=
nction(t,e){var t=3Dt.dataByAxis||[],o=3D(n[e]||{}).dataByAxis||[];(s=3Ds&&=
t.length=3D=3D=3Do.length)&&E(t,function(t,e){var e=3Do[e]||{},n=3Dt.series=
DataIndices||[],i=3De.seriesDataIndices||[];(s=3Ds&&t.value=3D=3D=3De.value=
&&t.axisType=3D=3D=3De.axisType&&t.axisId=3D=3D=3De.axisId&&n.length=3D=3D=
=3Di.length)&&E(n,function(t,e){e=3Di[e];s=3Ds&&t.seriesIndex=3D=3D=3De.ser=
iesIndex&&t.dataIndex=3D=3D=3De.dataIndex}),a&&E(t.seriesDataIndices,functi=
on(t){var t=3Dt.seriesIndex,e=3Dr[t],t=3Da[t];e&&t&&t.data!=3D=3De.data&&(s=
=3D!1)})})}),this._lastDataByCoordSys=3Dn,this._cbParamsList=3Dr,!!s},mM.pr=
ototype._hide=3Dfunction(t){this._lastDataByCoordSys=3Dnull,t({type:"hideTi=
p",from:this.uid})},mM.prototype.dispose=3Dfunction(t,e){!b.node&&e.getDom(=
)&&(fy(this,"_updatePosition"),this._tooltipContent.dispose(),NS("itemToolt=
ip",e))},mM.type=3D"tooltip",mM);function mM(){var t=3Dnull!=3D=3DfM&&fM.ap=
ply(this,arguments)||this;return t.type=3DmM.type,t}function vM(t,e,n){for(=
var i=3De.ecModel,o=3Dn?(o=3Dnew Hc(n,i,i),new Hc(e.option,o,i)):e,r=3Dt.le=
ngth-1;0<=3Dr;r--){var a=3Dt[r];a&&(a=3DH(a=3Da instanceof Hc?a.get("toolti=
p",!0):a)?{formatter:a}:a)&&(o=3Dnew Hc(a,o,i))}return o}function _M(t,e){r=
eturn t.dispatchAction||S(e.dispatchAction,e)}function xM(t){return"center"=
=3D=3D=3Dt||"middle"=3D=3D=3Dt}function wM(t){Sr(t,"label",["show"])}U_(fun=
ction(t){U_(ZS),t.registerComponentModel(jS),t.registerComponentView(yM),t.=
registerAction({type:"showTip",event:"showTip",update:"tooltip:manuallyShow=
Tip"},zt),t.registerAction({type:"hideTip",event:"hideTip",update:"tooltip:=
manuallyHideTip"},zt)});var bM,SM=3DRr(),MM=3D(u(TM,bM=3Dg),TM.prototype.in=
it=3Dfunction(t,e,n){this.mergeDefaultAndTheme(t,n),this._mergeOption(t,n,!=
1,!0)},TM.prototype.isAnimationEnabled=3Dfunction(){var t;return!b.node&&(t=
=3Dthis.__hostSeries,this.getShallow("animation"))&&t&&t.isAnimationEnabled=
()},TM.prototype.mergeOption=3Dfunction(t,e){this._mergeOption(t,e,!1,!1)},=
TM.prototype._mergeOption=3Dfunction(t,i,e,o){var r=3Dthis.mainType;e||i.ea=
chSeries(function(t){var e=3Dt.get(this.mainType,!0),n=3DSM(t)[r];e&&e.data=
?(n?n._mergeOption(e,i,!0):(o&&wM(e),E(e.data,function(t){t instanceof Arra=
y?(wM(t[0]),wM(t[1])):wM(t)}),P(n=3Dthis.createMarkerModelFromSeries(e,this=
,i),{mainType:this.mainType,seriesIndex:t.seriesIndex,name:t.name,createdBy=
Self:!0}),n.__hostSeries=3Dt),SM(t)[r]=3Dn):SM(t)[r]=3Dnull},this)},TM.prot=
otype.formatTooltip=3Dfunction(t,e,n){var i=3Dthis.getData(),o=3Dthis.getRa=
wValue(t),i=3Di.getName(t);return Dg("section",{header:this.name,blocks:[Dg=
("nameValue",{name:i,value:o,noName:!i,noValue:null=3D=3Do})]})},TM.prototy=
pe.getData=3Dfunction(){return this._data},TM.prototype.setData=3Dfunction(=
t){this._data=3Dt},TM.getMarkerModelFromSeries=3Dfunction(t,e){return SM(t)=
[e]},TM.type=3D"marker",TM.dependencies=3D["series","grid","polar","geo"],T=
M);function TM(){var t=3Dnull!=3D=3DbM&&bM.apply(this,arguments)||this;retu=
rn t.type=3DTM.type,t.createdBySelf=3D!1,t}at(MM,Bc.prototype);u(DM,IM=3DMM=
),DM.prototype.createMarkerModelFromSeries=3Dfunction(t,e,n){return new DM(=
t,e,n)},DM.type=3D"markLine",DM.defaultOption=3D{z:5,symbol:["circle","arro=
w"],symbolSize:[8,16],symbolOffset:0,precision:2,tooltip:{trigger:"item"},l=
abel:{show:!0,position:"end",distance:5},lineStyle:{type:"dashed"},emphasis=
:{label:{show:!0},lineStyle:{width:3}},animationEasing:"linear"};var IM,CM=
=3DDM;function DM(){var t=3Dnull!=3D=3DIM&&IM.apply(this,arguments)||this;r=
eturn t.type=3DDM.type,t}function kM(t,e,n,i,o,r){var a=3D[],s=3DOv(e,i)?e.=
getCalculationInfo("stackResultDimension"):i,t=3DRM(e,s,t),t=3De.indicesOfN=
earest(s,t)[0],o=3D(a[o]=3De.get(n,t),a[r]=3De.get(s,t),e.get(i,t)),n=3Dor(=
e.get(i,t));return 0<=3D(n=3DMath.min(n,20))&&(a[r]=3D+a[r].toFixed(n)),[a,=
o]}var AM=3D{min:M(kM,"min"),max:M(kM,"max"),average:M(kM,"average"),median=
:M(kM,"median")};function LM(t,e){if(e){var n=3Dt.getData(),i=3Dt.coordinat=
eSystem,o=3Di&&i.dimensions;if(s=3De,(isNaN(parseFloat(s.x))||isNaN(parseFl=
oat(s.y)))&&!V(e.coord)&&V(o)&&(s=3DPM(e,n,i,t),(e=3Dy(e)).type&&AM[e.type]=
&&s.baseAxis&&s.valueAxis?(i=3DC(o,s.baseAxis.dim),t=3DC(o,s.valueAxis.dim)=
,s=3DAM[e.type](n,s.baseDataDim,s.valueDataDim,i,t),e.coord=3Ds[0],e.value=
=3Ds[1]):e.coord=3D[null!=3De.xAxis?e.xAxis:e.radiusAxis,null!=3De.yAxis?e.=
yAxis:e.angleAxis]),null!=3De.coord&&V(o))for(var r=3De.coord,a=3D0;a<2;a++=
)AM[r[a]]&&(r[a]=3DRM(n,n.mapDimension(o[a]),r[a]));else e.coord=3D[];retur=
n e}var s}function PM(t,e,n,i){var o=3D{};return null!=3Dt.valueIndex||null=
!=3Dt.valueDim?(o.valueDataDim=3Dnull!=3Dt.valueIndex?e.getDimension(t.valu=
eIndex):t.valueDim,o.valueAxis=3Dn.getAxis(function(t,e){t=3Dt.getData().ge=
tDimensionInfo(e);return t&&t.coordDim}(i,o.valueDataDim)),o.baseAxis=3Dn.g=
etOtherAxis(o.valueAxis),o.baseDataDim=3De.mapDimension(o.baseAxis.dim)):(o=
.baseAxis=3Di.getBaseAxis(),o.valueAxis=3Dn.getOtherAxis(o.baseAxis),o.base=
DataDim=3De.mapDimension(o.baseAxis.dim),o.valueDataDim=3De.mapDimension(o.=
valueAxis.dim)),o}function OM(t,e){return!(t&&t.containData&&e.coord&&(n=3D=
e,isNaN(parseFloat(n.x)))&&isNaN(parseFloat(n.y)))||t.containData(e.coord);=
var n}function RM(t,e,n){var i,o;return"average"=3D=3D=3Dn?(o=3Di=3D0,t.eac=
h(e,function(t,e){isNaN(t)||(i+=3Dt,o++)}),i/o):"median"=3D=3D=3Dn?t.getMed=
ian(e):t.getDataExtent(e)["max"=3D=3D=3Dn?1:0]}function NM(){this.x1=3D0,th=
is.y1=3D0,this.x2=3D0,this.y2=3D0,this.percent=3D1}var EM,zM=3Dnh.prototype=
,BM=3Dlh.prototype;function FM(){return null!=3D=3DEM&&EM.apply(this,argume=
nts)||this}function VM(t){return isNaN(+t.cpx1)||isNaN(+t.cpy1)}u(FM,EM=3DN=
M);u(GM,HM=3D_s),GM.prototype.getDefaultStyle=3Dfunction(){return{stroke:"#=
000",fill:null}},GM.prototype.getDefaultShape=3Dfunction(){return new NM},G=
M.prototype.buildPath=3Dfunction(t,e){(VM(e)?zM:BM).buildPath.call(this,t,e=
)},GM.prototype.pointAt=3Dfunction(t){return(VM(this.shape)?zM:BM).pointAt.=
call(this,t)},GM.prototype.tangentAt=3Dfunction(t){var e=3Dthis.shape,e=3DV=
M(e)?[e.x2-e.x1,e.y2-e.y1]:BM.tangentAt.call(this,t);return Zt(e,e)};var HM=
,WM=3DGM;function GM(t){t=3DHM.call(this,t)||this;return t.type=3D"ec-line"=
,t}var XM=3D["fromSymbol","toSymbol"];function UM(t){return"_"+t+"Type"}fun=
ction YM(t,e,n){var i,o,r,a=3De.getItemVisual(n,t);return a&&"none"!=3D=3Da=
?(i=3De.getItemVisual(n,t+"Size"),o=3De.getItemVisual(n,t+"Rotate"),r=3De.g=
etItemVisual(n,t+"Offset"),e=3De.getItemVisual(n,t+"KeepAspect"),a+(n=3Dsm(=
i))+lm(r||0,n)+(o||"")+(e||"")):a}function ZM(t,e,n){var i,o,r,a=3De.getIte=
mVisual(n,t);if(a&&"none"!=3D=3Da)return r=3De.getItemVisual(n,t+"Size"),i=
=3De.getItemVisual(n,t+"Rotate"),o=3De.getItemVisual(n,t+"Offset"),e=3De.ge=
tItemVisual(n,t+"KeepAspect"),o=3Dlm(o||0,n=3Dsm(r)),(r=3Dam(a,-n[0]/2+o[0]=
,-n[1]/2+o[1],n[0],n[1],null,e)).__specifiedRotation=3Dnull=3D=3Di||isNaN(i=
)?void 0:+i*Math.PI/180||0,r.name=3Dt,r}function qM(t,e){t.x1=3De[0][0],t.y=
1=3De[0][1],t.x2=3De[1][0],t.y2=3De[1][1],t.percent=3D1;e=3De[2];e?(t.cpx1=
=3De[0],t.cpy1=3De[1]):(t.cpx1=3DNaN,t.cpy1=3DNaN)}u($M,jM=3DWo),$M.prototy=
pe._createLine=3Dfunction(n,i,t){var e,o=3Dn.hostModel,r=3D(r=3Dn.getItemLa=
yout(i),qM((e=3Dnew WM({name:"line",subPixelOptimize:!0})).shape,r),e);r.sh=
ape.percent=3D0,Eh(r,{shape:{percent:1}},o,i),this.add(r),E(XM,function(t){=
var e=3DZM(t,n,i);this.add(e),this[UM(t)]=3DYM(t,n,i)},this),this._updateCo=
mmonStl(n,i,t)},$M.prototype.updateData=3Dfunction(i,o,t){var e=3Di.hostMod=
el,n=3Dthis.childOfName("line"),r=3Di.getItemLayout(o),a=3D{shape:{}};qM(a.=
shape,r),Nh(n,a,e,o),E(XM,function(t){var e=3DYM(t,i,o),n=3DUM(t);this[n]!=
=3D=3De&&(this.remove(this.childOfName(t)),t=3DZM(t,i,o),this.add(t)),this[=
n]=3De},this),this._updateCommonStl(i,o,t)},$M.prototype.getLinePath=3Dfunc=
tion(){return this.childAt(0)},$M.prototype._updateCommonStl=3Dfunction(n,t=
,e){var i=3Dn.hostModel,r=3Dthis.childOfName("line"),o=3De&&e.emphasisLineS=
tyle,a=3De&&e.blurLineStyle,s=3De&&e.selectLineStyle,l=3De&&e.labelStatesMo=
dels,u=3De&&e.emphasisDisabled,h=3De&&e.focus,c=3De&&e.blurScope,p=3D(e&&!n=
.hasItemOption||(o=3D(f=3D(e=3Dn.getItemModel(t)).getModel("emphasis")).get=
Model("lineStyle").getLineStyle(),a=3De.getModel(["blur","lineStyle"]).getL=
ineStyle(),s=3De.getModel(["select","lineStyle"]).getLineStyle(),u=3Df.get(=
"disabled"),h=3Df.get("focus"),c=3Df.get("blurScope"),l=3Dxc(e)),n.getItemV=
isual(t,"style")),d=3Dp.stroke,f=3D(r.useStyle(p),r.style.fill=3Dnull,r.sty=
le.strokeNoScale=3D!0,r.ensureState("emphasis").style=3Do,r.ensureState("bl=
ur").style=3Da,r.ensureState("select").style=3Ds,E(XM,function(t){var e=3Dt=
his.childOfName(t);if(e){e.setColor(d),e.style.opacity=3Dp.opacity;for(var =
n=3D0;n<al.length;n++){var i=3Dal[n],o=3Dr.getState(i);o&&(o=3Do.style||{},=
i=3D(i=3De.ensureState(i)).style||(i.style=3D{}),null!=3Do.stroke&&(i[e.__i=
sEmptyBrush?"stroke":"fill"]=3Do.stroke),null!=3Do.opacity)&&(i.opacity=3Do=
.opacity)}e.markRedraw()}},this),i.getRawValue(t)),e=3D(_c(this,l,{labelDat=
aIndex:t,labelFetcher:{getFormattedLabel:function(t,e){return i.getFormatte=
dLabel(t,e,n.dataType)}},inheritColor:d||"#000",defaultOpacity:p.opacity,de=
faultText:(null=3D=3Df?n.getName(t):isFinite(f)?nr(f):f)+""}),this.getTextC=
ontent());e&&(o=3Dl.normal,e.__align=3De.style.align,e.__verticalAlign=3De.=
style.verticalAlign,e.__position=3Do.get("position")||"middle",V(a=3Do.get(=
"distance"))||(a=3D[a,a]),e.__labelDistance=3Da),this.setTextConfig({positi=
on:null,local:!0,inside:!1}),Wl(this,h,c,u)},$M.prototype.highlight=3Dfunct=
ion(){kl(this)},$M.prototype.downplay=3Dfunction(){Al(this)},$M.prototype.u=
pdateLayout=3Dfunction(t,e){this.setLinePoints(t.getItemLayout(e))},$M.prot=
otype.setLinePoints=3Dfunction(t){var e=3Dthis.childOfName("line");qM(e.sha=
pe,t),e.dirty()},$M.prototype.beforeUpdate=3Dfunction(){var t=3Dthis.childO=
fName("fromSymbol"),e=3Dthis.childOfName("toSymbol"),n=3Dthis.getTextConten=
t();if(t||e||n&&!n.ignore){for(var i=3D1,o=3Dthis.parent;o;)o.scaleX&&(i/=
=3Do.scaleX),o=3Do.parent;var r=3Dthis.childOfName("line");if(this.__dirty|=
|r.__dirty){var a=3Dr.shape.percent,s=3Dr.pointAt(0),l=3Dr.pointAt(a),u=3DG=
t([],l,s);if(Zt(u,u),t&&(t.setPosition(s),v(t,0),t.scaleX=3Dt.scaleY=3Di*a,=
t.markRedraw()),e&&(e.setPosition(l),v(e,1),e.scaleX=3De.scaleY=3Di*a,e.mar=
kRedraw()),n&&!n.ignore){n.x=3Dn.y=3D0;var h=3Dvoid(n.originX=3Dn.originY=
=3D0),c=3Dvoid 0,t=3Dn.__labelDistance,p=3Dt[0]*i,d=3Dt[1]*i,e=3Da/2,f=3Dr.=
tangentAt(e),t=3D[f[1],-f[0]],g=3Dr.pointAt(e),y=3D(0<t[1]&&(t[0]=3D-t[0],t=
[1]=3D-t[1]),f[0]<0?-1:1),m=3D("start"!=3D=3Dn.__position&&"end"!=3D=3Dn.__=
position&&(a=3D-Math.atan2(f[1],f[0]),l[0]<s[0]&&(a=3DMath.PI+a),n.rotation=
=3Da),void 0);switch(n.__position){case"insideStartTop":case"insideMiddleTo=
p":case"insideEndTop":case"middle":m=3D-d,c=3D"bottom";break;case"insideSta=
rtBottom":case"insideMiddleBottom":case"insideEndBottom":m=3Dd,c=3D"top";br=
eak;default:m=3D0,c=3D"middle"}switch(n.__position){case"end":n.x=3Du[0]*p+=
l[0],n.y=3Du[1]*d+l[1],h=3D.8<u[0]?"left":u[0]<-.8?"right":"center",c=3D.8<=
u[1]?"top":u[1]<-.8?"bottom":"middle";break;case"start":n.x=3D-u[0]*p+s[0],=
n.y=3D-u[1]*d+s[1],h=3D.8<u[0]?"right":u[0]<-.8?"left":"center",c=3D.8<u[1]=
?"bottom":u[1]<-.8?"top":"middle";break;case"insideStartTop":case"insideSta=
rt":case"insideStartBottom":n.x=3Dp*y+s[0],n.y=3Ds[1]+m,h=3Df[0]<0?"right":=
"left",n.originX=3D-p*y,n.originY=3D-m;break;case"insideMiddleTop":case"ins=
ideMiddle":case"insideMiddleBottom":case"middle":n.x=3Dg[0],n.y=3Dg[1]+m,h=
=3D"center",n.originY=3D-m;break;case"insideEndTop":case"insideEnd":case"in=
sideEndBottom":n.x=3D-p*y+l[0],n.y=3Dl[1]+m,h=3D0<=3Df[0]?"right":"left",n.=
originX=3Dp*y,n.originY=3D-m}n.scaleX=3Dn.scaleY=3Di,n.setStyle({verticalAl=
ign:n.__verticalAlign||c,align:n.__align||h})}}}function v(t,e){var n,i=3Dt=
.__specifiedRotation;null=3D=3Di?(n=3Dr.tangentAt(e),t.attr("rotation",(1=
=3D=3D=3De?-1:1)*Math.PI/2-Math.atan2(n[1],n[0]))):t.attr("rotation",i)}};v=
ar jM,KM=3D$M;function $M(t,e,n){var i=3DjM.call(this)||this;return i._crea=
teLine(t,e,n),i}JM.prototype.updateData=3Dfunction(n){var i=3Dthis,e=3D(thi=
s._progressiveEls=3Dnull,this.group),o=3Dthis._lineData,r=3D(this._lineData=
=3Dn,o||e.removeAll(),tT(n));n.diff(o).add(function(t){i._doAdd(n,t,r)}).up=
date(function(t,e){i._doUpdate(o,n,e,t,r)}).remove(function(t){e.remove(o.g=
etItemGraphicEl(t))}).execute()},JM.prototype.updateLayout=3Dfunction(){var=
 n=3Dthis._lineData;n&&n.eachItemGraphicEl(function(t,e){t.updateLayout(n,e=
)},this)},JM.prototype.incrementalPrepareUpdate=3Dfunction(t){this._seriesS=
cope=3DtT(t),this._lineData=3Dnull,this.group.removeAll()},JM.prototype.inc=
rementalUpdate=3Dfunction(t,e){function n(t){var e;t.isGroup||(e=3Dt).anima=
tors&&0<e.animators.length||(t.incremental=3D!0,t.ensureState("emphasis").h=
overLayer=3D!0)}this._progressiveEls=3D[];for(var i,o=3Dt.start;o<t.end;o++=
)nT(e.getItemLayout(o))&&((i=3Dnew this._LineCtor(e,o,this._seriesScope)).t=
raverse(n),this.group.add(i),e.setItemGraphicEl(o,i),this._progressiveEls.p=
ush(i))},JM.prototype.remove=3Dfunction(){this.group.removeAll()},JM.protot=
ype.eachRendered=3Dfunction(t){fc(this._progressiveEls||this.group,t)},JM.p=
rototype._doAdd=3Dfunction(t,e,n){nT(t.getItemLayout(e))&&(n=3Dnew this._Li=
neCtor(t,e,n),t.setItemGraphicEl(e,n),this.group.add(n))},JM.prototype._doU=
pdate=3Dfunction(t,e,n,i,o){t=3Dt.getItemGraphicEl(n);nT(e.getItemLayout(i)=
)?(t?t.updateData(e,i,o):t=3Dnew this._LineCtor(e,i,o),e.setItemGraphicEl(i=
,t),this.group.add(t)):this.group.remove(t)};var QM=3DJM;function JM(t){thi=
s.group=3Dnew Wo,this._LineCtor=3Dt||KM}function tT(t){var t=3Dt.hostModel,=
e=3Dt.getModel("emphasis");return{lineStyle:t.getModel("lineStyle").getLine=
Style(),emphasisLineStyle:e.getModel(["lineStyle"]).getLineStyle(),blurLine=
Style:t.getModel(["blur","lineStyle"]).getLineStyle(),selectLineStyle:t.get=
Model(["select","lineStyle"]).getLineStyle(),emphasisDisabled:e.get("disabl=
ed"),blurScope:e.get("blurScope"),focus:e.get("focus"),labelStatesModels:xc=
(t)}}function eT(t){return isNaN(t[0])||isNaN(t[1])}function nT(t){return t=
&&!eT(t[0])&&!eT(t[1])}var iT,oT=3DRr(),mu=3D(u(rT,iT=3D$g),rT.prototype.in=
it=3Dfunction(){this.markerGroupMap=3DN()},rT.prototype.render=3Dfunction(t=
,n,i){var o=3Dthis,e=3Dthis.markerGroupMap;e.each(function(t){oT(t).keep=3D=
!1}),n.eachSeries(function(t){var e=3DMM.getMarkerModelFromSeries(t,o.type)=
;e&&o.renderSeries(t,e,n,i)}),e.each(function(t){oT(t).keep||o.group.remove=
(t.group)})},rT.prototype.markKeep=3Dfunction(t){oT(t).keep=3D!0},rT.protot=
ype.toggleBlurSeries=3Dfunction(t,e){var n=3Dthis;E(t,function(t){t=3DMM.ge=
tMarkerModelFromSeries(t,n.type);t&&t.getData().eachItemGraphicEl(function(=
t){t&&(e?Ll:Pl)(t)})})},rT.type=3D"marker",rT);function rT(){var t=3Dnull!=
=3D=3DiT&&iT.apply(this,arguments)||this;return t.type=3DrT.type,t}function=
 aT(t,e,n,i){var o,r,a,s,l=3Dt.getData();return(e=3D[LM(t,(n=3DV(i)?i:"min"=
=3D=3D=3D(o=3Di.type)||"max"=3D=3D=3Do||"average"=3D=3D=3Do||"median"=3D=3D=
=3Do||null!=3Di.xAxis||null!=3Di.yAxis?(r=3Ds=3Dvoid 0,r=3Dnull!=3Di.yAxis|=
|null!=3Di.xAxis?(s=3De.getAxis(null!=3Di.yAxis?"y":"x"),_t(i.yAxis,i.xAxis=
)):(s=3D(e=3DPM(i,l,e,t)).valueAxis,RM(l,Rv(l,e.valueDataDim),o)),e=3D1-(l=
=3D"x"=3D=3D=3Ds.dim?0:1),s=3D{coord:[]},(a=3Dy(i)).type=3Dnull,a.coord=3D[=
],a.coord[e]=3D-1/0,s.coord[e]=3D1/0,0<=3D(e=3Dn.get("precision"))&&W(r)&&(=
r=3D+r.toFixed(Math.min(e,20))),a.coord[l]=3Ds.coord[l]=3Dr,[a,s,{type:o,va=
lueIndex:i.valueIndex,value:r}]):[])[0]),LM(t,n[1]),P({},n[2])])[2].type=3D=
e[2].type||null,d(e[2],e[0]),d(e[2],e[1]),e}var sT=3DRr();function lT(t){re=
turn!isNaN(t)&&!isFinite(t)}function uT(t,e,n,i){var o=3D1-t,r=3Di.dimensio=
ns[t];return lT(e[o])&&lT(n[o])&&e[t]=3D=3D=3Dn[t]&&i.getAxis(r).containDat=
a(e[t])}function hT(t,e){if("cartesian2d"=3D=3D=3Dt.type){var n=3De[0].coor=
d,i=3De[1].coord;if(n&&i&&(uT(1,n,i,t)||uT(0,n,i,t)))return!0}return OM(t,e=
[0])&&OM(t,e[1])}function cT(t,e,n,i,o){var r,a,s=3Di.coordinateSystem,l=3D=
t.getItemModel(e),u=3Der(l.get("x"),o.getWidth()),l=3Der(l.get("y"),o.getHe=
ight());isNaN(u)||isNaN(l)?(r=3Di.getMarkerPosition?i.getMarkerPosition(t.g=
etValues(t.dimensions,e)):(a=3Ds.dimensions,o=3Dt.get(a[0],e),i=3Dt.get(a[1=
],e),s.dataToPoint([o,i])),Ux(s,"cartesian2d")&&(o=3Ds.getAxis("x"),i=3Ds.g=
etAxis("y"),a=3Ds.dimensions,lT(t.get(a[0],e))?r[0]=3Do.toGlobalCoord(o.get=
Extent()[n?0:1]):lT(t.get(a[1],e))&&(r[1]=3Di.toGlobalCoord(i.getExtent()[n=
?0:1]))),isNaN(u)||(r[0]=3Du),isNaN(l)||(r[1]=3Dl)):r=3D[u,l],t.setItemLayo=
ut(e,r)}u(fT,pT=3Dmu),fT.prototype.updateTransform=3Dfunction(t,e,r){e.each=
Series(function(e){var n,i,o,t=3DMM.getMarkerModelFromSeries(e,"markLine");=
t&&(n=3Dt.getData(),i=3DsT(t).from,o=3DsT(t).to,i.each(function(t){cT(i,t,!=
0,e,r),cT(o,t,!1,e,r)}),n.each(function(t){n.setItemLayout(t,[i.getItemLayo=
ut(t),o.getItemLayout(t)])}),this.markerGroupMap.get(e.id).updateLayout())}=
,this)},fT.prototype.renderSeries=3Dfunction(r,e,t,a){var n,i,o,s,l=3Dr.coo=
rdinateSystem,u=3Dr.id,h=3Dr.getData(),c=3Dthis.markerGroupMap,c=3Dc.get(u)=
||c.set(u,new QM),p=3D(this.group.add(c.group),n=3Dr,u=3De,p=3D(l=3Dl)?F(l&=
&l.dimensions,function(t){return P(P({},n.getData().getDimensionInfo(n.getD=
ata().mapDimension(t))||{}),{name:t,ordinalMeta:null})}):[{name:"value",typ=
e:"float"}],i=3Dnew Cv(p,u),o=3Dnew Cv(p,u),s=3Dnew Cv([],u),u=3DF(u.get("d=
ata"),M(aT,n,l,u)),l&&(u=3Dut(u,M(hT,l))),l=3Dfunction(t,o){return t?functi=
on(t,e,n,i){return Xf(i<2?t.coord&&t.coord[i]:t.value,o[i])}:function(t,e,n=
,i){return Xf(t.value,o[i])}}(!!l,p),i.initData(F(u,function(t){return t[0]=
}),null,l),o.initData(F(u,function(t){return t[1]}),null,l),s.initData(F(u,=
function(t){return t[2]})),s.hasItemOption=3D!0,{from:i,to:o,line:s}),d=3Dp=
.from,f=3Dp.to,g=3Dp.line,y=3D(sT(e).from=3Dd,sT(e).to=3Df,e.setData(g),e.g=
et("symbol")),m=3De.get("symbolSize"),v=3De.get("symbolRotate"),_=3De.get("=
symbolOffset");function x(t,e,n){var i=3Dt.getItemModel(e),o=3D(cT(t,e,n,r,=
a),i.getModel("itemStyle").getItemStyle());null=3D=3Do.fill&&(o.fill=3DXy(h=
,"color")),t.setItemVisual(e,{symbolKeepAspect:i.get("symbolKeepAspect"),sy=
mbolOffset:R(i.get("symbolOffset",!0),_[n?0:1]),symbolRotate:R(i.get("symbo=
lRotate",!0),v[n?0:1]),symbolSize:R(i.get("symbolSize"),m[n?0:1]),symbol:R(=
i.get("symbol",!0),y[n?0:1]),style:o})}V(y)||(y=3D[y,y]),V(m)||(m=3D[m,m]),=
V(v)||(v=3D[v,v]),V(_)||(_=3D[_,_]),p.from.each(function(t){x(d,t,!0),x(f,t=
,!1)}),g.each(function(t){var e=3Dg.getItemModel(t).getModel("lineStyle").g=
etLineStyle();g.setItemLayout(t,[d.getItemLayout(t),f.getItemLayout(t)]),nu=
ll=3D=3De.stroke&&(e.stroke=3Dd.getItemVisual(t,"style").fill),g.setItemVis=
ual(t,{fromSymbolKeepAspect:d.getItemVisual(t,"symbolKeepAspect"),fromSymbo=
lOffset:d.getItemVisual(t,"symbolOffset"),fromSymbolRotate:d.getItemVisual(=
t,"symbolRotate"),fromSymbolSize:d.getItemVisual(t,"symbolSize"),fromSymbol=
:d.getItemVisual(t,"symbol"),toSymbolKeepAspect:f.getItemVisual(t,"symbolKe=
epAspect"),toSymbolOffset:f.getItemVisual(t,"symbolOffset"),toSymbolRotate:=
f.getItemVisual(t,"symbolRotate"),toSymbolSize:f.getItemVisual(t,"symbolSiz=
e"),toSymbol:f.getItemVisual(t,"symbol"),style:e})}),c.updateData(g),p.line=
.eachItemGraphicEl(function(t){k(t).dataModel=3De,t.traverse(function(t){k(=
t).dataModel=3De})}),this.markKeep(c),c.group.silent=3De.get("silent")||r.g=
et("silent")},fT.type=3D"markLine";var pT,dT=3DfT;function fT(){var t=3Dnul=
l!=3D=3DpT&&pT.apply(this,arguments)||this;return t.type=3DfT.type,t}U_(fun=
ction(t){t.registerComponentModel(CM),t.registerComponentView(dT),t.registe=
rPreprocessor(function(t){!function(t,e){if(t)for(var n=3DV(t)?t:[t],i=3D0;=
i<n.length;i++)if(n[i]&&n[i][e])return 1}(t.series,"markLine")||(t.markLine=
=3Dt.markLine||{})})});var gT=3D["x","y","radius","angle","single"],yT=3D["=
cartesian2d","polar","singleAxis"];function mT(t){return t+"Axis"}function =
vT(t,e){var i,o=3DN(),n=3D[],r=3DN();for(t.eachComponent({mainType:"dataZoo=
m",query:e},function(t){r.get(t.uid)||s(t)});i=3D!1,t.eachComponent("dataZo=
om",a),i;);function a(t){var n;!r.get(t.uid)&&(n=3D!1,t.eachTargetAxis(func=
tion(t,e){t=3Do.get(t);t&&t[e]&&(n=3D!0)}),n)&&(s(t),i=3D!0)}function s(t){=
r.set(t.uid,!0),n.push(t),t.eachTargetAxis(function(t,e){(o.get(t)||o.set(t=
,[]))[e]=3D!0})}return n}function _T(t){var o=3Dt.ecModel,r=3D{infoList:[],=
infoMap:N()};return t.eachTargetAxis(function(t,e){var n,i,t=3Do.getCompone=
nt(mT(t),e);t&&(e=3Dt.getCoordSysModel())&&(n=3De.uid,(i=3Dr.infoMap.get(n)=
)||(r.infoList.push(i=3D{model:e,axisModels:[]}),r.infoMap.set(n,i)),i.axis=
Models.push(t))}),r}ST.prototype.add=3Dfunction(t){this.indexMap[t]||(this.=
indexList.push(t),this.indexMap[t]=3D!0)};var xT,wT=3DST,gh=3D(u(bT,xT=3Dg)=
,bT.prototype.init=3Dfunction(t,e,n){var i=3DMT(t);this.settledOption=3Di,t=
his.mergeDefaultAndTheme(t,n),this._doInit(i)},bT.prototype.mergeOption=3Df=
unction(t){var e=3DMT(t);d(this.option,t,!0),d(this.settledOption,e,!0),thi=
s._doInit(e)},bT.prototype._doInit=3Dfunction(t){var n=3Dthis.option,i=3D(t=
his._setDefaultThrottle(t),this._updateRangeUse(t),this.settledOption);E([[=
"start","startValue"],["end","endValue"]],function(t,e){"value"=3D=3D=3Dthi=
s._rangePropMode[e]&&(n[t[0]]=3Di[t[0]]=3Dnull)},this),this._resetTarget()}=
,bT.prototype._resetTarget=3Dfunction(){var t=3Dthis.get("orient",!0),e=3Dt=
his._targetAxisInfoMap=3DN();this._fillSpecifiedTargetAxis(e)?this._orient=
=3Dt||this._makeAutoOrientByTargetAxis():(this._orient=3Dt||"horizontal",th=
is._fillAutoTargetAxisByOrient(e,this._orient)),this._noTarget=3D!0,e.each(=
function(t){t.indexList.length&&(this._noTarget=3D!1)},this)},bT.prototype.=
_fillSpecifiedTargetAxis=3Dfunction(i){var o=3D!1;return E(gT,function(t){v=
ar e,n=3Dthis.getReferringComponents(mT(t),Fr);n.specified&&(o=3D!0,e=3Dnew=
 wT,E(n.models,function(t){e.add(t.componentIndex)}),i.set(t,e))},this),o},=
bT.prototype._fillAutoTargetAxisByOrient=3Dfunction(r,e){var t,i=3Dthis.ecM=
odel,a=3D!0;function n(t,e){var n,i,o=3Dt[0];o&&((n=3Dnew wT).add(o.compone=
ntIndex),r.set(e,n),a=3D!1,"x"!=3D=3De&&"y"!=3D=3De||(i=3Do.getReferringCom=
ponents("grid",Br).models[0])&&E(t,function(t){o.componentIndex!=3D=3Dt.com=
ponentIndex&&i=3D=3D=3Dt.getReferringComponents("grid",Br).models[0]&&n.add=
(t.componentIndex)}))}a&&n(i.findComponents({mainType:(t=3D"vertical"=3D=3D=
=3De?"y":"x")+"Axis"}),t),a&&n(i.findComponents({mainType:"singleAxis",filt=
er:function(t){return t.get("orient",!0)=3D=3D=3De}}),"single"),a&&E(gT,fun=
ction(t){var e,n;a&&(e=3Di.findComponents({mainType:mT(t),filter:function(t=
){return"category"=3D=3D=3Dt.get("type",!0)}}))[0]&&((n=3Dnew wT).add(e[0].=
componentIndex),r.set(t,n),a=3D!1)},this)},bT.prototype._makeAutoOrientByTa=
rgetAxis=3Dfunction(){var e;return this.eachTargetAxis(function(t){e=3De||t=
},this),"y"=3D=3D=3De?"vertical":"horizontal"},bT.prototype._setDefaultThro=
ttle=3Dfunction(t){t.hasOwnProperty("throttle")&&(this._autoThrottle=3D!1),=
this._autoThrottle&&(t=3Dthis.ecModel.option,this.option.throttle=3Dt.anima=
tion&&0<t.animationDurationUpdate?100:20)},bT.prototype._updateRangeUse=3Df=
unction(i){var o=3Dthis._rangePropMode,r=3Dthis.get("rangeMode");E([["start=
","startValue"],["end","endValue"]],function(t,e){var n=3Dnull!=3Di[t[0]],t=
=3Dnull!=3Di[t[1]];n&&!t?o[e]=3D"percent":!n&&t?o[e]=3D"value":r?o[e]=3Dr[e=
]:n&&(o[e]=3D"percent")})},bT.prototype.noTarget=3Dfunction(){return this._=
noTarget},bT.prototype.getFirstTargetAxisModel=3Dfunction(){var n;return th=
is.eachTargetAxis(function(t,e){null=3D=3Dn&&(n=3Dthis.ecModel.getComponent=
(mT(t),e))},this),n},bT.prototype.eachTargetAxis=3Dfunction(n,i){this._targ=
etAxisInfoMap.each(function(t,e){E(t.indexList,function(t){n.call(i,e,t)})}=
)},bT.prototype.getAxisProxy=3Dfunction(t,e){t=3Dthis.getAxisModel(t,e);if(=
t)return t.__dzAxisProxy},bT.prototype.getAxisModel=3Dfunction(t,e){var n=
=3Dthis._targetAxisInfoMap.get(t);if(n&&n.indexMap[e])return this.ecModel.g=
etComponent(mT(t),e)},bT.prototype.setRawRange=3Dfunction(e){var n=3Dthis.o=
ption,i=3Dthis.settledOption;E([["start","startValue"],["end","endValue"]],=
function(t){null=3D=3De[t[0]]&&null=3D=3De[t[1]]||(n[t[0]]=3Di[t[0]]=3De[t[=
0]],n[t[1]]=3Di[t[1]]=3De[t[1]])},this),this._updateRangeUse(e)},bT.prototy=
pe.setCalculatedRange=3Dfunction(e){var n=3Dthis.option;E(["start","startVa=
lue","end","endValue"],function(t){n[t]=3De[t]})},bT.prototype.getPercentRa=
nge=3Dfunction(){var t=3Dthis.findRepresentativeAxisProxy();if(t)return t.g=
etDataPercentWindow()},bT.prototype.getValueRange=3Dfunction(t,e){return nu=
ll!=3Dt||null!=3De?this.getAxisProxy(t,e).getDataValueWindow():(t=3Dthis.fi=
ndRepresentativeAxisProxy())?t.getDataValueWindow():void 0},bT.prototype.fi=
ndRepresentativeAxisProxy=3Dfunction(t){if(t)return t.__dzAxisProxy;for(var=
 e,n=3Dthis._targetAxisInfoMap.keys(),i=3D0;i<n.length;i++)for(var o=3Dn[i]=
,r=3Dthis._targetAxisInfoMap.get(o),a=3D0;a<r.indexList.length;a++){var s=
=3Dthis.getAxisProxy(o,r.indexList[a]);if(s.hostedBy(this))return s;e=3De||=
s}return e},bT.prototype.getRangePropMode=3Dfunction(){return this._rangePr=
opMode.slice()},bT.prototype.getOrient=3Dfunction(){return this._orient},bT=
.type=3D"dataZoom",bT.dependencies=3D["xAxis","yAxis","radiusAxis","angleAx=
is","singleAxis","series","toolbox"],bT.defaultOption=3D{z:4,filterMode:"fi=
lter",start:0,end:100},bT);function bT(){var t=3Dnull!=3D=3DxT&&xT.apply(th=
is,arguments)||this;return t.type=3DbT.type,t._autoThrottle=3D!0,t._noTarge=
t=3D!0,t._rangePropMode=3D["percent","percent"],t}function ST(){this.indexL=
ist=3D[],this.indexMap=3D[]}function MT(e){var n=3D{};return E(["start","en=
d","startValue","endValue","throttle"],function(t){e.hasOwnProperty(t)&&(n[=
t]=3De[t])}),n}u(CT,TT=3Dgh),CT.type=3D"dataZoom.inside",CT.defaultOption=
=3DUc(gh.defaultOption,{disabled:!1,zoomLock:!1,zoomOnMouseWheel:!0,moveOnM=
ouseMove:!0,moveOnMouseWheel:!1,preventDefaultMouseMove:!0});var TT,IT=3DCT=
;function CT(){var t=3Dnull!=3D=3DTT&&TT.apply(this,arguments)||this;return=
 t.type=3DCT.type,t}u(kT,DT=3D$g),kT.prototype.render=3Dfunction(t,e,n,i){t=
his.dataZoomModel=3Dt,this.ecModel=3De,this.api=3Dn},kT.type=3D"dataZoom";v=
ar DT,wu=3DkT;function kT(){var t=3Dnull!=3D=3DDT&&DT.apply(this,arguments)=
||this;return t.type=3DkT.type,t}function AT(t,e,n,i,o,r){t=3Dt||0;var a=3D=
n[1]-n[0],a=3D(null!=3Do&&(o=3DPT(o,[0,a])),null!=3Dr&&(r=3DMath.max(r,null=
!=3Do?o:0)),"all"=3D=3D=3Di&&(s=3DPT(s=3DMath.abs(e[1]-e[0]),[0,a]),o=3Dr=
=3DPT(s,[o,r]),i=3D0),e[0]=3DPT(e[0],n),e[1]=3DPT(e[1],n),LT(e,i));e[i]+=3D=
t;var s=3Do||0,t=3Dn.slice();a.sign<0?t[0]+=3Ds:t[1]-=3Ds,e[i]=3DPT(e[i],t)=
,n=3DLT(e,i),null!=3Do&&(n.sign!=3D=3Da.sign||n.span<o)&&(e[1-i]=3De[i]+a.s=
ign*o),n=3DLT(e,i),null!=3Dr&&n.span>r&&(e[1-i]=3De[i]+n.sign*r)}function L=
T(t,e){t=3Dt[e]-t[1-e];return{span:Math.abs(t),sign:0<t||!(t<0)&&e?-1:1}}fu=
nction PT(t,e){return Math.min(null!=3De[1]?e[1]:1/0,Math.max(null!=3De[0]?=
e[0]:-1/0,t))}var OT=3D"\0_ec_interaction_mutex";function RT(t,e){return((t=
=3Dt)[OT]||(t[OT]=3D{}))[e]}X0({type:"takeGlobalCursor",event:"globalCursor=
Taken",update:"update"},zt);u(zT,NT=3Dae),zT.prototype.isDragging=3Dfunctio=
n(){return this._dragging},zT.prototype.isPinching=3Dfunction(){return this=
._pinching},zT.prototype.setPointerChecker=3Dfunction(t){this.pointerChecke=
r=3Dt},zT.prototype.dispose=3Dfunction(){this.disable()},zT.prototype._mous=
edownHandler=3Dfunction(t){if(!Ie(t)){for(var e=3Dt.target;e;){if(e.draggab=
le)return;e=3De.__hostTarget||e.parent}var n=3Dt.offsetX,i=3Dt.offsetY;this=
.pointerChecker&&this.pointerChecker(t,n,i)&&(this._x=3Dn,this._y=3Di,this.=
_dragging=3D!0)}},zT.prototype._mousemoveHandler=3Dfunction(t){var e,n,i,o,=
r,a;this._dragging&&VT("moveOnMouseMove",t,this._opt)&&"pinch"!=3D=3Dt.gest=
ureEvent&&!RT(this._zr,"globalPan")&&(e=3Dt.offsetX,n=3Dt.offsetY,r=3De-(i=
=3Dthis._x),a=3Dn-(o=3Dthis._y),this._x=3De,this._y=3Dn,this._opt.preventDe=
faultMouseMove&&Te(t.event),FT(this,"pan","moveOnMouseMove",t,{dx:r,dy:a,ol=
dX:i,oldY:o,newX:e,newY:n,isAvailableBehavior:null}))},zT.prototype._mouseu=
pHandler=3Dfunction(t){Ie(t)||(this._dragging=3D!1)},zT.prototype._mousewhe=
elHandler=3Dfunction(t){var e=3DVT("zoomOnMouseWheel",t,this._opt),n=3DVT("=
moveOnMouseWheel",t,this._opt),i=3Dt.wheelDelta,o=3DMath.abs(i),r=3Dt.offse=
tX,a=3Dt.offsetY;0!=3D=3Di&&(e||n)&&(e&&(e=3D3<o?1.4:1<o?1.2:1.1,BT(this,"z=
oom","zoomOnMouseWheel",t,{scale:0<i?e:1/e,originX:r,originY:a,isAvailableB=
ehavior:null})),n)&&BT(this,"scrollMove","moveOnMouseWheel",t,{scrollDelta:=
(0<i?1:-1)*(3<(o=3DMath.abs(i))?.4:1<o?.15:.05),originX:r,originY:a,isAvail=
ableBehavior:null})},zT.prototype._pinchHandler=3Dfunction(t){RT(this._zr,"=
globalPan")||BT(this,"zoom",null,t,{scale:1<t.pinchScale?1.1:1/1.1,originX:=
t.pinchX,originY:t.pinchY,isAvailableBehavior:null})};var NT,ET=3DzT;functi=
on zT(n){var t=3DNT.call(this)||this,i=3D(t._zr=3Dn,S(t._mousedownHandler,t=
)),o=3DS(t._mousemoveHandler,t),r=3DS(t._mouseupHandler,t),a=3DS(t._mousewh=
eelHandler,t),s=3DS(t._pinchHandler,t);return t.enable=3Dfunction(t,e){this=
.disable(),this._opt=3DB(y(e)||{},{zoomOnMouseWheel:!0,moveOnMouseMove:!0,m=
oveOnMouseWheel:!1,preventDefaultMouseMove:!0}),!0!=3D=3D(t=3Dnull=3D=3Dt?!=
0:t)&&"move"!=3D=3Dt&&"pan"!=3D=3Dt||(n.on("mousedown",i),n.on("mousemove",=
o),n.on("mouseup",r)),!0!=3D=3Dt&&"scale"!=3D=3Dt&&"zoom"!=3D=3Dt||(n.on("m=
ousewheel",a),n.on("pinch",s))},t.disable=3Dfunction(){n.off("mousedown",i)=
,n.off("mousemove",o),n.off("mouseup",r),n.off("mousewheel",a),n.off("pinch=
",s)},t}function BT(t,e,n,i,o){t.pointerChecker&&t.pointerChecker(i,o.origi=
nX,o.originY)&&(Te(i.event),FT(t,e,n,i,o))}function FT(t,e,n,i,o){o.isAvail=
ableBehavior=3DS(VT,null,n,i),t.trigger(e,o)}function VT(t,e,n){n=3Dn[t];re=
turn!t||n&&(!H(n)||e.event[n+"Key"])}var HT=3DRr();function WT(t,e){e&&(t.r=
emoveKey(e.model.uid),t=3De.controller)&&t.dispose()}function GT(t,e){t.isD=
isposed()||t.dispatchAction({type:"dataZoom",animation:{easing:"cubicOut",d=
uration:100},batch:e})}function XT(t,e,n,i){return t.coordinateSystem.conta=
inPoint([n,i])}function UT(t){t.registerProcessor(t.PRIORITY.PROCESSOR.FILT=
ER,function(t,a){var e=3DHT(a),l=3De.coordSysRecordMap||(e.coordSysRecordMa=
p=3DN());l.each(function(t){t.dataZoomInfoMap=3Dnull}),t.eachComponent({mai=
nType:"dataZoom",subType:"inside"},function(o){E(_T(o).infoList,function(t)=
{var r,e,n=3Dt.model.uid,i=3Dl.get(n)||l.set(n,(n=3Da,i=3Dt.model,r=3D{mode=
l:i,containsPoint:M(XT,i),dispatchAction:M(GT,n),dataZoomInfoMap:null,contr=
oller:null},e=3Dr.controller=3Dnew ET(n.getZr()),E(["pan","zoom","scrollMov=
e"],function(o){e.on(o,function(n){var i=3D[];r.dataZoomInfoMap.each(functi=
on(t){var e;n.isAvailableBehavior(t.model.option)&&(e=3D(e=3D(t.getRange||{=
})[o])&&e(t.dzReferCoordSysInfo,r.model.mainType,r.controller,n),!t.model.g=
et("disabled",!0))&&e&&i.push({dataZoomId:t.model.id,start:e[0],end:e[1]})}=
),i.length&&r.dispatchAction(i)})}),r));(i.dataZoomInfoMap||(i.dataZoomInfo=
Map=3DN())).set(o.uid,{dzReferCoordSysInfo:t,model:o,getRange:null})})}),l.=
each(function(t){var e,n,i,o,r,a=3Dt.controller,s=3Dt.dataZoomInfoMap;(e=3D=
s&&null!=3D(n=3Ds.keys()[0])?s.get(n):e)?(o=3D{type_true:2,type_move:1,type=
_false:0,type_undefined:-1},r=3D!0,s.each(function(t){var t=3Dt.model,e=3D!=
t.get("disabled",!0)&&(!t.get("zoomLock",!0)||"move");o["type_"+i]<o["type_=
"+e]&&(i=3De),r=3Dr&&t.get("preventDefaultMouseMove",!0)}),n=3D{controlType=
:i,opt:{zoomOnMouseWheel:!0,moveOnMouseMove:!0,moveOnMouseWheel:!0,preventD=
efaultMouseMove:!!r}},a.enable(n.controlType,n.opt),a.setPointerChecker(t.c=
ontainsPoint),dy(t,"dispatchAction",e.model.get("throttle",!0),"fixRate")):=
WT(l,t)})})}u(jT,YT=3Dwu),jT.prototype.render=3Dfunction(t,e,n){var i,o;YT.=
prototype.render.apply(this,arguments),t.noTarget()?this._clear():(this.ran=
ge=3Dt.getPercentRange(),n=3Dn,i=3Dt,o=3D{pan:S(qT.pan,this),zoom:S(qT.zoom=
,this),scrollMove:S(qT.scrollMove,this)},HT(n).coordSysRecordMap.each(funct=
ion(t){t=3Dt.dataZoomInfoMap.get(i.uid);t&&(t.getRange=3Do)}))},jT.prototyp=
e.dispose=3Dfunction(){this._clear(),YT.prototype.dispose.apply(this,argume=
nts)},jT.prototype._clear=3Dfunction(){for(var t=3Dthis.api,e=3Dthis.dataZo=
omModel,n=3DHT(t).coordSysRecordMap,i=3Dn.keys(),o=3D0;o<i.length;o++){var =
r,a=3Di[o],a=3Dn.get(a),s=3Da.dataZoomInfoMap;s&&(r=3De.uid,s.get(r))&&(s.r=
emoveKey(r),s.keys().length||WT(n,a))}this.range=3Dnull},jT.type=3D"dataZoo=
m.inside";var YT,ZT=3DjT,qT=3D{zoom:function(t,e,n,i){var o=3Dthis.range,r=
=3Do.slice(),a=3Dt.axisModels[0];if(a)return a=3D(0<(e=3D$T[e](null,[i.orig=
inX,i.originY],a,n,t)).signal?e.pixelStart+e.pixelLength-e.pixel:e.pixel-e.=
pixelStart)/e.pixelLength*(r[1]-r[0])+r[0],n=3DMath.max(1/i.scale,0),r[0]=
=3D(r[0]-a)*n+a,r[1]=3D(r[1]-a)*n+a,AT(0,r,[0,100],0,(t=3Dthis.dataZoomMode=
l.findRepresentativeAxisProxy().getMinMaxSpan()).minSpan,t.maxSpan),this.ra=
nge=3Dr,o[0]!=3D=3Dr[0]||o[1]!=3D=3Dr[1]?r:void 0},pan:KT(function(t,e,n,i,=
o,r){i=3D$T[i]([r.oldX,r.oldY],[r.newX,r.newY],e,o,n);return i.signal*(t[1]=
-t[0])*i.pixel/i.pixelLength}),scrollMove:KT(function(t,e,n,i,o,r){return $=
T[i]([0,0],[r.scrollDelta,r.scrollDelta],e,o,n).signal*(t[1]-t[0])*r.scroll=
Delta})};function jT(){var t=3Dnull!=3D=3DYT&&YT.apply(this,arguments)||thi=
s;return t.type=3D"dataZoom.inside",t}function KT(s){return function(t,e,n,=
i){var o=3Dthis.range,r=3Do.slice(),a=3Dt.axisModels[0];if(a)return AT(s(r,=
a,t,e,n,i),r,[0,100],"all"),this.range=3Dr,o[0]!=3D=3Dr[0]||o[1]!=3D=3Dr[1]=
?r:void 0}}var $T=3D{grid:function(t,e,n,i,o){var n=3Dn.axis,r=3D{},o=3Do.m=
odel.coordinateSystem.getRect();return t=3Dt||[0,0],"x"=3D=3D=3Dn.dim?(r.pi=
xel=3De[0]-t[0],r.pixelLength=3Do.width,r.pixelStart=3Do.x,r.signal=3Dn.inv=
erse?1:-1):(r.pixel=3De[1]-t[1],r.pixelLength=3Do.height,r.pixelStart=3Do.y=
,r.signal=3Dn.inverse?-1:1),r},polar:function(t,e,n,i,o){var r=3Dn.axis,a=
=3D{},o=3Do.model.coordinateSystem,s=3Do.getRadiusAxis().getExtent(),l=3Do.=
getAngleAxis().getExtent();return t=3Dt?o.pointToCoord(t):[0,0],e=3Do.point=
ToCoord(e),"radiusAxis"=3D=3D=3Dn.mainType?(a.pixel=3De[0]-t[0],a.pixelLeng=
th=3Ds[1]-s[0],a.pixelStart=3Ds[0],a.signal=3Dr.inverse?1:-1):(a.pixel=3De[=
1]-t[1],a.pixelLength=3Dl[1]-l[0],a.pixelStart=3Dl[0],a.signal=3Dr.inverse?=
-1:1),a},singleAxis:function(t,e,n,i,o){var n=3Dn.axis,o=3Do.model.coordina=
teSystem.getRect(),r=3D{};return t=3Dt||[0,0],"horizontal"=3D=3D=3Dn.orient=
?(r.pixel=3De[0]-t[0],r.pixelLength=3Do.width,r.pixelStart=3Do.x,r.signal=
=3Dn.inverse?1:-1):(r.pixel=3De[1]-t[1],r.pixelLength=3Do.height,r.pixelSta=
rt=3Do.y,r.signal=3Dn.inverse?-1:1),r}},QT=3DE,JT=3Dir,t2=3D(e2.prototype.h=
ostedBy=3Dfunction(t){return this._dataZoomModel=3D=3D=3Dt},e2.prototype.ge=
tDataValueWindow=3Dfunction(){return this._valueWindow.slice()},e2.prototyp=
e.getDataPercentWindow=3Dfunction(){return this._percentWindow.slice()},e2.=
prototype.getTargetSeriesModels=3Dfunction(){var n=3D[];return this.ecModel=
.eachSeries(function(t){var e;e=3D(e=3Dt).get("coordinateSystem"),0<=3DC(yT=
,e)&&(e=3DmT(this._dimName),e=3Dt.getReferringComponents(e,Br).models[0])&&=
this._axisIndex=3D=3D=3De.componentIndex&&n.push(t)},this),n},e2.prototype.=
getAxisModel=3Dfunction(){return this.ecModel.getComponent(this._dimName+"A=
xis",this._axisIndex)},e2.prototype.getMinMaxSpan=3Dfunction(){return y(thi=
s._minMaxSpan)},e2.prototype.calculateDataWindow=3Dfunction(i){var o,r=3Dth=
is._dataExtent,s=3Dthis.getAxisModel().axis.scale,a=3Dthis._dataZoomModel.g=
etRangePropMode(),l=3D[0,100],u=3D[],h=3D[],c=3D(QT(["start","end"],functio=
n(t,e){var n=3Di[t],t=3Di[t+"Value"];"percent"=3D=3D=3Da[e]?t=3Ds.parse(tr(=
n=3Dnull=3D=3Dn?l[e]:n,l,r)):(o=3D!0,n=3Dtr(t=3Dnull=3D=3Dt?r[e]:s.parse(t)=
,r,l)),h[e]=3Dnull=3D=3Dt||isNaN(t)?r[e]:t,u[e]=3Dnull=3D=3Dn||isNaN(n)?l[e=
]:n}),JT(h),JT(u),this._minMaxSpan);function t(t,e,n,i,o){var r=3Do?"Span":=
"ValueSpan";AT(0,t,n,"all",c["min"+r],c["max"+r]);for(var a=3D0;a<2;a++)e[a=
]=3Dtr(t[a],n,i,!0),o&&(e[a]=3Ds.parse(e[a]))}return o?t(h,u,r,l,!1):t(u,h,=
l,r,!0),{valueWindow:h,percentWindow:u}},e2.prototype.reset=3Dfunction(t){v=
ar e,i,n,o;t=3D=3D=3Dthis._dataZoomModel&&(n=3Dthis.getTargetSeriesModels()=
,this._dataExtent=3D(i=3D(e=3Dthis)._dimName,o=3D[1/0,-1/0],QT(n=3Dn,functi=
on(t){var e,n;e=3Do,n=3Dt.getData(),t=3Di,n&&E(V_(n,t),function(t){t=3Dn.ge=
tApproximateExtent(t);t[0]<e[0]&&(e[0]=3Dt[0]),t[1]>e[1]&&(e[1]=3Dt[1])})})=
,[(e=3DA_((n=3De.getAxisModel()).axis.scale,n,o).calculate()).min,e.max]),t=
his._updateMinMaxSpan(),n=3Dthis.calculateDataWindow(t.settledOption),this.=
_valueWindow=3Dn.valueWindow,this._percentWindow=3Dn.percentWindow,this._se=
tAxisModel())},e2.prototype.filterData=3Dfunction(t,e){var o,n,r,c;t=3D=3D=
=3Dthis._dataZoomModel&&(o=3Dthis._dimName,n=3Dthis.getTargetSeriesModels()=
,r=3Dt.get("filterMode"),c=3Dthis._valueWindow,"none"!=3D=3Dr)&&QT(n,functi=
on(n){var l,u,i=3Dn.getData(),h=3Di.mapDimensionsAll(o);h.length&&("weakFil=
ter"=3D=3D=3Dr?(l=3Di.getStore(),u=3DF(h,function(t){return i.getDimensionI=
ndex(t)},i),i.filterSelf(function(t){for(var e,n,i,o=3D0;o<h.length;o++){va=
r r=3Dl.get(u[o],t),a=3D!isNaN(r),s=3Dr<c[0],r=3Dr>c[1];if(a&&!s&&!r)return=
!0;a&&(i=3D!0),s&&(e=3D!0),r&&(n=3D!0)}return i&&e&&n})):QT(h,function(t){v=
ar e;"empty"=3D=3D=3Dr?n.setData(i=3Di.map(t,function(t){return t>=3Dc[0]&&=
t<=3Dc[1]?t:NaN})):((e=3D{})[t]=3Dc,i.selectRange(e))}),QT(h,function(t){i.=
setApproximateExtent(c,t)}))})},e2.prototype._updateMinMaxSpan=3Dfunction()=
{var i=3Dthis._minMaxSpan=3D{},o=3Dthis._dataZoomModel,r=3Dthis._dataExtent=
;QT(["min","max"],function(t){var e=3Do.get(t+"Span"),n=3Do.get(t+"ValueSpa=
n");null!=3D(n=3Dnull!=3Dn?this.getAxisModel().axis.scale.parse(n):n)?e=3Dt=
r(r[0]+n,r,[0,100],!0):null!=3De&&(n=3Dtr(e,[0,100],r,!0)-r[0]),i[t+"Span"]=
=3De,i[t+"ValueSpan"]=3Dn},this)},e2.prototype._setAxisModel=3Dfunction(){v=
ar t,e=3Dthis.getAxisModel(),n=3Dthis._percentWindow,i=3Dthis._valueWindow;=
n&&(t=3Dar(i,[0,500]),t=3DMath.min(t,20),e=3De.axis.scale.rawExtentInfo,0!=
=3D=3Dn[0]&&e.setDeterminedMinMax("min",+i[0].toFixed(t)),100!=3D=3Dn[1]&&e=
.setDeterminedMinMax("max",+i[1].toFixed(t)),e.freeze())},e2);function e2(t=
,e,n,i){this._dimName=3Dt,this._axisIndex=3De,this.ecModel=3Di,this._dataZo=
omModel=3Dn}var n2=3D{getTargetSeries:function(r){function t(o){r.eachCompo=
nent("dataZoom",function(i){i.eachTargetAxis(function(t,e){var n=3Dr.getCom=
ponent(mT(t),e);o(t,e,n,i)})})}t(function(t,e,n,i){n.__dzAxisProxy=3Dnull})=
;var o=3D[],e=3D(t(function(t,e,n,i){n.__dzAxisProxy||(n.__dzAxisProxy=3Dne=
w t2(t,e,i,r),o.push(n.__dzAxisProxy))}),N());return E(o,function(t){E(t.ge=
tTargetSeriesModels(),function(t){e.set(t.uid,t)})}),e},overallReset:functi=
on(t,i){t.eachComponent("dataZoom",function(n){n.eachTargetAxis(function(t,=
e){n.getAxisProxy(t,e).reset(n)}),n.eachTargetAxis(function(t,e){n.getAxisP=
roxy(t,e).filterData(n,i)})}),t.eachComponent("dataZoom",function(t){var e,=
n=3Dt.findRepresentativeAxisProxy();n&&(e=3Dn.getDataPercentWindow(),n=3Dn.=
getDataValueWindow(),t.setCalculatedRange({start:e[0],end:e[1],startValue:n=
[0],endValue:n[1]}))})}};var i2=3D!1;function o2(t){i2||(i2=3D!0,t.register=
Processor(t.PRIORITY.PROCESSOR.FILTER,n2),t.registerAction("dataZoom",funct=
ion(e,t){E(vT(t,e),function(t){t.setRawRange({start:e.start,end:e.end,start=
Value:e.startValue,endValue:e.endValue})})}),t.registerSubTypeDefaulter("da=
taZoom",function(){return"slider"}))}function r2(t){o2(t),t.registerCompone=
ntModel(IT),t.registerComponentView(ZT),UT(t)}u(l2,a2=3Dgh),l2.type=3D"data=
Zoom.slider",l2.layoutMode=3D"box",l2.defaultOption=3DUc(gh.defaultOption,{=
show:!0,right:"ph",top:"ph",width:"ph",height:"ph",left:null,bottom:null,bo=
rderColor:"#d2dbee",borderRadius:3,backgroundColor:"rgba(47,69,84,0)",dataB=
ackground:{lineStyle:{color:"#d2dbee",width:.5},areaStyle:{color:"#d2dbee",=
opacity:.2}},selectedDataBackground:{lineStyle:{color:"#8fb0f7",width:.5},a=
reaStyle:{color:"#8fb0f7",opacity:.2}},fillerColor:"rgba(135,175,274,0.2)",=
handleIcon:"path://M-9.35,34.56V42m0-40V9.5m-2,0h4a2,2,0,0,1,2,2v21a2,2,0,0=
,1-2,2h-4a2,2,0,0,1-2-2v-21A2,2,0,0,1-11.35,9.5Z",handleSize:"100%",handleS=
tyle:{color:"#fff",borderColor:"#ACB8D1"},moveHandleSize:7,moveHandleIcon:"=
path://M-320.9-50L-320.9-50c18.1,0,27.1,9,27.1,27.1V85.7c0,18.1-9,27.1-27.1=
,27.1l0,0c-18.1,0-27.1-9-27.1-27.1V-22.9C-348-41-339-50-320.9-50z M-212.3-5=
0L-212.3-50c18.1,0,27.1,9,27.1,27.1V85.7c0,18.1-9,27.1-27.1,27.1l0,0c-18.1,=
0-27.1-9-27.1-27.1V-22.9C-239.4-41-230.4-50-212.3-50z M-103.7-50L-103.7-50c=
18.1,0,27.1,9,27.1,27.1V85.7c0,18.1-9,27.1-27.1,27.1l0,0c-18.1,0-27.1-9-27.=
1-27.1V-22.9C-130.9-41-121.8-50-103.7-50z",moveHandleStyle:{color:"#D2DBEE"=
,opacity:.7},showDetail:!0,showDataShadow:"auto",realtime:!0,zoomLock:!1,te=
xtStyle:{color:"#6E7079"},brushSelect:!0,brushStyle:{color:"rgba(135,175,27=
4,0.15)"},emphasis:{handleStyle:{borderColor:"#8FB0F7"},moveHandleStyle:{co=
lor:"#8FB0F7"}}});var a2,s2=3Dl2;function l2(){var t=3Dnull!=3D=3Da2&&a2.ap=
ply(this,arguments)||this;return t.type=3Dl2.type,t}var u2,h2=3DEs,c2=3D"ho=
rizontal",p2=3D"vertical",d2=3D["line","bar","candlestick","scatter"],f2=3D=
{easing:"cubicOut",duration:100,delay:0},g2=3D(u(m,u2=3Dwu),m.prototype.ini=
t=3Dfunction(t,e){this.api=3De,this._onBrush=3DS(this._onBrush,this),this._=
onBrushEnd=3DS(this._onBrushEnd,this)},m.prototype.render=3Dfunction(t,e,n,=
i){u2.prototype.render.apply(this,arguments),dy(this,"_dispatchZoomAction",=
t.get("throttle"),"fixRate"),this._orient=3Dt.getOrient(),!1!=3D=3Dt.get("s=
how")?t.noTarget()?(this._clear(),this.group.removeAll()):(i&&"dataZoom"=3D=
=3D=3Di.type&&i.from=3D=3D=3Dthis.uid||this._buildView(),this._updateView()=
):this.group.removeAll()},m.prototype.dispose=3Dfunction(){this._clear(),u2=
.prototype.dispose.apply(this,arguments)},m.prototype._clear=3Dfunction(){f=
y(this,"_dispatchZoomAction");var t=3Dthis.api.getZr();t.off("mousemove",th=
is._onBrush),t.off("mouseup",this._onBrushEnd)},m.prototype._buildView=3Dfu=
nction(){var t=3Dthis.group,e=3D(t.removeAll(),this._brushing=3D!1,this._di=
splayables.brushRect=3Dnull,this._resetLocation(),this._resetInterval(),thi=
s._displayables.sliderGroup=3Dnew Wo);this._renderBackground(),this._render=
Handle(),this._renderDataShadow(),t.add(e),this._positionGroup()},m.prototy=
pe._resetLocation=3Dfunction(){var t=3Dthis.dataZoomModel,e=3Dthis.api,n=3D=
t.get("brushSelect")?7:0,i=3Dthis._findCoordRect(),e=3D{width:e.getWidth(),=
height:e.getHeight()},o=3Dthis._orient=3D=3D=3Dc2?{right:e.width-i.x-i.widt=
h,top:e.height-30-7-n,width:i.width,height:30}:{right:7,top:i.y,width:30,he=
ight:i.height},r=3DGp(t.option),n=3D(E(["right","top","width","height"],fun=
ction(t){"ph"=3D=3D=3Dr[t]&&(r[t]=3Do[t])}),Vp(r,e));this._location=3D{x:n.=
x,y:n.y},this._size=3D[n.width,n.height],this._orient=3D=3D=3Dp2&&this._siz=
e.reverse()},m.prototype._positionGroup=3Dfunction(){var t=3Dthis.group,e=
=3Dthis._location,n=3Dthis._orient,i=3Dthis.dataZoomModel.getFirstTargetAxi=
sModel(),i=3Di&&i.get("inverse"),o=3Dthis._displayables.sliderGroup,r=3D(th=
is._dataShadowInfo||{}).otherAxisInverse,n=3D(o.attr(n!=3D=3Dc2||i?n=3D=3D=
=3Dc2&&i?{scaleY:r?1:-1,scaleX:-1}:n!=3D=3Dp2||i?{scaleY:r?-1:1,scaleX:-1,r=
otation:Math.PI/2}:{scaleY:r?-1:1,scaleX:1,rotation:Math.PI/2}:{scaleY:r?1:=
-1,scaleX:1}),t.getBoundingRect([o]));t.x=3De.x-n.x,t.y=3De.y-n.y,t.markRed=
raw()},m.prototype._getViewExtent=3Dfunction(){return[0,this._size[0]]},m.p=
rototype._renderBackground=3Dfunction(){var t=3Dthis.dataZoomModel,e=3Dthis=
._size,n=3Dthis._displayables.sliderGroup,i=3Dt.get("brushSelect"),t=3D(n.a=
dd(new h2({silent:!0,shape:{x:0,y:0,width:e[0],height:e[1]},style:{fill:t.g=
et("backgroundColor")},z2:-40})),new h2({shape:{x:0,y:0,width:e[0],height:e=
[1]},style:{fill:"transparent"},z2:0,onclick:S(this._onClickPanel,this)})),=
e=3Dthis.api.getZr();i?(t.on("mousedown",this._onBrushStart,this),t.cursor=
=3D"crosshair",e.on("mousemove",this._onBrush),e.on("mouseup",this._onBrush=
End)):(e.off("mousemove",this._onBrush),e.off("mouseup",this._onBrushEnd)),=
n.add(t)},m.prototype._renderDataShadow=3Dfunction(){var t,e,n=3Dthis._data=
ShadowInfo=3Dthis._prepareDataShadowInfo();if(this._displayables.dataShadow=
Segs=3D[],n){var i=3Dthis._size,o=3Dthis._shadowSize||[],r=3Dn.series,a=3Dr=
.getRawData(),s=3Dr.getShadowDim&&r.getShadowDim(),s=3Ds&&a.getDimensionInf=
o(s)?r.getShadowDim():n.otherDim;if(null!=3Ds){var l,u,h,c,p,d,f,g,y=3Dthis=
._shadowPolygonPts,m=3Dthis._shadowPolylinePts;a=3D=3D=3Dthis._shadowData&&=
s=3D=3D=3Dthis._shadowDim&&i[0]=3D=3D=3Do[0]&&i[1]=3D=3D=3Do[1]||(r=3D.3*((=
l=3Da.getDataExtent(s))[1]-l[0]),l=3D[l[0]-r,l[1]+r],h=3D[0,i[1]],n=3D[0,i[=
0]],c=3D[[i[0],0],[0,0]],p=3D[],d=3Dn[1]/(a.count()-1),f=3D0,g=3DMath.round=
(a.count()/i[0]),a.each([s],function(t,e){var n;0<g&&e%g?f+=3Dd:(t=3D(n=3Dn=
ull=3D=3Dt||isNaN(t)||""=3D=3D=3Dt)?0:tr(t,l,h,!0),n&&!u&&e?(c.push([c[c.le=
ngth-1][0],0]),p.push([p[p.length-1][0],0])):!n&&u&&(c.push([f,0]),p.push([=
f,0])),c.push([f,t]),p.push([f,t]),f+=3Dd,u=3Dn)}),y=3Dthis._shadowPolygonP=
ts=3Dc,m=3Dthis._shadowPolylinePts=3Dp),this._shadowData=3Da,this._shadowDi=
m=3Ds,this._shadowSize=3D[i[0],i[1]];for(var v=3Dthis.dataZoomModel,_=3D0;_=
<3;_++){t=3D1=3D=3D=3D_,x=3De=3Dvoid 0,t=3Dv.getModel(t?"selectedDataBackgr=
ound":"dataBackground"),e=3Dnew Wo,x=3Dnew Zu({shape:{points:y},segmentIgno=
reThreshold:1,style:t.getModel("areaStyle").getAreaStyle(),silent:!0,z2:-20=
}),t=3Dnew $u({shape:{points:m},segmentIgnoreThreshold:1,style:t.getModel("=
lineStyle").getLineStyle(),silent:!0,z2:-19}),e.add(x),e.add(t);var x=3De;t=
his._displayables.sliderGroup.add(x),this._displayables.dataShadowSegs.push=
(x)}}}},m.prototype._prepareDataShadowInfo=3Dfunction(){var s,l,t=3Dthis.da=
taZoomModel,u=3Dt.get("showDataShadow");if(!1!=3D=3Du)return l=3Dthis.ecMod=
el,t.eachTargetAxis(function(r,a){E(t.getAxisProxy(r,a).getTargetSeriesMode=
ls(),function(t){var e,n,i,o;s||!0!=3D=3Du&&C(d2,t.get("type"))<0||(n=3Dl.g=
etComponent(mT(r),a).axis,o=3Dt.coordinateSystem,null!=3D(i=3D{x:"y",y:"x",=
radius:"angle",angle:"radius"}[r])&&o.getOtherAxis&&(e=3Do.getOtherAxis(n).=
inverse),i=3Dt.getData().mapDimension(i),s=3D{thisAxis:n,series:t,thisDim:r=
,otherDim:i,otherAxisInverse:e})},this)},this),s},m.prototype._renderHandle=
=3Dfunction(){var t,e,o=3Dthis.group,n=3Dthis._displayables,r=3Dn.handles=
=3D[null,null],a=3Dn.handleLabels=3D[null,null],s=3Dthis._displayables.slid=
erGroup,i=3Dthis._size,l=3Dthis.dataZoomModel,u=3Dthis.api,h=3Dl.get("borde=
rRadius")||0,c=3Dl.get("brushSelect"),p=3Dn.filler=3Dnew h2({silent:c,style=
:{fill:l.get("fillerColor")},textConfig:{position:"inside"}}),h=3D(s.add(p)=
,s.add(new h2({silent:!0,subPixelOptimize:!0,shape:{x:0,y:0,width:i[0],heig=
ht:i[1],r:h},style:{stroke:l.get("dataBackgroundColor")||l.get("borderColor=
"),lineWidth:1,fill:"rgba(0,0,0,0)"}})),E([0,1],function(t){var e=3Dl.get("=
handleIcon"),e=3Dam(e=3D!im[e]&&e.indexOf("path://")<0&&e.indexOf("image://=
")<0?"path://"+e:e,-1,0,2,2,null,!0),n=3D(e.attr({cursor:y2(this._orient),d=
raggable:!0,drift:S(this._onDragMove,this,t),ondragend:S(this._onDragEnd,th=
is),onmouseover:S(this._showDataInfo,this,!0),onmouseout:S(this._showDataIn=
fo,this,!1),z2:5}),e.getBoundingRect()),i=3Dl.get("handleSize"),i=3D(this._=
handleHeight=3Der(i,this._size[1]),this._handleWidth=3Dn.width/n.height*thi=
s._handleHeight,e.setStyle(l.getModel("handleStyle").getItemStyle()),e.styl=
e.strokeNoScale=3D!0,e.rectHover=3D!0,e.ensureState("emphasis").style=3Dl.g=
etModel(["emphasis","handleStyle"]).getItemStyle(),Hl(e),l.get("handleColor=
")),n=3D(null!=3Di&&(e.style.fill=3Di),s.add(r[t]=3De),l.getModel("textStyl=
e"));o.add(a[t]=3Dnew Hs({silent:!0,invisible:!0,style:wc(n,{x:0,y:0,text:"=
",verticalAlign:"middle",align:"center",fill:n.getTextColor(),font:n.getFon=
t()}),z2:10}))},this),p);c&&(p=3Der(l.get("moveHandleSize"),i[1]),t=3Dn.mov=
eHandle=3Dnew Es({style:l.getModel("moveHandleStyle").getItemStyle(),silent=
:!0,shape:{r:[0,0,2,2],y:i[1]-.5,height:p}}),c=3D.8*p,(c=3Dn.moveHandleIcon=
=3Dam(l.get("moveHandleIcon"),-c/2,-c/2,c,c,"#fff",!0)).silent=3D!0,c.y=3Di=
[1]+p/2-.5,t.ensureState("emphasis").style=3Dl.getModel(["emphasis","moveHa=
ndleStyle"]).getItemStyle(),e=3DMath.min(i[1]/2,Math.max(p,10)),(h=3Dn.move=
Zone=3Dnew Es({invisible:!0,shape:{y:i[1]-e,height:p+e}})).on("mouseover",f=
unction(){u.enterEmphasis(t)}).on("mouseout",function(){u.leaveEmphasis(t)}=
),s.add(t),s.add(c),s.add(h)),h.attr({draggable:!0,cursor:y2(this._orient),=
drift:S(this._onDragMove,this,"all"),ondragstart:S(this._showDataInfo,this,=
!0),ondragend:S(this._onDragEnd,this),onmouseover:S(this._showDataInfo,this=
,!0),onmouseout:S(this._showDataInfo,this,!1)})},m.prototype._resetInterval=
=3Dfunction(){var t=3Dthis._range=3Dthis.dataZoomModel.getPercentRange(),e=
=3Dthis._getViewExtent();this._handleEnds=3D[tr(t[0],[0,100],e,!0),tr(t[1],=
[0,100],e,!0)]},m.prototype._updateInterval=3Dfunction(t,e){var n=3Dthis.da=
taZoomModel,i=3Dthis._handleEnds,o=3Dthis._getViewExtent(),r=3Dn.findRepres=
entativeAxisProxy().getMinMaxSpan(),a=3D[0,100],e=3D(AT(e,i,o,n.get("zoomLo=
ck")?"all":t,null!=3Dr.minSpan?tr(r.minSpan,a,o,!0):null,null!=3Dr.maxSpan?=
tr(r.maxSpan,a,o,!0):null),this._range),n=3Dthis._range=3Dir([tr(i[0],o,a,!=
0),tr(i[1],o,a,!0)]);return!e||e[0]!=3D=3Dn[0]||e[1]!=3D=3Dn[1]},m.prototyp=
e._updateView=3Dfunction(t){var i=3Dthis._displayables,o=3Dthis._handleEnds=
,e=3Dir(o.slice()),r=3Dthis._size,n=3D(E([0,1],function(t){var e=3Di.handle=
s[t],n=3Dthis._handleHeight;e.attr({scaleX:n/2,scaleY:n/2,x:o[t]+(t?-1:1),y=
:r[1]/2-n/2})},this),i.filler.setShape({x:e[0],y:0,width:e[1]-e[0],height:r=
[1]}),{x:e[0],width:e[1]-e[0]});i.moveHandle&&(i.moveHandle.setShape(n),i.m=
oveZone.setShape(n),i.moveZone.getBoundingRect(),i.moveHandleIcon)&&i.moveH=
andleIcon.attr("x",n.x+n.width/2);for(var a=3Di.dataShadowSegs,s=3D[0,e[0],=
e[1],r[0]],l=3D0;l<a.length;l++){var u=3Da[l],h=3Du.getClipPath();h||(h=3Dn=
ew Es,u.setClipPath(h)),h.setShape({x:s[l],y:0,width:s[l+1]-s[l],height:r[1=
]})}this._updateDataInfo(t)},m.prototype._updateDataInfo=3Dfunction(t){var =
e,n,i=3Dthis.dataZoomModel,o=3Dthis._displayables,r=3Do.handleLabels,a=3Dth=
is._orient,s=3D["",""],l=3D(i.get("showDetail")&&(i=3Di.findRepresentativeA=
xisProxy())&&(e=3Di.getAxisModel().axis,n=3Dthis._range,t=3Dt?i.calculateDa=
taWindow({start:n[0],end:n[1]}).valueWindow:i.getDataValueWindow(),s=3D[thi=
s._formatLabel(t[0],e),this._formatLabel(t[1],e)]),ir(this._handleEnds.slic=
e()));function u(t){var e=3Dic(o.handles[t].parent,this.group),n=3Drc(0=3D=
=3D=3Dt?"right":"left",e),i=3Dthis._handleWidth/2+5,i=3Doc([l[t]+(0=3D=3D=
=3Dt?-i:i),this._size[1]/2],e);r[t].setStyle({x:i[0],y:i[1],verticalAlign:a=
=3D=3D=3Dc2?"middle":n,align:a=3D=3D=3Dc2?n:"center",text:s[t]})}u.call(thi=
s,0),u.call(this,1)},m.prototype._formatLabel=3Dfunction(t,e){var n=3Dthis.=
dataZoomModel,i=3Dn.get("labelFormatter"),n=3Dn.get("labelPrecision"),e=3D(=
null!=3Dn&&"auto"!=3D=3Dn||(n=3De.getPixelPrecision()),null=3D=3Dt||isNaN(t=
)?"":"category"=3D=3D=3De.type||"time"=3D=3D=3De.type?e.scale.getLabel({val=
ue:Math.round(t)}):t.toFixed(Math.min(n,20)));return D(i)?i(t,e):H(i)?i.rep=
lace("{value}",e):e},m.prototype._showDataInfo=3Dfunction(t){t=3Dthis._drag=
ging||t;var e=3Dthis._displayables,n=3De.handleLabels;n[0].attr("invisible"=
,!t),n[1].attr("invisible",!t),e.moveHandle&&this.api[t?"enterEmphasis":"le=
aveEmphasis"](e.moveHandle,1)},m.prototype._onDragMove=3Dfunction(t,e,n,i){=
this._dragging=3D!0,Te(i.event);i=3Doc([e,n],this._displayables.sliderGroup=
.getLocalTransform(),!0),e=3Dthis._updateInterval(t,i[0]),n=3Dthis.dataZoom=
Model.get("realtime");this._updateView(!n),e&&n&&this._dispatchZoomAction(!=
0)},m.prototype._onDragEnd=3Dfunction(){this._dragging=3D!1,this._showDataI=
nfo(!1),this.dataZoomModel.get("realtime")||this._dispatchZoomAction(!1)},m=
.prototype._onClickPanel=3Dfunction(t){var e=3Dthis._size,t=3Dthis._display=
ables.sliderGroup.transformCoordToLocal(t.offsetX,t.offsetY);t[0]<0||t[0]>e=
[0]||t[1]<0||t[1]>e[1]||(e=3D((e=3Dthis._handleEnds)[0]+e[1])/2,t=3Dthis._u=
pdateInterval("all",t[0]-e),this._updateView(),t&&this._dispatchZoomAction(=
!1))},m.prototype._onBrushStart=3Dfunction(t){var e=3Dt.offsetX,t=3Dt.offse=
tY;this._brushStart=3Dnew z(e,t),this._brushing=3D!0,this._brushStartTime=
=3D+new Date},m.prototype._onBrushEnd=3Dfunction(t){var e,n,i;this._brushin=
g&&(e=3Dthis._displayables.brushRect,this._brushing=3D!1,e)&&(e.attr("ignor=
e",!0),e=3De.shape,+new Date-this._brushStartTime<200&&Math.abs(e.width)<5|=
|(n=3Dthis._getViewExtent(),this._range=3Dir([tr(e.x,n,i=3D[0,100],!0),tr(e=
.x+e.width,n,i,!0)]),this._handleEnds=3D[e.x,e.x+e.width],this._updateView(=
),this._dispatchZoomAction(!1)))},m.prototype._onBrush=3Dfunction(t){this._=
brushing&&(Te(t.event),this._updateBrushRect(t.offsetX,t.offsetY))},m.proto=
type._updateBrushRect=3Dfunction(t,e){var n=3Dthis._displayables,i=3Dthis.d=
ataZoomModel,o=3Dn.brushRect,i=3D(o||(o=3Dn.brushRect=3Dnew h2({silent:!0,s=
tyle:i.getModel("brushStyle").getItemStyle()}),n.sliderGroup.add(o)),o.attr=
("ignore",!1),this._brushStart),n=3Dthis._displayables.sliderGroup,t=3Dn.tr=
ansformCoordToLocal(t,e),e=3Dn.transformCoordToLocal(i.x,i.y),n=3Dthis._siz=
e;t[0]=3DMath.max(Math.min(n[0],t[0]),0),o.setShape({x:e[0],y:0,width:t[0]-=
e[0],height:n[1]})},m.prototype._dispatchZoomAction=3Dfunction(t){var e=3Dt=
his._range;this.api.dispatchAction({type:"dataZoom",from:this.uid,dataZoomI=
d:this.dataZoomModel.id,animation:t?f2:null,start:e[0],end:e[1]})},m.protot=
ype._findCoordRect=3Dfunction(){var t,e,n=3D_T(this.dataZoomModel).infoList=
;return t=3D(t=3D!t&&n.length?(n=3Dn[0].model.coordinateSystem).getRect&&n.=
getRect():t)?t:{x:.2*(n=3Dthis.api.getWidth()),y:.2*(e=3Dthis.api.getHeight=
()),width:.6*n,height:.6*e}},m.type=3D"dataZoom.slider",m);function m(){var=
 t=3Dnull!=3D=3Du2&&u2.apply(this,arguments)||this;return t.type=3Dm.type,t=
._displayables=3D{},t}function y2(t){return"vertical"=3D=3D=3Dt?"ns-resize"=
:"ew-resize"}function m2(t){t.registerComponentModel(s2),t.registerComponen=
tView(g2),o2(t)}U_(function(t){U_(r2),U_(m2)}),U_(fx);var v2=3D{value:"eq",=
"<":"lt","<=3D":"lte",">":"gt",">=3D":"gte","=3D":"eq","!=3D":"ne","<>":"ne=
"},_2=3D(A2.prototype.evaluate=3Dfunction(t){var e=3Dtypeof t;return H(e)?t=
his._condVal.test(t):!!W(e)&&this._condVal.test(t+"")},A2),x2=3D(k2.prototy=
pe.evaluate=3Dfunction(){return this.value},k2),w2=3D(D2.prototype.evaluate=
=3Dfunction(){for(var t=3Dthis.children,e=3D0;e<t.length;e++)if(!t[e].evalu=
ate())return!1;return!0},D2),b2=3D(C2.prototype.evaluate=3Dfunction(){for(v=
ar t=3Dthis.children,e=3D0;e<t.length;e++)if(t[e].evaluate())return!0;retur=
n!1},C2),S2=3D(I2.prototype.evaluate=3Dfunction(){return!this.child.evaluat=
e()},I2),M2=3D(T2.prototype.evaluate=3Dfunction(){for(var t=3D!!this.valueP=
arser,e=3D(0,this.getValue)(this.valueGetterParam),n=3Dt?this.valueParser(e=
):null,i=3D0;i<this.subCondList.length;i++)if(!this.subCondList[i].evaluate=
(t?n:e))return!1;return!0},T2);function T2(){}function I2(){}function C2(){=
}function D2(){}function k2(){}function A2(t){null=3D=3D(this._condVal=3DH(=
t)?new RegExp(t):mt(t)?t:null)&&f("")}function L2(t,e){var n;if(!0=3D=3D=3D=
t||!1=3D=3D=3Dt)return(n=3Dnew x2).value=3Dt,n;{if(O2(t)||f(""),t.and)retur=
n P2("and",t,e);if(t.or)return P2("or",t,e);if(t.not)n=3De,O2(r=3D(r=3Dt).n=
ot)||f(""),(l=3Dnew S2).child=3DL2(r,n),l.child||f("");else{for(var i=3Dt,o=
=3De,r=3Do.prepareGetValue(i),a=3D[],s=3Dht(i),l=3Di.parser,u=3Dl?Yf(l):nul=
l,h=3D0;h<s.length;h++){var c,p=3Ds[h];"parser"=3D=3D=3Dp||o.valueGetterAtt=
rMap.get(p)||(c=3DEt(v2,p)?v2[p]:p,p=3Di[p],p=3Du?u(p):p,(c=3Dfunction(t,e)=
{return"eq"=3D=3D=3Dt||"ne"=3D=3D=3Dt?new Qf("eq"=3D=3D=3Dt,e):Et(Zf,t)?new=
 qf(t,e):null}(c,p)||"reg"=3D=3D=3Dc&&new _2(p))||f(""),a.push(c))}a.length=
||f(""),(l=3Dnew M2).valueGetterParam=3Dr,l.valueParser=3Du,l.getValue=3Do.=
getValue,l.subCondList=3Da}return l}}function P2(t,e,n){e=3De[t],V(e)||f(""=
),e.length||f(""),t=3Dnew("and"=3D=3D=3Dt?w2:b2);return t.children=3DF(e,fu=
nction(t){return L2(t,n)}),t.children.length||f(""),t}function O2(t){return=
 O(t)&&!st(t)}N2.prototype.evaluate=3Dfunction(){return this._cond.evaluate=
()};var R2=3DN2;function N2(t,e){this._cond=3DL2(t,e)}var E2=3D{type:"echar=
ts:filter",transform:function(t){for(var e,n,i=3Dt.upstream,o=3D(t=3Dt.conf=
ig,n=3D{valueGetterAttrMap:N({dimension:!0}),prepareGetValue:function(t){va=
r e=3Dt.dimension,t=3D(Et(t,"dimension")||f(""),i.getDimensionInfo(e));retu=
rn t||f(""),{dimIdx:t.index}},getValue:function(t){return i.retrieveValueFr=
omItem(e,t.dimIdx)}},new R2(t,n)),r=3D[],a=3D0,s=3Di.count();a<s;a++)e=3Di.=
getRawDataItem(a),o.evaluate()&&r.push(e);return{data:r}}},z2=3D{type:"echa=
rts:sort",transform:function(t){var a=3Dt.upstream,t=3Dt.config,t=3Dbr(t),s=
=3D(t.length||f(""),[]),t=3D(E(t,function(t){var e=3Dt.dimension,n=3Dt.orde=
r,i=3Dt.parser,t=3Dt.incomparable,e=3D(null=3D=3De&&f(""),"asc"!=3D=3Dn&&"d=
esc"!=3D=3Dn&&f(""),t&&"min"!=3D=3Dt&&"max"!=3D=3Dt&&f(""),"asc"!=3D=3Dn&&"=
desc"!=3D=3Dn&&f(""),a.getDimensionInfo(e)),o=3D(e||f(""),i?Yf(i):null);i&&=
!o&&f(""),s.push({dimIdx:e.index,parser:o,comparator:new jf(n,t)})}),a.sour=
ceFormat);t!=3D=3Dtd&&t!=3D=3Ded&&f("");for(var e=3D[],n=3D0,i=3Da.count();=
n<i;n++)e.push(a.getRawDataItem(n));return e.sort(function(t,e){for(var n=
=3D0;n<s.length;n++){var i=3Ds[n],o=3Da.retrieveValueFromItem(t,i.dimIdx),r=
=3Da.retrieveValueFromItem(e,i.dimIdx),i=3D(i.parser&&(o=3Di.parser(o),r=3D=
i.parser(r)),i.comparator.evaluate(o,r));if(0!=3D=3Di)return i}return 0}),{=
data:e}}};U_(function(t){t.registerTransform(E2),t.registerTransform(z2)}),=
t.Axis=3DEc,t.ChartView=3Dny,t.ComponentModel=3Dg,t.ComponentView=3D$g,t.Li=
st=3DCv,t.Model=3DHc,t.PRIORITY=3DJy,t.SeriesModel=3DGg,t.color=3Dvi,t.conn=
ect=3Dfunction(e){var t;return V(e)&&(t=3De,e=3Dnull,E(t,function(t){null!=
=3Dt.group&&(e=3Dt.group)}),e=3De||"g_"+R0++,E(t,function(t){t.group=3De}))=
,P0[e]=3D!0,e},t.dataTool=3D{},t.dependencies=3D{zrender:"5.5.0"},t.disConn=
ect=3DQy,t.disconnect=3DE0,t.dispose=3Dfunction(t){H(t)?t=3DL0[t]:t instanc=
eof m0||(t=3Dz0(t)),t instanceof m0&&!t.isDisposed()&&t.dispose()},t.env=3D=
b,t.extendChartView=3Dfunction(t){return t=3Dny.extend(t),ny.registerClass(=
t),t},t.extendComponentModel=3Dfunction(t){return t=3Dg.extend(t),g.registe=
rClass(t),t},t.extendComponentView=3Dfunction(t){return t=3D$g.extend(t),$g=
.registerClass(t),t},t.extendSeriesModel=3Dfunction(t){return t=3DGg.extend=
(t),Gg.registerClass(t),t},t.format=3DRc,t.getCoordinateSystemDimensions=3D=
function(t){if(t=3DAd.get(t))return t.getDimensionsInfo?t.getDimensionsInfo=
():t.dimensions.slice()},t.getInstanceByDom=3Dz0,t.getInstanceById=3Dfuncti=
on(t){return L0[t]},t.getMap=3Dfunction(t){var e=3DVm.getMap;return e&&e(t)=
},t.graphic=3Dop,t.helper=3Dtm,t.init=3Dfunction(t,e,n){var i=3D!(n&&n.ssr)=
;if(i){var o=3Dz0(t);if(o)return o}return(o=3Dnew m0(t,e,n)).id=3D"ec_"+O0+=
+,L0[o.id]=3Do,i&&Hr(t,N0,o.id),h0(o),Fm.trigger("afterinit",o),o},t.innerD=
rawElementOnCanvas=3DPm,t.matrix=3DFe,t.number=3Dea,t.parseGeoJSON=3Dl1,t.p=
arseGeoJson=3Dl1,t.registerAction=3DX0,t.registerCoordinateSystem=3DU0,t.re=
gisterLayout=3DY0,t.registerLoading=3DK0,t.registerLocale=3DQc,t.registerMa=
p=3D$0,t.registerPostInit=3DH0,t.registerPostUpdate=3DW0,t.registerPreproce=
ssor=3DF0,t.registerProcessor=3DV0,t.registerTheme=3DB0,t.registerTransform=
=3DQ0,t.registerUpdateLifecycle=3DG0,t.registerVisual=3DZ0,t.setCanvasCreat=
or=3Dfunction(t){I({createCanvas:t})},t.setPlatformAPI=3DI,t.throttle=3Dpy,=
t.time=3Dnc,t.use=3DU_,t.util=3DGy,t.vector=3Die,t.version=3D"5.5.0",t.zrUt=
il=3DFt,t.zrender=3DQo});
\ No newline at end of file
--=20
2.34.1

