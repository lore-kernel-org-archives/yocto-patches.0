Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032EFC87FD2
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 14:59:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (NAM04-DM6-obe.outbound.protection.outlook.com [40.107.102.69])
 by mx.groups.io with SMTP id smtpd.web11.49942.1754924389935962046
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=G8JIATsv;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.102.69, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXv0FqyhNX8TfqtLYqnw3+IUjsIKtLK9vPLUxGqL/lNyouAnaFEkKuezc7wXvlbnO6QbP+ol8sSqGkcfQNS7kS+Rsz0cSMrkbPSf+1WIQ7JjbsRbCwBIXmtnaLbT9o9PNtIvZqDiJoA3rvjAMcCK3Dg7U2NH9gkPLs+FPNg/QYvfRzCAU0sZ4XrSkyJuuvy3vzFAtMEFCiGYii2A9YVNjOhv4JFydCl3KtsXY/utU7omJXCK6/LqIG4KBbexUr5yhGdSw+kdhlkEvFz96CXTMT0TNGIgYGi0G+jDbTOV8jlAUjwNBIYDzoPE2bZPVUSjWdfysDIMzNz6keAKxSRF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCJRxRRj9LPhEtniwOncZ/BlcT/pBhuu4y4kkbtB6l0=;
 b=bpZzMMWt+P2vqJHl+Gth4AXNg73ZysK59xuVfiHRH1/7+2ixYCwJCESuyv84hx5h0jP5hWhbPR5/T5LgrQPgLwml6X0pan1LH1+bkWtScRLA3Z5uSf5zLhvYfVi3UjrQu9dFZpraYlbojQr28bIGeaSQDL5rd8q2iFgGInEWg8K+mULrbxGPw8OpUXT4+eVa2FWcR6/LXmt0Cu2sN3ok8AI25udsZ0dH+voTza1+2jJ/MCo4ORHR2+14vHp4b/es1A4tiRhSeLiOM1epbz124rllrU/Hg+K3aGd0LNR748rZp+5MAv36climTxAp0FmAfNzLslVYLTA7ljvhQ95nNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCJRxRRj9LPhEtniwOncZ/BlcT/pBhuu4y4kkbtB6l0=;
 b=G8JIATsvemjOotBJHs4RA8NDGtorqGIPGSajLLCgrauXsMVlvbXd1Po3hbrobbb9uvG7iqvjiXajoL51BD2F//fvzSclpWlxRwQx5N5PHlRqT6p970MvhWzQRakcK5IOApdrCvsaUeQE6ptSigigwujlhi882P0MnluD0Hon8UE=
Received: from BLAPR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:36e::11)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:47 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::66) by BLAPR05CA0008.outlook.office365.com
 (2603:10b6:208:36e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:46 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:46 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 1/13] qemu-cortex-a9: Fix runqemu errors
