Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468E3CCD184
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 08:35:03 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web10.6488.1761035700296037131
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Oct 2025 01:35:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GjxRPJ9U;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78e4056623fso68865556d6.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761035699; x=1761640499; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F712l2kV3AgGoachanEt4ZwazTxoaCXmn8VQUmoFkMA=;
        b=GjxRPJ9Uvrbz6GDbyrV1EgPaDfTqVBaT+AQ1cj44yAm2JGm2eprX6jF4zAIi3gH98M
         a/vsYyBvrPPSBE3dZQwaH7ltjgYc1RthPAulz9nXTb6xUyYIckmKVozz26lFFpuCdUq9
         NRNSHVsQQHdbAQ31q0ssxNwRqE0FXihrY9L2W4ni7iGNtbLau9lOvtQn7b28riccHmxy
         /X/Ol48aKdSDhsEdtXBgJNG1CE+YPI8bc6Gj1jVDemXR6lT1TWr3ueFvhayp0AIkbPoe
         tpiR73QtZ9OIFbx636Z4dgI4IyjF1/JPCsHS83ZkuZmm12Ae7VkA9exWD6P48+7syO84
         Ktlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035699; x=1761640499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F712l2kV3AgGoachanEt4ZwazTxoaCXmn8VQUmoFkMA=;
        b=KMnx7/PsD70omr1bzDbzqE/C2ptDl6/hFg2u4z30+hh7HflzgD9QD0NiTZzC6rCTtb
         esKgjKVcH+JfP9T3EuljhtMbcSZJc+0lK1j8VJ7RqusiwOKSqdcJM8VyEEwWuAHBdO9C
         cTETwdFo18ipqV1XwuuPIrRzwYuCCJCHSxitx5GGAfk4GIw++lRoz1kkPbg/VNxSxXPs
         XkOfyLeqNGUvqajeLo6gD5FDZfP+j799rGBzfx9zbvs7n+v/5hteMpUsa91Ge71SFGwr
         d6NiCaU3GSkoJaLhnIeEgTEMSWaXwKaUl9ZjhF7Y2VhNXVwUrx0uORnUISE5Ys3Nzg2r
         rjSQ==
X-Gm-Message-State: AOJu0YwR2ZrbhPMMrvctsO/AL7mRTArKPrJQvzgw/4Jmwc1rDODX8ZOG
	eLqshVdlO7G0v6UmXMxi+UzvY3MyhWBHVIMhzavmzR5OiASZF1HGrylsADfDeEb+yuk1udSmWBI
	AZnVCbLIyer6EcOOniLxYVFntLNhqUYA=
X-Gm-Gg: ASbGncspUtXLdzMSfSYJZJ9rhwgDbiJG6yo3rs24w1QBotcEN1VMIrg9VW3uuUKeeKF
	sOgdJBzTlg6yZdZhyqpDdSnFqIEJhoD70TzkKQGszxev50ZxOAWpFZhrZpJoNC4NqttChdaq6VJ
	zVl4qts0EWuwXxBW+bDA2ge65qt34hIu6P22bVVY5DMPeJrFXEPtOGNu4Ght2eDIW9Y8a7apEFY
	JUawjov9iXyfD01vHv+Ya2YHtUOJs4I8z/79+sq0moQNYW1BEQ2zA5dN82i1w+qKLn/PfxuHLYY
	yck5TAGXAgYcrcqp9LsVp9hhMlNye+L6cNzWyhbcF6XR1Fdg2Lupr/WP3v8pf51Gl7Krh170DcP
	H+53EE7F0GhlhR/cy8w==
X-Google-Smtp-Source: AGHT+IFL/DsHSZXCxN/0Dei3Ob4FKnsAWH+6pwuM40UegWjnsk3BmwueHKYV/lnpgAJnhHTUQP7KBxYdyMC2HNVJiRc=
X-Received: by 2002:ad4:5e86:0:b0:87c:43f0:373d with SMTP id
 6a1803df08f44-87c43f039damr176615236d6.39.1761035699304; Tue, 21 Oct 2025
 01:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102344.645363-1-richard.purdie@linuxfoundation.org>
 <CANNYZj-KXPZ0dOLoHTuVmnZoXtKy0eJ0Rgk8qmm5_FFWfFVcCA@mail.gmail.com> <f886c5f7bdb8b672010393dc4600b83de313fd51.camel@linuxfoundation.org>
In-Reply-To: <f886c5f7bdb8b672010393dc4600b83de313fd51.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 21 Oct 2025 10:34:48 +0200
X-Gm-Features: AS18NWDfSTMUq5K6bHpickhkIxf5EtesJ8DPDOP4Z9qgVhG_s4XNr_L-RGdBNx8
Message-ID: <CANNYZj8+W6pPW0Ac3=c8km0G5OnzvJk1b+BnGhyZRhog_Ouxrg@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH 1/2]
 config.json/scripts: Switch to use bitbake-setup
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 08:35:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2376

On Mon, 20 Oct 2025 at 23:45, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> > This should be in its own fragment, and testimage class should check
> > that the features are in place, and print something helpful when
> > they're not. Probably the poky login banner should mention the
> > fragment too, so that people aren't baffled when they expect behavior
> > from the old poky default template, and typing root without password
> > isn't working.
> >
> > I'll come up with a patchset. :)
>
> I'm not 100% convinced that is the right solution.
>
> a) We've wanted these things explicitly spelt out so the users clearly
> see "allow root login" for example, not hidden behind some "enable
> testing" fragment. This was why we removed "debug-tweaks" and I don't
> really want it to get hidden again for something this serious.

But it would not be hidden. The fragment would be called
'root-login-without-password', and it would always be opt-in, e.g.
testimage and login banner would ask that the user run
'enable-fragment root-login-without-password' and explain the
implications. This is actually better than poky and oe-core setting
the insecure default in local.conf.template without consent.

> b) perhaps some of the testing should configure the images with a
> testing key and /or set a root password? It might not work for
> testimage but it could for oe-selftest for example. Even for testimage,
> we might want a "qemu" key? A local one could work, just a question of
> project release image testing artefacts and how to handle those.

I agree that we need to implement something even better along these
lines, and this is a good moment to figure it out, I'm just worried
that in the meantime there is a serious user experience regression
with bitbake-setup: testimage and root logins not working, without a
clear way that users could fix it. The above fragment proposal could
address that.

Alex

