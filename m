Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B8CCEF17D
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 14:26:22 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
 by mx.groups.io with SMTP id smtpd.web10.10587.1728397580141685839
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Oct 2024 07:26:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nFfvgSf3;
 spf=pass (domain: gmail.com, ip: 209.85.217.42, mailfrom: quaresma.jose@gmail.com)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4a3a8cef4d2so1682070137.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Oct 2024 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397579; x=1729002379; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=er7SQEGlDrvX68yYOI/PVq0AILm4H1wD87JlNghvcWs=;
        b=nFfvgSf3YVeW3s0MFGq3/twcSwXSM+TdTKfs79CZoTsSljYBU4ijGcN+vKqXrYAGVl
         Ws64Xy3CzOdFA/IQv0nwOLAzs4Sl8jAqioP3fLSCiJLfHg121JCtb+fMhSO0NrAPQJXu
         xqX5tGaZazBPK1kDJ1NzyrPMBV/ahcRqej9VsqmYv7LAGvCszGaV8J0MQA10HVa11cLu
         FYSKPlFggiHzBGVfx3CApFUufH2mL5bx7i1KMDU5SVDOzzVck4i5w2s6hrjgQiFSuYPV
         wEqO/sWGQ3GC2Di4CU466N9la0Gohp+SmJeA/xL7xnftnoJaUqJPUdlWnXtAKuyWsx4/
         5WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397579; x=1729002379;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er7SQEGlDrvX68yYOI/PVq0AILm4H1wD87JlNghvcWs=;
        b=Hbks5K0k36kid1fuSbyNGUa0G5kEeivHeGiIOEPVk1bjrdz/xjHkGC+2rpV4xhpwgi
         3VCYXhtAA41oZ+MwNtwURGye4EiJIBf6QvyZIVCBQzKlqebg0Jg9wV/zQSj4SYx0ajRy
         sQMFOOS3AVb1hVHgxZ5Wq6GuO03CzPtXDt3cn9KlNGjdY2xM0VqZn/cOagJJeRxIo3cI
         sBNFzfG8MIdzPy39qdF8p9PZ0WSNZ9uXACh4lS5JkanPrt3Yw/NVpJYA2JhDa+aIOl1r
         n08Hh7zNFR9hObrgnClTTd+IMVCGIISkVKNAx+ytdYXGC0OFELpXrjxiydNVibKd27vc
         bmLg==
X-Gm-Message-State: AOJu0YxmxHUojdfbNbUnKECxkCJ6xL6mcn6EcTf72WRGJmzERaLVawPV
	a7aWbScYzvxD7X0xir1oxGi0lwMtGBjVU4UdvBrisMa4DAJpH45mPcupE3BmtTKC4nk87MvCH+O
	8N0Ul3dpKv1ZYJSU1e8Ra8ODcA2hi5gXA
X-Google-Smtp-Source: AGHT+IGQ3juoyfVnjFFEbrgwSYqp/PtG4l8krVUWSGHXe1YshgrGXNqNWywQjnW+kRVspe5CQFmyc5VIk13kw9Djzqw=
X-Received: by 2002:a05:6102:4429:b0:4a3:a31c:4056 with SMTP id
 ada2fe7eead31-4a4058d51b0mr10107936137.21.1728397578907; Tue, 08 Oct 2024
 07:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <68FCFF96-C849-410C-A25F-3B797A817B67@dorumtech.no>
In-Reply-To: <68FCFF96-C849-410C-A25F-3B797A817B67@dorumtech.no>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Tue, 8 Oct 2024 15:26:07 +0100
Message-ID: <CANPvuR=MEiFrWp64iJo9Tcfq4ti6KQFKxYm-dCa7fPiBhPcMeQ@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH] meta-lts-mixins kirkstone/go: depend on
 -crosssdk recipes
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000b8b7900623f7ebbd"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Oct 2024 14:26:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/693

--000000000000b8b7900623f7ebbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

First of all, sorry for the delay.
This happened during my vacation and I didn't see it at the time or when I
came back later.

I mostly use this with clang and everything seems to work but I believe you
use gcc. I will test with the latter to see what happens.
Could you please describe the steps to reproduce your build problem?

Jose

Martin D=C3=B8rum via lists.yoctoproject.org <martin=3D
dorumtech.no@lists.yoctoproject.org> escreveu (segunda, 2/09/2024 =C3=A0(s)
12:57):

