Return-Path: <andrej.kozemcak@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E585C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 09:18:42 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.53])
 by mx.groups.io with SMTP id smtpd.web11.23565.1716801515815472655
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 02:18:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=G7qK2EYo;
 spf=pass (domain: siemens.com, ip: 40.107.249.53, mailfrom: andrej.kozemcak@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP/9dtKewJjCLtCLxc28qmX8YGMGptG9j6ZjjS6l2ydzRsjc2zMNaXeDd7ufszOsw5gzWvKH34dEkjpmedjxJdXUJJ+Q8Mz4HFRepA4Bh9bvtPZi/mFgIxJd3KgaS8gjU3+P5/ruQ1UlbJdgrk/gTOxaTdDyAo7rjeyD/OY+iCuVlSXBdkiP2RmtgO8eA3W46E4VM4CUlpT1Cy44e8HQz4pUlc61/KSDwyfqlXMxx5RlzZMUvEeGtWhTI1dFR3cE3QVaAiBZTOdr8ygLht55YFlPNaBOC/ZasavIIuRtAPtOMRm67rHa7i07sTakn0xsaNTNIRDNFPy/5Bdm4DicxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOSVpfghuX1qqRhOjrZqfkp5br72vj9sPXR6sWUaDMI=;
 b=diQXt4IO5nC7XP+6zJlmIsap5q2ZOSYEAmtOvayZX7js7wStMqOwblKst8dBtSBYVVZh2SaqlXNE6yd5mnFne9mzoQMsVtIWr0leOwZyyLt1EjlDtQMIFESLPEj2uvQmVsOeI7ZvMqf29COHMDiJVOEnO9qK0J4K0/mxyZ/ycwKfiU7NBkPml2f4KqOMjAKl1W6FQCKwCZSQwFmRWLCYqVreBNvoTcIKm3zX9VvZZjA90gU2gQdU5etHii7o0ldQmQ5Ok1Q4RilMByYJVJvbIdtdKfwA+e1klALB+5V3TginevFAcCn/WeJAVePhDmt9L3Yq+DJ/V8XFOehdWuPuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOSVpfghuX1qqRhOjrZqfkp5br72vj9sPXR6sWUaDMI=;
 b=G7qK2EYoTWN6Kiin/uLdf9uk2kUalOhK92iCbi9yTJxcLURFnypgfjmuxW0soGLbEJBcwGW/t1da82wiC18ZPDdmz35hXyF0loAQupZXqchFqS2GKvnYzRbQQ8BpmQy5/VxRkn1Li2+dEt5N2lzYnmhncefUffkl02vymWMaHw+HLCbCDgaK+Buaojs4o8DoA82rMuzw38pVyn+lDbrcMW9L/hu9vXfDRbIaDCLW6ograRP2HvhLkqn/fkGS1A9nJcLYniPiaqnELyF2R/iZ05NICpLWsv3/Yv10jtiDEx3ontWD92RYW/yP66/pBgT1FhX1PNcbdwznlFZb3UumOQ==
Received: from AS9PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:542::7) by AS2PR10MB7178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:60e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:18:33 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:542:cafe::1) by AS9PR01CA0028.outlook.office365.com
 (2603:10a6:20b:542::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28 via Frontend
 Transport; Mon, 27 May 2024 09:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=E
Received: from hybrid.siemens.com (194.138.21.74) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:18:32 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 May 2024 11:18:31 +0200
Received: from dev.vm9.ccp.siemens.com (194.138.14.37) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 May 2024 11:18:31 +0200
Received: from dev.vm9.ccp.siemens.com (localhost [127.0.0.1])
	by dev.vm9.ccp.siemens.com (Postfix) with ESMTP id 191B84D4ADB;
	Mon, 27 May 2024 11:18:28 +0200 (CEST)
From: Andrej Kozemcak <andrej.kozemcak@siemens.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Andrej Kozemcak <andrej.kozemcak@siemens.com>
Subject: [meta-java][PATCH] openjdk-8: improve patch for different architecure
Date: Mon, 27 May 2024 11:17:40 +0200
Message-ID: <20240527091740.343852-1-andrej.kozemcak@siemens.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [194.138.14.37]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|AS2PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 8108885e-29e4-4678-30e1-08dc7e2dfad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pZKudwp9+gJz/ymIbh3yjm+I1sQDDL/+WQg0VVcNigdJWUR8bl3PdjbYZB4C?=
 =?us-ascii?Q?PQ8vySbFTZnYJ7hky5lRoaYkzlzlIFnDvJw+eqVctirdcDUY0p8hFFIqZcvg?=
 =?us-ascii?Q?bxm3p6McnTKs4PcDCKbBcErQ8n3nK4iqzGl6tWhgjTsS2BBwz7PYOweMxIWV?=
 =?us-ascii?Q?7kY9yD9+Csztpl1oG87VKRhU1Z2xd22I1CvaaSAm15At53OuDNjbiLIw3E2V?=
 =?us-ascii?Q?4rrLyXP/rUHyQn/72C/p4do6x5VvDNuMhd84Iz5tPKOorpxSEmQ91Hamaxc5?=
 =?us-ascii?Q?sg/1WNLu7PBrt4CA+9mgcEngHtyqkuFicqUlleaR4VFZCH0ZD12iTBuoBmDV?=
 =?us-ascii?Q?lXG2L1S25LBbfEU//ysuymLVNsnVBsWudKhOHY/nQvbE50qnsW48U8dFzZn/?=
 =?us-ascii?Q?DObWLZgB94nlKrVDOjYP4LWLeghc6pOgu4+DkqDZKP3FXEZEdj2bWmuEEOHN?=
 =?us-ascii?Q?V6kU2GzRzfghOmgYCJbmECm8FCmmd7Hf3A/xdmp/qNUmY0HwT2nW9b0OwWN9?=
 =?us-ascii?Q?92JXyzRXD3MMpaeX2BWd/KNrNUHA9+p9ZPZ9QBKdbWvhIDaeCJQJZrmxqS0A?=
 =?us-ascii?Q?i1KvJYMOgnRuxCIW4zzo3FwSapCldbyvVvuoUdpd1XGHba9TudWsWB/dcBj9?=
 =?us-ascii?Q?W69c4DFasJfGAruEdWQzb+tlv/MO809fsXWbeyA8EDEFM5dDhOBn/CNebc4C?=
 =?us-ascii?Q?PgHWMjNHYeuD/m28qqgp78I4gPMW12eIK1JzVCiZuG7QhfuslEqpzKVAGdTe?=
 =?us-ascii?Q?uvOEqC1zlZSIAVEK4ck/hNIq91ZZEnDCEGEiqvAzWI2uhaeBfdv0h4e4F4vl?=
 =?us-ascii?Q?r0KHO5lDPwXTzQc//Z6Nx/lJNcWB24NGEtV2iwO6Hfg29qqPn3L2o1qcKEwi?=
 =?us-ascii?Q?PX/3THNrR2TSlUqC4w6Ixc5fxzR4DZXnIUdSMZ5tuJKUCKb9FvlyByaXJROm?=
 =?us-ascii?Q?waBX6jNDslbdz7xKw2wT5Y9p+k+b/7RL2Y99H5i9Khj+JoNVdSuQwZWKF2G/?=
 =?us-ascii?Q?5fjyc4uxfdsrMqTiOAtdn6gKM1baFH82zYeqvZKB9TYFmIc28xPTzOLwEfJq?=
 =?us-ascii?Q?mPM7wbSYK8WmwnrUThyEWj13mTOYMjjtrZtopHkP2KUW1DL51Yh2fA/hUwfV?=
 =?us-ascii?Q?a4k8LHISQwz59/vh+JRddxYs610y3nmknFhu+tR7khdyLSHksHYZO+GhAOAQ?=
 =?us-ascii?Q?tMoLV+osEiJg2z/b4QjRWzh4w1XRYjCyat6UsssCCzKYjfwi1gRmQ20bJ6JT?=
 =?us-ascii?Q?9Yf4c8uL0eUx/KQa0FrEN0CO6SuSLuL5PGJW/Y7/uW43P8EB1MBehrc7ddRa?=
 =?us-ascii?Q?ijsaS7rWkYNA5vQ16nmV8Tyc/UrIlz1VlPyjFfvsonqxh7HlpvfWbU+eTenA?=
 =?us-ascii?Q?vs9z+KA=3D?=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:18:32.6006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8108885e-29e4-4678-30e1-08dc7e2dfad2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7178
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 09:18:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/209

Arrch64 and arm use same patch for different code. Improve
patch for arm code, so it can be apply without any warnings.

Signed-off-by: Andrej Kozemcak <andrej.kozemcak@siemens.com>
---
 .../openjdk/openjdk-8-release-common.inc      |  12 +-
 ...h32-Turn-on-the-Wreturn-type-warning.patch | 237 ++++++++++++++++++
 ...64-Turn-on-the-Wreturn-type-warning.patch} |   0
 3 files changed, 246 insertions(+), 3 deletions(-)
 create mode 100644 recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aar=
