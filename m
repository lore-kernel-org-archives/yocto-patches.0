Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC8C0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 15:05:07 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.14388.1738163096972390039
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 07:04:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FMYPRBGh;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: quaresma.jose@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46c8474d8f6so54839971cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 07:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738163096; x=1738767896; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MutbcOjQm4YLoAOGfPgVzCS4yAQkqHrBFrRf1wtGCn4=;
        b=FMYPRBGhHrVBFenQv4swwfyW1vifexwttK5OklrFhG4zh8rIgZwrHsiCScye5ezATh
         pP1A5fscagTvMqdmrpJP1oaeQ6GAAz9mdMThgvtxj8+ziJMPW0lTAHsOw2C60kKttKNV
         3IvY+BXLkNpt03imkIb/KeZKXtjX4eLA2y5j8MNVKNtJRiADfD6oaucAuswKyc8hZ7B3
         R62PSYz2X/SCulJlERPuOtVteRq9zLUh1MwK6S6kMV4KvO2jSAPwYa617xK8lJpnD6QA
         hTlAb0Ir257Hdw9GD0jmWXLqHXgDDpIOMYneVCv2XaT2VWUuD9lB/Aj4TDwdVbvdH2OW
         wllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738163096; x=1738767896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MutbcOjQm4YLoAOGfPgVzCS4yAQkqHrBFrRf1wtGCn4=;
        b=QA/EUXpVr6EksIn/ujdgwRrF28im7fG680hZNHCNeNnpdVLNA7hMDTblq+yR7z8xr6
         Lz39ajUkBYquXdzinnnQ9RpwcQ9uIntjKTubzQ1m81eGXV60kKLyxAGbSM1+mDIazCD4
         l5PCWyZov8YhgjOmBZhabnHixRmhZ2FPLuBsCSxdojE16WaFIbQU0tqcHaydtfKp3z3l
         OWR0DmA93YQB5yJT5KMK7wTrncukSCrWyVy4xJTHPFnxdKiappjCJloSGtEtctBQXqBT
         PyNdLlzVTc57f1ay7z80VvemwZURTB+7f10ZvABOnCqLJMtAvLLxiYRipjV+hfSwP2yc
         Keag==
X-Gm-Message-State: AOJu0Yy3Q73OqOkejzYJwOtWaIrxQpcs3wd6zQrpUPDgfXH9CYkNej2Z
	xvNLezv89ylXMejcqDN3C4mQ7rKoJuY81dCDD9DubjnKCEY0jkQ9JHi0w9hCmo9d9gqDjjiA1nP
	2q1OKf8DvM3aAH2B3CuBzXdkpdPr5+88c
X-Gm-Gg: ASbGncu9/nfzTrFrvyg92KAm5oHjpsrA0kM5r4DldU8uzKPsHQR26dFFTFrSJFXme0X
	6En/uww7BoZ2sqOMPjuwcD30wi4ci5aNVcxYVepqHRHHFy3UcZ43QWjlYkfLVnr/lnAfgkv89FQ
	rTwWUwFdBx
X-Google-Smtp-Source: AGHT+IFFY65CeBcYBIq6VHvB8RyQ1wAluH+KZuch414TGRrotFpFIB2jRUM4RCBmCO4LgBbKX7mECK68CBzq0yn4yQo=
X-Received: by 2002:ac8:5ad6:0:b0:467:5642:5917 with SMTP id
 d75a77b69052e-46fd0b6b21bmr50228181cf.32.1738163094749; Wed, 29 Jan 2025
 07:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20250128184826.1334984-1-peter.marko@siemens.com> <20250128184826.1334984-3-peter.marko@siemens.com>
In-Reply-To: <20250128184826.1334984-3-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 29 Jan 2025 15:04:44 +0000
X-Gm-Features: AWEUYZlKo4vMyRAej9s4Jy2C9OMXKALVAvt4XMhjVbP_vbPATKPwrLmhmUxQySU
Message-ID: <CANPvuR=R4=ib-MowRQoaW=UfQ_6xaL_Rk1yGP0Asz0RrNC7QVQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go 3/3] go: upgrade
 1.22.10 -> 1.22.11
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io, Peter Marko <peter.marko@siemens.com>
Content-Type: multipart/alternative; boundary="000000000000d3093c062cd9a1bf"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 15:05:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1011

