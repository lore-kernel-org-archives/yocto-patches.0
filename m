Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83704FE521D
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:46:26 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19329.1777031176537108924
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:46:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=RQevbE1u;
 spf=pass (domain: ericsson.com, ip: 52.101.65.33, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO2BRpAbKdA+kvnKpkvGENXDFDaR/OfP0CkYZCb3daw46tEm7muanxm6SuFDluPhfEE5Wo3jHHypWzyD9p8VNC4cG7g5Qd528Uo8l0fbNuVnEES4KPjatHVGdTlYpMZ8mrPjtKyuE6jAX0ESHOR/o7l6yqVP4W0l4vfIqtUcop91MN1BFUGkGwZTIfYkwqpVDYni0LSh7TVy0UuoKvX7pMR40wlotpJTEaTOqBi7T1mVk0CcXwdEMs/H/tlBEWivaSdRhoXiAOeVHTqmn3eUQGpQ+qskQoR2dfwRS/KFCHiaNgGDBSzhkq3EXppp1DIFQs3qbQcJxG6uk8XeDiyv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOg1y81jVZuRC+Q/KVbDWc0oE7XxVFESSn1XIN4cm/k=;
 b=XX64Y60jJpTdGcir6lDuHOaYJeY5bloqjnKVoeA5TBle4jOTzrrzV8GdKhP2sFg+C8ubNbW9pOyqQm9WSSbPVLDaeC4uIpSID+rlQpL/ocf7LzTuH8dIMxjh4I/T6A7ZXT0oksL1l1eMXD8imX9sxt+kWK/r5s+EMJTqpeyriF7Ew34/RfkMbpkj41qNT7PkBa3nsn9oL2m67GKdY3LSiym2ZxsNXufuv4DBDl4e0WL0/BAbnEU3XGiP69T7rZXzoifs26o16nHQerU/+397wqSGdFZnkx6gIdpb1q1P19B2/0w6ebuMCHj74U4q0e/dlWvFnDsEphVbtFrR7qKfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOg1y81jVZuRC+Q/KVbDWc0oE7XxVFESSn1XIN4cm/k=;
 b=RQevbE1umdTON+G/wG8+zXzOI3jZ2FXFcf1vwet8jdp1w+T/e1d1qGhPkWv5zuRAkkxGpD/TTbNkmu8qV7sKp2llUVSHhU12EBaYGUmbGfPXAhLO73k0UGzFBWgr7uKhkR1lXpG64zVMk1pOTa/lWkHWU6WCWpyryK4iHrSdAL8xRyGpXW6mQ0gpqzVxVp6UaWr2cqGJUPWLfA84aZdiGuQKtGZxkUMY542q6iUbJTq/Exontre3USJGAWysdYgrajQ6f6AU+LcrY5xvB9Sl4Z52HrTAWEmJSVACdHcszYWqnm9ov63c+8MWPSeEsvHapBdqVPt4msJbGGe1WII08A==
Received: from CWLP265CA0540.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18d::15)
 by AMBPR07MB11464.eurprd07.prod.outlook.com (2603:10a6:20b:734::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:46:11 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:400:18d:cafe::83) by CWLP265CA0540.outlook.office365.com
 (2603:10a6:400:18d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 11:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 11:46:11 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 13:46:10 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 40B7F4020846;
	Fri, 24 Apr 2026 13:46:10 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id EA063700DBB4; Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2 6/9] upgrade-helper.py: Add minor option for minor version upgrades
