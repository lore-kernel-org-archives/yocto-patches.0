Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3297.1792487376573385465
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Oct 2026 02:09:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=MNApo2Jh;
 spf=pass (domain: ericsson.com, ip: 52.101.84.51, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrGuO56pCYlBmy0qzh6xuEAcXBoLGb1s29OIvzMRyA3X3Aox+i2t9GR3ctnIOZh8Ny/dqp6qjO9GihHJ9p1ZN4i8UXn/z4IWoX50ExquLccInFeEdYtu2UGRIySnK7iepgRl/OHnta4Z9lpOhWulbF6jiRp8Z5/pc6XzXi5LI2tGfga8xdQIjtusu6boE0xq6G4UDUnXCPg/tsfuynT1YIcBhLCHZOYWPTofgXK7W+IAkpt/FwHYkt9Rs5ARunNOpdZ5y+zaaNoZeeeBUVXlLxJZbsEsW6Ko8QvTiuMGdPx1XNYPcixxyr1sKLJsi/SmTprQxhMuJoYtWUTUl7rJbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a+vh9ZaXvpWV1rcBl0SeL40e/ix9Z3DvloIdlvchkU=;
 b=gwQnpxleyH3ILHjyyOAmY8qgpm/+JJSWeVydCDWNqqA2U5hLqy10qY8E68aGO1TvFK0jwHAhsIvzFAn7qFzc5gWpxBAW/lXzAw/2MXl2cTcbem6smIgborwVciQsRW7RHrPvR9+VnrREJWHR/PWUgeJB96EQlgNVFyx/pizJkFIECvVoxk3q4Y9DJU1yH20tslYvTBp6p0iDvQf/EunjHNNh/354m+63m8faD2lchxEkRV8pVpkXpnucYfi0jDvWj2lw9lHkysuroJfijafQZsMgykSEgTz5a1r77MpIBSeW/v2SlIh7jLi/5zxQ30atJ71tWREF7VWZk0nWuV4TTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a+vh9ZaXvpWV1rcBl0SeL40e/ix9Z3DvloIdlvchkU=;
 b=MNApo2JhbLf25JdQAphIa3apCjIpTnWe3zCT0CkqfhFB0RwDVMZBhFeOngyPrDb7y4zSwKH5FthW9yYOvFmEXfYXRy4ZKwsHLSuIQUgu3j/Svj/MHJjOlKq9RPNO62IyWxJZ1UD6/YOEZeEGWrs6OynYVFfoCn9QJOGtCp6Qyg17C2iBs2H6XsAlhkhf69IgaETL+0TG2uOG7vAAxzNc1OaPoQ0uC2mxBIl/AoPLuxlQhkERhK/TRWWkUKGnmaJaFgySbdxHFwKOXGiMXsTBsIpgGOb+BypaTASswUjcxQzFlE1t2Z9ZZgBHE6cSoCNjqt1TGrKt5cSQ0wqEKvpJ8Q==
Received: from DU2PR04CA0010.eurprd04.prod.outlook.com (2603:10a6:10:3b::15)
 by AM7PR07MB6295.eurprd07.prod.outlook.com (2603:10a6:20b:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 09:09:30 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::56) by DU2PR04CA0010.outlook.office365.com
 (2603:10a6:10:3b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 09:09:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74) smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 09:09:30 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 20 Oct 2026 11:09:21 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 3D09F4020B6B;
	Tue, 20 Oct 2026 11:09:21 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id ED164700CF34; Tue, 20 Oct 2026 11:09:20 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [yocto-autobuilder-helper][PATCH] auh-config: skip changelog in commit message for noisy recipes
Date: Tue, 20 Oct 2026 11:09:17 +0200
Message-ID: <20261020090917.3132154-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: edaturu@ericsson.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFC:EE_|AM7PR07MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 45277c9e-7b7c-46c7-6c94-08df2e89d9c9
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|13003099007|11063799006|56012099006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: EPeXzVjRnZpNlm7+aRfklIu8+jvy5hK8xswuh1QZDSOT78joijOZRfToxzTIYv4QD1aURn4wPNOJLzPQvpI3CroPRBs3jNxMw+hM+MgI9WRdJi0zcy/CDz69x62sx0cSc+8JrNZzVK4jLSVoLs9roFpLQ1fEWKdFfOJX/GICUDog2KDeEuakVFPi8rvLTxu9aJjqyUDI+sDXb+ZwRBBdiaKc2hEBadMkosL9M3yORLL5ItcVM4MeOMAqdNJ1Ez+9kk+JSnK5oJcTpxeHRGDXGcBMGlsRuWqQACn3BoT76v+yyBTWJvrT1lsbzxbwW9+qWFQ1YfQv7GtQy4NW/dEZ709Yf9/BBJBsekuilrHr2Kg8ihuZQYCEkJHds33dpXJD0uoZzdgbhGgeLbMMNTosFCbSv/QLQho7pm5nvjKcreWFQS5U0Zm8bsdFa7yqtieCr//vMTi/yJTaZ59DuPxRYZhueKGZ5hvctVFf+RWZ9g8DLX1peTx5TC4aF3z3nk1sHqyyI5vF5oQYQ2vFScVBjLZ0gbxr8gjERH50xMHMi9w681cpGdpPEGYWStkgraKNsZQW+I6WgisSd5w0adN0jiU3YIaa10sgoUpyrwXC2zvHIJ70t/FrPHu6yG2Y73upcmyPjuAM8WGOG+bF5op66g==
X-Forefront-Antispam-Report: CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(13003099007)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pJ9DdVym81+VVV90jGSy8NNOZVtIgsU5oDLIuSPKrWwvTcIk4wkXX70rL2K+4++VXKGvxFMZf+MmvobZsjXMwuZNtRQaGA55gXK/tggu9GDXbHmmqceZCR71ECa6ucEq8xxP2/niuPV7jnRg2lofo0MEq3UCAWwOVN0cDUiGKLzSV3+gitTa6KJR9L6YvEZaM+AcZW/LXb8ktVLr8Qp26ctmk+o3gd1+nQ19T59G8EYSpYjp1ZHNAmuC1m571svdyIE/elTyrdQ9u4fOuaNyprsa92iIq/aZzC+KTyhISTluoBQ2XYmq+EvbVRdCOHnb7iJkthYyOfssrfowILp6B5yzdyMvm3U9EuVcnlQhARpdvddBMXu9eJe15zQ+YchXIhy+gFotf85b+lnhPs4XgxsvD1s4a2fi+FCLs+eLYuNjQyC8AZ8CCdC79Rda/lGH
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:09:30.8270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45277c9e-7b7c-46c7-6c94-08df2e89d9c9
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6295
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 20 Oct 2026 09:09:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5108
Content-Type: text/plain; charset="utf-8"

From: Daniel Turull <daniel.turull@ericsson.com>

These recipes produce changelogs that are badly formed for a commit
message: whole release notes documents (mesa, gstreamer, cmake,
python3), raw git log dumps (u-boot, openssh, acpica, freetype,
vulkan-validation-layers, parted) or markup banners (expat).

The changelog is still attached to the AUH email.

Requires the changelog_skip_recipes option in auto-upgrade-helper.

Assisted-by: kiro:claude-opus-5.5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 scripts/auh-config/upgrade-helper.conf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/auh-config/upgrade-helper.conf b/scripts/auh-config/up=
grade-helper.conf
index d7c6b1d..3a3449d 100644
--- a/scripts/auh-config/upgrade-helper.conf
+++ b/scripts/auh-config/upgrade-helper.conf
@@ -34,3 +34,7 @@ publish_work_url=3Dhttps://valkyrie.yocto.io/pub/auh
 commit_revert_policy=3Dall
=20
 retry_any_version_recipes=3Dvulkan-samples sbom-cve-check-update-cvelist-n=
ative sbom-cve-check-update-nvd-native
+
+# changelog only attached to the email, not added to the commit message
+changelog_skip_recipes=3Dmesa* gstreamer1.0* gst-* cmake* python3 u-boot*
+    openssh acpica freetype vulkan-validation-layers parted expat
