Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D2FCA0EC8
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.41])
 by mx.groups.io with SMTP id smtpd.web10.36646.1754869166029291579
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=dpDhKmBj;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.41, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoelxOSemDuVdbeus6WXjOMGoJiyShPlWxBXDsGadMwrgYRjBzCO5tzaNfQp9N9OZ/C2n1B+jAPldkO3LPUG3XbYH6hvzY6u0a3nmkSI9ZLmEwX0mYLstGo5I1r6XmsaUAa0Qc0eFjakXh40PZFpHrILNoa5j+sIZBr5z7NMX6za5pqsgwwBV22khsr21rmQm0+MUZoz/lvbU8zDNPsdUm1n1geAd7gEM24AEuGWuXYbNd2ORH5nMi3d+sSiSdK1HgvhDfJzED44y2g35dkqRTSU9uTl9/1mKccXcCXu+y2dZroS0CeMEi8p+XhbQWfXtrJcWrMPPSKGop2rrg9SVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYzt/v9wqiZE6y4AizGasoK/eWs0l+YqxrypKDI+iME=;
 b=sGsgpVKQlDA92WQCVbSJuGC4wbRvuhi7YTrRRq5iqEV1JMU9OlW8WJZb+OrfUkYA9PT/o2XigqT9oXo6p4xHiM9EV9828sww3zR2Z/hVouvQl8jO9qlG6YSi9+1Ejky2z3uCLjPhD8VtNl3eBNjL5TaMlFgCAgN8swrl93SE10Ok06aXgF60d7/AXgKDYhDM3TJH4wsdKikMN5Aq7Zih6s6DknYtSviVamrNE1nVIGTBO9fodQT+l2vz54vAvQbY6kGjsRV8r9lz5roIC3yMRhzW1YqTRDfRftJyVpcB9i10cdEiIGQQuHHyk9GCrQXiG+dhCmJlyJUItfnN1ZgZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYzt/v9wqiZE6y4AizGasoK/eWs0l+YqxrypKDI+iME=;
 b=dpDhKmBjLlytKHnoD4AoAhazKcEEcaOGgTWETkinNBO//cQTfqC2jI+lOoOm7usKQK3xR2t2FW+GmjwUf52mNS81ysBwBwmSz/uv4KG15L+vlNasi1k1TuaNs7AAVofzkqup7K3o1yCPiNRn9AdR2rGyrzkYSypyMOZ2YTAT5xg=
Received: from MW4PR03CA0079.namprd03.prod.outlook.com (2603:10b6:303:b6::24)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sun, 10 Aug
 2025 23:39:20 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::8c) by MW4PR03CA0079.outlook.office365.com
 (2603:10b6:303:b6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Sun,
 10 Aug 2025 23:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:17 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:17 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 3/12] zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
