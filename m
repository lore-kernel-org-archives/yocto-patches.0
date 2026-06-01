Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD3DCD6E56
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 12:04:25 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26851.1780315463604995984
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 05:04:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=GyVDEfi8;
 spf=pass (domain: ericsson.com, ip: 52.101.70.55, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSwIoxBscezUO60HTsn+uTi6lRlMN4XtJEmDHHWsNgQkAKVD1KG7vcFoWKQPdeKZCg0sm0Q0NFNStymtJTKc0sgstL/9DasWHwC2nLn6TfOomG35ra5Giz19oHITwdIt7Kb6ZL2zjRXVF9WOB4rE0t3ga0wHZz+fxOlk9qNq4QTEpOdXIt/ljOcMbVX08mrWpW+dtwmuspIIwM9lFaZRsh9KqcditGEckIouAQWWBqxNzdbrnsQFtyeHb5rFs/3wV/Yrxx2e4TBA1sVGT6Q82dqRJJyNepXZksdym/dRpLPoo6gl0hps9c4p8Atj0xAziDuW29vwKUTAvY7OMjL6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhguVmTCFVN7WBiWoyUOAaX0tFMVc4nU1YTqCRaB288=;
 b=Z2CYSCzvuugfYtqCAjf8rms4pG5aaUZkbkYhu9BFk+N9R0wb1/yDAVt6xpCpiLqNGsDy/QXjBikLceICnhUF3rrpUv9kMs64B+ji4Ur4XBUYdoX/PdXbXnOB41dxLwLlAGnOBuk5m4nsCyGK3bhh9CBZx4yL1AL1uXJ6TG/ISAHlStAp7BwA0oWA8mqSYP5zdVCiKpmsB6BkLvvth59p+zZbhwyr9+h5hswfJgMhp91PZJa5JUbt5jN/JKccLLje+rikgeVOZu/CWVJuJy/07qn3YATBSWj8wkwq6JJicWX3qpkUfYZIIyzhsRwwjTMyL0digczhkjI61ThqKVyK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhguVmTCFVN7WBiWoyUOAaX0tFMVc4nU1YTqCRaB288=;
 b=GyVDEfi8Y7dAAOTAFXvpZlZFN6AmbYcrb4qYaCgBkLdDaPmqAjvXdarRrZC72WkYO8+UOEnMihpH70eRAGQIdu5lLtfioWjIQGyTHDLDkn3Kk8wPoSV6hcm1IWoCv5r075T2+LUF21w/WwPoeAwvcZl2KXhIfGwlXU80MXiGaMp14NXl9xhH6SH9zDS9Ag+GXDvwQQc3x1X+a6hLu105nNuYa8ceRMUKt7nLUwl5CCB20XKAlSeJCH8Z99TBHM+72CztJZmSO9ysqqzh/HdbIsNULOAGmXpT3RPg2mnyQ+VojAKQnkq7sjeSfR0/ns3ZcZMXTgj/2Z1go55fz4U5vQ==
Received: from DU2PR04CA0265.eurprd04.prod.outlook.com (2603:10a6:10:28e::30)
 by AS8PR07MB8314.eurprd07.prod.outlook.com (2603:10a6:20b:37d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 12:04:17 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::40) by DU2PR04CA0265.outlook.office365.com
 (2603:10a6:10:28e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 12:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 12:04:17 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 14:04:17 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id C55FD4054DC7;
	Mon,  1 Jun 2026 13:34:15 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id AECEC7003739; Mon,  1 Jun 2026 13:34:15 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>
Subject: [AUH] [PATCH] upgrade-helper: add state module and --incremental mode
Date: Mon, 1 Jun 2026 13:34:08 +0200
Message-ID: <20260601113410.1896488-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B90:EE_|AS8PR07MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 9169f62e-7f24-4e02-d402-08debfd5e814
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|6133799003|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 
	pjN9Kc4sjCqVZQvUOv02Vkh1dnhlyAbkbcLQKaMnmcALN4g9sS47rU0YwdUN6Yo9Wrs+321umzx+5YvBhGdnrTArzk+oK6jXKDXYNfE94pZ/QyTVWH0oK/KZxEjg988H+85Ym+ECV6ZlGG5OINWevEhB5qys2bjslsqxqhEqvQfbXC4EkREVq7fBCECFcAoaYDN/qKw4XEZcLbYbxOoZZRR/pdyGRJPrMKPCeN5GU/2BdB/ZpwsBlIjvqRchg6l9T5UXRHQ6sgy7w6E3amrbsgWcs4/CV7nWNaI1t3rrbDIaZNJlFAF7HLOPfM9u5hBb5ZQpBy6j2HSM+49HqNVxk+S62v68R+Tacu/byDyQkwICKiyNmjf0f0YJQzRY0QVTqNGYoIp1Uzr8FsShx6Soiuz2Ys/XhA+k1pW+z3NsTGEbXi5IpoX35K0wrH30TtoXtxgwGSpyAzi4oCQyp7rA6PqInW7iuZMthEsCqa6DeeOlVdwF8+FFwYGw8WFirSeGUrrubeGPiGoYrUGi+MbSt8f0HD1hBiY+2jILwgCU45fsAhL1IjBawp1q1G/3dQR0w/qynQ4vGY7EVFmi8+A+3Duqva5V0pxSsar+q7KcjeWAURybr4jm2y0rpargjC2L/3jAWNEjQds556IDIiiOp/hKT3hMSwKJpQG3qivMJz9ViY6Ng5lrEkIilWTQRZvzF585RGnYW7xvMn7L0rXl0+PdnWl6+t/a+DR/MjmIuuc=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(6133799003)(18002099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	3LogOw5P5Msygv07rdbOLpxyaRbrGXvQCLpJJ7WuBRcDoQCrqFLFG9YCBV62gBthx/RJBFHJN0AhNwHWjlYQ4ICOOmoV5nP2zI16OTrxfMjEsCI2WWmuy4H+BQm0jbKLRVRYFBEMVbIGqlSB0ktFPU8qXLkLyO7V1Lzy21FJJWZkeASuoqCT45UN43BgRXejtUGT8ayj+mQ20DgD06+ktW+Uevo++C5j+TNq5g5z2jQnMH9DiRb4/J6doGGH2ElGQZR+H4+RmKnM567y2EJDsssq4c0DkcYhRCA3OiDLmWVmHOnN6xuCAv64yz1tynnc/3WvCFy1uCtlk9Ik1+/B6bSQiJOQsBokHjWuSvy8J1x2tnfXNsVxEcurgN3OPkQ+jsYyLwtu4p3hwgPmzNBp5Yhm7F2bFIO4GknxrdKKYJ698/hv+rRWEe8jpsexL8dz
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:04:17.5038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9169f62e-7f24-4e02-d402-08debfd5e814
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8314
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 12:04:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4091

From: Daniel Turull <daniel.turull@ericsson.com>

Without this, every AUH run retries all candidates regardless of previous
outcomes, wasting time on recipes that consistently fail or were already
upgraded recently.

Add modules/state.py which persists upgrade results to a JSON state file
(auh-state.json in the upgrade-helper work directory, typically
$BUILDDIR/upgrade-helper/). The new --incremental flag activates this
tracking and skips package groups where all packages were recently attempte=
d.

Behavior:
- Failed attempts are retried after retry_interval days (default 30).
- Successful/already-current upgrades are suppressed for success_max_age
  days (default 30).

Tested with master (2026-06-01):
command: ../auto-upgrade-helper/upgrade-helper.py all --incremental -s

- Run 1 (2026-06-01 07:38): 122 attempted, 98 succeeded, 24 failed, 0 skipp=
ed
- Run 2 (2026-06-01 11:17): 1 attempted, 0 succeeded, 1 failed, 26 skipped
- Run 3 (2026-06-01 11:20): 0 attempted, 0 succeeded, 0 failed, 27 skipped

Link: https://lists.openembedded.org/g/openembedded-architecture/message/23=
49

AI-Generated: kiro with claude-opus-4.6 model
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/state.py    | 102 ++++++++++++++++++++++++++++++++++++++++++++
 upgrade-helper.conf |  10 ++++-
 upgrade-helper.py   |  41 ++++++++++++++++++
 3 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 modules/state.py

diff --git a/modules/state.py b/modules/state.py
new file mode 100644
index 0000000..01bc18f
--- /dev/null
+++ b/modules/state.py
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# vim: set ts=3D4 sw=3D4 et:
+#
+# Copyright (c) 2026 Ericsson AB
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-130=
1, USA.
+#
+# AUTHORS
+# Daniel Turull   <daniel.turull@ericsson.com>
+#
+
+import json
+import os
+import time
+
+from logging import warning as W
+
+RESULT_SUCCESS =3D "success"
+RESULT_FAILURE =3D "failure"
+
+STATE_FILENAME =3D "auh-state.json"
+STATE_VERSION =3D 1
+
+SECONDS_PER_DAY =3D 86400
+DEFAULT_COOLDOWN_DAYS =3D 30
+DEFAULT_SUCCESS_MAX_AGE_DAYS =3D 30
+
+
+class State:
+    """Tracks upgrade attempts as {recipe: {version: {timestamp, result}}}=
."""
+
+    def __init__(self, state_dir, cooldown_days=3DDEFAULT_COOLDOWN_DAYS,
+                 success_max_age_days=3DDEFAULT_SUCCESS_MAX_AGE_DAYS):
+        self.path =3D os.path.join(state_dir, STATE_FILENAME)
+        self.cooldown =3D cooldown_days * SECONDS_PER_DAY
+        self.success_max_age =3D success_max_age_days * SECONDS_PER_DAY
+        self.data =3D self._load()
+        self._prune()
+
+    def _load(self):
+        if os.path.exists(self.path):
+            try:
+                with open(self.path) as f:
+                    raw =3D json.load(f)
+            except (json.JSONDecodeError, OSError) as e:
+                W(" %s is corrupt (%s), starting fresh" % (self.path, e))
+                return {}
+            if not isinstance(raw, dict) or raw.get("version") !=3D STATE_=
VERSION:
+                W(" %s: unsupported or missing version, starting fresh"
+                  % self.path)
+                return {}
+            return raw.get("recipes", {})
+        return {}
+
+    def save(self):
+        with open(self.path, "w") as f:
+            json.dump({"version": STATE_VERSION, "recipes": self.data},
+                      f, indent=3D2)
+
+    def record(self, pn, version, result):
+        entry =3D {"timestamp": time.time(), "result": result}
+        if pn not in self.data:
+            self.data[pn] =3D {}
+        self.data[pn][version] =3D entry
+
+    def should_skip(self, pn, version):
+        entry =3D self.data.get(pn, {}).get(version)
+        if not entry:
+            return False
+        age =3D time.time() - entry.get("timestamp", 0)
+        if entry.get("result") =3D=3D RESULT_SUCCESS:
+            return age < self.success_max_age
+        return age < self.cooldown
+
+    def _prune(self):
+        """Remove stale entries older than their respective max-age."""
+        now =3D time.time()
+        for pn in list(self.data):
+            versions =3D self.data[pn]
+            for ver in list(versions):
+                entry =3D versions[ver]
+                age =3D now - entry.get("timestamp", 0)
+                if entry.get("result") =3D=3D RESULT_SUCCESS:
+                    if age > self.success_max_age:
+                        del versions[ver]
+                else:
+                    if age > self.cooldown:
+                        del versions[ver]
+            if not versions:
+                del self.data[pn]
diff --git a/upgrade-helper.conf b/upgrade-helper.conf
index 269bde3..c5dfdde 100644
--- a/upgrade-helper.conf
+++ b/upgrade-helper.conf
@@ -50,7 +50,15 @@
 # passed; does not apply when layer_mode is enabled).
 #blacklist=3Dpython glibc gcc
=20
-# specify the directory where work (patches) will be saved=20
+# When running with --incremental, how many days to wait before retrying
+# a failed upgrade attempt for the same recipe version. Default is 30 days=
.
+#retry_interval=3D30
+
+# When running with --incremental, how many days to skip a successfully
+# upgraded recipe version before attempting it again. Default is 30 days.
+#success_max_age=3D30
+
+# specify the directory where work (patches) will be saved
 # (optional; default is BUILDDIR/upgrade-helper/)
 #workdir=3D
=20
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 40f31c4..339f096 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -59,6 +59,8 @@ from utils.emailhandler import Email
 from statistics import Statistics
 from steps import upgrade_steps
 from testimage import TestImage
+from state import (State, RESULT_SUCCESS, RESULT_FAILURE,
+                   DEFAULT_COOLDOWN_DAYS, DEFAULT_SUCCESS_MAX_AGE_DAYS)
=20
 if not os.getenv('BUILDDIR', False):
     E(" You must source oe-init-build-env before running this script!\n")
@@ -104,6 +106,8 @@ def parse_cmdline():
                         help=3D"do not compile, just change the checksums,=
 remove PR, and commit")
     parser.add_argument("-c", "--config-file", default=3DNone,
                         help=3D"Path to the configuration file. Default is=
 $BUILDDIR/upgrade-helper/upgrade-helper.conf")
+    parser.add_argument("--incremental", action=3D"store_true",
+                        help=3D"skip recipes already attempted (uses JSON =
state file)")
     parser.add_argument("--layer-names", nargs=3D'*', action=3D"store", de=
fault=3D'',
                         help=3D"layers to include in the upgrade research"=
)
     parser.add_argument("--layer-dir", action=3D"store", default=3D'',
@@ -169,6 +173,16 @@ class Updater(object):
             self.email_handler =3D Email(settings)
         self.statistics =3D Statistics()
=20
+        if self.args.incremental:
+            cooldown =3D int(settings.get('retry_interval', DEFAULT_COOLDO=
WN_DAYS))
+            success_max_age =3D int(settings.get('success_max_age',
+                                               DEFAULT_SUCCESS_MAX_AGE_DAY=
S))
+            self.state =3D State(self.uh_dir,
+                               cooldown_days=3Dcooldown,
+                               success_max_age_days=3Dsuccess_max_age)
+        else:
+            self.state =3D None
+
     def _set_options(self):
         self.opts =3D {}
         self.opts['layer_mode'] =3D settings.get('layer_mode', '')
@@ -468,6 +482,14 @@ class Updater(object):
=20
             pkggroups_ctx.append({"name":",".join([pkg_ctx['PN'] for pkg_c=
tx in pkgs_ctx]),"pkgs":pkgs_ctx,"error":None, 'base_dir':self.uh_recipes_a=
ll_dir})
         I(" ############################################################")
+        if self.state:
+            before =3D len(pkggroups_ctx)
+            pkggroups_ctx =3D [g for g in pkggroups_ctx
+                             if not self.state.should_skip(
+                                 g['pkgs'][0]['PN'], g['pkgs'][0]['NPV'])]
+            I(" %d/%d package groups skipped (incremental mode)"
+              % (before - len(pkggroups_ctx), before))
+            total_pkggroups =3D len(pkggroups_ctx)
         if pkggroups_ctx and not self.args.skip_compilation:
             I(" Building gcc runtimes ...")
             for machine in self.opts['machines']:
@@ -520,6 +542,10 @@ class Updater(object):
                 g['error'] =3D e
                 failed_pkggroups_ctx.append(g)
=20
+            # Capture upgrade error before commit_changes() which may
+            # overwrite g['error'] with a git commit failure.
+            upgrade_err =3D g.get('error') if self.state else None
+
             try:
                 self.commit_changes(g)
             except Exception as e:
@@ -534,6 +560,21 @@ class Updater(object):
                     succeeded_pkggroups_ctx.remove(g)
                     failed_pkggroups_ctx.append(g)
=20
+            if self.state:
+                # UpgradeNotNeededError means the recipe is already curren=
t,
+                # which is a successful outcome =E2=80=94 no retry needed.
+                if not upgrade_err or isinstance(upgrade_err, UpgradeNotNe=
ededError):
+                    result =3D RESULT_SUCCESS
+                else:
+                    result =3D RESULT_FAILURE
+                # All packages in a group share the same result because AU=
H
+                # upgrades them atomically; individual outcomes are not tr=
acked.
+                for pkg_ctx in g['pkgs']:
+                    self.state.record(pkg_ctx['PN'], pkg_ctx['NPV'], resul=
t)
+
+        if self.state:
+            self.state.save()
+
         if self.opts['testimage']:
             ctxs =3D {}
             ctxs['succeeded'] =3D succeeded_pkggroups_ctx
--=20
2.51.0


