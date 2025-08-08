Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3004CCA0EC2
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 17:58:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.58])
 by mx.groups.io with SMTP id smtpd.web10.28858.1754675919128899770
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 10:58:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=tlGhMv69;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.58, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGXpD9CnC186XmntZM+ZFUsaIEIMHfJkE486P204VI27podS7OBY6dtfMYQdFad+2/JGH0v+zeGqLzx+lJTAxUWFcrOYQ0hxaGt4ypuynSJZPAzypmLxW7LPWz5GQU/Sy5IxIetLXtnc2sWMrKpP3QIfD77C70MAXK6JAFsiP8e/eSAqD08/7RBitEBWP/BtkXFfsWRq52H8TUUb63wKr8I8HQX7H86qPJbPuzyb2VsnWDz66LBeIkPGsIC4GmU/q+DyfZLbv1KJ9fkyMCo7CQnRTFOsKVkvREbEeToXN0kAuEtTwbE2Wxh8QURpPVZ4dN/3r9Fuvt+Tw0LDWTqRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uylULhiudQM6RJTw/nWlUooCKIzBjQXhGb+pZGg6oIQ=;
 b=ejhKmHR50Xjzkk8P40DHZrUpVvxYXextlofMSmNwOmkz1IhGqi1GD9mofffrJBOVXj77z9iXr2bol5iN12YDBdYeddOCCZVSE5cg2Y3FnMgQD3zlwyh7F+UVYKUK1ZdQJD0NHeneV0p+LDdRqHNrUKDsx/RGrz9vk56rDagPFY/1BY4CRcWNMJH9JzVrN2Lydtku+JFDdoWpH/Z9YkTMdoVyhckPDSgGnrjiunajtIl4xFH6PB4rBVFPF8NFF1SrgvyROIR9R7RkO8hoyz2Q/J14uxPCuy5CcI/GFZtxXHFNSW/byxTe1i94rEIK8VOPUErzS8GGawjUIRV6DgCN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uylULhiudQM6RJTw/nWlUooCKIzBjQXhGb+pZGg6oIQ=;
 b=tlGhMv69oXhtSIfhtp3F56Pc4aDwCBiikFrIm0+s84bxquukmT+5c+mfrQ4rnhQoD3i6N5XodKqXs/wk8IfxwoWkim7WGUqXPrc8d9HC3Oe0tAUKgGbgzAJcidrV2Cimjfp9CY9MLsRjeJ6dZAMb0YJG+CyRsfDLkYTVF0jy1Os=
Received: from BYAPR07CA0091.namprd07.prod.outlook.com (2603:10b6:a03:12b::32)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 8 Aug
 2025 17:58:36 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::df) by BYAPR07CA0091.outlook.office365.com
 (2603:10b6:a03:12b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 17:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 17:58:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:32 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Aug 2025 12:58:32 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH 6/9] zephyr-qemuboot: Use image artifact file in qemuimage
