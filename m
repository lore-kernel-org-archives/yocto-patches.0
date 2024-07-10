Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1131C3DA45
	for <webhook@archiver.kernel.org>; Wed, 10 Jul 2024 11:46:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.12430.1720611966520967798
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jul 2024 04:46:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03599106F
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 04:46:31 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FFB53F766
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 04:46:05 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper master] config.json: add a builder for meta-webose
Date: Wed, 10 Jul 2024 12:45:58 +0100
Message-Id: <20240710114558.1486869-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jul 2024 11:46:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/418

Add a minimal (although still substantial) build of meta-webose for LG.
Because meta-webose has complex layer appends and dependencies we need
to manually set BBFILE_PRIORITY and rewrite bblayer.conf to match what
their custom build scripts currently do.

Builds against oe-core master are known to not work at present, but this
will be backported to kirkstone which is the latest supported release.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 config.json | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/config.json b/config.json
index 4a7099a7..1acdbc91 100644
--- a/config.json
+++ b/config.json
@@ -1748,6 +1748,32 @@
                     "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=3D:1=
 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"]
             }
         },
+        "meta-webosose" : {
+            "NEEDREPOS" : ["poky", "meta-webosose", "meta-clang", "meta-=
openembedded", "meta-qt6"],
+            "DISTRO": "webos",
+            "MACHINE": "qemux86-64",
+            "NOLAYERADD": ["meta-clang", "meta-qt6", "meta-webosose", "m=
eta-openembedded"],
+            "extravars" : [
+                "WEBOS_TARGET_DISTRO_VARIANT =3D 'minimal'",
+                "PACKAGE_CLASSES =3D 'package_ipk'",
+                "IMAGE_FEATURES:remove =3D 'webos-extract-ls2-api'",
+                "BBFILE_PRIORITY_openembedded-layer:forcevariable =3D '1=
0'",
+                "BBFILE_PRIORITY_multimedia-layer:forcevariable =3D '11'=
",
+                "BBFILE_PRIORITY_networking-layer:forcevariable =3D '12'=
",
+                "BBFILE_PRIORITY_meta-python:forcevariable =3D '13'",
+                "BBFILE_PRIORITY_filesystems-layer:forcevariable =3D '14=
'",
+                "BBFILE_PRIORITY_clang-layer:forcevariable =3D '15'",
+                "BBFILE_PRIORITY_qt6-layer:forcevariable =3D '20'"
+            ],
+            "step1": {
+                "shortname": "Fix bblayers.conf",
+                "EXTRACMDS": ["echo 'BBLAYERS =3D \" \\' >> conf/bblayer=
s.conf; for i in meta-poky meta-yocto-bsp meta-webosose/meta-webos meta-w=
ebosose/meta-webos-backports/meta-webos-backports-5.0 meta-webosose/meta-=
webos-backports/meta-webos-backports-4.3 meta-webosose/meta-webos-backpor=
ts/meta-webos-backports-4.2 meta-webosose/meta-webos-backports/meta-webos=
-backports-4.1 meta-qt6 meta-clang meta-openembedded/meta-filesystems met=
a-openembedded/meta-python meta-openembedded/meta-networking meta-openemb=
edded/meta-multimedia meta-openembedded/meta-oe meta; do echo \" ${HELPER=
BUILDDIR}/../$i \\ \" >> conf/bblayers.conf; done; echo '\"' >> conf/bbla=
yers.conf"]
+            },
+            "step2" : {
+                "shortname" : "Build webos-image",
+                "BBTARGETS" : "webos-image"
+            }
+        },
         "a-quick" : {
             "TEMPLATE" : "trigger-build"
         },
@@ -1894,6 +1920,12 @@
             "revision" : "HEAD",
             "no-layer-add" : true
         },
+        "meta-webosose" : {
+            "url" : "https://github.com/webosose/meta-webosose.git",
+            "branch" : "master",
+            "revision" : "HEAD",
+            "no-layer-add" : true
+        },
         "auto-upgrade-helper" : {
             "url" : "git://git.yoctoproject.org/auto-upgrade-helper",
             "branch" : "master",
--=20
2.34.1


