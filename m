Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDDBFD374D
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:16:03 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43949.1772021760701864269
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Feb 2026 04:16:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=bwKQ4XRz;
 spf=pass (domain: snapchat.com, ip: 209.85.221.42, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4398ebdf520so479028f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Feb 2026 04:16:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772021759; cv=none;
        d=google.com; s=arc-20240605;
        b=lEdWhKtxYsrsTvycdXQt2geXV7EbOw0zF1uXXEJ8aB3dfXncwzHzFG0FVb6jHnFcsB
         rhAbnvqLrl/UQgiNQgm5hmP9V3oLpROKqwsVXb28RFZf5nNXh2VOe63XIOlXUJqBMrXH
         lz0wfLSE2ukK2oIHAixFbzxL9vWDIlg8321Q3FLwJN18A9c1dHT5pcYIuZ6BQjq2YmID
         nNUo8AGH/od0GgcVapTumOlwEQ/WzDX0vpeiO7qKMMRTj07kTM7FWpRz8WDgzD+Hp/7k
         S6An+IQxrUz1OWTJBm09DFBSSSpmZmILnhbYXgFb4RWvXOQoscK6TMTVxEXW8XX6T1VZ
         Mlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E+wQ5T/qN6sUmvTM4gqyuRox/HfN23tEbR64ryiwfU0=;
        fh=vnwvjJBmT4xP5bZnotRs811IpgK/To6PNpBe4whKe/M=;
        b=NyYQe5PWgQmI6wyhBhnVjorpXYDw9tnPLHAu68/fvavEcpWPaCrRM6ZA1EsRJAkONw
         Q/AcJwl/PrD7zFKbW/3OOaPtWVZVAOKJcZxdE1aYxZWu/Ey0VZ5hfMulXsiSAFn/geMp
         BpQa1X5OqmjzEJQDudzjSKjFoQ8/kkt8B3felj4xsoI1AC9LgmhDlCYNhAxMeI1j9rhE
         CfUZvGxYMOQMZX25HexsuqeS34t+g/Qtypmc2LRjtdSoLg4KUTvLMd6XAcf9gNyM6kvA
         XhAcXG/ekMGQW3s/MVVVDmMWB6A6gYvcFuwwCzaF5TjiKdXmpHuXOuQcoDJywKBCXT4J
         Pimw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1772021759; x=1772626559; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+wQ5T/qN6sUmvTM4gqyuRox/HfN23tEbR64ryiwfU0=;
        b=bwKQ4XRzRUMMppPJ2VFN9kic0WuBh/8gp3qif4T8uIuk6dMDqYDWpHaKt1vbvUAaoc
         SX0hEH43zeHQInuuKnN+Y2WKFcstpcaVKVMXwquTWX0Xm+onaZPibYOuJCnD5ydGCg1v
         RpuUzxiOucMPGkMzj/8/+g31Ieyho0vGJEosk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772021759; x=1772626559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+wQ5T/qN6sUmvTM4gqyuRox/HfN23tEbR64ryiwfU0=;
        b=ZI2mfZ9Ofkoa+YLMf9wsKqFcYO4Vi/CvZ5f1GWrWKXOUOmEK4tQDChbbsgS91v/Feo
         LjyVPRY5ZDAmRESfJrNPcGhHCFRSTPCsDoZZPeJJ3ppGzhvUwIu0hHk2FL99oIIlREeg
         2BQ4hNzfCriKVG4kUPxQNilWW//+E7Iy1p1nedrD32ZfzVHvPhWtPUH0Ucg0e0VA0h8K
         2JDOoUnDLF3XJxtebKHypDqOcl69uzJdJQfZKPy+Nvv+AlSSKMfyerd/xNYekqKe14Bf
         KMrjHrWpi2zgfkgGLlDXiodBnbFzzgrX7GP84dSn2OeXwTk00+NdVR4MHuq0gM2gXcFd
         zP4g==
X-Gm-Message-State: AOJu0Yz8GDtKw97y8ub8Mbc8Fq9Zq0Gny+A4UUGYDLH4PjYgVSEmTTFU
	DBgxB4R6Exof2EdwBXHuABdOOlRnkexYkSNZPHIo/VdJIwZoGoDidD0subZDUgUppi7cuAVwYXG
	DltAxKx6lIWubh2iMeZq/FaF8AA6aOpmmKw94MNCcL2Uzc/RRMrl8aLYzpw==
X-Gm-Gg: ATEYQzxK216ayike5tMT4AbseQCZrGjTr25MvQoEztcynINJytGvIZmZqg2LNjFNDkr
	CGGZ0unEzzBEgSTKuSQmMkZU+YDZ/3BueJM8W7n4RyhZ5GvGw6tKaF0oRbN3JsvoDDRHVV2VpUh
	7/ISYkHZ2EYpElFIiRkUVTr4cxMgrY2zQPYJ278C1xl9ojTpkagxz9gnAPAYhQVOobcrambNEPs
	vMrHTo1dFPwtzoPnh3w7ywv4NURYnVaiIVYZ3wgki3cr/4exDIby4xXvKa0JfztvKbPY8wUksnq
	3Isl5BEiuH9QmHA5xIVkPnjCwUOp0XIB/T7MeELQ
X-Received: by 2002:a05:6000:4301:b0:435:96e9:cde8 with SMTP id
 ffacd0b85a97d-4398d83f2d7mr6158285f8f.12.1772021758039; Wed, 25 Feb 2026
 04:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20260202155852.76192-2-dev@qinc.tv>
In-Reply-To: <20260202155852.76192-2-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Wed, 25 Feb 2026 13:15:47 +0100
X-Gm-Features: AaiRm50EZhRNqu_OIPJfbvCqXa__aJdYM-XX5bVaKX6pu9ARWvLLjNKKWVms5Ek
Message-ID: <CAHUKmYZexyroFHEwKebtw7QQCOptjgfwO-MRY8kfvAYt25V7dg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-darwin][PATCH] Fix dylib paths for gdb and lldb
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Content-Type: multipart/alternative; boundary="0000000000006c4704064ba4f77d"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Feb 2026 12:16:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3278

