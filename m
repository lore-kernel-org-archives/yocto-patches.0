Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B8CA0EEC
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:55:07 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.80])
 by mx.groups.io with SMTP id smtpd.web11.4399.1755230098935892353
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:54:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Dj4Mrqvg;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.95.80, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dymomRXkEsBXL2E7xTgoc2O9Odicnf3dGk1qulnigWkQ/lUzt10l3fUgujhYTNOLBZsV3pFqm2j57TF0tqAnEWVq0jM0ZSlX+8bMsAaV0yHIPzUm7mkkJyZBuA8PaOonTzaNeWhdaxyz6JNylv5ldb0cdqE6rKbuGd68MHRPxrPKdJlFx2MOOJEiccBtWIWThviJywGmFmWEWaXqPQ+qz/3cuexbVJ4f26WuGku8sh55Q3MY07Wd491Vas1mZnHwN8rieV2kGO0l1NQ4C1PwvIAo2FNdtEYsfghLGBBdVBH03XTeIok6gC3j/q6bbqgpidl239ZDddgAX+kRnXNWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqTa4Jvssd45KmnJWWehx+FGiEcypMSPiGBw+vjHYJ8=;
 b=n3/vUDYGEbVmnq8gQX0zKzeE352Hb3Z8TByuHSWNDIELlhblTkCJMBRNzMOqJCIEz0GsaQZ5eGh/EddutO5ks6pe3doBteNtMIeAKQ0dLOirGyzEf85+HbQap/pYFtxnefFzuRXlWU6jFq+oRa0qrNKzw4BSLyqiADNBrjBeCT2c5qYHibdos5IT1/lHd8EEIqoFqiSkA86RG1BWea80xYQMMsknj8Mwug0SHo4CTWy1D+0xp5WduvpNGoUVptzpp0mRijlASSs4SFzITwa595QOS1i//8WzuotV1Nw4hih7FuvcWTvpzVkYt9uv+KMp6dk8dRAilwZhMI60KVkBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqTa4Jvssd45KmnJWWehx+FGiEcypMSPiGBw+vjHYJ8=;
 b=Dj4Mrqvg6Faaf64aYJG+W2iH87kE5aKNJRTaDN/jSiu8rr4D2maqTx9vZRsJOp5D8Act9zvL/LS2KfGZTjaFfLlz00J1oDR8x0VcXCsGM2XNXPhjJTg7MW9Qdn7qTxtXDHoqXDuoE6+vHE1bz0pBSG/uugjtDwC0oRSVZFgWQp0=
Received: from SJ0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:a03:3a1::20)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 03:54:53 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::29) by SJ0PR03CA0375.outlook.office365.com
 (2603:10b6:a03:3a1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:54:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 14 Aug
 2025 20:54:50 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:50 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 02/12] qemu-cortex-a9: Fix runqemu errors
