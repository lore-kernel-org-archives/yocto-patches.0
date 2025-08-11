Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23936CA0ECA
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 14:59:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.72])
 by mx.groups.io with SMTP id smtpd.web10.50424.1754924392521452522
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=nlEHexLq;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.95.72, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIN4a2Xb1hj0FysOVTJCZgVu21MN1zd09I9xmrfLf3831tsa6srAG0DCgnNB4NMBuQI7D68NM0+QIeCwiI/sIU2kjCivJcd47G/wzd4HodaUX/8Gf7tCOJCHLqzCcPqwgciWnPA5QHZBEr0vANHOPVEn8OMPGnCJEl+YKLYYxyQtCtemLrsE5QIyp7L66IsGe+1/DNmktzis6RvnLmxWD6Ba/EekORV5kczJX40C+QXtI8TV/ZgmoKjtM2PIw5NyoRmSB2B0ZUkkByFc2bXO4kJkrkb0OAHzGUMQfjbDDjVZVFRLzysbsuvriU5BVpQQ6EYtxNQDP+uTPRGNJlmoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYzt/v9wqiZE6y4AizGasoK/eWs0l+YqxrypKDI+iME=;
 b=qllETfUbm0LxzbOvUsXXIT1/dYeRP0BQ5VKZQS48gtH9+tcPZgy3KsL0vrBL7x18cIpNQwxu8xH86ctK0G4G1bHKbq1VJUVVig6nEoVYnUwRv50F+kLXkF5R8joHRzomMpIPZQSfe7dOtCzO2GIbQPUD2DLxz9XKxR2GpKb80WxWtJIbr5WNE8r8ziqD0mAURxqk6G4/H472fxh9+UBnxlhLXz/VB+lUsSeKc153iQt2n8aUs6aSgvOU4cEu9QCrAI1dNDNI7lA4rR60b6tTJAoY2vP7r8PIHiHIGsuUanURt1yS1pM6t3HWf4BwbKXC2B32lelURAUII1yFX38Z5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYzt/v9wqiZE6y4AizGasoK/eWs0l+YqxrypKDI+iME=;
 b=nlEHexLqvHicQZSsXG6aStK4Qdj47U4abgUYvg1oatmENkvvfNcuLMF+f+UbPGef43uZGbJKLs74e5jnvbly1EyEI4QqrnE97nHD1AuiylF4JZRPi4ZAB5GsX/I8Pwoh4gCejo9IhTjcvhGuUvcHMm6xogO0XIj7mIuJm8aAsuo=
Received: from BLAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:36e::10)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:50 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::59) by BLAPR05CA0003.outlook.office365.com
 (2603:10b6:208:36e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:47 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:47 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 3/13] zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
Date: Mon, 11 Aug 2025 08:59:31 -0600
Message-ID: <20250811145941.2553838-4-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
References: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: fc934b78-6db0-404c-8458-08ddd8e7b79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cCOSlnZ7FNXm4YulGHQ/8yD5X1SS7cz6qQtNtrugDl8iIuiODfhmbNhSxjKR?=
 =?us-ascii?Q?XKqesqAK9mF7LUZQ6Z338LacTityMbyAd85c0Ty+99AhjMa2RJJKSyJQmkki?=
 =?us-ascii?Q?f/QOrFWw9hnoEwYHuyyhKO4ML4pcuRqi1ig/sK5XgKDodJCIjJMNTFEWRO46?=
 =?us-ascii?Q?kMS35EGJAUJ5AoVcPstZROBkGJS+ZMeDuto6QYaf4YvUVrihQ4gHEwka7jhx?=
 =?us-ascii?Q?h7rlv/eMzLTYgMhWPK5EVN9q99hP0c8gJPuKoQdUYXB6IvfpRsplBhClnb07?=
 =?us-ascii?Q?jNT8OO1YeVSZFrEJD8TIg4mC0y63Vnt+zOrio18Xfat2/Zw2DxsSS9TPq6FV?=
 =?us-ascii?Q?pNDK67OfZWVC4DNdttqUeLFM4s35hmyXxOB6CXRoE1XP9zBjyLET7rhVKwiP?=
 =?us-ascii?Q?mXraSyipfdOhd9F9HPMm/TRg1HXsttrrvAY3nqUFYma4JCVJEtGGDWm1l0i1?=
 =?us-ascii?Q?LU8RW1Qdum4OODIrZcPhpvGQ/ZplpAxGv/ji0Tk23nhNO8bgJBBEqyly84Qe?=
 =?us-ascii?Q?fk8TSfbU+GKa5mMnhwpoTu/w3pbpUndJetluf289GMxKnUstNJ98inK0n/7e?=
 =?us-ascii?Q?wT3W3wxquWy2iUKyj+8Ynr6T7jIlqTZT6P5FL6S6AiJGwFvF21kP8NaJyCb1?=
 =?us-ascii?Q?OmfuC3Z9uqT3MtX76qpWaFyf3yNH2F9BLgwwHPxDr2IG1NDGF9AXX4VRkccK?=
 =?us-ascii?Q?7YIQ5rTa61ZahdQTy9ePSBTRMeUhPOgXDwhHBEXUWKAfQRsk7tpX+gMhlBpw?=
 =?us-ascii?Q?w4yLDCbjjEkiYbMp5bhwO9j9OuQv3qMc/cd26Eb1Kgvi8BnPkyYeovJHLL+U?=
 =?us-ascii?Q?eMwfNj8QM2d373B3miWUdQbyAZPLZEDrAXSSSdfZ5rgeXm0ydRZVZmbHtBNp?=
 =?us-ascii?Q?SsVpMEiU6J4AAfAeEbBLRc7dkFdXZw5T0VKAK1bwJBZrfD3eDWI8ArCgyWNX?=
 =?us-ascii?Q?ymFBxb9saHj+bQZDl8ZU7pIKbPaRxOuzIFo9ZOBIE0UKR/0GphUxWiRQXDgF?=
 =?us-ascii?Q?mCFxe7wsMyRO1NhPB9i11dcwlRqzUhpwrc+SBAt9EchOnSgHv7RDGvEcvZ/l?=
 =?us-ascii?Q?Bsw0driLG7TrtIlCmDlVhwp1/LvKIuOBEDM1BDciBvozUvWEXFM6n5ArDa0R?=
 =?us-ascii?Q?IaNe3/r3bgSLLepIuv3ZIllfqZvm+2SqEKQbkLgYb7fASsqaPyuEGVJi9oNy?=
 =?us-ascii?Q?NeOSU/yy3Dflf+kMEKP36krVsegL7xObZZNVOvVDYlYyequuLm5bvzZBS9tm?=
 =?us-ascii?Q?dJtXOwrYBr9dF8FTtyTFpJAuYuaaVpH46Stz7XWVB1FL9taS+iACwCwTLETC?=
 =?us-ascii?Q?23v91bAuvMfd3YBT+zIGPWLqLvnOehSBAcrUtb96OzKCU02qw9t93vlv+Rwp?=
 =?us-ascii?Q?/Tfi1QCyGxwlSMpyr3SB8zJ8L813idh47JGxxk0ktNEvYd4bPZkaYrsZM9KM?=
 =?us-ascii?Q?C25wJqWanflZ9PJLLNp/KFbbrsqVlmF3wAvZr37Rkk2bnzeUnAvJ2WdbTeQo?=
 =?us-ascii?Q?2+PdCbo5WSLF3PDHUSBNPowGapre5IGgDAn5?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:48.5675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc934b78-6db0-404c-8458-08ddd8e7b79e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 14:59:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1932

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


