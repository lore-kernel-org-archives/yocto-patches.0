Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14973CA0EC5
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 14:59:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.79])
 by mx.groups.io with SMTP id smtpd.web11.49948.1754924394808354405
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=VsZrmVz7;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.79, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJgOkfJu3ZOYj9rFUekmYSqd67aGtXwVAKQO4DT+taY8fOOE/lAhYHLI9CFQ/hiHJ31y+/WqZfDQh6z9U6F93LZA0f1i45qDzzCJpnW5hikuQx0Ndm6mr4eD8MvzKfhnr/P+WHivybey0fSH1PdaBFSDOvN+W6FI3qJRKn2GN6o8ja9S4lquLKxJywo23xIroqbqXk9lQs7acA9cE1i94QQ2TXL4KsZ1VPwe3aKC3GT2r/NKm/D5WeYfE9RT8f8/zszeICPkU/X1iFGOoy4Sc+3mwdAIQLaWeAcYWAdteg7+3AkTR08MQBi38MV540G4BKjvBQsbHZuDwguFMgfyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10E1QjRBllYheXG0z3khl52zhcmByD/4qTcS21Vm1gg=;
 b=ej0hFUsDvPJolOmAhlftqsR5cpGVs4h6uzgbSRMEiEcXK4OkCzBaS6KHNiwY5j0yIzvTp+sWCJG+y5DqlltlgupjTQT6KmpacVRXGBcRirvrVrqMN4wcZQF+mjsqdh4L7nRnxLhheiNvNklVlzgqNLwt45R2ssm519Vl56UTT6L7hkiRRc40JlSfyNjl74FDGw++cUKrZTT3JvoF8uO4/a/ypNV4g4GG0VT38E7Bifq/B/odlpTuDcH1desRbzBOai1h8yIkWo4KLICjsarASKpbgyWYw+m9Mc8LRcRm4/Zhu+7BkBNWY+kjN9z9HHZ2dKtnk1SFQCPNjsomVGMOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10E1QjRBllYheXG0z3khl52zhcmByD/4qTcS21Vm1gg=;
 b=VsZrmVz7kZJNozHVBfCJVYsaYFstun1zCGZZk033iS71vILeaSTnnksv8gvuS44MPa/P+F04lbDut3gw2y7KFaM++QTSHUp/LKmjll9bcWeJPX+L1oD2gOjNgs7a3jMUWBzj66Wcgf2FVVTGIolLcdXk4fDyq1m7PPVSM55t+dw=
Received: from BN9PR03CA0250.namprd03.prod.outlook.com (2603:10b6:408:ff::15)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:52 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::93) by BN9PR03CA0250.outlook.office365.com
 (2603:10b6:408:ff::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 14:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:50 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:50 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 11/13] classes-recipe: Convert zephyr-sample inc file to bbclass
