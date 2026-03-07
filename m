Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31998FC9EDD
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:44:10 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com (PH7PR06CU001.outbound.protection.outlook.com [52.101.201.18])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3308.1772858642773491932
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:44:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=PdDWCzcu;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.201.18, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdGK4euq9mSgy7ExWeRRGjWakQbbB1MhV9rSavf+NgO455APsfhL+zRJlWQZttni6Oa/v5rnZ/dPw93kCdFhOKbFI9k6Y94bnnVfGgjUQvrTPInHvX7i1m0BqgkYY7+VZ1FXA/4YU1qDkw/3yE3NBrPfo5uwS65bykWTMtSvqwSchTxCkvFdi1QjcOxQctnPy9Jj7H/hmpCht471DwsT/WojK/+2YTG+wRi0kwrxQIXGaDRjwbuBiIaTZEAHA0LZbbLxijxLX2lbi3renwsVuX+hwBMz8wV28gx7SSnHaptyzpmUz24VFIkg/Wxl1CnNJ8wktoyMljj/Duhw0IQeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9E8J0PfHXWV7sLoL25nLJql28bofeFQ1x8puhburj8=;
 b=EdNmn1qPfVzGNZUwcwunfn/A6xatPxLEl7gdEl7COFcoZEaupH9PkA2MUV200J8PvAtSPYKiuCj1bjv7VMnNTkaAUV1BT6ArERPxub044rT+ToKCUU24jRr9Nv7yjjLbgbW5ZOAzvUfCjLKL+eOTqrCHVX4ehS3ipSvi2BeRvBlxQZtv+Ac/IaT0xygcq0/9sejmbaPitJwdUwiaU4+s+uaz3oxIawqkxql6iO+2dknZMUQLz7Ml8w8rObhI63Wc03I7G70LN4fXssIPnP58gHfdNXYUvCfkPSCIDGmJNZnlEV2fKP93y2JpBHMCeAncSHiU9KHZszEKmK3ZrfyuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9E8J0PfHXWV7sLoL25nLJql28bofeFQ1x8puhburj8=;
 b=PdDWCzcupYjZkhv4FFRY+pYoyxSVLuB/XL5QJKvKs0YBaCBkcge5gHCZx2Vpvk8RTywShLJf5LvixR3jsCY1bHO/VNHc/SJLryyy8sAiKF/mrgXTvmg5vRglsH2Kvz1fbAUTS0454FA0kz29X5kdDsb6LwtXMW9m29NHD4seJcs=
Received: from SA1PR02CA0011.namprd02.prod.outlook.com (2603:10b6:806:2cf::28)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Sat, 7 Mar
 2026 04:43:56 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::b6) by SA1PR02CA0011.outlook.office365.com
 (2603:10b6:806:2cf::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Sat,
 7 Mar 2026 04:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 04:43:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:55 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 22:43:55 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 5/9] zephyr-kernel: Add support for v4.3.0
Date: Fri, 6 Mar 2026 21:43:49 -0700
Message-ID: <20260307044353.1936182-6-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
References: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c5cf2f-40c7-44e1-8464-08de7c042454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	d49AUXYegGPWpRfq4yPREwHN09ygqrNFS/jZ+VwdbmITKGNATPw4+0qQAskGj4Ul8k2neUTqtx/6Y+4uTUtEScTtn6ZgZ3CUee+thewz661irIE1flJ0x1u38fcyRXYQrah3ok28TVKYGVAw3ZyPAU2HkzWA3fYuFqEHWRUPrRZuELqAH57sZgqIqv1FB9dYF+bfVWaBYNbUR6OC3jit30v9emJCpXeg0y6OIs7FH6dy1AYx8bO4fOKI7T5/12WWG2uoBugoxCPQX2WGy1cQrvOnDM3TnjlhyxQ54jGtT/xemfLQEvkCkr4gCD6QTTUSa7urO5j2WuvtgmW9g3BRP58ZURoy5/UXGKxKkyfI8yOQ37yF0HLR76X4vuVSC4Oo8UHR5W6KCCGU72Q/Tixj/EKoBu42ugKrO/PYYHPf+jaz0o8gPshSBUn/yHwLbndVnIkIthAkEZdhKnruJsXpLq41PWvTe3qtk5kJ3JvVL54zH1Op+HW2k2TI18hbF+NuUb5yF9fqGQqaRNuwjVtq8Z2ssj8TdW1kxnuP3i38vPVGTvVnyoqZuiL1bexecKo3velTthYcAfKhnEgFg29QNygt+XfwzTDiaz+6xxkiVZ2ueJ0etVwr7KTa0c0OYgIN/KtIGhAvHIdMXMDZ4ndHXVdfvon5PF2Ue95AO0dMHCf8eaiXlJIyzF5/D6nJFWfyRiQ1FQJdRRS12FC37ZIbYZCMTiHlTRGmwftOdPfTqtJPxxglC++isgefyPEtKfBqF0nC2skWCXekUBKQamG8Ng==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	THnfGwu9owIUvPdq1sGNM5d6v4gdLjwnl8hGx5pxdIZd8w9h8tOvsjerB4w8J1gbhvL7+/+WV/JFa8ZUPieEMKtDYas3WIXLfdq2zhgH6N8/5UfI1k5xrlr8Lt60kslix21Is4oNje7Rz80x65ZTciK3stQTDdS3qSPUBgGdeXBf8KrgQKw0sdQRkaSCo/meZxCoqrpSoSLWUN2elnarKG7wJmCu1hGZeX9j229ucpGOtcUQtpepbHmHb8JF83IsRykohy/aOvfglUO8P/r7U3cUOYb7FPWy7Y57Xq1pJgArp2mTP04vV5ieUEL3NtTdwulW7bq7d0YoK3d7iNlvqAvuTLoucRSPd7O6+1rMt+BaakqLES7YNsjd3Zn49kcES+mwAfSAj2b5ggFXYsoXNp7gfaX23NzP/6SWdMOA9lsvvEwNhlGsjMKbeu1Gf0pV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:43:56.3809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c5cf2f-40c7-44e1-8464-08de7c042454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:44:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3360

