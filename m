Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C735E7C6EC
	for <webhook@archiver.kernel.org>; Sat, 31 Jan 2026 21:10:40 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17606.1769893833627960023
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Jan 2026 13:10:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=NgmbalQB;
 spf=pass (domain: snapchat.com, ip: 209.85.221.41, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4358fb60802so1982524f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 13:10:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769893831; cv=none;
        d=google.com; s=arc-20240605;
        b=RzxESLSn70IJSwATOshIHG3AzSi/tI94lHC2mEoE9oGwCvvrk4Gv/8ibUy9G7i+/+J
         8bcl5P/RQHYC/TMPnH91EYDCQ3mbtuWNWdb73BrfxrblkjWZzxPAI+tsHsjqQlW0R9Yc
         AEGLL77HIKt7oA2jXn3aJY86pPABC1DVV86UzKPKb6BlrweTZ/NyZM1XXfXVOrE86e8V
         OA59Vf4ZRW/IiwSoqPfTNSicOYD3vWjOXqgCpL4FC0dLECCFSRZKf/x/i1lr+nfZ7eRy
         CFp+al+rX32/OJiJuC8nii+0EpKnDGGYpJYvuSNTAYoPh4alqTVjYRAK18NXv48J0cGv
         0srQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rKmCjnJp/654jA+3pntvHLTMo/woPdtk+0ymQIsJ+98=;
        fh=vnwvjJBmT4xP5bZnotRs811IpgK/To6PNpBe4whKe/M=;
        b=MY8+dbpdVAEkYSvDIq7yXVTpBACfh37rq4VmNO5xnfX5e7EhH6lMbUJCjvhQp1ROnG
         ig+HSoQ+W7env6X2164UaTXIqCk36MNcTy1gbjagm6kKWNNnwN7kFjMloF8hyze5v+dq
         nRX2CMYy+RXFxfnIWd6gc7pfE3sL1qPH2VQxwTKyVGOBmQO9ONNvv3SGyXaMWzD19NcQ
         0Ei5M3fPtJYAv9jDWf5g/tIRkm4BaX365Q3bD8pNKKKZ8B/KzAxbEAdGetMuXTV8TYOe
         cYYoSMJqIfa3ld8vcQG8E2/Z1B9NGK4ylE/1Kap8p1h9WxaGQB8w7Aqi1nez2Werm/fh
         9RaQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1769893831; x=1770498631; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rKmCjnJp/654jA+3pntvHLTMo/woPdtk+0ymQIsJ+98=;
        b=NgmbalQBAbpzwhcbQ+GeaaNNd010Cb9hxLPScJIBD74RZFaFmb13oj8TqtBdZS9Y31
         1TDFguQBURIW2qXa18uSwmTAheZlKsMEjjrEV7bnB+rsZaeeL9iPjlNivNkGBcoTV/w0
         w4+zhPfyY2xOYY9oVXHJnaPbCCqBrS4d3Qq+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769893831; x=1770498631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKmCjnJp/654jA+3pntvHLTMo/woPdtk+0ymQIsJ+98=;
        b=vmW50VDaz6AJPHNK3Ot3VBex0guvEzzedwoUW8pud7jQv0n+T/2+9Bz97sbpQcnbyg
         W/IVetRPeEFX6yR5Pcl4CBmyO928zbTaNHIsUpo7pvoJeiiIbHvZ4i/d67qRvCpl1ZUA
         CM+msI6xGVtCVfhs9rh9Xgo7rRBW8cHQU2jhV9ElxC94kUKK5AyGKnOHxbhUf/HoHv7t
         HOw5eUDn6Qjb0hgh+9AGfutQnQ7ujrBZHGaKOIR6RbCGLaqYRYNuTAmoeGaUX5I9pBpT
         eKd+u+WpguXusRZ1SthV0epI8BOw8vzOmc5YNlxENTQPgTTgfsBLl4LLUWQSmNLP7CiQ
         xNxg==
X-Gm-Message-State: AOJu0Yzrj1TOG12zUBidQdbr9pMlHBplftbRLSMFNA7T1EjtEvwWvv5T
	vQe9pmp6G8qDPv+EHxHvULtTxKWNlsRb0MGfu/IE2MmqhB4HxMSfBwqKnw5oAg52GBLPwlXUTNf
	JWqTbSlGKJJzRiCGWXkf3x6deBNT4V2NLMGRT3QJlrbjOFlf4prbu+ROP3w==
X-Gm-Gg: AZuq6aI07XM4IXgNpwGQFAGxbGAk+kwq25pYe5ieN7+gyCQ6jpIQqT4jnEzlyjnHfDx
	Wa5jKxGVOPwrZK/VREshydyHYVAGdNGWSMpe+rNKz47d8FCz8Fr2YxhcXapmyI/sYP8YoRoIPPA
	yiMhNCwpDYn/TTjShMGULmiPQRQVyFKvsoUp5ZFq2HI8oQkozHKn6x7d6mY3WXoBvz30tdqRRIz
	9m0fOrb7qiUwVmKiHBqmBbPIoG0k0k+Ct27c3KaLjwx1ejt2K2oXwhyHblhsK0ctTaXZFEicqqP
	T1WWp51qAuqo90NPySlh5oOuV3w=
X-Received: by 2002:a5d:5d86:0:b0:432:c03e:a78e with SMTP id
 ffacd0b85a97d-435ea220d54mr14279136f8f.27.1769893831320; Sat, 31 Jan 2026
 13:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20260128063648.1422-1-dev@qinc.tv> <20260128063648.1422-3-dev@qinc.tv>
In-Reply-To: <20260128063648.1422-3-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Sat, 31 Jan 2026 22:10:20 +0100
X-Gm-Features: AZwV_QjK568XrgGDXtRTNe8pl67JNbglaVJZqcuaX1GGkKF3jo11jY9Y_M1p-Xg
Message-ID: <CAHUKmYYpunLBV3NPLKiEk9Lm9=7MpasLa2Pk9ujTOcvXZGew3A@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH 3/3] add bomutils recipe
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Content-Type: multipart/alternative; boundary="0000000000001b50300649b585a4"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 21:10:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3161

