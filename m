Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02CFFE521F
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:46:26 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19330.1777031176623999700
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:46:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=XKzqyakv;
 spf=pass (domain: ericsson.com, ip: 52.101.83.12, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEyCz85+RbX2be1/ljn+m+Er4jYDxMY0PO77hYCht3PAbyS6FqLNTAQsEzB+jqhoZFZ5N0XKpc+bUgXSoFnFaykv99pnkcgnoxVP/VqLO/iF7XaH5qx1ybLYB8yUOXTYNhUULXOaZndJgFLbjO6qVFx6WjfEiQp/0h7KJwEcPfIwo0DcSYEu6vyp/NGpT1wfLQ6xSDxOxnPSUTA6hpeQMmJQJCw1Z45g568/MbHPZpORmWjyO/PmoVrWATjK/ZJZEmBATCWMfRFnVF9KWaASAZ0ziilvUM2o6cctkDIOkgmfDiwAZbjMKF4ik+7JovP+5Xw6RBcFSZaMwlUVusfU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIUd0tLuuUs1eiRDNKt4w7Um0JpMG7TboLW+XBO5kcY=;
 b=UtyS3Pz/updWbjXbAJ4Ib6bg/zznn9BZODPY1PpFLuctvpcsYGTK7gz7MiAWj9rsBjJHM885Zcxx7PH366iiTwjUfQMxpPFgXxE9tmISBpJWIq4oN1GajIuNP+usxVhiXEJVRsntiMeA1+EIk5+7jaPQsYvMcKhd/CBX7/wW1El5CFN9ogbRyw1rRvWNZM50ASZElQBvdTc9REaE1+roDW6hl8iCtQi33iEYZsUjbNoqPK3cuG5qcaN4B7Q266I+VajleeOIR31IfWeicf79PlLHAeDB+1+qfvh2glfirSCsmP4MfrwVA7V8jvqt8JeLruI3f5y21BFXBMSyUQLtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIUd0tLuuUs1eiRDNKt4w7Um0JpMG7TboLW+XBO5kcY=;
 b=XKzqyakvFc7kxJajQOOp8XepDf7hoXqlBLzGi92ge79JuFcECmceAQlVnM/iQ/RfBuNXHXZJVN1zdketI5Nx43rMcpzQN/Ku/ZZM6DVHg8/btw1l4/A7Z/v2johZxFk4T809Z8yeSCg1biS6mb+60QJSGXpnuV513qrZQDpv061l138s+JbcwZEmiYAcOHtYzpvb6VZb8pVn0HDGSblLfwsaS8ZWMjnriaBjxMptFQWr3GnL66fqtzWXCr+gvnbU3IQIk39bSGUEls3r5gWyUi3kWDoGXNQDbFgE/c/Qump0edTq47d+au3gHsc6qZpE9zHfAT2AO8L4Mfn0wvLTQw==
Received: from AM0PR10CA0050.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::30)
 by AM7PR07MB6737.eurprd07.prod.outlook.com (2603:10a6:20b:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:46:11 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::3) by AM0PR10CA0050.outlook.office365.com
 (2603:10a6:20b:150::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Fri,
 24 Apr 2026 11:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 11:46:11 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 13:46:10 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 4FEF840215B5;
	Fri, 24 Apr 2026 13:46:10 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 02863700DF4A; Fri, 24 Apr 2026 13:46:10 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2 9/9] upgrade-helper.py: Limit number of requests to remote servers
