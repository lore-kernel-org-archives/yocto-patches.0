Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456BFC87FCB
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 15:49:32 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
 by mx.groups.io with SMTP id smtpd.web10.38879.1753890562678934592
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Jul 2025 08:49:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fADsZ9hI;
 spf=pass (domain: gmail.com, ip: 209.85.222.46, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87f04817bf6so870241.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Jul 2025 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753890561; x=1754495361; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ydxlW4qYrC9zXVe7+w8/oZAXTKSJz0ZDdLVZ1zn0M50=;
        b=fADsZ9hI8Do3gFHhQbiO0W9a61p/jOfvuIz5RGTy8HFIgmNmLY1LsLUSZ8PLsWVdTQ
         yxbPLx6+u0esNlli8vxMPcDtV8HGrLlKUHG0HlQP+p4tUUNgWYUov6pahWmQ+SguR6hi
         MRvkI3Oin1AZUA05ddLoiWdL9BTr+MCEnj7kzne7nBmxKChA6Ws6UlH8C1jtVfMjij8J
         CWgfiuGBgXBQ3MP/r12ilZur4YG1i4S4SM3FoluPv2FlXEDaP6knhHifzhxTaK4q8JRF
         PWPrsoCTN7eiHREXqkEkmA+KXtR15JkDZRhRRj5jG5bDoIY5hX8bbse57zMFj4HfQS5N
         3SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753890561; x=1754495361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydxlW4qYrC9zXVe7+w8/oZAXTKSJz0ZDdLVZ1zn0M50=;
        b=ty9GWYDIAxqdbztYU2EbLJbuOCv11PhaCIKxHfXx6//eGd+ezrnF7hztN5IQS8+x2l
         tBis1ZoS0Y/ouC7cQkv14lsIvfKfkGq7n38EmI67njG9ihEJ3SL5vAQ810w4uWSbvtpx
         8YuiTHaXVI+txU4FPfkypPuhhmMjlKuN9CLFe0oXBdHn4IxVwx5/wwWe/rqerdACrszI
         46CreWh/PgeI0p2v9KoSo0IATGLHHEV0emv89CMx1ayIHnJAG7YMMI5iaeaL2nFtFXhn
         b+5dfFuSa8mF7/Z3geFsS9hTP5njaR12YBuVWzhSanqkeNtXKtGOEVa8HmLiUtVBlPIq
         Y1jA==
X-Gm-Message-State: AOJu0Yyt2u30IkWQhD88gbgotZ51tPqnAsseuSL1OyfKpAKgVQ276lLU
	/b53LPhbP1NNtCv/H2Hy0YUc/FmrXyuHxExZNCNy+wagPTSsVlHCEXJz8X3E9KcvAPvfKAlS3t9
	QZ3mxbNgm7mLOHcCSabpbePOworz5K8N5rGp0
X-Gm-Gg: ASbGncs/wKJ8s0VLSW9Y3OCYypAGp7o7zpfydBHdHK6dRkEyMeTkx2VsO9WqEix8mHS
	usm5HRPCgpESToEPzCdjZkCss/xTtTrYFOrllVrzKHijkaRXYnT2xN6RYEpgLx4tw+7tH4naXj3
	Js3feVe7GzR1Q4bH/AgTnUFy0vwQK00uF7JWS3M2pyKrNXwlh7Pi6ZwfphwpCClEoubJ40J7Qu6
	hQ/E+Xp
X-Google-Smtp-Source: AGHT+IGfRNREJQsOyHGQnzxIh0iAI6zt/k/IjGaxyDU936+X0Bg/9CfeEW7ypiObQop1sRI46ZCsHMrhAK2Eh5o9On8=
X-Received: by 2002:a05:6102:6106:20b0:4fb:f15c:2e39 with SMTP id
 ada2fe7eead31-4fbf15c4105mr1069342137.24.1753890561083; Wed, 30 Jul 2025
 08:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250718162835.8822-1-peter.marko@siemens.com>
In-Reply-To: <20250718162835.8822-1-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 30 Jul 2025 16:49:10 +0100
X-Gm-Features: Ac12FXwH5kgbaanRTgIFYPhRW31ZuJtOixEN8KEf9sFSIVOoC3UeE_CFDtycVRw
Message-ID: <CANPvuRkhVY+-HghpenT_KfEtYddfBW0yuh=-2xcyDDjnMDmD8A@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go:
 upgrade 1.24.4 -> 1.24.5
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io, Peter Marko <peter.marko@siemens.com>
Content-Type: multipart/alternative; boundary="000000000000de5005063b277725"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Jul 2025 15:49:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1877

--000000000000de5005063b277725
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Applied! Sorry for the delay but I was away for a while.

Jose

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (sexta, 18/07/2025 =C3=A0(s) 1=
7:29):

> From: Peter Marko <peter.marko@siemens.com>
>
> Upgrade to latest 1.24.x release [1]:
>
> $ git --no-pager log --oneline go1.24.4..go1.24.5
> 9d828e80fa (tag: go1.24.5) [release-branch.go1.24] go1.24.5
> 825eeee3f7 [release-branch.go1.24] cmd/go: disable support for multiple
> vcs in one module
> dbf30d88f3 [release-branch.go1.24] cmd/link: permit a larger size BSS
> reference to a smaller DATA symbol
> 6b51660c8c [release-branch.go1.24] runtime: set mspan limit field early
> and eagerly
> cc604130c8 [release-branch.go1.24] runtime: prevent mutual deadlock
> between GC stopTheWorld and suspendG
> 21b488bb60 [release-branch.go1.24] runtime: handle system goroutines late=
r
> in goroutine profiling
> e038690847 [release-branch.go1.24] cmd/go/internal/fips140: ignore
> GOEXPERIMENT on error
> 1575127ef8 [release-branch.go1.24] runtime: add missing unlock in
> sysReserveAlignedSbrk
> 7d08a16fba [release-branch.go1.24] cmd/compile/internal/ssa: fix PPC64
> merging of (AND (S[RL]Dconst ...)
> 5f2cbe1f64 [release-branch.go1.24] cmd/compile: do nil check before
> calling duff functions, on arm64 and amd64
>
> Fixes CVE-2025-4674 [2].
>
> [1] https://github.com/golang/go/compare/go1.24.4...go1.24.5
> [2] https://groups.google.com/g/golang-announce/c/gTNJnDXmn34
>
> (From OE-Core rev: a3cc5038ea10a4857627e6f4de25bdc43023a349)
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  recipes-devtools/go/{go-1.24.4.inc =3D> go-1.24.5.inc}        | 2 +-
>  ...o-binary-native_1.24.4.bb =3D> go-binary-native_1.24.5.bb} | 6 +++---
>  ...cross-canadian_1.24.4.bb =3D> go-cross-canadian_1.24.5.bb} | 0
>  .../go/{go-cross_1.24.4.bb =3D> go-cross_1.24.5.bb}           | 0
>  .../go/{go-crosssdk_1.24.4.bb =3D> go-crosssdk_1.24.5.bb}     | 0
>  .../go/{go-runtime_1.24.4.bb =3D> go-runtime_1.24.5.bb}       | 0
>  recipes-devtools/go/{go_1.24.4.bb =3D> go_1.24.5.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.24.4.inc =3D> go-1.24.5.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.24.4.bb =3D>
> go-binary-native_1.24.5.bb} (79%)
>  rename recipes-devtools/go/{go-cross-canadian_1.24.4.bb =3D>
> go-cross-canadian_1.24.5.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.24.4.bb =3D> go-cross_1.24.5.bb}
> (100%)
>  rename recipes-devtools/go/{go-crosssdk_1.24.4.bb =3D>
> go-crosssdk_1.24.5.bb} (100%)
>  rename recipes-devtools/go/{go-runtime_1.24.4.bb =3D> go-runtime_1.24.5.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.24.4.bb =3D> go_1.24.5.bb} (100%)
>
> diff --git a/recipes-devtools/go/go-1.24.4.inc
> b/recipes-devtools/go/go-1.24.5.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.24.4.inc
> rename to recipes-devtools/go/go-1.24.5.inc
> index eff3f2f..fae0d3f 100644
> --- a/recipes-devtools/go/go-1.24.4.inc
> +++ b/recipes-devtools/go/go-1.24.5.inc
> @@ -17,4 +17,4 @@ SRC_URI +=3D "\
>
>  file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
>      file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "5a86a83a31f9fa81490b8c5420ac384fd3d95a3e71fba665c7b3f95d1dfef2b4"
> +SRC_URI[main.sha256sum] =3D
> "74fdb09f2352e2b25b7943e56836c9b47363d28dec1c8b56c4a9570f30b8f59f"
> diff --git a/recipes-devtools/go/go-binary-native_1.24.4.bb
> b/recipes-devtools/go/go-binary-native_1.24.5.bb
> similarity index 79%
> rename from recipes-devtools/go/go-binary-native_1.24.4.bb
> rename to recipes-devtools/go/go-binary-native_1.24.5.bb
> index d1f8fc6..5002686 100644
> --- a/recipes-devtools/go/go-binary-native_1.24.4.bb
> +++ b/recipes-devtools/go/go-binary-native_1.24.5.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "
> https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;nam=
e=3Dgo_${BUILD_GOTUPLE}
> "
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "77e5da33bb72aeaef1ba4418b6fe511bc4d041873cbf82e5aa6318740df98717"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "d5501ee5aca0f258d5fe9bfaed401958445014495dc115f202d43d5210b45241"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "9ca4afef813a2578c23843b640ae0290aa54b2e3c950a6cc4c99e16a57dec2ec"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "10ad9e86233e74c0f6590fe5426895de6bf388964210eac34a6d83f38918ecdc"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "0df02e6aeb3d3c06c95ff201d575907c736d6c62cfa4b6934c11203f1d600ffa"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "00bdfb16d1094e78473b681d2d09d42c19c886d4dfed743853769f1665c7a552"
>
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.24.4.bb
> b/recipes-devtools/go/go-cross-canadian_1.24.5.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.24.4.bb
> rename to recipes-devtools/go/go-cross-canadian_1.24.5.bb
> diff --git a/recipes-devtools/go/go-cross_1.24.4.bb b/recipes-devtools/go=
/
> go-cross_1.24.5.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.24.4.bb
> rename to recipes-devtools/go/go-cross_1.24.5.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.24.4.bb
> b/recipes-devtools/go/go-crosssdk_1.24.5.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.24.4.bb
> rename to recipes-devtools/go/go-crosssdk_1.24.5.bb
> diff --git a/recipes-devtools/go/go-runtime_1.24.4.bb
> b/recipes-devtools/go/go-runtime_1.24.5.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.24.4.bb
> rename to recipes-devtools/go/go-runtime_1.24.5.bb
> diff --git a/recipes-devtools/go/go_1.24.4.bb b/recipes-devtools/go/
> go_1.24.5.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.24.4.bb
> rename to recipes-devtools/go/go_1.24.5.bb
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1816):
> https://lists.yoctoproject.org/g/yocto-patches/message/1816
> Mute This Topic: https://lists.yoctoproject.org/mt/114223918/5052612
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

