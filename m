Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B54C52D7C
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 16:49:38 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
 by mx.groups.io with SMTP id smtpd.web10.582.1724258975681033121
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Aug 2024 09:49:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=xtshK3Ak;
 spf=pass (domain: limonsoftware.com, ip: 209.85.219.181, mailfrom: anibal@limonsoftware.com)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso7327794276.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1724258975; x=1724863775; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rcpOdcOpcuaCnhRxI3MurvL/qpJWxEJ/8QQRN/efchs=;
        b=xtshK3Ak0s7Nup2L0wt4JGDsw98sR0b4PYWFIBqp18IWVEA4EKVL1Qjc6UIwKJlmGa
         g43Lw3IoH4fnWaa8szO64FEj3Fy5fVEupWyYNpWUWjy3w0lc5sC4nNK1iFnesr8ix23t
         L5EylDQhL2q5Vt3A6c4VFdDIwFXRfBAxGHtBpn8gOipjb62QKnId1GlDf4SV23Fk2hQ7
         JFkxzV66/gD9/XFAttmRAztxmuLBPDU6qG0CpoD7E7a82VACt3JoUDx5Z8+Jbfmrnt/b
         /K6Z/bprRgrfCKM3eJg64KEKbASgaaJMK7eC2gzBJ8gZXIR3HQ1XUb4z38Q4N7PtHeUT
         JIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258975; x=1724863775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcpOdcOpcuaCnhRxI3MurvL/qpJWxEJ/8QQRN/efchs=;
        b=Kibsqz0mbgH1Yo0XaZxmH0MPyTpXJjqSGRfSAaHiZWUhY6BgrVTVwSYy/9MwE5mw/b
         SfejUrv0WRNg+Km9OJHoDyAWh0MYzA3TBKavAZ4WILycpiDxEf1dXuw+fW4z4MKVhz5K
         wozMYBPVFiLWZWYvpOEpzzuktz4KOSXizxsESm9TBMSbiq71QT26SOJ3wUAzPPCu9ZOW
         KDkrBhcWx2U31WUPJuDh4DpAuBdzmAqzz40+24Wtkr0zcDGjtCbNl3Q6rHnGOorUNh3W
         VccHwoeDvUQJI/bdgBkbQil09BHkJtm7BqtpF2AADT5SUWYmshvI4XbvpfEb2qFlBXtH
         AxtQ==
X-Gm-Message-State: AOJu0Yzzc/ekJTI+bx4ivBq3k6P+Z3dvH0xdKV6lxjhy1/TuBn4g43QR
	P8Q6/4faAn/Zhgfw6q5tYPHbFCMTdkwnL43qsuySw9b73kG2LeI00CrG5HNzpkWSgN0QFNq4l/c
	cJs8fuT9MSy9OAkdAA3T5TEj8ldmskLJqWhV0T7WEW46X+BhsfHc=
X-Google-Smtp-Source: AGHT+IGjR8QdvmxeAo2i/Bwwy3nEr2xp/43Zt5kF4MYOzzOxzSAyeuRXukrzNN/L6FO/NCqi4vcJuFwf4Hy2fQqAe5Q=
X-Received: by 2002:a05:6902:706:b0:e0b:db06:18cc with SMTP id
 3f1490d57ef6-e166541437emr3754552276.12.1724258974573; Wed, 21 Aug 2024
 09:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <23f3f3e4c8010e7f1b2322976ded709912863ca9.1724240133.git.joerg.sommer@navimatix.de>
 <cf10983b4b7efdd6125d2dc519d52fab9f4ec3ce.camel@linuxfoundation.org>
 <h4mbf77iqrtjho2p55b2beriufcf3b5i773onru6wignzjnxlu@v7ncwogo3k6y> <17EDCC4F5AAB762D.16045@lists.yoctoproject.org>
In-Reply-To: <17EDCC4F5AAB762D.16045@lists.yoctoproject.org>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 21 Aug 2024 10:49:23 -0600
Message-ID: <CAOU5ZMvmJ5r1EbZYoWP5bOFiYi=4QMf3TyV4WhuCR0VbcxEM-A@mail.gmail.com>
Subject: Re: [yocto-patches] [ptest-runner][PATCH] README: Update mailing list
 address for patches + add git command
To: yocto-patches@lists.yoctoproject.org, 
	=?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg.sommer@navimatix.de>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000ae3e3f062034538c"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 16:49:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/546

--000000000000ae3e3f062034538c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied!.

