Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6753C0219B
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 10:51:19 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
 by mx.groups.io with SMTP id smtpd.web11.9592.1739271072751811816
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 02:51:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TEQMORpq;
 spf=pass (domain: gmail.com, ip: 209.85.222.43, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-866e8ca2e07so1428255241.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739271071; x=1739875871; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fLaGEd/O8VWGipeHaqagfEbvxT9isNhZSTLfnAMKNm8=;
        b=TEQMORpqSk4D5IR3GMPmutghkZh51NNR47N/NbOUMXkRfS8mFKUJj8IirFz3md9yfn
         8kFhx3jS7c7rJw+TH+eDPiaMGqgFb8Sbe8gZLZ5FrKOyWHHqFsPPPgoq0BpsLsHSUsVl
         /Py3lGIi5boeMjtyjIzV/ati2ojQOj/s6g2pGIVrNlOir8Upal1MtTNfVg1+IxIFRqmZ
         5By2nK03ZYBWMvvygbVLuFjcaGKon8tNM+bHFdvPWx/6AIwNH7iwjMwmjxlhpgXNKcBP
         cxX+vQixsutq0nfnt1wKcZ9iyn8cjAxOVTThoPxmCM726ap1kJu9drTRUhbb519myfn1
         SXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739271071; x=1739875871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLaGEd/O8VWGipeHaqagfEbvxT9isNhZSTLfnAMKNm8=;
        b=K8EvANoa1UpyeHMQ5zN7X13zTSNP5HpyutH4Yc8xel+FrZt61HwEBN5tXoJE7h2yYr
         2n2HZJKqSIAorLu6PctISVOstMwYgOwJvHYKneKwvMz6c6Plbw1V1n2/Y0iLYhtNazps
         Zy7nWpH5ZVChMRMqmOrHY+2gaPwozDduUr27IJ2PPbj2VXX/DEFyAmkJtoA2mJiGQ7Ml
         Go8hkbc5ZaPwM9/R1c6Df6MbvUYxSyUHEzQdOlCFEn283am6dEYEAySBa+L4QCFIdedL
         B3McsmtQR3N/xHcWB5jcU+k/XWpCPhs/V6vbmvNSnTHAmPZIAE5/PBcysMmppE5OM+3U
         Xlfg==
X-Gm-Message-State: AOJu0YwUBm2vGtqRpuRn8ImZT8wApi31syzenAiomwwnCfnoRpiFHi2Q
	9aSPhIfZt3zEeqsi3wPV6cEhUQ2QovCACH3kJ3NE/M0WlS7wj/jJdBHQ4QsiaIVy/OD1+gbWttu
	wQmCFqFAWfo7CKgR3yI9iUgKkVospyg==
X-Gm-Gg: ASbGnctiQzWG4ql99Yd8u6Jxzdp5qT3aPDDeDcimw+LwGlLi37F3rIfz3umpnlFPl0Y
	KWIorlSt3bWZERMmA2XawTkIN92RJo4DH09/CBmfY1Ioov3JMG2hIaFzxO/zdLqBZGZct4ap0I3
	0=
X-Google-Smtp-Source: AGHT+IH1EMgo1rxVsXc3Ox0hEMydtRYlEEBg4zIHSaG9aey4JSOD0weYyVIrC2boJn3QVweHerbc7hn07wh3CvZoOHs=
X-Received: by 2002:a05:6102:508a:b0:4b6:8d8b:82c6 with SMTP id
 ada2fe7eead31-4ba85e70c19mr10073573137.15.1739271071529; Tue, 11 Feb 2025
 02:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20250210181238.2350415-1-peter.marko@siemens.com>
In-Reply-To: <20250210181238.2350415-1-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Tue, 11 Feb 2025 10:51:00 +0000
X-Gm-Features: AWEUYZnTqo9Fs-eT_gJrETwMrgGHy1vO_GQ0vM4Uj0C2L5FVS7n00PQxveRk6Ao
Message-ID: <CANPvuR=9GWgTR8-WL_7KuRz_f-x=jv8oDO9_Aiz2CpWjr+f3xg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go:
 upgrade 1.22.11 -> 1.22.12
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io, Peter Marko <peter.marko@siemens.com>
Content-Type: multipart/alternative; boundary="0000000000006303fe062ddb9aba"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 10:51:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1052

--0000000000006303fe062ddb9aba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied! Thanks

Jose

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (segunda, 10/02/2025 =C3=A0(s)
18:13):

> From: Peter Marko <peter.marko@siemens.com>
>
> Upgrade to latest 1.22.x release [1]:
>
> $ git --no-pager log --oneline go1.22.11..go1.22.12
> 5817e65094 (tag: go1.22.12) [release-branch.go1.22] go1.22.12
> 0cc45e7ca6 [release-branch.go1.22] crypto/internal/fips140/nistec: make
> p256NegCond constant time on ppc64le
> c3c6a50095 [release-branch.go1.22] cmd/go/internal/modfetch: do not trust
> server to send all tags in shallow fetch
> e0a01acd04 [release-branch.go1.22] cmd/compile: fix write barrier
> coalescing
>
> Fixes CVE-2025-22866
>
> [1] https://github.com/golang/go/compare/go1.22.11...go1.22.12
>
> (From OE-Core rev: 423ad5a67768738dac454b1e2aa27746f74511c5)
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  recipes-devtools/go/{go-1.22.11.inc =3D> go-1.22.12.inc}      | 2 +-
>  ...binary-native_1.22.11.bb =3D> go-binary-native_1.22.12.bb} | 6 +++---
>  ...oss-canadian_1.22.11.bb =3D> go-cross-canadian_1.22.12.bb} | 0
>  .../go/{go-cross_1.22.11.bb =3D> go-cross_1.22.12.bb}         | 0
>  .../go/{go-crosssdk_1.22.11.bb =3D> go-crosssdk_1.22.12.bb}   | 0
>  .../go/{go-runtime_1.22.11.bb =3D> go-runtime_1.22.12.bb}     | 0
>  recipes-devtools/go/{go_1.22.11.bb =3D> go_1.22.12.bb}        | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.22.11.inc =3D> go-1.22.12.inc} (89%)
>  rename recipes-devtools/go/{go-binary-native_1.22.11.bb =3D>
> go-binary-native_1.22.12.bb} (78%)
>  rename recipes-devtools/go/{go-cross-canadian_1.22.11.bb =3D>
> go-cross-canadian_1.22.12.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.22.11.bb =3D> go-cross_1.22.12.bb=
}
> (100%)
>  rename recipes-devtools/go/{go-crosssdk_1.22.11.bb =3D>
> go-crosssdk_1.22.12.bb} (100%)
>  rename recipes-devtools/go/{go-runtime_1.22.11.bb =3D>
> go-runtime_1.22.12.bb} (100%)
>  rename recipes-devtools/go/{go_1.22.11.bb =3D> go_1.22.12.bb} (100%)
>
> diff --git a/recipes-devtools/go/go-1.22.11.inc
> b/recipes-devtools/go/go-1.22.12.inc
> similarity index 89%
> rename from recipes-devtools/go/go-1.22.11.inc
> rename to recipes-devtools/go/go-1.22.12.inc
> index 21222be..05aa3a9 100644
> --- a/recipes-devtools/go/go-1.22.11.inc
> +++ b/recipes-devtools/go/go-1.22.12.inc
> @@ -15,4 +15,4 @@ SRC_URI +=3D "\
>
>  file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
>      file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "a60c23dec95d10a2576265ce580f57869d5ac2471c4f4aca805addc9ea0fc9fe"
> +SRC_URI[main.sha256sum] =3D
> "012a7e1f37f362c0918c1dfa3334458ac2da1628c4b9cf4d9ca02db986e17d71"
> diff --git a/recipes-devtools/go/go-binary-native_1.22.11.bb
> b/recipes-devtools/go/go-binary-native_1.22.12.bb
> similarity index 78%
> rename from recipes-devtools/go/go-binary-native_1.22.11.bb
> rename to recipes-devtools/go/go-binary-native_1.22.12.bb
> index a526cc8..747737f 100644
> --- a/recipes-devtools/go/go-binary-native_1.22.11.bb
> +++ b/recipes-devtools/go/go-binary-native_1.22.12.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "
> https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;nam=
e=3Dgo_${BUILD_GOTUPLE}
> "
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "0fc88d966d33896384fbde56e9a8d80a305dc17a9f48f1832e061724b1719991"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "9ebfcab26801fa4cf0627c6439db7a4da4d3c6766142a3dd83508240e4f21031"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "963a0ec973640b23ee8bb7a462cc415276fd8436111a03df8c34eb3b1ae29f12"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "4fa4f869b0f7fc6bb1eb2660e74657fbf04cdd290b5aef905585c86051b34d43"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "fd017e647ec28525e86ae8203236e0653242722a7436929b1f775744e26278e7"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "9573d30003b0796717a99d9e2e96c48fddd4fc0f29d840f212c503b03d7de112"
>
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.22.11.bb
> b/recipes-devtools/go/go-cross-canadian_1.22.12.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.22.11.bb
> rename to recipes-devtools/go/go-cross-canadian_1.22.12.bb
> diff --git a/recipes-devtools/go/go-cross_1.22.11.bb
> b/recipes-devtools/go/go-cross_1.22.12.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.22.11.bb
> rename to recipes-devtools/go/go-cross_1.22.12.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.22.11.bb
> b/recipes-devtools/go/go-crosssdk_1.22.12.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.22.11.bb
> rename to recipes-devtools/go/go-crosssdk_1.22.12.bb
> diff --git a/recipes-devtools/go/go-runtime_1.22.11.bb
> b/recipes-devtools/go/go-runtime_1.22.12.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.22.11.bb
> rename to recipes-devtools/go/go-runtime_1.22.12.bb
> diff --git a/recipes-devtools/go/go_1.22.11.bb b/recipes-devtools/go/
> go_1.22.12.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.22.11.bb
> rename to recipes-devtools/go/go_1.22.12.bb
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1050):
> https://lists.yoctoproject.org/g/yocto-patches/message/1050
> Mute This Topic: https://lists.yoctoproject.org/mt/111107477/5052612
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

