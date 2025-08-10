Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AB0CA0ECA
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.75])
 by mx.groups.io with SMTP id smtpd.web10.36647.1754869166649796616
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=vVwOiAAC;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.75, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jd0a8kpJtTNd8gVKo01Z6/tvUVl2sDoRPdq1firNDksqfO4L66Yq86JzJR85yfCn79h5617HwexIGqg28qe7ZODDoejY2hVeL4lLHW3Kv20EhniK6W7+2+/AKYz65FNVLa1kcW5F6Osl62eeXsE/4WGIBfeLiHbmDGdZEMEGoglodGkKgb52r3+8ajFnpvnXcYulCiiYydbq0PSYwKzptVl8T8gmZL1wF+paLSgn8J5batkgeO6AHkF6C9ApelISSSETVFs3ALtFZjfUjlYG5iJ4GsHPkzcDeBZ6z5M/npPUJOYNorAKPFolMLyS5eiIyBw6kKg93J84oegGqw3QQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiQihd3bLAf6AZAPBtb3sDQSmqHGxv6qBzljVd/y/wY=;
 b=FBha16Ray+GPO8G6VQBf+/+y07F/aG+8TR9y9OM1HEQGt26z4u3lgVIxihUzaGcGtP8OqEfkPRblC3m5pYxEz3k6vAxpk13vGKIy6x2Ji0u/GhB2Pet+1gN3TYwuTLbAixPikAkkg/8jqRDIR+yZrt4fd7URDnhs028O6332t1HS7CJqOOGvXTzokOf6t6XZkzWwo+K5AgQawMgnGa/kZKzTgBkudT/LV7h4rDerIL6aIuPkdWDXcJg3w61lUBEPtDYgmpGdSF6rHpNQMC3WgWPljLzjC7wPmwT/zCQ+d4MCzjyz6UCdsr5Eg3ySjok9LOoKqlhctjB1NTbyln3+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiQihd3bLAf6AZAPBtb3sDQSmqHGxv6qBzljVd/y/wY=;
 b=vVwOiAACF2UMmhZ0qd1bx52b0iXYydXg5x1v7zbewUCr4AbZ42ZN8FT7hvsu4xT5hp9GGCeAjVTjSSma2PDGdFsinVo1VuRiGZpFrOTx4dlrLute7YkfjLknNz6AzX01oyNM6/2cooF2ycG6z94FbxHOPGE4SraaCeRtAKZ8HKU=
Received: from BY5PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:180::19)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Sun, 10 Aug
 2025 23:39:19 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::ee) by BY5PR13CA0006.outlook.office365.com
 (2603:10b6:a03:180::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Sun,
 10 Aug 2025 23:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:18 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:17 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 4/12] layer: Set PREFERRED_VERSION for kernel and sdk
Date: Sun, 10 Aug 2025 17:39:03 -0600
Message-ID: <20250810233911.1259884-5-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 300d64ed-19c1-49d7-a10e-08ddd867207a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7ZKdejUcl65/rsFUSHUFRUl8kdTKLLN9YK2F5ZkyEEmWJWySqnyRoMC5qvCL?=
 =?us-ascii?Q?b/G0PlQhvQJ4GUGaoG2sXmb+gEEhGpNuHEUybB3Y6wz8uwmxN4GHW0B4B66W?=
 =?us-ascii?Q?co1PcAyBc5s8zDKmtxL26p850vooxf6AZjRgxV96mUyDs3VMc7J8jBxzcRyc?=
 =?us-ascii?Q?L5Dea/kfEwJH6XChhvlk1HFJ5L8nXYDr1zsKiGvkP4a6WhnjCV3e3+jjVe3J?=
 =?us-ascii?Q?k4qhCG9SUcZW2yzoOAtteRByfoZclLInUPT5M3BMGncrhSJ+jEm6d/caJw+a?=
 =?us-ascii?Q?A63pZlofVwnq/7r5EWwQwE4M7JHaegpv0+V9jr+ZQmgObQD4WsYl+f8691W1?=
 =?us-ascii?Q?I96SzBRrqarfVwCm6vrWQd0ZHVZcyWFUCUuqEE83+cO5JFkj/enyo7UIyviD?=
 =?us-ascii?Q?OhBLq7inrAcO2B3MNcGM1OdbY+0haAAdkJpAJjDsvXfX78kDh6atg+6P9v5y?=
 =?us-ascii?Q?vGacKgH8+94MUZGZchCSVc3jUy35RNsm6pmj6czj61BcByWxr+w5oOOVy48P?=
 =?us-ascii?Q?/cwCyN1LbGGrDL47zO4LdooBve3bd0owl7/fnRQXjqLg3G34ZsBUPeLmt5L1?=
 =?us-ascii?Q?byNpVviUyaDeLzddquAPOTBc/2JH++hLBf3Yo7HeVDF0/VPoqv72Vu0wNzGZ?=
 =?us-ascii?Q?+Wz9iAguqvAGE5ypHcTqz/agyCV4V4pilrZaHotBQqHguDp/d4gql7hH5GNc?=
 =?us-ascii?Q?lGQWRWL/X/m2fonzghrlzjgiphjLwVxWohR4Xo72085MpA/bqBfw7vH330KH?=
 =?us-ascii?Q?WXHivZUala8psP0SvXKcgkWID2ly3cY2+8Kq4y8xMF/IKCYhrq/6M5CPfqxw?=
 =?us-ascii?Q?os3CSzKRHMp86dlrG1ug/+WOltJPNkHMKIMiZvhnsDoHb2ez2uetnIKWbmav?=
 =?us-ascii?Q?wAs/yNNXMXsIBClHuAo9s/yH4BCBzW+53JPTRQvC514NtGWgnhv7PtY9yyjy?=
 =?us-ascii?Q?6zLQwCsKQpXEuqctdo+B6v0kx84XYnv5DV4Vi+VUNM/Ue64Z3UVn2TadyTGA?=
 =?us-ascii?Q?uqLw3VrXCjjpSoGHnFiiIyx5KenzMcRICaEzPYdtFnnozhWQJbl0JFVRXHZx?=
 =?us-ascii?Q?wgOuQd4wTBqMt1qB15J2A6MKnpIizqeHM+dbSoYuZOEt28tw1k944mdRV/HO?=
 =?us-ascii?Q?DIG1786WIFva3gfCy/QHbJido9P8dipHtZmCizKv2rEvW41lksIyNTSgzO3l?=
 =?us-ascii?Q?Ki2a4QfTemD6yFV4zaPozOORPBLd679S3rGBqw/Iin+HTxGYb83tu1vJhCUy?=
 =?us-ascii?Q?CDpZEOfappgDSOYoupolHVNtufv2gbxqiYpyd5WXH6VleSDqk26krBF7Kcon?=
 =?us-ascii?Q?WINFQ6OqnucQU/VzjNbC5ksii8UnajQ5Mq8/uT6+B1oE0b9qJkEws4e16Wy3?=
 =?us-ascii?Q?BsB01cvKBdagB+NbsS+Eda06AcBrwx9cuqOr+lb2LVbFgkZ1BtiL7BYOgviJ?=
 =?us-ascii?Q?8LBQzedXoT9Mwr1D8UQiyHP+oX4mklQwIgKwR/zLEO0WOZinzsROLM3vUS1I?=
 =?us-ascii?Q?bPi9PXkhyrowPUXkj+JVzEuohIYYVqCw8+M2?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:19.3248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300d64ed-19c1-49d7-a10e-08ddd867207a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1915

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


