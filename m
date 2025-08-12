Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A8ECA0EE7
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.89])
 by mx.groups.io with SMTP id smtpd.web11.80885.1755020521504580516
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:42:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=XN2OQCPa;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.89, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0t/wwmsd1sQijWu9Yw9N8pPzVmjNbSbA1KpOQVLXTTXshDJCIWz3pttb/7kE102IfUDp4Rdubhe7u9UeoiFXb8gAwPwzrN97RvjwTZOumepGKAiR/0Y87ckpHtJi2gmW5/VYq62e/84vs4RWgumt4WtqCwSfFaIBWuVF0rnxrWugoORJxkQLBHusBAzQWPw9vNBi40vx7ucq7kV76h1GTAKg+v970LmygRJC+vUf+6ti2Pe9kDGrfBVIsSS2adhDEq+QsZj0oiQL0GIpg0PyrFthozvNvicJNVM7sUKfkloM76W7ymawXXMfJ4gvf2wb883OMAPisK/vHeJ40Fw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10E1QjRBllYheXG0z3khl52zhcmByD/4qTcS21Vm1gg=;
 b=v+1B2LQ256pdAJr1FHTZf2CbVm3y9gWLevRC0p945bWQS1XkkQ/B4mS5RVuxV4WbohteRHHe7SlwoyWKyrTvFcyE4dEvN8roJFZ584R5vwjt1xxtyvKkPBWQpg7yspfZ96/zEvAVy/es2LyqtFsspYAvxGLQuVTjS0JuPw7koUOsyGFlRlujGV/KbbwXkW7NafGmxXpEd4abpw/bDb/UGZ0QvX43JcyxbnfBL1BIqWmB2KZPI5hHaUfooGkO149+g2GPBVmki/BrvVaPzxAp8W2dMvedVQZ4Qdi0dG2DISwHEmx3llIYT/MsS9tVGNtlgrnPqrxdyla3khokFGpBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10E1QjRBllYheXG0z3khl52zhcmByD/4qTcS21Vm1gg=;
 b=XN2OQCPaP2I5ZjYim2jAMlsK34IaH6wnY+aSPfT6uq4VH+RlOd/LAWQmUeeRmeMZV6Epjdy6jAsMID3rXtuLvXO8FNW8GHElK2vRIUJG64uoLmUp9RMbzgJuBlqk+gwtaBg3RQgiyiQI5L3Kms5QwGfxvqX89jnfQaeqfZT++6I=
Received: from CH0PR04CA0102.namprd04.prod.outlook.com (2603:10b6:610:75::17)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 17:41:59 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::20) by CH0PR04CA0102.outlook.office365.com
 (2603:10b6:610:75::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 17:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 17:41:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:56 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:56 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v5 10/12] classes-recipe: Convert zephyr-sample inc file to bbclass
