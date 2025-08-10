Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF51CA0EC4
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.83])
 by mx.groups.io with SMTP id smtpd.web11.36467.1754869166726418680
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=XPWrohJa;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.93.83, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KH2jzUtwjFBlEjWexbnVmoUoop0wY1b9n6/wJ8Ej9AMxz17LLLk39FKf+Fv1PxnlmOVdb5ixVb4UmQMA56j58LaXJub3Et3SIJ4dH2dctR52T1aAwChOhl4KtZlVY1bCWDoS1EtKTrR0h9DGOV6jEWUDGBgIKKkDGivOpxT9vBSReaG5sZOwjUv074c4GFNwNh+L3YUgrKcGQQC2rnBsePJtljMf48XilFnOo0upXu89OS5SxSDs1leIY4VSIuzEv1h+jDseUc/48Tbr5OQv/TNZqnCaubpRnJncwyKZCAlMDXgagoAVl/HMERtmxM7snja2FkzdpeBYHWqpNF05UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=Xy0RXApsphxHXhDDl8pJegO76xr1gtBzduVfs73qZseUilnwagmE3gGZS2exRDAwQX6U6zBJzzOPOdZrMQKbiPhb05yoQlOfX0BAxV08gvrD/8mGRpPwrUPG6fgIKRJvOitbnmncmAbyTgQnQDoafrPmM4FvCYNfiW4kluRg6gIvJ7QsVLAfRfFCZ+6TeuLs0ESA6tfuNA7rM2yJMHOXV6iB2Ierr3xWoyk2OugFXnNVpsX4L9HirGTamPADysX+hGFigoc7xjFdGUCtP3fgzktl8IoI2CTCBfJTjaIrC0Hv1aYKHODQcR/qaCNTOBfCDi0dO6uw1Y4I+QV4Sh0fJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=XPWrohJah4OExPOckK1OmXl6GUQGsW8I1DCvoB0Cg9Bb7lwcXD5ugZAjEJFqRHBzuBOkKKpsSS+bjB1VY9P0hzyZ44e4VD/rMN192aDWLv9whknD9uI/rGAwSwIrywouuNkvAbJyydExsyrms5EtzOpfGJcZ0i8CJ/OWHVFI7fM=
Received: from BY5PR13CA0004.namprd13.prod.outlook.com (2603:10b6:a03:180::17)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Sun, 10 Aug
 2025 23:39:22 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::ea) by BY5PR13CA0004.outlook.office365.com
 (2603:10b6:a03:180::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Sun,
 10 Aug 2025 23:39:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:18 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:18 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 6/12] classes: Move classes to match bbclass scope functionality
