Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45ABFC9ED3
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:44:08 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com (DM5PR21CU001.outbound.protection.outlook.com [52.101.62.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3304.1772858639000310271
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:43:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=vTX4kejk;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.62.50, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGDd5Bq3pBnmxWCoZemKWy5THvKOGQuA1hVCP7GInZzlOedmtQkjLA3SVpI9C7F2cnWKdZ8sfiimObA5de0L2DljLdwuuaqGi4IyJCXbzCzCeT6gXFzaf1wggL/7lVHSJuaJzPXAl6fH07J4LpCfEXaEJXL7PtnZLioosp79BuyJDOM9IEq2V+K4vzgg4FiBVmKuxtCy7xNoUhwRDkddoE/MFug0COZFdS12U4vxd2pywNn9AMte/Q2CJc8M1w6vLJ3+91md+h07INVW/jjKTIJ4f6Y3zsOhS1iGBzeNMotAiHNNDuXHiJbHFSLdbddcicmp0RtLGoWmWDC2RWS2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SA2WVe6ZwqPklAHDBdKSGPkEIshVqaLQQg+4vl6dCQ=;
 b=Jc8jhMjUf4GPFN+SIcma0tASf/uWoRQL+6GTqPoyjqJSHvKcwG7bgmS28MJ86Zc4/4TUPlWXQ5GkTt+s+leUNufxD2SmSlyHiPq6M4taaRLH/y3/PAGx9IFjqzxJm5ZFlvx9nwKDg9pQuJpe/ocP9a2yHm/1XVCNvwM8CYFPEPn34prbHvfcT2vEL4p4+iu9v6LMDXz4cho/ZQgb4/X74RaBlQsLXpLL4wlIZ3QDeVU6Ht9eTccuFGTAKI0BWvfG2cfx38izXn/8cBSWL7vbyXCCYi0KoM0FKzYzlJTpdgEoSIH3ows5kv/Ctmr5Yzw/bCyaTLs7PzAUTi+OsRLl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SA2WVe6ZwqPklAHDBdKSGPkEIshVqaLQQg+4vl6dCQ=;
 b=vTX4kejkW2MXlVftB0u+lvpozEnAmEcyoPJEvyMZWZiHixLxaq/brmcV2EKhL7YeP3ec3wsYhwVWTUvKyCcgRjBKcfG0BQ+CVUoMNsqf2GCAZx2vDESQSnA+JXRL1BVtQXzRGO9wbgflXqqq+Y5MkPFhBspjf1jKuQijMllg0rw=
Received: from DM6PR11CA0063.namprd11.prod.outlook.com (2603:10b6:5:14c::40)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Sat, 7 Mar
 2026 04:43:55 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::2b) by DM6PR11CA0063.outlook.office365.com
 (2603:10b6:5:14c::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Sat,
 7 Mar 2026 04:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 04:43:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:54 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 22:43:54 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 3/9] layer: Fix PREFERRED_VERSION for zephyr-sdk-native
Date: Fri, 6 Mar 2026 21:43:47 -0700
Message-ID: <20260307044353.1936182-4-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
References: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd7e504-5001-43f0-610c-08de7c0423a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016;
X-Microsoft-Antispam-Message-Info: 
	CLb6dyAcHiQQvMFDhdGw4G0yuJMk3bkBXrChjsLzRfxi+EBdx9s9fvY38lmYFAzH6JAAaVBphBCuLZkgd/hpGr9fyu60rALOMVFJM1s/q2nzUGhVeV931KJp0nSG4qxFNWiLMqecnVED5NW1CmfIaZCNeGfp5E6nC4oSZ3SN1zcB2k8EwkmTCQxuY2G/Sc6hUOiJU2bOSdP+GpH6W4+cSl4pxa6aDmJ9dz8nR7EUTG66w6cEYsgJa2pm7s1k+Tb6OMJTp6DS/XTDMPRFoqnZjBmj9HH19Cnx0x9SqEC+oUxL/D3Rpze2fd3fPcCFX4TERb8MVlsYN26DHxbx7NF3hwob0zAuXNnsUh9hNbosT6oBVM2NNJNmg8fTDkGtU/LEqtcZoNGUCybx2yd4s02ckhmoTDf0XVyraaeDtXEvSlQFUEteTcDKVTXRY2qWfhrzDiFbasKdTguogLGPEMWqpwM0Sx6y3vOwsQ1xZQaxPdjC2WrHTsgGZJfivDprwXiFBKzng3PEwaS6AtX+1NYEh/ydwwLay3bs4xW8OuYYEEIoF/qNi27wOhrYphcx7SBSG+3qPlxXsWnz+45d0+W/6MzQ392vwTwTefeHm8r8YVrIjbQ/VEXs3AF9UBJ0mxa+pMoP838PJQBUMu79fDE0Cb6RzZISKU4jWQCLCSQ49B2rug4EqqsSyqZFUkG6vw/DMhNMe20sn1+FFmJPnZTSGAqejPE5GuLO56gLFWZ4sayIKn9qME2RrlaW2PNouJOD7+kKVQcYz3yLApC+FSGoyg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	0f3+YgB7DOImmUFLMK0evxt14AuiAPKQo8Ural+rXwdu74rlqGI7f8wDjuiNChnk2oFS9EDno9mCphZauzmrZfTrEBD81YZyD/oMKjFIYKzlguzIaxfMSNAF135PbcYQDPKvCvTHIE5C1fSrQrUh3j+GjePSheOSrZcgWHy6y/GAyRvciyHRagJlLy6tc8ykw7AqddxeYBHCvC+GVXhZHaWfLUtMJMLGiEIxTUK39DumuOtfXVKncrwSaht1hJ/KQw/2Y9I3wnzA2SfZlrx5nKy3TEcKXOgYwQKABmXtc8wvcHEz1L59uxdmIkgXPh5wi0O//DXk7pwfCpq109w25bzBtryoEsFQW90uXy2u4HwFEJICkrqGYa8aVMtY78v4K15sjSRfpQaalJiWJXzvXN5LFdL7GtNuhu8UsjRnSVLOs+CiqbMWSOJT2N7QhC93
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:43:55.1890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd7e504-5001-43f0-610c-08de7c0423a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:44:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3354

zephyr-sdk is a native recipe, So fix PREFERRED_VERSION for
zephyr-sdk-native.

Also update PREFERRED_VERSION for zephyr-sdk-native to 0.17.4 which is the
latest SDK version for Zephyr 4.x releases and to match with default
zephyr kernel version.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer=
.conf
index e5d0ae3..519c4b8 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -22,4 +22,4 @@ PYTHON3_NATIVE_SITEPACKAGES_DIR =3D "${libdir_native}/${P=
YTHON3_DIR}/site-packages
 addpylib ${LAYERDIR}/lib oeqa
=20
 PREFERRED_VERSION_zephyr-kernel ??=3D "4.2.0"
-PREFERRED_VERSION_zephyr-sdk ??=3D "0.16.9"
+PREFERRED_VERSION_zephyr-sdk-native ??=3D "0.17.4"
--=20
2.34.1


