Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5EDE7314E
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 09:22:36 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49185.1770024151651545327
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Feb 2026 01:22:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=DJSfd1Ot;
 spf=pass (domain: snapchat.com, ip: 209.85.128.48, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480706554beso45646065e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Feb 2026 01:22:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770024149; cv=none;
        d=google.com; s=arc-20240605;
        b=UXJ38TSmaZTMp2oz7llPMMch4VoIuyXaIIoHiPM6jjXZAl/K4hCoYqEs2A1GlsE7AV
         DVBrn5bZ0mSyuomc7lAwToUXcgOEXm19AfEYILEyg7aaGwj3otrBb3oMRTmE0C5gJP0I
         a32BvHh8t+jekCXWqvYINQcMEOyGpPfqeyadRaaVo1XOB6R8WOGRPDnk40A3gDQNL/WN
         mWv6pSUa1BS9RGdTdwXwy1lFrJL2gUlolKp8LddoM+xG3f+2EH//K/g+d+d1JPStmK9V
         xwK8pft5usCzPn2iGIRBqZ+ZNpxD08N6Vv0aRIZPwZ98pV4PUMGQpeXIAdURUyuCbEbL
         T3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0KbE1RWZkkZjbw+g76Xua4LbrmzllCplo6zbBpj8Dxc=;
        fh=vnwvjJBmT4xP5bZnotRs811IpgK/To6PNpBe4whKe/M=;
        b=cew8ISh9JxwR3UhQBjjQDExLA2RXD4kI+8OulkA6cLxNGvDFOT9GEtmnjJQg5TSGpU
         1jC9rUc4HA0RTYizusUg9igMmQdAK4eSYijUdQzLQoNuu53KzL+ZfqC7voUTJHdFMkLL
         9se6A2em5eXR0rEBHberTvmkMwzAyGCITugps1I+Rx9ZUT9I8nvgO2PSUlmkgcHXvV7e
         1uLS1HQI6cuwhF0iJ8yb7uRFjWlXpAtbsoYbVsuGjNxp8BBGNKdl+Ny1d+9+dZCBha7/
         7EegIntNoK9DfOChwFwGdZkTrClA9EotwkzIg4FQwjnM+hExrdS0qWl6AqXIM/669rf4
         PasA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1770024149; x=1770628949; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0KbE1RWZkkZjbw+g76Xua4LbrmzllCplo6zbBpj8Dxc=;
        b=DJSfd1Ot3CtS5xYgNWuY4h9io5rad0W1IxPgz7NiqphBv/7LLQQZMOdkkbjxtOMZkv
         NOxlS4XZcF45izM2ODI0/B665MSSmO6DWU2UNhyfCeFETjnFGamExn5yJFHYzFSVyXtZ
         r2xECWDjOElxMFdF2KnKEmkjW2bKKHmuh4x9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770024149; x=1770628949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KbE1RWZkkZjbw+g76Xua4LbrmzllCplo6zbBpj8Dxc=;
        b=Is6RqzuwOqsaS859hwiy9eBsFgN1E9sREm3/vQxBtRryrL8+FVVs5z7TO4Nri/xOdz
         lhBZGqGHLP56Qz77lz5zCoS2glhb1V5woSGKiq6rnlwgr1sas0MfsBK7daJAyiqTAu4w
         +1x/K1y+laK+XvLWKJC5P0YY3JF3pzn8NXfsVAjq0wZpwxf8UKd4Z3E454lpCkb89vxe
         UMmE4YmxsPb0b7mob3kfdH4Z9DBDyQiiTTBPS10TlfGP6VjECGUeg0lw4giHBmk8Z8U1
         RVF0un8wXp/1AcpSFeaqwubmxy9GIGeGqwixXU8uAZe0IkiIHIJ0CBkQkUy7iQpidz2r
         x8hQ==
X-Gm-Message-State: AOJu0Ywp9Q1ozuRjPHfQBN1rbu6TbxCC5stfn3KaEdaEdgcA93YUtVX+
	74EPyEBsfWX9TmB2LdvLU4A6wrnHU+Y8LSaVEngEyuQF1KHIM0SjaLkdHZcfWbM8+TCOZ4BcmLt
	hAifBJI126bBZK6TCC5nAG6GnJJblMN/d9yyzE4TxQjqti614LTs7cV47eQ==
X-Gm-Gg: AZuq6aKu1dS8BfUhVKX/2pIsCpQxrSEH/aJ9QIUQA4No8bZ0zTdsq6W0qewJYd0Y4MH
	X1k11MGLq5qf/WdZVhe8lD91M/NmpWTnGeXtRQla4V0piNrh0IYU57VIzSxPzQurzOYrjDLI+0x
	ImkYbh6OU+YrzIkN91vxxYuW+EW1KnG/whulLZ7lKi5mWGR4O7Y/LOWzEPI1IaOzp9QltZAkWjO
	9CidgQQctiZQrizx1INoPvdpxPf1yaZzwa71HHm8WKyxs4GIGuZPJCKGz9YQ3xLje8IVZ7QYnZr
	YgkyciJVYBDiuF191GF7DkUHELgb
X-Received: by 2002:a05:600c:6814:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-482db4af871mr137985695e9.35.1770024149126; Mon, 02 Feb 2026
 01:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20260201042755.18458-1-dev@qinc.tv>
In-Reply-To: <20260201042755.18458-1-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Mon, 2 Feb 2026 10:22:17 +0100
X-Gm-Features: AZwV_QhhY_LUe5Ta7moTgFQMnk2qDbdaEIUGALovVc34uGGaA3SKmA0VlcSG-xY
Message-ID: <CAHUKmYZd7HfVy0qvtg+SccK4c3UtV-nTqXsq_BS=EKZr=tC4gA@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH] fix dylib paths with install_name_tool
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Content-Type: multipart/alternative; boundary="000000000000a74a6f0649d3dc3a"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Feb 2026 09:22:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3165

