Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CE5CD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 15:50:31 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23416.1780501823383908833
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 08:50:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=nXBgjwv2;
 spf=pass (domain: ericsson.com, ip: 40.107.159.41, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lp9UtPLloG4ruo9P7usHUFbHTkk5oKrTebKVu+i4XZWXOadLLQUngwc3Usv8rEWc96CHjdfAEsd6XBQIYZPVt5ba3Vb0Uw9wcOjM/2le/a/h/EoSFF5STc+k+I2AFOdLeKxg1SRjxIDJjElNX5z4yGazv4uCMetqfmfwcnJK+k64USnmgm2MKLVGrWD3r8RgZmbD5o82NHIF8S3IofReVKcW7G5hUV2hHG1NMFhBLf8W+EFk9q+yMQ9b1pbe7xaSYr+lndljGJULlvaHODWIMbOIFL1IAXOTqeRKzf3P4YHyeGFtus9K4qYTNkL04LS9EfdeBGDUTXoUXUmrbeUA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muorTeHOWMQJT9QFZUdj2Lvq6yDvud9RWEYKfUgwr20=;
 b=b+YoLgp5AU8QYmu1bcTRdoHnHYf6vYuOwi3GGz1aTEg1dAi38CkdPFbb/K3xOBvQmAHpyRKaydhzp+1Q8iAjMFlQ2coQf3Bo3PeasgsbQ9QORk1qr/Z5ev/z/Xz8MdID1Qtxhr6cSguFKnNmzIUUa5MJrmRkyH3dGveV2zceF3EO8uf9wXgeaTaLWTPzfdXSxRV+ZN1ffaaVrZN6QwxISLqm3tVo/mkgj3rAIR0kUXotUlrnxqUZxQzsymH/rw786M8WhxMmawJKq7fI6zHeyM9aeim9OzUk22XJQX9g9lTif04APX6lCEDVMlMhiy01ZMXCcLcuLSMgxaGr0kKvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muorTeHOWMQJT9QFZUdj2Lvq6yDvud9RWEYKfUgwr20=;
 b=nXBgjwv2uCT9oAnkHzT+4g+mb8Xi1HNzxrQVa+ElOtDYp8nlChG2x5wtFVydkiEFToWqsm3OskA06HwSKXLFHwnZFvEwRt/IQmxe7PmNNtQqcB1X4zjmX1OQk2+25aLzx2lWGMdT+t/kqfxr4Fe3r6eBF9OqxbWsA8hMpwRwwnHne2rEFKtve+65iMDcr03ivU5JPn5i+41dHeIAmbiySFtnHYhNBtXjSkHzWpvQYEeEJZN/VOc1bCQ1cMn2WA00niD8OIMwJH0UT9EokHb9pvi/Au+ChNS0xncjk0MN3Bt64WIZAxEVVVfWKJFc3kYKTQ4yBka1XEqUMgn9aUIHfg==
Received: from AS4P251CA0011.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::7)
 by DBAPR07MB6901.eurprd07.prod.outlook.com (2603:10a6:10:199::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 15:50:17 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::42) by AS4P251CA0011.outlook.office365.com
 (2603:10a6:20b:5d2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 15:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 15:50:17 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 17:50:03 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id C43994215097;
	Wed,  3 Jun 2026 15:40:54 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id A9DB87003739; Wed,  3 Jun 2026 15:40:54 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>
Subject: [AUH] [PATCH v2 1/2] upgrade-helper: add state module and --incremental mode
Date: Wed, 3 Jun 2026 15:40:43 +0200
Message-ID: <20260603134044.3377639-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78F:EE_|DBAPR07MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: 6119e181-23ce-4d0e-9c8a-08dec187cf1e
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|13003099007|6133799003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	j+S/MmMZbIziNo154juoPP4szImmRbPfpP4E5vdfIR1IYJh2T7ArxZMx9D4XHxkc9z/T1qtv973169eOCc5HBOmdvdkbMAf+ckiHOHGxryjTDTEod97jogAuhHdpNpENilEl43SMJh06z76Cf3Tk0ZmHq/dYQBQ4hLr+4UWso7gcOfwVg36na4LRjpKwrm4Epuo71Pbj1RF3/xkXuqqtsnycKX/uIz00KgreCofeko9tiGhGcZdhfNNBaYdssP/EpzrWhdlHNCgLCS3jbQCGjwaY9YC7Td27SKIWAjO8vCesuXrr99SxItWKV8ynsw2pm6kH0GRhPQQd30Y2bkxVgU3ZLPdfNjLUi/TNCbpo9qd5zP3uebaCIaHWaWRSU4iR6ois0BxUOtyomduLR9jkvpQia9ROCNZ7ORf6IQEoI34wv5i4mW1DC+xmPNYdWdA52F5S5Mi1FIDMqElrAzwyYH7zrBeYWl+taRzX9j20Ip2QFn1O/6AzVdMcddfcWH6NZYonVpLxoj7k8qNO9Zh0NDPSzT/exezFFxpIFXMTL1ZzUwQ1MDPAIiE8Ie9R9jCZ7YLaw3NlJ8OjFF7jkaDspGX+X3uWEqHFAmtcaQJum2jifwMpKRDBw9FdIHV+v/2Uqf0yxi5+rwL6uINmBRYCnE1gubOFMb/QHqWQRJfLC0/Qkh2FlvgcOqDifGdSib+xhZVDhvxjC9NRpQag919yjrll33FqNu5goXOvIU7XNXc=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(13003099007)(6133799003)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	2QEkvxD78EkJCH6Y1RSj5r2/qcMTK7UALJ/W40+LO6/xDjZFqxHPkOwST4klnbLt6msTsjd03oCBfncNIkM8FkATSeBygvGGBDiGQyubnm1WWzBhV7c3y7NpQi+/MktjTefu1VM5c7THoEk2OvducQ0Un/vV5QPLUXEMqx0N9TN1awGWFNZBf+yYjwDE1hq+StuMV11XiLqc4E7ElG9H1B5JDz6U0r9An5dA7z8enNe7J51cVTbS25bqj5gNiOB4miyQ9+x8ZofEosle+U+8WWm+nHD5HmiJsWt9wQE8kIEWs+90Fv8NVeqoNr5tDr7wkn/WlArOro03Jwf3KVKUWpf8SusF8KNAQOIZJKV3/2vQjUuRLrCZKCSzKEVB6QhdzuL2woHs2+bhGiPPV3WwpJ/7r+svVaAuDftVsybip1AgoTaTxERA0m0D8lRbWCzp
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:50:17.2163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6119e181-23ce-4d0e-9c8a-08dec187cf1e
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6901
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 15:50:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4121

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

2nd test on master (2026-06-02)

Now in the second run we get the skipping message

INFO: piglit 1.0-new-commits-available: skipping (last attempt 2026-06-02 1=
3:38:01 result=3Dfailure; will retry in 30 day(s))
INFO: libinput 1.31.2: skipping (last attempt 2026-06-02 13:40:03 result=3D=
failure; will retry in 30 day(s))
INFO: alsa-ucm-conf 1.2.16: skipping (last attempt 2026-06-02 13:43:57 resu=
lt=3Dfailure; will retry in 30 day(s))
INFO: webkitgtk 2.52.4: skipping (last attempt 2026-06-02 13:46:52 result=
=3Dfailure; will retry in 30 day(s))
INFO: boost 1.91.0: skipping (last attempt 2026-06-02 13:50:11 result=3Dfai=
lure; will retry in 30 day(s))
INFO: libical 4.0.2: skipping (last attempt 2026-06-02 13:52:44 result=3Dfa=
ilure; will retry in 30 day(s))
INFO: vte 0.84.0: skipping (last attempt 2026-06-02 13:53:31 result=3Dfailu=
re; will retry in 30 day(s))
INFO: 28/28 package groups skipped (incremental mode)
Link: https://lists.openembedded.org/g/openembedded-architecture/message/23=
49

And extract of auh-state.json

    "cargo": {
      "1.96.0": {
        "timestamp": 1780405831.0888734,
        "result": "failure"
      }
    },
    "sbom-cve-check-update-cvelist-native": {
      "2026-06-02": {
        "timestamp": 1780406109.500104,
        "result": "success"
      }
    },

Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
Changes in v2:
- should_skip() simplified to a presence check; _prune() owns all time logi=
c
- log skip reason (previous timestamp, result, days until retry) per group
- log recorded result per package after each attempt
- drop upgrade_err capture; use g['error'] directly after commit_changes()
- drop dead isinstance(upgrade_err, UpgradeNotNeededError) check
---
 modules/state.py    | 109 ++++++++++++++++++++++++++++++++++++++++++++
 upgrade-helper.conf |  10 +++-
 upgrade-helper.py   |  37 +++++++++++++++
 3 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 modules/state.py

diff --git a/modules/state.py b/modules/state.py
new file mode 100644
index 0000000..a23fa1f
--- /dev/null
+++ b/modules/state.py
@@ -0,0 +1,109 @@
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
+import datetime
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
+        """Return True if a recent state entry exists (stale entries are p=
runed at load)."""
+        return self.data.get(pn, {}).get(version) is not None
+
+    def skip_reason(self, pn, version):
+        """Return a human-readable string explaining why pn/version is bei=
ng skipped."""
+        entry =3D self.data.get(pn, {}).get(version, {})
+        ts =3D entry.get("timestamp", 0)
+        when =3D datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%d %H=
:%M:%S")
+        result =3D entry.get("result", "unknown")
+        max_age =3D self.success_max_age if result =3D=3D RESULT_SUCCESS e=
lse self.cooldown
+        retry_in =3D int((ts + max_age - time.time()) / SECONDS_PER_DAY) +=
 1
+        return ("last attempt %s result=3D%s; will retry in %d day(s)"
+                % (when, result, retry_in))
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
index 40f31c4..46311f0 100755
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
@@ -468,6 +482,18 @@ class Updater(object):
=20
             pkggroups_ctx.append({"name":",".join([pkg_ctx['PN'] for pkg_c=
tx in pkgs_ctx]),"pkgs":pkgs_ctx,"error":None, 'base_dir':self.uh_recipes_a=
ll_dir})
         I(" ############################################################")
+        if self.state:
+            kept =3D []
+            for g in pkggroups_ctx:
+                pn, npv =3D g['pkgs'][0]['PN'], g['pkgs'][0]['NPV']
+                if self.state.should_skip(pn, npv):
+                    I(" %s %s: skipping (%s)" % (pn, npv, self.state.skip_=
reason(pn, npv)))
+                else:
+                    kept.append(g)
+            I(" %d/%d package groups skipped (incremental mode)"
+              % (len(pkggroups_ctx) - len(kept), len(pkggroups_ctx)))
+            pkggroups_ctx =3D kept
+            total_pkggroups =3D len(pkggroups_ctx)
         if pkggroups_ctx and not self.args.skip_compilation:
             I(" Building gcc runtimes ...")
             for machine in self.opts['machines']:
@@ -534,6 +560,17 @@ class Updater(object):
                     succeeded_pkggroups_ctx.remove(g)
                     failed_pkggroups_ctx.append(g)
=20
+            if self.state:
+                result =3D RESULT_FAILURE if g.get('error') else RESULT_SU=
CCESS
+                # All packages in a group share the same result because AU=
H
+                # upgrades them atomically; individual outcomes are not tr=
acked.
+                for pkg_ctx in g['pkgs']:
+                    I(" %s %s: recording result=3D%s" % (pkg_ctx['PN'], pk=
g_ctx['NPV'], result))
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


