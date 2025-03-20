Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D48C35FFF
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 14:56:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.9942.1742482562748323030
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Mar 2025 07:56:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 212F11424
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 07:56:10 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 026983F673
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 07:56:01 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 2/2] scripts/dashboard/bugtriage: tweak order of sections
Date: Thu, 20 Mar 2025 14:55:57 +0000
Message-ID: <20250320145557.1939762-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320145557.1939762-1-ross.burton@arm.com>
References: <20250320145557.1939762-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 14:56:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1233

Move Reopened to before AB-INT.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index fef32f95..a6f1b4c3 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -89,6 +89,15 @@
         <div id=3D"high"></div>
       </div>
=20
+      <div class=3D"section scrollspy" id=3D"reopened-container">
+        <h4>Reopened <a class=3D"waves-effect btn-flat" onclick=3D"reloa=
dTable('#reopened');"><i class=3D"material-icons">refresh</i></a></h4>
+        <p>
+          Bugs that have been reopened. The owner should be reviewed and=
 the bug
+          moved to another state.
+        </p>
+        <div id=3D"reopened"></div>
+      </div>
+
       <div class=3D"section scrollspy" id=3D"abint-container">
         <h4>Autobuilder Intermittent <a class=3D"waves-effect btn-flat" =
onclick=3D"reloadTable('#abint');"><i class=3D"material-icons">refresh</i=
></a></h4>
         <p>
@@ -100,15 +109,6 @@
         <div id=3D"abint"></div>
       </div>
=20
-      <div class=3D"section scrollspy" id=3D"reopened-container">
-        <h4>Reopened <a class=3D"waves-effect btn-flat" onclick=3D"reloa=
dTable('#reopened');"><i class=3D"material-icons">refresh</i></a></h4>
-        <p>
-          Bugs that have been reopened. The owner should be reviewed and=
 the bug
-          moved to another state.
-        </p>
-        <div id=3D"reopened"></div>
-      </div>
-
       <div class=3D"section scrollspy" id=3D"needinfo-container">
         <h4>Need Info <a class=3D"waves-effect btn-flat" onclick=3D"relo=
adTable('#needinfo');"><i class=3D"material-icons">refresh</i></a></h4>
         <p>
@@ -151,8 +151,8 @@
         <li><a href=3D"#security-container">Security</a></li>
         <li><a href=3D"#unprioritised-container">Unprioritised</a></li>
         <li><a href=3D"#high-container">High</a></li>
-        <li><a href=3D"#abint-container">AB-INT</a></li>
         <li><a href=3D"#reopened-container">Reopened</a></li>
+        <li><a href=3D"#abint-container">AB-INT</a></li>
         <li><a href=3D"#needinfo-container">Need Info</a></li>
         <li><a href=3D"#inactive-container">Inactive</a></li>
         <li><a href=3D"#oldmilestone-container">Old Milestone</a></li>
--=20
2.43.0


