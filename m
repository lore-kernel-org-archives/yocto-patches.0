Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD661CA0EED
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:55:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.75])
 by mx.groups.io with SMTP id smtpd.web10.4403.1755230105688619432
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:55:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=PCBz3z44;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.236.75, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQYkSGCONW0gNvn4l8/q3jB6pt0x7Qfa2e24Z2fDh2N3Fz2qW+wFqTKX9kgTrId4AXeXKSUrtOqwrNv4QaOMRSFOyApLkPS0GaIErktB2PXIOE3fUbJAK8wzKseg0ymFU57Hf7SxWoet5UXhZ/UfiFfv1TWTwhbc7Nd2+kTTTwSFkS480aBjidUnqcbEBGD/sWc0BmZYYnu0m3TFOWVLKovWOAchqLSN1nVqxulIR8YYm6cT7MH90Fcq+ywUiTVmDwKyDbMd6wyXO9YAbl7l6C4feC6LW+VyzVf7cKdgvtI14RncWZpRi1K1xSBvQiC0Yb3RJ7tfg7iXnSGXwy70ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SstM2s0/V1WZBuDDHegR9ABSU3Wc5t1y6BzwAp+of9Y=;
 b=fJH03veWRfhNJW4pakABRqfkrbNzw7nBGEcAZBTQESBZRaFCxVwjhkfMnibQwISWvWdnqk5Sn8MJ/48Ryjawf2sbsEAZYk7pEWO9gfq/b3ytxjGf5LgrlCfLGH3LX4pHqdL1ZOgONeGzi5zolVaTlIZBQ8EzAhC+NuGIqGbgHi1Fs6ObNvKg6DEgBK1w/sBtpyJjP+1LcRF5gWtG7g5g+7k09FIUma60ByvVIpPajrHpZ98T96ldTYExP/ZRUalZd7hdH/hyHkMBAzjGRmF0TlJ10PcgmsZAoSY+M9JqjvXG6prdFTPakxU99l+TFGkoKt4Ysf5Wcde5cwrl77QJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SstM2s0/V1WZBuDDHegR9ABSU3Wc5t1y6BzwAp+of9Y=;
 b=PCBz3z44USTLaxNX2gKL6LdREXid/E+EXNapIm/RPTuvc5Ny3aFcjmgIm7aygptlopFTZf5BlOnKuP6XcNAG6CsKpYAUNyr5v2V3VLyBOzSjV57lYdVLiyArWX6oM98QDZHlfuqHMrHGoIYKeYohLo9Xt1MewEcJtfz5+aC08TM=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Fri, 15 Aug
 2025 03:55:00 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::f9) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:55:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 14 Aug
 2025 20:54:54 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:54 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 12/12] zephyr-kernel-common: Add Board extension support
