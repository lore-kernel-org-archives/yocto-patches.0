Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B5DC3DA4A
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 14:57:07 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web10.70496.1722524218939001359
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 Aug 2024 07:56:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=T7Fb67Nr;
 spf=pass (domain: konsulko.com, ip: 209.85.160.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44ff7bdb5a6so36448301cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 Aug 2024 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1722524218; x=1723129018; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSlYd+gKqJwNrw8tVMLlm4BVvveP+w44Rpr4TwvUXHQ=;
        b=T7Fb67NrZmd6Abrbukn37jFUNOStJ62ySF0wnvmeOPOaIcdEZowK93viyqzFp1YTuA
         P6swR5XkFZRHYAIDqNs97rj8BKv7TWI+BF9WTzYVGaFdUEYil7xG8vzx9V01rdFMP2ua
         jmTHV0D8G7x2yS4p/v+WZAF33fE9i7s/Ab6iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524218; x=1723129018;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSlYd+gKqJwNrw8tVMLlm4BVvveP+w44Rpr4TwvUXHQ=;
        b=D7ABfzvuqGNICZ9xMbEVuA1dgFo7+FuxKrWk75bkaCN2ABFP26yFJZTFgZOEfr7wtc
         ZBzhV+X1iCt93/6JrnurjdTM1P/xUZZhzzKM/Y1eIKjCxg0/aHDCLLIOxHp4b/BLrV6i
         NFJi/+WWfTH8LFG7xUmFg+h02ogsh2LmqrhGViMoAqqLS6acimcnVNjIeOmyX8y45dLJ
         NIcoRDVzaU4xDcfLO6M+fGH6CMtvSnWxzT3K/6tzevqmkzTu77WQiJ5m0k8rcfj1g+Gi
         lK4VV4BKjXt0TD0uXREXA322LNDrfYVeBK8Bytcb6W+CPKDt0bYJGpxO3JUWhgOSjt2q
         yjIg==
X-Gm-Message-State: AOJu0YxDqT5yOZGtv/yimRn3r+UEMOk46/vknVFj6SIpOopsAV8jm60u
	ldYwwCienlPsHVhaAOYDjPpEdIPLlaCI3wIF3Esl+EQQ3sWm+4gYloLpkx9gWlY=
X-Google-Smtp-Source: AGHT+IGjNHcXPmjBGYIHFhsxJg8TnRzVaTxfU+nyBUAiopmk3nRoMSB2HQBCeJE1o1BKES6i4yoqfg==
X-Received: by 2002:a05:622a:15d0:b0:44f:9ae7:c883 with SMTP id d75a77b69052e-45189342942mr2805091cf.63.1722524217889;
        Thu, 01 Aug 2024 07:56:57 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe81721bdsm69322241cf.45.2024.08.01.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:56:57 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:56:34 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH] rust:
 Add new varaible RUST_ENABLE_EXTRA_TOOLS
In-Reply-To: <9390f93f-5267-410a-8ce6-3d2cf3d00b0b@cherry.de>
Message-ID: <fa71e03e-a028-b802-1968-d4e98ee27799@konsulko.com>
References: <20240801054452.57965-1-ranjitsinh.rathod@kpit.com> <7208a42b-4309-4216-ab64-16a5a82eced8.a73bd9c8-8cbe-42e2-876b-4c548d837fba.d5bb5bdf-1b28-48ec-b886-7c4fe3dbdc1e@emailsignatures365.codetwo.com> <9390f93f-5267-410a-8ce6-3d2cf3d00b0b@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-1692820133-1722524217=:9538"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 Aug 2024 14:57:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/510

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1692820133-1722524217=:9538
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 1 Aug 2024, Quentin Schulz wrote:

> Hi Ranjitsinh,
[snip]
>
> On 8/1/24 7:44 AM, Ranjitsinh Rathod via lists.yoctoproject.org wrote:
> > [You don't often get email from ranjitsinh.rathod=kpit.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > There is a need to enable some extra tools from the rust for the build
> > and so this new variable will help for that
> >
> > This varaible then we can use during do_configure task to add overall
> > values as per json format in build -> tools
> >
> > Signed-off-by: Ranjitsinh Rathod <ranjitsinh.rathod@kpit.com>
> > ---
> >�� recipes-devtools/rust/rust_1.75.0.bb | 6 +++++-
> >�� 1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/recipes-devtools/rust/rust_1.75.0.bb b/recipes-devtools/rust/rust_1.75.0.bb
> > index 76e1fe2..c33f31d 100644
> > --- a/recipes-devtools/rust/rust_1.75.0.bb
> > +++ b/recipes-devtools/rust/rust_1.75.0.bb
> > @@ -70,6 +70,10 @@ addtask do_test_compile after do_configure do_rust_gen_targets
> >�� do_rust_setup_snapshot[dirs] += "${WORKDIR}/rust-snapshot"
> >�� do_rust_setup_snapshot[vardepsexclude] += "UNINATIVE_LOADER"
> >
> > +# there is a need to enable some more rust tools for the project
> > +# We can extend a list of more tools via this variable
> > +RUST_ENABLE_EXTRA_TOOLS ?= "rust-demangler"
> > +
> >�� python do_configure() {
> >������ import json
> >������ import configparser
> > @@ -141,7 +145,7 @@ python do_configure() {
> >������ config.add_section("build")
> >������ config.set("build", "submodules", e(False))
> >������ config.set("build", "docs", e(False))
> > -��� config.set("build", "tools", ["rust-demangler",])
> > +��� config.set("build", "tools", e(d.getVar("RUST_ENABLE_EXTRA_TOOLS").split()))
>
> It seems like the demangler has been removed in master branch of
> oe-core, see
> https://git.openembedded.org/openembedded-core/commit/meta/recipes-devtools/rust/rust_1.75.0.bb?id=58eaf2ee6c0809bf0a0d3c1d177e62bda7241651
>
> I don't know the policy for this layer or branch, but it's possible that
> a change that would benefit the latest branches of OE-Core/Yocto should
> first land there and then be backported to meta-lts-mixin? I'll let the
> maintainer confirm or not :)

Indeed, I won't take this change without it going through master first,
as I'm trying to avoid carrying extra changes that could complicate
backporting future Rust upgrades.

Scott

---1463811583-1692820133-1722524217=:9538--

