Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A66FC9ECB
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:44:08 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com (DM5PR21CU001.outbound.protection.outlook.com [52.101.62.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3303.1772858638692003240
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:43:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=y+CwdGYl;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.62.68, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHS1fDnFWxg32TgtF/ogcoSOiToYFD9c1TcoAQdBCKRAJYHTvQq6FhP1uYsba6hID+lDalDh5IgD/HOX1/uo3Witeia+TfoC/utApzrLGtMF3PwY0lxeQpw4iMornyUkpV3x7D8aAlF0Tv3jMvW/KzIUegAMD3pUUqUu42I7EoIR4Hs9lovqheKM/eyS3n4yvIomIYQkoLelaJOvFKVHFILA5Kw8qQGh4xTxu/SYB2Dnm6rc+rR0Cp0irS9Gwn1y0MuXsQOtIA/nC0WQq5HJ1h3nsWhzfItqWJ5Fm2G2ddrDM6qt+Ob1+EwuJ3zTRader8Ri8Hbk12kBHGnuTMW+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8vl9Ql7zRD+6x3VJMKBQGzRQ87Cxl16TxiKELJtB20=;
 b=YP8KfxOVutyjhlahoRVbxoTZl0Jl2xs8ZY2Hou5lRo8aQa0OHbZ+TbALJBprSPJneiiEO/bvzCjmeEWRCYI690rrUwjeLnzArBx5fnZP7+pOsyik6/KtAE1K08IKFsRM1EWSan4iW+8PSSo3AFpPIBGSqSBsZpFyyBwolmiH/BHf/5dMT0/sEws60FHdwjEhcXkz5HDznBkKhZyjoaD5aJ2aCC5JAGX9YnlLcHB/0vqlfPBItbpJaPM83T6ceeXq/ONZ5ZMtbLyuCPjQQmGSAtKzf6aLuYL/m8lWBWuSA870G0lGzmFxaYgTQW148MgPtpcI/EabU7BPhvWmo4LXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8vl9Ql7zRD+6x3VJMKBQGzRQ87Cxl16TxiKELJtB20=;
 b=y+CwdGYlLJJifZNwdrdm8Z+OuQq2bF15Z9+FA0cVrfRQ0VrC4M5piu/9D26a6dXydnc//TlRtdp7/nAD6yNzMpBpuf0wpyBOK3ho5ukgOMj5TnZ6C/2olb6GYwVmT1JI8thDz6QAeWLD6OBnTJB6lqVhBzmf7ocD1BdvCipdduQ=
Received: from SA1PR02CA0005.namprd02.prod.outlook.com (2603:10b6:806:2cf::10)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sat, 7 Mar
 2026 04:43:54 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::3b) by SA1PR02CA0005.outlook.office365.com
 (2603:10b6:806:2cf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Sat,
 7 Mar 2026 04:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 04:43:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:53 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 22:43:53 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 0/9] Update to v4.3.0
Date: Fri, 6 Mar 2026 21:43:44 -0700
Message-ID: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f229ff-88fe-48f0-7c8f-08de7c0422f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	uwyTvY7HpxTqwohA/05Bdkd2eO8LS3umal+D7FAKHoGtoynsIcz+XmPK0sMFe1pDIB0OaaXB2uChC99aD2Gg9U8jhY38kE7vl1KiPMyHnZtTT5zcvGvOlXOefbAHNJIVd9LN1eaHXKT8I/Wpib5+jldmKvlILnikj9oL8ds8lc2k4oKlwGDxlz58nIKi+/iUyHPi7nK/3o3LSiECmOg3DIDj5UEDoUsvIohn2ea3pPYGk+OO5asBNZMTgsTG37QuiWo2rXCNZUVktBspjioqUojTPZDMkcj9bzeMhcjO98KNIwZf8VGNzNuB5XLhv+nb2VvP2HQDK5ftr/hcueOOVFVPq8nykTTLSFhfao3YkNSabl6c9pWGHFl3l2iN2KvwzGM5At4aZuETaCfomxM27idxwFfaq0R4eRj63iMlzdOdm/ggWV8buVzUwZZJOgUFNffOZ0CpYtsaBoPoMfCFMvLlXFUYsZFyLhBHLnRqtkzMB2HaTNgB4tKk/EK4CPlLDYknhKD0RXULAopc5qj4g0yq1cC3ito87ZZkb+UezV+vFjSUsVWHhMLcaMYrSl7VWJXYKUW02DDOXVd3ANHI+otWJGg5yK5JJ0+rhSFiXXT1a0/7IheVPWAttMj3iisAiytW1ITsKzLteWDocK9itRqRW+KsraeYaXmTrJdYLq352vR7k89MldIwx4agGqivw5IQHvRzt/MePU0gfMpffeQ/8z7H29vtXej1Bv/TTYHYCZvarJkhDMOfYMDVoueBbCtmdEzo8PVY3QJ9+sUQ4Q==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	exBO5sqtvuw62aIzyaNEzMOo9uuieb8DkO3y/Xf0Wmr7sYnz57RzZTWNRnrSzn3ogT/6XcyDwFalCl7UAD2p0vbEVlXKOGnjHHhOo1/Vanmp5HwPdY8Uwtc9GP5YqJa/autqWcc8LTMjYL+xoNpYEDuO6gR/teSEPUxRWV6wyaJjtMmjOX19qLklA1oG/7Cqfz4kFUFluie34oownxHdexQFlNIfm608n6w06An3ltk+rcHyrQegBNrdHVvWKPtYa2/0t2xliq2OqbCI3SDpHcxiDQskZIS5VT1/aFzz+KhDEyXAg69RHQvM/AjAuEdbXe0ampyw9Iw2UldS7i1autPlZ6x2/iznLge4CLVDdgXWMDKDWpEZ+m/XbpbeFJRSUKXoh1Xtdhj1cT/h9zBs2nlOxzsYOtqsckTtJauv8bH/5HdW5L7tVOkaZ3s9IuEj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:43:54.1059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f229ff-88fe-48f0-7c8f-08de7c0422f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:44:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3352

Testing:

Set ZEPHYR_TOOLCHAIN_VARIANT =3D "zephyr" in local.conf

$ MACHINE=3Dqemu-x86 bitbake zephyr-helloworld
$ MACHINE=3Dqemu-cortex-m0 bitbake zephyr-helloworld
$ MACHINE=3Dqemu-cortex-a9 bitbake zephyr-helloworld
$ MACHINE=3Dqemu-cortex-a53 bitbake zephyr-helloworld
$ MACHINE=3Dqemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
$ MACHINE=3Dstm32mp157c-dk2 bitbake zephyr-openamp-rpmsg-multi-srv

Also test zephyr 3.7.0 and 4.2.0 by setting below variables in local.conf
for above machines.

# 4.2.0
PREFERRED_VERSION_zephyr-kernel =3D "4.2.0"

# 3.7.0
PREFERRED_VERSION_zephyr-kernel =3D "3.7.0"
PREFERRED_VERSION_zephyr-sdk =3D "0.16.9"

Sandeep Gundlupet Raju (9):
  zephyr: Remove duplicate uninative configuration
  zephyr-sdk: Add back sdk 0.16.9
  layer: Fix PREFERRED_VERSION for zephyr-sdk-native
  generate-version.py: Add verion and help options
  zephyr-kernel: Add support for v4.3.0
  zephyr-kernel-src.inc: Conditionally add python3-jsonschema-native
  zephyr-kernel: Move patch out of zephyr-kernel-src*.inc file
  machine: Add support for xenvm boards
  zephyr-kernel: Add rpmsg multi services recipe

 README.md                                     |   2 +-
 meta-zephyr-bsp/conf/machine/xenvm.conf       |  14 +
 meta-zephyr-bsp/conf/machine/xenvmgicv3.conf  |  14 +
 meta-zephyr-core/conf/distro/zephyr.conf      |   3 -
 meta-zephyr-core/conf/layer.conf              |   4 +-
 .../zephyr-sdk/zephyr-sdk_0.16.9.bb           |   4 +
 ...ry-generation-issue-in-cross-compila.patch |  84 +++++
 .../zephyr-kernel/zephyr-kernel-src-4.2.0.inc |   1 -
 .../zephyr-kernel/zephyr-kernel-src-4.3.0.inc | 310 ++++++++++++++++++
 .../zephyr-kernel/zephyr-kernel-src.inc       |  13 +
 .../zephyr-openamp-rpmsg-multi-srv.bb         |  25 ++
 meta-zephyr-core/scripts/generate-version.py  |  25 +-
 12 files changed, 488 insertions(+), 11 deletions(-)
 create mode 100644 meta-zephyr-bsp/conf/machine/xenvm.conf
 create mode 100644 meta-zephyr-bsp/conf/machine/xenvmgicv3.conf
 create mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk=
_0.16.9.bb
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/files/000=
1-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-ke=
rnel-src-4.3.0.inc
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb

--=20
2.34.1


