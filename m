Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2907D1951B
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 00:03:01 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36608.1769472175698860387
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 16:02:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IlIU2xS2;
 spf=pass (domain: konsulko.com, ip: 209.85.160.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-502acd495feso60211551cf.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 16:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769472174; x=1770076974; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lepTA0IKYIiqxqIGALn+YYAIvUuL5RfEHywdP8XoRHc=;
        b=IlIU2xS2P4mZggy3HmqedtgD6/AqPsGjNvwdKEKUePb3fDN4y/9Lfc/CoRguPmZlDA
         rOXb/gmfhNVKk3/EgNIMCBaBHQCW4LSNICWe4BCkyE65yMDuOsyU5eUfOi3XGlRojnPd
         5eRjiPpecl+acSaKrSOeAb3h3nmhDe8+8kYfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769472174; x=1770076974;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lepTA0IKYIiqxqIGALn+YYAIvUuL5RfEHywdP8XoRHc=;
        b=Z/u0OgGxcwKdDrk0XiFDtfctsISSwam8+MZIgw6AHQ5EdqrD3Xd8/mGwDxaW/5KOFP
         qs5vCr+AK7allhPPc1dJtHVzgXt1utBq3nYvA+APpuloFNZaKapujdcPC3R1BMI5WOR+
         sYC+3Douqz54EfSpno/lVqOhj9HNUGRPMc+rUV4yaE0fwXzta6ahup0VWdah5U93mhWZ
         oeRK9L5na6F8mItIxv7/3a2QSfsbRb6WB3wtXvw1CuRgBIajR2vIuqkiCrPB1QdEi8Yn
         sP5FOPBH8myubjSiQWyLuD52SqTCGSX6E6YJpPuWXUQ2sSlGGP4/Jer1ZEPVdNF28wFC
         TVsw==
X-Gm-Message-State: AOJu0YxrmocdhK2TopjqzA5QN67p7aUnCusdLGaJflH/JCUlyGkBk0gJ
	XpGfw5IcG0Rx5+fz6VzaQAfbS0Yecgzi8RECYuSAhayz7zqVTcsOeOUTwFzQYjwPGJn61qTyxWK
	CXswOJ6M=
X-Gm-Gg: AZuq6aL/q7X1mM2UrZLpHmXJa71wAPY53NgVN0oOnr35ZzFdnJ+mz13VVQ8hB/yuoFc
	nxfalvnr83XTyuW3IXdUJByXMeBq7XImQzatW9gWWq+iiD1uNveUNNDaCgrt1gvTItlqAzLnHss
	Kd5GFrniab/rw3HgPnuVO9kfT5KCf98PK/6GDqthUEmypusMfDetlWGBpFMwDtjCWC+wx+ldTqO
	SnVX/KY3CKsMPuskkXMAow82ByWZb9jlK9X1Ahn5prw37O6d5wdfRVuuQS8XFQj3vI7Wc0CNvov
	9bPrebBq/I6JAI2Ri8JJpHYd70v/tn0Publjrc9J2kQU9kMEKVA+rz71UkD7uGfjTe1FYtNQiGt
	zK7NG5z2QrNOQ2kIHq2CKI3ZaMAMc2brnR1MOfi3CVKZMGgZffuqq/QD4fd/y2Xz6jvaf7+0M4h
	J1RW2TltwCAGOsqcppaMBKBfVe8MsIPf/wuXGXwq5oDkHv3UlZ5MjAJhdWA4N3IdGS7GH3ZENVf
	4gLtDGYdYtr1WrBojfcCpwJui4BlXO6Drk=
X-Received: by 2002:ac8:5981:0:b0:4e8:b446:c01b with SMTP id d75a77b69052e-50314c690a1mr82062981cf.61.1769472174234;
        Mon, 26 Jan 2026 16:02:54 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e38700d6sm1037813885a.50.2026.01.26.16.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 16:02:53 -0800 (PST)
Date: Mon, 26 Jan 2026 19:02:51 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Tobias Burghart <tobias.burghart@rohde-schwarz.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH] rust:
 Upgrade 1.90.0 -> 1.91.1
In-Reply-To: <188CD18DBADE1EE2.3547823@lists.yoctoproject.org>
Message-ID: <d0d17e58-b7dc-7bcf-5717-762a67201278@konsulko.com>
References: <20260121105245.3978691-1-tobias.burghart.oss@rohde-schwarz.com> <188CD18DBADE1EE2.3547823@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 00:03:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3113

On Wed, 21 Jan 2026, Scott Murray via lists.yoctoproject.org wrote:

> On Wed, 21 Jan 2026, tobias.burghart.oss@rohde-schwarz.com wrote:
>
> > From: Tobias Burghart <tobias.burghart@rohde-schwarz.com>
> >
> > https://blog.rust-lang.org/2025/11/10/Rust-1.91.1/
> >
> > Test results summary:
> >
> >     rust v1.91.1
> >     +-----------+--------+---------+
> >     | Machine   | Passed | Ignored |
> >     +-----------+--------+---------+
> >     | arm-32    | 29,968 |  1,510  |
> >     | arm-64    | 30,071 |  1,447  |
> >     | x86-32    | 29,985 |  1,489  |
> >     | x86-64    | 30,229 |  1,247  |
> >     | riscv-64  | 30,045 |  1,472  |
> >     +-----------+--------+---------+
> >
> >     Test results difference (1.91.1 - 1.90):
> >     +-----------+--------+---------+
> >     | Machine   | Passed | Ignored |
> >     +-----------+--------+---------+
> >     | arm-32    |  +451  |   -19   |
> >     | arm-64    |  +463  |   -24   |
> >     | x86-32    |  +477  |   -18   |
> >     | x86-64    |  +326  |   -28   |
> >     | riscv-64  |  +461  |   -22   |
> >     +-----------+--------+---------+
> >
> > Signed-off-by: Tobias Burghart <tobias.burghart@rohde-schwarz.com>
>
> Thanks for these, but my plan is to catch up to master (1.92.0) with my
> backporting process in the next few days.  I had hoped to do it last
> week, but got delayed by some meta-security updating.
[snip]

I've posted my backport patch series to catch up to master for both
kirkstone/rust and scarthgap/rust.  If you for some reason actually
need 1.91.1 instead of 1.92.0, I did run oe-selftest for all the
interim versions on scarthgap/rust, so it should be fine to just
point at the 1.91.1 commit once the patches get merged.

Scott


