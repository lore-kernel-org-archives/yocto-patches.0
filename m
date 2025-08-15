Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8CCCA0EE0
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:55:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.65])
 by mx.groups.io with SMTP id smtpd.web11.4405.1755230106934054399
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:55:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=r5LykVai;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.65, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6gnFQCYwqF1NF81SNqF3kOk14NEk0hB7xfwL+ZZhfBNrmYH/iJntsCEAqJ4/5EqRLh2zYa3Ds+0EkuzXWV62+BT7C2BoxZGGhBURJfqQn4A9+HQGepVFNZRMjed87+XG/QHUit/SbkMgWwD/pi9ucC9eF6DNZrO8fpf6PIQEh8PRYUkZvh6OKgOIftiz61I7wVikZz9nCY7VsUDt+r+2+pVuUhUisCt89kZAiCHfSiQ/RuDLSV2OPj9XdCl6sQ5w3b/sazi0yuZzg8NAgECpkrPD37hgXUVMAcr/zcMaiPA/ouhprh11hM3cwWFsBOHr+03lPMP8GCMlxXjK3/E1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmBe3QXmvOmSP1DRp+hk4iSiUaZx8AUEsLe2vPmxwpA=;
 b=qGtv32XzAXSmdSlaX5IFa+q3xCO0LsRb8C6HqNQ4t7uH0HiVSXn9aPFrYNKKKRxoxVkJ/Jy5Tas/d54BeJ8suW16t02Busldram9L3WAl8yZDtlV3XZFdC7DhB9gPZFuHS2qX7Zte94+NoE0xeyZf9CIo8OOAfEOzMMzjtn3UTEGrJWYLFjn9Oj9no75JpKwiaOw7GzhQTnlv6Tg66ltTQoKxiBBq0GvtRtPudqmOR2ESqIHY6q4Cljx168MG+3pA1jJ8zM626/S+DZbg2orFRYJQpu8Yv+i2We0Pa91B/8S0/wzMiEJbgH4Au1zT9p7yLKDM8aJHcva5Sy7+yGWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmBe3QXmvOmSP1DRp+hk4iSiUaZx8AUEsLe2vPmxwpA=;
 b=r5LykVaiH4hUB0vNafZ+vVpSX1Gl5NgBDxhRb4OLKufHKP+mOw+Bhy+4iSmfm7PdHgtJgAq2vyhY4WZzg+fKHOm7RCfQe1lKj5p1FELWVtnFj4BId+l4+AwZfzlIj1Ah1BWs8YRy0nj2DD8Q3wwARuTZ4AtEzzwAZ5rT0bwpanI=
Received: from MW4PR04CA0107.namprd04.prod.outlook.com (2603:10b6:303:83::22)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 03:55:01 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::36) by MW4PR04CA0107.outlook.office365.com
 (2603:10b6:303:83::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:55:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 14 Aug
 2025 20:54:53 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:53 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 10/12] classes-recipe: Convert zephyr-sample inc file to bbclass