ch32-Turn-on-the-Wreturn-type-warning.patch
 rename recipes-core/openjdk/patches-openjdk-8/{1007-hotspot-Turn-on-the-Wr=
eturn-type-warning.patch =3D> 1007-hotspot-aarch64-Turn-on-the-Wreturn-type=
-warning.patch} (100%)

diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc b/recipes-co=
re/openjdk/openjdk-8-release-common.inc
index ff8d96e..8ef7049 100644
--- a/recipes-core/openjdk/openjdk-8-release-common.inc
+++ b/recipes-core/openjdk/openjdk-8-release-common.inc
@@ -29,7 +29,6 @@ HOTSPOT_UB_PATCH =3D "\
     file://1004-hotspot-fix-Wreturn-type-issues-introduced-by-806165.patch=
 \
     file://1005-hotspot-Zero-build-requires-disabled-warnings.patch \
     file://1006-hotspot-Missing-return-statement-in-__sync_val_compa.patch=
 \
-    file://1007-hotspot-Turn-on-the-Wreturn-type-warning.patch \
     file://1008-hotspot-handle-format-error-for-GCC-7.patch \
     file://1012-hotspot-enable-Wno-error.patch \
 "
@@ -39,10 +38,17 @@ HOTSPOT_UB_PATCH:append:class-target =3D "\
     file://1011-hotspot-restrict-to-staging-dir.patch \
 "
 HOTSPOT_UB_PATCH:prepend:aarch64 =3D "\
+    file://1007-hotspot-aarch64-Turn-on-the-Wreturn-type-warning.patch \
     file://1401-hotspot-aarch64-Add-missing-return-value-to-LIR_Asse.patch=
 \
 "
