Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC0CA0EC4
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 17:58:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.47])
 by mx.groups.io with SMTP id smtpd.web10.28856.1754675918846611653
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 10:58:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Uw6KGuUU;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.220.47, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTp4wVceVANWR7WlaCBSrOjKJMJcLMXBSbgSaw/469QLv3VbvbIuHL1V5OrLyzzgCcUetG3iemeT3s3asnsDk206VdU4GMR6EU6ycqCnT00muUnI4yc+yPhfQmkBSLjKFa5wkOy9evWISDPuQ7VhaTvD2W8DWEC1tOZDHwnXDGauiEJJcoNPh2ZrSN4+T157OREF33k1dZ8XSzoDzSWLYJKvSZJSDEk9Ip0h20jz3YLR/7i+GhzOraKzX+pbCNKTzU+v0FDukAfOP7MkHrGru8eXVhRhyBYphgrZ/4puUeXY1/8ROtVIhaSeKNTom/Lem1QRVWQzeietRwsrZw4fCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYzt/v9wqiZE6y4AizGasoK/eWs0l+YqxrypKDI+iME=;
 b=ydXJpRX8Q+jDXZJjS5wFzgVB6qj48oO+iFlQ4+HRY6NVExs+UAYjTc+SyCVpecKEVFhtXHNWkSk8/cFFiTLQhh+PArjehQfn2MdNlag+8Ofwjb26Ldnv01NxwEVUsurZGU5fchrT/ADNzENwfMfZdN1FvNQd8uk0J5Jun4/EHYUQD14gxooyJs4VD0jOeliExhNiedZ1CRIgmRbGATkcYtrijrHccHGz4QR+Ll7kX3Dv0bTZAclzSzKwxjNt18Xa9VLxmCawqdxvkjfI01HN+J9//N1n6MhvkwcR4K3GBfJrkuvH5/vvkmVa+K1GzSmmLlPKj76vdjCQrKOvOyzpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYzt/v9wqiZE6y4AizGasoK/eWs0l+YqxrypKDI+iME=;
 b=Uw6KGuUUZJDlZEEuiw7LNACRR4nWN5+aOARPRSirl/k+5qWZEkRkUfjVfk4dNEfc3Ruq4Ah2pe1BtC3yZOPN723cyz4DlWBEiudrEcTZiuzrAESQE64wZlUW/Ne9lUlLrUlhtvNPr6KDDbOkfWWHaesPo+43WxkCm0WSR8Zm75k=
Received: from BYAPR07CA0105.namprd07.prod.outlook.com (2603:10b6:a03:12b::46)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 17:58:34 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::d8) by BYAPR07CA0105.outlook.office365.com
 (2603:10b6:a03:12b::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 17:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 17:58:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:31 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Aug 2025 12:58:31 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH 3/9] zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
