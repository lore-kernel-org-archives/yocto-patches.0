Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32411CD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 12:54:25 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44672.1781182464158884967
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Jun 2026 05:54:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=APTjjmnK;
 spf=pass (domain: gmail.com, ip: 209.85.222.175, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91563abd6a9so384001585a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781182463; x=1781787263; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5dcUqbZ5pCGHhs6bAbZwNuKcJlJD2T8Ic4VpgMdENU=;
        b=APTjjmnK8681eomimu50zu0GZTnGwCDEBwfXsr0quLxAyc/0eMrkrZw5+KRZCkdN/u
         8mecoYHA2Bu5XYn4/ydsQbnQkaUv7hbRmDKLWAI1klG8z6vIX1kQFchfSWPQkTWDgP3H
         SnV/JjVcl5X1kyutgNZjYK9w7ERY6i8KQU8/84TYhEzOl2Stoy/+3rtkE/Jx4ta2JUdO
         GAEZfXNTvqMTPnF6J7pElVbiV5r8/JS9cuTZSw8l72xELBTDAmIGTuIX9ALFq7woZzQT
         M4YAWc5iGC9IxI+JZ378GLxeN68oU0lYT/BbSiOBwskhaMi9V5eilHjFTAqA2vXDNk41
         UF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781182463; x=1781787263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5dcUqbZ5pCGHhs6bAbZwNuKcJlJD2T8Ic4VpgMdENU=;
        b=XCHM0+lXMTu5zCo134UA506nokdgsfvDCjiYxl2ITPhQxfpEo7MqA8aHFir4lS577R
         zbQg7ksgX/RnIMO6e/BBJylt4IMNFVASHj/pTpQxpOu7CNU5s4bxK7S9Ca+EDVfwye51
         d+s9TZ43+iaBgA84W2sZUK5X7j4UFJl2EzCtIgAcvmAgztzHodp9YyAyYfP2VHjFIZj5
         epboC0vJK04OWQVtbTnpyDyyxSQQqZL/8RtF1JE3g6bsL8BslGPMdLBvSerUnubcKld8
         DPgM80Cg57d5v/7MDOD4UxVRpj+TIjCQ3/pJz2ThBQOVybz1pR/CR2lIDPbQtmAIow02
         rKVw==
X-Gm-Message-State: AOJu0YxAtuEGXmifJqcxK/jZVMmEUNkV9dQEWpRVhuvs29AbUgNqdax7
	0BTo+x5cnnj4bdbU0l372iwdwTHFMjgV8YKwgW2ZoJsop4BhSdbZ9hUi
X-Gm-Gg: Acq92OFKVmPGKva6zOl2Nq42Y45IloSqCfyctdaUmtGR2/i4aj34uM7laPCf21Lefs8
	IMYEs5pLFZuGruRuxGAu4loLounkvUR2cr2e8TypcoSYdTF6Nb0nTx29aSop5yZYhIxeGsMZelB
	1cSb735kmlNpuYqwCh93897WX1ppshs4oq59FPgLAYsNqd+Wmrl1a2hV6E20UcrPwrf02jXZDig
	i0MDt9IjdccL7h1+aIbK1ZaStJsenfsvyn2eazkEeVRVLRFbAJ+P7qUSOvJbwodgO00nAkxhKOe
	5UeWlVSeF2tAIvlUeJauHSRhrFdk+XxCBeGzsv3ksDBUNoy4oqYZFpWuzq99Bf1ZxWAu6X8pvkY
	J3oylDxPgl/W2aWSSvcAINk/SYtVFbJJRLgWGiH1T7HXa73ArXKDiYYGoiLBP+z0VfjjuG1qlnQ
	w6U0DsXS3gSMfuLqRPas+ic3kyjNeejub562vj98ZmLCstQ0QoYt4UlUGK/VfSJO9J1mXSX129e
	EGA
X-Received: by 2002:a05:620a:444d:b0:90e:2f56:2f0b with SMTP id af79cd13be357-9160aafc48bmr412454585a.7.1781182462954;
        Thu, 11 Jun 2026 05:54:22 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160adf699esm183832085a.29.2026.06.11.05.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 05:54:22 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:54:20 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <foss+yocto@0leil.net>
Cc: yocto-patches@lists.yoctoproject.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH wic 2/2] README.md: add Trevor (the maintainer)'s mail as
 Cc recipients
Message-ID: <aiqv_K-RMwc103f9@localhost.localdomain>
References: <20260608-to-cc-v1-0-a1e3e7462875@cherry.de>
 <20260608-to-cc-v1-2-a1e3e7462875@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608-to-cc-v1-2-a1e3e7462875@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 12:54:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4212

On Mon 2026-06-08 @ 12:47:59 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The instructions now match with the .b4-config file.
> 
> Suggested-by: Trevor Woerner <twoerner@gmail.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  README.md | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied to wic, master branch (given the previous caveats). Thanks!