--0000000000006c4704064ba4f77d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Thanks for the patch!
Merged to main as
https://git.yoctoproject.org/meta-darwin/commit/?id=3D11f796b19e30c20b7f432=
b3a11d501e1e66f4956

On Mon, Feb 2, 2026 at 4:59=E2=80=AFPM Eric L. Hernes via lists.yoctoprojec=
t.org
<dev=3Dqinc.tv@lists.yoctoproject.org> wrote:

> The installed path to expat and liblldb are wrong.  This results in
> the binaries not running on the macOS host. With gdb, we have
>
> $ ./aarch64-oe-linux-gdb
> dyld[...]: Library not loaded: libexpat.1.dylib
>   Referenced from: <4F097B37-76EC-308F-8022-448023624AD3>
> /.../aarch64-oe-linux-gdb
>   Reason: tried: 'libexpat.1.dylib' (no such file),
>   '/System/Volumes/Preboot/Cryptexes/OSlibexpat.1.dylib' (no such
>   file), 'libexpat.1.dylib' (no such file), '....'
>
> Running otool shows (some output omitted for clarity):
> $ otool -L ./aarch64-oe-linux-gdb
> ./aarch64-oe-linux-gdb:
>         libexpat.1.dylib (compatibility version 12.0.0, current version
> 12.0.0)
>         @loader_path/../../lib/libmpfr.6.dylib (compatibility version
> 9.0.0, current
>
> One fix would be to patch the configure/build/install scripts to have
> the proper path to expat.
>
> The macOS tools give us a simpler option to just run
> `install_name_tool` to set it correctly.
>
> lldb-dap has a similar problem with `liblldb`.
>
> Signed-off-by: Eric L. Hernes <dev@qinc.tv>
> ---
>  recipes-devtools/clang/clang_%.bbappend            | 4 ++++
>  recipes-devtools/gdb/gdb-cross-canadian_%.bbappend | 8 +++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/recipes-devtools/clang/clang_%.bbappend
> b/recipes-devtools/clang/clang_%.bbappend
> index e55dff6..9aa2c83 100644
> --- a/recipes-devtools/clang/clang_%.bbappend
> +++ b/recipes-devtools/clang/clang_%.bbappend
> @@ -83,4 +83,8 @@ FILES:${PN} +=3D " \
>     ${libdir}/LLVMgold.dylib \
>  "
>
> +do_compile:append:class-nativesdk:darwin21() {
> +    ${SDK_PREFIX}install_name_tool -change liblldb.${PV}.dylib
> @loader_path/../lib/liblldb.${PV}.dylib ${B}/bin/lldb-dap
> +}
> +
>  INSANE_SKIP:${PN}:class-nativesdk:darwin21 +=3D " file-rdeps"
> diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> index 3f69019..8d30ffb 100644
> --- a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> +++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend
> @@ -16,4 +16,10 @@ EXTRA_OECONF:remove:darwinsdk =3D "--with-system-readl=
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
> --
> 2.50.1 (Apple Git-155)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3168):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3168&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DDnn=
aXiF2bjQKM8-IDWXut7OR6YYymC-9FFg1oCZNLUcdV64-OGGRKx_9gy78azAW&s=3DTLgX480aR=
6uD74bbLAUYHubl1Gonl_cEleuc6hdcpWs&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_117598468_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DDnnaXiF2bjQKM=
8-IDWXut7OR6YYymC-9FFg1oCZNLUcdV64-OGGRKx_9gy78azAW&s=3DDzvuKyl9Gzy0y3mKfDY=
l2vuXLIjSF7z7Uwl5TJFa9cc&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3DDnnaXiF2bjQKM8-IDWXut7OR6YYymC-9FFg1oCZNLUcdV64-OGG=
RKx_9gy78azAW&s=3DUq4tnTshRts6qa5baONv8242u3SWFU2ydn5U_gRKMto&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--0000000000006c4704064ba4f77d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br><br>Thanks for the patch!<br>Merged to main as=
=C2=A0<a href=3D"https://git.yoctoproject.org/meta-darwin/commit/?id=3D11f7=
96b19e30c20b7f432b3a11d501e1e66f4956">https://git.yoctoproject.org/meta-dar=
win/commit/?id=3D11f796b19e30c20b7f432b3a11d501e1e66f4956</a></div><br><div=
 class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Mon, Feb 2, 2026 at 4:59=E2=80=AFPM Eric L. Hernes via <a href=
