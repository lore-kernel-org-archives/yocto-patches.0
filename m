Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30850CA0EC3
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 17:58:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.52])
 by mx.groups.io with SMTP id smtpd.web11.29078.1754675917251305909
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 10:58:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Am1NJHrz;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.52, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xe7ZFcPP3TRTLtQyKlFuXH5A/iw1YLYH45HSvWV2nIyjmc0bLWoHeEjlTNDOA5RhAqbZQGWIUwYazgTQN32BCIXKscZHx71FyEcVoW33rVfFLMnxwv8dP5R2jAcA9QR0lugLZ0EkDWp6UdsehYV1GtgOS36yV9ot1vp2C6pywd1ChqdYqW5chj2Bf/QwhbFoOpNweIKIbFHkJKDUQxX9V6/+e6EDbuWzi9BQHDFsa4Ku9qRPKwKr/ecT7VTO5NxePADnrgRpi7Qx8vL32J6D/q7nyfncb7aJZtydFb3YQp3XclrGbSQ2w18392kLLqxNIAsyInYpWkKir3Q22sA3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=ChZa5fu0e1j+ZNNqn57myC94TTG5Z5SKX5dKRVvXDjaLSdhSJFPV7e3HeUi0p9l7o4uOzjeSuO9N83+qYYZYIl1qU+hkubdfOzQFGlcQ9yeN3qO1wdz6KIH1DpSK7pPGaVMoxVC+pHW4YESIhvfqydaNEtutcgF6WfVTEq6Ii1ZI4v08Ye962F95rB+pxgA8j1ESyW9yj2wWHV6U46i1JMnzAuh5Q6oDxrZDNYFZOC64BbnsGCVrd8UUZ/RyE6NzfZeT98hpGGYSmPDPdPcZ4RvovvPJ5qmIdnWIAtkxLVoNP0/PwPhiDz2JXtNrdlA1lCCUnwbgi4Cr334XK761OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=Am1NJHrzFLjhZs9woD4BNu0x16SSJUxbp8kmyOFpYE4JfqXAGXVYUtJHC4taF2GAd0HytLo/uJ80HMq35fHQpEyDsSKwps/QqlKtR+57dmPg345b5+oDUxcgirqNwNqYEaBk4si4VjbYUlIWzzF9BKc0t73bcJSKxrfjROOgYvs=
Received: from BYAPR07CA0079.namprd07.prod.outlook.com (2603:10b6:a03:12b::20)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 17:58:35 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::39) by BYAPR07CA0079.outlook.office365.com
 (2603:10b6:a03:12b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 17:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 17:58:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:31 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Aug 2025 12:58:30 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH 2/9] zephyr-sdk: Add new inc file and update to 0.16.9 version
