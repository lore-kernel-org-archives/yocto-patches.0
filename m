Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E29C2D0CD
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 09:49:07 +0000 (UTC)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
 by mx.groups.io with SMTP id smtpd.web11.7403.1747820940738445202
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 May 2025 02:49:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PASlvmIu;
 spf=pass (domain: gmail.com, ip: 209.85.217.47, mailfrom: quaresma.jose@gmail.com)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4dfa6818db0so1849160137.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 May 2025 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747820939; x=1748425739; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=plmrtvqxVOeVVGgJW811LaulamBJKRMneq0ST1d5Qjs=;
        b=PASlvmIuSwZ2uRkJWeNzbgHhfltyJ38xM3KnQ1nrU8g4IW9rK8BJhJJhm9Av0CGSLO
         vKhuf2pBvuvzXK1EYvW8eTRoNn7iOrPy1w2Y3XCfFQrMglaM91XZd/vPr/GyR9Yk2NoK
         86NhV0QcB1uyK4G7SizNkMtzSZxpha5pQFYdQsSJzezOD7iMDQ+ZadxV0Okk1xcdrHwO
         kqxxH68xJ9KgDC0TK6c2qK5xdugfiNDXuX+nmQCVnq083My7duyLAMgb2uYozWquBxhC
         J4jYgtwZMhlgtTWGQUrJHNijt3PZuCG7lH468s1wyfTGzvgMzrlF4qXWOLtuiVCyzqw9
         F6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747820939; x=1748425739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plmrtvqxVOeVVGgJW811LaulamBJKRMneq0ST1d5Qjs=;
        b=eLAmS2Gl66if4i7NfghYDpm74By1AE4Owq9q69GqOOq4vmCdaXrp55MAZ/4E1XuxEE
         aZoXs/ToDNipiThjCSrGkN46nBHhRlV5BlFN4zfI47JbDfItdeYx/XyGE9hPGTL2Axus
         AKB0iLkJUmNnnngFPs1922xEtvXq3P6jSXaNXxyY0mqknhQMfUqWUr45AHTsQHppuS/U
         tALYwDymNVQjFF517AltDWvEA4J35mppaDGg66qVP79aIEUtjKs5APufDPVMzXgcwY3g
         GSKFT6yNPAc3K05YNjku7yki4DXAQS7gwL1MxdwAyNtMli57JAufhxWCfduitJFut+qb
         Mq1Q==
X-Gm-Message-State: AOJu0YxeYNQl1Y4YLleqjQRX4QQpxSUvQFMYK6kIjDn0U7Iu6wEJfDT3
	JG6CPgVHmfOdZYSCX72lVQTrbwBDuqFxBv/MISfXOg9xSKytw5kxck028iCXQK1cTgoKipEgprs
	1IDmPn8bpHT3tG1XrFvGn2RCxm00TEVeC7AiXQ00=
X-Gm-Gg: ASbGncsG1VouEvtDkV3KaUL3jdESKjI3Za7EFKaB2hT4MgWC+jB14Jihj3pRImFS5Rr
	KtCBWyAiFvLjsGvmd7SNyiMM3baPvQglWgerx+7xFftyqmpIPxxBlGwv53W25BtHe3EkZFPeGsW
	KR5dcdsZfky/CG9yzZ0IZ2+dWBeHvkzKHj
X-Google-Smtp-Source: AGHT+IFMgyMgzDrEb0NejZ1Oa5/sw1IeSbRYqPCvQ9wvLcq3sM+weI0KJFRY0kZ9LBWvP0YR9DJ+wMYKI8xNCTpCVyU=
X-Received: by 2002:a05:6102:2ac3:b0:4dd:b9bc:df71 with SMTP id
 ada2fe7eead31-4e049e63e87mr16041320137.10.1747820939471; Wed, 21 May 2025
 02:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250516162054.8214-1-peter.marko@siemens.com>
 <CANPvuRmjv74K6FvSjpBSreQ3mfe4b7t7z0SJFDTkze8zOJc_LQ@mail.gmail.com> <AS1PR10MB56974D357FF1F4FCC20849B0FD9EA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS1PR10MB56974D357FF1F4FCC20849B0FD9EA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 21 May 2025 10:48:48 +0100
