Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B14CA0EF5
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.65])
 by mx.groups.io with SMTP id smtpd.web10.2782.1755554589866345229
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Y9mmGL5z;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.101.65, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ux4H6zYv/0wI/BKEcOYcKnKo3TyO/0YUlaN3xANqHYD2aFVyvGEKY/QV58I5QP6jmF4F8q0ipRdb7cqqome9vt/9Hg+leCXXgZQMiyUm73VqFFvNntGJ2x4NF4u1jslMpECM8nTA6XkAjlZkctdbmfPi6WL26t4AIBxdF5uVPnN4vTEnlnFwQqWNSWbPKwGpIXjbmR3e3r9IOtyaErL6+eMGwRuPT+Bc99GQbNN5sClimonL+YP0W93wC+RbAYkyc2eV5KgMGXaX+/aj3XDjBQqYMlFYJ23Sx2njkdW2z+K2YXuBQ9CWOJTtwaXjIfqH6heBy7hIRBgivu4GHkDzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fhIaJcV54CDkocJcr+pLcrcuEtveazxwJjPmzq/zIk=;
 b=TbYjnPMQEadj5D66IpHVmGBiZHEnyQfgpAKVAwfWMch7A1k2j3ZvZPqcnm7fti7XHQ7KbocPJSivD3mXSIINYfTS5LrPoLFgafIDEl4o81WVkvmnNTscoKEwb5PhMRvEvzpiTYZh5aRcOiCBUF0m4TY0owUdxtexlohU4OleXMc+0EbD66xQWOsL+L7G3Vi3N3O6mzD1qNnWkzcHdivjqNm8xKEthZ3VYt1ih+/UvwdE7p6k+qtT4Esxunm9+GIey3CVKYe6c82S7y4ktWGqWEabidPx6BpogHxY87YwQvZmjY1tUhQ7GOT5BkxE+95FnYuEjVRtVqYQXBJaFoGdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fhIaJcV54CDkocJcr+pLcrcuEtveazxwJjPmzq/zIk=;
 b=Y9mmGL5zS7Ym5eJixpQdZZaZO3LbkfLJwrUgErCILt+CqLtMQxdHZ9U9Qpo8cCLRIiVEdRcjgkz4ZJJXW0MyQBVf8m3NuV+TinJvIPawiTLr4VMEal2zT/wcyxKfuZ4sh/ZkvXS0x6Fn6m/9BIADWt+2FC1/wNhOFVD5OE4iibc=
Received: from BY3PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:39b::12)
 by SA1PR12MB9491.namprd12.prod.outlook.com (2603:10b6:806:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 22:03:07 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:39b:cafe::aa) by BY3PR05CA0037.outlook.office365.com
 (2603:10b6:a03:39b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 22:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Mon, 18 Aug 2025 22:03:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:07 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:06 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v6 8/11] zephyr-kernel: Use relative path
