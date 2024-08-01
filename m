Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B88C3DA4A
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 12:02:26 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web10.66410.1722513741983491189
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 Aug 2024 05:02:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dnOTujmc;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44ff6dd158cso42264091cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 Aug 2024 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722513740; x=1723118540; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEK1UW6T1nHc51IyXQ3YUK4M4MtxlC7++i/jBBTUBZI=;
        b=dnOTujmc9ZnsZtqqRR7desDbbFE80FiCpvViW4dzZ1qkjk6+mYJMRI5Ih83G2at2uL
         MLUAZJycyPPosHmGAIfQa7/gM40SZhczJGdlTtCsBplzj1xDJ21vSB4NJyDT3DtkL1sp
         6/Yd0pgEQtZtxyRgQk5UX9T5dspvZENPadUPZY+Csop04cAOCqVdxTFujYoTQdV4vEsW
         /aH0GXZg8ro33UmisV92ASwviml7kxv6wqs44wTCqGldnVqEzw5FCRIvy8izP4aq5yOn
         vjeS3wNdWqDRpoCXiomBwMA/kaoY07E9C3XTytKzAyBeqadLAhpQuWLKuhKN92rDU0WQ
         DsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722513740; x=1723118540;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEK1UW6T1nHc51IyXQ3YUK4M4MtxlC7++i/jBBTUBZI=;
        b=LsdQ0DUXbvdF0d2YxqWmsKntfbxXDnVUUmV3/EQ7p8WOIx7YORtFFzCIXLq6/zb3Us
         RJ4m6VKd7qXlBlq+g4+cR7CGLEyQr70GyjFjXsTo3zghe3bnTi9XTeG9P393J3K05+kJ
         1sRXxLwV/ETXRa7LlWmPJBmxoifEJnSxCqLFcVBNaPDpI3SbcOLgSyox7m/FrSVHLC5S
         hdaAEAwJWx6Ak+6KcR7ckdselvFKHbwqYsFBg+STDfOsTXkvmiT+/4rTX1RTyzwFvcF9
         tQH9e9NhQ+lRQWXS2Lurk80KB4z3FJzy7tF2Tzquynwwoxl+vNy9rRHULvypIJ6yC4qM
         uXvA==
X-Gm-Message-State: AOJu0YzlGxLBJm3azVNwKMuslwaBXeUHjb9B9JI/4E5AFIrnbAwrqTIx
	Sbr4BDDvVbMrOFxVFCXQ/Zs66OY8WQZkLz4P7NJXb3Ey70MiIwPqv3yxgQ==
X-Google-Smtp-Source: AGHT+IEB8Qw1EwCMIowdqOCfLNJv95kbL28tVGLtlDgvFQKIgRt9J0l2aRSIlHyehnP0qLDPgYeNlQ==
X-Received: by 2002:ac8:5dc8:0:b0:447:e61d:2895 with SMTP id d75a77b69052e-4514798089bmr31115591cf.20.1722513739970;
        Thu, 01 Aug 2024 05:02:19 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8413194sm68202011cf.86.2024.08.01.05.02.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:02:19 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:02:17 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-rockchip][PATCH v2] linux-torvalds-next: add rauc config
Message-ID: <20240801120217.GA6343@localhost>
References: <20240801030506.8626-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801030506.8626-1-twoerner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 Aug 2024 12:02:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/507

On Wed 2024-07-31 @ 11:05:06 PM, Trevor Woerner wrote:
> The kernel needs a couple configuration tweaks in order to work with RAUC, and
> the default upstream kernel recipes already have this built-in due to
> meta-rauc. The non-upstream, one-off kernel required to support the Radxa Zero
> 3{e|w} boards (linux-torvalds-next) needs a similar tweak.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v2 changes:
> - use a different, more efficient, way to do the same thing without having to
>   repeat (and keep in sync) the cfg itself
> ---
>  .../recipes-kernel/linux/linux-torvalds-next_%.bbappend          | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 dynamic-layers/rk-rauc-demo/recipes-kernel/linux/linux-torvalds-next_%.bbappend

Applied to meta-rockchip, master branch, using "require" instead of "include".
Thanks!

