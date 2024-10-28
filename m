Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FB2D3398C
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 14:19:21 +0000 (UTC)
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
 by mx.groups.io with SMTP id smtpd.web10.52977.1730125153401689962
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Oct 2024 07:19:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 185.125.25.15, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xcb9W4nsKzD4g;
	Mon, 28 Oct 2024 15:19:11 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xcb9W0gTlzL1T;
	Mon, 28 Oct 2024 15:19:11 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 28 Oct 2024 15:18:47 +0100
Subject: [meta-rockchip PATCH] bsp: trusted-firmware-a: update patches'
 upstream status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-tf-a-patch-submitted-v1-1-4a4543c3331b@cherry.de>
X-B4-Tracking: v=1; b=H4sIAEadH2cC/x3MwQqDMAyA4VeRnBewQXHuVcYOWY1rELW0UQTx3
 Vc8fof/PyFLUsnwqk5IsmvWdSlwjwp84OUnqEMxUE2Nq+mJNiJjZPMB8/ad1UwGFG6pdx05ajo
 oaUwy6nFv3zCLMabVTz5ohM91/QEs32IGdQAAAA==
X-Change-ID: 20241028-tf-a-patch-submitted-ea5291721247
To: yocto-patches@lists.yoctoproject.org
Cc: raj.khem@gmail.com, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Oct 2024 14:19:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/767

From: Quentin Schulz <quentin.schulz@cherry.de>

The patches were sent upstream for review, so let's update their
upstream status to point at the patchset in the appropriate Gerrit.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 ...01-fix-rk3399-dram-Fix-build-with-gcc-11.patch} | 14 ++++++++------
 ...-plat_macros.S-Use-compatible-.asciz-asm.patch} | 15 +++++++++------
 ...-pmu-Do-not-mark-already-defined-functio.patch} | 22 ++++++++++++++--------
 .../trusted-firmware-a_%.bbappend                  |  6 +++---
 4 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-with-gcc-11.patch b/recipes-bsp/trusted-firmware-a/files/0001-fix-rk3399-dram-Fix-build-with-gcc-11.patch
similarity index 71%
rename from recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-with-gcc-11.patch
rename to recipes-bsp/trusted-firmware-a/files/0001-fix-rk3399-dram-Fix-build-with-gcc-11.patch
index 120ea0bd363577ed8ed3ce39f93b2561b841e20e..de287c3ef3b3fe2701f3ddb5b3accbdcccca280f 100644
--- a/recipes-bsp/trusted-firmware-a/files/0001-dram-Fix-build-with-gcc-11.patch
+++ b/recipes-bsp/trusted-firmware-a/files/0001-fix-rk3399-dram-Fix-build-with-gcc-11.patch
@@ -1,7 +1,7 @@
-From a09a1de53aba422249a8376b0d95024200021317 Mon Sep 17 00:00:00 2001
+From 300856a62de723e9a04376172e26fb01fa210f6f Mon Sep 17 00:00:00 2001
 From: Khem Raj <raj.khem@gmail.com>
 Date: Tue, 11 May 2021 11:55:31 -0700
-Subject: [PATCH] dram: Fix build with gcc 11
+Subject: [PATCH 1/3] fix(rk3399): dram: Fix build with gcc 11
 
 This is a redundant assignment which GCC warns about.
 
@@ -11,8 +11,13 @@ plat/rockchip/rk3399/drivers/dram/dram_spec_timing.c:781:11: error: explicitly a
                 twr_tmp = twr_tmp;
                 ~~~~~~~ ^ ~~~~~~~
 
-Upstream-Status: Pending
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
+[add fix(rk3399): prefix to commit title]
+Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
+Change-Id: Ib12281e0720346ffe68e81a24ea772ddc89d4f83
+
+Upstream-Status: Submitted [https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/33082]
+Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
 ---
  plat/rockchip/rk3399/drivers/dram/dram_spec_timing.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
@@ -30,6 +35,3 @@ index 3cdb7a296..76bc5ee96 100644
  	else if (twr_tmp <= 14)
  		twr_tmp = 14;
  	else
--- 
-2.31.1
-
diff --git a/recipes-bsp/trusted-firmware-a/files/0001-plat_macros.S-Use-compatible-.asciz-asm-directive.patch b/recipes-bsp/trusted-firmware-a/files/0002-fix-rockchip-plat_macros.S-Use-compatible-.asciz-asm.patch
similarity index 64%
rename from recipes-bsp/trusted-firmware-a/files/0001-plat_macros.S-Use-compatible-.asciz-asm-directive.patch
rename to recipes-bsp/trusted-firmware-a/files/0002-fix-rockchip-plat_macros.S-Use-compatible-.asciz-asm.patch
index 8807fcaabc0598d9c92b038fa6b443d2d1063945..a6b1522289dc6a12abfa956b3070ea1c01a6cecf 100644
--- a/recipes-bsp/trusted-firmware-a/files/0001-plat_macros.S-Use-compatible-.asciz-asm-directive.patch
+++ b/recipes-bsp/trusted-firmware-a/files/0002-fix-rockchip-plat_macros.S-Use-compatible-.asciz-asm.patch
@@ -1,13 +1,19 @@
-From 5f78ce7eb9ab6bf5af682a715a9264d2a5ee7666 Mon Sep 17 00:00:00 2001
+From 1dcf6b1f6f50396c503c9506629c7a9371f8118b Mon Sep 17 00:00:00 2001
 From: Khem Raj <raj.khem@gmail.com>
 Date: Tue, 11 May 2021 12:06:34 -0700