X-Gm-Features: AX0GCFvzXEaRYfaDvzsejk0taxH7Q5V2d9mcuKRdGioOlfucUm8ABH_9YImoSz8
Message-ID: <CANPvuRmszi7P=SzKJKAmaG7gQr1RngUaGPyD3b2ZSSmy3TCnCg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go:
 upgrade 1.24.2 -> 1.24.3
To: yocto-patches@lists.yoctoproject.org
Cc: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="0000000000003a762d0635a246c4"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 May 2025 09:49:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1574

--0000000000003a762d0635a246c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (quarta, 21/05/2025 =C3=A0(s)
07:15):

> Hi Jose
>
>
>
> I=E2=80=99m not seeing it in the mixins layer yet.
>

The patch is here
https://git.yoctoproject.org/meta-lts-mixins/commit/?h=3Dkirkstone/go&id=3D=
3e452059473f0ed49d421b6ebfa2bc2aa96645da
Maybe some issue with the mirrors, the webinterface is fully update to me
also.

Jose


>
>
> Peter
>
>
>
> *From:* Jose Quaresma <quaresma.jose@gmail.com>
> *Sent:* Tuesday, May 20, 2025 18:18
> *To:* yocto-patches@lists.yoctoproject.org
> *Cc:* jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1) <
> Peter.Marko@siemens.com>
> *Subject:* Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] go:
> upgrade 1.24.2 -> 1.24.3
>
>
>
> Applied
>
>
>
> Thanks
>
>
>
> Jose
>
>
>
> Peter Marko via lists.yoctoproject.org <peter.marko=3D
> siemens.com@lists.yoctoproject.org> escreveu (sexta, 16/05/2025 =C3=A0(s)
> 17:21):
>
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
> file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
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
>
>
>
>
>
> --
>
> Best regards,
>
>
> Jos=C3=A9 Quaresma
> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#1573)
> <https://lists.yoctoproject.org/g/yocto-patches/message/1573> | Reply to
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5Bmeta-lts-mixins%5D%5Bkirkstone%2Fgo%5D%5BPATCH%5D%20go%3A%20u=
pgrade%201.24.2%20-%3E%201.24.3>
> | Reply to Sender
> <peter.marko@siemens.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-patc=
hes%5D%20%5Bmeta-lts-mixins%5D%5Bkirkstone%2Fgo%5D%5BPATCH%5D%20go%3A%20upg=
rade%201.24.2%20-%3E%201.24.3>
> | Mute This Topic <https://lists.yoctoproject.org/mt/113148068/5052612> |=
 New
> Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/5052612> | Contac=
t
> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/5052612/15=
04338242/xyzzy>
> [quaresma.jose@gmail.com]
> _._,_._,_
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--0000000000003a762d0635a246c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Peter Marko via=
 <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;p=
eter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproject.org">siemens.=
com@lists.yoctoproject.org</a>&gt; escreveu (quarta, 21/05/2025 =C3=A0(s) 0=
7:15):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div clas=
s=3D"msg510716085992604121">





