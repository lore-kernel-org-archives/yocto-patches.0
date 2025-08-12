Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD4CCA0EE1
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.87])
 by mx.groups.io with SMTP id smtpd.web10.81600.1755020524242383297
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:42:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=X3SHPIfn;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.93.87, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uW1NdDZJ+28Vq7Hwgjl6OuxHIZxceJiu9Jhzu7O8u2n3pTZ9doaxqACBEScNJCKQz58SBrBFOJ9VNgQuS2O70YJoERSrYXu3HslyDtFMzhZJATZv3S8+xzENqZgqIe1kJuTUb+eHr4tmnG9eOINkwAEkvIM+37e9P2NtwhYaOBtbwMUHU3Nmf+ezQSAh3/KHUfFtQL/W4FhnKHYobaUzLzSI60RfAQzGoavDEpj4aTK85IWx5xSLJ6P7i0TngyJchNdO6moCfOszZK/i5FAscDlaNTaJiR7bnH4n7z1wS/DuPSE0KzRsrTcTHMEdiXKmmKchFeiSYWim1dbkNK5PiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR9pj7cigNr/qZGbPUp7Bzn1aD6Dmt5eJwLwILqqrzk=;
 b=qBYhMGEFoX3wiMFGh178HMoXpXbDZGRLvBFksSIxi2vJyOfBj57EGH5NcOITtfF3g4eVxI31T4YfSxdhzmhWdvNfPdxa5qKQx+SGgIeKnbSA2kdBpjMKZcTFPCVzOtVRpHmGs/QepsNSXXhtQfF3c2v9HkOSNiWiR07zjYKg0U74bc3SVo2593uJ7lMBX+yc1fp/wxGwVXNKpjvXSzjdW/6X8YWXOEWitb053ladP4IvHHKOvbqzncIFh2BViUM4XRk3JsEdcbytYTn4kJzYEDieqIWo2BeG2Av7OnhRNqKu5+dyst3zxQ/hTv0mpQYthxmCJIihwU3KUgGm1ss3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR9pj7cigNr/qZGbPUp7Bzn1aD6Dmt5eJwLwILqqrzk=;
 b=X3SHPIfnAHl6boXfDtYP/AXAjt/JZl74mTYAw/AXWUcXGe5pf3WglPMRHZJHCDM2OoDWJDj+NUkmmaHveZovIbEelsXUIvdw5zNu2TnsT/bIEAlylIAtLJGAhl/0BHUCVB9coxoveR4LEiJbJOhaKCFA8PIN3ixN1eL2zRehTsY=
Received: from SA9PR13CA0110.namprd13.prod.outlook.com (2603:10b6:806:24::25)
 by DS2PR12MB9637.namprd12.prod.outlook.com (2603:10b6:8:27b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 17:42:00 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::bc) by SA9PR13CA0110.outlook.office365.com
 (2603:10b6:806:24::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 17:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 17:41:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:57 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:56 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v5 12/12] zephyr-kernel-common: Add Board extension support
