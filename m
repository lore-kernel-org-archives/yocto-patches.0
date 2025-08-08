Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F8CA0EC0
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 17:58:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.84])
 by mx.groups.io with SMTP id smtpd.web10.28859.1754675920097850589
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 10:58:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=NQ3iiSVg;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.93.84, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agWrF3jR9QivWA23/QOgKsSz7fJVPrW0MXnvoGq+g91NevefqH0HCLOwPP2uD67oy607y/RY2FzUJxboqEk3PiiabOmwqasY261BBUmyTherWIy0DfDG9xOaqLxAStFsR2z2EUWxTixKr+LpvZXlL+UBkWpUxDIeRvHi/r8BjzNVyokIUusKef8kJbFhDjZV4q1cFj2emuPGm5zOeiUuR2D11hIpY0pCISIOekONIXbJ962C5jHJsrxe47gxGoju9xm4NBakdZcwtQbXTBO418IyYrd66qO8UAwZIXZV7dBsK/tZN1I1w7XDpTMiMXuf/ioAXqR5yQ9QymSHHLH21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XOEn80WT02WBG1CBZq3qagpOthkZ4xWGfPPmn5AIaY=;
 b=qmI6weP+m+YXjz/l/yKAZeQfU+mv3Q9IEdmNfpVZKDh3g3fqGEEbsWjwuWB57iGXWypa3E+LZWKv6sJzi+6gZwBwipwvkwxkLhjjzst0tVpbWwHB2SK4MZV+u9lYd+KbAI5BbLyitTHtMxzzMn8CitiPUE4fz06wQqULZonOz2QovuwRWEwOfRspRJRu8EjksfIhMtR53waw037Iab79zMN24YAu1xTWY443oIGhuT8xCD+kxSdHpRbzsovubjt4eU3Zc4CTxmyo5nj51hPzBgm8hmsaXUk3i8nUHDPpEEMcynU45Ui5xSQNiUOFbf3j4PKTwjnT1XKgwIN3fMPeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XOEn80WT02WBG1CBZq3qagpOthkZ4xWGfPPmn5AIaY=;
 b=NQ3iiSVgQKMuaOvimBrZMLeV1yrGQPXxlqV3HBwd/W1HOKNzKZ8CYeSgFhaEC23W7lgPo7YEAskktxnqUtbrqzfgaHfOECJ3x3lKG2aJ69P5pWslC+Gd6uPesB2gRMnxUt/UElYoeY/IZuplgr7YnA8q1N7VTda4yrE94SIc8A0=
Received: from BYAPR07CA0093.namprd07.prod.outlook.com (2603:10b6:a03:12b::34)
 by DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 17:58:38 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::ed) by BYAPR07CA0093.outlook.office365.com
 (2603:10b6:a03:12b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 17:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 17:58:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:33 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Aug 2025 12:58:33 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH 9/9] zephyr-kernel: Add rpmsg multi services recipe