Date: Mon, 11 Aug 2025 08:59:39 -0600
Message-ID: <20250811145941.2553838-12-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
References: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: c8144311-d3a4-472f-eb83-08ddd8e7b948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VU4MuURHaRoy8kXAMobHt1KemDrk7t5kG095S2zztfniuk8FPfnWNbhlQHpF?=
 =?us-ascii?Q?RFsqBIrq0zJV8xQTJJwiswIxBDFr8XoxVxYhm8rsDAYSv1xhSXDXbabkegjm?=
 =?us-ascii?Q?IZQotqi4F1NFicxL0LQNzWihfGe4nmyh3OR7ACW0u1wUABi3VPs7IGYz5v1J?=
 =?us-ascii?Q?4j32LN4dphrvJWuIeRz6P6ciOaM1L+yP9SotRrOHlFkPRYPoemYCWN5nHKIp?=
 =?us-ascii?Q?no92qsZGDh1I45YBTLj7SMwA9OZoZ/Xik+J/avdggPBuMGkJsllwcttRe+tc?=
 =?us-ascii?Q?JyE/hm9VQBelVXzCZGpX4JnIPPgvF7EnyMtbbkN6IpYNYZdhm2NfyXVHqP3u?=
 =?us-ascii?Q?Eq+w2zPt5jU7PIVi6GtaP81KUeMjRJPGrM0F8cRGthtSOeuSINdoEde+CMjq?=
 =?us-ascii?Q?Lahw7jVEy9Q/cp2kFVB0yrMgSd87hb1gxV4HcEJ9ao/zmCYlR707/41/Hyw7?=
 =?us-ascii?Q?krQhqh6TfNWYD8Q6QB0htdVZaZVD1tIK74nIjZIG1EWRHiYOxIFg6/znPhGO?=
 =?us-ascii?Q?RrYkH2UXCH5jtF96F9cg0SVYYIbMQN9nkgyIu2OvxZ1m7NdxSBwZlYAKB606?=
 =?us-ascii?Q?nmXWb5FvG0LCkQgGcGH+64WODE7scPoC+MLM/E+30uTdETeENK/5BCDgZKOE?=
 =?us-ascii?Q?/BTunqN3g6b4cEZtqD9zVeR+l1gKJWp3Llz98McrwPdZWasXwQ42xwoIzMpJ?=
 =?us-ascii?Q?ixEwP63/cuBK5kaON6MMuEkpAv27qmVQO8wCyf/AeIPM0xxuf//cWcrxuFjG?=
 =?us-ascii?Q?EEXCpJ3Lqjkijec1/LwF3gI6o97wPeliWOfCSrCiL7FQgUOffUYPQNSQFCRC?=
 =?us-ascii?Q?D5294zJ3VM8aWwh5A7POBFBx84VdqGMknEsBD0d+1bnF+fdLyNhoRINLqZZ4?=
 =?us-ascii?Q?/LSyrDdXR2hhUC49mZcQbcSuX0y83BoeA+fezVD5gIjeNTcyGntADHwvmsv5?=
 =?us-ascii?Q?Y7xt/0J0v1Bu1QwjhdjP0UNsbzWqsoUjHyoMAtYyxs8CmTpesAhw2Tamkoa2?=
 =?us-ascii?Q?6vzfUEI4sf3RJusyX5ZRZ34YCksELgLzrXqQTNJzZUboa+rolIAEgQUZAYae?=
 =?us-ascii?Q?s4W7NS6r7dy2reNu5QyFcDhOjLlUEYpGMFbigVjjOzB9kIxLtyvQYxZySCH3?=
 =?us-ascii?Q?FsMcY2WOXdRYFUTJFbxF7Qxrg5ROv12rRoXQSx9jaiDcWIJMO87EhKeFAsCJ?=
 =?us-ascii?Q?LLeEaiKfyLKWOzd3Oc4v1rxcdLyO/FeSnPoiw3dG5L+Cnfau3EumW/ViL+jQ?=
 =?us-ascii?Q?V+/6fO7IDF8a9Yy0/G9BlL3K8ddA2cGd3Fx0EaL+87fvNoDY5bapKcuG+oCz?=
 =?us-ascii?Q?08a793nrRH31rtjTyOdoWV3v3CsvpRH8S27oZLOxH9ZgQcIKyzsFZc1aFG9Q?=
 =?us-ascii?Q?0+3Eia/bVWnCyUbUM3diq/Nl9zO5uI8gH/B8LonDb6ZuVn7k7gyzAIvB6GXe?=
 =?us-ascii?Q?GzJosB/ZTCyn+j9F1HpbXezDTt05kHeudXeD6YnmU9RC6uwD5aczeK7o179J?=
 =?us-ascii?Q?v/hDXg5YbXGt/dL7cOGEG0g9FLfg04PkBvDr?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:51.3618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8144311-d3a4-472f-eb83-08ddd8e7b948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 14:59:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1936

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


