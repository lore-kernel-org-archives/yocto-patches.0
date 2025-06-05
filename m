Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260E3C5B549
	for <webhook@archiver.kernel.org>; Thu,  5 Jun 2025 03:23:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.74])
 by mx.groups.io with SMTP id smtpd.web11.35283.1749093797847412197
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Jun 2025 20:23:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=MBAhv6aF;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.223.74, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOidvO/9QWYU6diI+RMpJhwYGoOMEN3skQjKBABjJOTp3kVjAhVAlUjVBKz0D2YRNzvUj5g73TbF0jn0QDzPnkKC21U35JPKTFVYOdle1br4CS0TrDdk3K42CwW9tT4mC56jNLJDJQaovAcpgjANsEn55BUch7VlR1ISe0syqSFpq96nw+OzpevcVmwcHeVq66WOMxvUfLAx5NbMmJJfQ5ZoF8kqZqXqdet89GZj0rp47RG5tcQl8zBH2oP+CW9PHzJmkrHaC/YFtnbCd1B8wCrpwW6OOBtyAHK1GxYKgbdTQ9YE4U6250ZfSIt+Cn6uHAJwQkVKEyXOngOkOxXqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kstApQ2wfXdPtz954VyHIYN0Jbt666llgEQKwjs9F7k=;
 b=YApMjjoXv/ZIRaFOLGKt3+5syHb27NjrGwEaNB6WSXSed61PIVCByDoP1jVpplDhoeUpXxU5bwmDW4062Kj69uHBh7JqivNAhAa/jFq2DT9Cky9ngUNX9OoAjaZFtkqdbv1tMR6mkI/u1ZuK35oiCw6JT0fM8ajOSzPZhG4IGEM+4nwnjAgXy3MIj0iH4rNYcukR+WO7XOOqHHbgKMT6+27oz681YOwCaBOndCIqH6FMzSLsSXhA3ItxkSkpG5RJfUbRKgGlLY62T0/OZPpXvSYwIrVjDiXZOFR+SZGySCNk7/oTsDR75a86vD6ezWL+7PuFnkm7DlGY55tC/h1ydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kstApQ2wfXdPtz954VyHIYN0Jbt666llgEQKwjs9F7k=;
 b=MBAhv6aFTR16SxH2ZLB3jpZWf60hzceK8TJm9Nt0UU4VscAHxB6McgvyIlTxLtXZo6drm9INRQDQkiRXKHmDVnwsl7PB4ucT7VmM2Ku+BXslZrTXHOo56PWZgx5K73/u9YuBphnvUq7UhmTB/CWUjYPSN+Eh2Dv1sgDNnKgkczI=
