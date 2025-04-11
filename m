Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E1C36010
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 10:15:30 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
 by mx.groups.io with SMTP id smtpd.web11.22415.1744366521831917765
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Apr 2025 03:15:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=niX811MZ;
 spf=pass (domain: gmail.com, ip: 209.85.222.51, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-873ac8037ecso739995241.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Apr 2025 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744366521; x=1744971321; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gkD14yYhSudUbnbWoXZDHGW/el2R0Oc7sNR4a0Su6Ng=;
        b=niX811MZeLF8SeWv3YYFglnLYWgV5xAouV0KnK78nm4CW9JWhV/wMPUQejrpC/W6U5
         TL/rn+SidjpWG0p6giZ1Jwx5TcuwJ4BPmhmGvPDZleOweRSgN2WPVjjsXBT8KShh4hmr
         CgwldIV8uUgETKPDTpLdLvmdESIUdM9QeVVNZ4piDTy5M/9IYtbgvERRAxS2gy6MQOfr
         DgwrN/aMMo5LrpntnXdAP9idIPI8cOYT/aQPVFXjTmPsEEKX3NXxCorPjCujosaK4ixB
         C81so+WFSnIhKqdIuBLX7UBcD0s698qR8EpmzFVAsAwhLFXgTjyhtHpKVbGi74vI+4Fn
         r+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744366521; x=1744971321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkD14yYhSudUbnbWoXZDHGW/el2R0Oc7sNR4a0Su6Ng=;
        b=plYwCYhey3pv4WuXb1eT1o/tR/WHa1KTMWFjLIyW/qIvBAWacgjgXGihSW25ySJM2h
         +l/jGoy9IkGsA5ey7pJiNaUAN+gyAZZHphSqJFG+UQQfrdyHoW/2AKptRoIoe5CV7loJ
         ryKysmWvpUWwxEiOXTrK1hDzvNw/j1KjaWxF58d+7CnFiXYHWWa0nCAPspa/g8Go53s7
         yLWdRwyFJ2wbpD2bHFYKU1qTOikt9m5n+cMX2RpcXjLwAZbzrGtaoH8RyeSxZqjGLLes
         dZYKll9qPIsi7YxOEtPahwVBSJaq0zK2ri2ZNxpaUmFBiGX7T8fMVSNLbtpa3nDuCICY
         1k6w==
X-Gm-Message-State: AOJu0YxO31Ijhud7x3FdDF35GQiTEM7kDo0ai199jZl+U/NvoKBYFm/y
	m6zPKND5F6UNcbAMVHwIAe4HV1PzN6hpE2Ws+q9Qsctqb1Yony/CmOQGWMMcIH4+tNHwfm+GnPA
	Lf6NlOKCLtRLyJSXRa9NbPuxbO7qcQzS2/fY=
X-Gm-Gg: ASbGncsLEpomgY1MSHSrO4u1y9AK9p1Tkjwrd9EWxjJ7ttesHCRFb/06d+3H7T4TPh2
	ZstN6LjG1FMDcvI/Qxk1m9WmZIO1ycTHthK21JpeJ6omFIlIO39eO67zg2ChfDKdVmSa/zrJ2ok
	jv62MI5sU3s5878S26vXjGO7U=
X-Google-Smtp-Source: AGHT+IEMuYnl5cl/yfp8RHxptASsj+FLnWuzntaIOZlTAsHyuey6F7f1X8q0ILR0H15X2AZz+Y8ivxSpk5051VoqHG8=
X-Received: by 2002:a05:6102:4407:b0:4bb:e2a1:183e with SMTP id
 ada2fe7eead31-4c9e5006d87mr902192137.18.1744366520481; Fri, 11 Apr 2025
 03:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250411064802.1473179-1-niels@nobi.life>
In-Reply-To: <20250411064802.1473179-1-niels@nobi.life>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Fri, 11 Apr 2025 11:15:09 +0100
X-Gm-Features: ATxdqUH_BKPmeyhitl139Rvn1AFF5QEc80tM-kWOSLTy1gm_chSjLgAj-asGros
Message-ID: <CANPvuRk6qfy--dqHkJk_ppuTaO+ecO9dPeNzXduiwnyk2FQP=w@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go:
 upgrade 1.24.1 -> 1.24.2
To: yocto-patches@lists.yoctoproject.org
Cc: Niels Avonds <niels@nobi.life>
Content-Type: multipart/alternative; boundary="000000000000cfc07a06327dfac5"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Apr 2025 10:15:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1361

--000000000000cfc07a06327dfac5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niels,

I have applied the above patch
https://lists.yoctoproject.org/g/yocto-patches/message/1357

Thanks

Jose

Niels Avonds via lists.yoctoproject.org <niels=3D
nobi.life@lists.yoctoproject.org> escreveu (sexta, 11/04/2025 =C3=A0(s) 07:=
48):

> Upgrade to latest 1.24.x release [1]:
>
> $ git --no-pager log --oneline go1.24.1..go1.24.2
> 49860cf92a (tag: go1.24.2) [release-branch.go1.24] go1.24.2
> f3a302358f [release-branch.go1.24] testing: detect a stopped timer in
> B.Loop
> 1d755aa488 [release-branch.go1.24] testing: detect early return from B.Lo=
op
> 9204aca6c2 [release-branch.go1.24] testing: separate b.Loop counter from
> b.N
> 0ae3ca0a20 [release-branch.go1.24] runtime: explicitly disable async
> preempt for internal/runtime
> dae59b594c [release-branch.go1.24] runtime: skip TestCgoCallbackPprof on
> platforms with broken profiling
> b7fd97ae3e [release-branch.go1.24] runtime: only set isExtraInC if there
> are no Go frames left
> 311096a6a2 [release-branch.go1.24] go/types,types2: allocate the used*
> maps in initFiles
> e9162e7e22 [release-branch.go1.24] go/types,types2: externalize used
> objects
> d107ee90df [release-branch.go1.24] testing: allow manual timer control in
> testing.B.Loop
> 213f1566ee [release-branch.go1.24] internal/godebugs: fix changed version
> for winsymlink and winreadlinkvolume to 1.23
> ac1f5aa3d6 [release-branch.go1.24] net/http: reject newlines in chunk-siz=
e
> lines
> fd29397dca [release-branch.go1.24] net/http: don't modify caller's
> tls.Config.NextProtos
> 4524009ba6 [release-branch.go1.24] runtime: Added usage example for the
> runtime.AddCleanup() function.
> bd1bc8a6e7 [release-branch.go1.24] crypto/tls: allow P-521 in FIPS 140-3
> mode and Go+BoringCrypto
> c2a34bedee [release-branch.go1.24] cmd/compile: use inline-Pos-based
> recursion test
> 0ace2d8aca [release-branch.go1.24] cmd/compile: fix out of memory when
> inlining closure
> e4119e9b74 [release-branch.go1.24] all: updates vendored x/net
>
> Fixes CVE-2025-22871
>
> [1] https://github.com/golang/go/compare/go1.24.1...go1.24.2
>
> Signed-off-by: Niels Avonds <niels@nobi.life>
> ---
>  recipes-devtools/go/{go-1.24.1.inc =3D> go-1.24.2.inc}        | 2 +-
>  ...o-binary-native_1.24.1.bb =3D> go-binary-native_1.24.2.bb} | 6 +++---
>  ...cross-canadian_1.24.1.bb =3D> go-cross-canadian_1.24.2.bb} | 0
>  .../go/{go-cross_1.24.1.bb =3D> go-cross_1.24.2.bb}           | 0
>  .../go/{go-crosssdk_1.24.1.bb =3D> go-crosssdk_1.24.2.bb}     | 0
>  .../go/{go-runtime_1.24.1.bb =3D> go-runtime_1.24.2.bb}       | 0
>  recipes-devtools/go/{go_1.24.1.bb =3D> go_1.24.2.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.24.1.inc =3D> go-1.24.2.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.24.1.bb =3D>
> go-binary-native_1.24.2.bb} (78%)
>  rename recipes-devtools/go/{go-cross-canadian_1.24.1.bb =3D>
> go-cross-canadian_1.24.2.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.24.1.bb =3D> go-cross_1.24.2.bb}
> (100%)
>  rename recipes-devtools/go/{go-crosssdk_1.24.1.bb =3D>
> go-crosssdk_1.24.2.bb} (100%)
>  rename recipes-devtools/go/{go-runtime_1.24.1.bb =3D> go-runtime_1.24.2.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.24.1.bb =3D> go_1.24.2.bb} (100%)
>
> diff --git a/recipes-devtools/go/go-1.24.1.inc
> b/recipes-devtools/go/go-1.24.2.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.24.1.inc
> rename to recipes-devtools/go/go-1.24.2.inc
> index 4cf66e7..cb4ae9e 100644
> --- a/recipes-devtools/go/go-1.24.1.inc
> +++ b/recipes-devtools/go/go-1.24.2.inc
> @@ -17,4 +17,4 @@ SRC_URI +=3D "\
>
>  file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
>      file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "8244ebf46c65607db10222b5806aeb31c1fcf8979c1b6b12f60c677e9a3c0656"
> +SRC_URI[main.sha256sum] =3D
> "9dc77ffadc16d837a1bf32d99c624cb4df0647cee7b119edd9e7b1bcc05f2e00"
> diff --git a/recipes-devtools/go/go-binary-native_1.24.1.bb
> b/recipes-devtools/go/go-binary-native_1.24.2.bb
> similarity index 78%
> rename from recipes-devtools/go/go-binary-native_1.24.1.bb
> rename to recipes-devtools/go/go-binary-native_1.24.2.bb
> index ffe3d50..690b854 100644
> --- a/recipes-devtools/go/go-binary-native_1.24.1.bb
> +++ b/recipes-devtools/go/go-binary-native_1.24.2.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "
> https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;nam=
e=3Dgo_${BUILD_GOTUPLE}
> "
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "cb2396bae64183cdccf81a9a6df0aea3bce9511fc21469fb89a0c00470088073"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "8df5750ffc0281017fb6070fba450f5d22b600a02081dceef47966ffaf36a3af"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "0fb522efcefabae6e37e69bdc444094e75bfe824ea6d4cc3cbc70c7ae1b16858"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "68097bd680839cbc9d464a0edce4f7c333975e27a90246890e9f1078c7e702ad"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "756274ea4b68fa5535eb9fe2559889287d725a8da63c6aae4d5f23778c229f4b"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "5fff857791d541c71d8ea0171c73f6f99770d15ff7e2ad979104856d01f36563"
>
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.24.1.bb
> b/recipes-devtools/go/go-cross-canadian_1.24.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.24.1.bb
> rename to recipes-devtools/go/go-cross-canadian_1.24.2.bb
> diff --git a/recipes-devtools/go/go-cross_1.24.1.bb b/recipes-devtools/go=
/
> go-cross_1.24.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.24.1.bb
> rename to recipes-devtools/go/go-cross_1.24.2.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.24.1.bb
> b/recipes-devtools/go/go-crosssdk_1.24.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.24.1.bb
> rename to recipes-devtools/go/go-crosssdk_1.24.2.bb
> diff --git a/recipes-devtools/go/go-runtime_1.24.1.bb
> b/recipes-devtools/go/go-runtime_1.24.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.24.1.bb
> rename to recipes-devtools/go/go-runtime_1.24.2.bb
> diff --git a/recipes-devtools/go/go_1.24.1.bb b/recipes-devtools/go/
> go_1.24.2.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.24.1.bb
> rename to recipes-devtools/go/go_1.24.2.bb
> --
> 2.34.1
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1359):
> https://lists.yoctoproject.org/g/yocto-patches/message/1359
> Mute This Topic: https://lists.yoctoproject.org/mt/112206120/5052612
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

