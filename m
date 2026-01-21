Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC95C44506
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 17:44:13 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17748.1769017450164651917
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 09:44:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=X7cMWh+b;
 spf=pass (domain: smile.fr, ip: 209.85.221.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359019da8cso79591f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 09:44:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769017448; cv=none;
        d=google.com; s=arc-20240605;
        b=EhIBZFyFP37KBrRulD5RusD36a8+3dvnXbtyrhtEK7LpkctG6sSL7xVIFVwhlIBDZA
         YQNrf4Apdn6kSA/wVMjQPkrJsnDliF/uJJAYVUVMX7CgMbR0NCeZw84hkwZ2W93UyD7R
         HktvOi77AbS302CODjI17rZdcQJ5GnOdt7qbBGHPBvvLqsEplUSzekwUmf9QoGD2LGD+
         l3YqCgG/raq75SHja2TaiWPaj4sGXQNMhwKRCXJXI9z9Pi/oflitog6K7jdH13ztdV7c
         C4ByYlx541Y5uZ4wr3Xf7yyTUk2INNXWQBHj2SjEls7dQPqgv/qpbVZhxpLrSbHDaZdE
         0WOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jn52W1F7ZDLeFyg4lIcqAAXLeCV4w4Rub7hBkZ2bh8A=;
        fh=u5y/fV0y01xno7bV/8wxhRuk/xfJv6jNQKIdWBR5KX8=;
        b=Uws5SJ9E5kuSKRXI62qc4/7Cj/1vyKcZqHmLupJtXHf0hbtIfkLtyCYzOB9q7OjOJ/
         OCQrJ9zb6Xeri4TndGm32NWkuMctPsDQioRGjdsxv9KaTsBHAGyWam+HwPWRw/bs/P/X
         k3MpxrfQHaFG4r7LwX/t3qQx/Z2uNeQr8qpkp4kGKreSvromlVsS8IW+scUGmUpfLWjb
         PCLSQCHG1uWE2okUxtSzTAitJBUzjGTTyMm698lRmitbnRQruYTgz7/aRcxYrwuSnl4k
         4vQLc+luUy1rPnIqIcnnaaPklh+fpR+zhzSZgqau2frFtnAoJxj78EgWmfc8QB2B+f4n
         ASDA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769017448; x=1769622248; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn52W1F7ZDLeFyg4lIcqAAXLeCV4w4Rub7hBkZ2bh8A=;
        b=X7cMWh+bUSHzUbzae0SVZqt07FREiN4PFVgn7gAL983uZVOzyUYSQ8oWMNQlw9VT0A
         D9sXlStF6Xr5egc3MkMtltlT2IqRWWWObxKGE9oMOzAuASV5QM6ep/iECLWHwf9UPjXU
         M/rWNMAFxYBcHtHlOMHJFmGeVJ2wL6TM77Awg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769017448; x=1769622248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jn52W1F7ZDLeFyg4lIcqAAXLeCV4w4Rub7hBkZ2bh8A=;
        b=E0WyiYLNSCaWeDh+x+0e69EdTW+rfDmdesh3J9BEwmrfmJuGlBXXF3W+ra4iWFWa3T
         uCCOsIY65maWrExFw+rX0iP3mOf9CXYdPQvONWlZknaq0Jztu4WDz1SurhUkTpxXpnpT
         FftuXukQDrrsTkgTE2YSIWLSYluVn5oXeyc00ZGarKLkZYViUa3kAlPXx2DInWaYGQVM
         ybBqgSzox+G1QTyXLvT2FcL//Px/+UeZwuP07bIFl8+hN/NHrCejWDPFGH7iH5jkOvHg
         X3ziVABKtQABL/9Szv4zZ0iA4qODgrlpQt7JS891wlOLS4wGzhkNWwUwQ7I9ynpp4HaQ
         1Fmw==
X-Gm-Message-State: AOJu0Yxj+LmVNvbWqPJczjDtC6IcgMoNg6Foh7MTPVN++tvyWtVDNT8z
	zaqldwWTVDR143IiQMkZfNGT9X9Ef7BstCHL542ncpSNL9O2o8K/OM2fCN6JarnERJIfa4J7rVm
	Qk6z8WvuIQ6vmo/Dv056u/N9kpx2mrjnPBjrmJ9mD4Q==
X-Gm-Gg: AZuq6aL5wUYdLHG2mA8Rd8BNyGqUTQlpyrRny5x53zbK9ii5iZ+SlVw8thWHW9RyyjK
	ugltitIJtQW+a3K3M3F8NH3FlOJlu2FuBk7eeqCw0EssxFEhCMfGQcrTry+FQw/A5DsLXZGYgLF
	CYHBDy/vkh1zy+qSpImt7EYgwOurzZEjr1j/hbfrxytLJp9J1o3nMvISd1m0gjczitLjDe++p/P
	OehubhIAmD/G5jHu6K+4HRX6zCrjLbXX2JYAS1CKg8U1H8nvKazdkx2MTdZ8F6BGypuCnHlkvlL
	WYzNR5UX7Y+NRUWmSyMiZY/zzxCbTA==
X-Received: by 2002:a05:6000:1acd:b0:431:656:c73a with SMTP id
 ffacd0b85a97d-4356a07745fmr27811157f8f.31.1769017448510; Wed, 21 Jan 2026
 09:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20260121163409.59824-1-yoann.congal@smile.fr> <20260121163409.59824-2-yoann.congal@smile.fr>
 <CA+chaQd5_PZzoQJAdFV+5xrDTN_NTvP+qL3uS9BWVV2V3F0Viw@mail.gmail.com>
In-Reply-To: <CA+chaQd5_PZzoQJAdFV+5xrDTN_NTvP+qL3uS9BWVV2V3F0Viw@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Wed, 21 Jan 2026 18:43:23 +0100
X-Gm-Features: AZwV_QjwOOEc-xMUa_HWmW8JCXYr9l7DrCFSFO-mh7OZ8D3BQKZmCAEQX4kS3mQ
Message-ID: <CAMSfU+67DW5RLwWifv9xs_ndhvWb+D_OGuRdqiHq2=Z6ncKMwA@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH 2/2] schedulers: Add
 missing stable branches for non-core repos
