Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A88D5B87C
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:01:29 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web11.18600.1730304088790692482
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Oct 2024 09:01:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XXJ7dZOH;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7180bd5b79dso2786811a34.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730304088; x=1730908888; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XGxr0AfvR803cGWCtQk+C6BsWUW+GvxZGWrSnceIyqk=;
        b=XXJ7dZOHJFaQJXfkx9zdzFUkRv6KtGhzggSZcUhzcymVdu37jNe22RbQfcG9iKvTnp
         mYH5ByxBogg9la5sUZoYw48xSrdK6UAazOrU5f7W3GL3DQd5/nv7oY58xcl5gHO15YBr
         MdEK0SkrKlafbNF7QK8vjFDI2hn69SX14gRxit2x/zGs+5DruxBYljLpOzioj3aUaMDB
         zOUFUW7BV9nkiDN4S0kDVnL1BANKd/PaNR14c8aXS5E9iETLDMcmYxmsGJDQDroX3RpJ
         AZsnpO3rrn9iEI6n0cuPoQSg6W2+DCB+TH8aQh9WpsLH5d/4aRAmNaNqQsiH7w1qYEyi
         aCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304088; x=1730908888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGxr0AfvR803cGWCtQk+C6BsWUW+GvxZGWrSnceIyqk=;
        b=SQUrf05RPf4o+hCPqb3Gi/Zc6ca9C5yJVu9S1HfADjMJENoWWIjNU11F2mE6m8ybaK
         i33ypTJ57T96wqGRdUA/aFr707Qvu7VBVqAx68J6Xu7v1xAh3TUguInCbfrS6j3bFuNk
         Cg/w/+LdT4axbVbg9km2+JDBZZJqiN85qz7rQG7t+w3lubQzhHX7ByePoRsFN79BH/C9
         Of1X8Pd8Z0Iy+EadnK7iwq2lqaMNFN9QSfrcju7vGyJ5IvW7byL63qU57pzLF3lYBWKh
         iMj0Fcwzz7WJ3byRLY6eIJzfftqjlqN2ttz4LqyCp9rjDsYNXmCoE0dIcdq8yBeUuuwI
         bWvw==
X-Gm-Message-State: AOJu0YypwvPmxwG+SN/lcmDpsu/vOK48ti1D+zlgyln3pkuT8XGN2Tx9
	ncTSDjiothK6e5vKzymgxiPOy0YScJCB0sUNi9I2AJLVuzPfb2kkRjeIwZqdY28hm5MAnzPWaPE
	pCNEbECENCOa65yUxZ7xuOc1t5kQgNUMqaoY=
X-Google-Smtp-Source: AGHT+IHMZ6Beu2Std9UMym8NaMvbZt6hKU5jXv9KqCo3yPhpgCztIxnLAykRdQiQ0VOPUYCRyqR0GlBDxUYoXeNso8A=
X-Received: by 2002:a05:6359:5e9f:b0:1c5:e393:f60f with SMTP id
 e5c5f4694b2df-1c5e393f67fmr211172055d.18.1730304087496; Wed, 30 Oct 2024
 09:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241029191642.38027-1-peter.marko@siemens.com> <20241029191642.38027-2-peter.marko@siemens.com>
In-Reply-To: <20241029191642.38027-2-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 30 Oct 2024 16:01:16 +0000
Message-ID: <CANPvuRnLAgM1n=KOYxONAW47oL6KTGZNtrXaA4CFZ5K-kuUv7Q@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH 2/2] go:
 upgrade 1.22.7 -> 1.22.8
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io, Peter Marko <peter.marko@siemens.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="0000000000007d1d7a0625b3d037"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 16:01:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/776

--0000000000007d1d7a0625b3d037
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Merged to kirkstone/go.

Thanks

Jose

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (ter=C3=A7a, 29/10/2024 =C3=A0=
(s) 19:17):

