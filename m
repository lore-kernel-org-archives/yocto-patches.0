Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D85CA0EED
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.78])
 by mx.groups.io with SMTP id smtpd.web10.2786.1755554591028237907
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=cX+FB+5k;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.78, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y7IQZXNcBPbP6wEjuqV6X0bTNeHB7af+fOw26knt/GfjzTzJz+fbE9+Mow439oFNxVCVK7H/Y42X9PohiWmyamSu8l+8VFShmTaOxdtUNiaDbfq/LZubVJzW4pga9cVGJg5+swbYUR+DJQWQMJ3D8uoO6uIClRNu51c8SyiYJXWclHySvMGMaGRaPwY/TmYOs6MQo5BzPBed93Dw3FzJBdHeK0+DJTFdrgPQUp40yAwchM0miPhW/Bf4QRiTTMFSBhVYJ5242p8q5myY0P1+FpxNj6nZHzTeaIoaDszrglGsgWZocEfS/Z52cwanMxQXr4qS/muII6s/xhodOJiWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AjUxczb+QlNl9El3k3t4lxY78l+yzDIYGk1Hme7d4Q=;
 b=WKXwSeNvHY9qRitOk3pBbtfstbtplsxtjIY2s+tHPAsfnS3O+6qZZLF1DJxsXzhAX/d07uR0jYPY8uHJsksR6RdWNLS5r3EkB9J6kQ+YRf2zoWEX71a0Ooj1XNhjhlk+5LR3AsX04V3v99w+J8IHBCHr7WU6+nFUklZ/2CQMpqHTzxqvGHCH1OMLNz7DZ0W/OlP6zphgp9g5NEaOc8+EO1QYDVx8Iu/gKULeIX7XWxbBXbzLc/SzwflSEWY0butZj8x20ThXgHjut3MbEnufse24VDmf3BZYw5FSqZBtyKDbE0x+HF81+8azsaSrONAJlExVEKsHXotpzmxSPd8Tjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AjUxczb+QlNl9El3k3t4lxY78l+yzDIYGk1Hme7d4Q=;
 b=cX+FB+5km4NP0Zrdno2K7XrjATZgWLxPk73OJ/i9NFdSyD+kOT9ShFbFb3NbdRxZnw3y9lH0/zdZcrGiUvX15zpVIK+iIJC/64sNPjl9nW4Z4MNBytz/AfhymsaDXNR9L7an0Sylh/baFtuffcqKwDosDsJZ3enRfJ1/CCFMQ5E=
Received: from BL1PR13CA0338.namprd13.prod.outlook.com (2603:10b6:208:2c6::13)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 22:03:08 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::55) by BL1PR13CA0338.outlook.office365.com
 (2603:10b6:208:2c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 22:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 22:03:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 18 Aug
 2025 15:03:05 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:04 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v6 2/11] zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
