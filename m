Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3C7CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 11:56:11 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.web10.17915.1755690963042110265
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 04:56:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BGwtQu8c;
 spf=pass (domain: gmail.com, ip: 209.85.217.49, mailfrom: quaresma.jose@gmail.com)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-50f8bf5c518so4540974137.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 04:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755690962; x=1756295762; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F5E43gwlrYXz6gGcpiw3prql8+D0wf/VoA9EPWV0uMU=;
        b=BGwtQu8crUcaSkapaYWTL2WUgqkRGpfQ2g0X4B+VzGoD6vfV7WYicTO26LAeMVqfhB
         ynl6QazhKSbZ1Ca02l3Wi6RRA2rJErsENo0KzK3YWmjFGeiaENPNOwW796Z+KzQ5cjTt
         mywDIZN7iszTxDbGjeCca/K/h+tFsNG7G5d8NCOzw2j1fLhM1KIlB18hhcK2SGIaGDC7
         LExzz/w379EnuZxbsncnLwXGjvvJKyCaLajLBsyUmL6PT5/ygPfdBcxrrLZ68ZNph/is
         KrldBxZTx4B/yaSQhtNgaXOnOhGWvKCt+Rnd279vIeFfCzJf7r7V6xV+/b4oSOhxswk4
         w4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690962; x=1756295762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5E43gwlrYXz6gGcpiw3prql8+D0wf/VoA9EPWV0uMU=;
        b=Nz2lRl+113zQl8VmnjLnonjTLYidW5fdhN078gFcoPVItFwEBeJug21MYqHTyOyLw8
         7dWJK+eMBhM4aSpJyRS3InVQTRvxEjhGSFueh74Ews3mphfpa2RDHBTe529UWpx1h0cw
         TVPxhcL2IICzXgliQXARxZS59CrrNBLufVTJbEIhA0n0RppvZtrlz3cYDQ4lEp11b8Jy
         c9TVF/Z1zFYZE806SmqlnOiXuX/ft8jG9EdFYie+MQfaMDeItVwc75E3cRyE6RWuk/cO
         APHARIqucA0An7ol84kGe+RaXFCaqbMWW104TI9psYtb/anyOIdpZPi60le7fo6vYFrd
         N7Fw==
X-Gm-Message-State: AOJu0Yx8EIWDYt/xP6ac0kQxJxw2o0M0+TNkeEKPT/9DJi10q3l5+L4S
	MN7eIbF4axZjKogvkGXK1fojxSA/Lo+MxdcVb47JaplJYPfyKVLjeQ1rr+p1DUYOVkE+CuqAsC4
	ebEFBuQGQK7vS38xpI91Z2N1umQfid//t+LiurFs=
X-Gm-Gg: ASbGncsI1i0N7Mln3D+vKe+gf6RgJPf7rVx4KlmREKxDJ4wxV4avWsuRJYcrpari61h
	6sTbSBA9GlHXfe4n0QbmF6wa55vzbjwusHmfOMNph+e92eUGpeajGpkkQIAfbDgRee0S46TYUJ4
	Hbllx5OXpNSM475jFwvEW5X3TGUw+5I+fXDTiRr23aEeuoV+Q0y0pc705Kk5Jq5f95o2m6+DK9r
	rQp22Jj
X-Google-Smtp-Source: AGHT+IEsQ+Kla3V4f5e7Ibk92x2rJi8LP4fyaeyXA5Ck1BqAkal1qDFg9xEmPB00ymh6eoKQi13ubXoBLt2qCaDB3Qs=
X-Received: by 2002:a05:6102:5716:b0:4fd:53e0:b522 with SMTP id
 ada2fe7eead31-51a50c8d2f6mr661692137.19.1755690961834; Wed, 20 Aug 2025
 04:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250818225046.55311-1-peter.marko@siemens.com>
 <CANPvuRkYWZZ3YnegmTxCYLM65G+wvR7UvsRE0DeZ2enWzXSwcg@mail.gmail.com> <AS1PR10MB56973181DD547A7B6EB042B9FD33A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS1PR10MB56973181DD547A7B6EB042B9FD33A@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 20 Aug 2025 12:55:51 +0100
X-Gm-Features: Ac12FXw7wjY79Kdk2ZXXT3Fz4kLsbko972C7-cyLJTg-gsCXFI43SdryFTzjrzM
Message-ID: <CANPvuRnEUSaZOE1koCFY6fB9L=Mk+m+VCVN=y80RjkbPcGDL0Q@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH]
 conf/layer: switch to golang 1.25
To: yocto-patches@lists.yoctoproject.org
Cc: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="0000000000001d9515063ccaa81b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 11:56:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2067

--0000000000001d9515063ccaa81b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It will be good to pick it all since it is a good example to test and it
should be aligned with the rest of the pieces.
I updated the go-helloworld with what was pending from oe-core.

Thanks for the reminder.

Jose

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (quarta, 20/08/2025 =C3=A0(s)
12:41):

> Thanks Jose,
>
> I=E2=80=99m wondering if we should also pick all commits for go-helloworl=
d recipe
> or if it is irrelevant.
>
>
>
> Peter
>
>
>

--0000000000001d9515063ccaa81b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>It will be good to pick=C2=A0it all=C2=A0since it is =
a good example to test=C2=A0and it should be aligned with the rest of the p=
ieces.<br>I updated the=C2=A0<span style=3D"font-family:Arial,sans-serif;fo=
nt-size:13.3333px">go-helloworld</span>=C2=A0with what was pending from oe-=
core.</div><div><br></div><div>Thanks=C2=A0for the reminder.<br><br>Jose</d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">Peter Marko via <a href=3D"http://lists.yoctoproject.org=
">lists.yoctoproject.org</a> &lt;peter.marko=3D<a href=3D"mailto:siemens.co=
m@lists.yoctoproject.org">siemens.com@lists.yoctoproject.org</a>&gt; escrev=
eu (quarta, 20/08/2025 =C3=A0(s) 12:41):<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div class=3D"msg3314563860218317801">





<div lang=3D"EN-US" style=3D"overflow-wrap: break-word;">
<div class=3D"m_3314563860218317801WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif">Thanks Jose,<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif">I=E2=80=99m wondering if we should also pick all commits for go-hel=
loworld recipe or if it is irrelevant.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif">Peter<u></u><u></u></span></p>
<p class=3D"MsoNormal"><br></p></div></div></div></blockquote></div></div>

--0000000000001d9515063ccaa81b--

