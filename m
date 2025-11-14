Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5485CE7AF8
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:57:39 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16349.1763121452238950744
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 03:57:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZUJotCbC;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7359b03878so236265366b.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 03:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763121450; x=1763726250; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W6IxYQ1B4hBv9yvs8lsDW8v1A4dO1r/XtQzuINEZhaQ=;
        b=ZUJotCbCM4fS75//hbVY7Ch7gjx5Oyh1EKqaLKtxXCspq5u3bRIMZjeGB2W9LIAXkt
         DVMCunns7k2dDxpvCjdg7/YDkUHGovMhUxiX24L0KAxtY3DOM3f+6AMsjOl1D2Nt7An8
         7BkaB6X4832/n4IwqX4fT4/4zZnOuVD/MSfbr7gdvcXfawL29FDEZuqvf+s0Ahk3Rppw
         lsqNm6Sj4J0LVQ/Ax9uDtxcUWHoSjfb9vBUJVWusaagQzhO7cju35oRvDKqa+ogjaeWP
         AbxvlE54KmxSmJhKYAbeYsLtCzK406bSFNHLAPsdXG7rtuJdQyzvaQ0NCGTNCq7u9xl/
         cdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763121450; x=1763726250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6IxYQ1B4hBv9yvs8lsDW8v1A4dO1r/XtQzuINEZhaQ=;
        b=nv9rQ3bQbySIcgxqoqFS/Jn16v4bmBJkQgmZK1J30LX0ogwNchNW/Z+UCnkXJMlSfo
         sBEUrHHl90yWrYTLs9e+NW6xRSJlzxY7L2Uzm+1hw7nQdca/DXcomc/osqn8+Bbz04Jg
         fv0hH3jPj08MlNrS5vIwXDzYQAR3J0A5fpW7vSwUc78kRndjPkHZNoZY/LdFnF/sHUUn
         O6ihP0BqhqdQXuEtfME6xQar1SLC62IW87xjwkHEWU2Osz2ZlrPCwwh5t+AbtPoz5pT1
         14HmdbC3+qbRc1kbXm36b3gBbrwtBbJ6KT5x7AvyluN2dZ/9XnTnz+6+yLCEeC4IgHP8
         KaJw==
X-Gm-Message-State: AOJu0YyAaFYrNRrqRDydGdvlwZXi7ujaJeGCEBEocGveWKSBZL0mKezj
	YOyuf4Rcf8lXbbaRgJ+8zSEEencTceLDiNNa1cytOk8aaBqIdZmcZNvLAbCN3jK3OroCQJWeU32
	dVEh4OTkq5z/LuKnpQH7ing+EZoKRABM=
X-Gm-Gg: ASbGncuVQrIriF5CVyCj6rR4haeL9oCvfFor6n21OtQHBuo6fD2YBiADT4kkg+AaUbz
	vUSUALHOtrVhB4fAgQhBTwZNInXOwNZoSZjvR+8JRD4bq7vm3So/WURsQpYQ/I3xYqbbXceRutc
	vhbZJBnUyRum9P1K1fEwgfEGoweuryFXOYWMwGtIvoOQJXLpDQs8Lo/hFJj2845cK4gE+Rwq3p7
	7ppSIZSu/7pyqY2yRnQM4k99rw8aYFycVfjiD5LUOoq5akE3EBa7mT+HfVDu1VMdJGInX59
X-Google-Smtp-Source: AGHT+IG7z2+VQaOK1wmM3iCfkVpaWrn9gxFzbzMggM5C11l2fO5JJFy2TSci/5pdTMEA6Vo9lt4MJVmeY9RQ6B5xjdU=
X-Received: by 2002:a17:907:1c0a:b0:b72:5629:1789 with SMTP id
 a640c23a62f3a-b7348372658mr757944766b.13.1763121450223; Fri, 14 Nov 2025
 03:57:30 -0800 (PST)
