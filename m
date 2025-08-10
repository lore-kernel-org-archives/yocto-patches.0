Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DB2CA0ECB
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (NAM02-SN1-obe.outbound.protection.outlook.com [40.107.96.70])
 by mx.groups.io with SMTP id smtpd.web11.36465.1754869165729950599
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=yjFqftMc;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.96.70, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmyQMjEUXIdRhLxGUXPnOt9IbkiJzmWlQDPDcCXglmZ8US63omXw3EzxzEzha4SrvfNSYsECmjMi4pE+aCFWElcISYiklyGZkMyxJFwXGWc6U6hkIoQUCFnY4YopM8410ZlcHkNzku4AxMxkLRRVYgRjkReoH6hIRJw2cFO7U7aqg5kdYwgC/51Hz3n7BhtuOcqgvpXJgrI5wwHdzPsqb0EKyk2ELRluC8legz+3gw8UN2SHq5jhSnUvFQw8o7aM+ZRTO06VFNmZXd/pPXuOEsFBF+xVzQ5KiM32oWGe7Qz5/4/AIb4GSsUt/0DU3KB5B5NfAtXYeRPM7OyK6l4+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=libHPKrEdGkJD/iLYxKCQC1M2iEgtoZDf4BbATkOwjo=;
 b=K5SXT0nTioeaS6zjEFEdHKOtggjd6mzw+gK1emoDaqkZ87T9p9/sl9f2fPTJ1MzOFg0mp/WFD2WLuHoYgJlZ/DHV9al7C0Kl1IE9BgSpzaggSWid0Uf1GjygBbRcgZoKV54R6zbahV8LJ3BYPzTNzCylWk4bidE/S2otP+PI7IFzS+VY4iMOgEmJmidjw1Zzw9jpZvWifA1k9xUmUe1QqJ29TFjRFexKMoZBzVes0/t80cOVWEkYPRGPXzQKzewpeEN5vgaLnzAwVRRY+jD1dQHMhwSANIcMOEL44s4jUX+CV63CWeyuNnrV79SwtAo4qicBKT7WoIQ3iv8ZJXIQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=libHPKrEdGkJD/iLYxKCQC1M2iEgtoZDf4BbATkOwjo=;
 b=yjFqftMc4upvn2qGx5X13fX0cic3OA6u7Z6wbLmurMQyXF984rfvpmi0zvUNHqjhcuyaF9E6x9ebTJUMz6JZiLIsi/69ycQip6tvoxikSVI1cXJwbLZW0rKRr0TCrQwduKUN/VPUIlro5/TqTeavf0S0hgLBhOAEZSiDpMQ1Qco=
Received: from MW4PR03CA0074.namprd03.prod.outlook.com (2603:10b6:303:b6::19)
 by SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 23:39:22 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::a4) by MW4PR03CA0074.outlook.office365.com
 (2603:10b6:303:b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Sun,
 10 Aug 2025 23:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:18 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:18 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 5/12] zephyr-image: Add image artifacts to output files