=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;dev=3D<a =
href=3D"mailto:qinc.tv@lists.yoctoproject.org">qinc.tv@lists.yoctoproject.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">The installed path to expat and liblldb are wrong.=C2=A0 This results in<=
br>
the binaries not running on the macOS host. With gdb, we have<br>
<br>
$ ./aarch64-oe-linux-gdb<br>
dyld[...]: Library not loaded: libexpat.1.dylib<br>
=C2=A0 Referenced from: &lt;4F097B37-76EC-308F-8022-448023624AD3&gt; /.../a=
arch64-oe-linux-gdb<br>
=C2=A0 Reason: tried: &#39;libexpat.1.dylib&#39; (no such file),<br>
=C2=A0 &#39;/System/Volumes/Preboot/Cryptexes/OSlibexpat.1.dylib&#39; (no s=
uch<br>
=C2=A0 file), &#39;libexpat.1.dylib&#39; (no such file), &#39;....&#39;<br>
<br>
Running otool shows (some output omitted for clarity):<br>
$ otool -L ./aarch64-oe-linux-gdb<br>
./aarch64-oe-linux-gdb:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 libexpat.1.dylib (compatibility version 12.0.0,=
 current version 12.0.0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @loader_path/../../lib/libmpfr.6.dylib (compati=
bility version 9.0.0, current<br>
<br>
One fix would be to patch the configure/build/install scripts to have<br>
the proper path to expat.<br>
<br>
The macOS tools give us a simpler option to just run<br>
`install_name_tool` to set it correctly.<br>
<br>
lldb-dap has a similar problem with `liblldb`.<br>
<br>
Signed-off-by: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv" target=3D"=
_blank">dev@qinc.tv</a>&gt;<br>
---<br>
=C2=A0recipes-devtools/clang/clang_%.bbappend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 4 ++++<br>
=C2=A0recipes-devtools/gdb/gdb-cross-canadian_%.bbappend | 8 +++++++-<br>
=C2=A02 files changed, 11 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/recipes-devtools/clang/clang_%.bbappend b/recipes-devtools/cla=
ng/clang_%.bbappend<br>
index e55dff6..9aa2c83 100644<br>
--- a/recipes-devtools/clang/clang_%.bbappend<br>
+++ b/recipes-devtools/clang/clang_%.bbappend<br>
@@ -83,4 +83,8 @@ FILES:${PN} +=3D &quot; \<br>
=C2=A0 =C2=A0 ${libdir}/LLVMgold.dylib \<br>
=C2=A0&quot;<br>
<br>
+do_compile:append:class-nativesdk:darwin21() {<br>
+=C2=A0 =C2=A0 ${SDK_PREFIX}install_name_tool -change liblldb.${PV}.dylib @=
loader_path/../lib/liblldb.${PV}.dylib ${B}/bin/lldb-dap<br>
+}<br>
+<br>
=C2=A0INSANE_SKIP:${PN}:class-nativesdk:darwin21 +=3D &quot; file-rdeps&quo=
t;<br>
diff --git a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend b/recipes-d=
evtools/gdb/gdb-cross-canadian_%.bbappend<br>
index 3f69019..8d30ffb 100644<br>
--- a/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend<br>
+++ b/recipes-devtools/gdb/gdb-cross-canadian_%.bbappend<br>
@@ -16,4 +16,10 @@ EXTRA_OECONF:remove:darwinsdk =3D &quot;--with-system-re=
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
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3168): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3168&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DDnnaXiF2bjQKM8-IDWXut7OR6Y=
YymC-9FFg1oCZNLUcdV64-OGGRKx_9gy78azAW&amp;s=3DTLgX480aR6uD74bbLAUYHubl1Gon=
l_cEleuc6hdcpWs&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3168&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DD=
nnaXiF2bjQKM8-IDWXut7OR6YYymC-9FFg1oCZNLUcdV64-OGGRKx_9gy78azAW&amp;s=3DTLg=
X480aR6uD74bbLAUYHubl1Gonl_cEleuc6hdcpWs&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_117598468_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3DDnnaXiF2bjQKM8-IDWXut7OR6YYymC-9FFg1oCZNLUcdV6=
4-OGGRKx_9gy78azAW&amp;s=3DDzvuKyl9Gzy0y3mKfDYl2vuXLIjSF7z7Uwl5TJFa9cc&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_117598468_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DDnnaXiF2bjQKM8-IDWXut7OR6YYymC-=
9FFg1oCZNLUcdV64-OGGRKx_9gy78azAW&amp;s=3DDzvuKyl9Gzy0y3mKfDYl2vuXLIjSF7z7U=
wl5TJFa9cc&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DDnnaXiF2bjQKM=
8-IDWXut7OR6YYymC-9FFg1oCZNLUcdV64-OGGRKx_9gy78azAW&amp;s=3DUq4tnTshRts6qa5=
baONv8242u3SWFU2ydn5U_gRKMto&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DDnnaXiF2bjQKM8-IDWXut7OR6YYymC-9FFg1=
oCZNLUcdV64-OGGRKx_9gy78azAW&amp;s=3DUq4tnTshRts6qa5baONv8242u3SWFU2ydn5U_g=
RKMto&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--0000000000006c4704064ba4f77d--

