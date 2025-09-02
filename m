Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF42CA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 12:52:08 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web10.76642.1756817527191810752
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 05:52:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Csurem/k;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70ba7aa131fso59256626d6.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756817525; x=1757422325; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=um/hxVkAvBMFNCJpkBizuV3ylD5ICsOefH18HFqiNYs=;
        b=Csurem/kPpwDgXw0g5nt2Q2Ov246b8lBTjMSKd6J9Vh0H/wxwDTPFX3kOO8GXZxc9j
         3Hpp7IaKO4TR8bJLlB77dK+Nevjkq2JvZ1gAwJ90Bt/4aZZNgIpWITGXf3YFMRjJ+sit
         Rl+y1NObHa4IwWBlXOrEEORJIE+Yxq0UEfMtRAT28t6be2SAX2GXorvIh1OEVTuZqZeI
         JrxGuCamBiqINEpVOCClRiYewcMRlwNr+/dfTA1Yot1PTnzXyMHJHmNl42G1sG49rYTD
         /uzQJhqecmuq63mR0cciGyUddNTv9VYfjI+CcfCHFpIFGYErhIHL9F3GctbyHp6IZNBR
         q23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756817525; x=1757422325;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=um/hxVkAvBMFNCJpkBizuV3ylD5ICsOefH18HFqiNYs=;
        b=xFVYMPHlWrlZ5g5Z+1jn8cNVJn3Atrg5dnQ+/HFN4vmOBkIqhsf7YXUUwypHiPFE8o
         I8RRUYQ6BKTMPSNjjwTVlgoSmA1TYFDiFZ8evYGuZt+I5dvR2Xr445Kbpx1abHaRuMM5
         qEQd/8tw/02L8Ion+gtgzDYIeWLMkfkbAfbHdVur2twRAK1WCla90vS6XHaWUA54YUYZ
         62lgy+UPbmkiy3NwAXSGR50EfiWbQdRKBpmLBHLvYtI6QygugSGAznPnUM4miU+T6PIp
         3omK5dmj+VSFy1CdKboeN6xPQadV8978/BYZAlMX7nrlBi5Js3gNrCQao8nOZ08w/+oi
         p/Kg==
X-Gm-Message-State: AOJu0YxzYeuCcVSrUbRxrnyw8u4dx4Ep1wLXorR+Hsj052rrpaCS3PAD
	fMeHWxrzAoL1XJIp6N8YhsKv7nM6+KYs84lvpomufwT37zdfh68JD1DsaAkAEg==
X-Gm-Gg: ASbGncu237unToy0dEN4B3tfM4luHcdUyk1Pbpab9raHjEDYlcykaU6p+F6B7dZyKAY
	58CKO5M+AWQSpw91Zfq/Atl5y9PYlTpC5KlOJ2YUwEOyj2fv/C5049SZ642cdHeWHeR2JOxx7OO
	u5l3OTFEN2y+rq+cPQ/d8XIlpJepKfBKa6WvlrxOZq8uSIIgm9HUcgYfL8AGWqkUKlirRcMvs8G
	+HabXFm6bit44v2n9S3SO9tQrkCfOhk2mKzNiKNLigl87K2ISex6vG2SFf4nel5z7G+I7ryqIIz
	2wk+2gPDblbsyW4I0CqDGUl4F6l5TD9RFWfTnheVEubccUOBX4Saf+5PUFb8gtIhS3AFP/TS29t
	jHzd0Cxu4O/bkQNsHrgFBMWWzgnIW9Tg5LwD7GfnYlliGNtR4Qw==
X-Google-Smtp-Source: AGHT+IF4Yl5eHbT2HxReSbjVioWPQ5ZvkFnBZPBqtQdHk5pH9jA+hoAdGlwEdKCTSTJwOtK2pI13hw==
X-Received: by 2002:a05:6214:76b:b0:717:4378:b604 with SMTP id 6a1803df08f44-7174378d2c8mr99441436d6.58.1756817524973;
        Tue, 02 Sep 2025 05:52:04 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b46661f2sm11106876d6.42.2025.09.02.05.52.03
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:52:04 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:52:02 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH 2/4] radxa-zero-3: use non -dev kernel
Message-ID: <20250902125202.GC7287@localhost>
References: <20250831114105.27494-1-twoerner@gmail.com>
 <20250831114105.27494-2-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250831114105.27494-2-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 12:52:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2111

On Sun 2025-08-31 @ 07:41:03 AM, Trevor Woerner wrote:
> Now that 6.16.y is the preferred version of the linux-yocto kernel, the
> radxa-zero-3 machine that had been using the linux-yocto-dev kernel can be
> switched to using the linux-yocto kernel instead.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  conf/machine/include/radxa-zero-3.inc         | 1 -
>  recipes-kernel/linux/linux-yocto-dev.bbappend | 2 --
>  recipes-kernel/linux/linux-yocto_%.bbappend   | 1 +
>  3 files changed, 1 insertion(+), 3 deletions(-)

Added to meta-rockchip, master branch.

