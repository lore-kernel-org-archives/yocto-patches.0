Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453DDFE521B
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:46:26 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.62])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19022.1777031176968726017
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:46:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=yZYtPihR;
 spf=pass (domain: ericsson.com, ip: 52.101.84.62, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABM9QYYoD7KERyM1LrlpQtAixMlXj+LE4Heq/ZdVB22ZjDAvTiHxRcDeXAfbYf9CiGe8xteqNByyKCeafOJorO/MomhZ4vMQEHwO2DriE8HmO0SURdt8OAqQJX3mHETZUb491iaqIbWw2K7d6UNcLIdM/xHpA+/k+JRbcCFrCgWmzXVFQhG7Xgx87AlB964lvANRaRfQvmaKEKePfClzEdzrsj1hjiHKmvfelYpkyHOVeM2B/HJvw6oJktf6NOE8bLehkIPM9/MWfR6abLgSJ22+BaCbCokFnWAERTYqcnMTEpWNeb5yIDmjO5TPiLpq1xilm6bAsJ8DXgGhf2jAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSRS1yMVickLJ4NkgWpNLELVJpF+msKyA+/kY7Z2h7w=;
 b=PGUmzEyB1UwI0tLm3xN7J8l7hvbm4axD1Pj1VvKCKAdvFTD2Mw6pDye1t62NkUbei4KFQCDrssE2O8FiEvAFpo5sjzdqFjwetXG4NNqPvnuAD4QcqpEzPlXPnc/LnIcTQBH+GAAo4U3qdB/B4+Cxfc5IcU3zkoY8XDXBIIiBMFPwhXqs305TLP/XCPU1M45Ugm6RxE4wFF9lZUgwKU3YBgma9CPxUToEY1Ky6GLhmsCFmECIcJhsViHqnAz5mUKTR/ZzyS1KxsPafeqqSnP15uV96grpFtQwyebJvBF23Y5d8NkuZw17BwE64chpmd8GfUUH7KGr2itghtk5pc7zZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSRS1yMVickLJ4NkgWpNLELVJpF+msKyA+/kY7Z2h7w=;
 b=yZYtPihRj8pGmYn+tl3zNxVnAPF2KHwyotJuJk2n1LsemmqPY50b8MB+P30i3WrThNj3QHKFiaFQKO0A4qXoJT8cWYqm92p5QZj/mvPI2PxdD7IaWrB2btqUgFrjpTjN7uWOenP4+D+biut9awqRA4DJrWjsKIc+f4SDjMa8QHl34bt6y4YZa5mno3Q4y9peYlmERPx0Q8Zq9eKEUNctRHD7G+rgvwnLQUhqbB9w4qvvo9wfGTlrLEDbBaXP5z1pb0+hf7n7qlt0FWy1mqCymkmVIDNxTsb5momT2x6+wW5WrNbLFZ1fwD/elVdiALqeRc44S9Qo0Og5hekFSowmAA==
Received: from AS4P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::20)
 by DUYPR07MB12299.eurprd07.prod.outlook.com (2603:10a6:10:65f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:46:12 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::8f) by AS4P192CA0012.outlook.office365.com
 (2603:10a6:20b:5da::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 11:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 11:46:12 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 13:46:10 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 417CE9569E;
	Fri, 24 Apr 2026 13:46:10 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id F2A8D700DBBF; Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2 8/9] upgrade-helper.py: Add resume option to skip already attempted recipes
