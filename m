Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92CEC3ABDD
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 16:18:03 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.25263.1747757875541715653
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 May 2025 09:17:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Aj2zEEwK;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: quaresma.jose@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7cad6a4fae4so949176085a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747757874; x=1748362674; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jhQKTsZUQYxwaWYGFMN9R80DiK54RUlU6nPmB3xT4F0=;
        b=Aj2zEEwKVdKTWJ6Dlc+aIlzZkRLsu5delwY6DOqQxiKZ1Xnz5BUd7ZXCHHG9/wKdPT
         VhM/Cpj/QgjHNOy+ry/kjGB9286Y4MHFyCc2embl/XHIWzzqFrOrODQJ9ySI1UzIEe2m
         3iRdm2wdJcUwpOSkys6R126SQXmfC20yicsLyEpqqOO+68ATuVpOZqQe+xdC6UT4upso
         +dBsBjF7rPZaMH/ZuWBmK9r0RxUmVrBypSljMAmwswww1od1YnUgMWRNr3DY3Vrwtkc9
         RG5km8LBVWsEAnrqrT/8aos7e43bmmK6x9u50wXkS9DYokYkNz649moBKjn4TXV0cBqh
         ZYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757874; x=1748362674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhQKTsZUQYxwaWYGFMN9R80DiK54RUlU6nPmB3xT4F0=;
        b=V9MPSdFHw1nrX/NQTdXELe772ug5ibG7xtcDgisDx2+n4AzDGTN8yNzj1zgXTvGmH5
         S9li9YIIB6uZIp81Lw/8KMDBnDWpvr3JuhcujOinpt95YqFj9dKPZ1MYOc8n8v4+lMQB
         R1IlGgwomjXtqOLxExM7ISdRTV2GpqkuwbfuSK0UdKYwN92bZpFNQLu58UEc0AF1ZqDz
         01syNosQHCcK+YhLGMPnitiT9K3c7n9IjryKtNdIFsWSwe4dSSD8dAD48FZlX1NkY7YW
         hcshPpopyigu7oKPIB+Ozi9/wB9bJBYOpXqagco4BtNH4Hss4u2RtPs5v6RmvvMgUpmF
         HQaQ==
X-Gm-Message-State: AOJu0YwCJWe3X6aagBR+PJjlgKZkmjhcI/tPlqrNC1Y4QoyUm5HJkWDN
	logLKByglRPnJCCIA3vrIBCtYHTWThhvrGtOaZeLeEO/UAYrcfgvP0gp9M1XTK8gwSRf90HJAL8
	ZkduEm+1qX+JkHA+429Fc1sze4GLt4ygLRxvfqOM=
X-Gm-Gg: ASbGncuoe1oV9oPtaH5k7zDknB8JKXs8G1WAIGa8fWFiWlYWrlM5uJECrFR/7zT60Ta
	Z+9LK41xIbnynkaL/dE0ON8YyjajS3bsuLQh+b6wxtW0JxJDdc1ooewvGqz/0MV1kmHZsBD43LV
	Sv8MkDcUebvu7pHf6oJOInoEx728hsESDg
X-Google-Smtp-Source: AGHT+IFYMhmq8juGd1k3Wb5Bf+qF7PzKUDB+EU1Gfhr3RtIwWDgoGDcOCluPruM/1eZqUWtu/IiBfjXPoLt2a2ui/Zk=
X-Received: by 2002:a05:620a:258c:b0:7c7:b59d:a6f2 with SMTP id
 af79cd13be357-7cd47effa5cmr1996598185a.10.1747757874279; Tue, 20 May 2025
 09:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250516162054.8214-1-peter.marko@siemens.com>
In-Reply-To: <20250516162054.8214-1-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Tue, 20 May 2025 17:17:42 +0100
X-Gm-Features: AX0GCFvbX2ZmFnpsKoQCbgTLx-1LLUBlds4c3He1mMtoVmadSaknx_Up1SuEVkQ
Message-ID: <CANPvuRmjv74K6FvSjpBSreQ3mfe4b7t7z0SJFDTkze8zOJc_LQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go:
 upgrade 1.24.2 -> 1.24.3
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io, Peter Marko <peter.marko@siemens.com>
Content-Type: multipart/alternative; boundary="0000000000003ffb1606359397fd"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 16:18:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1568

--0000000000003ffb1606359397fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied

Thanks

Jose

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (sexta, 16/05/2025 =C3=A0(s) 1=
7:21):

