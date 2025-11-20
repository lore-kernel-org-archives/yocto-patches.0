Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3245CF884B
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 12:11:15 +0000 (UTC)
Received: from cow.pear.relay.mailchannels.net (cow.pear.relay.mailchannels.net [23.83.216.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32785.1763640674775882104
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 04:11:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@rootcommit.com header.s=hostingermail-a header.b=qH0HMELM;
 spf=pass (domain: rootcommit.com, ip: 23.83.216.41, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D4AA418118E
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 12:11:13 +0000 (UTC)
Received: from fr-int-smtpout22.hostinger.io (100-127-179-109.trex-nlb.outbound.svc.cluster.local [100.127.179.109])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 37BBD1810E6
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 12:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763640673;
	b=oG1w5Sji63+1fe/u09y3W2we52wvEW1axxxKviZ0f+BTc8kSNBDVFaZ8NsD5+LfcOmWMzi
	2+P0xU1htsb+wxUbU7JSO6/phftnWwSQtgpCJ7HHABGwKCSraxQHAhfy5fSKqK9M+DcBUl
	cRBpbq90mOlG7KYLiB7Aak1K6NJddWS6XfGGTZ257B32uNlV18z0pOtffuLg5DXleP/S3h
	vPwCXrbRoASLtnGd6/6QNJRRNjLmXEQL1U5P1dVcXjnGZBTJUSl3aObicsR3mH1D3cBXy4
	Yywwanjt1NO6vh1JbVVgO1oS3r0pX0jkr2TDf/Vc5BZLl5qPtODnwK8Pxp7FIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763640673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=CEKdB6oAfF8W5KoakIf1ogEpn3ZTv+/1g18PWll9iIg=;
	b=6F+Eg1+5S+IYOnRgAViSE1zjIICw8UWLzKJftsjGVLhbw3hKqKL+XhYzHyyzr+dRZALwZd
	96PR+sxjssxAiod4Bvc2kT04S1iU9r3W+yzAJsqKK1v0KjwUND/0PQUPcjnZ2yujoGZqjJ
	9bPcTaFoUohEtf8ZUMlSU0VLnuySjeXMrv1+Cj/8kaB6OcX3m1tZcHsPgwEYTTJejTpG94
	WDXjxKAE8Pb0YT6mGBTdAQLC9lYm9EDBA63AItW+MJm01fMP4vs0jKkNGmd1SlATOpDpWk
	hawvIiY/oTlwtoMfBqxoS9Jypfwo4PgDZzFjYJYxrUt5lQ68o+i+9MjHoM3liw==
ARC-Authentication-Results: i=1;
	rspamd-55b59744f-9n86x;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Good
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Abiding-Ruddy: 2ffc4bf4492b4cac_1763640673749_408250478
X-MC-Loop-Signature: 1763640673749:4250497859
X-MC-Ingress-Time: 1763640673749
Received: from fr-int-smtpout22.hostinger.io (fr-int-smtpout22.hostinger.io
 [148.222.54.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.179.109 (trex/7.1.3);
	Thu, 20 Nov 2025 12:11:13 +0000
Received: from [127.0.1.1] (unknown [IPv6:2001:861:4450:d360:a066:6d43:e556:60e2])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dBxyl0vH2zyZF;
	Thu, 20 Nov 2025 12:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1763640671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CEKdB6oAfF8W5KoakIf1ogEpn3ZTv+/1g18PWll9iIg=;
	b=qH0HMELMVABYaI8I/7POUcUtFp+oAYFEQQoWJuBHtiNKtMPcNlyolmCrD5hdNtY2ieZ5DZ
	NUClEPpn/HAYRSQ340iwptaE2XB4v01lpEfeFEKE+ZtVj3cNObbjoczXIwceMw4XLqEKcN
	A4wz2JrPgcC61pqgoAviXm4yYCbmAM5tWA7XJ1C4SZKvXfMGwijiyTjhZPQgoGaP7ByNWG
	catNBiEUxzqwuR03h+t+w0WOvcQKLamh0VqJ7E1JeXTViH3MUDyp/aQnogYrCMsKYTANbh
	E05JRPwikTYuhtOeW6zcuTQMxJPz5xhLIMOXNTfx6mvpxuo6x4wKn4tZrRPu1A==
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Subject: [PATCH meta-rockchip v2] orangepi-3b: add
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251120-orangepi-3b-v2-1-48df6c49609c@rootcommit.com>
X-B4-Tracking: v=1; b=H4sIAFsFH2kC/21NSw6CMBC9Cpm1Y5hpFHXlPQwLaAeZGGjTNkRDu
 LuVtauX918hSVRJcKtWiLJoUj8XwocK7NjNT0F1hQPXfCLiGn38qUHR9GiYyNK1v7i+gdIIUQZ
 972sPmCR3GL192VEDtMUeNWUfP/vXQnvo7+xCSGicoYbZnQcZ7tH7bP00aT4WgHbbti9n/Pgdu
 gAAAA==
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>
X-Mailer: b4 0.13.0
Date: Thu, 20 Nov 2025 12:11:11 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=GbNFnhXL c=1 sm=1 tr=0 ts=691f055f a=l2urqJcD81kOlpy6CkxEZg==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=5dAzR5NRAAAA:8 a=VwQbUJbxAAAA:8 a=d70CFdQeAAAA:8 a=GkU4xLVtkNox0wWLLKgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=tFHjQltceoMA:10 a=ZKAZAlVgJm32z6MX8p4a:22 a=NcxpMcIZDGm-g932nG_k:22
X-CM-Envelope: MS4xfBdfUqpzVvFuoEhHtxHM06lwO1mjxpEuBl8BqZcZbPrFwdmVs4BRQhPezgU2wUZ7orxSHiIWFYrHegAIcb3E3RisrUrE2YBFImSTVAlClpWeBJiiwVlD hNIaYdLREE3vnEVpr0RxNyveCh3zjjuLcNePQisVco5ZxzJyesKEUlTznnko5agGo9zxaPS6ojlQw7/4bTTilcZ9MlpvEcy6xdV3HK0lWfD9woSD7A9ysxyH zco9JqS0X6rDI5JHHpv8887nJmEzVgXcuIhmlNNvuX2HSBK/Abg+dHh0ojuwWpzwpFUTkb+TUiG6OOtxeq27eL9y5b+yCN742c4JQ7//hVk=
X-AuthUser: michael.opdenacker@rootcommit.com
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 12:11:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2628

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
    - 1x MIPI DSI LCD port
    - 1x MIPI CSI camera port
    - colour-coded 40-pin GPIO (uart, spi, i2c, pwm, gpio)
    - Gigabit Ethernet port
    - optional M.2 M-KEY PCIe port
    - 89 x 56 mm

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
Changes in v2:
- Fixed commit message:
  "1x MIPI CSI LCD port" -> "1x MIPI DSI LCD port"
- orangepi-3b.conf:
  - Replaced "Orange Pi 3B v2.1" by #Orange Pi 3B"
    in the "#@NAME:" line
  - Replaced "3th generation SBC" by "Raspberry Pi sized SBC"
    in the "#@DESCRIPTION:" line.
- Link to v1: https://lore.kernel.org/r/20251120-orangepi-3b-v1-1-3d31722=
d6fef@rootcommit.com
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
index 0000000..ba4d8c5
--- /dev/null
+++ b/conf/machine/orangepi-3b.conf
@@ -0,0 +1,11 @@
+#@TYPE: Machine
+#@NAME: Orange Pi 3B
+#@DESCRIPTION: Raspberry Pi sized SBC designed by Kunlong Co.,Limited.
+#http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/detai=
ls/Orange-Pi-3B.html
+
+require conf/machine/include/rk3566.inc
+
+KERNEL_DEVICETREE =3D "rockchip/rk3566-orangepi-3b-v2.1.dtb rockchip/rk3=
566-orangepi-3b-v1.1.dtb"
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


