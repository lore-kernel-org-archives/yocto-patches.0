Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A653ECA0EDB
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:46:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.63])
 by mx.groups.io with SMTP id smtpd.web11.57129.1754941618306927054
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=CwBsQP2M;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.95.63, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFV6FNSDwyxqYjf2j4u1RNVEFRWdCB8w/OdAFJzg+71PxjZWgfu4CBrO4vC9U0itSS34pt3LEBV3DOnwKptU9qK90Np/G1//pjptujN/1Fl8/sEa4PkVlZIMwbP7OG8GlaRUyZaQlP+U4cxkvdDxKgUV9rqqjlTTbvKgoZp72avAskmdHHv8mITd1U4k6RycJ/zQ9qJQJymWFFFsrSoXyT6TcwsCyQFzxQaJErnqV5WVZ7TUcGiIk/vuFLCO8yaVFXtK4HhujHVWZYbfdKAA+kV3oHecbYexWsJO5daIN8QsQZ6wchD0Jhgl8bCm+TFy3ae6MT7PDFu4FSOiyCSzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR9pj7cigNr/qZGbPUp7Bzn1aD6Dmt5eJwLwILqqrzk=;
 b=zTb1RYhC/H6oCXHRK+/oimDEhkQ7xE8AJZFhpuZSBpI2UNrbde2QY9ebTGJU5peWnk5zkg8pt+veGBBTsLb2176JInxL+jf/98+wUHTbICMO6UrZaU5vI44bqdxgZdBizb4WKF1CYKAufhWBbm5L+MXbG8Nur2ezkVqVFF9xvA+jnQP2B+8dQD4q6RcPCWE4d++dLYg+Mc0vRzyk9cWznnajYVT4T/4A5xRbQ631obVJJ8q6jFJsg8016vl4RtCbP8I+1h9APyxVa5sDkkn/jsSoVBIOpnUrws2Q9JaGHTvoFTcg/eDkDT9i3KlU/XYb+0NFUYyYjB8Xu1pOY3mQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR9pj7cigNr/qZGbPUp7Bzn1aD6Dmt5eJwLwILqqrzk=;
 b=CwBsQP2MmUaYqbmH97cOfziVibWB9IFUV1nXaHBNI27I7cSUe9uqMM11kgA4bfRJB5YgXH4DAQjYUTW7o6BfoOL6UW1OP0QetaOU0x6ObsUvLDooRnavcCxobJ+sJGphmfAPfZZQ3o8XKbTbUFjGHNm2fL1JvqmXl6FS4YorAw0=
Received: from CH2PR17CA0026.namprd17.prod.outlook.com (2603:10b6:610:53::36)
 by CH1PPF989868826.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Mon, 11 Aug
 2025 19:46:56 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::b1) by CH2PR17CA0026.outlook.office365.com
 (2603:10b6:610:53::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 19:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:51 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:51 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 13/13] zephyr-kernel-common: Add Board extension support
