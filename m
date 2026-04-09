Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E478E9DE7B
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 09:08:44 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.127866.1775725715956159096
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 02:08:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=bgeiiTwd;
 spf=pass (domain: ericsson.com, ip: 52.101.84.1, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WP5msU6X/V7icju4/FWqsExv1i9VZVufOBr3lrIbTlUgX73UjGK+tMdKkQxrNhP/6OqP3TNmn0Hv//a5A6WaEPzKuwU1UJ+Vggrl/RCuFdbMJuvCCXTxKBeZ/rhPatY8dQJgcYyiYm9yOq50WubTUAbEQe6DlW6p+KsJVvvMEYCmr2x4wClJQ/J2zh3wuVvqXENiMGUW/8Hc727S6ncE0sfED9Kx1I5xvdYNNJmsW9p48SkpZ1xAtAbBH1TddVgHk82SkwM8jPujCszyyDcAZvnSPnOvcIMa/SMPyrZnXX3W9qGf8oGGbCxWs/XEQXr8DTXOtwSrFHm6rj39jDLBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkJXXyGRghnz5KrCcX/S4wjcwgFpwzb1Fcc/pH9l7/I=;
 b=am/X2gbQsnk1uTVtte5IpBk6SpCmjT1a45+A90CdTRrOCB234UO8lisy2mUjB6Nhgd+jnftlV1OBzEgNpjDP+dcn3b+EDqUwJnMWuU9Iqa90Ii12Sv2lRPHxScilpvAxGKNvp4AsMjW5gCW6sbCsmxiAH1Vni4OzVodkQCg2ko+eBzyj0QFP3DtnnCFUt/DME6pwEB1NRMlCbY3+7KWBqGyqR9EqLQee3W3MLANQvkluyVe0CV+cEZvS1zh8Qk37XgaKfy2haBTDHh42+2p+T2chikjznOcaKmKXuyLVyYr1zX6JGNiBJdJHI+h08LRP1LAV2FfC8oKgJrk5P+P9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkJXXyGRghnz5KrCcX/S4wjcwgFpwzb1Fcc/pH9l7/I=;
 b=bgeiiTwdHK19wNTNGHIlYWeg1zRQkxz+ObGIzfWbAnRH4vZfmqoc2jU3Dj3nUsrcfwzetWwHuNXw1t2YeEUhmbTFmnrZI/Pl2Mm2YFh40nWEr1KMFcnV3I5KGWQRkZEFW47yL+yHDp5GCY4KSqSz0yyMwpmT3Ogu1WzDvmCDixR110RP1Pyg/JUg5iRQ9vefPa9T54nAeXEr8YFG73XjBuWAAQiWUn3OH9zUKt0j39Olps2p70r5UCwqBiBbGI2NVJ6Wcfi8nbEt+lUziPEJLQ9zxj0mP05w77FwYEhAA+Tf76wXQtEVlBXH3GN2uQZsjSbmOfRuE/dI+JUpUrCLJA==
Received: from AS4P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::9)
 by AMBPR07MB11785.eurprd07.prod.outlook.com (2603:10a6:20b:72c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 09:08:31 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:20b:5da:cafe::38) by AS4P192CA0002.outlook.office365.com
 (2603:10a6:20b:5da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Thu,
 9 Apr 2026 09:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:08:31 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Apr 2026 11:08:28 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 2CF9A9514D;
	Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 18EA9700DB95; Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>
Subject: [AUH] PATCH 4/6] upgrade-helper.py: Add minor option for minor version upgrades
Date: Thu, 9 Apr 2026 11:08:13 +0200
Message-ID: <20260409090815.1731294-5-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409090815.1731294-1-daniel.turull@ericsson.com>
References: <20260409090815.1731294-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DB:EE_|AMBPR07MB11785:EE_
X-MS-Office365-Filtering-Correlation-Id: c4852b66-c82d-46eb-00a5-08de9617923d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	B4kRh3rO1hQlMICBMibtMfpnGcqcvqYIyuVh3gmSdDR60441s4splb0vzEOvEaGrVr3szJuAePywc9rxAoxjY9/WN0/1kweuIznjZAGj1pstuJ9PlcHHStQ9nf/GV/2oMS+SaQG50+tPo8yPnsfgev4oLFDukkEnpaYypoPPvKrhVLZRYU9OBnI15vgxohz/wQa0YvlFKENRqp/0zKy8KKJB6Pof0SV5Ar3mMR+aCxVnU1X0jFfEE/4LuUDG4MckS61ZAdM/LofTtzaLb/Ixn5+NBCjpZSh5zg1nFPsDOdF5QurABrW8/Dm4Ec1WPjdlYLemX3+6nem4t8iXqraUYXvksZN/0WjTmOw8lw/r/40+yLwGJaVT5Nwpgv1Yagbq9CqYMHEtpPOc+by8LXxtFQxSwleyyGLYFhP40CwPAb9/ETknCwlZz1QvFQonE91qHYAZFgOk2vcXMRMVq1uY1Q7vXaXmpqKX0j5W2eXMKqWwa+q8Yx963uiJjFOz0PvXRNu3i0oLsImi4yVTBjvTICkLBg/XNjk6Q+aGiWXk+yb/igN9mevMW+YSK2lEOOxO+0FpPgd5NWCJEftj461QBuHBRcRP+RQkK40t8GgRJFcw8+G0zwAHk/3wvRTYmec8Fona4xbmkFFh6tTB/1zJblskOL+VApU0SO9sI+XcFcY5eUjzkJBRMiMnyIpuy0Q9G2OO2o4CxZOMd7d0tmVzPf1Q4p5obpB1SCgFzkCDAB5zA0y9wiric7iOKdRU49W+KjCC4AvnI7auXE2Ytl1uzQ==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	WLEBC86EjMQQUG8fIqtO0+0qD0Mn4ZQO3kYv30GldFe43rEUUizwYWkd7A7vCCtdfrFugqBWLD4gjrReyYKmgIHsXzLTrMHGQXmW9aR1TMM7a4WhhtjRS5dFE/t4RbQWmEgmmcMI28xk7+Wr1SEkzU5kmpFx4e+05+kJyzyyaYwvbcUtcTXHkN3zj5UryTO+JMcnha0uwCr1feltB602fs2OCz4/rv8yY6sbAWTUZ852/s/9wIathAQKGMlgM+HXGsQUDAooavzqdex5Mk2Mv2cCoS3bMPuKU61Cq25HHSPsZ0Ql3QN7BE5ilvAB5r6YE7mbrgMumE4PQuxtBDY5/jELddmZIJCbBrKWH+g5PMHQvY+y2hkLuK/hpvx/Akwp8vxNTHJbnohNSKCXbCp4/V4ELp6Cc9J8/qVo25rV8yTAcUgcVDcRojrCvIMx+2mc
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:08:31.4442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4852b66-c82d-46eb-00a5-08de9617923d
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11785
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 09:08:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3671

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
 upgrade-helper.py        | 27 ++++++++++++++++-----------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/modules/utils/version.py b/modules/utils/version.py