Date: Mon, 18 Aug 2025 16:03:01 -0600
Message-ID: <20250818220304.2300436-9-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SA1PR12MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: a48e7335-fdf7-476f-9849-08dddea30389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UCg/8pU/uc32IFo3t/NyWTPERaViJL2Q0HiB36SveYuk/bJ2bWsneTXeH5S4?=
 =?us-ascii?Q?4rXNm8UBiIZwubfoW38Dx4/1miz4nz5tvpatcD0tT+kHRCB8vd9aZuLQF+lj?=
 =?us-ascii?Q?JFrjwQPoiElA+EmXNX9dwmZVG4natGrGbfy7jQPo7+wdBonyP/CO9huQyZaQ?=
 =?us-ascii?Q?VlLTmLgO+HKWm0qw4M3xOVvt3/pmvtuK8XJTScAEgj30gBTUZ4rkI9wx5Qq2?=
 =?us-ascii?Q?jNQhFxwYK+3AE2Tx6+1Cf3SsGoqDSJZCG8mZ6ezDYkA64iQ6Z0s6yFoP9Yo5?=
 =?us-ascii?Q?y/5d6lR61sJvHBQLs1g+WSYCxeqF4phHdywG71YMZ1B7VMAQsEB42sKnsrtY?=
 =?us-ascii?Q?VvLWe7vPJSI0gUi/+jVOoiPevLKmRkhE8TF4/sLJD5zmYzJ1uGC0MH7UP5+L?=
 =?us-ascii?Q?KbTB7SP80u4sSF6VGBW5Y/1l9upzKJHL0BkEnOiYB+YU8+vs1OX3FNH4iL5I?=
 =?us-ascii?Q?9zvKajWB2VWmLOkLNjaWtZK0SXi+/28eLVXJ95OqbZt5vKfkDTF5cmSol0ax?=
 =?us-ascii?Q?hu6N7mjza3lUh1sBwNVg7f9SGnjVhxj37yYCchqAKdBbWzdTpDCNpz7iI4pN?=
 =?us-ascii?Q?/drBgK16sxT6rYCWMF0wyzUMIIROJzpi+es4uT4idk6cTiO+hskWaq/UmtqV?=
 =?us-ascii?Q?e8Oe+0fpignikJDifZqdZ27j3A46YJ4izLu2Jeeg2f8zhmOO6zvXgBbcLJU4?=
 =?us-ascii?Q?c/+VrPYyIFjdDjuMnByxUzkVI0ewuCQklKDxqJudrAgCh7InkHwyGW/FN2bu?=
 =?us-ascii?Q?802S21eEBlVtCjm2NIo9UcOTg4q8L8mOEz6os3Ka4bRaojdTqb+NFoRAu7aZ?=
 =?us-ascii?Q?E0I2mGmqkEHBfYLopaTbbuI1WrJFbo2uKQuBs20DqXmdnrvMFHSRVuL+6+6+?=
 =?us-ascii?Q?3SYZDJnzvCaZA1xgorkmRf8U+AS5cmRuVa8mSR8LTZg1Pa1K3C6D8fC6uiVb?=
 =?us-ascii?Q?75nWXh38yprEdlXfVonVStZ/t8Lt9WSEI9v8oMuro26ATj747xogR08W1bFK?=
 =?us-ascii?Q?By5RrA82md5/8q8yTjFZQkx9U3lmjzKDybkqGtOiePUDZRiXaKV14Cmuglqy?=
 =?us-ascii?Q?02ug/GMae3B1/wBqh4x1l0UD7UHjZes2wS62udJlsNZXDIvDoxsHFxBZUq/V?=
 =?us-ascii?Q?yJgrpXkNUjIf1+dq+AQfJ/g/JRDMJ/vh9Hl7xNsLMHGGf2crIRNZdX5lJElX?=
 =?us-ascii?Q?9aI2FneFAcyRbJcpOqXKv7vwUCUYovPC8WlU6K0lfyZ2fVHpDoK1zlWEotM2?=
 =?us-ascii?Q?Q4ENoUie1wqlDcvPVbBNaH/4hfPUFI6SAGGvPr9g9+8Ei7f+2j/ZhAiEawzM?=
 =?us-ascii?Q?Swuy2SkVUWGt+hoLISWZEua08d7EfyK6hp7gJOOKJw+EcL0vBy15BMpX3Mah?=
 =?us-ascii?Q?md5dHA/h0066xQWQ/ZLr6LJ0HXeANw9pVtyWjYyMCTYexbueYFQ3o8B4nTuY?=
 =?us-ascii?Q?W4RJE0JsPrtsLlrWS2lTLrBNPYtl5t/FNEEbzwSFzyT/qBtxmiMDLNGp6yWl?=
 =?us-ascii?Q?AHuvjroU7TwOcKQ8czalE2Pk8ZKAr7gKWD1T?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:07.5533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48e7335-fdf7-476f-9849-08dddea30389
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9491
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2039

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
index 15891c6..f6d0a91 100644
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


