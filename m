Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1AECA0EEA
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:55:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.85])
 by mx.groups.io with SMTP id smtpd.web11.4402.1755230100371664456
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:55:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=a4v+V/B4;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.93.85, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEcXpmQXrpc2JBfZEZNXw9UaLnWXrKbRgU2fQqijP/K7xOns6Xh4YqdR31HGCItRK/DsHcFaBJ2EcK/pry/acxljIGtajyLhELlPKK/N26vy8dLBmlmSkGb2aRSslEIqdsGhQ85P0a7/oisdge8Qsrl2B4QDY0fJaMWEOGFWUQ57MIxRpTf+rlnId1tcfH3Gttr9JI7qrDWLNSYvQurEoYXLcM7NB8F9+AdBcOPdGlKUVJR1bgbP/ZLBGkZjBAOKBdgUWAQVl3OwSnbPajI+qXxMhlcia5CKuDtv7tV9rtHVOXy4nD0ixCtNfHhtUnnl7SIv9D96HaJCS2SWTmrrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZUmKvLNKtLrvcvwoXmU3D9q/OVXm5JAyTjpZFYnW4w=;
 b=MHsVzGc9DJMuLlOSTzzTJl+ISR2MLcfWSb7ZwQ3+8at1E7R28kHV7QXl0gam8FfFMD48SMSqH9LdlbciK7AFcv2tzSRy7XgN2ESlm60qTsl3X/9dnpg9f7INLtJxpEaOB+6wRXXd6n0uNNEvTm4mR7No9W22mzPbW1rrLwMoCzoTudFVNnz38D9kkwjg+wS0Y/HkcpUHopq94Zuytt3tuwFPj/Bs+iNNOFavGpkoIjvWRb3fGmTYHTbbb7J8H2l/b/rk/ASwxxKj2OanXv3QJsIKpDiry2IFq4ELuCNl1BLYGaiy/1B501b7B5ukvGjR+6WwhyJzrgWtO3NwaVc4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZUmKvLNKtLrvcvwoXmU3D9q/OVXm5JAyTjpZFYnW4w=;
 b=a4v+V/B46WMfLjdxo4ozSSDmwpg9Xkr1VSOHUiJa7+roujjocgKJf2HjBdzs2Nx4uj7EoUKjqK7s3CWg8X0dofyVYLuJV7GanLrKF9xbG6MM0f5b0Zih2F4pN4nbf4K6FelqOrM8gH9tjGa+llKjIfIw5dAjXSfd5uZdqKReIEU=
Received: from SJ0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:a03:3a1::7)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 03:54:56 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::f7) by SJ0PR03CA0362.outlook.office365.com
 (2603:10b6:a03:3a1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:54:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:53 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:53 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 09/12] zephyr-kernel: Use relative path
Date: Thu, 14 Aug 2025 21:54:46 -0600
Message-ID: <20250815035449.2816001-10-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: a202701b-4cfb-4a81-a57b-08dddbaf7f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?N6PM1XiSgI7S+rbZa1lHwIFFZTPRlfSpIaUPlLMjd3i3reqhKiwWORx63cpj?=
 =?us-ascii?Q?WP/SyFZu+na6mckJ7k1j8YhZp3Tpjjeuwzup3eH0TbFwu/8xuwBetXRI2Kn0?=
 =?us-ascii?Q?oQ8lLMcay74CO/rprnekk3p/nX+w8kxhioT5OZrpYenJa6sQa2HJEqAMSdC3?=
 =?us-ascii?Q?IveYnEzKna6Xdi3d0mOZUY5ach+3VULasdWOWtVBCD7/aq7LFbjA510u3kJF?=
 =?us-ascii?Q?qQO3OdMVrSN9QvoVRxjsfUxjsuPn1ddSRTIrFsBCS5QUi5RoReWHzyXQVaDE?=
 =?us-ascii?Q?sqrCrXFUL0qgkwL7mswLCOZUYdM9yVeuaFNVx0SqxJslcIKQ3q6vk95tTx1+?=
 =?us-ascii?Q?nw2BY5IUeVba1kD6eqn5/AE/k0guuDVuT/MmZtgMXX4su4KQGFQ9gXXF9Bl1?=
 =?us-ascii?Q?FkeD/hcJ5ccztBti7uGP75nc5tuC1vF2g1lQTB3mQag0MzrLyWkj/H7mvTWi?=
 =?us-ascii?Q?22O9y5NFI5t2hkPOsp6Q1MUVUQr6SxxA4WtGqQb0B1XCCNW1l23sS+yU/QtE?=
 =?us-ascii?Q?TgNLxdp7l6owFSDj9SzxbHx+Zinl7NBmrlDz07zAOiMAbhOjNaRORq8ZM883?=
 =?us-ascii?Q?wbTE1VNqiuJTG3b4nXoCruoFAm7iuumN5yMcvq6DhvdLNVhidCFH70UZEXWG?=
 =?us-ascii?Q?4HTqwE1k2fweHuZP3bS+zrAu4pd8HORhyBIgUyRWr1y+fJwcN6wL9mSwussx?=
 =?us-ascii?Q?b3RQ0r2D3M+LtZPhL8Z3y6YX2iw+NGC5P6x9fbuzEpC6deiqI1QhoCJiITLt?=
 =?us-ascii?Q?oyLlj7greOlaFolYUhgS8lXq2SOqx61+XPTblreZmKXCA8kyivM4fekdCQFK?=
 =?us-ascii?Q?KpnbGyKld/1iCkSykUo+ybYNbD+FMaXD6/qtCFm22ossgAZIx9/8gWdTUgsb?=
 =?us-ascii?Q?RLndQ7I7roPqqox2NKSme+TfegMA9y1GyPqX9Wb6qHS9SnfPAsfZdlnnEiHm?=
 =?us-ascii?Q?7DWVleLkhKeNsQYRbojpziSfGILI1qt38gPfv83miFY6QnnEiSjcCl7crwq7?=
 =?us-ascii?Q?m46Z4QUzQGbMUJhh3Jwk/oKG3BfpoCkm6H6o+wKwR4ntKivOxxBjS27oACpW?=
 =?us-ascii?Q?JdsDoDeLHSbCLg29pbNx49YTEXMgSkWzjXGS8rPMjjU5TtVvsJHgq5afv40b?=
 =?us-ascii?Q?1kAHgmFLMWQKomsjQrf94wa0g5Y+EcFU+D7MQ3EpvcI7lX9qvl50HyzpHA4l?=
 =?us-ascii?Q?tvX4l5j8O4ioSWsePIh/B4rpC+l1o19RIwMQyemDHwknPWrLVyVfGBwYuObe?=
 =?us-ascii?Q?zw5p+gQgMO2TwThR89Xn5U06zoiZ9G5LmScT5c+CNVLwqT0BPGUY8qxO4Spy?=
 =?us-ascii?Q?qA7gOu8aUWcUOi7RnInTI88UOEZAuwQj/iAZYIfXTw+Eub9IT58mML0fF03x?=
 =?us-ascii?Q?mFi8roF2Bv5WvZYWQLjXcLdLCXc6RJZvREISo1PILoTicfat9BdOfPXXkNbC?=
 =?us-ascii?Q?J9SYdgdCcgIIiaG8+f5ztZ8UjVhLBUu+6l19iBOK6zxttba3xPdcZ7J3jEGa?=
 =?us-ascii?Q?CKA0z7aUKbCLfp8sMdlc1tUXaK8z6TVsinUe?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:54:55.9894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a202701b-4cfb-4a81-a57b-08dddbaf7f85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:55:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1995

Use relative path for all the include files to avoid overlaying the
include files.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-image.inc             | 4 ++--
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc     | 2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.bb    | 2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb        | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc=
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
index 61ad90c..477dc03 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
@@ -1,5 +1,5 @@
-require zephyr-kernel-src.inc
-require zephyr-kernel-common.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
 inherit deploy image-artifact-names
=20
 OECMAKE_SOURCEPATH =3D "${ZEPHYR_SRC_DIR}"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-co=
mmon.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-comm=
on.inc
index 7967614..c1a4d47 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
@@ -8,7 +8,7 @@ inherit ${ZEPHYR_INHERIT_CLASSES}
 IMAGE_NO_MANIFEST =3D "1"
=20
 ZEPHYR_TOOLCHAIN_VARIANT ?=3D "cross-compile"
-require zephyr-toolchain-${ZEPHYR_TOOLCHAIN_VARIANT}.inc
+require recipes-kernel/zephyr-kernel/zephyr-toolchain-${ZEPHYR_TOOLCHAIN_V=
ARIANT}.inc
=20
 ZEPHYR_MAKE_OUTPUT ?=3D "\
     zephyr.elf \
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-te=
st-all.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-tes=
t-all.bb
index 85efd24..d9dbb40 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.=
bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.=
bb
@@ -1,7 +1,7 @@
 LICENSE =3D "Apache-2.0"
 INHIBIT_DEFAULT_DEPS =3D "1"
=20
-require zephyr-kernel-test.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-test.inc
=20
 addtask testimage
 deltask compile
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-te=
st.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
index 2918d2d..75b1757 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
@@ -1,4 +1,4 @@
-require zephyr-image.inc
-require zephyr-kernel-test.inc
+require recipes-kernel/zephyr-kernel/zephyr-image.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-test.inc
=20
 BBCLASSEXTEND =3D '${@" ".join(["zephyrtest:" + x for x in d.getVar("ZEPHY=
RTESTS", True).split()])}'
--=20
2.34.1


