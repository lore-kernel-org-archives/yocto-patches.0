Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DB8CE7AEF
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:37:29 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15880.1763120239399407716
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 03:37:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AaAVDRbO;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b735b7326e5so220325966b.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 03:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763120237; x=1763725037; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=etB8mnhgV+lliF+Fs94R5ezuHnMpzpvDxysg77Aw7pg=;
        b=AaAVDRbOUZnoboUyq6WZ4ItCq/uHrv1ZewWBTZUUeHZQ16mlUdbIh6BOyJsVSzLIHX
         bWHScsf9bVB6lEK+Y/vino0kXc1pZWYpFJbAq4pvEloH1DreQzb13z4jzoL9ok9j/Vtv
         EchEWKKRGPfT8JUu54aDhjNEJ1cVr6bZ19K+B0ELKm2i9zvwfuzzSfxpBnv0ntx46D12
         fsufa1xMB8PLmUp9Fa8pFCxkO1dQ7/rW9+zdzQQO83CyBNN0NM2cGIwBqn+9vVUX0pRC
         ItEZEoisTnDz3SLtqKO44UsunGmO1iCKbX5DDr5clutd1wQr13YuU8s14CI728Uatu+a
         BG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763120237; x=1763725037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etB8mnhgV+lliF+Fs94R5ezuHnMpzpvDxysg77Aw7pg=;
        b=EPOF/Woo5YlIlgtY9G/ueD2akWCQexwi53dBhvyPA2m4OzS13mPxwtGppWx/T7hv8k
         tJWJkb7OuIe4mEEOZd9ciP+5P5Lq0ygsW0I8dIFfqy3lZS44nVXloV/nn7hnxq8CzbI4
         yz07NdMxsH/HJO5SFP8AgpaKvo0Lhs1T+/QXzLcznzxMfKLdtIRrIeEYY8gNOafVO5xn
         piSpRloBBkcYykV8UQSJq3nKMy2UggVQEAMAnu/WNpWR+Xho5mgNPKPKqfe2hNTM4GKy
         hrpsmcir6nV2mqEJO4Z6M35OgOfvpyYAAzbPtT6SIEIXFBQ+StV1od6KFuSuXxLU15qi
         ENhA==
X-Gm-Message-State: AOJu0YzGSvl4gqVemXtw5lzl7A5u93iJKtG6YdNpocMXB/GuuI3mQ/fq
	6ZGj0dWSEf4bkqEZKEGlO/jfZj7Ue/9Dug7+yrKusXK+8a8RMmmMM6/XPgANjX5MCMMdF4D6l7x
	oPehzIEp3Q594h9GV7u+XhpqTlr92mp0HfErhfhA=
X-Gm-Gg: ASbGnctWfM1tb+TFGfmOFfi7vU1hLBeFa4DydRJgQI8wQWCtxlcNBjd/x0pyQdJiu3Q
	hAT6h9RsYjzxskEkPaRSDDL1bzmxVTtTVNH+HUmCKhG7b3db6MFfMUADNkQg1KyRoXokRiTaEGA
	noau5D76LbQV/J9wBAX8gystQYLlDODU9j8Hk7OT5u2Q4eRBodZgpI3oSrSDXgzpkGL752Hdw8H
	R5yw7qfGaUglx9tk5XkDHO6m6KMGV7C9hiUk8u/M6WWFzucNlDy5e7TB9omuIHCrCXVbw1Z/Uyx
	q3Y8qXE=
X-Google-Smtp-Source: AGHT+IGrAknq9PtOmVY+bP/FQJJ0keGT1xzhNze18YTlM6awfsAw+oyf0qiIZ6O/1iM74NY/OsLNdWG5TBfXMWZtRoM=
X-Received: by 2002:a17:907:eccc:b0:b73:2e54:a002 with SMTP id
 a640c23a62f3a-b73485707c9mr666233366b.15.1763120236713; Fri, 14 Nov 2025
 03:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20251113125712.18914-1-peter.marko@siemens.com> <20251113125712.18914-35-peter.marko@siemens.com>
In-Reply-To: <20251113125712.18914-35-peter.marko@siemens.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Fri, 14 Nov 2025 11:37:05 +0000
X-Gm-Features: AWmQ_bl35SoyS6OJxXswAb7K8lt8OfU0kyjfLwF-VdBNiMuEqDGgHuES6oWG3-M
Message-ID: <CANPvuR=GwC6m1XXTMnLPu4j_ysZu2sdkWGEoeic5vHKaGUoDUQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/go][RFC PATCH 34/34]
 readme: add QA chapter
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com, jose.quaresma@foundries.io
Content-Type: multipart/alternative; boundary="00000000000067db7a06438c6bb6"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 11:37:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2561

--00000000000067db7a06438c6bb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter Marko via lists.yoctoproject.org <peter.marko=3D
siemens.com@lists.yoctoproject.org> escreveu (quinta, 13/11/2025 =C3=A0(s)
12:57):

