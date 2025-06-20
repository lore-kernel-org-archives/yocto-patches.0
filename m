Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB937C7115A
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 02:11:33 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.558.1750385490737132416
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Jun 2025 19:11:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kDEaV4qR;
 spf=pass (domain: konsulko.com, ip: 209.85.218.41, mailfrom: tim.orling@konsulko.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae04ce9153aso161663366b.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Jun 2025 19:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1750385489; x=1750990289; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vG/uooJCsmmxRC3lFjQYkCl/7IW0276g/ZfuOioGHF0=;
        b=kDEaV4qRns0hgAApwAj/Xp6oFDcQRSt7niVhkyrA3u3BOqxm2nu/xAIlD2AGsPCWE5
         kBLmbWhwXSU7/jnEWdvB46N2UgaUC7Yy2SjrciSHuDsMPY0dcMCWJqmbZZG8DUNiZ8+k
         7mxAvV3IL5rNis9q/e5Rnr6PCYHltdibEcjQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750385489; x=1750990289;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vG/uooJCsmmxRC3lFjQYkCl/7IW0276g/ZfuOioGHF0=;
        b=O8CI9WYym7vBm3ZZdlxzCGKDyQI7NlLJ7ferCGN/ByMhIWe66ySP71GaqsT5zwT1M2
         LZr33DeXeOskWwSMjx37EKLPcf64Mo7c2xuc+ns3QRxy7O1YmjRxIcis08L57Lv457eK
         9I1Y5ZDW6nwVn/zgRS9kHmyA8liSM5l1qCgWoapTumKkoIA6NcJEVmMdy7SjgECaqSO3
         F4cJk/QmCi3wa86eO6+c9PoAxQqBraJtKEixTWa68FMmknb72v1LZOC7ru6sn9YsVdaX
         lzD09ms4C8DeVoq6k6E6XCq2Fs4GIJEM2vYbYRSnAYeBl5ha9DYhpaKdOHRVnp1fy89J
         Z+pA==
X-Gm-Message-State: AOJu0YzwSPVwntF8t/3DDe7BXqR9ZQKbTayb8lXj42XLnppMIQaJwysr
	LC/+BGUHbK5yVyeEC91t4tWpAJQBimLs7mqCpL3SnJZfMK+6cezcnETCAdYVtkKur84i7N9v5Bv
	VejX6yAlIt1J5GlyLeyUhQL65nbqvcHNO8d1F6rtnyfzNL90oA9DpmFU=
X-Gm-Gg: ASbGncuQPGrJHyyeKyrvBKqbpo6KJy6WylIzsSVDG/wjNC4JURPQmKkSiS3w8/VvRPb
	I/jPwyv91fWHCLmsmAtWoGlnN6y0ykeiyXPemIrwJbPsH2VDNHT7QzfigB6cJ344neCz+nhP4Ue
	61HKbVIbn3RTJW4T7bENXZNNLHHThr0rpyHn0hqHCrkGM=
X-Google-Smtp-Source: AGHT+IEBQe95vnTpnSPtoHeZmW42ADKeoSOL9cWooZa7PtDKIdOjzy2xoZqkXipdWXryoATUbIUM2ZJMVEH3WfJbY2o=
X-Received: by 2002:a17:907:7f8c:b0:adf:f05f:6d89 with SMTP id
 a640c23a62f3a-ae05affeda7mr47701766b.23.1750385487348; Thu, 19 Jun 2025
 19:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1748486276.git.tim.orling@konsulko.com> <CAOyo-84mkvgiZ02fyZw=DTpB5pdNp5-tdiHJuu=p+Ar0dpDMmA@mail.gmail.com>
In-Reply-To: <CAOyo-84mkvgiZ02fyZw=DTpB5pdNp5-tdiHJuu=p+Ar0dpDMmA@mail.gmail.com>
From: Tim Orling <tim.orling@konsulko.com>
Date: Thu, 19 Jun 2025 19:11:16 -0700
X-Gm-Features: Ac12FXxEQ9eQAFzEiS-xmiBl-nYQsFF0RALS-mSfIiohNfOfTS2IROS5z1I5HKA
Message-ID: <CAOyo-86DaFQjAB9cRK0Ghx36YR-+LX3qP+APfmx_3t204Eni4Q@mail.gmail.com>
Subject: Re: [PATCH 00/11] scarthgap/u-boot: upgrade to 2025.04
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000319b1a0637f761ed"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 02:11:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1666

--000000000000319b1a0637f761ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged.

On Thu, Jun 19, 2025 at 7:01=E2=80=AFPM Tim Orling <tim.orling@konsulko.com=
> wrote:

> I haven't had any feedback at all (positive or negative) on this series.
> But it boots for me, so I am merging it.
>
> On Wed, May 28, 2025 at 7:41=E2=80=AFPM <tim.orling@konsulko.com> wrote:
>
>> From: Tim Orling <tim.orling@konsulko.com>
>>
>> Apply selected patches from "master" on top of existing 2024.04
>>
>> NOTE: There are features in 2025.07-rcX that are desired, but we will
>> wait until 2025.07 upgrade lands in "master".
>>
>> The following changes since commit
>> 66ceeebd047d7fdfc8668b300319a76da8ae257d:
>>
>>   u-boot: update to final v2024.04 release (2024-04-05 07:38:57 -0700)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/moto-timo/meta-lts-mixins scarthgap/u-boot-2025.04
>>
>> https://github.com/moto-timo/meta-lts-mixins/tree/scarthgap/u-boot-2025.=
04
>>
>> Fabio Estevam (5):
>>   u-boot: upgrade 2024.04 -> 2024.07
>>   u-boot: upgrade 2024.07 -> 2024.10
>>   u-boot: Update Upstream-Status
>>   u-boot: upgrade 2024.10 -> 2025.01
>>   u-boot: upgrade 2025.01 -> 2025.04
>>
>> Florian Amstutz (1):
>>   u-boot: Fix potential index error issues in do_deploy with multiple
>>     u-boot configurations
>>
>> Maik Otto (1):
>>   u-boot: Set CVE_PRODUCT
>>
>> Markus Volk (1):
>>   u-boot: Add patch to use SWIG_AppendOutput
>>
>> Otavio Salvador (1):
>>   u-boot: Ensure we use BFD as linker even if using GCC for it
>>
>> Ryan Eatmon (1):
>>   u-boot.inc: Refactor do_* steps into functions that can be overridden
>>
>> Tim Orling (1):
>>   u-boot-tools.inc: Fix variable assignment whitespace
>>
>>  recipes-bsp/u-boot/u-boot-common.inc          |   4 +-
>>  recipes-bsp/u-boot/u-boot-configure.inc       |  36 ++-
>>  recipes-bsp/u-boot/u-boot-tools.inc           |   2 +-
>>  ...ols_2024.04.bb =3D> u-boot-tools_2025.04.bb} |   0
>>  recipes-bsp/u-boot/u-boot.inc                 | 287 ++++++++++++------
>>  recipes-bsp/u-boot/u-boot_2024.04.bb          |   5 -
>>  recipes-bsp/u-boot/u-boot_2025.04.bb          |   4 +
>>  7 files changed, 220 insertions(+), 118 deletions(-)
>>  rename recipes-bsp/u-boot/{u-boot-tools_2024.04.bb =3D>
>> u-boot-tools_2025.04.bb} (100%)
>>  delete mode 100644 recipes-bsp/u-boot/u-boot_2024.04.bb
>>  create mode 100644 recipes-bsp/u-boot/u-boot_2025.04.bb
>>
>> --
>> 2.43.0
>>
>>

--000000000000319b1a0637f761ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged.</div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 19, 2025 at 7:01=
=E2=80=AFPM Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko.com">tim.o=
rling@konsulko.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div dir=3D"ltr">I haven&#39;t had any feedback at all (p=
ositive or negative) on this series. But it boots for me, so I am merging i=
t.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, May 28, 2025 at 7:41=E2=80=AFPM &lt;<a href=3D"mailto:tim.orling@=
konsulko.com" target=3D"_blank">tim.orling@konsulko.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">From: Tim Orling &lt=
;<a href=3D"mailto:tim.orling@konsulko.com" target=3D"_blank">tim.orling@ko=
nsulko.com</a>&gt;<br>
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
</blockquote></div>

--000000000000319b1a0637f761ed--

