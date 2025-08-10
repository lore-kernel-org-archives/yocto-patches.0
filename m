Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDF1CA0ECD
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.87])
 by mx.groups.io with SMTP id smtpd.web11.36464.1754869164840982919
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=R9sFDS6N;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.87, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqHg2pbI9STWCOhTSszWLgmveC19ezXdOa1DbqAIe5y40A8wGPba8QoMJ8s36BXm/VjpUEL9TrhsQtlLZB5gdz0tdF5Sb5zDdClWrSxibE7HmOZ4zC1e4FAN1UAXfrihIsG3CuTnxQrc4esIjh1vooh4pXoxB94EexpLEMFiQVrnI0g/YGD0iEDapM6oWiMzrT54k9HsmObUyf5J009X36SaZ9pYo46xqRBedE01ilXr9tzDzHxddBzIV2eIGOJI9IqujmzC+w30lbxXzruKnzV3Cd+foQQ96sHmatFDP0f5DiDupfvQj9ebWHhFIEUoTinoFMwxIyDriZAB5GUK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCJRxRRj9LPhEtniwOncZ/BlcT/pBhuu4y4kkbtB6l0=;
 b=pEE90cWLttHT7lRGz0BARwIMhaEq/Oe0XF1pYwp9r66ndQBv754HBjA24D39gBq9wOX0fNFelQmYnlMjCcfGCJEw+iQ0BjKjewA0+GRdjznP94/kjKc6bXxXMHWFIiKEsI/nLvxuZHsEWYC2Di9mkr/BdD8hSepJnuX32BSsZHSCM3/mVbRCruzBB6oZSG0vdKUdF/CKyfP7VGgQPmzsO72cHDIfBwTYXtIJGEXd/fAtx4bhR2gs206eYw3smalE7DfKtSdsn00M/k1OT1cOVcLmlF8M8x5BUcHX9+dao7ab3mdqfvsAtaebL9tPysjKXza6tmkkhFU6FHBsiV3pog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCJRxRRj9LPhEtniwOncZ/BlcT/pBhuu4y4kkbtB6l0=;
 b=R9sFDS6NaPZa80IZLXZKppOLJQkMIUCgN1f0xqryZGG1CdRcgcKVqLc3sbLgLbPgBp7oDwlUF7xV3qMmJLdUdx90HKVO7URi/vQokDJu/6tQq1MP5XJy1dzhYeTggk0MBlYR319ng6buB83YK1M3teN//aheUQxIVm4VDeq3R/s=
Received: from BY5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:a03:180::41)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sun, 10 Aug
 2025 23:39:18 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::f7) by BY5PR13CA0028.outlook.office365.com
 (2603:10b6:a03:180::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Sun,
 10 Aug 2025 23:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:16 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:16 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 1/12] qemu-cortex-a9: Fix runqemu errors
