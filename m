Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD492CA0EDD
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:46:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.40])
 by mx.groups.io with SMTP id smtpd.web10.57316.1754941613664410856
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=MXKZv5fW;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.40, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQkp6ZMY7997SY7VruYqtJQLtJwG96S56nFj607vuH6iBhFHumSNuq4Xu69/ghviRWyTk3DipNWkWhOwjA6TUd0SmSTSd61Dp9XIhPj3LKqt9/qgi7hc3fTlesUyRZk0/HulNnQmQjOp4L1A58QN+GqKHu+YXOkSa3kSiOTeabyu5Wf/gvTKAGsb/Ygt/t3Xpap4L3CZTlG6CBKCh1/d/vT9GpJAcsrMfb4VeSo8UUBmp+euNh3aOqD0MIifLsITr1z4ZrHMdqbzV7Sx8a38amp8q+oree70L1C9ihFGKIS7vaXQ9C11Nzz8XThJW6K/USQ9kXBBZpTX80dZqqbfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=libHPKrEdGkJD/iLYxKCQC1M2iEgtoZDf4BbATkOwjo=;
 b=AFoQMHmcaDKMLyfCp24/+CLcd6B0MTzbKLIe5LmVnqkBD0tkyBH1thq89XchvpgLBt0gtEChjK802FLGOxHlG3wzuX48JV/pfmFOdDpjVb89+80JS6pGYL+BEDlyrbp5nguECsPYbQAGUALKgCu8vu+UzVRXyOUjSVr1FunOm6ri2Qddl2pEKjsV9UwZ/K6gzUkvd1BxFaLrtKCELH2p310GdOg/g2iFtvNY6FVMzKS2L/fq1kt5o+r8mZMa0+2EFUImD2N4n7Yax3N9iQtS7x+h4kVkV3lFj0UQz2qtjwSByp7aSgeVrRjAuxVs0z3iqf/QzS2275ItJE/SGXHpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=libHPKrEdGkJD/iLYxKCQC1M2iEgtoZDf4BbATkOwjo=;
 b=MXKZv5fWvqK3Ebvocq9iBnYv6+HIC3//vCty2R/gtH5mgOBZb7MEEDm5PQNv9pTxai6BR0bRSu+hSevmZfrwxGVdVO1sClRrLJrSAaHWTxb8WIyxjYTKPLLDmz8jaWODy9Oym0edd7uSgrW9hzKbt0sOsr1//6pT+ej+vEOaX2k=
Received: from CH2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:610:53::12)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 19:46:49 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::a3) by CH2PR17CA0002.outlook.office365.com
 (2603:10b6:610:53::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 19:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:48 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:48 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 5/13] zephyr-image: Add image artifacts to output files
Date: Mon, 11 Aug 2025 13:46:38 -0600
Message-ID: <20250811194646.3408854-6-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: def76a07-ab9c-433b-92f4-08ddd90fd042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ty8aHzGgL1KFAm0Vsbvv/BNMEgUJixBjNaulcg69EFu/nTQ3t+1V/uAodfhb?=
 =?us-ascii?Q?v5guk1dl3oRI9phP5p3JDjj20n5zNGCPd97pD/H+zfgm5wQHLpiyAneZWhV9?=
 =?us-ascii?Q?Iiak51B+nWkN6MygvBWhyJ7DpDyZAc7+Lbtoqpw1LvSWVkGNUfFGQsNK06rz?=
 =?us-ascii?Q?G9BKyaqfiOfLEuQC+WNvMZald/fpn9I+a4CdMGftkNbvHO7EwG8P7P9eD2fG?=
 =?us-ascii?Q?92JyReT/K8M0BgJFvjXKxYjIDPnmY8cfpvxcjjnhc1tgUNJuKAmpeaRMVBp/?=
 =?us-ascii?Q?pgRyccN/txD7GwlawAKen4+44t6Gu1XiwKt3GlSQoyeLJX+dz4yEe1EJGtva?=
 =?us-ascii?Q?Djmd08ayxgDQx8HhSW7+0lg608E+aHwHxOv84OXdLbzHMGtuuHQLzo01e5rw?=
 =?us-ascii?Q?a5fChW6qznPFw85aS3hOZ7P4rrRcIY4HARukNEyJOAwQVbReDizUM9YcQv7I?=
 =?us-ascii?Q?Lf1iIYVzk4I7bAbVMfVKH0KqeL2zezlbNtF2B5eFRrZwfqvhKoQoHYqSgLCB?=
 =?us-ascii?Q?kJKUG9/SFM8/T4TcPVxCmOWlolCVsTZf3iB4EtdCWhx9oe9FgvCdk+UMosnd?=
 =?us-ascii?Q?zF63qkwiRfC+TsXQtUxieBa5HiDvps0EvoOK7K0aFY672K0+VpNV5qT0Dhcn?=
 =?us-ascii?Q?NJ/E4Msae6oG6sSdB8MIl5AZbyfqmkCw3YAHHYjfO24c6e2oqPyBOZPECJUo?=
 =?us-ascii?Q?gxt9MdkkfmIugCqyV3xVs98JbSW+1q3NpigNRn59eAQgd5t6/vZhTuymELLD?=
 =?us-ascii?Q?cxAnUynjbPm4OeWDge9JSQ6rOg/rO2BV9CllQAIV1ztOlK71mG9OL7N8zO8m?=
 =?us-ascii?Q?yRvuHDF5pdLryRv72Ygj3OxNQdpiRM5gjUEpohcPOy33lqcilpeStRdEMx9p?=
 =?us-ascii?Q?p+z0lCx+r++p1ARGg4e/+yvfsE88msv9/IVLcuTCAbJIMfargQhuBzPeiCkU?=
 =?us-ascii?Q?Qcyl/u+ySwCYuwNLWhsB/HEGcEUYRYlsv9JQmXNkR3FYtWXSfgcRsGdvdNVO?=
 =?us-ascii?Q?ONGvUgO+5Bu/KNjqx7FG4bv5i6wK6crHC92jnnF0cdZyimvDj5j7g6aHl532?=
 =?us-ascii?Q?ChZtSqlPSKdzrWR2/jH/yIJ5Zi9QG0wSHFpSraQDD2F02zOT1a0CtwRmZm4O?=
 =?us-ascii?Q?rGnilYi4mp91mdIpcGlprIuMFGZKZ30Zu+2/mNiuI6Q9qnmDXIr1OXVBG3QX?=
 =?us-ascii?Q?XfnPlSHz31k6MkJvC6pj4KFVGyIOaLuMt2s/e2FxLO2ZUoK5m0Ykfc/izTdQ?=
 =?us-ascii?Q?2+r+n5SGXGW7JVWVa9DGUE5jggy/cb9NZs9JRFHZN3eFkCboks6YxzjtY3oq?=
 =?us-ascii?Q?5Gp6TVnM1LL5cGw08E38vOp7B6Fdm9MVp9ZQP9jzIp9Xz6/u/noqgrSzXqbs?=
 =?us-ascii?Q?3rJAeCSOHA4zk5D7xSQX9FcZsK2Sx24UzzZ7cOtwxWDFWG1PLTyVqkTLBctc?=
 =?us-ascii?Q?edSigEGzht9lWl8zU6eOvz2udrZC8bhGAHVn5dKZBxH6jVPQYdudzB1K3gzU?=
 =?us-ascii?Q?luqqBSF1sdkX80CPKkApCrXO7C6TaglKoRgS?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:49.7689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: def76a07-ab9c-433b-92f4-08ddd90fd042
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1948

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


