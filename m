Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2876CA0EE0
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:46:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.63])
 by mx.groups.io with SMTP id smtpd.web10.57317.1754941613897139228
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=uWiIzw/f;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.220.63, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxaVTHw1k4XdcQv0FMt/CJoomiKu6czHQYjZ7q+Rt4fUcjyNjgHbIfpYhc0OtJKGUPi2wfo7Fgp5061GC/ZLj6eRdFNwFNYLZbTO8x/OKcHPFz9WcMxexCHl83sWXu3CjECbFLkZNTFd2RFozoQmd6q7agl3t4pRsBNKoaG8EuH05+DhgPoax2C5Y5i9HmtVGWIm454vvO8cNq/OsK+APxGfUrVaZPGicYqkJO9Oy+Ju6ksC3ti95qfPT3BSgGGniROaiUC1nOWvPNfjU4a3837QTOfIg0A/hfo9RQSXbHnIA7d1Utg/nRekZTenfqgS5MweOHtXILnowp3PBs4S7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiQihd3bLAf6AZAPBtb3sDQSmqHGxv6qBzljVd/y/wY=;
 b=HILJx1zLF3xFF0Edaud3Krit5dUBApGOlxdmC58pDMPnCWidGYcKZXojeFC3Yi8p3PxWmQkp8Slj3HwKnvLNKOV6l0LBn8eOQg1av2Qr+y+BMeXaksFroo/rSCBxvLt8DrQkiWrz9HjyRtAYiXlT+a32okJz3DU4V9jkCNumDahNXzhM88F7tXpTJK6m4prXPUWgUl8DrOvxruISjbRlCNIOFDiyTgKOpghywa20r9k8n0pWMWiXNaw8mNyq0IojUXfGVCdCbtg1b3zk8ewiDcs17glqj9CA5bpe9AIHkATt0HMSfWRq/GKjmMsozsd/O6UycCrdSTZkrLzeiIHZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiQihd3bLAf6AZAPBtb3sDQSmqHGxv6qBzljVd/y/wY=;
 b=uWiIzw/fUpOt3Cqrhh4+aRCuiVlX998OKJGl3Qc7YfbKh3XdIZqy/T6vWVruwV5Q2zIogZ/UCVMX1tkGzT+jTo+HQFFUpZrck6NvuRMZr6ddimYyEAAmvAzWlfao1JqJ5N2QTA/5gIMBZ+KGZof9d85hHklmL0noD1BfJx4TIH0=
Received: from SJ0PR03CA0105.namprd03.prod.outlook.com (2603:10b6:a03:333::20)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 19:46:51 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::2f) by SJ0PR03CA0105.outlook.office365.com
 (2603:10b6:a03:333::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 19:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:48 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:48 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 4/13] layer: Set PREFERRED_VERSION for kernel and sdk