--0000000000001b50300649b585a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
thanks for the patch! Applied as
https://git.yoctoproject.org/meta-darwin/commit/?id=3D34593df0e9bd4746b02b4=
e2aed79088f15b3fe88

On Wed, Jan 28, 2026 at 7:37=E2=80=AFAM Eric L. Hernes via lists.yoctoproje=
ct.org
<dev=3Dqinc.tv@lists.yoctoproject.org> wrote:

> bomutils is used to build the bill of materials files for macOS .pkg
> installers
>
> Signed-off-by: Eric L. Hernes <dev@qinc.tv>
> ---
>  recipes-support/bomutils/bomutils_git.bb | 34 ++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 recipes-support/bomutils/bomutils_git.bb
>
> diff --git a/recipes-support/bomutils/bomutils_git.bb
> b/recipes-support/bomutils/bomutils_git.bb
> new file mode 100644
> index 0000000..04e6dbd
> --- /dev/null
> +++ b/recipes-support/bomutils/bomutils_git.bb
> @@ -0,0 +1,34 @@
> +SUMMARY =3D "Bill Of Materials Utils"
> +HOMEPAGE =3D "https://github.com/hogliux/bomutils "
> +LICENSE =3D "GPL-2.0-only"
> +
> +SRCREV =3D "f62b59c659b1e57788661dadf87765e226824f67"
> +SRC_URI =3D " \
> +    git://github.com/elhernes/bomutils.git;branch=3Dmaster;protocol=3Dht=
tps \
> +"
> +
> +LIC_FILES_CHKSUM =3D
> "file://${WORKDIR}/git/LICENSE;md5=3D55d923cdeef7e46b4d6415cb173b345a"
> +
> +BBCLASSEXTEND =3D "native"
> +
> +S =3D "${WORKDIR}/git"
> +B =3D "${WORKDIR}/git/build"
> +
> +do_compile() {
> +    make -C ${S}
> +}
> +
> +do_install() {
> +    install -d ${D}${bindir}
> +    install -d ${D}${mandir}/man1
> +
> +    install -m 0755 ${B}/bin/ls4mkbom ${D}${bindir}
> +    install -m 0755 ${B}/bin/dumpbom ${D}${bindir}
> +    install -m 0755 ${B}/bin/lsbom ${D}${bindir}
> +    install -m 0755 ${B}/bin/mkbom ${D}${bindir}
> +
> +    install -m 0444 ${B}/man/ls4mkbom.1.gz ${D}${mandir}/man1
> +    install -m 0444 ${B}/man/dumpbom.1.gz ${D}${mandir}/man1
> +    install -m 0444 ${B}/man/lsbom.1.gz ${D}${mandir}/man1
> +    install -m 0444 ${B}/man/mkbom.1.gz ${D}${mandir}/man1
> +}
> --
> 2.50.1 (Apple Git-155)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3127):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3127&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DLJM=
eCNzx7PX_6mimmV7tx47v1nKUUHpsO1WPaxzzFUFBJ0otVGRKSliQypZjt6hw&s=3DXT2YhK68v=
YAXijX0OuBr26F6m50HAyJ32IfUzQcyoqQ&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117504015_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DLJMeCNzx7PX_6=
mimmV7tx47v1nKUUHpsO1WPaxzzFUFBJ0otVGRKSliQypZjt6hw&s=3D8MJuqwlOtNqUcnEyKA3=
uXO0Ts4cIXJbRHMZtOxeqcAg&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3DLJMeCNzx7PX_6mimmV7tx47v1nKUUHpsO1WPaxzzFUFBJ0otVGR=
KSliQypZjt6hw&s=3DtcvWqZxBfxDdYsbTIzHwlAAy1O4G_DnNuDXzP5kOSig&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--0000000000001b50300649b585a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br>thanks for the patch! Applied as=C2=A0<a href=
=3D"https://git.yoctoproject.org/meta-darwin/commit/?id=3D34593df0e9bd4746b=
02b4e2aed79088f15b3fe88">https://git.yoctoproject.org/meta-darwin/commit/?i=
d=3D34593df0e9bd4746b02b4e2aed79088f15b3fe88</a></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On We=
d, Jan 28, 2026 at 7:37=E2=80=AFAM Eric L. Hernes via <a href=3D"http://lis=
ts.yoctoproject.org">lists.yoctoproject.org</a> &lt;dev=3D<a href=3D"mailto=
:qinc.tv@lists.yoctoproject.org">qinc.tv@lists.yoctoproject.org</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">bomutils is =
used to build the bill of materials files for macOS .pkg installers<br>
<br>
Signed-off-by: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv" target=3D"=
_blank">dev@qinc.tv</a>&gt;<br>
---<br>
=C2=A0recipes-support/bomutils/<a href=3D"http://bomutils_git.bb" rel=3D"no=
referrer" target=3D"_blank">bomutils_git.bb</a> | 34 ++++++++++++++++++++++=
++<br>
=C2=A01 file changed, 34 insertions(+)<br>
=C2=A0create mode 100644 recipes-support/bomutils/<a href=3D"http://bomutil=
s_git.bb" rel=3D"noreferrer" target=3D"_blank">bomutils_git.bb</a><br>
<br>
diff --git a/recipes-support/bomutils/<a href=3D"http://bomutils_git.bb" re=
l=3D"noreferrer" target=3D"_blank">bomutils_git.bb</a> b/recipes-support/bo=
mutils/<a href=3D"http://bomutils_git.bb" rel=3D"noreferrer" target=3D"_bla=
nk">bomutils_git.bb</a><br>
new file mode 100644<br>
index 0000000..04e6dbd<br>
--- /dev/null<br>
+++ b/recipes-support/bomutils/<a href=3D"http://bomutils_git.bb" rel=3D"no=
referrer" target=3D"_blank">bomutils_git.bb</a><br>
@@ -0,0 +1,34 @@<br>
+SUMMARY =3D &quot;Bill Of Materials Utils&quot;<br>
+HOMEPAGE =3D &quot;<a href=3D"https://github.com/hogliux/bomutils" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/hogliux/bomutils</a> &quot=
;<br>
+LICENSE =3D &quot;GPL-2.0-only&quot;<br>
+<br>
+SRCREV =3D &quot;f62b59c659b1e57788661dadf87765e226824f67&quot;<br>
+SRC_URI =3D &quot; \<br>
+=C2=A0 =C2=A0 git://<a href=3D"http://github.com/elhernes/bomutils.git;bra=
nch=3Dmaster;protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blank">github.=
com/elhernes/bomutils.git;branch=3Dmaster;protocol=3Dhttps</a> \<br>
+&quot;<br>
+<br>
+LIC_FILES_CHKSUM =3D &quot;file://${WORKDIR}/git/LICENSE;md5=3D55d923cdeef=
7e46b4d6415cb173b345a&quot;<br>
+<br>
+BBCLASSEXTEND =3D &quot;native&quot;<br>
+<br>
+S =3D &quot;${WORKDIR}/git&quot;<br>
+B =3D &quot;${WORKDIR}/git/build&quot;<br>
+<br>
+do_compile() {<br>
+=C2=A0 =C2=A0 make -C ${S}<br>
+}<br>
+<br>
+do_install() {<br>
+=C2=A0 =C2=A0 install -d ${D}${bindir}<br>
+=C2=A0 =C2=A0 install -d ${D}${mandir}/man1<br>
+<br>
+=C2=A0 =C2=A0 install -m 0755 ${B}/bin/ls4mkbom ${D}${bindir}<br>
+=C2=A0 =C2=A0 install -m 0755 ${B}/bin/dumpbom ${D}${bindir}<br>
+=C2=A0 =C2=A0 install -m 0755 ${B}/bin/lsbom ${D}${bindir}<br>
+=C2=A0 =C2=A0 install -m 0755 ${B}/bin/mkbom ${D}${bindir}<br>
+<br>
+=C2=A0 =C2=A0 install -m 0444 ${B}/man/ls4mkbom.1.gz ${D}${mandir}/man1<br=
>
+=C2=A0 =C2=A0 install -m 0444 ${B}/man/dumpbom.1.gz ${D}${mandir}/man1<br>
+=C2=A0 =C2=A0 install -m 0444 ${B}/man/lsbom.1.gz ${D}${mandir}/man1<br>
+=C2=A0 =C2=A0 install -m 0444 ${B}/man/mkbom.1.gz ${D}${mandir}/man1<br>
+}<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3127): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3127&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DLJMeCNzx7PX_6mimmV7tx47v1n=
KUUHpsO1WPaxzzFUFBJ0otVGRKSliQypZjt6hw&amp;s=3DXT2YhK68vYAXijX0OuBr26F6m50H=
AyJ32IfUzQcyoqQ&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3127&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DL=
JMeCNzx7PX_6mimmV7tx47v1nKUUHpsO1WPaxzzFUFBJ0otVGRKSliQypZjt6hw&amp;s=3DXT2=
YhK68vYAXijX0OuBr26F6m50HAyJ32IfUzQcyoqQ&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117504015_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DLJMeCNzx7PX_6mimmV7tx47v1nKUUHpsO1WPaxzzFUFBJ0=
otVGRKSliQypZjt6hw&amp;s=3D8MJuqwlOtNqUcnEyKA3uXO0Ts4cIXJbRHMZtOxeqcAg&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117504015_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DLJMeCNzx7PX_6mimmV7tx47v1nKUUHp=
sO1WPaxzzFUFBJ0otVGRKSliQypZjt6hw&amp;s=3D8MJuqwlOtNqUcnEyKA3uXO0Ts4cIXJbRH=
MZtOxeqcAg&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DLJMeCNzx7PX_6=
mimmV7tx47v1nKUUHpsO1WPaxzzFUFBJ0otVGRKSliQypZjt6hw&amp;s=3DtcvWqZxBfxDdYsb=
TIzHwlAAy1O4G_DnNuDXzP5kOSig&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DLJMeCNzx7PX_6mimmV7tx47v1nKUUHpsO1WP=
axzzFUFBJ0otVGRKSliQypZjt6hw&amp;s=3DtcvWqZxBfxDdYsbTIzHwlAAy1O4G_DnNuDXzP5=
kOSig&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--0000000000001b50300649b585a4--

