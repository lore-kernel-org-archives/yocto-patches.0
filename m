Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5480EC44508
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 17:16:43 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16823.1769015799774147753
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 09:16:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A9UUMP8T;
 spf=pass (domain: gmail.com, ip: 209.85.167.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b9fee282dso6844499e87.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 09:16:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769015798; cv=none;
        d=google.com; s=arc-20240605;
        b=jKxk3YiyVYunQ3m9v6u6PvT0+gWC0Facs+LDMR6avCQeUb1UCX33mtSS8bJZaqeGrA
         g1yW5MYQSFhBAcHdY+8Thv1j4GNFE1g6JiD5nkX8+2ruaffvD2SbfzAlxvS2pLI1MQXu
         Ix6dt4v+KJW0G0PsRSrkI9WHnMFeadN3ViLT2jxox8NFJUbezpnIg4Zqo3wwLml+SgCI
         5r05mjme0RU2U6LiFP/SK+0AlNUkPxAy4rc7cSB0e5MCcL23SMoKpOySqV9ptqJEkVgY
         KzsiLxzbBCQQDg9uQ1En8167Vuw5vVBOzG5OhH+XbdD+rlQZf20M3tpIRwy/iMNXI8eg
         fBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iUCoqqC2zE8DKYZ0s+wXHnD71jpglW19sJZioa/jBuY=;
        fh=iQm91xFQUBbDJgUsk3JL+epfGsh5C+lNegyohSZUpgk=;
        b=LTSDIRnQqWcM+Lwoh2D1HuHAwdszjYRVXSbBWko05fsE3yqXtjO3XpBMjpuC0s06HX
         ufxjEeU8H1YwEiidj8qdF1fy9idJCS3Lk07oaEoFN1BiXEahPaIM5CfkLqAhmEno7soo
         P7TmUteE6P7wurbrgggtutO1C6GlkUdyIT4u2tofChVZZ7tOZvm5BtZU5m3uSMMUSZkA
         yqulRqT4rxvHS18Me7kAs7fE9942sQ6Sx6UPraDFLzKbxHjcnVj7NvKrYog3LqKVdPZQ
         ZYklf7tkS+WM3vedJf3oCsSzn/BX7x8B5Jg68ymkm9dNTUn0C+tEwLhO3L2bj4yek0pf
         8gbA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769015798; x=1769620598; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUCoqqC2zE8DKYZ0s+wXHnD71jpglW19sJZioa/jBuY=;
        b=A9UUMP8Ti/Rc7G7u5B7d6NTnRIIDpPa7U5+g/Kp0bZwhheDrAerSTzz3JZuOpDJH94
         wwy8y5dMkbLxjGRuYEYGFdhppeZiF/foS8tJ1lIGMoOnyOToqfcT9HLj3yg/hMgzbUEH
         29rBqBXw/wZ/RblcYdY8LGlb74QzKYvepFEQq92nzLY+IV8lAxKYrEN+OAWWwRY6yYEE
         XM+TMW0edFWpRKDQaRzxXLR1SkUniirG/jF1UplM2qDLu+JA3zc+HsipCmbglRH242U9
         Rq2mf5xtAZDyTZXez4zMMSnfXBZtcguwdEgQ/DCfwheJ3w5F+MRK6iTPDFuWnnFpd9M6
         fjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769015798; x=1769620598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUCoqqC2zE8DKYZ0s+wXHnD71jpglW19sJZioa/jBuY=;
        b=B4xXIBKCKN4WYk+dI0L5/O6Ah9HECFeAqKL1wnUPi5VxUGLLwZaMgz6SDFuFENRATT
         zzgdl7HV5zOaY2X+T0l5DGkyR9YcpC+B9VowHC2jedxEP2BlK2X1KbVZDl50+2Ggbp8T
         x4Z43rAIaBqQ3K1PGiwPTk+NbslsdWA9XbunmlMrxviL9D2SZSS0oigvXAPIKpKQj19e
         8HlUs7nxMrqlH/UcY3/wBvl5sKSOgV3LjDX2nziB1lDoniFQKE5hiwGaopmdU0qFIxKL
         NNTitN6oR1AGJH89Fo0Xzv/sEyfVmQM+4FiKxIwc/OF/Fs8HQ1sXPwJz2BjMmJlUpQwY
         G17Q==
X-Gm-Message-State: AOJu0Yxw97FKcDatXgOfkcS1b0O/Galzso25QhJJ5TwmpRlcpDp/9iUL
	c/TQDMihR0LSSOGYxVJQfkB+YOdxS53dGfuhFZyIelCyxApNDHomA9fGeQcvn22qRB4gVGGK9dE
	hJPgzkt5i7z8yqjFNNW0smPkCSEuFTWvHgw==
X-Gm-Gg: AZuq6aIZFw3tNCeDeeANgxXwFRmbci30LarNV1e5cn3VhinD/rvXmPDE8P7paoGyq+p
	y6ynPFtIdA0LxraZXT4LQV9e+xKbALNmgCwvIJlJQ/dkMi7IjLqL7SzULLAoEGrOeJ2GtUOlHCw
	IwzGL1NUP3h2w1hVlpMPMzCyMSeawjPvHenZzmQ1ske37x+i0hKfLt9LKPS+7229Nh2i0n326w4
	PTiIP/xv6NZ3UHVIojr/Pk00AeZOqbyB9iW4dghxHwpuldMMTEA2kloNaXVbna/tksEuwqzTA==
X-Received: by 2002:a05:6512:3c85:b0:59a:118c:5c78 with SMTP id
 2adb3069b0e04-59baeed4ab2mr5936940e87.22.1769015797398; Wed, 21 Jan 2026
 09:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20260121163409.59824-1-yoann.congal@smile.fr> <20260121163409.59824-2-yoann.congal@smile.fr>
In-Reply-To: <20260121163409.59824-2-yoann.congal@smile.fr>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 21 Jan 2026 18:16:25 +0100
X-Gm-Features: AZwV_QjVRsqMObDPfQDevliFc2I8UoZ2Si5lctbK1tzzcfldiYrhP0zda0cteWs
Message-ID: <CA+chaQd5_PZzoQJAdFV+5xrDTN_NTvP+qL3uS9BWVV2V3F0Viw@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH 2/2] schedulers: Add
 missing stable branches for non-core repos
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 17:16:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3046

On Wed, Jan 21, 2026 at 5:34=E2=80=AFPM Yoann Congal via
lists.yoctoproject.org <yoann.congal=3Dsmile.fr@lists.yoctoproject.org>
wrote:
>
> From: Yoann Congal <yoann.congal@smile.fr>
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  schedulers.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/schedulers.py b/schedulers.py
> index 0018fcb..036d66c 100644
> --- a/schedulers.py
> +++ b/schedulers.py
> @@ -75,7 +75,10 @@ branchdefaults =3D {
>          'branch': 'whinlatter',
>          'branch_bitbake': '2.16',
>          'branch_meta-arm': 'whinlatter',
> +        'branch_meta-aws': 'whinlatter',
> +        'branch_meta-clang': 'whinlatter',

I think there is no whinlatter branch in meta-clang.

