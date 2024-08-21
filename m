Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67116C52D7C
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 15:44:35 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.23243.1724255065670851175
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Aug 2024 08:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XbC9Xvbz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3719f0758c6so3043341f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724255064; x=1724859864; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vco0FmYEskNfMt/axFAfEIkVChIJZ8LlG0wAOix2XUk=;
        b=XbC9Xvbzr3ddNUMlV80kBbBOBuepOf/e2FusDG20JGONnYhdM2rJmT+oqs5QVbuJnY
         u01FJlcfB683j4LEIZ+QQSe8iv+DH6jC1AByMQon4gu0S9Ll4s8adZagFo95Ix220m6G
         0I30p4wzPjHsHyVNbicDyumohekQ1FRauVud0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724255064; x=1724859864;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vco0FmYEskNfMt/axFAfEIkVChIJZ8LlG0wAOix2XUk=;
        b=uzQ9ovSO4RmIt+1Yhao/1HHTiJGOQ7UMXXJg+4c2SypC7Ih9o3U1+buQCW8tgldEGH
         k+XpFmxrvrmhJPvYPi4VdSs3dwWCjFNUNIC3n2sE9m3jMw4q8twBWsxXRqzp7H2tUCqs
         f8nTwSJiJXcXecyJqF1Wu+xbbwRK70vF5alal20cvquzFdfkdOOhIUtpGAFbQB3ie6lN
         tZ6u2SISLXjnXY1FyAGrlDd8jc8wmsuNjJFFyvZxkbfKdHpP53YzzWZKPnQn/CHsdWYp
         inkHuLZU74h7zbXE8A9dZLlzsJroQk3GKbSdZvTzdxLGRLlcBaGCMUCMI2llJIgWsaX1
         lM8w==
X-Gm-Message-State: AOJu0YzxGte65BHlGw6qjYVlbi8eDlx0GGQwPwgh5srVXklyJutX3Eo1
	Wvf+c1ZyE6l4+wExKz3jrMz2nty6FoeArttWcP9iY/cHfTh/+8Nq83oa4sBXbK/bmJzxCAGXh7D
	K
X-Google-Smtp-Source: AGHT+IEni1ikbP0jbImThbGJfS1ctR0xYExTa6e2kUCeKQm1cGlwvyxcpphf/zGIyHXvzCLaKslzOg==
X-Received: by 2002:a5d:6a43:0:b0:367:9575:2820 with SMTP id ffacd0b85a97d-372fd7015c3mr1953147f8f.45.1724255063661;
        Wed, 21 Aug 2024 08:44:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e724:d651:c8f9:e43? ([2001:8b0:aba:5f3c:e724:d651:c8f9:e43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497f0sm15984441f8f.39.2024.08.21.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:44:23 -0700 (PDT)
Message-ID: <cf10983b4b7efdd6125d2dc519d52fab9f4ec3ce.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [ptest-runner][PATCH] README: Update mailing
 list address for patches + add git command
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, joerg.sommer@navimatix.de
Cc: Anibal Limon <anibal@limonsoftware.com>
Date: Wed, 21 Aug 2024 16:44:22 +0100
In-Reply-To: <23f3f3e4c8010e7f1b2322976ded709912863ca9.1724240133.git.joerg.sommer@navimatix.de>
References: 
	<23f3f3e4c8010e7f1b2322976ded709912863ca9.1724240133.git.joerg.sommer@navimatix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 15:44:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/543

On Wed, 2024-08-21 at 13:35 +0200, J=C3=B6rg Sommer via lists.yoctoproject.=
org wrote:
> From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
>=20
> Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> ---
> =C2=A0README.md | 8 ++++++--
> =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/README.md b/README.md
> index e6f548e..8afb161 100644
> --- a/README.md
> +++ b/README.md
> @@ -48,8 +48,12 @@ $ mtrace ./ptest-runner $MALLOC_TRACE
> =C2=A0
> =C2=A0## Contributions
> =C2=A0
> -For contribute please send a patch with subject prefix "[ptest-runner]" =
to=20
> -yocto@lists.yoctoproject.org.
> +For contribute please send a patch with subject prefix "[ptest-runner]" =
to
> +yocto-patches@lists.yoctoproject.org.
> +
> +```
> +git send-email --to=3Dyocto-patches@lists.yoctoproject.org=C2=A0--subjec=
t-prefix=3D'ptest-runner][PATCH' ...
> +```

This looks good but we might also want to cc: Anibal on these so note
that in there as well?

Cheers,

Richard

