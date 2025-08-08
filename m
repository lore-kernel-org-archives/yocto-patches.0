Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4736ACA0EC6
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 17:58:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.71])
 by mx.groups.io with SMTP id smtpd.web11.29081.1754675919737199627
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 10:58:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=d9dGkXi4;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.71, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIemX4dVokQk4cNjyDqZ5im9/cS8i6a0GORe5V1sxg+7AmL87s5vS62n0uNfioW7iBVroYEirl/Aon43oAvVP35nBOSyouXpGhaZ+yDSGG7ZsMaVLKkuPRnDTVdlndGYVnD94lsVVqckmvqW4WqLZ/hbVmffnNlm6/3JrqjiEAtxsCleDx0GDfDpsI+rYkjeTL3JaSeuiudglRYMnNlqk/DSdeIPkUrJ2NYslcCDQwp+dOzSxS2CRKTwv10uWBiJJlHJW0JDNezuE5iL1WsLBYR/8ie4A9hcr6smwikUHj4DoUBZxTTgbGLwBlrlpb133yDDBG5vhBLB2EAojnVirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zQit/NfBOd0ObadHTX4l+EslAC1p4AbtkmnouigN+E=;
 b=YXKnLkXoaxo0HOe5OurIaXk9azfh8DeHmJzRtkFkuENFqJZvpfE8PeMJCgMbv9yJB1QtVScQi7dP5bzXqvpxMlmaKyHQ2LStY2sDWiN1eoSmGmXAKWYYZOX7ARUznZ+5IhL/NoAQzaY1Zom69BubSJzhWw/XDe+jJ177Ydhr+SE2k70vyJ3obva86/lfAis/FULWS5tK3fVnPQBE7tt6BSAQCRxxCd2VHja/WHhdsr6RLYCFRokl42ZibsoFdb+eopBc1R1IEDO5vINMmvdZ2Wi7l/EBs+WwtyEPB1NXoEzazD5UGLAcivMeAF5zQ+bbLpGe1HyYOk6jabpqhxBdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zQit/NfBOd0ObadHTX4l+EslAC1p4AbtkmnouigN+E=;
 b=d9dGkXi4tVanCmfuMq0DKKylpI6nqTOlOadjtB29MaR+U7XtwaqePwBQvBdlU9MFVS6cWKyO+V7lZgY1GKzraqLv+YmQrxDyDbL+s3J/XUrQyveIKrwQTbEdfH8Ew43gpRWj1W1qPo3mD1/Kyhzs48DGc3HnXjKGyI6eSwI8ijg=
