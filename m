Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AEFC87FCF
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.82])
 by mx.groups.io with SMTP id smtpd.web10.36643.1754869161718227056
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=2vrZxDco;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.100.82, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Biv4xYxs0NoIjivP5GOQXSL+IOzdU6SN0Ynf/ZpkWtyxyRT2pO32QV1On9p+VNP0JJsnUgC01+pLT+whBYBWJjUXEVPOC8NJjYuApIxzKr9fLJELpam/SnBqSA7MKxuwXNfuKzNCa0JuN+YiNoxylfxvHOjNlu4zHBNekcEZ7PDTsaVAz3cJKF5Ahyym+iDgnBt4yT7/VVZC70n2WszXdOAnqaE9hirLsfNnEGyANJmnEnRi9v2mqXYtEiA93kuCz1G3Jx1KtG5Ax6EZbopYQK3okPlmz0AzxLVDDfgjxm6GFy0Qcd3uRaHIOrNabB71T3dmLrjUfYS2+0SiZHKKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bX4XP79aq2T0ivYm8nrB0VtqLUhJtOY8fhPEslydG4=;
 b=oNBCQUOEWzkRE3r228xvdu9q8ptmNJDU/kQSt1Qg49HC0MWC+MW5/lZKQaj2X/cIbWEEVqOYJ83Ooh9KO0iB8UPkweQ02mEDHx6+H+Jt7xoUI+2c3q5hcyix2B6CPOddHGdkEjtXYMopgA1REjkzWaTvN2qEl9eGCNyYIi9B++mFCkZL2mQ7Wsy1l3qXnkrcx7XhuGQNwMwuuwe1ybd0kGRiPxPmi/S5Ic59ObggSbfLoBfZsJBGxUfs/Jrf5xKyGmvsNnBad4JuSbQzITaR1Xx3tTieB2XFbAt+fO1RQEX+r/BfkTD5oJAazKCbHJg8cWMW4MIrLAohLQAGwbUMcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bX4XP79aq2T0ivYm8nrB0VtqLUhJtOY8fhPEslydG4=;
 b=2vrZxDcoDvpwQm0ehqLaxH2VAM5A3EA4QPit0Fw2RA0YA1ID2NVpoAKSqhtnPLnHWU4IhMo6+3+AvxBlo9hyAyVFvDDrZET4X6b25DaCH6Guh5pYGx/isiyo8xKXGfwakJqiR2WL5o0sRu3uqq5d5vAcnSLabDxXOZS/WOaRd/w=
