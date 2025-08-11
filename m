Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154CACA0EC7
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 14:59:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.68])
 by mx.groups.io with SMTP id smtpd.web11.49945.1754924390975412234
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Lz6RYGzG;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.68, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcw2yLRvAVT82WvtC1gRc0n9L/QmyNot0oIOcJxzBsgktcqQD2VYPMFsBLZpdzMXFX0i5D7QgUcEnPOzk+zwDpMipR8hblgccAHHg3O0outhVusw3Vh70fYI/XyUn0Qyo7w1jznKqsY/8sljE2uwnpSPQL2ymQFFoZJ2JUF382me0rf3Ekbls/3iDyZtYw0QtLuBwVg/ZzgXgbT3oWkVSVlkpoLnEf+mpe/0GC38fSOHI3ReYqSDzbp13nbLJo+0PTpOSSlv070m+6abPhCzDddALfS2D+Qdt1alnAoULhNO/JRQcB/FSYQJMiw8dlJd3yiUduBekIGIcgCBXoznqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VeVf7vdMnldrtd89OdK6my86dxr2pBw4oUJ6eNenI0=;
 b=PKKxPmIeIZazDUdGQOrHZ/NY+2km0DGa8+qayz6r91wScviPVC262tCl498xjGc0A/O4QNsK0ATXmHQI3baZNXUiFcylPX59/7K2KdhblcxkSIADWgfezIpPjQoazBC4TKIanW5pJd9TeRRmJjF4hJ8WFFTd3NnqXvchJ1b4xgPKbjraxz26JROtlgh+056+Dfcr9LR9eI17WF0CWBBW+5M9lwtJbrmJlOFW2ACF9MmFIJPl2ceL7a6W4tjF0F2JKPHiho6boM3B79y98lGoNZFO/uwWbCVfEBzy11EElGPh+q4dMZ/2fkL4pOuk/maB4NWAtgoqFHtvU5GLA9EtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VeVf7vdMnldrtd89OdK6my86dxr2pBw4oUJ6eNenI0=;
 b=Lz6RYGzGj7UylGeSrYhHOCXVU8pV63UAsIefE+l37pZBo2MyJJftlEAwF2+MiyHxkK355TstzEbslcCyVMM6VlIecmpfHxKIOwy1dH9/Q9sfPVcNt2bFJMGYPRaTzaPiDoRpoB0w94H5HtH26yBVREf0737G6O8jGWBIkQuHJ5E=
Received: from BLAPR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:36e::24)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:47 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::4b) by BLAPR05CA0019.outlook.office365.com
 (2603:10b6:208:36e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:46 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:46 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [scarthgap][PATCH v3 0/13] Update for scarthgap release
Date: Mon, 11 Aug 2025 08:59:28 -0600
Message-ID: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 93937bd3-a010-46f1-865b-08ddd8e7b6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WxjKknX7AYBvVy7iowpggBRJ9GqBn/qdK1ub2jsekHRy70AsnCVPRm5oe8aF?=
 =?us-ascii?Q?wh7tFqN8JnjdAGHD6xEmqYm5PHLQ+SBeSbjnxeFsAaZKYiAwWrg9kNVX6DhW?=
 =?us-ascii?Q?eDkHnlqPDgua3ELh0yLW4mllyHgQJfNoG/tbRUKtxkl8frG0DorWh8SiXFUk?=
 =?us-ascii?Q?sIY1/pP8hqA0chylFwBesueaC6JPir98aDtEK/58DIY836XSeDP5dgdrKZUg?=
 =?us-ascii?Q?Qok7hTqkmiICY4HFIG9QPUq8UEibB0LXl7XVGGfxowyFw4EtMs18ToZNbJ7l?=
 =?us-ascii?Q?S26aWztWBLod97J3xTc2A33+Wy0Ek1LHSUJElIWs7yRLKYlgmt8oysBlh1L1?=
 =?us-ascii?Q?jpPi5MhNWE9RIAJVrEY93gbm5XzbcrNjb1/eSoz8c8KFhmB+IlonL/MPdLuO?=
 =?us-ascii?Q?ux98jqQxX946mu7QZp82gBXGJgtKC77y6zAXJYc3ryZKeIG67msRHjJbOKCi?=
 =?us-ascii?Q?uwx8OqL67RWBOxhfKUfbU94rcRSAh5F4RZcFe2kdZwp7n1hFBcWW4vONNG/O?=
 =?us-ascii?Q?XS06hn0SNfIyHwaJBQZQyhonnIkQ+r5o8svPETT5fs+xNAtsC8iaHISj+JXe?=
 =?us-ascii?Q?Ic5EjW2am9axa1+NXH2uL+Cp28STvcSkUWA3p2sBuMlrGki1wFCgN+mv0DUd?=
 =?us-ascii?Q?Y1aTPCX8W90dXlUXYi5c0AYudjf0z7qqsIPCvhIkqZmkEzCmg7eOdwix1VTu?=
 =?us-ascii?Q?nMbEivaD5qWL4pmFPl2rnH1+4d1ehm6VibNbN6J8EmpHw6KkuSlHACcdVva5?=
 =?us-ascii?Q?0PDk8POfGdu0OGKPqvuUxmAqnLXCWzj49LnXc47Gi0o15AWIlBgdKnW8Ppyh?=
 =?us-ascii?Q?eTr2JrSjvd2b5rXGF45OdFy+VcyYAB4IJ4CkLW23OindKE8g8I76FLphROKE?=
 =?us-ascii?Q?36T6Tqve7XjjKaXH+XornxCJbUx3zP7TmUIRZNhN+kOvtNHq/fEOfXncTA5V?=
 =?us-ascii?Q?HOMJDn4LbH9DfqqzrSIb85sTFRIu3TdYf680PGgwNmDuhjWQ/dbw/MJE6U7l?=
 =?us-ascii?Q?NpVa7Nb41TYIkZgAVQA2R7STr6nATBzoBkkmz2nuBCNSRfw2yUs8I8lzDBiD?=
 =?us-ascii?Q?ijGrom53XV6JkE3EQhNexFMLm/XUq6u1wb8nHV3EqI7rQBr4TSKbUBJ0LNiA?=
 =?us-ascii?Q?dRzN6QQi5W415UmNSS6p9GMGiPoa45qRhDYCzM0d+EsecOMDPBjZ40zcCQg6?=
 =?us-ascii?Q?hJTxcholSywVRnpOZFPXcmke6czULxKpGLBpq0sSDwEb2moDcUdWkjanD6vE?=
 =?us-ascii?Q?MUtw8dOmQr+o9apc1QmubvBOonSfKUsVRo7tA5uGgwUbes/siE7GR09XD/1+?=
 =?us-ascii?Q?TJjW2z3x20JyVgwovtYjaxCqj7fz5WmDvjvERv396TUiPAeOSICrVyiZAKJx?=
 =?us-ascii?Q?IZ2jZBlQ4digwqktBHU7PvdaAfgmujQKzr5FLG1QnuK2zKiUmeEZw+cvBDZv?=
 =?us-ascii?Q?9d8TMdamXjfjzgY0jNs7uMaIRqZmeYN7Ci0SPqFZEMK15L7rfnUw3po69qLY?=
 =?us-ascii?Q?LIZW9v8ogVuXydu2k15B0s3JFYnDSw4y5QlN?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:47.0223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93937bd3-a010-46f1-865b-08ddd8e7b6b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 14:59:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1931

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
 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc    =
                                                |    5=20
 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sample.inc           =
                                                |    1=20
 41 files changed, 599 insertions(+), 95 deletions(-)
---