Date: Fri, 8 Aug 2025 11:58:26 -0600
Message-ID: <20250808175829.3830489-7-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
References: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: b197bfd8-6870-4619-2508-08ddd6a532d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hhZ15pkOKbnHD5QmU3D0Oru3lB7Aw+mrHjIis/eO5Vmsb2+0Ez3GnBQABdzW?=
 =?us-ascii?Q?QI23GQg7xxBdIT7lrFJD6w8gdkKt6sWApNgHsLSbakUnqdmuWUh/iGTZmD8D?=
 =?us-ascii?Q?3yQjLj7vOdkHUYmqrHpDgT1IFQBo8RlC0m9moYDyohxPqHJfc5s5Eit2Dx98?=
 =?us-ascii?Q?3pHZVdNz/Vyf2LQzFomb5GlNtNYqk9GAPhanb3eU5Xj1uriujEv6YTQYR52u?=
 =?us-ascii?Q?41hoQGsRU+FtBW1hivmdZ+BaLz+I2/Z9c1a+qC8XvjtEOyQ2p5VtKkD70GfG?=
 =?us-ascii?Q?hrcCwRtS8/Ayvt7Y/N4n+TOs6eQhFwpNg6NDyUv+y7J9MKOrl6bpbto3OSj7?=
 =?us-ascii?Q?AaUzPDsRPGMWRRvV2i4WoTqL/qZB92DZXEqWmxMpiTAt3nTevuxUVrlH4gJf?=
 =?us-ascii?Q?X+EKQdPRqcM2y8sXAufj+7a2ZCxnAMcB4eNVQBL6j1mNVkGmlAvy1EXSGerc?=
 =?us-ascii?Q?eHD6ymvwW/4LpgQwFs0t7AWzD7WXtH56Q6WEYkjJJzSt/Wcd2NhjGG+kin1k?=
 =?us-ascii?Q?V5/vgkk4lwzkQlE5CS9Tb8oqQjk4AHmm4IIjbbAczGlP7PuNaOj5spUs6ERk?=
 =?us-ascii?Q?eal0MFCXNveMdHTitR3W4AvvvJhW3ZChYqwcAHuVqRSWhfhUbWmV3qKk0zHE?=
 =?us-ascii?Q?EnQpi9FK+s088zJ/87nB5/nxqMKMBMSG0N+TKYiR6D20NMocZaT7tNOSIbCN?=
 =?us-ascii?Q?LRaVR0IKidrhgjoy0pgRv9P1GXuUVD7inSL9FRruUk23h6/bu+95zLiQX6tq?=
 =?us-ascii?Q?QIrbu9FX/u/wqCa4HB1OiQixRB6uRPVpHluHCn799/t82arJVkD82Nkdtneh?=
 =?us-ascii?Q?d2X+kvC4/3ukq6PnrKSBgIy+NqW2IlXFB3oFixzUKmxY0Q4SIEwNzCSdN+7Z?=
 =?us-ascii?Q?9HvYnjqxDN32QJy8Zc22ehYLyo+qSguxkIT07afHUywsbxMScqsT65EVmps+?=
 =?us-ascii?Q?Bx1EfexgX9ZN1dlNdraOKV+Rbjw4Zue+ibjI7jTGiwtPj6+EqHLLT2a9eXfB?=
 =?us-ascii?Q?GhMGlBoif0HHCwtoUGHvfy8rha6YSn6JnzW2RA5jLqsmp56jvsmMA272xsZd?=
 =?us-ascii?Q?hlEz6F9cKcwq0TU6mzKbdSjEIhYy9hCXvKOv0W3IGl96O5/eUhBPRRWfZXlV?=
 =?us-ascii?Q?atbCLJaHDNrX5LAT/UjbrYdSZ3ylzY9t9UpzRiDYaUBjOV2DBIADAVUomFgD?=
 =?us-ascii?Q?kiBxWc59cdUXRMhQ4wr7c4dqn8k4KgyYq+IgVcRIvUNPll2O4drxjgpWQkPK?=
 =?us-ascii?Q?Yyz1Mhcec3F92UjpGv5NeUqj5pOtCF3r2t1Em5yf1b91PmLU9bwlnULX2KCE?=
 =?us-ascii?Q?PrP8K2gSKKzYTyiFH1FgNTs52fVFggLXtoE4V+0u4MIPehi2nvcsL3kVjaLF?=
 =?us-ascii?Q?AvhyOVXXmY4stdt0AZKNi0ShR8udr4RaGgCtx9eNuE2kjC2F2AvAy6N58Vec?=
 =?us-ascii?Q?WeNdAhUpX4AxyQGzzblyMXtp1rKZmLONsO/Tlod9E8PgC8IftDjB51K4TJ/S?=
 =?us-ascii?Q?MzM3F/9GFxh8IpRUw8HabW5okTHH/RzYOijg?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:36.6198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b197bfd8-6870-4619-2508-08ddd6a532d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 17:58:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1904

Use image artifacts output file in qemuimage link.

Before:
zephyr-helloworld-image-{MACHINE}.elf -> zephyr-helloworld.elf

After:
zephyr-helloworld-image-{MACHINE}.elf -> zephyr-helloworld-{MACHINE}-{DATET=
IME}.elf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/classes/zephyr-qemuboot.bbclass | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-core/classes/zephyr-qemuboot.bbclass b/meta-zephyr=
-core/classes/zephyr-qemuboot.bbclass
index b45e6f6..ab0a281 100644
--- a/meta-zephyr-core/classes/zephyr-qemuboot.bbclass
+++ b/meta-zephyr-core/classes/zephyr-qemuboot.bbclass
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