Date: Fri, 8 Aug 2025 11:58:23 -0600
Message-ID: <20250808175829.3830489-4-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d047e6b-c377-44df-bf1e-08ddd6a53158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+5c7N7tEZmNPHFBu+2vlvQ4P2gCycWE78Iq5YGsqcpConDZoEIaVkzvK1r+o?=
 =?us-ascii?Q?wCDvGg9SBBGajgV8hgT5ymAps77yu5dM1WdjqY5/204mtI10IrL26z1i5MVc?=
 =?us-ascii?Q?aAg7USpSlToScxJGgqlalrjYUHpolPFyfvqouqlq+VGZA4vV7P5/PQBC3Cxt?=
 =?us-ascii?Q?VIdYuYxn/GShielZMUj3pAaAwv1gFt+Or9gjvSZOQ/L0zb6LMiATN9Z1rhlQ?=
 =?us-ascii?Q?9JJllVVF1J+h/m9VY6WSjnhUseb7rP7Vu9/j4j14rfPiE3GTr38ZnuXNu5lk?=
 =?us-ascii?Q?WRTBJdfPKscl1XDqINtwH/HPBu5mw7+7Tzy1Nxn8riqpKxMbPHNMN85HqLsG?=
 =?us-ascii?Q?svvmSiT/Py54mOTbZZ8pz4rMqXNi5VgWOzwOwc2ass8TWLpRMxdAFqKBJ2RB?=
 =?us-ascii?Q?YHblBuevf2EO23WzcGSvHqVQdM79hGD270XkzLQhF5x+eWAd8Cvsr6NaM+dH?=
 =?us-ascii?Q?vH4xQL2feMCh2K745w+pG4vvxXb76ji8GKvY+YfpQ34Qhlx3sv5h/3aLPB0c?=
 =?us-ascii?Q?mMW5FvSyH23SttXnhO8Y5aUqXJUu83jDtIgUxJNYG0MSrBIvfk4A9Kuz+TSA?=
 =?us-ascii?Q?HT6cxRpEHRYlAnJVilFWbT9E+C2MWzYalMM5B7VOntLWBwl9hrNsb7Ha6TJc?=
 =?us-ascii?Q?ttHh0yE5EQcypbz8+eoqHXcKB4nBUFdBJ9iPgz6S+smnSvLemp4GXuDxNGn4?=
 =?us-ascii?Q?GGteETYp+YJXMEWelQ82GUwq4gZbTS6ilgqafDF9W0tz0EL3YrrUQIaQWg34?=
 =?us-ascii?Q?rpcJVMeIjmoiTSJP29j0E8BnFeZ0IMxwsvIgZ/1jzz6qIObevKXco+O8ALvU?=
 =?us-ascii?Q?jFhhky2Z8MmcZNSk0UPZ/xE5BXN2JQaImYOXK9IJ7u7cuCyAqrrD97dzAE/c?=
 =?us-ascii?Q?LtwEDnXmOjb/P5K26t4MrEAllTr69BPjZ+W1SEgUCFqpgGEYS8n3fyMkVjbR?=
 =?us-ascii?Q?/ryL1fT/7MdTJLYZynGHrkG9JSL3Uu9X1zJDYFbLkZt36XsCS2EfSQjDBz+6?=
 =?us-ascii?Q?mKVWoLIBp/VkYiuhzith+c2NRlTMw6jpJu5Kav1plgmiJdZwWK9TWGLDKwl3?=
 =?us-ascii?Q?g1q20VtMBpoFEh744R+jo/I3+J91XbQ0fsw1Jwv1CeLvYQU+LZPkPXbDvSGO?=
 =?us-ascii?Q?3WGuUiPOHVGpRi1HaxXk7Eksgilzwi6L9Z9817+f6RThckxYfOoLJA0oRaS4?=
 =?us-ascii?Q?bRxHXDcDlb8CFg6T2eL73srNeKRplI2KtqKE0akV5ay7mzNw4ojl+Y6gBltS?=
 =?us-ascii?Q?n3l8LZHpOajIeFXmkPbxV01GowdZ1q5Uhm5NyILeEBgk27WhV7EJ+9It1C4q?=
 =?us-ascii?Q?yINoCyqxcTGtUe5CoFAD0GjxDIP0cCcbqRqpwkyOPMgvgP2zGwVU6S35z4Jl?=
 =?us-ascii?Q?XYisPPtQ0ywm8fSxq0YC9cQSTAJkicHVTKy9dIzzJvjTwvZb2bx/iwiHf9/+?=
 =?us-ascii?Q?Vq08boUIpc/K0U8E0umBijo4xURXpB74Rb19Lg+JuAm2dP2Sggm2fMw1y5Vb?=
 =?us-ascii?Q?kUtx8Q7VmVw4xoKUe/ZIrc3uxJI1dQAI0LOR?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:34.1599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d047e6b-c377-44df-bf1e-08ddd6a53158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 17:58:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1903

Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src.inc
as it should be some in global configuration file and override from
local.conf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc          | 2 --
 1 file changed, 2 deletions(-)

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