Date: Sun, 10 Aug 2025 17:39:00 -0600
Message-ID: <20250810233911.1259884-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
References: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c91ba82-171b-47f1-1fe2-08ddd8671f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?viruDJ+Isx7/Z/hWtVBcKLQspwxXXGxH01YNDvznIJ15yjj6EGaBxFHfyuEj?=
 =?us-ascii?Q?wCzpLT/T0g7DOzUctYJr/aABU8ZOV3pIEBQgOedthzdlZy5sqTz1Yz+SK2Kt?=
 =?us-ascii?Q?q2mi8WkwFamcsEkpy7F6bJUr3qbrlb/P2Uo1gc5LrdJgCddoGJRt1uVm14No?=
 =?us-ascii?Q?ch8NaygIC3AbHxBdxmz2mPhPtNFWKZxNs8Sb2+N7PsGMoHiJqLIboAUeA6oM?=
 =?us-ascii?Q?cDGg/ITrqaiDp1bzgx/9ACNoFpIuu2RNbGqe/TefIV94cBUxLsiycJXlc/1z?=
 =?us-ascii?Q?nzbIJkjm8O8fEzsN3ppb/d2sSRr0LFOmGdsYz+1s+1HdtrniMxCIVsrMLJMR?=
 =?us-ascii?Q?4DzCXmPqkmSlFOjYTw2A7II7NInJIzOD1S+EJXrcxXpVpkBtEy9O8wQwdPpg?=
 =?us-ascii?Q?MlElYQGIvUhcWbNXaVMNCXXhs1froFchRz/JkDjEA1/JFd72C9D9RF626mYM?=
 =?us-ascii?Q?LXLQQWtKOuEC71x/zB6S9JbncDT7vOQV4b0cNr64KGMg+W5rrrRqRbYgO5tj?=
 =?us-ascii?Q?qNlyQYQUqS1tQmDlSwk9IFO9efrADvDWMcoUgjWw6N+Kg7gPZZvoCNykWV16?=
 =?us-ascii?Q?n+08DP+dM3XFLbsycdLn8Hr0sC1e43bKTrme5E4B5B8F2eo8x+RX79YA+Hzp?=
 =?us-ascii?Q?FXhzFTn++L5kVdOHMeotZDdHX+MQg8u9aZNB+RCptUhTKE7TGqHzO8aXgZf+?=
 =?us-ascii?Q?WnfOFPUS8GIeQF20zryYSMW129kEYfNpabNd6vz37OnOp+MZpuGjRVJa3li6?=
 =?us-ascii?Q?TFOquDVTLU+zVz5+r5lgqXUAtIVb44b15BFKPMAg5e/ueXW5UAHw57p21Gw7?=
 =?us-ascii?Q?lTqqGdQDXefJNOgZT/HFwSt1gEipCSYQi67WE4LbKR9XcukA3KsGKT9///Ow?=
 =?us-ascii?Q?LkAXAa/xIn1eeeR5gmHPnUDuHsgmPVInHCRcgmIxpQeHLV7O9mFMj8hyy31m?=
 =?us-ascii?Q?ss456Yofmws1nN9uJ2T+lvncXQVYBTyKAI0+lr5Jtml65o6pLxTxjP6rzkJL?=
 =?us-ascii?Q?Y1EQx/KdwZJB+2g02vNT02LotgbJANxUa/RDR49ZxGpz2dcUrYT6NEVeXOo1?=
 =?us-ascii?Q?ZQaL4jpyKaKrNwNY9EXJF9G7+md5Y/fHGUn9ym/R7wfM8INFiBR/QUnNDcfZ?=
 =?us-ascii?Q?SvvaOEL+rg0EqbDHnH6p+D7hi2M7AFh/PM/l4so1/UG7aQ2DqtmkX7GP6OTt?=
 =?us-ascii?Q?Ixwzz5EcOVcLWxL87WDHxgHggfvs8iLEcgBrecHbGecLihPD9IA05gs2G8E/?=
 =?us-ascii?Q?Q5gY00r3zKKfWwmWoRv3ZqBqIq5n6GWa7cCrMT+Xm/ojS+BcU/M93pIEFC+j?=
 =?us-ascii?Q?q5wl1/H6V0M3Oulx4bT3tqvr0sQGY5QU5dXfOhA1E+OyJpwpYDO+cxImCkap?=
 =?us-ascii?Q?eLGVbqhnWr1kF3611Kkllmogpcui3T7D+r9GcK6d4gun5OmLeU6E1lP2Rl7s?=
 =?us-ascii?Q?cBS3wGbpPADYPAOxkZKZ94pfPpq/45pm4nwVRfU+PXqntOQsgqQrSXYm+4HV?=
 =?us-ascii?Q?eMu8AVFK1O2ODcOTfhUCbxk4fRZ2AmH/pIqI?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:17.6208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c91ba82-171b-47f1-1fe2-08ddd8671f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1911

Fix below runqemu errors for qemu-cortex-a9 machine.

runqemu - ERROR - Failed to run qemu: qemu-system-arm: -device virtio-rng-p=
ci,rng=3Drng0: No 'PCI' bus found for device 'virtio-rng-pci'

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf b/meta-zephyr=
-bsp/conf/machine/qemu-cortex-a9.conf
index 9dfee42..e1b026f 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
@@ -14,6 +14,7 @@ QB_MACHINE =3D "-machine xilinx-zynq-a9"
 QB_CPU =3D "-cpu cortex-a9"
 QB_GRAPHICS =3D "-nographic -vga none"
 QB_OPT_APPEND =3D "-icount shift=3D3,align=3Doff,sleep=3Doff -rtc clock=3D=
vm"
+QB_RNG =3D ""
=20
 # Zephyr RTOS settings
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
--=20
2.34.1


