Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDCFF506D8
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:17:13 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51684.1773670627077597805
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 07:17:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=EROSCPIe;
 spf=pass (domain: snapchat.com, ip: 209.85.221.50, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b4915161fso255316f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 07:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773670625; cv=none;
        d=google.com; s=arc-20240605;
        b=A9T4y0P/D+rSZ0qVoS9QeIZtiEZoA3N5x107Ro9FXKVVXj+goASq3sghKXkIGtqT/B
         UqF3/GHie5F/6097dhX01vlK+1HiF4SN7um6C4AoLfKt42BLVSr0mkxvFhV9tPB5G/uv
         BxOTmYkVysBnjyxzRd5L4+Lu16KSGEuJ9ZEyxcYeT/M1iScIdYoSp+nZUGkPS/0LSDSy
         61mmfS1FD5Sc3NKMrG1hosKanMltErPhwwIcHcyEXDIGX5HKTNdJQj2GNVQbYwziQsii
         eLqR29EFBGF6K+7A3nKiXtxeNeEr/yju4mUSkumO68sDG7MyfyPEtxLqh0jPWU9SIAAk
         Fl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X+ePRb/OfXUPdmDCClYiIIs0OAc4YiOzmpbHkDajzDw=;
        fh=vnwvjJBmT4xP5bZnotRs811IpgK/To6PNpBe4whKe/M=;
        b=YIINNV1AEtFHqNcd39z2Y3n71rSXi7EDNcul6sUPB5wP5bQ36RDRIknHbUGCjCCNQV
         PlSzGwbwQboSunAIGmc7cBxYE/DZg6oDPo/LXpdvoi7W32JiGAzE1a5ZqGzaEhfJ4z3B
         FdgzNBSdImSviccqQHWghtJb/NWLQWw5j1nQYgobhMHn6x/Yczqyzgr+kKgUMYg159oc
         TAAQEsasvqccIRHAdclwsBYLGqtSjo1guvDD+vQMQ2naEbOGwVBQCI/LP92bqRlwO5Cn
         tR6bGc7UqOXUYxDraWgOmp5nz7ftK846MhKgN+xWSTDjTuYTNXOVxmzsaMd/07EjsTZW
         Q2Nw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1773670625; x=1774275425; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X+ePRb/OfXUPdmDCClYiIIs0OAc4YiOzmpbHkDajzDw=;
        b=EROSCPIejCFfxru6nTo7IL7CROzTWMJt0/a9arUh7kJeoiUff82RGOwU2JmoMtTOGQ
         IQSdetZxjqncusofR3zL1yFWZzj4JNJT3fnLHblbqvZbTc0s4zi+dtnwxvGgqRwjUkMU
         3+4lgxOkFiTJWIYYAafdGM7l1nJ46JLpiM44Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773670625; x=1774275425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+ePRb/OfXUPdmDCClYiIIs0OAc4YiOzmpbHkDajzDw=;
        b=ZAUi360rKgYuno3rCdJSQobq3lj4WS/PQYsv0qBxkSEsvjt8Gh2e5DDB7C3HBYOjdr
         xgNPoAeI7b1rXzjtUojRcFmRxZPJBVIQAoSsaLqy2EKgEwLUdtJgo2WrloXqJ8AsawhA
         fKMh1ag1trpCJIZBpqgRPRf9E6AryZL32KgakUQwUAMKR1sC45uh3di4TDZKkkK+kfdp
         6Hf/jq5dx+YHMfMRMWTzZwZrZn+Bsp3ET3xYkDjP89P40jfdiqnD/UbDwi5Mnk4i5Bgl
         icHoEA09TxibZkm9xXgPNaC86i980UdxZVqBJOLb8gjEqwni068Oa2gcexdl+c1cQfvH
         wI8w==
X-Gm-Message-State: AOJu0YxpxHrtTaHk6ZJRWLm/xnMHzS72TqRb5t9MUTjVGvesrssjxlDs
	C3DPyrnD8hBlOsjNdgE0chNCZoNxAqnv5T56j7K/Kpe1/VB/GocOGj8lh69y/PtULeVvBZ2xIhN
	XBEFmxKMWkJWYiAvEIRhTyKgNI6Vt6UqrflEgnU11xZThjvGqF57rbxFwZQ==
X-Gm-Gg: ATEYQzzN99GRTLsERM+JncCN2OS+IlUMfjMccnB7QNS7P4LVwI7Yr+smDsV8ReQqelR
	+ZhDzBW4Jt4yEcWXis9lBHYwyXnzzFY3CG14cjje+OAcgk+/+SdyZCoRLPF65INhYaokkgofSEO
	KclxRy64utQv7LtCmLkm3oQagOKro4QJNfytP7ndC3Gnvjk64DL+JFueJNhFo/msIUmcN+BCdrR
	GhBZZa7H2hasO6GkuDhAoAwpT6CbxD4ze28p3vlgOVRaTCKPn+V5OpG7yogz09+EBbRlWH2wp6n
	FOjxbSIdxEvIe6g3LwkOb9pUi1R/Q5Q3/X9iuPM=
X-Received: by 2002:a05:600c:8b46:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-485566d7092mr216467855e9.12.1773670624434; Mon, 16 Mar 2026
 07:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260309231251.99347-1-dev@qinc.tv> <20260309231251.99347-3-dev@qinc.tv>
In-Reply-To: <20260309231251.99347-3-dev@qinc.tv>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Mon, 16 Mar 2026 15:16:52 +0100
X-Gm-Features: AaiRm50KTitMmvSZ7YmFXFcLMxZabHhuF3oMVYW695fpUQs-0tQetepWuqk-03U
Message-ID: <CAHUKmYYiVRfS4LqmqcQbpmER2rKC=tWjGCWr-dEZ8V5kr3Gjgw@mail.gmail.com>
Subject: Re: [yocto-patches] [PATCH 2/2] convert libdispatch to native-only recipe
To: yocto-patches@lists.yoctoproject.org
Cc: "Eric L. Hernes" <dev@qinc.tv>
Content-Type: multipart/alternative; boundary="00000000000084cc84064d24df21"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 14:17:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3474

--00000000000084cc84064d24df21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,
thanks for the patches. I have merged them as
https://git.yoctoproject.org/meta-darwin/commit/?id=3Dc07b59a59fb3d27ecc6ac=
1e22db16c667b424cdd
and
https://git.yoctoproject.org/meta-darwin/commit/?id=3Dcb5e3675542e4c4aa088a=
b5a5acf20d00bb8334e

=C3=89tienne

On Tue, Mar 10, 2026 at 12:13=E2=80=AFAM Eric L. Hernes via lists.yoctoproj=
ect.org
<dev=3Dqinc.tv@lists.yoctoproject.org> wrote:

> Signed-off-by: Eric L. Hernes <dev@qinc.tv>
> ---
>  .../{libdispatch_git.bb =3D> libdispatch-native_git.bb}        | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>  rename recipes-devtools/libdispatch/{libdispatch_git.bb =3D>
> libdispatch-native_git.bb} (94%)
>
> diff --git a/recipes-devtools/libdispatch/libdispatch_git.bb
> b/recipes-devtools/libdispatch/libdispatch-native_git.bb
> similarity index 94%
> rename from recipes-devtools/libdispatch/libdispatch_git.bb
> rename to recipes-devtools/libdispatch/libdispatch-native_git.bb
> index 05b309d..07f3c78 100644
> --- a/recipes-devtools/libdispatch/libdispatch_git.bb
> +++ b/recipes-devtools/libdispatch/libdispatch-native_git.bb
> @@ -11,13 +11,12 @@ SECTION =3D "devel"
>  SRCREV =3D "e85f6a0d5c9ea1f32f5013c3fa34e4fc146cd0eb"
>  SRC_URI =3D "git://
> github.com/swiftlang/swift-corelibs-libdispatch.git;nobranch=3D1;protocol=
=3Dhttps
> "
>
> -inherit cmake
> -
> -BBCLASSEXTEND =3D "native"
> +inherit cmake native
>
>  S =3D "${WORKDIR}/git"
>  B =3D "${WORKDIR}/build"
>
> +
>  DEPENDS +=3D " \
>      clang-native \
>      libcxx-native \
> --
> 2.50.1 (Apple Git-155)
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3390):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_message_3390&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vC=
HvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Dgh6=
HSMbmx0OD3n83Jfv6c6ABbwso7uhJMEOr01XIgLCAJ_3ssel-EtV6FUT6pw2a&s=3DrpcpUxM1_=
bvQGz8T16lIrASFqhDdS1jIoYmjxX4Ys6g&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_mt_118232149_7048771&d=3DDwIFAg&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Dgh6HSMbmx0OD3=
n83Jfv6c6ABbwso7uhJMEOr01XIgLCAJ_3ssel-EtV6FUT6pw2a&s=3D7Lv7J9_Py0HjRnoMuou=
4qYryqnKTTO2eTl3dZ0l_gcQ&e=3D
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject=
.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&d=3DDwIFAg&c=
=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&m=3Dgh6HSMbmx0OD3n83Jfv6c6ABbwso7uhJMEOr01XIgLCAJ_3ssel=
-EtV6FUT6pw2a&s=3DtzyFN712dDuPoNUmp9p_EN2zT5ZutsBE1KzYrH6Z_8E&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--00000000000084cc84064d24df21
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<br>thanks for the patches. I have merged them as=
=C2=A0<a href=3D"https://git.yoctoproject.org/meta-darwin/commit/?id=3Dc07b=
59a59fb3d27ecc6ac1e22db16c667b424cdd">https://git.yoctoproject.org/meta-dar=
win/commit/?id=3Dc07b59a59fb3d27ecc6ac1e22db16c667b424cdd</a> and=C2=A0<a h=
ref=3D"https://git.yoctoproject.org/meta-darwin/commit/?id=3Dcb5e3675542e4c=
4aa088ab5a5acf20d00bb8334e">https://git.yoctoproject.org/meta-darwin/commit=
/?id=3Dcb5e3675542e4c4aa088ab5a5acf20d00bb8334e</a><br><br>=C3=89tienne</di=
v><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Tue, Mar 10, 2026 at 12:13=E2=80=AFAM Eric L. Hernes v=
ia <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt=
;dev=3D<a href=3D"mailto:qinc.tv@lists.yoctoproject.org">qinc.tv@lists.yoct=
oproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Signed-off-by: Eric L. Hernes &lt;<a href=3D"mailto:dev@qinc.tv=
" target=3D"_blank">dev@qinc.tv</a>&gt;<br>
---<br>
=C2=A0.../{<a href=3D"http://libdispatch_git.bb" rel=3D"noreferrer" target=
=3D"_blank">libdispatch_git.bb</a> =3D&gt; <a href=3D"http://libdispatch-na=
tive_git.bb" rel=3D"noreferrer" target=3D"_blank">libdispatch-native_git.bb=
</a>}=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 5 ++---<br>
=C2=A01 file changed, 2 insertions(+), 3 deletions(-)<br>
=C2=A0rename recipes-devtools/libdispatch/{<a href=3D"http://libdispatch_gi=
t.bb" rel=3D"noreferrer" target=3D"_blank">libdispatch_git.bb</a> =3D&gt; <=
a href=3D"http://libdispatch-native_git.bb" rel=3D"noreferrer" target=3D"_b=
lank">libdispatch-native_git.bb</a>} (94%)<br>
<br>
diff --git a/recipes-devtools/libdispatch/<a href=3D"http://libdispatch_git=
.bb" rel=3D"noreferrer" target=3D"_blank">libdispatch_git.bb</a> b/recipes-=
devtools/libdispatch/<a href=3D"http://libdispatch-native_git.bb" rel=3D"no=
referrer" target=3D"_blank">libdispatch-native_git.bb</a><br>
similarity index 94%<br>
rename from recipes-devtools/libdispatch/<a href=3D"http://libdispatch_git.=
bb" rel=3D"noreferrer" target=3D"_blank">libdispatch_git.bb</a><br>
rename to recipes-devtools/libdispatch/<a href=3D"http://libdispatch-native=
_git.bb" rel=3D"noreferrer" target=3D"_blank">libdispatch-native_git.bb</a>=
<br>
index 05b309d..07f3c78 100644<br>
--- a/recipes-devtools/libdispatch/<a href=3D"http://libdispatch_git.bb" re=
l=3D"noreferrer" target=3D"_blank">libdispatch_git.bb</a><br>
+++ b/recipes-devtools/libdispatch/<a href=3D"http://libdispatch-native_git=
.bb" rel=3D"noreferrer" target=3D"_blank">libdispatch-native_git.bb</a><br>
@@ -11,13 +11,12 @@ SECTION =3D &quot;devel&quot;<br>
=C2=A0SRCREV =3D &quot;e85f6a0d5c9ea1f32f5013c3fa34e4fc146cd0eb&quot;<br>
=C2=A0SRC_URI =3D &quot;git://<a href=3D"http://github.com/swiftlang/swift-=
corelibs-libdispatch.git;nobranch=3D1;protocol=3Dhttps" rel=3D"noreferrer" =
target=3D"_blank">github.com/swiftlang/swift-corelibs-libdispatch.git;nobra=
nch=3D1;protocol=3Dhttps</a>&quot;<br>
<br>
-inherit cmake<br>
-<br>
-BBCLASSEXTEND =3D &quot;native&quot;<br>
+inherit cmake native<br>
<br>
=C2=A0S =3D &quot;${WORKDIR}/git&quot;<br>
=C2=A0B =3D &quot;${WORKDIR}/build&quot;<br>
<br>
+<br>
=C2=A0DEPENDS +=3D &quot; \<br>
=C2=A0 =C2=A0 =C2=A0clang-native \<br>
=C2=A0 =C2=A0 =C2=A0libcxx-native \<br>
-- <br>
2.50.1 (Apple Git-155)<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#3390): <a href=3D"https://urldefense.proofpoint.com/v2/=
url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2Dpatches_message_3390&amp=
;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhk=
bNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dgh6HSMbmx0OD3n83Jfv6c6ABbw=
so7uhJMEOr01XIgLCAJ_3ssel-EtV6FUT6pw2a&amp;s=3DrpcpUxM1_bvQGz8T16lIrASFqhDd=
S1jIoYmjxX4Ys6g&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urld=
efense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_g_yocto-2=
Dpatches_message_3390&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgG=
kICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dg=
h6HSMbmx0OD3n83Jfv6c6ABbwso7uhJMEOr01XIgLCAJ_3ssel-EtV6FUT6pw2a&amp;s=3Drpc=
pUxM1_bvQGz8T16lIrASFqhDdS1jIoYmjxX4Ys6g&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.yoctoproject.org_mt_118232149_7048771&amp;d=3DDwIFAg&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3Dgh6HSMbmx0OD3n83Jfv6c6ABbwso7uhJMEOr01XIgLCAJ_=
3ssel-EtV6FUT6pw2a&amp;s=3D7Lv7J9_Py0HjRnoMuou4qYryqnKTTO2eTl3dZ0l_gcQ&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.yoctoproject.org_mt_118232149_7048771&amp;d=3D=
DwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dgh6HSMbmx0OD3n83Jfv6c6ABbwso7uh=
JMEOr01XIgLCAJ_3ssel-EtV6FUT6pw2a&amp;s=3D7Lv7J9_Py0HjRnoMuou4qYryqnKTTO2eT=
l3dZ0l_gcQ&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.yoctoproject.org_g_yocto-2Dpatches_leave_13184993_7048771_1814342=
232_xyzzy&amp;d=3DDwIFAg&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdi=
w&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dgh6HSMbmx0OD3=
n83Jfv6c6ABbwso7uhJMEOr01XIgLCAJ_3ssel-EtV6FUT6pw2a&amp;s=3DtzyFN712dDuPoNU=
mp9p_EN2zT5ZutsBE1KzYrH6Z_8E&amp;e=3D" rel=3D"noreferrer" target=3D"_blank"=
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.yoctoproject.=
org_g_yocto-2Dpatches_leave_13184993_7048771_1814342232_xyzzy&amp;d=3DDwIFA=
g&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGR=
fPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3Dgh6HSMbmx0OD3n83Jfv6c6ABbwso7uhJMEOr=
01XIgLCAJ_3ssel-EtV6FUT6pw2a&amp;s=3DtzyFN712dDuPoNUmp9p_EN2zT5ZutsBE1KzYrH=
6Z_8E&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" target=3D=
"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div>

--00000000000084cc84064d24df21--

