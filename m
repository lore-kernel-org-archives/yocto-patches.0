Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD9EC36008
	for <webhook@archiver.kernel.org>; Wed, 26 Mar 2025 16:55:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.27806.1743008131055384945
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Mar 2025 09:55:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E3121424
	for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 09:55:36 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 424503F58B
	for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 09:55:30 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder2] config.py: add musl-qemuarm64 to the shared builder list
Date: Wed, 26 Mar 2025 16:55:27 +0000
Message-ID: <20250326165527.921637-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Mar 2025 16:55:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1258

This adds musl-qemuarm64 to a-quick and a-full, alongwith musl-qemux86.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index be3829f..e0c4c39 100644
--- a/config.py
+++ b/config.py
@@ -93,7 +93,9 @@ trigger_builders_wait_shared =3D [
     "pkgman-non-rpm",
     "build-appliance", "buildtools",
     "non-gpl3", "wic",
-    "poky-tiny", "musl-qemux86", "musl-qemux86-64", "no-x11",
+    "poky-tiny",
+    "musl-qemuarm64", "musl-qemux86", "musl-qemux86-64",
+    "no-x11",
     "qa-extras", "qa-extras2",
     "check-layer", "meta-mingw",
     "reproducible",
--=20
2.43.0