--000000000000d3093c062cd9a1bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied! Thanks

Jose

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (ter=C3=A7a, 28/01/2025 =C3=A0=
(s) 18:49):

> From: Peter Marko <peter.marko@siemens.com>
>
> Upgrade to latest 1.22.x release [1]:
>
> $ git --no-pager log --oneline go1.22.10..go1.22.11
> f072884354 (tag: go1.22.11) [release-branch.go1.22] go1.22.11
> b72d56f98d [release-branch.go1.22] net/http: persist header stripping
> across repeated redirects
> 19d2103415 [release-branch.go1.22] crypto/x509: properly check for IPv6
> hosts in URIs
> ae9996f965 [release-branch.go1.22] runtime: hold traceAcquire across
> casgstatus in injectglist
> 223260bc63 [release-branch.go1.22] crypto/tls: fix Config.Time in tests
> using expired certificates
>
> Fixes CVE-2024-45336 and CVE-2024-45341
>
> [1] https://github.com/golang/go/compare/go1.22.10...go1.22.11
>
> (From OE-Core rev: 4589986602319f9ed61e381b333bb53b731eb8d8)
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  recipes-devtools/go/{go-1.22.10.inc =3D> go-1.22.11.inc}      | 2 +-
>  ...binary-native_1.22.10.bb =3D> go-binary-native_1.22.11.bb} | 6 +++---
>  ...oss-canadian_1.22.10.bb =3D> go-cross-canadian_1.22.11.bb} | 0
>  .../go/{go-cross_1.22.10.bb =3D> go-cross_1.22.11.bb}         | 0
>  .../go/{go-crosssdk_1.22.10.bb =3D> go-crosssdk_1.22.11.bb}   | 0
>  .../go/{go-runtime_1.22.10.bb =3D> go-runtime_1.22.11.bb}     | 0
>  recipes-devtools/go/{go_1.22.10.bb =3D> go_1.22.11.bb}        | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.22.10.inc =3D> go-1.22.11.inc} (89%)
>  rename recipes-devtools/go/{go-binary-native_1.22.10.bb =3D>
> go-binary-native_1.22.11.bb} (78%)
>  rename recipes-devtools/go/{go-cross-canadian_1.22.10.bb =3D>
> go-cross-canadian_1.22.11.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.22.10.bb =3D> go-cross_1.22.11.bb=
}
> (100%)
>  rename recipes-devtools/go/{go-crosssdk_1.22.10.bb =3D>
> go-crosssdk_1.22.11.bb} (100%)
>  rename recipes-devtools/go/{go-runtime_1.22.10.bb =3D>
> go-runtime_1.22.11.bb} (100%)
>  rename recipes-devtools/go/{go_1.22.10.bb =3D> go_1.22.11.bb} (100%)
>
> diff --git a/recipes-devtools/go/go-1.22.10.inc
> b/recipes-devtools/go/go-1.22.11.inc
> similarity index 89%
> rename from recipes-devtools/go/go-1.22.10.inc
> rename to recipes-devtools/go/go-1.22.11.inc
> index 2abe7d0..21222be 100644
> --- a/recipes-devtools/go/go-1.22.10.inc
> +++ b/recipes-devtools/go/go-1.22.11.inc
> @@ -15,4 +15,4 @@ SRC_URI +=3D "\
>
>  file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
>      file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "1e94fd48be750d1fafb4d9b3b6dd31a6e9d2735d339bf2462bc97b64ca4c1037"
> +SRC_URI[main.sha256sum] =3D
> "a60c23dec95d10a2576265ce580f57869d5ac2471c4f4aca805addc9ea0fc9fe"
> diff --git a/recipes-devtools/go/go-binary-native_1.22.10.bb
> b/recipes-devtools/go/go-binary-native_1.22.11.bb
> similarity index 78%
> rename from recipes-devtools/go/go-binary-native_1.22.10.bb
> rename to recipes-devtools/go/go-binary-native_1.22.11.bb
> index 8c8fe5b..a526cc8 100644
> --- a/recipes-devtools/go/go-binary-native_1.22.10.bb
> +++ b/recipes-devtools/go/go-binary-native_1.22.11.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "
> https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;nam=
e=3Dgo_${BUILD_GOTUPLE}
> "
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "736ce492a19d756a92719a6121226087ccd91b652ed5caec40ad6dbfb2252092"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "5213c5e32fde3bd7da65516467b7ffbfe40d2bb5a5f58105e387eef450583eec"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "db05b9838f69d741fb9a5301220b1a62014aee025b0baf341aba3d280087b981"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "0fc88d966d33896384fbde56e9a8d80a305dc17a9f48f1832e061724b1719991"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "9ebfcab26801fa4cf0627c6439db7a4da4d3c6766142a3dd83508240e4f21031"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "963a0ec973640b23ee8bb7a462cc415276fd8436111a03df8c34eb3b1ae29f12"
>
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.22.10.bb
> b/recipes-devtools/go/go-cross-canadian_1.22.11.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.22.10.bb
> rename to recipes-devtools/go/go-cross-canadian_1.22.11.bb
> diff --git a/recipes-devtools/go/go-cross_1.22.10.bb
> b/recipes-devtools/go/go-cross_1.22.11.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.22.10.bb
> rename to recipes-devtools/go/go-cross_1.22.11.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.22.10.bb
> b/recipes-devtools/go/go-crosssdk_1.22.11.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.22.10.bb
> rename to recipes-devtools/go/go-crosssdk_1.22.11.bb
> diff --git a/recipes-devtools/go/go-runtime_1.22.10.bb
> b/recipes-devtools/go/go-runtime_1.22.11.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.22.10.bb
> rename to recipes-devtools/go/go-runtime_1.22.11.bb
> diff --git a/recipes-devtools/go/go_1.22.10.bb b/recipes-devtools/go/
> go_1.22.11.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.22.10.bb
> rename to recipes-devtools/go/go_1.22.11.bb
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1010):
> https://lists.yoctoproject.org/g/yocto-patches/message/1010
> Mute This Topic: https://lists.yoctoproject.org/mt/110864634/5052612
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

