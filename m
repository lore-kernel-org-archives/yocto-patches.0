Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E1EC83F09
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 04:49:11 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.11466.1751950148832745095
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Jul 2025 21:49:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=9284fa5eea=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5684UARO028245
	for <yocto-patches@lists.yoctoproject.org>; Tue, 8 Jul 2025 04:49:07 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47ps91tfy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 04:49:07 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Mon, 7 Jul 2025 21:48:51 -0700
Received: from pek-lpg-core6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Mon, 7 Jul 2025 21:48:51 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-raspberrypi][PATCH] Adapt to S/UNPACKDIR changes
Date: Tue, 8 Jul 2025 12:49:04 +0800
Message-ID: <20250708044904.3022644-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PLcP+eqC c=1 sm=1 tr=0 ts=686ca343 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=RF00TdSWAAAA:8 a=t7CeM3EgAAAA:8 a=7jZnNDYnWWHeJJFzJ1wA:9 a=_nx8FpPT0le-2JWwMI5O:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 3K_cTXzipkE4MrXntSQbvxALl-Ev3B1-
X-Proofpoint-ORIG-GUID: 3K_cTXzipkE4MrXntSQbvxALl-Ev3B1-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAzNSBTYWx0ZWRfX7CYFq+IDzXSw GMKPw7B0saGQO8LDfVnsBKGeqNtsQVDrP+oLyi19r1l7W1K7FPP0WFZzdU/RpMm2WGMpzbqRwSU M3VCIxR12/d8zLSH7O+hUAnngdpGEPdez+IJrYfqK6FakSERBrPilBZM6TAsDdzxAQznax254AG
 8mB/85Trle5Jh4AFJXlBJhSSlR2FtgadF9eMPMfP4zFSzsHOsGE2SorcW7b5FGl6zwhiace7Tsr 03eEnUusJK9rGzJjisOapQCGjkZVucmiSaNr4OBNZ1lp+bDxH72ixX7jWVRqxvECgzwgwkElQvF EsCWtkUX0dksGnBKPJr1k4L80oOPinQYhoz303URd/iF+OqQ7K1Edaqkm4zHJFiqoYM7sIP9P0L
 R7XnlDCxkxfvkv4/w8JfzqPF1OOLZ/AmTvD279d4nfToqueewDi4T2dXy9s7ruj8ge+N0NJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507080035
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 04:49:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1780

From: Changqing Li <changqing.li@windriver.com>

Remove or update S definitions as required to work with oe-core
S/UNPACKDIR changes.

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 .../recipes-multimedia/libcamera-apps/libcamera-apps_git.bb    | 1 -
 .../recipes-multimedia/rpidistro-vlc/rpidistro-vlc_3.0.17.bb   | 1 -
 .../recipes-devtools/python/python3-adafruit-blinka_6.2.2.bb   | 1 -
 .../python/python3-adafruit-circuitpython-busdevice_5.0.5.bb   | 1 -
 .../python/python3-adafruit-circuitpython-motor_3.2.6.bb       | 1 -
 .../python/python3-adafruit-circuitpython-motorkit_1.6.1.bb    | 1 -
 .../python/python3-adafruit-circuitpython-pca9685_3.3.4.bb     | 1 -
 recipes-bsp/bootfiles/rpi-bootfiles.bb                         | 2 +-
 recipes-bsp/bootfiles/rpi-config_git.bb                        | 1 -
 recipes-bsp/common/raspberrypi-firmware.inc                    | 2 +-
 recipes-bsp/common/raspberrypi-tools.inc                       | 2 +-
 recipes-bsp/rpi-eeprom/rpi-eeprom_git.bb                       | 1 -
 recipes-bsp/rpi-u-boot-scr/rpi-u-boot-scr.bb                   | 3 +--
 recipes-connectivity/pi-bluetooth/pi-bluetooth_0.1.17.bb       | 1 -
 recipes-core/udev/udev-rules-rpi.bb                            | 1 -
 recipes-devtools/pi-blaster/pi-blaster_git.bb                  | 1 -
 .../python/python3-adafruit-circuitpython-register_1.9.10.bb   | 1 -
 .../python/python3-adafruit-platformdetect_3.27.0.bb           | 1 -
 recipes-devtools/python/python3-adafruit-pureio_1.1.9.bb       | 1 -
 recipes-devtools/python/python3-rtimu_7.2.1.bb                 | 2 +-
 recipes-devtools/python/rpio_0.10.1.bb                         | 1 -
 recipes-devtools/raspi-gpio/raspi-gpio_git.bb                  | 1 -
 recipes-devtools/raspi-utils/raspi-utils_git.bb                | 1 -
 recipes-graphics/raspidmx/raspidmx_git.bb                      | 1 -
 recipes-graphics/userland/userland_git.bb                      | 1 -
 .../bluez-firmware-rpidistro/bluez-firmware-rpidistro_git.bb   | 1 -
 .../linux-firmware-rpidistro/linux-firmware-rpidistro_git.bb   | 1 -
 recipes-multimedia/omxplayer/omxplayer_git.bb                  | 3 +--
 recipes-multimedia/python3-picamera/python3-picamera_git.bb    | 1 -
 recipes-multimedia/rpidistro-ffmpeg/rpidistro-ffmpeg_5.1.4.bb  | 1 -
 30 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/dynamic-layers/multimedia-layer/recipes-multimedia/libcamera-apps/libcamera-apps_git.bb b/dynamic-layers/multimedia-layer/recipes-multimedia/libcamera-apps/libcamera-apps_git.bb
