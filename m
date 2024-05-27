Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C80C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 19:46:57 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.5728.1716839215880226279
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 12:46:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NhtExxaS;
 spf=pass (domain: gmail.com, ip: 209.85.208.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e9819a6327so641231fa.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716839214; x=1717444014; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mTudrur74WdKgl9I9egHFdbrvPEj9ACqW9SmYRjcEMI=;
        b=NhtExxaSChs1QHwsA2tqj5rMsiH0kZAA7nLY01kne9oRnB1w+12l1kiBtyQSh9s9TR
         GEWa5T9iaJl45oe/xEwPuVULVcJ7pWoNivQUDpovGb1dT0tG4P5TrmXx0yupNlpuemWe
         TwEYKLDS9UFYBc5J3MKBI1B6QuhDkN+V51fbxzIqAyiYJjja/IuSamfi+ZiPUvTSnsU9
         y+PgsyBfA+yYz698Yu9PQnSXRwqKN9PeVhDp9qwkp34cK2EuuJhGp1BM1V/uRGAM164F
         XZYSU06knLzbTqFcYQk35tdh/kMcmB+LiLWsAKQ4WmNftgFagZ7bWUnYZJt8Ji3WyKMC
         4XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716839214; x=1717444014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTudrur74WdKgl9I9egHFdbrvPEj9ACqW9SmYRjcEMI=;
        b=vfiW/FpTQb2EmZwEcGdXtURaCc7Aah2kKJmQbW9UhQOwpbAx6xFRuTPHylF6z+ree7
         Rsp6jNnjdbZRHaZIqmse0/kJJRsOKJguf1naQWuNkA4g36SbSBOsjqkeZM2Ff8WmPtyN
         82oMoRGHsOEotDh/QN3EchlIHtz5T+0y2tCPXEUhiIdLWCZu6/Zgndxuc58MzLG8LNjK
         qqC4S2V3hcA3WJjvefhyC26IxBXAlIi1dOyxc4t5ZoA5X5ybnEBa6oEeQM8aD3wjxLzJ
         3C26zsHAo1f4RUKggx4LRaYMFjfkuGpXqNMnPx9TjUH9oOmuKsGsPVlRR7N5smMcb1Bn
         VW7Q==
X-Gm-Message-State: AOJu0YwR12qNuC0DCHUx1qiLZdhv/+wb42YWj3tmFVfCHPZkGHfHsS1Q
	CiG764OYABppJk6KQ0AQteCBsKwl+uL6wFd3rWxArwv4YuyqCDYP2ZJc7fOQUUtSLs1F/+R9G//
	jVcYx2E4Y0wtUI9G5OGerRqOFmwo=
X-Google-Smtp-Source: AGHT+IHjDOtkQwKVZtWPu1NNqndhCZ14ejSbe+iHYxVrDYEDwGNNJA7nLp4FzLKM3w9+NOWXisf0gWNCjop/YcBJ5e8=
X-Received: by 2002:a2e:2e10:0:b0:2e5:87c1:e845 with SMTP id
 38308e7fff4ca-2e95b278a70mr59353461fa.48.1716839213203; Mon, 27 May 2024
 12:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240527175850.1256122-1-tgamblin@baylibre.com>
 <CANNYZj9NxxYo3jTYmNVhGPvv9VoeZN8M779TmDwfgsbDzdoEtw@mail.gmail.com> <81cbe515-6fb2-4342-8932-cb453a0bf8ab@baylibre.com>
In-Reply-To: <81cbe515-6fb2-4342-8932-cb453a0bf8ab@baylibre.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 May 2024 21:46:41 +0200
Message-ID: <CANNYZj8EHiyFr+rSLS_2Nr6SMnc4AVsUTP2dnY+C1LZcKkw2bw@mail.gmail.com>
Subject: Re: [yocto-patches] [auto-upgrade-helper][PATCH] upgrade-helper: fix
 testimage check
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 19:46:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/215

On Mon, 27 May 2024 at 21:02, Trevor Gamblin <tgamblin@baylibre.com> wrote:
> > remote: ##############################################
> > remote: Invalid author Trevor Gamblin via lists.yoctoproject.org
> > remote: ##############################################
> >
> >
> > I could probably fix this up, but perhaps it's better to do it on your side.
>
> Is there something that needs to be set in my gitconfig or elsewhere?

You need to convince git to unconditionally add a From: line at the
start of the message body. By default it does that only if the mail
sender and patch author differ.

Alex

