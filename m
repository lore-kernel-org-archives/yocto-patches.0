Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE02CCA0EF6
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.64])
 by mx.groups.io with SMTP id smtpd.web10.2783.1755554590081028165
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=sRy/0TVZ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.64, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIxD2WoE0vLXQQl555k+1Z14V9V8TM0r+Yuczz3LAQzS8kg+TgHetLHWmOdEtHiVT1dzbqJquZMmkoE8j8+wydsRZ/tEATHUKhdM55WQLG/NNMs3rgm9LA7f95fVOcXxPE36iZpGKnZRMwy+ZxYRbO8LI+XHk+oMoedozlpNssjra0NH8Cu9WW/DW66DXWvHjx+OxEfg8qkE/9N+GV6r3R3RpVvh+9RR4lYL00aCDi3t1T95bqETBW6bvptoYstbvHNnKnN9ckEXZIJISkh7XWPqHkM8MD9tjRuooh6mhoi6hl1dvhOGU8Hi9h9FK2gXrAbKZQnObvrovcK3j6LehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9EPR4cTNA2vXb5f4YKQWncFzS9fxcYLpMy8LDB7Otw=;
 b=CI0CXbZdQ+ubt80xEzY43y6no/AuIyYWH/Jqsw1u+xxcANyVUDQtS8kETnpsPnIwdj0jUOMGcCTfQwcMmXPuMnsY7wgfBE0Lw6ZGe14maULm++DEq5dgKOYl1TIzvC37mKZekwSJL3DvnPGskhYpsyoBtuLTPMNnXyOSYmuxnATPeRK4BMzoNcKmGLmEWrjHBg3Qlcb68xcTTcgJLd/A7GAm/8Hrfj9jnTtLQCmJ9HPgd2VNqMIZSrx77jvaMon4hTmYWLmZKng3Rot1zTYIgSgmlJsAPxbkoMP0pRE5BULLbHq7s5gs675u73GJ4dulqBsp6EV+IeTARHS/5qKUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9EPR4cTNA2vXb5f4YKQWncFzS9fxcYLpMy8LDB7Otw=;
 b=sRy/0TVZTw4WAvy9QOWdiS97pQSMMgTPT/cn/haxwORDbArNtlK7tRifx/xfSBL3meP2OqSZSOEz1TlAYaxFNIF7QssTIL34AECjW3R9OUdVfavn3oX9WOaOHS7uebRT7rLxt98ADpC5AvAtEAJAZ5bgxt4/OFlXWO4MC0JqI1o=
