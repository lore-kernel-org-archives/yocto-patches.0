Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0533CA0EE3
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.73])
 by mx.groups.io with SMTP id smtpd.web10.81601.1755020524890203598
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:42:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=yFE4zqD8;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.236.73, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGMqf+rvsGR0AsU3tj53bZk87RE6xeqaU2g4Xu/XfxbIJocMTLXLdBXR1I82b0nM/0g/wimkNzhCQGCutZ2UyeWHC4QmFrjwXHW6RW7D3OrxCNR5dxF3eEiykGnIrhhL/wq6/WOhttR/u8I6XX3ad0usgI4+ZsE8m6T5VJsgRAXadgDLTMdaaLyR2CjXdUNVZYqgl5gg8e4WHUBYMdHDABMZh7iZOPYoxe+YH146lXVb0rxJ0fjG6UllSTPA71gefEhNi+OCvxnsPm+/WIw13L4dY2cJEI9TH77+H0DlUzfbegoipSOlkx3iHYv5qcfiUoq0OAZJrphFZx+oIdXA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=UJVZMJCzerTWQ/enewcpsDGTfJamH3kh9ifxf3VJXeSaYAYlJnjTunBKiYDeleGULM50YJ3s+lWjbZ0c75u4TPURWTeOaA09M+o7VM7rx2C3fXzcAEIXvXgQXbHVIpvL6EEESh2k4CyHQ8KM12CYhuQyD56ANxstFFkcfoaePDoHs8JIe0Apb44nQekJdbnS4nmg5bS0OL2S/5tLN2arevSdnBmgCxcxvGFRNqL4z7hc1ssNGIdydYssb/S9xzqzMdP6XcWpIkHCXGpy0QETCIXzNGpHAgBdVfEc/tKDX1xr+SYj7YFxoqTK/URCsH8MaJ3SGcA55DH9Z8FtVdw1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=yFE4zqD8SafZ7C1KTP8InYEdxlmJ/pBuIJQ/Y4RnZmrOKNMfVk0QHUPW5R34O2pY/7Zrfsmj40DhSqoLqTTUIHVeh7ZfIBTJv56k0Rtc37Zc2nI35NyBkkcrX0F5kQp56BrlT6YlyWSrSstERLYnXBYv9+PD6LxlNCd1qszIM24=
Received: from CH0PR04CA0097.namprd04.prod.outlook.com (2603:10b6:610:75::12)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 17:41:58 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::91) by CH0PR04CA0097.outlook.office365.com
 (2603:10b6:610:75::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 17:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 17:41:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:54 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:54 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v5 6/12] zephyr-qemuboot: Use image artifact file in qemuimage