> From: Peter Marko <peter.marko@siemens.com>
>
> Upgrade to latest 1.22.x release [1]:
>
> $ git --no-pager log --oneline go1.22.7..go1.22.8
> aeccd613c8 (tag: go1.22.8) [release-branch.go1.22] go1.22.8
> b4086b7c16 [release-branch.go1.22] syscall: skip TestAmbientCapsUserns
> when restricted, document
> 6fab4b9a9e [release-branch.go1.22] runtime: size maps.Clone destination
> bucket array safely
> 71655f14ce [release-branch.go1.22] cmd/cgo: correct padding required by
> alignment
>
> [1] https://github.com/golang/go/compare/go1.22.7...go1.22.8
>
> (From OE-Core rev: 552b9913b25107d7a34611b499b7811896b5f098)
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/{go-1.22.7.inc =3D> go-1.22.8.inc}        | 2 +-
>  ...o-binary-native_1.22.7.bb =3D> go-binary-native_1.22.8.bb} | 6 +++---
>  ...cross-canadian_1.22.7.bb =3D> go-cross-canadian_1.22.8.bb} | 0
>  .../go/{go-cross_1.22.7.bb =3D> go-cross_1.22.8.bb}           | 0
>  .../go/{go-crosssdk_1.22.7.bb =3D> go-crosssdk_1.22.8.bb}     | 0
>  .../go/{go-runtime_1.22.7.bb =3D> go-runtime_1.22.8.bb}       | 0
>  recipes-devtools/go/{go_1.22.7.bb =3D> go_1.22.8.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.22.7.inc =3D> go-1.22.8.inc} (89%)
>  rename recipes-devtools/go/{go-binary-native_1.22.7.bb =3D>
> go-binary-native_1.22.8.bb} (78%)
>  rename recipes-devtools/go/{go-cross-canadian_1.22.7.bb =3D>
> go-cross-canadian_1.22.8.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.22.7.bb =3D> go-cross_1.22.8.bb}
> (100%)
>  rename recipes-devtools/go/{go-crosssdk_1.22.7.bb =3D>
> go-crosssdk_1.22.8.bb} (100%)
>  rename recipes-devtools/go/{go-runtime_1.22.7.bb =3D> go-runtime_1.22.8.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.22.7.bb =3D> go_1.22.8.bb} (100%)
>
> diff --git a/recipes-devtools/go/go-1.22.7.inc
> b/recipes-devtools/go/go-1.22.8.inc
> similarity index 89%
> rename from recipes-devtools/go/go-1.22.7.inc
> rename to recipes-devtools/go/go-1.22.8.inc
> index e54a902..542519b 100644
> --- a/recipes-devtools/go/go-1.22.7.inc
> +++ b/recipes-devtools/go/go-1.22.8.inc
> @@ -15,4 +15,4 @@ SRC_URI +=3D "\
>
>  file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
>      file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "66432d87d85e0cfac3edffe637d5930fc4ddf5793313fe11e4a0f333023c879f"
> +SRC_URI[main.sha256sum] =3D
> "df12c23ebf19dea0f4bf46a22cbeda4a3eca6f474f318390ce774974278440b8"
> diff --git a/recipes-devtools/go/go-binary-native_1.22.7.bb
> b/recipes-devtools/go/go-binary-native_1.22.8.bb
> similarity index 78%
> rename from recipes-devtools/go/go-binary-native_1.22.7.bb
> rename to recipes-devtools/go/go-binary-native_1.22.8.bb
> index aba317f..98799eb 100644
> --- a/recipes-devtools/go/go-binary-native_1.22.7.bb
> +++ b/recipes-devtools/go/go-binary-native_1.22.8.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "
> https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;nam=
e=3Dgo_${BUILD_GOTUPLE}
> "
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "fc5d49b7a5035f1f1b265c17aa86e9819e6dc9af8260ad61430ee7fbe27881bb"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "ed695684438facbd7e0f286c30b7bc2411cfc605516d8127dc25c62fe5b03885"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "a6441d5da40a961039ec22b0aadbc8b513f52b31bb8919c359a7e2c3c5bcf26a"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "5f467d29fc67c7ae6468cb6ad5b047a274bae8180cac5e0b7ddbfeba3e47e18f"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "5c616b32dab04bb8c4c8700478381daea0174dc70083e4026321163879278a4a"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "c546f27866510bf8e54e86fe6f58c705af0e894341e5572c91f197a734152c27"
>
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.22.7.bb
> b/recipes-devtools/go/go-cross-canadian_1.22.8.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.22.7.bb
> rename to recipes-devtools/go/go-cross-canadian_1.22.8.bb
> diff --git a/recipes-devtools/go/go-cross_1.22.7.bb b/recipes-devtools/go=
/
> go-cross_1.22.8.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.22.7.bb
> rename to recipes-devtools/go/go-cross_1.22.8.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.22.7.bb
> b/recipes-devtools/go/go-crosssdk_1.22.8.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.22.7.bb
> rename to recipes-devtools/go/go-crosssdk_1.22.8.bb
> diff --git a/recipes-devtools/go/go-runtime_1.22.7.bb
> b/recipes-devtools/go/go-runtime_1.22.8.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.22.7.bb
> rename to recipes-devtools/go/go-runtime_1.22.8.bb
> diff --git a/recipes-devtools/go/go_1.22.7.bb b/recipes-devtools/go/
> go_1.22.8.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.22.7.bb
> rename to recipes-devtools/go/go_1.22.8.bb
> --
> 2.30.2
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#771):
> https://lists.yoctoproject.org/g/yocto-patches/message/771
> Mute This Topic: https://lists.yoctoproject.org/mt/109283683/5052612
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

