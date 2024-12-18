Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1FEE77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 10:46:54 +0000 (UTC)
Received: from 2.mo582.mail-out.ovh.net (2.mo582.mail-out.ovh.net [46.105.76.65])
 by mx.groups.io with SMTP id smtpd.web10.102462.1734518761756104824
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Dec 2024 02:46:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@3mdeb.com header.s=ovhmo3617313-selector1 header.b=ViJF1GUc;
 spf=softfail (domain: 3mdeb.com, ip: 46.105.76.65, mailfrom: daniil.klimuk@3mdeb.com)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.108.9.32])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4YCr200178z1RZT
	for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Dec 2024 10:45:59 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-ww7cs (unknown [10.110.101.105])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 003E71FE8B;
	Wed, 18 Dec 2024 10:45:58 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.96])
	by ghost-submission-5b5ff79f4f-ww7cs with ESMTPSA
	id d8RmIuanYmdbfAAA6zOj7A
	(envelope-from <daniil.klimuk@3mdeb.com>); Wed, 18 Dec 2024 10:45:58 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-96R001dc07e684-1402-40a5-97b7-802f9144c570,
                    5C288CA946AEF4DDBB46030A318C0F4C5FE4FC4D) smtp.auth=daniil.klimuk@3mdeb.com
X-OVh-ClientIp: 93.174.30.2
From: "Danik" <daniil.klimuk@3mdeb.com>
To: yocto-patches@lists.yoctoproject.org
Cc: piotr.krol@3mdeb.com,
	maciej.pijanowski@3mdeb.com,
	twoerner@gmail.com
Subject: [meta-rockchip] [PATCH] add Quartz64-A
Date: Wed, 18 Dec 2024 11:45:57 +0100
Message-ID: <20241218104557.45036-1-daniil.klimuk@3mdeb.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Ovh-Tracer-Id: 12098638926148113601
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhiihhlucfmlhhimhhukhcuoegurghnihhilhdrkhhlihhmuhhkseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpeetfeeijefhteekkefhvedttdejfeejgeeihfdtieegheeiieekhfeiueefvedugfenucffohhmrghinhepphhinhgvieegrdhorhhgnecukfhppeduvdejrddtrddtrddupdelfedrudejgedrfedtrddvpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggrnhhiihhlrdhklhhimhhukhesfehmuggvsgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdpoffvtefjohhsthepmhhoheekvdgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=E35Sw84SWeEW8Ftw4NWxcNFRLs9h7MX3zYI/9m91Q08=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734518760; v=1;
 b=ViJF1GUcjnXgdaSJ/rXl/WM9cFRewdB59Q/s2W1xG+T2rK+vKcdHT+5vDlZWBGr1lQs5qzX3
 KR5Ok4BPfId8RuZDzYXAeKQ29WkNXWx7Nxz04yCkZzwnh673HDlS5I3OzAg6nUklqQpfEjeufw2
 RgC7C0ys15dEcpK46IFDeJ1E53zv4hlEFDHJkPgJKL4ujZm6AcIHiZkiqkjgJfjUoe2AQTDvS4w
 6hW08swe5h3oT9f3JEgKY7laIl/5aO/Kkp2IShpNavUzU/HSYFu1G5FPno0UhMQQ234/kjltgeG
 rbkPCY69m1TNl0r9uBWo8madl1rM/Q8ZhsQTL3jFyOm8w==
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Dec 2024 10:46:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/934

Add Quartz64-A support.

Signed-off-by: Daniil Klimuk <daniil.klimuk@3mdeb.com>
---
 README                                      |  1 +
 conf/machine/quartz64-a.conf                | 13 +++++++++++++
 recipes-kernel/linux/linux-yocto_%.bbappend |  1 +
 3 files changed, 15 insertions(+)
 create mode 100644 conf/machine/quartz64-a.conf

diff --git a/README b/README
index 4c75ac9d574d..4c50786433d5 100644
--- a/README
+++ b/README
@@ -47,6 +47,7 @@ Status of supported boards:
 			rock-pi-s
 			rock64
 			soquartz (on model A base board)
+			quartz64-a
=20
 	builds:
 		32-bit:
diff --git a/conf/machine/quartz64-a.conf b/conf/machine/quartz64-a.conf
new file mode 100644
index 000000000000..83190a10013d
--- /dev/null
+++ b/conf/machine/quartz64-a.conf
@@ -0,0 +1,13 @@
+#@TYPE: Machine
+#@NAME: Quartz64 Model A
+#@DESCRIPTION: The Quartz64 Model A is powered by a Rockchip RK3566 quad=
-core
+# ARM Cortex A55 64-Bit Processor with a Mali G-52 GPU. It comes equippe=
d with
+# 2GB, 4GB or 8GB LPDDR4 system memory, and a 128Mb SPI boot flash.
+# https://pine64.org/devices/quartz64_model_a/
+
+require conf/machine/include/rk3566.inc
+
+KERNEL_DEVICETREE =3D "rockchip/rk3566-quartz64-a.dtb"
+MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"
+
+UBOOT_MACHINE =3D "quartz64-a-rk3566_defconfig"
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel=
/linux/linux-yocto_%.bbappend
index 91a9b8e0abcb..8b47503fa3fa 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -24,6 +24,7 @@ COMPATIBLE_MACHINE:rock-5a =3D "rock-5a"
 COMPATIBLE_MACHINE:rock-5b =3D "rock-5b"
 COMPATIBLE_MACHINE:soquartz =3D "soquartz"
 COMPATIBLE_MACHINE:radxa-cm3 =3D "radxa-cm3"
+COMPATIBLE_MACHINE:quartz64-a =3D "quartz64-a"
=20
 SRC_URI:append =3D " file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-=
kmeta;destsuffix=3Drockchip-kmeta"
 SRC_URI:append:nanopi-r4s =3D " file://nanopi-r4s.scc"
--=20
2.47.1


