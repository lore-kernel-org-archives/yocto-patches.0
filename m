Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF31C79F99
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 18:43:20 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com (DM5PR21CU001.outbound.protection.outlook.com [52.101.62.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2516.1788892991569681458
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Sep 2026 11:43:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=cWXI/E4P;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.62.68, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slqbdLo5wP1hho+l8yW+skNJDLGDQ0ZKG2vmxkm/UCqJhxSg9Cf9/p2kZRiRTpU9GvJXwrp0rkAG4TCYDPTlaazx/AnU1A3qfE53SNNnWFJK/kYSUxyjvOl35AlsN/eTlZhA5A7WU3QfuJ3Fcatxw8uHJwRUUECOc3LFL1oynNksu8TP6mi9gt3amwNeUkE1GD3IGsGhfwN39X+u4u1o4I8sBCwEtngWzY8r61o84AdvToFA6K2XT7KRa7IqXgETwqB3tT/0sZNBTbufAR9Z17BTnfw/b+WnITYBDUJr/yc3N/bs31gHX58SxviVtemUMal4kQpjCfhGHolxD5V2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgsrePVzI8nFRLtpBk6mLd9VX5ew/BbIloM1ENd+zdM=;
 b=aR0+1RGaWyugh66D3lzSD1LmLFnU8MEwz8Jinniq8Tt2Ww64OY3IiE/ylDY2R20F6dFtyB0bL6QhK+Z36heOAAX8SCvc9jsU2PpudTLzi5RCGG+Y1AgUsp02GlsSyhoGn1jkWoAWavcPuiv43zuJQ1KtwIT4Q8XPBaq0etRlungHiog0+DZ7cXoY9w0O9Y4Pr3M9MR4PBIqwtamwr2XaYsnCffHH8hNXa0yb36Pyi5TZfM4aJZf0ViUGciJoLwXnIvyXoXSh8Bl05p+/JsRNoULk2RS/58LoOc0dax/xzvErT6qttr7bIPpdkKxtGNPN+mdLjeNUz02gP+yxva33wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgsrePVzI8nFRLtpBk6mLd9VX5ew/BbIloM1ENd+zdM=;
 b=cWXI/E4PhHVZfJb24DR8wgFkHtpaM6Z/QJjYque9KL4M5a0WR6lKCUX1cNg0wfxwfAr8jo3Kp9TLdscQnxuw0Y4T/P7PmCzAzANEW/agGw1GUIbnTlahkps1cGstaz3SFc4w85EVJTFwWlx+DOEai2sNgjC4ZjmiQAvFCJtlhK4=
Received: from CH5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:610:1f1::15)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:43:05 +0000
Received: from BN7PEPF000000AB.namprd05.prod.outlook.com
 (2603:10b6:610:1f1:cafe::a5) by CH5PR03CA0021.outlook.office365.com
 (2603:10b6:610:1f1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 18:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF000000AB.mail.protection.outlook.com (10.167.245.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 18:43:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 13:43:02 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 13:43:02 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH] layer.conf: Update to blacksail
Date: Tue, 8 Sep 2026 12:42:56 -0600
Message-ID: <20260908184256.1126208-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000AB:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: b0188d1e-fb49-4d37-102e-08df0dd90371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	6ymVr07meqJwLa8UcIRLj+UkLs1T+7+1e3aNP4A65naM6nDPBrg1NLa38+ryIi5JMotP5pcc6XdGDAQda6+GqLWLhGBNy85+y5xLHjL+gdiwa65lImPuyNCVOzHmTG5XL8U8bx53UEsTs1dSujg2mWieNDAllmVy66hH7lc2Wj74pM2XvtjVL0G+h6XbqLRu3XYGjjuQNrA0nnTKNJ/DlJqbPtShZbqSNFKiCzIOkUWE/rPS9nW0gBF+6nvWrRdLhAugSccgJKm/bkgpj44InzI997sPQJl+fGWTSG/PwIjAM9nPp+PE5r39qMDMt8zuqWR/ZhcJjz6RUUCUbiuJoKonxWGfvpyPljvJTVL4VM4gkb2E8sJ7rJjTczzSkJ/+bRBYyHPT7qi1HXxy9tP6hahDDDb/mm2yBcwdCZajvD0tnsuQCGg73fIaR7kF8oayROr8bJo93ZpGAZZm1KZw7mZcXhEdUqTB/yO1NVdViL7CQ2ioCbH7VZapAyECzEDKuRVZnfPNdXbklM1/XQS2Gje5H8u0SSGmrtjd0vu/oQMF2MZweDfwAxeQ8u8LgEDKFOpfXe9G6fhH5j+b2wlqOk8AiBtlbVwu/40d65sRdjy//u7D2GQNxcT29KPl4cHDrJRqtdDJl3hKa6RrAlA+3gZ7mrFztze6el4fq0Ufgx8m49f2zrDJuUUkKmo4KlvPS5ecgTFlrm/VP2YImfrXrQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	VmbS3Sh/bPHs5i6nK2Ke9wJwba3mtDZwhionl+8/bvAZ+YufnhgWME5Kj2udR9gBz6KNbDcSMQcL0VyP9Mu3P+Ac2fGkg0x4GlcMh3wBl/jL9exDJzTAbJmLra9q4jiYsC4wuGtfTyMHjeqQCgAUjKhZ17OnrwLkDVsmYAkfEa45faHEKplAqgm3BAT4utN/9TA68xLkehcuCf2jSIK6zJ+w06Br7CA28OGYRuV0idFdkZmEcIE9iLgij7iaavNHFJrJEc40Wi76xuq6XTnbKejb3bL+QXjxwDaPHmtST6fregYx2xOhaCpRSMWI18eL6jRVABYQEwWFBMl7irDi8/CnYAhYF7hzcifzhHYUkqEtry4T1H+Q8a/5Rzff8K6G6boC3n8Qz/zsiM8TUFy/qm3jaycAXDOWrvMLPcl0RkZPvdDZK6tldu4NtrNr8bGa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 18:43:02.6272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0188d1e-fb49-4d37-102e-08df0dd90371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN7PEPF000000AB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Sep 2026 18:43:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4753

Prepare for the next release and update to the new blacksail release
series.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-bsp/conf/layer.conf  | 2 +-
 meta-zephyr-core/conf/layer.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-bsp/conf/layer.conf b/meta-zephyr-bsp/conf/layer.c=
onf
index a00d3f1..7a23a35 100644
--- a/meta-zephyr-bsp/conf/layer.conf
+++ b/meta-zephyr-bsp/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERVERSION_zephyrbsp =3D "1"
=20
 LAYERDEPENDS_zephyrbsp =3D "zephyrcore core meta-python"
=20
-LAYERSERIES_COMPAT_zephyrbsp =3D "wrynose"
+LAYERSERIES_COMPAT_zephyrbsp =3D "blacksail"
diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer=
.conf
index e9c97bb..12de1b4 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERVERSION_zephyrcore =3D "1"
=20
 LAYERDEPENDS_zephyrcore =3D "core meta-python"
=20
-LAYERSERIES_COMPAT_zephyrcore =3D "wrynose"
+LAYERSERIES_COMPAT_zephyrcore =3D "blacksail"
=20
 PYTHON3_NATIVE_SITEPACKAGES_DIR =3D "${libdir_native}/${PYTHON3_DIR}/site-=
packages"
=20
--=20
2.34.1


