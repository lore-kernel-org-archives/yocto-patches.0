Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C65F46C66
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 17:30:08 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com (BN8PR05CU002.outbound.protection.outlook.com [52.101.57.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.60556.1775496599411457887
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Apr 2026 10:29:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=HPTMeN+O;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.57.31, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0gZZCkBppIuNdCTUNp0bbdZ31e9Mni3BbARlmUr8f/4Eeik0+YFCbDySFL5z9CDCKS0jQ59YcoPuojTyNhK8hLRoPMMsAvviJAIlRvK5MFdCRb/jxFMdg/kB75IaazNIlX6XBeF7OXKt6mvZIYRfKOhu5yWO5H7Cd9+e1Ge+SM7Fnui+m25DKIJ3owiaMvr1cvljC3oYPQjaWrkG540Nn4j/9hbtPDutd6KaucWLpsopC6fddP7VMyYswvV/sUnSQd5Vyt5MdVXunlB0n0QKtn388wXT/l+ECC7Hqb4A45ZDzeXjwXuF60ia9Lk+9eTVxQHpQuuVwK861u85HZhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJefhWtez0v6CPmTvxt9LOz/pPwwr9BZQ6kJCt3ENGU=;
 b=Jfs6Kcn7/r96vIgM6hCuwNBO1ZvnGCEAeB+C8bLcu2L2wHE7R2GKyAX3LwNysJd2IyMpFUbPuqL0hnMXEfSEqXjz3HAAPvjt5pkusadF1kJrA0wF9vV0uMDUtOS9tCb5oO9+Xls+JyycgwcCO+6SLXPZNRKGlhFlWOOos6J2Cml8phLO1MmL2daPT9oZP5D9XqomsX29YWjCZPuI9tNEL5w33mtIYMIaCmYxQLJf+cf3c1lJBqIIV3XB1KMIrUfkZx6nWq7zxOvXB5ZFpJC3vzlM8Aq5JObqUPHoWvCg02nl1I2LID3nvz30uw1QxFs3CgJeSwfQExXz1vAT1LrS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJefhWtez0v6CPmTvxt9LOz/pPwwr9BZQ6kJCt3ENGU=;
 b=HPTMeN+ObHXpE2bDOrv7cUVJs/61SNkz8Ozq9g0oX0J7Sl0Zq1L2ePfNvXv/dTFucv3so8tvr783GbGCA/qrLYf1Yf7k32OcCG+2gDcFxNCyAZOZdmr6TRw+6D2BMWrihWOxK3fePBg92M3zpIfmJnX2Msu+0+HCigPHB6Q7iw0=
Received: from IA4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::14)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 17:29:54 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::96) by IA4P220CA0001.outlook.office365.com
 (2603:10b6:208:558::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 17:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 17:29:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Apr
 2026 12:29:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Apr
 2026 12:29:54 -0500
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Apr 2026 12:29:53 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <tim.orling@konsulko.com>, <mark.hatle@kernel.crashing.org>
Subject: [layerindex-web][PATCH v2 2/4] connectivity_check.sh: Use yoctoproject.org for HTTPS check
Date: Mon, 6 Apr 2026 11:30:08 -0600
Message-ID: <20260406173010.1366742-3-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406173010.1366742-1-sandeep.gundlupet-raju@amd.com>
References: <20260406173010.1366742-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: b08184ad-a759-4adb-4b0a-08de94021deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|13003099007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	zzG1hq3/qjzPPxVw/K+YbjNThSLw7Gr93mCQQi/By0TOMtCjYnkwbFRJU962QZipmJFqoPwSiP7woqGonLasU+G7aZN4rIVr7ErUNkizL3MS67TXeSmwegpk0WsD4AFN8ZripQ21wDOC6uYxi77PUzaqAUMixKuqXE/YxrYaFyHU0FrsSFz+MfqO5mZomt/VCDt6Qgr45HqD78/PdCCOfTikW/tKvwxwB510w9jeII3sNDsgIvCAEMhtfu3jsxImvu1Bo3BByu3b3Y2w5jOLucXJtqO0B/4Q8zTt7RkbcFwlWdfXZDmwq7EPxKWwMr/ma7PsdoEINgxGD/Ad0E08FaWWsZQjsnReSFVe4EKxHBGANd4ei5TaOMWiYRnF9bb/lZxf+PcWsgJSp3y+eqdxHe9o6OC24ttoX9ZiWfPSS52TEXdhfs6s3/+rW87H2/TbZ/w3flprd2FIorJK82NHoRerEt8ZnqNBptvg8H6o8UPnQF14HmT7hIdZjh716V5cBtLs64TYG58bC8sCKyP3fp/P2EdJbHCr6EETgnbUok7OO7tTFJEkNFdp2myhPKCi/n2V8STKyp6FminQ8TOBq3TX0EHRvyY4CbQIASUs6pTgnrWWBy8YE9B8yIx4TT1SDXbkFgz1Th2/sAFmLS0cI1dkYUcdJiX1U/4f3L1k6z+14ERfb6ML0QFf5zaIsVuHY7pq4dU5mBZ3rWpycBE72g==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	UkovibEuWQHjljR6pDooprGe5FOGqjsmjo6u1Cj3TWi1wUso3l2LsIXu8VwuU6sS5UtBvDciXbhmHQthZmk252N+2fQ05dZLP6gWKw2HkDWcYUk4F0yGhN4AiJSq6E3xBqYx87LNvpyqCJAE2odoWY3mlhzUPrZK5zWzs115Sf9leisXidiLw/Ze+G0elDpo49CRQYtHFtrZgWdgGPFbyVYEJnYFHxA89+RrbU1fyK72B4FPxv7AT4cKe9MUXG3tt7DL8DJfbx0HCWycd7z1IBN5I36c/oqYU6MlajeY1TuynzCu1Jn+N62QTrS6h/VujaoZpYA3D4H38TS/ztqBGYv0lI2/pGEECEXIRNGuFRhMLMVV91QwfOlafhpNwurUmMQUQSLvfv8M4h7ckCNDtO1+vYbO+2lJkIZG9FfemeCnl3Ri8ziCvefI6e62yXIJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:29:54.5562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08184ad-a759-4adb-4b0a-08de94021deb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Apr 2026 17:30:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3645

Replace google.com with yoctoproject.org as the HTTPS test URL.
google.com may be blocked or considered unsafe on some Linux host
environments, while yoctoproject.org is a more appropriate and
reliable choice for a Yocto/OE layer index deployment.

AI-Generated: GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
Changes in v2:
   - None
---
 docker/connectivity_check.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docker/connectivity_check.sh b/docker/connectivity_check.sh
index 59b26b8..89931b0 100755
--- a/docker/connectivity_check.sh
+++ b/docker/connectivity_check.sh
@@ -18,7 +18,7 @@ if ! wget -q $HTTP_TEST_URL ; then
     exit 1
 fi
=20
-HTTPS_TEST_URL=3D"https://google.com"
+HTTPS_TEST_URL=3D"https://yoctoproject.org"
 if ! wget -q $HTTPS_TEST_URL ; then
     echo "ERROR: failed to fetch $HTTPS_TEST_URL"
     cleanup_tmp
--=20
2.43.0


