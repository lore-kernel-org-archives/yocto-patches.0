Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74FEC7115B
	for <webhook@archiver.kernel.org>; Thu, 19 Jun 2025 15:10:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.2071.1750345844528009845
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Jun 2025 08:10:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAC37113E
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Jun 2025 08:10:23 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E3C83F58B
	for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Jun 2025 08:10:43 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] bugtriage: consider more point releases as in the future
Date: Thu, 19 Jun 2025 16:10:38 +0100
Message-ID: <20250619151038.1773147-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Jun 2025 15:10:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1663

There is a bug which has the Target Milestone of 5.0.15 and appears in
the Old Milestone list despite the latest 5.0.x release being 5.0.10.

This happened because we only considered the next three point releases,
so extend the list of future point releases to ten to ensure that we
include all realistic versions.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index 19f66759..1cca4928 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -318,8 +318,8 @@
           parts.length =3D 3;
           parts.fill(0, origlen);
=20
-          // Add the next three point releases
-          for (let i =3D 0; i < 3; i++) {
+          // Add the next ten point releases to be sure we cover all the=
 future releases.
+          for (let i =3D 0; i < 10; i++) {
             // Let JavaScript so-called-typing ignore the fact that we'r=
e incrementing a string
             parts[parts.length - 1]++;
             active.push(parts.join("."));
--=20
2.43.0


