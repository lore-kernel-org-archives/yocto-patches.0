Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C834D3B7EA
	for <webhook@archiver.kernel.org>; Tue,  9 Dec 2025 09:02:30 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3420.1765270947747727890
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Dec 2025 01:02:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=We6izAxl;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-882475d8851so59520426d6.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Dec 2025 01:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765270947; x=1765875747; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EuHqg+7Vq0O9cbNkZ4a8s+u1ESvqTGu4eYtLE/IsW8o=;
        b=We6izAxli4F8wSxfZK23WDo/5A8YrI6TlBrcdSW3MlS7p+pruNOdDQLKHH8dfn0lb0
         Ua33VPrJcUNDd7XVK9aQ5Uw/xzxldG2oV1+cLwQKIVnE30tGhYvhlA4iqcgmOaizodtc
         KCfnPSHq4GqMzUHeHW38h+gqzn6d4uLHsh8qX8UdaKcGbGkJ6UjJTa1bTPHgLcyYgsFj
         p4RmV7OcSxu6Yw8kb0Yfc9OGDPn0Fn0C/zCyVPQo/knOY6Y1Aawy1CTSdomi+ng1JegF
         XF+c+jDD8QjmG4dxyBKNRfQLs4gSPDWgWMZN7bIZj8PeO9cawN/60ROzHo4Kzndjd/nO
         Ws9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765270947; x=1765875747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuHqg+7Vq0O9cbNkZ4a8s+u1ESvqTGu4eYtLE/IsW8o=;
        b=omrUuTFwOH3FVPsztOiXtK8TpyHLjSCXlmZQ3MhwQFF7mLQBjRltWAl9griSz5hVEt
         73sXwRX89zjcsUJpHag43uX+rZ7WJrS29Lpa7/+trtdzX8qAXJdhhIsGqi46+MsN4e9+
         g37tD6GAVxFhMrXr/wZoyHZ1Ks8xcMVbKsvrFPImL+QFr0fBBt76JU53ePndNfl4VshB
         yRaNOZrIzNRkbOUa9Y8Xep1kHhz8w4G/0syZQbnUqZOsuDZnKu/ojjsdYbgYRj3j/Rpt
         qt+LEoB/A2tA59w8TDtVPPuj+XOK74jdq01qV+lO4abuHz4vhPYRA20D6s9EfJMVfq4/
         LnEQ==
X-Gm-Message-State: AOJu0Yy6d6cfj3fkaA+WMnDH2d3fcoCaJRGGohEl7gp1vaCTak8WC47W
	Mx6kqLwJjjKMulYapW/3BNECC5zG01GLdICWIwUE2RUuMF6RyPsrSoTLF7P8jU/ssoSZ7VoD5UB
	csm/JlhOhEPtdeJp9JW06RKUkrQOzvBk=
X-Gm-Gg: ASbGncvUO9Hhn9T/deXqlLCfGDogI+3MkwCfEJvCYNapIWvO49dzZq4ZlT6JpbCLjVD
	Kz1p4dqtT13rMGxOt6rAOdswCJRBCzHmU48R4b6iOU3lP/Edbw3/5bI/FesfzLrHgWhtG9H4Zcv
	ayaiC2DnpOGaHBPHuhlOH/7UB7mXXKEj0S3HS+77VlxrZXHloBjDgmM1xc/tbWMGksQRvisoz5E
	WuWiRxpFl0vtX5FnqsK5D33imLMber7va1+jWfQSGxPpTaKoqHQo6QnQJL8pfUqfksdpIPbQCZi
	IuYBnLuRtCF4JHiIOAyXwpqoGa2MrA==
X-Google-Smtp-Source: AGHT+IH8ON7IuPrcgEVSz1B98BIPRLF4yPppDz7mT6R/oRylXLu5/M8cN0zQAynpUZe5gNFtlRvgDMQHzPT4YZ43bl0=
X-Received: by 2002:a05:6214:4105:b0:880:2c08:88e with SMTP id
 6a1803df08f44-8883dc1e638mr178186166d6.45.1765270946651; Tue, 09 Dec 2025
 01:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20251208223118.374387-2-t.f.g.geelen@gmail.com> <CAJo0Az6wHkTjxxMYTnwbdxhq0VSnnXvDwtXuuRcd=5vy2NQ0Rg@mail.gmail.com>
In-Reply-To: <CAJo0Az6wHkTjxxMYTnwbdxhq0VSnnXvDwtXuuRcd=5vy2NQ0Rg@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Dec 2025 10:02:15 +0100
X-Gm-Features: AQt7F2qSsaTooEwnAYTodC1ZC6ThR0ZmZHJBV9cTJVq37ZG0hfUaH8PGuB_pfQ8
Message-ID: <CANNYZj9O_3P6oUo5b9KnU=dDKJDy3=xdmnDsXPQL=jBc0T07TA@mail.gmail.com>
Subject: Re: [auh][PATCH 2/2] testimage: adjust qmp detection for testimage
To: Tom Geelen <t.f.g.geelen@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Dec 2025 09:02:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2756

On Mon, 8 Dec 2025 at 23:40, Tom Geelen <t.f.g.geelen@gmail.com> wrote:
> This one I would like your opinion on. I have enabled a testimage in
> my local AUH configuration but when upgrading something the message is
> always that 'qmp' cannot be found. I adjusted auh now such that this
> is detected from the image passed via 'testimage' in the conf file.
> However it could also be that I'm overlooking something, in that case apologies.

Can you provide a simple way to reproduce and observe this? It looks
like a complicated workaround for an issue that is not fully
understood.

This particular feature of AUH is not used in the autobuilder jobs,
and AUH has no tests of its own, so it's prone to regressions. And if
I didn't inherit the code from somewhere else, I would just throw it
all away and do a clean rewrite (possibly as a devtool
plugin/command). It barely works :)

Alex

