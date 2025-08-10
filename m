Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F745CA0ECC
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.51])
 by mx.groups.io with SMTP id smtpd.web10.36651.1754869171886048680
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Gyp27NSy;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.236.51, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cG3KBUNQewyJYu/EMuhI4v2ItIm+b9wFSqqvWbhgcHKKQz4u9Jjw0egpqCLH96CyXv+UN0FYH0nlI8zyxT/HB2up/sWpbL38HndpXqslVo4viAM5oZLyEbF/goIWWhCsq6FoC5WHJ9wjjpsxZ+7BCVq4f6HqanAkARoYGpGjaTS+lxkrpQbm4re9xqC8znzdm8AL0gxUgRQSCPLGcnLjFXadm3Fs7l1d+VhnvZYwJBT2GHXxeu9U67nUlNB4H7HXJUVuKkjjZwcufYY4QxZ1Dl3BWPtGElxRYh6+AIDzVa6qadpcTVhCphPsHj8hc8Lnr/14580fz2hLyrvPEQZH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISs6cuvTFdN7VCuELhR8XI1pTHN8m0TeLRCYXAYPsKk=;
 b=lyLEEzLeJ/jn08jK9PHDv8ssoFETeVjAHXkzUYdJi7INqt0Jc5VLKwLtuDhIkrjL8FAs7Y6ShNsbsJH5U3nssJrSqK5jAjojx8NpnRxGva6PzV9frWgIcCANcks6EobzSJgsmA6b8gt9qQXE2Nh5ZRCASWiXhoaEXc8IEQFi0rYhvVsl/P2NcCD9PxcOc/87bhcsV7HKl1J16tuWikEiw/iNTunXAL4Z87Ti9qbl4irGWKfR4wXK94zaRTHuQllLCjIu6jR+4quhlETfuvTmss75Gc9YvWyVOqsxHTcgyJMalGVRwM1oezh5bknxhXqyVe9KEs3geJvkDSzDm9rbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISs6cuvTFdN7VCuELhR8XI1pTHN8m0TeLRCYXAYPsKk=;
 b=Gyp27NSyJxfBac7IrRGs+l33pCbHGHePNMV2iJQPWMr8wOqlEYjUVpcgVHPGfTW4AUeyOpy9qOUeR6M+KViaIDx8WaFArpEeHD61JUoqNgoks5Rs86Zz6rQJhgQTxHc73h7xbyNXhY4nRNMCphM8IWjfW2IA5/cMKUNbmZcKvnA=
Received: from MW4PR03CA0069.namprd03.prod.outlook.com (2603:10b6:303:b6::14)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 23:39:24 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::cf) by MW4PR03CA0069.outlook.office365.com
 (2603:10b6:303:b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.20 via Frontend Transport; Sun,
 10 Aug 2025 23:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:19 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:19 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 9/12] meta-zephyr: Update README files