index dc07145..343004f 100644
--- a/dynamic-layers/multimedia-layer/recipes-multimedia/libcamera-apps/libcamera-apps_git.bb
+++ b/dynamic-layers/multimedia-layer/recipes-multimedia/libcamera-apps/libcamera-apps_git.bb
@@ -15,7 +15,6 @@ SRC_URI = "\
 PV = "1.4.2+git${SRCPV}"
 SRCREV = "9ae39f85ae6bee9761c36b9b5b80d675bc1fa369"
 
-S = "${WORKDIR}/git"
 
 DEPENDS = "libcamera libexif jpeg tiff libpng boost"
 
diff --git a/dynamic-layers/multimedia-layer/recipes-multimedia/rpidistro-vlc/rpidistro-vlc_3.0.17.bb b/dynamic-layers/multimedia-layer/recipes-multimedia/rpidistro-vlc/rpidistro-vlc_3.0.17.bb
index 2007201..8f61c2a 100644
--- a/dynamic-layers/multimedia-layer/recipes-multimedia/rpidistro-vlc/rpidistro-vlc_3.0.17.bb
+++ b/dynamic-layers/multimedia-layer/recipes-multimedia/rpidistro-vlc/rpidistro-vlc_3.0.17.bb
@@ -32,7 +32,6 @@ SRC_URI = "\
 
 SRCREV = "b276eb0d7bc3213363e97dbb681ef7c927be6c73"
 
-S = "${WORKDIR}/git"
 
 PROVIDES = "vlc"
 RPROVIDES:${PN} = "${PROVIDES}"
diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-blinka_6.2.2.bb b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-blinka_6.2.2.bb
index 9e1e357..cf9c1af 100644
--- a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-blinka_6.2.2.bb
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-blinka_6.2.2.bb
@@ -6,7 +6,6 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=660e614bc7efb0697cc793d8a22a55c2"
 SRC_URI = "git://github.com/adafruit/Adafruit_Blinka.git;branch=main;protocol=https"
 SRCREV = "dc688f354fe779c9267c208b99f310af87e79272"
 
-S = "${WORKDIR}/git"
 
 inherit setuptools3
 
diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-busdevice_5.0.5.bb b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-busdevice_5.0.5.bb
index 93491d4..52db8b1 100644
--- a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-busdevice_5.0.5.bb
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-busdevice_5.0.5.bb
@@ -6,7 +6,6 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=6ec69d6e9e6c85adfb7799d7f8cf044e"
 SRC_URI = "git://github.com/adafruit/Adafruit_CircuitPython_BusDevice.git;branch=main;protocol=https"
 SRCREV = "1bfe8005293205e2f7b2cc498ab5a946f1133b40"
 
-S = "${WORKDIR}/git"
 
 inherit setuptools3
 
diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-motor_3.2.6.bb b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-motor_3.2.6.bb
index 3233c8f..c568504 100644
--- a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-motor_3.2.6.bb
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-motor_3.2.6.bb
@@ -6,7 +6,6 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=b72678307cc7c10910b5ef460216af07"
 SRC_URI = "git://github.com/adafruit/Adafruit_CircuitPython_Motor.git;branch=main;protocol=https"
 SRCREV = "2251bfc0501d0acfb96c0a43f4f2b4c6a10ca14e"
 
-S = "${WORKDIR}/git"
 
 inherit setuptools3
 
diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-motorkit_1.6.1.bb b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-motorkit_1.6.1.bb
index 39fe76a..4de6462 100644
--- a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-motorkit_1.6.1.bb
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-motorkit_1.6.1.bb
@@ -6,7 +6,6 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=6ad4a8854b39ad474755ef1aea813bac"
 SRC_URI = "git://github.com/adafruit/Adafruit_CircuitPython_MotorKit.git;branch=main;protocol=https"
 SRCREV = "8c1462b4129b21f6db156d1517abb017bb74b982"
 
-S = "${WORKDIR}/git"
 
 inherit setuptools3
 
diff --git a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-pca9685_3.3.4.bb b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-pca9685_3.3.4.bb
index f7f0ff1..1da4c3f 100644
--- a/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-pca9685_3.3.4.bb
+++ b/dynamic-layers/openembedded-layer/recipes-devtools/python/python3-adafruit-circuitpython-pca9685_3.3.4.bb
@@ -6,7 +6,6 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=e7eb6b599fb0cfb06485c64cd4242f62"
 SRC_URI = "git://github.com/adafruit/Adafruit_CircuitPython_PCA9685.git;branch=main;protocol=https"
 SRCREV = "2780c4102f4c23fbab252aa1198b61ba7e2d1b2c"
 
-S = "${WORKDIR}/git"
 
 inherit setuptools3
 
diff --git a/recipes-bsp/bootfiles/rpi-bootfiles.bb b/recipes-bsp/bootfiles/rpi-bootfiles.bb
index eb31d54..ba119cc 100644
--- a/recipes-bsp/bootfiles/rpi-bootfiles.bb
+++ b/recipes-bsp/bootfiles/rpi-bootfiles.bb
@@ -9,7 +9,7 @@ RPIFW_DATE ?= "20250430"
 SRCREV = "bc7f439c234e19371115e07b57c366df59cc1bc7"
 SHORTREV = "${@d.getVar("SRCREV", False).__str__()[:7]}"
 RPIFW_SRC_URI ?= "https://api.github.com/repos/raspberrypi/firmware/tarball/${SRCREV};downloadfilename=raspberrypi-firmware-${SHORTREV}.tar.gz"
-RPIFW_S ?= "${WORKDIR}/raspberrypi-firmware-${SHORTREV}"
+RPIFW_S ?= "${UNPACKDIR}/raspberrypi-firmware-${SHORTREV}"
 
 SRC_URI = "${RPIFW_SRC_URI}"
 SRC_URI[sha256sum] = "2c027debbef53c86c9ff9197d056d501b95f6ad214ad4db00a8a59b947574eb1"
diff --git a/recipes-bsp/bootfiles/rpi-config_git.bb b/recipes-bsp/bootfiles/rpi-config_git.bb
index 0140f30..d39621c 100644
--- a/recipes-bsp/bootfiles/rpi-config_git.bb
+++ b/recipes-bsp/bootfiles/rpi-config_git.bb
@@ -12,7 +12,6 @@ SRC_URI = "git://github.com/Evilpaul/RPi-config.git;protocol=https;branch=master
            file://0001-config.txt-reintroduce-start_x.patch \
           "
 
-S = "${WORKDIR}/git"
 
 PR = "r5"
 
diff --git a/recipes-bsp/common/raspberrypi-firmware.inc b/recipes-bsp/common/raspberrypi-firmware.inc
index 311da21..2025e73 100644
--- a/recipes-bsp/common/raspberrypi-firmware.inc
+++ b/recipes-bsp/common/raspberrypi-firmware.inc
@@ -1,7 +1,7 @@
 RPIFW_DATE ?= "20230509~buster"
 
 RPIFW_SRC_URI ?= "https://archive.raspberrypi.com/debian/pool/main/r/raspberrypi-firmware/raspberrypi-firmware_1.${RPIFW_DATE}.orig.tar.xz"
