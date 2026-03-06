Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05E2FCC078
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 21:00:39 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (SN4PR2101CU001.outbound.protection.outlook.com [40.93.195.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4788.1772830838024461903
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 13:00:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=hYyf6pY/;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.195.16, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLLt/Zyf9ru80eodqsgWL6h/FKXreVRPPiqi5YVSmC3reEsLuPfdfHi8djPYlwaUqZcHfxjRy/9GYOHGnIn0cSFY+haf96Aa7XD0qbJO79/oH3JFGXZMIcOmKJBj9WiN9kbea+b+biO3tuMXl0Jtv2s5vJ9JEC7RwG2OJgnrCIpTCEnDDvnsSPQH3D+RHcfTFOJ29h7xB3ObXpOFO6E57t6ZtdUm6yTzHA25rArpNdnoegHKhu2eTdQ4fSuDIEOnq5bAkN7pWFC+DJlAWETFni19r6UIpVE0kVKQydHtyeN3GTQNp3mJYqkAal5EagbJsG4hqxT7FlVFkKeL287lLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VduQqgcDaVIyotWrn2+pBRV5FGERtIwPWUgF3uv/Iqo=;
 b=DWhn+0T0Ooyh8Q161tlx+lnP8xMdy7xNfClYSsgse5CIXZmkj82mh/eSrFi/0vlzzONylBH8nPeKkTywnT/Vg3nvt1mv+SEYmMq+CVYwZn9nl6sIgbOSKxTSwbyvV7giziEaCE3mKikN7RSh8v3JWubsbPbIv4ehgV0zLcXCkI9pZX3fvQwMyQehKPsfsa6n97P+GXsP+RgzLXluJ0Warseol+YoCT6Ef/UYDaNE07LbyddlK5m48gbHiKu9UomoGQD82h3VR6/MukIHHS7yDKhqvUKjFeMXsB8Gtci6vsuzmC4QT7eQqsXzygEBRriJhpQkR1QCNHGsvfISmRjv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VduQqgcDaVIyotWrn2+pBRV5FGERtIwPWUgF3uv/Iqo=;
 b=hYyf6pY/2UtsayeVFXqCbxiU4RhOEYGxW/xMIBPi0FPHsT0WujKG+ZUouFLO/8qLMix/FtYSEQqzFK4f/LV9QoT1O1Sp2JUW0vLgbsRlq5b1skrCU/liFatntcTCN7WQIvE5/Emx2yXJbABtGRXYBGAad75bjmhu6868brAr6hI=
Received: from BY3PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:39a::12)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 21:00:35 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::aa) by BY3PR03CA0007.outlook.office365.com
 (2603:10b6:a03:39a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 21:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 21:00:35 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 15:00:34 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 15:00:34 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][scarthgap][PATCH] layer: Fix PREFERRED_VERSION for zephyr-sdk-native
Date: Fri, 6 Mar 2026 14:00:34 -0700
Message-ID: <20260306210034.1201401-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6b1f03-1866-4786-e3a4-08de7bc36976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016;
X-Microsoft-Antispam-Message-Info: 
	gCwcoE3gt1DQz5bHHSK6jX0vJEEvcUI5xTVbShnlkPElwTwR58JzWD3TnWGO2TX/wWcZbnQ6zKGRz+HIYuwKPy3msQeoY6W4UqPiB6Sx5wMDfDAyQd1JfePTyQEpMSS4oIwmV+ifOcgkIpzMIe/JAoexLLBsgRsXjaWCt8NqzLAR0iaK8+bR4vS1lIVRRY+VRcETcXF36Mz9OPp1OzJSyuGhNSJ4emkAqNSMX7r/yVc/LOIJjycVyxViJ4EreKTUPSTN5j/4vix40aU9XR7ZI4jakfWSPLgMiv8fcmLbf6OH6kMASUI8KPp+BGiMSxfqQ6Avbt375bxEM0NndKD3Sy/MHiMBhtBW1HbjpWc8t3kjlxDcUpbPcDk3zBpt809UIWI4wtEw5NOt3hu9J7Uk4U20GIHa1+BgkzPVrHgoQXKB6Y5AlKNP6csADQAV580MUanQnPTWxR1tGSSKUuMRwy1Uj4jCIPHDS37hM2ZWlpzM6/sP+7MwNKU0jUubI8k5/ON3NAEIg1Vj41Eg/YkZ2iEMwDnP3ZnvM2BRTswFGzwjLHCZ30QlT7Py77Z1qgaQnsB8WLTCKIZBBzCa8FMRsLfEX/k8Yzb6ixR8AVdcEiwwqSkqSkTAf8OJ9UgzYVT/xouIgacXjXWtzgpOvfDtWO+cJ1YSeVZZgdUUZd7kSq/b1d8F8nIuad9XLYUpg+UT2c8qwi88P98TKuvdtYrJmWCSfQchMBkJQCgijOxYMEf3SyKhmFcZn01corxYyWIe2jKmCCDhwJV50cCuCV3s4A==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	UJmWrEsQv5Lrvtn+wroskuPwLKjSk8G9/fJ6QraTfyn6mXjLV28iJkkbvKRwf2JtK2IwgtRpntlYcUPTvFCLfcd6MdKx9TL5lSVFpuV2/zR3AMsdggrG1pjY1X2xC1NO7/lrpNjPwkuAIpFySc74vPOeN1TFZCDA8tLV0GDjiVvZkA07nTEBu0Jq5sY+zGkuS4g1rBCU/xYVlEAwOPfCFsOJi0skjZ9Q0f0By2jXBcfbrAPBAcXDewrg7L7xvWU5yvv06IHrNlBEiZtpqTxhNEtcH9V85tnIWQi7FGpYp/cOQtALRO+OxSO/ExMv2bMIxZUbJcNS26JB+cDznzymCr3SYvafR9oZfToAZ6Zab3aP475kud9lSW0hdW/6x9K2GHBAexK13whWskI3DDa5+Ucv+d+q3sR4BX2dZwogQuEbQiGjPBJe5fHcXP+sG2PL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 21:00:35.0632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6b1f03-1866-4786-e3a4-08de7bc36976
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 21:00:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3350

zephyr-sdk is a native recipe, So fix PREFERRED_VERSION for
zephyr-sdk-native.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer=
.conf
index e355b3f..a01657a 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -23,4 +23,4 @@ addpylib ${LAYERDIR}/lib oeqa
=20
 # Default to a stable version
 PREFERRED_VERSION_zephyr-kernel ??=3D "3.6.0"
-PREFERRED_VERSION_zephyr-sdk ??=3D "0.16.9"
+PREFERRED_VERSION_zephyr-sdk-native ??=3D "0.16.9"
--=20
2.34.1


