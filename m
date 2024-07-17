Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F604C3DA42
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 13:08:34 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.14698.1721221713220369583
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jul 2024 06:08:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WWeOLo5X;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42726d6eca5so49389125e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721221711; x=1721826511; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YE95r/NVBVw44who/qFabPaPzHJj4PLsr+P5Y4r+Cjk=;
        b=WWeOLo5XVaWpYxa3BH2IvUBz3ml1DnfBxtdBypSThLfdztDX7HndIOA2h94Ep9Ygkb
         ZLd9rIWvpreYvdHqOBruYgYBNPdMnh9qc/9Eq3XhHkkxst1gRj+FZnTBXNqqMeEfIsnt
         qzhQCu+cusMEixUf+zitRKlnHuWJ3RF/Tv3ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721221711; x=1721826511;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YE95r/NVBVw44who/qFabPaPzHJj4PLsr+P5Y4r+Cjk=;
        b=ac1eOeJDTZmOVzzarlgkHvmFvLXC4Oxnm/1GFhCmPDUUwSy60AX2tUBg+r/tZbIv/l
         OneNxOGxtktAQnlmcMX9snrrfpqfE6e+ecmhxwmGYk5iVEne5p7kFvfdQr628AGeq2IP
         ykiVhf8noUUmPBtfxEyvQ+2SwNYSYTE/eGyLvUgdaWm6v3wWue6YiBbH38k3zGIqZvYg
         vQwXiAIQxyqwRb9UGrO0q7u2v30xjTKkYJhNtArPftTZMTE7XXD1gX/Ffd72fjN73det
         Y1G7RnEn0CZlG1alW2PuKP98acLCTDrs1ED2f7We5vzBqHuCgT41G/B2UjnblbOo2ZUX
         IDsw==
X-Gm-Message-State: AOJu0Yy+iTneiHnOZzkogz6gIPD+EPN9PVCGzytnIVtUYWLFP8Tp20c3
	KImvDL74D3AkoP/ybpFUr0fjmhNT4crz0ELv0mVGe+CobwNHLsp0Mem1pQsGxoHR/l9fZcu5lh7
	K
X-Google-Smtp-Source: AGHT+IFpuohbs01oQh4ZeS6RHqaUVl9A0BZOln7PI7eAyLhkT1Yhp6BsyYNo3hPbf8ixLaIvG3lIPw==
X-Received: by 2002:a05:6000:2c8:b0:367:94a7:12c8 with SMTP id ffacd0b85a97d-368315f2ca5mr1312859f8f.6.1721221711373;
        Wed, 17 Jul 2024 06:08:31 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9a16:3e6:efff:89c6? ([2001:8b0:aba:5f3c:9a16:3e6:efff:89c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db03bc4sm11623062f8f.93.2024.07.17.06.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:08:30 -0700 (PDT)
Message-ID: <778f65c9449972c08e3cf159d1601ae9463bedc5.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-java, master][PATCH] openjdk-8: Fix
 multiple CVEs
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Date: Wed, 17 Jul 2024 14:08:29 +0100
In-Reply-To: <41f24d4b-00db-4c67-b7aa-aa9151d81081@mvista.com>
References: <20240701115411.15574-1-hprajapati@mvista.com>
	 <17E10E97BE1E983D.20043@lists.yoctoproject.org>
	 <41f24d4b-00db-4c67-b7aa-aa9151d81081@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 13:08:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/438

On Wed, 2024-07-17 at 17:35 +0530, Hitendra Prajapati via lists.yoctoprojec=
t.org wrote:
> Hi Team,
> Any Update on this issue ?
> Regards,
> Hitendra
>=20

The maintenance of meta-java is struggling. The code doesn't have
good/working automated testing which makes it hard to know which
patches are safe to apply and which are not.

It has struggled along for a while now but has reached a point where
nobody knows what to do with it. We can't just "blindly" merge patches
and hope for the best.

So I doubt there will be an update on this issue any time soon. We've
simply run out of people with time to spent on maintaining it.

Cheers,

Richard

> >=20