Date: Fri, 8 Aug 2025 11:58:22 -0600
Message-ID: <20250808175829.3830489-3-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: aafbf24d-e4f1-49fc-ee7e-08ddd6a53150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mwbQ49P8mit4pJ6T6wM6yVeEsBSnVW5al+2Jk0efcbSb2nlB2qev9FZsB/FC?=
 =?us-ascii?Q?hihJO3x0oIgFWUXbE4y3ruThBEMv+zlih3fRud2Z/zUqxn1fEC3vYEZlwIK2?=
 =?us-ascii?Q?jsq3mbZ++QF25DLeiGpWUsQEemrFNnGjoRbRs43JLWBT8WuxxHUfOsWeVSiy?=
 =?us-ascii?Q?yTOoTbttGYEHWc2lj9HBS1w5a/9fH/LRYHFwuVTE7UXEquOrCFPSGe4CBLf7?=
 =?us-ascii?Q?Bpq+uNm54jMBAcLHzf0Nt6Hvzk1gyJSONT03Sy1A5HXtmrgmpiH8y1N7iJcA?=
 =?us-ascii?Q?dFvtlXzQtY5G0WP9rINJ6RQta+ofBFLG7JVGjQgRoI+dESYqE+2kd1s2ZXdj?=
 =?us-ascii?Q?pnNmMCvwRMXHYTUn6P9AKhC5vdfhvt3pYtIc+D8gEiLloJHMEP2hSvPleV1/?=
 =?us-ascii?Q?1jXpQCzw4q7VbKsULaU9L6lLzedyaaTse33JoPOCQ2gU1WA9xOan43ftuiG8?=
 =?us-ascii?Q?N2SSlo6WUipog9WtT22p3wz+qSFvAqbsqKQp1QWsKVCVkzxIAHu6t0Z2vzGu?=
 =?us-ascii?Q?mtSrNsHTSiPynRiTRge067Gs/pzfqhWmcYE6CWgV2oyRqCRxHecZI/70JPG2?=
 =?us-ascii?Q?9tspFbl4Z9poiTYilzOYfcTJ78/xtzT3wx1Xem9AavN0pGWEvEWXZyIqlEl4?=
 =?us-ascii?Q?EHKO1KAyfk/DY8gexClvwvukzJftDlW10ruiJrFTB+CR3ESzOZVLabLbXPW3?=
 =?us-ascii?Q?id9KCoeHzMlwUCkGh5gxciQlshKn28T68s4JW66qVxSHYbosCzpsRIjaaC8+?=
 =?us-ascii?Q?DosU9CSzQTlphL7OMwdbUTga6Wa1aCDFI031VUDfcMvTCf/CvEwigwiet4k3?=
 =?us-ascii?Q?s6Omqvuh0vpFdI7it+FKE0ds0oillintT1xRPm3sS7g1414n+CORMzBPEplh?=
 =?us-ascii?Q?ZW35f8MxQ6KF1MrU9j3rUWi72oGTK3AS3E9nh5ZISF5N7rsfuxFXt/m8/Rh1?=
 =?us-ascii?Q?OAPvlVNkygeF/N5Bq7MnHQJSvqD6NTgi7qmABKFztegCo6uyMmzQS8if54lC?=
 =?us-ascii?Q?+G8uBNymbj9tzShTWLbFI69L3CyDx/X4JWZgg8gu4LpSkEQxoVbAIccgggRF?=
 =?us-ascii?Q?OElcgs8xcsL+hnyPpjH8Jq6uVCnZuExkDdIFaMe6pteAi5y6Kl3kcPzqj1c5?=
 =?us-ascii?Q?8sCXe/IuFUrmxCLOf9SRoeqYQ5fVt6X9rm9VyPD77xIk+jHC6VQ1cgrh4iKG?=
 =?us-ascii?Q?6yJv9adK0cr+CeBkjjyHGH8H8O1H9rWL/5cqNdwQo9ocz8RayJ/xtfLf4Qwt?=
 =?us-ascii?Q?uO2/RPMbDgu8hDILGHMMojnwnxkcJ9OePTQyIBNeR1C3hI2ZqiK6Teo3VX9X?=
 =?us-ascii?Q?o86zeSi+MXnwnFHDhqCXvmhEa9dFjN0qiBVGnrhgw/W95ZQsKoUnv6VlPuJS?=
 =?us-ascii?Q?mqZjt4rnlAARSslSJ1phZ4ausXFaL2q7aq+xcM24dEBGHBRfm1clReWKaH2n?=
 =?us-ascii?Q?iEcPXXLG+WYRz02jWT5TXBQnxAXeD4IuRjT1UweCHOVgD2JDOJyHHp8RgP67?=
 =?us-ascii?Q?0Pn6qKD6ZFPTcVuEcKfOL/jSy8N2U85S+uk1?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:34.1089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aafbf24d-e4f1-49fc-ee7e-08ddd6a53150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 17:58:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1901

Add zephyr-sdk.inc file and move all the common sdk implementation
zephyr-sdk.inc file to support multiple version of sdk.

Also update sdk to 0.16.9 version.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-sdk/{zephyr-sdk_0.16.5-1.bb =3D> zephyr-sdk.inc}     | 3 ---
 .../recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb          | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)
 rename meta-zephyr-core/recipes-devtools/zephyr-sdk/{zephyr-sdk_0.16.5-1.b=
b =3D> zephyr-sdk.inc} (83%)
 create mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk=
_0.16.9.bb

diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5=
-1.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
similarity index 83%
rename from meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-=
1.bb
rename to meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
index 0b608bc..ee2e63b 100644
--- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-1.bb
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
@@ -14,9 +14,6 @@ SDK_ARCHIVE =3D "zephyr-sdk-${PV}_linux-${BUILD_ARCH}.tar=
.xz"
 SDK_NAME =3D "${BUILD_ARCH}"
 SRC_URI =3D "https://github.com/zephyrproject-rtos/sdk-ng/releases/downloa=
d/v${PV}/${SDK_ARCHIVE};subdir=3D${S};name=3D${SDK_NAME}"
=20
-SRC_URI[x86_64.sha256sum] =3D "01f942146d2fc6d6afd5afe6f4b5c315525d2c937c7=
e613d3312b0992b33bc68"
-SRC_URI[aarch64.sha256sum] =3D "1749b6891a6a6e70b013d8b31ff067c5a94891f651=
985a6da9a20367b2deb6c7"
-
 do_configure[noexec] =3D "1"
 do_compile[noexec] =3D "1"
=20
diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9=
.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
new file mode 100644
index 0000000..ba20341
--- /dev/null
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
@@ -0,0 +1,4 @@
+require zephyr-sdk.inc
+
+SRC_URI[x86_64.sha256sum] =3D "9b4b96f8df594801a84fce1aa112a84cdfcd430efc2=
a74229907b6421fb859a8"
+SRC_URI[aarch64.sha256sum] =3D "a8c1731ad602553304e539a7ade9cdb34caabc1850=
d581585cbba0372a7493b2"
--=20
2.34.1


