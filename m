Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA352F3D333
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 17:00:23 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.49082.1772730017338789114
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Mar 2026 09:00:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lO2RNIc5;
 spf=pass (domain: gmail.com, ip: 209.85.208.171, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-389fa5e55e2so137533861fa.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Mar 2026 09:00:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772730015; cv=none;
        d=google.com; s=arc-20240605;
        b=XWWdoLmBEIuzam3+F+zuWd5124HSj759LL/Boe61unLSpHMDuhQ4jx+R42aL/xtnta
         QweNJ2gLKP21+epIM4NTkG0TL1AEx2q5cEcYb//nusrXOG7Nkg2Gr64JFqFkeq8I8V/r
         VwEUz+zGuidmXqa1iUeiEd2tLhhXQxeF774VFpCXlSXpgN3I3DgWrwKcnRvjP4wJXheD
         8Pm4VrK4EtfMcLxogYZx/gDyyUEUHbzSafNXORDvMsG1ywiJhOnrD41gsuFs72huKAtH
         URExD2J/X5/fKdJGkeV8orpVej2vrB9NEmTZw9qf6CsYSlrjmzM4LzIzc5daXQbbgOsw
         pG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9XVpuemfcrQy+SA1NVwr4Ta9o68+ftheP30uKJjEVCc=;
        fh=xcD3OP+wsrc47z50P5N115xVWfhDG4yi2zwkSmt+KAU=;
        b=PhybmjRulx7j5HjIQ75WUCGBHGOnR5n5Fij8u3okQ0Qji9Q1yU6DUzIYqjr2GkxLBG
         +WfDkB3HO+1dFbcRtZbJaoDmB38TSqcj/Uyn2I8PY6uzYR4uoTfcsadqWPJQl+DNZjx6
         CAXgljYGWE8svXThOs/KJN3ZdhREYbSpbgYD1v0SW59jHiqZQ4FQRqU6bJcLonaCfbjz
         yfTkbC54AEUW+9/v6uMa57XmPCxHb6s41P6g2fzrP2UNeJ04OtTSzQvJv+0cKCepH3oc
         9UY20sd4NTrGd155YTFo5YEFJIur8FYgC63QMmpkrOoqrpAejdtvZPRWp95oHzX09szP
         iqqQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772730015; x=1773334815; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XVpuemfcrQy+SA1NVwr4Ta9o68+ftheP30uKJjEVCc=;
        b=lO2RNIc5HwsLbgGS5eYctFBXxuocVCPl0Abq+Ivx4U0zdbbzvwHkWruSmj4O589ksc
         8jcn0ja933q6XKFmfWf2+DWJTy7wK//8gCZ5G4DVxcs+DOuGx1jyYSzgaWmILD/YM+hK
         7HdBg5M7GUxNxBQQoRqqF2I88Az0MqXqRJf+lROoQeH+T4cSm00qiKnOT3uLzEqKL+P0
         xdqNcRcp52sEIUSZT/FqUBWEzYod5b3GAZ5EJKcMCADWNYfwxysNa/CPpeNRAZDzEt1O
         VEzvOnAkuq0+gMpQoHtiFpg9u5EsTI13/CoLo50mxRts4KiEuJvikjkP3yVxdjwZoDfU
         xB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730015; x=1773334815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XVpuemfcrQy+SA1NVwr4Ta9o68+ftheP30uKJjEVCc=;
        b=U+FVInJ+4lFvMgKQvGQYhx+ywlNeVlwIxG385Xdkm3Ca3T5oJwS1opBnqQETyNBgLU
         nPRkrmga4J2rssEPqy1tKSy5yKom/1uhxluEKBk45x2Ny2lKEh9oKPHwmZZe1/QWHFzq
         HnLdgn7091BCxlnrqLDuiJ21Gp3DhPHWy4YH2WxOHiO2V1jAW2oZe96UKIMcPRAQKJQx
         D6YuWS+NOoARqoeAg6zIaVHgXlK3I6+TNvrc8CWqLdUOv7tSNbqrmKJ3RjLd7hgovXDo
         2y2wlbuOw/KgtIPteO2Bq/yyV1YNG3pULMoEXvYn9QJZYnnVzZl6ps58YkiHTWMHCXVC
         VwjA==
X-Gm-Message-State: AOJu0YxyaJ84i9PY+jBxK3e9mzcmmYMuN6Il1UErcPFVL+116AfSnlmW
	3JeyyRiCpT96pz1DLVvWiZRDroIiOGw7zllEcQX8MUvkEBil6mMMH/0dVkwQz7hJ0JMdyG9NqaB
	kQk5B5Aus75kLsdd1klpSQM9o6edJ6z6WmKLv
X-Gm-Gg: ATEYQzzrA3ZHVjQqTDNEdQQaQajsq2UXzlw39WVFPBpc4RUuqMyMhXLqRcpFEgdC84N
	q04DVCf2/TZ1dsCj9DdhwH1+NxY6SSem4Sl6t/Xo1tmTUHjhMG8ZNfyUq5pCChivG66P5uE8Ees
	v0TM4wV+rlX2zKeXFS3VpLzO0O4txxum/b8KVchPLZMgOvZeznfIJLyvsyF451LJ2QaXjJJ95fx
	thaYkPFShsiSXkEbJjCcQ3tpu/Azvj7tOHBMa8vmEklYC475qAHZRkEycpT2TlVNClbjGjWSdSe
	mqUelX7zvg==
X-Received: by 2002:a05:6512:3093:b0:5a1:3134:923f with SMTP id
 2adb3069b0e04-5a131349301mr1023264e87.40.1772730014614; Thu, 05 Mar 2026
 09:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20260113231729.2698563-1-richard.purdie@linuxfoundation.org> <20260113231729.2698563-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20260113231729.2698563-2-richard.purdie@linuxfoundation.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 5 Mar 2026 18:00:00 +0100
X-Gm-Features: AaiRm50F3_ApHB3klTbUscc0GxkZiTM8hRO3T5WmRnrAnMItXn1qvpItdgPSycg
Message-ID: <CA+chaQd5DzfJb7WKZVwZbGUqK_U6zttpNwpG7zm41LM_wbv_Hw@mail.gmail.com>
Subject: Re: [yocto-patches] [pseudo] [PATCH 2/3] ports/linux/openat2: Add
 dummy wrapper
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, mark.hatle@kernel.crashing.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Mar 2026 17:00:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3339

I've recently upgraded my Gentoo to have glibc-2.43 and I'm working on
build failures caused by that, I'll send fixed for m-native,
libunistring-native, dtc-native, systemd. Now gettext and
pseudo-native remain (when building core-image-minimal).

The pseudo-native is a bit strange:
https://errors.yoctoproject.org/Errors/Details/903979/

In file included from pseudo_wrappers.c:300:
pseudo_wrapfuncs.c: At top level:
pseudo_wrapfuncs.c:11537:1: error: conflicting types for =E2=80=98openat2=
=E2=80=99;
have =E2=80=98int(int,  const char *, struct open_how *, size_t)=E2=80=99 {=
aka
=E2=80=98int(int,  const char *, struct open_how *, long unsigned int)=E2=
=80=99}
11537 | openat2(int dirfd, const char *path, struct open_how *how,
size_t size) {
      | ^~~~~~~
In file included from /usr/include/bits/fcntl-linux.h:492,
                 from /usr/include/bits/fcntl.h:61,
                 from /usr/include/fcntl.h:35,
                 from pseudo_wrappers.c:23:
/usr/include/bits/fcntl-linux-fortify.h:36:1: note: previous
definition of =E2=80=98openat2=E2=80=99 with type =E2=80=98int(int,  const =
char *, const
struct open_how *, long unsigned int)=E2=80=99
   36 | openat2 (int __dfd, const char *__filename, const struct
open_how *__how,
      | ^~~~~~~
make: *** [Makefile:162: pseudo_wrappers.o] Error 1

If I use const for struct open_how to match:
https://sourceware.org/cgit/glibc/commit/?id=3D0f0a5cd338998f4b603f52f3ce21=
63df0db7b814
then it builds fine, but I assume you had some reason not to use const
(as this glibc commit existed before pseudo change it seems?).

I'll send the update for ports/linux/openat2/guts/openat2.c
ports/linux/openat2/wrapfuncs.in if it makes sense to use const here.

Regards,



On Wed, Jan 14, 2026 at 12:17=E2=80=AFAM Richard Purdie via
lists.yoctoproject.org
<richard.purdie=3Dlinuxfoundation.org@lists.yoctoproject.org> wrote:
>
> From: "mark.hatle" <mark.hatle@kernel.crashing.org>
>
> For now fail politely, most callers have fallback behavior.
>
> Signed-off-by: mark.hatle <mark.hatle@kernel.crashing.org>
> ---
>  makewrappers                       |  1 +
>  ports/linux/openat2/guts/openat2.c | 23 +++++++++++++++++++++++
>  ports/linux/openat2/portdefs.h     | 13 +++++++++++++
>  ports/linux/openat2/wrapfuncs.in   |  1 +
>  ports/linux/subports               |  2 ++
>  5 files changed, 40 insertions(+)
>  create mode 100644 ports/linux/openat2/guts/openat2.c
>  create mode 100644 ports/linux/openat2/portdefs.h
>  create mode 100644 ports/linux/openat2/wrapfuncs.in
>
> diff --git a/makewrappers b/makewrappers
> index 67c73e2..0d73cc1 100755
> --- a/makewrappers
> +++ b/makewrappers
> @@ -209,6 +209,7 @@ typedata =3D {
>    'ssize_t': { 'format': '%ld', 'value': '(long) rc' },
>    'struct group *': { 'format': '%p', 'value': '(void *) rc' },
>    'struct passwd *': { 'format': '%p', 'value': '(void *) rc' },
> +  'struct open_how *': { 'format': '%p', 'value': '(void *) rc' },
>    'uid_t': { 'format': '%ld', 'value': ' (long) rc' },
>    'void *': { 'format': '%p', 'value': 'rc' },
>    'void': { 'format': 'void%s', 'value': '""' },
> diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/gut=
s/openat2.c
> new file mode 100644
> index 0000000..da01b31
> --- /dev/null
> +++ b/ports/linux/openat2/guts/openat2.c
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (c) 2026 Mark Hatle <mark.hatle@amd.com>; see
> + * guts/COPYRIGHT for information.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-only
> + *
> + * int openat2(int dirfd, const char *path, struct open_how *how, size_t=
 size)
> + *     int rc =3D -1;
> + */
> +
> +       (void) dirfd;
> +       (void) path;
> +       (void) how;
> +       (void) size;
> +       /* for now, let's try just failing out hard, and hope things retr=
y with a
> +        * different syscall.
> +        */
> +       errno =3D ENOSYS;
> +       rc =3D -1;
> +
> +/*     return rc;
> + * }
> + */
> diff --git a/ports/linux/openat2/portdefs.h b/ports/linux/openat2/portdef=
s.h
> new file mode 100644
> index 0000000..8e4e33e
> --- /dev/null
> +++ b/ports/linux/openat2/portdefs.h
> @@ -0,0 +1,13 @@
> +/*
> + * SPDX-License-Identifier: LGPL-2.1-only
> + *
> + */
> +#if __has_include (<linux/openat2.h>)
> +# include <linux/openat2.h>
> +#else
> +  struct open_how {
> +        __u64 flags;
> +        __u64 mode;
> +        __u64 resolve;
> +  };
> +#endif
> diff --git a/ports/linux/openat2/wrapfuncs.in b/ports/linux/openat2/wrapf=
uncs.in
> new file mode 100644
> index 0000000..96ae8a7
> --- /dev/null
> +++ b/ports/linux/openat2/wrapfuncs.in
> @@ -0,0 +1 @@
> +int openat2(int dirfd, const char *path, struct open_how *how, size_t si=
ze);
> diff --git a/ports/linux/subports b/ports/linux/subports
> index 099ea59..b202c27 100755
> --- a/ports/linux/subports
> +++ b/ports/linux/subports
> @@ -70,3 +70,5 @@ else
>  fi
>  rm -f dummy.c dummy.o
>
> +# For openat2, similar to statx, we need to be able to build on systems =
without that support.
> +echo "linux/openat2"
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2952): https://lists.yoctoproject.org/g/yocto-patches=
/message/2952
> Mute This Topic: https://lists.yoctoproject.org/mt/117253067/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