Date: Thu, 14 Aug 2025 21:54:39 -0600
Message-ID: <20250815035449.2816001-3-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f0f34c-1d7c-4b77-b69b-08dddbaf7ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ik0IhWvrgE8jAuSEbbd3k55C1dSsGYNPuFUZGYiW6mP+KiEZ9Avh3hjX/yP5?=
 =?us-ascii?Q?SCWkHmdYtCyElfMBXa54xP36bASnYpDT2dZKaPp/zvz8uKiRw+aqUyCTlqVB?=
 =?us-ascii?Q?L007iPsRNGGp40NMkS+zMYDRpKc4WOU84xe0pLghpZ2uuNufZTzedwMVzs+B?=
 =?us-ascii?Q?jqRsWHpMCRMimF0iUIJ9FcjCWZfUvr+Y6EyUxK4goFXVf4DNxRK2MYSgZx8t?=
 =?us-ascii?Q?QcosnUmsySlg7ZyYiGTWwQ48sGKjSwyXySijMAyObcqzu38cKyliIz1LwVgj?=
 =?us-ascii?Q?Tf/bEPNNnDUrMGGrcDXFV7nRibMTqEo4oK+cuO3VcEUZ5WODMmUjaEaF9Itk?=
 =?us-ascii?Q?iNp6ed1St9yCXSDZbFrCSeasY/EH8uy/pEqLP1kdfBBNEZb/iR3/8sNmpNLj?=
 =?us-ascii?Q?U/+3qAV/RG6oSh7pKKXVoGkSTZTKL1hVXG1phf+nE6S88a2ZLWtd9gkWjMC7?=
 =?us-ascii?Q?TxDwSgdKAPyPIFiKe2Rr3kHG7pv+a79G35UyQB+ksSUqSwpa0Q8sYjIsG5dg?=
 =?us-ascii?Q?sCvfLgL9QB85W63fHuYBJzHNf6I4zkjuhoKaF+Ru8USCWxSIst6upq36ynrt?=
 =?us-ascii?Q?7P4yEB866o1fxiwGGFeJr+sAYQ+FXhCX47nGR1LzQy1edo+0VGTQYrZ79N09?=
 =?us-ascii?Q?e61eeJJFUu/gLpGbjzKPFbLP5zLGVL7Ut67Q3UgGgOEBJ6qqawaNcCotQFNM?=
 =?us-ascii?Q?y8dOK6j4ZvlBKfd2jaeutrtFaFaVpdHBQNwHY4GZOdsWQa0PEYxp/zduvYtO?=
 =?us-ascii?Q?jcI40q7xr2KA+HEv/JyD+iuRK7Ntq5g+E/+WmEBbc5Ni5IO4bsS9ZCYuVgXn?=
 =?us-ascii?Q?fl0Wj2+G3mphNKZVRnvGTpxtg9GFMyhdDkosmcA5q71/t3i8FJt9DtZbm99o?=
 =?us-ascii?Q?iVMqwWb3QOfhuVISMBTyTNT0E8GSWACbIIW5lUE4nZHPfkY8QSiGdLfhuRVb?=
 =?us-ascii?Q?yh0uzkSTSqwlcEy+A0ZorY927g3TESp/GZJ2cJpdTxh6vjC9rg82xJw+hqiq?=
 =?us-ascii?Q?gnyJac4+XHcE7nu6ZV3byYgqhFzGLbYI9yXnXu8ycMP6KmooR/UEb4Ws9kma?=
 =?us-ascii?Q?obe7xM6BS+I9kHt0JdINt5x78ORjvq+8J+NVDtaAxz8cEdqHDZy8JEP9J4nl?=
 =?us-ascii?Q?wZ8N3qWW93EPbM72uUuAlYC5McPV5x47Zgt0buTsJpEnMtAceaBX+j3vE0TJ?=
 =?us-ascii?Q?DZ0S7w1Pp4Bf73ft5hBPzeJIblak/dA5LuA1mdEzYm/fW0nT6EK7MGBL0com?=
 =?us-ascii?Q?7Qnsj1q2c9MouAHu7rgA1V/rsNQFhxeuGF7i7Hd+G6Wqqeaf4nn07U8TDDBH?=
 =?us-ascii?Q?Onuk7VQCRI4g6va8Uem9gTxaSI2ckJiGG56xfFNDSCe7hGSkhJGQcm/HhRVy?=
 =?us-ascii?Q?OZBDYk9Q39JnVjTue0hTec716rmO2aL7Vh2Xh/SvxoxmH7/kG06s0GKJkC6e?=
 =?us-ascii?Q?tw+gv2+y9IAYhO2mnH+UW3wo6U99uz0lXtux+XzKnruK2zQmIDsm90krLKem?=
 =?us-ascii?Q?HV0iZhQcKj1lblpl/llqOz9fNxiFKoZmNlVM?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:54:53.2705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f0f34c-1d7c-4b77-b69b-08dddbaf7ddf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:55:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1992

Fix below runqemu errors for qemu-cortex-a9 machine.

runqemu - ERROR - Failed to run qemu: qemu-system-arm: -device virtio-rng-p=
ci,rng=3Drng0: No 'PCI' bus found for device 'virtio-rng-pci'

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf b/meta-zephyr=
-bsp/conf/machine/qemu-cortex-a9.conf
index 4ce6e56..e0f6ade 100644
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


