Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACFDC87FDA
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.65])
 by mx.groups.io with SMTP id smtpd.web11.36469.1754869169789960786
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Q0frlq97;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.65, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ0AFXfUTw6w0C7h3NpeSbZ+jU3aHNz7+pGf6NUqp/02XqcaTcNx91qW2UXDGDVsCwoc2zd0q/LZm19hXiVilY9uUxoye38LLvRLEcm1vGwaTNcfLPvKdS0pURA2n/5cxb8WTjo4fRL+kXmz2W4Kfx1MVNEyauIUsn1G6EVdcRAE06RI7XJaX/b9TqpGgYy/+LwwGvehmKQTq1KHJ+5HFnJ5aRKYbFXDdWpPqXqfzV4w5updLXGmRSrvOsRuoM3dxtNRCOZHgtzNKtBGSsYXFHxd8q9+NmzW65VhSlZl6IY2E18b9h/6Q2cZGIQpAU898EnTP9YE46Pu+72XaBE6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=WBec4wG8qCtCKPa8ngfXcwwB0nw+NDqTVaYL25iNvTENatLbRaU3hWRDLIo/oL00/Q+wccM4LCmv7pjIumdGuhbJG2gxRsioXtQJ0Gd6EzOaIovtCdGIy9rXmyotP0llKKdsSptoESYVAY0vRUDsTU6pEiB1bRD5dXxyGigsMb0+HCePN7xuvPoQ1vW3dhurWIZ3NDHlIRLjAjpS104r71wt8uDPskoMiIow3ZKokyGt/DZq1dn4nYDigNutyyzPQ78lJvwH6nmiSnUpi0QX/zRTmGpPGAcUi0msI2FBLGx171dzKM6kbPkgYxCGSjOMvBkP8NquIwRHpy7kjdhbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=Q0frlq97GrkYvwueHQU/KbyGkyqhxtbFByEAXzi3qSMEwMgSUBT4TszoGw4GPwTOOUMklHfPOjazRYdhyH1unQHW6QDc9b6nEUKMOHzUcxsfXsYURrG7W0obpdgcwpuqytVzQD/mis1PRpUj1eMJlYsUoJZ1nXVBzPNYOKPg2C8=
Received: from BY5PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:180::38)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Sun, 10 Aug
 2025 23:39:23 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::d9) by BY5PR13CA0025.outlook.office365.com
 (2603:10b6:a03:180::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Sun,
 10 Aug 2025 23:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:19 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:18 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 7/12] zephyr-qemuboot: Use image artifact file in qemuimage
Date: Sun, 10 Aug 2025 17:39:06 -0600
Message-ID: <20250810233911.1259884-8-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 90952c8a-aabe-47c6-0881-08ddd867228a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mdRrA9Gip45XE5PWLHd97t3cPgf2n9CR5zPQx/REInHnJtB8HSGbQSyb5XGx?=
 =?us-ascii?Q?Bb+kLVsS+ytmQEoYvOqVFzVKEVGHlU1ymFTx0tHrL9zG//oGHgMfdglRatfM?=
 =?us-ascii?Q?vaoSXFCtZvR1aMAdnr01y609DJIqrIL3YdqRZDIlbZDSLj0xUj36qJmArG1a?=
 =?us-ascii?Q?yDVvTLY1V8MPKpeI3FLg7Aivrd6WLfRt1jahcmRW0U/5k70mnwZSIXgkL1ls?=
 =?us-ascii?Q?AkHdbIzdMkaGioLq0uxX/QBrSUoqRNM4W/d2vbUhj3/2waTeL+hio8jlOfI1?=
 =?us-ascii?Q?I2/cJHQ43u7Z2u5e/0sAyFYjoSTWMPTWaijWEOr/IQ/0NQj+i1VSNlCWFGmQ?=
 =?us-ascii?Q?D8aSTCF43gzsCprAC3RrkFZhPnZj1VU0uqu6W6BAbfJrhM5aYNXEuli9+PgC?=
 =?us-ascii?Q?SiRH9kyhKNLgjinBq1BiRNZwujxAL+faIRJLd9A6Qxdw+YWZviErJNMjdf49?=
 =?us-ascii?Q?PVtdmSQi8ApAmKpRUyGITIZWFjXqAMHydipWzd3ENrYuZFPcAIdlv7om2fbS?=
 =?us-ascii?Q?zOpCn2Ec/EsHMsq/W+uPCMOjZFE5zautJd+XiZRmBjHlPB5nAgqr5aR7rH2q?=
 =?us-ascii?Q?4VYg28xoTbACp8IbfLfxydkq+HLWNXZfbouArM5ZSNnywkQLK/dgD5AB3+Rx?=
 =?us-ascii?Q?tlOaxxt0jnZiflosLv51xogfb+ctY2rq1x2XMYjGXp2GJrLwvXwKS5t8ZKB9?=
 =?us-ascii?Q?ADglFTJiFHXyjiiDURWWY3JvHnzNBy6G/HTiTUY6c1kpeY8WNmltmrUUfUjh?=
 =?us-ascii?Q?SxdP5b6rt88EdyXMy5xls8Hbu/b18R0Ui2+S34w0386Undt60Ikd0uSV0Dg+?=
 =?us-ascii?Q?upoftHbz8Sw+iEoZHc9SP+oajk7Qj5Lkup9T09ZxQGt3cnTOE7GhmQXkZLTR?=
 =?us-ascii?Q?2kmZeS4NxbTSBEoYKwp+hdMtkcirttfS5uUDXTbpgKrDGW2fxyhOy504NmVJ?=
 =?us-ascii?Q?C375JFkxlTJhoHxe2Bor0Y2wvrXyC5ANBXmUnBE6Pkd48G75kYVA3CnSLcoH?=
 =?us-ascii?Q?Mpw4ppYKREv8kviZ5q/deUaDTZ4BAgB9+eJl0OyicaTtS3duSO1iiD3ab4A1?=
 =?us-ascii?Q?1szW8wEZIDjyQaBFRqQ9O8T5ljf5tadNVW9PSeVgGhuYZH8jAzhbNNziXTpk?=
 =?us-ascii?Q?YGzzF93gk/chQoDF+UlfZnG5SN4JfsVXxwGEbjogs0oUMA3Z6NTCsi+UXQ+B?=
 =?us-ascii?Q?AzaAQhZfW14Q1qk3KXCNjAa+Yi+gf2jqhbFQg9b2MZ1LI/Q9SxprK2HKSy3/?=
 =?us-ascii?Q?v3QDbhlYhWDdE5Ci/pCLEWzKJcdKkQZjt9L1qLSFBQVQjcIO76FPLe+ATtEp?=
 =?us-ascii?Q?59tKnPYtSTsewXCC2N/8JPFQlKPXhNsOdAoxKXJav8cGtOFGep2ijZ6LjZAt?=
 =?us-ascii?Q?m6ond0iK9Ru/Apk5BZGf6FiEG8Eww1B4ExQMJXGTst4B2fMOVEMzOXWG1GNd?=
 =?us-ascii?Q?18HWTluy18MIsGTQ4XA3sB/PwYSvxvIPvp8bdKoDau3XTLoIPnyoHaSfL4v1?=
 =?us-ascii?Q?teZ5y8pYApbm7dbl8R4HvUKC+rqv/BVEbI2w?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:22.7838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90952c8a-aabe-47c6-0881-08ddd867228a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1919

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


