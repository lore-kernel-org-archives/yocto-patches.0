Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD666C7115C
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 02:02:03 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.388.1750384916576647511
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Jun 2025 19:01:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EPE3B6t0;
 spf=pass (domain: konsulko.com, ip: 209.85.208.53, mailfrom: tim.orling@konsulko.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso2154771a12.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Jun 2025 19:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1750384914; x=1750989714; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rz01E5l8e3av3PGhwT94qeJHaFEQbMFtzjbJdCCk2xg=;
        b=EPE3B6t0LnO8LyaT5UExe8n0BXPto2hA0EyM8iYJ5nwAo2CkwVpV8TgZpu0Jmmh57j
         j9B8JPPqCggsfzWBYkAHhIL3CCj1SzO6btm8DfUW9i8HSoo5PbceKM07yx/XpP0BcAj/
         Z1FDfcO7UPByj5qXzz/Idria4uXbfnh6c4y3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750384914; x=1750989714;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz01E5l8e3av3PGhwT94qeJHaFEQbMFtzjbJdCCk2xg=;
        b=OwIGGIwZeYB2KzI5oFT1Ipaycj4ECWETkk0XYXBXBN0/WV/TJm2BXbSOewQlS6bUUq
         0FL7yXIu2SQQ09XM9gHoMavS6sDQApZSHn6DTSJzhJ1zHTx9Hqno6bKKnZcJQGavPFIL
         PVGyTMk7IG8BnG9syiXQqN3ZSarCOmFBonAkrpBRww9IXxqCCK7gq15XIT40oZO8ddbB
         9vf1sujZ2uy8jrbrD5QXbiL3lLPDfhrJHuq2PBAHjoAtw1HuTJIQZ4r4cdPjzaR8w9SW
         Q/duOd6Cux5czmSfRFgE47DbC7O846f5MEzypvgXt2WexFKnOKd0G9f1q0FRxLFIywt5
         wO8g==
X-Gm-Message-State: AOJu0Yx52JvRu3law4uo3y0SUiZVI3/WB3pbuBOopT82Cvhn6O4Ikyzh
	Vb8iyp67l4cPB4B7crDdOI6VeCrPex1eiP2C9QlYqGRVKOm9cJyLceBUCyCF2EVOLB9sfPLjJAa
	7awahi+qArs/lKplEpgzRa2zhkf2Cg2olAznt76DGq58HDp5wm/6yz3E=
X-Gm-Gg: ASbGncvlduvGp/6Q/n62b67wJ1z5zWiCFOufKmfHIM9X8hDkjsX7MVMPPsuXH1lKTGT
	vteK4DO5sypjbWuZnRYh3TBfca9nR6FQFPrs8jQP3OgrVaXM3t0wUO21gwJ5A/Xsm03KS3cNefu
	/N9y58wuGkOTZtucIQvuGK/uc/J/JKglH4y696X0+DhtI=
X-Google-Smtp-Source: AGHT+IG0Tf0JdJqthOVdgtY5zXqXYvJfjp1QbnKJuGLugg6RzlwUB5GE27M4iudM7FOMXMBg8KknZBJ8GHsb4lqOKu4=
X-Received: by 2002:a17:907:3d0e:b0:adb:4203:cc9c with SMTP id
 a640c23a62f3a-ae057c13810mr85655266b.50.1750384913805; Thu, 19 Jun 2025
 19:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1748486276.git.tim.orling@konsulko.com>
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
From: Tim Orling <tim.orling@konsulko.com>
Date: Thu, 19 Jun 2025 19:01:42 -0700
X-Gm-Features: Ac12FXyy4QNJTCbKT1uPrsFKpU9M2iJ-gYCN4J074QOKIXzOX0WgrNuR9kbHX8s
Message-ID: <CAOyo-84mkvgiZ02fyZw=DTpB5pdNp5-tdiHJuu=p+Ar0dpDMmA@mail.gmail.com>
Subject: Re: [PATCH 00/11] scarthgap/u-boot: upgrade to 2025.04
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000002044c0637f73feb"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 02:02:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1665

--00000000000002044c0637f73feb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I haven't had any feedback at all (positive or negative) on this series.
But it boots for me, so I am merging it.

On Wed, May 28, 2025 at 7:41=E2=80=AFPM <tim.orling@konsulko.com> wrote:

> From: Tim Orling <tim.orling@konsulko.com>
>
> Apply selected patches from "master" on top of existing 2024.04
>
> NOTE: There are features in 2025.07-rcX that are desired, but we will
> wait until 2025.07 upgrade lands in "master".
>
> The following changes since commit
> 66ceeebd047d7fdfc8668b300319a76da8ae257d:
>
>   u-boot: update to final v2024.04 release (2024-04-05 07:38:57 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/moto-timo/meta-lts-mixins scarthgap/u-boot-2025.04
>
> https://github.com/moto-timo/meta-lts-mixins/tree/scarthgap/u-boot-2025.0=
4
>
> Fabio Estevam (5):
>   u-boot: upgrade 2024.04 -> 2024.07
>   u-boot: upgrade 2024.07 -> 2024.10
>   u-boot: Update Upstream-Status
>   u-boot: upgrade 2024.10 -> 2025.01
>   u-boot: upgrade 2025.01 -> 2025.04
>
> Florian Amstutz (1):
>   u-boot: Fix potential index error issues in do_deploy with multiple
>     u-boot configurations
>
> Maik Otto (1):
>   u-boot: Set CVE_PRODUCT
>
> Markus Volk (1):
>   u-boot: Add patch to use SWIG_AppendOutput
>
> Otavio Salvador (1):
>   u-boot: Ensure we use BFD as linker even if using GCC for it
>
> Ryan Eatmon (1):
>   u-boot.inc: Refactor do_* steps into functions that can be overridden
>
> Tim Orling (1):
>   u-boot-tools.inc: Fix variable assignment whitespace
>
>  recipes-bsp/u-boot/u-boot-common.inc          |   4 +-
>  recipes-bsp/u-boot/u-boot-configure.inc       |  36 ++-
>  recipes-bsp/u-boot/u-boot-tools.inc           |   2 +-
>  ...ols_2024.04.bb =3D> u-boot-tools_2025.04.bb} |   0
>  recipes-bsp/u-boot/u-boot.inc                 | 287 ++++++++++++------
>  recipes-bsp/u-boot/u-boot_2024.04.bb          |   5 -
>  recipes-bsp/u-boot/u-boot_2025.04.bb          |   4 +
>  7 files changed, 220 insertions(+), 118 deletions(-)
>  rename recipes-bsp/u-boot/{u-boot-tools_2024.04.bb =3D>
> u-boot-tools_2025.04.bb} (100%)
>  delete mode 100644 recipes-bsp/u-boot/u-boot_2024.04.bb
>  create mode 100644 recipes-bsp/u-boot/u-boot_2025.04.bb
>
> --
> 2.43.0
>
>

--00000000000002044c0637f73feb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I haven&#39;t had any feedback at all (positive or negativ=
e) on this series. But it boots for me, so I am merging it.</div><br><div c=
lass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_=
attr">On Wed, May 28, 2025 at 7:41=E2=80=AFPM &lt;<a href=3D"mailto:tim.orl=
ing@konsulko.com">tim.orling@konsulko.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">From: Tim Orling &lt;<a href=3D"ma=
ilto:tim.orling@konsulko.com" target=3D"_blank">tim.orling@konsulko.com</a>=
&gt;<br>
<br>
Apply selected patches from &quot;master&quot; on top of existing 2024.04<b=
r>
<br>
NOTE: There are features in 2025.07-rcX that are desired, but we will<br>
wait until 2025.07 upgrade lands in &quot;master&quot;.<br>
<br>
The following changes since commit 66ceeebd047d7fdfc8668b300319a76da8ae257d=
:<br>
<br>
=C2=A0 u-boot: update to final v2024.04 release (2024-04-05 07:38:57 -0700)=
<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 <a href=3D"https://github.com/moto-timo/meta-lts-mixins" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/moto-timo/meta-lts-mixins</a> =
scarthgap/u-boot-2025.04<br>
=C2=A0 <a href=3D"https://github.com/moto-timo/meta-lts-mixins/tree/scarthg=
ap/u-boot-2025.04" rel=3D"noreferrer" target=3D"_blank">https://github.com/=
moto-timo/meta-lts-mixins/tree/scarthgap/u-boot-2025.04</a><br>
<br>
Fabio Estevam (5):<br>
=C2=A0 u-boot: upgrade 2024.04 -&gt; 2024.07<br>
=C2=A0 u-boot: upgrade 2024.07 -&gt; 2024.10<br>
=C2=A0 u-boot: Update Upstream-Status<br>
=C2=A0 u-boot: upgrade 2024.10 -&gt; 2025.01<br>
=C2=A0 u-boot: upgrade 2025.01 -&gt; 2025.04<br>
<br>
Florian Amstutz (1):<br>
=C2=A0 u-boot: Fix potential index error issues in do_deploy with multiple<=
br>
=C2=A0 =C2=A0 u-boot configurations<br>
<br>
Maik Otto (1):<br>
=C2=A0 u-boot: Set CVE_PRODUCT<br>
<br>
Markus Volk (1):<br>
=C2=A0 u-boot: Add patch to use SWIG_AppendOutput<br>
<br>
Otavio Salvador (1):<br>
=C2=A0 u-boot: Ensure we use BFD as linker even if using GCC for it<br>
<br>
Ryan Eatmon (1):<br>
=C2=A0 u-boot.inc: Refactor do_* steps into functions that can be overridde=
n<br>
<br>
Tim Orling (1):<br>
=C2=A0 u-boot-tools.inc: Fix variable assignment whitespace<br>
<br>
=C2=A0recipes-bsp/u-boot/u-boot-common.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0recipes-bsp/u-boot/u-boot-configure.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 36 ++-<br>
=C2=A0recipes-bsp/u-boot/u-boot-tools.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0...<a href=3D"http://ols_2024.04.bb" rel=3D"noreferrer" target=3D"_bl=
ank">ols_2024.04.bb</a> =3D&gt; <a href=3D"http://u-boot-tools_2025.04.bb" =
rel=3D"noreferrer" target=3D"_blank">u-boot-tools_2025.04.bb</a>} |=C2=A0 =
=C2=A00<br>
=C2=A0recipes-bsp/u-boot/u-boot.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 287 ++++++++++++------<br>
=C2=A0recipes-bsp/u-boot/<a href=3D"http://u-boot_2024.04.bb" rel=3D"norefe=
rrer" target=3D"_blank">u-boot_2024.04.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A05 -<br>
=C2=A0recipes-bsp/u-boot/<a href=3D"http://u-boot_2025.04.bb" rel=3D"norefe=
rrer" target=3D"_blank">u-boot_2025.04.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A04 +<br>
=C2=A07 files changed, 220 insertions(+), 118 deletions(-)<br>
=C2=A0rename recipes-bsp/u-boot/{<a href=3D"http://u-boot-tools_2024.04.bb"=
 rel=3D"noreferrer" target=3D"_blank">u-boot-tools_2024.04.bb</a> =3D&gt; <=
a href=3D"http://u-boot-tools_2025.04.bb" rel=3D"noreferrer" target=3D"_bla=
nk">u-boot-tools_2025.04.bb</a>} (100%)<br>
=C2=A0delete mode 100644 recipes-bsp/u-boot/<a href=3D"http://u-boot_2024.0=
4.bb" rel=3D"noreferrer" target=3D"_blank">u-boot_2024.04.bb</a><br>
=C2=A0create mode 100644 recipes-bsp/u-boot/<a href=3D"http://u-boot_2025.0=
4.bb" rel=3D"noreferrer" target=3D"_blank">u-boot_2025.04.bb</a><br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--00000000000002044c0637f73feb--

