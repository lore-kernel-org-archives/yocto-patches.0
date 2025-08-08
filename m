Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366D9C87FDA
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 17:58:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.55])
 by mx.groups.io with SMTP id smtpd.web11.29079.1754675918841781772
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 10:58:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=0qGazbqP;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.92.55, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usdC+B0sVpZHkREso1rexa47ekyZlOkpWlCbltOmjbkYtUbLC6fQoL2u09fD3BPQB16JZUCBvi/VWZFdFnIBwvEzz3II+0kFKopFHaUsPRS9Evzz0cHBTwFW5nBaXVIlBHIfQ8vevfHzNnnMn0L9Ki2La0KZXSBkX7GjwXK9s3p2ZHWL9k9ViXKkwSowT+IDgnKxtASFAuqfEMWgssYrJTVj/LYHcS3iYj8kwB+V+8xN1dz/fsNFS/ZuD8fZ++9hvOMD0Vs72mdw/mNz2oFiV2f2LNvu/IdOd52RCDAiyWzefVarPCjEbBcR4tDLOGbPHp19tv6lekEUArnYG5O5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiQihd3bLAf6AZAPBtb3sDQSmqHGxv6qBzljVd/y/wY=;
 b=dbgN7f+bC9njsuivMh3t4gE+9xok4snVvN5ZXFxVEkF8j8KPrr4gHSuVZ9HhBRSjxr36wn21H4PCrDXjzjsTmE1wacZJAu3Mb1UHUk4fSifNr+spNZR5BXCtXYX5yqgTRKptgOky/PIQ2ntPBuO1OhQJ8Q8oQQVdwhMvJrDV82gs5kMjSGWI+zE1NgniblPjl6EoA4CrJGIUOgKsLKa/5oCrUq8vSaE3eqir0VolWsyd/awf4RTYyAJt5cbbBThZnzrP0ubTFhbgJnktmp/yLE2O3fbtUpN5YS7ZUf6O/KPcMrsRGkiHmPhsuUuha6kGa6K+zRYejFHwTE4CWYYouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiQihd3bLAf6AZAPBtb3sDQSmqHGxv6qBzljVd/y/wY=;
 b=0qGazbqP8L4s0PkUQTXJaOF/gYAfEkKRwekmqxX9+B1qAjj2xJUHQTmW35eAKBPOAs361bxgV8GBmfETiS1+Bs9ZxZoNu+YgSzzJJaMbem/SWZUxHv9fYVg9/mquy4QX+6b34dChbTGK1xjaHda7hb9bAl+Au0jIqB3bTpK5DUA=
Received: from BYAPR07CA0094.namprd07.prod.outlook.com (2603:10b6:a03:12b::35)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Fri, 8 Aug
 2025 17:58:36 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::cf) by BYAPR07CA0094.outlook.office365.com
 (2603:10b6:a03:12b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 17:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 17:58:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:31 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Aug 2025 12:58:31 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH 4/9] layer: Set PREFERRED_VERSION for kernel and sdk
