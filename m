Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5979E77183
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 03:54:46 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web10.49499.1734321283094183241
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Dec 2024 19:54:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MUUGFLtm;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a1ee7ff2so27876951cf.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Dec 2024 19:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734321281; x=1734926081; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JolqbguS30Afv2m/KoRqmG1ytGdWP0IF3sijWySbMtk=;
        b=MUUGFLtmO76X7lN0O2humQCHit08Oqp6L8HsORx3EevX1K5WH4mqmy8P3oOraztJ7W
         U0iGy0QzEP4ylUh9JfT/ARNPRau+idSobRbdHxjxc8JN+dLj4yE5/rLU+xOTCZwE75KU
         rYuLe8LOAyr3ix1agnpCnIUoaNVoSwGlNb0W5V068gTaGuHMj2pr3OZ5DqRBZNY6scpD
         7uREkGeXtfumVZ6pie7bpkPIdcO+0mF1tQ3M45rI6e0O0el1YDH1wHKKs4pfwVBsm6R3
         Y3IEfj1rDFBxdpFbYHfi9p4eTZ+3j+DTFn70CZUWtfzKRaB+EVUuro1hE4Jd56qrpPKE
         Du6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734321281; x=1734926081;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JolqbguS30Afv2m/KoRqmG1ytGdWP0IF3sijWySbMtk=;
        b=Z/0YRWLu3jNkIkkPGyEndFMhyzprA4Prc/UjJVNzgeYYj0DEn32jN4zHi3hvOsvlP2
         qmNLRvnqBjgqd5UrYLuqIKT3kHx0zOU9xElWLf6OaVSAU0EPJED6e/czXqNRmZXsQRxn
         mXTseOXu0fsDI1N8cDhnDURQclkCCtgl9ukIx2goQkAk3iOSoqdXXqaWIkAgKWdH9m2/
         ykXAg10o/Yq33q5jyNBU2g7tnAxZqH9B6wYqbIVzVOpzfyg9UDr1wK2XhLo+cpgx168b
         Fv/kHoiCKQ5iqSFpVx0OTOXemu+dAdbtpbBJW0THZxbJW2U4miZfj7D/RqEc9aP2DYL9
         yt/A==
X-Gm-Message-State: AOJu0Yyq78qZ7HSZEVMco7e/kv3qsFqpuNBONBkwnx9Eo5JPyrYvekAi
	Q+sYLkTrq+92paRUC6tz2o/FpniauEK3OY8752jOt+fXugkVJE6DIiRmbg==
X-Gm-Gg: ASbGncsrmBeCPlC2V5I/lachKkBuo3w5EzjcaK8JSAo3B/jcFKkPyo05cCi5gnNqwLC
	B9QtJeXKdjNqdzmPIYF9ULpqnlV3K/W5CsOn928WZ7eUCIdmdp0mq2Fb0Gr4NmtVA4QauJplGB1
	e4fWPBNXF59x6eK7Gdkuh5XpLWyUmixnzNAu7pAWM8RL6SDv5p8WmT5Jppr8DMZcMreh1AV+pjg
	keIMhCSdJ6p5b9i7y4B8QMNW404ZNqRgGJw9eJG7fwI/v+mKeApps49ltDKiktGZ7irof2ogClM
	qezhX+yy
X-Google-Smtp-Source: AGHT+IFKZnljgw5cPZX/CBTFUNBXFaGgbHSUhketvmR0TDywtyqFMPCcO7k9S47dJTSsam5aZ6f74w==
X-Received: by 2002:a05:622a:1444:b0:467:699e:2527 with SMTP id d75a77b69052e-467a57a8846mr172194951cf.25.1734321281516;
        Sun, 15 Dec 2024 19:54:41 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2cbe814sm23462971cf.43.2024.12.15.19.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:54:40 -0800 (PST)
Date: Sun, 15 Dec 2024 22:54:37 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2 2/2] bsp: rkbin: bump to
 latest commit in master branch
Message-ID: <20241216035437.GC466@localhost>
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
 <20241128-rkbin-bump-v2-2-a194385aad7a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128-rkbin-bump-v2-2-a194385aad7a@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Dec 2024 03:54:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/923

On Thu 2024-11-28 @ 04:58:50 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This seems to be fixing random RCU stalls, system hangs or resets while
> running upstream Linux kernel on RK3588 boards.
> 
> License-Update: Fixing typos c.f. 385bf9f1700c ("license: typo fix")
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb | 8 ++++----
>  recipes-bsp/rkbin/rockchip-rkbin.inc        | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Applied to meta-rockchip, master and styhead branches. Thanks!

