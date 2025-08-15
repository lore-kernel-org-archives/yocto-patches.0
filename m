Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A669DCA0EE8
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:54:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.79])
 by mx.groups.io with SMTP id smtpd.web10.4392.1755230096084811481
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:54:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=iwyDAnPt;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.79, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvHTiXbfRJ1zsgI8v5Z1aQ8qt6kf+IXb6vLKVtN3pu0vqlYlKbOQOZb02ODcvQRSzYT6JpeMH6WyGCONsAugkdpP6w5PHEMY/1tMDj1CE/1Xe2NSf7MsssczSI2KYfBp+joB6AcKzzZaCOHloTdIDd6xo9ui2kSLlSxzDKRHjyEkbiu8maMn8BL+I6dPvKSAY4Ggsyb4GA1jCEI8+9ZQ64xiyyIi9ygXM+uB2s9XNG802wp71jaiXzt8TKVJt8/Hr4XQz0bjOzuhFlhffISzVebu2Gv+3oy85Da/MZK/m8KN6ntOXUGy8QzEllGdwMrQBgvlxjD4Sb15otnoTpEKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMJKZus28PJu1oxM9m1rlmp7WYSCcht0hPrcTJv07S4=;
 b=CgHHF17W2heHoE4Y334RyX08/gTAP8WexQovsvbKy3d1DWPFyJCCynpxFy9vwR/inN5C8NKZ3AFyFl6CcVuMDtlPcly69AOkfo9jHGuvnZHJSN+Y3pUx1DX7jVhNHKfXmv5BWp8BuWo3aBVkXKxfezK+HiAyr7bYT9ewV1WNiVqti1IJe9U0uYyLiRVtxu/nf5hGBW/ymRJZ3Mzp5cvtRrnAnTTUmqXhlboawdMZEs7Hm2RomkxrHBYdkuht8J8s+tZr0KCMyhKTQvk27caUcSO4d22IqDq8NLk7l6UuhO7tUzR3uJvRW2ap5iBPH2sUS0+PRj7ypH3bdNWJJFFHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMJKZus28PJu1oxM9m1rlmp7WYSCcht0hPrcTJv07S4=;
 b=iwyDAnPt74cytW9WX7H2+eniNOrHcrW0GNTb0c48vsjgdCZPJLk0YJLXPb0jDeXE91cJ1ue7Xkdau5iv950IdvoH4MpSaKo+KtBIVWFnIJc9YA4FXdaNxpRjIEdt092Y4I6ontP1mJqNosKTd8x4po9sw8YQoDn8dboHpaCkMM8=
Received: from SJ0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:a03:3a1::7)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 03:54:52 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::ba) by SJ0PR03CA0362.outlook.office365.com
 (2603:10b6:a03:3a1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:54:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 14 Aug
 2025 20:54:50 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:50 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 00/12] Update for master
