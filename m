Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19209.1792912848496677160
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 25 Oct 2026 00:20:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OFuqfKYX;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: gael.portay@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49e71fc84bbso1614285e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 25 Oct 2026 00:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792912847; x=1793517647; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jkDqSI5mgrdnh7wtMyvIjRNEcefr/32dsGYkothGRFA=;
        b=OFuqfKYXvxyEk8SXGa1L5bBC/c1VHJKpKnh6cqDsfVdOVQcOo9qTL6DEDno3TcXbQ8
         CQ9g/HFAmdtYHu5u25CV+NvSe5qnkn1wg03MGdqxQGKdmYhujFPbPVPB+7SV9AXe3GnS
         WrYYPK4dYZWeRLVCCxidrggzUELOcXfxpvqXJPdIKUwqOPlGYw2TV9JCo8ipG3Tl5/AE
         Rv+PyhPH7wdAeAv6pEsJTSUrdoC5y5WLPp06DRVnBv3x7h5VrBLLLOJXolKE2tVpBiEb
         zTJ45tFYQ63z+ywKorhA9b5ER4oHMXbp7gujs5qpeyr4vWjWeMKTV753rk0XfgLAtIsD
         mT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792912847; x=1793517647;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkDqSI5mgrdnh7wtMyvIjRNEcefr/32dsGYkothGRFA=;
        b=w7IVDDWBE0Dwn2JBBMPJ9n3/UTAf8VwZ0jsW/M9HOhmUvIAkPQSwgJ24VmjDIm577r
         E4Hq4jRJiFQR79/cUmx5aaBcdHDMvlMr3pL/YQpJWlML6EnCuVbc9otDivy1SoedNt0g
         E4XxsEHhQ+0HubUsWt8S9lj+peB5AEYnIEmVocFNTOBjaiBrBATVjWlE/Mux3gKgpYg1
         JlRjjqsahNvTWfHA/2ZUq/0jVOFzx1GFx7PhE/+9sSmhaweJisgKGi6dQvloNhC/hLLK
         2EHRVU+F3IunbWS147uBC1eR5kyiOuSFz7Ej8JQEKCzMX8frd7s1IIGmuJvfdt9C3aYk
         jXlg==
X-Gm-Message-State: AFq9FYKknla5pgq8HAeMdGjghgzoxtpWnmTVRLqt5mytozq5ghPIy5H8
	3eDOhUTEwLxumEjEMw85eNW5h5WzlAxEZLOcSNttEYmIbhi6ATNEahj+DkwXeqBh
X-Gm-Gg: AYBFou1ZM7+oY48YAjCf2uplEJgkWoh35nujGt0swDWL6det/d6iBS98Wv/EmIS7jYM
	zAKIoXo4BU2OAMKwX/6aUsQfcm9G4sHJOkAunfcQLxUQMJMyGzR4JnlrW7QP9vNLFoxy8Ugjq9N
	sXbylLfFGTwVTMoKgNMwf7vleVBz4VYYcjWzKFG83n7FuoF6H73eq7vwtRH9WtoGRBeYgHpg6Uu
	Bp9REoocdKV2+bmGLR14BRqsweau/hSL10S2z6tVC5wrqcsgUYwXtFrQAwdYzfBLbeymuy0C3bm
	0NMHOkXJ9W44/7OkjhVw1scEdg+KuwUyrJxDVcAOzwUpguz5DE5IhGOlh+fIhle5JnfdTeeOaVP
	OUua4/6oHdXwgR059e+MsU32We8yHs0iPx9gt9Acna7VAv8juxlKBJ6UW58+IuE/MAt7ilDGc+1
	VjJEPj+a0YzohPYEv21BWutZxaZGbIgVTsZubBjehUQPFvnyCXEhH/CnLmqlAcr151xu899f0+I
	+dXEw5tdw8nS1gQs1/XWZl0WA9dqePKppGwb3j5/J2sBwKsVKlozNTh2xhGnzlodPqQ1lEcMMXJ
	5bYqfBD8atvDOWC0l/GEM3prYq15pdClpYM=
X-Received: by 2002:a05:600c:6088:b0:4a0:1e9f:64f6 with SMTP id 5b1f17b1804b1-4a35aae2effmr55705765e9.0.1792912846479;
        Sun, 25 Oct 2026 00:20:46 -0700 (PDT)
