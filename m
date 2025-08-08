Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F095C87FCB
	for <webhook@archiver.kernel.org>; Fri,  8 Aug 2025 17:58:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.56])
 by mx.groups.io with SMTP id smtpd.web11.29083.1754675925206002555
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 Aug 2025 10:58:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=jfk3Tqos;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.100.56, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ck3HFqKe0oVDguu4Og86uegfUKFNuEoCLFwdnrOn7ZIFWtZYBK2NexGBV1rVGy0UV+cPy2lojxJwiLOmpn9XdF4PEDStVIBr+Dh+3jobMz3u9aekNlZzKBKaedzgPhHpcR7ufhCDif90htoOESBNJaxJf/gm3VNjd1eEA0vStGkaFYl3/uiKppkZgRcQ3VvciXILjptVsFqD2Ih7fAr1rV8Nri0s2Ta2xY+tQVRvcGy9glP/a9A6/OuDmSjkrzqaV9mBTfNqWE+e5fNH2Kg4W5H2pwkYhn+niRuQLFVEJh5/0m2dAZIDNXHb5Uzt1YKVdQLk1m4TBfQfSc5S2gg45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISs6cuvTFdN7VCuELhR8XI1pTHN8m0TeLRCYXAYPsKk=;
 b=j/nMbOLAxLY91MrHz+Ja0Q6bQ3F7BjL40zKbvmT0yPU5zoCzbpDDXI2X4nQ2P5Hu+5REiiRxYcHT/xnJcIPfW1VVQl5khuJ1xf0o7ycPOhuWhSEARUxlMl2zeaL9hJlhtf+scJMcRI79NSE9+vhn52SD1zVD2+hsNqkqQMj2roqOXj2sFogk0GVcNKt2DCM5N3WPulbUW3mEeIqnlS5FtofLazxaMNhVUiir79GUSN/HYn26vg9NTnc+xhOY5VNQJ7gyjVele8/hsncNOkuvGmYTB1Mgfbd9VZxCRmlqbG+x+iHx2J8UHWaE1+KU12xyJs0VJr68NuqnnFOJEDv0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISs6cuvTFdN7VCuELhR8XI1pTHN8m0TeLRCYXAYPsKk=;
 b=jfk3TqosqdPbaZMG/JndpoGK9JZ4tAf2uwO0Y+aBOoEQPXNhIhTm6AY02luo3YaZHreKeH36ytI2v5Gstrj9yVZls6DkXbOUoHVlu8QGhPWXBVBbuAWFg/KUOEnL6fAdXytWHeWVWr/uoIasfO1FwJHCYlj1NYWULSaCFrh21HQ=
Received: from BYAPR07CA0107.namprd07.prod.outlook.com (2603:10b6:a03:12b::48)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 17:58:37 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::31) by BYAPR07CA0107.outlook.office365.com
 (2603:10b6:a03:12b::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.18 via Frontend Transport; Fri,
 8 Aug 2025 17:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 17:58:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 12:58:33 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 8 Aug 2025 12:58:32 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH 8/9] meta-zephyr: Update README files
