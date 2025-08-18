Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85CECA0EE4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.45])
 by mx.groups.io with SMTP id smtpd.web10.2789.1755554593508877785
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Q2Di8UCV;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.45, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clPK46tRVjieadL8Vv9jUZfpEu529/2jFxj6Hd8MmIJU8G24DXizjIpnNGpX4getDbynbnv24veogRizSG7/S60g9A+c26Zbe6Af5byzVP1VghgzFYj6iHIZdIOsPWHvxXzXkjHIl5cn4VhTNSmLevj5ccpRpc6Gll1KN/W6w8PYUqwju55ky37yxr5B5gSHXOKmq+9tgmXnksIugswIXC+Aiwb1OLxXJcz3na55k7CMKqL3VLBdFH5tDU6vFirH6YszPyiWAr02N+xNVMatZU7//204boF+CkxJb35dtPQIPPmLUN2oVkFtfUddXKGJxdyBYuCyUFrAwivUz2hzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISs6cuvTFdN7VCuELhR8XI1pTHN8m0TeLRCYXAYPsKk=;
 b=EmT3eEFcKvyYLfx5PIS+LJ9sGVRRdXhmRWapDxMuGe0S/1B3DUqbD2TzR+Da+AQIVmrd4WsSOwqZ5emcLHQBV1dwiS9vQa2m8nePSIXhdmVG6bF1x95h9jXPGKlomYDYyAftbLIO1WfrcRwe8rlsCZP4OtLNisZeJIashWDUeEYR5wabzW9/hEIu8cHYiswCA1Q0AbYZHENashG7J/+5ndgzOhY2J6FwMgQpnNM27lwWPBBVnZfo5AogGdCsO6iPudjt/fSiSRAsc9CNHq0lTTlzwFjOZC4ws/VC4BagzAEynrF2/Tj5103J0u/NPlhrr8wuISHe2zbaRv4RDMfw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISs6cuvTFdN7VCuELhR8XI1pTHN8m0TeLRCYXAYPsKk=;
 b=Q2Di8UCVVU9krIBrS/xxTBt3IbDOaPwdVYdrQVKyf9hlO+Z5C9d9gs/tzcHQVw66+hUvc7n4ge9kwBJFQSgg1ge51xwzR1B2vdkr3F2QzvIoOIGx+yDJkGExwimKHhbQGwR1DeoL2XvyLrz/8z3RExYFIlS+8ctBmPDQu+6wYTI=
Received: from SJ0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:a03:2ef::27)
 by DS7PR12MB9549.namprd12.prod.outlook.com (2603:10b6:8:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 22:03:07 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::4c) by SJ0PR03CA0202.outlook.office365.com
 (2603:10b6:a03:2ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 22:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Mon, 18 Aug 2025 22:03:07 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 18 Aug
 2025 15:03:06 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:06 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v6 7/11] meta-zephyr: Update README files
