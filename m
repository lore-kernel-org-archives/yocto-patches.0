Return-Path: <pbe@trifork.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3212D44148
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 11:46:19 +0000 (UTC)
Received: from mxout02.netic.dk (mxout02.netic.dk [77.243.50.218])
 by mx.groups.io with SMTP id smtpd.web11.18978.1732016775871966334
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Nov 2024 03:46:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@trifork.com header.s=dkim header.b=BqMf5NR9;
 spf=pass (domain: trifork.com, ip: 77.243.50.218, mailfrom: pbe@trifork.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=trifork.com; i=@trifork.com; l=10148; q=dns/txt;
  s=dkim; t=1732016776; x=1763552776;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  z=From:=20"Paul=20M.=20Bendixen"=20<pbe@trifork.com>|To:
   =20Trevor=20Woerner=20<twoerner@gmail.com>,=0D=0A=09"yoct
   o-patches@lists.yoctoproject.org"=20<yocto-patches@lists.
   yoctoproject.org>|Subject:=20Re:=20[meta-rockchip]=20[PAT
   CH]=20SOQuartz:=20add|Date:=20Tue,=2019=20Nov=202024=2011
   :46:11=20+0000|Message-ID:=20<2371750.ElGaqSPkdT@pbe-lati
   tude5501>|References:=20<3608313a-2d69-435d-807f-3dceb632
   6ca8@trifork.com>=0D=0A=20<20241118180317.GA17525@localho
   st>|In-Reply-To:=20<20241118180317.GA17525@localhost>
   |Content-ID:=20<7D7581B7A37B314081E4604B7C4C93BC@trifork.
   com>|Content-Transfer-Encoding:=20quoted-printable
   |MIME-Version:=201.0;
  bh=CC6nD/zwQnvNwn8vNOXGzp6dHL7uxbEWoKLIpAgsh20=;
  b=BqMf5NR9rIWE7ur8ex1OOgAkRJjJpJRqnTJzlhCXxUSb0P4Gf3ydjcUR
   Faumcd5bdKH7ljZIOlMxNIfj97hTr1zndsnouJMUVTbsmZDDC2Two6/SP
   He2arydOEL5VkXGhJCwYEvUVJsfkcylSY/640RCFyCfCcEUxwswlnWr4h
   Y=;
X-CSE-ConnectionGUID: glBCH/wnSAS4IdUPtwFa5A==
X-CSE-MsgGUID: nUuICXlpRG6nIFB4zxE1+w==
IronPort-Data: A9a23:vveZoq9TqQtvasWyxRxzDrUD6n+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 WYZXG6FbKqOMDf9KNl1YIiz8EoGvJaEzoJrGQRsqS4xFiIbosf7XtnIdU2Y0wF+jiHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+an9T8kk/nVHtIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8gVaYDkpOs/jf8Uo27ayr0N8llgdWic5j7Qa2e0Y9XMp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ais7XBtJFAatko2zhc+RK9
 Tl4ncfYpTHFnkH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhljJBleAGEWxgp4KW5K3
 9c4by8LVTm428O6/YqnVcdl2+12eaEHPKtH0p1h5R36KN8HZciSBaTM+dJCxC0xnc0IEfW2i
 8gxM2I3NUaZP0EfaA1LWMA1zLX63CGnIWIJwL6WjfNfD2z71AZ8+KT3MdTSYN/MTsJQ9qqdj
 jKfpTyhUkxDXDCZ4Ty471OHtuvXpwylXqM8PuGq5tMzw0LGkwT/DzVTDzNXu8KRllG5VshZJ
 lY89S8nrKx0/0uuJvHsWBakpzuctwIXW9dLO+k78x2WjLvT6BqeHnIDTDNKdJohrsBeeNAx/
 lOKmtroAWQ+9ryTVX+H7q2Vtj70NSt9wXI+WBLohDAtu7HLyLzfRDqWEL6PzIbdYgXJJAzN
IronPort-HdrOrdr: A9a23:O6nb46yIrUm/AenSI3u+KrPw9r1zdoMgy1knxilNoERuA6ilf1
 jHpoVg6faGskd3ZJhGo6H8BEDgewKmyXcb2+ks1NuZMTUO/VHYSb2KjrGSvwEIeReOldK1vJ
 0IG8MVNDSzNykZsS+T2njGLz9K+ra6GdWT5Ns2uE0CcegFUc1dBkxCe2Cm+wVNNXB77LQCZe
 Kh2vY=
X-Talos-CUID: 9a23:UScNnG0O3a0dp2CtNcelfLxfFcQPWV2a03HrCnTkKGpUcKGKZ1bN0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AUx7T8g+lunaJwvD9LdsNi2WQf8FV/oWFOEQVq7p?=
 =?us-ascii?q?YveiqH3BiKxrEzyviFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.12,165,1728943200"; 
   d="scan'208";a="81200851"
Received: from DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) by
 DKMAIL09.interprise.dk (2001:1448:248:c8::200:79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 19 Nov 2024 12:46:10 +0100
Received: from DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) by
 DKMAIL03.interprise.dk (2001:1448:248:6e::110:72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Nov 2024 12:46:11 +0100
Received: from DKMAIL03.interprise.dk ([fe80::7100:ad8c:7536:e0a]) by
 DKMAIL03.interprise.dk ([fe80::7100:ad8c:7536:e0a%4]) with mapi id
 15.02.1544.011; Tue, 19 Nov 2024 12:46:11 +0100
From: "Paul M. Bendixen" <pbe@trifork.com>
To: Trevor Woerner <twoerner@gmail.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: Re: [meta-rockchip] [PATCH] SOQuartz: add
Thread-Topic: [meta-rockchip] [PATCH] SOQuartz: add
Thread-Index: AQHbN23Nnct2ufJjiky2t/PBq2jjTbK9SKqAgAEo9wA=
Date: Tue, 19 Nov 2024 11:46:11 +0000
Message-ID: <2371750.ElGaqSPkdT@pbe-latitude5501>
References: <3608313a-2d69-435d-807f-3dceb6326ca8@trifork.com>
 <20241118180317.GA17525@localhost>
In-Reply-To: <20241118180317.GA17525@localhost>
Accept-Language: da-DK, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [152.115.32.67]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D7581B7A37B314081E4604B7C4C93BC@trifork.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Nov 2024 11:46:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/823

Hi Trevor=0A=
=0A=
On mandag den 18. november 2024 19.03.17 CET you wrote:=0A=
> Hi Paul,=0A=
> =0A=
> Thanks for your patch!=0A=
> =0A=
> Are you using "git send-email ..." to send your patches? The patch itself=
=0A=
> appears to be base64 encoded. It looks fine in email readers, but using m=
utt=0A=
> to save the patch then try to apply it is running into issues.=0A=
> =0A=
> I'll see if I can figure out the magic to decode (done) in a way that mak=
es=0A=
> "git am ..." happy (not working).=0A=
> =0A=
I'm going to try sending using KMail now, does this help? (should I do anot=
her version?=0A=
> Thanks, Quentin and Ross, for your help :-)=0A=
> =0A=
> Best regards,=0A=
> 	Trevor=0A=
> =0A=
> On Fri 2024-11-15 @ 02:51:08 PM, Paul M. Bendixen wrote:=0A=
> > The SOQuartz is a RK3566 based compute module and parts of Quartz64 ser=
ies=0A=
> > The Model-A base board is one possible board that supports it=0A=
> > =0A=
> > Website:=0A=
> >      https://pine64.org/devices/soquartz/=0A=
> > =0A=
> > Wiki:=0A=
> >      https://wiki.pine64.org/wiki/SOQuartz=0A=
> > =0A=
> > Specs:=0A=
> > - Rockchip RK3566 Quad-core ARM Cortex-A55@1.8GHz=0A=
> > - Mali-G52 2EE Bifrost GPU@800MHz=0A=
> > - Raspberry Pi 4 CM form factor=0A=
> > - RAM Memory Variants: 2GB, 4GB, 8GB LPDDR4.=0A=
> > - optional eMMC from 8GB to 128GB=0A=
> > - optional 128Mb SPI Flash=0A=
> > - 10/100/1000Mbps Ethernet=0A=
> > - WiFi 802.11 b/g/n/ac with Bluetooth 5.0=0A=
> > =0A=
> > Exposed preripherals:=0A=
> > - 1x HDMI=0A=
> > - 2x DSI=0A=
> > - 1x eDP=0A=
> > - 1x LVDS=0A=
> > - 1x CSI 4-line=0A=
> > - 1x Ethernet=0A=
> > - 1x USB 2.0 OTG=0A=
> > - 1x SD=0A=
> > - 1x PCIe 1-line=0A=
> > - 28x GPIO=0A=
> > =0A=
> > Model-A baseboard:=0A=
> > - 1x microSD - bootable=0A=
> > - 1x HDMI Port=0A=
> > - 2x USB A 2.0 Host=0A=
> > - 1x USB C 2.0 Host=0A=
> > - 1x 5 pin USB expansion=0A=
> > - 1x Ethernet w. PoE=0A=
> > - 1x 40 pole Pi2 compatible GPIO=0A=
> > - 1x MiPi-CSI 2 lanes=0A=
> > - 1x MiPi-CSI 4 lanes=0A=
> > - 1x MiPi-DSI 2 lanes=0A=
> > - 1x MiPi-DSI 4 lanes=0A=
> > - 1x PCIe open ended=0A=
> > =0A=
> > Signed-off-by: Paul M. B. Bendixen <pbe@trifork.com>=0A=
> > ---=0A=
> > =0A=
> >   README                                      |  1 +=0A=
> >   conf/machine/include/soquartz.inc           | 15 +++++++++++++++=0A=
> >   conf/machine/soquartz-model-a.conf          | 12 ++++++++++++=0A=
> >   recipes-kernel/linux/linux-yocto_%.bbappend |  1 +=0A=
> >   4 files changed, 29 insertions(+)=0A=
> >   create mode 100644 conf/machine/include/soquartz.inc=0A=
> >   create mode 100644 conf/machine/soquartz-model-a.conf=0A=
> > =0A=
> > diff --git a/README b/README=0A=
> > index 09f8691..85ab2ec 100644=0A=
> > --- a/README=0A=
> > +++ b/README=0A=
> > =0A=
> > @@ -45,6 +45,7 @@ Status of supported boards:=0A=
> >               rock-pi-e=0A=
> >               rock-pi-s=0A=
> >               rock64=0A=
> > =0A=
> > +            soquartz (on model A base board)=0A=
> > =0A=
> >       builds:=0A=
> > =0A=
> >           32-bit:=0A=
> > diff --git a/conf/machine/include/soquartz.inc=0A=
> > b/conf/machine/include/soquartz.inc=0A=
> > new file mode 100644=0A=
> > index 0000000..6714efc=0A=
> > --- /dev/null=0A=
> > +++ b/conf/machine/include/soquartz.inc=0A=
> > @@ -0,0 +1,15 @@=0A=
> > +#Copyright (C) Trifork A/S 2024=0A=
> > +# Released under the MIT license (see COPYING.MIT for the terms)=0A=
> > +=0A=
> > +# Common override for basing a SOQuartz design on=0A=
> > +# https://wiki.pine64.org/wiki/SOQuartz=0A=
> > +=0A=
> > +MACHINEOVERRIDES =3D. "soquartz:"=0A=
> > +=0A=
> > +require conf/machine/include/rk3566.inc=0A=
> > +=0A=
> > +# A machine using this baseboard could use these options or overload t=
hem=0A=
> > +# UBOOT_MACHINE ?=3D "soquartz-cm4-rk3566_defconfig"=0A=
> > +# KERNEL_DEVICETREE ?=3D "rockchip/rk3566-soquartz-cm4.dtb"=0A=
> > +=0A=
> > +MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"=0A=
> > diff --git a/conf/machine/soquartz-model-a.conf=0A=
> > b/conf/machine/soquartz-model-a.conf=0A=
> > new file mode 100644=0A=
> > index 0000000..b8be4ca=0A=
> > --- /dev/null=0A=
> > +++ b/conf/machine/soquartz-model-a.conf=0A=
> > @@ -0,0 +1,12 @@=0A=
> > +#Copyright (C) Trifork A/S 2024=0A=
> > +# Released under the MIT license (see COPYING.MIT for the terms)=0A=
> > +=0A=
> > +#@TYPE: Machine=0A=
> > +#@NAME: SOQuartz on Model A base board=0A=
> > +#@DESCRIPTION: SOQuartz is a series of Compute Module by Pine64, the=
=0A=
> > Model-A baseboard provides standard connectors for the compute module=
=0A=
> > +#https://wiki.pine64.org/wiki/SOQuartz#SOQuartz_Model-A_Baseboard_Feat=
ure=0A=
> > s=0A=
> > +=0A=
> > +require conf/machine/include/soquartz.inc=0A=
> > +=0A=
> > +KERNEL_DEVICETREE =3D "rockchip/rk3566-soquartz-model-a.dtb"=0A=
> > +UBOOT_MACHINE =3D "soquartz-model-a-rk3566_defconfig"=0A=
> > diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend=0A=
> > b/recipes-kernel/linux/linux-yocto_%.bbappend=0A=
> > index 5528bab..56ec9d7 100644=0A=
> > --- a/recipes-kernel/linux/linux-yocto_%.bbappend=0A=
> > +++ b/recipes-kernel/linux/linux-yocto_%.bbappend=0A=
> > @@ -22,6 +22,7 @@ COMPATIBLE_MACHINE:rock-3a =3D "rock-3a"=0A=
> > =0A=
> >   COMPATIBLE_MACHINE:rock-4c-plus =3D "rock-4c-plus"=0A=
> >   COMPATIBLE_MACHINE:rock-5a =3D "rock-5a"=0A=
> >   COMPATIBLE_MACHINE:rock-5b =3D "rock-5b"=0A=
> > =0A=
> > +COMPATIBLE_MACHINE:soquartz =3D "soquartz"=0A=
> > =0A=
> >   SRC_URI:append =3D "=0A=
> > =0A=
> > file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-kmeta;destsuffix=3Dr=
ockchip-k=0A=
> > meta"> =0A=
> >   SRC_URI:append:nanopi-r4s =3D " file://nanopi-r4s.scc"=0A=
=0A=
From 1eba8ca5a6c04301603da3367359444a2f3b6743 Mon Sep 17 00:00:00 2001=0A=
From: "Paul M. B. Bendixen" <pbe@trifork.com>=0A=
Date: Wed, 13 Nov 2024 09:29:46 +0100=0A=
Subject: [meta-rockchip] [PATCH] SOQuartz: add=0A=
=0A=
The SOQuartz is a RK3566 based compute module and parts of Quartz64 series=
=0A=
The Model-A base board is one possible board that supports it=0A=
=0A=
Website:=0A=
	https://pine64.org/devices/soquartz/=0A=
