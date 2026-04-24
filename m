Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938A9FE5210
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:46:24 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19327.1777031175730191117
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:46:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=l3dMQAis;
 spf=pass (domain: ericsson.com, ip: 52.101.84.57, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4HDIHAZ6EWo/KDOMxlxxYweIivbXcpFBiNsnwDMV7RwrdGGZ8ZKOOO664Cd/edO5lM5VKLVx+K8BJkTK9pF9VMSnyT9YR6RA9mC9B6cVVUW4m068Hk8QksfPUP9Jnd9zpIgAs30xb4mofOPyotrWeBwFnCaeSVquZDYy+TkuLx8Cgga0nJFbp9bdMH4+YQD4v7hfJlElhY3dw8EoD9B7T03dOCiNoqn00QH5SBYl0H10vrldl2JNDar5TqrR9d3VT9jdIh38vYu8+N00MviI8lmgIaOc2FmKSAM+UWhe+pp1x7BIaSV3b+mPLkAstRpCB/zmisA2hBcOiElFEpkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho30g4I1ujBGrv3V0wW9BB8Rupz2/VYv+LsZhi/P5c8=;
 b=E7XGUVFAbXvJpfbaFpkqjUDNhNGoe27n05/IDr265JJFYSNxenANix5t0b7jVkXi6Jhgg+4Ib/zdUb/E9DjexLbnB2OGYW6KNZKPE7NUOeX/lY4WaKymBGe34cQ/PF7Faid3HSPiPDXFFqO0Dm02LcOO5GqFsnbnkM2uCR3bdTh9lFEItASWN6cUJ966YKIcat99taHolwCHqJOP6esjEGWEzh/zghmi/A2lBNmoQDkeDjvntcskPf0eyKfAapU+yKt8FFAMFR6Vur/zFT/6St7eQLfPppeGEK7sg+CNq7FgyWVmqLnub9q8EF1wuNzpXlQvqF9N+4GZw0KvgsYdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho30g4I1ujBGrv3V0wW9BB8Rupz2/VYv+LsZhi/P5c8=;
 b=l3dMQAisuVW0L9oRQf5/jSERKcvY7E7pQT3/v3h8dj+gybnSXO9JA8/2yuY0XSOHsmM5niKm2OdchCq5jj8qFYKdWWhvelShP7XLRKuEZmSvSWnOudtwo5LqSZLxPWU1D37ZKFQkitLTeBDMBHMwZTaU6rORmwlmk7ggRz+/NeBDHG7+tvveZibsjrkXgZeUhGO6Z0MlSlhI3DlWNTv+zlH9GYOJRPWZIrCJXjIVeVa2uw7tHZh/rFbFms5exJN3DJSmpgkzmFlqTLp5V96sM+z51vH7Fpht+VsYoo8Hk02Y/7Uc47TZmZcNjVF9FFedbuAwexWQ6XGShj94jOVTQQ==
Received: from DUZPR01CA0156.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::19) by AM7PR07MB6376.eurprd07.prod.outlook.com
 (2603:10a6:20b:131::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:46:11 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::17) by DUZPR01CA0156.outlook.office365.com
 (2603:10a6:10:4bd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 11:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Fri, 24 Apr 2026 11:46:11 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 13:46:10 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 3DCF640215A8;
	Fri, 24 Apr 2026 13:46:10 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id EE31E700DBB5; Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2 7/9] upgrade-helper.py: Add prebuild option
