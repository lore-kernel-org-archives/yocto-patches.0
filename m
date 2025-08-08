Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49325C87FDA
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 17:58:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.63])
 by mx.groups.io with SMTP id smtpd.web11.29082.1754675920792125995
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 10:58:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=fKo3+Jdn;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.63, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeAuvUWyINCsWr76Owf9V9/doNeW/od+yyFZ8ZTLgPSpT3fnqYLke7UVOp7CHbwnQ5oDkD6CMDTfX6xCiJ0pLlUe2l/bW2/2JRmwjn6Ftw+E7beIR9QFGfv+9e4y9+O1fzyp9aDOBKbJIl4V9SWy3QhtI5oIN4/D3CFM7T5wa+3cK80S0P/AaOf/Ho6rDOyC7rKrf1sc5knf1AP2XBEP8epsqX3h6+ejwdNwDG7xPb/7IsqGsd6WH2pf+zrgas1CzUgwTRYjKVMdXJTLdtrmpJkDaSGEfq09mzNhbm5I5pYPI3vZnFrY6G9IemR/hoWAIENqBWvMtP5xgDTULP5dog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=libHPKrEdGkJD/iLYxKCQC1M2iEgtoZDf4BbATkOwjo=;
 b=m9WVyhpoiBSONSeslm34SZ+LTg3H1VdZj/Teo0ASlCuiBSI63TsrqmvY/IjGlNGJIWnnIW+cXX1sT1msrcip9dK4p+r59Wzu9AZf8NjOZHapjlh4jKE3cZGxBoPaX9aOdwA/qN5zJc5IXa+4zgO98L/DulD7vc+HFLYG4akW4VSDaW6qqRK3mH36XS9Blv48ld24AbeSSk28T3C2OkyuZMdXQdKY6C3/q00eDpnaA787TN34NF1aMpFUedXNLQYWg5t6X26pR2+y4aljDOi4XCd6cMr7UpoxtEkwziNIPMgYANh6WHv4n3VYDlN9fySzAZCilYekK2Mw21+peEsZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=libHPKrEdGkJD/iLYxKCQC1M2iEgtoZDf4BbATkOwjo=;
 b=fKo3+JdnXnx6fi1g8f5DjghcX8VlDhYi2ZirtdzpgvYIhdbGlNfdWBo0wjK+Q5mzsy3wgxmmxzZ6t2K6tCLBPbA0K8YWnWRHGcE8JB/YEo/SxXOr53bScBDngPpNp2IAoYTTG0YF0dC/poFOCSTb4fs8PB5NBRR8uzpNUcKXnXE=
