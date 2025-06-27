Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E41CC7EE31
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 14:57:18 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.15866.1751036230825009760
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 07:57:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GijrTJsv;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fad8b4c927so21047986d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751036229; x=1751641029; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HghWn2FMA2lG8ksWL0EoVnocAeOfcw11U7efL4mplU=;
        b=GijrTJsvLvxBQ2JX8XS07l0v0ygZ7FBNx8QXnL+DMAIBb54UxpChoK19VvDzliuB39
         4h2HMDJODXVE6/RIX9ncukssUL8HE+QUwLDoWnJCkmcZNtj1EgJfRPm6oMi0gWx68Hr8
         YJlPy1Sp2+YAog8DvEU26ynn3JioU6TnZeGkmWXA9GnHe9YCMe0xZfc0Cc2MxK88twpm
         Qde+wmwquX7vpRe64NbA3JD5+wZ5thstF5lUDR8bK4urASuC5CSr9uM2yvbZF4CiO/61
         d6PP57Eh0hLF4NBDTYiVjkHKw5yyzwUgtu7Y0HP65UX3gLLJK4JNsQM8xwPV8NJBg8N6
         LWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036229; x=1751641029;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HghWn2FMA2lG8ksWL0EoVnocAeOfcw11U7efL4mplU=;
        b=OQzfmyqsduXZGnANODwq7+NLyngsQw4cdujeUxmIgsrHIRdNLkmX7tVHB4PbepxJum
         vw2YYbEST+7UmiwJtXhl28j71PeHZys6i1IIebJj5T+hrcjQBEpGUNOTxPF2c5SvcfXw
         OhpQW14d3qxYbMrL8pLnaagqHaEYALxkmWSUkX+/m5j8rxtA0q9FR47+3wR/laQT8hz/
         DJ3lDYX19SyTcNWjfTaVtF25E7membhanf4kxSfYFVEFUwZbGMFiJ9qqOlUOxjAjqRVK
         /CaB3sBvDm+qnH41FPAPPVYs/cDpbiy1kMmxtq27Xpk1YUHL1p/jLEhsNhQr63cWusZk
         k8fQ==
X-Gm-Message-State: AOJu0YyJ9OVG8mEZoL/VBRuam6yKfkOGhQgxn7N93jh9eoV4MmRbzlND
	MI3TXJ//zZ43HPbJsnclywOrgM000/WbCBYxzQNVxQehyme1OlLhKXCRpEVwQ8v3
X-Gm-Gg: ASbGncsuMcvIvASni0AqtJxFpweq96HUmORG3Um6lZzvAJ/a/Q/7nbx6dtcfyuVbLxK
	LDn2Sf0AV+jAZkW2/hIIsjlf5e04yb7P66LW+Vty53J2cvsE7ABpfPFGBRZqsQUxeqqaLPfsZhV
	n6XQ7YCoayEJdxvjxxLKlLVeJGg02x7rltquEeq91WXuJ4pV0kjQrxngsiwaz6FO7wtKGrZ3BWe
	ckEOCopiem7mWhAk1eaEV3cc7Vd4O+Gr7a9j/xcOawCWWoAwu1p9b4P0GI2LAJxw0Q1unT9XHSd
	wuSOQBq/SJGeAmE3NRJwvpO/NjdLR09tg1TCyk2Up+zt92b5ij/VbffsgD7kZcA/n0PIywULhid
	B/kZCsGNoEBaiVQ==
X-Google-Smtp-Source: AGHT+IGOfcm1IbInyLhebdl/+1uQ6VaqxOXi1mSKgoMz8o9iyNHb2itoPiU4uGC+1CmMiybo0sOcAQ==
X-Received: by 2002:ad4:5b85:0:b0:6fa:c512:c401 with SMTP id 6a1803df08f44-70012fcf43bmr65659746d6.37.1751036229089;
        Fri, 27 Jun 2025 07:57:09 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718d327sm21725166d6.22.2025.06.27.07.57.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:57:08 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:57:06 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v4] fitimage rework
Message-ID: <20250627145706.GA35399@localhost>
References: <20250626031810.35828-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250626031810.35828-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 14:57:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1719

On Wed 2025-06-25 @ 11:18:10 PM, Trevor Woerner wrote:
> oe-core has completely re-written the fitImage support starting roughly at
> commit [1], update meta-rockchip to match.
> 
> Most of the MACHINEs in meta-rockchip use a fitImage for the kernel, but
> some don't. Create a boolean variable (RK_KERNEL_FITIMAGE), enabled by
> default, to keep track of which ones do and which ones don't. Use this
> variable to decide how to configure various image-related fields.
> 
> Build tested with all meta-rockchip MACHINEs both with and without RAUC.
> 
> Run tested on the following with RAUC configured:
> 	- nanopi-m4b
> 	- nanopi-r2s
> 	- radxa-zero-3e
> 	- rock-pi-4b
> 	- rock-pi-e
> 	- rock-pi-s
> 
> Run tested on the following without RAUC:
> 	- radxa-zero-3e
> 	- rock-pi-e
> 	- rock-pi-s
> 
> [1] oe-core: 3442d9297dca ("oe-selftest: fitimage: test external dtb")
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes in v4:
> - rename the variable to RK_KERNEL_FITIMAGE
> - update the README, variable name, and comments to emphasize the fitImage
>   is kernel-related (and does not pertain to other fit-able components)
> - use ?= so the RK_KERNEL_FITIMAGE value can be changed by the user
> - the location of the RK_KERNEL_FITIMAGE variable is not arbitrary (as
>   it may be for other variables) add a comment to this effect
> - re-organize the fit and non-fit values to do away with adding two new
>   files (rockchip-fitimage.inc and rockchip-unfitimage.inc) so as to add
>   only one (rockchip-fitimage.inc); set all non-fit values as defaults
>   to be over-ridden in the rockchip-fitimage.inc file as required
> 
> changes in v3:
> - remove the 2nd MACHINE_ESSENTIAL_EXTRA_RDEPENDS from the
>   rockchip-extlinux.inc file and place the relevant portions into either
>   the rockchip-fitimage.inc or rockchip-unfitimage.inc files as
>   appropriate
> 
> changes in v2:
> - remove the ",False" from the bb.utils.to_boolean() calls
> - add information on new param (RK_FITIMAGE) to README
> - re-structure the fitimage require so it is less invasive in
>   MACHINE.conf files
> ---
>  README                                     | 10 ++++++++++
>  conf/machine/include/px30.inc              |  2 --
>  conf/machine/include/rk3066.inc            |  2 +-
>  conf/machine/include/rk3188.inc            |  2 +-
>  conf/machine/include/rk3288.inc            |  2 +-
>  conf/machine/include/rk3308.inc            |  2 --
>  conf/machine/include/rk3328.inc            |  2 --
>  conf/machine/include/rk3399.inc            |  2 --
>  conf/machine/include/rk3566.inc            |  2 --
>  conf/machine/include/rk3568.inc            |  2 --
>  conf/machine/include/rk3588s.inc           |  2 --
>  conf/machine/include/rockchip-defaults.inc |  7 +++++++
>  conf/machine/include/rockchip-extlinux.inc |  7 +++----
>  conf/machine/include/rockchip-fitimage.inc |  5 +++++
>  14 files changed, 28 insertions(+), 21 deletions(-)
>  create mode 100644 conf/machine/include/rockchip-fitimage.inc

Applied (with some tweaks discussed on IRC) to meta-rockchip, master branch.
Thanks for the review!

