Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58376C369D6
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 14:50:50 +0000 (UTC)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
 by mx.groups.io with SMTP id smtpd.web11.13629.1744987844387777776
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Apr 2025 07:50:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZfHkV5rwtz185;
	Fri, 18 Apr 2025 16:50:42 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZfHkV1cJmz3yc;
	Fri, 18 Apr 2025 16:50:42 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 18 Apr 2025 16:50:15 +0200
Subject: [meta-rockchip PATCH v2 3/9] bsp: rkbin: add native recipe for
 tools (ddrbin_tool.py)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-ddrbin-custom-v2-3-700828527faf@cherry.de>
References: <20250418-ddrbin-custom-v2-0-700828527faf@cherry.de>
In-Reply-To: <20250418-ddrbin-custom-v2-0-700828527faf@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 14:50:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1390

From: Quentin Schulz <quentin.schulz@cherry.de>

This will allow us to use tools from rkbin repo destined to be used on
the host in recipes for the target. For example, ddrbin_tool.py which
is used to modify the configuration of the DDR bin blob.

This has limited usefulness for ddrbin_tool.py as it is a python script
with no external dependencies and could be run directly from
rockchip-ddr-bin recipe. However, this is required so we can decouple
the version of the git repo used for rockchip-ddr-bin DDR bin blob from
the version of the git repo used for ddrbin_tool.py (which is very
recent).

This recipe will be used in a later commit to modify the DDR bin blob if
need be.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 recipes-bsp/rkbin/rockchip-rkbin-native_git.bb | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb
new file mode 100644
index 0000000000000000000000000000000000000000..2adccdd59bbf454bd5264d503d6d5883b94c472d
--- /dev/null
+++ b/recipes-bsp/rkbin/rockchip-rkbin-native_git.bb
@@ -0,0 +1,21 @@
+DESCRIPTION = "Rockchip native tools related to their rkbin blobs, e.g. ddrbin_tool.py"
+
+SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
+SRCREV = "f43a462e7a1429a9d407ae52b4745033034a6cf9"
+LICENSE = "Proprietary"
+LIC_FILES_CHKSUM = "file://../LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
+
+inherit native
+
+S = "${WORKDIR}/git/tools"
+
+# ddrbin_tool.py only uses python and core modules.
+# Yocto depends on a host python anyway so we can simply ignore that dependency
+# and have ddrbin_tool.py run with the host's python instead of building python
+# natively.
+# DEPENDS = "python3-native"
+
+do_install() {
+	install -d "${D}${bindir}"
+	install -m 0755 ddrbin_tool.py "${D}${bindir}"
+}

-- 
2.49.0


