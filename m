Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C4CF89254
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 10:34:48 +0000 (UTC)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22037.1776767682543176230
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Apr 2026 03:34:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=af4c5SI3;
 spf=pass (domain: gmail.com, ip: 74.125.82.49, mailfrom: rybczynska@gmail.com)
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c565476d7so9018318c88.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 03:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776767681; cv=none;
        d=google.com; s=arc-20240605;
        b=Fyn7KUkD8MT3Bbb23Wd14jBzYU23URn0/K9BauXbx9DW+LOdnRamHmZf6myOmRScC/
         qDSdnoL/hsr8mzTDWU5wwUFPeyQmsoj4myyVKBQ0RQRPPQsXmMDtAQMx6M5NgP84UhYF
         6YYznxN+nWcIsi+dmhgjqSq0LFZfn4XchCb70wVTkGeoiDP2QjjyNC89/FDN6ORKDIM+
         6YqzBqxrN9yuC8dkit+P6HJrou72H63GFDPXI3yi3UuRZTzQ66QDUDKnelfCSH4EY6M9
         UGQJnrT6SV6OPkejNoxhJ9RSw2qxS1e7rVWJu2llLXzbflDK6sV+U4Q/+kGnxk6hOk/B
         Fapg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Nlo3CUuHQz/ziRJjeUwdQzluY501p65HYeyWjuj3x7w=;
        fh=NIYVmCOpaoA0rQDVWV7U4TkSJBcqj6aHIfoAXaY5ae0=;
        b=JdkOmp3oaDXF+KKVuT5yjp0GfEbkwf5F9HfVgfg7jxtjtBnAttEP5hVJ/GV7yxcQmM
         PaUPptmhLuiU1UjzuBaiuVePCRKoGw2lKZa2/1bkhiQXFSzIDvnL1jeohClJAGZVPHy3
         Iq8YzIUNsv4lO3PFnGz1/6OmYTiYz8VWVOo7ZH2YQ15pJWJ7U0l6DJd69Gqfm3PXFYZk
         GIK/MsZyPsQ9kAZ4sFvEnUBmpK/Fsha1s1lQ9TUH4RUvmJ8IDsEti2M9CPL2bbVRKVKZ
         t/o7o0YTsNTpteexUqEUhuLV0WcANfpFOxrJD24w9Pc5NlfmEN75SRIWUeYl9U5gr72P
         JP/w==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776767681; x=1777372481; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nlo3CUuHQz/ziRJjeUwdQzluY501p65HYeyWjuj3x7w=;
        b=af4c5SI3/6xGjOFLuvyxy/OvFrEVLM8ELSjoujysSakfVUQN9Ke1WTeieYqU8XIZcQ
         rXLvccOgKIpPgL9tOBHjz6j7QEHBERM70ifEcsXhclbrNdijIySD//PxfCzrBq8QWK5R
         zSF5oE12evQ80PbS//bWTtzxybeMYqYXudc4WCLbyIaMUJKpwOB/SXrt0m6zdbnaOmzP
         BaYD3az/pWiW5L/kyVhiK3rOwIWDCA8B2GYwHIw5zuz4z62C1as9sUUM+wZJB1XQuKn0
         xLYH9Ds5fMKO8R0yKYIiLTDqJ1ZM6oBY2Fj61sI0fgEWbQlkxP8Jx+TgDIA6MXrzKKqF
         wV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776767681; x=1777372481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nlo3CUuHQz/ziRJjeUwdQzluY501p65HYeyWjuj3x7w=;
        b=LJ134laZ/wtHwYfWIpIrMXCyN1jkWp3N4XG5ZRR4qrDmdCbLcXuA6rssZEilrsZvzn
         x+0X2pf2gjMiMNLfIeJQJ388mXK7G+PkFvjt/+mnCqSqZkG7sRDjx5SdUZcF5tLeqNrx
         2VY6J0w6fKXi9MEOPbwarSdJHO+UE2MhqaAjQ2I/adIL6FYrBF34yomlR+fCvOetGZaz
         cRPklQ6BCNiVA6DVotK83YdsxX4XSpsPafLiGAhrIKoE752bXRXjNCeTE8qKuWRCyYfU
         dlPNXDiYhNnVF9B6DRIBqUJ0dJBeLpKj8DNXlrv9zuqHfm1bjK0GNNc2Qwop2SoeJnGs
         3RKg==
X-Gm-Message-State: AOJu0YxY/zYc6ZY0CeA8sw+cMJH1n3zVCgPuijB6lVeY3cE4gqC1jdrB
	FZAtoIUnzy38KZBA8mfNNlxoXNqhyQ391eXUGvpKg1vblmd6dzNZHCxR0cm4KHmrF6cPf/Bnrz1
	sEnCuBBUzyq35tGP+xDHiCyTyn3EUmHoYGMXq
X-Gm-Gg: AeBDiev82AS20Fcdfbj4kbycAWlzqB3/dEkNmDCnd8YlpfpwXaQnzQdwniuX0Bf5PjQ
	oZ4rUeIYPVxZ4oaCFdGtkvcDllNszhQjr05cVXsU+d1/OSVyN/TarTTZsW9bY31orsYehIAOzfZ
	LPeZPbUve/10OEkPiC5E0u/dCFxk0WvlEunuxJvrIUN82iVZcKvFh5inCtpdh2npakPa1ScYgAf
	DCL+b5HIEzEqicUvy07KVmPfK47UXlf+dOcpcNTNjC1PX9FdXLMEgMomzhRYIXWKL2eQPwd4dPn
	m7eW6+Mi51Q7v/WGnLEXjk4QG2wL/6lgrszbz0mEQqBeF9Yui74=