Date: Mon, 18 Aug 2025 16:03:00 -0600
Message-ID: <20250818220304.2300436-8-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DS7PR12MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 011515a7-0de3-4a97-cd06-08dddea3035f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OLSBQ/fWyG13Ldph4MuAIOuYzN7+8Bitxbt4AbUzx/uvv9XepAbRYXvhA923?=
 =?us-ascii?Q?L8OuzbnALR9TKLVRrgweDemjqwwpK6AeKYhasPWWMtMKhOJyWqSYAEOlvXwU?=
 =?us-ascii?Q?adJ7kOGEXijbWSzc/EyrT3LONyGp5ZAakaEro3oi3w8Q3ecIJpwDTNhiORI0?=
 =?us-ascii?Q?b6r3KkZr/l9rASS8ihmbbQpLNxOFgIbQuvZvEsAJhfLQ356OrrZOs+TFdgDL?=
 =?us-ascii?Q?SHb8NvcRX9Wi5sCWzuxuDOsYGsyLSHKjRa8eiAb6JNC8a/U7+xCWm9oi8rNN?=
 =?us-ascii?Q?GVhyz5P6L66Ks6sXOEm3BrWS8BqgrzhkC4WFI1PHpfOwWwSwFmx6TPMiXUw7?=
 =?us-ascii?Q?3FYI93vRK8pxJVwIurLH34/J3s/3ljmIigAZybgz6PXq+HctzIcwvKtjlSDX?=
 =?us-ascii?Q?JK2LMrs5JIlMV58lRpE2FWKD8toSRGnKpgH0AGwRqkUhPFZCaAkKz/RKnXox?=
 =?us-ascii?Q?s5Iy1yp9HrKHUKBCAqFI5D47JA1cdbsrAj5TksqhUWtjF1fFhXeuqN2ofMeP?=
 =?us-ascii?Q?0Ubaxt01a9S/lb+eY+7HFMcQilSb/OBPjiH03saPLqKsSTt5CkpakU/l4jp+?=
 =?us-ascii?Q?OmSo8nx4FNXBQ/DRSZjsB6GOiXy3Bh0mxgYn1qjW8xrZStar0hDzdU0oadNq?=
 =?us-ascii?Q?4zYXwYlyI1c+qu/pizF1BBEmqzhWwru2wIS7zylYVnmAR2hegy2uGHL7QGTl?=
 =?us-ascii?Q?SGiwsewC/b1iJzr5lQZnKFkAghapy2nBPsRzAtoyJHq5n5wHK3b68sryYU9j?=
 =?us-ascii?Q?9nf0F2vyniV72eyb47va7DlHmE4CFPA9B7XPGM0AuFgyU1ujX6AwdO3JUVw0?=
 =?us-ascii?Q?tfSI3z+Vet1Bp5XLus/E7J6pgs57omvsu0r5kXwfhF6F5vrtkQjZgBUM6Bb7?=
 =?us-ascii?Q?RxwU3uP7mLX/MtMGex9MSnRsJfluDxkv3bNwxpdiAOm6z+0oeXvMorGlsNFR?=
 =?us-ascii?Q?6hHsTbp6yJ39SmDvZEN1QiRpGp2I6VE+Fq2LGjLNLbzyjlG43lX+ja4ab/WV?=
 =?us-ascii?Q?GLez05o5YsIrop8zyBgkYKPwgTNmmRLi08XlFwmgLkvrRBibfmxA/T0d3m2m?=
 =?us-ascii?Q?2kpuuKmCe9f7QyOG2ieuDoRD3lUikGHs2FhZyQPXHEN82DqE0ytbWHIbViNo?=
 =?us-ascii?Q?KZJ9bQjyayUxbrHkOGcls/ZhnzW/2GIyn5RxWqT/tmNDTNl9G8Zo5bXL1sg7?=
 =?us-ascii?Q?cPwfPUDXaH9qWUytbhDqpeBAfEfOIBUf0NACiWezD4CdZ0c9BeBh7iB67B0q?=
 =?us-ascii?Q?0L3/399vP2zDtUHVPcjkCIiVCDbK7vc7/x5PgZrasf/35kkvY0/GA10gWYgS?=
 =?us-ascii?Q?mZaLF8auWG32aQEa2I61rwsD2Xoxm6Gsr67lWuNu7AeRJnHjFU9seOTer5MG?=
 =?us-ascii?Q?0X4KPjWNLZi/WDbaBpNoNWP2/CdJO+Eqdvwd3mf8SxQDrh3DU1OrJJEOLVrJ?=
 =?us-ascii?Q?zIbjqd6ATX4pq6g4GOoAxDJxDZX/zq15RgLsoQEmnV3Nni5vuKQbGsBBaAzd?=
 =?us-ascii?Q?d2FvCG3EDzRbb1s=3D?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:07.2780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011515a7-0de3-4a97-cd06-08dddea3035f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9549
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2049

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


