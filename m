Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C6C87FCB
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 17:58:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.62])
 by mx.groups.io with SMTP id smtpd.web11.29077.1754675916491044952
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 10:58:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=bQ8ePAKA;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.62, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPSc1TnbE9Op18rj5tmWxSk8a58XIBPOlJN0CRarCDXTAoynnNSESzbneO/T8nbUFBuZHym7db/5XOykcHY0yKqiEk1qV8FeD8iOTuTlkMfbYvdCJdNtbK7s4ZqPJ5NYocoVHj0IipEIJl63kYXPYGDVL44DyEPUxclcdxDS9hz98QVflRrJtoqa0ePIN6OcXz3YoLH/xBWlY1QhUA2Fb+NOvYoRIuKslhEWUChazz+xBr7vF41ja2k06Pd56fi0x4dUJLTny0FFMCPuwkquuFk7cnUlW+sSqvd9Q0k6S3SnzK9YBdVc1eIcTr+qQSBZdTImbAJnzgRHe1MtMMwvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXPuK3vGM9eqmhgB7J3EO9MjVB4bMebOxoQHIQsDEmg=;
 b=Sr50o+V2fpDQIdLk7mYh+RkM9EZttX1raJlxmtd6qbp6uWW2ZCCclP53uCQNetHzk090WLAKgEC9IsPYakGa9HNkTHoe8DiNOc29WbZM7/cIH/64UQpJCs7uI84H+GyPi0ZXcKKrJDnPWLCAJr8RF9dOQP33n2ahMJ3TeDd2sbN42aZ2sFPvrQI2NtnVUoMPB7wEER9Hh84ttsyPgcE4A0ek3sUcVGM6bn8bFeXgg7CPYuSAn+RXJhFVbOZpaqJn74p9VLrLgfsOqZ9b1FQ9sBBwFiQpA2fI4O1FOQBYnz/4PmqoPPOsBZOybwIS19PU/tyYsL4vf8EKOGNi853G5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXPuK3vGM9eqmhgB7J3EO9MjVB4bMebOxoQHIQsDEmg=;
 b=bQ8ePAKAxBkgXPopbJ8JlGwxtkaPmTDZIrbjatkVGYiyaBAqEw7z62TB9kKk3OOAgxT1uLJTFMrJKKSlW9eeqeI+sVwyYmkiWWdwaQRwDru5TVdb78a5NcVRr7apsB7RwUOJZ+sNryg9v31uWwpq1svB80xlvPNvQ25VQxPwZZ8=
Received: from CY8PR12CA0046.namprd12.prod.outlook.com (2603:10b6:930:49::24)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 17:58:34 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::12) by CY8PR12CA0046.outlook.office365.com
 (2603:10b6:930:49::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 17:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 17:58:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:32 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Aug 2025 12:58:32 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH 7/9] zephyr-kernel: Add Zephyr LTS3.7.0 support
Date: Fri, 8 Aug 2025 11:58:27 -0600
Message-ID: <20250808175829.3830489-8-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 031690a4-595a-4ba1-111e-08ddd6a53101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?x5PIgRlXRsHCVJIej1KuG5AWgOvmRslpFSZUrCKd0/K1XeuQygELuDOropNk?=
 =?us-ascii?Q?eza2GzvvmnG9E1ByjOG+qXdPPWO52dFWYqdsEwx2vQQLlBeuoUnS3lgRE4/o?=
 =?us-ascii?Q?jwrkcyXFmusUjEev+5+EKgxAn7CZRkVokdrdLjTQIOKQv4xWA6dZYyV8wCu9?=
 =?us-ascii?Q?RZ+EwKHNZ3Yi0cf/AifrsfQBuTReYwkTjVnFMVpHLdXK+A52vVI6zVYV2VSr?=
 =?us-ascii?Q?+KyS+MYnOpIxHbbP3Go/Ajtt96d+R6wNir1NcfuvWx+AXjsjIJgCebBVX6ft?=
 =?us-ascii?Q?CqgiJ3F0Z8SSmU3J4KyBQxEdakEmxuCEHCa4F20rdRA/WLo1z/hUbMFobfKd?=
 =?us-ascii?Q?OcXbZbNGF3cin0MTD3jW7cz3RwYKiiLtAZ2wv8CN3vjwK1p9OMg1+t/A0aUI?=
 =?us-ascii?Q?u2VrsweRZvUX7FfKZWUWa1Zv502qXonGbYkC0/CBhcqRPnekeQ5Y37Nvx9GP?=
 =?us-ascii?Q?xP1y2A54ZbvTeCvvcg1IWoDOGtuiiZBEa61p7qIRu4l45QNAM8h5DkxdZtbI?=
 =?us-ascii?Q?5qFX65JceDUPJLsGnbLgbcDNidx/ikALFXAZMhuzFEkMJqiku/x/7pdX5P8X?=
 =?us-ascii?Q?ZUTsOX2EJ39Zilq1zFXPr8YqyLMM6en69crLCutYwooM0X2cR5oMoQEAfQdN?=
 =?us-ascii?Q?atheG7T0Q8lmlF21vG63pafT5LEGFj1IQ8QU1l3846wlg6VWUw0ZgV9t8z/8?=
 =?us-ascii?Q?7qPK4+tTBaVlzepOqyMNyOF/tu6hXrquhvYM5SHKmIuvcnvZRUA84VDLVMH9?=
 =?us-ascii?Q?T6R7Q+F0VacLn2xlwQ0mpDxukJaNWtSMCmRlN23DOqP2JLG8RYXseDObAxUf?=
 =?us-ascii?Q?kxP5d0QYdOeBcNIkTe9FgdS/QGqRIBPtgdflEVyhbSt2sTX3P16XFiEy0tMP?=
 =?us-ascii?Q?5Ni8kMrXswf8/YMcuSH21xgXz6TdvYbIby5yFxMbrx/7D4z6vX72bp116QBd?=
 =?us-ascii?Q?mjTLZAn5UBxGPuAx+MBJlqpeUTIIEuWl28LDXLhFsDSuw4T/lN2MBs7eqaZl?=
 =?us-ascii?Q?UNpZcUKdC0oE+pWf6ag1qId7INKt5CUnzU3rrlZ6gigF8xUMC5bQ34a/lyAd?=
 =?us-ascii?Q?nnl/MN7mEdrCsAx+JrCGFbCed7qKG5LOCcyrgn6AwrswRzcyLN259JBvyjOo?=
 =?us-ascii?Q?RHc5u+JBquRgX4uwcrXfFdf+iMXp8JQJEXjs7PE6YQLZzoCXIJ7Op8F39pxy?=
 =?us-ascii?Q?Ke4lHeodZ/xXe7HxS9Rxv8hURHMZC4mvOZjcr0jyFRWi9UxchWGmMo2BvHgg?=
 =?us-ascii?Q?Hd2aHwTc8CcWwJ8sR0hODRohYUNNz94yn2CIBOCIejSWOso3wVlR0slPrA7/?=
 =?us-ascii?Q?5yc9sGNHgf87rjZ6wJkq7iMdsuTdReqX983GXhClAB0a9lABKg4MPdMvUPPX?=
 =?us-ascii?Q?RF3Cn4kPsjKfnPNOcco1rwHMeuy0zCJwRk3/O1lZNLlSXheIyWqemN+URpvV?=
 =?us-ascii?Q?iTk8B3z7ATz5a8OQ006nRqth9X85xqnkW3jJ7H6xHxuSgdN0YmFkWZ7Fvb/v?=
 =?us-ascii?Q?9tulEKngCJzNVsalLHQa9O5vk8zw8NHUKAIQ?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:33.5688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 031690a4-595a-4ba1-111e-08ddd6a53101
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 17:58:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1900

