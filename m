Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A64CA0EC7
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.46])
 by mx.groups.io with SMTP id smtpd.web11.36466.1754869166679676731
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=tGL3Q+Y7;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.220.46, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpO0i+W8Ne4kxP7lEyvZIRvlEiprFPVmOyD78fuLgRoQu5NNTstML/MgM9O/aetJcPlbaLFK1KlJVCmOFskfyRBJ0Z3xNCR8av8MKMVxb8B4LKGA3/RrPrgBGVe/50sTSrOs8Of22YjrGyni3O4yFFVD982tYQWCM0NaXijn0g110HvAQ5Nsi0V3/X51w76cvU8g2xWSry0cG92lcRIM1yPMthxMKm/6e99BNNt0rViRXP/wrnjbFtuT2cCfutcGZq7JhNVrlscs0K0ONjSW/sisPMKTopapWYWFM/o7ft2PO/uQj2f6XX3bqNo+2+3Soj7gLoYSobSeGvcy+AHoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow8E5obRKYC4wBzHdGz3sOZZcV8JmzEvAwOctX0166E=;
 b=hYh33QAlBYaq2oVRIl0O7nDpnG1UMyyKc8hARBeuF09axlUz5JMjQOIU1OUfrI3imU5wWlGYIQefKp80wWZv+C1WNPs+HpVjXLhfuwflHKa2XbNCXm3nwHHVyIIfDm/TxXwwiaY8Y8yx4kXXFFVVfi1cSJBmucrAQfHWl1wtBkxYnsduu+Dk9XnQ0jUS9jnx4WgvMAIsUW+eLfrL40PKH4DjNBYqeYj3JIPP6Mxl4RBlSv//vidSdeMoj7MElIKrmx2iyjJG1i5eEA+dUY+vgvVbE/YDI342QOU4QS2Ly6hHocxe7X15BULkl9Nn6PSFR+2b+UNVN+simdO6/M8pWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow8E5obRKYC4wBzHdGz3sOZZcV8JmzEvAwOctX0166E=;
 b=tGL3Q+Y7kB+VDd0Wcp4NfuXzuhqn+4zcEITEOY4Q1WW1cQ4R+QogkafzDZEY0aSRq6sFA2UyhyDG8R20Pbjo9IiMaiHjqHAAp/uO/3gJJ2QdSJVoY1O0YOK5/Ro3IRwQadx0sfwtMs6/P0vyfjRf0GrQwVWJ9hzMLAfD2fLmIVo=
Received: from DS7PR06CA0032.namprd06.prod.outlook.com (2603:10b6:8:54::17) by
 DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.16; Sun, 10 Aug 2025 23:39:21 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::17) by DS7PR06CA0032.outlook.office365.com
 (2603:10b6:8:54::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Sun,
 10 Aug 2025 23:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:20 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:20 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 10/12] zephyr-kernel: Use relative path
