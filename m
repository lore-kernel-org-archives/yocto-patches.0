Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F671C88E5A
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 21:04:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49577.1789160638348494116
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 14:03:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=reLS8+oI;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE6D32E96
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:53 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 526E23F8C6
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789160637; bh=SZFaBuCZ5t2XE+3YDqqLkD/RhjtMqH0WaSAFL3FiTTw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=reLS8+oIdFGWOUTnfbswKyQ17my+HK6G2VIyPUwh8qFIufyGe9I9Sdwcuesw4cKQI
	 cb86QAhQPUTAU54MSV1fTS9rjFTKqSW4uRxWfZnDLBh96YOu1O5X5QUvqRABUHU+sL
	 hiv5G1tS3xUWBWVkY3Xj/NYOK9rzyHWIeAuDQPVg=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 5/8] dashboard/bugtriage: add BZSearch, subclassing URLSearchParams
Date: Fri, 11 Sep 2026 22:03:48 +0100
Message-ID: <20260911210351.2020798-5-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911210351.2020798-1-ross.burton@arm.com>
References: <20260911210351.2020798-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 21:04:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4820

Add a subclass of URLSearchParams that has some helper functions for
constructing Bugzilla search queries.

Change all constructors that use URLSearchParams to BZSearch.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 43 +++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 7febd4dc..a9ccf2e7 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -484,6 +484,39 @@
=20
   </script>
   <script>
+    // URLSearchParams subclass to make it easier to construct Bugzilla =
queries
+    class BZSearch extends URLSearchParams {
+      appendNotResolved() {
+        this.append("resolution", "---");
+      }
+
+      // appendQuery: add the specified field/operator/value as fN/oN/vN=
 parameters.
+      appendQuery(field, operator, value) {
+        const index =3D this.nextFieldIndex();
+        this.append(`f${index}`, field);
+        this.append(`o${index}`, operator);
+        this.append(`v${index}`, value);
+      };
+
+      // appendOperator: add a logical operator (fN/vN) pair to the sear=
ch
+      appendOperator(operator) {
+        const index =3D this.nextFieldIndex();
+        this.append(`f${index}`, "OP");
+        this.append(`j${index}`, operator);
+      };
+
+      // nextFieldIndex: return the next field number, searching for fie=
lds of the form f<int>.
+      nextFieldIndex() {
+        let max =3D -1;
+        for (const [key] of this) {
+          const match =3D /^f(\d+)$/.exec(key);
+          if (match)
+            max =3D Math.max(max, Number(match[1]));
+        }
+        return max + 1;
+      };
+    }
+
     const serverUrl =3D "https://bugzilla.yoctoproject.org";
=20
     const ignoreProducts =3D [
@@ -604,7 +637,7 @@
     }
=20
     function bugsByWhiteboard(keyword) {
-      const params =3D new URLSearchParams({
+      const params =3D new BZSearch({
         resolution: "---",
         status_whiteboard: keyword,
         status_whiteboard_type: "anywords",
@@ -613,7 +646,7 @@
     }
=20
     function bugsByPriority(priority) {
-      const params =3D new URLSearchParams({
+      const params =3D new BZSearch({
         resolution: "---",
         priority: priority
       });
@@ -621,14 +654,14 @@
     }
=20
     function bugsByStatus(status) {
-      const params =3D new URLSearchParams({
+      const params =3D new BZSearch({
         bug_status: status
       });
       return params;
     }
=20
     function bugsInactive(operator) {
-      const params =3D new URLSearchParams({
+      const params =3D new BZSearch({
         resolution: "---",
         f1: "days_elapsed",
         o1: "greaterthaneq",
@@ -729,7 +762,7 @@
     async function bugsOldMilestone() {
       const activeMilestones =3D await activeMilestonesPromise;
=20
-      const params =3D new URLSearchParams({
+      const params =3D new BZSearch({
         resolution: "---",
         f1: "target_milestone",
         o1: "notregexp",
--=20
2.43.0