Add Zephyr LTS3.7.0 support to scarthgap release. In scarthgap default
PREFERRED_VERSION_zephyr-kernel is set to 3.6.0 and if user needs LTS3
then set PREFERRED_VERSION_zephyr-kernel =3D "3.7.0" in local.conf file.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 ...ry-generation-issue-in-cross-compila.patch | 106 +++++++
 .../zephyr-kernel/zephyr-kernel-src-3.7.0.inc | 274 ++++++++++++++++++
 2 files changed, 380 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/files/000=
1-3.7-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-ke=
rnel-src-3.7.0.inc

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-3.7-x=
86-fix-efi-binary-generation-issue-in-cross-compila.patch b/meta-zephyr-cor=
e/recipes-kernel/zephyr-kernel/files/0001-3.7-x86-fix-efi-binary-generation=
-issue-in-cross-compila.patch
new file mode 100644
index 0000000..5029369
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-3.7-x86-fix-=
efi-binary-generation-issue-in-cross-compila.patch
@@ -0,0 +1,106 @@
+From 23f6da3cf295fa84cb03c7d98dfc6ec9c6aa2cf3 Mon Sep 17 00:00:00 2001
+From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
+Date: Thu, 3 Jul 2025 00:31:50 -0600
+Subject: [PATCH] x86: fix efi binary generation issue in cross compilation=
 env
