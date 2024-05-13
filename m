Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31626C25B10
	for <webhook@archiver.kernel.org>; Mon, 13 May 2024 10:58:09 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.57430.1715597882567199017
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 May 2024 03:58:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=JY9XBEIA;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.44, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a599eedc8eeso1014929266b.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 03:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715597881; x=1716202681; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hzwW8sTQB+qSV6nWhykP6k2hQs/p1Mi5fY+70UwLZpM=;
        b=JY9XBEIAZwbnPGMhJWRiR8FqM0JiYUPphRn9PXziAVtdi2L0af5CQrjqig1sZZX+tB
         3PqW6Cg7Y1jtyTAALGD1UXsNAOHaneRRpql4KitvVOAU3xo+VOaDSIm+RiaUOX1lxSkL
         5v0MIPh/a8nPzjcvJvNpkioTAyI/iFz+pxI/5Aig3kgPfRGwZwIiR9/gf1+1aSYlFPle
         pAe+kfqqpGkBdEehYavKZggUhV21q62Gg3LzYybHcnCOUGyx6rPjLa3ovknbft5vI2bA
         KN4cWkItVEudXftl2c4Pd6URQ92trZIu1pXW+nugKTMRqbCN//H4qLUvFi+mkB7NEdTT
         O4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715597881; x=1716202681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzwW8sTQB+qSV6nWhykP6k2hQs/p1Mi5fY+70UwLZpM=;
        b=iEG9WSexNbP0Ia6hapha/7js2qIO9oXPiuUnBY/jh/Utb6H9UlzO8uTMcFM+4tW4WG
         nMB+kCzTuVFjF7T+0fcVC/a8AC40mYpiV5kW8dn5N2q3cLvaAoA5eS6qaxuUOx0tgVLj
         oXASC+NpMbL2hmG5DPnVBQr5gz1qh+yoedKcuu+z7lEqOl39KtF2g0dIdgG9I6+6Dnbe
         F8pF8LEJqse6L33ubHfC+HO1xYMHwdQMx3VnNP4BBEeBRO0oN4z0X7IPAwXA09sX/hP8
         fR9Cz9/rYKFqJv6weMgGl1fvLb1Bcrzf5C+ECGKzvzKEdGPU5sr2Vs2gJf6h/W7jmCKb
         OORw==
X-Gm-Message-State: AOJu0YxHdAOVireRE1vmp01meIOlG9zfdhhpHdkrZX15mbJfLjXPlg5B
	FvZBbbwUqI4BMwq2UGCChGVwgJA0dyjr9jmEJ7by3D9ISmQZhsfZBgVjK3uNLEkTHg5rFcu4Iof
	Sb5im0GOGWVZ/jxDgkEfWVWLBCGWb/ci6JoYd+A==
X-Google-Smtp-Source: AGHT+IGx67213C8MRMg+LFDLuQv9F6oWz2XgHpmabrFAz+AJxWq8GcsjasMe9jNA+9CoLWspZdFIhUWrkCYsLNvmJfQ=
X-Received: by 2002:a17:906:7f8a:b0:a59:b6a8:4d7a with SMTP id
 a640c23a62f3a-a5a2d5d3d22mr623731266b.43.1715597880657; Mon, 13 May 2024
 03:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
 <20240508153131.94270-3-ninette@thehoodiefirm.com> <3ebe931181412a352eb719d19cee95b0f2eebe23.camel@linuxfoundation.org>
In-Reply-To: <3ebe931181412a352eb719d19cee95b0f2eebe23.camel@linuxfoundation.org>
From: Ninette Adhikari <ninette@neighbourhood.ie>
Date: Mon, 13 May 2024 12:57:49 +0200
Message-ID: <CAG1aeW0ySPCCTd040nwjB0VEptrPdECrfLTCrG2OULEo7fChUA@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH 02/12] patch-status: add README.md file
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: yocto-patches@lists.yoctoproject.org, engineering@neighbourhood.ie, 
	Alex Feyerke <hello@alexfeyerke.com>