<div lang=3D"EN-US" style=3D"overflow-wrap: break-word;">
<div class=3D"m_510716085992604121WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif">Hi Jose<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif">I=E2=80=99m not seeing it in the mixins layer yet.</span></p></div>=
</div></div></blockquote><div><br>The patch is here=C2=A0<a href=3D"https:/=
/git.yoctoproject.org/meta-lts-mixins/commit/?h=3Dkirkstone/go&amp;id=3D3e4=
52059473f0ed49d421b6ebfa2bc2aa96645da">https://git.yoctoproject.org/meta-lt=
s-mixins/commit/?h=3Dkirkstone/go&amp;id=3D3e452059473f0ed49d421b6ebfa2bc2a=
a96645da</a></div><div>Maybe some issue with the mirrors,=C2=A0the webinter=
face is fully update to me also.<br><br>Jose<br>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div class=3D"msg510716085992604121"><di=
v lang=3D"EN-US" style=3D"overflow-wrap: break-word;"><div class=3D"m_51071=
6085992604121WordSection1"><p class=3D"MsoNormal"><span style=3D"font-size:=
10pt;font-family:Arial,sans-serif"><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif">Peter<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10pt;font-family:Arial,sans=
-serif"><u></u>=C2=A0<u></u></span></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:Calibri=
,sans-serif">From:</span></b><span style=3D"font-size:11pt;font-family:Cali=
bri,sans-serif"> Jose Quaresma &lt;<a href=3D"mailto:quaresma.jose@gmail.co=
m" target=3D"_blank">quaresma.jose@gmail.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, May 20, 2025 18:18<br>
<b>To:</b> <a href=3D"mailto:yocto-patches@lists.yoctoproject.org" target=
=3D"_blank">yocto-patches@lists.yoctoproject.org</a><br>
<b>Cc:</b> <a href=3D"mailto:jose.quaresma@foundries.io" target=3D"_blank">=
jose.quaresma@foundries.io</a>; Marko, Peter (FT D EU SK BFS1) &lt;<a href=
=3D"mailto:Peter.Marko@siemens.com" target=3D"_blank">Peter.Marko@siemens.c=
om</a>&gt;<br>
<b>Subject:</b> Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH] =
go: upgrade 1.24.2 -&gt; 1.24.3<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Applied<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<p class=3D"MsoNormal">Jose<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Peter Marko via <a href=3D"http://lists.yoctoproject=
.org" target=3D"_blank">lists.yoctoproject.org</a> &lt;peter.marko=3D<a hre=
f=3D"mailto:siemens.com@lists.yoctoproject.org" target=3D"_blank">siemens.c=
om@lists.yoctoproject.org</a>&gt; escreveu (sexta, 16/05/2025 =C3=A0(s) 17:=
21):<u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;b=
order-left:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin-left:4=
.8pt;margin-right:0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt">From: Peter Marko &lt;<=
a href=3D"mailto:peter.marko@siemens.com" target=3D"_blank">peter.marko@sie=
mens.com</a>&gt;<br>
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
[1] <a href=3D"https://github.com/golang/go/compare/go1.24.2...go1.24.3" ta=
rget=3D"_blank">
https://github.com/golang/go/compare/go1.24.2...go1.24.3</a><br>
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
=C2=A0...<a href=3D"http://o-binary-native_1.24.2.bb" target=3D"_blank">o-b=
inary-native_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go-binary-native_1.24.3.bb" target=3D"_blank">go-binary-n=
ative_1.24.3.bb</a>} | 6 +++---<br>
=C2=A0...<a href=3D"http://cross-canadian_1.24.2.bb" target=3D"_blank">cros=
s-canadian_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go-cross-canadian_1.24.3.bb" target=3D"_blank">go-cross-c=
anadian_1.24.3.bb</a>} | 0<br>
=C2=A0.../go/{<a href=3D"http://go-cross_1.24.2.bb" target=3D"_blank">go-cr=
oss_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go-cross_1.24.3.bb" target=3D"_blank">go-cross_1.24.3.bb<=
/a>}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-crosssdk_1.24.2.bb" target=3D"_blank">go=
-crosssdk_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go-crosssdk_1.24.3.bb" target=3D"_blank">go-crosssdk_1.24=
.3.bb</a>}=C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0.../go/{<a href=3D"http://go-runtime_1.24.2.bb" target=3D"_blank">go-=
runtime_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go-runtime_1.24.3.bb" target=3D"_blank">go-runtime_1.24.3=
.bb</a>}=C2=A0 =C2=A0 =C2=A0 =C2=A0| 0<br>
=C2=A0recipes-devtools/go/{<a href=3D"http://go_1.24.2.bb" target=3D"_blank=
">go_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go_1.24.3.bb" target=3D"_blank">go_1.24.3.bb</a>}=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 0<br>
=C2=A07 files changed, 4 insertions(+), 4 deletions(-)<br>
=C2=A0rename recipes-devtools/go/{go-1.24.2.inc =3D&gt; go-1.24.3.inc} (91%=
)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-binary-native_1.24.2=
.bb" target=3D"_blank">go-binary-native_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go-binary-native_1.24.3.bb" target=3D"_blank">go-binary-n=
ative_1.24.3.bb</a>} (78%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross-canadian_1.24.=
2.bb" target=3D"_blank">go-cross-canadian_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go-cross-canadian_1.24.3.bb" target=3D"_blank">go-cross-c=
anadian_1.24.3.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-cross_1.24.2.bb" tar=
get=3D"_blank">go-cross_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go-cross_1.24.3.bb" target=3D"_blank">go-cross_1.24.3.bb<=
/a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-crosssdk_1.24.2.bb" =
target=3D"_blank">go-crosssdk_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go-crosssdk_1.24.3.bb" target=3D"_blank">go-crosssdk_1.24=
.3.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go-runtime_1.24.2.bb" t=
arget=3D"_blank">go-runtime_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go-runtime_1.24.3.bb" target=3D"_blank">go-runtime_1.24.3=
.bb</a>} (100%)<br>
=C2=A0rename recipes-devtools/go/{<a href=3D"http://go_1.24.2.bb" target=3D=
"_blank">go_1.24.2.bb</a> =3D&gt;
<a href=3D"http://go_1.24.3.bb" target=3D"_blank">go_1.24.3.bb</a>} (100%)<=
br>
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
=C2=A0 =C2=A0 =C2=A0<a>file://0010-cmd-go-clear-GOROOT-for-func-ldShared-wh=
en-trimpath-.patch</a> \<br>
=C2=A0 =C2=A0 =C2=A0<a>file://6d265b008e3d106b2706645e5a88cd8e2fb98953.patc=
h</a> \<br>
=C2=A0&quot;<br>
-SRC_URI[main.sha256sum] =3D &quot;9dc77ffadc16d837a1bf32d99c624cb4df0647ce=
e7b119edd9e7b1bcc05f2e00&quot;<br>
+SRC_URI[main.sha256sum] =3D &quot;229c08b600b1446798109fae1f569228102c8473=
caba8104b6418cb5bc032878&quot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.2.=
bb" target=3D"_blank">go-binary-native_1.24.2.bb</a> b/recipes-devtools/go/=
<a href=3D"http://go-binary-native_1.24.3.bb" target=3D"_blank">go-binary-n=
ative_1.24.3.bb</a><br>
similarity index 78%<br>
rename from recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.2.b=
b" target=3D"_blank">go-binary-native_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.3.bb"=
 target=3D"_blank">go-binary-native_1.24.3.bb</a><br>