Add support for Zephyr v4.3.0
https://github.com/zephyrproject-rtos/zephyr/releases/tag/v4.3.0

Also bump the PREFERRED_VERSION to 4.3.0 as default zpehyr-kernel
version.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/conf/layer.conf              |   2 +-
 ...ry-generation-issue-in-cross-compila.patch |  84 +++++
 .../zephyr-kernel/zephyr-kernel-src-4.3.0.inc | 310 ++++++++++++++++++
 3 files changed, 395 insertions(+), 1 deletion(-)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/files/000=
1-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-ke=
rnel-src-4.3.0.inc

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer=
.conf
index 519c4b8..48a0066 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -21,5 +21,5 @@ PYTHON3_NATIVE_SITEPACKAGES_DIR =3D "${libdir_native}/${P=
YTHON3_DIR}/site-packages
=20
 addpylib ${LAYERDIR}/lib oeqa
=20
-PREFERRED_VERSION_zephyr-kernel ??=3D "4.2.0"
+PREFERRED_VERSION_zephyr-kernel ??=3D "4.3.0"
 PREFERRED_VERSION_zephyr-sdk-native ??=3D "0.17.4"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.=
0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch b/meta-zephyr-=
core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-gene=
ration-issue-in-cross-compila.patch
new file mode 100644
index 0000000..ba454a9
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-f=
ix-efi-binary-generation-issue-in-cross-compila.patch
@@ -0,0 +1,84 @@
+From 9a2162517de91bf085ed336615c49db06ed8585f Mon Sep 17 00:00:00 2001
+From: Naveen Saini <naveen.kumar.saini@intel.com>
+Date: Wed, 16 Apr 2025 14:51:49 +0800
+Subject: [PATCH] x86: fix efi binary generation issue in cross compilation=
 env
