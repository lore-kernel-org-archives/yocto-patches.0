Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0A4C52D6F
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 16:47:58 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
 by mx.groups.io with SMTP id smtpd.web11.547.1724258873274669746
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Aug 2024 09:47:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=fkA0Cjez;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.175, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6b5b65b1b9fso36553717b3.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1724258872; x=1724863672; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QU4Wzxww0/a/EWvrHx4Ba3T4QdHo6m6FY4DM2x804YM=;
        b=fkA0CjezdYsVPWuP3/E2Bnf1omXgqzlEFLoZwwaIoshUTy2cUL6U42SJv6eGWPRHbe
         rG1YIhtBIG8DUkU2f4klo26kvFQ1J6xyFuGGRR7JcG8zyB+pv9gBigY3NlrxBiM+OTNS
         EWAgR56k+5exYzorfGYJYPAaQe6bzLw5zTDDGI/ToxmHXHuiuROTnKCo1UfAn8ErSJfd
         +imQ61IFYfpDd1IrX/LN4mHn+ADm3CVoUvFxTrhJ0tKm7jhDBGOwWMC6ApyoufnV/COy
         4xBjGxUACmr+DSckFgwkzjySc62StV0nqWeZnebSWnJa0MFU3J3Ef+arq2RjVR8RD88B
         pPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258872; x=1724863672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QU4Wzxww0/a/EWvrHx4Ba3T4QdHo6m6FY4DM2x804YM=;
        b=DEO7OjmOKVXj3nvwqPuE4IdUmvMJMGLctu2JAlRyaVphdiuNTZikUFC/V4cpKVq3US
         Js9CpdbVS85iQSm9Bof5avDESw0Kp6c9A3tbK9C4FUd5fv5oTuogUf7jS2bTtFHGru66
         /gUk4cWPJfBQNsi6PZ9KKzMxjv9xILDQeKAtMGaoNwlg92UhYIo0gENm07L6QY/cGCU0
         Tna6TP2iMNc5wmoXXuNd9fpKdf//o8xZ/OFWLXRIIBkOJGOVOwxnQt7OGxhe8/iyLMol
         wGOnyUy75VE21cQbq/yvzKq5/ERbLG9ZEmp7f3EWMayk02XZJyjVYHsl9uFAeBfPHKgG
         fH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUZiUQ9pa5/KRQTj3MwdWlFa9NvQJPI4WCG9vfpWNuIy2z3ETlxzjuPwksQ5WwL98bdUOnEp5A3FXxrl9m@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yxz6SF0PiZ8BZV1xJPbCLZMUmVYAXdi6Zk3BndMP6PJLKvz/Pmt
	rSXimD0F1HxkRjTGhtSl+3Z9wl9o3B8cLgyI2BKeUqTpW/8igKCTX+PCxpgW4ZfNAouaxqeh/U6
	D3JeT7oGsJe65DRoIHriuiE/JRf0ZrRbPo9ydBg==
X-Google-Smtp-Source: AGHT+IGEJeReSUyXhZUROzuyNRyCWb8YDDE2B/Y0PrhtjSWB2sRXQs0Ick2q0VlmRTgqFCQuIBuQUwSagJ40Q7kymJI=
X-Received: by 2002:a05:690c:2c88:b0:6b3:3520:a45 with SMTP id
 00721157ae682-6c0fc1dd57cmr23526817b3.20.1724258872366; Wed, 21 Aug 2024
 09:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <23f3f3e4c8010e7f1b2322976ded709912863ca9.1724240133.git.joerg.sommer@navimatix.de>
 <cf10983b4b7efdd6125d2dc519d52fab9f4ec3ce.camel@linuxfoundation.org> <h4mbf77iqrtjho2p55b2beriufcf3b5i773onru6wignzjnxlu@v7ncwogo3k6y>
In-Reply-To: <h4mbf77iqrtjho2p55b2beriufcf3b5i773onru6wignzjnxlu@v7ncwogo3k6y>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 21 Aug 2024 10:47:41 -0600
Message-ID: <CAOU5ZMun=6eiVpSXNMz8Ca0kpdoD3gkEMDa+PXOgSVc8U=qwNQ@mail.gmail.com>
Subject: Re: [yocto-patches] [ptest-runner][PATCH] README: Update mailing list
 address for patches + add git command
To: =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg.sommer@navimatix.de>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000096b6d00620344de3"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 16:47:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/545