> From: Peter Marko <peter.marko@siemens.com>
>
> Upgrade to latest 1.24.x release [1]:
>
> $ git --no-pager log --oneline go1.24.2..go1.24.3
> 34c8b14ca9 (release-branch.go1.24) [release-branch.go1.24] go1.24.3
> 8947f3395e [release-branch.go1.24] os: avoid escape from Root via paths
> ending in ../
> 06fd2f115b [release-branch.go1.24] cmd/compile: remove no-longer-necessar=
y
> recursive inlining checks
> f66ab6521c [release-branch.go1.24] cmd/internal/obj/wasm: use i64 for
> large return addr
> c1f9c2c7b0 [release-branch.go1.24] cmd/go/internal/load: join incompatibl=
e
> and dirty build specifiers with .
> 0ab64e2caa [release-branch.go1.24] runtime: cleanup M vgetrandom state
> before dropping P
> 56eb99859d [release-branch.go1.24] internal/runtime/maps: pass proper fun=
c
> PC to race.WritePC/race.ReadPC
> 43130aff52 [release-branch.go1.24] runtime: fix 9-arg syscall on
> darwin/amd64
> b2c005e7b2 [release-branch.go1.24] crypto/tls: fix ECH compatibility
> a9d9b55709 [release-branch.go1.24] cmd/link: choose one with larger size
> for duplicated BSS symbols
> fa7217f74d [release-branch.go1.24] os: avoid panic in Root when symlink
> references the root
>
> Fixes CVE-2025-22873
>
> [1] https://github.com/golang/go/compare/go1.24.2...go1.24.3
>
> (From OE-Core rev: b317570acf1e25a4cfaa0c66a2630d082b4d0bae)
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  recipes-devtools/go/{go-1.24.2.inc =3D> go-1.24.3.inc}        | 2 +-
>  ...o-binary-native_1.24.2.bb =3D> go-binary-native_1.24.3.bb} | 6 +++---
>  ...cross-canadian_1.24.2.bb =3D> go-cross-canadian_1.24.3.bb} | 0
>  .../go/{go-cross_1.24.2.bb =3D> go-cross_1.24.3.bb}           | 0
>  .../go/{go-crosssdk_1.24.2.bb =3D> go-crosssdk_1.24.3.bb}     | 0
>  .../go/{go-runtime_1.24.2.bb =3D> go-runtime_1.24.3.bb}       | 0
>  recipes-devtools/go/{go_1.24.2.bb =3D> go_1.24.3.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.24.2.inc =3D> go-1.24.3.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.24.2.bb =3D>
> go-binary-native_1.24.3.bb} (78%)
>  rename recipes-devtools/go/{go-cross-canadian_1.24.2.bb =3D>
> go-cross-canadian_1.24.3.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.24.2.bb =3D> go-cross_1.24.3.bb}
> (100%)
>  rename recipes-devtools/go/{go-crosssdk_1.24.2.bb =3D>
> go-crosssdk_1.24.3.bb} (100%)
>  rename recipes-devtools/go/{go-runtime_1.24.2.bb =3D> go-runtime_1.24.3.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.24.2.bb =3D> go_1.24.3.bb} (100%)
>
> diff --git a/recipes-devtools/go/go-1.24.2.inc
> b/recipes-devtools/go/go-1.24.3.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.24.2.inc
> rename to recipes-devtools/go/go-1.24.3.inc
> index cb4ae9e..78e2614 100644
> --- a/recipes-devtools/go/go-1.24.2.inc
> +++ b/recipes-devtools/go/go-1.24.3.inc
> @@ -17,4 +17,4 @@ SRC_URI +=3D "\
>
>  file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
>      file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "9dc77ffadc16d837a1bf32d99c624cb4df0647cee7b119edd9e7b1bcc05f2e00"
> +SRC_URI[main.sha256sum] =3D
> "229c08b600b1446798109fae1f569228102c8473caba8104b6418cb5bc032878"
> diff --git a/recipes-devtools/go/go-binary-native_1.24.2.bb
> b/recipes-devtools/go/go-binary-native_1.24.3.bb
> similarity index 78%
> rename from recipes-devtools/go/go-binary-native_1.24.2.bb
> rename to recipes-devtools/go/go-binary-native_1.24.3.bb
> index 690b854..af56dc9 100644
> --- a/recipes-devtools/go/go-binary-native_1.24.2.bb
> +++ b/recipes-devtools/go/go-binary-native_1.24.3.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "
> https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOARCH}.tar.gz;nam=
e=3Dgo_${BUILD_GOTUPLE}
> "
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "68097bd680839cbc9d464a0edce4f7c333975e27a90246890e9f1078c7e702ad"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "756274ea4b68fa5535eb9fe2559889287d725a8da63c6aae4d5f23778c229f4b"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "5fff857791d541c71d8ea0171c73f6f99770d15ff7e2ad979104856d01f36563"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "3333f6ea53afa971e9078895eaa4ac7204a8c6b5c68c10e6bc9a33e8e391bdd8"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "a463cb59382bd7ae7d8f4c68846e73c4d589f223c589ac76871b66811ded7836"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "341a749d168f47b1d4dad25e32cae70849b7ceed7c290823b853c9e6b0df0856"
>
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.24.2.bb
> b/recipes-devtools/go/go-cross-canadian_1.24.3.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.24.2.bb
> rename to recipes-devtools/go/go-cross-canadian_1.24.3.bb
> diff --git a/recipes-devtools/go/go-cross_1.24.2.bb b/recipes-devtools/go=
/
> go-cross_1.24.3.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.24.2.bb
> rename to recipes-devtools/go/go-cross_1.24.3.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.24.2.bb
> b/recipes-devtools/go/go-crosssdk_1.24.3.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.24.2.bb
> rename to recipes-devtools/go/go-crosssdk_1.24.3.bb
> diff --git a/recipes-devtools/go/go-runtime_1.24.2.bb
> b/recipes-devtools/go/go-runtime_1.24.3.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.24.2.bb
> rename to recipes-devtools/go/go-runtime_1.24.3.bb
> diff --git a/recipes-devtools/go/go_1.24.2.bb b/recipes-devtools/go/
> go_1.24.3.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.24.2.bb
> rename to recipes-devtools/go/go_1.24.3.bb
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1560):
> https://lists.yoctoproject.org/g/yocto-patches/message/1560
> Mute This Topic: https://lists.yoctoproject.org/mt/113148068/5052612
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