index 690b854..af56dc9 100644<br>
--- a/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.2.bb" tar=
get=3D"_blank">go-binary-native_1.24.2.bb</a><br>
+++ b/recipes-devtools/go/<a href=3D"http://go-binary-native_1.24.3.bb" tar=
get=3D"_blank">go-binary-native_1.24.3.bb</a><br>
@@ -9,9 +9,9 @@ PROVIDES =3D &quot;go-native&quot;<br>
<br>
=C2=A0# Checksums available at <a href=3D"https://go.dev/dl/" target=3D"_bl=
ank">https://go.dev/dl/</a><br>
=C2=A0SRC_URI =3D &quot;<a href=3D"https://dl.google.com/go/go$%7BPV%7D.$%7=
BBUILD_GOOS%7D-$%7BBUILD_GOARCH%7D.tar.gz;name=3Dgo_$%7BBUILD_GOTUPLE%7D" t=
arget=3D"_blank">https://dl.google.com/go/go${PV}.${BUILD_GOOS}-${BUILD_GOA=
RCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}</a>&quot;<br>
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
=C2=A0UPSTREAM_CHECK_URI =3D &quot;<a href=3D"https://golang.org/dl/" targe=
t=3D"_blank">https://golang.org/dl/</a>&quot;<br>
=C2=A0UPSTREAM_CHECK_REGEX =3D &quot;go(?P&lt;pver&gt;\d+(\.\d+)+)\.linux&q=
uot;<br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.2=
.bb" target=3D"_blank">go-cross-canadian_1.24.2.bb</a> b/recipes-devtools/g=
o/<a href=3D"http://go-cross-canadian_1.24.3.bb" target=3D"_blank">go-cross=
-canadian_1.24.3.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.2.=
bb" target=3D"_blank">go-cross-canadian_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-cross-canadian_1.24.3.bb=
" target=3D"_blank">go-cross-canadian_1.24.3.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-cross_1.24.2.bb" targ=
et=3D"_blank">go-cross_1.24.2.bb</a> b/recipes-devtools/go/<a href=3D"http:=
//go-cross_1.24.3.bb" target=3D"_blank">go-cross_1.24.3.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-cross_1.24.2.bb" targe=
t=3D"_blank">go-cross_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-cross_1.24.3.bb" target=
=3D"_blank">go-cross_1.24.3.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.2.bb" t=
arget=3D"_blank">go-crosssdk_1.24.2.bb</a> b/recipes-devtools/go/<a href=3D=
"http://go-crosssdk_1.24.3.bb" target=3D"_blank">go-crosssdk_1.24.3.bb</a><=
br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.2.bb" ta=
rget=3D"_blank">go-crosssdk_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-crosssdk_1.24.3.bb" targ=
et=3D"_blank">go-crosssdk_1.24.3.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go-runtime_1.24.2.bb" ta=
rget=3D"_blank">go-runtime_1.24.2.bb</a> b/recipes-devtools/go/<a href=3D"h=
ttp://go-runtime_1.24.3.bb" target=3D"_blank">go-runtime_1.24.3.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go-runtime_1.24.2.bb" tar=
get=3D"_blank">go-runtime_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go-runtime_1.24.3.bb" targe=
t=3D"_blank">go-runtime_1.24.3.bb</a><br>
diff --git a/recipes-devtools/go/<a href=3D"http://go_1.24.2.bb" target=3D"=
_blank">go_1.24.2.bb</a> b/recipes-devtools/go/<a href=3D"http://go_1.24.3.=
bb" target=3D"_blank">go_1.24.3.bb</a><br>
similarity index 100%<br>
rename from recipes-devtools/go/<a href=3D"http://go_1.24.2.bb" target=3D"_=
blank">go_1.24.2.bb</a><br>
rename to recipes-devtools/go/<a href=3D"http://go_1.24.3.bb" target=3D"_bl=
ank">go_1.24.3.bb</a><br>
<br>
<br>
<br>
<br>
<u></u><u></u></p>
</blockquote>
</div>
<div>
<p class=3D"MsoNormal"><br clear=3D"all">
<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<p class=3D"MsoNormal"><span class=3D"m_510716085992604121gmailsignaturepre=
fix">-- </span><u></u><u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Best regards,<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><br>
Jos=C3=A9 Quaresma<u></u><u></u></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>