--000000000000de5005063b277725
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Peter,</div><div><br></div>Applied! Sorry for the =
delay but I was away for a while.<div><div><br></div>Jose</div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">Peter Marko via <a href=3D"http://lists.yoctoproject.org">lists.yoctopr=
oject.org</a> &lt;peter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctopr=
oject.org">siemens.com@lists.yoctoproject.org</a>&gt; escreveu (sexta, 18/0=
7/2025 =C3=A0(s) 17:29):<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com"=
 target=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
<br>
Upgrade to latest 1.24.x release [1]:<br>
<br>
$ git --no-pager log --oneline go1.24.4..go1.24.5<br>
9d828e80fa (tag: go1.24.5) [release-branch.go1.24] go1.24.5<br>
825eeee3f7 [release-branch.go1.24] cmd/go: disable support for multiple vcs=
 in one module<br>
dbf30d88f3 [release-branch.go1.24] cmd/link: permit a larger size BSS refer=
ence to a smaller DATA symbol<br>
6b51660c8c [release-branch.go1.24] runtime: set mspan limit field early and=
 eagerly<br>
cc604130c8 [release-branch.go1.24] runtime: prevent mutual deadlock between=
 GC stopTheWorld and suspendG<br>
21b488bb60 [release-branch.go1.24] runtime: handle system goroutines later =
in goroutine profiling<br>
e038690847 [release-branch.go1.24] cmd/go/internal/fips140: ignore GOEXPERI=
MENT on error<br>
1575127ef8 [release-branch.go1.24] runtime: add missing unlock in sysReserv=
eAlignedSbrk<br>
7d08a16fba [release-branch.go1.24] cmd/compile/internal/ssa: fix PPC64 merg=
ing of (AND (S[RL]Dconst ...)<br>
5f2cbe1f64 [release-branch.go1.24] cmd/compile: do nil check before calling=
 duff functions, on arm64 and amd64<br>
<br>
Fixes CVE-2025-4674 [2].<br>
<br>
[1] <a href=3D"https://github.com/golang/go/compare/go1.24.4...go1.24.5" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/golang/go/compare/go1=
.24.4...go1.24.5</a><br>
[2] <a href=3D"https://groups.google.com/g/golang-announce/c/gTNJnDXmn34" r=
el=3D"noreferrer" target=3D"_blank">https://groups.google.com/g/golang-anno=
unce/c/gTNJnDXmn34</a><br>
<br>
(From OE-Core rev: a3cc5038ea10a4857627e6f4de25bdc43023a349)<br>
<br>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
Signed-off-by: Mathieu Dubois-Briand &lt;<a href=3D"mailto:mathieu.dubois-b=
riand@bootlin.com" target=3D"_blank">mathieu.dubois-briand@bootlin.com</a>&=
gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0recipes-devtools/go/{go-1.24.4.inc =3D&gt; go-1.24.5.inc}=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0...<a href=3D"http://o-binary-native_1.24.4.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">o-binary-native_1.24.4.bb</a> =3D&gt; <a href=3D"http://go-=
binary-native_1.24.5.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-nat=
ive_1.24.5.bb</a>} | 6 +++---<br>
=C2=A0...<a href=3D"http://cross-canadian_1.24.4.bb" rel=3D"noreferrer" tar=
get=3D"_blank">cross-canadian_1.24.4.bb</a> =3D&gt; <a href=3D"http://go-cr=
oss-canadian_1.24.5.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canad=
ian_1.24.5.bb</a>} | 0<br>
=C2=A0.../go/{<a href=3D"http://go-cross_1.24.4.bb" rel=3D"noreferrer" targ=
et=3D"_blank">go-cross_1.24.4.bb</a> =3D&gt; <a href=3D"http://go-cross_1.2=
4.5.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1.24.5.bb</a>}=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-crosssdk_1.24.4.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-crosssdk_1.24.4.bb</a> =3D&gt; <a href=3D"http://go-cro=
sssdk_1.24.5.bb" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.5.bb=
</a>}=C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-runtime_1.24.4.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">go-runtime_1.24.4.bb</a> =3D&gt; <a href=3D"http://go-runti=
me_1.24.5.bb" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.24.5.bb</a>=
}=C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0recipes-devtools/go/{<a href=3D"http://go_1.24.4.bb" rel=3D"noreferre=
r" target=3D"_blank">go_1.24.4.bb</a> =3D&gt; <a href=3D"http://go_1.24.5.b=
b" rel=3D"noreferrer" target=3D"_blank">go_1.24.5.bb</a>}=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 0<br>
=C2=A07 files changed, 4 insertions(+), 4 deletions(-)<br>
=C2=A0rename recipes-devtools/go/{go-1.24.4.inc =3D&gt; go-1.24.5.inc} (91%=
)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-binary-native_1.24.4=
.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.4.bb</a> =
=3D&gt; <a href=3D"http://go-binary-native_1.24.5.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">go-binary-native_1.24.5.bb</a>} (79%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross-canadian_1.24.=
4.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.4.bb</a> =
=3D&gt; <a href=3D"http://go-cross-canadian_1.24.5.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-cross-canadian_1.24.5.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross_1.24.4.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.24.4.bb</a> =3D&gt; <a href=3D=
"http://go-cross_1.24.5.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1=
.24.5.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-crosssdk_1.24.4.bb" =
rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.4.bb</a> =3D&gt; <a h=
ref=3D"http://go-crosssdk_1.24.5.bb" rel=3D"noreferrer" target=3D"_blank">g=
o-crosssdk_1.24.5.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-runtime_1.24.4.bb" r=
el=3D"noreferrer" target=3D"_blank">go-runtime_1.24.4.bb</a> =3D&gt; <a hre=
f=3D"http://go-runtime_1.24.5.bb" rel=3D"noreferrer" target=3D"_blank">go-r=
untime_1.24.5.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go_1.24.4.bb" rel=3D"no=
referrer" target=3D"_blank">go_1.24.4.bb</a> =3D&gt; <a href=3D"http://go_1=
.24.5.bb" rel=3D"noreferrer" target=3D"_blank">go_1.24.5.bb</a>} (100%)<br>
<br>
diff --git a/recipes-devtools/go/go-1.24.4.inc b/recipes-devtools/go/go-1.2=
4.5.inc<br>
similarity index 91%<br>
rename from recipes-devtools/go/go-1.24.4.inc<br>
rename to recipes-devtools/go/go-1.24.5.inc<br>
index eff3f2f..fae0d3f 100644<br>
--- a/recipes-devtools/go/go-1.24.4.inc<br>
+++ b/recipes-devtools/go/go-1.24.5.inc<br>
@@ -17,4 +17,4 @@ SRC_URI +=3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-=
trimpath-.patch \<br>
=C2=A0 =C2=A0 =C2=A0file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \=
<br>
=C2=A0&quot;<br>
-SRC_URI[main.sha256sum] =3D &quot;5a86a83a31f9fa81490b8c5420ac384fd3d95a3e=
71fba665c7b3f95d1dfef2b4&quot;<br>
+SRC_URI[main.sha256sum] =3D &quot;74fdb09f2352e2b25b7943e56836c9b47363d28d=
ec1c8b56c4a9570f30b8f59f&quot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.4.=
bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.4.bb</a> b/r=
ecipes-devtools/go/<a href=3D"http://go-binary-native_1.24.5.bb" rel=3D"nor=
eferrer" target=3D"_blank">go-binary-native_1.24.5.bb</a><br>
similarity index 79%<br>
rename from recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.4.b=
b" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.4.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.5.bb"=
 rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.5.bb</a><br>
index d1f8fc6..5002686 100644<br>
--- a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.4.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.4.bb</a><br>
+++ b/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.5.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.5.bb</a><br>
@@ -9,9 +9,9 @@ PROVIDES =3D &quot;go-native&quot;<br>
<br>
=C2=A0# Checksums available at <a href=3D"https://go.dev/dl/" rel=3D"norefe=
rrer" target=3D"_blank">https://go.dev/dl/</a><br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://dl.google.com/go/go$%7BPV%7D.$%7=
BBUILD_GOOS%7D-$%7BBUILD_GOARCH%7D.tar.gz;name=3Dgo_$%7BBUILD_GOTUPLE%7D" r=
el=3D"noreferrer" target=3D"_blank">https://dl.google.com/go/go${PV}.${BUIL=
D_GOOS}-${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}</a>&quot;<br>
-SRC_URI[go_linux_amd64.sha256sum] =3D &quot;77e5da33bb72aeaef1ba4418b6fe51=
1bc4d041873cbf82e5aa6318740df98717&quot;<br>
-SRC_URI[go_linux_arm64.sha256sum] =3D &quot;d5501ee5aca0f258d5fe9bfaed4019=
58445014495dc115f202d43d5210b45241&quot;<br>
-SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;9ca4afef813a2578c23843b640ae=
0290aa54b2e3c950a6cc4c99e16a57dec2ec&quot;<br>
+SRC_URI[go_linux_amd64.sha256sum] =3D &quot;10ad9e86233e74c0f6590fe5426895=
de6bf388964210eac34a6d83f38918ecdc&quot;<br>
+SRC_URI[go_linux_arm64.sha256sum] =3D &quot;0df02e6aeb3d3c06c95ff201d57590=
7c736d6c62cfa4b6934c11203f1d600ffa&quot;<br>
+SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;00bdfb16d1094e78473b681d2d09=
d42c19c886d4dfed743853769f1665c7a552&quot;<br>
<br>
=C2=A0UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://golang.org/dl/" rel=
=3D"noreferrer" target=3D"_blank">https://golang.org/dl/</a>&quot;<br>
=C2=A0UPSTREAM_CHECK_REGEX =3D &quot;go(?P&lt;pver&gt;\d+(\.\d+)+)\.linux&q=
uot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.4=
.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.4.bb</a> b=
/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.5.bb" rel=3D"=
noreferrer" target=3D"_blank">go-cross-canadian_1.24.5.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.4.=
bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.4.bb</a><br=
>
rename to recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.5.bb=
" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.5.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross_1.24.4.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.24.4.bb</a> b/recipes-devtools=
/go/<a href=3D"http://go-cross_1.24.5.bb" rel=3D"noreferrer" target=3D"_bla=
nk">go-cross_1.24.5.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross_1.24.4.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.24.4.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-cross_1.24.5.bb" rel=3D"=
noreferrer" target=3D"_blank">go-cross_1.24.5.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.4.bb" r=
el=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.4.bb</a> b/recipes-dev=
tools/go/<a href=3D"http://go-crosssdk_1.24.5.bb" rel=3D"noreferrer" target=
=3D"_blank">go-crosssdk_1.24.5.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.4.bb" re=
l=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.4.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.5.bb" rel=
=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.5.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-runtime_1.24.4.bb" re=
l=3D"noreferrer" target=3D"_blank">go-runtime_1.24.4.bb</a> b/recipes-devto=
ols/go/<a href=3D"http://go-runtime_1.24.5.bb" rel=3D"noreferrer" target=3D=
"_blank">go-runtime_1.24.5.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-runtime_1.24.4.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.24.4.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-runtime_1.24.5.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.24.5.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go_1.24.4.bb" rel=3D"nor=
eferrer" target=3D"_blank">go_1.24.4.bb</a> b/recipes-devtools/go/<a href=
=3D"http://go_1.24.5.bb" rel=3D"noreferrer" target=3D"_blank">go_1.24.5.bb<=
/a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go_1.24.4.bb" rel=3D"nore=
ferrer" target=3D"_blank">go_1.24.4.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go_1.24.5.bb" rel=3D"norefe=
rrer" target=3D"_blank">go_1.24.5.bb</a><br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#1816): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/1816" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/1816</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/114223918/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/114223918/5052612</a><br>
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
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></=
div></div></div>

--000000000000de5005063b277725--

