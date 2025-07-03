Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62121C83F03
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 19:34:08 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web11.31307.1751571243303619247
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Jul 2025 12:34:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=M38cDk04;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d5d1feca18so20590285a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 03 Jul 2025 12:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751571242; x=1752176042; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thY4rjaQwX19CkOnvZMAFBlb655b1TgT+odZOhHlqss=;
        b=M38cDk04dBPLTbLLrzgi0q0wPwL8EoQGajo4feXR3XYDgmG7SINkutF20O58ZUIsPo
         Ma7y6KO0Q4pnMnJ2Vh9Lg/8d01D1WOtzUxRPIfEnNudjJQ7UzlG1KEE8TFx43UQBEnH1
         vVbecQJZFm1zMCNx8pi3X5knQnxN5l0bUZQCGfOlenEFwU8D92oUrMckSOsLEBQWa5L/
         wPh6+5TGhpPF1Lga+zao04THoMNR9eSuenmeRdX0bzDjfaHaLWDVFzopN+y61Tq9mcyN
         IdIjPbDHEZ+MvIPhxWpa3D4QUYMgeIE+Wi3Xk+I5BbmUOHHQzOv9PyDMlzLGx2mLG6n0
         /ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751571242; x=1752176042;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thY4rjaQwX19CkOnvZMAFBlb655b1TgT+odZOhHlqss=;
        b=XQ3qXB47Dl8pkAcISc6qKISrloRkXJBSx4F8WOFjuZhZ/lopKl1Jw3wL/2M7K1FOer
         okI8aFjvr+hwL0+ujLvi5VcY7ndxjp5zYwIqXbI/RnR6uhu822ysluZwwJWcwIN0PWgU
         0LX7QW8s8Lufj8JAqiGX/k6CSFlSMS9ubuBj88TlDVwAhQwwlF2X9+RyhCCdDfYYqfQ+
         8qHQIDTXLFBEmJZaTxR276ueHneg3OS8aqzQLZALI6MPLl2atX5uhmvb1yL0++SDt4LH
         sgmT/2qZXnXMp6GOlwenPd0RM0M/M1YDOIENc8cl/ogTTXql70NZ3CfpS/PpRBMnwmSB
         2g0Q==
X-Gm-Message-State: AOJu0Yzlq7znnkXUFeX0Qny0VY0mpy5hI7OZjWalMAYxXRkrmint5rxQ
	cuak4XnwfDFkvjdaG3zm+TxgQl+5Hn1OZE3yrn2G5ZUleyZ+8OBC7N5j
X-Gm-Gg: ASbGncuuYVx9ULTOODg3wtYiRMSuplwVwdte8Y6zXDmm61Opm6IfQPXx7HfmfMnTx1i
	xPw8eupJISE6jNTz+zjx4aFtdMydQFcI4w0+jof9L87L81Z9gkIhB2TyROf66xbSKlER05yW5GB
	uM3CQS0E5YiNbUrcmNFIKkmX04lZDyrgHrDHak65DWa2bFLkMmA1y1zm/6TBnz41zRTBHvzcS9o
	4nzI3OqvQ5lVphNN8WVFm7Qm5gwputvsMqa0yI37GwquTkmZ7PejfQSfbJdF+I1WuBgNyuNoU9m
	AWJNZJ9bTYQg1j585ymV6F4LfNxw3rqtLAydegGQNbHcjWTpf5ghm6UCU32MgJ+CnldjIrCtvHj
	oBqh0OqjItjV5bg==
X-Google-Smtp-Source: AGHT+IH67rbjeqz5rn6hYqGO6I25CnTxi8TCseTJzUwDYby5Eez9RzbHTDYoIkPD6R/nneljjM6eOA==
X-Received: by 2002:a05:620a:170b:b0:7d4:3811:84b6 with SMTP id af79cd13be357-7d5dccf4a25mr24977085a.32.1751571242087;
        Thu, 03 Jul 2025 12:34:02 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeaf6dasm37284285a.104.2025.07.03.12.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 12:34:00 -0700 (PDT)
Date: Thu, 3 Jul 2025 15:33:59 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <foss+yocto@0leil.net>
Cc: yocto-patches@lists.yoctoproject.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [meta-rockchip PATCH v3 0/6] mesa: build fixes, refactoring and
 adding support for RK3588(s), RK3066, RK3188
Message-ID: <20250703193359.GA34355@localhost>
References: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627-mesa-panthor-v3-0-798c24a9eef3@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Jul 2025 19:34:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1748

On Fri 2025-06-27 @ 04:19:11 PM, Quentin Schulz wrote:
> This removes now unneeded kmsro PACKAGECONFIG as mesa dropped it (as
> well as OE-Core's recipe).
> 
> The Panfrost drivers currently do not compile anymore due to a missing
> libclc PACKAGECONFIG dependency so this adds the libclc to the
> Panfrost-supported SoCs.
> 
> This refactors a bit the bbappend to hopefully require a bit less
> maintenance with newer SoCs with most assumed to be supported by
> Panfrost mesa drivers.
> 
> This enables (untested) support for lima mesa driver on RK3066 and
> RK3188.
> 
> Finally, this enables Panthor support for RK3588(S).
> 
> Panthor is the open-source implementation for the Arm GPU Valhall series
> both in the Linux kernel and Mesa userspace. In the latter, the panfrost
> "driver" is actually handling this version of the Arm GPU. One therefore
> needs to enable panfrost in PACKAGECONFIG to be able to use this
> open-source implementation.
> 
> The open-source implementation still requires a proprietary blob which
> is running on the GPU: mali_csffw.bin. Note that the closed-source
> implementation (libmali and vendor kernel drivers) also requires this
> blob.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Changes in v3:
> - added now-required libclc dependency for panfrost,
> - added support for RK3066 and RK3188 (though untested)
> - refactored bbappend to default to panfrost unless specified otherwise,
> - Link to v2: https://lore.kernel.org/r/20250415-mesa-panthor-v2-0-a7850d0091fe@cherry.de
> 
> Changes in v2:
> - rebased on top of master with mesa 25.0 update merged
> - added patch 3 which removes kmsro from PACKAGECONFIG as it's now
>   unnecessary,
> - Link to v1: https://lore.kernel.org/r/20240531-mesa-panthor-v1-0-8cfb4d17ad3a@cherry.de
> 
> ---
> Quentin Schulz (6):
>       mesa: remove kmsro from PACKAGECONFIG
>       mesa: add libclc to PACKAGECONFIG for Panfrost-supported SoCs
>       mesa: enable lima for RK3066 boards
>       mesa: enable lima for RK3188 boards
>       mesa: rework bbappend to default to panfrost
>       mesa: add support for RK3588(S)
> 
>  recipes-graphics/mesa/mesa.bbappend | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> ---

For the series:
Reviewed-by: Trevor Woerner <twoerner@gmail.com>

Applied to meta-rockchip, master branch. Thanks!