Date: Thu, 14 Aug 2025 21:54:47 -0600
Message-ID: <20250815035449.2816001-11-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4cfd9c-7221-4de0-170c-08dddbaf8277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?G5NtqSxorBU+Qwuabbp+T2W74XnYuAJHAsiSApRJt+rmV4P8kENshAdyJsKH?=
 =?us-ascii?Q?FSli3a6/rUOY0sC0ngXsGtxVH6nKFzTGLpGTJQDQ1gvLW5B5ulp+HP2PLl47?=
 =?us-ascii?Q?AHWFPIJu5DsM0bbH/vCCX+Zl0M7LnWdHrWJbGI+kTOLmFQjq7mtAoTtM5t30?=
 =?us-ascii?Q?jdcecvYFMaOwXdqp1f936VVJHtfG+KwTCHcWI1dlt9vi9AGFQD7w9NiavoV4?=
 =?us-ascii?Q?D4T2hfSfFfnoDIvlr2IWawGPH/YrnaaqBx9TROpwEFAqxdYJFMSAsAjIdMVu?=
 =?us-ascii?Q?GMuggNGAk/nXXeVWSDbjg7q0b+ojWk0Y322cjuP4sFvZ/KIZCOwnmpZ+r0wS?=
 =?us-ascii?Q?XRboD29ebny2zOQxrPZZ/GQ9aZ+ajzUiZtrsCAptaofz3c9umy8y21miiRx0?=
 =?us-ascii?Q?YpYlX8fioBL1pBJhvCW5zHM0a+kW5Z0paknbpVhHOszI7Z5nf5YhWppr5LDf?=
 =?us-ascii?Q?EWtW1r7Os4vNjVjZ2afWEjgxT7H1eTlTRyOAs9nWtjEZBVFbPdp0X1jDkkIy?=
 =?us-ascii?Q?XUokBTacTpDVBmFeti/QCv8A0WXp3q5kxRu031BPjp1RzLwmOtUZuRo0TBgD?=
 =?us-ascii?Q?hJhkmRl9GL3jdJtIPVC5Ua0I62X3X5ZDsNDTULnF8v42qnbthgTquufc1ji9?=
 =?us-ascii?Q?880HzMPI2b4Wd0jNUY3vf6IadYSO8xKm12JmN+kXkzwIorm7+aMicgrwUU/0?=
 =?us-ascii?Q?UCCnER/mlpkCqvmS2XXkgPaZELoauyYIqVyYU/choYt8iPKUrtFPHR+eMkbT?=
 =?us-ascii?Q?yU2PJ9mZdlHPWAveen5HfZDsY/z7QZittVUuUWfgE2/3+vcVqbWiojQPryzR?=
 =?us-ascii?Q?/FE62uuxt23B/++2wHA8UdM4SaeZSDPoB39R+bTBwwQWI+pCDLNH/RzuaB7x?=
 =?us-ascii?Q?h7mmGEZKdNtdTCVazwV+oFR8nClmuU2szZp0DGc/WGWuHthzmbsq2kNg2N4l?=
 =?us-ascii?Q?HTyfuy00huNEl/h51ocCbFyqnG9lUws0YUEiiikH6SxAHQ2zy5z1hW2KPlQ7?=
 =?us-ascii?Q?bQakiwypJ3GFpx/bqbNdk8mdGJyzvtyLjg5foMiTIagLe3sVE4XrrNXuG6JJ?=
 =?us-ascii?Q?/Pj5dG9890LurTDSfCDX5b5tC2l3EuUO5lu4bfzXSn6V8H2IOvnrmw4fvccz?=
 =?us-ascii?Q?s/g63hKC14HuJf8c6yxf83cKnCjNoSuAHD5Nt+LOFTEeBLsk40j58TWhuPKq?=
 =?us-ascii?Q?uK8nBQKJAtBr/0F9QRhjpQ50WbdsMgcIJWPzhfBChVAOG1Xuv43uUce6fS23?=
 =?us-ascii?Q?LgWBZrHoDh1SATIoaA+iigZaDP0LaGkCGaGUBT88C2RQv/dr3izRTDkVBl4e?=
 =?us-ascii?Q?s7S9z74/6raJ8AvZYnPs/ZIZur2PsIgYYCPemNIYD2kgNqNzJAuhgvi22v+A?=
 =?us-ascii?Q?e7ZsXfMMkr9IpRnEXRjjXCCfh8BTMFh98lFSWJ4VDX3IAGo5xESh9M6/PiFq?=
 =?us-ascii?Q?Nrqz1WhOt452FWqq9vAypyqacqzN23s8fveB6wS2+aRG1Pu4vKQDKvWMsr5v?=
 =?us-ascii?Q?C2I6V8nCRvaXgBB5pKQXkBzOSCX+ymCIMbp6?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:55:01.0184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4cfd9c-7221-4de0-170c-08dddbaf8277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:55:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2001

