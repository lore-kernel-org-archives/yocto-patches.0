Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D9CA0EC8
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 14:59:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.46])
 by mx.groups.io with SMTP id smtpd.web11.49946.1754924393959566746
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=USMTGcZP;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.46, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbNShSQDZrya9q79ts+MVzcj9LkQsTPH6Ez0YBcLV4AnVFCvrNraDNRI3ELNwsQrcd4VeZFNOGZMmvMjIzLviumNVbAlKADyO8v9aW179b5NKUAIyRxf7G1TlqYatwLEZ3S6Dm537XdcnO4cMTqt5HQTr2oIHGfnQ7seAZLxokXCPkWTupVNAbntMobcaw6VIY/7+QpSkKbcVnngLdz6G6U1EGqRsjOJPn9yDnh5jLtUtljfosHa7/9CzXoq7kjPFpXQ4cn52TKO3LhBScB25XEUsNMT22Laxz6dxfueN5MR0krCZBlWA4dIn5pO8lWAA9P1RD41zjTNp64oqUYWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiQihd3bLAf6AZAPBtb3sDQSmqHGxv6qBzljVd/y/wY=;
 b=r2zByXu/kvrDH8vQBl+jnNFvrK/fxMZ/6mZe8FR7rVmipRCmbRJNV+KxPvPlJbh6LHWe+6u6ZqP/jvV4lBx7thfnEJtTt1/qEMc03Ju8wm6mseLgiUN/yUAiyfmEXMnRr8JhbwU1FoatrkimKMCf/h1sWD5XQdTGt6/eDX+2yKk8bDXyxEhBDbVo7a8KvKU2lHVlmCH4M11YrW/76TyWARfJ0C1fdRiP8FTRo80Mq3VT5c1IL+9ITp9vEYQOc049iDhIuDi7/gDhkY0JP2inpmutx6wE+2cwf2tDzw3SzQg5GT3LG+gHGehMwoxQsKmpGQQtGNhwbLQzOu062yW1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiQihd3bLAf6AZAPBtb3sDQSmqHGxv6qBzljVd/y/wY=;
 b=USMTGcZPsYy6TWBvM+BJP27TetU2s3iWyLuIIWRrDZ2feGt4sWhmO5vpYMi6uR/IfFgq2xeqsCEThkYlagWo0z6sl1GNhiMlrWGmcbGMQnf8KiljoXW+Xfp8CEZLtSv43eBpyl+ucAvxpKMkoa/T5NnvclePxAyQCETRwqiT41Q=
Received: from BLAPR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:36e::13)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 14:59:50 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::e3) by BLAPR05CA0018.outlook.office365.com
 (2603:10b6:208:36e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:47 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:47 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 4/13] layer: Set PREFERRED_VERSION for kernel and sdk
Date: Mon, 11 Aug 2025 08:59:32 -0600
Message-ID: <20250811145941.2553838-5-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: a788ef89-2727-4ce6-4a11-08ddd8e7b8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1Xm5dStHylX+XBoSPfPqs3Ul8zgrD3iEGXpEHzJOyn2O+7+mEmzH+bWWPsC4?=
 =?us-ascii?Q?Y8nhy1+5lRaxeJOdZ8P2HT95yFC0WfNqOW3aiOBs6UhjikwaZnfOU4+pC1GE?=
 =?us-ascii?Q?rU5hTvhSb5sClTnrPw8L32hbJCx6ctieDT0SKM+/Fgmfw0NiCGOczH0ES+gd?=
 =?us-ascii?Q?36TPCKAM4Qb5gWhJPSjYmDUiyhOE/ko/I38XydUOK8nRmD2/G5939cEJsbQd?=
 =?us-ascii?Q?Oh11hCIK5UdjU+im3vcWtMqmDG/U/R5hLp0c/vCQ3lp3sNy6ZyFzdAS4CnVi?=
 =?us-ascii?Q?Ry/nZf6zXqM4PPA6nC+eCjYW89lXOvMIvFpcGY7yuORNrJXfHpKJ/nmqjdON?=
 =?us-ascii?Q?kdybALh01MIY6FNyFUo8UYL5heCkcjlxon2llNsWKTw7/Sa5MxZ29dWUpKxz?=
 =?us-ascii?Q?hbJuvRvqZpkrinquJ3eCEMN918iaSuJNKCAweP9eSTcAbQpGXoMJHn9JHi7P?=
 =?us-ascii?Q?5IZM2E2otNj8969QG2AKhFu5c7mY4Y1IiYrc9QY8r6K2oCCOy0h8fbzIt05c?=
 =?us-ascii?Q?BIJ26L8E8+5QAlDRw1rxaKQ18R96GKYEqIl3irAG1fDPJG8XAcTFa1Qo77p9?=
 =?us-ascii?Q?hL2namxTUKZ2g4gx4nzXpDeA6oKMA5s5tciRDsHPJQai+7ZI95vr9rOeDmB1?=
 =?us-ascii?Q?eXE0ENzyOHtPDeMhxqKfwSoqX0OWVyZna+oplS0zKI9CWG8QDELyUmBbsH5I?=
 =?us-ascii?Q?/kbsMTSt/6t2fmKCDzNlUYDA6oXTSd+1fGVRAIqS4PFcYaZKEBbdPygqhCUR?=
 =?us-ascii?Q?YUeFlCPZDh090E+gbz2yxPiyJlYMSFC8TGEllyREyISRl4mLG2gdq6WrcuRb?=
 =?us-ascii?Q?FNSzS1BJPcr7bmr5/eqbGPQZzlemmJbo7cUuBBjOqHDVZo9tQ07l94clxgOe?=
 =?us-ascii?Q?WwzXJw9R07maBL2ilF1nXLci5MIqEJot/JzZAeoKx62jRi69iJlY190u0vtm?=
 =?us-ascii?Q?WeEBen/7Q+4ng6IxRmzeK6zpbxka0xOVwdbu92RcwK59sI8HrX2RhiflJO/F?=
 =?us-ascii?Q?0Uwbi0LZUYoC9zWQawP99yoXusNLKBGLZVLdKHo41rAOs5j+vR+R4zLOhu+t?=
 =?us-ascii?Q?2PHAlzIU23zzuoU1o9FTn+WqnVQ70BR0tOdbKLchA2RwJaMinh1LtthaQ0ca?=
 =?us-ascii?Q?BWBRu73y7TbZ6/BRiy+M7quiOS++GOEygcLbEkYcNLwHCEPcmpdwEcKiTufq?=
 =?us-ascii?Q?GvOu/YBCIhX1odLLPfCAGbUktLCJ4wQdhgw2aV4iRB+/qkqc/xCgA6fzhcL0?=
 =?us-ascii?Q?Wjjy53FHvQqSVmpmAgMlg/dcjnQIMT9her0a4nV1QnvVtXgfNRqegB6fVhkS?=
 =?us-ascii?Q?n0F099zMC8NNqKkoH3zW9rhhfS0Wjw8zzgKgF26nshrXMDwx5zOMgjO9/sg+?=
 =?us-ascii?Q?WgI5mXeT9BTb/F4DO/3/fgGqZWf9AV3v8fcQ/QWt00FLKZeSSnGOi08ra2PJ?=
 =?us-ascii?Q?KUJLdM4BT2Vi4Ow6YV7cX0N/HCrx5It5mfZntloLzw8qPTSAAvLbnh/3HwGX?=
 =?us-ascii?Q?g3k2MddCDpVbEr5UJI6q/3d8O3TeHbMSrR7E?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:50.6004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a788ef89-2727-4ce6-4a11-08ddd8e7b8d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 14:59:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1934

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


