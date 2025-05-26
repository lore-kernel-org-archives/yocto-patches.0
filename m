Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A24C5AD49
	for <webhook@archiver.kernel.org>; Mon, 26 May 2025 16:22:23 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.32221.1748276538038163997
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 May 2025 09:22:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ngl+CZwU;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6faa10ee879so20702926d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 May 2025 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748276536; x=1748881336; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPhQKkwfG07GphJOyzmu/OHo46WTmk5gI8nixj2pzW8=;
        b=Ngl+CZwUGZD27h5170mBrHXdPfYv7jBbS7HdSUgjorz/19u1Cn9UpO+wpWcR4KZL3i
         v9sAEPb2oYuTQhEqE6NE4vr1LoqMoE64s/Z6oFFkmzUSPQ1Wv6FFGFf5GOAAmTHnBpFm
         o/Wq58XeiX6UfFvvnO+LjZbGVeixDI5xRYYa1h5gRNpfHGm7WYWcY+S+0lexda9BOF43
         coBV6FBwdA69+vZvM6ECSrjlGINuDARDoEhiwMP6c5NxoIXd/aWLHgv/0ERg6NO6l92+
         XwWLEXq79za7giGnv4Z49O+u4t+ITGfEFrjzHBGlmVX3jVxgX61K2dOpPpLo6pkuACBS
         Q+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748276536; x=1748881336;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPhQKkwfG07GphJOyzmu/OHo46WTmk5gI8nixj2pzW8=;
        b=ZeUupbQw0qe1vMjiphqo7O+iXZDSfhGZ0GrVXYa/ALz5NVhvU+HFOwZVaAG6Km5Qg/
         UFnDHS4pOqT34fey3y5FRks3yvivsBT4NInXdi7Dr4s5ed0wHR/Z+7yvk5fVAqo/0mtR
         FF/aXjMQjvg15sLjrl7kZo6IBf77fkTKLFOTrZ1UsYUmRN/o+n0PgyPbwPa6AhSkfl1J
         tY/toiGN8a8aU/L/AFxh1paGT4z9vKJ7kwO0x/RivKTy6fX50i5kafzykHyQuFZ4Lnqd
         fA5YLAq65Dw2dPBJA1V13oYd5S9XuHzaYM7VNNrufCAewPQkwcvoGuc1qPPD4ZJp0n2c
         +wOQ==
X-Gm-Message-State: AOJu0YzqOZm0DxKq/0TitVBjcveeqn+ssFaT1ngZGAPezwkKuVg5x9tY
	S0DCblxOB6IDNGg5Q/nIt5CRB6DPCTGImXOrcEL09hQ2ji9BqYqEbxb+JENZLg==
X-Gm-Gg: ASbGncvFSiUW6OfJdGmUMmiD5N+5wFPlw8KsfK9EUBivdlqG74TT1kIlHmCmYSR5aSO
	LxpZM44Pt2a+Tf3/B5XPD1V4UsnQqMnLK1sp0bq5sZrDePmY/ilJ2X9hH2iWU33LTvSC69bSVJq
	F2mXv6zWk6gdIGAsl8vqYa4+4deX4iQL0T/uyyh6S8NQpx1fqubeh2oatPldjSEZ7nGt+XUMF16
	l5Eg9bJmpStj8RZB8+fn6PpgwX8iITuftyjP0kDbkU8jmH1KTfePplRqHy9SM/V/XAtdowvWjpH
	iwS9yv+/HE8dskDx78JkPXI10Kra6Of9D1MROe4e8r1Hgeb6kGKZN4NWDYzfMlwew84WtWTb9SQ
	nFgA=
X-Google-Smtp-Source: AGHT+IGWymP1q45vpJvFP8RyAn1mXiDScYQCyn20fkUF1XZ2DOelxkiBtvzoqwIeKsqr95duJM0Uiw==
X-Received: by 2002:a05:6214:5095:b0:6e6:5e15:d94f with SMTP id 6a1803df08f44-6fa9d2ac714mr176139846d6.27.1748276535817;
        Mon, 26 May 2025 09:22:15 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fa9e750cfbsm35315376d6.109.2025.05.26.09.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 09:22:15 -0700 (PDT)
Date: Mon, 26 May 2025 12:22:13 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH v3 0/9] rkbin: factoring
 do_deploy, customize ddrbin and bump rkbin
Message-ID: <20250526162213.GA35361@localhost>
References: <20250505-ddrbin-custom-v3-0-577b94c72035@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250505-ddrbin-custom-v3-0-577b94c72035@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 May 2025 16:22:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1579