+
+Set root directory for headers.
+
+Upstream-Status: Inappropriate [Yocto Project cross-compilation specific]
+
+Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
+---
+ arch/x86/zefi/zefi.py                                       | 5 ++++-
+ boards/intel/adl/CMakeLists.txt                             | 1 +
+ boards/intel/ehl/CMakeLists.txt                             | 1 +
+ boards/intel/rpl/CMakeLists.txt                             | 1 +
+ boards/up-bridge-the-gap/up_squared/CMakeLists.txt          | 1 +
+ boards/up-bridge-the-gap/up_squared_pro_7000/CMakeLists.txt | 1 +
+ 6 files changed, 9 insertions(+), 1 deletion(-)
+
+diff --git a/arch/x86/zefi/zefi.py b/arch/x86/zefi/zefi.py
+index 99c188ecd08..1cd86a21cd4 100755
+--- a/arch/x86/zefi/zefi.py
++++ b/arch/x86/zefi/zefi.py
+@@ -109,8 +109,10 @@ def build_elf(elf_file, include_dirs):
+     includes =3D []
+     for include_dir in include_dirs:
+         includes.extend(["-I", include_dir])
++    #  Pass --sysroot path for cross compilation
++    sysrootarg =3D "--sysroot=3D" + args.sysroot
+     cmd =3D ([args.compiler, "-shared", "-Wall", "-Werror", "-I."] + incl=
udes +
+-           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wc=
har",
++           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wc=
har", sysrootarg,
+             "-Wl,-nostdlib", "-T", ldscript, "-o", "zefi.elf", cfile])
+     verbose(" ".join(cmd))
+     subprocess.run(cmd, check =3D True)
+@@ -150,6 +152,7 @@ def parse_args():
+     parser.add_argument("-v", "--verbose", action=3D"store_true", help=3D=
"Verbose output")
+     parser.add_argument("-i", "--includes", required=3DTrue, nargs=3D"+",
+                         help=3D"Zephyr base include directories")
++    parser.add_argument("-s", "--sysroot", required=3DTrue, help=3D"Cross=
 compilation --sysroot=3Dpath")
+=20
+     return parser.parse_args()
+=20
+diff --git a/boards/intel/adl/CMakeLists.txt b/boards/intel/adl/CMakeLists=
.txt
+index 36ddcdf9d13..4cb244a777d 100644
+--- a/boards/intel/adl/CMakeLists.txt
++++ b/boards/intel/adl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_comma=
nds
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/intel/ehl/CMakeLists.txt b/boards/intel/ehl/CMakeLists=
.txt
+index 36ddcdf9d13..4cb244a777d 100644
+--- a/boards/intel/ehl/CMakeLists.txt
++++ b/boards/intel/ehl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_comma=
nds
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/intel/rpl/CMakeLists.txt b/boards/intel/rpl/CMakeLists=
.txt
+index 36ddcdf9d13..4cb244a777d 100644
+--- a/boards/intel/rpl/CMakeLists.txt
++++ b/boards/intel/rpl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_comma=
nds
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/up-bridge-the-gap/up_squared/CMakeLists.txt b/boards/u=
p-bridge-the-gap/up_squared/CMakeLists.txt
+index ddfd93807ff..8dfe7aa9cec 100644
+--- a/boards/up-bridge-the-gap/up_squared/CMakeLists.txt
++++ b/boards/up-bridge-the-gap/up_squared/CMakeLists.txt
+@@ -11,6 +11,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_com=
mands
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/up-bridge-the-gap/up_squared_pro_7000/CMakeLists.txt b=
/boards/up-bridge-the-gap/up_squared_pro_7000/CMakeLists.txt
+index 36ddcdf9d13..4cb244a777d 100644
+--- a/boards/up-bridge-the-gap/up_squared_pro_7000/CMakeLists.txt
++++ b/boards/up-bridge-the-gap/up_squared_pro_7000/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_comma=
nds
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+--=20
+2.34.1
+
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-sr=
c-3.7.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-s=
rc-3.7.0.inc
new file mode 100644
index 0000000..1cf87a2
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0=
.inc
@@ -0,0 +1,274 @@
+# Auto-generated from zephyr-kernel-src.inc.jinja
+
+SRCREV_FORMAT =3D "default"
+
+SRCREV_default =3D "36940db938a8f4a1e919496793ed439850a221c2"
+SRCREV_acpica =3D "8d24867bc9c9d81c81eeac59391cda59333affd4"
+SRCREV_bsim =3D "9351ae1ad44864a49c351f9704f65f43046abeb0"
+SRCREV_babblesim_base =3D "4bd907be0b2abec3b31a23fd8ca98db2a07209d2"
+SRCREV_babblesim_ext_2G4_libPhyComv1 =3D "93f5eba512c438b0c9ebc1b1a947517c=
865b3643"
+SRCREV_babblesim_ext_2G4_phy_v1 =3D "04eeb3c3794444122fbeeb3715f4233b0b50c=
fbb"
+SRCREV_babblesim_ext_2G4_channel_NtNcable =3D "20a38c997f507b0aa53817aab3d=
73a462fff7af1"
+SRCREV_babblesim_ext_2G4_channel_multiatt =3D "bde72a57384dde7a4310bcf3843=
469401be93074"
+SRCREV_babblesim_ext_2G4_modem_magic =3D "edfcda2d3937a74be0a59d6cd47e0f50=
183453da"
+SRCREV_babblesim_ext_2G4_modem_BLE_simple =3D "a38d2d24b04a6f970a225d13160=
47256ebf5a539"
+SRCREV_babblesim_ext_2G4_device_burst_interferer =3D "5b5339351d6e6a2368c6=
86c734dc8b2fc65698fc"
+SRCREV_babblesim_ext_2G4_device_WLAN_actmod =3D "9cb6d8e72695f6b785e57443f=
0629a18069d6ce4"
+SRCREV_babblesim_ext_2G4_device_playback =3D "abb48cd71ddd4e2a9022f4bf49b2=
712524c483e8"
+SRCREV_babblesim_ext_libCryptov1 =3D "eed6d7038e839153e340bd333bc43541cb90=
ba64"
+SRCREV_cmsis =3D "4b96cbb174678dcd3ca86e11e1f24bc5f8726da0"
+SRCREV_cmsis-dsp =3D "6489e771e9c405f1763b52d64a3f17a1ec488ace"
+SRCREV_cmsis-nn =3D "ea987c1ca661be723de83bd159aed815d6cbd430"
+SRCREV_edtt =3D "8d7b543d4d2f2be0f78481e4e1d8d73a88024803"
+SRCREV_fatfs =3D "427159bf95ea49b7680facffaa29ad506b42709b"
+SRCREV_hal_adi =3D "dee9a7b1eff13a9da0560daf8842d61657f9d61e"
+SRCREV_hal_altera =3D "4fe4df959d4593ce66e676aeba0b57f546dba0fe"
+SRCREV_hal_ambiq =3D "e25327f026df1ee08f1bf01a4bbfeb5e5f4026f1"
+SRCREV_hal_atmel =3D "56d60ebc909ad065bf6554cee73487969857614b"
+SRCREV_hal_espressif =3D "87e7902d7184a8280b4d13bce79801a723f4ddd8"
+SRCREV_hal_ethos_u =3D "8e2cf756b474eff9a32a9bdf1775d9620f1eadcf"
+SRCREV_hal_gigadevice =3D "2994b7dde8b0b0fa9b9c0ccb13474b6a486cddc3"
+SRCREV_hal_infineon =3D "f25734a72c585f6675e8254a382e80e78a3cd03a"
+SRCREV_hal_intel =3D "0905a528623de56b1bedf817536321bcdbc0efae"
+SRCREV_hal_microchip =3D "71eba057c0cb7fc11b6f33eb40a82f1ebe2c571c"
+SRCREV_hal_nordic =3D "ab5cb2e2faeb1edfad7a25286dcb513929ae55da"
+SRCREV_hal_nuvoton =3D "466c3eed9c98453fb23953bf0e0427fea01924be"
+SRCREV_hal_nxp =3D "862e001504bd6e0a4feade6a718e9f973116849c"
+SRCREV_hal_openisa =3D "eabd530a64d71de91d907bad257cd61aacf607bc"
+SRCREV_hal_quicklogic =3D "bad894440fe72c814864798c8e3a76d13edffb6c"
+SRCREV_hal_renesas =3D "af77d7cdfeeff290593e7e99f54f0c1e2a3f91e6"
+SRCREV_hal_rpi_pico =3D "fba7162cc7bee06d0149622bbcaac4e41062d368"
+SRCREV_hal_silabs =3D "a09dd1b82b24aa3060e162c0dfa40026c0dba450"
+SRCREV_hal_st =3D "b77157f6bc4395e398d90ab02a7d2cbc01ab2ce7"
+SRCREV_hal_stm32 =3D "f1317150eac951fdd8259337a47cbbc4c2e6d335"
+SRCREV_hal_telink =3D "4226c7fc17d5a34e557d026d428fc766191a0800"
+SRCREV_hal_ti =3D "b85f86e51fc4d47c4c383d320d64d52d4d371ae4"
+SRCREV_hal_wurthelektronik =3D "e5bcb2eac1bb9639ce13b4dafc78eb254e014342"
+SRCREV_hal_xtensa =3D "a2d658525b16c57bea8dd565f5bd5167e4b9f1ee"
+SRCREV_hostap =3D "a90df86d7c596a5367ff70c2b50c7f599e6636f3"
+SRCREV_libmetal =3D "a6851ba6dba8c9e87d00c42f171a822f7a29639b"
+SRCREV_liblc3 =3D "1a5938ebaca4f13fe79ce074f5dee079783aa29f"
+SRCREV_littlefs =3D "408c16a909dd6cf128874a76f21c793798c9e423"
+SRCREV_loramac-node =3D "fb00b383072518c918e2258b0916c996f2d4eebe"
+SRCREV_lvgl =3D "2b498e6f36d6b82ae1da12c8b7742e318624ecf5"
+SRCREV_mbedtls =3D "2f24831ee13d399ce019c4632b0bcd440a713f7c"
+SRCREV_mcuboot =3D "fb2cf0ec3da3687b93f28e556ab682bdd4b85223"
+SRCREV_mipi-sys-t =3D "71ace1f5caa03e56c8740a09863e685efb4b2360"
+SRCREV_net-tools =3D "7c7a856814d7f27509c8511fef14cec21f7d0c30"
+SRCREV_nrf_hw_models =3D "6c389b9b5fa0a079cd4502e69d375da4c0c289b7"
+SRCREV_open-amp =3D "76d2168bcdfcd23a9a7dce8c21f2083b90a1e60a"
+SRCREV_openthread =3D "3873c6fcd5a8a9dd01b71e8efe32ef5dc7923bb1"
+SRCREV_percepio =3D "a49e5f3947faad0dd654eddd5a750127fb81e50d"
+SRCREV_picolibc =3D "764ef4e401a8f4c6a86ab723533841f072885a5b"
+SRCREV_segger =3D "b011c45b585e097d95d9cf93edf4f2e01588d3cd"
+SRCREV_tinycrypt =3D "1012a3ebee18c15ede5efc8332ee2fc37817670f"
+SRCREV_trusted-firmware-m =3D "069455be098383bf96eab73e3ff8e0c66c60fa5a"
+SRCREV_trusted-firmware-a =3D "713ffbf96c5bcbdeab757423f10f73eb304eff07"
+SRCREV_uoscore-uedhoc =3D "84ef879a46d7bfd9a423fbfb502b04289861f9ea"
+SRCREV_zcbor =3D "75d088037eb237b18e7ec1f47c9ce494b9b95aab"
+
+SRC_URI_ZEPHYR ?=3D "git://github.com/zephyrproject-rtos/zephyr.git;protoc=
ol=3Dhttps"
+SRC_URI_ZEPHYR_ACPICA ?=3D "git://github.com/zephyrproject-rtos/acpica;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_BSIM ?=3D "git://github.com/zephyrproject-rtos/babblesim-ma=
nifest;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_BASE ?=3D "git://github.com/BabbleSim/base;protoc=
ol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1 ?=3D "git://github.com/Babble=
Sim/ext_2G4_libPhyComv1;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1 ?=3D "git://github.com/BabbleSim/e=
xt_2G4_phy_v1;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE ?=3D "git://github.com/B=
abbleSim/ext_2G4_channel_NtNcable;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT ?=3D "git://github.com/B=
abbleSim/ext_2G4_channel_multiatt;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC ?=3D "git://github.com/Babble=
Sim/ext_2G4_modem_magic;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE ?=3D "git://github.com/B=
abbleSim/ext_2G4_modem_BLE_simple;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER ?=3D "git://githu=
b.com/BabbleSim/ext_2G4_device_burst_interferer;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD ?=3D "git://github.com=
/BabbleSim/ext_2G4_device_WLAN_actmod;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK ?=3D "git://github.com/Ba=
bbleSim/ext_2G4_device_playback;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1 ?=3D "git://github.com/BabbleSim/=
ext_libCryptov1;protocol=3Dhttps"
+SRC_URI_ZEPHYR_CMSIS ?=3D "git://github.com/zephyrproject-rtos/cmsis;proto=
col=3Dhttps"
+SRC_URI_ZEPHYR_CMSIS_DSP ?=3D "git://github.com/zephyrproject-rtos/cmsis-d=
sp;protocol=3Dhttps"
+SRC_URI_ZEPHYR_CMSIS_NN ?=3D "git://github.com/zephyrproject-rtos/cmsis-nn=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_EDTT ?=3D "git://github.com/zephyrproject-rtos/edtt;protoco=
l=3Dhttps"
+SRC_URI_ZEPHYR_FATFS ?=3D "git://github.com/zephyrproject-rtos/fatfs;proto=
col=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ADI ?=3D "git://github.com/zephyrproject-rtos/hal_adi;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ALTERA ?=3D "git://github.com/zephyrproject-rtos/hal_al=
tera;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_AMBIQ ?=3D "git://github.com/zephyrproject-rtos/hal_amb=
iq;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ATMEL ?=3D "git://github.com/zephyrproject-rtos/hal_atm=
el;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ESPRESSIF ?=3D "git://github.com/zephyrproject-rtos/hal=
_espressif;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ETHOS_U ?=3D "git://github.com/zephyrproject-rtos/hal_e=
thos_u;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_GIGADEVICE ?=3D "git://github.com/zephyrproject-rtos/ha=
l_gigadevice;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_INFINEON ?=3D "git://github.com/zephyrproject-rtos/hal_=
infineon;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_INTEL ?=3D "git://github.com/zephyrproject-rtos/hal_int=
el;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_MICROCHIP ?=3D "git://github.com/zephyrproject-rtos/hal=
_microchip;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_NORDIC ?=3D "git://github.com/zephyrproject-rtos/hal_no=
rdic;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_NUVOTON ?=3D "git://github.com/zephyrproject-rtos/hal_n=
uvoton;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_NXP ?=3D "git://github.com/zephyrproject-rtos/hal_nxp;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_OPENISA ?=3D "git://github.com/zephyrproject-rtos/hal_o=
penisa;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_QUICKLOGIC ?=3D "git://github.com/zephyrproject-rtos/ha=
l_quicklogic;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_RENESAS ?=3D "git://github.com/zephyrproject-rtos/hal_r=
enesas;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_RPI_PICO ?=3D "git://github.com/zephyrproject-rtos/hal_=
rpi_pico;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_SILABS ?=3D "git://github.com/zephyrproject-rtos/hal_si=
labs;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ST ?=3D "git://github.com/zephyrproject-rtos/hal_st;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_STM32 ?=3D "git://github.com/zephyrproject-rtos/hal_stm=
32;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_TELINK ?=3D "git://github.com/zephyrproject-rtos/hal_te=
link;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_TI ?=3D "git://github.com/zephyrproject-rtos/hal_ti;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK ?=3D "git://github.com/zephyrproject-rt=
os/hal_wurthelektronik;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_XTENSA ?=3D "git://github.com/zephyrproject-rtos/hal_xt=
ensa;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HOSTAP ?=3D "git://github.com/zephyrproject-rtos/hostap;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_LIBMETAL ?=3D "git://github.com/zephyrproject-rtos/libmetal=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_LIBLC3 ?=3D "git://github.com/zephyrproject-rtos/liblc3;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_LITTLEFS ?=3D "git://github.com/zephyrproject-rtos/littlefs=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_LORAMAC_NODE ?=3D "git://github.com/zephyrproject-rtos/lora=
mac-node;protocol=3Dhttps"
+SRC_URI_ZEPHYR_LVGL ?=3D "git://github.com/zephyrproject-rtos/lvgl;protoco=
l=3Dhttps"
+SRC_URI_ZEPHYR_MBEDTLS ?=3D "git://github.com/zephyrproject-rtos/mbedtls;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_MCUBOOT ?=3D "git://github.com/zephyrproject-rtos/mcuboot;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_MIPI_SYS_T ?=3D "git://github.com/zephyrproject-rtos/mipi-s=
ys-t;protocol=3Dhttps"
+SRC_URI_ZEPHYR_NET_TOOLS ?=3D "git://github.com/zephyrproject-rtos/net-too=
ls;protocol=3Dhttps"
+SRC_URI_ZEPHYR_NRF_HW_MODELS ?=3D "git://github.com/zephyrproject-rtos/nrf=
_hw_models;protocol=3Dhttps"
+SRC_URI_ZEPHYR_OPEN_AMP ?=3D "git://github.com/zephyrproject-rtos/open-amp=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_OPENTHREAD ?=3D "git://github.com/zephyrproject-rtos/openth=
read;protocol=3Dhttps"
+SRC_URI_ZEPHYR_PERCEPIO ?=3D "git://github.com/zephyrproject-rtos/percepio=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_PICOLIBC ?=3D "git://github.com/zephyrproject-rtos/picolibc=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_SEGGER ?=3D "git://github.com/zephyrproject-rtos/segger;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_TINYCRYPT ?=3D "git://github.com/zephyrproject-rtos/tinycry=
pt;protocol=3Dhttps"
+SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M ?=3D "git://github.com/zephyrproject-rto=
s/trusted-firmware-m;protocol=3Dhttps"
+SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A ?=3D "git://github.com/zephyrproject-rto=
s/trusted-firmware-a;protocol=3Dhttps"
+SRC_URI_ZEPHYR_UOSCORE_UEDHOC ?=3D "git://github.com/zephyrproject-rtos/uo=
score-uedhoc;protocol=3Dhttps"
+SRC_URI_ZEPHYR_ZCBOR ?=3D "git://github.com/zephyrproject-rtos/zcbor;proto=
col=3Dhttps"
+
+SRC_URI_PATCHES ?=3D "\
+    file://0001-3.7-x86-fix-efi-binary-generation-issue-in-cross-compila.p=
atch;patchdir=3Dzephyr \
+"
+
+SRC_URI =3D "\
+    ${SRC_URI_ZEPHYR};branch=3D${ZEPHYR_BRANCH};name=3Ddefault;destsuffix=
=3Dgit/zephyr \
+    ${SRC_URI_ZEPHYR_ACPICA};name=3Dacpica;nobranch=3D1;destsuffix=3Dgit/m=
odules/lib/acpica \
+    ${SRC_URI_ZEPHYR_BSIM};name=3Dbsim;nobranch=3D1;destsuffix=3Dgit/tools=
/bsim \
+    ${SRC_URI_ZEPHYR_BABBLESIM_BASE};name=3Dbabblesim_base;nobranch=3D1;de=
stsuffix=3Dgit/tools/bsim/components \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1};name=3Dbabblesim_ext_2=
G4_libPhyComv1;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/ext_2G4_=
libPhyComv1 \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1};name=3Dbabblesim_ext_2G4_ph=
y_v1;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/ext_2G4_phy_v1 \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE};name=3Dbabblesim_=
ext_2G4_channel_NtNcable;nobranch=3D1;destsuffix=3Dgit/tools/bsim/component=
s/ext_2G4_channel_NtNcable \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT};name=3Dbabblesim_=
ext_2G4_channel_multiatt;nobranch=3D1;destsuffix=3Dgit/tools/bsim/component=
s/ext_2G4_channel_multiatt \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC};name=3Dbabblesim_ext_2=
G4_modem_magic;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/ext_2G4_=
modem_magic \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE};name=3Dbabblesim_=
ext_2G4_modem_BLE_simple;nobranch=3D1;destsuffix=3Dgit/tools/bsim/component=
s/ext_2G4_modem_BLE_simple \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER};name=3Dbab=
blesim_ext_2G4_device_burst_interferer;nobranch=3D1;destsuffix=3Dgit/tools/=
bsim/components/ext_2G4_device_burst_interferer \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD};name=3Dbabblesi=
m_ext_2G4_device_WLAN_actmod;nobranch=3D1;destsuffix=3Dgit/tools/bsim/compo=
nents/ext_2G4_device_WLAN_actmod \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK};name=3Dbabblesim_e=
xt_2G4_device_playback;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/=
ext_2G4_device_playback \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1};name=3Dbabblesim_ext_libCr=
yptov1;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/ext_libCryptov1 =
\
+    ${SRC_URI_ZEPHYR_CMSIS};name=3Dcmsis;nobranch=3D1;destsuffix=3Dgit/mod=
ules/hal/cmsis \
+    ${SRC_URI_ZEPHYR_CMSIS_DSP};name=3Dcmsis-dsp;nobranch=3D1;destsuffix=
=3Dgit/modules/lib/cmsis-dsp \
+    ${SRC_URI_ZEPHYR_CMSIS_NN};name=3Dcmsis-nn;nobranch=3D1;destsuffix=3Dg=
it/modules/lib/cmsis-nn \
+    ${SRC_URI_ZEPHYR_EDTT};name=3Dedtt;nobranch=3D1;destsuffix=3Dgit/tools=
/edtt \
+    ${SRC_URI_ZEPHYR_FATFS};name=3Dfatfs;nobranch=3D1;destsuffix=3Dgit/mod=
ules/fs/fatfs \
+    ${SRC_URI_ZEPHYR_HAL_ADI};name=3Dhal_adi;nobranch=3D1;destsuffix=3Dgit=
/modules/hal/adi \
+    ${SRC_URI_ZEPHYR_HAL_ALTERA};name=3Dhal_altera;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/altera \
+    ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=3Dhal_ambiq;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/ambiq \
+    ${SRC_URI_ZEPHYR_HAL_ATMEL};name=3Dhal_atmel;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/atmel \
+    ${SRC_URI_ZEPHYR_HAL_ESPRESSIF};name=3Dhal_espressif;nobranch=3D1;dest=
suffix=3Dgit/modules/hal/espressif \
+    ${SRC_URI_ZEPHYR_HAL_ETHOS_U};name=3Dhal_ethos_u;nobranch=3D1;destsuff=
ix=3Dgit/modules/hal/ethos_u \
+    ${SRC_URI_ZEPHYR_HAL_GIGADEVICE};name=3Dhal_gigadevice;nobranch=3D1;de=
stsuffix=3Dgit/modules/hal/gigadevice \
+    ${SRC_URI_ZEPHYR_HAL_INFINEON};name=3Dhal_infineon;nobranch=3D1;destsu=
ffix=3Dgit/modules/hal/infineon \
+    ${SRC_URI_ZEPHYR_HAL_INTEL};name=3Dhal_intel;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/intel \
+    ${SRC_URI_ZEPHYR_HAL_MICROCHIP};name=3Dhal_microchip;nobranch=3D1;dest=
suffix=3Dgit/modules/hal/microchip \
+    ${SRC_URI_ZEPHYR_HAL_NORDIC};name=3Dhal_nordic;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/nordic \
+    ${SRC_URI_ZEPHYR_HAL_NUVOTON};name=3Dhal_nuvoton;nobranch=3D1;destsuff=
ix=3Dgit/modules/hal/nuvoton \
+    ${SRC_URI_ZEPHYR_HAL_NXP};name=3Dhal_nxp;nobranch=3D1;destsuffix=3Dgit=
/modules/hal/nxp \
+    ${SRC_URI_ZEPHYR_HAL_OPENISA};name=3Dhal_openisa;nobranch=3D1;destsuff=
ix=3Dgit/modules/hal/openisa \
+    ${SRC_URI_ZEPHYR_HAL_QUICKLOGIC};name=3Dhal_quicklogic;nobranch=3D1;de=
stsuffix=3Dgit/modules/hal/quicklogic \
+    ${SRC_URI_ZEPHYR_HAL_RENESAS};name=3Dhal_renesas;nobranch=3D1;destsuff=
ix=3Dgit/modules/hal/renesas \
+    ${SRC_URI_ZEPHYR_HAL_RPI_PICO};name=3Dhal_rpi_pico;nobranch=3D1;destsu=
ffix=3Dgit/modules/hal/rpi_pico \
+    ${SRC_URI_ZEPHYR_HAL_SILABS};name=3Dhal_silabs;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/silabs \
+    ${SRC_URI_ZEPHYR_HAL_ST};name=3Dhal_st;nobranch=3D1;destsuffix=3Dgit/m=
odules/hal/st \
+    ${SRC_URI_ZEPHYR_HAL_STM32};name=3Dhal_stm32;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/stm32 \
+    ${SRC_URI_ZEPHYR_HAL_TELINK};name=3Dhal_telink;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/telink \
+    ${SRC_URI_ZEPHYR_HAL_TI};name=3Dhal_ti;nobranch=3D1;destsuffix=3Dgit/m=
odules/hal/ti \
+    ${SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK};name=3Dhal_wurthelektronik;nobra=
nch=3D1;destsuffix=3Dgit/modules/hal/wurthelektronik \
+    ${SRC_URI_ZEPHYR_HAL_XTENSA};name=3Dhal_xtensa;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/xtensa \
+    ${SRC_URI_ZEPHYR_HOSTAP};name=3Dhostap;nobranch=3D1;destsuffix=3Dgit/m=
odules/lib/hostap \
+    ${SRC_URI_ZEPHYR_LIBMETAL};name=3Dlibmetal;nobranch=3D1;destsuffix=3Dg=
it/modules/hal/libmetal \
+    ${SRC_URI_ZEPHYR_LIBLC3};name=3Dliblc3;nobranch=3D1;destsuffix=3Dgit/m=
odules/lib/liblc3 \
+    ${SRC_URI_ZEPHYR_LITTLEFS};name=3Dlittlefs;nobranch=3D1;destsuffix=3Dg=
it/modules/fs/littlefs \
+    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=3Dloramac-node;nobranch=3D1;destsu=
ffix=3Dgit/modules/lib/loramac-node \
+    ${SRC_URI_ZEPHYR_LVGL};name=3Dlvgl;nobranch=3D1;destsuffix=3Dgit/modul=
es/lib/gui/lvgl \
+    ${SRC_URI_ZEPHYR_MBEDTLS};name=3Dmbedtls;nobranch=3D1;destsuffix=3Dgit=
/modules/crypto/mbedtls \
+    ${SRC_URI_ZEPHYR_MCUBOOT};name=3Dmcuboot;nobranch=3D1;destsuffix=3Dgit=
/bootloader/mcuboot \
+    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=3Dmipi-sys-t;nobranch=3D1;destsuffix=
=3Dgit/modules/debug/mipi-sys-t \
+    ${SRC_URI_ZEPHYR_NET_TOOLS};name=3Dnet-tools;nobranch=3D1;destsuffix=
=3Dgit/tools/net-tools \
+    ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=3Dnrf_hw_models;nobranch=3D1;dest=
suffix=3Dgit/modules/bsim_hw_models/nrf_hw_models \
+    ${SRC_URI_ZEPHYR_OPEN_AMP};name=3Dopen-amp;nobranch=3D1;destsuffix=3Dg=
it/modules/lib/open-amp \
+    ${SRC_URI_ZEPHYR_OPENTHREAD};name=3Dopenthread;nobranch=3D1;destsuffix=
=3Dgit/modules/lib/openthread \
+    ${SRC_URI_ZEPHYR_PERCEPIO};name=3Dpercepio;nobranch=3D1;destsuffix=3Dg=
it/modules/debug/percepio \
+    ${SRC_URI_ZEPHYR_PICOLIBC};name=3Dpicolibc;nobranch=3D1;destsuffix=3Dg=
it/modules/lib/picolibc \
+    ${SRC_URI_ZEPHYR_SEGGER};name=3Dsegger;nobranch=3D1;destsuffix=3Dgit/m=
odules/debug/segger \
+    ${SRC_URI_ZEPHYR_TINYCRYPT};name=3Dtinycrypt;nobranch=3D1;destsuffix=
=3Dgit/modules/crypto/tinycrypt \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=3Dtrusted-firmware-m;nobranc=
h=3D1;destsuffix=3Dgit/modules/tee/tf-m/trusted-firmware-m \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=3Dtrusted-firmware-a;nobranc=
h=3D1;destsuffix=3Dgit/modules/tee/tf-a/trusted-firmware-a \
+    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=3Duoscore-uedhoc;nobranch=3D1;de=
stsuffix=3Dgit/modules/lib/uoscore-uedhoc \
+    ${SRC_URI_ZEPHYR_ZCBOR};name=3Dzcbor;nobranch=3D1;destsuffix=3Dgit/mod=
ules/lib/zcbor \
+    ${SRC_URI_PATCHES} \
+"
+
+ZEPHYR_MODULES =3D "\
+${S}/modules/lib/acpica\;\
+${S}/tools/bsim\;\
+${S}/tools/bsim/components\;\
+${S}/tools/bsim/components/ext_2G4_libPhyComv1\;\
+${S}/tools/bsim/components/ext_2G4_phy_v1\;\
+${S}/tools/bsim/components/ext_2G4_channel_NtNcable\;\
+${S}/tools/bsim/components/ext_2G4_channel_multiatt\;\
+${S}/tools/bsim/components/ext_2G4_modem_magic\;\
+${S}/tools/bsim/components/ext_2G4_modem_BLE_simple\;\
+${S}/tools/bsim/components/ext_2G4_device_burst_interferer\;\
+${S}/tools/bsim/components/ext_2G4_device_WLAN_actmod\;\
+${S}/tools/bsim/components/ext_2G4_device_playback\;\
+${S}/tools/bsim/components/ext_libCryptov1\;\
+${S}/modules/hal/cmsis\;\
+${S}/modules/lib/cmsis-dsp\;\
+${S}/modules/lib/cmsis-nn\;\
+${S}/tools/edtt\;\
+${S}/modules/fs/fatfs\;\
+${S}/modules/hal/adi\;\
+${S}/modules/hal/altera\;\
+${S}/modules/hal/ambiq\;\
+${S}/modules/hal/atmel\;\
+${S}/modules/hal/espressif\;\
+${S}/modules/hal/ethos_u\;\
+${S}/modules/hal/gigadevice\;\
+${S}/modules/hal/infineon\;\
+${S}/modules/hal/intel\;\
+${S}/modules/hal/microchip\;\
+${S}/modules/hal/nordic\;\
+${S}/modules/hal/nuvoton\;\
+${S}/modules/hal/nxp\;\
+${S}/modules/hal/openisa\;\
+${S}/modules/hal/quicklogic\;\
+${S}/modules/hal/renesas\;\
+${S}/modules/hal/rpi_pico\;\
+${S}/modules/hal/silabs\;\
+${S}/modules/hal/st\;\
+${S}/modules/hal/stm32\;\
+${S}/modules/hal/telink\;\
+${S}/modules/hal/ti\;\
+${S}/modules/hal/wurthelektronik\;\
+${S}/modules/hal/xtensa\;\
+${S}/modules/lib/hostap\;\
+${S}/modules/hal/libmetal\;\
+${S}/modules/lib/liblc3\;\
+${S}/modules/fs/littlefs\;\
+${S}/modules/lib/loramac-node\;\
+${S}/modules/lib/gui/lvgl\;\
+${S}/modules/crypto/mbedtls\;\
+${S}/bootloader/mcuboot\;\
+${S}/modules/debug/mipi-sys-t\;\
+${S}/tools/net-tools\;\
+${S}/modules/bsim_hw_models/nrf_hw_models\;\
+${S}/modules/lib/open-amp\;\
+${S}/modules/lib/openthread\;\
+${S}/modules/debug/percepio\;\
+${S}/modules/lib/picolibc\;\
+${S}/modules/debug/segger\;\
+${S}/modules/crypto/tinycrypt\;\
+${S}/modules/tee/tf-m/trusted-firmware-m\;\
+${S}/modules/tee/tf-a/trusted-firmware-a\;\
+${S}/modules/lib/uoscore-uedhoc\;\
+${S}/modules/lib/zcbor\;\
+"
+
+ZEPHYR_BRANCH =3D "v3.7-branch"
+PV =3D "3.7.0+git${SRCPV}"
--=20
2.34.1


