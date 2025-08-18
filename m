Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD62CA0EF3
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.77])
 by mx.groups.io with SMTP id smtpd.web11.2752.1755554590875321742
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=qnY2YH+p;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.236.77, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9M7NKo7R484uiFnCJbCAbrROEFl2lqbygQTQIBZZXVOB/gBJc9ZOchDmoiFazpAwMOYkwfhQJBT6m3x11KR6JSLT9l1TtYwUOku2sOewzY31VphKpEtrL2FJVvF14GSVLSCfKTSnTtMuBc08G0HW3SwwXd59fOekIrGyeHzryWkJdAs52/17OcO9puXu5W7iI1S7Ysy2wOVXJvAi3zg1NqfLuGfEi8sK9xqRKrgBGlnqbt7Nn2XDf8wcPIE7hIxe3qK0gDIFrDRnuLwbB4TPtxvI0egpdvwomFiVekphu9iVeaf+L3ooZgzEhO8WLvUduoVscQGFZ29/pvAhNaX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wka75/N7XB9vRm6mv8QileLT8QNpfWhHTekeaQ5Oq7U=;
 b=rM2XmwHaxuAYE6e4eAw3Qjn5fIgbDavXOJ6AyXXBOn5RPssXKZeCa4ZJ0c4AQmTP/vcYLQQQ+A/PAygdZSo3FpJtiHay3rMP0vM/xYytapKsWuqfLf7rt2k+YfSx27GpUS6Dqq6o4VH1qlUgriLljGsDxcbkawtFyTWYwI/7qr+eZiB6oiBcwpUoMH/pxOOCAd/Gc3ShXwZ2P5W/ayMOI7Tz5g9bL2jUZhD8KSgHW3EDLWxWZ5h27beWhY77aRuI4pz7aSYusZNp9afOi6YXj1s6XeXnA3TTQ7Yi7nRRUJn3c23A8wtuBBACkXZeVzWSTa0t+MrkK6Pmr5h5Y/rvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wka75/N7XB9vRm6mv8QileLT8QNpfWhHTekeaQ5Oq7U=;
 b=qnY2YH+pFeRxQBjBcUwR5STjXZcoyIEmfn4X7lOx53mUlaCOLadBE+sCewrdHuwAV/1ui6cc7A+XElmcUYnZh0D1TjpgfGedUl9hfroT078OeFw1ncvwwlMWCYjhBUFU+OvetPvQWrXCHTPqEswdcRIHOpGKISP9T5V1vn3E8Us=
Received: from BL1PR13CA0347.namprd13.prod.outlook.com (2603:10b6:208:2c6::22)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 22:03:09 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::43) by BL1PR13CA0347.outlook.office365.com
 (2603:10b6:208:2c6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 22:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 22:03:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:05 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:05 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v6 3/11] zephyr-image: Add image artifacts to output files