-RPIFW_S ?= "${WORKDIR}/raspberrypi-firmware-1.${RPIFW_DATE}"
+RPIFW_S ?= "${UNPACKDIR}/raspberrypi-firmware-1.${RPIFW_DATE}"
 
 SRC_URI = "${RPIFW_SRC_URI}"
 SRC_URI[sha256sum] = "1d9eb83111826b708f461101766fd2000d45f1c171ad573936d000f623ca8098"
diff --git a/recipes-bsp/common/raspberrypi-tools.inc b/recipes-bsp/common/raspberrypi-tools.inc
index c88e7e4..a67c543 100644
--- a/recipes-bsp/common/raspberrypi-tools.inc
+++ b/recipes-bsp/common/raspberrypi-tools.inc
@@ -1,7 +1,7 @@
 RPITOOLS_DATE ?= "20220711"
 SRCREV ?= "439b6198a9b340de5998dd14a26a0d9d38a6bcac"
 RPITOOLS_SRC_URI ?= "git://github.com/raspberrypi/tools;protocol=https;branch=master"
-RPITOOLS_S ?= "${WORKDIR}/git"
+RPITOOLS_S ?= "${UNPACKDIR}/${BB_GIT_DEFAULT_DESTSUFFIX}"
 
 SRC_URI = "${RPITOOLS_SRC_URI}"
 
diff --git a/recipes-bsp/rpi-eeprom/rpi-eeprom_git.bb b/recipes-bsp/rpi-eeprom/rpi-eeprom_git.bb
index f3ca5e3..ef8c2af 100644
--- a/recipes-bsp/rpi-eeprom/rpi-eeprom_git.bb
+++ b/recipes-bsp/rpi-eeprom/rpi-eeprom_git.bb
@@ -11,7 +11,6 @@ SRC_URI = " \
 SRCREV = "1bd0a1052b2e74d7af04de18d30b5edb12d8a423"
 PV = "v2025.03.10-2712"
 
