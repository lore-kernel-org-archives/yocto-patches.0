Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F2ECA0EC1
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 14:59:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.73])
 by mx.groups.io with SMTP id smtpd.web11.49949.1754924396374199097
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=zr7z8JP+;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.223.73, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBwNzR2FPqmKAA3Jnb9Met3fvWrADE617GB6Jc+EeAgkMzIzu4VPmkH+97cz/Wo7qgfL0bub0+D28AE6e0p0obQEoMfpPRKyhy5ec9atTbHyArHf/u8tK/i1gRe9mNTuT5pNrAhhp6QQr0A0vfZuG1Nihsyg3lgiQR/sjZtxBQrizr3WZMUTCgmT08lSGcZCSZBkvEykB7PjNwjNoMztCMflJX4zgUdVJFekadHRhCPv6Xwt6NCTwb3K4cuqLHqnIe4J1y7swRoHYJNdJSEAlL4uZIqPXyM3u6f+G8Bpdp58/1KAOq90xJcZOSV8xLgbJ2Ex5+iggtv8aDqIfZCVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=libHPKrEdGkJD/iLYxKCQC1M2iEgtoZDf4BbATkOwjo=;
 b=wYPvii1ei60ZrPBMH1YfokQgD3EEz/enAMorqn3gxevM8LS7ACGmLr7jqjZMgZBgPfqjaB6RedAvBwYjTaGpVyeaDIOf1UyTDUs7vcWJGY1ZpzU89/Pz4RsOFox5vSLflnuTwRzffMNpjVxHekO0wtQCk8YMkibTXcYQXSfgp+VubKjghmrnZ3CxSYrVFrCDG4fmfOVZJqLGiqUN/Ds+4im3FY4wY/b6jokH7NfS2YIWosldLcvrvEJG4hkI0rBx/xEOgGsk+NLkN3b/3U82Xz6SBWBDJSGX9j7LXpAgANb/u2shNPjBG1pBZL4bFTxZ7gK+o7I6mlieCoFlOajqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=libHPKrEdGkJD/iLYxKCQC1M2iEgtoZDf4BbATkOwjo=;
 b=zr7z8JP+KDkiAddiSKXeKWkgNMsdZSa1dqyPT9mvaHLGxdQb4z0uftAVXGBQaIpwnoNO4QKgeSQY26K3EJCM0tYHUkcX0a1PsINi90yLTHnbxZ4FSYPzU3XKG8h/p7ZlZGjRn1JjogEHM3bkWXVjJfWUrsJ396AE0xrmYyBZVac=
Received: from BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:51 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::69) by BL1PR13CA0266.outlook.office365.com
 (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Mon,
 11 Aug 2025 14:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:48 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:47 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 5/13] zephyr-image: Add image artifacts to output files
Date: Mon, 11 Aug 2025 08:59:33 -0600
Message-ID: <20250811145941.2553838-6-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
References: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 605d3292-377b-4308-1b1f-08ddd8e7b92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eRypSWL4ia1cNFtZAhyfPZhvuVJSFKRJoEqMr31XfRnh9s3dMYC1egTRCDtc?=
 =?us-ascii?Q?2TopYnlDCac6Xat0e430INxJlAfNEXZWY0mAccjtUZ09DQ7Xk574bCDkZafU?=
 =?us-ascii?Q?OJl2w2l8QXwtt5RyR2rVLJuwnvaA+XkN/IJKBC6KuP+Z1uZO1Yc1n+EduBsW?=
 =?us-ascii?Q?sQR/tmX9RTmuxvAwxc3ylm7TuGWn/WQaZOq0/4ilZ1yd9XL7knU+ATAXFUMx?=
 =?us-ascii?Q?vmsqkS7YFPetCscybXu5Z0Tciur9bzGVzu9JdEgWquJGShTlS4dq4Ra+PS5j?=
 =?us-ascii?Q?egp/v45fY3CrnKlvIH53KidnSG10WXyHIvNBxbDl4Ti4qW2waFvxZSkShEHI?=
 =?us-ascii?Q?IUXK2DD2jrnMlhJELnp8fhl5N85n/bzQBuEO7jP+YhsbpIb+M+suqXCV8MFf?=
 =?us-ascii?Q?52QXq5rchXiCFrlqNDekfuwdWJUySzXTP0hiY9OPfKP6rcLbk33V5F5FzAEJ?=
 =?us-ascii?Q?mOMxHpjxJcS9RDucLBl9nFsiVYyjF9Lxb25bgKbZO2agPQqsnZLXvnNW8jMu?=
 =?us-ascii?Q?KpimqolheNc0NxKugnc3mCWSNY+E3gqEuMMkjW6BVp3NbGeFVlPUd/choZKx?=
 =?us-ascii?Q?zMgvhUtBrtf8iglMNgBUbYWOts7q9awiuxX/1rafKQx2uR0VyuetuITc7Gkq?=
 =?us-ascii?Q?NFOHxGpR3kSpNpU6d4btIzFLpPybdUH5EHjYVcX+EEUp51UflMd+Opkar695?=
 =?us-ascii?Q?wv4fA+8kJN314w5DV11tY8q5YLyDwLOsEhjkVUqNhxhdOZXHNCRnQq5f3ePe?=
 =?us-ascii?Q?0AjysyReqIHx5+39QbzamOH8ngq07CTkOBSlmlYpwbQnDXHfwiuVCz2ftCBJ?=
 =?us-ascii?Q?hLYtytqwuvPzZH5HPoxPljn3HuoXtvUyLWazQRaG3LCJ12vHpPtjG1wLDFKD?=
 =?us-ascii?Q?y3fIhAERdeiMQaqCaTU9DpaBwp0bpzSPF6HIMs39ktZEO+MlJL0bHaKjBnok?=
 =?us-ascii?Q?91WUe9RQ1lal5QTNg89XLQMqCFZxF+XVgRDl8n4BAP7BRCesv+/6UFDu/1ZH?=
 =?us-ascii?Q?FoMmkeDvxKDKL7l3d3Y2gEAhPgVp7JU0eiYUvEVIes0g8Vtj+SwXXz2iMZXR?=
 =?us-ascii?Q?qVhV0jA6Ja7bFAmcOyKs7KTBZXa6o0EzpDmXhxBgu9gPbj88eDayTnbmWAKW?=
 =?us-ascii?Q?elePIsc3oX6DuLbSRxzPnDsefRyCJHDVl/9W3TwNOdk9AfcLy85XbvDu+U58?=
 =?us-ascii?Q?42Yc1Are6HBz6UNyFMW/jv/W5vDTtMG17+tVwEcDo286tWHiDQ/Pokyg2lvO?=
 =?us-ascii?Q?aWKRnpIAhQjZ0MUckNycLG1Zov6hWvvscgV5xp53gTiEUuceOzNEEmcUbeSO?=
 =?us-ascii?Q?hhVoaNVSfDW1KR9V+n/bXmK/JX/PjlfJ8HNnfiDfpWHKzgRSNrtpfo1YPbT8?=
 =?us-ascii?Q?XuD9ManHVxbE3E4YBbL8OLMqMo+ExcwXyKzH84Kfo2eHFwVebsuLiFlawt/E?=
 =?us-ascii?Q?UgKY6tcJurzWxJ5LiJRWSfbAKOn9qoz0nN5AZDexqEIWmC2ApjwBY7+fC72l?=
 =?us-ascii?Q?NcYCyTZLQAX7FIp+BvMtBRDWQTw6AcvKoeDk?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:51.1751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 605d3292-377b-4308-1b1f-08ddd8e7b92c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 14:59:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1938

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