+
+Set root directory for headers.
+
+Upstream-Status: Inappropriate [Cross-compilation specific]
+
+Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
+
+Rebase original patch with v4.3.0 directory structure and drop
+up_squared board changes as this is removed from v4.3.0
+
+Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
+---
+ arch/x86/zefi/zefi.py           | 4 +++-
+ boards/intel/adl/CMakeLists.txt | 1 +
+ boards/intel/ehl/CMakeLists.txt | 1 +
+ boards/intel/rpl/CMakeLists.txt | 1 +
+ 4 files changed, 6 insertions(+), 1 deletion(-)
+
+diff --git a/arch/x86/zefi/zefi.py b/arch/x86/zefi/zefi.py
+index b98419f8a49..790797f011a 100755
+--- a/arch/x86/zefi/zefi.py
++++ b/arch/x86/zefi/zefi.py
+@@ -115,8 +115,9 @@ def build_elf(elf_file, include_dirs):
+     includes =3D []
+     for include_dir in include_dirs:
+         includes.extend(["-I", include_dir])
++    #  Pass --sysroot path for cross compilation
+     cmd =3D ([args.compiler, "-shared", "-Wall", "-Werror", "-I."] + incl=
udes +
+-           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wc=
har",
++           ["-fno-stack-protector", "-fpic", "-mno-red-zone", "-fshort-wc=
har", sysrootarg,
+             "-Wl,-nostdlib", "-nostartfiles", "-T", ldscript, "-o", "zefi=
.elf", cfile])
+     verbose(" ".join(cmd))
+     subprocess.run(cmd, check =3D True)
+@@ -156,6 +157,7 @@ def parse_args():
+     parser.add_argument("-v", "--verbose", action=3D"store_true", help=3D=
"Verbose output")
+     parser.add_argument("-i", "--includes", required=3DTrue, nargs=3D"+",
+                         help=3D"Zephyr base include directories")
++    parser.add_argument("-s", "--sysroot", required=3DTrue, help=3D"Cross=
 compilation --sysroot=3Dpath")
+=20
+     return parser.parse_args()
+=20
+diff --git a/boards/intel/adl/CMakeLists.txt b/boards/intel/adl/CMakeLists=
.txt
+index 6a250ca315c..867393baac6 100644
+--- a/boards/intel/adl/CMakeLists.txt
++++ b/boards/intel/adl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_comma=
nds
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/intel/ehl/CMakeLists.txt b/boards/intel/ehl/CMakeLists=
.txt
+index 6a250ca315c..867393baac6 100644
+--- a/boards/intel/ehl/CMakeLists.txt
++++ b/boards/intel/ehl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_comma=
nds
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+diff --git a/boards/intel/rpl/CMakeLists.txt b/boards/intel/rpl/CMakeLists=
.txt
+index 6a250ca315c..867393baac6 100644
+--- a/boards/intel/rpl/CMakeLists.txt
++++ b/boards/intel/rpl/CMakeLists.txt
+@@ -8,6 +8,7 @@ set_property(GLOBAL APPEND PROPERTY extra_post_build_comma=
nds
+   -o ${CMAKE_OBJCOPY}
+   -i ${ZEPHYR_BASE}/include ${PROJECT_BINARY_DIR}/include/generated
+   -f ${PROJECT_BINARY_DIR}/${CONFIG_KERNEL_BIN_NAME}.elf
++  -s ${SYSROOT_DIR}
+   $<$<BOOL:${CMAKE_VERBOSE_MAKEFILE}>:--verbose>
+   WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
+ )
+--=20
+2.34.1
+
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-sr=
c-4.3.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-s=
rc-4.3.0.inc
new file mode 100644
index 0000000..3352986
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.3.0=
.inc
@@ -0,0 +1,310 @@
+# Auto-generated from zephyr-kernel-src.inc.jinja
+
+SRCREV_FORMAT =3D "default"
+
+SRCREV_default =3D "3568e1b6d5cdd51a6b964a2a1d6d29200fea2056"
+SRCREV_acpica =3D "8d24867bc9c9d81c81eeac59391cda59333affd4"
+SRCREV_babblesim_base =3D "2cfac3dca2071452ae481d115d8541880568753d"
+SRCREV_babblesim_ext_2G4_channel_NtNcable =3D "20a38c997f507b0aa53817aab3d=
73a462fff7af1"
+SRCREV_babblesim_ext_2G4_channel_multiatt =3D "bde72a57384dde7a4310bcf3843=
469401be93074"
+SRCREV_babblesim_ext_2G4_device_WLAN_actmod =3D "9cb6d8e72695f6b785e57443f=
0629a18069d6ce4"
+SRCREV_babblesim_ext_2G4_device_burst_interferer =3D "5b5339351d6e6a2368c6=
86c734dc8b2fc65698fc"
+SRCREV_babblesim_ext_2G4_device_playback =3D "abb48cd71ddd4e2a9022f4bf49b2=
712524c483e8"
+SRCREV_babblesim_ext_2G4_libPhyComv1 =3D "e18e41e8e3fa9f996559ed98b9238a57=
02dcdd36"
+SRCREV_babblesim_ext_2G4_modem_BLE_simple =3D "4d2379de510684cd4b1c3bbbb09=
bce7b5a20bc1f"
+SRCREV_babblesim_ext_2G4_modem_magic =3D "edfcda2d3937a74be0a59d6cd47e0f50=
183453da"
+SRCREV_babblesim_ext_2G4_phy_v1 =3D "8964ed1eb94606c2ea555340907bdc5171793=
e65"
+SRCREV_babblesim_ext_libCryptov1 =3D "da246018ebe031e4fe4a8228187fb459e9f3=
b2fa"
+SRCREV_bsim =3D "2ba22a0608ad9f46da1b96ee5121af357053c791"
+SRCREV_cmsis =3D "512cc7e895e8491696b61f7ba8066b4a182569b8"
+SRCREV_cmsis-dsp =3D "97512610ec92058f0119450b9e743eeb7e95b5c8"
+SRCREV_cmsis-nn =3D "e9328d612ea3ea7d0d210d3ac16ea8667c01abdd"
+SRCREV_cmsis_6 =3D "30a859f44ef8ab4dc8f84b03ed586fd16ccf9d74"
+SRCREV_edtt =3D "c282625e694f0b53ea53e13231ea6d2f49411768"
+SRCREV_fatfs =3D "f4ead3bf4a6dab3a07d7b5f5315795c073db568d"
+SRCREV_hal_adi =3D "eeb155f7382343438114605963ae64436cc53434"
+SRCREV_hal_afbr =3D "4e1eea7ea283db9d9ce529b0e9f89c0b5c2660e3"
+SRCREV_hal_ambiq =3D "5efc0228528a8adce5eae0d226fac85d2551eb3b"
+SRCREV_hal_atmel =3D "065e57c5013051c8b7f2256271349c6942bd9344"
+SRCREV_hal_bouffalolab =3D "89df8327276755b5935dc4cc2f2f68e27a8dba3d"
+SRCREV_hal_espressif =3D "af6cfa2e3e7098b596062ab516b80a48a7ba7332"
+SRCREV_hal_ethos_u =3D "fd5d5b7b36b209f2c48635de5d6c9b8dbf0bfff0"
+SRCREV_hal_gigadevice =3D "ee0e31302c21b2a465dc303b3ced8c606c2167c8"
+SRCREV_hal_infineon =3D "f3c571f772209b5970bdd1806da641244b5c4c38"
+SRCREV_hal_intel =3D "82a33b2de29523d9ce572b3d0110a808665cd3ff"
+SRCREV_hal_microchip =3D "89754d87258945ceb1cff8ecee0ddd8852396ae8"
+SRCREV_hal_nordic =3D "7858281d843468fe53c829995fb63f45a227387a"
+SRCREV_hal_nuvoton =3D "9b455fffd6dd3936c5a4eb575e4d33edbcf1b6b0"
+SRCREV_hal_nxp =3D "6d6ab91d5cc71c872353af1957d19f3d930df0fd"
+SRCREV_hal_openisa =3D "eabd530a64d71de91d907bad257cd61aacf607bc"
+SRCREV_hal_quicklogic =3D "bad894440fe72c814864798c8e3a76d13edffb6c"
+SRCREV_hal_renesas =3D "a279c14e196cb0904593035888a334dcd2c720bd"
+SRCREV_hal_rpi_pico =3D "09e957522da60581cf7958b31f8e625d969c69a5"
+SRCREV_hal_sifli =3D "7be421088b6fa2910917f3f8b656ded01e21b4e8"
+SRCREV_hal_silabs =3D "5d75cba8a1b0e9a747ae387d9ffbb1bf7cd8c529"
+SRCREV_hal_st =3D "9f81b4427e955885398805b7bca0da3a8cd9109c"
+SRCREV_hal_stm32 =3D "286dd285b5bb4fddafdfff27b5405264e5a61bfe"
+SRCREV_hal_tdk =3D "6727477af1e46fa43878102489b9672a9d24e39f"
+SRCREV_hal_telink =3D "4226c7fc17d5a34e557d026d428fc766191a0800"
+SRCREV_hal_ti =3D "cc049020152585c4e968b83c084d230234b6d852"
+SRCREV_hal_wch =3D "6dd313768b5f4cc69baeac4ce6e59f2038eb8ce5"
+SRCREV_hal_wurthelektronik =3D "7c1297ea071d03289112eb24e789c89c7095c0a2"
+SRCREV_hal_xtensa =3D "3cc9e3a9360be5c96c956dce84064b85439b6769"
+SRCREV_hostap =3D "cf05f33f594de6b62840a3b0dd435f10467a2e4c"
+SRCREV_liblc3 =3D "48bbd3eacd36e99a57317a0a4867002e0b09e183"
+SRCREV_libmctp =3D "b97860e78998551af99931ece149eeffc538bdb1"
+SRCREV_libmetal =3D "91d38634d1882f0a2151966f8c5c230ce1c0de7b"
+SRCREV_libsbc =3D "8e1beda02acb8972e29e6edbb423f7cafe16e445"
+SRCREV_littlefs =3D "8f5ca347843363882619d8f96c00d8dbd88a8e79"
+SRCREV_lora-basics-modem =3D "9a14f6772c1d6e303bacb2d594c8063bb804b6ee"
+SRCREV_loramac-node =3D "fb00b383072518c918e2258b0916c996f2d4eebe"
+SRCREV_lvgl =3D "b03edc8e6282a963cd312cd0b409eb5ce263ea75"
+SRCREV_mbedtls =3D "c5b06d89c9c498d8fc8659ce31f7e53137b6270f"
+SRCREV_mcuboot =3D "96576b341ee19f1c3af6622256b0d4f3d408e1e3"
+SRCREV_mipi-sys-t =3D "5a9d6055b62edc54566d6d0034d9daec91749b98"
+SRCREV_nanopb =3D "7307ce399b81ddcb3c3a5dc862c52d4754328d38"
+SRCREV_net-tools =3D "64d7acc661ae2772282570f21beab85d02f2f35c"
+SRCREV_nrf_hw_models =3D "26ed181181eed53e400db8f63fa83c566a05d971"
+SRCREV_nrf_wifi =3D "e269670cd17fb8ccc4b7004544276bc7d9578496"
+SRCREV_open-amp =3D "c30a6d8b92fcebdb797fc1a7698e8729e250f637"
+SRCREV_openthread =3D "2bc7712f57af22058770d1ef131ad3da79a0c764"
+SRCREV_percepio =3D "132ed87d617578a6cb70a2443f43e117c315e0f0"
+SRCREV_picolibc =3D "ca8b6ebba5226a75545e57a140443168a26ba664"
+SRCREV_segger =3D "9f08435a79d41133d7046b7c59d1b25929eda450"
+SRCREV_trusted-firmware-a =3D "0a29cac8fe0f7bdb835b469d9ea11b8e17377a92"
+SRCREV_trusted-firmware-m =3D "04aa7243e04946b5422b124bea9c0675ab6b120f"
+SRCREV_uoscore-uedhoc =3D "54abc109c9c0adfd53c70077744c14e454f04f4a"
+SRCREV_zcbor =3D "9b07780aca6fb21f82a241ba386ad9b379809337"
+
+SRC_URI_ZEPHYR ?=3D "git://github.com/zephyrproject-rtos/zephyr.git;protoc=
ol=3Dhttps"
+SRC_URI_ZEPHYR_ACPICA ?=3D "git://github.com/zephyrproject-rtos/acpica;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_BASE ?=3D "git://github.com/BabbleSim/base;protoc=
ol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE ?=3D "git://github.com/B=
abbleSim/ext_2G4_channel_NtNcable;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT ?=3D "git://github.com/B=
abbleSim/ext_2G4_channel_multiatt;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD ?=3D "git://github.com=
/BabbleSim/ext_2G4_device_WLAN_actmod;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER ?=3D "git://githu=
b.com/BabbleSim/ext_2G4_device_burst_interferer;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK ?=3D "git://github.com/Ba=
bbleSim/ext_2G4_device_playback;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1 ?=3D "git://github.com/Babble=
Sim/ext_2G4_libPhyComv1;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE ?=3D "git://github.com/B=
abbleSim/ext_2G4_modem_BLE_simple;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC ?=3D "git://github.com/Babble=
Sim/ext_2G4_modem_magic;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1 ?=3D "git://github.com/BabbleSim/e=
xt_2G4_phy_v1;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1 ?=3D "git://github.com/BabbleSim/=
ext_libCryptov1;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BSIM ?=3D "git://github.com/zephyrproject-rtos/babblesim-ma=
nifest;protocol=3Dhttps"
+SRC_URI_ZEPHYR_CMSIS ?=3D "git://github.com/zephyrproject-rtos/cmsis;proto=
col=3Dhttps"
+SRC_URI_ZEPHYR_CMSIS_DSP ?=3D "git://github.com/zephyrproject-rtos/cmsis-d=
sp;protocol=3Dhttps"
+SRC_URI_ZEPHYR_CMSIS_NN ?=3D "git://github.com/zephyrproject-rtos/cmsis-nn=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_CMSIS_6 ?=3D "git://github.com/zephyrproject-rtos/CMSIS_6;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_EDTT ?=3D "git://github.com/zephyrproject-rtos/edtt;protoco=
l=3Dhttps"
+SRC_URI_ZEPHYR_FATFS ?=3D "git://github.com/zephyrproject-rtos/fatfs;proto=
col=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ADI ?=3D "git://github.com/zephyrproject-rtos/hal_adi;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_AFBR ?=3D "git://github.com/zephyrproject-rtos/hal_afbr=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_AMBIQ ?=3D "git://github.com/zephyrproject-rtos/hal_amb=
iq;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ATMEL ?=3D "git://github.com/zephyrproject-rtos/hal_atm=
el;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_BOUFFALOLAB ?=3D "git://github.com/zephyrproject-rtos/h=
al_bouffalolab;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ESPRESSIF ?=3D "git://github.com/zephyrproject-rtos/hal=
_espressif;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ETHOS_U ?=3D "git://github.com/zephyrproject-rtos/hal_e=
thos_u;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_GIGADEVICE ?=3D "git://github.com/zephyrproject-rtos/ha=
l_gigadevice;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_INFINEON ?=3D "git://github.com/zephyrproject-rtos/hal_=
infineon;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_INTEL ?=3D "git://github.com/zephyrproject-rtos/hal_int=
el;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_MICROCHIP ?=3D "git://github.com/zephyrproject-rtos/hal=
_microchip;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_NORDIC ?=3D "git://github.com/zephyrproject-rtos/hal_no=
rdic;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_NUVOTON ?=3D "git://github.com/zephyrproject-rtos/hal_n=
uvoton;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_NXP ?=3D "git://github.com/zephyrproject-rtos/hal_nxp;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_OPENISA ?=3D "git://github.com/zephyrproject-rtos/hal_o=
penisa;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_QUICKLOGIC ?=3D "git://github.com/zephyrproject-rtos/ha=
l_quicklogic;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_RENESAS ?=3D "git://github.com/zephyrproject-rtos/hal_r=
enesas;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_RPI_PICO ?=3D "git://github.com/zephyrproject-rtos/hal_=
rpi_pico;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_SIFLI ?=3D "git://github.com/zephyrproject-rtos/hal_sif=
li;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_SILABS ?=3D "git://github.com/zephyrproject-rtos/hal_si=
labs;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ST ?=3D "git://github.com/zephyrproject-rtos/hal_st;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_STM32 ?=3D "git://github.com/zephyrproject-rtos/hal_stm=
32;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_TDK ?=3D "git://github.com/zephyrproject-rtos/hal_tdk;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_TELINK ?=3D "git://github.com/zephyrproject-rtos/hal_te=
link;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_TI ?=3D "git://github.com/zephyrproject-rtos/hal_ti;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_WCH ?=3D "git://github.com/zephyrproject-rtos/hal_wch;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK ?=3D "git://github.com/zephyrproject-rt=
os/hal_wurthelektronik;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_XTENSA ?=3D "git://github.com/zephyrproject-rtos/hal_xt=
ensa;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HOSTAP ?=3D "git://github.com/zephyrproject-rtos/hostap;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_LIBLC3 ?=3D "git://github.com/zephyrproject-rtos/liblc3;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_LIBMCTP ?=3D "git://github.com/zephyrproject-rtos/libmctp;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_LIBMETAL ?=3D "git://github.com/zephyrproject-rtos/libmetal=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_LIBSBC ?=3D "git://github.com/zephyrproject-rtos/libsbc;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_LITTLEFS ?=3D "git://github.com/zephyrproject-rtos/littlefs=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_LORA_BASICS_MODEM ?=3D "git://github.com/zephyrproject-rtos=
/lora-basics-modem;protocol=3Dhttps"
+SRC_URI_ZEPHYR_LORAMAC_NODE ?=3D "git://github.com/zephyrproject-rtos/lora=
mac-node;protocol=3Dhttps"
+SRC_URI_ZEPHYR_LVGL ?=3D "git://github.com/zephyrproject-rtos/lvgl;protoco=
l=3Dhttps"
+SRC_URI_ZEPHYR_MBEDTLS ?=3D "git://github.com/zephyrproject-rtos/mbedtls;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_MCUBOOT ?=3D "git://github.com/zephyrproject-rtos/mcuboot;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_MIPI_SYS_T ?=3D "git://github.com/zephyrproject-rtos/mipi-s=
ys-t;protocol=3Dhttps"
+SRC_URI_ZEPHYR_NANOPB ?=3D "git://github.com/zephyrproject-rtos/nanopb;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_NET_TOOLS ?=3D "git://github.com/zephyrproject-rtos/net-too=
ls;protocol=3Dhttps"
+SRC_URI_ZEPHYR_NRF_HW_MODELS ?=3D "git://github.com/zephyrproject-rtos/nrf=
_hw_models;protocol=3Dhttps"
+SRC_URI_ZEPHYR_NRF_WIFI ?=3D "git://github.com/zephyrproject-rtos/nrf_wifi=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_OPEN_AMP ?=3D "git://github.com/zephyrproject-rtos/open-amp=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_OPENTHREAD ?=3D "git://github.com/zephyrproject-rtos/openth=
read;protocol=3Dhttps"
+SRC_URI_ZEPHYR_PERCEPIO ?=3D "git://github.com/zephyrproject-rtos/percepio=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_PICOLIBC ?=3D "git://github.com/zephyrproject-rtos/picolibc=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_SEGGER ?=3D "git://github.com/zephyrproject-rtos/segger;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A ?=3D "git://github.com/zephyrproject-rto=
s/trusted-firmware-a;protocol=3Dhttps"
+SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M ?=3D "git://github.com/zephyrproject-rto=
s/trusted-firmware-m;protocol=3Dhttps"
+SRC_URI_ZEPHYR_UOSCORE_UEDHOC ?=3D "git://github.com/zephyrproject-rtos/uo=
score-uedhoc;protocol=3Dhttps"
+SRC_URI_ZEPHYR_ZCBOR ?=3D "git://github.com/zephyrproject-rtos/zcbor;proto=
col=3Dhttps"
+
+SRC_URI_PATCHES ?=3D "\
+    file://0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compil=
a.patch;patchdir=3Dzephyr \
+"
+
+SRC_URI =3D "\
+    ${SRC_URI_ZEPHYR};branch=3D${ZEPHYR_BRANCH};name=3Ddefault;destsuffix=
=3D${P}/zephyr \
+    ${SRC_URI_ZEPHYR_ACPICA};name=3Dacpica;nobranch=3D1;destsuffix=3D${P}/=
modules/lib/acpica \
+    ${SRC_URI_ZEPHYR_BABBLESIM_BASE};name=3Dbabblesim_base;nobranch=3D1;de=
stsuffix=3D${P}/tools/bsim/components \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE};name=3Dbabblesim_=
ext_2G4_channel_NtNcable;nobranch=3D1;destsuffix=3D${P}/tools/bsim/componen=
ts/ext_2G4_channel_NtNcable \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT};name=3Dbabblesim_=
ext_2G4_channel_multiatt;nobranch=3D1;destsuffix=3D${P}/tools/bsim/componen=
ts/ext_2G4_channel_multiatt \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD};name=3Dbabblesi=
m_ext_2G4_device_WLAN_actmod;nobranch=3D1;destsuffix=3D${P}/tools/bsim/comp=
onents/ext_2G4_device_WLAN_actmod \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER};name=3Dbab=
blesim_ext_2G4_device_burst_interferer;nobranch=3D1;destsuffix=3D${P}/tools=
/bsim/components/ext_2G4_device_burst_interferer \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK};name=3Dbabblesim_e=
xt_2G4_device_playback;nobranch=3D1;destsuffix=3D${P}/tools/bsim/components=
/ext_2G4_device_playback \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1};name=3Dbabblesim_ext_2=
G4_libPhyComv1;nobranch=3D1;destsuffix=3D${P}/tools/bsim/components/ext_2G4=
_libPhyComv1 \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE};name=3Dbabblesim_=
ext_2G4_modem_BLE_simple;nobranch=3D1;destsuffix=3D${P}/tools/bsim/componen=
ts/ext_2G4_modem_BLE_simple \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC};name=3Dbabblesim_ext_2=
G4_modem_magic;nobranch=3D1;destsuffix=3D${P}/tools/bsim/components/ext_2G4=
_modem_magic \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1};name=3Dbabblesim_ext_2G4_ph=
y_v1;nobranch=3D1;destsuffix=3D${P}/tools/bsim/components/ext_2G4_phy_v1 \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1};name=3Dbabblesim_ext_libCr=
yptov1;nobranch=3D1;destsuffix=3D${P}/tools/bsim/components/ext_libCryptov1=
 \