Date: Fri, 24 Apr 2026 13:46:00 +0200
Message-ID: <20260424114603.2444938-7-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424114603.2444938-1-daniel.turull@ericsson.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|AMBPR07MB11464:EE_
X-MS-Office365-Filtering-Correlation-Id: 292970f6-30ce-431c-f60a-08dea1f714ee
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	MVrcBSaMiyMKkuX87aMIj/d16B9xxJTnKar0S4wuzHM3tcthKxuyQmvEIYJLbatasouUm1p740P+UqHZj806vzh410O2YRVt6J0Tuku3K7udSTo4VSM4hp21LRJwMzpcK8ChZBefkVr+sBsaJXGK7vwM9+1S+41QepPyvM4ykrJP/NMtizjfGsuTX1f+WFoq2OEgyXiz+GLN+7hGLHq6X3Kaa1EfNOm0jIIPVL2aeUOOFg6eu09Hg350Bl+AieHKOy8OsBi/tEuyYfTZ7NhZ8U1h/IHPdZZuYmVKc5unGdG352T2Mx8KUVC+R0ZnxpXRUV+qoJaxjh+lKkV3As62JxAIECihS7JAcck0CZaAyD6l8+uq7Ap5mwQjKLY0FrdyJnClPgyH888YnGKA8pkzhKTJyhLrX/d7Vs3P++PWkt4FHM2XxLbPW6YIhHxb/EYYZEawG/lKtEXzJ88cpwcNYxvg9qBsCXzX0tBE8SvULanJGEh6XI9A8EN+3Z0DS9D7cVYhyXCBuq2Dl55GhlDariqIwzB0obq3tkkTc3YRT3wmBx7ETLIwgjlNoF/xVD8LKDrUMOlfzKEJbwpzgvOosJpAXVABbQgEAh1IVX/NUObKF9K3u8xGzBG/SE6a+3RV04WCOgaHNlVB2wHiSzrzlnPUD3oiwcdnwq7B1voXY3KCIMo2iNR+T1/M/t6YplkgtKTBEazCIayMtJoxnUNrxBaiAulMeu+yHV4CahugbN3andpnB9ez7WdIJ/kC+VuyWtdeTVnqih/HmSmoB9vsDQ==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	bSe+JV9pqf5R67QIAIeBqcOkZv56aQfhHPPxY2wAVtUYjnQG2VoLYzx4XCXkNGMKhXi4wGLaO1pWy26YhQqDBrEU8elFjk3wS+dXPoJ81Rk5NPUZ8yFrvmmEB+hMclzNA2NR5wQgqwFvzmsirGKZxuZx9dcZNYXENrpepTqfIbpToXCB+AKN5hVx/gcPO0hRyS4Q6UOLk0PCtRxQVa4CmAQORnihbpV5gGaKWt2Q2jntwvl80zl+glvACM87tvBN1slf4m7GJ77uptWcullI37dVdXj1vpOmTKXmL/PCHq+ES4vKctuUBFaF3zzN0f7T99qcjkvJufn6dmy6U/oDhJRGSzV7z6BzvAcflR/VoGcIjIaWTUV5oCdLOYUIGzuHc/POZiAHr00toDovXvmvKmiw+aPyyW6YjP3oSKGWtc11Pax4SFtEvI4VfonGt3Eu
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:46:11.2809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 292970f6-30ce-431c-f60a-08dea1f714ee
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11464
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:46:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3793

From: Daniel Turull <daniel.turull@ericsson.com>

Add --minor option that allows upgrades within the same major version
(e.g. 3.5.x -> 3.6.x), complementing --stable which only allows
patch-level changes.

Extends _resolve_stable_version with a minor flag and adds
is_minor_update / find_minor_version to utils/version.py.

Assisted-by: Claude, Anthropic
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/utils/version.py | 15 +++++++++++++++
 upgrade-helper.py        | 23 ++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/modules/utils/version.py b/modules/utils/version.py
index b40eb1c..71e0a1e 100644
--- a/modules/utils/version.py
+++ b/modules/utils/version.py
@@ -44,6 +44,17 @@ def is_patch_update(current_ver, candidate_ver):
         return bb.utils.vercmp_string(candidate_ver, current_ver) > 0
=20
=20
+def is_minor_update(current_ver, candidate_ver):
+    """Check if candidate is a newer release within the same major version=
."""
+    cur =3D _split_version(current_ver)
+    cand =3D _split_version(candidate_ver)
+    if len(cur) < 2 or len(cand) < 2:
+        return False
+    if cur[0] !=3D cand[0]:
+        return False
+    return bb.utils.vercmp_string(candidate_ver, current_ver) > 0
+
+
 def _find_best_version(current_ver, all_versions, filter_fn):
     candidates =3D [v for v in all_versions if filter_fn(current_ver, v)]
     if not candidates:
@@ -58,6 +69,10 @@ def find_patch_version(current_ver, all_versions):
     return _find_best_version(current_ver, all_versions, is_patch_update)
