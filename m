Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B658ACA0EDE
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:46:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (NAM02-BN1-obe.outbound.protection.outlook.com [40.107.212.54])
 by mx.groups.io with SMTP id smtpd.web10.57318.1754941614710238572
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=ePAyf3UA;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.212.54, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waiB2mCLR+KIXuqiiWszDKHEzmFPHKkb/bRKx8dQZMjO1Ips/R0NVlR2+CO5Bjm6nHegIwKGqeG08gRZCoz548yvexeNdwhSvTmOdPEG3LmXRgqooHniaVwu6KLp7qqdMR/Tsunzx8TBbDqiCs86ljNMbZXJ0twsCMHn3Z1C4bOoNuxk6oywPy63rz8q1gtp+SZ2DY7U1FbPt7nFsW3xmC2pztqDpqWgAyzWoVkGfJnhP3YRThbqNnfViOOoCRnl92JPhiG7e+jd0bGrIT2nQb1OxOmHCLiPgl1eVfavjtq1QwSorQGrm/IeTOM+15bI3i403D4sQCKeh/SsBgPz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=RK23SA24gwJJgkX/ZfFMX6b0ludNfswpFZBan3qv5D1qzFjHIlA0SJCWRXPpOF9J8pViWVKGai75cRdY8vOh+GCo6P6kbyRvU3Ah9U6W7vy4V/wVxhkNr7u3YqvoDJnQdvNMiOadfNSCk0a8GYzEIiI+j4w8I9cG4P3IjOe1wcTEqUiH4KxRZoTZHFf4wxpF63Crk4MBOR6V2Xoy//A1Ao0iP3dOh/qOd7nyNOMuQcV0LrszHdC+cRtO6xGHy6OZfR/gKW0+goMKXKragTRu6rblsiN2oYbyokiJ+pS0U72eEMS1qnfrvBwZ54UywSLPxgge5B1CdXZxZVMz6d3aHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=ePAyf3UAvoonoaW0eqg6fa2v1P8l5Cgx8P59D+cdbNjHVFxSds9HXJjl7Gsfnjld6Jh1O1WsqYEMmhC8OIpKMlqO+q00XoT+2WvMSod/37loPAh5lmoZpre+2y3rjRsTaSkXw9qlP70GoUXx4IQNhRuuosf47tETOKonf7LHuJk=
Received: from CH2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:610:53::32)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 19:46:50 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::a5) by CH2PR17CA0022.outlook.office365.com
 (2603:10b6:610:53::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 19:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:49 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:48 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 6/13] classes: Move classes to match bbclass scope functionality
Date: Mon, 11 Aug 2025 13:46:39 -0600
Message-ID: <20250811194646.3408854-7-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: a4831d06-de55-46c2-b45d-08ddd90fd09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zHeGlC3xnimEXQ4GYP7aJ1FhlJUNRvRtdX7nlFk1NwBNLH3mvAJlEtMlw03N?=
 =?us-ascii?Q?n4FPxE5aZiajz+3N4z3EwtMe1iTkdpyLhDElf0qD4bPmjkIC+zIvmH/UGTXX?=
 =?us-ascii?Q?pvAb79qrIkHy2yiEzdvjv5Xsky/M4Gn5b7aIlFxEk5PJKhLWMOswfT0/xWWL?=
 =?us-ascii?Q?pClBBaISkwnpch6V38MjcwrRXClnRuk+y4y6rzi/qgtI8if6l7kBcS36fbeS?=
 =?us-ascii?Q?aPs1Gisriji4ReQA+GctziikEd0mes78rtp3LyzF4WUSZ4k+BL4ge6duZ1yW?=
 =?us-ascii?Q?NeFYjF7KUw9KkNfB0nSW8p3xuoMlEXKk42uHxH1jSjfwxYWVPPQEbNTrVKFt?=
 =?us-ascii?Q?Gmgc6+IBP4DtaCk5Qt3mKapbVCFraxxGPYLvAMb3C4cgzqL5xbKUGmo3KRaV?=
 =?us-ascii?Q?TzlP8bkLVT+XHQRmMGigSMJPnIMpbVMvshBXezGqqUiSjRVpilN7P/s3PPXM?=
 =?us-ascii?Q?qHjdfUITvHNTl7lXzUoWsih7pjg04vOR7smbuAKRsY7T75XzO2ivlyFqCamu?=
 =?us-ascii?Q?spSakqRMB3HRsiQUIuFgIOS/05p/SwoG/3sIjx294w4+EJq5EsfZLOO5cSoy?=
 =?us-ascii?Q?TJogXOnnzA/MwWKA2OtTvxkPoS7ZOa0nUIk24WInEC6n/NWFsIFcb2ktMknk?=
 =?us-ascii?Q?Kg+iMmioaSuI4rwic91mwE6aovHecc/e1wO/RuxENvF29//EHWGejUq/svn3?=
 =?us-ascii?Q?AYwyRPIzL4evN7CM+yJBzr9laVDQ1F03jcSlKumRnOW9wPz8RUcR52SmFz9O?=
 =?us-ascii?Q?g0Hhmd8MVJQXkVmf2lk/rsIThKYd5sXN75hPMiPOqpjsDfyfkcGvUKMzGLgT?=
 =?us-ascii?Q?Hm28ItjMzLPUY4YmILwLRzIPYjcbA5rFht3fOVt6lQNoWCXUS2hdgdevxNdC?=
 =?us-ascii?Q?J9XlUxYdHhc1XNnoKsT3fnUOiwh1vpLXjck395Fibgm+PV/06g4mLjlyO3tg?=
 =?us-ascii?Q?Dw2EQ/868yrsKyrLU5q9KRfkBGX9knYTmezYGVhnLld3VEMycPEk4sFXdx4H?=
 =?us-ascii?Q?FuQWj1VBYtWUiK1ykKAMB6/lNnC8QSpqgh58t6G7MsqOrk5z+W/Yd+k+cecz?=
 =?us-ascii?Q?WQ3u5b0Nc3Q3Ri8b54N6s+Xh4SCZOn2GopnX3GQ4Gu3+9trSILEbZwU3vg7o?=
 =?us-ascii?Q?qv5IbrY5uhSSUjYiGXQTxrwyFVOi7t0sn5eNRiEcAtWKByTOBQfZmaORG7GJ?=
 =?us-ascii?Q?kgrnlPcutpbbNRWCyViFkfo77cegZKsE2Ljw+6U9dSXVDnyLTd+kdReLYjcS?=
 =?us-ascii?Q?hh68afpyz/stxPPfIHM2RBArT7DoZ+waqBlCzpb3KBi1D9/4BHzjSD5Kzh3i?=
 =?us-ascii?Q?Rfj0l6omPIE+z0NkJNFvPOsd/NpKO1avbrjrWccd/rzmNpGpFIl3wvPCyCSi?=
 =?us-ascii?Q?PtXE9sF46O+NAsLcxwUIV9dRfAdYHbtmapj7y3JPp4fDaUkO05Hwi/tfjqPW?=
 =?us-ascii?Q?twKV9P9Iz1HRiOd8S6cQL/9BAyDFD2B9wjBlXStu8Hh8ssOhzsMbO1bzA/1f?=
 =?us-ascii?Q?7B+oWtl5RfgBVygcioXAITuSi+rszOBPQB5A?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:50.3528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4831d06-de55-46c2-b45d-08ddd90fd09b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1950

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


