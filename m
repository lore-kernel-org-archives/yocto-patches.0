Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D595BCD6E7D
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 13:28:12 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8048.1780666084249787257
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 06:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=cY+SM3rO;
 spf=pass (domain: ericsson.com, ip: 52.101.69.41, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUsC0rzrE+IQ/m4EsPHYbXwTDbXkPb42S1LNcIyFJbCOv2FW53Nu0aaQw/k05SKiiEGVJc3j0/uowR3ExU0KiWeYKpXc0ExxyN2Kxtw15S3fK90w4kYZf4H9Zzh+p09vIXk72A4v7p6yqAydQ2s4MrKJs9l0CI9naa4RELi8mhjaa5rEHfguiAn3YRXomCqGsIqmmT2fdKiNXrSVmSsJJL0Sriq/WFSls6vtKGqvPairmzBUnW+B6RQsV/bkbMkYMUypFPdSL9Fd96ThxWWC6Vaxv7RCdtuGxO6XG/DL5qvFi1t96AXwFfv5nuCiKwKGoThPtwRiyeKTjbN/ZA2WrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrsTa4FmR4sUo0kf1VDaGiqJghw104ydq1PkLnOMbY8=;
 b=y6h6zfxlYD2E1MsBOXqoOwqnKrPkl98R7IEgYNWA9KUT1uBlNLSVCX0yKv86wspD5sGG8+3iv0GOZ8fiFgqJ23Q7SvWlJQa7rT8+whLKsHoo1lxgjHM5wDzZzkmgl0DB3MSitPhW9E8CK1Sm5jaYOpx8Se7IBR2enyywzMn061mJ5Dv/VQsx3cfsL6A8MZXhkNTXDy8e4TPBj0vq6UMjoiIOZ2X5etuWY+9M3njp+X6t0V18Kpz2l6Oc8z1hyLV+UmXr4DbPr5FQ7EJ3rIN4Hd199Vjt2oewwgYbDgP8R7V70xiQ180BZzWN8gcOWrewKZTZmvUdMfVIKXrtTEFUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrsTa4FmR4sUo0kf1VDaGiqJghw104ydq1PkLnOMbY8=;
 b=cY+SM3rOvGi6mnV8NynbjggPTQQxhF3faTNd3nd6kayPynvQPytCLwA+cvjnraPMVnGXQir+Pqp4fcVau8Ev28K4pvs+rF6i1rWjw6xosjg61ZFNPZitS+Fd+inf3vAn8wRc7+8R60AxF9UCNqRYFs0Ga7d9WzyImM+kOYz7O20q6xLWXhP6RDJU3qx7/MVY1BU3hk4vT/gHX40Vsp7VAzJFGzWmajN6sLejdnCk6ZaiRNvYsHWXJBU/DkVJmK//l5digrQfnhQ6lwH5NhuPeMJcpoH3yJ5NPQlblPtknHK/6GdxWvsV5Vstv6tw2AF+GhA8vjFwPAHbb81xL1rBHA==
Received: from CWLP123CA0204.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::8)
 by BESPR07MB12170.eurprd07.prod.outlook.com (2603:10a6:b10:fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:27:58 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:400:19c:cafe::75) by CWLP123CA0204.outlook.office365.com
 (2603:10a6:400:19c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 13:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:27:57 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 15:27:57 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 523009569E;
	Fri,  5 Jun 2026 15:27:57 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 3B6DC7003739; Fri,  5 Jun 2026 15:27:57 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH] [PATCH v3] upgrade-helper: add state module and --incremental mode