X-Received: by 2002:a05:7022:60f:b0:12a:7181:2f1c with SMTP id
 a92af1059eb24-12c73f9983dmr10649799c88.17.1776767681016; Tue, 21 Apr 2026
 03:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260421054133.16448-1-marta.rybczynska@ygreky.com> <7139e91d403b6f917f3fe48c2e734ec00adc1801.camel@pbarker.dev>
In-Reply-To: <7139e91d403b6f917f3fe48c2e734ec00adc1801.camel@pbarker.dev>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Tue, 21 Apr 2026 12:34:29 +0200
X-Gm-Features: AQROBzC9UrMswN2DHnxzOs-X7YnuqKXZNYu3fQUNVJhGE9jwQK6kGfypTR2CsOk
Message-ID: <CAApg2=RmQ_+gr4Amzeh81LincR5JxOJTMxO+8hFrRuRZ7tCNdQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH] README: update CI links
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Content-Type: multipart/alternative; boundary="00000000000079b8de064ff5f619"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Apr 2026 10:34:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3748

--00000000000079b8de064ff5f619
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:22=E2=80=AFAM Paul Barker via lists.yoctoproject=
.org
<paul=3Dpbarker.dev@lists.yoctoproject.org> wrote:

> On Tue, 2026-04-21 at 07:41 +0200, Marta Rybczynska via
> lists.yoctoproject.org wrote:
> > Update CI links for meta-security
> >
> > Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
> > ---
> >  README.md | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/README.md b/README.md
> > index dae5aad..c92d3f2 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -1,7 +1,5 @@
> > -Master-next:
> > -[![pipeline status](
> https://gitlab.com/akuster/meta-security/badges/master-next/pipeline.svg)=
](https://gitlab.com/akuster/meta-security/-/commits/master-next
> )
> > -
> > -Master: [![pipeline status](
> https://gitlab.com/akuster/meta-security/badges/master/pipeline.svg)](htt=
ps://gitlab.com/akuster/meta-security/-/commits/master
> )
> > +Master-next: [pipeline status](
> https://gitlab.com/ygreky/meta-security/-/pipelines)
> > +Master: [pipeline status](
> https://gitlab.com/ygreky/meta-security/-/pipelines)
>
> Hi Marta,
>
> Is https://gitlab.com/ygreky/meta-security public? The new links don't
> work for me.
>
>
 Should be fixed.
Kind regards,
Marta

--00000000000079b8de064ff5f619
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 21,=
 2026 at 10:22=E2=80=AFAM Paul Barker via <a href=3D"http://lists.yoctoproj=
ect.org">lists.yoctoproject.org</a> &lt;paul=3D<a href=3D"mailto:pbarker.de=
v@lists.yoctoproject.org">pbarker.dev@lists.yoctoproject.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 2026-04=
-21 at 07:41 +0200, Marta Rybczynska via<br>
<a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.yoctoproject.org</a> wrote:<br>
&gt; Update CI links for meta-security<br>
&gt; <br>
&gt; Signed-off-by: Marta Rybczynska &lt;<a href=3D"mailto:marta.rybczynska=
@ygreky.com" target=3D"_blank">marta.rybczynska@ygreky.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 README.md | 6 ++----<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/README.md b/README.md<br>
&gt; index dae5aad..c92d3f2 100644<br>
&gt; --- a/README.md<br>
&gt; +++ b/README.md<br>
&gt; @@ -1,7 +1,5 @@<br>
&gt; -Master-next: <br>
&gt; -[![pipeline status](<a href=3D"https://gitlab.com/akuster/meta-securi=
ty/badges/master-next/pipeline.svg)%5D(https://gitlab.com/akuster/meta-secu=
rity/-/commits/master-next" rel=3D"noreferrer" target=3D"_blank">https://gi=
tlab.com/akuster/meta-security/badges/master-next/pipeline.svg)](https://gi=
tlab.com/akuster/meta-security/-/commits/master-next</a>)<br>
&gt; -<br>
&gt; -Master: [![pipeline status](<a href=3D"https://gitlab.com/akuster/met=
a-security/badges/master/pipeline.svg)%5D(https://gitlab.com/akuster/meta-s=
ecurity/-/commits/master" rel=3D"noreferrer" target=3D"_blank">https://gitl=
ab.com/akuster/meta-security/badges/master/pipeline.svg)](https://gitlab.co=
m/akuster/meta-security/-/commits/master</a>)<br>
&gt; +Master-next: [pipeline status](<a href=3D"https://gitlab.com/ygreky/m=
eta-security/-/pipelines" rel=3D"noreferrer" target=3D"_blank">https://gitl=
ab.com/ygreky/meta-security/-/pipelines</a>)<br>
&gt; +Master: [pipeline status](<a href=3D"https://gitlab.com/ygreky/meta-s=
ecurity/-/pipelines" rel=3D"noreferrer" target=3D"_blank">https://gitlab.co=
m/ygreky/meta-security/-/pipelines</a>)<br>
<br>
Hi Marta,<br>
<br>
Is <a href=3D"https://gitlab.com/ygreky/meta-security" rel=3D"noreferrer" t=
arget=3D"_blank">https://gitlab.com/ygreky/meta-security</a> public? The ne=
w links don&#39;t<br>
work for me.<br><br></blockquote><div><br></div><div>=C2=A0Should be fixed.=
</div><div>Kind regards,</div><div>Marta</div></div></div>

--00000000000079b8de064ff5f619--