Wiki:=0A=
	https://wiki.pine64.org/wiki/SOQuartz=0A=
=0A=
Specs:=0A=
- Rockchip RK3566 Quad-core ARM Cortex-A55@1.8GHz=0A=
- Mali-G52 2EE Bifrost GPU@800MHz=0A=
- Raspberry Pi 4 CM form factor=0A=
- RAM Memory Variants: 2GB, 4GB, 8GB LPDDR4.=0A=
- optional eMMC from 8GB to 128GB=0A=
- optional 128Mb SPI Flash=0A=
- 10/100/1000Mbps Ethernet=0A=
- WiFi 802.11 b/g/n/ac with Bluetooth 5.0=0A=
=0A=
Exposed preripherals:=0A=
- 1x HDMI=0A=
- 2x DSI=0A=
- 1x eDP=0A=
- 1x LVDS=0A=
- 1x CSI 4-line=0A=
- 1x Ethernet=0A=
- 1x USB 2.0 OTG=0A=
- 1x SD=0A=
- 1x PCIe 1-line=0A=
- 28x GPIO=0A=
=0A=
Model-A baseboard:=0A=
- 1x microSD - bootable=0A=
- 1x HDMI Port=0A=
- 2x USB A 2.0 Host=0A=
- 1x USB C 2.0 Host=0A=
- 1x 5 pin USB expansion=0A=
- 1x Ethernet w. PoE=0A=
- 1x 40 pole Pi2 compatible GPIO=0A=
- 1x MiPi-CSI 2 lanes=0A=
- 1x MiPi-CSI 4 lanes=0A=
- 1x MiPi-DSI 2 lanes=0A=
- 1x MiPi-DSI 4 lanes=0A=
- 1x PCIe open ended=0A=
=0A=
Signed-off-by: Paul M. B. Bendixen <pbe@trifork.com>=0A=
---=0A=
 README                                      |  1 +=0A=
 conf/machine/include/soquartz.inc           | 15 +++++++++++++++=0A=
 conf/machine/soquartz-model-a.conf          | 12 ++++++++++++=0A=
 recipes-kernel/linux/linux-yocto_%.bbappend |  1 +=0A=
 4 files changed, 29 insertions(+)=0A=
 create mode 100644 conf/machine/include/soquartz.inc=0A=
 create mode 100644 conf/machine/soquartz-model-a.conf=0A=
