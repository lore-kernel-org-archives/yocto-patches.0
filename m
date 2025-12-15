Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09BAD5B175
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 14:35:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50128.1765809339579910789
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Dec 2025 06:35:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F6A497
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 06:35:31 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A54BB3F694
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 06:35:38 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] dashboard/bugtriage: add retest section
Date: Mon, 15 Dec 2025 14:35:32 +0000
Message-ID: <20251215143532.981506-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Dec 2025 14:35:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2789

Add a section for bugs with the "retest" whiteboard entry.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 45273ef8..10d998d2 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -152,6 +152,14 @@
         </p>
         <div id=3D"newcomer"></div>
       </div>
+
+      <div class=3D"section scrollspy" id=3D"retest-container">
+        <h4>Needs Testing <a class=3D"waves-effect btn-flat" onclick=3D"=
reloadTable('#retest');"><i class=3D"material-icons">refresh</i></a></h4>
+        <p>
+          All open bugs which have been tagged as needing to be retested=
.
+        </p>
+        <div id=3D"retest"></div>
+      </div>
     </div>
=20
     <div class=3D"col hide-on-small-only m3 l2">
@@ -166,6 +174,7 @@
         <li><a href=3D"#inactivefeatures-container">Old Features</a></li=
>
         <li><a href=3D"#oldmilestone-container">Wrong Milestone</a></li>
         <li><a href=3D"#newcomer-container">Newcomer</a></li>
+        <li><a href=3D"#retest-container">Retest</a></li>
       </ul>
     </div>
   </div>
@@ -401,6 +410,9 @@
         case "#newcomer":
           bugsByWhiteboard(table, "NEWCOMER");
           break;
+        case "#retest":
+          bugsByWhiteboard(table, "RETEST");
+          break;
         case "#reopened":
           bugsByStatus(table, "REOPENED");
           break;
@@ -428,6 +440,7 @@
     reloadTable("#inactivebugs");
     reloadTable("#inactivefeatures");
     reloadTable("#oldmilestone");
+    reloadTable("#retest");
=20
     document.addEventListener('DOMContentLoaded', function () {
       var elems =3D document.querySelectorAll('.scrollspy');
--=20
2.43.0