--000000000000cfc07a06327dfac5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Niels,<br><br>I have applied the above=
 patch<br><a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message=
/1357">https://lists.yoctoproject.org/g/yocto-patches/message/1357</a></div=
><br>Thanks<br><br>Jose<br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Niels Avonds via <a href=3D"http=
://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;niels=3D<a href=
=3D"mailto:nobi.life@lists.yoctoproject.org">nobi.life@lists.yoctoproject.o=
rg</a>&gt; escreveu (sexta, 11/04/2025 =C3=A0(s) 07:48):<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Upgrade to latest 1.24.x release [=
1]:<br>
<br>
$ git --no-pager log --oneline go1.24.1..go1.24.2<br>
49860cf92a (tag: go1.24.2) [release-branch.go1.24] go1.24.2<br>
f3a302358f [release-branch.go1.24] testing: detect a stopped timer in B.Loo=
p<br>
1d755aa488 [release-branch.go1.24] testing: detect early return from B.Loop=
<br>
9204aca6c2 [release-branch.go1.24] testing: separate b.Loop counter from b.=
N<br>
0ae3ca0a20 [release-branch.go1.24] runtime: explicitly disable async preemp=
t for internal/runtime<br>
dae59b594c [release-branch.go1.24] runtime: skip TestCgoCallbackPprof on pl=
atforms with broken profiling<br>
b7fd97ae3e [release-branch.go1.24] runtime: only set isExtraInC if there ar=
e no Go frames left<br>
311096a6a2 [release-branch.go1.24] go/types,types2: allocate the used* maps=
 in initFiles<br>
