Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.919.1794856612132253582
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 11:16:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=g6TF2gus;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.53.67, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OabWdeqM2FErnn4WlfMNhdui+BTTqZxvDAQoT1I9PY8ji67/hF7PoW+YRtULEhbGFD/5qsa1pfJ4nyDQRplncD14knR3L7N0ElPIQDZugJf5RbQvLDoQn0DqNrEncJ6AJCS3DiEena7tZReugq3xFIcPGPTN+hdQJCijO+5vypMsaykj/9Z5l1kRJtOYchH0dp0UzXSxyGZoVQCgK8JXBTT9anIAR//DmADMMnPoB49KqoaWJxOYQbiFRAjHzRho2XvKYDcrNbm5nAz707qMu6SQsDPfkMWb1GA/fDnv7JkG0LEfL/Ix5vBHag4ecOmnoFf/pG5UJNuAdOegCN6ozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqWLNHXPHjQw65bk2BHFvLgQOPdihJyIBo1MpBhwBQc=;
 b=Qkt+5vjXOlu+sGrJEagMJrwmXY/dGMTr+bBlGWHnlNsfqbvt6L0XWBwe4qGAIwfj169KztN2EwAKx+8gqMmX3xRC82MJn94XH4FAQnr6Ip9sJ6FcakHT5ngZQOKFwYmH2yO+vT1RZ79XycTTakHdSsiupE/LvOi0NKMWro1fLiYt/aKe+nW1GzjCuMjZEEdg6ZhkCE5iRKJjcfnlR4iQiI7bBI08B46ZQz7fzYQVatkqh7XASM7gOo18E5C1cTuWo68T4BmUM7cn4Wut8QAklvtnEdkMOSeVlSd7/skxabcJ0mXndwgeXlqR5/P9vP6arL2r5kr9TqfTbqrmyrNqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqWLNHXPHjQw65bk2BHFvLgQOPdihJyIBo1MpBhwBQc=;
 b=g6TF2gus1RuQehs7gshkfc8CLqkg8iDmq++fWebArmcGyZN7/94RFhVZehFVAp3RjfIx5mGtgGjKS2qqBRD57wF4hf2p1Yr3hd4sfHC6iDZxR0jm2Lxf9AmXb3tNWwqAf6jxrq73oSlnFSRQs1WsSYC53C75SRRum89iiIKxwuk=