Date: Fri, 24 Apr 2026 13:46:01 +0200
Message-ID: <20260424114603.2444938-8-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424114603.2444938-1-daniel.turull@ericsson.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EC:EE_|AM7PR07MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 195e733e-47a0-41cd-f9ef-08dea1f71503
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	E/6ECrHXY/oE+igJFVyrvK/Lp4unsagoQcfnmJthNEpFr4IacNF9ogaNDP9oZVUKdGir0Xv0WZvnf1eORhId+WAd+dfcPrx512aD2CZzvQG+TL+hLlAlggfkWSrDUT/5UTRKKnRHs3POHM6SfGByN9+abYrKEZGz/XWFXGeE8tlYXjkio/fW55v2fx/RTWaga31S0EYFClm2J4skW4Sa16FI2BH184CLJgctA7lMCJQk+StuGkDx/hkZGJgpx0rMJJc+0YgAvbZNYKHON1rDPvJNIJ0Sep5/un++XOItSfiuta0hAS0AOwQgut6U8EZA3GBcX01pfb5qnxh2C0oRD8lMTl1GGYAVQvwL/T29a9xbhpJp7aF6+FTLtOT7ohlgghJAnu32sEzr4HReEyYDD11qHq59UPsTRvEwYDSqUj8HN6UK79G8QCDC8TAbkJjbLIrzQs091EIuzKHRYzka/ICkjvZx0Y1ZDoAfdFWqQ2qoBA0Yf1WBmGlJISZ1gXQdDMPAMIFrg18sGgLlvDXF+cTvLSZLMlJrtyOHMBpBQouJRYZ7RuGeljUpj1MewaKjhJUbejp0P/iphQbmZMXaKXc9OSODh5qPVBvlqNSgQ9lMEsnwBjJzCHqypEq0ed6VBh2PnSOWDiG7zfgL/xW+cpwxetAVODlPZkwQ4vs7qsAqlyEI+grwdjfB+5A0JLv319RQ3mnLNGmaeqObL5moBmC32ehgquIrOEj4qs+FTSRG+21Hs9JiJtHplMJ0rf0nfKgYgyismynZEt4hCO7Kpg==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Kb3ruZyQ+W08P3V4Nw7arOTvIxuNXPdNl8ALeRrpouVZ5aYRBJKeTw5LJu6/6Mdl4nvJeMSiy4pnzKWsq+tOS7Xvak7KLc9OyeFwdmgwai9xYcgx3h+uiwapY+j9QjL5UQ65mhz8eanHdHeC9aiysHMrvCdenqP81IcuvxxtdvqyzI33jOY/faOtG0LDiUrJk9FuQ2NhwXAGfSdRjiJhhob9A3AKPz40bgQuuBKZLKE2ha+hc4dx/g+wNOLxKPnr/Nr//ta5Yoeies3CxGzrli08JwHGGRya+DDuEDWiM1tPeBT3+RxmrflYIktxd/FgD/sezL/AOhP+AhT4JdPNPzbfETLAeSlt2w/o+t7YUAal9Cz1lfBGT2AePM5My29FxdMmpqm7izWuqnffbgwyy6MuRGJOjj1/9btbtrz0rez0doutQ8CwWKVWeml+BNBA
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:46:11.3960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195e733e-47a0-41cd-f9ef-08dea1f71503
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6376
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:46:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3790

From: Daniel Turull <daniel.turull@ericsson.com>

Add --prebuild option to build each recipe at its current version before
attempting the upgrade. This allows verifying that recipes build before
applying the upgrade and enables comparing binaries produced before and
after, for example for build size or ABI compatibility checks.

Recipes that fail the pre-build are skipped and recorded as failures.

Assisted-by: Claude, Anthropic
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 upgrade-helper.py | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index ffa7449..11a97d2 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -105,6 +105,9 @@ def parse_cmdline():
     parser.add_argument("--minor", action=3D"store_true", default=3DFalse,
                         help=3D"allow upgrades within the same major versi=
on (e.g. 3.5.2 -> 3.6.0, 3.99.0)")
=20
+    parser.add_argument("--prebuild", action=3D"store_true", default=3DFal=
se,
+                        help=3D"build each recipe at its current version b=
efore attempting upgrade")
+
     parser.add_argument("-d", "--debug-level", type=3Dint, default=3D4, ch=
oices=3Drange(1, 6),
                         help=3D"set the debug level: CRITICAL=3D1, ERROR=
=3D2, WARNING=3D3, INFO=3D4, DEBUG=3D5")
     parser.add_argument("-e", "--send-emails", action=3D"store_true", defa=
ult=3DFalse,
@@ -516,6 +519,21 @@ class Updater(object):
             attempted_pkggroups +=3D 1
             pkggroup_name =3D g["name"]
             I(" ATTEMPT PACKAGE GROUP %d/%d" % (attempted_pkggroups, total=
_pkggroups))
+
+            # Build current version first to verify it builds and seed ABI=
 reference
+            if self.args.prebuild and not self.args.skip_compilation:
+                I(" %s: Pre-building current version ..." % pkggroup_name)
+                try:
+                    for machine in self.opts['machines']:
+                        self.bb.complete(" ".join([p['PN'] for p in g['pkg=
s']]), machine)
+                except Exception as e:
+                    E(" %s: Pre-build FAILED, skipping upgrade" % pkggroup=
_name)
+                    if isinstance(e, Error):
+                        E(e.stdout + e.stderr)
+                    g['error'] =3D e if isinstance(e, Error) else Error(me=
ssage=3Dstr(e))
+                    failed_pkggroups_ctx.append(g)
+                    continue
+
             try:
                 for pkg_ctx in g['pkgs']:
                     I(" %s: Upgrading to %s" % (pkg_ctx['PN'], pkg_ctx['NP=
V']))
@@ -571,6 +589,8 @@ class Updater(object):
             tim.run()
=20
         for g in pkggroups_ctx:
+            if 'workdir' not in g:
+                continue
=20
             if g in succeeded_pkggroups_ctx:
                 os.symlink(g['workdir'], os.path.join( \
--=20
2.34.1