-S = "${WORKDIR}/git"
 
 RDEPENDS:${PN} += " \
     coreutils \
diff --git a/recipes-bsp/rpi-u-boot-scr/rpi-u-boot-scr.bb b/recipes-bsp/rpi-u-boot-scr/rpi-u-boot-scr.bb
index d035d6e..f201dc6 100644
--- a/recipes-bsp/rpi-u-boot-scr/rpi-u-boot-scr.bb
+++ b/recipes-bsp/rpi-u-boot-scr/rpi-u-boot-scr.bb
@@ -21,8 +21,7 @@ do_compile() {
 
 inherit kernel-arch deploy nopackages
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
+S = "${UNPACKDIR}"
 
 do_deploy() {
     install -d ${DEPLOYDIR}
diff --git a/recipes-connectivity/pi-bluetooth/pi-bluetooth_0.1.17.bb b/recipes-connectivity/pi-bluetooth/pi-bluetooth_0.1.17.bb
index 1c3daff..3f25f15 100644
--- a/recipes-connectivity/pi-bluetooth/pi-bluetooth_0.1.17.bb
+++ b/recipes-connectivity/pi-bluetooth/pi-bluetooth_0.1.17.bb
@@ -12,7 +12,6 @@ SRC_URI = "\
 "
 SRCREV = "fd4775bf90e037551532fc214a958074830bb80d"
 
-S = "${WORKDIR}/git"
 
 inherit ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', 'update-rc.d', d)}
 # hciuart.service replaces what was brcm43438.service 
diff --git a/recipes-core/udev/udev-rules-rpi.bb b/recipes-core/udev/udev-rules-rpi.bb
index 3ca34f4..d898deb 100644
--- a/recipes-core/udev/udev-rules-rpi.bb
+++ b/recipes-core/udev/udev-rules-rpi.bb
@@ -8,7 +8,6 @@ SRC_URI = " \
 	"
 SRCREV = "5ce3ef2b7f377c23fea440ca9df0e30f3f8447cf"
 
-S = "${WORKDIR}/git"
 
 INHIBIT_DEFAULT_DEPS = "1"
 
diff --git a/recipes-devtools/pi-blaster/pi-blaster_git.bb b/recipes-devtools/pi-blaster/pi-blaster_git.bb
index d02fa92..644a4c7 100644
--- a/recipes-devtools/pi-blaster/pi-blaster_git.bb
+++ b/recipes-devtools/pi-blaster/pi-blaster_git.bb
@@ -8,7 +8,6 @@ SRC_URI = "git://github.com/sarfata/pi-blaster;branch=master;protocol=https \
            file://remove-initscript-lsb-dependency.patch \
            "
 
-S = "${WORKDIR}/git"
 
 SRCREV = "fbba9a7dcef0f352a11f8a2a5f6cbc15b62c0829"
 
diff --git a/recipes-devtools/python/python3-adafruit-circuitpython-register_1.9.10.bb b/recipes-devtools/python/python3-adafruit-circuitpython-register_1.9.10.bb
index 8ff3073..b009131 100644
--- a/recipes-devtools/python/python3-adafruit-circuitpython-register_1.9.10.bb
+++ b/recipes-devtools/python/python3-adafruit-circuitpython-register_1.9.10.bb
@@ -5,7 +5,6 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=6ec69d6e9e6c85adfb7799d7f8cf044e"
 
 SRC_URI = "git://github.com/adafruit/Adafruit_CircuitPython_Register.git;branch=main;protocol=https"
 SRCREV = "d1e8ac7ad9dcd65ab83749db3e5c96ffee80ebb7"
-S = "${WORKDIR}/git"
 
 DEPENDS += "python3-setuptools-scm-native"
 
diff --git a/recipes-devtools/python/python3-adafruit-platformdetect_3.27.0.bb b/recipes-devtools/python/python3-adafruit-platformdetect_3.27.0.bb
index 45dc49d..32eb491 100644
--- a/recipes-devtools/python/python3-adafruit-platformdetect_3.27.0.bb
+++ b/recipes-devtools/python/python3-adafruit-platformdetect_3.27.0.bb
@@ -5,7 +5,6 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=fccd531dce4b989c05173925f0bbb76c"
 
 SRC_URI = "git://github.com/adafruit/Adafruit_Python_PlatformDetect.git;branch=main;protocol=https"
 SRCREV = "e1460098eeca5ea573f92814691bb378e15530d9"
-S = "${WORKDIR}/git"
 
 inherit setuptools3
 
diff --git a/recipes-devtools/python/python3-adafruit-pureio_1.1.9.bb b/recipes-devtools/python/python3-adafruit-pureio_1.1.9.bb
index cdbe4b4..8f8d433 100644
--- a/recipes-devtools/python/python3-adafruit-pureio_1.1.9.bb
+++ b/recipes-devtools/python/python3-adafruit-pureio_1.1.9.bb
@@ -6,7 +6,6 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=2a21fcca821a506d4c36f7bbecc0d009"
 SRC_URI = "git://github.com/adafruit/Adafruit_Python_PureIO.git;branch=main;protocol=https"
 SRCREV = "383b615ce9ff5bbefdf77652799f380016fda353"
 
-S = "${WORKDIR}/git"
 
 inherit setuptools3
 
diff --git a/recipes-devtools/python/python3-rtimu_7.2.1.bb b/recipes-devtools/python/python3-rtimu_7.2.1.bb
index 1afbb5f..22b33f7 100644
--- a/recipes-devtools/python/python3-rtimu_7.2.1.bb
+++ b/recipes-devtools/python/python3-rtimu_7.2.1.bb
@@ -11,5 +11,5 @@ SRC_URI = "git://github.com/RPi-Distro/RTIMULib.git;protocol=http;branch=master;
           "
 SRCREV = "b949681af69b45f0f7f4bb53b6770037b5b02178"
 
-S = "${WORKDIR}/git/Linux/python"
+S = "${UNPACKDIR}/${BB_GIT_DEFAULT_DESTSUFFIX}/Linux/python"
 inherit setuptools3
diff --git a/recipes-devtools/python/rpio_0.10.1.bb b/recipes-devtools/python/rpio_0.10.1.bb
index 176646d..8a7b8c1 100644
--- a/recipes-devtools/python/rpio_0.10.1.bb
+++ b/recipes-devtools/python/rpio_0.10.1.bb
@@ -9,7 +9,6 @@ SRC_URI = "\
     git://github.com/metachris/RPIO.git;protocol=https;branch=master \
     "
 SRCREV = "be1942a69b2592ddacd9dc833d2668a19aafd8d2"
-S = "${WORKDIR}/git"
 
 inherit setuptools3
 
diff --git a/recipes-devtools/raspi-gpio/raspi-gpio_git.bb b/recipes-devtools/raspi-gpio/raspi-gpio_git.bb
index 8ea4be1..c9d4051 100644
--- a/recipes-devtools/raspi-gpio/raspi-gpio_git.bb
+++ b/recipes-devtools/raspi-gpio/raspi-gpio_git.bb
@@ -12,5 +12,4 @@ SRCREV = "22b44e4765b4b78dc5b22394fff484e353d5914d"
 SRC_URI = "git://github.com/RPi-Distro/raspi-gpio.git;protocol=https;branch=master \
           "
 
-S = "${WORKDIR}/git"
 
diff --git a/recipes-devtools/raspi-utils/raspi-utils_git.bb b/recipes-devtools/raspi-utils/raspi-utils_git.bb
index 77ff2c3..7c71eb1 100644
--- a/recipes-devtools/raspi-utils/raspi-utils_git.bb
+++ b/recipes-devtools/raspi-utils/raspi-utils_git.bb
@@ -15,7 +15,6 @@ SRC_URI = "git://github.com/raspberrypi/utils;protocol=https;branch=master"
 
 SRCREV = "b9c63214c535d7df2b0fa6743b7b3e508363c25a"
 
-S = "${WORKDIR}/git"
 
 FILES:${PN}:append = " \
     ${datadir}/bash-completion/completions/pinctrl \
diff --git a/recipes-graphics/raspidmx/raspidmx_git.bb b/recipes-graphics/raspidmx/raspidmx_git.bb
index 4729e8c..7c2e50c 100644
--- a/recipes-graphics/raspidmx/raspidmx_git.bb
+++ b/recipes-graphics/raspidmx/raspidmx_git.bb
@@ -20,7 +20,6 @@ SRC_URI = "git://github.com/AndrewFromMelbourne/raspidmx;protocol=https;branch=m
 PV = "0.0+git${SRCPV}"
 SRCREV = "e2ee6faa0d01a5ece06bcc74a47f37d7e6837310"
 
-S = "${WORKDIR}/git"
 
 inherit pkgconfig
 
diff --git a/recipes-graphics/userland/userland_git.bb b/recipes-graphics/userland/userland_git.bb
index bd50bf8..270a99b 100644
--- a/recipes-graphics/userland/userland_git.bb
+++ b/recipes-graphics/userland/userland_git.bb
@@ -51,7 +51,6 @@ SRC_URI = "\
 
 SRC_URI:remove:toolchain-clang = "file://0021-cmake-Disable-format-overflow-warning-as-error.patch"
 
-S = "${WORKDIR}/git"
 
 inherit cmake pkgconfig
 
diff --git a/recipes-kernel/bluez-firmware-rpidistro/bluez-firmware-rpidistro_git.bb b/recipes-kernel/bluez-firmware-rpidistro/bluez-firmware-rpidistro_git.bb
index bd5ed62..b562fa6 100644
--- a/recipes-kernel/bluez-firmware-rpidistro/bluez-firmware-rpidistro_git.bb
+++ b/recipes-kernel/bluez-firmware-rpidistro/bluez-firmware-rpidistro_git.bb
@@ -29,7 +29,6 @@ SRC_URI = " \
 SRCREV = "78d6a07730e2d20c035899521ab67726dc028e1c"
 PV = "1.2-9+rpt3"
 
-S = "${WORKDIR}/git"
 
 inherit allarch
 
diff --git a/recipes-kernel/linux-firmware-rpidistro/linux-firmware-rpidistro_git.bb b/recipes-kernel/linux-firmware-rpidistro/linux-firmware-rpidistro_git.bb
index f22ec54..cfad4bd 100644
--- a/recipes-kernel/linux-firmware-rpidistro/linux-firmware-rpidistro_git.bb
+++ b/recipes-kernel/linux-firmware-rpidistro/linux-firmware-rpidistro_git.bb
@@ -20,7 +20,6 @@ SRC_URI = "git://github.com/RPi-Distro/firmware-nonfree;branch=bookworm;protocol
 "
 SRCREV = "4b356e134e8333d073bd3802d767a825adec3807"
 PV = "20230625-2+rpt3"
-S = "${WORKDIR}/git"
 
 inherit allarch
 
diff --git a/recipes-multimedia/omxplayer/omxplayer_git.bb b/recipes-multimedia/omxplayer/omxplayer_git.bb
index b7eaf40..66926e0 100644
--- a/recipes-multimedia/omxplayer/omxplayer_git.bb
+++ b/recipes-multimedia/omxplayer/omxplayer_git.bb
@@ -25,7 +25,7 @@ SRCREV_default = "1f1d0ccd65d3a1caa86dc79d2863a8f067c8e3f8"
 SRCREV_ffmpeg = "fcbd117df3077bad495e99e20f01cf93737bce76"
 
 SRC_URI = "git://github.com/popcornmix/omxplayer.git;protocol=https;branch=master \
-           git://github.com/FFmpeg/FFmpeg;branch=release/4.0;protocol=https;depth=1;name=ffmpeg;destsuffix=git/ffmpeg \
+           git://github.com/FFmpeg/FFmpeg;branch=release/4.0;protocol=https;depth=1;name=ffmpeg;destsuffix=${BP}/ffmpeg \
            file://0002-Libraries-and-headers-from-ffmpeg-are-installed-in-u.patch \
            file://0003-Remove-strip-step-in-Makefile.patch \
            file://0004-Add-FFMPEG_EXTRA_CFLAGS-and-FFMPEG_EXTRA_LDFLAGS.patch \
@@ -40,7 +40,6 @@ SRC_URI = "git://github.com/popcornmix/omxplayer.git;protocol=https;branch=maste
 
 SRC_URI:append = "${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", " file://0001-Fix-build-with-vc4-driver.patch ", "", d)}"
 
