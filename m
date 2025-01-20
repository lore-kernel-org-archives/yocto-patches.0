Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B6DC02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 19:01:25 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.web11.43734.1737399675726444185
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jan 2025 11:01:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=n3wFUlz9;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d88cb85987so42434766d6.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 11:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1737399675; x=1738004475; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SC1c3bWDVhqixDb0C7ov/NXvntyGEA7HfnUJvzSjmlY=;
        b=n3wFUlz9/zwYarPyHpe45x9cZnDPHPQprmQUrYiuzLdlHRDR1AZvh4P/MpTShArUBQ
         pW9RwZ2U9w+KfOIiOUAKkxWd89zoO1uBw9MO96wr8QtTaiQstgJab0Up3qQSmWdPqqA2
         tOSeqM6mS9AUSn5Rev0dEta1Yx/0cgOaIVFWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737399675; x=1738004475;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SC1c3bWDVhqixDb0C7ov/NXvntyGEA7HfnUJvzSjmlY=;
        b=eXufNFEjlXSveaoAFF0qwROPtvm4zmV3pPnaqoQWg/AKBBhDIwb7SvwMuztg/Er85O
         j7j7fpqAN0/VipAnUwSMbDtprKoGRKa4aQia9d1hyLFIHnoMUg0MepSvSKhUP7qpk9nW
         N2nB+4GZZjIOBC+FHyS54BSmPjgi1TaaybkmdkjdC9yjSnvopY7oZw6z4ckJlMm2M9EB
         VEqSVtTTYXJ3BGQcsy2+KgM+svS7DsPSQCy+iJVC9q1tqVRRa3VqR6aN2+/WZe13bDtI
         BMOv7uRFKnWqsrmQ8bPj0By/VJ5rkyiDnXtwTqNvggcnxX2QrIjwYQmuChNIPHDBmIoe
         kMgw==
X-Gm-Message-State: AOJu0YwLeJ5Nq0QEmQEXiuMaJKvYyMx2XU/KlLbP3NSXa29IJdAv0dgH
	cEE+QYfJEjTWxvxutb/s11AzRfpePPQRU/vUAzlhTW0cmgdnbQ2nzCjZX1lxdNwwsf/aY6Vmx2F
	1
X-Gm-Gg: ASbGnctLGGd0sHM3W31UWylv6wyVag6kuQwNlmjdwoFf5DTEbVfBFvSxh9hYSZbfBeB
	DoyeTP0kftQoGRup5JhZWoMgjRmpJFjoaPcMel32l0Wx3wR8RzGz8mSbMztdmclIoWBdP5AKpva
	D1pGAaOjx7aMSa2PCnzG+gPXdxjnRzuYAmqruy470a61PTes8BTRaz5XmXfnaXmQ/tVh2rxQd+k
	8TfHw83P9XpU24KsRr9VCMh0M8lpnH5akuTzJ1T985P6kTP4RxykM62T8cqKzBxoKGlqncJpfT7
	5QoahsushZKhKQJiLp8g3Vd4G1BQ
X-Google-Smtp-Source: AGHT+IGJPt/JjN5beZInlyNB+XGuBzfaNYx/0ZBFTfxgPhFoE/4UutIg5Vds4WiUodqPAehq32hu+Q==
X-Received: by 2002:a05:6214:486:b0:6d8:e7c9:ffa0 with SMTP id 6a1803df08f44-6e192c73ef5mr320971016d6.19.1737399674628;
        Mon, 20 Jan 2025 11:01:14 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc111e3sm44073546d6.43.2025.01.20.11.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 11:01:14 -0800 (PST)
Date: Mon, 20 Jan 2025 14:00:58 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-lts-mixins][scarthgap/rust][PATCH] classes: rename to
 classes-recipes/
In-Reply-To: <20250120165117.737681-1-enrico.scholz@sigma-chemnitz.de>
Message-ID: <1f6cdeb4-c868-e32c-4372-123371eb4b12@konsulko.com>
References: <20250120165117.737681-1-enrico.scholz@sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 19:01:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/989

On Mon, 20 Jan 2025, Enrico Scholz wrote:

> From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
>
> bitbake looks first in 'classes-recipes/' and then in 'classes/'.
> Hence, content had no effect and was just ignored.
>
> Rename folder so that it overrides the OE-core classes.
>
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
[snip]

I'm pretty sure this is incorrect.  bitbake does look in classes-global,
classes-recipe, and then classes, but that does not matter in this
instance as it is iterating through BBPATH at a higher  level when
searching, and should be finding the mixin layer first.  Running
"bitbake-layers show-overlayed" here (see below) shows the expected
behavior, please try that locally to double-check yourself.

There is likely a case to be made with respect to easing future
backporting that the classes can be moved to classes-recipe now, but
the commit message would need to reflect that if you still want to
bother.  I am going to work on backporting 1.81 later this week, so
I can do it then myself, perhaps.  The small incentive for not doing
it is then I have different workflow for the kirkstone and scarthgap
mixins, so I'll think about it a bit.

Scott

--
[scottm@ghidorah build.scarthgap]$ bitbake-layers show-overlayed
NOTE: Starting bitbake server...
Loading cache: 100%
|##########################################################################################################################################################################################################################################|
Time: 0:00:00
Loaded 1979 entries from dependency cache.
=== Overlayed recipes ===
aspell:
  meta                 0.60.8.1
  meta-selftest        0.0.0.1
cargo:
  meta-lts-mixins.scarthgap 1.80.1
  meta                 1.75.0
cargo-c-native:
  meta-lts-mixins.scarthgap 0.10.3+cargo-0.81.0
  meta                 0.9.30+cargo-0.77.0
librsvg:
  meta-lts-mixins.scarthgap 2.58.2
  meta                 2.57.1
libstd-rs:
  meta-lts-mixins.scarthgap 1.80.1
  meta                 1.75.0
rust:
  meta-lts-mixins.scarthgap 1.80.1
  meta                 1.75.0
rust-cross-canadian-x86-64:
  meta-lts-mixins.scarthgap 1.80.1
  meta                 1.75.0
rust-llvm:
  meta-lts-mixins.scarthgap 1.80.1
  meta                 1.75.0
=== Overlayed classes ===
rust-target-config.bbclass:
  meta-lts-mixins.scarthgap
  meta
cargo_c.bbclass:
  meta-lts-mixins.scarthgap
  meta
cargo_common.bbclass:
  meta-lts-mixins.scarthgap
  meta
rust-common.bbclass:
  meta-lts-mixins.scarthgap
  meta
cargo.bbclass:
  meta-lts-mixins.scarthgap
  meta
cargo-update-recipe-crates.bbclass:
  meta-lts-mixins.scarthgap
  meta
rust.bbclass:
  meta-lts-mixins.scarthgap
  meta


