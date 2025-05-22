Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707CAC54E65
	for <webhook@archiver.kernel.org>; Thu, 22 May 2025 21:08:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.86])
 by mx.groups.io with SMTP id smtpd.web11.34593.1747948086287482908
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 May 2025 14:08:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=PRHcR4D7;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.236.86, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaB3RxdSwavdHdnl2xg2Flj+kywDDH/YJRikC7GGjqePyDBkHhtM6WiTewgIeDLeDka85B4JXp+zGeNmDfJXDLrr5v3IMvzzueHqVIxYFOABXDHNsgyhdFd83O31iP0EFzb2b3mUbYR2OX8546U+LnXoOrJGMG30lct6w1HS+Ds6EGlUEPpSy3iQsP4P1SiGOPCuC0KvYDvsWd/XTxtw0VGGeKB9pn5qT7snjBb3WY/WUqzUcIVajAqygB3M5EquFSUJpUixEfP5w4sH24fB5R4i0khszHPdoh45ZlPih6mwsMgbShQhxjVpGmSNE4U17rjdkSkiVIuyhBGzICuNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a0nRslwtfsG97Z1aotIPg6G6yjLl5Vt4xlcIxLJLU8=;
 b=nYK4Wrz4TpWI2P+AQGUubOt67o3Jp24PvrmVhTNq8R4G7GFj60ii1IpZVevJPCaz/mMC/Ag53Wf5MsubQlxKeOCtCgA1K/ob0GDVghCByKjc4+8HkpGUntIUWWiLL2To7GtcgeKXcLAjPLE10C0ED+YxeFCWTlKk53Yp/CZmyzBOJJyvvsqcoCQ7KCUaBhT//WA0Lmiu1P4ECBRA3cY/wKaDX0Ua8GAZCY5g+WDIy1nyQzfj3c5dd2Gpu1i8OD0Yz4bic3Fp+YCkk5EI+sWGe99kao4W9xxDYGp5Wsr8Q3SOAy6iq3qkBx7Jr6AA1uo5VF7OIqlhoMYrrpID2lxbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a0nRslwtfsG97Z1aotIPg6G6yjLl5Vt4xlcIxLJLU8=;
 b=PRHcR4D7BsR3y0IyKY0Yv5cdgJNrFXRwYHgEMTIuo6rJh+MDr8UUMmvp91jSa6ju7ucYO0weMOc16u/lFqMp17LPo9xn1ZON/PNDcR5o8Ckq8OB4aSbnEWw0uo4UXA9ftyxm4lVX4RsFtm7MDmQj9cQWMw3cGxZa9cvUhFBW944=
Received: from BN9PR03CA0289.namprd03.prod.outlook.com (2603:10b6:408:f5::24)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 21:08:03 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::21) by BN9PR03CA0289.outlook.office365.com
 (2603:10b6:408:f5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.29 via Frontend Transport; Thu,
 22 May 2025 21:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:08:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:08:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:08:00 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 22 May 2025 16:07:59 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-zephyr][walnascar,master][PATCH] README: Update instructions to fix warning
