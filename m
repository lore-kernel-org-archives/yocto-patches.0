Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F01C3DA4A
	for <webhook@archiver.kernel.org>; Thu, 22 Aug 2024 11:45:02 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
 by mx.groups.io with SMTP id smtpd.web11.11184.1724327098043720342
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Aug 2024 04:44:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=RTgUecEy;
 spf=pass (domain: limonsoftware.com, ip: 209.85.219.178, mailfrom: anibal@limonsoftware.com)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e13e11b23faso742273276.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Aug 2024 04:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1724327097; x=1724931897; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9R3PgoInLpLKANK82fsZws9o/iFtnboHXvVm7HVE0UI=;
        b=RTgUecEyux58sQ8AopFBVmFanqItzR+bHHZInFwNN3KtRbrD+TskavDY4RPKd9aEXG
         n7oQQsylAYeT2wrROW4N6jBXhadA1OGZPMJIKv3GqMrnlWv4ARBm2O4aDRmP1aaq5ddD
         +czApmmOR8iprvegMgR1KfZXZwJjqEDUXh/Q6OBa3BmB7opZ8/ZwfPud1sUp4lvvj44N
         GOp6zDHxY2fIJgIHv8pAz55zScYuhJxAGdqhpA2T9OF4jeimaFxFH/o+fktabEl6PgUm
         m7upgA5pngfoFducdczbxdfAPP3+7yvUF5qPgDcoTP3cbBU1Hlz2+pz2xC9Q2o62otdu
         mI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724327097; x=1724931897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9R3PgoInLpLKANK82fsZws9o/iFtnboHXvVm7HVE0UI=;
        b=wL5g+0tv/jTCGZ5q6p3JZW7whgWtRG5kV5Qi6Hft+Ehi1lf4y3lfiJjOhLhbKMsUjq
         nGtFIv/wNkzwCxuHR6Fpz1tM8Cgd/PhXABY+kEnlx0/MUvIAXXeegb9F4iUYxOuar+L5
         +1Bdl/YK8sTFdupdvxTDDOrV9PqOCkRuqgkFDlxNseWT3MuK5oGlq7xn8XykQI5oznVJ
         8C8Dg5xEiF7jDeH/66XGZtk2Hf1tOLAL+Y4LwmmyAvWYdySsDU2j8xplq5GlQWv1PQct
         zQ73WePEun9XQFOIXdjXiiEyWLeM7dmiPTnep0MkcGaujyzZoBgg/mNsXRB8Dj21Z46u
         6B6Q==
X-Gm-Message-State: AOJu0YxkStT3KlefKqapBMAJAUouxVO7wyLR29lvFapnBitybNTbfwM0
	fa+FPJnZKUtOnhnKSL3R42PUJvxQ+00mSH0/zmz/FJuUwnJtKX5NQCrZyUu3uvRYs2OL7EV4+lk
	cdLgPGQ9mxEV1BU+OYuMilGV5gR5Zw4b1INZgzS5ZUDMMScAShgE=
X-Google-Smtp-Source: AGHT+IErc1rXtuM50cJR6inPzBEPL+ad7zvJIy+JksBTuzE+KFOjFkBy3Gy5AGBKckfSf+D9SX65OOyDAJLqstFgMno=
X-Received: by 2002:a05:6902:248c:b0:e13:dbac:4254 with SMTP id
 3f1490d57ef6-e1666423fefmr5485757276.31.1724327097072; Thu, 22 Aug 2024
 04:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <23f3f3e4c8010e7f1b2322976ded709912863ca9.1724240133.git.joerg.sommer@navimatix.de>
 <cf10983b4b7efdd6125d2dc519d52fab9f4ec3ce.camel@linuxfoundation.org>
 <h4mbf77iqrtjho2p55b2beriufcf3b5i773onru6wignzjnxlu@v7ncwogo3k6y>
 <CAOU5ZMun=6eiVpSXNMz8Ca0kpdoD3gkEMDa+PXOgSVc8U=qwNQ@mail.gmail.com> <lylbqxoz7egejkh6nfkilnbzfivwwp52vkle4vtn3ga22p33m7@sl4qsaqglypv>
In-Reply-To: <lylbqxoz7egejkh6nfkilnbzfivwwp52vkle4vtn3ga22p33m7@sl4qsaqglypv>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Thu, 22 Aug 2024 05:44:46 -0600
Message-ID: <CAOU5ZMuYfaHXPJNC9txjujBF0K8BBQTDWn-Zjj92ky0NxdG_9Q@mail.gmail.com>
Subject: Re: [yocto-patches] [ptest-runner][PATCH] README: Update mailing list
 address for patches + add git command
To: =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg.sommer@navimatix.de>
Cc: yocto-patches@lists.yoctoproject.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="0000000000001924d3062044306a"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 22 Aug 2024 11:45:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/548

--0000000000001924d3062044306a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:37=E2=80=AFAM J=C3=B6rg Sommer <joerg.sommer@navi=
matix.de>
wrote:

> Anibal Limon via lists.yoctoproject.org schrieb am Mi 21. Aug, 10:47
> (GMT):
> > On Wed, Aug 21, 2024 at 10:34=E2=80=AFAM J=C3=B6rg Sommer <joerg.sommer=
@navimatix.de>
> > wrote:
> >
> > > Richard Purdie schrieb am Mi 21. Aug, 16:44 (GMT):
> > > > On Wed, 2024-08-21 at 13:35 +0200, J=C3=B6rg Sommer via
> > > lists.yoctoproject.org wrote:
> > > > > From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> > > > >
> > > > > Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> > > > > ---
> > > > >  README.md | 8 ++++++--
> > > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/README.md b/README.md
> > > > > index e6f548e..8afb161 100644
> > > > > --- a/README.md
> > > > > +++ b/README.md
> > > > > @@ -48,8 +48,12 @@ $ mtrace ./ptest-runner $MALLOC_TRACE
> > > > >
> > > > >  ## Contributions
> > > > >
> > > > > -For contribute please send a patch with subject prefix
> > > "[ptest-runner]" to
> > > > > -yocto@lists.yoctoproject.org.
> > > > > +For contribute please send a patch with subject prefix
> > > "[ptest-runner]" to
> > > > > +yocto-patches@lists.yoctoproject.org.
> > > > > +
> > > > > +```
> > > > > +git send-email --to=3Dyocto-patches@lists.yoctoproject.org
> --subject-prefix=3D'ptest-runner][PATCH'
> > > ...
> > > > > +```
> > > >
> > > > This looks good but we might also want to cc: Anibal on these so no=
te
> > > > that in there as well?
> > >
> > > Would be `--cc=3Danibal@limonsoftware.com` okay?
> > >
> >
> > Yes I will add that to your patch, Thanks!,
>
> Did you forget to amend the patch?
>

Nice catch, yes, pushing upon one. Thanks!

--0000000000001924d3062044306a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 22, 2024 at 5:37=E2=80=AF=
AM J=C3=B6rg Sommer &lt;<a href=3D"mailto:joerg.sommer@navimatix.de">joerg.=
sommer@navimatix.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Anibal Limon via <a href=3D"http://lists.yoctoproject.or=
g" rel=3D"noreferrer" target=3D"_blank">lists.yoctoproject.org</a> schrieb =
am Mi 21. Aug, 10:47 (GMT):<br>
&gt; On Wed, Aug 21, 2024 at 10:34=E2=80=AFAM J=C3=B6rg Sommer &lt;<a href=
=3D"mailto:joerg.sommer@navimatix.de" target=3D"_blank">joerg.sommer@navima=
tix.de</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; Richard Purdie schrieb am Mi 21. Aug, 16:44 (GMT):<br>
&gt; &gt; &gt; On Wed, 2024-08-21 at 13:35 +0200, J=C3=B6rg Sommer via<br>
&gt; &gt; <a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer" targ=
et=3D"_blank">lists.yoctoproject.org</a> wrote:<br>
&gt; &gt; &gt; &gt; From: J=C3=B6rg Sommer &lt;<a href=3D"mailto:joerg.somm=
er@navimatix.de" target=3D"_blank">joerg.sommer@navimatix.de</a>&gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: J=C3=B6rg Sommer &lt;<a href=3D"mailto:j=
oerg.sommer@navimatix.de" target=3D"_blank">joerg.sommer@navimatix.de</a>&g=
t;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 README.md | 8 ++++++--<br>
&gt; &gt; &gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 2 deletions(-)<b=
r>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/README.md b/README.md<br>
&gt; &gt; &gt; &gt; index e6f548e..8afb161 100644<br>
&gt; &gt; &gt; &gt; --- a/README.md<br>
&gt; &gt; &gt; &gt; +++ b/README.md<br>
&gt; &gt; &gt; &gt; @@ -48,8 +48,12 @@ $ mtrace ./ptest-runner $MALLOC_TRAC=
E<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 ## Contributions<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -For contribute please send a patch with subject prefix=
<br>
&gt; &gt; &quot;[ptest-runner]&quot; to<br>
&gt; &gt; &gt; &gt; -<a href=3D"mailto:yocto@lists.yoctoproject.org" target=
=3D"_blank">yocto@lists.yoctoproject.org</a>.<br>
&gt; &gt; &gt; &gt; +For contribute please send a patch with subject prefix=
<br>
&gt; &gt; &quot;[ptest-runner]&quot; to<br>
&gt; &gt; &gt; &gt; +<a href=3D"mailto:yocto-patches@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches@lists.yoctoproject.org</a>.<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +```<br>
&gt; &gt; &gt; &gt; +git send-email --to=3D<a href=3D"mailto:yocto-patches@=
lists.yoctoproject.org" target=3D"_blank">yocto-patches@lists.yoctoproject.=
org</a> --subject-prefix=3D&#39;ptest-runner][PATCH&#39;<br>
&gt; &gt; ...<br>
&gt; &gt; &gt; &gt; +```<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This looks good but we might also want to cc: Anibal on thes=
e so note<br>
&gt; &gt; &gt; that in there as well?<br>
&gt; &gt;<br>
&gt; &gt; Would be `--cc=3D<a href=3D"mailto:anibal@limonsoftware.com" targ=
et=3D"_blank">anibal@limonsoftware.com</a>` okay?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes I will add that to your patch, Thanks!,<br>
<br>
Did you forget to amend the patch?<br></blockquote><div><br></div><div>Nice=
 catch, yes, pushing upon one. Thanks!=C2=A0</div></div></div>

--0000000000001924d3062044306a--