e9162e7e22 [release-branch.go1.24] go/types,types2: externalize used object=
s<br>
d107ee90df [release-branch.go1.24] testing: allow manual timer control in t=
esting.B.Loop<br>
213f1566ee [release-branch.go1.24] internal/godebugs: fix changed version f=
or winsymlink and winreadlinkvolume to 1.23<br>
ac1f5aa3d6 [release-branch.go1.24] net/http: reject newlines in chunk-size =
lines<br>
fd29397dca [release-branch.go1.24] net/http: don&#39;t modify caller&#39;s =
tls.Config.NextProtos<br>
4524009ba6 [release-branch.go1.24] runtime: Added usage example for the run=
time.AddCleanup() function.<br>
bd1bc8a6e7 [release-branch.go1.24] crypto/tls: allow P-521 in FIPS 140-3 mo=
de and Go+BoringCrypto<br>
c2a34bedee [release-branch.go1.24] cmd/compile: use inline-Pos-based recurs=
ion test<br>
0ace2d8aca [release-branch.go1.24] cmd/compile: fix out of memory when inli=
ning closure<br>
e4119e9b74 [release-branch.go1.24] all: updates vendored x/net<br>
<br>
Fixes CVE-2025-22871<br>
<br>
[1] <a href=3D"https://github.com/golang/go/compare/go1.24.1...go1.24.2" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/golang/go/compare/go1=
.24.1...go1.24.2</a><br>
<br>
Signed-off-by: Niels Avonds &lt;niels@nobi.life&gt;<br>
---<br>
=C2=A0recipes-devtools/go/{go-1.24.1.inc =3D&gt; go-1.24.2.inc}=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0...<a href=3D"http://o-binary-native_1.24.1.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">o-binary-native_1.24.1.bb</a> =3D&gt; <a href=3D"http://go-=
binary-native_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-nat=
ive_1.24.2.bb</a>} | 6 +++---<br>
=C2=A0...<a href=3D"http://cross-canadian_1.24.1.bb" rel=3D"noreferrer" tar=
get=3D"_blank">cross-canadian_1.24.1.bb</a> =3D&gt; <a href=3D"http://go-cr=
oss-canadian_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canad=
ian_1.24.2.bb</a>} | 0<br>
=C2=A0.../go/{<a href=3D"http://go-cross_1.24.1.bb" rel=3D"noreferrer" targ=
et=3D"_blank">go-cross_1.24.1.bb</a> =3D&gt; <a href=3D"http://go-cross_1.2=
4.2.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1.24.2.bb</a>}=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-crosssdk_1.24.1.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-crosssdk_1.24.1.bb</a> =3D&gt; <a href=3D"http://go-cro=
sssdk_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.2.bb=
</a>}=C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-runtime_1.24.1.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">go-runtime_1.24.1.bb</a> =3D&gt; <a href=3D"http://go-runti=
me_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.24.2.bb</a>=
}=C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0recipes-devtools/go/{<a href=3D"http://go_1.24.1.bb" rel=3D"noreferre=
r" target=3D"_blank">go_1.24.1.bb</a> =3D&gt; <a href=3D"http://go_1.24.2.b=
b" rel=3D"noreferrer" target=3D"_blank">go_1.24.2.bb</a>}=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 0<br>
=C2=A07 files changed, 4 insertions(+), 4 deletions(-)<br>
=C2=A0rename recipes-devtools/go/{go-1.24.1.inc =3D&gt; go-1.24.2.inc} (91%=
)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-binary-native_1.24.1=
.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.1.bb</a> =
=3D&gt; <a href=3D"http://go-binary-native_1.24.2.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">go-binary-native_1.24.2.bb</a>} (78%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross-canadian_1.24.=
1.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.1.bb</a> =
=3D&gt; <a href=3D"http://go-cross-canadian_1.24.2.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-cross-canadian_1.24.2.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross_1.24.1.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.24.1.bb</a> =3D&gt; <a href=3D=
"http://go-cross_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1=
.24.2.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-crosssdk_1.24.1.bb" =
rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.1.bb</a> =3D&gt; <a h=
ref=3D"http://go-crosssdk_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">g=
o-crosssdk_1.24.2.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-runtime_1.24.1.bb" r=
el=3D"noreferrer" target=3D"_blank">go-runtime_1.24.1.bb</a> =3D&gt; <a hre=
f=3D"http://go-runtime_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-r=
untime_1.24.2.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go_1.24.1.bb" rel=3D"no=
referrer" target=3D"_blank">go_1.24.1.bb</a> =3D&gt; <a href=3D"http://go_1=
.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go_1.24.2.bb</a>} (100%)<br>
<br>
diff --git a/recipes-devtools/go/go-1.24.1.inc b/recipes-devtools/go/go-1.2=
4.2.inc<br>
similarity index 91%<br>
rename from recipes-devtools/go/go-1.24.1.inc<br>
rename to recipes-devtools/go/go-1.24.2.inc<br>
index 4cf66e7..cb4ae9e 100644<br>
--- a/recipes-devtools/go/go-1.24.1.inc<br>
+++ b/recipes-devtools/go/go-1.24.2.inc<br>
@@ -17,4 +17,4 @@ SRC_URI +=3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-=
trimpath-.patch \<br>
=C2=A0 =C2=A0 =C2=A0file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \=
<br>
=C2=A0&quot;<br>
-SRC_URI[main.sha256sum] =3D &quot;8244ebf46c65607db10222b5806aeb31c1fcf897=
9c1b6b12f60c677e9a3c0656&quot;<br>
+SRC_URI[main.sha256sum] =3D &quot;9dc77ffadc16d837a1bf32d99c624cb4df0647ce=
e7b119edd9e7b1bcc05f2e00&quot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.1.=
bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.1.bb</a> b/r=
ecipes-devtools/go/<a href=3D"http://go-binary-native_1.24.2.bb" rel=3D"nor=
eferrer" target=3D"_blank">go-binary-native_1.24.2.bb</a><br>
similarity index 78%<br>
rename from recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.1.b=
b" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.1.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.2.bb"=
 rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.2.bb</a><br>