> The Go recipes failed to compile for me,
> because Bitbake said that the recipes
> virtual/${HOST_PREFIX}gcc and virtua/${HOST_PREFIX}binutils
> didn't exist.
> I took a look at how Poky does it, and Poky's Go recipes depend on
> virtual/${HOST_PREFIX}gcc-crosssdk and
> virtual/${HOST_PREFIX}binutils-crosssdk,
> so I changed the mixin recipes to reflect that.
>
> With these changes, the Go recipes compile on Kirkstone.
> ---
>  recipes-devtools/go/go-cross-canadian.inc | 2 +-
>  recipes-devtools/go/go-crosssdk.inc       | 2 +-
>  recipes-devtools/go/go-runtime.inc        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/recipes-devtools/go/go-cross-canadian.inc
> b/recipes-devtools/go/go-cross-canadian.inc
> index dd485b6..2c6ed29 100644
> --- a/recipes-devtools/go/go-cross-canadian.inc
> +++ b/recipes-devtools/go/go-cross-canadian.inc
> @@ -1,7 +1,7 @@
>  inherit cross-canadian
>
>  DEPENDS =3D "go-native virtual/${HOST_PREFIX}go
> virtual/nativesdk-${HOST_PREFIX}go-runtime \
> -           virtual/${HOST_PREFIX}gcc virtual/nativesdk-libc \
> +           virtual/${HOST_PREFIX}gcc-crosssdk virtual/nativesdk-libc \
>             virtual/nativesdk-${HOST_PREFIX}compilerlibs"
>  PN =3D "go-cross-canadian-${TRANSLATED_TARGET_ARCH}"
>
> diff --git a/recipes-devtools/go/go-crosssdk.inc
> b/recipes-devtools/go/go-crosssdk.inc
> index 1293900..61486a6 100644
> --- a/recipes-devtools/go/go-crosssdk.inc
> +++ b/recipes-devtools/go/go-crosssdk.inc
> @@ -1,6 +1,6 @@
>  inherit crosssdk
>
> -DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc
> virtual/nativesdk-${TARGET_PREFIX}compilerlibs
> virtual/${TARGET_PREFIX}binutils"
> +DEPENDS =3D "go-native virtual/${TARGET_PREFIX}gcc-crosssdk
> virtual/nativesdk-${TARGET_PREFIX}compilerlibs
> virtual/${TARGET_PREFIX}binutils-crosssdk"
>  PN =3D "go-crosssdk-${SDK_SYS}"
>  PROVIDES =3D "virtual/${TARGET_PREFIX}go"
>
> diff --git a/recipes-devtools/go/go-runtime.inc
> b/recipes-devtools/go/go-runtime.inc
> index 413cf6d..86539f2 100644
> --- a/recipes-devtools/go/go-runtime.inc
> +++ b/recipes-devtools/go/go-runtime.inc
> @@ -1,5 +1,5 @@
>  DEPENDS =3D "virtual/${TUNE_PKGARCH}-go go-native"
> -DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go"
> +DEPENDS:class-nativesdk =3D "virtual/${TARGET_PREFIX}go-crosssdk"
>  PROVIDES =3D "virtual/${TARGET_PREFIX}go-runtime"
>
>  DEBUG_PREFIX_MAP =3D "\
> --
> 2.46
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#609):
> https://lists.yoctoproject.org/g/yocto-patches/message/609
> Mute This Topic: https://lists.yoctoproject.org/mt/108225175/5052612
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/150=
4338242/xyzzy
> [quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000b8b7900623f7ebbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Martin,</div><div><br></div><div>First of all, sor=
ry for the delay.</div>This happened during my vacation and I didn&#39;t se=
e it at the time or when I came back later.<br><br>I mostly use this with c=
lang and everything seems to work but I believe you use gcc. I will test wi=
th the latter to see what happens.<br>Could you please describe the steps t=
o reproduce your build problem?<br><br>Jose<div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">Martin D=C3=B8rum via <a href=3D"=
http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;martin=3D<a h=
ref=3D"mailto:dorumtech.no@lists.yoctoproject.org">dorumtech.no@lists.yocto=
project.org</a>&gt; escreveu (segunda, 2/09/2024 =C3=A0(s) 12:57):<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">The Go recipes failed to=
 compile for me,<br>
because Bitbake said that the recipes<br>
virtual/${HOST_PREFIX}gcc and virtua/${HOST_PREFIX}binutils<br>
didn&#39;t exist.<br>
I took a look at how Poky does it, and Poky&#39;s Go recipes depend on<br>
virtual/${HOST_PREFIX}gcc-crosssdk and<br>
virtual/${HOST_PREFIX}binutils-crosssdk,<br>
so I changed the mixin recipes to reflect that.<br>
<br>
With these changes, the Go recipes compile on Kirkstone.<br>
---<br>
=C2=A0recipes-devtools/go/go-cross-canadian.inc | 2 +-<br>
=C2=A0recipes-devtools/go/go-crosssdk.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
=C2=A0recipes-devtools/go/go-runtime.inc=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<=
br>
=C2=A03 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/recipes-devtools/go/go-cross-canadian.inc b/recipes-devtools/g=
o/go-cross-canadian.inc<br>
index dd485b6..2c6ed29 100644<br>
--- a/recipes-devtools/go/go-cross-canadian.inc<br>
+++ b/recipes-devtools/go/go-cross-canadian.inc<br>
@@ -1,7 +1,7 @@<br>
=C2=A0inherit cross-canadian<br>
<br>
=C2=A0DEPENDS =3D &quot;go-native virtual/${HOST_PREFIX}go virtual/nativesd=
k-${HOST_PREFIX}go-runtime \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtual/${HOST_PREFIX}gcc virtual=
/nativesdk-libc \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtual/${HOST_PREFIX}gcc-crosssd=
k virtual/nativesdk-libc \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtual/nativesdk-${HOST_PREFIX}c=
ompilerlibs&quot;<br>
=C2=A0PN =3D &quot;go-cross-canadian-${TRANSLATED_TARGET_ARCH}&quot;<br>
<br>
diff --git a/recipes-devtools/go/go-crosssdk.inc b/recipes-devtools/go/go-c=
rosssdk.inc<br>
index 1293900..61486a6 100644<br>
--- a/recipes-devtools/go/go-crosssdk.inc<br>
+++ b/recipes-devtools/go/go-crosssdk.inc<br>
@@ -1,6 +1,6 @@<br>
=C2=A0inherit crosssdk<br>
<br>
-DEPENDS =3D &quot;go-native virtual/${TARGET_PREFIX}gcc virtual/nativesdk-=
${TARGET_PREFIX}compilerlibs virtual/${TARGET_PREFIX}binutils&quot;<br>
+DEPENDS =3D &quot;go-native virtual/${TARGET_PREFIX}gcc-crosssdk virtual/n=
ativesdk-${TARGET_PREFIX}compilerlibs virtual/${TARGET_PREFIX}binutils-cros=
ssdk&quot;<br>
=C2=A0PN =3D &quot;go-crosssdk-${SDK_SYS}&quot;<br>
=C2=A0PROVIDES =3D &quot;virtual/${TARGET_PREFIX}go&quot;<br>
<br>
diff --git a/recipes-devtools/go/go-runtime.inc b/recipes-devtools/go/go-ru=
ntime.inc<br>
index 413cf6d..86539f2 100644<br>
--- a/recipes-devtools/go/go-runtime.inc<br>
+++ b/recipes-devtools/go/go-runtime.inc<br>
@@ -1,5 +1,5 @@<br>
=C2=A0DEPENDS =3D &quot;virtual/${TUNE_PKGARCH}-go go-native&quot;<br>
-DEPENDS:class-nativesdk =3D &quot;virtual/${TARGET_PREFIX}go&quot;<br>
+DEPENDS:class-nativesdk =3D &quot;virtual/${TARGET_PREFIX}go-crosssdk&quot=
;<br>
=C2=A0PROVIDES =3D &quot;virtual/${TARGET_PREFIX}go-runtime&quot;<br>
<br>
=C2=A0DEBUG_PREFIX_MAP =3D &quot;\<br>
--<br>
2.46<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#609): <a href=3D"https://lists.yoctoproject.org/g/yocto=
-patches/message/609" rel=3D"noreferrer" target=3D"_blank">https://lists.yo=
ctoproject.org/g/yocto-patches/message/609</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/108225175/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/108225175/5052612</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13170708/5052612/1504338242/xyzzy" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/150433=
8242/xyzzy</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank=
">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div></div>

--000000000000b8b7900623f7ebbd--