Date: Tue, 12 Aug 2025 11:41:41 -0600
Message-ID: <20250812174147.130972-7-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 961c3628-6959-4ee4-0b99-08ddd9c78971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Nwn9/XO7qvIB1g/Yiyq+Fo6dmSZOXEOqNBBqpswlc/3oDe/T8hKU6BmFJvAg?=
 =?us-ascii?Q?4taC2PfqSZUpOXmlLZQC9TFPgToj4aXXHUdEXZMw7H+EPP/Nj2+0YuWN0zON?=
 =?us-ascii?Q?8Mc4gGeSBpXMG1EaVBR2NTn/fJQTkCOuizNlVBoLwi5LDyFhLYIM7DMl2fel?=
 =?us-ascii?Q?XntMuQFq8AbjWScOK3xlZtmHQv5+ALPXbo+dFuRbK4uCPluedpWf+6dxiFXT?=
 =?us-ascii?Q?QX4V5NZDHJZCWRYPDeWLBXtWbdDKDPwP1Q4cILQ1JeHabZG+7bWOlhCMem0p?=
 =?us-ascii?Q?+A8NGJtutwUBpCnAPhV/1TJxqKH4VbVpMZCbuMRifadKvhYNikWq2e6db68z?=
 =?us-ascii?Q?9Ml+Nm/iZ9tNFrp3FW7Oe2MbMrOvoV/W5mg+oWnvLBX1kRgJu2haKRcjuewT?=
 =?us-ascii?Q?fFvxGuftRqebdrhaxIu8LCX/KMHr6R7ZqUnQ3gkBem5ezedKN7dAVwKa/prC?=
 =?us-ascii?Q?0mX1Bi4OVwmyGYhbC0vPQRJWJYDP6uCHwYzEC+PSXBxzWz5EyxZh72WZJAKf?=
 =?us-ascii?Q?QN6Z/hlLPWiWHKT8sx+KQ6iV60KLZtDqaSDZC7PACIGsVaDxXty+ym1NBhTa?=
 =?us-ascii?Q?5s5Lo5Q0/3uzNW2i7RKGDyIcmD8ZBZHyht0pmMKvi2Q7Z/tGPx4mqR8Nmsx9?=
 =?us-ascii?Q?I4yvmH2nkgVdhWv/yjAqi8vZmxHmSwuDjs0ugS5S7k3bEUGGMuVr1V4wkNyo?=
 =?us-ascii?Q?Zzw1pC2DoShjbk5T1g9hYYSFZce8Gsn/LcJf8s90Z2eSyONA/nBWRehdhbXO?=
 =?us-ascii?Q?o6/u/kqllQkRLYLPi7UhEzIGD3D605hZUifuYPftkqGrw69nwbW/lh1J3FHj?=
 =?us-ascii?Q?Oa/CGLkwCHEB+F4jXv1LiNVfwniuD7IT1gjy6f5K3AzLgChkpleJS23U8TF+?=
 =?us-ascii?Q?4nI+fh7LW0++WGBR9aktfhwPp7wFT1ge9uCQRpWrcmLmRDUHsw5cEZSgFBpz?=
 =?us-ascii?Q?6ow+us6j3udIG/LtSArsV/4wS7EZUxLtqd17BTGjapp+0nEJdwrJHx8VuWmU?=
 =?us-ascii?Q?oMLXeN1EI+o6DAIrjGWXwqftRChuYs9trRlYLMKBLYi+TTXkEFdMM9U+Hl/g?=
 =?us-ascii?Q?eCDcdYr8oh0aMWhcWjQiI7E6LDDZNlkU4KcaDpXp3E68ZsQSOow/HmapHOZk?=
 =?us-ascii?Q?+iXSgbd6UnVom0SHjQ9HC+hIjJeSe/l+8oRJu44dVgAslO/VrmByp5njQ+bt?=
 =?us-ascii?Q?KX34wdGRIGz65UN17NLtU2syauwdtC3eGIi98UVgwj1J1KZtABm/ulghmxee?=
 =?us-ascii?Q?UUVjI/LhhpurRhsZf20a1h7SviI98Q6Y+GYEJAx9TUd55pyCTx1ZZtrBq92t?=
 =?us-ascii?Q?Nahu9sTyUFt7UPQVEtOVco/GDf1Y3eTFs1D6OGrbs4XqFcz3tC64yECzCgMh?=
 =?us-ascii?Q?R3Zifqzud4GAEYigoKBDz+IZnNe3Mei4qDJrAOY3ov285FK1V9GF8H2r+DTJ?=
 =?us-ascii?Q?Z9X523aYwVr02EXc8cvycg4FG9C2rhr7fx8K2C/kYhNdBoNSHFrl+lissuZn?=
 =?us-ascii?Q?UlzXLULrqUVRy6Rx7CFteenWhnfj/5bzL0DZ?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:58.3547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 961c3628-6959-4ee4-0b99-08ddd9c78971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1973

Use image artifacts output file in qemuimage link.

Before:
zephyr-helloworld-image-{MACHINE}.elf -> zephyr-helloworld.elf

After:
zephyr-helloworld-image-{MACHINE}.elf -> zephyr-helloworld-{MACHINE}-{DATET=
IME}.elf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass b/meta=
-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
index b45e6f6..ab0a281 100644
--- a/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
+++ b/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
@@ -1,6 +1,8 @@
 inherit qemuboot
=20
-KERNEL_IMAGETYPE =3D "${PN}.elf"
+ZEPHYR_IMAGE_BASE_NAME ?=3D "${PN}-${MACHINE}${IMAGE_VERSION_SUFFIX}"
+
+KERNEL_IMAGETYPE =3D "${ZEPHYR_IMAGE_BASE_NAME}.elf"
 QB_DEFAULT_FSTYPE =3D "elf"
 QB_NETWORK_DEVICE =3D "none"
 QB_NET =3D "none"
@@ -27,7 +29,7 @@ python bootconf_clean() {
 python do_bootconf_write() {
     bb.build.exec_func("do_write_qemuboot_conf", d)
=20
-    qemuimage =3D "%s/%s.elf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.get=
Var('PN', True))
+    qemuimage =3D "%s/%s.elf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.get=
Var('ZEPHYR_IMAGE_BASE_NAME', True))
     qemuimage_link =3D d.getVar('QEMU_IMAGE_LINK', True)
     if os.path.lexists(qemuimage_link):
         os.remove(qemuimage_link)
--=20
2.34.1