index ffe3d50..690b854 100644<br>
--- a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.1.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.1.bb</a><br>
+++ b/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.2.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.2.bb</a><br>
@@ -9,9 +9,9 @@ PROVIDES =3D &quot;go-native&quot;<br>
<br>
=C2=A0# Checksums available at <a href=3D"https://go.dev/dl/" rel=3D"norefe=
rrer" target=3D"_blank">https://go.dev/dl/</a><br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://dl.google.com/go/go$%7BPV%7D.$%7=
BBUILD_GOOS%7D-$%7BBUILD_GOARCH%7D.tar.gz;name=3Dgo_$%7BBUILD_GOTUPLE%7D" r=
el=3D"noreferrer" target=3D"_blank">https://dl.google.com/go/go${PV}.${BUIL=
D_GOOS}-${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}</a>&quot;<br>
-SRC_URI[go_linux_amd64.sha256sum] =3D &quot;cb2396bae64183cdccf81a9a6df0ae=
a3bce9511fc21469fb89a0c00470088073&quot;<br>
-SRC_URI[go_linux_arm64.sha256sum] =3D &quot;8df5750ffc0281017fb6070fba450f=
5d22b600a02081dceef47966ffaf36a3af&quot;<br>
-SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;0fb522efcefabae6e37e69bdc444=
094e75bfe824ea6d4cc3cbc70c7ae1b16858&quot;<br>
+SRC_URI[go_linux_amd64.sha256sum] =3D &quot;68097bd680839cbc9d464a0edce4f7=
c333975e27a90246890e9f1078c7e702ad&quot;<br>
+SRC_URI[go_linux_arm64.sha256sum] =3D &quot;756274ea4b68fa5535eb9fe2559889=
287d725a8da63c6aae4d5f23778c229f4b&quot;<br>
+SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;5fff857791d541c71d8ea0171c73=
f6f99770d15ff7e2ad979104856d01f36563&quot;<br>
<br>
=C2=A0UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://golang.org/dl/" rel=
=3D"noreferrer" target=3D"_blank">https://golang.org/dl/</a>&quot;<br>
=C2=A0UPSTREAM_CHECK_REGEX =3D &quot;go(?P&lt;pver&gt;\d+(\.\d+)+)\.linux&q=
uot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.1=
.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.1.bb</a> b=
/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.2.bb" rel=3D"=
noreferrer" target=3D"_blank">go-cross-canadian_1.24.2.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.1.=
bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.1.bb</a><br=
>
rename to recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.2.bb=
" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.2.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross_1.24.1.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.24.1.bb</a> b/recipes-devtools=
/go/<a href=3D"http://go-cross_1.24.2.bb" rel=3D"noreferrer" target=3D"_bla=
nk">go-cross_1.24.2.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross_1.24.1.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.24.1.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-cross_1.24.2.bb" rel=3D"=
noreferrer" target=3D"_blank">go-cross_1.24.2.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.1.bb" r=
el=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.1.bb</a> b/recipes-dev=
tools/go/<a href=3D"http://go-crosssdk_1.24.2.bb" rel=3D"noreferrer" target=
=3D"_blank">go-crosssdk_1.24.2.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.1.bb" re=
l=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.1.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.2.bb" rel=
=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.2.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-runtime_1.24.1.bb" re=
l=3D"noreferrer" target=3D"_blank">go-runtime_1.24.1.bb</a> b/recipes-devto=
ols/go/<a href=3D"http://go-runtime_1.24.2.bb" rel=3D"noreferrer" target=3D=
"_blank">go-runtime_1.24.2.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-runtime_1.24.1.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.24.1.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-runtime_1.24.2.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.24.2.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go_1.24.1.bb" rel=3D"nor=
eferrer" target=3D"_blank">go_1.24.1.bb</a> b/recipes-devtools/go/<a href=
=3D"http://go_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go_1.24.2.bb<=
/a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go_1.24.1.bb" rel=3D"nore=
ferrer" target=3D"_blank">go_1.24.1.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go_1.24.2.bb" rel=3D"norefe=
rrer" target=3D"_blank">go_1.24.2.bb</a><br>
-- <br>
2.34.1<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#1359): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/1359" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/1359</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/112206120/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/112206120/5052612</a><br>
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

--000000000000cfc07a06327dfac5--

