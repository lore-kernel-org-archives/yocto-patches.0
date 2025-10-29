Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8BDCCF9E9
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 14:21:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.7028.1761747661928541428
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Oct 2025 07:21:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD7761AC1
	for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 07:20:53 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A40C3F66E
	for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 07:21:01 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 3/3] dashboard/bugtriage: split Inactive into bugs and features
Date: Wed, 29 Oct 2025 14:20:58 +0000
Message-ID: <20251029142058.3066156-3-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029142058.3066156-1-ross.burton@arm.com>
References: <20251029142058.3066156-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 14:21:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2403

Use the severity=3Denhancement field to split the Inactive list into bugs
and features, to make it easier to triage them.

Also rename to "Old" as it's a shorter word and we don't want very wide
sidebars.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 34 +++++++++++++++++++-------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 891510f0..54065576 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -119,12 +119,20 @@
         <div id=3D"needinfo"></div>
       </div>
=20
-      <div class=3D"section scrollspy" id=3D"inactive-container">
-        <h4>Inactive <a class=3D"waves-effect btn-flat" onclick=3D"reloa=
dTable('#inactive');"><i class=3D"material-icons">refresh</i></a></h4>
+      <div class=3D"section scrollspy" id=3D"inactivebugs-container">
+        <h4>Inactive Bugs <a class=3D"waves-effect btn-flat" onclick=3D"=
reloadTable('#inactivebugs');"><i class=3D"material-icons">refresh</i></a=
></h4>
         <p>
           All open bugs that haven't been altered in two years.
         </p>
-        <div id=3D"inactive"></div>
+        <div id=3D"inactivebugs"></div>
+      </div>
+
+      <div class=3D"section scrollspy" id=3D"inactivefeatures-container"=
>
+        <h4>Inactive Enhancements <a class=3D"waves-effect btn-flat" onc=
lick=3D"reloadTable('#inactivefeatures');"><i class=3D"material-icons">re=
fresh</i></a></h4>
+        <p>
+          All open enhancements that haven't been altered in two years.
+        </p>
+        <div id=3D"inactivefeatures"></div>
       </div>
=20
       <div class=3D"section scrollspy" id=3D"oldmilestone-container">
@@ -154,7 +162,8 @@
         <li><a href=3D"#reopened-container">Reopened</a></li>
         <li><a href=3D"#abint-container">AB-INT</a></li>
         <li><a href=3D"#needinfo-container">Need Info</a></li>
-        <li><a href=3D"#inactive-container">Inactive</a></li>
+        <li><a href=3D"#inactivebugs-container">Old Bugs</a></li>
+        <li><a href=3D"#inactivefeatures-container">Old Features</a></li=
>
         <li><a href=3D"#oldmilestone-container">Wrong Milestone</a></li>
         <li><a href=3D"#newcomer-container">Newcomer</a></li>
       </ul>
@@ -268,12 +277,15 @@
       const bugs =3D await searchBugs(table, params);
     }
=20
-    async function bugsInactive(table) {
+    async function bugsInactive(table, operator) {
       const params =3D new URLSearchParams({
         resolution: "---",
         f1: "days_elapsed",
         o1: "greaterthaneq",
-        v1: 365 * 2
+        v1: 365 * 2,
+        f2: "bug_severity",
+        o2: operator,
+        v2: "enhancement"
       });
       const bugs =3D await searchBugs(table, params);
     }
@@ -396,8 +408,11 @@
         case "#needinfo":
           bugsByStatus(table, "NEEDINFO");
           break;
-        case "#inactive":
-          bugsInactive(table);
+        case "#inactivebugs":
+          bugsInactive(table, "notequals");
+          break;
+        case "#inactivefeatures":
+          bugsInactive(table, "equals");
           break;
         case "#oldmilestone":
           bugsOldMilestone(table);
@@ -411,7 +426,8 @@
     reloadTable("#newcomer");
     reloadTable("#reopened");
     reloadTable("#needinfo");
-    reloadTable("#inactive");
+    reloadTable("#inactivebugs");
+    reloadTable("#inactivefeatures");
     reloadTable("#oldmilestone");
=20
     document.addEventListener('DOMContentLoaded', function () {
--=20
2.43.0