Date: Mon, 11 Aug 2025 13:46:46 -0600
Message-ID: <20250811194646.3408854-14-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: 626f3266-6462-464c-d4dd-08ddd90fd41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dcgntM403Qgm2pumDj6m2kHJvy58F7sQCVEj5DImgzpX6D+mW/lflZlNN9Y2?=
 =?us-ascii?Q?88Sye8P8YOWtHuCGrgg3c03gMywp5u3BD5FZ6wyx/LYpw9MIu85tgkf9HIaX?=
 =?us-ascii?Q?wRX8Vh6W/SftblnwY06V5Iskx19aIEGlojxC5NOx1xwXGqgKh0JZfo3xrvjF?=
 =?us-ascii?Q?WwVHnbwNOxC70HJ5DHyA95N2Ik0ngbyEa0C07vdMFXarLzRnR0kFKPMRx0c5?=
 =?us-ascii?Q?3nb1q3Ct6CbcRUizjLuaMr93m1vuA1bylyl9OiBRZbPLoJVkA8B5udh1cGom?=
 =?us-ascii?Q?KjXmuxhT6I6lDJ6dMOGu5K00XwEG2bhsFiTLBEsNNqkP2FWKPDy2yhcQ/QNW?=
 =?us-ascii?Q?F60Kb79axKwqoNJrh6WNVKQ6qZ7zv7hCPsv4Bz5OyCrhrQRlUtP7Og+0r5cd?=
 =?us-ascii?Q?qjjio7pZFMNVF4hbuGaxD6wI0LAsRd4NKN45Lt3cjG0fJtqQ6FbGVZRYYbDY?=
 =?us-ascii?Q?BVJhmog4uCs57I76i0X7mWtNWiUf0djdnltSHbHcGECKTHn5qp4rOxUejc/9?=
 =?us-ascii?Q?rXi6JnXnaUbbtJ+MqCE1Gm4LUBasKcvB7Z07b/3sUkveANYCEGo3AKNPxXKz?=
 =?us-ascii?Q?WyZUuaJfOlKb36sOM1MUx7O2ouX1Vw0Q3Eb5trHhwOb65hSLdLlgiQBObu6I?=
 =?us-ascii?Q?UFEGEMy4JxRbUcyRQZ78fgXaFtFqHE7ypru+IXmQn26IxstFQ4e7qEuVEjum?=
 =?us-ascii?Q?zOEPwVkEZkcO0XRxoOJSyV7F348+bIw9ygnNrKBsK1THYqIBcATlAneeZjj3?=
 =?us-ascii?Q?1t9LyZEB3f8lM8323sIR44+pe0ErCUTvRLLZTddRhj5YL9JM5+Ne9HfQ5B91?=
 =?us-ascii?Q?Mo/yEH9w9Wcv/jftFprWCIYYRsfBgR321N5xah+BBvFDjAjIRJWL21qh7Ij4?=
 =?us-ascii?Q?krcNFj+Q50pqHKZsHT36tH4sKYXjv7IcluCCnQqysCy7AyjFnwu3xcBAFaRA?=
 =?us-ascii?Q?HPAfsQMc5V6nuFT84xRrEtIFj8ZfFMD0UdNzJfskts1Ch51C654lOButataN?=
 =?us-ascii?Q?9QI1uosEJgxckUnIIpIWqDdR9oM6hiTd2CxxZBgjEoCgGFX2j33Q4YPueDLb?=
 =?us-ascii?Q?NXl2phrEdz4OImOUGmMnLJe8/tf3jhXGqM7MUOOKLYloSgHDXsBhIwEhcNd7?=
 =?us-ascii?Q?wz1WLa/y80vmki3WrE4cjq0HuJT5HunKA+5a+5CkDs6mfD++sRBZkKDzwjGD?=
 =?us-ascii?Q?39yPq2SowG2gyBzlTJMsuWovhWyPe9jDE3vN3RwDqROh7NKPBsVcyETUAp++?=
 =?us-ascii?Q?8fTT7midvmPfnO8pEq3/aO69C5o14PZ42UL3ECeBCPtaW90nNM9tGmt8s9kN?=
 =?us-ascii?Q?RyeUM51q8e1LBJszCPR9LYDyMvOSCTHjK7EPqbZlBETke6955Kt8kxzWdWa9?=
 =?us-ascii?Q?rcLC9w4HFL127iGYXO8a4/gjMQKoOrbsOLgdLaR9nJCFnArbdTD9iQbzdfgx?=
 =?us-ascii?Q?he/CU+T7i4Cy/HxojUpJXhJQst7EWMWJHIaTBVMjiQXfQK45G8wIQHC+G6UB?=
 =?us-ascii?Q?UsCik24cGE5ZDfGur7REz4bXj3nFJC94NuT5?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:56.2533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 626f3266-6462-464c-d4dd-08ddd90fd41f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1953

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


