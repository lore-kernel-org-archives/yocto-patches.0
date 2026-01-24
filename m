Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83B0D715E9
	for <webhook@archiver.kernel.org>; Sat, 24 Jan 2026 13:53:45 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18777.1769262820484256282
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Jan 2026 05:53:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=uhQ2123/;
 spf=pass (domain: smile.fr, ip: 209.85.221.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4327555464cso2066830f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Jan 2026 05:53:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769262819; cv=none;
        d=google.com; s=arc-20240605;
        b=G8I7ot/Rm1zJOvKhFNd7KP4zEzyT1Bq+SgoTAvX0Iqhn6me5NUymurThYR12cC9eRc
         VvOuBzL7tllrmBDTcojIQu6Yo3h2HpGU94H6NzRLPTYTzCIUB7zldvPs7ZSlRGIMOMFi
         UMZoQTOQk3io/tQJJWp6ICnawWNTmiu2rhLWB+wOgdRjQ7yAY+1mSU5ag4JQHTqvpXg+
         tAC+Zg34hHOFXVl/pBjAVbN0B8GgcRfP7jHxmS4LfHlCr+8nQnqr3JaDrcXknxfYJrO2
         Cdb2/UtPtPNO/B7EaFIUv/a0oDUzbeovzmfJJwVWw4+NRSyxqGPdLxjj7nZizS5v5rh3
         CMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lnm1TNI/E60KGD0uuziOVEQVPn8mUhjhKBmEUTvZu9g=;
        fh=VvQjf0NX9rkBq68zKFbgS/cQ/2U9OrQZ/WSGzGdcdjs=;
        b=hjH9uskmyuvfBj7ZG3REMCn0loF7DSXE1rKenpxhnZL7zCuB5FMh7NQYGRR4tPxHDS
         rbd+GfYxt6+RkNO8Ke3U/fr0oampIaFC/mlVa7JQzaQd6ce+4q++FKfkqLwdUJUM5jfX
         y6W8asfrg3ORBCOfVttbm4DyGiJDcjyLWTKL4QMHjemS2TWk/aBhp06tPFVhyy2KOtZ/
         tWth7QNNAWQLVr+LsZq2l/IkqnsiK6WrrnUh72hp4QkG14Os02pBCbaJ3ARJSSnsgbFn
         Zig+/KhL49er6C6TDK1JmwCSkIMbNX8LP8zuWilBkj1gDlj1nHXrNACNy8tEJOFdHIpo
         3Trg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769262819; x=1769867619; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lnm1TNI/E60KGD0uuziOVEQVPn8mUhjhKBmEUTvZu9g=;
        b=uhQ2123/Q0/cP7BIPa2mPkaKN2YZbFwqVrplCW2eDW5EZffht1fFMAusbSmq0p4IOr
         scPQIhfyOKvDzUb5W36e27i6y/57UCy7e46ovHWgWjGVXgkCmubz4+mYqsLKMmkRvXDi
         A7s6gTw/Na4+Qj4lyhyLErPyN0S2Ec/8m64SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769262819; x=1769867619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnm1TNI/E60KGD0uuziOVEQVPn8mUhjhKBmEUTvZu9g=;
        b=VCtxm1+TOqDp1UNJozIEpj3rfxbxJF0WHes7yIx982LpD9538tkCFeHDE+EIExlAaC
         QkFm75wLLHAwbRDiMD/h9Ckjtvg8ONAerjf3HKBSG3cjKh/Yfhnefuc9T6Zw7yzJUSkT
         zlOOEeiiR666nvvYxqQ07GWZEazrEFZ5GS2OT5xWJ4UvWbFOLhqyf4Eki+tLoqS/j56S
         F9zN/x0/s3RfCaE3qyT/mRwAXs356ldsAOr+9IiPHBEMERJr4ZzmY62FiDshC1LKR8Qa
         N0ZG7eMdTcn81P2+Ug9OTzSp9bv7m9mOVQaV5PS8b7TtCKLiRe9b5D9MZ2zG4UYFXZlt
         9zrw==
X-Gm-Message-State: AOJu0YzmQqr265hO544NwgigwRBXEFrUaN6qSW/76VwhNZZj1jMI4+6K
	zI9PtS5wECejahmZbjzHaPoWW33B2DDo5L/tInnQxmsvxoJ1j80qDGIwXSoqCukpbw4cXt45SJK
	cBjviNAXVQe9c3DDnqW7ilY2SoCGUxtSIlOiDaSbLLA==
X-Gm-Gg: AZuq6aLKE5+Sum3CqB5ieQ+AhxBCD2jYGht8LdeE4s7jpKCt/R3p3KxQ/hXAHOlJnzJ
	mAMPLbg4BShaW7ICsuT4v6sU4rLSgwgeG8wKFE51Z6rTKG3+/ncUXNESRtotkO2vrYBc4dwIsfD
	D6wADxJkJQnYu6fM74pvxDpCEOFL57yKnzUvBrnWQUbGwg/IsCGfCtrySN4s52I9P2E4WKa84PW
	+QrMlWcRH2/dccvhFX5EmCgfZxb0/hDV+CmDPmwuzU+ZqcEUMRVvRRMBYTYywsTzJmMxVuLfGZL
	jEucCIFsOA/+/MFzTHW0zOKbsAh/
X-Received: by 2002:a05:6000:2c08:b0:435:9522:2bc9 with SMTP id
 ffacd0b85a97d-435b15bd97fmr12725334f8f.5.1769262818603; Sat, 24 Jan 2026
 05:53:38 -0800 (PST)
MIME-Version: 1.0
References: <20260121174651.64212-1-yoann.congal@smile.fr> <DB5PR02MB10213B6D7B2ED24E5B7C1BC72EF96A@DB5PR02MB10213.eurprd02.prod.outlook.com>
In-Reply-To: <DB5PR02MB10213B6D7B2ED24E5B7C1BC72EF96A@DB5PR02MB10213.eurprd02.prod.outlook.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Sat, 24 Jan 2026 14:53:12 +0100
X-Gm-Features: AZwV_Qju3xx6Cjv30eiy5_7aGxQRwLgVXQXJPCEyYkKqU7JhzqEqwTZclYsDV0g
Message-ID: <CAMSfU+77g0L6iG6Y1pcxd3KmXOGSE9i13iP048X612BqNxVFYA@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH v2 1/2] schedulers:
 sort repo branches in maintained stable branches
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Content-Type: multipart/alternative; boundary="000000000000d14dad06492299c4"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 24 Jan 2026 13:53:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3067