Date: Mon, 11 Aug 2025 13:46:37 -0600
Message-ID: <20250811194646.3408854-5-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1513c3-e92f-4490-7a5c-08ddd90fcffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QzLZeo6AZ5wpG5f92TJTiCKE7fuIPw00UmsvQZ3Jy6hX3UyJ5sdjwWh5J3qX?=
 =?us-ascii?Q?h8ekPWKqVU61xQ057JfHNZSK62HzsqPEjOwMEZaScLO8YSSIvr+1YODe0ksM?=
 =?us-ascii?Q?CoCjf4sZDcnpOUsd1LGEvjqTAhZROQA/GgZ3gasHvGiXF67annwfjDGssTf+?=
 =?us-ascii?Q?Vaokyc74m8EYINUiVU7GFMBqN6lgn99Pu02LofjoJuyDRYMjhHn/a9BD6WTN?=
 =?us-ascii?Q?ODd3ppe/2q5ASeZNEVQIyi1Zja7q6C98oS/dYDNNseqXQL9z+3Pe40kdCgiH?=
 =?us-ascii?Q?y0L7s6uwTXp3Sj3mRt3YGUL9cGm7hZ2YjHlRwHiGCwUhsC/jEueoOVuArv1v?=
 =?us-ascii?Q?vuw4ENqXCU6CfJgQe8MfKkMxU64EgrFA8hjLoc5CLGJZZY9hW0++nKRpyXl1?=
 =?us-ascii?Q?MjXqaxdfKxJfhGioZQx+6j0K1oX1hbIEVYnF6PuhqKRvDi5B1Adw3NqzdW59?=
 =?us-ascii?Q?c4eD1PH5Bp8zqI6kuGqVlaK5n0jr7OrC8ChKJI7WLSI6h7DTyCKI9JsTlG9L?=
 =?us-ascii?Q?XCEff53CEROxV0OwS/Ls2awxc5fKQMWJyw4zaMVw/oKu8NwlVFixcQigh6tJ?=
 =?us-ascii?Q?xxnYJND5B5ZtJ7SVIF7cGKDNJSv2BYugGWaMdP6vkhyco+yDSWNgh2TqWwqw?=
 =?us-ascii?Q?dTG0k8eO4ZSFVG8Dj3WbZTd2hh8FZP5oEmxLwi2TQbQcbY6pWaEBiFHxR0k1?=
 =?us-ascii?Q?Aiw111PwSS4vzp15j08OlmiVX0DcaLFDFxbsjVkWAEED2VnVOb3cTe4/6rwS?=
 =?us-ascii?Q?ts8LEF391aj53Lf/OG4leI5wMtomxvh8fIQUnUTDWZyeDA7dlMpLK1qERJCy?=
 =?us-ascii?Q?5LPoZ6ZLcKSkxRyP8hqH6mJ53cAuaJ1l1Ms2akVEKPE99pG/q6pIeaKmHvvE?=
 =?us-ascii?Q?X0aL8mCwcOWZzcrsNQlLMSJEN642dLx047tQw47o/8HQNw+CxSXy6Op9A2a/?=
 =?us-ascii?Q?CMcCXcmSbb10D9mozUcz+8IRxLkHfNSUnaPzaEC9VCrEqqq62N56GI5c2FO9?=
 =?us-ascii?Q?1IsRZ1/eOhJbV7t+/J25HoOGBHM391uDiEcZLfRHKbchaO2Jr06sScVQ/xQE?=
 =?us-ascii?Q?U+3HDKmZSbaFBEmyjfPgIdn3Vw3xO5tOYU8Rt6Agl+DOFGm/D3ou+MTsLBiD?=
 =?us-ascii?Q?Xox/gf0LHnpm41Uk5ycvLGU8HzWjcIqwfIT636YLOPbGlCyLgNUfbmHxwUSf?=
 =?us-ascii?Q?4/j2ABDlMKscgU0v9me4tcgfPRpCzLvPdVGOesZPRD6UnsY6dt1Qt47XXs/Y?=
 =?us-ascii?Q?vevO+wxNvd/HLv5lGEo7SBMZ5GLX0Smr8+NXPY6XFDw1zsuEyCsrFfYYz/2r?=
 =?us-ascii?Q?rX5v6Aips1gmzXCiNpL+SGfqpoBClYG5DL/Z/P+YRnY1CDbnxbAwIRiLPgzc?=
 =?us-ascii?Q?jlAxjeSRo/iSWL7TtyOwZfyu5s7T/oAboovN+Z/YZVo2tjci3KhpNiW9O3/i?=
 =?us-ascii?Q?DNIjCgo8a0dJ75ZMPnm9lWCX2uTzbUxFAgZtjdpsaZILX8eI+dFED6os73M0?=
 =?us-ascii?Q?zwxYUhegwUz2DxmrrBVBK/GgwiZJVuthJ9Bl?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:49.2423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1513c3-e92f-4490-7a5c-08ddd90fcffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1949

Set default stable PREFERRED_VERSION for kernel and sdk.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/conf/layer.conf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer=
.conf
index e1bb263..e355b3f 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -20,3 +20,7 @@ LAYERSERIES_COMPAT_zephyrcore =3D "kirkstone scarthgap"
 PYTHON3_NATIVE_SITEPACKAGES_DIR =3D "${libdir_native}/${PYTHON3_DIR}/site-=
packages"
=20
 addpylib ${LAYERDIR}/lib oeqa
+
+# Default to a stable version
+PREFERRED_VERSION_zephyr-kernel ??=3D "3.6.0"
+PREFERRED_VERSION_zephyr-sdk ??=3D "0.16.9"
--=20
2.34.1