To: Martin Jansa <martin.jansa@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000009ec63d0648e9783d"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 17:44:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3047

--0000000000009ec63d0648e9783d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 janv. 2026 =C3=A0 18:16, Martin Jansa <martin.jansa@gmail.com> a
=C3=A9crit :

> On Wed, Jan 21, 2026 at 5:34=E2=80=AFPM Yoann Congal via
> lists.yoctoproject.org <yoann.congal=3Dsmile.fr@lists.yoctoproject.org>
> wrote:
> >
> > From: Yoann Congal <yoann.congal@smile.fr>
> >
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > ---
> >  schedulers.py | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/schedulers.py b/schedulers.py
> > index 0018fcb..036d66c 100644
> > --- a/schedulers.py
> > +++ b/schedulers.py
> > @@ -75,7 +75,10 @@ branchdefaults =3D {
> >          'branch': 'whinlatter',
> >          'branch_bitbake': '2.16',
> >          'branch_meta-arm': 'whinlatter',
> > +        'branch_meta-aws': 'whinlatter',
> > +        'branch_meta-clang': 'whinlatter',
>
> I think there is no whinlatter branch in meta-clang.
>
Right!

v2 incoming

Thanks Martin :)

--=20
Yoann Congal
Smile ECS

--0000000000009ec63d0648e9783d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mer. 21=
 janv. 2026 =C3=A0=C2=A018:16, Martin Jansa &lt;<a href=3D"mailto:martin.ja=
nsa@gmail.com">martin.jansa@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Jan 21, 2026 at 5=
:34=E2=80=AFPM Yoann Congal via<br>
<a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.yoctoproject.org</a> &lt;yoann.congal=3D<a href=3D"mailto:smile.f=
r@lists.yoctoproject.org" target=3D"_blank">smile.fr@lists.yoctoproject.org=
</a>&gt;<br>
wrote:<br>
&gt;<br>
&gt; From: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=
=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.f=
r" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 schedulers.py | 6 ++++++<br>
&gt;=C2=A0 1 file changed, 6 insertions(+)<br>
&gt;<br>
&gt; diff --git a/schedulers.py b/schedulers.py<br>
&gt; index 0018fcb..036d66c 100644<br>
&gt; --- a/schedulers.py<br>
&gt; +++ b/schedulers.py<br>
&gt; @@ -75,7 +75,10 @@ branchdefaults =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch&#39;: &#39;whinlatter&#3=
9;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_bitbake&#39;: &#39;2.16&=
#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-arm&#39;: &#39;whin=
latter&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-aws&#39;: &#39;whinlatte=
r&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-clang&#39;: &#39;whinlat=
ter&#39;,<br>
<br>
I think there is no whinlatter branch in meta-clang.<br>
</blockquote></div><div>Right!</div><div><br></div><div>v2 incoming</div><d=
iv><br></div><div>Thanks Martin :)</div><br><span class=3D"gmail_signature_=
prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><font face=
=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--0000000000009ec63d0648e9783d--

