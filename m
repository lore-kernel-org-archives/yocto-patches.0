Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18E3CA0ED1
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:46:58 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.75])
 by mx.groups.io with SMTP id smtpd.web10.57312.1754941611545391323
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=EpZ4JIy3;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.95.75, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irXIdSW/ifMBk/vOcsqwMADA7lF4qkfk/qIzRdQEfqEM8vlafCcmdTVnNY/N1Gn+GyOUUPYXl2GBHp/PJEWf0+3v12ADUgX5UurZ11n3hblZu7T+veKxGVgTE5PZJZ3lhKE71nAD3mBq7WVhC9v0iCbt2/nkRe71V0PG6gqLVzDCpc9In+rYFWptUWa9spu4poUhzWBjnBG0t0xQb0yzVDuXbZy+tmBstflHvRE4eY16N2qZ6NJSW2zAIumOX+1uw9l2NVE9K0TYOaKqEqK7kcmGtf2gihB/PepJSLNRxn5uXhtmAW0L1wjSKC//4Kr/POi7nY9lqiNcYcpDOcc5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcCKbr9mHNpOMap4J2Q/rjcvx0qxE/jIKq6CwE5VvIY=;
 b=XsCt5yUdDym6F7m3/fVnSvbi0d8S+jIArl1nouq2mY6CVMIw872/19VR60BFdniikFoy+EPaD+l/qrmlwVBymNQ9Sv4qBJ9z5WQBQIlmKdGKrBoX8FX2k7rfp9sYflV2LXx00VTSZo9NZm1ztqImqAhzbC4zmPIfhXLDGGD/SAQttz8icD1pSWqTHNBTkigjGfgmcfVWQLr5sVRR6AsWDHyCCGYpHiidcHaR7NLrFFEMXu/Wy2yTGIphjZ4DwHsiUxkeXgmZvwdTRzOE+3Qfx8S5WvzlalIm++kyI/FtGy1z6uu+8C0glmJdzbQ/iYvjVs85GksNqtl6VvD3h7bjBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcCKbr9mHNpOMap4J2Q/rjcvx0qxE/jIKq6CwE5VvIY=;
 b=EpZ4JIy3C9cslKtbmmG4NxhoBQJShX5rmsfVwLsOfIFO+de/a6cSjiBArF2FsE6dB5Jg+Ywsi6dWHXlxmN2K3hJJnylieHVmDDZSVY1ny4QMFZ1mqy/qVyLY0WpBpLmRvv/eXGHRbe+dWB51SL6KDwy43Rs3qUFKCzoX7DqMato=
