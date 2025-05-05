Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A50C3ABB0
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 10:05:36 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.46647.1746439529193671814
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 03:05:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dNzaWasH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so26849495e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746439527; x=1747044327; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GicJggFuaIFiYxXY2hrlxldd4mOh5GRodk/j9SXX7I0=;
        b=dNzaWasHSSG62a6KdYopKVWjN6/ACnE5j+qXNFfNG4ZAXHNwTNlkYVD2SRbtDJ210i
         ar7ThfZ0qYkXRWRYL6SBSUGLRE0Wu4zxtzVo+Y3XV//du/73y6SLmNl5PV42rqwQsCIq
         ntIUl5fNsc3ZfCjQAxiJjpkDds1yFY0A0MxM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746439527; x=1747044327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GicJggFuaIFiYxXY2hrlxldd4mOh5GRodk/j9SXX7I0=;
        b=fZoN+iD1lS/a8VeC8uOe8hvFSYD78B5xqEdRW9yvr2SzIXGQEGX3a+m8eqTakXmNbk
         YYAJOio3uyiSXznfOed6ADfCh5vKownnqku/IyuUCrlu8NzWjrILdxTzRDDji6+TwqD6
         ROHmVRx3J+vEmlrSt3jQSEvF5yqvkDUJh2RfAY0/1CSq2eqHesrL+dkOkRbZ/1JxKIch
         eqlSKMQS0woP9dOW86bPjTDsyxNZuxFPjB1n6YoB2e/TtrWWeCDflQYVfusYALzPIldT
         x0wIsnwZdsaayUkFRRo+TQpEuz6YiOo0j8V4vg69gPjqkqmI89yA7TgdOZ2OFGeJ3dAX
         Fjgg==
X-Gm-Message-State: AOJu0Yx0pu+Gs0qs2Tnd4qaCK8NXyBDdbkQYzgNCisE1K3fWd5rkz+fY
	iy5C2AJKqnoW3umidFlqm3OAYPollAAz7mg5Oe+C8RbiI50Ej1GzNe20iFBulo8ik/AFbvIMWWI
	w
X-Gm-Gg: ASbGncuJJ14q6FuJ6KiKhd6+xbQ68zxqkBmqk3oRUy6S7/G7IIt6OAkrjxBQYQIRiT6
	cBzItKd6IftZZTTbEFcEHFJwGAaZ6ns7skqKOKhSG2GQH04YVtk4tI+I7nFrCUTxRGGhzAM7B7F
	9sfWnEk9Wa2pVYrMBmLA2mIzXZJeAP1odXN7qlFqNoefbROJbYhhvvydO7q1LXMFZOFThWLH9w1
	V+efXrvuDJzdWbe7avVJUCxUYZAdLwLXwTJpN2O1MAKVHZps6nRIvKuzIhtTsL3V4lAYsnTz53Y
	3SqDH1/MhubQaSUz2AacPyYxnl7OzSuQ7r895+zsA3FsYtsQLdSNL9BWEnVMtgAtJCLPsekGeJL
	4nZXKiIS62Wdk31dd0RjQ82yY5zriawiSkpEF89rV
X-Google-Smtp-Source: AGHT+IF7HtsDOQ3KL79HoMcuaNT00huMIU/GHraGCqH3l9i/SKkQaRPet6gNdcG4MxKieiGw6hrt8w==
X-Received: by 2002:a05:600c:a405:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-441c99f3c6amr30964555e9.4.1746439527283;
        Mon, 05 May 2025 03:05:27 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:4146:97bc:575c:a2f9? ([2001:8b0:aba:5f3c:4146:97bc:575c:a2f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aecb54sm172846555e9.10.2025.05.05.03.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 03:05:26 -0700 (PDT)
Message-ID: <2dadedef80eec9aae68c0e6bff49d3a66c4cbc98.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-java][PATCH] Updates the mailing list for
 meta-java
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Ashish Mishra <emailaddress.ashish@gmail.com>
Date: Mon, 05 May 2025 11:05:25 +0100
In-Reply-To: <20250505094642.941006-1-emailaddress.ashish@gmail.com>
References: <20250505094642.941006-1-emailaddress.ashish@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 10:05:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1498

On Mon, 2025-05-05 at 15:16 +0530, Ashish Mishra via lists.yoctoproject.org=
 wrote:
> The mailing list is being updated as per commit
> "ac65b6e5bbd2c9b55a64a13ab4c55d212a8b585f"
> in meta-java
>=20
> Signed-off-by: Ashish Mishra <emailaddress.ashish@gmail.com>
> ---
> =C2=A0CONTRIBUTING.md | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> index 00c7b88..d7cc308 100644
> --- a/CONTRIBUTING.md
> +++ b/CONTRIBUTING.md
> @@ -14,7 +14,7 @@ Contributing via E-Mail
> =C2=A0-----------------------
> =C2=A0
> =C2=A0To contribute to this layer you may submit the patches for review t=
o the
> -mailing list (openembedded-devel@lists.openembedded.org).
> +mailing list (yocto-patches@lists.yoctoproject.org.).
> =C2=A0
> =C2=A0Please refer to:
> =C2=A0https://wiki.yoctoproject.org/wiki/Contribution_Guidelines#General_=
Information

Since I know maintainership of this layer is in crisis and it is
important to have this kind of information correct, I have merged this
patch.

Cheers,

Richard