=20
=20
+def find_minor_version(current_ver, all_versions):
+    return _find_best_version(current_ver, all_versions, is_minor_update)
+
+
 def get_all_upstream_versions(rd):
     """Get all upstream versions using the fetcher infrastructure.
=20
diff --git a/upgrade-helper.py b/upgrade-helper.py
index b7b8ddf..ffa7449 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -59,7 +59,8 @@ from utils.emailhandler import Email
 from statistics import Statistics
 from steps import upgrade_steps
 from testimage import TestImage
-from utils.version import is_patch_update, find_patch_version, get_all_ups=
tream_versions
+from utils.version import is_patch_update, find_patch_version, get_all_ups=
tream_versions, \
+    is_minor_update, find_minor_version
=20
 if not os.getenv('BUILDDIR', False):
     E(" You must source oe-init-build-env before running this script!\n")
@@ -101,6 +102,8 @@ def parse_cmdline():
                         help=3D"extract changelog between old and new vers=
ions, highlighting CVEs")
     parser.add_argument("--stable", action=3D"store_true", default=3DFalse=
,
                         help=3D"only upgrade to the next patch version wit=
hin the stable branch (e.g. 1.2.3 -> 1.2.4)")
+    parser.add_argument("--minor", action=3D"store_true", default=3DFalse,
+                        help=3D"allow upgrades within the same major versi=
on (e.g. 3.5.2 -> 3.6.0, 3.99.0)")
=20
     parser.add_argument("-d", "--debug-level", type=3Dint, default=3D4, ch=
oices=3Drange(1, 6),
                         help=3D"set the debug level: CRITICAL=3D1, ERROR=
=3D2, WARNING=3D3, INFO=3D4, DEBUG=3D5")
@@ -702,20 +705,22 @@ class UniverseUpdater(Updater):
=20
     def _get_packagegroups_to_upgrade(self, packages=3DNone):
=20
-        def _resolve_stable_version(pn, cur_ver, next_ver, tinfoil):
-            """Find the latest patch version within the current stable bra=
nch."""
-            if is_patch_update(cur_ver, next_ver):
+        def _resolve_stable_version(pn, cur_ver, next_ver, tinfoil, minor=
=3DFalse):
+            """Find the latest patch (or minor) version within the allowed=
 range."""
+            check_fn =3D is_minor_update if minor else is_patch_update
+            find_fn =3D find_minor_version if minor else find_patch_versio=
n
+            if check_fn(cur_ver, next_ver):
                 return next_ver, None
-            I(" %s: latest version %s is not a patch update from %s,"
+            I(" %s: latest version %s is not a %s update from %s,"
               " searching for versions..." %
-              (pn, next_ver, cur_ver))
+              (pn, next_ver, "minor" if minor else "patch", cur_ver))
             try:
                 rd =3D tinfoil.parse_recipe(pn)
                 if not rd:
                     I(" %s: could not parse recipe, skipping" % pn)
                     return None, None
                 all_versions =3D get_all_upstream_versions(rd)
-                ver =3D find_patch_version(cur_ver, all_versions)
+                ver =3D find_fn(cur_ver, all_versions)
                 if ver:
                     I(" %s: found version %s" % (pn, ver))
                     return ver, "N/A"
@@ -792,7 +797,7 @@ class UniverseUpdater(Updater):
                 if upgrade_group:
                     upgrade_pkggroups.append(upgrade_group)
=20
-        if self.args.stable and upgrade_pkggroups:
+        if (self.args.stable or self.args.minor) and upgrade_pkggroups:
             stable_tinfoil =3D bb.tinfoil.Tinfoil()
             stable_tinfoil.prepare(config_only=3DFalse)
             try:
@@ -802,7 +807,7 @@ class UniverseUpdater(Updater):
                     for pkg in group:
                         stable_ver, stable_rev =3D _resolve_stable_version=
(
                             pkg['pn'], pkg['cur_ver'], pkg['next_ver'],
-                            stable_tinfoil)
+                            stable_tinfoil, minor=3Dself.args.minor)
                         if stable_ver is not None:
                             pkg['next_ver'] =3D stable_ver
                             if stable_rev is not None:
--=20
2.34.1


