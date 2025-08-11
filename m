Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57A7CA0EC4
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:46:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (NAM04-DM6-obe.outbound.protection.outlook.com [40.107.102.49])
 by mx.groups.io with SMTP id smtpd.web11.57122.1754941611060721552
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Ok1tcW/z;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.102.49, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlH4SKXz2lnVlOSH8e+XGrZ25pr1LuT/NOlCndyA7WtrZGDbFofn6kW6xw+V/SVr9eZqHWAN8qTx/DGBltHz+OKor/hy1HHICmcOtE4uDTq04g20KWXX0KU2MY/CB0q+JnhGdG01LUa8GUjmubh2TxD/fmFhxUIAkUWxwE6spVqm0hGj8HOX7DqYYyG6djzJTXieY/z4GrtI8hu8pNpzmvVkumupZM4+Gugk1kMkAVCrOXlsS5emqDPD6EUaJG03SqZ+N8NCuc17E8BYUhizfkJIANsyANhcwP1yIsBXkQa0JKoTIXc2X1noPpdYOTTF21V8iRNO0ErxCbsw5TCPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCJRxRRj9LPhEtniwOncZ/BlcT/pBhuu4y4kkbtB6l0=;
 b=VjXOAzf0NVsLlSxkD6Lr7WIYpPoMbymuUxTD4dynU88QUnS8dNd1f2ScMW/Mx/nyb4oLeXQxBzTJagcp+wqhUP5+P1Widnl/eFCGvhTxIFNTq20xEHBOeInlKn0BH8ecR+edR+6iN2xLfUFJpSMUpSONjrY+/zzHOjXLcOYMhUXtLAZk6Pu2+BhHI34MhgUINE/pt9nFNg5qhk++LEKtekLLxul04YwqjCMNaPML7sSPXTpDda2HW1q+NuDrQe5wbzLlaLuMwQOjkIwhrOpSv8bv4tn6PtiJcAO4wca4GCvP2UkFftUuIrCt1IUpydD/7AdQePAwk7hNiX1Jh5ANyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCJRxRRj9LPhEtniwOncZ/BlcT/pBhuu4y4kkbtB6l0=;
 b=Ok1tcW/zp19jNHQ9uUoj2hj8g3rc8/nu/vK/yUXo/YpjEPXippRNjqdWuTsyvpFqWowAQMQw8qqwofocsY1xdkKCUS8z+/fDD3BJ9kcr6Gfx03qcZ2qjibC3EJZlFtBsDInpCcweCg+uwpGWUubgWhDrTqatL1WmqITLSezjjs4=
Received: from CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 11 Aug
 2025 19:46:48 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::ce) by CH2PR17CA0010.outlook.office365.com
 (2603:10b6:610:53::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 19:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:47 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:47 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 1/13] qemu-cortex-a9: Fix runqemu errors
