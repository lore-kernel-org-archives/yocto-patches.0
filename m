Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625BEC87FDA
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.64])
 by mx.groups.io with SMTP id smtpd.web10.36653.1754869172691676362
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=PgZz2zlu;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.64, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JveNUtfZnXXNv9QJ4WEjHa61/iwGQi6t/xO+raBdkI9Vt5yJ7qsOcLv7VaqXSjX9wGD+o6iH1Sbn6+Ai3u78Qnvd1R9f9D+DvKp5bS2ex2UdvJkJhjGsE30GfaMgK7H6HjNDA6UyVid8MNn3p9omo17LBXNyeiriblee3hI2SYqWMCkxWH98ukk9wDGdEIDAqCTpXuPNA0/QiK7Bb9ZCjXovwE8OR4xFRiqeYXT8YqV7zfp2tvFqaxGFZcAeKcsdmA0xIBx4YnswrBIuvWlKNcwn86ZxxDk2qhHYyw/tuyCSyWZsQG01XT4nTYp/7hjKBzDKBpIg5ylwlzFmMjYHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10E1QjRBllYheXG0z3khl52zhcmByD/4qTcS21Vm1gg=;
 b=y1j8amgRcrAyBkKcUEKgChPu+JJhzd53T7HZ0l7anwdPfBpVVR42vAIDmY2k0c+7KdYY0QTWe8ocWrdofpprILKkznDKZsIh+icgWGQ3eq7GXW3JSZYujAnK6xj+WLmMXGURVZxsxsddrDZ3uAQPKu9yKo1DNcAppiwM6uPPluyNjYPdXuVo01jH+lzv91/UI267CM+a/urQyCIUHGdrSE0zDduSojFx389q3YH816ZmzILveVB/btoeTLie7ylzqxNPOLbl5tD3mzC+tl5A9Acyx4yfeSraV10HA0VM1ytA6FNwMwCKG8vPyGZgRsLQc7fE7fOcoP/mdPgqM7MWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10E1QjRBllYheXG0z3khl52zhcmByD/4qTcS21Vm1gg=;
 b=PgZz2zluz+DZLO0+RBMW7oUBX5zo3XBv8CNKc075ma6WXcGxCN9AnbuileJagcJvC0S6fAE8wXaNN9xEwPKRniBJxkT13PhdGIlR9A5tvvA6M9OoxjQw+g0dqEcIiyZQxvp7zvrOhJwqoHPeQVzSGWuZ7ZnaFGF1/5bbRVqfpQ0=
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Sun, 10 Aug
 2025 23:39:24 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::d0) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Sun,
 10 Aug 2025 23:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:20 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:20 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 11/12] classes-recipe: Convert zephyr-sample inc file to bbclass
Date: Sun, 10 Aug 2025 17:39:10 -0600
Message-ID: <20250810233911.1259884-12-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 64222f76-1201-4e9c-658c-08ddd8672396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/IKqjFJVaoYR4OdvXA1PIQ6h5ixAhVjDkZSkdzueDX7fP6mS0FjH47o1EV3L?=
 =?us-ascii?Q?yiwaQweIJuT5Rnrr3kDbZ3Os+5KM9DJSJrMDojTp+juzfJC8EGl8mCzg77nH?=
 =?us-ascii?Q?cZ8+JQzFJrkvpkuyZ57IURUD/vyDGZMhnv8OO0hdzKpfvdqRU1zI4Phlmbdw?=
 =?us-ascii?Q?93iW5sD1mO9JIu2pPdlClU3k3g7CWwkxIwiJkRPGiKj7tqsIoNPKsKireum6?=
 =?us-ascii?Q?aUffrPdXt/cxOjgqA4UvICJai/ZKKwweeLRgBTiLMEYkZjDXZdwVk+h/A3gL?=
 =?us-ascii?Q?a/w7CrUN5pHoWcBDs64SdspnaTvIBBUkDIFsw8jbAA9hca87RDPwI02XZucQ?=
 =?us-ascii?Q?c/LFYDfDFqJGpr6KzdBy/KTSg727JbKkbb7T31PrxMP+j7Vwp9H+FO6/ZSK5?=
 =?us-ascii?Q?mp3FVUKVtb5DOwASUWjF3MfUhYrW+XGJ9GazZYYtNU7AQLE5vuemhNLqs9yr?=
 =?us-ascii?Q?7mdBwOtEW+G5fXnOQxI1PkSjz3jHj03MkLmJmFMfTQU3jHScTw3s2qPFpGNE?=
 =?us-ascii?Q?lNQOEiKDSZXBcGwS4BHaoe5QdP5ZaYJBXNQ/rqY6NUbFbTlHSDl3XLJ8Y66I?=
 =?us-ascii?Q?vwWZpXMn8YXJKSDOPidOrdJ4xncSzOkhbi88Y+t0c7IzJ+x61txOMG9WKyX5?=
 =?us-ascii?Q?78pmIY8fLu8rlhWx1rR3jeAyYEhDpxW8TCunARUF9AYRJG+4bNF5Ja9sYwcW?=
 =?us-ascii?Q?ONAuoTH0F+kgXbtbIgGUblYoW1E1ofGGBBFdQRBA2anjyDfqPigzGeCid1zY?=
 =?us-ascii?Q?YFl8f3Ak7OyGh//nbfPRpge1NAyGduecI+os4vf1zW5HZj/LKiGm/PACKeST?=
 =?us-ascii?Q?tRcGAKQJTshMB/UQ5nIuWZeBTNcKa8tWAltiNBx2Aw+vvhByoU/1/Nzd+Y5Q?=
 =?us-ascii?Q?22indb84V45chNL2ey46YKIpgS5IUvcDuRCmeQDn7c1BeVefslOYJojABlNc?=
 =?us-ascii?Q?NPpnFKlBeK9vOHJoZ1b5b64L2jHA/FPbEl9a+Yw8do215c5WOSsr7vbqKSJx?=
 =?us-ascii?Q?PXP4zuLWFfUb5jF1skZQ3rpU+kbYxlbnS0idF+FbNf0/RT9izJBxgLTVoXwz?=
 =?us-ascii?Q?hOdy4gQYZBXeGSPrVfwQg0qh7jv+RSLvDw1X+jGyghJQ5Vmmt1IZgb0DPQeE?=
 =?us-ascii?Q?NtNjHoaMeyIlEjo2xh/bjtFBzw1ypiKSa3BIAiD5iYwlCng2pDKvtLyJDWlT?=
 =?us-ascii?Q?zcSsHO43D2XMaPyTxiYt7vt52dt/NoQApra2Wvg9gWRd3t8cd/vPilj3Pmfx?=
 =?us-ascii?Q?aL0UOFja0wAnBo33BY7k3hbjT2XW4hoVSPqWEy3+p9U/gUADfdC2KuXpQJTk?=
 =?us-ascii?Q?/ZD/ZZPnB5T3IeYu6ys3k0AenDc4n+kvyTnN/FrRwbbR/EArTS739fP/ItMc?=
 =?us-ascii?Q?CVEBesuZx7+v+GndGViJBYuYP2o0QFTHu2qRKMFXTytyKfuMzbpKLvs0szC9?=
 =?us-ascii?Q?2WajH3FB1/LLN7dm7uiwswmX0yqkHQoVNG+SMAYq7uBbES4KNKsCysyJyCKE?=
 =?us-ascii?Q?VyB0uv7XwGm3z+msZiL58lQsxCQSEL4AGSmr?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:24.5424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64222f76-1201-4e9c-658c-08ddd8672396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1922

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


