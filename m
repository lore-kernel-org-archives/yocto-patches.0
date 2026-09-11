Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A58BC88E56
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 21:03:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49575.1789160636450497353
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 14:03:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=VL6yglKR;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EB9B2E99
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:52 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BF4A3F8C6
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789160635; bh=2tmlMXoHwnUhk5I4PHhvaoonbjLaxe1x2d1oebMJ+fY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VL6yglKRmNE4u7IJBey1kQ2vuoTG3rLTI70Hs8yrYhHpC/ionqaZNgcj1meqxwqha
	 xUWRtgOnVyy45AYbvDdhQYGX6HPgv+0wf6tcy0hHKroNF4Uf8StgaQkOsURI5xm3hy
	 wXq/5GRSb+N5gTSmxHR1qaG6+1R2e+azgxwYYzWI=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 2/8] dashboard/bugtriage: fetch releases.json once
Date: Fri, 11 Sep 2026 22:03:45 +0100
Message-ID: <20260911210351.2020798-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911210351.2020798-1-ross.burton@arm.com>
References: <20260911210351.2020798-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 21:03:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4817

Assume that the releases.json doesn't change often and fetch it once
whilst the page is loading instead of every time we reload the Old
Milestones section.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 8427b0d1..7970b5dd 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -724,8 +724,10 @@
       return active;
     }
=20
+    const activeMilestonesPromise =3D getActiveReleases();
+
     async function bugsOldMilestone(table) {
-      const activeMilestones =3D await getActiveReleases();
+      const activeMilestones =3D await activeMilestonesPromise;
=20
       const params =3D new URLSearchParams({
         resolution: "---",
--=20
2.43.0


