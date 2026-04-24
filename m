Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F106FE5218
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:46:26 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19332.1777031177557329159
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:46:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=nb7B9yYZ;
 spf=pass (domain: ericsson.com, ip: 40.107.130.24, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBPSXyh21hXVEEte3u89emwUvrY0Od9hb/C7FIHKOOSRU5s3JxDeguTSRaVifNGkSNF5fYvxcYW7KLhCS6/JU2KRGSctTVq8RFv7X7I0l2DPwgE2OoXmxuLTb2JrlupZ+yARZ+VKu5D5e2Bw3UKK0nufri1i/B4UE/i4mKZpVMwD3+f93Attdor0y6Q3n/13BlxgMhqU232Jtjmjd77CT//nsimXKFKJxWLylVQ6yyBU5n8wAtBbO7SQDCRAW7tOVKEiDnmzSRPfYuBOfVywiuRtliXYkE/pmNkbQd+QWBcAnF+4xmEie9rVhfzB01MOewvQcRbCZjX3XzTAMNNibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzL9ZjgRWl4nlPSudBsrTN5W0L9NwmSrSNo6GX9rSic=;
 b=MnlQaCMCtU3inRTVSJAFBCUIpin82l04RUB7IMd50ABTRaZ+td2imdAWXaCfcBIWh0ucJvrKQG0BMX7xV/61thKn2G8g4Y9BeB3DE8K/AgMsck5koQYkXAhUr+PNKZSZDUSEq6Jm9XFCwlTaXjSebESYIgP7ONLcfDcfIOqmJYjW5Kz2A4wunauZ5wc0cIW0iImxSYZv/Lih97EcRMCoUhGDd7eAtSRpkrptXWZRfnfvzK5ejKEWHZOzzgiM6S32MEPiVpL0vK+joqLBOTb4xSC6eWzU2WenoFTqUxXqrP1TyUlM1kLX+J2fYrPvJpwxF7RQLFGApMErgij6E4GOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzL9ZjgRWl4nlPSudBsrTN5W0L9NwmSrSNo6GX9rSic=;
 b=nb7B9yYZTBH3q6ewyYG9S9/MzhsGKnOmiBI5etDq8lwmr1y8rKgT26giksCMGOpwqy5X5nvrztrP1BmltUDRwRxwqzcNkSfW/hDFUioMrbSo1bI3NYV6iN6xqNZYt0jMDXF8e3ItgTUL3NTdrLkhkvbyxwoRcne3dap/g0miQjOEgO5/+A7AK4yLa2Ml4NcWeQy5ThyxtSf7CwyBFLHyi6L1JVbuFur5/KGNnH/XxLDS/ge6XvjVD2TwPU1Aid1IEGnL5arTBuNVY0sTUSB3biAcsOqvUt6kaqeV1D06fpbBVK77HP63N1STbBqfA1wg7dp+8oaMOfUA8nQeAJssRA==
Received: from AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::27)
 by AM7PR07MB6964.eurprd07.prod.outlook.com (2603:10a6:20b:1be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 11:46:10 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::c4) by AM0PR10CA0047.outlook.office365.com
 (2603:10a6:20b:150::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 11:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 11:46:10 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 13:46:10 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id EE8299569F;
	Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id D8652700DB93; Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2 2/9] upgrade-helper.py: Handle fetch errors gracefully during version scan
