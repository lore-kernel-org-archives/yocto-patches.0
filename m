Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0987D591AE
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 19:15:08 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
 by mx.groups.io with SMTP id smtpd.web11.1591.1731957306377075612
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Nov 2024 11:15:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H29cm8HA;
 spf=pass (domain: gmail.com, ip: 209.85.210.43, mailfrom: raj.khem@gmail.com)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7187e0041d5so1627400a34.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 11:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731957305; x=1732562105; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zt2vqOpZQkHPQw1afKFEVB9XmD3E2a4Py7DZuK9hzA=;
        b=H29cm8HAJeGz1M8sUYG5Vgo6GKkoD9FB94sLPGTqT7O6wJEbQVaxl7GVERhSNXoN/J
         TwsjeS8Aw2vAexQwXuhWzI5KvQYT0frk5CDnt2MtD5BG2xly8lFxmqbrRRC/oyJE5aIj
         +vk1Y7bEZqbnIpiqpFRhyFs+LMJv0jiLCqOov3FXgzR6SyD2qbOHC51cZ7OM1JBT+coz
         KawiSojUVVU7fNqHLayBxHdTOV7Fn8nuOiHcm7T8oRKI63yKnhbOsMRVEZEGjxUqdCck
         XdmbWvRG2j0zYNrR7uO466RPn0qXijBxMZ/R2Btlj9UDb8h2e0RuBvasRyytBaTdW25v
         gkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731957305; x=1732562105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Zt2vqOpZQkHPQw1afKFEVB9XmD3E2a4Py7DZuK9hzA=;
        b=qSu0c82hevrCQDyZ+3lfV3zX1LQwWaCY8yNUuwW7Y/bUZYoDHAFjvcG44WftQ/c99c
         iqwBVNK3ZMCd7pKy0lkb4DrAHsl9gK2e/RKG06CkD4oYiBuppzXQmbEOSeEdx34TTzCg
         wjhNzvl7Xu59OOAA/uu+cJ1GTH4BLTb4cjgf/cG+MFmzFGKe65/U1DJ213t6q3LRlyRv
         xhydy2dSt5ZF80C6buLhjvv8sYl5oSalnEKU2g62qV5cDsL4LYYo2WdcMtm4l8300hTP
         93he0b8ZgdTpr2hvmgOVbaE0ME5gkJbqrjYc/ZE54cwMwhCv3JbtRBabE0mrNDkAgOk0
         bsHw==
X-Gm-Message-State: AOJu0YxqJWPOkK0HrK/+5sWXXq4JkUWxPtipfSd1hlOWnBERxlptxEsC
	4jRBcSoaZrciqC3SRrej2SMJlLldxTCGCLiDIqug/ak/Q+rXs8WRJzmf5G0TPvtguNcB8rIs5dz
	vPq7B6bUatKWXZTw3SQYvQJV+/o9x8L37
X-Google-Smtp-Source: AGHT+IEWTw8n+mwJ3dV4uLRZjj8/48aI3j131WVyOErMTbowVJaZe4H+QPxsjSuk1nu5EinyNo29r91K0c6DdosdCDc=
X-Received: by 2002:a05:6830:3691:b0:718:1767:912f with SMTP id
 46e09a7af769-71a777b6770mr13050890a34.0.1731957305401; Mon, 18 Nov 2024
 11:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20241118153117.307424-1-ryosuke.saito@linaro.org>
In-Reply-To: <20241118153117.307424-1-ryosuke.saito@linaro.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 19 Nov 2024 00:44:54 +0530
Message-ID: <CAMKF1spA4GBsR4h6Bx34a1cG8ZePTHU_8=8K+2UukfmHZvnvdQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-cgl] [PATCH] ocfs2-tools: Add missing
 readline dependency
To: yocto-patches@lists.yoctoproject.org
Cc: raitosyo@gmail.com
Content-Type: multipart/alternative; boundary="000000000000f46809062734bb36"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 19:15:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/821

--000000000000f46809062734bb36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 7:31=E2=80=AFAM Ryosuke Saito via lists.yoctoprojec=
t.org
<ryosuke.saito=3Dlinaro.org@lists.yoctoproject.org> wrote:

