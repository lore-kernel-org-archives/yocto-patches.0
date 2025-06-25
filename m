Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67C4C77B7C
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 15:10:50 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.17879.1750864245220142291
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 08:10:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mUyUO4z2;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fadb9a0325so191846d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750864243; x=1751469043; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B74qk582Zu1+kFRmey7Z1IhZcSrCDNEGqESia/6Xo3g=;
        b=mUyUO4z2jOJzrAfxmEko0d3fCC+BINIFz1u3Ly65pioYSd7FBL4va0zpSxfFj8dB9X
         GFNOPQTjSNchV2DTxGFFAWiucqFH1DKAfFUfJaRo0tMa1gEKpOS9QZ3GBLxh4OEtg8Bx
         YHF9VB9iwyDtmeqmVhiC4IfziXSU8DZGuUupyVkE2U+bEK2lPAhO4DVmbU1EI1X1r4WR
         3v5l6AEUu+WhwJd3DozORk/kECP1/Jr+JGJxWMzLGVOjMoJiCGfbKx/jF1n5ToBt02eO
         /WC4nD2Uk9kGlf3mFxsuwDL10y1dBTFUGkCf0tLKnRe+952IHQSupY/OtvD/OnWW+aEi
         /SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864243; x=1751469043;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B74qk582Zu1+kFRmey7Z1IhZcSrCDNEGqESia/6Xo3g=;
        b=D0huItWuZwixm+KwZot3qG9l0VudQ0pW8TsGv9JCPiEnLnnN4Cj+6Be2biefjB6MQ6
         moNZ9eQ0my0xSulUexhwW9c6bLwuw55jzVH5ibbvb4Mv2Fsf26/sWzPzjm16HEKP7Z64
         XHCosQOkIWlUSmuSXSw0mMAISwykdHA4QPIeeomGozUZUmFhw6ifjdfgV/uN8B5itNaJ
         4lmeD6NKQeGGvg9jdnigsidd0TLHyTDEz4WicH/gKQa/YHdmo4eYPhXN/Seq7Ky7+2OD
         0pOkF+/jaNH3Ib8lcDIano/oGx6P7WPekFiMdUKyNeq5joDF+MkafYSsPPYKyazIY/jG
         bqBg==
X-Gm-Message-State: AOJu0YxvnP/E/35Ayx8K1NwZ78KiMSZokE6D9DL1VqdQ7PJKMwy9wucj
	gPuvpAOGeL/paxQmI6WJfDWj6u+RrIccd1Pabx+CVnYucuf4U8a+mmEBLl/kF/nn
X-Gm-Gg: ASbGncsjbs4FUXEG9FVIJJIGHdmzwF4FymFv9j+/E0bCoZf1FIZohGJbnOOOlKM6Jc5
	G6RpaK52Tn77+KtQZxAwIH4nnKpXx6pYaY+WI9ezoEyx+9tywoP3+f6/CC3ViH42Op/SBzdldsw
	tx3k9pA3a4fQpxeKvLsA3xQbgfwlZWyuus/F1afShcNJpQ3ANDmIi1GriCL2swaDqctUZWFOjj0
	Bvfb8w2mIsPJWHCixVuxhofM1PLSqJoXabarzbWeNYj8/xGQVwCrJQ3ybG0YBF3kpD7BtbzQDvM
	0avfHATP9dhYLOudtCiXy1CSEbuqrABi7F9YBhnTuDzzcLF8EmQyfvy72lXAFA97IOpGA40AiP8
	YI8ISVV5exXs1LQ==
X-Google-Smtp-Source: AGHT+IFP6dDizmVS8hBddqv/fXHn2/NjaxJrHyCUGxhuqDB9QE+J8PjEraTaGgrPoQpXh2KS0w5w8A==
X-Received: by 2002:ad4:5d41:0:b0:6fa:ccb6:603d with SMTP id 6a1803df08f44-6fd5ef75c17mr54222316d6.16.1750864243040;
        Wed, 25 Jun 2025 08:10:43 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09538227sm69379196d6.72.2025.06.25.08.10.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:10:42 -0700 (PDT)
Date: Wed, 25 Jun 2025 11:10:40 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] remove S = WORKDIR/git
Message-ID: <20250625151040.GA22422@localhost>
References: <184C519C86ED12D8.823@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <184C519C86ED12D8.823@lists.yoctoproject.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 15:10:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1690

On Wed 2025-06-25 @ 11:08:02 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> oe-core sets S = "${WORKDIR}/git" and will now fail if recipes set this
> explicitly:
> 
> 	ERROR: rockchip-rkbin-tf-a-git-r0 do_unpack: Recipes that set S = "${WORKDIR}/git" or S = "${UNPACKDIR}/git" should remove that assignment, as S set by bitbake.conf in oe-core now works.
> 
> oe-core: f80c07019dda ("meta: remove S in recipes that fetch from git via setting BB_GIT_DEFAULT_DESTSUFFIX")
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-bsp/rkbin/rk3308-rkbin_git.bb | 2 --
>  recipes-bsp/rkbin/rockchip-rkbin.inc  | 2 --
>  2 files changed, 4 deletions(-)

...should have checked the mailing list before sending, lol.