Return-Path: <gael.portay@gmail.com>
Received: from localhost ([2a01:e0a:1169:72f0:95de:85db:2666:6a8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ae28sm107189135e9.2.2026.10.25.00.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 00:20:45 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 08:20:44 +0100
Message-Id: <DMDQK6AYRSFM.16ZOLDEKE83MC@gmail.com>
Cc: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay+rtone@gmail.com>
Subject: Re: [yocto-patches] [psplash][PATCH 1/2] Add configure flags to set
 progression bar size
From: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@gmail.com>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.17.0
References: <1879D2EA94BEE1A5.1516663@lists.yoctoproject.org>
In-Reply-To: <1879D2EA94BEE1A5.1516663@lists.yoctoproject.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 25 Oct 2026 07:20:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5152

Dear Maintainers,

Any chance you could take a quick look at that change?

Kind Regards,
Ga=C3=ABl

On Thu Nov 20, 2025 at 10:03 PM CET, Ga=C3=ABl PORTAY via lists.yoctoprojec=
t.org wrote:
> Added --progress-bar-border-size configure option to set progress bar
> border size without patching the code. Default behaviour is to show a
> progress bar with a 4-pixel border size.
>
> Signed-off-by: Ga=C3=ABl PORTAY <gael.portay+rtone@gmail.com>
> ---
>  configure.ac     |  8 ++++++++
>  psplash-config.h |  5 +++++
>  psplash.c        | 10 +++++-----
>  3 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 110ce32..a64990a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -45,6 +45,14 @@ AS_IF([test "x$enable_progress_bar" =3D "xno"], [
>      EXTRA_GCC_FLAGS=3D"$EXTRA_GCC_FLAGS -DPSPLASH_DISABLE_PROGRESS_BAR"
>  ])
> =20
> +AC_ARG_WITH([progress-bar-border-size],
> +    AS_HELP_STRING([--with-progress-bar-border-size=3DSIZE], [Set progre=
ss bar border size (default is 4 pixel)]),
> +    [with_progress_bar_border_size=3D$withval],
> +    [with_progress_bar_border_size=3D4])
> +AS_IF([test "x$with_progress_bar_border_size" !=3D "xyes"], [
> +    EXTRA_GCC_FLAGS=3D"$EXTRA_GCC_FLAGS -DPSPLASH_PROGRESS_BAR_BORDER_SI=
ZE=3D$with_progress_bar_border_size"
> +])
> +
>  AC_ARG_ENABLE([img-fullscreen],
>      AS_HELP_STRING([--enable-img-fullscreen], [Enable the logo image in =
fullscreen mode)]),
>      [enable_img_fullscreen=3D$enableval],
> diff --git a/psplash-config.h b/psplash-config.h
> index eb90ef3..c7fff81 100644
> --- a/psplash-config.h
> +++ b/psplash-config.h
> @@ -26,6 +26,11 @@
>  #define PSPLASH_SHOW_PROGRESS_BAR 1
>  #endif
> =20
> +/* Size of the progress bar */
> +#ifndef PSPLASH_PROGRESS_BAR_BORDER_SIZE
> +#define PSPLASH_PROGRESS_BAR_BORDER_SIZE 4
> +#endif
> +
>  /* Position of the image split from top edge, numerator of fraction */
>  #define PSPLASH_IMG_SPLIT_NUMERATOR 5
> =20
> diff --git a/psplash.c b/psplash.c
> index 261dd1c..fbd51d0 100644
> --- a/psplash.c
> +++ b/psplash.c
> @@ -67,11 +67,11 @@ psplash_draw_progress (PSplashFB *fb, int value)
>  {
>    int x, y, width, height, barwidth;
> =20
> -  /* 4 pix border */
> -  x      =3D ((fb->width  - BAR_IMG_WIDTH)/2) + 4 ;
> -  y      =3D SPLIT_LINE_POS(fb) + 4;
> -  width  =3D BAR_IMG_WIDTH - 8;=20
> -  height =3D BAR_IMG_HEIGHT - 8;
> +  /* n pix border */
> +  x      =3D ((fb->width  - BAR_IMG_WIDTH)/2) + PSPLASH_PROGRESS_BAR_BOR=
DER_SIZE;
> +  y      =3D SPLIT_LINE_POS(fb) + PSPLASH_PROGRESS_BAR_BORDER_SIZE;
> +  width  =3D BAR_IMG_WIDTH - 2 * PSPLASH_PROGRESS_BAR_BORDER_SIZE;
> +  height =3D BAR_IMG_HEIGHT - 2 * PSPLASH_PROGRESS_BAR_BORDER_SIZE;
> =20
>    if (value > 0)
>      {

