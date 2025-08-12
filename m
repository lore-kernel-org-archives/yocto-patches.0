Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3558CA0EE9
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.48])
 by mx.groups.io with SMTP id smtpd.web10.81593.1755020516350180924
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:41:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=rjI2KWIn;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.93.48, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0y7zM6pl5LWkVMVsHsPVJxteYTOt0k3aN/0RRZUZyh68qt4okJLFcHIstnTLvohmxOtWW2GD6FoiqVD8ZS4aSqExCi4ixIPojgvTLb4EoZRiWIoBEVwzItinS2SDBwJIfZcLiMAf1W0BuIX7HVG3jUv3caHdZiBIBooeK35/yJRN5y0s0Lvmg+YIgZVxnOqFXNroN11WKO5pksZRqR4TJzwUUfQm9XzE0pOlQ9uiOXVNSdnHNi5vu378g7Ytler+OMFyEN8OIMgC2JbRmuTmQkKWkpxbd23GoYobtobUzI/x/2ytCcaRBGmfQC8e1wuYptwMPna2xg1ggbxn/2HXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjKt9L/gmV9Ma3m8hBlzCvpoR3EWuDXrIcB4G+SoDts=;
 b=uhvGi65eOwbF3SrWUXHpGEdnKm2pZk0qI8TQyqc+lhFQ6PSTa5/wnplgyZ6XVA3jVGkJQoz9Y6AEHl+a4ru/heBIzeBOTa+w2C21x+0fyobmZ3st08ZVaO+lRbvMv/Ps1oMaB3CQBVFuMqEM0x9r6vVwE/uo9PWagmqAkA5X3yMe5ySaEfV3dJMMQYcB+TDxSS+Lj6Zs5VhMk2ftOyGd4yDO4EJnADli5JZlC+pVUtZIdMbgUCV44AOn2nfKzBMjtu7oo5nHWDFT0DZvJbQzRE/fSbP1uxpFREpeNtX7625gi6QjAuV/fjMQrU7oPWg2C/cf00OgUlwUEauW1KvQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjKt9L/gmV9Ma3m8hBlzCvpoR3EWuDXrIcB4G+SoDts=;
 b=rjI2KWInBW8YavHouX1y65Mxz8HJuqvEaX7A0rd94vBznEeZ4tQ2XmG03jJWXJYyne1wmRRsJOx90wJlaS/Z/sRMjMm4IbQ4yr3ffunQOaOIJb7LiyYlNisNH5/2qmkpCd+Axglx7uYrjS7FW0SLWS23jPnf2KyrnS2Fe0UD/9Q=