Date: Fri, 5 Jun 2026 15:27:39 +0200
Message-ID: <20260605132739.617143-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|BESPR07MB12170:EE_
X-MS-Office365-Filtering-Correlation-Id: 099139ef-cad7-4a4d-eb96-08dec3064226
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|13003099007|6133799003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 
	lu5JfkbBP59TOwipJO286d9vth5EJ/ZkrS+FvF+YWG5okZ7e1toTjDsUVa/v5+3eJNLCblqQTfXGvzedaYDf7zUY248gFuUPhXhkPNgUF8laqwIq1KJKjl6EQmDhW1AHGAZMSSlJEeQzFwlt0L9JPzE3DY+9GiTjxIvr9UwUyXcT4XUSidI56H1+wVIMz3dXFJX386xuqVtXW1vV9vmD+WNj3soN5/A5/3JSep2YCyxgVP+fH0bDvsdOU/CMHCwG254m+nYXH35oUI8gIN2j2nd2F8cMyloFXzogKJOLfGnyHQuVnZcxqvjgi43dnHiASB1Sy9v82EwRwAdUrLD/j+HspuVsiMuNNpOXpeSzXEmmY9mW8Nm4Sgb4ce/Pa6ipHkZjYDCOaB/Vc/duTQDvnV/kgSmBd0qhG6ho44UuyVFL3xYHnrUX/38iyUTap7ZV14d+SVQ8qwp8iEDJ5JinIc11xSo6teY6iyIF+oLbVyfneHyP9U6NkLI/rPDUvj5s7lXgS7WLaqLamtD92zhc91i3fGoKMVZS2kwsZtUPzbZzlWJCtNwwL0yjnoz08+hw+LIDrpG5IKyq2MgmHIOotq7rzDUPuwnghpwqGEbj26cl8rYe3ztuBdN7p+iERM0G7LNei58WXtnHMPP1CWhh4AIRYyEo2iDerOLAkbKssS5PVTGUb8ZOxJA/dvanwk8v3Fr2Q3HYG2CGCBBXe3WireokPmXxuXFj4aK1vo7jrWk=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(13003099007)(6133799003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	EkZRPDliGPfP+Uxyy7zV8rCkdkitnSyYGksfRnU+/mb5kNoUfN36M7ANGlvh4GZrOsFFU38+T+58QbKrO0NeVpPCgRKHaX+MivRkH8Xq7M5FxVxEKvis1Y84tO0L56hOzFDQDGDToKj13QBQ+aMvsT4nOXByWm5fi8X/0OHjW7aOlYdjAirUbr/XefuThrmv+y0iAZysiDqIvkTJ0uOtWwuxjKOG/FD0/kQUanA5Iny8d0hU3YmFkBtqUewV8D9+SgKkV6mXWQYOxeapWAtZgvwUSSxQdI+RQjLt6vYsz4DveflsvJWJAnZVgMQ55wPoRHcrHd2GUkbU3kpbeLyHHeM9ah3HIT/nnIKSTTxjPHpA5PKGaLlt9rfbCCco4HJvTgRclk5GtvlT+dvajMF7qPCuT6nBdt1gAjE+2IY62T5leUT6jet29Eap3IVpi1m7
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:27:57.9617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 099139ef-cad7-4a4d-eb96-08dec3064226
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR07MB12170
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 13:28:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4147

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
- Failed attempts are retried after retry_same_version_interval days
  (default 30).
- Successful/already-current upgrades are suppressed for success_max_age
  days (default 30).
- Rapid-fire recipes (listed in retry_any_version_recipes) are throttled
  by retry_any_version_interval (default 7) regardless of version or
  result, preventing mailing list flooding from recipes with very frequent
  upstream releases.

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

AI-Generated: kiro with claude-opus-4.6 model
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>

---
Changes in v3:
- Rename retry_interval to retry_same_version_interval
- Add retry_any_version_interval (default 7 days) for rapid-fire recipes
- Add retry_any_version_recipes config setting (space-separated list)
- Unify timestamp logic into a single check() helper returning
  {skip, reason}; should_skip(), skip_reason() and _prune() all
  derive from it

Changes in v2:
- should_skip() simplified to a presence check; _prune() owns all time logi=
c
- log skip reason (previous timestamp, result, days until retry) per group
- log recorded result per package after each attempt
- drop upgrade_err capture; use g['error'] directly after commit_changes()
- drop dead isinstance(upgrade_err, UpgradeNotNeededError) check
---
 modules/state.py    | 140 ++++++++++++++++++++++++++++++++++++++++++++
 upgrade-helper.conf |  21 ++++++-
 upgrade-helper.py   |  46 +++++++++++++++
 3 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 modules/state.py

diff --git a/modules/state.py b/modules/state.py
new file mode 100644
index 0000000..0c2c7bb
--- /dev/null
+++ b/modules/state.py
@@ -0,0 +1,140 @@
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
+DEFAULT_RETRY_SAME_VERSION_DAYS =3D 30
+DEFAULT_RETRY_ANY_VERSION_DAYS =3D 7
+DEFAULT_SUCCESS_MAX_AGE_DAYS =3D 30
+
+
+class State:
+    """Tracks upgrade attempts as {recipe: {version: {timestamp, result}}}=
."""
+
+    def __init__(self, state_dir,
+                 retry_same_version_days=3DDEFAULT_RETRY_SAME_VERSION_DAYS=
,
+                 success_max_age_days=3DDEFAULT_SUCCESS_MAX_AGE_DAYS,
+                 retry_any_version_days=3DDEFAULT_RETRY_ANY_VERSION_DAYS,
+                 retry_any_version_recipes=3DNone):
+        self.path =3D os.path.join(state_dir, STATE_FILENAME)
+        self.retry_same_version =3D retry_same_version_days * SECONDS_PER_=
DAY
+        self.success_max_age =3D success_max_age_days * SECONDS_PER_DAY
+        self.retry_any_version =3D retry_any_version_days * SECONDS_PER_DA=
Y
+        self.any_version_recipes =3D set(retry_any_version_recipes or [])
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
+        """Return True if this recipe/version should not be attempted."""
+        return self.check(pn, version)['skip']
+
+    def skip_reason(self, pn, version):
+        """Return a human-readable string explaining why pn/version is bei=
ng skipped."""
+        return self.check(pn, version)['reason']
+
+    def check(self, pn, version):
+        """Return {'skip': bool, 'reason': str} for a recipe/version pair.
+
+        For any_version_recipes, any recent attempt (any version) causes a=
 skip.
+        For normal recipes, only a matching version entry causes a skip.
+        """
+        if pn in self.any_version_recipes:
+            entry =3D self._newest_entry(pn)
+            max_age =3D self.retry_any_version
+        else:
+            entry =3D self.data.get(pn, {}).get(version)
+            if entry is None:
+                return {'skip': False, 'reason': ''}
+            max_age =3D self.success_max_age \
+                if entry.get("result") =3D=3D RESULT_SUCCESS \
+                else self.retry_same_version
+
+        if not entry:
+            return {'skip': False, 'reason': ''}
+
+        ts =3D entry.get("timestamp", 0)
+        age =3D time.time() - ts
+        if age > max_age:
+            return {'skip': False, 'reason': ''}
+
+        result =3D entry.get("result", "unknown")
+        when =3D datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%d %H=
:%M:%S")
+        retry_in =3D int((max_age - age) / SECONDS_PER_DAY) + 1
+        prefix =3D "rapid-fire; " if pn in self.any_version_recipes else "=
"
+        return {'skip': True,
+                'reason': "%slast attempt %s result=3D%s; will retry in %d=
 day(s)"
+                          % (prefix, when, result, retry_in)}
+
+    def _newest_entry(self, pn):
+        """Return the most recent entry for a recipe across all versions."=
""
+        versions =3D self.data.get(pn, {})
+        return max(versions.values(), key=3Dlambda e: e.get("timestamp", 0=
),
+                   default=3D{})
+
+    def _prune(self):
+        """Remove entries that check() would no longer skip."""
+        for pn in list(self.data):
+            versions =3D self.data[pn]
+            for ver in list(versions):
+                if not self.check(pn, ver)['skip']:
+                    del versions[ver]
+            if not versions:
+                del self.data[pn]
diff --git a/upgrade-helper.conf b/upgrade-helper.conf
index 269bde3..53c3c46 100644
--- a/upgrade-helper.conf
+++ b/upgrade-helper.conf
@@ -50,7 +50,26 @@
 # passed; does not apply when layer_mode is enabled).
 #blacklist=3Dpython glibc gcc
=20
-# specify the directory where work (patches) will be saved=20
+# When running with --incremental, how many days to wait before retrying
+# a failed upgrade attempt for the same recipe version. Default is 30 days=
.
+#retry_same_version_interval=3D30
+
+# When running with --incremental, how many days to skip a successfully
+# upgraded recipe version before attempting it again. Default is 30 days.
+#success_max_age=3D30
+
+# When running with --incremental, how many days to suppress any upgrade
+# attempt for recipes listed in retry_any_version_recipes, regardless of
+# version or result. Useful for recipes with very frequent upstream releas=
es.
+# Default is 7 days.
+#retry_any_version_interval=3D7
+
+# Space-separated list of recipes that release so frequently that they wou=
ld
+# flood the mailing list. These are throttled by retry_any_version_interva=
l
+# instead of per-version intervals.
+#retry_any_version_recipes=3Dvulkan-samples sbom-cve-check-update-cvelist-=
native sbom-cve-check-update-nvd-native
+
+# specify the directory where work (patches) will be saved
 # (optional; default is BUILDDIR/upgrade-helper/)
 #workdir=3D
=20
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 4786735..fb9e45f 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -59,6 +59,10 @@ from utils.emailhandler import Email
 from statistics import Statistics
 from steps import upgrade_steps
 from testimage import TestImage
+from state import (State, RESULT_SUCCESS, RESULT_FAILURE,
+                   DEFAULT_RETRY_SAME_VERSION_DAYS,
+                   DEFAULT_RETRY_ANY_VERSION_DAYS,
+                   DEFAULT_SUCCESS_MAX_AGE_DAYS)
=20
 if not os.getenv('BUILDDIR', False):
     E(" You must source oe-init-build-env before running this script!\n")
@@ -104,6 +108,8 @@ def parse_cmdline():
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
@@ -169,6 +175,22 @@ class Updater(object):
             self.email_handler =3D Email(settings)
         self.statistics =3D Statistics()
=20
+        if self.args.incremental:
+            retry_same =3D int(settings.get('retry_same_version_interval',
+                                          DEFAULT_RETRY_SAME_VERSION_DAYS)=
)
+            success_max_age =3D int(settings.get('success_max_age',
+                                               DEFAULT_SUCCESS_MAX_AGE_DAY=
S))
+            retry_any =3D int(settings.get('retry_any_version_interval',
+                                         DEFAULT_RETRY_ANY_VERSION_DAYS))
+            any_version_recipes =3D settings.get('retry_any_version_recipe=
s', '').split()
+            self.state =3D State(self.uh_dir,
+                               retry_same_version_days=3Dretry_same,
+                               success_max_age_days=3Dsuccess_max_age,
+                               retry_any_version_days=3Dretry_any,
+                               retry_any_version_recipes=3Dany_version_rec=
ipes)
+        else:
+            self.state =3D None
+
     def _set_options(self):
         self.opts =3D {}
         self.opts['layer_mode'] =3D settings.get('layer_mode', '')
@@ -468,6 +490,19 @@ class Updater(object):
=20
             pkggroups_ctx.append({"name":",".join([pkg_ctx['PN'] for pkg_c=
tx in pkgs_ctx]),"pkgs":pkgs_ctx,"error":None, 'base_dir':self.uh_recipes_a=
ll_dir})
         I(" ############################################################")
+        if self.state:
+            kept =3D []
+            for g in pkggroups_ctx:
+                pn, npv =3D g['pkgs'][0]['PN'], g['pkgs'][0]['NPV']
+                r =3D self.state.check(pn, npv)
+                if r['skip']:
+                    I(" %s %s: skipping (%s)" % (pn, npv, r['reason']))
+                else:
+                    kept.append(g)
+            I(" %d/%d package groups skipped (incremental mode)"
+              % (len(pkggroups_ctx) - len(kept), len(pkggroups_ctx)))
+            pkggroups_ctx =3D kept
+            total_pkggroups =3D len(pkggroups_ctx)
         if pkggroups_ctx and not self.args.skip_compilation:
             I(" Building gcc runtimes ...")
             for machine in self.opts['machines']:
@@ -532,6 +567,17 @@ class Updater(object):
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