index b40eb1c..acec835 100644
--- a/modules/utils/version.py
+++ b/modules/utils/version.py
@@ -44,6 +44,17 @@ def is_patch_update(current_ver, candidate_ver):
         return bb.utils.vercmp_string(candidate_ver, current_ver) > 0
=20
=20
+def is_minor_update(current_ver, candidate_ver):
+    """Check if candidate changes only the second component (e.g. 3.5.x ->=
 3.6.x)."""
+    cur =3D _split_version(current_ver)
+    cand =3D _split_version(candidate_ver)
+    if len(cur) !=3D len(cand) or len(cur) < 2:
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
index d023559..bef9bca 100755
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
+                        help=3D"allow minor version upgrades within the sa=
me major (e.g. 3.5.x -> 3.6.x)")
=20
     parser.add_argument("-d", "--debug-level", type=3Dint, default=3D4, ch=
oices=3Drange(1, 6),
                         help=3D"set the debug level: CRITICAL=3D1, ERROR=
=3D2, WARNING=3D3, INFO=3D4, DEBUG=3D5")
@@ -702,22 +705,24 @@ class UniverseUpdater(Updater):
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
-              " searching for patch versions..." %
-              (pn, next_ver, cur_ver))
+            I(" %s: latest version %s is not a %s update from %s,"
+              " searching for versions..." %
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
-                    I(" %s: found patch version %s" % (pn, ver))
+                    I(" %s: found version %s" % (pn, ver))
                     return ver, "N/A"
                 else:
                     I(" %s: no suitable version available, skipping" % pn)
@@ -791,7 +796,7 @@ class UniverseUpdater(Updater):
                 if upgrade_group:
                     upgrade_pkggroups.append(upgrade_group)
=20
-        if self.args.stable and upgrade_pkggroups:
+        if (self.args.stable or self.args.minor) and upgrade_pkggroups:
             stable_tinfoil =3D bb.tinfoil.Tinfoil()
             stable_tinfoil.prepare(config_only=3DFalse)
             try:
@@ -801,7 +806,7 @@ class UniverseUpdater(Updater):
                     for pkg in group:
                         stable_ver, stable_rev =3D _resolve_stable_version=
(
                             pkg['pn'], pkg['cur_ver'], pkg['next_ver'],
-                            stable_tinfoil)
+                            stable_tinfoil, minor=3Dself.args.minor)
                         if stable_ver is not None:
                             pkg['next_ver'] =3D stable_ver
                             if stable_rev is not None:

