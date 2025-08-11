Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA1BCA0EC1
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 15:00:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.84])
 by mx.groups.io with SMTP id smtpd.web10.50428.1754924396416830151
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=45wttJtG;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.223.84, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFyoTxByCqfAUUWvW5sqXUeKzbVD07JYRUnj6Q83vIyITOfyGNeksUHefNhs0fA6Ue+OXMq/sA5roXi+QsPkDab25WkT8odYSc54o9a0pYjn/MnrsCUMF0j7h/aYRQp575r3tl6zBH+frMdhxOiapU4mX0tficAZPG+7Hsqdd5/UaWEfTLFnhqIUuUB3DGnxF6NjoMHL4O6SoBu/LDCvL/ItDb64ghJM8oe0laZh+MXjo58+i7650vTSH9tPV3iFza6yNYh0Ewk+57qNTqOdC7dP5njfqcwt5rt/Vd10MIrgNE4dNqtSBWdhhAYVdY+K4SwNBTMDAJzIiMeg/L0AaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow8E5obRKYC4wBzHdGz3sOZZcV8JmzEvAwOctX0166E=;
 b=fjruiCg2VqPPCZZaYKgya9wY1q373IMoGp4EgBGT/YhFgIFUKe5lLUOFbD/BFf/pfcR9BtZB5PmrREfSeUjE5F4+8DgAXaUtN/eUeoIt+DO4bLCUpm3bDWjIE6ILm8sD/8eMTR781xIKH1xFeTcTgHd+3ZtYZ3BCErE+Lr8+ZQ8EQySMDl/PXu0AUcSDg6hBM7da5LWjvmUaYjzwcPHU8dCDlNIjmDATo17sY9DjN/hNK8ZOWeaoL78olRmVfv5iicLxaAfy5z6UZF8p36HiUIvvbV5uXDCJNpWPFJIatQ2e9C3GOSCwA6189Q9HhZNe92OcQrxZxRn5Fs3KE27Mcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow8E5obRKYC4wBzHdGz3sOZZcV8JmzEvAwOctX0166E=;
 b=45wttJtGVZQ2ctm7L9eRggkx+exxipUseF6JTmPhC6befqk54UH6hq43dUk4Eo+zgCgKBti260aYkcV1Fy8cG+oR02KVw4R1bZs/aILWb/JQee/WLR/637U64KwZHxhSLbT9t9b4DKPX5it1RDtbVb0Q+1mAOIabNvt23MOECyw=
Received: from BLAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:36e::10)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:52 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::80) by BLAPR05CA0003.outlook.office365.com
 (2603:10b6:208:36e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:49 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:49 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 10/13] zephyr-kernel: Use relative path
Date: Mon, 11 Aug 2025 08:59:38 -0600
Message-ID: <20250811145941.2553838-11-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: da496f06-e65b-42fe-2cd6-08ddd8e7b9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?x1bctZ2dD/+G+5mJqWVQBQsdvisJHA7BI9pIoRG6d4p32c49JHG3rfXZmXe+?=
 =?us-ascii?Q?gW60ZP/PjZFhhcT99ZZ5ZF0F60wjT/uVrCltZtmNYjvubn35jb7mdKyIiChF?=
 =?us-ascii?Q?9p6eVhCjK4N9MFp9fvYJmSWdsU4LgB6pACmNJNIgpI7NdzNIRRdyiXgMJb1Q?=
 =?us-ascii?Q?V/IAwYZXxJXsn/Wdp97L6XhGLy9IdbnAoChiv5sTtsgXbVioi9zEl1akI9Cq?=
 =?us-ascii?Q?3BaDz7MbQ/JM4C/n2CTF2CFaoSz489poIaAHikWHLjsageGX9f2ict9WuQB8?=
 =?us-ascii?Q?OjiyTyxEVO9VJInvY5EjrGj1lM6IWEPmnPIQQaiv8VawAXlhk0e0KwRhyEe/?=
 =?us-ascii?Q?IJMSBXuqwBFjeUidvOT/uQQPXzNjU5Z7whw9Vtd/hZaBZ1sLq2nriJ86Phza?=
 =?us-ascii?Q?1aKQwQAY/XrtW4dVsJneh3d8P6dXiEVf7NcP8Y3T+YhpHytk6Pz/j62Upq3K?=
 =?us-ascii?Q?yR0bDZCwyFfRal8wePZH6C0jVG7Q6Rmmnv+NbZ/rSp/F8ANqlHJeTnQuPaBQ?=
 =?us-ascii?Q?U/VJFzxB8xUxiD9tTaM2MIJDQPu+cWWhdLXFFM+j5NjxjYUsdrSUp/Yq2xm+?=
 =?us-ascii?Q?aBi7pp6D0IQAeqEdIxZwsr4cyDvW+0zDSFuGH3m8F1iG/8eyAE//KGlxdaip?=
 =?us-ascii?Q?PYeJ1nolNQddJMYebJZfS2lHPFKHzep1ySz9BJiKeKEwgJum4iQ8Q3zzNHC+?=
 =?us-ascii?Q?mdJfYgPKIb+D4zwoUMvVUAJHjcsB2o0jaOKNlpchVeVJXZlGqucngIz+1vcx?=
 =?us-ascii?Q?NaT3iD/Fk3PyPPfvEOcb3/UTvnaeW66PrVpPPFx1pTuUOKToSV/tI5RGsctk?=
 =?us-ascii?Q?OmCr+Qk98BryAfXg9Y+CgX9iFpvw7SJi3slG4iLHGVl6oSzw6unhmpotEozV?=
 =?us-ascii?Q?ajaShyTYhgUgDURFgX6mj40XJ+TVwkR/IrTrT7dEsRgmlVEjmNP3NNiPlRF0?=
 =?us-ascii?Q?PRDDYpGgbiFoE96G9OXAQVSvpAE4mE1Dyt9myA9Jy+zSr0hkeOGfdEhn4WZv?=
 =?us-ascii?Q?aSZvpszH/fJS1BbalOQfeyhp9S5ZtKU550bkUNB0fG11MN3xjDzeKtYE6eHQ?=
 =?us-ascii?Q?vlXvglF+WatAa/YDzN+2EC6S5qvSduAm4cN2gKG6aIRx811PcHvIsNfsvlkm?=
 =?us-ascii?Q?lHZIYNDrOGpcKug7TwOvljqQgz4MYUZv5h+lpmTFmwp1LS8m8JykQhn7gop+?=
 =?us-ascii?Q?EPyDInS5576PLRbOoBzY5OIhHemV6jDVA/hrQDAzCCZJ6XAlAoPh6L6q/3B2?=
 =?us-ascii?Q?5y6xN9wQgAWq4mWHyP6jeYXb+rb3PeuKCvMNm8IEUxJilEUPhV5PT2Mns3+F?=
 =?us-ascii?Q?+ybkSTP6H1g8W3IMEyRxC2OHKxZctk8wV/wNErHrP/HTRXU/nGB3KkPqQvSD?=
 =?us-ascii?Q?fS0mSxnQBBsSvW1EF31UEqnuhrmhE4skEWe77AvgzCEenAbtnFrh9M1X5An/?=
 =?us-ascii?Q?cWhC5yzCpPgkpNFHAN82/5rA+5WRR6w+h/OtrIHuSiD4E90MbJ2GEiCr7JJc?=
 =?us-ascii?Q?COq71zbEdnKRLZNO/5FAxNjbjOl8mfv1MQq3?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:52.3892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da496f06-e65b-42fe-2cd6-08ddd8e7b9e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 15:00:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1939

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
index 93d36b1..ca728b9 100644
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
index ba70a29..5191b9a 100644
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
 ZEPHYR_MAKE_OUTPUT =3D "zephyr.elf"
 ZEPHYR_MAKE_BIN_OUTPUT =3D "zephyr.bin"
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