Content-Type: multipart/alternative; boundary="0000000000004122ee061853c200"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 May 2024 10:58:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/117

--0000000000004122ee061853c200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

This is really strange that the patches are coming through as empty for
you. Sorry about that! Just to be sure that we understood correctly do you
mean your email client actually doesn=E2=80=99t display the patches? becaus=
e we can
see them in the email you replied to.
I followed this documentation
<https://docs.yoctoproject.org/contributor-guide/submit-changes.html?highli=
ght=3Dpull+request#sending-the-patches-via-email>
to send the patches and it worked fine for previous patches. We have also
pushed the patches to the yocto metrics contributors branch
<https://git.yoctoproject.org/yocto-metrics/log/?h=3Dcontrib/jacobabrandner=
/improve_chart_page>
in case you can't view the email patches.

Please let me know if there is any other way to share the patches or if I
should rensend the patches. Thanks so much!

Best,
Ninette

On Thu, May 9, 2024 at 12:53=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2024-05-08 at 17:31 +0200, Ninette Adhikari via
> lists.yoctoproject.org wrote:
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#93):
> > https://lists.yoctoproject.org/g/yocto-patches/message/93
> > Mute This Topic: https://lists.yoctoproject.org/mt/105983324/1686473
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe:
> >
> https://lists.yoctoproject.org/g/yocto-patches/leave/13162210/1686473/167=
7322349/xyzzy
> >  [richard.purdie@linuxfoundation.org]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
> This patch and patches 4, 7 and 8 all appeared to come through as empty
> unfortunately (messages with nothing in them other than the list
> footer).
>
> Any idea what happened to them?
>
> Cheers,
>
> Richard
>
>
>
>

--0000000000004122ee061853c200
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Richard,</div><div><br></div><div=
>This is really strange that the patches are coming through as empty for yo=
u. Sorry about that! Just to be sure that we understood correctly do you me=
an your email client actually doesn=E2=80=99t display the patches? because =
we can see them in the email you replied to.<br>I followed this <a href=3D"=
https://docs.yoctoproject.org/contributor-guide/submit-changes.html?highlig=
ht=3Dpull+request#sending-the-patches-via-email" target=3D"_blank">document=
ation</a> to send the patches and it worked fine for previous patches. We h=
ave also pushed the patches to the yocto metrics <a href=3D"https://git.yoc=
toproject.org/yocto-metrics/log/?h=3Dcontrib/jacobabrandner/improve_chart_p=
age" target=3D"_blank">contributors branch</a> in case you can&#39;t view t=
he email patches.</div><div><br></div><div>Please let me know if there is a=
ny other way to share the patches or if I should rensend the patches. Thank=
s so much!</div><div><br></div><div>Best,</div><div>Ninette<br></div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu=
, May 9, 2024 at 12:53=E2=80=AFPM Richard Purdie &lt;<a href=3D"mailto:rich=
ard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxfound=
ation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Wed, 2024-05-08 at 17:31 +0200, Ninette Adhikari via <a href=
=3D"http://lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lis=
ts.yoctoproject.org</a> wrote:<br>
&gt; <br>
&gt; <br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#93):<br>
&gt; <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/93" =
rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/yocto=
-patches/message/93</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/10598332=
4/1686473" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.=
org/mt/105983324/1686473</a><br>
&gt; Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoprojec=
t.org" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
&gt; Unsubscribe:<br>
&gt; <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/131622=
10/1686473/1677322349/xyzzy" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.yoctoproject.org/g/yocto-patches/leave/13162210/1686473/1677322349/xyz=
zy</a><br>
&gt; =C2=A0[<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D=
"_blank">richard.purdie@linuxfoundation.org</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
This patch and patches 4, 7 and 8 all appeared to come through as empty<br>
unfortunately (messages with nothing in them other than the list<br>
footer).<br>
<br>
Any idea what happened to them?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
</blockquote></div><br></div>

--0000000000004122ee061853c200--

