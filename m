Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1147DCD8CB2
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 16:40:25 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com (PH7PR06CU001.outbound.protection.outlook.com [52.101.201.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38.1781023223424940523
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 09:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=UzuzOMr5;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.201.3, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGGeoOqSBTKHTQb9izVfHnvL/qMxxDOcGSWdvVm+d5SGzx/kQk58/IV/KWZ9ncsgLkZubFIJU2DjiwTNHqlXjZm7NOZEk9IxDOP2ABADnHV3CWJ29rj0zC0GRNCsQpqzNr/ReL49PL46AtvtobWi92i+sPhiSUzKSEfSfwiUlMaFrt3iAdc0nLT4qFfZ1b8PW1Q9AgN0YbiRLyf3O7BZyIMXRJkTRYnfI253rxxSqVNk2TiNK6E6jUz8s04SZnhv1cEaOZpnDkhjSyldssYlidRX02wlv2UAf6vqprnKR2/tj7nW6t3NOu9kT0ao2szh/jEO8p/Pn/kuuEfebvdLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgj//8poQzg+Mmj4LhL9s4hoS2qf+CedcRw5qSs83jc=;
 b=VWhkcwVLT3Mg4zpA1Cv9RCi7aWJGKv5Bxn65gSgFMi6nXh8g0hVOICVOmd3209jpJLHgxUFc3PceYxFfNLHY2oPlI60GV31V2fJixkEPxZf8r/ilsuwM+vCQPSq7l4Jw0vA4+HvB2OL9ewVBK1dfQ7E5gvbTwRJqmLL3kPYLhP4h5I4fccUHP6t7+ZnnrtpHJ9S5Y+/0WJA7AqTmj1QsMYAJiAnCGDKI5/Q+8FfMAGK1R+B+KiyVRc5aRCXuhnys7FM+9sS7yXAiqzxUuiajdLjv0XCYQey65T0NfJxE9+Go9nbQ3lBkI9+Sh4hUMEmCQSIIcgrPgtkJx8FS0KBPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgj//8poQzg+Mmj4LhL9s4hoS2qf+CedcRw5qSs83jc=;
 b=UzuzOMr5l39MGjx2vU0u9pFfvZjNYRqrh4s9BDG64EqR06uqKYmJh1Em1yDG4EPNDwnQGCO8hA3T+0Z3Kogm1nxPEMJJEU7G5zOIcukzINcPqH3QsQi2iB+YWQuZCze6Tn7ka73drI9fErBEyWX8EP0VsDfyuhEPwXRLC8lKzTw=
Received: from SJ0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:a03:39e::17)
 by PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 16:40:20 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::49) by SJ0PR03CA0282.outlook.office365.com
 (2603:10b6:a03:39e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 16:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 16:40:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:40:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:40:19 -0500
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 11:40:19 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <tim.orling@konsulko.com>
CC: <mark.hatle@kernel.crashing.org>, <piotr@qbee.io>
Subject: [yocto-patches] [layerindex-web][PATCH v3 2/4] connectivity_check.sh: Use yoctoproject.org for HTTPS check
Date: Tue, 9 Jun 2026 10:40:30 -0600
Message-ID: <20260609164032.1415124-3-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com>
References: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b9f139-7514-4c70-a8a9-08dec645cb4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	qntZz7oyYlj4cR9PtRCUI4sBLgttonCsek+mu8h5goQbSMHmoWRirQqp4GSAqpYS+1Cj6uzG2WFj6jw47OJOMBx59wS0zrMjJ0NBj3P6dTaIXXd9vHoVeLR9DxspFwCSHR4ZOAOU4Ae30hLENwKkltPp4b6dEGaXuQyB6UvaOoMhmyvzkMn/E80j++oggIyANN1vI7IFt04+VoXcgFGrYl2DUTqVKIAs4Tfi6bwNSt7Hp0A3EzYEQeoj3du2O/g+mEYEeJAGixLCUGneV69GMluRfRhLDsOpm9mqPZyjSaJzSU7VDl7JTNmIS6AiMUcWGDXnYkbtkqcjPfrW7bIPbo/SB20LPjfKCpHrv543eooe1oyU2IGZYmAh+uilX3w6zxKiq6tLHF+JAJgBjDX1Qvo4aVgRj2LS9sp5LwTPF8DRZyTZuKBiBL+KQs1pt5ANfz6YyXZ6Y/uDK39T/ThqKVZMVnsEjoFMGQPkqIuNOPyisCMmqCW+J3Ab9Uvlj90meI0Df5EEytVaq7/79j1ZqWgxgYBVU4/xrd673Wy3e80jHOlMWKpMnET3zkQgqFLyI3D3PELANycdJ+O6V9Tvt8GlW/VET92DIjs2nDbIC1e/OHuYzb9Cxyf44zzx1Whw36GPLZSQZyAPOV8bEf0+7jIK/sV4fpW6lynUNl5S744=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	maZHND0fQpfV/2oZTVDNdsYvnTAaGT6PjnG9Lwhfgbd3DkcGmJLxa7nxdwc3bZgMn5HYB/MzF9I2EbRnCxH8BBryvHMXboWUalOGT5IWVRvTLT3ckIqwYkIJBgSWTgkWrQ5Om6xNtirlN4gVrLFMPydWrID03BqitR/BnTWczleRROoZMkLsN/v1haugO6muK56TrM0CP4hPh4lUyraAYUg7QOetJLplMD9hyY0yDSTODlse/M9OYLKcubMfeEDT+Wc8VEI2qOEhMCNTicGSuRYIuBuPwPxy6dSiH55wX2IrXoCANj85TXakHupPzMbQFDPPWGry9C99AiyGAXvu/VSDdPrvnw+BDC0Ol6QaCr+ofUm5laEF6TdfjPgkH2qLig6YTnaPSxwIoiOJINOfUEl5nb+uMzn0wHb2SP4ZMWk6iNElUxfCxnZQPfQWRT4O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:40:19.8536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b9f139-7514-4c70-a8a9-08dec645cb4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 16:40:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4187

Replace google.com with yoctoproject.org as the HTTPS test URL.
google.com may be blocked or considered unsafe on some Linux host
environments, while yoctoproject.org is a more appropriate and
reliable choice for a Yocto/OE layer index deployment.

AI-Generated: GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 docker/connectivity_check.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docker/connectivity_check.sh b/docker/connectivity_check.sh
index 2e46ce4..630d0dc 100755
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


