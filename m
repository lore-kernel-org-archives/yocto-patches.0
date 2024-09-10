Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EA1EDE99A
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 16:09:17 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.191.1725984550783849121
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Sep 2024 09:09:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L43/BOqw;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99e8ad977so345394685a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Sep 2024 09:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725984549; x=1726589349; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CJlqHZtX4MsAgXBs6t5lNfjSFILUU4dEG3eMdkCXU8=;
        b=L43/BOqwRzkViVQhPgFUq2Ye0AIxF+/4YTDmp0EfLZHNF7VdcEYWGYYjeI9o5+055P
         9Jug/Ci4koqpbvGExrTnKXIeqnLV0WMQKvAMMds9/Yh0DNV1CGqZ/dT02JFrKNl7NeKP
         Wo7K2l0vZ87peBG2bp8pcTqx40KcDpe3rT1yPsIVF6gSHpMwtsC8hbO7f3rRKx2kL4CC
         /VCFHF/fwFyxUc5sCuEq5maXXgxLRzyXE/B+JXKU2knPiHunyFJ6RniUbUmxhzVU07Ko
         Wt6kMw2TV2cy6DxMUdEK6faD46/BLobjgURz062ujZXVsh1udoeWS5K2VqKH5XahMnnt
         Z7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984549; x=1726589349;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CJlqHZtX4MsAgXBs6t5lNfjSFILUU4dEG3eMdkCXU8=;
        b=gXmklC051H0KYOHDcgn6QdZACwS9dtBc2Gn+g51/fHpKmP8s5mQI/3EtoBanFqG8Cu
         J74kPCFHvAhdNKThzslVsvh6CpNbO0GP4vrBG5DJFfDtgLFSOCrE+qvpXsfcjAaJrnEB
         hxEKyO//ytVVQNlFPITUcySF95BQztcur5mw+ZLa57fp2l/1CWo6+8z4qRIG4J+vXdIz
         /66/FxwcnRA8cT6/38GU8+Hz5oheZ2zqh/xm0yt+se6G628GyRHnIXHAgUQ4JOqW+76o
         XBUtqWfl6AvvzKrAqLclfgxlO5vfjTDnfyZjTBZfIC4QQuf4+uH2W6dvePMmE1lHBiPN
         5Xdg==
X-Gm-Message-State: AOJu0YzE/k9uM8MwIwaLHhP/nsBl+0m13M3oD2sqMLGitS6F1lIAnnv+
	eK82SLN/DOX9yI0eAK5tQ2y2I5C3Ac8oW3Dk7uJONSYOe78iYkl2Ac28QA==
X-Google-Smtp-Source: AGHT+IEt/kIYpxcGF3q/G4Ep+IEJ0GCStLNT0WxaSWQkevYmpWBAk1ypPEP6E8oA+hyESIIUHdOH1Q==
X-Received: by 2002:a05:620a:2a0b:b0:79f:1cf:551e with SMTP id af79cd13be357-7a9a386ecfdmr1766166185a.5.1725984548550;
        Tue, 10 Sep 2024 09:09:08 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7968ed5sm319796585a.42.2024.09.10.09.09.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:09:07 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:09:05 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] remove upstreamed rk3328
 patch
Message-ID: <20240910160905.GA30814@localhost>
References: <17F3C85BF43F6ACB.32151@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17F3C85BF43F6ACB.32151@lists.yoctoproject.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Sep 2024 16:09:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/643

On Tue 2024-09-10 @ 12:42:47 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> oe-core recently bumped linux-yocto to v6.10.8 which already contains this
> patch to fix the pinctrl driver for the rk3328-based Rockchip SoCs (which
> enables SPI to work again).
> 
> oe-core: 48ac41fdc02c ("linux-yocto/6.10: update to v6.10.8")
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  ...-correct-RK3328-iomux-width-flag-for.patch | 51 -------------------
>  recipes-kernel/linux/linux-yocto_%.bbappend   |  1 -
>  2 files changed, 52 deletions(-)
>  delete mode 100644 recipes-kernel/linux/linux-yocto/rk3328/0001-pinctrl-rockchip-correct-RK3328-iomux-width-flag-for.patch

Applied to meta-rockchip, master branch.