Convert recipes-kernel/zephyr-kernel/zephyr-sample.inc file to
classes-recipe/zephyr-sample.bbclass. Using this bbclass user can
inherit this bbclass from any layer to build custom or out-of-tree
zephyr applications.

Also update the recipes to inherit zephyr-sample bbclass.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-meta/meta/generate-zephyr-machines.bb      |  4 +---
 meta-zephyr-core/classes-recipe/zephyr-sample.bbclass  | 10 ++++++++++
 .../recipes-kernel/zephyr-kernel/zephyr-blinky.bb      |  2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-coap-client.bb |  2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-coap-server.bb |  2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-echo-client.bb |  2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-hci-uart.bb    |  2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-helloworld.bb  |  2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-http-client.bb |  2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-lvgl.bb        |  2 +-
 .../zephyr-kernel/zephyr-mqtt-publisher.bb             |  2 +-
 .../zephyr-kernel/zephyr-openamp-rsc-table.bb          |  2 +-
 .../zephyr-kernel/zephyr-openthread-echo-client.bb     |  2 +-
 .../zephyr-kernel/zephyr-openthread-rcp.bb             |  2 +-
 .../zephyr-kernel/zephyr-peripheral-esp.bb             |  2 +-
 .../zephyr-kernel/zephyr-peripheral-hr.bb              |  2 +-
 .../zephyr-kernel/zephyr-philosophers.bb               |  2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-sample.inc     |  1 -
 .../zephyr-kernel/zephyr-synchronization.bb            |  2 +-
 .../zephyr-kernel/zephyr-websocket-client.bb           |  2 +-
 20 files changed, 28 insertions(+), 21 deletions(-)
 create mode 100644 meta-zephyr-core/classes-recipe/zephyr-sample.bbclass
 delete mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sa=
mple.inc

diff --git a/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb =
b/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb
index 30d362c..57718f0 100644
--- a/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb
+++ b/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb
@@ -2,12 +2,10 @@
 # SPDX-License-Identifier: Apache-2.0
 FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
=20
-ZEPHYR_INHERIT_CLASSES +=3D "zephyr cmake"
+ZEPHYR_INHERIT_CLASSES +=3D "zephyr cmake zephyr-sample"
=20
 inherit ${ZEPHYR_INHERIT_CLASSES}
=20
-require recipes-kernel/zephyr-kernel/zephyr-sample.inc
-
 SRC_URI:append =3D " file://0001-zephyr-Export-an-OpenEmbedded-machine-con=
fig.patch"
=20
 ZEPHYR_SRC_DIR =3D "${S}/samples/hello_world"
diff --git a/meta-zephyr-core/classes-recipe/zephyr-sample.bbclass b/meta-z=
ephyr-core/classes-recipe/zephyr-sample.bbclass
new file mode 100644
index 0000000..b2a71db
--- /dev/null
+++ b/meta-zephyr-core/classes-recipe/zephyr-sample.bbclass
@@ -0,0 +1,10 @@
+#
+# Copyright (C) 2025, Advanced Micro Devices, Inc. All rights reserved.
+#
+# SPDX-License-Identifier: MIT
+#
+# This bbclass is inherity by all the zephyr-kernel/zephyr-<apps>.bb recip=
es
+# to build zephyr applications. User can also inherit this bbclass from an=
y
+# layer for custom or out-of-tree zephyr applications.
+
+require recipes-kernel/zephyr-kernel/zephyr-image.inc
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-blinky.bb=
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-blinky.bb
index c2a1e55..78a6e83 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-blinky.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-blinky.bb
@@ -1,3 +1,3 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/basic/blinky"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-clie=
nt.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-client.bb
index 7796f6b..aa020e9 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-client.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-client.bb
@@ -1,3 +1,3 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/net/sockets/coap_client"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-serv=
er.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-server.bb
index 5e345d4..b43143a 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-server.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-server.bb
@@ -1,3 +1,3 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/net/sockets/coap_server"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-echo-clie=
nt.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-echo-client.bb
index 73187cf..4705724 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-echo-client.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-echo-client.bb
@@ -1,3 +1,3 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/net/sockets/echo_client"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-hci-uart.=
bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-hci-uart.bb
index ebc6dc3..f95f544 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-hci-uart.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-hci-uart.bb
@@ -1,4 +1,4 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/bluetooth/hci_uart"
=20
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-helloworl=
d.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-helloworld.bb
index 68b42aa..637287b 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-helloworld.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-helloworld.bb
@@ -2,6 +2,6 @@ SUMMARY =3D "Hello World Zephyr Sample"
 DESCRIPTION =3D "A simple Zephyr application that prints 'Hello World' on =
