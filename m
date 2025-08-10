Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390BCCA0EC1
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.48])
 by mx.groups.io with SMTP id smtpd.web10.36645.1754869165084381327
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=oP1ISN9a;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.48, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrmzYsX4FrD2uPhWRaMpb4jIUE2/5Bm84BiG/6/DrToU638mwYbX8Q/WoLHk8wZ0GEnPKb5RsKcE5mD3wvMCILITVFpxP7rEmhmcOZiSQxlMhmoJBb+66xnizNvz/0/MfkTSsNBD3r5PeEh78CUBm+2xGTe4jKVIUitfyLHFnZ0ZSLwaVodG89oM12lrx0+gdNikWuyadl1+hKik3NezJxaGU9feDW4TUVP9fuNLyJi2M0UvbGhhh196toHZ+RwXSY0H1j4ROhKFgnGBH+dU32s4z8l8lPVbY4tHYFc9zYRSuP5PTfLphVRq8pqCykhz0mjZxHQL50M1Ne4wkoWkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=feRzUS6lwagHEJssJ4AdB2Z70qdYaXkCBVHYAVFvCgcTJu5TduMisEjmY9i3agwlZdyPsGQyMzJIp1U9HZF3q20ZA5v9KxoYrf4IZYedEclv+fmGtKcXhBrjfKDCebklP6eI51xa0ZeRuoOiuNFAC/SBHcKcW4beOyPdRRVLhyvcRlP9oF8/WZ+dVUzl7vq6XtpxcwjOF3p/H7dOedwKbDzzX0Z4SAYU/edGnxpBGktx4itShCthI1tkb5rK628L8M9T9/amIfBfZS+2hSuyE5DjWXci67di471AyjCOg4OCt5dJLvq8WS1woLwxQ2HKW7LzZQ7DmmMXcA1pxuSqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=oP1ISN9aOSM8Ybp2inX3ugGmB/bi01MExIn91h1Wz+GPz9ZyNOhjmgVWlHQgL6N4C4UM8/2Dj1Uxj9k8lzbqIUwWT7ef0DvEkBNcZF0eI3S0YCOHNb40ZfiiP3DLxRyQWMN4tDCAStjipv1EKamOXpoYtyDodgj2er/jChP4d6k=
Received: from BY5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:180::37)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 23:39:19 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::61) by BY5PR13CA0024.outlook.office365.com
 (2603:10b6:a03:180::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Sun,
 10 Aug 2025 23:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:17 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:17 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 2/12] zephyr-sdk: Add new inc file and update to 0.16.9 version
Date: Sun, 10 Aug 2025 17:39:01 -0600
Message-ID: <20250810233911.1259884-3-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: c18847a7-6c12-47b8-ff4d-08ddd8671ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8l4XcPion6fE8U08d6E4mf5vptOUq3sRRq2R9aGU9dV/pXRJq/WtZ9rg6Yz8?=
 =?us-ascii?Q?EZ+jNguCQaZzf+jAz3XbPbghD3LjYyKV1r3KQS5ciCbbZcwbZX/lUFwIwtUh?=
 =?us-ascii?Q?UyJN4hfeMlfifNUvbLvrpmlzzv9I+u2chvXwDojMrNWnWTVeZK64YjS4Fkzh?=
 =?us-ascii?Q?PUu3/MRGrfhS2v9CUxUHJkwV65yuQxr2IT/v6YjeuT8bm8lMXZBTkdblMIun?=
 =?us-ascii?Q?CErWllSxPuJZ+jKyiipmz4RKBXHpQXICMT/+g3o9Gk331mP4HYQSsZVpPzSW?=
 =?us-ascii?Q?DLrgE5lUY+VF59FUYfraGLYEZeFiBGYD84jZK47triJoRNa5oxZ4UzCsvoow?=
 =?us-ascii?Q?URpAZMZovDWXWWuWUpgX29814DcHhC7M6Xa7dlj9oKVt9tGa06EmTCV9dN1q?=
 =?us-ascii?Q?S8bJ5uK3YjXxKS2qwUSK3dtK/cL2IWWGB4g1SbYTw/hD747jhz3dcACSf0aW?=
 =?us-ascii?Q?R3yKAo7AzjohjsJURj28n9ZDcocUvGz5iMPAdphuWEhtu3ZuLADULOkPSQtV?=
 =?us-ascii?Q?xT8KhV2w6TmQ2MrX/YIpcJs8j1Kk19kOSVIy27AnpwItqZe/xBTuDns7EcpR?=
 =?us-ascii?Q?HL6nFXe6EM2E6JqcwwfEMy3JVKKxrqaKequMDLzue3aLNwZyBYf8qGQu7IIL?=
 =?us-ascii?Q?JO379EQB88587wZPJK2txrnKT1T8l02YROZzaXxI5FDwubFJx9v5CSGPYPWZ?=
 =?us-ascii?Q?sCzzDCm88tJ2ygCrVgmRzNzn3XO9qq+/ROae8fTp83fMowj+tSA0+1PEXj/z?=
 =?us-ascii?Q?YUI+y4BuWUwEOSx7Hn6X8e8ovbDKGw1pVKEwCi66isYWV8z2T8H9D/Fo+7of?=
 =?us-ascii?Q?PLPrJxKRf/JrgHbYLBan3i5EBKzGX0G5vpdMYY1ijJKFMDj2wm+ctKlQlFPi?=
 =?us-ascii?Q?DVk02IkdFeL9mIseUEoaS/3rmG7CsK1oZIyR4V3pBag0o8kEiXqQF1ncuxlv?=
 =?us-ascii?Q?g4GOP1hy2ihxm8z5wSvVhYzaZMXItaGPAC1VgqnceS3MAKLv29TrZCW4Vq9E?=
 =?us-ascii?Q?KMD4RWWPnjyyebbUWVlLO+/DoER0IuFENJSEEJ5ZZHYafZmscXqq1AGwZUVh?=
 =?us-ascii?Q?gu0ZcLK3bebeR3uL3C5l8lYGcJbVO2DRb+uMSlOymVs4zLf9+mSfFd8bp1Ub?=
 =?us-ascii?Q?118cZjjutnBOezlM4q3zW4O9uPmeR63/SAKikHGlg8pt26GXQNhkpNZU0dOB?=
 =?us-ascii?Q?nhKM89ONrfLmWGPbxfxQmNyiBpajYEIcxtJKskuiDSYv+nVkdVVfiLvAGYST?=
 =?us-ascii?Q?It49fDuuF0eBphp31xIXvk+tzle0GfiNRrK4Bjt3Vphx84U9TUKlh1Vd0ImB?=
 =?us-ascii?Q?ZCzVcFVhz7OpBfTJpXf7W+mzNw6eWGJN9H1Hn0BmhiMXImayZtAvBQPwFnbo?=
 =?us-ascii?Q?X4ot8MoLOGehW7ZmX9W+xgvsuU/eRVOP2utNb4aFHNhtvB1fkPCXZjfFQKCW?=
 =?us-ascii?Q?xaFafXLzMAMQk3Ojs/SQYrHjLnDC1tGY+IPHQ7kqAYoAKyE/U4CoGpII5RxC?=
 =?us-ascii?Q?g8vCKKqAfIewdwz38AiFo+w8sRuLx1fdoVxi8RRck3qEJ53wrRRLqCRuoA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:18.4443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c18847a7-6c12-47b8-ff4d-08ddd8671ff3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1912

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