Date: Fri, 24 Apr 2026 13:46:02 +0200
Message-ID: <20260424114603.2444938-9-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424114603.2444938-1-daniel.turull@ericsson.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A68:EE_|DUYPR07MB12299:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b33ff1-7e10-4932-12a6-08dea1f71598
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	k/p7Q5zPXoLEM5kxFLlJQRgPig0lhU17R9qrul7LWExjzh7OI8CiIfrcTNA9beBNruxGkvvbgN9DdLrZLqnNjjmOj+D73sWE0+u2xIeq2siDzIJl3B/XtSNU7wYnFlXSybwgXYIhCPiNjqgk8Ag/7ftWGz+dE9/BGNzT9KC0tqEFgqkDgbcgLUO3qdT1Ur263Xh5IbQ0/+EHO96ORw6jtDArpUUvRV0cSgjRFYIy4Bmzhf5jRH5tr24lJKbCk58Ruh4tb7ovaPV/Qlq3mwCDcuZiD1oivElgpGIwy+jmPO32h3Ymhim+qLD3FXkOMMsu0QBOk7Ip3/3Y+y3ZqyiffAzV8jVCLNu8EVjHVQ8+HEPoAxLyTKY0FUw3cfSYTmmHhciqsDyIiATyRCRS4RELCwJ19eDsJqjXMiliCqzLouhnF97vrDMA8F2Kx/zqdZwN1ki//Cf7Upw1JJleCNSYcepBrZlNggRBmhzdgZAGvRhQr5NR3aXxxptD/UNNqFj4CD4Ca/ir+2ACy8QoXw+n6ylVHbi1qpbKU5+JMb0SlcZFymLDvR7LodJ2GufwD5jJMmZOO/OH67I4lzUv2HpMn0nLFm18g85UAzka8m4UWpKoDrMpdqVi58AptvAPEZur2fmSXH/j+FHX4c9/xKK0GFeHMNAf2jboHORIU+oGz+r30HroqH5z2Gfam5LHyGcFmwrS3biyzJ/0nUOF6xF8H/i57V/y+E51rNeD9RmbdLcKLXjULe2NhYDuUPySgUsnuvMT9bfMiOOjHi/oJr5KcA==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	zbR1rwOfwnMjc74a59BX6aLBCdKjEJGiaVHgpowZHfNDICwbfQ6f6MrxTlAHGAozKrVYazwbVMBi2WEJQbBEpt2biOgpWtINxyiXdh08O/YFJ/ODJD9w6Xnbw7N68jpe1p1gQW/zyGvNWFP8KywrnIncf850GuaTiVrCoTBfiq6XmoMorSqIYidjA5VesnMdopF44cYq15u4NYesgCN7VJL96nzrIbfZobyJlrJpit9kJUzLdyXWhq8JW4PxclEUzXEWRBqKTzGGibDRTUrHvCGdorOiWZ9Nu72SEOaw0Xnv3Y10Vjb2ZvQryGjlelWD144JWRpejHJA9fOAjeMHN8ftM/BZMOWcekHcT+4wLfMuqeuFCh3BVqOzG/pPyTEjq21XKaliDfikK6wT3ymX5J/6cWAqc7R6ghyatQYexPyrDpQBttcBdDCLK6WaKARS
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:46:12.3816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b33ff1-7e10-4932-12a6-08dea1f71598
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR07MB12299
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:46:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3795

From: Daniel Turull <daniel.turull@ericsson.com>

Add --resume option that reads the most recent run's log and skips
recipes that were already attempted (either upgraded or failed pre-build).

This allows restarting an interrupted run without re-processing recipes
that have already been handled, saving significant time on large runs
(e.g. 12h for 135 recipes).

The skip set is built by parsing 'Upgrading to' and 'Pre-build FAILED'
lines from the previous run's upgrade-helper.log.

Assisted-by: Claude, Anthropic
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 upgrade-helper.py | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 11a97d2..58fd660 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -108,6 +108,9 @@ def parse_cmdline():
     parser.add_argument("--prebuild", action=3D"store_true", default=3DFal=
se,
                         help=3D"build each recipe at its current version b=
efore attempting upgrade")
=20
+    parser.add_argument("--resume", action=3D"store_true", default=3DFalse=
,
+                        help=3D"skip recipes already attempted in the last=
 run")
+
     parser.add_argument("-d", "--debug-level", type=3Dint, default=3D4, ch=
oices=3Drange(1, 6),
                         help=3D"set the debug level: CRITICAL=3D1, ERROR=
=3D2, WARNING=3D3, INFO=3D4, DEBUG=3D5")
     parser.add_argument("-e", "--send-emails", action=3D"store_true", defa=
ult=3DFalse,
@@ -515,9 +518,33 @@ class Updater(object):
         succeeded_pkggroups_ctx =3D []
         failed_pkggroups_ctx =3D []
         attempted_pkggroups =3D 0
+
+        # --resume: skip recipes already attempted in the most recent run
+        resume_skip =3D set()
+        if self.args.resume:
+            import glob as _glob
+            prev_runs =3D sorted(_glob.glob(os.path.join(self.uh_dir, "20*=
")))
+            # skip the current run dir (last entry) if it exists
+            prev_runs =3D [r for r in prev_runs if r !=3D self.uh_work_dir=
]
+            if prev_runs:
+                prev_log =3D os.path.join(prev_runs[-1], "upgrade-helper.l=
og")
+                if os.path.isfile(prev_log):
+                    with open(prev_log) as f:
+                        for line in f:
+                            m =3D re.match(r'\s+(\S+): (?:Upgrading to|Pre=
-build FAILED)', line)
+                            if m:
+                                resume_skip.add(m.group(1))
+                    I(" --resume: skipping %d recipes from %s" %
+                      (len(resume_skip), prev_runs[-1]))
         for g in pkggroups_ctx:
             attempted_pkggroups +=3D 1
             pkggroup_name =3D g["name"]
+
+            if any(p['PN'] in resume_skip for p in g['pkgs']):
+                I(" SKIP PACKAGE GROUP %d/%d (already attempted): %s" %
+                  (attempted_pkggroups, total_pkggroups, pkggroup_name))
+                continue
+
             I(" ATTEMPT PACKAGE GROUP %d/%d" % (attempted_pkggroups, total=
_pkggroups))
=20
             # Build current version first to verify it builds and seed ABI=
 reference
--=20
2.34.1