Received: from BY5PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:180::49)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 23:39:17 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::32) by BY5PR13CA0036.outlook.office365.com
 (2603:10b6:a03:180::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Sun,
 10 Aug 2025 23:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:16 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:16 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [scarthgap][PATCH v2 0/12] Update for scarthgap release
Date: Sun, 10 Aug 2025 17:38:59 -0600
Message-ID: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 53fc824c-fa21-4c59-20df-08ddd8671f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mPPknAqRDvJg693vpfEK7EMGo2QOBdCwQ2SRk/fFhuWC74B19Oe/vS46HtAx?=
 =?us-ascii?Q?j7IrOK9+5zBxJRYXUcrhe4wR6cibKxtydjWIdxKzii+X1YINdx6adJ912sEt?=
 =?us-ascii?Q?DfFHGjkkm4C9nN5xRcgfguDeC+tHy+s6racoaxeXKldhlHtNmtSU6qgLc+Qg?=
 =?us-ascii?Q?Bnu4pdlcjWoHl/TUgCJ4hTqxnpVJBlYrCIeSb+q6ASXhgNzjljxzZdsb3Eg1?=
 =?us-ascii?Q?OCopq5GXmbDtrYKVeLj9PB4YsNcCgNxli7stRWEltTRIK+IwF7bPYD8NEOfU?=
 =?us-ascii?Q?At4AF7wYIF5PfuL+zQymAFCfoWf3RajR8xAJ6xu91WgqY13kDzjvX4qMk3dW?=
 =?us-ascii?Q?oIqjxSwoxORIqe6jenITJ0GXm0A9lMZ1e90y+GgR+cwwgW25ZSN55tgX4RBl?=
 =?us-ascii?Q?bdWtlBZyGUJJUZgmvhNF0/PGlKVJgQuRNwl8fMKjALy/CRfmN2alxX+TKcnS?=
 =?us-ascii?Q?/tn67LG1yP5Pmy8+fudVzJuzeEg/FtTlEM3k2gMVD64ALTiI2mCuX6DcZUkx?=
 =?us-ascii?Q?WpVjcgI0Wc3uhEusRXRzJkdkB/WXnUI+e+051I1bQUr4mg+pkChBCbkE7ACR?=
 =?us-ascii?Q?pDkiy8ncvWWiNqTk9Cwc8AdN+QM7cI/8QcrGZqmoop9uoiehfQEA5SJerON1?=
 =?us-ascii?Q?daRXGZqCRAf9td+2TK4hk1zd9MrLaPaAOYNPshS1qtbsCsvgiu8lVuh0dZw6?=
 =?us-ascii?Q?eqxQG36UYpNBuZrkdXcPjM4TOC03GQFKGjotSbcUqSn7T2Z6SYCfJggSpC1+?=
 =?us-ascii?Q?SAzvDauVfTnkO7D5EPgCjghMgjXgdpDOxwBBpWl5H0mgLvOYZBblX/bGe6/M?=
 =?us-ascii?Q?1/r2J2HxqXQJw58vgyYI3yw4hVc7L+w87jvUt4FSoLZ29ly+mBWB9Vsgs24J?=
 =?us-ascii?Q?OlqpUdta213j2/7Y0CBBSS2Mr2Yg3M7JGo2knlzb30aV4/JgTddcHXhM3oHE?=
 =?us-ascii?Q?7nAwfzD0Z08yCNtY2Y7Mn4Pfua1NZu6ltIGYQ9oQxm/l4ryit4orUqK6XVnS?=
 =?us-ascii?Q?xnnbHOER0U6zK55P7PBwfUT530/4yFJ8GVSFgc25N88bAnQNMreuJF0Heymt?=
 =?us-ascii?Q?6bmJeKTp6zAVFgpknjl6qUlhFYS8vg6Q83cmkbo+qKjril0be1X3o9161sxL?=
 =?us-ascii?Q?BcrDnjldYqlk8zbGj/LrR5nVX07/lO+AbpRo3rEMSm6SBmQ2Hf4hgReh9nBs?=
 =?us-ascii?Q?XQBns2AwdKhbcpp8kkuI+TGavSqB5i2EZESqAReqausCfgFu9JSXGHdAZnRm?=
 =?us-ascii?Q?HJ2GI6HA4l/Onx7ZzWi7rrBhAzshnt2OecbAN0lD6B/7uX7oyYpQ/GyxZp17?=
 =?us-ascii?Q?nZwi25iXki8c1mg7QrEnaG+ezPsWzuyligjBT6BfIWjktx9g9eikI1uuAaoI?=
 =?us-ascii?Q?6OWrVSQigXqyez9mgsrg2l2wLGfr471n814I5kqo6bA3wkEp6gFAeGT1ZKi8?=
 =?us-ascii?Q?jukUnQYIxpUARCj1q9uZ4UDx5zTstZpFTBz4M+z3+mnU5mC0DsN/V1ifp55N?=
 =?us-ascii?Q?XlYcSb5jDlsdaL5W7e0grd+ts/5n0OCC5QPS?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:16.9848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fc824c-fa21-4c59-20df-08ddd8671f15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1910

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

Testing:
Run the following commands.

$ MACHINE=3D<machine-name> bitbake zephyr-helloworld
$ MACHINE=3D<machine-name> runqemu nographic

Summary of changes:

meta-zephyr (scarthgap):
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
    layer: Set PREFERRED_VERSION for kernel and sdk
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
 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sample.inc           =
                                                |    1=20
 40 files changed, 594 insertions(+), 95 deletions(-)
---
*** Instructions ***

Technical Reviewer - This person should review the changes for technical
             accuracy.  They are expected to ACK or NAK a change before
             it is merged.

Gatekeeper - This person decides if this is an appropriate change to make
             at this time.  While they do not need to perform a technical
             review, they may also do this.

Issues -     A comma separated list of Jira references for the changes in
             this request.

Description of change - A verbose description for the changes as a whole.
             Each change is expected to have good Summary and Description,
             this is just a general overview to help people understand
             the set of patches as a whole.

Testing -    Describe the testing you performed for this change set.

CI Build Information - Various fields used to control automated CI test
             builds.

Summary of changes - Automated summary of the changes included in this
             change set.

