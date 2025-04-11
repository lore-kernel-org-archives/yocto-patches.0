Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35093C36010
	for <webhook@archiver.kernel.org>; Fri, 11 Apr 2025 10:14:00 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
 by mx.groups.io with SMTP id smtpd.web11.22389.1744366432454708619
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Apr 2025 03:13:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CQ8Q0e10;
 spf=pass (domain: gmail.com, ip: 209.85.222.44, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso2702642241.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Apr 2025 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744366431; x=1744971231; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fR2h7zo2Fe18fc+p2PtYVHsFHsLx12SVSvB69L/9zoU=;
        b=CQ8Q0e10TYpjqwsLkIgopTsTm8VISowbYKn4niBqeJwAkahqWx0H3dOhfm9SgYbQel
         YmXn3Pl5/Dx1gertJBV1fxq8t2nnOkPFcGU2hNUE/UHS1TNcmjDr9wR+7eTgAda+srw6
         kgczI56Dw2nODnCUhivmV/CSQhLg4Cd7bFUVB2l+RgPHHUZphpv+cNBzpQ7HjzRY5GRY
         V60bYRAr8veb97yPSUPBa8tmmllHW8q1D7xRMt2BJE9ecxNgbXqY8B546qcJ9C51JDJ9
         W/gRjNFNP911gFAAs578rQaKMzIWcq9HZpwwNoo0aup4CL/A+hI9DqGtcPyIylz2/LBd
         koaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744366431; x=1744971231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR2h7zo2Fe18fc+p2PtYVHsFHsLx12SVSvB69L/9zoU=;
        b=RwoNl7yhFJhpva6G5XOX7BYUNyeRY+4hxd/IU+t6Od0lDbDTy2SmLPLE6ZhXIQnHZu
         Z1LT1FCjyaYfdp5gAUOomVwVgibMrcGy2gcrqOHAYSE8ZNn9oO/Cx3NT9Vw7zoKwCtN3
         +FdHwGkxLwMDGWA4aZdvBKdsY+b9RNUDZ6R63gOdgbuRMwC9TKsLQEyriV9CBkoFln1T
         P05P4Cl/4pdJkWs8zSpLcbfLodD9SNoapAuW+pZBxKOwgGO7z7lvON99O8m5lhDb254T
         mK6ftyY9eU0/qCLHV3MC/SqZtritn3Syyq03U3iGFvfZDNwHFBJVY5wehTHAqMjd0nNI
         UOIA==
X-Gm-Message-State: AOJu0YwsHwMJbyiW1YVuctNQOmz81sXHAprLfIGsDoVZ4ba336VkISob
	Ftcn/gY80XB6/6hern8DDOu9505nZytUc48eDXWV7zG3mBUugfRvc/F3gzQCTvBR7LL3yTIEr25
	H/uVSCE3tjNQzLX/Inrrvzi2UhW2dcwwINRw=
X-Gm-Gg: ASbGnctV684V8Hb+4LNEXMCy2tO72zJz1BsXeVjasonlDkQiWzsEJWOXlpVn4rtDKUm
	blgiK5EkZzDErKJO/fyCaK3onUDMgHQ9zhdhTVjGYF8dnqZVKqj+diBMG4JxzR8mk/+s+PHgFMB
	fI0sfsdRD1jY/Tw1Ss4opXL3o=
X-Google-Smtp-Source: AGHT+IGN4p2HG+zrfL+15Qr/6DdK3J0fvHfJDxoCSfNZtDBN3H4KC+euk7IoP0Xeh9laHyf8INXONfUvj+zIk9UbHxI=
X-Received: by 2002:a67:f687:0:b0:4c0:435b:5dd2 with SMTP id
 ada2fe7eead31-4c9d3e68648mr3971095137.1.1744366430940; Fri, 11 Apr 2025
 03:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250410165229.9748-1-peter.marko@siemens.com> <AS1PR10MB569751BF90E3B789828A992FFDB72@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS1PR10MB569751BF90E3B789828A992FFDB72@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Fri, 11 Apr 2025 11:13:39 +0100
X-Gm-Features: ATxdqUGkMIhsL_LBBPifjCUjhRwStcYDYdlUV2molBBuUAkcnZBCWl6jwy4nuz4
Message-ID: <CANPvuR=d8-8pF+gpjbp-Y_iMRNkrwW2O1LORFroMv7JmGPb8Fg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/go][PATCH] go:
 upgrade 1.24.1 -> 1.24.2
