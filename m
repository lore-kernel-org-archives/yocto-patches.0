Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F230D462B8
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 14:46:22 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.web10.13437.1731509181610355448
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Nov 2024 06:46:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LVS6y2X9;
 spf=pass (domain: konsulko.com, ip: 209.85.160.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460e6d331d6so43284961cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 13 Nov 2024 06:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1731509180; x=1732113980; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SmbJ1tDov7AHXmfMi6CoYvc46lB38LfTTyBrK+ucL7Q=;
        b=LVS6y2X9yDHN+zFTj9Jkk7BmHd2UEnkvxdDQmcmlbrtvdq0yEiXy/gkqYhCeyEE5gf
         pyVYsBqF0yOmohG0pGCVgVpvq80hfyi8wjfQ21/HQwi+CEXaxhH57dg6N28iYYo3M30Z
         v+4PL8wM/AOlslf8aU4PJnA7A5MMsWaZa7tbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509180; x=1732113980;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmbJ1tDov7AHXmfMi6CoYvc46lB38LfTTyBrK+ucL7Q=;
        b=NZcXISeugIJKCQTzn2c4H9lp+P8JmkfYX4gEK6EBMF3FhQkO9Dhgir7Wp9hGR/1/FN
         OyWJackU3KYmcz6ZfDxJkLrZE7nXgQZyYbobB2myA3IzgD84MhI/MSpJDHT2YrAnWdMt
         S0CzfxBuPwjqHz88CdOBKc4UbbTZXJj+RU6lYZ21pSEZSILCjLRoQd5P41ZBDAEKbUul
         UqRhkWTnsQS4WWR+Vt14qOq+/tWoC2vaCEv9JMP5Vu2J43mTxAThf4yPy8Rvhxusjzm9
         +i8UAo43QlyCqxsxC2DhDC4f/zu0vi9aZFRHB9l8OfCcFakb+S8DMTUE/XC85Xw9uurl
         Q6bQ==
X-Gm-Message-State: AOJu0YyjINITB8aXv/cE1SxgFXZiU9S7rj0TpAwxaHvEQ0TxANYQSR9Q
	MZ/Py7/yeFH1XqPRIrxiLb2kXwcQ7J07NzqqCR36lyFTCRiEmtFbMGTXn+W//sY=
X-Google-Smtp-Source: AGHT+IEmmhdRu1RX3/fsGLlDeVZw6Lc/Mqk6HeZ8xT6dGhRQL6CuKE5jCLhWhmnvBaSzpRJbagyggg==
X-Received: by 2002:a05:6214:5c4a:b0:6d3:5ca6:b3f6 with SMTP id 6a1803df08f44-6d39e1f1f5fmr250551076d6.45.1731509180628;
        Wed, 13 Nov 2024 06:46:20 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ecc85sm85430916d6.39.2024.11.13.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:46:19 -0800 (PST)
Date: Wed, 13 Nov 2024 09:46:06 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
cc: yocto-patches@lists.yoctoproject.org, quaresma.jose@gmail.com
Subject: Re: [meta-lts-mixins][kirkstone/rust][RFC]Release/branch
 kirkstone/rust-1.74
In-Reply-To: <f379ec20-6a31-4dfc-a524-21a7f06b709f@collabora.com>
Message-ID: <44086b2b-aa3d-160e-adec-2ee8c7f93f9c@konsulko.com>
References: <fd647dcd-fe6d-4e7e-ad5e-983aca24c086@collabora.com> <f379ec20-6a31-4dfc-a524-21a7f06b709f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Nov 2024 14:46:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/797

On Fri, 1 Nov 2024, Ariel D'Alessandro wrote:

> Gentle ping :-)
> [+Cc Jose - as I've seen it active]
>
> Thanks!

Sorry, I've been away a couple of weeks on vacation.

> On 10/25/24 1:54 PM, Ariel D'Alessandro wrote:
> > Hi Scott, all,
> >
> > Question regarding `meta-lts-mixins` layer. What's the criteria to create a
> > branch pointing to a specific rust release? Apart from `kirkstone/rust-1.68`
> > and `kirkstone/rust-1.70`, could we also add `kirkstone/rust-1.74`?

When I created the existing ones, it was to track the version of Rust in a
specific YP release, but given how quickly the Rust ecosystem moves, that
eventually started to seem not that useful, hence the switch to the master
following kirkstone/rust.

> > We're currently working on getting `meta-browser` chromium support bump to
> > verions `129.` on kirkstone [0], which requires `rust >= 1.74.0`.
> >
> > Of course we could just put a specific requirement using a commit hash for
> > the required version from `kirkstone/rust` branch, but it'd better to have a
> > tag or freezed branch instead.

It would likely be better to target 1.75, since that's what is in
scarthgap and will at least see some security fixes for a couple of
years.  I spoke to some automotive folks at OSS EU that described their
requirements for supporting Rust code on kirkstone and scarthgap, and I
did tell them I'd consider a kirkstone/rust-1.75.  If it would also meet
your requirements, I'll work something up once I've worked through getting
kirkstone/rust updated (it's a little behind master atm).

Scott


