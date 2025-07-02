Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E175C83F03
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 23:08:42 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.10053.1751497717566913104
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 02 Jul 2025 16:08:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=g4zIqJre;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fad79433bbso46798816d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751497716; x=1752102516; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7I0M4SKkXrgi04Ue44Y+KT7NsEEZAYeLm5ZZgBQkl8=;
        b=g4zIqJreCF/kPq+q8YuYCRHt0gs3Rt4vEnvA+peLEhY1gMfciGIy3EcYXNg7DLIGCj
         iozotGY16gCn64UY8rolcBnehVBINv43uFwVTNUJT6GbZMs4ramDlZMmpsohO7ytnscL
         5JdIcwBNQHwlAXj3g9PZKezYLGsiT0eJgSq00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497716; x=1752102516;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7I0M4SKkXrgi04Ue44Y+KT7NsEEZAYeLm5ZZgBQkl8=;
        b=ZwK9o5Cv/PAGEnr47H+dq96I9y+KjNxvbY1OGBEwesYkBA6mNm5gMGB0eC/9G6MhOH
         K/dPeIjOGWKDD3QgjP0gavNFwotrz0BcAzakuofiJMZ73jD3uUaYnkjXrGY2q/JkQo5+
         PgRZ/hViaAxlP48eCCjxy+TZo9FJXC+ReuHs9131+STAv+C/0c8wCH96gyXMv2KQnu0g
         BrdfuCyidRLhy823bz5mMpFL2Urn61qBLC3MjwBdMnoZV6u9PH6Cit2cZcEYaVf+GvoG
         yfSka9qeX6RebtcVwDEcthu+Vd57ICUvT9xa256UR2y71RDqgz4ocAp9ywnCOM/VJxiY
         dDag==
X-Gm-Message-State: AOJu0YzKWhbu7wRRpH8AjUNx6iFeVBdkvz/vp5ii2tKD84Gte/mrCppS
	+psUyMSRu+DOUOPmjlE/2Atx7EjeGvMnkSeuCL65DPDVEOo7KFPRcmNA3rpD0qmM0gz42o3rO6K
	fGFhS
X-Gm-Gg: ASbGncv8+CsLX/s74XFnTBPBHdPAz7aB8SSh+TfwBcQluf5TDu1eaC8WwMlAob0IjoA
	x2LBWiZ0UTtNLxP9+09P7Fa/yZ9/ut1h/ODADZJYJZnx9Dv+gcQjBjcx+J2JIt/tzWSSzEIAQx5
	XfiIcBBNK2NyBnVAiweCdbRibOIpVaVRMVSIS4x6IVcgH/mHP6SLS2D8zamU291zG3d1fbmUjQ+
	gFu6dhaRbpw0uOXAxRg/ioVQCGsXOpMFfJ3VMesndBQnLIJ/2jtjzSGt0vTS7Ad3gRQGfh8T7pV
	fgUyB/JcuqP4+AD5VHhZ4k+nzZu1kyMxbic7CGTFVa041sP0yxNoglCxvMKDaVbH7aW1K2mDa6k
	mSrCRhKnvoc2AtkYjrije
X-Google-Smtp-Source: AGHT+IFNFgf3upPhl9g5U9FSD1JWPA7o1ZD/xH0wWXYw8ir0PUaRxyuJQCT7sn+PnFikT1FSyXKo6w==
X-Received: by 2002:a05:6214:2524:b0:6fa:faf7:7545 with SMTP id 6a1803df08f44-702b1bdb68fmr72114796d6.31.1751497716281;
        Wed, 02 Jul 2025 16:08:36 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd771d9c00sm107476126d6.48.2025.07.02.16.08.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:35 -0700 (PDT)
Date: Wed, 2 Jul 2025 19:08:34 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 1/1] Update maintainers
In-Reply-To: <6459.1751475911713660170@lists.yoctoproject.org>
Message-ID: <76551a11-14cc-315e-7022-473d19462447@konsulko.com>
References: <CAApg2=S8PUKMVSCcBdZazNDkxwMLMGjQ2UH4HoebymErpm4mZA@mail.gmail.com> <6459.1751475911713660170@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 02 Jul 2025 23:08:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1739

On Wed, 2 Jul 2025, Anton Antonov via lists.yoctoproject.org wrote:

> Hello Martha,
>
> Thank you for checking the patch.
> I don't know if you already started running pipelines for
> meta-security. Armin used to have jobs building security-test-image
> which also includes Parsec and OE QA test suites for it.

The CI setup is still something we're discussing, but the plan is to keep
doing that testing.  It is possible, however, that we may merge some of
the more immediately required changes for whinlatter compatibility with
just manual testing for expediency.

Scott