<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/1573" tar=
get=3D"_blank">View/Reply Online (#1573)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re=
%3A%20%5Byocto-patches%5D%20%5Bmeta-lts-mixins%5D%5Bkirkstone%2Fgo%5D%5BPAT=
CH%5D%20go%3A%20upgrade%201.24.2%20-%3E%201.24.3" target=3D"_blank">Reply t=
o Group</a>
 =20
    | <a href=3D"mailto:peter.marko@siemens.com?subject=3DPrivate:%20Re:%20=
Re%3A%20%5Byocto-patches%5D%20%5Bmeta-lts-mixins%5D%5Bkirkstone%2Fgo%5D%5BP=
ATCH%5D%20go%3A%20upgrade%201.24.2%20-%3E%201.24.3" target=3D"_blank">Reply=
 to Sender</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/113148068/5052612" target=3D=
"_blank">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" target=3D=
"_blank">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/5052612" =
target=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank">Contact Group Owner</a> |

<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13170708/50=
52612/1504338242/xyzzy" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank">quaresma.jos=
e@gmail.com</a>]<br>
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></div></blockquote></div><div><br clear=3D"all"></div><div><b=
r></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"lt=
r" class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=
=A9 Quaresma</div></div></div></div>

--0000000000003a762d0635a246c4--

