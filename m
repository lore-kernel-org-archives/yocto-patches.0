Received: from SN4PR0501CU005.outbound.protection.outlook.com (SN4PR0501CU005.outbound.protection.outlook.com [40.93.194.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.407.1794855371283239137
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 10:56:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=WjtHEuso;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.194.2, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO3yGMIRj00rUVhENRRQripd29bIqrSEXzTZJ5icf3OVsYbyDGXgiuhgIQhCC1MO9Jyb8g4rig6yPZ+MObSPJPTOhEIUhLYPUK+1LA2yUor8SyzAufs7nOBqsYSghbxmn3R8uJHDhNV90GYgXEQxBe0aPQF0pBQo+PyegSAnInKu9IgkBj/wZcOqutxCKmrocOxhtKUPtnjxm32YGuT/gERbGQe7pFXdIWwlu3YbpY0R6yh4u5M9eFBkNaF+8aR3DhTQJWIn6IrvOtkuyz9Y+x1iT7NpPypOb9jxyAcGBSyaXs1rQRypHB9R+UHGEfAenKd7Ve3ce8EoSVQbGerUxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+rAtBk9mrJhBZt0sIQhkKW/hF4FBwgzTfR1Ja0CGOM=;
 b=t9pMlmNlf7LfOPfHqh+Sgqcd4PqcAWt0dTuoXG4FA9047Vck+d+VRNFaimyN7pzK3m0eX/Lp6cWBVdRxymVxNt/kIzbdE5kjd4mpMaoJbwPaiDujJu/8jdcESCCy8wMxFPK/VaufE3IOezjGixxgL2kLRs+Cstn9P3LXmIAX1EvtLUBDpwXaSYd1tk4FYmpX7B5XkflNwH/xIgwZvnKHvpMrMPZ5eh73VU51VzToCu19JjUFVwR0hNJithZSvx/mWWgKGxuwA7mC+d2bNyLbcJGscU35B76QGZM+ZBwToBiawGCPObHOY22h1r3bPnLlFeAGo7n2qtZjtF5Pg+60ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+rAtBk9mrJhBZt0sIQhkKW/hF4FBwgzTfR1Ja0CGOM=;
 b=WjtHEusoSTWesFJXNKjcaTOtKgdyHoxzUVgXrQSRUfQjDwakX50RaHksjSDaIhZnC+O8Hxux3e9wxXKL1NWj95eYRAoqp8X5ymc09uz66FsxbkSjxwwn5NFlaRz/SMh5TbwCmVT3d2RlEH7CEIIyS+CAP44UusSYlM7nTVM+r2Q=
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:54:02 +0000
Received: from BL6PEPF0006C3DD.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::46) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Mon, 16
 Nov 2026 18:54:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0006C3DD.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 16 Nov 2026 18:54:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 12:54:01 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 12:54:01 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 12:54:01 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH 3/3] README.security: Describe io_uring refusal and the host fallback