Date: Fri, 8 Aug 2025 11:58:24 -0600
Message-ID: <20250808175829.3830489-5-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
References: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 89284da6-7149-46fd-3d48-08ddd6a53215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pnUSDype017dnX1kO1qsCn2Y8r9Ug+slF+c8XNGtnh+7Mps/JcRV4mhBclzH?=
 =?us-ascii?Q?TOUaJn5sK9CFAYnIv7NCC9u/OCQbvLkRETcIdmAjCm4F8vieGgGtPalhheG5?=
 =?us-ascii?Q?eOPrbHasIQywrnQioUQKMSLvjaJlWE+D+nLgxfB+Qvqab/uNEjeSqgD7GoeG?=
 =?us-ascii?Q?n19PoyQjEXvTpDKUv3W/jIsjqx59V8kapsf5i86Rg31z+mmdIQZd1FkK5xqH?=
 =?us-ascii?Q?TAjNsyMzmmCpYvTPf9Nv/ucswjtGxZFERTbqsAeRzPBxNJlOM57ysXPpa5bh?=
 =?us-ascii?Q?M1QNESbSy4mmcu7i3YNZCxvJD1DmwDeVrtPsU6bWmEV56Zr44d1hovmQ0Qcc?=
 =?us-ascii?Q?6b1H047znmPQJlbR2rgzywu4S2mXMnElI9ujtTuU99p7ewSxcf75uUK7/F66?=
 =?us-ascii?Q?38bw18+M3tP4U/UE2Gu6ybDdAlneKa5baXbdployErP4ULVZLId2jxv7dITt?=
 =?us-ascii?Q?l13qtpjOlkn5h7enp1saEhMS/91gmPK3ynH7p7dLlf1TWhbht7kjvc1owzE0?=
 =?us-ascii?Q?6Rur5jUK4F8hVIp8JR8VaggJlD7gc/GSuSfg/nn0SCMF3HF9sXfFea7O3mwD?=
 =?us-ascii?Q?fD2wUNkqndw8ZuXFyekgXBEivC8QFPRYPyvr9ElPZ2C4MAHuGPtehQIY3Ltz?=
 =?us-ascii?Q?+iPDooO8F6BRMDEb+w5PgAWFrox9+n8+bENNeLBmmNPWjo/nuGWzKhZMGc61?=
 =?us-ascii?Q?xQc//yAe3sNAazenk3ruTRGI6Zha4LSZUfh4Se7syUW0C2u9ycczud5YHAUM?=
 =?us-ascii?Q?vyW956RZG4PQQ1TcK/qB1iPyd3Kdy36ntKAztKd895HNN+FKwBiD+NxtabO3?=
 =?us-ascii?Q?5GENZVTZBkjOOJmVDhG4ayYAD0sL2gJ9LYQcRwawDa95l6SI2OST977kwF2Q?=
 =?us-ascii?Q?7B0r84JXZ57bzahK0bFDVwbZL2KMGwcSoGmPDZlA938LHPfZn1hv7a9Fr/re?=
 =?us-ascii?Q?4UD5ZNLYI4j2EhhLq+nMKxxzRqvuPjTuc89kyW95OtdVJNsaqOzz/BbQBTDt?=
 =?us-ascii?Q?Tq7Ksay91mebP5LtS8h3wNO3UA1e/fAdrkSAKKSlcXiE3+MOqeS91I+p0ZRH?=
 =?us-ascii?Q?7He99DSB5zqly1lcEPYDvDauK2jvCeEFs3v2GB1e7uPyLH3pGDciDeWSDhVC?=
 =?us-ascii?Q?HgHg0EFZak6SN1P0NZxqRaNUhwDDeDgntprR6lWJ5rodSpf+FPbc7XRdV5VO?=
 =?us-ascii?Q?rgY6JbO7X46D52SBDt0ZiFtPKn8EgQ5BKUxJK8159mHbZaxgqkpgtQs2b9lR?=
 =?us-ascii?Q?2TP6ll7KvsNEPVfBWqJKwRSmGgJ/ScuNIzqpFtXELGnkbfc1I6z6a44Cy6qA?=
 =?us-ascii?Q?B/8w8em5yQ+W8243I5QC2gCEJpEe8upxFVw66vh1IKXa4JtYg6WnNQpFaHoe?=
 =?us-ascii?Q?+nuq1aa+Hkv6U1CaaaHJs64bSmMNFR4qV7k/4UyDe3fEyqzhmY4Sbk1MuE/g?=
 =?us-ascii?Q?lGFf+5Pemn45JkZ4bqw+l36DgzLjoFNlCG0laIieCV7ebH0mHs5IKlfAzAC0?=
 =?us-ascii?Q?n2gEuqTOUEJw9UVLVeDtSoSZLeezFWk7k68e?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:35.3941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89284da6-7149-46fd-3d48-08ddd6a53215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 17:58:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1902

Set default stable PREFERRED_VERSION for kernel and sdk.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/conf/layer.conf | 4 ++++
 1 file changed, 4 insertions(+)

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
--=20
2.34.1


