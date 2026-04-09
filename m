Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB53E9DE7A
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 09:08:44 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.128133.1775725715986426575
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 02:08:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=tRuWT6ga;
 spf=pass (domain: ericsson.com, ip: 52.101.70.2, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSn6kwHK213YoYPKXYvMWtnhyTEr/ocS7i54pPSNW8wUuSd3Tj5Bj2kAZnrJ0c8QkeX/iW6XezB6amowp5sa7UGtRsWmY1tD3rogycp1TFCE5s6F3thPXOXieQA4ZgVnhnjS3Jh2MfDRRZXHycFgdfRXQuYzOCglAze08xo2sI6craN/0NoZjpF5vc9o8l13il6APJUDdHJkDjiHa23JhmrSNS5y0J3WAJpmeMRaw/7G+sJ+lKk5uZvHFMu5kizYosB+0/SFfYzrAsC2aaTNhK5IkcIIrcbRZST3swYtf0gjCFSMW5s5ziQKP92gEbCm2NzscuIBp5Wq7gk5wIGGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A67pgQDA7YuBcVZOJByNQcpqT5fMdNXIrrVp25u0p38=;
 b=WuFQSQf/PV/8nNLx4NG2Y/TmzL2U7rGOYzMub9OmKQMyY0CDPrUrQ9EBQbEjD9o/P7LvXyDCjSDCGZQS9cyPmoCizyMfOfMqI3Bel8JyxnFWODTDPnGHiSPESkMQ3EzYYrR9XKaekqSguUpI17JsO4pkezeCvDRSJbz3hqJH3NpT3CZT01u8H2j0xu+8A83ZQNpyt+sb9pF0mjH3hfd5HxuuwRHapwWIhLFpw/EkwGWDnKxvw8bE3cyxlJ3tlMh3qy4JiSISxs523PtaiUnAZ9Byl8XH96ZatSasu+VNqmCNWHhJuVl1HOhKWMNEA6ErDvyt0EYabn1OEVCNpeWzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A67pgQDA7YuBcVZOJByNQcpqT5fMdNXIrrVp25u0p38=;
 b=tRuWT6gaFg8O/iWLJjISGhT5MBUdDiBJ9MoaJW77Mtre6KKh2YVxGOMSap1Q1a6HBb/AZqZGUkyAB6MB9eQjG37NwRntRBseE7wiNJmQBBX3KDW2cHWGSR7Bazwe6jTxWHPY9IRXdh7O2qNJPTNCZXq13YmnMQNfT2OTITvbbW2Lf0ab9FfZXMsnmKCtzXhrZGwcWkPqwA82vm/YRFo+9xR/287BlngEGkC6DUPTA8CFe/ztTZfLpbyLXBny+26JcQ0TgKGve26rErv3QEO7OdKuZCTdVKnsyHl/2HFGHjbZ/iWR+0wZtuOwKMXhLZnPQls0JZGJwo/PHL9hc7XtTA==
Received: from DU7P194CA0029.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::22)
 by AM9PR07MB7889.eurprd07.prod.outlook.com (2603:10a6:20b:301::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 09:08:29 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::23) by DU7P194CA0029.outlook.office365.com
 (2603:10a6:10:553::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Thu,
 9 Apr 2026 09:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:08:29 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Apr 2026 11:08:28 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 5E18595151;
	Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 1CC56700DBAF; Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>
Subject: [AUH] PATCH 5/6] upgrade-helper.py: Add prebuild option
Date: Thu, 9 Apr 2026 11:08:14 +0200
Message-ID: <20260409090815.1731294-6-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409090815.1731294-1-daniel.turull@ericsson.com>
References: <20260409090815.1731294-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|AM9PR07MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: b33078ee-4242-49f7-3c8e-08de961790f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	r6iM66lyskQbgkh/NQqwHC46LwgKdaDZpKJeSHLRN1J+ZhsnNbogSi3GRHQLBpc0PBgwhH/5hsZ0SThojFa77HT7kgfHMG6o9R9WtOhMCE/l8sWSQAcSzHAzCBsizWrMH6k7yH6MHUmPYVDm8SWp+vdvwIEHzXHsZruwxcoV+p7Txio7rVJgdj/79kamfc/52DeOSSzlA3T/UKsyQyIEyfANurMbGzRy15/Y6nLOnUc9qVqbripewNC6a6vGJvdihbPpZkImDaG2+BeObKUv8vcFU3cesOOvmnn4+NXViPqpzXTKE0jRwT9VO/YOGcrYzkeHFrm+jL2ZD1JVyQaQtnBnb/2v3LzLzX2WLqnrmEDAoMvvsJobw77D+pixMhiQt+ydkqQj7DzJLkrc8IuXTZ0o3hxv+TiCMwGqhZCt4hlPuqAxBuMuhuqBEdjA6G4atVwEkNkMbQrD2QTEMoJgAeUdKZY6cUiEArXNwFQNL5wjXfdy66TjK+BrQqjhQMue0mAo+zHtyjZFOVf1u1LdCvH1d0vktcdN3PX+hyxaHxvyhYp0z5UvYhYfm1Ar+eAEEXKxF7frlTA+Zbq+xRHEoacILI+64Tm5AnbipOHOc9J6gTMbNnlDis+zzFnaOt6OxjuvYQhz5MWewq4I9PBtCK3OuE0yHfu7/dyPLuWk1qgFzpS8Kb2q93jgG/K10zmACmGWp9bcCUHssyLfut32aZ6RJoNAHVDrv7ZiPrXJnA/hZBWG8HQXd00Vq0AvvosTj7uRiM5ACrxD5MRFm3ZmKA==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	mngSS8Q+XaPV/dQUQKMrw9/JiZq17qfaCo5dvGfKMDoXfaZjotcZ0E+p1sdu8BwxdA8LVla0DXccACRMJYXsgNYEWiNTVz/+s/Vr4w5TjNgszcuklm4evyGnOeXJ71LUV6igxnSUXyZj09jGncKoEdwQgd/29r78d6Xpv4Uncrg/SdEYjDDMp5zgTULUsshfZLPl/2xw50ivOh+VYEnhGubdpyo/w1lLKAEEDRybzIVJxA7A8leDIVL4mfyxMJZbQM+cM+UHO7LECsq8Dnpv+sS3hc8uTX5VotE+3I13GhMZqF0fkb1kOkP81STa2NfDcW3zSZsf4ha1sNjYDTfjsLqBoukGE9rtdQymE9UBUM3IFmd1bZdK9kpMA9efv3FtBwZpfY7EMzIUTln79qkC3csw1URkqeh/S80vC68D0a36STTxO9Il4smdaTSjkFML
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:08:29.2923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33078ee-4242-49f7-3c8e-08de961790f7
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7889
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 09:08:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3670

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
index bef9bca..945c4fc 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -105,6 +105,9 @@ def parse_cmdline():
     parser.add_argument("--minor", action=3D"store_true", default=3DFalse,
                         help=3D"allow minor version upgrades within the sa=
me major (e.g. 3.5.x -> 3.6.x)")
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
+                        self.bb.complete(pkggroup_name, machine)
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