Date: Thu, 14 Aug 2025 21:54:37 -0600
Message-ID: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 17986607-5a97-4d9b-f792-08dddbaf7ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LnPttVTq+9tomSIVds+Mz0oJejcpAi+Z8WvLjgIN+WeeBK4L1jPzDte+ttmv?=
 =?us-ascii?Q?87r30UkkKMBi9nW67gXbZ4Ci5NZB+UiZT1Yt7Iand+0diWD/BP0lEK3bZ07u?=
 =?us-ascii?Q?qGgVQqK6t5nEKwycuwyQAz1ac2t77fCAUn2r0UAUUnonFuKZGEeTEn2/O5E8?=
 =?us-ascii?Q?DBs8GRWHyNR07Wl/5okSkFotEX4PxtkVoAclwH0t2LHx2pMP5vUWnCNDQHuL?=
 =?us-ascii?Q?qNf3xSUs+Q+XHiZhFu0TGYnH937JBkB04l85CEtsWjzq6JXwnCzeHh26NSx3?=
 =?us-ascii?Q?beM/8HrfkD88xFeMqQ62Ce2ldt6hidLYD/7h52k6zeA5X7BpzqrvEqW6mrZI?=
 =?us-ascii?Q?pmZwUe43yoK5TVNFpdIx1SX+4CXsXyI4mXZYsOLFsco24oTA/cSYHVIAT2+N?=
 =?us-ascii?Q?pA6kX5WAqaAS0Yiyd/E/2D93evRJhlVzhaukl2v6jqSB09rwmoVkdQ707t0z?=
 =?us-ascii?Q?kyezDAMbh862eEdxeDRj/wEX8ogkH1FPcjIR5rD8A5RnrBonpYZjC/Pm+dNP?=
 =?us-ascii?Q?ZS7Igls0rHoAU6zr80C+hOAHrfXSzQvDy5EdmH4bj7UdQTlZ9EE/q6AuispY?=
 =?us-ascii?Q?PkrAlg069XnCqf60nCzy5RJ06d7hwaTIvI92EI8t6nDVrIdE0ScZce/n685p?=
 =?us-ascii?Q?JcBq4g9CPGVgkz36bXj70/xyiWEsQFCGFj5/bwABhYiqrpV2e7rIUWESGUYO?=
 =?us-ascii?Q?AJaFIqzBvpeEC46cIlO6u4ExxT4zsbBE0wnJVluauysQqwsxbpJY8ipL/mE4?=
 =?us-ascii?Q?viHjvAVn9DI9hKExz+gqGmPR1T0C3P7baJKnQr3mEnzi/nl6yyjjuXi5ZwQh?=
 =?us-ascii?Q?VP/UuQwearr4Wlttexg6rf/7Ax4+1bilw0aGuKFDWoDT23+A6jODf3HeUsST?=
 =?us-ascii?Q?wtPw+ZfCosnOq/2nZ4RRWBwfApMoV6xzvfKU6/4HJdoiFiy0K3BpxlDfMT9R?=
 =?us-ascii?Q?nJiHeeQ10PAllt8E5Ra6x+W3m8ClgFx6c1xjsPS3gyS1zWBD+69yhgwQ0T/T?=
 =?us-ascii?Q?zIC/IXWXGrk+I8AfOsz0Byr4c/SnC7Ul+++0jX4RWdGy0Es6hQLVUhn5RRoY?=
 =?us-ascii?Q?Y4LufPnr77r4UDVrJ3EZYl+AUBuhZxLn1k7oCTo6c1bedIvEjGeDf+wdWIiF?=
 =?us-ascii?Q?YN+YpekkXBXBMG+nibcC/75f2pE0jVxN3AyTNs+GQyi9fPNDYTekIEo+adCD?=
 =?us-ascii?Q?k8hHTbLazkPRSItVizdd+zGuMjXJld0IKyBaEFtJ+Nh2u+UnujAYKTypYhV3?=
 =?us-ascii?Q?TsBFtRcoyn6qc6rJVuZUrm161OhpgpdI+N+jngErkJLykjbpLrZP+VVvu6dJ?=
 =?us-ascii?Q?mdQA2H1PS1zXGQTaq2XRu11zAi9IuSZoXn4Z1ekWAyXMQH8a1jRKnAu/vbmJ?=
 =?us-ascii?Q?PS6JXMVD1xXD9MGPmEE/rBgZODrToczMeg5xMiGZz3dzfLEcbAa3UINqP3Oz?=
 =?us-ascii?Q?MjUP2nZyRgyOtbDJC0WLuhSe3rCl2eeyz2o91yrNx4Pyhks4apIzWBs3C8Mt?=
 =?us-ascii?Q?vWLm7I815ehh4C9LFJYLjN6VkeegRscKHO95?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:54:51.2392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17986607-5a97-4d9b-f792-08dddbaf7ca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:54:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1989

**Note**: This patch set requires Lee Chee Yang's patches.

[meta-zephyr][PATCH v2 1/2] layer.conf: Update to whinlatter release series
[meta-zephyr][PATCH 2/2] recipes: update to match S/UNPACKDIR changes


Description of change:
1. Update script to generate srcrev
2. Fix runqemu errors for qemu-cortex-a9 machine.
3. Add new sdk inc file
4. Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src and
   move to layer.conf
5. Add image artifacts to output files and use these files for qemuimage.
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

Summary of changes:

meta-zephyr (master):
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
    zephyr-qemuboot: Use image artifact file in qemuimage