Date: Mon, 18 Aug 2025 16:02:55 -0600
Message-ID: <20250818220304.2300436-3-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd7b04b-9d93-4cfe-f8c1-08dddea30432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lQfgDmeYbeQtI3HkGrbq7eeypolVB33VvetdUAMX38Cksa2CPVAc/yvrpT8r?=
 =?us-ascii?Q?8rW0JpBPn3+6IALLq18CWqUXDlgnLzEeS9oCPsgtBX/0ttdDoPi2CSb4cAeS?=
 =?us-ascii?Q?JjsYLWdve11/rHCw/tPiYMJHvlXLqegIk1pT9NCe5c64JuXrJ7Q2RAz5qDeu?=
 =?us-ascii?Q?HyZ+N/Lg8aCj110mlWyYMrjzeg/J+uw+bfWOitRvN2OwrWfciNs5Ba5p3DVs?=
 =?us-ascii?Q?xjPoMsr9WbChX62DG6AXsSAfzJfUh9hAFWHT0UVZxlgnr6rvnn3yBwXPbgDI?=
 =?us-ascii?Q?mICMAUsgc+xTgeXZILA2hogWnt4f8CMlJCtdbuhJNjwtlt/DbUUWk6RXA3xW?=
 =?us-ascii?Q?e0UIPG1ZBplSxtJf/6QHMqE8jnTCtCGN7AX8shX39zVLURXEGzPYSBvMmYw8?=
 =?us-ascii?Q?n8IFc5J+7fm6b3hFFH0mjndp9AV6SRteEOSKPAs5NQzZJIn3UB2M1Cc4s0Za?=
 =?us-ascii?Q?blBwrA1aw2E945jiCcf8t4RpOoNfKvmX5VvOmJze2JSvG7TMPE8Z7pe5lLlw?=
 =?us-ascii?Q?kgQnl+omHEecYiUQbGLSAW0kFwJpqCiDI2qRFkKSce1EerCccAzwW8tpVYPb?=
 =?us-ascii?Q?yygGohWGYrI8D3gGYTJhmiUNMec3jsXYkLrreAQFwq6g1lXVBqr/oqEDqaJ3?=
 =?us-ascii?Q?127pMU+WfozNfd1qRRVg2RK54YKKvZ6auqToenGA4BEeOwnHFP8t1+lf+iC9?=
 =?us-ascii?Q?pG/Yg3oz27aTt/5KmUlpPxyi8d+5SAncPlXhO/w0Lh1npr0yH6iuIuPwj5K4?=
 =?us-ascii?Q?+acT0tehbAbJkBwerbsi032Z/eZqsiK43rX4c/DATdPlmwRgOQcc9Im5a8t8?=
 =?us-ascii?Q?PXR2sIiVqB4Vjw0wxbMQS67Ds6ldkezb621wVo4B1sZYGfabYlJmbacPH79R?=
 =?us-ascii?Q?sbhNsB7eXj/W/vAhAL79LxDvTP7LP3UiZzXpjeRhF3fINTsshcTB0LwDCIXF?=
 =?us-ascii?Q?Am97r5bXoeoLYGQC23/ea2DbVYCgvxFLlQINT5nvPd+SVYQ767Wm+EGc8sRF?=
 =?us-ascii?Q?6eavksN5p33H7OIj2JyHCAJLShFH38ChD1Eq9ai91Tm5egZfZIvIUIMdM2zT?=
 =?us-ascii?Q?KqtyJQavNaZDsbLBom139mvXaIGcp38wNQ6XJDSYidR3tkC64cMpVv2Zm489?=
 =?us-ascii?Q?fxN6dygd8EacY94Qn4slQuGy440Bj5HXs+jGP3D3gaVAyeaQBqbJyfPZDdV9?=
 =?us-ascii?Q?CrehxVgk/95S1X3Emq1a3VURn7ormXL6oZ/nYxo2fnzB5JYCcnyA1k5xqyXy?=
 =?us-ascii?Q?qm3X2yEXA0gvo3ofwGaRYY+DCaKCYsZoyuJ9nC9fPqazze2Bob7OTa/HzPAl?=
 =?us-ascii?Q?vC3pR+hA317eI3UL6nWZRbeHrCmgfUgp2AImv1+CX983kWOJoDL/WVC33yNT?=
 =?us-ascii?Q?74HuXK4shP2a4UMpPj4/EhS/Gx/2e0pol2BITYU78FMlf7Lq8+t4ae3rYlTQ?=
 =?us-ascii?Q?fNwUAO7iH8AI1hdsoY1HolH9X8trjzXT83q5FYY/agsKJ3CLFqbuGxlUXJ1S?=
 =?us-ascii?Q?P1aF2V0cAqalemg2LgHeLOgjD+1rq3RFC6Mr?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:08.7533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd7b04b-9d93-4cfe-f8c1-08dddea30432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2044

Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src.inc
as this variable should be in global configuration file and override
from local.conf file.

Set default stable PREFERRED_VERSION for kernel and sdk in layer.conf
file.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/conf/layer.conf                              | 4 ++++
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc        | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

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


