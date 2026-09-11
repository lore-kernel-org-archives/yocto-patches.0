Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F4FC88E5C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 21:04:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49579.1789160639244625283
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 14:03:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=kxOnjsud;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 185212E96
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:55 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 718F53F8C6
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789160638; bh=xF/ZN9eiPDi2wQSTLT+7/1XmgAAgicSZC/qkmhLfgis=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kxOnjsudpbvVotmHH++/fnwqIG6vR1uWr2RIBtHCeTiTSSKoIbux5mRb0GByv+oHw
	 BbY2sqQjQiFHqaJohoDxKhzQvIlBiaesbAx6WxplW5XChGQ630P+YtVcY4FgQK5fnH
	 TMrsJaRWdd+Qx0ocaSWTF7XgP63DO1H5Vjffw1u4=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 7/8] dashboard/bugtriage: rewrite queries using BZSearch functions
Date: Fri, 11 Sep 2026 22:03:50 +0100
Message-ID: <20260911210351.2020798-7-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911210351.2020798-1-ross.burton@arm.com>
References: <20260911210351.2020798-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 21:04:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4822

Use the new BZSearch functions to construct the queries. No change to
the actual queries, just the code.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 43 ++++++++++----------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 939dd8fb..c34fcaf3 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -636,39 +636,31 @@
     }
=20
     function bugsByWhiteboard(keyword) {
-      const params =3D new BZSearch({
-        resolution: "---",
-        status_whiteboard: keyword,
-        status_whiteboard_type: "anywords",
-      });
+      const params =3D new BZSearch();
+      params.append("status_whiteboard", keyword);
+      params.append("status_whiteboard_type", "anywords");
+      params.appendNotResolved();
       return params;
     }
=20
     function bugsByPriority(priority) {
-      const params =3D new BZSearch({
-        resolution: "---",
-        priority: priority
-      });
+      const params =3D new BZSearch();
+      params.appendNotResolved();
+      params.append("priority", priority);
       return params;
     }
=20
     function bugsByStatus(status) {
-      const params =3D new BZSearch({
-        bug_status: status
-      });
+      const params =3D new BZSearch();
+      params.append("bug_status", status);
       return params;
     }
=20
     function bugsInactive(operator) {
-      const params =3D new BZSearch({
-        resolution: "---",
-        f1: "days_elapsed",
-        o1: "greaterthaneq",
-        v1: 365 * 2,
-        f2: "bug_severity",
-        o2: operator,
-        v2: "enhancement"
-      });
+      const params =3D new BZSearch();
+      params.appendNotResolved();
+      params.appendQuery("days_elapsed", "greaterthaneq", 365 * 2);
+      params.appendQuery("bug_severity", operator, "enhancement");
       return params;
     }
=20
@@ -761,12 +753,9 @@
     async function bugsOldMilestone() {
       const activeMilestones =3D await activeMilestonesPromise;
=20
-      const params =3D new BZSearch({
-        resolution: "---",
-        f1: "target_milestone",
-        o1: "notregexp",
-        v1: `^(${activeMilestones.map((s) =3D> escapeRegExp(s)).join("|"=
)})$`
-      });
+      const params =3D new BZSearch();
+      params.appendNotResolved();
+      params.appendQuery("target_milestone", "notregexp", `^(${activeMil=
estones.map((s) =3D> escapeRegExp(s)).join("|")})$`);
       return params;
     }
=20
--=20
2.43.0


