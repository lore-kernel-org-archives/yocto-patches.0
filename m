Return-Path: <rtrivedi@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9819FF8875
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 00:59:22 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10475.1777510762364636155
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 17:59:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=MsmOFfhl;
 spf=pass (domain: snapchat.com, ip: 209.85.210.181, mailfrom: rtrivedi@snapchat.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-834da62e52dso171887b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 17:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777510761; cv=none;
        d=google.com; s=arc-20240605;
        b=deW3Y1AsaVSfIFlIC/U0lnfdz95qM35frVN4bGRvRKFX+/gEnPnp0GA7w2VhvfRQDr
         qgD/EuWzmNv5n4To2BZXdBB3XAnEAgGt7aQtsvidFDmIuJ9PIct4HdJGDRH3JFb44QaN
         JsgzDNoi7CjgdwJ+AwOyPboADcCiBlXVyFdmzw5sKLAE8+ga8Wg+cLwC0Q3y3sAdpbka
         PBiqsMLxET9Cj+ppVQ7iS3EMForAZn3oxTFQ40o1tRaT3rYpymzbaOWovFcYdEryrS2x
         xCxMfSpBrzKdubpeQxVPZdZQ+jszX4z22Y1dfh7XyY03aSus3GdFBXjR6LjRKi2cl84C
         bVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D0xagz1DP/TqqaKlsBhjxzmEmhMhAngZjxt0AAaPe/c=;
        fh=/Hpk4tTGaXpdv9l1MBS8cYp4DanNyj1iy3fyB8qCiNw=;
        b=L7jQoUivghFgJHMjcN2xEnZtzDVWQh0j+cFU416/LGqYQaH0gq8O0KY+PCB3D4vtYh
         uLPJ0vmVFtKDCkBgKedhbrI8yQcWaqF/LJbCFhMrA13CCOUG4hjTnZYC5hpvpC1hd898
         SG4PWEQCIWyD/7EvzCwEZcbs+sCqu0VYPyA1PFmX4nBBwk82INjO9HUw8s9lF63QHiir
         tzGY3J1xRP9uEpdUlpPUz6qmxt4Hui2/12DOivnpdGISq8XiF1AVbYLYY7scVx+c1mV9
         2vPwo6sj9pqWI7kZdaicAidErunwZ30l/V0wamoessSPDQnoDkala/PfLcQW27kaKL8J
         UUOw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1777510761; x=1778115561; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0xagz1DP/TqqaKlsBhjxzmEmhMhAngZjxt0AAaPe/c=;
        b=MsmOFfhl30TJOnGCEA8xwfUuV4uF8BMkNxDLuFPiI753HbEcJzZRxIo8J8nWXzh1g0
         wcd9R+hz/GcjTo49weaSjp9OPYrPw2mdFg/2wjTvO5K7IsewhHXNz8Iiy0Hi/Ob4LaYw
         U3fUVgmVfCtKbnTrcS63fkIV1+kntEEdKBrP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777510761; x=1778115561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D0xagz1DP/TqqaKlsBhjxzmEmhMhAngZjxt0AAaPe/c=;
        b=kdJ4VqQkW8YrBTQQ0kik9PzpKdUjHjmLb2a8vAFqt6+d0F3WlRrF/JjiADQ4OubqQB
         OXSwB+JZ2K/XWF/aJyknui/UxNN8rd1pBNgDVoljvN6bOIXNmlPlspkmsAqbQiHJNkJc
         eEs/4kxFNZMcuxF/kIPmA4jXc3PN7tdpKCq2aYUQ5VwJRZRHNuuuBYZ4Q3GVMMqcefr3
         hLaFozUA1oy+o4sXzsLWsqeMf0K/RkVtUrJMAq34ryvBBHVuJHiOO+y1kgY/prL4Iih3
         7858HxKcYs3aMEwT5AdFI5UGoCf6pkvwnjM7fSs7Ch4CBHMfNZh8l21yZW/iOopX3LOM
         idsg==
X-Gm-Message-State: AOJu0Yz5wdUQLJyXsLSOBePi2W+9tu5P4+J7jE4u3sibDVyYRddDtNVz
	ZBYpMK995aNSCZK9BohN17aSO4K0MwK//Zm70jTNV4Ni+CCM/T3EpSpMiYdc4wdcU7a5AOpM065
	bIhAxAlMCNQFbaTqzVFxN1GI1Ozw4WpZ5rjK/+uOuXEBujlSbHPLaONTdzg==
X-Gm-Gg: AeBDievSSbkk3qP0sT4s7GVhekB6uiIXQRSRkFr6wP6oXvDdteP7zmnCz0dc5bzlScl
	j2mVtUyrsC1yZ/nWjs+wmWtSjTIlmPaXcNiscklMFNSL77nXq3svOkeMo/7bbvORBTeL+hNtUJ6
	qkvRWb8GDlUQOPtjdNeVJJn3KCQn3bJXPUaXwtMjMVNyb3YP21vhAra0/I2nea7C0bdMnSRvrzX
	wwq2jp3xm5LSjIk8S0nROz+hJAvcGpJuZRFvBwt+2dkevE+qlNX5JAvOgtO61ptgTKYcsAlr6Mn
	DUc+ahw+HfEw4/Py8LdPxCcICA==
X-Received: by 2002:a05:6a00:a90d:b0:82f:a085:c46b with SMTP id
 d2e1a72fcca58-834fdc96843mr956662b3a.47.1777510761124; Wed, 29 Apr 2026
 17:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <CACoT=N6UZ9xULwNnNOGqmL9pMrhR66dH=cxbb4fj=u836eXQXA@mail.gmail.com>
In-Reply-To: <CACoT=N6UZ9xULwNnNOGqmL9pMrhR66dH=cxbb4fj=u836eXQXA@mail.gmail.com>
From: Rahul Trivedi <rtrivedi@snap.com>
Date: Wed, 29 Apr 2026 17:59:10 -0700
X-Gm-Features: AVHnY4I9HnhEekoGVImvRM-nVRj6a0HRrDK6IU0rgNskSJG1-hKyjGhxsEoE-Sc
Message-ID: <CACoT=N4dJyopCtqmz1gmGm4-rdb4WZVrYPO_kXVTjYZbfNZ8fg@mail.gmail.com>
Subject: [meta-mingw] [PATCH 2/2] binutils: disable gprofng on mingw32 host
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Apr 2026 00:59:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3891

gprofng is enabled by default in binutils 2.42 but does not build for an

x86_64-w64-mingw32 host: its sources rely on POSIX-only constructs

(libdl/dlopen, mmap with MAP_PRIVATE on /proc-style fds, sigaction-based

profiler signals) that mingw-w64 does not provide.


Pass --disable-gprofng via EXTRA_OECONF for mingw32 host builds so

binutils configures and compiles cleanly.


Signed-off-by: Rahul Trivedi <rtrivedi@snap.com>

---

 recipes-devtools/binutils/binutils_%.bbappend | 2 ++

 1 file changed, 2 insertions(+)


diff --git a/recipes-devtools/binutils/binutils_%.bbappend
b/recipes-devtools/binutils/binutils_%.bbappend

index 401bace..76a8c6f 100644

--- a/recipes-devtools/binutils/binutils_%.bbappend

+++ b/recipes-devtools/binutils/binutils_%.bbappend

@@ -3,3 +3,5 @@

 # in dlltool.c.  Push the POSIX minimum / NTFS per-component limit via the

 # compile flags instead of carrying a source patch.

 CFLAGS:append:mingw32 =3D " -DNAME_MAX=3D255"

+

+EXTRA_OECONF:append:mingw32 =3D " --disable-gprofng"

--=20

2.51.0



On Wed, Apr 29, 2026 at 5:56=E2=80=AFPM Rahul Trivedi <rtrivedi@snap.com> w=
rote:
>
> mingw-w64's <limits.h> does not define NAME_MAX, which Poky's backport
>
> of upstream binutils commit d0285cdf58ad (carried as
>
> 0017-dlltool-file-name-too-long.patch in scarthgap) uses unconditionally
>
> in dlltool.c.  As a result, building binutils-cross-canadian for an
>
> x86_64-w64-mingw32 host fails with:
>
>
>     dlltool.c: error: 'NAME_MAX' undeclared
>
>
> Define NAME_MAX via CFLAGS at the POSIX minimum and NTFS per-component
>
> limit (255) for mingw32 host builds, which avoids carrying a source
>
> patch in meta-mingw.
>
>
> Signed-off-by: Rahul Trivedi <rtrivedi@snap.com>
>
> ---
>
>  recipes-devtools/binutils/binutils_%.bbappend | 5 +++++
>
>  1 file changed, 5 insertions(+)
>
>  create mode 100644 recipes-devtools/binutils/binutils_%.bbappend
>
>
> diff --git a/recipes-devtools/binutils/binutils_%.bbappend
> b/recipes-devtools/binutils/binutils_%.bbappend
>
> new file mode 100644
>
> index 0000000..401bace
>
> --- /dev/null
>
> +++ b/recipes-devtools/binutils/binutils_%.bbappend
>
> @@ -0,0 +1,5 @@
>
> +# mingw-w64 <limits.h> doesn't define NAME_MAX, which Poky's backport of
>
> +# upstream commit d0285cdf58ad (0017-dlltool-file-name-too-long.patch) u=
ses
>
> +# in dlltool.c.  Push the POSIX minimum / NTFS per-component limit via t=
he
>
> +# compile flags instead of carrying a source patch.
>
> +CFLAGS:append:mingw32 =3D " -DNAME_MAX=3D255"
>
> --
>
> 2.51.0