Date: Sun, 10 Aug 2025 17:39:02 -0600
Message-ID: <20250810233911.1259884-4-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: d676a11a-0b5a-42e3-340e-08ddd86720a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ee9kGIXpEvz2P7roRKeztA2l56FOGkmAfMamJACLyZuumMLx7C+ng13kWzVA?=
 =?us-ascii?Q?OaPDWBuIa161nlQpbXMEnnS1idUAVz3TTrOkDDJoHLH7wO2AchhvFkYGUHL/?=
 =?us-ascii?Q?HZNKxodvZCi2zOdKnJ9SM6yzwxf1M0tOT66dH7OAACIbTu7rxpcKebZtJwOX?=
 =?us-ascii?Q?vgzDnWwVS7LU0GO1BiFqTwUuDegNcmyPK/dKSplyA9nWV5iEhTr/XWPD6iyA?=
 =?us-ascii?Q?u4WVficOoR97J1JgViOzW5uNJLfuNYAD9YeVCGLTDQOM2xBb4KXW5f3+eA+J?=
 =?us-ascii?Q?SKtmCWsUqwQ9Y7XluyAKPbZf0IjYdBvGoWD7lpcSJeY1apfJHWWNkN7f/dCL?=
 =?us-ascii?Q?4OsMie2JggHgfwJSUK9u0OZQ200UcNpWqn3WxY5KD612MK5rHuIq8fhA9rP5?=
 =?us-ascii?Q?mMygln6ZhEhIiMgN4gPouQalBgT/hJ5YxD0FkKWIicwhHt5SsNC9Sx3ZP4Sp?=
 =?us-ascii?Q?U2OR9E1pttcCGE19knp6cIEsOKaX4EQVZs/rtTCQLwhueIoX2blC80/OgUlB?=
 =?us-ascii?Q?4CEeLj/1bu5xukCfWr3LV28aO3PJx3eIT9nP5A7tYRxeWvSQwgWIZK05dT7k?=
 =?us-ascii?Q?ypkMe3TCXI+EsEJdFBzLnBwlINRo17lf6Fy73A4z3345JmrkPgEb2n7FwWo3?=
 =?us-ascii?Q?1Y46DYY+gBtsPTU/e6pcLMNk2z5yzBaqfsToF8FSQpVN0idJIiR000SVOooz?=
 =?us-ascii?Q?7UAo8WYJg5bMP+MKhYn6MOLVrn6tkNskgcz1kNmOVilajcByCGukrmbXiSFN?=
 =?us-ascii?Q?DmDBq5hofR+sT1UrBYn4xGRobNoyMEZ7xo10bkWf5bkhqJ9ytlFdHmlDItBx?=
 =?us-ascii?Q?AhP1IpxxtR6emQZvR9RGIHZx61pvprcM2S6h5v1CBKDjeesSw2BNndlfqSPj?=
 =?us-ascii?Q?ndtPgoGSQH5mXJwgz0y4mRW4U6YAzo80iqZhSynLopdsoDkGwHz9uXIWW+Ku?=
 =?us-ascii?Q?Rf6jcha1NwDoxfksqL+LjNruwsJ64N0BSpNkelJbsNqgMTWUU/Cca6T7YJL+?=
 =?us-ascii?Q?tEIcUzK5cOM3SwaNkh8DvHJPH6QZ9K6q6TY4xWTY9uuqVS0AsVuSFxWZ2qHY?=
 =?us-ascii?Q?8JLrFAalJHkieupM0tefmHTUWJ3GhQ9jXkg0AIU9hidqWA2y8m/wqTo9Pa8Y?=
 =?us-ascii?Q?JO7cyjAh3HRIxVz2wx1zIwSovbriQ46SLdo83TKPeZtbCWPuthhBWP736zuD?=
 =?us-ascii?Q?TSRBNhCL6Vy3n+Q52IMN9GndONz1uzBIY+cc/S6jXJyXgpvVzXftCg5dsw8q?=
 =?us-ascii?Q?h9Dt6E7LjLnQsWR+it6LZGWHnHEDyKhUP3H+K4yUHSmCcVIFe+6DLez/yKvA?=
 =?us-ascii?Q?BlfiET7a8WpsL87fNY0BlFY7sABscM5ZPMTNAekRbN8QkvcwH8YVz3rol/2f?=
 =?us-ascii?Q?Xa3TutOhDaaecxCGPob4DIoLFM4xRwi7PG1sr8ZPdzXgbJG+VbGTWv6dGilm?=
 =?us-ascii?Q?7S3xYQ7l7jjqXMn4heYfRGD8aWicHA5fysJtz563nahAioIWzKFQ2iQSXkfs?=
 =?us-ascii?Q?o7b9fNK306SHY6j150MZUsjMvfJrd0GeKBAI?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:19.5893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d676a11a-0b5a-42e3-340e-08ddd86720a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1914

Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src.inc
as it should be some in global configuration file and override from
local.conf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc          | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-sr=
c.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
index 0b9baac..6b2b697 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
@@ -11,6 +11,4 @@ inherit cmake
 FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
 S =3D "${WORKDIR}/git"
=20
-# Default to a stable version
-PREFERRED_VERSION_zephyr-kernel ??=3D "3.6.0"
 require recipes-kernel/zephyr-kernel/zephyr-kernel-src-${PREFERRED_VERSION=
_zephyr-kernel}.inc
--=20
2.34.1


