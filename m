Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF5C369D3
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 09:52:58 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.44406.1745833971914499447
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Apr 2025 02:52:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TV/86eEh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c30d9085aso3273105f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745833970; x=1746438770; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLhcpuz0rtnYk/LvH8pmEGETy0nyEP20A6VpLoK4bE4=;
        b=TV/86eEh/FGJfVQ6vfaMBsCLGA0gHqpC+jpU9XAVM4lWG1EdGO+1D1mqw1+z+3baIH
         Ajbeu5c78g2FmdkkXAnZTYYXQPA+Fv0waXaTqgFTfEWh3t3s+z6bRgZO+SQseT8ZLPMZ
         iHGBJ/DBidSUZDuAKzHMocPZZs57oO9I329is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745833970; x=1746438770;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLhcpuz0rtnYk/LvH8pmEGETy0nyEP20A6VpLoK4bE4=;
        b=lY9olhzt5QrqPA5qw4WdOtWR7NuCM0UmGVfGGcI5VGwzGj+1vhno4rceANFfg/Z3IH
         mNU4j8fYRyc9magGEsVy+BEpj1yUEPLY3rRjN4+UrxuBiMwK5yB1gDsD53OUc2NHhvI9
         gJyivzjEOqPadYoz6jWIgkYe6L1SkuXVc/eFavvE7KEwEkqSdNHpYBJ+fZ4ohF78x4DM
         9eNYHiashBdYJ6gHc7R6nTgS4x4sSmolvpZhh+y+d+K418YLJQiUC5TA+7onurHQ02fd
         DZwOGMvnvXmYYIHKxvm+LUMm6Ni/hCq0x8k5neiDKNB8mnaraiW4A5eZkw+uvold7dlz
         PC/A==
X-Gm-Message-State: AOJu0YwPGQtfvtl101lFYOwEmB+jV8aYNYDNQsu5pU0YYa6WGj9XgqPy
	zJxm0DhRUQVNGpd+Ox/PCP+2bd0xI7iPAApUOb58ufT2vOEI2NIMVV5zhMXITM08dMyNGwtg8Mk
	W
X-Gm-Gg: ASbGncuZxwoapaCH3DeNmGKZYZ9zbkCaoblXdxliUTUmV5N4R5Gp7Eew6Xc7YxFawDT
	PLwqmGX1ZFJ0jIFd/hzl5pWe34/FV7BuJ6hKMEyZ7PQBzxEoQhiCg+DZEvBH0cq1GnxB/TGiUjK
	4rqKy8PGEPBdD5TfqxGQtZYO0a6alcGGljFmp7m54HNKe9uJZ2znnOMwG2eJBfV5MaJqi+ZHYGl
	mu8mRmauMUfNCshur2sZpyNWBw3RfA0fX2aMRsnFkSCkbWJT7UpmFry5+2/XMqQqXDV14l6SNnv
	azvK6gFImgEsD0m4cGRbq0ZqAKZpiM/NQQyz2KYD7EJAJH7UV/NLaqtMUP2IBaUE+l1nGTCfK9K
	dGT5xFwjR9CzkwnaJP62n1tnLxjx61A==
X-Google-Smtp-Source: AGHT+IEnIu3ThT0Mks+L5XnXW4Kg06Y7qWAh0CVt8yBmgxzVHEgCsglokAr7jjrUhrtq8pYvUjJkdA==
X-Received: by 2002:a5d:5889:0:b0:3a0:8330:3377 with SMTP id ffacd0b85a97d-3a08330339dmr2664505f8f.44.1745833969918;
        Mon, 28 Apr 2025 02:52:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9969:e6a6:49a5:9ef1? ([2001:8b0:aba:5f3c:9969:e6a6:49a5:9ef1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca4e50sm10911879f8f.30.2025.04.28.02.52.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 02:52:49 -0700 (PDT)
Message-ID: <2632b1436e89479a8e9045188905c804f292e7c4.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][scarthgap][PATCH]
 config.json: add a builder for meta-webosose
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 28 Apr 2025 10:52:48 +0100
In-Reply-To: <CA+chaQcz+_1xjqsALTA+z13qKSN77x8G6cWu8ytE+A3CqEav9Q@mail.gmail.com>
References: <D926NE9BWQNP.24UZVBATV4CNF@bootlin.com>
	 <8641.1745829497357307449@lists.yoctoproject.org>
	 <962736f53e74160579c266835dacfca786d3b362.camel@linuxfoundation.org>
	 <CA+chaQcz+_1xjqsALTA+z13qKSN77x8G6cWu8ytE+A3CqEav9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 09:52:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1407

On Mon, 2025-04-28 at 11:49 +0200, Martin Jansa via lists.yoctoproject.org =
wrote:
> On Mon, Apr 28, 2025 at 11:45=E2=80=AFAM Richard Purdie via
> lists.yoctoproject.org
> <richard.purdie=3Dlinuxfoundation.org@lists.yoctoproject.org> wrote:
> >=20
> > On Mon, 2025-04-28 at 01:38 -0700, Hieu Van Nguyen via lists.yoctoproje=
ct.org wrote:
> > > Could you please merge this patch and schedule support for the
> > > webosose build for the Scarthgap branch?
> > > Please let me know if you need any further updates.
> >=20
> > I've merged it, sorry about the delay.
>=20
> Thanks Richard, I think this might depend on
> https://lists.yoctoproject.org/g/yocto-patches/message/1339=C2=A0which al=
so
> doesn't seem to be merged yet.

Thanks, also now merged.

Cheers,

Richard