Date: Sun, 10 Aug 2025 17:39:09 -0600
Message-ID: <20250810233911.1259884-11-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
References: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|DS2PR12MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 7058806e-05ea-4492-e5f9-08ddd867214b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?c0feUh8O8wbRDZW5XpiM8Hmf2IR7+6wxLd8a1qkDE7f7OqjCFKZOr58n4BTJ?=
 =?us-ascii?Q?ib00WPDO9LA9QoymrSrMAUWUP6RuOuoaJPkKOpTM1a+P3lWAPQWVpUliUnc/?=
 =?us-ascii?Q?K4QjZIMvexjJike/D9DLjPZFAUApcqylQ9hfkPTN3OWeONs0fxOBNYWNzFuU?=
 =?us-ascii?Q?VIzFyzf9biOzGO74ZJktmkLK+9POtkxxAbxbM0tVNlljL4OaSsmfnl1+zgsb?=
 =?us-ascii?Q?Fl0UhEhfKL67qcNuwKyJnOHg6Qr7emOUjwqWCPSYSpFbkf+x8PVMVgnSD3fx?=
 =?us-ascii?Q?12u/tA+E2MrT2kjYt+czAe7fpzz4VykcJdCcAxDzkiq/qBYNE0yQrbgKPeyk?=
 =?us-ascii?Q?QjRM0pEGgZp/yvIteWgfd78BfAC6wP4KkxD3wz+X9ZJa0D7tAq25nhZmPzUt?=
 =?us-ascii?Q?TLLaHwGXJSYs25605aMxRRMipgxD6leenqDHsqRNKa88Fm4es7p/vGMc2vR9?=
 =?us-ascii?Q?puU1TJYOlWjdDSjVQgbyJi4Kv8QmBRvUgsoLm+RYaxFa6EhhmruqRz7Vkjy3?=
 =?us-ascii?Q?V0trwis+toT/0+3c/YsVZdYtCSIooLDezMYvSCGS/2Vod0zFVhCSRRiUimXa?=
 =?us-ascii?Q?67I5bbyhkPxLDIcHYv0fnSRYLGZAfjkZOq+6BVv0RABX7J1oWQiby7k5y6/h?=
 =?us-ascii?Q?6bwFHq7g+r5pax7YZpRyzw3UwS2w6CoNaqxynt2/vGOJA4kexHorAvGpPEz8?=
 =?us-ascii?Q?PRqM+kuM7MBCMbPbKiOpV0MKqm1U8lQd8fSQdrzz9nBusbHv0V0smQcfWLVq?=
 =?us-ascii?Q?/D6twtdLNZq3edwouZSvQul1utSPAVA3+byvnc+RVLIUnF2vKKaF6tnSnl/e?=
 =?us-ascii?Q?bsMsPpeCLLB1G5/4Vv2VhVhcnDQc/Oh5REFFyEnosNS+zbfGpw5/2w6IBjS3?=
 =?us-ascii?Q?TMsEriOchob8y7szBmVyQ9TvEPolGLE0Bx9OJidfXKHxXylUdte/8iHHlqOE?=
 =?us-ascii?Q?3eo/eKszNvtimqUjUuw+2uimhdITLmDydepMTFAggPawkXQrq1+QsOf6GcHB?=
 =?us-ascii?Q?Fg8tQs0hgi6qj19EHpgm4ddTSBgSh7ydHd2P7717PdZ0rG1s6Iup8C01L4ID?=
 =?us-ascii?Q?zPIhxDISnTJu03iOdw8Cy2HqaFEVnHL0/y8cdWICVTVKQLfzXmrtM6XSf482?=
 =?us-ascii?Q?IG9Vw9RQn3wFYSIGhoQAxza6Vc9TA17uu3GvwCGQjZ0E08GV3h6p8ORyTw3x?=
 =?us-ascii?Q?fCyRcevBgKRm8g6tqP1bfvBS2QInfI3v3eU8t/enAIiIubvd8lc5W7WWfoBE?=
 =?us-ascii?Q?u3Zz/L6ESN4uiWWMMWncavQk34mtOZFxlLlKomL13oV7MSdUwNWoJvyP6zry?=
 =?us-ascii?Q?S0i/B89hJXs3wksWPR+JcZvpWLJkx8rtYGp0Gzy8gmOkcH0ci6kt1evKkQU2?=
 =?us-ascii?Q?Zl123YQ/oBSVd4JexxWhEEkZlW10l5WdprIFiOWCe7SoOXfZKS3uk3Ly8pk/?=
 =?us-ascii?Q?vb/0fGOUfM0M93byLr8AcIV3lvz9DE2I39H52X0F6neGJLyHFuoY8cnxdGaY?=
 =?us-ascii?Q?4v7o7DDfv24inv/eqC3USs9T4nVAchnY8sy4?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:20.7451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7058806e-05ea-4492-e5f9-08ddd867214b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9750
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1916

Use relative path for all the include files to avoid overlaying the
include files.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-image.inc             | 4 ++--
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc     | 2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.bb    | 2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb        | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc=
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
index 93d36b1..ca728b9 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
@@ -1,5 +1,5 @@
-require zephyr-kernel-src.inc
-require zephyr-kernel-common.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
 inherit deploy image-artifact-names
=20
 OECMAKE_SOURCEPATH =3D "${ZEPHYR_SRC_DIR}"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-co=
mmon.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-comm=
on.inc
index ba70a29..5191b9a 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
@@ -8,7 +8,7 @@ inherit ${ZEPHYR_INHERIT_CLASSES}
 IMAGE_NO_MANIFEST =3D "1"
=20
 ZEPHYR_TOOLCHAIN_VARIANT ?=3D "cross-compile"
-require zephyr-toolchain-${ZEPHYR_TOOLCHAIN_VARIANT}.inc
+require recipes-kernel/zephyr-kernel/zephyr-toolchain-${ZEPHYR_TOOLCHAIN_V=
ARIANT}.inc
=20
 ZEPHYR_MAKE_OUTPUT =3D "zephyr.elf"
 ZEPHYR_MAKE_BIN_OUTPUT =3D "zephyr.bin"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-te=
st-all.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-tes=
t-all.bb
index 85efd24..d9dbb40 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.=
bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.=
bb
@@ -1,7 +1,7 @@
 LICENSE =3D "Apache-2.0"
 INHIBIT_DEFAULT_DEPS =3D "1"
=20
-require zephyr-kernel-test.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-test.inc
=20
 addtask testimage
 deltask compile
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-te=
st.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
index 2918d2d..75b1757 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
@@ -1,4 +1,4 @@
-require zephyr-image.inc
-require zephyr-kernel-test.inc
+require recipes-kernel/zephyr-kernel/zephyr-image.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-test.inc
=20
 BBCLASSEXTEND =3D '${@" ".join(["zephyrtest:" + x for x in d.getVar("ZEPHY=
RTESTS", True).split()])}'
--=20
2.34.1


