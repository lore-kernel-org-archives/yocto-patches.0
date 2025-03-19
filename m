Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569CAC35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 12:52:21 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.7133.1742388736572208267
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Mar 2025 05:52:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Q0BzgCq5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso30382105e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 05:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742388734; x=1742993534; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdD/jHKXTNB0yv3y+mPhgPBABj3eguEk5dNZI3TgFw8=;
        b=Q0BzgCq5kiWOklE60Yh6qiQ2eg4h/ION1mpflslso80rWgIlDnIAyZSDqOHXOmDM1w
         dG03JtWqOuSTJHAZdVAq4f8fLEfW2fJFvfJIeazFWtfZOKs3Nk+iRSmbJevdfLZjwAOW
         QWb0co7/i6pmDfRq8ZR8JXFkN0IP/nP4jY1Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742388734; x=1742993534;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WdD/jHKXTNB0yv3y+mPhgPBABj3eguEk5dNZI3TgFw8=;
        b=LrxJTv3rDipB+zBYXIJHoa4kTfLZQRMLy2zInBfJ6D1oLZ9/W75+rpeZMrDvLz3U33
         CLnoY28w0EnyPe5pA5FCouvQkox7Ho4S6fDZMlE1zxeeCPYClt4Aup1ZbKiVwCqbIn2n
         XNSKkG625/7LAR+v4GpJkRrRZcNkubYmANXNmJJAv7t4ZdkL7LR0MKWemf54V2yJZP1y
         m0lrH8pyiplnQg6BTfG3tRubyahDp5Qd2YRLrK3rHM4WmhcIWKFBzUKwZwM10/c7lMka
         KHk7F5YuGxnt5jJqbNDO1tiw9xeWWCvaEC+CkW/zJOnQ2tNx1pnYUoDtugARde6KUGBz
         pu9w==
X-Gm-Message-State: AOJu0Yynbj0Zr0+j0tSaW2DSdx4VtOpHDcnPhZO2HV1+Nl9RGsiPYSKk
	hnyJ7JPthq3whzraxOCszHypFx1tgW7oSJiISXmKPveqv0NlbTOceMXaVxLSVOeAPuCQ5P4qg4t
	j
X-Gm-Gg: ASbGncvS2g3dgMBHDP0BUp3b2S5amQ7WNOxxetsaIqClUiyimaELmUAMsvGbSc+u94g
	kRO2w8RocS02h2YIOXJdREUWJ8YV4YtJ75X3lOnGlfluTf2SDqUANZQgWjxl+XKdcUn9Vb4nM9G
	AouvS2Ry2BSklAyVt0X/MpE0IFpvBlce9cPzrFfQ4sUN+FOcNse82yxKFLX6ZmEwIfbYEcMIXKz
	Ruk+oVbilZ73L+z84JH9kbhLyEL95XfvTsUUN/OXf3U05v7FhY77VJqqB29HoZnGfhv1iFpZme9
	PB1QTlarS7TNTWp3GM4QIHPA6pq/0GX/LeYUkt4hd65iHzFw6IPJO8kDqKOm/MvQNk4mWN/+6uh
	8GBIrt6v659kwZoK9FkARsFcG3TkNguM=
X-Google-Smtp-Source: AGHT+IE7CddoFUicnVLO0rd1uC4p5ssR3zeDD2js3j0Yw25oS3Yn2YllpxS4+aHUBGeAwES0deVeyQ==
X-Received: by 2002:a05:600c:1e0b:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-43d437a9655mr22818055e9.13.1742388732950;
        Wed, 19 Mar 2025 05:52:12 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:dad:b471:9c34:4577? ([2001:8b0:aba:5f3c:dad:b471:9c34:4577])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39973c9d93bsm1972800f8f.65.2025.03.19.05.52.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 05:52:12 -0700 (PDT)
Message-ID: <831fba9db81edd7fe0b155ef8fca855283829731.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [libmatchbox] [PATCH 1/2] Clean up licence
 headers/files to use SPDX
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Wed, 19 Mar 2025 12:52:11 +0000
In-Reply-To: <182E346AC2DED877.9767@lists.yoctoproject.org>
References: <182E346AC2DED877.9767@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Mar 2025 12:52:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1222

On Wed, 2025-03-19 at 12:35 +0000, Richard Purdie via
lists.yoctoproject.org wrote:
> Switch the headers on files for SPDX license identifiers, which is
> LGPL-2.0-only in most cases.
>=20

This is wrong, it should be or later :(. I'll redo this.

Cheers,

Richard