To: yocto-patches@lists.yoctoproject.org
Cc: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="00000000000079738e06327df5c3"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Apr 2025 10:14:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1360

--00000000000079738e06327df5c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (quinta, 10/04/2025 =C3=A0(s)
18:08):

> Should have been [kirkstone/go]...
> I hope it will be found anyway :-)
>
> Peter
>
>
Applied to kirkstone/go
Maybe we should have a scarthgap now. But this time I would like to have
some more tests and a CI for this, maybe have a copy on github or gitlab.
I'll try to find some time to think about it.

Jose

> -----Original Message-----
> > From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> > Sent: Thursday, April 10, 2025 18:52
> > To: yocto-patches@lists.yoctoproject.org
> > Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> > <Peter.Marko@siemens.com>
> > Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.24.1 ->
> 1.24.2
> >
> > From: Peter Marko <peter.marko@siemens.com>
> >
> > Upgrade to latest 1.24.x release [1]:
> >
> > $ git --no-pager log --oneline go1.24.0..go1.24.1
> > 339c903a75 (tag: go1.24.1) [release-branch.go1.24] go1.24.1
> > 334de7982f [release-branch.go1.24] all: updated vendored x/net with
> security fix
> > 5d6920842b [release-branch.go1.24] runtime/cgo: avoid errors from -
> > Wdeclaration-after-statement
> > 949eae84df [release-branch.go1.24] cmd/compile: don't pull constant
> offsets out of
> > pointer arithmetic
> > 0bfde51e0d [release-branch.go1.24] runtime: document that cleanups can
> run
> > concurrently with each other
> > 45a52718e3 [release-branch.go1.24] runtime/cgo: avoid errors from -
> > Wdeclaration-after-statement
> > 7f375e2c22 [release-branch.go1.24] reflect: let Value.Seq return the
> iteration
> > value correct type
> > 4070531920 [release-branch.go1.24] syscall: disable O_DIRECTORY on
> Windows
> > for js/wasm
> > 5ffdb9c88b [release-branch.go1.24] reflect: correctly handle method
> values in Seq
> > becc17ebcd [release-branch.go1.24] runtime: use WCLONE when waiting on
> pidfd
> > test child
> > d418e224ae [release-branch.go1.24] syscall: don't send child signal whe=
n
> testing
> > pidfd
> > 456eaf5c29 [release-branch.go1.24] cmd/compile: don't report newLimit
> > discovered when unsat happens multiple times
> > e4ef83383e [release-branch.go1.24] debug/buildinfo: base64-encode test
> binaries
> > 4e6d3468cc [release-branch.go1.24] cmd/compile: ensure we don't reuse
> > temporary register
> > f5c388313f [release-branch.go1.24] internal/godebugs: add fips140 as an
> opaque
> > godebug setting
> > af236716b2 [release-branch.go1.24] cmd/compile, runtime: use deferretur=
n
> as
> > target PC for recover from deferrangefunc
> > 0f7b7600fb [release-branch.go1.24] doc/godebug: mention GODEBUG=3Dfips1=
40
> > eb58df7dbf [release-branch.go1.24] cmd/compile: avoid infinite recursio=
n
> when
> > inlining closures
> > 30f4d9e117 [release-branch.go1.24] syscall: don't truncate newly create=
d
> files on
> > Windows
> > bb0e5c2045 [release-branch.go1.24] runtime: fix usleep on s390x/linux
> > cd0e528d3d [release-branch.go1.24] runtime: add some linknames back for
> > `github.com/bytedance/sonic` <http://github.com/bytedance/sonic>
> > 80e2e474b8 [release-branch.go1.24] cmd/go: initialize req.Header when
> loading
> > git credential
> >
> > Fixes CVE-2025-22871
> >
> > [1] https://github.com/golang/go/compare/go1.24.1...go1.24.2
> >
> > (From OE-Core rev: c83927d94bc0afe2205324a976e9495d6df00caf)
> >
> > Signed-off-by: Peter Marko <peter.marko@siemens.com>
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  recipes-devtools/go/{go-1.24.1.inc =3D> go-1.24.2.inc}        | 2 +-
> >  ...o-binary-native_1.24.1.bb =3D> go-binary-native_1.24.2.bb} | 6 +++-=
--
> >  ...cross-canadian_1.24.1.bb =3D> go-cross-canadian_1.24.2.bb} | 0
> >  .../go/{go-cross_1.24.1.bb =3D> go-cross_1.24.2.bb}           | 0
> >  .../go/{go-crosssdk_1.24.1.bb =3D> go-crosssdk_1.24.2.bb}     | 0
> >  .../go/{go-runtime_1.24.1.bb =3D> go-runtime_1.24.2.bb}       | 0
> >  recipes-devtools/go/{go_1.24.1.bb =3D> go_1.24.2.bb}          | 0
> >  7 files changed, 4 insertions(+), 4 deletions(-)
> >  rename recipes-devtools/go/{go-1.24.1.inc =3D> go-1.24.2.inc} (91%)
> >  rename recipes-devtools/go/{go-binary-native_1.24.1.bb =3D> go-binary-
> > native_1.24.2.bb} (78%)
> >  rename recipes-devtools/go/{go-cross-canadian_1.24.1.bb =3D> go-cross-
> > canadian_1.24.2.bb} (100%)
> >  rename recipes-devtools/go/{go-cross_1.24.1.bb =3D> go-cross_1.24.2.bb=
}
> (100%)
> >  rename recipes-devtools/go/{go-crosssdk_1.24.1.bb =3D>
> go-crosssdk_1.24.2.bb}
> > (100%)
> >  rename recipes-devtools/go/{go-runtime_1.24.1.bb =3D>
> go-runtime_1.24.2.bb}
> > (100%)
> >  rename recipes-devtools/go/{go_1.24.1.bb =3D> go_1.24.2.bb} (100%)
> >
> > diff --git a/recipes-devtools/go/go-1.24.1.inc
> b/recipes-devtools/go/go-1.24.2.inc
> > similarity index 91%
> > rename from recipes-devtools/go/go-1.24.1.inc
> > rename to recipes-devtools/go/go-1.24.2.inc
> > index 4cf66e7..cb4ae9e 100644
> > --- a/recipes-devtools/go/go-1.24.1.inc
> > +++ b/recipes-devtools/go/go-1.24.2.inc
> > @@ -17,4 +17,4 @@ SRC_URI +=3D "\
> >
> file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
> >      file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patch \
> >  "
> > -SRC_URI[main.sha256sum] =3D
> > "8244ebf46c65607db10222b5806aeb31c1fcf8979c1b6b12f60c677e9a3c0656"
> > +SRC_URI[main.sha256sum] =3D
> > "9dc77ffadc16d837a1bf32d99c624cb4df0647cee7b119edd9e7b1bcc05f2e00"
> > diff --git a/recipes-devtools/go/go-binary-native_1.24.1.bb b/recipes-
> > devtools/go/go-binary-native_1.24.2.bb
> > similarity index 78%
> > rename from recipes-devtools/go/go-binary-native_1.24.1.bb
> > rename to recipes-devtools/go/go-binary-native_1.24.2.bb
> > index ffe3d50..690b854 100644
> > --- a/recipes-devtools/go/go-binary-native_1.24.1.bb
> > +++ b/recipes-devtools/go/go-binary-native_1.24.2.bb
> > @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
> >
> >  # Checksums available at https://go.dev/dl/
> >  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> > ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> > -SRC_URI[go_linux_amd64.sha256sum] =3D
> > "cb2396bae64183cdccf81a9a6df0aea3bce9511fc21469fb89a0c00470088073"
> > -SRC_URI[go_linux_arm64.sha256sum] =3D
> > "8df5750ffc0281017fb6070fba450f5d22b600a02081dceef47966ffaf36a3af"
> > -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> > "0fb522efcefabae6e37e69bdc444094e75bfe824ea6d4cc3cbc70c7ae1b16858"
> > +SRC_URI[go_linux_amd64.sha256sum] =3D
> > "68097bd680839cbc9d464a0edce4f7c333975e27a90246890e9f1078c7e702ad"
> > +SRC_URI[go_linux_arm64.sha256sum] =3D
> > "756274ea4b68fa5535eb9fe2559889287d725a8da63c6aae4d5f23778c229f4b"
> > +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> > "5fff857791d541c71d8ea0171c73f6f99770d15ff7e2ad979104856d01f36563"
> >
> >  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
> >  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> > diff --git a/recipes-devtools/go/go-cross-canadian_1.24.1.bb b/recipes-
> > devtools/go/go-cross-canadian_1.24.2.bb
> > similarity index 100%
> > rename from recipes-devtools/go/go-cross-canadian_1.24.1.bb
> > rename to recipes-devtools/go/go-cross-canadian_1.24.2.bb
> > diff --git a/recipes-devtools/go/go-cross_1.24.1.bb
> b/recipes-devtools/go/go-
> > cross_1.24.2.bb
> > similarity index 100%
> > rename from recipes-devtools/go/go-cross_1.24.1.bb
> > rename to recipes-devtools/go/go-cross_1.24.2.bb
> > diff --git a/recipes-devtools/go/go-crosssdk_1.24.1.bb
> b/recipes-devtools/go/go-
> > crosssdk_1.24.2.bb
> > similarity index 100%
> > rename from recipes-devtools/go/go-crosssdk_1.24.1.bb
> > rename to recipes-devtools/go/go-crosssdk_1.24.2.bb
> > diff --git a/recipes-devtools/go/go-runtime_1.24.1.bb
> b/recipes-devtools/go/go-
> > runtime_1.24.2.bb
> > similarity index 100%
> > rename from recipes-devtools/go/go-runtime_1.24.1.bb
> > rename to recipes-devtools/go/go-runtime_1.24.2.bb
> > diff --git a/recipes-devtools/go/go_1.24.1.bb b/recipes-devtools/go/
> go_1.24.2.bb
> > similarity index 100%
> > rename from recipes-devtools/go/go_1.24.1.bb
> > rename to recipes-devtools/go/go_1.24.2.bb
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1358):
> https://lists.yoctoproject.org/g/yocto-patches/message/1358
> Mute This Topic: https://lists.yoctoproject.org/mt/112195136/5052612
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

