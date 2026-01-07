Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B857CFD65F
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 16:32:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10253.1767803549667307287
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 Jan 2026 08:32:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FA56497
	for <yocto-patches@lists.yoctoproject.org>; Wed,  7 Jan 2026 08:32:22 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EFC3C3F5A1
	for <yocto-patches@lists.yoctoproject.org>; Wed,  7 Jan 2026 08:32:28 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-metrics] patch-status: use releases.json instead of our own releases.csv
Date: Wed,  7 Jan 2026 16:32:27 +0000
Message-ID: <20260107163227.3034611-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 16:32:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2912

https://dashboard.yoctoproject.org/releases.json is a machine-generated
file that contains all (caveat below) of the information that we need
for these charts: name, version, release date.

The caveat is that at the time of writing the data is missing the 1.3
release entirely and the 5.3 release hasn't happened. This is being
actively worked on so soon the file will be complete.

Also note that the releases.json file has the _tag date_ as the release
date, not the date that the release was actually announced. These differ
by several days so the markers on the charts do shift slightly.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 patch-status/index.html   | 18 +++++++-----------
 patch-status/releases.csv | 32 --------------------------------
 2 files changed, 7 insertions(+), 43 deletions(-)
 delete mode 100644 patch-status/releases.csv

diff --git a/patch-status/index.html b/patch-status/index.html
index 9bdcd478..e5980a90 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -357,7 +357,6 @@ SPDX-License-Identifier: MIT
         <li><a href=3D"patch-status-pie.json">patch-status-pie.json</a><=
/li>
         <li><a href=3D"patch-status-byday.json">patch-status-byday.json<=
/a></li>
         <li><a href=3D"cve-count-byday.json">cve-count-byday.json</a></l=
i>
-        <li><a href=3D"releases.csv">releases.csv</a></li>
       </ul>
     </section>
   </main>
@@ -475,20 +474,17 @@ SPDX-License-Identifier: MIT
       ]
     }
=20
-    fetch('releases.csv')
-      .then(response =3D> response.text())
+    fetch('https://dashboard.yoctoproject.org/releases.json')
+      .then(response =3D> response.json())
       .then(data =3D> {
         const release_lines =3D []
-        const lines =3D data.split("\n")
-        // skip the header
-        for (let i =3D 1; i < lines.length; i++) {
-          const line =3D lines[i].split(",");
-          if (line.length) {
+        for (const release of data) {
+          if (release.latest_tag) {
             const cve =3D {
-              name: line[0],
-              xAxis: new Date(line[1])
+              name: `${release.series_version} (${release.release_codena=
me})`,
+              xAxis: new Date(release.original_release_date)
             }
-            release_lines.push(cve)
+            release_lines.push(cve);
           }
         }
         const releases =3D {
diff --git a/patch-status/releases.csv b/patch-status/releases.csv
deleted file mode 100644
index 91b94bd9..00000000
--- a/patch-status/releases.csv
+++ /dev/null
@@ -1,32 +0,0 @@
-Name,Date
-5.2 (Walnascar),2025-05-08
-5.1 (Styhead),2024-10-17
-5.0 (Scarthgap),2024-04-30
-4.3 (Nanbield),2023-11-14
-4.2 (Mickledore),2023-05-03
-4.1 (Langdale),2022-10-23
-4.0 (Kirkstone),2022-04-27
-3.4 (Honister),2021-10-25
-3.3 (Hardknott),2021-04-06
-3.2 (Gatesgarth),2020-10-26
-3.1 (Dunfell),2020-04-21
-3.0 (Zeus),2019-10-22
-2.7 (Warrior),2019-05-01
-2.6 (Thud),2018-11-15
-2.5 (Sumo),2018-04-01
-2.4 (Rocko),2017-10-26
-2.3 (Pyro),2017-05-12
-2.2 (Morty),2016-11-01
-2.1 (Krogoth),2016-05-02
-2.0 (Jethro),2015-11-03
-1.8 (Fido),2015-04-09
-1.7 (Dizzy),2014-10-28
-1.6 (Daisy),2014-04-23
-1.5 (Dora),2013-10-08
-1.4 (Dylan),2013-04-18
-1.3 (Danny),2012-10-22
-1.2 (Denzil),2012-04-18
-1.1 (Edison),2011-10-12
-1.0 (Bernard),2011-05-25
-
-
--=20
2.43.0


