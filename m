Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B15C88E53
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 21:04:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49576.1789160637095148117
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 14:03:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=f75tAlK4;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6247E2E99
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:53 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCFE83F8C6
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789160637; bh=12vHL+iYIXg+x3EH9j8vnDy6RmvHI6UrL4JdM1PdDJg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f75tAlK4dzsYKtuHn8wfTh7oEXM5jnrM00YdVPeqyfk2xf//FBMH3naG+DEGtla//
	 qonuIfboXM4cY9JVfaVPY3ajI6Odr1I4yy96zCpzi2lDiJo14TtT0cP+0reUszzm8F
	 RbiExiHkAlmb2z88HicIGMYBp+HAIx4e28fRZRUE=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 4/8] dashboard/bugtriage: refactor the fetch/update
Date: Fri, 11 Sep 2026 22:03:47 +0100
Message-ID: <20260911210351.2020798-4-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911210351.2020798-1-ross.burton@arm.com>
References: <20260911210351.2020798-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 21:04:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4819

move the searchBugs() calls into reloadTable() so that the bugsBy*()
functions just return a constructed query object.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 49 +++++++++++++++-----------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 873a3b6f..7febd4dc 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -603,31 +603,31 @@
       reloadButton.classList.toggle('spin')
     }
=20
-    async function bugsByWhiteboard(table, keyword) {
+    function bugsByWhiteboard(keyword) {
       const params =3D new URLSearchParams({
         resolution: "---",
         status_whiteboard: keyword,
         status_whiteboard_type: "anywords",
       });
-      const bugs =3D await searchBugs(table, params);
+      return params;
     }
=20
-    async function bugsByPriority(table, priority) {
+    function bugsByPriority(priority) {
       const params =3D new URLSearchParams({
         resolution: "---",
         priority: priority
       });
-      const bugs =3D await searchBugs(table, params);
+      return params;
     }
=20
-    async function bugsByStatus(table, status) {
+    function bugsByStatus(status) {
       const params =3D new URLSearchParams({
         bug_status: status
       });
-      const bugs =3D await searchBugs(table, params);
+      return params;
     }
=20
-    async function bugsInactive(table, operator) {
+    function bugsInactive(operator) {
       const params =3D new URLSearchParams({
         resolution: "---",
         f1: "days_elapsed",
@@ -637,7 +637,7 @@
         o2: operator,
         v2: "enhancement"
       });
-      const bugs =3D await searchBugs(table, params);
+      return params;
     }
=20
     function escapeRegExp(string) {
@@ -726,7 +726,7 @@
=20
     const activeMilestonesPromise =3D getActiveReleases();
=20
-    async function bugsOldMilestone(table) {
+    async function bugsOldMilestone() {
       const activeMilestones =3D await activeMilestonesPromise;
=20
       const params =3D new URLSearchParams({
@@ -735,42 +735,49 @@
         o1: "notregexp",
         v1: `^(${activeMilestones.map((s) =3D> escapeRegExp(s)).join("|"=
)})$`
       });
-      const bugs =3D await searchBugs(table, params);
+      return params;
     }
=20
-    function reloadTable(table) {
+    async function reloadTable(table) {
+      let params;
+
       switch (table) {
         case "#unprioritised":
-          bugsByPriority(table, "Undecided");
+          params =3D bugsByPriority("Undecided");
           break;
         case "#high":
-          bugsByPriority(table, "High");
+          params =3D bugsByPriority("High");
           break;
         case "#abint":
-          bugsByWhiteboard(table, "AB-INT");
+          params =3D bugsByWhiteboard("AB-INT");
           break;
         case "#newcomer":
-          bugsByWhiteboard(table, "NEWCOMER");
+          params =3D bugsByWhiteboard("NEWCOMER");
           break;
         case "#retest":
-          bugsByWhiteboard(table, "RETEST");
+          params =3D bugsByWhiteboard("RETEST");
           break;
         case "#reopened":
-          bugsByStatus(table, "REOPENED");
+          params =3D bugsByStatus("REOPENED");
           break;
         case "#needinfo":
-          bugsByStatus(table, "NEEDINFO");
+          params =3D bugsByStatus("NEEDINFO");
           break;
         case "#inactivebugs":
-          bugsInactive(table, "notequals");
+          params =3D bugsInactive("notequals");
           break;
         case "#inactivefeatures":
-          bugsInactive(table, "equals");
+          params =3D bugsInactive("equals");
           break;
         case "#oldmilestone":
-          bugsOldMilestone(table);
+          params =3D await bugsOldMilestone();
           break;
+        default:
+          console.error(`Unhandled table ${table}`);
+          return;
       }
+
+      await searchBugs(table, params);
     }
=20
     reloadTable("#unprioritised");
--=20
2.43.0