Date: Mon, 11 Aug 2025 13:46:34 -0600
Message-ID: <20250811194646.3408854-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a27007a-fa89-4244-18b8-08ddd90fcf77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mn6B+QhGgEdRVVPKSVu7/pGMY5xGtotrMgsnirj0rJV+41kRK0jHGuQTA1PU?=
 =?us-ascii?Q?iQvLErRHuD7L4JvoLfF5zO0xcT4Z1PyVBCTuIwurAfNj6tMEIjnNMCMSgTvC?=
 =?us-ascii?Q?Wj6a0EJwyfZUGZMhx9YpXYX7WkzMg8/HlI2Nrp+w8slCHHFuntdRFdsFCc6X?=
 =?us-ascii?Q?PB96wdMJFGuBOsfT+mMXyvtX2l78L+NcdqSA3xVhWfoFRBQD1zh4SCPzhri7?=
 =?us-ascii?Q?iE3sL+/n5VGmtYtUIQrIperoecuMaflHjnIZutt7oFvrru41InQTMF642PLH?=
 =?us-ascii?Q?rKVKbASNoXPVC4UCHbMdGlK8rGJXKOyzBXINFELYenkX/DxQ7iakzhdBkcUS?=
 =?us-ascii?Q?AAeYHrJkZLEllaBjWziVOQCyBKI4teQQe1UjtRAv2YKeiOHOcJOTM+uJgVH2?=
 =?us-ascii?Q?p8wgySIgsafpodv9kV2pYPG+1HoVa36E3KnxA+raZtLAVwocx6VDk0NeDyXt?=
 =?us-ascii?Q?biX6EJKNO7WUSTI++b+Uwk0Yz4CbvTHDS503NeCKHAv1rD92gnuP+BWtbxeT?=
 =?us-ascii?Q?g8xA/oeWlNCDnKcPE8cPRWxirL/6izZB4iayJZB2o+tgvPLGpFuWEpPArXpk?=
 =?us-ascii?Q?OuEaeyogxlaQ6n5eEVWvi5McJ+FyVlZ819iXvXvhUQJwDpo0HcWYNSP6gk6u?=
 =?us-ascii?Q?b2gKFBVkIDZg1oe4rNcfotzJGIlE4al8qODB7+jkRhiaO6eF3qdmMIbx2H7y?=
 =?us-ascii?Q?6sQsHsw5nd76/5NpIh2RO3vJYQoBtiKEV+CjLKlPy9w1Mg4Bfg4sQDEmZfLY?=
 =?us-ascii?Q?/4NcYOvxDRpW9FxGXSym8uTDf6V0CmNhaXpLrJ8m5OS+fO9vsrVkS/53aP9r?=
 =?us-ascii?Q?ygHslrO7E6uh2RkHh+QKNkEmFLuAQnIqVnfj0qo2zd9D0ObQZo1M/EujWQLH?=
 =?us-ascii?Q?zpkq7RrIda2whmzZinzTXc0lI6NlgDKHCWnl6UGd+sfuxAsUvx11Fp1pT4A7?=
 =?us-ascii?Q?6LZ9+CSb1UCRraEgrWDEmswc3XK8MYRDpK3H2NhA0TxAgfPps0IEGQ7C7bKv?=
 =?us-ascii?Q?xHqaCeA4ZOgzPJnrkc7sdwTbTNle1llBJZXZvrRFJYa0I0uKEAh9aRBK3brJ?=
 =?us-ascii?Q?tBqAD+9VKUbilN5fFcpWoN9Af1bULkcwqZjqgYF2kDKiyIPkffkYn0tKevBK?=
 =?us-ascii?Q?PkoGD6ROkLlnUYPDiR8YifGGY43i1du9+lfbgkQJmtnScwhlrzDje77+XgDy?=
 =?us-ascii?Q?gwKJvKXFnXPdX1w9lW6NPnWkJdVd0S0UeVeMn2RD6UXELKODPI9wCHcWTOOR?=
 =?us-ascii?Q?GxLC26HcHYRKJ5Ch++0X1aQd72LM6Rb8cPFHu4DZ/wtKUgETIMIMNb2vHd/h?=
 =?us-ascii?Q?K4edD7Qwi5pOYKn/8csyBOEJ+e8cQ3JoZndJBUs62owhk3BoU/JthRfFjuJR?=
 =?us-ascii?Q?tsYG6iDft2oniPFpFqrrm/2jC6fBaRYxetvqEWIxxJ1Pp0bx8BhdDm8cSbIl?=
 =?us-ascii?Q?l0yZcBX4VUlGEiH4E2Ek6DRMzVTW4b2Qcg1X7Nytw1jdNzIRq5uOp1XzEk+E?=
 =?us-ascii?Q?i410OgR9puOok1RNG2dcp+z2F2tNpubapi8U?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:48.4364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a27007a-fa89-4244-18b8-08ddd90fcf77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1943

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


