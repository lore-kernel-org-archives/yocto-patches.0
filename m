Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5786D5B86D
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:01:29 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
 by mx.groups.io with SMTP id smtpd.web10.18836.1730304080697493781
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Oct 2024 09:01:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y0qMP3CY;
 spf=pass (domain: gmail.com, ip: 209.85.161.42, mailfrom: quaresma.jose@gmail.com)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5eb9ee4f14cso27205eaf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730304080; x=1730908880; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tTLrOcwsHwn6UsaxvX2RUmcOuM1Gpvw2HlFVo5vuTUk=;
        b=Y0qMP3CYUI2MPyzx2Zah8m5CdfIJqYO1Xpg6/hjWWbHlj4Ul/dHMYl4YXRD9WbrILw
         aIVI8U2An4fvl11mFwkvsZe5xLDtLTbM5xWoeFr/SP+/K7kBy7l0Tv5hpslsC3Sx9dcg
         qBxlWif2nXz/88USrzzDO9PGhnjRoWXnYqaMPcFzAoaIoQN0H7hSFWnT4SCkl31vfyLq
         lH8pqXLWqZ0RUt1OsxhdHwKedhWWJKjtL7siZU2fs2cLR+k1l7yTvCi1y9yJrE8Igs2X
         luefqx0Ts4BSdXEl0/5KzGZ5DqGHF0t9L+7UKtWVQS+9mNvRNAwmSHpGDGR1nBwR2qTe
         ysog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304080; x=1730908880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTLrOcwsHwn6UsaxvX2RUmcOuM1Gpvw2HlFVo5vuTUk=;
        b=GA930VEAtpS8sgvGyLLsWuMJBruK5BtsKhKhtjRo8VAwx0ruMifpDE6CvW/TQKK40A
         5x07WfiuOIE+6pQ/bbL8BP10dOh3hDW4T9yCOFZ90tjQlLLNpJED+cqVa4gQKGNtbL0J
         Wuk9Hut4kd5/0Tec+HUfkFld88Q90WI9baH7EVb/Vn+Y1teqz8w61RJ8iXRNd4D9s74Y
         8AhHjsgp0K57sUfL5pT0qqfC6wodKTOA+NdCj56Vry2ORk8QAi+75Fiu5WT1VvbiC8tH
         HaCL5wcO0ZkzXBGY4VrY4KQlg+6EYK5jfN6YbniLASURar/JZfx+WLl07jf/YHEnBEgE
         B0Xw==
X-Gm-Message-State: AOJu0Yyt4KoD4dz9UvdExssveX0uhuDhSPTvoPG5YaSVMRYdJsTXYWHK
	M2Kn29TTYhknBtdgE7FqLKDI6RNYelglxqX85C5RpUc9+ATDusUvXSja2HhqpzhhU60WXZvwwfB
	ZyqY4UIldFxXWd7U5WbfD71CtjlarrgzxDh8=
X-Google-Smtp-Source: AGHT+IHS1E4Jm+Rtjg8/Fvqp6dANx3qweI7THWv8xwIqJcg5o7oy5t503S3pwamFtdDtcFbpfTrx4IAIMSqaYo/mE9g=
X-Received: by 2002:a05:6358:704:b0:1c3:39ad:7c6c with SMTP id
 e5c5f4694b2df-1c3f9f6bb6cmr861032055d.17.1730304079017; Wed, 30 Oct 2024
 09:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241029191642.38027-1-peter.marko@siemens.com>
In-Reply-To: <20241029191642.38027-1-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 30 Oct 2024 16:01:08 +0000
Message-ID: <CANPvuRmz2LXDENRXO+BGvE5y2arwkkfYG8f=1kL9m9QcD27UJQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH 1/2] go:
 upgrade 1.22.6 -> 1.22.7
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io, Peter Marko <peter.marko@siemens.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000fbbe980625b3cf52"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 16:01:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/775