Received: from PH8PR07CA0006.namprd07.prod.outlook.com (2603:10b6:510:2cd::7)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Thu, 5 Jun
 2025 03:23:13 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::be) by PH8PR07CA0006.outlook.office365.com
 (2603:10b6:510:2cd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Thu,
 5 Jun 2025 03:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 03:23:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 22:23:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 22:23:11 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Jun 2025 22:23:11 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <naveen.kumar.saini@intel.com>
Subject: [meta-zephyr][walnascar,scarthgap,master][PATCH] layer.conf: Add LAYERBASE_zephyrcore variable
Date: Wed, 4 Jun 2025 21:23:06 -0600
Message-ID: <20250605032306.3073101-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2116e4-6048-4258-7d28-08dda3e04ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TT1sAFK3Qgg/XhIA6wKAeA6jW2udu8VyKngdNZrv/8Rv/Au6nVm03Nr7IP9T?=
 =?us-ascii?Q?+4zpxeAUVGJF+AeqCovn6zMraQNzi/FUygu0bjx6HS/bRvCm2OUyfgfcjTEA?=
 =?us-ascii?Q?f27qQtaH7AgQ/GqVroLHM0AIBrKAE0DnEHfhn/bTiGZNO/bAwGDxcUaFp4TR?=
 =?us-ascii?Q?ScTvHycd/aaSZVmOZml3J2aYJJGertEx/z/Yl2JAnmzn5XO1W1YHRjzKAOvg?=
 =?us-ascii?Q?/sMGeFKBWUvP04KPy0Ji9QFP7jolCEznY3Im7mN25QH1z5G2iMdaibD1h2aP?=
 =?us-ascii?Q?NU1fHmY+mBqF2rV5E3KHyueY1tANdarDIN5aFcULUM8BWuw16gQvkrmpZJyh?=
 =?us-ascii?Q?k5QukPpHZF2Oq9esEaaz0mjiQKukIP+o3t+dvu8SSua9OyVC46B0wwmCwNxY?=
 =?us-ascii?Q?/k1asx8zLzopPP6P69hPT4TAsHMjMnza9Hdxb37AUm9mlh2i/iPlrJWSkwIl?=
 =?us-ascii?Q?rbaeFqArrIHpTAojHQSnJrHh7nznRanWnbSmngHq4cwBAfVEIoBHz2tFY37w?=
 =?us-ascii?Q?rwT110+y0OclkqLtRz2ocSJSf74Y537DvQ0AZ3QIWZaG8FZVjqN7n8DhugWn?=
 =?us-ascii?Q?TR2d4oeabjB8WpSuRQXvs9IBQW5KlwEBfyihLAFb7hRoE9mR9tLZ5rQ05Y1F?=
 =?us-ascii?Q?EWxACPuCW24l3qgIA52W0AfWs9vhKkk18XfMVBtvoJyrk3LXL9KBI+MP9KPz?=
 =?us-ascii?Q?uFpoqxCZX/yUADS7irGViK49eRFn8CsWkUeTg0hLOpSZ6l+IDCY7qidyZ5yP?=
 =?us-ascii?Q?Gzkrfg5f0vmy18W9G1jT+JO9ww6hQlyhYJxayyue3lpR737zUC2kztfDags6?=
 =?us-ascii?Q?5r4jhQ2IfWE/KcgY5vdX/GKKdPnX8VY6eXHj/jb8GTmWrpVQTQH0eFD60zOu?=
 =?us-ascii?Q?rII09bBiZh7GA1//0ZTfvq+gEphAtMb5q9CDClIrh5OKS2BC8tHTJUa/umR+?=
 =?us-ascii?Q?TgQ3hm8bZOuwdvBgFbNqjYsR3RVcAahO67q4oPeNqqDLLLgrEoRtkJqzX9vI?=
 =?us-ascii?Q?I3c7q6EMxTj9qRiU6QbRzijOr++B/jfKpOGCnv3eKzuYDV63YIBxHO3EBtA6?=
 =?us-ascii?Q?HZNUEqlnE6E44gDl2SHtLvY/Ihlr46xl60AMdhmXzSYUZiozW5XgYmt67vx5?=
 =?us-ascii?Q?LLiBfvNvC4tu3rlkTiBLhpukhj9iAbCgJ/wpEvcESFgTi0SBDF4EhQe7+v0f?=
 =?us-ascii?Q?MRgMPyX0ww1SauIeR/GVqKNZZpWaZ6uChpLX3knJCPAj/Zv7riCQ0Q9zsUnL?=
 =?us-ascii?Q?Ma53vfUOoSQ4orSEV3ObAmAX3r27rX8AbytrL6kZ3dRRA3hXeraZm6hoSHw8?=
 =?us-ascii?Q?77YTq0Z3m7OxuDk0aphIwYq/j6TvgqEiBOVTM7osLvA7J/sBcI0JdnygsYEG?=
 =?us-ascii?Q?84hE9kq0l71uXXGD8gVItECXUB4ZAkh5/GTGl3nAxj3cpp76rYO8dAjvg9ii?=
 =?us-ascii?Q?QdsJuijWiAdR1R5sCscyxejFeiYvobJko2lkTXAUGmLmVFHTL97dmSov0P/2?=
 =?us-ascii?Q?3WmoH0xuW8dsOi1xm0Edsrd4pRF6tPjA+Nu9?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 03:23:12.9376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2116e4-6048-4258-7d28-08dda3e04ddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Jun 2025 03:23:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1617

Add LAYERBASE_zephyrcore variable so that files from
meta-zephyr-core can be accessed from other layers.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Signed-off-by: Sandeep Gundlupet Raju <grsandeep85@gmail.com>
---
 meta-zephyr-core/conf/layer.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer=
.conf
index e1bb263..a4b3555 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -20,3 +20,6 @@ LAYERSERIES_COMPAT_zephyrcore =3D "kirkstone scarthgap"
 PYTHON3_NATIVE_SITEPACKAGES_DIR =3D "${libdir_native}/${PYTHON3_DIR}/site-=
packages"
=20
 addpylib ${LAYERDIR}/lib oeqa
+
+# Allow other layers to find the root of this layer if necessary.
+LAYERBASE_zephyrcore =3D "${LAYERDIR}"
--=20
2.34.1


