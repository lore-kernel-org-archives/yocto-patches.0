Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FD2E9DE78
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 09:08:44 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.128132.1775725715415624542
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 02:08:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=V3wrNLH5;
 spf=pass (domain: ericsson.com, ip: 52.101.69.13, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeFOaL/Qc3lkVbq0UTpKH9dKO4SOuPyZHZWvDjXJ4cvVoCmehcnIJj1PRPKRuvG9EKIQqk2XZ+/8AF6+S5Em/T9R7QSrqkU2PdQDLv+1gXb2T+81FcH6ZacBeQyRulJXhtrLSnBqQTuRMu7ox7rLVBqCYPzOy0Tu4eZkyr1HlsxKXqUHKi2ut6c3bTRWWxzjMiG+KE3eTcfgWVw3OlM0J8T5xn/XkK35agqngjHmbZpDhboAKFR3wM387vCxPzJCl2/f/UOVJYXo5P0GHduRVVBuUlSQ0FjbmDg3cAapM45dGM7TceICF48DYary1XcEm6UDs/aCbR3WEjqwpNA9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2kNRUDYr/TQYux9Y1nPGnHxnUs31/nlrhAOH7bmDvw=;
 b=PqZpfniKbpQJhX4gVt72/Kov7f5El+Kd0LVVZBs3rRvvKRW0QZrUP/05XH4ZADPU5RvtFIB4wYlhU7QeK9c3XT/pmESWrJPmkXKobfzBu3bprcn4cjJefGnosmReJqETG0mxft8Xp3e6BCEuPpgWg/xan6dUpg+rLGQrwVLW9F94egJRjQVIJERq8nwb0D9bB3t7/BkX6/sC49bP8ntwzyW7CK0hT5B195AxpNJx90h8HA7oo3H3To8rY9KvksHc2A9jLh/10pyZkFHOoJPNGHNqqFlML17l2e2QL0ENuphn8WvTYKhbuCQtwbM92LwdS3V/FCSrUqOMSd++DTJOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2kNRUDYr/TQYux9Y1nPGnHxnUs31/nlrhAOH7bmDvw=;
 b=V3wrNLH5dAiRdCfL3uu9RdZrhdDCon8/+Ez/b1F8OJyJAjlVNV5C+ggs4R+t+E/1ZobTbo6Iz7aH6WcSa8JPmtMad6nSHiOmin8w1houVpoBDdxctnRKj1OP5u+15CdPaai3I3jajQ8v9pTotZi1H4xhXkPwh54pTMm67c7pdWI+zEmfbMoOr73BTBW49sAdlIeWhTXhwufXQGfpwGHS6Q5O4dCmcMquD1QevNOloJZvQ128cKhbi+xS0yR3K37A7FrSgrCBt4MZMwEAZqF2qXDGwrJXUA24D7JsllcWIiVpjCBweYjV43yK10rZD9pRXB6ku7jJ0nMTl7PW9VwbsQ==
Received: from CWLP265CA0428.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::16)
 by AM0PR07MB11699.eurprd07.prod.outlook.com (2603:10a6:20b:740::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 09:08:29 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:400:1d7:cafe::99) by CWLP265CA0428.outlook.office365.com
 (2603:10a6:400:1d7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.41 via Frontend Transport; Thu,
 9 Apr 2026 09:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:08:29 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Apr 2026 11:08:28 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 1D8149569E;
	Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 07DA3700CF09; Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>
Subject: [AUH] PATCH 0/6] Make upgrade-helper compatible with scarthgap and master
Date: Thu, 9 Apr 2026 11:08:09 +0200
Message-ID: <20260409090815.1731294-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A794:EE_|AM0PR07MB11699:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aeae465-97d8-426d-0115-08de961790d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	Rs21/w+08eY679cL73hsacJQV/+1QeZd7tKeGF8pmQ6zuqah7yjT2wMbbvOP/rjKBPa896sDg3HOdtGfOG9Sk/KoTAQGJ0UdtCuaoACa8f+yrmcVn8OSxi8HgANRuyZ2gLZXHOMjSxG2Y1Rc3XggLSZG3TYa8ldRHfP+cR+jLuKlRqoSFh7JiJDCEwcGu2KYwkMnQvEDjHY1fwZOaEmAPNu+JL/MlB5aj144fdpq8xOpEGCRFlvw1nORUf6mL3Dc7jtnjxfdNtRXgf3mOo+jKSQYPCP4i5JAO59AHhLBvoXP8RGEQJSuHAwaSc0AvD0rKOEl+kA1+8RCU+Qc9tsqExemafTU2cWqZEKF5degulcw+Ovwoz3dR3nU2ZYTfVxz1wfpWkizlhVb5SFAhYFvUgbI76ODEM3fQYdb6HeGmQgUutIXkF5D9qLMHqwEbmgf7aIIwEcy5TuKNUAaw/iaKBdURvMn8cHbTfBgWTS3LFknH7BG+O/IuIk6BErzDLz8/D4zynATj0x1xwOOQlib9n+LwozsCYpOTSg0hQ64T2KKDg5NoI0YwBRaMviaN4ZtH6WOz8XsiHLENkhgLr9fsxnAzH4qe/C0JwiFApZneLutYn1mpS9GE6PD/X+nmiaiI4OglQS3vuTZzDsWxcERAU7poP8T83dPq1Kv7kLX2peoW4iUCiIvYPMY5q5/kY0KlRb4cH2XP0sLtfHoNiNxnnQ4clup1kYpinZgksfQcmQ=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	C5i6H9ETcULwIgHarFWpAr4fb3yrvXftrAIQ6aZV62rgGVmF/k3QWOJRxFtOQtEhUltPuQ7QlxtDnz4vXrCIyZLtoqZewyL+CL0qt8pwI6H3KU068Br0bFN2PkELSO5I6WjUMu9HYLCnCS+JGNv9EQlvO2zK+d64CbmYPFuJ8DBtHtk1J3r27+I2d2Q13e0e8uHomUX31cKm4Dbogpons6BjsKwLAS+0qrYb2NSzph+PmwW+eS1H0mss3CsPhvyCrrKJUp+50Dpa/4U9G1O4di1A0ahEoxQsfwrgxNpTAMtTiZ1xPxLGAGv0XYhp4Vb1ZDQ1/5TBVGKGdQ2/FHFZQG1RMN2d/NjNakNjAnEt+plkygKWdVOFs+wAxLIYIU1EV4Sx8h6rXz1im67Bul456v/oEjLC2zSfBffTx8HzHFUVwtwqj17QSN0sep/zJCc4
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:08:29.0795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aeae465-97d8-426d-0115-08de961790d4
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB11699
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 09:08:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3669

