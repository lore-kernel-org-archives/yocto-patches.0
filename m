Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80470CA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 13:08:48 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.77028.1756818523714568577
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 06:08:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Yda/x00Q;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70df4418f98so45660236d6.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756818522; x=1757423322; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsl4RUxBpt/1z0sCVQO1i1MDExFTCCKMRtP4XR0q0cE=;
        b=Yda/x00Q7YeOYmgCpKgNnwB0EfhWU3KfVl4Uh7KEcoFc00M46cwIV0uLlsbQU+7rCC
         +j94b7TJlYkgfVwv6ydYgvnY7rVpSyZ9HZiAwvPrpSR6iJhNCm7Hh1msaU/BcLaIo3I9
         aHWSOtHtlx+vOATFG/uCdxIpyvOXX36YL+izANXTKP0ZV2ZdTPP3kxXEASxDfkr40uru
         QkOZkwwmWJPN5My+sRDICZaf1YZvQhne7OwlyR9qgSceydUUhOC+wm2BogLrCqU79oeb
         uSQhKgIEokyDIWE2QjZdQ3MLSYNwxwwbcGIbizIfE3t8FnVWf8OxjB2LMKjTkE6iVmey
         +6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818522; x=1757423322;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsl4RUxBpt/1z0sCVQO1i1MDExFTCCKMRtP4XR0q0cE=;
        b=oyghJqB3BalOhHR6uqT1WgFrY5b88515Bp7Hnhc8fcABJzXgm6lxbrrtaugl+c8UJn
         M8rVPovOMD8YiTgJwYBZqmMR5w138s4JhdkHUN4Mk/1NyWXmXbKDUt/orAj2odbW5fwg
         w2vV2S2ZLq/NBbkLUXhggxJvINzONR1zrdnmBiq9oJCPbdvSgyHPJNOYxzh/ITFRx9NF
         X60r65p9vIlhFeygbedaN+QVJCqJJByEN5pLYZNuEzrcnpLzE4mZ28hUcoZqYARiN7yC
         qcZNWRILKby0r6exDOjUtu2oPHJ1Ipk6i23gThbTYMYN+E6J9VmrLYAZeakLnpP21oc4
         tYqQ==
X-Gm-Message-State: AOJu0YxQ4OE80mnO7ZEW5UQZH8XaVy0CT7qPoTw+j6zLxaush1dSz3rB
	z2pUZO8mHeJIk7ClXyiZ1SceAmUhNjXLTTtHvTwT5vbcM5oB3ThjobbPTwPGvQ==
X-Gm-Gg: ASbGnctip9t8eYaM5Dhd+j1LazZj7k+hzrZWcFgcAl/weULVjqDiIwqtR/AWHtaMQD7
	Wmo2y9Cbsf5N4pb1rYIiNiC1bfn8yyJrIdfWo4QHWrMJ4gSNk9RLG4nCjFbX3TV9yOwgT3zh35Y
	lsSuXwYLMfAE1QaFZBnMuJZQA0gigy1Xif9jm1WwMgchDCQ7fueABQg2DWtuipFpOsoflofvXbC
	8XZdMSC5rlCWQCep4jPKLil3zsQAeXEpl44FPX0B0HSxjADDF1M9iBmFwSGDu+ePNcHz+2obKpI
	8Pqr10OGHZRf11CFJNAJgXTbUr9pGRyhWW9grAprsjYqcwu+1R83BHmk7rjSKs3M70M0WIgRUsv
	R0T7df4doQIlLa9Fu5ZChMf5cl4cV29KWGfBj7pxyrIj79Pw4ug==
X-Google-Smtp-Source: AGHT+IFQWpWoQAg+qMsmOcN9HuVDps0TtG6u15jnRO+MD0jihQqPwoFOvn8BNAUMfUVenyjutK0tzA==
X-Received: by 2002:ad4:5c8b:0:b0:70d:fec9:b5e0 with SMTP id 6a1803df08f44-70fa96cc470mr119684286d6.5.1756818521787;
        Tue, 02 Sep 2025 06:08:41 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b55cf6c9sm11409916d6.49.2025.09.02.06.08.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:08:41 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:08:39 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH] kernel overrides
Message-ID: <20250902130839.GA15419@localhost>
References: <20250902125435.28394-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902125435.28394-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 13:08:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2115

On Tue 2025-09-02 @ 08:54:35 AM, Trevor Woerner wrote:
> Add a :rockchip override to the kernel SRC_URI appends to play nicely when
> multiple BSP layers are used together in the same build.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  recipes-kernel/linux/linux-yocto-dev.bbappend | 2 +-
>  recipes-kernel/linux/linux-yocto_%.bbappend   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to meta-rockchip, master branch.

