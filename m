Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96A7C3DA42
	for <webhook@archiver.kernel.org>; Wed, 10 Jul 2024 11:48:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.12445.1720612094082226732
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jul 2024 04:48:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8B2C106F
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 04:48:38 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 458303F766
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 04:48:13 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder2] schedulers.py: add meta-webosose scheduled build
Date: Wed, 10 Jul 2024 12:48:12 +0100
Message-Id: <20240710114812.1487154-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 11:48:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/421

Add a scheduled build (2am on Friday) to run meta-webosose for kirkstone.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 schedulers.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 3fb8e9c..5cf8a60 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -141,6 +141,8 @@ branchdefaults =3D {
         'branch_meta-ti': 'kirkstone',
         'branch_meta-virtualization': 'kirkstone',
         'branch_oecore': 'kirkstone',
+        'branch_meta-webosose': 'kirkstone-webos',
+        'branch_meta-qt6': '6.6.0',
     },
     'honister': {
         'branch': 'honister',
@@ -554,3 +556,7 @@ schedulers.append(sched.AnyBranchScheduler(name=3D"bi=
tbake-docs-changed",
             onlyImportant=3DTrue,
             treeStableTimer=3D60,
             builderNames=3D["docs"]))
+
+# Run meta-webosose for kirkstone once a week on weekends (2am on Friday=
)
+schedulers.append(sched.Nightly(name=3D'nightly-meta-webosose', branch=3D=
'kirkstone', properties=3Dparent_default_props('meta-webosose', 'kirkston=
e'),
+                  builderNames=3D['meta-webosose'], hour=3D2, minute=3D0=
, dayOfWeek=3D4))
--=20
2.34.1