Received: from BYAPR02CA0055.namprd02.prod.outlook.com (2603:10b6:a03:54::32)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 22:03:05 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:54:cafe::6c) by BYAPR02CA0055.outlook.office365.com
 (2603:10b6:a03:54::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 22:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Mon, 18 Aug 2025 22:03:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:04 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:04 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [scarthgap][PATCH v6 0/11] Update for scarthgap release
Date: Mon, 18 Aug 2025 16:02:53 -0600
Message-ID: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: e416ea13-1515-4471-6ceb-08dddea301da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+enOdPVss5J9i2CuASQi6HgbHXvxO9DJljvL0v0WnNOQehquPMi3pcBL74li?=
 =?us-ascii?Q?ycpJ5AOyb9heB8TE5KoMksGKWAwUciWh4ZOepI85/L6mDV6pttvWeZiehaYU?=
 =?us-ascii?Q?60L8w0pCJ7GztYreT55DGEWEusRiPOIi9APK71AUDmA+3a0iRqgE39sJlW/b?=
 =?us-ascii?Q?xb8YsCepFi7npW1wbG52q30P/xkq3cCJT7/UOd6/QSEK+IOWTiFGC8b3YorE?=
 =?us-ascii?Q?haGvcDfEg8JQgTUYWhvSX2aKVeMcTfh/T+uJrAJEEV/T/j4IHRWmwntQ8hrL?=
 =?us-ascii?Q?vpdXqkS5w2AcUSs3Nc9iYwb1UljJjdvqCPWKP8Rt6g1xShtCKbvQwj7Rxau4?=
 =?us-ascii?Q?lLspDcTrBJK1h/Ffm6xS6NY0ZEco1oAuVIbNyoE4/76nPFnvJxcXQx8W5c2a?=
 =?us-ascii?Q?dJCVPr20DtvqD+7TDk8UebgNAC+nOAZw8CBeXMibg/iDXDuctW6HZg/E6NXY?=
 =?us-ascii?Q?K5xfwplYoOLJnfDOnOFTsAzweDoFr5nem1F9D6gyA+yJpp4rguqNDVubW7QL?=
 =?us-ascii?Q?so5Pl19aJ2qmnSyYpW99crYJHx75fufwVtk8zMg5pQdOH4vr4OMPwLaMegts?=
 =?us-ascii?Q?h2kvEZFBkZCuHt4gu5/QLe3ffjoVpF27lmtcRIPS09KVrLGfo1eLIdV2nPnu?=
 =?us-ascii?Q?I4I5Dl0k2vnFii6hAjAMjyF/jYSi/myWa9ghyPvb2bN8+HSduEpEzMiwpGAs?=
 =?us-ascii?Q?Tv18LKpiQkqmBxNkHCh1KyVDLOqFbcWfn4uzYKFN0jVPK29W5IPvM4Wy/3Qh?=
 =?us-ascii?Q?ejQDZWIVZJ9u1r+KHTDaxA3t5jKy/ICBBb22FyaZtxY0/bN7MRs9MgGAqOjm?=
 =?us-ascii?Q?4qdDgecG/p3qd7UASjwgC5VPKu7BDOnieXrNqdwrsZVaf2BS7Q6DujKAUsu1?=
 =?us-ascii?Q?9Oqy3R353DZEmVqY/Jq8g4hihwyujlNRgMPRlQkJ3DkhasebV6nDOjMDXKCx?=
 =?us-ascii?Q?6xiz+ye13707a/OUzz17EuoKkTHQjgrsXCnp6OmDlhNHfzC8Ch6oK4Gka+hp?=
 =?us-ascii?Q?H195BLt8HYjPrd7ZAfc2v8Hsd++/1kqBBPzeVjrWVJgtJALZVrwIAFHr9Ejf?=
 =?us-ascii?Q?nrtTIAbnySYl67pF4uOCzlsXM6cGH7Di4gvogIEgno1aGaUVa7leMKH/Pgvk?=
 =?us-ascii?Q?WQgJKoQoERbEtsqFa3hDu3ilTPfuqEPhXCfx0lPI1fl9wSzXoBKk8NBaNOuh?=
 =?us-ascii?Q?ZnSMUsCWtirIr0j2q9V3D8wrZA1ifMaeVcmk9wWFVYJRDdqJBFGVe1G2shoT?=
 =?us-ascii?Q?89XWfZ9r5i7vpS+1XhkhAX7roFsqxq6Ha0ZcEk2BUdvcmeiUhtwi801cedq7?=
 =?us-ascii?Q?yfxDdZ/+N+xrnEuswSXu3wwTN3x7gRCIQI9aoXUlN01YlFrEhEGQWd3N6c7S?=
 =?us-ascii?Q?ckcT0pYIhqf9TnGpDffh0ORtn0C8408YdCx5AtmoYfhmYJolOPzuxD4KCjk4?=
 =?us-ascii?Q?GEId0GZ5+e/XNf1hn+2c8FPKml8clhOukbfZqAnhMehDQECcVgiZZD63JdHT?=
 =?us-ascii?Q?N9GQkFCDx/VWXe5+k+r2vJzev/VqC1cSSKC9?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:04.7268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e416ea13-1515-4471-6ceb-08dddea301da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2040

Changes in v6:
   - Deploy ${PN}.elf/bin/efi for backward compatibility.

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
1. Add new inc file and update to 0.16.9 version for scathgap
2. Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src and
   move to layer.conf
3. Add image artifacts to output files and use these files for qemuimage.
4. Add Zephyr LTS3.7.0 support for scarthgap release.
5. Update README files.
6. Move classes to match bbclass scope functionality.
7. Use relative path to follow best practice.
8. Convert zephyr-sample inc file to bbclass so that it can
   be inherited from custom layers to support out-of-tree
   zephyr applications.
9. Add rpmsg multi services recipe for openamp.
10. Add Board extension support.

Testing:
Run the following commands.

$ MACHINE=3D<machine-name> bitbake zephyr-helloworld
$ MACHINE=3D<machine-name> runqemu nographic


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

 b/README.md                                                               =
                                                |  163 +++--
 b/meta-zephyr-bsp/README.md                                               =
                                                |    5=20
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
                                                |   37 +
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
 40 files changed, 607 insertions(+), 95 deletions(-)
---