--00000000000079738e06327df5c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Peter Marko via=
 <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;p=
eter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproject.org">siemens.=
com@lists.yoctoproject.org</a>&gt; escreveu (quinta, 10/04/2025 =C3=A0(s) 1=
8:08):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Should ha=
ve been [kirkstone/go]...<br>
I hope it will be found anyway :-)<br>
<br>
Peter<br>
<br></blockquote><div>=C2=A0</div><div>Applied to kirkstone/go<br>Maybe we =
should have a scarthgap now. But this time I would like to have some more t=
ests and a CI for this, maybe have a copy on github or gitlab.</div><div>I&=
#39;ll try to find some time to think about it.<br><br>Jose<br><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
&gt; -----Original Message-----<br>
&gt; From: Marko, Peter (FT D EU SK BFS1) &lt;<a href=3D"mailto:Peter.Marko=
@siemens.com" target=3D"_blank">Peter.Marko@siemens.com</a>&gt;<br>
&gt; Sent: Thursday, April 10, 2025 18:52<br>
&gt; To: <a href=3D"mailto:yocto-patches@lists.yoctoproject.org" target=3D"=
_blank">yocto-patches@lists.yoctoproject.org</a><br>
&gt; Cc: <a href=3D"mailto:jose.quaresma@foundries.io" target=3D"_blank">jo=
se.quaresma@foundries.io</a>; Marko, Peter (FT D EU SK BFS1)<br>
&gt; &lt;<a href=3D"mailto:Peter.Marko@siemens.com" target=3D"_blank">Peter=
.Marko@siemens.com</a>&gt;<br>
&gt; Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.24.1 -&g=
t; 1.24.2<br>
&gt; <br>
&gt; From: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" targe=
t=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
&gt; <br>
&gt; Upgrade to latest 1.24.x release [1]:<br>
&gt; <br>
&gt; $ git --no-pager log --oneline go1.24.0..go1.24.1<br>
&gt; 339c903a75 (tag: go1.24.1) [release-branch.go1.24] go1.24.1<br>
&gt; 334de7982f [release-branch.go1.24] all: updated vendored x/net with se=
curity fix<br>
&gt; 5d6920842b [release-branch.go1.24] runtime/cgo: avoid errors from -<br=
>
&gt; Wdeclaration-after-statement<br>
&gt; 949eae84df [release-branch.go1.24] cmd/compile: don&#39;t pull constan=
t offsets out of<br>
&gt; pointer arithmetic<br>
&gt; 0bfde51e0d [release-branch.go1.24] runtime: document that cleanups can=
 run<br>