--0000000000007d1d7a0625b3d037
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged to=C2=A0kirkstone/go.<br><br>Thanks<br><br>Jose</di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Pete=
r Marko via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.or=
g</a> &lt;peter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproject.or=
g">siemens.com@lists.yoctoproject.org</a>&gt; escreveu (ter=C3=A7a, 29/10/2=
024 =C3=A0(s) 19:17):<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" targ=
et=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
<br>
Upgrade to latest 1.22.x release [1]:<br>
<br>
$ git --no-pager log --oneline go1.22.7..go1.22.8<br>
aeccd613c8 (tag: go1.22.8) [release-branch.go1.22] go1.22.8<br>
b4086b7c16 [release-branch.go1.22] syscall: skip TestAmbientCapsUserns when=
 restricted, document<br>
6fab4b9a9e [release-branch.go1.22] runtime: size maps.Clone destination buc=
ket array safely<br>
71655f14ce [release-branch.go1.22] cmd/cgo: correct padding required by ali=
gnment<br>
<br>
[1] <a href=3D"https://github.com/golang/go/compare/go1.22.7...go1.22.8" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/golang/go/compare/go1=
.22.7...go1.22.8</a><br>
<br>
(From OE-Core rev: 552b9913b25107d7a34611b499b7811896b5f098)<br>
<br>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
---<br>
=C2=A0recipes-devtools/go/{go-1.22.7.inc =3D&gt; go-1.22.8.inc}=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0...<a href=3D"http://o-binary-native_1.22.7.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">o-binary-native_1.22.7.bb</a> =3D&gt; <a href=3D"http://go-=
binary-native_1.22.8.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-nat=
ive_1.22.8.bb</a>} | 6 +++---<br>
=C2=A0...<a href=3D"http://cross-canadian_1.22.7.bb" rel=3D"noreferrer" tar=
get=3D"_blank">cross-canadian_1.22.7.bb</a> =3D&gt; <a href=3D"http://go-cr=
oss-canadian_1.22.8.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canad=
ian_1.22.8.bb</a>} | 0<br>
=C2=A0.../go/{<a href=3D"http://go-cross_1.22.7.bb" rel=3D"noreferrer" targ=
et=3D"_blank">go-cross_1.22.7.bb</a> =3D&gt; <a href=3D"http://go-cross_1.2=
2.8.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1.22.8.bb</a>}=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-crosssdk_1.22.7.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-crosssdk_1.22.7.bb</a> =3D&gt; <a href=3D"http://go-cro=
sssdk_1.22.8.bb" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.8.bb=
</a>}=C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-runtime_1.22.7.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">go-runtime_1.22.7.bb</a> =3D&gt; <a href=3D"http://go-runti=
me_1.22.8.bb" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.22.8.bb</a>=
}=C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0recipes-devtools/go/{<a href=3D"http://go_1.22.7.bb" rel=3D"noreferre=
r" target=3D"_blank">go_1.22.7.bb</a> =3D&gt; <a href=3D"http://go_1.22.8.b=
b" rel=3D"noreferrer" target=3D"_blank">go_1.22.8.bb</a>}=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 0<br>
=C2=A07 files changed, 4 insertions(+), 4 deletions(-)<br>
=C2=A0rename recipes-devtools/go/{go-1.22.7.inc =3D&gt; go-1.22.8.inc} (89%=
)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-binary-native_1.22.7=
.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.7.bb</a> =
=3D&gt; <a href=3D"http://go-binary-native_1.22.8.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">go-binary-native_1.22.8.bb</a>} (78%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross-canadian_1.22.=
7.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.7.bb</a> =
=3D&gt; <a href=3D"http://go-cross-canadian_1.22.8.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-cross-canadian_1.22.8.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross_1.22.7.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.22.7.bb</a> =3D&gt; <a href=3D=
"http://go-cross_1.22.8.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1=
.22.8.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-crosssdk_1.22.7.bb" =
rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.7.bb</a> =3D&gt; <a h=
ref=3D"http://go-crosssdk_1.22.8.bb" rel=3D"noreferrer" target=3D"_blank">g=
o-crosssdk_1.22.8.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-runtime_1.22.7.bb" r=
el=3D"noreferrer" target=3D"_blank">go-runtime_1.22.7.bb</a> =3D&gt; <a hre=
f=3D"http://go-runtime_1.22.8.bb" rel=3D"noreferrer" target=3D"_blank">go-r=
untime_1.22.8.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go_1.22.7.bb" rel=3D"no=
referrer" target=3D"_blank">go_1.22.7.bb</a> =3D&gt; <a href=3D"http://go_1=
.22.8.bb" rel=3D"noreferrer" target=3D"_blank">go_1.22.8.bb</a>} (100%)<br>
<br>
diff --git a/recipes-devtools/go/go-1.22.7.inc b/recipes-devtools/go/go-1.2=
2.8.inc<br>
similarity index 89%<br>
rename from recipes-devtools/go/go-1.22.7.inc<br>
rename to recipes-devtools/go/go-1.22.8.inc<br>
index e54a902..542519b 100644<br>
--- a/recipes-devtools/go/go-1.22.7.inc<br>
+++ b/recipes-devtools/go/go-1.22.8.inc<br>
@@ -15,4 +15,4 @@ SRC_URI +=3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-hos=
t-compile.patch \<br>
=C2=A0 =C2=A0 =C2=A0file://0009-go-Filter-build-paths-on-staticly-linked-ar=
ches.patch \<br>
=C2=A0&quot;<br>
-SRC_URI[main.sha256sum] =3D &quot;66432d87d85e0cfac3edffe637d5930fc4ddf579=
3313fe11e4a0f333023c879f&quot;<br>
+SRC_URI[main.sha256sum] =3D &quot;df12c23ebf19dea0f4bf46a22cbeda4a3eca6f47=
4f318390ce774974278440b8&quot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.7.=
bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.7.bb</a> b/r=
ecipes-devtools/go/<a href=3D"http://go-binary-native_1.22.8.bb" rel=3D"nor=
eferrer" target=3D"_blank">go-binary-native_1.22.8.bb</a><br>
similarity index 78%<br>
rename from recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.7.b=
b" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.7.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.8.bb"=
 rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.8.bb</a><br>
index aba317f..98799eb 100644<br>
--- a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.7.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.7.bb</a><br>
+++ b/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.8.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.8.bb</a><br>
@@ -9,9 +9,9 @@ PROVIDES =3D &quot;go-native&quot;<br>
<br>
=C2=A0# Checksums available at <a href=3D"https://go.dev/dl/" rel=3D"norefe=
rrer" target=3D"_blank">https://go.dev/dl/</a><br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://dl.google.com/go/go$%7BPV%7D.$%7=
BBUILD_GOOS%7D-$%7BBUILD_GOARCH%7D.tar.gz;name=3Dgo_$%7BBUILD_GOTUPLE%7D" r=
el=3D"noreferrer" target=3D"_blank">https://dl.google.com/go/go${PV}.${BUIL=
D_GOOS}-${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}</a>&quot;<br>
-SRC_URI[go_linux_amd64.sha256sum] =3D &quot;fc5d49b7a5035f1f1b265c17aa86e9=
819e6dc9af8260ad61430ee7fbe27881bb&quot;<br>
-SRC_URI[go_linux_arm64.sha256sum] =3D &quot;ed695684438facbd7e0f286c30b7bc=
2411cfc605516d8127dc25c62fe5b03885&quot;<br>
-SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;a6441d5da40a961039ec22b0aadb=
c8b513f52b31bb8919c359a7e2c3c5bcf26a&quot;<br>
+SRC_URI[go_linux_amd64.sha256sum] =3D &quot;5f467d29fc67c7ae6468cb6ad5b047=
a274bae8180cac5e0b7ddbfeba3e47e18f&quot;<br>
+SRC_URI[go_linux_arm64.sha256sum] =3D &quot;5c616b32dab04bb8c4c8700478381d=
aea0174dc70083e4026321163879278a4a&quot;<br>
+SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;c546f27866510bf8e54e86fe6f58=
c705af0e894341e5572c91f197a734152c27&quot;<br>
<br>
=C2=A0UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://golang.org/dl/" rel=
=3D"noreferrer" target=3D"_blank">https://golang.org/dl/</a>&quot;<br>
=C2=A0UPSTREAM_CHECK_REGEX =3D &quot;go(?P&lt;pver&gt;\d+(\.\d+)+)\.linux&q=
uot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.7=
.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.7.bb</a> b=
/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.8.bb" rel=3D"=
noreferrer" target=3D"_blank">go-cross-canadian_1.22.8.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.7.=
bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.7.bb</a><br=
>
rename to recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.8.bb=
" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.8.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross_1.22.7.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.22.7.bb</a> b/recipes-devtools=
/go/<a href=3D"http://go-cross_1.22.8.bb" rel=3D"noreferrer" target=3D"_bla=
nk">go-cross_1.22.8.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross_1.22.7.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.22.7.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-cross_1.22.8.bb" rel=3D"=
noreferrer" target=3D"_blank">go-cross_1.22.8.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.7.bb" r=
el=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.7.bb</a> b/recipes-dev=
tools/go/<a href=3D"http://go-crosssdk_1.22.8.bb" rel=3D"noreferrer" target=
=3D"_blank">go-crosssdk_1.22.8.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.7.bb" re=
l=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.7.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.8.bb" rel=
=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.8.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-runtime_1.22.7.bb" re=
l=3D"noreferrer" target=3D"_blank">go-runtime_1.22.7.bb</a> b/recipes-devto=
ols/go/<a href=3D"http://go-runtime_1.22.8.bb" rel=3D"noreferrer" target=3D=
"_blank">go-runtime_1.22.8.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-runtime_1.22.7.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.22.7.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-runtime_1.22.8.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.22.8.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go_1.22.7.bb" rel=3D"nor=
eferrer" target=3D"_blank">go_1.22.7.bb</a> b/recipes-devtools/go/<a href=
=3D"http://go_1.22.8.bb" rel=3D"noreferrer" target=3D"_blank">go_1.22.8.bb<=
/a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go_1.22.7.bb" rel=3D"nore=
ferrer" target=3D"_blank">go_1.22.7.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go_1.22.8.bb" rel=3D"norefe=
rrer" target=3D"_blank">go_1.22.8.bb</a><br>
-- <br>
2.30.2<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#771): <a href=3D"https://lists.yoctoproject.org/g/yocto=
-patches/message/771" rel=3D"noreferrer" target=3D"_blank">https://lists.yo=
ctoproject.org/g/yocto-patches/message/771</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/109283683/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/109283683/5052612</a><br>
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
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div>

--0000000000007d1d7a0625b3d037--

