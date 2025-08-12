Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3A8C87FCB
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.50])
 by mx.groups.io with SMTP id smtpd.web11.80876.1755020516330497537
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:41:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=XZ3rfRVG;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.50, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5hOKMXN3b07KZKn/4qGlskvXUCsWfm27WmGtKFCPMFTDyRtHozigATx4jSxbpcyoOj0Iv4psWxk95GTEYzZQPAfns+bscr/ZYQUAx267c1iowyNkh5YAbDb1/GPmB4gFdPllPb0oyOcF7+MzBncmsXfp6uS3086AXQf3Vvw7HPuJqgENaPsGnwY/hbMh29IeSog8bV7HKQGYFrS8CL2aXqa1c9xbQxBvxW3sRL2mScY1bk0y947lL/uErs2AoIwOT3lQ8BvgW2YHzB0VSQ4TB6QtQB5Q98kBL3KO3P0BB1Yiz52pjqoYsTzTzUiYBtJoB9qFAFumKhfNmeBLyoH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCJRxRRj9LPhEtniwOncZ/BlcT/pBhuu4y4kkbtB6l0=;
 b=IFlrvMvpjm8whPrSBAPovbqgsU+n6siIZlJLDJ04IcKgiCiQKWodjKs1zVsk9zXyqRHKc4Ps3+c+lffdIPc0QIYDS+5D+APJyLIAa7pbDLZ+6XDAbsuMpwXsEsugea81H8hX4MMxrbQO3tWYwMhNHOIszFcjixpDFUwF7xss6A4igLzpo915djg7lgrzgqQoKyC05OMs2ABzAiuULE/4qxmBN6Noz1wYyU5Imp6U7EplX/CAZin6BPAa7O0uBoc1MjAiihQNQizlcKszfF3kLYwJ8G/6f8JIuJjgsMR0s4Amnjxv2h48OAdOdjYsrTNtYObNUsyW9msIQe5wfZJ4Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCJRxRRj9LPhEtniwOncZ/BlcT/pBhuu4y4kkbtB6l0=;
 b=XZ3rfRVGOsKLju+BThN2m+notwRj30PmRZQAzwqg5/a8eTd4/wy7mxf9X44W6fdEUtzAsX433pF8T+mbggwCTeZXxZKUu8GqTZbzf/PwlctXPpw+85vP9OW4VALMpyAP7IPIf41rOPfHPunwfIUdNRSuqtcpDzY/rMFhxQJWt6s=
Received: from SA9PR13CA0100.namprd13.prod.outlook.com (2603:10b6:806:24::15)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Tue, 12 Aug
 2025 17:41:54 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::5f) by SA9PR13CA0100.outlook.office365.com
 (2603:10b6:806:24::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 17:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 17:41:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:53 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:52 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v5 1/12] qemu-cortex-a9: Fix runqemu errors
Date: Tue, 12 Aug 2025 11:41:36 -0600
Message-ID: <20250812174147.130972-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af5dce6-d0fc-472e-621f-08ddd9c786a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?GLMky2T3B7ub1XceWc9JZmhX3pDF1K04To9+wheGtFNx2KgPo1jziKXvLieB?=
 =?us-ascii?Q?b0lx+gT9IVafAT19uw0I8L5YN9CBKbULf995VEum58U0Sq8Hs/LG3SUXbHXX?=
 =?us-ascii?Q?765xEdEooincuNwqGucSqAxY6N4ZKKp7GJ8iyUMySJ5Fm6512KjTGfqOgJR1?=
 =?us-ascii?Q?KZtyZluWOtDM5heaSIcu3X+zP/Sacwq0qbKBijMh3nVNhYfZmis29kn9/LjA?=
 =?us-ascii?Q?bE5elGDeeoqZS7aEZ7uEKMYunuDu/peItYl724YZCkCKj6gZxKcu+fc/bh00?=
 =?us-ascii?Q?l+N7h15knf02otMIFMpRGl59ZoBF3OeZ2zFGl/ukbgNQXVWCIrS45fvGh1yZ?=
 =?us-ascii?Q?lukjXL2M3EEhgHhvsX5cRjcU6A5g4Mk8trqxXor1d8VDwFflTMKv1Em5eIOP?=
 =?us-ascii?Q?Ukbwju8BA+JdAsQ7rze+fm7KrtQn/LGYPk0VM3Fku0cYaTtZ7zMmDDvA7sZv?=
 =?us-ascii?Q?Wzr5znWsJ6PoxCVgeAHZGT7cA/6KD0p28/JKkKzoya+1yvaZXd0KrUKWiROb?=
 =?us-ascii?Q?U8OeWizMMNPavKmnORPS93f+MOtN3tmCucSPIspsQ9nzygrL3RJksLgycuZL?=
 =?us-ascii?Q?va2IbAznWivQAGWjcrPISwFrsU673J1jzX6C3oDEPbSNKbdPw5VofRWrB3Hp?=
 =?us-ascii?Q?NqOkxAG3+f9KdkCbliqUrq+IkBvFT+UA5gkp+lJ42oDl8hn/mC0CZqDwjSLF?=
 =?us-ascii?Q?mfkQBYOlNFWgUWdLZrnhWB0ZuVHZ6tIvs0WdW9uGmrJu/axUDK70WJbPxY7r?=
 =?us-ascii?Q?1OBF3SRtOr22Puut2sMnCGhkfy88LLeWmu6SrOa79qX37yfGZsvyjUEEOqg2?=
 =?us-ascii?Q?eIxrhfQgW4RIebnwpvIcp5VXfi7CBOkoTMCVt3Ki9Oo/Vy9DjtRnVMrjpAhY?=
 =?us-ascii?Q?YFBJYWlIfNoKz7gfnFyBWKQpiNpcjqZpLHn0VShvcmtmKwZ8QQpxIeaDKVlk?=
 =?us-ascii?Q?f+GOZLIG7ylVqpiHVzywmgksJ0OFf4cgIuo01QbfRasCFQJzX7ws7DEnP13P?=
 =?us-ascii?Q?46Zr58P9Y81zCHd20AMIVf9mYnSt9RGba5K2+jDXIHuK6GcOqEc6uZ6O+4tW?=
 =?us-ascii?Q?BIX2z/yG/uY6rp6c2E8TC5b2okD+FCRJv1x6sZeqoGdbi4zZjCapoRJCZR58?=
 =?us-ascii?Q?f7fOorQsWTaAWoh7K3Itn5wwX8FoeAzbKIu0W39HOStsiGXLtsVhZKeRE0ul?=
 =?us-ascii?Q?O/Ah7UN/KxdR2jbamytWGbQgDfPBaQTYsQGajVbTrAuOEPdyj5uVYtSPRiqQ?=
 =?us-ascii?Q?wDToxrr5d16XJULYF1Um9u20GBBtR3Dm7eW4kTj6HAIqLFfUjhVB3+ItTe7T?=
 =?us-ascii?Q?w8UKInJeX26auvjHkN6oRcosrwRj51pz13b0aL5XBQB2I+qSCz+XzVD8EkTQ?=
 =?us-ascii?Q?qKCVXsfMz2bZ8LT5sPl4cgB1pagi/9Rt/2wHThrwNRYzgCUlchPdaB/xDjfS?=
 =?us-ascii?Q?PR0tzk76lLIL43I7CHiczgBHsro3/ssXGNLPDfkdbFmlrpZaTOWmTLyxrXyD?=
 =?us-ascii?Q?03g4qLa5srQdWdl+JgdP1f81f2muTojtaw1W?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:53.6788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af5dce6-d0fc-472e-621f-08ddd9c786a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1961

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