Date: Sun, 10 Aug 2025 17:39:08 -0600
Message-ID: <20250810233911.1259884-10-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
References: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 23944bf2-f99a-40bb-5eb9-08ddd867231f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jIOOe4K6uH+OZrbbpPfm7GaHrDSV7Hp4Dbc+5GylXJSjhQ882V5XTfdWo5Y1?=
 =?us-ascii?Q?ltF52ktcQK2gLN0aZg2sfEn28DXNU+Pzex7J77aQhtijqSiguuyhVGJ7lNr0?=
 =?us-ascii?Q?zW2KsyfCgH+t0LeChIrIDcRbQ96sfzCwWeiUuLIS03nj1quFZLqZSljPHTZ7?=
 =?us-ascii?Q?4Gz7/CVvoYahDC9j6WKwYXcf+9eIc/RlQXwAx9q4H+CH8TFOfItcNhePjbSA?=
 =?us-ascii?Q?sPnQRRDKD6j4dJrxfdpcCo6zh7ZUROclNgRvknCsrrgDeiwkVxICq12U0TWp?=
 =?us-ascii?Q?xd/M5BUZB1Ji0fBdAqNim2MnL277rwFhUj6mEB8mr71S6dIjEPzeNS2GQYAQ?=
 =?us-ascii?Q?viVxubgxdi3w9P9//NpKdphg8UkYAQRXFphyzodKZk2I0Y/SrL9xG0Ks0MQ0?=
 =?us-ascii?Q?Tjjr1TBlaaU8JOzmCcjM949j1qCiCrnN89P0oAr7rlyeHpYlEmLJVi5whjAX?=
 =?us-ascii?Q?NH6oFYpFB9JN9+w5tswhHK6nAF5xKon5doy6Prejl7qi6t5XyQGXyav1F+tT?=
 =?us-ascii?Q?vzQw2avkqHbvW87p+MPZvkS8eILbeK6mjGr//H+KSjdl2Bqx9p2yjmy5LfCb?=
 =?us-ascii?Q?0eXt+FECUqAOE8RXKliGlsENAnKW4CMNuH+f6QiXq21o8WOa9FOknOt4OTgU?=
 =?us-ascii?Q?7FZpApgsUUhfkFeA6rDNoPS5NpTF7pRWQi7IHGKsiKE0kUhSUDIti3eY0VvT?=
 =?us-ascii?Q?aCqbgx70hNjSX+QvSLlkIDCsxSiOOurii5LFjbSsBAo117PPftelYr1naIa2?=
 =?us-ascii?Q?52c/pB19fPU0tGGJg1c006i3aFz5p3gs96mHqfn0Qop3jZcbWG/bPap97bxM?=
 =?us-ascii?Q?3N+0Hr6QX6RXKZNCh4rpV5mT5AC6IpSO6txc5ozdZNmadpjQaMcM7kFQxydI?=
 =?us-ascii?Q?G2SN0bebrD1DIGnFZg71UpTDeMSg5nyAMWMMUlDq8d5Wf4v+zjcyVDUcD4SU?=
 =?us-ascii?Q?NeaX9JPRrqi1U0SBCeTBTRNrCWwCfKzqXSkarolW+m21n1UoB279srXPjtix?=
 =?us-ascii?Q?SAKTzGoXGQwTLQPrkM6NLZkwaTMr+NS0ARXUbgREcupKRCmZq0R0qCtF3ul8?=
 =?us-ascii?Q?fHmVSwkzbAEOe3i0nIJDBXvhuTuy4Fol+Exr+kV/VY4R067rQgOaangcUlgA?=
 =?us-ascii?Q?Fbv6RsemmfJS5ODhQDF4inGZC6SqiRu8X6JoCNwPIMmXSGvzIkIqS4om55Bq?=
 =?us-ascii?Q?zO3Krz4tnmh+80bqV+G5MSxc/3OP05NiPY4dPh8J/KLczXOLzneUkB4W73E4?=
 =?us-ascii?Q?i/aMZKEtu0lW5SjStdIxXk4C6Uj5mSuxx5hiAnhOjnMofbLG9BtFs1EDJrHS?=
 =?us-ascii?Q?FwjxQNi1blfn9AtoT3EI+F24GI7DGISG+tf6bxoYW5YG6ya9g7faqit/GtRd?=
 =?us-ascii?Q?kC0WgjGV3V5r9jB11uQOXOfBQZmTOSLzrS0WehePYPmXpH3SvGFjcNiPGJrF?=
 =?us-ascii?Q?Zkf1w9GxCZlzc6yKnWCHqPSz5/v3HejpH5zdxA45B/YnPrpxHVUStg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:23.7612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23944bf2-f99a-40bb-5eb9-08ddd867231f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1921