Date: Fri, 8 Aug 2025 11:58:29 -0600
Message-ID: <20250808175829.3830489-10-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c41110-5ce5-4310-ebaf-08ddd6a53358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3DS09aDLnitvqKK1BM6lf5HKHb3g402QXOqqeDbPAVzBgosFBnmiOZaQ5rac?=
 =?us-ascii?Q?+OfSayOBFXkZ3PjrWhKbC0+FO2FG8EbcYb8sebawGmcO73HV3TdIOjrNiGoU?=
 =?us-ascii?Q?7hiuMcPODIBEO6gJbmuWEcnGbhOXbvMRD+oSTruJAsufhO1DnyQRPzn/4I3M?=
 =?us-ascii?Q?/CxNXaMc1iNlPGHmgnSwFqV2J13/53PnTmG4nTJrnGrW4J8waXA7IwEnXxrU?=
 =?us-ascii?Q?mLPSUV+nK4miKcCVC1JUtKbgiIQ4/xdadtiGX5mtih8M+VlmsPxT5iuCSEMz?=
 =?us-ascii?Q?04tEz5o2MwUzealskbkem1UU+EhUjO/2KsODOee8FUf09yAIKmWbqtC646RK?=
 =?us-ascii?Q?KwBiUJ7BqbGc0xgt0Yfm8yhM0hMfPaX1rjzAAM35ZmYOL7i13nnpOKLHbPsj?=
 =?us-ascii?Q?DNeoBePuoS5VRn3v/UU/xRdxNjT4wRmxQqSgwcHV5FIpTtNf8y/OX8BjEu2T?=
 =?us-ascii?Q?1odYPQ3lgEBNCS4rGbM7sOeKaq3JFc1pYWPHS0btG7X0Q9krrjVOFC6Y5h1b?=
 =?us-ascii?Q?/4h1b+H/Cnt/+KTEnIBmYBkl2btKd//yuVcsDXBSeigi9NsTTzGKW8GeiRPe?=
 =?us-ascii?Q?aJiTH69KZXG0TVCmivu8hZj9ac3nz8hpGCqz3lXo8uGAFDZh/S+q8q1YTCSQ?=
 =?us-ascii?Q?5myK+zZMVuaViDlQw4CkgDW6h7sBx+ZVkOfOPoDGdd6cjhhbgWI1IGgvv/A2?=
 =?us-ascii?Q?nzaEtMpreWFMpCMGY7UhE8F1JbLqbbmeP67yzeAufl+scz/A9B3U2UQrfBnK?=
 =?us-ascii?Q?v8ByNovY7T3K3Q8IrUIkq7sa8+cbgN6VlFVYrPVzrXgJNu47m3KEm8CuhNrJ?=
 =?us-ascii?Q?ryCQGpxEuoggBBaDPi35wlHXg3arxTxnh33PJ5kcAUXOkKSHhYR2dZYp1AeE?=
 =?us-ascii?Q?pRDZgLBM3SNiqFlO8aF3v3VORBt6G8/6qc46ktZBK8g0JvxoEW+DfhJHN3Kj?=
 =?us-ascii?Q?zYXZMRKCHmFAtpR3snVp0sMxeg7iBQiwfirbN+bi0o4nQDRGhgrk50eh5jAK?=
 =?us-ascii?Q?80pPbg9wbK8RFYoCGiJo66mTXf6cmzkugJDulDt5APb/zbE0lsDA7GsIaXII?=
 =?us-ascii?Q?d8jRjMOBtgXcqTnMowR5OyB+PQ4OBNHOJeDguCrGfYJ5CR3px3yJT5OtRluv?=
 =?us-ascii?Q?C1osPVUwuWcE16jIs4Pv0yXgDflMyc0VxsBZyu46bff8N7zF/daZHmsyGch9?=
 =?us-ascii?Q?LCeCkYpAVMxHfHR7dEPwnzc/63qXAR7YPFB0X2OpCqnFai06R8A9eMK9oHvc?=
 =?us-ascii?Q?GkLBG29u98sVCIsQtFZR0xI4CMdk+FJ09T0bB8RTY2r2gYMH8tjs3oyYZSuK?=
 =?us-ascii?Q?ccawa4Or+4uiVlo3iy8ezPr3ut/58r8A8rOEUscfJ8/hJRmUely4xNw0KbBy?=
 =?us-ascii?Q?+vQkrWzL+uI/vGOtvA03ERK6m5PJe9h8A3xgfeWXNDMW6AclBd7LodWZlZiA?=
 =?us-ascii?Q?582kURncZQ5OhUvPlAkdjh6YDy7hKSBLBmGlwgOwr5vR6lk+sl/lt7Sv58yd?=
 =?us-ascii?Q?X2nE7DVbXRs0ztGjuIuZAqj/8Hbuw2Y4qmWK?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:37.5141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c41110-5ce5-4310-ebaf-08ddd6a53358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 17:58:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1906

Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
openamp-system-reference example applications.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-openamp-rpmsg-multi-srv.bb         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-r=
pmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb
new file mode 100644
index 0000000..1314766
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-mu=
lti-srv.bb
@@ -0,0 +1,23 @@
+SUMMARY =3D "Open AMP rpmsg mulit services"
+DESCRIPTION =3D "Open AMP rpmsg mulit services"
+
+include zephyr-sample.inc
+
+SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=3D "git:///github.com/OpenAMP/openamp-sy=
stem-reference;protocol=3Dhttps"
+
+BRANCH ?=3D "v2024.05"
+BRANCHARG =3D "${@['nobranch=3D1', 'branch=3D${BRANCH}'][d.getVar('BRANCH'=
, True) !=3D '']}"
+
+SRC_URI:append =3D " \
+    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=3Dopen-amp-sys-ref;${BRANCHARG=
};destsuffix=3Dgit/open-amp-sys-ref \
+    "
+
+SRCREV_open-amp-sys-ref =3D "d78315763fbacba8a74552d0ad570bd01c42ccf9"
+
+ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/../open-amp-sys-ref/examples/zephyr/rpm=
sg_multi_services"
+
+ZEPHYR_MAKE_OUTPUT =3D "rpmsg_multi_services.elf"
+
+EXTRA_OECMAKE +=3D " \
+    -DCONF_FILE=3D"prj.conf" \
+    "
--=20
2.34.1


