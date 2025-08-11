Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E32C87FDB
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 15:00:07 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.68])
 by mx.groups.io with SMTP id smtpd.web10.50431.1754924397505236149
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=WcxUIPSI;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.212.68, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj4JPuZGqzwmO3341AhlI97wtnvjJl/pMJQI0akh57+irLvgXnpKkRMr/laJWqQOUhRqv8NPU6s5ySQYjC48sn7f6u6rJy9DpFibeEnxztwpZPMQFnIaz37GawuJnlmpTSvV1a99A3L+yiHuxwxBlpqWnwUO15BybTM8Yf48/RqduFpkbgTuEiVk8k+XFSDZU8XhA/jRCIoZULXjimtAFJQRhn3kmDOITnd0FA7oo0RTjOyCShFJp8cvXzJB80xN1ZlAbZ7JwMR9I/DMVdgRKD2r1dtSJDadvBNwqIv554eTzFJuFRgv2d+bAKs5Qr1Ubrqv29/t5eCuli4E5nnkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR9pj7cigNr/qZGbPUp7Bzn1aD6Dmt5eJwLwILqqrzk=;
 b=YD99oDCD40hOzbWWoJf/u4uta7UeJ0UAr/S3kQHht+ddOt80CdlI4fqdKbVSH1CFuZ+RGrzjc/L183su9YT+Qf4Jia5ty+Rd4FQP3F35ZHXZ2u40YZE47xmXCEmxwMoajUd+NFdG7VR5qYTO40h3npvChS/pO8ggNyNtymqk4raU6Ic15hjmKJtHvKyGzaIM7+jQt1He6Dsz51cIDUY0ExYdAE64MYeFea+tFHpSYsaU8w3cKYSfYp86uBXfvd3TPIberMpfb+U3x7zimmIvcGIpH4uV81CFNKiMYYcR2ZfCQEvYkd2KQP5fA0B6ZvW2apfhoomcCeAu4sSEuGuZBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR9pj7cigNr/qZGbPUp7Bzn1aD6Dmt5eJwLwILqqrzk=;
 b=WcxUIPSI0CYWA7THI9CzBRzhE/TWcwJLvBxAKaF0xCqZPyHVU0Qkp4JpJAcbnprx3QbWKtPva4dn6Dh1MsKLFQyVu8ix6wgPLye7aPeC96TvtDo2TR6eSQF8F1zdgZQO4tgamkxJyT6eqwTV4k01Zym0QXMPfP+s1uNL4ly2QI0=
Received: from BL1PR13CA0269.namprd13.prod.outlook.com (2603:10b6:208:2ba::34)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Mon, 11 Aug
 2025 14:59:53 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::10) by BL1PR13CA0269.outlook.office365.com
 (2603:10b6:208:2ba::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:50 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:50 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 13/13] zephyr-kernel-common: Add Board extension support