> Describe QA done when accepting patches.
>
> Note that oe-selftest fail when additional parameters (like -j) is not
> present. When that is fixed, we can simplify the oe-selftest QA example.
>
> Expected results:
> * runtime
> RESULTS - go.GoCompileTest.test_go_compile: PASSED (67.87s)
> RESULTS - go.GoCompileTest.test_go_module: PASSED (6.17s)
> RESULTS - go.GoHelloworldTest.test_gohelloworld: PASSED (1.24s)
> RESULTS - ping.PingTest.test_ping: PASSED (0.02s)
> RESULTS - ssh.SSHTest.test_ssh: PASSED (0.67s)
> * sdk
> RESULTS - go.GoCompileTest.test_go_build: PASSED (0.35s)
> RESULTS - go.GoCompileTest.test_go_module: PASSED (0.33s)
> RESULTS - go.GoHostCompileTest.test_go_cross_compile: PASSED (0.22s)
> RESULTS - go.GoHostCompileTest.test_go_module_cross_compile: PASSED (0.37=
s)
> * oe-selftest
> 2025-11-13 11:55:23,485 - oe-selftest - INFO -
> gotoolchain.oeGoToolchainSelfTest.test_go_dep_build
> (subunit.RemotedTestCase)
> 2025-11-13 11:55:23,485 - oe-selftest - INFO -  ... ok
> 2025-11-13 11:55:23,485 - oe-selftest - INFO - 0: 1/1 1/1 (3.17s) (0
> failed) (gotoolchain.oeGoToolchainSelfTest.test_go_dep_build)
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  README.md | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/README.md b/README.md
> index e316fc6..06a948d 100644
> --- a/README.md
> +++ b/README.md
> @@ -41,3 +41,47 @@ Maintenance
>  Layer maintainers:
>  * Jose Quaresma <jose.quaresma@foundries.io>
>  * Peter Marko <peter.marko@siemens.com>
> +
> +Quality Assurance
> +-----------------
> +
> +QA tests are using original openembedded-core testsuites.
> +Current plan is to backport QA test changes to openembedded-core
> scarthgap branch.
> +When that is no longer possible, changes will picked here.
> +
> +Automated tests to verify go toolchain functionality are being executed
> with following configurations and commands:
> +
> +* OEQA runtime
> +
> +    ```
> +    IMAGE_INSTALL:append =3D " packagegroup-core-ssh-dropbear go-hellowo=
rld
> packagegroup-go-sdk-target"
>

Is the go-helloworld running automatically or does it need to be launched
manually?

Jose


> +    IMAGE_CLASSES +=3D "testimage"
> +    TEST_SUITES =3D "ping ssh go"
> +    QB_MEM =3D "-m 2048"
> +    ```
> +
> +    ```
> +    bitbake core-image-minimal && bitbake core-image-minimal:do_testimag=
e
> +    ```
> +
> +* OEQA SDK
> +
> +    ```
> +    IMAGE_CLASSES +=3D "testimage"
> +    SDK_TOOLCHAIN_LANGS =3D "go"
> +    TESTSDK_SUITES =3D "go"
> +    ```
> +
> +    ```
> +    bitbake core-image-minimal:do_populate_sdk && bitbake
> core-image-minimal:do_testsdk
> +    ```
> +
> +* OEQA selftest
> +
> +    ```
> +    SANITY_TESTED_DISTROS =3D ""
> +    ```
> +
> +    ```
> +    oe-selftest -r gotoolchain -j $(grep -c ^processor /proc/cpuinfo)
> +    ```
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2533):
> https://lists.yoctoproject.org/g/yocto-patches/message/2533
> Mute This Topic: https://lists.yoctoproject.org/mt/116273420/5052612
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

--00000000000067db7a06438c6bb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Peter Marko via=
 <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;p=
