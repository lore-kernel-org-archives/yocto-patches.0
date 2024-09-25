Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9089BC369C7
	for <webhook@archiver.kernel.org>; Wed, 25 Sep 2024 10:05:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.11453.1727257013982709839
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Sep 2024 02:36:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ben.cownley@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D396712FC;
	Wed, 25 Sep 2024 02:37:22 -0700 (PDT)
Received: from e125927.manchester.arm.com (unknown [10.32.102.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FA053F64C;
	Wed, 25 Sep 2024 02:36:52 -0700 (PDT)
From: "Ben Cownley" <ben.cownley@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ben Cownley <ben.cownley@arm.com>
Subject: [meta-zephyr][PATCH 1/2] topics/baicow01/zephyr-ARCH-remove: Remove ARCH from meta-zephyr
Date: Wed, 25 Sep 2024 10:36:39 +0100
Message-Id: <20240925093640.17353-1-Ben.Cownley@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Sep 2024 10:05:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/671

meta-zephyr current passes an ARCH variable to the CMake build
It's widely believed this is no longer necessary as it is
inferred from the BOARD variable

Signed-off-by: Ben Cownley <ben.cownley@arm.com>
---
 meta-zephyr-bsp/conf/machine/96b-avenger96.conf                  | 1 -
 meta-zephyr-bsp/conf/machine/96b-nitrogen.conf                   | 1 -
 meta-zephyr-bsp/conf/machine/arduino-nano-33-ble.conf            | 1 -
 meta-zephyr-bsp/conf/machine/frdm-kw41z.conf                     | 1 -
 meta-zephyr-bsp/conf/machine/intel-x86-64.conf                   | 1 -
 meta-zephyr-bsp/conf/machine/mps2-an385.conf                     | 1 -
 meta-zephyr-bsp/conf/machine/mps2-an521.conf                     | 1 -
 meta-zephyr-bsp/conf/machine/mps3-an547.conf                     | 1 -
 meta-zephyr-bsp/conf/machine/nrf52840-mdk-usb-dongle.conf        | 1 -
 meta-zephyr-bsp/conf/machine/nrf52840dk-nrf52840.conf            | 1 -
 meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf                | 1 -
 meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf                 | 1 -
 meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf                 | 1 -
 meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf                 | 1 -
 meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf                 | 1 -
 meta-zephyr-bsp/conf/machine/qemu-nios2.conf                     | 1 -
 meta-zephyr-bsp/conf/machine/qemu-x86.conf                       | 1 -
 meta-zephyr-bsp/conf/machine/stm32mp157c-dk2.conf                | 1 -
 meta-zephyr-bsp/conf/machine/v2m-beetle.conf                     | 1 -
 meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf                   | 1 -
 meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf                   | 1 -
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc        | 1 -
 22 files changed, 22 deletions(-)

diff --git a/meta-zephyr-bsp/conf/machine/96b-avenger96.conf b/meta-zephy=
r-bsp/conf/machine/96b-avenger96.conf
index ae6f972..5c493b1 100644
--- a/meta-zephyr-bsp/conf/machine/96b-avenger96.conf
+++ b/meta-zephyr-bsp/conf/machine/96b-avenger96.conf
@@ -5,4 +5,3 @@
=20
 require conf/machine/include/stm32mp1-cortex-m4.inc
=20
-ARCH:96b-avenger96 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/96b-nitrogen.conf b/meta-zephyr=
-bsp/conf/machine/96b-nitrogen.conf
index affe9eb..65bdfbf 100644
--- a/meta-zephyr-bsp/conf/machine/96b-nitrogen.conf
+++ b/meta-zephyr-bsp/conf/machine/96b-nitrogen.conf
@@ -5,4 +5,3 @@
=20
 require conf/machine/include/nrf52.inc
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-flash-pyocd"
-ARCH:96b-nitrogen =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/arduino-nano-33-ble.conf b/meta=
-zephyr-bsp/conf/machine/arduino-nano-33-ble.conf
index ebf4155..c6ffa67 100644
--- a/meta-zephyr-bsp/conf/machine/arduino-nano-33-ble.conf
+++ b/meta-zephyr-bsp/conf/machine/arduino-nano-33-ble.conf
@@ -5,5 +5,4 @@
=20
 require conf/machine/include/nrf52.inc
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-flash-bossac"
-ARCH:arduino-nano-33-ble =3D "arm"
=20
diff --git a/meta-zephyr-bsp/conf/machine/frdm-kw41z.conf b/meta-zephyr-b=
sp/conf/machine/frdm-kw41z.conf
index 464e83a..46b1e0e 100755
--- a/meta-zephyr-bsp/conf/machine/frdm-kw41z.conf
+++ b/meta-zephyr-bsp/conf/machine/frdm-kw41z.conf
@@ -6,6 +6,5 @@
=20
 require conf/machine/include/arm/armv6m/tune-cortexm0plus.inc
=20
-ARCH:frdm-kw41z =3D "arm"
=20
 DEFAULTUNE ?=3D "cortexm0plus"
diff --git a/meta-zephyr-bsp/conf/machine/intel-x86-64.conf b/meta-zephyr=
-bsp/conf/machine/intel-x86-64.conf
index 5112f28..4bda0cd 100644
--- a/meta-zephyr-bsp/conf/machine/intel-x86-64.conf
+++ b/meta-zephyr-bsp/conf/machine/intel-x86-64.conf
@@ -4,7 +4,6 @@
=20
 require conf/machine/include/tune-corei7-common.inc
=20
-ARCH:intel-x86-64 =3D "x86"
=20
 # Supported Boards:
 # ZEPHYR_BOARD ?=3D "acrn"
diff --git a/meta-zephyr-bsp/conf/machine/mps2-an385.conf b/meta-zephyr-b=
sp/conf/machine/mps2-an385.conf
index 159e1bd..bb67972 100644
--- a/meta-zephyr-bsp/conf/machine/mps2-an385.conf
+++ b/meta-zephyr-bsp/conf/machine/mps2-an385.conf
@@ -16,4 +16,3 @@ QB_OPT_APPEND =3D "-icount shift=3D7,align=3Doff,sleep=3D=
off -rtc clock=3Dvm"
=20
 # Zephyr RTOS settings
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
-ARCH:mps2-an385 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/mps2-an521.conf b/meta-zephyr-b=
sp/conf/machine/mps2-an521.conf
index acd02be..fb763ea 100644
--- a/meta-zephyr-bsp/conf/machine/mps2-an521.conf
+++ b/meta-zephyr-bsp/conf/machine/mps2-an521.conf
@@ -18,4 +18,3 @@ QB_OPT_APPEND =3D "-icount shift=3D7,align=3Doff,sleep=3D=
off -rtc clock=3Dvm"
=20
 # Zephyr RTOS settings
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
-ARCH:mps2-an521 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/mps3-an547.conf b/meta-zephyr-b=
sp/conf/machine/mps3-an547.conf
index 185c425..c3ebd2c 100644
--- a/meta-zephyr-bsp/conf/machine/mps3-an547.conf
+++ b/meta-zephyr-bsp/conf/machine/mps3-an547.conf
@@ -17,4 +17,3 @@ QB_OPT_APPEND =3D "-icount shift=3D7,align=3Doff,sleep=3D=
off -rtc clock=3Dvm"
=20
 # Zephyr RTOS settings
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
-ARCH:mps3-an547 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/nrf52840-mdk-usb-dongle.conf b/=
meta-zephyr-bsp/conf/machine/nrf52840-mdk-usb-dongle.conf
index 67e407a..448f1ed 100644
--- a/meta-zephyr-bsp/conf/machine/nrf52840-mdk-usb-dongle.conf
+++ b/meta-zephyr-bsp/conf/machine/nrf52840-mdk-usb-dongle.conf
@@ -4,4 +4,3 @@
 #@DESCRIPTION: Machine configuration for makerdiary's nrf52840-mdk-usb-d=
ongle
=20
 require conf/machine/include/nrf52.inc
-ARCH:nrf52840-mdk-usb-dongle =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/nrf52840dk-nrf52840.conf b/meta=
-zephyr-bsp/conf/machine/nrf52840dk-nrf52840.conf
index 258aa7a..bd99878 100644
--- a/meta-zephyr-bsp/conf/machine/nrf52840dk-nrf52840.conf
+++ b/meta-zephyr-bsp/conf/machine/nrf52840dk-nrf52840.conf
@@ -5,4 +5,3 @@
=20
 require conf/machine/include/nrf52.inc
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-flash-pyocd"
-ARCH:nrf52840dk-nrf52840 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf b/meta-zep=
hyr-bsp/conf/machine/qemu-cortex-a53.conf
index e21f3da..4a511f9 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf
@@ -17,4 +17,3 @@ QB_OPT_APPEND =3D "-icount shift=3D4,align=3Doff,sleep=3D=
on -rtc clock=3Dvm"
 # Zephyr RTOS settings
 ZEPHYR_BOARD =3D "qemu_cortex_a53"
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
-ARCH:qemu-cortex-a53 =3D "aarch64"
diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf b/meta-zeph=
yr-bsp/conf/machine/qemu-cortex-a9.conf
index 9dfee42..4ce6e56 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
@@ -17,4 +17,3 @@ QB_OPT_APPEND =3D "-icount shift=3D3,align=3Doff,sleep=3D=
off -rtc clock=3Dvm"
=20
 # Zephyr RTOS settings
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
-ARCH:qemu-cortex-a9 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf b/meta-zeph=
yr-bsp/conf/machine/qemu-cortex-m0.conf
index 736579e..9a01efd 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf
@@ -21,4 +21,3 @@ QB_OPT_APPEND =3D "-icount shift=3D6,align=3Doff,sleep=3D=
off -rtc clock=3Dvm"
 # Zephyr RTOS settings
 ZEPHYR_BOARD =3D "qemu_cortex_m0"
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
-ARCH:qemu-cortex-m0 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf b/meta-zeph=
yr-bsp/conf/machine/qemu-cortex-m3.conf
index 904a79b..2314dc5 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf
@@ -15,4 +15,3 @@ QB_CPU =3D "-cpu cortex-m3"
 QB_RNG =3D ""
 QB_OPT_APPEND =3D "-icount shift=3D6,align=3Doff,sleep=3Doff -rtc clock=3D=
vm"
=20
-ARCH:qemu-cortex-m3 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf b/meta-zeph=
yr-bsp/conf/machine/qemu-cortex-r5.conf
index 5a0ea69..e85a42c 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf
@@ -19,4 +19,3 @@ QB_RNG =3D ""
 # Zephyr RTOS settings
 ZEPHYR_BOARD =3D "qemu_cortex_r5"
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
-ARCH:qemu-cortex-r5 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/qemu-nios2.conf b/meta-zephyr-b=
sp/conf/machine/qemu-nios2.conf
index c41f505..e9420b5 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-nios2.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-nios2.conf
@@ -13,6 +13,5 @@ QB_MACHINE =3D "-machine altera_10m50_zephyr"
 QB_OPT_APPEND =3D "-nographic"
 QB_CPU =3D "-cpu nios2"
=20
-ARCH:qemu-nios2 =3D "nios2"
=20
 TCLIBC =3D "glibc"
diff --git a/meta-zephyr-bsp/conf/machine/qemu-x86.conf b/meta-zephyr-bsp=
/conf/machine/qemu-x86.conf
index d21de35..3535a4c 100644
--- a/meta-zephyr-bsp/conf/machine/qemu-x86.conf
+++ b/meta-zephyr-bsp/conf/machine/qemu-x86.conf
@@ -14,4 +14,3 @@ QB_GRAPHICS =3D "-nographic -no-acpi"
 QB_CPU:x86 =3D "-cpu qemu32,+nx,+pae"
 QB_CPU_KVM:x86 =3D "-cpu kvm32"
=20
-ARCH:qemu-x86 =3D "x86"
diff --git a/meta-zephyr-bsp/conf/machine/stm32mp157c-dk2.conf b/meta-zep=
hyr-bsp/conf/machine/stm32mp157c-dk2.conf
index 52c1819..c81b30e 100644
--- a/meta-zephyr-bsp/conf/machine/stm32mp157c-dk2.conf
+++ b/meta-zephyr-bsp/conf/machine/stm32mp157c-dk2.conf
@@ -5,4 +5,3 @@
=20
 require conf/machine/include/stm32mp1-cortex-m4.inc
=20
-ARCH:stm32mp157c-dk2 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/v2m-beetle.conf b/meta-zephyr-b=
sp/conf/machine/v2m-beetle.conf
index 37895c6..4065496 100644
--- a/meta-zephyr-bsp/conf/machine/v2m-beetle.conf
+++ b/meta-zephyr-bsp/conf/machine/v2m-beetle.conf
@@ -9,4 +9,3 @@ require conf/machine/include/arm/armv7m/tune-cortexm3.inc
 # GLIBC will not work with Cortex-M.
 TCLIBC =3D "newlib"
=20
-ARCH:beetle =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf b/meta-zephyr=
-bsp/conf/machine/v2m-musca-b1.conf
index 171e899..af5ae5e 100644
--- a/meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf
+++ b/meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf
@@ -22,4 +22,3 @@ QB_MEM =3D "512k"
 # Zephyr RTOS settings
 ZEPHYR_BOARD =3D "v2m_musca_b1"
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
-ARCH:musca-b1 =3D "arm"
diff --git a/meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf b/meta-zephyr=
-bsp/conf/machine/v2m-musca-s1.conf
index c43d560..be7a42b 100644
--- a/meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf
+++ b/meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf
@@ -20,4 +20,3 @@ QB_MEM =3D "512k"
=20
 # Zephyr RTOS settings
 ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
-ARCH:musca-s1 =3D "arm"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-=
common.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-=
common.inc
index 8a1638d..6544475 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.=
inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.=
inc
@@ -19,7 +19,6 @@ ZEPHYR_MAKE_OUTPUT ?=3D "\
 EXTRA_OECMAKE =3D "\
     -DZEPHYR_BASE=3D${ZEPHYR_BASE} \
     -DBOARD=3D${BOARD} \
-    -DARCH=3D${ARCH} \
     -DZEPHYR_TOOLCHAIN_VARIANT=3D${ZEPHYR_TOOLCHAIN_VARIANT} \
     -DZEPHYR_MODULES=3D${ZEPHYR_MODULES} \
     "
--=20
2.34.1


