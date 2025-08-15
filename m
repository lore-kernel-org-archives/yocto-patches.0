Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E172CA0EE9
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:55:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.80])
 by mx.groups.io with SMTP id smtpd.web10.4396.1755230100367871566
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:55:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=NLsX/+sg;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.236.80, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvEM/7t+FQtxoONZsADk7vwUlJqFxCbgwfT1cU47X9jeZVKOe/g9oCCAfQJqHeX9u5k+N5F/9zkSN6k+sRHbvLCSd614J+CWG5ZGk1NnONwiRQz/R5nncd/O180by8CO8yvRA4ZbdhyPWVYkKohr5tvWKm5TzhjVMeGgtkn/A+qepfPFW4Np9mC0B739+b/QJwyMx/vOELfNR0CN5FK2PfYHx8t8oZ4oOz7nqW74QLfoUdcbRCvTHFHlokGVC0hyL+4yerf9RaRhOgLjoj8UAWPFgRLnx9PUXidGyLGvb+OjA41+DJJViHu2U/Z6rJf133vapo42+UUeb/H4Wnuo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=pCXTZs9n1iaSUB3jbu7No0obFgHlBY2Zw6+EqJOuQp4JXXMw3+7GlT0zvnkKI4DAsRdq87wYrmCQFVX2Hn5VRJ0YPlOtaXbbOY3tN+GymuhFALMGQluMTBfqcZ5+WNMbB1zfbUIvCgwIn6rCRpzog37GSTAuJDJIiRYdr9sGteV/gcFxfWvV1dwF603gpmyussxY83LE7zAMG9nQd/i/Vpdzmu6xY15b1vSbFwEibuorDJLekB8hjvSX4AZNsCa+6a9m4BtFLZUo0LQdbkKLeOCW6s29+77powHmg9y9Msl8/qs6km2XyGHvWIRmRddjLeJxyYpfH4yOfskmWYuFWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=NLsX/+sgMtmvgXVT4bUiPiQplNO5gGGrMEBr6tpeqkER4aBO/yKWOPlQlar1ZDx7WSop7IEEJLX2dpFJpCoQxuU+azvOPRNxc3fTUncPFUH8sNdkLxnTEzUhehzJJnfUq21UavcIMv1iH2txP7dpePtK8nY9EvhbNGoiRITSw8c=
Received: from SJ0PR03CA0380.namprd03.prod.outlook.com (2603:10b6:a03:3a1::25)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 03:54:55 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::c0) by SJ0PR03CA0380.outlook.office365.com
 (2603:10b6:a03:3a1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:54:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 14 Aug
 2025 20:54:52 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:52 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 07/12] zephyr-qemuboot: Use image artifact file in qemuimage
Date: Thu, 14 Aug 2025 21:54:44 -0600
Message-ID: <20250815035449.2816001-8-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca4c346-eac7-48f9-9467-08dddbaf7f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YzREl0ebP/jKNdNOSZswq5VFODCh4l2S2sP0XfJIauQQ0FKOff1IO0g2qypO?=
 =?us-ascii?Q?vgupZoF3LI1OVZWuwQB8Vvs61eCEJA93qoJfiqk1eDZ3Xoq4eCMSnAcG9sdD?=
 =?us-ascii?Q?8IWsmrWVCR7uIzVjB3sfx5bm0LIRsotEFX25PwrTN2jA9NH1RoSdivsN9XvV?=
 =?us-ascii?Q?M932i2CLFLEbLGsi6jf6Ncz7L28ziQ4zSGGBQ9KEhWSyXIR0xcl8iTQ/mEMz?=
 =?us-ascii?Q?Ma1VMQk3iRc20wdnwyr0O8gN0sF44FzBV/Da6y0n5P2UpPscxf7+UzDCZ2TC?=
 =?us-ascii?Q?V//mos8gje3m10WOcLlO9AFFRCQwJg1dS4ChYbjM1AWJztWItZCfy+i6qgpN?=
 =?us-ascii?Q?C1n7IM30EQ75KrR14T1zPay/YyHCCN8Tgjynb53CqxIFNasvH3s5aL6VB1U6?=
 =?us-ascii?Q?nqR5iQeW8+IaVzqnGPu+OS7DpHO1WAzqvkbisnzxGF60dVKLAznaLhNbJBpo?=
 =?us-ascii?Q?l5G7BQSxX82D+WC4wdDdE9O/ZUm0qDIwzDUy4tAJ5d+IwZMQxrVb6bWi9zNG?=
 =?us-ascii?Q?fY+VuFeAYiu9lssHmt6a6mf4u0vcylHcUWa94/bTAzmkAwZCegFYIcyhcyOv?=
 =?us-ascii?Q?0zAgcbf3hat2yxIN8fmhYcj87xFfg0saYV60E1RwPUMvlXf3fMZaRiW4iWIv?=
 =?us-ascii?Q?xQoQP21U3OEzN2DvWJVDyt/4escKkO6TwM52DgnsCAULK2MsPqa1V9vYFyVA?=
 =?us-ascii?Q?bzot/2Gr4jEAwwl4DgQjxK4RT3V4ct465NboboZ9bcTvHKHoR8DfyAyINUIy?=
 =?us-ascii?Q?WcgPoNCvtKREgN+GMOXuIT6COOQG6sUIEzZbWVfMY6p75m/kGUtQUSVpqdtz?=
 =?us-ascii?Q?kl96AMUBDJCj4KZTM1w4nsbeXq/Y32sObzlyhvFud8zhalwbjoL9b6GJQ08h?=
 =?us-ascii?Q?KVrUDnPmrQ4YP47xCS0eP2zEm7YCAuSQTBX17HiPv126gwF69Y4pbAHEJcXL?=
 =?us-ascii?Q?mg8CTv9YX4FvpZvmH2lXqQhMxOdapBz9MiEuGnbeaxDvzTQTtqbFBuvVfD1+?=
 =?us-ascii?Q?oCFpfKfFO+ThXE3JqW3+QNvCcruu4JyzPdSY7g2ZG1Ww5nIWL9xbmfn5/ZSB?=
 =?us-ascii?Q?AvyBHyNVvX+1HbhELAZiKd915XbkNyXWgZmPEMb4F1KS3o7CoqoPW1go96ip?=
 =?us-ascii?Q?KBEqeK8wpEweK2dj/kWHd7Q6+FQkRXYwNL6jtn6dhFzNJgl9B1zXKVukRNE7?=
 =?us-ascii?Q?/7H+DdcX29giGxrOvPur5aBMTnjA7uJ90wA4TbiflcKRT0QTkGPLNMeKWtBF?=
 =?us-ascii?Q?LHWHJZVV2wPWH/Pq/QKzbGR902b8+boZw7yGFz+MyeqUEYNii/FIezlLs4xh?=
 =?us-ascii?Q?oxj8S90Ji7vQCUhOH3PTDafntIZe6724E8AWUNwTo6LRA8CG6nWhzyXLr4G4?=
 =?us-ascii?Q?YRymeKv3Xb0cHEfx0heBNxBCQRvdHLgCrvG5eXTtPzmxPB8wDrWB3KBYDolR?=
 =?us-ascii?Q?vPwLpjmFUWmWAxqFAjiZu+y0ljEer578ZfhpS/SjjsavJqSMID8ZXNOyDwKa?=
 =?us-ascii?Q?6ZMP3DBTQDELW4PO2lHkh84U0rFEw7Uf7GTU?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:54:55.5049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca4c346-eac7-48f9-9467-08dddbaf7f34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:55:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1996

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


