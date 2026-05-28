Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119C4CD5BD5
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 21:20:36 +0000 (UTC)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20992.1780003234350630451
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 May 2026 14:20:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ot8CRfsF;
 spf=pass (domain: gmail.com, ip: 74.125.224.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65db820588aso10888867d50.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 14:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780003233; cv=none;
        d=google.com; s=arc-20240605;
        b=hEQDWrGX41RD9b4go9nLItwIRA5MHoEeUcaygjBYReh4wzZQbr9iy/TLnQmjoLVv8/
         WbCzJOysOfqT6GkHfHZCHnqYGEH73jE5jIuC0nPC+fQtrO/94rC+qPuw6DAdnhBagW/Q
         CozJVQQc4XZLxVUWaVU7J0o3o0OF8qnR2vL9FmCHU7SxZGmyAInWgGDLla8AJ/SlEYHm
         UEUY3oaYoh0am9k0bQYpldKmPMYLZ7ZedYwL/AT6veWrdKQxzNdnW+7H9geGEYN1oPA0
         V9f8If7Fado0oIO0PboGfxArBXyoJpx+l9jO5AFiTX/fmJhsVi2QNUitTcQFQE7m5E/e
         pIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JYSFCJS4wZXmG65win/reiKESUmCWUYXWpn07zg+D+k=;
        fh=Rok/qTQaDfcxzYG7DK6VlGf2ZoAWY26qHsxdzavlydQ=;
        b=MPGtXy9mG+p/qLvKdzZ6+TN8EUMJDo37SXw9F0lASntp9a8Bxl1CZZlewxHq0VrbLm
         +fc3mAYjtuc9XaeJKyFDR5UhYtuqRqkqb6EaDrbKWjo3iwqqINRf+nqbuzzHPF+qdlJL
         4cNLVoOhjxMkLBFkECNPlZEoqWV0sJ8DOPHuPTlDUqcSn37U8gyqnRUusBOWwRuV1URF
         UuB/mLMdCfWNiw/F4AI8PeEYteABZ1U1EiYmRbkWvyFJqrodns6mdfeDr8Y25M6f88Qc
         bkzCR+9e2/YPj+4FjIUkBHyB3FlLOK0i0VIrp/T/vzW3SlNG4cK075c9/QLs+a7CV7zn
         LkUA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003233; x=1780608033; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYSFCJS4wZXmG65win/reiKESUmCWUYXWpn07zg+D+k=;
        b=Ot8CRfsF7BsZadRYtZlRzNzUjO/c1RhoEVPdHREYwcbt3Bo3h9UMvEDVg/tycYKZov
         Mq4YrS9Uw8WKpE98k/33xOU1oB7+7VTduDr+WuMZvbw8MivA8bFGZ1g/62cCoMSKsYQ/
         RkekhcTScSRmfBUIRnT/up3nz17zU8xz8QsOY9skMhmSMiiAP1rwAQ8Quv6SL0x5clrK
         cqgRsHHLDUdwnZpqd0dMIy3ACxvLpBCRtwTmhD2V1+JVH+ZKbu34i12XnGXr5+2dRlAg
         BaVh+0bgbcbPLRU3xG9HFe2NLN0/6MBMfBZYjbaZJh6nyShd805t2lPvZ3af4otIbBkR
         Zeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003233; x=1780608033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYSFCJS4wZXmG65win/reiKESUmCWUYXWpn07zg+D+k=;
        b=XMCdjELzRisEhe61wxFyENcIX7Z3TjuETZevHk8NEDiZWcPHlwXq7AG86EDRY4zg73
         fjq8fqzCPja4JpwRZE5y3nLHA60V8GX4Nh4YbSW3RbGCHa3/PomGQE9A1fI2vOJaczkJ
         EXNoXdRE7ozf9ZwUIvuKeUpK2pKEXdgC0PGVzo/KN36YgX+NbMk1SNg3nUoF71092zJj
         3dJMSWsCNxMYpKTR6sjuRm7e1YTTv2uFq901xvMOdcKkkGSOGNxWTW9cMQghhYj4kNWJ
         31rAHMTsSfOM96nS08zTWc0WVppTpkktGF1oWywSA20fz03wvOuCanQ7GZR4LDyqwZFT
         y6Qw==
X-Gm-Message-State: AOJu0Yz7UtKebZ9PudE1ws3JdJ5NQbTni1WC1FwSk9aJ/5QXvVbjTd+L
	K7mIl22vcQhqChDDRvox1CcpceDZcc8WMab4YyDsNwhoR4lDP8i39BmWbIP/CjspOGTIS42rF33
	odEjQNi9N0shxJJEbFuZ08tBrD7rOQmA=
X-Gm-Gg: Acq92OFDGkQ4aMRnRfUdqDDfffxDEQyrWGnzddwT/mj/gTKFqOK3yVIPUvAB8SnBFRj
	UByVJHJVSWx8uwr4L1O+3CQkAcUSAYICKptaZ27IITti2GaRtpi4kvF/FOFJjNUMy0cbbtH8nT8
	qWH2Pt8/4ZJ/e7B4EqW0h4iTy3VSupFQC/cFxkNcKPFbxShKjwsCGVF/H4h9sYKTYB2ynstG6Ti
	+WY5JUQzjsY8w8hSgdHGr5vgbDtTVq7r79Rh4kMl4Eda6Rzb0xOpQroxgKg12+VyWXWCpZuG71p
	olXtVuBETe+CZnW3IhQ6sKn1QtDHsaYY
X-Received: by 2002:a53:d9cb:0:b0:65e:37bc:c759 with SMTP id
 956f58d0204a3-6604e8ab239mr413962d50.62.1780003233414; Thu, 28 May 2026
 14:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <CACoT=N6UZ9xULwNnNOGqmL9pMrhR66dH=cxbb4fj=u836eXQXA@mail.gmail.com>
In-Reply-To: <CACoT=N6UZ9xULwNnNOGqmL9pMrhR66dH=cxbb4fj=u836eXQXA@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 28 May 2026 15:20:22 -0600
X-Gm-Features: AVHnY4LmxCUUPKbxA5VSvLYcceoBd8mFZXdZe1mr10gQ2AsWG_ZKCuF0lSBuS0A
Message-ID: <CAJdd5GZJR1T2GpQLip6_pLeBqO-ZojGba6UWyXvvKszgG-kGfQ@mail.gmail.com>
Subject: Re: [meta-mingw] [PATCH 1/2] binutils: define NAME_MAX for mingw-w64
 host build
To: Rahul Trivedi <rtrivedi@snap.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 21:20:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4084

Rahul,

The newlines on this (and your other patches) look mangles; can you
correct that and re-send them?

On Wed, Apr 29, 2026 at 6:56=E2=80=AFPM Rahul Trivedi <rtrivedi@snap.com> w=
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