Received: from BYAPR07CA0097.namprd07.prod.outlook.com (2603:10b6:a03:12b::38)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 17:58:37 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::87) by BYAPR07CA0097.outlook.office365.com
 (2603:10b6:a03:12b::38) with Microsoft SMTP Server (version=TLS1_3,
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
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:32 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Aug 2025 12:58:31 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH 5/9] zephyr-image: Add image artifacts to output files
Date: Fri, 8 Aug 2025 11:58:25 -0600
Message-ID: <20250808175829.3830489-6-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
References: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: d2c8ed43-b68c-45a7-b304-08ddd6a53271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1bqKw0ZXODAC09pDaxtv2zBIbf2R7o3sWsQ3Enq2DrqcMKb/ZpzAjZh3RtJa?=
 =?us-ascii?Q?8/ASGwVayBxVDMXHpHPrqrzIXqfcdFh2joMJcKb08tsd2iBxHaIESCoYYuSA?=
 =?us-ascii?Q?g5zxL+xjC9cTESldw6mRanbXw/KuVsEW0q5s0saMUXEj9CPYLfPdG96qFQ8U?=
 =?us-ascii?Q?RPvGKJR7G1mEj00K1qWD7Sok1TwIGFdWvtidNmUtddLw5wfCtJp3M0okVW2Y?=
 =?us-ascii?Q?QBwVrMcdcg9iUXjC2LOoKwleXHRHu5SS/dJJoLEv7Qwn46TDU92m8UHIajBa?=
 =?us-ascii?Q?Oyh9BLEr6x0ql78mNJ6n+PpFjHijIH+BVHv7LNnPAZzfLGI/QEuIIL0LjuMB?=
 =?us-ascii?Q?OFrTmLlJymsyNaVxuRT46kUe9Hyiy0u+ZR/0Y8XBBqO6oS+7+nLJ4w4Z+yny?=
 =?us-ascii?Q?NGGIll9qv0forzs5JlmCcur8TZha4DcEMVYB5A5/rGtEcrfzJYTKx6N+8OeM?=
 =?us-ascii?Q?qBbvOV38fh/cQuZ1c3vrCoZTdUovkycFDb9EN9RjBE75IZtLchQmg4ZxYDSq?=
 =?us-ascii?Q?fOaAAzdExyAuoCJqJIsU66L/d6tUylNleY1dElNFJBfuH68SixDA48CXhlW8?=
 =?us-ascii?Q?vWAYLHMW8c81kFoYlB24mqYwx5ftXna1QlVEjV/x8d7Vivxzbyw9YkrRKJf9?=
 =?us-ascii?Q?3Lc7DcNSULXDezRCNSVhzM2BdMEkEQEcCyQvSq0CpCGPmqu8aMhkICzqADS9?=
 =?us-ascii?Q?rDVXjPzmxHwn8Z3VrzffaZkNgSOhY27V/4h172rNox5eE4fE0Be372XWFMLP?=
 =?us-ascii?Q?kJs80REsXLNxE9pMbBq84oDdo8LS0wDFkWblmAYqjAQAqDokwbDRvzimzQP2?=
 =?us-ascii?Q?0rb1/BAeJyvoCfXthIIISZ0lwvSNkCRQJ+ds8eyRqjxfvYlyaeDPIw4bNWS3?=
 =?us-ascii?Q?fHW1/Te6BvmMar0hGye7h4hq/Iw4rC7E/n6870zgrE+0pFNqtqh1x3Y7PNtl?=
 =?us-ascii?Q?KWWUHukpe2HD7B8mzQuhhSSE8JZz4oB+zYd/TWg//yvO/hOsjhHBE0mn8Rkw?=
 =?us-ascii?Q?S2qU1SWjpdrV/t6XFD9eFdQmC/vLO/PKJR6gzc6UKAhgY9vN8plRhX3ACpRG?=
 =?us-ascii?Q?BD13PRfIRm3DDb+dEl0p5q4t9gFA5i/Wnzu/tFHBIEZsyTau+kcY2OHMT5nX?=
 =?us-ascii?Q?FcCdmQ+JXsLTuiQz/70iL8GSBLTu/5WsB+r2tVBPju48qqndJqkNFM+Zbm6f?=
 =?us-ascii?Q?SeVUJXk4xp5aJD4+3kNTRWsZoKHsm/HC9GrJ0dJCkK7f13YnRQGC76YNXJVP?=
 =?us-ascii?Q?EMO4Rnhy+qrfJ+bhS2JNAOqXEZB1ZZP7czdsfoUV3eEo51e5cyR/UH8Vgb5X?=
 =?us-ascii?Q?IwhQx2PvL8aJfsjjZkfxXX75eTyDW0b0LxjDVw8XnAai4vWD4SNpGZjE5mzw?=
 =?us-ascii?Q?2pGOC8Rk8EI4+wvHJ+LlAMIye1mM2FKjE0nKx9D6k/yG5kVuUPV7dCF0rpII?=
 =?us-ascii?Q?DUbFnXtiN4BrRZgv8DMqqkpr3VFR3M+56OL3SXGGhro5eHHw99AjqBNaoy+R?=
 =?us-ascii?Q?ZNAMG2rcjV0wSgYSAhMcz5wvb00XBQi4QPBj?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:36.0000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c8ed43-b68c-45a7-b304-08ddd6a53271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 17:58:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1907

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