Received: from CH2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:610:53::12)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Mon, 11 Aug
 2025 19:46:47 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::8d) by CH2PR17CA0002.outlook.office365.com
 (2603:10b6:610:53::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 19:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:46 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:46 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [scarthgap][PATCH v4 0/13] Update for scarthgap release
Date: Mon, 11 Aug 2025 13:46:33 -0600
Message-ID: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d2edfe-904a-4e09-4d29-08ddd90fcee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kvJV8kCasfi5LYxj3ikc2nvrQNED8/yk2ClS94ppibz31wAV2QvOU+76yUFE?=
 =?us-ascii?Q?HE0/JgvLfLi2qXuuJ0bnTQWgB0iZKL9a0vkwqfrzWgiiZ+6exR69kMBnPlpb?=
 =?us-ascii?Q?Osa1vvzUNVgVJgjU08n5tQ2gx0AT20yTbtdzwhfwAq9Er9inrbLgyqqGuwWo?=
 =?us-ascii?Q?5x/tdR32kj/5OJtMjfacqaRqcsKTznVMk4ps2AjIW6b/JukzBUJab4NyXWYn?=
 =?us-ascii?Q?C8wmVJBRbyJnSxPnm3RWECcEMJsktClP7z83NsPFStQOvuO0jvwwClKqwn9+?=
 =?us-ascii?Q?yDsNbFNyZcsBwoFpbSBA/CUHIM3KZxeb2vaFj7oyUTy0JJOF4yv/zy5wQOuc?=
 =?us-ascii?Q?GoAaDsmuL5J0LJ349WdMkeHGzPvyyT4RoVv/+Hn1kWLaBl0zrNWJMGVD21Ka?=
 =?us-ascii?Q?aYO+7C655QhQ1E3pLJft1Qz3T8J/UWj/dYRVNzXD9SFezqdHIF8frALVJ9XL?=
 =?us-ascii?Q?54gmfXtvkc09QHlZ1HS4ahISxvbILWyF1SBRgYbRUFq9vma1nZfz4WFDPglI?=
 =?us-ascii?Q?KqlXo4rlx8Ze1x6RS2rX1AdZ+Zbov/iO3DnZ28Cn3i+/FaLdRzA9TUNQLvUs?=
 =?us-ascii?Q?mruTY3fykLWlwhgi6tec8dMm0m7GGeSNPDflx0cT9A9y39EU6i2UdPB4iAtC?=
 =?us-ascii?Q?rr+tBdExSxHsNTHxllQco+ZynXbldjP3h4T9ql0Z54ftTqH7SCrgmbwtymA3?=
 =?us-ascii?Q?tD6GMDj12X7y0CpANkLz4l96D2QKFLfBvam81sNXTt6GDoVlfuQcSrHlzSEl?=
 =?us-ascii?Q?5BezkbtYsCDsFsHvizoDvNxAa8iGZ5yLQ2uVHq6sszPAqqcJPC/aYyhUGClp?=
 =?us-ascii?Q?OwhND7NZaNWNP6cCEcvA20vZ5+W4XXT/eFnFB0bWGImL+XDwoux59hplQ0/f?=
 =?us-ascii?Q?RWAXChTpHKl35ROwYkL8EWvazu/emhRtFsb8FipKRDAGZwfTFF/Aahoe19tN?=
 =?us-ascii?Q?3qAHNPbG3lEoBt6rNaKqipyDk5gD3Bwmgs2GeRiYSw6dWZIEaOJ/DiQAu1c7?=
 =?us-ascii?Q?fSZkGAjvuyV4xTA6bUI2qrbvprtn3vmwv2GmHHpk5olk2eKJHdoYBXkZwXku?=
 =?us-ascii?Q?T3YbOBN+L+Cc9+bMKtMjlzRvI4NFDFVGpqSAhnQ0xeNlGJwupzBigediBJYe?=
 =?us-ascii?Q?PwIjV1yRUmvA6jTkl0st3AhqYATX854UX7Hiquqwn+aC3E9PFzHQNTKqgdkO?=
 =?us-ascii?Q?VMTlueEGpc7wV+uVraNYFpm/2Ju5zwOqii9bdHpxO5hCwFfNYk48fhwrYDP3?=
 =?us-ascii?Q?tMi7Qamo7nwjhde/wSKDJS2Gdnaj5tmr9yO+i/QQLC9HlLa9NvsZXiw6W6l2?=
 =?us-ascii?Q?srW/0mfK6e1oL/n5cX1Aaq5llvzwTSszv2fGHvoCB1/X+MZm0QFPzi+Ow7qY?=
 =?us-ascii?Q?BH2Nuuot7+mbwORgfVNteJwQMiZmfziD/IOLfhdgOeS+HJpGreEC8c4uTV57?=
 =?us-ascii?Q?Z3+lPDvVS2AKi+ucs17oW2bwnxfSm6WFL6rf9pzBGrdRSyIvfzwf9aTNUzk6?=
 =?us-ascii?Q?qaKtjvelY4y0Lj+Tf4ArpvAPeXSG5c1ufee/?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:47.5003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d2edfe-904a-4e09-4d29-08ddd90fcee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1944

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