Date: Mon, 16 Nov 2026 11:54:00 -0700
Message-ID: <20261116185400.2205466-4-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116185400.2205466-1-mark.hatle@amd.com>
References: <20261116185400.2205466-1-mark.hatle@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DD:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d5ab34-e3fd-4ca1-b4ea-08df4412fb08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|6133799003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info: UE9ygYKBkoQAUYQaD2BvvTDGeVWKs86Q1xyF+ri9AUsQQfGKuvvLVIObGWXPdLPYgwXy0X+s43wltUckir2tCKcY2awo57Gs1HhZii2/m5zL7L/7dbH6N2D0kkEEG2anq/qbhMxocDkw/eZhe300RbB3r5qe9mAVvBZFF/PYDzEoSRVql+RK/NvO/AWJEoGTMAeyh1gF7kIUTwTlunE4vhea+6DJCJz1dkBLQVx2q8KkevVAMtW+UPAD0+CZhlLwVYWLMNRkuruwmDeH7E3cXWdjc8l+4HWSfw3KAIbFXVrNMy3XGsYDPyNOoDeZgQDvxVkmIQocIn6XXsadiQ0MtTeh7ydiVXKzDcDSG7Lsbd7bAR4K1Wv4KNo5b/ayHtifMe6mz4IXyDWGA1M83EMbQlYdBGWxYaE0MTR107L1L3wVVou1bYHVL41wslOnF9HqQEO1zW37h46f5N1bnpQCXUHbwbsl/LyB5rKW7B7Zro4nhs5f6b12n770eyW+qQzejXM0tay71x/yEPubJnPkgGk11CLivYKQVBfcCwiAdZxFiShvTFAuPG5DqJjzXW9IK8c4D0tMs1uVHNbVoU3JLn+9ak8VBet7U0eDDSWW/z1Mn0BxQrK4wRfb0tH90uVu0yUZUs83pgCji46YkIuh9zKbTBTfAnST4C/t0PQpBx0xHS/0Nw1qWJmU/LcKFB+yW6IZX3jhj6UUg5meQ7QseA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003)(261022115727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vfMjG+Y+e8TJNQralK47UKJmtXh1fh9lT6dlfb1v5jr2Db+ksE6vFUtCQu+K7pKR6a0vVfVHegbH4PCCTto4cVpHss5ZzHyhBJCjJznyzCUwdusNZ21IoXLHCNhCoXN0cakNojPvZMX0CgWl/99aiZWveIaBQIMxIAbkhDNTam8fHGHWUCCVN2FoIKXdnedmYTglqFRxkaxhfRfzTgZEnaCi3MvCPsAl4MBiypvgoIhli3o1gfpCOQyLaHHW3t6MZZkVmyyDWsIMPs//Qvixbq0BQsbIu2p3Cluf+5EpQZpWv3StgAoeOL/UNtI7vhLxeFGxvkMcwJc5KUv9AwktTISNoO6CO79lcoDVGCmtbxu/YezG6cl0tF5MlR8ls7AlI0XN0Ja5kLCLQ5QFvdD+Pjhct6dDt7WQSptOAwDtmxSX9lQf2PkJQA35wyFNOnaL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:54:02.1217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d5ab34-e3fd-4ca1-b4ea-08df4412fb08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 18:56:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5415
Content-Type: text/plain; charset="utf-8"

Explain that pseudo refuses io_uring because it can't see the file
operations done through it, and that its seccomp filter needs
no_new_privs.  Where that isn't available, or io_uring should be ruled
out for every process on the build host, the kernel.io_uring_disabled
sysctl can disable it.

[YOCTO #15244]

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 README.security | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/README.security b/README.security
index 7249b5d..496524f 100644
--- a/README.security
+++ b/README.security
@@ -38,6 +38,20 @@ started pseudo.  This includes:
 A program running under pseudo can therefore always step outside of it.
 pseudo cannot be used to restrict what a program does.
=20
+Files created or changed through io_uring are not seen by pseudo, so
+pseudo refuses io_uring: calls made through syscall() always fail with
+ENOSYS, and by default (PSEUDO_IO_URING_SECCOMP, see pseudo.1) a seccomp
+filter also refuses calls made directly, such as liburing's.  The filter
+can only be installed where no_new_privs is already set.  Where it is
+not, or to rule io_uring out for every process on the build host,
+including those pseudo is not loaded into, disable io_uring in the
+kernel instead:
+on Linux 6.6 and later, and some distribution kernels, the sysctl
+kernel.io_uring_disabled=3D2 makes io_uring_setup() fail with EPERM for
+everyone, and kernel.io_uring_disabled=3D1 limits it to CAP_SYS_ADMIN and
+members of kernel.io_uring_group.  The default seccomp profiles of
+container runtimes such as Docker also refuse io_uring.
+
=20
 2. "ROOT" EXISTS ONLY IN THE DATABASE
=20
@@ -167,3 +181,5 @@ RECOMMENDATIONS:
   ownership and mode.
 * Verify the ownership, permissions, labels and capabilities of
   security relevant files in the final image.
+* Where pseudo cannot install its io_uring filter, disable io_uring on
+  the build host with the kernel.io_uring_disabled sysctl.
--=20
2.34.1

