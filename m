Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19225.1792912938482188639
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 25 Oct 2026 00:22:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=FK6znH35;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: gael.portay@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a599e9110eso410575e9.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 25 Oct 2026 00:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792912936; x=1793517736; darn=lists.yoctoproject.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H7kt+M6E2A25imSMkAEfGuZoT59RiMWaBfuIpbeec6Q=;
        b=FK6znH35nHTO+PbYhdm/w7WlsiHkuYxZsEeJPyEm8X8CYelkL017irzbZfMkS/Irpr
         0ijvUZKBabOvnEr9LpM37WWjrjVT+J+BQuUId195N5ZqlbifnK5LMYgMgPj3fB3FtCUq
         +KvZ5Zi20Mnc1rHH7RBjQ5McXI3h3uEG7TNtiesDPhI3Xf7zELusSEIije9/4oEWSVQk
         mpzsEgxJB6yH/PR3ClHTXmlX3nAWeWyRMDzFrrMtHgj1N8wCgQUmjUo2bCJBhuvXym0r
         7lTgyAOieqTJ2go1xeKMmhhboV8lAGnDezJn+7losb3dYGzKn+MWwOkN2c6RYqUcSa2k
         Wkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792912936; x=1793517736;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7kt+M6E2A25imSMkAEfGuZoT59RiMWaBfuIpbeec6Q=;
        b=d9TvhD9rSgG5npM9f2TPGKbtLcsKxK/HidiYNWqSxR5Qn8zXKFxBq96dDK8YVvSgcY
         UVjs0id4yAdLtt97BR54wAAwTtEKdkPoi5+NB/Tf/kpr6DsOX3Hv4nMfpbrAVKiD8xuc
         nEiG3mzCtAaYa+oaGNjZMYtMBacF+xd9YaQ5SNf3cgmTfOhT+2NuPERjkDCofZXsjc+r
         lrI3Jstnm/l3M9aazDJShxzMb2JsxzMgYezj5qUF4w0IvRBrVGP5r1vIYOxalVlfgNOE
         TL1uTym/uhDOaNodBzIBrqJEIqLI+RGVQeunpozn4y8zoQ6xg0BsJkZmIWWkK6rVAtj9
         SH/Q==
X-Gm-Message-State: AFq9FYLUCsuTUOtWzHwf726zlbktgYdqCPDt7Xmt0Qf1uP7LnANDgH+0
	WALLysNttHp+9JPvI42TTMRoWSSKuvvLTWKuYcQbXgOI/yVFNumcpuZjNELJ+twI
X-Gm-Gg: AYBFou0XYPN2e0+ebO1U8q8UATlnB2bCUgv/yLAowQ7ISzkuNBH1qiDqALjVo+R54h5
	32gF3wHvN50fRrHRefOKqRRnd5HXJHwCUICsCH872QvYSGb7cN5Ed6Hbj86i41UUtskBQWSIjIu
	kBbYppURtmXFyiPYUcScPG6QgwSK9EHH07dRMS4ZfXTB+3kCQG6+dMrmnY23kUcNWc0T23WZ82f
	57BphTPU+Gfmx9OctZBn3zgpBiiKP1J+BFFBOIYEUo0Txtj8FFX28yUXjUhcRo8t3ROukbDSAvm
	GXUembtGAXvpJ7tzETwzHRdm1/d9a7rW04zjP2kgueO+6oHHVbhmBq6ku+JgGdnT5FWt4cALTBk
	m7vWwrNS/yThmpnvf4wGyRtYjg37imZwvwvTehnS2LfmJ3wA1fyt89CvQapfCAJrq7Xwo5j14TB
	csBTgkyzGOCIhdLyq+K9Zfyu04eDCa41hnmd8+staTsEjgm+Mpz4fs2tKpKBwAOs9KiBQQdajGF
	1gOl/3qFHhYQu9i2wCPYqJSYtNO99i/8O7kxotk4YHq+Zfnt5+ESHmx5m2ZCh1DPRLglUHVqipM
	oSNE5W+S4+esIA==
X-Received: by 2002:a05:600c:a114:b0:4a1:e015:6441 with SMTP id 5b1f17b1804b1-4a35aae2c99mr42525735e9.0.1792912936338;
        Sun, 25 Oct 2026 00:22:16 -0700 (PDT)
