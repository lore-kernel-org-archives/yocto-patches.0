Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B4DCA0EE8
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:55:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.56])
 by mx.groups.io with SMTP id smtpd.web10.4395.1755230100197018585
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:55:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=m8UXcItp;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.237.56, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9TVi1J+lGDLLC10p8Cki5pD2E6BUzHFTGt2YwcRn+5Z/3rUQexjRU4dwAoBGE1YqmRytnd4pYPwe9MeR1K565Q2fPaiX0ex8NyEozoLzjhQcvQ8chMdB1r7MlPl05ta2PZHZlMYXdlbPLNM3y28FsZ8tyogKonmUHw+aATJcLHSb5KfTdfieYW0ogDH2BTN2FoWw1pdpqESkJr7hI/iGdRC7VomFspogw6V8vuNs2AHdyPzBI+x+kxl0HiYv+Ze83aIWiCB/mJutpJbOMOUAZ1D8YhBCGYoFrCyKEGQXD1azRtl9U6W9U4F5UbXnHvjBYil6fy1nCLM9+tlXsUsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gZi1r7FStJOP+3dLMw5owNkZrCoXs5WJ3/7NeQoC0Q=;
 b=NJDhw1fbrXayajejV3QEbH94laoEu+jiAAfJMXmPW991xqMPdOhZAU0BLtow3o8r1W82yNibTF0vAQbHgipBw6IPta061+3SEMp9940jgFBqBdPI172nOGdVDjUGAS2iPCEallWnZw4SEmv7J9WiH/xX3fTT6BJrKhSlPOfmDGvV8amsCNLn2IO1hpF6eXCOYzJoIQU5ZIoxP6gCNrUNvjFlE1PZvX4S14HW9dljf6riuSNLGsc7eSxdOj8EkIgKdgLA0pJx8H9qUu/UOJxvg1r8q4prrGBrISvnDnh4A5l2O3HenlE8LYWX0Dqe6HsxfKT4f1YHiO+bfFsUNQwgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gZi1r7FStJOP+3dLMw5owNkZrCoXs5WJ3/7NeQoC0Q=;
 b=m8UXcItpvv3NwZyuw2YmJdTKge6v9nfADVdZFwP5NyBq3Yvc2w8afpWHXSyLXJppHneSL7GeEh9RACsUU1yu2Ro0HhH2cvX1rWS5/K/iXD+pZQH4CU47QICgl0if5wyNzXB92P09XjcR3vzysHJzSIrYnXE4s+JmtQG+rvinpGI=
Received: from MW3PR06CA0018.namprd06.prod.outlook.com (2603:10b6:303:2a::23)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 03:54:56 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::f5) by MW3PR06CA0018.outlook.office365.com
 (2603:10b6:303:2a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:54:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:51 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:51 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 03/12] zephyr-sdk: Add new inc file