MIME-Version: 1.0
References: <20251113125712.18914-1-peter.marko@siemens.com>
 <20251113125712.18914-35-peter.marko@siemens.com> <CANPvuR=GwC6m1XXTMnLPu4j_ysZu2sdkWGEoeic5vHKaGUoDUQ@mail.gmail.com>
 <AS1PR10MB569760D671AF59BD1DFF2746FDCAA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS1PR10MB569760D671AF59BD1DFF2746FDCAA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Fri, 14 Nov 2025 11:57:18 +0000
X-Gm-Features: AWmQ_bmEB34c-3E1zVQxgovA9sVEGd92YS_Cf9bAHnslM7NdIwn4-oWrjOZqLkA
Message-ID: <CANPvuRm3r2jHzQuGXRXKKvNFfJwZ4ZJKTTasL+V8XhGZ53J=xw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/go][RFC PATCH 34/34]
 readme: add QA chapter
To: "Marko, Peter" <Peter.Marko@siemens.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
	"jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="000000000000bc8f5d06438cb3e4"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 11:57:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2564

--000000000000bc8f5d06438cb3e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Marko, Peter <Peter.Marko@siemens.com> escreveu (sexta, 14/11/2025 =C3=A0(s=
)
11:55):

>
>
> > -----Original Message-----
> > From: Jose Quaresma <quaresma.jose@gmail.com>
> > Sent: Friday, November 14, 2025 12:37
> > To: yocto-patches@lists.yoctoproject.org
> > Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>;
> > jose.quaresma@foundries.io
> > Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/go][RFC PATCH
> 34/34]
> > readme: add QA chapter
> >
> >
> >
> > Peter Marko via lists.yoctoproject.org <http://lists.yoctoproject.org>
> > <peter.marko=3Dsiemens.com@lists.yoctoproject.org
> > <mailto:siemens.com@lists.yoctoproject.org> > escreveu (quinta,
> 13/11/2025 =C3=A0(s)
> > 12:57):
> >
> >
> >       Describe QA done when accepting patches.
> >
> >       Note that oe-selftest fail when additional parameters (like -j) i=
s
> not
> >       present. When that is fixed, we can simplify the oe-selftest QA
> example.
> >
> >       Expected results:
> >       * runtime
> >       RESULTS - go.GoCompileTest.test_go_compile: PASSED (67.87s)
> >       RESULTS - go.GoCompileTest.test_go_module: PASSED (6.17s)
> >       RESULTS - go.GoHelloworldTest.test_gohelloworld: PASSED (1.24s)
> >       RESULTS - ping.PingTest.test_ping: PASSED (0.02s)
> >       RESULTS - ssh.SSHTest.test_ssh: PASSED (0.67s)
> >       * sdk
> >       RESULTS - go.GoCompileTest.test_go_build: PASSED (0.35s)
> >       RESULTS - go.GoCompileTest.test_go_module: PASSED (0.33s)
> >       RESULTS - go.GoHostCompileTest.test_go_cross_compile: PASSED
> > (0.22s)
> >       RESULTS - go.GoHostCompileTest.test_go_module_cross_compile:
> > PASSED (0.37s)
> >       * oe-selftest
> >       2025-11-13 11:55:23,485 - oe-selftest - INFO -
> > gotoolchain.oeGoToolchainSelfTest.test_go_dep_build
> > (subunit.RemotedTestCase)
> >       2025-11-13 11:55:23,485 - oe-selftest - INFO -  ... ok
> >       2025-11-13 11:55:23,485 - oe-selftest - INFO - 0: 1/1 1/1 (3.17s)
> (0 failed)
> > (gotoolchain.oeGoToolchainSelfTest.test_go_dep_build)
> >
> >       Signed-off-by: Peter Marko <peter.marko@siemens.com
> > <mailto:peter.marko@siemens.com> >
> >       ---
> >        README.md | 44
> > ++++++++++++++++++++++++++++++++++++++++++++
> >        1 file changed, 44 insertions(+)
> >
> >       diff --git a/README.md b/README.md
> >       index e316fc6..06a948d 100644
> >       --- a/README.md
> >       +++ b/README.md
> >       @@ -41,3 +41,47 @@ Maintenance
> >        Layer maintainers:
> >        * Jose Quaresma <jose.quaresma@foundries.io
> > <mailto:jose.quaresma@foundries.io> >
> >        * Peter Marko <peter.marko@siemens.com
> > <mailto:peter.marko@siemens.com> >
> >       +
> >       +Quality Assurance
> >       +-----------------
> >       +
> >       +QA tests are using original openembedded-core testsuites.
> >       +Current plan is to backport QA test changes to openembedded-core
> > scarthgap branch.
> >       +When that is no longer possible, changes will picked here.
> >       +
> >       +Automated tests to verify go toolchain functionality are being
> executed
> > with following configurations and commands:
> >       +
> >       +* OEQA runtime
> >       +
> >       +    ```
> >       +    IMAGE_INSTALL:append =3D " packagegroup-core-ssh-dropbear go=
-
> > helloworld packagegroup-go-sdk-target"
> >
> >
> >
> > Is the go-helloworld running automatically or does it need to be launch=
ed
> > manually?
>
> go.GoHelloworldTest.test_gohelloworld executes it in qemu and checks both
> exit code and printed message.
> See
> https://git.openembedded.org/openembedded-core/tree/meta/lib/oeqa/runtime=
/cases/go.py?h=3Dscarthgap


Nice!


>
>
> Peter
>
> >
> > Jose
> >
> >
> >       +    IMAGE_CLASSES +=3D "testimage"
> >       +    TEST_SUITES =3D "ping ssh go"
> >       +    QB_MEM =3D "-m 2048"
> >       +    ```
> >       +
> >       +    ```
> >       +    bitbake core-image-minimal && bitbake core-image-
> > minimal:do_testimage
> >       +    ```
> >       +
> >       +* OEQA SDK
> >       +
> >       +    ```
> >       +    IMAGE_CLASSES +=3D "testimage"
> >       +    SDK_TOOLCHAIN_LANGS =3D "go"
> >       +    TESTSDK_SUITES =3D "go"
> >       +    ```
> >       +
> >       +    ```
> >       +    bitbake core-image-minimal:do_populate_sdk && bitbake
> core-image-
> > minimal:do_testsdk
> >       +    ```
> >       +
> >       +* OEQA selftest
> >       +
> >       +    ```
> >       +    SANITY_TESTED_DISTROS =3D ""
> >       +    ```
> >       +
> >       +    ```
> >       +    oe-selftest -r gotoolchain -j $(grep -c ^processor
> /proc/cpuinfo)
> >       +    ```
> >
> >
> >       -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >       Links: You receive all messages sent to this group.
> >       View/Reply Online (#2533): https://lists.yoctoproject.org/g/yocto=
-
> > patches/message/2533
> >       Mute This Topic:
> https://lists.yoctoproject.org/mt/116273420/5052612
> >       Group Owner: yocto-patches+owner@lists.yoctoproject.org <mailto:
> yocto-
> > patches%2Bowner@lists.yoctoproject.org>
> >       Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> > patches/leave/13170708/5052612/1504338242/xyzzy [quaresma.jose@gmail.co=
m
> > <mailto:quaresma.jose@gmail.com> ]
> >       -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >
> >
> >
> >
> >
> > --
> >
> > Best regards,
> >
> > Jos=C3=A9 Quaresma
>


--=20
Best regards,

Jos=C3=A9 Quaresma

--000000000000bc8f5d06438cb3e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Marko, Peter &l=
t;<a href=3D"mailto:Peter.Marko@siemens.com">Peter.Marko@siemens.com</a>&gt=
; escreveu (sexta, 14/11/2025 =C3=A0(s) 11:55):<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Jose Quaresma &lt;<a href=3D"mailto:quaresma.jose@gmail.com" tar=
get=3D"_blank">quaresma.jose@gmail.com</a>&gt;<br>
&gt; Sent: Friday, November 14, 2025 12:37<br>
&gt; To: <a href=3D"mailto:yocto-patches@lists.yoctoproject.org" target=3D"=
_blank">yocto-patches@lists.yoctoproject.org</a><br>
&gt; Cc: Marko, Peter (FT D EU SK BFS1) &lt;<a href=3D"mailto:Peter.Marko@s=
iemens.com" target=3D"_blank">Peter.Marko@siemens.com</a>&gt;;<br>
&gt; <a href=3D"mailto:jose.quaresma@foundries.io" target=3D"_blank">jose.q=
uaresma@foundries.io</a><br>
&gt; Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/go][RFC PATCH=
 34/34]<br>