Date: Fri, 24 Apr 2026 13:46:03 +0200
Message-ID: <20260424114603.2444938-10-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424114603.2444938-1-daniel.turull@ericsson.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6B:EE_|AM7PR07MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d14696-fa05-4132-496c-08dea1f714d9
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	mGU25RgbS0JQIJ3UvKuWmNh2t5OXRe1pZaHrpYujtfuBOfu9fXDUrdkeb6MW+XUzaaTCiWMEDZ632QGZwI4m756E3ngXi4sg2Ck12oNfLYDo1ie5InW13wBTS5a3ulpMeA83hN2HGDIPPqnPGRM3Z+0czIX1bkFnXjJP13jsyPaLdcKjg2iEWu4/e238hItFKaIExosMGpmuYTszpqgbFDne+/8uZUKJRgm8rAw8DARIJA6IqZma90EtjzA5cRbPnbUpXdKAHDPhcuq9owG6Qz5IBRR9bTjwTM/AjQezVd919yEdgVvnmpL5vr3b5Ztq/jEaOPPv/m1MVl152Fijmdpx+NHvOgnXTtOfxf4eONbX6n3gESCvRnAvysBg6eyqBMY5tliSK9OdYF6f224DXUAsGSoETTHItn0S5xV9YTwDJN4Suzx/mLLS+O2sQFE7K2vNA7fe3W0Ieja6mWLOqn7RllYQwRziOQ6sQXW7u8fiOjYcgAcy21AfJLxSZLzM75AZQpOMvGvXOUeO7XmYJ6qlFL/kwEZe8la4r636kepoAM/YLUFs8HIMf0UJIXtz4gXwPlf0DXdvOKuZ02ghZyrBG+c4eqTrIgyO7Lagoq3NQ9n9aVZnaZ8MaI5CJifFVyFdiiCXoxqGWEq5Vo8ytIAEQo2CKeqhrwelQAXCM7RVnCWH25qyb0HNYvI3DIwaHip920uLiz5/Z7Fl1o4hherE1d3g9VmHRZddUmLQmsBgLzNuM2lRaN3Vp390JVCt44zMA51hLdCskbhcH+tCUA==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	8FUikh5AGvFc4obU8mDFTy3c7a6r9oelVNFu4U2RQKHBMOVaZrSXhpphZuizGiyTaSkWbLjHefolVeks67UANSH3baJQNuJhQ7NIH8tSbpl6C94vORam2U9xLy73lx7itSxUkNUaLAp0EI5yibdTDdi+jNmMcn3GfMB2cmYX726aUSI7m9wsbuXVZblxWAK37I/FKahEpUVMs99BckmBkzZk2KzdA98V1QL61EgOh4yu06rbQQX3+Vq7BbyciybzrIvTBayFDSRZdaFNEm5CVyji6nnVBpyzxl25dDjwNK8ThTTAG9j1a/TbICIqItk277OQ4DzoGLU+fKeQVYKhwT3zmJ5vdODhM8/GI+30cqETmQc49jh1sfUrsGH1vAf8eQVLA/4oW/1zW1smlD0gJbObTxMLbQsgjlLrp31i9gquhCkPEmLO0wjXRGUpWZxW
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:46:11.1323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d14696-fa05-4132-496c-08dea1f714d9
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6737
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:46:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3794

From: Daniel Turull <daniel.turull@ericsson.com>

In systems with lots of CPUs, we overflood some remote servers
and then we get timeouts because of rate control.

Be more conservative. Defaults to 8 parallel workers instead of 64.
Configurable via scan_workers=3DN in upgrade-helper.conf

For example, ftp.gnu.org was timing out

Assisted-by: Claude, Anthropic
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 upgrade-helper.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 58fd660..11b8d58 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -808,9 +808,17 @@ class UniverseUpdater(Updater):
             return pkg_to_upgrade
=20
         upgrade_pkggroups =3D []
+        scan_workers =3D int(settings.get("scan_workers", "8"))
=20
         for layer_name, layer_recipes in self.recipes:
-            pkggroups_iter =3D oe.recipeutils.get_recipe_upgrade_status(la=
yer_recipes)
+            # Limit parallel version checks to avoid overwhelming upstream
+            # servers (oe-core defaults to cpu_count which can be 64+).
+            _orig_cpu_count =3D oe.utils.cpu_count
+            oe.utils.cpu_count =3D lambda at_least=3D1, at_most=3D64: min(=
max(at_least, scan_workers), at_most)
+            try:
+                pkggroups_iter =3D oe.recipeutils.get_recipe_upgrade_statu=
s(layer_recipes)
+            finally:
+                oe.utils.cpu_count =3D _orig_cpu_count
=20
             # Collect results, logging any fetch error that terminates
             # the iterator early (oe-core raises inside executor.map,
--=20
2.34.1