Update README files with following.

 - Build instructions
 - Maintainers lists and patch submission

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 README.txt =3D> README.md     | 163 ++++++++++++++++++++++++------------
 meta-zephyr-bsp/README.md   |   5 ++
 meta-zephyr-bsp/README.txt  |   1 -
 meta-zephyr-core/README.md  |   6 ++
 meta-zephyr-core/README.txt |   1 -
 5 files changed, 120 insertions(+), 56 deletions(-)
 rename README.txt =3D> README.md (60%)
 create mode 100644 meta-zephyr-bsp/README.md
 delete mode 100644 meta-zephyr-bsp/README.txt
 create mode 100644 meta-zephyr-core/README.md
 delete mode 100644 meta-zephyr-core/README.txt

diff --git a/README.txt b/README.md
similarity index 60%
rename from README.txt
rename to README.md
index d3694a6..16951b0 100644
--- a/README.txt
+++ b/README.md
@@ -1,71 +1,101 @@
-Building Zephyr Images via bitbake recipes
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+# meta-zephyr
=20
-More detailed and up-to-date information can be found here:
-
-https://wiki.yoctoproject.org/wiki/TipsAndTricks/BuildingZephyrImages
+This layer enables building Zephyr using Yocto Project.
=20
-Prerequisites:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+## Dependencies
=20
 This layer depends on:
-    Yocto distro (master)
-        git://git.yoctoproject.org/poky
-    Python layer (meta-openembedded/meta-python)
-        git://git.openembedded.org/meta-openembedded
=20
-Add "meta-openembedded/meta-oe" to BBLAYERS
-Add "meta-openembedded/meta-python" to BBLAYERS
-Add "meta-zephyr-core" and "meta-zephyr-bsp" to BBLAYERS
+	URI: https://git.yoctoproject.org/poky
+	layers: meta, meta-poky
+	branch: scarthgap
+
+	URI: https://git.openembedded.org/meta-openembedded
+	layers: meta-oe, meta-python
+	branch: scarthgap
+
+## Building Zephyr Images via bitbake recipes
+
+More detailed and up-to-date information can be found here:
+
+https://wiki.yoctoproject.org/wiki/TipsAndTricks/BuildingZephyrImages
=20
-Building and Running Zephyr Samples
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+> **Pre-requisites:**
+1. Refer [Yocto Project Quick Build]( https://docs.yoctoproject.org/dev/si=
ngleindex.html#yocto-project-quick-build) documentation.
+
+2. Clone and add following layers to BBLAYERS
+    * meta-openembedded/meta-oe
+    * meta-openembedded/meta-python
+    * meta-zephyr-core
+    * meta-zephyr-bsp
+```
+    $ mkdir sources
+    $ git clone -b <release-branch> https://git.yoctoproject.org/poky
+    $ git clone -b <branch-name> https://git.openembedded.org/meta-openemb=
edded
+    $ git clone -b <branch-name> https://git.yoctoproject.org/meta-zephyr
+    $ source poky/oe-init-build-env
+    $ bitbake-layers add-layer ../meta-openembedded/meta-oe
+    $ bitbake-layers add-layer ../meta-openembedded/meta-python
+    $ bitbake-layers add-layer ../meta-zephyr/meta-zephyr-core
+    $ bitbake-layers add-layer ../meta-zephyr/meta-zephyr-bsp
+```
+
+### Building and Running Zephyr Samples
=20
 You can build Zephyr samples. There are several sample recipes.
=20
 To use the Yocto toolchain, modify local conf by adding:
+```
     DISTRO=3D"zephyr"
+```
=20
 To use the Zephyr pre-built toolchain, modify local conf by adding:
+```
     ZEPHYR_TOOLCHAIN_VARIANT =3D "zephyr"
+```
=20
 For example, to build the Zephyr "philosophers" sample:
-   =20
+```
     $ MACHINE=3Dqemu-x86 bitbake zephyr-philosophers
-   =20
-You can then run the created "philosophers" image in qemu:
+```
=20
+You can then run the created "philosophers" image in qemu:
+```
     $ runqemu qemu-x86
-   =20
-The same sample, for ARM image:
+```
=20
+The same sample, for ARM image:
+```
     $ MACHINE=3Dqemu-cortex-m3 bitbake zephyr-philosophers
     $ runqemu qemu-cortex-m3
-   =20
-The same sample, for Nios2 image:
+```
=20
+The same sample, for Nios2 image:
+```
     $ MACHINE=3Dqemu-nios2 bitbake zephyr-philosophers
     $ runqemu qemu-nios2
+```
=20
-Flashing
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+### Flashing
=20
 You can flash Zephyr samples to boards. Currently, the following MACHINEs
 are supported:
  * DFU:
-  - arduino-101-sss
-  - arduino-101
-  - arduino-101-ble
+   * arduino-101-sss
+   * arduino-101
+   * arduino-101-ble
  * pyocd:
-  - 96b-nitrogen
+   * 96b-nitrogen
=20
 To flash the example you built with command e.g.
-
+```
     $ MACHINE=3D96b-nitrogen bitbake zephyr-philosophers
+```
=20
 call similar command with explicit flash_usb command:
-
+```
     $ MACHINE=3D96b-nitrogen bitbake zephyr-philosophers -c flash_usb
+```
=20
 dfu-util and/or pyocd need to be installed in your system. If you observe
 permission errors or the flashing process seem to hang, follow those instr=
uctions:
@@ -77,28 +107,31 @@ of IDs. Once that is set, the tool will only try to pr=
ogram these IDs. You can
 query for the IDs by running `pyocd list` on your host while having the pr=
obes
 attached. Besides setting this variable through the build's configuration =
or
 metadata, you can also inject its value from command line with something l=
ike:
-
+```
     $ PYOCD_FLASH_IDS=3D'<ID1> <ID2> <ID3>' BB_ENV_EXTRAWHITE=3D"$BB_ENV_E=
XTRAWHITE PYOCD_FLASH_IDS" bitbake <TARGET> -c flash_usb
+```
+
+## Building and Running Zephyr Tests
=20
-Building and Running Zephyr Tests
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Presently only toolchains for ARM, x86, IAMCU and Nios2 are supported.
 (For ARM we use CortexM3 toolchain)
=20
 To run Zephyr Test using Yocto Image Tests, ensure following in local.conf=
:
-
+```
     INHERIT +=3D "testimage"
+```
=20
 You can build and test an individual existing Zephyr test.
 This is done by appending the actual test name to the "zephyr-kernel-test"=
,
 for example:
-
+```
     $ MACHINE=3Dqemu-x86 bitbake zephyr-kernel-test-sleep
     $ MACHINE=3Dqemu-x86 bitbake zephyr-kernel-test-sleep -c testimage
+```
=20
 You can also build and run all Zephyr existing tests (as listed in the fil=
e
 zephyr-kernel-test.inc). For example:
-
+```
     $ MACHINE=3Dqemu-x86 bitbake zephyr-kernel-test-all
     $ MACHINE=3Dqemu-x86 bitbake zephyr-kernel-test-all -c testimage
 or=20
@@ -107,16 +140,17 @@ or
 or=20
     $ MACHINE=3Dqemu-nios2 bitbake zephyr-kernel-test-all
     $ MACHINE=3Dqemu-nios2 bitbake zephyr-kernel-test-all -c testimage
-       =20
+```
+
+## Generating OE Machines based on Zephyr board definitions
=20
-Generating OE Machines based on Zephyr board definitions
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
 We currently have a recipe called generate-zephry-machines which will go t=
hrough
 and attempt to create an OE machine conf file for every board in Zephyr.
=20
 This is run via:
-
+```
 MACHINE=3Dqemu-x86 bitbake generate-zephyr-machines
+```
=20
 The output is then put in the normal deploy dir. This recipe is really onl=
y
 useful for maintainers. There is currently no way to use the Zephyr board=
=20
@@ -125,14 +159,15 @@ you will need to run the above, copy the conf files f=
rom the deploy dir to the
 machine conf directory and then run your build. This shouldn't need to hap=
pen=20
 often.
=20
-Generating new Zephyr recipe versions
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+## Generating new Zephyr recipe versions
+
 The script meta-zephyr-core/scripts/generate-version.py is used to generat=
e
 Yocto configuration for a Zephyr version from the West configuration in th=
e
 Zephyr repository. It requires the west and jinja2 Python packages to be
 installed on the host. Run it as follows:
-
+```
     $ ./meta-zephyr-core/scripts/generate-version.py x.x.x
+```
=20
 where x.x.x is the Zephyr version.
=20
@@ -140,17 +175,37 @@ The patch files added to SRC_URI in the generated fil=
e should be validated and
 modified if required.
=20
 The new version should be committed and submitted to the mailing list as
-described in "Contributing".
+described in "Maintainers, Mailing list, Patches".
+
+## Maintainers, Mailing list, Patches
+
+Please send any patches for this layer to the yocto-patches mailinglists
+with ['meta-zephyr'] in the subject:
+
+	yocto-patches@lists.yoctoproject.org
+
+When sending patches, please make sure the email subject line includes
+`[meta-amd-edf][<BRANCH_NAME>][PATCH]` and cc'ing the maintainers.
+
+For more details follow the Yocto Project community patch submission guide=
lines,
+as described in:
+
+https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html#
+
+`git send-email --to yocto-patches@lists.yoctoproject.org *.patch`
+
+> **Note:** When creating patches, please use below format. To follow best=
 practice,
+> if you have more than one patch use `--cover-letter` option while genera=
ting the
+> patches. Edit the 0000-cover-letter.patch and change the title and top o=
f the
+> body as appropriate.
=20
-Contributing
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+**Syntax:**
+`git format-patch -s --subject-prefix=3D"meta-zephyr][<BRANCH_NAME>][PATCH=
" -1`
=20
-Patches for meta-zephyr should be sent to the yocto-patches@lists.yoctopro=
ject.org
-mailing list.  See https://lists.yoctoproject.org/g/yocto-patches for subs=
cription
-details and the list archive.  Please add [meta-zephyr] to the subject so
-the patches are identifable.
+**Example:**
+`git format-patch -s --subject-prefix=3D"meta-zephyr][scarthgap][PATCH" -1=
`
=20
-Git can be configured to send mails appropriately when using git send-emai=
l:
+**Maintainers:**
=20
-$ git config --local sendemail.to yocto-patches@lists.yoctoproject.org
-$ git config --local format.subjectPrefix meta-zephyr][PATCH
+    Lee Chee Yang <chee.yang.lee@intel.com>
+	Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
diff --git a/meta-zephyr-bsp/README.md b/meta-zephyr-bsp/README.md
new file mode 100644
index 0000000..e159015
--- /dev/null
+++ b/meta-zephyr-bsp/README.md
@@ -0,0 +1,5 @@
+# meta-zephyr-bsp
+
+This layer contains machine files for building Zephyr applications.
+
+For more details see [Building Instructions](../README.md)
diff --git a/meta-zephyr-bsp/README.txt b/meta-zephyr-bsp/README.txt
deleted file mode 100644
index 2644ed0..0000000
--- a/meta-zephyr-bsp/README.txt
+++ /dev/null
@@ -1 +0,0 @@
-See ../README.txt
diff --git a/meta-zephyr-core/README.md b/meta-zephyr-core/README.md
new file mode 100644
index 0000000..18db977
--- /dev/null
+++ b/meta-zephyr-core/README.md
@@ -0,0 +1,6 @@
+# meta-zephyr-core
+
+This layer enables Zephyr build metadata such as zephyr scripts, kernel in=
clude
+files, zephyr applications recipes and bitbake class to support qemu boot.
+
+For more details see [Building Instructions](../README.md)
diff --git a/meta-zephyr-core/README.txt b/meta-zephyr-core/README.txt
deleted file mode 100644
index 2644ed0..0000000
--- a/meta-zephyr-core/README.txt
+++ /dev/null
@@ -1 +0,0 @@
-See ../README.txt
--=20
2.34.1