the \
 console"
=20
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/hello_world"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-http-clie=
nt.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-http-client.bb
index 8bff2be..a4bf7f2 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-http-client.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-http-client.bb
@@ -1,4 +1,4 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/net/sockets/http_client"
=20
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb b=
/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb
index b5f02a1..71e19e9 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb
@@ -1,4 +1,4 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/subsys/display/lvgl"
=20
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-mqtt-publ=
isher.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-mqtt-publis=
her.bb
index f314841..fae7eb4 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-mqtt-publisher.b=
b
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-mqtt-publisher.b=
b
@@ -1,3 +1,3 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/net/mqtt_publisher"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-r=
sc-table.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-=
rsc-table.bb
index 8a95b14..daed729 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-tabl=
e.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-tabl=
e.bb
@@ -1,4 +1,4 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
=20
 ZEPHYR_MAKE_OUTPUT ?=3D " \
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthrea=
d-echo-client.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-ope=
nthread-echo-client.bb
index e2b3efd..0408d92 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-echo-=
client.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-echo-=
client.bb
@@ -1,4 +1,4 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/net/sockets/echo_client"
=20
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthrea=
d-rcp.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-=
rcp.bb
index d745e85..e1f1646 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-rcp.b=
b
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-rcp.b=
b
@@ -1,4 +1,4 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/net/openthread/coprocessor"
=20
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-periphera=
l-esp.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-=
esp.bb
index 0aac7f6..61829bb 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-esp.b=
b
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-esp.b=
b
@@ -1,3 +1,3 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/bluetooth/peripheral_esp"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-periphera=
l-hr.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-h=
r.bb
index 80e3505..2c0fcb9 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-hr.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-hr.bb
@@ -1,3 +1,3 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/bluetooth/peripheral_hr"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-philosoph=
ers.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-philosophers.=
bb
index 2b4fca3..931541e 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-philosophers.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-philosophers.bb
@@ -3,6 +3,6 @@ DESCRIPTION =3D "A simple Zephyr application that demonstra=
tes basic sanity of \
 the kernel. It demonstrates that kernel scheduling, communication and timi=
ng \
 operate correctly by printing a greeting to the console from two threads."
=20
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/philosophers"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sample.in=
c b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sample.inc
deleted file mode 100644
index 5f6dea9..0000000
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sample.inc
+++ /dev/null
@@ -1 +0,0 @@
-require zephyr-image.inc
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-synchroni=
zation.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-synchroniz=
ation.bb
index a55736b..217ab7d 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-synchronization.=
bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-synchronization.=
bb
@@ -3,6 +3,6 @@ DESCRIPTION =3D "A simple Zephyr application that demonstra=
tes basic sanity of \
 the kernel. It demonstrates that kernel scheduling, communication and timi=
ng \
 operate correctly by printing a greeting to the console from two threads."
=20
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/synchronization"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-websocket=
-client.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-websocket=
-client.bb
index b92e986..b646b6d 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-websocket-client=
.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-websocket-client=
.bb
@@ -1,3 +1,3 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
 ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/samples/net/sockets/websocket_client"
--=20
2.34.1


