Received: from CH4PR04CU002.outbound.protection.outlook.com (CH4PR04CU002.outbound.protection.outlook.com [40.107.201.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6216.1795472854561215465
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Nov 2026 14:27:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=JsWusugH;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.201.0, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSRAoJBF7vdUT+5WDXyExstjOjpoY1jQppwV6nirOT2dMaKoAubzScBApRVBNqE0cJMsZ436CW+suh1JQCWdGHYrwuhY5eSPzLDNGyijPQiePl+tcOCN0OK6+J+g9a8vK4rGWGKIibfdCxw0Q2Y1mmlbIzxD0yZiQnyRioYz2wN7qBVq66O5ZqeF1C4expqPrQiGXUTbZTRfZLtrKOCJIA8Gz8i8kbqnUugyBCi///wibTgZITd9BqSpZfrlw1AsruUJ4LNLxHfN1wGJ0tpb3awwakCDgW/TxFM1XUROY6ynB1gN+wKC0NAjbjW7N36csgGiJFgV6Vt1n4/kWd8aWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AG8VQzdmEWPTnPuGewTAo0dbgGkpUEqrMowi7aipxs=;
 b=lPfzsmbxXjcoXvfaLnSSGF8E0nsh5Zhix9QobX2lpccDaqKbNlrTwXFu/JQuY9JBFC+cPirFg14X+jvtC0CWjMl2iZ5n00AIuHZgs8SFF0NbwbF1O7xPd6BjOE0OBw9lgN4tbHJXB0BYcdXW3wCQ7vvfF4skEy0Rs6m20AZdWOqic+LuC+oo68Ye8Az19LOGDGAJ0RUE2+VEgA8QbiQMrMiw57+VGn9+D52vMV8kQOCJ0MMjh1l1S/Pii/NzQk8PMZhU/0JcWV2+TbdoZWI4nAgLl3yLqLR7klPdPAvaRIsiArcSyUHDgszvJ5nmYFeb7YGPmAZtGd25epHW9YrxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AG8VQzdmEWPTnPuGewTAo0dbgGkpUEqrMowi7aipxs=;
 b=JsWusugHVTYwiwzItFn7uPVtCl3avxf7w7YyuU/l7DjkygzhWRICCPuy/2QUOG5OyixJBdlovjOfkL2Sij6nTT558AhF582Q4vsYmXiUWIaS5cCz/4YMke3HHL9x2HT8FrjvBj5JqEULV8Vccqx0m356/Z9zX8S8dpZ/iTXwFoM=
Received: from BN0PR10CA0025.namprd10.prod.outlook.com (2603:10b6:408:143::22)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 22:27:30 +0000
Received: from BN3PEPF00022BD5.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::61) by BN0PR10CA0025.outlook.office365.com
 (2603:10b6:408:143::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 22:27:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BD5.mail.protection.outlook.com (10.167.248.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 22:27:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 16:27:29 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 23 Nov 2026 16:27:29 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH 0/2] Implement async i/o and fast operations
Date: Mon, 23 Nov 2026 15:27:26 -0700
Message-ID: <20261123222728.2343685-1-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD5:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0ba3d7-7079-4732-2de6-08df49b0f5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|36860700016|30052699003|82310400026|1800799024|376014|261026121527099003|261102123227099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|11063799006|56012099006|10067099003|261009223027099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: gjwbl4VoAEmnO8RzwjfA2Uisxmwj6x/gdzo9qhbfHp1LKmpJgNENMbVSOZUA61USN9ib2rB9n/GJHdqhG6IMPA7TzlyPzI4zx66FYzg47fWwRN47Yymrs0bvzpkJm2HeVCWZzgKwhM7RTKPCn+XqjbzgvrLeXugxJiI25UCwqKIfWuhBXUEoDDS3uJ1IzLsS4/z1gxAFEQrJoMnhWQ577WyzDiH5SSktSwry3XCdH9Sr8TiOVNw66Z5v/3GkoEArykHRrXFSKpfwDWaoJZUWvVGPZ61mEeSbAJgZRzPLyjujexx8MWZzV74dFJxJCWC5rpzPwNjybOwzb9kpJoHMasyLkz9GdM1mTIhKiN2pswpzSZGuAT2LFeBswbMLFm9bgPhsT2PH9o0wJ2Si9iuPMMrLv9b4sbzcgpwQcBRYlUzIU33wzuHrc1+yPREOARXEGBvvzpQMHmxliH84pzUcgMb2ior1mMFWPfyPOI8j8W5vBuwhBNXtsUwIH2McdRKG8HFmuZNo+CGtVfbdU8hLzYlrLkT44UHIuNlMpRohSV3CRVrMBgAJLpY4CZa+/BgptFnNSngBciLoX44qmIhKwPi9YSPUelfBEve4aN444q55ulNA7aMtqitVkxHqGX6HWFlIYEycqOG4H/vxHI29o6S0mJjYbleoEfd+C+hmagqQ/BPNUEA1KBmfp2zeyYFK/GM9dAPFBzWPFt+QXk3Upg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(30052699003)(82310400026)(1800799024)(376014)(261026121527099003)(261102123227099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SJk/YAkQhvuSPVTLbHTKMSw5PRbPCIRPbnLqUrIZKKK8fWoD//6/Nwy89wpkaaIlTc5BaGulFWlPOh4/8hdtyyMynVLy2ZuieYUNj6wntzn8kiSKnq5l1aP0oFFDA/KBTvlikfedQJ2ay0ll+V+UovzXdvAQeJlqfocGYZCXTsiO3upUZRsiPwVXY/3Hr935i5xZJswGRip47A+rL5Abd3HH8NwY9WoQ4X12XFh6Htrk4/2aW8zAXGH39OzV51quHxmsTiCYt98ojJtwlbWK87VdOTbMsyUEvlh3r4Ynudcex6kz0Bu/a96jfy61mIi7rzA0WWZMjbO38nhgLs+4xCiAhwczuzi6ly9sZ877hSmwzMRj4/DCeeGrMiypy/K5N3s+tOJdMPAxCB0xQ7qf6phLnX1Oh0WrJ/RBF4HKceL9f+KNbiWkJDlgo3k98z8c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:27:29.8239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0ba3d7-7079-4732-2de6-08df49b0f5e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Nov 2026 22:27:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5493
Content-Type: text/plain; charset="utf-8"

These two were previously sent as an RFC.  A minor issue was discovered
in the previous implementation.  One a case insensitive filesystem it
had both _Exit.c and _exit.c which caused a conflict and problems.  The
implementation was updated to avoid this problem.

Yocto Project (wrynose) was used for testing, along with my layer
configuration.  For a build that had 32447 tasks, I prepopulated an
sstate-cache, then removed the rootfs and package related cache objects.

The build difference was 45 seconds, 17:30 down to 16:45.  I believe most
of the time was rootfs construction.  Offline testing showed a measurable
improvement when running some 40,000+ operations.  (This is on a 64 thread
Epyc w/ plenty of ram, so I expect a larger difference on slower hardware.)

I'm running additional performance benchmarks with buildstats, but this
is enough to send to give others a chance to comment.  I'll reply with
the buildstats info once I have it.

Mark Hatle (2):
  Send client requests over one shared datagram socket
  Replace FASTOP with requests that don't wait for a reply

 README.security                |   4 +-
 doc/overview                   |   6 +-
 doc/program_flow               |  11 ++
 doc/pseudo_ipc                 |  73 +++++++++--
 enums/msg_type.in              |   2 +-
 enums/op.in                    |  50 +++----
 ports/common/guts/_exit.c      |  16 +++
 ports/common/guts/execv.c      |   4 +
 ports/common/guts/execve.c     |   4 +
 ports/common/guts/execveat.c   |   4 +
 ports/common/guts/execvp.c     |   4 +
 ports/common/guts/execvpe.c    |   4 +
 ports/common/guts/fexecve.c    |   4 +
 ports/common/pseudo_wrappers.c |  24 ++++
 ports/common/wrapfuncs.in      |   1 +
 pseudo.1                       |  23 +++-
 pseudo.c                       |   2 +-
 pseudo.h                       |   1 +
 pseudo_client.c                | 230 ++++++++++++++++++++++++++-------
 pseudo_client.h                |   2 +
 pseudo_ipc.c                   |  42 ++++++
 pseudo_ipc.h                   |   8 ++
 pseudo_server.c                | 186 ++++++++++++++++++++++----
 pseudo_util.c                  |   1 +
 pseudo_wrappers.c              |  43 ++++++
 test/test-async-abort.c        |  48 +++++++
 test/test-async-abort.sh       |  40 ++++++
 test/test-async-order.c        | 188 +++++++++++++++++++++++++++
 test/test-async-order.sh       |  23 ++++
 29 files changed, 931 insertions(+), 117 deletions(-)
 create mode 100644 ports/common/guts/_exit.c
 create mode 100644 test/test-async-abort.c
 create mode 100755 test/test-async-abort.sh
 create mode 100644 test/test-async-order.c
 create mode 100755 test/test-async-order.sh

--=20
2.34.1