Date: Sun, 10 Aug 2025 17:39:04 -0600
Message-ID: <20250810233911.1259884-6-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 030a9cfd-7f57-435d-b5bf-08ddd8672150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sWhZcjoAHqIUTBtMAs7emI4mLHG4tzDYLBcwlYGw6ib0vuRcLZqkWMVQHObG?=
 =?us-ascii?Q?XDzAtoZ6cdnUD86iXqTONcwfkO8+5L2mRIdL9NaMcshxHiZlurccfXn1d0Fa?=
 =?us-ascii?Q?xT7M4D/wuWBU61PYiOKrqZ5DHCpHG6N/4rDZj3GR5GPIrS6HYx6qYjb6eXxj?=
 =?us-ascii?Q?Z/bE+XuZXclFCKS2DCeTMTcujXv2VK8pxBRN9CVbmxxWaHWVEAo/q5kBMsof?=
 =?us-ascii?Q?Uj6bqdFmoVkWLhKSex7miczd1JibhphkjEtsaCSFtsfwFbwdI5KwmIbnxUoG?=
 =?us-ascii?Q?PBiMKmgOLN4zcKAh2uyriAUfXw6mz98joMJYNwirVTA1AetQoQRVmeFDGvni?=
 =?us-ascii?Q?rvOl0hGN0OO6ycEvmPtLHiG6V67xVh0A8zcQnW1rhivi1UxJjsAM0zxF0Pdm?=
 =?us-ascii?Q?vgVJZmJ36dpytkxuUPuclfH1aUHGZJ47Hb2vzllKO/tH52qjlUQArdOHb2Mb?=
 =?us-ascii?Q?GArEOWIuAbhv3MLHop/bIZk4zl9f6pmQVkzjULspXV011Bh736oRw+I/vjlL?=
 =?us-ascii?Q?voktASJjNy5ao73vNzKSVC7rO2HSn+g+bW0e1JVQUlFpFHq6YR7v6Mu3t6eu?=
 =?us-ascii?Q?99k1RPzo3JLT2rworgGeXZcRwlBbsz8XF1hX2eHZ5dV2uJ9tDxSQNNrA4ZJ6?=
 =?us-ascii?Q?VzJFTR5X/w5QBNan4i5zCmdFK9qFsnCUjE9UCN/ltE+CIsycWTMxLEOytysE?=
 =?us-ascii?Q?8MA/epUtZpChF0Z0PTo44l+2AYAFpShJa8Q82m9zPSE3/aefFsbTZUdUcjy9?=
 =?us-ascii?Q?3kCNY8j3Zv89DXeMQm7HmHBOZr7+bTOejbsXUEQ9EFFoa59I2SGCI8LqpDc7?=
 =?us-ascii?Q?34L+GRhas1bts3b1EMNLV+ujI1jvqTy6AIfsWOSsg12zRayxLLxUjtvxaF2H?=
 =?us-ascii?Q?VAfrdnITfTv1QSQWszLGn9IKaIanbbFFYF4qyB4T1jlnSD0zeQ8GJLMgey2+?=
 =?us-ascii?Q?E52vcl+fPmjZdcWjlnxItZnVnlGhmKQ4E/DZUubEEdn5s7APOaMdJxYXozch?=
 =?us-ascii?Q?q+ZopxZMXgWqwrvL3E2e772sreKdXBMJXx9ohvpSpQUtIS8O3OjX+YHK92sd?=
 =?us-ascii?Q?OR+ehIfjH90sY/JK83W2Vm2s+opv5q4AbZvpMvNBiLqcItsPy8ZpfaIR+XZd?=
 =?us-ascii?Q?7eQdOPuiQ2isNpmTzdWujFvvZBXGDdv8QP9ZMIEzBDo2x6wg3XhsxYhQY8ts?=
 =?us-ascii?Q?1cN2FNHLU0Bs2TUDBwOGU4olAPOTp/gx+dRZo2CkZ6kNrdZ9j5te21ylfp8j?=
 =?us-ascii?Q?UYNDcVb+s3iSFZX4Nil82iu3hD9di2xm/m/4lb283WxtPOyEk3GxjAQWtHi9?=
 =?us-ascii?Q?+/F/tKQ90FFLlJhJYMYmI28emikNryIfZnB06Tb5hdNRA9g/21uqYUPlca0J?=
 =?us-ascii?Q?gpDBJ9TATOYTm5w+dtQmcY5ftFlXv/pMPpENsONmHOqQS+2eJwWRldXblVNr?=
 =?us-ascii?Q?lFZlBqd9/Ratx3Ea2v95D48NmjcPyL2BxOGNvQc6tlavaBatztSAYhUCES0R?=
 =?us-ascii?Q?4s9NS1tOyYmr8HObPkio6K2W8QVOFsrQzv27?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:20.7298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 030a9cfd-7f57-435d-b5bf-08ddd8672150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1913

Inherit image-artifact-names bbclass in zephyr-image.inc and add
image artifacts to output generated files.

Before:
zephyr-helloworld.elf

After:
zephyr-helloworld-{MACHINE}-{DATETIME}.elf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-kernel/zephyr-image.inc            | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc=
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
index d6ee21f..93d36b1 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
@@ -1,29 +1,47 @@
 require zephyr-kernel-src.inc
 require zephyr-kernel-common.inc
-inherit deploy
+inherit deploy image-artifact-names
=20
 OECMAKE_SOURCEPATH =3D "${ZEPHYR_SRC_DIR}"
=20
+ZEPHYR_IMAGE_LINK_NAME ?=3D "${PN}-${MACHINE}"
+ZEPHYR_IMAGE_BASE_NAME ?=3D "${PN}-${MACHINE}${IMAGE_VERSION_SUFFIX}"
+
 do_install() {
     install -d ${D}/firmware
=20
-    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT} ${D}/firmware/${PN}.elf
+    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT} ${D}/firmware/${ZEPHYR_IM=
AGE_BASE_NAME}.elf
=20
     if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
     then
-      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ${D}/firmware/${PN}=
.bin
+      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ${D}/firmware/${ZEP=
HYR_IMAGE_BASE_NAME}.bin
     fi
=20
     if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
     then
-      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ${D}/firmware/${PN}=
.efi
+      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ${D}/firmware/${ZEP=
HYR_IMAGE_BASE_NAME}.efi
     fi
 }
+
 FILES:${PN} =3D "/firmware"
 INSANE_SKIP +=3D "ldflags buildpaths"
 SYSROOT_DIRS +=3D "/firmware"
=20
 do_deploy() {
-    cp ${D}/firmware/${PN}.* ${DEPLOYDIR}/
+    cp ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT} ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_=
NAME}.elf
+    ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.elf ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_=
NAME}.elf
+
+    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
+    then
+       cp ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ${DEPLOYDIR}/${ZEPHYR_IMAG=
E_BASE_NAME}.bin
+       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.bin ${DEPLOYDIR}/${ZEPHYR_IMAGE_LI=
NK_NAME}.bin
+    fi
+
+    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
+    then
+       cp ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ${DEPLOYDIR}/${ZEPHYR_IMAG=
E_BASE_NAME}.efi
+       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.efi ${DEPLOYDIR}/${ZEPHYR_IMAGE_LI=
NK_NAME}.efi
+    fi
+
 }
 addtask deploy after do_install
--=20
2.34.1