--0000000000006303fe062ddb9aba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Applied! Thanks<br><br>Jose=C2=A0</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">Peter Marko via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproj=
ect.org</a> &lt;peter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproj=
ect.org">siemens.com@lists.yoctoproject.org</a>&gt; escreveu (segunda, 10/0=
2/2025 =C3=A0(s) 18:13):<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com"=
 target=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
<br>
Upgrade to latest 1.22.x release [1]:<br>
<br>
$ git --no-pager log --oneline go1.22.11..go1.22.12<br>
5817e65094 (tag: go1.22.12) [release-branch.go1.22] go1.22.12<br>
0cc45e7ca6 [release-branch.go1.22] crypto/internal/fips140/nistec: make p25=
6NegCond constant time on ppc64le<br>
c3c6a50095 [release-branch.go1.22] cmd/go/internal/modfetch: do not trust s=
erver to send all tags in shallow fetch<br>
e0a01acd04 [release-branch.go1.22] cmd/compile: fix write barrier coalescin=
g<br>
<br>
Fixes CVE-2025-22866<br>
<br>
[1] <a href=3D"https://github.com/golang/go/compare/go1.22.11...go1.22.12" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/golang/go/compare/g=
o1.22.11...go1.22.12</a><br>
<br>
(From OE-Core rev: 423ad5a67768738dac454b1e2aa27746f74511c5)<br>
<br>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0recipes-devtools/go/{go-1.22.11.inc =3D&gt; go-1.22.12.inc}=C2=A0 =C2=
=A0 =C2=A0 | 2 +-<br>
=C2=A0...<a href=3D"http://binary-native_1.22.11.bb" rel=3D"noreferrer" tar=
get=3D"_blank">binary-native_1.22.11.bb</a> =3D&gt; <a href=3D"http://go-bi=
nary-native_1.22.12.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-nati=
ve_1.22.12.bb</a>} | 6 +++---<br>
=C2=A0...<a href=3D"http://oss-canadian_1.22.11.bb" rel=3D"noreferrer" targ=
et=3D"_blank">oss-canadian_1.22.11.bb</a> =3D&gt; <a href=3D"http://go-cros=
s-canadian_1.22.12.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadi=
an_1.22.12.bb</a>} | 0<br>
=C2=A0.../go/{<a href=3D"http://go-cross_1.22.11.bb" rel=3D"noreferrer" tar=
get=3D"_blank">go-cross_1.22.11.bb</a> =3D&gt; <a href=3D"http://go-cross_1=
.22.12.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1.22.12.bb</a>}=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-crosssdk_1.22.11.bb" rel=3D"noreferrer" =
target=3D"_blank">go-crosssdk_1.22.11.bb</a> =3D&gt; <a href=3D"http://go-c=
rosssdk_1.22.12.bb" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.1=
2.bb</a>}=C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-runtime_1.22.11.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-runtime_1.22.11.bb</a> =3D&gt; <a href=3D"http://go-run=
time_1.22.12.bb" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.22.12.bb=
</a>}=C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0recipes-devtools/go/{<a href=3D"http://go_1.22.11.bb" rel=3D"noreferr=
er" target=3D"_blank">go_1.22.11.bb</a> =3D&gt; <a href=3D"http://go_1.22.1=
2.bb" rel=3D"noreferrer" target=3D"_blank">go_1.22.12.bb</a>}=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 0<br>
=C2=A07 files changed, 4 insertions(+), 4 deletions(-)<br>
=C2=A0rename recipes-devtools/go/{go-1.22.11.inc =3D&gt; go-1.22.12.inc} (8=
9%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-binary-native_1.22.1=
1.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.11.bb</a> =
=3D&gt; <a href=3D"http://go-binary-native_1.22.12.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-binary-native_1.22.12.bb</a>} (78%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross-canadian_1.22.=
11.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.11.bb</a=
> =3D&gt; <a href=3D"http://go-cross-canadian_1.22.12.bb" rel=3D"noreferrer=
" target=3D"_blank">go-cross-canadian_1.22.12.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross_1.22.11.bb" re=
l=3D"noreferrer" target=3D"_blank">go-cross_1.22.11.bb</a> =3D&gt; <a href=
=3D"http://go-cross_1.22.12.bb" rel=3D"noreferrer" target=3D"_blank">go-cro=
ss_1.22.12.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-crosssdk_1.22.11.bb"=
 rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.11.bb</a> =3D&gt; <a=
 href=3D"http://go-crosssdk_1.22.12.bb" rel=3D"noreferrer" target=3D"_blank=
">go-crosssdk_1.22.12.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-runtime_1.22.11.bb" =
rel=3D"noreferrer" target=3D"_blank">go-runtime_1.22.11.bb</a> =3D&gt; <a h=
ref=3D"http://go-runtime_1.22.12.bb" rel=3D"noreferrer" target=3D"_blank">g=
o-runtime_1.22.12.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go_1.22.11.bb" rel=3D"n=
oreferrer" target=3D"_blank">go_1.22.11.bb</a> =3D&gt; <a href=3D"http://go=
_1.22.12.bb" rel=3D"noreferrer" target=3D"_blank">go_1.22.12.bb</a>} (100%)=
<br>
<br>
diff --git a/recipes-devtools/go/go-1.22.11.inc b/recipes-devtools/go/go-1.=
22.12.inc<br>
similarity index 89%<br>
rename from recipes-devtools/go/go-1.22.11.inc<br>
rename to recipes-devtools/go/go-1.22.12.inc<br>
index 21222be..05aa3a9 100644<br>
--- a/recipes-devtools/go/go-1.22.11.inc<br>
+++ b/recipes-devtools/go/go-1.22.12.inc<br>
@@ -15,4 +15,4 @@ SRC_URI +=3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-hos=
t-compile.patch \<br>
=C2=A0 =C2=A0 =C2=A0file://0009-go-Filter-build-paths-on-staticly-linked-ar=
ches.patch \<br>
=C2=A0&quot;<br>
-SRC_URI[main.sha256sum] =3D &quot;a60c23dec95d10a2576265ce580f57869d5ac247=
1c4f4aca805addc9ea0fc9fe&quot;<br>
+SRC_URI[main.sha256sum] =3D &quot;012a7e1f37f362c0918c1dfa3334458ac2da1628=
c4b9cf4d9ca02db986e17d71&quot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.11=
.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.11.bb</a> b=
/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.12.bb" rel=3D"=
noreferrer" target=3D"_blank">go-binary-native_1.22.12.bb</a><br>
similarity index 78%<br>
rename from recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.11.=
bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.11.bb</a><br=
>
rename to recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.12.bb=
" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.12.bb</a><br>
index a526cc8..747737f 100644<br>
--- a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.11.bb" re=
l=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.11.bb</a><br>
+++ b/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.12.bb" re=
l=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.12.bb</a><br>
@@ -9,9 +9,9 @@ PROVIDES =3D &quot;go-native&quot;<br>
<br>
=C2=A0# Checksums available at <a href=3D"https://go.dev/dl/" rel=3D"norefe=
rrer" target=3D"_blank">https://go.dev/dl/</a><br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://dl.google.com/go/go$%7BPV%7D.$%7=
BBUILD_GOOS%7D-$%7BBUILD_GOARCH%7D.tar.gz;name=3Dgo_$%7BBUILD_GOTUPLE%7D" r=
el=3D"noreferrer" target=3D"_blank">https://dl.google.com/go/go${PV}.${BUIL=
D_GOOS}-${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}</a>&quot;<br>
-SRC_URI[go_linux_amd64.sha256sum] =3D &quot;0fc88d966d33896384fbde56e9a8d8=
0a305dc17a9f48f1832e061724b1719991&quot;<br>
-SRC_URI[go_linux_arm64.sha256sum] =3D &quot;9ebfcab26801fa4cf0627c6439db7a=
4da4d3c6766142a3dd83508240e4f21031&quot;<br>
-SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;963a0ec973640b23ee8bb7a462cc=
415276fd8436111a03df8c34eb3b1ae29f12&quot;<br>
+SRC_URI[go_linux_amd64.sha256sum] =3D &quot;4fa4f869b0f7fc6bb1eb2660e74657=
fbf04cdd290b5aef905585c86051b34d43&quot;<br>
+SRC_URI[go_linux_arm64.sha256sum] =3D &quot;fd017e647ec28525e86ae8203236e0=
653242722a7436929b1f775744e26278e7&quot;<br>
+SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;9573d30003b0796717a99d9e2e96=
c48fddd4fc0f29d840f212c503b03d7de112&quot;<br>
<br>
=C2=A0UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://golang.org/dl/" rel=
=3D"noreferrer" target=3D"_blank">https://golang.org/dl/</a>&quot;<br>
=C2=A0UPSTREAM_CHECK_REGEX =3D &quot;go(?P&lt;pver&gt;\d+(\.\d+)+)\.linux&q=
uot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.1=
1.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.11.bb</a>=
 b/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.12.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.12.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.11=
.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.11.bb</a><=
br>
rename to recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.12.b=
b" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.12.bb</a><br=
>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross_1.22.11.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.22.11.bb</a> b/recipes-devtool=
s/go/<a href=3D"http://go-cross_1.22.12.bb" rel=3D"noreferrer" target=3D"_b=
lank">go-cross_1.22.12.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross_1.22.11.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.22.11.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-cross_1.22.12.bb" rel=3D=
"noreferrer" target=3D"_blank">go-cross_1.22.12.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.11.bb" =
rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.11.bb</a> b/recipes-d=
evtools/go/<a href=3D"http://go-crosssdk_1.22.12.bb" rel=3D"noreferrer" tar=
get=3D"_blank">go-crosssdk_1.22.12.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.11.bb" r=
el=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.11.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.12.bb" rel=
=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.12.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-runtime_1.22.11.bb" r=
el=3D"noreferrer" target=3D"_blank">go-runtime_1.22.11.bb</a> b/recipes-dev=
tools/go/<a href=3D"http://go-runtime_1.22.12.bb" rel=3D"noreferrer" target=
=3D"_blank">go-runtime_1.22.12.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-runtime_1.22.11.bb" re=
l=3D"noreferrer" target=3D"_blank">go-runtime_1.22.11.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-runtime_1.22.12.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.22.12.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go_1.22.11.bb" rel=3D"no=
referrer" target=3D"_blank">go_1.22.11.bb</a> b/recipes-devtools/go/<a href=
=3D"http://go_1.22.12.bb" rel=3D"noreferrer" target=3D"_blank">go_1.22.12.b=
b</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go_1.22.11.bb" rel=3D"nor=
eferrer" target=3D"_blank">go_1.22.11.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go_1.22.12.bb" rel=3D"noref=
errer" target=3D"_blank">go_1.22.12.bb</a><br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#1050): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/1050" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/1050</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/111107477/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/111107477/5052612</a><br>
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

--0000000000006303fe062ddb9aba--

