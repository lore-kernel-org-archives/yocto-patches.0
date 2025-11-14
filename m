Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F31CE8D4E
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 16:00:55 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1724.1763136048294562032
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 08:00:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bnAecwm4;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-882451b353fso13853856d6.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 08:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763136047; x=1763740847; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTGWnrSLBWsLzEvinwe96zAk5RJrtuxLM5WKoKMvG20=;
        b=bnAecwm4Lym8fFH8rQOrU9/BbSbQqyF2mhPPWJi0iKIQT+XnnaZohRPWi1jGvSR2Fe
         GnxCPoTTTm5dLF9/E1agy8hBzxFAMEjSIE6aaC31r4FMrNxbWessbUc8ox6A+CdK/d8D
         IEB6YPR2PZJn89KFtvVqkta34Zhcg1R7DEkBDJZQNxPURAQp5ryIL+VzKgIZO1BQx2Ek
         +Lz2x2WtRJUi2R4D+kWfrJ4Y5wKUMrRRtjKcdv90HOJz4WjzyKnNNJBnJPYruPFOuFwU
         Uey7DrClWEm7u12byY44/0pw/FuB6v5KuW9pt6UFEN/77YwqFdiMl3IHSHHawDkD8UJI
         yiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763136047; x=1763740847;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dTGWnrSLBWsLzEvinwe96zAk5RJrtuxLM5WKoKMvG20=;
        b=pmWgTHbXWUXR7jouR2TMPWUwmhwyzx7Qi7mP0F9DlcHLoOuD6TLa2OvIcoM4WibJUm
         KSvwtQ//zAt+3FnOVUQOL2E7lrU/XaaSX0De2q2xd3F3nNMogrKvW/6BEXogAtk6bQlj
         IbppKS8bOGnUXP52HAYoHFwwROG/m9N4RlgBVoJi9XNyvIOgf1Zx5kkjurkp7bM8R9PY
         DNO8riQgNf06+POGYWEe2vFpXNIEdbP1rPcm7G96WRWR7syoNdEaLoZ0TKbAeE9b3Bvc
         XJmXKFp/f355CfXQw1h5gUGyH/PUwHa4q0FwcEUstCcyf/o5fSoKKWcoHr1ykJ/ckrBX
         28Lw==
X-Gm-Message-State: AOJu0Yyfc3Hh2sS+wVUJkyfJYUxOzTZV2k3TYZGpNJmZ3l0Qm9L4+91L
	442TJ+Wi7J9LxFZxxT5lNBjfxkycwj5zdjTnHpyqGdZHpzZltTjh+42N
X-Gm-Gg: ASbGncvG16KDHI5XMjSV2nGyZoJKymq3OFO7ca93Brx+Vl+zOtJzhPlYbtyWllE5kfM
	hujFG7myAZgW6+D/7qxwx69um7MokxBJeKrL8VqMUOIVHLIFEdX6NKY7JBVGyDT7wsgImmySYq5
	gT2JnePpmxgkm2qeAASTabwX8j9afD3niyPWKlOROk1vQ/oNcpc0KIlI/QVYJULXPfgLxyAuf0K
	UFSzLyUkZZEYLTNM2A8cpwBXQ+Qfzz+r9zK60jIeRqjqVD6B8AvTqQznOX1r2EHf+GfQfdx8soZ
	g2xbfWLAUJS7VZTsMt7AeuC5PD5OzdwpSAm4Mp5W9lnniazhLsNXZsV6dqXu6L6PcgOMOz0mWpa
	/1tI22kjUsYLT4KiqHC3XhQ21dzXRlGmQnYErqBKojrjaHUBh1wboI/eIDeY7Ua0MOlRXHtHIAg
	8HebN1oFuwsqZIukU2p8zwrNajigI=
X-Google-Smtp-Source: AGHT+IEAJP3171fPJhbHqqbOVmxzQUR9rb6a2pb8jIf5/wwLHJhfHZ/PcjdcZ/oe+MJK/M+FC8bp/w==
X-Received: by 2002:ad4:5ecf:0:b0:87c:22e8:6f1a with SMTP id 6a1803df08f44-882925a3d1fmr46162106d6.5.1763136046920;
        Fri, 14 Nov 2025 08:00:46 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828630e991sm34076366d6.15.2025.11.14.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:00:46 -0800 (PST)
Date: Fri, 14 Nov 2025 11:00:42 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Peter Shkenev <mustela@erminea.space>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip] [PATCH v3] rk3288: use u-boot.img as bootloader
 image
Message-ID: <20251114160042.GA14886@localhost>
References: <20251108225641.171832-1-mustela@erminea.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251108225641.171832-1-mustela@erminea.space>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 16:00:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2570

On Sun 2025-11-09 @ 01:56:41 AM, Peter Shkenev wrote:
> Currently, u-boot.bin is used for supported rk3288-based boards. But on
> some boards, such as tinker-board, it can not be loaded, since
> u-boot.bin is raw and those boards have raw image support
> (CONFIG_SPL_RAW_IMAGE_SUPPORT) disabled in favour of FIT images.
> 
> Use u-boot.img which is FIT when FIT support is enabled, and raw
> otherwise.
> 
> Also add a note that u-boot.itb should be used if one wantes to utilize
> OP-TEE.
> 
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Signed-off-by: Peter Shkenev <mustela@erminea.space>
> ---
>  conf/machine/include/rk3288.inc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to meta-rockchip, master branch.
Thanks!

