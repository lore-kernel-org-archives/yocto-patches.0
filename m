Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53782CDB479
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 09:00:33 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2726.1782291624503197681
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 02:00:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=o7cqW85b;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: jackson.james9803@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso706744a12.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 02:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782291623; cv=none;
        d=google.com; s=arc-20240605;
        b=c3w+OB5fV8kpajjJ8TygfG67pqg2IW/AIpF1n9oKkrnOnVH/h3JEsZIL1F32yZfQHm
         NCU/sHa41j2ckhr9xI2FAF3Ix0ENRaQVDRN3a8s52EMfQxqm0huEWOAglz7QvvIBZMcv
         BuoVJLTIF9RgCZlDuD4kKgILsrj/ozjzaO0O8N9hMH2kDNcs8A2ccByBZeFpOYzDznaG
         9lxhA7vPyQGz4cDer0mWCD0yjliY7+g14XVuQHNm9tHV+o4RKT1+/4irrY8zvmJ+3h6Z
         k0ZNN354c9ue6wCvxI3PVBzBVkPm3gbxVJ8ySOjMdMdB/7YYPWzV5hvcII3QKb/vOQI3
         28yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vGPIaYCxkzplkX/jEEl7Ew+bZe99JFqJ5Vo1fH2W2Oo=;
        fh=eSJHAoFNOdYsDj7gKKTW2Rj4cGqmVqZHwehqO+2rtmA=;
        b=QFDoxscQU4LsYq+Z881yuQX3bjkMvECHy7e5sMSmfqJFB7saOwkdAOf8MzqLyzjMvd
         8+ONDK+qHOQAEGqnxuu18D9rcGOLZjuZwCwFaMKM2AG8qeJcUwVnQlPCN1wDGm3PHX97
         dHuepIqxOV3IoAn8srdJ7gp2X4QbkcQ+SCB5VjgbhR2lbpmKcRCS6tH7zfRwI1j1jyXS
         IPT2KelvwmtDZ9+YSMBK8GwW0COxkLerDssCrSjhGKG1bJ2t0B9r+Cv3vuDxhP0zguTt
         BK6KGnS6ShV3GjrbvahWKVD3Bs9rCYQyflvOfbvU1vqGYp98KFXKeVgov7hdLJTA58Et
         XlNA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782291623; x=1782896423; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vGPIaYCxkzplkX/jEEl7Ew+bZe99JFqJ5Vo1fH2W2Oo=;
        b=o7cqW85bS2Ss3uxScgrQ48JfXtFkC1cGxDnbl+4C6FPtoGB4bGa2jd+m2NuW4zWrCL
         e0G2qnJzEaRIjGlFapeTCyHT8cw77TkQcUfhKbf6rvY7iqqAknzyXunBzfsGKuI5jirU
         g/pFhG+1k6KKUoo/LFYQgJ+LcIWz1C/6I1YNVqym9oCYO6Y1x8wJjgBhgy4eEJz75xIQ
         bH4bsG2U+vZWzitUqzBzkx0SWUG78K3D2hUwr/6yAHgyKh7kb+4FXZip1K5LgIByP+jk
         38115PeqNwqjzVFkrS0/JI6y7+/9MpT/lvYHF47e89SYLHABRTbHkOSuV1dECzDEGJUJ
         //ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782291623; x=1782896423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGPIaYCxkzplkX/jEEl7Ew+bZe99JFqJ5Vo1fH2W2Oo=;
        b=ndDPJhSMX5V2cPyL8iaIE0adDUkHaZ3KMX7fy6gqOlWn044aBOKgAPky69VqKsTLXP
         JzbDgRZF1YhDFXcKDEUZjLCsYBxNhbT8DF0DCLGIyQ9m/Okwl8a0a3DqSlsvA43uIbvG
         meIekak0kvjy0IUcuJWfpaHO2cxSuIDQWQQM5E2u9b+W/0IVeYLGoyX3KOczmEKBTw8r
         b96A11x5InG6tdwRPPvYozXuHpcDm7ZOvUzpqPWeFqp/XrTG+ukCIXoZIb5kY2xos49i
         5QHlFaKq83+Tzgn5N4hePRhGcEB1ordhLXxrpCybmBCQ3RkuMmOPIauiVEbtIO36MeOp
         syuA==