-S = "${WORKDIR}/git"
 
 COMPATIBLE_MACHINE = "^rpi$"
 COMPATIBLE_HOST:aarch64 = "null"
diff --git a/recipes-multimedia/python3-picamera/python3-picamera_git.bb b/recipes-multimedia/python3-picamera/python3-picamera_git.bb
index f14941b..4d0b18a 100644
--- a/recipes-multimedia/python3-picamera/python3-picamera_git.bb
+++ b/recipes-multimedia/python3-picamera/python3-picamera_git.bb
@@ -14,7 +14,6 @@ RDEPENDS:${PN} = "python3-numbers   \
 SRC_URI = "git://git@github.com/waveform80/picamera.git;protocol=ssh;branch=master"
 SRCREV = "7e4f1d379d698c44501fb84b886fadf3fc164b70"
 
-S = "${WORKDIR}/git"
 
 inherit setuptools3
 
diff --git a/recipes-multimedia/rpidistro-ffmpeg/rpidistro-ffmpeg_5.1.4.bb b/recipes-multimedia/rpidistro-ffmpeg/rpidistro-ffmpeg_5.1.4.bb
index e8f640b..4a07f50 100644
--- a/recipes-multimedia/rpidistro-ffmpeg/rpidistro-ffmpeg_5.1.4.bb
+++ b/recipes-multimedia/rpidistro-ffmpeg/rpidistro-ffmpeg_5.1.4.bb
@@ -50,7 +50,6 @@ SRC_URI = "\
 
 SRCREV = "1c363463c432c5ed492c7b759abb6e015b93b6b5"
 
-S = "${WORKDIR}/git"
 
 # libraries to build in addition to avutil
 PACKAGECONFIG[avdevice] = "--enable-avdevice,--disable-avdevice"
-- 
2.34.1