Date: Mon, 11 Aug 2025 08:59:29 -0600
Message-ID: <20250811145941.2553838-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
References: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e8326f-b27d-4d9a-683c-08ddd8e7b704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LSRyyK1C3su/+tbJfLMXALEyIEUI04yESMGZzhaiMGSLMQRajsB0EDRWt6A2?=
 =?us-ascii?Q?9mf3pIZ+lOj+OlBVxRuD7oOtNBgCBr3UgzBufyp/7wPUSfLG7P8+qw9fqEUE?=
 =?us-ascii?Q?cNIJHKldJSnUcyGWU5UAW6HQrHYm/zCKv4RjNVmSFGtZjHafuloC1qZd2wSd?=
 =?us-ascii?Q?eJssYS9Y9BZHGYgAcLR5ylG1zh2yMAsA3fcpo1XhH2d/c3EpQmwmZVL/bQNp?=
 =?us-ascii?Q?CWgUuQAl1VnxPuWjw3WzbkDR66zQG+qfDFDGSO8eFI3dqh5yoyhsv59XxldG?=
 =?us-ascii?Q?q4RfdXmfH9StTO4+dqdk+H9VJitTLq3khsuFRrF1vuHZyG2Sw7o9PKYjhz62?=
 =?us-ascii?Q?/DJdW8yFa9ASoRPk2VTmTr1qvl1WA0y5UGz6H4BFmGZhOSVJikr/IJ+2hwL2?=
 =?us-ascii?Q?de8/M+sJKiN4qLiMUovMyQPYeoBPQtF8mgdMgVMlk4x5RsvIgZW1WER8z9Xh?=
 =?us-ascii?Q?I1KotifxFPaEznDKn9GERP/Nx6EdBx00SbyrviVuaxHXeAh6MwlASOoJepiI?=
 =?us-ascii?Q?RJ1SG9c35UaTJGVl1RS9zuTYrDPewSK+02dQNayCdqW6K+B33vNOP6K6e0Nl?=
 =?us-ascii?Q?+I5r+oUSm99T0eAXPFN/OGPbOA+HAUetupoQQu3Iy8NMTDWa80DVMgzpsd8t?=
 =?us-ascii?Q?6E+WRuxlpmIrQ3TKP1Oq7qojD3b1ZmI+/W+V5go2YeUwaXSSFQ5ycAOLSf90?=
 =?us-ascii?Q?gWQjmYtk4P+QzyM+QuoS7Hr+4FBQo531jvtQfrTz7DBXX0Ug8D+un1DT9iyW?=
 =?us-ascii?Q?EGSnkKOpmZ6cuNoidLwQRrExBBd97X5NyxJkYS4rvqu2KpNqsp5zu0vDaUNI?=
 =?us-ascii?Q?PcOiWi3DOl4FrS0nfIvY2de5UjG3oPoh+QknGevXkAGlopsSfFcjdQlzY5/K?=
 =?us-ascii?Q?3WjRK73amd0bVVzxA5CZAA9+BfCOufQparWc5OmBiLfMkoWaYJtf6esw5vXk?=
 =?us-ascii?Q?lvoMF69WoweUdzIQwrUV4HSE4v6JhSvylIc3FX3chVC7vZHIJ3zf5vgdq51E?=
 =?us-ascii?Q?hVaAymqNsr0bg2iXdXSPLeDB0jlNu3gXrvyEU/25cEklJEubpfrLIerQh2K9?=
 =?us-ascii?Q?g9GuABKmzd9UEtrWQ8JKoHeYqjdI9JM0Wq9BOdqDcIRvFgbtzCfcxnoVec0o?=
 =?us-ascii?Q?83oGgl7M4fdtju7b9unXW3wJMK2yNUMCT1u/rBo/cZKxp/uOULbYp21GilQb?=
 =?us-ascii?Q?GpfU2sbJnOFKLNOci5DsWr8v5kb3P0rnUllt1CNPIRLgjPjU2jJZwU9qz4Vj?=
 =?us-ascii?Q?211SwwMQUNGjOZluIBXlLAVrUc7cqdctsWwWm3TtXoNzc+qHZJfUpjVadJfK?=
 =?us-ascii?Q?xLxjDuVT2yLTQMKGQ032uFx9GHb8DXwIz5ODEdogspvIR19wf5p3mJRD4wN/?=
 =?us-ascii?Q?/EJRMVFWSstu4QFDgcX67Mlf8NC8a57QpGtLJtag/ypEtSqpINvkV5XW9uAS?=
 =?us-ascii?Q?5mzL40dzglwJ8J01aWbjRpvJpJx+TSlo6ckbmdB1c46+agpm8cHJ8GhvXQXt?=
 =?us-ascii?Q?8QK3Erpxe7WmgS/h0dS/5IK1Nfyo9jg+1/Cw?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:47.5599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e8326f-b27d-4d9a-683c-08ddd8e7b704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 14:59:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1929

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