--000000000000fbbe980625b3cf52
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
> $ git --no-pager log --oneline go1.22.6..go1.22.7
> 7529d09a11 (tag: go1.22.7) [release-branch.go1.22] go1.22.7
> d4c53812e6 [release-branch.go1.22] go/build/constraint: add parsing limit=
s
> 2092294f2b [release-branch.go1.22] encoding/gob: cover missed cases when
> checking ignore depth
> b232596139 [release-branch.go1.22] go/parser: track depth in nested
> element lists
> e87be9833e [release-branch.go1.22] runtime: on AIX, fix call to
> _cgo_sys_thread_create in _rt0_ppc64_aix_lib
> 676d6100d8 [release-branch.go1.22] cmd/fix: support go versions with patc=
h
> release
> 0a525a3ed0 [release-branch.go1.22] os: fix Chtimes test flakes
>
> Fixes CVE-2024-34155, CVE-2024-34156 and CVE-2024-34158
>
> [1] https://github.com/golang/go/compare/go1.22.6...go1.22.7
>
> (From OE-Core rev: 92d609c49c0870ca10fcc39d52a801109d65a98b)
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/{go-1.22.6.inc =3D> go-1.22.7.inc}        | 2 +-
>  ...o-binary-native_1.22.6.bb =3D> go-binary-native_1.22.7.bb} | 6 +++---
>  ...cross-canadian_1.22.6.bb =3D> go-cross-canadian_1.22.7.bb} | 0
>  .../go/{go-cross_1.22.6.bb =3D> go-cross_1.22.7.bb}           | 0
>  .../go/{go-crosssdk_1.22.6.bb =3D> go-crosssdk_1.22.7.bb}     | 0
>  .../go/{go-runtime_1.22.6.bb =3D> go-runtime_1.22.7.bb}       | 0
>  recipes-devtools/go/{go_1.22.6.bb =3D> go_1.22.7.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.22.6.inc =3D> go-1.22.7.inc} (89%)
>  rename recipes-devtools/go/{go-binary-native_1.22.6.bb =3D>
> go-binary-native_1.22.7.bb} (78%)
>  rename recipes-devtools/go/{go-cross-canadian_1.22.6.bb =3D>
> go-cross-canadian_1.22.7.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.22.6.bb =3D> go-cross_1.22.7.bb}
> (100%)
>  rename recipes-devtools/go/{go-crosssdk_1.22.6.bb =3D>
> go-crosssdk_1.22.7.bb} (100%)
>  rename recipes-devtools/go/{go-runtime_1.22.6.bb =3D> go-runtime_1.22.7.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.22.6.bb =3D> go_1.22.7.bb} (100%)
>
> diff --git a/recipes-devtools/go/go-1.22.6.inc
> b/recipes-devtools/go/go-1.22.7.inc
> similarity index 89%
> rename from recipes-devtools/go/go-1.22.6.inc
> rename to recipes-devtools/go/go-1.22.7.inc
> index 834deba..e54a902 100644
> --- a/recipes-devtools/go/go-1.22.6.inc
> +++ b/recipes-devtools/go/go-1.22.7.inc
> @@ -15,4 +15,4 @@ SRC_URI +=3D "\
>
>  file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
>      file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "9e48d99d519882579917d8189c17e98c373ce25abaebb98772e2927088992a51"
> +SRC_URI[main.sha256sum] =3D
> "66432d87d85e0cfac3edffe637d5930fc4ddf5793313fe11e4a0f333023c879f"
> diff --git a/recipes-devtools/go/go-binary-native_1.22.6.bb
> b/recipes-devtools/go/go-binary-native_1.22.7.bb
> similarity index 78%
> rename from recipes-devtools/go/go-binary-native_1.22.6.bb
> rename to recipes-devtools/go/go-binary-native_1.22.7.bb
> index ea4577f..aba317f 100644
> --- a/recipes-devtools/go/go-binary-native_1.22.6.bb
> +++ b/recipes-devtools/go/go-binary-native_1.22.7.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "
> https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;nam=
e=3Dgo_${BUILD_GOTUPLE}
> "
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "999805bed7d9039ec3da1a53bfbcafc13e367da52aa823cb60b68ba22d44c616"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "c15fa895341b8eaf7f219fada25c36a610eb042985dc1a912410c1c90098eaf2"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "9d99fce3f6f72a76630fe91ec0884dfe3db828def4713368424900fa98bb2bd6"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "fc5d49b7a5035f1f1b265c17aa86e9819e6dc9af8260ad61430ee7fbe27881bb"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "ed695684438facbd7e0f286c30b7bc2411cfc605516d8127dc25c62fe5b03885"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "a6441d5da40a961039ec22b0aadbc8b513f52b31bb8919c359a7e2c3c5bcf26a"
>
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.22.6.bb
> b/recipes-devtools/go/go-cross-canadian_1.22.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.22.6.bb
> rename to recipes-devtools/go/go-cross-canadian_1.22.7.bb
> diff --git a/recipes-devtools/go/go-cross_1.22.6.bb b/recipes-devtools/go=
/
> go-cross_1.22.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.22.6.bb
> rename to recipes-devtools/go/go-cross_1.22.7.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.22.6.bb
> b/recipes-devtools/go/go-crosssdk_1.22.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.22.6.bb
> rename to recipes-devtools/go/go-crosssdk_1.22.7.bb
> diff --git a/recipes-devtools/go/go-runtime_1.22.6.bb
> b/recipes-devtools/go/go-runtime_1.22.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.22.6.bb
> rename to recipes-devtools/go/go-runtime_1.22.7.bb
> diff --git a/recipes-devtools/go/go_1.22.6.bb b/recipes-devtools/go/
> go_1.22.7.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.22.6.bb
> rename to recipes-devtools/go/go_1.22.7.bb
> --
> 2.30.2
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#770):
> https://lists.yoctoproject.org/g/yocto-patches/message/770
> Mute This Topic: https://lists.yoctoproject.org/mt/109283678/5052612
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