Received: from CH0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:610:75::24)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Tue, 12 Aug
 2025 17:41:54 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::f0) by CH0PR04CA0109.outlook.office365.com
 (2603:10b6:610:75::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 17:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 17:41:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:52 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:52 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [scarthgap][PATCH v5 0/12] 
Date: Tue, 12 Aug 2025 11:41:35 -0600
Message-ID: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 4edcb607-28fb-42e0-cad9-08ddd9c78684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?njiPVTiIqVnsfkDvzfbr3+XT8RAKmqW5Py6aGMJmAhwy7aznNSShLcgMN36j?=
 =?us-ascii?Q?dZ1oe8DZ1si8bO6QKREAiqQB1nuNxRfK52g4oRTNYm+RFGYv2chNFNPVaDpz?=
 =?us-ascii?Q?bBO1z1FXCJ/3ov7ajIFH3oHZkZFEPcFFbc1Vr77StGbw5g0IjEs3eEQ+UoLe?=
 =?us-ascii?Q?p20pQrnbpE7CNracQdcmnsuE1I6FiWJlcppgmz8UitUfAQhy4/nQf9w+Luv/?=
 =?us-ascii?Q?kLl3buRUv2ie0qzWj8H0BJjZRZbePv+p90PVkvxGH+CjwzND8m/nRQJAEWFd?=
 =?us-ascii?Q?hoRBQhS+hDHhN1524GU/NsT0LS4JFCoUhKCkKlGvwFiDMc5FrrhYekSNlP5B?=
 =?us-ascii?Q?Z3G8kSnaWDq7B/4R2UArqvbo0mw3lNjkeifcdQu24CtP8jZVOi5gI9sBpSBn?=
 =?us-ascii?Q?pUEuJ7gZNYZTwwlsjsCTfOI8MTt1Pen4w+OZLtxsm97a5cdDa3a1cm4aP5sD?=
 =?us-ascii?Q?9vG9LbPkq0TDWWxbb78ox4fjTb6LGl91RCm7AEsChVLcitrsF8ZaUUV5dAU4?=
 =?us-ascii?Q?a6wl2/KHuAHn5087RJYqAIZg3eDsfhcnHWI4EOqv/xOo4mqyMykFFEcxTFzV?=
 =?us-ascii?Q?lLLcsKUC5wwyVB4yBvfyHnV3HXkPA9o5c39mWjbXnr8lkU1X3Kh759ZF8mhH?=
 =?us-ascii?Q?f1JYVhQeeWA7LyZmLZqYqwTEa/4aBoJIF5vC6h9jvJOw978bqRj3oStTY3WN?=
 =?us-ascii?Q?BKncWCLAdO31jSVRDaafvXoKmldGaGmS5sBwId6PGuIwLvU4Xr8psAKWIHw+?=
 =?us-ascii?Q?IVqyHRRxMr5mW+ENpQxXbgEvN8UCNfj7oMgL61Orms9ARPXY6/JGWz3eYNFk?=
 =?us-ascii?Q?rzNt9yOZdUvJELw6Yc0HT1oUuVWAxGLVx7ZoiHf2qYBzPJskr8+Ddkv+3+Zx?=
 =?us-ascii?Q?i04EpAEJZSMG6PdJDFOaIt1JMChAB+GGNSGZV/v6cMvPd0icndk2Dq7MPQqi?=
 =?us-ascii?Q?eJVUWYEcIRlFOUwZsll1howWW5pE9+Fgz5TGuWiUP9xVL8xgJj6L8UZMYNQw?=
 =?us-ascii?Q?sPTSFhksdiY4dyrx/ti9NeD5v86Y0PZMEsoUOJA1QZJtr+E3y3lh7sPbIlJc?=
 =?us-ascii?Q?yV/UVjYTjKy6WUN1XGA4bgoyADOmFw2T7Jccynr2P66RT1QEWZktpMb73b6A?=
 =?us-ascii?Q?HCJ6OpoavMex86npKXQyd9bXYQYctiItIHEFfSGScj6NKBNirqdWb9cSsZSI?=
 =?us-ascii?Q?gHFz4gi3AevC05XjH5mM85r3Md/0SwsLXBdel8ROyI1CgV/M2DOk8LA3QnKg?=
 =?us-ascii?Q?Q/aU2G346CMmOqlBPA0mxrp8rBhisKuN1Ibmb2RvIzm36A+Gn8Og+QXpVR3e?=
 =?us-ascii?Q?YBBAsSt5mcCUXLwT1VOIv9QbbbO6nq7Ooi0GvLgzQPLvlMAT1afWgf0c2z7l?=
 =?us-ascii?Q?3UQWjt0r+7pBgIDpQ9P7gw+X4jodtNWnQmyp3zBYtiCaG9uRC0zJzHWJtAO8?=
 =?us-ascii?Q?lryy3z0KPyvLKwAHXglivM7M4YXcOsfTVCq1cXJFaWOvV/KN31sqXVsJZ2Hu?=
 =?us-ascii?Q?8P7Tg3u+5ouBGP4+52O1hioEiNv6K7myyIME?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:53.4505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edcb607-28fb-42e0-cad9-08ddd9c78684
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1962

Changes in v5:
   - Fix typo in zephyr-openamp-rpmsg-multi-srv recipe.
   - Merge below commits into single commit.
     [meta-zephyr][scarthgap][PATCH v4 3/13] zephyr-kernel-src: Remove PREF=
ERRED_VERSION_zephyr-kernel
     [meta-zephyr][scarthgap][PATCH v4 4/13] layer: Set PREFERRED_VERSION f=
or kernel and sdk

Changes in v4:
   -  Fix below patch commit message typo.
      zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel

Changes in v3:
   - Add Board extension support variables.

Changes in v2:
   - Move classes to match bbclass scope functionality.
   - Use relative path to follow best practice.
   - Convert zephyr-sample inc file to bbclass so that it can
     be inherited from custom layers to support out-of-tree
     zephyr applications.

Description of change:
1. Fix runqemu errors for qemu-cortex-a9 machine.
2. Add new inc file and update to 0.16.9 version for scathgap
3. Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src and
   move to layer.conf
4. Add image artifacts to output files and use these files for qemuimage.
5. Add Zephyr LTS3.7.0 support for scarthgap release.
6. Update README files.
7. Move classes to match bbclass scope functionality.
8. Use relative path to follow best practice.
9. Convert zephyr-sample inc file to bbclass so that it can
   be inherited from custom layers to support out-of-tree
   zephyr applications.
10. Add rpmsg multi services recipe for openamp.
11. Add Board extension support.

Testing:
Run the following commands.

$ MACHINE=3D<machine-name> bitbake zephyr-helloworld
$ MACHINE=3D<machine-name> runqemu nographic

CI Build Information:
MACHINE:
BOARD:
BOARD_VARIANT:
IMAGE:
PLNX_BUILD:

Summary of changes:

meta-zephyr (scarthgap):
Sandeep Gundlupet Raju
    zephyr-kernel-common: Add Board extension support
Sandeep Gundlupet Raju
    zephyr-kernel: Add rpmsg multi services recipe
Sandeep Gundlupet Raju
    classes-recipe: Convert zephyr-sample inc file to bbclass
Sandeep Gundlupet Raju
    zephyr-kernel: Use relative path
Sandeep Gundlupet Raju
    meta-zephyr: Update README files
Sandeep Gundlupet Raju
    zephyr-kernel: Add Zephyr LTS3.7.0 support
Sandeep Gundlupet Raju
    zephyr-qemuboot: Use image artifact file in qemuimage
Sandeep Gundlupet Raju
    classes: Move classes to match bbclass scope functionality
Sandeep Gundlupet Raju
    zephyr-image: Add image artifacts to output files
Sandeep Gundlupet Raju
    zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
Sandeep Gundlupet Raju
    zephyr-sdk: Add new inc file and update to 0.16.9 version
Sandeep Gundlupet Raju
    qemu-cortex-a9: Fix runqemu errors

 b/README.md                                                               =
                                                |  163 +++--
 b/meta-zephyr-bsp/README.md                                               =
                                                |    5=20
 b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf                        =
                                                |    1=20
 b/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb           =
                                                |    4=20
 b/meta-zephyr-core/README.md                                              =
                                                |    6=20
 b/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass                 =
                                                |    6=20
 b/meta-zephyr-core/classes-recipe/zephyr-sample.bbclass                   =
                                                |   10=20
 b/meta-zephyr-core/classes-recipe/zephyrtest.bbclass                      =
                                                |    1=20
 b/meta-zephyr-core/conf/layer.conf                                        =
                                                |    4=20
 b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc             =
                                                |    3=20
 b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb       =
                                                |    4=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-3.7-x86-fix-efi=
-binary-generation-issue-in-cross-compila.patch |  106 +++
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-blinky.bb          =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-client.bb     =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-server.bb     =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-echo-client.bb     =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-hci-uart.bb        =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-helloworld.bb      =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-http-client.bb     =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc          =
                                                |   28 -
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc  =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0.in=
c                                               |  274 ++++++++++
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc     =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.bb =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb     =
                                                |    4=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb            =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-mqtt-publisher.bb  =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi=
-srv.bb                                         |   23=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-table.b=
b                                               |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-echo-cli=
ent.bb                                          |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-rcp.bb  =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-esp.bb  =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-hr.bb   =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-philosophers.bb    =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-synchronization.bb =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-websocket-client.bb=
                                                |    2=20
 meta-zephyr-bsp/README.txt                                                =
                                                |    1=20
 meta-zephyr-core/README.txt                                               =
                                                |    1=20
 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc            =
                                                |    4=20
 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc    =
                                                |    5=20
 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sample.inc           =
                                                |    1=20
 41 files changed, 599 insertions(+), 95 deletions(-)
---