On Wed, Aug 21, 2024 at 10:47=E2=80=AFAM Anibal Limon via lists.yoctoprojec=
t.org
<anibal=3Dlimonsoftware.com@lists.yoctoproject.org> wrote:

>
>
> On Wed, Aug 21, 2024 at 10:34=E2=80=AFAM J=C3=B6rg Sommer <joerg.sommer@n=
avimatix.de>
> wrote:
>
>> Richard Purdie schrieb am Mi 21. Aug, 16:44 (GMT):
>> > On Wed, 2024-08-21 at 13:35 +0200, J=C3=B6rg Sommer via
>> lists.yoctoproject.org wrote:
>> > > From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
>> > >
>> > > Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
>> > > ---
>> > >  README.md | 8 ++++++--
>> > >  1 file changed, 6 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/README.md b/README.md
>> > > index e6f548e..8afb161 100644
>> > > --- a/README.md
>> > > +++ b/README.md
>> > > @@ -48,8 +48,12 @@ $ mtrace ./ptest-runner $MALLOC_TRACE
>> > >
>> > >  ## Contributions
>> > >
>> > > -For contribute please send a patch with subject prefix
>> "[ptest-runner]" to
>> > > -yocto@lists.yoctoproject.org.
>> > > +For contribute please send a patch with subject prefix
>> "[ptest-runner]" to
>> > > +yocto-patches@lists.yoctoproject.org.
>> > > +
>> > > +```
>> > > +git send-email --to=3Dyocto-patches@lists.yoctoproject.org --subjec=
t-prefix=3D'ptest-runner][PATCH'
>> ...
>> > > +```
>> >
>> > This looks good but we might also want to cc: Anibal on these so note
>> > that in there as well?
>>
>> Would be `--cc=3Danibal@limonsoftware.com` okay?
>>
>
> Yes I will add that to your patch, Thanks!,
> Anibal
> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#545)
> <https://lists.yoctoproject.org/g/yocto-patches/message/545> | Reply To
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5Bptest-runner%5D%5BPATCH%5D%20README%3A%20Update%20mailing%20l=
ist%20address%20for%20patches%20%2B%20add%20git%20command>
> | Reply To Sender
> <anibal@limonsoftware.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-pat=
ches%5D%20%5Bptest-runner%5D%5BPATCH%5D%20README%3A%20Update%20mailing%20li=
st%20address%20for%20patches%20%2B%20add%20git%20command>
> | Mute This Topic <https://lists.yoctoproject.org/mt/108017501/8181911> |=
 New
> Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/8181911> | Contac=
t
> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13235916/8181911/17=
931940/xyzzy>
> [anibal@limonsoftware.com]
> _._,_._,_
>
>

--000000000000ae3e3f062034538c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied!.</div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Wed, Aug 21, 2024 at 10:47=E2=80=AFAM Anibal L=
imon via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</=
a> &lt;anibal=3D<a href=3D"mailto:limonsoftware.com@lists.yoctoproject.org"=
>limonsoftware.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">=
<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Wed, Aug 21, 2024 at 10:34=E2=80=AFAM J=C3=B6rg Sommer &lt;<a href=
=3D"mailto:joerg.sommer@navimatix.de" target=3D"_blank">joerg.sommer@navima=
tix.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Richard Purdie schrieb am Mi 21. Aug, 16:44 (GMT):<br>
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


<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/545" targ=
et=3D"_blank">View/Reply Online (#545)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re=
%3A%20%5Byocto-patches%5D%20%5Bptest-runner%5D%5BPATCH%5D%20README%3A%20Upd=
ate%20mailing%20list%20address%20for%20patches%20%2B%20add%20git%20command"=
 target=3D"_blank">Reply To Group</a>
 =20
    | <a href=3D"mailto:anibal@limonsoftware.com?subject=3DPrivate:%20Re:%2=
0Re%3A%20%5Byocto-patches%5D%20%5Bptest-runner%5D%5BPATCH%5D%20README%3A%20=
Update%20mailing%20list%20address%20for%20patches%20%2B%20add%20git%20comma=
nd" target=3D"_blank">Reply To Sender</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/108017501/8181911" target=3D=
"_blank">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" target=3D=
"_blank">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/8181911" =
target=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank">Contact Group Owner</a> |

<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13235916/81=
81911/17931940/xyzzy" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:anibal@limonsoftware.com" target=3D"_blank">anibal@limo=
nsoftware.com</a>]<br>
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></blockquote></div>

--000000000000ae3e3f062034538c--

