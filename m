Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A5BCA0EC1
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 17:58:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.84])
 by mx.groups.io with SMTP id smtpd.web11.29076.1754675916354407551
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 10:58:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=O8sxRFCQ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.84, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3eRCt1pej3GNHbmv9lphQLN98yjqfBINIjqGo6tfBALzwMGZiyy7So0hry1iyyVwffMhk4kCjaBK4JQZkyk6Cs6pmPkPhF1nwzw7eweZE4Xyv0pzAVVoL7xL22ABsH8e/lrl1EUbnsFy1KiMR3/bR5BErp7Tq9fN4acouFMV19I0hAbimWx2AqYgCogY1xQYTuBP4ZlRqL+0+GBcF6eRJoQOTIhIXzmBfQ+jxdw7mOFVjYBVoLfWv8jyrjjtx2Q/kJxytwJxM6Fq7hJUbA1z1bthJ0Arpe6ND4+5rB8aP1yycxXuDViSOi7K4Lmmtf8jBwToPHarbujeIMMRr6xcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCJRxRRj9LPhEtniwOncZ/BlcT/pBhuu4y4kkbtB6l0=;
 b=JQJKhrDr1yMVoFbfQYSs1QzgJkWJEHaQMZzolNVu58QMr4dM+qBG+TFwxeAyhcES4TQMBTrHTVXqY+kscsW/1DQbLcL8Axm4k1R86naLYsZ3ym5CetuNau7w19BKdriJII+MeE2mzqIioz7qX3mWdZajDeMRgMOZWtZPMbuizA/f5+5tNTX/HYTXSKrbaRt/k3acd2iYKVGrR7atKtKh1ieMcv1AtFaewPrZM1lhvGJ+jv21OH01d+SWf+A2TJK13gKn8KEqkCMWCiwkUhvuFG/CSeDyEe+cQ0fZ3UPgu31nsqT3iAS+zVnYD+H6sX5702ibYm/G1bRnSADlZ3F1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCJRxRRj9LPhEtniwOncZ/BlcT/pBhuu4y4kkbtB6l0=;
 b=O8sxRFCQAXP2AsI+TX4yaREBYH4qc4hqgVZ398QJZihdPb5js6sed1pdALcqz6eUAjvBhsjAUlb/bCG6wku5vnUlspH/XsyHiu5NfxjKZ8TyLHN5/1RpRB9gEI17Cpe6dK/I+emxSrGiBQXAr8iZVhwzKzO7DY5XtA0hGo4EeDc=
Received: from BYAPR07CA0092.namprd07.prod.outlook.com (2603:10b6:a03:12b::33)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 17:58:33 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::e0) by BYAPR07CA0092.outlook.office365.com
 (2603:10b6:a03:12b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 17:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 17:58:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:30 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Aug 2025 12:58:30 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH 1/9] qemu-cortex-a9: Fix runqemu errors