-Subject: [PATCH] plat_macros.S: Use compatible .asciz asm directive
+Subject: [PATCH 2/3] fix(rockchip): plat_macros.S: Use compatible .asciz asm
+ directive
 
 clang asm does not like two strings to .asciz therefore make it single
 string which works on clang too.
 
-Upstream-Status: Pending
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
+[added fix(rockchip): prefix to commit title]
+Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
+Change-Id: I5bbc71b3d78c479d0f8099ee0a95ed77287c2bc2
+
+Upstream-Status: Submitted [https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/33083]
+Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
 ---
  plat/rockchip/common/include/plat_macros.S | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)
@@ -26,6 +32,3 @@ index 691beeb44..c07be9ca9 100644
  newline:
  	.asciz "\n"
  spacer:
--- 
-2.31.1
-
diff --git a/recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch b/recipes-bsp/trusted-firmware-a/files/0003-fix-rockchip-pmu-Do-not-mark-already-defined-functio.patch
similarity index 59%
rename from recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch
rename to recipes-bsp/trusted-firmware-a/files/0003-fix-rockchip-pmu-Do-not-mark-already-defined-functio.patch
index bd4d2b594e4440024822ea23da49fb8bb2614527..7d9d8a986f790ae09a017f9cc8582baf69d5ddb3 100644
--- a/recipes-bsp/trusted-firmware-a/files/0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch
+++ b/recipes-bsp/trusted-firmware-a/files/0003-fix-rockchip-pmu-Do-not-mark-already-defined-functio.patch
@@ -1,24 +1,33 @@
-From 9d963cd69faf94bdcb80624132fd10392f57875b Mon Sep 17 00:00:00 2001
+From ba25a5bb2641feeacadbd7ec01ab03169aa0da6e Mon Sep 17 00:00:00 2001
 From: Khem Raj <raj.khem@gmail.com>
 Date: Tue, 11 May 2021 12:11:51 -0700
-Subject: [PATCH] pmu: Do not mark already defined functions as weak
+Subject: [PATCH 3/3] fix(rockchip): pmu: Do not mark already defined functions
+ as weak
 
 These functions are already defined as static functions in same header
 Fixes
 
-| plat/rockchip/common/drivers/pmu/pmu_com.h:35:14: error: weak identifier 'pmu_power_domain_ctr' never declared [-Werror]                                                                                      | #pragma weak pmu_power_domain_ctr                                                                                                                                                                             |              ^
+| plat/rockchip/common/drivers/pmu/pmu_com.h:35:14: error: weak identifier 'pmu_power_domain_ctr' never declared [-Werror]
+| #pragma weak pmu_power_domain_ctr
+|              ^
 | plat/rockchip/common/drivers/pmu/pmu_com.h:36:14: error: weak identifier 'check_cpu_wfie' never declared [-Werror]
 | #pragma weak check_cpu_wfie
 |              ^
 
-Upstream-Status: Pending
 Signed-off-by: Khem Raj <raj.khem@gmail.com>
+[fixed alignment in commit log]
+[added fix(rockchip): prefix in commit title]
+Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
+Change-Id: I96d4acbe743ba4b8996f0be0fa713b341bd4903c
+
+Upstream-Status: Submitted [https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/33084]
+Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
 ---
  plat/rockchip/common/drivers/pmu/pmu_com.h | 2 --
  1 file changed, 2 deletions(-)
 
 diff --git a/plat/rockchip/common/drivers/pmu/pmu_com.h b/plat/rockchip/common/drivers/pmu/pmu_com.h
-index 5359f73b4..3f9ce7df9 100644
+index 022bb024a..259c8c006 100644
 --- a/plat/rockchip/common/drivers/pmu/pmu_com.h
 +++ b/plat/rockchip/common/drivers/pmu/pmu_com.h
 @@ -32,8 +32,6 @@ enum pmu_pd_state {
@@ -30,6 +39,3 @@ index 5359f73b4..3f9ce7df9 100644
  
  static inline uint32_t pmu_power_domain_st(uint32_t pd)
  {
--- 
-2.31.1
-
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
index c9ad84c248578cd93aeb368f064e58ecf08ca383..8eca63a7a78cc96052455875ce75135a7219abaf 100644
--- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
@@ -8,9 +8,9 @@ COMPATIBLE_MACHINE:append:px30 = "|px30"
 
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 SRC_URI += "\
-    file://0001-dram-Fix-build-with-gcc-11.patch \
-    file://0001-plat_macros.S-Use-compatible-.asciz-asm-directive.patch \
-    file://0001-pmu-Do-not-mark-already-defined-functions-as-weak.patch \
+    file://0001-fix-rk3399-dram-Fix-build-with-gcc-11.patch \
+    file://0002-fix-rockchip-plat_macros.S-Use-compatible-.asciz-asm.patch \
+    file://0003-fix-rockchip-pmu-Do-not-mark-already-defined-functio.patch \
 "
 
 

---
base-commit: 24a411a17f389650c4cea38bef1f9279117fab8e
change-id: 20241028-tf-a-patch-submitted-ea5291721247

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


