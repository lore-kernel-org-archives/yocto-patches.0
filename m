Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C061E64004
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 18:43:50 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web10.6049.1732214625952641378
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 21 Nov 2024 10:43:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OlUaA6yI;
 spf=pass (domain: gmail.com, ip: 209.85.167.50, mailfrom: twoerner@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53da22c5863so1441482e87.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 21 Nov 2024 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732214624; x=1732819424; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FEyygFJIWYgI7lzYxgySonBzVLQo18j/x0KWpCnpVbk=;
        b=OlUaA6yIMNak/7WdZ/9rM/KNJ0jKI2hx912D2lMLY3N1KLnonMIPo1hEhGzQCAyKyC
         +Po8qcc2WD3Ex2ASyIr3yauwm4Y/rbW+z0f38yRKL1Yd3RwT3z5LvS75QUGnWMAcTXNI
         3B27xfZYhecOwzO15YCdsD06Teiyd1m+QRJL/a15P9xF7C6is5igH6Ea+IcTCuo8Xxbg
         NwmCK4zto96xmWRE+RjY7WTuPUPDclP9T9aAiGLltTo507zMe7HgAn3x1EDO04KLIixc
         LvFABZ7Cdptp4xKaNdOL+uhZAR9Mi8B4oM0Q0xzhfFykTG5NMyKowyz2oLTTV7Z9fCOD
         fiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214624; x=1732819424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEyygFJIWYgI7lzYxgySonBzVLQo18j/x0KWpCnpVbk=;
        b=k2Pe2sVvTin15hDOPP0IYV22X2B2m/tH+fEZbB5u73AvH5DZE+x3pTmR38ttaUTb5m
         z358ZP86IDD3CC8rt7Mq6EGMjIPWHQGc+Llk5a8Y7zGgddrX5KqtiBnwh1QXsbdtJ0CV
         SF6ki9etB86ze/8qukpvFQ4AoLv7C3ZQRdVwkTycKHo9W10YcyNzxTdYaGlD/n3YOLuP
         qgVx8mBE9j4uZbrrgBBmZlIRI5cX0UJrKbsUmuSo5Mweiz/80p5sNHUSJG7IpFlsVKrf
         2vwDjpoOLCx+lVBsWj9HCyGSDHzs/obOpeIOO4eCGcG/U0AWSiwPMB7P7TFHC16gUzK8
         Rxvg==
X-Gm-Message-State: AOJu0YwghkJ2wUF6iYXWsBpVHePUv86ci3L1ReFJpZeo169LmmWzIAaD
	XTiVl83RLqBkaIGmHKGLx0qhzi4/ibKHynE20Pt8r0eSwtZwCAgb7ycG7lz66japXn0d0PhnUlb
	TDdGMYavUVs7yQF70LsWGSpChuzw=
X-Gm-Gg: ASbGncsJIM6M5PVSK7wh1prMX6V6V+Yq5u2Rlq+scBdxPfJGUkFPOs+VCyPg+7ALL2h
	Dq2ppoNHEW7mLa8i7ZN6CCG7ZtoBRHHGj
X-Google-Smtp-Source: AGHT+IFTlnyHXDvT5rJKEhmg6LtbScHrp52Gom20KpqAwzy181lWVN9xk3YSVkAk89gMDhO/NRDnkyv1RZ+6pwBigtU=
X-Received: by 2002:a05:6512:310a:b0:53d:ab1f:4c39 with SMTP id
 2adb3069b0e04-53dc136aa2fmr3120585e87.41.1732214623697; Thu, 21 Nov 2024
 10:43:43 -0800 (PST)
MIME-Version: 1.0
References: <3608313a-2d69-435d-807f-3dceb6326ca8@trifork.com>
In-Reply-To: <3608313a-2d69-435d-807f-3dceb6326ca8@trifork.com>
From: Trevor Woerner <twoerner@gmail.com>
Date: Thu, 21 Nov 2024 13:43:31 -0500
Message-ID: <CAHUNapR=u9jst6wFiwmFyGDdyonu=7CLCLz2Nm5SrCk09srrzw@mail.gmail.com>
Subject: Re: [meta-rockchip] [PATCH] SOQuartz: add
To: "Paul M. Bendixen" <pbe@trifork.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="000000000000520aca062770a588"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 21 Nov 2024 18:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/832

--000000000000520aca062770a588
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 9:51=E2=80=AFAM Paul M. Bendixen <pbe@trifork.com> =
wrote:

> The SOQuartz is a RK3566 based compute module and parts of Quartz64 serie=
s
> The Model-A base board is one possible board that supports it
>
> Website:
>      https://pine64.org/devices/soquartz/
> Wiki:
>      https://wiki.pine64.org/wiki/SOQuartz
>
> Specs:
> - Rockchip RK3566 Quad-core ARM Cortex-A55@1.8GHz
> - Mali-G52 2EE Bifrost GPU@800MHz
> - Raspberry Pi 4 CM form factor
> - RAM Memory Variants: 2GB, 4GB, 8GB LPDDR4.
> - optional eMMC from 8GB to 128GB
> - optional 128Mb SPI Flash
> - 10/100/1000Mbps Ethernet
> - WiFi 802.11 b/g/n/ac with Bluetooth 5.0
>
> Exposed preripherals:
> - 1x HDMI
> - 2x DSI
> - 1x eDP
> - 1x LVDS
> - 1x CSI 4-line
> - 1x Ethernet
> - 1x USB 2.0 OTG
> - 1x SD
> - 1x PCIe 1-line
> - 28x GPIO
>
> Model-A baseboard:
> - 1x microSD - bootable
> - 1x HDMI Port
> - 2x USB A 2.0 Host
> - 1x USB C 2.0 Host
> - 1x 5 pin USB expansion
> - 1x Ethernet w. PoE
> - 1x 40 pole Pi2 compatible GPIO
> - 1x MiPi-CSI 2 lanes
> - 1x MiPi-CSI 4 lanes
> - 1x MiPi-DSI 2 lanes
> - 1x MiPi-DSI 4 lanes
> - 1x PCIe open ended
>
> Signed-off-by: Paul M. B. Bendixen <pbe@trifork.com>
> ---
>   README                                      |  1 +
>   conf/machine/include/soquartz.inc           | 15 +++++++++++++++
>   conf/machine/soquartz-model-a.conf          | 12 ++++++++++++
>   recipes-kernel/linux/linux-yocto_%.bbappend |  1 +
>   4 files changed, 29 insertions(+)
>   create mode 100644 conf/machine/include/soquartz.inc
>   create mode 100644 conf/machine/soquartz-model-a.conf
>

Added to meta-rockchip, master branch; thanks!

--000000000000520aca062770a588
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 15, 2024 at 9:51=E2=80=AF=
AM Paul M. Bendixen &lt;<a href=3D"mailto:pbe@trifork.com">pbe@trifork.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
he SOQuartz is a RK3566 based compute module and parts of Quartz64 series<b=
r>
The Model-A base board is one possible board that supports it<br>
<br>
Website:<br>
=C2=A0=C2=A0=C2=A0=C2=A0 <a href=3D"https://pine64.org/devices/soquartz/" r=
el=3D"noreferrer" target=3D"_blank">https://pine64.org/devices/soquartz/</a=
><br>
Wiki:<br>
=C2=A0=C2=A0=C2=A0=C2=A0 <a href=3D"https://wiki.pine64.org/wiki/SOQuartz" =
rel=3D"noreferrer" target=3D"_blank">https://wiki.pine64.org/wiki/SOQuartz<=
/a><br>
<br>
Specs:<br>
- Rockchip RK3566 Quad-core ARM Cortex-A55@1.8GHz<br>
- Mali-G52 2EE Bifrost GPU@800MHz<br>
- Raspberry Pi 4 CM form factor<br>
- RAM Memory Variants: 2GB, 4GB, 8GB LPDDR4.<br>
- optional eMMC from 8GB to 128GB<br>
- optional 128Mb SPI Flash<br>
- 10/100/1000Mbps Ethernet<br>
- WiFi 802.11 b/g/n/ac with Bluetooth 5.0<br>
<br>
Exposed preripherals:<br>
- 1x HDMI<br>
- 2x DSI<br>
- 1x eDP<br>
- 1x LVDS<br>
- 1x CSI 4-line<br>
- 1x Ethernet<br>
- 1x USB 2.0 OTG<br>
- 1x SD<br>
- 1x PCIe 1-line<br>
- 28x GPIO<br>
<br>
Model-A baseboard:<br>
- 1x microSD - bootable<br>
- 1x HDMI Port<br>
- 2x USB A 2.0 Host<br>
- 1x USB C 2.0 Host<br>
- 1x 5 pin USB expansion<br>
- 1x Ethernet w. PoE<br>
- 1x 40 pole Pi2 compatible GPIO<br>
- 1x MiPi-CSI 2 lanes<br>
- 1x MiPi-CSI 4 lanes<br>
- 1x MiPi-DSI 2 lanes<br>
- 1x MiPi-DSI 4 lanes<br>
- 1x PCIe open ended<br>
<br>
Signed-off-by: Paul M. B. Bendixen &lt;<a href=3D"mailto:pbe@trifork.com" t=
arget=3D"_blank">pbe@trifork.com</a>&gt;<br>
---<br>
=C2=A0=C2=A0README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +<br>
=C2=A0=C2=A0conf/machine/include/soquartz.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +++++++++++++++<br>
=C2=A0=C2=A0conf/machine/soquartz-model-a.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++++++++<br>
=C2=A0=C2=A0recipes-kernel/linux/linux-yocto_%.bbappend |=C2=A0 1 +<br>
=C2=A0=C2=A04 files changed, 29 insertions(+)<br>
=C2=A0=C2=A0create mode 100644 conf/machine/include/soquartz.inc<br>
=C2=A0=C2=A0create mode 100644 conf/machine/soquartz-model-a.conf<br></bloc=
kquote><div><br></div>Added to meta-rockchip, master branch; thanks!<br></d=
iv></div>

--000000000000520aca062770a588--