--000000000000a74a6f0649d3dc3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
thanks for the patch! Can you please add a short description of what the
issue was in the commit message?
Also can you use the PV variable instead of hard-coding 18.1.6?


#   set meta-clang/recipes-devtools/clang/clang.inc:12
#     "${MAJOR_VER}.${MINOR_VER}.${PATCH_VER}${VER_SUFFIX}"
# pre-expansion value:
#   "${MAJOR_VER}.${MINOR_VER}.${PATCH_VER}${VER_SUFFIX}"
PV=3D"18.1.6"

On Sun, Feb 1, 2026 at 5:28=E2=80=AFAM Eric L. Hernes via lists.yoctoprojec=
t.org
<dev=3Dqinc.tv@lists.yoctoproject.org> wrote:

> Signed-off-by: Eric L. Hernes <dev@qinc.tv>
> ---
>  recipes-devtools/clang/clang_%.bbappend            | 4 ++++
>  recipes-devtools/gdb/gdb-cross-canadian_%.bbappend | 9 ++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/recipes-devtools/clang/clang_%.bbappend
> b/recipes-devtools/clang/clang_%.bbappend
> index e55dff6..6c0a757 100644
> --- a/recipes-devtools/clang/clang_%.bbappend
> +++ b/recipes-devtools/clang/clang_%.bbappend
> @@ -83,4 +83,8 @@ FILES:${PN} +=3D " \
>     ${libdir}/LLVMgold.dylib \
>  "
>
> +do_compile:append:class-nativesdk:darwin21() {
> +    ${SDK_PREFIX}install_name_tool -change liblldb.18.1.6.dylib
> @loader_path/../lib/liblldb.18.1.6.dylib ${B}/bin/lldb-dap
> +}
> +
>  INSANE_SKIP:${PN}:class-nativesdk:darwin21 +=3D " file-rdeps"
> diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> index 3f69019..5fa29a7 100644
> --- a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> +++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> @@ -16,4 +16,11 @@ EXTRA_OECONF:remove:darwinsdk =3D "--with-system-readl=
ine"
>  # Remove -rpath-link and -rpath
>  LDFLAGS:darwinsdk =3D "${BUILDSDK_LDFLAGS}"
>
> -INSANE_SKIP:append:darwin21 =3D " buildpaths"
> +do_compile:append:darwinsdk() {
> +    ${SDK_PREFIX}install_name_tool -change libexpat.1.dylib
> @loader_path/../../lib/libexpat.1.dylib ${B}/gdb/gdb
> +}
> +
> +DEPENDS:append:darwinsdk =3D " nativesdk-zlib "
> +
> +INSANE_SKIP:append:darwinsdk =3D " buildpaths"
> +
> --
> 2.50.1 (Apple Git-155)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3162):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3162&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D9ND=
zehceBAtFxwQjf1ZvZF9kKQABoDheAwKSAe0d37qN299gtRECv3HBuclcyzeD&s=3DYFvsep7CM=
9Cpi1V7Rc1wCVPKFjXvJEj2MufVcn4CutQ&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117572910_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D9NDzehceBAtFx=
wQjf1ZvZF9kKQABoDheAwKSAe0d37qN299gtRECv3HBuclcyzeD&s=3Dj288T9KVEzDNpVSW_cA=
HfDDzkNZ95Jgvl99IfK3plL4&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3D9NDzehceBAtFxwQjf1ZvZF9kKQABoDheAwKSAe0d37qN299gtRE=
Cv3HBuclcyzeD&s=3Del0hw-GP_LKsJfZmmG3hjdMTqgLtjur_jIxZUTN0ZhQ&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000a74a6f0649d3dc3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br>thanks for the patch! Can you please add a sho=
rt description of what the issue was in the commit message?<br>Also can you=
 use the PV variable instead of hard-coding 18.1.6?<br><br><br># =C2=A0 set=
 meta-clang/recipes-devtools/clang/clang.inc:12<br># =C2=A0 =C2=A0 &quot;${=
