Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ABECDDE54
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:09:00 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.5411.1729678133038452183
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Oct 2024 03:08:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KXygUee8;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539ee1acb86so4937354e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729678131; x=1730282931; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkX0SOj+fe4NtdxQLNPYzDsdSU4WiniZM+ZM4BtEvIU=;
        b=KXygUee8iF3JhiDHLxFPPskSLPJ5/W4PjLQd5tvKdLWt20uTxWvCleT/IEedocE5bP
         ofPfsV/R7ZwrcZ7n+wslhSmf3UTE5d9yE+CYUXYEdLh1Uz4/icOC1+USRgvUs+jAeo/X
         2g28xHDML3OtBEJLX/8pRb7p3grhG7688Azq6BsLZBDmNUGX5u2lq2YTtyNhICSylMpb
         O3nWjJRF/tKtas6iGpqfnFmtaHMJQNDxudmLePecb1Xt+kukIxb+ubdO4VXhUvwIDlvN
         qt1MUgxpIPy7MSnkh48g3DfkTOlvQX0y/l9LbnLTfA6DOydw8+ol2f3u8UjrZskNz4i4
         QtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729678131; x=1730282931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkX0SOj+fe4NtdxQLNPYzDsdSU4WiniZM+ZM4BtEvIU=;
        b=p/p020EWYlkrU/2v8uJ6Sb7r92rifaim07zYob0a1Bgw+ybheJqYafHi73H3W2/k4j
         SudiBcwOy/S54vKnJc1ba8C3Vqg0gPJQg+3a23Z7FWM9b5n1T0a8r2jKQWAJrTnrHbTW
         Mi0cVixUFhI6mvoXlzx/Ud4V6pRpFBNZvPRjy1DdkbC2b1g/9OgbgYx8CkDfCOcjFt/L
         HVB3ddGcIdUwANwJe3xHP+r4JqM9u7Z3oLxsP5Tv5wQnaJ6l4QwCgnuof4FIiYcPo8YC
         mPitH3nnZCNhodCWBVym7JeEyd8uy4RjMRgvWB4OEoVO7W88Q7XkFoelCVi/nl/YYyVg
         GcUA==
X-Gm-Message-State: AOJu0YwQTLMGVqehg+l+Ya6ojLQO4WOeNW6LXAKKctWoUv9uAv0tJXg8
	WSKk+RUbCvBk3raSn6U7IyO1thT3IZISPd1ZbSVlunaUeh5AIMw+YsT0+rKLZIRMxhL6bdt0kn0
	smLMbbpHQjMk/VIEfDSquUr/9nf7LPg==
X-Google-Smtp-Source: AGHT+IHQlWkx39AkUuqqmHBUtdgmR97wUHGc9hnKq+1kmjuYicCHrJat9R+Qg3+iu2RNazJ8vnuUlPmSMF1wY1jbIDI=
X-Received: by 2002:a05:6512:138f:b0:539:a2f5:2f1d with SMTP id
 2adb3069b0e04-53b1a3a613dmr863970e87.61.1729678130955; Wed, 23 Oct 2024
 03:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241023100242.3953188-1-mathieu.dubois-briand@bootlin.com>
In-Reply-To: <20241023100242.3953188-1-mathieu.dubois-briand@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 23 Oct 2024 12:08:39 +0200
Message-ID: <CANNYZj8B3jKqA4EDrVS2jwfTH8Dn1BbVK=3TAaBVB3VA_6DPQg@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder2][PATCH] Add branch selector
 for Mathieu
To: yocto-patches@lists.yoctoproject.org
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 10:09:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/731

I wonder if we should give this branch a generic, stable name? It
would also help when we need to point to people that, no, their
patches aren't ignored, and are in fact being tested in a staging
branch.

Ideas for the name? 'master-next-next'?

Alex

On Wed, 23 Oct 2024 at 12:03, Mathieu Dubois-Briand via
lists.yoctoproject.org
<mathieu.dubois-briand=3Dbootlin.com@lists.yoctoproject.org> wrote:
>
> From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>
> As Alexandre is no longer using the autobuilder daily, remove his branch
> selector and add mine.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  schedulers.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/schedulers.py b/schedulers.py
> index ec3a085ace8a..7bf27f8537dc 100644
> --- a/schedulers.py
> +++ b/schedulers.py
> @@ -44,13 +44,13 @@ branchdefaults =3D {
>          'branch_meta-openembedded': 'master',
>          'branch_oecore': 'master-next',
>      },
> -    'abelloni-next': {
> +    'mathieu-next': {
>          'repo_poky': 'ssh://git@push.yoctoproject.org/poky-contrib',
> -        'branch_poky': 'abelloni/master-next',
> +        'branch_poky': 'mathieu/master-next',
>          'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-cor=
e-contrib',
> -        'branch_oecore': 'abelloni/master-next',
> +        'branch_oecore': 'mathieu/master-next',
>          'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib=
',
> -        'branch_bitbake': 'abelloni/master-next',
> +        'branch_bitbake': 'mathieu/master-next',
>      },
>      'mut': {
>          'branch': 'master',
> @@ -454,7 +454,7 @@ def parent_scheduler(target):
>              name=3D"branchselector",
>              default=3D"master",
>              label=3D"Release Shortcut Selector",
> -            choices=3D["master", "master-next", "abelloni-next", "mut", =
"styhead", "scarthgap", "nanbield", "mickledore", "langdale", "kirkstone", =
"honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud"=
, "sumo", "rocko", "pyro", "morty"],
> +            choices=3D["master", "master-next", "mathieu-next", "mut", "=
styhead", "scarthgap", "nanbield", "mickledore", "langdale", "kirkstone", "=
honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud",=
 "sumo", "rocko", "pyro", "morty"],
>              selectors=3Dbranchdefaults),
>          util.BooleanParameter(
>              name=3D"swat_monitor",
> --
> 2.39.5
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#730): https://lists.yoctoproject.org/g/yocto-patches/=
message/730
> Mute This Topic: https://lists.yoctoproject.org/mt/109167694/1686489
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1319734=
9/1686489/315264618/xyzzy [alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

