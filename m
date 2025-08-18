Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BADCA0EE9
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.65])
 by mx.groups.io with SMTP id smtpd.web11.2756.1755554593254773403
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=mKS51p1V;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.65, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeHFRG4ErPLaYlL0cLqia/jctHBvxF8P+oqL/5oE9SFkQ8ohloR7g6iQwnSOxR0iN4Kah+vbhMI13DrWnzesUbLbs5IdkFzvhRtuosbo4StOil5V3hfKubCmKDpH7T2Uo0vHzpAfFxh9FBEScYffnEp+aCFViTljeptUb2Yuc6Nd6u1Uotwr31sCAaLsllR0rouND4LwrNSkUCkxgPJr++3PForkOKrwE+pvlldVDThO/zmjA7WJVSskkAHY/GH+tEvs08qTeloSGRM3mgTn5ONhmPIvz80JnvHmyEYM5zuy3nAqf6ATEQgDHMZtc97Tch4QZ9fmofb+ZYPwQO5/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=aPuSrd12Q9zZUVvPTWki5ut20WTg/kiW5Yb43P6EYWhVJ4etRhY++72Wv94VZg/08pVXIBq+kVo6svaJFmvdTrC2kB0baFpYfezLOCXbNebajMP8JEmHYq3pSXGrXDmeUVrlLEgUiR8SEkrEfcrKd9xq+p28+Jjeg5uPFKaAmbemkIlHd0z6Dr3+UrOdsvE3SpFLYcsJty/itG6mCrbiSSjkHOiuuMMC3ii/iWOhfDrhF8PBonBZ0AbbJ89xCwRC7EtfDBtUbF5KVR/Gy+KuNjig6IOBJSm1cSl1Cj6//92RToBT5K59vTtYhtnJArymZU+dmHZnxxcEmRt1sUc8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=mKS51p1VV8cAAuKkLyHZHt1WI46OmzpdFMHVrtCrzTVueRbBV3yGiSkF6Crp/50sY364uV5StOBmOTTjs+rwLyPvFmg21GB5as8c1nQP9kkXH0SiDPZAkYoMzX0DC7y6Ab2UgeXbJfQJyhZV24oLSHOd4wVU5Zmjh9lr32wkZo4=
Received: from BL1PR13CA0352.namprd13.prod.outlook.com (2603:10b6:208:2c6::27)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 18 Aug
 2025 22:03:09 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::74) by BL1PR13CA0352.outlook.office365.com
 (2603:10b6:208:2c6::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 22:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 22:03:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:05 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:05 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v6 4/11] classes: Move classes to match bbclass scope functionality
Date: Mon, 18 Aug 2025 16:02:57 -0600
Message-ID: <20250818220304.2300436-5-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb77ad9-1ffd-4810-43ed-08dddea3046b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gb+zNI22MOHlMsnxQ+SR2KMAcla3+50odpoiWItVlVF9SDIL6j8FSzVN+ld8?=
 =?us-ascii?Q?Za8+07yXoOFHWOgUf+pDLCc3hvXF73JJyuGs4W6g5xRoGDW05FYBnbrDwxVp?=
 =?us-ascii?Q?vvaufpf8wNuQzISKREGb+eQuRcoOWRU6ErjdrMtly+0nVfRjFFw/CKAjHkdR?=
 =?us-ascii?Q?RhlJ47DVziZpcJVA61PXArlX7Qa9Div75Yuks3Ts6w6HRndqOpfC3vp63klP?=
 =?us-ascii?Q?dcF5Gty2LkhiT+/cVq1sc/Clr4zgPOs3r10secOWiAAN1KWrCES1KCtzN+Hp?=
 =?us-ascii?Q?jbs1z4snpD5lg0BTFpkBsjlW4+fbwhhm9+pr5pgRl36Ds0rJYHWwe6KsbEgD?=
 =?us-ascii?Q?aiw2Qevfp198XqAn0TakFW1AxlsIh/FLdhGLeVrYYuK71jQL0iQ3HMjyJYLk?=
 =?us-ascii?Q?ADfdKKlfi3yfluHKj5cSmHbje+uZk0SJY8T0EcFjImlSdWHkvlyoslEwIoWx?=
 =?us-ascii?Q?71Px1ZImCuXNEoIpZ80z2YvoVvnJi4FwHz116rpPa7u+nYxna1x1jx50vifK?=
 =?us-ascii?Q?/ZWWeoT8/nc8/qXYZFXOCquvc8Syky2MJKLGjpfabdQRJup8ZlTNv5aotz37?=
 =?us-ascii?Q?clyNZIpXT4dt4hWgdAVjsmMPV4HE3qu8vctcNslfn1o0Mm2MTA7YfIerW8+F?=
 =?us-ascii?Q?l5WVXP4SyX4mKHhMpzLXiJli58nTgv5tX2X0PU+Wz1KY+EENeT8cgDWJc1Cf?=
 =?us-ascii?Q?5KrimXptwEoTXEnKxL1aE1i3g6lfvrRT79rbhON1jItzScE0og7Dy4as5oNl?=
 =?us-ascii?Q?cOQH9CsMuhEVzpoWDOH4SGxJVpEaoThui6vDdTg1Y1gaaEtcBd1yUCYufWeL?=
 =?us-ascii?Q?1a/Lyw4ENAK4qSQBGIuC7y8O8561bQh3fg88eWvgh/9K71qBg2whftj4d049?=
 =?us-ascii?Q?4Vmm5jF2XPabPSTgcGYdQxencd+3OsHrXbH6v2i6PiRCsQDNkOO2InBk4oYS?=
 =?us-ascii?Q?jiL5R4S6mMXqsXPzrnOUnyPHFbyR4AU9NeyS2wbtCRxZoMPBSsJmd1m+u2TC?=
 =?us-ascii?Q?zVrDGMm9/cOKKe2GMHb/7o4ZglwC2fx+wN0DdnBIP8jd1TZU9113eNzPad1a?=
 =?us-ascii?Q?ReN3rimrYUUy+V2LYqeIbWjIJpCmpHXIRGRF3sQdCx2/BoijfAWwWw0qvz7E?=
 =?us-ascii?Q?XEyrT76pW1zyBPx5igoCFZW0vIa2AYnzD1cm0O4jdwnv+v3QD+ED8ouAdAUK?=
 =?us-ascii?Q?euQ4Dlb7pg2eNPZMyX8hSWz8H7FoOJYbZvaZDrZp1DcHbuXtysU22NH7Xaox?=
 =?us-ascii?Q?obhzbek9jM7WtTq4/0PdRqJMl3oi/uNjHwmNfCby1CCF5nHVFXNRTnWYlk3f?=
 =?us-ascii?Q?BE7Z4fc9PuHInXUmMDM9nXEGEZ37GTY386Md7prCJAETnEpj/d6WErgEhBJn?=
 =?us-ascii?Q?A2Q5GpV7cGLLKJBKHn9FQWne+zRtbf3Nr/4a+D6RBh/NsCyeZh5X07Z4pmuO?=
 =?us-ascii?Q?/3mQwIxvorcBewDDAjYwC1rQl9IsJJ4KRNA+4iIdcVVgQLzWkZX/GPrLf7KL?=
 =?us-ascii?Q?3s95HDpKdvSG3fTUouXe58iYgTzFgEnYxpZi?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:09.1232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb77ad9-1ffd-4810-43ed-08dddea3046b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2048

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