MAJOR_VER}.${MINOR_VER}.${PATCH_VER}${VER_SUFFIX}&quot;<br># pre-expansion =
value:<br># =C2=A0 &quot;${MAJOR_VER}.${MINOR_VER}.${PATCH_VER}${VER_SUFFIX=
}&quot;<br>PV=3D&quot;18.1.6&quot;<br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 1, =
2026 at 5:28=E2=80=AFAM Eric L. Hernes via <a href=3D"http://lists.yoctopro=
ject.org">lists.yoctoproject.org</a> &lt;dev=3D<a href=3D"mailto:qinc.tv@li=
sts.yoctoproject.org">qinc.tv@lists.yoctoproject.org</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-off-by: Eric L. =
Hernes &lt;<a href=3D"mailto:dev@qinc.tv" target=3D"_blank">dev@qinc.tv</a>=
&gt;<br>
---<br>
=C2=A0recipes-devtools/clang/clang_%.bbappend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 4 ++++<br>
=C2=A0recipes-devtools/gdb/gdb-cross-canadian_%.bbappend | 9 ++++++++-<br>
=C2=A02 files changed, 12 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/recipes-devtools/clang/clang_%.bbappend b/recipes-devtools/cla=
ng/clang_%.bbappend<br>
index e55dff6..6c0a757 100644<br>
--- a/recipes-devtools/clang/clang_%.bbappend<br>
+++ b/recipes-devtools/clang/clang_%.bbappend<br>
@@ -83,4 +83,8 @@ FILES:${PN} +=3D &quot; \<br>
=C2=A0 =C2=A0 ${libdir}/LLVMgold.dylib \<br>
=C2=A0&quot;<br>
<br>
+do_compile:append:class-nativesdk:darwin21() {<br>
+=C2=A0 =C2=A0 ${SDK_PREFIX}install_name_tool -change liblldb.18.1.6.dylib =
@loader_path/../lib/liblldb.18.1.6.dylib ${B}/bin/lldb-dap<br>
+}<br>
+<br>
=C2=A0INSANE_SKIP:${PN}:class-nativesdk:darwin21 +=3D &quot; file-rdeps&quo=
t;<br>
diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend b/recipes-d=
evtools/gdb/gdb-cross-canadian_%.bbappend<br>
index 3f69019..5fa29a7 100644<br>
--- a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend<br>
+++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend<br>
@@ -16,4 +16,11 @@ EXTRA_OECONF:remove:darwinsdk =3D &quot;--with-system-re=
adline&quot;<br>
=C2=A0# Remove -rpath-link and -rpath<br>
=C2=A0LDFLAGS:darwinsdk =3D &quot;${BUILDSDK_LDFLAGS}&quot;<br>
<br>
-INSANE_SKIP:append:darwin21 =3D &quot; buildpaths&quot;<br>
+do_compile:append:darwinsdk() {<br>
+=C2=A0 =C2=A0 ${SDK_PREFIX}install_name_tool -change libexpat.1.dylib @loa=
der_path/../../lib/libexpat.1.dylib ${B}/gdb/gdb<br>
+}<br>
+<br>
+DEPENDS:append:darwinsdk =3D &quot; nativesdk-zlib &quot;<br>
+<br>
+INSANE_SKIP:append:darwinsdk =3D &quot; buildpaths&quot;<br>
+<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3162): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3162&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9NDzehceBAtFxwQjf1ZvZF9kKQ=
ABoDheAwKSAe0d37qN299gtRECv3HBuclcyzeD&amp;s=3DYFvsep7CM9Cpi1V7Rc1wCVPKFjXv=
JEj2MufVcn4CutQ&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3162&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9=
NDzehceBAtFxwQjf1ZvZF9kKQABoDheAwKSAe0d37qN299gtRECv3HBuclcyzeD&amp;s=3DYFv=
sep7CM9Cpi1V7Rc1wCVPKFjXvJEj2MufVcn4CutQ&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117572910_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3D9NDzehceBAtFxwQjf1ZvZF9kKQABoDheAwKSAe0d37qN29=
9gtRECv3HBuclcyzeD&amp;s=3Dj288T9KVEzDNpVSW_cAHfDDzkNZ95Jgvl99IfK3plL4&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117572910_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9NDzehceBAtFxwQjf1ZvZF9kKQABoDh=
eAwKSAe0d37qN299gtRECv3HBuclcyzeD&amp;s=3Dj288T9KVEzDNpVSW_cAHfDDzkNZ95Jgvl=
99IfK3plL4&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9NDzehceBAtFx=
wQjf1ZvZF9kKQABoDheAwKSAe0d37qN299gtRECv3HBuclcyzeD&amp;s=3Del0hw-GP_LKsJfZ=
mmG3hjdMTqgLtjur_jIxZUTN0ZhQ&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D9NDzehceBAtFxwQjf1ZvZF9kKQABoDheAwKS=
Ae0d37qN299gtRECv3HBuclcyzeD&amp;s=3Del0hw-GP_LKsJfZmmG3hjdMTqgLtjur_jIxZUT=
N0ZhQ&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--000000000000a74a6f0649d3dc3a--

