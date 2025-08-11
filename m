Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C50CA0EE1
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:46:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.71])
 by mx.groups.io with SMTP id smtpd.web10.57313.1754941612628907796
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=jDZEWWbZ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.101.71, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=el5yvPtD26UN57VQjGWymch6sqzZtZbOHPk2nWDbKF9Ci+IQekbzpxTUVIRqYHY5SJiPcIV45x4+Ye6oMONUtDXhU5Hci7LZHF4SHGroMVV+zSAEa6Z8HsR4yiJpyPTyzDlaUobNpBINcVcJsTEBQ38NP/kMcyFJiQQxu06biAGGAS2UJdL2E5QbmIV77+Qswsf3D17OURwEIuupMILrgbHYie/AfTpaLLiIt3lFJ1MAg4V/ddoUM7L4GcjCtXExwmZLK02bXl5FKVb0HK2mg4aVsc8TQtdS6L47+kZXj7EBjK11GCNkKEYrbZo54ZwNtthvs9XNoBRaUooVI9p1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lveJZPmL50aZHiukepUQXpbpA7E+NBV87180hWgz3SM=;
 b=fzO9JdIAYYH9yYlIkjmuDlys6ivJANN/gbLvQdpaitnnnDnCdUAIt4xjfq71TZ5O/41FYvXvjU4/4yZX96/stMNyE22WHr8IGy77JDTHx1ZJg43wTWCx9RJIz2reSJrwJq0XTxTAaRAlCX5cH3M5EjYOs9ZCHyzvgGtDsp9VGIkttrDps4GGw5QH14iW7+GnftFGzu1WJYZo/rvQz5U9cOkXMNGmOFWdS5IOb+pCYXH7C04zKRvYH6IEACRBDZS+Ssm8lqpH4ID3lB75anBX62RHR9mDZ1MZ21bPuVrqtF6CztNZbtGWlxFugvENHommWCHETzKqnmn0EeuALAwBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lveJZPmL50aZHiukepUQXpbpA7E+NBV87180hWgz3SM=;
 b=jDZEWWbZkLI3n4cRaqQ+Mx0CCexQH9UEoc9b7j03EgUKETcSXnoa5xYvDMIE96p3QhOzgnYvpH88xUsi9ufVYvpP1aaL5sgNwselJvc2ucFe/EbVPIRkTlyIKZ9wh4uuLowp/nXWzhvGKREPsyapA5C62+bT4WPlOCrJa7N7pIw=
Received: from CH2PR17CA0020.namprd17.prod.outlook.com (2603:10b6:610:53::30)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Mon, 11 Aug
 2025 19:46:49 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::4d) by CH2PR17CA0020.outlook.office365.com
 (2603:10b6:610:53::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 19:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:47 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:47 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 3/13] zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
Date: Mon, 11 Aug 2025 13:46:36 -0600
Message-ID: <20250811194646.3408854-4-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f22fa9-84d6-4d65-83e4-08ddd90fd006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uZ9oRX068XegoWNpAcdEZ9/rGvor1ENjg3LItvX9zljuwh+iyECENfbJyuFa?=
 =?us-ascii?Q?ryJgzEdnP+tHEzcYeM7/qfIf1cITnrTHT31r8S5ch/jWZHK46uXnkihvw4P3?=
 =?us-ascii?Q?/TA9WyW8HN7m04Ir1FVsCi0dB0rLIb2rQbF5V4gK+zCMCkl4DrwSwOR5RxC/?=
 =?us-ascii?Q?ejfzwVMyxR23SuVP3HvwZ6bY9nG/3M9mj0CUQU7bFaA0oYbjVLn76lQn9egb?=
 =?us-ascii?Q?6730nGCefrTC5VTj7mW5KM37XIoUiG341szztZYM4RFWUpzCkkJ2ptpFQlk3?=
 =?us-ascii?Q?s0nc0C+gumZ0uhDhHYj6ZSNB03emRGJyNnbDlWMR4L4yGVShA6VT1JKFf3kb?=
 =?us-ascii?Q?II/0M2256KxBeW/OKBy9jUeQ2BTP1xHKu0C+n/hpTrhOmK66MqHs5/TVNZ1A?=
 =?us-ascii?Q?2AQpPxTKBzgd+LKsud6h9NfHZugwS0TVatHselBN/I70IJQhYQGDxPS2RirX?=
 =?us-ascii?Q?kVxHHqwguc4N8X5YftWvzbt8CPT6lZq2yTsaUmo3mrJqx4SfKOVfq/m2J+PX?=
 =?us-ascii?Q?x1RfRESPhMOP1Xe6kXDuD0y7LXIJMk7xfcw0DcD0ZHNvrmXPB8w6n347Cfuf?=
 =?us-ascii?Q?b149OX+NzZXHZMEWfRySRJm6jizifpNfQyLuQDUhq2bUaJG+OcOtNiX1ldYe?=
 =?us-ascii?Q?nOiQiJJeW8UdV7IE7/P8ecxbla32wC2AcsVy9I1dayJ60jPsmWBXUw1HvXZt?=
 =?us-ascii?Q?baZ9N+yXouCoQymYVG/vq7B1crgA/qDx2cWyLTgbK9eQt4U3ogZUUqKE5KBt?=
 =?us-ascii?Q?H9ihIRcY9M78r7tLAnRoyoN3TmUYU7m6TSNxupz52B7s/1pMljh82unq4oIq?=
 =?us-ascii?Q?SWggtTD643kGXnlA84MQQyH6Di07e83FwqaQwXlyxnaPls1k14+JYOy+XWz6?=
 =?us-ascii?Q?wECCt2Owcsaeycp2Ipo0IU5irBOKD2ZqI6PrVVYfkSNWJ/AjL6SZ8Ku9YSlg?=
 =?us-ascii?Q?gU9HuhhhnH6p2MXGVL3Z5Ap/VY7z9cvszcEkZDJlVVIaFJCmFudV1cU3/cvV?=
 =?us-ascii?Q?06mlpkvhLnKd5XYvZWJalxSGko/EO9iOm+/msnVi69RKXVRvwPgRS3R+gntl?=
 =?us-ascii?Q?XWGgfQ82Rf+Qn0IslU8K3698i8ovCtVEXWhstAjgXfAz7ViyU8tMpiADz8g2?=
 =?us-ascii?Q?wgQMeJnO/ux+bIlkKMPjH8/mDgXkFXEww4JCfFi8irxopYRgF0Co9V22oj++?=
 =?us-ascii?Q?VlJU4O3OywT9ySElTenDqzX1Kldp2xv1zwCVzZ6V17h4RF4AGXnsxJysQINn?=
 =?us-ascii?Q?XaNRocBrDbFexx3bArlNY9BbBxTwXEtuyTakeZeelXIzPIdUz6WQbBpUJSEJ?=
 =?us-ascii?Q?LkzsL+EDHvBI0a6sMAHxRJAa5l1r/zWxx+fcQ2x9hu9XiICetMaj8JW5IvOn?=
 =?us-ascii?Q?Gz0Zw8PmltbRIf99hOsOCvilSmjAewSLqmDjbFyn31FcRspsuAyNW5osJhsc?=
 =?us-ascii?Q?fQapyhbFocx6gauG/GPkyCud6yOneVas4XkEGjhBBAZnMyh8cTIjVbm9Go+S?=
 =?us-ascii?Q?1WYF3X0bbRmnTSwx1xW4QvOjUy8inDKaY7Rk?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:49.3773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f22fa9-84d6-4d65-83e4-08ddd90fd006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1946

Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src.inc
as this variable should be in global configuration file and override
from local.conf file.

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