Date: Thu, 22 May 2025 15:07:54 -0600
Message-ID: <20250522210754.4006865-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e8a869-b871-47ea-64f0-08dd9974bc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?g1N0WTSDaq5enMQAoBAlAHQO7o4cYoZ39RxVYsj7XkFOqU3p0l14AZI406wQ?=
 =?us-ascii?Q?Q5w7Xw2jhHKG4K9JQPFtIJJ4vP7rqOwDrpH6IDzEJmL7MJFR7N6zMWOhTV/+?=
 =?us-ascii?Q?FWEdj/CaTxnfcHZZAkF4wSskGAEQJU6uZ3UnoCncO2mHXB87sdvZFM6sdLPE?=
 =?us-ascii?Q?ZOyaZFPUKsi+8LMbVHOBWUqT8sshJmorYvWhl/z1OK26uKP2kWBaEOpJXALb?=
 =?us-ascii?Q?kfYO+CI/ZMx8vF35j09YlEfDfAks07z+Sw/MdPcrNwZ7td9JZX5F9HPF5Usu?=
 =?us-ascii?Q?twW3YpmlPSNk8uUNITAaiEFl81D4bIA0lA1R+0WWdphrkZWmHG9UGoe+1HAo?=
 =?us-ascii?Q?ITg9JxKc38HYd6CjZypxsAZwUgrzPF3I6MCCfXPYZX5zDgaRRxhtc9oN3EiF?=
 =?us-ascii?Q?hf2bwYtzbfsY+LgQLZvuE0beGMX4CD6ELV4b46npa3ktLH07YoYjdIwrmRjm?=
 =?us-ascii?Q?hAlWdlfqIM8rK0sdZgbEHgdxnO+F5HxUEYW6s27l+SCeWL3GlY2yyRo8hL+Z?=
 =?us-ascii?Q?ivRu+68QOx5z3jKBeBToFgCdW2wmrX8gEjkMt9fh5jxyUXL1KVHn92SMtYpe?=
 =?us-ascii?Q?dRcEgkV7Q/GS+hDFqlvHOb0Bte7YqIoSMC7k5wGmF8IOKZGCOKGSkKv+cSsg?=
 =?us-ascii?Q?p8cL1y+kWZL4uRdVHxms7S62rPO5XfpqcTWMCyxHet6SFCjngNq8zTzR/laZ?=
 =?us-ascii?Q?ge02jerVnyzfUzVn1kfzB1DkgwFOlw2fc0EmX8mJuE/Z9ygT7lBmj20AMXV1?=
 =?us-ascii?Q?IsA8418MXnT8gLUb21RtExwDi3scvTrukBeTYHMZ8sNLGnvcvBbusffRVhoo?=
 =?us-ascii?Q?NZ7dqgVL40OYoCZ6AZRiJSscJud9oUj+iurlxYcV7tsXZEk4jNGuAtrVkW3W?=
 =?us-ascii?Q?PozdRlWZvneaWzjEsm2PKFonmSCfH6XHv5DfNh+vuamA4BbddI7L72JW4om2?=
 =?us-ascii?Q?3Xq0dQBkc3/XNUwTY6R8yFvqgAZ5FvygwDab8njoGpeR0Ui3eFjhA3qnhQNl?=
 =?us-ascii?Q?qvd60m2n9I3ivjS438l2/2JDGpw4ii+4sO3FAb9vPrA8cRHG3AM0Jyn1Ia/B?=
 =?us-ascii?Q?ok4LXzjaX1/E/jxsbvUeO4EOHoWfR3U/JyHQOEAWBcOy56NBM0AYnUTtOB46?=
 =?us-ascii?Q?hGJowiBe9JnicTXv6zvuku5WEmqomCeO0l4RVKPMmMcWV+m/A8VQc8Qj3RG1?=
 =?us-ascii?Q?4kB1ga4sBf8shYBse5pL7Uj5NJxgryJEXU8MrRV0PbLm9xFiapiPy/AiUrB3?=
 =?us-ascii?Q?6f3cnJWLs3t7OCsfn4CsbQOEONI1f2o3wpK0XgQSaoitbEa147sffxEQ2yKV?=
 =?us-ascii?Q?FU8pXKN73oI/sJ12vSqUcV7Aiyjsw7o81tyvSUP2MUj60/XGrnK77/xpOHlz?=
 =?us-ascii?Q?zSC1cnvHjJcMwso7jfCxAJP51fMxnuaBfT74oLVdsLv0mPgup2c+D7FUdjtz?=
 =?us-ascii?Q?YfPM9IiP3SJfMOUEk8m4GEvDfOk5+A2ygYOEttdozVAxyBw9DXx9ysroYSpw?=
 =?us-ascii?Q?kuEIP5+K3z41ButCyvDkor41GI6odDtr6qL5?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:08:01.2387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e8a869-b871-47ea-64f0-08dd9974bc6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 22 May 2025 21:08:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1578

In README instructions DISTRO variable assigment doesn't have
whitespace, due to this bitbake throws the warning messages as
shown below.

WARNING: /scratch/sandeep/yocto/yp-master/build-zep/conf/local.conf:291 has=
 a lack of whitespace around the assignment: 'DISTRO=3D"zephyr"'

Hence update instructions to fix warning messages.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 README.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.txt b/README.txt
index d3694a6..247c029 100644
--- a/README.txt
+++ b/README.txt
@@ -24,7 +24,7 @@ Building and Running Zephyr Samples
 You can build Zephyr samples. There are several sample recipes.
=20
 To use the Yocto toolchain, modify local conf by adding:
-    DISTRO=3D"zephyr"
+    DISTRO =3D "zephyr"
=20
 To use the Zephyr pre-built toolchain, modify local conf by adding:
     ZEPHYR_TOOLCHAIN_VARIANT =3D "zephyr"
--=20
2.34.1