Received: from SJ0PR13CA0135.namprd13.prod.outlook.com (2603:10b6:a03:2c6::20)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:02:45 +0000
Received: from CO1PEPF00018863.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::4c) by SJ0PR13CA0135.outlook.office365.com
 (2603:10b6:a03:2c6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Mon, 16
 Nov 2026 19:02:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00018863.mail.protection.outlook.com (10.167.249.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 16 Nov 2026 19:02:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:02:44 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 13:02:44 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 16 Nov 2026 13:02:44 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH 0/2] Attempt to prevent selinux related failures
Date: Mon, 16 Nov 2026 12:02:42 -0700
Message-ID: <20261116190244.2205781-1-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00018863:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: c65232a6-f36a-4f19-f13f-08df441432be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|261009223027099003|261021123027099003|261022075727099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7WaEVU+wug4OEmAjqDUkMMDChwzdHsMSmO6GUrZGoKsN11LHVLDPnLkyEFPjjKnQ2XSZbehn6N+xzzGog0az4M8GFJI+hmZDVAL1l1/rBk4+ys+YPmLA7quh48Dq+wHLEkZO8xLNRzbK+K5lAVmxHWZ01RsQ6Hb/vmKe6GF6g3g+fdDLhQuAiE/N16kq91Rd2i1mKmkkByjWnqDSl757DhMLJbI2U++5W2yVPRm3YSz50lHQCciL3wf4oKOTr03va77PxYPPWls7cYByezcdsPj90vXppEOeqB70uiKB8Jz4Lk7H25KamSXxQ22DFZOlABpPlXg0dCilPly3nPsXHqOyT00I0V6gi8yAVpQ9SUyDyb9rMpjdB1J1Hnd/jl28Tzl3yStMyKHDNuwtlQgZaCzQzjj2K5g/z6bxSivLH4AUuppC20R3eh96+NZchypdHPC77hal2QDjgF1XJwbfhBkE1Xb4+vSXgGRpnbHcxOqmqUWDnMCbyTKPXUtw3fzHqt6S+dt9KN6l1wLo/7y9Zn1CksEcKHJXf+jJuyK4Y/1Y/+yzq0yPMj5LuZCMKmeiv3hDSWeSB/7ZweY6WXcWAH0xdcDasXYL0JIokcBxVoFBakF19g3XGCrwCa10Omv1Xdq87WDQLhzAO/xQgI2XUG0r4avW2NzATdXym7TwYo7MDBnqc0js+AM54yBn2LfcZocTnpRCgmYfyO5uBJzs2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QCvoZA6Dd30SuZQZqwPkGo6OYLf0j6HIEn2c1+1fRZAoeH1t5dZItCmtCkOSp68gVYp2S8fDWkjh8pY45EbwO0/yyrvVlbWhwDSGxTj17JhRAycCKuqQCcCxujOchtPhOXB19zyyt/1jMg6BRKnnKSjHlp2ru5fNW11Wlu/rYI6zGy+SCmTOHmxc+cIW6DahWXN1eb+cCRZ6YrLddNwHFJBIuSfsFas0RW8Dpsmm/9vIxX/rsIyB7/qC/8pQFS8L4SX87dOE3Idgl8s3NERqa3P7mH33XcU/uHC7oDvwjOdUKw7kNgcMVEXpfE+0+PMLUAwDjH3QJKlGdZ3A/ZPxWa9qSvzH8Msda5Rvt5iXwh/MMEkhc3s1smVPSZAphX7WhYunVHcJYvVXkmKRP4jcYqR1ncnaTuweVH+5F9kR1iUIVypRt8ZqulneWM99/Za+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:02:45.0274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65232a6-f36a-4f19-f13f-08df441432be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00018863.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 19:16:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5418
Content-Type: text/plain; charset="utf-8"

[YOCTO #6580]

This is the oldest open pseudo related bug in the bugzilla.  The change
adds some code that will tell users that SELinux is always in a
non-enforcing mode.  This should cause various tools to avoid doing
stupid things, even if the user is in a configuration that otherwise
works.

Additionally, a check was added that tries to identify if we are in a
confined environment, and logs this with a warning.  The idea is if
someone is trying to debug what is going wrong, they'll at least get
information that the environment is confined, and it might not be a
pseudo bug.

Mark Hatle (2):
  ports/linux: Report SELinux as disabled under pseudo
  pseudo_server: Log when running in a confined SELinux domain

 .gitignore                                |  1 +
 Makefile.in                               | 10 +++-
 README.security                           | 20 ++++++++
 ports/linux/guts/is_selinux_enabled.c     | 24 +++++++++
 ports/linux/guts/is_selinux_mls_enabled.c | 16 ++++++
 ports/linux/pseudo_wrappers.c             | 23 +++++++++
 ports/linux/wrapfuncs.in                  |  2 +
 pseudo_server.c                           | 60 +++++++++++++++++++++++
 test/fake-selinux.c                       | 15 ++++++
 test/test-selinux-disabled.c              | 49 ++++++++++++++++++
 test/test-selinux-disabled.sh             | 20 ++++++++
 11 files changed, 239 insertions(+), 1 deletion(-)
 create mode 100644 ports/linux/guts/is_selinux_enabled.c
 create mode 100644 ports/linux/guts/is_selinux_mls_enabled.c
 create mode 100644 test/fake-selinux.c
 create mode 100644 test/test-selinux-disabled.c
 create mode 100755 test/test-selinux-disabled.sh

--=20
2.34.1