Date: Tue, 12 Aug 2025 11:41:47 -0600
Message-ID: <20250812174147.130972-13-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DS2PR12MB9637:EE_
X-MS-Office365-Filtering-Correlation-Id: 4585eb53-d27c-4cf7-eaaa-08ddd9c78925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PIWBF5F5zlLl3dcb9mH1wwprxLRW5SVZ2zwsU5rvEAkcAFJOh52BIeNr594a?=
 =?us-ascii?Q?CxFYz5GwF0mL7uLS29m+5ZUNNnN6nbqI5T3S1otibHE8VJtneYK/FdEWbnsT?=
 =?us-ascii?Q?sST//EWLvwszWB2PHmJSS2Azf8Gin7oeh0dzqNmv6Q6G/ntQoFvswTa1zJvA?=
 =?us-ascii?Q?4ZpI48UuwGrfVGYzMbpFrlMcPQYrQ5ZENjohmsV8qodUqYhkfWTF4anvJOiz?=
 =?us-ascii?Q?P81f0ZCVJrMj8eQkiGsfaxOg+6etylUUgDwQGY9U5RDFl+fcZ0/A2+H6kQWv?=
 =?us-ascii?Q?bvAaJrRBG0K410K5QVpgSyM8G82n8FifFr4mQs1UvcBoalSy6Q9ROa2YOGxJ?=
 =?us-ascii?Q?jzrsdv7V4kdf9MuMmHSjc7PVHbFoQA0ncfkRgpVVh86yq6WLfCiHpAVzTSOV?=
 =?us-ascii?Q?YEpV4y0VbxNBjPN0YT5IrKyxZpN4i9sov69kePoZQOGHNWOTEW4dimCt3O+s?=
 =?us-ascii?Q?cqKwxw5kOql8a+ESxZkvC9PWe5DW3sRBUQop/BFLB92SNVeWEPzoWG4Anl7f?=
 =?us-ascii?Q?Kslt774y4r0txGeKY1bw5RjRINJLJNXVibekA8s2NT6t4CcQrmxWdBtCDPsE?=
 =?us-ascii?Q?Iupt7DOzMK7Ql5uPYgHAbJAlZlvc1ny1dRQCXE3oIvxcZUj3Ku/l/7RWrPfI?=
 =?us-ascii?Q?W5LIkQGolTl5NCdUDrjdftfn9m7enFzSXN+Y3pUimkI9luhajpVgdJQAu4Ld?=
 =?us-ascii?Q?L5DhvnO5bzZNU2SDh75B7So/Yj0CV1/FVZsg4Z/2Ko/UxEtG2P5/+oFtM4Te?=
 =?us-ascii?Q?WI7FyXYzrheBvpDpsPo8+D+zalHTl76DrBdRLiP9lJ+k7yPk0aXCeeXJuofx?=
 =?us-ascii?Q?Bk2UL8ZuglRYwtQ7wnqwQa4JW6uT/zuOsS1qBAzZ2IDvC7hBhTKD7nlXcM2R?=
 =?us-ascii?Q?1pqQnxc1+sMgmFw6qcVqajGosxbAVdzxP3idTT5Sak/Y77ulAy40zsxOuS9r?=
 =?us-ascii?Q?YD4u661FSiqMNy4LeKLmRvlW3mTdghk38BTA2HrCRUgmcTBioW5wwoJr5V82?=
 =?us-ascii?Q?tkxFYpmQ5TH2jrCHvKcR9ch5ksUrgtGZ3rQQ7K6i7dyfiEY+VUY3c+40Nu/W?=
 =?us-ascii?Q?cfgxHnyvjzds6KxVkn1BT1SLfx8FkAeaK0Rqaicst6jwaAcBzTYpPIs43hJY?=
 =?us-ascii?Q?77BIU8jBfakUvTfpGNUIKa6ZfOQLkZ9qH4YOnLXOLZL7d4vJjnpPCmJJKv6v?=
 =?us-ascii?Q?G0XvN1TDxL9lRbaooLmotDYT3t+61T40t0qLp+0ITDNTP0fzsO4cmSHsnzBH?=
 =?us-ascii?Q?vuXkafg9jsrMnK9BTeVBUz3bjHmNTedSvvWMIlIGot4LS5/jf808kTV42s1U?=
 =?us-ascii?Q?NQ4MJ6aAa5GJw2J7JJFOAhgsOx+3ouIrKqSg1IZhvaHlkklEXE3u0hA6vuLW?=
 =?us-ascii?Q?HI3vXO/e5Mfv7qVr5HH1q67q9fVnVMSwOUyb1A5X/H1i/JW+nd7Q9Mkm9QaA?=
 =?us-ascii?Q?TZwGQcwy9fr4UGhJbB3mVd1iKtUD5s6v+aj90f2MOvr0YudFg/x845POQi4E?=
 =?us-ascii?Q?4rCMksSDrM0HtmcfqhLdzOwJdv/1sRNmdwh3?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:57.8509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4585eb53-d27c-4cf7-eaaa-08ddd9c78925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9637
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1972

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