Date: Fri, 8 Aug 2025 11:58:21 -0600
Message-ID: <20250808175829.3830489-2-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a753cf1-6cc0-4cb0-83e5-08ddd6a530cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?izByuAzYBlVLM/6/umlk6ygyP+vt7KLK0C01ffhAbGzj3ion5cRmiZTU+MYF?=
 =?us-ascii?Q?9nnkhFUIdP/qzdKBeBLUpvRKjaPxh1SnZ8T38Fk3ulv5GtsSMzR3Mq21fux4?=
 =?us-ascii?Q?Ifz1aczowvOUEpYdE7RG9FDZlccDFcoX/9VbBH1jwa66gyq77LCwd5JJSubb?=
 =?us-ascii?Q?IVwt56BZyvDRigqal+FYya7unGOIz3ctyL3SDIHgYyb0qJPUbjWEySONtX3U?=
 =?us-ascii?Q?mE7Y5aE+9/B7u2/EUKYnYuy/vI4cy/Qr1Lejk6a7QA4a/FX6N43K3mNz6mm5?=
 =?us-ascii?Q?I7cKwv1uBYiv1VFFrrIavDqLP7oigPPeaw/SYWBII3yoSWonPH0ZVZJlBAKY?=
 =?us-ascii?Q?XYPfa9vxT5+usxnQDo/8tRMUms5+0g+5tkUPiV3/K6EhrWzUiEp7uKvm3HZA?=
 =?us-ascii?Q?4kLjRIrSfMBX515rUf8Ek1hnU+F6eLjdNRKvF1D0OPOVjKzP50IuFejUuqR7?=
 =?us-ascii?Q?RuSEJfxYwxX9PHCXTK0sdBanAvQqiAdSq5ipjxhGoyaWajpAU68KiaW30WeH?=
 =?us-ascii?Q?A7j3kgjAbnDmigL3EPNjrBM01QOqmvFC0rxuj8vXQ+HEpFFyLp1ASFGyOTGA?=
 =?us-ascii?Q?ICTH/T9kYpnoERrYHRySTGP3vMe5OYmNBni+4spkQZkLskMiTdn585B3+YMQ?=
 =?us-ascii?Q?m/81nLtJZTDYUV88BjOcjwOrYkvY8qGICAoj2Ykt7I+J1NKIwI638f+4zuoJ?=
 =?us-ascii?Q?VDXL0/6un9aQddLXV1EsFxQIWZcGNwlj++HEF0VYCMAqSAXsALYJad0+/TOE?=
 =?us-ascii?Q?v6JjidMvLrWZCYyaMptlzwrL4FQEmkPCrGVayDpp7HcmqJIUHiFuQ0Yxtd1r?=
 =?us-ascii?Q?BcdWCo9vGtx0KIkrAIxmlU5s8ovSM1eLmPBbutSmcLLELNzYgoZbOa75csqX?=
 =?us-ascii?Q?9y1gm6tAvqOQ6FhNEzwSXJNKNFc7X5N623Lye/cbu8rl8Hbs1hPrxH+1mR/V?=
 =?us-ascii?Q?P6uhheoLSmvHXo6WWz8G6Lm5sl3sbiUGP7EYyE3y0urLWvZ5/I++ix4Ijhhp?=
 =?us-ascii?Q?KF/2hCZlrszOqm68mgUM9g/qVHFcJkBIa+v/vGmAe+J5untBsSwnif0jO4xQ?=
 =?us-ascii?Q?o06uLIxF7sUm/EuN5Ld/g0H+eZP1ffXBhlJPe/cI/TJhNuYlRMOA+gIcUQRl?=
 =?us-ascii?Q?jGsqgKXtc8oUct6OMCyZfxUUFXN8A538uIwi7YqyqCYgZ1CynSml1DbRsc7M?=
 =?us-ascii?Q?8OMeVZqd+kHE0a+RIa6Z48jVTf1RV9rzZF2OVzBXSMKZdRwNgYyKvgzrOvcv?=
 =?us-ascii?Q?KABn/oVESPYGD1rE7m5aIUj7WB9iaCWU/56BBAm06nl1TDglmQH8ur135e+/?=
 =?us-ascii?Q?b8lVCMWV2geqSyPbqeVtOO2jBAwcspH2Xt8u/UIGEnK9evG+0gd3GCNFSk3I?=
 =?us-ascii?Q?t/nbweHtVlgYbzcmYIAbRSAglpEHlHOqVWpuU8xXBO3jDx7W2apE3kDpgEXp?=
 =?us-ascii?Q?LOquX4MhhXbJvIAMuEYJ3/Sjzjp+cAsXfFX70pCGC+DqOtRuwcuIRLGvi/5N?=
 =?us-ascii?Q?xMOsgWyq8ZIbQ/Js7pGPRRtwGYSXoILyMLlA?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:33.2595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a753cf1-6cc0-4cb0-83e5-08ddd6a530cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 17:58:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1899

Fix below runqemu errors for qemu-cortex-a9 machine.

runqemu - ERROR - Failed to run qemu: qemu-system-arm: -device virtio-rng-p=
ci,rng=3Drng0: No 'PCI' bus found for device 'virtio-rng-pci'

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf b/meta-zephyr=
-bsp/conf/machine/qemu-cortex-a9.conf
index 9dfee42..e1b026f 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
@@ -14,6 +14,7 @@ QB_MACHINE =3D "-machine xilinx-zynq-a9"
 QB_CPU =3D "-cpu cortex-a9"
 QB_GRAPHICS =3D "-nographic -vga none"
 QB_OPT_APPEND =3D "-icount shift=3D3,align=3Doff,sleep=3Doff -rtc clock=3D=
vm"
+QB_RNG =3D ""
=20
 # Zephyr RTOS settings
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
--=20
2.34.1