From: Daniel Turull <daniel.turull@ericsson.com>

This allows to be able to automatically generate patches for updating patch=
ed or
minor versions, which can help on the security work fixing vulnerabilities.

It adds also the option to extract the changelog with different strategies

It can also prebuild the recipe to be able to compare before and after the =
update,
so it could be connected with ABI changes with meta-binaryaudit [1],
so if there are incompatible changes the upgrade fails.

Example with OE-core scarthgap, there are 156 potential updates

vte: no suitable version available, skipping
 ########### The list of recipes to be upgraded #############
 , libubootenv, 0.3.5, 0.3.7, Stefano Babic <sbabic@denx.de>, 1e3511ed77f79=
4ee5decc0974d54c8e5af26f64c
 , bind, 9.18.44, 9.18.48, Unassigned <unassigned@yoctoproject.org>, N/A
 , dhcpcd, 10.0.6, 10.0.10, Unassigned <unassigned@yoctoproject.org>, N/A
 , libpcap, 1.10.4, 1.10.6, Anuj Mittal <anuj.mittal@intel.com>, N/A
 , ppp, 2.5.0, 2.5.2, Hongxu Jia <hongxu.jia@windriver.com>, N/A
 , socat, 1.8.0.0, 1.8.0.3, Hongxu Jia <hongxu.jia@windriver.com>, N/A
 , base-passwd, 3.6.3, 3.6.8, Anuj Mittal <anuj.mittal@intel.com>, N/A
 , ifupdown, 0.8.41, 0.8.45, Anuj Mittal <anuj.mittal@intel.com>, N/A
 , libxcrypt-compat, 4.4.36, 4.4.38, Khem Raj <raj.khem@gmail.com>, N/A
 , libxcrypt, 4.4.36, 4.4.38, Khem Raj <raj.khem@gmail.com>, N/A
 , ovmf, edk2-stable202402, edk2-stable202602, Unassigned <unassigned@yocto=
