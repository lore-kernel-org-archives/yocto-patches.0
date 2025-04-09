Return-Path: <hieu2.nguyen@lge.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECFFC36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 13:57:43 +0000 (UTC)
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.53])
 by mx.groups.io with SMTP id smtpd.web11.9235.1744207056981215171
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Apr 2025 06:57:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: lge.com, ip: 156.147.23.53, mailfrom: hieu2.nguyen@lge.com)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
	by 156.147.23.53 with ESMTP; 9 Apr 2025 22:57:34 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: hieu2.nguyen@lge.com
Received: from unknown (HELO vsl.LGE.NET) (10.218.140.120)
	by 156.147.1.151 with ESMTP; 9 Apr 2025 22:57:34 +0900
X-Original-SENDERIP: 10.218.140.120
X-Original-MAILFROM: hieu2.nguyen@lge.com
From: hieu2.nguyen@lge.com
To: yocto-patches@lists.yoctoproject.org,
	mathieu.dubois-briand@bootlin.com
Cc: martin.jansa@gmail.com,
	Hieu Van Nguyen <hieu2.nguyen@lge.com>
Subject: [yocto-autobuilder-helper][scarthgap][PATCH] config.json: add a builder for meta-webosose
Date: Wed,  9 Apr 2025 22:57:14 +0900
Message-ID: <20250409135714.3204718-1-hieu2.nguyen@lge.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 13:57:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1340

From: Hieu Van Nguyen <hieu2.nguyen@lge.com>

Backport from master, with the extend layers updated and
the target default branch changed to scarthgap-webos.

Signed-off-by: Hieu Van Nguyen <hieu2.nguyen@lge.com>
---
 config.json | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/config.json b/config.json
index da328ea..a63e239 100644
--- a/config.json
+++ b/config.json
@@ -1742,6 +1742,32 @@
                     "EXTRACMDS" : ["${SCRIPTSDIR}/checkvnc; DISPLAY=:1 oe-selftest -r buildoptions.SourceMirroring.test_yocto_source_mirror"]
             }
         },
+        "meta-webosose" : {
+            "NEEDREPOS" : ["poky", "meta-webosose", "meta-security", "meta-clang", "meta-openembedded", "meta-qt6"],
+            "DISTRO": "webos",
+            "MACHINE": "qemux86-64",
+            "NOLAYERADD": ["meta-security", "meta-clang", "meta-qt6", "meta-webosose", "meta-openembedded"],
+            "extravars" : [
+                "WEBOS_TARGET_DISTRO_VARIANT = 'minimal'",
+                "PACKAGE_CLASSES = 'package_ipk'",
+                "BBFILE_PRIORITY_openembedded-layer:forcevariable = '10'",
+                "BBFILE_PRIORITY_multimedia-layer:forcevariable = '11'",
+                "BBFILE_PRIORITY_networking-layer:forcevariable = '12'",
+                "BBFILE_PRIORITY_meta-python:forcevariable = '13'",
+                "BBFILE_PRIORITY_filesystems-layer:forcevariable = '14'",
+                "BBFILE_PRIORITY_clang-layer:forcevariable = '15'",
+                "BBFILE_PRIORITY_qt6-layer:forcevariable = '20'",
+                "BBFILE_PRIORITY_security-layer:forcevariable = '21'"
+            ],
+            "step1": {
+                "shortname": "Fix bblayers.conf",
+                "EXTRACMDS": ["echo 'BBLAYERS = \" \\' >> conf/bblayers.conf; for i in meta-poky meta-yocto-bsp meta-security meta-webosose/meta-webos meta-webosose/meta-webos-backports/meta-webos-backports-5.2 meta-webosose/meta-webos-backports/meta-webos-backports-5.1 meta-qt6 meta-clang meta-openembedded/meta-filesystems meta-openembedded/meta-python meta-openembedded/meta-networking meta-openembedded/meta-multimedia meta-openembedded/meta-oe meta; do echo \" ${HELPERBUILDDIR}/../$i \\ \" >> conf/bblayers.conf; done; echo '\"' >> conf/bblayers.conf"]
+            },
+            "step2" : {
+                "shortname" : "Build webos-image",
+                "BBTARGETS" : "webos-image"
+            }
+        },
         "a-quick" : {
             "TEMPLATE" : "trigger-build"
         },
@@ -1893,6 +1919,12 @@
             "branch" : "master",
             "revision" : "HEAD",
             "no-layer-add" : true
+        },
+        "meta-webosose" : {
+            "url" : "https://github.com/webosose/meta-webosose.git",
+            "branch" : "scarthgap-webos",
+            "revision" : "HEAD",
+            "no-layer-add" : true
         }
     },
     "buildtools" : {
-- 
2.48.1


