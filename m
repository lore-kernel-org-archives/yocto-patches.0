Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CDCA0EC4
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.53])
 by mx.groups.io with SMTP id smtpd.web11.80877.1755020516412969832
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:41:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=jVdd+YSN;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.223.53, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoXEYbIGX4Bxx6AZQzvGGfwRqB+Yao+JErUwRgnesMHFa4UWsWmJ49Cl6SmUaPEhu97tGPf2m1STcnE7A3sTSqQDYxpHi3/JiEJX3DB1JZ1Kr0uEoSFk9wGDlNo6lOA/Tp+joiAoECXeUaiDFraGpRjvjPKbGEo4P2y2BOf6PO5SmBAuyfHYD7dkZHyDYG2E5QpnsFQ4OFUmq+6mX2ZZDAFMYnOkBasaRcJ31Pqzrzdv0WuVi2lL5MrNJ4dzhaeesGhzQ6qhiWivynGcysJ1qAWCPirkAv7dMQUSPChCq+Ioinih3FrZZtXzz6ABCRaWO7SlBovnoLEwU6WTxRwgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=cmDPYKqMeubGCdSf6S06c3YrtABey6qJuPHyxfdMXWk8H/g3CZMq89MjYuZYKJT0jc4zQTLclw38PSSwV0YbJ+2PDmTdB4ujdfajRZ+YG3SahvFemOIgRshh1wl4dXawzOmH69EstCAIdCyfo0gdQqlyD+DDXVjr5sXCYSjFHflaXVn/ngZCCmi/pYolG4rIL12loyfJYamvZwjpvdUOZJ8aKdWG4r8p1F0hnQPDQmnev6eZvHx+rK12+Ol6DHc5AW+rb7H/hUB4YEQLLDgQ9yTnlemKQ1vRDakYBJ+N3PV3/YDmNyNwLmdwwzGasPSP2ZgtUtyuc5sNfU4UlR54fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=jVdd+YSN7Ra3ilsHYcRtCMCzGhJk94i7/pjQMHe+hJj71oEZftqry5tfIdV7bn73rt2kwsjye6WAjfRU2xiLH1FIAxMkqbhNpxh/2t1wuO8w3vibjMoiT1xTeGcnIM9wcfhy+ablit4IJR/B5Su4jirPe6XiM/ekV0QK7UvSu38=
Received: from CH0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:610:75::19)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 17:41:54 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::51) by CH0PR04CA0104.outlook.office365.com
 (2603:10b6:610:75::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 17:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 17:41:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:53 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:53 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v5 2/12] zephyr-sdk: Add new inc file and update to 0.16.9 version
Date: Tue, 12 Aug 2025 11:41:37 -0600
Message-ID: <20250812174147.130972-3-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: da5a7c39-9256-4ec2-e30e-08ddd9c7871a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gXv3WaLvq+8SnrYWVRo3z5H5liSwC16CdqJIvE1IdNh9aYd8FOGlCfqOVQpL?=
 =?us-ascii?Q?T7Ide9ejvH2VGZ3RU9k8XvGxwCX6Beo7CavqbKUtW+PmmFzY7EKvlFMsDzVE?=
 =?us-ascii?Q?L9zyHyFSAH3wIgUUj50e2vd4IKWhuGu+jEDRBRYgBMHMCIqBfJra7k3BN4Lh?=
 =?us-ascii?Q?icWSrgXnDmbdVRZJiogeEulEsa5oqqaSn8k/fieoYxn4VPRo2AYxNxP/Qv1q?=
 =?us-ascii?Q?w7lSfRt7ArjE+6fPUZ4GV6LIK78J1Zc7JYASQkLvgSMqqM7BWPou1MXPFS7F?=
 =?us-ascii?Q?3YjPhjYPtK/tqLGsNilDP1WRdMOeROJrYXIjNo2EgzlEmfkLBMlzcvDan0k8?=
 =?us-ascii?Q?IHRrVBX6vqptw43BEyfWJmbBtHlXaI4Hogn0AsqrDHtHqd01daPHCOwSnUEB?=
 =?us-ascii?Q?sCsIDYPma783Ghh6KTNBGB/sW+j+TqNRw7OjJ9LtQW0lsPMDTirLYVyv9Odm?=
 =?us-ascii?Q?y5geGWMtMxu1IZ3EdenIE3wxDL24s28CDZmRDPS9Bwp1q92ptRaarU4P2QyY?=
 =?us-ascii?Q?uhVuUPitt6d6Wilk52uNOfBWK+rycUcpu+Y/0Dl1IeOjSC9tB4Sa1zM972I0?=
 =?us-ascii?Q?0bAIyZDFkqeyqoO7g4DmnQI7wYoiof6ya6W0+Pr089vxrhsSU6gYDpxM5DgD?=
 =?us-ascii?Q?SA5hUsZXVkyJSBeMI93hPDekkpkOf7TPHX3kjtzhZ7fCNHqu1kbuRmaRAva9?=
 =?us-ascii?Q?zJy0LY5eCgeI59Z95arcV5tyXMgm7y4WR7dpPl1S38jFOmikZQjMtfuGrOrc?=
 =?us-ascii?Q?OrecPcJBN98+0zrrvMzQqN6XtixoBIIW9gm58es2Oxp9MXatOD7BZ1BtqkOo?=
 =?us-ascii?Q?GhHSuoGc9esSXHldNDhP+9yf6ivEe/YqHHF7guYGgqNuIKeasB0YO2G0m39T?=
 =?us-ascii?Q?jKYtU5p+CgLDBpI3pJaPf9owDdeIuKDm5Wlk1Kl3VF+BViWBJcGzsMIbUPZm?=
 =?us-ascii?Q?Tmu0FKnT4gb5hONDrkpOZaITXSkH6ASrjal8KtV0ibLo+WTpHssKzhSBsasy?=
 =?us-ascii?Q?Zt9FyoYvzgvHGnROHv20SMPgFO3Vd8GEIddyeHUJj6MKuMrPXwgjdcnXjBAR?=
 =?us-ascii?Q?QV+13SWf0+qTxGYuAddXFXWPtMlN7Zp7htO24Cn5PRsZdUvwhcFrY1CyCYKO?=
 =?us-ascii?Q?FtVhO3081Z7VGGHKf/dZVWJHJfCGRtMU1mP1sxVhpWik8aSMHdxAflFw2EW+?=
 =?us-ascii?Q?cUlwbuUtV5OieCFwbxRWsrRuvdBAsY1li5rJ3L1BdY+iaxnSjYC3C02dPufn?=
 =?us-ascii?Q?xN9TWuROq4vcemRUw/84sh3TqhX2ooiROiB1kxkO/j6i9FxS++DDd4jJ3rF7?=
 =?us-ascii?Q?WvojenoP8GrKiFWQtWzDMUvwvCbaQVG7jDo0fZ9OrJsPA7lDF27iruCub8aF?=
 =?us-ascii?Q?R4HExrLCfGba1R5iULWRwvGDyrD4UfRidIy/MQJmFuPFdCdfR0KffUKdCN27?=
 =?us-ascii?Q?AD78B/YeU+jl/F8vYBb6GSq/ts6brHaJ42Wf0iOwAyc70CeYndT5OyQwwcBy?=
 =?us-ascii?Q?7LpWBKKnvHtsFFbleq3vGNg+z2c6VARZNuOE?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:54.4361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da5a7c39-9256-4ec2-e30e-08ddd9c7871a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1963

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