=0A=
diff --git a/README b/README=0A=
index 09f8691..85ab2ec 100644=0A=
--- a/README=0A=
+++ b/README=0A=
@@ -45,6 +45,7 @@ Status of supported boards:=0A=
 			rock-pi-e=0A=
 			rock-pi-s=0A=
 			rock64=0A=
+			soquartz (on model A base board)=0A=
 =0A=
 	builds:=0A=
 		32-bit:=0A=
diff --git a/conf/machine/include/soquartz.inc b/conf/machine/include/soqua=
rtz.inc=0A=
new file mode 100644=0A=
index 0000000..6714efc=0A=
--- /dev/null=0A=
+++ b/conf/machine/include/soquartz.inc=0A=
@@ -0,0 +1,15 @@=0A=
+#Copyright (C) Trifork A/S 2024=0A=
+# Released under the MIT license (see COPYING.MIT for the terms)=0A=
+=0A=
+# Common override for basing a SOQuartz design on=0A=
+# https://wiki.pine64.org/wiki/SOQuartz=0A=
+=0A=
+MACHINEOVERRIDES =3D. "soquartz:"=0A=
+=0A=
+require conf/machine/include/rk3566.inc=0A=
+=0A=
+# A machine using this baseboard could use these options or overload them=
=0A=
+# UBOOT_MACHINE ?=3D "soquartz-cm4-rk3566_defconfig"=0A=
+# KERNEL_DEVICETREE ?=3D "rockchip/rk3566-soquartz-cm4.dtb"=0A=
+=0A=
+MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"=0A=
diff --git a/conf/machine/soquartz-model-a.conf b/conf/machine/soquartz-mod=
el-a.conf=0A=
new file mode 100644=0A=
index 0000000..b8be4ca=0A=
--- /dev/null=0A=
+++ b/conf/machine/soquartz-model-a.conf=0A=
@@ -0,0 +1,12 @@=0A=
+#Copyright (C) Trifork A/S 2024=0A=
+# Released under the MIT license (see COPYING.MIT for the terms)=0A=
+=0A=
+#@TYPE: Machine=0A=
+#@NAME: SOQuartz on Model A base board=0A=
+#@DESCRIPTION: SOQuartz is a series of Compute Module by Pine64, the Model=
-A baseboard provides standard connectors for the compute module=0A=
+#https://wiki.pine64.org/wiki/SOQuartz#SOQuartz_Model-A_Baseboard_Features=
 =0A=
