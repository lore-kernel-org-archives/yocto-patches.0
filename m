Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8CECAC5B9
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 01:16:36 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.14877.1759194994473812940
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 18:16:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=EKqjOP0b;
 spf=pass (domain: mvista.com, ip: 209.85.208.50, mailfrom: vanusuri@mvista.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-636688550c0so76639a12.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1759194992; x=1759799792; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I6qB9XUg8q4A0OFEKahXNCUkii4UPGZg2Hzeqi9WxpY=;
        b=EKqjOP0b4DOazxTtOVyJNGbhYcyq/aFKPFSZsWFl92IyMcHIG6X49cCyBzUNX1EAVD
         R6Bfq+vtqceIFx22SXGLcZljJYzjoanCZVDnAphO91MzEgkkQGt4RltjMfm9efH7puSe
         QM+Qri1xoFJCLO1rbhl/VfsjfrasY5JXemquA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759194992; x=1759799792;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6qB9XUg8q4A0OFEKahXNCUkii4UPGZg2Hzeqi9WxpY=;
        b=NeFrOVaHeIKlPpfxj7dsM5tp25z8NrR3kSOJscjYqDZ8WjUrgGtr6cobKua6Sz70Es
         oQ3NvBHCIgNlf60nLAevTCCnt5Pi5luHqdwuYmPV4CNzXCmp0DrY3SdFNzxl7YSE9DKI
         SZ5wY3Zbet25c+5kStVyjHJ/7VQowwXWz0s5P+ZCO3YBjndd2czj78wbFr00XFYD3oaq
         70P25RaQq4PKq6lngvKpqJDD4AthK5tjdc4kVd6vpktjhK2atrBuTY4h6kw5QO6iziaf
         SM8BcV/3mAsE9GQHADqqT8vv4s0ICKeNndEStTV5xM2MhhL1J3/zqMYlRUgUJvCkrzyH
         W5fw==
X-Gm-Message-State: AOJu0Yzk529zl5HebNWDUnK53eH0lEj7zasEO1Vu2V1DQa9c78QMLb11
	rGT3ksI2F5IG0bvqDJ4AIAjiCvpw4DHB/TYFRTx1CZWYkW0jUh5TxHGedJrA/QqtTdKeTOvxBpu
	mr7qrx681utn1szjwSKjt4nsijLzmT/Hg8Cy3/+KR8Q==
X-Gm-Gg: ASbGncuH9t9yFC627BQr0ks+J5zo/fN/VBGyGoIXtf+h9ztK4OT9EcnRDI0x0RqNCIP
	Klg42t+HVTqzsH8IZ3H6wTCwFgOw7cb2lFXcvBz2pSNBe45A96PZKbVVEkq2j56xXKWUfndZRpN
	38IRBL2O/f2ed2Um4Uhwz67CFa1i+aio3bo0K9VkMMcL/G8vpuiCV6TrE+/F+B2h+rbFVkZbIO7
	f/Hn4k8ZJmJ0xdeL0yZkq+U4Wiu6ZAcx3Csj0+mFfmxkG1tYv5XXVNbSEG5Nd0=
X-Google-Smtp-Source: AGHT+IGNAYRY0SP+oH49MJtqRYc+e7f+SOM9Bj1neUsBsi/t0CoedmtzxxKhHBtOHBUehq2mkNmoWbX+rMZMkqtbzvc=
X-Received: by 2002:a17:907:9447:b0:b2d:28fd:c6bd with SMTP id
 a640c23a62f3a-b34ba450e21mr1921135166b.36.1759194992312; Mon, 29 Sep 2025
 18:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250929045007.12623-1-vanusuri@mvista.com> <20250929045007.12623-3-vanusuri@mvista.com>
 <CAMKF1spJZ6Y1XxG-86ROPPwbGp2gzyb0xX6R1H0hG0y0DRq4tg@mail.gmail.com>
In-Reply-To: <CAMKF1spJZ6Y1XxG-86ROPPwbGp2gzyb0xX6R1H0hG0y0DRq4tg@mail.gmail.com>
From: Vijay Anusuri <vanusuri@mvista.com>
Date: Tue, 30 Sep 2025 06:46:20 +0530
X-Gm-Features: AS18NWB7Ky8OtiStYlVye01MtEALgAJbrqefm1GeW5wrkjr_0n2XxXKB5krCdZk
Message-ID: <CANQUz1_H7qfd10auFPr4dBXvyCdGtsn9dgM+0fsWav3n=8VTeA@mail.gmail.com>
Subject: Re: [yocto-patches][meta-cgl][PATCH 3/3] ucarp: Fix the permissions
To: Khem Raj <raj.khem@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000009b9281063ffa80ec"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 01:16:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2254

--0000000000009b9281063ffa80ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Khem,

The Makefile.in.in file inside the po/ directory had read-only permissions =
(
0444), even for the file owner. During the build, the process attempted to
copy and overwrite this file but failed due to lack of write permissions.

I updated the permissions to grant write access so that the build process
could proceed successfully.

Below is the error snippet


| NOTE: List of Makefile.in.ins to update:
/home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/uca=
rp/1.5.2/sources/ucarp-1.5.2/po/
Makefile.in.in
| NOTE: Executing: cp
/home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/uca=
rp/1.5.2/recipe-sysroot-native/usr/share/gettext/po/
Makefile.in.in
/home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/uca=
rp/1.5.2/sources/ucarp-1.5.2/po/
| cp: cannot create regular file
'/home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-linux/uc=
arp/1.5.2/sources/ucarp-1.5.2/po/
Makefile.in.in': Permission denied

Thanks & Regards,
Vijay

On Tue, Sep 30, 2025 at 12:26=E2=80=AFAM Khem Raj <raj.khem@gmail.com> wrot=
e:

> On Sun, Sep 28, 2025 at 9:50=E2=80=AFPM Vijay Anusuri via
> lists.yoctoproject.org <vanusuri=3Dmvista.com@lists.yoctoproject.org>
> wrote:
> >
> > From: Vijay Anusuri <vanusuri@mvista.com>
> >
> > Gave write permission to po
> > List of Makefile.in.ins to update po/Makefile.in.in
> >
> > Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
> > ---
> >  meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> > index d221814..8a2737b 100644
> > --- a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> > +++ b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> > @@ -42,6 +42,10 @@ EXTRA_OECONF +=3D "--sysconfdir=3D${sysconfdir}/${BP=
N}"
> >  # fix the perms for config.rpath
> >  do_configure:prepend() {
> >      chmod 755 ${S}/config.rpath
> > +    # Make sure po directory is writable by current user
>
> Why should it be writable ?
>
> > +    if [ -d "${S}/po" ]; then
> > +        chmod -R u+rw ${S}/po
> > +    fi
> >  }
> >
> >  do_install:append() {
> > --
> > 2.25.1
> >
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#2248):
> https://lists.yoctoproject.org/g/yocto-patches/message/2248
> > Mute This Topic: https://lists.yoctoproject.org/mt/115490482/1997914
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/645=
821814/xyzzy
> [raj.khem@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >
>

--0000000000009b9281063ffa80ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Khem,<br><br><p>The <code><a href=3D"http://Makefile.in=
.in">Makefile.in.in</a></code> file inside the <code>po/</code> directory h=
ad read-only permissions (<code>0444</code>), even for the file owner. Duri=
ng the build, the process attempted to copy and overwrite this file but fai=
led due to lack of write permissions.</p>
<p>I updated the permissions to grant write access so that the build proces=
s could proceed successfully.<br><br></p><p>Below is the error snippet</p><=
p><br>| NOTE: List of Makefile.in.ins to update: /home/xxx/project/yocto_ma=
ster/poky/build/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5=
.2/po/<a href=3D"http://Makefile.in.in">Makefile.in.in</a><br>| NOTE: Execu=
ting: cp /home/xxx/project/yocto_master/poky/build/tmp/work/x86-64-v3-poky-=
linux/ucarp/1.5.2/recipe-sysroot-native/usr/share/gettext/po/<a href=3D"htt=
p://Makefile.in.in">Makefile.in.in</a> /home/xxx/project/yocto_master/poky/=
build/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.2/po/<br>=
| cp: cannot create regular file &#39;/home/xxx/project/yocto_master/poky/b=
uild/tmp/work/x86-64-v3-poky-linux/ucarp/1.5.2/sources/ucarp-1.5.2/po/<a hr=
ef=3D"http://Makefile.in.in">Makefile.in.in</a>&#39;: Permission denied</p>=
<div><br></div><div>Thanks &amp; Regards,<br></div><div>Vijay</div></div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Sep 30, 2025 at 12:26=E2=80=AFAM Khem Raj &lt;<a hr=
ef=3D"mailto:raj.khem@gmail.com">raj.khem@gmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On Sun, Sep 28, 2025 at =
9:50=E2=80=AFPM Vijay Anusuri via<br>
<a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer" target=3D"_bla=
nk">lists.yoctoproject.org</a> &lt;vanusuri=3D<a href=3D"mailto:mvista.com@=
lists.yoctoproject.org" target=3D"_blank">mvista.com@lists.yoctoproject.org=
</a>&gt;<br>
wrote:<br>
&gt;<br>
&gt; From: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mvista.com" target=
=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
&gt;<br>
&gt; Gave write permission to po<br>
&gt; List of Makefile.in.ins to update po/<a href=3D"http://Makefile.in.in"=
 rel=3D"noreferrer" target=3D"_blank">Makefile.in.in</a><br>
&gt;<br>
&gt; Signed-off-by: Vijay Anusuri &lt;<a href=3D"mailto:vanusuri@mvista.com=
" target=3D"_blank">vanusuri@mvista.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 meta-cgl-common/recipes-cgl/ucarp/<a href=3D"http://ucarp_1.5.2.=
bb" rel=3D"noreferrer" target=3D"_blank">ucarp_1.5.2.bb</a> | 4 ++++<br>
&gt;=C2=A0 1 file changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/meta-cgl-common/recipes-cgl/ucarp/<a href=3D"http://ucarp=
_1.5.2.bb" rel=3D"noreferrer" target=3D"_blank">ucarp_1.5.2.bb</a> b/meta-c=
gl-common/recipes-cgl/ucarp/<a href=3D"http://ucarp_1.5.2.bb" rel=3D"norefe=
rrer" target=3D"_blank">ucarp_1.5.2.bb</a><br>
&gt; index d221814..8a2737b 100644<br>
&gt; --- a/meta-cgl-common/recipes-cgl/ucarp/<a href=3D"http://ucarp_1.5.2.=
bb" rel=3D"noreferrer" target=3D"_blank">ucarp_1.5.2.bb</a><br>
&gt; +++ b/meta-cgl-common/recipes-cgl/ucarp/<a href=3D"http://ucarp_1.5.2.=
bb" rel=3D"noreferrer" target=3D"_blank">ucarp_1.5.2.bb</a><br>
&gt; @@ -42,6 +42,10 @@ EXTRA_OECONF +=3D &quot;--sysconfdir=3D${sysconfdir=
}/${BPN}&quot;<br>
&gt;=C2=A0 # fix the perms for config.rpath<br>
&gt;=C2=A0 do_configure:prepend() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 chmod 755 ${S}/config.rpath<br>
&gt; +=C2=A0 =C2=A0 # Make sure po directory is writable by current user<br=
>
<br>
Why should it be writable ?<br>
<br>
&gt; +=C2=A0 =C2=A0 if [ -d &quot;${S}/po&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 chmod -R u+rw ${S}/po<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 do_install:append() {<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#2248): <a href=3D"https://lists.yoctoproject.org/g=
/yocto-patches/message/2248" rel=3D"noreferrer" target=3D"_blank">https://l=
ists.yoctoproject.org/g/yocto-patches/message/2248</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/11549048=
2/1997914" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.=
org/mt/115490482/1997914</a><br>
&gt; Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoprojec=
t.org" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches=
/leave/13340786/1997914/645821814/xyzzy" rel=3D"noreferrer" target=3D"_blan=
k">https://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/64=
5821814/xyzzy</a> [<a href=3D"mailto:raj.khem@gmail.com" target=3D"_blank">=
raj.khem@gmail.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--0000000000009b9281063ffa80ec--

