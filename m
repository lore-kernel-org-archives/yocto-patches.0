Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1A2C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 13:17:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.14371.1741871821235252629
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Mar 2025 06:17:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F8A1C00
	for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Mar 2025 06:17:10 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFA1B3F673
	for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Mar 2025 06:16:59 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper] scripts/list-ab-workers
Date: Thu, 13 Mar 2025 13:16:56 +0000
Message-ID: <20250313131656.3404378-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Mar 2025 13:17:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1200

This is a a little script I have that should be somewhere public. It
simply lists all of the connected workers, but is very useful when used
in conjunction with parallel-ssh to run commands on every worker at once.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/list-ab-workers.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 scripts/list-ab-workers.py

diff --git a/scripts/list-ab-workers.py b/scripts/list-ab-workers.py
new file mode 100644
index 00000000..26f03982
--- /dev/null
+++ b/scripts/list-ab-workers.py
@@ -0,0 +1,20 @@
+#! /usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# This script will list all of the connected workers on the autobuilder.
+
+import requests
+
+buildbot_api =3D "https://autobuilder.yoctoproject.org/valkyrie/api/v2/"
+
+http =3D requests.Session()
+
+def buildbot(method, **args):
+    return http.get(buildbot_api + method, params=3Dargs).json()
+
+for worker in buildbot(f"workers")["workers"]:
+    # Skip workers that are not connected to any controllers
+    if not worker["connected_to"]:
+        continue
+    print(f"{worker['name']}.yocto.io")
--=20
2.43.0