Date: Tue, 12 Aug 2025 11:41:45 -0600
Message-ID: <20250812174147.130972-11-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DS0PR12MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: bec230f6-e1f3-43ee-24fb-08ddd9c789d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9IogBPZDQldFHvcGPEjykz+o79uPCo5OEpCz1yMszloGovlgQo5VbKSmg+Ez?=
 =?us-ascii?Q?KwQS4/pSJ5hFN20oAFuTkmBu2dixbXMsj0acAe2Eg2sx5MmgXdCWOPDJVf2K?=
 =?us-ascii?Q?pUSDSgRHLiatD8c2nRTHi9653nyDZOJyXiJnav+JniuvOvIjRH7qVxEnkp5n?=
 =?us-ascii?Q?U4xbGKl9/iOohQUcbjIusxY1/BgQbhZJbCWxzAlrpjb3XiLUanoESaYu5eJn?=
 =?us-ascii?Q?YKUHuzVMRzUgUKms2zdlKXSz/jFNqwizs57bZM5JkOlVcbqZQu8rFyUs70AC?=
 =?us-ascii?Q?cKAh5mkWrog+WlHJNwafUVeMNrj/gNZp5TL0fGerfcmORypXuo4CCq+Sra5d?=
 =?us-ascii?Q?zYLlQBaSKmpZdO2ag7iqFoM9sxrqn/MNAQG4RhO8SV7gcrpLm4KPPtzGt+G8?=
 =?us-ascii?Q?D7ZOAeIFQ6lDOubk/lltOlCXFnRBaAL13Qk842wK9IQccwf+yXr2E5LrcITu?=
 =?us-ascii?Q?TwKcbbVVQWVdQAWZjUTjM+1roHWfox7IJFi95+nL8x6md8mCfLlFym4YrEzN?=
 =?us-ascii?Q?NjCY5x+BOHxbDxMSt3W33J7baSIY58LJTqpW+ug3piVfRP7OrOUigbhxmtdT?=
 =?us-ascii?Q?ShwlUdWNzHEjmXJNErJg8LEK0jTlntVaOTePYfXMnAVLvfglrRxoc65Av5wj?=
 =?us-ascii?Q?EaCtpyH/fK3duG0uTK32SFb+cqu0uhVRnOzaPlsA7IJlPLnIpHPFedcn+tEB?=
 =?us-ascii?Q?ut8S3RXLg9OuREgdEf68tA+M+zHDJUSe7jA5cYrGZc1+UpoDUqYOwBs08zwF?=
 =?us-ascii?Q?feF4joZaNCZqsJNdi8R7i4hWLHK43ic4hdbCYww/ZRyY7uG6YMSB7Fxiqk73?=
 =?us-ascii?Q?ZIye3/P0pj51pECxEzIUXyj6hixaHO2QXXeYl7wzJTWlXvM1bPQMUyrzQMrM?=
 =?us-ascii?Q?myrmdt2hE4/82KjhpvkI8QoFB9alVsA2FlWsq8xZmYyINTGVOMYNzhnerGOr?=
 =?us-ascii?Q?axrmpFv3YLJDljfAk401JGHfHfD4nOD+F6fzlMNc960Y0Cx5PgHMf6yU19ea?=
 =?us-ascii?Q?xaFTiO7AAuLPMxQpuRknbcOEidtUqxim4YgtKlsqeyzmbhHppf+AFWk6iYw/?=
 =?us-ascii?Q?aqlVgXbIl4qzm5F6tVgQIuX0ymnFWFP2rQ2XRzxKfIf1fZUWNUxTw60bQIfR?=
 =?us-ascii?Q?aSS1kHchZUkgrPnsEG2+kUkYeTfkmniTrVnmrdctd5Cx3qQnwaXLGiMxg0Ya?=
 =?us-ascii?Q?KcANr924ZeD8ARk/c8mYSIaGaykoIQrRcZJTzi5Eo4uSCY04U/ECa3c3nHA2?=
 =?us-ascii?Q?NgdzxCgUQEbW8U4xQqL707tpnLL973PlJJbXGgHzHwJzBsYfUa011Tcu6Av1?=
 =?us-ascii?Q?MdSxNPrFjVEN+v6JVhj08xcHHJZXKG1tNJPG816piudxxJXnAys0eGtVAQ8w?=
 =?us-ascii?Q?iYkkCIWzlw8+12L4W7dc/K9AKamtBNPnWz5835o0hrtMBdYBxT1ZOqsURO6M?=
 =?us-ascii?Q?aCWvHvb919bkui3YdNHmK11xEXU107WXDycK1CKJabgEKWjOIdMRvBKaPkXW?=
 =?us-ascii?Q?eudAcI+G1uabq4LyycSua1zDAdcc1u2cvt1l?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:58.9788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bec230f6-e1f3-43ee-24fb-08ddd9c789d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1968

Convert recipes-kernel/zephyr-kernel/zephyr-sample.inc file to
classes-recipe/zephyr-sample.bbclass. Using this bbclass user can
inherit this bbclass from any layer to build custom or out-of-tree
zephyr applications.

Also update the recipes to inherit zephyr-sample bbclass.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-meta/meta/generate-zephyr-machines.bb      |  4 ++--
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
 20 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 meta-zephyr-core/classes-recipe/zephyr-sample.bbclass
 delete mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sa=
mple.inc

diff --git a/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb =
b/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb
index 30d362c..a52ffba 100644
--- a/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb
+++ b/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb
@@ -2,11 +2,11 @@
 # SPDX-License-Identifier: Apache-2.0
 FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
=20
-ZEPHYR_INHERIT_CLASSES +=3D "zephyr cmake"
+ZEPHYR_INHERIT_CLASSES +=3D "zephyr cmake zephyr-sample"
=20
 inherit ${ZEPHYR_INHERIT_CLASSES}
=20
-require recipes-kernel/zephyr-kernel/zephyr-sample.inc
+#require recipes-kernel/zephyr-kernel/zephyr-sample.inc
=20
 SRC_URI:append =3D " file://0001-zephyr-Export-an-OpenEmbedded-machine-con=
fig.patch"
=20
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
index a635da2..3878937 100644
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
index 5e51c23..2932b53 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-tabl=
e.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-tabl=
e.bb
@@ -1,4 +1,4 @@
-include zephyr-sample.inc
+inherit zephyr-sample
=20
=20
 ZEPHYR_MAKE_OUTPUT =3D "zephyr_openamp_rsc_table.elf"
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