Date: Thu, 14 Aug 2025 21:54:40 -0600
Message-ID: <20250815035449.2816001-4-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: afafbaf4-fa80-4a2e-5130-08dddbaf7f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?a6g10J2JIv0p6J17Q9uVxyvABre3EJFyZ9fovt/w9i2x/gxEJr6LcNSnyCsr?=
 =?us-ascii?Q?wLKZYzF2Uy1L1HmTLS4Stdc5iuwru3FT7w5zyvKeKrVVmmox8CSglg0IQ4nR?=
 =?us-ascii?Q?NpHzFhbf0J8njgDUDXCVInnOcPR19RfDGaTZLe8RyXaXCAo5Qy3LBu+D640u?=
 =?us-ascii?Q?bL4iziHkZjQ6XUs2SWk9Cb8LUXMxaWtflI7LxNH8xfH49tnUB9+xl7nXYWxD?=
 =?us-ascii?Q?5iOJ6yKVMpQAD816ZRtCFy0bPIeQMsnFAdlFIFk8Q+XXbkRv21+DhI1ezMSD?=
 =?us-ascii?Q?OFTUG3xS1OvAYc1v7iPksF9/27GF4xdH27bqv7n6tpP4eXBS85zUAbXief21?=
 =?us-ascii?Q?T2hoNNUgW8ewc8he4TtigqEvJuI5xTwr/H8u2PgCsWlJ//jXq6X9D2h0PZWA?=
 =?us-ascii?Q?Nrgo6taGuwuTwli1RYxPbovTEynTdKIZAVFbuNmvc7eX4yQ9mEnRYiosiSvV?=
 =?us-ascii?Q?Gj7+u8qb4M0X/cu6vbeS4Vg/2j54I0xM2oJtxDUWwLDR/XrbxazCt7/OGvbL?=
 =?us-ascii?Q?hsgIww/vMgHDxv1CWYdzfS9wj1bqMrM5xLrMN7JnHokWDaRMpLIz90NCB8dH?=
 =?us-ascii?Q?cWCtQyW/Tgf6Dg/njqYKUbCps+/11EjlMgJ1N4wg592EAL6pL4uWZDsW5fCk?=
 =?us-ascii?Q?IpyDi9o/xL5ET/PRd8sZ3UcZI2PN5eUigeQu8t8DAWDVsUWRLAT08QhNC83j?=
 =?us-ascii?Q?Oxnf83TQVaO9OO6NK++YzYQrvabMROLEdtZRxsSqXYc1TCR8vfNa+NS+uncw?=
 =?us-ascii?Q?ShYN/5ru12Bw7zjiOxqXewou/OC2hPegXQhsQZXAHOdA+8n6vKMH8Fe2Tj51?=
 =?us-ascii?Q?4ZpsJT34rr6i2v087hLwuRer4vRf1wRY1qs0bJxmwvFdwePV7vDjInx3wJ+f?=
 =?us-ascii?Q?5ru4xLBr8o4zes/u6eBS8DSHDl2ACXHQNfKWGPJ4tY8VhWuQ4PmUQzrqyKXJ?=
 =?us-ascii?Q?1O2Yo0klzwe/kP/P0RZ7KjZWB11xSinvxBBjiuxtr/jJE/TajTyZ9/8SVBow?=
 =?us-ascii?Q?NdhmOdqBlt7Ysj38zt1n+OTNcCZUqeKgektMsVAtvRr/7MdP06jhptq8Xubq?=
 =?us-ascii?Q?i31mQZtxvptWHu6H4qQtqEVTUSk6kJ1/GrYElo9WmB6Yj+XgAP+SIlFWCR/Y?=
 =?us-ascii?Q?L1APnjVfEnLECe8qg91MJxzmIKqSVsALyj2ZyAaFhphJR6088ZzWuJ0Xa/2n?=
 =?us-ascii?Q?OIciKSVoBr2QpC6B/tFaKgg4+Y9+qST2FBvgAcHzh4Jj6YkAhVcz9mUe7OXF?=
 =?us-ascii?Q?XgjJofLxamCft+06y1xYTrBD3iPEMqtjPZl2dENxVabJpGBTgQZWChURMMwp?=
 =?us-ascii?Q?sPL4nVWlHJ+qRTPCimd6I28ORfWvVK6dciAi736TGNlIA5G9pDqt5d7hWtm5?=
 =?us-ascii?Q?yP2/Xm5Og6/yyUMv4gS6pQKIoSVuwUGZGGiJnGMRHeGNJWykOfDdCwspwPGG?=
 =?us-ascii?Q?mIBaNc4LR2KE4fSVPwEEfiJzRXMnHFc85ogmFWChAjc0tU/JJ7ZXkjTywAEA?=
 =?us-ascii?Q?nZXspQDbI6Yo9B1Se+xmRArMErP/BTH8vW5yqbuEYDekywLn30PehWpk7Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:54:56.0610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afafbaf4-fa80-4a2e-5130-08dddbaf7f82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:55:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1994

Add zephyr-sdk.inc file and move all the common sdk implementation
zephyr-sdk.inc file to support multiple version of sdk.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-sdk/zephyr-sdk.inc                 | 35 +++++++++++++++++++
 .../zephyr-sdk/zephyr-sdk_0.16.9.bb           | 33 +----------------
 2 files changed, 36 insertions(+), 32 deletions(-)
 create mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk=
.inc

diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc b/=
meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
new file mode 100644
index 0000000..4ef45ee
--- /dev/null
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
@@ -0,0 +1,35 @@
+SUMMARY =3D "Zephyr SDK Bundle"
+DESCRIPTION =3D "Official SDK built using crosstool-ng, distributed by the=
 \