--000000000000fbbe980625b3cf52
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
$ git --no-pager log --oneline go1.22.6..go1.22.7<br>
7529d09a11 (tag: go1.22.7) [release-branch.go1.22] go1.22.7<br>
d4c53812e6 [release-branch.go1.22] go/build/constraint: add parsing limits<=
br>
2092294f2b [release-branch.go1.22] encoding/gob: cover missed cases when ch=
ecking ignore depth<br>
b232596139 [release-branch.go1.22] go/parser: track depth in nested element=
 lists<br>
e87be9833e [release-branch.go1.22] runtime: on AIX, fix call to _cgo_sys_th=
read_create in _rt0_ppc64_aix_lib<br>
676d6100d8 [release-branch.go1.22] cmd/fix: support go versions with patch =
release<br>
0a525a3ed0 [release-branch.go1.22] os: fix Chtimes test flakes<br>
<br>
Fixes CVE-2024-34155, CVE-2024-34156 and CVE-2024-34158<br>
<br>
[1] <a href=3D"https://github.com/golang/go/compare/go1.22.6...go1.22.7" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/golang/go/compare/go1=
.22.6...go1.22.7</a><br>
<br>
(From OE-Core rev: 92d609c49c0870ca10fcc39d52a801109d65a98b)<br>
<br>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
---<br>
=C2=A0recipes-devtools/go/{go-1.22.6.inc =3D&gt; go-1.22.7.inc}=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0...<a href=3D"http://o-binary-native_1.22.6.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">o-binary-native_1.22.6.bb</a> =3D&gt; <a href=3D"http://go-=
binary-native_1.22.7.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-nat=
ive_1.22.7.bb</a>} | 6 +++---<br>
=C2=A0...<a href=3D"http://cross-canadian_1.22.6.bb" rel=3D"noreferrer" tar=
get=3D"_blank">cross-canadian_1.22.6.bb</a> =3D&gt; <a href=3D"http://go-cr=
oss-canadian_1.22.7.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canad=
ian_1.22.7.bb</a>} | 0<br>
=C2=A0.../go/{<a href=3D"http://go-cross_1.22.6.bb" rel=3D"noreferrer" targ=
et=3D"_blank">go-cross_1.22.6.bb</a> =3D&gt; <a href=3D"http://go-cross_1.2=
2.7.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1.22.7.bb</a>}=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-crosssdk_1.22.6.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-crosssdk_1.22.6.bb</a> =3D&gt; <a href=3D"http://go-cro=
sssdk_1.22.7.bb" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.7.bb=
</a>}=C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-runtime_1.22.6.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">go-runtime_1.22.6.bb</a> =3D&gt; <a href=3D"http://go-runti=
me_1.22.7.bb" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.22.7.bb</a>=
}=C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0recipes-devtools/go/{<a href=3D"http://go_1.22.6.bb" rel=3D"noreferre=
r" target=3D"_blank">go_1.22.6.bb</a> =3D&gt; <a href=3D"http://go_1.22.7.b=
b" rel=3D"noreferrer" target=3D"_blank">go_1.22.7.bb</a>}=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 0<br>
=C2=A07 files changed, 4 insertions(+), 4 deletions(-)<br>
=C2=A0rename recipes-devtools/go/{go-1.22.6.inc =3D&gt; go-1.22.7.inc} (89%=
)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-binary-native_1.22.6=
.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.6.bb</a> =
=3D&gt; <a href=3D"http://go-binary-native_1.22.7.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">go-binary-native_1.22.7.bb</a>} (78%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross-canadian_1.22.=
6.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.6.bb</a> =
=3D&gt; <a href=3D"http://go-cross-canadian_1.22.7.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-cross-canadian_1.22.7.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross_1.22.6.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.22.6.bb</a> =3D&gt; <a href=3D=
"http://go-cross_1.22.7.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1=
.22.7.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-crosssdk_1.22.6.bb" =
rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.6.bb</a> =3D&gt; <a h=
ref=3D"http://go-crosssdk_1.22.7.bb" rel=3D"noreferrer" target=3D"_blank">g=
o-crosssdk_1.22.7.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-runtime_1.22.6.bb" r=
el=3D"noreferrer" target=3D"_blank">go-runtime_1.22.6.bb</a> =3D&gt; <a hre=
f=3D"http://go-runtime_1.22.7.bb" rel=3D"noreferrer" target=3D"_blank">go-r=
untime_1.22.7.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go_1.22.6.bb" rel=3D"no=
referrer" target=3D"_blank">go_1.22.6.bb</a> =3D&gt; <a href=3D"http://go_1=
.22.7.bb" rel=3D"noreferrer" target=3D"_blank">go_1.22.7.bb</a>} (100%)<br>
<br>
diff --git a/recipes-devtools/go/go-1.22.6.inc b/recipes-devtools/go/go-1.2=
2.7.inc<br>
similarity index 89%<br>
rename from recipes-devtools/go/go-1.22.6.inc<br>
rename to recipes-devtools/go/go-1.22.7.inc<br>
index 834deba..e54a902 100644<br>
--- a/recipes-devtools/go/go-1.22.6.inc<br>
+++ b/recipes-devtools/go/go-1.22.7.inc<br>
@@ -15,4 +15,4 @@ SRC_URI +=3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-hos=
t-compile.patch \<br>
=C2=A0 =C2=A0 =C2=A0file://0009-go-Filter-build-paths-on-staticly-linked-ar=
ches.patch \<br>
=C2=A0&quot;<br>
-SRC_URI[main.sha256sum] =3D &quot;9e48d99d519882579917d8189c17e98c373ce25a=
baebb98772e2927088992a51&quot;<br>
+SRC_URI[main.sha256sum] =3D &quot;66432d87d85e0cfac3edffe637d5930fc4ddf579=
3313fe11e4a0f333023c879f&quot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.6.=
bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.6.bb</a> b/r=
ecipes-devtools/go/<a href=3D"http://go-binary-native_1.22.7.bb" rel=3D"nor=
eferrer" target=3D"_blank">go-binary-native_1.22.7.bb</a><br>
similarity index 78%<br>
rename from recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.6.b=
b" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.6.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.7.bb"=
 rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.7.bb</a><br>
index ea4577f..aba317f 100644<br>
--- a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.6.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.6.bb</a><br>
+++ b/recipes-devtools/go/<a href=3D"http://go-binary-native_1.22.7.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.22.7.bb</a><br>
@@ -9,9 +9,9 @@ PROVIDES =3D &quot;go-native&quot;<br>
<br>
=C2=A0# Checksums available at <a href=3D"https://go.dev/dl/" rel=3D"norefe=
rrer" target=3D"_blank">https://go.dev/dl/</a><br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://dl.google.com/go/go$%7BPV%7D.$%7=
BBUILD_GOOS%7D-$%7BBUILD_GOARCH%7D.tar.gz;name=3Dgo_$%7BBUILD_GOTUPLE%7D" r=
el=3D"noreferrer" target=3D"_blank">https://dl.google.com/go/go${PV}.${BUIL=
D_GOOS}-${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}</a>&quot;<br>
-SRC_URI[go_linux_amd64.sha256sum] =3D &quot;999805bed7d9039ec3da1a53bfbcaf=
c13e367da52aa823cb60b68ba22d44c616&quot;<br>
-SRC_URI[go_linux_arm64.sha256sum] =3D &quot;c15fa895341b8eaf7f219fada25c36=
a610eb042985dc1a912410c1c90098eaf2&quot;<br>
-SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;9d99fce3f6f72a76630fe91ec088=
4dfe3db828def4713368424900fa98bb2bd6&quot;<br>
+SRC_URI[go_linux_amd64.sha256sum] =3D &quot;fc5d49b7a5035f1f1b265c17aa86e9=
819e6dc9af8260ad61430ee7fbe27881bb&quot;<br>
+SRC_URI[go_linux_arm64.sha256sum] =3D &quot;ed695684438facbd7e0f286c30b7bc=
2411cfc605516d8127dc25c62fe5b03885&quot;<br>
+SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;a6441d5da40a961039ec22b0aadb=
c8b513f52b31bb8919c359a7e2c3c5bcf26a&quot;<br>
<br>
=C2=A0UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://golang.org/dl/" rel=
=3D"noreferrer" target=3D"_blank">https://golang.org/dl/</a>&quot;<br>
=C2=A0UPSTREAM_CHECK_REGEX =3D &quot;go(?P&lt;pver&gt;\d+(\.\d+)+)\.linux&q=
uot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.6=
.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.6.bb</a> b=
/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.7.bb" rel=3D"=
noreferrer" target=3D"_blank">go-cross-canadian_1.22.7.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.6.=
bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.6.bb</a><br=
>
rename to recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.22.7.bb=
" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.22.7.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross_1.22.6.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.22.6.bb</a> b/recipes-devtools=
/go/<a href=3D"http://go-cross_1.22.7.bb" rel=3D"noreferrer" target=3D"_bla=
nk">go-cross_1.22.7.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross_1.22.6.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.22.6.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-cross_1.22.7.bb" rel=3D"=
noreferrer" target=3D"_blank">go-cross_1.22.7.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.6.bb" r=
el=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.6.bb</a> b/recipes-dev=
tools/go/<a href=3D"http://go-crosssdk_1.22.7.bb" rel=3D"noreferrer" target=
=3D"_blank">go-crosssdk_1.22.7.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.6.bb" re=
l=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.6.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-crosssdk_1.22.7.bb" rel=
=3D"noreferrer" target=3D"_blank">go-crosssdk_1.22.7.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-runtime_1.22.6.bb" re=
l=3D"noreferrer" target=3D"_blank">go-runtime_1.22.6.bb</a> b/recipes-devto=
ols/go/<a href=3D"http://go-runtime_1.22.7.bb" rel=3D"noreferrer" target=3D=
"_blank">go-runtime_1.22.7.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-runtime_1.22.6.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.22.6.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-runtime_1.22.7.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.22.7.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go_1.22.6.bb" rel=3D"nor=
eferrer" target=3D"_blank">go_1.22.6.bb</a> b/recipes-devtools/go/<a href=
=3D"http://go_1.22.7.bb" rel=3D"noreferrer" target=3D"_blank">go_1.22.7.bb<=
/a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go_1.22.6.bb" rel=3D"nore=
ferrer" target=3D"_blank">go_1.22.6.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go_1.22.7.bb" rel=3D"norefe=
rrer" target=3D"_blank">go_1.22.7.bb</a><br>
-- <br>
2.30.2<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#770): <a href=3D"https://lists.yoctoproject.org/g/yocto=
-patches/message/770" rel=3D"noreferrer" target=3D"_blank">https://lists.yo=
ctoproject.org/g/yocto-patches/message/770</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/109283678/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/109283678/5052612</a><br>
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

--000000000000fbbe980625b3cf52--