+=0A=
+require conf/machine/include/soquartz.inc=0A=
+=0A=
+KERNEL_DEVICETREE =3D "rockchip/rk3566-soquartz-model-a.dtb"=0A=
+UBOOT_MACHINE =3D "soquartz-model-a-rk3566_defconfig"=0A=
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/l=
inux/linux-yocto_%.bbappend=0A=
index 5528bab..56ec9d7 100644=0A=
--- a/recipes-kernel/linux/linux-yocto_%.bbappend=0A=
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend=0A=
@@ -22,6 +22,7 @@ COMPATIBLE_MACHINE:rock-3a =3D "rock-3a"=0A=
 COMPATIBLE_MACHINE:rock-4c-plus =3D "rock-4c-plus"=0A=
 COMPATIBLE_MACHINE:rock-5a =3D "rock-5a"=0A=
 COMPATIBLE_MACHINE:rock-5b =3D "rock-5b"=0A=
+COMPATIBLE_MACHINE:soquartz =3D "soquartz"=0A=
 =0A=
 SRC_URI:append =3D " file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-km=
eta;destsuffix=3Drockchip-kmeta"=0A=
 SRC_URI:append:nanopi-r4s =3D " file://nanopi-r4s.scc"=0A=
-- =0A=
2.43.0=0A=
=0A=