Date: Fri, 24 Apr 2026 13:45:56 +0200
Message-ID: <20260424114603.2444938-3-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424114603.2444938-1-daniel.turull@ericsson.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6B:EE_|AM7PR07MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df55fc5-c85d-4136-5ff1-08dea1f714ac
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	VJ/wnDegqMtpOyzBFQLA+3TcNQlSUH1Gr9+q444dNcuqwwEnP860QxbrW9zP0qkZY7oIu/7+IJCRT/1A8gg0eyeP3SuKmr9f8+Xks9N2yeHgazllED/Xn9PsZtUjr6gu33zSVA3pjD8RpLwXWXHJQPerkMMv8cqAbN+pG5lHKx7EGsE9TD7OEfy1BGC6TUNXMTM9584nA6AR/oD1cufnrGehBn75mX2L0wJqZrBQFe30izNwUVGCsHddDrZmaWem33U8jXvcaA/9+HI2DiWbLUcE/cNxSzak7YNPmx5G84v6VFAMot2A29rtzw4K7Inf+NsTcPanzRp3qlhHnGWBXBzfrf5Q7Rgqk1t4j1nbVln6/ndcuKP3/5JogyOtmVvx5YT+xAWa1zSRzGq2ClC6+LGVhxAqNQkLZfz9J7vplVXAaEyk3PXG1j05p/2jYnVwn4kY6ua02z4kK/sUaoCvdrW8d9B6j72aFO8HT5Shcqwpcu+OVboiZnJpNkFDRGmvlbfGatY7cvandHhIIOrG19VYC8AGVhwxBpsw8H0Zc6sYhAG8VG+pkHjtkJctmdbxs1lm8QBg0bQNJlePdaReCcv+lk8nl6+47YBiUKzlb1XlkFzfjNu38ydaQ75basi1eaJA/rE7VlVknV78NH+b8quNgSWeGSi1tkjWTfIMWIB2Ek7inyYrrcTfVaeD8nbnTSB6SpKCVGxFVZGxkyJP3NzjBoSE3uTgpwhHbJCErbCxylnXwYoCC1tDMAfqt4DDwX6sE3Ka89awhhoBO9EbqA==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	030T7HG48xBZEXnpuozvpf1ekkwC4dEIwiz0asUPjgxT6356Ofw4Tk+MhadtiV9drIX37Y7MpBH2CUBTEWhJ7VolvHOGaJ+f+hrxLQ/lzzXbu+KJQxW1mpFlBHwaxx/Wq9of598unu3soTHiAv8FUC/Ee6cZg05WpPnWYb9AJCeNtq4cI3+svXZIVtx8645N6M+gZdCDC8QrxPjUjDV/a6HWjr0G3mBbrh91/YqOGyzfzr5IRC/6Ja/i2l7MfYLOpYGVjH7+BGN7A1sz30wRNchZJoS8ZDfo9AsELx0uwzGjjQuz2n5NhK2gnOZl2g1+01QYqzFNFf4mpvBIrdJ0N/+KbbCk3n2jstg3e+2k73L4i9yhupBP9cCBu7ieHqGx2g1FzkCGrf1bVwUdzSeQxWXLIaX8eh/5a9zKE1b/FwPTEd2lZyCcve7x6p3hldWs
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:46:10.8376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df55fc5-c85d-4136-5ff1-08dea1f714ac
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6964
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:46:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3798

From: Daniel Turull <daniel.turull@ericsson.com>

Materialise the iterator from get_recipe_upgrade_status into a list,
catching any exception that terminates the iterator early. A single
unreachable upstream (e.g. git.savannah.gnu.org down) no longer
aborts the entire scan =E2=80=94 the recipes collected so far are still
processed.

Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
Assisted-by: Claude, Anthropic
---
 upgrade-helper.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index aef7ed1..98391f3 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -711,7 +711,18 @@ class UniverseUpdater(Updater):
         upgrade_pkggroups =3D []
=20
         for layer_name, layer_recipes in self.recipes:
-            pkggroups =3D oe.recipeutils.get_recipe_upgrade_status(layer_r=
ecipes)
+            pkggroups_iter =3D oe.recipeutils.get_recipe_upgrade_status(la=
yer_recipes)
+
+            # Collect results, logging any fetch error that terminates
+            # the iterator early (oe-core raises inside executor.map,
+            # which cannot be resumed after an exception).
+            pkggroups =3D []
+            try:
+                for group in pkggroups_iter:
+                    pkggroups.append(group)
+            except Exception as e:
+                W(" Fetch error terminated recipe scan for layer %s: %s" %
+                  (layer_name, str(e)))
=20
             for group in pkggroups:
=20
--=20
2.34.1


