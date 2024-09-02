Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161FCCA0ED3
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 06:40:47 +0000 (UTC)
Received: from TWMBX01.aspeed.com (TWMBX01.aspeed.com [211.20.114.72])
 by mx.groups.io with SMTP id smtpd.web11.31133.1725249630289595922
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 01 Sep 2024 21:00:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: aspeedtech.com, ip: 211.20.114.72, mailfrom: jamin_lin@aspeedtech.com)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 2 Sep
 2024 12:00:28 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 2 Sep 2024 12:00:28 +0800
From: "Jamin Lin" <jamin_lin@aspeedtech.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <troy_lee@aspeedtech.com>, <jamin_lin@aspeedtech.com>,
	<jaminlin1207@gmail.com>, <vince_chang@aspeedtech.com>
Subject: [meta-zephyr][PATCH v1 1/2] zephyr-kernel: Add source version to support v3.7.0
Date: Mon, 2 Sep 2024 12:00:26 +0800
Message-ID: <20240902040027.1197998-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Sep 2024 06:40:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/604

This inc file is created by generate-version.py

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 .../zephyr-kernel/zephyr-kernel-src-3.7.0.inc | 274 ++++++++++++++++++
 1 file changed, 274 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-ke=
rnel-src-3.7.0.inc

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-sr=
c-3.7.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-s=
rc-3.7.0.inc
new file mode 100644
index 0000000..1cf87a2
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0=
.inc
@@ -0,0 +1,274 @@
+# Auto-generated from zephyr-kernel-src.inc.jinja
+
+SRCREV_FORMAT =3D "default"
+
+SRCREV_default =3D "36940db938a8f4a1e919496793ed439850a221c2"
+SRCREV_acpica =3D "8d24867bc9c9d81c81eeac59391cda59333affd4"
+SRCREV_bsim =3D "9351ae1ad44864a49c351f9704f65f43046abeb0"
+SRCREV_babblesim_base =3D "4bd907be0b2abec3b31a23fd8ca98db2a07209d2"
+SRCREV_babblesim_ext_2G4_libPhyComv1 =3D "93f5eba512c438b0c9ebc1b1a947517c=
865b3643"
+SRCREV_babblesim_ext_2G4_phy_v1 =3D "04eeb3c3794444122fbeeb3715f4233b0b50c=
fbb"
+SRCREV_babblesim_ext_2G4_channel_NtNcable =3D "20a38c997f507b0aa53817aab3d=
73a462fff7af1"
+SRCREV_babblesim_ext_2G4_channel_multiatt =3D "bde72a57384dde7a4310bcf3843=
469401be93074"
+SRCREV_babblesim_ext_2G4_modem_magic =3D "edfcda2d3937a74be0a59d6cd47e0f50=
183453da"
+SRCREV_babblesim_ext_2G4_modem_BLE_simple =3D "a38d2d24b04a6f970a225d13160=
47256ebf5a539"
+SRCREV_babblesim_ext_2G4_device_burst_interferer =3D "5b5339351d6e6a2368c6=
86c734dc8b2fc65698fc"
+SRCREV_babblesim_ext_2G4_device_WLAN_actmod =3D "9cb6d8e72695f6b785e57443f=
0629a18069d6ce4"
+SRCREV_babblesim_ext_2G4_device_playback =3D "abb48cd71ddd4e2a9022f4bf49b2=
712524c483e8"
+SRCREV_babblesim_ext_libCryptov1 =3D "eed6d7038e839153e340bd333bc43541cb90=
ba64"
+SRCREV_cmsis =3D "4b96cbb174678dcd3ca86e11e1f24bc5f8726da0"
+SRCREV_cmsis-dsp =3D "6489e771e9c405f1763b52d64a3f17a1ec488ace"
+SRCREV_cmsis-nn =3D "ea987c1ca661be723de83bd159aed815d6cbd430"
+SRCREV_edtt =3D "8d7b543d4d2f2be0f78481e4e1d8d73a88024803"
+SRCREV_fatfs =3D "427159bf95ea49b7680facffaa29ad506b42709b"
+SRCREV_hal_adi =3D "dee9a7b1eff13a9da0560daf8842d61657f9d61e"
+SRCREV_hal_altera =3D "4fe4df959d4593ce66e676aeba0b57f546dba0fe"
+SRCREV_hal_ambiq =3D "e25327f026df1ee08f1bf01a4bbfeb5e5f4026f1"
+SRCREV_hal_atmel =3D "56d60ebc909ad065bf6554cee73487969857614b"
+SRCREV_hal_espressif =3D "87e7902d7184a8280b4d13bce79801a723f4ddd8"
+SRCREV_hal_ethos_u =3D "8e2cf756b474eff9a32a9bdf1775d9620f1eadcf"
+SRCREV_hal_gigadevice =3D "2994b7dde8b0b0fa9b9c0ccb13474b6a486cddc3"
+SRCREV_hal_infineon =3D "f25734a72c585f6675e8254a382e80e78a3cd03a"
+SRCREV_hal_intel =3D "0905a528623de56b1bedf817536321bcdbc0efae"
+SRCREV_hal_microchip =3D "71eba057c0cb7fc11b6f33eb40a82f1ebe2c571c"
+SRCREV_hal_nordic =3D "ab5cb2e2faeb1edfad7a25286dcb513929ae55da"
+SRCREV_hal_nuvoton =3D "466c3eed9c98453fb23953bf0e0427fea01924be"
+SRCREV_hal_nxp =3D "862e001504bd6e0a4feade6a718e9f973116849c"
+SRCREV_hal_openisa =3D "eabd530a64d71de91d907bad257cd61aacf607bc"
+SRCREV_hal_quicklogic =3D "bad894440fe72c814864798c8e3a76d13edffb6c"
+SRCREV_hal_renesas =3D "af77d7cdfeeff290593e7e99f54f0c1e2a3f91e6"
+SRCREV_hal_rpi_pico =3D "fba7162cc7bee06d0149622bbcaac4e41062d368"
+SRCREV_hal_silabs =3D "a09dd1b82b24aa3060e162c0dfa40026c0dba450"
+SRCREV_hal_st =3D "b77157f6bc4395e398d90ab02a7d2cbc01ab2ce7"
+SRCREV_hal_stm32 =3D "f1317150eac951fdd8259337a47cbbc4c2e6d335"
+SRCREV_hal_telink =3D "4226c7fc17d5a34e557d026d428fc766191a0800"
+SRCREV_hal_ti =3D "b85f86e51fc4d47c4c383d320d64d52d4d371ae4"
+SRCREV_hal_wurthelektronik =3D "e5bcb2eac1bb9639ce13b4dafc78eb254e014342"
+SRCREV_hal_xtensa =3D "a2d658525b16c57bea8dd565f5bd5167e4b9f1ee"
+SRCREV_hostap =3D "a90df86d7c596a5367ff70c2b50c7f599e6636f3"
+SRCREV_libmetal =3D "a6851ba6dba8c9e87d00c42f171a822f7a29639b"
+SRCREV_liblc3 =3D "1a5938ebaca4f13fe79ce074f5dee079783aa29f"
+SRCREV_littlefs =3D "408c16a909dd6cf128874a76f21c793798c9e423"
+SRCREV_loramac-node =3D "fb00b383072518c918e2258b0916c996f2d4eebe"
+SRCREV_lvgl =3D "2b498e6f36d6b82ae1da12c8b7742e318624ecf5"
+SRCREV_mbedtls =3D "2f24831ee13d399ce019c4632b0bcd440a713f7c"
+SRCREV_mcuboot =3D "fb2cf0ec3da3687b93f28e556ab682bdd4b85223"
+SRCREV_mipi-sys-t =3D "71ace1f5caa03e56c8740a09863e685efb4b2360"
+SRCREV_net-tools =3D "7c7a856814d7f27509c8511fef14cec21f7d0c30"
+SRCREV_nrf_hw_models =3D "6c389b9b5fa0a079cd4502e69d375da4c0c289b7"
+SRCREV_open-amp =3D "76d2168bcdfcd23a9a7dce8c21f2083b90a1e60a"
+SRCREV_openthread =3D "3873c6fcd5a8a9dd01b71e8efe32ef5dc7923bb1"
+SRCREV_percepio =3D "a49e5f3947faad0dd654eddd5a750127fb81e50d"
+SRCREV_picolibc =3D "764ef4e401a8f4c6a86ab723533841f072885a5b"
+SRCREV_segger =3D "b011c45b585e097d95d9cf93edf4f2e01588d3cd"
+SRCREV_tinycrypt =3D "1012a3ebee18c15ede5efc8332ee2fc37817670f"
+SRCREV_trusted-firmware-m =3D "069455be098383bf96eab73e3ff8e0c66c60fa5a"
+SRCREV_trusted-firmware-a =3D "713ffbf96c5bcbdeab757423f10f73eb304eff07"
+SRCREV_uoscore-uedhoc =3D "84ef879a46d7bfd9a423fbfb502b04289861f9ea"
+SRCREV_zcbor =3D "75d088037eb237b18e7ec1f47c9ce494b9b95aab"
+
+SRC_URI_ZEPHYR ?=3D "git://github.com/zephyrproject-rtos/zephyr.git;protoc=
ol=3Dhttps"
+SRC_URI_ZEPHYR_ACPICA ?=3D "git://github.com/zephyrproject-rtos/acpica;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_BSIM ?=3D "git://github.com/zephyrproject-rtos/babblesim-ma=
nifest;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_BASE ?=3D "git://github.com/BabbleSim/base;protoc=
ol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1 ?=3D "git://github.com/Babble=
Sim/ext_2G4_libPhyComv1;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1 ?=3D "git://github.com/BabbleSim/e=
xt_2G4_phy_v1;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE ?=3D "git://github.com/B=
abbleSim/ext_2G4_channel_NtNcable;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT ?=3D "git://github.com/B=
abbleSim/ext_2G4_channel_multiatt;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC ?=3D "git://github.com/Babble=
Sim/ext_2G4_modem_magic;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE ?=3D "git://github.com/B=
abbleSim/ext_2G4_modem_BLE_simple;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER ?=3D "git://githu=
b.com/BabbleSim/ext_2G4_device_burst_interferer;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD ?=3D "git://github.com=
/BabbleSim/ext_2G4_device_WLAN_actmod;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK ?=3D "git://github.com/Ba=
bbleSim/ext_2G4_device_playback;protocol=3Dhttps"
+SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1 ?=3D "git://github.com/BabbleSim/=
ext_libCryptov1;protocol=3Dhttps"
+SRC_URI_ZEPHYR_CMSIS ?=3D "git://github.com/zephyrproject-rtos/cmsis;proto=
col=3Dhttps"
+SRC_URI_ZEPHYR_CMSIS_DSP ?=3D "git://github.com/zephyrproject-rtos/cmsis-d=
sp;protocol=3Dhttps"
+SRC_URI_ZEPHYR_CMSIS_NN ?=3D "git://github.com/zephyrproject-rtos/cmsis-nn=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_EDTT ?=3D "git://github.com/zephyrproject-rtos/edtt;protoco=
l=3Dhttps"
+SRC_URI_ZEPHYR_FATFS ?=3D "git://github.com/zephyrproject-rtos/fatfs;proto=
col=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ADI ?=3D "git://github.com/zephyrproject-rtos/hal_adi;p=
rotocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ALTERA ?=3D "git://github.com/zephyrproject-rtos/hal_al=
tera;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_AMBIQ ?=3D "git://github.com/zephyrproject-rtos/hal_amb=
iq;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ATMEL ?=3D "git://github.com/zephyrproject-rtos/hal_atm=
el;protocol=3Dhttps"
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
+SRC_URI_ZEPHYR_HAL_SILABS ?=3D "git://github.com/zephyrproject-rtos/hal_si=
labs;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_ST ?=3D "git://github.com/zephyrproject-rtos/hal_st;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_STM32 ?=3D "git://github.com/zephyrproject-rtos/hal_stm=
32;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_TELINK ?=3D "git://github.com/zephyrproject-rtos/hal_te=
link;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_TI ?=3D "git://github.com/zephyrproject-rtos/hal_ti;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK ?=3D "git://github.com/zephyrproject-rt=
os/hal_wurthelektronik;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HAL_XTENSA ?=3D "git://github.com/zephyrproject-rtos/hal_xt=
ensa;protocol=3Dhttps"
+SRC_URI_ZEPHYR_HOSTAP ?=3D "git://github.com/zephyrproject-rtos/hostap;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_LIBMETAL ?=3D "git://github.com/zephyrproject-rtos/libmetal=
;protocol=3Dhttps"
+SRC_URI_ZEPHYR_LIBLC3 ?=3D "git://github.com/zephyrproject-rtos/liblc3;pro=
tocol=3Dhttps"
+SRC_URI_ZEPHYR_LITTLEFS ?=3D "git://github.com/zephyrproject-rtos/littlefs=
;protocol=3Dhttps"
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
+SRC_URI_ZEPHYR_NET_TOOLS ?=3D "git://github.com/zephyrproject-rtos/net-too=
ls;protocol=3Dhttps"
+SRC_URI_ZEPHYR_NRF_HW_MODELS ?=3D "git://github.com/zephyrproject-rtos/nrf=
_hw_models;protocol=3Dhttps"
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
+SRC_URI_ZEPHYR_TINYCRYPT ?=3D "git://github.com/zephyrproject-rtos/tinycry=
pt;protocol=3Dhttps"
+SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M ?=3D "git://github.com/zephyrproject-rto=
s/trusted-firmware-m;protocol=3Dhttps"
+SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A ?=3D "git://github.com/zephyrproject-rto=
s/trusted-firmware-a;protocol=3Dhttps"
+SRC_URI_ZEPHYR_UOSCORE_UEDHOC ?=3D "git://github.com/zephyrproject-rtos/uo=
score-uedhoc;protocol=3Dhttps"
+SRC_URI_ZEPHYR_ZCBOR ?=3D "git://github.com/zephyrproject-rtos/zcbor;proto=
col=3Dhttps"
+
+SRC_URI_PATCHES ?=3D "\
+    file://0001-3.7-x86-fix-efi-binary-generation-issue-in-cross-compila.p=
atch;patchdir=3Dzephyr \
+"
+
+SRC_URI =3D "\
+    ${SRC_URI_ZEPHYR};branch=3D${ZEPHYR_BRANCH};name=3Ddefault;destsuffix=
=3Dgit/zephyr \
+    ${SRC_URI_ZEPHYR_ACPICA};name=3Dacpica;nobranch=3D1;destsuffix=3Dgit/m=
odules/lib/acpica \
+    ${SRC_URI_ZEPHYR_BSIM};name=3Dbsim;nobranch=3D1;destsuffix=3Dgit/tools=
/bsim \
+    ${SRC_URI_ZEPHYR_BABBLESIM_BASE};name=3Dbabblesim_base;nobranch=3D1;de=
stsuffix=3Dgit/tools/bsim/components \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1};name=3Dbabblesim_ext_2=
G4_libPhyComv1;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/ext_2G4_=
libPhyComv1 \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1};name=3Dbabblesim_ext_2G4_ph=
y_v1;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/ext_2G4_phy_v1 \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE};name=3Dbabblesim_=
ext_2G4_channel_NtNcable;nobranch=3D1;destsuffix=3Dgit/tools/bsim/component=
s/ext_2G4_channel_NtNcable \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT};name=3Dbabblesim_=
ext_2G4_channel_multiatt;nobranch=3D1;destsuffix=3Dgit/tools/bsim/component=
s/ext_2G4_channel_multiatt \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC};name=3Dbabblesim_ext_2=
G4_modem_magic;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/ext_2G4_=
modem_magic \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE};name=3Dbabblesim_=
ext_2G4_modem_BLE_simple;nobranch=3D1;destsuffix=3Dgit/tools/bsim/component=
s/ext_2G4_modem_BLE_simple \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER};name=3Dbab=
blesim_ext_2G4_device_burst_interferer;nobranch=3D1;destsuffix=3Dgit/tools/=
bsim/components/ext_2G4_device_burst_interferer \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD};name=3Dbabblesi=
m_ext_2G4_device_WLAN_actmod;nobranch=3D1;destsuffix=3Dgit/tools/bsim/compo=
nents/ext_2G4_device_WLAN_actmod \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK};name=3Dbabblesim_e=
xt_2G4_device_playback;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/=
ext_2G4_device_playback \
+    ${SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1};name=3Dbabblesim_ext_libCr=
yptov1;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/ext_libCryptov1 =
\
+    ${SRC_URI_ZEPHYR_CMSIS};name=3Dcmsis;nobranch=3D1;destsuffix=3Dgit/mod=
ules/hal/cmsis \
+    ${SRC_URI_ZEPHYR_CMSIS_DSP};name=3Dcmsis-dsp;nobranch=3D1;destsuffix=
=3Dgit/modules/lib/cmsis-dsp \
+    ${SRC_URI_ZEPHYR_CMSIS_NN};name=3Dcmsis-nn;nobranch=3D1;destsuffix=3Dg=
it/modules/lib/cmsis-nn \
+    ${SRC_URI_ZEPHYR_EDTT};name=3Dedtt;nobranch=3D1;destsuffix=3Dgit/tools=
/edtt \
+    ${SRC_URI_ZEPHYR_FATFS};name=3Dfatfs;nobranch=3D1;destsuffix=3Dgit/mod=
ules/fs/fatfs \
+    ${SRC_URI_ZEPHYR_HAL_ADI};name=3Dhal_adi;nobranch=3D1;destsuffix=3Dgit=
/modules/hal/adi \
+    ${SRC_URI_ZEPHYR_HAL_ALTERA};name=3Dhal_altera;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/altera \
+    ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=3Dhal_ambiq;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/ambiq \
+    ${SRC_URI_ZEPHYR_HAL_ATMEL};name=3Dhal_atmel;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/atmel \
+    ${SRC_URI_ZEPHYR_HAL_ESPRESSIF};name=3Dhal_espressif;nobranch=3D1;dest=
suffix=3Dgit/modules/hal/espressif \
+    ${SRC_URI_ZEPHYR_HAL_ETHOS_U};name=3Dhal_ethos_u;nobranch=3D1;destsuff=
ix=3Dgit/modules/hal/ethos_u \
+    ${SRC_URI_ZEPHYR_HAL_GIGADEVICE};name=3Dhal_gigadevice;nobranch=3D1;de=
stsuffix=3Dgit/modules/hal/gigadevice \
+    ${SRC_URI_ZEPHYR_HAL_INFINEON};name=3Dhal_infineon;nobranch=3D1;destsu=
ffix=3Dgit/modules/hal/infineon \
+    ${SRC_URI_ZEPHYR_HAL_INTEL};name=3Dhal_intel;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/intel \
+    ${SRC_URI_ZEPHYR_HAL_MICROCHIP};name=3Dhal_microchip;nobranch=3D1;dest=
suffix=3Dgit/modules/hal/microchip \
+    ${SRC_URI_ZEPHYR_HAL_NORDIC};name=3Dhal_nordic;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/nordic \
+    ${SRC_URI_ZEPHYR_HAL_NUVOTON};name=3Dhal_nuvoton;nobranch=3D1;destsuff=
ix=3Dgit/modules/hal/nuvoton \
+    ${SRC_URI_ZEPHYR_HAL_NXP};name=3Dhal_nxp;nobranch=3D1;destsuffix=3Dgit=
/modules/hal/nxp \
+    ${SRC_URI_ZEPHYR_HAL_OPENISA};name=3Dhal_openisa;nobranch=3D1;destsuff=
ix=3Dgit/modules/hal/openisa \
+    ${SRC_URI_ZEPHYR_HAL_QUICKLOGIC};name=3Dhal_quicklogic;nobranch=3D1;de=
stsuffix=3Dgit/modules/hal/quicklogic \
+    ${SRC_URI_ZEPHYR_HAL_RENESAS};name=3Dhal_renesas;nobranch=3D1;destsuff=
ix=3Dgit/modules/hal/renesas \
+    ${SRC_URI_ZEPHYR_HAL_RPI_PICO};name=3Dhal_rpi_pico;nobranch=3D1;destsu=
ffix=3Dgit/modules/hal/rpi_pico \
+    ${SRC_URI_ZEPHYR_HAL_SILABS};name=3Dhal_silabs;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/silabs \
+    ${SRC_URI_ZEPHYR_HAL_ST};name=3Dhal_st;nobranch=3D1;destsuffix=3Dgit/m=
odules/hal/st \
+    ${SRC_URI_ZEPHYR_HAL_STM32};name=3Dhal_stm32;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/stm32 \
+    ${SRC_URI_ZEPHYR_HAL_TELINK};name=3Dhal_telink;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/telink \
+    ${SRC_URI_ZEPHYR_HAL_TI};name=3Dhal_ti;nobranch=3D1;destsuffix=3Dgit/m=
odules/hal/ti \
+    ${SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK};name=3Dhal_wurthelektronik;nobra=
nch=3D1;destsuffix=3Dgit/modules/hal/wurthelektronik \
+    ${SRC_URI_ZEPHYR_HAL_XTENSA};name=3Dhal_xtensa;nobranch=3D1;destsuffix=
=3Dgit/modules/hal/xtensa \
+    ${SRC_URI_ZEPHYR_HOSTAP};name=3Dhostap;nobranch=3D1;destsuffix=3Dgit/m=
odules/lib/hostap \
+    ${SRC_URI_ZEPHYR_LIBMETAL};name=3Dlibmetal;nobranch=3D1;destsuffix=3Dg=
it/modules/hal/libmetal \
+    ${SRC_URI_ZEPHYR_LIBLC3};name=3Dliblc3;nobranch=3D1;destsuffix=3Dgit/m=
odules/lib/liblc3 \
+    ${SRC_URI_ZEPHYR_LITTLEFS};name=3Dlittlefs;nobranch=3D1;destsuffix=3Dg=
it/modules/fs/littlefs \
+    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=3Dloramac-node;nobranch=3D1;destsu=
ffix=3Dgit/modules/lib/loramac-node \
+    ${SRC_URI_ZEPHYR_LVGL};name=3Dlvgl;nobranch=3D1;destsuffix=3Dgit/modul=
es/lib/gui/lvgl \
+    ${SRC_URI_ZEPHYR_MBEDTLS};name=3Dmbedtls;nobranch=3D1;destsuffix=3Dgit=
/modules/crypto/mbedtls \
+    ${SRC_URI_ZEPHYR_MCUBOOT};name=3Dmcuboot;nobranch=3D1;destsuffix=3Dgit=
/bootloader/mcuboot \
+    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=3Dmipi-sys-t;nobranch=3D1;destsuffix=
=3Dgit/modules/debug/mipi-sys-t \
+    ${SRC_URI_ZEPHYR_NET_TOOLS};name=3Dnet-tools;nobranch=3D1;destsuffix=
=3Dgit/tools/net-tools \
+    ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=3Dnrf_hw_models;nobranch=3D1;dest=
suffix=3Dgit/modules/bsim_hw_models/nrf_hw_models \
+    ${SRC_URI_ZEPHYR_OPEN_AMP};name=3Dopen-amp;nobranch=3D1;destsuffix=3Dg=
it/modules/lib/open-amp \
+    ${SRC_URI_ZEPHYR_OPENTHREAD};name=3Dopenthread;nobranch=3D1;destsuffix=
=3Dgit/modules/lib/openthread \
+    ${SRC_URI_ZEPHYR_PERCEPIO};name=3Dpercepio;nobranch=3D1;destsuffix=3Dg=
it/modules/debug/percepio \
+    ${SRC_URI_ZEPHYR_PICOLIBC};name=3Dpicolibc;nobranch=3D1;destsuffix=3Dg=
it/modules/lib/picolibc \
+    ${SRC_URI_ZEPHYR_SEGGER};name=3Dsegger;nobranch=3D1;destsuffix=3Dgit/m=
odules/debug/segger \
+    ${SRC_URI_ZEPHYR_TINYCRYPT};name=3Dtinycrypt;nobranch=3D1;destsuffix=
=3Dgit/modules/crypto/tinycrypt \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=3Dtrusted-firmware-m;nobranc=
h=3D1;destsuffix=3Dgit/modules/tee/tf-m/trusted-firmware-m \
+    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=3Dtrusted-firmware-a;nobranc=
h=3D1;destsuffix=3Dgit/modules/tee/tf-a/trusted-firmware-a \
+    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=3Duoscore-uedhoc;nobranch=3D1;de=
stsuffix=3Dgit/modules/lib/uoscore-uedhoc \
+    ${SRC_URI_ZEPHYR_ZCBOR};name=3Dzcbor;nobranch=3D1;destsuffix=3Dgit/mod=
ules/lib/zcbor \
+    ${SRC_URI_PATCHES} \
+"
+
+ZEPHYR_MODULES =3D "\
+${S}/modules/lib/acpica\;\
+${S}/tools/bsim\;\
+${S}/tools/bsim/components\;\
+${S}/tools/bsim/components/ext_2G4_libPhyComv1\;\
+${S}/tools/bsim/components/ext_2G4_phy_v1\;\
+${S}/tools/bsim/components/ext_2G4_channel_NtNcable\;\
+${S}/tools/bsim/components/ext_2G4_channel_multiatt\;\
+${S}/tools/bsim/components/ext_2G4_modem_magic\;\
+${S}/tools/bsim/components/ext_2G4_modem_BLE_simple\;\
+${S}/tools/bsim/components/ext_2G4_device_burst_interferer\;\
+${S}/tools/bsim/components/ext_2G4_device_WLAN_actmod\;\
+${S}/tools/bsim/components/ext_2G4_device_playback\;\
+${S}/tools/bsim/components/ext_libCryptov1\;\
+${S}/modules/hal/cmsis\;\
+${S}/modules/lib/cmsis-dsp\;\
+${S}/modules/lib/cmsis-nn\;\
+${S}/tools/edtt\;\
+${S}/modules/fs/fatfs\;\
+${S}/modules/hal/adi\;\
+${S}/modules/hal/altera\;\
+${S}/modules/hal/ambiq\;\
+${S}/modules/hal/atmel\;\
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
+${S}/modules/hal/silabs\;\
+${S}/modules/hal/st\;\
+${S}/modules/hal/stm32\;\
+${S}/modules/hal/telink\;\
+${S}/modules/hal/ti\;\
+${S}/modules/hal/wurthelektronik\;\
+${S}/modules/hal/xtensa\;\
+${S}/modules/lib/hostap\;\
+${S}/modules/hal/libmetal\;\
+${S}/modules/lib/liblc3\;\
+${S}/modules/fs/littlefs\;\
+${S}/modules/lib/loramac-node\;\
+${S}/modules/lib/gui/lvgl\;\
+${S}/modules/crypto/mbedtls\;\
+${S}/bootloader/mcuboot\;\
+${S}/modules/debug/mipi-sys-t\;\
+${S}/tools/net-tools\;\
+${S}/modules/bsim_hw_models/nrf_hw_models\;\
+${S}/modules/lib/open-amp\;\
+${S}/modules/lib/openthread\;\
+${S}/modules/debug/percepio\;\
+${S}/modules/lib/picolibc\;\
+${S}/modules/debug/segger\;\
+${S}/modules/crypto/tinycrypt\;\
+${S}/modules/tee/tf-m/trusted-firmware-m\;\
+${S}/modules/tee/tf-a/trusted-firmware-a\;\
+${S}/modules/lib/uoscore-uedhoc\;\
+${S}/modules/lib/zcbor\;\
+"
+
+ZEPHYR_BRANCH =3D "v3.7-branch"
+PV =3D "3.7.0+git${SRCPV}"
--=20
2.25.1


