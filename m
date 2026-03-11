Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A1104951C
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 09:39:55 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16941.1773221991082398128
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 02:39:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=haYwnxuj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439c5b40f60so6483217f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 02:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773221989; x=1773826789; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLOk/hfQeO3ba+tRkRQWR8oxzYBBfwrl0OMHMzlrub4=;
        b=haYwnxujJIkZZt3p9fa8bSehmpGTFEWkCND/ZkhiDkbFyMgh7GqxjGxy/fVOYuidPo
         XmYYveosH1LU/RGAvpNm4VepNMTPaVEz0hwo4iwA+wmjFMrjrWsIcJvJW5UNwNAsCPQV
         LMq68T1FiHP1p36yq2L4sKI5cNDaecI+JdAm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773221989; x=1773826789;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLOk/hfQeO3ba+tRkRQWR8oxzYBBfwrl0OMHMzlrub4=;
        b=Y3KmsC5+01RWtquJgxriGiPOdX53fvfSm+J6UGD1J60ohryz0AHefWNHxMAwYGC9Ye
         iJiZRLnJYcmsRoHEhTU40Lgd0gF9CxInAeozXv7mDiZMFbyfvr28B7kdipA/JHLjcesp
         rXK5pMVz5QiAQThzFZfVGp58lsYqRpTpUqy4DD98dGf3ioB5B3nxVcBRRrI67LK/4d2b
         SL5yQFoF2V7XF2ywrwfIIHxE1yNLGqpzV8LLSCzcKB/VMtlsvrfV1QAaG8O1svNzn7YR
         q4Mcwo2Lmg6UD/7yXD47N91lopkqd2+u4mlaTBTxb3qy9O3p+lHYJxZJzUyy96SXrsDo
         adMg==
X-Forwarded-Encrypted: i=1; AJvYcCXmTPjiVuNlYJf4HHHYyWy66lzSsMFCdn/CkIoxbZBaN+RgOjhkivUAi5xRZ+yPlEyQCh9UvqHgyJJV8KQ/@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Ywhq8C3OkEuPIzSlzvuWuRMmpNUvd9Ly7VOMeDviBUAi5U/rUNw
	v4lOi+cG96v2Yiehg++2t33i5gI3TfwMDvaNb5y4GsrKniGhIdrg5zOEFz/rAybn6sDTmSw4yBQ
	UR1SiIFg=
X-Gm-Gg: ATEYQzwD5z5SnS2ZRV0VYW9b0OXPRd4sXrBrWDIiyipE9WaYF+csJ3HlPPFI6kMhqEZ
	Mv2ovgpn1Ij1gkXCgOQ9Pzy+e4npSxlT3N+pcjqAWaiPmqQmc7XuSU6HRrA1074bQfWEMu9mmAq
	WbSypRm7JBPOcuxG6bXyKbpcmjsCOd3axeSUA7FApELWHAP3DdUuJf20TnJB5JxDYZJqr4zz1q6
	ke2Quq9HQfBKwM9onNy3q9gWPZ8QOPaojlQLi8sM7j3J9g82zpKcpybgpBAISgN1Dd1dpMvXYSq
	Fa7BxLfntYlDHHnY7lt1p24/7QLLmtHbnath808UV6mPrOvy/uuE9fQMF7NW9ZE4slCWdNM8bz0
	HNVRunOYj3S/SPLTcZqX62A/2XAxflGXE8EytD8GcG3tqghw+CHntZ9u7mNFDhJrGenzE6GSbL5
	6q7f+bGLLDcG8LcNm3CQ7HzmtwH/rAP3qUhY9Z3j1jl35s7eS0anhYLxYSVTZd8OZpNZ4OorjBa
	erlcpO5fESHO/Y=
X-Received: by 2002:a05:600c:3e10:b0:483:badb:618f with SMTP id 5b1f17b1804b1-4854b11694dmr26577645e9.25.1773221989255;
        Wed, 11 Mar 2026 02:39:49 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7fc5:b1af:c486:ad0b? ([2001:8b0:aba:5f3c:7fc5:b1af:c486:ad0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f818f449sm5985394f8f.2.2026.03.11.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:39:48 -0700 (PDT)
Message-ID: <294e7021b4370ce4b3a0b9ddac188ca842a9955c.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH 1/2]
 config.json: Drop vnc usage
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	yocto-patches@lists.yoctoproject.org
Date: Wed, 11 Mar 2026 09:39:48 +0000
In-Reply-To: <CANNYZj-Ex5LUpa=5TO6QSHDaSDZTRjRMLUmJsAJzgk3OJhRNUA@mail.gmail.com>
References: <189B9F01010B1521.2412760@lists.yoctoproject.org>
	 <b8f3d35149f5b2a8e144da24fa6d1b4e777c6419.camel@linuxfoundation.org>
	 <189BBF57BD2F5917.2412760@lists.yoctoproject.org>
	 <CANNYZj-Ex5LUpa=5TO6QSHDaSDZTRjRMLUmJsAJzgk3OJhRNUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 09:39:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3430

On Wed, 2026-03-11 at 10:33 +0100, Alexander Kanavin wrote:
> On Wed, 11 Mar 2026 at 10:27, Alexander Kanavin via
> lists.yoctoproject.org
> <alex.kanavin=3Dgmail.com@lists.yoctoproject.org>
> wrote:
> > I agree, except one thing.
> >=20
> > I would take this opportunity to drop x11 usage on the host/naitve
> > side altogether, and migrate the test to use some kind of host-side
> > wayland compositor rather, that can be found via WAYLAND_DISPLAY
> > variable. I can experiment/propose needed patches to the selftest
> > and
> > oe-core metadata, but I don't yet have a clear proposal for the
> > wayland setup on hosts.
>=20
> One option is that the test would start weston-native in headless
> mode, and direct qemu to use that (via WAYLAND_DISPLAY). No special
> setup needed on the autobuilder.

If you have a patch for that, I'd take it!

Is weston-native able to build and run effectively currently?

Cheers,

Richard

