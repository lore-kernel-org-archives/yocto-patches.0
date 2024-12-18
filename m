Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B395E77187
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 10:47:14 +0000 (UTC)
Received: from 5.mo581.mail-out.ovh.net (5.mo581.mail-out.ovh.net [178.32.120.239])
 by mx.groups.io with SMTP id smtpd.web10.102388.1734518348665574399
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Dec 2024 02:39:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@3mdeb.com header.s=ovhmo3617313-selector1 header.b=KQe02k4W;
 spf=softfail (domain: 3mdeb.com, ip: 178.32.120.239, mailfrom: daniil.klimuk@3mdeb.com)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.176.103])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4YCqt24sVBz1DVm
	for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Dec 2024 10:39:06 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-48qbt (unknown [10.108.54.44])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id D451A1FEB6;
	Wed, 18 Dec 2024 10:39:05 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.106])
	by ghost-submission-5b5ff79f4f-48qbt with ESMTPSA
	id V6NgF0mmYmfKUwAA5dmEAw
	(envelope-from <daniil.klimuk@3mdeb.com>); Wed, 18 Dec 2024 10:39:05 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-106R0061c0a09a5-2902-45c5-9f13-d06eec0960e6,
                    5C288CA946AEF4DDBB46030A318C0F4C5FE4FC4D) smtp.auth=daniil.klimuk@3mdeb.com
X-OVh-ClientIp: 93.174.30.2
From: "Danik" <daniil.klimuk@3mdeb.com>
To: yocto-patches@lists.yoctoproject.org
Cc: piotr.krol@3mdeb.com,
	maciej.pijanowski@3mdeb.com,
	twoerner@gmail.com
Subject: [meta-rockchip] [PATCH] add radxa-cm3
Date: Wed, 18 Dec 2024 11:39:04 +0100
Message-ID: <20241218103904.43032-1-daniil.klimuk@3mdeb.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Ovh-Tracer-Id: 11982389761891734721
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhiihhlucfmlhhimhhukhcuoegurghnihhilhdrkhhlihhmuhhkseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeegieevgfefgeejuedujefhueehkeeggeegleevffduvdeivdfhuefggfevffenucffohhmrghinheprhgrugigrgdrtghomhenucfkphepuddvjedrtddrtddruddpleefrddujeegrdeftddrvddpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggrnhhiihhlrdhklhhimhhukhesfehmuggvsgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdpoffvtefjohhsthepmhhoheekudgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=5kv1JLa5iMceiWNDl7vAcqrzHg4PigsgMTf6MEaWtoo=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734518346; v=1;
 b=KQe02k4WJ/RXi9hDDEZ4okf1avKQztgoES5ZdcXSWmRwJum+CQJWgHhldFEoNVeDg3jVNqAV
 uuTMFTkStoulliB91kTTt3PBe8sTg0vGvZY7gL1qy4Gd1en2hrxPAPf9798mP5ttNAMWozX05dN
 6/Vc9h9Z4gxRR8LOCyO70VBjBFQms0mW7CTfQw+5Eo5wQJE/ipl/21PWust/ghFcqZB6eMFQJ24
 9QGeQxJ6pkHPBFZ97ax0O6AdpFihlGrxohLgxZCP6vSPe1Ou6CufrT3uxGyfwwLMVU+SA+DeqPk
 qALcu0o+bRNqSGeFpqcAagVtNMYpLOG3iDmvOBSgPPnFQ==
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Dec 2024 10:47:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/935

Add Radxa Compute Module 3 support.

Signed-off-by: Daniil Klimuk <daniil.klimuk@3mdeb.com>
---
 README                                      |  1 +
 conf/machine/radxa-cm3.conf                 | 12 ++++++++++++
 recipes-kernel/linux/linux-yocto_%.bbappend |  1 +
 3 files changed, 14 insertions(+)
 create mode 100644 conf/machine/radxa-cm3.conf

diff --git a/README b/README
index 6bceba0c9cf0..4c75ac9d574d 100644
--- a/README
+++ b/README
@@ -31,6 +31,7 @@ Status of supported boards:
 			nanopi-r2s
 			nanopi-r4s
 			orangepi-5-plus
+			radxa-cm3
 			radxa-zero-3e
 			radxa-zero-3w
 			roc-rk3308-cc
diff --git a/conf/machine/radxa-cm3.conf b/conf/machine/radxa-cm3.conf
new file mode 100644
index 000000000000..2a6c62613978
--- /dev/null
+++ b/conf/machine/radxa-cm3.conf
@@ -0,0 +1,12 @@
+#@TYPE: Machine
+#@NAME: Radxa Rock CM3
+#@DESCRIPTION: Radxa Computing Module 3 Series (Radxa CM3 Series) is a s=
eries
+#System-on-Module based on the Rockchip RK356x series, containing proces=
sor,
+#memory, eMMC Flash and Power Management Unit. https://wiki.radxa.com/Ro=
ck3/CM3
+
+require conf/machine/include/rk3566.inc
+
+KERNEL_DEVICETREE =3D "rockchip/rk3566-radxa-cm3-io.dtb"
+MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"
+
+UBOOT_MACHINE =3D "radxa-cm3-io-rk3566_defconfig"
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel=
/linux/linux-yocto_%.bbappend
index 56ec9d7ea81b..91a9b8e0abcb 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -23,6 +23,7 @@ COMPATIBLE_MACHINE:rock-4c-plus =3D "rock-4c-plus"
 COMPATIBLE_MACHINE:rock-5a =3D "rock-5a"
 COMPATIBLE_MACHINE:rock-5b =3D "rock-5b"
 COMPATIBLE_MACHINE:soquartz =3D "soquartz"
+COMPATIBLE_MACHINE:radxa-cm3 =3D "radxa-cm3"
=20
 SRC_URI:append =3D " file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-=
kmeta;destsuffix=3Drockchip-kmeta"
 SRC_URI:append:nanopi-r4s =3D " file://nanopi-r4s.scc"
--=20
2.47.1