+Zephyr project"
+COMPATIBLE_HOST =3D "(x86_64|aarch64).*-linux"
+
+LICENSE =3D "Apache-2.0"
+LIC_FILES_CHKSUM =3D "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=3D89aea4=
e17d99a7cacdbeed46a0096b10"
+
+INHIBIT_DEFAULT_DEPS =3D "1"
+# CMake is required by the setup script
+DEPENDS +=3D "cmake"
+
+SDK_ARCHIVE =3D "zephyr-sdk-${PV}_linux-${BUILD_ARCH}.tar.xz"
+SDK_NAME =3D "${BUILD_ARCH}"
+SRC_URI =3D "https://github.com/zephyrproject-rtos/sdk-ng/releases/downloa=
d/v${PV}/${SDK_ARCHIVE};name=3D${SDK_NAME}"
+
+SRC_URI[x86_64.sha256sum] =3D "9b4b96f8df594801a84fce1aa112a84cdfcd430efc2=
a74229907b6421fb859a8"
+SRC_URI[aarch64.sha256sum] =3D "a8c1731ad602553304e539a7ade9cdb34caabc1850=
d581585cbba0372a7493b2"
+
+do_configure[noexec] =3D "1"
+do_compile[noexec] =3D "1"
+
+ZEPHYR_SDK_DIR =3D "${prefix}/zephyr-sdk"
+
+do_install() {
+    install -d ${D}${prefix}
+    cp -r ${UNPACKDIR}/zephyr-sdk-${PV} ${D}${ZEPHYR_SDK_DIR}
+
+    # Install host tools
+    ${D}${ZEPHYR_SDK_DIR}/setup.sh -h
+}
+
+SYSROOT_DIRS +=3D "${ZEPHYR_SDK_DIR}"
+INHIBIT_SYSROOT_STRIP =3D "1"
+BBCLASSEXTEND =3D "native"
\ No newline at end of file
diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9=
.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
index b749763..ba20341 100644
--- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
@@ -1,35 +1,4 @@
-SUMMARY =3D "Zephyr SDK Bundle"
-DESCRIPTION =3D "Official SDK built using crosstool-ng, distributed by the=
 \
-Zephyr project"
-COMPATIBLE_HOST =3D "(x86_64|aarch64).*-linux"
-
-LICENSE =3D "Apache-2.0"
-LIC_FILES_CHKSUM =3D "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=3D89aea4=
e17d99a7cacdbeed46a0096b10"
-
-INHIBIT_DEFAULT_DEPS =3D "1"
-# CMake is required by the setup script
-DEPENDS +=3D "cmake"
-
-SDK_ARCHIVE =3D "zephyr-sdk-${PV}_linux-${BUILD_ARCH}.tar.xz"
-SDK_NAME =3D "${BUILD_ARCH}"
-SRC_URI =3D "https://github.com/zephyrproject-rtos/sdk-ng/releases/downloa=
d/v${PV}/${SDK_ARCHIVE};name=3D${SDK_NAME}"
+require zephyr-sdk.inc
=20
 SRC_URI[x86_64.sha256sum] =3D "9b4b96f8df594801a84fce1aa112a84cdfcd430efc2=
a74229907b6421fb859a8"
 SRC_URI[aarch64.sha256sum] =3D "a8c1731ad602553304e539a7ade9cdb34caabc1850=
d581585cbba0372a7493b2"
-
-do_configure[noexec] =3D "1"
-do_compile[noexec] =3D "1"
-
-ZEPHYR_SDK_DIR =3D "${prefix}/zephyr-sdk"
-
-do_install() {
-    install -d ${D}${prefix}
-    cp -r ${UNPACKDIR}/zephyr-sdk-${PV} ${D}${ZEPHYR_SDK_DIR}
-
-    # Install host tools
-    ${D}${ZEPHYR_SDK_DIR}/setup.sh -h
-}
-
-SYSROOT_DIRS +=3D "${ZEPHYR_SDK_DIR}"
-INHIBIT_SYSROOT_STRIP =3D "1"
-BBCLASSEXTEND =3D "native"
--=20
2.34.1


