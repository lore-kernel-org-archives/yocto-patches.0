Received: from BN8PR05CU002.outbound.protection.outlook.com (BN8PR05CU002.outbound.protection.outlook.com [52.101.57.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3621.1794509479708519539
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 10:51:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=uMxlX4kr;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.57.10, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8P3uZHRLOOMj5YGAXuYbhShRcRNd8J0ExjFySY5BG3HArgOUnsxh/JN6z9A1HWvrqBd8N2ma/8iykHH3aJJIpYhmEFfDlSukmgkgMxmcYmkLYAAMJcpv/6iPVOk3k0aW3R5xPB2t3jBPAHBDMVMTErYiEe1CxjnrmfjjqFyxkNo6AxGaqr51Tx0Bxa8ecLf6slHxDA8tcoWfdFg8Vi1UD/btvW7pAedBXaquSdGtL7dCOA9zgdB7nE6P2nN2MgrIvTfOnvWXg0TA9UQeGEh4P20PhBlRJ/s+I64oX0+s8HQXyW8HyUVf74Txj1ACNsnuVjNT9qXcTsjKIEvkCp8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vshb871Odv/K43r5Ie9g7Xas4pB5yhd/7YcgIz4QdSI=;
 b=iKHgA9I15+zSmaWNKvghboJkxXpD5lFCLqiiyZ5dOlFGFrCm0Xna7Xd3le/QVU8tK1IgIB/rlrzSORZ0Pig2tmLLzOjrjE4lsk0/j2PxQbqO8hyQHqcLHA00s0Q7IPOCzF/1owZBo1C3MkU0+VAG7NLzvLHMXx+egW6R3pppG62m1LlUy3fowP4QoavKaf0aE9x5Y+QbbANJb8eWmLO4auloIdxOkRsOWqWxWsUzoarcb3Mtncoyx70tjiZgK1LdtmVwfdnfslIIDuymFQchXNNtWoR1yXBqnRmjgfc8WLqGwLHX/e2JIkPvv+KBmX/fl/nr17l8YcJZwYFdgMl/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vshb871Odv/K43r5Ie9g7Xas4pB5yhd/7YcgIz4QdSI=;
 b=uMxlX4krYHJfa2F3Skb948LyWMhj4ABFooJ1UkJgIJssdb7qIoJENRROfdw6rFfPq1cn3+TKgdsURFoEk7LbpvZ4Ae1/0MoIwJkpf1ReNzE3hIKH3EEKIhYYghgVtOvI2b1UWelu5+U+mmxg8Gz3+5jgmAkjEMYR9MiP1N5EYiA=
Received: from BL1P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::16)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 18:48:46 +0000
Received: from CY5PEPF00000E78.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::97) by BL1P221CA0022.outlook.office365.com
 (2603:10b6:208:2c5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 18:48:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY5PEPF00000E78.mail.protection.outlook.com (10.167.247.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 18:47:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:10 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:10 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:10 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH RFC 0/2] Implement new openat2 flags
Date: Thu, 12 Nov 2026 11:47:08 -0700
Message-ID: <20261112184710.549482-1-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E78:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 83999ada-22c1-4e91-4176-08df40ed6b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|10067099003|11063799006|261026121527099003|56012099006|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: qnfgAaX764u7DsvRruo4WL4c6LlRGfKBqrDEFwnRASCZuwO2TBkO0veaZwWZoH2QNVKPr6Q4dq6a6ufHJjw3K5PYEjICc80suTJY/2BiunSjd+vowyIPHknNp7S/VHCNET0UiHTU+Xx52mMohNeqIq+m3kg2a360HQxt+LvKwP/3DeY+1Jqd6QseQZ0qjX/k5xNeKcSQieqdrzLDBEpDH1KVUVmULejQPRXsD09OZ8bLTeotFgTbypePGnUUwlh8N/MV6WOwHDLcqoHjqVVRZu0g/Hvv0eppeN5ehDVQFireIXHAFCzPP3aiDsSI/kUL48ZSZiPjIYFeq8cs7g/YVx/grk3peVjOXEp1RRVSPw14NJFCmveCzsO4JxrdkUQ8keut1YM0v4WcgcAzegf5GHNHYvZzBQOQlitYQz+S6CA1W2wB6oclSElMUb7ef0yxFNn844VMkk/H+pwJGwTIv2+QVhf427+j0qe9zj4kq3dbXffQsjTh9FxbiDAYH8UywVc7Ts40TaylchkeznT3RtVRlPfUyeVrrPdyXDzuW5OQ28lBeX99EgVVNJeLfZwJZtWRaM7ujmspR0xS9W6CqbSx/uieRSU/SgdmNU1xbtX1G9v9B49LbQ4lQvaBA9sw8QMyFHeJRYGKRQZMaVJ36kAemo1a1jYLohd8bsSu6LRMZM9iPXPS/ng7C4l884BQFZi27JWlkaIjnzvMo5yOEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(10067099003)(11063799006)(261026121527099003)(56012099006)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bBr5gxBH3upOdGmoBAELds3Zu8AUjQqIqfQ9cGNPGSw1CYYREScaLc306xwnw/YyNTEn/3JltH06WdPSPQYnhZk3wnCLoBqoUKNhNJ9zREPGfvzz4htB3D+kySweYjn4O3buZQOuFZhGKQIleXXWfDofkxrKGd5HhMn88ZHv06LHu0KYOfg3iTLIzHhZL9afeyYCeTvhk6WGHI6ZHBtHhPQqJXZbvbWSmZDAaFZlvghR35u3lfIq2l91ETp9upjCPixVM8XdPKZtSecPRlNys3fI9gKQZAFyVrfCXq5Gwn6Z/mIkKYOY3XLHLYP6bpKu9AEZGvI6Z0TYtjW62nQeDQCQ6eB+7Xsh5BviAnpd+v5maGocNMJzPy2Yes8gfxzJt8xSBhAbqBbQmsVXcx1meNLDW0Hhlu+vEf+ONserq29uEgySANquUV2v6rhBzSfp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 18:47:36.1254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83999ada-22c1-4e91-4176-08df40ed6b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 18:51:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5335
Content-Type: text/plain; charset="utf-8"

See [YOCTO #16327].  As reported the new Linux 7.2 includes both
O_EMPTYPATH and OPENAT2_REGULAR.

OPENAT2_REGULAR requires no changes, as the flag is passed to the
kernel and no local pseudo behavior changes are required.

O_EMPTYPATH requires minor changes, and also pointed out a behavior
inconsistency with the existing implementation where a blank dir
was expanded.

I do not have a Linux 7.2 or newer environment to test this on.  This
was implementated based on description, kernel source inspection and
man pages.

Sent as an RFC as I'm not able to directly run this on a newer kernel
and validate it is working.

Any review / test would be appreciated!

Mark Hatle (2):
  ports/linux: Pass an empty openat() path to the kernel
  openat2: Look at dirfd for an empty path

 makewrappers                       |  13 +++-
 ports/linux/guts/openat.c          |  21 ++++--
 ports/linux/openat2/guts/openat2.c |  24 +++++--
 ports/linux/wrapfuncs.in           |   8 +--
 test/test-openat-emptypath.c       | 105 +++++++++++++++++++++++++++++
 test/test-openat-emptypath.sh      |  12 ++++
 6 files changed, 166 insertions(+), 17 deletions(-)
 create mode 100644 test/test-openat-emptypath.c
 create mode 100755 test/test-openat-emptypath.sh

--=20
2.34.1

