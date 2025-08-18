Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF8CA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.73])
 by mx.groups.io with SMTP id smtpd.web10.2788.1755554591684176520
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=GwP3y2bz;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.237.73, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL0AJjetLZDIkwO7nlr9TrkzQ5HgpqpEhtBxGlPUEza3RgdIYHF1NDDcTRvJhYLzhQ66aJ9FJGhgPy/uOgLu3EpD7sZ74q6cllVRn2Gg1Qx6zzTaiVxcqhammo2I3sm7Y6C70R4XaJxT3FsGEFS2f2UFV29hp5IDNDPgOTjkbuRzEhyGx7lTHEdBnbT3bw2PBRCucVvtuCK5LmasboZ3npkJKUkltYROM3/gVwqr+24YpzODhtjrXR/hW/TWmSVnhmJZDoMRR/OGbxEbJHJ1aMixnzq+0SE3uUhu50pN43lC6s5pY+Dq/1oagB9yuBnxqHfEH0BItQFX9OdXRz5ZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10E1QjRBllYheXG0z3khl52zhcmByD/4qTcS21Vm1gg=;
 b=lIRLM+fkcceADd7rE2Hy/LISZVteDWQwQE1tFw2imzGjKGBWa9f2CGxFBDGm0rI1kkYIhouG34g55+ZeRh5ZPNnC1cdp+kSptJZEPFTZWdlToyyj7dRqb7/1RWNVqstGJQ2Njy+zxe7qlsNmTVYx6AbVFsBOctMkyCMarJx8ZLLd7S+zzsHcK3fd5kySDgC8ZPN+ZsfkbB+mFcAk2WLhJuU7qyX+KqbWnPG+52pbO4iFpc+cJcTrmWYdhmeMoEvfIEV9kaiU+3LCsNSR0tTk0nvMuB6yptqezOU77fziRZYMuu/nyJ9/UuCMJsapFgJiSw9Z6Cr88BtdwB3CoA4P8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10E1QjRBllYheXG0z3khl52zhcmByD/4qTcS21Vm1gg=;
 b=GwP3y2bz1BYjXA6QW+WPfbQ5aoiLvK6Agq5+cFEOYTHyFNSUTQOQaI5pWvCMJ+aozxM1cZY6KdT+MmOYvIKdritLj5NlONzc1Dbfyn0//IVetrtV/H2CeiubstD2qco8RIxKuL2sOTwL2E1ZCnzscJUBY6FneFO6QvuypfpK+iI=
Received: from BL1PR13CA0350.namprd13.prod.outlook.com (2603:10b6:208:2c6::25)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Mon, 18 Aug
 2025 22:03:09 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::47) by BL1PR13CA0350.outlook.office365.com
 (2603:10b6:208:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 22:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 22:03:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:07 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:07 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v6 9/11] classes-recipe: Convert zephyr-sample inc file to bbclass