--000000000000d3093c062cd9a1bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied! Thanks<br><br>Jose</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Peter Mar=
ko via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a>=
 &lt;peter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproject.org">si=
emens.com@lists.yoctoproject.org</a>&gt; escreveu (ter=C3=A7a, 28/01/2025 =
=C3=A0(s) 18:49):<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">From: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" target=
=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
<br>
Upgrade to latest 1.22.x release [1]:<br>
<br>
$ git --no-pager log --oneline go1.22.10..go1.22.11<br>
f072884354 (tag: go1.22.11) [release-branch.go1.22] go1.22.11<br>
b72d56f98d [release-branch.go1.22] net/http: persist header stripping acros=
s repeated redirects<br>
19d2103415 [release-branch.go1.22] crypto/x509: properly check for IPv6 hos=
ts in URIs<br>
ae9996f965 [release-branch.go1.22] runtime: hold traceAcquire across casgst=
atus in injectglist<br>
223260bc63 [release-branch.go1.22] crypto/tls: fix Config.Time in tests usi=
ng expired certificates<br>
<br>
Fixes CVE-2024-45336 and CVE-2024-45341<br>
<br>
[1] <a href=3D"https://github.com/golang/go/compare/go1.22.10...go1.22.11" =
rel=3D"noreferrer" target=3D"_blank">https://github.com/golang/go/compare/g=
o1.22.10...go1.22.11</a><br>
<br>
(From OE-Core rev: 4589986602319f9ed61e381b333bb53b731eb8d8)<br>
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
=C2=A0recipes-devtools/go/{go-1.22.10.inc =3D&gt; go-1.22.11.inc}=C2=A0 =C2=
=A0 =C2=A0 | 2 +-<br>
=C2=A0...<a href=3D"http://binary-native_1.22.10.bb" rel=3D"noreferrer" tar=
get=3D"_blank">binary-native_1.22.10.bb</a> =3D&gt; <a href=3D"http://go-bi=
nary-native_1.22.11.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-nati=
ve_1.22.11.bb</a>} | 6 +++---<br>
=C2=A0...<a href=3D"http://oss-canadian_1.22.10.bb" rel=3D"noreferrer" targ=
et=3D"_blank">oss-canadian_1.22.10.bb</a> =3D&gt; <a href=3D"http://go-cros=
s-canadian_1.22.11.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadi=
an_1.22.11.bb</a>} | 0<br>
=C2=A0.../go/{<a href=3D"http://go-cross_1.22.10.bb" rel=3D"noreferrer" tar=
get=3D"_blank">go-cross_1.22.10.bb</a> =3D&gt; <a href=3D"http://go-cross_1=
.22.11.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1.22.11.bb</a>}=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-crosssdk_1.22.10.bb" rel=3D"noreferrer" =
target=3D"_blank">go-crosssdk_1.22.10.bb</a> =3D&gt; <a href=3D"http://go-c=
rosssdk_1.22.11.bb" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.1=
1.bb</a>}=C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-runtime_1.22.10.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-runtime_1.22.10.bb</a> =3D&gt; <a href=3D"http://go-run=
time_1.22.11.bb" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.22.11.bb=
</a>}=C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0recipes-devtools/go/{<a href=3D"http://go_1.22.10.bb" rel=3D"noreferr=
er" target=3D"_blank">go_1.22.10.bb</a> =3D&gt; <a href=3D"http://go_1.22.1=
1.bb" rel=3D"noreferrer" target=3D"_blank">go_1.22.11.bb</a>}=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 0<br>
=C2=A07 files changed, 4 insertions(+), 4 deletions(-)<br>
=C2=A0rename recipes-devtools/go/{go-1.22.10.inc =3D&gt; go-1.22.11.inc} (8=
9%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-binary-native_1.22.1=
0.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.10.bb</a> =
=3D&gt; <a href=3D"http://go-binary-native_1.22.11.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-binary-native_1.22.11.bb</a>} (78%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross-canadian_1.22.=
10.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.10.bb</a=
> =3D&gt; <a href=3D"http://go-cross-canadian_1.22.11.bb" rel=3D"noreferrer=
" target=3D"_blank">go-cross-canadian_1.22.11.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross_1.22.10.bb" re=
l=3D"noreferrer" target=3D"_blank">go-cross_1.22.10.bb</a> =3D&gt; <a href=
=3D"http://go-cross_1.22.11.bb" rel=3D"noreferrer" target=3D"_blank">go-cro=
ss_1.22.11.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-crosssdk_1.22.10.bb"=
 rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.10.bb</a> =3D&gt; <a=
 href=3D"http://go-crosssdk_1.22.11.bb" rel=3D"noreferrer" target=3D"_blank=
">go-crosssdk_1.22.11.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-runtime_1.22.10.bb" =
rel=3D"noreferrer" target=3D"_blank">go-runtime_1.22.10.bb</a> =3D&gt; <a h=
ref=3D"http://go-runtime_1.22.11.bb" rel=3D"noreferrer" target=3D"_blank">g=
o-runtime_1.22.11.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go_1.22.10.bb" rel=3D"n=
oreferrer" target=3D"_blank">go_1.22.10.bb</a> =3D&gt; <a href=3D"http://go=
_1.22.11.bb" rel=3D"noreferrer" target=3D"_blank">go_1.22.11.bb</a>} (100%)=
<br>
<br>
diff --git a/recipes-devtools/go/go-1.22.10.inc b/recipes-devtools/go/go-1.=
22.11.inc<br>
similarity index 89%<br>
rename from recipes-devtools/go/go-1.22.10.inc<br>
rename to recipes-devtools/go/go-1.22.11.inc<br>
index 2abe7d0..21222be 100644<br>
--- a/recipes-devtools/go/go-1.22.10.inc<br>
+++ b/recipes-devtools/go/go-1.22.11.inc<br>
@@ -15,4 +15,4 @@ SRC_URI +=3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-hos=
t-compile.patch \<br>
=C2=A0 =C2=A0 =C2=A0file://0009-go-Filter-build-paths-on-staticly-linked-ar=
ches.patch \<br>
=C2=A0&quot;<br>
-SRC_URI[main.sha256sum] =3D &quot;1e94fd48be750d1fafb4d9b3b6dd31a6e9d2735d=
339bf2462bc97b64ca4c1037&quot;<br>
+SRC_URI[main.sha256sum] =3D &quot;a60c23dec95d10a2576265ce580f57869d5ac247=
1c4f4aca805addc9ea0fc9fe&quot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.10=
.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.10.bb</a> b=
/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.11.bb" rel=3D"=
noreferrer" target=3D"_blank">go-binary-native_1.22.11.bb</a><br>
similarity index 78%<br>
rename from recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.10.=
bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.10.bb</a><br=
>
rename to recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.11.bb=
" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.11.bb</a><br>
index 8c8fe5b..a526cc8 100644<br>
--- a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.10.bb" re=
l=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.10.bb</a><br>
+++ b/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.11.bb" re=
l=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.11.bb</a><br>
@@ -9,9 +9,9 @@ PROVIDES =3D &quot;go-native&quot;<br>
<br>
=C2=A0# Checksums available at <a href=3D"https://go.dev/dl/" rel=3D"norefe=
rrer" target=3D"_blank">https://go.dev/dl/</a><br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://dl.google.com/go/go$%7BPV%7D.$%7=
BBUILD_GOOS%7D-$%7BBUILD_GOARCH%7D.tar.gz;name=3Dgo_$%7BBUILD_GOTUPLE%7D" r=
el=3D"noreferrer" target=3D"_blank">https://dl.google.com/go/go${PV}.${BUIL=
D_GOOS}-${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}</a>&quot;<br>
-SRC_URI[go_linux_amd64.sha256sum] =3D &quot;736ce492a19d756a92719a61212260=
87ccd91b652ed5caec40ad6dbfb2252092&quot;<br>
-SRC_URI[go_linux_arm64.sha256sum] =3D &quot;5213c5e32fde3bd7da65516467b7ff=
bfe40d2bb5a5f58105e387eef450583eec&quot;<br>
-SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;db05b9838f69d741fb9a5301220b=
1a62014aee025b0baf341aba3d280087b981&quot;<br>
+SRC_URI[go_linux_amd64.sha256sum] =3D &quot;0fc88d966d33896384fbde56e9a8d8=
0a305dc17a9f48f1832e061724b1719991&quot;<br>
+SRC_URI[go_linux_arm64.sha256sum] =3D &quot;9ebfcab26801fa4cf0627c6439db7a=
4da4d3c6766142a3dd83508240e4f21031&quot;<br>
+SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;963a0ec973640b23ee8bb7a462cc=
415276fd8436111a03df8c34eb3b1ae29f12&quot;<br>
<br>
=C2=A0UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://golang.org/dl/" rel=
=3D"noreferrer" target=3D"_blank">https://golang.org/dl/</a>&quot;<br>
=C2=A0UPSTREAM_CHECK_REGEX =3D &quot;go(?P&lt;pver&gt;\d+(\.\d+)+)\.linux&q=
uot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.1=
0.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.10.bb</a>=
 b/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.11.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.11.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.10=
.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.10.bb</a><=
br>
rename to recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.11.b=
b" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.11.bb</a><br=
>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross_1.22.10.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.22.10.bb</a> b/recipes-devtool=
s/go/<a href=3D"http://go-cross_1.22.11.bb" rel=3D"noreferrer" target=3D"_b=
lank">go-cross_1.22.11.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross_1.22.10.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.22.10.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-cross_1.22.11.bb" rel=3D=
"noreferrer" target=3D"_blank">go-cross_1.22.11.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.10.bb" =
rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.10.bb</a> b/recipes-d=
evtools/go/<a href=3D"http://go-crosssdk_1.22.11.bb" rel=3D"noreferrer" tar=
get=3D"_blank">go-crosssdk_1.22.11.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.10.bb" r=
el=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.10.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.11.bb" rel=
=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.11.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-runtime_1.22.10.bb" r=
el=3D"noreferrer" target=3D"_blank">go-runtime_1.22.10.bb</a> b/recipes-dev=
tools/go/<a href=3D"http://go-runtime_1.22.11.bb" rel=3D"noreferrer" target=
=3D"_blank">go-runtime_1.22.11.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-runtime_1.22.10.bb" re=
l=3D"noreferrer" target=3D"_blank">go-runtime_1.22.10.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-runtime_1.22.11.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.22.11.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go_1.22.10.bb" rel=3D"no=
referrer" target=3D"_blank">go_1.22.10.bb</a> b/recipes-devtools/go/<a href=
=3D"http://go_1.22.11.bb" rel=3D"noreferrer" target=3D"_blank">go_1.22.11.b=
b</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go_1.22.10.bb" rel=3D"nor=
eferrer" target=3D"_blank">go_1.22.10.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go_1.22.11.bb" rel=3D"noref=
errer" target=3D"_blank">go_1.22.11.bb</a><br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#1010): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/1010" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/1010</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/110864634/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/110864634/5052612</a><br>
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
div></div>

--000000000000d3093c062cd9a1bf--