--0000000000003ffb1606359397fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Applied</div><div><br></div><div>Thanks</div><div><br=
></div>Jose<div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">Peter Marko via <a href=3D"http://lists.yoc=
toproject.org">lists.yoctoproject.org</a> &lt;peter.marko=3D<a href=3D"mail=
to:siemens.com@lists.yoctoproject.org">siemens.com@lists.yoctoproject.org</=
a>&gt; escreveu (sexta, 16/05/2025 =C3=A0(s) 17:21):<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">From: Peter Marko &lt;<a href=3D"mailt=
o:peter.marko@siemens.com" target=3D"_blank">peter.marko@siemens.com</a>&gt=
;<br>
<br>
Upgrade to latest 1.24.x release [1]:<br>
<br>
$ git --no-pager log --oneline go1.24.2..go1.24.3<br>
34c8b14ca9 (release-branch.go1.24) [release-branch.go1.24] go1.24.3<br>
8947f3395e [release-branch.go1.24] os: avoid escape from Root via paths end=
ing in ../<br>
06fd2f115b [release-branch.go1.24] cmd/compile: remove no-longer-necessary =
recursive inlining checks<br>
f66ab6521c [release-branch.go1.24] cmd/internal/obj/wasm: use i64 for large=
 return addr<br>
c1f9c2c7b0 [release-branch.go1.24] cmd/go/internal/load: join incompatible =
and dirty build specifiers with .<br>
0ab64e2caa [release-branch.go1.24] runtime: cleanup M vgetrandom state befo=
re dropping P<br>
56eb99859d [release-branch.go1.24] internal/runtime/maps: pass proper func =
PC to race.WritePC/race.ReadPC<br>
43130aff52 [release-branch.go1.24] runtime: fix 9-arg syscall on darwin/amd=
64<br>
b2c005e7b2 [release-branch.go1.24] crypto/tls: fix ECH compatibility<br>
a9d9b55709 [release-branch.go1.24] cmd/link: choose one with larger size fo=
r duplicated BSS symbols<br>
fa7217f74d [release-branch.go1.24] os: avoid panic in Root when symlink ref=
erences the root<br>
<br>
Fixes CVE-2025-22873<br>
<br>
[1] <a href=3D"https://github.com/golang/go/compare/go1.24.2...go1.24.3" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/golang/go/compare/go1=
.24.2...go1.24.3</a><br>
<br>
(From OE-Core rev: b317570acf1e25a4cfaa0c66a2630d082b4d0bae)<br>
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
=C2=A0recipes-devtools/go/{go-1.24.2.inc =3D&gt; go-1.24.3.inc}=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0...<a href=3D"http://o-binary-native_1.24.2.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">o-binary-native_1.24.2.bb</a> =3D&gt; <a href=3D"http://go-=
binary-native_1.24.3.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-nat=
ive_1.24.3.bb</a>} | 6 +++---<br>
=C2=A0...<a href=3D"http://cross-canadian_1.24.2.bb" rel=3D"noreferrer" tar=
get=3D"_blank">cross-canadian_1.24.2.bb</a> =3D&gt; <a href=3D"http://go-cr=
oss-canadian_1.24.3.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canad=
ian_1.24.3.bb</a>} | 0<br>
=C2=A0.../go/{<a href=3D"http://go-cross_1.24.2.bb" rel=3D"noreferrer" targ=
et=3D"_blank">go-cross_1.24.2.bb</a> =3D&gt; <a href=3D"http://go-cross_1.2=
4.3.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1.24.3.bb</a>}=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-crosssdk_1.24.2.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-crosssdk_1.24.2.bb</a> =3D&gt; <a href=3D"http://go-cro=
sssdk_1.24.3.bb" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.3.bb=
</a>}=C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-runtime_1.24.2.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">go-runtime_1.24.2.bb</a> =3D&gt; <a href=3D"http://go-runti=
me_1.24.3.bb" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.24.3.bb</a>=
}=C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0recipes-devtools/go/{<a href=3D"http://go_1.24.2.bb" rel=3D"noreferre=
r" target=3D"_blank">go_1.24.2.bb</a> =3D&gt; <a href=3D"http://go_1.24.3.b=
b" rel=3D"noreferrer" target=3D"_blank">go_1.24.3.bb</a>}=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 0<br>
=C2=A07 files changed, 4 insertions(+), 4 deletions(-)<br>
=C2=A0rename recipes-devtools/go/{go-1.24.2.inc =3D&gt; go-1.24.3.inc} (91%=
)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-binary-native_1.24.2=
.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.2.bb</a> =
=3D&gt; <a href=3D"http://go-binary-native_1.24.3.bb" rel=3D"noreferrer" ta=
rget=3D"_blank">go-binary-native_1.24.3.bb</a>} (78%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross-canadian_1.24.=
2.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.2.bb</a> =
=3D&gt; <a href=3D"http://go-cross-canadian_1.24.3.bb" rel=3D"noreferrer" t=
arget=3D"_blank">go-cross-canadian_1.24.3.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross_1.24.2.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.24.2.bb</a> =3D&gt; <a href=3D=
"http://go-cross_1.24.3.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1=
.24.3.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-crosssdk_1.24.2.bb" =
rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.2.bb</a> =3D&gt; <a h=
ref=3D"http://go-crosssdk_1.24.3.bb" rel=3D"noreferrer" target=3D"_blank">g=
o-crosssdk_1.24.3.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-runtime_1.24.2.bb" r=
el=3D"noreferrer" target=3D"_blank">go-runtime_1.24.2.bb</a> =3D&gt; <a hre=
f=3D"http://go-runtime_1.24.3.bb" rel=3D"noreferrer" target=3D"_blank">go-r=
untime_1.24.3.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go_1.24.2.bb" rel=3D"no=
referrer" target=3D"_blank">go_1.24.2.bb</a> =3D&gt; <a href=3D"http://go_1=
.24.3.bb" rel=3D"noreferrer" target=3D"_blank">go_1.24.3.bb</a>} (100%)<br>
<br>
diff --git a/recipes-devtools/go/go-1.24.2.inc b/recipes-devtools/go/go-1.2=
4.3.inc<br>
similarity index 91%<br>
rename from recipes-devtools/go/go-1.24.2.inc<br>
rename to recipes-devtools/go/go-1.24.3.inc<br>
index cb4ae9e..78e2614 100644<br>
--- a/recipes-devtools/go/go-1.24.2.inc<br>
+++ b/recipes-devtools/go/go-1.24.3.inc<br>
@@ -17,4 +17,4 @@ SRC_URI +=3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-=
trimpath-.patch \<br>
=C2=A0 =C2=A0 =C2=A0file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \=
<br>
=C2=A0&quot;<br>
-SRC_URI[main.sha256sum] =3D &quot;9dc77ffadc16d837a1bf32d99c624cb4df0647ce=
e7b119edd9e7b1bcc05f2e00&quot;<br>
+SRC_URI[main.sha256sum] =3D &quot;229c08b600b1446798109fae1f569228102c8473=
caba8104b6418cb5bc032878&quot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.2.=
bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.2.bb</a> b/r=
ecipes-devtools/go/<a href=3D"http://go-binary-native_1.24.3.bb" rel=3D"nor=
eferrer" target=3D"_blank">go-binary-native_1.24.3.bb</a><br>
similarity index 78%<br>
rename from recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.2.b=
b" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.3.bb"=
 rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.3.bb</a><br>
index 690b854..af56dc9 100644<br>
--- a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.2.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.2.bb</a><br>
+++ b/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.3.bb" rel=
=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.3.bb</a><br>
@@ -9,9 +9,9 @@ PROVIDES =3D &quot;go-native&quot;<br>
<br>
=C2=A0# Checksums available at <a href=3D"https://go.dev/dl/" rel=3D"norefe=
rrer" target=3D"_blank">https://go.dev/dl/</a><br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://dl.google.com/go/go$%7BPV%7D.$%7=
BBUILD_GOOS%7D-$%7BBUILD_GOARCH%7D.tar.gz;name=3Dgo_$%7BBUILD_GOTUPLE%7D" r=
el=3D"noreferrer" target=3D"_blank">https://dl.google.com/go/go${PV}.${BUIL=
D_GOOS}-${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}</a>&quot;<br>
-SRC_URI[go_linux_amd64.sha256sum] =3D &quot;68097bd680839cbc9d464a0edce4f7=
c333975e27a90246890e9f1078c7e702ad&quot;<br>
-SRC_URI[go_linux_arm64.sha256sum] =3D &quot;756274ea4b68fa5535eb9fe2559889=
287d725a8da63c6aae4d5f23778c229f4b&quot;<br>
-SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;5fff857791d541c71d8ea0171c73=
f6f99770d15ff7e2ad979104856d01f36563&quot;<br>
+SRC_URI[go_linux_amd64.sha256sum] =3D &quot;3333f6ea53afa971e9078895eaa4ac=
7204a8c6b5c68c10e6bc9a33e8e391bdd8&quot;<br>
+SRC_URI[go_linux_arm64.sha256sum] =3D &quot;a463cb59382bd7ae7d8f4c68846e73=
c4d589f223c589ac76871b66811ded7836&quot;<br>
+SRC_URI[go_linux_ppc64le.sha256sum] =3D &quot;341a749d168f47b1d4dad25e32ca=
e70849b7ceed7c290823b853c9e6b0df0856&quot;<br>
<br>
=C2=A0UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://golang.org/dl/" rel=
=3D"noreferrer" target=3D"_blank">https://golang.org/dl/</a>&quot;<br>
=C2=A0UPSTREAM_CHECK_REGEX =3D &quot;go(?P&lt;pver&gt;\d+(\.\d+)+)\.linux&q=
uot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.2=
.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.2.bb</a> b=
/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.3.bb" rel=3D"=
noreferrer" target=3D"_blank">go-cross-canadian_1.24.3.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.2.=
bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.2.bb</a><br=
>
rename to recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.3.bb=
" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.3.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross_1.24.2.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.24.2.bb</a> b/recipes-devtools=
/go/<a href=3D"http://go-cross_1.24.3.bb" rel=3D"noreferrer" target=3D"_bla=
nk">go-cross_1.24.3.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross_1.24.2.bb" rel=
=3D"noreferrer" target=3D"_blank">go-cross_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-cross_1.24.3.bb" rel=3D"=
noreferrer" target=3D"_blank">go-cross_1.24.3.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.2.bb" r=
el=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.2.bb</a> b/recipes-dev=
tools/go/<a href=3D"http://go-crosssdk_1.24.3.bb" rel=3D"noreferrer" target=
=3D"_blank">go-crosssdk_1.24.3.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.2.bb" re=
l=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.3.bb" rel=
=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.3.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-runtime_1.24.2.bb" re=
l=3D"noreferrer" target=3D"_blank">go-runtime_1.24.2.bb</a> b/recipes-devto=
ols/go/<a href=3D"http://go-runtime_1.24.3.bb" rel=3D"noreferrer" target=3D=
"_blank">go-runtime_1.24.3.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-runtime_1.24.2.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-runtime_1.24.3.bb" rel=
=3D"noreferrer" target=3D"_blank">go-runtime_1.24.3.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go_1.24.2.bb" rel=3D"nor=
eferrer" target=3D"_blank">go_1.24.2.bb</a> b/recipes-devtools/go/<a href=
=3D"http://go_1.24.3.bb" rel=3D"noreferrer" target=3D"_blank">go_1.24.3.bb<=
/a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go_1.24.2.bb" rel=3D"nore=
ferrer" target=3D"_blank">go_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go_1.24.3.bb" rel=3D"norefe=
rrer" target=3D"_blank">go_1.24.3.bb</a><br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#1560): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/1560" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/1560</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/113148068/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/113148068/5052612</a><br>
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
div></div></div></div>

--0000000000003ffb1606359397fd--

