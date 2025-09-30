Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C94CAC5B0
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 03:37:17 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.17008.1759203427181286989
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 20:37:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=MC+FOhjo;
 spf=pass (domain: mvista.com, ip: 209.85.208.49, mailfrom: vanusuri@mvista.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so10781592a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 20:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1759203425; x=1759808225; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EUW9j9LYcNOoNtGxiHagPtTW9Kh0DHCUfkofTE+eyzw=;
        b=MC+FOhjoPTp1LnqpRrzvjwxRW2kUVVjKhc0H0fTljkDXwKmXOijhj3+jM06uuEhLFE
         MObRSSPOr9FdTyVgs8JGLdLws67lbNC1imzPNjSEiuRcimrSS308iF8ZMMgNxRUmw6eb
         PSkEkOsIEz5riGvmWqIqYNKSSvR5e3dQZXbz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759203425; x=1759808225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUW9j9LYcNOoNtGxiHagPtTW9Kh0DHCUfkofTE+eyzw=;
        b=dT/tDLx4rnhdOMY1jia3zRXjx9LJU5ErXBvbofFAAdf+drYuM9sLDiLV3Jjp4YaalZ
         C95qpbA0PmHYzVYf1zBJeREdsTy/reeAWmxVckfLqt8ZJDq9u4kPr5knDUlT/a9bDCLY
         gvJ+NEe9mgntIij4qd5eK0OewxN9goBzoDtKsS63WgTgd0dsoiArg90ZD2k/5EIXoKR7
         b+D7+q47SXoNGmzY5qxwkrhatACHYzlRqvFwoYNkuSPCW3GockcjRE5M7phUsDjftyf3
         2iok0Oja4AJRmx29+VHvnxV3Ai0U+It9X0VV0yP3UdrG8fecZiWTZn63aJR8GHRILDS2
         LqxQ==
X-Gm-Message-State: AOJu0Yzqm2m4OaBUlIhi9482tn2lxnvY1F+uATaSlB680cu7MPl9r/l/
	T/3280pLGhTcXaHLKh5wG14x0/wXzylSqNSg03mhP4eq3Lf64oA6ifmfsDAZWkwFIirUzADVZNA
	oxWO/sZWSfyfvQppegAnHUtNEPCNgNaziGsx5qlwM4Q==
X-Gm-Gg: ASbGncvLMc1R6+KzEWpcDq1arW846EDoWON2xk9m4lLi6swj0vSfiiPl8PxyqY6XDc8
	B6wkN4+z1l5ArLkwi+4P4tfiWxElzoTA5kSl4P1qopoM/ZGiFhL7GsS3tH5A1N9RZN+AiHgM/jj
	Qw703zzb7pVv4AC00VuGVQrXvn7qprJ9RChQrHH0pK8fnT6/mQL342v123SdY8ZIecx23SZKZ7i
	4c00a7Vx/txuWUNG0xLFsZsx1/8dw1nEVg1WqokFUp+wrwrEKlpe3nLIYa88sQLgaMSsbDSn6vl
X-Google-Smtp-Source: AGHT+IFoa4nuX7FZnX4gZ6VeOGRJZLLUSgeAAh5rVXkVcY6u94KU4/yLIhSFqbZsZXPsWyCkmcLZjK9Opgt3NtehFvM=
X-Received: by 2002:a17:907:7fa5:b0:b40:a71b:152e with SMTP id
 a640c23a62f3a-b40a71b1703mr393518466b.40.1759203425371; Mon, 29 Sep 2025
 20:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250929045007.12623-1-vanusuri@mvista.com> <20250929045007.12623-3-vanusuri@mvista.com>
 <CAMKF1spJZ6Y1XxG-86ROPPwbGp2gzyb0xX6R1H0hG0y0DRq4tg@mail.gmail.com>
 <CANQUz1_H7qfd10auFPr4dBXvyCdGtsn9dgM+0fsWav3n=8VTeA@mail.gmail.com> <CAMKF1srK7AZFg36EJ8W8Ti-VcxznC3f_p4RzBHxLq0Z9uEtT-w@mail.gmail.com>
In-Reply-To: <CAMKF1srK7AZFg36EJ8W8Ti-VcxznC3f_p4RzBHxLq0Z9uEtT-w@mail.gmail.com>
From: Vijay Anusuri <vanusuri@mvista.com>
Date: Tue, 30 Sep 2025 09:06:53 +0530
X-Gm-Features: AS18NWDhJ8TbyX3tXLHwop0d2-SrzCvN9t2B4yaNB6M1sKj2sdLxyqW0xrD9H9A
Message-ID: <CANQUz1_16qWLDrqBrrSCa=LHwUVHaHRQs+SAySHumbj+hoSqQg@mail.gmail.com>
Subject: Re: [yocto-patches][meta-cgl][PATCH 3/3] ucarp: Fix the permissions
To: Khem Raj <raj.khem@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000041db03063ffc77b7"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 03:37:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2256

--00000000000041db03063ffc77b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure. I will update the commit message and send out a v2 patch.

On Tue, Sep 30, 2025 at 8:29=E2=80=AFAM Khem Raj <raj.khem@gmail.com> wrote=
:

> On Mon, Sep 29, 2025 at 6:16=E2=80=AFPM Vijay Anusuri <vanusuri@mvista.co=
m> wrote:
> >
> > Hi Khem,
> >
> > The Makefile.in.in file inside the po/ directory had read-only
> permissions (0444), even for the file owner. During the build, the proces=
s
> attempted to copy and overwrite this file but failed due to lack of write
> permissions.
> >
> > I updated the permissions to grant write access so that the build
> process could proceed successfully.
> >
> > Below is the error snippet
> >
> >
> > | NOTE: List of Makefile.in.ins to update:
> /home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/u=
carp/1.5.2/sources/ucarp-1.5.2/po/
> Makefile.in.in
> > | NOTE: Executing: cp
> /home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/u=
carp/1.5.2/recipe-sysroot-native/usr/share/gettext/po/
> Makefile.in.in
> /home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/u=
carp/1.5.2/sources/ucarp-1.5.2/po/
> > | cp: cannot create regular file
> '/home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/=
ucarp/1.5.2/sources/ucarp-1.5.2/po/
> Makefile.in.in': Permission denied
> >
>
> Good. It will be nice to add this context in the commit message.
>
> >
> > Thanks & Regards,
> > Vijay
> >
> > On Tue, Sep 30, 2025 at 12:26=E2=80=AFAM Khem Raj <raj.khem@gmail.com> =
wrote:
> >>
> >> On Sun, Sep 28, 2025 at 9:50=E2=80=AFPM Vijay Anusuri via
> >> lists.yoctoproject.org <vanusuri=3Dmvista.com@lists.yoctoproject.org>
> >> wrote:
> >> >
> >> > From: Vijay Anusuri <vanusuri@mvista.com>
> >> >
> >> > Gave write permission to po
> >> > List of Makefile.in.ins to update po/Makefile.in.in
> >> >
> >> > Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
> >> > ---
> >> >  meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> >> > index d221814..8a2737b 100644
> >> > --- a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> >> > +++ b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> >> > @@ -42,6 +42,10 @@ EXTRA_OECONF +=3D "--sysconfdir=3D${sysconfdir}/$=
{BPN}"
> >> >  # fix the perms for config.rpath
> >> >  do_configure:prepend() {
> >> >      chmod 755 ${S}/config.rpath
> >> > +    # Make sure po directory is writable by current user
> >>
> >> Why should it be writable ?
> >>
> >> > +    if [ -d "${S}/po" ]; then
> >> > +        chmod -R u+rw ${S}/po
> >> > +    fi
> >> >  }
> >> >
> >> >  do_install:append() {
> >> > --
> >> > 2.25.1
> >> >
> >> >
> >> >
> >> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >> > Links: You receive all messages sent to this group.
> >> > View/Reply Online (#2248):
> https://lists.yoctoproject.org/g/yocto-patches/message/2248
> >> > Mute This Topic: https://lists.yoctoproject.org/mt/115490482/1997914
> >> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> >> > Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/645=
821814/xyzzy
> [raj.khem@gmail.com]
> >> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >> >
> >> >
>

--00000000000041db03063ffc77b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sure. I will update the commit message and send out a=
 v2 patch.</div></div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 30, 2025 at 8:29=E2=80=AF=
AM Khem Raj &lt;<a href=3D"mailto:raj.khem@gmail.com">raj.khem@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Mon, Sep 29, 2025 at 6:16=E2=80=AFPM Vijay Anusuri &lt;<a href=3D"mailto:va=
nusuri@mvista.com" target=3D"_blank">vanusuri@mvista.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Khem,<br>
&gt;<br>
&gt; The <a href=3D"http://Makefile.in.in" rel=3D"noreferrer" target=3D"_bl=
ank">Makefile.in.in</a> file inside the po/ directory had read-only permiss=
ions (0444), even for the file owner. During the build, the process attempt=
ed to copy and overwrite this file but failed due to lack of write permissi=
ons.<br>
&gt;<br>
&gt; I updated the permissions to grant write access so that the build proc=
ess could proceed successfully.<br>
&gt;<br>
&gt; Below is the error snippet<br>
&gt;<br>
&gt;<br>
&gt; | NOTE: List of Makefile.in.ins to update: /home/xxx/project/yocto_mas=
ter/poky/build/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.=
2/po/<a href=3D"http://Makefile.in.in" rel=3D"noreferrer" target=3D"_blank"=
>Makefile.in.in</a><br>
&gt; | NOTE: Executing: cp /home/xxx/project/yocto_master/poky/build/tmp/wo=
rk/x86-64-v3-poky-linux/ucarp/1.5.2/recipe-sysroot-native/usr/share/gettext=
/po/<a href=3D"http://Makefile.in.in" rel=3D"noreferrer" target=3D"_blank">=
Makefile.in.in</a> /home/xxx/project/yocto_master/poky/build/tmp/work/x86-6=
4-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.2/po/<br>
&gt; | cp: cannot create regular file &#39;/home/xxx/project/yocto_master/p=
oky/build/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.2/po/=
<a href=3D"http://Makefile.in.in" rel=3D"noreferrer" target=3D"_blank">Make=
file.in.in</a>&#39;: Permission denied<br>
&gt;<br>
<br>
Good. It will be nice to add this context in the commit message.<br>
<br>
&gt;<br>
&gt; Thanks &amp; Regards,<br>
&gt; Vijay<br>
&gt;<br>
&gt; On Tue, Sep 30, 2025 at 12:26=E2=80=AFAM Khem Raj &lt;<a href=3D"mailt=
o:raj.khem@gmail.com" target=3D"_blank">raj.khem@gmail.com</a>&gt; wrote:<b=
r>
&gt;&gt;<br>
&gt;&gt; On Sun, Sep 28, 2025 at 9:50=E2=80=AFPM Vijay Anusuri via<br>
&gt;&gt; <a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer" targe=
t=3D"_blank">lists.yoctoproject.org</a> &lt;vanusuri=3D<a href=3D"mailto:mv=
ista.com@lists.yoctoproject.org" target=3D"_blank">mvista.com@lists.yoctopr=
oject.org</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; From: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mvista.com=
" target=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Gave write permission to po<br>
&gt;&gt; &gt; List of Makefile.in.ins to update po/<a href=3D"http://Makefi=
le.in.in" rel=3D"noreferrer" target=3D"_blank">Makefile.in.in</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@m=
vista.com" target=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 meta-cgl-common/recipes-cgl/ucarp/<a href=3D"http://uca=
rp_1.5.2.bb" rel=3D"noreferrer" target=3D"_blank">ucarp_1.5.2.bb</a> | 4 ++=
++<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/meta-cgl-common/recipes-cgl/ucarp/<a href=3D"htt=
p://ucarp_1.5.2.bb" rel=3D"noreferrer" target=3D"_blank">ucarp_1.5.2.bb</a>=
 b/meta-cgl-common/recipes-cgl/ucarp/<a href=3D"http://ucarp_1.5.2.bb" rel=
=3D"noreferrer" target=3D"_blank">ucarp_1.5.2.bb</a><br>
&gt;&gt; &gt; index d221814..8a2737b 100644<br>
&gt;&gt; &gt; --- a/meta-cgl-common/recipes-cgl/ucarp/<a href=3D"http://uca=
rp_1.5.2.bb" rel=3D"noreferrer" target=3D"_blank">ucarp_1.5.2.bb</a><br>
&gt;&gt; &gt; +++ b/meta-cgl-common/recipes-cgl/ucarp/<a href=3D"http://uca=
rp_1.5.2.bb" rel=3D"noreferrer" target=3D"_blank">ucarp_1.5.2.bb</a><br>
&gt;&gt; &gt; @@ -42,6 +42,10 @@ EXTRA_OECONF +=3D &quot;--sysconfdir=3D${s=
ysconfdir}/${BPN}&quot;<br>
&gt;&gt; &gt;=C2=A0 # fix the perms for config.rpath<br>
&gt;&gt; &gt;=C2=A0 do_configure:prepend() {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 chmod 755 ${S}/config.rpath<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 # Make sure po directory is writable by curren=
t user<br>
&gt;&gt;<br>
&gt;&gt; Why should it be writable ?<br>
&gt;&gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 if [ -d &quot;${S}/po&quot; ]; then<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 chmod -R u+rw ${S}/po<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 fi<br>
&gt;&gt; &gt;=C2=A0 }<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 do_install:append() {<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; 2.25.1<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;&gt; &gt; Links: You receive all messages sent to this group.<br>
&gt;&gt; &gt; View/Reply Online (#2248): <a href=3D"https://lists.yoctoproj=
ect.org/g/yocto-patches/message/2248" rel=3D"noreferrer" target=3D"_blank">=
https://lists.yoctoproject.org/g/yocto-patches/message/2248</a><br>
&gt;&gt; &gt; Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt=
/115490482/1997914" rel=3D"noreferrer" target=3D"_blank">https://lists.yoct=
oproject.org/mt/115490482/1997914</a><br>
&gt;&gt; &gt; Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yo=
ctoproject.org" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.or=
g</a><br>
&gt;&gt; &gt; Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/leave/13340786/1997914/645821814/xyzzy" rel=3D"noreferrer" target=
=3D"_blank">https://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1=
997914/645821814/xyzzy</a> [<a href=3D"mailto:raj.khem@gmail.com" target=3D=
"_blank">raj.khem@gmail.com</a>]<br>
&gt;&gt; &gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
</blockquote></div>

--00000000000041db03063ffc77b7--

