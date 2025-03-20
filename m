Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B750C28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 16:30:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.12360.1742488209112940869
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Mar 2025 09:30:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C941113E
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 09:30:16 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0216D3F673
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 09:30:07 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] scripts/dashboard/bugtriage: don't consider the future milestones as old
Date: Thu, 20 Mar 2025 16:30:04 +0000
Message-ID: <20250320163004.3661846-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Mar 2025 16:30:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1235

We considered the next release to be active, but failed to include the
next release's milestones.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index a6f1b4c3..2abeba48 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -332,10 +332,14 @@
           // And so is the next major release
           const parts =3D release.series_version.split(".")
           parts[parts.length - 1]++;
-          active.push(parts.join("."));
+          const next =3D parts.join(".")
+          active.push(next);
+          // And all of the next releases milestones
+          let milestones =3D new Set([1, 2, 3, 4].map((m) =3D> `${next} =
M${m}`));
+          active.push(...milestones);
=20
           // All remaining milestones in this release
-          let milestones =3D new Set([1, 2, 3, 4].map((m) =3D> `${releas=
e.series_version} M${m}`));
+          milestones =3D new Set([1, 2, 3, 4].map((m) =3D> `${release.se=
ries_version} M${m}`));
           // Remove the milestones that have been releases. Map the tag =
names to milestone names here.
           const seenMilestones =3D new Set(release.releases.map((s) =3D>=
 s.replace("_", " ")));
           milestones =3D milestones.difference(seenMilestones);
--=20
2.43.0