On Mon 2025-05-05 @ 04:20:36 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> This simplifies rockchip-rkbin-ddr, rockchip-rkbin-tf-a and
> rockchip-rkbin-optee-os do_deploy to only have one do_deploy task common
> to all supported SoC instead of having to add a new task override for
> each new SoC. It does require to set a few more variables though.
> Thanks to the variable abstraction, we can now move all of do_deploy
> into the rockchip-rkbin.inc file.
> 
> The downside is that the version for OPTEE-OS and TF-A are now hardcoded
> in recipes, so a bump of rkbin requires to bump those as well.
> 
> Additionally, this finally allows to customize the DDR binary blob using
> Rockchip's ddrbin_tool.py tool. This is typically useful if your board
> isn't following Rockchip's HW reference design, e.g. using a different
> UART controller or pins for serial output, or using a baudrate different
> from the default of 1500000.
> 
> Finally it bumps OP-TEE OS, TF-A and DDR bin recipes to use the latest
> commit in rkbin git repo.
> 
> I am not too fond of using a file as input for the customization, but
> this is what ddrbin_tool.py uses and there are possibly too many
> corner-cases to handle by using fine-grained variables. So for now, I
> decided to go with that but that is for sure not the only possible
> implementation!
> 
> Note that the bump commit wasn't tested.
> 
> Note that I plan on backporting all but the factoring out and rkbin
> bump patches to scarthgap (and I assume styhead too). The factoring out
> patches would break backward compatibility if someone appends to the
> do_deploy:<override> task. The last patch could be merged but there's no
> absolute need for it?
> 
> Lastly, the patch about customizing DDR bin needs to be modified before
> being backported as it uses UNPACKDIR which doesn't exist in scarthgap.
> The logic should be safe to use with ${S} (for scarthgap) though!
> 
> @Trevor, maybe you can check if that would fix your issue with the
> RK3308 DDR blob you wanted to keep on that outdated version which is one
> of the last versions where the UART you want to use exists? It'd be nice
> to get rid of the rk3308-specific recipes I believe :)
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Changes in v3:
> - fixed tee- prefix instead of bl31- in rockchip-ddrbin-tf-a recipe,
> - build tested with bitbake virtual/bootloader,
> - Link to v2: https://lore.kernel.org/r/20250418-ddrbin-custom-v2-0-700828527faf@cherry.de
> 
> Changes in v2:
> - factored out rockchip-rkbin-optee-os and rockchip-rkbin-tf-a as well,
> - moved do_deploy (and RKBIN_BINDIR) to rockchip-rkbin.inc,
> - removed bbfatal for the version variable as it's not used directly,
>   only through another variable, which can be overwritten, so it doesn't
>   make sense to enforce it if it's not necessarily used,
> - renamed variables to be recipe-agnostic (e.g. RKBIN_ instead of
>   DDRBIN_ for the prefix) so they can be used from the .inc in the
>   do_deploy task,
> - renamed ddrbin_params.txt into ddrbin_param.txt to match the original
>   filename in rkbin git repo,
> - Link to v1: https://lore.kernel.org/r/20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de
> 
> ---
> Quentin Schulz (9):
>       bsp: rkbin: ddr: store directory path for the DDR bin blob in a variable
>       bsp: rkbin: ddr: make deployed name configurable
>       bsp: rkbin: add native recipe for tools (ddrbin_tool.py)
>       bsp: rkbin: ddr: allow to customize DDR bin blob
>       bsp: rkbin: ddr: factor out do_deploy to be SoC-agnostic
>       bsp: rkbin: optee-os: factor out do_deploy to be SoC-agnostic
>       bsp: rkbin: tf-a: factor out do_deploy to be SoC-agnostic
>       bsp: rkbin: factor out do_deploy and RKBIN_BINDIR variable
>       bsp: rkbin: bump to latest commit in master branch
> 
>  README                                           | 20 +++++-
>  recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb      | 83 ++++++++++++++++--------
>  recipes-bsp/rkbin/rockchip-rkbin-native_git.bb   | 21 ++++++
>  recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb | 29 ++++-----
>  recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb     | 29 ++++-----
>  recipes-bsp/rkbin/rockchip-rkbin.inc             | 21 +++++-
>  6 files changed, 141 insertions(+), 62 deletions(-)
> ---
> base-commit: 0aba79e47951b049bcdd39e07f660c665e257393
> change-id: 20250311-ddrbin-custom-f83918406e3a

Applied to meta-rockchip, master branch. Thanks!