Sandeep Gundlupet Raju
    classes: Move classes to match bbclass scope functionality
Sandeep Gundlupet Raju
    zephyr-image: Add image artifacts to output files
Sandeep Gundlupet Raju
    zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
Sandeep Gundlupet Raju
    zephyr-sdk: Add new inc file
Sandeep Gundlupet Raju
    qemu-cortex-a9: Fix runqemu errors
Sandeep Gundlupet Raju
    zephyr-kernel-src.inc.jinja: Update script to generate srcrev

 README.txt =3D> README.md                       | 163 ++++++++++++------
 meta-zephyr-bsp/README.md                     |   5 +
 meta-zephyr-bsp/README.txt                    |   1 -
 .../conf/machine/qemu-cortex-a9.conf          |   1 +
 .../meta/generate-zephyr-machines.bb          |   4 +-
 meta-zephyr-core/README.md                    |   6 +
 meta-zephyr-core/README.txt                   |   1 -
 .../zephyr-qemuboot.bbclass                   |   6 +-
 .../classes-recipe/zephyr-sample.bbclass      |  10 ++
 .../zephyr.bbclass                            |   0
 .../zephyrtest.bbclass                        |   0
 meta-zephyr-core/conf/layer.conf              |   3 +
 .../zephyr-sdk/zephyr-sdk.inc                 |  35 ++++
 .../zephyr-sdk/zephyr-sdk_0.16.9.bb           |  33 +---
 .../zephyr-kernel/zephyr-blinky.bb            |   2 +-
 .../zephyr-kernel/zephyr-coap-client.bb       |   2 +-
 .../zephyr-kernel/zephyr-coap-server.bb       |   2 +-
 .../zephyr-kernel/zephyr-echo-client.bb       |   2 +-
 .../zephyr-kernel/zephyr-hci-uart.bb          |   2 +-
 .../zephyr-kernel/zephyr-helloworld.bb        |   2 +-
 .../zephyr-kernel/zephyr-http-client.bb       |   2 +-
 .../zephyr-kernel/zephyr-image.inc            |  21 ++-
 .../zephyr-kernel/zephyr-kernel-common.inc    |   7 +-
 .../zephyr-kernel/zephyr-kernel-src.inc       |   2 -
 .../zephyr-kernel/zephyr-kernel-test-all.bb   |   2 +-
 .../zephyr-kernel/zephyr-kernel-test.bb       |   4 +-
 .../zephyr-kernel/zephyr-lvgl.bb              |   2 +-
 .../zephyr-kernel/zephyr-mqtt-publisher.bb    |   2 +-
 .../zephyr-openamp-rpmsg-multi-srv.bb         |  23 +++
 .../zephyr-kernel/zephyr-openamp-rsc-table.bb |   2 +-
 .../zephyr-openthread-echo-client.bb          |   2 +-
 .../zephyr-kernel/zephyr-openthread-rcp.bb    |   2 +-
 .../zephyr-kernel/zephyr-peripheral-esp.bb    |   2 +-
 .../zephyr-kernel/zephyr-peripheral-hr.bb     |   2 +-
 .../zephyr-kernel/zephyr-philosophers.bb      |   2 +-
 .../zephyr-kernel/zephyr-sample.inc           |   1 -
 .../zephyr-kernel/zephyr-synchronization.bb   |   2 +-
 .../zephyr-kernel/zephyr-websocket-client.bb  |   2 +-
 .../scripts/zephyr-kernel-src.inc.jinja       |   6 +-
 39 files changed, 243 insertions(+), 125 deletions(-)
 rename README.txt =3D> README.md (60%)
 create mode 100644 meta-zephyr-bsp/README.md
 delete mode 100644 meta-zephyr-bsp/README.txt
 create mode 100644 meta-zephyr-core/README.md
 delete mode 100644 meta-zephyr-core/README.txt
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyr-qemuboot.bbcl=
ass (92%)
 create mode 100644 meta-zephyr-core/classes-recipe/zephyr-sample.bbclass
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyr.bbclass (100%=
)
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyrtest.bbclass (=
100%)
 create mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk=
.inc
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb
 delete mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sa=
mple.inc

--=20
2.34.1


