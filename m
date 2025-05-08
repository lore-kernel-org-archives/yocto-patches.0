Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D44AC3ABBE
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 19:56:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.5316.1746734187128567040
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 May 2025 12:56:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0247B1E2F
	for <yocto-patches@lists.yoctoproject.org>; Thu,  8 May 2025 12:56:16 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 342C23F5A1
	for <yocto-patches@lists.yoctoproject.org>; Thu,  8 May 2025 12:56:26 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] dashboard: include the next major release as an active release series
Date: Thu,  8 May 2025 20:56:21 +0100
Message-ID: <20250508195621.1494886-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 May 2025 19:56:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1538

We have a 6.0 target in bugilla now, so consider that active.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 2abeba48..19f66759 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -327,13 +327,15 @@
         } else {
           // If there's not a latest_tag set then this is the current de=
velopment cycle.
=20
-          // The current major release is active
+          // The current release is active (e.g. 5.3)
           active.push(release.series_version);
-          // And so is the next major release
-          const parts =3D release.series_version.split(".")
+
+          // And so is the next minor release (eg 5.4)
+          let parts =3D release.series_version.split(".");
           parts[parts.length - 1]++;
-          const next =3D parts.join(".")
+          const next =3D parts.join(".");
           active.push(next);
+
           // And all of the next releases milestones
           let milestones =3D new Set([1, 2, 3, 4].map((m) =3D> `${next} =
M${m}`));
           active.push(...milestones);
@@ -344,6 +346,11 @@
           const seenMilestones =3D new Set(release.releases.map((s) =3D>=
 s.replace("_", " ")));
           milestones =3D milestones.difference(seenMilestones);
           active.push(...milestones);
+
+          // The next major release (eg 6.0) is active
+          parts =3D release.series_version.split(".");
+          active.push(`${parseInt(parts[0])+1}.0`);
+          console.log(active);
         }
       }
       return active;
--=20
2.43.0


