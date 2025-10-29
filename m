Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0FDCCF9EE
	for <webhook@archiver.kernel.org>; Wed, 29 Oct 2025 14:21:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.7027.1761747661238048615
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Oct 2025 07:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13CEF1C2B
	for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 07:20:53 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 823773F66E
	for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 07:21:00 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 2/3] dashboard/bugtriage: improve active milestone logic
Date: Wed, 29 Oct 2025 14:20:57 +0000
Message-ID: <20251029142058.3066156-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029142058.3066156-1-ross.burton@arm.com>
References: <20251029142058.3066156-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Oct 2025 14:21:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2402

The next major release is now 6.0, so we should create milestone releases
for that release and consider them active.  Do a little refactoring to
reduce duplication of the milestone creation.

Also I expect we'll be creating a 6.99 target shortly, so consider that
active too.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index a51279ab..891510f0 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -291,6 +291,7 @@
         "---",
         "0.0.0",
         "5.99",
+        "6.99",
         "Q1",
         "Q2",
         "Q3",
@@ -327,21 +328,24 @@
         } else {
           // If there's not a latest_tag set then this is the current de=
velopment cycle.
=20
+          function createMilestones(version) {
+            // Create all milestones for a specific version
+            return new Set([1, 2, 3, 4].map((m) =3D> `${version} M${m}`)=
);
+          }
+
           // The current release is active (e.g. 5.3)
           active.push(release.series_version);
=20
           // And so is the next minor release (eg 5.4)
           let parts =3D release.series_version.split(".");
           parts[parts.length - 1]++;
-          const next =3D parts.join(".");
+          let next =3D parts.join(".");
           active.push(next);
-
           // And all of the next releases milestones
-          let milestones =3D new Set([1, 2, 3, 4].map((m) =3D> `${next} =
M${m}`));
-          active.push(...milestones);
+          active.push(...createMilestones(next));
=20
           // All remaining milestones in this release
-          milestones =3D new Set([1, 2, 3, 4].map((m) =3D> `${release.se=
ries_version} M${m}`));
+          let milestones =3D createMilestones(release.series_version);
           // Remove the milestones that have been releases. Map the tag =
names to milestone names here.
           const seenMilestones =3D new Set(release.releases.map((s) =3D>=
 s.replace("_", " ")));
           milestones =3D milestones.difference(seenMilestones);
@@ -349,7 +353,11 @@
=20
           // The next major release (eg 6.0) is active
           parts =3D release.series_version.split(".");
-          active.push(`${parseInt(parts[0])+1}.0`);
+          next =3D `${parseInt(parts[0])+1}.0`
+          active.push(next);
+          // And all of the next releases milestones
+          active.push(...createMilestones(next));
+
           console.log(active);
         }
       }
--=20
2.43.0