Date: Mon, 18 Aug 2025 16:02:56 -0600
Message-ID: <20250818220304.2300436-4-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a63062-e364-4900-aa50-08dddea3044f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?g1ZPB/W5GGrLqpwqzwVpksO6miVKl4wBS5paeqzcD5lzc6+SqVXEr+DnrYZO?=
 =?us-ascii?Q?pyamwsWRqHcA8aiP0pvt54uSQVpW/NYZI5avpBcI01Detjhb69db9k5RvtV5?=
 =?us-ascii?Q?kO0joF3760lcznAI25KR1ro7ZuCDvabPcjBVV2pFiOPNwUIHOtUbwl7biIS1?=
 =?us-ascii?Q?wPPL5zHSAP1GKVLjc19dk2Gxxww2Hqf/KnCjsBhpw0cpSN0bH5v4cGjT8VJm?=
 =?us-ascii?Q?Ekb0BTELgq0q3zKlusR+Yzly6iNnEnb8b2Ko5/qi46+CdQdbwujDqA+kSSrH?=
 =?us-ascii?Q?9zZhvH6IpXKbW0LyzAchsS30zFPg1Ridr9NvBYOeVWPC8/rMCH1tlrC2kgLL?=
 =?us-ascii?Q?mU2GcX24lfEqT3eK/y605FV7jOAViUxZpArUyK0E9Bt1mZEa3XtzcjFivkI1?=
 =?us-ascii?Q?tMb7g+/ydEA62hhdt/6/jq9CbphUe5M/BVkuLXlIvla57LOtkwvYdGH8O87c?=
 =?us-ascii?Q?qG+GJwRTC4mcOi8NtjrRxqI+COGZvvzEzBg83MNcf7PU+kHHe9MCP/+iGKFB?=
 =?us-ascii?Q?apqZoyxPj/25j96JRtmSOXgkkeVUYcgeh7DjQVzKC1JWTziRd4oDrFS4EDMo?=
 =?us-ascii?Q?K9KBrPEsBEpk3OL9ZskszqnUzYnGGfErPZny6ulnaimEUj/1nRMRvVGrcQVR?=
 =?us-ascii?Q?9Ty4mODZ1P/aVqoSFoB+3EigGkJ9Lz3fXDleUFKWhD+kqNqvsCeXtf4Q59W6?=
 =?us-ascii?Q?HKfZY59LN4c44oIypHWHX1ahXOO6c45YVE4wjpa2pkRTrql2fPWz6T0+hcSx?=
 =?us-ascii?Q?oJJHiQe9b7I8oyEqVQZk93A2Ppa6W+k1NGpJNnux7DSGYvnUjMp92PGaQyzA?=
 =?us-ascii?Q?8/lAKAH+IBqTD/5cbBIur9oOj7FLwAcxYMqVrU/To+mtC/qASJw3/UOmhr75?=
 =?us-ascii?Q?yUBQkiRRNok1g3K6qzhM9EM7LneXa3Qp8/PpSCKfOCJUkA09GAtyvoGnMMyL?=
 =?us-ascii?Q?qXlG8aB4CQ8BkGl87jVNGecqSlooxPhHaLTQXPrRHcuxWYq26EPpyQVrmO7D?=
 =?us-ascii?Q?f1XeOeynOVk08XWrFwSPrB0Ua6Hssw8VIwn86lDiDc5fEd20iagpghnHdqzT?=
 =?us-ascii?Q?2DSySFB7vCyjcRJyXl9fD5YumGRpPwDKdS/i+MapcqWbjlH1VVceyBq3Nim0?=
 =?us-ascii?Q?hoCo0AFfj86yEhrJcCs/PUNBpuZ0ShY2B5Zb76lD8APSTLYPLDDIPwfC+DtP?=
 =?us-ascii?Q?NZB/RrgAi+Yq8mCXOSwJ/TiRjwcOG8m1zwzpeNJJosDmQMsqwuCfPfgDILOu?=
 =?us-ascii?Q?ALwqivB3D1KIoaelnYZ89hng+YAgZHNsYr5rZMPA4cTVFGQAwJ+9nlp80jY8?=
 =?us-ascii?Q?L3m8KP1o56HBSx5+YnTHwAyL46pnnvxuflr0MM0H52JiIS2Ws4ASGEhfO032?=
 =?us-ascii?Q?UrJlvFsUI7kCP/pt7/93n/hpG6IFd9oPFFGnzrSO8Vtgex5hkQ84mfxQ/yg3?=
 =?us-ascii?Q?ToR+job5P7sPTNKAf5nm9783J853RCkFaOUDzdeueb/fUwbPuxBOgbZYPba6?=
 =?us-ascii?Q?86ykXqYb5NpX65GfmasWJBFbtY4uQQYGiY1j?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:08.9411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a63062-e364-4900-aa50-08dddea3044f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2043

Inherit image-artifact-names bbclass in zephyr-image.inc and add
image artifacts to output generated files.

Also keep old image artifacts nomenclature in do_deploy task for
backward compatibility.

Before:
zephyr-helloworld.elf

After:
zephyr-helloworld-{MACHINE}-{DATETIME}.elf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-kernel/zephyr-image.inc            | 37 ++++++++++++++++---
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc=
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
index d6ee21f..15891c6 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
@@ -1,29 +1,56 @@
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
+    # Keep old image artifact nomenclautre for backward compatibility.
+    ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.elf ${DEPLOYDIR}/${PN}.elf
+
+    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
+    then
+        cp ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ${DEPLOYDIR}/${ZEPHYR_IMA=
GE_BASE_NAME}.bin
+        ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.bin ${DEPLOYDIR}/${ZEPHYR_IMAGE_L=
INK_NAME}.bin
+
+        # Keep old image artifact nomenclautre for backward compatibility.
+        ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.bin ${DEPLOYDIR}/${PN}.bin
+    fi
+
+    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
+    then
+        cp ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ${DEPLOYDIR}/${ZEPHYR_IMA=
GE_BASE_NAME}.efi
+        ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.efi ${DEPLOYDIR}/${ZEPHYR_IMAGE_L=
INK_NAME}.efi
+
+        # Keep old image artifact nomenclautre for backward compatibility.
+        ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.efi ${DEPLOYDIR}/${PN}.efi
+    fi
+
 }
 addtask deploy after do_install
--=20
2.34.1


