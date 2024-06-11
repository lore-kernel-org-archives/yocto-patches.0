Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B27C25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 13:29:57 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.web10.9641.1718112588516998667
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 06:29:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EJ9TSTIm;
 spf=pass (domain: gmail.com, ip: 209.85.128.169, mailfrom: twoerner@gmail.com)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62a08b250a2so52778077b3.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718112587; x=1718717387; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXxY1x4vcERWys7QKI1hTrtfLT58w7dXCiSV8CtF2Wo=;
        b=EJ9TSTImqi3DsFZepjW9UNcUpGVr7cu7AlzJMmb5I7R1GRUbCR6Ztdf7L3CtQZYPnp
         QHO/puxTi6QDThdhyLSKH+WFMgAB3PsUMua7ipaY/IDyp/34ygE6VtZdT88+ob9OTR/z
         cVW5pIQ8Smc6h7zf8LFDQbMhe63rmrsnl6bizjvN6DAp4Z3P6/RQGAv7VflcQlXAdZan
         SsyM6HYBgl66IbWa8I6ZKtGG4i9jR0zqig3jnVwiXsJrgza16NNPa1CnZPhHxbrnPQ8w
         8YZF00x8uRNCStbDVTlHJ05VkrTz9DmXvDQJMzfoIxMMr5Qe8oVl5dhwb3jv9QzFBEgG
         7xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718112587; x=1718717387;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXxY1x4vcERWys7QKI1hTrtfLT58w7dXCiSV8CtF2Wo=;
        b=inYDA+6k+vB28U1xr7oKk7dSHExbA2riv3zMtEyKU7J/sTTANT966DXiEF/vqFhp9u
         rSYlcZMQITtXqQqI0u9e3WxWk4MxsUwByn+yIeKxJUUSLaeqgf/YucYpZCWU1fN6SKRq
         pwGQu8Jqa74qDA6ALKS2py+RLAWjFtBDCjrGZjH8J2PU0sB5XhEa9mMCvfUiQjV6kISP
         YGSsJMO7aWVvB+9c7Pb4qb0xYlragwPz69kqmr0xZeirTU2x4f0Rs245YP7GqH7j3Mr/
         L3gXA9DATRjLvmHrKfykkoqr+5GZV9ooTPmP5LMxdIPU3SFrHTphsp90BlzpIdary43i
         BxTA==
X-Gm-Message-State: AOJu0YzjN5enme+W9k0AFV9Z3XavYDIDqLb3YUdGEkn/V+z5zMLStq2s
	Wj5wKd2eeDeXIv/38ebj6PtsViLyCv3kIFvzQ2nQQMgyS7X4vtY/qEYOQw==
X-Google-Smtp-Source: AGHT+IEU6EWYEE+dP/Ai0tWjEbZTGEH8ygBSmA2tCbegDI4q1J8WhpPmsOayYxWXlGUF77+GXgZjPw==
X-Received: by 2002:a0d:f906:0:b0:61b:1c6f:830e with SMTP id 00721157ae682-62cd5667c86mr112039147b3.43.1718112587007;
        Tue, 11 Jun 2024 06:29:47 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0634147b9sm42711566d6.145.2024.06.11.06.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 06:29:46 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:29:44 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [PATCH meta-rockchip 0/2] enable Panfrost on
 RK3328 and RK3568
Message-ID: <20240611132944.GA39107@localhost>
References: <20240531-mesa-panfrost-v1-0-84e23ae9a600@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531-mesa-panfrost-v1-0-84e23ae9a600@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 13:29:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/294

On Fri 2024-05-31 @ 02:48:13 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Note: I do not have access to any RK3328 or RK3568 device so I could
> not test those patches.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (2):
>       mesa: enable lima on all rk3328 boards
>       mesa: build panfrost for RK3568 boards
> 
>  recipes-graphics/mesa/mesa_%.bbappend | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> ---
> base-commit: 3381d6af6eabfb532da16863b785a95abba6b9e8
> change-id: 20240531-mesa-panfrost-f975f1251b6c

I have a couple rk3328-based boards, but the rock64 is the only one of these
that has a video output device (hdmi). So I guess if someone really wants to
build a graphics-based image for an rk3328-based board that doesn't have a
video dongle, then I guess they would want panfrost too (?)

It's been a long time since I've done any graphics stuff, I have a rock-3a
that is rk3568-based but couldn't get x11 nor weston/wayland working. I
probably need to do more fiddling.

Neither of these patches interfere with the build so I'm okay adding them.
Would you also want them on scarthgap as well?

