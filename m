Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B7DCD3427
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:36:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9214.1777876591485309772
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 03 May 2026 23:36:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=v6MhtNCp;
 spf=pass (domain: ericsson.com, ip: 40.107.162.69, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0qIzt3oFSuiVCSldy8i+BAXBdV3k5r0I4EytgqloSeUOLmhTY7L91IXhg0ltXtgurK7ljG8muwopfo/Qu2mFcL8uWejGHy9KUjpCL9t1RVTfA+bmHbBVSRGpjzh21V2z9lpUhqqvkU+n2TP9ITfYNoANmjP4oNIyUWnHeMNDBAF62Nkapp645/aHUaN+pSx3miq9nOr8RGKgl4V4VXIX4sSJjho0uRneuC1HNEhDvb4O6SRA60rj5f5+uQ3Px8ehqCk7NmItZ1ynZBV7o2ROhU2njafx8DTzIBTDFGl48dIsNIAXwAZQKsoySu+plvAJtGHPpc1KopEoiRNbegyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt3X/fc2Xqo7sATJa1rIR27Z8i584wHhxlzzOMEZEIo=;
 b=SBejLjJi6etiLWr3mBc5apNGlr+ix0MLIuiuuSvQVhUS+F3bINpqJ6B7u/uR/kjFi8WDvHzAW7NSIl8QOAqDlQo8pRKBKKzTYmjuAD494nwyAb1+GX8B27HNOXQPN5XclkFJe6St8WZu9ZZCWbp25My5g2EoufN+RolPPuMyJbmaxlEeMyi/JkX7mn/ell9p5bWVmxAFGKhXFXUsDLfGOhlW0qFifUh/DTwO5cmtNWcfW13jEof8JHejGUKftX23s7nGNRrfFaUNz37OhdFX3uBjWKKM6TgzdPk5hBPkrRwgEuDrBN5oNgY5f2SzKSW5LEKPDHH9TLACV1q137vcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt3X/fc2Xqo7sATJa1rIR27Z8i584wHhxlzzOMEZEIo=;
 b=v6MhtNCpOfnw5VWSl+5yrO703N1DTgG8dck02DPRqV1ccGY7FS9fn09YsqMpkZDY94aSyKkNxcHb93ioCDVgHWaMnZvVFJTLIL9ufbGjYOBO9anj+PQWS0l8Swq6wjAePiJdv67HsBat2xKirhXUr7esQ4Ko72SHz+hH5fzvhQJI2pS3+gRcGnL4pMRQf+wFTBA1hIx8FN486iaiay3/RslbAawRAFfFSOhtCC4vlKP0cYhrpOjUmhA6oBldiYhbHZpStm1gjc7XMtogdRpINg3wuPfCz1Of/GH77EiqYX1drZPE2akFBGbesyTdTSlXu4Warrxxg7neRX6kYuYzew==
Received: from CWLP123CA0124.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:87::16)
 by DB9PR07MB9887.eurprd07.prod.outlook.com (2603:10a6:10:4c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 06:36:24 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:401:87:cafe::76) by CWLP123CA0124.outlook.office365.com
 (2603:10a6:401:87::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 06:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 06:36:24 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 4 May 2026 08:36:23 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id CDC644021580;
	Mon,  4 May 2026 08:36:22 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id B8C01700DB95; Mon,  4 May 2026 08:36:22 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>
Subject: [AUH][PATCH v3 4/4] upgrade-helper.py: Add resume option to skip already attempted recipes
Date: Mon, 4 May 2026 08:36:12 +0200
Message-ID: <20260504063614.3831203-5-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504063614.3831203-1-daniel.turull@ericsson.com>
References: <20260504063614.3831203-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A68:EE_|DB9PR07MB9887:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c39a71-7eda-461e-66bb-08dea9a776ab
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	nw2DMVDLCqHzxg8iAjp6zPCHTilv4+E4ymAecWDoQ4nNCSixcOIn134rzlMNLWM1TGGqucc9xMHiAHOEhdd+O+9Ces87jiZUpIwPg3Jzihe0Z4gG5lhYZBY2+aKbI09IeBwD5U9RHkGHFqDi8rXBbwdmOiJjSoqwg05kybZ523vbBkXQzK+NYBVsxU7eBRq/Teet9ZBSM8FkETAFRJ0xarAYowcmo+vCiLQEb7O9/Sg7OlR8JIB7JTkE8iDfa+qBtg5ouANmDnAVTpb+faNZUjTBh48HT9DSCq7dYOWOskqIrlMict993IC4DAbhQ5MuV7qU0BAzdFvofTf2U2WdPAeT5S3imp3uoRqjBUCXD8T86EJ72fVcmG/G+pJXM1ur5H/YyQs3IRE9LCPonoyfAivgNRE6RnGternzs1nBnDAZbcsRDy3p1Upy9LaF55j4Gj6ropvmvKDuDG8BQaNBiVBl6oZJIFPeiV75Q0I7PeZPdpGJfrlgvooX566KoZ13bmllxXuW0uJrDNfYee1KM/Cnoyp3ZZPfThZBiJ4OU0BCR1AW/ja9dspMuUhgsSl/MywYsDOqjRVNl4oxqi9elsRNcFC15HpntywzyITurqDUvK6RQyhQVcYyB9vmwSsVwv3oK430PXUJBxkOXGT9t/lu5pkn1BWM7unRwjaZ/2zQG74CO7D0BwC3e9nn02pN3luS4L4OseC/GfyKgNrc5jUK3QYVkFkq0dAsi2sht6Y=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	26htK7DdYJNABG4ES4bPX+ijyGgLRImbFLqlPlr2U5Gn6y8/cH9sTQdNB5faI9JJDL9e9d/c5k3ffLFlWjM728LOjKkChv3P7ao88sH4PTB1C07e1r4F0T0UcSq2swkTUEHxIQcSePxuaZDkpbYHxCAYhg+gEWXfm1NOcLsyOOyJPsjEV+JCUtzYW6wL9JqAQVn74eb91U5kGFSTKgETKyJTveSG1pfenuyIC5iocajEZdwCYREeXglwIMDh38jSKOyclKn3pMYA5Q0K9k8GFAdVkWoJte8ifPtm42/P5/b8wIqKLRvo9uwPtIB8N3Qxfo6n/MlSQESAxKnVl03NWyNWMle37CT0fPik4aa/hcbzzylk+0zFF1aUMc1AVY0N6S95iE7f8QZbJPAYOmiba/HI9bgXU+S07PtlZOb1ptlITXnzhzbFR7NSur1vnE1y
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 06:36:24.8125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c39a71-7eda-461e-66bb-08dea9a776ab
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9887
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 06:36:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3901

From: Daniel Turull <daniel.turull@ericsson.com>

Add --resume option that checks the most recent run's succeed/ and
failed/ directories to determine which recipes were already attempted.

Symlinks in these directories are now created immediately after each
recipe is processed (rather than at the end of the run), so an
interrupted run still leaves behind the right state for --resume.

This allows restarting an interrupted run without re-processing recipes
that have already been handled, saving significant time on large runs
(e.g. 12h for 135 recipes).

Assisted-by: kiro:claude-opus-4.6
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 upgrade-helper.py | 48 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index aecb207..e6ae77f 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -42,6 +42,7 @@ import re
 import signal
 import sys
 import configparser
+import glob
 from datetime import datetime
 from datetime import date
 import shutil
@@ -99,10 +100,12 @@ def parse_cmdline():
=20
     parser.add_argument("-t", "--to_version",
                         help=3D"version to upgrade the recipe to")
-
     parser.add_argument("--stable", action=3D"store_true", default=3DFalse=
,
                         help=3D"only upgrade to the next patch version wit=
hin the stable branch (e.g. 1.2.3 -> 1.2.4)")
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
@@ -493,10 +496,34 @@ class Updater(object):
         succeeded_pkggroups_ctx =3D []
         failed_pkggroups_ctx =3D []
         attempted_pkggroups =3D 0
+
+        # --resume: skip recipes already attempted in the most recent run
+        resume_skip =3D set()
+        if self.args.resume:
+            prev_runs =3D sorted(glob.glob(os.path.join(self.uh_dir, "20*"=
)))
+            prev_runs =3D [r for r in prev_runs if r !=3D self.uh_work_dir=
]
+            if prev_runs:
+                prev_dir =3D prev_runs[-1]
+                for d in ("succeed", "failed"):
+                    result_dir =3D os.path.join(prev_dir, d)
+                    if os.path.isdir(result_dir):
+                        resume_skip.update(os.listdir(result_dir))
+                if resume_skip:
+                    I(" --resume: skipping %d recipes from %s" %
+                      (len(resume_skip), prev_dir))
+            else:
+                W(" --resume: no previous run found, nothing to skip")
         for g in pkggroups_ctx:
             attempted_pkggroups +=3D 1
             pkggroup_name =3D g["name"]
+
+            if g['name'] in resume_skip:
+                I(" SKIP PACKAGE GROUP %d/%d (already attempted): %s" %
+                  (attempted_pkggroups, total_pkggroups, pkggroup_name))
+                continue
+
             I(" ATTEMPT PACKAGE GROUP %d/%d" % (attempted_pkggroups, total=
_pkggroups))
+
             try:
                 for pkg_ctx in g['pkgs']:
                     I(" %s: Upgrading to %s" % (pkg_ctx['PN'], pkg_ctx['NP=
V']))
@@ -541,6 +568,15 @@ class Updater(object):
                     succeeded_pkggroups_ctx.remove(g)
                     failed_pkggroups_ctx.append(g)
=20
+            # Create symlink immediately so --resume can find it
+            if 'workdir' in g:
+                if any(g['name'] =3D=3D s['name'] for s in succeeded_pkggr=
oups_ctx):
+                    link =3D os.path.join(self.uh_recipes_succeed_dir, g['=
name'])
+                else:
+                    link =3D os.path.join(self.uh_recipes_failed_dir, g['n=
ame'])
+                if not os.path.exists(link):
+                    os.symlink(g['workdir'], link)
+
         if self.opts['testimage']:
             ctxs =3D {}
             ctxs['succeeded'] =3D succeeded_pkggroups_ctx
@@ -551,15 +587,7 @@ class Updater(object):
=20
             tim.run()
=20
-        for g in pkggroups_ctx:
-
-            if g in succeeded_pkggroups_ctx:
-                os.symlink(g['workdir'], os.path.join( \
-                    self.uh_recipes_succeed_dir, g['name']))
-            else:
-                os.symlink(g['workdir'], os.path.join( \
-                    self.uh_recipes_failed_dir, g['name']))
-
+        for g in succeeded_pkggroups_ctx + failed_pkggroups_ctx:
             self.statistics.update(g)
             self.pkg_upgrade_handler(g)
=20
--=20
2.34.1


