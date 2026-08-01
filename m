Return-Path: <vinay@v-patil.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02533C5516F
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 21:40:34 +0000 (UTC)
Received: from outbound.pv.icloud.com (outbound.pv.icloud.com [57.103.65.234])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13663.1785620422386383061
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 01 Aug 2026 14:40:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@v-patil.com header.s=sig1 header.b=BDtgtWwQ;
 spf=pass (domain: v-patil.com, ip: 57.103.65.234, mailfrom: vinay@v-patil.com)
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-7 (Postfix) with ESMTPS id 4BE2C1800120;
	Sat, 01 Aug 2026 21:40:19 +0000 (UTC)
X-ICL-RepId: 019fbf45-5258-722d-9f97-fe5bdb5b7edd
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBAHVwFUxxBCkgdXANaEhVdRUUEWQpLME9VQwxDAl5eWhdeTVEPDwYUCFIZXgccE1YVEx9UVgFQUR1fAgoERwRbF0YDU0VCBhcRUAFYHlZeWhdeTUcfQE1iSQFaGVscQBdKbk1TDw8GFAhSGV4HHBNWFRMAXg8PTAtIAVsHUwJBC0kHXQdeHEMATAtABkZEGVcZSi1BRkIRTRFfQ1QEX04ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=v-patil.com; s=sig1; t=1785620421; x=1788212421; bh=NHzpZHNO4nE3Q2muUs4DH8aIkkBXblPWmpTyo/qQvSY=; h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme; b=BDtgtWwQr0Nk9E6OPrAIN4VtHcilpma4gcPiOS7P6LcE3QXVb69hxER93j+2OkCMMDWDnRgJ7O0VFAORPZWEWYSpr60xujEtpu5Egobb7Lq6u6yTHct4kepzlfuU4PwCs/02Om+0KMNIa+1DVnF3UAEsclsLjTG/n6+25n5pusvW8uyhx0CAiWaDOCaI+TN0xbUwwNnzxQyYDDi1NGYAxWYSji028q2bK/Ua/qTlEBKSQR+RrR6PgBtxF3d4cV6JIZsfngui8OI1I9RZ5xv9hClVFJ+aSUIcHa4Ba5zaqzkGsWh/cr1J5stmDcZHLBddfNLFwCYtKch+BkXRyU0EPw==
mail-alias-created-date: 1761599442858
Received: from localhost.localdomain (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-7 (Postfix) with ESMTPSA id CFBD8180010F;
	Sat, 01 Aug 2026 21:40:17 +0000 (UTC)
From: Vinay Patil <vinay@v-patil.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Vinay Patil <vinay@v-patil.com>
Subject: [meta-rockchip] [PATCH] rock-5b-plus: add
Date: Sat,  1 Aug 2026 21:40:05 +0000
Message-Id: <20260801214005.3948-1-vinay@v-patil.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: colymD9Wkg3bhkCg_Do95-v7AMzbkDh-
X-Authority-Info-Out: v=2.4 cv=aLX9aL9m c=1 sm=1 tr=0 ts=6a6e67c3
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ksxQWNrZAAAA:8 a=Lu2rwPLOAAAA:8 a=EyyYkJS4udwgHj1ysDMA:9
 a=l7WU34MJF0Z5EO9KEJC3:22 a=W0bwAMBE2Sel-UYqUuEJ:22
X-Proofpoint-GUID: colymD9Wkg3bhkCg_Do95-v7AMzbkDh-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE3MyBTYWx0ZWRfXwT5ZyTFLDEEN
 oQ8UInEEyX7Q4BXG2yrGYwGVp1ZIU0UmWpw70UjfU1u0BtxpZ6xcy7mZhizoBvxHVyRpq9QQ3G0
 UVFeQQ+Q5NAJpwlPitfm6GXjJozoSC5FFxXCr6dOIEamYQz9lRqgdr+898c9IIwabSRWjODKHRb
 G3PuavPaMd62tA0kmBKVwxZO7Vo/y2CezCYwIGb2pjUlZgWR4SemjCPPnNt3jRbs5yybx07ZjaE
 bc7BW4tbgdsv77LZkS6FtnAbMbIssPxr1XzfpQNzr8GwNRjVPYKJyOatq5xcyo0U9C48wohVNs/
 /903RCnJA/oFTI68R84gtpM7mka7fzVi0GmywlM/426WMlkmYrsvs6LvfDQYG4=
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 01 Aug 2026 21:40:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4616

The Radxa ROCK 5B+ is an RK3588-based single-board computer and a
successor to the ROCK 5B. It features LPDDR5 memory, onboard Wi-Fi 6,
Bluetooth 5.2, dual M.2 M-Key connectors and 2.5 Gigabit Ethernet.

Product Page:
https://radxa.com/products/rock5/5b-plus/

Documentation page:
https://docs.radxa.com/en/rock5/rock5b

Specs:

- Rockchip RK3588
- Quad-Core Arm Cortex-A76 @ 2.4GHz
- Quad-Core Arm Cortex-A55 @ 1.8GHz
- Arm Mali-G610 MP4 GPU
- OpenGL ES 1.1/2.0/3.2
- OpenCL 1.1/1.2/2.2
- Vulkan 1.2
- 6 TOPS neural processing unit
- LPDDR5 RAM (4/8/16/32 GB)
- Onboard eMMC socket
- 2x M.2 M-Key connectors supporting NVMe SSDs
- 1x M.2 E-Key connector
- 1x MicroSD card slot
- 2x HDMI outputs
- 1x HDMI input
- 1x DisplayPort over USB Type-C
- 2x MIPI DSI
- 2x MIPI CSI
- Wi-Fi 6 and Bluetooth 5.2 with BLE
- 1x 2.5 Gigabit Ethernet
- 2x USB 3.0 HOST ports
- 2x USB 2.0 HOST ports
- 1x 4-ring 3.5mm audio jack
- 40-pin GPIO header with UART, SPI, I2C, I2S, PWM and GPIO
- USB Type-C power input

Signed-off-by: Vinay Patil <vinay@v-patil.com>
---
 README                                  |  1 +
 conf/machine/rock-5b-plus.conf          | 11 +++++++++++
 recipes-kernel/linux/linux-rockchip.inc |  1 +
 3 files changed, 13 insertions(+)
 create mode 100644 conf/machine/rock-5b-plus.conf

diff --git a/README b/README
index c2697d1..6825009 100644
--- a/README
+++ b/README
@@ -41,6 +41,7 @@ Status of supported boards:
 			rock-4c-plus
 			rock-5a
 			rock-5b
+			rock-5b-plus
 			rock-pi-4a
 			rock-pi-4b
 			rock-pi-4b-plus
diff --git a/conf/machine/rock-5b-plus.conf b/conf/machine/rock-5b-plus.c=
onf
new file mode 100644
index 0000000..bfa3714
--- /dev/null
+++ b/conf/machine/rock-5b-plus.conf
@@ -0,0 +1,11 @@
+#@TYPE: Machine
+#@NAME: Radxa Rock 5B plus
+#@DESCRIPTION: ROCK5 is the 5th generation of SBC designed by Radxa.
+#https://docs.radxa.com/en/rock5/rock5b
+
+require conf/machine/include/rk3588.inc
+
+KERNEL_DEVICETREE =3D "rockchip/rk3588-rock-5b-plus.dtb"
+MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"
+
+UBOOT_MACHINE =3D "rock5b-rk3588_defconfig"
diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/lin=
ux/linux-rockchip.inc
index 6c62e84..6c012d4 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -25,6 +25,7 @@ COMPATIBLE_MACHINE:rock-3a =3D "rock-3a"
 COMPATIBLE_MACHINE:rock-4c-plus =3D "rock-4c-plus"
 COMPATIBLE_MACHINE:rock-5a =3D "rock-5a"
 COMPATIBLE_MACHINE:rock-5b =3D "rock-5b"
+COMPATIBLE_MACHINE:rock-5b-plus =3D "rock-5b-plus"
 COMPATIBLE_MACHINE:rock-pi-4 =3D "rock-pi-4"
 COMPATIBLE_MACHINE:rock-pi-e =3D "rock-pi-e"
 COMPATIBLE_MACHINE:rock-pi-s =3D "rock-pi-s"
--=20
2.34.1