--00000000000096b6d00620344de3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:34=E2=80=AFAM J=C3=B6rg Sommer <joerg.sommer@nav=
imatix.de>
wrote:

> Richard Purdie schrieb am Mi 21. Aug, 16:44 (GMT):
> > On Wed, 2024-08-21 at 13:35 +0200, J=C3=B6rg Sommer via
> lists.yoctoproject.org wrote:
> > > From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> > >
> > > Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> > > ---
> > >  README.md | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/README.md b/README.md
> > > index e6f548e..8afb161 100644
> > > --- a/README.md
> > > +++ b/README.md
> > > @@ -48,8 +48,12 @@ $ mtrace ./ptest-runner $MALLOC_TRACE
> > >
> > >  ## Contributions
> > >
> > > -For contribute please send a patch with subject prefix
> "[ptest-runner]" to
> > > -yocto@lists.yoctoproject.org.
> > > +For contribute please send a patch with subject prefix
> "[ptest-runner]" to
> > > +yocto-patches@lists.yoctoproject.org.
> > > +
> > > +```
> > > +git send-email --to=3Dyocto-patches@lists.yoctoproject.org --subject=
-prefix=3D'ptest-runner][PATCH'
> ...
> > > +```
> >
> > This looks good but we might also want to cc: Anibal on these so note
> > that in there as well?
>
> Would be `--cc=3Danibal@limonsoftware.com` okay?
>

Yes I will add that to your patch, Thanks!,
Anibal

--00000000000096b6d00620344de3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 21, 2024 at 10:34=E2=80=
=AFAM J=C3=B6rg Sommer &lt;<a href=3D"mailto:joerg.sommer@navimatix.de">joe=
rg.sommer@navimatix.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Richard Purdie schrieb am Mi 21. Aug, 16:44 (GMT):<br=
>
&gt; On Wed, 2024-08-21 at 13:35 +0200, J=C3=B6rg Sommer via <a href=3D"htt=
p://lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">lists.yoct=
oproject.org</a> wrote:<br>
&gt; &gt; From: J=C3=B6rg Sommer &lt;<a href=3D"mailto:joerg.sommer@navimat=
ix.de" target=3D"_blank">joerg.sommer@navimatix.de</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: J=C3=B6rg Sommer &lt;<a href=3D"mailto:joerg.somme=
r@navimatix.de" target=3D"_blank">joerg.sommer@navimatix.de</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; =C2=A0README.md | 8 ++++++--<br>
&gt; &gt; =C2=A01 file changed, 6 insertions(+), 2 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/README.md b/README.md<br>
&gt; &gt; index e6f548e..8afb161 100644<br>
&gt; &gt; --- a/README.md<br>
&gt; &gt; +++ b/README.md<br>
&gt; &gt; @@ -48,8 +48,12 @@ $ mtrace ./ptest-runner $MALLOC_TRACE<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; =C2=A0## Contributions<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; -For contribute please send a patch with subject prefix &quot;[pt=
est-runner]&quot; to <br>
&gt; &gt; -<a href=3D"mailto:yocto@lists.yoctoproject.org" target=3D"_blank=
">yocto@lists.yoctoproject.org</a>.<br>
&gt; &gt; +For contribute please send a patch with subject prefix &quot;[pt=
est-runner]&quot; to<br>
&gt; &gt; +<a href=3D"mailto:yocto-patches@lists.yoctoproject.org" target=
=3D"_blank">yocto-patches@lists.yoctoproject.org</a>.<br>
&gt; &gt; +<br>
&gt; &gt; +```<br>
&gt; &gt; +git send-email --to=3D<a href=3D"mailto:yocto-patches@lists.yoct=
oproject.org" target=3D"_blank">yocto-patches@lists.yoctoproject.org</a>=C2=
=A0--subject-prefix=3D&#39;ptest-runner][PATCH&#39; ...<br>
&gt; &gt; +```<br>
&gt; <br>
&gt; This looks good but we might also want to cc: Anibal on these so note<=
br>
&gt; that in there as well?<br>
<br>
Would be `--cc=3D<a href=3D"mailto:anibal@limonsoftware.com" target=3D"_bla=
nk">anibal@limonsoftware.com</a>` okay?<br></blockquote><div><br></div><div=
>Yes I will add that to your patch, Thanks!,</div><div>Anibal=C2=A0</div></=
div></div>

--00000000000096b6d00620344de3--