Date: Sun, 10 Aug 2025 17:39:05 -0600
Message-ID: <20250810233911.1259884-7-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
References: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: df2de0ce-5c2c-4785-0cec-08ddd8672206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jonENB4ou3k4VuoVhmT5IG27BnFPF0XY3+O4zJ+Ii+bIN9+/vK8aoY4kgFqg?=
 =?us-ascii?Q?03sbo3sCiSlnY/PqrQnuPLGDHfgsL+c4+OpkuEKtQ5nmEuEzih8KoQyhyyMg?=
 =?us-ascii?Q?SjK2Gbooxt/wmPzRi7ZI35CIrdo1lUxNN4L/mA3TkbixWt5zTB4ovaM3Cz19?=
 =?us-ascii?Q?kCOrXf20TEVqCaZw0f5WUsUdt+1V5kTi/tB/PzBsvxtkaYj5T8NzkTLWTxdt?=
 =?us-ascii?Q?C1Xfj6PT3qaL/bt8yOvGFpy9R02Y5kjAfAmBY1HM0RuzJKyv2wojq1bpheOn?=
 =?us-ascii?Q?UKJQWpmrTPmgf9FN9MHfSODA8M00tNg6ag7TldU4LLOGWP1oEYx2/6zmmXGu?=
 =?us-ascii?Q?91ZXkRQIqQWHV5g2xnpvyjKfwWofWaPCq3vePY0lUiqGDUcZ7ahoCjZKShdM?=
 =?us-ascii?Q?DIkQvxdTPg6e1g6E9KA9q3Nyj3C4VHZJ8+6Bd41HOJ9qqNwpaOpVklBgO27j?=
 =?us-ascii?Q?rwxFyOZqI9VN/d/0yg/1GmPRoe0hzc+2roTjQ87nOKwk7BzJjTxQYfgjensi?=
 =?us-ascii?Q?wL+RgyyZpN++7Rf59ECiV7aTE/AEu6oinhEc/L0+6dMbOAZhEVsBem2F/d8p?=
 =?us-ascii?Q?RLLg7+WdT2DeM+RxfXO6npcGqdOJab2FpiBYdiCSZsDgpy9L9DlVy3+vIQCl?=
 =?us-ascii?Q?gb9YTbwiPoSZ6AWjQDv1aKNGWeAhrXsecrnSgOqxKLCArkaEglx3ibol58SV?=
 =?us-ascii?Q?Y8zIhaKrO3KHPWCMHVE1KHcylyyYHD2lMSl7F2olJshtSNxjZVxBG6tghNmd?=
 =?us-ascii?Q?YiGBuFrisERnIxUf95T7ErE9lYjX3KMveYrDTpJ18MbmhA8P9O/D/ab0sqS1?=
 =?us-ascii?Q?k4LMTaXg6Yye0BcYQZDcj34BgWk50+/p2x0OORoW4RIhRV03wpVLcbMW5/sR?=
 =?us-ascii?Q?EI3RDFHRTVS9ZN7inolkN27cCKTAA8ydNJJfyIntF0BFQN6bu+BE3a11gRfT?=
 =?us-ascii?Q?2IJPBtSBqKDUKms6wGeB1tp87MYj3RT9/La+NOMVpB97XeJUUnp5YKsGOcsn?=
 =?us-ascii?Q?XxFjaC/R8wBAD0AwJ3jzIIwM0JCpRL9ZUwkvEZAFYiH2GrMyOHPR9qBHs5vK?=
 =?us-ascii?Q?IAMTgbnTIyVp+cYzElr0KQQTj+FgfLeJ9q/ZQwpGq8h0p6Wfnie/f4uwTBzJ?=
 =?us-ascii?Q?Xfph5kkudJDVbKfvl54oy8D9kAviMuopbeS2uKUbvYNcevOGFD4tROjn+SOn?=
 =?us-ascii?Q?hBTLMvIlNH9UdPvAlidkISU8WQV+BQBdxC/cFuhpnTPY8UrBKGMGE83gdm95?=
 =?us-ascii?Q?nK7lUlRe/GF5rfoWm0hwDQDtJ4OzzfDBWeEl2gtkX3WOvOAsbTxwaS7g4WMW?=
 =?us-ascii?Q?DcByskPi8KFvwGaUQXaAa2k9LfNN9XARvZZXTzRb55T1YOjxlKO3mwHH7vFj?=
 =?us-ascii?Q?dC2oM2q2jLOVEIKAgktqDvr4XaAyA1CDHAaaEoJQcfCWkyDlLyHRwzO0UyNX?=
 =?us-ascii?Q?nxMjh44FhNIwlf/jqF5HGokjFgI6cvnixEPhSScPNCGTXpLxODysDDDmCRW+?=
 =?us-ascii?Q?WRCLE0IWpK2AQEo4p9560OrW4uWDDQSN2RmN?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:21.9191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2de0ce-5c2c-4785-0cec-08ddd8672206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1917

Move classes to classes-recipe as appropriate to match bbclass
scope functionality.

zephyr.bbclass, zephyr-qemuboot.bbclass, zephyrtest.bbclass are
inherited by recipes hence move to classes-recipe.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../{classes =3D> classes-recipe}/zephyr-qemuboot.bbclass           | 0
 meta-zephyr-core/{classes =3D> classes-recipe}/zephyr.bbclass       | 0
 meta-zephyr-core/{classes =3D> classes-recipe}/zephyrtest.bbclass   | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyr-qemuboot.bbcl=
ass (100%)
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyr.bbclass (100%=
)
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyrtest.bbclass (=
100%)

diff --git a/meta-zephyr-core/classes/zephyr-qemuboot.bbclass b/meta-zephyr=
-core/classes-recipe/zephyr-qemuboot.bbclass
similarity index 100%
rename from meta-zephyr-core/classes/zephyr-qemuboot.bbclass
rename to meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
diff --git a/meta-zephyr-core/classes/zephyr.bbclass b/meta-zephyr-core/cla=
sses-recipe/zephyr.bbclass
similarity index 100%
rename from meta-zephyr-core/classes/zephyr.bbclass
rename to meta-zephyr-core/classes-recipe/zephyr.bbclass
diff --git a/meta-zephyr-core/classes/zephyrtest.bbclass b/meta-zephyr-core=
/classes-recipe/zephyrtest.bbclass
similarity index 100%
rename from meta-zephyr-core/classes/zephyrtest.bbclass
rename to meta-zephyr-core/classes-recipe/zephyrtest.bbclass
--=20
2.34.1