-HOTSPOT_UB_PATCH:append:armv7a =3D " file://1201-hotspot-aarch32-fix-missi=
ng-return-values.patch"
-HOTSPOT_UB_PATCH:append:armv7ve =3D " file://1201-hotspot-aarch32-fix-miss=
ing-return-values.patch"
+HOTSPOT_UB_PATCH:append:armv7a =3D "\
+    file://1007-hotspot-aarch32-Turn-on-the-Wreturn-type-warning.patch \
+    file://1201-hotspot-aarch32-fix-missing-return-values.patch \
+"
+HOTSPOT_UB_PATCH:append:armv7ve =3D "\
+    file://1007-hotspot-aarch32-Turn-on-the-Wreturn-type-warning.patch \
+    file://1201-hotspot-aarch32-fix-missing-return-values.patch \
+"
=20
 PATCHES_URI:append:class-target =3D "\
     file://1013-hotspot-add-missing-includes-for-shark-build-pt2.patch \
diff --git a/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch32-Tu=
rn-on-the-Wreturn-type-warning.patch b/recipes-core/openjdk/patches-openjdk=
-8/1007-hotspot-aarch32-Turn-on-the-Wreturn-type-warning.patch
new file mode 100644
index 0000000..ecd610c
--- /dev/null
+++ b/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch32-Turn-on-t=
he-Wreturn-type-warning.patch
@@ -0,0 +1,237 @@
+From 6758bf27e31110dc5d4c7237476c823ff05454a2 Mon Sep 17 00:00:00 2001
+From: Richard Leitner <richard.leitner@skidata.com>
+Date: Thu, 22 Oct 2020 09:41:07 +0200
+Subject: [PATCH] hotspot: Turn on the -Wreturn-type warning
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+
+|# HG changeset patch
+|# User stefank
+|# Date 1525453613 -3600
+|#      Fri May 04 18:06:53 2018 +0100
+|# Node ID 07a1135a327362f157955d470fad5df07cc35164
+|# Parent  de79964656fc652f2085dac4fe99bcc128b5a3b1
+8062808, PR3548: Turn on the -Wreturn-type warning
+Reviewed-by: mgerdin, tschatzl, coleenp, jrose, kbarrett
+
+Upstream-Status: Backport
+
+Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@jci.com>
+Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
+
+---
+ hotspot/make/linux/makefiles/gcc.make               | 2 +-
+ hotspot/src/cpu/x86/vm/x86_32.ad                    | 1 +
+ hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp    | 1 +
+ hotspot/src/share/vm/classfile/defaultMethods.cpp   | 4 ++--
+ hotspot/src/share/vm/classfile/symbolTable.cpp      | 4 ++--
+ hotspot/src/share/vm/classfile/systemDictionary.cpp | 6 +++---
+ hotspot/src/share/vm/memory/heapInspection.hpp      | 2 +-
+ hotspot/src/share/vm/memory/metaspaceShared.hpp     | 2 +-
+ hotspot/src/share/vm/oops/constantPool.hpp          | 2 +-
+ hotspot/src/share/vm/prims/jvm.cpp                  | 2 +-
+ hotspot/src/share/vm/runtime/reflection.cpp         | 2 +-
+ hotspot/src/share/vm/runtime/sharedRuntime.cpp      | 2 +-
+ hotspot/src/share/vm/services/memTracker.hpp        | 2 +-
+ 13 files changed, 17 insertions(+), 15 deletions(-)
+
+diff --git a/hotspot/make/linux/makefiles/gcc.make b/hotspot/make/linux/ma=
kefiles/gcc.make
+index 76f738c6..67607fb2 100644
+--- a/hotspot/make/linux/makefiles/gcc.make
++++ b/hotspot/make/linux/makefiles/gcc.make
+@@ -212,7 +212,7 @@ ifeq ($(USE_CLANG), true)
+   WARNINGS_ARE_ERRORS +=3D -Wno-return-type -Wno-empty-body
+ endif
+=20
+-WARNING_FLAGS =3D -Wpointer-arith -Wsign-compare -Wundef -Wunused-functio=
n -Wunused-value
++WARNING_FLAGS =3D -Wpointer-arith -Wsign-compare -Wundef -Wunused-functio=
n -Wunused-value -Wreturn-type
+=20
+ ifeq ($(USE_CLANG),)
+   # Since GCC 4.3, -Wconversion has changed its meanings to warn these im=
plicit
+diff --git a/hotspot/src/cpu/x86/vm/x86_32.ad b/hotspot/src/cpu/x86/vm/x86=
_32.ad
+index f42d1a28..c8f4ee16 100644
+--- a/hotspot/src/cpu/x86/vm/x86_32.ad
++++ b/hotspot/src/cpu/x86/vm/x86_32.ad
+@@ -1250,6 +1250,7 @@ uint MachSpillCopyNode::implementation( CodeBuffer *=
cbuf, PhaseRegAlloc *ra_, bo
+=20
+=20
+   Unimplemented();
++  return 0; // Mute compiler
+ }
+=20
+ #ifndef PRODUCT
+diff --git a/hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp b/hotspot/sr=
c/os_cpu/linux_x86/vm/os_linux_x86.cpp
+index c35d8677..65c3165c 100644
+--- a/hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp
++++ b/hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp
+@@ -541,6 +541,7 @@ JVM_handle_linux_signal(int sig,
+   err.report_and_die();
+=20
+   ShouldNotReachHere();
++  return true; // Mute compiler
+ }
+=20
+ void os::Linux::init_thread_fpu_state(void) {
+diff --git a/hotspot/src/share/vm/classfile/defaultMethods.cpp b/hotspot/s=
rc/share/vm/classfile/defaultMethods.cpp
+index 4b4b4e25..196622ae 100644
+--- a/hotspot/src/share/vm/classfile/defaultMethods.cpp
++++ b/hotspot/src/share/vm/classfile/defaultMethods.cpp
+@@ -506,7 +506,7 @@ Symbol* MethodFamily::generate_method_message(Symbol *=
klass_name, Method* method
+   ss.write((const char*)name->bytes(), name->utf8_length());
+   ss.write((const char*)signature->bytes(), signature->utf8_length());
+   ss.print(" is abstract");
+-  return SymbolTable::new_symbol(ss.base(), (int)ss.size(), CHECK_NULL);
++  return SymbolTable::new_symbol(ss.base(), (int)ss.size(), THREAD);
+ }
+=20
+ Symbol* MethodFamily::generate_conflicts_message(GrowableArray<Method*>* =
methods, TRAPS) const {
+@@ -521,7 +521,7 @@ Symbol* MethodFamily::generate_conflicts_message(Growa=
bleArray<Method*>* methods
+     ss.print(".");
+     ss.write((const char*)name->bytes(), name->utf8_length());
+   }
+-  return SymbolTable::new_symbol(ss.base(), (int)ss.size(), CHECK_NULL);
++  return SymbolTable::new_symbol(ss.base(), (int)ss.size(), THREAD);
+ }
+=20
+=20
+diff --git a/hotspot/src/share/vm/classfile/symbolTable.cpp b/hotspot/src/=
share/vm/classfile/symbolTable.cpp
+index ec97077b..2621a7d6 100644
+--- a/hotspot/src/share/vm/classfile/symbolTable.cpp
++++ b/hotspot/src/share/vm/classfile/symbolTable.cpp
+@@ -249,7 +249,7 @@ Symbol* SymbolTable::lookup(const char* name, int len,=
 TRAPS) {
+   MutexLocker ml(SymbolTable_lock, THREAD);
+=20
+   // Otherwise, add to symbol to table
+-  return the_table()->basic_add(index, (u1*)name, len, hashValue, true, C=
HECK_NULL);
++  return the_table()->basic_add(index, (u1*)name, len, hashValue, true, T=
HREAD);
+ }
+=20
+ Symbol* SymbolTable::lookup(const Symbol* sym, int begin, int end, TRAPS)=
 {
+@@ -288,7 +288,7 @@ Symbol* SymbolTable::lookup(const Symbol* sym, int beg=
in, int end, TRAPS) {
+   // Grab SymbolTable_lock first.
+   MutexLocker ml(SymbolTable_lock, THREAD);
+=20
+-  return the_table()->basic_add(index, (u1*)buffer, len, hashValue, true,=
 CHECK_NULL);
++  return the_table()->basic_add(index, (u1*)buffer, len, hashValue, true,=
 THREAD);
+ }
+=20
+ Symbol* SymbolTable::lookup_only(const char* name, int len,
+diff --git a/hotspot/src/share/vm/classfile/systemDictionary.cpp b/hotspot=
/src/share/vm/classfile/systemDictionary.cpp
+index 3e64b719..b1dd335c 100644
+--- a/hotspot/src/share/vm/classfile/systemDictionary.cpp
++++ b/hotspot/src/share/vm/classfile/systemDictionary.cpp
+@@ -236,15 +236,15 @@ Klass* SystemDictionary::resolve_or_null(Symbol* cla=
ss_name, Handle class_loader
+                  class_name->as_C_string(),
+                  class_loader.is_null() ? "null" : class_loader->klass()-=
>name()->as_C_string()));
+   if (FieldType::is_array(class_name)) {
+-    return resolve_array_class_or_null(class_name, class_loader, protecti=
on_domain, CHECK_NULL);
++    return resolve_array_class_or_null(class_name, class_loader, protecti=
on_domain, THREAD);
+   } else if (FieldType::is_obj(class_name)) {
+     ResourceMark rm(THREAD);
+     // Ignore wrapping L and ;.
+     TempNewSymbol name =3D SymbolTable::new_symbol(class_name->as_C_strin=
g() + 1,
+                                    class_name->utf8_length() - 2, CHECK_N=
ULL);
+-    return resolve_instance_class_or_null(name, class_loader, protection_=
domain, CHECK_NULL);
++    return resolve_instance_class_or_null(name, class_loader, protection_=
domain, THREAD);
+   } else {
+-    return resolve_instance_class_or_null(class_name, class_loader, prote=
ction_domain, CHECK_NULL);
++    return resolve_instance_class_or_null(class_name, class_loader, prote=
ction_domain, THREAD);
+   }
+ }
+=20
+diff --git a/hotspot/src/share/vm/memory/heapInspection.hpp b/hotspot/src/=
share/vm/memory/heapInspection.hpp
+index 09ee6602..c5fec15c 100644
+--- a/hotspot/src/share/vm/memory/heapInspection.hpp
++++ b/hotspot/src/share/vm/memory/heapInspection.hpp
+@@ -367,7 +367,7 @@ class HeapInspection : public StackObj {
+       _csv_format(csv_format), _print_help(print_help),
+       _print_class_stats(print_class_stats), _columns(columns) {}
+   void heap_inspection(outputStream* st) NOT_SERVICES_RETURN;
+-  size_t populate_table(KlassInfoTable* cit, BoolObjectClosure* filter =
=3D NULL) NOT_SERVICES_RETURN;
++  size_t populate_table(KlassInfoTable* cit, BoolObjectClosure* filter =
=3D NULL) NOT_SERVICES_RETURN_(0);
+   static void find_instances_at_safepoint(Klass* k, GrowableArray<oop>* r=
esult) NOT_SERVICES_RETURN;
+  private:
+   void iterate_over_heap(KlassInfoTable* cit, BoolObjectClosure* filter =
=3D NULL);
+diff --git a/hotspot/src/share/vm/memory/metaspaceShared.hpp b/hotspot/src=
/share/vm/memory/metaspaceShared.hpp
+index 2f3abae6..d58ebecb 100644
+--- a/hotspot/src/share/vm/memory/metaspaceShared.hpp
++++ b/hotspot/src/share/vm/memory/metaspaceShared.hpp
+@@ -93,7 +93,7 @@ class MetaspaceShared : AllStatic {
+   static void preload_and_dump(TRAPS) NOT_CDS_RETURN;
+   static int preload_and_dump(const char * class_list_path,
+                               GrowableArray<Klass*>* class_promote_order,
+-                              TRAPS) NOT_CDS_RETURN;
++                              TRAPS) NOT_CDS_RETURN_(0);
+=20
+   static ReservedSpace* shared_rs() {
+     CDS_ONLY(return _shared_rs);
+diff --git a/hotspot/src/share/vm/oops/constantPool.hpp b/hotspot/src/shar=
e/vm/oops/constantPool.hpp
+index 124c970e..dae574c0 100644
+--- a/hotspot/src/share/vm/oops/constantPool.hpp
++++ b/hotspot/src/share/vm/oops/constantPool.hpp
+@@ -353,7 +353,7 @@ class ConstantPool : public Metadata {
+=20
+   Klass* klass_at(int which, TRAPS) {
+     constantPoolHandle h_this(THREAD, this);
+-    return klass_at_impl(h_this, which, CHECK_NULL);
++    return klass_at_impl(h_this, which, THREAD);
+   }
+=20
+   Symbol* klass_name_at(int which);  // Returns the name, w/o resolving.
+diff --git a/hotspot/src/share/vm/prims/jvm.cpp b/hotspot/src/share/vm/pri=
ms/jvm.cpp
+index 6f2221c4..daa69f89 100644
+--- a/hotspot/src/share/vm/prims/jvm.cpp
++++ b/hotspot/src/share/vm/prims/jvm.cpp
+@@ -4368,7 +4368,7 @@ JVM_ENTRY(jlong,JVM_DTraceActivate(
+     JVM_DTraceProvider* providers))
+   JVMWrapper("JVM_DTraceActivate");
+   return DTraceJSDT::activate(
+-    version, module_name, providers_count, providers, CHECK_0);
++    version, module_name, providers_count, providers, THREAD);
+ JVM_END
+=20
+ JVM_ENTRY(jboolean,JVM_DTraceIsProbeEnabled(JNIEnv* env, jmethodID method=
))
+diff --git a/hotspot/src/share/vm/runtime/reflection.cpp b/hotspot/src/sha=
re/vm/runtime/reflection.cpp
+index d9fddbe4..a5f73793 100644
+--- a/hotspot/src/share/vm/runtime/reflection.cpp
++++ b/hotspot/src/share/vm/runtime/reflection.cpp
+@@ -1093,7 +1093,7 @@ oop Reflection::invoke(instanceKlassHandle klass, me=
thodHandle reflected_method,
+   } else {
+     if (rtype =3D=3D T_BOOLEAN || rtype =3D=3D T_BYTE || rtype =3D=3D T_C=
HAR || rtype =3D=3D T_SHORT)
+       narrow((jvalue*) result.get_value_addr(), rtype, CHECK_NULL);
+-    return box((jvalue*) result.get_value_addr(), rtype, CHECK_NULL);
++    return box((jvalue*) result.get_value_addr(), rtype, THREAD);
+   }
+ }
+=20
+diff --git a/hotspot/src/share/vm/runtime/sharedRuntime.cpp b/hotspot/src/=
share/vm/runtime/sharedRuntime.cpp
+index 013aa7a2..df4cde96 100644
+--- a/hotspot/src/share/vm/runtime/sharedRuntime.cpp
++++ b/hotspot/src/share/vm/runtime/sharedRuntime.cpp
+@@ -1045,7 +1045,7 @@ Handle SharedRuntime::find_callee_info(JavaThread* t=
hread, Bytecodes::Code& bc,
+   // last java frame on stack (which includes native call frames)
+   vframeStream vfst(thread, true);  // Do not skip and javaCalls
+=20
+-  return find_callee_info_helper(thread, vfst, bc, callinfo, CHECK_(Handl=
e()));
++  return find_callee_info_helper(thread, vfst, bc, callinfo, THREAD);
+ }
+=20
+=20
+diff --git a/hotspot/src/share/vm/services/memTracker.hpp b/hotspot/src/sh=
are/vm/services/memTracker.hpp
+index 8ea859dd..535147f8 100644
+--- a/hotspot/src/share/vm/services/memTracker.hpp
++++ b/hotspot/src/share/vm/services/memTracker.hpp
+@@ -64,7 +64,7 @@ class MemTracker : AllStatic {
+     const NativeCallStack& stack, MEMFLAGS flag =3D mtNone) { }
+   static inline void record_virtual_memory_commit(void* addr, size_t size=
, const NativeCallStack& stack) { }
+   static inline Tracker get_virtual_memory_uncommit_tracker() { return Tr=
acker(); }
+-  static inline Tracker get_virtual_memory_release_tracker() { }
++  static inline Tracker get_virtual_memory_release_tracker() { return Tra=
cker(); }
+   static inline void record_virtual_memory_type(void* addr, MEMFLAGS flag=
) { }
+   static inline void record_thread_stack(void* addr, size_t size) { }
+   static inline void release_thread_stack(void* addr, size_t size) { }
diff --git a/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-Turn-on-th=
e-Wreturn-type-warning.patch b/recipes-core/openjdk/patches-openjdk-8/1007-=
hotspot-aarch64-Turn-on-the-Wreturn-type-warning.patch
similarity index 100%
rename from recipes-core/openjdk/patches-openjdk-8/1007-hotspot-Turn-on-the=
-Wreturn-type-warning.patch
rename to recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch64-Turn-=
on-the-Wreturn-type-warning.patch
--=20
2.39.2