Date: Fri, 8 Aug 2025 11:58:28 -0600
Message-ID: <20250808175829.3830489-9-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
References: <20250808175829.3830489-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f56909-7e7c-4406-a70a-08ddd6a53332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8+XCLaFLKaiQF6rxcDJGdNpKnshs2+GehrfmRxBHBeqrsDudCMiS2tEyt++U?=
 =?us-ascii?Q?wEEqpeqrA2Ng8qU2eS7NrpImZc5nCof1hXMBPewOb21hGRJNPQs1wuryTiw9?=
 =?us-ascii?Q?u+UG3xn7QmAoUxXv6YWFh6kDKzuZmto5O4Vxo5KCQ2VdoRYwB5UQhdFCCtrx?=
 =?us-ascii?Q?qtHIFD4GMYbUiwhiskvXDEwf+rg1v6wfQNBeE25lpOSa+oxqrj0AZQbnNJPn?=
 =?us-ascii?Q?Xsb0jVuijHBuB5GPc2/3aRTVuHbYyMmqFzx53DPucsqFO44YQsu+9LrFAVQX?=
 =?us-ascii?Q?OskVxlycBGVsPuOXXNiBwG8ubqKjeAW230eojNBGyLE/ZvFebIJmD0TN3b8U?=
 =?us-ascii?Q?WA52LfAmWvF953RCrOAASkD8Ooh41Mqde+F/I5hod+UXcQiLxEMRJlVXYS3i?=
 =?us-ascii?Q?ba84CuhE9z4Frqok+qI6ikmwAJnauMW+O6WJh9X31+4K4VqWRt3VQssFGZxJ?=
 =?us-ascii?Q?1WXHbyinxf2SXLdxZQqu/CgGMI2emaF0AUSAtien0XBXI96Ix6lXONQmHQa/?=
 =?us-ascii?Q?xgW81XjlG4pr/LyEdZIlznSGQSRVENxKSccpEgBMNdZWijGSxtvLfICAl3GD?=
 =?us-ascii?Q?3qkevsyng29AgGExz2HzfulpC8lKabCpt3OY9HjgL/zvk9dASP38ixwQk+Fh?=
 =?us-ascii?Q?XzPNnzUfhuBsDCy7Ym+N7lFZZ+vHB2Sp2xjAr0twm9mZUMi5vbnOd2rCKSRF?=
 =?us-ascii?Q?M8aGu96NrFsUmeepeECe21iEtwWSQctp6LzTnCxDMLrY57X+MZFnS06ToypD?=
 =?us-ascii?Q?V/fRWeCAao8QEfUc0LWubAcZn1hrB7Nm+VzzdxxdYC86ErrgU9R5RDaD2e/F?=
 =?us-ascii?Q?9N0i/3/KUXlFvmTDGa0/VX3kTmmveK+ytGvIBCOmO5uX0kPQzjs/xvj6nEMN?=
 =?us-ascii?Q?inV9u20SI8n01ZD70+fAA6AhnLTauLnyjaCNpSH7iNW6DKlepli7+NX2l8av?=
 =?us-ascii?Q?alSHml13dM57Qfx/V5orI/sNAn6Aw33BMpvb0VrU2rhCeDuXo+nZJDvAnnhV?=
 =?us-ascii?Q?FXw9/0Ev3FiUWmx5A5hH0r9pchiaNCTceEDol1evi5hfmsVYyplHrrVF4fvG?=
 =?us-ascii?Q?CehpJJursdKNjxIi1/ktUn88COvYqRsfhYVKj6DaxVuOHus1WX+uOHEcXaFX?=
 =?us-ascii?Q?2sXpRUL2otPjhefPJhg1NlX8s3IVDoSvJ4Y/Sh4g1GjAMqGrqqD8S/hy7qPc?=
 =?us-ascii?Q?bs9NVmWsHQQ1d/88K+r8rnq/rsNg1uke30I7B0jqbENW++dL1+G7/cuTRazX?=
 =?us-ascii?Q?yEcB2PeAFyhL+7giQo9OtcqZbmodRN0o7aonkeKuzcEzRcKOcQgt+cz86VKw?=
 =?us-ascii?Q?5dmh4hKH7CypBMfnhn+SHuuTYncxnUgeONoPvSlDQrm2kwdw+0P3MTtuSnim?=
 =?us-ascii?Q?lLuJRQ8RcxJEEJ86G+U7cEfgvVBdtJmeS2z5iBkTb/xbCC/fOpuNIsWDlP/5?=
 =?us-ascii?Q?MRAco3n0i7eBuKj29GBAxPYbZRWW1GTWuZohF5+Z36KPwyHsnxIqtA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:58:37.2628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f56909-7e7c-4406-a70a-08ddd6a53332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 Aug 2025 17:58:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1908

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


