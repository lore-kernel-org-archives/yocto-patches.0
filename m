Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F0D68BE1
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 06:03:42 +0000 (UTC)
Received: from cow.pear.relay.mailchannels.net (cow.pear.relay.mailchannels.net [23.83.216.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35464.1766037819920629033
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Dec 2025 22:03:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@rootcommit.com header.s=hostingermail-a header.b=CQ4Duaua;
 spf=pass (domain: rootcommit.com, ip: 23.83.216.41, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 14EA5441369
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 06:03:39 +0000 (UTC)
Received: from de-fra-smtpout6.hostinger.io (100-109-2-65.trex-nlb.outbound.svc.cluster.local [100.109.2.65])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5E3944420C1
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 06:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1766037818;
	b=Va7LAERbA1AK8AuRGExue0wiQACFpyUSO3zt5x30XDHlVOppW4FvRcOEDJiGq/Sse9igmL
	GiD7eOWG9f4ovwkiGgVjF8Kd3PyfMkvoDNGBq2rNrsZ+P944VsiJsn+ZEIh4sXcUH2vQKF
	Ls0j9tUIhYXIVG2NTlpHT35h5rOHi0+B3oSUKjezTIDl5H9KtD/9MsdYUMQQmOXQuLTEfd
	4EYBAxkdkgyveJoVpC+GbcevvN80hG8/S7B//JL3EF6e1lVXk1/vh//Iykz4Ql0pBG2q5O
	fP1Vig6OgS39Ibx8OaeKDYPcCfikJglz3cSGa6IfuGn55u09vO3CvaSAf3gOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1766037818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Ajki7utQeB8iflaN07Cqswy9TuqXgqlcwohCQj07Wow=;
	b=tn6YPuviwK4QRAxBGa4zqZYLabuaJIKj9/gdGvn1AL457I262hJG7NNosb30RiWIUhHsbD
	zLsvKAqKVDhacdsNCvqow80nEoc1hDArshOwAnYR1gTjooH9T0sK+4R2W7yfh5AFLMmZQ2
	TxSOKJHKAglFdkTDTOkmgPpVK/S2MjA3cOYiklgjReU3VQU2H46qCj7zN9+wB7TwABHdxu
	DafzMhWDnTLWaZrNbDC5qbpPaIjtiVxOswef3rB5u5M1vhjZwCVufT7KXtJfdSlpQL2TNq
	q+QIY1nLzYgbaaTILyEJMPBMN2vMN3lWlaeHO0ZZi/bNnSnohROE7RpaoYZmJw==
ARC-Authentication-Results: i=1;
	rspamd-6ccd5b4cc5-8lkh2;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Good
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Inform-Spicy: 0008830747b6911a_1766037818886_3822447355
X-MC-Loop-Signature: 1766037818886:4119337196
X-MC-Ingress-Time: 1766037818886
Received: from de-fra-smtpout6.hostinger.io (de-fra-smtpout6.hostinger.io
 [148.222.55.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.2.65 (trex/7.1.3);
	Thu, 18 Dec 2025 06:03:38 +0000
Received: from localhost.localdomain (unknown [IPv6:2001:861:4450:d360:6f03:783f:9b5b:57c1])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dX0Th44vcz3wc1;
	Thu, 18 Dec 2025 06:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1766037816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ajki7utQeB8iflaN07Cqswy9TuqXgqlcwohCQj07Wow=;
	b=CQ4Duauamo2iwdXb6iZ6ItThG+Qx34xczyYcY8YWvKkFn85vUliK71w8pPs9yCxHNro9fJ
	5udTXnC7OgVSgBAbD+yD7+BZ+U5pSOHgs5JQ70yz7f8416C5/wRqyK9zyrvUzQy470ePXk
	S0FKqaF9TGW1u1Wx3yapvBFXUtL/AEF83+1xILmunKrcnxb/3aNcO+DQNgcvKFYshb2eBY
	80uA/y86+13wZUwtVddmz4Jly52QxvMDTHFGFdC80GUrOmeDHxgZ9MPRDTUF6cQN/LjSUJ
	kHBLoahNBVRiaELINlEz7pCae4395HX6Y4KihGwZrJYvuic7uCjKa/wcBsYxoQ==
From: michael.opdenacker@rootcommit.com
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Subject: [meta-rockchip] [PATCH] tinker-board-3: add
Message-ID: <20251218060321.2194839-1-michael.opdenacker@rootcommit.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Date: Thu, 18 Dec 2025 06:03:36 +0000 (UTC)
X-CM-Envelope: MS4xfBj13XJkCjrBcxkvGNmL2NHpWghm99T2HPJqC9QUUQ3OFt/CaC9ARfD1Ufyb0IykY0QPso/FVlis/Z8ZYU9oRHI5JPN2T7Bn1h7ab6O3a5PevhZU3HvK BdA/Fz8umq+qXSfeV0k02fe1cOdHR3slMbfQT6vIh0hI0M7L1K3zFYOIJXuPqclY8c4XZcp/lo1Wk8KXpD5JgRcCMLbrvQH4eXCwXMwx3KnbZDBzzfyKNYXk ciGq6fYS6UXVXdrlIpo/CpTRK5N2btfo6xrWJ4/QC9OPpsk/oJRVydIXTZJiN54OhjavIjvP9YVA0bUDMlEO3FCbHfawhCZDqyA4pGisIsgjxdfB1axnKVo0 ULeWFuKn
X-CM-Analysis: v=2.4 cv=Ceda56rl c=1 sm=1 tr=0 ts=69439938 a=TJDTwvido1ACHfu3sFfMdQ==:617 a=xqWC_Br6kY4A:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=-Yt9tNsTAAAA:8 a=d70CFdQeAAAA:8 a=wLSwfkusHtFu5lftlTkA:9 a=qPQde0g9OtMA:10 a=HTceBwxjnJgA:10 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 06:03:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2813

From: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Add basic support for the Asus Tinker Board 3 [1] and 3S [2] SBCs,
with the Rockchip rk3566 SoC.

Support for such boards was introduced in the 6.19-rc1 version
of the Linux kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D9f80b3952318d7ef18573a5010f06118602f992e

Therefore, the https://github.com/betafive/meta-linux-mainline/
layer is currently a prerequisite to build images for such machines.

Here are already supported features:
- Debug UART (/dev/ttyS2)
- SD card (/dev/mmcblk1)
- eMMC (/dev/mmcblk0, only on Tinker Board 3S)
- I2C:
  - i2c0 (internal bus with a PMIC and regulators)
  - i2c2 (internal bus with an at24 eeprom and an RTC device)
- USB 2.0 ports
- 2 GPIO LEDS

[1] https://tinker-board.asus.com/series/tinker-board-3.html
[2] https://tinker-board.asus.com/series/tinker-board-3s.html

Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
---
 conf/machine/include/tinker-board-3.inc     | 11 +++++++++++
 conf/machine/tinker-board-3.conf            | 10 ++++++++++
 conf/machine/tinker-board-3s.conf           | 10 ++++++++++
 recipes-kernel/linux/linux-yocto_%.bbappend |  2 ++
 4 files changed, 33 insertions(+)
 create mode 100644 conf/machine/include/tinker-board-3.inc
 create mode 100644 conf/machine/tinker-board-3.conf
 create mode 100644 conf/machine/tinker-board-3s.conf

diff --git a/conf/machine/include/tinker-board-3.inc b/conf/machine/inclu=
de/tinker-board-3.inc
new file mode 100644
index 0000000..17d0ecc
--- /dev/null
+++ b/conf/machine/include/tinker-board-3.inc
@@ -0,0 +1,11 @@
+require conf/machine/include/rk3566.inc
+
+# Kernel provided by https://github.com/betafive/meta-linux-mainline/
+PREFERRED_PROVIDER_virtual/kernel =3D "linux-mainline"
+PREFERRED_VERSION_virtual/kernel =3D "6.19-rc1"
+
+MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"
+
+# U-Boot doesn't support Tinker Board 3 so far
+# but boots fine when configured for a similar SBC
+UBOOT_MACHINE =3D "soquartz-model-a-rk3566_defconfig"
diff --git a/conf/machine/tinker-board-3.conf b/conf/machine/tinker-board=
-3.conf
new file mode 100644
index 0000000..d6400f3
--- /dev/null
+++ b/conf/machine/tinker-board-3.conf
@@ -0,0 +1,10 @@
+# Copyright (C) 2025 Michael Opdenacker <michael.opdenacker@rootcommit.c=
om>
+# Released under the MIT license (see COPYING.MIT for the terms)
+
+#@TYPE: Machine
+#@NAME: Tinker Board 3 RK3566
+#@DESCRIPTION: ASUS Tinker Board 3 is a Raspberry Pi like SBC based on R=
ockchip RK3566 Processor.
+
+require conf/machine/include/tinker-board-3.inc
+
+KERNEL_DEVICETREE =3D "rockchip/rk3566-tinker-board-3.dtb"
diff --git a/conf/machine/tinker-board-3s.conf b/conf/machine/tinker-boar=
d-3s.conf
new file mode 100644
index 0000000..e23dc8b
--- /dev/null
+++ b/conf/machine/tinker-board-3s.conf
@@ -0,0 +1,10 @@
+# Copyright (C) 2025 Michael Opdenacker <michael.opdenacker@rootcommit.c=
om>
+# Released under the MIT license (see COPYING.MIT for the terms)
+
+#@TYPE: Machine
+#@NAME: Tinker Board 3S RK3566
+#@DESCRIPTION: ASUS Tinker Board 3 is a Raspberry Pi like SBC based on R=
ockchip RK3566 Processor.
+
+require conf/machine/include/tinker-board-3.inc
+
+KERNEL_DEVICETREE =3D "rockchip/rk3566-tinker-board-3s.dtb"
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel=
/linux/linux-yocto_%.bbappend
index 2dba3d7..684d33a 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -30,6 +30,8 @@ COMPATIBLE_MACHINE:rock-pi-e =3D "rock-pi-e"
 COMPATIBLE_MACHINE:rock-pi-s =3D "rock-pi-s"
 COMPATIBLE_MACHINE:rock64 =3D "rock64"
 COMPATIBLE_MACHINE:soquartz =3D "soquartz"
+COMPATIBLE_MACHINE:tinker-board-3 =3D "tinker-board-3"
+COMPATIBLE_MACHINE:tinker-board-3s =3D "tinker-board-3s"
=20
 SRC_URI:append:rockchip =3D " file://rockchip-kmeta;type=3Dkmeta;name=3D=
rockchip-kmeta;destsuffix=3Drockchip-kmeta"
 SRC_URI:append:nanopi-r4s =3D " file://realtek-r8169.cfg"