Date: Mon, 11 Aug 2025 08:59:41 -0600
Message-ID: <20250811145941.2553838-14-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
References: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: afe77edb-7ddd-45e7-e769-08ddd8e7ba4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2LlyRWz4mmyTiRvb8Q20s4IRcdgN1CAzWcl1aOyzZjWhfEqWTMkGj1JlWFCb?=
 =?us-ascii?Q?ITBocMsARHxb7aKnzICPyEme9rAGE+vFTgavDKfuBOkqX3wfgUoyHhMSbkvK?=
 =?us-ascii?Q?wXJylxpc8eNxIP8OsbHOIGNXsDaVNh6xSfnN28onN0kxv0HqRE2ADXzWjc9Y?=
 =?us-ascii?Q?jaFU4yCOTuATR0+lqTDJRGaBjiB3YZ7/SoHIniATdy7tI69Rx1EKKA4AKqZj?=
 =?us-ascii?Q?815LWNQqodozwnwU9ONxfZvVakazhOq729AccKNjBspwj8sxE3dXVDIx+M3l?=
 =?us-ascii?Q?RxMkdQYTJTAiJztQljuJq1kssN4t6SotU2bFUJiul21tL+xxwIVRBk6cEKbW?=
 =?us-ascii?Q?Tj/wK6KRsVVZUzpslv0jf/BgvOBacECUihixFqe0qVcxvjf5EkozPPYG0fzO?=
 =?us-ascii?Q?1gVIMIvfENXPaVCB5UA0u7z/byK5pLB7Wdc981vIkEtGPwGIhOwpCVXychLB?=
 =?us-ascii?Q?vcF/JNFSG4TWL13NnLkOzM3irRwtWP9G84NEnHrnfUJIIUwYr9De8U+E4EV9?=
 =?us-ascii?Q?9C9oK7RQ1arWsA0mQzlYvHhqXqjgbVPHj7gFFy35etIzHW5tB2ncnqa3OHvr?=
 =?us-ascii?Q?KdzaGBRlzxcroEMDdlEs7Qe2oKm04izorRNHjyzAwBgZ06kjHA8PL7f27lMc?=
 =?us-ascii?Q?gYGxA9GBSrq1sLgoCP0XS9ri9VBWnw62KzfCah/oNFsJIelhhZxb6ajpuqWx?=
 =?us-ascii?Q?1VQ5ASgVBBRrHeCvczSvRCrIUF1z1wrJMg6XIi9yNAF+wLgDreKJw3KUM2Az?=
 =?us-ascii?Q?2QpTAFFyd6hholgPwkNgWi5oJSmYFing4SXgBk19YZ5SWadiM3B8647nkojm?=
 =?us-ascii?Q?tkwFv1+D04wbcBFyiago2T9NWeri48af11SKhXgmxsl1Y12smqnf6AkXvYw+?=
 =?us-ascii?Q?CJP5OSGWgfhu+r1el4zcMOY/qNXf1glzgqGZn9/mvkVslJx73/5/CPX3JJA2?=
 =?us-ascii?Q?aG/YfLdcGm/1HIGauPckgSfx9UfwWxZsbV2KfWd0+rwJNjFqEG3ZX+ZONu2Y?=
 =?us-ascii?Q?WuyM5rEiqOZpr4EwTi29N4aos1XxircTcNNqqnejnn+NcTcDrExK4CTNDl/U?=
 =?us-ascii?Q?AdR4Sj5PWSwH5OqBxpnsczXW/q0pmxyJKKAoReu56gbQQw6qX37gnLlQOZ2I?=
 =?us-ascii?Q?Iz4W0o0SywPxTUVdjJKyqjR+UYcfF6hPxQbotFlq2Hwwfvls0GhGfqnnCW2w?=
 =?us-ascii?Q?A1UkVejImnIkE7p+yYhqwfSHTUsvceEycgqAqRN1HKDjbs+ajW28uG8f+CpV?=
 =?us-ascii?Q?XdJ8oCjhxIg7ZblnrWpJukmT/dMx1DGu/WmEx8HLo46veArfIxsvofmhbFPf?=
 =?us-ascii?Q?zrfDyThIVLMGA32t+ugB2sqq2H3AYjkk8LNrIeYVdETQyKHPoM9tBCbOuLPJ?=
 =?us-ascii?Q?wNebWMneExl6jrc4oFy9qPD3i/6dbPKumbWmp2MrkQT79s82NPmkUt4AokaJ?=
 =?us-ascii?Q?Z7DkGPG7hwSyMPziz1ZSW5MU3niwL0ZC/hNnn3LY7MvOaC4qbkJDnIC76l5o?=
 =?us-ascii?Q?nJ7oZ1OlWYfGaAyKJiV2h3HU+yznHEMS66XT?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:53.0811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe77edb-7ddd-45e7-e769-08ddd8e7ba4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 15:00:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1941

Add board extension support variables where user can specify the
BOARD_ROOT variable for out-of-tree custom boards.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-co=
mmon.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-comm=
on.inc
index 5191b9a..579fd6c 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
@@ -18,6 +18,11 @@ EXTRA_OECMAKE =3D "\
     -DZEPHYR_BASE=3D${ZEPHYR_BASE} \
     -DBOARD=3D${BOARD} \
     -DARCH=3D${ARCH} \
+    -DBOARD_DIR=3D${BOARD_DIR} \
+    -DARCH_DIR=3D${ARCH_DIR} \
+    -DBOARD_ROOT=3D${BOARD_ROOT} \
+    -DBOARD_EXTENSION_DIRS=3D${BOARD_EXTENSION_DIRS} \
+    -DSOC_ROOT=3D${SOC_ROOT} \
     -DZEPHYR_TOOLCHAIN_VARIANT=3D${ZEPHYR_TOOLCHAIN_VARIANT} \
     -DZEPHYR_MODULES=3D${ZEPHYR_MODULES} \
     "
--=20
2.34.1