eter.marko=3D<a href=3D"mailto:siemens.com@lists.yoctoproject.org">siemens.=
com@lists.yoctoproject.org</a>&gt; escreveu (quinta, 13/11/2025 =C3=A0(s) 1=
2:57):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Describe =
QA done when accepting patches.<br>
<br>
Note that oe-selftest fail when additional parameters (like -j) is not<br>
present. When that is fixed, we can simplify the oe-selftest QA example.<br=
>
<br>
Expected results:<br>
* runtime<br>
RESULTS - go.GoCompileTest.test_go_compile: PASSED (67.87s)<br>
RESULTS - go.GoCompileTest.test_go_module: PASSED (6.17s)<br>
RESULTS - go.GoHelloworldTest.test_gohelloworld: PASSED (1.24s)<br>
RESULTS - ping.PingTest.test_ping: PASSED (0.02s)<br>
RESULTS - ssh.SSHTest.test_ssh: PASSED (0.67s)<br>
* sdk<br>
RESULTS - go.GoCompileTest.test_go_build: PASSED (0.35s)<br>
RESULTS - go.GoCompileTest.test_go_module: PASSED (0.33s)<br>
RESULTS - go.GoHostCompileTest.test_go_cross_compile: PASSED (0.22s)<br>
RESULTS - go.GoHostCompileTest.test_go_module_cross_compile: PASSED (0.37s)=
<br>
* oe-selftest<br>
2025-11-13 11:55:23,485 - oe-selftest - INFO - gotoolchain.oeGoToolchainSel=
fTest.test_go_dep_build (subunit.RemotedTestCase)<br>
2025-11-13 11:55:23,485 - oe-selftest - INFO -=C2=A0 ... ok<br>
2025-11-13 11:55:23,485 - oe-selftest - INFO - 0: 1/1 1/1 (3.17s) (0 failed=
) (gotoolchain.oeGoToolchainSelfTest.test_go_dep_build)<br>
<br>
Signed-off-by: Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" t=
arget=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
---<br>
=C2=A0README.md | 44 ++++++++++++++++++++++++++++++++++++++++++++<br>
=C2=A01 file changed, 44 insertions(+)<br>
<br>
diff --git a/README.md b/README.md<br>
index e316fc6..06a948d 100644<br>
--- a/README.md<br>
+++ b/README.md<br>
@@ -41,3 +41,47 @@ Maintenance<br>
=C2=A0Layer maintainers:<br>
=C2=A0* Jose Quaresma &lt;<a href=3D"mailto:jose.quaresma@foundries.io" tar=
get=3D"_blank">jose.quaresma@foundries.io</a>&gt;<br>
=C2=A0* Peter Marko &lt;<a href=3D"mailto:peter.marko@siemens.com" target=
=3D"_blank">peter.marko@siemens.com</a>&gt;<br>
+<br>
+Quality Assurance<br>
+-----------------<br>
+<br>
+QA tests are using original openembedded-core testsuites.<br>
+Current plan is to backport QA test changes to openembedded-core scarthgap=
 branch.<br>
+When that is no longer possible, changes will picked here.<br>
+<br>
+Automated tests to verify go toolchain functionality are being executed wi=
th following configurations and commands:<br>
+<br>
+* OEQA runtime<br>
+<br>
+=C2=A0 =C2=A0 ```<br>
+=C2=A0 =C2=A0 IMAGE_INSTALL:append =3D &quot; packagegroup-core-ssh-dropbe=
ar go-helloworld packagegroup-go-sdk-target&quot;<br></blockquote><div><br>=
</div><div>Is the go-helloworld running=C2=A0automatically or does it need =
to be launched manually?<br><br>Jose</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 IMAGE_CLASSES +=3D &quot;testimage&quot;<br>
+=C2=A0 =C2=A0 TEST_SUITES =3D &quot;ping ssh go&quot;<br>
+=C2=A0 =C2=A0 QB_MEM =3D &quot;-m 2048&quot;<br>
+=C2=A0 =C2=A0 ```<br>
+<br>
+=C2=A0 =C2=A0 ```<br>
+=C2=A0 =C2=A0 bitbake core-image-minimal &amp;&amp; bitbake core-image-min=
imal:do_testimage<br>
+=C2=A0 =C2=A0 ```<br>
+<br>
+* OEQA SDK<br>
+<br>
+=C2=A0 =C2=A0 ```<br>
+=C2=A0 =C2=A0 IMAGE_CLASSES +=3D &quot;testimage&quot;<br>
+=C2=A0 =C2=A0 SDK_TOOLCHAIN_LANGS =3D &quot;go&quot;<br>
+=C2=A0 =C2=A0 TESTSDK_SUITES =3D &quot;go&quot;<br>
+=C2=A0 =C2=A0 ```<br>
+<br>
+=C2=A0 =C2=A0 ```<br>
+=C2=A0 =C2=A0 bitbake core-image-minimal:do_populate_sdk &amp;&amp; bitbak=
e core-image-minimal:do_testsdk<br>
+=C2=A0 =C2=A0 ```<br>
+<br>
+* OEQA selftest<br>
+<br>
+=C2=A0 =C2=A0 ```<br>
+=C2=A0 =C2=A0 SANITY_TESTED_DISTROS =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 ```<br>
+<br>
+=C2=A0 =C2=A0 ```<br>
+=C2=A0 =C2=A0 oe-selftest -r gotoolchain -j $(grep -c ^processor /proc/cpu=
info)<br>
+=C2=A0 =C2=A0 ```<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#2533): <a href=3D"https://lists.yoctoproject.org/g/yoct=
o-patches/message/2533" rel=3D"noreferrer" target=3D"_blank">https://lists.=
yoctoproject.org/g/yocto-patches/message/2533</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/116273420/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/116273420/5052612</a><br>
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

--00000000000067db7a06438c6bb6--

