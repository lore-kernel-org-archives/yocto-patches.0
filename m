Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E5CF857B
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 10:25:45 +0000 (UTC)
Received: from elephant.ash.relay.mailchannels.net (elephant.ash.relay.mailchannels.net [23.83.222.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31169.1763634334779950012
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 02:25:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@rootcommit.com header.s=hostingermail-a header.b=BcsqPQhG;
 spf=pass (domain: rootcommit.com, ip: 23.83.222.57, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4584746215F
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 10:25:31 +0000 (UTC)
Received: from fr-int-smtpout22.hostinger.io (trex-green-4.trex.outbound.svc.cluster.local [100.98.42.205])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 35A1346209D
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 10:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763634330;
	b=ZvWA1SDco0vjbALt85FBDFCMaW0A7/Z+TEI47l/Q5GXDxuMAmb5TzeWGwlhgIgdVLSlrqU
	jAMCVZgjBAtm4/Ja0wjPMQm4/Zin4EtKVRR5bS7PVQKag30kNaUEUroPBfHFjekqCiXs7i
	NA0f2dRcVs2ShNxjZosS++PllELd0TA5XWsJqwcTV2wmNocWUW6jSdh8rMdWeeQ8gsMn8b
	WEabj33t6ozl9aLxdywP6lVXL/LmUobNRGa7UnwZWq/WkkKklHwVJj43vjC2ST4S6DXRro
	d1bmogPu+Pv7nQA7SjVhwnAEIrfINNX+ECJ5xDVrNFF5viXtp9vrHeMoccIMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763634330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=hxjRo3VuJVivg4O9SfjDxRa7LLM3OPLwJG43HpZx45w=;
	b=Yoa08mYWzRa8b1FwMFSgldv/DixcwG6ylp1aanZTt9PWAvf3116RUPEtpB9CQVmovC4BEG
	tkwo2TBjdtTa1v3OATYL8kWGecsAxkT596qvpbCKOsVDWb5ZbuSGRoqiR7L6Bisyo4SKIo
	ZAHR33loBgXiOVd5W+deJ5nToResg3nOW4tzo+CrhKYl9XM8XyvvqtdozWUyK8oIbaAsYh
	PWUGqBBg+jBXx55JPbaubvT+JWr+mCoifWZ6uEfE8yO6ph/F5oKoHgXnZpHmNPlFb87DS8
	DQu3P894aGD2FWRZrCeNBFzOGOlzVInCfvS7hq57Jpp/dhYH9Ld+gcCsYwME0Q==
ARC-Authentication-Results: i=1;
	rspamd-5ffd6989c9-rdbjh;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Fearful-Arithmetic: 591ef345730236ce_1763634330747_3179291881
X-MC-Loop-Signature: 1763634330747:493499772
X-MC-Ingress-Time: 1763634330746
Received: from fr-int-smtpout22.hostinger.io (fr-int-smtpout22.hostinger.io
 [148.222.54.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.42.205 (trex/7.1.3);
	Thu, 20 Nov 2025 10:25:30 +0000
Received: from [127.0.1.1] (unknown [IPv6:2001:861:4450:d360:a066:6d43:e556:60e2])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dBvcl1KSLzybG;
	Thu, 20 Nov 2025 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1763634327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hxjRo3VuJVivg4O9SfjDxRa7LLM3OPLwJG43HpZx45w=;
	b=BcsqPQhGa5UZnhLe3qtit864CdI9eav5uHCIp7XcoPIVsV5WqOHdv+Z3FMadvBQeMMc6t7
	mRKiOqn2CIHkSmXXDDFAdE1rUF0KnoJFcK3CAxgKxv32yJGI5aB8dmBLPv2lgjBvVmJPb3
	30q/++Dcca10wSR6LY+OqSFcibqlZkP/zXfIOnwJityVEz6qvs2TFjFKNALD/hStCbX20b
	L8SUdBq4mYZA3Rw6CtRzt0g2W/oDF6meeEheKnizusiLwcw+wmhy0yzGFNqSL9OHJQyooZ
	GFNa5MLntDkF9HZ40cY1JzwrRF7Y/3ZxeBhZMkIu5Pw2/luoo798iQBGciiHzg==
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Subject: [PATCH meta-rockchip] orangepi-3b: add
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251120-orangepi-3b-v1-1-3d31722d6fef@rootcommit.com>
X-B4-Tracking: v=1; b=H4sIAI3sHmkC/x2MywrDIBAAf0X23AXXEPr4ldJD1G1dSlXWUgLBf
 4/pcQZmNmiswg1uZgPlnzQpeQCdDIS05BejxMHgrJuJnMWih62Ck8fJEQW6+kv0ZxhFVX7K+r/
 d4cPfBbWEd0hS4dH7DmmAeE1sAAAA
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>
X-Mailer: b4 0.13.0
Date: Thu, 20 Nov 2025 10:25:27 +0000 (UTC)
X-CM-Envelope: MS4xfE5oMO4DO1EuD6g6qDv4f23k/rQkUwaIt5ov7JGphZR0FlL4R/t7BDEVOt/vtPh1WD9z/LG6a/ycIzx2DJaT6ytSloFgqPgG7/7tZvPlY8K3IIgdss6V vPuhee8wsdO88ueyZ4AYlsLT2VFZUg5TJrKUq4vDwO5cCUj/g+ZOizB2tJQNRQarLAgTwVj/gZNUEavA+91maOnKbxksQG5YtpTiVC0zcuR1n5anpZm02vga Bp6Ks3LRbFDZBcBs/PHQirtdTOKDp/KEzHyUYGO0Np8IlUn8Ibq6teCYRfOmA1fm/Ozwp/kJ+XggYRTfn7EcxmO1b18ZK5tMSc+yO1YrOIo=
X-CM-Analysis: v=2.4 cv=DJTd4DNb c=1 sm=1 tr=0 ts=691eec97 a=l2urqJcD81kOlpy6CkxEZg==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=5dAzR5NRAAAA:8 a=d70CFdQeAAAA:8 a=aPf4wIkZ49BEWAetmZsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=tFHjQltceoMA:10 a=ZKAZAlVgJm32z6MX8p4a:22 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 10:25:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2621

The Orange Pi 3B board is a Raspberry Pi sized single board computer
based on the Rockchip RK3566:

http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details=
/Orange-Pi-3B.html

    Tech specs:
    - Rockchip RK3566 (4x Arm Cortex-A55 @ 1.6GHz)
    - Arm Mali-G52-2EE (OpenGL ES 1.1/2.0/3.0/3.1/3.2, Vulkan 1.1, OpenCL=
 2.0)
    - LPDDR4 RAM (2/4/8 GB)
    - =C2=B5SD
    - SPI flash (16/32 MB)
    - optional eMMC pluggable module (16/32/64/128/256 GB)
    - Wi-Fi5 + Bluetooth 5.0, BLE
    - 1x USB 2.0 Type A OTG, 2x USB 2.0 Type A HOST, 1x USB 3.0 Type A Ho=
st
    - 1x HDMI (up to 4K @ 60fps)
    - 1x MIPI CSI LCD port
    - 1x MIPI CSI camera port
    - colour-coded 40-pin GPIO (uart, spi, i2c, pwm, gpio)
    - Gigabit Ethernet port
    - optional M.2 M-KEY PCIe port
    - 89 x 56 mm

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 README                                      |  1 +
 conf/machine/orangepi-3b.conf               | 11 +++++++++++
 recipes-kernel/linux/linux-yocto_%.bbappend |  1 +
 3 files changed, 13 insertions(+)

diff --git a/README b/README
index f55f750..6a13428 100644
--- a/README
+++ b/README
@@ -31,6 +31,7 @@ Status of supported boards:
 			nanopi-m4b
 			nanopi-r2s
 			nanopi-r4s
+			orangepi-3b
 			orangepi-5-plus
 			radxa-zero-3e
 			radxa-zero-3w
diff --git a/conf/machine/orangepi-3b.conf b/conf/machine/orangepi-3b.con=
f
new file mode 100644
index 0000000..eadf458
--- /dev/null
+++ b/conf/machine/orangepi-3b.conf
@@ -0,0 +1,11 @@
+#@TYPE: Machine
+#@NAME: Orange Pi 3B v2.1
+#@DESCRIPTION: 3th generation SBC designed by Kunlong Co.,Limited.
+#http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/detai=
ls/Orange-Pi-3B.html
+
+require conf/machine/include/rk3566.inc
+
+KERNEL_DEVICETREE =3D "rockchip/rk3566-orangepi-3b-v2.1.dtb"
+MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"
+
+UBOOT_MACHINE =3D "orangepi-3b-rk3566_defconfig"
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel=
/linux/linux-yocto_%.bbappend
index da1b172..2dba3d7 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -16,6 +16,7 @@ COMPATIBLE_MACHINE:nanopi-m4-2gb =3D "nanopi-m4-2gb"
 COMPATIBLE_MACHINE:nanopi-m4b =3D "nanopi-m4b"
 COMPATIBLE_MACHINE:nanopi-r2s =3D "nanopi-r2s"
 COMPATIBLE_MACHINE:nanopi-r4s =3D "nanopi-r4s"
+COMPATIBLE_MACHINE:orangepi-3b =3D "orangepi-3b"
 COMPATIBLE_MACHINE:orangepi-5-plus =3D "orangepi-5-plus"
 COMPATIBLE_MACHINE:radxa-zero-3 =3D "radxa-zero-3"
 COMPATIBLE_MACHINE:roc-rk3308-cc =3D "roc-rk3308-cc"

---
base-commit: f32c5da2c502c43c9dd3663a6b3cbfa37539d197
change-id: 20251120-orangepi-3b-3211c19b8db7

Best regards,
--=20
Michael Opdenacker <michael.opdenacker@rootcommit.com>