&gt; concurrently with each other<br>
&gt; 45a52718e3 [release-branch.go1.24] runtime/cgo: avoid errors from -<br=
>
&gt; Wdeclaration-after-statement<br>
&gt; 7f375e2c22 [release-branch.go1.24] reflect: let Value.Seq return the i=
teration<br>
&gt; value correct type<br>
&gt; 4070531920 [release-branch.go1.24] syscall: disable O_DIRECTORY on Win=
dows<br>
&gt; for js/wasm<br>
&gt; 5ffdb9c88b [release-branch.go1.24] reflect: correctly handle method va=
lues in Seq<br>
&gt; becc17ebcd [release-branch.go1.24] runtime: use WCLONE when waiting on=
 pidfd<br>
&gt; test child<br>
&gt; d418e224ae [release-branch.go1.24] syscall: don&#39;t send child signa=
l when testing<br>
&gt; pidfd<br>
&gt; 456eaf5c29 [release-branch.go1.24] cmd/compile: don&#39;t report newLi=
mit<br>
&gt; discovered when unsat happens multiple times<br>
&gt; e4ef83383e [release-branch.go1.24] debug/buildinfo: base64-encode test=
 binaries<br>
&gt; 4e6d3468cc [release-branch.go1.24] cmd/compile: ensure we don&#39;t re=
use<br>
&gt; temporary register<br>
&gt; f5c388313f [release-branch.go1.24] internal/godebugs: add fips140 as a=
n opaque<br>
&gt; godebug setting<br>
&gt; af236716b2 [release-branch.go1.24] cmd/compile, runtime: use deferretu=
rn as<br>
&gt; target PC for recover from deferrangefunc<br>
&gt; 0f7b7600fb [release-branch.go1.24] doc/godebug: mention GODEBUG=3Dfips=
140<br>
&gt; eb58df7dbf [release-branch.go1.24] cmd/compile: avoid infinite recursi=
on when<br>
&gt; inlining closures<br>
&gt; 30f4d9e117 [release-branch.go1.24] syscall: don&#39;t truncate newly c=
reated files on<br>
&gt; Windows<br>
&gt; bb0e5c2045 [release-branch.go1.24] runtime: fix usleep on s390x/linux<=
br>
&gt; cd0e528d3d [release-branch.go1.24] runtime: add some linknames back fo=
r<br>
&gt; `<a href=3D"http://github.com/bytedance/sonic" rel=3D"noreferrer" targ=
et=3D"_blank">github.com/bytedance/sonic`</a><br>
&gt; 80e2e474b8 [release-branch.go1.24] cmd/go: initialize req.Header when =
loading<br>
&gt; git credential<br>
&gt; <br>
&gt; Fixes CVE-2025-22871<br>
&gt; <br>
&gt; [1] <a href=3D"https://github.com/golang/go/compare/go1.24.1...go1.24.=
2" rel=3D"noreferrer" target=3D"_blank">https://github.com/golang/go/compar=
e/go1.24.1...go1.24.2</a><br>
&gt; <br>
&gt; (From OE-Core rev: c83927d94bc0afe2205324a976e9495d6df00caf)<br>
&gt; <br>
&gt; Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.c=
om" target=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
&gt; Signed-off-by: Mathieu Dubois-Briand &lt;<a href=3D"mailto:mathieu.dub=
ois-briand@bootlin.com" target=3D"_blank">mathieu.dubois-briand@bootlin.com=
</a>&gt;<br>
&gt; Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&=
gt;<br>
&gt; ---<br>
&gt;=C2=A0 recipes-devtools/go/{go-1.24.1.inc =3D&gt; go-1.24.2.inc}=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 ...<a href=3D"http://o-binary-native_1.24.1.bb" rel=3D"noreferre=
r" target=3D"_blank">o-binary-native_1.24.1.bb</a> =3D&gt; <a href=3D"http:=
//go-binary-native_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-binar=
y-native_1.24.2.bb</a>} | 6 +++---<br>
&gt;=C2=A0 ...<a href=3D"http://cross-canadian_1.24.1.bb" rel=3D"noreferrer=
" target=3D"_blank">cross-canadian_1.24.1.bb</a> =3D&gt; <a href=3D"http://=
go-cross-canadian_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-=
canadian_1.24.2.bb</a>} | 0<br>
&gt;=C2=A0 .../go/{<a href=3D"http://go-cross_1.24.1.bb" rel=3D"noreferrer"=
 target=3D"_blank">go-cross_1.24.1.bb</a> =3D&gt; <a href=3D"http://go-cros=
s_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-cross_1.24.2.bb</a>}=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
&gt;=C2=A0 .../go/{<a href=3D"http://go-crosssdk_1.24.1.bb" rel=3D"noreferr=
er" target=3D"_blank">go-crosssdk_1.24.1.bb</a> =3D&gt; <a href=3D"http://g=
o-crosssdk_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24=
.2.bb</a>}=C2=A0 =C2=A0 =C2=A0| 0<br>
&gt;=C2=A0 .../go/{<a href=3D"http://go-runtime_1.24.1.bb" rel=3D"noreferre=
r" target=3D"_blank">go-runtime_1.24.1.bb</a> =3D&gt; <a href=3D"http://go-=
runtime_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.24.2.b=
b</a>}=C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
&gt;=C2=A0 recipes-devtools/go/{<a href=3D"http://go_1.24.1.bb" rel=3D"nore=
ferrer" target=3D"_blank">go_1.24.1.bb</a> =3D&gt; <a href=3D"http://go_1.2=
4.2.bb" rel=3D"noreferrer" target=3D"_blank">go_1.24.2.bb</a>}=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 0<br>
&gt;=C2=A0 7 files changed, 4 insertions(+), 4 deletions(-)<br>
&gt;=C2=A0 rename recipes-devtools/go/{go-1.24.1.inc =3D&gt; go-1.24.2.inc}=
 (91%)<br>
&gt;=C2=A0 rename recipes-devtools/go/{<a href=3D"http://go-binary-native_1=
.24.1.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.1.bb</=
a> =3D&gt; go-binary-<br>
&gt; <a href=3D"http://native_1.24.2.bb" rel=3D"noreferrer" target=3D"_blan=
k">native_1.24.2.bb</a>} (78%)<br>
&gt;=C2=A0 rename recipes-devtools/go/{<a href=3D"http://go-cross-canadian_=
1.24.1.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.1.bb=
</a> =3D&gt; go-cross-<br>
&gt; <a href=3D"http://canadian_1.24.2.bb" rel=3D"noreferrer" target=3D"_bl=
ank">canadian_1.24.2.bb</a>} (100%)<br>
&gt;=C2=A0 rename recipes-devtools/go/{<a href=3D"http://go-cross_1.24.1.bb=
" rel=3D"noreferrer" target=3D"_blank">go-cross_1.24.1.bb</a> =3D&gt; <a hr=
ef=3D"http://go-cross_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go-cr=
oss_1.24.2.bb</a>} (100%)<br>
&gt;=C2=A0 rename recipes-devtools/go/{<a href=3D"http://go-crosssdk_1.24.1=
.bb" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.1.bb</a> =3D&gt;=
 <a href=3D"http://go-crosssdk_1.24.2.bb" rel=3D"noreferrer" target=3D"_bla=
nk">go-crosssdk_1.24.2.bb</a>}<br>
&gt; (100%)<br>
&gt;=C2=A0 rename recipes-devtools/go/{<a href=3D"http://go-runtime_1.24.1.=
bb" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.24.1.bb</a> =3D&gt; <=
a href=3D"http://go-runtime_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank"=
>go-runtime_1.24.2.bb</a>}<br>
&gt; (100%)<br>
&gt;=C2=A0 rename recipes-devtools/go/{<a href=3D"http://go_1.24.1.bb" rel=
=3D"noreferrer" target=3D"_blank">go_1.24.1.bb</a> =3D&gt; <a href=3D"http:=
//go_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go_1.24.2.bb</a>} (100=
%)<br>
&gt; <br>
&gt; diff --git a/recipes-devtools/go/go-1.24.1.inc b/recipes-devtools/go/g=
o-1.24.2.inc<br>
&gt; similarity index 91%<br>
&gt; rename from recipes-devtools/go/go-1.24.1.inc<br>
&gt; rename to recipes-devtools/go/go-1.24.2.inc<br>
&gt; index 4cf66e7..cb4ae9e 100644<br>
&gt; --- a/recipes-devtools/go/go-1.24.1.inc<br>
&gt; +++ b/recipes-devtools/go/go-1.24.2.inc<br>
&gt; @@ -17,4 +17,4 @@ SRC_URI +=3D &quot;\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 file://0010-cmd-go-clear-GOROOT-for-func-ldShared-=
when-trimpath-.patch \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 file://6d265b008e3d106b2706645e5a88cd8e2fb98953.pa=
tch \<br>
&gt;=C2=A0 &quot;<br>
&gt; -SRC_URI[main.sha256sum] =3D<br>
&gt; &quot;8244ebf46c65607db10222b5806aeb31c1fcf8979c1b6b12f60c677e9a3c0656=
&quot;<br>
&gt; +SRC_URI[main.sha256sum] =3D<br>
&gt; &quot;9dc77ffadc16d837a1bf32d99c624cb4df0647cee7b119edd9e7b1bcc05f2e00=
&quot;<br>
&gt; diff --git a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.=
24.1.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.1.bb</a=
> b/recipes-<br>
&gt; devtools/go/<a href=3D"http://go-binary-native_1.24.2.bb" rel=3D"noref=
errer" target=3D"_blank">go-binary-native_1.24.2.bb</a><br>
&gt; similarity index 78%<br>
&gt; rename from recipes-devtools/go/<a href=3D"http://go-binary-native_1.2=
4.1.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.1.bb</a>=
<br>
&gt; rename to recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.=
2.bb" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.2.bb</a><b=
r>
&gt; index ffe3d50..690b854 100644<br>
&gt; --- a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.1.bb=
" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.1.bb</a><br>
&gt; +++ b/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.2.bb=
" rel=3D"noreferrer" target=3D"_blank">go-binary-native_1.24.2.bb</a><br>
&gt; @@ -9,9 +9,9 @@ PROVIDES =3D &quot;go-native&quot;<br>
&gt; <br>
&gt;=C2=A0 # Checksums available at <a href=3D"https://go.dev/dl/" rel=3D"n=
oreferrer" target=3D"_blank">https://go.dev/dl/</a><br>
&gt;=C2=A0 SRC_URI =3D &quot;<a href=3D"https://dl.google.com/go/go$%7BPV%7=
D.$%7BBUILD_GOOS%7D-" rel=3D"noreferrer" target=3D"_blank">https://dl.googl=
e.com/go/go${PV}.${BUILD_GOOS}-</a><br>
&gt; ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}&quot;<br>
&gt; -SRC_URI[go_linux_amd64.sha256sum] =3D<br>
&gt; &quot;cb2396bae64183cdccf81a9a6df0aea3bce9511fc21469fb89a0c00470088073=
&quot;<br>
&gt; -SRC_URI[go_linux_arm64.sha256sum] =3D<br>
&gt; &quot;8df5750ffc0281017fb6070fba450f5d22b600a02081dceef47966ffaf36a3af=
&quot;<br>
&gt; -SRC_URI[go_linux_ppc64le.sha256sum] =3D<br>
&gt; &quot;0fb522efcefabae6e37e69bdc444094e75bfe824ea6d4cc3cbc70c7ae1b16858=
&quot;<br>
&gt; +SRC_URI[go_linux_amd64.sha256sum] =3D<br>
&gt; &quot;68097bd680839cbc9d464a0edce4f7c333975e27a90246890e9f1078c7e702ad=
&quot;<br>
&gt; +SRC_URI[go_linux_arm64.sha256sum] =3D<br>
&gt; &quot;756274ea4b68fa5535eb9fe2559889287d725a8da63c6aae4d5f23778c229f4b=
&quot;<br>
&gt; +SRC_URI[go_linux_ppc64le.sha256sum] =3D<br>
&gt; &quot;5fff857791d541c71d8ea0171c73f6f99770d15ff7e2ad979104856d01f36563=
&quot;<br>
&gt; <br>
&gt;=C2=A0 UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://golang.org/dl/" =
rel=3D"noreferrer" target=3D"_blank">https://golang.org/dl/</a>&quot;<br>
&gt;=C2=A0 UPSTREAM_CHECK_REGEX =3D &quot;go(?P&lt;pver&gt;\d+(\.\d+)+)\.li=
nux&quot;<br>
&gt; diff --git a/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1=
.24.1.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.1.bb<=
/a> b/recipes-<br>
&gt; devtools/go/<a href=3D"http://go-cross-canadian_1.24.2.bb" rel=3D"nore=
ferrer" target=3D"_blank">go-cross-canadian_1.24.2.bb</a><br>
&gt; similarity index 100%<br>
&gt; rename from recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.=
24.1.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.1.bb</=
a><br>
&gt; rename to recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24=
.2.bb" rel=3D"noreferrer" target=3D"_blank">go-cross-canadian_1.24.2.bb</a>=
<br>
&gt; diff --git a/recipes-devtools/go/<a href=3D"http://go-cross_1.24.1.bb"=
 rel=3D"noreferrer" target=3D"_blank">go-cross_1.24.1.bb</a> b/recipes-devt=
ools/go/go-<br>
&gt; <a href=3D"http://cross_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank=
">cross_1.24.2.bb</a><br>
&gt; similarity index 100%<br>
&gt; rename from recipes-devtools/go/<a href=3D"http://go-cross_1.24.1.bb" =
rel=3D"noreferrer" target=3D"_blank">go-cross_1.24.1.bb</a><br>
&gt; rename to recipes-devtools/go/<a href=3D"http://go-cross_1.24.2.bb" re=
l=3D"noreferrer" target=3D"_blank">go-cross_1.24.2.bb</a><br>
&gt; diff --git a/recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.1.=
bb" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.1.bb</a> b/recipe=
s-devtools/go/go-<br>
&gt; <a href=3D"http://crosssdk_1.24.2.bb" rel=3D"noreferrer" target=3D"_bl=
ank">crosssdk_1.24.2.bb</a><br>
&gt; similarity index 100%<br>
&gt; rename from recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.1.b=
b" rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.1.bb</a><br>
&gt; rename to recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.2.bb"=
 rel=3D"noreferrer" target=3D"_blank">go-crosssdk_1.24.2.bb</a><br>
&gt; diff --git a/recipes-devtools/go/<a href=3D"http://go-runtime_1.24.1.b=
b" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.24.1.bb</a> b/recipes-=
devtools/go/go-<br>
&gt; <a href=3D"http://runtime_1.24.2.bb" rel=3D"noreferrer" target=3D"_bla=
nk">runtime_1.24.2.bb</a><br>
&gt; similarity index 100%<br>
&gt; rename from recipes-devtools/go/<a href=3D"http://go-runtime_1.24.1.bb=
" rel=3D"noreferrer" target=3D"_blank">go-runtime_1.24.1.bb</a><br>
&gt; rename to recipes-devtools/go/<a href=3D"http://go-runtime_1.24.2.bb" =
rel=3D"noreferrer" target=3D"_blank">go-runtime_1.24.2.bb</a><br>
&gt; diff --git a/recipes-devtools/go/<a href=3D"http://go_1.24.1.bb" rel=
=3D"noreferrer" target=3D"_blank">go_1.24.1.bb</a> b/recipes-devtools/go/<a=
 href=3D"http://go_1.24.2.bb" rel=3D"noreferrer" target=3D"_blank">go_1.24.=
2.bb</a><br>
&gt; similarity index 100%<br>
&gt; rename from recipes-devtools/go/<a href=3D"http://go_1.24.1.bb" rel=3D=
"noreferrer" target=3D"_blank">go_1.24.1.bb</a><br>
&gt; rename to recipes-devtools/go/<a href=3D"http://go_1.24.2.bb" rel=3D"n=
oreferrer" target=3D"_blank">go_1.24.2.bb</a><br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#1358): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/1358" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/1358</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/112195136/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/112195136/5052612</a><br>
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

--00000000000079738e06327df5c3--

