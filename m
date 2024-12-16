Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C790FE77180
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 03:53:56 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web10.49487.1734321233615989359
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 19:53:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Qa7Ylp41;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467918c360aso45447461cf.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 19:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734321232; x=1734926032; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1OSWNKHissKNBuiPH6UqyQ1X86p3JjmJLhqf4yjtHg=;
        b=Qa7Ylp41DwrXjeECr5J95cMu5jp4ftie6Vl8GsQxgFnFaOpkUnOPUKRhrl88BO1d89
         hYKGkDE3zY3gRubznu+S0Sj9IdulJwbtb+zWHoVSAU96QLlje1BuHyRfLslaOSpZ/YTT
         GIojofMsrbmV5XhLSY5T7PtinHxSOaJppZ+iH7kgvpR1oSbm5k/nbtwqCFquZueHxJZw
         vDmn5cg1mO4hdbT80YbSRpILOrYPvnAaedayHCIzgIiOffq5GYFMaOwCDa/5EC3WrMUx
         KJrHw3vlOrmyGEfHK554ImOKo4pYbqPx7ZO8xaHN6agRIVNSLtlVrP4POXUu6T1tFG4U
         R/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734321232; x=1734926032;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1OSWNKHissKNBuiPH6UqyQ1X86p3JjmJLhqf4yjtHg=;
        b=llQU6rBgV/jwrU+ZqJ7leuAv0wreP0R/oSwkStEv5FMe2I35rFV+ikW5muKoRWDl88
         2LapxWyRjJKvYYE8NUhvfdlhjHWszrb00G3bE20eBIysq/NWJUCdUO/LldMDMkCG0qsj
         EYIdzBR7M1ryaazkEc9sliocSzS4cvNg1RYDaeFQj7I0nbfo359DZ4w1XFhlX/ZKgaRT
         BgNKBD0GMhm0GYeWeAEpQ0uu4piTx38KX5UOeYy5N2MRUZGxHqbHKoJo92OwLSmsbVTk
         KJlhggZ4cZ8UEU8feDgBAglGcauMPeEE191IybxvqcVu6sU/NLFj5+XDp1mVFZTChCut
         9ihg==
X-Gm-Message-State: AOJu0YwPfJR4RW6g3UJeVe+kxyWZx2hvyDkauBHpTwLhtlnHtfbHE34y
	Qmvf7+BlaE13wsB3tRtlZRnG54s1BiY+01wePVaLVoaPnKdzpGDS2/SL0Q==
X-Gm-Gg: ASbGnctueUBTu06BriJ+yipkoEu/2u/r7+BdWWLeZOzXNmtSu9Pi2sgMkhuzveR28IH
	+pRvZT8RRef3nze7Ojky6XdWhcuVr+H8zvkM+FI8IZUu/r2PM2hV3Y0zgy+EoXtYzC8Wh5N/EZA
	5s8eiCvF7o2oAxPuE+deyZGX9p865/8QGUSt2lz3G7L+86eAT57rlA+4h42QSBMNYte6sTMsqBB
	ki51BjpUXwuKcvj1TaUIRpAbxDpWK4qYuUN+7skD+UwfkF4CVdx6OPBk8yL06NqD5rknastlUWe
	rP+cqy4+
X-Google-Smtp-Source: AGHT+IEneSz7EWZV2vhPOkt3Yjn4ORnCCigwRiQusagFJZ9cemqvDdap1ljSXkikdlu/dv22je8h+g==
X-Received: by 2002:a05:622a:4d95:b0:460:aa51:840a with SMTP id d75a77b69052e-467a58448damr223278521cf.45.1734321232076;
        Sun, 15 Dec 2024 19:53:52 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2ca29d4sm23387821cf.30.2024.12.15.19.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:53:50 -0800 (PST)
Date: Sun, 15 Dec 2024 22:53:47 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2 1/2] bsp: rkbin:
 rkbin-ddr: use version and file variables for path matching
Message-ID: <20241216035347.GB466@localhost>
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
 <20241128-rkbin-bump-v2-1-a194385aad7a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128-rkbin-bump-v2-1-a194385aad7a@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Dec 2024 03:53:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/922

On Thu 2024-11-28 @ 04:58:49 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> By using variables to give the path where to find the file to install,
> it is easier for users to have a different SRCREV for their own machine.
> 
> Additionally, because glob patterns are now not used by default, it is
> guaranteed only to match a single file.
> 
> The glob pattern for rk3308 has been hardcoded with the only file that
> matches in the rkbin git repository at the currently used commit.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  README                                      | 15 +++++++++++++++
>  recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 20 ++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)

Applied to meta-rockchip, master and styhead branches. Thanks!