&gt; readme: add QA chapter<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Peter Marko via <a href=3D"http://lists.yoctoproject.org" rel=3D"noref=
errer" target=3D"_blank">lists.yoctoproject.org</a> &lt;<a href=3D"http://l=
ists.yoctoproject.org" rel=3D"noreferrer" target=3D"_blank">http://lists.yo=
ctoproject.org</a>&gt;<br>
&gt; &lt;peter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproject.org=
" target=3D"_blank">siemens.com@lists.yoctoproject.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:siemens.com@lists.yoctoproject.org" targe=
t=3D"_blank">siemens.com@lists.yoctoproject.org</a>&gt; &gt; escreveu (quin=
ta, 13/11/2025 =C3=A0(s)<br>
&gt; 12:57):<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Describe QA done when accepting patches.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Note that oe-selftest fail when additional p=
arameters (like -j) is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0present. When that is fixed, we can simplify=
 the oe-selftest QA example.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Expected results:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* runtime<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RESULTS - go.GoCompileTest.test_go_compile: =
PASSED (67.87s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RESULTS - go.GoCompileTest.test_go_module: P=
ASSED (6.17s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RESULTS - go.GoHelloworldTest.test_gohellowo=
rld: PASSED (1.24s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RESULTS - ping.PingTest.test_ping: PASSED (0=
.02s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RESULTS - ssh.SSHTest.test_ssh: PASSED (0.67=
s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* sdk<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RESULTS - go.GoCompileTest.test_go_build: PA=
SSED (0.35s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RESULTS - go.GoCompileTest.test_go_module: P=
ASSED (0.33s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RESULTS - go.GoHostCompileTest.test_go_cross=
_compile: PASSED<br>
&gt; (0.22s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RESULTS - go.GoHostCompileTest.test_go_modul=
e_cross_compile:<br>
&gt; PASSED (0.37s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* oe-selftest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A02025-11-13 11:55:23,485 - oe-selftest - INFO=
 -<br>
&gt; gotoolchain.oeGoToolchainSelfTest.test_go_dep_build<br>
&gt; (subunit.RemotedTestCase)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A02025-11-13 11:55:23,485 - oe-selftest - INFO=
 -=C2=A0 ... ok<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A02025-11-13 11:55:23,485 - oe-selftest - INFO=
 - 0: 1/1 1/1 (3.17s) (0 failed)<br>
&gt; (gotoolchain.oeGoToolchainSelfTest.test_go_dep_build)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Signed-off-by: Peter Marko &lt;<a href=3D"ma=
ilto:peter.marko@siemens.com" target=3D"_blank">peter.marko@siemens.com</a>=
<br>
&gt; &lt;mailto:<a href=3D"mailto:peter.marko@siemens.com" target=3D"_blank=
">peter.marko@siemens.com</a>&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 README.md | 44<br>
&gt; ++++++++++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 1 file changed, 44 insertions(+)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0diff --git a/README.md b/README.md<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0index e316fc6..06a948d 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0--- a/README.md<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+++ b/README.md<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@@ -41,3 +41,47 @@ Maintenance<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Layer maintainers:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Jose Quaresma &lt;<a href=3D"mailto:jose.=
quaresma@foundries.io" target=3D"_blank">jose.quaresma@foundries.io</a><br>
&gt; &lt;mailto:<a href=3D"mailto:jose.quaresma@foundries.io" target=3D"_bl=
ank">jose.quaresma@foundries.io</a>&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Peter Marko &lt;<a href=3D"mailto:peter.m=
arko@siemens.com" target=3D"_blank">peter.marko@siemens.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:peter.marko@siemens.com" target=3D"_blank=
">peter.marko@siemens.com</a>&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+Quality Assurance<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+-----------------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+QA tests are using original openembedded-co=
re testsuites.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+Current plan is to backport QA test changes=
 to openembedded-core<br>
&gt; scarthgap branch.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+When that is no longer possible, changes wi=
ll picked here.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+Automated tests to verify go toolchain func=
tionality are being executed<br>
&gt; with following configurations and commands:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+* OEQA runtime<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 IMAGE_INSTALL:append =3D &quo=
t; packagegroup-core-ssh-dropbear go-<br>
&gt; helloworld packagegroup-go-sdk-target&quot;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Is the go-helloworld running automatically or does it need to be launc=
hed<br>
&gt; manually?<br>
<br>
go.GoHelloworldTest.test_gohelloworld executes it in qemu and checks both e=
xit code and printed message.<br>
See <a href=3D"https://git.openembedded.org/openembedded-core/tree/meta/lib=
/oeqa/runtime/cases/go.py?h=3Dscarthgap" rel=3D"noreferrer" target=3D"_blan=
k">https://git.openembedded.org/openembedded-core/tree/meta/lib/oeqa/runtim=
e/cases/go.py?h=3Dscarthgap</a></blockquote><div><br></div><div>Nice!</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
Peter<br>
<br>
&gt; <br>
&gt; Jose<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 IMAGE_CLASSES +=3D &quot;test=
image&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 TEST_SUITES =3D &quot;ping ss=
h go&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 QB_MEM =3D &quot;-m 2048&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 bitbake core-image-minimal &a=
mp;&amp; bitbake core-image-<br>
&gt; minimal:do_testimage<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+* OEQA SDK<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 IMAGE_CLASSES +=3D &quot;test=
image&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 SDK_TOOLCHAIN_LANGS =3D &quot=
;go&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 TESTSDK_SUITES =3D &quot;go&q=
uot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 bitbake core-image-minimal:do=
_populate_sdk &amp;&amp; bitbake core-image-<br>
&gt; minimal:do_testsdk<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+* OEQA selftest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 SANITY_TESTED_DISTROS =3D &qu=
ot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 oe-selftest -r gotoolchain -j=
 $(grep -c ^processor /proc/cpuinfo)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ```<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Links: You receive all messages sent to this=
 group.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0View/Reply Online (#2533): <a href=3D"https:=
//lists.yoctoproject.org/g/yocto-" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lists.yoctoproject.org/g/yocto-</a><br>
&gt; patches/message/2533<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Mute This Topic: <a href=3D"https://lists.yo=
ctoproject.org/mt/116273420/5052612" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lists.yoctoproject.org/mt/116273420/5052612</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Group Owner: <a href=3D"mailto:yocto-patches=
%2Bowner@lists.yoctoproject.org" target=3D"_blank">yocto-patches+owner@list=
s.yoctoproject.org</a> &lt;mailto:<a href=3D"mailto:yocto-" target=3D"_blan=
k">yocto-</a><br>
&gt; <a href=3D"mailto:patches%252Bowner@lists.yoctoproject.org" target=3D"=
_blank">patches%2Bowner@lists.yoctoproject.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Unsubscribe: <a href=3D"https://lists.yoctop=
roject.org/g/yocto-" rel=3D"noreferrer" target=3D"_blank">https://lists.yoc=
toproject.org/g/yocto-</a><br>
&gt; patches/leave/13170708/5052612/1504338242/xyzzy [<a href=3D"mailto:qua=
resma.jose@gmail.com" target=3D"_blank">quaresma.jose@gmail.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:quaresma.jose@gmail.com" target=3D"_blank=
">quaresma.jose@gmail.com</a>&gt; ]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; --<br>
&gt; <br>
&gt; Best regards,<br>
&gt; <br>
&gt; Jos=C3=A9 Quaresma<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></=
div></div></div>

--000000000000bc8f5d06438cb3e4--

