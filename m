Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA9BCA0ED3
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:46:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.53])
 by mx.groups.io with SMTP id smtpd.web10.57319.1754941617361083659
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=aW1LORwG;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.236.53, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSDh0Z2Kw9+47zlS/8b2zk7mE/9ovZ+PWiuKl492cmOtbUvZlPv7TMo4tCQGQ1c+eIsfex1Ac/zDlc05H06FzOLgPRQSH4La7+D+rJeEcsduuolpMS2bD3zYj5gv6puTJruOcM0lu973/0ydWcYpv6oiqdhQuyE/9EQzhiqZJrw3bAfdD/m4cxHwd1ccLfiLhprdLj6/DXcwJ3+7ZetMXJc8o+0wZkOfthAEIbPqozA3Zvl8yo3lLOpS8468Jbx2FCrVD/dgYWxYzrcFnwI9PzzYVU/IoaJXIRAcN67BQW441uF6efz+DAQ2xtmZ80aPgEs9HmQbppf88eVqd9Vyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISs6cuvTFdN7VCuELhR8XI1pTHN8m0TeLRCYXAYPsKk=;
 b=Wsw+1AqbrUOv8VGUJrfpSnRrzXVYUWjTFB5I4yAUEana1f0ulipShar/Ic7cdwppKeBjaV60rGm6eDmV5hz6JqbzttBBfiWHKV3hPXj81cIoDBG88JFyH4OyhBcpF1ZvCDE5tred/9MhFDqPh1k2/Ontzj7UGlv3YC9Tt44Wa+WNO8j69Y/7oWeaGd5tytObh6/MwIze4Ou3GR4bwOjajzrCQ/FmeDikcopMdhFagDAYA6Pc7q8AVljKqfr7yUcmEGPXWGP30tMRQWlyfn48LITEptDrGZYae3957SXdznTGBd2jrnaosSyU2CVLxRIQHWOhhutm9/TelyaIi21Cng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISs6cuvTFdN7VCuELhR8XI1pTHN8m0TeLRCYXAYPsKk=;
 b=aW1LORwGIWYuWQ2h+dXmKKD8QSO+H7W3dLPhiVCKb+8HnutOKNvXcm+Ku8eppQPWwrtDYf72zat3Afjrskl/fQHwAPukMYxgj9SyB+KqDsOOXyLR2h+5lBmkQkniJ2bCnsWz78tI78Z5INHMjq7aDiawDh3u/UarmsRtGQP6TDI=
Received: from CH2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:610:53::12)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 19:46:51 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::3e) by CH2PR17CA0002.outlook.office365.com
 (2603:10b6:610:53::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 19:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:50 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:49 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 9/13] meta-zephyr: Update README files
Date: Mon, 11 Aug 2025 13:46:42 -0600
Message-ID: <20250811194646.3408854-10-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cae094b-7e5f-4dcb-b5a3-08ddd90fd12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ApIiZlm5x+wKg/BBZWtLHQ+/j/d2deTLk3pT3R9z507s8FQvTB5ykKJ0skOC?=
 =?us-ascii?Q?YRYFyskrutNk9RDasQF8XRiPF2TCqQUztWf9f/Mjg93cNXiPBFHKl1tYqM/y?=
 =?us-ascii?Q?o8axb7Uvh5m4cDTeMdjTIIjzRk9y+HCWTuwn2ZSQvMy9lVinKIZGIyvYpAah?=
 =?us-ascii?Q?dxQMdzi6rnmWlEJvo2rxm0kAO0H6jNM9PIqZfduEk1AuhLSku7Rm2hJtvrnN?=
 =?us-ascii?Q?eu8lhYxy3xga6Z1dZGmIkokqjSKFyMAf5iBV3slRBWDjchLEGkeqythNyUYX?=
 =?us-ascii?Q?Nql+0ptyRKv11NoO3dEZ80rMNTyyPqCqsQrwxPzhz44vNYFYcvImjwNK2P4D?=
 =?us-ascii?Q?7nwZNugGReJ5vAxVwnGjuOZpqQh+DUb3yy2CyfeguFaUiW6Ey9NXauVny9Zu?=
 =?us-ascii?Q?r6l6jKm1NBcPv8JRw9d4Q8Y/MDgp5jWnzSf8ps7x/rVEFcDDMByZjp3zjpR4?=
 =?us-ascii?Q?7wf/1Kw0Wbs8/RlpXmiLA58pwUFNCchfj17z4+S2g0xoZR+coOMcj2PlkawA?=
 =?us-ascii?Q?dFk5m1y2vjRO+RouQRYb/tPuuOsTgqlYqADkP1xuXIENK53DV9lWhZi8+xKt?=
 =?us-ascii?Q?itfPmWzLSoI0OFamny9Qdv1GJ2oKG+Ys/8tuZQj6lEtIDFzlrUTLYYyfv9U3?=
 =?us-ascii?Q?eq5oxeCDPWEwuPVbj3ObjJ8rU81eTvMt8icK3vN1o7NMBfWHztU1AavHFUxS?=
 =?us-ascii?Q?Q7UUJIMfqNTWIxyuuwV578TCCS8CnW67Q/wpM/zBjpJA+A1TXD1/Ix7BETRz?=
 =?us-ascii?Q?MTQBHerwMasWq+SufFTqUZysgfiiyzRheYQd6eYePG5Gt6SHPq8ZOpVL0r9T?=
 =?us-ascii?Q?sE2gjXMgJx2WT3vvOwxkc8ecQ/NoIoft+mRlhmXDu6TwsfIVeVxef4QpXQ/u?=
 =?us-ascii?Q?yB0QX6u7vJbwnx3erLplRkTQ+IoNVJZ98doz/gr7W3L0lX4AyHTEwPCf+Z7b?=
 =?us-ascii?Q?wpwv+jCzeqwaSJMB4ZWi00SD+DVXEC1Jgjzrd2KpUKH6jX7Wu5OIGb3eRFnx?=
 =?us-ascii?Q?kyho0iN4z3gaSYVX0SPD6UG5tWKml5639ntZlOtY6/HJRBrcgvak8HvAz3yT?=
 =?us-ascii?Q?EKFxqYF0KKPsOYogzHazspfOCoDUj2leRvEo5J18Fq6YjH2HqDO0S/UpLmIM?=
 =?us-ascii?Q?kYeP6tFOY+d6s/hEGMOPizJEix0OuCBmvS/LEQM7kgDdiNXCXauoHlHQaoOW?=
 =?us-ascii?Q?+ikSVrgiu1RtrYJtE9xcsx6MoP2sqtplbcLmZ+JX7kOumkfE0pGIKr10ydFe?=
 =?us-ascii?Q?ihb2jbvlLw7BjswIqRLQSqc3DG7Tqr98YOQf3uJiR9BpRd01Cu0m8pAvFPjt?=
 =?us-ascii?Q?eelYGZCqqMo5wHZGydvx1dPW0vErMqZUZpuf5RISTHkiXq6NGYHdcxZ05bS6?=
 =?us-ascii?Q?dGq9l1vC9Sc36Qe0qm45cMD7DCIFg2KdHknH9fJF8WjFD0cxK9FQ6uLLoWhX?=
 =?us-ascii?Q?Qc0uEoevrDu/ZsZ5/SSV6fYQWfBBHDAEtIhJAxPnswHNEROPZRqMeA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:51.3236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cae094b-7e5f-4dcb-b5a3-08ddd90fd12f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1952

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