+    ${SRC_URI_ZEPHYR_BSIM};name=3Dbsim;nobranch=3D1;destsuffix=3D${P}/tool=
s/bsim \
+    ${SRC_URI_ZEPHYR_CMSIS};name=3Dcmsis;nobranch=3D1;destsuffix=3D${P}/mo=
dules/hal/cmsis \
+    ${SRC_URI_ZEPHYR_CMSIS_DSP};name=3Dcmsis-dsp;nobranch=3D1;destsuffix=
=3D${P}/modules/lib/cmsis-dsp \
+    ${SRC_URI_ZEPHYR_CMSIS_NN};name=3Dcmsis-nn;nobranch=3D1;destsuffix=3D$=
{P}/modules/lib/cmsis-nn \
+    ${SRC_URI_ZEPHYR_CMSIS_6};name=3Dcmsis_6;nobranch=3D1;destsuffix=3D${P=
}/modules/hal/cmsis_6 \
+    ${SRC_URI_ZEPHYR_EDTT};name=3Dedtt;nobranch=3D1;destsuffix=3D${P}/tool=
s/edtt \
+    ${SRC_URI_ZEPHYR_FATFS};name=3Dfatfs;nobranch=3D1;destsuffix=3D${P}/mo=
dules/fs/fatfs \
+    ${SRC_URI_ZEPHYR_HAL_ADI};name=3Dhal_adi;nobranch=3D1;destsuffix=3D${P=
}/modules/hal/adi \
+    ${SRC_URI_ZEPHYR_HAL_AFBR};name=3Dhal_afbr;nobranch=3D1;destsuffix=3D$=
{P}/modules/hal/afbr \
+    ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=3Dhal_ambiq;nobranch=3D1;destsuffix=
=3D${P}/modules/hal/ambiq \
+    ${SRC_URI_ZEPHYR_HAL_ATMEL};name=3Dhal_atmel;nobranch=3D1;destsuffix=
=3D${P}/modules/hal/atmel \
+    ${SRC_URI_ZEPHYR_HAL_BOUFFALOLAB};name=3Dhal_bouffalolab;nobranch=3D1;=
destsuffix=3D${P}/modules/hal/bouffalolab \
+    ${SRC_URI_ZEPHYR_HAL_ESPRESSIF};name=3Dhal_espressif;nobranch=3D1;dest=
suffix=3D${P}/modules/hal/espressif \
+    ${SRC_URI_ZEPHYR_HAL_ETHOS_U};name=3Dhal_ethos_u;nobranch=3D1;destsuff=
ix=3D${P}/modules/hal/ethos_u \
+    ${SRC_URI_ZEPHYR_HAL_GIGADEVICE};name=3Dhal_gigadevice;nobranch=3D1;de=
stsuffix=3D${P}/modules/hal/gigadevice \
+    ${SRC_URI_ZEPHYR_HAL_INFINEON};name=3Dhal_infineon;nobranch=3D1;destsu=
ffix=3D${P}/modules/hal/infineon \
+    ${SRC_URI_ZEPHYR_HAL_INTEL};name=3Dhal_intel;nobranch=3D1;destsuffix=
=3D${P}/modules/hal/intel \
+    ${SRC_URI_ZEPHYR_HAL_MICROCHIP};name=3Dhal_microchip;nobranch=3D1;dest=
suffix=3D${P}/modules/hal/microchip \
+    ${SRC_URI_ZEPHYR_HAL_NORDIC};name=3Dhal_nordic;nobranch=3D1;destsuffix=
=3D${P}/modules/hal/nordic \
+    ${SRC_URI_ZEPHYR_HAL_NUVOTON};name=3Dhal_nuvoton;nobranch=3D1;destsuff=
ix=3D${P}/modules/hal/nuvoton \
+    ${SRC_URI_ZEPHYR_HAL_NXP};name=3Dhal_nxp;nobranch=3D1;destsuffix=3D${P=
}/modules/hal/nxp \
+    ${SRC_URI_ZEPHYR_HAL_OPENISA};name=3Dhal_openisa;nobranch=3D1;destsuff=
ix=3D${P}/modules/hal/openisa \
+    ${SRC_URI_ZEPHYR_HAL_QUICKLOGIC};name=3Dhal_quicklogic;nobranch=3D1;de=
stsuffix=3D${P}/modules/hal/quicklogic \
+    ${SRC_URI_ZEPHYR_HAL_RENESAS};name=3Dhal_renesas;nobranch=3D1;destsuff=
ix=3D${P}/modules/hal/renesas \
+    ${SRC_URI_ZEPHYR_HAL_RPI_PICO};name=3Dhal_rpi_pico;nobranch=3D1;destsu=
ffix=3D${P}/modules/hal/rpi_pico \
+    ${SRC_URI_ZEPHYR_HAL_SIFLI};name=3Dhal_sifli;nobranch=3D1;destsuffix=
=3D${P}/modules/hal/sifli \
+    ${SRC_URI_ZEPHYR_HAL_SILABS};name=3Dhal_silabs;nobranch=3D1;destsuffix=
=3D${P}/modules/hal/silabs \
+    ${SRC_URI_ZEPHYR_HAL_ST};name=3Dhal_st;nobranch=3D1;destsuffix=3D${P}/=
modules/hal/st \
+    ${SRC_URI_ZEPHYR_HAL_STM32};name=3Dhal_stm32;nobranch=3D1;destsuffix=
=3D${P}/modules/hal/stm32 \
+    ${SRC_URI_ZEPHYR_HAL_TDK};name=3Dhal_tdk;nobranch=3D1;destsuffix=3D${P=
}/modules/hal/tdk \
+    ${SRC_URI_ZEPHYR_HAL_TELINK};name=3Dhal_telink;nobranch=3D1;destsuffix=
=3D${P}/modules/hal/telink \
+    ${SRC_URI_ZEPHYR_HAL_TI};name=3Dhal_ti;nobranch=3D1;destsuffix=3D${P}/=
modules/hal/ti \
+    ${SRC_URI_ZEPHYR_HAL_WCH};name=3Dhal_wch;nobranch=3D1;destsuffix=3D${P=
}/modules/hal/wch \
+    ${SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK};name=3Dhal_wurthelektronik;nobra=
nch=3D1;destsuffix=3D${P}/modules/hal/wurthelektronik \
+    ${SRC_URI_ZEPHYR_HAL_XTENSA};name=3Dhal_xtensa;nobranch=3D1;destsuffix=
=3D${P}/modules/hal/xtensa \
+    ${SRC_URI_ZEPHYR_HOSTAP};name=3Dhostap;nobranch=3D1;destsuffix=3D${P}/=
modules/lib/hostap \
+    ${SRC_URI_ZEPHYR_LIBLC3};name=3Dliblc3;nobranch=3D1;destsuffix=3D${P}/=
modules/lib/liblc3 \
+    ${SRC_URI_ZEPHYR_LIBMCTP};name=3Dlibmctp;nobranch=3D1;destsuffix=3D${P=
}/modules/lib/libmctp \
+    ${SRC_URI_ZEPHYR_LIBMETAL};name=3Dlibmetal;nobranch=3D1;destsuffix=3D$=
{P}/modules/hal/libmetal \
+    ${SRC_URI_ZEPHYR_LIBSBC};name=3Dlibsbc;nobranch=3D1;destsuffix=3D${P}/=
modules/lib/libsbc \
+    ${SRC_URI_ZEPHYR_LITTLEFS};name=3Dlittlefs;nobranch=3D1;destsuffix=3D$=
{P}/modules/fs/littlefs \
+    ${SRC_URI_ZEPHYR_LORA_BASICS_MODEM};name=3Dlora-basics-modem;nobranch=
=3D1;destsuffix=3D${P}/modules/lib/lora-basics-modem \
+    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=3Dloramac-node;nobranch=3D1;destsu=
ffix=3D${P}/modules/lib/loramac-node \
+    ${SRC_URI_ZEPHYR_LVGL};name=3Dlvgl;nobranch=3D1;destsuffix=3D${P}/modu=
les/lib/gui/lvgl \
+    ${SRC_URI_ZEPHYR_MBEDTLS};name=3Dmbedtls;nobranch=3D1;destsuffix=3D${P=
}/modules/crypto/mbedtls \
+    ${SRC_URI_ZEPHYR_MCUBOOT};name=3Dmcuboot;nobranch=3D1;destsuffix=3D${P=
}/bootloader/mcuboot \
+    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=3Dmipi-sys-t;nobranch=3D1;destsuffix=
=3D${P}/modules/debug/mipi-sys-t \
+    ${SRC_URI_ZEPHYR_NANOPB};name=3Dnanopb;nobranch=3D1;destsuffix=3D${P}/=
modules/lib/nanopb \
+    ${SRC_URI_ZEPHYR_NET_TOOLS};name=3Dnet-tools;nobranch=3D1;destsuffix=
=3D${P}/tools/net-tools \
+    ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=3Dnrf_hw_models;nobranch=3D1;dest=
suffix=3D${P}/modules/bsim_hw_models/nrf_hw_models \
+    ${SRC_URI_ZEPHYR_NRF_WIFI};name=3Dnrf_wifi;nobranch=3D1;destsuffix=3D$=
{P}/modules/lib/nrf_wifi \
+    ${SRC_URI_ZEPHYR_OPEN_AMP};name=3Dopen-amp;nobranch=3D1;destsuffix=3D$=
{P}/modules/lib/open-amp \
+    ${SRC_URI_ZEPHYR_OPENTHREAD};name=3Dopenthread;nobranch=3D1;destsuffix=
=3D${P}/modules/lib/openthread \
+    ${SRC_URI_ZEPHYR_PERCEPIO};name=3Dpercepio;nobranch=3D1;destsuffix=3D$=
{P}/modules/debug/percepio \
+    ${SRC_URI_ZEPHYR_PICOLIBC};name=3Dpicolibc;nobranch=3D1;destsuffix=3D$=
{P}/modules/lib/picolibc \
+    ${SRC_URI_ZEPHYR_SEGGER};name=3Dsegger;nobranch=3D1;destsuffix=3D${P}/=
modules/debug/segger \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=3Dtrusted-firmware-a;nobranc=
h=3D1;destsuffix=3D${P}/modules/tee/tf-a/trusted-firmware-a \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=3Dtrusted-firmware-m;nobranc=
h=3D1;destsuffix=3D${P}/modules/tee/tf-m/trusted-firmware-m \
+    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=3Duoscore-uedhoc;nobranch=3D1;de=
stsuffix=3D${P}/modules/lib/uoscore-uedhoc \
+    ${SRC_URI_ZEPHYR_ZCBOR};name=3Dzcbor;nobranch=3D1;destsuffix=3D${P}/mo=
dules/lib/zcbor \
+    ${SRC_URI_PATCHES} \
+"
+
+ZEPHYR_MODULES =3D "\
+${S}/modules/lib/acpica\;\
+${S}/tools/bsim/components\;\
+${S}/tools/bsim/components/ext_2G4_channel_NtNcable\;\
+${S}/tools/bsim/components/ext_2G4_channel_multiatt\;\
+${S}/tools/bsim/components/ext_2G4_device_WLAN_actmod\;\
+${S}/tools/bsim/components/ext_2G4_device_burst_interferer\;\
+${S}/tools/bsim/components/ext_2G4_device_playback\;\
+${S}/tools/bsim/components/ext_2G4_libPhyComv1\;\
+${S}/tools/bsim/components/ext_2G4_modem_BLE_simple\;\
+${S}/tools/bsim/components/ext_2G4_modem_magic\;\
+${S}/tools/bsim/components/ext_2G4_phy_v1\;\
+${S}/tools/bsim/components/ext_libCryptov1\;\
+${S}/tools/bsim\;\
+${S}/modules/hal/cmsis\;\
+${S}/modules/lib/cmsis-dsp\;\
+${S}/modules/lib/cmsis-nn\;\
+${S}/modules/hal/cmsis_6\;\
+${S}/tools/edtt\;\
+${S}/modules/fs/fatfs\;\
+${S}/modules/hal/adi\;\
+${S}/modules/hal/afbr\;\
+${S}/modules/hal/ambiq\;\
+${S}/modules/hal/atmel\;\
+${S}/modules/hal/bouffalolab\;\
+${S}/modules/hal/espressif\;\
+${S}/modules/hal/ethos_u\;\
+${S}/modules/hal/gigadevice\;\
+${S}/modules/hal/infineon\;\
+${S}/modules/hal/intel\;\
+${S}/modules/hal/microchip\;\
+${S}/modules/hal/nordic\;\
+${S}/modules/hal/nuvoton\;\
+${S}/modules/hal/nxp\;\
+${S}/modules/hal/openisa\;\
+${S}/modules/hal/quicklogic\;\
+${S}/modules/hal/renesas\;\
+${S}/modules/hal/rpi_pico\;\
+${S}/modules/hal/sifli\;\
+${S}/modules/hal/silabs\;\
+${S}/modules/hal/st\;\
+${S}/modules/hal/stm32\;\
+${S}/modules/hal/tdk\;\
+${S}/modules/hal/telink\;\
+${S}/modules/hal/ti\;\
+${S}/modules/hal/wch\;\
+${S}/modules/hal/wurthelektronik\;\
+${S}/modules/hal/xtensa\;\
+${S}/modules/lib/hostap\;\
+${S}/modules/lib/liblc3\;\
+${S}/modules/lib/libmctp\;\
+${S}/modules/hal/libmetal\;\
+${S}/modules/lib/libsbc\;\
+${S}/modules/fs/littlefs\;\
+${S}/modules/lib/lora-basics-modem\;\
+${S}/modules/lib/loramac-node\;\
+${S}/modules/lib/gui/lvgl\;\
+${S}/modules/crypto/mbedtls\;\
+${S}/bootloader/mcuboot\;\
+${S}/modules/debug/mipi-sys-t\;\
+${S}/modules/lib/nanopb\;\
+${S}/tools/net-tools\;\
+${S}/modules/bsim_hw_models/nrf_hw_models\;\
+${S}/modules/lib/nrf_wifi\;\
+${S}/modules/lib/open-amp\;\
+${S}/modules/lib/openthread\;\
+${S}/modules/debug/percepio\;\
+${S}/modules/lib/picolibc\;\
+${S}/modules/debug/segger\;\
+${S}/modules/tee/tf-a/trusted-firmware-a\;\
+${S}/modules/tee/tf-m/trusted-firmware-m\;\
+${S}/modules/lib/uoscore-uedhoc\;\
+${S}/modules/lib/zcbor\;\
+"
+
+ZEPHYR_BRANCH =3D "v4.3-branch"
+PV =3D "4.3.0+git${SRCPV}"
--=20
2.34.1