Date: Thu, 14 Aug 2025 21:54:49 -0600
Message-ID: <20250815035449.2816001-13-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DS4PR12MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9356a8-f715-4a49-7c11-08dddbaf81ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7oTiSQYxc2HA1mU5vbId7ivGTLJC6sa5fo/3kNUrAp/rFhnv0uz3DppeLR2n?=
 =?us-ascii?Q?zl6k9OSbAI3ft/7BlHjDgSrOGqVs0hf7xZvSfOq+xPj48h3lFP7TgCF1JUPn?=
 =?us-ascii?Q?WH1LavuvIYrciUW+XOEKnRhxjTrQfUe0Nrid02mBqjD7ntjFohNZOMS17q0y?=
 =?us-ascii?Q?u2nMLKpL/HTNy3Elwe2crsfCTm+aFwOmAquSGVecLAV26SK0Qk19iEUPZ9/E?=
 =?us-ascii?Q?eQciiMJEUEoiuSwx+UtTONDEMSTZH/RL8n5NbYjkosbMW6aCJZpy1o7M/9vV?=
 =?us-ascii?Q?nkOoVPZm7UZesG1+PQKcwXImJI+soKSeJaxtDlPvKTXZukJ7GcFoVQfklgbd?=
 =?us-ascii?Q?6AEAKV8/ON6l6FQIOIz/6UhPb+DiXn35i6hYeUDLzX1+Lq13JfnZPNavRGta?=
 =?us-ascii?Q?AkAOnqJWi7wmzJuIm/7jvN7jqHIhF7WwCyjN01KjQpQ8KGjRE4HyPGIjQou/?=
 =?us-ascii?Q?VM5Oh0jUGJLbktMIJcuJPSaGo+17SAtAUm2v1eDnBfrRCe63L5cLCV/u+Xc6?=
 =?us-ascii?Q?gxorMr1vvvFGlE5c0n4aaJjThsiYW37qB0XGMSGBkN3S7UJvN9PhgB+Uwg44?=
 =?us-ascii?Q?az35ZGFye6kv3ig5dF5jNe8HeaMvQ98ybwlZdk4GmTG+7EVjhiUuYZiAnuyK?=
 =?us-ascii?Q?U6fh7YHaEVMYs7+SatBZmPgKl03uRm4vPvWs1F8q09KL7slZRF2HJ4vEP2Br?=
 =?us-ascii?Q?WnPBWoLVUwNbMzngBMwyCIVau7uZH32c63a+5fVHUnkqmLtEgb0BPwFTC7sq?=
 =?us-ascii?Q?nc5SRawlj3J1pqLw1mWW0B3dvH+5CBZ9v1QgcBvFWf/QioUjiEzJByvmmang?=
 =?us-ascii?Q?0p9kwufMLZmqeeT7DcoLTOYbl7eRaeFCPmZTnNtzYXCmzHYvxG5zWMuVMMLN?=
 =?us-ascii?Q?usuZ8tYZ3kBTEssk85y4rYeqPMi34mW84pYh0/36pzmxBmbHaR3+3OvrxkNe?=
 =?us-ascii?Q?+J3KLoatzrE+dTMhJu2f1nDjlW/aUp+D+RixL5/EmaQdx7dLEXekrX7Y+GHZ?=
 =?us-ascii?Q?6xlpYGWF7zqBDKm2dYnz1uGxLvbDBIx5DhKmDg1PiE75PNUwrOqQn/Zqe2TR?=
 =?us-ascii?Q?kkZQYmNmUDLm0Y8FpiUvnI4nyA7NuNEe6fhx8yr07Tf0Z2dOey26yjSc0P11?=
 =?us-ascii?Q?+wv3hqONgC4fARt9RmuY2S/ifOr50QnzHK3ReGqEh5Uxq2EiT81wbXkIRJJ3?=
 =?us-ascii?Q?MCuanX5bOfBypWvKePb0VdlPCUt+lHVLBE0KfIOOE9gDSnwcrbK2mA7TIifs?=
 =?us-ascii?Q?MVi+Ya0iOgBxzwsiViiwa1mchOhf4K0YTyVUWkUpCGHu3/mJlptktkreLoaS?=
 =?us-ascii?Q?8/q2uqRfpfXyaZ3gOxOxlFfkBspgHpQlE3UNSqcg84udPnRWetERAGo7U3wU?=
 =?us-ascii?Q?cvY7pNytIS5eyXgUX6rV4B448Z4crZesjkcNhfvHhiuIOXZqZy0g/q7MvM8z?=
 =?us-ascii?Q?gw39YwJ+ESWwQtQBPBbLKQGPc3q/6a5xO8+Q81zEKsjB7WUC6DkhhqwKQoz0?=
 =?us-ascii?Q?uGLOrMyjtMvH4z+CPI5cSqkqbHe/Wwm2sxHj?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:55:00.1245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9356a8-f715-4a49-7c11-08dddbaf81ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9612
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:55:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2000

Add board extension support variables where user can specify the
BOARD_ROOT variable for out-of-tree custom boards.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-co=
mmon.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-comm=
on.inc
index c1a4d47..3a8a4da 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
@@ -19,6 +19,11 @@ ZEPHYR_MAKE_OUTPUT ?=3D "\
 EXTRA_OECMAKE =3D "\
     -DZEPHYR_BASE=3D${ZEPHYR_BASE} \
     -DBOARD=3D${BOARD} \
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