> This patch fixes a build error during the ./configure phase:
>
> | checking for readline in -lreadline... no
> | configure: error: Unable to find readline library
>
> Adds readline to DEPENDS to resolve the issue, enabling proper linking
> during the build process.
>
> Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
> ---
>  meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
> b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
> index 28b82c2cda94..69daff031a04 100644
> --- a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
> +++ b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
> @@ -31,7 +31,7 @@ inherit autotools-brokensep pkgconfig systemd
>
>  DEPENDS =3D "corosync pacemaker \
>      libxml2 linux-libc-headers libaio \
> -    e2fsprogs e2fsprogs-native \
> +    e2fsprogs e2fsprogs-native readline \
>  "


Is there a configure knob to enable/disable it ? If so that might be used
via a packageconfig

>
>
>
> --
> 2.47.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#819):
> https://lists.yoctoproject.org/g/yocto-patches/message/819
> Mute This Topic: https://lists.yoctoproject.org/mt/109646026/1997914
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/645=
821814/xyzzy
> [raj.khem@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000f46809062734bb36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Nov 18, 2024 at 7:31=E2=80=AFAM Ryosuke Saito via <=
a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.org</a> &lt;ryo=
suke.saito=3D<a href=3D"mailto:linaro.org@lists.yoctoproject.org">linaro.or=
g@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">This patch fixes a build error during the ./configure phase:<br>
<br>
| checking for readline in -lreadline... no<br>
| configure: error: Unable to find readline library<br>
<br>
Adds readline to DEPENDS to resolve the issue, enabling proper linking<br>
during the build process.<br>
<br>
Signed-off-by: Ryosuke Saito &lt;<a href=3D"mailto:ryosuke.saito@linaro.org=
" target=3D"_blank">ryosuke.saito@linaro.org</a>&gt;<br>
---<br>
=C2=A0meta-cgl-common/recipes-cgl/ocfs2-tools/<a href=3D"http://ocfs2-tools=
_1.8.6.bb" rel=3D"noreferrer" target=3D"_blank">ocfs2-tools_1.8.6.bb</a> | =
2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/meta-cgl-common/recipes-cgl/ocfs2-tools/<a href=3D"http://ocfs=
2-tools_1.8.6.bb" rel=3D"noreferrer" target=3D"_blank">ocfs2-tools_1.8.6.bb=
</a> b/meta-cgl-common/recipes-cgl/ocfs2-tools/<a href=3D"http://ocfs2-tool=
s_1.8.6.bb" rel=3D"noreferrer" target=3D"_blank">ocfs2-tools_1.8.6.bb</a><b=
r>
index 28b82c2cda94..69daff031a04 100644<br>
--- a/meta-cgl-common/recipes-cgl/ocfs2-tools/<a href=3D"http://ocfs2-tools=
_1.8.6.bb" rel=3D"noreferrer" target=3D"_blank">ocfs2-tools_1.8.6.bb</a><br=
>
+++ b/meta-cgl-common/recipes-cgl/ocfs2-tools/<a href=3D"http://ocfs2-tools=
_1.8.6.bb" rel=3D"noreferrer" target=3D"_blank">ocfs2-tools_1.8.6.bb</a><br=
>
@@ -31,7 +31,7 @@ inherit autotools-brokensep pkgconfig systemd<br>
<br>
=C2=A0DEPENDS =3D &quot;corosync pacemaker \<br>
=C2=A0 =C2=A0 =C2=A0libxml2 linux-libc-headers libaio \<br>
-=C2=A0 =C2=A0 e2fsprogs e2fsprogs-native \<br>
+=C2=A0 =C2=A0 e2fsprogs e2fsprogs-native readline \<br>
=C2=A0&quot;</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Is t=
here a configure knob to enable/disable it ? If so that might be used via a=
 packageconfig=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex" dir=3D"auto"><br>
<br>
<br>
-- <br>
2.47.0<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#819): <a href=3D"https://lists.yoctoproject.org/g/yocto=
-patches/message/819" rel=3D"noreferrer" target=3D"_blank">https://lists.yo=
ctoproject.org/g/yocto-patches/message/819</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/109646026/199=
7914" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/m=
t/109646026/1997914</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13340786/1997914/645821814/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13340786/1997914/6458218=
14/xyzzy</a> [<a href=3D"mailto:raj.khem@gmail.com" target=3D"_blank">raj.k=
hem@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--000000000000f46809062734bb36--

