Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01D8CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 20:41:52 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21310.1792356105036136275
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 13:41:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=d5fPzqTI;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91beb36fcc6so8591206d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1792356104; x=1792960904; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzXHpDrQIVim2eNl6///aBqsXC34SGhuEzAMcwIHHcI=;
        b=d5fPzqTIR4bGsQK8zdiYDBfBMBSHeqGUbmGe6a+IsOpvqta0SGVCnQSdAmZLfQssaS
         zhI0+YJ8RwwoxDyPW0Z+yxMkW8BncEundw49MYVcr+2jRJh2grvunymk4ubtTL9iSNDV
         lg/+z0j7wR937R1aKRGBUfeLvlxWF2VqaxEb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792356104; x=1792960904;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzXHpDrQIVim2eNl6///aBqsXC34SGhuEzAMcwIHHcI=;
        b=pw+Z9DBs0dJhMjDqgx7VWIQQd/HVUvHCvO/AEAmzz+YLBNygbN6mAXXx528TS51j7d
         OagpVb0Rx8563TRypb1SJKTAcVdYkcLGPl+Zr8j0OGHRUNCMiCNRSFb8edzJn79OW6Cc
         V1J+Lk2O64V4eED6TJ/KpZrJYsuf6+bYJVhMOqmgMKli0/JemIiVZDzD2UcWU11QVufX
         XwCaYrF2oArINDYwuHGp5ak7rcwHajkn31DlU19aOAfxE6+0VEnTfHASIfPW+55fpICc
         ZxHItYioZxtM0uqcZU1WBh2+XKnpSQqWjH8f3qVA9QeBo3c2QctHTd+Skzg6sC286npa
         8iBw==
X-Gm-Message-State: AFq9FYIJ7k4w3MakYi5k/veKiJKy7PFiyQ7Eq4hEm7Fm5dBSBFTEeKA2
	VxlOl826JvEyvv4JB6lRe/m7Ambg9sgRDRi7IMlX9g7WicF7e6B8JLk5ZWW2u4WK/t6B3k1vyrK
	taCoZ
X-Gm-Gg: AYBFou3ylgfHbJ3Gy6aidOO35P8q5YTRJrSAeVolILMEy8zW12npkZxasWpW2aGc1jp
	v9a3BoDw8FIZinyiu1TSjtMGhDHSqH5oHEGRkZIJ5Ze2iMoMcXqXy+VxVfKI/DA+RrB68B5nhpC
	8I8HSYmy/K3QOPs3nw0usWlRPFVLLhsRV0drImD8UJlXn98SqEZjNvbgmyh/wlMbq4TwjKCms9Y
	0dGPmNAFx1g/PbKi4SC1mzSHRsFmjE94pXuYQhrNnA/Gem4B0M+mmJHys6hZ+ktz21kRtECmV1T
	6bF5ObMHyxPJ0NnZ0PMUz0T9U64PF8IdJgLA4F0kZJnnX8rZdVcpRoQMaHv9hcaJeT61I+n06un
	/1/+xL6lwVrW+qcMD8ktM5G3L0+YQW+FFNsbM/bvsF53r0qKtFIXDKF3VxW/cJCMliUdkLvQkLI
	hh4yjQEXJP30wDjGln7X0Y+mArpOwREgRyjhpEUySOog6DamqLKXqAPIFLJtKUxbhvlpzTgJxon
	3+lzVqi7aGcUWvnhEmpx3bEmShn5nvrjw3xN9LrQlXp/ChInqdqn//P7TELV2FTve9eUDH68AnR
	jP9Z1pFGAz/54T+xVw==
X-Received: by 2002:a05:6214:262d:b0:91b:88fe:a426 with SMTP id 6a1803df08f44-91bde902c63mr108815336d6.0.1792356103734;
        Sun, 18 Oct 2026 13:41:43 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8c4adasm79872016d6.1.2026.10.18.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:41:43 -0700 (PDT)
Date: Sun, 18 Oct 2026 16:41:42 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
cc: ehsan@emami.net
Subject: Re: [yocto-patches] [meta-security][PATCH] swtpm: inherit useradd
In-Reply-To: <002EC865-B05F-4FC8-BFED-3D541947DE27@emami.net>
Message-ID: <2d3f3a35-b0a5-3bcb-11da-316804786f18@konsulko.com>
References: <1C882C13-9FFC-4A2A-9F90-8708E040FA19@e2technologies.com> <002EC865-B05F-4FC8-BFED-3D541947DE27@emami.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 20:41:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5070

On Tue, 6 Oct 2026, e2.65 via lists.yoctoproject.org wrote:

> Hello meta-security maintainers,
>
> This is a one-line fix for the swtpm recipe in meta-tpm.
>
> Problem. The swtpm recipe declares the user and group it needs (USERADD_PACKAGES, USERADD_PARAM, GROUPADD_PARAM), but it never inherits the useradd class. Without that class, BitBake ignores those variables. The swtpm user and the tss group are therefore never created on the target. Any service that starts swtpm with --runas swtpm (or with User=swtpm in a systemd unit) fails at startup.
>
> How we found it. We build a Yocto image against meta-security commit 2703974d (swtpm 0.10.0). The swtpm account is missing from /etc/passwd on the target. It appears as soon as a bbappend adds inherit useradd. The recipe on master (6824bd7) has the same problem.
>
> Fix. Add useradd to the recipe's inherit line.

I was about to include this in a set of updates for master branch, but
realized it does not have a Signed-off-by line.  Please either reply with
what you'd like to use as one, or post a v2 of the patch with it.

Thanks,

Scott


> ---
>  meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
> index 8472f02..8488d01 100644
> --- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
> +++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
> @@ -12,7 +12,7 @@ SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=h
>  PE = "2"
>
>  PARALLEL_MAKE = ""
> -inherit autotools pkgconfig perlnative
> +inherit autotools pkgconfig perlnative useradd
>
>  TSS_USER = "tss"
>  TSS_GROUP = "tss"
> --
> 2.43.0
>
> Thank you for reviewing it.
>
> Ehsan Emami
> E2 Technologies
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4993): https://lists.yoctoproject.org/g/yocto-patches/message/4993
> Mute This Topic: https://lists.yoctoproject.org/mt/121612547/2167468
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170805/2167468/856840347/xyzzy [scott.murray@konsulko.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
>