Return-Path: <gael.portay@gmail.com>
Received: from localhost ([2a01:e0a:1169:72f0:95de:85db:2666:6a8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d6f6fsm102598365e9.12.2026.10.25.00.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 00:22:15 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 08:22:14 +0100
Message-Id: <DMDQLBOHOO5R.C6T162UJUITR@gmail.com>
Subject: Re: [yocto-patches] [psplash][PATCH 2/2] Add configure flags to set
 colors
From: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@gmail.com>
To: <yocto-patches@lists.yoctoproject.org>
Cc: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay+rtone@gmail.com>
X-Mailer: aerc 0.17.0
References: <20251120210348.88193-1-gael.portay+rtone@gmail.com>
 <1879D2EAB5EE21E5.1334697@lists.yoctoproject.org>
In-Reply-To: <1879D2EAB5EE21E5.1334697@lists.yoctoproject.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 25 Oct 2026 07:22:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5153

Dear Maintainers,

I am just bumping this for visibility, I am sorry if this is not
appropriate.

Kind Regards,
Ga=C3=ABl

On Thu Nov 20, 2025 at 10:03 PM CET, Ga=C3=ABl PORTAY via lists.yoctoprojec=
t.org wrote:
> Added --with-text-color, --with-background-color, --with-bar-color, and
> --with-bar-background-color configure options to set colors without
> patching the code. Default colors are 0x6d,0x6d,0x70 for any text output
> and bar indicator, and 0xec,0xec,0xe1 for overall background.
>
> Signed-off-by: Ga=C3=ABl PORTAY <gael.portay+rtone@gmail.com>
> ---
>  configure.ac     | 32 ++++++++++++++++++++++++++++++++
>  psplash-colors.h |  8 ++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/configure.ac b/configure.ac
> index a64990a..d01afce 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -53,6 +53,38 @@ AS_IF([test "x$with_progress_bar_border_size" !=3D "xy=
es"], [
>      EXTRA_GCC_FLAGS=3D"$EXTRA_GCC_FLAGS -DPSPLASH_PROGRESS_BAR_BORDER_SI=
ZE=3D$with_progress_bar_border_size"
>  ])
> =20
> +AC_ARG_WITH([text-color],
> +    AS_HELP_STRING([--with-text-color=3DRED,GREEN,BLUE], [Set color of a=
ny text output (default is 0x6d,0x6d,0x70)]),
> +    [with_text_color=3D$withval],
> +    [with_text_color=3D0x6d,0x6d,0x70])
> +AS_IF([test "x$with_text_color" !=3D "xyes"], [
> +    EXTRA_GCC_FLAGS=3D"$EXTRA_GCC_FLAGS -DPSPLASH_TEXT_COLOR=3D$with_tex=
t_color"
> +])
> +
> +AC_ARG_WITH([background-color],
> +    AS_HELP_STRING([--with-background-color=3DRED,GREEN,BLUE], [Set colo=
r of overall background (default is 0xec,0xec,0xe1)]),
> +    [with_background_color=3D$withval],
> +    [with_background_color=3D0xec,0xec,0xe1])
> +AS_IF([test "x$with_background_color" !=3D "xyes"], [
> +    EXTRA_GCC_FLAGS=3D"$EXTRA_GCC_FLAGS -DPSPLASH_BACKGROUND_COLOR=3D$wi=
th_background_color"
> +])
> +
> +AC_ARG_WITH([bar-color],
> +    AS_HELP_STRING([--with-bar-color=3DRED,GREEN,BLUE], [Set color of th=
e progress bar indicator (default is 0x6d,0x6d,0x70)]),
> +    [with_bar_color=3D$withval],
> +    [with_bar_color=3D0x6d,0x6d,0x70])
> +AS_IF([test "x$with_bar_color" !=3D "xyes"], [
> +    EXTRA_GCC_FLAGS=3D"$EXTRA_GCC_FLAGS -DPSPLASH_BAR_COLOR=3D$with_bar_=
color"
> +])
> +
> +AC_ARG_WITH([bar-background-color],
> +    AS_HELP_STRING([--with-bar-background-color=3DRED,GREEN,BLUE], [Set =
color of the progress bar background (default is 0xec,0xec,0xe1)]),
> +    [with_bar_background_color=3D$withval],
> +    [with_bar_background_color=3D0xec,0xec,0xe1])
> +AS_IF([test "x$with_bar_background_color" !=3D "xyes"], [
> +    EXTRA_GCC_FLAGS=3D"$EXTRA_GCC_FLAGS -DPSPLASH_BAR_BACKGROUND_COLOR=
=3D$with_bar_background_color"
> +])
> +
>  AC_ARG_ENABLE([img-fullscreen],
>      AS_HELP_STRING([--enable-img-fullscreen], [Enable the logo image in =
fullscreen mode)]),
>      [enable_img_fullscreen=3D$enableval],
> diff --git a/psplash-colors.h b/psplash-colors.h
> index 82a9893..d6d19af 100644
> --- a/psplash-colors.h
> +++ b/psplash-colors.h
> @@ -12,15 +12,23 @@
>  #define _HAVE_PSPLASH_COLORS_H
> =20
>  /* This is the overall background color */
> +#ifndef PSPLASH_BACKGROUND_COLOR
>  #define PSPLASH_BACKGROUND_COLOR 0xec,0xec,0xe1
> +#endif
> =20
>  /* This is the color of any text output */
> +#ifndef PSPLASH_TEXT_COLOR
>  #define PSPLASH_TEXT_COLOR 0x6d,0x6d,0x70
> +#endif
> =20
>  /* This is the color of the progress bar indicator */
> +#ifdef PSPLASH_BAR_COLOR
>  #define PSPLASH_BAR_COLOR 0x6d,0x6d,0x70
> +#endif
> =20
>  /* This is the color of the progress bar background */
> +#ifdef PSPLASH_BAR_BACKGROUND_COLOR
>  #define PSPLASH_BAR_BACKGROUND_COLOR 0xec,0xec,0xe1
> +#endif
> =20
>  #endif