project.org>, b7a715f7c03c45c6b4575bf88596bfd79658b8ce
 , util-linux-libuuid, 2.39.3, 2.39.4, Chen Qi <Qi.Chen@windriver.com>, N/A
 , util-linux, 2.39.3, 2.39.4, Chen Qi <Qi.Chen@windriver.com>, N/A
...
 , numactl, 2.0.18, 2.0.19, Richard Purdie <richard.purdie@linuxfoundation.=
org>, 3bc85e37d5a30da6790cb7e8bb488bb8f679170f
 , taglib, 2.0.1, 2.0.2, Anuj Mittal <anuj.mittal@intel.com>, N/A
 , utfcpp, 4.0.5, 4.0.9, Anuj Mittal <anuj.mittal@intel.com>, 63d64de49fd6b=
829f7c8694df5ab2ee625cb7134
 , xxhash, 0.8.2, 0.8.3, Alexander Kanavin <alex.kanavin@gmail.com>, e626a7=
2bc2321cd320e953a0ccf1584cad60f363

[...]
 ############################################################
 Building gcc runtimes ...
  building gcc runtime for qemux86-64
  building gcc runtime for qemuarm_musl
 ATTEMPT PACKAGE GROUP 1/156
[...]

Tested with on openembedded-core with latest scarthgap version (2026-04-07)
../auto-upgrade-helper/upgrade-helper.py all --layer-dir ../openembedded-co=
re --changelog  --stable --prebuild

    TOTAL: attempted=3D135 succeeded=3D81(60.00%) failed=3D54(40.00%)

Examples of the patches in my contrib branch [2]

[1] https://github.com/Nordix/meta-binaryaudit
[2] https://git.openembedded.org/openembedded-core-contrib/log/?h=3Ddturull=
/scarthgap-auh

Daniel Turull (6):
  upgrade-helper.py: Add compatibility with Yocto scarthgap
  upgrade-helper.py: allow to set the git directory from layer-dir
  upgrade-helper.py: add changelog flag
  upgrade-helper.py: Add minor option for minor version upgrades
  upgrade-helper.py: Add prebuild option
  upgrade-helper.py: Add resume option to skip already attempted recipes

 modules/changelog.py     | 256 +++++++++++++++++++++++++++++++++++++++
 modules/steps.py         |  22 +++-
 modules/utils/bitbake.py |   8 +-
 modules/utils/version.py | 175 ++++++++++++++++++++++++++
 upgrade-helper.py        | 143 +++++++++++++++++++++-
 5 files changed, 600 insertions(+), 4 deletions(-)
 create mode 100644 modules/changelog.py
 create mode 100644 modules/utils/version.py

--
2.34.1

Daniel Turull (6):
  upgrade-helper.py: Add compatibility with Yocto scarthgap
  upgrade-helper.py: allow to set the git directory from layer-dir
  upgrade-helper.py: add changelog flag
  upgrade-helper.py: Add minor option for minor version upgrades
  upgrade-helper.py: Add prebuild option
  upgrade-helper.py: Add resume option to skip already attempted recipes

 modules/changelog.py     | 256 +++++++++++++++++++++++++++++++++++++++
 modules/steps.py         |  22 +++-
 modules/utils/bitbake.py |   8 +-
 modules/utils/version.py | 175 ++++++++++++++++++++++++++
 upgrade-helper.py        | 143 +++++++++++++++++++++-
 5 files changed, 600 insertions(+), 4 deletions(-)
 create mode 100644 modules/changelog.py
 create mode 100644 modules/utils/version.py