Received: from BYAPR07CA0097.namprd07.prod.outlook.com (2603:10b6:a03:12b::38)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 17:58:33 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::ca) by BYAPR07CA0097.outlook.office365.com
 (2603:10b6:a03:12b::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 17:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 17:58:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:30 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Aug 2025 12:58:30 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [scarthgap][PATCH 0/9] Update for scarthgap release
Date: Fri, 8 Aug 2025 11:58:20 -0600
Message-ID: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: b98c1478-b55f-49ba-027e-08ddd6a52f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KQCFT7NeHN85pddqyyVtUb5XarU5X26UIEMCkGK4lrMgV8Rn0GiySpRDmnKg?=
 =?us-ascii?Q?Tsjwho8rHt2RKnVasWxv92lwVeESYBZ9XCBfV5qJCc5YcK0vp2KDgbJWmVd1?=
 =?us-ascii?Q?qHZ9c950ITLAzQSELseLu3oIG5KVZ08WuKl7RvDmDOX6Z5qRceGnr1xOwrBT?=
 =?us-ascii?Q?uDVNbrXi8cvDbLHnYHXtlq2wVjTUVx8FbuQUNiKhBr42XmYJETrQrnRUCecU?=
 =?us-ascii?Q?Nx46xYNY+43iaNhENkxfqdsSxKQdikeQeJSajBDhxBuzgwfTuySiaz+BRygB?=
 =?us-ascii?Q?f4gqYj6UQNT5aqc69j0j/jKRuqc0VoD3W9PTJDK9Jwr+WYcpWx1l74PtQ9nb?=
 =?us-ascii?Q?NNpcRNBn6q2bW3Sf6X4p+f+Ww99L0yt7nGCujE3BrCn3NMHc0wOfXvcO1yJL?=
 =?us-ascii?Q?cxV+WK4S4mqAyZVuNSefwP2jMc9qLpfxvxW6Al7ZP9C/Khe3pejTy9NrVKhv?=
 =?us-ascii?Q?lWnPU7J9JN/AFw8/FN9ydrLZ1RdRbaOxB1omr0cE7FV+EiX17cGs0Wm85hFk?=
 =?us-ascii?Q?lyvhI+C4NstHB0HwbljstxLjfvdMTudHIKMCpo1RuRaKPV0aSDneBUKKWDko?=
 =?us-ascii?Q?4yjwmkFjvvQO4ODEmaEZltbwBnAKEoAm5BtvoP71IMCHr39HVTZjge2p7HUE?=
 =?us-ascii?Q?7VrXo/1iwfeY+DP5uJJaHrUIufoCwoKA/zc5jUb57LZJ4HrAzLPpQwlHVrcY?=
 =?us-ascii?Q?4XP5cTmY2agWCxgULey7N2d+VgPp4Fh5nTHQIihevIN70NE8AMLJ+e8BaaZ+?=
 =?us-ascii?Q?kFC+rxFNbfIsVxz3Pvmx0ndhICAGWl3jalGF5qRKYVNDTC/ezZUU1PoyMlha?=
 =?us-ascii?Q?JdaSdF7OMKEmT7ZcPlXRa9NeoZ8Kf3Ksnl5043oJkXPaT0bwZdMAUnCoQ2O0?=
 =?us-ascii?Q?HeIi8m7QVzPw0POhjcc1FfkS7xGCXrOZftila3gy6ZtUfFfy1RMGojYZQHv+?=
 =?us-ascii?Q?yGEm2dQvfZAwJhPc8GA1m/72MfPumYKMar2030RHzEiuUNellMVmzZ55GHrP?=
 =?us-ascii?Q?WE8DbdA4tDC0a0ilqLwz36/0k0H6udqsdJYwTZRMNCvx4E8TJkQrZ+Gmf9u5?=
 =?us-ascii?Q?XMbdzD/r7y6ETBv5B13DHUhPtN9Ek4hKgXbFvV9st5O6NTlgjt++schWOgCT?=
 =?us-ascii?Q?7BeBVvk9ACIAxtVVORAT7CVGeS7bTcEHuYN0rfCkY96ChwKK/zO2JTJKS663?=
 =?us-ascii?Q?RmbGwKs9cs8xON98HK0ELCufSlaVUY1ZwUJF1uT3wRZJNnKJ2TrFUFAavezl?=
 =?us-ascii?Q?WdOtcaA4+/K0ZNABPd63vgr0xCLCDyvNktOyYPD6dQiRw8uhaUv+NYVe9I7Z?=
 =?us-ascii?Q?Gy2XV1qnm2F+ANsCHb/qPEINUSRjrXqFcdc8YYDqZK7wceyxfKW9XLpWBjhr?=
 =?us-ascii?Q?35QaKObGTzb78Odf+kfm5yVPx6fclsVvAByn5iFAM2bZ4TWGmFrx3WOfTCjH?=
 =?us-ascii?Q?+Q9K+J8Ex/NfdTF2Lgc5akIOLVCH4G/ZsFsrwcTaefrZtFo9P+sEIf/+zJuI?=
 =?us-ascii?Q?HlNlH6ASFrasgC4HKY4mEs5nemHKcrKkTD9b?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:30.9084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98c1478-b55f-49ba-027e-08ddd6a52f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 17:58:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1905

Description of change:
1. Fix runqemu errors for qemu-cortex-a9 machine.
2. Add new inc file and update to 0.16.9 version for scathgap
3. Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src and
   move to layer.conf
4. Add image artifacts to output files and use these files for qemuimage.
5. Add Zephyr LTS3.7.0 support for scarthgap release.
6. Update README files.
7. Add rpmsg multi services recipe for openamp.

Testing:
Run the following commands.

$ MACHINE=3D<machine-name> bitbake zephyr-helloworld
$ MACHINE=3D<machine-name> runqemu nographic

Summary of changes:

meta-zephyr (scarthgap):
Sandeep Gundlupet Raju
    zephyr-kernel: Add rpmsg multi services recipe
Sandeep Gundlupet Raju
    meta-zephyr: Update README files
Sandeep Gundlupet Raju
    zephyr-kernel: Add Zephyr LTS3.7.0 support
Sandeep Gundlupet Raju
    zephyr-qemuboot: Use image artifact file in qemuimage
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
 b/meta-zephyr-core/README.md                                              =
                                                |    6=20
 b/meta-zephyr-core/classes/zephyr-qemuboot.bbclass                        =
                                                |    6=20
 b/meta-zephyr-core/conf/layer.conf                                        =
                                                |    4=20
 b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc             =
                                                |    3=20
 b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb       =
                                                |    4=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-3.7-x86-fix-efi=
-binary-generation-issue-in-cross-compila.patch |  106 +++
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc          =
                                                |   28 -
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0.in=
c                                               |  274 ++++++++++
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc     =
                                                |    2=20
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi=
-srv.bb                                         |   23=20
 meta-zephyr-bsp/README.txt                                                =
                                                |    1=20
 meta-zephyr-core/README.txt                                               =
                                                |    1=20
 15 files changed, 559 insertions(+), 68 deletions(-)
---

