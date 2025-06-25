Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52AAC77B7C
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 15:53:20 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.19024.1750866799041254302
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Jun 2025 08:53:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=i1qtbxKE;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6faf66905adso664036d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750866797; x=1751471597; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6zH/rZCQWu4glVJdQtYA4qtKx8rydGdfp/mxN6raX8=;
        b=i1qtbxKEBdbFFuWB95eblaXZkhDj8WYhdSKgRU8QXuBCG+75KvaK5HoMkB7z8w3FDC
         WoGvbIRAJtS5eZV2KAs9HXZ+HYryIsIaFiyifnC6sR+UaBQg7gLoC8gPt6NFsT7e1TN6
         SW/IbFAY5CMod5wG86VGq1pdXSUAzL/FOxwgilLF2l7hNcP9pcsbQmTjL6iyzs6EhJID
         O/BnbYN3Lu9W2Za6wUV3AMiu8UJXafBWfhB5pATlHyGgFKLclAH6nukQ2uzLYrbn6gKr
         unKbAvs/+e3JH8fwlkQT3GqH5zHKlj6vv8KPes7vTvL+MTuR2DzlJhs2u5fy9H9FZXWC
         QnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750866797; x=1751471597;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6zH/rZCQWu4glVJdQtYA4qtKx8rydGdfp/mxN6raX8=;
        b=kHfQ0ELqX4qjzlZ3ZSiyZfDX67iJsvF38WICc2BPmyP5jmES4dBkau4Tp8tQRg2y8R
         Ij0E4bVpEYueYlF7XaOBbx8IHLHB+aPywoI8vVFmp59q3WybBqHDRwn0amTuWMomiTbI
         8DhfEMsLBST7JghiVre2xaAhHzAI5gosvgn8RpnR9pCNe6HxQgi5Ut4pkb9/wu0BqmMQ
         Q65QitGXUQj+PhWP0ybRlUaSo/PzROU/GnDZzTUaXPOzOl8d2RGKf1xqT24d4NwZXb9f
         DdAWmeeOfI4zIH8rMYwPvox0oU+vLpSk9LdpoPm0D/qrg/2nZsBcYQiridKErEIM0mem
         gNRQ==
X-Gm-Message-State: AOJu0Yyb237z6LFYCrNHcf543kAKip1svyB7bF1WUjLTDrVsfKjEG3K8
	0oxhvhdO4NEt1vApta+D+nBoBotoxvYqsbRrsmdXUI8IL3bi1KUc1o1bDHqT5VKD
X-Gm-Gg: ASbGncsZCNdjJMw9bqNCI57g0j6L8AFWBPZ53e3k8CbfBSdIy1l153gLAKBuSDhcBaB
	kjzIIUox1zFLeoNUOmBO87Ci3+GWXlFr/ZSAPDNxbZUsX6EWoYlA/5t7dfbH5mLV6CrXmenAO9A
	gBE1tRcHG7jpbuxvKcz5iFIlwqMfVRWez/0ki2fhd2tvklqbBaxkeDJmSTCh4DEIvSDFj/ScG1L
	/khRYo4Cm9xIixfGBeYbeXXjpShYWX4JwUNUouQrQu4/wBToObH7qsANPIZcEQPeWbeZUKaMlbg
	lWlkG60pplYBHNZlEEFgQcU8R7Reg4FZo6lPe5yaZst4mLwGNuZcwdWsJB6eiFZC5Oov++cLeu2
	OADFyMOECDkpmcMFuQMC8P4zb
X-Google-Smtp-Source: AGHT+IHUXLgfpcNEBxSYBPj7Ey3tVZd1sFRrhbNdGK5fOW+PNWxQGH3bClqwweTsNQhQ6+tLrvMgfQ==
X-Received: by 2002:a05:6214:5405:b0:6fb:16a:da41 with SMTP id 6a1803df08f44-6fd5ee80286mr51703746d6.0.1750866797178;
        Wed, 25 Jun 2025 08:53:17 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd32b18d3csm30688816d6.94.2025.06.25.08.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:53:16 -0700 (PDT)
Date: Wed, 25 Jun 2025 11:53:14 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH 0/2] bsp: rkbin: fix build
 issues around S and WORKDIR
Message-ID: <20250625155314.GA14662@localhost>
References: <20250625-s-unpackdir-v1-0-6f45466478d8@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625-s-unpackdir-v1-0-6f45466478d8@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Jun 2025 15:53:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1691

On Wed 2025-06-25 @ 02:07:12 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Since commit 46480a5e6674 ("insane/do_qa_unpack: add checks that ensure
> S is set correctly"), three recipes fail to build because they either:
> 
> - set S to WORKDIR/git which isn't allowed anymore for git-fetched
>   recipes,
> - have WORKDIR in S which isn't allowed anymore, UNPACKDIR should be
>   used instead,
> 
> This fixes the build issues seen on master.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (2):
>       bsp: rkbin: fix build since S = "${WORKDIR}/git" is implied by OE-Core
>       bsp: rkbin-native: fix build since ${WORKDIR} isn't allowed in S anymore
> 
>  recipes-bsp/rkbin/rk3308-rkbin_git.bb          | 2 --
>  recipes-bsp/rkbin/rockchip-rkbin-native_git.bb | 2 +-
>  recipes-bsp/rkbin/rockchip-rkbin.inc           | 2 --
>  3 files changed, 1 insertion(+), 5 deletions(-)
> ---
> base-commit: 961768ccd13630a4b98701f5821372a9ede86e85
> change-id: 20250625-s-unpackdir-8fee740998d0

Applied to meta-rockchip, master branch. Thanks!