--000000000000d14dad06492299c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 janv. 2026 =C3=A0 18:52, Peter Kjellerstedt <
peter.kjellerstedt@axis.com> a =C3=A9crit :

> > -----Original Message-----
> > From: yocto-patches@lists.yoctoproject.org <
> yocto-patches@lists.yoctoproject.org> On Behalf Of Yoann Congal via
> lists.yoctoproject.org
> > Sent: den 21 januari 2026 18:47
> > To: yocto-patches@lists.yoctoproject.org
> > Cc: Yoann Congal <yoann.congal@smile.fr>
> > Subject: [yocto-patches] [yocto-autobuilder2][PATCH v2 1/2] schedulers:
> sort repo branches in maintained stable branches
> >
> > From: Yoann Congal <yoann.congal@smile.fr>
> >
> > This should help seeing if any branch is missing by comparing with the
> > "Build Properties" page of a build.
> >
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > ---
> >  schedulers.py | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/schedulers.py b/schedulers.py
> > index 42983a8..0018fcb 100644
> > --- a/schedulers.py
> > +++ b/schedulers.py
> > @@ -73,16 +73,16 @@ branchdefaults =3D {
> >      },
> >      'whinlatter': {
> >          'branch': 'whinlatter',
> > -        'branch_poky': 'master',
> >          'branch_bitbake': '2.16',
> >          'branch_meta-arm': 'whinlatter',
> >          'branch_meta-gplv2': 'master',
> >          'branch_meta-mingw': 'whinlatter',
> >          'branch_meta-openembedded': 'whinlatter',
> > +        'branch_meta-virtualization': 'whinlatter',
> >          'branch_meta-yocto': 'whinlatter',
> > -        'branch_yocto-docs': 'whinlatter',
> >          'branch_oecore': 'whinlatter',
> > -        'branch_meta-virtualization': 'whinlatter',
> > +        'branch_poky': 'master',
>
> I don't know how these are actually used, but is a branch for poky
> really meaningful with Whinlatter? Though I notice that meta-gplv2
> is also mentioned above, and it has been dead and buried for years...
>

Those are used to pre-fill the "target branch" fields when starting a new
build on the autobuilder.
Poky and meta-gplv2 are not used in the build but since the field is
present, I'd rather have it filled to a known value instead of inheriting
the default value.
I agree that some cleanup should be done to remove those unused repos from
the UI but that is for another day.

> +        'branch_yocto-docs': 'whinlatter',
> >      },
> >      'walnascar': {
> >          'branch': 'walnascar',
> > @@ -120,22 +120,22 @@ branchdefaults =3D {
> >      },
> >      'scarthgap': {
> >          'branch': 'scarthgap',
> > -        'branch_poky': 'scarthgap',
> >          'branch_bitbake': '2.8',
> > -        'branch_meta-arm': 'scarthgap',
> >          'branch_meta-agl': 'master',
> > +        'branch_meta-arm': 'scarthgap',
> >          'branch_meta-aws': 'scarthgap',
> >          'branch_meta-clang': 'scarthgap',
> >          'branch_meta-gplv2': 'master',
> >          'branch_meta-intel': 'scarthgap',
> >          'branch_meta-mingw': 'scarthgap',
> >          'branch_meta-openembedded': 'scarthgap',
> > +        'branch_meta-qt6': '6.8.1',
> >          'branch_meta-security': 'scarthgap',
> >          'branch_meta-ti': 'scarthgap',
> >          'branch_meta-virtualization': 'scarthgap',
> > -        'branch_oecore': 'scarthgap',
> >          'branch_meta-webosose': 'scarthgap-webos',
> > -        'branch_meta-qt6': '6.8.1',
> > +        'branch_oecore': 'scarthgap',
> > +        'branch_poky': 'scarthgap',
> >      },
> >      'nanbield': {
> >          'branch': 'nanbield',
> > @@ -185,22 +185,22 @@ branchdefaults =3D {
> >      },
> >      'kirkstone': {
> >          'branch': 'kirkstone',
> > -        'branch_poky': 'kirkstone',
> >          'branch_bitbake': '2.0',
> > -        'branch_meta-arm': 'kirkstone',
> >          'branch_meta-agl': 'quillback',
> > +        'branch_meta-arm': 'kirkstone',
> >          'branch_meta-aws': 'kirkstone',
> >          'branch_meta-clang': 'kirkstone',
> >          'branch_meta-gplv2': 'kirkstone',
> >          'branch_meta-intel': 'kirkstone',
> >          'branch_meta-mingw': 'kirkstone',
> >          'branch_meta-openembedded': 'kirkstone',
> > +        'branch_meta-qt6': '6.8.1',
> >          'branch_meta-security': 'kirkstone',
> >          'branch_meta-ti': 'kirkstone',
> >          'branch_meta-virtualization': 'kirkstone',
> > -        'branch_oecore': 'kirkstone',
> >          'branch_meta-webosose': 'kirkstone-webos',
> > -        'branch_meta-qt6': '6.8.1',
> > +        'branch_oecore': 'kirkstone',
> > +        'branch_poky': 'kirkstone',
> >      },
> >      'honister': {
> >          'branch': 'honister',
> >
>
> //Peter
>
>

--=20
Yoann Congal
Smile ECS

--000000000000d14dad06492299c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mer. 21 janv=
. 2026 =C3=A0=C2=A018:52, Peter Kjellerstedt &lt;<a href=3D"mailto:peter.kj=
ellerstedt@axis.com" target=3D"_blank">peter.kjellerstedt@axis.com</a>&gt; =
a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:yocto-patches@lists.yoctoproject.org" target=
=3D"_blank">yocto-patches@lists.yoctoproject.org</a> &lt;<a href=3D"mailto:=
yocto-patches@lists.yoctoproject.org" target=3D"_blank">yocto-patches@lists=
.yoctoproject.org</a>&gt; On Behalf Of Yoann Congal via <a href=3D"http://l=
ists.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproj=
ect.org</a><br>
&gt; Sent: den 21 januari 2026 18:47<br>
&gt; To: <a href=3D"mailto:yocto-patches@lists.yoctoproject.org" target=3D"=
_blank">yocto-patches@lists.yoctoproject.org</a><br>
&gt; Cc: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=
=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; Subject: [yocto-patches] [yocto-autobuilder2][PATCH v2 1/2] schedulers=
: sort repo branches in maintained stable branches<br>
&gt; <br>
&gt; From: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=
=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; <br>
&gt; This should help seeing if any branch is missing by comparing with the=
<br>
&gt; &quot;Build Properties&quot; page of a build.<br>
&gt; <br>
&gt; Signed-off-by: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.f=
r" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 schedulers.py | 22 +++++++++++-----------<br>
&gt;=C2=A0 1 file changed, 11 insertions(+), 11 deletions(-)<br>
&gt; <br>
&gt; diff --git a/schedulers.py b/schedulers.py<br>
&gt; index 42983a8..0018fcb 100644<br>
&gt; --- a/schedulers.py<br>
&gt; +++ b/schedulers.py<br>
&gt; @@ -73,16 +73,16 @@ branchdefaults =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;whinlatter&#39;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch&#39;: &#39;whinlatter&#3=
9;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_poky&#39;: &#39;master&#39;,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_bitbake&#39;: &#39;2.16&=
#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-arm&#39;: &#39;whin=
latter&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-gplv2&#39;: &#39;ma=
ster&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-mingw&#39;: &#39;wh=
inlatter&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-openembedded&#39;: =
&#39;whinlatter&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-virtualization&#39;: &#3=
9;whinlatter&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-yocto&#39;: &#39;wh=
inlatter&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_yocto-docs&#39;: &#39;whinlat=
ter&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_oecore&#39;: &#39;whinla=
tter&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-virtualization&#39;: &#3=
9;whinlatter&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_poky&#39;: &#39;master&#39;,<=
br>
<br>
I don&#39;t know how these are actually used, but is a branch for poky <br>
really meaningful with Whinlatter? Though I notice that meta-gplv2 <br>
is also mentioned above, and it has been dead and buried for years...<br></=
blockquote><div><br></div><div>Those are used to pre-fill the &quot;target =
branch&quot; fields when starting a new build on the autobuilder.</div><div=
>Poky and=C2=A0meta-gplv2 are not used in the build but since the field is =
present, I&#39;d rather have it filled to a known value instead of inheriti=
ng the default value.</div><div>I agree that some cleanup should be done to=
 remove those unused repos from the UI but that is for another day.</div><d=
iv><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_yocto-docs&#39;: &#39;whinlat=
ter&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;walnascar&#39;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch&#39;: &#39;walnascar&#39=
;,<br>
&gt; @@ -120,22 +120,22 @@ branchdefaults =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;scarthgap&#39;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch&#39;: &#39;scarthgap&#39=
;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_poky&#39;: &#39;scarthgap&#39=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_bitbake&#39;: &#39;2.8&#=
39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-arm&#39;: &#39;scarthgap=
&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-agl&#39;: &#39;mast=
er&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-arm&#39;: &#39;scarthgap=
&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-aws&#39;: &#39;scar=
thgap&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-clang&#39;: &#39;sc=
arthgap&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-gplv2&#39;: &#39;ma=
ster&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-intel&#39;: &#39;sc=
arthgap&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-mingw&#39;: &#39;sc=
arthgap&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-openembedded&#39;: =
&#39;scarthgap&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-qt6&#39;: &#39;6.8.1&#39=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-security&#39;: &#39=
;scarthgap&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-ti&#39;: &#39;scart=
hgap&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-virtualization&#39;=
: &#39;scarthgap&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_oecore&#39;: &#39;scarthgap&#=
39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-webosose&#39;: &#39=
;scarthgap-webos&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-qt6&#39;: &#39;6.8.1&#39=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_oecore&#39;: &#39;scarthgap&#=
39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_poky&#39;: &#39;scarthgap&#39=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;nanbield&#39;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch&#39;: &#39;nanbield&#39;=
,<br>
&gt; @@ -185,22 +185,22 @@ branchdefaults =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;kirkstone&#39;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch&#39;: &#39;kirkstone&#39=
;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_poky&#39;: &#39;kirkstone&#39=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_bitbake&#39;: &#39;2.0&#=
39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-arm&#39;: &#39;kirkstone=
&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-agl&#39;: &#39;quil=
lback&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-arm&#39;: &#39;kirkstone=
&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-aws&#39;: &#39;kirk=
stone&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-clang&#39;: &#39;ki=
rkstone&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-gplv2&#39;: &#39;ki=
rkstone&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-intel&#39;: &#39;ki=
rkstone&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-mingw&#39;: &#39;ki=
rkstone&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-openembedded&#39;: =
&#39;kirkstone&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-qt6&#39;: &#39;6.8.1&#39=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-security&#39;: &#39=
;kirkstone&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-ti&#39;: &#39;kirks=
tone&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-virtualization&#39;=
: &#39;kirkstone&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_oecore&#39;: &#39;kirkstone&#=
39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-webosose&#39;: &#39=
;kirkstone-webos&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_meta-qt6&#39;: &#39;6.8.1&#39=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_oecore&#39;: &#39;kirkstone&#=
39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch_poky&#39;: &#39;kirkstone&#39=
;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;honister&#39;: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;branch&#39;: &#39;honister&#39;=
,<br>
&gt; <br>
<br>
//Peter<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>
</div>

--000000000000d14dad06492299c4--

