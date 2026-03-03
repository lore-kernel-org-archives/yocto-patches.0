Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A0BEC1428
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 10:46:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15511.1772534785689667437
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Mar 2026 02:46:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D784B497
	for <yocto-patches@lists.yoctoproject.org>; Tue,  3 Mar 2026 02:46:18 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBF263F7BD
	for <yocto-patches@lists.yoctoproject.org>; Tue,  3 Mar 2026 02:46:24 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] config.json: update meta-arm checklayer invocation
Date: Tue,  3 Mar 2026 10:46:19 +0000
Message-ID: <20260303104619.2755812-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Mar 2026 10:46:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3317

meta-gem5 and meta-arm-autonomy were deleted long ago.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index c7c92c3a..1a8284cd 100644
--- a/config.json
+++ b/config.json
@@ -1305,7 +1305,7 @@
             "step2" : {
                 "shortname" : "Test meta-arm YP Compatibility",
                 "MACHINE" : "qemuarm64",
-                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-arm/me=
ta-arm ../meta-arm/meta-arm-toolchain ../meta-arm/meta-arm-bsp ../meta-ar=
m/meta-gem5 ../meta-arm/meta-arm-autonomy --dependency ../meta-openembedd=
ed/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta=
-python ../meta-poky ../meta-openembedded/meta-filesystems ../meta-virtua=
lization --no-auto-dependency"]
+                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-arm/me=
ta-arm ../meta-arm/meta-arm-toolchain ../meta-arm/meta-arm-bsp --dependen=
cy ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../m=
eta-openembedded/meta-python ../meta-poky ../meta-openembedded/meta-files=
ystems ../meta-virtualization --no-auto-dependency"]
             },
             "step3" : {
                 "shortname" : "Test meta-aws YP Compatibility",
--=20
2.43.0


