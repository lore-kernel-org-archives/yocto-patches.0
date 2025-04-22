Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C2EC369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 10:31:45 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.36742.1745317904171857382
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Apr 2025 03:31:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fU0TwvbR;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c08fc20194so192801085a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Apr 2025 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745317903; x=1745922703; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ERQGpL4TXimdvqYfcjCtH4DNxM1TATsh6rfLIF5FU2E=;
        b=fU0TwvbR1LfeWHpXNPPC/itMwx0mU6ZiNllVDpvjbVmiIM/cGwTTqHwRDEdqa/slg1
         ckVzJ6jwyTJeeqGFJkadSeSQ7jJgXcWWYS/5l2VrBFA2GapQQlYa+sECt0HRnL691SBs
         uN2Lu/ehpqOXvpeU5YAL+iySC7b0Sx99SPXWJzjfzbWwBuMNFM9Caoasu0A/vDPcFL/W
         It0uKk9nELfAf5/SPLNdSku6J4N5HvOg/itGan1XAQ42p9AAm4gWo1L1qHl49pbp58Oj
         28+wDBeFPHstta7qPelhzbetlKENSrvU00ZzWQ9MCH/VgS1sAxWtpWNIf2qTPiThp1q+
         YD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745317903; x=1745922703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERQGpL4TXimdvqYfcjCtH4DNxM1TATsh6rfLIF5FU2E=;
        b=UNxnLMNd+n54XszVm6h679EzQg7DL8hyHF1jMwERIMStsQmOmhmeqCKnSPx0VavWnX
         WNBW9JF2XQybNOonzoXHtzvEUH2IJJLIfwoYStA5JTzSAQw/Wt7+gkfJaFJgWhxXZQ3E
         IhUNdgw5sdv32E8iiO4804ckjNTwRMZywstrO2NCJWgxCR7xr4JWojUxv3eNd1II17zg
         3tmnMVOWMVTPo+9cs/rUUlLBJ0K8b5Tu8dcMNX3nD0SeTx6kmKnSy9OUH45Rx8pqKq07
         SFfnWkHxOef3EgR0mtzwhk8NVhYp7LIFAtrpR6HkwkzvrokiTDwfnnWVjNjbAumt8qMF
         G0mw==
X-Gm-Message-State: AOJu0YxH8rNq8/E5C6m5l8Wnjho/MU5z0cK1iMyXmA/3ivYohuvAhYyN
	JhPzdoDJhjPmKLrQgeVIxdjfclrzNbOSsFvUyRr/H+I3uaxbXWMMfm5JqTtnsGfRjjbbxU1NWtJ
	XvyJ96fX8lhM6eKmTRAe5iGjvQ7j7fw==
X-Gm-Gg: ASbGnct/XRPOPG9L4V8YwF0pbRXHOpLeT699Z9ksnQK2dL/nq3FafeRqyas42OP15n8
	apTEF5yaZlUDku7ML4fXtpA5gkITTj8R9vH4gqk5DsaMWbIw7/lsnv51bY9QTydm6zCI0YbDNFZ
	ovmodJpTzixRPI98Om1TOH7UKEEs9YXVf0SRbWSEIdcdMniZTlYxoNOej0
X-Google-Smtp-Source: AGHT+IFfCF5hfEuOWssQSixwTCowPIHEa4Y0Dkb6lOl7cfez/cLl7aiNYqRjvZl6s7B49f48atCL8HKG+UhiWZ0r6cg=
X-Received: by 2002:a05:6214:5cc:b0:6f2:c9e1:8511 with SMTP id
 6a1803df08f44-6f2c9e1f24dmr174630506d6.39.1745317903232; Tue, 22 Apr 2025
 03:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250417160709.3581248-1-oe@myspectrum.nl>
In-Reply-To: <20250417160709.3581248-1-oe@myspectrum.nl>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 22 Apr 2025 12:31:32 +0200
X-Gm-Features: ATxdqUHh-ROuF8jyk0mm3m_mhCcrtjuDMDEfqVz93E5iNHByx0jj16HuyFzm2Jc
Message-ID: <CANNYZj_oy4D-2v6tn+gn2rbvKZ3ZRG=ROvVkvFpRdVk63OqvRg@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/go][PATCH]
 conf/layer: add scarthgap as compatible
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@foundries.io>, Jeroen Hofstee <jhofstee@victronenergy.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Apr 2025 10:31:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1398

I think there should rather be a scarthgap/go branch. Listing multiple
yocto releases in LAYERSERIES_COMPAT is not a good practice.

Alex

On Thu, 17 Apr 2025 at 18:07, Jeroen Hofstee via
lists.yoctoproject.org <oe=myspectrum.nl@lists.yoctoproject.org>
wrote:
>
> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>
> Scarthgap shipped go 1.22, which is now EOL since the release of
> go 1.24. This adds scarthap as compatible to the kirkstone branch,
> so a newer version of go can be compiled for that release as well.
> While that is a bit mixing releases, that seems rather applicable
> to this repository. Add a note to README that the kirkstone/go
> branch is compatible with both.
>
> Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
> ---
>  README          | 7 +++++++
>  conf/layer.conf | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/README b/README
> index d0b6bc4..b12c360 100644
> --- a/README
> +++ b/README
> @@ -5,6 +5,13 @@ and officially Kirkstone supports only that. This thin special-purpose mixin
>  layer is meant to address this issue by backporting Go recipes from the master
>  branch of openembedded-core.
>
> +A the time Scarthgap was released in April 2024, Go 1.22 was the latest version
> +and officially Scarthgap supports only that. Since the branches for Kirkstone
> +and Scarthgap would be the same and they are supported till April 2026, the
> +kirkstone/go branch is marked as compatible with Scarthgap as well.
> +
> +NOTE: The branch name might be subject to change, especially after April 2026.
> +
>  The patches can be backport from openembedded-core with:
>
>   git -C ../openembedded-core format-patch --stdout -1 origin/master meta/recipes-devtools/go | \
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 5d1b19f..30a0e00 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -8,7 +8,7 @@ BBFILE_COLLECTIONS += "lts-go-mixin"
>  BBFILE_PATTERN_lts-go-mixin := "^${LAYERDIR}/"
>  BBFILE_PRIORITY_lts-go-mixin = "6"
>
> -LAYERSERIES_COMPAT_lts-go-mixin = "kirkstone"
> +LAYERSERIES_COMPAT_lts-go-mixin = "kirkstone scarthgap"
>
>  LAYERDEPENDS_lts-go-mixin = " \
>      core \
> --
> 2.43.0
>
>
>
> ------------
> Links: You receive all messages sent to this group.
> View/Reply Online (#1378): https://lists.yoctoproject.org/g/yocto-patches/message/1378
> Mute This Topic: https://lists.yoctoproject.org/mt/112316185/1686489
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13197349/1686489/315264618/xyzzy [alex.kanavin@gmail.com]
> ------------
>
>