Date: Mon, 18 Aug 2025 16:03:02 -0600
Message-ID: <20250818220304.2300436-10-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: e824a0c9-0021-4247-e62f-08dddea30481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?f6izbR65AsbJxGS+zZqSHbJ8t16qgEHCIbPu2ssrnaSnaKFBW0Fxp7ttwtRj?=
 =?us-ascii?Q?BaOtZfPkM53636DnRqQSvzP4Fl7c9jvkICgCcO4CZCOPyNdt+MpMcTerU+o/?=
 =?us-ascii?Q?EsGWFfpX7i/pdWg/1J2PSzy61IPFMpsq28TZWSFZ9YQHSn2RwXSE0c3l4ER6?=
 =?us-ascii?Q?PlwusFZZ2RImcVUH853pcyNCy4iumrrbfXOh7H3Na04n/R+mB/o/EsoIhgSj?=
 =?us-ascii?Q?q9/T0N5fyySnMDz2ffp258wVbNm3t5FPSIgxgRIZWooX/t3V50gAQ/euj63a?=
 =?us-ascii?Q?J1OmMGnq1alBOeaLl1FzeVAfJvyTbVOMSwMnBY+JDi8Y4IC67iaa3TQJBiwO?=
 =?us-ascii?Q?AYSe/nh3qHrPvG/Y9S5Emzi4kNyMo43e+vKBbvrfnm8/2PgfqPKovrFOjACX?=
 =?us-ascii?Q?7/6u+BkK6yGtZ+3dOq6fjlGZs8XH/OPAhMCl+IZLGl8OqGaWeEJRwMtN9y2W?=
 =?us-ascii?Q?p8mN8o2uDooiU4ZIrPnq4dAadLqFTK0c0BT86pXiVy3I3lad/ADcs92bZCHf?=
 =?us-ascii?Q?F9DqDS01hl+UR8ke6akx3qHyx/lOiLM+OCJz9vyexghwXY8TlUOMQjl90I1s?=
 =?us-ascii?Q?JNCtru/6fWWyUsMXjKmPyTCcTxRF2+X9s3bqwk/5VNrbuQNjHBmC1rT85B1r?=
 =?us-ascii?Q?Ch9ZcZKDAxxQUb4CiWAs4/e9A9wxi1+yPc8SU9zdmO5/GsrKSE8sF+niNifn?=
 =?us-ascii?Q?8EdXTeJuH7m9n07ody0bDUAn2OfpTu3GfMffnth+dxLrWKnIgq74tcCG34oB?=
 =?us-ascii?Q?/Xsv9ySIJff/heCI9TXgjClIa//iYFfzdM/m0CTLKl/hexnGq6R+EuJ8kZ1P?=
 =?us-ascii?Q?4D1xUYHm3f8vUEq4a4FYOztnRJHgmoPaBCPK7KkXz+AjC0VuRDG7VvZi4KgV?=
 =?us-ascii?Q?QRyQr43KKC0FzTROU+F+x9nPmVtM4Dhm31sggyt8PhZyhs+l/AmXmbNpNOW+?=
 =?us-ascii?Q?FdXpZis3CwDwSCkOXJhHTKYlW+j2SMAaaUoIQt1lQ57vUr+Y39lRWUqvTgv0?=
 =?us-ascii?Q?U94sAmHd3SqvjxFeghy0ChZsfhDIex9d5bXqbWQ4YlJd/C03AOl09Uu86aMY?=
 =?us-ascii?Q?zidt4qZzEunRPhJunoZK4SxHnPLQNElOyblmQJHI1iO4it0GlOyuloRqc6Kq?=
 =?us-ascii?Q?f6+ZG5VXCl+Gcc3pmixSr4izovD+IRHQIV3C6lOmB0DbShEksoaNifWTZ4YA?=
 =?us-ascii?Q?HUd5tWUL/JaUP96XF+pkGUgfQFXIkR6JaKJqZDmbzen9iXNmErtAzf2UyMrG?=
 =?us-ascii?Q?CMGErAK4kYTQiUL0k2uxHsoIeGbS7oetZNIlbf5M8TvG/9ol8ErU+JrWNW/b?=
 =?us-ascii?Q?4wl62OzFOU69x/tudTwd706765E3BwSX2vVRfK04sgh1W/G6gMDv+eAlpWZL?=
 =?us-ascii?Q?gK8PH2cNZCQjsGRJPsRWXf9IgxyIn/GkV+K+0fEfKga3XB1tdULD1eNI/td5?=
 =?us-ascii?Q?A8xLHLbCpL6jXnfGcB8Bj4RMIXRm4nM59To3/cHAGHUrOdUQYCdGqJWIIvbt?=
 =?us-ascii?Q?Q3meeRyyY+tRVutWQnLvAKGNdZz0Y8FQgclW?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:09.2705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e824a0c9-0021-4247-e62f-08dddea30481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2046

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