X-Gm-Message-State: AOJu0YxLxp4gFAjENvND7zzDdmY963XSDin5AgtxsZVLqrooIF6QZyX+
	y1vnc5uW4Mw1HIym4tHztrM3yLfYwz8udxVQIqohsX+TVRIGkDp3mx2iY35h1TDQTOFN+jFTajv
	S/dLfHkSZne1wGVKZHrzjuaGr+k+CiYCqGQ==
X-Gm-Gg: AfdE7ckjPZi5sj5cAQUUI+QlPw2Ts/26hiFCaSNEr4QfHfeI1F9nBCrGzYDND+N2okP
	pOK90JXviIpEXA0bvQPCSlYSSyo6mztvbtaV76VkgNZQaNuke55gHzGu9TgQU4Cp5V84xOYKruh
	2OE4uSVuHxqeP8JrIOwdN9Oj7hWHzt61ShyRIjP6XnO7UbBuarrJRuvawtY6/e6S2EhNs42E+G6
	iGOXyxJY24bcX14JH2HtNLWkMCBCKEv0RHvl3/uZmcTG9+5dFGVMN7pDugLssAp7/+UNmFoN4qh
	kOxRkzYXbr6P6sExTOvP+c7I/l8t
X-Received: by 2002:a05:6402:4012:b0:697:f2e4:3f11 with SMTP id
 4fb4d7f45d1cf-697f3aa2236mr1103109a12.14.1782291622322; Wed, 24 Jun 2026
 02:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260623094813.130228-1-jacksonj2@kpit.com>
In-Reply-To: <20260623094813.130228-1-jacksonj2@kpit.com>
From: Jackson James <jackson.james9803@gmail.com>
Date: Wed, 24 Jun 2026 14:30:09 +0530
X-Gm-Features: AVVi8Ce5B7l2o2MEnZ7lQQl-H-xQx85Xq6_HcHJQbkya0PdmJkWoAy-gLdpjT5o
Message-ID: <CADuKNg7pRs6a274-kbksQuy1EUpiPzw_qWozZk+tndxKy_Ua4g@mail.gmail.com>
Subject: Re: [meta-lts-collab][kirkstone][PATCH] jpeg: Reject unsupported
 number of components
To: yocto-patches@lists.yoctoproject.org
Cc: careers.myinfo@gmail.com
Content-Type: multipart/alternative; boundary="00000000000008e63d0654fc1b7e"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 09:00:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4292

--00000000000008e63d0654fc1b7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi team,
Please ignore the patch. Will update patch commit message and send it again

Regards,
Jackson James

On Tue, 23 Jun, 2026, 3:18=E2=80=AFpm Jackson James, <jackson.james9803@gma=
il.com>
wrote:

> From: Shaik Moin <careers.myinfo@gmail.com>
>
> This condition was already checked for incremental loading.
> This commit adds the same check in the nonincremental
> code path.
>
> Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
> ---
>  .../gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch | 47 +++++++++++++++++++
>  .../gdk-pixbuf/gdk-pixbuf_%.bbappend          |  4 ++
>  2 files changed, 51 insertions(+)
>  create mode 100644
> meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch
>  create mode 100644 meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappen=
d
>
> diff --git
> a/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch
> b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch
> new file mode 100644
> index 0000000..d5bf327
> --- /dev/null
> +++ b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch
> @@ -0,0 +1,47 @@
> +From 4d6eb46037d1b6a298d5db293dba57bbea4d0d08 Mon Sep 17 00:00:00 2001
> +From: Shaik Moin <careers.myinfo@gmail.com>
> +Date: Thu, 18 Jun 2026 14:51:28 +0530
> +Subject: [PATCH] jpeg: Reject unsupported number of components
> +
> +Backport the fix for CVE-2026-5201
> +
> +This condition was already checked for incremental loading.
> +This commit adds the same check in the nonincremental
> +code path.
> +
> +CVE: CVE-2026-5201
> +
> +Upstream-Status: Backport [
> https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/commit/6cce9311e70b969cbcc6e3=
e1e74ae1756ed02d5b
> ]
> +
> +Reviewed-by: Matthias Clasen <mclasen@redhat.com>
> +Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
> +---
> + gdk-pixbuf/io-jpeg.c | 12 ++++++++++++
> + 1 file changed, 12 insertions(+)
> +
> +diff --git a/gdk-pixbuf/io-jpeg.c b/gdk-pixbuf/io-jpeg.c
> +index 9ee1d21..60ad0d0 100644
> +--- a/gdk-pixbuf/io-jpeg.c
> ++++ b/gdk-pixbuf/io-jpeg.c
> +@@ -625,6 +625,18 @@ gdk_pixbuf__real_jpeg_image_load (FILE *f, struct
> jpeg_decompress_struct *cinfo,
> +       cinfo->do_fancy_upsampling =3D FALSE;
> +       cinfo->do_block_smoothing =3D FALSE;
> +
> ++        /* Reject unsupported component counts */
> ++        if (cinfo->output_components !=3D 3 && cinfo->output_components=
 !=3D
> 4 &&
> ++            !(cinfo->output_components =3D=3D 1 &&
> ++              cinfo->out_color_space =3D=3D JCS_GRAYSCALE)) {
> ++                g_set_error (error,
> ++                             GDK_PIXBUF_ERROR,
> ++                             GDK_PIXBUF_ERROR_CORRUPT_IMAGE,
> ++                             _("Unsupported number of color components
> (%d)"),
> ++                             cinfo->output_components);
> ++                goto out;
> ++        }
> ++
> +       pixbuf =3D gdk_pixbuf_new (GDK_COLORSPACE_RGB,
> +                                cinfo->out_color_components =3D=3D 4 ? T=
RUE :
> FALSE,
> +                                8,
> +--
> +2.34.1
> +
> diff --git a/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappend
> b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappend
> new file mode 100644
> index 0000000..6a5584e
> --- /dev/null
> +++ b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappend
> @@ -0,0 +1,4 @@
> +FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
> +
> +SRC_URI +=3D "file://CVE-2026-5201.patch \
> +"
> --
> 2.34.1
>
>

--00000000000008e63d0654fc1b7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span style=3D"font-size:12.8px;background-color:rgb(18,1=
9,22)">Hi team,</span><div dir=3D"auto" style=3D"font-size:12.8px;backgroun=
d-color:rgb(18,19,22)">Please ignore the patch. Will update patch commit me=
ssage and send it again</div><div dir=3D"auto" style=3D"font-size:12.8px;ba=
ckground-color:rgb(18,19,22)"><br></div><div dir=3D"auto" style=3D"font-siz=
e:12.8px;background-color:rgb(18,19,22)">Regards,</div><div dir=3D"auto" st=
yle=3D"font-size:12.8px;background-color:rgb(18,19,22)">Jackson James</div>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, 23 Jun, 2026, 3:18=E2=80=AFpm Jackson James, =
&lt;<a href=3D"mailto:jackson.james9803@gmail.com">jackson.james9803@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Shaik Moin=
 &lt;<a href=3D"mailto:careers.myinfo@gmail.com" target=3D"_blank" rel=3D"n=
oreferrer">careers.myinfo@gmail.com</a>&gt;<br>
<br>
This condition was already checked for incremental loading.<br>
This commit adds the same check in the nonincremental<br>
code path.<br>
<br>
Signed-off-by: Shaik Moin &lt;<a href=3D"mailto:careers.myinfo@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">careers.myinfo@gmail.com</a>&gt;<br>
---<br>
=C2=A0.../gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch | 47 ++++++++++++++++++=
+<br>
=C2=A0.../gdk-pixbuf/gdk-pixbuf_%.bbappend=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 4 ++<br>
=C2=A02 files changed, 51 insertions(+)<br>
=C2=A0create mode 100644 meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-20=
26-5201.patch<br>
=C2=A0create mode 100644 meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbap=
pend<br>
<br>
diff --git a/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patc=
h b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch<br>
new file mode 100644<br>
index 0000000..d5bf327<br>
--- /dev/null<br>
+++ b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch<br>
@@ -0,0 +1,47 @@<br>
+From 4d6eb46037d1b6a298d5db293dba57bbea4d0d08 Mon Sep 17 00:00:00 2001<br>
+From: Shaik Moin &lt;<a href=3D"mailto:careers.myinfo@gmail.com" target=3D=
"_blank" rel=3D"noreferrer">careers.myinfo@gmail.com</a>&gt;<br>
+Date: Thu, 18 Jun 2026 14:51:28 +0530<br>
+Subject: [PATCH] jpeg: Reject unsupported number of components<br>
+<br>
+Backport the fix for CVE-2026-5201<br>
+<br>
+This condition was already checked for incremental loading.<br>
+This commit adds the same check in the nonincremental<br>
+code path.<br>
+<br>
+CVE: CVE-2026-5201<br>
+<br>
+Upstream-Status: Backport [<a href=3D"https://gitlab.gnome.org/GNOME/gdk-p=
ixbuf/-/commit/6cce9311e70b969cbcc6e3e1e74ae1756ed02d5b" rel=3D"noreferrer =
noreferrer" target=3D"_blank">https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/c=
ommit/6cce9311e70b969cbcc6e3e1e74ae1756ed02d5b</a>]<br>
+<br>
+Reviewed-by: Matthias Clasen &lt;<a href=3D"mailto:mclasen@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">mclasen@redhat.com</a>&gt;<br>
+Signed-off-by: Shaik Moin &lt;<a href=3D"mailto:careers.myinfo@gmail.com" =
target=3D"_blank" rel=3D"noreferrer">careers.myinfo@gmail.com</a>&gt;<br>
+---<br>
+ gdk-pixbuf/io-jpeg.c | 12 ++++++++++++<br>
+ 1 file changed, 12 insertions(+)<br>
+<br>
+diff --git a/gdk-pixbuf/io-jpeg.c b/gdk-pixbuf/io-jpeg.c<br>
+index 9ee1d21..60ad0d0 100644<br>
+--- a/gdk-pixbuf/io-jpeg.c<br>
++++ b/gdk-pixbuf/io-jpeg.c<br>
+@@ -625,6 +625,18 @@ gdk_pixbuf__real_jpeg_image_load (FILE *f, struct jpe=
g_decompress_struct *cinfo,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cinfo-&gt;do_fancy_upsampling =3D FALSE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0cinfo-&gt;do_block_smoothing =3D FALSE;<br>
+ <br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Reject unsupported component counts */<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cinfo-&gt;output_components !=3D 3 &amp;&=
amp; cinfo-&gt;output_components !=3D 4 &amp;&amp;<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(cinfo-&gt;output_components =
=3D=3D 1 &amp;&amp;<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cinfo-&gt;out_color_spac=
e =3D=3D JCS_GRAYSCALE)) {<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_set_error (erro=
r,<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GDK_PIXBUF_ERROR,<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GDK_PIXBUF_ERROR_CORRUPT_IMAGE,<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_(&quot;Unsupported number of color componen=
ts (%d)&quot;),<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cinfo-&gt;output_components);<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
++<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pixbuf =3D gdk_pixbuf_new (GDK_COLORSPACE_RGB, =
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cinfo-&gt;out_color_components =3D=
=3D 4 ? TRUE : FALSE, <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8,<br>
+-- <br>
+2.34.1<br>
+<br>
diff --git a/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappend b/meta-=
oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappend<br>
new file mode 100644<br>
index 0000000..6a5584e<br>
--- /dev/null<br>
+++ b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappend<br>
@@ -0,0 +1,4 @@<br>
+FILESEXTRAPATHS:prepend :=3D &quot;${THISDIR}/files:&quot;<br>
+<br>
+SRC_URI +=3D &quot;file://CVE-2026-5201.patch \<br>
+&quot;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--00000000000008e63d0654fc1b7e--

